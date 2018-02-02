public class CampaignProcess_AddMember implements Database.Batchable<sObject>,Database.Stateful
{
    public final String query;
    public Id campaignId;
    public set<Decimal> camplistOrderId;
    public string emailAddress;
    public boolean isSegmentedCampaign=false;
    public CampaignProcess_AddMember(Id campId, Decimal listOrderId)
    {
        campaignId = campId;
        camplistOrderId = new set<Decimal>{listOrderId};
        emailAddress = UserInfo.getUserEmail();
        query ='select id,Response_Schema__c,Failed_Contact_Id__c,Request_Schema__c,Campaign_Member_Status__c,Campaign__c from Transaction__c where Campaign__c=:campaignId AND WM_List_Order_Id__c IN:camplistOrderId AND Campaign_Member_Status__c=\'Ready to Process\' AND Type__c=\'GetOrderData\'';
    }
    public CampaignProcess_AddMember(Id campId,boolean isSegmented)
    {
        campaignId = campId;
        camplistOrderId = new set<Decimal>();
        emailAddress = UserInfo.getUserEmail();
        isSegmentedCampaign = isSegmented;
        for(Campaign cmp : [select id,List_Order_Id__c,(select id,List_Order_Id__c from CRM_SegmentedParentCampaigns__r) from Campaign where id=:campId]){
        	for(Campaign ccmp : cmp.CRM_SegmentedParentCampaigns__r){
        		if(ccmp.List_Order_Id__c!=null)
        			camplistOrderId.add(ccmp.List_Order_Id__c);
        	}
        }
        query ='select id,Response_Schema__c,Failed_Contact_Id__c,Request_Schema__c,Campaign_Member_Status__c,Campaign__c from Transaction__c where Campaign__r.CRM_ParentSegmentedCampaign__c=:campaignId AND ((WM_List_Order_Id__c IN:camplistOrderId AND Campaign_Member_Status__c=\'Ready to Process\' AND Type__c=\'GetOrderData\') OR (Transaction_Source__c = \'Audience Upload\'))';
    }
    
    public CampaignProcess_AddMember(Id campId, Integer isUpload)
    {
        campaignId = campId;
        emailAddress = UserInfo.getUserEmail();
        query = 'select id,Response_Schema__c,Failed_Contact_Id__c,Request_Schema__c,Campaign_Member_Status__c,Campaign__c from Transaction__c where Campaign__c=:campaignId AND Transaction_Source__c = \'Audience Upload\'';
    }
    
    public Database.QueryLocator start(Database.BatchableContext BC)
    {
        System.debug(query);
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC,List<sObject> transactions)
    {
        Transaction__c trans;
        try
        {
            for(Sobject t: transactions)
            { 
                trans = (Transaction__c)t;
                Set<string> wmContactIds = new set<string>();
                if(string.isBlank(trans.Failed_Contact_Id__c))
                    wmContactIds.addAll(trans.Response_Schema__c.split(','));
                else
                    wmContactIds.addAll(trans.Failed_Contact_Id__c.split(','));
                //trans.Missed_Profile_Count__c= CampaignMemberManager.addContactsToCampaigns(wmContactIds, campaignId,trans);
                CampaignMemberManager.addContactsToCampaigns(wmContactIds, campaignId,trans);
                trans.Campaign_Member_Status__c = 'Added Members';
                update trans;
            }
       }
       catch(Exception ex)
       {
             update trans;
            //transactionIds.add(trans.Id);
            //Tenet_Exception_Handler logError = new Tenet_Exception_Handler();
            //logError.creatExceptionLog(ex,null,'CampaignProcess_AddMember');
       }    
    }
   
    public void finish(Database.BatchableContext BC)
    {
        try
        {
   			if(isSegmentedCampaign){
  				integer i = [select Count() from Transaction__c where Campaign__r.CRM_ParentSegmentedCampaign__c=:campaignId AND WM_List_Order_Id__c IN:camplistOrderId AND Campaign_Member_Status__c='Ready to Process' AND Type__c='GetOrderData'];
  				Campaign camp = new Campaign(Id=campaignId);
  				if(i>0){
  					camp.CRM_ActivateProcessId__c=Database.executeBatch(new CampaignProcess_AddMember(campaignId,true),1);
	            /*else
  					camp.CRM_ActivateProcessId__c=Database.executeBatch(new Campaign_AddCampaignMemberFromAU(campaignId,true),2000);
	            */
  				FlexQueue.moveJobToFront(camp.CRM_ActivateProcessId__c);
  				update camp;
  				//This else condition is in Campaign_AddCampaignMemberFromAU, remove this condition when you uncomment the above else condition for PP1
  				}else{
  					list<Campaign> cmpList = new list<Campaign>(); 
  					for(Campaign cmp : [select Id, Name, List_Order_Id__c,Suppression_Count__c,System_Control_Group_Count__c, of_CampaignMembers__c,Add_Member_Status__c,Control_Group_Count__c,Control_Group_Percentage__c,Control_Group_Size__c, Current_count__c, Missing_Contact_Count__c,(select id from CRM_SegmentedParentCampaigns__r) from Campaign where Id=:campaignId]){
  						
  						CampaignMemberManager.confirmControlGroupCount(cmp);
  						
  						cmp.Add_Member_Status__c = 'Added Members';
		                cmp.Status = 'Active';
		                cmp.IsActive = true;
		                cmpList.add(cmp);
		                for(Campaign cm : cmp.CRM_SegmentedParentCampaigns__r){
		                	cm.Add_Member_Status__c = 'Added Members';
			                cm.Status = 'Segment Activated';
			                cm.IsActive = true;
			                cmpList.add(cm);
		                }
  					}
  					
	                update cmpList;
	                
	                id jobId=Database.executeBatch(new CampaignProcess_ContactSyncToMarketo(campaignId), Integer.valueOf(Tenet_Static_Variables.tenetDataConfigSetting.get(Tenet_Static_Variables.Query_API_Page_Size).Static_Value__c));
            		FlexQueue.moveJobToFront(jobId);
  				}	
  			}else
  				campaignHandler();
        }
        catch(Exception ex)
        {
             Tenet_Exception_Handler logError = new Tenet_Exception_Handler();
             logError.creatExceptionLog(ex,null,'CampaignProcess_AddMember:Final');
        }
    }
    void campaignHandler(){
    	//Check if the camp added all the members
        // Campaign camp = [SELECT Id,System_Control_Group_Count__c, Name, List_Order_Id__c, of_CampaignMembers__c, Current_count__c, Missing_Contact_Count__c FROM Campaign WHERE Id=:campaignId];
        // Staring of defect 810
        Campaign camp = [SELECT Id, Name, List_Order_Id__c,Suppression_Count__c,System_Control_Group_Count__c, of_CampaignMembers__c,Add_Member_Status__c,Control_Group_Count__c,Control_Group_Percentage__c,Control_Group_Size__c, Current_count__c, Missing_Contact_Count__c FROM Campaign WHERE Id=:campaignId]; 
        // Ending of defect 810
        if(camp.Missing_Contact_Count__c == null) camp.Missing_Contact_Count__c = 0;
        system.debug('&&&&count'+camp);
        decimal countDiff = camp.Current_Count__c - (camp.of_CampaignMembers__c + camp.Missing_Contact_Count__c);
        system.debug('^^^^^count'+countDiff);
        //If all campaign members got added succesfully, then 
        if(countDiff == 0){
            
            //Recheck if Control Group is added properly in case Control Group Size is defined
            //if(camp.Control_Group_Size__c!=null){
                //if(camp.Control_Group_Size__c != camp.Control_Group_Count__c)
                    CampaignMemberManager.confirmControlGroupCount(camp);
            //}
              
            //Update the campaign as Active
            if(camp.Add_Member_Status__c !='Invalid Control Group Count'){
                camp.Add_Member_Status__c = 'Added Members';
                camp.Status = 'Active';
                camp.IsActive = true;
            }
            update camp;
             //Start the batch process for setting the Sync to marketo flag on the related contacts
            // starting of defect CRM-72 795 , only 5 campaigns can be activated
            id jobId=Database.executeBatch(new CampaignProcess_ContactSyncToMarketo(camp.Id), Integer.valueOf(Tenet_Static_Variables.tenetDataConfigSetting.get(Tenet_Static_Variables.Query_API_Page_Size).Static_Value__c));
            FlexQueue.moveJobToFront(jobId);
           // Ending of defect CRM-72 795 
            //If send email on activation success is enabled, then send an email to the campaignowner
            if(Tenet_Static_Variables.manageCampaignActivation.get(Tenet_Static_Variables.campaignFaliureEmail).Activate_Process__c)
            {
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(new String[] {emailAddress});
                mail.setSubject('Campaign ' + camp.Name +' has been activated succesfully.');
                mail.setPlainTextBody('Campaign ' + camp.Name +' has been activated succesfully.');
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });  
            }
        }
        //else if all campaign members were not added successfully, then 
        else{
            // Starting of defect CRM-72 795, only 5 campaigns can be activated
            //If auto-retry proccess is enabled, then restart the batch process to retry adding the pending members
            if(Tenet_Static_Variables.manageCampaignActivation.get(Tenet_Static_Variables.reProcessCampaignMembers).Activate_Process__c){
                camp.CRM_ActivateProcessId__c=Database.executeBatch(new CampaignProcess_AddMember(camp.Id, camp.List_Order_Id__c),1);
                FlexQueue.moveJobToFront(camp.CRM_ActivateProcessId__c);
            
             update camp;
              // ending of defect CRM-72 795  
              //else if auto-retry proccess is not enabled, then don't activate the campaign so that user can manually try it 
             }else{
                
                camp.Add_Member_Status__c = 'Added Members';
                update camp;
                
                //If send email on activation failure is enabled, then send an email to the campaignowner
                if(Tenet_Static_Variables.manageCampaignActivation.get(Tenet_Static_Variables.campaignSuccessEmail).Activate_Process__c)
                {
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    mail.setToAddresses(new String[] {emailAddress});
                    mail.setSubject('Campaign ' + camp.Name +' had a problem in activating.');
                    mail.setPlainTextBody('There was a problem in completing the Campaign Activation as '+countDiff+' campaign members were not added to the campaign \''+camp.Name+'\'. Please click the \'Activate Campaign\' button on the Campaign Activation screen to resolve this problem.');
                    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });  
                }
            }
        }	
    }
}
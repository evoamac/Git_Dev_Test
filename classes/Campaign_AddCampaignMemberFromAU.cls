//This class will be used to create campaign member in case member type is Upload List
public class Campaign_AddCampaignMemberFromAU implements Database.Batchable<sObject>,Database.Stateful{
    public final String query;
    public Id campaignId;
    public string emailAddress;
    public boolean isSegmentedCampaign=false;
    public Campaign_AddCampaignMemberFromAU(Id campId){
        campaignId = campId;
        emailAddress = UserInfo.getUserEmail();
        query ='select Id,CRM_WundermanId__c from CRM_AudienceUpload__c where CRM_AudienceUploadJunction__r.CRM_Campaign__c=:campaignId AND CRM_AudienceUploadJunction__r.CRM_ToDelete__c=false AND CRM_IsProcessed__c=false';
        //query ='select id,Response_Schema__c,Campaign__c from Transaction__c where Campaign__c  =campaignId AND Transaction_Source__c = \'Audience Upload\'';
    }
    public Campaign_AddCampaignMemberFromAU(Id campId,boolean isSegmented){
        campaignId = campId;
        isSegmentedCampaign = true;
        emailAddress = UserInfo.getUserEmail();
        query ='select Id,CRM_WundermanId__c from CRM_AudienceUpload__c where CRM_AudienceUploadJunction__r.CRM_Campaign__r.CRM_ParentSegmentedCampaign__c=:campaignId AND CRM_AudienceUploadJunction__r.CRM_ToDelete__c=false AND CRM_IsProcessed__c=false';
    }
    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC,List<sObject> uploadRec){
        
        
        set<string> wundermanIDs = new set<string>();
        //Transaction__c auRec;
        CRM_AudienceUpload__c auRec;
        map<string,Id> WMIdauIdMap = new map<string,Id>();
        try{
            for(Sobject t: uploadRec){ 
               // auRec = (Transaction__c)t;
                 auRec = (CRM_AudienceUpload__c)t;
               // wundermanIDs.addAll(auRec.Response_Schema__c.split(','));
               /* for(String wid :wundermanIDs){
                WMIdauIdMap.put(wid,auRec.Id);
                }*/
                WMIdauIdMap.put(auRec.CRM_WundermanId__c,auRec.Id);
            }
            
           // CampaignMemberManager.addAudienceUploadAsCampaignMember(WMIdauIdMap, campaignId);
            
       }catch(Exception ex){
             //transactionIds.add(trans.Id);
            //Tenet_Exception_Handler logError = new Tenet_Exception_Handler();
            //logError.creatExceptionLog(ex,null,'CampaignProcess_AddMember');
       }    
    }
   
    public void finish(Database.BatchableContext BC){
        try{
  			if(isSegmentedCampaign){
  				integer i = [select count() from CRM_AudienceUpload__c where CRM_AudienceUploadJunction__r.CRM_Campaign__r.CRM_ParentSegmentedCampaign__c=:campaignId AND CRM_AudienceUploadJunction__r.CRM_ToDelete__c=false AND CRM_IsProcessed__c=false];
  				if(i>0){
  					Campaign camp = new Campaign(Id=campaignId);
  					camp.CRM_ActivateProcessId__c=Database.executeBatch(new Campaign_AddCampaignMemberFromAU(campaignId,true),2000);
	                FlexQueue.moveJobToFront(camp.CRM_ActivateProcessId__c);
	            
	             	update camp;
	             	//check if we want to call confirmControlGroupCount mehtod
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
        catch(Exception ex){
             Tenet_Exception_Handler logError = new Tenet_Exception_Handler();
             logError.creatExceptionLog(ex,null,'CampaignProcess_AddMember:Final');
        }
    }
    
    void campaignHandler(){
    	Campaign camp = [SELECT Id, Name, List_Order_Id__c,Suppression_Count__c,System_Control_Group_Count__c, of_CampaignMembers__c,Add_Member_Status__c,Control_Group_Count__c,Control_Group_Percentage__c,Control_Group_Size__c, Current_count__c, Missing_Contact_Count__c FROM Campaign WHERE Id=:campaignId]; 
        if(camp.Missing_Contact_Count__c == null) camp.Missing_Contact_Count__c = 0;
  
        decimal countDiff = camp.Current_Count__c - (camp.of_CampaignMembers__c + camp.Missing_Contact_Count__c);
        if(countDiff == 0){
            
            CampaignMemberManager.confirmControlGroupCount(camp);
            
            //Update the campaign as Active
            if(camp.Add_Member_Status__c !='Invalid Control Group Count'){
                camp.Add_Member_Status__c = 'Added Members';
                camp.Status = 'Active';
                camp.IsActive = true;
            }
            
            update camp;
            
            id jobId=Database.executeBatch(new CampaignProcess_ContactSyncToMarketo(camp.Id), 2000);
            FlexQueue.moveJobToFront(jobId);
           
            if(Tenet_Static_Variables.manageCampaignActivation.get(Tenet_Static_Variables.campaignFaliureEmail).Activate_Process__c){
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(new String[] {emailAddress});
                mail.setSubject('Campaign ' + camp.Name +' has been activated succesfully.');
                mail.setPlainTextBody('Campaign ' + camp.Name +' has been activated succesfully.');
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });  
            }
        }
        //else if all campaign members were not added successfully, then 
        else{
            //If auto-retry proccess is enabled, then restart the batch process to retry adding the pending members
            if(Tenet_Static_Variables.manageCampaignActivation.get(Tenet_Static_Variables.reProcessCampaignMembers).Activate_Process__c){
                camp.CRM_ActivateProcessId__c=Database.executeBatch(new Campaign_AddCampaignMemberFromAU(camp.Id),2000);
                FlexQueue.moveJobToFront(camp.CRM_ActivateProcessId__c);
            
             	update camp;
             	//else if auto-retry proccess is not enabled, then don't activate the campaign so that user can manually try it 
            }else{
                camp.Add_Member_Status__c = 'Added Members';
                update camp;
                
                //If send email on activation failure is enabled, then send an email to the campaignowner
                if(Tenet_Static_Variables.manageCampaignActivation.get(Tenet_Static_Variables.campaignSuccessEmail).Activate_Process__c){
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
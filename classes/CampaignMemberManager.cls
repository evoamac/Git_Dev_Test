public class CampaignMemberManager
{
    public boolean confirmOrderPlace{get;set;}
    public static list<Transaction__c> transactionList = new list<Transaction__c>();
    public static integer soqlContactCount;
    public static integer pageSize;
    public CampaignMemberManager(){}
    public CampaignMemberManager(ApexPages.StandardController acon) { confirmOrderPlace=false;}

    public static void getNetCount(Id campaignId)
    {
        try
        {
            Campaign campaign = 
            [
                SELECT 
                    id,
                    Current_count__c, 
                    List_Order_Id__c, 
                    Control_Group_Size__c, 
                    Control_Group_Percentage__c, 
                    campaign.Channel__c, 
                    campaign.Ignore_Minor_Suppression__c, 
                    campaign.Ignore_Bad_Debt_Suppression__c,
                    Add_Member_Status__c
                FROM 
                    Campaign 
                WHERE 
                    Id=:campaignId
            ];
            
            string orderResponse = WundermanAPIConnector.getListOrderStatus(string.valueOf(campaign.List_Order_Id__c));
            Set<string> values=new set<string>();
            values.addAll(WundermanAPIConnector.getValuesFromXmlResponse(orderResponse));
            //if order status is deliverd then refresh count
            DateTime dt;
            if(values.contains(Tenet_Static_Variables.Order_Delivery_Status))
            {
                system.debug('pageCount^^^^'+campaign.Current_count__c);
                //system.debug('pageCount^^^^'+campaign.Current_count__c);
                Double pageCount = Double.valueOf(campaign.Current_count__c)/Double.valueOf(Tenet_Static_Variables.tenetDataConfigSetting.get(Tenet_Static_Variables.Query_API_Page_Size).Static_Value__c);
                system.debug('pageCount^^^^'+pageCount);
                if(pageCount>integer.valueof(pageCount))
                    pageCount +=1;
            
                system.debug('Audience Count: ' + campaign.Current_Count__c + ', Page Count: ' + pageCount + 'campaignId: '+ campaign.id);
                campaign.CG_Count__c = 0;
                campaign.Supp_Count__c = 0;
                dt = DateTime.Now();
                for(integer pageNumber=1; pageNumber<=integer.valueOf(pageCount); pageNumber++)
                {
                    string lstWMContactIds = WundermanAPIConnector.getOrderData(string.valueOf(campaign.List_Order_Id__c), pageNumber);
                    Set<string> setWMContactIds = new Set<string>();
                    setWMContactIds.addAll(lstWMContactIds.split(','));
                    
                    Integer rowLimit = Limits.getLimitQueryRows()-Limits.getQueryRows();
                    if(rowLimit!=0 && setWMContactIds.size()<rowLimit){
                        rowLimit = setWMContactIds.size();
                        campaign.Supp_Count__c += getSuppressCount(setWMContactIds,campaign,rowLimit);
                    }else
                        throw new CampaignMemberManagerException('Invalid Suppression Count');
                        
                    /*if(Limits.getQueryRows()< (Limits.getLimitQueryRows()-setWMContactIds.size()))
                        campaign.Supp_Count__c += getSuppressCount(setWMContactIds,campaign,rowLimit);
                    else
                        throw new CampaignMemberManagerException('Invalid Suppression Count');
                    */
                    
                    system.debug('****=campaign.Supp_Count__c'+campaign.Supp_Count__c);
                }
                
                insert new Track_History__c(campaign__c=campaign.Id,OldValue__c='Track System Slowness',NewValue__c='Track System Slowness',User__c = UserInfo.getName(),Date__c = dt,FieldHistory__c='Track System Slowness');
                
                system.debug('****=campaign.Supp_Count__c'+campaign.Supp_Count__c);
                system.debug('****=campaign.Current_Count__c'+campaign.Current_Count__c);
                system.debug('****=integer.valueOf(campaign.Control_Group_Percentage__c)'+integer.valueOf(campaign.Control_Group_Percentage__c));
                
                //Calculate Control Group Count
                getCGCount(campaign);
                      
                system.debug('Supression Count:' + campaign.Supp_Count__c + ', Control Group Count:' + campaign.CG_Count__c);
                for(Transaction__c tran : WundermanAPIConnector.transactions)
                {
                    //system.debug(tran.Type__c+'*****'+tran.Request_Schema__c.indexOf('GetOrderData')+'******tran.Request_Schema__c='+tran.Request_Schema__c);
                    if(tran.Type__c.equalsIgnoreCase('GetOrderData')){
                        tran.Campaign__c = campaignId;
                        tran.Campaign_Member_Status__c='Ready to Process';
                        tran.WM_List_Order_Id__c = campaign.List_Order_Id__c;
                        //tran.Type__c='GetOrderData';
                    }
                }
                
                //Changes for PP1 Start
                campaign.Add_Member_Status__c='Adding Audience Report';
                //Changes for PP1 End
                
                update campaign;
            }
            WundermanAPIConnector.logTransactions();
        }
        catch(Exception ex)
        {
             Tenet_Exception_Handler logError = new Tenet_Exception_Handler();
             logError.creatExceptionLog(ex,null,'CampaignProcess_GetNetCount_CampaignMemberManager');
             if(ex.getMessage()=='Invalid Suppression Count')
                 update new Campaign(id=campaignId,Add_Member_Status__c='Invalid Suppression Count');
            
        }
    }
  
    
    public static void addContactsToCampaigns(Set<string> lstWMContactIds, Id campaignId,Transaction__c trans)
    {
        // Starting of new Suppression Logic Implementation 
        Campaign campaign = [SELECT Id,List_Order_Id__c,Supp_Count__c,Member_types__c,Suppression_Count__c,System_Control_Group_Count__c,Current_count__c, Channel__c, CG_Count__c,Ignore_Bad_Debt_Suppression__c, Ignore_Minor_Suppression__c, Control_Group_Percentage__c, Control_Group_Size__c, Missing_Contact_Count__c,Control_Group_Count__c FROM Campaign WHERE Id=:campaignId];
        //This will be used to apply suppression count as per child segment suppresion selection
        //Campaign childCampaign = [SELECT Id,List_Order_Id__c,Supp_Count__c,Member_types__c,Suppression_Count__c,System_Control_Group_Count__c,Current_count__c, Channel__c, CG_Count__c,Ignore_Bad_Debt_Suppression__c, Ignore_Minor_Suppression__c, Control_Group_Percentage__c, Control_Group_Size__c, Missing_Contact_Count__c,Control_Group_Count__c FROM Campaign WHERE Id=:trans.Campaign__c];
        List<Contact> contacts = [Select Id,Wunderman_Id__c,SUP_NON_EMAIL__c,HasOptedOutOfEmail, SUP_BAD_DEBT__c, SUP_MINOR__c, SUP_Clinical_Disease_States__c, SUP_Deceased_External__c, SUP_Deceased_Internal__c, SUP_Incarcerated__c, Industry_Suppr_State_Level_Do_Not_Mail__c, SUP_PO_Box_Types__c, SUP_Name_formats__c, SUP_Discharge_Status__c, SUP_Industry_State_Level__c FROM Contact WHERE Wunderman_Id__c IN:lstWMContactIds];
        //Start defect#810
        pageSize=lstWMContactIds.size();
        //End Defect#810        
        Tenet_Static_Variables.suppressedCampaignMember = 0;
        List<CampaignMember> members = new List<CampaignMember>();
        system.debug('***contacts'+contacts.size());
        map<Id,string> contactIdWIdMap = new map<id,string>();
        for(Contact contact: contacts)
        {
            contactIdWIdMap.put(contact.id,contact.Wunderman_Id__c);
            CampaignMember member = new CampaignMember();
            member.CampaignId = campaign.Id;
            member.ContactId = contact.Id;
            member.Exclude_From_Roll_Up__c = false;
            //Changes for PP1 and PP4 Start
            /*if(string.valueOf(campaign.Member_types__c).equalsIgnoreCase('Campaign Segments')){
            	setCampaignMemberSuppressionDetails(childCampaign,contact,member);
            }else*/
           		setCampaignMemberSuppressionDetails(campaign,contact,member);
            //Changes for PP1 and PP4 End
        // Ending of new Suppression Logic Implementation 
            members.add(member);
            
            if(lstWMContactIds.contains(contact.Wunderman_Id__c))
                lstWMContactIds.remove(contact.Wunderman_Id__c);
        }
        
        system.debug('***members'+members.size());
        
        //Changes for PP1 Start
        applyControlGroups(members,campaign,false);
        //Changes for PP1 End
        
        Database.SaveResult[] srList = Database.insert(members, false);
        
        // Iterate through each returned result
        integer i=0;
        string failedIds='';//trans.Failed_Contact_Id__c='';
        for (Database.SaveResult sr : srList) 
        {
            if(!sr.isSuccess() && sr.getId()==null){
                
                boolean isError=true;
				for(Database.Error err : sr.getErrors()){
					if(err.getStatusCode()==StatusCode.DUPLICATE_VALUE)
						isError=false;
				}
				if(isError){
					if(string.isBlank(failedIds))
						failedIds += contactIdWIdMap.get(members[i].ContactId);
					else
						failedIds += ','+contactIdWIdMap.get(members[i].ContactId);
				}
            }
            i++;
            
        }

        //This section should be after insert and before save result calculation
        if(string.isBlank(trans.Failed_Contact_Id__c)){
            if(campaign.Missing_Contact_Count__c == null) campaign.Missing_Contact_Count__c = 0;
            
            campaign.Missing_Contact_Count__c += lstWMContactIds.size();
            
            if(lstWMContactIds.size()>0){
                list<string> wIds = new list<string>();
                wIds.addAll(lstWMContactIds);
                trans.Missed_Profile_Count__c= string.join(wIds,',');
            }
            
            update campaign;
        }        
        
        trans.Failed_Contact_Id__c=failedIds;
        if(!string.isBlank(failedIds))
            throw new CampaignMemberManagerException('Campaign Member Record Insertion Failed');
        
            
        
        
          
    }
    
    //Changes for PP1 Start
    static void setCampaignMemberSuppressionDetails(Campaign campaign,Contact contact, CampaignMember member){
        if((!campaign.Ignore_Bad_Debt_Suppression__c && contact.SUP_BAD_DEBT__c) || (!campaign.Ignore_Minor_Suppression__c && contact.SUP_Minor__c) || (campaign.Channel__c=='Email'  && (contact.SUP_NON_EMAIL__c || contact.HasOptedOutOfEmail)) || (campaign.Channel__c=='Direct Mail' && contact.Industry_Suppr_State_Level_Do_Not_Mail__c) || contact.SUP_Clinical_Disease_States__c || contact.SUP_Deceased_External__c || contact.SUP_Deceased_Internal__c || contact.SUP_Incarcerated__c || contact.SUP_Name_formats__c || contact.SUP_Discharge_Status__c || contact.SUP_Industry_State_Level__c)
        {
            member.Suppress__c = true;
            member.Suppression_Reasons__c = getValueIfTrue(!campaign.Ignore_Bad_Debt_Suppression__c && contact.SUP_BAD_DEBT__c, 'Bad Debt') + getValueIfTrue(!campaign.Ignore_Minor_Suppression__c && contact.SUP_Minor__c,'Minor') + getValueIfTrue(campaign.Channel__c=='Direct Mail'  && contact.Industry_Suppr_State_Level_Do_Not_Mail__c, 'Mail') + getValueIfTrue(campaign.Channel__c=='Email'  && (contact.SUP_NON_EMAIL__c || contact.HasOptedOutOfEmail), 'Non Email') + getValueIfTrue(contact.SUP_Clinical_Disease_States__c,'Clinical Disease States') + getValueIfTrue(contact.SUP_Deceased_External__c,'Deceased External') + getValueIfTrue(contact.SUP_Deceased_Internal__c, 'Deceased Internal') + getValueIfTrue(contact.SUP_Incarcerated__c, 'Incarcerated') + getValueIfTrue(contact.SUP_Name_formats__c,'Name formats') + getValueIfTrue(contact.SUP_Discharge_Status__c,'Discharge Status') + getValueIfTrue(contact.SUP_Industry_State_Level__c,'State Level') ;
            Tenet_Static_Variables.suppressedCampaignMember +=1;
        }
    }
    //Changes for PP1 End
    
     //This method will parse list order id into an eligible string
    @TestVisible
    private static string parseListOrderId(Decimal listOrderId)
    {
        string parsedlistOrderId = string.valueOf(listOrderId);
        if(parsedlistOrderId.indexOf('.')!=-1)
            parsedlistOrderId = parsedlistOrderId.substring(0,parsedlistOrderId.indexOf('.'));
        
        return parsedlistOrderId;
    }
    
    //Staring of defect#810 
     //This method will check Control Group Count in case Control Group Size is mentioned on Campaing before activating Campaign
    public static void confirmControlGroupCount(Campaign camp){
      system.debug('cgCountDifference%%%'+camp);
      integer cgCountDifference=0;
	    if(camp.Control_Group_Percentage__c!=null){
	        system.debug('cgCountDifference%%%'+camp.System_Control_Group_Count__c);
	        system.debug('cgCountDifference%%%'+camp.Control_Group_Count__c);
	    	cgCountDifference=integer.valueOf(camp.System_Control_Group_Count__c) - integer.valueOf(camp.Control_Group_Count__c);
	    }else{
	    	cgCountDifference = integer.valueOf(camp.Control_Group_Size__c) - integer.valueOf(camp.Control_Group_Count__c);
	    }     
        if(cgCountDifference>0){
	        list<CampaignMember> cmList = [select id,Control_Group__c from CampaignMember where campaignId=:camp.id AND Control_Group__c=false AND Suppress__c=false limit 9900];
	        integer j=0;
	        list<CampaignMember> updateCMList = new list<CampaignMember>();
	        for(CampaignMember cm:cmList){
	          integer rn= integer.valueof(math.random()*cmList.size());
	          if(!cmList[rn].Control_Group__c){
	          cmList[rn].Control_Group__c = true;
	          updateCMList.add(cmList[rn]);
	          j++;
	          }
	          if(j==cgCountDifference)
	          break;
            }
        
	        if(updateCMList.size()>0)
	          update updateCMList;
	      
	        if(updateCMList.size() !=cgCountDifference)
	          camp.Add_Member_Status__c='Invalid Control Group Count';
	    }
    }
    //Ending of defect#810 
    
    
  
    // Starting of defect : 810: Control group changes
    //Changes for PP1 Start
    private static void applyControlGroups(List<CampaignMember> lstCampaignMembers, Campaign objCampaign,Boolean isAudienceUpload)
    {   
        //This query will help in making sure CG count won't fluctuate due to multiple pages
        Integer totalPages;
        if(isAudienceUpload){
            Id uploadRecordTYpeId = ReferenceData_PicklistController.recordTypeId('CRM_AudienceUploadJunction__c','Audience_Upload');
            Decimal tp=0.0;
            for(CRM_AudienceUploadJunction__c auj :[select CRM_AudienceCount__c from CRM_AudienceUploadJunction__c where recordTypeId=:uploadRecordTYpeId AND (CRM_Campaign__c=:objCampaign.id OR CRM_Campaign__r.CRM_ParentSegmentedCampaign__c=:objCampaign.id) AND CRM_ToDelete__c=false]){
            	if(auj.CRM_AudienceCount__c==null)auj.CRM_AudienceCount__c=0;
            	tp += auj.CRM_AudienceCount__c;	
            }
            
            tp = tp/2000;//Maximum batch size allowed by SFDC is 2000
            if(tp>integer.valueof(tp))
                tp = integer.valueof(tp) +1;
            
            totalPages = integer.valueof(tp);
        }else{
            list<Decimal> listOrderIds = new list<Decimal>();
            for(Campaign cm : [select List_Order_Id__c from Campaign where CRM_ParentSegmentedCampaign__c=:objCampaign.Id AND List_Order_Id__c!=null]){
            	listOrderIds.add(cm.List_Order_Id__c);
            }
            totalPages = [select count() from Transaction__c where ((Campaign__c=:objCampaign.id AND WM_List_Order_Id__c=:objCampaign.List_Order_Id__c) OR (Campaign__r.CRM_ParentSegmentedCampaign__c=:objCampaign.id AND WM_List_Order_Id__c IN:listOrderIds)) AND Type__c='GetOrderData'];
        }
        
        integer validCGCMList = lstCampaignMembers.size()-Tenet_Static_Variables.suppressedCampaignMember;
        integer controlGroupCount=0;
        integer expectedCGCount;
        integer validCampMemberCountForCGroup;
        
        if(objCampaign.Control_Group_Size__c!=null)
            expectedCGCount = integer.valueof(objCampaign.CG_Count__c) - integer.valueof(objCampaign.Control_Group_Count__c);
        else
            expectedCGCount = integer.valueof(objCampaign.System_Control_Group_Count__c) - integer.valueof(objCampaign.Control_Group_Count__c);
        
        if(objCampaign.Control_Group_Size__c == null)
            validCampMemberCountForCGroup = Math.round((validCGCMList*objCampaign.Control_Group_Percentage__c)/100);
        else{
            
            if(totalPages>1){
            //deect#810
                integer lastPageRecordCount=integer.valueOf(objCampaign.Current_count__c-(pageSize*(totalPages-1)));
                //defect 810
                lastPageRecordCount = lastPageRecordCount - integer.valueOf((objCampaign.Supp_Count__c-Tenet_Static_Variables.suppressedCampaignMember - objCampaign.Suppression_Count__c));
                if(!(lastPageRecordCount>integer.valueOf(objCampaign.Control_Group_Size__c/totalPages)))
                    totalPages -= 1;
                validCampMemberCountForCGroup = integer.valueof(objCampaign.Control_Group_Size__c/totalPages);
            }else
                validCampMemberCountForCGroup = integer.valueof(objCampaign.Control_Group_Size__c/(totalPages));
        }
        system.debug('***validCampMemberCountForCGroup='+validCampMemberCountForCGroup);
        
       if(expectedCGCount!=0){
           if(expectedCGCount>validCampMemberCountForCGroup+totalPages)
            controlGroupCount = validCampMemberCountForCGroup;
          else
            controlGroupCount = expectedCGCount;
        } 
        if(controlGroupCount!=0){
            integer j=0;
            for(integer i=0; i<lstCampaignMembers.size(); i++){ 
              integer rn= integer.valueof(math.random()*lstCampaignMembers.size());//This will return a number less than list size
              if(!lstCampaignMembers[rn].Suppress__c && !lstCampaignMembers[rn].Control_Group__c){
                lstCampaignMembers[rn].Control_Group__c = true;
                j++;
              }
              if(j==controlGroupCount)
                break;
            }
        }
    }
    //Changes for PP1 End
    // Ending of defect : 810: Control group changes
    
    
  
    private static string getValueIfTrue(boolean key, string value)
    {
        if(key==true)
            return value + ';';
        else    
            return '';
    }   
    // Starting of new Suppression Logic Implementation  
    public static integer getSuppressCount(Set<string> lstWMContactIds,Campaign objCampaign,integer queryLimit)
    {
        string query='Select Id, SUP_BAD_DEBT__c, SUP_MINOR__c, SUP_Clinical_Disease_States__c, SUP_Deceased_External__c, SUP_Deceased_Internal__c, SUP_Incarcerated__c, Industry_Suppr_State_Level_Do_Not_Mail__c, SUP_PO_Box_Types__c, SUP_Name_formats__c, SUP_Discharge_Status__c, SUP_Industry_State_Level__c FROM Contact WHERE Wunderman_Id__c IN:lstWMContactIds';
        query += ' AND (SUP_Clinical_Disease_States__c=true OR SUP_Deceased_External__c=true OR SUP_Deceased_Internal__c=true OR SUP_Incarcerated__c=true OR SUP_Name_formats__c=true OR SUP_Discharge_Status__c=true OR SUP_Industry_State_Level__c=true';
        if(!objCampaign.Ignore_Bad_Debt_Suppression__c)
            query += ' OR SUP_BAD_DEBT__c=true';
        if(!objCampaign.Ignore_Minor_Suppression__c)
            query += ' OR SUP_Minor__c=true';
        if(objCampaign.Channel__c=='Email')
            query += ' OR SUP_NON_EMAIL__c=true OR HasOptedOutOfEmail=true';
        if(objCampaign.Channel__c=='Direct Mail')
            query += ' OR Industry_Suppr_State_Level_Do_Not_Mail__c=true';
    
        query += ') LIMIT '+queryLimit;
        
        list<sObject> contactList=Database.query(query);
        
        return contactList.size();
    }
    // Ending of new Suppression Logic Implementation 
    public static void getCGCount(Campaign campaign){
    	if(campaign.Control_Group_Percentage__c != null)
            campaign.CG_Count__c = Math.round(((campaign.Current_Count__c - campaign.Supp_Count__c)*integer.valueOf(campaign.Control_Group_Percentage__c))/100);
        else if(campaign.Control_Group_Size__c != null)
            campaign.CG_Count__c = campaign.Control_Group_Size__c;
    }
    /*
    public static integer getCGCount(integer suppressionCount,integer cgCount,Campaign objCampaign)
    {   
        integer controlGroupCount;
        integer validCampMemberCountForCGroup = CampaignMemberManager.soqlContactCount-suppressionCount;
        system.debug('****suppressionCount='+suppressionCount);
        system.debug('***validCampMemberCountForCGroup='+validCampMemberCountForCGroup);
        integer controlGroupSize;
        system.debug('***objCampaign.Control_Group_Size__c='+objCampaign.Control_Group_Size__c);
        if(objCampaign.Control_Group_Size__c!=null){
            if(suppressionCount!=0){
                controlGroupSize=integer.valueOf(objCampaign.Control_Group_Size__c-cgCount);
            }else{
                controlGroupSize=integer.valueOf(objCampaign.Control_Group_Size__c);
            }
            
            if(controlGroupSize>validCampMemberCountForCGroup){
                controlGroupCount=validCampMemberCountForCGroup;
            }else{
                controlGroupCount=controlGroupSize;
            }
            system.debug('***controlGroupCount='+controlGroupCount);
        }else{
       
            //controlGroupCount= (validCampMemberCountForCGroup*integer.valueOf(objCampaign.Control_Group_Percentage__c))/100;
            controlGroupCount= Math.round((decimal.valueof(validCampMemberCountForCGroup)*integer.valueOf(objCampaign.Control_Group_Percentage__c))/100);
            system.debug('***controlGroupCount='+controlGroupCount);
        }
        system.debug('***controlGroupCount='+controlGroupCount);
        return controlGroupCount;
    }
    */
    @future
    public static void updateContactSyncToMarketo(set<id> contactIds){
        list<Contact> updateContactList = new list<Contact>();
        for(Contact con : [select id,SyncToMarketo__c from Contact where Id IN: contactIds AND SyncToMarketo__c=false]){
            updateContactList.add(new Contact(Id=con.Id,SyncToMarketo__c=true));
        }
        if(updateContactList.size()>0)
            update updateContactList;
    }
    //This method will add campaign member status when a campaign is created or edited
    public static void createMemberStatus(map<id,Campaign> campaignMap,Boolean isInsert){
        
        list<CampaignMemberStatus> defaultCMSList = new list<CampaignMemberStatus>();
        map<id,set<string>> existingStatusMap = new map<id,set<string>>();
        
        if(!isInsert){
            for(CampaignMemberStatus cms : [select label,CampaignId from CampaignMemberStatus where CampaignId IN: campaignMap.keySet()]){
                if(!existingStatusMap.containsKey(cms.CampaignId)){
                    set<string> lables = new set<string>();lables.add(cms.Label);
                    existingStatusMap.put(cms.CampaignId,lables);
                }else{
                    existingStatusMap.get(cms.CampaignId).add(cms.Label);
                }
            }
        }
         
        for(id cms : campaignMap.keySet()){
            
            if(isInsert)
                defaultCMSList.add(new CampaignMemberStatus(IsDefault=true,Label='Member',SortOrder=3,CampaignId = cms));
                
                        
            if(campaignMap.get(cms).Channel__c =='Inbound' && campaignMap.get(cms).Call_to_Action__c=='Event'){
                if(isInsert){
                    defaultCMSList.add(new CampaignMemberStatus(Label='Registered',SortOrder=4,CampaignId = cms));
                    defaultCMSList.add(new CampaignMemberStatus(Label='No-Show',SortOrder=5,CampaignId = cms));
                    defaultCMSList.add(new CampaignMemberStatus(Label='Attended',SortOrder=6,CampaignId = cms));
                }else{
                
                    if(!existingStatusMap.get(cms).contains('Registered'))
                        defaultCMSList.add(new CampaignMemberStatus(Label='Registered',SortOrder=4,CampaignId = cms));
                    if(!existingStatusMap.get(cms).contains('No-Show')) 
                        defaultCMSList.add(new CampaignMemberStatus(Label='No-Show',SortOrder=5,CampaignId = cms));
                    if(!existingStatusMap.get(cms).contains('Attended'))
                        defaultCMSList.add(new CampaignMemberStatus(Label='Attended',SortOrder=6,CampaignId = cms));
                }
            }
        }
        
        if(defaultCMSList.size()>0)
            insert defaultCMSList;  
   }
   //This method will be used to create campaign member from audience upload
   //Changes for PP1 Start
   /*public static void addAudienceUploadAsCampaignMember(map<string,Id> WMIdauIdMap, Id campaignId){
        map<string,Id> masterWMIdauIdMap = new map<string,Id>();
        masterWMIdauIdMap.putAll(WMIdauIdMap);
        // Starting of new Suppression Logic Implementation 
        Campaign campaign = [SELECT Id,List_Order_Id__c,Supp_Count__c,Suppression_Count__c,System_Control_Group_Count__c,Current_count__c,Channel__c, 
        CG_Count__c,Ignore_Bad_Debt_Suppression__c, Ignore_Minor_Suppression__c, Control_Group_Percentage__c, Control_Group_Size__c, Missing_Contact_Count__c,Control_Group_Count__c FROM Campaign WHERE Id=:campaignId];
        List<Contact> contacts = [Select Id,Wunderman_Id__c,SUP_NON_EMAIL__c,HasOptedOutOfEmail, SUP_BAD_DEBT__c, SUP_MINOR__c, SUP_Clinical_Disease_States__c, SUP_Deceased_External__c, SUP_Deceased_Internal__c, SUP_Incarcerated__c, Industry_Suppr_State_Level_Do_Not_Mail__c, SUP_PO_Box_Types__c, SUP_Name_formats__c, SUP_Discharge_Status__c, SUP_Industry_State_Level__c FROM Contact WHERE Wunderman_Id__c IN:WMIdauIdMap.keySet()];
        
        pageSize=WMIdauIdMap.size();
        
        Tenet_Static_Variables.suppressedCampaignMember = 0;
        List<CampaignMember> members = new List<CampaignMember>();
        system.debug('***contacts'+contacts.size());
        map<Id,string> contactIdWIdMap = new map<id,string>();
        for(Contact contact: contacts)
        {
            contactIdWIdMap.put(contact.id,contact.Wunderman_Id__c);
            CampaignMember member = new CampaignMember();
            member.CampaignId = campaign.Id;
            member.ContactId = contact.Id;
            member.Exclude_From_Roll_Up__c = false;
            
            //set suppression details on campaign member
            setCampaignMemberSuppressionDetails(campaign,contact,member);
            
            members.add(member);
            
            if(WMIdauIdMap.containsKey(contact.Wunderman_Id__c))
                WMIdauIdMap.remove(contact.Wunderman_Id__c);
        }
        
        system.debug('***members'+members.size());
        
        applyControlGroups(members,campaign,true);
        
        Database.SaveResult[] srList = Database.insert(members, false);
        
        // Iterate through each returned result
        integer i=0;
        list<CRM_AudienceUpload__c> updatedAUrecords = new list<CRM_AudienceUpload__c>();
        for (Database.SaveResult sr : srList) 
        {
            if(sr.isSuccess()){
                
                if(contactIdWIdMap.containsKey(members[i].ContactId)){
                    if(masterWMIdauIdMap.containsKey(contactIdWIdMap.get(members[i].ContactId))){
                        id au=masterWMIdauIdMap.get(contactIdWIdMap.get(members[i].ContactId));
                        updatedAUrecords.add(new CRM_AudienceUpload__c(id=au,CRM_IsProcessed__c=true));
                    }
                }
                
            }else{
				boolean isError=true;
				for(Database.Error err : sr.getErrors()){
					if(err.getStatusCode()==StatusCode.DUPLICATE_VALUE)
						isError=false;
				}
				
				if(!isError){
					if(contactIdWIdMap.containsKey(members[i].ContactId)){
						if(masterWMIdauIdMap.containsKey(contactIdWIdMap.get(members[i].ContactId))){
							id au=masterWMIdauIdMap.get(contactIdWIdMap.get(members[i].ContactId));
							updatedAUrecords.add(new CRM_AudienceUpload__c(id=au,CRM_IsProcessed__c=true));
						}
					}	
				}
			                
			}
            i++;
            
        }
        
        
        if(campaign.Missing_Contact_Count__c == null) campaign.Missing_Contact_Count__c = 0;
            campaign.Missing_Contact_Count__c += WMIdauIdMap.size();
            
        if(WMIdauIdMap.size()>0){
            for(Id au : WMIdauIdMap.values()){
                updatedAUrecords.add(new CRM_AudienceUpload__c(id=au,CRM_IsNotAvailable__c=true,CRM_IsProcessed__c=true));
            }
        }
        
        update updatedAUrecords;
        
        update campaign;
        
    }*/
    //Changes for PP1 Ends
    
   public class CampaignMemberManagerException extends Exception {}
}
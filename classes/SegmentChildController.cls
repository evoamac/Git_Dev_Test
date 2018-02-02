public class SegmentChildController {

    public  campaign camp{get;set;}
    public  Campaign objcamp{get;set;}
    public  SObject headSObject ,headClone;
    public id parentid{get;set;}
    public  String parentCampName {get ; set ;}
    public boolean  segmentedchildflag{get;set;}
    public string parentname{get;set;}
    public string oldvalue{get;set;}
    public String newvalue{get;set;}
    public string channelOldValue{get;set;}
   
   
    
    
    public SegmentChildController(ApexPages.StandardController controller)
    {
        
         camp = new campaign();
      objcamp = (Campaign) controller.getRecord();
        objcamp = [Select name,channel__c from campaign where id=: objcamp.Id];
        system.debug('parent campname is@@@@'+objcamp);
        parentid = ApexPages.CurrentPage().getParameters().get('id');
   parentname = String.valueOf(objcamp.name);
       system.debug('parent camp is@@@@'+ parentid);
      
          
    }
    
    public  string addSegmentChildCamp(id parentid)
    {   
        PageReference pgr;
        
          segmentedchildflag=true;
        
       
        if(CampaignWizardcontroller.BeforeCloneValidation(parentid))
        {  
            //headClone=ClonePlusController.cloneObjects(new List<sObject>{headSObject}).get(0);
            
            ClonePlusController clonep = new ClonePlusController();
            string campaignQuery = clonep.queryString('Campaign',null);
            campaignQuery += ' where id=\''+parentid+'\'';
            for(SObject camp:Database.query(campaignQuery)){
                headClone = camp.clone(false,true);
            }
            
            parentCampName = String.valueOf(headClone.get('name'));
            headClone.put('Service_Line__c',null);
            headClone.put('CRM_OwnershipType__c',null);
            headClone.put('EndDate',null);
            headClone.put('StartDate',null);
            //objcamp.Selectedownership = null;
            //objcamp.showSelectedownership=null;
            headClone.put('Call_Center_Identifier__c',null);
            headClone.put('Call_Center_Unique_Identifier__c',null); 
            headClone.put('Campaign_Toll_Free_Number__c',null);
            headClone.put('Status','Segmented Campaign Not Activated');
            headClone.put('IsActive',false);
            headClone.put('Approved__c',false); 
            headClone.put('Member_types__c','Any or no encounters - Everyone'); 
            //headClone.put('Channel__c', null);
            //headClone.put('Vendor_Name__c', null); 
            headClone.put('Other__c', null);
            headClone.put('Program_Name__c',null); 
            headClone.put('Save_Campaign_as_Template__c',false);
            headclone.put('Actual_Spend__c', null);
            headClone.put('Campaign_Budget__c' , null);
            headClone.put('Expected_Contribution_Margin__c', null);
            headClone.put('Purchase_Invoice_Order__c', null);
            headClone.put('Place_Order_Date_Time__c',null); 
            headClone.put('Add_Member_Status__c',null);
            headClone.put('List_Order_Id__c',null);
            headClone.put('LIST_ORDER_SELECT_GRP_ID__c',null);
            headClone.put('Current_count__c',null);
            headClone.put('Approved_By__c',null);
            headClone.put('Approval_Comments__c',null);
            headClone.put('MARS_Approval__c',null);
            headClone.put('Ownerid', UserInfo.getUserId());
            headClone.put('CG_Count__c',null);
            headClone.put('Supp_Count__c',null);
            headClone.put('Missing_Contact_Count__c',null);
            headclone.put('Segment__c', camp.Segment__c);
            headclone.put('Control_Group_Percentage__c', null);
           
            headClone.put('CRM_Refreshed_Count_Date__c',null);
           headClone.put('CRM_ParentSegmentedCampaign__c',String.valueOf(parentid));
            insert headClone;
          String segmentchildname=ReferenceData_PicklistController.getCampaignName(headclone.id);            
            headClone.put('Name',segmentchildname);
             system.debug('### count of index## '+segmentchildname.substringAfter('-'));
            if(segmentchildname!=null){
                system.debug('child name'+ segmentchildname);
          headClone.put('count_of_index__c', segmentchildname.substringAfter('-'));    
            }
              
        update headClone;
         
            
        system.debug('####### headClone id ######'+headClone.Id); 
           if(headClone.id!=null){
         return headClone.id;
        
         }
        return headClone.id;
        }
       else
       {
           
            return null;
       }
     
        
    }
    
    public void segmentchild(){
        pageReference ref;
        
        addSegmentChildCamp(parentid);
        if(headclone.id!=null){
         
            system.debug('old vallue member type is'+ oldvalue);
           	newvalue = String.valueOf(headclone.get('Member_Types__c'));
             String channelNewvalue = objcamp.Channel__c;
            system.debug('new vallue member type is'+ newvalue);
            
            system.debug('old vallue channel  is'+ channelOldValue);
             system.debug('new vallue channel  is'+ channelNewvalue);
             CampaignWizardController.insertMemberTypeCriteria(headclone.id,oldvalue ,newvalue);
             CampaignWizardController.UpsertDemoCriteras(headclone.id,channelOldValue,channelNewvalue ); 
            
             map<id,id> mainNClonedCampIdMap = new map<id,id>();
             mainNClonedCampIdMap.put(parentid,headclone.id);
             clonerefJunctionCriteria(mainNClonedCampIdMap);

        }
        /* ref = new PageReference('/apex/campaignWizard?Id='+parentid+'&stepNo=3&parentname='+parentCampName);
        ref.setredirect(true);
        return ref;*/
        
       
    }
    
    
   public void clonerefJunctionCriteria(map<id,id> mainNClonedCampIdMap)
    {
        list<sObject> searchCriteriaList = new list<sObject>();
        system.debug('**mainNClonedCampIdMap**='+mainNClonedCampIdMap);
        for(Campaign cm : [select id,(select id,CRM_CampaignWizardReferenceData__c,CRM_CampaignMapping__c  from CRM_CampaignRefJunction__r) from campaign where ID IN:mainNClonedCampIdMap.keySet()]){
             
                        system.debug('**cm.CRM_CampaignRefJunction__r**='+cm.CRM_CampaignRefJunction__r.size());
            for(CRM_CampaignRefJunction__c  ObjJO : cm.CRM_CampaignRefJunction__r){
                CRM_CampaignRefJunction__c newListRecord = new CRM_CampaignRefJunction__c (CRM_CampaignWizardReferenceData__c = ObjJO.CRM_CampaignWizardReferenceData__c,CRM_CampaignMapping__c= mainNClonedCampIdMap.get(cm.id));        
                searchCriteriaList.add(newListRecord); 
            }
               
        }
        system.debug('****searchCriteriaList='+searchCriteriaList.size());
        searchCriteriaList.sort();
        if(searchCriteriaList.size()>0)
            insert searchCriteriaList;
    }
    
        
}
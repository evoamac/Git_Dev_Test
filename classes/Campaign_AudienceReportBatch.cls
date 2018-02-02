public class Campaign_AudienceReportBatch implements Database.Batchable<sObject>,Database.Stateful
{
    public final String query;
    public final boolean flag;
    public Id campaignId;
    public boolean updateCampaign=true;
    list<Decimal> listOrderIDs;
    list<Id> campaignIDs;
    map<id,boolean> campaignProcessingStatusMap = new map<id,boolean>();
    
    public Campaign_AudienceReportBatch(id campId,Boolean isAudienceUpload)
    {
        Campaign campObj = [select id,List_Order_Id__c from Campaign where id=:campId];
        flag = isAudienceUpload;
        campaignId = campObj.id;
        if(isAudienceUpload)
            query = 'select id,Response_Schema__c,Campaign__c from Transaction__c where Campaign__c  =\''+campObj.id+'\' AND Transaction_Source__c = \'Audience Upload\'';
    }
    
    public Campaign_AudienceReportBatch(set<Id> campId)
    {
        listOrderIDs = new list<Decimal>();
        campaignIDs = new list<Id>();
        for(Campaign campObj : [select Id,List_Order_Id__c from Campaign where id IN:campId]){
            if(campObj.List_Order_Id__c != null)
                listOrderIDs.add(campObj.List_Order_Id__c);
            
            campaignIDs.add(campObj.Id);
            campaignProcessingStatusMap.put(campObj.Id,true);
        }
        flag = false;
        
        query = 'select id,Response_Schema__c,Campaign__c from Transaction__c where Campaign__c IN:campaignIDs  AND WM_List_Order_Id__c IN: listOrderIDs  AND Campaign_Member_Status__c=\'Ready to Process\' AND Type__c=\'GetOrderData\'';
        
        
    }
    public Database.QueryLocator start(Database.BatchableContext BC)
    {
        
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext BC,List<sObject> transactions)
    {
       try{
           list<CRM_AudienceReport__c> insertAudienceReportList;
           set<string> contactIds = new set<string>();
           
           if(flag){
                for(sObject sobj : transactions){
                    Transaction__c au = (Transaction__c)sobj;
                    contactIds.addAll(au.Response_Schema__c.split(','));
                    if(campaignId==null)
                        campaignId = au.Campaign__c;
                } 
                
                Campaign cmp = [select id,Ignore_Bad_Debt_Suppression__c,Supp_Count__c,
                            Ignore_Minor_Suppression__c,Channel__c from campaign where id=:campaignId];
           
                //if(cmp.Supp_Count__c==null)
                    //cmp.Supp_Count__c=0;
                                        
                //cmp.Supp_Count__c +=CampaignMemberManager.getSuppressCount(contactIds,cmp,2000);
               
                //update cmp;
            
           }else{
               
               Transaction__c tran = (Transaction__c)transactions[0];
               if(!string.isBlank(tran.Response_Schema__c)){
                    contactIds.addAll(tran.Response_Schema__c.split(','));
                   
            }
                
               campaignId = tran.Campaign__c;
           }
           
           insertAudienceReportList=AudienceReport_Helper.prepareAudienceRecord(campaignId,contactIds);
           
           if(insertAudienceReportList.size()>0)
                insert insertAudienceReportList;
                
       }catch(Exception ex){
            updateCampaign = false;
            if(campaignProcessingStatusMap.containsKey(campaignId))
                campaignProcessingStatusMap.put(campaignId,false);
            //create error log record
            Tenet_Exception_Handler logError = new Tenet_Exception_Handler();
            logError.creatExceptionLog(ex,null,'Campaign_AudienceReportBatch');
            
       }
    }
    
    public void finish(Database.BatchableContext BC){
         
         try{
             list<id> campIds = new list<id>();
             if(flag){    
                 if(updateCampaign){
                    
                    Campaign cmp = [select id,Control_Group_Size__c,Control_Group_Percentage__c,Supp_Count__c,
                                    Channel__c,Current_Count__c,CRM_ParentSegmentedCampaign__r.id,CRM_ParentSegmentedCampaign__c  from campaign where id=:campaignId];
                    
                    cmp.Add_Member_Status__c='Calculated Net Count';
                    cmp.CG_Count__c = 0;
                    
                    CampaignMemberManager.getCGCount(cmp);//Calculate Congrol Group Count   
                        
                    update cmp;
                    if(cmp.CRM_ParentSegmentedCampaign__c!=null)
                        campIds.add(cmp.id);
                
                 }else{
                    update new Campaign(id=campaignId,Add_Member_Status__c='Invalid Audience Report',Supp_Count__c=null,CG_Count__c=null);
                    Id uploadRecordTYpeId = ReferenceData_PicklistController.recordTypeId('CRM_AudienceUploadJunction__c','Audience_Report');
                    list<CRM_AudienceUploadJunction__c> acj = [select id from CRM_AudienceUploadJunction__c where CRM_Campaign__c=:campaignId AND  CRM_ToDelete__c=false AND RecordTypeId=:uploadRecordTYpeId];
                    if(acj.size()>0){
                        acj[0].CRM_ToDelete__c = true;
                        update acj[0];
                    }
                 }
             }else{
                list<Campaign> cmpList = new list<Campaign>();
                set<Id> failIdSet = new set<Id>();
                for(Id cmpId :campaignProcessingStatusMap.keySet()){
                    if(campaignProcessingStatusMap.get(cmpId)){
                        cmpList.add(new campaign(id=cmpId,Add_Member_Status__c='Calculated Net Count'));
                        campIds.add(cmpId);
                    }else{
                        failIdSet.add(cmpId);
                    }
                }
                    
                if(failIdSet.size()>0){
                    for(id cmid : failIdSet){
                        cmpList.add(new Campaign(id=campaignId,Add_Member_Status__c='Invalid Audience Report'));
                    }
                    Id uploadRecordTYpeId = ReferenceData_PicklistController.recordTypeId('CRM_AudienceUploadJunction__c','Audience_Report');
                    list<CRM_AudienceUploadJunction__c> acj = [select id from CRM_AudienceUploadJunction__c where CRM_Campaign__c IN: failIdSet AND  CRM_ToDelete__c=false AND RecordTypeId=:uploadRecordTYpeId];
                    for(CRM_AudienceUploadJunction__c au : acj){
                        au.CRM_ToDelete__c = true;
                    }
                    
                    if(acj.size()>0)
                        update acj;
                }
                
                 if(cmpList.size()>0){
                    update cmpList;
                    
                 }
                    
                    
             }
             //This will rollup count detail to parent campaign
             //if(campIds.size()>0)
                //AudienceReport_Helper.rollupFinalCountDetailToSegmented(campIds,false);
         }catch(Exception ex){
            //create error log record
            Tenet_Exception_Handler logError = new Tenet_Exception_Handler();
            logError.creatExceptionLog(ex,null,'Campaign_AudienceReportBatch');
         }
    
    }
}
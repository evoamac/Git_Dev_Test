/*This class will create Audience History Records once a campaign is Activated Successfully*/
public class CampaignAudience_HistoryBatch implements Database.Batchable<sObject>,Database.Stateful {
    public final String query;
    public set<Id> campaignId;
    public Id uploadRecordTYpeId;
    public set<Id> junctionRecordIdSet;
    public set<string> campStatus;
    public CampaignAudience_HistoryBatch(Id campId){
    	campaignId = new set<Id>();
    	for(Campaign cm : [select id,(select id from CRM_SegmentedParentCampaigns__r) from Campaign where Id=:campId]){
    		campaignId.add(cm.id);
    		for(Campaign c : cm.CRM_SegmentedParentCampaigns__r){
    			campaignId.add(c.Id);
    		}
    	}
    	uploadRecordTYpeId = ReferenceData_PicklistController.recordTypeId('CRM_AudienceUploadJunction__c','Audience_Report');
    	junctionRecordIdSet = new set<Id>();
        campStatus = new set<string>{'Active','Segment Activated'};
        query = 'select CRM_Campaign__c,CRM_ControlGroup__c,CRM_AudienceUploadJunction__c,CRM_Hospital__c,CRM_LIstOrderId__c,CRM_Member__c,CRM_ParentCampaign__c,CRM_Segment__c,CRM_Supression__c,CRM_WundermanID__c,CRM_ZipCode__c from CRM_AudienceReport__c where CRM_AudienceUploadJunction__r.CRM_Campaign__c IN:campaignId AND CRM_AudienceUploadJunction__r.CRM_Campaign__r.Status IN:campStatus AND CRM_AudienceUploadJunction__r.CRM_ToDelete__c=false AND CRM_AudienceUploadJunction__r.recordTypeId=:uploadRecordTYpeId';
        
    }
    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext BC,List<sObject> audeinceReport){
        try{
	        list<CRM_CampaignAudienceHistory__c> newAudienceHistoryList = new list<CRM_CampaignAudienceHistory__c>();
	        for(Sobject t: audeinceReport){ 
	        	
	        	CRM_AudienceReport__c ar = (CRM_AudienceReport__c)t;
	          	
	          	CRM_CampaignAudienceHistory__c ah = new CRM_CampaignAudienceHistory__c();
	          	ah.CRM_Campaign__c  = ar.CRM_Campaign__c;
	          	ah.CRM_ControlGroup__c  = ar.CRM_ControlGroup__c;
	          	ah.CRM_Hospital__c  = ar.CRM_Hospital__c;
	          	ah.CRM_LIstOrderId__c  = ar.CRM_LIstOrderId__c;
	          	ah.CRM_Member__c = ar.CRM_Member__c;
	          	ah.CRM_ParentCampaign__c  = ar.CRM_ParentCampaign__c;
	          	ah.CRM_Segment__c  = ar.CRM_Segment__c;
	          	ah.CRM_Supression__c  = ar.CRM_Supression__c;
	          	ah.CRM_WundermanID__c = ar.CRM_WundermanID__c;
	          	ah.CRM_ZipCode__c  = ar.CRM_ZipCode__c;
	            
	            newAudienceHistoryList.add(ah);
	            
	            if(!junctionRecordIdSet.contains(ar.CRM_AudienceUploadJunction__c))
	            	junctionRecordIdSet.add(ar.CRM_AudienceUploadJunction__c);
	        }
	        
	        if(newAudienceHistoryList.size()>0)
	        	insert newAudienceHistoryList;
	    }catch(Exception ex){
             Tenet_Exception_Handler logError = new Tenet_Exception_Handler();
             logError.creatExceptionLog(ex,null,'CampaignAudience_HistoryBatch:Execute');
        }
    }
    public void finish(Database.BatchableContext BC){
        try{
	        list<CRM_AudienceUploadJunction__c> updateJunctionRecordForDelete = new list<CRM_AudienceUploadJunction__c>();
	        for(CRM_AudienceUploadJunction__c au : [select id,CRM_ToDelete__c from CRM_AudienceUploadJunction__c where Id IN: junctionRecordIdSet limit 5000]){
	        	au.CRM_ToDelete__c=true;
	        	updateJunctionRecordForDelete.add(au);
	        }
	     	if(updateJunctionRecordForDelete.size()>0)
	     		update updateJunctionRecordForDelete;
        }catch(Exception ex){
             Tenet_Exception_Handler logError = new Tenet_Exception_Handler();
             logError.creatExceptionLog(ex,null,'CampaignAudience_HistoryBatch:Finish');
        }   
    }
}
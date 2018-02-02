public with sharing class AudienceUploadHelper 
{
    public static integer uploadJunctionCounter;
    //This method will link campaign to audience upload junction and then AUJ to Aundience Upload object records and do the rollup count
    public static void setJunctionUploadId(list<CRM_AudienceUpload__c> newAudienceUploadList){
    	if(uploadJunctionCounter==null){
    		uploadJunctionCounter = integer.valueof(math.random()*10000000);
    	}
    	set<string> campaignName = new set<string>();
    	for(CRM_AudienceUpload__c au : newAudienceUploadList){
    		campaignName.add(au.CRM_CampaignName__c);
    	}
    	
    	//Check if we already have a Audience Upload Junction Record for a Campaign or not
    	set<id> campaignIdset = new set<id>();
    	list<CRM_AudienceUploadJunction__c> uploadJunctionRecord = new list<CRM_AudienceUploadJunction__c>();
    	Id uploadRecordTYpeId = ReferenceData_PicklistController.recordTypeId('CRM_AudienceUploadJunction__c','Audience_Upload');
    	for(Campaign cm : 
    					[
	    					select 
	    					id,
	    					(select id from CRM_AudienceUploadJunctions__r where CRM_ToDelete__c=false AND RecordTypeId=:uploadRecordTYpeId AND CRM_BatchCounter__c=:uploadJunctionCounter) 
	    					from Campaign 
	    					where Name IN: campaignName
    					]
    	){
    		campaignIdset.add(cm.id);
    		if(cm.CRM_AudienceUploadJunctions__r.size()<1)
    			uploadJunctionRecord.add(new CRM_AudienceUploadJunction__c(CRM_Campaign__c=cm.Id,RecordTypeId=uploadRecordTYpeId,CRM_BatchCounter__c=uploadJunctionCounter));
    	}
    	//In Case no AUJ record for a campaign then create one
    	if(uploadJunctionRecord.size()>0)
    		insert uploadJunctionRecord;
    	
    	//Map of campaign name and related AUJ record 	
    	map<string,CRM_AudienceUploadJunction__c> campaignNameuploadJunctionMap = new map<string,CRM_AudienceUploadJunction__c>();
    	for(CRM_AudienceUploadJunction__c auj : 
    											[
    												select 
    												id,CRM_AudienceCount__c,
    												CRM_Campaign__r.Name 
    												from CRM_AudienceUploadJunction__c 
    												where CRM_Campaign__c IN:campaignIdset AND CRM_ToDelete__c=false AND
    												RecordTypeId=:uploadRecordTYpeId AND CRM_BatchCounter__c=:uploadJunctionCounter
    											]
    	){
    		campaignNameuploadJunctionMap.put(auj.CRM_Campaign__r.Name,auj);
    	}
    	
    	//Related AUJ with AU records and do rollup count
    	for(CRM_AudienceUpload__c au : newAudienceUploadList){
    		
    		if(campaignNameuploadJunctionMap.containsKey(au.CRM_CampaignName__c)){
    			au.CRM_AudienceUploadJunction__c= campaignNameuploadJunctionMap.get(au.CRM_CampaignName__c).id;
    			
    			if(campaignNameuploadJunctionMap.get(au.CRM_CampaignName__c).CRM_AudienceCount__c==null)
    				campaignNameuploadJunctionMap.get(au.CRM_CampaignName__c).CRM_AudienceCount__c=0;
    			
    			campaignNameuploadJunctionMap.get(au.CRM_CampaignName__c).CRM_AudienceCount__c += 1;
    				
    		}
    	}
    	
    	if(campaignNameuploadJunctionMap.size()>0)
    		update campaignNameuploadJunctionMap.values();
    }
    
    //This method will mark AUJ records for deletion, which then be deleted by a night job
    public static void setUploadJunctionForDelete(id campId){
    	
    	Id uploadRecordTYpeId = ReferenceData_PicklistController.recordTypeId('CRM_AudienceUploadJunction__c','Audience_Upload');
    	list<CRM_AudienceUploadJunction__c> updateUploadJunctionList = new list<CRM_AudienceUploadJunction__c>();
    	
    	for(CRM_AudienceUploadJunction__c auj : 
    											[
    												select 
    												id,
    												CRM_ToDelete__c
    												from CRM_AudienceUploadJunction__c 
    												where CRM_Campaign__c =:campId AND CRM_ToDelete__c=false AND
    												RecordTypeId=:uploadRecordTYpeId
    											]
    	){
    		auj.CRM_ToDelete__c = true;
    		updateUploadJunctionList.add(auj);
    	}
    	
    	if(updateUploadJunctionList.size()>0)
    		update updateUploadJunctionList;
    }
}
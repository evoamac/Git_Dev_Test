/*
	This class will delte Audience Upload Junction records which are marked for deletion and child Audience Upload records
*/
public class Campaign_AudienceUploadDeleteBatch implements Database.Batchable<sObject>,Database.Stateful{
	public final String query;
	
	public Campaign_AudienceUploadDeleteBatch(){
		query = 'select id from CRM_AudienceUpload__c where CRM_AudienceUploadJunction__r.CRM_ToDelete__c=true OR CRM_AudienceUploadJunction__c=null';
	}
	public Database.QueryLocator start(Database.BatchableContext BC){
	    
	    return Database.getQueryLocator(query);
	}
	
	public void execute(Database.BatchableContext BC,List<sObject> audienceUpload){
	
		delete audienceUpload;
		
		Database.emptyRecycleBin(audienceUpload);
	
	}
	    
	public void finish(Database.BatchableContext BC){
		
		delete [select id from CRM_AudienceUploadJunction__c where CRM_ToDelete__c=true limit 10000];
	
	}

}
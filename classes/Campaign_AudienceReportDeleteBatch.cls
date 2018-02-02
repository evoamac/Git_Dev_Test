/*
    This class will delte Audience Upload Junction records which are marked for deletion and child Audience Upload records
*/
public class Campaign_AudienceReportDeleteBatch implements Database.Batchable<sObject>,Database.Stateful{
    public final String query;
    
    public Campaign_AudienceReportDeleteBatch (){
        query = 'select id from CRM_AudienceReport__c where CRM_AudienceUploadJunction__r.CRM_ToDelete__c=true OR CRM_AudienceUploadJunction__c=null';
    }
    public Database.QueryLocator start(Database.BatchableContext BC){
        
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC,List<sObject> audienceReport){
        try{
            delete audienceReport;
            
            Database.emptyRecycleBin(audienceReport);
        }catch(Exception ex){
            createLogs(ex, 'Campaign_AudienceReportDeleteBatch:Execute');
        }   
    }
        
    public void finish(Database.BatchableContext BC){
        try{
            Id uploadRecordTYpeId = ReferenceData_PicklistController.recordTypeId('CRM_AudienceUploadJunction__c','Audience_Report');
            list<CRM_AudienceUploadJunction__c> deleteAudienceJunctionList = new list<CRM_AudienceUploadJunction__c>();
            deleteAudienceJunctionList = [select id from CRM_AudienceUploadJunction__c where recordTypeId=:uploadRecordTYpeId AND CRM_ToDelete__c=true limit 5000];
            delete deleteAudienceJunctionList;
        }catch(Exception ex){
             createLogs(ex, 'Campaign_AudienceReportDeleteBatch:Finish');
        }   
    }
    
    public void createLogs(Exception ex, string sr){
        Tenet_Exception_Handler logError = new Tenet_Exception_Handler();
        logError.creatExceptionLog(ex,null,sr);
    }

}
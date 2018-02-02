@istest
public class Tenet_AudienceReportScheduler_Test{
public static testmethod void executemethod() {
    
 Test.startTest();
     list<CRM_AudienceReport__c> audReport = new list<CRM_AudienceReport__c>();
        list<CRM_AudienceUpload__c>  audienclist = new list<CRM_AudienceUpload__c>();
        Campaign camp = marketingDataUtils.campforhomeaddress();
        CRM_AudienceUploadJunction__c  audiencejunction = marketingDataUtils.createAudienceJunctin(camp.id);
        CRM_AudienceReport__c audiencereport = new CRM_AudienceReport__c();
         audiencereport.CRM_Campaign__c=camp.id;
         audiencereport.CRM_AudienceUploadJunction__c=audiencejunction.id;
       insert audiencereport;
       audReport.add(audiencereport);
    Tenet_AudienceReportScheduler campmembersc = new Tenet_AudienceReportScheduler();
    String CRON_EXP = '0 10 12 21 4 ?';
    String jobId = System.schedule('Sample_name', CRON_EXP, new Tenet_AudienceReportScheduler() ); 
    Campaign_AudienceReportDeleteBatch ds = new Campaign_AudienceReportDeleteBatch ();
    
    ds.createLogs(new MyException('This is bad'),'Test');
 Test.stopTest();
 }
 public class MyException extends Exception {} 
}
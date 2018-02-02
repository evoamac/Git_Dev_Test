@istest
public class CampaignAudience_HistoryBatch_Test {
 public static testmethod void ReportDeleteBatch()
    {
        list<CRM_AudienceReport__c> audReport = new list<CRM_AudienceReport__c>();
        Campaign camp = marketingDataUtils.campforhomeaddress();
        CRM_AudienceUploadJunction__c  audiencejunction = marketingDataUtils.createAudienceJunctin(camp.id);
        CRM_AudienceReport__c audiencereport = new CRM_AudienceReport__c();
         audiencereport.CRM_Campaign__c=camp.id;
         audiencereport.CRM_AudienceUploadJunction__c=audiencejunction.id;
       insert audiencereport;
       audReport.add(audiencereport);
       Database.QueryLocator QL;
       Database.BatchableContext BC;
       Test.startTest();      
       CampaignAudience_HistoryBatch history = new CampaignAudience_HistoryBatch(camp.id);
           Database.executebatch(history);
           history.execute(BC,audReport);
           history.finish(BC);
       Test.stopTest();
	}

}
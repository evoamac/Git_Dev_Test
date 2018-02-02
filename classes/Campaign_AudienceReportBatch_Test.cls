@istest
public class Campaign_AudienceReportBatch_Test {

    
    public static testmethod void batchmethod1(){
        Database.QueryLocator QL;
        Database.BatchableContext BC;
        Campaign camp = marketingDataUtils.campforhomeaddress();
        camp.Control_Group_Size__c=23554;
        camp.Current_Count__c=3253;
        camp.Supp_Count__c=1230;
        camp.Control_Group_Percentage__c=10;
      update camp;
        CRM_AudienceUploadJunction__c  audiencejunction = marketingDataUtils.createAudienceJunction(camp.id);
        audiencejunction.CRM_ToDelete__c=false;
      update audiencejunction;
        Lead l = marketingDataUtils.createleads();
        Transaction__c trans = marketingDataUtils.createTransaction(camp.id, l.id);
        Boolean isAudienceUpload = true;
        set<id> setcampid = new set<id>();
        setcampid.add(camp.id);
        list<CRM_AudienceReport__c> AudienceReportList = new list<CRM_AudienceReport__c>();
     Test.startTest();      
           //Campaign_AudienceReportBatch deltebatch = new Campaign_AudienceReportBatch(camp.id,isAudienceUpload);
           Campaign_AudienceReportBatch delteebatch = new Campaign_AudienceReportBatch(setcampid);
               QL = delteebatch.start(BC);
               Database.executebatch(delteebatch);
     Test.stopTest();
        
    }
    public static testmethod void batchmethod2(){
        
        Database.QueryLocator QL;
        Database.BatchableContext BC;
        campaign newCampaigns =marketingDataUtils.createcampforPP();
        Id uploadRecordTYpeId = ReferenceData_PicklistController.recordTypeId('CRM_AudienceUploadJunction__c','Audience_Report');
        CRM_AudienceUploadJunction__c  audiencejunction = marketingDataUtils.createAudienceJunction(newCampaigns.id);
        audiencejunction.CRM_ToDelete__c=false;
        audiencejunction.RecordTypeId=uploadRecordTYpeId;
      update audiencejunction;
        Lead l = marketingDataUtils.createleads();
        Transaction__c trans = marketingDataUtils.createnewTransaction(newCampaigns.id, l.id);
        contact con = marketingDataUtils.createNewcontact();
        Boolean isAudienceUpload = True;
        set<id> setcampid = new set<id>();
        setcampid.add(newCampaigns.id);
        list<CRM_AudienceReport__c> AudienceReportList = new list<CRM_AudienceReport__c>();
     Test.startTest();      
           //Campaign_AudienceReportBatch deltebatch = new Campaign_AudienceReportBatch(newCampaigns.id,isAudienceUpload);
           Campaign_AudienceReportBatch delteebatch = new Campaign_AudienceReportBatch(setcampid);
               QL = delteebatch.start(BC);
               delteebatch.updateCampaign=False;
               Database.executebatch(delteebatch);
     Test.stopTest();
        
    }
    public static testmethod void batchmethod3(){
        
      Database.QueryLocator QL;
      Database.BatchableContext BC;
        campaign newCampaigns =marketingDataUtils.createcampforPP();
        Id uploadRecordTYpeId = ReferenceData_PicklistController.recordTypeId('CRM_AudienceUploadJunction__c','Audience_Report');
        CRM_AudienceUploadJunction__c  audiencejunction = marketingDataUtils.createAudienceJunction(newCampaigns.id);
           audiencejunction.CRM_ToDelete__c=false;
           audiencejunction.RecordTypeId=uploadRecordTYpeId;
      update audiencejunction;
        Lead l = marketingDataUtils.createleads();
        Transaction__c trans = marketingDataUtils.createnewTransaction(newCampaigns.id, l.id);
        contact con = marketingDataUtils.createNewcontact();
            Boolean isAudienceUpload = False;
            set<id> setcampid = new set<id>();
            setcampid.add(newCampaigns.id);
        
        list<CRM_AudienceReport__c> AudienceReportList = new list<CRM_AudienceReport__c>();
        CRM_AudienceReport__c audreport = marketingDataUtils.createaudiencereport(newCampaigns.id,audiencejunction.id);
     Test.startTest();      
            Campaign_AudienceReportBatch delteebatch = new Campaign_AudienceReportBatch(setcampid);
               QL = delteebatch.start(BC);
               delteebatch.updateCampaign=False;
               Database.executebatch(delteebatch);
     Test.stopTest();
        
    }
    public static testmethod void batchmethod4()
    {
         Database.QueryLocator QL;
        Database.BatchableContext BC;
        campaign newCampaigns =marketingDataUtils.createcampforPP();
        campaign newCamp =marketingDataUtils.createcampsegmented();
        newCamp.Member_Types__c=  'Campaign Segments';
      update newCamp;
          List<Id> cmpid = new List<Id>();
            cmpid.add(newCamp.id);
            Boolean isDelete =True;
        Id uploadRecordTYpeId = ReferenceData_PicklistController.recordTypeId('CRM_AudienceUploadJunction__c','Audience_Report');
        CRM_AudienceUploadJunction__c  audiencejunction = marketingDataUtils.createAudienceJunction(newCampaigns.id);
          audiencejunction.CRM_ToDelete__c=false;
          audiencejunction.RecordTypeId=uploadRecordTYpeId;
      update audiencejunction;
            Boolean isAudienceUpload = False;
            Boolean isQuickCount = True;
            Lead l = marketingDataUtils.createleads();
          Transaction__c trans = marketingDataUtils.createnewTransaction(newCampaigns.id, l.id);
            AudienceReport_Helper uploadaud = new AudienceReport_Helper();
              AudienceReport_Helper.createCampaignAudienceReport(newCampaigns.id);
              AudienceReport_Helper.rollupFinalCountDetailToSegmented(cmpid, isDelete,isQuickCount);
              AudienceReport_Helper.rollupFinalCountDetailToSegmented2(cmpid, isDelete,isQuickCount);
            
    }
    public static testmethod void batchmethod5()
    {
         Database.QueryLocator QL;
        Database.BatchableContext BC;
        campaign newCampaigns =marketingDataUtils.createcampforPP();   
            Id uploadRecordTYpeId = ReferenceData_PicklistController.recordTypeId('CRM_AudienceUploadJunction__c','Audience_Report');
            Boolean isAudienceUpload = False;
        contact con = marketingDataUtils.createNewcontact();
        set<string> windermanIds = new set<string>();
        	    windermanIds.add('69755');
        Lead l = marketingDataUtils.createleads();
          Transaction__c trans = marketingDataUtils.createnewTransaction(newCampaigns.id, l.id);
            AudienceReport_Helper uploadaud = new AudienceReport_Helper();
            AudienceReport_Helper.createCampaignAudienceReport(newCampaigns.id);
            AudienceReport_Helper.prepareAudienceRecord(newCampaigns.id,windermanIds);
                
    }
    
     public static testmethod void batchmethod6()
    {
         Database.QueryLocator QL;
        Database.BatchableContext BC;
        campaign newCampaigns =marketingDataUtils.createcampforPP();
        campaign newCamp =marketingDataUtils.createcampsegmented();
        newCamp.Member_Types__c=  'Campaign Segments';
      update newCamp;
          List<Id> cmpid = new List<Id>();
            cmpid.add(newCamp.id);
            Boolean isDelete =True;
        Id uploadRecordTYpeId = ReferenceData_PicklistController.recordTypeId('CRM_AudienceUploadJunction__c','Audience_Report');
        CRM_AudienceUploadJunction__c  audiencejunction = marketingDataUtils.createAudienceJunction(newCampaigns.id);
          audiencejunction.CRM_ToDelete__c=false;
          audiencejunction.RecordTypeId=uploadRecordTYpeId;
      update audiencejunction;
            Boolean isAudienceUpload = False;
            Boolean isQuickCount = False;
            Lead l = marketingDataUtils.createleads();
          Transaction__c trans = marketingDataUtils.createnewTransaction(newCampaigns.id, l.id);
            AudienceReport_Helper uploadaud = new AudienceReport_Helper();
              AudienceReport_Helper.createCampaignAudienceReport(newCampaigns.id);
              AudienceReport_Helper.rollupFinalCountDetailToSegmented(cmpid, isDelete,isQuickCount);
              AudienceReport_Helper.rollupFinalCountDetailToSegmented2(cmpid, isDelete,isQuickCount);
            
    }
}
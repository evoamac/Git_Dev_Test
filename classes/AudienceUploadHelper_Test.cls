@istest
public class AudienceUploadHelper_Test 
    {
        public static testmethod void helper1()
        {
        Database.QueryLocator QL;
        Database.BatchableContext BC;
        campaign newCampaigns =marketingDataUtils.createcampforPP();
        Id uploadRecordTYpeId = ReferenceData_PicklistController.recordTypeId('CRM_AudienceUploadJunction__c','Audience_Report');
        CRM_AudienceUploadJunction__c  audiencejunction = marketingDataUtils.createAudienceJunction(newCampaigns.id);
          audiencejunction.CRM_ToDelete__c=false;
          audiencejunction.RecordTypeId=uploadRecordTYpeId;
      update audiencejunction;
            Boolean isAudienceUpload = False;
            AudienceUploadHelper uploadaud = new AudienceUploadHelper();
              AudienceUploadHelper.setUploadJunctionForDelete(newCampaigns.id);
        }

    }
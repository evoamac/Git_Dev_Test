@istest
public class Campaign_AudienceUploadDeleteBatch_Test
{
    public static testmethod void audienceuploadmethod()
    {
        Campaign camp = marketingDataUtils.campforhomeaddress();
        CRM_AudienceUploadJunction__c  audiencejunction = marketingDataUtils.createAudienceJunction(camp.id);
          
       Test.startTest();      
       Campaign_AudienceUploadDeleteBatch deltebatch = new Campaign_AudienceUploadDeleteBatch();
           Database.executebatch(deltebatch);     
       Test.stopTest();
    }
}
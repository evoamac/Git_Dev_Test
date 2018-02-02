@isTest
private class AudienceUploadController_Test 
{
    @testSetup
    private static void setupMethod()
    {
        Campaign camp = new Campaign
        (
            Name = 'Test Campaign'
        );
        insert camp;
    }
    
    @isTest
	private static void testMethod001() 
	{
	    Test.startTest();
	    PageReference pr1 = Page.AudienceUpload;
	    pr1.getParameters().put('campaignId', '');
	    Test.setCurrentPage(pr1);
	    AudienceUploadController controller = new AudienceUploadController();
	    List<ApexPages.Message> msgs = ApexPages.getMessages();
	    System.assertEquals(1, msgs.size());
	    ApexPages.Message msg = msgs[0];
	    System.assertEquals(msg.getDetail(), Label.CRM_AudienceUploadNoCampaignIdFound);
	    Test.stopTest();
	}
	
	@isTest
	private static void testMethod002()
	{
	    Test.startTest();
	    PageReference pr1 = Page.AudienceUpload;
	    pr1.getParameters().put('campaignId', '2343');
	    Test.setCurrentPage(pr1);
	    AudienceUploadController controller = new AudienceUploadController();
	    List<ApexPages.Message> msgs = ApexPages.getMessages();
	    System.assertEquals(1, msgs.size());
	    ApexPages.Message msg = msgs[0];
	    System.assertEquals(msg.getDetail(), Label.CRM_AudienceUploadNoCampaignIdFound);
	    Test.stopTest();
	}
	
	@isTest
	private static void testMethod003()
	{
	    Test.startTest();
	    PageReference pr1 = Page.AudienceUpload;
	    pr1.getParameters().put('campaignId', '0010U000002zcqB');
	    Test.setCurrentPage(pr1);
	    AudienceUploadController controller = new AudienceUploadController();
	    List<ApexPages.Message> msgs = ApexPages.getMessages();
	    System.assertEquals(1, msgs.size());
	    ApexPages.Message msg = msgs[0];
	    System.assertEquals(msg.getDetail(), Label.CRM_Invalid_Campaign_ID);
	    Test.stopTest();
	}
	
	@isTest
	private static void testMethod004() 
	{
	    Test.startTest();
	    
	    List<Campaign> camps = [SELECT Id FROM Campaign];
	    
	    PageReference pr = Page.AudienceUpload;
	    pr.getParameters().put('campaignId', camps[0].Id);
	    Test.setCurrentPage(pr);
	    
	    AudienceUploadController controller = new AudienceUploadController();
	    controller.fileBody = Blob.valueOf('12345\n23456\n34567\n45678');
	    controller.importCsv();
	    
	    Campaign camp = [SELECT CRM_AudienceUploadCount__c FROM Campaign WHERE Id =: camps[0].Id];
	    
	    Test.stopTest();
	}
	
	@isTest
	private static void testMethod005()
	{
	    Test.startTest();
	    
	    List<Campaign> camps = [SELECT Id FROM Campaign];
	    
	    PageReference pr = Page.AudienceUpload;
	    pr.getParameters().put('campaignId', camps[0].Id);
	    Test.setCurrentPage(pr);
	    
	    AudienceUploadController controller = new AudienceUploadController();
	    controller.fileBody = Blob.valueOf('12345\n23456\n34567\n45678\n234,3234');
	    
	    controller.importCsv();
	    
	    Test.stopTest();
	}
	
	@isTest
	private static void testMethod006()
	{
	    //Test.startTest();
	    
	    List<Campaign> camps = [SELECT Id FROM Campaign];
	    /*
	    PageReference pr = Page.AudienceUpload;
	    pr.getParameters().put('campaignId', camps[0].Id);
	    Test.setCurrentPage(pr);
	    
	    AudienceUploadController controller = new AudienceUploadController();
	    */
	    String wdmIds = '1\n2\n3\n4\n5\n6\n7\n8\n9\n';
	    String testBlobString = '1\n2\n3\n4\n5\n6\n7\n8\n9';
	    for (Integer i=0; i<=17000; i++)
	    {
	        testBlobString += wdmIds;
	    }
	    Test.startTest();
	    
	    AudienceUploadController.importCsvFuture(Blob.valueOf(testBlobString), camps[0].Id);
	    
	    
	    Test.stopTest();
	}
	
	@isTest
	private static void tesetMethod007()
	{
	    Test.startTest();
	    List<Campaign> camps = [SELECT Id FROM Campaign];
	    AudienceUploadCOntroller.hasExistingFileUpload(camps[0].Id);
	    Test.stopTest();
	}
	

}
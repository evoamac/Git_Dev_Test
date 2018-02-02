@istest
public class PagingDRGController_Test 
{
    public static testMethod void DrgMethod() 
    {
        boolean flag = True;
        boolean exclude = true;
        set < Integer > visitedPage = Null;
        campaign cmp = marketingDataUtils.CreateCampaign();
        DRG_Code__c codes = marketingDataUtils.createDRGcode();
        DRG_Code_Information__c DRGCode = marketingDataUtils.createDRGCodeDetails(cmp.id, codes.id);

        PagingDRGController.WrapSearchResult wrap = new PagingDRGController.WrapSearchResult(codes, flag);
        pagereference testpage = new pagereference('/apex/CampaignCriteria_DRGs');
        Test.setcurrentPage(testPage);
        ApexPages.currentPage().getParameters().put('id', cmp.id);
        //ApexPages.currentPage().getParameters().put('exclude',True);
        ApexPages.StandardController sc = new ApexPages.standardController(cmp);
        PagingDRGController Drg = new PagingDRGController(sc);
        Drg.geo = codes;
        Drg.selectAll = True;
        Drg.selectedDrgNumbere = 'Test';
        Drg.masterSelectAll = False;
        Drg.selectedDescription = 'This is location';
        Drg.searchLocation();
        Drg.selectAll = True;
        Drg.exclude = True;
        Drg.getsearchResult();
        Drg.first();
        Drg.next();
        Drg.previous();
        Drg.last();
        Drg.cancel();
        Drg.saveDemographicServiceArea();
        Drg.clearSearch();
        Drg.quickSave();
    }

    public static testMethod void DrgMethod2() 
    {
        boolean flag = True;
        boolean exclude = True;
        set < Integer > visitedPage = Null;
        campaign cmp = marketingDataUtils.CreateCampaign();
        DRG_Code__c codes = marketingDataUtils.createDRGcode();
        DRG_Code_Information__c DRGCode = marketingDataUtils.createDRGCodeInformation(cmp.id);
        Encounter__c encount = marketingDataUtils.createEncounter(cmp.id);
        PagingDRGController.WrapSearchResult wrap = new PagingDRGController.WrapSearchResult(codes, flag);
        pagereference testpage = new pagereference('/apex/CampaignCriteria_DRGs');
        Test.setcurrentPage(testPage);
        ApexPages.currentPage().getParameters().put('id', cmp.id);

        ApexPages.StandardController sc = new ApexPages.standardController(cmp);
        PagingDRGController Drg = new PagingDRGController(sc);
        Drg.geo = codes;
        Drg.selectAll = True;
        Drg.selectedDrgNumbere = 'Test';
        Drg.masterSelectAll = False;
        Drg.searchLocation();
        Drg.selectAll = True;
        Drg.getsearchResult();
        Drg.first();
        Drg.next();
        Drg.previous();
        Drg.last();
        Drg.cancel();
        Drg.selectAll = False;
        Drg.masterSelectAll = True;
        Drg.saveDemographicServiceArea();
        Drg.clearSearch();
    }
    
    public static testMethod void DrgMethod3() 
    {
        boolean flag = True;
        boolean exclude = True;
        set < Integer > visitedPage = Null;
        string encounterid;
        map < id, DRG_Code__c > masterSearchResult;

        campaign cmp = marketingDataUtils.CreateCampaign();
        DRG_Code__c codes = marketingDataUtils.createDRGcode();
        DRG_Code_Information__c DRGCode = marketingDataUtils.createDRGCodeInformation(cmp.id);
        Encounter__c encount = marketingDataUtils.createEncounter(cmp.id);

        PagingDRGController.WrapSearchResult wrap = new PagingDRGController.WrapSearchResult(codes, flag);
        pagereference testpage = new pagereference('/apex/CampaignCriteria_DRGs');
        Test.setcurrentPage(testPage);
        ApexPages.currentPage().getParameters().put('id', cmp.id);
        //ApexPages.currentPage().getParameters().put('encounterid',encount.id);    
        ApexPages.StandardController sc = new ApexPages.standardController(cmp);
        PagingDRGController Drg = new PagingDRGController(sc);
        Drg.geo = codes;
        Drg.selectAll = True;
        Drg.selectedDrgNumbere = 'Test';
        Drg.masterSelectAll = False;
        Drg.searchLocation();
        Drg.selectAll = True;
        Drg.getsearchResult();
        Drg.first();
        Drg.next();
        Drg.previous();
        Drg.last();
        Drg.encounterid = 'enc123';

        Drg.cancel();
        Drg.saveDemographicServiceArea();
        Drg.clearSearch();
    }
    
    public static testMethod void DrgMethod4() 
    {
        campaign cmp = marketingDataUtils.createcampainDetails();
        DRG_Code__c codes = marketingDataUtils.createDRGcode();
        DRG_Code_Information__c DRGCode = marketingDataUtils.createDRGCodeInformation(cmp.id);
        Encounter__c encount = marketingDataUtils.createEncounter(cmp.id);
        boolean flag = true;
        PagingDRGController.WrapSearchResult wrap = new PagingDRGController.WrapSearchResult(codes, flag);
        pagereference testpage = new pagereference('/apex/CampaignCriteria_DRGs');
        Test.setcurrentPage(testPage);
        ApexPages.currentPage().getParameters().put('id', cmp.id);
        ApexPages.StandardController sc = new ApexPages.standardController(cmp);
        PagingDRGController Drg = new PagingDRGController(sc);
        Drg.geo = codes;
        Drg.cmp.Service_Line__c = 'All Other';
        Drg.cmp.CRM_SubServiceLineText__c = 'Dental';
        Drg.selectedDescription = 'ok this true';
        Drg.searchLocation();
    }
    
    public static testMethod void DrgMethod5() 
    {
        boolean flag = False;
        boolean exclude = true;
        set < Integer > visitedPage = Null;
        campaign cmp = marketingDataUtils.CreateCampaign();
        DRG_Code__c codes = marketingDataUtils.createDRGcode();
        DRG_Code_Information__c DRGCode = marketingDataUtils.createDRGCodeDetails(cmp.id, codes.id);

        PagingDRGController.WrapSearchResult wrap = new PagingDRGController.WrapSearchResult(codes, flag);
        pagereference testpage = new pagereference('/apex/CampaignCriteria_DRGs');
        Test.setcurrentPage(testPage);
        ApexPages.currentPage().getParameters().put('id', cmp.id);
        //ApexPages.currentPage().getParameters().put('exclude',True);
        ApexPages.StandardController sc = new ApexPages.standardController(cmp);
        PagingDRGController Drg = new PagingDRGController(sc);
        Drg.geo = codes;
        Drg.selectAll = True;
        Drg.selectedDrgNumbere = 'Test';
        Drg.masterSelectAll = True;
        Drg.selectedDescription = 'This is location';
        Drg.searchLocation();
        Drg.selectAll = False;
        Drg.exclude = True;
        Drg.getsearchResult();
        Drg.first();
        Drg.next();
        Drg.previous();
        Drg.last();
        Drg.cancel();
        Drg.saveDemographicServiceArea();
        Drg.clearSearch();
        Drg.quickSave();
    }
    
    @isTest
    private static void testLstServiceLineValues()
    {
        boolean flag = True;
        boolean exclude = true;
        set<Integer> visitedPage = null;
        
        Test.startTest();
        campaign cmp = marketingDataUtils.CreateCampaign();
        DRG_Code__c codes = marketingDataUtils.createDRGcode();
        DRG_Code_Information__c DRGCode = marketingDataUtils.createDRGCodeDetails(cmp.id, codes.id);
        
        CRM_CampaignWizardReferenceData__c referenceData1 = new CRM_CampaignWizardReferenceData__c();
        referenceData1.CRM_IsActive__c = true;
        referenceData1.RecordTypeId = [SELECT id FROM RecordType WHERE SobjectType='CRM_CampaignWizardReferenceData__c' AND DeveloperName='Service_Line'][0].Id;
        referenceData1.CRM_ServiceLine__c = 'TestServiceLine';
        insert referenceData1;
        
        CRM_CampaignWizardReferenceData__c referenceData2 = new CRM_CampaignWizardReferenceData__c();
        referenceData2.CRM_IsActive__c = true;
        referenceData2.RecordTypeId = [SELECT id FROM RecordType WHERE SobjectType='CRM_CampaignWizardReferenceData__c' AND DeveloperName='Sub_Service_Line'][0].Id;
        referenceData2.CRM_SubServiceLine__c = 'TestSubServiceLine';
        insert referenceData2;
        

        PagingDRGController.WrapSearchResult wrap = new PagingDRGController.WrapSearchResult(codes, flag);
        pagereference testpage = new pagereference('/apex/CampaignCriteria_DRGs');
        Test.setcurrentPage(testPage);
        ApexPages.currentPage().getParameters().put('id', cmp.id);
        ApexPages.StandardController sc = new ApexPages.standardController(cmp);
        PagingDRGController Drg = new PagingDRGController(sc);
        
        List<SelectOption> serviceLineValues = Drg.lstServiceLineValues;
        List<SelectOption> subServiceLineValues = Drg.getsubserviceLine();
        Drg.callactionmethod();
        
        
        System.assertEquals(serviceLineValues.size(), 2);
        System.assertEquals(subServiceLineValues.size(), 1);
        Test.stopTest();
    }
    
    @isTest
    private static void haldleExistingRecordsTest()
    {
        Test.startTest();
        boolean flag = true;
        campaign cmp = marketingDataUtils.CreateCampaign();
        DRG_Code__c codes = marketingDataUtils.createDRGcode();
        DRG_Code_Information__c DRGCode = marketingDataUtils.createDRGCodeDetails(cmp.id, codes.id);
        
        PagingDRGController.WrapSearchResult wrap = new PagingDRGController.WrapSearchResult(codes, flag);
        pagereference testpage = new pagereference('/apex/CampaignCriteria_DRGs');
        Test.setcurrentPage(testPage);
        ApexPages.currentPage().getParameters().put('id', cmp.id);
        ApexPages.StandardController sc = new ApexPages.standardController(cmp);
        PagingDRGController Drg = new PagingDRGController(sc);
        Drg.geo = codes;
        Drg.selectAll = true;
        Drg.selectedDrgNumbere = 'Test';
        Drg.masterSelectAll = false;
        Drg.selectedDescription = 'This is location';
        Drg.searchLocation();
        Drg.selectAll = true;
        Drg.exclude = true;
        
        Drg.searchLocation();
        
        String[] valSsls = new String[]{'ssl1', 'ssl2'};
        Drg.selectedvalSSL = valSsls;
        Drg.searchLocation();
        Test.StopTest();
    }
    
    @isTest
    private static void haldleExistingRecordsTest1()
    {
        Test.startTest();
        boolean flag = true;
        campaign cmp = marketingDataUtils.CreateCampaign();
        DRG_Code__c codes = marketingDataUtils.createDRGcode();
        DRG_Code_Information__c DRGCode = marketingDataUtils.createDRGCodeDetails(cmp.id, codes.id);
        
        PagingDRGController.WrapSearchResult wrap = new PagingDRGController.WrapSearchResult(codes, flag);
        pagereference testpage = new pagereference('/apex/CampaignCriteria_DRGs');
        Test.setcurrentPage(testPage);
        ApexPages.currentPage().getParameters().put('id', cmp.id);
        ApexPages.StandardController sc = new ApexPages.standardController(cmp);
        PagingDRGController Drg = new PagingDRGController(sc);
        
        Drg.searchLocation();
        Test.StopTest();
    }
}
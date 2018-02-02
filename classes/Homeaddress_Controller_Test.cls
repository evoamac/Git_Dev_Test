@istest
public class Homeaddress_Controller_Test{
public static testmethod void method1(){
Campaign newCampaign = marketingDataUtils.campforhomeaddress(); 
CRM_CampaignLocationReferenceData__c refSA = marketingDataUtils.createServiceArea();
CRM_CampaignLocationReferenceData__c refMarket = marketingDataUtils.createRegionMarket();

CRM_Search_Criteria__c searchcriteria = new CRM_Search_Criteria__c();
     searchcriteria.CRM_Campaign__c=newCampaign.id;
     searchcriteria.CRM_Search_Criteria_Level_1__c ='By Market';
     searchcriteria.CRM_Search_Criteria_Level_2__c ='PSA';
     searchcriteria.CRM_Search_Criteria_Level_3__c ='DT1;EF3;PH2';
     searchcriteria.CRM_AdditionalZipCodes__c ='';
     searchcriteria.CRM_ExcludedZipCodes__c ='1GAP123';
   insert searchcriteria;
   
   pagereference testpage = new pagereference ('/apex/HomeAddress');
   Test.setcurrentPage(testPage); 
       ApexPages.currentPage().getParameters().put('id',newCampaign.id);
       ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
   Homeaddress_Controller homeadress = new Homeaddress_Controller(sc);
        homeadress.refreshSearchLevel2();
        homeadress.refreshSearchLevel3();
        homeadress.selectedServiceArea.add(refSA.id);
        homeadress.selectedSearchCriteriaLevel2.add(refMarket.id);
        homeadress.saveHomeAddressSearch();
        homeadress.Cancel();
        homeadress.deleteCriteria();
  }
  public static testmethod void method2(){
string sl='By Region';
list<string> sl2=new list<string>{'Primary Service Area'};
list<string> sl3= new list<string>{'Baylor/Tenet JV Region'};   
Campaign newCampaign = marketingDataUtils.campforhomeaddress(); 
CRM_CampaignLocationReferenceData__c refSA = marketingDataUtils.createServiceArea();
CRM_CampaignLocationReferenceData__c  refregion =marketingDataUtils.createRegion();


CRM_Search_Criteria__c searchcriteria = new CRM_Search_Criteria__c();
     searchcriteria.CRM_Campaign__c=newCampaign.id;
     searchcriteria.CRM_Search_Criteria_Level_1__c ='By Region';
     searchcriteria.CRM_Search_Criteria_Level_2__c ='PSA';
     searchcriteria.CRM_Search_Criteria_Level_3__c ='CR3';
     searchcriteria.CRM_AdditionalZipCodes__c ='';
     searchcriteria.CRM_ExcludedZipCodes__c ='';
   insert searchcriteria;

   pagereference testpage = new pagereference ('/apex/HomeAddress');
   Test.setcurrentPage(testPage); 
       ApexPages.currentPage().getParameters().put('id',newCampaign.id);
       ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
   Homeaddress_Controller homeadress = new Homeaddress_Controller(sc);
        Homeaddress_Controller.searchResult(sl, sl2, sl3);
        homeadress.refreshSearchLevel2();
        homeadress.refreshSearchLevel3();
        homeadress.serviceAreaList = new  List<SelectOption>{};
        homeadress.selectedServiceArea.add(refSA .id);
        homeadress.selectedSearchCriteriaLevel2.add(refregion.id);
        homeadress.saveHomeAddressSearch();

  }
    public static testmethod void method3(){
string sl='By Distance';
list<string> sl2=new list<string>{''};
list<string> sl3= new list<string>{''};    
Campaign newCampaign = marketingDataUtils.campforhomeaddress(); 
CRM_CampaignLocationReferenceData__c refSA = marketingDataUtils.createServiceArea();
CRM_CampaignLocationReferenceData__c refhos = marketingDataUtils.createrefHospital();
CRM_CampaignGeographyReferenceData__c state = marketingDataUtils.createstate();

CRM_Search_Criteria__c searchcriteria = new CRM_Search_Criteria__c();
     searchcriteria.CRM_Campaign__c=newCampaign.id;
     searchcriteria.CRM_Search_Criteria_Level_1__c ='By Distance';
     searchcriteria.CRM_Search_Criteria_Level_2__c ='21';
     searchcriteria.CRM_Search_Criteria_Level_3__c ='DHF';
     searchcriteria.CRM_AdditionalZipCodes__c ='26536;76733';
     searchcriteria.CRM_ExcludedZipCodes__c ='88693;87833';
   insert searchcriteria;
   pagereference testpage = new pagereference ('/apex/HomeAddress');
   Test.setcurrentPage(testPage); 
       ApexPages.currentPage().getParameters().put('id',newCampaign.id);
       ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
   Homeaddress_Controller homeadress = new Homeaddress_Controller(sc);
        homeadress.refreshSearchLevel2();
        homeadress.refreshSearchLevel3();
        homeadress.selectedSearchCriteriaLevel2.add(refhos.id);
        homeadress.saveHomeAddressSearch();
        
  }
  public static testmethod void method4(){
Campaign newCampaign = marketingDataUtils.campforhomeaddress(); 
CRM_CampaignGeographyReferenceData__c  cbsa =  marketingDataUtils.createrefCBSA();

   pagereference testpage = new pagereference ('/apex/HomeAddress');
   Test.setcurrentPage(testPage); 
       ApexPages.currentPage().getParameters().put('id',newCampaign.id);
       ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
   Homeaddress_Controller homeadress = new Homeaddress_Controller(sc);
        homeadress.refreshSearchLevel2();
        homeadress.selectedSearchCriteriaLevel2.add(cbsa.id);
        homeadress.saveHomeAddressSearch();
  }
  public static testmethod void method5(){
string sl='By county';
list<string> sl2=new list<string>{'Missouri'};
list<string> sl3= new list<string>{'DALLAS'};
Campaign newCampaign = marketingDataUtils.campforhomeaddress(); 
CRM_CampaignLocationReferenceData__c refSA = marketingDataUtils.createServiceArea();
Id Recordtypesstate = Schema.SObjectType.CRM_CampaignGeographyReferenceData__c.getRecordTypeInfosByName().get('State').getRecordTypeId(); 
      CRM_CampaignGeographyReferenceData__c geostaterefData = new CRM_CampaignGeographyReferenceData__c();
                 geostaterefData.CRM_State__c='Missouri';
                 geostaterefData.CRM_StateCode__c='MO';
                 geostaterefData.CRM_IsActive__c=True;
                 geostaterefData.RecordTypeId=Recordtypesstate;
               insert geostaterefData;
           Id RecordtypeCounty = Schema.SObjectType.CRM_CampaignGeographyReferenceData__c.getRecordTypeInfosByName().get('County').getRecordTypeId(); 
           CRM_CampaignGeographyReferenceData__c countyrefData = new CRM_CampaignGeographyReferenceData__c();
                 countyrefData.CRM_County__c='DALLAS';
                 countyrefData.CRM_CountysStateID__c=geostaterefData.id;
                 countyrefData.CRM_IsActive__c=True;
                 countyrefData.RecordTypeId=RecordtypeCounty;
               insert countyrefData;

CRM_Search_Criteria__c searchcriteria = new CRM_Search_Criteria__c();
     searchcriteria.CRM_Campaign__c=newCampaign.id;
     searchcriteria.CRM_Search_Criteria_Level_1__c ='By County';
     searchcriteria.CRM_Search_Criteria_Level_2__c ='MO';
     searchcriteria.CRM_Search_Criteria_Level_3__c ='DALLAS';
     searchcriteria.CRM_AdditionalZipCodes__c ='';
     searchcriteria.CRM_ExcludedZipCodes__c ='';
   insert searchcriteria;
   pagereference testpage = new pagereference ('/apex/HomeAddress');
   Test.setcurrentPage(testPage); 
        ApexPages.currentPage().getParameters().put('id',newCampaign.id);
        ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
        Homeaddress_Controller homeadress = new Homeaddress_Controller(sc);
        Homeaddress_Controller.searchResult(sl, sl2, sl3);
        homeadress.refreshSearchLevel2();
        homeadress.selectedSearchCriteriaLevel2.add(geostaterefData.id);
        homeadress.refreshSearchLevel3();
        homeadress.selectedVal.add(countyrefData.id);
        homeadress.saveHomeAddressSearch();
  }
  public static testmethod void method6(){
string sl='By State';
list<string> sl2=new list<string>{'Missouri'};
list<string> sl3= new list<string>{''};   
Campaign newCampaign = marketingDataUtils.campforhomeaddress(); 
CRM_CampaignLocationReferenceData__c refSA = marketingDataUtils.createServiceArea();
CRM_CampaignLocationReferenceData__c refhosket = marketingDataUtils.createrefHospital();
CRM_CampaignGeographyReferenceData__c state =  marketingDataUtils.createstate();

CRM_Search_Criteria__c searchcriteria = new CRM_Search_Criteria__c();
     searchcriteria.CRM_Campaign__c=newCampaign.id;
     searchcriteria.CRM_Search_Criteria_Level_1__c ='By State';
     searchcriteria.CRM_Search_Criteria_Level_2__c ='MO';
     searchcriteria.CRM_Search_Criteria_Level_3__c ='';
     searchcriteria.CRM_AdditionalZipCodes__c ='';
     searchcriteria.CRM_ExcludedZipCodes__c ='';
   insert searchcriteria;

   pagereference testpage = new pagereference ('/apex/HomeAddress');
   Test.setcurrentPage(testPage); 
       ApexPages.currentPage().getParameters().put('id',newCampaign.id);
       ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
   Homeaddress_Controller homeadress = new Homeaddress_Controller(sc);
        Homeaddress_Controller.searchResult(sl, sl2, sl3);
        homeadress.refreshSearchLevel2();
        homeadress.refreshSearchLevel3();
        homeadress.selectedSearchCriteriaLevel2.add(state.id);
        homeadress.saveHomeAddressSearch();

  }
  public static testmethod void method7(){
Campaign newCampaign = marketingDataUtils.campforhomeaddress(); 
CRM_CampaignLocationReferenceData__c refSA = marketingDataUtils.createServiceArea();
CRM_CampaignGeographyReferenceData__c state =  marketingDataUtils.createstate();
CRM_CampaignGeographyReferenceData__c Cbsa =  marketingDataUtils.createrefCBSA();

CRM_Search_Criteria__c searchcriteria = new CRM_Search_Criteria__c();
     searchcriteria.CRM_Campaign__c=newCampaign.id;
     searchcriteria.CRM_Search_Criteria_Level_1__c ='By CBSA';
     searchcriteria.CRM_Search_Criteria_Level_2__c ='Aberdeen, SD';
     searchcriteria.CRM_Search_Criteria_Level_3__c ='';
     searchcriteria.CRM_AdditionalZipCodes__c ='638863';
     searchcriteria.CRM_ExcludedZipCodes__c ='1GAP123';
   insert searchcriteria;
   pagereference testpage = new pagereference ('/apex/HomeAddress');
   Test.setcurrentPage(testPage); 
       ApexPages.currentPage().getParameters().put('id',newCampaign.id);
       ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
   Homeaddress_Controller homeadress = new Homeaddress_Controller(sc);
        homeadress.refreshSearchLevel2();
        homeadress.saveHomeAddressSearch();
  }
}
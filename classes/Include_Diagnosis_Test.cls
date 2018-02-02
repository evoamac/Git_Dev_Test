@istest
private class Include_Diagnosis_Test
{
public static testmethod void Add_diagnosistestmethod()
 {
 boolean selectAll=false;
 boolean flag = true;
 set<Integer> visitedPage= Null;
campaign cmp = marketingDataUtils.CreateCampaign();

ICD_Diagnosis__c  diagnosis = marketingDataUtils.creatediagnosis();



Include_Diagnosis_Controller.WrapSearchResult wrap = new Include_Diagnosis_Controller.WrapSearchResult(diagnosis,flag);
pagereference testpage = new pagereference ('/apex/AddICD');
    Test.setcurrentPage(testPage);
    ApexPages.currentPage().getParameters().put('id',cmp.id);
    
     ApexPages.StandardController sc = new ApexPages.standardController(cmp);
     
     Include_Diagnosis_Controller diagnosisinfo = new Include_Diagnosis_Controller(sc) ;
     diagnosisinfo.selectedDiagnosisCode = '45372';
     diagnosisinfo.selectedDiangnosisType= 'ICD9';
     diagnosisinfo.selectedLongDesc= 'Chronic venous embolism and thrombosis of deep veins of upper extremity';
     
     ICD_Diagnosis_In__c diagnosisinformation = marketingDataUtils.creatediagnosisinformation(cmp.id, diagnosis.id);
     
     diagnosisinfo.searchLocation();
    // diagnosisinfo.selectAll= true;
     diagnosisinfo.getsearchResult();
     diagnosisinfo.selectAll= true;
     boolean isCalloutEventTypeDelete=true;     
     diagnosisinfo.first();
     diagnosisinfo.last();
     diagnosisinfo.previous();
     diagnosisinfo.next();
     diagnosisinfo.saveDemographicServiceArea();
     diagnosisinfo.quickSave();
     diagnosisinfo.cancel();
     diagnosisinfo.clearSearch();
   }
   
   public static testmethod void Add_diagnosistestmethod1()
 {
 boolean selectAll=false;
boolean flag = true;
string encounterid= null;

campaign cmp = marketingDataUtils.CreateCampaign();

ICD_Diagnosis__c  diagnosis = marketingDataUtils.creatediagnosis();



Include_Diagnosis_Controller.WrapSearchResult wrap = new Include_Diagnosis_Controller.WrapSearchResult(diagnosis,flag);
pagereference testpage = new pagereference ('/apex/AddICD');
    Test.setcurrentPage(testPage);
    ApexPages.currentPage().getParameters().put('id',cmp.id);
    
     ApexPages.StandardController sc = new ApexPages.standardController(cmp);
     
     Include_Diagnosis_Controller diagnosisinfo = new Include_Diagnosis_Controller(sc) ;
     diagnosisinfo.selectedDiagnosisCode = '45372';
     diagnosisinfo.selectedDiangnosisType= 'ICD9';
     diagnosisinfo.selectedLongDesc= 'Chronic venous embolism and thrombosis of deep veins of upper extremity';
     
     ICD_Diagnosis_In__c diagnosisinformation = marketingDataUtils.creatediagnosisinformation(cmp.id, diagnosis.id);
     
     diagnosisinfo.searchLocation();
    diagnosisinfo.selectAll= true;
     diagnosisinfo.getsearchResult();
    
     
   }
   public static testmethod void Add_diagnosistestmethod2()
 {
 boolean selectAll=false;
boolean flag = true;

campaign cmp = marketingDataUtils.CreateCampaign();

ICD_Diagnosis__c  diagnosis = marketingDataUtils.creatediagnosis();



Include_Diagnosis_Controller.WrapSearchResult wrap = new Include_Diagnosis_Controller.WrapSearchResult(diagnosis,flag);
pagereference testpage = new pagereference ('/apex/AddICD');
    Test.setcurrentPage(testPage);
    ApexPages.currentPage().getParameters().put('id',cmp.id);
    
     ApexPages.StandardController sc = new ApexPages.standardController(cmp);
     
     Include_Diagnosis_Controller diagnosisinfo = new Include_Diagnosis_Controller(sc) ;
     diagnosisinfo.selectedDiagnosisCode = '45372';
     diagnosisinfo.selectedDiangnosisType= 'ICD9';
     diagnosisinfo.selectedLongDesc= 'Chronic venous embolism and thrombosis of deep veins of upper extremity';
     
     ICD_Diagnosis_In__c diagnosisinformation = marketingDataUtils.creatediagnosisinformation(cmp.id, diagnosis.id);
     
     diagnosisinfo.searchLocation();
    // diagnosisinfo.selectAll= true;
     diagnosisinfo.getsearchResult();
     diagnosisinfo.first();
     diagnosisinfo.last();
     diagnosisinfo.previous();
     diagnosisinfo.next();
     diagnosisinfo.selectAll= False;
     diagnosisinfo.masterSelectAll=True;
     diagnosisinfo.saveDemographicServiceArea();
     diagnosisinfo.cancel();
     diagnosisinfo.clearSearch();
   }
    public static testmethod void Add_diagnosistestmethod3()
 {
 boolean selectAll=false;
 boolean flag = False;
 set<Integer> visitedPage= Null;
campaign cmp = marketingDataUtils.CreateCampaign();

ICD_Diagnosis__c  diagnosis = marketingDataUtils.creatediagnosis();
Include_Diagnosis_Controller.WrapSearchResult wrap = new Include_Diagnosis_Controller.WrapSearchResult(diagnosis,flag);
pagereference testpage = new pagereference ('/apex/AddICD');
    Test.setcurrentPage(testPage);
    ApexPages.currentPage().getParameters().put('id',cmp.id);
    ApexPages.StandardController sc = new ApexPages.standardController(cmp);  
     Include_Diagnosis_Controller diagnosisinfo = new Include_Diagnosis_Controller(sc) ;
     diagnosisinfo.selectedDiangnosisType= 'ICD9';     
     ICD_Diagnosis_In__c diagnosisinformation = marketingDataUtils.creatediagnosisinformation(cmp.id, diagnosis.id);
     
     diagnosisinfo.searchLocation();
     diagnosisinfo.getsearchResult();
     diagnosisinfo.selectAll= true;
     boolean isCalloutEventTypeDelete=true;     
     diagnosisinfo.first();
     diagnosisinfo.last();
     diagnosisinfo.previous();
     diagnosisinfo.next();
     diagnosisinfo.saveDemographicServiceArea();
     diagnosisinfo.quickSave();
     diagnosisinfo.cancel();
     diagnosisinfo.clearSearch();
   }
   
     public static testmethod void Add_diagnosistestmethod4()
 {
 boolean selectAll=false;
 boolean flag = False;
 set<Integer> visitedPage= Null;
campaign cmp = marketingDataUtils.CreateCampaign();

ICD_Diagnosis__c  diagnosis = marketingDataUtils.creatediagnosis();
Include_Diagnosis_Controller.WrapSearchResult wrap = new Include_Diagnosis_Controller.WrapSearchResult(diagnosis,flag);
wrap.index=2;

pagereference testpage = new pagereference ('/apex/AddICD');
    Test.setcurrentPage(testPage);
    ApexPages.currentPage().getParameters().put('id',cmp.id);
    ApexPages.StandardController sc = new ApexPages.standardController(cmp);  
     Include_Diagnosis_Controller diagnosisinfo = new Include_Diagnosis_Controller(sc) ;
     diagnosisinfo.selectedDiangnosisType= '';  
     diagnosisinfo.selectedDiagnosisCode='';
     diagnosisinfo.selectedLongDesc='';
     ICD_Diagnosis_In__c diagnosisinformation = marketingDataUtils.creatediagnosisinformation(cmp.id, diagnosis.id);
     
     diagnosisinfo.searchLocation();
     //diagnosisinfo.getsearchResult();
     //diagnosisinfo.selectAll= true;
     boolean isCalloutEventTypeDelete=true;     
     //diagnosisinfo.first();
     //diagnosisinfo.last();
     //diagnosisinfo.previous();
     //diagnosisinfo.next();
     diagnosisinfo.saveDemographicServiceArea();
     diagnosisinfo.quickSave();
     diagnosisinfo.exclude=false;
     diagnosisinfo.cancel();
     diagnosisinfo.clearSearch();
   }   
   
   public static testmethod void Add_diagnosistestmethod7()
 {
 boolean selectAll=false;
 boolean flag = true;
 set<Integer> visitedPage= null;
campaign cmp = marketingDataUtils.CreateCampaign();

ICD_Diagnosis__c  diagnosis = marketingDataUtils.creatediagnosis();



Include_Diagnosis_Controller.WrapSearchResult wrap = new Include_Diagnosis_Controller.WrapSearchResult(diagnosis,flag);
pagereference testpage = new pagereference ('/apex/AddICD');
    Test.setcurrentPage(testPage);
    ApexPages.currentPage().getParameters().put('id',cmp.id);
    
     ApexPages.StandardController sc = new ApexPages.standardController(cmp);
     
     Include_Diagnosis_Controller diagnosisinfo = new Include_Diagnosis_Controller(sc) ;
     diagnosisinfo.selectedDiagnosisCode = '';
     diagnosisinfo.selectedDiangnosisType= 'ICD10';
     diagnosisinfo.selectedLongDesc= '';
     
     ICD_Diagnosis_In__c diagnosisinformation = marketingDataUtils.creatediagnosisinformation(cmp.id, diagnosis.id);
     
     diagnosisinfo.searchLocation();
     diagnosisinfo.selectAll= true;
     diagnosisinfo.masterSelectAll= true;
     //diagnosisinfo.getsearchResult();
     diagnosisinfo.showSearchResult= true;
     boolean isCalloutEventTypeDelete=true;     
     //diagnosisinfo.first();
     //diagnosisinfo.last();
     //diagnosisinfo.previous();
     //diagnosisinfo.next();
     diagnosisinfo.saveDemographicServiceArea();
     diagnosisinfo.quickSave();
     diagnosisinfo.cancel();
     diagnosisinfo.clearSearch();
     
   }
   
    public static testmethod void Add_diagnosistestmethod5()
 {
 boolean selectAll=false;
 boolean flag = true;
 set<Integer> visitedPage= null;
campaign cmp = marketingDataUtils.CreateCampaign();

ICD_Diagnosis__c  diagnosis = marketingDataUtils.creatediagnosis();



Include_Diagnosis_Controller.WrapSearchResult wrap = new Include_Diagnosis_Controller.WrapSearchResult(diagnosis,flag);
pagereference testpage = new pagereference ('/apex/AddICD');
    Test.setcurrentPage(testPage);
    ApexPages.currentPage().getParameters().put('id',cmp.id);
    
     ApexPages.StandardController sc = new ApexPages.standardController(cmp);
     
     Include_Diagnosis_Controller diagnosisinfo = new Include_Diagnosis_Controller(sc) ;
     diagnosisinfo.selectedDiagnosisCode = '45372';
     diagnosisinfo.selectedDiangnosisType= 'ICD9';
     diagnosisinfo.selectedLongDesc= 'Chronic venous embolism and thrombosis of deep veins of upper extremity';
     
     ICD_Diagnosis_In__c diagnosisinformation = marketingDataUtils.creatediagnosisinformation(cmp.id, diagnosis.id);
     
     diagnosisinfo.searchLocation();
     diagnosisinfo.selectAll= false;
     diagnosisinfo.masterSelectAll= true;
     diagnosisinfo.getsearchResult();
     diagnosisinfo.showSearchResult= false;
     boolean isCalloutEventTypeDelete=false;     
     diagnosisinfo.first();
     diagnosisinfo.last();
     diagnosisinfo.previous();
     diagnosisinfo.next();
     diagnosisinfo.exclude=true;
     diagnosisinfo.saveDemographicServiceArea();
     diagnosisinfo.quickSave();
     diagnosisinfo.cancel();
     diagnosisinfo.clearSearch();
     
   }
   }
@istest
public class AddLocation_ByServiceArea_Test
{
    public static testmethod void Addlocationtestmethod()
     {
        boolean selectAll=false;
        boolean flag = true;
        campaign cmp = marketingDataUtils.CreateCampaign();
        
        Location__c loc= marketingDataUtils.createlocation();
        Campaign_Location__c loc1 =    marketingDataUtils.createLocationInformation(cmp.id, loc.id);

        map<id,Location__c> locmap = new map<id,Location__c>([SELECT Hospital__c,Market__c,Region__c  FROM Location__c WHERE ID=:Loc.id]);
        AddLocation_ByServiceArea_Controller.WrapSearchResult wrap = new AddLocation_ByServiceArea_Controller.WrapSearchResult(loc,flag);
        pagereference testpage = new pagereference ('/apex/AddLocation_ByServiceArea');
        Test.setcurrentPage(testPage);
        ApexPages.currentPage().getParameters().put('id',cmp.id); 
        ApexPages.StandardController sc = new ApexPages.standardController(cmp);
        AddLocation_ByServiceArea_Controller location = new AddLocation_ByServiceArea_Controller(sc) ;       
        location.selectedZipCode ='22222222';
        location.selectedRegion = 'Texas';
        location.selectedMarket = 'Dellas';
        location.selectedHospital = 'ABRAZO ARIZONA HEART HOSPITAL';
        list<SelectOption> sa=new list<SelectOption>();
        sa.add(new SelectOption('test','PSA'));
        sa.add(new SelectOption('SSA','SSA'));
        sa.add(new SelectOption('TSASSA','TSA'));
        location.selectedServiceArea=sa;
        location.handleExistingRecords(locmap);
        location.preparePiclistFields();
        location.searchLocation();
        location.selectAll= true;
        location.masterSelectAll= False;
        location.getsearchResult();
        location.first();
        location.last();
        location.previous();
        location.next();
        location.selectAll= true;
        location.handleSeletedLocation();
        location.saveDemographicServiceArea();
        location.quickSave();
        system.debug('location&&&&'+location);
        location.cancel();
        //location.saveServiceArea();
   }
     
 public static testmethod void Addlocationtestmethod1()
 {
        boolean selectAll=False;
        boolean flag = True;
        //boolean showSearchResult=false;
        set<Integer> visitedPage;
        campaign cmp = marketingDataUtils.CreateCampaign();  
        Location__c loc= marketingDataUtils.createlocation();
        AddLocation_ByServiceArea_Controller.WrapSearchResult wrap = new AddLocation_ByServiceArea_Controller.WrapSearchResult(loc,flag);
        
        pagereference testpage = new pagereference ('/apex/AddLocation_ByServiceArea');
        Test.setcurrentPage(testPage);
        ApexPages.currentPage().getParameters().put('id',cmp.id);
        ApexPages.StandardController sc = new ApexPages.standardController(cmp);
        AddLocation_ByServiceArea_Controller location = new AddLocation_ByServiceArea_Controller(sc) ;
        location.selectedZipCode ='22222222';
        location.selectedRegion = 'Texas';
        location.selectedMarket = 'Dellas';
        location.selectedHospital = 'Atlanta Medical Center';
        list<SelectOption> sa=new list<SelectOption>();
        sa.add(new SelectOption('PSA','PSA'));
        sa.add(new SelectOption('SSA','SSA'));
        sa.add(new SelectOption('TSASSA','TSA'));
        location.selectedServiceArea=sa;  
        
        location.searchLocation();
        location.selectAll= True;
        location.getsearchResult();
        
    }
    public static testmethod void Addlocationtestmethod2()
 {
         
        boolean selectAll=false;
        boolean flag = true;
        campaign cmp = marketingDataUtils.CreateCampaign();
        
        Location__c loc= marketingDataUtils.createlocation();
        Campaign_Location__c loc1 = marketingDataUtils.createLocationInformation(cmp.id, loc.id);

        AddLocation_ByServiceArea_Controller.WrapSearchResult wrap = new AddLocation_ByServiceArea_Controller.WrapSearchResult(loc,flag);
        pagereference testpage = new pagereference ('/apex/AddLocation_ByServiceArea');
        Test.setcurrentPage(testPage);
        ApexPages.currentPage().getParameters().put('id',cmp.id);
        
        ApexPages.StandardController sc = new ApexPages.standardController(cmp);
        
        AddLocation_ByServiceArea_Controller location = new AddLocation_ByServiceArea_Controller(sc) ;
        
        location.selectedZipCode ='22222222';
        location.selectedRegion = 'Texas';
        location.selectedMarket = 'Dellas';
        location.selectedHospital = 'ABRAZO ARIZONA HEART HOSPITAL';
        list<SelectOption> sa=new list<SelectOption>();
        sa.add(new SelectOption('PSA','PSA'));
        sa.add(new SelectOption('SSA','SSA'));
        sa.add(new SelectOption('TSASSA','TSA'));
        location.selectedServiceArea=sa;  
        location.preparePiclistFields();
        location.searchLocation();
        location.getsearchResult(); 
        location.first();
        location.last();
        location.previous();
        location.next();
        location.selectAll= False;
        location.masterSelectAll=True;
        location.handleSeletedLocation();
        location.saveDemographicServiceArea();
        system.debug('location&&&&'+location);
        location.cancel();
   
   }
   
   
    public static testmethod void Test_searchLocation1()
    {
        boolean selectAll=false;
        boolean flag = true;
        campaign cmp = marketingDataUtils.CreateCampaign();
        
        Location__c loc= marketingDataUtils.createlocation();
        Campaign_Location__c loc1 =    marketingDataUtils.createLocationInformation(cmp.id, loc.id);
      
        map<id,Location__c> locmap = new map<id,Location__c>([SELECT Hospital__c,Market__c,Region__c  FROM Location__c WHERE ID=:Loc.id]);
        AddLocation_ByServiceArea_Controller.WrapSearchResult wrap = new AddLocation_ByServiceArea_Controller.WrapSearchResult(loc,flag);
        
        pagereference testpage = new pagereference ('/apex/AddLocation_ByServiceArea');
        Test.setcurrentPage(testPage);
        ApexPages.currentPage().getParameters().put('id',cmp.id); 
        ApexPages.StandardController sc = new ApexPages.standardController(cmp);
        AddLocation_ByServiceArea_Controller location = new AddLocation_ByServiceArea_Controller(sc) ;       
        location.selectedZipCode ='';
        location.selectedRegion = '';
        location.selectedMarket = '';
        location.selectedHospital = '';
        list<SelectOption> sa=new list<SelectOption>();
        
        location.selectedServiceArea=sa;
        
        location.searchLocation();
        location.selectAll= true;
        

    }
    
     public static testmethod void Test_saveServiceArea1()
     {
          boolean selectAll=false;
        boolean flag = true;
        campaign cmp = marketingDataUtils.CreateCampaign();
        
        Location__c loc= marketingDataUtils.createlocation();
        Campaign_Location__c loc1 =    marketingDataUtils.createLocationInformation(cmp.id, loc.id);

        map<id,Location__c> locmap = new map<id,Location__c>([SELECT Hospital__c,Market__c,Region__c  FROM Location__c WHERE ID=:Loc.id]);
        AddLocation_ByServiceArea_Controller.WrapSearchResult wrap = new AddLocation_ByServiceArea_Controller.WrapSearchResult(loc,flag);
        wrap.isSelected=false;
        pagereference testpage = new pagereference ('/apex/AddLocation_ByServiceArea');
        Test.setcurrentPage(testPage);
        ApexPages.currentPage().getParameters().put('id',cmp.id); 
        ApexPages.StandardController sc = new ApexPages.standardController(cmp);
        AddLocation_ByServiceArea_Controller location = new AddLocation_ByServiceArea_Controller(sc) ;       
        location.selectedZipCode ='22222222';
        location.selectedRegion = 'Texas';
        location.selectedMarket = 'Dellas';
        location.selectedHospital = 'ABRAZO ARIZONA HEART HOSPITAL';
        list<SelectOption> sa=new list<SelectOption>();
        sa.add(new SelectOption('test','PSA'));
        sa.add(new SelectOption('SSA','SSA'));
        sa.add(new SelectOption('TSASSA','TSA'));
        location.selectedServiceArea=sa;  
        location.handleExistingRecords(locmap);
        location.preparePiclistFields();
        location.searchLocation();
        location.selectAll= False;
        location.masterSelectAll= True;
        location.getsearchResult();
        location.first();
        location.last();
        location.previous();
        location.next();
        location.selectAll= true;
        location.handleSeletedLocation();
        location.saveDemographicServiceArea();
        location.quickSave();
        system.debug('location&&&&'+location);
        location.cancel();   
        //location.saveServiceArea();
               
   }
   
    
 }
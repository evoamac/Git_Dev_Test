@istest
private  class Geographic_ByRadius_Test{
  public static testmethod void Geographic_ByRadius_method(){

 boolean selectAll=false;
 boolean flag = true;
 
 
campaign cmp = marketingDataUtils.CreateCampaign();
Location__c loactn = marketingDataUtils.createlocation();
 Geographic__c geo = marketingDataUtils.createGeographic();
 
 
 Geographic_Info_Information__c geoinfo =    marketingDataUtils.createGeographicInfo(cmp.id, geo.id);
 
 
 pagereference testpage = new pagereference ('/apex/Geography_By_Radius');
        Test.setcurrentPage(testPage);
      ApexPages.currentPage().getParameters().put('id',cmp.id);
    ApexPages.StandardController sc = new ApexPages.standardController(cmp);
    
     GeographicByRadius geography = new GeographicByRadius(sc) ;
     GeographicByRadius.WrapSearchResult wp = new GeographicByRadius.WrapSearchResult(geo,flag);
     list<GeographicByRadius.WrapSearchResult> lstwrap= new list<GeographicByRadius.WrapSearchResult>();
     lstwrap.add(wp);
            Geography.geo=geo;
            Geography.showSearchResult=True;
            Geography.pageSize=10;
            Geography.noOfRecords=1;
            Geography.masterSelectAll=False;
            Geography.getlisthospital();
            Geography.selectedHospital= 'ABRAZO ARIZONA HEART HOSPITAL';
            Geography.selectedMiles='50';
            Geography.showSearchResult=true;
            Geography.searchLocation();
            Geography.getsearchResult();
       system.debug('&&&&first'+Geography);
            Geography.selectAll=true;
            Geography.first();
            system.debug('&&&&first'+Geography);
            Geography.last();
            Geography.previous();
            Geography.next();
            Geography.saveDemographicServiceArea();
            Geography.quickSave();
            Geography.cancel();
            

          }
          
       public static testmethod void Geographic_ByRadius_method1(){

 boolean selectAll=false;
 boolean flag = false;
 
 
 campaign cmp = marketingDataUtils.CreateCampaign();
 Location__c loactn = marketingDataUtils.createlocation();
 Geographic__c geo = marketingDataUtils.createGeographic();
 Geographic_Info_Information__c geoinfo =    marketingDataUtils.createGeographicInfo(cmp.id, geo.id);
 GeographicByRadius.WrapSearchResult wp = new GeographicByRadius.WrapSearchResult(geo,flag);
 pagereference testpage = new pagereference ('/apex/Geography_By_Radius');
        Test.setcurrentPage(testPage);
      ApexPages.currentPage().getParameters().put('id',cmp.id);
    ApexPages.StandardController sc = new ApexPages.standardController(cmp);
    
     GeographicByRadius geography = new GeographicByRadius(sc) ;
            Geography.geo=geo;
            Geography.showSearchResult=True;
            Geography.pageSize=10;
            Geography.noOfRecords=1;
            Geography.masterSelectAll=False;
            Geography.getlisthospital();
            Geography.selectedHospital= 'ABRAZO ARIZONA HEART HOSPITAL';
            Geography.selectedMiles='50';
            Geography.showSearchResult=true;
            Geography.searchLocation();           
            Geography.getsearchResult();
       system.debug('&&&&first'+Geography);
            Geography.selectAll=true;
            Geography.first();
            system.debug('&&&&first'+Geography);
            Geography.last();
            Geography.previous();
            Geography.next();
            Geography.saveDemographicServiceArea();
      
            Geography.cancel();  
          }   
          
       public static testmethod void Geographic_ByRadius_method2(){

 boolean selectAll=false;
 boolean flag = true;
 
 
campaign cmp = marketingDataUtils.CreateCampaign();
Location__c loactn = marketingDataUtils.createlocation();
 Geographic__c geo = marketingDataUtils.createGeographic();
 
 
 Geographic_Info_Information__c geoinfo =    marketingDataUtils.createGeographicInfo(cmp.id, geo.id);
 
 
 pagereference testpage = new pagereference ('/apex/Geography_By_Radius');
        Test.setcurrentPage(testPage);
      ApexPages.currentPage().getParameters().put('id',cmp.id);
    ApexPages.StandardController sc = new ApexPages.standardController(cmp);
    
     GeographicByRadius geography = new GeographicByRadius(sc) ;
     GeographicByRadius.WrapSearchResult wp = new GeographicByRadius.WrapSearchResult(geo,flag);
     list<GeographicByRadius.WrapSearchResult> lstwrap= new list<GeographicByRadius.WrapSearchResult>();
     lstwrap.add(wp);
            Geography.geo=geo;
            Geography.showSearchResult=True;
            Geography.pageSize=10;
            Geography.noOfRecords=1;
            Geography.getlisthospital();
            Geography.selectedHospital= 'ABRAZO ARIZONA HEART HOSPITAL';
            Geography.selectedMiles='50';
            Geography.showSearchResult=true;
            Geography.searchLocation();
            Geography.selectAll=true;
            Geography.getsearchResult();
       system.debug('&&&&first'+Geography);
            Geography.first();
            system.debug('&&&&first'+Geography);
            Geography.last();
            Geography.previous();
            Geography.next();
            Geography.masterSelectAll=True;
            Geography.selectAll=False;
            Geography.saveDemographicServiceArea();
      
            Geography.cancel();
            

          }  
 public static testmethod void Geographic_ByRadius_method3(){

 boolean selectAll=false;
 boolean flag = true;
 
 
campaign cmp = marketingDataUtils.CreateCampaign();
Location__c loactn = marketingDataUtils.createlocation();
 Geographic__c geo = marketingDataUtils.createGeographic();
 
 
 Geographic_Info_Information__c geoinfo =    marketingDataUtils.createGeographicInfo(cmp.id, geo.id);
 
 
 pagereference testpage = new pagereference ('/apex/Geography_By_Radius');
        Test.setcurrentPage(testPage);
      ApexPages.currentPage().getParameters().put('id',cmp.id);
    ApexPages.StandardController sc = new ApexPages.standardController(cmp);
    
     GeographicByRadius geography = new GeographicByRadius(sc) ;
     GeographicByRadius.WrapSearchResult wp = new GeographicByRadius.WrapSearchResult(geo,flag);
     wp.index=5;
     list<GeographicByRadius.WrapSearchResult> lstwrap= new list<GeographicByRadius.WrapSearchResult>();
     lstwrap.add(wp);
            Geography.geo=geo;
            Geography.showSearchResult=True;
            Geography.pageSize=10;
            Geography.noOfRecords=1;
            Geography.getlisthospital();
            Geography.selectedHospital= '';
            Geography.selectedMiles='';
            Geography.showSearchResult=true;
            Geography.searchLocation();
            Geography.selectAll=true;
             boolean isCalloutEventTypeDelete=true;    
            //Geography.getsearchResult();
          system.debug('&&&&first'+Geography);
            //Geography.first();
            system.debug('&&&&first'+Geography);
            //Geography.last();
            //Geography.previous();
            //Geography.next();
            Geography.masterSelectAll=false;
            Geography.saveDemographicServiceArea();
            Geography.cancel();
            

          }            
          
   public static testmethod void Geographic_ByRadius_method4(){

 boolean selectAll=false;
 boolean flag = true;
 set<Integer> visitedPage= null;
 
campaign cmp = marketingDataUtils.CreateCampaign();
Location__c loactn = marketingDataUtils.createlocation();
 Geographic__c geo = marketingDataUtils.createGeographic();
 
 
 Geographic_Info_Information__c geoinfo =    marketingDataUtils.createGeographicInfo(cmp.id, geo.id);
 
 
 pagereference testpage = new pagereference ('/apex/Geography_By_Radius');
        Test.setcurrentPage(testPage);
      ApexPages.currentPage().getParameters().put('id',cmp.id);
    ApexPages.StandardController sc = new ApexPages.standardController(cmp);
    
     GeographicByRadius geography = new GeographicByRadius(sc) ;
     GeographicByRadius.WrapSearchResult wp = new GeographicByRadius.WrapSearchResult(geo,flag);
     wp.index=5;
     list<GeographicByRadius.WrapSearchResult> lstwrap= new list<GeographicByRadius.WrapSearchResult>();
     lstwrap.add(wp);
            Geography.geo=geo;
            Geography.showSearchResult=false;
            Geography.pageSize=10;
            Geography.noOfRecords=1;
            Geography.selectedbutton='Save';
            Geography.getlisthospital();
            Geography.selectedHospital= 'ABRAZO ARIZONA HEART HOSPITAL';
            Geography.selectedMiles='10';
            Geography.showSearchResult=false;
            Geography.searchLocation();
            Geography.selectAll=false;
            Geography.getlisthospital();
            Geography.masterSelectAll=true;
            boolean isCalloutEventTypeDelete=false;    
            Geography.getsearchResult();
          system.debug('&&&&first'+Geography);
            Geography.first();
            system.debug('&&&&first'+Geography);
            Geography.last();
            Geography.previous();
            Geography.next();
            Geography.saveDemographicServiceArea();
            Geography.cancel();
            

          }                
                             
}
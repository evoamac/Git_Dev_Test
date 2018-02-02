@istest
    public class GeographicController_Test
  {   
        public static testmethod void GeographicTestMethod()
     { 
            Campaign cmp = marketingDataUtils.CreateCampaign();
            Geographic__c geo = marketingDataUtils.createGeographic();  
            Geographic_Info_Information__c geoinfo =    marketingDataUtils.createGeographicInfo(cmp.id, geo.id);       
                boolean flag = true;
                CBSA_values__c cb = new CBSA_values__c ();
                cb.Name= 'test';
                  insert cb;
                    pagereference testpage = new pagereference ('/apex/AddGeography');
                    Test.setcurrentPage(testPage);
                       GeographicController.WrapSearchResult wrap = new GeographicController.WrapSearchResult(geo,flag);
                        ApexPages.currentPage().getParameters().put('id',cmp.id);
                        ApexPages.StandardController sc = new ApexPages.standardController(cmp);
                            GeographicController Geography = new GeographicController(sc) ;              
                            GeographicByRadius.WrapSearchResult wp = new GeographicByRadius.WrapSearchResult(geo,flag);
                                Geography.selectAll=True; 
                                System.debug('selectAll@@@@@@'+Geography);
                                Geography.selectedState= 'AK';                                
                                Geography.geo=geo;
                                Geography.searchLocation();
                                Geography.selectAll=True;
                                Geography.masterSelectAll=True;
                                Geography.getsearchResult();
        System.debug('selectAll@@@@@@'+Geography);
                                Geography.quickSave();
                                Geography.first();
                                Geography.last();
                                Geography.previous();
                                Geography.next();
         System.debug('selectAll@@@@@@'+Geography);
                                Geography.saveDemographicServiceArea();
         System.debug('selectAll@@@@@@'+Geography);
                                Geography.cancel();
         
    }
  
  public static testmethod void GeographicTestMethod1()
     { 
            Campaign cmp = marketingDataUtils.CreateCampaign();
            Geographic__c geo = marketingDataUtils.createGeographic();  
            Geographic_Info_Information__c geoinfo =    marketingDataUtils.createGeographicInfo(cmp.id, geo.id);       
                boolean flag = true;
                CBSA_values__c cb = new CBSA_values__c ();
                cb.Name= 'test';
                  insert cb;
                    pagereference testpage = new pagereference ('/apex/AddGeography');
                    Test.setcurrentPage(testPage);
                     GeographicController.WrapSearchResult wrap = new GeographicController.WrapSearchResult(geo,flag);
                        ApexPages.currentPage().getParameters().put('id',cmp.id);
                        ApexPages.StandardController sc = new ApexPages.standardController(cmp);
                            GeographicController Geography = new GeographicController(sc) ;              
                            GeographicByRadius.WrapSearchResult wp = new GeographicByRadius.WrapSearchResult(geo,flag);
                                Geography.selectAll=True;    
                                Geography.selectedCounty = 'ANCHORAGE';
                                Geography.geo=geo;
                                Geography.searchLocation();
                                Geography.getsearchResult();
                                Geography.first();
                                Geography.last();
                                Geography.previous();
                                Geography.next();
                                Geography.saveDemographicServiceArea();
                                Geography.cancel();
       }
   public static testmethod void GeographicTestMethod2()
     { 
            Campaign cmp = marketingDataUtils.CreateCampaign();
            Geographic__c geo = marketingDataUtils.createGeographic();  
            Geographic_Info_Information__c geoinfo =    marketingDataUtils.createGeographicInfo(cmp.id, geo.id);       
                boolean flag = true;
                CBSA_values__c cb = new CBSA_values__c ();
                cb.Name= 'test';
                  insert cb;
                    pagereference testpage = new pagereference ('/apex/AddGeography');
                    Test.setcurrentPage(testPage);
                     GeographicController.WrapSearchResult wrap = new GeographicController.WrapSearchResult(geo,flag);

                        ApexPages.currentPage().getParameters().put('id',cmp.id);
                        ApexPages.StandardController sc = new ApexPages.standardController(cmp);
                            GeographicController Geography = new GeographicController(sc) ;              
                            GeographicByRadius.WrapSearchResult wp = new GeographicByRadius.WrapSearchResult(geo,flag);
                                Geography.selectAll=True;    
                                Geography.selectedCBSA = 'Anchorage, AK';                                
                                Geography.geo=geo;
                                Geography.searchLocation();
                                Geography.getsearchResult();
                                Geography.first();
                                Geography.last();
                                Geography.previous();
                             
                                Geography.next();
                              
                                Geography.saveDemographicServiceArea();
                             
                                Geography.cancel();
       }     
    public static testmethod void GeographicTestMethod3()
     { 
            Campaign cmp = marketingDataUtils.CreateCampaign();
            Geographic__c geo = marketingDataUtils.createGeographic();  
            Geographic_Info_Information__c geoinfo =    marketingDataUtils.createGeographicInfo(cmp.id, geo.id);       
                boolean flag = true;
                CBSA_values__c cb = new CBSA_values__c ();
                cb.Name= 'test';
                  insert cb;
                    pagereference testpage = new pagereference ('/apex/AddGeography');
                    Test.setcurrentPage(testPage);
                        ApexPages.currentPage().getParameters().put('id',cmp.id);
                        ApexPages.StandardController sc = new ApexPages.standardController(cmp);
                        GeographicController.WrapSearchResult wrap = new GeographicController.WrapSearchResult(geo,flag);

                            GeographicController Geography = new GeographicController(sc) ;              
                            GeographicByRadius.WrapSearchResult wp = new GeographicByRadius.WrapSearchResult(geo,flag);
                                Geography.selectAll=True;    
                                Geography.selectedState= 'AK';
                                Geography.selectedCounty = 'ANCHORAGE';                                
                                Geography.geo=geo;
                                Geography.searchLocation();
                                Geography.getsearchResult();
                                Geography.first();
                                Geography.last();
                                Geography.previous();
                                Geography.next();
                                Geography.saveDemographicServiceArea();
                                Geography.cancel();
       }
     public static testmethod void GeographicTestMethod4()
     { 
            Campaign cmp = marketingDataUtils.CreateCampaign();
            Geographic__c geo = marketingDataUtils.createGeographic();
         Campaign newCampaign1 = new Campaign();
            newCampaign1.Name='NewTestCampaign';
            newCampaign1.Service_Line__c='Burn';
            newCampaign1.Audience_Region__c='Texas';
            newCampaign1.Channel__c='Direct Mail';
        
              insert newCampaign1;
          Geographic_Info_Information__c geoinfo = new Geographic_Info_Information__c();
           geoinfo.Campaign__c=newCampaign1.id;
           geoinfo.Geographic_Info__c=geo.id;
              insert geoinfo;
           // Geographic_Info_Information__c geoinfo =    marketingDataUtils.createGeographicInfo(cmp.id, geo.id);       
                boolean flag = true;
                CBSA_values__c cb = new CBSA_values__c ();
                cb.Name= 'test';
                  insert cb;
                    pagereference testpage = new pagereference ('/apex/AddGeography');
                    Test.setcurrentPage(testPage);
                        ApexPages.currentPage().getParameters().put('id',cmp.id);
                        ApexPages.StandardController sc = new ApexPages.standardController(cmp);
                        GeographicController.WrapSearchResult wrap = new GeographicController.WrapSearchResult(geo,flag);
                                 
                            GeographicController Geography = new GeographicController(sc) ;              
                            GeographicByRadius.WrapSearchResult wp = new GeographicByRadius.WrapSearchResult(geo,flag);
                               
                                Geography.selectAll=True;    
                                Geography.selectedState= 'AK';
                                Geography.selectedCounty = 'ANCHORAGE';                                
                                Geography.geo=geo;
                                Geography.SelectAll=True;
                                Geography.masterSelectAll=True;
         system.debug('geographymasterSelectAll****' +Geography);
                                Geography.searchLocation();
                                Geography.getsearchResult();
                                Geography.first();
                                Geography.last();
                                Geography.previous();
                                Geography.next();
                                Geography.saveDemographicServiceArea();
                                Geography.cancel();
       }
     public static testmethod void GeographicTestMethod5()
     { 
            Campaign cmp = marketingDataUtils.CreateCampaign();
            Geographic__c geo = marketingDataUtils.createGeographic();  
            Geographic_Info_Information__c geoinfo =    marketingDataUtils.createGeographicInfo(cmp.id, geo.id);       
                boolean flag = true;
                boolean SelectAll= False;
                CBSA_values__c cb = new CBSA_values__c ();
                cb.Name= 'test';
                  insert cb;
                    pagereference testpage = new pagereference ('/apex/AddGeography');
                    Test.setcurrentPage(testPage);
                       GeographicController.WrapSearchResult wrap = new GeographicController.WrapSearchResult(geo,flag);
                        ApexPages.currentPage().getParameters().put('id',cmp.id);
                        ApexPages.StandardController sc = new ApexPages.standardController(cmp);
                            GeographicController Geography = new GeographicController(sc) ;              
                            GeographicByRadius.WrapSearchResult wp = new GeographicByRadius.WrapSearchResult(geo,flag);
              
                                Geography.selectedState= 'AK';
                                Geography.geo=geo;
                                Geography.searchLocation();
                                Geography.selectAll=False;
                                Geography.masterSelectAll=True;
                                Geography.getsearchResult();
                                Geography.first();
                                Geography.last();
                                Geography.previous();
                                Geography.next();
                                Geography.saveDemographicServiceArea();
                                Geography.cancel();
         
    }
      public static testmethod void GeographicTestMethod6()
     { 
            Campaign cmp = marketingDataUtils.CreateCampaign();
            Geographic__c geo = marketingDataUtils.createGeographic();  
            Geographic_Info_Information__c geoinfo =    marketingDataUtils.createGeographicInfo(cmp.id, geo.id);       
                boolean flag = False;
                CBSA_values__c cb = new CBSA_values__c ();
                cb.Name= 'test';
                  insert cb;
                    pagereference testpage = new pagereference ('/apex/AddGeography');
                    Test.setcurrentPage(testPage);
                       GeographicController.WrapSearchResult wrap = new GeographicController.WrapSearchResult(geo,flag);
                        ApexPages.currentPage().getParameters().put('id',cmp.id);
                        ApexPages.StandardController sc = new ApexPages.standardController(cmp);
                            GeographicController Geography = new GeographicController(sc) ;              
                            GeographicByRadius.WrapSearchResult wp = new GeographicByRadius.WrapSearchResult(geo,flag);
                                Geography.selectAll=True; 
                                System.debug('selectAll@@@@@@'+Geography);
                                Geography.selectedState= 'AK'; 
                                Geography.selectedCBSA='Anchorage, AK';
                                Geography.selectedCounty='ANCHORAGE';                               
                                Geography.geo=geo;
                                Geography.searchLocation();
                                Geography.selectAll=True;
                                Geography.masterSelectAll=True;
                                //Geography.getsearchResult();
        System.debug('selectAll@@@@@@'+Geography);
                                Geography.quickSave();
                                //Geography.first();
                               // Geography.last();
                                //Geography.previous();
                               // Geography.next();
         System.debug('selectAll@@@@@@'+Geography);
                                Geography.saveDemographicServiceArea();
         System.debug('selectAll@@@@@@'+Geography);
                                Geography.cancel();
         
    }
    
    public static testmethod void GeographicTestMethod7()
     { 
            Campaign cmp = marketingDataUtils.CreateCampaign();
            Geographic__c geo = marketingDataUtils.createGeographic();  
            Geographic_Info_Information__c geoinfo =    marketingDataUtils.createGeographicInfo(cmp.id, geo.id);       
                boolean flag = False;
                CBSA_values__c cb = new CBSA_values__c ();
                cb.Name= 'test';
                  insert cb;
                    pagereference testpage = new pagereference ('/apex/AddGeography');
                    Test.setcurrentPage(testPage);
                       GeographicController.WrapSearchResult wrap = new GeographicController.WrapSearchResult(geo,flag);
                        ApexPages.currentPage().getParameters().put('id',cmp.id);
                        ApexPages.StandardController sc = new ApexPages.standardController(cmp);
                            GeographicController Geography = new GeographicController(sc) ;              
                            GeographicByRadius.WrapSearchResult wp = new GeographicByRadius.WrapSearchResult(geo,flag);
                                Geography.selectAll=True; 
                                System.debug('selectAll@@@@@@'+Geography);
                                Geography.selectedState= '';   
                                Geography.selectedCBSA='';
                                Geography.selectedCounty='';                     
                                Geography.geo=geo;
                                Geography.searchLocation();
                                Geography.selectAll=True;
                                Geography.masterSelectAll=True;
                               // Geography.getsearchResult();
        System.debug('selectAll@@@@@@'+Geography);
                                Geography.quickSave();
                               // Geography.first();
                                //Geography.last();
                               // Geography.previous();
                                //Geography.next();
         System.debug('selectAll@@@@@@'+Geography);
                                Geography.saveDemographicServiceArea();
         System.debug('selectAll@@@@@@'+Geography);
                                Geography.cancel();
         
    }
  }
@istest
public class CampaignCriteriaGeographies_Test
{
 public static testmethod void CampaignCriteriaMethod()
 {
  campaign cmp = marketingDataUtils.CreateCampaign();
  Location__c Loc = marketingDataUtils.createlocation();
  Campaign_Location__c  cmpLoc = marketingDataUtils.createLocationInformation(cmp.id,loc.id);
      pagereference testpage = new pagereference ('/apex/CampaignCriteria_Geographies');
      Test.setcurrentPage(testPage);    
       ApexPages.StandardController sc = new ApexPages.standardController(cmp);
       CampaignCriteria_GeographiesController CampaignCriteria = new CampaignCriteria_GeographiesController(sc);
          CampaignCriteria.AddBoundaries();
          CampaignCriteria.AddDistances();
          CampaignCriteria.AddServiceAreas();
          CampaignCriteria.BackToCampaign();
          CampaignCriteria.deleteAllGeoBoundaryDistance();
          CampaignCriteria.deleteAllGeoServiceArea();
          CampaignCriteria.hasServiceAreas=True;
 }
 public static testmethod void CampaignCriteriaMethod1()
 {
  campaign cmp = marketingDataUtils.CreateCampaign();
  Geographic__c geography = marketingDataUtils.createGeographic();
  Geographic_Info_Information__c geoinfo = new Geographic_Info_Information__c();
     geoinfo.Campaign__c=cmp.id;
     geoinfo.Geographic_Info__c=geography.id;
     geoinfo.Audience_Search_Type__c='Geography By Boundary';
      insert geoinfo;        
    pagereference testpage = new pagereference ('/apex/CampaignCriteria_Geographies');
    Test.setcurrentPage(testPage);    
    ApexPages.StandardController sc = new ApexPages.standardController(cmp);        
    CampaignCriteria_GeographiesController CampaignCriteria = new CampaignCriteria_GeographiesController(sc);
          CampaignCriteria.AddBoundaries();
          CampaignCriteria.AddDistances();
          CampaignCriteria.AddServiceAreas();
          CampaignCriteria.BackToCampaign();
          CampaignCriteria.deleteAllGeoBoundaryDistance();
          CampaignCriteria.deleteAllGeoServiceArea();
          CampaignCriteria.hasServiceAreas=True;
 }
 public static testmethod void CampaignCriteriaMethod2()
 {
  campaign cmp = marketingDataUtils.CreateCampaign();
  Geographic__c geography = marketingDataUtils.createGeographic();
  Geographic_Info_Information__c geoinfo = new Geographic_Info_Information__c();
     geoinfo.Campaign__c=cmp.id;
     geoinfo.Geographic_Info__c=geography.id;
     geoinfo.Audience_Search_Type__c='Geography By Distance';
      insert geoinfo;         
    pagereference testpage = new pagereference ('/apex/CampaignCriteria_Geographies');
    Test.setcurrentPage(testPage);    
    ApexPages.StandardController sc = new ApexPages.standardController(cmp);        
          CampaignCriteria_GeographiesController CampaignCriteria = new CampaignCriteria_GeographiesController(sc);
          CampaignCriteria.AddBoundaries();
          CampaignCriteria.AddDistances();
          CampaignCriteria.AddServiceAreas();
          CampaignCriteria.BackToCampaign();
          CampaignCriteria.deleteAllGeoBoundaryDistance();
          CampaignCriteria.deleteAllGeoServiceArea();
          CampaignCriteria.hasServiceAreas=True;
 }
}
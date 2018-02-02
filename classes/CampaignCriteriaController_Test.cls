@istest
 public class CampaignCriteriaController_Test{
  public static testmethod void CampaignCriteriaMethod(){
    campaign cmp = marketingDataUtils.CreateCampaign();
    Campaign_Member_Criteria__c cmpmember = marketingDataUtils.createCampaignMemberCriteria(cmp.id);
    pagereference testpage = new pagereference ('/apex/CampaignCriteria');
    CRM_Search_Criteria__c csc = new CRM_Search_Criteria__c();
    csc.CRM_Search_Criteria_Level_1__c = 'By Region';
    csc.CRM_Search_Criteria_Level_2__c = 'By Market';
    csc.CRM_Search_Criteria_Level_3__c = 'By Hospital';
    csc.CRM_Campaign__c = cmp.id;
    insert csc;
    List<RecordType> lstRecType = [select developerName,id from RecordType where sObjectType='CRM_CampaignLocationReferenceData__c' AND developerName = 'Region'];
    if(lstRecType.size()>0) {
        CRM_CampaignLocationReferenceData__c clr = new CRM_CampaignLocationReferenceData__c();
        clr.CRM_Hospital__c = 'ABC';
        clr.CRM_Market__c = 'Dallas';
        clr.CRM_Region__c = 'Dallas Market';
        clr.CRM_IsActive__c = true;
        clr.RecordTypeid = lstRecType[0].id;
        clr.CRM_HospitalCode__c = 'By Hospital'; 
        insert clr;
    }
    
    Test.setcurrentPage(testPage);   
    ApexPages.StandardController sc = new ApexPages.standardController(cmp);
    CampaignCriteriaController criteria = new CampaignCriteriaController(sc);
   }
   public static testmethod void CampaignCriteriaMethod2(){
    campaign cmp = marketingDataUtils.CreateCampaign();
    Campaign_Member_Criteria__c cmpmember = marketingDataUtils.createCampaignMemberCriteria(cmp.id);
    pagereference testpage = new pagereference ('/apex/CampaignCriteria');
    CRM_Search_Criteria__c csc = new CRM_Search_Criteria__c();
    csc.CRM_Search_Criteria_Level_1__c = 'By Distance';
    csc.CRM_Search_Criteria_Level_2__c = 'By Market';
    csc.CRM_Search_Criteria_Level_3__c = 'By Hospital';
    csc.CRM_Campaign__c = cmp.id;
    insert csc;
    List<RecordType> lstRecType = [select developerName,id from RecordType where sObjectType='CRM_CampaignLocationReferenceData__c' AND developerName = 'Region'];
    if(lstRecType.size()>0) {
        CRM_CampaignLocationReferenceData__c clr = new CRM_CampaignLocationReferenceData__c();
        clr.CRM_Hospital__c = 'ABC';
        clr.CRM_Market__c = 'Dallas';
        clr.CRM_Region__c = 'Dallas Market';
        clr.CRM_IsActive__c = true;
        clr.RecordTypeid = lstRecType[0].id;
        clr.CRM_HospitalCode__c = 'By Hospital'; 
        insert clr;
    }
    
    Test.setcurrentPage(testPage);   
    ApexPages.StandardController sc = new ApexPages.standardController(cmp);
    CampaignCriteriaController criteria = new CampaignCriteriaController(sc);
   }
    public static testmethod void CampaignCriteriaMethod3(){
    campaign cmp = marketingDataUtils.CreateCampaign();
    Campaign_Member_Criteria__c cmpmember = marketingDataUtils.createCampaignMemberCriteria(cmp.id);
    pagereference testpage = new pagereference ('/apex/CampaignCriteria');
    CRM_Search_Criteria__c csc = new CRM_Search_Criteria__c();
    csc.CRM_Search_Criteria_Level_1__c = 'By State';
    csc.CRM_Search_Criteria_Level_2__c = 'By Market';
    csc.CRM_Search_Criteria_Level_3__c = 'By Hospital';
    csc.CRM_Campaign__c = cmp.id;
    insert csc;
    List<RecordType> lstRecType = [select developerName,id from RecordType where sObjectType='CRM_CampaignLocationReferenceData__c' AND developerName = 'Region'];
    if(lstRecType.size()>0) {
        CRM_CampaignLocationReferenceData__c clr = new CRM_CampaignLocationReferenceData__c();
        clr.CRM_Hospital__c = 'ABC';
        clr.CRM_Market__c = 'Dallas';
        clr.CRM_Region__c = 'Dallas Market';
        clr.CRM_IsActive__c = true;
        clr.RecordTypeid = lstRecType[0].id;
        clr.CRM_HospitalCode__c = 'By Hospital'; 
        insert clr;
    }
    
    Test.setcurrentPage(testPage);   
    ApexPages.StandardController sc = new ApexPages.standardController(cmp);
    CampaignCriteriaController criteria = new CampaignCriteriaController(sc);
   }
    public static testmethod void CampaignCriteriaMethod4(){
    campaign cmp = marketingDataUtils.CreateCampaign();
    Campaign_Member_Criteria__c cmpmember = marketingDataUtils.createCampaignMemberCriteria(cmp.id);
    pagereference testpage = new pagereference ('/apex/CampaignCriteria');
    CRM_Search_Criteria__c csc = new CRM_Search_Criteria__c();
    csc.CRM_Search_Criteria_Level_1__c = 'By State';
    csc.CRM_Search_Criteria_Level_2__c = 'By Market;By State';
    csc.CRM_Search_Criteria_Level_3__c = 'By Hospital;By Market';
    csc.CRM_Campaign__c = cmp.id;
    insert csc;
    List<RecordType> lstRecType = [select developerName,id from RecordType where sObjectType='CRM_CampaignGeographyReferenceData__c' AND developerName = 'State'];
    if(lstRecType.size()>0) {
        CRM_CampaignGeographyReferenceData__c clr = new CRM_CampaignGeographyReferenceData__c();
        clr.CRM_StateCode__c = 'By Market';
        clr.CRM_IsActive__c = true;
        clr.CRM_CBSA__c = 'By State';
        clr.CRM_County__c = 'By Hospital';
        clr.RecordTypeid = lstRecType[0].id;
        insert clr;
        
        CRM_CampaignGeographyReferenceData__c clr2 = new CRM_CampaignGeographyReferenceData__c();
        clr2.CRM_County__c = 'By Hospital';
        clr2.CRM_CountysStateID__c = clr.id;
        clr2.RecordTypeid = lstRecType[0].id;
        clr.CRM_IsActive__c = true;
        insert clr2;
    }
    
    Test.setcurrentPage(testPage);   
    ApexPages.StandardController sc = new ApexPages.standardController(cmp);
    CampaignCriteriaController criteria = new CampaignCriteriaController(sc);
   }
  }
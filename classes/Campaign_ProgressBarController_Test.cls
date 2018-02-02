@istest
public class Campaign_ProgressBarController_Test{
  
 public static testmethod void Campaign_ProgressBarMethod(){
        Campaign newCampaign = new Campaign();
        newCampaign.Name='NewTestCampaign';
        newCampaign.Service_Line__c='Burn';
        newCampaign.Audience_Region__c='Texas';
        newCampaign.Channel__c='Direct Mail';
        newCampaign.Add_Member_Status__c = 'Added Members';
        newCampaign.CRM_ActivateProcessId__c=Database.executeBatch(new CampaignProcess_GetNetCount(),1);
        insert newCampaign;   
        pagereference testpage = new pagereference('/apex/Campaign_ProgressBar');
        test.setcurrentpage(testpage);
        ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
        Campaign_ProgressBarController processBar = new Campaign_ProgressBarController(sc);
        
        processBar.refresh();
        
    }
    
    
    
   public static testmethod void Campaign_ProgressBarWDMDedupeMethod(){
       
       String WDMdedupebatchID;
        campaign cmp = marketingDataUtils.createcampsegmented();
       Campaign cmpagns = new Campaign();
     cmpagns.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
     cmpagns.Service_Line__c='Burn';
     cmpagns.Vendor_Name__c='BG Solutions BS';
     cmpagns.CRM_SelectedOwnershipCriteria__c='AHH;AHD';
     cmpagns.CRM_OwnershipType__c='Hospital';
     cmpagns.Ignore_Bad_Debt_Suppression__c=True;
     cmpagns.Call_to_Action__c='HRA';
     cmpagns.List_Order_Id__c=1162755;
     cmpagns.Member_Types__c='Campaign Segments';
     cmpagns.Channel__c='Direct Mail';
     cmpagns.status='In development';
       cmpagns.CRM_WdmDedupeProcessId__c=cmp.id;
       cmpagns.CRM_ActivateProcessId__c= cmp.id;
     cmpagns.CRM_UnlockProcessBatch_ID__c= null;
   insert cmpagns;
       
      Campaign cmpagns1 = new Campaign();
     cmpagns1.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
     cmpagns1.Service_Line__c='Burn';
     cmpagns1.Vendor_Name__c='BG Solutions BS';
     cmpagns1.CRM_SelectedOwnershipCriteria__c='AHH;AHD';
     cmpagns1.CRM_OwnershipType__c='Hospital';
     cmpagns1.Ignore_Bad_Debt_Suppression__c=True;
     cmpagns1.Call_to_Action__c='HRA';
     cmpagns1.List_Order_Id__c=1162755;
     cmpagns1.Member_Types__c='One or more encounters - Patients';
     cmpagns1.Channel__c='Direct Mail';
     cmpagns1.status='In development';
     cmpagns1.CRM_ParentSegmentedCampaign__c= cmpagns.id;
   insert cmpagns1;
       
       CRM_AudienceUploadJunction__c  audiencejunction = marketingDataUtils.createAudienceJunction(cmpagns.id);
        
         Set<id> juncid = new Set<id>();
        juncid.add(audiencejunction.Id);
       
       map<string,integer> wIdDuplicateCountMap = new map<string,integer>();
       wIdDuplicateCountMap.put('48190076',1);
       
        pagereference testpage = new pagereference('/apex/Campaign_ProgressBar');
        test.setcurrentpage(testpage);
        
        ApexPages.StandardController sc = new ApexPages.standardController(cmpagns);
        
        
         test.startTest();
         WDMdedupebatchID =	Database.executeBatch(new Audience_dedupeBatch(cmpagns ,juncid, wIdDuplicateCountMap.keySet()),2000);
         cmpagns.CRM_WdmDedupeProcessId__c = WDMdedupebatchID;
         update cmpagns;
         system.debug('batch id ==='+ cmpagns.CRM_UnlockProcessBatch_ID__c);
         test.stopTest();
        Campaign_ProgressBarController processBar = new Campaign_ProgressBarController(sc);
         processBar.refresh();
        
        
       
        
    } 
    
    
     public static testmethod void Campaign_ProgressBarUnlockDedupeMethod(){
       
         String unlockbatchID;
      campaign cmp = marketingDataUtils.createcampsegmented();
        Campaign cmpagns = new Campaign();
        cmpagns.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
     cmpagns.Service_Line__c='Burn';
     cmpagns.Vendor_Name__c='BG Solutions BS';
     cmpagns.CRM_SelectedOwnershipCriteria__c='AHH;AHD';
     cmpagns.CRM_OwnershipType__c='Hospital';
     cmpagns.Ignore_Bad_Debt_Suppression__c=True;
     cmpagns.Call_to_Action__c='HRA';
     cmpagns.List_Order_Id__c=1162755;
     cmpagns.Member_Types__c='Campaign Segments';
     cmpagns.Channel__c='Direct Mail';
     cmpagns.status='In development';
     cmpagns.CRM_WdmDedupeProcessId__c=null;
        
     cmpagns.CRM_UnlockProcessBatch_ID__c= cmp.id;
        
        insert cmpagns;  
         
       Campaign cmpagns1 = new Campaign();
     cmpagns1.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
     cmpagns1.Service_Line__c='Burn';
     cmpagns1.Vendor_Name__c='BG Solutions BS';
     cmpagns1.CRM_SelectedOwnershipCriteria__c='AHH;AHD';
     cmpagns1.CRM_OwnershipType__c='Hospital';
     cmpagns1.Ignore_Bad_Debt_Suppression__c=True;
     cmpagns1.Call_to_Action__c='HRA';
     cmpagns1.List_Order_Id__c=1162755;
     cmpagns1.Member_Types__c='One or more encounters - Patients';
     cmpagns1.Channel__c='Direct Mail';
     cmpagns1.status='In development';
     cmpagns1.CRM_ParentSegmentedCampaign__c= cmpagns.id;
   insert cmpagns1;
         
         
       
         CRM_AudienceUploadJunction__c  audiencejunction = marketingDataUtils.createAudienceJunction(cmpagns.id);
        
         Set<id> juncid = new Set<id>();
        juncid.add(audiencejunction.Id);
         
        
         
         pagereference testpage = new pagereference('/apex/Campaign_ProgressBar');
        test.setcurrentpage(testpage);
        
        ApexPages.StandardController sc = new ApexPages.standardController(cmpagns);
        
        
         test.startTest();
         unlockbatchID =	Database.executeBatch(new Audience_dedupeBatch(cmpagns ,juncid),2000);
         cmpagns.CRM_UnlockProcessBatch_ID__c = unlockbatchID;
         update cmpagns;
         system.debug('batch id ==='+ cmpagns.CRM_UnlockProcessBatch_ID__c);
         test.stopTest();
        Campaign_ProgressBarController processBar = new Campaign_ProgressBarController(sc);
         processBar.refresh();
       
        
    } 
    
 }
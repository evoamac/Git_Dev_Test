@istest
public class CRM_CountSummaryController_Test 
{
     public static testmethod void count()
     {
            Campaign newCampaigns = new Campaign();
             newCampaigns.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
             newCampaigns.Service_Line__c='Burn';
             newCampaigns.CRM_SubServiceLineText__c='Dermatology';
             newCampaigns.Vendor_Name__c='BG Solutions BS';
             newCampaigns.CRM_SelectedOwnershipCriteria__c='AHH;AHD';
             newCampaigns.CRM_OwnershipType__c='Hospital';
             newCampaigns.Status ='In Development';
             newCampaigns.Segment__c='Segment1';
             newCampaigns.Call_to_Action__c='HRA';
             newCampaigns.Member_Types__c='Campaign Segments';
             newCampaigns.Channel__c='Direct Mail';
             newcampaigns.status='In development';
            insert newCampaigns;
			pagereference testpage = new pagereference ('/apex/CRM_CountSummary');
			Test.setcurrentPage(testPage);
			ApexPages.currentPage().getParameters().put('id',newCampaigns.id);
			ApexPages.StandardController sc = new ApexPages.standardController(newCampaigns);
			CRM_CountSummaryController count = new CRM_CountSummaryController(sc);
			count.enc_back();
			count.callAnalysisTotalsOnly();
			count.callAnalysisByPreferredHospital();
			count.callAnalysisByZipcode();
     }
public static testmethod void Non_Segmented_count()
     {
            Campaign newCampaigns = new Campaign();
             newCampaigns.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
             newCampaigns.Service_Line__c='Burn';
             newCampaigns.CRM_SubServiceLineText__c='Dermatology';
             newCampaigns.Vendor_Name__c='BG Solutions BS';
             newCampaigns.CRM_SelectedOwnershipCriteria__c='AHH;AHD';
             newCampaigns.CRM_OwnershipType__c='Hospital';
             newCampaigns.Status ='In Development';
             newCampaigns.Segment__c='Segment1';
             newCampaigns.Call_to_Action__c='HRA';
             newCampaigns.Member_Types__c='Any or no encounters - Everyone';
             newCampaigns.Channel__c='Direct Mail';
             newcampaigns.status='In development';
            insert newCampaigns;
			pagereference testpage = new pagereference ('/apex/CRM_CountSummary');
			Test.setcurrentPage(testPage);
			ApexPages.currentPage().getParameters().put('id',newCampaigns.id);
			ApexPages.StandardController sc = new ApexPages.standardController(newCampaigns);
			CRM_CountSummaryController count = new CRM_CountSummaryController(sc);
			count.enc_back();
			count.callAnalysisTotalsOnly();
			count.callAnalysisByPreferredHospital();
			count.callAnalysisByZipcode();
     }
     
  }
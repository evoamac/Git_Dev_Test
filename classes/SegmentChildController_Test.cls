@istest
public class SegmentChildController_Test {
    public static testmethod void segmentmethod(){
        campaign newCamp =marketingDataUtils.createcampsegmented();
       
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
   insert cmpagns;
        CRM_CampaignWizardReferenceData__c wizrefdata = new CRM_CampaignWizardReferenceData__c();
        	wizrefdata.CRM_VendorName__c='Amplified Digital (AD)';
            wizrefdata.CRM_IsActive__c= True;
        insert wizrefdata;
        CampaignSequencer__c sequ =marketingDataUtils.createsequencer();
        CRM_CampaignRefJunction__c refjun = new CRM_CampaignRefJunction__c();
        		refjun.CRM_CampaignWizardReferenceData__c=wizrefdata.id;
                refjun.CRM_CampaignMapping__c= cmpagns.id;  
        insert refjun;
        
       id parentid =cmpagns.id;
       map<id,id> mapid = new map<id,id>();
        mapid.put(cmpagns.id,cmpagns.id);
     pagereference testpage = new pagereference ('/apex/Segmentchild');
                    Test.setcurrentPage(testPage);
        ApexPages.StandardController sc = new ApexPages.standardController(newCamp);
                    SegmentChildController seg = new SegmentChildController(sc) ;
        seg.addSegmentChildCamp(parentid);
        seg.clonerefJunctionCriteria(mapid);
    }
}
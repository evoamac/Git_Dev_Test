@isTest
private class CampaignRefDataAlerts_Controller_Test {
    public static testmethod void method1() {
        Campaign cmp = new Campaign();
        cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        cmp.Service_Line__c='Burn';
        cmp.CRM_SubServiceLineText__c='Dermatology';
        cmp.Tactic__c='Mail';
        cmp.count_of_index__c ='765';
        cmp.Channel__c='Direct Mail';
        cmp.List_Order_Id__c = 1876757;
        insert cmp; 
        System.assertEquals(cmp.Name, '20170127-103-Detroit-Cardiovascular-Direct Mail-V1');
        test.startTest();
        ApexPages.StandardController stdController = new ApexPages.StandardController(cmp);
        CampaignRefDataAlerts_Controller objCampRef = new CampaignRefDataAlerts_Controller(stdController);        
        test.stopTest();        
    
    }
    public static testmethod void method2() {
        Campaign cmp = new Campaign();
        cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        cmp.Service_Line__c='Burn';
        cmp.CRM_SubServiceLineText__c='Dermatology';
        cmp.Tactic__c='Mail';
        cmp.count_of_index__c ='765';
        cmp.Channel__c='Direct Mail';
        cmp.List_Order_Id__c = 1876757;
        insert cmp;
        System.assertEquals(cmp.Name, '20170127-103-Detroit-Cardiovascular-Direct Mail-V1');
         
        List<RecordType> lstRecTypeCRD = [select developerName,id from RecordType where sObjectType='CRM_CampaignWizardReferenceData__c' AND developerName = 'Service_Line'];
        CRM_CampaignWizardReferenceData__c crd = new CRM_CampaignWizardReferenceData__c ();
         if(lstRecTypeCRD.size()>0) {             
             crd.CRM_IsActive__c = false;
             crd.Recordtypeid = lstRecTypeCRD[0].id;
             crd.CRM_ServiceLine__c= 'Burn';
             insert crd;
             System.assertEquals(crd.CRM_ServiceLine__c, 'Burn');
        }
        
        CRM_CampaignRefJunction__c ccr = new CRM_CampaignRefJunction__c();
        ccr.CRM_CampaignMapping__c = cmp.id;
        ccr.CRM_CampaignWizardReferenceData__c = crd.id;
        insert ccr;
        System.assertEquals(ccr.CRM_CampaignMapping__c, cmp.id);
        
        test.startTest();
        ApexPages.StandardController stdController = new ApexPages.StandardController(cmp);
        CampaignRefDataAlerts_Controller objCampRef = new CampaignRefDataAlerts_Controller(stdController); 
        test.stopTest();
       
    }
    
}
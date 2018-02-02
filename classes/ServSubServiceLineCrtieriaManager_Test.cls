@isTest
private class ServSubServiceLineCrtieriaManager_Test {
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
        
        Campaign_Member_Criteria_Group__c  grp = new Campaign_Member_Criteria_Group__c();
        grp.Campaign__c=cmp.id;
        grp.Exclude__c = True;
        grp.Group_Name__c='test';
        grp.WM_CriteriaGroup_Id__c='12';
        grp.WM_Parent_group_Id__c='677';
        grp.Inner_Operator__c = 'OR';
        insert grp;
          
        Campaign_Member_Criteria__c mem= new Campaign_Member_Criteria__c();
        mem.Campaign__c=cmp.id;
        mem.Exclude__c=true;
        mem.Category__c = 'Ailments';
        mem.Criteria_Group__c = grp.id;
        mem.Field_Name__c='ZipCode__c';
        mem.value__c = '32124';
        insert mem;
        List<RecordType> recTypes = [SELECT id FROM RecordType WHERE SobjectType='CRM_CampaignWizardReferenceData__c' AND DeveloperName='Sub_Service_Line'];
        if(recTypes.size()>0) {
        id recTypeid = recTypes[0].id;
            CRM_CampaignWizardReferenceData__c cwr = new CRM_CampaignWizardReferenceData__c ();
            cwr.CRM_SubServiceLine__c = 'Branding-Sub';
            cwr.RecordTypeid = recTypeid;
            insert cwr;
        }
        test.startTest();
        ServSubServiceLineCrtieriaManager.ServiceSubServiceValuesAsperWDM(mem);
        ServSubServiceLineCrtieriaManager.ServiceLineSubServiceLineMapping();
        ServSubServiceLineCrtieriaManager.ServiceLineSubServiceSetsMapping();        
        test.stopTest();
    
    
    }
}
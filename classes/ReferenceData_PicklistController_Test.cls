@istest
 private class ReferenceData_PicklistController_Test{
     public static testmethod void CampaignCriteriaMethod(){
         test.startTest();
         List<RecordType> lstRecType = [select developerName,id from RecordType where sObjectType='CRM_CampaignLocationReferenceData__c' AND developerName = 'Region'];
         if(lstRecType.size()>0) {  
             CRM_CampaignLocationReferenceData__c clr = new CRM_CampaignLocationReferenceData__c ();
             clr.CRM_Region__c = 'Dallas';
             clr.CRM_Market__c= 'Dallas Market';
             insert clr;
             System.assertEquals(clr.CRM_Region__c, 'Dallas');            
             ReferenceData_PicklistController.recordTypeDeveloperName('CRM_CampaignLocationReferenceData__c',lstRecType[0].id);
             ReferenceData_PicklistController.refreshOwnershiptype(lstRecType[0].id);
         }
         List<RecordType> lstRecTypeCRD = [select developerName,id from RecordType where sObjectType='CRM_CampaignWizardReferenceData__c' AND developerName = 'Service_Line'];
         if(lstRecTypeCRD.size()>0) {
             CRM_CampaignWizardReferenceData__c crd = new CRM_CampaignWizardReferenceData__c();
             crd.CRM_IsActive__c = true;
             crd.Recordtypeid = lstRecTypeCRD[0].id;
             crd.CRM_ServiceLine__c= 'Branding';
             insert crd;
             System.assertEquals(crd.CRM_ServiceLine__c, 'Branding'); 
             ReferenceData_PicklistController.serviceLine(true);
              
         }
         List<RecordType> lstRecTypeCLR = [select developerName,id from RecordType where sObjectType='CRM_CampaignLocationReferenceData__c' AND developerName = 'Region'];
         if(lstRecTypeCLR.size()>0) 
             ReferenceData_PicklistController.ownershipOptions();
             
         List<RecordType> lstRecTypeCRDSSL = [select developerName,id from RecordType where sObjectType='CRM_CampaignWizardReferenceData__c' AND developerName = 'Sub_Service_Line'];
         if(lstRecTypeCRDSSL.size()>0) {
             CRM_CampaignWizardReferenceData__c crd = new CRM_CampaignWizardReferenceData__c();
             crd.CRM_IsActive__c = true;
             crd.Recordtypeid = lstRecTypeCRDSSL[0].id;
             crd.CRM_ServiceLine__c= 'Primary Care';
             insert crd;
             List<String> serviceLine = new List<String> ();
             serviceLine.add('Branding');
             System.assertEquals(serviceLine.size(), 1);
             ReferenceData_PicklistController.subServiceLine(true, serviceLine);
             ReferenceData_PicklistController.clinicalServiceLine(true);
         }
         List<RecordType> lstRecTypeCACR = [select developerName,id from RecordType where sObjectType='CRM_AudienceCriteriaRefData__c' AND developerName = 'ClinicalSubServiceLine'];
         if(lstRecTypeCACR.size()>0) {
             List<String> serviceLine = new List<String> ();
             serviceLine.add('Branding');
             CRM_AudienceCriteriaRefData__c cra = new CRM_AudienceCriteriaRefData__c();
             cra.CRM_IsActive__c = true;
             cra.Recordtypeid = lstRecTypeCACR[0].id;
             //cra.CRM_ClinicalServiceLineID__c = 'Branding';
             insert cra;
             System.assertEquals(cra.CRM_IsActive__c, true);
             ReferenceData_PicklistController.clinicalSubServiceLine(false,serviceLine);
             
             
         }
         Campaign c =  new Campaign ();
         c.Name = 'test';
         c.CRM_SelectedOwnershipCriteria__c = 'Hospital,Region';
         insert c;
         System.assertEquals(c.Name, 'test');        
         CRM_CampaignWizardReferenceData__c crd = new CRM_CampaignWizardReferenceData__c();
         List<RecordType> lstRecTypeCRDSSLN = [select developerName,id from RecordType where sObjectType='CRM_CampaignWizardReferenceData__c' AND developerName = 'Sub_Service_Line'];
         if(lstRecTypeCRDSSLN.size()>0) {             
             crd.CRM_IsActive__c = true;
             crd.Recordtypeid = lstRecTypeCRDSSLN[0].id;
             crd.CRM_ServiceLine__c= 'Hematology';
             insert crd;
         }
         System.assertEquals(crd.CRM_ServiceLine__c, 'Hematology');  
         CRM_CampaignRefJunction__c ccr = new CRM_CampaignRefJunction__c();
         ccr.CRM_CampaignMapping__c = c.id;
         ccr.CRM_CampaignWizardReferenceData__c = crd.id;
         insert ccr;
         System.assertEquals(ccr.CRM_CampaignMapping__c, c.id); 
          
         CampaignSequencer__c cs = new CampaignSequencer__c();
         cs.Name =  'test';
         cs.Counter_Value__c = 999;
         insert cs;
         System.assertEquals(cs.Name,  'test');  
         
         list<string> ValuesIds = new list<string> ();
         ValuesIds.add(crd.id);
         System.assertEquals(ValuesIds.size(),  1);  
         
         ReferenceData_PicklistController.updateJunctionObject(c.id, ValuesIds);
         ReferenceData_PicklistController.getCampaignName(c.id);
         ReferenceData_PicklistController.getPickListValues('ChannelValues');
         test.stopTest();
         
     }
     public static testmethod void CampaignCriteriaMethod2(){
         test.startTest();
         ReferenceData_PicklistController.getPickListValues('Call_To_Action');     
         test.stopTest();    
     
     }
     public static testmethod void CampaignCriteriaMethod3(){
         test.startTest();
         ReferenceData_PicklistController.getPickListValues('Vendor_Name');         
         test.stopTest();
     }
     public static testmethod void CampaignCriteriaMethod4(){
         test.startTest();
         ReferenceData_PicklistController.getPickListValues('Service_Line');         
         test.stopTest();
     
     }
     public static testmethod void CampaignCriteriaMetho5(){
         ReferenceData_PicklistController.getPickListValues('Sub_Service_Line'); 
         CRM_CampaignWizardReferenceData__c ccr = new CRM_CampaignWizardReferenceData__c();
         ccr.CRM_IsTargeted__c = false;
         insert ccr;
         System.assertEquals(ccr.CRM_IsTargeted__c, false);
         
         ReferenceData_PicklistController.getCampaignRecordTypeId(ccr.id); 
         Campaign c =  new Campaign ();
         c.Name = 'test';
         c.CRM_SelectedOwnershipCriteria__c = 'Hospital,Region';
         insert c;
         System.assertEquals(c.Name,'test');
         
         CampaignSequencer__c cs = new CampaignSequencer__c();
         cs.Name =  'test';
         cs.Counter_Value__c = 100;
         insert cs;
         System.assertEquals(cs.Name,  'test');
         test.startTest();
         ReferenceData_PicklistController.getCampaignName(c.id);
         test.stopTest();
     }       
     
     public static testmethod void CampaignCriteriaMethod6(){
         ReferenceData_PicklistController.getPickListValues('MemberType');
         CRM_CampaignWizardReferenceData__c ccr = new CRM_CampaignWizardReferenceData__c();
         ccr.CRM_IsTargeted__c = true;
         
         insert ccr;
         System.assertEquals(ccr.CRM_IsTargeted__c , true);
         
         test.startTest();
         ReferenceData_PicklistController.getCampaignRecordTypeId(ccr.id);
         test.stopTest();
         
         
         
     }
     public static testmethod void CampaignCriteriaMethod7(){
         ReferenceData_PicklistController.getPickListValues('Sub_Service_Line'); 
         CRM_CampaignWizardReferenceData__c ccr = new CRM_CampaignWizardReferenceData__c();
         ccr.CRM_IsTargeted__c = false;
         insert ccr;
         System.assertEquals(ccr.CRM_IsTargeted__c , false);
          
         ReferenceData_PicklistController.getCampaignRecordTypeId(ccr.id); 
         Campaign c =  new Campaign ();
         c.Name = 'test';
         c.CRM_SelectedOwnershipCriteria__c = 'Hospital,Region';
        
         insert c;
         System.assertEquals(c.Name ,  'test');
         
         CampaignSequencer__c cs = new CampaignSequencer__c();
         cs.Name =  'test';
         cs.Counter_Value__c = 100;
         insert cs;
         System.assertEquals( cs.Name,  'test');
         
         test.startTest();
         ReferenceData_PicklistController.getCampaignName(c.id);
         test.stopTest();
         
         
     }
          
     public static testmethod void CampaignCriteriaMethod8(){
         test.startTest();
         ReferenceData_PicklistController.getPickListValues('Sub_Service_Line'); 
         CRM_CampaignWizardReferenceData__c ccr = new CRM_CampaignWizardReferenceData__c();
         ccr.CRM_IsTargeted__c = false;
         insert ccr;
         System.assertEquals(ccr.CRM_IsTargeted__c,false);
         
         ReferenceData_PicklistController.getCampaignRecordTypeId(ccr.id); 
         Campaign c =  new Campaign ();
         c.Name = 'test';
         c.CRM_OwnershipType__c= 'Hospital';
         c.CRM_SelectedOwnershipCriteria__c = 'Hospital';
         
         insert c;
         System.assertEquals(c.Name,  'test');
         
         List<RecordType> lstRecType = [select developerName,id from RecordType where sObjectType='CRM_CampaignLocationReferenceData__c' AND developerName = 'Hospital'];
         if(lstRecType.size()>0) {  
         CRM_CampaignLocationReferenceData__c clr = new CRM_CampaignLocationReferenceData__c ();
         clr.CRM_Region__c = 'Dallas';
         clr.CRM_Market__c= 'Dallas Market';
         clr.CRM_HospitalCode__c = 'Hospital';
         clr.Recordtypeid = lstRecType[0].id;
         insert clr;
         System.assertEquals(clr.CRM_Region__c, 'Dallas');
         }
       
         CampaignSequencer__c cs = new CampaignSequencer__c();
         cs.Name =  'test';
         cs.Counter_Value__c = 100;
         insert cs;
         System.assertEquals(cs.Name,  'test');
         
        // ReferenceData_PicklistController.getCampaignName(c.id);
         ReferenceData_PicklistController.refreshOwnershiptype(lstRecType[0].id);
         test.stopTest();
         
         
     }
      public static testmethod void CampaignCriteriaMethod9(){
         test.startTest();
         CRM_CampaignWizardReferenceData__c ccr = new CRM_CampaignWizardReferenceData__c();
         ccr.CRM_IsTargeted__c = false;
         insert ccr;
         System.assertEquals(ccr.CRM_IsTargeted__c, false);
         
         ReferenceData_PicklistController.getCampaignRecordTypeId(ccr.id); 
         Campaign c =  new Campaign ();
         c.Name = 'test';
         c.CRM_OwnershipType__c= 'Region';
         c.CRM_SelectedOwnershipCriteria__c = 'Region';
         c.Audience_Region__c = 'Dallas Region';
         c.Audience_Hospital__c = 'ABC';
         
         insert c;
         System.assertEquals(c.Name,  'test');
         
         List<RecordType> lstRecType = [select developerName,id from RecordType where sObjectType='CRM_CampaignLocationReferenceData__c' AND developerName = 'Region'];
         if(lstRecType.size()>0) {  
         CRM_CampaignLocationReferenceData__c clr = new CRM_CampaignLocationReferenceData__c ();
         clr.CRM_Region__c = 'Region';
         clr.CRM_Market__c= 'Dallas Market';
         clr.CRM_HospitalCode__c = 'ABC';
         clr.CRM_RegionCode__c = 'Region';
         clr.Recordtypeid = lstRecType[0].id;
         insert clr;
         System.assertEquals(clr.CRM_Market__c, 'Dallas Market');
         }
       
         CampaignSequencer__c cs = new CampaignSequencer__c();
         cs.Name =  'test';
         cs.Counter_Value__c = 102;
         insert cs;
         System.assertEquals(cs.Name,  'test');
         
         //ReferenceData_PicklistController.getCampaignName(c.id);
         test.stopTest();
         
         
     }
     public static testmethod void CampaignCriteriaMethod10(){
         Campaign c =  new Campaign ();
         c.Name = 'test';
         c.CRM_OwnershipType__c= 'Market';
         c.CRM_SelectedOwnershipCriteria__c = 'Market';
         c.Audience_Region__c = 'Dallas Market';
         
         insert c;
         System.assertEquals(c.Name,  'test');
         
         Test.setCreatedDate(c.Id, DateTime.newInstance(2017,01,01));
         List<RecordType> lstRecType = [select developerName,id from RecordType where sObjectType='CRM_CampaignLocationReferenceData__c' AND developerName = 'Market'];
         if(lstRecType.size()>0) {  
         CRM_CampaignLocationReferenceData__c clr = new CRM_CampaignLocationReferenceData__c ();
         clr.CRM_Region__c = 'Dallas Region';
         clr.CRM_Market__c= 'Market';
         clr.CRM_HospitalCode__c = 'Market';
         clr.Recordtypeid = lstRecType[0].id;
         insert clr;
         System.assertEquals(clr.CRM_Market__c, 'Market');
         }
       
         CampaignSequencer__c cs = new CampaignSequencer__c();
         cs.Name =  'test';
         cs.Counter_Value__c = 100;
         insert cs;
         System.assertEquals(cs.Name,  'test');
         
         test.startTest();
         //ReferenceData_PicklistController.getCampaignName(c.id);
         ReferenceData_PicklistController.refreshOwnershiptype(lstRecType[0].id);
         test.stopTest();
         
         
     }
                  
     public static testmethod void CampaignCriteriaMethod11(){
         
         Campaign c =  new Campaign ();
         c.Name = 'test';
         c.CRM_OwnershipType__c= 'Market';
         c.CRM_SelectedOwnershipCriteria__c = 'Market';
         c.Audience_Region__c = 'Dallas Market';
         
         insert c;
         System.assertEquals(c.Name,  'test');
         Campaign c2 =  new Campaign ();
         c2.Name = 'test';
         c2.CRM_OwnershipType__c= 'Market';
         c2.CRM_SelectedOwnershipCriteria__c = 'Market';
         c2.Audience_Region__c = 'Dallas Market';
         
         insert c2;
         System.assertEquals(c2.Name,  'test');
        
         List<RecordType> lstRecType = [select developerName,id from RecordType where sObjectType='CRM_CampaignLocationReferenceData__c' AND developerName = 'Market'];
         if(lstRecType.size()>0) {  
         CRM_CampaignLocationReferenceData__c clr = new CRM_CampaignLocationReferenceData__c ();
         clr.CRM_Region__c = 'Dallas Region';
         clr.CRM_Market__c= 'Market';
         clr.CRM_HospitalCode__c = 'Market';
         clr.Recordtypeid = lstRecType[0].id;
         insert clr;
         System.assertEquals(clr.CRM_Market__c, 'Market');
         }
       
         CampaignSequencer__c cs = new CampaignSequencer__c();
         cs.Name =  'test';
         cs.Counter_Value__c = 100;
         insert cs;
         System.assertEquals(cs.Name,  'test');
         test.startTest();
         //ReferenceData_PicklistController.getCampaignName(c.id);
         ReferenceData_PicklistController.refreshOwnershiptype(lstRecType[0].id);
         test.stopTest();
     
     }
     public static testmethod void CampaignCriteriaMethod12(){
        
         Campaign c =  new Campaign ();
         c.Name = 'test';
         c.CRM_OwnershipType__c= 'Region';
         c.CRM_SelectedOwnershipCriteria__c = 'Region';
         c.Audience_Region__c = 'Dallas Region';
         c.Audience_Hospital__c = 'ABC';
         
         insert c;
         System.assertEquals(c.Name,  'test');
         List<RecordType> lstRecType = [select developerName,id from RecordType where sObjectType='CRM_CampaignLocationReferenceData__c' AND developerName = 'Region'];
         if(lstRecType.size()>0) {  
         CRM_CampaignLocationReferenceData__c clr = new CRM_CampaignLocationReferenceData__c ();
         clr.CRM_Region__c = 'Dallas-Region';
         clr.CRM_Market__c= 'Dallas Market';
         clr.CRM_HospitalCode__c = 'ABC';
         clr.CRM_RegionCode__c = 'Region';
         clr.Recordtypeid = lstRecType[0].id;
         insert clr;
         System.assertEquals(clr.CRM_Region__c, 'Dallas-Region');
         }
       
         CampaignSequencer__c cs = new CampaignSequencer__c();
         cs.Name =  'test';
         cs.Counter_Value__c = 102;
         insert cs;
         System.assertEquals(cs.Name,  'test');
         test.startTest();
         //ReferenceData_PicklistController.getCampaignName(c.id);
         test.stopTest();
         
         
     }
     public static testmethod void CampaignCriteriaMethod13(){
         
         Campaign c =  new Campaign ();
         c.Name = 'test';
         c.CRM_OwnershipType__c= 'Region';
         c.CRM_SelectedOwnershipCriteria__c = 'Region';
         c.Audience_Region__c = 'Dallas Region';
         c.Audience_Hospital__c = 'ABC';
         
         insert c;
         System.assertEquals(c.Name,  'test');
         List<RecordType> lstRecType = [select developerName,id from RecordType where sObjectType='CRM_CampaignLocationReferenceData__c' AND developerName = 'Region'];
         if(lstRecType.size()>0) {  
         CRM_CampaignLocationReferenceData__c clr = new CRM_CampaignLocationReferenceData__c ();
         clr.CRM_Region__c = 'region';
         clr.CRM_Market__c= 'Dallas Market';
         clr.CRM_HospitalCode__c = 'ABC';
         clr.CRM_RegionCode__c = 'Region';
         clr.Recordtypeid = lstRecType[0].id;
         insert clr;
         System.assertEquals(clr.CRM_Market__c, 'Dallas Market');
         }
       
         CampaignSequencer__c cs = new CampaignSequencer__c();
         cs.Name =  'test';
         cs.Counter_Value__c = 102;
         insert cs;
         System.assertEquals(cs.Name,  'test');
         
         test.startTest();
        // ReferenceData_PicklistController.getCampaignName(c.id);
         test.stopTest();
         
         
     }
     
     public static testmethod void CampaignCriteriaMethod130()
     {
         
         Campaign c =  new Campaign ();
         c.Name = 'test';
         c.CRM_OwnershipType__c= 'Market';
         c.CRM_SelectedOwnershipCriteria__c = 'DT1';
         c.Service_Line__c = 'enc';
         c.Channel__c = 'Email';
        
         insert c;
         System.assertEquals(c.Name,  'test');
         List<RecordType> lstRecType = [select developerName,id from RecordType where sObjectType='CRM_CampaignLocationReferenceData__c' AND developerName = 'Market'];
         if(lstRecType.size()>0) {  
         CRM_CampaignLocationReferenceData__c clr = new CRM_CampaignLocationReferenceData__c ();
         clr.CRM_Market__c= 'Detroit Market';
         clr.CRM_MarketCode__c = 'DT1';
         clr.Recordtypeid = lstRecType[0].id;
         insert clr;
         System.assertEquals(clr.CRM_Market__c, 'Detroit Market');
         }
       
         CampaignSequencer__c cs = new CampaignSequencer__c();
         cs.Name =  'test';
         cs.Counter_Value__c = 102;
         insert cs;
         System.assertEquals(cs.Name,  'test');
         
         test.startTest();
         ReferenceData_PicklistController.getCampaignName(c.id);
         test.stopTest();
         
         
     }
     
     public static testmethod void CampaignCriteriaMethod131()
     {
         
         Campaign c =  new Campaign ();
         c.Name = 'test';
         c.CRM_OwnershipType__c= 'Region';
         c.CRM_SelectedOwnershipCriteria__c = 'TX1';
         c.Service_Line__c = 'enc';
         c.Channel__c = 'Email';
        
         insert c;
         System.assertEquals(c.Name,  'test');
         List<RecordType> lstRecType = [select developerName,id from RecordType where sObjectType='CRM_CampaignLocationReferenceData__c' AND developerName = 'Region'];
         if(lstRecType.size()>0) {  
         CRM_CampaignLocationReferenceData__c clr = new CRM_CampaignLocationReferenceData__c ();
         clr.CRM_Region__c= 'Texas Region';
         clr.CRM_RegionCode__c = 'TX1';
         clr.Recordtypeid = lstRecType[0].id;
         insert clr;
         System.assertEquals(clr.CRM_Region__c, 'Texas Region');
         }
       
         CampaignSequencer__c cs = new CampaignSequencer__c();
         cs.Name =  'test';
         cs.Counter_Value__c = 102;
         insert cs;
         System.assertEquals(cs.Name,  'test');
         
         test.startTest();
         ReferenceData_PicklistController.getCampaignName(c.id);
         test.stopTest();
         
         
     }
     
}
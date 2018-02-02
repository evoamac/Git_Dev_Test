@istest
public class ClonePlusController_Test 
{
    public static testmethod void ClonePlusmethod() 
    {
        Campaign newCampaign = new Campaign();
        newCampaign.Name = '20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        newCampaign.Service_Line__c = 'Burn';
        newCampaign.CRM_SubServiceLineText__c = 'Dermatology';
        newCampaign.Audience_Hospital__c= 'Alabama Market — Brookwood Medical Center';
        newCampaign.CRM_OwnershipType__c= 'Hospital';
        newCampaign.CRM_SelectedOwnershipCriteria__c = 'BMC';
        newCampaign.Tactic__c = 'Mail';
        newCampaign.count_of_index__c = '765';
        newCampaign.Channel__c = 'Direct Mail';
        upsert newCampaign;
           Campaign newCampaignSeg = new Campaign();
        newCampaignSeg.Name = '20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        newCampaignSeg.Service_Line__c = 'Burn';
        newCampaignSeg.CRM_SubServiceLineText__c = 'Dermatology';
        newCampaignSeg.Audience_Hospital__c= 'Alabama Market — Brookwood Medical Center';
        newCampaignSeg.CRM_OwnershipType__c= 'Hospital';
        newCampaignSeg.CRM_SelectedOwnershipCriteria__c = 'BMC';
        newCampaignSeg.Tactic__c = 'Mail';
        newCampaignSeg.count_of_index__c = '765';
        newCampaignSeg.Channel__c = 'Direct Mail';
        newCampaignSeg.CRM_ParentSegmentedCampaign__c  = newCampaign.id;
        
        upsert newCampaignSeg;
        
        Attachment at=new Attachment();
        at.ParentId=newCampaign.id;
        Campaign newCampaignInactiveValues1 = new Campaign();
        newCampaignInactiveValues1.Name = '20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        newCampaignInactiveValues1.Service_Line__c = 'Burn';
        newCampaignInactiveValues1.CRM_SubServiceLineText__c = 'Dermatology';
        newCampaignInactiveValues1.Audience_Hospital__c= 'Alabama Market — Brookwood Medical Center';
        newCampaignInactiveValues1.CRM_OwnershipType__c= 'Hospital';
        newCampaignInactiveValues1.CRM_SelectedOwnershipCriteria__c = 'BMC';
        newCampaignInactiveValues1.Tactic__c = 'Mail';
        newCampaignInactiveValues1.count_of_index__c = '765';
        newCampaignInactiveValues1.Channel__c = 'Direct Mail';
        upsert newCampaignInactiveValues1;
        Campaign newCampaignInactiveValues = new Campaign();
        newCampaignInactiveValues.Name = '20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        newCampaignInactiveValues.Service_Line__c = 'Burn';
        newCampaignInactiveValues.CRM_SubServiceLineText__c = 'Dermatology';
        newCampaignInactiveValues.Audience_Hospital__c= 'Alabama Market — Brookwood Medical Center';
        newCampaignInactiveValues.CRM_OwnershipType__c= 'Hospital';
        newCampaignInactiveValues.CRM_SelectedOwnershipCriteria__c = 'BMC';
        newCampaignInactiveValues.Tactic__c = 'Mail';
        newCampaignInactiveValues.count_of_index__c = '765';
        newCampaignInactiveValues.Channel__c = 'Direct Mail';
        upsert newCampaignInactiveValues;
        
        Campaign newCampaign1 = new Campaign();
        newCampaign1.Name = '20161206-102-Florida-Cardiovascular-Direct Mail-V1';
        newCampaign1.Service_Line__c = 'Burn';
        newCampaign1.CRM_SubServiceLineText__c = 'Dermatology';
        newCampaign1.Tactic__c = 'Mail';
        newCampaign1.Channel__c = 'Direct Mail';
        insert newCampaign1;
        Location__c Loc = new Location__c();
        loc.Market__c = 'Dellas';
        loc.Region__c = 'Texas';
        loc.HSPCD__c = 'test';
        loc.Hospital__c = 'Birmingham-Princeton Baptist Medical Center';
        insert Loc;
        campaignSequencer__c campsequencer = new campaignSequencer__c();
        campsequencer.Counter_Value__c = 999;
        campsequencer.Name = 'count';
        insert campsequencer;
        List < Campaign_Related_List__c > RelatedList = new List < Campaign_Related_List__c > {
            new Campaign_Related_List__c(Name = 'Campaign_Demographics__c'),
            new Campaign_Related_List__c(Name = 'Encounter__c')
        };
        insert RelatedList;

        Encounter__c enc = marketingDataUtils.createEncounter(newCampaign.id);

       

        Schema.DescribeSObjectResult R = CRM_AudienceCriteriaRefData__c.SObjectType.getDescribe();
        List < Schema.RecordTypeInfo > RT = R.getRecordTypeInfos();

        list < CRM_AudienceCriteriaRefData__c > audienceSelectionRefDataList = new list < CRM_AudienceCriteriaRefData__c > ();
        audienceSelectionRefDataList.add(new CRM_AudienceCriteriaRefData__c(RecordTypeId = rt[0].getRecordTypeId(), CRM_IsActive__c = true, CRM_ClinicalServiceLine__c = 'Test', CRM_ClinicalServiceLineSyncData__c = 'TEST'));
        insert audienceSelectionRefDataList;
        CRM_EncounterServiceLineSelection__c junobj = new CRM_EncounterServiceLineSelection__c(CRM_AudienceCriteriaReferenceData__c = audienceSelectionRefDataList[0].id, CRM_Encounter__c = enc.id);
        insert junobj;
        
        
        
        String odlCampId = '67866768';
        String NewCampId = 'hydd';
        String pluralLabel = 'ffghhgv';
        String relatedFieldName = 'cghg';
        List < sObject > sObjects = new List < sObject > ();
        sObjects.add(newCampaign);
        Sobject obj = newCampaign;
       // ClonePlusController.relatedObjectRow wrap1 = new ClonePlusController.relatedObjectRow(obj);
       // wrap1.getName();
       // list < ClonePlusController.relatedObjectRow > objectRows = new list < ClonePlusController.relatedObjectRow > ();
      // objectRows.add(wrap1);

        CRM_Search_Criteria__c CSC = new CRM_Search_Criteria__c();
        CSC.CRM_Search_Criteria_Level_1__c = 'By Region';
        CSC.CRM_Search_Criteria_Level_2__c = 'Primary Service Area';
        CSC.CRM_Search_Criteria_Level_3__c = 'Baylor/Tenet JV Region';
        CSC.CRM_AdditionalZipCodes__c = '1234';
        CSC.CRM_ExcludedZipCodes__c = '34566';
        CSC.CRM_Campaign__c = newCampaign.id;
        insert CSC;
         
        CRM_Search_Criteria__c CSC2 = new CRM_Search_Criteria__c();
        CSC2.CRM_Search_Criteria_Level_1__c = 'By Region';
        CSC2.CRM_Search_Criteria_Level_2__c = 'SSA;CA';
        CSC2.CRM_Search_Criteria_Level_3__c = 'DT1';
        CSC2.CRM_AdditionalZipCodes__c = '1234';
        CSC2.CRM_ExcludedZipCodes__c = '34566';
        CSC2.CRM_Campaign__c = newCampaignInactiveValues.id;
        insert CSC2;
        
        CRM_Search_Criteria__c CSC3 = new CRM_Search_Criteria__c();
        CSC3.CRM_Search_Criteria_Level_1__c = 'By State';
        CSC3.CRM_Search_Criteria_Level_2__c = 'CA';
        CSC3.CRM_Search_Criteria_Level_3__c = 'DT1';
        CSC3.CRM_AdditionalZipCodes__c = '1234';
        CSC3.CRM_ExcludedZipCodes__c = '34566';
        CSC3.CRM_Campaign__c = newCampaignInactiveValues1.id;
        insert CSC3;
        
        Encounter_aggregates__c encAgg = new Encounter_aggregates__c();
        encAgg.Campaign__c = newCampaign.id;
        encAgg.Last_Discharge_Date_From_UI__c = date.parse('9/5/2017');
        encAgg.Last_Discharge_Date_To_UI__c = date.parse('9/20/2017');
        encAgg.CRM_SelectedPreferedHospitalCodes__c = 'UCC';
        insert encAgg;
        CRM_CampaignLocationReferenceData__c CLRef = new CRM_CampaignLocationReferenceData__c();
        CLRef.CRM_Hospital__c = 'Alabama Market — Brookwood Medical Center';
        CLRef.CRM_HospitalCode__c= 'BMC';
        CLRef.recordTypeId= ReferenceData_PicklistController.recordTypeId('CRM_CampaignLocationReferenceData__c' , newCampaign.CRM_OwnershipType__c);
        
        CLRef.CRM_IsActive__c = true;
        Insert CLRef;
      
        
        CRM_CampaignOwnershipDetail__c COD = new CRM_CampaignOwnershipDetail__c();
        COD.Campaign_Location_Reference_Data_Mapping__c = CLRef.id;
        COD.Campaign__c = newCampaign.id;
       
        insert COD;
       
        
        
        CRM_CampaignWizardReferenceData__c CLRef1 = new CRM_CampaignWizardReferenceData__c();
        CLRef1.CRM_channel__c = 'ENC';
        CLRef1.recordTypeId= ReferenceData_PicklistController.recordTypeId('CRM_CampaignWizardReferenceData__c' , 'ChannelValues');
        CLRef1.CRM_IsActive__c = false;
        Insert CLRef1;
        
        list <CRM_CampaignWizardReferenceData__c> inactiveRefDataList = new list < CRM_CampaignWizardReferenceData__c > ();
        inactiveRefDataList.add(new CRM_CampaignWizardReferenceData__c(RecordTypeId = ReferenceData_PicklistController.recordTypeId('CRM_CampaignWizardReferenceData__c' , 'Call_To_Action'), CRM_IsActive__c = false, CRM_CallToAction__c= 'Test_CRM_CallToAction'));
        inactiveRefDataList.add(new CRM_CampaignWizardReferenceData__c(RecordTypeId = ReferenceData_PicklistController.recordTypeId('CRM_CampaignWizardReferenceData__c' , 'Vendor_Name'), CRM_IsActive__c = false, CRM_VendorName__c= 'Test_CRM_VendorName'));
        inactiveRefDataList.add(new CRM_CampaignWizardReferenceData__c(RecordTypeId = ReferenceData_PicklistController.recordTypeId('CRM_CampaignWizardReferenceData__c' , 'Service_Line'), CRM_IsActive__c = false, CRM_ServiceLine__c= 'Test_CRM_ServiceLine'));
        inactiveRefDataList.add(new CRM_CampaignWizardReferenceData__c(RecordTypeId = ReferenceData_PicklistController.recordTypeId('CRM_CampaignWizardReferenceData__c' , 'Sub_Service_Line'), CRM_IsActive__c = false, CRM_SubServiceLine__c= 'Test_CRM_ServiceLine'));
        
        insert inactiveRefDataList;
        
        List<CRM_CampaignRefJunction__c> refInactiveJuncObj=new List<CRM_CampaignRefJunction__c> ();
        for(CRM_CampaignWizardReferenceData__c inactiveRec :inactiveRefDataList )
        {
        refInactiveJuncObj.add(new CRM_CampaignRefJunction__c(CRM_CampaignMapping__c=newCampaignInactiveValues.id,CRM_CampaignWizardReferenceData__c=inactiveRec.id));
       
        }
        insert refInactiveJuncObj;
        
        list <CRM_CampaignLocationReferenceData__c> inactiveRefOwnerDataList = new list < CRM_CampaignLocationReferenceData__c> ();
        inactiveRefOwnerDataList.add(new CRM_CampaignLocationReferenceData__c(RecordTypeId = ReferenceData_PicklistController.recordTypeId('CRM_CampaignLocationReferenceData__c' , 'Region'), CRM_IsActive__c = false,CRM_RegionCode__c='DT1', CRM_Region__c= 'Test_Region'));
        inactiveRefOwnerDataList.add(new CRM_CampaignLocationReferenceData__c(RecordTypeId = ReferenceData_PicklistController.recordTypeId('CRM_CampaignLocationReferenceData__c' , 'Market'), CRM_IsActive__c = false, CRM_Market__c= 'Test_Market'));
        inactiveRefOwnerDataList.add(new CRM_CampaignLocationReferenceData__c(RecordTypeId = ReferenceData_PicklistController.recordTypeId('CRM_CampaignLocationReferenceData__c' , 'Hospital'), CRM_IsActive__c = false, CRM_Hospital__c= 'Test_Hospital'));
        inactiveRefOwnerDataList.add(new CRM_CampaignLocationReferenceData__c(RecordTypeId = ReferenceData_PicklistController.recordTypeId('CRM_CampaignLocationReferenceData__c' , 'ServiceArea'), CRM_IsActive__c = false,CRM_ServiceAreaCode__c ='SSA', CRM_ServiceArea__c= 'Test_Hospital'));
         
        insert inactiveRefOwnerDataList;
        
        list <CRM_CampaignGeographyReferenceData__c> inactiveRefGeoDataList = new list < CRM_CampaignGeographyReferenceData__c> ();
        inactiveRefGeoDataList.add(new CRM_CampaignGeographyReferenceData__c(RecordTypeId = ReferenceData_PicklistController.recordTypeId('CRM_CampaignGeographyReferenceData__c' , 'State'), CRM_IsActive__c = false,CRM_StateCode__c='CA',CRM_State__c='Test_State'));
         
        insert inactiveRefGeoDataList;
        
        
        
        List<CRM_CampaignOwnershipDetail__c> refInactiveOwnerJuncObj=new List<CRM_CampaignOwnershipDetail__c> ();
        for(CRM_CampaignLocationReferenceData__c inactiveRec :inactiveRefOwnerDataList)
        {
        refInactiveOwnerJuncObj.add(new CRM_CampaignOwnershipDetail__c(Campaign__c=newCampaignInactiveValues.id,Campaign_Location_Reference_Data_Mapping__c=inactiveRec.id));
       
        }
        insert refInactiveOwnerJuncObj;
        
        
        list <CRM_AudienceCriteriaRefData__c> inactiveRefEncDataList = new list < CRM_AudienceCriteriaRefData__c> ();
        inactiveRefEncDataList.add(new CRM_AudienceCriteriaRefData__c(RecordTypeId = ReferenceData_PicklistController.recordTypeId('CRM_AudienceCriteriaRefData__c' , 'ClinicalServiceLine'), CRM_IsActive__c = false, CRM_ClinicalServiceLine__c= 'Test_ClinicalServiceLine'));
        
        insert inactiveRefEncDataList;
        
        Encounter__c encInactive=new Encounter__c ();
        encInactive.CRM_ServiceLine__c='Test_ServiceLine';
        encInactive.Campaign__c=newCampaignInactiveValues.id;
        
        insert encInactive;
      
      CRM_CampaignLocationReferenceData__c CLRef2 = new CRM_CampaignLocationReferenceData__c();
        CLRef.CRM_Hospital__c = 'Alabama Market — Brookwood Medical Center3';
        CLRef.CRM_HospitalCode__c= 'BMC3';
        CLRef.recordTypeId= ReferenceData_PicklistController.recordTypeId('CRM_CampaignLocationReferenceData__c' , newCampaign.CRM_OwnershipType__c);
        
        CLRef.CRM_IsActive__c = false;
        Insert CLRef2;
      
        CRM_EncounterHospitalJuntion__c EHJ=new CRM_EncounterHospitalJuntion__c();
       EHJ.CRM_Encounter__c =encInactive.id;
       EHJ.CRM_CampaignLocationMapping__c =CLRef2.id;
        insert EHJ;
        
        List<CRM_EncounterServiceLineSelection__c> refInactiveEncJuncObj=new List<CRM_EncounterServiceLineSelection__c> ();
        for(CRM_AudienceCriteriaRefData__c inactiveRec :inactiveRefEncDataList )
        {
        refInactiveEncJuncObj.add(new CRM_EncounterServiceLineSelection__c(CRM_Encounter__c=encInactive.id,CRM_AudienceCriteriaReferenceData__c=inactiveRec.id));
       
        }
        insert refInactiveEncJuncObj;
        
        
        
        CRM_CampaignRefJunction__c refJuncObj=new CRM_CampaignRefJunction__c ();
        refJuncObj.CRM_CampaignMapping__c=newCampaignInactiveValues.id;
        refJuncObj.CRM_CampaignWizardReferenceData__c=CLRef1.id;
        insert refJuncObj;
        
        
        CRM_EncounterAggHospitalJunction__c encAggHJUn = new CRM_EncounterAggHospitalJunction__c();
        encAggHJUn.CRM_EnocunterAggregates__c = encAgg.id;
        encAggHJUn.CRM_CampaignLocationEncAggMapping__c = CLRef.id;
        insert encAggHJUn;
        
        Campaign_Member_Criteria__c  CampMem = new Campaign_Member_Criteria__c  ();
        CampMem.Field_Name__c = 'Member_Types__c';
        CampMem.Value__c = 'Any or no encounters - Everyone';
        CampMem.Field_id__c = 'Member Type';
        CampMem.Exclude__c = false;
        CampMem.Category__c = 'Encounters';
        CampMem.Operator__c = 'AND';
        
        CampMem.WM_Sync_Type__c = 'Insert';
        CampMem.WM_Sync_Status__c = 'Synced';
        CampMem.Campaign__c = newCampaign.id;
        
        insert CampMem;
       
        
        Encounter_aggregates__c  EncAgg2 = new Encounter_aggregates__c  ();
        EncAgg2.CRM_SelectedPreferedHospitalCodes__c = 'CMB';
        EncAgg2.Most_Recent_Primary_Payor_Type__c = 'MANAGED CARE';
        EncAgg2.Preffered_Hospital__c = 'Citizens Medical Center';
        EncAgg2.Wunderman_Preferred_Hospitals__c = 'CMB';
       
        EncAgg2.Campaign__c = newCampaign.id;
        
        insert EncAgg2;
       
        
        pagereference testpage = new pagereference('/apex/ClonePlus');
        Test.setcurrentPage(testPage);
        //ClonePlusController.relatedObjects wrap = new ClonePlusController.relatedObjects(objectRows, pluralLabel, relatedFieldName);
        //ClonePlusController.cloneObjects(sObjects);
        ClonePlusController ClonePlus = new ClonePlusController();
        ClonePlus.initialiseObjectsForCloning(newCampaign.id);
        ClonePlusController.BeforeCloneValidation(newCampaignInactiveValues.id);
        ClonePlusController.BeforeCloneValidation(newCampaignInactiveValues1.id);
        
        ClonePlus.CampName = newCampaign;
       // ClonePlus.nochild = False;
        //ClonePlus.cloneSelectedObjects();
        //ClonePlus.campname_value1='234';
        //ReferenceData_PicklistController.getCampaignName(newCampaign.id);
    }
    
    public static testmethod void ClonePlusmethod2() 
    {
        Campaign newCampaign = new Campaign();
        newCampaign.Name = '20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        newCampaign.Service_Line__c = 'Burn';
        newCampaign.CRM_SubServiceLineText__c = 'Dermatology';
        newCampaign.Tactic__c = 'Mail';
        newCampaign.Member_Types__c = 'Campaign Segments';
        newCampaign.CRM_SelectedOwnershipCriteria__c = 'DT1';
        newCampaign.Channel__c = 'Direct Mail';
        newCampaign.Audience_Hospital__c = 'Massachusetts-St.Vincent Hospital';
        insert newCampaign;
        Campaign newCampaign1 = new Campaign();
        newCampaign1.Name = '20161206-102-Florida-Cardiovascular-Direct Mail-V1';
        newCampaign1.Service_Line__c = 'Burn';
        newCampaign1.CRM_SubServiceLineText__c = 'Dermatology';
        newCampaign1.Tactic__c = 'Mail';
        newCampaign1.Channel__c = 'Direct Mail';
        insert newCampaign1;
        Location__c Loc = new Location__c();
        loc.Market__c = 'Dellas';
        loc.Region__c = 'Texas';
        loc.HSPCD__c = 'test';
        loc.Hospital__c = 'Birmingham-Princeton Baptist Medical Center';
        insert Loc;
        campaignSequencer__c campsequencer = new campaignSequencer__c();
        campsequencer.Counter_Value__c = 999;
        campsequencer.Name = 'count';
        insert campsequencer;
        Campaign_Related_List__c RelatedList = new Campaign_Related_List__c();
        RelatedList.Name = 'Campaign_Demographics__c';
        insert RelatedList;
        String odlCampId = '889686ghj';
        String NewCampId = 'hydd';
        String pluralLabel = 'ffghhgv';
        String relatedFieldName = 'cghg';
        List < sObject > sObjects = new List < sObject > ();
        sObjects.add(newCampaign);
        Sobject obj = newCampaign;
       // ClonePlusController.relatedObjectRow wrap1 = new ClonePlusController.relatedObjectRow(obj);
      //  wrap1.getName();
      //  list < ClonePlusController.relatedObjectRow > objectRows = new list < ClonePlusController.relatedObjectRow > ();
      //  objectRows.add(wrap1);
        CRM_Search_Criteria__c CSC = new CRM_Search_Criteria__c();
        CSC.CRM_Search_Criteria_Level_1__c = 'By Region';
        CSC.CRM_Search_Criteria_Level_2__c = 'Primary Service Area';
        CSC.CRM_Search_Criteria_Level_3__c = 'Baylor/Tenet JV Region';
        CSC.CRM_AdditionalZipCodes__c = '1234';
        CSC.CRM_ExcludedZipCodes__c = '34566';
        CSC.CRM_Campaign__c = newCampaign.id;
        insert CSC;

        pagereference testpage = new pagereference('/apex/ClonePlus');
        Test.setcurrentPage(testPage);
       // ClonePlusController.relatedObjects wrap = new ClonePlusController.relatedObjects(objectRows, pluralLabel, relatedFieldName);
       // ClonePlusController.cloneObjects(sObjects);
        ClonePlusController ClonePlus = new ClonePlusController();
        ClonePlus.CampName = newCampaign;
        
       // ClonePlus.nochild = False;
        //ClonePlus.campname_value1='234'; 
        //ClonePlus.initialiseObjectsForCloning(newCampaign.id);
        //ClonePlus.cloneSelectedObjects();
        //ReferenceData_PicklistController.getCampaignName(newCampaign.id);
    }
    
    public static testmethod void ClonePlusmethod1() 
    {
        Campaign newCampaign = new Campaign();
        newCampaign.Name = '20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        newCampaign.Service_Line__c = 'Burn';
        newCampaign.CRM_SubServiceLineText__c = 'Dermatology';
        newCampaign.Tactic__c = 'Print Banners';

        newCampaign.CRM_SelectedOwnershipCriteria__c = 'DT1';
        newCampaign.Channel__c = 'Direct Mail';
        newCampaign.Audience__c = 'Texas-East Texas';
        insert newCampaign;
        Campaign newCampaign1 = new Campaign();
        newCampaign1.Name = '20161206-102-Florida-Cardiovascular-Direct Mail-V1';
        newCampaign1.Service_Line__c = 'Burn';
        newCampaign1.CRM_SubServiceLineText__c = 'Dermatology';
        newCampaign1.Tactic__c = 'Mail';
        newCampaign1.Channel__c = 'Direct Mail';
        insert newCampaign1;
        campaignSequencer__c campsequencer = new campaignSequencer__c();
        campsequencer.Counter_Value__c = 999;
        campsequencer.Name = 'count';
        insert campsequencer;
        Campaign_Related_List__c RelatedList = new Campaign_Related_List__c();
        RelatedList.Name = 'Campaign_Demographics__c';
        insert RelatedList;
        String odlCampId = '896868';
        String NewCampId = 'hydd';
        String pluralLabel = 'ffghhgv';
        String relatedFieldName = 'cghg';
        List < sObject > sObjects = new List < sObject > ();
        sObjects.add(newCampaign);
        Sobject obj = newCampaign;
     //   ClonePlusController.relatedObjectRow wrap1 = new ClonePlusController.relatedObjectRow(obj);
     //   wrap1.getName();
     //   list < ClonePlusController.relatedObjectRow > objectRows = new list < ClonePlusController.relatedObjectRow > ();
       // objectRows.add(wrap1);

        CRM_Search_Criteria__c CSC = new CRM_Search_Criteria__c();
        CSC.CRM_Search_Criteria_Level_1__c = 'By Region';
        CSC.CRM_Search_Criteria_Level_2__c = 'Primary Service Area';
        CSC.CRM_Search_Criteria_Level_3__c = 'Baylor/Tenet JV Region';
        CSC.CRM_AdditionalZipCodes__c = '1234';
        CSC.CRM_ExcludedZipCodes__c = '34566';
        CSC.CRM_Campaign__c = newCampaign.id;
        insert CSC;
        pagereference testpage = new pagereference('/apex/ClonePlus');
        Test.setcurrentPage(testPage);
     //   ClonePlusController.relatedObjects wrap = new ClonePlusController.relatedObjects(objectRows, pluralLabel, relatedFieldName);
     //   ClonePlusController.cloneObjects(sObjects);
        ClonePlusController ClonePlus = new ClonePlusController();
        ClonePlus.CampName = newCampaign;
      //  ClonePlus.nochild = False;
        //ClonePlus.campname_value1='234';
        //ClonePlus.initialiseObjectsForCloning(newCampaign.id);
        //ClonePlus.cloneSelectedObjects();
        //ReferenceData_PicklistController.getCampaignName(newCampaign.id);
    }
    
    public static testmethod void ClonePlusmethod3() 
    {
        Campaign newCampaign = new Campaign();
        newCampaign.Name = '20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        newCampaign.Service_Line__c = 'Burn';
        newCampaign.CRM_SubServiceLineText__c = 'Dermatology';
        newCampaign.Tactic__c = 'Mail';

        newCampaign.CRM_SelectedOwnershipCriteria__c = 'DT1';
        newCampaign.Channel__c = 'Direct Mail';
        newCampaign.Audience_Region__c = 'Texas';
        insert newCampaign;
        Campaign newCampaign1 = new Campaign();
        newCampaign1.Name = '20161206-102-Florida-Cardiovascular-Direct Mail-V1';
        newCampaign1.Service_Line__c = 'Burn';
        newCampaign1.CRM_SubServiceLineText__c = 'Dermatology';
        newCampaign1.Tactic__c = 'Mail';
        newCampaign1.Channel__c = 'Direct Mail';
        insert newCampaign1;

        campaignSequencer__c campsequencer = new campaignSequencer__c();
        campsequencer.Counter_Value__c = 999;
        campsequencer.Name = 'count';
        insert campsequencer;
        Campaign_Related_List__c RelatedList = new Campaign_Related_List__c();
        RelatedList.Name = 'Campaign_Demographics__c';
        insert RelatedList;
        String odlCampId = '786768';
        String NewCampId = 'hydd';
        String pluralLabel = 'ffghhgv';
        String relatedFieldName = 'cghg';
        List < sObject > sObjects = new List < sObject > ();
        sObjects.add(newCampaign);
        Sobject obj = newCampaign;
      //  ClonePlusController.relatedObjectRow wrap1 = new ClonePlusController.relatedObjectRow(obj);
      //  wrap1.getName();
      //  list < ClonePlusController.relatedObjectRow > objectRows = new list < ClonePlusController.relatedObjectRow > ();
     //   objectRows.add(wrap1);

        CRM_Search_Criteria__c CSC = new CRM_Search_Criteria__c();
        CSC.CRM_Search_Criteria_Level_1__c = 'By Region';
        CSC.CRM_Search_Criteria_Level_2__c = 'Primary Service Area';
        CSC.CRM_Search_Criteria_Level_3__c = 'Baylor/Tenet JV Region';
        CSC.CRM_AdditionalZipCodes__c = '1234';
        CSC.CRM_ExcludedZipCodes__c = '34566';
        CSC.CRM_Campaign__c = newCampaign.id;
        insert CSC;

        pagereference testpage = new pagereference('/apex/ClonePlus');
        Test.setcurrentPage(testPage);
       // ClonePlusController.relatedObjects wrap = new ClonePlusController.relatedObjects(objectRows, pluralLabel, relatedFieldName);
      //  ClonePlusController.cloneObjects(sObjects);
        ClonePlusController ClonePlus = new ClonePlusController();
        ClonePlus.CampName = newCampaign;
       // ClonePlus.nochild = False;
        //ClonePlus.campname_value1='234';
       // ClonePlus.initialiseObjectsForCloning(newCampaign.id);
        //ClonePlus.cloneSelectedObjects();
        //ReferenceData_PicklistController.getCampaignName(newCampaign.id);
    }
    
    public static testmethod void ClonePlusmethodtestmethod() 
    {
        Campaign newCampaign = new Campaign();
        newCampaign.Name = '20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        newCampaign.Service_Line__c = 'Burn';
        newCampaign.CRM_SubServiceLineText__c = 'Dermatology';
        newCampaign.Tactic__c = 'Mail';
        newCampaign.Channel__c = 'Direct Mail';

        newCampaign.CRM_SelectedOwnershipCriteria__c = 'DT1';
        newCampaign.Audience_Hospital__c = 'Phoenix-Abrazo Arrowhead Campus';
        newCampaign.Audience_Region__c = 'Texas';
        insert newCampaign;
        Location__c loc = new Location__c();
        loc.HSPCD__c = 'test';
        loc.Hospital__c = 'Phoenix-Abrazo Arrowhead Campus';
        loc.Zip_Code__c = '110098';
        insert loc;
        campaignSequencer__c campsequencer = new campaignSequencer__c();
        campsequencer.Counter_Value__c = 999;
        campsequencer.Name = 'count';
        insert campsequencer;
        Campaign_Related_List__c RelatedList = new Campaign_Related_List__c();
        RelatedList.Name = 'Campaign_Demographics__c';
        insert RelatedList;
        String odlCampId = '786768';
        String NewCampId = 'hydd';
        String pluralLabel = 'ffghhgv';
        String relatedFieldName = 'cghg';
        List < sObject > sObjects = new List < sObject > ();
        sObjects.add(newCampaign);
        Sobject obj = newCampaign;
      //  ClonePlusController.relatedObjectRow wrap1 = new ClonePlusController.relatedObjectRow(obj);
      //  wrap1.getName();
      //  list < ClonePlusController.relatedObjectRow > objectRows = new list < ClonePlusController.relatedObjectRow > ();
     //   objectRows.add(wrap1);

        pagereference testpage = new pagereference('/apex/ClonePlus');
        Test.setcurrentPage(testPage);
     //   ClonePlusController.relatedObjects wrap = new ClonePlusController.relatedObjects(objectRows, pluralLabel, relatedFieldName);
       // ClonePlusController.cloneObjects(sObjects);
        ClonePlusController ClonePlus = new ClonePlusController();

        ClonePlus.CampName = newCampaign;
        boolean nameFlag = False;
        //ReferenceData_PicklistController.getCampaignName(newCampaign.id);
    }


}
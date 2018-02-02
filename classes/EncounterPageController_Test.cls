@istest
public class EncounterPageController_Test 
{
    public static testmethod void locationtestmethod()
    { 
            Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';        
            insert newCampaign;
            
            Location__c loc = new Location__c();
            loc.Hospital__c='Alabama - Citizens Medical Center';
            insert loc;
            List<Location__c> SelectedHospitalName=[Select Hospital__c FROM Location__c where id=:loc.id];              
            Encounter__c  encount = new Encounter__c();
            encount.Campaign__c= newCampaign.Id;
            encount.Discharge_Date__c=Date.newInstance(2015,01,20);
            encount.Discharge_Date_To__c=Date.newInstance(2016,01,20);
            encount.HospitalIds__c='DHF;AHH';
            encount.Number_of_ER_Encounters__c='50';
            encount.Number_of_ER_Encounters_to__c='99';
            encount.Include_Facility_ID__c='334';
            encount.Exclude_Facility_IDs__c='304';
            encount.Include_Physician_NPIs__c='704';
            encount.To_discharge_date_encounter__c=system.today();
            encount.Discharge_Date_encounter__c=Date.newInstance(2015,01,20);
            encount.Exclude_Physician_NPIs__c='704';
            insert encount;
            
                    
            Model__c campaignModel = New Model__c();
            campaignModel.Campaign__c= newCampaign.Id;
            campaignModel.Model_1_from__c='0';
            campaignModel.Model_1_to__c='0';
            campaignModel.Model_2_from__c='0';
            campaignModel.Model_3_from__c='0';
            campaignModel.Model_4_from__c='0';
            campaignModel.Model_2_to__c='0';
            campaignModel.Model_3_to__c='0';
            campaignModel.Model_4_to__c='0';       
            campaignModel.Model_Cardiology_Ranges__c='0';
            campaignModel.Model_Ortho_Hip_Ranges__c='0';
            campaignModel.Model_Ortho_Knee_Ranges__c='0';
            campaignModel.Model_Ortho_Spine_Ranges__c='0';    
            insert campaignModel;
            
            Account acc = new Account();
            acc.Name='test';
            insert acc;
            
            contact con = new Contact();
            con.AccountId = acc.id;
            con.LastName='test';
            insert con;
            
            Interaction__c interaction = new Interaction__c();
            interaction.Response_By_Campaign_Member__c = con.id;
            interaction.Response_For_Campaign__c = newCampaign.id ;
            insert interaction;
            
            
            Life_Style__c lifestyle = new Life_Style__c();
            lifestyle.Campaign__c= newCampaign.Id;
            
           lifestyle.Health_Index_Manage_Bus_of_Health__c='1'; 
           lifestyle.Health_Index_Manage_Bus_of_Health_To__c='1';
           //lifestyle.Health_Index_Manage_Illness_Condition_Fr__c='1';
           //lifestyle.Health_Index_Illness_or_Condition_To__c='1';
           lifestyle.Health_Index_Manage_Health_From__c='1';  
           lifestyle.Health_Index_Manage_Health_To__c='1';  
            insert lifestyle;
            
            Campaign_Demographics__c demographic = new Campaign_Demographics__c();
            demographic.Campaign__c= newCampaign.Id;
            demographic.Birthdate__c=system.today();
            demographic.to_1__c=system.today();
            demographic.Number_of_Children__c='200';
            demographic.to_Number_of_Children__c='100';
            demographic.to_Number_of_Persons_in_HH__c='100';
            demographic.Number_of_Persons_in_HH__c='2';
            demographic.Number_of_Adults_in_HH__c='20';
            demographic.to_Number_of_Adults_in_HH__c='10';
            demographic.Est_Discretionary_Income_Percent__c='22';
            demographic.Age__c='2';
            demographic.AgeTo_UI__c =21;
            demographic.AgeFrom_UI__c =23;
            demographic.Move_Activity_in_Months__c ='01';
            insert demographic;
            
            
            Procedures__c Procedures = new Procedures__c();
            Procedures.Code__c='Test';
            insert Procedures;
            
            Procedure_Information__c procedureInfo = new Procedure_Information__c();
            procedureInfo.Campaign__c=newCampaign.Id;
            procedureInfo.ICD_CPT_Procedures__c=Procedures.Id;
            insert procedureInfo;
            
            DRG_Code_Information__c DrgCodeinfo = new DRG_Code_Information__c();
            DrgCodeinfo.Campaign__c=newcampaign.id;
            insert DrgCodeinfo;
            
            ICD_Diagnosis__c IcdDiagnosis = new ICD_Diagnosis__c();
            IcdDiagnosis.DIAGNOSIS_CODE__c='Test';
            insert IcdDiagnosis;
            
            ICD_Diagnosis_In__c ICD_DiagnosisInfo = new ICD_Diagnosis_In__c ();
            ICD_DiagnosisInfo.Campaign__c=newcampaign.Id;
            ICD_DiagnosisInfo.ICD_Diagnosis__c=IcdDiagnosis.Id;
            insert ICD_DiagnosisInfo;
            
            Encounter_aggregates__c  encounteraggregate = new Encounter_aggregates__c();
            encounteraggregate.Campaign__c=newcampaign.Id;
            encounteraggregate.Number_of_ER_Encounters_To__c='999';
            encounteraggregate.Number_of_ER_Encounters__c='999';
            encounteraggregate.Last_Discharge_Date_From_UI__c=NULL;
            encounteraggregate.Last_Discharge_Date_Criteria_Element_Id__c='test';
            encounteraggregate.Last_Discharge_Date_Ranges__c='test';
            encounteraggregate.Last_Discharge_Date_To_UI__c=NULL;
            encounteraggregate.No_of_ER_Encounters_ranges__c='test';
            encounteraggregate.Preffered_Hospital__c='Alabama - Citizens Medical Center';
            encounteraggregate.Wunderman_Preferred_Hospitals__c='test';
            insert encounteraggregate;
            
            
            
             Campaign_Member_Search_Critera__c campsearch=new Campaign_Member_Search_Critera__c();
            campsearch.Name='Ailments';
            campsearch.Inner_Operator__c='OR';
            campsearch.Outer_Operator__c='AND';
            campsearch.Requires_SubGroup__c=true;
            insert campsearch;
            
           
            
            Campaign_Member_Search_Critera__c campsearch2=new Campaign_Member_Search_Critera__c();
            campsearch2.Name='Survey Responses';
            campsearch2.Inner_Operator__c='OR';
            campsearch2.Outer_Operator__c='AND';
            campsearch2.Requires_SubGroup__c=true;
            insert campsearch2;
            
             Campaign_Member_Search_Critera__c campsearch3=new Campaign_Member_Search_Critera__c();
            campsearch3.Name='Health Insurance';
            campsearch3.Inner_Operator__c='AND';
            campsearch3.Outer_Operator__c='AND';
            campsearch3.Requires_SubGroup__c=true;
            insert campsearch3;
            
            Campaign_Member_Search_Critera__c campsearch4=new Campaign_Member_Search_Critera__c();
            campsearch4.Name='Health Indices';
            campsearch4.Inner_Operator__c='AND';
            campsearch4.Outer_Operator__c='AND';
            campsearch4.Requires_SubGroup__c=true;
            insert campsearch4;
            
            
            
            Campaign_Member_Criteria__c  cmpmem = marketingDataUtils.createCampaignMemberCriteria(newCampaign.id);
            Campaign_Member_Criteria_Group__c cmpmemgrp = marketingDataUtils.createCampaignmemgrp(newCampaign.id);
            Data_Element_Identifier__c elemnt = new Data_Element_Identifier__c();
            elemnt.Criteria_Group_Name__c='Health Indices';
            elemnt.Name='HXMBOH';
            elemnt.Field_Name__c='Health_Index_Manage_Bus_of_Health_ranges__c';
            insert elemnt;
            
            Data_Element_Identifier__c elemnt2 = new Data_Element_Identifier__c();
            elemnt2.Criteria_Group_Name__c='Health Indices';
            elemnt2.Name='HXMBOH';
            elemnt2.Field_Name__c='Health_Index_Manage_Health_ranges__c';
            insert elemnt2;
        
           CRM_CampaignLocationReferenceData__c refMarket = marketingDataUtils.createrefHospital();
           CRM_EncounterHospitalJuntion__c junc = new CRM_EncounterHospitalJuntion__c();
            junc.CRM_CampaignLocationMapping__c=refMarket.id;
            junc.CRM_Encounter__c=encount.id;
        insert junc;
           CRM_EncounterAggHospitalJunction__c encjunc = new CRM_EncounterAggHospitalJunction__c();
            encjunc.CRM_CampaignLocationEncAggMapping__c=refMarket.id;
            encjunc.CRM_EnocunterAggregates__c=encounteraggregate.id;
        insert encjunc;

            PageReference pageRef = Page.EncountersPage;
            Test.setCurrentPage(pageRef);
            ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(newCampaign);
            ApexPages.currentPage().getParameters().put('Id',newCampaign.id);  
            ApexPages.currentPage().getParameters().put('Lifeid',lifestyle.id);
            ApexPages.currentPage().getParameters().put('demo',demographic.Id);
            ApexPages.currentPage().getParameters().put('encounter',encount.Id);
            ApexPages.currentPage().getParameters().put('encounteraggid',encounteraggregate.Id);
            ApexPages.currentPage().getParameters().put('encounteraggregates',encounteraggregate.Id);
            ApexPages.currentPage().getParameters().put('encagg',encounteraggregate.Id);            
            ApexPages.currentPage().getParameters().put('Modelid',campaignModel.id);
            ApexPages.currentPage().getParameters().put('lifestyle',lifestyle.id);
            ApexPages.currentPage().getParameters().put('btn','1');
            
            EncounterPageController encounter = new EncounterPageController(sc);

            system.debug('EditCriteria&&&&&&'+encounter);
            encounter.campgn=newCampaign;
            encounter.model=campaignModel;       
            encounter.demo.Number_of_Children__c ='2';
            encounter.age_from = 123;
            encounter.age_to = 121;
            Test.startTest();
            encounter.addDRG();
            encounter.AddIcd();
            encounter.IncludeProcedure();
            encounter.enc_back();
            List<SelectOption> selOpts=encounter.lstServiceLinevalues;
            encounter.DetailPage=True;
            string fieldName ='Procedure_Code__c';
            string value = 'Zipcode';
            //Id campaignId = newCampaign.id;
            string stringcampaignId = newCampaign.id;
            boolean exclude = true;
            boolean hasFacilityChange =false;
            string objectname ='Geographic_Info_Information__c';
            //encounter.SaveEncounterCriteria();
            
            encounter.SaveDemoCount();         
            encounter.SaveModel();
            encounter.preparePiclistFields();
            encounter.prepareHospitalchosenPiclistFields();
            encounter.cancelencountercriteria();
            encounter.canceldemographicscriteria();
            encounter.cancelmodelcriteria();
         Id campaignId = newCampaign.id;
            encounter.EditCriteria();
            system.debug('EditCriteria&&&&&&'+encounter);
            encounter.cancellifestylecriteria();
            encounter.encagg=encounteraggregate;
            encounter.cancelencounteraggregatescriteria();
            encounter.excludeDRG();
            encounter.ExcludeIcd();
            encounter.selectedpreferedhospitalCodes.add('DHF');
            encounter.SaveEncounterAggregatesCriteria();
            encounter.ExcludeProcedure();
            encounter.deleteAllProcedureInclusions();
            encounter.deleteAllDRGExclusions();
            encounter.deleteAllProcedureExclusions();
            encounter.deleteAllDRGInclusions();
            encounter.deleteAllICDDiagnosis();
            encounter.deleteAllDiagnosisExclusions();
            encounter.deleteAllDiagnosisInclusions();
            encounter.LifeStyleSave();
        
            
            Test.stopTest(); 
    
    }
    
    
    public static testmethod void locationtestmethod1()
    {
            
            Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';
            
            insert newCampaign;                    
            
            Account acc = new Account();
            acc.Name='test';
            insert acc;
            
            contact con = new Contact();
            con.AccountId = acc.id;
            con.LastName='test';
            insert con;
            
            
            Campaign_Member_Criteria__c  cmpmem = marketingDataUtils.createCampaignMemberCriteria(newCampaign.id);
            Campaign_Member_Criteria_Group__c cmpmemgrp = marketingDataUtils.createCampaignmemgrp(newCampaign.id);
            Data_Element_Identifier__c elemnt = new Data_Element_Identifier__c();
            elemnt.Criteria_Group_Name__c='Ailments';
            elemnt.Name='new';
            elemnt.Field_Name__c='Procedure_Code__c';
            insert elemnt;
            PageReference pageRef = Page.EncountersPage;
            Test.setCurrentPage(pageRef);
            ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(newCampaign);
            ApexPages.currentPage().getParameters().put('Id',newCampaign.id);  
           // ApexPages.currentPage().getParameters().put('itr',interaction.id);  
           // ApexPages.currentPage().getParameters().put('itrid',Null);  
            //ApexPages.currentPage().getParameters().put('btn','6');
            EncounterPageController encounter = new EncounterPageController(sc);
            
            encounter.button=6;
            encounter.demo.Number_of_Children__c ='2';
          //  encounter.SaveItrCount();
            
    }
    
    
    
    
    public static testmethod void saveDemocountmethod()
    {

            Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';        
            insert newCampaign;      
            Campaign_Member_Criteria_Group__c cmpmemgrp = marketingDataUtils.createCampaignmemgrp(newCampaign.id);
            Campaign_Member_Criteria__c cmpmem = new Campaign_Member_Criteria__c();
            cmpmem.Campaign__c=newCampaign.id;
            cmpmem.Exclude__c=true;
            cmpmem.Field_Name__c='Procedure_Code__c';
            cmpmem.Category__c='Ailments';
            insert cmpmem;
        
            Campaign_Member_Search_Critera__c searchmem = new Campaign_Member_Search_Critera__c();
            searchmem.Name='Geographics';
            searchmem.Inner_Operator__c = 'OR';
            searchmem.Outer_Operator__c = 'AND';
            searchmem.Requires_SubGroup__c = True;
            insert searchmem;
            
            Encounter__c  encount = new Encounter__c();
            encount.Campaign__c= newCampaign.Id;
            encount.Discharge_Date__c=Date.newInstance(1980 , 10 ,20);
            encount.Discharge_Date_To__c=Date.newInstance(1970 , 10 ,20);
            encount.HospitalIds__c='test';
            encount.Number_of_ER_Encounters__c='2000';
            encount.Number_of_ER_Encounters_to__c='1999';
            encount.Include_Facility_ID__c='testthis';
            encount.Exclude_Facility_IDs__c='this';
            encount.Include_Physician_NPIs__c='this';
            encount.Exclude_Physician_NPIs__c='test';
            insert encount;
            
            Campaign_Demographics__c demographic = new Campaign_Demographics__c();
            demographic.Campaign__c= newCampaign.Id;
            Demographic.Preferred_Contact_Method__c='Phone';    
            Demographic.Est_Discretionary_Income_Percent_to__c='22';     
            Demographic.Assimilation__c='Unknown';    
            Demographic.Dwelling_Type__c='Multi Family Dwelling/Apartment';    
            Demographic.Est_Household_Debt_Level__c='A = $0';    
            Demographic.Est_Household_Income_3_0__c='Less than $15,000';    
            Demographic.Ethnic_Group__c='African American';    
            Demographic.Ethcinity__c='Arab';    
            Demographic.Gender__c='Female';    
            Demographic.Generations_2_0__c='Age Defying Techies';    
            Demographic.Language__c='Afrikaans';  
            Demographic.AgeTo_UI__c =21;
            Demographic.AgeFrom_UI__c =23;
            Demographic.Move_Activity_in_Months__c ='01';
            Demographic.Net_Worth_3_0__c='$0 or Less';    
            Demographic.Presence_of_Children__c= true; 
            Demographic.Presence_of_Elderly_Parents__c=true;    
            Demographic.Presence_of_Donor__c=true;    
            Demographic.Religion__c='Buddhist';       
            Demographic.Race__c='Asian';     Demographic.to_Number_of_Persons_in_HH__c='Test';     Demographic.Suppression_Non_emailable__c='Has an email address';    Demographic.Move_Activity_in_Months__c='01';    Demographic.Address_Deliverable__c='Has a valid or foreign mailing address'; 
            demographic.Birthdate__c=Date.newinstance(1993,03,01);
            demographic.to_1__c=Date.newinstance(2016,12,12);
            demographic.Number_of_Children__c='10';
            demographic.to_Number_of_Children__c='20';
            demographic.to_Number_of_Persons_in_HH__c='10';
            demographic.Number_of_Persons_in_HH__c='2';
            demographic.Number_of_Adults_in_HH__c='10';
            demographic.to_Number_of_Adults_in_HH__c='20';
            demographic.Est_Discretionary_Income_Percent__c='21';
            demographic.DOBFrom_UI__c=system.today();
            demographic.DOBTo_UI__c=system.today();
            insert demographic;        
            CRM_CampaignLocationReferenceData__c loc = marketingdatautils.createrefHospital();
            PageReference pageRef = Page.EncountersPage;
            Test.setCurrentPage(pageRef);
            ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(newCampaign);
            ApexPages.currentPage().getParameters().put('Id',newCampaign.id);          
            ApexPages.currentPage().getParameters().put('encounter',encount.Id);
            
            ApexPages.currentPage().getParameters().put('Demo',demographic.Id);
            //ApexPages.currentPage().getParameters().put('Demoid',Null);
            string fieldName ='Procedure_Code__c';
            string value = 'Zipcode';
            Id campaignId = newCampaign.id;
            string stringcampaignId = newCampaign.id;
            boolean exclude = true;
            string objectname ='Geographic_Info_Information__c';
            EncounterPageController encounter = new EncounterPageController(sc);
            encounter.Demo=demographic;
            encounter.age_from = 118;
            encounter.age_to = 119;   
                   
             encounter.SaveDemoCount();  
            
    }
    public static testmethod void saveDemocountmethod1()
    {
        
        Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';        
        insert newCampaign;      
       
Campaign_Member_Criteria_Group__c  grp = new Campaign_Member_Criteria_Group__c();
        grp.Campaign__c=newCampaign.id;
        grp.Exclude__c = false;
        grp.Group_Name__c='Demographics';
        grp.WM_CriteriaGroup_Id__c='12';
        grp.WM_Parent_group_Id__c='677';
        grp.Inner_Operator__c = 'OR';
         insert grp;
    Campaign_Member_Criteria__c mem= new Campaign_Member_Criteria__c();
        mem.Campaign__c=newCampaign.id;
        mem.Exclude__c=true;
        mem.Category__c = 'Demographics';
        mem.Criteria_Group__c = grp.id;
        mem.Field_Name__c='New_Movers_Range__c';
           insert mem;        
     
        Data_Element_Identifier__c elementidentifier = new Data_Element_Identifier__c();
        elementidentifier.Data_Element_Identifier__c = 'ZIPCD';
        elementidentifier.Data_Element_Name__c='ZIP Code';
        elementidentifier.Display_Type_Code__c='GEO.MANUAL';
        elementidentifier.Criteria_Group_Name__c='Demographics';
        elementidentifier.Value_Mapping__c='{"Out Patient":"O","In Patient":"I"}';
        elementidentifier.Field_Name__c ='New_Movers_Range__c';
            insert elementidentifier;
        Campaign_Demographics__c demographic = new Campaign_Demographics__c();
            demographic.Campaign__c= newCampaign.Id;  
            demographic.Move_Activity_in_Months__c='01';
            demographic.DOBFrom_UI__c = Date.newInstance(1980 , 10 ,20);
            demographic.DOBTo_UI__c=Date.newInstance(1980 , 10 ,10);
            demographic.Birthdate_Ranges__c='34';
            demographic.CRM_Birth_Month__c='Any';
         
            demographic.Birthdate__c=Date.newInstance(1994,01,20);
            demographic.to_1__c=Date.newInstance(2016,01,20);
            //demographic.Number_of_Adults_in_HH__c='20';
        insert demographic;   

        PageReference pageRef = Page.EncountersPage;
        Test.setCurrentPage(pageRef);
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(newCampaign);
        ApexPages.currentPage().getParameters().put('Id',newCampaign.id);          
        //ApexPages.currentPage().getParameters().put('encounter',encount.Id);
        ApexPages.currentPage().getParameters().put('Demo',demographic.Id);
        
        
        
        EncounterPageController encounter = new EncounterPageController(sc);
        //encounter.Demo=demographic;
        //encounter.age_from = 218;
       // encounter.age_to = 219;
        
        encounter.SaveDemoCount();
    
    }   
  
                       
    public static testmethod void Test_SaveEncounterCriteria()
    { 
            
            Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';        
            insert newCampaign;
            
            Location__c loc = new Location__c();
            loc.Hospital__c='Alabama - Citizens Medical Center';
            loc.HSPCD__c='703';
            insert loc;
            List<Location__c> SelectedHospitalName=[Select Hospital__c FROM Location__c where id=:loc.id];              
            Encounter__c  encount = new Encounter__c();
            encount.Campaign__c= newCampaign.Id;
            encount.Exclude_Physician_NPIs__c='707';
            encount.HospitalIds__c='DHF;AHH';
            encount.Include_Facility_ID__c='8726;3453';
            
            insert encount;
            encount.Include_Facility_ID__c='8728;3455';      
            update  encount;
        CRM_CampaignLocationReferenceData__c refMarket = marketingDataUtils.createrefHospital();
        CRM_EncounterHospitalJuntion__c junc = new CRM_EncounterHospitalJuntion__c();
            junc.CRM_CampaignLocationMapping__c=refMarket.id;
            junc.CRM_Encounter__c=encount.id;
        insert junc;
            Schema.DescribeSObjectResult R = CRM_AudienceCriteriaRefData__c.SObjectType.getDescribe();
            List<Schema.RecordTypeInfo> RT = R.getRecordTypeInfos();
        
            ReferenceData_PicklistController.recordTypeDeveloperName('CRM_AudienceCriteriaRefData__c',RT[0].getRecordTypeId());
            
            list<CRM_AudienceCriteriaRefData__c> audienceSelectionRefDataList = new  list<CRM_AudienceCriteriaRefData__c>();
            audienceSelectionRefDataList.add(new CRM_AudienceCriteriaRefData__c(RecordTypeId=rt[0].getRecordTypeId(),CRM_IsActive__c=true,CRM_ClinicalServiceLine__c='Test',CRM_ClinicalServiceLineSyncData__c='TEST'));
            insert audienceSelectionRefDataList;
            audienceSelectionRefDataList.add(new CRM_AudienceCriteriaRefData__c(RecordTypeId=rt[1].getRecordTypeId(),CRM_IsActive__c=true,CRM_ClinicalServiceLineID__c=audienceSelectionRefDataList[0].Id,CRM_ClinicalSubServiceLine__c='Test',CRM_ClinicalSubServiceLineSyncData__c='TEST'));
            upsert audienceSelectionRefDataList;
                    
            list<CRM_EncounterServiceLineSelection__c> junobj= new list<CRM_EncounterServiceLineSelection__c>{
                new CRM_EncounterServiceLineSelection__c(CRM_AudienceCriteriaReferenceData__c=audienceSelectionRefDataList[0].id,CRM_Encounter__c=encount.id),
                new CRM_EncounterServiceLineSelection__c(CRM_AudienceCriteriaReferenceData__c=audienceSelectionRefDataList[1].id,CRM_Encounter__c=encount.id)};
            insert junobj;

         
            List<SelectOption> options = new List<SelectOption>();
           options.add(new SelectOption('Alabama - Citizens Medical Center','Memphis-Saint Francis Hospital-Bartlett'));
           options.add(new SelectOption('Phoenix-Abrazo Arizona Heart Hospital','South Carolina-Coastal Carolina Hospital'));
            
            Account acc = new Account();
            acc.Name='test';
            insert acc;
            
            contact con = new Contact();
            con.AccountId = acc.id;
            con.LastName='test';
            insert con;
            
            Campaign_Member_Search_Critera__c campsearch=new Campaign_Member_Search_Critera__c();
            campsearch.Name='Service Line';
            campsearch.Inner_Operator__c='OR';
            campsearch.Outer_Operator__c='AND';
            campsearch.Requires_SubGroup__c=true;
            insert campsearch;
            
            Campaign_Member_Criteria__c  cmpmem = marketingDataUtils.createCampaignMemberCriteria(newCampaign.id);
            Campaign_Member_Criteria_Group__c cmpmemgrp = marketingDataUtils.createCampaignmemgrp(newCampaign.id);
            list<Data_Element_Identifier__c> elemnt = new list<Data_Element_Identifier__c>{
               new Data_Element_Identifier__c(Criteria_Group_Name__c='Ailments',Field_Name__c='Facility_ID__c'),
               new Data_Element_Identifier__c(Criteria_Group_Name__c='Service Line',Field_Name__c='CRM_ServiceLine__c', Data_Element_Name__c='Service Line'),
               new Data_Element_Identifier__c(Criteria_Group_Name__c='Service Line',Field_Name__c='CRM_SubServiceLine__c',  Data_Element_Name__c='Sub Service Line')
            };          
            insert elemnt;

            PageReference pageRef = Page.EncountersPage;
            Test.setCurrentPage(pageRef);
            ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(newCampaign);
            ApexPages.currentPage().getParameters().put('Id',newCampaign.id);  
            ApexPages.currentPage().getParameters().put('encounter',encount.Id);
            ApexPages.currentPage().getParameters().put('btn','1');
            
            EncounterPageController encounter = new EncounterPageController(sc);
            
            encounter.selectedValSSL.add(audienceSelectionRefDataList[1].id);
            encounter.campgn=newCampaign;
            encounter.age_from = 123;
            encounter.age_to = 121;
            encount.Exclude_Physician_NPIs__c='770';
            //update encount;
            
            encounter.DetailPage=True;
            string fieldName ='Procedure_Code__c';
            string value = 'Zipcode';
            Id campaignId = newCampaign.id;
            string stringcampaignId = newCampaign.id;
            boolean exclude = true;
            boolean hasFacilityChange =False;
            encounter.DetailPage=True;
            test.startTest();
            encounter.selectedHospitalList=options;
            encounter.selectedhospitalCodes.add('DHF'); 
            encounter.SaveEncounterCriteria();
            encounter.selectedhospitalCodes.add('DHF'); 
            test.stopTest();
            
            
            
    }      
    
            
    public static testmethod void Test_SaveEncounterCriteria2()
    { 
            
            Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';        
            insert newCampaign;
            
            Location__c loc = new Location__c();
            loc.Hospital__c='Phoenix - Abrazo Arrowhead Campus';
            loc.Market__c='Phoenix Market';
            loc.HSPCD__c='703';
            insert loc;
            List<Location__c> SeelectedHospitalName=[Select Hospital__c FROM Location__c where id=:loc.id];              
            Encounter__c  encount = new Encounter__c();
            encount.Campaign__c= newCampaign.Id;
            encount.To_discharge_date_encounter__c=Date.newInstance(2015,01,20);
            encount.Include_Facility_ID__c='703';
            encount.Exclude_Facility_IDs__c='567';
            encount.Include_Physician_NPIs__c='610';
            encount.Exclude_Physician_NPIs__c='707';
            encount.HospitalIds__c='703;504';
            insert encount;
          
            encount.Include_Physician_NPIs__c='610';
            encount.Exclude_Physician_NPIs__c='707';
            encount.HospitalIds__c='702;504';
            update encount;
        
            Account acc = new Account();
            acc.Name='test';
            insert acc;
            
            contact con = new Contact();
            con.AccountId = acc.id;
            con.LastName='test';
            insert con;
            
            
            Campaign_Member_Criteria__c  cmpmem = marketingDataUtils.createCampaignMemberCriteria(newCampaign.id);
            Campaign_Member_Criteria_Group__c cmpmemgrp = marketingDataUtils.createCampaignmemgrp(newCampaign.id);
            Data_Element_Identifier__c elemnt = new Data_Element_Identifier__c();
            elemnt.Criteria_Group_Name__c='Ailments';
            elemnt.Name='new';
            elemnt.Field_Name__c='Facility_ID__c';
            insert elemnt;
            
            PageReference pageRef = Page.EncountersPage;
            Test.setCurrentPage(pageRef);
            ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(newCampaign);
            ApexPages.currentPage().getParameters().put('Id',newCampaign.id);  
            ApexPages.currentPage().getParameters().put('encounter',encount.Id);
            ApexPages.currentPage().getParameters().put('btn','1');
            
            EncounterPageController encounter = new EncounterPageController(sc);
            encounter.campgn=newCampaign;
            encounter.age_from = 123;
            encounter.age_to = 121;
        list<SelectOption> sa=new list<SelectOption>();
        sa.add(new SelectOption('Phoenix-Abrazo Arizona Heart Hospital','Memphis-Saint Francis Hospital-Bartlett'));
        sa.add(new SelectOption('San Antonio-Baptist Medical Center','Alabama-Brookwood Medical Center')); 
            encounter.selectedHospitalList=sa;
            encounter.SelectedHospitalName=SeelectedHospitalName;
            encounter.DetailPage=True;
            string fieldName ='Procedure_Code__c';
            string value = 'Zipcode';
            Id campaignId = newCampaign.id;
            string stringcampaignId = newCampaign.id;
            boolean exclude = true;
            boolean hasFacilityChange =False;
            
            hasFacilityChange = true;
            encounter.DetailPage=True;
           
            test.startTest();
            	encounter.SaveEncounterCriteria();
            test.stopTest();
           
    }      
   public static testmethod void Test_SaveEncounterCriteria3()
    { 
            
     Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';        
            insert newCampaign;
            String HospitalCodes='704';
            
            Location__c loc = new Location__c();
            loc.Hospital__c='Abrazo Scottsdale Campus';
            loc.HSPCD__c='PVA';
            insert loc;
        
            List<Location__c> SelectedHospitalName=[Select Hospital__c FROM Location__c where id=:loc.id];  
            List<Location__c > SelectedHospitalCode= [Select Hospital__c FROM Location__c where id=:loc.id];             
            Encounter__c  encount = new Encounter__c();
            encount.Campaign__c= newCampaign.Id;
            encount.Include_Facility_ID__c='87328';
            encount.Number_of_ER_Encounters__c='02';
            encount.Number_of_ER_Encounters_to__c='08';
            encount.Exclude_Facility_IDs__c='8733';
            encount.Discharge_Date_encounter__c=Date.newInstance(2017,01,20);
            //encount.To_discharge_date_encounter__c=Date.newInstance(2016,01,20);
            insert encount;
            encount.Number_of_ER_Encounters_to__c='08';
            encount.Exclude_Facility_IDs__c='8763';
             update encount;
        
            Account acc = new Account();
            acc.Name='test';
            insert acc;
            
            contact con = new Contact();
            con.AccountId = acc.id;
            con.LastName='test';
            insert con;
            
            
       Campaign_Demographics__c demographic = new Campaign_Demographics__c();       
            demographic.Campaign__c= newCampaign.Id;
            demographic.AgeFrom_UI__c=123;
            insert demographic;
            
            Campaign_Member_Search_Critera__c campsearch=new Campaign_Member_Search_Critera__c();
            campsearch.Name='Encounter Aggregates';
            campsearch.Inner_Operator__c='AND';
            campsearch.Outer_Operator__c='AND';
            insert campsearch;
            Campaign_Member_Criteria__c  cmpmem = marketingDataUtils.createCampaignMemberCriteria(newCampaign.id);
            Campaign_Member_Criteria_Group__c cmpmemgrp = marketingDataUtils.createCampaignmemgrp(newCampaign.id);
            Data_Element_Identifier__c elemnt = new Data_Element_Identifier__c();
            elemnt.Criteria_Group_Name__c='Encounter Aggregates';
            elemnt.Name='THCNUMERENC';
            elemnt.Field_Name__c='No_of_ER_Encounters_ranges__c';
            insert elemnt;
            PageReference pageRef = Page.EncountersPage;
            Test.setCurrentPage(pageRef);
            ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(newCampaign);
            ApexPages.currentPage().getParameters().put('Id',newCampaign.id); 
            ApexPages.currentPage().getParameters().put('encounter',encount.Id);
            ApexPages.currentPage().getParameters().put('demo',demographic.Id);
            ApexPages.currentPage().getParameters().put('btn','1');
            
            EncounterPageController encounter = new EncounterPageController(sc);
            encounter.campgn=newCampaign;
            encounter.age_from = 123;
            encounter.age_to = 121;
            
            encounter.DetailPage=True;
            string fieldName ='Procedure_Code__c';
            string value = 'Zipcode';
            Id campaignId = newCampaign.id;
            string stringcampaignId = newCampaign.id;
            boolean exclude = true;
            boolean hasFacilityChange =true;
            boolean insercriteriaflag=true;
            
            encounter.DetailPage=True;
            encount.Number_of_ER_Encounters__c='03';
            encount.Number_of_ER_Encounters_to__c='09';
            
            test.startTest();
            encounter.SaveDemoCount();
            encounter.SaveEncounterCriteria();
            update encount;
            test.stopTest();
                        
            
            
    }      
    
     public static testmethod void Test_Demo3()
    { 
            
            Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';        
            insert newCampaign;
            String HospitalCodes='704';
            
            Location__c loc = new Location__c();
            loc.Hospital__c='Alabama - Citizens Medical Center';
            loc.HSPCD__c='703';
            insert loc;
            List<Location__c> SelectedHospitalName=[Select Hospital__c FROM Location__c where id=:loc.id];  
            List<Location__c > SelectedHospitalCode= [Select Hospital__c FROM Location__c where id=:loc.id];             
            Encounter__c  encount = new Encounter__c();
            encount.Campaign__c= newCampaign.Id;
            encount.Number_of_ER_Encounters__c='03';
            encount.Number_of_ER_Encounters_to__c='04';
            encount.HospitalIds__c='703;504';
                        insert encount;
            
            
            Account acc = new Account();
            acc.Name='test';
            insert acc;
            
            contact con = new Contact();
            con.AccountId = acc.id;
            con.LastName='test';
            insert con;
            
             Campaign_Demographics__c demographic = new Campaign_Demographics__c();
            demographic.Campaign__c= newCampaign.Id;
            demographic.Birthdate__c=system.today();
            demographic.to_1__c=system.today();
            demographic.Number_of_Children__c='200';
            demographic.to_Number_of_Children__c='100';
            demographic.to_Number_of_Persons_in_HH__c='100';
            demographic.Number_of_Persons_in_HH__c='2';
            demographic.Number_of_Adults_in_HH__c='20';
            demographic.to_Number_of_Adults_in_HH__c='10';
            demographic.Est_Discretionary_Income_Percent__c='22';
            demographic.Age__c='2';
            
             demographic.Preferred_Contact_Method__c='Phone';
            demographic.DOBFrom_UI__c=Date.newInstance(1990,01,20);
            demographic.DOBTo_UI__c=Date.newInstance(2000,01,20);
            demographic.AgeTo_UI__c =21;
            demographic.AgeFrom_UI__c =null;
           
            insert demographic;
            
            Campaign_Member_Criteria__c  cmpmem = marketingDataUtils.createCampaignMemberCriteria(newCampaign.id);
            Campaign_Member_Criteria_Group__c cmpmemgrp = marketingDataUtils.createCampaignmemgrp(newCampaign.id);
            Data_Element_Identifier__c elemnt = new Data_Element_Identifier__c();
            elemnt.Criteria_Group_Name__c='Ailments';
            elemnt.Name='new';
            elemnt.Field_Name__c='Facility_ID__c';
            insert elemnt;
            PageReference pageRef = Page.EncountersPage;
            Test.setCurrentPage(pageRef);
            ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(newCampaign);
            ApexPages.currentPage().getParameters().put('Id',newCampaign.id);  
            ApexPages.currentPage().getParameters().put('encounter',encount.Id);
            ApexPages.currentPage().getParameters().put('demo',demographic.Id);
            
            ApexPages.currentPage().getParameters().put('btn','1');
            
            EncounterPageController encounter = new EncounterPageController(sc);
            encounter.campgn=newCampaign;
            encounter.age_from = 123;
            encounter.age_to = 121;
            
            encounter.DetailPage=True;
            string fieldName ='Procedure_Code__c';
            string value = 'Zipcode';
            Id campaignId = newCampaign.id;
            string stringcampaignId = newCampaign.id;
            boolean exclude = true;
            boolean hasFacilityChange =true;
            boolean insercriteriaflag=true;
            
            encounter.DetailPage=True;
            
            test.startTest();
            encounter.SaveDemoCount();
            test.stopTest();
            
            
    }      
    
     public static testmethod void Test_Demo4()
    { 
            
            Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';        
            insert newCampaign;
            String HospitalCodes='704';
            
            Location__c loc = new Location__c();
            loc.Hospital__c='Alabama - Citizens Medical Center';
            insert loc;
            List<Location__c> SelectedHospitalName=[Select Hospital__c FROM Location__c where id=:loc.id];  
            List<Location__c > SelectedHospitalCode= [Select Hospital__c FROM Location__c where id=:loc.id];             
            Encounter__c  encount = new Encounter__c();
                encount.Campaign__c= newCampaign.Id;
                encount.Number_of_ER_Encounters__c='03';
                encount.Number_of_ER_Encounters_to__c='04';
                encount.HospitalIds__c='703;504';
                        insert encount;
            
            
            Account acc = new Account();
            acc.Name='test';
            insert acc;
            
            contact con = new Contact();
            con.AccountId = acc.id;
            con.LastName='test';
            insert con;
            
             Campaign_Demographics__c demographic = new Campaign_Demographics__c();
            demographic.Campaign__c= newCampaign.Id;
            demographic.AgeFrom_UI__c=null;
            demographic.AgeTo_UI__c=null ;
            demographic.Preferred_Contact_Method__c=null;
            demographic.Est_Discretionary_Income_Percent_to__c=null;
            demographic.Est_Discretionary_Income_Percent__c=null ;
            demographic.Assimilation__c=null ;
            demographic.Birthdate__c=null;
            demographic.Dwelling_Type__c=null ;
            demographic.Est_Household_Debt_Level__c=null;
            demographic.Est_Household_Income_3_0__c=null ;
            demographic.Ethnic_Group__c=null ;
            demographic.Ethcinity__c=null ;
            demographic.Gender__c=null ;
            demographic.Generations_2_0__c=null ;
            demographic.Language__c=null ;
            demographic.Net_Worth_3_0__c=null ;
            demographic.Number_of_Adults_in_HH__c='20';
           // demographic.Number_of_Children__c=null ;
            
            demographic.Number_of_Persons_in_HH__c=null;
            demographic.Presence_of_Children__c=false;
            demographic.Presence_of_Donor__c=true;
            demographic.Religion__c=null;
            demographic.Presence_of_Elderly_Parents__c=true;
            demographic.Race__c=null ;
            demographic.to_1__c=null;
            demographic.to_Number_of_Adults_in_HH__c=null ;
            demographic.to_Number_of_Children__c=null ;
            demographic.to_Number_of_Persons_in_HH__c=null ;
            demographic.Suppression_Non_emailable__c=null; 
            demographic.Address_Deliverable__c=null ;
            insert demographic;
            
            Campaign_Member_Criteria__c  cmpmem = marketingDataUtils.createCampaignMemberCriteria(newCampaign.id);
            Campaign_Member_Criteria_Group__c cmpmemgrp = marketingDataUtils.createCampaignmemgrp(newCampaign.id);
            Data_Element_Identifier__c elemnt = new Data_Element_Identifier__c();
            elemnt.Criteria_Group_Name__c='Ailments';
            elemnt.Name='new';
            elemnt.Field_Name__c='Facility_ID__c';
            insert elemnt;
            PageReference pageRef = Page.EncountersPage;
            Test.setCurrentPage(pageRef);
            ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(newCampaign);
            ApexPages.currentPage().getParameters().put('Id',newCampaign.id);  
            ApexPages.currentPage().getParameters().put('encounter',encount.Id);
            ApexPages.currentPage().getParameters().put('demo',demographic.Id);
            
            ApexPages.currentPage().getParameters().put('btn','1');
            
            EncounterPageController encounter = new EncounterPageController(sc);
            encounter.campgn=newCampaign;
            encounter.age_from = 123;
            encounter.age_to = 121;
            
            encounter.DetailPage=True;
            string fieldName ='Procedure_Code__c';
            string value = 'Zipcode';
            Id campaignId = newCampaign.id;
            string stringcampaignId = newCampaign.id;
            boolean exclude = true;
            boolean hasFacilityChange =true;
            boolean insercriteriaflag=true;
            
            encounter.DetailPage=True;
            
            test.startTest();
            encounter.SaveDemoCount();
            test.stopTest();
            
            
    }      
    
     public static testmethod void Test_LifeStyle5()
    { 
              Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';        
            insert newCampaign;
            
            Location__c loc = new Location__c();
            loc.Hospital__c='Alabama - Citizens Medical Center';
            insert loc;
            List<Location__c> SelectedHospitalName=[Select Hospital__c FROM Location__c where id=:loc.id];              
            
            Account acc = new Account();
            acc.Name='test';
            insert acc;
            
            contact con = new Contact();
            con.AccountId = acc.id;
            con.LastName='test';
            insert con;
            
            
            Life_Style__c lifestyle = new Life_Style__c();
            lifestyle.Campaign__c= newCampaign.Id;
            lifestyle.Health_Index_Manage_Illness_Condition_Fr__c='5'; 
            lifestyle.Health_Index_Illness_or_Condition_To__c='1'; 
            insert lifestyle;
            
            
            
            
            Campaign_Member_Criteria__c  cmpmem = marketingDataUtils.createCampaignMemberCriteria(newCampaign.id);
            Campaign_Member_Criteria_Group__c cmpmemgrp = marketingDataUtils.createCampaignmemgrp(newCampaign.id);
            
            Data_Element_Identifier__c elemnt = new Data_Element_Identifier__c();
            elemnt.Criteria_Group_Name__c='Ailments';
            elemnt.Name='new';
            elemnt.Field_Name__c='Facility_ID__c';
            insert elemnt;
            
            Data_Element_Identifier__c elemnt1 = new Data_Element_Identifier__c();
            elemnt1.Criteria_Group_Name__c='Ailments';
            elemnt1.Name='new';
            elemnt1.Field_Name__c='Health_Index_Manage_Illness_Cond_ranges__c';
            insert elemnt1;
            
            Campaign_Member_Search_Critera__c cms = new Campaign_Member_Search_Critera__c ();
          	cms.Name= 'Ailments';
          	insert cms;
          
            PageReference pageRef = Page.EncountersPage;
            Test.setCurrentPage(pageRef);
            ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(newCampaign);
            ApexPages.currentPage().getParameters().put('Id',newCampaign.id);  
            ApexPages.currentPage().getParameters().put('Lifeid',lifestyle.id);
          
            ApexPages.currentPage().getParameters().put('btn','2');
            
            EncounterPageController encounter = new EncounterPageController(sc);
            encounter.campgn=newCampaign;
            
            encounter.DetailPage=True;
            
            Test.startTest();
           		encounter.LifeStyleSave();
           		
           		encounter.lf.Campaign__c= newCampaign.Id;
            	encounter.lf.Health_Index_Manage_Illness_Condition_Fr__c='5'; 
            	encounter.lf.Health_Index_Illness_or_Condition_To__c='1'; 
            	
           		encounter.LifeStyleSave();
           		encounter.lf.Health_Index_Manage_Illness_Condition_Fr__c='2';
           		encounter.lf.Health_Index_Illness_or_Condition_To__c='5';
           		encounter.LifeStyleSave();
            Test.stopTest(); 
    
            
            
    }      
    
     public static testmethod void Test_LifeStyle()
    { 
              Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';        
            insert newCampaign;
            
            Location__c loc = new Location__c();
            loc.Hospital__c='Alabama - Citizens Medical Center';
            insert loc;
            List<Location__c> SelectedHospitalName=[Select Hospital__c FROM Location__c where id=:loc.id];              
            Encounter__c  encount = new Encounter__c();
            encount.Campaign__c= newCampaign.Id;
            encount.Discharge_Date__c=Date.newInstance(2016,01,20);
            encount.Discharge_Date_To__c=Date.newInstance(2016,01,20);
            encount.HospitalIds__c='DDR';
            encount.Number_of_ER_Encounters__c=null;
            encount.Number_of_ER_Encounters_to__c=null;
            encount.Include_Facility_ID__c='334';
            encount.Exclude_Facility_IDs__c='304';
            encount.Include_Physician_NPIs__c='704';
            encount.To_discharge_date_encounter__c=system.today();
            encount.Discharge_Date_encounter__c=Date.newInstance(2015,01,20);
            encount.Exclude_Physician_NPIs__c='704';
            insert encount;
            
            Model__c campaignModel = New Model__c();
            campaignModel.Campaign__c= newCampaign.Id;
            campaignModel.Model_1_from__c='0';
            campaignModel.Model_1_to__c='0';
            campaignModel.Model_2_from__c='0';
            campaignModel.Model_3_from__c='0';
            campaignModel.Model_4_from__c='0';
            campaignModel.Model_2_to__c='0';
            campaignModel.Model_3_to__c='0';
            campaignModel.Model_4_to__c='0';        
            campaignModel.Model_Cardiology_Ranges__c='0';
            campaignModel.Model_Ortho_Hip_Ranges__c='0';
            campaignModel.Model_Ortho_Knee_Ranges__c='0';
            campaignModel.Model_Ortho_Spine_Ranges__c='0';    
            insert campaignModel;
            
            Account acc = new Account();
            acc.Name='test';
            insert acc;
            
            contact con = new Contact();
            con.AccountId = acc.id;
            con.LastName='test';
            insert con;
            
            
            Life_Style__c lifestyle = new Life_Style__c();
            lifestyle.Campaign__c= newCampaign.Id;
            lifestyle.Aches_and_Pain_AGPAIN__c=True; 
            lifestyle.Ailment_Present_Any__c=True;  
            lifestyle.Allergies_and_Sinuses_AGNOSE__c=True;  
            lifestyle.Cancer_AGCANCER__c=True; 
            lifestyle.Cholesterol_and_Blood_Pressure_AGBLOOD__c=True; 
            lifestyle.Diabetes_AGDIAB__c=True;  
            lifestyle.Digestive_AGDIG__c=True; 
            lifestyle.Do_It_Yourself__c=True;
            lifestyle.Female_Conditions_AGFEM__c=True;
            lifestyle.Fine_Arts__c=True;  lifestyle.Foot_AGFOOT__c=True; 
            lifestyle.Health_Index_Manage_Illness_Condition_Fr__c='1'; 
            lifestyle.Health_Index_Illness_or_Condition_To__c='1'; 
            lifestyle.Health_Index_Illness_or_Condition_To__c='1';  
            lifestyle.Health_Index_Manage_Bus_of_Health__c='1'; 
            lifestyle.Health_Index_Manage_Bus_of_Health_To__c='1';  
            lifestyle.Health_Index_Manage_Health_From__c='1'; 
            lifestyle.Health_Index_Manage_Health_To__c='1';  
            lifestyle.Health_Index_Wear_Dev_to_Manage_Health__c='1'; 
            lifestyle.Health_Index_Wear_Dev_to_Manage_Health_T__c='1'; 
            lifestyle.Health_Ins_Direct_Pay_Index_From__c='1';
            lifestyle.Health_Ins_Direct_Pay_Index_To__c='1'; 
            lifestyle.Health_Ins_Engagement_Index_From__c='1'; 
            lifestyle.Health_Ins_Engagement_Index_To__c='1';
            lifestyle.Health_Ins_Influence_Index_From__c='1'; 
            lifestyle.Health_Ins_Influence_Index_To__c='1';  
            lifestyle.Heart_Condition_AGHEART__c=True; 
            lifestyle.Home_Life__c=True;  
            lifestyle.Joint_Spine_AGJOINT__c=True; 
            lifestyle.Luxury_Life__c=True;  
            lifestyle.Male_Conditions_AGMALE__c=True;  
            lifestyle.Mobility_Problems_and_Assistance_AGAST__c=True; 
            lifestyle.Health_Ins_Subsidy_Ind__c='Households that may qualify for Medicaid based on the number of persons present and their estimated household income.';  lifestyle.Healthcare_Treatment_Pref__c='1'; 
            lifestyle.Mouth_and_Teeth_AGMOUTH__c=True; 
            lifestyle.Health_Ins_Prem_Tolerance_Index__c='1'; 
            lifestyle.Health_Ins_Prem_Tolerance_Index_to__c='1'; 
            lifestyle.Medicare_Supplement_Ins_Rspnder_Idx_from__c='1';  
            lifestyle.Medicare_Supplement_Ins_Rspnder_Idx_to__c='1';  
            lifestyle.Outdoor_Enthusiasts__c=True; 
            lifestyle.Physically_Active__c=True; 
            lifestyle.Progressive_Conditions_AGPROG__c=True; 
            lifestyle.Psychological_Behavioral_AGPSYCO__c=True; 
            lifestyle.Uninsured_Index__c='1'; 
            lifestyle.Uninsured_Index_to__c='1';
            lifestyle.Respiratory_AGRESP__c=True; 
            lifestyle.Skin_AGSKIN__c=True;  
            lifestyle.Sports_Enthusiasts__c=True; 
            lifestyle.Techies__c=True; 
            lifestyle.Up_Town__c=True;
            lifestyle.Urinary_Bowel_AGURINAR__c=True; 
            lifestyle.Vision_AGVSN__c=True;  
            lifestyle.Weight_AGWEIGHT__c=True;       
            lifestyle.Health_Index_Manage_Illness_Cond_ranges__c='5-9';
            insert lifestyle;
            
            
            Procedures__c Procedures = new Procedures__c();
            Procedures.Code__c='Test';
            insert Procedures;
            
            Procedure_Information__c procedureInfo = new Procedure_Information__c();
            procedureInfo.Campaign__c=newCampaign.Id;
            procedureInfo.ICD_CPT_Procedures__c=Procedures.Id;
            insert procedureInfo;
            
            DRG_Code_Information__c DrgCodeinfo = new DRG_Code_Information__c();
            DrgCodeinfo.Campaign__c=newcampaign.id;
            insert DrgCodeinfo;
            
            ICD_Diagnosis__c IcdDiagnosis = new ICD_Diagnosis__c();
            IcdDiagnosis.DIAGNOSIS_CODE__c='Test';
            insert IcdDiagnosis;
            
            ICD_Diagnosis_In__c ICD_DiagnosisInfo = new ICD_Diagnosis_In__c ();
            ICD_DiagnosisInfo.Campaign__c=newcampaign.Id;
            ICD_DiagnosisInfo.ICD_Diagnosis__c=IcdDiagnosis.Id;
            insert ICD_DiagnosisInfo;
            
            Encounter_aggregates__c  encounteraggregate = new Encounter_aggregates__c();
            encounteraggregate.Campaign__c=newcampaign.Id;
            encounteraggregate.Number_of_ER_Encounters_To__c=NULL;
            encounteraggregate.Number_of_ER_Encounters__c=NULL;
            encounteraggregate.Last_Discharge_Date_From_UI__c=NULL;
            encounteraggregate.Last_Discharge_Date_Criteria_Element_Id__c='test';
            encounteraggregate.Last_Discharge_Date_Ranges__c='test';
            encounteraggregate.Last_Discharge_Date_To_UI__c=NULL;
            encounteraggregate.No_of_ER_Encounters_ranges__c='test';
            encounteraggregate.Most_Recent_Primary_Payor_Type__c=NULL;
            
            encounteraggregate.Preffered_Hospital__c=NULL;
            encounteraggregate.Wunderman_Preferred_Hospitals__c='test';
            insert encounteraggregate;
            
            Campaign_Member_Criteria__c  cmpmem = marketingDataUtils.createCampaignMemberCriteria(newCampaign.id);
            Campaign_Member_Criteria_Group__c cmpmemgrp = marketingDataUtils.createCampaignmemgrp(newCampaign.id);
            Data_Element_Identifier__c elemnt = new Data_Element_Identifier__c();
            elemnt.Criteria_Group_Name__c='Ailments';
            elemnt.Name='new';
            elemnt.Field_Name__c='Facility_ID__c';
            insert elemnt;
            PageReference pageRef = Page.EncountersPage;
            Test.setCurrentPage(pageRef);
            ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(newCampaign);
            ApexPages.currentPage().getParameters().put('Id',newCampaign.id);  
            ApexPages.currentPage().getParameters().put('Lifeid',lifestyle.id);
          
            ApexPages.currentPage().getParameters().put('btn','1');
            
            EncounterPageController encounter = new EncounterPageController(sc);
            system.debug('EditCriteria&&&&&&'+encounter);
            encounter.campgn=newCampaign;
            
            encounter.DetailPage=True;
            boolean exclude = true;
            boolean hasFacilityChange =false;
            
            Test.startTest();
           
             encounter.LifeStyleSave();
            Test.stopTest(); 
    
            
            
    }      
 
 public static testmethod void Test_LifeStyle3()
    { 
           Integer valueSelected;
           Integer valueSelected1;
           date mydate1;
           integer selectedbutton;
              Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';        
            insert newCampaign;
            
            Location__c loc = new Location__c();
            loc.Hospital__c='Alabama - Citizens Medical Center';
            insert loc;
            List<Location__c> SelectedHospitalName=[Select Hospital__c FROM Location__c where id=:loc.id];              
            Encounter__c  encount = new Encounter__c();
            encount.Campaign__c= newCampaign.Id;
            encount.Discharge_Date__c=Date.newInstance(2015,01,20);
            encount.Discharge_Date_To__c=Date.newInstance(2016,01,20);
            encount.HospitalIds__c='DDR';
            encount.Number_of_ER_Encounters__c='9900';
            encount.Number_of_ER_Encounters_to__c='9900';
            encount.Include_Facility_ID__c='334';
            encount.Exclude_Facility_IDs__c='304';
            encount.Include_Physician_NPIs__c='704';
            encount.To_discharge_date_encounter__c=system.today();
            encount.Discharge_Date_encounter__c=Date.newInstance(2015,01,20);
            encount.Exclude_Physician_NPIs__c='704';
            insert encount;
            
            Model__c campaignModel = New Model__c();
            campaignModel.Campaign__c= newCampaign.Id;
            campaignModel.Model_1_from__c='0';
            campaignModel.Model_1_to__c='0';
            campaignModel.Model_2_from__c='0';
            campaignModel.Model_3_from__c='0';
            campaignModel.Model_4_from__c='0';
            campaignModel.Model_2_to__c='0';
            campaignModel.Model_3_to__c='0';
            campaignModel.Model_4_to__c='0';        
            campaignModel.Model_Cardiology_Ranges__c='0';
            campaignModel.Model_Ortho_Hip_Ranges__c='0';
            campaignModel.Model_Ortho_Knee_Ranges__c='0';
            campaignModel.Model_Ortho_Spine_Ranges__c='0';    
            insert campaignModel;
            
            Account acc = new Account();
            acc.Name='test';
            insert acc;
            
            contact con = new Contact();
            con.AccountId = acc.id;
            con.LastName='test';
            insert con;
            
            
            Life_Style__c lifestyle = new Life_Style__c();
            lifestyle.Campaign__c= newCampaign.Id;
            lifestyle.Aches_and_Pain_AGPAIN__c=false;
            insert lifestyle;
            
            
            Procedures__c Procedures = new Procedures__c();
            Procedures.Code__c='Test';
            insert Procedures;
            
            Procedure_Information__c procedureInfo = new Procedure_Information__c();
            procedureInfo.Campaign__c=newCampaign.Id;
            procedureInfo.ICD_CPT_Procedures__c=Procedures.Id;
            insert procedureInfo;
            
            DRG_Code_Information__c DrgCodeinfo = new DRG_Code_Information__c();
            DrgCodeinfo.Campaign__c=newcampaign.id;
            insert DrgCodeinfo;
            
            ICD_Diagnosis__c IcdDiagnosis = new ICD_Diagnosis__c();
            IcdDiagnosis.DIAGNOSIS_CODE__c='Test';
            insert IcdDiagnosis;
            
            ICD_Diagnosis_In__c ICD_DiagnosisInfo = new ICD_Diagnosis_In__c ();
            ICD_DiagnosisInfo.Campaign__c=newcampaign.Id;
            ICD_DiagnosisInfo.ICD_Diagnosis__c=IcdDiagnosis.Id;
            insert ICD_DiagnosisInfo;
            
            
            Campaign_Member_Criteria__c  cmpmem = marketingDataUtils.createCampaignMemberCriteria(newCampaign.id);
            Campaign_Member_Criteria_Group__c cmpmemgrp = marketingDataUtils.createCampaignmemgrp(newCampaign.id);
            Data_Element_Identifier__c elemnt = new Data_Element_Identifier__c();
            elemnt.Criteria_Group_Name__c='Ailments';
            elemnt.Name='new';
            elemnt.Field_Name__c='Facility_ID__c';
            insert elemnt;
            PageReference pageRef = Page.EncountersPage;
            Test.setCurrentPage(pageRef);
            ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(newCampaign);
            ApexPages.currentPage().getParameters().put('Id',newCampaign.id);  
            ApexPages.currentPage().getParameters().put('Lifeid',lifestyle.id);
          
            ApexPages.currentPage().getParameters().put('btn','1');
            
            EncounterPageController encounter = new EncounterPageController(sc);
            system.debug('EditCriteria&&&&&&'+encounter);
            encounter.campgn=newCampaign;
            encounter.valueSelected=10;
            encounter.valueSelected1=10;
            encounter.mydate1=Date.newInstance(2017, 12, 9);
            encounter.selectedbutton=24;
            encounter.DetailPage=True;
            boolean exclude = false;
            boolean hasFacilityChange =true;
            
            Test.startTest();
           
             encounter.LifeStyleSave();
            Test.stopTest(); 
    
            
            
    }      
    public static testmethod void locationtestmethodtest()
    { 
            Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';        
            insert newCampaign;
            
            
            Model__c campaignModel = New Model__c();
            campaignModel.Campaign__c= newCampaign.Id;
            campaignModel.Model_1_from__c='2';
            campaignModel.Model_1_to__c='0';
            campaignModel.Model_2_from__c='0';
            campaignModel.Model_3_from__c='0';
            campaignModel.Model_4_from__c='0';
            campaignModel.Model_2_to__c='0';
            campaignModel.Model_3_to__c='0';
            campaignModel.Model_4_to__c='0';     
            campaignModel.Model_Cardiology_Ranges__c='0';
            campaignModel.Model_Ortho_Hip_Ranges__c='0';
            campaignModel.Model_Ortho_Knee_Ranges__c='0';
            campaignModel.Model_Ortho_Spine_Ranges__c='0';    
            insert campaignModel;
            
           
            PageReference pageRef = Page.EncountersPage;
            Test.setCurrentPage(pageRef);
            ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(newCampaign);
            ApexPages.currentPage().getParameters().put('Id',newCampaign.id);          
            ApexPages.currentPage().getParameters().put('Modelid',campaignModel.id);            
            EncounterPageController encounter = new EncounterPageController(sc);
            encounter.campgn=newCampaign;
            encounter.model=campaignModel;       
            encounter.SaveModel();   
    }
   public static testmethod void locationtestmethodtest1()
    { 
            Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';        
            insert newCampaign;
        
            Model__c campaignModel = New Model__c();
            campaignModel.Campaign__c= newCampaign.Id;  
            campaignModel.Model_Cardiology_Ranges__c='0';
            campaignModel.Model_Ortho_Hip_Ranges__c='0';
            campaignModel.Model_Ortho_Knee_Ranges__c='0';
            campaignModel.Model_Ortho_Spine_Ranges__c='0';    
            insert campaignModel;
        
            PageReference pageRef = Page.EncountersPage;
            Test.setCurrentPage(pageRef);
            ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(newCampaign);
            ApexPages.currentPage().getParameters().put('Id',newCampaign.id);                        
            EncounterPageController encounter = new EncounterPageController(sc);
            encounter.campgn=newCampaign;
            encounter.model=campaignModel;       
            encounter.SaveModel();
            encounter.cancelmodelcriteria();
            encounter.AddIcd();
            encounter.addDRG();
            encounter.excludeDRG();
            encounter.ExcludeIcd();
            encounter.IncludeProcedure();
            encounter.ExcludeProcedure();
            encounter.deleteAllDRGInclusions();
            encounter.deleteAllDRGExclusions();
    }
   public static testmethod void locationtestmethodtest2()
    { 
            Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';        
            insert newCampaign;
            
            
            Model__c campaignModel = New Model__c();
            campaignModel.Campaign__c= newCampaign.Id;
            campaignModel.Model_1_from__c='0';
            campaignModel.Model_1_to__c='0';
            campaignModel.Model_2_from__c='2';  

            insert campaignModel;
                       
            PageReference pageRef = Page.EncountersPage;
            Test.setCurrentPage(pageRef);
            ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(newCampaign);
            ApexPages.currentPage().getParameters().put('Id',newCampaign.id);          
            ApexPages.currentPage().getParameters().put('Modelid',campaignModel.id);
            EncounterPageController encounter = new EncounterPageController(sc);
            encounter.campgn=newCampaign;
            encounter.model=campaignModel;       
            encounter.SaveModel();   
    }    
     public static testmethod void locationtestmethodtest3()
    { 
            Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';        
            insert newCampaign;
        
            Model__c campaignModel = New Model__c();
            campaignModel.Campaign__c= newCampaign.Id;
            campaignModel.Model_1_from__c='0';    
            insert campaignModel;
       
            PageReference pageRef = Page.EncountersPage;
            Test.setCurrentPage(pageRef);
            ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(newCampaign);
            ApexPages.currentPage().getParameters().put('Id',newCampaign.id);          
            ApexPages.currentPage().getParameters().put('Modelid',campaignModel.id);            
            EncounterPageController encounter = new EncounterPageController(sc);
            encounter.campgn=newCampaign;
            encounter.model=campaignModel;       
            encounter.SaveModel();   
    }
     public static testmethod void locationtestmethodtest4()
    { 
            Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';        
            insert newCampaign;    
        
            Model__c campaignModel = New Model__c();
            campaignModel.Campaign__c= newCampaign.Id;
            campaignModel.Model_1_from__c='0';
            campaignModel.Model_1_to__c='0';
            campaignModel.Model_2_from__c='2';
            campaignModel.Model_2_to__c='0';   
            
            insert campaignModel;
            Life_Style__c lifestyle = new Life_Style__c();
            lifestyle.Campaign__c= newCampaign.Id;
            
           lifestyle.Health_Index_Manage_Bus_of_Health__c='1'; 
           lifestyle.Health_Index_Manage_Bus_of_Health_To__c='1';
           lifestyle.Health_Index_Manage_Illness_Condition_Fr__c='2';
           lifestyle.Health_Index_Illness_or_Condition_To__c='1';
           lifestyle.Health_Index_Manage_Health_From__c='1';  
           lifestyle.Health_Index_Manage_Health_To__c='1';  
            insert lifestyle;
           
            PageReference pageRef = Page.EncountersPage;
            Test.setCurrentPage(pageRef);
            ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(newCampaign);
            ApexPages.currentPage().getParameters().put('Id',newCampaign.id);          
            ApexPages.currentPage().getParameters().put('Modelid',campaignModel.id);            
            EncounterPageController encounter = new EncounterPageController(sc);
            encounter.campgn=newCampaign;
            encounter.model=campaignModel;       
            encounter.SaveModel();   
    }
        public static testmethod void locationtestmethodtest5()
    { 
            Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';        
            insert newCampaign;
        
          Model__c campaignModel = New Model__c();
            campaignModel.Campaign__c= newCampaign.Id;
            campaignModel.Model_1_from__c='0';
            campaignModel.Model_1_to__c='0';
            campaignModel.Model_2_from__c='0';
            campaignModel.Model_3_from__c='0';
            campaignModel.Model_4_from__c='0';
            campaignModel.Model_5_from__c='0';
            campaignModel.Model_5_to__c='0';
            campaignModel.Model_6_from__c='0';
            campaignModel.Model_6_to__c='0';
            campaignModel.Model_7_from__c='0'; 
            campaignModel.Model_7_to__c='0';
            campaignModel.Model_8_from__c='0';
            campaignModel.Model_8_from__c='0';
         
            insert campaignModel;
     
            PageReference pageRef = Page.EncountersPage;
            Test.setCurrentPage(pageRef);
            ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(newCampaign);
            ApexPages.currentPage().getParameters().put('Id',newCampaign.id);          
            ApexPages.currentPage().getParameters().put('Modelid',campaignModel.id);            
            EncounterPageController encounter = new EncounterPageController(sc);
            encounter.campgn=newCampaign;
            encounter.model=campaignModel;       
            encounter.SaveModel();   
    }
     public static testmethod void locationtestmethodtest6()
    { 
            Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';        
            insert newCampaign;
        
          Model__c campaignModel = New Model__c();
            campaignModel.Campaign__c= newCampaign.Id;
            campaignModel.Model_1_from__c='0';
            campaignModel.Model_1_to__c='0';
            campaignModel.Model_2_from__c='0';
            campaignModel.Model_3_from__c='2';
            campaignModel.Model_4_from__c='0';
            campaignModel.Model_2_to__c='0';
            campaignModel.Model_3_to__c='0';
            campaignModel.Model_4_to__c='0';     
            campaignModel.Model_Cardiology_Ranges__c='0';
            campaignModel.Model_Ortho_Hip_Ranges__c='0';
            campaignModel.Model_Ortho_Knee_Ranges__c='0';
            campaignModel.Model_Ortho_Spine_Ranges__c='0';    
            insert campaignModel;
    
            PageReference pageRef = Page.EncountersPage;
            Test.setCurrentPage(pageRef);
            ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(newCampaign);
            ApexPages.currentPage().getParameters().put('Id',newCampaign.id);          
            ApexPages.currentPage().getParameters().put('Modelid',campaignModel.id);            
            EncounterPageController encounter = new EncounterPageController(sc);
            encounter.campgn=newCampaign;
            encounter.model=campaignModel;       
            encounter.SaveModel(); 
            encounter.canceldemographicscriteria();
            encounter.cancelencounteraggregatescriteria();
            encounter.cancellifestylecriteria(); 
            encounter.cancelencountercriteria();
        
    }
     public static testmethod void ModelNewValues()
    { 
            Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';        
            insert newCampaign;    
        
            Model__c campaignModel = New Model__c();
            campaignModel.Campaign__c= newCampaign.Id;
            campaignModel.Model_5_from__c='0';
            campaignModel.Model_5_to__c='0';
            campaignModel.Model_6_from__c='2';
            campaignModel.Model_6_to__c='4';
            campaignModel.Model_7_from__c='2';
            campaignModel.Model_7_to__c='4';
            campaignModel.Model_8_from__c='0';
            campaignModel.Model_8_to__c='5';
            campaignModel.Model_for_Breast_Ranges__c='0';
            campaignModel.Model_Colon_Ranges__c='2-4';
            campaignModel.Model_OB_Medicade_Ranges__c='2-4';
            campaignModel.Model_OB_Commercial_Ranges__c='0-5';
              
            insert campaignModel;

            PageReference pageRef = Page.EncountersPage;
            Test.setCurrentPage(pageRef);
            ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(newCampaign);
            ApexPages.currentPage().getParameters().put('Id',newCampaign.id);          
            ApexPages.currentPage().getParameters().put('Modelid',campaignModel.id);            
            EncounterPageController encounter = new EncounterPageController(sc);
            encounter.campgn=newCampaign;
            encounter.model=campaignModel;       
            encounter.SaveModel();   
    }
    
    public static testmethod void ModelNewValues_invalidcase()
    { 
            Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';        
            insert newCampaign;    
        
            Model__c campaignModel = New Model__c();
            campaignModel.Campaign__c= newCampaign.Id;
            campaignModel.Model_5_from__c='0';
            campaignModel.Model_5_to__c=null;
            campaignModel.Model_6_from__c='5';
            campaignModel.Model_6_to__c='4';
            
            
            campaignModel.Model_OB_Medicade_Ranges__c='2-4';
            campaignModel.Model_OB_Commercial_Ranges__c='0-5';
              
            insert campaignModel;

            PageReference pageRef = Page.EncountersPage;
            Test.setCurrentPage(pageRef);
            ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(newCampaign);
            ApexPages.currentPage().getParameters().put('Id',newCampaign.id);          
            ApexPages.currentPage().getParameters().put('Modelid',campaignModel.id);            
            EncounterPageController encounter = new EncounterPageController(sc);
            encounter.campgn=newCampaign;
            encounter.model=campaignModel;       
            encounter.SaveModel();   
    }
    // created by Lov
      public static testmethod void TestMethod1() { 
          Campaign newCampaign = new Campaign();
          newCampaign.Name='NewTestCampaign';
          newCampaign.Service_Line__c='Burn';
          newCampaign.Audience_Region__c='Texas';
          newCampaign.Channel__c='Direct Mail';        
          insert newCampaign;   
          System.assertEquals(newCampaign.Name, 'NewTestCampaign'); 
          
          Model__c campaignModel = New Model__c();
          campaignModel.Campaign__c= newCampaign.Id;
          campaignModel.Model_5_from__c='0';
          campaignModel.Model_5_to__c='2';
          campaignModel.Model_6_from__c='3';
          campaignModel.Model_6_to__c='4';        
          Campaign_Member_Criteria__c  cmpmem = marketingDataUtils.createCampaignMemberCriteria(newCampaign.id);
          Campaign_Member_Criteria_Group__c cmpmemgrp = marketingDataUtils.createCampaignmemgrp(newCampaign.id);
          Data_Element_Identifier__c elemnt = new Data_Element_Identifier__c();
          elemnt.Criteria_Group_Name__c='Models';
          elemnt.Name='new';
          elemnt.Field_Name__c ='Model_for_Breast_Ranges__c';
          insert elemnt;
          Data_Element_Identifier__c elemnt2 = new Data_Element_Identifier__c();
          elemnt2.Criteria_Group_Name__c='Models';
          elemnt2.Name='new';
          elemnt2.Field_Name__c ='Model_Colon_Ranges__c';
          insert elemnt2;
          Campaign_Member_Search_Critera__c cms = new Campaign_Member_Search_Critera__c ();
          cms.Name= 'Models';
          insert cms;
          
          PageReference pageRef = Page.EncountersPage;
          Test.setCurrentPage(pageRef);
          ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(newCampaign);
          ApexPages.currentPage().getParameters().put('Id',newCampaign.id);          
          ApexPages.currentPage().getParameters().put('Modelid',null); 
          test.startTest();        
          EncounterPageController encounter = new EncounterPageController(sc);
          encounter.campgn=newCampaign;
          List<selectoption> lstoption = encounter.ownershiptype;    
          encounter.model = campaignModel;
          encounter.SaveModel();   
          test.stopTest();
    }
     public static testmethod void saveDemocountmethod1234()
    {
        
        Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';        
        insert newCampaign;      
       
Campaign_Member_Criteria_Group__c  grp = new Campaign_Member_Criteria_Group__c();
        grp.Campaign__c=newCampaign.id;
        grp.Exclude__c = false;
        grp.Group_Name__c='Demographics';
        grp.WM_CriteriaGroup_Id__c='12';
        grp.WM_Parent_group_Id__c='677';
        grp.Inner_Operator__c = 'OR';
         insert grp;
    Campaign_Member_Criteria__c mem= new Campaign_Member_Criteria__c();
        mem.Campaign__c=newCampaign.id;
        mem.Exclude__c=true;
        mem.Category__c = 'Demographics';
        mem.Criteria_Group__c = grp.id;
        mem.Field_Name__c='New_Movers_Range__c';
           insert mem;        
     
        Data_Element_Identifier__c elementidentifier = new Data_Element_Identifier__c();
        elementidentifier.Data_Element_Identifier__c = 'ZIPCD';
        elementidentifier.Data_Element_Name__c='ZIP Code';
        elementidentifier.Display_Type_Code__c='GEO.MANUAL';
        elementidentifier.Criteria_Group_Name__c='Demographics';
        elementidentifier.Value_Mapping__c='{"Out Patient":"O","In Patient":"I"}';
        elementidentifier.Field_Name__c ='New_Movers_Range__c';
            insert elementidentifier;
        Campaign_Demographics__c demographic = new Campaign_Demographics__c();
            demographic.Campaign__c= newCampaign.Id;  
            demographic.Number_of_Adults_in_HH__c='100';
            demographic.to_Number_of_Adults_in_HH__c='101';
            demographic.Number_of_Persons_in_HH__c='100';
            demographic.to_Number_of_Persons_in_HH__c='101';
        insert demographic;   

        PageReference pageRef = Page.EncountersPage;
        Test.setCurrentPage(pageRef);
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(newCampaign);
        ApexPages.currentPage().getParameters().put('Id',newCampaign.id);          
        //ApexPages.currentPage().getParameters().put('encounter',encount.Id);
        ApexPages.currentPage().getParameters().put('Demo',demographic.Id);
        
        
        
        EncounterPageController encounter = new EncounterPageController(sc);
        //encounter.Demo=demographic;
        //encounter.age_from = 218;
       // encounter.age_to = 219;
        
        encounter.SaveDemoCount();
    
    }   
  public static testmethod void saveDemocountmethod12345()
    {
        
        Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';        
        insert newCampaign;      
       
Campaign_Member_Criteria_Group__c  grp = new Campaign_Member_Criteria_Group__c();
        grp.Campaign__c=newCampaign.id;
        grp.Exclude__c = false;
        grp.Group_Name__c='Demographics';
        grp.WM_CriteriaGroup_Id__c='12';
        grp.WM_Parent_group_Id__c='677';
        grp.Inner_Operator__c = 'OR';
         insert grp;
    Campaign_Member_Criteria__c mem= new Campaign_Member_Criteria__c();
        mem.Campaign__c=newCampaign.id;
        mem.Exclude__c=true;
        mem.Category__c = 'Demographics';
        mem.Criteria_Group__c = grp.id;
        mem.Field_Name__c='New_Movers_Range__c';
           insert mem;        
     
        Data_Element_Identifier__c elementidentifier = new Data_Element_Identifier__c();
        elementidentifier.Data_Element_Identifier__c = 'ZIPCD';
        elementidentifier.Data_Element_Name__c='ZIP Code';
        elementidentifier.Display_Type_Code__c='GEO.MANUAL';
        elementidentifier.Criteria_Group_Name__c='Demographics';
        elementidentifier.Value_Mapping__c='{"Out Patient":"O","In Patient":"I"}';
        elementidentifier.Field_Name__c ='New_Movers_Range__c';
            insert elementidentifier;
        Campaign_Demographics__c demographic = new Campaign_Demographics__c();
            demographic.Campaign__c= newCampaign.Id;  
            demographic.Number_of_Adults_in_HH__c='100';
            demographic.to_Number_of_Adults_in_HH__c='99';
            demographic.Number_of_Persons_in_HH__c='100';
            demographic.to_Number_of_Persons_in_HH__c='101';
        insert demographic;   

        PageReference pageRef = Page.EncountersPage;
        Test.setCurrentPage(pageRef);
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(newCampaign);
        ApexPages.currentPage().getParameters().put('Id',newCampaign.id);          
        ApexPages.currentPage().getParameters().put('Demo',demographic.Id);
       
        EncounterPageController encounter = new EncounterPageController(sc);
 
        encounter.SaveDemoCount();
    
    }   
    public static testmethod void saveDemocountmethod123456()
    {
        
        Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';        
        insert newCampaign;      
       
Campaign_Member_Criteria_Group__c  grp = new Campaign_Member_Criteria_Group__c();
        grp.Campaign__c=newCampaign.id;
        grp.Exclude__c = false;
        grp.Group_Name__c='Demographics';
        grp.WM_CriteriaGroup_Id__c='12';
        grp.WM_Parent_group_Id__c='677';
        grp.Inner_Operator__c = 'OR';
         insert grp;
    Campaign_Member_Criteria__c mem= new Campaign_Member_Criteria__c();
        mem.Campaign__c=newCampaign.id;
        mem.Exclude__c=true;
        mem.Category__c = 'Demographics';
        mem.Criteria_Group__c = grp.id;
        mem.Field_Name__c='New_Movers_Range__c';
           insert mem;        
     
        Data_Element_Identifier__c elementidentifier = new Data_Element_Identifier__c();
        elementidentifier.Data_Element_Identifier__c = 'ZIPCD';
        elementidentifier.Data_Element_Name__c='ZIP Code';
        elementidentifier.Display_Type_Code__c='GEO.MANUAL';
        elementidentifier.Criteria_Group_Name__c='Demographics';
        elementidentifier.Value_Mapping__c='{"Out Patient":"O","In Patient":"I"}';
        elementidentifier.Field_Name__c ='New_Movers_Range__c';
            insert elementidentifier;
        Campaign_Demographics__c demographic = new Campaign_Demographics__c();
            demographic.Campaign__c= newCampaign.Id;  
            demographic.Number_of_Persons_in_HH__c='101';
            demographic.to_Number_of_Persons_in_HH__c='100';
        insert demographic;   

        PageReference pageRef = Page.EncountersPage;
        Test.setCurrentPage(pageRef);
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(newCampaign);
        ApexPages.currentPage().getParameters().put('Id',newCampaign.id);          
        ApexPages.currentPage().getParameters().put('Demo',demographic.Id);
       
        EncounterPageController encounter = new EncounterPageController(sc);
 
        encounter.SaveDemoCount();
    
    }  
     public static testmethod void saveDemocountmethod23456()
    {
        
        Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';        
        insert newCampaign;      
       
Campaign_Member_Criteria_Group__c  grp = new Campaign_Member_Criteria_Group__c();
        grp.Campaign__c=newCampaign.id;
        grp.Exclude__c = false;
        grp.Group_Name__c='Demographics';
        grp.WM_CriteriaGroup_Id__c='12';
        grp.WM_Parent_group_Id__c='677';
        grp.Inner_Operator__c = 'OR';
         insert grp;
    Campaign_Member_Criteria__c mem= new Campaign_Member_Criteria__c();
        mem.Campaign__c=newCampaign.id;
        mem.Exclude__c=true;
        mem.Category__c = 'Demographics';
        mem.Criteria_Group__c = grp.id;
        mem.Field_Name__c='New_Movers_Range__c';
           insert mem;        
     
        Data_Element_Identifier__c elementidentifier = new Data_Element_Identifier__c();
        elementidentifier.Data_Element_Identifier__c = 'ZIPCD';
        elementidentifier.Data_Element_Name__c='ZIP Code';
        elementidentifier.Display_Type_Code__c='GEO.MANUAL';
        elementidentifier.Criteria_Group_Name__c='Demographics';
        elementidentifier.Value_Mapping__c='{"Out Patient":"O","In Patient":"I"}';
        elementidentifier.Field_Name__c ='New_Movers_Range__c';
            insert elementidentifier;
        Campaign_Demographics__c demographic = new Campaign_Demographics__c();
            demographic.Campaign__c= newCampaign.Id;  
            demographic.Number_of_Children__c='100';
            demographic.to_Number_of_Children__c='99';
        insert demographic;   

        PageReference pageRef = Page.EncountersPage;
        Test.setCurrentPage(pageRef);
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(newCampaign);
        ApexPages.currentPage().getParameters().put('Id',newCampaign.id);          
        ApexPages.currentPage().getParameters().put('Demo',demographic.Id);
       
        EncounterPageController encounter = new EncounterPageController(sc);
 
        encounter.SaveDemoCount();
    
    }  
        public static testmethod void saveDemocountmethod3456()
    {
        
        Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';        
        insert newCampaign;      
       
Campaign_Member_Criteria_Group__c  grp = new Campaign_Member_Criteria_Group__c();
        grp.Campaign__c=newCampaign.id;
        grp.Exclude__c = false;
        grp.Group_Name__c='Demographics';
        grp.WM_CriteriaGroup_Id__c='12';
        grp.WM_Parent_group_Id__c='677';
        grp.Inner_Operator__c = 'OR';
         insert grp;
    Campaign_Member_Criteria__c mem= new Campaign_Member_Criteria__c();
        mem.Campaign__c=newCampaign.id;
        mem.Exclude__c=true;
        mem.Category__c = 'Demographics';
        mem.Criteria_Group__c = grp.id;
        mem.Field_Name__c='New_Movers_Range__c';
           insert mem;        
     
        Data_Element_Identifier__c elementidentifier = new Data_Element_Identifier__c();
        elementidentifier.Data_Element_Identifier__c = 'ZIPCD';
        elementidentifier.Data_Element_Name__c='ZIP Code';
        elementidentifier.Display_Type_Code__c='GEO.MANUAL';
        elementidentifier.Criteria_Group_Name__c='Demographics';
        elementidentifier.Value_Mapping__c='{"Out Patient":"O","In Patient":"I"}';
        elementidentifier.Field_Name__c ='New_Movers_Range__c';
            insert elementidentifier;
        Campaign_Demographics__c demographic = new Campaign_Demographics__c();
            demographic.Campaign__c= newCampaign.Id;  
            demographic.AgeFrom_UI__c=170;
            demographic.AgeTo_UI__c=180;
        insert demographic;   

        PageReference pageRef = Page.EncountersPage;
        Test.setCurrentPage(pageRef);
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(newCampaign);
        ApexPages.currentPage().getParameters().put('Id',newCampaign.id);          
        ApexPages.currentPage().getParameters().put('Demo',demographic.Id);
       
        EncounterPageController encounter = new EncounterPageController(sc);
 
        encounter.SaveDemoCount();
    
    }
        public static testmethod void saveDemocountmethod456()
    {
        
        Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';        
        insert newCampaign;      
       
Campaign_Member_Criteria_Group__c  grp = new Campaign_Member_Criteria_Group__c();
        grp.Campaign__c=newCampaign.id;
        grp.Exclude__c = false;
        grp.Group_Name__c='Demographics';
        grp.WM_CriteriaGroup_Id__c='12';
        grp.WM_Parent_group_Id__c='677';
        grp.Inner_Operator__c = 'OR';
         insert grp;
    Campaign_Member_Criteria__c mem= new Campaign_Member_Criteria__c();
        mem.Campaign__c=newCampaign.id;
        mem.Exclude__c=true;
        mem.Category__c = 'Demographics';
        mem.Criteria_Group__c = grp.id;
        mem.Field_Name__c='New_Movers_Range__c';
           insert mem;        
     
        Data_Element_Identifier__c elementidentifier = new Data_Element_Identifier__c();
        elementidentifier.Data_Element_Identifier__c = 'ZIPCD';
        elementidentifier.Data_Element_Name__c='ZIP Code';
        elementidentifier.Display_Type_Code__c='GEO.MANUAL';
        elementidentifier.Criteria_Group_Name__c='Demographics';
        elementidentifier.Value_Mapping__c='{"Out Patient":"O","In Patient":"I"}';
        elementidentifier.Field_Name__c ='New_Movers_Range__c';
            insert elementidentifier;
        Campaign_Demographics__c demographic = new Campaign_Demographics__c();
            demographic.Campaign__c= newCampaign.Id;  
            demographic.Number_of_Persons_in_HH__c='170';
            demographic.to_Number_of_Persons_in_HH__c='180';
        insert demographic;   

        PageReference pageRef = Page.EncountersPage;
        Test.setCurrentPage(pageRef);
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(newCampaign);
        ApexPages.currentPage().getParameters().put('Id',newCampaign.id);          
        ApexPages.currentPage().getParameters().put('Demo',demographic.Id);
       
        EncounterPageController encounter = new EncounterPageController(sc);
 
        encounter.SaveDemoCount();
    
    }
      public static testmethod void saveDemocountmethod56()
    {
        
        Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';        
        insert newCampaign;      
       
Campaign_Member_Criteria_Group__c  grp = new Campaign_Member_Criteria_Group__c();
        grp.Campaign__c=newCampaign.id;
        grp.Exclude__c = false;
        grp.Group_Name__c='Demographics';
        grp.WM_CriteriaGroup_Id__c='12';
        grp.WM_Parent_group_Id__c='677';
        grp.Inner_Operator__c = 'OR';
         insert grp;
    Campaign_Member_Criteria__c mem= new Campaign_Member_Criteria__c();
        mem.Campaign__c=newCampaign.id;
        mem.Exclude__c=true;
        mem.Category__c = 'Demographics';
        mem.Criteria_Group__c = grp.id;
        mem.Field_Name__c='New_Movers_Range__c';
           insert mem;        
     
        Data_Element_Identifier__c elementidentifier = new Data_Element_Identifier__c();
        elementidentifier.Data_Element_Identifier__c = 'ZIPCD';
        elementidentifier.Data_Element_Name__c='ZIP Code';
        elementidentifier.Display_Type_Code__c='GEO.MANUAL';
        elementidentifier.Criteria_Group_Name__c='Demographics';
        elementidentifier.Value_Mapping__c='{"Out Patient":"O","In Patient":"I"}';
        elementidentifier.Field_Name__c ='New_Movers_Range__c';
            insert elementidentifier;
        Campaign_Demographics__c demographic = new Campaign_Demographics__c();
            demographic.Campaign__c= newCampaign.Id;  
            demographic.to_Number_of_Children__c='170';
            demographic.Number_of_Children__c='130';
        insert demographic;   

        PageReference pageRef = Page.EncountersPage;
        Test.setCurrentPage(pageRef);
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(newCampaign);
        ApexPages.currentPage().getParameters().put('Id',newCampaign.id);          
        ApexPages.currentPage().getParameters().put('Demo',demographic.Id);
       
        EncounterPageController encounter = new EncounterPageController(sc);
 
        encounter.SaveDemoCount();
    
    }
     public static testmethod void ModelNewValues12345()
    { 
            Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';        
            insert newCampaign;    
        
            Model__c campaignModel = New Model__c();
            campaignModel.Campaign__c= newCampaign.Id;
            campaignModel.Model_9_from__c='1';
            campaignModel.Model_9_to__c='0';
            campaignModel.Model_OB_Medicade_Ranges__c='2-4';
            campaignModel.Model_OB_Commercial_Ranges__c='0-5';
              
            insert campaignModel;

            PageReference pageRef = Page.EncountersPage;
            Test.setCurrentPage(pageRef);
            ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(newCampaign);
            ApexPages.currentPage().getParameters().put('Id',newCampaign.id);          
            ApexPages.currentPage().getParameters().put('Modelid',campaignModel.id);            
            EncounterPageController encounter = new EncounterPageController(sc);
            encounter.campgn=newCampaign;
            encounter.model=campaignModel;       
            encounter.SaveModel();   
    }
    
    
    public static testmethod void Test_SaveEncounterCriteria02()
    {             
            Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';        
            insert newCampaign;          
            PageReference pageRef = Page.EncountersPage;
            Test.setCurrentPage(pageRef);
            ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(newCampaign);
            ApexPages.currentPage().getParameters().put('Id',newCampaign.id);  
            ApexPages.currentPage().getParameters().put('btn','1');
            EncounterPageController encounter = new EncounterPageController(sc);
            encounter.DetailPage=True;
            test.startTest();
            encounter.SaveEncounterCriteria();
            test.stopTest();
           
    }
    
    
    public static testmethod void Test_SaveEncounterCriteria03()
    { 
            
            Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';        
            insert newCampaign;
            String HospitalCodes='704';
            
        
            Encounter__c  encount = new Encounter__c();
            encount.Campaign__c= newCampaign.Id;
            encount.Include_Facility_ID__c='87328';
            encount.Number_of_ER_Encounters__c='02';
            encount.Number_of_ER_Encounters_to__c='08';
            encount.Exclude_Facility_IDs__c='8733';
            encount.Discharge_Date_encounter__c=Date.newInstance(2017,01,20);
   
            insert encount;
   
		   list<Data_Element_Identifier__c> newDEI = new list<Data_Element_Identifier__c>(); 
		   Data_Element_Identifier__c DEI=new Data_Element_Identifier__c();
		   DEI.Criteria_Group_Name__c='Encounters';
		   DEI.Data_Element_Description__c='Number of ER Encounters';
		   DEI.Data_Element_Identifier__c='13313';
		   DEI.Data_Element_Name__c='Number of ER Encounters';
		   DEI.Display_Type_Code__c='NUMERIC.RANGE.TEXT';
		   DEI.List_Product_Identifier__c='961';
		   DEI.Field_Name__c='No_of_ER_Encounters_ranges__c';
		   newDEI.add(DEI);
   		   
   		   Data_Element_Identifier__c elemnt1 = new Data_Element_Identifier__c();
           elemnt1.Criteria_Group_Name__c='Encounters';
	       elemnt1.Name='new';
	       elemnt1.Field_Name__c='CRM_ServiceLine__c';
	       newDEI.add(elemnt1);
            
           Data_Element_Identifier__c elemnt2 = new Data_Element_Identifier__c();
           elemnt2.Criteria_Group_Name__c='Encounters';
	       elemnt2.Name='new';
	       elemnt2.Field_Name__c='Primary_NPIs__c';
	       newDEI.add(elemnt2);
	       
	       Data_Element_Identifier__c elemnt3 = new Data_Element_Identifier__c();
           elemnt3.Criteria_Group_Name__c='Encounters';
	       elemnt3.Name='new';
	       elemnt3.Field_Name__c='Admitting_NPIs__c';
	       newDEI.add(elemnt3);
	       
	       Data_Element_Identifier__c elemnt4 = new Data_Element_Identifier__c();
           elemnt4.Criteria_Group_Name__c='Encounters';
	       elemnt4.Name='new';
	       elemnt4.Field_Name__c='Attending_NPIs__c';
	       newDEI.add(elemnt4);
	       
	       insert newDEI;
	        
		   CRM_AudienceCriteriaRefData__c CSSL=new CRM_AudienceCriteriaRefData__c();
		   CSSL.CRM_IsActive__c=true;
		   CSSL.CRM_ClinicalServiceLineSyncData__c='INFECTIOUS DISEASE';
		   CSSL.CRM_ClinicalServiceLine__c='Infectious Disease';
		    CSSL.CRM_ClinicalServiceLine__c='Infectious Disease';
		  insert  CSSL;
   
   			Campaign_Member_Search_Critera__c cms = new Campaign_Member_Search_Critera__c ();
          	cms.Name= 'Encounters';
          	insert cms;
            
            PageReference pageRef = Page.EncountersPage;
            Test.setCurrentPage(pageRef);
            ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(newCampaign);
            ApexPages.currentPage().getParameters().put('Id',newCampaign.id); 
            ApexPages.currentPage().getParameters().put('encounter',encount.Id);
            ApexPages.currentPage().getParameters().put('btn','1');
            list<String > SelectedServiceLineVals= new  list<String>();
            SelectedServiceLineVals.add(CSSL.id);
            
            EncounterPageController encounter = new EncounterPageController(sc);
            encounter.campgn=newCampaign;
            encounter.selectedValSL=SelectedServiceLineVals;
            
            
            encounter.DetailPage=True;
   
            test.startTest();
            	encounter.enc.Include_Facility_ID__c='43543,45345';
            	encounter.enc.Exclude_Facility_IDs__c='43543,45345';
            	encounter.enc.Include_Physician_NPIs__c='43543,45345';
            	encounter.enc.Exclude_Physician_NPIs__c='43543,45345';
            	encounter.SaveEncounterCriteria();
            test.stopTest();
    } 
      
 }
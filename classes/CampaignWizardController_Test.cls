@istest
public class CampaignWizardController_Test{
 public static testmethod void CampaignWizardmethod(){
   boolean detailpage;
 SObject headSObject ,headClone;
   
 Campaign newCampaign = new Campaign();
            newCampaign.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
            newCampaign.Service_Line__c='Burn';
            newCampaign.CRM_SubServiceLineText__c='Dermatology';
            newCampaign.Tactic__c='Mail';
            newCampaign.Vendor_Name__c='BG Solutions BS';
            newCampaign.CRM_SelectedOwnershipCriteria__c='FRH;DHF';
            newCampaign.CRM_OwnershipType__c='Hospital';
            newCampaign.Status ='In Development';
            newCampaign.Call_to_Action__c='HRA';
            newCampaign.Member_Types__c='One or more encounters - Patients';
            //newCampaign.Audience_Hospital__c ='Phoenix-Abrazo Arrowhead Campus;ABRAZO ARIZONA HEART HOSPITAL';
            newCampaign.Channel__c='Direct Mail';
            newcampaign.status='In development';
            newcampaign.program_name__c='xyz';
              insert newCampaign;
Campaign cmp = new Campaign();
            cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V2';
            cmp.Service_Line__c='Burn';
            cmp.CRM_SubServiceLineText__c='Dermatology';
            cmp.Tactic__c='Mail';
            cmp.Audience_Hospital__c ='Phoenix-Abrazo Arrowhead Campus';
            cmp.Audience_Region__c='Texas';      
            cmp.Channel__c='Direct Mail';
            cmp.ParentId=newCampaign.id;
              insert cmp;
       
CRM_CampaignWizardReferenceData__c wizrefdata = new CRM_CampaignWizardReferenceData__c();
     wizrefdata.CRM_ServiceLine__c='Burn';
     wizrefdata.CRM_CallToAction__c='HRA';
     wizrefdata.CRM_Channel__c='Direct Mail';
     wizrefdata.CRM_SubServiceLine__c='Dermatology';
     wizrefdata.CRM_VendorName__c='BG Solutions BS';
     wizrefdata.CRM_IsActive__c=True;
    insert wizrefdata;
Id Recordtypereglocation = Schema.SObjectType.CRM_CampaignLocationReferenceData__c.getRecordTypeInfosByName().get('Region').getRecordTypeId(); 
CRM_CampaignLocationReferenceData__c locationrefregiondata = new CRM_CampaignLocationReferenceData__c();
     locationrefregiondata.CRM_Region__c='Baylor/Tenet JV Region';
     locationrefregiondata.CRM_RegionCode__c='CR3';
     locationrefregiondata.RecordTypeId=Recordtypereglocation;
     locationrefregiondata.CRM_IsActive__c=True;
  insert locationrefregiondata;
Id Recordtypelocation = Schema.SObjectType.CRM_CampaignLocationReferenceData__c.getRecordTypeInfosByName().get('Market').getRecordTypeId(); 
CRM_CampaignLocationReferenceData__c refdata = new CRM_CampaignLocationReferenceData__c();
     refdata.CRM_Market__c='Baylor/Tenet JV Region';
     refdata.CRM_MarketCode__c='CR3';
     refdata.CRM_MarketsRegionID__c=locationrefregiondata.id;
     refdata.RecordTypeId=Recordtypelocation;
     refdata.CRM_IsActive__c=True;
  insert refdata;
Id Recordtypehospital = Schema.SObjectType.CRM_CampaignLocationReferenceData__c.getRecordTypeInfosByName().get('Hospital').getRecordTypeId(); 
CRM_CampaignLocationReferenceData__c Hospitalrefdata = new CRM_CampaignLocationReferenceData__c();
     Hospitalrefdata.CRM_Hospital__c='Baylor Scott & White Medical Center White Rock;Baylor Scott & White Medical Center - Centennial';
     Hospitalrefdata.CRM_HospitalCode__c='DHF';
     Hospitalrefdata.CRM_HospitalLocation__Latitude__s=32.835496;
     Hospitalrefdata.CRM_HospitalLocation__Longitude__s=-96.705023;
     Hospitalrefdata.CRM_HospitalsMarketID__c=refdata.id;
     Hospitalrefdata.RecordTypeId=Recordtypehospital;
     Hospitalrefdata.CRM_IsActive__c=True;
  insert Hospitalrefdata;

CRM_CampaignOwnershipDetail__c cmpownershipdetail = new CRM_CampaignOwnershipDetail__c();
     cmpownershipdetail.Campaign__c=newCampaign.id;
     cmpownershipdetail.Campaign_Location_Reference_Data_Mapping__c=Hospitalrefdata.id;
   //insert cmpownershipdetail;
   contact  contct = marketingDataUtils.CreateContact();  
   CampaignMember campaignmem = marketingDataUtils.createcampmember(newCampaign.id, contct.id);
   DRG_Code__c dr = marketingDataUtils.createDRGcode();
Campaign_Member_Criteria_Group__c  grp = new Campaign_Member_Criteria_Group__c();
        grp.Campaign__c=newCampaign.id;
        grp.Exclude__c = True;
        grp.Group_Name__c='test';
        grp.WM_CriteriaGroup_Id__c='12';
        grp.WM_Parent_group_Id__c='677';
        grp.Inner_Operator__c = 'OR';
          insert grp;
    Campaign_Member_Criteria__c mem= new Campaign_Member_Criteria__c();
        mem.Campaign__c=newCampaign.id;
        mem.Exclude__c=true;
        mem.Category__c = 'Ailments';
        mem.Criteria_Group__c = grp.id;
        mem.Field_Name__c='ZipCode__c';
           insert mem;     
   Campaign_Member_Criteria__c campaignmember = marketingDataUtils.createCampaignMemberCriteria(newCampaign.id);
   Location__c loctn = marketingDataUtils.createlocation();
   Campaign_Location__c  camploc = marketingDataUtils.createLocationInformation(newCampaign.id,loctn.id);
   Geographic__c  geo = marketingDataUtils.createGeographic();
   Geographic_Info_Information__c geoinfo = new Geographic_Info_Information__c();
           geoinfo.Campaign__c=newCampaign.id;
           geoinfo.Geographic_Info__c=geo.id;
           geoinfo.Audience_Search_Type__c ='Geography By Boundary';
              insert geoinfo;  
   campaignSequencer__c campsequencer = new campaignSequencer__c();
      campsequencer.Counter_Value__c=999;
      campsequencer.Name='count';
        insert campsequencer;
   Campaign_Related_List__c RelatedList = new Campaign_Related_List__c();
     RelatedList.Name='Campaign_Demographics__c';
      insert RelatedList;          
              
   Life_Style__c lifestyle = marketingDataUtils.createLifeStyle(newCampaign.id);
   Campaign_Demographics__c   cmpdemo = marketingDataUtils.createDemographics(newCampaign.id);
   Model__c   model = marketingDataUtils.createCampaignModel(newCampaign.id); 
   Encounter__c    enc = marketingDataUtils.createEncounter(newCampaign.id);
   Encounter_aggregates__c aggre = marketingDataUtils.createaggregates(newCampaign.id);
   //contact  con =marketingDataUtils.createcontact();
    id CloneCampid = mem.id;
    string oldvalue ='jjhdu';
    string newvalue ='vwg';
    string SelectedcdId = newCampaign.id;
   pagereference testpage = new pagereference ('/apex/CampaignWizard');
   Test.setcurrentPage(testPage);     
// CampaignWizardController.WrapperClassForDRGCheckBox wrap = new CampaignWizardController.WrapperClassForDRGCheckBox(dr);
CampaignWizardController.filterCriteria wrap1 = new CampaignWizardController.filterCriteria();
        wrap1.fieldApi = 'AND';
        wrap1.operator= 'AND';
        wrap1.value= 'AND';
CampaignWizardController.wrapRecord  wrap2 = new CampaignWizardController.wrapRecord(contct); 

  ApexPages.currentPage().getParameters().put('id',newCampaign.id);
  String id = ApexPages.currentPage().getParameters().get('id');
 system.debug('ConId---'+id);
 
 
 
  ApexPages.currentPage().getParameters().put('templateflag', 'true');
  String tempflag = ApexPages.currentPage().getParameters().get('templateflag');
 if(tempflag=='true'){
 detailPage=false;
 
            newcampaign.status='In development';
            newcampaign.program_name__c='xyz';
 }
  ApexPages.currentPage().getParameters().put('stepNo','1');
  ApexPages.currentPage().getParameters().put('btn','1');
  ApexPages.currentPage().getParameters().put('campflag','true');
  ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
  CampaignWizardController.insertMemberTypeCriteria(newCampaign.id,oldvalue,newvalue);
  CampaignWizardController.UpsertDemoCriteras(newCampaign.id,oldvalue,newvalue);
          CampaignWizardController  CampaignWiz = new CampaignWizardController(sc);
          list<SelectOption> lstMemberTypeValues = CampaignWiz.lstMemberTypeValues;
          list<SelectOption> lstCallTOActionValues = CampaignWiz.lstCallTOActionValues;
          list<SelectOption> ownershipList = CampaignWiz.ownershipList;
          list<SelectOption> ownershiptype = CampaignWiz.ownershiptype;
          CampaignWiz.TemplateFlag='True';
          CampaignWiz.selectedServiceLine='Burn';
           CampaignWiz.selectedChannel='Direct Mail';
           CampaignWiz.selectedCallToAction='HRA';
           CampaignWiz.selectedVendor='BG Solutions BS';
          CampaignWiz.DetailPage=False;
          CampaignWiz.stepNumFromPage=1;
          CampaignWiz.showTab();
          CampaignWiz.nextStep();  
          CampaignWiz.DetailPage=TRUE;
          CampaignWiz.previousStep();    
       Test.startTest();  
          CampaignWiz.init();
          CampaignWiz.initFilter();
          CampaignWiz.closePopup();
          CampaignWiz.fetchSubServiceLineNames();
          CampaignWiz.Childflag = False;
          CampaignWiz.TemplateFlag = 'false';    
          CampaignWiz.campId =newCampaign.id;
          CampaignWiz.CloneCampaign();     
          CampaignWiz.getFields();
          CampaignWiz.getOperator();
          CampaignWiz.refreshSubServiceLines();
          CampaignWiz.ViewChildCampaign();
          CampaignWiz.TemplateFlag='True';
          CampaignWiz.DetailPage=False;
          CampaignWiz.Childflag = True;
          CampaignWiz.SaveCampaign();
          CampaignWiz.deleteAllGeoServiceArea();
          CampaignWiz.EditCampaign();
          //CampaignWiz.SubServiceLine();
          CampaignWiz.insertOwnershipJO(newCampaign.id);
          CampaignWiz.saveownershipvalues();
          CampaignWiz.tactic();
          CampaignWiz.TacticMember();
          CampaignWiz.BacktoCampaign();
          CampaignWiz.AddLoc();   
          CampaignWiz.CancelEditCampaign();
          CampaignWiz.method1();
          CampaignWiz.SelectedchildId = SelectedcdId;
          CampaignWiz.DeleteChild();
          CampaignWiz.encounter();
          CampaignWiz.encounter_aggregates();
          CampaignWiz.LifeStyle();
          CampaignWiz.demo();
          CampaignWiz.enc_back();
          CampaignWiz.model();
          CampaignWiz.values();
          CampaignWiz.refreshCount();
          CampaignWiz.membervalues();
          CampaignWiz.activatecampaign();
          CampaignWiz.getownername();
          //CampaignWiz.createControlGroup ();
          CampaignWiz.selectedCriteria.add('Hospital');
         Test.stopTest();
  }
    public static testmethod void CampaignWizardmethod1(){
		Campaign cmp = new Campaign();
            cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V2';
            cmp.Service_Line__c='Burn';
            cmp.CRM_SubServiceLineText__c='Dermatology';
            cmp.Tactic__c='Mail';
            cmp.Audience_Hospital__c ='Phoenix-Abrazo Arrowhead Campus';
            cmp.Audience_Region__c='Texas';      
            cmp.Channel__c='Direct Mail';
              insert cmp;      
        
        
        contact  contct = marketingDataUtils.CreateContact();
        DRG_Code__c dr = marketingDataUtils.createDRGcode();
  pagereference testpage = new pagereference ('/apex/CampaignWizard');
  Test.setcurrentPage(testPage);    
 //CampaignWizardController.WrapperClassForDRGCheckBox wrap = new CampaignWizardController.WrapperClassForDRGCheckBox(dr);
CampaignWizardController.filterCriteria wrap1 = new CampaignWizardController.filterCriteria();
CampaignWizardController.wrapRecord  wrap2 = new CampaignWizardController.wrapRecord(contct);  
  ApexPages.currentPage().getParameters().put('id',cmp.id);
  
  ApexPages.StandardController sc = new ApexPages.standardController(cmp);
  CampaignWizardController  CampaignWiz = new CampaignWizardController(sc);       
          CampaignWiz.init();
          CampaignWiz.getownername();
          CampaignWiz.Childflag=True;
          CampaignWiz.initFilter();
          CampaignWiz.closePopup();
          CampaignWiz.stepNumFromPage=4;     
          CampaignWiz.showTab();
          //=-campaignWiz.deleteaudience();
          campaignWiz.segmentnavbar();
          campaignWiz.CountAnalysis();
   }
    
  public static testmethod void CampaignWizardmethod3(){
Campaign cmp = new Campaign();
            cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V2';
            cmp.Service_Line__c='Burn';
            cmp.CRM_SubServiceLineText__c='Dermatology';
            cmp.Tactic__c='Mail';
            cmp.Audience_Hospital__c ='Phoenix-Abrazo Arrowhead Campus';
            cmp.Audience_Region__c='Texas';      
            cmp.Channel__c='Direct Mail';
              insert cmp;     pagereference testpage = new pagereference ('/apex/CampaignWizard');
     Test.setcurrentPage(testPage);     
     CampaignWizardController.filterCriteria wrap1 = new CampaignWizardController.filterCriteria(); 
          ApexPages.currentPage().getParameters().put('id',cmp.id);
          ApexPages.StandardController sc = new ApexPages.standardController(cmp);
      CampaignWizardController  CampaignWiz = new CampaignWizardController(sc);
           CampaignWiz.stepNumFromPage=5;
           CampaignWiz.showTab();
          
       
}


public static testmethod void CampaignWizardmethod4(){
Campaign cmp = new Campaign();
            cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V2';
            cmp.Service_Line__c='Burn';
            cmp.CRM_SubServiceLineText__c='Dermatology';
            cmp.Tactic__c='Mail';
            cmp.Audience_Hospital__c ='Phoenix-Abrazo Arrowhead Campus';
            cmp.Audience_Region__c='Texas';      
            cmp.Channel__c='Direct Mail';
              insert cmp;     pagereference testpage = new pagereference ('/apex/CampaignWizard');
     Test.setcurrentPage(testPage);     
     CampaignWizardController.filterCriteria wrap1 = new CampaignWizardController.filterCriteria(); 
          ApexPages.currentPage().getParameters().put('id',cmp.id);
          ApexPages.StandardController sc = new ApexPages.standardController(cmp);
      CampaignWizardController  CampaignWiz = new CampaignWizardController(sc);
           CampaignWiz.stepNumFromPage=3;
           CampaignWiz.showTab();
           CampaignWiz.refreshCountButtonMethod();
       
}



    public static testmethod void nextstep(){
Id RecordtypeTargated = Schema.SObjectType.Campaign.getRecordTypeInfosByName().get('Targeted').getRecordTypeId();
Campaign newCampaign = new Campaign();
            newCampaign.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
            newCampaign.Service_Line__c='Burn';
            newCampaign.CRM_SubServiceLineText__c='Dermatology';
            newCampaign.Tactic__c='Mail';
            newCampaign.RecordTypeId=RecordtypeTargated;
            newCampaign.Channel__c='Direct Mail';
            newCampaign.Approved__c =true;
            newCampaign.Vendor_Name__c='BG Solutions BS';
            newCampaign.CRM_SelectedOwnershipCriteria__c='DT1;TX2';
            newCampaign.CRM_OwnershipType__c='Market';
            newCampaign.Status ='In Development';
            newCampaign.Call_to_Action__c='HRA';
            newCampaign.Control_Group_Percentage__c =100;
            newCampaign.Current_count__c=21;
            newCampaign.LIST_ORDER_SELECT_GRP_ID__c=354;
            newCampaign.List_Order_Id__c=7333;
            newCampaign.StartDate=Date.newInstance(2015,01,10);
            newCampaign.EndDate=Date.newInstance(2015,01,20);
            newCampaign.Place_Order_Date_Time__c =system.today();
            newCampaign.Member_Types__c='Campaign Segments';
              insert newCampaign;
        String channelold = newCampaign.Channel__c;
        newCampaign.Channel__c = 'Email';

        String channelnew = 'Email';
        
     Campaign cmp = new Campaign();
            cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V2';
            cmp.Service_Line__c='Burn';
            cmp.CRM_SubServiceLineText__c='Dermatology';
            cmp.Tactic__c='Mail';
            cmp.Audience_Hospital__c ='Phoenix-Abrazo Arrowhead Campus';
            cmp.Audience_Region__c='Texas';      
            cmp.Channel__c='Direct Mail';
            cmp.ParentId=newCampaign.id;
              insert cmp;
       
        
        
        List<Campaign> childlist = new List<Campaign>();
        childlist.add(cmp);
        
CRM_CampaignWizardReferenceData__c wizrefdata = new CRM_CampaignWizardReferenceData__c();
     wizrefdata.CRM_ServiceLine__c='Burn';
     wizrefdata.CRM_CallToAction__c='HRA';
     wizrefdata.CRM_Channel__c='Direct Mail';
     wizrefdata.CRM_SubServiceLine__c='Dermatology';
     wizrefdata.CRM_VendorName__c='BG Solutions BS';
     wizrefdata.CRM_IsActive__c=True;
    insert wizrefdata;
CRM_CampaignLocationReferenceData__c locationrefdata = new CRM_CampaignLocationReferenceData__c();
     locationrefdata.CRM_Hospital__c='Abrazo Arizona Heart Hospital';
     locationrefdata.CRM_Region__c='Detroit Market';
     locationrefdata.CRM_ServiceArea__c='Primary Service Area';
     locationrefdata.CRM_Market__c ='Detroit Market';
     locationrefdata.CRM_IsActive__c=True;
    insert locationrefdata;
CRM_CampaignOwnershipDetail__c cmpownershipdetail = new CRM_CampaignOwnershipDetail__c();
     cmpownershipdetail.Campaign__c=newCampaign.id;
     cmpownershipdetail.Campaign_Location_Reference_Data_Mapping__c=locationrefdata.id;
    insert cmpownershipdetail;
     pagereference testpage = new pagereference ('/apex/CampaignWizard');
     Test.setcurrentPage(testPage);     
     CampaignWizardController.filterCriteria wrap1 = new CampaignWizardController.filterCriteria(); 
          ApexPages.currentPage().getParameters().put('id',newCampaign.id);
          ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
      CampaignWizardController  CampaignWiz = new CampaignWizardController(sc);
           CampaignWiz.selectedServiceLine='Burn';
           CampaignWiz.selectedChannel='Direct Mail';
           CampaignWiz.selectedCallToAction='HRA';
           CampaignWiz.selectedVendor='BG Solutions BS';
           CampaignWiz.parentCampName ='parentnamecampaign';
           CampaignWiz.nextStep();
           CampaignWiz.DelCampaign();
           CampaignWiz.SaveCampaign();
           CampaignWiz.fetchOwnershipNames();
           CampaignWiz.CloneCampaign(); 
           //CampaignWiz.insertOwnershipJO(newCampaign.id);
           CampaignWiz.saveownershipvalues();
           CampaignWiz.clearCriteria();
           
            
           
    }
        public static testmethod void nextstep3(){
Campaign newCampaign = new Campaign();
            newCampaign.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
            newCampaign.Service_Line__c='Burn';
            newCampaign.CRM_SubServiceLineText__c='Dermatology';
            newCampaign.Tactic__c='Mail';
            newCampaign.Audience_Hospital__c ='Phoenix-Abrazo Arizona Heart Hospital';
            newCampaign.Channel__c='Direct Mail';
            newCampaign.Approved__c =true;
            newCampaign.Status ='In Development';
            newCampaign.Control_Group_Percentage__c =100;
            newCampaign.Current_count__c=21;
            newCampaign.LIST_ORDER_SELECT_GRP_ID__c=354;
            newCampaign.List_Order_Id__c=7333;
            newCampaign.StartDate=Date.newInstance(2015,01,10);
            newCampaign.EndDate=Date.newInstance(2015,01,20);
            newCampaign.Place_Order_Date_Time__c =system.today();
              insert newCampaign;
     Campaign cmp = new Campaign();
            cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V2';
            cmp.Service_Line__c='Burn';
            cmp.CRM_SubServiceLineText__c='Dermatology';
            cmp.Tactic__c='Mail';
            cmp.Audience_Hospital__c ='Phoenix-Abrazo Arrowhead Campus';
            cmp.Audience_Region__c='Texas';      
            cmp.Channel__c='Direct Mail';
            cmp.ParentId=newCampaign.id;
              insert cmp;
     pagereference testpage = new pagereference ('/apex/CampaignWizard');
     Test.setcurrentPage(testPage);     
     CampaignWizardController.filterCriteria wrap1 = new CampaignWizardController.filterCriteria(); 
          ApexPages.currentPage().getParameters().put('id',newCampaign.id);
       //   if(newCampaign.Name!=null && newCampaign.Name.length()>0 && newCampaign.Name!=''){
        //   List<Campaign> lstCampaigns = [SELECT id FROM Campaign WHERE name =: newCampaign.Name];
        //   }
          
          ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
      CampaignWizardController  CampaignWiz = new CampaignWizardController(sc);
           CampaignWiz.parentCampName ='20170525-102-Detroit-Nephrology/Urology-Operational-V1';
           CampaignWiz.nextStep();
           
    }

    public static testmethod void nextstep2(){
Campaign newCampaign = new Campaign();
            newCampaign.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
            newCampaign.Service_Line__c='Burn';
            newCampaign.CRM_SubServiceLineText__c='Dermatology';
            newCampaign.Tactic__c='Mail';
            newCampaign.Audience_Hospital__c ='Phoenix-Abrazo Arizona Heart Hospital';
            newCampaign.Channel__c='Direct Mail';
            newCampaign.Approved__c =true;
            newCampaign.Status ='In Development';
            newCampaign.Control_Group_Percentage__c =100;
            newCampaign.Current_count__c=21;
            newCampaign.LIST_ORDER_SELECT_GRP_ID__c=354;
            newCampaign.List_Order_Id__c=7333;
            newCampaign.StartDate=Date.newInstance(2015,01,10);
            newCampaign.EndDate=Date.newInstance(2015,01,20);
            newCampaign.Place_Order_Date_Time__c =system.today();
              insert newCampaign;
     Campaign cmp = new Campaign();
            cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V2';
            cmp.Service_Line__c='Burn';
            cmp.CRM_SubServiceLineText__c='Dermatology';
            cmp.Tactic__c='Mail';
            cmp.Audience_Hospital__c ='Phoenix-Abrazo Arrowhead Campus';
            cmp.Audience_Region__c='Texas';      
            cmp.Channel__c='Direct Mail';
            cmp.ParentId=newCampaign.id;
              insert cmp;
     pagereference testpage = new pagereference ('/apex/CampaignWizard');
     Test.setcurrentPage(testPage);     
     CampaignWizardController.filterCriteria wrap1 = new CampaignWizardController.filterCriteria(); 
          ApexPages.currentPage().getParameters().put('id',newCampaign.id);
       //   if(newCampaign.Name!=null && newCampaign.Name.length()>0 && newCampaign.Name!=''){
        //   List<Campaign> lstCampaigns = [SELECT id FROM Campaign WHERE name =: newCampaign.Name];
        //   }
          
          ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
      CampaignWizardController  CampaignWiz = new CampaignWizardController(sc);
           CampaignWiz.parentCampName =newCampaign.Name;
           
           CampaignWiz.nextStep();
           
    }
    public static testmethod void CampaignWizardmethodnew(){
 		Campaign newCampaign = new Campaign();
        newCampaign.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        newCampaign.Service_Line__c='Burn';
        newCampaign.CRM_SubServiceLineText__c='Dermatology';
        newCampaign.Tactic__c='Mail';
        newCampaign.Audience_Hospital__c ='Phoenix-Abrazo Arizona Heart Hospital';
        newCampaign.Audience_Region__c='Texas';
        newCampaign.Channel__c='Direct Mail';
        newCampaign.Approved__c =true;
        newCampaign.Status ='In Development';
        newCampaign.Control_Group_Percentage__c =100;
        newCampaign.Current_count__c=21;
        newCampaign.LIST_ORDER_SELECT_GRP_ID__c=354;
        newCampaign.List_Order_Id__c=7333;
        newCampaign.Place_Order_Date_Time__c =system.today();
        newCampaign.Member_types__c='Test';
        insert newCampaign;
       
        WundermanLogin__c login = new WundermanLogin__c();
	      login.EndpointURL__c= 'https://thcintellisight.uat.kbmg.com/IntellisightListAPI/com/wunderman/api/listOrder';
	      login.Session_Id__c ='5685179';
	      login.Password__c ='tenet1test';
	      login.GetSession__c='GetSession.jsp';
	      login.Name ='tenettest1';
	         insert login; 
         
      CRM_MemberTypeReferenceData__c cS = new CRM_MemberTypeReferenceData__c(Name='Campaign Segments',CRM_IsActive__c=true,CRM_IsParentCampaign__c=true);
      insert cS;
      
      contact con = marketingDataUtils.createcontact();
      CampaignMember campaignmem = marketingDataUtils.createcampmember(newCampaign.id, con.id);
       Lead  ld = marketingDataUtils.createleads();
      Transaction__c  tr = marketingDataUtils.createTransaction(newCampaign.id,ld.id);
      pagereference testpage = new pagereference ('/apex/CampaignWizard');
     Test.setcurrentPage(testPage);     
     CampaignWizardController.filterCriteria wrap1 = new CampaignWizardController.filterCriteria(); 
          ApexPages.currentPage().getParameters().put('id',newCampaign.id);
          ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
      CampaignWizardController  CampaignWiz = new CampaignWizardController(sc);
      Test.startTest();
    string response='<submitMessageResponseObject><responseCode>0</responseCode><transactionId>1568502965</transactionId><attributes><entry><key>NEW_PERSON_IND</key><value>1</value></entry></attributes><jobId>0</jobId><objects><entry><key>person</key><value xsi:type="ns3:person" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns3="com.kbmg.remix.api"><address1>239 GRANT ST</address1><attributes/><city>PARK FOREST</city><country>USA</country><dob>11/03/1971</dob><emailAddress>B_2_WILLIAMS@MYEMAILPROVIDER.COM</emailAddress><firstName>BILLY</firstName><id>WDM1223</id><lastName>WILLIAMS</lastName><middleName>D</middleName><objects/><state>IL</state><suffix>III</suffix><telephone>281.777.9311</telephone></value></entry></objects></submitMessageResponseObject>';
    Test.setMock(HttpCalloutMock.class, new MockHttpResponse(response));
        CampaignWiz.refreshNetCount();
        CampaignWiz.activatecampaign();
        //CampaignWiz.createControlGroup();

      Test.stopTest();
}
    public static testmethod void CampaignWizardApprovedacmp(){
 			Campaign newCampaign = new Campaign();
            newCampaign.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
            newCampaign.Service_Line__c='Burn';
            newCampaign.CRM_SubServiceLineText__c='Dermatology';
            newCampaign.Approved__c=True;
            newCampaign.Vendor_Name__c='Amplified Digital (AD)';
            newCampaign.Audience_Hospital__c ='ABRAZO ARIZONA HEART HOSPITAL';
            newCampaign.Audience_Region__c='Texas;Western';
            newCampaign.Channel__c='Direct Mail';
            newCampaign.Status ='In Development';
            newCampaign.Control_Group_Percentage__c =100;
            newCampaign.Current_count__c=21;
            newCampaign.LIST_ORDER_SELECT_GRP_ID__c=354;
            newCampaign.List_Order_Id__c=7333;
            newCampaign.Approved_By__c ='vaishali';
            newCampaign.CRM_OwnershipType__c = 'Hospital';
            newCampaign.Place_Order_Date_Time__c =system.today();
              insert newCampaign;
      
      campaignSequencer__c campsequencer = new campaignSequencer__c();
      campsequencer.Counter_Value__c=999;
      campsequencer.Name='count';
        insert campsequencer;
         String camp_name = '20171004-104-South Carolina-Physical Therapy/Rehabilitation-External Mobile Messaging-V1';
      contact con = marketingDataUtils.createcontact();
      CampaignMember campaignmem = marketingDataUtils.createcampmember(newCampaign.id, con.id);
      Location__c loctn = marketingDataUtils.createlocation();
      Campaign_Location__c  camploc = marketingDataUtils.createLocationInformation(newCampaign.id,loctn.id);
       Lead  ld = marketingDataUtils.createleads();
      Transaction__c  tr = marketingDataUtils.createTransaction(newCampaign.id,ld.id);
      pagereference testpage = new pagereference ('/apex/CampaignWizard');
     Test.setcurrentPage(testPage);     
     CampaignWizardController.filterCriteria wrap1 = new CampaignWizardController.filterCriteria(); 
          ApexPages.currentPage().getParameters().put('id',newCampaign.id);
          ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
      CampaignWizardController  CampaignWiz = new CampaignWizardController(sc);
      Test.startTest();
        CampaignWiz.activatecampaign();
        //CampaignWiz.vendorname();
        CampaignWiz.campname_value1 ='val';
        CampaignWiz.nameFlag = false;
        CampaignWiz.CampNamingConvention();
      Test.stopTest();
    }
     public static testmethod void CampaignWizardApprovedacmp1(){
 			Id Recordtypereglocation = Schema.SObjectType.CRM_CampaignLocationReferenceData__c.getRecordTypeInfosByName().get('Region').getRecordTypeId(); 
			CRM_CampaignLocationReferenceData__c locationrefregiondata = new CRM_CampaignLocationReferenceData__c();
		    locationrefregiondata.CRM_Region__c='Baylor/Tenet JV Region';
		    locationrefregiondata.CRM_RegionCode__c='CR3';
		    locationrefregiondata.RecordTypeId=Recordtypereglocation;
		    locationrefregiondata.CRM_IsActive__c=True;
		  	insert locationrefregiondata;
			
		    List<RecordType> lstRecTypeCRD = [select developerName,id from RecordType where sObjectType='CRM_CampaignWizardReferenceData__c' AND developerName = 'Service_Line'];
		     CRM_CampaignWizardReferenceData__c crd = new CRM_CampaignWizardReferenceData__c ();
		     if(lstRecTypeCRD.size()>0) {             
		         crd.CRM_IsActive__c = true;
		         crd.Recordtypeid = lstRecTypeCRD[0].id;
		         crd.CRM_ServiceLine__c= 'Branding';
		         insert crd;
		    }
		    List<RecordType> lstRecTypeCRD3 = [select developerName,id from RecordType where sObjectType='CRM_CampaignWizardReferenceData__c' AND developerName = 'ChannelValues'];
		    CRM_CampaignWizardReferenceData__c crd3 = new CRM_CampaignWizardReferenceData__c ();
		     if(lstRecTypeCRD3.size()>0) {             
		         crd3.CRM_IsActive__c = true;
		         crd3.Recordtypeid = lstRecTypeCRD3[0].id;
		         crd3.CRM_DemoEmail__c = 'Has an email address';
		         crd3.CRM_DemoMailingAddress__c= 'Everyone';
		         crd3.CRM_Channel__c = 'Email';
		         insert crd3;
		    }
        
 			Campaign newCampaign = new Campaign();
            newCampaign.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
            newCampaign.Service_Line__c='Burn';
            newCampaign.CRM_SubServiceLineText__c='Dermatology';
            newCampaign.Approved__c=True;
            newCampaign.Vendor_Name__c='Amplified Digital (AD)';
            newCampaign.Audience_Hospital__c ='ABRAZO ARIZONA HEART HOSPITAL';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';
            newCampaign.Status ='In Development';
            newCampaign.Control_Group_Percentage__c =100;
            newCampaign.Current_count__c=21;
            newCampaign.LIST_ORDER_SELECT_GRP_ID__c=354;
            newCampaign.List_Order_Id__c=7333;
            newCampaign.Approved_By__c ='vaishali';
            newCampaign.CRM_OwnershipType__c = 'Region';
            newCampaign.Place_Order_Date_Time__c =system.today();
            insert newCampaign;
      
      campaignSequencer__c campsequencer = new campaignSequencer__c();
      campsequencer.Counter_Value__c=999;
      campsequencer.Name='count';
        insert campsequencer;
        
      contact con = marketingDataUtils.createcontact();
      CampaignMember campaignmem = marketingDataUtils.createcampmember(newCampaign.id, con.id);
      Location__c loctn = marketingDataUtils.createlocation();
      Campaign_Location__c  camploc = marketingDataUtils.createLocationInformation(newCampaign.id,loctn.id);
       Lead  ld = marketingDataUtils.createleads();
      Transaction__c  tr = marketingDataUtils.createTransaction(newCampaign.id,ld.id);
      pagereference testpage = new pagereference ('/apex/CampaignWizard');
     Test.setcurrentPage(testPage);     
     CampaignWizardController.filterCriteria wrap1 = new CampaignWizardController.filterCriteria(); 
          ApexPages.currentPage().getParameters().put('id',newCampaign.id);
          ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
      CampaignWizardController  CampaignWiz = new CampaignWizardController(sc);
      Test.startTest();
        CampaignWiz.activatecampaign();
        
        list<SelectOption> ownershipList =  CampaignWiz.ownershipList; 
      	CampaignWiz.selectedCriteria.add(string.valueof(locationrefregiondata.id));
        CampaignWiz.selectedServiceLine = crd.id;
        CampaignWiz.selectedChannel = crd3.id;
        CampaignWiz.activatecampaign();
        //CampaignWiz.vendorname();
        CampaignWiz.campname_value1 ='val';
        CampaignWiz.nameFlag = false;
     	CampaignWiz.camp_name = '20171004-104-South Carolina-Physical Therapy/Rehabilitation-External Mobile Messaging-V1';
        CampaignWiz.SaveCampaign();
        CampaignWiz.CampNamingConvention();
        
      Test.stopTest();
     }
    public static testmethod void savecamp(){
    String camp_clone_id;
    Campaign camp_clone1;
        Campaign newCampaign = new Campaign();
            newCampaign.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
            newCampaign.Service_Line__c='Burn';
            newCampaign.CRM_SubServiceLineText__c='Dermatology';
            newCampaign.Tactic__c='Mail';
            newCampaign.Audience_Hospital__c ='Phoenix-Abrazo Arrowhead Campus;ABRAZO ARIZONA HEART HOSPITAL';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';
            newCampaign.Member_Types__c='No Encounters - Prospects';
              insert newCampaign;
      newCampaign.Audience_Region__c='Western';
          update newCampaign;
        
         Campaign clonecamp=newCampaign.clone(false,true);
         Campaign cmp = new Campaign();
            cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V2';
            cmp.Service_Line__c='Burn';
            cmp.CRM_SubServiceLineText__c='Dermatology';
            cmp.Tactic__c='Mail';
            cmp.Audience_Hospital__c ='Phoenix-Abrazo Arrowhead Campus';
            cmp.Audience_Region__c='Texas';      
            cmp.Channel__c='Direct Mail';
            cmp.ParentId=newCampaign.id;       
              upsert cmp;
   contact  contct = marketingDataUtils.CreateContact();  
   CampaignMember campaignmem = marketingDataUtils.createcampmember(newCampaign.id, contct.id);
   DRG_Code__c dr = marketingDataUtils.createDRGcode();     
   Campaign_Member_Criteria__c campaignmember = marketingDataUtils.createCampaignMemberCriteria(newCampaign.id);
   Location__c loctn = marketingDataUtils.createlocation();
   Campaign_Location__c  camploc = marketingDataUtils.createLocationInformation(newCampaign.id,loctn.id);
   Geographic__c  geo = marketingDataUtils.createGeographic();
   Geographic_Info_Information__c geoinfo = new Geographic_Info_Information__c();
           geoinfo.Campaign__c=newCampaign.id;
           geoinfo.Geographic_Info__c=geo.id;
           geoinfo.Audience_Search_Type__c ='Geography By Boundary';
              insert geoinfo;
   Life_Style__c lifestyle = marketingDataUtils.createLifeStyle(newCampaign.id);
   Campaign_Demographics__c   cmpdemo = marketingDataUtils.createDemographics(newCampaign.id);
   Model__c   model = marketingDataUtils.createCampaignModel(newCampaign.id); 
   Encounter__c    enc = marketingDataUtils.createEncounter(newCampaign.id);
   Encounter_aggregates__c aggre = marketingDataUtils.createaggregates(newCampaign.id);
   //contact  con =marketingDataUtils.createcontact();
    id CloneCampid = campaignmember.id;
    string oldvalue ='No Encounters - Prospects ';
    string newvalue ='One or more encounters - Patients';
    string SelectedcdId = newCampaign.id;
   pagereference testpage = new pagereference ('/apex/CampaignWizard');
   Test.setcurrentPage(testPage);     
CampaignWizardController.filterCriteria wrap1 = new CampaignWizardController.filterCriteria();
        wrap1.fieldApi = 'AND';
        wrap1.operator= 'AND';
        wrap1.value= 'AND';
CampaignWizardController.wrapRecord  wrap2 = new CampaignWizardController.wrapRecord(contct);  
  ApexPages.currentPage().getParameters().put('id',newCampaign.id);
  
  ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
  CampaignWizardController.insertMemberTypeCriteria(newCampaign.id,oldvalue,newvalue);
          CampaignWizardController  CampaignWiz = new CampaignWizardController(sc);  
          CampaignWiz.TemplateFlag= 'FALSE';
          CampaignWiz.DetailPage = True;
          CampaignWiz.selectedCriteria.add('Hospital');
          CampaignWiz.Childflag = True;
         
          CampaignWiz.SaveCampaign();
          
         
  }
   public static testmethod void CampaignWizardmethod5(){
  
 SObject headSObject ,headClone;
 Campaign newCampaign = new Campaign();
            newCampaign.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
            newCampaign.Service_Line__c='Burn';
            newCampaign.CRM_SubServiceLineText__c='Dermatology';
            newCampaign.Tactic__c='Mail';
            newCampaign.Audience_Hospital__c ='Phoenix-Abrazo Arrowhead Campus;ABRAZO ARIZONA HEART HOSPITAL';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';
            newcampaign.status='In development';
            newcampaign.program_name__c='xyz';
              insert newCampaign;
              
 campaignSequencer__c campsequencer = new campaignSequencer__c();
      campsequencer.Counter_Value__c=999;
      campsequencer.Name='count';
        insert campsequencer;
  ApexPages.currentPage().getParameters().put('id',newCampaign.id);
  String id = ApexPages.currentPage().getParameters().get('id');
 system.debug('ConId---'+id);
 List<SObject> primaryObjectQueryString = [SELECT Id, Name FROM Campaign WHERE Id =: id limit 1];
 system.debug('ConId list=================---'+primaryObjectQueryString );
 SObject a = primaryObjectQueryString.get(0);
 system.debug('ConId 9999---'+a);
ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
  
          CampaignWizardController  CampaignWiz = new CampaignWizardController(sc);
          CampaignWiz.campflag='false';
          //CampaignWiz.CampNamingConvention();
          CampaignWiz.addChildCamp();
           CampaignWiz.SaveCampaign();
          }
          
          
 public static testmethod void CampaignWizardmethodnamingconv(){
  
 String parentCampName;
 Campaign newCampaign = new Campaign();
            newCampaign.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
            newCampaign.Service_Line__c='Burn';
            newCampaign.CRM_SubServiceLineText__c='Dermatology';
            newCampaign.Tactic__c='Mail';
            newCampaign.Audience_Hospital__c ='Phoenix-Abrazo Arrowhead Campus;ABRAZO ARIZONA HEART HOSPITAL';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';
            newcampaign.status='In development';
            newcampaign.program_name__c='xyz';
              insert newCampaign;
              
              Campaign newCampnext = new Campaign();
            newCampnext.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
            newCampnext.Service_Line__c='Burn';
            newCampnext.CRM_SubServiceLineText__c='Dermatology';
            newCampnext.Tactic__c='Mail';
            newCampnext.Audience_Hospital__c ='Phoenix-Abrazo Arrowhead Campus;ABRAZO ARIZONA HEART HOSPITAL';
            newCampnext.Audience_Region__c='Texas';
            newCampnext.Channel__c='Direct Mail';
            newCampnext.status='In development';
            newCampnext.program_name__c='xyz';
         //  newCampnext.parentid=newcampaign.id;
              insert newCampnext ;
              system.debug('parentof camp====='+newcampnext.parent.name);
  parentcampname=newCampaign.Name;
  system.debug('id name of parent============='+parentcampname);
  ApexPages.currentPage().getParameters().put('id',newCampaign.id);
  String id = ApexPages.currentPage().getParameters().get('id');
 system.debug('ConId---'+id);
 System.debug('length of name==========='+parentcampname.length());
  
  List<Campaign> lstCampaigns = [SELECT id FROM Campaign WHERE name = :parentcampname];
  //System.assertEquals(0, lstCampaigns.size());
   System.debug('size of location list==========='+lstCampaigns.size());
   System.debug('list location list==========='+lstCampaigns[0]);
   newCampnext.parentid=newcampaign.id;
  system.debug('lstcampaign name assign---'+newCampnext.parentid);
ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
  
          CampaignWizardController  CampaignWiz = new CampaignWizardController(sc);
         
         CampaignWiz.campflag='true';
         CampaignWiz.templateflag='false';
        CampaignWiz.parentcampname=newCampaign.Name;
          CampaignWiz.SaveCampaign();
          
       }   
       
       
       public static testmethod void CampaignWizardmethodflag(){
  
 
 Campaign newCampaign = new Campaign();
            newCampaign.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
            newCampaign.Service_Line__c='Burn';
            newCampaign.CRM_SubServiceLineText__c='Dermatology';
            newCampaign.Tactic__c='Mail';
            newCampaign.Audience_Hospital__c ='Phoenix-Abrazo Arrowhead Campus;ABRAZO ARIZONA HEART HOSPITAL';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';
            newcampaign.status='In development';
            newcampaign.program_name__c='xyz';
              insert newCampaign;
       ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
  
          CampaignWizardController  CampaignWiz = new CampaignWizardController(sc);
         
         
         CampaignWiz.templateflag='true';
         CampaignWiz.detailpage=false;
        newcampaign.status='In Development';
          newcampaign.name='New Campaign';
       
 }
        public static testmethod void Nontargatedcamp(){
 Campaign newCampaign = new Campaign();
            newCampaign.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
            newCampaign.Service_Line__c='Burn';
            newCampaign.CRM_SubServiceLineText__c='Dermatology';
            newCampaign.Tactic__c='Mail';
            newCampaign.Audience_Hospital__c ='Phoenix-Abrazo Arizona Heart Hospital';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';
            newCampaign.Approved__c =true;
            newCampaign.Status ='In Development';
            newCampaign.Control_Group_Percentage__c =100;
            newCampaign.Current_count__c=21;
            newCampaign.LIST_ORDER_SELECT_GRP_ID__c=354;
            newCampaign.List_Order_Id__c=7333;
            newCampaign.Place_Order_Date_Time__c =system.today();
              insert newCampaign;
        WundermanLogin__c login = new WundermanLogin__c();
      login.EndpointURL__c= 'https://thcintellisight.uat.kbmg.com/IntellisightListAPI/com/wunderman/api/listOrder';
      login.Session_Id__c ='5685179';
      login.Password__c ='tenet1test';
      login.GetSession__c='GetSession.jsp';
      login.Name ='tenettest1';
         insert login; 
      contact con = marketingDataUtils.createcontact();
      CampaignMember campaignmem = marketingDataUtils.createcampmember(newCampaign.id, con.id);
       Lead  ld = marketingDataUtils.createleads();
      Transaction__c  tr = marketingDataUtils.createTransaction(newCampaign.id,ld.id);
      pagereference testpage = new pagereference ('/apex/CampaignWizard');
     Test.setcurrentPage(testPage);     
     CampaignWizardController.filterCriteria wrap1 = new CampaignWizardController.filterCriteria(); 
          ApexPages.currentPage().getParameters().put('id',newCampaign.id);
          ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
      CampaignWizardController  CampaignWiz = new CampaignWizardController(sc);
      Test.startTest();
    string response='<submitMessageResponseObject><responseCode>0</responseCode><transactionId>1568502965</transactionId><attributes><entry><key>NEW_PERSON_IND</key><value>1</value></entry></attributes><jobId>0</jobId><objects><entry><key>person</key><value xsi:type="ns3:person" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns3="com.kbmg.remix.api"><address1>239 GRANT ST</address1><attributes/><city>PARK FOREST</city><country>USA</country><dob>11/03/1971</dob><emailAddress>B_2_WILLIAMS@MYEMAILPROVIDER.COM</emailAddress><firstName>BILLY</firstName><id>WDM1223</id><lastName>WILLIAMS</lastName><middleName>D</middleName><objects/><state>IL</state><suffix>III</suffix><telephone>281.777.9311</telephone></value></entry></objects></submitMessageResponseObject>';
    Test.setMock(HttpCalloutMock.class, new MockHttpResponse(response));
        CampaignWiz.refreshNetCount();
        CampaignWiz.isTargetedCampaign =False;
        CampaignWiz.activatecampaign();
        //CampaignWiz.createControlGroup();
 CampaignWiz.SaveCampaign();
      Test.stopTest();
}

public static testmethod void Nontargatedcamp3(){
 Campaign newCampaign = new Campaign();
            newCampaign.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
            newCampaign.Service_Line__c='Burn';
            newCampaign.CRM_SubServiceLineText__c='Dermatology';
            newCampaign.Tactic__c='Mail';
            newCampaign.Audience_Hospital__c ='Phoenix-Abrazo Arizona Heart Hospital';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';
            newCampaign.Approved__c =true;
            newCampaign.Approved_By__c='abc';
            newCampaign.Status ='In Development';
            newCampaign.Control_Group_Size__c=null;
            newCampaign.Control_Group_Percentage__c =null;
            newCampaign.Current_count__c=21;
            newCampaign.LIST_ORDER_SELECT_GRP_ID__c=354;
            newCampaign.List_Order_Id__c=7333;
            newCampaign.Place_Order_Date_Time__c =system.today();
              insert newCampaign;
        WundermanLogin__c login = new WundermanLogin__c();
      login.EndpointURL__c= 'https://thcintellisight.uat.kbmg.com/IntellisightListAPI/com/wunderman/api/listOrder';
      login.Session_Id__c ='5685179';
      login.Password__c ='tenet1test';
      login.GetSession__c='GetSession.jsp';
      login.Name ='tenettest1';
         insert login; 
      contact con = marketingDataUtils.createcontact();
      CampaignMember campaignmem = marketingDataUtils.createcampmember(newCampaign.id, con.id);
       Lead  ld = marketingDataUtils.createleads();
      Transaction__c  tr = marketingDataUtils.createTransaction(newCampaign.id,ld.id);
      pagereference testpage = new pagereference ('/apex/CampaignWizard');
     Test.setcurrentPage(testPage);     
     CampaignWizardController.filterCriteria wrap1 = new CampaignWizardController.filterCriteria(); 
          ApexPages.currentPage().getParameters().put('id',newCampaign.id);
          ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
      CampaignWizardController  CampaignWiz = new CampaignWizardController(sc);
      Test.startTest();
    string response='<submitMessageResponseObject><responseCode>0</responseCode><transactionId>1568502965</transactionId><attributes><entry><key>NEW_PERSON_IND</key><value>1</value></entry></attributes><jobId>0</jobId><objects><entry><key>person</key><value xsi:type="ns3:person" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns3="com.kbmg.remix.api"><address1>239 GRANT ST</address1><attributes/><city>PARK FOREST</city><country>USA</country><dob>11/03/1971</dob><emailAddress>B_2_WILLIAMS@MYEMAILPROVIDER.COM</emailAddress><firstName>BILLY</firstName><id>WDM1223</id><lastName>WILLIAMS</lastName><middleName>D</middleName><objects/><state>IL</state><suffix>III</suffix><telephone>281.777.9311</telephone></value></entry></objects></submitMessageResponseObject>';
    Test.setMock(HttpCalloutMock.class, new MockHttpResponse(response));
        CampaignWiz.refreshNetCount();
        CampaignWiz.isTargetedCampaign =False;
        CampaignWiz.activatecampaign();
        //CampaignWiz.createControlGroup();
 CampaignWiz.SaveCampaign();
      Test.stopTest();
}

public static testmethod void CampaignWizardApprovedacmp7(){
 Campaign newCampaign = new Campaign();
            newCampaign.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
            //newCampaign.Service_Line__c='Physical Therapy/Rehabilitation';
            newCampaign.CRM_SubServiceLineText__c='Dermatology';
            newCampaign.Approved__c=True;
            newCampaign.Vendor_Name__c='Amplified Digital (AD)';
            string campname_value1 ='val';
            newCampaign.Audience_Hospital__c ='';
            newCampaign.Audience_Region__c='';
            newCampaign.Audience__c='South Carolina';
            newCampaign.Service_Line__c='Physical Therapy/Rehabilitation';
            newCampaign.Channel__c='External Mobile Messaging';
            newCampaign.Status ='In Development';
            newCampaign.Control_Group_Percentage__c =100;
            newCampaign.Current_count__c=21;
            newCampaign.LIST_ORDER_SELECT_GRP_ID__c=354;
            newCampaign.List_Order_Id__c=7333;
            newCampaign.Approved_By__c ='vaishali';
            newCampaign.CRM_OwnershipType__c = 'Hospital';
            newCampaign.Place_Order_Date_Time__c =system.today();
              insert newCampaign;
      String camp_name = '20171004-104-South Carolina-Physical Therapy/Rehabilitation-External Mobile Messaging-V1';
      campaignSequencer__c campsequencer = new campaignSequencer__c();
      campsequencer.Counter_Value__c=999;
      campsequencer.Name='count';
        insert campsequencer;
        
      contact con = marketingDataUtils.createcontact();
      CampaignMember campaignmem = marketingDataUtils.createcampmember(newCampaign.id, con.id);
      Location__c loctn = marketingDataUtils.createlocation();
      Campaign_Location__c  camploc = marketingDataUtils.createLocationInformation(newCampaign.id,loctn.id);
       Lead  ld = marketingDataUtils.createleads();
      Transaction__c  tr = marketingDataUtils.createTransaction(newCampaign.id,ld.id);
      pagereference testpage = new pagereference ('/apex/CampaignWizard');
     Test.setcurrentPage(testPage);     
     CampaignWizardController.filterCriteria wrap1 = new CampaignWizardController.filterCriteria(); 
          ApexPages.currentPage().getParameters().put('id',newCampaign.id);
          ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
      CampaignWizardController  CampaignWiz = new CampaignWizardController(sc);
      Test.startTest();
        CampaignWiz.activatecampaign();
        //CampaignWiz.vendorname();
        CampaignWiz.campname_value1 ='val';
        CampaignWiz.nameFlag = false;
         CampaignWiz.SaveCampaign();
      // CampaignWiz.CampNamingConvention();
      Test.stopTest();
    }
    
public static testmethod void CampaignWizardApprovedacmp71(){
 Campaign newCampaign = new Campaign();
            newCampaign.Name='20170923-104-Baylor/Tenet JV-Burn-Email-V1';
            newCampaign.CRM_SubServiceLineText__c='Dermatology';
            newCampaign.Approved__c=True;
            newCampaign.Vendor_Name__c='Amplified Digital (AD)';
            string campname_value1 ='val';
            newCampaign.Audience_Hospital__c ='';
            newCampaign.Audience_Region__c='';
            newCampaign.Audience__c='Baylor/Tenet JV Region';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Channel__c='Email';
            newCampaign.Status ='In Development';
            newCampaign.Control_Group_Percentage__c =100;
            newCampaign.Current_count__c=21;
            newCampaign.LIST_ORDER_SELECT_GRP_ID__c=354;
            newCampaign.List_Order_Id__c=7333;
            newCampaign.Approved_By__c ='vaishali';
            newCampaign.CRM_OwnershipType__c = 'Hospital';
            newCampaign.Place_Order_Date_Time__c =system.today();
            newCampaign.Member_types__c='Campaign Segments';
            insert newCampaign;
     // String camp_name = '20171004-104-South Carolina-Physical Therapy/Rehabilitation-External Mobile Messaging-V1';
      campaignSequencer__c campsequencer = new campaignSequencer__c();
      campsequencer.Counter_Value__c=999;
      campsequencer.Name='count';
        insert campsequencer;
       
      contact con = marketingDataUtils.createcontact();
      CampaignMember campaignmem = marketingDataUtils.createcampmember(newCampaign.id, con.id);
      Location__c loctn = marketingDataUtils.createlocation();
      Campaign_Location__c  camploc = marketingDataUtils.createLocationInformation(newCampaign.id,loctn.id);
     CRM_CampaignLocationReferenceData__c locreference = marketingDataUtils.createRegionMarket();
       Lead  ld = marketingDataUtils.createleads();
      Transaction__c  tr = marketingDataUtils.createTransaction(newCampaign.id,ld.id);
      pagereference testpage = new pagereference ('/apex/CampaignWizard');
     Test.setcurrentPage(testPage);     
     CampaignWizardController.filterCriteria wrap1 = new CampaignWizardController.filterCriteria(); 
          ApexPages.currentPage().getParameters().put('id',newCampaign.id);
          ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
      CampaignWizardController  CampaignWiz = new CampaignWizardController(sc);
      Test.startTest();
        CampaignWiz.AddHomeAddress();
        CampaignWiz.activatecampaign();
        //CampaignWiz.vendorname();
        CampaignWiz.campname_value1 ='val';
        CampaignWiz.nameFlag = true;
        CampaignWiz.camp_name = '20171004-104-South Carolina-Physical Therapy/Rehabilitation-External Mobile Messaging-V1';
        CampaignWiz.CampNamingConvention();
         CampaignWiz.SaveCampaign();
      Test.stopTest();
    }    
 
 public static testmethod void CampaignWizardApprovedacmp72(){
 	Id Recordtypereglocation = Schema.SObjectType.CRM_CampaignLocationReferenceData__c.getRecordTypeInfosByName().get('Region').getRecordTypeId(); 
	CRM_CampaignLocationReferenceData__c locationrefregiondata = new CRM_CampaignLocationReferenceData__c();
    locationrefregiondata.CRM_Region__c='Baylor/Tenet JV Region';
    locationrefregiondata.CRM_RegionCode__c='CR3';
    locationrefregiondata.RecordTypeId=Recordtypereglocation;
    locationrefregiondata.CRM_IsActive__c=True;
  	insert locationrefregiondata;
	
	Id Recordtypelocation = Schema.SObjectType.CRM_CampaignLocationReferenceData__c.getRecordTypeInfosByName().get('Market').getRecordTypeId(); 
	CRM_CampaignLocationReferenceData__c refdata = new CRM_CampaignLocationReferenceData__c();
    refdata.CRM_Market__c='Baylor/Tenet JV Region';
    refdata.CRM_MarketCode__c='CR31';
    refdata.CRM_MarketsRegionID__c=locationrefregiondata.id;
    refdata.RecordTypeId=Recordtypelocation;
    refdata.CRM_IsActive__c=True;
  	insert refdata; 
    
    List<RecordType> lstRecTypeCRD = [select developerName,id from RecordType where sObjectType='CRM_CampaignWizardReferenceData__c' AND developerName = 'Service_Line'];
     CRM_CampaignWizardReferenceData__c crd = new CRM_CampaignWizardReferenceData__c ();
     if(lstRecTypeCRD.size()>0) {             
         crd.CRM_IsActive__c = true;
         crd.Recordtypeid = lstRecTypeCRD[0].id;
         crd.CRM_ServiceLine__c= 'Branding';
         insert crd;
    }
    List<RecordType> lstRecTypeCRD3 = [select developerName,id from RecordType where sObjectType='CRM_CampaignWizardReferenceData__c' AND developerName = 'ChannelValues'];
    CRM_CampaignWizardReferenceData__c crd3 = new CRM_CampaignWizardReferenceData__c ();
     if(lstRecTypeCRD3.size()>0) {             
         crd3.CRM_IsActive__c = true;
         crd3.Recordtypeid = lstRecTypeCRD3[0].id;
         crd3.CRM_DemoEmail__c = 'Has an email address';
         crd3.CRM_DemoMailingAddress__c= 'Everyone';
         crd3.CRM_Channel__c = 'Email';
         insert crd3;
    }
        
 	Campaign newCampaign = new Campaign();
            newCampaign.Name='20171004-104-MM-Burn-External Mobile  Messaging-V1';
            newCampaign.Service_Line__c='Burn';
            newCampaign.CRM_SubServiceLineText__c='Dermatology';
            newCampaign.Approved__c=True;
            newCampaign.Vendor_Name__c='Amplified Digital (AD)';
            string campname_value1 ='val';
            newCampaign.Audience_Hospital__c ='';
            newCampaign.Audience_Region__c='';
            newCampaign.Audience__c='Baylor/Tenet JV Region; South Carolina';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Channel__c='External Mobile Messaging';
            newCampaign.Version__c=null;
            newCampaign.Status ='In Development';
            newCampaign.Control_Group_Percentage__c =100;
            newCampaign.Current_count__c=21;
            newCampaign.LIST_ORDER_SELECT_GRP_ID__c=354;
            newCampaign.List_Order_Id__c=7333;
            newCampaign.Approved_By__c ='vaishali';
            newCampaign.Place_Order_Date_Time__c =system.today();
            newCampaign.CRM_OwnershipType__c = 'Market';
            insert newCampaign;
      
      campaignSequencer__c campsequencer = new campaignSequencer__c();
      campsequencer.Counter_Value__c=107;
      campsequencer.Name='count';
        insert campsequencer;
        
      contact con = marketingDataUtils.createcontact();
      CampaignMember campaignmem = marketingDataUtils.createcampmember(newCampaign.id, con.id);
      Location__c loctn = marketingDataUtils.createlocation();
      Campaign_Location__c  camploc = marketingDataUtils.createLocationInformation(newCampaign.id,loctn.id);
      
      
     
       Lead  ld = marketingDataUtils.createleads();
      Transaction__c  tr = marketingDataUtils.createTransaction(newCampaign.id,ld.id);
      pagereference testpage = new pagereference ('/apex/CampaignWizard');
     Test.setcurrentPage(testPage);     
    // String camp_name = '20171004-104-South Carolina-Physical Therapy/Rehabilitation-External Mobile Messaging-V1';
     CampaignWizardController.filterCriteria wrap1 = new CampaignWizardController.filterCriteria(); 
          ApexPages.currentPage().getParameters().put('id',newCampaign.id);
          ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
      CampaignWizardController  CampaignWiz = new CampaignWizardController(sc);
      Test.startTest();
         list<SelectOption> ownershipList =  CampaignWiz.ownershipList; 
      	CampaignWiz.selectedCriteria.add(string.valueof(refdata.id));
        CampaignWiz.selectedServiceLine = crd.id;
        CampaignWiz.selectedChannel = crd3.id;
        CampaignWiz.activatecampaign();
        //CampaignWiz.vendorname();
        CampaignWiz.campname_value1 ='val';
        CampaignWiz.nameFlag = false;
     	CampaignWiz.camp_name = '20171004-104-South Carolina-Physical Therapy/Rehabilitation-External Mobile Messaging-V1';
        CampaignWiz.SaveCampaign();
        CampaignWiz.CampNamingConvention();
      Test.stopTest();
    }       
    
    
 public static testmethod void CampaignWizardApprovedacmp73(){
 Campaign newCampaign = new Campaign();
            newCampaign.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
            newCampaign.Service_Line__c='Burn';
            newCampaign.CRM_SubServiceLineText__c='Dermatology';
            newCampaign.Approved__c=True;
            newCampaign.Vendor_Name__c='Amplified Digital (AD)';
            string campname_value1 ='val';
            newCampaign.Audience_Hospital__c ='';
            newCampaign.Audience_Region__c='Western';
            newCampaign.Audience__c='';
            newCampaign.Service_Line__c='';
            newCampaign.Channel__c='Magazine';
            newCampaign.Version__c=null;
            newCampaign.Status ='In Development';
            newCampaign.Control_Group_Percentage__c =100;
            newCampaign.Current_count__c=21;
            newCampaign.LIST_ORDER_SELECT_GRP_ID__c=354;
            newCampaign.List_Order_Id__c=7333;
            newCampaign.Approved_By__c ='vaishali';
            newCampaign.Place_Order_Date_Time__c =system.today();
            newCampaign.CRM_OwnershipType__c = 'Hospital';
              insert newCampaign;
      
      campaignSequencer__c campsequencer = new campaignSequencer__c();
      campsequencer.Counter_Value__c=107;
      campsequencer.Name='count';
        insert campsequencer;
       String camp_name = '20171004-104-South Carolina-Physical Therapy/Rehabilitation-External Mobile Messaging-V1';
      contact con = marketingDataUtils.createcontact();
      CampaignMember campaignmem = marketingDataUtils.createcampmember(newCampaign.id, con.id);
      Location__c loctn = marketingDataUtils.createlocation();
      Campaign_Location__c  camploc = marketingDataUtils.createLocationInformation(newCampaign.id,loctn.id);
       Lead  ld = marketingDataUtils.createleads();
      Transaction__c  tr = marketingDataUtils.createTransaction(newCampaign.id,ld.id);
      pagereference testpage = new pagereference ('/apex/CampaignWizard');
     Test.setcurrentPage(testPage);     
     CampaignWizardController.filterCriteria wrap1 = new CampaignWizardController.filterCriteria(); 
          ApexPages.currentPage().getParameters().put('id',newCampaign.id);
          ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
      CampaignWizardController  CampaignWiz = new CampaignWizardController(sc);
      Test.startTest();
        CampaignWiz.activatecampaign();
        //CampaignWiz.vendorname();
        CampaignWiz.campname_value1 ='val';
        CampaignWiz.nameFlag = true;
       // CampaignWiz.CampNamingConvention();
         CampaignWiz.SaveCampaign();
      Test.stopTest();
    } 
    
  public static testmethod void CampaignWizardmethod7(){
   boolean detailpage;
 SObject headSObject ,headClone;
 Campaign newCampaign = new Campaign();
            newCampaign.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
            newCampaign.Service_Line__c='Burn';
            newCampaign.CRM_SubServiceLineText__c='Dermatology';
            newCampaign.Tactic__c='Mail';
            newCampaign.Member_Types__c='Upload List';
            newCampaign.Audience_Hospital__c ='Phoenix-Abrazo Arrowhead Campus;ABRAZO ARIZONA HEART HOSPITAL';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';
            newcampaign.status='In development';
            newcampaign.program_name__c='xyz';
              insert newCampaign;
Campaign cmp = new Campaign();
            cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V2';
            cmp.Service_Line__c='Burn';
            cmp.CRM_SubServiceLineText__c='Dermatology';
            cmp.Tactic__c='Mail';
            cmp.Audience_Hospital__c ='Phoenix-Abrazo Arrowhead Campus';
            cmp.Audience_Region__c='Texas';      
            cmp.Channel__c='Direct Mail';
            cmp.ParentId=newCampaign.id;
              insert cmp;
   contact  contct = marketingDataUtils.CreateContact();  
   CampaignMember campaignmem = marketingDataUtils.createcampmember(newCampaign.id, contct.id);
   DRG_Code__c dr = marketingDataUtils.createDRGcode();
Campaign_Member_Criteria_Group__c  grp = new Campaign_Member_Criteria_Group__c();
        grp.Campaign__c=newCampaign.id;
        grp.Exclude__c = True;
        grp.Group_Name__c='test';
        grp.WM_CriteriaGroup_Id__c='12';
        grp.WM_Parent_group_Id__c='677';
        grp.Inner_Operator__c = 'OR';
          insert grp;
    Campaign_Member_Criteria__c mem= new Campaign_Member_Criteria__c();
        mem.Campaign__c=newCampaign.id;
        mem.Exclude__c=true;
        mem.Category__c = 'Ailments';
        mem.Criteria_Group__c = grp.id;
        mem.Field_Name__c='ZipCode__c';
           insert mem;     
   Campaign_Member_Criteria__c campaignmember = marketingDataUtils.createCampaignMemberCriteria(newCampaign.id);
   Location__c loctn = marketingDataUtils.createlocation();
   Campaign_Location__c  camploc = marketingDataUtils.createLocationInformation(newCampaign.id,loctn.id);
   Geographic__c  geo = marketingDataUtils.createGeographic();
   Geographic_Info_Information__c geoinfo = new Geographic_Info_Information__c();
           geoinfo.Campaign__c=newCampaign.id;
           geoinfo.Geographic_Info__c=geo.id;
           geoinfo.Audience_Search_Type__c ='Geography By Boundary';
              insert geoinfo;  
   campaignSequencer__c campsequencer = new campaignSequencer__c();
      campsequencer.Counter_Value__c=999;
      campsequencer.Name='count';
        insert campsequencer;
   Campaign_Related_List__c RelatedList = new Campaign_Related_List__c();
     RelatedList.Name='Campaign_Demographics__c';
      insert RelatedList;          
              
   Life_Style__c lifestyle = marketingDataUtils.createLifeStyle(newCampaign.id);
   Campaign_Demographics__c   cmpdemo = marketingDataUtils.createDemographics(newCampaign.id);
   Model__c   model = marketingDataUtils.createCampaignModel(newCampaign.id); 
   Encounter__c    enc = marketingDataUtils.createEncounter(newCampaign.id);
   Encounter_aggregates__c aggre = marketingDataUtils.createaggregates(newCampaign.id);
   //contact  con =marketingDataUtils.createcontact();
    id CloneCampid = mem.id;
    string oldvalue ='jjhdu';
    string newvalue ='vwg';
    string SelectedcdId = newCampaign.id;
   pagereference testpage = new pagereference ('/apex/CampaignWizard');
   Test.setcurrentPage(testPage);     
// CampaignWizardController.WrapperClassForDRGCheckBox wrap = new CampaignWizardController.WrapperClassForDRGCheckBox(dr);
CampaignWizardController.filterCriteria wrap1 = new CampaignWizardController.filterCriteria();
        wrap1.fieldApi = 'AND';
        wrap1.operator= 'AND';
        wrap1.value= 'AND';
CampaignWizardController.wrapRecord  wrap2 = new CampaignWizardController.wrapRecord(contct); 

  ApexPages.currentPage().getParameters().put('id',newCampaign.id);
  String id = ApexPages.currentPage().getParameters().get('id');
 system.debug('ConId---'+id);
 
 
 
  ApexPages.currentPage().getParameters().put('templateflag', 'true');
  String tempflag = ApexPages.currentPage().getParameters().get('templateflag');
 if(tempflag=='true'){
 detailPage=false;
 
            newcampaign.status='In development';
            newcampaign.program_name__c='xyz';
 }
  ApexPages.currentPage().getParameters().put('stepNo','1');
  ApexPages.currentPage().getParameters().put('btn','1');
  ApexPages.currentPage().getParameters().put('campflag','true');
  ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
  CampaignWizardController.insertMemberTypeCriteria(newCampaign.id,oldvalue,newvalue);
          CampaignWizardController  CampaignWiz = new CampaignWizardController(sc);
          CampaignWiz.TemplateFlag='True';
          CampaignWiz.DetailPage=False;
          CampaignWiz.stepNumFromPage=1;
          CampaignWiz.showTab();
          CampaignWiz.nextStep();  
          CampaignWiz.DetailPage=TRUE;
          CampaignWiz.previousStep();
       
         
          CampaignWiz.init();
          CampaignWiz.initFilter();
          CampaignWiz.closePopup();
         // CampaignWiz.AddCampaignMembers();
          CampaignWiz.Childflag = False;
          CampaignWiz.TemplateFlag = 'false';
     
          CampaignWiz.campId =newCampaign.id;
          CampaignWiz.CloneCampaign();
     
          CampaignWiz.getFields();
          CampaignWiz.getOperator();
         
          CampaignWiz.ViewChildCampaign();
          CampaignWiz.TemplateFlag='';
          CampaignWiz.DetailPage=False;
          CampaignWiz.Childflag = false;
          CampaignWiz.SaveCampaign();
          CampaignWiz.deleteAllGeoServiceArea();
          CampaignWiz.EditCampaign();
          CampaignWiz.SubServiceLine();
          CampaignWiz.tactic();
          CampaignWiz.TacticMember();
          CampaignWiz.BacktoCampaign();
          CampaignWiz.AddLoc();   
          CampaignWiz.CancelEditCampaign();
          CampaignWiz.method1();
          CampaignWiz.SelectedchildId = SelectedcdId;
          CampaignWiz.DeleteChild();
          CampaignWiz.encounter();
          CampaignWiz.encounter_aggregates();
          CampaignWiz.LifeStyle();
          CampaignWiz.demo();
          CampaignWiz.enc_back();
          CampaignWiz.model();
          CampaignWiz.values();
          CampaignWiz.refreshCount();
          CampaignWiz.membervalues();
          CampaignWiz.activatecampaign();
          CampaignWiz.getownername();
          //CampaignWiz.createControlGroup ();
          //CampaignWiz.vendorname();
          CampaignWiz.deactivegeographybuttons();
          CampaignWiz.preparehospitalpicklist();
          CampaignWiz.DelCampaign();
          CampaignWiz.UnlockAudienceSelection();
        
          CampaignWiz.getWundermanidRefresh();
          CampaignWiz.AddIcd();
          CampaignWiz.deleteAllGeoBoundaryDistance();
       
  }  
  
public static testmethod void CampaignWizardApprovedacmp77(){
 Campaign newCampaign = new Campaign();
            newCampaign.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
            newCampaign.Service_Line__c='Burn';
            newCampaign.CRM_SubServiceLineText__c='Dermatology';
            newCampaign.Approved__c=True;
            newCampaign.Vendor_Name__c='Amplified Digital (AD)';
            string campname_value1 ='val';
            newCampaign.Audience_Hospital__c ='';
            newCampaign.Audience_Region__c='Western';
            newCampaign.Audience__c='';
            newCampaign.Service_Line__c='';
            newCampaign.Channel__c='Magazine';
            newCampaign.Version__c=null;
            newCampaign.Status ='In Development';
            newCampaign.Control_Group_Percentage__c =100;
            newCampaign.Current_count__c=21;
            newCampaign.LIST_ORDER_SELECT_GRP_ID__c=354;
            newCampaign.List_Order_Id__c=7333;
            newCampaign.Approved_By__c ='';
            newCampaign.Place_Order_Date_Time__c =system.today();
            newCampaign.CRM_OwnershipType__c = 'Hospital';
              insert newCampaign;
      
      campaignSequencer__c campsequencer = new campaignSequencer__c();
      campsequencer.Counter_Value__c=107;
      campsequencer.Name='count';
        insert campsequencer;
        
      contact con = marketingDataUtils.createcontact();
      CampaignMember campaignmem = marketingDataUtils.createcampmember(newCampaign.id, con.id);
      Location__c loctn = marketingDataUtils.createlocation();
      Campaign_Location__c  camploc = marketingDataUtils.createLocationInformation(newCampaign.id,loctn.id);
       Lead  ld = marketingDataUtils.createleads();
      Transaction__c  tr = marketingDataUtils.createTransaction(newCampaign.id,ld.id);
      pagereference testpage = new pagereference ('/apex/CampaignWizard');
     Test.setcurrentPage(testPage);  
    String camp_name = '20171004-104-South Carolina-Physical Therapy/Rehabilitation-External Mobile Messaging-V1';
     CampaignWizardController.filterCriteria wrap1 = new CampaignWizardController.filterCriteria(); 
          ApexPages.currentPage().getParameters().put('id',newCampaign.id);
          ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
      CampaignWizardController  CampaignWiz = new CampaignWizardController(sc);
      Test.startTest();
        CampaignWiz.activatecampaign();
        //CampaignWiz.vendorname();
        CampaignWiz.campname_value1 ='val';
      CampaignWiz.nameFlag = true;
      //  CampaignWiz.CampNamingConvention();
         CampaignWiz.SaveCampaign();
      Test.stopTest();
    } 
    
  public static testmethod void CampaignWizardmethod77(){
   boolean detailpage;
   integer PageNumber;
   string camp_clone_Id;
   boolean disflag1;
   boolean relatedlistflag;
   boolean relatedlistflag1;
   boolean relatedlistflag2;
   boolean relatedlistflag3;
   string flagstatus;
 SObject headSObject ,headClone;
 Campaign newCampaign = new Campaign();
            newCampaign.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
            newCampaign.Service_Line__c='Burn';
            newCampaign.CRM_SubServiceLineText__c='Dermatology';
            newCampaign.Tactic__c='';
            newCampaign.Member_Types__c='One or more encounters - Patients';
            newCampaign.Audience_Hospital__c ='Phoenix-Abrazo Arrowhead Campus;ABRAZO ARIZONA HEART HOSPITAL';
            newCampaign.Audience_Region__c='Texas';
            boolean nameFlag = true;
           
            newCampaign.Channel__c='';
            newCampaign.StartDate=Date.newInstance(2015,01,10);
            newCampaign.EndDate=Date.newInstance(2018,01,20);
            newcampaign.status='Completed';
            newcampaign.program_name__c='xyz';
              insert newCampaign;
Campaign cmp = new Campaign();
            cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V2';
            cmp.Service_Line__c='Burn';
            cmp.CRM_SubServiceLineText__c='Dermatology';
            cmp.Tactic__c='';
            cmp.Audience_Hospital__c ='Phoenix-Abrazo Arrowhead Campus';
            cmp.Audience_Region__c='Texas';      
            cmp.Channel__c='';
            cmp.ParentId=newCampaign.id;
              insert cmp;
   contact  contct = marketingDataUtils.CreateContact();  
   CampaignMember campaignmem = marketingDataUtils.createcampmember(newCampaign.id, contct.id);
   DRG_Code__c dr = marketingDataUtils.createDRGcode();
Campaign_Member_Criteria_Group__c  grp = new Campaign_Member_Criteria_Group__c();
        grp.Campaign__c=newCampaign.id;
        grp.Exclude__c = True;
        grp.Group_Name__c='test';
        grp.WM_CriteriaGroup_Id__c='12';
        grp.WM_Parent_group_Id__c='677';
        grp.Inner_Operator__c = 'OR';
          insert grp;
    Campaign_Member_Criteria__c mem= new Campaign_Member_Criteria__c();
        mem.Campaign__c=newCampaign.id;
        mem.Exclude__c=false;
        mem.Category__c = 'Ailments';
        mem.Criteria_Group__c = grp.id;
        mem.Field_Name__c='ZipCode__c';
           insert mem;     
   Campaign_Member_Criteria__c campaignmember = marketingDataUtils.createCampaignMemberCriteria(newCampaign.id);
   Location__c loctn = marketingDataUtils.createlocation();
   Campaign_Location__c  camploc = marketingDataUtils.createLocationInformation(newCampaign.id,loctn.id);
   Geographic__c  geo = marketingDataUtils.createGeographic();
   Geographic_Info_Information__c geoinfo = new Geographic_Info_Information__c();
           geoinfo.Campaign__c=newCampaign.id;
           geoinfo.Geographic_Info__c=geo.id;
           geoinfo.Audience_Search_Type__c ='Geography By Boundary';
              insert geoinfo;  
   campaignSequencer__c campsequencer = new campaignSequencer__c();
      campsequencer.Counter_Value__c=999;
      campsequencer.Name='count';
        insert campsequencer;
   Campaign_Related_List__c RelatedList = new Campaign_Related_List__c();
     RelatedList.Name='Campaign_Demographics__c';
      insert RelatedList;          
              
   Life_Style__c lifestyle = marketingDataUtils.createLifeStyle(newCampaign.id);
   Campaign_Demographics__c   cmpdemo = marketingDataUtils.createDemographics(newCampaign.id);
   Model__c   model = marketingDataUtils.createCampaignModel(newCampaign.id); 
   Encounter__c    enc = marketingDataUtils.createEncounter(newCampaign.id);
   Encounter_aggregates__c aggre = marketingDataUtils.createaggregates(newCampaign.id);
   //contact  con =marketingDataUtils.createcontact();
    id CloneCampid = mem.id;
    string oldvalue ='jjhdu';
    string newvalue ='vwg';
    string SelectedcdId = newCampaign.id;
   pagereference testpage = new pagereference ('/apex/CampaignWizard');
   Test.setcurrentPage(testPage);     
// CampaignWizardController.WrapperClassForDRGCheckBox wrap = new CampaignWizardController.WrapperClassForDRGCheckBox(dr);
CampaignWizardController.filterCriteria wrap1 = new CampaignWizardController.filterCriteria();
        wrap1.fieldApi = 'AND';
        wrap1.operator= 'AND';
        wrap1.value= 'AND';
CampaignWizardController.wrapRecord  wrap2 = new CampaignWizardController.wrapRecord(contct); 

  ApexPages.currentPage().getParameters().put('id',newCampaign.id);
  String id = ApexPages.currentPage().getParameters().get('id');
 system.debug('ConId---'+id);
 
 
 
  ApexPages.currentPage().getParameters().put('templateflag', 'true');
  String tempflag = ApexPages.currentPage().getParameters().get('templateflag');
 if(tempflag=='true'){
 detailPage=false;
 
            newcampaign.status='In development';
            newcampaign.program_name__c='xyz';
 }
  ApexPages.currentPage().getParameters().put('stepNo','2');
  ApexPages.currentPage().getParameters().put('btn','1');
  ApexPages.currentPage().getParameters().put('campflag','true');
  ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
  CampaignWizardController.insertMemberTypeCriteria(newCampaign.id,oldvalue,newvalue);
          CampaignWizardController  CampaignWiz = new CampaignWizardController(sc);
          CampaignWiz.TemplateFlag='True';
          CampaignWiz.DetailPage=False;
          CampaignWiz.stepNumFromPage=1;
          CampaignWiz.showTab();
          CampaignWiz.nextStep();  
          CampaignWiz.DetailPage=TRUE;
          CampaignWiz.previousStep();
          CampaignWiz.PageNumber=2;
          CampaignWiz.camp_clone_Id= 'cmpid';
          CampaignWiz.disflag1=true;
          CampaignWiz.relatedlistflag=true;
          CampaignWiz.relatedlistflag1=false;
          CampaignWiz.relatedlistflag2=true;
          CampaignWiz.flagstatus='true';
         
          CampaignWiz.init();
          CampaignWiz.initFilter();
          CampaignWiz.closePopup();
         // CampaignWiz.AddCampaignMembers();
          CampaignWiz.Childflag = False;
          CampaignWiz.TemplateFlag = 'false';
          CampaignWiz.campname_value1 ='val';
          CampaignWiz.nameFlag = true;
          CampaignWiz.campId =newCampaign.id;
          CampaignWiz.CloneCampaign();
          CampaignWiz.SaveCampaign();
          CampaignWiz.getFields();
          CampaignWiz.getOperator();
         
          CampaignWiz.ViewChildCampaign();
          CampaignWiz.TemplateFlag='';
          CampaignWiz.DetailPage=False;
          CampaignWiz.Childflag = false;
          CampaignWiz.SaveCampaign();
          CampaignWiz.deleteAllGeoServiceArea();
          CampaignWiz.EditCampaign();
          CampaignWiz.SubServiceLine();
          CampaignWiz.tactic();
          CampaignWiz.TacticMember();
          CampaignWiz.BacktoCampaign();
          CampaignWiz.AddLoc();   
          CampaignWiz.CancelEditCampaign();
          CampaignWiz.method1();
          CampaignWiz.SelectedchildId = SelectedcdId;
          CampaignWiz.DeleteChild();
          CampaignWiz.encounter();
          CampaignWiz.encounter_aggregates();
          CampaignWiz.LifeStyle();
          CampaignWiz.demo();
          CampaignWiz.enc_back();
          CampaignWiz.model();
          CampaignWiz.values();
          CampaignWiz.refreshCount();
          CampaignWiz.membervalues();
          CampaignWiz.activatecampaign();
          CampaignWiz.getownername();
          //CampaignWiz.createControlGroup ();
          //CampaignWiz.vendorname();
          CampaignWiz.deactivegeographybuttons();
          CampaignWiz.preparehospitalpicklist();
          CampaignWiz.DelCampaign();
          CampaignWiz.UnlockAudienceSelection();
          CampaignWiz.parentcampname='childCamp';
          CampaignWiz.getWundermanidRefresh();
          CampaignWiz.AddIcd();
          CampaignWiz.deleteAllGeoBoundaryDistance();
          
  }  
    
  public static testmethod void newDesignTestMethod(){
Campaign newCampaign = new Campaign();
     newCampaign.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
     newCampaign.Service_Line__c='Burn';
     newCampaign.CRM_SubServiceLineText__c='Dermatology';
     newCampaign.Tactic__c='Mail';
     newCampaign.Vendor_Name__c='BG Solutions BS';
     newCampaign.CRM_SelectedOwnershipCriteria__c='AHH;AHD';
     newCampaign.CRM_OwnershipType__c='Hospital';
     newCampaign.Status ='In Development';
     newCampaign.Version__c=Null;
     newCampaign.Call_to_Action__c='HRA';
     newCampaign.Member_Types__c='One or more encounters - Patients';
     newCampaign.Audience_Hospital__c ='Abrazo Arrowhead Campus;ABRAZO ARIZONA HEART HOSPITAL';
     newCampaign.Audience_Region__c='Texas';
     newCampaign.Control_Group_Size__c=Null;
     newCampaign.Channel__c='Direct Mail';
     newcampaign.status='In development';
     newcampaign.program_name__c='xyz';
   insert newCampaign;
CRM_CampaignWizardReferenceData__c wizrefdata = new CRM_CampaignWizardReferenceData__c();
     wizrefdata.CRM_ServiceLine__c='Burn';
     wizrefdata.CRM_CallToAction__c='HRA';
     wizrefdata.CRM_Channel__c='Direct Mail';
     wizrefdata.CRM_SubServiceLine__c='Dermatology';
     wizrefdata.CRM_VendorName__c='BG Solutions BS';
     wizrefdata.CRM_IsActive__c=True;
   insert wizrefdata;
CRM_CampaignLocationReferenceData__c locationrefdata = new CRM_CampaignLocationReferenceData__c();
     locationrefdata.CRM_Hospital__c='ABRAZO ARIZONA HEART HOSPITAL';
     locationrefdata.CRM_Region__c='Detroit Market';
     locationrefdata.CRM_ServiceArea__c='Primary Service Area';
     locationrefdata.CRM_Market__c ='Detroit Market';
     locationrefdata.CRM_IsActive__c=True;
  insert locationrefdata;
CRM_CampaignGeographyReferenceData__c georefData = new CRM_CampaignGeographyReferenceData__c();
     //georefData.CRM_CBSA__c='Abilene, TX';
     //georefData.CRM_County__c='ANASCO';
     georefData.CRM_State__c='New York';
     georefData.CRM_State__c='NY';
     georefData.RecordTypeId=ReferenceData_PicklistController.recordTypeId('CRM_CampaignGeographyReferenceData__c' , 'State') ;
     georefData.CRM_IsActive__c=True;
   insert georefData;
CRM_CampaignGeographyReferenceData__c geographyrefData = new CRM_CampaignGeographyReferenceData__c();
     //geographyrefData.CRM_CBSA__c='Aberdeen, SD';
     geographyrefData.CRM_County__c='SUFFOLK';
     geographyrefData.RecordTypeId=ReferenceData_PicklistController.recordTypeId('CRM_CampaignGeographyReferenceData__c' , 'County') ;
     geographyrefData.CRM_CountysStateID__c=georefData.id;
     geographyrefData.CRM_IsActive__c=True;
   insert geographyrefData;
CRM_CampaignOwnershipDetail__c cmpownershipdetail = new CRM_CampaignOwnershipDetail__c();
     cmpownershipdetail.Campaign__c=newCampaign.id;
     cmpownershipdetail.Campaign_Location_Reference_Data_Mapping__c=locationrefdata.id;
  insert cmpownershipdetail;
CampaignSequencer__c sequence = new CampaignSequencer__c();
     sequence.Name='Count';
     sequence.Counter_Value__c=100;
   insert sequence;
     pagereference testpage = new pagereference ('/apex/CampaignWizard');
     Test.setcurrentPage(testPage); 
   ApexPages.currentPage().getParameters().put('id',newCampaign.id);
   ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
   CampaignWizardController  CampaignWiz = new CampaignWizardController(sc);
        CampaignWiz.CloneCampaign();
    }
    Public static testmethod void ownershiptestmethod(){      
Campaign newCampaign = new Campaign();
     newCampaign.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
     newCampaign.Service_Line__c='Burn';
     newCampaign.CRM_SubServiceLineText__c='Burn';
     newCampaign.Vendor_Name__c='BG Solutions (BS)';
     newCampaign.CRM_SelectedOwnershipCriteria__c='AHH;AHD';
     newCampaign.CRM_OwnershipType__c='Hospital';
     newCampaign.Status ='In Development';
     newCampaign.Call_to_Action__c='HRA';
     newCampaign.Member_Types__c='One or more encounters - Patients';
     newCampaign.Channel__c='Direct Mail';
     newcampaign.status='In development';
   insert newCampaign;
Id Recordtypereglocation = Schema.SObjectType.CRM_CampaignLocationReferenceData__c.getRecordTypeInfosByName().get('Region').getRecordTypeId(); 
CRM_CampaignLocationReferenceData__c locationrefregiondata = new CRM_CampaignLocationReferenceData__c();
     locationrefregiondata.CRM_Region__c='Baylor/Tenet JV Region';
     locationrefregiondata.CRM_RegionCode__c='CR3';
     locationrefregiondata.RecordTypeId=Recordtypereglocation;
     locationrefregiondata.CRM_IsActive__c=True;
  insert locationrefregiondata;
Id Recordtypelocation = Schema.SObjectType.CRM_CampaignLocationReferenceData__c.getRecordTypeInfosByName().get('Market').getRecordTypeId(); 
CRM_CampaignLocationReferenceData__c refdata = new CRM_CampaignLocationReferenceData__c();
     refdata.CRM_Market__c='Baylor/Tenet JV Region';
     refdata.CRM_MarketCode__c='CR3';
     refdata.CRM_MarketsRegionID__c=locationrefregiondata.id;
     refdata.RecordTypeId=Recordtypelocation;
     refdata.CRM_IsActive__c=True;
  insert refdata; 
Id Recordtypehospital = Schema.SObjectType.CRM_CampaignLocationReferenceData__c.getRecordTypeInfosByName().get('Hospital').getRecordTypeId(); 
CRM_CampaignLocationReferenceData__c Hospitalrefdata = new CRM_CampaignLocationReferenceData__c();
     Hospitalrefdata.CRM_Hospital__c='Baylor Scott & White Medical Center White Rock';
     Hospitalrefdata.CRM_HospitalCode__c='DHF';
     Hospitalrefdata.CRM_HospitalLocation__Latitude__s=32.835496;
     Hospitalrefdata.CRM_HospitalLocation__Longitude__s=-96.705023;
     Hospitalrefdata.CRM_HospitalsMarketID__c=refdata.id;
     Hospitalrefdata.RecordTypeId=Recordtypehospital;
     Hospitalrefdata.CRM_IsActive__c=True;
  insert Hospitalrefdata;
CRM_CampaignOwnershipDetail__c cmpownershipdetail = new CRM_CampaignOwnershipDetail__c();
     cmpownershipdetail.Campaign__c=newCampaign.id;
     cmpownershipdetail.Campaign_Location_Reference_Data_Mapping__c=Hospitalrefdata.id;
   insert cmpownershipdetail;
  pagereference testpage = new pagereference ('/apex/CampaignWizard');
     Test.setcurrentPage(testPage); 
   ApexPages.currentPage().getParameters().put('id',newCampaign.id);
   ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
   CampaignWizardController  CampaignWiz = new CampaignWizardController(sc);
        CampaignWiz.insertOwnershipJO(newCampaign.id);   
        CampaignWiz.saveownershipvalues();    
    }
    Public static testmethod void SaveCampaignTestMethod(){
Campaign newCampaign = new Campaign();
     newCampaign.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
     newCampaign.Service_Line__c='Burn';
     newCampaign.CRM_SelectedOwnershipCriteria__c='AHH;AHD';
     newCampaign.CRM_OwnershipType__c='Hospital';
     newCampaign.Status ='In Development';
     //newCampaign.Call_to_Action__c='HRA';
     newCampaign.Member_Types__c='One or more encounters - Patients';
    // newCampaign.Channel__c='Direct Mail';
     newcampaign.status='In development';
     newcampaign.CRM_SubServiceLineText__c = 'Burn';
   insert newCampaign;
CRM_CampaignWizardReferenceData__c refwizard = new CRM_CampaignWizardReferenceData__c();
     refwizard.CRM_Channel__c='Direct Mail';
     refwizard.CRM_ServiceLine__c='Burn';
     refwizard.CRM_SubServiceLine__c='Burn';     
     refwizard.CRM_VendorName__c='BG Solutions (BS)';
     refwizard.CRM_CallToAction__c='HRA';
   insert refwizard;
     pagereference testpage = new pagereference ('/apex/CampaignWizard');
     Test.setcurrentPage(testPage); 
     ApexPages.currentPage().getParameters().put('id',newCampaign.id);
     ApexPages.currentPage().getParameters().put('flag','true');
     ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
         List<RecordType> lstRecTypeCRD = [select developerName,id from RecordType where sObjectType='CRM_CampaignWizardReferenceData__c' AND developerName = 'Service_Line'];
         CRM_CampaignWizardReferenceData__c crd = new CRM_CampaignWizardReferenceData__c ();
         if(lstRecTypeCRD.size()>0) {             
             crd.CRM_IsActive__c = true;
             crd.Recordtypeid = lstRecTypeCRD[0].id;
             crd.CRM_ServiceLine__c= 'Branding';
             insert crd;
        }
        
        
        CRM_CampaignRefJunction__c ccr = new CRM_CampaignRefJunction__c();
        ccr.CRM_CampaignMapping__c = newCampaign.id;
        ccr.CRM_CampaignWizardReferenceData__c = crd.id;
        insert ccr;
        List<RecordType> lstRecTypeCRD2 = [select developerName,id from RecordType where sObjectType='CRM_CampaignWizardReferenceData__c' AND developerName = 'Sub_Service_Line'];
        CRM_CampaignWizardReferenceData__c crd2 = new CRM_CampaignWizardReferenceData__c ();
         if(lstRecTypeCRD2.size()>0) {             
             crd2.CRM_IsActive__c = true;
             crd2.Recordtypeid = lstRecTypeCRD2[0].id;
             crd2.CRM_ServiceLine__c= 'Musculoskeletal';
             insert crd2;
        }
        CRM_CampaignRefJunction__c ccr2 = new CRM_CampaignRefJunction__c();
        ccr2.CRM_CampaignMapping__c = newCampaign.id;
        ccr2.CRM_CampaignWizardReferenceData__c = crd2.id;
        insert ccr2;
       
       List<RecordType> lstRecTypeCRD3 = [select developerName,id from RecordType where sObjectType='CRM_CampaignWizardReferenceData__c' AND developerName = 'ChannelValues'];
        CRM_CampaignWizardReferenceData__c crd3 = new CRM_CampaignWizardReferenceData__c ();
         if(lstRecTypeCRD3.size()>0) {             
             crd3.CRM_IsActive__c = true;
             crd3.Recordtypeid = lstRecTypeCRD3[0].id;
             crd3.CRM_DemoEmail__c = 'Has an email address';
             crd3.CRM_DemoMailingAddress__c= 'Everyone';
             crd3.CRM_Channel__c = 'Email';
             insert crd3;
        }
        Data_Element_Identifier__c dei = new Data_Element_Identifier__c();
        dei.Field_Name__c = 'Suppression_Non_emailable__c';
        dei.Criteria_Group_Name__c = 'Demographics';
        insert dei;
        Data_Element_Identifier__c dei2 = new Data_Element_Identifier__c();
        dei2.Field_Name__c = 'Address_Deliverable__c';
        dei2.Criteria_Group_Name__c = 'Demographics';
        insert dei2;
        Data_Element_Identifier__c dei3 = new Data_Element_Identifier__c();
        dei3.Field_Name__c = 'Member_Types__c';
        dei3.Criteria_Group_Name__c = 'Encounters';
        insert dei3;
        Campaign_Member_Search_Critera__c  cms = new Campaign_Member_Search_Critera__c ();
        cms.Requires_SubGroup__c = false;
        cms.Name = 'Demographics';
        insert cms;
        Campaign_Member_Search_Critera__c  cms2 = new Campaign_Member_Search_Critera__c ();
        cms2.Requires_SubGroup__c = false;
        cms2.Name = 'Encounters';
        insert cms2;
        CampaignWizardController  CampaignWiz = new CampaignWizardController(sc);
        CampaignWiz.selectedChannel=refwizard.id;
        CampaignWiz.selectedServiceLine=refwizard.id;
        CampaignWiz.selectedCallToAction=refwizard.id;
        CampaignWiz.selectedServiceLine = refwizard.id;
        
        CampaignWiz.SaveCampaign();
        List<SelectOption> lstOption = new List<SelectOption> ();
        CampaignWiz.lstchannelvalues = lstOption ;
        CampaignWiz.lstVenderNamesValues= lstOption ;
        CampaignWiz.lstMemberTypeValues= lstOption ;
        CampaignWiz.lstCallTOActionValues= lstOption ;
        CampaignWiz.lstServiceLinevalues  = lstOption;
        CampaignWiz.ownershipList = lstOption;
        CampaignWiz.ownershiptype = lstOption;
        CampaignWizardController.UpsertDemoCriteras(newCampaign.id,'Direct Mail', 'Email');
        system.debug('SaveCampaign'+CampaignWiz);
         CampaignWiz.SaveCampaign();
    }
    public static testmethod void TestCriteriasLov () {
         Campaign newCampaign = new Campaign();
         newCampaign.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
         newCampaign.Service_Line__c='Burn';
       
         newCampaign.CRM_SelectedOwnershipCriteria__c='AHH;AHD';
         newCampaign.CRM_OwnershipType__c='Hospital';
         newCampaign.Status ='In Development';
         //newCampaign.Call_to_Action__c='HRA';
         newCampaign.Member_Types__c='One or more encounters - Patients';
        // newCampaign.Channel__c='Direct Mail';
         newcampaign.status='In development';
         newcampaign.CRM_SubServiceLineText__c = 'Burn';
        insert newCampaign;
        List<RecordType> lstRecTypeCRD3 = [select developerName,id from RecordType where sObjectType='CRM_CampaignWizardReferenceData__c' AND developerName = 'ChannelValues'];
        CRM_CampaignWizardReferenceData__c crd3 = new CRM_CampaignWizardReferenceData__c ();
        if(lstRecTypeCRD3.size()>0) {             
             crd3.CRM_IsActive__c = true;
             crd3.Recordtypeid = lstRecTypeCRD3[0].id;
             crd3.CRM_DemoEmail__c = 'Has an email address';
             crd3.CRM_DemoMailingAddress__c= 'Everyone';
             crd3.CRM_Channel__c = 'Email';
             insert crd3;
        }
        Campaign_Demographics__c cd = new Campaign_Demographics__c();
        cd.Suppression_Non_emailable__c ='Everyone';
        cd.Campaign__c = newCampaign.id;
        insert cd;
        Data_Element_Identifier__c dei = new Data_Element_Identifier__c();
        dei.Field_Name__c = 'Suppression_Non_emailable__c';
        dei.Criteria_Group_Name__c = 'Demographics';
        insert dei;
        Data_Element_Identifier__c dei2 = new Data_Element_Identifier__c();
        dei2.Field_Name__c = 'Address_Deliverable__c';
        dei2.Criteria_Group_Name__c = 'Demographics';
        insert dei2;
        Data_Element_Identifier__c dei3 = new Data_Element_Identifier__c();
        dei3.Field_Name__c = 'Member_Types__c';
        dei3.Criteria_Group_Name__c = 'Encounters';
        insert dei3;
        Campaign_Member_Search_Critera__c  cms = new Campaign_Member_Search_Critera__c ();
        cms.Requires_SubGroup__c = false;
        cms.Name = 'Demographics';
        insert cms;
        Campaign_Member_Search_Critera__c  cms2 = new Campaign_Member_Search_Critera__c ();
        cms2.Requires_SubGroup__c = false;
        cms2.Name = 'Encounters';
        insert cms2;
        CampaignWizardController.UpsertDemoCriteras(newCampaign.id,'Direct Mail', 'Email');
    
    }
    
    public static testmethod void TestCriteriasLov3 () {
         Campaign newCampaign = new Campaign();
         newCampaign.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
         newCampaign.Service_Line__c='Burn';
         newCampaign.CRM_SelectedOwnershipCriteria__c='AHH;AHD';
         newCampaign.CRM_OwnershipType__c='Hospital';
         newCampaign.Status ='In Development';
         //newCampaign.Call_to_Action__c='HRA';
         newCampaign.Member_Types__c='One or more encounters - Patients';
        // newCampaign.Channel__c='Direct Mail';
         newcampaign.status='In development';
         newcampaign.CRM_SubServiceLineText__c = 'Burn';
        insert newCampaign;
        List<RecordType> lstRecTypeCRD3 = [select developerName,id from RecordType where sObjectType='CRM_CampaignWizardReferenceData__c' AND developerName = 'ChannelValues'];
        CRM_CampaignWizardReferenceData__c crd3 = new CRM_CampaignWizardReferenceData__c ();
        if(lstRecTypeCRD3.size()>0) {             
             crd3.CRM_IsActive__c = true;
             crd3.Recordtypeid = lstRecTypeCRD3[0].id;
             crd3.CRM_DemoEmail__c = 'Has an email address';
             crd3.CRM_DemoMailingAddress__c= 'Has a valid or foreign mailing address';
             crd3.CRM_Channel__c = 'Email';
             insert crd3;
        }
        Campaign_Demographics__c cd = new Campaign_Demographics__c();
        cd.Suppression_Non_emailable__c ='Everyone';
        cd.Campaign__c = newCampaign.id;
        insert cd;
        Data_Element_Identifier__c dei = new Data_Element_Identifier__c();
        dei.Field_Name__c = 'Suppression_Non_emailable__c';
        dei.Criteria_Group_Name__c = 'Demographics';
        insert dei;
        Data_Element_Identifier__c dei2 = new Data_Element_Identifier__c();
        dei2.Field_Name__c = 'Address_Deliverable__c';
        dei2.Criteria_Group_Name__c = 'Demographics';
        insert dei2;
        Data_Element_Identifier__c dei3 = new Data_Element_Identifier__c();
        dei3.Field_Name__c = 'Member_Types__c';
        dei3.Criteria_Group_Name__c = 'Encounters';
        insert dei3;
        Campaign_Member_Search_Critera__c  cms = new Campaign_Member_Search_Critera__c ();
        cms.Requires_SubGroup__c = false;
        cms.Name = 'Demographics';
        insert cms;
        Campaign_Member_Search_Critera__c  cms2 = new Campaign_Member_Search_Critera__c ();
        cms2.Requires_SubGroup__c = false;
        cms2.Name = 'Encounters';
        insert cms2;
        CampaignWizardController.UpsertDemoCriteras(newCampaign.id,'Direct Mail', 'Email');
    
    }
    public static testmethod void TestCriteriasLov4 () {
         Campaign newCampaign = new Campaign();
         newCampaign.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
         newCampaign.Service_Line__c='Burn';
        newCampaign.CRM_SelectedOwnershipCriteria__c='AHH;AHD';
         newCampaign.CRM_OwnershipType__c='Hospital';
         newCampaign.Status ='In Development';
         //newCampaign.Call_to_Action__c='HRA';
         newCampaign.Member_Types__c='One or more encounters - Patients';
        // newCampaign.Channel__c='Direct Mail';
         newcampaign.status='In development';
         newcampaign.CRM_SubServiceLineText__c = 'Burn';
        insert newCampaign;
        List<RecordType> lstRecTypeCRD3 = [select developerName,id from RecordType where sObjectType='CRM_CampaignWizardReferenceData__c' AND developerName = 'ChannelValues'];
        CRM_CampaignWizardReferenceData__c crd3 = new CRM_CampaignWizardReferenceData__c ();
        if(lstRecTypeCRD3.size()>0) {             
             crd3.CRM_IsActive__c = true;
             crd3.Recordtypeid = lstRecTypeCRD3[0].id;
             crd3.CRM_DemoEmail__c = 'Everyone';
             crd3.CRM_DemoMailingAddress__c= 'Has a valid or foreign mailing address';
             crd3.CRM_Channel__c = 'Email';
             insert crd3;
        }
        Data_Element_Identifier__c dei = new Data_Element_Identifier__c();
        dei.Field_Name__c = 'Suppression_Non_emailable__c';
        dei.Criteria_Group_Name__c = 'Demographics';
        insert dei;
        Data_Element_Identifier__c dei2 = new Data_Element_Identifier__c();
        dei2.Field_Name__c = 'Address_Deliverable__c';
        dei2.Criteria_Group_Name__c = 'Demographics';
        insert dei2;
        Data_Element_Identifier__c dei3 = new Data_Element_Identifier__c();
        dei3.Field_Name__c = 'Member_Types__c';
        dei3.Criteria_Group_Name__c = 'Encounters';
        insert dei3;
        Campaign_Member_Search_Critera__c  cms = new Campaign_Member_Search_Critera__c ();
        cms.Requires_SubGroup__c = false;
        cms.Name = 'Demographics';
        insert cms;
        Campaign_Member_Search_Critera__c  cms2 = new Campaign_Member_Search_Critera__c ();
        cms2.Requires_SubGroup__c = false;
        cms2.Name = 'Encounters';
        insert cms2;
        CampaignWizardController.UpsertDemoCriteras(newCampaign.id,'Direct Mail', 'Email');
    
    }
    public static testmethod void TestCriteriasLov5 () {
         Campaign newCampaign = new Campaign();
         newCampaign.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
         newCampaign.Service_Line__c='Burn';
         newCampaign.CRM_SelectedOwnershipCriteria__c='AHH;AHD';
         newCampaign.CRM_OwnershipType__c='Hospital';
         newCampaign.Status ='In Development';
         //newCampaign.Call_to_Action__c='HRA';
         newCampaign.Member_Types__c='One or more encounters - Patients';
        // newCampaign.Channel__c='Direct Mail';
         newcampaign.status='In development';
         newcampaign.CRM_SubServiceLineText__c = 'Burn';
        insert newCampaign;
        List<RecordType> lstRecTypeCRD3 = [select developerName,id from RecordType where sObjectType='CRM_CampaignWizardReferenceData__c' AND developerName = 'ChannelValues'];
        CRM_CampaignWizardReferenceData__c crd3 = new CRM_CampaignWizardReferenceData__c ();
        if(lstRecTypeCRD3.size()>0) {             
             crd3.CRM_IsActive__c = true;
             crd3.Recordtypeid = lstRecTypeCRD3[0].id;
             crd3.CRM_DemoEmail__c = 'Has an email address';
             crd3.CRM_DemoMailingAddress__c= 'Has a valid or foreign mailing address';
             crd3.CRM_Channel__c = 'Email';
             insert crd3;
        }
        Data_Element_Identifier__c dei = new Data_Element_Identifier__c();
        dei.Field_Name__c = 'Suppression_Non_emailable__c';
        dei.Criteria_Group_Name__c = 'Demographics';
        insert dei;
        Data_Element_Identifier__c dei2 = new Data_Element_Identifier__c();
        dei2.Field_Name__c = 'Address_Deliverable__c';
        dei2.Criteria_Group_Name__c = 'Demographics';
        insert dei2;
        Data_Element_Identifier__c dei3 = new Data_Element_Identifier__c();
        dei3.Field_Name__c = 'Member_Types__c';
        dei3.Criteria_Group_Name__c = 'Encounters';
        insert dei3;
        Campaign_Member_Search_Critera__c  cms = new Campaign_Member_Search_Critera__c ();
        cms.Requires_SubGroup__c = false;
        cms.Name = 'Demographics';
        insert cms;
        Campaign_Member_Search_Critera__c  cms2 = new Campaign_Member_Search_Critera__c ();
        cms2.Requires_SubGroup__c = false;
        cms2.Name = 'Encounters';
        insert cms2;
        CampaignWizardController.UpsertDemoCriteras(newCampaign.id,'Direct Mail', 'Email');
    
    }
    
    
    public static testmethod void TestCriteriasNewCamp () {
         Campaign newCampaign = new Campaign();
     newCampaign.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
     newCampaign.Service_Line__c='Burn';
     newCampaign.CRM_SubServiceLineText__c='Dermatology';
     newCampaign.Vendor_Name__c='BG Solutions BS';
     newCampaign.CRM_SelectedOwnershipCriteria__c='FRH;DHF';
     newCampaign.CRM_OwnershipType__c='Hospital';
     newCampaign.Status ='In Development';
     newCampaign.Call_to_Action__c='HRA';
     newCampaign.Member_Types__c='One or more encounters - Patients';
     newCampaign.Channel__c='Direct Mail';
     newcampaign.status='In development';
   insert newCampaign;

Id RecordtypeSA = Schema.SObjectType.CRM_CampaignLocationReferenceData__c.getRecordTypeInfosByName().get('Service Area').getRecordTypeId(); 
CRM_CampaignLocationReferenceData__c locationrefdata = new CRM_CampaignLocationReferenceData__c();
     locationrefdata.CRM_ServiceArea__c='Primary Service Area';
     locationrefdata.CRM_ServiceAreaCode__c='PSA';
     locationrefdata.RecordTypeId=RecordtypeSA;
     locationrefdata.CRM_IsActive__c=True;
  insert locationrefdata;
Id Recordtypereglocation = Schema.SObjectType.CRM_CampaignLocationReferenceData__c.getRecordTypeInfosByName().get('Region').getRecordTypeId(); 
CRM_CampaignLocationReferenceData__c locationrefregiondata = new CRM_CampaignLocationReferenceData__c();
     locationrefregiondata.CRM_Region__c='Baylor/Tenet JV Region';
     locationrefregiondata.CRM_RegionCode__c='CR3';
     locationrefregiondata.RecordTypeId=Recordtypereglocation;
     locationrefregiondata.CRM_IsActive__c=True;
  insert locationrefregiondata;
Id Recordtypelocation = Schema.SObjectType.CRM_CampaignLocationReferenceData__c.getRecordTypeInfosByName().get('Market').getRecordTypeId(); 
CRM_CampaignLocationReferenceData__c refdata = new CRM_CampaignLocationReferenceData__c();
     refdata.CRM_Market__c='Baylor/Tenet JV Region';
     refdata.CRM_MarketCode__c='CR3';
     refdata.CRM_MarketsRegionID__c=locationrefregiondata.id;
     refdata.RecordTypeId=Recordtypelocation;
     refdata.CRM_IsActive__c=True;
  insert refdata;
Id Recordtypehospital = Schema.SObjectType.CRM_CampaignLocationReferenceData__c.getRecordTypeInfosByName().get('Hospital').getRecordTypeId(); 
CRM_CampaignLocationReferenceData__c Hospitalrefdata = new CRM_CampaignLocationReferenceData__c();
     Hospitalrefdata.CRM_Hospital__c='Baylor Scott & White Medical Center White Rock;Baylor Scott & White Medical Center -Contennial';
     Hospitalrefdata.CRM_HospitalCode__c='DHF';
     Hospitalrefdata.CRM_HospitalLocation__Latitude__s=32.835496;
     Hospitalrefdata.CRM_HospitalLocation__Longitude__s=-96.705023;
     Hospitalrefdata.CRM_HospitalsMarketID__c=refdata.id;
     Hospitalrefdata.RecordTypeId=Recordtypehospital;
     Hospitalrefdata.CRM_IsActive__c=True;
  insert Hospitalrefdata;
  ApexPages.currentPage().getParameters().put('id',newCampaign.id);
  pagereference testpage = new pagereference ('/apex/CampaignWizard');
       Test.setcurrentPage(testPage);
  ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
     CampaignWizardController  CampaignWiz = new CampaignWizardController(sc);
        CampaignWiz.CloneCampaign(); 
    }
    public static testmethod void CoveringConstructorMethod () {
        Campaign newCampaign = new Campaign();
        newCampaign.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        newCampaign.Service_Line__c='Burn';
        newCampaign.CRM_SubServiceLineText__c='Dermatology';
        newCampaign.Vendor_Name__c='BG Solutions BS';
        newCampaign.CRM_SelectedOwnershipCriteria__c='FRH;DHF';
        newCampaign.CRM_OwnershipType__c='Hospital';
        newCampaign.Status ='In Development';
        newCampaign.Call_to_Action__c='HRA';
        newCampaign.Member_Types__c='One or more encounters - Patients';
        newCampaign.Channel__c='Direct Mail';
        newcampaign.status='In development';
        insert newCampaign;
        System.assertEquals(newCampaign.Name, '20170127-103-Detroit-Cardiovascular-Direct Mail-V1');
        
        test.startTest();
        ApexPages.currentPage().getParameters().put('stepNo','5');
        ApexPages.currentPage().getParameters().put('detailPage','false');
        ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
        CampaignWizardController  CampaignWiz = new CampaignWizardController(sc);
        CampaignWiz.stepNumFromPage = 5;
        CampaignWiz.showTab();
        test.stopTest();
    }
    public static testmethod void CoveringSaveCampaignMethod () {
        Campaign newCampaign = new Campaign();
        newCampaign.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        newCampaign.Service_Line__c='Burn';
        newCampaign.CRM_SubServiceLineText__c='Dermatology';
        newCampaign.Vendor_Name__c='BG Solutions BS';
        newCampaign.CRM_SelectedOwnershipCriteria__c='FRH;DHF';
        newCampaign.CRM_OwnershipType__c='Hospital';
        newCampaign.Status ='In Development';
        newCampaign.Call_to_Action__c='HRA';
        newCampaign.Member_Types__c='One or more encounters - Patients';
        newCampaign.Channel__c='Direct Mail';
        newcampaign.status='In development';
        newCampaign.Control_Group_Percentage__c = 5;
        insert newCampaign;
        System.assertEquals(newCampaign.Name, '20170127-103-Detroit-Cardiovascular-Direct Mail-V1');
        
        Contact c = new Contact();
        c.FirstName = 'Test';
        c.LastName = 'Contact';
        insert c;
        System.assertEquals(c.FirstName, 'Test');
        
        CampaignMember cm = new CampaignMember();
        cm.Campaignid = newCampaign.id;
        cm.Contactid = c.id;
        cm.Control_Group__c = true;
        cm.Exclude_From_Roll_Up__c=false;
        insert cm;
        System.assertEquals(cm.Control_Group__c, true);
        
        List<RecordType> lstRecTypeCRD = [select developerName,id from RecordType where sObjectType='CRM_CampaignWizardReferenceData__c' AND developerName = 'Service_Line'];
        CRM_CampaignWizardReferenceData__c crd = new CRM_CampaignWizardReferenceData__c ();
         if(lstRecTypeCRD.size()>0) {             
             crd.CRM_IsActive__c = true;
             crd.Recordtypeid = lstRecTypeCRD[0].id;
             crd.CRM_ServiceLine__c= 'Burn';
             insert crd;
        }
        System.assertEquals(crd.CRM_ServiceLine__c, 'Burn');
        
        CRM_CampaignRefJunction__c ccr = new CRM_CampaignRefJunction__c();
        ccr.CRM_CampaignMapping__c = newCampaign.id;
        ccr.CRM_CampaignWizardReferenceData__c = crd.id;
        insert ccr;
        
        System.assertEquals(ccr.CRM_CampaignMapping__c, newCampaign.id);
        
        List<RecordType> lstRecTypeCRD2 = [select developerName,id from RecordType where sObjectType='CRM_CampaignWizardReferenceData__c' AND developerName = 'ChannelValues'];
        CRM_CampaignWizardReferenceData__c crd2 = new CRM_CampaignWizardReferenceData__c ();
         if(lstRecTypeCRD2.size()>0) {             
             crd2.CRM_IsActive__c = true;
             crd2.Recordtypeid = lstRecTypeCRD2[0].id;
             crd2.CRM_Channel__c = 'Direct Mail';
             insert crd2;
        }
        System.assertEquals(crd2.CRM_Channel__c, 'Direct Mail');
        
        CRM_CampaignRefJunction__c ccr2 = new CRM_CampaignRefJunction__c();
        ccr2.CRM_CampaignMapping__c = newCampaign.id;
        ccr2.CRM_CampaignWizardReferenceData__c = crd2.id;
        insert ccr2;
        System.assertEquals(ccr2.CRM_CampaignMapping__c, newCampaign.id);
        
        Data_Element_Identifier__c dei = new Data_Element_Identifier__c();
        dei.Field_Name__c = 'Member_Types__c';
        dei.Criteria_Group_Name__c = 'Encounters';
        insert dei;
        System.assertEquals(dei.Criteria_Group_Name__c,'Encounters');
        
        Campaign_Member_Search_Critera__c  cms = new Campaign_Member_Search_Critera__c ();
        cms.Requires_SubGroup__c = false;
        cms.Name = 'Encounters';
        insert cms;
        CampaignSequencer__c cs = new CampaignSequencer__c();
        cs.Name = '101';
        cs.Counter_Value__c = 102 ;
        insert cs;
        
        System.assertEquals(cs.Name,'101');
        
        test.startTest();
        ApexPages.currentPage().getParameters().put('id',newCampaign.id);
        ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
        CampaignWizardController  CampaignWiz = new CampaignWizardController(sc);
        CampaignWiz.TemplateFlag = 'true';
        CampaignWiz.SaveCampaign();        
        //CampaignWiz.createControlGroup();
        test.stopTest();
    }
      public static testmethod void CoveringSaveCampaignMethodWithFalseTemplate () {
        Campaign newCampaign = new Campaign();
        newCampaign.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        newCampaign.Service_Line__c='Burn';
        newCampaign.CRM_SubServiceLineText__c='Dermatology';
        newCampaign.Vendor_Name__c='BG Solutions BS';
        newCampaign.CRM_SelectedOwnershipCriteria__c='FRH;DHF';
        newCampaign.CRM_OwnershipType__c='Hospital';
        newCampaign.Status ='In Development';
        newCampaign.Call_to_Action__c='HRA';
        newCampaign.Member_Types__c='One or more encounters - Patients';
        newCampaign.Channel__c='Direct Mail';
        newcampaign.status='In development';
        newCampaign.Control_Group_Percentage__c = 5;
        insert newCampaign;
        System.assertEquals(newCampaign.Name, '20170127-103-Detroit-Cardiovascular-Direct Mail-V1');
        
        Contact c = new Contact();
        c.FirstName = 'Test';
        c.LastName = 'Contact';
        insert c;
        System.assertEquals(c.FirstName, 'Test');
        
        CampaignMember cm = new CampaignMember();
        cm.Campaignid = newCampaign.id;
        cm.Contactid = c.id;
        cm.Control_Group__c = true;
        cm.Exclude_From_Roll_Up__c=false;
        insert cm;
        System.assertEquals(cm.Control_Group__c, true);
        
        List<RecordType> lstRecTypeCRD = [select developerName,id from RecordType where sObjectType='CRM_CampaignWizardReferenceData__c' AND developerName = 'Service_Line'];
        CRM_CampaignWizardReferenceData__c crd = new CRM_CampaignWizardReferenceData__c ();
         if(lstRecTypeCRD.size()>0) {             
             crd.CRM_IsActive__c = true;
             crd.Recordtypeid = lstRecTypeCRD[0].id;
             crd.CRM_ServiceLine__c= 'Burn';
             insert crd;
        }
        System.assertEquals(crd.CRM_ServiceLine__c, 'Burn');
        
        CRM_CampaignRefJunction__c ccr = new CRM_CampaignRefJunction__c();
        ccr.CRM_CampaignMapping__c = newCampaign.id;
        ccr.CRM_CampaignWizardReferenceData__c = crd.id;
        insert ccr;
        
        System.assertEquals(ccr.CRM_CampaignMapping__c, newCampaign.id);
        
        List<RecordType> lstRecTypeCRD2 = [select developerName,id from RecordType where sObjectType='CRM_CampaignWizardReferenceData__c' AND developerName = 'ChannelValues'];
        CRM_CampaignWizardReferenceData__c crd2 = new CRM_CampaignWizardReferenceData__c ();
         if(lstRecTypeCRD2.size()>0) {             
             crd2.CRM_IsActive__c = true;
             crd2.Recordtypeid = lstRecTypeCRD2[0].id;
             crd2.CRM_Channel__c = 'Direct Mail';
             insert crd2;
        }
        System.assertEquals(crd2.CRM_Channel__c, 'Direct Mail');
        
        CRM_CampaignRefJunction__c ccr2 = new CRM_CampaignRefJunction__c();
        ccr2.CRM_CampaignMapping__c = newCampaign.id;
        ccr2.CRM_CampaignWizardReferenceData__c = crd2.id;
        insert ccr2;
        System.assertEquals(ccr2.CRM_CampaignMapping__c, newCampaign.id);
        
        Data_Element_Identifier__c dei = new Data_Element_Identifier__c();
        dei.Field_Name__c = 'Member_Types__c';
        dei.Criteria_Group_Name__c = 'Encounters';
        insert dei;
        System.assertEquals(dei.Criteria_Group_Name__c,'Encounters');
        
        Campaign_Member_Search_Critera__c  cms = new Campaign_Member_Search_Critera__c ();
        cms.Requires_SubGroup__c = false;
        cms.Name = 'Encounters';
        insert cms;
        CampaignSequencer__c cs = new CampaignSequencer__c();
        cs.Name = '101';
        cs.Counter_Value__c = 102 ;
        insert cs;
        
        System.assertEquals(cs.Name,'101');
        
        List<RecordType> lstRecTypeCLR = [select developerName,id from RecordType where sObjectType='CRM_CampaignLocationReferenceData__c' AND developerName = 'Hospital'];
        if(lstRecTypeCLR.size()>0) {
        CRM_CampaignLocationReferenceData__c clrm = new CRM_CampaignLocationReferenceData__c ();
        clrm.CRM_IsActive__c =  true;
        clrm.CRM_Hospital__c = 'ABC';
        clrm.Recordtypeid = lstRecTypeCLR[0].id;
        insert clrm;
        System.assertEquals(clrm.CRM_Hospital__c, 'ABC');
        
        CRM_CampaignOwnershipDetail__c cos = new CRM_CampaignOwnershipDetail__c ();
        cos.Campaign_Location_Reference_Data_Mapping__c = clrm.id;
        cos.campaign__c = newCampaign.id;
        insert cos;
        System.assertEquals(cos.campaign__c,newCampaign.id);
        }
        test.startTest();
        ApexPages.currentPage().getParameters().put('id',newCampaign.id);
        ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
        CampaignWizardController  CampaignWiz = new CampaignWizardController(sc);
        CampaignWiz.TemplateFlag = 'false';
        CampaignWiz.SelectedOwnershipValues(newCampaign.id);
        CampaignWiz.SaveCampaign();                
        test.stopTest();
    }
    public static testmethod void CoveringSaveCampaignMethodWithFalseTemplate1 () {
        Campaign newCampaign = new Campaign();
        newCampaign.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        newCampaign.Service_Line__c='Burn';
        newCampaign.CRM_SubServiceLineText__c='Dermatology';
        newCampaign.Vendor_Name__c='BG Solutions BS';
        newCampaign.CRM_SelectedOwnershipCriteria__c='FRH;DHF';
        newCampaign.CRM_OwnershipType__c='Hospital';
        newCampaign.Status ='In Development';
        newCampaign.Call_to_Action__c='HRA';
        newCampaign.Member_Types__c='Upload List';
        newCampaign.Channel__c='Direct Mail';
        newCampaign.Control_Group_Percentage__c = 5;
        insert newCampaign;
     CRM_AudienceUploadJunction__c aud = marketingDataUtils.createAudienceJunction(newCampaign.id);
        test.startTest();
        ApexPages.currentPage().getParameters().put('id',newCampaign.id);
        ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
        CampaignWizardController  CampaignWiz = new CampaignWizardController(sc);
        CampaignWiz.refreshNetCount();
        test.stopTest();
    }
    
    public static testmethod void CampaignWizardOverrideSuppActionTest()
    {
        Campaign newCampaign = new Campaign();
        newCampaign.Name='20170923-104-Baylor/Tenet JV-Burn-Email-V1';
        newCampaign.CRM_SubServiceLineText__c='Dermatology';
        newCampaign.Approved__c=True;
        newCampaign.Vendor_Name__c='Amplified Digital (AD)';
        string campname_value1 ='val';
        newCampaign.Audience_Hospital__c ='';
        newCampaign.Audience_Region__c='';
        newCampaign.Audience__c='Baylor/Tenet JV Region';
        newCampaign.Service_Line__c='Burn';
        newCampaign.Channel__c='Email';
        newCampaign.Status ='In Development';
        newCampaign.Control_Group_Percentage__c =100;
        newCampaign.Current_count__c=21;
        newCampaign.LIST_ORDER_SELECT_GRP_ID__c=354;
        newCampaign.List_Order_Id__c=7333;
        newCampaign.Approved_By__c ='vaishali';
        newCampaign.CRM_OwnershipType__c = 'Hospital';
        newCampaign.Place_Order_Date_Time__c =system.today();
        newCampaign.Member_types__c='Campaign Segments';
        insert newCampaign;
        
        Campaign segCampaign = new Campaign();
        segCampaign.Name = 'SEG00000000';
        segCampaign.Add_Member_Status__c = 'Calculated Net Count';
        segCampaign.CRM_ParentSegmentedCampaign__c = newCampaign.Id;
        insert segCampaign;
        
     // String camp_name = '20171004-104-South Carolina-Physical Therapy/Rehabilitation-External Mobile Messaging-V1';
        campaignSequencer__c campsequencer = new campaignSequencer__c();
        campsequencer.Counter_Value__c=999;
        campsequencer.Name='count';
        insert campsequencer;
        
        contact con = marketingDataUtils.createcontact();
        CampaignMember campaignmem = marketingDataUtils.createcampmember(newCampaign.id, con.id);
        Location__c loctn = marketingDataUtils.createlocation();
        Campaign_Location__c  camploc = marketingDataUtils.createLocationInformation(newCampaign.id,loctn.id);
        CRM_CampaignLocationReferenceData__c locreference = marketingDataUtils.createRegionMarket();
        Lead  ld = marketingDataUtils.createleads();
        Transaction__c  tr = marketingDataUtils.createTransaction(newCampaign.id,ld.id);
        pagereference testpage = new pagereference ('/apex/CampaignWizard');
        Test.setcurrentPage(testPage);     
        CampaignWizardController.filterCriteria wrap1 = new CampaignWizardController.filterCriteria(); 
        ApexPages.currentPage().getParameters().put('id',newCampaign.id);
        ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
        CampaignWizardController  CampaignWiz = new CampaignWizardController(sc);
        Test.startTest();
        CampaignWiz.AddHomeAddress();
        CampaignWiz.activatecampaign();
        //CampaignWiz.vendorname();
        CampaignWiz.campname_value1 ='val';
        CampaignWiz.nameFlag = true;
        CampaignWiz.camp_name = '20171004-104-South Carolina-Physical Therapy/Rehabilitation-External Mobile Messaging-V1';
        CampaignWiz.CampNamingConvention();
        CampaignWiz.SaveCampaign();
        CampaignWiz.overrideSuppAction();
        CampaignWiz.refreshCount();
        segCampaign.Add_Member_Status__c = null;
        update segCampaign;
        CampaignWiz.overrideSuppAction();
      Test.stopTest();
    } 
    
    
}
public class EncounterPageController 
{
    
    /*****Object Declaration ******/
    string text ;
    string text1;
    string  HospitalCodes;
    string PrefHodpitalCodes;
    List<String> Hosval; // hospital change encounter
    List<String> HospitalField; // hospital change emcounter aggregates
    string PrefHosVal;
    public  Model__c model{get;set;}
    public Campaign campobj {get;set;}   
   
    public campaign campgn{get;set;}
    public Life_Style__c lf{get;set;}
    public List<Location__c> SelectedHospitalCode=new List<Location__c>();
    public List<Location__c> SelectedPreferredHospitalCode=new List<Location__c>();
    public  List<Location__c> SelectedHospitalName=new List<Location__c>();
    public  List<Location__c> SelectedPreferredHospitalName=new List<Location__c>();
    public Encounter__c enc{get;set;}
    public Encounter_aggregates__c encagg{get;set;}
    public list<SelectOption> HospitalList{get;set;}
    public set<SelectOption> ChosenHospitalList{get;set;}
    public list<SelectOption> selectedHospitalList{get;set;}
    // public  List<Hospitals__c> SelectedHospitalName{get;set;} 
    public Encounter__c BeforeSaveEnc{get;set;}
    public Campaign_Demographics__c demo{get;set;}
    public Integer valueSelected{get;set;}
    public Integer valueSelected1{get;set;}
    public Integer age_from {get; set;} 
    public Integer  age_to {get; set;} 
    public list<SelectOption> serviceAreList{get;set;}
   
    //public Campaign_HRA__c hra{get;set;}
    
    //Part of R2 
    //public Interaction__c itr{get;set;}
    
    public date mydate1{get;set;}
    public boolean DetailPage{get;set;}
    //public Campaign_Demographics__c demo{get;set;}
       
    public string campaignId{get;set;}
    public string encounterid{get;set;}
    public string encounteraggid{get;set;}
    public string Modelid {get;set;}
    public string Lifeid{get;set;}
    public integer button{get;set;}
    Public Integer btn{get;set;}
    public string lifestyleid{get;set;}
   // public string hraid{get;set;}
    
    //Part of R2
    //public string itrid{get;set;}
    public string demoid{get;set;}
    public Campaign objCampaign {get ; set ;}
    public list<SelectOption> PrefferedHospitalList {get;set;}
    public List<SelectOption> SelectedPrefferedHospitalList{get;set;}
    public integer selectedbutton{get;set;}
    public String[] selectedValSL {get;set;}    //audience selection Service line and sub service  line change 
    public String[] selectedValSSL {get;set;}    //audience selection Service line and sub service  line change 
    public map<id,CRM_AudienceCriteriaRefData__c> serviceLineMap{get;set;}    //audience selection Service line and sub service  line change  
    public map<id,CRM_AudienceCriteriaRefData__c> SelectedserviceLineMap{get;set;}
    public map<id,CRM_AudienceCriteriaRefData__c> showSelectedSubService{get;set;} //audience selection Service line and sub service  line change
    public string[] selectedHospitalCriteria{get;set;} // for hospial change
    public List<String> selectedhospitalCodes{get;set;}
    public string[] selectedPrefferedHospitalCriteria{get;set;} // for prefered hospial change
    public List<String> selectedpreferedhospitalCodes{get;set;}
    //map<id,set<id>> selectedServiceANDSubServiceline;
    public List<SelectOption> subserviceline{get;set;}  //audience selection Service line and sub service  line change
    
    public EncounterPageController(ApexPages.StandardController controller)
    {
         
        enc = new Encounter__c();
        encagg = new Encounter_aggregates__c();
        lf=new Life_Style__c();
        //Part of R2
        //hra=new Campaign_HRA__c();
        model= new Model__c();
        demo= new Campaign_Demographics__c();
        selectedHospitalList= new list<SelectOption>();
         system.debug('values of facility id====='+ selectedHospitalList);
         system.debug('size of facility id====='+ selectedHospitalList.size());
         SelectedPrefferedHospitalList= new list<SelectOption>();
        //enc.Discharge_Date__c=null;
        //Datetime myDate = datetime.valueOf(enc.Discharge_Date__c);
        //system.debug('#####'+myDate);
        //mydate1=String.valueOf(myDate);
        //myDate1=null;
        //system.debug('#####'+myDate1);
        //enc.Discharge_Date__c=date.valueOf('');
        //enc.Discharge_Date__c=null;
        //Start of audience selection Service line and sub service  line change
        subserviceline = new list<SelectOption>();
        selectedValSL = new String[]{}; 
        selectedvalSSL = new String[]{};
         //end of audience selection Service line and sub service  line change
        selectedHospitalCriteria =  new String[]{}; // for hospital change
        selectedhospitalCodes  =  new List<String>();
        selectedPrefferedHospitalCriteria =  new String[]{}; // for hospital change
        selectedpreferedhospitalCodes  =  new List<String>();
        Hosval =  new List<String>();
        HospitalField = new List<String>();
        DetailPage=true;
        campObj = (Campaign) controller.getRecord(); //PP4 chnage
        campaignId=ApexPages.currentPage().getParameters().get('id');
        for(Campaign cmp :[Select CRM_ParentSegmentedCampaign__c from campaign where id=:campaignId]){//PP4 chnage
        	campObj= cmp;
        }
        Modelid=ApexPages.currentPage().getParameters().get('Modelid');
        demo.Suppression_Non_emailable__c = 'Everyone';
        demo.Address_Deliverable__c= 'Everyone';
        system.debug('campaign id====' + campaignId);
        preparehospitalpicklist();
         
        if(ApexPages.CurrentPage().getParameters().get('btn')!= null)
        {
            button = Integer.valueOf(ApexPages.CurrentPage().getParameters().get('btn'));
            system.debug('value of button\\\\\\\\\\\\\\'+ button);
        }else
           btn=0;
           
           
           
        system.debug('%%%%%%btn'+ btn);
        encounterid=ApexPages.currentPage().getParameters().get('encounter');
        encounteraggid= ApexPages.currentPage().getParameters().get('encounteraggregates');
        Lifeid=ApexPages.currentPage().getParameters().get('lifestyle');
        lifestyleid=ApexPages.currentPage().getParameters().get('lifestyle');
        //Part Of R2
        //hraid=ApexPages.currentPage().getParameters().get('hra');
        demoid=ApexPages.currentPage().getParameters().get('demo');
        system.debug('value of enc'+ enc);
        
        if(ApexPages.CurrentPage().getParameters().get('Id') != null && encounterid!=null )
        {
            
            system.debug('value of encounter'+ encounterid);
            enc=[SELECT Wunderman_Preferred_Hospitals__c,Hospital_Names__c, HospitalIds__c,Discharge_Date_encounter__c,To_discharge_date_encounter__c,Campaign__c,
                          Discharge_Date_To__c,Discharge_Date__c,ED_Flag__c,Exclude_Facility_IDs__c,Exclude_Physician_NPIs__c,
                          Hospital_IDs__c,Include_Facility_ID__c,Include_Physician_NPIs__c,Labor_and_Delivery_Flag__c,
                          Patient__c,Normal_Newborn_Flag__c,Number_of_ER_Encounters_to__c,Number_of_ER_Encounters__c,
                          Payor_Type__c,Discharge_Date_Ranges__c,Surgery_Flag__c,No_of_ER_Encounters_ranges__c,
                          CRM_ServiceLine__c,CRM_SubServiceLine__c,CRM_SelectedHospitalCodes__c FROM Encounter__c where id=:encounterid limit 1];
            
          system.debug('Value of enc before '+enc);
              
          if (enc.Include_Facility_ID__c!=null)
          enc.Include_Facility_ID__c=enc.Include_Facility_ID__c.replace(';' , ',');   
          if (enc.Exclude_Facility_IDs__c!=null)  
          enc.Exclude_Facility_IDs__c =enc.Exclude_Facility_IDs__c.replace(';' , ',');
          if (enc.Exclude_Physician_NPIs__c!=null) 
          enc.Exclude_Physician_NPIs__c=enc.Exclude_Physician_NPIs__c.replace(';' , ',');
          if (enc.Include_Physician_NPIs__c!=null)
          enc.Include_Physician_NPIs__c=enc.Include_Physician_NPIs__c.replace(';' , ',');
              
          system.debug('Value of enc after'+enc);
            // Start of audience selection Service line and sub service  line change
            //Fetch Service LIne and Sub Service Line details for existing records for Service line and sub service  line change         
          id servicelineRecordTypeId = ReferenceData_PicklistController.recordTypeId('CRM_AudienceCriteriaRefData__c','ClinicalServiceLine');
          id subServicelineRecordTypeId=ReferenceData_PicklistController.recordTypeId('CRM_AudienceCriteriaRefData__c','ClinicalSubServiceLine');
          
            for(CRM_EncounterServiceLineSelection__c esl : [select id,CRM_AudienceCriteriaReferenceData__c,CRM_AudienceCriteriaReferenceData__r.recordTypeId,CRM_AudienceCriteriaReferenceData__r.CRM_ClinicalServiceLineID__r.CRM_IsActive__c from CRM_EncounterServiceLineSelection__c where CRM_Encounter__c=:enc.id AND CRM_AudienceCriteriaReferenceData__r.CRM_IsActive__c=true]){
              if(esl.CRM_AudienceCriteriaReferenceData__r.recordTypeId==servicelineRecordTypeId)
                selectedValSL.add(esl.CRM_AudienceCriteriaReferenceData__c);
                
              if(esl.CRM_AudienceCriteriaReferenceData__r.recordTypeId==subServicelineRecordTypeId && esl.CRM_AudienceCriteriaReferenceData__r.CRM_ClinicalServiceLineID__r.CRM_IsActive__c)
                selectedvalSSL.add(esl.CRM_AudienceCriteriaReferenceData__c);
            }
            
            if(DetailPage)
              serviceLineItems();
            SelectedserviceLineMap = new map<id,CRM_AudienceCriteriaRefData__c>([select id,CRM_ClinicalServiceLine__c,CRM_ClinicalSubServiceLine__c from CRM_AudienceCriteriaRefData__c where Id in (Select  CRM_AudienceCriteriaReferenceData__c from CRM_EncounterServiceLineSelection__c where CRM_Encounter__c =: enc.id)]);
            //This method is used to show exiting sub service line selection
            refreshSubServiceLines();
            //***********************************
          // end of audience selection Service line and sub service  line change
          // Start of hospital change
           showselectedhospitals();
         system.debug('Selected hospital values in edit mode in cons@@@@'+ selectedHospitalCriteria);
        }
        
        
        if(ApexPages.CurrentPage().getParameters().get('Id') != null && encounteraggid!=null )
        {
            
            system.debug('value of encounter'+ encounterid);
            encagg =[SELECT Campaign__c, Last_Discharge_Date_From_UI__c,CRM_SelectedPreferedHospitalCodes__c,Last_Discharge_Date_To_UI__c, Most_Recent_Primary_Payor_Type__c , Number_of_ER_Encounters__c,Number_of_ER_Encounters_To__c,Preffered_Hospital__c, Wunderman_Preferred_Hospitals__c, No_of_ER_Encounters_ranges__c, Last_Discharge_Date_Ranges__c, Last_Discharge_Date_Criteria_Element_Id__c  FROM Encounter_aggregates__c
                            where id=:encounteraggid limit 1];
            
        system.debug('@@@@@@encaggPreferredHospital '+encagg.Preffered_Hospital__c);
            
        //   system.debug('Value of enc after'+enc);
        //start of hospital change
        showselectedpreferedhospitals();
         system.debug('Selected hospital values in edit mode in cons@@@@'+ selectedHospitalCriteria); 
        }
        
        
        if(ApexPages.CurrentPage().getParameters().get('Id') != null && Lifeid!=null )
        {
            system.debug('value of lifestyle'+ Lifeid);
            lf=[SELECT Aches_and_Pain_AGPAIN__c,Ailment_Present_Any__c,Allergies_and_Sinuses_AGNOSE__c,
                            Campaign__c,Cancer_AGCANCER__c,Uninsured_Index__c ,
                            
                            Cholesterol_and_Blood_Pressure_AGBLOOD__c,Diabetes_AGDIAB__c,Digestive_AGDIG__c,Do_It_Yourself__c,Female_Conditions_AGFEM__c,
                            Fine_Arts__c,Foot_AGFOOT__c,Healthcare_Treatment_Pref__c,Health_Index_Illness_or_Condition_To__c,Health_Index_Manage_Bus_of_Health_To__c,
                            Health_Index_Manage_Bus_of_Health__c,Health_Index_Manage_Health_From__c,Health_Index_Manage_Health_To__c,
                            Health_Index_Manage_Illness_Condition_Fr__c,Health_Index_Wear_Dev_to_Manage_Health_T__c,Health_Index_Wear_Dev_to_Manage_Health__c,
                            Health_Ins_Direct_Pay_Index_From__c,Health_Ins_Direct_Pay_Index_To__c,Health_Ins_Engagement_Index_From__c,Health_Ins_Engagement_Index_To__c,
                            Health_Ins_Influence_Index_From__c,Health_Ins_Influence_Index_To__c,Health_Ins_Prem_Tolerance_Index_to__c,Health_Ins_Prem_Tolerance_Index__c,
                            Health_Ins_Subsidy_Ind_to__c,Health_Ins_Subsidy_Ind__c,Heart_Condition_AGHEART__c,Home_Life__c,Joint_Spine_AGJOINT__c,Luxury_Life__c,
                            Male_Conditions_AGMALE__c,Medicare_Supplement_Ins_Rspnder_Idx_from__c,Medicare_Supplement_Ins_Rspnder_Idx_to__c,
                            Mobility_Problems_and_Assistance_AGAST__c,Mouth_and_Teeth_AGMOUTH__c,Outdoor_Enthusiasts__c,Physically_Active__c,
                            Progressive_Conditions_AGPROG__c,Psychological_Behavioral_AGPSYCO__c,Respiratory_AGRESP__c,Skin_AGSKIN__c,Sports_Enthusiasts__c,Techies__c,
                            Uninsured_Index_to__c,Up_Town__c,Urinary_Bowel_AGURINAR__c,
                            Health_Index_Manage_Bus_of_Health_ranges__c,Health_Index_Manage_Health_ranges__c,Health_Index_Manage_Illness_Cond_ranges__c,
                            Health_Index_Weardevto_managehealth_rang__c,Health_ins_engagement_index_ranges__c,Health_ins_influence_index_ranges__c,
                            Health_Ins_Pay_Index_ranges__c,Health_ins_prem_tolerance_index_ranges__c,Medicare_supplement_ins_respond_ind_rang__c,
                            Uninsured_index_ranges__c,CRM_Living_Well__c, // Added for Audience Selection criteria story
                            Vision_AGVSN__c,Weight_AGWEIGHT__c FROM Life_Style__c
                            where id=:Lifeid limit 1];
            system.debug('*****values of LifeStyle Record *****'+ lf);
        }
        
        
        
        //Part of R2
        /*
        if(ApexPages.CurrentPage().getParameters().get('Id') != null && hraid!=null )
        {
            
            system.debug('value of encounter'+ hraid);
            hra=[select Campaign__c, Asthma_Risk_Category__c,Breast_Cancer_Lifetime_Risk__c,Back_Neck_Impairement__c,BMI_Category__c,Breast_Cancer_5_Year__c,Diabetes_Risk__c,Incontinence_Symptoms__c,Interest_Baria__c,Interest_Cardiology__c,Interest_Emergency__c,Interest_Obstetrics__c,Interest_Orthopedics__c,Interest_Pediatrics__c,Joint__c,Joint_Assessment__c,Joint_BMI_Category__c,Lead_Role__c, Lifetime_Risk_Category__c, Lung_Screening__c, OrthoOsteoarthritis_Joint_Disease__c, Ortho_Pain_Type__c, Pad_Risk_Category__c, Prostate_Risk_Category__c,qoL_Impact__c, Risk_Category__c, Risk_Category_30_Years__c, Seminar_Date__c, Stroke_Risk_Category__c, Weight_Loss_Rec__c, Weight_Loss_Surgery_Rec__c from Campaign_HRA__c where id=:hraid limit 1];
            system.debug('value of enc'+ hra);
        }*/
        
        if(ApexPages.CurrentPage().getParameters().get('Id') != null && Modelid!=null )
        {
            
            system.debug('value of Modelid'+ Modelid);
            model=[select Model_1_from__c, Model_1_to__c,Model_2_from__c, Model_2_to__c,Model_3_from__c, Model_3_to__c,Model_4_from__c, Model_4_to__c, Campaign__c,Model_Cardiology_Ranges__c,Model_Ortho_Hip_Ranges__c,Model_Ortho_Knee_Ranges__c,Model_Ortho_Spine_Ranges__c
                   ,Model_5_from__c, Model_5_to__c,Model_6_from__c, Model_6_to__c,Model_7_from__c, Model_7_to__c,Model_8_from__c, Model_8_to__c,Model_for_Breast_Ranges__c,Model_Colon_Ranges__c,Model_OB_Medicade_Ranges__c,Model_OB_Commercial_Ranges__c // Added for new Model Requirement
                   , Model_9_from__c, Model_9_to__c, Model_Bariatric_Ranges__c // Added for new Model CRM 270 req.
                   from Model__c where id=:Modelid limit 1];
            system.debug('value of model'+ Modelid);
        }
        
         if(ApexPages.CurrentPage().getParameters().get('Id') != null && demoid!=null )
        {
             
            system.debug('value of encounter'+ demoid);
            demo=[SELECT DOBFrom_UI__c,DOBTo_UI__c,DOB__c,AgeTo_UI__c,AgeFrom_UI__c,Address_Deliverable__c,Age__c,Assimilation__c,Birthdate__c,Campaign__c,New_Movers_Range__c,
                                                  Dwelling_Type__c,Birthdate_Ranges__c,
                                                  Est_Discretionary_Income_Percent_to__c,Est_Discretionary_Income_Percent__c,
                                                  Est_Household_Debt_Level__c,Est_Household_Income_3_0__c,Ethcinity_Criteria_Element__c,
                                                  Ethcinity__c,Ethnic_Group__c,Gender_Criteria_Element__c,Gender__c,Generations_2_0__c,
                                                  Language__c,
                                                  
                                                  Move_Activity_Criteria_Element__c,Move_Activity_in_Months__c,
                                                  Name,Net_Worth_3_0__c,Number_of_Adults_in_HH__c,Number_of_Children__c,Number_of_Persons_in_HH__c,
                                                  
                                                  Preferred_Contact_Criteria_Element__c,Preferred_Contact_Method__c,Presence_of_Children__c,
                                                  Presence_of_Donor__c,Presence_of_Elderly_Parents__c,
                                                  Race__c,Religion_Criteria_Element__c,Religion__c,
                                                  Suppression_Non_emailable__c,SystemModstamp,to_1__c,to_age__c,to_Number_of_Adults_in_HH__c,New_movers__c,CRM_Birth_Month__c,// Added for Audience Selection criteria story-BithMonth 
                                                  Discretionary_Income_Percent_ranges__c,Household_size_ranges__c,Number_of_Adults_in_hh_ranges__c,Number_of_Children_ranges__c,
                                                  to_Number_of_Children__c,to_Number_of_Persons_in_HH__c FROM Campaign_Demographics__c
                                                   where id=:demoid limit 1];
            system.debug('value of enc'+ demo);
            if(demo.Age__c!=null) 
            {
                String[] agefrom = new List<String>();
                  system.debug('##### agefrom'+agefrom);
                if(agefrom.size()>0){
                   if(agefrom[0]!=null) age_from = Integer.valueOf(agefrom[0]);
                 system.debug('##### inside if block#####');
                }
                 if(agefrom.size()>1) 
                   if(agefrom[1]!=null) age_to = Integer.valueOf(agefrom[1]);
                    
             }
                
        }
        
        if(encagg.Preffered_Hospital__c != null)
            {
                  system.debug('@@@@@@@@@@@@ encagg.Preffered_Hospital__c'+encagg.Preffered_Hospital__c);
                List<String> lstprefferedHospital = encagg.Preffered_Hospital__c.split(';');
                system.debug('lstHospital *****'+lstprefferedHospital ); 
                for(string str : lstprefferedHospital )
                {
                system.debug('value in constructor of hospital======'+ str);
                    SelectedPrefferedHospitalList.add(new SelectOption(str, str));
                }
                system.debug('SelectedPrefferedHospitalList*****'+SelectedPrefferedHospitalList); 
                
            }
        preparePiclistFields();
        prepareHospitalchosenPiclistFields();
    }
    // start of hospital change
     Id recordTypeid = ReferenceData_PicklistController.recordTypeId('CRM_CampaignLocationReferenceData__c', 'Hospital');
    public list<SelectOption> ownershiptype{
        get{
             return ReferenceData_PicklistController.refreshOwnershiptype(recordTypeid);
            
        }
        set;
    }
    public  map<id,CRM_CampaignLocationReferenceData__c> showSelectedhospital{get;set;}
    public  map<id,CRM_CampaignLocationReferenceData__c> showPreferedSelectedhospital{get;set;}
    public void fetchOwnershipNames(){
        system.debug('*****selectedCriteria='+selectedHospitalCriteria);
        showSelectedhospital = new map<id,CRM_CampaignLocationReferenceData__c>([select id,CRM_Hospital__c,CRM_HospitalMarket__c from CRM_CampaignLocationReferenceData__c where Id IN:selectedHospitalCriteria AND CRM_isActive__C = true]);
    
    }
    public void fetchpreferedOwnershipNames(){
        system.debug('*****selectedCriteria='+selectedPrefferedHospitalCriteria);
        showPreferedSelectedhospital = new map<id,CRM_CampaignLocationReferenceData__c>([select id,CRM_Hospital__c,CRM_HospitalMarket__c from CRM_CampaignLocationReferenceData__c where Id IN:selectedPrefferedHospitalCriteria AND CRM_isActive__C = true]);
    
    }
    //start of audience selection Service line and sub service  line change
    public List<SelectOption> lstServiceLinevalues {
        get {
           return serviceLineItems();
        }
        set;
    
    }
    
    list<SelectOption> serviceLineItems(){
      list<SelectOption> serviceLine = ReferenceData_PicklistController.clinicalServiceLine(false);
         serviceLineMap = ReferenceData_PicklistController.clinicalServiceLineMap;
         return serviceLine;
    }
    // end of audience selection Service line and sub service  line change
    // start of Service line and sub service  line change
    set<string> selectedSL;
    public void refreshSubServiceLines(){
        
        system.debug('****selectedValSL='+selectedValSL);
    
    system.debug('****subserviceline='+subserviceline);
    subserviceline.clear();
    subserviceline.addAll(ReferenceData_PicklistController.clinicalSubServiceLine(false,selectedValSL));
    system.debug('****subserviceline='+subserviceline);
    //This section will handle selection and non selection of parent and child line items 
    if(selectedSL==null)
        selectedSL=new set<string>();
      else
        selectedSL.clear();
        
      selectedSL.addAll(selectedValSL);
    system.debug('****selectedSL='+selectedSL);
    //resetSubServiceLine();
    system.debug('****selectedValSSL_1='+selectedValSSL);
    if(selectedValSSL.size()>0)
      fetchSubServiceLineNames();
    
    }
    //selectedServiceANDSubServiceline
    public void fetchSubServiceLineNames(){
        showSelectedSubService = new map<id,CRM_AudienceCriteriaRefData__c>();
        set<string> virtuallist = new set<string>();
        virtuallist.addAll(selectedValSSL);
        for(CRM_AudienceCriteriaRefData__c cr : [select id,CRM_ClinicalSubServiceLine__c,CRM_ClinicalSubServiceLineSyncData__c,CRM_ServiceSubServiceLine__c,CRM_ClinicalServiceLineID__c from CRM_AudienceCriteriaRefData__c where Id IN:selectedValSSL order by CRM_ServiceSubServiceLine__c asc]){
            system.debug('*****selectedSL='+selectedSL);
            system.debug('*****cr.CRM_ClinicalServiceLineID__c='+cr.CRM_ClinicalServiceLineID__c);
            if(selectedSL.contains(cr.CRM_ClinicalServiceLineID__c))
                showSelectedSubService.put(cr.id,cr);
            else{
                //Integer i =0;
                //Start :Service line /subservice line blank issue 
                system.debug('*****cr.id='+cr.id);
                if(virtuallist.contains(cr.id))
                        virtuallist.remove(cr.id);
                /*for(string sslId: selectedValSSL){
                    system.debug('*****sslId='+sslId);
                    if(virtuallist.contains(sslId))
                        virtuallist.remove(sslId);
                    //if(cr.id==sslId)
                        //virtuallist.remove(i);
                    
                    //i++;
                }*/
                
                //End :Service line /subservice line blank issue
            }
        }
        
        selectedValSSL.clear();
        selectedValSSL.addAll(virtuallist);
        
        system.debug('*****virtuallist='+virtuallist);
        
        system.debug('*****selectedValSSL='+selectedValSSL);
    }
    
    //this method will insert/update service line ans sub serviceline criteria in encount and junction object
    void manageSLandSSL(){
       //We only sync service line which does not have any sub service line selected
       
       set<string> validSLforSync = new set<string>();
       validSLforSync.addAll(selectedValSL);
       
       if(selectedValSSL.size()>0){
           //enc.CRM_SubServiceLine__c =string.join(selectedValSSL,';');
           string ssl;
           for(string str : selectedValSSL){
             if(string.isBlank(ssl))
               ssl=showSelectedSubService.get(str).CRM_ClinicalSubServiceLineSyncData__c;
             else
               ssl += ';'+showSelectedSubService.get(str).CRM_ClinicalSubServiceLineSyncData__c;
               
             if(validSLforSync.contains(showSelectedSubService.get(str).CRM_ClinicalServiceLineID__c))
               validSLforSync.remove(showSelectedSubService.get(str).CRM_ClinicalServiceLineID__c);
           }  
           enc.CRM_SubServiceLine__c = ssl;
           
        }else{
          enc.CRM_SubServiceLine__c =null;
        }
        
        
        if(validSLforSync.size()>0){
           //enc.CRM_ServiceLine__c =string.join(selectedValSL,';');
           string sl;
           for(string str : validSLforSync){
             if(string.isBlank(sl))
               sl=serviceLineMap.get(str).CRM_ClinicalServiceLineSyncData__c;
             else
               sl += ';'+serviceLineMap.get(str).CRM_ClinicalServiceLineSyncData__c;
           }  
           enc.CRM_ServiceLine__c = sl;
       }else{
           enc.CRM_ServiceLine__c =null;
       }
    }
    
    //This method will create/update/delete data from junction obejct for SL and SSL
    void manageRefrenceData(){
      //selectedValSL,selectedValSSL;CRM_EncounterServiceLineSelection__c
      set<string> servicelineANDSSLIds = new set<string>();
      system.debug('****selectedValSL='+selectedValSL);
      system.debug('****selectedValSSL='+selectedValSSL);
      servicelineANDSSLIds.addAll(selectedValSL);
      servicelineANDSSLIds.addAll(selectedValSSL);
      system.debug('****servicelineANDSSLIds='+servicelineANDSSLIds);
      list<CRM_EncounterServiceLineSelection__c> deleteList = new list<CRM_EncounterServiceLineSelection__c>();
      list<CRM_EncounterServiceLineSelection__c> insertList = new list<CRM_EncounterServiceLineSelection__c>();
      map<string,CRM_EncounterServiceLineSelection__c> existingRecordMap = new map<string,CRM_EncounterServiceLineSelection__c>();
      
      for(CRM_EncounterServiceLineSelection__c slandssl : [select CRM_Encounter__c,CRM_AudienceCriteriaReferenceData__c from CRM_EncounterServiceLineSelection__c where CRM_Encounter__c=:enc.Id]){
        system.debug('****slandssl.CRM_AudienceCriteriaReferenceData__c=='+slandssl.CRM_AudienceCriteriaReferenceData__c);
        if(!existingRecordMap.containsKey(slandssl.CRM_AudienceCriteriaReferenceData__c))
          existingRecordMap.put(slandssl.CRM_AudienceCriteriaReferenceData__c,slandssl);
        
        if(!servicelineANDSSLIds.contains(slandssl.CRM_AudienceCriteriaReferenceData__c))
          deleteList.add(slandssl);
      }
      system.debug('*****deleteList='+deleteList);
      for(String str : servicelineANDSSLIds){
        if(!existingRecordMap.containsKey(str))
          insertList.add(new CRM_EncounterServiceLineSelection__c(CRM_Encounter__c=enc.Id,CRM_AudienceCriteriaReferenceData__c=str));
      }
      system.debug('*****insertList='+insertList);
      if(deleteList.size()>0)
        delete deleteList;
      
      if(insertList.size()>0)
        insert insertList;
      
    }
    // end of audience selection Service line and sub service  line change
    public void preparePiclistFields(){
      HospitalList = new list<SelectOption>();
       for(AggregateResult hlist: [select Hospital__c from Location__c where Hospital__c!= null group by Hospital__c order by Hospital__c asc]){
            HospitalList.add(new SelectOption((string)hlist.get('Hospital__c'),(string)hlist.get('Hospital__c')));
       }
    }
    
    public void prepareHospitalchosenPiclistFields(){ 
        ChosenHospitalList= new set<SelectOption>();
        string strQuery = 'SELECT Hospital__c FROM Location__c ';
        system.debug('###### Values Chosen Hospitals values ###### '+ enc.HospitalIds__c);
        
        String whereHos='(\''+enc.HospitalIds__c+'\')';
        
        whereHos = whereHos.replace(';' , '\',\'');
        whereHos = whereHos.replace(' ' , '');
        system.debug('###### Values whereHos ###### '+ whereHos);
        strQuery += ' WHERE HSPCD__c in ' + whereHos;
        system.debug('###### Values strQuery ###### '+ strQuery );
        SelectedHospitalName= Database.query(strQuery);
        system.debug('###### Values SelectedHospitalName ###### '+ SelectedHospitalName);
        
        for (Location__c h :SelectedHospitalName)
        {
        ChosenHospitalList.add(new SelectOption(h.Hospital__c ,h.Hospital__c) );
        }
        system.debug('###### Values ChosenHospitalList ###### '+ ChosenHospitalList);
        
        selectedHospitalList=new List<SelectOption>(ChosenHospitalList);
        system.debug('###### Values selectedHospitalList ###### '+ selectedHospitalList);
    }
    
    
    
    public pageReference addDRG(){
        
      //  pagereference ref;
      if(campaignId!=null && encounterid!=null){
          return new Pagereference('/apex/CampaignCriteria_DRGs?id='+ campaignId+'&encounter='+encounterid);
           // ref.setredirect(true);             
      }
      // return ref;
      else{
        return new PageReference('/apex/CampaignCriteria_DRGs?id='+campaignId);
      }
       
    }
    
    public pageReference excludeDRG()
    {
        
      //  pagereference ref;
        if(campaignId!=null && encounterid!=null)
        {
            return new Pagereference('/apex/CampaignCriteria_DRGs?id='+ campaignId+'&encounter='+encounterid+ '&exclude=true');
           // ref.setredirect(true);             
        }
       // return ref;
       else{
       return new PageReference('/apex/CampaignCriteria_DRGs?id='+campaignId+ '&exclude=true');
       }
       
    }
    
    Public PageReference AddIcd()
    {   if(encounterid!=null)
            {
        return new PageReference('/apex/CampaignCriteria_Diagnosis?id='+campaignId+ '&encounter='+encounterid);   
            }
     else{
         return new PageReference('/apex/CampaignCriteria_Diagnosis?id='+campaignId);
     }
    }
    
    Public PageReference ExcludeIcd()
    {   if(encounterid!=null)
            {
        return new PageReference('/apex/CampaignCriteria_Diagnosis?id='+campaignId+ '&encounter='+encounterid+ '&exclude=true');   
            }
     else{
         return new PageReference('/apex/CampaignCriteria_Diagnosis?id='+campaignId + '&exclude=true');
     }
    }
    
     Public PageReference IncludeProcedure()
    {   
        if(encounterid!=null)
        {
            return new PageReference('/apex/CampaignCriteria_Procedures?id='+campaignId+ '&encounter='+encounterid);   
        }
         else
         {
             return new PageReference('/apex/CampaignCriteria_Procedures?id='+campaignId);
         }
    }
    
     Public PageReference ExcludeProcedure()
    {   
        if(encounterid!=null)
        {
            return new PageReference('/apex/CampaignCriteria_Procedures?id='+campaignId+ '&encounter='+encounterid+ '&exclude=true');   
        }
         else
         {
             return new PageReference('/apex/CampaignCriteria_Procedures?id='+campaignId+ '&exclude=true');
         }
    }    
    
    
    public pagereference enc_back()
    {
        pagereference ref;
        if(campaignId!=null)
        {
            //start of PP4 chnage
        if(campObj.CRM_ParentSegmentedCampaign__c!=null){
            ref = new Pagereference('/apex/CampaignWizard?Id='+campaignId +'&stepNo=2');
            }
            else{
             ref = new Pagereference('/apex/CampaignWizard?Id='+campaignId +'&stepNo=3');
            }
            //end of PP4 chnage
            ref.setredirect(true);             
        }
        return ref;
    }
    
    public pagereference SaveEncounterCriteria()
    {
       // DetailPage = true;
       pagereference ref; 
       string strQuery;
       string HospitalField = null;
       set<String> HospitalVal = new set<String>();
       list<String> lstWhereLocCondition=new List<string>();
       system.debug('values selectedHospitalList'+ selectedHospitalList);
       strQuery = 'SELECT HSPCD__c FROM Location__c';
       list<String> Hospitalslines = new List<String>();
       
     //setup service line and sub service line criteria
       manageSLandSSL();
       
     /*  if(selectedHospitalList!=null){
                    system.debug('valueof selected list===='+ selectedHospitalList);
                    System.debug('--------i am in selectedHospitalList---------');
              
            try 
            {
                    for(selectOption s: selectedHospitalList)
                    {
                        System.debug('--------i am in selectedHospitalList for loop ---------');
                        system.debug('size of selected list===='+ selectedHospitalList.Size());
                        Hospitalslines.add(string.valueOf(s.getvalue()));                    
                    }
                    system.debug('#####string Hospitalslines selected list#####===='+ Hospitalslines);
                    text = String.valueOf(Hospitalslines).replace('(' , '(\'');
                    text1 = text.replace(')' , '\')');
                    text1 = text1.replace(', ' , '\',\'');                 
                    strQuery += ' WHERE Hospital__c in ' + text1;
                    
                    HosVal= String.valueOf(Hospitalslines).replace('(' , '');
                    HosVal= HosVal.replace(')' , '');
            
                    system.debug('##### valueof strQuery ##### ===='+ strQuery);
                    SelectedHospitalCode = Database.query(strQuery);
                    
                    system.debug('##### valueof SelectedHospitalCode  ##### ===='+ SelectedHospitalCode);
                    for( Location__c s :  SelectedHospitalCode) 
                    {
                    
                    system.debug('values SelectedHospitalCode '+ s.HSPCD__c );
                    
                    HospitalVal.add(string.valueOf(s.HSPCD__c ));
                    
                    }
                    system.debug('##### valueof HospitalVal ##### ===='+ HospitalVal);
                    system.debug('#### values HospitalVal list #### '+ HospitalCodes ); 
                    HospitalCodes = String.valueOf(HospitalVal).replace('(' , '');
                    HospitalCodes = HospitalCodes.replace(')' , '');
                    HospitalCodes = HospitalCodes.replace(',' , ';');
                    HospitalCodes = HospitalCodes.replace('{' , '');
                    HospitalCodes = HospitalCodes.replace('}' , '');
                    HospitalCodes = HospitalCodes.replaceAll( '\\s+', '');
                    system.debug('#### values HospitalCodes to insert #### '+ HospitalCodes );  
            
            }catch(Exception ex){ 
            
              System.debug(ex.getMessage() + ' at line' + ex.getLineNumber());
              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'There is some issue with this page. Please contact your system admin.'));
            }
            
       } */
        // save selected hospital codes in field on encounter  
       if(selectedHospitalCriteria!=null)
            {
        save_encounter_hospitalvalues();
        enc.CRM_SelectedHospitalCodes__c=string.join(selectedhospitalCodes,', ');
            system.debug('*****objcampaign.CRM_SelectedOwnershipCriteria__c'+ enc.CRM_SelectedHospitalCodes__c);
                for(string s : selectedhospitalCodes){
                     for(CRM_CampaignLocationReferenceData__c selhoscriteria : [select recordtype.name, CRM_isActive__C,   CRM_Hospital__c, CRM_HospitalMarket__c from CRM_CampaignLocationReferenceData__c where CRM_HospitalCode__c=:s ])
                {
                    Hosval.add(selhoscriteria.CRM_Hospital__c);
                }
                }
                System.debug('hosval list names@@@@@'+ Hosval);
          }
        /*** Save preffered hospital MultiSelect Picklist ***/
        for(integer i=0;i < SelectedPrefferedHospitalList.size();i++)
        {                
        if(HospitalField == null)
        HospitalField = SelectedPrefferedHospitalList[i].getValue();
        
        else
        HospitalField += ';'+SelectedPrefferedHospitalList[i].getValue();
        
        }
        // system.debug('size of available list after remove==========='+ AllSubServLines.Size());
        
        system.debug('######enc##' +enc);
        
        system.debug('######enc##' +encounterid);
        system.debug('###### selectedHospitalList Value #####' +selectedHospitalList.isEmpty()); 
        if(enc.Patient__c==null && enc.To_discharge_date_encounter__c==null && enc.Discharge_Date_encounter__c==null && enc.Discharge_Date__c==null && enc.Number_of_ER_Encounters_to__c==null && enc.Number_of_ER_Encounters__c==null  && enc.Hospital_IDs__c==null && enc.Payor_Type__c==null && enc.Include_Facility_ID__c==null && enc.Exclude_Facility_IDs__c==null && enc.Include_Physician_NPIs__c==null && enc.Exclude_Physician_NPIs__c==null && enc.ED_Flag__c==false && enc.Labor_and_Delivery_Flag__c==false && enc.Normal_Newborn_Flag__c==false && enc.Surgery_Flag__c==false && enc.Discharge_Date_To__c==null && selectedHospitalList.isEmpty()==true && encounterid==null)
       {
       system.debug('i am null encounter');
       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Please select atleast one field to save the record'));
       return null;
       } 
       
      
       if((enc.Number_of_ER_Encounters_to__c!=null && enc.Number_of_ER_Encounters__c==null) || (enc.Number_of_ER_Encounters_to__c==null && enc.Number_of_ER_Encounters__c!=null)){
           ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Please select range of encounter number'));
           return null;
       }
       if(enc.Number_of_ER_Encounters_to__c!=null && enc.Number_of_ER_Encounters__c!=null ){
       if(Integer.valueOf(enc.Number_of_ER_Encounters__c)>Integer.valueOf(enc.Number_of_ER_Encounters_to__c))
       {
        
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Invalid encounter number'));
           return null;
       } 
       
       if(Integer.valueOf(enc.Number_of_ER_Encounters_to__c)>999 || Integer.valueOf(enc.Number_of_ER_Encounters__c)>999)
        {
           // system.debug('i am in value selected method '+ Integer.valueOf(demo.to_age__c));
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Encounter cannot be greater than 999'));
           return null;
       } 
       
       }
       
       if(enc.Discharge_Date__c!=null && enc.Discharge_Date_To__c!=null ){
       if(enc.Discharge_Date__c>enc.Discharge_Date_To__c)
        {
        
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Invalid discharge date'));
       return null;
       } 
       
       
       }
        List<Encounter__c> existingValues = new List<Encounter__c>();
        Encounter__c objexistingValues = new Encounter__c ();
        Date dto = enc.To_discharge_date_encounter__c;
        Date dfrom = enc.Discharge_Date_encounter__c;  
        String DischargeDateTo;
        String DischargeDateFrom;
        String dischargeDateRange;
        if(dto!=null)
        DischargeDateTo = DateTime.newInstance(dto.year(),dto.month(),dto.day()).format('YYYYMMdd');
        if(dfrom!=null)
        DischargeDateFrom = DateTime.newInstance(dfrom.year(),dfrom.month(),dfrom.day()).format('YYYYMMdd');
        if(DischargeDateTo!=null && DischargeDateFrom!=null)
        dischargeDateRange = DischargeDateFrom+'-'+DischargeDateTo ;
        Enc.Discharge_Date_Ranges__c = dischargeDateRange;
        System.debug('*********dischargeDateRange*********'+dischargeDateRange);
        // start of hospital change
         if(!selectedhospitalCodes.isEmpty())
            enc.HospitalIds__c =  string.join(selectedhospitalCodes,';');
        else
             enc.HospitalIds__c = null;
        
        // end of hospital change
        
        if (enc.Include_Facility_ID__c!=null)
        {
            enc.Include_Facility_ID__c=enc.Include_Facility_ID__c.replace(',' , ';'); 
             enc.Include_Facility_ID__c= enc.Include_Facility_ID__c.replaceAll( '\\s+', '');  
             }
        if (enc.Exclude_Facility_IDs__c!=null)  
        {
            enc.Exclude_Facility_IDs__c =enc.Exclude_Facility_IDs__c.replace(',' , ';');
            
         enc.Exclude_Facility_IDs__c = enc.Exclude_Facility_IDs__c .replaceAll( '\\s+', '');
         }
        if (enc.Exclude_Physician_NPIs__c!=null) 
        {
            enc.Exclude_Physician_NPIs__c=enc.Exclude_Physician_NPIs__c.replace(',' , ';');
              enc.Exclude_Physician_NPIs__c= enc.Exclude_Physician_NPIs__c.replaceAll( '\\s+', '');
              }
              
        if (enc.Include_Physician_NPIs__c!=null)
        {
            enc.Include_Physician_NPIs__c=enc.Include_Physician_NPIs__c.replace(',' , ';');
        
           enc.Include_Physician_NPIs__c= enc.Include_Physician_NPIs__c.replaceAll( '\\s+', '');
        }
       
        
        if(enc.Number_of_ER_Encounters__c!=null && enc.Number_of_ER_Encounters_to__c!=null)
            enc.No_of_ER_Encounters_ranges__c =  enc.Number_of_ER_Encounters__c + '-' + enc.Number_of_ER_Encounters_to__c;
        
        existingValues = [SELECT Wunderman_Preferred_Hospitals__c,Hospital_Names__c,HospitalIds__c,Discharge_Date_encounter__c, To_discharge_date_encounter__c, Campaign__c,
                          Discharge_Date_To__c,Discharge_Date__c,ED_Flag__c,Exclude_Facility_IDs__c,Exclude_Physician_NPIs__c,
                          Hospital_IDs__c,Include_Facility_ID__c,Include_Physician_NPIs__c,Attending_NPIs__c,Admitting_NPIs__c,
                          Primary_NPIs__c,Labor_and_Delivery_Flag__c,Patient__c,Normal_Newborn_Flag__c,
                          Number_of_ER_Encounters_to__c,Number_of_ER_Encounters__c,Payor_Type__c,
                          Discharge_Date_Ranges__c,Surgery_Flag__c,No_of_ER_Encounters_ranges__c,
                          CRM_ServiceLine__c,CRM_SubServiceLine__c,CRM_SelectedHospitalCodes__c FROM Encounter__c WHERE Campaign__c=:campaignId];
                          
        if(existingValues.size()>0)
           objexistingValues = existingValues[0];
           
        Campaign objCampaignForAPI;
        list<Campaign> lstCampaign = [SELECT LIST_ORDER_SELECT_GRP_ID__c,Wunderman_Sync__c FROM Campaign WHERE id=:campaignId];
        
        if(lstCampaign.size()>0) objCampaignForAPI = lstCampaign[0];
        Map<String, Map<String, String>> mapApiNameswithValues = new Map<String, Map<String, String>> ();
        System.debug('***********objexistingValues*******'+objexistingValues+'***********enc******'+enc);
        mapApiNameswithValues  = FieldsInfoManager.GetFieldsInfoInsert('Encounter__c', objexistingValues,  enc);
        
        System.debug('*******mapApiNameswithValues1******'+mapApiNameswithValues);
        if(mapApiNameswithValues!=null)
        {
            objCampaignForAPI.Wunderman_Sync__c = 'Pending';
            update objCampaignForAPI;
            System.debug('*******mapApiNameswithValues2******'+mapApiNameswithValues);
        }
        
        boolean hasFacilityChange = false;
        for(String s : mapApiNameswithValues.keyset()) 
        {
            if(mapApiNameswithValues.get(s).containsKey('Include_Facility_ID__c')) 
            {
                mapApiNameswithValues.get(s).remove('Include_Facility_ID__c');
                hasFacilityChange = true;
                 System.debug('*******mapApiNameswithValues3******'+mapApiNameswithValues);
            }
            if(mapApiNameswithValues.get(s).containsKey('HospitalIds__c')) 
            {
                mapApiNameswithValues.get(s).remove('HospitalIds__c');
                hasFacilityChange = true;
                 System.debug('*******mapApiNameswithValues4******'+mapApiNameswithValues);
            }
        }
        
        if(hasFacilityChange)
        {
            string facilityIds = '';
            if(enc.Include_Facility_ID__c!= null)
                facilityIds = enc.Include_Facility_ID__c;
            if(enc.HospitalIds__c!= null)
            {
                if(facilityIds == '')
                    facilityIds = enc.HospitalIds__c;
                else
                {
                    for(string hospitalId: enc.HospitalIds__c.split(';'))
                    {
                        if(!facilityIds.contains(hospitalId))
                            facilityIds += ';' + hospitalId;
                    }
                }
            }
            system.debug('facilityIds:' + facilityIds);
            system.debug('mapApiNameswithValues:' + mapApiNameswithValues);
            if(facilityIds ==  '' )
            {
                if(objexistingValues.Include_Facility_ID__c!=null || objexistingValues.HospitalIds__c!=null)
                {
                    if(!mapApiNameswithValues.containsKey('Delete'))
                        mapApiNameswithValues.put('Delete', new Map<string,string>());
                    mapApiNameswithValues.get('Delete').put('Facility_ID__c', facilityIds);
                }
            }
            else
            {
                if(objexistingValues.Include_Facility_ID__c!=null || objexistingValues.HospitalIds__c!=null)
                {
                    if(!mapApiNameswithValues.containsKey('Update'))
                        mapApiNameswithValues.put('Update', new Map<string,string>());
                    mapApiNameswithValues.get('Update').put('Facility_ID__c', facilityIds);
                }
                else
                {
                    if(!mapApiNameswithValues.containsKey('Insert'))
                        mapApiNameswithValues.put('Insert', new Map<string,string>());
                    mapApiNameswithValues.get('Insert').put('Facility_ID__c', facilityIds);
                }
            }
        }
        for(String s : mapApiNameswithValues.keyset()) 
        {
         System.debug('*******mapApiNameswithValues6******'+mapApiNameswithValues);
            Map<string, string> excludeCriteriasMap = new Map<string, string>();
            if(mapApiNameswithValues.get(s).containsKey('Exclude_Facility_IDs__c'))
            {
                excludeCriteriasMap.put('Facility_ID__c', mapApiNameswithValues.get(s).get('Exclude_Facility_IDs__c'));
                mapApiNameswithValues.get(s).remove('Exclude_Facility_IDs__c');
            } 
            if(mapApiNameswithValues.get(s).containsKey('Include_Physician_NPIs__c'))
            {
                string includeNPIs = mapApiNameswithValues.get(s).get('Include_Physician_NPIs__c');
                mapApiNameswithValues.get(s).put('Primary_NPIs__c', includeNPIs);
                mapApiNameswithValues.get(s).put('Admitting_NPIs__c', includeNPIs);
                mapApiNameswithValues.get(s).put('Attending_NPIs__c', includeNPIs);
                mapApiNameswithValues.get(s).remove('Include_Physician_NPIs__c');
            } 
            if(mapApiNameswithValues.get(s).containsKey('Exclude_Physician_NPIs__c'))
            {
                string excludeNPIs = mapApiNameswithValues.get(s).get('Exclude_Physician_NPIs__c');
                excludeCriteriasMap.put('Primary_NPIs__c', excludeNPIs);
                excludeCriteriasMap.put('Admitting_NPIs__c', excludeNPIs);
                excludeCriteriasMap.put('Attending_NPIs__c', excludeNPIs);
                mapApiNameswithValues.get(s).remove('Exclude_Physician_NPIs__c');
            }
            /*if(mapApiNameswithValues.get(s).containsKey('HospitalIds__c'))
            {
                if(s == 'Insert' || s == 'Update')
                {
                    string hospitalIds = mapApiNameswithValues.get(s).get('HospitalIds__c');
                    if(!(mapApiNameswithValues.get('Insert').containsKey('Facility_ID__c') || mapApiNameswithValues.get('Update').containsKey('Facility_ID__c')))
                    {
                        mapApiNameswithValues.get(s).put('Facility_ID__c', hospitalIds);
                    else
                    {
                        mapApiNameswithValues.get(s).put('Facility_ID__c', mapApiNameswithValues.get(s).get('Facility_ID__c') + ',' + hospitalIds);
                        mapApiNameswithValues.get(s).remove('HospitalIds__c');
                    }
                }
                else if(s == 'Delete')
                {
                    if(!(mapApiNameswithValues.get('Insert').containsKey('Facility_ID__c') || mapApiNameswithValues.get('Update').containsKey('Facility_ID__c') || mapApiNameswithValues.get('Delete').containsKey('Facility_ID__c')))
                    {
                        if(objexistingValues.Include_Facility_ID__c==null)
                            mapApiNameswithValues.get('Delete').put('Facility_ID__c', null);
                        else
                            mapApiNameswithValues.get('Update').put('Facility_ID__c', objexistingValues.Include_Facility_ID__c);
                    }   
                    mapApiNameswithValues.get(s).remove('HospitalIds__c');
                }
            }*/
            
            System.debug('*******mapApiNameswithValues.get(s)******'+mapApiNameswithValues.get(s));
            System.debug('*******excludeCriteriasMap******'+excludeCriteriasMap);
        
            if(s == 'Insert') 
            {
            System.debug('*******excludeCriteriasMap******'+mapApiNameswithValues.get(s));
            System.debug('*******campaignId******'+campaignId);
            
                CampaignMemberCriteriaManager.insertCriterias(mapApiNameswithValues.get(s),campaignId, false, 'Encounter__c');
                System.debug('*******excludeCriteriasMap******'+!excludeCriteriasMap.isEmpty());
                if(excludeCriteriasMap.size()>0 )
                    CampaignMemberCriteriaManager.insertCriterias(excludeCriteriasMap,campaignId, true, 'Encounter__c');
                     System.debug('*******excludeCriteriasMap******'+!excludeCriteriasMap.isEmpty());
        
            }
            else if(s == 'Update') 
            {
                CampaignMemberCriteriaManager.updateCriterias(mapApiNameswithValues.get(s),campaignId, false);
                if(excludeCriteriasMap.size()>0)
                    CampaignMemberCriteriaManager.updateCriterias(excludeCriteriasMap,campaignId, true);
            }
            else if(s == 'Delete') 
            {
                CampaignMemberCriteriaManager.deleteCriterias(mapApiNameswithValues.get(s),campaignId, false);
                if(excludeCriteriasMap.size()>0)
                    CampaignMemberCriteriaManager.deleteCriterias(excludeCriteriasMap,campaignId, true);
            }
        }
        CampaignMemberCriteriaManager.setAddonExclusionCriterias(campaignId);
             
        if (encounterid==null && button==1){ 
          DetailPage = true;
        
          system.debug('####### SelectedHospitalName save #######========' + SelectedHospitalName);
            system.debug('campaign id in lifestyle method========' + enc);
            enc.Campaign__c=campaignId; 
            enc.Hospital_Names__c=string.join(HosVal,', ');                  
            upsert enc;
               
             /* WundermanAPICallouts insertAPI = new WundermanAPICallouts();
          insertAPI.InsertCriteriaEncounter(enc.id);*/
        }else{
          
          system.debug('####### SelectedHospitalName save #######========' + SelectedHospitalName);
          enc.Hospital_Names__c=string.join(HosVal,', ');      
            update enc; 
            system.debug('values AfterSaveEnc'+ enc);             
            
            /* WundermanAPICallouts insertAPI = new WundermanAPICallouts();
          insertAPI.InsertCriteriaEncounter(enc.id); */          
            
        }
         
        ref = new Pagereference('/apex/EncountersPage?Id='+campaignId+'&btn='+button  +'&encounter='+enc.id);
        ref.setredirect(true);
        
       if(enc.id!=null){
             manageRefrenceData();//This method will create/update/delte data from junction obejct for SL and SSL
            HospitalJunctionEncounterData(); //This method will create/update/delte data from junction obejct for include hospital fields
        }
        return ref;
    }
    
    public pagereference SaveEncounterAggregatesCriteria()
    {
       // DetailPage = true;
        pagereference ref; 
         String strQuery;
          
        set<String> PrefHospitalVal = new set<String>();
        List<String> lstWhereLocCondition=new List<string>();
       // system.debug('values selectedHospitalList'+ selectedHospitalList);
        strQuery = 'SELECT HSPCD__c FROM Location__c';
         List<String> PreferredHospitalslines = new List<String>();
        
        
     //start of hospital change
       if(selectedPrefferedHospitalCriteria!=null)
            {
        save_encounteragg_hospitalvalues();
        encagg.CRM_SelectedPreferedHospitalCodes__c=string.join(selectedpreferedhospitalCodes,', ');
            system.debug('*****objcampaign.CRM_SelectedOwnershipCriteria__c'+ encagg.CRM_SelectedPreferedHospitalCodes__c);
                for(string s : selectedpreferedhospitalCodes){
                     for(CRM_CampaignLocationReferenceData__c selhoscriteria : [select recordtype.name, CRM_isActive__C,   CRM_Hospital__c, CRM_HospitalMarket__c from CRM_CampaignLocationReferenceData__c where CRM_HospitalCode__c=:s ])
                {
                    HospitalField.add(selhoscriteria.CRM_Hospital__c);
                }
                }
                System.debug('HospitalField list names@@@@@'+ HospitalField);
          }
     
        // system.debug('size of available list after remove==========='+ AllSubServLines.Size());
         encagg.Preffered_Hospital__c = string.join(HospitalField,', ');
      // end of hospital change  
        
        
         if(SelectedPrefferedHospitalList!=null )
       {
                    system.debug('valueof selected list===='+ SelectedPrefferedHospitalList);
                    System.debug('--------i am in selectedHospitalList---------');
              
              try 
            {
                    for(selectOption s: SelectedPrefferedHospitalList)
                    {
                    System.debug('--------i am in SelectedPrefferedHospitalListfor loop ---------');
                    system.debug('size of selected list===='+ SelectedPrefferedHospitalList.Size());
                    PreferredHospitalslines.add(string.valueOf(s.getvalue()));                    
                    }
                    system.debug('#####string Hospitalslines selected list#####===='+ PreferredHospitalslines );
                    text = String.valueOf(PreferredHospitalslines).replace('(' , '(\'');
                    text1 = text.replace(')' , '\')');
                    text1 = text1.replace(', ' , '\',\'');                 
                    strQuery += ' WHERE Hospital__c in ' + text1;
                    
                    PrefHosVal= String.valueOf(PreferredHospitalslines).replace('(' , '');
                    PrefHosVal= PrefHosVal.replace(')' , '');
            
           
            
            
                    system.debug('##### valueof strQuery ##### ===='+ strQuery);
                    SelectedPreferredHospitalCode= Database.query(strQuery);
                    
                    system.debug('##### valueof SelectedPreferredHospitalCode##### ===='+ SelectedPreferredHospitalCode);
                    for( Location__c s :  SelectedPreferredHospitalCode) 
                    {
                    
                    system.debug('values SelectedPreferredHospitalCode'+ s.HSPCD__c );
                    
                    PrefHospitalVal.add(string.valueOf(s.HSPCD__c ));
                    
                    }
                    system.debug('##### valueof HospitalVal ##### ===='+ PrefHospitalVal );
                    system.debug('#### values HospitalVal list #### '+ PrefHodpitalCodes); 
                    PrefHodpitalCodes= String.valueOf(PrefHospitalVal).replace('(' , '');
                    PrefHodpitalCodes= PrefHodpitalCodes.replace(')' , '');
                    PrefHodpitalCodes= PrefHodpitalCodes.replace(',' , ';');
                    PrefHodpitalCodes= PrefHodpitalCodes.replace('{' , '');
                    PrefHodpitalCodes= PrefHodpitalCodes.replace('}' , '');
                    PrefHodpitalCodes= PrefHodpitalCodes.replaceAll( '\\s+', '');
                    system.debug('#### values HospitalCodes to insert #### '+ PrefHodpitalCodes);  
            
            
            
            
            
            }
            catch(Exception ex) 
            { 
            
            System.debug(ex.getMessage() + ' at line' + ex.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'There is some issue with this page. Please contact your system admin.'));
            }
            
       }
        
        
        
        
        system.debug('###### selectedHospitalList Value #####' +selectedHospitalList.isEmpty()); 
        if(encagg.Last_Discharge_Date_From_UI__c==null && encagg.Last_Discharge_Date_To_UI__c==null && encagg.Most_Recent_Primary_Payor_Type__c==null && encagg.Number_of_ER_Encounters__c==null && encagg.Number_of_ER_Encounters_To__c==null && encagg.Preffered_Hospital__c==null && selectedHospitalList.isEmpty()==true && encounteraggid==null)
       {
       system.debug('i am null encounter');
       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Please select atleast one field to save the record'));
       return null;
       } 
       
      
       if((encagg.Number_of_ER_Encounters_To__c!=null && encagg.Number_of_ER_Encounters__c==null) || (encagg.Number_of_ER_Encounters_To__c==null && encagg.Number_of_ER_Encounters__c!=null)){
           ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Please select range of encounter number'));
           return null;
       }
       if(encagg.Number_of_ER_Encounters_To__c!=null && encagg.Number_of_ER_Encounters__c!=null ){
       if(Integer.valueOf(encagg.Number_of_ER_Encounters__c)>Integer.valueOf(encagg.Number_of_ER_Encounters_To__c))
        {
        
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Invalid encounter number'));
       return null;
       } 
       
       if(Integer.valueOf(encagg.Number_of_ER_Encounters_To__c)>999 || Integer.valueOf(encagg.Number_of_ER_Encounters__c)>999)
        {
       // system.debug('i am in value selected method '+ Integer.valueOf(demo.to_age__c));
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Encounter cannot be greater than 999'));
       return null;
       } 
       
       }
       
       if(encagg.Last_Discharge_Date_From_UI__c!=null && encagg.Last_Discharge_Date_To_UI__c!=null ){
       if(encagg.Last_Discharge_Date_From_UI__c>encagg.Last_Discharge_Date_To_UI__c)
        {
        
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Invalid discharge date'));
       return null;
       } 
       
       
       }
        List<Encounter_aggregates__c> existingValues = new List<Encounter_aggregates__c>();
        Encounter_aggregates__c objexistingValues = new Encounter_aggregates__c();
        Date dto = encagg.Last_Discharge_Date_To_UI__c;
        Date dfrom = encagg.Last_Discharge_Date_From_UI__c;  
        String LastDischargeDateTo;
        String LastDischargeDateFrom;
        String LastdischargeDateRange;
        if(dto!=null)
        LastDischargeDateTo= DateTime.newInstance(dto.year(),dto.month(),dto.day()).format('YYYYMMdd');
        if(dfrom!=null)
        LastDischargeDateFrom= DateTime.newInstance(dfrom.year(),dfrom.month(),dfrom.day()).format('YYYYMMdd');
         if(LastDischargeDateTo!=null && LastDischargeDateFrom!=null)
        {LastdischargeDateRange= LastDischargeDateFrom+'-'+LastDischargeDateTo;
        }
        else
        {
        LastdischargeDateRange=null;
        }
        Encagg.Last_Discharge_Date_Ranges__c = LastdischargeDateRange;
        System.debug('*********LastdischargeDateRange*********'+LastdischargeDateRange);
        //start of hospital change
        if(!selectedpreferedhospitalCodes.isEmpty())
            encagg.Wunderman_Preferred_Hospitals__c = string.join(selectedpreferedhospitalCodes,';');
        else
             encagg.Wunderman_Preferred_Hospitals__c = null;
        
        // end of hospital change
        if(encagg.Number_of_ER_Encounters__c!=null && encagg.Number_of_ER_Encounters_To__c!=null)
            encagg.No_of_ER_Encounters_ranges__c =  encagg.Number_of_ER_Encounters__c + '-' + encagg.Number_of_ER_Encounters_To__c;
        else
           encagg.No_of_ER_Encounters_ranges__c =null;
        existingValues = [SELECT Wunderman_Preferred_Hospitals__c,Last_Discharge_Date_From_UI__c, Last_Discharge_Date_To_UI__c,Campaign__c,Last_Discharge_Date_Criteria_Element_Id__c ,
                         Number_of_ER_Encounters_To__c,Number_of_ER_Encounters__c,Most_Recent_Primary_Payor_Type__c,
                         Preffered_Hospital__c, CRM_SelectedPreferedHospitalCodes__c,Last_Discharge_Date_Ranges__c,No_of_ER_Encounters_ranges__c FROM Encounter_aggregates__c WHERE Campaign__c=:campaignId];
        if(existingValues.size()>0)
           objexistingValues = existingValues[0];
         Campaign objCampaignForAPI;
        List<Campaign> lstCampaign = [SELECT LIST_ORDER_SELECT_GRP_ID__c,Wunderman_Sync__c FROM Campaign WHERE id=:campaignId];
        if(lstCampaign.size()>0) objCampaignForAPI = lstCampaign[0];
        Map<String, Map<String, String>> mapApiNameswithValues = new Map<String, Map<String, String>> ();
        mapApiNameswithValues  = FieldsInfoManager.GetFieldsInfoInsert('Encounter_aggregates__c', objexistingValues,  encagg);
        System.debug('*******mapApiNameswithValues******'+mapApiNameswithValues);
        if(mapApiNameswithValues!=null)
        {
            objCampaignForAPI.Wunderman_Sync__c = 'Pending';
            update objCampaignForAPI;
        }
        for(String s : mapApiNameswithValues.keyset()) {
            if(s == 'Insert') CampaignMemberCriteriaManager.insertCriterias(mapApiNameswithValues.get(s),campaignId, false, 'Encounter_aggregates__c');
            else if(s == 'Update') CampaignMemberCriteriaManager.updateCriterias(mapApiNameswithValues.get(s),campaignId, false);
            else if(s == 'Delete') CampaignMemberCriteriaManager.deleteCriterias(mapApiNameswithValues.get(s),campaignId, false);
            
        }
             
        if ( encounteraggid==null && button==8)
        { DetailPage = true;
        
      //  system.debug('####### SelectedHospitalName save #######========' + SelectedHospitalName);
            system.debug('campaign id in lifestyle method========' + encagg);
            encagg.Campaign__c=campaignId; 
           // encagg.Hospital_Names__c=HosVal;         
            upsert encagg; 
            ref = new Pagereference('/apex/EncountersPage?Id='+campaignId+'&btn='+button  +'&encounteraggregates='+encagg.id);
            ref.setredirect(true);   
             /* WundermanAPICallouts insertAPI = new WundermanAPICallouts();
        insertAPI.InsertCriteriaEncounter(enc.id);*/
        }
        else 
        {
      //  system.debug('####### SelectedHospitalName save #######========' + SelectedPrefferedHospitalList);
        
         //  enc.Hospital_Names__c=HosVal;
            update encagg; 
            system.debug('values AfterSaveEnc'+ encagg);             
            ref = new Pagereference('/apex/EncountersPage?Id='+campaignId+'&btn='+button  +'&encounteraggregates='+encagg.id);
            ref.setredirect(true);  
            
            /* WundermanAPICallouts insertAPI = new WundermanAPICallouts();
        insertAPI.InsertCriteriaEncounter(enc.id); */          
            
        } 
         if(encagg.id!=null){
           
            HospitalJunctionEncounterAggregatesData(); //This method will create/update/delte data from junction obejct for encounter aggregates prefered hospital fields
        }
        return ref;
    }
    
    
    public pagereference LifeStyleSave()
    {
        pagereference ref; 
        
        if(lf.Aches_and_Pain_AGPAIN__c==false && lf.Ailment_Present_Any__c==false && lf.Allergies_and_Sinuses_AGNOSE__c==false && lf.Cancer_AGCANCER__c==false  && lf.Cholesterol_and_Blood_Pressure_AGBLOOD__c==false && lf.Diabetes_AGDIAB__c==false && lf.Digestive_AGDIG__c==false && lf.Do_It_Yourself__c==false && lf.Female_Conditions_AGFEM__c==false && lf.Fine_Arts__c==false && lf.Foot_AGFOOT__c==false && lf.Health_Index_Manage_Illness_Condition_Fr__c==null &&
                lf.Health_Index_Illness_or_Condition_To__c==null &&  lf.Health_Index_Illness_or_Condition_To__c==null && lf.Health_Index_Manage_Bus_of_Health__c==null && lf.Health_Index_Manage_Bus_of_Health_To__c==null && lf.Health_Index_Manage_Health_From__c==null && lf.Health_Index_Manage_Health_To__c==null && lf.Health_Index_Wear_Dev_to_Manage_Health__c==null && lf.Health_Index_Wear_Dev_to_Manage_Health_T__c==null && lf.Health_Ins_Direct_Pay_Index_From__c==null && lf.Health_Ins_Direct_Pay_Index_To__c==null &&  lf.Health_Ins_Engagement_Index_From__c==null && lf.Health_Ins_Engagement_Index_To__c==null && lf.Health_Ins_Influence_Index_From__c==null && lf.Health_Ins_Influence_Index_To__c==null && lf.Heart_Condition_AGHEART__c==false && lf.Home_Life__c==false && lf.Joint_Spine_AGJOINT__c==false && lf.Luxury_Life__c==false && lf.Male_Conditions_AGMALE__c==false && lf.Mobility_Problems_and_Assistance_AGAST__c==false && lf.Health_Ins_Subsidy_Ind__c==null && lf.Healthcare_Treatment_Pref__c==null &&
                lf.Mouth_and_Teeth_AGMOUTH__c==false && lf.Health_Ins_Prem_Tolerance_Index__c==null && lf.Health_Ins_Prem_Tolerance_Index_to__c==null && lf.Medicare_Supplement_Ins_Rspnder_Idx_from__c==null && lf.Medicare_Supplement_Ins_Rspnder_Idx_to__c==null && lf.Outdoor_Enthusiasts__c==false && lf.Physically_Active__c==false && lf.Progressive_Conditions_AGPROG__c==false && lf.Psychological_Behavioral_AGPSYCO__c==false  && lf.Respiratory_AGRESP__c==false && lf.Skin_AGSKIN__c==false && lf.Sports_Enthusiasts__c==false && lf.Techies__c==false && lf.Up_Town__c==false && lf.Urinary_Bowel_AGURINAR__c==false && lf.Vision_AGVSN__c==false && lf.Weight_AGWEIGHT__c==false && Lifeid==null 
                && lf.CRM_Living_Well__c == null && lf.Uninsured_Index__c==null && lf.Uninsured_Index_to__c==null ) // Added for Audience Selection criteria story and uninsured index 
        {
        system.debug('in null lifestyle');
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Please select atleast one field to save the record'));
       return null;
       } 
       
        system.debug('*********** Health_Index_Manage_Illness_Condition_Fr__c****'+lf.Health_Index_Manage_Illness_Condition_Fr__c);
        system.debug('*********** Health_Index_Illness_or_Condition_To__c****'+lf.Health_Index_Illness_or_Condition_To__c);
        
       if(lf.Health_Index_Manage_Illness_Condition_Fr__c!=null&& lf.Health_Index_Illness_or_Condition_To__c!=null ){
       if(Integer.valueOf(lf.Health_Index_Manage_Illness_Condition_Fr__c)>Integer.valueOf(lf.Health_Index_Illness_or_Condition_To__c))
        {
        
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Invalid Index ranges'));
       return null;
       } 
      
       }
       
       if(lf.Health_Index_Manage_Health_From__c!=null && lf.Health_Index_Manage_Health_To__c!=null){
       if(Integer.valueOf(lf.Health_Index_Manage_Health_From__c)>Integer.valueOf(lf.Health_Index_Manage_Health_To__c))
        {
        
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Invalid Index ranges'));
       return null;
       } 
      }
       
       
       if(lf.Health_Ins_Direct_Pay_Index_From__c!=null && lf.Health_Ins_Direct_Pay_Index_To__c!=null){
       if(Integer.valueOf(lf.Health_Ins_Direct_Pay_Index_From__c)>Integer.valueOf(lf.Health_Ins_Direct_Pay_Index_To__c))
        {
        
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Invalid Index ranges'));
       return null;
       } 
       }
       
       
       if(lf.Health_Ins_Influence_Index_From__c!=null && lf.Health_Ins_Influence_Index_To__c!=null){
       if(Integer.valueOf(lf.Health_Ins_Influence_Index_From__c)>Integer.valueOf(lf.Health_Ins_Influence_Index_To__c))
        {
        
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Invalid Index ranges'));
       return null;
       } 
       }
       
       
       if(lf.Health_Index_Manage_Bus_of_Health__c!=null && lf.Health_Index_Manage_Bus_of_Health_To__c!=null){
       if(Integer.valueOf(lf.Health_Index_Manage_Bus_of_Health__c)>Integer.valueOf(lf.Health_Index_Manage_Bus_of_Health_To__c))
        {
        
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Invalid Index ranges'));
       return null;
       } 
       }
       
       
       if(lf.Health_Index_Wear_Dev_to_Manage_Health__c!=null && lf.Health_Index_Wear_Dev_to_Manage_Health_T__c!=null){
       if(Integer.valueOf(lf.Health_Index_Wear_Dev_to_Manage_Health__c)>Integer.valueOf(lf.Health_Index_Wear_Dev_to_Manage_Health_T__c))
        {
        
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Invalid Index ranges'));
       return null;
       } 
       }
       
       
       if(lf.Health_Ins_Engagement_Index_From__c!=null && lf.Health_Ins_Engagement_Index_To__c!=null){
       if(Integer.valueOf(lf.Health_Ins_Engagement_Index_From__c)>Integer.valueOf(lf.Health_Ins_Engagement_Index_To__c))
        {
        
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Invalid Index ranges'));
       return null;
       } 
       }
       
       
       if(lf.Health_Ins_Prem_Tolerance_Index__c!=null && lf.Health_Ins_Prem_Tolerance_Index_to__c!=null){
       if(Integer.valueOf(lf.Health_Ins_Prem_Tolerance_Index__c)>Integer.valueOf(lf.Health_Ins_Prem_Tolerance_Index_to__c))
        {
        
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Invalid Index ranges'));
       return null;
       } 
       }
       
       //Defect -Uninsured_Index__c and Medicare_Supplement_Ins_Rspnder validation 
       
       if(lf.Uninsured_Index__c!=null && lf.Uninsured_Index_to__c!=null){
       if(Integer.valueOf(lf.Uninsured_Index__c)>Integer.valueOf(lf.Uninsured_Index_to__c))
        {
        
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Invalid Index ranges'));
       return null;
       } 
       }
       else if ( (lf.Uninsured_Index__c==null && lf.Uninsured_Index_to__c!=null )|| (lf.Uninsured_Index__c!=null && lf.Uninsured_Index_to__c==null))
       {
       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Invalid Index ranges'));
       return null;
       }
       
       
       
       if(lf.Medicare_Supplement_Ins_Rspnder_Idx_from__c!=null && lf.Medicare_Supplement_Ins_Rspnder_Idx_to__c!=null){
       if(Integer.valueOf(lf.Medicare_Supplement_Ins_Rspnder_Idx_from__c)>Integer.valueOf(lf.Medicare_Supplement_Ins_Rspnder_Idx_to__c) )
        {
        
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Invalid Index ranges'));
       return null;
       } 
       }
       else if ( (lf.Medicare_Supplement_Ins_Rspnder_Idx_from__c==null && lf.Medicare_Supplement_Ins_Rspnder_Idx_to__c!=null )|| (lf.Medicare_Supplement_Ins_Rspnder_Idx_from__c!=null && lf.Medicare_Supplement_Ins_Rspnder_Idx_to__c==null))
       {
       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Invalid Index ranges'));
       return null;
       }
       
       
       //Defect -Uninsured_Index__c and Medicare_Supplement_Ins_Rspnder validation 
       
       if(lf.Health_Index_Manage_Illness_Condition_Fr__c!=null && lf.Health_Index_Illness_or_Condition_To__c!=null)  
          lf.Health_Index_Manage_Illness_Cond_ranges__c =  lf.Health_Index_Manage_Illness_Condition_Fr__c + '-' + lf.Health_Index_Illness_or_Condition_To__c;
       else 
           lf.Health_Index_Manage_Illness_Cond_ranges__c = null;
           
       if(lf.Health_Index_Manage_Bus_of_Health__c!=null && lf.Health_Index_Manage_Bus_of_Health_To__c!=null)  
          lf.Health_Index_Manage_Bus_of_Health_ranges__c=  lf.Health_Index_Manage_Bus_of_Health__c+ '-' + lf.Health_Index_Manage_Bus_of_Health_To__c;
       else 
           lf.Health_Index_Manage_Bus_of_Health_ranges__c= null;
           
       if(lf.Health_Index_Manage_Health_From__c!=null && lf.Health_Index_Manage_Health_To__c!=null)  
          lf.Health_Index_Manage_Health_ranges__c =  lf.Health_Index_Manage_Health_From__c+ '-' + lf.Health_Index_Manage_Health_To__c;
       else 
           lf.Health_Index_Manage_Health_ranges__c = null;
           
       if(lf.Health_Index_Wear_Dev_to_Manage_Health__c!=null && lf.Health_Index_Wear_Dev_to_Manage_Health_T__c!=null)  
          lf.Health_Index_Weardevto_managehealth_rang__c=  lf.Health_Index_Wear_Dev_to_Manage_Health__c+ '-' + lf.Health_Index_Wear_Dev_to_Manage_Health_T__c;
       else 
           lf.Health_Index_Weardevto_managehealth_rang__c= null;
           
       if(lf.Health_Ins_Direct_Pay_Index_From__c!=null && lf.Health_Ins_Direct_Pay_Index_To__c!=null)  
          lf.Health_Ins_Pay_Index_ranges__c=  lf.Health_Ins_Direct_Pay_Index_From__c+ '-' + lf.Health_Ins_Direct_Pay_Index_To__c;
      else 
           lf.Health_Ins_Pay_Index_ranges__c = null;
           
       if(lf.Health_Ins_Engagement_Index_From__c!=null && lf.Health_Ins_Engagement_Index_To__c!=null)  
          lf.Health_ins_engagement_index_ranges__c=  lf.Health_Ins_Engagement_Index_From__c+ '-' + lf.Health_Ins_Engagement_Index_To__c;
          
       else 
           lf.Health_ins_engagement_index_ranges__c = null;
           
       if(lf.Health_Ins_Influence_Index_From__c!=null && lf.Health_Ins_Influence_Index_To__c!=null)  
          lf.Health_ins_influence_index_ranges__c=  lf.Health_Ins_Influence_Index_From__c+ '-' + lf.Health_Ins_Influence_Index_To__c;
       else 
           lf.Health_ins_influence_index_ranges__c = null;
           
       if(lf.Health_Ins_Prem_Tolerance_Index__c!=null && lf.Health_Ins_Prem_Tolerance_Index_to__c!=null)  
          lf.Health_ins_prem_tolerance_index_ranges__c=  lf.Health_Ins_Prem_Tolerance_Index__c+ '-' + lf.Health_Ins_Prem_Tolerance_Index_to__c;
       else 
           lf.Health_ins_prem_tolerance_index_ranges__c= null;
           
       if(lf.Medicare_Supplement_Ins_Rspnder_Idx_from__c!=null && lf.Medicare_Supplement_Ins_Rspnder_Idx_to__c!=null)  
          lf.Medicare_supplement_ins_respond_ind_rang__c=  lf.Medicare_Supplement_Ins_Rspnder_Idx_from__c+ '-' + lf.Medicare_Supplement_Ins_Rspnder_Idx_to__c;
       else 
           lf.Medicare_supplement_ins_respond_ind_rang__c= null;
            /*  Starting of defect 831 */
       if(lf.Uninsured_Index__c!=null && lf.Uninsured_Index_to__c!=null)  
          lf.Uninsured_index_ranges__c=  lf.Uninsured_Index__c+ '-' + lf.Uninsured_Index_to__c;
       else 
           lf.Uninsured_index_ranges__c= null;
      /* Ending of defect 831 */
     
       
        Life_Style__c objexistingValues = new Life_Style__c ();
        List<Life_Style__c> existingValues = new List<Life_Style__c> ();
        existingValues = [SELECT Aches_and_Pain_AGPAIN__c,Ailment_Present_Any__c,Allergies_and_Sinuses_AGNOSE__c,
                            Campaign__c,Cancer_AGCANCER__c,
                            
                            Cholesterol_and_Blood_Pressure_AGBLOOD__c,Diabetes_AGDIAB__c,Digestive_AGDIG__c,Do_It_Yourself__c,Female_Conditions_AGFEM__c,
                            Fine_Arts__c,Foot_AGFOOT__c,Healthcare_Treatment_Pref__c,Health_Index_Illness_or_Condition_To__c,Health_Index_Manage_Bus_of_Health_To__c,
                            Health_Index_Manage_Bus_of_Health__c,Health_Index_Manage_Health_From__c,Health_Index_Manage_Health_To__c,
                            Health_Index_Manage_Illness_Condition_Fr__c,Health_Index_Wear_Dev_to_Manage_Health_T__c,Health_Index_Wear_Dev_to_Manage_Health__c,
                            Health_Ins_Direct_Pay_Index_From__c,Health_Ins_Direct_Pay_Index_To__c,Health_Ins_Engagement_Index_From__c,Health_Ins_Engagement_Index_To__c,
                            Health_Ins_Influence_Index_From__c,Health_Ins_Influence_Index_To__c,Health_Ins_Prem_Tolerance_Index_to__c,Health_Ins_Prem_Tolerance_Index__c,
                            Health_Ins_Subsidy_Ind_to__c,Health_Ins_Subsidy_Ind__c,Heart_Condition_AGHEART__c,Home_Life__c,Joint_Spine_AGJOINT__c,Luxury_Life__c,
                            Male_Conditions_AGMALE__c,Medicare_Supplement_Ins_Rspnder_Idx_from__c,Medicare_Supplement_Ins_Rspnder_Idx_to__c,
                            Mobility_Problems_and_Assistance_AGAST__c,Mouth_and_Teeth_AGMOUTH__c,Outdoor_Enthusiasts__c,Physically_Active__c,
                            Progressive_Conditions_AGPROG__c,Psychological_Behavioral_AGPSYCO__c,Respiratory_AGRESP__c,Skin_AGSKIN__c,Sports_Enthusiasts__c,Techies__c,
                            Uninsured_Index_to__c,Up_Town__c,Urinary_Bowel_AGURINAR__c,
                            Health_Index_Manage_Bus_of_Health_ranges__c,Health_Index_Manage_Health_ranges__c,Health_Index_Manage_Illness_Cond_ranges__c,
                            Health_Index_Weardevto_managehealth_rang__c,Health_ins_engagement_index_ranges__c,Health_ins_influence_index_ranges__c,
                            Health_Ins_Pay_Index_ranges__c,Health_ins_prem_tolerance_index_ranges__c,Medicare_supplement_ins_respond_ind_rang__c,
                            Uninsured_index_ranges__c,CRM_Living_Well__c, // Added for Audience Selection criteria story
                            Vision_AGVSN__c,Weight_AGWEIGHT__c FROM Life_Style__c WHERE Campaign__c=:campaignId];
                            
        if(existingValues.size()>0)
        objexistingValues = existingValues[0];
        Campaign objCampaignForAPI;
        List<Campaign> lstCampaign = [SELECT LIST_ORDER_SELECT_GRP_ID__c,Wunderman_Sync__c FROM Campaign WHERE id=:campaignId];
        if(lstCampaign.size()>0) objCampaignForAPI = lstCampaign[0];
        Map<String, Map<String, String>> mapApiNameswithValues = new Map<String, Map<String, String>> ();       
        mapApiNameswithValues  = FieldsInfoManager.GetFieldsInfoInsert('Life_Style__c', objexistingValues,  lf);
        System.debug('*******mapApiNameswithValues******'+mapApiNameswithValues);
         if(mapApiNameswithValues!=null)
        {
            objCampaignForAPI.Wunderman_Sync__c = 'Pending';
            update objCampaignForAPI;
        }
        for(String s : mapApiNameswithValues.keyset()) {
            if(s == 'Insert') CampaignMemberCriteriaManager.insertCriterias(mapApiNameswithValues.get(s),campaignId,false,'Life_Style__c');
            else if(s == 'Update') CampaignMemberCriteriaManager.updateCriterias(mapApiNameswithValues.get(s),campaignId, false);
            else if(s == 'Delete') CampaignMemberCriteriaManager.deleteCriterias(mapApiNameswithValues.get(s),campaignId, false);
            
        }
        if (Lifeid==null)
        {  
            system.debug('value of lf'+ lf);
            lf.Campaign__c=campaignId;
            insert lf; 
            ref = new Pagereference('/apex/EncountersPage?Id='+campaignId+'&btn='+button  +'&lifestyle='+lf.id);
            ref.setredirect(true);   
        }
        else 
        {
            update lf;             
            ref = new Pagereference('/apex/EncountersPage?Id='+campaignId+'&btn='+button  +'&lifestyle='+lf.id);
            ref.setredirect(true);             
            
        }
        
        
        
        
        // getSession();
       /* WundermanAPICallouts lifeCriteria =new WundermanAPICallouts();
        
        lifeCriteria.InsertCriteriaLifestyle(lf.id); */
        
        return ref;
    }
    
    
     public pagereference SaveDemoCount()
    {
        pagereference ref; 
        
        
        
        
        if(demo.AgeFrom_UI__c==null &&  demo.AgeTo_UI__c==null && demo.Preferred_Contact_Method__c==null && demo.Est_Discretionary_Income_Percent_to__c==null && demo.Est_Discretionary_Income_Percent__c==null && demo.Assimilation__c==null   && demo.Birthdate__c==null && demo.Dwelling_Type__c==null && demo.Est_Household_Debt_Level__c==null && demo.Est_Household_Income_3_0__c==null && demo.Ethnic_Group__c==null && demo.Ethcinity__c==null && demo.Gender__c==null && demo.Generations_2_0__c==null && demo.Language__c==null &&  demo.Net_Worth_3_0__c==null && demo.Number_of_Adults_in_HH__c==null && demo.Number_of_Children__c==null && demo.Number_of_Persons_in_HH__c==null &&  demo.Presence_of_Children__c==null && demo.Presence_of_Donor__c==null && demo.Religion__c==null && demo.Presence_of_Elderly_Parents__c==null && demo.Race__c==null &&   demo.to_1__c==null  && demo.to_Number_of_Adults_in_HH__c==null &&    demo.to_Number_of_Children__c==null && demo.to_Number_of_Persons_in_HH__c==null  && demo.Suppression_Non_emailable__c==null && demo.Move_Activity_in_Months__c==null && demo.Address_Deliverable__c==null && demoid==null)
        {
        
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Please select atleast one field to save the record'));
       return null;
       } 
       if((demo.AgeFrom_UI__c!=null && demo.AgeTo_UI__c==null) || (demo.AgeFrom_UI__c==null && demo.AgeTo_UI__c!=null)) 
        {
        
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Please select the range of Birthdate'));
        return null;
       } 
      
     if(demo.AgeFrom_UI__c!=null && demo.AgeTo_UI__c!=null )
     {
      // if(age_from>age_to)
      if(demo.AgeFrom_UI__c > demo.AgeTo_UI__c )
        {
        
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error, 'Age from cannot be greater than Age to'));
       return null;
       }
        
       
       if ((demo.AgeFrom_UI__c!=null && demo.AgeTo_UI__c!=null) )
     {// if(age_from>120 || age_to>120)
        if(demo.AgeFrom_UI__c>120 || demo.AgeTo_UI__c>120)
        {
       // system.debug('i am in value selected method '+ Integer.valueOf(demo.to_age__c));
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error, 'Age cannot be greater than 120'));
       return null;
       } 
      } 
       
        
        }
        if (demo.Birthdate__c!=null && demo.to_1__c!=null)
        {
        Integer days =(demo.Birthdate__c).daysBetween(Date.Today()); 
        Integer days_to =(demo.to_1__c).daysBetween(Date.Today()); 
           if(days/365>43800/365 || days_to/365>43800/365)
           {
           system.debug('days between======= '+ days);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error, 'Birth date cannot be greater than 120 years'));
           return null;
           }  
        }
         if((demo.Number_of_Adults_in_HH__c!=null && demo.to_Number_of_Adults_in_HH__c==null) || (demo.Number_of_Adults_in_HH__c==null && demo.to_Number_of_Adults_in_HH__c!=null)) 
         {        
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Please select the range of Number of Adults'));
            return null;
         } 
        if(demo.Number_of_Adults_in_HH__c!=null && demo.to_Number_of_Adults_in_HH__c!=null ){
        system.debug('i am in adults in HH');
       if(Integer.valueOf(demo.Number_of_Adults_in_HH__c)>Integer.valueOf(demo.to_Number_of_Adults_in_HH__c))
        {
         system.debug('i am in adults in HH for invalid ranges');
         system.debug('value of integer===='+ Integer.valueOf(demo.Number_of_Adults_in_HH__c));
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error, 'Invalid ranges for Number of Adults'));
       return null;
       } 
       if(Integer.valueOf(demo.to_Number_of_Adults_in_HH__c) > 99 ||  Integer.valueOf(demo.Number_of_Adults_in_HH__c)>99)
        {
        system.debug('i am in value selected method');
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error, 'Number of Adults value cannot be greater than 99'));
       return null;
       } 
        
        }
        
        
  if((demo.Number_of_Persons_in_HH__c!=null && demo.to_Number_of_Persons_in_HH__c==null) || (demo.Number_of_Persons_in_HH__c==null && demo.to_Number_of_Persons_in_HH__c!=null)) 
         {        
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Please select the range of Household size'));
            return null;
         }      
if(demo.Number_of_Persons_in_HH__c!=null && demo.to_Number_of_Persons_in_HH__c!=null ){
system.debug('i am in adults in HH');
if(Integer.valueOf(demo.Number_of_Persons_in_HH__c)>Integer.valueOf(demo.to_Number_of_Persons_in_HH__c))
{
system.debug('i am in adults in HH for invalid ranges');
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Invalid ranges for Number of Persons'));
return null;
} 
if((Integer.valueOf(demo.to_Number_of_Persons_in_HH__c)>99) || (Integer.valueOf(demo.Number_of_Persons_in_HH__c)>99))
{
system.debug('i am in value selected method');
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Number of Persons value cannot be greater than 99'));
return null;
} 

}
        if((demo.Number_of_Children__c!=null && demo.to_Number_of_Children__c==null) || (demo.Number_of_Children__c==null && demo.to_Number_of_Children__c!=null)) 
         {        
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Please select the range for Number of children'));
            return null;
         }  
        if(demo.Number_of_Children__c!=null && demo.to_Number_of_Children__c!=null ){
    system.debug('i am in adults in HH');
        if(Integer.valueOf(demo.Number_of_Children__c)>Integer.valueOf(demo.to_Number_of_Children__c))
            {
        system.debug('i am in adults in HH for invalid ranges');
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Invalid ranges for Number of Children'));
        return null;
        } 
        if((Integer.valueOf(demo.to_Number_of_Children__c)>99) || (Integer.valueOf(demo.Number_of_Children__c)>99))
    {
        system.debug('i am in value selected method');
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Number of Children value cannot be greater than 99'));
        return null;
        } 

        }
        
        if((demo.Est_Discretionary_Income_Percent__c!=null && demo.Est_Discretionary_Income_Percent_to__c==null) || (demo.Est_Discretionary_Income_Percent__c==null && demo.Est_Discretionary_Income_Percent_to__c!=null)) 
        {        
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Please select the range of Discretionary Income Percent'));
            return null;
        } 
        
        if(demo.Est_Discretionary_Income_Percent_to__c<demo.Est_Discretionary_Income_Percent__c)
      {
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Discretionary income cannot be less than starting income'));
       return null;
      }
         //  Added for Audience Selection criteria story - BirthMonth
      if(demo.CRM_Birth_Month__c!=null && demo.CRM_Birth_Month__c.contains('Any')) {
          List<String> otherValues = demo.CRM_Birth_Month__c.split(';');
          for(String str: otherValues) {
              if(str!= 'Any') {
                  ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Any and other months can not be selected at the same time. Please select either Any or other months'));
                  return null;
              }
          }
                   
      }
      
      // end of Added for Audience Selection criteria story - BirthMonth
        
        
        // Added to include edit/insert/delete criteria
        //ageFrom();
     /*   if(age_from!=null && age_to!=null && age_from!=0 && age_to!=0){
            demo.age__c= string.valueOf(age_from)+'-'+string.valueOf(age_to) ;
            system.debug('age value in insert criteria'+ age_from);
            system.debug('age to value '+ age_to);
            } */
            
          if(demo.AgeFrom_UI__c!=null && demo.AgeTo_UI__c!=null && demo.AgeFrom_UI__c!=0 && demo.AgeTo_UI__c!=0){
            demo.age__c= string.valueOf(demo.AgeFrom_UI__c)+'-'+string.valueOf(demo.AgeTo_UI__c) ;
            system.debug('age value in insert criteria'+ demo.age__c);
            system.debug('age to value '+ demo.AgeFrom_UI__c);
            }   
            
        else{
            demo.age__c = null;
            system.debug('age value in insert else criteria'+ demo.AgeFrom_UI__c);
            }
            
        if(demo.Number_of_Persons_in_HH__c!=null && demo.to_Number_of_Persons_in_HH__c!=null)
            demo.Household_size_ranges__c = demo.Number_of_Persons_in_HH__c + '-' + demo.to_Number_of_Persons_in_HH__c;
        else
            demo.Household_size_ranges__c =null;
              
        if(demo.Number_of_Adults_in_HH__c!=null && demo.to_Number_of_Adults_in_HH__c!=null)
            demo.Number_of_Adults_in_hh_ranges__c = demo.Number_of_Adults_in_HH__c+'-'+ demo.to_Number_of_Adults_in_HH__c;
        else
            demo.Number_of_Adults_in_hh_ranges__c= null;
        if(demo.Number_of_Children__c!=null && demo.to_Number_of_Children__c!=null)
            demo.Number_of_Children_ranges__c = demo.Number_of_Children__c +'-'+ demo.to_Number_of_Children__c;
        else
            demo.Number_of_Children_ranges__c = null;
        if(demo.Est_Discretionary_Income_Percent__c!=null && demo.Est_Discretionary_Income_Percent_to__c!=null)
            demo.Discretionary_Income_Percent_ranges__c= demo.Est_Discretionary_Income_Percent__c +'-'+ demo.Est_Discretionary_Income_Percent_to__c;
        else
             demo.Discretionary_Income_Percent_ranges__c=null;
             
         if(demo.Move_Activity_in_Months__c!=null) {
            Integer subtractmonths = Integer.valueOf(demo.Move_Activity_in_Months__c) ;     
            system.debug('integer value of move activity in months+++++'+subtractmonths )  ;     
            Date rangefirst = Date.Today().addmonths(-subtractmonths);
            system.debug('date rangefirst+++++'+rangefirst ) ; 
            Date rangesecond = Date.Today().addmonths(-1);
             system.debug('date rangesecond+++++'+rangesecond ) ; 
            String monthfirst = String.valueOf(rangefirst.Month());
            system.debug('date month first+++++'+monthfirst ) ; 
            String monthsecond = String.valueOf(rangesecond.Month());
            system.debug('date monthsecond +++++'+monthsecond ) ; 
            if(monthfirst.length() ==1) monthfirst = '0'+monthfirst;
            if(monthsecond.length() ==1) monthsecond = '0'+monthsecond ;
            demo.New_Movers_Range__c = String.valueOf(rangefirst.Year()) + monthfirst + '-' +String.valueOf(rangesecond.Year()) +monthsecond;
            System.debug('******demo.New_Movers_Range__c**'+demo.New_Movers_Range__c);
        }
        else
            demo.New_Movers_Range__c = null;
        if(demo.DOBFrom_UI__c!=null && demo.DOBTo_UI__c!=null) 
        {
            String monthfirst = String.valueOf(demo.DOBFrom_UI__c.Month());
            String monthsecond = String.valueOf(demo.DOBTo_UI__c.Month());
            String dayfirst = String.valueOf(demo.DOBFrom_UI__c.day());
            String daysecond = String.valueOf(demo.DOBTo_UI__c.day());
            if(monthfirst.length() ==1) monthfirst = '0'+monthfirst;
            if(monthsecond.length() ==1) monthsecond = '0'+monthsecond ;
            if(dayfirst.length() ==1) dayfirst= '0'+dayfirst;
            if(daysecond.length() ==1) daysecond= '0'+daysecond;
            demo.Birthdate_Ranges__c = String.valueOf(demo.DOBFrom_UI__c.Year()) + monthfirst + dayfirst+'-' +String.valueOf(demo.DOBTo_UI__c.Year()) +monthsecond+daysecond ;
            System.debug('******demo.Birthdate_Ranges__c**'+demo.Birthdate_Ranges__c);
        }
        else
            demo.Birthdate_Ranges__c = null;
        
         List<Campaign_Demographics__c> existingValues = new List<Campaign_Demographics__c> ();
        Campaign_Demographics__c objexistingValues = new Campaign_Demographics__c ();
        existingValues = [SELECT DOBTo_UI__c,DOBFrom_UI__c,DOB__c,AgeTo_UI__c,AgeFrom_UI__c,Address_Deliverable__c,Age__c,Assimilation__c,Birthdate__c,Campaign__c,New_Movers_Range__c,
                                                  Dwelling_Type__c,Birthdate_Ranges__c,
                                                  Est_Discretionary_Income_Percent_to__c,Est_Discretionary_Income_Percent__c,
                                                  Est_Household_Debt_Level__c,Est_Household_Income_3_0__c,Ethcinity_Criteria_Element__c,
                                                  Ethcinity__c,Ethnic_Group__c,Gender_Criteria_Element__c,Gender__c,Generations_2_0__c,
                                                  Language__c,
                                                  
                                                  Move_Activity_Criteria_Element__c,Move_Activity_in_Months__c,
                                                  Name,Net_Worth_3_0__c,Number_of_Adults_in_HH__c,Number_of_Children__c,Number_of_Persons_in_HH__c,
                                                  
                                                  Preferred_Contact_Criteria_Element__c,Preferred_Contact_Method__c,Presence_of_Children__c,CRM_Birth_Month__c,  // Added for Audience Selection criteria story -BirthMonth
                                                  Presence_of_Donor__c,Presence_of_Elderly_Parents__c,
                                                  Discretionary_Income_Percent_ranges__c,Household_size_ranges__c,Number_of_Adults_in_hh_ranges__c,Number_of_Children_ranges__c,
                                                  Race__c,Religion_Criteria_Element__c,Religion__c,New_movers__c,
                                                  Suppression_Non_emailable__c,SystemModstamp,to_1__c,to_age__c,to_Number_of_Adults_in_HH__c,
                                                  to_Number_of_Children__c,to_Number_of_Persons_in_HH__c FROM Campaign_Demographics__c WHERE Campaign__c=:campaignId];
        
        
        
       if(existingValues.size()>0)
           objexistingValues = existingValues[0];
         System.debug('********objexistingValues.Age__c'+objexistingValues.Age__c+'**********new values*****'+demo.Age__c);
         System.debug('********objexistingValues.Age__c'+objexistingValues.Gender__c+'**********new values*****'+demo.Gender__c);
        Campaign objCampaignForAPI;
        List<Campaign> lstCampaign = [SELECT LIST_ORDER_SELECT_GRP_ID__c FROM Campaign WHERE id=:campaignId];
        if(lstCampaign.size()>0) objCampaignForAPI = lstCampaign[0];
        Map<String, Map<String, String>> mapApiNameswithValues = new Map<String, Map<String, String>> (); 
        mapApiNameswithValues  = FieldsInfoManager.GetFieldsInfoInsert('Campaign_Demographics__c', objexistingValues,  demo);
        System.debug('*******mapApiNameswithValues******'+mapApiNameswithValues);
        if(mapApiNameswithValues!=null)
        {
            objCampaignForAPI.Wunderman_Sync__c = 'Pending';
            update objCampaignForAPI;
        }
        for(String s : mapApiNameswithValues.keyset()) {
            if(s == 'Insert') {
                CampaignMemberCriteriaManager.insertCriterias(mapApiNameswithValues.get(s),campaignId, false, 'Campaign_Demographics__c');
            }
            else if(s == 'Update') CampaignMemberCriteriaManager.updateCriterias(mapApiNameswithValues.get(s),campaignId, false);
            else if(s == 'Delete') CampaignMemberCriteriaManager.deleteCriterias(mapApiNameswithValues.get(s),campaignId, false);
            
        }
        
        
        
        
        if (button==3 && demoid==null)
        { 
            system.debug('campaign id in lifestyle method========' + demo);
            demo.Campaign__c=campaignId;
          
            if(demo.AgeFrom_UI__c!=null && demo.AgeTo_UI__c!=null)
            demo.age__c= string.valueOf(demo.AgeFrom_UI__c)+'-'+string.valueOf(demo.AgeTo_UI__c) ;
           
            system.debug('value of age======'+demo.AgeTo_UI__c);
            system.debug('value of age======'+demo.AgeFrom_UI__c);
            upsert demo; 
            ref = new Pagereference('/apex/EncountersPage?Id='+campaignId+'&btn='+button  +'&demo='+demo.id);
            ref.setredirect(true);   
        }
        else 
        {
        
            if(demo.AgeFrom_UI__c!=null && demo.AgeTo_UI__c!=null)
            demo.age__c= string.valueOf(demo.AgeFrom_UI__c)+'-'+string.valueOf(demo.AgeTo_UI__c) ;
            update demo;             
            ref = new Pagereference('/apex/EncountersPage?Id='+campaignId+'&btn='+button  +'&demo='+demo.id);
            ref.setredirect(true);             
            
        }
        

        
        
        // getSession();
        // commented out by Lov to test the new edit/insert/delete functionality 
        /*WundermanAPICallouts democriteria =new WundermanAPICallouts();
        
        democriteria.InsertCriteriaDemo(demo.id);*/
       
        return ref;
    }
    
    
    
    public pagereference SaveModel()
    {
        pagereference ref; 
        
       
        if(model.Model_1_from__c==null && model.Model_1_to__c==null && model.Model_2_from__c==null && model.Model_2_to__c==null && model.Model_3_from__c==null && model.Model_3_to__c==null && model.Model_4_from__c==null && model.Model_4_to__c==null 
        && model.Model_5_from__c==null && model.Model_5_to__c==null && model.Model_6_from__c==null && model.Model_6_to__c==null && model.Model_7_from__c==null && model.Model_7_to__c==null && model.Model_8_from__c==null && model.Model_8_to__c==null // Added for new Model Requirement
        && model.Model_9_from__c == null && model.Model_9_to__c == null && Modelid==null)  // Added for new Model CRM 270 req.
        {
        system.debug('in null model if condition');
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Please select atleast one field to save the record'));
       return null;
       } 
        
        
        // Added for new Model CRM 270 req.
       if(model.Model_9_from__c!=null && model.Model_9_to__c!=null ){
       if(Integer.valueOf(model.Model_9_from__c)>Integer.valueOf(model.Model_9_to__c))
        {
        
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Invalid Bariatric ranges'));
       return null;
       } 
      if(Integer.valueOf(model.Model_9_to__c)>9 || Integer.valueOf(model.Model_9_from__c)>9)
        {
       
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Bariatric value cannot be greater than 9'));
       return null;
       } 
       }
       
       if((model.Model_9_from__c!=null && model.Model_9_to__c==null) || (model.Model_9_from__c==null && model.Model_9_to__c!=null)){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Please enter Bariatric ranges'));
       return null;
       }
       // End of new Model CRM 270 req.
        
       // Added for new Model Requirement
       if(model.Model_5_from__c!=null && model.Model_5_to__c!=null ){
       if(Integer.valueOf(model.Model_5_from__c)>Integer.valueOf(model.Model_5_to__c))
        {
        
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Invalid Breast - Oncology ranges'));
       return null;
       } 
      if(Integer.valueOf(model.Model_5_to__c)>9 || Integer.valueOf(model.Model_5_from__c)>9)
        {
       
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Breast - Oncology value cannot be greater than 9'));
       return null;
       } 
       }
       
       if((model.Model_5_from__c!=null && model.Model_5_to__c==null) || (model.Model_5_from__c==null && model.Model_5_to__c!=null)){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Please enter Breast - Oncology ranges'));
       return null;
       } 
        
        
         if(model.Model_1_from__c!=null && model.Model_1_to__c!=null ){
       if(Integer.valueOf(model.Model_1_from__c)>Integer.valueOf(model.Model_1_to__c))
        {
        
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Invalid Cardiology ranges'));
       return null;
       } 
      
       }
       
       if((model.Model_1_from__c!=null && model.Model_1_to__c==null) || (model.Model_1_from__c==null && model.Model_1_to__c!=null)){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Please enter Cardiology ranges'));
       return null;
       }
       
       if(model.Model_6_from__c!=null && model.Model_6_to__c!=null ){
       if(Integer.valueOf(model.Model_6_from__c)>Integer.valueOf(model.Model_6_to__c))
        {
        
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Invalid Colon - Oncology ranges'));
       return null;
       } 
      if(Integer.valueOf(model.Model_6_to__c)>9 || Integer.valueOf(model.Model_6_from__c)>9)
        {
       
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Colon - Oncology value cannot be greater than 9'));
       return null;
       } 
       }
       
       if((model.Model_6_from__c!=null && model.Model_6_to__c==null) || (model.Model_6_from__c==null && model.Model_6_to__c!=null)){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Please enter Colon - Oncology ranges'));
       return null;
       }
       
       
       if(model.Model_8_from__c!=null && model.Model_8_to__c!=null ){
       if(Integer.valueOf(model.Model_8_from__c)>Integer.valueOf(model.Model_8_to__c))
        {
        
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Invalid OB Managed Care ranges'));
       return null;
       } 
      if(Integer.valueOf(model.Model_8_to__c)>9 || Integer.valueOf(model.Model_8_from__c)>9)
        {
       
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'OB Managed Care value cannot be greater than 9'));
       return null;
       } 
       }
       
       if((model.Model_8_from__c!=null && model.Model_8_to__c==null) || (model.Model_8_from__c==null && model.Model_8_to__c!=null)){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Please enter OB Managed Care ranges'));
       return null;
       }
       
       // End for new Model Requirement
       
       
        if(model.Model_7_from__c!=null && model.Model_7_to__c!=null ){
       if(Integer.valueOf(model.Model_7_from__c)>Integer.valueOf(model.Model_7_to__c))
        {
        
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Invalid OB Medicaid ranges'));
       return null;
       } 
      if(Integer.valueOf(model.Model_7_to__c)>9 || Integer.valueOf(model.Model_7_from__c)>9)
        {
       
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'OB Medicaid value cannot be greater than 9'));
       return null;
       } 
       }
       
       if((model.Model_7_from__c!=null && model.Model_7_to__c==null) || (model.Model_7_from__c==null && model.Model_7_to__c!=null)){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Please enter OB Medicaid ranges'));
       return null;
       }
       
       if(model.Model_3_from__c!=null && model.Model_3_to__c!=null ){
       if(Integer.valueOf(model.Model_3_from__c)>Integer.valueOf(model.Model_3_to__c))
        {
        
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Invalid Orthopedics-Hip ranges'));
       return null;
       } 
      if(Integer.valueOf(model.Model_3_to__c)>9 || Integer.valueOf(model.Model_3_from__c)>9)
        {
       
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Orthopedics-Hip value cannot be greater than 9'));
       return null;
       } 
       }
       
       if((model.Model_3_from__c!=null && model.Model_3_to__c==null) || (model.Model_3_from__c==null && model.Model_3_to__c!=null)){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Please enter Orthopedics-Hip ranges'));
       return null;
       }
       
       
       if(model.Model_2_from__c!=null && model.Model_2_to__c!=null ){
       if(Integer.valueOf(model.Model_2_from__c)>Integer.valueOf(model.Model_2_to__c))
        {
        
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Invalid Orthopedics-knee ranges'));
       return null;
       } 
      if(Integer.valueOf(model.Model_2_to__c)>9 || Integer.valueOf(model.Model_2_from__c)>9)
        {
       
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Orthopedics-knee value cannot be greater than 9'));
       return null;
       } 
       }
       
       
       if((model.Model_2_from__c!=null && model.Model_2_to__c==null) || (model.Model_2_from__c==null && model.Model_2_to__c!=null)){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Please enter Orthopedics-knee ranges'));
       return null;
       }
       
       
       
       if(model.Model_4_from__c!=null && model.Model_4_to__c!=null ){
       if(Integer.valueOf(model.Model_4_from__c)>Integer.valueOf(model.Model_4_to__c))
        {
        
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Invalid Orthopedics-Spine ranges'));
       return null;
       } 
      if(Integer.valueOf(model.Model_4_to__c)>9 || Integer.valueOf(model.Model_4_from__c)>9)
        {
       
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Orthopedics-Spine value cannot be greater than 9'));
       return null;
       } 
       }
       
       if((model.Model_4_from__c!=null && model.Model_4_to__c==null) || (model.Model_4_from__c==null && model.Model_4_to__c!=null)){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Please enter Orthopedics-Spine ranges'));
       return null;
       }
       
       
       
       if(model.Model_1_from__c!=null && model.Model_1_to__c!=null )
       {
           model.Model_Cardiology_Ranges__c = model.Model_1_from__c + '-' + model.Model_1_to__c;    
       }
       else
           model.Model_Cardiology_Ranges__c = null;
        if(model.Model_2_from__c!=null && model.Model_2_to__c!=null )
       {
           model.Model_Ortho_Knee_Ranges__c= model.Model_2_from__c + '-' + model.Model_2_to__c;    
       }
        else
           model.Model_Ortho_Knee_Ranges__c= null;
        if(model.Model_3_from__c!=null && model.Model_3_to__c!=null )
       {
           model.Model_Ortho_Hip_Ranges__c= model.Model_3_from__c + '-' + model.Model_3_to__c;    
       }
        else
           model.Model_Ortho_Hip_Ranges__c= null;
        if(model.Model_4_from__c!=null && model.Model_4_to__c!=null )
       {
           model.Model_Ortho_Spine_Ranges__c = model.Model_4_from__c + '-' + model.Model_4_to__c;    
       }
        else
           model.Model_Ortho_Spine_Ranges__c = null;
       // Added for new Model Requirement
       
       if(model.Model_5_from__c!=null && model.Model_5_to__c!=null )
       {
           model.Model_for_Breast_Ranges__c = model.Model_5_from__c + '-' + model.Model_5_to__c;    
       }
       else
           model.Model_for_Breast_Ranges__c = null;
           
        if(model.Model_6_from__c!=null && model.Model_6_to__c!=null )
       {
           model.Model_Colon_Ranges__c = model.Model_6_from__c + '-' + model.Model_6_to__c;    
       }
       else
           model.Model_Colon_Ranges__c= null;
           
       if(model.Model_7_from__c!=null && model.Model_7_to__c!=null )
       {
           model.Model_OB_Medicade_Ranges__c = model.Model_7_from__c + '-' + model.Model_7_to__c;    
       }
       else
           model.Model_OB_Medicade_Ranges__c = null;
           
           
       if(model.Model_8_from__c!=null && model.Model_8_to__c!=null )
       {
           model.Model_OB_Commercial_Ranges__c= model.Model_8_from__c + '-' + model.Model_8_to__c;    
       }
       else
           model.Model_OB_Commercial_Ranges__c = null;
       
       
       // End for new Model Requirement
       
       // Added for new Model CRM 270 req.
        if(model.Model_9_from__c!=null && model.Model_9_to__c!=null )
       {
           model.Model_Bariatric_Ranges__c = model.Model_9_from__c + '-' + model.Model_9_to__c;    
       }
       else
           model.Model_Bariatric_Ranges__c = null;
       // End of new Model CRM 270 req.
           
        System.debug('******first*********'+model.Model_2_from__c+'*****'+model.Model_2_to__c + '******ranges*****'+model.Model_Ortho_Knee_Ranges__c);
        System.debug('******second*********'+model.Model_3_from__c+'*****'+model.Model_3_to__c + '******ranges*****'+model.Model_Ortho_Hip_Ranges__c);
        List<Model__c> existingValues= new List<Model__c> (); 
        Model__c objexistingValues = new Model__c();
        existingValues = [SELECT Model_1_from__c,Model_1_to__c,Model_2_from__c,Model_2_to__c,Model_3_from__c,Model_3_to__c,Model_4_from__c,Model_4_to__c,Campaign__c,
                           Model_Cardiology_Ranges__c,Model_Ortho_Hip_Ranges__c,Model_Ortho_Knee_Ranges__c,Model_Ortho_Spine_Ranges__c
                           ,Model_5_from__c, Model_5_to__c,Model_6_from__c, Model_6_to__c,Model_7_from__c, Model_7_to__c,Model_8_from__c, Model_8_to__c,Model_for_Breast_Ranges__c,Model_Colon_Ranges__c,Model_OB_Medicade_Ranges__c,Model_OB_Commercial_Ranges__c // Added for new Model Requirement
                           , Model_9_from__c, Model_9_to__c, Model_Bariatric_Ranges__c FROM Model__c WHERE Campaign__c=:campaignId]; // Added for new Model CRM 270 req.
        if(existingValues.size()>0)
           objexistingValues = existingValues[0];
        Campaign objCampaignForAPI;
        List<Campaign> lstCampaign = [SELECT LIST_ORDER_SELECT_GRP_ID__c,Wunderman_Sync__c  FROM Campaign WHERE id=:campaignId];
        if(lstCampaign.size()>0) objCampaignForAPI = lstCampaign[0];
        Map<String, Map<String, String>> mapApiNameswithValues = new Map<String, Map<String, String>> (); 
        mapApiNameswithValues  = FieldsInfoManager.GetFieldsInfoInsert('Model__c', objexistingValues,  model);
        System.debug('*******mapApiNameswithValues******'+mapApiNameswithValues);
         if(mapApiNameswithValues!=null)
        {
            objCampaignForAPI.Wunderman_Sync__c = 'Pending';
            update objCampaignForAPI;
        }
        for(String s : mapApiNameswithValues.keyset()) {
            if(s == 'Insert') CampaignMemberCriteriaManager.insertCriterias(mapApiNameswithValues.get(s),campaignId, false, 'Model__c');
            else if(s == 'Update') CampaignMemberCriteriaManager.updateCriterias(mapApiNameswithValues.get(s),campaignId, false);
            else if(s == 'Delete') CampaignMemberCriteriaManager.deleteCriterias(mapApiNameswithValues.get(s),campaignId, false);
            
        }
        
        if ( Modelid==null)
        { 
            system.debug('campaign id in lifestyle method========' + model);
            model.Campaign__c=campaignId;
            upsert model; 
            ref = new Pagereference('/apex/EncountersPage?Id='+campaignId+'&btn='+button  +'&Modelid='+model.id);
            ref.setredirect(true);   
        }
        else 
        {
            update model;             
            ref = new Pagereference('/apex/EncountersPage?Id='+campaignId+'&btn='+button  +'&Modelid='+model.id);
            ref.setredirect(true);             
            
        }
        
        return ref;
    }
    
    
    public void EditCriteria()
    {
  
        
        if(campaignId==null ){
        system.debug('i am in campaign id null==========');
        detailPage = true;
        }
        else{
         system.debug('==============i am in not campaign id null==========');
        DetailPage = false;        
        }
           if(encagg.Preffered_Hospital__c != null )
      
        {
        system.debug('value of hospital in edit');
          List<String> lstPrefferedHospital= encagg.Preffered_Hospital__c.split(';');
            Set<String> setprefferedhospital = new Set<String>();
            for(string str : lstPrefferedHospital)
            {
            system.debug('value of hospital in edit mode======'+ str);
              //  SelectedPrefferedHospitalList.add(new SelectOption(str, str));
                setprefferedhospital.add(str);
                 for(integer i=0;i<PrefferedHospitalList.Size();i++)
                {
                        system.debug('**AllPrefferedHospitalList**='+PrefferedHospitalList[i].getValue()+'******');
                        if(PrefferedHospitalList[i].getValue() == str)
                            PrefferedHospitalList.remove(i);
                    }
            }
            
            
           } 
     
    }
    
  /*  public void CancelEditCriteria()
    { 
       DetailPage = true; 
    
    }  */
    
     
    
    
    public pagereference cancelencountercriteria(){
   		pagereference ref; 
        // DetailPage =true;
        system.debug('campaign id in cancel encounter method========' + campaignId);
        if(encounterid!=null){
            ref = new Pagereference('/apex/EncountersPage?Id='+campaignId+'&btn=1&encounter='+encounterid);
            ref.setredirect(true);  
        }else{
         ref = new Pagereference('/apex/EncountersPage?Id='+campaignId+'&btn=1');
            ref.setredirect(true);
        }
        return ref;
    }
    
    
    public pagereference cancelencounteraggregatescriteria(){
   
         pagereference ref; 
        // DetailPage =true;
            system.debug('campaign id in cancel encounter method========' + campaignId);
          if(encounteraggid!=null){
            ref = new Pagereference('/apex/EncountersPage?Id='+campaignId+'&btn=8&encounteraggregates='+encounteraggid);
            ref.setredirect(true);  
        }
        else{
         ref = new Pagereference('/apex/EncountersPage?Id='+campaignId+'&btn=8');
            ref.setredirect(true);
            }
        return ref;
    }
    
    
     public pagereference canceldemographicscriteria(){
   
         pagereference ref; 
        // DetailPage =true;
            system.debug('campaign id in cancel demographics method========' + campaignId);
          if(demoid!=null){
            ref = new Pagereference('/apex/EncountersPage?Id='+campaignId+'&btn=3&demo='+demoid);
            ref.setredirect(true);  
        }
        else{
        ref = new Pagereference('/apex/EncountersPage?Id='+campaignId+'&btn=3');
            ref.setredirect(true);
            }
        return ref;
    }
    
     public pagereference cancelmodelcriteria(){
   
         pagereference ref; 
        // DetailPage =true;
            system.debug('campaign id in cancel model method========' + campaignId);
          if(Modelid!=null){
          system.debug('i am in model cancel button');
            ref = new Pagereference('/apex/EncountersPage?Id='+campaignId+'&btn=5&Modelid='+model.Id);
            ref.setredirect(true);  
        }
        else{
        system.debug('i am in else model cancel');
        ref = new Pagereference('/apex/EncountersPage?Id='+campaignId+'&btn=5');
            ref.setredirect(true);  
            }
        return ref;
    }
    //Part of R2
     /*
     public pagereference cancelhracriteria()
     {
   
         pagereference ref; 
        // DetailPage =true;
            system.debug('campaign id in cancel hra method========' + campaignId);
          if(hraid!=null){
            ref = new Pagereference('/apex/EncountersPage?Id='+campaignId+'&btn=4&hra='+hraid);
            ref.setredirect(true);  
        }
        else{
         ref = new Pagereference('/apex/EncountersPage?Id='+campaignId+'&btn=4');
            ref.setredirect(true);
            }
        return ref;
    }
    */
    
    public pagereference cancellifestylecriteria(){
   
         pagereference ref; 
        // DetailPage =true;
            system.debug('campaign id in cancel lifestyle method========' + campaignId);
          if(Lifeid!=null){
            ref = new Pagereference('/apex/EncountersPage?Id='+campaignId+'&btn=2&lifestyle='+Lifeid);
            ref.setredirect(true);  
        }
        else{
        ref = new Pagereference('/apex/EncountersPage?Id='+campaignId+'&btn=2');
            ref.setredirect(true);  
            }
        return ref;
    }
    
    public pageReference deleteAllDiagnosisInclusions()
    {
        return deleteAllICDDiagnosis(false);
    }
    
    public pageReference deleteAllDiagnosisExclusions()
    {
        return deleteAllICDDiagnosis(true);
    }
    
    public pageReference deleteAllICDDiagnosis()
    {
        return null;
    }
    
    private pageReference deleteAllICDDiagnosis(boolean exclude)
    {
        list<ICD_Diagnosis_In__c> deleteDRGCodeList = [select id from ICD_Diagnosis_In__c where Campaign__c=:campaignId and Exclude__c=:exclude];
        system.debug('*****='+deleteDRGCodeList.size());
        Pagereference pg;
         CampaignMemberCriteriaManager.deleteCriteria('Diagnosis_Code__c', campaignId, exclude);  
         CampaignMemberCriteriaManager.setAddOnExclusionCriterias(campaignId);
       if(deleteDRGCodeList.size()>0){
            delete deleteDRGCodeList;
            if(encounterid!=null){
            pg = new Pagereference('/apex/EncountersPage?Id='+campaignId+'&btn=1&encounter='+encounterid);
            pg.setRedirect(true);
            }
            else{
       pg = new Pagereference('/apex/EncountersPage?Id='+campaignId+'&btn=1');
            pg.setRedirect(true);  
            }
          
        }
        return pg;
    }
    
    public pageReference deleteAllDRGInclusions()
    {
        return deleteAllDRGCode(false);
    }
    
    public pageReference deleteAllDRGExclusions()
    {
        return deleteAllDRGCode(true);
    }
    
      private pageReference deleteAllDRGCode(boolean exclude)
      {
        list<DRG_Code_Information__c> deleteDRGCodeList = [select id from DRG_Code_Information__c where Campaign__c=:campaignId AND Exclude__c=:exclude];
        system.debug('*****='+deleteDRGCodeList.size());
        Pagereference pg;
        CampaignMemberCriteriaManager.deleteCriteria('MS_DRG__c', campaignId, exclude);  
        CampaignMemberCriteriaManager.setAddOnExclusionCriterias(campaignId);
        if(deleteDRGCodeList.size()>0){
            delete deleteDRGCodeList;
            if(encounterid!=null){
            pg = new Pagereference('/apex/EncountersPage?Id='+campaignId+'&btn=1&encounter='+encounterid);
            pg.setRedirect(true);
            }
             else{
       pg = new Pagereference('/apex/EncountersPage?Id='+campaignId+'&btn=1');
            pg.setRedirect(true);  
            }
            
        }
        return pg;
    }
    
    public pageReference deleteAllProcedureInclusions()
    {
        return deleteAllprocedure(false);
    }
    
    public pageReference deleteAllProcedureExclusions()
    {
        return deleteAllprocedure(true);
    }
    
    private pageReference deleteAllprocedure(boolean exclude)
    {
        list<Procedure_Information__c> deleteProcedureCodeList = [select id from Procedure_Information__c where Campaign__c=:campaignId AND Exclude__c=:exclude];
        system.debug('*****='+deleteProcedureCodeList.size());
        Pagereference pg;
        CampaignMemberCriteriaManager.deleteCriteria('Procedure_Code__c', campaignId, exclude);  
        CampaignMemberCriteriaManager.setAddOnExclusionCriterias(campaignId);
        if(deleteProcedureCodeList.size()>0){
                 system.debug('%%%%%%deleteProcedureCodeList'+ deleteProcedureCodeList);

            delete deleteProcedureCodeList;
                 system.debug('%%%%%%deleteProcedureCodeList'+ deleteProcedureCodeList);

           if(encounterid!=null){
            pg = new Pagereference('/apex/EncountersPage?Id='+campaignId+'&btn=1&encounter='+encounterid);
            pg.setRedirect(true);
            }
             else{
       pg = new Pagereference('/apex/EncountersPage?Id='+campaignId+'&btn=1');
            pg.setRedirect(true);  
            }
        }
        return pg;
    }
    
     
  
  public  void preparehospitalpicklist()
    {
     PrefferedHospitalList = new list<SelectOption>();
    // HospitalList.add(new SelectOption('','--None--'));
     
     for(AggregateResult hlist: [select Hospital__c from Location__c where Hospital__c!= null group by Hospital__c order by Hospital__c asc])
     {
            PrefferedHospitalList .add(new SelectOption((string)hlist.get('Hospital__c'),(string)hlist.get('Hospital__c')));
     }
     
     }
   /*
        public list<selectoption> getsubserviceline()
        {
                subserviceline = new list<SelectOption>();
                selectedValSSL=  new String[]{};
                system.debug('iAM in subserviceline method'+selectedValSL);
                id RecordTypeid = [SELECT id FROM RecordType WHERE SobjectType='CRM_CampaignWizardReferenceData__c' AND DeveloperName='Sub_Service_Line'][0].id;
                
                for (CRM_CampaignWizardReferenceData__c objCRMServiceLineVal : [select CRM_ParentServiceLineID__r.CRM_ServiceLine__c,CRM_ServiceSubServiceLine__c from CRM_CampaignWizardReferenceData__c where CRM_ParentServiceLineID__r.CRM_ServiceLine__c =:selectedValSL and RecordTypeid=:RecordTypeid])
               // for (AggregateResult objCRMServiceLineVal: [select CRM_SubServiceLine__c  from CRM_CampaignWizardReferenceData__c where CRM_ParentServiceLineID__r.CRM_ServiceLine__c =:objcampaign.Service_Line__c group by CRM_SubServiceLine__c order by CRM_SubServiceLine__c asc])
                {   
                
                    
                    //subserviceline.add(new SelectOption((string)objCRMServiceLineVal.get('CRM_SubServiceLine__c'), (String)objCRMServiceLineVal.get('CRM_SubServiceLine__c')));
                    subserviceline.add(new SelectOption(objCRMServiceLineVal.CRM_ServiceSubServiceLine__c, objCRMServiceLineVal.CRM_ServiceSubServiceLine__c));
                    
                    system.debug('##### subserviceline ##### '+subserviceline);
                }
                
                return subserviceline;
                
        }
     */
    // start of hospital change
      public void save_encounter_hospitalvalues(){  
          List<id> hospital_id =  new List<id>();
          system.debug('selected hospital values in save method@@@'+ selectedHospitalCriteria);
    for(String str: selectedHospitalCriteria){
             Id i1 = Id.valueOf(str);
            hospital_id.add(i1);
                }
            for(CRM_CampaignLocationReferenceData__c selcriteria : [select recordtype.name, CRM_isActive__C,  CRM_HospitalCode__c from CRM_CampaignLocationReferenceData__c where Id IN: hospital_id ])
                {
          system.debug('inside second if');
            if((selcriteria.recordtype.name).equalsIgnoreCase(Tenet_Static_Variables.Campaign_Ownership_Hospital)  ){
              system.debug('inside second if%%% if condition true');
             selectedhospitalCodes.add(selcriteria.CRM_HospitalCode__c);
             system.debug('*****selectedownershipCodes'+ selectedhospitalCodes);
             }
                }
        
      }
    
    //start of encounter aggregates hospital change
    public void save_encounteragg_hospitalvalues(){  
          List<id> hospital_id =  new List<id>();
          system.debug('selected prefered hospital values in save method@@@'+ selectedPrefferedHospitalCriteria);
    for(String str: selectedPrefferedHospitalCriteria){
             Id i1 = Id.valueOf(str);
            hospital_id.add(i1);
                }
            for(CRM_CampaignLocationReferenceData__c selcriteria : [select recordtype.name, CRM_isActive__C,  CRM_HospitalCode__c from CRM_CampaignLocationReferenceData__c where Id IN: hospital_id ])
                {
          system.debug('inside second if');
            if((selcriteria.recordtype.name).equalsIgnoreCase(Tenet_Static_Variables.Campaign_Ownership_Hospital)  ){
              system.debug('inside second if%%% if condition true');
             selectedpreferedhospitalCodes.add(selcriteria.CRM_HospitalCode__c);
             system.debug('*****selectedownershipCodes'+ selectedpreferedhospitalCodes);
             }
                }
        
      }
    public void showselectedhospitals(){
        List<String> lstHospital= new List<String>();
        
        if(enc.CRM_SelectedHospitalCodes__c!=null){
            for(string s: enc.CRM_SelectedHospitalCodes__c.split(',')){
                lstHospital.add(s.trim());
                
            }
        }
         system.debug('tr@@@@'+ lstHospital);
        for(CRM_CampaignLocationReferenceData__c rt : [ select id, CRM_IsActive__c, CRM_Hospital__c, CRM_HospitalMarket__c from CRM_CampaignLocationReferenceData__c where CRM_HospitalCode__C IN: lstHospital AND CRM_IsActive__c=true ])
       {
           system.debug('tr@@@@'+ rt.CRM_HospitalMarket__c);
          selectedHospitalCriteria.add(rt.id);
       }
        system.debug('selected hospitals in method ============'+selectedHospitalCriteria );
        fetchOwnershipNames();
}
    public void showselectedpreferedhospitals(){
        List<String> lstpreferedHospital= new List<String>();
        
        if(encagg.CRM_SelectedPreferedHospitalCodes__c!=null){
            for(string s: encagg.CRM_SelectedPreferedHospitalCodes__c.split(',')){
                lstpreferedHospital.add(s.trim());
                
            }
        }
         system.debug('tr@@@@'+ lstpreferedHospital);
        for(CRM_CampaignLocationReferenceData__c rt : [ select id, CRM_IsActive__c, CRM_Hospital__c, CRM_HospitalMarket__c from CRM_CampaignLocationReferenceData__c where CRM_HospitalCode__C IN: lstpreferedHospital AND CRM_IsActive__c=true ])
       {
           system.debug('tr@@@@'+ rt.CRM_HospitalMarket__c);
          selectedPrefferedHospitalCriteria.add(rt.id);
       }
        system.debug('selected hospitals in method ============'+selectedPrefferedHospitalCriteria );
        fetchpreferedOwnershipNames();
}     
 // end of hospiptal change for encounter and encoounter aggregates   
 
    //This method will create/update/delete data from junction obejct for Encounter include hospitals
    void HospitalJunctionEncounterData(){
      
      set<string> HospitalIds = new set<string>();
      system.debug('****selectedHospitalCriteria='+selectedHospitalCriteria);
      
      HospitalIds.addAll(selectedHospitalCriteria);
      
      system.debug('****HospitalIds='+HospitalIds);
      list<CRM_EncounterHospitalJuntion__c> deleteList = new list<CRM_EncounterHospitalJuntion__c>();
      list<CRM_EncounterHospitalJuntion__c> insertList = new list<CRM_EncounterHospitalJuntion__c>();
      map<string,CRM_EncounterHospitalJuntion__c> existingRecordMap = new map<string,CRM_EncounterHospitalJuntion__c>();
      
      for(CRM_EncounterHospitalJuntion__c hospitalid : [select CRM_Hospital__c,  CRM_Encounter__c, CRM_CampaignLocationMapping__c from CRM_EncounterHospitalJuntion__c where CRM_Encounter__c=:enc.Id]){
        system.debug('****slandssl.CRM_CampaignLocationMapping__c=='+hospitalid.CRM_CampaignLocationMapping__c);
        if(!existingRecordMap.containsKey(hospitalid.CRM_CampaignLocationMapping__c))
          existingRecordMap.put(hospitalid.CRM_CampaignLocationMapping__c,hospitalid);
        
        if(!HospitalIds.contains(hospitalid.CRM_CampaignLocationMapping__c))
          deleteList.add(hospitalid);
      }
      system.debug('*****deleteList='+deleteList);
      for(String str : HospitalIds){
        if(!existingRecordMap.containsKey(str))
          insertList.add(new CRM_EncounterHospitalJuntion__c(CRM_Encounter__c=enc.Id,CRM_CampaignLocationMapping__c=str));
      }
      system.debug('*****insertList='+insertList);
      if(deleteList.size()>0)
        delete deleteList;
      
      if(insertList.size()>0)
        insert insertList;
      
    }
    
    
     //This method will create/update/delete data from junction obejct for Encounter Aggregates include hospitals
    void HospitalJunctionEncounterAggregatesData(){
      
      set<string> HospitalIds = new set<string>();
      system.debug('****selectedHospitalCriteria='+selectedPrefferedHospitalCriteria);
      
      HospitalIds.addAll(selectedPrefferedHospitalCriteria);
      
      system.debug('****HospitalIds='+HospitalIds);
      list<CRM_EncounterAggHospitalJunction__c> deleteList = new list<CRM_EncounterAggHospitalJunction__c>();
      list<CRM_EncounterAggHospitalJunction__c> insertList = new list<CRM_EncounterAggHospitalJunction__c>();
      map<string,CRM_EncounterAggHospitalJunction__c> existingRecordMap = new map<string,CRM_EncounterAggHospitalJunction__c>();
      
      for(CRM_EncounterAggHospitalJunction__c hospitalid : [select CRM_Hospital__c,  CRM_EnocunterAggregates__c, CRM_CampaignLocationEncAggMapping__c from CRM_EncounterAggHospitalJunction__c where CRM_EnocunterAggregates__c=:encagg.Id]){
        system.debug('****slandssl.CRM_CampaignLocationEncAggMapping__c=='+hospitalid.CRM_CampaignLocationEncAggMapping__c);
        if(!existingRecordMap.containsKey(hospitalid.CRM_CampaignLocationEncAggMapping__c))
          existingRecordMap.put(hospitalid.CRM_CampaignLocationEncAggMapping__c,hospitalid);
        
        if(!HospitalIds.contains(hospitalid.CRM_CampaignLocationEncAggMapping__c))
          deleteList.add(hospitalid);
      }
      system.debug('*****deleteList='+deleteList);
      for(String str : HospitalIds){
        if(!existingRecordMap.containsKey(str))
          insertList.add(new CRM_EncounterAggHospitalJunction__c(CRM_EnocunterAggregates__c=encagg.Id,CRM_CampaignLocationEncAggMapping__c=str));
      }
      system.debug('*****insertList='+insertList);
      if(deleteList.size()>0)
        delete deleteList;
      
      if(insertList.size()>0)
        insert insertList;
      
    }
}
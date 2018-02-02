@istest
public class marketingDataUtils

{
   public static Campaign CreateCampaign()
   {
            Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
            User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser00@testorg.com',CommunityNickname='Nick');
              insert u;
          
            Campaign newCampaign = new Campaign();
                newCampaign.Name='NewTestCampaign';
                newCampaign.Service_Line__c='Burn';
                newCampaign.OwnerId=u.id;
               // newCampaign.Audience_Region__c='Texas';
                newCampaign.Channel__c='Direct Mail';
        
              insert newCampaign;
              return newCampaign;
        
  } 
  
  public static Campaign createcampainDetails()
  {
          Campaign newCampaign = new Campaign();
            newCampaign.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
            newCampaign.Service_Line__c='Burn';
            newCampaign.CRM_SubServiceLineText__c='Dermatology';
            newCampaign.Tactic__c='Mail';
          //  newCampaign.Audience_Hospital__c ='Phoenix-Abrazo Arrowhead Campus;ABRAZO ARIZONA HEART HOSPITAL';
          //  newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';
            newcampaign.status='In development';
            newcampaign.program_name__c='xyz';
            
            insert newCampaign;
            
            list<CampaignMemberStatus> cmStatus=new list<CampaignMemberStatus>{
            new CampaignMemberStatus(HasResponded=true,IsDefault=false,Label='Responded',SortOrder=4,CampaignId = newCampaign.id),
            new CampaignMemberStatus(HasResponded=false,IsDefault=true,Label='Member',SortOrder=3,CampaignId = newCampaign.id)
            };
        
            insert cmStatus;
              
            return newCampaign;
  }
  public static contact createcontact()
  {
  
            Account acc = new Account();
                acc.Name='test';
                 insert acc;
         
            contact con = new Contact();
               con.AccountId = acc.id;
               con.LastName='test';
               con.Wunderman_Id__c ='12345';
                insert con;
                return con;   
  }
  
  public static CampaignMember createcampmember(Id newcampId,Id Contid)
  {
            CampaignMember campaignmem = new CampaignMember();
               campaignmem.CampaignId = newcampId;
               campaignmem.ContactId =Contid;
               //campaignmem.Contact_Identifier__c = Contid;
                 insert campaignmem;
                 return campaignmem;
  }
  public static Campaign_Member_Criteria__c createCampaignMemberCriteria(Id newcampId)
  {
            Campaign_Member_Criteria__c campmember = new Campaign_Member_Criteria__c();
                campmember.Campaign__c=newcampId;
                campmember.Exclude__c=true;
                campmember.Field_Name__c='Include_Physician_NPIs__c';
                 insert campmember;
                 return campmember; 
   }
   
 public static Campaign_Member_Criteria_Group__c createCampaignmemgrp(Id newcampId)
 {  
            Campaign_Member_Criteria_Group__c  grp = new Campaign_Member_Criteria_Group__c();
                grp.Campaign__c=newcampId;
                 insert grp;
                 return grp;
 }
          
  public static Lead createleads()
  {
          lead ld = new lead();
           ld.Status='New';
           ld.LastName ='Goel';
           ld.FirstName = 'Vaishali';
           ld.Phone = '3133630467';
           ld.Email = 'kayabe100@gmail.com';
           ld.PostalCode = '110098';
           ld.CampaignID__c = '2016-05-24-044-Detroit-Florida-Miami-BMC-OB/GYN-Radio Internet-V1Undo';
           ld.SourceSystem__c='CONIFER';
           ld.Company ='NTT';
           //ld.Is_Processed__c = False;
            insert ld;
            return ld;
  }
  
  public static Transaction__c createTransaction(Id newcampId,Id ld)
  {
          Transaction__c Transation = new Transaction__c();
           Transation.Campaign__c = newcampId;
           Transation.Request_URL__c ='test';
           Transation.Transaction_Source__c = 'Name Match';
           Transation.Campaign_Member_Status__c='Ready to Process';
           Transation.Lead_SFDC_Id__c = ld;
           Transation.Response_Schema__c ='ok this is just response schema';
           Transation.WM_List_Order_Id__c=123456; 
           Transation.Type__c='GetOrderData';
            insert Transation;
            return Transation;
  }
     
  public static Interaction__c createineraction(Id newcampId,Id Contid)
  
  {   
          Interaction__c inter = new Interaction__c();
           inter.Response_For_Campaign__c=newcampId;
           inter.Response_By_Campaign_Member__c=Contid;
            insert inter;
            return inter;
  }
           
  public static Campaign_Demographics__c createDemographics(Id newcampId)
  {
            Campaign_Demographics__c demographic = new Campaign_Demographics__c();
            demographic.Campaign__c= newcampId;
            demographic.AgeTo_UI__c =12;
            demographic.AgeFrom_UI__c =22;
            
                insert demographic;
                return demographic;
  
  }  
    public static Campaign_Demographics__c createDemographicsOtherFields(Id newcampId)
{
         Campaign_Demographics__c demographic = new Campaign_Demographics__c();
            demographic.Campaign__c= newcampId;
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
            Demographic.Net_Worth_3_0__c='$0 or Less';    
            Demographic.Presence_of_Children__c=true;    
            Demographic.Presence_of_Donor__c=true;    
            Demographic.Religion__c='Buddhist';    
            Demographic.Presence_of_Elderly_Parents__c=true;    
            Demographic.Race__c='Asian';     
            Demographic.to_Number_of_Persons_in_HH__c='Test';    
            Demographic.Suppression_Non_emailable__c='Has an email address';    
            Demographic.Move_Activity_in_Months__c='01';    
            Demographic.Address_Deliverable__c='Has a valid or foreign mailing address'; 
            demographic.Birthdate__c=Date.newinstance(1993,03,01);
            demographic.to_1__c=Date.newinstance(2016,12,12);
            demographic.Number_of_Children__c='10';
            demographic.to_Number_of_Children__c='20';
            demographic.to_Number_of_Persons_in_HH__c='10';
            demographic.Number_of_Persons_in_HH__c='2';
            demographic.Number_of_Adults_in_HH__c='10';
            demographic.to_Number_of_Adults_in_HH__c='20';
            demographic.Est_Discretionary_Income_Percent__c='21';                     
                insert demographic;
                return demographic;
     }                     
  public static Campaign_HRA__c createCampaignHRA(Id newcampId)
  {
          Campaign_HRA__c Hra = new Campaign_HRA__c();
          Hra.Name='hraTest';
          Hra.Campaign__c=newcampId;
          
            insert Hra;
            return Hra;
   }
  
  public static Model__c createCampaignModel(Id newcampId)  {
    Model__c campaignModel = New Model__c();
    campaignModel.Campaign__c= newcampId;
    insert campaignModel;
    return campaignModel;
    }
  public static DRG_Code_Information__c createDRGCodeInformation(Id newcampId){
       DRG_Code_Information__c  DRGCode = new DRG_Code_Information__c();
       DRGCode.Campaign__c= newcampId;
       DRGCode.Exclude__c= True;
     insert DRGCode;
     return DRGCode;
   }  
  public static Encounter__c createEncounter(Id newcampId)
  {
      Encounter__c  encounter = new Encounter__c();
      encounter.Campaign__c= newcampId;
    insert encounter;
    return encounter;
  }
  
  public static Encounter_aggregates__c  createaggregates(Id newcampId)
  {
      Encounter_aggregates__c  encounteraggregate = new Encounter_aggregates__c();
            encounteraggregate.Campaign__c=newcampId;
            encounteraggregate.Number_of_ER_Encounters_To__c='999';
            encounteraggregate.Number_of_ER_Encounters__c='999';
            encounteraggregate.Last_Discharge_Date_From_UI__c=Date.newInstance(2015,01,20);
            encounteraggregate.Last_Discharge_Date_Criteria_Element_Id__c='test';
            encounteraggregate.Last_Discharge_Date_Ranges__c='test';
            encounteraggregate.Last_Discharge_Date_To_UI__c=Date.newInstance(2015,01,25);
            encounteraggregate.No_of_ER_Encounters_ranges__c='test';
            encounteraggregate.Preffered_Hospital__c='Alabama - Citizens Medical Center';
            encounteraggregate.Wunderman_Preferred_Hospitals__c='test';
             insert encounteraggregate;
             return encounteraggregate;
  }
  
  public static Life_Style__c createLifeStyle(Id newcampId)
  {
  Life_Style__c lifestyle = new Life_Style__c();
  lifestyle.Campaign__c= newcampId;
  lifestyle.Aches_and_Pain_AGPAIN__c=True;
  lifestyle.Ailment_Present_Any__c=True;
  lifestyle.Allergies_and_Sinuses_AGNOSE__c=True;
  lifestyle.Cancer_AGCANCER__c=True;
 insert lifestyle;
 return lifestyle;
 }
           public static Life_Style__c createLifestyleotherfields(Id newcampId)
           {
             Life_Style__c lifestyle = new Life_Style__c();
              lifestyle.Campaign__c= newcampId;
              lifestyle.Aches_and_Pain_AGPAIN__c=True;  
              lifestyle.Ailment_Present_Any__c=True;  
              lifestyle.Allergies_and_Sinuses_AGNOSE__c=True;  
              lifestyle.Cancer_AGCANCER__c=True;  
              lifestyle.Cholesterol_and_Blood_Pressure_AGBLOOD__c=True;  
              lifestyle.Diabetes_AGDIAB__c=True;  
              lifestyle.Digestive_AGDIG__c=True;  
              lifestyle.Do_It_Yourself__c=True;
              lifestyle.Female_Conditions_AGFEM__c=True;  
              lifestyle.Fine_Arts__c=True;  
              lifestyle.Foot_AGFOOT__c=True;  
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
              lifestyle.Health_Ins_Subsidy_Ind__c='Households that may qualify for Medicaid based on the number of persons present and their estimated household income.';
              lifestyle.Healthcare_Treatment_Pref__c='1'; 
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
               return lifestyle;
  }
               
  public static Track_History__c createTrackHistory(Id newcampId)
  {
         Track_History__c History = new Track_History__c();
             History.Campaign__c= newcampId;
                 insert History;
                 return History;
  }
  
    public static Location__c createlocation()
    {
        Location__c Loc = new Location__c();
              loc.Hospital__c = 'ABRAZO ARIZONA HEART HOSPITAL';
              loc.Market__c = 'Dellas';
              loc.Region__c = 'Texas';
              loc.Service_Area__c = 'test';
              loc.Lattitude__c = '40.8154';
              loc.Longitude__c = '-73.0456';
              loc.Zip_Code__c = '22222222';
              loc.HSPCD__c  = 'test';
          
        insert Loc;
        return Loc;
    }
    
    public static Campaign_Location__c createLocationInformation(id newcampId,id Loc)
    {
        Campaign_Location__c Locinfo = new Campaign_Location__c();
         Locinfo.Campaign__c=newcampId;
         Locinfo.Location__c=Loc;
         insert Locinfo;
         return Locinfo;
    }
    
 
    public static ICD_Diagnosis__c creatediagnosis()
    {
        ICD_Diagnosis__c diagnose = new ICD_Diagnosis__c();
            diagnose.DIAGNOSIS_CODE__c='45372' ;
            diagnose.Long_Description__c = 'Chronic venous embolism and thrombosis of deep veins of upper extremity' ;
            diagnose.Short_Description__c = 'Ch DVT/embl up ext' ;
            diagnose.Type_Of_Diagnosis__c = 'ICD9' ;    
                insert diagnose ;
                return diagnose ;
    }
    
    
    public static   ICD_Diagnosis_In__c creatediagnosisinformation(id newcampId,id diagnose ){
    
    ICD_Diagnosis_In__c diagnoseinfo = new ICD_Diagnosis_In__c();
    diagnoseinfo.Campaign__c = newcampId;
    diagnoseinfo.ICD_Diagnosis__c = diagnose;
    insert diagnoseinfo;
    return diagnoseinfo;
    }
    
    
    public static DRG_Code__c createDRGcode()
    {
        DRG_Code__c codes = new DRG_Code__c();
        codes.Description__c='This is location';
        codes.MS_DRG__c='Test';
        codes.Service_Line__c='All Other';
        codes.Sub_Service_Line__c='Dental';
        insert codes;
        return codes;
    }  
     
    public static DRG_Code_Information__c createDRGCodeDetails(Id newcampId,id codesid)
    {
           DRG_Code_Information__c  DRGCode = new DRG_Code_Information__c();
               DRGCode.Campaign__c= newcampId;
               DRGCode.DRG_Code__c=codesid;
               DRGCode.Exclude__c= True;
                 insert DRGCode;
                 return DRGCode;
    }  
       
    public static Geographic__c createGeographic()
    {
    Geographic__c geo = new Geographic__c();
      geo.CBSA__c='Anchorage, AK';
      geo.City__c='ANCHORAGE';
      geo.County__c='ANCHORAGE';
      geo.ZipCode__c='99501';
      geo.Latitude__c='40.8154';
      geo.Longitude__c='-73.0456';
      geo.State__c='AK';
      insert geo;
      return geo;
    }
    
      public static Geographic_Info_Information__c createGeographicInfo(Id newcampId,ID geoId){
      Geographic_Info_Information__c geoinfo = new Geographic_Info_Information__c();
           geoinfo.Campaign__c=newcampId;
           geoinfo.Geographic_Info__c=geoid;
              insert geoinfo;
              return geoinfo;
     }         
     
     
     
     
       public static Error_Log__c createErrorlogs(){
       Error_Log__c  Logs = new Error_Log__c();
        Logs.Error_Description__c='Desc';
        Logs.Error_Line_Number__c=2;
        Logs.Error_Number__c=2;
        Logs.Error_Source__c='Name Match';
        Logs.Error_Type__c='New';
        Logs.Stack_Trace__c='Trace';
         Insert Logs;
         Return Logs;
  } 
  
  public static Data_Element_Identifier__c createDataElementIdentifier()
  {
   Data_Element_Identifier__c elementidentifier = new Data_Element_Identifier__c();
    elementidentifier.Data_Element_Identifier__c = 'ZIPCD';
     elementidentifier.Data_Element_Name__c='ZIP Code';
     elementidentifier.Display_Type_Code__c='GEO.MANUAL';
     //elementidentifier.Value_Mapping__c='{"Out Patient":"O","In Patient":"I"}';
     elementidentifier.Field_Name__c ='Wunderman_Preferred_Hospitals';
      insert elementidentifier;
      return elementidentifier;
   }
      
  public static Campaign_HRA__c createCampaignHRAotherfields(id newcampId){
   Campaign_HRA__c hracon = new Campaign_HRA__c ();
          hracon.Name='hraconTest';
          hracon.Campaign__c=newcampId;
          hracon.Asthma_Risk_Category__c='test';
          hracon.Back_Neck_Impairement__c='test';
          hracon.BMI_Category__c='test';
          hracon.Breast_Cancer_5_Year__c='test';
          hracon.Diabetes_Risk__c='test';
          hracon.Incontinence_Symptoms__c='test';
          hracon.Interest_Baria__c=true;
          hracon.Interest_Cardiology__c=true;
          hracon.Interest_Emergency__c=true;
          hracon.Interest_Obstetrics__c=true;
          hracon.Interest_Orthopedics__c=true;
          hracon.Interest_Pediatrics__c=true;
          hracon.Joint__c='test';
          hracon.Joint_Assessment__c='test';
          hracon.Joint_BMI_Category__c='test';
          hracon.Lifetime_Risk_Category__c='test';
          hracon.Lung_Screening__c='test';
          hracon.OrthoOsteoarthritis_Joint_Disease__c=true;
          hracon.Ortho_Pain_Type__c='test';
          hracon.Pad_Risk_Category__c='test';
          hracon.Prostate_Risk_Category__c='test';
          hracon.qoL_Impact__c='test';
          hracon.Risk_Category__c='test';
          hracon.Risk_Category_30_Years__c='test';
          hracon.Stroke_Risk_Category__c='test';
          hracon.Weight_Loss_Rec__c='test';
          hracon.Weight_Loss_Surgery_Rec__c='test';                   
            insert hracon;
            return hracon;
    }
    
    public static void createTagMapping()
    {
            list<XML_Tag_Mapping__c> xmlList=new list<XML_Tag_Mapping__c>{new XML_Tag_Mapping__c(XML_Tag_Value__c='Suffix',XML_Tag__c='SUFFIXE',XML_Type__c='Request'),
            new XML_Tag_Mapping__c(XML_Tag_Value__c='Phone',XML_Tag__c='PHONE',XML_Type__c='Request'),
            new XML_Tag_Mapping__c(XML_Tag_Value__c='Email',XML_Tag__c='EMAIL',XML_Type__c='Request'),
            new XML_Tag_Mapping__c(XML_Tag_Value__c='LastName',XML_Tag__c='LAST_NAME',XML_Type__c='Request'),
            new XML_Tag_Mapping__c(XML_Tag_Value__c='FirstName',XML_Tag__c='FIRST_NAME',XML_Type__c='Request'),
            new XML_Tag_Mapping__c(XML_Tag_Value__c='Salutation',XML_Tag__c='HONORIFIC',XML_Type__c='Request'),
            new XML_Tag_Mapping__c(XML_Tag_Value__c='Street',XML_Tag__c='ADDRESS',XML_Type__c='Request'),
            new XML_Tag_Mapping__c(XML_Tag_Value__c='MiddleName',XML_Tag__c='MID_NAME',XML_Type__c='Request'),
            new XML_Tag_Mapping__c(XML_Tag_Value__c='PostalCode',XML_Tag__c='ZIP',XML_Type__c='Request'),
            new XML_Tag_Mapping__c(XML_Tag_Value__c='mkto_dateOfBirth__c',XML_Tag__c='DOB',XML_Type__c='Request'),
            new XML_Tag_Mapping__c(XML_Tag_Value__c='City',XML_Tag__c='CITY',XML_Type__c='Request'),
            new XML_Tag_Mapping__c(XML_Tag_Value__c='State',XML_Tag__c='STATE',XML_Type__c='Request'),
            new XML_Tag_Mapping__c(XML_Tag_Value__c='Email',XML_Tag__c='emailAddress',XML_Type__c='Response'),
            new XML_Tag_Mapping__c(XML_Tag_Value__c='Wunderman_Id__c',XML_Tag__c='id',XML_Type__c='Response'),
            new XML_Tag_Mapping__c(XML_Tag_Value__c='LastName',XML_Tag__c='lastName',XML_Type__c='Response'),
            new XML_Tag_Mapping__c(XML_Tag_Value__c='MiddleName',XML_Tag__c='middleName',XML_Type__c='Response'),
            new XML_Tag_Mapping__c(XML_Tag_Value__c='MailingState',XML_Tag__c='state',XML_Type__c='Response'),
            new XML_Tag_Mapping__c(XML_Tag_Value__c='MailingStreet',XML_Tag__c='address1',XML_Type__c='Response'),
            new XML_Tag_Mapping__c(XML_Tag_Value__c='Phone',XML_Tag__c='telephone',XML_Type__c='Response'),
            new XML_Tag_Mapping__c(XML_Tag_Value__c='FirstName',XML_Tag__c='firstName',XML_Type__c='Response'),
            new XML_Tag_Mapping__c(XML_Tag_Value__c='DOB__c',XML_Tag__c='dob',XML_Type__c='Response'),
            new XML_Tag_Mapping__c(XML_Tag_Value__c='MailingCountry',XML_Tag__c='country',XML_Type__c='Response'),
            new XML_Tag_Mapping__c(XML_Tag_Value__c='MailingCity',XML_Tag__c='city',XML_Type__c='Response'),
            new XML_Tag_Mapping__c(XML_Tag_Value__c='Suffix',XML_Tag__c='suffix',XML_Type__c='Response')};
            
            insert xmlList;
    }
    public static Account createAccount(){
        Account acc= new Account(Name='Test');
        insert acc;
        return acc;
    
    }
    public static void createCustomSetting()
    {
            list<Tenet_Data_Configuration__c> customsettinglist=new list<Tenet_Data_Configuration__c>{new Tenet_Data_Configuration__c(Name='End Point',Static_Value__c='http://example.com'),
            new Tenet_Data_Configuration__c(Name='Marketo User Id',Static_Value__c='00521000000lNx6'),
            new Tenet_Data_Configuration__c(Name='Message Type Code',Static_Value__c='IDENTIFY.CONSUMER'),
            new Tenet_Data_Configuration__c(Name='Order Id',Static_Value__c='123'),
            new Tenet_Data_Configuration__c(Name='Page Size',Static_Value__c='5000'),
            new Tenet_Data_Configuration__c(Name='Security Token',Static_Value__c='cd6osdf6878G'),
            new Tenet_Data_Configuration__c(Name='Username'),
            new Tenet_Data_Configuration__c(Name='Account Id',Static_Value__c=string.valueOf(createAccount().Id))};
            
            insert customsettinglist;
    }
    

   public static CRM_CampaignLocationReferenceData__c createRegionMarket()
    {
             Campaign newCampaign = new Campaign();
             newCampaign.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
             newCampaign.Service_Line__c='Burn';
             newCampaign.CRM_SubServiceLineText__c='Burn';
             newCampaign.Vendor_Name__c='BG Solutions BS';
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
        Id Recordtypemarket = Schema.SObjectType.CRM_CampaignLocationReferenceData__c.getRecordTypeInfosByName().get('Market').getRecordTypeId(); 
        CRM_CampaignLocationReferenceData__c refdata = new CRM_CampaignLocationReferenceData__c();
             refdata.CRM_Market__c='Baylor/Tenet JV Region';
             refdata.CRM_MarketCode__c='CR3';
             refdata.CRM_MarketsRegionID__c=locationrefregiondata.id;
             refdata.RecordTypeId=Recordtypemarket;
             refdata.CRM_IsActive__c=True;
          insert refdata;
        
          return refdata;
    }
    Public static CRM_CampaignLocationReferenceData__c createServiceArea()
    {
      Id Recordtypelocation = Schema.SObjectType.CRM_CampaignLocationReferenceData__c.getRecordTypeInfosByName().get('Service Area').getRecordTypeId(); 
        CRM_CampaignLocationReferenceData__c locationrefdata = new CRM_CampaignLocationReferenceData__c();
             locationrefdata.CRM_ServiceArea__c='Primary Service Area';
             locationrefdata.CRM_ServiceAreaCode__c='PSA';
             locationrefdata.RecordTypeId=Recordtypelocation;
             locationrefdata.CRM_IsActive__c=True;
          insert locationrefdata;
          return locationrefdata;     
    }
    Public static Campaign campforhomeaddress()
    {
        Campaign newCampaigns = new Campaign();
             newCampaigns.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
             newCampaigns.Service_Line__c='Burn';
             newCampaigns.CRM_SubServiceLineText__c='Dermatology';
             newCampaigns.Vendor_Name__c='BG Solutions BS';
             newCampaigns.CRM_SelectedOwnershipCriteria__c='AHH;AHD';
             newCampaigns.CRM_OwnershipType__c='Hospital';
             newCampaigns.Status ='In Development';
             newCampaigns.Call_to_Action__c='HRA';
             newCampaigns.Member_Types__c='One or more encounters - Patients';
             newCampaigns.Channel__c='Direct Mail';
             newcampaigns.status='In development';
             
             
           insert newCampaigns;
           return newCampaigns;
    }
   public static CRM_CampaignLocationReferenceData__c createrefHospital()   
   {
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
          return Hospitalrefdata;
        }
    public static CRM_CampaignGeographyReferenceData__c createrefCBSA()
        {
        Id RecordtypeCBSA = Schema.SObjectType.CRM_CampaignGeographyReferenceData__c.getRecordTypeInfosByName().get('CBSA').getRecordTypeId(); 
    CRM_CampaignGeographyReferenceData__c geographyrefData = new CRM_CampaignGeographyReferenceData__c();
             geographyrefData.CRM_CBSA__c='Aberdeen, SD';
             geographyrefData.CRM_IsActive__c=True;
             geographyrefData.RecordTypeId=RecordtypeCBSA;
       insert geographyrefData; 
        return geographyrefdata;
        }
        public static CRM_CampaignGeographyReferenceData__c createstate()
        {
        Id Recordtypesstate = Schema.SObjectType.CRM_CampaignGeographyReferenceData__c.getRecordTypeInfosByName().get('State').getRecordTypeId(); 
      CRM_CampaignGeographyReferenceData__c geostaterefData = new CRM_CampaignGeographyReferenceData__c();
             geostaterefData.CRM_State__c='Missouri';
             geostaterefData.CRM_StateCode__c='MO';
             geostaterefData.CRM_IsActive__c=True;
             geostaterefData.RecordTypeId=Recordtypesstate;
       insert geostaterefData;
        return geostaterefData;
        }
      public static CRM_CampaignGeographyReferenceData__c createcounty()
        {
            Id Recordtypesstate = Schema.SObjectType.CRM_CampaignGeographyReferenceData__c.getRecordTypeInfosByName().get('State').getRecordTypeId(); 
      CRM_CampaignGeographyReferenceData__c geostaterefData = new CRM_CampaignGeographyReferenceData__c();
                 geostaterefData.CRM_State__c='Missouri';
                 geostaterefData.CRM_StateCode__c='MO';
                 geostaterefData.CRM_IsActive__c=True;
                 geostaterefData.RecordTypeId=Recordtypesstate;
               insert geostaterefData;
           Id RecordtypeCounty = Schema.SObjectType.CRM_CampaignGeographyReferenceData__c.getRecordTypeInfosByName().get('County').getRecordTypeId(); 
           CRM_CampaignGeographyReferenceData__c countyrefData = new CRM_CampaignGeographyReferenceData__c();
                 countyrefData.CRM_County__c='DALLAS';
                 countyrefData.CRM_CountysStateID__c=geostaterefData.id;
                 countyrefData.CRM_IsActive__c=True;
                 countyrefData.RecordTypeId=RecordtypeCounty;
               insert countyrefData;
               return countyrefData;
        } 
        public static CRM_ZipCodeReferenceData__c  createZipcode()
        {
        
        Id RecordtypeCBSA = Schema.SObjectType.CRM_CampaignGeographyReferenceData__c.getRecordTypeInfosByName().get('CBSA').getRecordTypeId(); 
        CRM_CampaignGeographyReferenceData__c geographyrefData = new CRM_CampaignGeographyReferenceData__c();
             geographyrefData.CRM_CBSA__c='Aberdeen, SD';
             geographyrefData.CRM_IsActive__c=True;
             geographyrefData.RecordTypeId=RecordtypeCBSA;
           insert geographyrefData;
        Id Recordtypesstate = Schema.SObjectType.CRM_CampaignGeographyReferenceData__c.getRecordTypeInfosByName().get('State').getRecordTypeId(); 
        CRM_CampaignGeographyReferenceData__c geostaterefData = new CRM_CampaignGeographyReferenceData__c();
             geostaterefData.CRM_State__c='Missouri';
             geostaterefData.CRM_StateCode__c='MO';
             geostaterefData.CRM_IsActive__c=True;
             geostaterefData.RecordTypeId=Recordtypesstate;
           insert geostaterefData;
        Id RecordtypeCounty = Schema.SObjectType.CRM_CampaignGeographyReferenceData__c.getRecordTypeInfosByName().get('County').getRecordTypeId(); 
        CRM_CampaignGeographyReferenceData__c countyrefData = new CRM_CampaignGeographyReferenceData__c();
             countyrefData.CRM_County__c='DALLAS';
             countyrefData.CRM_CountysStateID__c=geostaterefData.id;
             countyrefData.CRM_IsActive__c=True;
             countyrefData.RecordTypeId=RecordtypeCounty;
           insert countyrefData;
        CRM_ZipCodeReferenceData__c zip = new CRM_ZipCodeReferenceData__c();
             zip.CRM_IsActive__c=true;
             zip.CRM_ZipCode__c='75040';
             zip.CRM_ZipsCBSAID__c=geographyrefData.id;
             zip.CRM_ZipsCountyID__c=countyrefData.id;
             zip.CRM_IsActive__c=True;
           insert zip;
           return Zip;
        }   
        public static CRM_Hospital_Zip_ServiceArea_Ref_Data__c createHospitalZipMapping()
        {
        Id Recordtypesstate = Schema.SObjectType.CRM_CampaignGeographyReferenceData__c.getRecordTypeInfosByName().get('State').getRecordTypeId(); 
        CRM_CampaignGeographyReferenceData__c geostaterefData = new CRM_CampaignGeographyReferenceData__c();
             geostaterefData.CRM_State__c='Missouri';
             geostaterefData.CRM_StateCode__c='MO';
             geostaterefData.CRM_IsActive__c=True;
             geostaterefData.RecordTypeId=Recordtypesstate;
           insert geostaterefData;
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
        Id RecordtypeCBSA = Schema.SObjectType.CRM_CampaignGeographyReferenceData__c.getRecordTypeInfosByName().get('CBSA').getRecordTypeId(); 
        CRM_CampaignGeographyReferenceData__c geographyrefData = new CRM_CampaignGeographyReferenceData__c();
             geographyrefData.CRM_CBSA__c='Aberdeen, SD';
             geographyrefData.CRM_IsActive__c=True;
             geographyrefData.RecordTypeId=RecordtypeCBSA;
           insert geographyrefData;
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
        Id RecordtypeCounty = Schema.SObjectType.CRM_CampaignGeographyReferenceData__c.getRecordTypeInfosByName().get('County').getRecordTypeId(); 
        CRM_CampaignGeographyReferenceData__c countyrefData = new CRM_CampaignGeographyReferenceData__c();
             countyrefData.CRM_County__c='DALLAS';
             countyrefData.CRM_CountysStateID__c=geostaterefData.id;
             countyrefData.CRM_IsActive__c=True;
             countyrefData.RecordTypeId=RecordtypeCounty;
           insert countyrefData;
        CRM_ZipCodeReferenceData__c zip = new CRM_ZipCodeReferenceData__c();
             zip.CRM_ZipCode__c='75040';
             zip.CRM_ZipsCBSAID__c=geographyrefData.id;
             zip.CRM_ZipsCountyID__c=countyrefData.id;
             zip.CRM_IsActive__c=True;
           insert zip;
        CRM_Hospital_Zip_ServiceArea_Ref_Data__c HZSA = new CRM_Hospital_Zip_ServiceArea_Ref_Data__c();
             HZSA.CRM_HZSAsHospitalID__c=Hospitalrefdata.id;
             HZSA.CRM_HZSAsServiceAreaID__c=locationrefdata.id;
             HZSA.CRM_HZSAsZipID__c=zip.id;
             HZSA.CRM_IsActive__c=True;
           insert HZSA;
           return HZSA;
        }
        public static CRM_CampaignLocationReferenceData__c  createRegion()
        {
        Id Recordtypereglocation = Schema.SObjectType.CRM_CampaignLocationReferenceData__c.getRecordTypeInfosByName().get('Region').getRecordTypeId(); 
        CRM_CampaignLocationReferenceData__c locationrefregiondata = new CRM_CampaignLocationReferenceData__c();
             locationrefregiondata.CRM_Region__c='Baylor/Tenet JV Region';
             locationrefregiondata.CRM_RegionCode__c='CR3';
             locationrefregiondata.RecordTypeId=Recordtypereglocation;
             locationrefregiondata.CRM_IsActive__c=True;
          insert locationrefregiondata;
          return locationrefregiondata;
        }
        /*
        public static CRM_AudienceUpload__c createAudienceUpload()
        {
        CRM_AudienceUpload__c au = new CRM_AudienceUpload__c();
            au.CRM_WundermanId__c='12323443';
            insert au;
            return au;
        }
        */
   Public static CRM_AudienceUploadJunction__c createAudienceJunction(id newCampaignsId)
   {    
        Id audience = Schema.SObjectType.CRM_AudienceUploadJunction__c.getRecordTypeInfosByName().get('Audience Upload').getRecordTypeId(); 
        CRM_AudienceUploadJunction__c junctionupload = new CRM_AudienceUploadJunction__c();
        junctionupload.CRM_AudienceCount__c=56752;
        junctionupload.RecordTypeId=audience;
        junctionupload.CRM_Campaign__c=newCampaignsId;
        junctionupload.CRM_ToDelete__c=False;
        insert junctionupload;
        return junctionupload;
   }
    Public static CRM_AudienceUploadJunction__c createAudienceJunctin(id newCampaignsId)
   {    
        Id audience = Schema.SObjectType.CRM_AudienceUploadJunction__c.getRecordTypeInfosByName().get('Audience Upload').getRecordTypeId(); 
        CRM_AudienceUploadJunction__c junctionuplod = new CRM_AudienceUploadJunction__c();
        junctionuplod.CRM_AudienceCount__c=56752;
        junctionuplod.RecordTypeId=audience;
        junctionuplod.CRM_Campaign__c=newCampaignsId;
        junctionuplod.CRM_ToDelete__c=True;
        insert junctionuplod;
        return junctionuplod;
   }
   /*
   Public static CRM_AudienceUpload__c createAudienceUpload(id junctionuplodId)
   {
       CRM_AudienceUpload__c  audienceupload = new CRM_AudienceUpload__c();
           audienceupload.CRM_AudienceUploadJunction__c=junctionuplodId;
           audienceupload.CRM_CampaignName__c='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
           audienceupload.CRM_WundermanId__c='69755';
          insert audienceupload;
          return audienceupload;
   }
   
    public static CRM_AudienceUpload__c createAudienceUploadd()
    {
    CRM_AudienceUpload__c au = new CRM_AudienceUpload__c();
        au.CRM_WundermanId__c='12323443';
        insert au;
        return au;
        }
    */
    public static contact createNewcontact()
    {
    contact cont = new Contact();
        cont.LastName='Gupta';
        cont.Wunderman_Id__c ='69755';
        cont.HospitalName__c='Baylor Scott & White Medical Center White Rock';
       insert cont;
       return cont;   
  }
  public static Transaction__c createnewTransaction(Id newCampaigns,Id ld)
  {
          Transaction__c Transtion = new Transaction__c();
           Transtion.Campaign__c = newCampaigns;
           Transtion.Type__c='GetOrderData';
           Transtion.Campaign_Member_Status__c='Ready to Process';
           Transtion.Lead_SFDC_Id__c = ld;
           Transtion.WM_List_Order_Id__c=1162755;
           Transtion.Response_Schema__c ='<ROOT><LIST_ORDER><LIST_ORDER_ID>1162755</LIST_ORDER_ID><INVOICE_GEN_TYPE_CD><![CDATA[GROUPBYPO]]></INVOICE_GEN_TYPE_CD><SERVICE_ID>1</SERVICE_ID><ORG_ID>23433</ORG_ID><LIST_PRDCT_ID>980</LIST_PRDCT_ID><DEAL_TYPE_CD><![CDATA[STD]]></DEAL_TYPE_CD><LIST_ORDER_TYPE_CD><![CDATA[IQ.COUNT]]></LIST_ORDER_TYPE_CD><LIST_ORDER_STATUS_CD><![CDATA[IQ.COUNT]]></LIST_ORDER_STATUS_CD><PURCHASE_METHOD_CD><![CDATA[ACCOUNT]]></PURCHASE_METHOD_CD><PROCESS_TYPE_CD><![CDATA[NEEDSREVIEW]]></PROCESS_TYPE_CD><PRICE_GRP_RATE_TIER_ID></PRICE_GRP_RATE_TIER_ID><ORG_MAILER_ID></ORG_MAILER_ID><KEYCODE_TYPE_CD><![CDATA[]]></KEYCODE_TYPE_CD><QUERY_TYPE_CD><![CDATA[DISTINCT.INDIVIDUAL]]></QUERY_TYPE_CD><DEAL_TYPE_PCT>1</DEAL_TYPE_PCT><LIST_ORDER_DESC><![CDATA[]]></LIST_ORDER_DESC><DEAL_TYPE_RUN_CHRG_AMT>1</DEAL_TYPE_RUN_CHRG_AMT><QUERY_KEY><![CDATA[1162755]]></QUERY_KEY><PO_NUMBER><![CDATA[]]></PO_NUMBER><LIST_ORDER_NM><![CDATA[SFDC]]></LIST_ORDER_NM><SALES_REP_USERNAME><![CDATA[shalbeisen]]></SALES_REP_USERNAME><OPERATOR_USERNAME><![CDATA[tenettest]]></OPERATOR_USERNAME><LIST_ORDER_DTTM></LIST_ORDER_DTTM><LAST_RUN_DTTM>14-AUG-17</LAST_RUN_DTTM><DROP_DTTM></DROP_DTTM><LIST_ORDER_COUNT>0</LIST_ORDER_COUNT><PROCESSING_COUNT>0</PROCESSING_COUNT><ADJ_LIST_ORDER_COUNT>0</ADJ_LIST_ORDER_COUNT><LIST_ORDER_TOTAL>0</LIST_ORDER_TOTAL><SUPPRESS_IND>0</SUPPRESS_IND><SUPPRESS_TABLE_NM><![CDATA[]]></SUPPRESS_TABLE_NM><REMEMBER_MONTHS>12</REMEMBER_MONTHS><IFL_DATA_SET_NM><![CDATA[]]></IFL_DATA_SET_NM><ADDITIONAL_PROCESSING_IND>0</ADDITIONAL_PROCESSING_IND><RESTRICT_PHONE_IND>0</RESTRICT_PHONE_IND><BILLING_CONTACT_NAME><![CDATA[]]></BILLING_CONTACT_NAME><BILLING_ADDRESS_LINE><![CDATA[]]></BILLING_ADDRESS_LINE><BILLING_CITY><![CDATA[]]></BILLING_CITY><BILLING_STATE_CD><![CDATA[]]></BILLING_STATE_CD><BILLING_ZIP><![CDATA[]]></BILLING_ZIP><BILLING_PHONE_NUMBER><![CDATA[]]></BILLING_PHONE_NUMBER><BILLING_FAX_NUMBER><![CDATA[]]></BILLING_FAX_NUMBER><BILLING_NOTES><![CDATA[]]></BILLING_NOTES><CREATED_USERID><![CDATA[tenettest]]></CREATED_USERID><UPDATED_USERID><![CDATA[tenettest]]></UPDATED_USERID><CREATED_DTTM>14-AUG-17</CREATED_DTTM><UPDATED_DTTM>14-AUG-17</UPDATED_DTTM><UPDATED_TIMESTAMP>2017-08-14 04:32:16.405000000</UPDATED_TIMESTAMP><MAIL_DTTM></MAIL_DTTM><GRAND_RAD>0</GRAND_RAD><STACK_IND>0</STACK_IND><ORG_NM><![CDATA[Tenet Health System Medical Inc]]></ORG_NM><ORG_NO><![CDATA[6710]]></ORG_NO><ORG_ACCTNG_NO><![CDATA[6710]]></ORG_ACCTNG_NO><PUB_LIST_PRDCT_NM><![CDATA[Tenet Health Care UAT]]></PUB_LIST_PRDCT_NM><UPDATED_TIMESTAMP><![CDATA[2017-08-14 04:32:16.405000000]]></UPDATED_TIMESTAMP><ADDITIONAL_PROCESSING_NOTES><![CDATA[null]]></ADDITIONAL_PROCESSING_NOTES><LIST_ORDER_SELECT_GRP><LIST_ORDER_SELECT_GRP_ID>1739303</LIST_ORDER_SELECT_GRP_ID><LIST_ORDER_SELECT_GRP_NM><![CDATA[]]></LIST_ORDER_SELECT_GRP_NM><SELECT_GRP_TYPE_CD><![CDATA[INCLUDE.ALL]]></SELECT_GRP_TYPE_CD><SELECT_GRP_TYPE_NM><![CDATA[Include All ]]></SELECT_GRP_TYPE_NM><GROUP_NUM>0</GROUP_NUM><NTH_POS></NTH_POS><START_POS></START_POS><STOP_POS></STOP_POS><RESULT_COUNT></RESULT_COUNT><PROCESSING_COUNT>-1</PROCESSING_COUNT><UPDATED_TIMESTAMP><![CDATA[2017-08-14 04:32:15.467774000]]></UPDATED_TIMESTAMP><KEYCODE></KEYCODE></LIST_ORDER_SELECT_GRP></LIST_ORDER><!--LO_SUPPRESS_TYPE_XREF.java!!!--><SUPPRESSION><RESULT><RETURNCODE>0</RETURNCODE><RECORDCOUNT>0</RECORDCOUNT><MESSAGE>Returned 0 rows</MESSAGE><PAGE>1</PAGE><LASTPAGE>1</LASTPAGE><PAGESIZE>0</PAGESIZE></RESULT></SUPPRESSION><RESULT><RETURNCODE>0</RETURNCODE><MESSAGE>Returned Count Criteria</MESSAGE></RESULT></ROOT>';
            insert Transtion;
            return Transtion;
  } 
  Public static Campaign createcampforPP()
  {
  Campaign cmpaigns = new Campaign();
     cmpaigns.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
     cmpaigns.Service_Line__c='Burn';
     //cmpaigns.Sub_Service_Line__c='Burn';
     cmpaigns.Vendor_Name__c='BG Solutions BS';
     cmpaigns.CRM_SelectedOwnershipCriteria__c='AHH;AHD';
     cmpaigns.CRM_OwnershipType__c='Hospital';
     cmpaigns.Ignore_Bad_Debt_Suppression__c=True;
     cmpaigns.Call_to_Action__c='HRA';
     cmpaigns.List_Order_Id__c=1162755;
     cmpaigns.Member_Types__c='One or more encounters - Patients';
     cmpaigns.Channel__c='Direct Mail';
     cmpaigns.status='In development';
   insert cmpaigns;
   return cmpaigns;
   }
   Public static Campaign createcampsegmented()
   {
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
   
  Campaign cmpaigns = new Campaign();
     cmpaigns.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
     cmpaigns.Service_Line__c='Burn';
     //cmpaigns.Sub_Service_Line__c='Burn';
     cmpaigns.Vendor_Name__c='BG Solutions BS';
     cmpaigns.CRM_SelectedOwnershipCriteria__c='AHH;AHD';
     cmpaigns.CRM_OwnershipType__c='Hospital';
     cmpaigns.Ignore_Bad_Debt_Suppression__c=True;
     cmpaigns.Call_to_Action__c='HRA';
     cmpaigns.List_Order_Id__c=1162755;
     cmpaigns.Member_Types__c='One or more encounters - Patients';
     cmpaigns.CRM_ParentSegmentedCampaign__c=cmpagns.id;
     cmpaigns.Channel__c='Direct Mail';
     cmpaigns.status='In development';
   insert cmpaigns;
   return cmpaigns;
   }
    public static CampaignSequencer__c createsequencer()
    {
        CampaignSequencer__c seq = new CampaignSequencer__c();
         seq.Counter_Value__c=100;
         seq.Name='Count';
      insert seq;
      return seq;
    }
     public static CRM_AudienceReport__c createaudiencereport(ID cmpaignsid,ID junctionuplodid)
   {
    CRM_AudienceReport__c audiencereport = new CRM_AudienceReport__c();
             audiencereport.CRM_Campaign__c=cmpaignsid;
             audiencereport.CRM_AudienceUploadJunction__c=junctionuplodid;
             audiencereport.CRM_ControlGroup__c = 2;
             audiencereport.CRM_Supression__c = 1;
             audiencereport.Missing__c = 0;
             audiencereport.CRM_WundermanDupe__c= true;
             audiencereport.CRM_WundermanID__c='48190076';
           insert audiencereport;
           return audiencereport;
   }
    
    
}
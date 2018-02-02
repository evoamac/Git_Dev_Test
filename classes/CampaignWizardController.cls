//***************************
//Created by :- Shivangi Mehra, Nancy,Sourabh
//Date :- 11th August,2016
//Purpose:- 
//**************************

public class CampaignWizardController
{   
    
    /*******Object Decalartion ****/   
    public Campaign objcampaign{get;set;}
    public Campaign  ObjActiveCamp{get;set;}
    public SObject headSObject ,headClone;
    public Campaign CloneCampaign{get;set;}
    public string campaignId{get;set;}
    public string OldMemberType{get;set;}
    public Campaign cp{get;set;}
    public Campaign myCamp{get;set;}
    public Campaign CampName{get;set;}
    public Campaign CampName1{get;set;}
  //  public Campaign_Location__c CampInfoLoc{get;set;}
  //  public Location__c loc{get;set;}
    public campaign camp{get;set;}
  //  public Campaign_Location__c campLoc{get;set;}
    public DRG_Code__c drg{get;set;}
   // public HospitalCode__c hpCode{get;set;}
    public Location__c hpCode{get;set;}
    public Campaign Encounterid{get;set;}
 
    Campaign camp_clone1{get;set;}
    Campaign camp_childMember{get;set;}
    Campaign campaign{get;set;}
    public encounter__c eid{get;set;}
    public Encounter_aggregates__c eaid{get;set;}
    public Life_Style__c lifesid{get;set;}
   //Part of R2
   // public Campaign_HRA__c hraid{get;set;}
    public Model__c Modelid{get;set;}
    public Campaign_Demographics__c demoid{get;set;}
    public String u{get;set;}
    public User activeUser{get;set;}
    public String username{get;set;}
    public string CampNameInteraction{get;set;}
    public campaign campIDD{get;set;}
    public boolean campmemberflag{get;set;}
    public boolean nameFlag{get;set;}
    public boolean vendornameflag{get;set;}
    public boolean activatecampaignflag{get;set;}
    public boolean activateSearviceAreaButton{get;set;}
    public boolean activateGeographyByDistanceButton{get;set;}
    public boolean activateGeographyBoundaryButton{get;set;}
    public string buttonvalue{get;set;}
    public boolean isLeadershipProfile{get;set;}
    
    public boolean isCountAnalysisEnable{get;set;}
    public boolean NotOwner{get;set;}
    
    //Other Variable declaration
  //  Public String description {get;set;}
    public string channelSelected{get;set;}
    public string SelectedchildId{get;set;}
  //  public String impact{get;set;}
    public Integer stepNumFromPage{get;set;}
   
  //  public String ms_drg{get;set;}
  //  public String note{get;set;}
   // public string type {get;set;} 
    public string camp_name{get;set;}
    public boolean noNext{get;set;}
    public boolean noNextB{get;set;}
    public boolean stepFlag{get;set;}
    public boolean SaveFlag{get;set;}
    public boolean TactFlag{get;set;}
    public boolean flag1{get;set;}
    public boolean disflag1{get;set;}
    public boolean disflag2{get;set;}
    public boolean disflag3{get;set;}
    public boolean disflagcontrl {get;set;}
    public boolean memberflag{get;set;}
    public boolean relatedlistflag1{get;set;}
    public boolean relatedlistflag{get;set;}
    public boolean relatedlistflag2{get;set;}
    public boolean relatedlistflagstep3{get;set;}
    public boolean relatedlistflagstep1{get;set;}
    public boolean relatedlistflagstep2{get;set;}
    public boolean hasAudienceUpload { get; set; } //AXU - for PP1
    
    public boolean Childflag{get;set;}
    public boolean CampChildViewFlag{get;set;}
    Public string newCampaign {get;set;}
    Public Integer stepno{get;set;}
    Public Integer btn{get;set;}
    public Integer maxStep{get;set;}
    public boolean DetailPage{get;set;}
    public string campname_value{get;set;}
    public string campname_value1{get;set;}
    public date campname_Date{get;set;}
    public DateTime campname_creatDate{get;set;}
   
    public boolean addedtocampaign{get;set;}
    public boolean proFlag {get;set;}
    public string strRegion{get;set;}
    public string strMarket{get;set;}
    public string strHospital{get;set;}
    public string strZipCode{get;set;}
    public string strServArea {get;set;}
    public string loc_hospital{get;set;}
    public string loc_Market{get;set;}
    public string loc_Region{get;set;}
    public string loc_ServiceArea{get;set;}
    public string loc_ZipCode{get;set;}
    public string campId{get;set;}
    public string camp_clone_Id{get;set;}
    
    public integer PageNumber {get;set;}
    private integer totalRecs = 0;     
    private integer index = 0;
    private integer blockSize = 5; 
    private integer OffsetSize = 0;
    private integer LimitSize= 10;
    public string ServLine{get;set;}
    public string TemplateFlag{get;set;}
    public integer button{get;set;}
    public boolean setflag{get;set;}
    public string flagstatus{get;set;}
    public boolean setflag1{get;set;}
    public String campflag{get;set;}
    
    public string val;
    public integer demoCount;
    public integer LifeCount;
    public integer modelCount;
    public integer hraCount;
    public integer EncCount;
    public integer EncAggCount;
    public integer locationCount;
    public integer geographyCount;
    public integer IncludeDiagnosesCount;
    public integer IncludeProceduresCount; 
    public integer IncludeDRGCount ;
    public integer distanceCount;
    public boolean refreshFlag{get;set;}
    public boolean targeted{get;set;}
    public boolean getwunderman{get;set;}
    public boolean activeCamp{get;set;}
    public boolean RefreshMem{get;set;}
    public CampaignMember campmember{get;set;} 
    public boolean displayPopUp{get;set;}
    public boolean isTargetedCampaign{get;set;} 
     //Inactive values validation change  
    public static boolean RefData_Alert{get;set;}{RefData_Alert=false;}
    public boolean IsAddChildCheck{get;set;}
    public boolean showolddatacampaign{get;set;}  //for old campaign data issue
    //Changes for PP1 Start
    public boolean externaluploadflag{get;set;} //for external upload campaign change
    public boolean loadaudienceflag{get;set;}
    //Changes for PP1 End
    public boolean lockMemberType { get; set; } //to lock parent campaign member type PP4 change
    public boolean lockChannelValue{get;set;}// to lock channel value PP4 change
     public String segmentedparentCampName {get;set;} //PP4 change
      public boolean IsParentCampaign { get; set; } //PP4 change
    public List<Campaign> childCampaign{get;set;}// PP4 change
     public id IdFromPage{get;set;}//PP4 change
    public boolean segmentflag{get;set;}//PP4 change
    public boolean activateparentflag{get;set;}//PP4 change
    public string oldChannelValue{get;set;}//PP4 change
    public static ID targetedid{get;set;}
    public static ID nontargetedid{get;set;}
    public static ID selectedchannelID{get;set;}
    
    
   
    
    public String dedupeBatchId { get; set; } //AXU added for getting WDM dedupe status
    public ID unlockbatchID{get;set;}
    /*****List Decalartion ******/
    public List<SelectOption> AllSubServLines{get;set;}
    public List<SelectOption> SelectedSubServLines{get;set;}
   // public List<SelectOption> Alltactic{get;set;}
  //  public List<SelectOption> Selectedtactic{get;set;}
  //  public List<SelectOption> AllPayorType{get;set;}
  //  public List<SelectOption> SelectedPayorType{get;set;}
    Public List<filterCriteria> lstFilter {get;set;}
    Public List<wrapRecord> lstRecord {get;set;}  
    public List<CampaignMember> lstCampaignMember{get;set;}
   // public List<WrapperClassForInteraction> wrapperLocList{get;set;}    
   // public List<WrapperClassForInteraction> getInteraction{get;set;}
   // public List<Location__c> loc_list{get;set;}
   //public List<Campaign_Location__c> campLocList{get;set;}
   // public List<Campaign_Location__c> campLocList1{get;set;}
   //public List<Campaign_Location__c> CampLocationInformation{get;set;} 
  //  public List<WrapperClassForLocationCheckBox> DetailLocrelatedlst{get;set;}
  //  public List<Campaign_Location__c> lstrelatedLoc{get;set;}
  //  public List<WrapperClassForDRGCheckBox> DetailwrapDRGRelatedlist{get;set;} 
  //  public List<Location__c> lstlocation=new List<Location__c>();
  //  public List<clsLocation> lstwrpLoc{get;set;}
    public List<Campaign> lstCamp_memb{get;set;}
    public List<Campaign> lstCamp_memb1{get;set;}
    public List<String> loc_listmem{get;set;}
    public List<String> loc_listmemid{get;set;}
    public List<CampaignMember> loc_listmem1{get;set;}
    List<String> lstWhereLocCondition = new List<String>();
    public set<Id> ConSet{get;set;}
    public List<wrapRecord> Detailmemberlist {get;set;} 
    public list<SelectOption> HospitalList{get;set;}
    public List<SelectOption> SelectedHospitalList{get;set;}
    
     public Integer pageSize{get;set;}
   
    public Integer noOfRecords{get; set;}
    public boolean showEditButton{get;set;}
    public String cloneFlag{get;set;}
    public String profileName{get;set;}
    public boolean profileflag{get;set;}
    public boolean deploymentflag{get;set;} //used for restricting cloning of old campaign
    public boolean segmentedchildflag{get;set;} // PP4 change
     public List<CRM_CampaignOwnershipDetail__c> ownerlist{get;set;}  //Ownership change
    public List<String> selectedownershipCodes{get;set;} //ownership change
     public  Map<id,CRM_CampaignOwnershipDetail__c> JunctionObjMap{get;set;}
   
    
    List<DRG_Code_Information__c> lstdrginfo = new List<DRG_Code_Information__c>();
    
    Public List<DRG_Code__c> lstdrg{get;set;}
    public String parentCampName {get ; set ;}
    public ApexPages.StandardSetController con{get; set;}
    
    // Design change for channel vendor screen  
    public List<SelectOption> subserviceline{get;set;} 
    public boolean IsChannelInbound{get;set;}    
    public String selectedChannel {get;set;}
    public String selectedVendor {get;set;}
    public String selectedCallToAction {get;set;}
    public List<SelectOption> lstchannelvalues {get{return ReferenceData_PicklistController.getPickListValues('ChannelValues');}set;}
    public List<SelectOption> lstVenderNamesValues {get {return ReferenceData_PicklistController.getPickListValues('Vendor_Name');}set;}    
    public List<SelectOption> lstMemberTypeValues {get
    {
        //start of PP4 change
        List<SelectOption> segmentedmembertype = new List<SelectOption>();
            segmentedmembertype = ReferenceData_PicklistController.getPickListValues('MemberType');
        
            
            system.debug('segmentedmembertype values'+ segmentedmembertype);
            for(integer j=0; j<segmentedmembertype.size(); j++){
                system.debug('inside for loop');
                system.debug('value ===='+String.valueOf(segmentedmembertype.get(j)) );
                if(segmentedmembertype[j].getValue()=='Campaign Segments'){
                system.debug('after if syste removing@@@@');
                    segmentedmembertype.remove(j);
                    system.debug('after removing@@@@');
                }
            }
            system.debug('after removing'+ segmentedmembertype);
      if(objcampaign.CRM_ParentSegmentedCampaign__c!=null || lstCamp_memb1.size()>0){
          return segmentedmembertype;     
        }
       else{
        system.debug('size of member type list'+ segmentedmembertype.size());     
        List<String> memberval = new List<string>();
           memberval.add('Campaign Segments');
           segmentedmembertype.add(new SelectOption('Campaign Segments', 'Campaign Segments'));
system.debug('size of member type list after $$$$$'+ segmentedmembertype.size());          
        return segmentedmembertype;
            //ReferenceData_PicklistController.getPickListValues('MemberType');
      }
    }
     set;}
    //end of PP4 change
    public List<SelectOption> lstCallTOActionValues  
    {
       get 
       {  list<SelectOption> returnList = new List<SelectOption> (); 
        if (!IsChannelInbound)
        return ReferenceData_PicklistController.getPickListValues('Call_To_Action');
        else 
        returnList.add(new SelectOption('', '--None--')); return returnList;
       }
       set;
    }
    public  Map<id,CRM_CampaignWizardReferenceData__c> refrenceDataMap;
   //End  Design change for channel vendor screen :
   /* Start: Campaign detail screen change :Sub Service/Service Line */
        
    public String[] selectedValSSL {get;set;}           
    public String selectedServiceLine {get;set;}       
    public List<SelectOption> lstServiceLinevalues{get{return ReferenceData_PicklistController.serviceLine(true);}set;}
    public map<id,CRM_CampaignWizardReferenceData__c> showSelectedSubService{get;set;}
    
    public void refreshSubServiceLines()
    {
        system.debug('****selectedServiceLine='+selectedServiceLine);
        selectedValSSL=  new String[]{};
        subserviceline = ReferenceData_PicklistController.subServiceLine(false, new list<string>{selectedServiceLine});
    }
    
    public void fetchSubServiceLineNames()
    {
        showSelectedSubService = new map<id,CRM_CampaignWizardReferenceData__c>([select id,CRM_ServiceSubServiceLine__c from CRM_CampaignWizardReferenceData__c where Id IN:selectedValSSL]);
    
        system.debug('****selectedServiceLine='+showSelectedSubService ); 
    
    }
   /* End: Campaign detail screen change :Sub Service/Service Line */ 

    //Start of Ownership process change
    public string selectedOwnerType{get;set;}
    public string[] selectedCriteria{get;set;}
    public list<SelectOption> ownershipList {
        get {
           selectedCriteria = new String[]{};
           list<SelectOption> slo = ReferenceData_PicklistController.ownershipOptions();
          if(selectedOwnerType==null)
           selectedOwnerType = slo[0].getValue();
           return slo;
        }
        set;
    
    }
    public list<SelectOption> ownershiptype{
        get{
            system.debug('*****selectedOwnerType='+selectedOwnerType);
            
            return ReferenceData_PicklistController.refreshOwnershiptype(selectedOwnerType);
            
        }
        set;
    }
    
    public  map<id,CRM_CampaignLocationReferenceData__c> showSelectedownership{get;set;}
    public  map<id,CRM_CampaignLocationReferenceData__c> Selectedownership{get;set;}
    public void fetchOwnershipNames(){
        //start of PP4 change
        if(segmentedparentCampName==null){
            //end of PP4 change
        system.debug('*****selectedCriteria='+selectedCriteria);
        showSelectedownership = new map<id,CRM_CampaignLocationReferenceData__c>([select id,CRM_Region__c,CRM_Market__c,CRM_Hospital__c,CRM_MarketRegion__c,CRM_HospitalMarket__c from CRM_CampaignLocationReferenceData__c where Id IN:selectedCriteria]);
        }
    }
    
    //End of ownership process change
   
    public CampaignWizardController(ApexPages.StandardController controller)
    {   campflag='True';
        NotOwner=false;
        Childflag=false;
        nameFlag=false;
        system.debug('&&&&&&'+nameFlag);
        CampChildViewFlag=false;
        system.debug('%%%%%%%+'+Childflag);
        noNext=false;
        noNextB=false;
        flag1=false;
        TactFlag=true;
        disflag2=true;
        disflagcontrl=true;
        memberflag=true;
        activatecampaignflag=false;
        proFlag=false;
        targeted=false;
        campmemberflag=false;
        vendornameflag=true;
        showolddatacampaign=false; //for old campaign data issues
       // disflag3=false;
        stepFlag=false;
        SaveFlag=false;
        setflag=false;
        setflag1=false;
        getwunderman=false;
        RefreshMem=false;
        refreshFlag=false;
        segmentedchildflag=false; //PP4 change
        activateSearviceAreaButton= false;
        activateGeographyBoundaryButton=false;
        activateGeographyByDistanceButton=false;
        
        //Channel vandor and Service line sub service line changes 
         subserviceline = new list<SelectOption>();
         IsChannelInbound= true;
        //Channel vandor and Service line sub service line changes 
        selectedvalSSL = new String[]{};
            //Start of ownership change
         selectedCriteria = new String[]{}; 
          ownerList = new List<CRM_CampaignOwnershipDetail__c>();
         selectedownershipCodes  =  new List<String>();
      lstCamp_memb1=new List<Campaign>();
     // End of Ownership process change        
        //  btn=0; 
        //newCampaign ='New Campaign' ;
        // newCampaignStatus ='In Development' ;
        system.debug('i am in constructor]]]]]]]]]]]]]]');
        set<string> profileNameSet = new set<string>();
        profileNameSet.add('Tenet Leadership');profileNameSet.add('Tenet Marketer');profileNameSet.add('Tenet Admin');profileNameSet.add('System Administrator');profileNameSet.add('Tenet Super User');
        profileNameSet.add('Tenet Help Desk'); profileNameSet.add('Tenet IT');
        Id profileId=userinfo.getProfileId();
         profileName=[Select Id,Name from Profile where Id=:profileId].Name;
        showEditButton=false;
        
        if(profileNameSet.contains(profileName)){
            showEditButton=true;
            profileflag= true;
        }
        isLeadershipProfile=false;
        if(profileName.equalsIgnoreCase('Tenet Leadership'))
            isLeadershipProfile=true;
        
        
        
        if(ApexPages.CurrentPage().getParameters().get('stepNo')!= null)
        {   
            stepno = Integer.valueOf(ApexPages.CurrentPage().getParameters().get('stepNo'));
            system.debug('after getting step no---------===='+stepno);
        }
        else
            stepno = 1;
          
        maxStep = 5;
        if(ApexPages.CurrentPage().getParameters().get('btn')!= null)
        {
            button = Integer.valueOf(ApexPages.CurrentPage().getParameters().get('btn'));
            system.debug('value of button\\\\\\\\\\\\\\'+ button);
        }
        else
            btn=0;
       
       
       if(ApexPages.CurrentPage().getParameters().get('campflag')!=null)
       {
        campflag=ApexPages.CurrentPage().getParameters().get('campflag');
        }
        else
            campflag='true';
            
        ConSet = new Set<Id>();
        myCamp = new Campaign(Status = 'In Development');
        Detailmemberlist = new List<wrapRecord> ();
        addedtocampaign = false;
        init();
        ServLine = '';
        loc_hospital = '';
        loc_ServiceArea ='';
        loc_Market ='';
        loc_Region ='';
        loc_ZipCode='';
        AllSubServLines = new List<SelectOption>();
        SelectedSubServLines = new list<SelectOption>();
        SelectedHospitalList = new list<SelectOption>();
        
        objcampaign=new campaign();
        objActiveCamp=new campaign();
        CloneCampaign=new campaign();
        system.debug('^^^^^'+objcampaign);
        objcampaign.Name='New Campaign';
        objcampaign.Vendor_Name__c='None';
        objcampaign.Member_Types__c='Any or no encounters - Everyone';
        system.debug('value of approved in cons!!!!!!!!!!1======='+ objcampaign.Approved__c);
        campId=ApexPages.CurrentPage().getParameters().get('Id');
        system.debug('###'+campId);
        
        if(campId!=null)
        {
            cp = new campaign(id=campId);
        }
        else
        {
            cp=new campaign();
            // method1();
            system.debug('ia am in else');
            getownername();
            //vendorname();
            preparehospitalpicklist();
           //  system.debug('value of user name==========='+ activeUser.Name);
        }
        
        isTargetedCampaign=true;
        
    
     
        if(ApexPages.CurrentPage().getParameters().get('Id') != null)
        {
            //campId=ApexPages.CurrentPage().getParameters().get('Id');
           objcampaign=[select Call_to_Action__c,parent.Name,RecordTypeId,Clone_Campaign_Flag__c,Call_Center_Identifier__c,Campaign_Toll_Free_Number__c,Place_Order_Date_Time__c,Control_Group_Size__c,Control_Group_Percentage__c,count_of_index__c,
                         Actual_Spend__c,Approval_Comments__c,Approved_By__c,Approved__c,Audience_Hospital__c,Audience_Region__c,Audience__c,Campaign_Budget__c,Error_Message__c,List_Order_ID_Error_Message__c,
                         Channel__c,Control_Group_Member__c,CreatedBy.name,CreatedDate,Current_count__c,Wunderman_Sync__c,Description,EndDate,Expected_Contribution_Margin__c,Goal_Objective__c,
                         Id,LastModifiedById,MARS_Approval__c,List_Order_Id__c,Member_Types__c,Name,Other__c,of_CampaignMembers__c,of_Members__c,OwnerId,ParentId,Program_Name__c,Purchase_Invoice_Order__c,Control_Group_Count__c,CRM_OwnershipType__c,CRM_SelectedOwnershipCriteria__c,
                         Requested_By__c, CRM_AudienceUploadCount__c, RecordType.Name,
                         //Changes for PP1 Start
                        //CRM_UploadAudienceCount__c,
                        //Changes for PP1 Ends
                        //start of PP4 change
                        Segment__c,CRM_ParentSegmentedCampaign__c,CRM_ParentSegmentedCampaign__r.name,Net_Count__c,
                        //end of PP4 change
                         IsActive,CRM_SubServiceLineText__c,Sub_Service_Line__c,Save_Campaign_as_Template__c,Ignore_Bad_Debt_Suppression__c,Ignore_Minor_Suppression__c,Service_Line__c,StartDate,Status,Add_Member_Status__c,Tactic__c,Type,Vendor_Name__c,Version__c,LastModifiedDate,LIST_ORDER_SELECT_GRP_ID__c from campaign where id=:campId limit 1];

            //Changes for PP1 Start
            ObjActiveCamp=[select Member_Types__c,Status,id,Add_Member_Status__c from campaign where id=:campId limit 1];
            hasAudienceUpload = hasExistingAudienceUpload();
            //Changes for PP1 End
            system.debug('control group % value after query@@@@@'+objcampaign.Control_Group_Percentage__c);
            //start of PP4 change
            childCampaign=new list<Campaign>();
            //AXU added to lock parent campaign member type selection dropdown
            if(objcampaign.CRM_ParentSegmentedCampaign__c==null){
                system.debug('i am in if');
             childCampaign = [SELECT Id, Segment__c, Member_Types__c,Add_Member_Status__c FROM Campaign WHERE CRM_ParentSegmentedCampaign__c =: campId ORDER by Segment__c asc];
             
            }
            else{
                system.debug('i am in else@@@');
              childCampaign = [SELECT Id, Segment__C,Add_Member_Status__c From Campaign where CRM_ParentSegmentedCampaign__c=:objcampaign.CRM_ParentSegmentedCampaign__r.id ORDER by Segment__c asc] ; 
              
            }
          /*Defect#997 :Start*/ 
            If(objcampaign.Add_Member_Status__c=='Calculated Net Count' || objcampaign.Add_Member_Status__c=='Adding Members' ||objcampaign.Add_Member_Status__c=='Added Members')
            isCountAnalysisEnable=true;
            
             for(campaign childcam : childCampaign)
            {
                if(childcam.Add_Member_Status__c=='Calculated Net Count' )
                {
                    isCountAnalysisEnable=true;
                   
                }
            }
            
           /*Defect#997 :End*/
          
                if(CRM_MemberTypeReferenceData__c.getInstance(objcampaign.Member_Types__c)!=null){
                lockMemberType = CRM_MemberTypeReferenceData__c.getInstance(objcampaign.Member_Types__c).CRM_IsParentCampaign__c && 
                                childCampaign != null && 
                                childCampaign.size() > 0 || (objcampaign.Status=='Active' && objcampaign.Member_Types__c=='Campaign Segments') ;
                if(childCampaign.size()>0 && stepNo==2 && objcampaign.CRM_ParentSegmentedCampaign__c==null){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING,System.Label.CRM_MembertypeUnlockMessage));
            
                }
            }else
                lockMemberType = false;

            System.debug('Lock Member Type: ' + lockMemberType);
            
            for(campaign c: childCampaign){
                if(c.Add_Member_Status__c=='Calculated Net Count' || c.Add_Member_Status__c == 'Adding Audience Report' || c.Add_Member_Status__c == 'Order Placed'){
                    lockChannelValue = true;
                }
            }
            //end of PP4 change
            OldMemberType=objcampaign.Member_Types__c;
            oldChannelValue= objcampaign.Channel__c;
            cloneFlag= ApexPages.CurrentPage().getParameters().get('cloneFlag');
            
            //start of old campiagn data issue
            if(objcampaign.Status=='Active' && objcampaign.CRM_OwnershipType__c==null && objcampaign.CRM_SelectedOwnershipCriteria__c==null)
              showolddatacampaign=true;
            //end of old campaign data issue
            if(objcampaign.parentid!=null) parentCampName = objcampaign.parent.Name;
            //start of PP4 change
            if(objcampaign.CRM_ParentSegmentedCampaign__c!=null) segmentedparentCampName = objcampaign.CRM_ParentSegmentedCampaign__r.Name;
            //end of PP4 change
            RecordType rt = [select id,developerName from RecordType where id=:objcampaign.RecordTypeId];
            
            if(rt.developerName=='Non_Targeted')
                isTargetedCampaign=false;
          
           
            //Start: Design change for channel and vendor and Sub Service/Service Line: 
           
            Map<String ,List<String>> junctionObjectMap=new Map<String ,List<String>>();
            
            Map<String ,String> junctionObjectMapForOldCamp=new Map<String ,String>(); 
            for (CRM_CampaignRefJunction__c CRMJO: [select CRM_CampaignWizardReferenceData__c ,CRM_CampaignWizardReferenceData__r.RecordType.DeveloperName,CRM_CampaignWizardReferenceData__r.CRM_Channel__c from CRM_CampaignRefJunction__c where CRM_CampaignMapping__c=:CampId and CRM_CampaignWizardReferenceData__r.CRM_isActive__c=true ])
            {
                if(!junctionObjectMap.containsKey(CRMJO.CRM_CampaignWizardReferenceData__r.recordType.developername )) 
                {
                    junctionObjectMap.put(CRMJO.CRM_CampaignWizardReferenceData__r.recordType.developername, new List<String>());
                    
                }
                junctionObjectMap.get(CRMJO.CRM_CampaignWizardReferenceData__r.recordType.developername).add(CRMJO.CRM_CampaignWizardReferenceData__c); 
               
                 
            }
               
            refrenceDataMap = new  Map<id,CRM_CampaignWizardReferenceData__c>();
            
            system.debug('>>>>>refrenceDataMap<<<<<<<<<'+refrenceDataMap);
            
            system.debug('>>>>>junctionObjectMap<<<<<<<<<'+junctionObjectMap);
            
            system.debug('>>>>>junctionObjectMapForOldCamp<<<<<<<<<'+junctionObjectMapForOldCamp);
            
            if(objcampaign.Channel__c!=null && junctionObjectMap.get('ChannelValues')!=null)
            selectedChannel=string.join(junctionObjectMap.get('ChannelValues'),',');
           
            system.debug('#### selectedChannel #### '+ selectedChannel);   
            if(objcampaign.Vendor_Name__c!=null && junctionObjectMap.get('Vendor_Name')!=null)
            selectedVendor=string.join(junctionObjectMap.get('Vendor_Name'),',');
            
            if(objcampaign.Call_to_Action__c!=null && junctionObjectMap.get('Call_To_Action')!=null)
            selectedCallToAction=string.join(junctionObjectMap.get('Call_To_Action'),',');
            //End: Design change for channel and vendor 
            
            /*Start :Campaign detail screen change :Sub Service/Service Line*/    
            if (objcampaign.Service_Line__c!=null && junctionObjectMap.get('Service_Line')!=null) 
            {
               selectedServiceLine= string.join(junctionObjectMap.get('Service_Line'),',');
               refreshSubServiceLines();  
               system.debug('#### selectedServiceLine #### '+ selectedServiceLine);
            }
            
            if (selectedServiceLine!=null && selectedServiceLine!='' && objcampaign.CRM_SubServiceLineText__c!=null && junctionObjectMap.get('Sub_Service_Line')!=null)
            { 
               system.debug('#### Sub_Service_Line #### '+ junctionObjectMap.get('Sub_Service_Line'));
               selectedValSSL= junctionObjectMap.get('Sub_Service_Line');
               fetchSubServiceLineNames();
               system.debug('#### selectedValSSL #### '+ selectedValSSL);
            }
            
            
            //End: Design change for channel and vendor and Sub Service/Service Line: 
           // Start of ownership process change
             if(selectedCriteria!=null  )
            {  
             
                SelectedOwnershipValues(objcampaign.id);
                system.debug('$$$$$selected ownership in inactive mode@@@'+ objcampaign.CRM_SelectedOwnershipCriteria__c);    
             }
            // End of ownership process change
            if(objcampaign.Approved__c==false)
            {
            objcampaign.Approved_By__c=null;
            }
             // start  of PP4 change
            if(objcampaign.Member_Types__c=='Campaign Segments' && stepNo==5 && objcampaign.Current_count__c >= 150000 && objcampaign.status!='Active' ){
                system.debug('inside if@@@@');
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING,System.Label.CRM_SegmentFinalCountMessage));
            
            }      
       //   <!-- end of PP4 change-->
            system.debug('control group percentage@@@@'+objcampaign.Control_Group_Percentage__c);
            
            system.debug('*******Value of wundeman Sync*******'+objcampaign.Wunderman_Sync__c);
            setflag=false;
          //  relatedlistflag=true;
          
           String LoginUserid=UserInfo.getUserId();
            system.debug('#### LoginUserid #####'+LoginUserid);
            system.debug('#### objcampaign.OwnerId #####'+objcampaign.OwnerId);
            
            if (LoginUserid!=objcampaign.OwnerId)
            NotOwner=true;
           
            relatedlistflagstep2=true;
            relatedlistflagstep3=false;
            system.debug('**************'+objcampaign);
            //CampNamingConvention();
            DetailPage = true;
           //start of ownership process change 
           //start of PP4 change
            if(objcampaign.CRM_ParentSegmentedCampaign__c==null){  
           //end of PP4 change
            Selectedownership = new map<id,CRM_CampaignLocationReferenceData__c>([select id,CRM_Region__c,CRM_Market__c,CRM_Hospital__c,CRM_MarketRegion__c,CRM_HospitalMarket__c from CRM_CampaignLocationReferenceData__c where Id in (Select  Campaign_Location_Reference_Data_Mapping__c from CRM_CampaignOwnershipDetail__c where Campaign__c =: campid)]);
           system.debug('##########3'+ Selectedownership);
            }
            // End of ownership process change
            //DetailPage= False;          
            //stepFlag=true;
            system.debug('&&&& Campaign Id'+TemplateFlag);
            TemplateFlag=ApexPages.CurrentPage().getParameters().get('flag');
            system.debug('&&&&'+TemplateFlag);
            system.debug('&&&&Template campaign'+TemplateFlag); 
            CampNameInteraction=ApexPages.CurrentPage().getParameters().get('campname');
            system.debug('#####'+CampNameInteraction);
            pageSize=10;
            
            if(TemplateFlag=='true'){
                DetailPage=false;
                objcampaign.status='In Development';
                objcampaign.Save_Campaign_as_Template__c=false;
                objcampaign.name='New Campaign';
                objcampaign.Current_count__c=null;
                objcampaign.Program_Name__c=null;
                objcampaign.ownerid=UserInfo.getUserId();
               
                
                system.debug('status of campaign for template=========='+ objcampaign.status);
            }
            
            ViewChildCampaign();
            if(!showolddatacampaign)// Member type none issue for active old campaign 
              tactic();
            tactic();
            //Start: Design change for channel Vendor  
            tactflag=isTargetedCampaign;
           
            //End: Design change for channel Vendor
            
            membervalues();
            method1();
            //vendorname();
            preparehospitalpicklist();
            //Changes for PP1 Start
            /*if(objcampaign.id!=null ){
                // Integer recordcount = [Select Count() from CRM_AudienceUpload__c where id=:objcampaign.id];
                IF(objcampaign.CRM_UploadAudienceCount__c < 150000){
                    system.debug('i am in load audience');
                    loadaudienceflag=true;
                }
                else If(objcampaign.CRM_UploadAudienceCount__c >= 150000){
                    loadaudienceflag=false;
                } 
            }*/
            //Changes for PP1 Ends
            //getCampmember();
            system.debug('brfore calling refreshCountButtonMethod flag  '+refreshFlag);
            refreshCountButtonMethod();
            deactivegeographybuttons();
            // start of restricting old campaign from cloning
             system.debug('date entered in custom label@@@@@@@'+ Date.valueOf(System.Label.CRM_Deployment_Date));
            if(Date.valueOf(objcampaign.createdDate) < Date.valueOf(System.Label.CRM_Deployment_Date)){
                deploymentflag= true;
           }
            //  End of restricting old campaign from cloning
           // getownername();
            system.debug('value of approved in cons======='+ objcampaign.Approved__c);
            
            if(CampNameInteraction!=null)
            {
                //getCampmember();
                //getInteraction(); //Commented by Amit
                //savemember();
            }
            /* 
            for(CampaignMember C : [select Id,CampaignId, ContactId from CampaignMember where CampaignId=:campId])
            {
                ConSet.add(C.ContactId);                
            }
            
            for(Contact Con : [Select Id, FirstName,Account.Name, LastName, Title,AccountId,Email from Contact where id IN: ConSet])
            {
                wrapRecord cont = new wrapRecord(Con);
                cont.IsSelected = false;
                Detailmemberlist.add(cont); 
                //system.debug('Detailmemberlist***'+Detailmemberlist.size());
            }*/
            
            /*set<id> locset = new set<id>();
            for(Campaign_Location__c CamInfo :[Select id, Location__c, Campaign__c from Campaign_Location__c  where Campaign__c =:campId])
            {
                locset.add(CamInfo.Location__c);    
            }
            for(Location__c l : [select id, Hospital__c, Market__c, Region__c, Service_Area__c, Zip_Code__c from Location__c  where id in:locset])
            {
              //  DetailLocrelatedlst.add(new WrapperClassForLocationCheckBox(l));
            }*/
            //system.debug('objcampaign.Sub_Service_Line__c*****'+objcampaign.Sub_Service_Line__c);
            //SubServiceLine();
            if(objcampaign.CRM_SubServiceLineText__c != null)
            {
                List<String> lstSubServ = objcampaign.CRM_SubServiceLineText__c.split(';');
                for(string str : lstSubServ)
                {
                    system.debug('**SelectedSubServLines**='+str+'******');
                    SelectedSubServLines.add(new SelectOption(str, str));
                    for(integer i=0;i<AllSubServLines.Size();i++)
                    {
                        system.debug('**AllSubServLines**='+AllSubServLines[i].getValue()+'******');
                        if(AllSubServLines[i].getValue() == str)
                            AllSubServLines.remove(i);
                    }
                }
                system.debug('SelectedSubServLines*****'+SelectedSubServLines); 
            }
            
        /**    if(objcampaign.Tactic__c != null)
            {
                List<String> lstTactic = objcampaign.Tactic__c.split(';');
                system.debug('lstTactic*****'+lstTactic); 
                for(string str : lstTactic)
                {
                    Selectedtactic.add(new SelectOption(str, str));
                }
                system.debug('Selectedtactic*****'+Selectedtactic); 
                
            }  **/
            
            if(objcampaign.Audience_Hospital__c != null)
            {
                List<String> lstHospital = objcampaign.Audience_Hospital__c .split(';');
                system.debug('lstHospital *****'+lstHospital ); 
                for(string str : lstHospital )
                {
                system.debug('value in constructor of hospital======'+ str);
                    SelectedHospitalList.add(new SelectOption(str, str));
                   //Staring of defect:available list issue for child campaign and careate template  
                     for(integer i=0;i<HospitalList.Size();i++)
                    {
                            system.debug('**AllSubServLines**='+HospitalList[i].getValue()+'******');
                            if(HospitalList[i].getValue() == str)
                                HospitalList.remove(i);
                     }
                   //Ending of defect:available list issue for child campaign and careate template  
                      
                }
                system.debug('SelectedHospitalList*****'+SelectedHospitalList); 
                
            }
            
           set<id> DRGInfoset = new set<id>();
          for(DRG_Code_Information__c D : [select id, Campaign__c, Description__c, DRG_Code__c from DRG_Code_Information__c where Campaign__c=:campId])
            {
                DRGInfoset.add(D.DRG_Code__c);
            }
            
        /*     if(!DRGInfoset.IsEmpty())
            {
                for(DRG_Code__c dr : [select id, Description__c, Impact__c, MS_DRG__c, Note__c, Service_Line__c, Sub_Service_Line__c, Type__c from DRG_Code__c where id IN : DRGInfoset])
                {
                    DetailwrapDRGRelatedlist.add(new WrapperClassForDRGCheckBox(dr));
                }
            } */
        }         
        strRegion = '';
        strMarket = '';
        strHospital = '';
        strZipCode = '';
        strServArea = '';
            
         if(ApexPages.CurrentPage().getParameters().get('retURL')!=null && NotOwner!=true)
        {   
        
        system.debug('####Edit#####');
           DetailPage=false;
        }
    }  
    
    public void init() 
    {
        initFilter();
        lstRecord = new List<wrapRecord>();
    }
    
    public void initFilter() 
    {
        lstRecord = new List<wrapRecord>();
        lstFilter = new List<filterCriteria>();
        for(Integer i=0 ; i<5 ; i++) 
        {
            lstFilter.add(new filterCriteria());
        }
    }
    public void closePopup()
    {       
        displayPopup = false;   
    }   

  /*  public void searchDRG()
    {
        lstdrg = new List<DRG_Code__c>();
        system.debug('value for region==='+description);
        String strQuery = 'SELECT Description__c , Impact__c , MS_DRG__c , Note__c , Service_Line__c , Sub_Service_Line__c , Type__c FROM DRG_Code__c';
        List<String> WhereCondition = new List<String>();
        
        if(String.isNotBlank(description)) {
            WhereCondition.add(' Description__c LIKE \'%'+description+'%\'');
        }  
        if(String.isNotBlank(impact)) {
            WhereCondition.add(' Impact__c LIKE\'%'+impact+ '%\'');
        }
        if(String.isNotBlank(ms_drg)) {
            WhereCondition.add(' MS_DRG__c LIKE\'%'+ms_drg+ '%\'');
        }
        if(String.isNotBlank(note)) {
            WhereCondition.add(' Note__c LIKE\'%'+note+ '%\'');
        }
        if(String.isNotBlank(objcampaign.Service_Line__c)) {
            WhereCondition.add(' Service_Line__c=\''+objcampaign.Service_Line__c+ '\'');
        }
        if(String.isNotBlank(objcampaign.Sub_Service_Line__c)) {
            WhereCondition.add(' Sub_Service_Line__c=\''+objcampaign.Sub_Service_Line__c+ '\'');
        }
        if(String.isNotBlank(type)) {
            WhereCondition.add(' Type__c LIKE\'%'+type+ '%\'');
        }
        String strWhereQuery = '';        
        if(WhereCondition.size()>0) 
        {      
            strWhereQuery +=String.join(WhereCondition, 'AND');
        }
        if(WhereCondition.size()>0) 
        {
            strQuery += ' WHERE ' + strWhereQuery;
        }
        //strQuery += ' ORDER By Name';
        strQuery += ' ORDER By Name LIMIT 1000';
        //strQuery += ' ORDER By Name LIMIT :blockSize OFFSET :index';
        system.debug('after query string============'+strQuery );
        lstdrg= Database.query(strQuery);
        //ApexPages.StandardSetController ssc=new ApexPages.StandardSetController(Database.query(strQuery));
        //con = new ApexPages.StandardSetController(Database.getQueryLocator(strQuery));
        //con.setPageSize(5);
        //getDrg();
        system.debug('after database query-======'+lstdrg);
        system.debug('wrapperDrgList-======'+wrapperDrgList);
        wrapperDrgList=new List<WrapperClassForDRGCheckBox>();
        for(DRG_Code__c d:lstdrg)
            
        {
            wrapperDrgList.add(new WrapperClassForDRGCheckBox(d));      
        }
    }  */
    
  /**  public List<WrapperClassForDRGCheckBox> getDrg()
    {
        if(wrapperDrgList==null)
        {
            drg_list=new List<DRG_Code__c>();
   //       system.debug('&&&'+lstdrg);
        //    system.debug('&&&'+lstdrg1);
            
            wrapperDrgList=new List<WrapperClassForDRGCheckBox>();
            for(DRG_Code__c d:lstdrg)
                
            {
                wrapperDrgList.add(new WrapperClassForDRGCheckBox(d));      
            }  
        }
        system.debug('wrapperDrgList'+wrapperDrgList);
        return wrapperDrgList;
    }   **/
    
    /************* to show the tab *********/
    public PageReference showTab()
    { 
    PageReference ref;
        stepNo=stepNumFromPage;
        system.debug('sssssssshow tab'+stepNumFromPage);
       // stepNo = stepNo+1;
       // Integer val=   stepNo++;
        system.debug('step after incre====='+ stepNo);
        
        if(stepNo==1 || stepNo==2)
        {
           system.debug('i am in step 1 and 2 of showtab');
            relatedlistflagstep1=true;
            relatedlistflagstep2=true;
            relatedlistflagstep3=false;
             system.debug('i am in step 1 and 2 of showtab flag value' + relatedlistflagstep1);
        }
         
        if(stepNo==3 && stepNo!=1)
        {
            system.debug('i am in step 3 of showtab');
            relatedlistflagstep2=false;
            relatedlistflagstep1=false;
            relatedlistflagstep3=false;
            system.debug('i am in step 3 of showtab flag value' + relatedlistflagstep1);
            refreshCountButtonMethod();
        }
        if((stepNo==4)  || (TactFlag==false && stepNo==3) )
        {
            system.debug('i am in step4 of showtab');
            relatedlistflagstep3=true;
            relatedlistflagstep1=true;
            relatedlistflagstep2=true;
        }
         if((stepNo==5 && detailPage!=true) || (TactFlag==false && stepNo==4 && detailPage!=true))
        {
            relatedlistflagstep3=false;
            relatedlistflagstep1=false;
            relatedlistflagstep2=true;
                 
            if(selectedChannel==null || selectedChannel == '')// Design change for channel vendor screen     
            {
                system.debug('$$$$In if save');
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Channel is mandatory field.Please select the value');//Same old drama 
                ApexPages.addMessage(myMsg);
                return null;
            }
        }
        
        
       if (objcampaign.id!=null && DetailPage==true)
        {
        ref = new Pagereference('/apex/CampaignWizard?Id='+objcampaign.id+'&stepNo='+stepNumFromPage);
        ref.setredirect(true); 
        return ref;
        }              
      else
      {
      return null;  
      }
     
}
    
    public PageReference UnlockAudienceSelection()
    {
        Pagereference ref;
        try{
            deleteAudienceMethod();
            //This method will rest duplicate audience report records in case use unlock the child segment
            Audience_dedupeHelper.resetAuReportDuplicateHandler(campId);
            unlockbatchID = Audience_dedupeHelper.unlockbatchID;
            system.debug('uinlock batch id@@@@'+ unlockbatchID);
            CampaignMemberCriteriaManager.resetCampaignMemberCriteriasSync(campId,unlockbatchID);
            unlockAudienceSelectionHelper();
            
            //AudienceReport_Helper.rollupFinalCountDetailToSegmented(new list<Id>{campId},false);
            ref = new Pagereference('/apex/CampaignWizard?Id='+objcampaign.id+'&stepNo='+stepno);
            ref.setredirect(true);
        }catch(Exception ex){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Something went Wrong. Please contact Administrator !!'+ex.getMessage()));
            
        }
        
        return ref;
    }
    
    private void unlockAudienceSelectionHelper()
    {
        Campaign thisCamp = [SELECT CRM_WdmDedupeProcessId__c FROM Campaign WHERE Id =: objcampaign.Id];
        if (String.isBlank(thisCamp.CRM_WdmDedupeProcessId__c)) return;
        
        List<AsyncApexJob> jobs = [SELECT Id, Status FROM AsyncApexJob WHERE Id =: thisCamp.CRM_WdmDedupeProcessId__c];
        if (jobs.size() > 0)
        {
            AsyncApexJob thisJob = jobs[0];
            if (thisJob.Status != 'Aborted' && thisJob.Status != 'Completed')
            {
                System.debug('Alex Job Id: ' + thisJob.Id);
                System.abortJob(thisJob.Id);
            }
        }
        
        thisCamp.CRM_WdmDedupeProcessId__c = null;
        update thisCamp;
    }
    
    
    
    public PageReference CloneCampaign()
    {
        system.debug('### CloneCampaign  ##### ');
        pagereference ref;
        
        //Design Change for channel vendor screen : Inactive values validation 
        try{
            ClonePlusController clone=new ClonePlusController();
            string CloneCampid =clone.initialiseObjectsForCloning(campId);
            
            system.debug('### CloneCampid ##### '+CloneCampid);
            
            if (CloneCampid!=null){
            
                    ref = new PageReference('/apex/campaignWizard?Id='+CloneCampid+'&cloneFlag=true');
                ref.setredirect(true);
                return ref;
            
            }
            
        }catch(Exception ex){   
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Something went Wrong. Please contact Administrator !!'+ex.getMessage()));
             System.debug(ex.getMessage() + ' at line' + ex.getLineNumber());
             return null;
        }
        return null;
        // Design change of Channel and vendor screen : inactive refrence data validaion   
    }
    
 /*************Main Wrapper Class *************/
    
 /**  public class WrapperClassForDRGCheckBox
    {
        public DRG_Code__c WrapperdrgCo{get;set;}
        public boolean flag{get;set;}       
        public WrapperClassForDRGCheckBox(DRG_Code__c dg)
        {
            WrapperdrgCo=dg;
            flag=false;
        }
        
    }  **/
    
    
  /** public void Search() 
    {
        Map<String, Schema.SObjectField> schemaFieldMap = Schema.SObjectType.Contact.fields.getMap();
        List<String> lstWhereCondition = new List<String>();
        lstRecord = new List<wrapRecord>();
        String strQuery = 'SELECT Id,FirstName,Lastname,Title,Email,AccountId,Account.Name FROM Contact';        
        for(filterCriteria filter : lstFilter) {
               system.debug('^^^fieldapi'+filter);

            if(String.isNotBlank(filter.fieldApi) && String.isNotBlank(filter.operator)) 
            {
                system.debug('^^^fieldapi'+filter);
                //if(!strQuery.contains('WHERE')) strQuery += ' WHERE';
               String strOperator = filter.operator;
                strOperator = strOperator.replace('{1}', filter.fieldApi);
                
                String value = filter.value;
                
                Schema.DisplayType fieldType = schemaFieldMap.get(filter.fieldApi).getDescribe().getType();                
                if((fieldType == Schema.DisplayType.ANYTYPE || fieldType == Schema.DisplayType.STRING ||
                    fieldType == Schema.DisplayType.REFERENCE || fieldType == Schema.DisplayType.EMAIL || 
                    fieldType == Schema.DisplayType.ENCRYPTEDSTRING || fieldType == Schema.DisplayType.ID ||
                    fieldType == Schema.DisplayType.PICKLIST || fieldType == Schema.DisplayType.MULTIPICKLIST ||
                    fieldType == Schema.DisplayType.TEXTAREA || fieldType == Schema.DisplayType.URL) &&
                   (filter.operator=='{1}={0}' || filter.operator=='{1}!={0}'))
                {
                    value = '\'' + value + '\'';
                }
                
                strOperator = strOperator.replace('{0}', value);                
                lstWhereCondition.add(strOperator);     
                
            }
        }
        if(campId != null)
            lstWhereCondition.add('Id NOT IN (SELECT ContactId FROM CampaignMember WHERE CampaignId=\''+campId+'\')');
        // lstWhereCondition.add('Id NOT IN (SELECT ContactId FROM CampaignMember WHERE CampaignId=\''+campaignId+'\')');      
        if(lstWhereCondition.size()>0) {
            strQuery += ' WHERE ' + String.join(lstWhereCondition, ' AND ');                        
        }
        strQuery += ' LIMIT 1000';
        System.debug('>>>strQuery : ' + strQuery);
        try {     
            lstRecord = new List<wrapRecord>();
            for(Contact objContact : Database.query(strQuery)) {
                lstRecord.add(new wrapRecord(objContact));
            }            
            if(lstRecord.size()>=1000) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Only 1000 records displayed, Please refine the search using filters !!'));
            }
        }
        catch(Exception ex) 
        {           
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Something went Wrong. Please contact Administrator !!'));
            System.debug(ex.getMessage() + ' at line' + ex.getLineNumber());
        }
    }
    
    **/
    
  /**  public void AddCampaignMembers() 
    {
        Map<id, Contact> mapCon = new map<id, Contact>();
        ConSet = new Set<id>();
        if(!ConSet.IsEmpty())
            for(CampaignMember C : [select Id,CampaignId, ContactId from CampaignMember where CampaignId=:campId])
        {
                ConSet.add(C.ContactId);
                
            }
        for(Contact Con : [Select Id, FirstName,Account.Name, LastName, Title,AccountId,Email from Contact where id IN: ConSet]){
            mapCon.put(con.id,con);
        }
        Map<id, Contact> mapContact = new Map<id, Contact>();
        if(!Detailmemberlist.IsEmpty())
           for(wrapRecord wc : Detailmemberlist)
            {
                mapContact.put(wc.objContact.Id, wc.Objcontact);
            }
        for(wrapRecord w : lstRecord)
        {
            if(w.Isselected == true && !mapCon.containsKey(w.objContact.id) && !mapContact.containsKey(w.objContact.id))
            {
                wrapRecord cont = new wrapRecord(w.objContact);
                cont.IsSelected = false;
                Detailmemberlist.add(cont); 
            }
        }
        addedtocampaign = true;
    }  **/
    
    private Map<String,String> mapOperator
    {
        get
        {
            Map<String,String> mapOperator = new Map<String,String>();
            mapOperator.put('equals', '{1}={0}');
            mapOperator.put('not equal to', '{1}!={0}');
            mapOperator.put('starts with', '{1} LIKE \'%{0}\'');
            mapOperator.put('contains', '{1} LIKE \'%{0}%\'');
            mapOperator.put('does not contains', '(NOT {1} LIKE \'%{0}%\')');
            return mapOperator;
        }        
    }
    
    public List<SelectOption> getFields() 
    {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new Selectoption('','--None--'));
        
        Map<String, Schema.SObjectField> schemaFieldMap = Schema.SObjectType.Contact.fields.getMap();
        Map<String, List<String>> mapField = new Map<String,List<String>>();
        for(String fieldName : schemaFieldMap.keySet())
        {
            String key = schemaFieldMap.get(fieldName).getDescribe().getLabel();
            if(!mapField.containsKey(key)) 
            {
                mapField.put(key, new List<String>());
            }
            mapField.get(key).add(fieldName);            
        }
        List<String> lstFieldName = new List<String>(mapField.keySet());
        lstFieldName.sort();
        for(String fieldLabel : lstFieldName) 
        {            
            for(String fieldApi : mapField.get(fieldLabel)) 
            {
                options.add(new SelectOption(fieldApi, fieldLabel));
            }
        } 
        
        return options;
    }
    
    public List<SelectOption> getOperator() 
    {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new Selectoption('','--None--'));
        
        for(String operatorName : mapOperator.keySet()) 
        {
            options.add(new Selectoption(mapOperator.get(operatorName), operatorName));
        }           
        return options;
    }
    
    public class filterCriteria
    {
        public String fieldApi{get;set;}
        public String operator{get;set;}
        public String value{get;set;}   
        
        public filterCriteria() {
            fieldApi = operator = value = '';            
        }
    }
    
    public class wrapRecord 
    {
        Public Boolean isSelected{get;set;}
        Public Contact objContact{get;set;}
        
        public wrapRecord(Contact contactRec) 
        {
            isSelected = false;
            objContact = contactrec;
        }
    }
    
    /********Next Step ************/
    public Pagereference nextStep() 
    {
    
    Pagereference ref;
        //start of PP4 change
     if((objcampaign.EndDate<objcampaign.StartDate) && segmentedparentCampName==null )
         // end of PP4 change
     {
        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Campaign Start Date: The campaign end date should not be before the start date');//Same old drama 
        ApexPages.addMessage(myMsg);
      }
       /*Campaign detail screen change :Sub Service/Service Line*/
        //start of PP4 change
     if((selectedServiceLine==null || selectedServiceLine=='') && DetailPage!=true && objcampaign.status!='Active' && segmentedparentCampName==null )
    //end of PP4 change
     {
        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Service line is required field .Please select the value');//Same old drama 
        ApexPages.addMessage(myMsg);
        return null;
      }
     /*Campaign detail screen change :Sub Service/Service Line*/
    
      system.debug('before next method=====' );
        
       //validation msg for Ownership process
       //start of PP4 change
     if(selectedCriteria.isEmpty() && DetailPage!=true && objcampaign.status!='Active' && segmentedparentCampName==null )
    //end of PP4 change
     {
        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please select the Ownership ');
        ApexPages.addMessage(myMsg);
        return null;
      }  
      
       
        else  if(parentCampName!=null && parentCampName.length()>0 && parentCampName!='') {
           List<Campaign> lstCampaigns = [SELECT id FROM Campaign WHERE name = :parentCampName];
           if(lstCampaigns.size() == 0) {
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Please enter the valid parent name');
                ApexPages.addMessage(myMsg);
                return null;
             
          }
          
        if(objcampaign.name==parentcampname){
          ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Parent campaign cannot be same as current campiagn name');
                ApexPages.addMessage(myMsg);
                return null;
          }
          else {
            stepNo++;
            system.debug('step no is getting +');           
            if(stepNo>maxStep) 
            { stepNo = maxStep; 
            }
            ViewChildCampaign();
            refreshCountButtonMethod();
            //tactic();
            TacticMember();
          
          }
           
        }
            else 
        {
            system.debug('i am in else in nest');
            stepNo++;
            system.debug('step no is getting +');           
            if(stepNo>maxStep) 
            { stepNo = maxStep; 
            }
            ViewChildCampaign();
            refreshCountButtonMethod();
            //tactic();
            TacticMember();
       }
       
        system.debug('##### DetailPage ####'+DetailPage); 
        if (objcampaign.id!=null && DetailPage==true)
        {
         system.debug('##### DetailPage ####'+DetailPage); 
        ref = new Pagereference('/apex/CampaignWizard?Id='+objcampaign.id+'&stepNo='+stepNo);
        ref.setredirect(true); 
        return ref;
        }              
      else
      {
      return null;  
      }                   
    }
    
    
     /********Previous Step ************/
    public Pagereference previousStep()
    {
    
    Pagereference ref;
        stepNo--;
        if(stepNo<1) 
        { 
            stepNo = 1;
        }
        ViewChildCampaign();
        TacticMember();
        refreshCountButtonMethod();
          if (objcampaign.id!=null && DetailPage==true)
        {
        ref = new Pagereference('/apex/CampaignWizard?Id='+objcampaign.id+'&stepNo='+stepNo);
        ref.setredirect(true); 
        return ref;
        }              
      else
      {
      return null;  
      }           
    }
    
   
    
    
    /********* View child campaign list **************/
    public void ViewChildCampaign()
    {
        if(campId!=null) {
        lstCamp_memb=new List<Campaign>();
      //  lstCamp_memb1=new List<Campaign>();
       
        lstCamp_memb=[select parentId,name,status,Program_Name__c,Description from campaign where parentId=:campId];
        System.debug('ParentList $$$'+lstCamp_memb);
        //System.debug('ParentList $$$'+lstCamp_memb.);       
        if(lstCamp_memb.size()>0)
        {
            CampChildViewFlag=true;
            for(campaign cc:lstCamp_memb)
            {
                lstCamp_memb1.add(cc);
                
                system.debug('######ch'+lstCamp_memb1);
            }
        }
        } 
        
        
    }
    
    
    
    
     public pageReference SaveCampaign()
    {
        noNextB=true;
        PageReference CampaignDetail;
        try
        {
            system.debug('*****cccc'+noNextB);
            system.debug('*****'+SelectedSubServLines);
            string ServiceLine = null;
            string HospitalField = null;
            string TacticCamp=null;
            String PayorCamp=null;
            noNextB=true;    
            
            if (!isExternalupload(objcampaign.Member_Types__c) && objcampaign.Add_Member_Status__c != 'Calculated Net Count')
            {
                deleteAudienceMethod();
            }
            
            if (isExternalUpload(objcampaign.Member_Types__c))
            {
                Integer transCount = [SELECT Count() FROM Transaction__c WHERE Campaign__c =: objcampaign.Id AND Transaction_Source__c = 'Audience Upload'];
                if (transCount == 0)
                {
                    deleteAudienceMethod();
                }
            }
         
            //Design change for channel and vendor screen               
            refrenceDataMap = new  Map<id,CRM_CampaignWizardReferenceData__c>();
           
             for(CRM_CampaignWizardReferenceData__c objCRMVal : [Select id ,CRM_Channel__c,CRM_CallToAction__c,CRM_VendorName__c,CRM_ServiceLine__c,CRM_SubServiceLine__c FROM CRM_CampaignWizardReferenceData__c ])  
               refrenceDataMap.put(objCRMVal.id,objCRMVal);
              
            system.debug('>>>>refrenceDataMap<<<<'+refrenceDataMap);
            
            Map<String ,List<String>> junctionObjectMap=new Map<String ,List<String>>();
           //start of PP4 change
            if(selectedVendor!=null && selectedVendor!='' && segmentedparentCampName==null )
            objcampaign.Vendor_name__c =refrenceDataMap.get(selectedVendor).CRM_VendorName__c ;
            else objcampaign.Vendor_name__c=null;
            
            if(selectedChannel!=null && selectedChannel!=''  )
            objcampaign.Channel__c =refrenceDataMap.get(selectedChannel).CRM_Channel__c;
            else 
                objcampaign.Channel__c=null;
             
            system.debug('channel value after else condition@@@@'+ objcampaign.Channel__c);
            System.debug('###  selectedCallToAction ## '+ selectedCallToAction);
            
            if (selectedCallToAction!=null && selectedCallToAction!='' && objcampaign.CRM_ParentSegmentedCampaign__c==null )
            objcampaign.Call_to_Action__c=refrenceDataMap.get(selectedCallToAction).CRM_CallToAction__c;
            else {objcampaign.Call_to_Action__c=null;}
             
            // End :Design change for channel and vendor screen 
            /*Start :Campaign detail screen change :Sub Service/Service Line*/
            if (selectedServiceLine!=null && selectedServiceLine!='' && objcampaign.CRM_ParentSegmentedCampaign__c==null)
            {              
                 objcampaign.Service_Line__c=refrenceDataMap.get(selectedServiceLine).CRM_ServiceLine__c ;                
            }
            else if(objcampaign.CRM_ParentSegmentedCampaign__c==null)
            {
               objcampaign.Service_Line__c=null;
               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please enter Service Line value'));
               return null; 
            }
            
            if (selectedValSSL.size()>0 && objcampaign.CRM_ParentSegmentedCampaign__c==null)
                //start of PP4 change
            { 
                List<String> SSLValList =new List<String>();
                for(String SSL : selectedValSSL)
                SSLValList.add(refrenceDataMap.get(SSL).CRM_SubServiceLine__c);
                objcampaign.CRM_SubServiceLineText__c=String.join(SSLValList,';');
            }
            else
            {
                objcampaign.CRM_SubServiceLineText__c=null;
            }
          
                 List<string> allSelectedIds = new List<string>();
                    
                    if(selectedValSSL.size()>0)
                    allSelectedIds.addAll(selectedValSSL);                    
                    if(selectedServiceLine!=null && selectedServiceLine!='')
                    allSelectedIds.add(selectedServiceLine);
                    if(selectedChannel!=null && selectedChannel!='')    
                    allSelectedIds.add(selectedChannel);
                    if(selectedCallToAction!=null && selectedCallToAction!='')    
                    allSelectedIds.add(selectedCallToAction);
                    if(selectedVendor!=null && selectedVendor!='')    
                    allSelectedIds.add(selectedVendor);
               system.debug('****selectedValSSL='+allSelectedIds );
                
            /*end :Campaign detail screen change :Sub Service/Service Line*/
            
            /*** Save SubServiceLine MultiSelect Picklist ***/
            for(integer i=0;i < SelectedSubServLines.size();i++)
            {                
                if(ServiceLine == null)
                ServiceLine = SelectedSubServLines[i].getValue();
                else
                ServiceLine += ';'+SelectedSubServLines[i].getValue();
                system.debug('size of available list'+ AllSubServLines.size());
                for(integer j=0; j<AllSubServLines.size(); j++)
                {
                system.debug('values of available list'+ AllSubServLines[j].getValue());
                }
            }
            // system.debug('size of available list after remove==========='+ AllSubServLines.Size());
            
            
            
            /*** Save hospital MultiSelect Picklist ***/
          /*  for(integer i=0;i < SelectedHospitalList.size();i++)
            {                
                if(HospitalField == null)
                HospitalField = SelectedHospitalList[i].getValue();
                else
                HospitalField += ';'+SelectedHospitalList[i].getValue();
                    
            } */
          
           
           
          
            
            // system.debug('size of available list after remove==========='+ AllSubServLines.Size());
         //   objcampaign.Audience_Hospital__c = HospitalField ;
            
            system.debug('#### objcampaign.Call_to_Action__c #####'+ objcampaign.Call_to_Action__c);    
            if(objcampaign.id==null){
            objcampaign.Name = 'New Campaign';
            } 
            system.debug('&&&&&^^^^^^'+TemplateFlag);           
            system.debug('********* Childflag'+Childflag);            
            //Desgin change for Channel screen  
            if(selectedChannel!=null && selectedChannel!= '')
            {
              objcampaign.RecordTypeId=ReferenceData_PicklistController.getCampaignRecordTypeId(selectedChannel);  
            }
            //start of PP4 change
            else if(objcampaign.CRM_ParentSegmentedCampaign__c==null)
            //end of PP4 change
            {
                system.debug('$$$$In if save');
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Channel is required.Please select the value');//Same old drama 
                ApexPages.addMessage(myMsg);
                return null;
            }
            //Desgin change for Channel screen 
            
            /** for saving ownership field values ***/
            //start of PP4 change
             if(selectedCriteria.isEmpty() && DetailPage!=true && objcampaign.status!='Active' && objcampaign.CRM_ParentSegmentedCampaign__c==null)
            //end of PP4 change
             {
        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please select the Ownership ');
        ApexPages.addMessage(myMsg);
        return null;
      }  
            //start of PP4 change
            else if(selectedCriteria!=null && objcampaign.CRM_ParentSegmentedCampaign__c==null)
            //end of PP4 change
            {
            
          saveownershipvalues();
          
          objcampaign.CRM_SelectedOwnershipCriteria__c=string.join(selectedownershipCodes,', ');
            system.debug('*****objcampaign.CRM_SelectedOwnershipCriteria__c'+ objcampaign.CRM_SelectedOwnershipCriteria__c);
          }
            //start of PP4 change
            if( objcampaign.CRM_ParentSegmentedCampaign__c==null){
                //end of PP4 change
           objcampaign.CRM_OwnershipType__c = ReferenceData_PicklistController.recordTypeDeveloperName('CRM_CampaignLocationReferenceData__c', selectedOwnerType);
            system.debug('%%%%%%%%%ownership type value in save%%%%%%%' + objcampaign.CRM_OwnershipType__c );
            }
            else
             objcampaign.CRM_OwnershipType__c = null;   
                //End of Ownership Process
            
             targetedid = [select id from RecordType where developerName='Targeted' ][0].Id;
         nontargetedid = [select id from RecordType where developerName='Non_Targeted'][0].Id;
         
         //AXU fix for defect CRM-318
        if (String.isBlank(selectedChannel))
         {
             List<CRM_CampaignWizardReferenceData__c> cwrds = [SELECT Id FROM CRM_CampaignWizardReferenceData__c WHERE CRM_Channel__c =: objcampaign.Channel__c];
             if (cwrds.size() != 1)
                throw new ApplicationException('Cannot retrieve Channel information');
             selectedChannel = cwrds[0].Id;
         } 
         //END fix for defect CRM-318
         
         selectedchannelID =  ReferenceData_PicklistController.getCampaignRecordTypeId(selectedChannel);
        if(selectedChannel!=null && objcampaign.Member_Types__c=='Campaign Segments'){
        system.debug('inside if condition@@@@');
        // selectedchannelID =  ReferenceData_PicklistController.getCampaignRecordTypeId(selectedChannel);
        if(selectedchannelID != targetedid && childCampaign.size()>0){
            system.debug('####inside second if####');
            ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Info,Label.CRM_SegmentChannelChangeLabel);
            Apexpages.addMessage(msg);  
            return null;
        }
        }
            
            
            system.debug('control group percentage@@@@ after null'+objcampaign.Control_Group_Percentage__c);
            
            
            system.debug('approved by value================='+ objcampaign.Approved_By__c);
            system.debug('approved  value================='+ objcampaign.Approved__c);
            if(objcampaign.Approved__c== true && objcampaign.Approved_By__c=='' )
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please enter the Approved By name'));
                return new PageReference('/apex/CampaignWizard?id='+ objcampaign.Id);
            }
            
            
            if((objcampaign.id!=null && objcampaign.Control_Group_Size__c==null && objcampaign.Control_Group_Percentage__c==null && stepNo==5 && segmentedparentCampName==null && tactflag==true) || (objcampaign.id!=null && objcampaign.Control_Group_Size__c!=Null && objcampaign.Control_Group_Percentage__c!=Null && stepNo==5 && segmentedparentCampName==null && tactflag==true)) 
            {
            system.debug('campiagn id@@@@'+ objcampaign.id);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select either Control Group Size or Control Group Percentage'));
               // return new PageReference('/apex/CampaignWizard?id='+ objcampaign.Id);
               return null;
            }
            
            if(objcampaign.id!=null && ( objcampaign.Control_Group_Percentage__c > 100 || objcampaign.Control_Group_Percentage__c==100) && objcampaign.Control_Group_Size__c==null ) 
            {
            system.debug('campiagn id@@@@'+ objcampaign.id);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Control Group Percentage cannot be equal to or greater than 100'));
               // return new PageReference('/apex/CampaignWizard?id='+ objcampaign.Id);
               return null;
            }
            
         /*    if(objcampaign.id!=null && (objcampaign.Control_Group_Percentage__c >=0 || objcampaign.Control_Group_Size__c!=null) && segmentedparentCampName!=null){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,System.Label.CRM_ControlGroupValidation));
               // return new PageReference('/apex/CampaignWizard?id='+ objcampaign.Id);
               return null;
            } */
            
            if(parentCampName!=null && parentCampName.length()>0 && parentCampName!='') 
            {
                List<Campaign> lstCampaigns = [SELECT id FROM Campaign WHERE name = :parentCampName];
                if(lstCampaigns.size() == 0) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please enter the valid parent name'));
                    return new PageReference('/apex/CampaignWizard?id='+ objcampaign.Id); 
                } 
            }
            //Changes for PP1 Start
            if(OldMemberType!=objcampaign.Member_Types__c && (objcampaign.Add_Member_Status__c == 'Calculated Net Count' || objcampaign.Add_Member_Status__c == 'Adding Audience Report' || objcampaign.Add_Member_Status__c == 'Order Placed')){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CRM_Update_Locked_Campaign));
                return null;
            }
            
         /*   if(lockChannelValue==true && oldChannelValue!=objcampaign.Channel__c && objcampaign.CRM_ParentSegmentedCampaign__c==null){
              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CRM_Update_Channel_Locked_Campaign));
                return null;  
            } */
            //Changes for PP1 End
            RecordType rt = [select id,developerName from RecordType where id=:objcampaign.RecordTypeId];
            
            if(rt.developerName=='Targeted')
                isTargetedCampaign=true;
            else isTargetedCampaign=false;
                
            if(isTargetedCampaign&& objcampaign.Member_Types__c=='None')
                objcampaign.Member_Types__c='Any or no encounters - Everyone';
             
            
             //Changes for PP1 Starts
             /*if(OldMemberType != objcampaign.Member_Types__c && (objcampaign.Member_Types__c=='Upload List' || OldMemberType=='Upload List')){
                objcampaign.Current_Count__c=null;
             }*/
             //Changes for PP1 Ends                 
            /******Save as template check *********/ 
            if(TemplateFlag=='true')
            {               
                system.debug('&&&&&^&&&&&^^^^^'+TemplateFlag);
                // Start :Audience Selection criteria stories changes(BirthMonth) :added CRM_Refreshed_Count_Date__c field 
                Campaign tempcamp=[select id,CRM_Refreshed_Count_Date__c,Version__c,Audience_Hospital__c,Current_count__c,Audience_Region__c,Audience__c,name,status,Program_Name__c,Description,Member_Types__c,
                StartDate,EndDate,Purchase_Invoice_Order__c,Approved__c,Approved_By__c,Expected_Contribution_Margin__c,MARS_Approval__c,Actual_Spend__c,//Goal_Objective__c,
                Service_Line__c,Campaign_Budget__c,Channel__c,CRM_SelectedOwnershipCriteria__c,CRM_OwnershipType__c,
                Tactic__c,of_Members__c,of_CampaignMembers__c,Vendor_Name__c,LastModifiedDate,CRM_SubServiceLineText__c, Sub_Service_Line__c
                from campaign where id=:campId];
                // End :Audience Selection criteria stories changes(BirthMonth)
                system.debug('^^^^^^'+tempcamp);
                Campaign camp_clone=tempcamp.clone(false,true);
                system.debug('@@@@@@@clone camp'+camp_clone);                
                camp_clone.Name=objcampaign.name;
                camp_clone.Status=objcampaign.status;
                camp_clone.Program_Name__c=objcampaign.Program_Name__c;
                // camp_clone.Goal_Objective__c=objcampaign.Goal_Objective__c;
                camp_clone.Description=objcampaign.Description;
                camp_clone.Member_Types__c=objcampaign.Member_Types__c;
                camp_clone.StartDate=objcampaign.StartDate;
                camp_clone.EndDate=objcampaign.EndDate;
                camp_clone.Purchase_Invoice_Order__c=objcampaign.Purchase_Invoice_Order__c;
                camp_clone.Approved__c=objcampaign.Approved__c;
                camp_clone.Approved_By__c=objcampaign.Approved_By__c;
                camp_clone.MARS_Approval__c=objcampaign.MARS_Approval__c;
                
                /*Campaign detail screen change :Sub Service/Service Line*/
                camp_clone.Service_Line__c=objcampaign.Service_Line__c;
                camp_clone.CRM_SubServiceLineText__c=objcampaign.CRM_SubServiceLineText__c;
                camp_clone.call_to_action__c=objcampaign.call_to_action__c;
                /*Campaign detail screen change :Sub Service/Service Line*/
                
                camp_clone.Campaign_Budget__c=objcampaign.Campaign_Budget__c;
                camp_clone.Expected_Contribution_Margin__c=objcampaign.Expected_Contribution_Margin__c;
                camp_clone.Channel__c=objcampaign.Channel__c;
                camp_clone.Tactic__c=objcampaign.Tactic__c;
                camp_clone.Vendor_Name__c=objcampaign.Vendor_Name__c;
                camp_clone.Actual_Spend__c=objcampaign.Actual_Spend__c;
                //camp_clone.of_CampaignMembers__c=objcampaign.of_CampaignMembers__c;
                camp_clone.of_Members__c=objcampaign.of_Members__c;
                camp_clone.Other__c=objcampaign.Other__c;
                camp_clone.Tactic__c=TacticCamp;
                camp_clone.Requested_By__c=objcampaign.Requested_By__c;
               // camp_clone.Audience__c=objcampaign.Audience__c;
               // camp_clone.Audience_Hospital__c=objcampaign.Audience_Hospital__c;
                //camp_clone.Audience_Region__c=objcampaign.Audience_Region__c;
                camp_clone.Version__c=objcampaign.Version__c;
                camp_clone.count_of_index__c=objcampaign.count_of_index__c;
                camp_clone.CRM_OwnershipType__c = objcampaign.CRM_OwnershipType__c;
               // camp_clone.CRM_SelectedOwnershipCriteria__c = objcampaign.CRM_SelectedOwnershipCriteria__c;
                // Start :Audience Selection criteria stories changes(BirthMonth) 
                camp_clone.CRM_Refreshed_Count_Date__c= null;
                // End :Audience Selection criteria stories changes(BirthMonth) 
                
                system.debug('&&&& objcampaign'+objcampaign);
                //camp_clone=objcampaign;
                system.debug('&&&&copied'+camp_clone);   
                camp_clone.List_Order_Id__c = null;  
                camp_clone.Current_count__c = null;
                String oldvalue;
                // Added for Audience Selection Criteria story - PresetEmail/Mail
                String channelOldValue;
                // end of Added for Audience Selection Criteria story - PresetEmail/Mail
                
                if(camp_clone.id!=null) 
                {
                    oldvalue = [SELECT Member_Types__c FROM Campaign WHERE id=:camp_clone.id].Member_Types__c;
                    // Added for Audience Selection Criteria story - PresetEmail/Mail
                    channelOldValue = [SELECT Channel__c FROM Campaign WHERE id=:camp_clone.id].Channel__c ;
                    // end of Added for Audience Selection Criteria story - PresetEmail/Mail
                }
                else
                    oldvalue = null;
                     
                insert camp_clone;
                
                
                if(camp_clone.id!=null) 
                {
                    System.debug('*******inside member type criteria logic***********');
                    String newvalue = camp_clone.Member_Types__c;                
                    insertMemberTypeCriteria(camp_clone.id,oldvalue ,newvalue);
                    // Added for Audience Selection Criteria story - PresetEmail/Mail 
                    String channelNewvalue = camp_clone.Channel__c; 
                    UpsertDemoCriteras(camp_clone.id,channelOldValue,channelNewvalue );      
                    // end of Added for Audience Selection Criteria story - PresetEmail/Mail 
                }
                system.debug('&&&& new save clone template'+camp_clone);
                system.debug('&&&& new save clone template ID'+camp_clone.Id);
                camp_clone_Id=camp_clone.Id;
                camp_clone1=camp_clone;
                CampNamingConvention();
                if(camp_name.length()>80){
                    ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Info,Label.Campiagn_Name_Convention);
                    Apexpages.addMessage(msg); 
                    return null;
                }
                camp_clone1.Name=objcampaign.Name;
                camp_clone1.count_of_index__c=campname_value1;
                newCampaign=camp_clone1.Name; 
                objcampaign.Version__c=camp_clone1.Version__c;
                objcampaign.count_of_index__c=camp_clone1.count_of_index__c;
                system.debug( 'value of  objcampaign.count_of_index__c======='+  objcampaign.count_of_index__c);
                update camp_clone1;
                system.debug('&&&& new save child ID'+camp_clone1);
                system.debug('&&&& name flag in template condition==='+nameFlag);
                system.debug('&&&& newCampaign in template condition==='+newCampaign);
                
                 /**** Save ownership selection in junction object ****/
                if(objcampaign.id!=null)
                    insertOwnershipJO(camp_clone.id);
                
                /*Campaign detail screen change :Sub Service/Service Line and Design change for channel and vendor */
 
                if(allSelectedIds.size()>0)
                    ReferenceData_PicklistController.updateJunctionObject(camp_clone1.id,allSelectedIds);  
                
                /*Campaign detail screen change :Sub Service/Service Line and Design change for channel and vendor */
                
                            
                
            }else
            {
                String oldvalue;
                // Added for Audience Selection Criteria story - PresetEmail/Mail
                String channelOldValue;
                // end of Added for Audience Selection Criteria story - PresetEmail/Mail
                
                if(objcampaign.id!=null) 
                {
                    oldvalue = [SELECT Member_Types__c FROM Campaign WHERE id=:objcampaign.id].Member_Types__c;
                    // Added for Audience Selection Criteria story - PresetEmail/Mail
                    channelOldValue = [SELECT Channel__c FROM Campaign WHERE id=:objcampaign.id].Channel__c ;
                    // end of Added for Audience Selection Criteria story - PresetEmail/Mail
                }
                else
                    oldvalue = null;  
                
                //  if(segmentedparentCampName!=null) 
                //   objcampaign.Name = 'New Campaign';
                // else{    
                CampNamingConvention();
                if(camp_name.length()>80){  
                    ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Info,Label.Campiagn_Name_Convention);
                    Apexpages.addMessage(msg); 
                    return null;
                }
                   // }
                
                objcampaign.audience__c=null;
                objcampaign.Audience_Region__c=null;
                objcampaign.Audience_Hospital__c=null;
                system.debug('@@@@after insert'+objcampaign.Name);
                
                system.debug('####after second save '+ objcampaign.Current_count__c);
                system.debug('%%%%%%%%%%5 name flag' + nameFlag);
                //CampNamingConvention();                
                system.debug('#########################'+objcampaign.Name);
                system.debug('%%%%%%%%%%5 name flag' + nameFlag);
                newCampaign=objcampaign.Name;
                objcampaign.count_of_index__c=campname_value1;
                if(parentCampName!=null && parentCampName.length()>0 && parentCampName!='') 
                {
                    List<Campaign> lstCampaigns = [SELECT id FROM Campaign WHERE name =:parentCampName];
                    if(lstCampaigns.size()>0)
                    objcampaign.parentid = lstCampaigns[0].id; 
                }
                else
                    objcampaign.parentid = null;
                               
                upsert objcampaign;
                
                if(objcampaign.id!=null) 
                {
                    System.debug('*******inside member type criteria logic***********');
                    String newvalue = objcampaign.Member_Types__c;           
                       
                    insertMemberTypeCriteria(objcampaign.id,oldvalue ,newvalue);
                    
                    if(!string.isBlank(oldvalue) && oldvalue != newValue && newValue=='Campaign Segments')
                        CampaignMemberCriteriaManager.resetCampaignMemberCriteriasSync(campId,unlockbatchID);
                    
                    // Added for Audience Selection Criteria story - PresetEmail/Mail 
                    String channelNewvalue = objcampaign.Channel__c; 
                    system.debug('channle new value is@@@@@'+ channelNewvalue);
                    UpsertDemoCriteras(objcampaign.id,channelOldValue,channelNewvalue );      
                    // end of Added for Audience Selection Criteria story - PresetEmail/Mail 
                    // start ofPP4 change  
                    if(childCampaign!=null){
                      for(campaign c: childCampaign){
                        UpsertDemoCriteras(c.id,channelOldValue,channelNewvalue ); 
                        system.debug('channel old value$$$$$'+ channelOldValue );
                        system.debug('channel new value$$$$$'+ channelNewvalue );
                        if(channelOldValue!= channelNewvalue ){
                        
                         c.Current_count__c=null; 
                         update c;
                         system.debug('current count value!!!!'+ c.Current_count__c);
                         }
                      }  
                    }
                    // end of PP4 change
                }
                
                
                //upsert objcampaign;
                
                   /**** Save ownership selection in junction object ****/
                if(objcampaign.id!=null)
                    insertOwnershipJO(objcampaign.Id);
                system.debug('channel values are  ===='+ objcampaign.Channel__c);
             /*Campaign detail screen change :Sub Service/Service Line and Design change for channel and vendor */
                  
                if(allSelectedIds.size()>0)
                    ReferenceData_PicklistController.updateJunctionObject(objcampaign.id,allSelectedIds);  
                
               /*Campaign detail screen change :Sub Service/Service Line and Design change for channel and vendor */
                
                system.debug('&&&&&%%%%%%%updating'+objcampaign);
                system.debug('&&&& new save camp '+objcampaign.Id);
     
            }
               
            if(TemplateFlag==''|| TemplateFlag==null || Childflag==false)
            {
                
                DetailPage = true;
                
                system.debug('DetailPage *****'+DetailPage );
                system.debug('debug inside else*****'+objcampaign.Id);  
                CampaignDetail = new PageReference('/apex/CampaignWizard?id='+ objcampaign.Id +'&stepNo='+stepno + '&setflag='+setflag);
                CampaignDetail.setRedirect(true); 
            }
            if(TemplateFlag=='true')
            {
                DetailPage=true;
                
                system.debug('DetailPage *****'+DetailPage );
                CampaignDetail = new PageReference('/apex/CampaignWizard?id='+ camp_clone1.id);
                CampaignDetail.setRedirect(true); 
            } 
            
            if(Childflag==true)
            {
                DetailPage=true;
                system.debug('DetailPage *****'+DetailPage );
                stepno=4;
                CampaignDetail=new PageReference('/apex/CampaignWizard?id='+objcampaign.Id +'&stepNo=2');
                CampaignDetail.setRedirect(true); 
                ViewChildCampaign();
            } 
            
            return CampaignDetail;            
        }
        catch(Exception ex)
        {
            if(ex.getMessage().contains('Please provide the reason for Inactivation'))
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please provide the reason for Inactivation'));
            else if(ex.getMessage().contains('You will not able to Inactivate/Suspend the Campaign as the campaign start date should be earlier than today'))
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'You will not able to Inactivate/Suspend the Campaign as the campaign start date should be earlier than today'));
            else if(ex.getMessage().contains('You can not change Campaign Status'))
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'You can not change Campaign Status.'));
            else if(ex.getMessage().contains('Campaign is Inactivated.'))
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Campaign is Inactivated.'));
            else if(ex.getMessage().contains('DUPLICATE_VALUE'))    
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Call Center Identifier and Toll Free Number combination already exist.'));
            else
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, ex.getMessage()));
            System.debug(ex.getMessage() + ' at line' + ex.getLineNumber());
            return null;
        }   
    }
    
    public static void insertMemberTypeCriteria(String campaignId,String oldvalue, String newvalue)
    {
        System.debug('*************in the method call itslef**oldvalue*********'+oldvalue+'********new value*****'+newvalue);
        if(oldvalue!=null && oldvalue != newvalue) CampaignMemberCriteriaManager.updateCriteria('Member_Types__c', newvalue, campaignId, false);
        else if(oldvalue == null) {
            /*List<Campaign_Member_Criteria__c> lstexistingMemTypeCriteria = [SELECT id FROM Campaign_Member_Criteria__c WHERE Field_Name__c = 'Member_Types__c' AND Campaign__c =:campaignId];
            if(lstexistingMemTypeCriteria.size()==0)*/
                CampaignMemberCriteriaManager.insertCriteria('Member_Types__c', newvalue, campaignId, false,'Campaign');
        }
           
    }
    // Added for Audience Selection Criteria story - PresetEmail/Mail
     public static void UpsertDemoCriteras (String campaignId,String oldChannelvalue, String newChannelvalue)
     {
        System.debug('*************in the method call itslef**oldvalue*********'+oldChannelvalue+'********new value*****'+newChannelvalue);
        if(oldChannelvalue!= newChannelvalue) 
        {
            Map<String, List<String>> mapChannelValuesDemoFields = new Map<String, List<String>> ();            
            // Design change for channel vendor screen
            id RecordTypeid = [SELECT id FROM RecordType WHERE SobjectType='CRM_CampaignWizardReferenceData__c' AND DeveloperName='ChannelValues'][0].id;
            for(CRM_CampaignWizardReferenceData__c channelValues: [Select name,CRM_Channel__c,CRM_IsTargeted__c,CRM_DemoEmail__c, CRM_DemoMailingAddress__c 
                                                                     FROM CRM_CampaignWizardReferenceData__c WHERE Recordtypeid =:RecordTypeid]) 
            {
              // end of Design change for channel vendor screen
               if(channelValues.CRM_DemoEmail__c!=null && channelValues.CRM_DemoMailingAddress__c!=null) 
               {
                        List<String> lstDemoFields = new List<String>();
                        lstDemoFields.add(channelValues.CRM_DemoEmail__c);
                        lstDemoFields.add(channelValues.CRM_DemoMailingAddress__c);
                        mapChannelValuesDemoFields.put(channelValues.CRM_Channel__c,lstDemoFields);
                   system.debug('map####'+ mapChannelValuesDemoFields);
               }
            }
            List<Campaign_Demographics__c> existingcampaignDemo = [SELECT Suppression_Non_emailable__c,Address_Deliverable__c  FROM Campaign_Demographics__c WHERE Campaign__c=:campaignId];
             Campaign_Demographics__c objCampaignDemo ;
            if(mapChannelValuesDemoFields.containsKey(newChannelvalue)) 
            {
                system.debug('inside new channel value if condition@@@@');
                  // List<Campaign_Demographics__c> existingcampaignDemo = [SELECT Suppression_Non_emailable__c,Address_Deliverable__c  FROM Campaign_Demographics__c WHERE Campaign__c=:campaignId];
                   System.debug('*********mapChannelValuesDemoFields'+mapChannelValuesDemoFields.get(newChannelvalue));
                   if(existingcampaignDemo.size()>0 && (existingcampaignDemo[0].Suppression_Non_emailable__c!=mapChannelValuesDemoFields.get(newChannelvalue)[0] 
                   || existingcampaignDemo[0].Address_Deliverable__c!=mapChannelValuesDemoFields.get(newChannelvalue)[1])) 
                   {
                     objCampaignDemo = existingcampaignDemo[0];
                    objCampaignDemo.Suppression_Non_emailable__c = mapChannelValuesDemoFields.get(newChannelvalue)[0];
                    objCampaignDemo.Address_Deliverable__c  = mapChannelValuesDemoFields.get(newChannelvalue)[1];
                    update objCampaignDemo;
                    if(mapChannelValuesDemoFields.get(newChannelvalue)[1] == 'Everyone' && mapChannelValuesDemoFields.get(newChannelvalue)[0]!= 'Everyone') 
                    {
                        CampaignMemberCriteriaManager.insertCriteria('Suppression_Non_emailable__c', mapChannelValuesDemoFields.get(newChannelvalue)[0], campaignId, false,'Campaign_Demographics__c');
                        CampaignMemberCriteriaManager.deleteCriteria('Address_Deliverable__c',campaignId,false);
                    }
                    else if(mapChannelValuesDemoFields.get(newChannelvalue)[0] == 'Everyone' && mapChannelValuesDemoFields.get(newChannelvalue)[1]!= 'Everyone') 
                    {
                        CampaignMemberCriteriaManager.insertCriteria('Address_Deliverable__c', mapChannelValuesDemoFields.get(newChannelvalue)[1], campaignId, false,'Campaign_Demographics__c');
                        CampaignMemberCriteriaManager.deleteCriteria('Suppression_Non_emailable__c',campaignId,false);                   
                    }
                    else if(mapChannelValuesDemoFields.get(newChannelvalue)[0]!= 'Everyone' && mapChannelValuesDemoFields.get(newChannelvalue)[1]!= 'Everyone') 
                    {
                        CampaignMemberCriteriaManager.insertCriteria('Address_Deliverable__c', mapChannelValuesDemoFields.get(newChannelvalue)[1], campaignId, false,'Campaign_Demographics__c');
                        CampaignMemberCriteriaManager.insertCriteria('Suppression_Non_emailable__c', mapChannelValuesDemoFields.get(newChannelvalue)[0], campaignId, false,'Campaign_Demographics__c');
                    }
                    else if(mapChannelValuesDemoFields.get(newChannelvalue)[0] == 'Everyone' && mapChannelValuesDemoFields.get(newChannelvalue)[1] == 'Everyone') 
                    {
                        CampaignMemberCriteriaManager.deleteCriteria('Suppression_Non_emailable__c',campaignId,false);
                        CampaignMemberCriteriaManager.deleteCriteria('Address_Deliverable__c',campaignId,false);                       
                    }
                 }
                 else if(existingcampaignDemo.size() == 0) 
                 {   system.debug('inside else of Condotion!!!!!!');
                     Campaign_Demographics__c campaignDemo = new Campaign_Demographics__c (Suppression_Non_emailable__c = mapChannelValuesDemoFields.get(newChannelvalue)[0], Address_Deliverable__c = mapChannelValuesDemoFields.get(newChannelvalue)[1], Campaign__c = campaignId);
                     insert campaignDemo;
                     if(mapChannelValuesDemoFields.get(newChannelvalue)[1] == 'Everyone' && mapChannelValuesDemoFields.get(newChannelvalue)[0]!= 'Everyone')
                     {
                         CampaignMemberCriteriaManager.insertCriteria('Suppression_Non_emailable__c', mapChannelValuesDemoFields.get(newChannelvalue)[0], campaignId, false,'Campaign_Demographics__c');
                     }
                     else if(mapChannelValuesDemoFields.get(newChannelvalue)[0] == 'Everyone' && mapChannelValuesDemoFields.get(newChannelvalue)[1]!= 'Everyone') 
                     {
                         CampaignMemberCriteriaManager.insertCriteria('Address_Deliverable__c', mapChannelValuesDemoFields.get(newChannelvalue)[1], campaignId, false,'Campaign_Demographics__c');
                     }
                     else if(mapChannelValuesDemoFields.get(newChannelvalue)[0]!= 'Everyone' && mapChannelValuesDemoFields.get(newChannelvalue)[1]!= 'Everyone') 
                     {
                         CampaignMemberCriteriaManager.insertCriteria('Suppression_Non_emailable__c', mapChannelValuesDemoFields.get(newChannelvalue)[0], campaignId, false,'Campaign_Demographics__c');
                         CampaignMemberCriteriaManager.insertCriteria('Address_Deliverable__c', mapChannelValuesDemoFields.get(newChannelvalue)[1], campaignId, false,'Campaign_Demographics__c');
                     }
                 }
            }
           else{
           if(!mapChannelValuesDemoFields.containsKey(newChannelvalue) && (selectedchannelID==targetedid) && existingcampaignDemo.size()>0) {
           objCampaignDemo = existingcampaignDemo[0];
                objCampaignDemo.Suppression_Non_emailable__c = 'Everyone';
                    objCampaignDemo.Address_Deliverable__c  = 'Everyone';
                    update objCampaignDemo;
               CampaignMemberCriteriaManager.deleteCriteria('Suppression_Non_emailable__c',campaignId,false);
               CampaignMemberCriteriaManager.deleteCriteria('Address_Deliverable__c',campaignId,false);
            } 
            }
        }
     }
    // end of Added for Audience Selection Criteria story
    
    public Pagereference deleteAllGeoServiceArea()
    {
        return null;
    }
    
    public Pagereference deleteAllGeoBoundaryDistance()
    {
        return null;
    }
    
    /********** Edit Campaign **********/
    public PageReference EditCampaign()
    {
        setflag1=true;
        noNext=true;
        stepFlag=true;
        SaveFlag=true;
        nameFlag=true;
        system.debug('%%%%%%%%%%5 name flag' + nameFlag);
        
        lstCampaignMember = new List<CampaignMember>();
        SelectedSubServLines= new List<SelectOption>();
        SelectedHospitalList= new List<SelectOption>();
     //   Selectedtactic=new List<SelectOption>();
       system.debug('##### selectedValSSL list ###*****'+selectedValSSL); 
        system.debug('setfalg1 value in edit method==='+ setflag1);
       
        system.debug('####ownership type value in edit mode#######'+ objcampaign.CRM_OwnershipType__c);
        system.debug('@@@@selected ownership in edit mode@@@'+ objcampaign.CRM_SelectedOwnershipCriteria__c);
       
       
       // SelectedOwnershipValues(objcampaign.id);
      
        
        //system.debug('Sub Service Line********'+objcampaign.Sub_Service_Line__c);

        
         system.debug('hospital value********'+objcampaign.Audience_Hospital__c);
           if(objcampaign.Audience_Hospital__c != null)
      
        {
        system.debug('value of hospital in edit');
          List<String> lstHospital= objcampaign.Audience_Hospital__c.split(';');
            Set<String> sethospital = new Set<String>();
            for(string str : lstHospital)
            {
            system.debug('value of hospital in edit mode======'+ str);
                SelectedHospitalList.add(new SelectOption(str, str));
                sethospital.add(str);
                 for(integer i=0;i<HospitalList.Size();i++)
                {
                        system.debug('**AllSubServLines**='+HospitalList[i].getValue()+'******');
                        if(HospitalList[i].getValue() == str)
                            HospitalList.remove(i);
                    }
            }
            
            
           } 
        system.debug('#####refrenceDataMap edit='+refrenceDataMap);
        DetailPage = false;
           if (objcampaign.id!=null)
           ClonePlusController.BeforeCloneValidation(objcampaign.id);
     
        return null;
        
    }
    public PageReference DelCampaign()
    {
         if (objcampaign.id!=null ){
            //start of PP4 changes
            //This will undo all the changes to parent campaign
            Savepoint sp = Database.setSavepoint();
            try{
                
                AudienceReport_Helper.rollupFinalCountDetailToSegmented(new list<Id>{objcampaign.id},true,true);
                list <Campaign> deleteCampaignList=new list <Campaign>();
                list<CRM_AudienceUploadJunction__c> markAUToDeleteList = new list<CRM_AudienceUploadJunction__c>(); 
                for(Campaign cm :[select id,(select id from CRM_SegmentedParentCampaigns__r),(select id,CRM_ToDelete__c from CRM_AudienceUploadJunctions__r where CRM_ToDelete__c=false) from campaign where id =:objcampaign.id]){
                
                    deleteCampaignList.add(cm);
                    
                    for(campaign c : cm.CRM_SegmentedParentCampaigns__r){
                        deleteCampaignList.add(c);
                    }
                    
                    for(CRM_AudienceUploadJunction__c auj : cm.CRM_AudienceUploadJunctions__r){
                        auj.CRM_ToDelete__c=true;
                        markAUToDeleteList.add(auj);
                    }
                }
                
                if(markAUToDeleteList.size()>0)
                    update markAUToDeleteList;
                    
                if(deleteCampaignList.size()>0){
                  delete deleteCampaignList;
                }
            }catch(Exception ex){
                Database.rollback(sp);
                Tenet_Exception_Handler logError = new Tenet_Exception_Handler();
                logError.creatExceptionLog(ex,null,'CampaignWizardController:Delete:'+objcampaign.id);
            }
        }
        if(objcampaign.CRM_ParentSegmentedCampaign__c!=null){
            Pagereference pg = new Pagereference('/apex/campaignWizard?id='+objcampaign.CRM_ParentSegmentedCampaign__c);
            pg.setRedirect(true);
            return pg;
        }else{
            Pagereference pg = new Pagereference('/');
            pg.setRedirect(false);
            return new PageReference('/701/o');
            //end of PP4 changes
        }
    }
    
   public void SubServiceLine()
{
    SelectedSubServLines = new List<SelectOption>();
    AllSubServLines = new List<SelectOption>();
    cp.Service_Line__c=objcampaign.Service_Line__c;
    
    system.debug('objcampaign.Service_Line__c****'+cp.Service_Line__c);
    
    //system.debug('####objcampaign.Service_Line__c####'+objcampaign.Service_Line__c);
    //Map<String,List<String>> pickValueMap=DependentPickListValueController.GetDependentOptions('Campaign','Service_Line__c','Sub_Service_Line__c');
    
    Schema.DescribeFieldResult campaingDescribe;
    campaingDescribe = Schema.sObjectType.Campaign.fields.CRM_SubServiceLineText__c;
    Schema.sObjectField subServiceLine = campaingDescribe.getSObjectField();
    campaingDescribe = Schema.sObjectType.Campaign.fields.Service_Line__c;
    Schema.sObjectField serviceLine = campaingDescribe.getSObjectField();
    Map<String,List<String>> pickValueMap=DependentPickListValueController.GetDependentOptions(subServiceLine,serviceLine);
    
    system.debug('####objcampaign.Service_Line__c####'+objcampaign.Service_Line__c);
    if(objcampaign.Service_Line__c != null && objcampaign.Service_Line__c != '' )
    {
        system.debug('M in if');
        system.debug('****'+AllSubServLines);    
        for(string dependSubServ : pickValueMap.get(objcampaign.Service_Line__c))
        {
            AllSubServLines.add(new SelectOption(dependSubServ, dependSubServ)); 
        } 
        system.debug('****'+AllSubServLines);     
    }
    
    else
    {
        if(objcampaign.Service_Line__c=='')
        {
            system.debug('M in else for none value chk');
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select any other value for Service Line '));
        }
        system.debug('M in else');        
    }   
}
         
public void tactic()
{
     //Start : Design change for channel vendor screen
    
    Map<String ,Boolean> mapChannelRecordTypes=new Map<String ,Boolean>();  
    Map<String ,Boolean> mapChannelInbound=new Map<String ,Boolean>(); 
    id RecordTypeid = [SELECT id FROM RecordType WHERE SobjectType='CRM_CampaignWizardReferenceData__c' AND DeveloperName='ChannelValues'][0].id;
    
    for(CRM_CampaignWizardReferenceData__c objCRMChannelVal : [Select id, CRM_Channel__c,CRM_IsTargeted__c,CRM_IsCallToActionEnabled__c FROM CRM_CampaignWizardReferenceData__c WHERE Recordtypeid =:RecordTypeid])
    {
        mapChannelRecordTypes.put(objCRMChannelVal.id,objCRMChannelVal.CRM_IsTargeted__c);
        mapChannelInbound.put(objCRMChannelVal.id,objCRMChannelVal.CRM_IsCallToActionEnabled__c);
    }
    System.debug('******mapChannelRecordTypes'+mapChannelRecordTypes);
    System.debug('******mapChannelRecordTypes.get'+mapChannelRecordTypes.get(selectedChannel));
    
    
    
    if (mapChannelRecordTypes!=null && mapChannelRecordTypes.size()>0 )
    {  
        if(mapChannelRecordTypes.get(selectedChannel)!=null && mapChannelRecordTypes.get(selectedChannel)==true) 
        {
            targeted=true;
            flag1=false;
            TactFlag=true;
            proFlag=false;
           // isTargetedCampaign=true;
            memberflag=true;           
            system.debug('after if ' + TactFlag +'channel value'+ selectedChannel);
            system.debug('i am in if condition tactic method========= ' + proFlag );
        }
        //start of PP4 change
        else if(objcampaign.id==null  || (childCampaign.size()==0 && campId!=null && segmentedparentCampName==null)  )
        // end of PP4 change    
        {
            flag1=false;
            TactFlag=false;
            memberflag=false;
            proFlag=true;
            system.debug('i am in else condition tactic method========== ' + proFlag );  
          
            objcampaign.Member_Types__c='None';                      
            system.debug('in else if '+TactFlag + 'channel value'+ selectedChannel);
        }
    }
    if (mapChannelInbound!=null && mapChannelInbound.size()>0 )
    {  
    
        if(mapChannelInbound.get(selectedChannel)!=null && mapChannelInbound.get(selectedChannel)==true) 
        {
         IsChannelInbound= false;           
        }
        else 
        {
            selectedCallToAction=null;
            IsChannelInbound= true;   
        }
    }
    
    
        // End : Design change for channel vendor screen 
}     
public void TacticMember()
{
   /* Start :Design change for channel vendor screen*/
    Map<String ,Boolean> mapChannelRecordTypes=new Map<String ,Boolean>();
    
    id RecordTypeid = [SELECT id FROM RecordType WHERE SobjectType='CRM_CampaignWizardReferenceData__c' AND DeveloperName='ChannelValues'][0].id;
    
    for(CRM_CampaignWizardReferenceData__c objCRMChannelVal : [Select id , CRM_Channel__c,CRM_IsTargeted__c FROM CRM_CampaignWizardReferenceData__c WHERE Recordtypeid =:RecordTypeid])
    {
        mapChannelRecordTypes.put(objCRMChannelVal.id,objCRMChannelVal.CRM_IsTargeted__c);
    }
    
    if(objcampaign.id!=null)
    {
   
        if(selectedChannel!=null && selectedChannel!='' && mapChannelRecordTypes.get(selectedChannel)!=null && mapChannelRecordTypes.get(selectedChannel)==true) 
        {    
            TactFlag=true;  
            flag1=false;
        }
        else if(selectedChannel==null || selectedChannel == '')
        {
            TactFlag=true;  
            flag1=false;
        }
        else
        {
            TactFlag=false;  
            flag1=true;
        }
    }
   /* End :Design change for channel vendor screen */
    
}


    public PageReference BacktoCampaign()
    {        
        return new Pagereference('/apex/Step5_Campaign_wizard');
    }
    
 
    public PageReference AddLoc()
    {
      //  wrapperLocList = new List<WrapperClassForLocationCheckBox>();
        return new PageReference('/apex/CampaignCriteria_Geographies?id='+ objcampaign.id);
    }  
    
    Public PageReference AddIcd()
    {
        return new PageReference('/apex/AddICD?id='+campId);   
        
    }
    
    
    
      /*********** Naming Convention **********/
    public void CampNamingConvention()
    {       
        campname_value='100'; 
        integer i=1;
        integer campcount;
        integer EncCount;
        integer incrementedCount;
        campaign name1;
        //campname_value=campname_value+i;
        system.debug('@@@@@@@'+ campname_value);
        //i++;
        /******** For child & template ******/
        if(Childflag==true)
        {
            CampName=[Select Id,name,NameCounter__c,count_of_index__c,CreatedDate,Service_Line__c,CRM_SubServiceLineText__c,Sub_Service_Line__c,Channel__c,
            CRM_OwnershipType__c,CRM_SelectedOwnershipCriteria__c,Audience_Region__c,Audience_Hospital__c,Audience__c, Version__c from Campaign where id =:camp_childMember.Id];  
        }
        else if(TemplateFlag=='true')
        {
            CampName=[Select Id,name,NameCounter__c,count_of_index__c,CreatedDate,Service_Line__c,CRM_SubServiceLineText__c,Sub_Service_Line__c,Channel__c,
            CRM_OwnershipType__c,CRM_SelectedOwnershipCriteria__c,Audience_Region__c,Audience_Hospital__c,Audience__c, Version__c from Campaign where id =:camp_clone1.Id];  
             System.debug('^^^^^&&&&'+CampName); 
        }
        else
        {
             CampName=objcampaign;
        }        
        System.debug('^^^^^'+CampName); 
       if(CampName.CreatedDate==null)
            campname_creatDate=datetime.now();
        else
            campname_creatDate=CampName.CreatedDate;   
       // campname_creatDate=system.now();  
        System.debug('%%%%%%Camp Date'+campname_creatDate);
        campname_Date=date.newInstance(campname_creatDate.year(),campname_creatDate.month(),campname_creatDate.day());
        System.debug('%%%%%%campname_Date'+campname_Date); 
        string campname_creatDate1=String.valueOf(campname_Date);
        system.debug('@@@@@@@'+ campname_creatDate1);
        campname_creatDate1=campname_creatDate1.replace('-','');
        system.debug('@@@@@@@'+ campname_creatDate1);
        
        campcount=[Select count() from Campaign where CreatedDate =today];
        system.debug('&&&&&&& count '+campcount);
        system.debug('name flag check@@@'+ nameFlag);
        objcampaign.Audience_Region__c=null;
        objcampaign.Audience_Hospital__c=null;
        objcampaign.Audience__c=null;
        system.debug('&&&&#### Audience_Region__c '+objcampaign.Audience_Region__c);
        system.debug('&&&&&&& Audience_Hospital__c '+objcampaign.Audience_Hospital__c);
        system.debug('&&&&&&& Audience__c '+objcampaign.Audience__c);
        /*Campaign counter genrator :Counter will start from 101 for every day or if campaign count for a day is 999 else it will increment by one every time */
        if(nameFlag==false)
        {
                system.debug('### Name Flag ###'+ nameFlag);
                CampaignSequencer__c Cs= CampaignSequencer__c.getOrgDefaults();   
                String LastModiDate= DateTime.newInstance(Cs.LastModifiedDate.year(),Cs.LastModifiedDate.month(),Cs.LastModifiedDate.day()).format('M/d/YYYY');               
                if(LastModiDate!=Date.today().format() || Cs.Counter_Value__c==999)
                    Cs.Counter_Value__c= 101;                                         
                else
                    Cs.Counter_Value__c= Cs.Counter_Value__c+1;
                
                update Cs; 
                CampName.count_of_index__c=string.valueof(integer.valueof(Cs.Counter_Value__c));
                campname_value1 =string.valueof(integer.valueof(Cs.Counter_Value__c));                  
        }
       else if(nameFlag==true)/*if name is already preseent then same count will be updated in campaign name every time*/
       {
          name1=[select count_of_index__c from campaign where id=:campid limit 1];
          campname_value1=name1.count_of_index__c;      
        } 
        
       
        /**** for null values check ****/
       if(CampName.CRM_OwnershipType__c=='Hospital' && selectedCriteria==null)
        {
          CampName.Audience_Hospital__c=null;
          system.debug('*****' + selectedCriteria);
        }
       
        if(CampName.CRM_OwnershipType__c=='Region' && selectedCriteria==null)
        {
          CampName.Audience_Region__c=null;
          system.debug('*****'+CampName.Audience_Region__c);
        }
        
        if(CampName.CRM_OwnershipType__c=='Market' && selectedCriteria==null)
        {
          CampName.Audience__c=null;
          system.debug('*****');
        }
        
        if(CampName.Version__c=='' || CampName.Version__c==null)
        {
          CampName.Version__c=null;
          system.debug('*****');
        }
        
        

        /***** Multiple selection & Fetching the hospital code **********/      
        if(selectedCriteria.size()>1 )
        
        {
            system.debug('I am in if of naming convention');
            if(CampName.CRM_OwnershipType__c=='Hospital' )
            {
                system.debug('I am true hospital multi');
                CampName.Audience_Hospital__c='MH';
               
                system.debug('^^^^^^MH'+CampName.Audience_Hospital__c);
            }
          //  else
         //   {
           //     List<HospitalCode__c> lsthpcode= [select Name from HospitalCode__c where Hospital_Name__c=:CampName.Audience_Hospital__c];
         //  List<Location__c> lsthpcode= [select HSPCD__c from Location__c where Hospital__c =:CampName.Audience_Hospital__c];
             //   if(lsthpcode.size()>0)
             //   {
              //    hpCode= lsthpcode[0]; /***Code fetching****/
                                
                //  CampName.Audience_Hospital__c=hpCode.Name;   
             //   CampName.Audience_Hospital__c=String.valueOf(selectedownershipCodes) ;                  
              //    system.debug('^^^^^^hospital'+CampName.Audience_Hospital__c);
               // } 
                
              //  system.debug('^^^^^^hospital'+CampName.Audience_Hospital__c);                
          //  }                
            
            if(CampName.CRM_OwnershipType__c=='Region' )
            {
                system.debug('I am true region multi');
                CampName.Audience_Region__c='MR';
                
                system.debug('^^^^^^MR'+CampName.Audience_Region__c);
            }
           
            if(CampName.CRM_OwnershipType__c=='Market' )
            {
                system.debug('I am true market multi');
                CampName.Audience__c='MM';
                system.debug('^^^^^^MM'+CampName.Audience__c);
            }
                       
            if(campname_value1!=null && nameFlag==false)
            {
            campname_value1= campname_value1.right(3);
            system.debug('#####'+campname_value1); 
            }
            else if(campname_value1!=null && nameFlag==true)
            {
                campname_value1=name1.count_of_index__c;
                system.debug('##### count'+campname_value1);
            }
            
            /*** criteria ****/
            //region null & market null
             // Design change for channel vendor screen
          system.debug('CampName.Audience_Region__c'+ CampName.Audience_Region__c);
             system.debug('CampName.Audience_Hospital__c'+ CampName.Audience_Hospital__c);
            if(campname_value1!=null && CampName.Audience_Region__c==null &&  CampName.Audience__c==null && CampName.Audience_Hospital__c!='' && CampName.Service_Line__c!=null && CampName.Channel__c!=null && CampName.Channel__c!='')
            {
                
                camp_name=campname_creatDate1+'-'+campname_value1+'-'+CampName.Audience_Hospital__c+'-'+CampName.Service_Line__c+'-'+CampName.Channel__c+(CampName.Version__c!=null?'-V'+CampName.Version__c : '');  
                system.debug('@@@@ region null & market null'+camp_name);
            }   
            //hospital null & region null  
            else if(campname_value1!=null && CampName.Audience_Region__c==null  && CampName.Audience__c!='' && CampName.Audience_Hospital__c==null && CampName.Service_Line__c!=null && CampName.Channel__c!=null && CampName.Channel__c!='')
            {
              camp_name=campname_creatDate1+'-'+campname_value1+'-'+CampName.Audience__c+'-'+CampName.Service_Line__c+'-'+CampName.Channel__c+(CampName.Version__c!=null?'-V'+CampName.Version__c : '');  
              system.debug('@@@@@ hospital null & version null'+camp_name);
            }
            //hospital null & market null  
            else if(campname_value1!=null && CampName.Audience_Region__c!='' &&  CampName.Audience__c!='' && CampName.Audience_Hospital__c==null && CampName.Service_Line__c!=null && CampName.Channel__c!=null && CampName.Channel__c!='')
            {
              camp_name=campname_creatDate1+'-'+campname_value1+'-'+CampName.Audience_Region__c+'-'+CampName.Service_Line__c+'-'+CampName.Channel__c+(CampName.Version__c!=null?'-V'+CampName.Version__c : '');  
              system.debug('@@@@@ hospital null & version null'+camp_name);
            }
            //no value null
             // end of Design change for channel vendor screen
            else
            {
            if(CampName.Audience__c!=null && CampName.Audience_Region__c!=null && CampName.Audience_Hospital__c!=null){
              camp_name=campname_creatDate1+'-'+campname_value1+'-'+ CampName.Audience_Region__c +'-'+CampName.Audience__c+'-'+CampName.Audience_Hospital__c+'-'+CampName.Service_Line__c+'-'+CampName.Channel__c+(CampName.Version__c!=null?'-V'+CampName.Version__c : '');  
              system.debug('@@@@@ no value null'+camp_name);
              }
            }  

        }
        else 
        {
             //start of PP4 change
            if(segmentedparentCampName==null){
                 //end of PP4 change
            system.debug('I am in else of naming convention');
             List<CRM_CampaignLocationReferenceData__c> lstregionname = [select CRM_Region__c, CRM_Market__c, CRM_HospitalCode__c from CRM_CampaignLocationReferenceData__c where (CRM_RegionCode__c IN: selectedownershipCodes OR CRM_MarketCode__C IN: selectedownershipCodes OR CRM_HospitalCode__c IN: selectedownershipCodes)AND recordTypeId=:ReferenceData_PicklistController.recordTypeId('CRM_CampaignLocationReferenceData__c' , objcampaign.CRM_OwnershipType__c) ]; 
            
                //  List<Location__c> lsthpcode = [select HSPCD__c from Location__c where Hospital__c=:CampName.Audience_Hospital__c];
            if(CampName.CRM_OwnershipType__c=='Hospital' && selectedCriteria.size()==1)
            {
           // hpCode= lsthpcode[0]; /***Code fetching****/
          //  system.debug('%%%%%Hospital Code'+hpCode); 
          system.debug('@@@selectedownership size'+ selectedownershipCodes );
               CRM_CampaignLocationReferenceData__c hospitalname = lstregionname[0];
               system.debug('@@@regionannme'+ hospitalname );
                String hospitalname1= String.valueOf(hospitalname.CRM_HospitalCode__c); 
            CampName.Audience_Hospital__c=hospitalname1;
            system.debug('@@@CampName.Audience_Hospital__c'+ CampName.Audience_Hospital__c );
            CampName.Audience_Region__c=null;
            CampName.Audience__c=null;
            }
          
            if(CampName.CRM_OwnershipType__c=='Region' && selectedCriteria.size()==1)
            {
          
            CRM_CampaignLocationReferenceData__c regioname = lstregionname[0];
                system.debug('@@@regionannme'+ regioname );
                String regionname= String.valueOf(regioname.CRM_Region__c);
                system.debug('@@@regionname'+ regioname );
               
                if(regionname.contains('-')){
                    system.debug('inside if for region -');
                    String regionnanme = regionname.replace(' Region' , '');
                    CampName.Audience_Region__c=regionnanme ;
                }
                else if(regionname.contains('Region')){
                CampName.Audience_Region__c=(regionname.substring(0, regionname.indexOf('Region'))).trim();
                }
                else if(regionname.contains('region')){
                CampName.Audience_Region__c=(regionname.substring(0, regionname.indexOf('region'))).trim();
                }
                else if(regionname.contains('Market')){
                 CampName.Audience_Region__c=(regionname.substring(0, regionname.indexOf('Market'))).trim();    
                }
                else{
                CampName.Audience_Region__c=regionname.trim();
                }
                system.debug('@@@CampName.Audience_Region__c'+ CampName.Audience_Region__c );
                CampName.Audience__c=null;
                CampName.Audience_Hospital__c=null;
            }
            
            if(CampName.CRM_OwnershipType__c=='Market' && selectedCriteria.size()==1)
            {
          CRM_CampaignLocationReferenceData__c marketname = lstregionname[0];
                system.debug('@@@regionannme'+ marketname );
                String marketname_1= String.valueOf(marketname.CRM_Market__c);
                system.debug('@@@marketname'+ marketname_1 );
           if(marketname_1.contains('Market')){
            CampName.Audience__c=(marketname_1.substring(0, marketname_1.indexOf('Market'))).trim();
            }
            else if(marketname_1.contains('market')){
                CampName.Audience__c=(marketname_1.substring(0, marketname_1.indexOf('market'))).trim();
                }
               else if(marketname_1.contains('Region')){
                CampName.Audience__c=(marketname_1.substring(0, marketname_1.indexOf('Region'))).trim();
                }
                else{
                CampName.Audience__c=marketname_1.trim();
                }
                CampName.Audience_Hospital__c=null;
                CampName.Audience_Region__c=null;
                
            }
               
            }
            //campname_value1= campname_value1.right(3);
            //system.debug('#####'+campname_value1);
             system.debug('value of nameflag in else of convention before if conditon======='+ nameFlag);
           system.debug('value of campname_value1 in else of convention before if conditon======='+ campname_value1);  
            if(campname_value1!=null && nameFlag==false)
            {
            campname_value1= campname_value1.right(3);
            system.debug('#####'+campname_value1); 
            }
            else if(campname_value1!=null && nameFlag==true)
            {
                campname_value1=name1.count_of_index__c;
                system.debug('##### count'+campname_value1);
            }
            
           
            
            /*** criteria ****/
            //region null & market null
             // Design change for channel vendor screen
            if(segmentedparentCampName==null){
            if(campname_value1!=null && CampName.Audience_Region__c==null &&  CampName.Audience__c==null && CampName.Audience_Hospital__c!='' && CampName.Service_Line__c!=null && CampName.Channel__c!=null && CampName.Channel__c!='')
            {
                camp_name=campname_creatDate1+'-'+campname_value1+'-'+CampName.Audience_Hospital__c+'-'+CampName.Service_Line__c+'-'+CampName.Channel__c+(CampName.Version__c!=null?'-V'+CampName.Version__c : '');  
                system.debug('@@@@ region null & market null'+camp_name);
            }   
            //hospital null & region null  
            else if(campname_value1!=null && CampName.Audience_Region__c==null  && CampName.Audience__c!='' && CampName.Audience_Hospital__c==null && CampName.Service_Line__c!=null && CampName.Channel__c!=null && CampName.Channel__c!='')
            {
              camp_name=campname_creatDate1+'-'+campname_value1+'-'+CampName.Audience__c+'-'+CampName.Service_Line__c+'-'+CampName.Channel__c+(CampName.Version__c!=null?'-V'+CampName.Version__c : '');  
              system.debug('@@@@@ hospital null & version null'+camp_name);
            }
            //hospital null & market null  
            else if(campname_value1!=null && CampName.Audience_Region__c!='' &&  CampName.Audience__c==null && CampName.Audience_Hospital__c==null && CampName.Service_Line__c!=null && CampName.Channel__c!=null && CampName.Channel__c!='')
            {
              camp_name=campname_creatDate1+'-'+campname_value1+'-'+CampName.Audience_Region__c+'-'+CampName.Service_Line__c+'-'+CampName.Channel__c+(CampName.Version__c!=null?'-V'+CampName.Version__c : '');  
              system.debug('@@@@@ hospital null & version null'+camp_name);
            }
            //no value null
              // end of Design change for channel vendor screen
       /*   else
            {
             system.debug('value of region in else'+ CampName.Audience_Region__c );
             system.debug('value of market in else'+ CampName.Audience__c);
              system.debug('value of hospital in else'+ CampName.Audience_Hospital__c );
              system.debug('value of counter in else'+ campname_value1 );
               system.debug('value of name flag in else'+ nameflag );
              camp_name=campname_creatDate1+'-'+campname_value1+'-'+ CampName.Audience_Region__c +'-'+CampName.Audience__c+'-'+CampName.Audience_Hospital__c+'-'+CampName.Service_Line__c+'-'+CampName.Channel__c+'-V'+CampName.Version__c;  
              system.debug('@@@@@ no value null'+camp_name);
            }  
            */
            
  
            
            system.debug('&^^^^^'+camp_name);      
        } //end of PP4 change
            //start of PP4 change
            else if(segmentedparentCampName!=null){
                camp_name='SEG'+campname_creatDate1+'-'+campname_value1; 
            }
            //end of PP4 change
        }
        System.debug('%%%%%% name concatination'+camp_name); 
        if(camp_name.length()>80 ){
         
        ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Info,Label.Campiagn_Name_Convention);
            Apexpages.addMessage(msg); 
        
            objcampaign.Name= camp_name;
        }
        
        else {
         objcampaign.Name=camp_name; 
        }
    }
    
  /********** Add Child Campaign Member *********/
    public PageReference addChildCamp()
    {   
        PageReference pgr;
        campflag='false';
        tactflag=true;
        // Start Inactive Validation change 
        IsAddChildCheck=true;
       // detailPage = false;
       // stepNo=1;
        
        //String primaryObjectQueryString = 'SELECT Id, Name FROM Campaign WHERE Id = \''+ objcampaign.id+ '\'';                        
        //headSObject = Database.query(primaryObjectQueryString);
        //Start : Channel Vendor and service line/sub service line change 
        if(BeforeCloneValidation(objcampaign.id))
        {  
            //headClone=ClonePlusController.cloneObjects(new List<sObject>{headSObject}).get(0);
            ClonePlusController clonep = new ClonePlusController();
            string campaignQuery = clonep.queryString('Campaign',null);
            campaignQuery += ' where id=\''+objcampaign.id+'\'';
            for(SObject camp:Database.query(campaignQuery)){
                headClone = camp.clone(false,true);
            }
            
            headClone.put('Name', 'New Campaign');
           
            parentCampName = objCampaign.Name;
            
            headClone.put('Call_Center_Identifier__c',null);
            headClone.put('Call_Center_Unique_Identifier__c',null); 
            headClone.put('Campaign_Toll_Free_Number__c',null);
            headClone.put('Status','In Development');
            headClone.put('IsActive',false);
            headClone.put('Approved__c',false); 
            headClone.put('Member_types__c','Any or no encounters - Everyone'); 
            headClone.put('Channel__c', null);
            headClone.put('Vendor_Name__c', null); 
            headClone.put('Other__c', null);
            headClone.put('Program_Name__c',null); 
            headClone.put('Save_Campaign_as_Template__c',false);
            headclone.put('Actual_Spend__c', null);
            headClone.put('Campaign_Budget__c' , null);
            headClone.put('Expected_Contribution_Margin__c', null);
            headClone.put('Purchase_Invoice_Order__c', null);
            headClone.put('Place_Order_Date_Time__c',null); 
            headClone.put('Add_Member_Status__c',null);
            headClone.put('List_Order_Id__c',null);
            headClone.put('LIST_ORDER_SELECT_GRP_ID__c',null);
            headClone.put('Current_count__c',null);
            headClone.put('Approved_By__c',null);
            headClone.put('Approval_Comments__c',null);
            headClone.put('MARS_Approval__c',null);
            headClone.put('Ownerid', UserInfo.getUserId());
            headClone.put('CG_Count__c',null);
            headClone.put('Supp_Count__c',null);
            headClone.put('Missing_Contact_Count__c',null);
        
            // Start :Audience Selection criteria stories changes(BirthMonth)
            headClone.put('CRM_Refreshed_Count_Date__c',null);
            //End :Audience Selection criteria stories changes(BirthMonth)
            
            objcampaign=(Campaign)headClone;
            Campaign=(Campaign)headClone;
            detailPage = false;
            stepNo=1;
            pgr=new PageReference('/apex/campaignWizard');    
            System.debug('InsideAdd child campaign if ');
            system.debug('add child channel value==='+ selectedChannel);
                
            return pgr;
       }
       else
       {
           
            return null;
       }
     
        // End :Inactive Validation change
        //Start : Channel Vendor and service line/sub service line change 
    }
     //Start Inactive Validation Change 
     public static Boolean BeforeCloneValidation(id campid)
     {
        string errorMessage=ClonePlusController.inactiveOptionAlertMessage(new set<id>{campid},true);
        if(!string.isBlank(errorMessage))
        {
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING,System.Label.CRM_CloneValidationMessage+'<br/>'+errorMessage));
          return false;
        }
        else
        {
          System.debug('>>>>>>Validation Successful<<<<<<');
          return true;
        }
    }
    
    //End: Inactive Validation Change 
      
    
  /** public pageReference addDRG()
    {
        wrapperDrgList = new List<WrapperClassForDRGCheckBox>();
        EditCampaign();
        return new PageReference('/apex/addDRGCodes?id='+ objcampaign.id);
    }   **/
    
  /**  public pageReference RemoveDRG()
    {
        List<WrapperClassForDRGCheckBox> removeDRGrec = DetailwrapDRGRelatedlist ;
        Set<Id> DRGIds = new Set<Id>();
        
        for(integer i = 0;i<removeDRGrec.size();i++)
        {
            if(removeDRGrec[i].flag == true)
            {
                
                system.debug('removeDRGrec[i].WrapperdrgCo.Id****'+removeDRGrec[i].WrapperdrgCo.Id);
                DRGIds.add(removeDRGrec[i].WrapperdrgCo.Id);
                removeDRGrec.remove(i);
            }
        }
        if(campId != null)
        {
            List<DRG_Code_Information__c> DeleteDRGInfo = new List<DRG_Code_Information__c>();
            for(DRG_Code_Information__c drginfo : [Select id, Campaign__c, DRG_Code__c from DRG_Code_Information__c where Campaign__c =: campid and DRG_Code__c IN : DRGIds]){
                DeleteDRGInfo.add(drginfo);
            }
            if(!DeleteDRGInfo.IsEmpty())
                delete DeleteDRGInfo;
        }
        
        DetailwrapDRGRelatedlist = removeDRGrec;
        
        
        return new PageReference('/apex/CampaignWizard');
        
    }    **/
 /**   public PageReference CancelDRG()
    {
        return new PageReference('/apex/CampaignWizard');
    }   **/
    
    public PageReference CancelEditCampaign()
    {
        pagereference ref;
        if(campid!=null){
        
        ref=new pagereference('/apex/campaignWizard?Id='+campid + '&stepNo='+stepNo);
        ref.setredirect(true);  
      //  return ref;
        }
        if(campid==null){
        // pagereference ref;
        ref=new pagereference('/701/o');
        ref.setredirect(true);  
       
        }
         return ref;
    }
    
     public void method1()
     {
        system.debug('i am in method 1 ');
        system.debug('value of approved====' + objcampaign.Approved__c);
        disflagcontrl = false;
        if(objcampaign.Approved__c==true)
        {
            disflag2=false;
            activatecampaignflag=true;
            system.debug('i am in method 1 condition false========' + disflag2);
        }
        else
        {
            disflag2= true;
            activatecampaignflag=false;
            system.debug('i am in method 1 condition true========' + disflag2);
        }
    }
    

    
    public void DeleteChild()
    {
        /*String camp_child_id= ApexPages.currentPage().getParameters().get('camp_child_id'); 
system.debug('related list ======'+ camp_child_id);
Campaign campch = [Select parentId,name,status,Program_Name__c,Description from campaign where parentId=:campId ];
if(campch !=null && campch.id !=null){
delete campch;
}  */
        
        if (SelectedchildId == null) 
        {
            system.debug('selected chilfdid ===' + SelectedchildId);
            return ;
        }
        campaign tobeDeleted = null;
        //  Campaign campch = [Select parentId,name,status,Program_Name__c,Description from campaign where parentId=:campId ];
        for(Campaign a : lstCamp_memb)
            
        if (a.Id == SelectedchildId) 
        {
            tobeDeleted = a;
            break;
        }
        if (tobeDeleted != null) 
        {
            Delete tobeDeleted;
            system.debug('in the last');
            ViewChildCampaign();   
        } 
        
        //return new PageReference('/apex/CampaignWizard?Id='+objcampaign.Id +'&stepNo=2');
    }
    
    public pagereference encounter()
    {
        //getSession();
        
        btn=1;
        //    button = Integer.valueOf(ApexPages.CurrentPage().getParameters().get('btn'));
        system.debug('inside encounter method=====');
        pagereference ref;
        //Encounterid=[select id,(select id from Encounters__r) from campaign where id =:objcampaign.Id ];
        //Encounterid=[ select id,(select id from Encounters__r) from campaign where id =:objcampaign.Id];
         EncCount=[Select count() from encounter__c where Campaign__c=:objcampaign.Id ];
         system.debug('Value of EncCount'+EncCount);
        
        if (EncCount>0)
        {
        eid=[select id from encounter__c where Campaign__c=:objcampaign.Id limit 1];
        system.debug('inside encounter Encounterid=====');
        ref= new PageReference('/apex/EncountersPage?Id='+objcampaign.Id +'&btn='+btn +'&encounter='+eid.Id);
        ref.setredirect(true); 
        }
        else 
        {            
        system.debug('inside encounter else Encounterid=====');
        ref= new PageReference('/apex/EncountersPage?Id='+objcampaign.Id +'&btn='+btn);
        ref.setredirect(true);            
        }   
        system.debug('ref value\\\\\\\\\\\\\\'+ ref);
        return ref;
    }
    
    
    public pagereference encounter_aggregates()
    {
        //getSession();
        
        btn=8;
        //    button = Integer.valueOf(ApexPages.CurrentPage().getParameters().get('btn'));
        system.debug('inside encounter aggregates method=====');
        pagereference ref;
        //Encounterid=[select id,(select id from Encounters__r) from campaign where id =:objcampaign.Id ];
        //Encounterid=[ select id,(select id from Encounters__r) from campaign where id =:objcampaign.Id];
         EncAggCount=[Select count() from Encounter_aggregates__c where Campaign__c=:objcampaign.Id ];
         system.debug('Value of EncCount'+EncAggCount);
        
        if (EncAggCount>0)
        {
        eaid=[select id from Encounter_aggregates__c where Campaign__c=:objcampaign.Id limit 1];
        system.debug('inside encounter aggregate Encounterid=====');
        ref= new PageReference('/apex/EncountersPage?Id='+objcampaign.Id +'&btn='+btn +'&encounteraggregates='+eaid.Id);
        ref.setredirect(true); 
        }
        else 
        {            
        system.debug('inside encounteraggregate else Encounterid=====');
        ref= new PageReference('/apex/EncountersPage?Id='+objcampaign.Id +'&btn='+btn);
        ref.setredirect(true);            
        }   
        system.debug('ref value\\\\\\\\\\\\\\'+ ref);
        return ref;
    }
    
    
    
    public pagereference LifeStyle()
    { 
        
        btn=2;
        system.debug('inside LifeStyle method=====');
        pagereference ref;
        LifeCount=[Select count() from Life_Style__c where Campaign__c=:objcampaign.Id ];
         system.debug('Value of EncCount'+LifeCount);
       if (LifeCount>0)
        {
        lifesid=[select id from Life_Style__c where Campaign__c=:objcampaign.Id limit 1];
        system.debug('inside encounter lifesid=====');
        ref= new PageReference('/apex/EncountersPage?Id='+objcampaign.Id +'&btn='+btn +'&lifestyle='+lifesid.Id);
        ref.setredirect(true); 
        }
        else 
        {            
        system.debug('inside encounter else lifesid=====');
        ref= new PageReference('/apex/EncountersPage?Id='+objcampaign.Id +'&btn='+btn);
        ref.setredirect(true);            
        }  
        system.debug('ref value'+ ref);
        return ref;
    }
    
    /*******Demographic button ****/
    public pagereference demo()    
    {
        //getSession();
        //integer demoCount;
        btn=3;
        //    button = Integer.valueOf(ApexPages.CurrentPage().getParameters().get('btn'));
        system.debug('inside demo method=====');
        pagereference ref;
        demoCount=[Select count() from Campaign_Demographics__c where Campaign__c=:objcampaign.Id ];
        system.debug('Value of EncCount'+demoCount);
        
        if (demoCount>0)
        {
        demoid=[select id from Campaign_Demographics__c where Campaign__c=:objcampaign.Id limit 1];
        system.debug('inside demo demoCount>0=====');
        ref= new PageReference('/apex/EncountersPage?Id='+objcampaign.Id +'&btn='+btn +'&demo='+demoid.Id);
        ref.setredirect(true); 
        }
        else 
        {            
        system.debug('inside demo else demoCount<0=====');
        ref= new PageReference('/apex/EncountersPage?Id='+objcampaign.Id +'&btn='+btn);
        ref.setredirect(true);            
        }   
        system.debug('ref value\\\\\\\\\\\\\\'+ ref);
        return ref;
    }
    
    
    public pagereference enc_back()
    {
        pagereference ref;
        if(campId!=null)
        {
            ref = new Pagereference('/apex/CampaignWizard?Id='+campId +'&stepNo=3');
            ref.setredirect(true);             
        }
        return ref;
    }
    
    /* Home address button change */
    public PageReference AddHomeAddress()
    {
        return new PageReference('/apex/HomeAddress?id='+ objcampaign.id);
    }  
 /*End of Home address button change */ 
    
    public pagereference model()
    {
        
        btn=5;
        //    button = Integer.valueOf(ApexPages.CurrentPage().getParameters().get('btn'));
        system.debug('inside Modelid method=====');
        pagereference ref;
        //Encounterid=[select id,(select id from Encounters__r) from campaign where id =:objcampaign.Id ];
        //Encounterid=[ select id,(select id from Encounters__r) from campaign where id =:objcampaign.Id];
        modelCount=[Select count() from Model__c where Campaign__c=:objcampaign.Id ];
         system.debug('Value of hraCount'+modelCount);
        
        if (modelCount>0)
        {
        Modelid=[select id from Model__c where Campaign__c=:objcampaign.Id limit 1];
        system.debug('inside Model =====');
        ref= new PageReference('/apex/EncountersPage?Id='+objcampaign.Id +'&btn='+btn +'&Modelid='+Modelid.Id);
        //ref.setredirect(true); 
        }
        else 
        {            
        system.debug('inside Model else =====');
        ref= new PageReference('/apex/EncountersPage?Id='+objcampaign.Id +'&btn='+btn);
       // ref.setredirect(true);            
        }   
        system.debug('ref value\\\\\\\\\\\\\\'+ ref);
        return ref;
    
    }
    
    
    public void values()
    {
        if(objcampaign.Channel__c != 'Consumer Engagement Asset' || objcampaign.Channel__c != 'DirectMail' || objcampaign.Channel__c != 'Email')
        {
            objcampaign.Member_Types__c= 'None';
        }
    }
    
    //Changes for PP1 Start
    public Pagereference refreshCount()
    {
        Pagereference ref;
        try 
        {
            Campaign cmp = [select id,Member_Types__c,CRM_AudienceUploadCount__c, CRM_ParentSegmentedCampaign__c from Campaign where id=:campId];
            
            if (isExternalUpload(cmp.Member_Types__c))
            {
                if (cmp.CRM_AudienceUploadCount__c != -2)
                {
                    cmp.Current_count__c = cmp.CRM_AudienceUploadCount__c;
                    update cmp;
                }
                if (cmp.CRM_ParentSegmentedCampaign__c == null)
                    ref = new PageReference('/apex/CampaignWizard?Id='+campId+'&stepNo=3');
                else
                    ref = new PageReference('/apex/CampaignWizard?Id='+campId+'&stepNo=2');
                ref.setRedirect(true);
                return ref;
            }
            
            
            /*Campaign cmp = [select id,Member_Types__c,CRM_UploadAudienceCount__c from Campaign where id=:campId];
            if(!string.valueOf(cmp.Member_types__c).equalsIgnoreCase('Upload List') ){*/
                //Starting of defect#798:Net counts did not complete being calculated. SFDC suspected timeout after 2 minutes and did a manual process to restart the job. 
                if(Tenet_Static_Variables.checkActiveJob(Tenet_Static_Variables.WUNDERMAN_SESSION_SCHEDULER))
                {
                    if(!string.valueOf(cmp.Member_types__c).equalsIgnoreCase('Campaign Segments'))
                    {
                        CampaignMemberCriteriaManager.syncCampaignMemberCriterias(campId,false);//Ending of PP5 changes
                    }
                    //else
                        //AudienceReport_Helper.rollupFinalCountDetailToSegmented(new list<Id>{cmp.id},false,true);   //PP4 chnages
                   system.debug('inside if for not campaign segments');
                   // start of PP4 change
                   if(objcampaign.CRM_ParentSegmentedCampaign__c!=null){
                       ref = new Pagereference('/apex/CampaignWizard?Id='+campId+'&stepNo=2');
                   }else{
                        ref = new Pagereference('/apex/CampaignWizard?Id='+campId+'&stepNo=3');
                   }
                   // end of PP4 change
                    ref.setredirect(true); 
                }else{
                    throw new ApplicationException('Automated Process is not running. Please contact CRM support');
                }
            /*}else{
                
                cmp.Current_count__c = cmp.CRM_UploadAudienceCount__c;
                update cmp;
               // ref = new Pagereference('/apex/CampaignWizard?Id='+campId+'&stepNo=3');
               ref = new Pagereference('/apex/CampaignWizard?Id='+campId+'&stepNo='+stepNo);
                ref.setredirect(true);
            }
             if(string.valueOf(cmp.Member_types__c).equalsIgnoreCase('Upload List')){
                cmp.Current_count__c = cmp.CRM_AudienceUploadCount__c;
                update cmp;
              
               ref = new Pagereference('/apex/CampaignWizard?Id='+campId+'&stepNo='+stepNo);
                ref.setredirect(true);
            }*/
            if (cmp.CRM_ParentSegmentedCampaign__c != null) return ref;
            AudienceReport_Helper.rollupFinalCountDetailToSegmented(new list<Id>{cmp.id},false,true);   //PP4 chnages
        } 
        
         //Start of PP5 changes
        catch(Exception ex)
        {
            if(ex.getMessage().startsWith('Automated Process is not running'))
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,+System.label.CRM_QuickCountErrorMessage+' '+System.label.CRM_AutomatedProcessIsNotRunning));   
            else if(ex.getMessage().startsWith('Unable to do the refresh count from Wunderman.'))
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,+System.label.CRM_UnableToDoRefreshCountFromWunderman));
            else
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,+System.label.CRM_QuickCountErrorMessage+' '+ ex.getMessage() + '.Please try again.'));    
         }
         //Ending of PP5 changes  
         //Ending of defect#798                  
        return ref;         
    }
    //Changes for PP1 Ends
    public void membervalues()
    {
    IsParentCampaign = false; //AXU added 10-20-2017  //PP4 chnage
       system.debug('i am in membervalues method 1 ');
    system.debug('value of member==type==' + objcampaign.Member_Types__c);
    Map<String ,Boolean> mapMemberTypeVal=new Map<String ,Boolean>();
   // Map<String ,Boolean> mapExternalUploadVal=new Map<String ,Boolean>();
    Map<String, Boolean> mapParentVal = new Map<String, Boolean>(); //PP4 chnage
    
    for(CRM_MemberTypeReferenceData__c objCRMMemberTypeVal : [Select id ,name,CRM_Is_EncounterEnabled__c,CRM_IsParentCampaign__c  FROM CRM_MemberTypeReferenceData__c WHERE CRM_IsActive__c=true ]){
        mapMemberTypeVal.put(objCRMMemberTypeVal.name,objCRMMemberTypeVal.CRM_Is_EncounterEnabled__c);
      //  mapExternalUploadVal.put(objCRMMemberTypeVal.name, objCRMMemberTypeVal.CRM_IsExternalUpload__c);
        mapParentVal.put(objCRMMemberTypeVal.Name, objCRMMemberTypeVal.CRM_IsParentCampaign__c); //PP4 chnage
    }
    system.debug('#### mapMemberTypeVal####' + mapMemberTypeVal);
    if (mapMemberTypeVal!=null && mapMemberTypeVal.size()>0 )
    {  
        if(mapMemberTypeVal.get(Objcampaign.Member_Types__c)!=null && mapMemberTypeVal.get(Objcampaign.Member_Types__c)==false ) 
        {
            disflag3=true;
            system.debug('i am in method 1 condition false========' + disflag3);
        }
        else
        {
            disflag3= false;
            system.debug('i am in method 1 condition true========' + disflag3);
        }
    }
    
    //Changes for PP1 Start
    /*if (mapExternalUploadVal!=null && mapExternalUploadVal.size()>0 )
    {  
        if(mapExternalUploadVal.get(Objcampaign.Member_Types__c)!=null && mapExternalUploadVal.get(Objcampaign.Member_Types__c)==false ) 
        {
            externaluploadflag=false;
            system.debug('i am in external upload condition false========' + externaluploadflag);
        }
        else
        {
            externaluploadflag= true;
            system.debug('i am in external condition true========' + externaluploadflag);
        }
    }*/ 
    //Changes for PP1 End  
    //start of PP4 change
    if (mapParentVal != null && mapParentVal.size() > 0)
    {
        if (mapParentVal.get(ObjCampaign.Member_Types__c) != null && mapParentVal.get(ObjCampaign.Member_Types__c) == true)
        {
            IsParentCampaign = true;
            system.debug('segmentedchildflag value---'+segmentedchildflag );
            
        }
        //end of PP4 change
        
    }
    System.debug('Is Parent Campaign: ' + IsParentCampaign);
    }
    
    
   public pagereference getWundermanidRefresh()
    {    pagereference ref;
      
        ref = new Pagereference('/apex/CampaignWizard?Id='+objcampaign.id+'&stepNo=5');
        ref.setredirect(true); 
         return ref;
    }
    
    //********************* Method to Active Campaign After adding Campaign Member *******
    public Pagereference activatecampaign()
    {      
        if(!objcampaign.Approved__c)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Only approved campaigns can be activated'));
            return null;
        }
        else if(objcampaign.Approved__c== true && objcampaign.Approved_By__c=='' )
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Please enter the Approved By name'));
            return null;
        }
        else if ((objcampaign.Current_Count__c == 0 || objcampaign.Net_Count__c == 0) && objcampaign.RecordType.Name == 'Targeted')
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Cannot activate a zero count campaign'));
            return null;
        }
        else if((objcampaign.Control_Group_Size__c==null && objcampaign.Control_Group_Percentage__c==null && tactflag==true) || (objcampaign.Control_Group_Size__c!=null && objcampaign.Control_Group_Percentage__c!=null && tactflag==true)){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Please select only Control Group Size or Control Group Percentage'));
            return null;
        }
        //start of PP4 chnage
        else if(objcampaign.CRM_ParentSegmentedCampaign__c==null && childCampaign.size()>0){
            
            if(objcampaign.Add_Member_Status__c!='Calculated Net Count')
                activateparentflag=false;
            else
                activateparentflag=true;
            
            if(objcampaign.CRM_ParentSegmentedCampaign__c==null && stepNo==5 && !activateparentflag){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, Label.CRM_SegmentchildNet_count_Label));
                return null;
            }else if(objcampaign.Current_Count__c>150000 ){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING,System.Label.CRM_SegmentFinalCountMessage));
                return null;
            }
        }
        else if(objcampaign.Member_Types__c=='Campaign Segments' && childCampaign.isEmpty() && stepNo==5){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CRM_SegmentCampaignActivationMessage));
            return null;
        }/*else if(Integer.valueof(objcampaign.Net_Count__c)==0){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CRM_FinalCountWarningMessage));
            return null;
        }*/
        //end of PP4 chnage
        Pagereference ref;
        try{
            addCampaignMember();
            displayPopUp=true;
            activatecampaignflag=true;
          
            ref = new Pagereference('/apex/CampaignWizard?Id='+objcampaign.id+'&stepNo='+stepNo);
            ref.setredirect(true);                 
        
        }catch(Exception ex){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'We can not activate campaign at this time : '+ ex.getMessage()));    
        }
        return ref;        
    }
    
    //THis method will add campaing members
    //Changes for PP1 Start
    @TestVisible
    private void addCampaignMember()
    {
        Campaign campaignObj=[select id ,Control_Group_Member__c,Member_Types__c,Status,Current_count__c,LIST_ORDER_SELECT_GRP_ID__c,List_Order_Id__c ,Place_Order_Date_Time__c from campaign where id=:campId];
        //start batch or schedule batch
        
        if(isTargetedCampaign){
          /*  if(!string.valueOf(campaignObj.Member_types__c).equalsIgnoreCase('Upload List')){ */
        List<Transaction__c> transList = new List<Transaction__c>();
        if (isExternalUpload(campaignObj.Member_Types__c))
        {
            transList = [SELECT Id FROM Transaction__c WHERE Transaction_Source__c = 'Audience Upload' AND Campaign__c =: campaignObj.Id];
        }
        else
        {
            transList = [SELECT Id FROM Transaction__c WHERE Campaign_Member_Status__c='Ready to Process' AND WM_List_Order_Id__c=:campaignObj.List_Order_Id__c AND Campaign__c=:campaignObj.id];
        }
        
          
          
                //list<Transaction__c> transList= [select id from Transaction__c where Campaign_Member_Status__c='Ready to Process' AND WM_List_Order_Id__c=:campaignObj.List_Order_Id__c AND Campaign__c=:campaignObj.id];
                if(transList.size()==0 && !string.valueOf(campaignObj.Member_types__c).equalsIgnoreCase('Campaign Segments')){ //PP4 chnage
                    campaignObj.status='Active';
                    campaignObj.IsActive=true;
                    campaignObj.Add_Member_Status__c='Added Members';
                
                }else{
                    if([SELECT count() FROM AsyncApexJob WHERE Status = 'Holding' AND JobType = 'BatchApex']<100 )
                    {
                        if(string.valueOf(campaignObj.Member_types__c).equalsIgnoreCase('Campaign Segments')) //PP4 chnage
                            campaignObj.CRM_ActivateProcessId__c=Database.executeBatch(new CampaignProcess_AddMember(campId, true),1);   // Added for defect CRM-72 795 , only 5 campaigns can be activated
                        else if (isExternalUpload(campaignObj.Member_Types__c))
                            campaignObj.CRM_ActivateProcessId__c = Database.executeBatch(new CampaignProcess_AddMember(campId, 1), 1);
                        else
                            campaignObj.CRM_ActivateProcessId__c=Database.executeBatch(new CampaignProcess_AddMember(campId, campaignObj.List_Order_Id__c),1);   // Added for defect CRM-72 795 , only 5 campaigns can be activated 
                    }
                    else
                    {
                        throw new ApplicationException('Please try again');
                    }
                    
                    campaignObj.Add_Member_Status__c='Adding Members';
                    campaignObj.Missing_Contact_Count__c = null;// We will re calculate missing count during campaign activation
                }
         /*   }else{
                 if([SELECT count() FROM AsyncApexJob WHERE Status = 'Holding' AND JobType = 'BatchApex']<100)
                   campaignObj.CRM_ActivateProcessId__c=Database.executeBatch(new Campaign_AddCampaignMemberFromAU(campId),2000);
                else
                    throw new ApplicationException('Please try again');
                
                campaignObj.Add_Member_Status__c='Adding Members';
                campaignObj.Missing_Contact_Count__c = null;// We will re calculate missing count during campaign activation
            } */
        }else{
            campaignObj.status='Active';
            campaignObj.IsActive=true;
        }
        update campaignObj;
    
    }
    //Changes for PP1 Ends
    /********* To get current user name *****/
    public void getownername()
    {
       u= UserInfo.getUserId();
       User activeUser =  [SELECT Name FROM User WHERE Id = : u limit 1];
       system.debug('current user name===========' + activeUser.Name);
       username = activeUser.Name;
       system.debug('current user name===========' + username);
       objcampaign.OwnerId = u;
    }
    
    /****To enable the reresh button ***/
    public void refreshCountButtonMethod()
    {
    
    
        
        
    Integer  EncCountAgg=[Select count() from Encounter_aggregates__c where Campaign__c=:objcampaign.Id ];
     system.debug('EncCountAgg'+EncCountAgg);
        EncCount=[Select count() from encounter__c where Campaign__c=:objcampaign.Id ];
        system.debug('EncCount'+EncCount);
        LifeCount=[Select count() from Life_Style__c where Campaign__c=:objcampaign.Id ];
        system.debug('LifeCount'+LifeCount);
        demoCount=[Select count() from Campaign_Demographics__c where Campaign__c=:objcampaign.Id ];
        system.debug('demoCount'+demoCount);
        modelCount=[Select count() from Model__c where Campaign__c=:objcampaign.Id ];  
        locationCount=[Select count() from Campaign_Location__c where Campaign__c=:objcampaign.Id ];  
        system.debug('locationCount'+locationCount);     
        system.debug('modelCount'+modelCount);  
        geographyCount=[Select count() from Geographic_Info_Information__c where Campaign__c=:objcampaign.Id ];  
        system.debug('geographyCount'+geographyCount); 
         IncludeDiagnosesCount= [SELECT count() FROM ICD_Diagnosis_In__c WHERE Campaign__c=:objcampaign.Id];  
        system.debug('IncludeDiagnosesCount'+IncludeDiagnosesCount);           
       IncludeProceduresCount = [SELECT count() FROM Procedure_Information__c WHERE Campaign__c=:objcampaign.Id];
       system.debug('IncludeProceduresCount '+IncludeProceduresCount );
        IncludeDRGCount = [SELECT count() FROM DRG_Code_Information__c WHERE Campaign__c=:campid];
         system.debug('IncludeDRGCount '+IncludeDRGCount );
        system.debug('inside refreshCountButtonMethod ');
           if(EncCountAgg >0 || demoCount > 0 || LifeCount >0 || modelCount >0 || EncCount>0 || locationCount>0 || geographyCount>0 || IncludeDiagnosesCount>0 || IncludeProceduresCount>0 || IncludeDRGCount>0  || (objcampaign.Member_Types__c !=null && objcampaign.Member_Types__c!='none'))
        {
          system.debug('brfore refreshFlag '+refreshFlag);
          refreshFlag=true;  
          system.debug('after refreshFlag'+refreshFlag);
        }


    }
    
   
   // created by Lov for control group functionality
  /*public void createControlGroup () {
      List<CampaignMember> existingCampMem =  new List<CampaignMember> ();
      List<CampaignMember> CampMemToBeUpd =  new List<CampaignMember> ();
      System.debug('****objcampaign********'+objcampaign);
      if(objcampaign.Control_Group_Member__c!=0) {
          for(CampaignMember cm : [SELECT id, Control_Group__c FROM CampaignMember WHERE Campaignid=:campId ORDER By Name]) {
              existingCampMem.add(cm);
          }
          if(existingCampMem.size()>0) {
          for(Integer i=0; i<existingCampMem.size(); i++) {
              if(math.mod(i,Integer.valueOf(objcampaign.Control_Group_Member__c)) == 0) {
                  CampaignMember cm = new CampaignMember();
                  cm = existingCampMem[i];
                  cm.Control_Group__c = true;
                  CampMemToBeUpd.add(cm);                  
              }
          }
          System.debug('****CampMemToBeUpd******'+CampMemToBeUpd);
          if(CampMemToBeUpd.size()>0)
              update CampMemToBeUpd;
          }
      
      }
      
  }*/
  
  //delete All Geography By Service Area records for this campaign
 
/*public void vendorname()
{    
    // Design change for channel vendor screen: Vendor Name
    system.debug('i am in vendorname method ');
    Map<String ,Boolean> mapVendorNameOther=new Map<String ,Boolean>();
    id RecordTypeid = [SELECT id FROM RecordType WHERE SobjectType='CRM_CampaignWizardReferenceData__c' AND DeveloperName='Vendor_Name'][0].id;
  *//*  for(CRM_CampaignWizardReferenceData__c objCRMVendorNameVal : [Select CRM_VendorName__c ,CRM_IsOtherEnabled__c  FROM CRM_CampaignWizardReferenceData__c WHERE Recordtypeid =:RecordTypeid])
    {
        mapVendorNameOther.put(objCRMVendorNameVal.id,objCRMVendorNameVal.CRM_IsOtherEnabled__c  );
    }
    system.debug('#### mapVendorNameOther ####' + mapVendorNameOther);
    if (mapVendorNameOther!=null && mapVendorNameOther.size()>0 )
    {  
        if(mapVendorNameOther.get(selectedVendor)==true) 
        {
            vendornameflag=false;     
            system.debug('i am in vendornameflag1 condition false========' + vendornameflag);  
        }
        else 
        {
            vendornameflag= true;
            system.debug('i am in vendornameflag1 condition false========' + vendornameflag);
            objcampaign.Other__c = '';      
        }
    }  */
// End : Design change for channel vendor screen :Vendor Name
//}
   
   
   public void deactivegeographybuttons(){
     
        locationCount=[Select count() from Campaign_Location__c where Campaign__c=:objcampaign.Id ]; 
        
        if(locationCount<1)
            geographyCount=[Select count() from Geographic_Info_Information__c where Campaign__c=:objcampaign.Id AND Audience_Search_Type__c='Geography By Boundary'];
        
        if(geographyCount<1)
            distanceCount=[Select count() from Geographic_Info_Information__c where Campaign__c=:objcampaign.Id AND Audience_Search_Type__c='Geography By Distance'];
        
        if(locationCount>0){
            activateGeographyBoundaryButton=true;
            activateGeographyByDistanceButton=true;
        }else if(geographyCount>0){
            activateGeographyByDistanceButton=true;
            activateSearviceAreaButton= true;
        }else if(distanceCount>0){
            activateSearviceAreaButton= true;
            activateGeographyBoundaryButton=true;
        }
        
   }
   
  public  void preparehospitalpicklist(){
     HospitalList = new list<SelectOption>();
     //HospitalList.add(new SelectOption('','--None--'));
     
     for(AggregateResult hlist: [select Hospital__c from Location__c where Hospital__c!= null group by Hospital__c order by Hospital__c asc]){
            HospitalList.add(new SelectOption((string)hlist.get('Hospital__c'),(string)hlist.get('Hospital__c')));
     }
     
  }
  
    //This method will place order and get net count
    //Changes for PP1 Start
    //Start of PP5 Changes 
    public PageReference refreshNetCount(){
        pageReference pg;
        Campaign cmp;
        system.debug('*****campaignId='+campaignId+'****'+campId);
       try
       {
            cmp = [select id,Member_Types__c,CRM_AudienceUploadCount__c,CRM_ParentSegmentedCampaign__c,(select id from CRM_SegmentedParentCampaigns__r where Add_Member_Status__c!='Calculated Net Count') from Campaign where id=:campId];
            
            
            if (isExternalUpload(cmp.Member_Types__c))
            {
                if (cmp.CRM_ParentSegmentedCampaign__c == null)
                    pg= new Pagereference('/apex/CampaignWizard?Id='+campId+'&stepNo=3');
                else
                    pg= new Pagereference('/apex/CampaignWizard?Id='+campId+'&stepNo=2');
                pg.setRedirect(true);
                if (cmp.CRM_AudienceUploadCount__c == -2 || cmp.CRM_AudienceUploadCount__c == -3 || cmp.CRM_AudienceUploadCount__c == null)
                {
                    return pg;
                }
                
                cmp.Current_count__c = cmp.CRM_AudienceUploadCount__c;
                cmp.Add_Member_Status__c = 'Calculating Upload';
                update cmp;
                Id batchId = Database.executeBatch(new AudienceUpload_GetNetCount(cmp.Id), 2000);
                return pg;
            }
            
            
            /*cmp = [select id,Member_Types__c,CRM_UploadAudienceCount__c from Campaign where id=:campId];
            if(!string.valueOf(cmp.Member_types__c).equalsIgnoreCase('Upload List') )
            {*/
                //Starting of defect#798:Net counts did not complete being calculated. SFDC suspected timeout after 2 minutes and did a manual process to restart the job. 
    
            if(Tenet_Static_Variables.checkActiveJob(Tenet_Static_Variables.WUNDERMAN_SESSION_SCHEDULER) && Tenet_Static_Variables.checkActiveJob(Tenet_Static_Variables.WUNDERMAN_NET_COUNT_SCHEDULER))
            {
                if(!string.valueOf(cmp.Member_types__c).equalsIgnoreCase('Campaign Segments') && (!string.valueOf(cmp.Member_types__c).equalsIgnoreCase('Upload List')))
                {
                    system.debug('inside if statement for non member type');
                    CampaignMemberCriteriaManager.syncCampaignMemberCriterias(campId,true);
                }
                else
                {
                    if(cmp.CRM_SegmentedParentCampaigns__r.size()>0)
                        throw new ApplicationException(System.label.CRM_Segment_Final_Count_Warning);
                    else
                    {
                        dedupeBatchId = AudienceReport_Helper.rollupFinalCountDetailToSegmented2(new list<Id>{cmp.id},false,false);   //PP4 chnages
                        
                        //AXU - track WDM deduping batch process
                        if (String.isNotBlank(dedupeBatchId))
                        {
                            cmp.CRM_WdmDedupeProcessId__c = dedupeBatchId;
                            cmp.Add_Member_Status__c = 'WDM Deduping';
                            update cmp;
                        }
                    }
                    
                }
            }else
            {
                throw new ApplicationException(System.label.CRM_AutomatedProcessIsNotRunning);
            }
            /*}else 
           If(string.valueOf(cmp.Member_types__c).equalsIgnoreCase('Upload List')){
                
                cmp.Current_count__c = cmp.CRM_AudienceUploadCount__c;
                update cmp;
                
                if(cmp.Current_count__c!=null)
                {
                    if(integer.valueof(cmp.Current_count__c)>150000)
                        throw new ApplicationException('Audience Count more than 150000');
                }
                
                cmp.Add_Member_Status__c='Order Placed';
                cmp.Error_Message__c=null;
                update cmp;
                system.debug('before execute batch@@@');
                Database.executeBatch(new Campaign_AudienceReportBatch(cmp.Id,true),2000);
                system.debug('after execute batch@@@');
                pg= new Pagereference('/apex/CampaignWizard?Id='+campId+'&stepNo=3');
            
            } */
            //start of PP4 chnage
           if(objcampaign.CRM_ParentSegmentedCampaign__c!=null)
                pg= new Pagereference('/apex/CampaignWizard?Id='+campId+'&stepNo=2');
             else 
                pg= new Pagereference('/apex/CampaignWizard?Id='+campId+'&stepNo=3');
            //end of PP4 chnage
            pg.setredirect(true); 
            
           
        }catch(Exception ex)
        {
            
            if(ex.getMessage().startsWith(System.label.CRM_AutomatedProcessIsNotRunning))
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,+System.label.CRM_FinalCountErrorMessage+' '+ System.label.CRM_AutomatedProcessIsNotRunning));   
            
            else if(ex.getMessage().startsWith('Audience Count more than 150000')){
                objcampaign.Current_count__c =[select Current_count__c from campaign where id=:campId limit 1].Current_count__c;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,+System.label.CRM_FinalCountLimitExceeded));    
            }else if(ex.getMessage().startsWith('Unable to do the refresh count from Wunderman.'))
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,+System.label.CRM_UnableToDoRefreshCountFromWunderman));           
            else if(ex.getMessage().startsWith(System.label.CRM_Segment_Final_Count_Warning))
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage()));
            else
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,+System.label.CRM_FinalCountErrorMessage+' '+ ex.getMessage()+ ex.getStackTraceString() + '.Please try again.' ));    
         }
            //update camp;
            
        return pg;
    }
    //End of PP5 Changes 
    //Changes for PP1 End
    
  // start of ownership process change  
   public void insertOwnershipJO(Id campId)
{ 
  System.debug('>>>>>>campId<<<<<'+campId);
  if(selectedCriteria!=null)
  {
    system.debug('*****selectedCriteria in save method='+selectedCriteria);
    //added below lists to fix required field error 
    List<CRM_CampaignOwnershipDetail__c> toInsertOwnerlist= new list<CRM_CampaignOwnershipDetail__c>();   
    List<CRM_CampaignOwnershipDetail__c> toDeleteOwnerlist = new List<CRM_CampaignOwnershipDetail__c>();
    
    Set<String> selectedcriteriaset = new Set<String>(selectedCriteria); 
    map <id,CRM_CampaignOwnershipDetail__c > existingownershiplist = new  map<id,CRM_CampaignOwnershipDetail__c >([select id ,Campaign_Location_Reference_Data_Mapping__c from CRM_CampaignOwnershipDetail__c where Campaign__c =:CampId ]);
    system.debug('*****existing ownership size'+existingownershiplist.size() );
    // for deleting existing records in junction object
    for(CRM_CampaignOwnershipDetail__c ol:existingownershiplist.values() )
    {
        if (!selectedcriteriaset.contains(ol.id))
        {
            System.debug('#### inside check deleted records '+selectedcriteriaset.contains(ol.id));
            toDeleteOwnerlist.add(ol);    
        }
    
    }
    if (toDeleteOwnerlist.size()>0)
    {
        delete [Select Id from CRM_CampaignOwnershipDetail__c where id=:toDeleteOwnerlist]; 
    }
    // for removing the already user inserted records in junction object
    for(CRM_CampaignOwnershipDetail__c ol:existingownershiplist.values() )
    { 
        system.debug('inside existing list check');
        if(selectedcriteriaset.contains( ol.Campaign_Location_Reference_Data_Mapping__c))
        {
            system.debug('####inside existing list check with selected criteria');
            selectedcriteriaset.remove(ol.id);
            system.debug('####selected criteria size'+ selectedCriteria.size());
        }
    }
    system.debug('####selected criteria size after removal'+ selectedCriteria.size());
    //for inserting records in junction object
    System.debug('>>>>>>selectedcriteriaset<<<<<'+selectedcriteriaset);
    
    for(String str: selectedcriteriaset)
    {
        for(CRM_CampaignLocationReferenceData__c objCRMRefVals : [Select id,CRM_Region__c, CRM_Market__c, CRM_Hospital__c from CRM_CampaignLocationReferenceData__c where Id=:str AND CRM_isActive__c=true]) {
       // ListIdsToCheck.add(objCRMRefVals.id);
        System.debug('>>>>>>campId<<<<<'+campId);    
        System.debug('>>>>>>str<<<<<'+str);
        CRM_CampaignOwnershipDetail__c ownershipdetails = new CRM_CampaignOwnershipDetail__c();
        system.debug('*****in for loopafter object junction ');
        Id i = Id.valueOf(str);
        ownershipdetails.Campaign__c = campId;
        system.debug('*****inside for loop ');
        ownershipdetails.Campaign_Location_Reference_Data_Mapping__c= objCRMRefVals.id;
        
        System.debug('>>>>>>ownershipdetails<<<<<'+ownershipdetails);
        toInsertOwnerlist.add(ownershipdetails );
        
        System.debug('>>>>>>ownerlist<<<<<'+toInsertOwnerlist);
    }
    }
    if(!toInsertOwnerlist.IsEmpty())
    {
        System.debug('>>>>>>ownerlist<<<<<'+toInsertOwnerlist);
        insert toInsertOwnerlist;    
    }
  }
}
    
    public void saveownershipvalues(){
         List<Id> selectedIds = new List<Id>();
       for(String str: selectedCriteria){
             selectedIds.add(Id.valueOf(str));
        }
            for(CRM_CampaignLocationReferenceData__c selcriteria : [select recordtype.name, CRM_isActive__C, CRM_RegionCode__c, CRM_MarketCode__c, CRM_HospitalCode__c from CRM_CampaignLocationReferenceData__c where Id IN:selectedIds ])
                {
          system.debug('inside second if');
            if((selcriteria.recordtype.name).equalsIgnoreCase(Tenet_Static_Variables.Campaign_Ownership_Region)  ){
              system.debug('inside second if%%% if condition true');
              selectedownershipCodes.add(selcriteria.CRM_RegionCode__c);
              system.debug('*****selectedownershipCodes'+ selectedownershipCodes);
             }
              
         
            else if((selcriteria.recordtype.name).equalsIgnoreCase(Tenet_Static_Variables.Campaign_Ownership_Market) ){
              system.debug('inside second if%%% if condition true');
              selectedownershipCodes.add(selcriteria.CRM_MarketCode__c);
              system.debug('*****selectedownershipCodes'+ selectedownershipCodes);
             }
           else if((selcriteria.recordtype.name).equalsIgnoreCase(Tenet_Static_Variables.Campaign_Ownership_Hospital)){
             system.debug('inside second if%%% if condition true');
             selectedownershipCodes.add(selcriteria.CRM_HospitalCode__c);
             system.debug('*****selectedownershipCodes'+ selectedownershipCodes);
            }
         }
       
        
        
    }

public void SelectedOwnershipValues(Id CampId )    
{
 
        if(objcampaign.CRM_OwnershipType__c!=null){
       
      //  if(selectedOwnerType!=null){
        system.debug('inside ownership in edit mode');
      
       selectedOwnerType = Schema.SObjectType.CRM_CampaignLocationReferenceData__c.getRecordTypeInfosByName().get(objcampaign.CRM_OwnershipType__c).getRecordTypeId() ;
        system.debug('%%%%%%%inside ownership in edit mode selectedownershiptype'+ selectedOwnerType );
        
        
        
        
        id regionrecordtypeid= ReferenceData_PicklistController.recordTypeId('CRM_CampaignLocationReferenceData__c','Region');
        id marketrecordtypeid= ReferenceData_PicklistController.recordTypeId('CRM_CampaignLocationReferenceData__c','Market');
        id hospitalrecordtypeid= ReferenceData_PicklistController.recordTypeId('CRM_CampaignLocationReferenceData__c','Hospital');
        List<Id> junctionvalues = new List<Id>();
       for(CRM_CampaignOwnershipDetail__c rt : [ select id, CRM_IsActive__c, Campaign_Location_Reference_Data_Mapping__c, Campaign_Location_Reference_Data_Mapping__r.recordTypeId from CRM_CampaignOwnershipDetail__c where campaign__c=:campid  ])
       {
       
    
       if(rt.Campaign_Location_Reference_Data_Mapping__r.recordTypeId==regionrecordtypeid && rt.CRM_IsActive__c==true){
                    selectedCriteria.add(rt.Campaign_Location_Reference_Data_Mapping__c);
                    
}   
             
      else if(rt.Campaign_Location_Reference_Data_Mapping__r.recordTypeId==marketrecordtypeid && rt.CRM_IsActive__c==true){
     
        system.debug('record in edit@@@'+rt.Campaign_Location_Reference_Data_Mapping__c);
       
                    selectedCriteria.add(rt.Campaign_Location_Reference_Data_Mapping__c);
                     
             } 
      else if(rt.Campaign_Location_Reference_Data_Mapping__r.recordTypeId==hospitalrecordtypeid && rt.CRM_IsActive__c==true){
                    selectedCriteria.add(rt.Campaign_Location_Reference_Data_Mapping__c);
                     
             }
           junctionvalues.add(rt.Campaign_Location_Reference_Data_Mapping__c);
        }
        system.debug('edit mode junctionvalues name==='+junctionvalues );
        system.debug('edit mode selectedcriteria name==='+selectedCriteria );
        fetchOwnershipNames();
   
        }
   
   
   
   } 
   
   public void clearCriteria(){
    selectedCriteria.clear();
    }
    
    // End of Ownership process change
   //Changes for PP1 Start
    /*public PageReference deleteaudience(){
        PageReference ref;
        AudienceUploadHelper.setUploadJunctionForDelete(objcampaign.Id);
         ref = new Pagereference('/apex/CampaignWizard?Id='+campId+'&stepNo=2');
            ref.setredirect(true); 
        return ref;
    }*/
    //Changes for PP1 End
    //start of PP4 chnage
    public pagereference segmentnavbar(){
        pagereference ref;
    system.debug('id of child@@@'+ IdFromPage);
      
        if((stepNo==1 || stepNo==2) && objcampaign.CRM_ParentSegmentedCampaign__c==null){
            stepNo=1;
        }
        else if(stepNo==3 && objcampaign.CRM_ParentSegmentedCampaign__c==null){
            stepNo=2;
        }
        else if((stepNo==4 || stepNo==5) && objcampaign.CRM_ParentSegmentedCampaign__c==null){
            stepNo=3;
        }
        else if(objcampaign.CRM_ParentSegmentedCampaign__c!=null && segmentflag==true){
         stepNo=stepNo;
        }
        else if(stepNo==1 && objcampaign.CRM_ParentSegmentedCampaign__c!=null && segmentflag==false){
         stepNo=2;
        }
        else if(stepNo==2 && objcampaign.CRM_ParentSegmentedCampaign__c!=null && segmentflag==false){
         stepNo=3;
        }
        else if(stepNo==3 && objcampaign.CRM_ParentSegmentedCampaign__c!=null && segmentflag==false){
         stepNo=4;
        }
        
        ref = new PageReference('/apex/campaignWizard?id='+IdFromPage+'&stepNo='+stepNo);
        system.debug('after oage url');
        ref.setredirect(true);
        return ref;
    }
// end of PP4 chnages
    
    /* Staring of PP6 changes */
    Public pagereference CountAnalysis()
    {
     pagereference ref;
     
     if (ObjCampaign.CRM_ParentSegmentedCampaign__c!=null)
     ref = new PageReference('/apex/CRM_CountSummary?id='+ObjCampaign.CRM_ParentSegmentedCampaign__c);
     else
     ref = new PageReference('/apex/CRM_CountSummary?id='+ObjCampaign.id); 
     
     ref.setredirect(true);
     return ref;
    }
    
    /* Ending of PP6 changes */
    
    //BEGIN - CRM 326 FIX  - AXU
    
    public void overrideSuppAction()
    {
        if (objcampaign.Add_Member_Status__c == 'Calculated Net Count')
        {
            Campaign cmp = [SELECT Ignore_Bad_Debt_Suppression__c, Ignore_Minor_Suppression__c FROM Campaign WHERE Id =: objcampaign.Id];
            objcampaign.Ignore_Bad_Debt_Suppression__c = cmp.Ignore_Bad_Debt_Suppression__c;
            objcampaign.Ignore_Minor_Suppression__c = cmp.Ignore_Minor_Suppression__c;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Campaign must be unlocked before changing Override Suppressions value'));
            return;
        }
        
        
        List<Campaign> segments =
        [
            SELECT
                Ignore_Bad_Debt_Suppression__c,
                Ignore_Minor_Suppression__c,
                Add_Member_Status__c
            FROM
                Campaign
            WHERE
                CRM_ParentSegmentedCampaign__c =: objcampaign.Id
        ];
        
        for (Campaign c : segments)
        {
            if (c.Add_Member_Status__c == 'Calculated Net Count')
            {
                System.debug('Alex don\'t change that');
                objcampaign.Ignore_Bad_Debt_Suppression__c = c.Ignore_Bad_Debt_Suppression__c;
                objcampaign.Ignore_Minor_Suppression__c = c.Ignore_Minor_Suppression__c;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'All Segments must be unlocked before changing Override Suppressions value'));
                return;
            }
        }
        
        for (Campaign c : segments)
        {
            c.Ignore_Bad_Debt_Suppression__c = objcampaign.Ignore_Bad_Debt_Suppression__c;
            c.Ignore_Minor_Suppression__c = objcampaign.Ignore_Minor_Suppression__c;
        }
        update segments;
    }
    //END - CRM 326 FIX  - AXU
    
    //BEGIN - PP1 - AXU
    public PageReference deleteAudience()
    {
        deleteAudienceMethod();
        PageReference ref;
        if (objcampaign.CRM_ParentSegmentedCampaign__c == null)
            ref = new PageReference('/apex/campaignWizard?Id=' + objcampaign.Id + '&stepNo=3');
        else
            ref = new PageReference('/apex/campaignWizard?Id=' + objcampaign.Id + '&stepNo=2');
        ref.setRedirect(true);
        return ref;
    }
    
    private void deleteAudienceMethod()
    {
        List<Transaction__c> trans = 
        [
            SELECT Id
            FROM Transaction__c
            WHERE Transaction_Source__c = 'Audience Upload'
            AND Campaign__c =: objcampaign.Id 
        ];
        delete trans;
        
        if (objcampaign != null && objcampaign.Id != null)
        {
            objcampaign.CRM_AudienceUploadCount__c = null;
            objcampaign.Current_count__c = null;
            objcampaign.CRM_AudienceUploadRowCount__c = null;
            update new Campaign(Id = objcampaign.Id, CRM_AudienceUploadCount__c = null, Current_count__c = null, CRM_AudienceUploadRowCount__c = null);
        }
    }
    
    public Boolean hasExistingAudienceUpload()
    {
        if (objcampaign.CRM_AudienceUploadCount__c != null && objcampaign.CRM_AudienceUploadCount__c != 0 && objcampaign.CRM_AudienceUploadCount__c != -2 )
            return true;
        
        Integer transCount = [SELECT Count() FROM Transaction__c WHERE Transaction_Source__c = 'Audience Upload' AND Campaign__c =: objCampaign.Id];
        if (transCount > 0)
            return true;
            
        return false;
    }
    //END - PP1 - AXU
    
    public Boolean isExternalUpload(String memberType)
    {
        CRM_MemberTypeReferenceData__c refDataMemType = CRM_MemberTypeReferenceData__c.getValues(memberType);
        return refDataMemType == null ? false : refDataMemType.CRM_IsExternalUpload__c;
    }

    
   

    
    public class ApplicationException extends Exception {}
}
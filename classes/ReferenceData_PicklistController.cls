public class ReferenceData_PicklistController{
    public static map<id,CRM_CampaignWizardReferenceData__c> serviceLineMap;
    
    public static map<id,CRM_AudienceCriteriaRefData__c> clinicalServiceLineMap;
    public static Id recordTypeId(string sobjectName, string developerName){
        Id recordTypeid = [SELECT id FROM RecordType WHERE SobjectType=:sobjectName AND DeveloperName=: developerName][0].Id;
        return recordTypeid; 
    }
    
    public static string recordTypeDeveloperName(string sobjectName, string recordTypeId){
        string developerName = [SELECT id,developerName FROM RecordType WHERE SobjectType=:sobjectName AND Id=:recordTypeId][0].developerName;
        return developerName; 
    }
    /*Start - Service and Sub Service Line Camptaign Detail Methods*/
    public static list<SelectOption> serviceLine(Boolean isSingleSelect){
        serviceLineMap = new map<id,CRM_CampaignWizardReferenceData__c>();
        list<SelectOption> lstServiceLineVal = new List<SelectOption> ();
        if(isSingleSelect)
            lstServiceLineVal.add(new SelectOption('', '--None--'));
        for(CRM_CampaignWizardReferenceData__c objCRMServiceLineVal : [Select id ,CRM_ServiceLine__c  FROM CRM_CampaignWizardReferenceData__c WHERE Recordtypeid =:recordTypeId('CRM_CampaignWizardReferenceData__c','Service_Line') and CRM_IsActive__c=true order by CRM_ServiceLine__c  asc]){ 
           lstServiceLineVal.add(new SelectOption(objCRMServiceLineVal.id, objCRMServiceLineVal.CRM_ServiceLine__c));
           serviceLineMap.put(objCRMServiceLineVal.id,objCRMServiceLineVal);
        }
        
        return lstServiceLineVal;
    }
    
    public static list<SelectOption> subServiceLine(boolean isAll, list<string> serviceLine){
        
        list<SelectOption> lstServiceLineVal = new List<SelectOption> ();
           
        id recordTypeId=recordTypeId('CRM_CampaignWizardReferenceData__c','Sub_Service_Line');
        string query = 'Select id ,CRM_ParentServiceLineID__r.CRM_ServiceLine__c,CRM_ServiceSubServiceLine__c  FROM CRM_CampaignWizardReferenceData__c WHERE Recordtypeid = :recordTypeId AND CRM_IsActive__c=true';
        if(!isAll && serviceLine!=null && serviceLine.size()>0)
            query += ' and CRM_ParentServiceLineID__c IN :serviceLine';
        query += ' order by CRM_ServiceSubServiceLine__c  asc';
        if(!isAll && (serviceLine==null || serviceLine.size()<1))
            query += ' limit 0';
            
        for(CRM_CampaignWizardReferenceData__c objCRMServiceLineVal : Database.query(query)){ 
           lstServiceLineVal.add(new SelectOption(objCRMServiceLineVal.id, objCRMServiceLineVal.CRM_ServiceSubServiceLine__c));
           
        }
        
        return lstServiceLineVal;
    }  
    /*End - Service and Sub Service Line Camptaign Detail Methods*/
    
    /* start of ownership process */
    public static list<SelectOption> ownershipOptions(){
        list<SelectOption> campaignOwner = new list<SelectOption>();
        
        for(RecordType rt : [select developerName,id from RecordType where sObjectType='CRM_CampaignLocationReferenceData__c' AND developerName IN ('Region','Market','Hospital') order by developerName desc ]){
            campaignOwner.add(new SelectOption(rt.id,rt.developerName+'(s)'));
        }
        
        return campaignOwner;
    }
    
    public static list<SelectOption> refreshOwnershiptype(id recordtypeId){
        list<SelectOption> campaignOwner = new list<SelectOption>();
        string developerName = recordTypeDeveloperName('CRM_CampaignLocationReferenceData__c',recordtypeId);
        for(CRM_CampaignLocationReferenceData__c rt : [select CRM_Region__c, CRM_Market__c, CRM_Hospital__c, CRM_HospitalMarket__c, CRM_MarketRegion__c from CRM_CampaignLocationReferenceData__c where CRM_IsActive__c=true AND RecordTypeId=:recordtypeId order by CRM_Region__c, CRM_MarketRegion__c, CRM_HospitalMarket__c asc]){
            if(developerName.equalsIgnoreCase(Tenet_Static_Variables.Campaign_Ownership_Region))
                campaignOwner.add(new SelectOption(rt.id,rt.CRM_Region__c));
            else  if(developerName.equalsIgnoreCase(Tenet_Static_Variables.Campaign_Ownership_Market))
                campaignOwner.add(new SelectOption(rt.id,rt.CRM_MarketRegion__c));
            else  if(developerName.equalsIgnoreCase(Tenet_Static_Variables.Campaign_Ownership_Hospital))
                campaignOwner.add(new SelectOption(rt.id,rt.CRM_HospitalMarket__c));
        }
        
        return campaignOwner;
    }
    
    /* End of ownership process */
    /*Start - Service and Sub Service Line Audience Selection Methods*/
    public static list<SelectOption> clinicalServiceLine(Boolean isSingleSelect){
        clinicalServiceLineMap = new map<id,CRM_AudienceCriteriaRefData__c>();
        list<SelectOption> lstServiceLineVal = new List<SelectOption> ();
        if(isSingleSelect)
            lstServiceLineVal.add(new SelectOption('', '--None--'));
        for(CRM_AudienceCriteriaRefData__c objCRMServiceLineVal : [Select id ,CRM_ClinicalServiceLine__c,CRM_ClinicalServiceLineSyncData__c  FROM CRM_AudienceCriteriaRefData__c WHERE Recordtypeid =:recordTypeId('CRM_AudienceCriteriaRefData__c','ClinicalServiceLine') and CRM_IsActive__c=true order by CRM_ClinicalServiceLine__c  asc]){ 
           lstServiceLineVal.add(new SelectOption(objCRMServiceLineVal.id, objCRMServiceLineVal.CRM_ClinicalServiceLine__c));
           clinicalServiceLineMap.put(objCRMServiceLineVal.id,objCRMServiceLineVal);
        }
        
        return lstServiceLineVal;
    }
    
    public static list<SelectOption> clinicalSubServiceLine(boolean isAll, list<string> serviceLine){
        
        list<SelectOption> lstServiceLineVal = new List<SelectOption> ();
           
        id recordTypeId=recordTypeId('CRM_AudienceCriteriaRefData__c','ClinicalSubServiceLine');
        string query = 'Select id ,CRM_ClinicalServiceLineID__r.CRM_ClinicalServiceLine__c,CRM_ClinicalSubServiceLine__c,CRM_ClinicalSubServiceLineSyncData__c,CRM_ServiceSubServiceLine__c  FROM CRM_AudienceCriteriaRefData__c WHERE Recordtypeid = :recordTypeId AND CRM_IsActive__c=true';
        if(!isAll && serviceLine!=null && serviceLine.size()>0)
            query += ' and CRM_ClinicalServiceLineID__c IN :serviceLine';
        query += ' order by CRM_ServiceSubServiceLine__c  asc';
        if(!isAll && (serviceLine==null || serviceLine.size()<1))
            query += ' limit 0';
            
        for(CRM_AudienceCriteriaRefData__c objCRMServiceLineVal : Database.query(query)){ 
           lstServiceLineVal.add(new SelectOption(objCRMServiceLineVal.id, objCRMServiceLineVal.CRM_ServiceSubServiceLine__c));
           
        }
        
        return lstServiceLineVal;
    }  
    /*End - Service and Sub Service Line Audience Selection Methods*/
    
    
    /*Start -Method to insert/delete selected reference data values in junction Object for Service Line,Subservice line,Channeland Vendor Name screen*/   
    public static void updateJunctionObject(String CampId,list<string> ValuesIds)
    {
        Set<String> selectedOptionsSet = new Set<String>(ValuesIds);
        List<CRM_CampaignRefJunction__c > listToInsert =new    List<CRM_CampaignRefJunction__c >();
        List<CRM_CampaignRefJunction__c > listToDel =new    List<CRM_CampaignRefJunction__c >();
        Map<string,CRM_CampaignRefJunction__c > existingRecordMap = new Map<string,CRM_CampaignRefJunction__c >();   
        for(CRM_CampaignRefJunction__c ObjJO : [select CRM_CampaignWizardReferenceData__c,CRM_CampaignMapping__c  from CRM_CampaignRefJunction__c where CRM_CampaignMapping__c =:CampId])
        {
         system.debug('>>>>>ObjJO.CRM_CampaignWizardReferenceData__c<<<<<'+ObjJO.CRM_CampaignWizardReferenceData__c);
          if(!existingRecordMap.containsKey(ObjJO.CRM_CampaignWizardReferenceData__c))
          existingRecordMap.put(ObjJO.CRM_CampaignWizardReferenceData__c,ObjJO);  
          if(!selectedOptionsSet.contains(ObjJO.CRM_CampaignWizardReferenceData__c))
          listToDel.add(ObjJO);
        }
        if (listToDel.size()>0) delete listToDel;
        
        for(String str : selectedOptionsSet)
        if(!existingRecordMap.containsKey(str))
        listToInsert.add(new CRM_CampaignRefJunction__c(CRM_CampaignMapping__c=CampId,CRM_CampaignWizardReferenceData__c=str));
        
        if (listToInsert.size()>0) insert listToInsert;
        
   }
   
    /*End -Method to insert/delete selected reference data values in junction Object for Service Line,Subservice line,Channeland Vendor Name screen*/
   
   /*Start- Method to prepare list for channel vendor screeen and service and subservice line picklist on UI */
    public static list<SelectOption> getPickListValues(String DevName)
    {   id recordTypeId;
        list<SelectOption> returnList = new List<SelectOption> ();
        if(Devname!='MemberType')
        {returnList.add(new SelectOption('', '--None--'));
        recordTypeId=recordTypeId('CRM_CampaignWizardReferenceData__c',DevName);
        }
       
        if(Devname=='ChannelValues')
        for(CRM_CampaignWizardReferenceData__c objCRMVal : [Select id ,CRM_Channel__c FROM CRM_CampaignWizardReferenceData__c WHERE Recordtypeid =:recordTypeId and CRM_IsActive__c=true order by CRM_Channel__c asc]) 
           returnList.add(new SelectOption(objCRMVal.id, objCRMVal.CRM_Channel__c)); 
        else if(Devname=='Call_To_Action')
        for(CRM_CampaignWizardReferenceData__c objCRMVal : [Select id ,CRM_CallToAction__c FROM CRM_CampaignWizardReferenceData__c WHERE Recordtypeid =:recordTypeId and CRM_IsActive__c=true order by CRM_CallToAction__c asc])
           returnList.add(new SelectOption(objCRMVal.id, objCRMVal.CRM_CallToAction__c ));
        else if (Devname=='Vendor_Name') 
        for(CRM_CampaignWizardReferenceData__c objCRMVal : [Select id ,CRM_VendorName__c FROM CRM_CampaignWizardReferenceData__c WHERE Recordtypeid =:recordTypeId and CRM_IsActive__c=true order by CRM_VendorName__c asc])             
           returnList.add(new SelectOption(objCRMVal.id, objCRMVal.CRM_VendorName__c ));
        else if (Devname=='Service_Line') 
        for(CRM_CampaignWizardReferenceData__c objCRMVal : [Select id ,CRM_ServiceLine__c FROM CRM_CampaignWizardReferenceData__c WHERE Recordtypeid =:recordTypeId and CRM_IsActive__c=true order by CRM_ServiceLine__c asc])             
           returnList.add(new SelectOption(objCRMVal.id, objCRMVal.CRM_ServiceLine__c ));
        else if (Devname=='Sub_Service_Line') 
        for(CRM_CampaignWizardReferenceData__c objCRMVal : [Select id ,CRM_SubServiceLine__c FROM CRM_CampaignWizardReferenceData__c WHERE Recordtypeid =:recordTypeId and CRM_IsActive__c=true order by CRM_SubServiceLine__c asc])             
           returnList.add(new SelectOption(objCRMVal.id, objCRMVal.CRM_SubServiceLine__c ));
        else if (Devname=='MemberType') 
        for(CRM_MemberTypeReferenceData__c objCRMVal : [Select id ,name  FROM CRM_MemberTypeReferenceData__c WHERE CRM_IsActive__c=:true  order by name asc])             
           returnList.add(new SelectOption(objCRMVal.name, objCRMVal.name));
                     
        return returnList;
    }
    
    /*End - Method to fecth picklist values for channel vendor screeen and service and subservice line */
    
    /*Start -Method to get RecordTypeId for campaign */ 
    
    public static id getCampaignRecordTypeId(String selectedChannel)
    {
      RecordType rt; 
      String rId=''; 
      if(selectedChannel!=null || selectedChannel!='')
       {         
            CRM_CampaignWizardReferenceData__c objCRMChannelVal = [Select id,CRM_Channel__c ,CRM_IsTargeted__c  FROM CRM_CampaignWizardReferenceData__c WHERE id=:selectedChannel];
            IF(objCRMChannelVal.CRM_IsTargeted__c)
            {
             rt = [select id from RecordType where developerName='Targeted'];
             rId=rt.id;
            }
            else
            {
             rt = [select id from RecordType where developerName='Non_Targeted'];
             rId=rt.id;
            }   
       } 
     return  rId; 
    }
    
    /*End -Method to get RecordTypeId for campaign */
    
    /*Start -Method to genratecampaign Name */ 
    
    public Static string getCampaignName(id Campid)
    {   
       string campname_value1;
        String camp_name;
        boolean nameFlag;
        Location__c hpCode ;
      
        String  campname_value='101'; 
        integer i=1;
        integer campcount;
        integer EncCount;
        integer incrementedCount;
        campaign name1;
        Campaign CampName;
       // DateTime campname_creatDate;
        //campname_value=campname_value+i;
        system.debug('@@@@@@@'+ campname_value);
        //i++;
        /******** For clone Campaign ******/
        if(Campid!=null)
        {
            CampName=[Select Id,name,NameCounter__c,count_of_index__c,CreatedDate,Service_Line__c,CRM_SubServiceLineText__c,Sub_Service_Line__c,Channel__c,Audience_Hospital__c,Audience__c,Audience_Region__c, Version__c,CRM_OwnershipType__c,CRM_SelectedOwnershipCriteria__c,CRM_ParentSegmentedCampaign__c,segment__c from Campaign where id =:Campid][0];
              
        }
        
        System.debug('^^^^^'+CampName); 
     /* if(CampName.CreatedDate==null)
          campname_creatDate=datetime.now();
        else
            campname_creatDate=CampName.CreatedDate;  */
        Date  campname_creatDate=Date.today();  
        System.debug('%%%%%%Camp Date'+campname_creatDate);
        //date  campname_Date=date.newInstance(campname_creatDate.year(),campname_creatDate.month(),campname_creatDate.day());
           String  campname_Date  =DateTime.newInstance(campname_creatDate.year(),campname_creatDate.month(),campname_creatDate.day()).format('YYYYMMdd');
        System.debug('%%%%%%campname_Date'+campname_Date); 
        string campname_creatDate1=campname_Date;
       
        campcount=[Select Count() from Campaign where CreatedDate =today ];        
      
        system.debug('##### IF ###');
          //nameFlag=false;
          CampaignSequencer__c Cs= CampaignSequencer__c.getOrgDefaults();
          if(campcount!=0 )
          {
          
                List<CampaignSequencer__c> CsVal = CampaignSequencer__c.getall().values();      
                String LastModiDate= DateTime.newInstance(CsVal[0].LastModifiedDate.year(),CsVal[0].LastModifiedDate.month(),CsVal[0].LastModifiedDate.day()).format('M/d/YYYY');
                system.debug('******CsVal[0].LastModifiedDate***'+LastModiDate);     
                system.debug('******Date.today().format()***'+Date.today().format());
           
                
                if(campcount==1 || CsVal[0].Counter_Value__c==999)
                {
                
                   if(LastModiDate==Date.today().format() && CsVal[0].Counter_Value__c>=101 && CsVal[0].Counter_Value__c!=999 )
                   {
                    Cs.Counter_Value__c= Cs.Counter_Value__c+1;
                    update Cs; 
                     
                   }
                   else
                   {
                    Cs.Counter_Value__c= 101;
                    update Cs;
                   }
                    List<CampaignSequencer__c> CsV = CampaignSequencer__c.getall().values();      
                    CampName.count_of_index__c=string.valueof(integer.valueof(CsV[0].Counter_Value__c));
                    campname_value1 =string.valueof(integer.valueof(CsV[0].Counter_Value__c));           
                    system.debug('####Counter_Value__c### '+integer.valueof(CsV[0].Counter_Value__c));  
                }
                else
                {
                    Cs.Counter_Value__c= Cs.Counter_Value__c+1;
                    update Cs;                      
                    List<CampaignSequencer__c> CsV = CampaignSequencer__c.getall().values();      
                    CampName.count_of_index__c=string.valueof(integer.valueof(CsV[0].Counter_Value__c));
                    campname_value1 =string.valueof(integer.valueof(CsV[0].Counter_Value__c));           
                    system.debug('####Counter_Value__c### '+integer.valueof(CsV[0].Counter_Value__c));
                }
                    
          }
          else
          {
            system.debug('I am else');
            system.debug('in else cond....campname_value when campcount is zero=========='+campname_value);
            campname_value1=campname_value;
            system.debug('in else cond....campname_value1 when campcount is zero=========='+campname_value1);
            CampName.count_of_index__c=campname_value1;
            
            Cs.Counter_Value__c= 101;
            update Cs;
          }            
        
        
        /**** for null values check ****/
        if(CampName.CRM_ParentSegmentedCampaign__c==null){
        if(CampName.CRM_OwnershipType__c=='Hospital' && CampName.CRM_SelectedOwnershipCriteria__c==null)
        {
          CampName.Audience_Hospital__c=null;
          system.debug('*****' + CampName.CRM_SelectedOwnershipCriteria__c);
        }
        
        if(CampName.CRM_OwnershipType__c=='Region' && CampName.CRM_SelectedOwnershipCriteria__c==null)
        {
          CampName.Audience_Region__c=null;
          system.debug('*****'+CampName.Audience_Region__c);
        }
        
        if(CampName.CRM_OwnershipType__c=='Market' && CampName.CRM_SelectedOwnershipCriteria__c==null)
        {
          CampName.Audience__c=null;
          system.debug('*****');
        }
        }
        if(CampName.Version__c=='' || CampName.Version__c==null)
        {
          CampName.Version__c=null;
          system.debug('*****');
        }
        
        

        /***** Multiple selection & Fetching the hospital code **********/      
      if(CampName.CRM_SelectedOwnershipCriteria__c.contains(',') && CampName.CRM_ParentSegmentedCampaign__c==null)
        {
            system.debug('I am in if of naming convention');
            if(CampName.CRM_OwnershipType__c=='Hospital' )
            {
                system.debug('I am true hospital multi');
                CampName.Audience_Hospital__c='MH';
                system.debug('^^^^^^MH'+CampName.Audience_Hospital__c);
            }
                   
            
            if(CampName.CRM_OwnershipType__c=='Region' )
            {
                system.debug('I am true region multi');
                CampName.Audience_Region__c='MR';
                system.debug('^^^^^^MR'+CampName.Audience_Region__c);
            }
           
            if(CampName.CRM_OwnershipType__c=='Market' )
            {
                system.debug('I am true market multi');
                system.debug('market cloned value@@@'+CampName.CRM_SelectedOwnershipCriteria__c);
                CampName.Audience__c='MM';
                system.debug('^^^^^^MM'+CampName.Audience__c);
            }
                        
            if(campname_value1!=null && nameFlag==false)
            {
            //campname_value1= campname_value1.right(3);
            system.debug('#####'+campname_value1); 
            }
            else if(campname_value1!=null && nameFlag==true)
            {
                campname_value1=name1.count_of_index__c;
                system.debug('##### count'+campname_value1);
            }
            
            /*** criteria ****/
            //region null & market null
            
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
             else if(campname_value1!=null && CampName.Audience_Region__c!='' &&  CampName.Audience__c==null && CampName.Audience_Hospital__c==null && CampName.Service_Line__c!=null && CampName.Channel__c!=null && CampName.Channel__c!='')
            {
              camp_name=campname_creatDate1+'-'+campname_value1+'-'+CampName.Audience_Region__c+'-'+CampName.Service_Line__c+'-'+CampName.Channel__c+(CampName.Version__c!=null?'-V'+CampName.Version__c : '');  
              system.debug('@@@@@ hospital null & version null'+camp_name);
            }
            //no value null
           else
            {
              camp_name=campname_creatDate1+'-'+campname_value1+'-'+ CampName.Audience_Region__c +'-'+CampName.Audience__c+'-'+CampName.Audience_Hospital__c+'-'+CampName.Service_Line__c+'-'+CampName.Channel__c+(CampName.Version__c!=null?'-V'+CampName.Version__c : '');  
              system.debug('@@@@@ no value null'+camp_name);
            }

        }
        else
        {
            system.debug('I am in else of naming convention');
            
            system.debug('$$$$$CampName'+CampName);
            if(campName.CRM_ParentSegmentedCampaign__c==null){
             List<CRM_CampaignLocationReferenceData__c> lstregionname = [select CRM_Region__c, CRM_Market__c, CRM_HospitalCode__c from CRM_CampaignLocationReferenceData__c where (CRM_RegionCode__c =: CampName.CRM_SelectedOwnershipCriteria__c OR CRM_MarketCode__C =: CampName.CRM_SelectedOwnershipCriteria__c OR CRM_HospitalCode__c =: CampName.CRM_SelectedOwnershipCriteria__c)AND recordTypeId=:ReferenceData_PicklistController.recordTypeId('CRM_CampaignLocationReferenceData__c' , campName.CRM_OwnershipType__c) ]; 
          system.debug('@@@lstregionnameSize'+ lstregionname );
          
          //  List<Location__c> lsthpcode = [select HSPCD__c from Location__c where Hospital__c=:CampName.Audience_Hospital__c];
         
        // List <String> hospitalval =campname.CRM_SelectedOwnershipCriteria__c.split(',');
          
            if(CampName.CRM_OwnershipType__c=='Hospital' )
            {
            system.debug('@@@selectedownership size'+ CampName.CRM_SelectedOwnershipCriteria__c );
          
               CRM_CampaignLocationReferenceData__c hospitalname = lstregionname[0];
               system.debug('@@@regionannme'+ hospitalname );
                String hospitalname1= String.valueOf(hospitalname.CRM_HospitalCode__c); 
            CampName.Audience_Hospital__c=hospitalname1;
            system.debug('@@@CampName.Audience_Hospital__c'+ CampName.Audience_Hospital__c );
              CampName.Audience_Region__c=null;
            CampName.Audience__c=null;
            }
          if(CampName.CRM_OwnershipType__c=='Region' )
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
                CampName.Audience_Region__c=regionname;
                }
                system.debug('@@@CampName.Audience_Region__c'+ CampName.Audience_Region__c );
                CampName.Audience__c=null;
                CampName.Audience_Hospital__c=null;
            }
            if(CampName.CRM_OwnershipType__c=='Market' )
            {
          CRM_CampaignLocationReferenceData__c marketname = lstregionname[0];
                system.debug('@@@regionannme'+ marketname );
                String marketname_1= String.valueOf(marketname.CRM_Market__c);
                system.debug('@@@regionname'+ marketname_1 );
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
                CampName.Audience__c=marketname_1;
                }
                CampName.Audience_Hospital__c=null;
                CampName.Audience_Region__c=null;
            }
            }
            //campname_value1= campname_value1.right(3);
            //system.debug('#####'+campname_value1);
            system.debug('#####campname_value1'+campname_value1); 
            system.debug('#####nameFlag'+nameFlag); 
            
            if(campname_value1!=null && nameFlag==false)
            {
            campname_value1= campname_value1.right(3);
            system.debug('#####'+campname_value1); 
            }
            else if(campname_value1!=null && nameFlag==true)
            {
                campname_value1=name1.count_of_index__c;
                  system.debug('ehrn nameflag is true...count_of_index__c====='+ CampName.count_of_index__c);
                system.debug('ehrn nameflag is true...campname_value1====='+ campname_value1);
                system.debug('##### count'+campname_value1);
            }
           
            system.debug('#####campname_value1'+campname_value1); 
            system.debug('#####CampName'+CampName); 
           
            
            /*** criteria ****/
            //region null & market null
        if(campName.CRM_ParentSegmentedCampaign__c==null)
        {
           if(campname_value1!=null && CampName.Audience_Region__c==null &&  CampName.Audience__c==null && CampName.Audience_Hospital__c!='' && CampName.Service_Line__c!=null && CampName.Channel__c!=null && CampName.Channel__c!='')
            {
                camp_name=campname_creatDate1+'-'+campname_value1+'-'+CampName.Audience_Hospital__c+'-'+CampName.Service_Line__c+'-'+CampName.Channel__c+'-V'+CampName.Version__c;  
                system.debug('@@@@ camp_name1'+camp_name);
            }   
            //hospital null & region null  
            else if(campname_value1!=null && CampName.Audience_Region__c==null  && CampName.Audience__c!='' && CampName.Audience_Hospital__c==null && CampName.Service_Line__c!=null && CampName.Channel__c!=null && CampName.Channel__c!='')
            {
              camp_name=campname_creatDate1+'-'+campname_value1+'-'+CampName.Audience__c+'-'+CampName.Service_Line__c+'-'+CampName.Channel__c+'-V'+CampName.Version__c;  
              system.debug('@@@@@ camp_name2'+camp_name);
            }
            //hospital null & market null  
            else if(campname_value1!=null && CampName.Audience_Region__c!='' &&  CampName.Audience__c==null && CampName.Audience_Hospital__c==null && CampName.Service_Line__c!=null && CampName.Channel__c!=null && CampName.Channel__c!='')
            {
              camp_name=campname_creatDate1+'-'+campname_value1+'-'+CampName.Audience_Region__c+'-'+CampName.Service_Line__c+'-'+CampName.Channel__c+'-V'+CampName.Version__c;  
              system.debug('@@@@@ camp_name3'+camp_name);
            }
            //no value null
       }
       else if(campName.CRM_ParentSegmentedCampaign__c!=null)
       {
                camp_name='SEG'+campname_creatDate1+'-'+campname_value1; 
                system.debug('@@@@@ camp_name4'+camp_name);
       }
     }
        
        System.debug('%%%%%% name concatination'+camp_name);    
        if(camp_name.length()>80 ){
         
        ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Info,Label.Campiagn_Name_Convention);
            Apexpages.addMessage(msg); 
        
           
        }
        
        
       return camp_name;
     
    }
    
    /*End -Method to genratecampaign Name */ 
}
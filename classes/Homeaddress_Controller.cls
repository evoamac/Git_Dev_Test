public class Homeaddress_Controller{
    
    public String[] bydistancevar{get;set;}
    string campId;
    public List<SelectOption> searchCriteriaLevel3{get;set;}
    public List<SelectOption> searchCriteriaLevel2{get;set;}
    public String dynamicLabel{get;set;}
    public string codes{get;set;}
    public string codesexclude{get;set;}
    public List <string> ZipcodeValues{get;set;}
    public string withindistanceval{get;set;}
    public boolean showServiceArea{get;set;}
    public map<Id,string> selectedSAText{get;set;}
    public String[] selectedVal {get;set;}
    public String[] selectedServiceArea {get;set;}
    public String[] selectedSearchCriteriaLevel2 {get;set;}
    public campaign objcamp{get;set;} //PP4 chnage
    
    public List<SelectOption> serviceAreaList{get{
       
       list<SelectOption> saList = new List<SelectOption>();
       if(selectedSAText==null)
            selectedSAText = new map<Id,string>();
       
        for(CRM_CampaignLocationReferenceData__c loc: [select id, CRM_ServiceArea__c from CRM_CampaignLocationReferenceData__c where RecordTypeId=:ReferenceData_PicklistController.recordTypeId('CRM_CampaignLocationReferenceData__c','ServiceArea') AND CRM_ServiceArea__c!=null AND CRM_IsActive__c=true order by CRM_ServiceAreaSortOrder__c asc]){
            saList.add(new SelectOption(loc.id,loc.CRM_ServiceArea__c));
            selectedSAText.put(loc.id,loc.CRM_ServiceArea__c);
        }
        return saList;
    }set;}
    
    public CRM_Search_Criteria__c selectedSearchCriteria{get;set;}
    map<string,id> recordTypeMap;
    //set<string> stateName;
    
    public Homeaddress_Controller(ApexPages.StandardController controller){
        
        campId=ApexPages.currentPage().getParameters().get('id');
        objcamp = (Campaign) controller.getRecord();//PP4 chnage
        objcamp=[Select CRM_ParentSegmentedCampaign__c from campaign where id=:campId];//PP4 chnage
        selectedSearchCriteria = new CRM_Search_Criteria__c();
        
        showServiceArea=false;
        bydistancevar = new string[]{};
        searchCriteriaLevel2 = new List<SelectOption>();
        searchCriteriaLevel3 = new List<SelectOption>();
        
        selectedServiceArea = new String[]{};
        selectedSearchCriteriaLevel2 = new String[]{};
     selectedVal = new String[]{};
     
        recordTypeMap = new map<string,id>();
    
        for(RecordType rt : [select developerName,id from RecordType where sObjectType='CRM_CampaignGeographyReferenceData__c' OR sObjectType='CRM_CampaignLocationReferenceData__c']){
            recordTypeMap.put(rt.developerName,rt.id);
        }
      
      if(!string.isBlank(campId))
        fetchSavedCriteria();
      //By Hospital should be default selection             
      if(selectedSearchCriteria.CRM_Search_Criteria_Level_1__c==null){
        selectedSearchCriteria.CRM_Search_Criteria_Level_1__c='By Hospital';
        refreshSearchLevel2();
      }
      
    }
    
    void fetchSavedCriteria(){
      for(CRM_Search_Criteria__c crms : [select id,CRM_Campaign__c,CRM_Search_Criteria_Level_1__c,CRM_Search_Criteria_Level_2__c,CRM_Search_Criteria_Level_3__c,CRM_AdditionalZipCodes__c,CRM_ExcludedZipCodes__c from CRM_Search_Criteria__c where CRM_Campaign__c=:campId]){
        selectedSearchCriteria = crms;
      }
      if(selectedSearchCriteria!=null){
        
        codes = selectedSearchCriteria.CRM_AdditionalZipCodes__c;
        codesexclude = selectedSearchCriteria.CRM_ExcludedZipCodes__c;
        
        string sl = selectedSearchCriteria.CRM_Search_Criteria_Level_1__c;
        
        if(sl=='By Region' || sl=='By Market' || sl=='By Hospital'){
          refreshSearchLevel2();refreshSearchLevel3();
          id recordTypeIds = sl=='By Region'?recordTypeMap.get('Region'):sl=='By Market'?recordTypeMap.get('Market'):recordTypeMap.get('Hospital');
          list<string> saCode = selectedSearchCriteria.CRM_Search_Criteria_Level_2__c.split(';');
          for(CRM_CampaignLocationReferenceData__c clrs : [select id,CRM_ServiceAreaCode__c from CRM_CampaignLocationReferenceData__c where CRM_ServiceAreaCode__c IN: saCode AND CRM_IsActive__c=true AND recordTypeId=:recordTypeMap.get('ServiceArea')]){
            selectedServiceArea.add(clrs.id);
          }
          
          list<string> level3Codes = selectedSearchCriteria.CRM_Search_Criteria_Level_3__c.split(';');
          for(CRM_CampaignLocationReferenceData__c clrs : [select id from CRM_CampaignLocationReferenceData__c where (CRM_HospitalCode__c IN: level3Codes OR CRM_MarketCode__c IN: level3Codes OR CRM_RegionCode__c IN: level3Codes) AND CRM_IsActive__c=true AND recordTypeId=:recordTypeIds]){
            selectedSearchCriteriaLevel2.add(clrs.id);
          }
          
        }
        if(sl=='By Distance'){
          refreshSearchLevel2();
          withindistanceval = selectedSearchCriteria.CRM_Search_Criteria_Level_2__c;
          id recordTypeIds = recordTypeMap.get('Hospital');
          list<string> level3Codes = selectedSearchCriteria.CRM_Search_Criteria_Level_3__c.split(';');
          for(CRM_CampaignLocationReferenceData__c clrs : [select id from CRM_CampaignLocationReferenceData__c where CRM_HospitalCode__c IN: level3Codes AND CRM_IsActive__c=true AND recordTypeId=:recordTypeIds]){
            selectedSearchCriteriaLevel2.add(clrs.id);
          }
        }
        if(sl=='By State' || sl=='By County' || sl=='By CBSA'){
          refreshSearchLevel2();
          id recordTypeIds = sl=='By State'?recordTypeMap.get('State'):sl=='By County'?recordTypeMap.get('State'):recordTypeMap.get('CBSA');
          list<string> saCode = selectedSearchCriteria.CRM_Search_Criteria_Level_2__c.split(';');
          for(CRM_CampaignGeographyReferenceData__c clrs : [select id from CRM_CampaignGeographyReferenceData__c where (CRM_StateCode__c IN: saCode OR CRM_CBSA__c IN: saCode) AND CRM_IsActive__c=true AND recordTypeId=:recordTypeIds]){
            selectedSearchCriteriaLevel2.add(clrs.id);
          }
          
          
          if(selectedSearchCriteria.CRM_Search_Criteria_Level_3__c!=null){
            refreshSearchLevel3();  
            list<string> level3Codes = selectedSearchCriteria.CRM_Search_Criteria_Level_3__c.split(';');
            system.debug('****selectedVal='+level3Codes);
            for(CRM_CampaignGeographyReferenceData__c clrs : [select id from CRM_CampaignGeographyReferenceData__c where CRM_CountysStateID__c IN:selectedSearchCriteriaLevel2 AND CRM_County__c IN: level3Codes AND CRM_IsActive__c=true]){
              selectedVal.add(clrs.id);
            }
            
            system.debug('****selectedVal='+selectedVal);
          }
          
          
        }
        
      }
    }
    
    public void refreshSearchLevel2(){
        
        if(selectedSAText!=null)
            selectedSAText.clear();
        else
            selectedSAText=new map<id,string>();
        
        showServiceArea=false;    
        searchCriteriaLevel2.clear();searchCriteriaLevel3.clear();selectedSearchCriteriaLevel2.clear();
        selectedVal.clear(); selectedServiceArea.clear(); //zipcodesexclude.clear();codes='';codesexclude='';
        
        system.debug('L2******='+selectedSearchCriteria.CRM_Search_Criteria_Level_1__c);
       
        if(selectedSearchCriteria.CRM_Search_Criteria_Level_1__c!=null){
            
            string queryString;
            id recordTypeId;
            if(selectedSearchCriteria.CRM_Search_Criteria_Level_1__c=='By Region'){
                showServiceArea=true;
                dynamicLabel='Regions: ';
                recordTypeId=recordTypeMap.get('Region');                               
                queryString='select id,CRM_Region__c from CRM_CampaignLocationReferenceData__c where RecordTypeId=:recordTypeId AND CRM_Region__c!=null and CRM_IsActive__c=true  order by CRM_Region__c asc';
               system.debug('queryString='+queryString);
            }else if(selectedSearchCriteria.CRM_Search_Criteria_Level_1__c=='By Market'){
                 showServiceArea=true;
                 recordTypeId=recordTypeMap.get('Market');
                 dynamicLabel='Markets: ';
                 system.debug('recordTypeId=))'+recordTypeId);
               queryString='select id,CRM_MarketRegion__c from CRM_CampaignLocationReferenceData__c where RecordTypeId=:recordTypeId AND CRM_Market__c!=null and CRM_IsActive__c=true order by CRM_MarketRegion__c asc';
                //system.debug('queryString='+queryString[0].CRM_Market__c);
            }else if(selectedSearchCriteria.CRM_Search_Criteria_Level_1__c=='By Hospital'){
                showServiceArea=true;
                dynamicLabel='Hospitals: ';
                recordTypeId=recordTypeMap.get('Hospital');
                queryString='select id,CRM_HospitalMarket__c from CRM_CampaignLocationReferenceData__c where RecordTypeId=:recordTypeId AND  CRM_Hospital__c!=null and CRM_IsActive__c=true order by CRM_HospitalMarket__c  asc';
            }else if(selectedSearchCriteria.CRM_Search_Criteria_Level_1__c=='By State' || selectedSearchCriteria.CRM_Search_Criteria_Level_1__c=='By County'){
                showServiceArea=false;
                recordTypeId=recordTypeMap.get('State');
                dynamicLabel='States: ';
                queryString='select id,CRM_State__c from CRM_CampaignGeographyReferenceData__c  where RecordTypeId=:recordTypeId AND CRM_State__c!=null and CRM_IsActive__c=true order by CRM_State__c asc';
          //  }else if(selectedSearchCriteria.CRM_Search_Criteria_Level_1__c=='By County'){
           //     recordTypeId=recordTypeMap.get('County');
           //     queryString='select CRM_County__c from CRM_CampaignGeographyReferenceData__c  where RecordTypeId=:recordTypeId AND CRM_County__c!=null group by CRM_County__c order by CRM_County__c asc';
            }else if(selectedSearchCriteria.CRM_Search_Criteria_Level_1__c=='By CBSA'){
                showServiceArea=false;
                dynamicLabel='CBSAs: ';
                recordTypeId=recordTypeMap.get('CBSA');
                queryString='select id,CRM_CBSA__c from CRM_CampaignGeographyReferenceData__c where RecordTypeId=:recordTypeId AND CRM_CBSA__c!=null and CRM_IsActive__c=true order by CRM_CBSA__c asc';
            }else if(selectedSearchCriteria.CRM_Search_Criteria_Level_1__c=='By Distance'){
                showServiceArea=false;
                dynamicLabel='of Hospitals: ';
                recordTypeId=recordTypeMap.get('Hospital');
                queryString='select id,CRM_Hospital__c,CRM_HospitalMarket__c from CRM_CampaignLocationReferenceData__c where RecordTypeId=:recordTypeId AND CRM_Hospital__c !=null and CRM_IsActive__c=true order by CRM_HospitalMarket__c asc';
            }
            //system.debug('Database.query(queryString)****'+Database.query(queryString));
            //searchCriteriaLevel2
            for(sObject sr:Database.query(queryString)){
                string option='';
                if(selectedSearchCriteria.CRM_Search_Criteria_Level_1__c=='By Region'){
                    option=(string)sr.get('CRM_Region__c');
                    selectedSAText.put((id)sr.get('id'),(string)sr.get('CRM_Region__c'));
                    
                }else if(selectedSearchCriteria.CRM_Search_Criteria_Level_1__c=='By Market'){
                    option=(string)sr.get('CRM_MarketRegion__c');
                    selectedSAText.put((id)sr.get('id'),(string)sr.get('CRM_MarketRegion__c'));
                }else if(selectedSearchCriteria.CRM_Search_Criteria_Level_1__c=='By Hospital'){
                    //if((string)sr.get('CRM_ServiceArea__c')!='Other')
                        option=(string)sr.get('CRM_HospitalMarket__c');
                        selectedSAText.put((id)sr.get('id'),(string)sr.get('CRM_HospitalMarket__c'));
                }else if(selectedSearchCriteria.CRM_Search_Criteria_Level_1__c=='By State' || selectedSearchCriteria.CRM_Search_Criteria_Level_1__c=='By County'){
                    option=(string)sr.get('CRM_State__c');
                    selectedSAText.put((id)sr.get('id'),(string)sr.get('CRM_State__c'));             
                }else if(selectedSearchCriteria.CRM_Search_Criteria_Level_1__c=='By CBSA'){
                    option=(string)sr.get('CRM_CBSA__c');
                    selectedSAText.put((id)sr.get('id'),(string)sr.get('CRM_CBSA__c'));
                }else if(selectedSearchCriteria.CRM_Search_Criteria_Level_1__c=='By Distance'){
                     //We should call level3 method
                    // option.add(new SelectOption((string)sr.get('CRM_Market__c')+' — '+(string)sr.get('CRM_Hospital__c'),(string)sr.get('CRM_Market__c')+' — '+(string)sr.get('CRM_Hospital__c')));
                     option=(string)sr.get('CRM_HospitalMarket__c');
                     selectedSAText.put((id)sr.get('id'),(string)sr.get('CRM_HospitalMarket__c'));
                }   
                    
                system.debug('option)))***'+option);

                if(!string.isBlank(option))    
                    searchCriteriaLevel2.add(new SelectOption((string)sr.get('id'),option));
            }
           
        }else{
            searchCriteriaLevel2.clear();
            searchCriteriaLevel3.clear();
        }
    
    }
    
    public void refreshSearchLevel3(){
        system.debug('L3******='+selectedSearchCriteria.CRM_Search_Criteria_Level_1__c);
        searchCriteriaLevel3.clear();
        
        string queryString;
        id recordTypeId;
        integer recordCounter=searchCriteriaLevel3.size();
        if(selectedSearchCriteriaLevel2.size()>0){
          set<string> oldIds = new set<string>();
          oldIds.addAll(selectedVal);
          selectedVal.clear();
            
            system.debug('*****=selected---'+selectedSearchCriteriaLevel2);
            if(selectedSearchCriteria.CRM_Search_Criteria_Level_1__c=='By Hospital'){
                recordTypeId=recordTypeMap.get('ServiceArea');
                queryString='select id,CRM_HospitalMarket__c  from CRM_CampaignLocationReferenceData__c where RecordTypeId=:recordTypeId AND CRM_ServiceArea__c IN:selectedSearchCriteriaLevel2 AND CRM_IsActive__c=true order by CRM_HospitalMarket__c asc';
            }else if(selectedSearchCriteria.CRM_Search_Criteria_Level_1__c=='By County'){
                recordTypeId=recordTypeMap.get('County');
                queryString='select id,CRM_StateCounty__c  from CRM_CampaignGeographyReferenceData__c WHERE RecordTypeId=:recordTypeId  AND CRM_CountysStateID__c IN:selectedSearchCriteriaLevel2 AND CRM_IsActive__c=true AND CRM_County__c !=null  order by CRM_StateCounty__c asc';
                system.debug('queryString%%%==='+queryString);
            }
            system.debug('**selectedSAText='+selectedSAText.size());
            if(!string.isBlank(queryString)){
                for(sObject sr:Database.query(queryString)){
                  system.debug('size of level 3==='+sr);
                       
                    string option='';
                    if(selectedSearchCriteria.CRM_Search_Criteria_Level_1__c=='By Hospital'){
                        option=(string)sr.get('CRM_HospitalMarket__c');
                        selectedSAText.put((id)sr.get('id'),(string)sr.get('CRM_HospitalMarket__c'));
                    }else if(selectedSearchCriteria.CRM_Search_Criteria_Level_1__c=='By County'){                
                        option=(string)sr.get('CRM_StateCounty__c');
                        selectedSAText.put((id)sr.get('id'),(string)sr.get('CRM_StateCounty__c'));
                        
                    }
                    
                    if(!string.isBlank(option)){
                      if(searchCriteriaLevel3.size()<1000){    
                          searchCriteriaLevel3.add(new SelectOption((string)sr.get('id'),option));
                          if(oldIds.contains((string)sr.get('id')))
                            selectedVal.add((string)sr.get('id'));
                      }
                    }
                  
                    system.debug('size of level 3==='+option+'****='+selectedSAText);
                    recordCounter++;
                }
                system.debug('**selectedSAText='+selectedSAText.size());
                system.debug('**selectedVal='+selectedVal);
                
            }
            
        }else{
            searchCriteriaLevel3.clear();
        }
        
        if(recordCounter>1000){
            ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Info,Label.CRM_Picklist_Size_Limit_A+ ' ' +recordCounter+' '+ Label.CRM_Picklist_Size_Limit_B);
            Apexpages.addMessage(msg);          
        }
    }
    
    public pagereference saveHomeAddressSearch(){

      //selectedSearchCriteria.CRM_Search_Criteria_Level_1__c=='By Region'
      PageReference pg;
       if(selectedSearchCriteria.CRM_Campaign__c==null)
          selectedSearchCriteria.CRM_Campaign__c= campId;
        selectedSearchCriteria.CRM_AdditionalZipCodes__c= parseZipCodes(codes);
        selectedSearchCriteria.CRM_ExcludedZipCodes__c= parseZipCodes(codesexclude);

      string errorMessage=validateSearch();
      
      if(string.isBlank(errorMessage)){
        try{
          
          set<string> zipcodeSet=new set<string>();
          string sl=selectedSearchCriteria.CRM_Search_Criteria_Level_1__c;
          if(sl=='By Region' || sl=='By Market' || sl=='By Hospital')
            zipcodeSet = searchResult(sl,selectedServiceArea,selectedSearchCriteriaLevel2);
          if(sl=='By Distance')
            zipcodeSet = searchResult(sl,new list<string>{withindistanceval},selectedSearchCriteriaLevel2);
          if(sl=='By State' || sl=='By County' || sl=='By CBSA')
              zipcodeSet = searchResult(sl,selectedSearchCriteriaLevel2,selectedVal);
            
            if(zipcodeSet.size()>0 || (!string.isBlank(selectedSearchCriteria.CRM_AdditionalZipCodes__c))){
              if(!string.isBlank(selectedSearchCriteria.CRM_AdditionalZipCodes__c)){
                for(string str : selectedSearchCriteria.CRM_AdditionalZipCodes__c.split(';')){
                  zipcodeSet.add(str);
                }
              }
              
              //Now remove excluded zip codes from search result
              if(!string.isBlank(selectedSearchCriteria.CRM_ExcludedZipCodes__c)){
                for(string str : selectedSearchCriteria.CRM_ExcludedZipCodes__c.split(';')){
                  if(zipcodeSet.contains(str))
                    zipcodeSet.remove(str);
                }
                
              }
              
              if(zipcodeSet.size()>0){
                //This check will make sure we do not have more than qualified limit of zip codes for wunderman request
                if(zipcodeSet.size()<=9000){
                  //This method will get entity code and set to level 2 and level 3 fields
                  setSearchCriteriaCodes();
                  
                  upsert selectedSearchCriteria;
                  
                  list<string> zipcodeList = new list<string>();
                  zipcodeList.addAll(zipcodeSet);
                  string valuesCSV = String.join(zipcodeList, ';');
                  if(!string.isBlank(valuesCSV)) 
                    CampaignMemberCriteriaManager.insertCriteria('ZipCode__c',valuesCSV, campId, false, 'Campaign_Location__c');
                  else
                    if(([SELECT id FROM Campaign_Member_Criteria__c WHERE Campaign__c=:campId and Exclude__c=false limit 1]).size()>0)
                           CampaignMemberCriteriaManager.deleteCriteria('ZipCode__c', campId, false);
                           
                  /*if(!string.isBlank(selectedSearchCriteria.CRM_ExcludedZipCodes__c))
                        CampaignMemberCriteriaManager.insertCriteria('ZipCode__c',selectedSearchCriteria.CRM_ExcludedZipCodes__c, campId, true, 'Campaign_Location__c');
                      else{
                         if(([SELECT id FROM Campaign_Member_Criteria__c WHERE Campaign__c=:campId and Exclude__c=true limit 1]).size()>0)
                           CampaignMemberCriteriaManager.deleteCriteria('ZipCode__c', campId, true);
                      }
                      */  
                    //start of PP4 chnage
                    if(objcamp.CRM_ParentSegmentedCampaign__c==null){
                  pg = new PageReference('/apex/CampaignWizard?id='+campId+'&stepNo=3');
                    }
                    else{
                     pg = new PageReference('/apex/CampaignWizard?id='+campId+'&stepNo=2');   
                    }
                    //end of PP4 chnage
                }else{
                  Apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.WARNING,Label.CRM_Zip_Code_Threshold_Limit));
                }
              }else{//
                Apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.WARNING,Label.CRM_Search_Result_Message));
              }
            }else{
              Apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.WARNING,Label.CRM_Search_Result_Message));
            }
          }catch(Exception ex){
            Apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR,Label.CRM_Home_Address_Exception_Message+':'+ex.getMessage()));
          }
          
      }else{
        
            Apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.WARNING,errorMessage));   
      }
      return pg;
   }
   
   string validateSearch(){
     string errorMessage;
     if(selectedSearchCriteria.CRM_Search_Criteria_Level_1__c==null && string.isBlank(selectedSearchCriteria.CRM_AdditionalZipCodes__c)){
       errorMessage = Label.CRM_Home_Address_Include;
       
       if(!string.isBlank(selectedSearchCriteria.CRM_ExcludedZipCodes__c))
         errorMessage = Label.CRM_Home_Address_Exclude;
         
     }else if(selectedSearchCriteria.CRM_Search_Criteria_Level_1__c!=null){
       if(selectedSearchCriteria.CRM_Search_Criteria_Level_1__c=='By Region' || selectedSearchCriteria.CRM_Search_Criteria_Level_1__c=='By Market' || selectedSearchCriteria.CRM_Search_Criteria_Level_1__c=='By Hospital')
         if(selectedServiceArea.size()==0 || selectedSearchCriteriaLevel2.size()==0)
           errorMessage=Label.CRM_Home_Address_Validation;
       
       if(selectedSearchCriteria.CRM_Search_Criteria_Level_1__c=='By State')
         if(selectedSearchCriteriaLevel2.size()==0)
           errorMessage=Label.CRM_Home_Address_Validation_State;
       
       if(selectedSearchCriteria.CRM_Search_Criteria_Level_1__c=='By County')
         if(selectedVal.size()==0)
           errorMessage=Label.CRM_Home_Address_Validation_County;
       
       if(selectedSearchCriteria.CRM_Search_Criteria_Level_1__c=='By CBSA')
         if(selectedSearchCriteriaLevel2.size()==0)
           errorMessage=Label.CRM_Home_Address_Validation_CBSA;
           
       if(selectedSearchCriteria.CRM_Search_Criteria_Level_1__c=='By Distance'){
         if(string.isBlank(withindistanceval))
           errorMessage=Label.CRM_Home_Address_Distance;
         else if(selectedSearchCriteriaLevel2.size()==0)
           errorMessage=Label.CRM_Home_Address_Distance_Hospital;
         //else if(selectedSearchCriteriaLevel2.size()>1)
           //errorMessage=Label.CRM_Home_Address_Distance_Only_One_Hospital;
       }
     }
     
     string invalidZipCodes;
     if(!string.isBlank(selectedSearchCriteria.CRM_AdditionalZipCodes__c)){
           for(string str : selectedSearchCriteria.CRM_AdditionalZipCodes__c.split(';')){
             if(str.length()!=5 || !str.isNumeric()){
               if(string.isBlank(invalidZipCodes))
                 invalidZipCodes = str;
               else
                 invalidZipCodes += ', '+str;
             }
           }
      }
          
      if(!string.isBlank(selectedSearchCriteria.CRM_ExcludedZipCodes__c)){
           for(string str : selectedSearchCriteria.CRM_ExcludedZipCodes__c.split(';')){
             if(str.length()!=5 || !str.isNumeric()){
               if(string.isBlank(invalidZipCodes))
                 invalidZipCodes = str;
               else
                 invalidZipCodes += ', '+str;
             }
           }
      }
          
      if(!string.isBlank(invalidZipCodes))
           errorMessage = Label.CRM_Invalid_Zip_Codes+invalidZipCodes;
     
     return errorMessage;
   }
  
  string parseZipCodes(string zipCodes){
    if(!string.isBlank(zipCodes)){
      zipCodes = zipCodes.replaceAll(',',';').replaceAll(' ',';').replaceAll('\r\n',';');
      while(zipCodes.IndexOf(';;')!=-1)
        zipCodes = zipCodes.replaceAll(';;',';');
    }
    return zipCodes;
  } 
  
  void setSearchCriteriaCodes(){
    string sl = selectedSearchCriteria.CRM_Search_Criteria_Level_1__c;
    selectedSearchCriteria.CRM_Search_Criteria_Level_2__c=null;
      selectedSearchCriteria.CRM_Search_Criteria_Level_3__c=null;
      
      if(sl=='By Region' || sl=='By Market' || sl=='By Hospital'){
        for(CRM_CampaignLocationReferenceData__c clrs : [select id,CRM_ServiceAreaCode__c from CRM_CampaignLocationReferenceData__c where id IN: selectedServiceArea]){
          if(selectedSearchCriteria.CRM_Search_Criteria_Level_2__c==null)
            selectedSearchCriteria.CRM_Search_Criteria_Level_2__c=clrs.CRM_ServiceAreaCode__c;
          else
            selectedSearchCriteria.CRM_Search_Criteria_Level_2__c +=';'+clrs.CRM_ServiceAreaCode__c;
        }
        
        for(CRM_CampaignLocationReferenceData__c clrs : [select id,CRM_HospitalCode__c,CRM_MarketCode__c,CRM_RegionCode__c from CRM_CampaignLocationReferenceData__c where id IN: selectedSearchCriteriaLevel2]){
          string str = sl=='By Region'?clrs.CRM_RegionCode__c:sl=='By Market'?clrs.CRM_MarketCode__c:sl=='By Hospital'?clrs.CRM_HospitalCode__c:'';
          
          if(selectedSearchCriteria.CRM_Search_Criteria_Level_3__c==null)
            selectedSearchCriteria.CRM_Search_Criteria_Level_3__c=str;
          else
            selectedSearchCriteria.CRM_Search_Criteria_Level_3__c +=';'+str;
        }
      }
      if(sl=='By Distance'){
        system.debug('****='+selectedSearchCriteriaLevel2);
        selectedSearchCriteria.CRM_Search_Criteria_Level_2__c=withindistanceval;
        for(CRM_CampaignLocationReferenceData__c clrs : [select id,CRM_HospitalCode__c from CRM_CampaignLocationReferenceData__c where id IN: selectedSearchCriteriaLevel2]){
          system.debug('****='+clrs);
          system.debug('****='+selectedSearchCriteria.CRM_Search_Criteria_Level_3__c);
          if(selectedSearchCriteria.CRM_Search_Criteria_Level_3__c==null)
            selectedSearchCriteria.CRM_Search_Criteria_Level_3__c=clrs.CRM_HospitalCode__c;
          else
            selectedSearchCriteria.CRM_Search_Criteria_Level_3__c +=';'+clrs.CRM_HospitalCode__c;
        }
        
      }
      if(sl=='By State' || sl=='By County' || sl=='By CBSA'){
        for(CRM_CampaignGeographyReferenceData__c clrs : [select id,CRM_StateCode__c,CRM_CBSA__c,CRM_County__c from CRM_CampaignGeographyReferenceData__c where id IN: selectedSearchCriteriaLevel2]){
          string str = sl=='By State'?clrs.CRM_StateCode__c:sl=='By County'?clrs.CRM_StateCode__c:sl=='By CBSA'?clrs.CRM_CBSA__c:'';
          
          if(selectedSearchCriteria.CRM_Search_Criteria_Level_2__c==null)
            selectedSearchCriteria.CRM_Search_Criteria_Level_2__c=str;
          else
            selectedSearchCriteria.CRM_Search_Criteria_Level_2__c +=';'+str;
        }
        
        for(CRM_CampaignGeographyReferenceData__c clrs : [select id,CRM_County__c from CRM_CampaignGeographyReferenceData__c where id IN: selectedVal]){
          if(selectedSearchCriteria.CRM_Search_Criteria_Level_3__c==null)
            selectedSearchCriteria.CRM_Search_Criteria_Level_3__c=clrs.CRM_County__c;
          else
            selectedSearchCriteria.CRM_Search_Criteria_Level_3__c +=';'+clrs.CRM_County__c;
        }
      }  
  }
  
  public static set<string> searchResult(string sl, list<string> sl2,list<string> sl3){
    set<string> zipcodeSet=new set<string>();
    //string sl = selectedSearchCriteria.CRM_Search_Criteria_Level_1__c;
    if(sl=='By Region' || sl=='By Market' || sl=='By Hospital'){
      string query='select id,CRM_HZSAsZipID__r.CRM_ZipCode__c from CRM_Hospital_Zip_ServiceArea_Ref_Data__c where CRM_HZSAsZipID__r.CRM_IsActive__c=true AND CRM_IsActive__c=true AND CRM_HZSAsServiceAreaID__c IN:sl2';
      if(sl=='By Region')
        query +=' AND CRM_HZSAsHospitalID__r.CRM_HospitalsMarketID__r.CRM_MarketsRegionID__c IN:sl3';
      if(sl=='By Market')
        query +=' AND CRM_HZSAsHospitalID__r.CRM_HospitalsMarketID__c IN:sl3';
      if(sl=='By Hospital')
        query +=' AND CRM_HZSAsHospitalID__c IN:sl3';
        
      for(sObject sr:Database.query(query)){
        if(sr.getSobject('CRM_HZSAsZipID__r')!=null)
          zipcodeSet.add((string)(sr.getSobject('CRM_HZSAsZipID__r').get('CRM_ZipCode__c')));
      }
        
      system.debug('****='+query);
    }
    if(sl=='By Distance'){
      boolean orCondition=false;
      String queryString = 'SELECT CRM_ZipCode__c ' +
      'FROM CRM_ZipCodeReferenceData__c ' +
      'WHERE CRM_IsActive__c=true AND (';
      for(CRM_CampaignLocationReferenceData__c hsl :[SELECT CRM_HospitalLocation__c,CRM_HospitalLocation__Latitude__s,CRM_HospitalLocation__Longitude__s FROM CRM_CampaignLocationReferenceData__c where id =: sl3 AND CRM_IsActive__c=true]){
        if(orCondition)
          queryString += ' OR ';
          
        queryString +='DISTANCE(CRM_Location__c, GEOLOCATION('+hsl.CRM_HospitalLocation__Latitude__s+','+hsl.CRM_HospitalLocation__Longitude__s+'), \'mi\') <'+integer.valueOf(sl2[0]);
        orCondition=true;
      }
      queryString += ')';
      
      for(CRM_ZipCodeReferenceData__c sr: Database.query(queryString)){
        zipcodeSet.add((string)sr.get('CRM_ZipCode__c'));
      }
      
    }
    if(sl=='By State' || sl=='By CBSA' || sl=='By County'){
      string query='select id,CRM_ZipCode__c from CRM_ZipCodeReferenceData__c where CRM_IsActive__c=true';
      if(sl=='By State')
        query +=' AND CRM_ZipsCountyID__r.CRM_CountysStateID__c IN:sl2';
      if(sl=='By CBSA')
        query +=' AND CRM_ZipsCBSAID__c IN:sl2';
      if(sl=='By County')
        query +=' AND CRM_ZipsCountyID__c IN:sl3';
      
      for(sObject sr:Database.query(query)){
        zipcodeSet.add((string)sr.get('CRM_ZipCode__c'));
      }
        
    }
    
    
    return zipcodeSet;
  }
     
   public pagereference Cancel(){
      pagereference ref;
       //start of PP4 chnage
       if(objcamp.CRM_ParentSegmentedCampaign__c==null){
      ref= new PageReference('/apex/CampaignWizard?id='+campId+'&stepNo=3');
       }
       else{
          ref = new PageReference('/apex/CampaignWizard?id='+campId+'&stepNo=2');
       }
       //end of PP4 chnage
       return ref;
   }
   
   public pagereference deleteCriteria(){
     pagereference ref;
     //delete [select id from Campaign_Member_Criteria__c WHERE Campaign__c=:campId AND Field_Name__c='ZipCode__c'];
     for(Campaign_Member_Criteria__c cm : [SELECT id,Exclude__c FROM Campaign_Member_Criteria__c WHERE Campaign__c=:campId AND Field_Name__c='ZipCode__c']){
      CampaignMemberCriteriaManager.deleteCriteria('ZipCode__c', campId, cm.Exclude__c);
    }
     delete [select id from CRM_Search_Criteria__c where CRM_Campaign__c=:campId];
      if(objcamp.CRM_ParentSegmentedCampaign__c==null){
          ref= new PageReference('/apex/CampaignWizard?id='+campId+'&stepNo=3');
      }
       else{
           ref= new PageReference('/apex/CampaignWizard?id='+campId+'&stepNo=2');
       }
      return  ref;
   } 
   
}
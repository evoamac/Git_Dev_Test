/*
    Created By: Amit Dahiya
    Created Date: 15 November 2016
    Description: This controller will be used to add location to a campaing on the basis of Geography By Service Line Area
*/
public with sharing class Include_Diagnosis_Controller 
{
    //Variable Declaration
    public boolean exclude {get;set;}
    string campId{get;set;}
    public string encounterid{get;set;}
    public ICD_Diagnosis__c geo{get;set;}
    public list<SelectOption> typeDiagnosisList{get;set;}
    public string selectedDiangnosisType{get;set;}
    public string selectedDiagnosisCode{get;set;}
    public string selectedLongDesc{get;set;}
    public boolean showSearchResult{get;set;}
    list<WrapSearchResult> searchResult{get;set;}
    public ApexPages.StandardSetController setCon{get;set;}
    public Integer pageSize{get;set;}
    set<Integer> visitedPage{get;set;}
    public Integer noOfRecords{get; set;}
    set<id> selectedLocationSet;
    map<id,ICD_Diagnosis_In__c> existingLocationMap;
    public boolean selectAll{get;set;}
    map<id,ICD_Diagnosis__c> masterSearchResult;
    public boolean masterSelectAll{get;set;}
    //Constructure
    public Include_Diagnosis_Controller(ApexPages.StandardController controller){
        campId=ApexPages.currentPage().getParameters().get('id');
        encounterid=ApexPages.currentPage().getParameters().get('encounter');
        exclude=ApexPages.currentPage().getParameters().get('exclude')==null?false:true;
        system.debug('^^^^campId'+campId);
        showSearchResult=false;
        pageSize= 10;
        selectAll=false;
        masterSelectAll=false;
        
        typeDiagnosisList = new List<SelectOption>();
        typeDiagnosisList.add(new SelectOption('',''));
        typeDiagnosisList.add(new SelectOption('ICD9','ICD9'));
        typeDiagnosisList.add(new SelectOption('ICD10','ICD10'));   
    }
    
    void handleExistingRecords(map<id,ICD_Diagnosis__c> masterSearchResult){
        //Existing location records
        existingLocationMap = new map<id,ICD_Diagnosis_In__c>();
        selectedLocationSet = new set<id>();
        for(ICD_Diagnosis_In__c cmpLoc : [select id,ICD_Diagnosis__c,Campaign__c from ICD_Diagnosis_In__c where Campaign__c=:campId and Exclude__c=:exclude AND ICD_Diagnosis__c IN: masterSearchResult.keySet()]){
            existingLocationMap.put(cmpLoc.ICD_Diagnosis__c,cmpLoc);
            
            //put the existing records in selectMap so that we do not need to handle it seprately
            selectedLocationSet.add(cmpLoc.ICD_Diagnosis__c);
        }
    }
    //Search will be performed on the basis of selected criteria
    public void searchLocation(){
        if(string.isBlank(selectedDiangnosisType) && string.isBlank(selectedDiagnosisCode) && string.isBlank(selectedLongDesc)){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Please select atleast one filter criteria !!'));
        }else{
            
            //Prepare query on the basis of search chriteria entered by user
            string searchQuery = 'select DIAGNOSIS_CODE__c,Long_Description__c,Group_Indicator__c,Short_Description__c,Type_Of_Diagnosis__c from ICD_Diagnosis__c ';
            string limitedsearchQuery = 'select DIAGNOSIS_CODE__c,Long_Description__c,Group_Indicator__c,Short_Description__c,Type_Of_Diagnosis__c from ICD_Diagnosis__c ';
            list<String> lstWhereLocCondition=new list<string>();
            selectAll=false;
            masterSelectAll=false;
            visitedPage=null;
            
            if(string.isNotBlank(selectedDiagnosisCode))
                lstWhereLocCondition.add(' DIAGNOSIS_CODE__c Like \'%'+selectedDiagnosisCode+ '%\'');
           
            if(string.isNotBlank(selectedDiangnosisType))
                lstWhereLocCondition.add(' Type_Of_Diagnosis__c Like \'%'+selectedDiangnosisType+ '%\'');
            
            if(string.isNotBlank(selectedLongDesc))
                lstWhereLocCondition.add(' Long_Description__c Like \'%'+selectedLongDesc+ '%\'');
            
            if(lstWhereLocCondition.size()>0){
                searchQuery += ' WHERE ' + String.join(lstWhereLocCondition,' AND ');
                limitedsearchQuery += ' WHERE ' + String.join(lstWhereLocCondition,' AND ');
            }
             searchQuery +=' Limit 48000';
             limitedsearchQuery +=' Limit 1500';
            //Put a limit on record in case user only select Type of Diagnosis, because there are 80000 records for ICSD9 and ICSD10 and it also affect viewstate
           // if(string.isNotBlank(selectedDiangnosisType) && string.isBlank(selectedDiagnosisCode) && string.isBlank(selectedLongDesc))
                //searchQuery +=' Limit 1500';
            list<ICD_Diagnosis__c> locList = new  list<ICD_Diagnosis__c> ();
            list<ICD_Diagnosis__c> limitedlocList = new  list<ICD_Diagnosis__c> ();
            try{
                //THis list will be used when saving records
                masterSearchResult=new map<id,ICD_Diagnosis__c>();
                locList = Database.Query(searchQuery);
                limitedlocList = Database.Query(limitedsearchQuery);
                masterSearchResult.putAll(limitedlocList);
                if(locList.size()>1500)
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, '1500 records can be shown out of '+locList.size()+' Please narrow down the criteria.'));
                
                //reset selectedLocationSet
                handleExistingRecords(masterSearchResult);
            
                setCon = new ApexPages.StandardSetController(limitedlocList);
                setCon.setPageSize(pageSize);  
                noOfRecords = setCon.getResultSize();
                if(noOfRecords>0)
                    showSearchResult=true;
                else{
                    showSearchResult=false;
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'No matching record found. Please check search filter.'));
                }
                
            }catch(Exception ex){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'There is some issue with this page. Please contact your system admin.'));
            } 
        }
    }
    //SearchResult per page list
    public list<WrapSearchResult> getsearchResult() {
         searchResult = new list<WrapSearchResult>();
         system.debug('=******='+setCon.getResultSize());
         for(sObject loc:setCon.getRecords()){
            ICD_Diagnosis__c lo = (ICD_Diagnosis__c)loc;
            if(selectAll){
                if(visitedPage!=null && visitedPage.contains(setCon.getPageNumber())){
                    if(selectedLocationSet.contains(lo.id))
                        searchResult.add(new WrapSearchResult(lo,true));
                    else{
                        searchResult.add(new WrapSearchResult(lo,false));
                    }       
                }else{
                    searchResult.add(new WrapSearchResult(lo,true));
                }
            }else{
                if(selectedLocationSet.contains(lo.id) && !masterSelectAll)
                    searchResult.add(new WrapSearchResult(lo,true));
                else
                    searchResult.add(new WrapSearchResult(lo,false));
            }
            
         }
         return searchResult; 
    }
    // returns the first page of records
    public void first() {
        handleSeletedLocation();
        setCon.first();
    }

    // returns the last page of records
    public void last() {
        handleSeletedLocation();
        setCon.last();
    }

    // returns the previous page of records
    public void previous() {
        handleSeletedLocation();
        setCon.previous();
    }

    // returns the next page of records
    public void next() {
        handleSeletedLocation();
        setCon.next();
    }
    
    //manage selected locations
    void handleSeletedLocation(){
        if(selectAll){
            if(visitedPage==null)
                visitedPage=new set<Integer>();
            visitedPage.add(setCon.getPageNumber());
        }
        for(WrapSearchResult wrap:searchResult){
            if(wrap.isSelected){
                selectedLocationSet.add(wrap.lo.id);
            }else{
                if(selectedLocationSet.contains(wrap.lo.id))
                    selectedLocationSet.remove(wrap.lo.id);
                
                 if(masterSearchResult.containsKey(wrap.lo.id))
                    masterSearchResult.remove(wrap.lo.id);
                   
            }
                
        }
    }
    //save selected location under this campaign
    public PageReference saveDemographicServiceArea(){
        PageReference ref;
        try{
            saveServiceArea();
            if(encounterid!=null)
                ref=new Pagereference('/apex/EncountersPage?btn=1&Id='+campId+'&encounter='+encounterid );
           else
                ref = new pagereference('/apex/EncountersPage?btn=1&Id='+campId );
            
           ref.setredirect(true);
           
           
        }catch(Exception ex){           
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage()));
        }
        return ref;
    }
    public void saveServiceArea(){
        
        try{
                      
           list<ICD_Diagnosis_In__c> insertNewServiceArea = new list<ICD_Diagnosis_In__c>();
           list<ICD_Diagnosis_In__c> deleteServiceArea = new list<ICD_Diagnosis_In__c>();
           
           //This iterration is only for current page
           for(WrapSearchResult wrap:searchResult){
              if(wrap.isSelected){
                    selectedLocationSet.add(wrap.lo.id);
              }else{
                    if(selectedLocationSet.contains(wrap.lo.id)){
                        selectedLocationSet.remove(wrap.lo.id);
                    }
                    masterSearchResult.remove(wrap.lo.id);
              }
           }
           
           if(selectAll){
                for(id locId :masterSearchResult.keySet()){
                    if(!selectedLocationSet.contains(locId))
                        selectedLocationSet.add(locid);
                }                
           }else if(!selectAll && masterSelectAll){//This case is when user search and existing rcords come in search and then user select and then unselect all checkbox
                selectedLocationSet.clear();
                masterSelectAll=false;
           }    
       
           //This itteration is for all the selected records
           for(id locId : selectedLocationSet){
                if(!existingLocationMap.containsKey(locId)){
                    ICD_Diagnosis_In__c campLoc = new ICD_Diagnosis_In__c();
                    campLoc.Campaign__c=campId;
                    campLoc.ICD_Diagnosis__c=locid;
                    campLoc.Exclude__c = exclude;
                    insertNewServiceArea.add(campLoc);
                }
           }
           
           //In case existing record is unselected by user then that record will be deleted
           for(id camLoc : existingLocationMap.keySet()){
                if(!selectedLocationSet.contains(camLoc)){
                    deleteServiceArea.add(existingLocationMap.get(camLoc));
                }
           }
           
           if(insertNewServiceArea.size()<=0 && deleteServiceArea.size()<=0){
                if(existingLocationMap.size()>0){
                    //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Warning,'These Record/s are already saved'));
                    throw new ApplicationException('These Record/s are already saved');
                }else{
                    //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Warning,'No Record/s are selected'));
                    throw new ApplicationException('No Record/s are selected');
                }
                
           }
           
           // code for inserting criteria for wundermanapi callouts
           Boolean hasGeoRecordsAlready = false;
           List<ICD_Diagnosis_In__c> lstICDDiagnosis = new List<ICD_Diagnosis_In__c> ();
           lstICDDiagnosis = [SELECT id FROM ICD_Diagnosis_In__c WHERE Campaign__c=:campid AND exclude__c=:exclude Limit 1];
           if(lstICDDiagnosis.size()>0) hasGeoRecordsAlready = true;
           else hasGeoRecordsAlready = false;
           
           if(insertNewServiceArea.size()>0)
                insert insertNewServiceArea;
           
           boolean isCalloutEventTypeDelete=false;
                
           if(deleteServiceArea.size()>0){
                database.delete(deleteServiceArea,false);
                
                if(([SELECT id FROM ICD_Diagnosis_In__c WHERE Campaign__c=:campId AND exclude__c=:exclude limit 1]).size()==0)
                    isCalloutEventTypeDelete=true;
           }    
            
                        
           // code for inserting criteria for wundermanapi callouts
           Campaign objCampaignForAPI;
           List<Campaign> lstCampaign = [SELECT Wunderman_Sync__c  FROM Campaign WHERE id=:campId];
           if(lstCampaign.size()>0) objCampaignForAPI = lstCampaign[0];
           objCampaignForAPI.Wunderman_Sync__c  = 'Pending';
           update objCampaignForAPI;
           
           if(isCalloutEventTypeDelete)
               CampaignMemberCriteriaManager.deleteCriteria('Diagnosis_Codes__c',campId, exclude);
           else
           {
               String[] stringList = new String[0];
               for(ICD_Diagnosis_In__c diagnosis : [SELECT Diagnosis_Code__c,Type_Of_Diagnosis__c FROM ICD_Diagnosis_In__c WHERE campaign__c=:campId and Exclude__c=:exclude]) 
                   stringList.add(diagnosis.Type_Of_Diagnosis__c+'DIAG_'+diagnosis.Diagnosis_Code__c);                   
               string valuesCSV = String.join(stringList, ';');
               if(!hasGeoRecordsAlready)
                    CampaignMemberCriteriaManager.insertCriteria('Diagnosis_Code__c',valuesCSV, campId, exclude, 'ICD_Diagnosis_In__c');
               else
                    CampaignMemberCriteriaManager.updateCriteria('Diagnosis_Code__c',valuesCSV, campId, exclude);
           }
           CampaignMemberCriteriaManager.setAddOnExclusionCriterias(campId);
               
               
        }catch(Exception ex){           
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'There is some problem. Please contact your system administrator'));
            throw new ApplicationException(ex.getMessage());
        }
        
    }
    
     public class ApplicationException extends Exception {}
    
    public void quickSave(){
        
        try{
            saveServiceArea();
            //reset selectedLocationSet
            //handleExistingRecords(masterSearchResult);
            searchLocation();
        }catch(Exception ex){           
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage()));
        }
        
    }
    
    //Back to Audience Selection tab
    public pagereference cancel(){
        pagereference ref;
        if(encounterid!=null){
            ref=new Pagereference('/apex/EncountersPage?btn=1&Id='+campId+'&encounter='+encounterid );
        }else{
            ref=new Pagereference('/apex/EncountersPage?btn=1&Id='+campId );
        }
        ref.setredirect(true);  
        return ref;
        
    }
    public void clearSearch(){
        selectedDiangnosisType=null;
        selectedDiagnosisCode=null;
        selectedLongDesc=null;
    }
    
    public class WrapSearchResult{
        public ICD_Diagnosis__c lo{get;set;}
        public boolean isSelected{get;set;}
        public integer index{get;set;}
        
        public WrapSearchResult(ICD_Diagnosis__c l,boolean flag){
            lo=l;
            isSelected=flag;
        }
        
    }
}
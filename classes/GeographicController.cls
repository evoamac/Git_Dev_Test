/*
    Created By: Amit Dahiya
    Created Date: 12 November 2016
    Description: This controller will be used to add location to a campaing on the basis of Geography By Service Line Area
*/
public with sharing class GeographicController {
    //Variable Declaration
    string campId{get;set;}
    public Geographic__c geo{get;set;}
    public list<SelectOption> stateList{get;set;}
    public list<SelectOption> CBSAList{get;set;}
    public string selectedState{get;set;}
    public string selectedCBSA{get;set;}
    public string selectedCounty{get;set;}
    public boolean showSearchResult{get;set;}
    public string selectedbutton{get;set;}
    list<WrapSearchResult> searchResult{get;set;}
    public ApexPages.StandardSetController setCon{get;set;}
    public Integer pageSize{get;set;}
    set<Integer> visitedPage{get;set;}
    public Integer noOfRecords{get; set;}
    set<id> selectedLocationSet;
    map<id,Geographic_Info_Information__c> existingLocationMap;
    public boolean selectAll{get;set;}
    map<id,Geographic__c> masterSearchResult;
    public boolean masterSelectAll{get;set;}
    //Constructure
    public GeographicController(ApexPages.StandardController controller){
        campId=ApexPages.currentPage().getParameters().get('id');
        system.debug('^^^^campId'+campId);
        showSearchResult=false;
        pageSize= 10;
        selectAll=false;
        masterSelectAll=false;
        preparePiclistFields();
    }
    
    //Prepare piclist fields for search criteria
    void preparePiclistFields(){
        stateList = new list<SelectOption>();
        CBSAList = new list<SelectOption>();
        
        stateList.add(new SelectOption('','--None--'));
        CBSAList.add(new SelectOption('','--None--'));
        
        for(AggregateResult loc: [select State__c from Geographic__c where State__c != null group by State__c order by State__c asc]){
            stateList.add(new SelectOption((string)loc.get('State__c'),(string)loc.get('State__c')));
        }
        
        for(AggregateResult loc: [Select CBSA_Name__c from CBSA_values__c where CBSA_Name__c != null group by CBSA_Name__c order by CBSA_Name__c asc]){
            CBSAList.add(new SelectOption((string)loc.get('CBSA_Name__c'),(string)loc.get('CBSA_Name__c')));
        }
        
    }
    
    void handleExistingRecords(map<id,Geographic__c> masterSearchResult){
        //Existing location records
        existingLocationMap = new map<id,Geographic_Info_Information__c>();
        selectedLocationSet = new set<id>();
        system.debug('*****'+masterSearchResult.size());
        for(Geographic_Info_Information__c cmpLoc : [select id,Geographic_Info__c,Campaign__c,ZipCode__c from Geographic_Info_Information__c where Campaign__c=:campId AND Geographic_Info__c IN: masterSearchResult.keySet()]){
            existingLocationMap.put(cmpLoc.Geographic_Info__c,cmpLoc);
            system.debug('&&&&existingLocationMap'+existingLocationMap);
            //put the existing records in selectMap so that we do not need to handle it seprately
            selectedLocationSet.add(cmpLoc.Geographic_Info__c);
        }
        system.debug(selectedLocationSet.size()+'*****'+existingLocationMap.size());
    }
    //Search will be performed on the basis of selected criteria
    public void searchLocation(){
        if(string.isBlank(selectedState) && string.isBlank(selectedCBSA) && string.isBlank(selectedCounty)){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Please select atleast one filter criteria !!'));
        }else if(string.isNotBlank(selectedCBSA) && (string.isNotBlank(selectedState) || string.isNotBlank(selectedCounty))){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select only one criteria for searching !!'));
        }else{
            
            //Prepare query on the basis of search chriteria entered by user
            string searchQuery = 'Select City__c,CBSA__c,State__c,StateFIPS__c,ZipCode__c, County__c from Geographic__c';
            list<String> lstWhereLocCondition=new list<string>();
            selectAll=false;
            masterSelectAll=false;
            visitedPage=null;
            if(string.isNotBlank(selectedCBSA))
                lstWhereLocCondition.add(' CBSA__c Like \'%'+selectedCBSA+ '%\'');
           
            if(string.isNotBlank(selectedState))
                lstWhereLocCondition.add(' State__c Like \'%'+selectedState+ '%\'');
            
            if(string.isNotBlank(selectedCounty))
                lstWhereLocCondition.add(' County__c Like \'%'+selectedCounty+ '%\'');
            
            if(lstWhereLocCondition.size()>0){
                searchQuery += ' WHERE ' + String.join(lstWhereLocCondition,' AND ');
            }
            
            try{
                //THis list will be used when saving records
                masterSearchResult=new map<id,Geographic__c>();
                list<Geographic__c> locList = Database.Query(searchQuery);
                masterSearchResult.putAll(locList);
                
                //reset selectedLocationSet
                handleExistingRecords(masterSearchResult);
                
                setCon = new ApexPages.StandardSetController(locList);
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
         system.debug('=******='+selectAll);
         for(sObject loc:setCon.getRecords()){
            Geographic__c lo = (Geographic__c)loc;
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
          ref=new pagereference('/apex/CampaignCriteria_Geographies?Id='+campId);
            ref.setredirect(true);
           
        }catch(Exception ex){           
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage()));
        }
        return ref;
    }
    
    //save selected location under this campaign
    public void saveServiceArea(){
        
        try{
                      
           list<Geographic_Info_Information__c> insertNewServiceArea = new list<Geographic_Info_Information__c>();
           set<string> zipCodSet = new set<string>();
           
           //This iterration is only for current page
           for(WrapSearchResult wrap:searchResult){
              if(wrap.isSelected){
                    selectedLocationSet.add(wrap.lo.id);
                  system.debug('selectedLocationSet******'+selectedLocationSet);
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
                    Geographic_Info_Information__c campLoc = new Geographic_Info_Information__c();
                    campLoc.Campaign__c=campId;
                    campLoc.Geographic_Info__c=locid;
                    campLoc.Audience_Search_Type__c='Geography By Boundary';
                    insertNewServiceArea.add(campLoc);
                }
           }
           
           //In case existing record is unselected by user then that record will be deleted
           for(id camLoc : existingLocationMap.keySet()){
                if(!selectedLocationSet.contains(camLoc)){
               system.debug('selectedLocationSet****^^^'+selectedLocationSet);
                    zipCodSet.add(existingLocationMap.get(camLoc).ZipCode__c);
               system.debug('zipCodSet****^^^'+zipCodSet);
                }
           }
          
            if(insertNewServiceArea.size()<=0 && zipCodSet.size()<=0){
                if(existingLocationMap.size()>0){
                    //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Warning,'These Record/s are already saved'));
                    throw new ApplicationException('These Record/s are already saved');
                }else{
                    //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Warning,'No Record/s are selected'));
                    throw new ApplicationException('No Record/s are selected');
                }
                
            } 
            
             // logic to verify if its update or insert operation for wunderman API callouts
           Boolean hasGeoRecordsAlready = false;
           List<Geographic_Info_Information__c> lstexistingGeoRecords = new List<Geographic_Info_Information__c> ();
           lstexistingGeoRecords = [SELECT id FROM Geographic_Info_Information__c WHERE Campaign__c=:campid];
           if(lstexistingGeoRecords.size()>0) hasGeoRecordsAlready = true;
           else hasGeoRecordsAlready = false;
           System.debug('*****lstexistingGeoRecords***'+lstexistingGeoRecords+'***hasGeoRecordsAlready *****'+hasGeoRecordsAlready);
           
           
            system.debug('&&&&insertNewServiceArea'+insertNewServiceArea);
            if(insertNewServiceArea.size()>0)
                insert insertNewServiceArea;
                
           boolean isCalloutEventTypeDelete=false;
           //when user delete any record, all records with same zipcode should be deleted     
           if(zipCodSet.size()>0){
                list<Geographic_Info_Information__c> deleteServiceArea = new list<Geographic_Info_Information__c>();
                for(Geographic_Info_Information__c cl:[select id from Geographic_Info_Information__c where Campaign__c=:campId AND ZipCode__c IN: zipCodSet]){
                    deleteServiceArea.add(cl);
                }
                database.delete(deleteServiceArea,false);
                
                if(([SELECT id FROM Geographic_Info_Information__c WHERE Campaign__c=:campid limit 1]).size()==0)
                    isCalloutEventTypeDelete=true;
           } 
           
           if(campId!=null){
                Campaign objCampaignForAPI=new Campaign(id=campId,Wunderman_Sync__c = 'Pending');
                update objCampaignForAPI;
           }
                
           
           if(isCalloutEventTypeDelete)
                CampaignMemberCriteriaManager.deleteCriteria('ZipCode__c', campId, false);
           else 
           {    
                String[] stringList = new String[0];
                Set<string> zipCodeSet = new set<String>();
                for(Geographic_Info_Information__c  geoInfo : [SELECT ZipCode__c FROM Geographic_Info_Information__c where campaign__c=:campId]) 
                    zipCodeSet.add(geoInfo.ZipCode__c);                   
                stringList.addAll(zipCodeSet);
                string valuesCSV = String.join(stringList, ';'); 
                if(!hasGeoRecordsAlready)
                    CampaignMemberCriteriaManager.insertCriteria('ZipCode__c',valuesCSV, campId, false, 'Geographic_Info_Information__c');
                else
                    CampaignMemberCriteriaManager.updateCriteria('ZipCode__c',valuesCSV, campId, false);
           }
             
        }
        catch(Exception ex){           
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
        ref=new pagereference('/apex/CampaignCriteria_Geographies?Id='+campId);
        ref.setredirect(true);  
        return ref;
        
    }
    
    public class WrapSearchResult{
        public Geographic__c lo{get;set;}
        public boolean isSelected{get;set;}
        public integer index{get;set;}
        
        public WrapSearchResult(Geographic__c l,boolean flag){
            lo=l;
            isSelected=flag;
        }
        
    }
   
}
/*
    Created By: Amit Dahiya
    Created Date: 12 November 2016
    Description: This controller will be used to add location to a campaing on the basis of Geography By Service Line Area
*/
public with sharing class AddLocation_ByServiceArea_Controller {
    //Variable Declaration
    string campId{get;set;}
    public list<SelectOption> regionList{get;set;}
    public list<SelectOption> marketList{get;set;}
    public list<SelectOption> hospitalList{get;set;}
    public list<SelectOption> serviceAreList{get;set;}
    public string selectedRegion{get;set;}
    public string selectedMarket{get;set;}
    public string selectedHospital{get;set;}
    public string selectedZipCode{get;set;}
    public list<SelectOption> selectedServiceArea{get;set;}
    public boolean showSearchResult{get;set;}
    list<WrapSearchResult> searchResult{get;set;}
    public ApexPages.StandardSetController setCon{get;set;}
    public Integer pageSize{get;set;}
    set<Integer> visitedPage{get;set;}
    public Integer noOfRecords{get; set;}
    set<id> selectedLocationSet;
    map<id,Campaign_Location__c> existingLocationMap;
    public boolean selectAll{get;set;}
    map<id,Location__c> masterSearchResult;
    public string selectedbutton{get;set;}
    public boolean masterSelectAll{get;set;}
    //Constructure
    public AddLocation_ByServiceArea_Controller(ApexPages.StandardController controller){
        campId=ApexPages.currentPage().getParameters().get('id');
        system.debug('^^^^campId'+campId);
        showSearchResult=false;
        selectedServiceArea = new list<SelectOption>();
         system.debug('^^^^selectedServiceArea'+selectedServiceArea);
        pageSize= 10;
        selectAll=false;
        masterSelectAll=false;
        preparePiclistFields();
    }
    
    //Prepare piclist fields for search criteria
   public void preparePiclistFields(){
        regionList = new list<SelectOption>();
        marketList = new list<SelectOption>();
        hospitalList = new list<SelectOption>();
        serviceAreList = new list<SelectOption>();
        
        regionList.add(new SelectOption('','--None--'));
        marketList.add(new SelectOption('','--None--'));
        hospitalList.add(new SelectOption('','--None--'));
        for(AggregateResult loc: [select Region__c from Location__c where Region__c != null group by Region__c order by Region__c asc]){
            regionList.add(new SelectOption((string)loc.get('Region__c'),(string)loc.get('Region__c')));
        }
        
        for(AggregateResult loc: [select Market__c from Location__c where Market__c != null group by Market__c order by Market__c asc]){
            marketList.add(new SelectOption((string)loc.get('Market__c'),(string)loc.get('Market__c')));
        }
        
        for(AggregateResult loc: [select Hospital__c from Location__c where Hospital__c != null group by Hospital__c order by hospital__c asc]){
            hospitalList.add(new SelectOption((string)loc.get('Hospital__c'),(string)loc.get('Hospital__c')));
        }
        
        for(AggregateResult loc: [select Service_Area__c from Location__c where Service_Area__c != null group by Service_Area__c order by Service_Area__c desc]){
            if(loc.get('Service_Area__c')!='Other')
                serviceAreList.add(new SelectOption((string)loc.get('Service_Area__c'),(string)loc.get('Service_Area__c')));
        }
        //Custom sorting
        serviceAreList.sort();
        //serviceAreList.add(new SelectOption('Other','Other'));
        
        
    }
    
    public void handleExistingRecords(map<id,Location__c> masterSearchResult){
        //Existing location records
        existingLocationMap = new map<id,Campaign_Location__c>();
        selectedLocationSet = new set<id>();
        system.debug('*****'+masterSearchResult.size());
        for(Campaign_Location__c cmpLoc : [select id,Location__c,Campaign__c,Zip_Code__c from Campaign_Location__c where Campaign__c=:campId AND Location__c IN: masterSearchResult.keySet()]){
            existingLocationMap.put(cmpLoc.Location__c,cmpLoc);
            system.debug('***Location__c='+cmpLoc);
            //put the existing records in selectMap so that we do not need to handle it seprately
            selectedLocationSet.add(cmpLoc.Location__c);
        }
        system.debug(selectedLocationSet.size()+'*****'+existingLocationMap.size());
    }
    //Search will be performed on the basis of selected criteria
    public void searchLocation(){
        if(string.isBlank(selectedRegion) && string.isBlank(selectedMarket) && string.isBlank(selectedHospital) && string.isBlank(selectedZipCode) && (selectedServiceArea==null || selectedServiceArea.size()==0)){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Please select atleast one filter criteria !!'));
        }else{
            
            //Prepare query on the basis of search chriteria entered by user
            string searchQuery = 'SELECT region__c , hospital__c , market__c , Zip_Code__c , Service_Area__c FROM location__c';
            list<String> lstWhereLocCondition=new list<string>();
            selectAll=false;
            masterSelectAll=false;
            visitedPage=null;
            if(selectedHospital!=null)
                lstWhereLocCondition.add(' hospital__c Like\'%'+String.escapeSingleQuotes(selectedHospital)+ '%\'');     
                       
            if(selectedMarket!=null)
                lstWhereLocCondition.add(' market__c Like \'%'+selectedMarket+ '%\'');
           
            if(selectedRegion!=null )
                lstWhereLocCondition.add(' region__c Like \'%'+selectedRegion+ '%\'');
            
            if(String.isNotBlank(selectedZipCode)){
              list<string> zipCodeList = selectedZipCode.deleteWhitespace().split(',');
                lstWhereLocCondition.add(' Zip_Code__c IN:zipCodeList');
            }
            
            if(selectedServiceArea!=null ){
                system.debug('slectedsericeArea');
                set<string> serviceAreaWhereCondition = new set<string>();
                for(selectOption s: selectedServiceArea)
                    serviceAreaWhereCondition.add(string.valueOf(s.getvalue()));
                   system.debug('serviceAreaWhereCondition@@@@'+serviceAreaWhereCondition);
                if(serviceAreaWhereCondition.size()>0)
                    lstWhereLocCondition.add(' Service_Area__c IN: serviceAreaWhereCondition');
            }
            
            if(lstWhereLocCondition.size()>0){
                searchQuery += ' WHERE ' + String.join(lstWhereLocCondition,' AND ');
            }
            
            try{
                //THis list will be used when saving records
                masterSearchResult=new map<id,Location__c>();
                system.debug('searcgquery============'+ searchQuery);
                list<Location__c> locList = Database.Query(searchQuery);
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
         system.debug('*****='+masterSelectAll);
         for(sObject loc:setCon.getRecords()){
            Location__c lo = (Location__c)loc;
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
         System.debug('#######searchResult'+searchResult);
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
   public void handleSeletedLocation(){
        
        if(selectAll){
            if(visitedPage==null)
                visitedPage=new set<Integer>();
            visitedPage.add(setCon.getPageNumber());
        }
        System.debug('@@@@@@@@@searchResult'+searchResult);
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
    @TestVisible
    void saveServiceArea(){
        
        try{
                      
           list<Campaign_Location__c> insertNewServiceArea = new list<Campaign_Location__c>();
           set<string> zipCodSet = new set<string>();
           //This iterration is only for current page
           for(WrapSearchResult wrap:searchResult){
              if(wrap.isSelected){
              system.debug('****wrap****'+wrap);
              
                    selectedLocationSet.add(wrap.lo.id);
              }else{
              system.debug('****selectedLocationSet****'+selectedLocationSet);
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
                //existingLocationMap.clear();
                masterSelectAll=false;
           }   
            system.debug('****selectedLocationSet='+selectedLocationSet);
           //This itteration is for all the selected records
           for(id locId : selectedLocationSet){
                if(!existingLocationMap.containsKey(locId)){
                    Campaign_Location__c campLoc = new Campaign_Location__c();
                    campLoc.Campaign__c=campId;
                    campLoc.Location__c=locid;
                    insertNewServiceArea.add(campLoc);
                }
               
           }
           
           //In case existing record is unselected by user then that record will be deleted
           for(id camLoc : existingLocationMap.keySet()){
                if(!selectedLocationSet.contains(camLoc)){
                    zipCodSet.add(existingLocationMap.get(camLoc).Zip_Code__c);
                }
           }
           
           if(insertNewServiceArea.size()<=0 && zipCodSet.size()<=0){
                if(existingLocationMap.size()>0){
                    //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Warning,'These Record/s are already saved'));
                  throw new ApplicationException('These Record/s are already saved');
                }
                else{
                    //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Warning,'No Record/s are selected'));
                    throw new ApplicationException('No Record/s are selected');
                } 
                
           }
           
           // logic to verify if its update or insert operation for wunderman API callouts
           Boolean hasGeoRecordsAlready = false;
           List<Campaign_Location__c> lstexistingGeoRecords = new List<Campaign_Location__c> ();
           lstexistingGeoRecords = [SELECT id FROM Campaign_Location__c WHERE Campaign__c=:campid];
           
           if(lstexistingGeoRecords.size()>0) hasGeoRecordsAlready = true;
           else hasGeoRecordsAlready = false;
           System.debug('*****lstexistingGeoRecords***'+lstexistingGeoRecords+'***hasGeoRecordsAlready *****'+hasGeoRecordsAlready);
            
           //Insert location records
           if(insertNewServiceArea.size()>0)
                insert insertNewServiceArea;
           
           boolean isCalloutEventTypeDelete=false;
           //when user delete any record, all records with same zipcode should be deleted     
           if(zipCodSet.size()>0){
                list<Campaign_Location__c> deleteServiceArea = new list<Campaign_Location__c>();
                for(Campaign_Location__c cl:[select id from Campaign_Location__c where Campaign__c=:campId AND Zip_Code__c IN: zipCodSet]){
                    deleteServiceArea.add(cl);
                }
                database.delete(deleteServiceArea,false);
                
                if(([SELECT id FROM Campaign_Location__c WHERE Campaign__c=:campid limit 1]).size()==0)
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
                for(Campaign_Location__c  geoInfo : [SELECT Zip_Code__c FROM Campaign_Location__c where campaign__c=:campId]) 
                    zipCodeSet.add(geoInfo.Zip_Code__c);                   
                stringList.addAll(zipCodeSet);
                string valuesCSV = String.join(stringList, ';'); 
                if(!hasGeoRecordsAlready)
                    CampaignMemberCriteriaManager.insertCriteria('ZipCode__c',valuesCSV, campId, false, 'Campaign_Location__c');
                else
                    CampaignMemberCriteriaManager.updateCriteria('ZipCode__c',valuesCSV, campId, false);
           }

        }
        catch(Exception ex)
        {           
        
         system.debug('********e.getLineNumber()******'+ex.getLineNumber());
            
             throw new ApplicationException(ex.getMessage());
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,''));
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
        public Location__c lo{get;set;}
        public boolean isSelected{get;set;}
        public integer index{get;set;}
        
        public WrapSearchResult(Location__c l,boolean flag){
            lo=l;
            isSelected=flag;
        }
        
    }
    
}
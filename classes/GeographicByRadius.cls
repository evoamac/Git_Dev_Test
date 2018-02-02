/*
    Created By: Amit Dahiya
    Created Date: 12 November 2016
    Description: This controller will be used to add location to a campaing on the basis of Geography By Service Line Area
*/
public with sharing class GeographicByRadius {
    //Variable Declaration
    string campId{get;set;}
    public Geographic__c geo{get;set;}
    public string selectedHospital{get;set;}
    public string selectedMiles{get;set;}
    public string selectedbutton{get;set;}
    public boolean showSearchResult{get;set;}
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
    public GeographicByRadius(ApexPages.StandardController controller){
        campId=ApexPages.currentPage().getParameters().get('id');
        system.debug('^^^^campId'+campId);
        showSearchResult=false;
        pageSize= 10;
        selectAll=false;
        masterSelectAll=false;
    }
    
    public list<SelectOption> getlisthospital(){
        list<SelectOption> listValues = new list<SelectOption>();
        listValues.add(new SelectOption('','--None--'));
        
        for(AggregateResult loc: [select Hospital__c from Location__c where Hospital__c != null group by Hospital__c order by Hospital__c asc]){
            listValues.add(new SelectOption((string)loc.get('Hospital__c'),(string)loc.get('Hospital__c')));
        }
        return listValues;
    }  
    
    void handleExistingRecords(map<id,Geographic__c> masterSearchResult){
        //Existing location records
        existingLocationMap = new map<id,Geographic_Info_Information__c>();
        selectedLocationSet = new set<id>();
        for(Geographic_Info_Information__c cmpLoc : [select id,Geographic_Info__c,Campaign__c,ZipCode__c from Geographic_Info_Information__c where Campaign__c=:campId AND Geographic_Info__c IN: masterSearchResult.keySet()]){
            existingLocationMap.put(cmpLoc.Geographic_Info__c,cmpLoc);
            
            //put the existing records in selectMap so that we do not need to handle it seprately
            selectedLocationSet.add(cmpLoc.Geographic_Info__c);
        }
    }
    //Search will be performed on the basis of selected criteria
    public void searchLocation(){
        if(string.isBlank(selectedHospital) || string.isBlank(selectedMiles)){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Please enter the value for hospital and miles !!'));
        }else{
            
            masterSelectAll=false;
            selectAll=false;
            visitedPage=null;
            
            try{
                //THis list will be used when saving records
                masterSearchResult=new map<id,Geographic__c>();
                
                Location locHospital;
                for(Location__c geoHosp:[select Lattitude__c,   Longitude__c from Location__c where Hospital__c = :selectedHospital limit 1]){
                     locHospital = Location.newInstance(geoHosp.Lattitude__c!=null?Double.valueOf(geoHosp.Lattitude__c):null,geoHosp.Longitude__c!=null?Double.valueOf(geoHosp.Longitude__c):null);
                }
                
                Location locginfo;
                Double distance;
                Set<id> geoInfoids = new Set<id> ();
                for(Geographic__c gInfo : [select id,Latitude__c,Longitude__c from Geographic__c where Latitude__c!=null AND Longitude__c!=null]){
                    if(gInfo.Latitude__c!=null && gInfo.Longitude__c!=null){
                        locginfo = Location.newInstance(Double.valueOf(gInfo.Latitude__c),Double.valueOf(gInfo.Longitude__c ));
                        distance = Location.getDistance(locginfo, locHospital , 'mi');
                        if(distance < Double.valueOf(selectedMiles))
                            geoInfoids.add(gInfo.id);
                    }
                } 
                
                if(geoInfoids.size()>0){
                    list<Geographic__c> locList = [SELECT id, CBSA__c,City__c,County__c,CountyFIPS__c,Latitude__c,Longitude__c,MSA__c,State__c,StateFIPS__c,ZipCode__c FROM Geographic__c WHERE Id IN:geoInfoids];
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
                }else{
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
            system.debug('****wrap.isSelected='+wrap.isSelected);
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
        PageReference ref;
        try{
                      
           list<Geographic_Info_Information__c> insertNewServiceArea = new list<Geographic_Info_Information__c>();
           set<string> zipCodSet = new set<string>();
                      
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
                    Geographic_Info_Information__c campLoc = new Geographic_Info_Information__c();
                    campLoc.Campaign__c=campId;
                    campLoc.Geographic_Info__c=locid;
                    campLoc.Audience_Search_Type__c='Geography By Distance';
                    insertNewServiceArea.add(campLoc);
                }
           }
           
           //In case existing record is unselected by user then that record will be deleted
           for(id camLoc : existingLocationMap.keySet()){
                if(!selectedLocationSet.contains(camLoc)){
                    zipCodSet.add(existingLocationMap.get(camLoc).ZipCode__c);
                }
           }
           
           if(insertNewServiceArea.size()<=0 && zipCodSet.size()<=0){
                if(existingLocationMap.size()>0){
                    throw new ApplicationException('These Record/s are already saved');
                    //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Warning,'These Record/s are already saved'));
                }else{
                  throw new ApplicationException('No Record/s are selected');
                    //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Warning,'No Record/s are selected'));
                }
           }
           
           // logic to verify if its update or insert operation for wunderman API callouts
           Boolean hasGeoRecordsAlready = false;
           List<Geographic_Info_Information__c> lstexistingGeoRecords = new List<Geographic_Info_Information__c> ();
           lstexistingGeoRecords = [SELECT id FROM Geographic_Info_Information__c WHERE Campaign__c=:campid];
           if(lstexistingGeoRecords.size()>0) hasGeoRecordsAlready = true;
           else hasGeoRecordsAlready = false;
           System.debug('*****lstexistingGeoRecords***'+lstexistingGeoRecords+'***hasGeoRecordsAlready *****'+hasGeoRecordsAlready);
           
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
           
           ref=new pagereference('/apex/CampaignCriteria_Geographies?Id='+campId);
           ref.setredirect(true);
            
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

           
             
        }catch(Exception ex){           
             throw new ApplicationException(ex.getMessage());
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'There is some problem. Please contact your system administrator'));
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
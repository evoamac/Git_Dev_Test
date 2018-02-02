/*
    Created By: Amit Dahiya
    Created Date: 15 November 2016
    Description: This controller will be used to add location to a campaing on the basis of Geography By Service Line Area
*/
public with sharing class PagingDRGController {
    //Variable Declaration
    public boolean exclude {get;set;}
    string campId{get;set;}
    public string encounterid{get;set;}
    public DRG_Code__c geo{get;set;}
    public Campaign cmp{get;set;}
    public string selectedDrgNumbere{get;set;}
    public string selectedDescription{get;set;}
    public boolean showSearchResult{get;set;}
    list<WrapSearchResult> searchResult{get;set;}
    public ApexPages.StandardSetController setCon{get;set;}
    public Integer pageSize{get;set;}
    set<Integer> visitedPage{get;set;}
    public Integer noOfRecords{get; set;}
    set<id> selectedLocationSet;
    map<id,DRG_Code_Information__c> existingLocationMap;
    public boolean selectAll{get;set;}
    map<id,DRG_Code__c> masterSearchResult;
    public boolean masterSelectAll{get;set;}
    
    // Service line /subservice line changes 
     public List<SelectOption> subserviceline{get;set;}     
     public String[] selectedValSSL {get;set;}     
     Public Map<String,String> SubServiceLineMap =new   Map<String,String>();
     public List<SelectOption> lstServiceLinevalues {
        get {
            List<SelectOption> lstServiceLineVal = new List<SelectOption> ();
            
            lstServiceLineVal.add(new SelectOption('', '--None--'));
            id RecordTypeid = [SELECT id FROM RecordType WHERE SobjectType='CRM_CampaignWizardReferenceData__c' AND DeveloperName='Service_Line'][0].id;
            for(CRM_CampaignWizardReferenceData__c objCRMServiceLineVal : [Select id ,CRM_ServiceLine__c  FROM CRM_CampaignWizardReferenceData__c WHERE Recordtypeid =:RecordTypeid and CRM_IsActive__c=:true]) 
               { 
             
               lstServiceLineVal.add(new SelectOption(objCRMServiceLineVal.CRM_ServiceLine__c, objCRMServiceLineVal.CRM_ServiceLine__c  ));
               }
            if(lstServiceLineVal.size()>0) lstServiceLineVal.sort();
            return lstServiceLineVal;
        }
        set;
    
    }
   
        public list<selectoption> getsubserviceline()
        {
                subserviceline = new list<SelectOption>();
                selectedValSSL=  new String[]{};
               
                id RecordTypeid = [SELECT id FROM RecordType WHERE SobjectType='CRM_CampaignWizardReferenceData__c' AND DeveloperName='Sub_Service_Line'][0].id;
                for (CRM_CampaignWizardReferenceData__c objCRMServiceLineVal : [select CRM_SubServiceLine__c ,CRM_ParentServiceLineID__r.CRM_ServiceLine__c,CRM_ServiceSubServiceLine__c from CRM_CampaignWizardReferenceData__c where CRM_ParentServiceLineID__r.CRM_ServiceLine__c =:cmp.Service_Line__c and RecordTypeid=:RecordTypeid])
                {       
                    SubServiceLineMap.put(objCRMServiceLineVal.CRM_ServiceSubServiceLine__c ,objCRMServiceLineVal.CRM_SubServiceLine__c);
                    subserviceline.add(new SelectOption(objCRMServiceLineVal.CRM_ServiceSubServiceLine__c, objCRMServiceLineVal.CRM_ServiceSubServiceLine__c ));    
                    system.debug('##### subserviceline ##### '+subserviceline);
                }
                return subserviceline;
        }
        public void callactionmethod()   
        {
            getsubserviceline();
           
        }
   // Service line /subservice line changes 
   
    //Constructure
    public pagingDRGController(ApexPages.StandardController controller){
        campId=ApexPages.currentPage().getParameters().get('id');
        encounterid=ApexPages.currentPage().getParameters().get('encounter');
        exclude=ApexPages.currentPage().getParameters().get('exclude')==null?false:true;
        cmp = (Campaign) controller.getRecord();
        cmp.Service_Line__c = null;
        cmp.Sub_Service_Line__c = null;
        system.debug('^^^^campId'+campId);
        showSearchResult=false;
        pageSize= 10;
        selectAll=false;
        masterSelectAll=false;
       // Service line /subservice line changes 
        subserviceline = new list<SelectOption>();      
        selectedvalSSL = new String[]{};
       // Service line /subservice line changes 
   
     }
    
    void handleExistingRecords(map<id,DRG_Code__c> masterSearchResult){
        //Existing location records
        existingLocationMap = new map<id,DRG_Code_Information__c>();
        selectedLocationSet = new set<id>();
        for(DRG_Code_Information__c cmpLoc : [select id,DRG_Code__c,Campaign__c from DRG_Code_Information__c where Campaign__c=:campId AND Exclude__c=:exclude AND DRG_Code__c IN: masterSearchResult.keySet()]){
            existingLocationMap.put(cmpLoc.DRG_Code__c,cmpLoc);
            
            //put the existing records in selectMap so that we do not need to handle it seprately
            selectedLocationSet.add(cmpLoc.DRG_Code__c);
        }
    }
    //Search will be performed on the basis of selected criteria
    public void searchLocation()
    {
        system.debug('*****='+cmp);
    
        // Service line /subservice line changes 
        List<String> SelectedSubServiceLine=new List<String>();
        for (String key:selectedValSSL )
        SelectedSubServiceLine.add(SubServiceLineMap.get(key));
        cmp.Sub_Service_Line__c =String.join(SelectedSubServiceLine,';');
        // Service line /subservice line changes 
     
        if(string.isBlank(selectedDrgNumbere) && string.isBlank(cmp.Service_Line__c) && string.isBlank(cmp.Sub_Service_Line__c) && string.isBlank(selectedDescription)){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Please select atleast one filter criteria !!'));
        }else{
            
            //Prepare query on the basis of search chriteria entered by user
            string searchQuery = 'select Description__c , MS_DRG__c ,  Service_Line__c , Sub_Service_Line__c from DRG_Code__c ';
            string limitedsearchQuery = 'select Description__c , MS_DRG__c ,  Service_Line__c , Sub_Service_Line__c from DRG_Code__c ';
            list<String> lstWhereLocCondition=new list<string>();
            selectAll=false;
            visitedPage=null;
            masterSelectAll=false;
            
            if(string.isNotBlank(selectedDrgNumbere))
                lstWhereLocCondition.add(' MS_DRG__c Like \'%'+selectedDrgNumbere+ '%\'');
            
            if(string.isNotBlank(selectedDescription))
                lstWhereLocCondition.add(' Description__c Like \'%'+selectedDescription+ '%\'');
            
            if(String.isNotBlank(cmp.Service_Line__c)){
                System.debug('--------i am in service----------');
                lstWhereLocCondition.add(' Service_Line__c=\''+cmp.Service_Line__c+ '\'');
            }
            
            if(String.isNotBlank(cmp.Sub_Service_Line__c)){
                list<string> subsserviceLineList = cmp.Sub_Service_Line__c.split(';');
                lstWhereLocCondition.add('  Sub_Service_Line__c IN :subsserviceLineList');
            }
            
            if(lstWhereLocCondition.size()>0){
                searchQuery += ' WHERE ' + String.join(lstWhereLocCondition,' AND ');
                limitedsearchQuery += ' WHERE ' + String.join(lstWhereLocCondition,' AND ');
            }
            searchQuery +=' Limit 48000';
            limitedsearchQuery +=' Limit 1500';
            system.debug('****='+cmp);
            system.debug('****='+searchQuery);
            list<DRG_Code__c> locList = new list<DRG_Code__c> ();
            list<DRG_Code__c> limitedlocList = new list<DRG_Code__c> ();
            try{
                //THis list will be used when saving records
                masterSearchResult=new map<id,DRG_Code__c>();
                locList = Database.Query(searchQuery);
                limitedlocList = Database.Query(limitedsearchQuery);
                masterSearchResult.putAll(limitedlocList);
                if(locList.size()>1500)
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, '1500 records can be shown out of '+locList.size()+' Please narrow down the criteria.'));
                
                //
                
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
            DRG_Code__c lo = (DRG_Code__c)loc;
            if(selectAll){
                if(visitedPage != null && visitedPage.contains(setCon.getPageNumber())){
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
                ref = new pageReference('/apex/EncountersPage?btn=1&Id='+campId+'&encounter='+encounterid);
           else
                 ref=new pagereference('/apex/EncountersPage?btn=1&Id='+campId );
            
           ref.setredirect(true);
           
           
        }catch(Exception ex){           
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage()));
        }
        return ref;
    }
    
    //save selected location under this campaign
    public void saveServiceArea(){
        
        try{
                      
           list<DRG_Code_Information__c> insertNewServiceArea = new list<DRG_Code_Information__c>();
           list<DRG_Code_Information__c> deleteServiceArea = new list<DRG_Code_Information__c>();
           
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
                    DRG_Code_Information__c campLoc = new DRG_Code_Information__c();
                    campLoc.Campaign__c=campId;
                    campLoc.DRG_Code__c=locid;
                    campLoc.Exclude__c=exclude;
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
           List<DRG_Code_Information__c> lstDRGInf = new List<DRG_Code_Information__c> ();
           lstDRGInf = [SELECT id FROM DRG_Code_Information__c WHERE Campaign__c=:campid AND Exclude__c=:exclude limit 1];
           if(lstDRGInf.size()>0) hasGeoRecordsAlready = true;
           else hasGeoRecordsAlready = false;
           
           if(insertNewServiceArea.size()>0)
                insert insertNewServiceArea;
           
           boolean isCalloutEventTypeDelete=false;     
           if(deleteServiceArea.size()>0){
                delete deleteServiceArea;
                
                if(([SELECT id FROM DRG_Code_Information__c WHERE Campaign__c=:campid limit 1]).size()==0)
                    isCalloutEventTypeDelete=true; 
           }   
            
           
           // code for inserting criteria for wundermanapi callouts
           Campaign objCampaignForAPI;
           List<Campaign> lstCampaign = [SELECT Wunderman_Sync__c  FROM Campaign WHERE id=:campId];
           if(lstCampaign.size()>0) objCampaignForAPI = lstCampaign[0];
           objCampaignForAPI.Wunderman_Sync__c  = 'Pending';
           update objCampaignForAPI;
           
           if(isCalloutEventTypeDelete)
                CampaignMemberCriteriaManager.deleteCriteria('MS_DRG__c', campId, false);
           else
           {
                String[] stringList = new String[0];
                  for(DRG_Code_Information__c  DRG : [SELECT MS_DRG__c FROM DRG_Code_Information__c WHERE campaign__c=:campId and Exclude__c=:exclude]) {
                      stringList.add(DRG.MS_DRG__c); 
                  }          
               string valuesCSV = String.join(stringList, ';');
               if(!hasGeoRecordsAlready)
                    CampaignMemberCriteriaManager.insertCriteria('MS_DRG__c',valuesCSV, campId, exclude, 'DRG_Code_Information__c');
                else
                    CampaignMemberCriteriaManager.updateCriteria('MS_DRG__c',valuesCSV, campId, exclude);
           }
           CampaignMemberCriteriaManager.setAddOnExclusionCriterias(campId);
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
        if(encounterid!=null){
            ref=new Pagereference('/apex/EncountersPage?btn=1&Id='+campId+'&encounter='+encounterid );
        }else{
            ref=new Pagereference('/apex/EncountersPage?btn=1&Id='+campId );
        }
        ref.setredirect(true);  
        return ref;
        
    }
    public void clearSearch(){
        selectedDrgNumbere=null;
        selectedDescription=null;
    }
    
    public class WrapSearchResult{
        public  transient DRG_Code__c lo{get;set;}
        public boolean isSelected{get;set;}
        public integer index{get;set;}
        
        public WrapSearchResult(DRG_Code__c l,boolean flag){
            lo=l;
            isSelected=flag;
        }
        
    }
    
}
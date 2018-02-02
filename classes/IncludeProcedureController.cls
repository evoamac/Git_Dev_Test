public class IncludeProcedureController 

{
        
    //Variable Declaration 
    public boolean exclude {get;set;}
    public string campId{get;set;}
    public string encounterid{get;set;}
    public string IncludeProCode{get;set;}
    public string IPCodes{get;set;}
    public string IPDis{get;set;}
    public Integer size{get;set;}
    public String TypeOfPro{get;set;}
    public Integer noOfRecords{get; set;}
    public boolean showSearchResult{get;set;}
    set<id> selectedProcedureSet;
    public boolean selectAll{get;set;}
    public boolean masterSelectAll{get;set;}
    set<Integer> visitedPage{get;set;}
    map<id,Procedures__c> masterSearchResult;
    map<id,Procedure_Information__c> existingProcedureMap;
    public ApexPages.StandardSetController setCon{get;set;}
    public Integer pageSize{get;set;}
    list<WrapperClassForProcedure> searchResult{get;set;}
    public list<SelectOption> typeofdiagnosislist{get;set;}
    public string selectedtypeofProcedures{get;set;}
    
   /******** Constructor **************/


    public includeProcedureController(ApexPages.StandardController controller) 
    {
    
   
    campId=ApexPages.currentPage().getParameters().get('id');
    system.debug('^^^^campId'+campId);
    encounterid=ApexPages.currentPage().getParameters().get('encounter');
    exclude=ApexPages.currentPage().getParameters().get('exclude')==null?false:true;
    system.debug('@@@@@encounter id==='+ encounterid);
    showSearchResult=false;
    pageSize= 10;
        selectAll=false;
        masterSelectAll=false;
        preparePiclistFields();

    }
    
    
    public includeProcedureController()
    
    {
        
    }
    
   
    
    void preparePiclistFields(){
      typeofdiagnosislist = new list<SelectOption>();
      typeofdiagnosislist.add(new SelectOption('','--None--'));
      for(AggregateResult loc: [select Type_Of_Procedure__c from Procedures__c where Type_Of_Procedure__c != null group by Type_Of_Procedure__c order by Type_Of_Procedure__c asc]){
            typeofdiagnosislist.add(new SelectOption((string)loc.get('Type_Of_Procedure__c'),(string)loc.get('Type_Of_Procedure__c')));
      }
        
    }
    /****** Wrapper class *****/
    
   
    
    public class WrapperClassForProcedure{
        public Procedures__c wrapPro{get;set;}
        public boolean isSelected{get;set;}
        public integer index{get;set;}
        
        public WrapperClassForProcedure(Procedures__c lP,boolean flag){
            wrapPro=lP;
            isSelected=flag;
        }
        
    }

    void handleExistingRecords(map<id,Procedures__c> masterSearchResult)
    {
        //Existing location records
        existingProcedureMap = new map<id,Procedure_Information__c >();
        selectedProcedureSet = new set<id>();
        for(Procedure_Information__c cmpPro : [select id,Code__c,ICD_CPT_Procedures__c,Campaign__c,GroupIdentifier__c ,Long_Description__c ,Short_Description__c ,Type_Of_Procedure__c from Procedure_Information__c where Campaign__c=:campId and Exclude__c=:exclude AND ICD_CPT_Procedures__c IN:masterSearchResult.keySet()])
        {
            existingProcedureMap.put(cmpPro.ICD_CPT_Procedures__c,cmpPro );
            
            //put the existing records in selectMap so that we do not need to handle it seprately
            selectedProcedureSet.add(cmpPro.ICD_CPT_Procedures__c);
        }
    }


      
    public void searchIncludeProcedure()
    { 

         if(string.isBlank(IPCodes) && string.isBlank(IPDis) &&  string.isBlank(selectedtypeofProcedures))
         {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Please select atleast one filter criteria !!'));
         }
        
         else
         {
            string searchQuery = 'SELECT Code__c, GroupIdentifier__c, LongDescription__c, ShortDescription__c, Type_Of_Procedure__c FROM Procedures__c';
            string limitedsearchQuery = 'SELECT Code__c, GroupIdentifier__c, LongDescription__c, ShortDescription__c, Type_Of_Procedure__c FROM Procedures__c';
            list<String> lstWhereLocCondition=new list<string>();
         
            selectAll=false;
            masterSelectAll=false;
            visitedPage=null;
            
            if(String.isNotBlank(IPCodes))
                lstWhereLocCondition.add(' Code__c Like\'%'+IPCodes+ '%\'');    
                
             if(String.isNotBlank(IPDis))
                lstWhereLocCondition.add(' LongDescription__c Like\'%'+IPDis+ '%\'');  
                
              if(selectedtypeofProcedures!=null )
                lstWhereLocCondition.add(' Type_Of_Procedure__c Like\'%'+selectedtypeofProcedures+ '%\'');
                
             if(lstWhereLocCondition.size()>0)
             {
                searchQuery += ' WHERE ' + String.join(lstWhereLocCondition,' AND ');
                limitedsearchQuery += ' WHERE ' + String.join(lstWhereLocCondition,' AND ');
             } 
             
             
                          
            // if(string.isNotBlank(selectedtypeofProcedures) && string.isBlank(IPDis) && string.isBlank(IPCodes))
            
               searchQuery +=' Limit 48000';
               limitedsearchQuery +=' Limit 1500';
               list<Procedures__c> ProList = new list<Procedures__c> ();
               list<Procedures__c> limitedProList = new list<Procedures__c> ();
               try
               
              {
                //This list will be used when saving records
                masterSearchResult=new map<id,Procedures__c>();
                ProList = Database.Query(searchQuery);
                limitedProList = Database.Query(limitedsearchQuery);
                masterSearchResult.putAll(limitedProList);
                if(ProList.size()>1500)
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, '1500 records can be shown out of '+ProList.size()+' Please narrow down the criteria.'));
                handleExistingRecords(masterSearchResult);
                
                setCon = new ApexPages.StandardSetController(limitedProList);
                setCon.setPageSize(pageSize);  
                noOfRecords = setCon.getResultSize();
                if(noOfRecords>0)
                    showSearchResult=true;
                else
                {
                    showSearchResult=false;
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'No matching record found. Please check search filter.'));
                }
                
            }catch(Exception ex){
                  ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'There is some issue with this page. Please contact your system admin.'));
            }        
                
        
         }
        
        

    }
    
    
      //SearchResult per page list
    public list<WrapperClassForProcedure> getsearchResult() 
    {
         searchResult = new list<WrapperClassForProcedure>();
         system.debug('=******='+selectAll);
         system.debug('*****='+masterSelectAll);
         system.debug('**setCon**='+setCon);
         for(sObject Pro:setCon.getRecords())
         {
            Procedures__c InPro = (Procedures__c ) Pro;
            system.debug('**InPro**='+InPro);
            system.debug('**selectAll**='+selectAll);
            if(selectAll)
            {
                system.debug('=***visitedPage***='+visitedPage);
                system.debug('**setCon**='+setCon);
                if(visitedPage!=null && visitedPage.contains(setCon.getPageNumber()))
                {
                    if(selectedProcedureSet.contains(InPro.id))
                        searchResult.add(new WrapperClassForProcedure(InPro,true));
                    else
                    {
                        searchResult.add(new WrapperClassForProcedure(InPro ,false));
                    }       
                }else
                {
                    searchResult.add(new WrapperClassForProcedure(InPro,true));
                }
            }
            else
            {
              if(selectedProcedureSet.contains(InPro.id) && !masterSelectAll)
                    searchResult.add(new WrapperClassForProcedure(InPro,true));
                else
                    searchResult.add(new WrapperClassForProcedure(InPro,false));
            }
            
         }
         return searchResult; 
    }
   
     
        // returns the first page of records
    public void first() 
    {
        handleSeletedProcedures();
        setCon.first();
    }

    // returns the last page of records
    public void last() {
        handleSeletedProcedures();
        setCon.last();
    }

    // returns the previous page of records
    public void previous() {
        handleSeletedProcedures();
        setCon.previous();
    }

    // returns the next page of records
    public void next() {
        handleSeletedProcedures();
        setCon.next();
    }
    
    
    //manage selected locations
    void handleSeletedProcedures()
    {
      
        if(selectAll)
        {
            if(visitedPage==null)
                visitedPage=new set<Integer>();
            visitedPage.add(setCon.getPageNumber());
        }
        for(WrapperClassForProcedure wrap:searchResult)
        {
            if(wrap.isSelected)
            {
                selectedProcedureSet.add(wrap.wrapPro.id);
            }
            else
            {
                if(selectedProcedureSet.contains(wrap.wrapPro.id))
                    selectedProcedureSet.remove(wrap.wrapPro.id);
                
                if(masterSearchResult.containsKey(wrap.wrapPro.id))
                  masterSearchResult.remove(wrap.wrapPro.id);   
            }
                
        }
    }
    //save selected location under this campaign
    public PageReference saveProcedure(){
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
    //save selected location under this campaign
    public void saveServiceArea(){
    
        try{
                      
           list<Procedure_Information__c > insertNewProcedure = new list<Procedure_Information__c >();
           list<Procedure_Information__c > deleteProcedure = new list<Procedure_Information__c >();
           system.debug('****hasGeoRecordsAlready***=');
           //This iterration is only for current page
           for(WrapperClassForProcedure wrap:searchResult)
           {
              if(wrap.isSelected)
              {
                    selectedProcedureSet.add(wrap.wrapPro.id);
              }
              else
              {
                    if(selectedProcedureSet.contains(wrap.wrapPro.id))
                    {
                        selectedProcedureSet.remove(wrap.wrapPro.id);
                    }
                    masterSearchResult.remove(wrap.wrapPro.id);
              }
           }
           system.debug('****hasGeoRecordsAlready***=');
           if(selectAll)
           {
                for(id ProId :masterSearchResult.keySet())
                {
                    if(!selectedProcedureSet.contains(ProId ))
                        selectedProcedureSet.add(ProId );
                }                
           }
           else if(!selectAll && masterSelectAll)
           {//This case is when user search and existing rcords come in search and then user select and then unselect all checkbox
               selectedProcedureSet.clear();
               masterSelectAll=false;
           }   
           system.debug('****hasGeoRecordsAlready***=');
           //This itteration is for all the selected records
           for(id ProId : selectedProcedureSet)
           {
                if(!existingProcedureMap.containsKey(ProId))
                {
                    Procedure_Information__c campPro = new Procedure_Information__c ();
                    campPro.Campaign__c=campId;
                    campPro.ICD_CPT_Procedures__c=ProId;
                    campPro.Exclude__c = exclude;
                    insertNewProcedure.add(campPro);
                }
           }
           system.debug('****hasGeoRecordsAlready***=');
           //In case existing record is unselected by user then that record will be deleted
           for(id camPro : existingProcedureMap.keySet())
           {
                if(!selectedProcedureSet.contains(camPro ))
                {
                    deleteProcedure.add(existingProcedureMap.get(camPro));
                }
           }
           system.debug('****hasGeoRecordsAlready***=');
           
           if(insertNewProcedure.size()<=0 && deleteProcedure.size()<=0){
                if(existingProcedureMap.size()>0){
                    //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Warning,'These Record/s are already saved'));
                    throw new ApplicationException('These Record/s are already saved');
                }else{
                    //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Warning,'No Record/s are selected'));
                    throw new ApplicationException('No Record/s are selected');
                }
                
           }
           
           // code for inserting criteria for wundermanapi callouts
           Boolean hasGeoRecordsAlready = false;
           List<Procedure_Information__c> lstICDProcedures = new List<Procedure_Information__c> ();
           lstICDProcedures = [SELECT id FROM Procedure_Information__c WHERE Campaign__c=:campid and Exclude__c=:exclude limit 1];
           hasGeoRecordsAlready = lstICDProcedures.size()>0?true:false;
           system.debug('****hasGeoRecordsAlready***='+hasGeoRecordsAlready);
           
           if(insertNewProcedure.size()>0)
                insert insertNewProcedure;
           
           boolean isCalloutEventTypeDelete=false;
           if(deleteProcedure.size()>0)
           {
                database.delete(deleteProcedure,false);
                if(([SELECT id FROM Procedure_Information__c WHERE Campaign__c=:campid and Exclude__c=:exclude limit 1]).size()==0)
                    isCalloutEventTypeDelete=true;
           }    
           
            // code for inserting criteria for wundermanapi callouts
           if(isCalloutEventTypeDelete)
                CampaignMemberCriteriaManager.deleteCriteria('Procedure_Code__c', campId, exclude);
           else    
           {
               String[] stringList = new String[0];
               for(Procedure_Information__c Procedure : [SELECT Code__c,Type_Of_Procedure__c FROM Procedure_Information__c WHERE campaign__c=:campId and Exclude__c=:exclude]) 
               {
                      if(Procedure.Type_Of_Procedure__c=='CPT4')
                          stringList.add(Procedure.Type_Of_Procedure__c+'_'+Procedure.Code__c); 
                      else
                          stringList.add(Procedure.Type_Of_Procedure__c+'PROC_'+Procedure.Code__c); 
               }           
               string valuesCSV = String.join(stringList, ';');
               if(!hasGeoRecordsAlready)
                   CampaignMemberCriteriaManager.insertCriteria('Procedure_Code__c',valuesCSV, campId, exclude, 'Procedure_Information__c');
                else
                    CampaignMemberCriteriaManager.updateCriteria('Procedure_Code__c',valuesCSV, campId, exclude);
               system.debug('Procedures Criteria Added');
           }
            CampaignMemberCriteriaManager.setAddOnExclusionCriterias(campId);
          
        }
        catch(Exception ex)
        {           
            system.debug('****Exception Block***='+ex);
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
            searchIncludeProcedure();
        }catch(Exception ex){           
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage()));
        }
        
    }
    
    
     public pagereference cancel()
     {
        pagereference ref;
        if(encounterid!=null){
            ref=new Pagereference('/apex/EncountersPage?btn=1&Id='+campId+'&encounter='+encounterid );
        }else{
            ref=new Pagereference('/apex/EncountersPage?btn=1&Id='+campId );
        }
        ref.setredirect(true);  
        return ref;
        
    }
    
    

}
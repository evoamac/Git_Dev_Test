public class ClonePlusController{
    //public List<relatedObjects> objectChildren  { get; set; }
    public Campaign CampName{get;set;} 
    public SObject headSObject, headClone ,headChildClone ;  
    map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
    public static boolean isClone=false;  
    public string initialiseObjectsForCloning(Id campid){  
        //Design Change for channel vendor screen : Inactive values validation 
        isClone=true;
        if(BeforeCloneValidation(campid)){  
        
            headSObject = (sObject)new Campaign(Id=campid);//Database.query(primaryObjectQueryString); 
            //headClone = cloneObjects(new List<sObject>{headSObject}).get(0);
            
            string campaignQuery = queryString('Campaign',null);
            campaignQuery += ' where id=\''+campid+'\'';
            
            system.debug('**Query String='+campaignQuery);
            map<id,id> mainNClonedCampIdMap = new map<id,id>();
            //This loop will run only once for main campaign
            for(SObject camp:Database.query(campaignQuery)){
                sobject obj = setupCampaignData(camp);
                insert obj;
                headClone = obj;
                mainNClonedCampIdMap.put(campId,(id)obj.get('id'));
                //system.debug('***mainNClonedCampIdMap='+mainNClonedCampIdMap.size()+'-----'+mainNClonedCampIdMap);
                
                list<sObject> cloneCampaign = new list<sObject>();
                if(camp.get('Member_Types__c')=='Campaign Segments'){
                    for(sobject sob : camp.getSobjects('CRM_SegmentedParentCampaigns__r')){
                        system.debug('***obj.get(id)='+(id)obj.get('id'));
                        sob.put('CRM_ParentSegmentedCampaign__c',(id)obj.get('id'));
                        cloneCampaign.add(setupCampaignData(sob));
                    }
                    
            
                    if(cloneCampaign.size()>0){
                        insert cloneCampaign;
                        
                        for(sObject sob :cloneCampaign){
                            mainNClonedCampIdMap.put((id)sob.get('CRM_ClonedFromCampaign__c'),(id)sob.get('id'));
                        }   
                    }
                }
            }
            
            //populateObjectChildren();   
            //cloneSelectedObjects();
            system.debug('***mainNClonedCampIdMap='+mainNClonedCampIdMap.size()+'-----'+mainNClonedCampIdMap);
            //This method will be used to clone all the child object data except segment campaing data
            cloneRelatedData(mainNClonedCampIdMap);//PP4
            
            /* for cloning junction object for encounter and encounter agg hospital */
            cloneEncounterJunctionCriteria(mainNClonedCampIdMap);
            cloneEncounterAggregatesJunctionCriteria(mainNClonedCampIdMap); 
            /* end of cloning junction object */
        
            //Clone audience selection junction objects {service ans sub service line on encounter screen}
            cloneSelectionCriteria(mainNClonedCampIdMap);
            /*
            if(headClone.get('Member_types__c')=='Campaign Segments'){
                system.debug('inside if condition for chikd camp$$$$$');
                clonesegmentedcampaign(campid, headClone.Id );
            }
            */
            //CloneSelectedPicklistValues(campid,headClone.Id );
        
            system.debug('####### headClone id ######'+headClone.Id); 
            return headClone.Id;
        
        }else{
            return null;
    }
   
    //Design Change for channel vendor screen : Inactive values validation 
    }
    //Created for PP4 
    public static sObject setupCampaignData(sObject camp){
        sObject clonedCamp;
        //for(SObject camp:Database.query(campaignQuery)){
        clonedCamp = camp.clone(false,true);
        //}
        clonedCamp.put('CRM_ClonedFromCampaign__c',camp.id);
        clonedCamp.put('Program_Name__c',null);
        
        if(String.valueOf(clonedCamp.get('CRM_ParentSegmentedCampaign__c'))!=null){
            clonedCamp.put('Status','Segmented Campaign not Activated');
        }
        else
            clonedCamp.put('Status','In Development');
        
        clonedCamp.put('Call_Center_Identifier__c',null);    
        clonedCamp.put('Call_Center_Unique_Identifier__c',null);
        clonedCamp.put('Campaign_Toll_Free_Number__c',null);
        clonedCamp.put('Save_Campaign_as_Template__c',false);
        clonedCamp.put('CRM_ActivateProcessId__c', null);    
        clonedCamp.put('Ownerid',userinfo.getUserId());
        clonedCamp.put('Actual_Spend__c', null);
        clonedCamp.put('Campaign_Budget__c' , null);
        clonedCamp.put('Expected_Contribution_Margin__c', null);
        clonedCamp.put('Purchase_Invoice_Order__c', null);
        clonedCamp.put('IsActive',false);
        clonedCamp.put('Approved__c',false); 
        clonedCamp.put('Error_Message__c',null);
        clonedCamp.put('CRM_AudienceUploadCount__c', null);
        // Start :Audience Selection criteria stories changes(BirthMonth)
        clonedCamp.put('CRM_Refreshed_Count_Date__c',null);
        clonedCamp.put('Place_Order_Date_Time__c',null); 
        clonedCamp.put('Add_Member_Status__c',null);
        clonedCamp.put('List_Order_Id__c',null);
        clonedCamp.put('LIST_ORDER_SELECT_GRP_ID__c',null);
        clonedCamp.put('Current_count__c',null);
        clonedCamp.put('Approved_By__c',null);
        clonedCamp.put('Approval_Comments__c',null);
        clonedCamp.put('MARS_Approval__c',null);
        clonedCamp.put('CG_Count__c',null);
        clonedCamp.put('Missing_Contact_Count__c',null);
        clonedCamp.put('count_of_index__c',null);
        clonedCamp.put('Supp_Count__c',null);
        clonedCamp.put('Audience_Hospital__c',null);
        clonedCamp.put('Audience__c',null);
        clonedCamp.put('Audience_Region__c',null);
        String NewName=ReferenceData_PicklistController.getCampaignName(camp.Id);     
        clonedCamp.put('Name',NewName);   
        // Defect Start : if Control_Group_Size value is present than Control_Group_Percentage should be null 
        if (clonedCamp.get('Control_Group_Size__c')!=null)
        	clonedCamp.put('Control_Group_Percentage__c',null);  
        //Ending of Defect: if Control_Group_Size value is present than Control_Group_Percentage should be null           
        if(clonedCamp.get('CRM_ParentSegmentedCampaign__c')!=null){
        	clonedCamp.put('Control_Group_Size__c',null);
        	clonedCamp.put('Control_Group_Percentage__c',null); 
        }
        if(NewName!=null && NewName.length()>12)
            clonedCamp.put('count_of_index__c',NewName.substring(9, 12));
          
        return clonedCamp;
         
         
    }
    //Clone campaign related data
    void cloneRelatedData(map<id,id> mainNClonedCampIdMap){//PP4
        string queryString;
        boolean hasAttachmentinCustomSetting=false;
        sobject sb = (sObject)new Campaign();
        Set<String> childObjectTypes = new Set<String>{};
        for (Campaign_Related_List__c s: Campaign_Related_List__c.getall().values())
            childObjectTypes.add(s.name);
          
        Schema.DescribeSObjectResult headDescribe = sb.getSObjectType().getDescribe();
        List<Schema.ChildRelationship> childRelationships = headDescribe.getChildRelationships(); 
        map<String,String> relationshipNameMap = new map<String,String>();
        for (Schema.ChildRelationship childRelationship :childRelationships)
        {
           
           Schema.SObjectType childObjectType = childRelationship.getChildSObject();
           string objectApiName = childObjectType.getDescribe().getName();
           if (childObjectTypes.contains(objectApiName)){
              
              Schema.SObjectField childObjectField = childRelationship.getField();                    
              //Attachment body is a binary field and we can not query binary field in subqueries
              if(objectAPIName!='Attachment'){
                  string relationshipName = childRelationship.getRelationshipName();
                  relationshipNameMap.put(relationshipName,childObjectField.getDescribe().getName());
                  
                  if(string.isBlank(queryString))
                    queryString = 'select id,('+queryString(objectApiName,relationshipName)+')';
                  else
                    queryString += ',('+queryString(objectApiName,relationshipName)+')';
              }else
                hasAttachmentinCustomSetting=true;
            }
           
        }
        queryString += ' from Campaign where Id IN (';
        string whereClause;
        for(Id cmid : mainNClonedCampIdMap.keySet()){
            if(string.isBlank(whereClause))
                whereClause = '\'' + cmid + '\'';
            else
                whereClause += ',\'' + cmid + '\'';
        }
        queryString += whereClause+')';
        
        system.debug('****156='+queryString);
        system.debug('****relationshipNameMap='+relationshipNameMap);
        list<sObject> relatedList = new list<sObject>();
        for(sObject sob : Database.query(queryString)){
            for(string str :relationshipNameMap.keySet()){
                system.debug('***Clone Backend Records'+sob.getSobjects(str));
                if(sob.getSobjects(str)!=null){
                    system.debug('***Clone Backend Records');
                    for(sObject rl : sob.getSobjects(str)){
                        sObject s = rl.clone(false,true);
                        system.debug('***Parent Record Id Before='+s.get(relationshipNameMap.get(str)));
                        s.put(relationshipNameMap.get(str),mainNClonedCampIdMap.get((Id)rl.get(relationshipNameMap.get(str))));
                        system.debug('***Parent Record Id After='+s.get(relationshipNameMap.get(str)));
                        relatedList.add(s);
                    }
                }
            }
        }
        system.debug('***relatedList='+relatedList.size()+'-----'+relatedList);
        //This section is specificaly cloning the attachment list in case it is mentioned in the custom setting
        if(hasAttachmentinCustomSetting){
            string attchQuery=queryString('Attachment',null);
            string attchWhereClause;
            for(Id cmid : mainNClonedCampIdMap.keySet()){
                if(string.isBlank(attchWhereClause))
                    attchWhereClause = ' Where ParentID IN(\'' + cmid + '\'';
                else
                    attchWhereClause += ',\'' + cmid + '\'';
            }
            attchQuery += attchWhereClause+')';
            
            for(sObject sob : Database.query(attchQuery)){
                sObject s = sob.clone(false,true);
                s.put('ParentId',mainNClonedCampIdMap.get((id)sob.get('ParentId')));
                relatedList.add(s);
            }
        }
        relatedList.sort();
        if(relatedList.size()>0)
            insert relatedList;
    }
    //This method will copy junction object data for service and sub service line audience selection and home address selection
    public void cloneSelectionCriteria(map<id,id> mainNClonedCampIdMap)
    {
        list<sObject> searchCriteriaList = new list<sObject>();
        system.debug('**mainNClonedCampIdMap**='+mainNClonedCampIdMap);
        for(Campaign cm : [select id,(select id,CRM_CampaignWizardReferenceData__c,CRM_CampaignMapping__c  from CRM_CampaignRefJunction__r),(select id, Campaign_Location_Reference_Data_Mapping__c,CRM_Region__C, CRM_Market__C, CRM_Hospital__C, Campaign_Location_Reference_Data_Mapping__r.recordTypeId from CRM_CampaignOwnershipDetailsMapping__r),(SELECT WM_Sync_Type__c,Exclude__c,Category__c,Operator__c,Criteria_Group__c, WM_Sync_Status__c,Field_Name__c,Value__c,Field_id__c,Campaign__c FROM Campaign_Member_Criterias__r),(select id,CRM_Campaign__c,CRM_Search_Criteria_Level_1__c,CRM_Search_Criteria_Level_2__c,CRM_Search_Criteria_Level_3__c,CRM_AdditionalZipCodes__c,CRM_ExcludedZipCodes__c from Search_Criterias_del__r) from campaign where ID IN:mainNClonedCampIdMap.keySet()]){
             system.debug('**cm.Search_Criterias_del__r**='+cm.Search_Criterias_del__r.size());
             for(CRM_Search_Criteria__c crms : cm.Search_Criterias_del__r){
                CRM_Search_Criteria__c hsl = new CRM_Search_Criteria__c();
                hsl.CRM_Campaign__c=mainNClonedCampIdMap.get(cm.id);
                hsl.CRM_Search_Criteria_Level_1__c=crms.CRM_Search_Criteria_Level_1__c;
                hsl.CRM_Search_Criteria_Level_2__c=crms.CRM_Search_Criteria_Level_2__c;
                hsl.CRM_Search_Criteria_Level_3__c=crms.CRM_Search_Criteria_Level_3__c;
                hsl.CRM_AdditionalZipCodes__c=crms.CRM_AdditionalZipCodes__c;
                hsl.CRM_ExcludedZipCodes__c=crms.CRM_ExcludedZipCodes__c;
                searchCriteriaList.add(hsl);
            }
            system.debug('**cm.Campaign_Member_Criterias__r**='+cm.Campaign_Member_Criterias__r.size());
            for(Campaign_Member_Criteria__c criteria: cm.Campaign_Member_Criterias__r) {
                Campaign_Member_Criteria__c criteriacloned = new Campaign_Member_Criteria__c ();
                criteriacloned.Field_Name__c = criteria.Field_Name__c;
                criteriacloned.Value__c = criteria.Value__c;
                criteriacloned.Field_id__c= criteria.Field_id__c;
                criteriacloned.Exclude__c= criteria.Exclude__c;
                criteriacloned.Category__c= criteria.Category__c;
                criteriacloned.Operator__c= criteria.Operator__c;
                criteriacloned.Criteria_Group__c= criteria.Criteria_Group__c;
                criteriacloned.WM_Sync_Type__c = 'Insert';
                criteriacloned.WM_Sync_Status__c = 'Pending';
                criteriacloned.Campaign__c = mainNClonedCampIdMap.get(cm.id);
                searchCriteriaList.add(criteriacloned);
                
            }
            system.debug('**cm.CRM_CampaignOwnershipDetailsMapping__r**='+cm.CRM_CampaignOwnershipDetailsMapping__r.size());
            for(CRM_CampaignOwnershipDetail__c ownershipdetails: cm.CRM_CampaignOwnershipDetailsMapping__r) {
                CRM_CampaignOwnershipDetail__c ownershipcriteriacloned = new CRM_CampaignOwnershipDetail__c ();
                ownershipcriteriacloned.Campaign__c = mainNClonedCampIdMap.get(cm.id);
                ownershipcriteriacloned.Campaign_Location_Reference_Data_Mapping__c = ownershipdetails.Campaign_Location_Reference_Data_Mapping__c;
                searchCriteriaList.add(ownershipcriteriacloned);
            }
            system.debug('**cm.CRM_CampaignRefJunction__r**='+cm.CRM_CampaignRefJunction__r.size());
            for(CRM_CampaignRefJunction__c  ObjJO : cm.CRM_CampaignRefJunction__r){
                CRM_CampaignRefJunction__c newListRecord = new CRM_CampaignRefJunction__c (CRM_CampaignWizardReferenceData__c = ObjJO.CRM_CampaignWizardReferenceData__c,CRM_CampaignMapping__c= mainNClonedCampIdMap.get(cm.id));        
                searchCriteriaList.add(newListRecord); 
            }
               
        }
        system.debug('****searchCriteriaList='+searchCriteriaList.size());
        searchCriteriaList.sort();
        if(searchCriteriaList.size()>0)
            insert searchCriteriaList;
    }
   /*
   public void populateObjectChildren()
   {
    objectChildren = new List<relatedObjects>{};
    Set<String> childObjectTypes = new Set<String>{};
    for (Campaign_Related_List__c s: Campaign_Related_List__c.getall().values())
    childObjectTypes.add(s.name);      
    Schema.DescribeSObjectResult headDescribe = headsObject.getSObjectType().getDescribe();
    List<Schema.ChildRelationship> childRelationships = headDescribe.getChildRelationships(); 
    for (Schema.ChildRelationship childRelationship :childRelationships)
    {
      Schema.SObjectType childObjectType = childRelationship.getChildSObject();
      if (childObjectTypes.contains(childObjectType.getDescribe().getName()))
      {
        List<relatedObjectRow> relatedObjects = new List<relatedObjectRow>{};   
        Schema.SObjectField childObjectField = childRelationship.getField();         
        String relatedChildSObjectsquery = 'SELECT ID, Name FROM ' + childObjectType.getDescribe().getName()+ ' WHERE '+ childObjectField.getDescribe().getName()+ ' = \'' + headsObject.Id+ '\'';                                                         
        for (SObject childObject : Database.query(relatedChildSObjectsquery))
        {
          relatedObjects.add(new relatedObjectRow(childObject));   
          if (!relatedObjects.isEmpty())
          {
            objectChildren.add(new relatedObjects(relatedObjects, childObjectType.getDescribe().getLabelPlural(), childObjectField.getDescribe().getName()));
          }  
        }
        system.debug('**Test Cloning='+objectChildren.size()+'++++'+objectChildren);
      }
     }
  }
  public void cloneSelectedObjects()
  {
        
    List<sObject> clonedObjects = new List<sObject>{};
    List<sObject> selectedRelatedObjects;
     
    for (relatedObjects relatedObject : objectChildren)
    {
          selectedRelatedObjects = new List<sObject>{};  
          clonedObjects = new List<sObject>{};  
          
          for (relatedObjectRow row : relatedObject.objectRows) 
          {
            if (row.selected)
            {
              selectedRelatedObjects.add(row.obj);
            }
          }
          
          if (!selectedRelatedObjects.isEmpty())
          {
          
            clonedObjects = cloneObjects(selectedRelatedObjects);
            
            for (sObject clone : clonedObjects)
            {
              clone.put(relatedObject.relatedFieldName, headClone.Id);  
            }
            
            insert clonedObjects;
          }
    }
  }
    
  public void clonechildSelectedObjects(id Campid,id parentId)
  {
       
    List<sObject> clonedObjects = new List<sObject>{};
    List<sObject> selectedRelatedObjects;
     
    for (relatedObjects relatedObject : objectChildren)
    {
      selectedRelatedObjects = new List<sObject>{};  
      clonedObjects = new List<sObject>{};  
      
      for (relatedObjectRow row : relatedObject.objectRows) 
      {
        if (row.selected)
        {
          selectedRelatedObjects.add(row.obj);
        }
      }
      
      if (!selectedRelatedObjects.isEmpty())
      {
      
        clonedObjects = cloneObjects(selectedRelatedObjects);
        
        for (sObject clone : clonedObjects)
        {
          clone.put(relatedObject.relatedFieldName, parentId);  
        }
        system.debug('###clonedObjects###'+clonedObjects);
        insert clonedObjects;
      }
    }
  
 } 
 public static List<sObject> cloneObjects(List<sObject> sObjects)
  {                                            
    Schema.SObjectType objectType = sObjects.get(0).getSObjectType();
    List<Id> sObjectIds = new List<Id>{};
    List<String> sObjectFields = new List<String>{};
    List<sObject> clonedSObjects = new List<sObject>{};
    if(objectType != null)
    {
      for (Schema.SObjectField objField : objectType.getDescribe().fields.getMap().values())
      { 
        Schema.DescribeFieldResult fieldDesc = objField.getDescribe();
        if(fieldDesc.getType() != DisplayType.LOCATION)
        {
          sObjectFields.add(fieldDesc.Name);
        }
      }
    }
    if (sObjects != null ||    sObjects.isEmpty() || sObjectFields.isEmpty())
    {
          for (sObject objectInstance: sObjects)
          {
            sObjectIds.add(objectInstance.Id);
          }
          String allSObjectFieldsQuery = 'SELECT ' + sObjectFields.get(0); 
        
          for (Integer i=1 ; i < sObjectFields.size() ; i++)
          {
            allSObjectFieldsQuery += ', ' + sObjectFields.get(i);
          }
        
          allSObjectFieldsQuery += ' FROM ' + objectType.getDescribe().getName() + ' WHERE ID IN (\'' + sObjectIds.get(0) + '\'';
    
          for (Integer i=1 ; i < sObjectIds.size() ; i++)
          {
            allSObjectFieldsQuery += ', \'' + sObjectIds.get(i) + '\'';
          }
        
          allSObjectFieldsQuery += ')';
        
          system.debug('allSObjectFieldsQuery: ' + allSObjectFieldsQuery);
        
         try 
         {
              for (SObject sObjectFromDatabase:Database.query(allSObjectFieldsQuery))
              {
                 clonedSObjects.add(sObjectFromDatabase.clone(false,true));  
              }
        
         } 
         catch (exception e)
         {
         }
      
    } 
    return clonedSObjects;
  }
    
  public class relatedObjects
  {
    public List<relatedObjectRow> objectRows { get; set; }
    public String                 pluralLabel      { get; set; }
    public String                 relatedFieldName { get; set; }
    
    public relatedObjects(List<relatedObjectRow> objectRows, 
                          String pluralLabel, 
                          String relatedFieldName) 
    {
      this.objectRows       = objectRows;
      this.pluralLabel      = pluralLabel;
      this.relatedFieldName = relatedFieldName;
    }   
  }     


  public class relatedObjectRow
  {
    public sObject obj      { get; set; }
    public Boolean selected { get; set; }
    
    public relatedObjectRow(Sobject obj)
    {
      this.obj      = obj;
      // All object rows are selected by default.
      this.selected     = true;
    }
    
    public String getName(){
      try{
        return '' + obj.get('Name');
      } catch (Exception e){
        return '';
      }    
    }   
  }
  */
   //Design Change for channel vendor screen : Inactive values validation 
    public static Boolean BeforeCloneValidation(id campid){//PP4
        set<id> cmpaignsIds = new set<id>();
        if(isClone){
            for(Campaign cmp : [select id,(select id from CRM_SegmentedParentCampaigns__r) from Campaign where id=:campid]){
                cmpaignsIds.add(cmp.id);
                for(Campaign cm :cmp.CRM_SegmentedParentCampaigns__r){
                    cmpaignsIds.add(cm.id); 
                }
            }
        }else
            cmpaignsIds.add(campid);
            
        string errorMessage=ClonePlusController.inactiveOptionAlertMessage(cmpaignsIds,false);//PP4
        if(!string.isBlank(errorMessage)){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING,System.Label.CRM_Home_Address_Criteria_Clone+'<br/>'+errorMessage));
            return false;
        }else{
            System.debug('>>>>>>Validation Successful<<<<<<');
            return true;
        }
    }
    public static string inactiveOptionAlertMessage(set<id> campId,boolean isCloneCampaignOnly){
        String errorMessage;
        map<string,list<string>> inactiveValuesMap= new map<string,list<string>>();
        
        for(CRM_CampaignWizardReferenceData__c objCRMRefVals :[Select id,Recordtypeid ,CRM_VendorName__c,CRM_CallToAction__c, CRM_Channel__c,CRM_ServiceLine__c,CRM_ServiceSubServiceLine__c ,CRM_SubServiceLine__c, Recordtype.Developername,Recordtype.Name   FROM CRM_CampaignWizardReferenceData__c WHERE id IN (select CRM_CampaignWizardReferenceData__c  from CRM_CampaignRefJunction__c where CRM_CampaignMapping__c IN:campid)and CRM_IsActive__c=:false]){
            
            string str;    
            if (objCRMRefVals.Recordtype.Developername =='ChannelValues')
             str=objCRMRefVals.CRM_Channel__c;                     
            else if (objCRMRefVals.Recordtype.Developername =='Call_To_Action')
             str=objCRMRefVals.CRM_CallToAction__c;  
            else if (objCRMRefVals.Recordtype.Developername =='Vendor_Name')
             str=objCRMRefVals.CRM_VendorName__c;  
            else if (objCRMRefVals.Recordtype.Developername =='Service_Line')
             str=objCRMRefVals.CRM_ServiceLine__c;  
            else if (objCRMRefVals.Recordtype.Developername =='Sub_Service_Line')
             str=objCRMRefVals.CRM_ServiceSubServiceLine__c;
            
            if(!inactiveValuesMap.containsKey(objCRMRefVals.Recordtype.Name))
                inactiveValuesMap.put(objCRMRefVals.Recordtype.Name,new list<string>{str});
            else
                inactiveValuesMap.get(objCRMRefVals.Recordtype.Name).add(str);
        }
             
        for(CRM_CampaignLocationReferenceData__c ownerRefVals :[Select id,Recordtypeid ,CRM_Region__c,CRM_Market__c, CRM_Hospital__c,CRM_MarketRegion__c,  CRM_HospitalMarket__c ,Recordtype.Developername,Recordtype.Name FROM CRM_CampaignLocationReferenceData__c WHERE id IN (select Campaign_Location_Reference_Data_Mapping__c  from CRM_CampaignOwnershipDetail__c where Campaign__c IN:campid )and CRM_IsActive__c=false]){   
            String str;
            if (ownerRefVals.Recordtype.Developername=='Region')
             str=ownerRefVals.CRM_Region__c;      
            else if (ownerRefVals.Recordtype.Developername=='Market') 
             str=ownerRefVals.CRM_Market__c;  
            else if (ownerRefVals.Recordtype.Developername=='Hospital') 
             str=ownerRefVals.CRM_Hospital__c;
            
            if(!inactiveValuesMap.containsKey(ownerRefVals.Recordtype.Name))
                inactiveValuesMap.put(ownerRefVals.Recordtype.Name,new list<string>{str});
            else
                inactiveValuesMap.get(ownerRefVals.Recordtype.Name).add(str);
        }
        //In case we are creating campaign from template or adding a child campaing 
        //then audience criteria will not be copied and hance no need to check inactive value
        if(!isCloneCampaignOnly){
            //Check Audience Screen service line and sub service line
            for(CRM_EncounterServiceLineSelection__c ssl :[select CRM_AudienceCriteriaReferenceData__c,CRM_Encounter__c,CRM_AudienceCriteriaReferenceData__r.CRM_IsActive__c,CRM_AudienceCriteriaReferenceData__r.CRM_ClinicalServiceLine__c,CRM_AudienceCriteriaReferenceData__r.CRM_ServiceSubServiceLine__c from CRM_EncounterServiceLineSelection__c where CRM_Encounter__r.Campaign__c IN:campId AND CRM_AudienceCriteriaReferenceData__r.CRM_IsActive__c=false]){
                
                if(ssl.CRM_AudienceCriteriaReferenceData__r.CRM_ClinicalServiceLine__c!=null){
                    
                    if(!inactiveValuesMap.containsKey('Encounter Service Line'))
                        inactiveValuesMap.put('Encounter Service Line',new list<string>{ssl.CRM_AudienceCriteriaReferenceData__r.CRM_ClinicalServiceLine__c});
                    else
                        inactiveValuesMap.get('Encounter Service Line').add(ssl.CRM_AudienceCriteriaReferenceData__r.CRM_ClinicalServiceLine__c);
                    
                }else{
                    if(!inactiveValuesMap.containsKey('Encounter Sub Service Line'))
                        inactiveValuesMap.put('Encounter Sub Service Line',new list<string>{ssl.CRM_AudienceCriteriaReferenceData__r.CRM_ServiceSubServiceLine__c});
                    else
                        inactiveValuesMap.get('Encounter Sub Service Line').add(ssl.CRM_AudienceCriteriaReferenceData__r.CRM_ServiceSubServiceLine__c);
                }
                    
            }
            
            for(CRM_EncounterHospitalJuntion__c ssl :[select CRM_CampaignLocationMapping__c,CRM_Encounter__c,CRM_CampaignLocationMapping__r.CRM_IsActive__c,CRM_Hospital__c from CRM_EncounterHospitalJuntion__c where CRM_Encounter__r.Campaign__c IN:campId AND CRM_CampaignLocationMapping__r.CRM_IsActive__c=false]){
                
                if(!inactiveValuesMap.containsKey('Encounter Hospital'))
                    inactiveValuesMap.put('Encounter Hospital',new list<string>{ssl.CRM_Hospital__c});
                else
                    inactiveValuesMap.get('Encounter Hospital').add(ssl.CRM_Hospital__c);
            }
            
            for(CRM_EncounterAggHospitalJunction__c ssl :[select CRM_CampaignLocationEncAggMapping__c   ,CRM_EnocunterAggregates__c,CRM_CampaignLocationEncAggMapping__r.CRM_IsActive__c,CRM_Hospital__c from CRM_EncounterAggHospitalJunction__c where CRM_EnocunterAggregates__r.Campaign__c IN:campId AND CRM_CampaignLocationEncAggMapping__r.CRM_IsActive__c=false]){
                if(!inactiveValuesMap.containsKey('Encounter Aggregates Hospital'))
                    inactiveValuesMap.put('Encounter Aggregates Hospital',new list<string>{ssl.CRM_Hospital__c});
                else
                    inactiveValuesMap.get('Encounter Aggregates Hospital').add(ssl.CRM_Hospital__c);
            }
                
           for(CRM_Search_Criteria__c hsl : [select id,CRM_Campaign__c,CRM_Search_Criteria_Level_1__c,CRM_Search_Criteria_Level_2__c,CRM_Search_Criteria_Level_3__c,CRM_AdditionalZipCodes__c,CRM_ExcludedZipCodes__c from CRM_Search_Criteria__c where CRM_Campaign__c IN:campId limit 1]){
                string homeaddress = hsl.CRM_Search_Criteria_Level_1__c;
                string mapKey;
                if(homeaddress=='By Region' || homeaddress=='By Market' || homeaddress=='By Hospital' || homeaddress=='By Distance'){
                    list<string> saCode = hsl.CRM_Search_Criteria_Level_2__c.split(';');
                    System.debug('***saCode ='+saCode );
                    for(CRM_CampaignLocationReferenceData__c clrs : [select id,CRM_ServiceArea__c,Recordtype.Name from CRM_CampaignLocationReferenceData__c where CRM_ServiceAreaCode__c IN: saCode AND CRM_IsActive__c=false]){
                        mapKey = 'Home Address '+clrs.Recordtype.Name;
                        if(!inactiveValuesMap.containsKey(mapKey))
                            inactiveValuesMap.put(mapKey,new list<string>{clrs.CRM_ServiceArea__c});
                        else
                            inactiveValuesMap.get(mapKey).add(clrs.CRM_ServiceArea__c);
                    }
                    
                    list<string> level3Codes = hsl.CRM_Search_Criteria_Level_3__c.split(';');
                    for(CRM_CampaignLocationReferenceData__c clrs : [select id,CRM_Hospital__c,CRM_Market__c,CRM_Region__c,RecordType.Name from CRM_CampaignLocationReferenceData__c where (CRM_HospitalCode__c IN: level3Codes OR CRM_MarketCode__c IN: level3Codes OR CRM_RegionCode__c IN: level3Codes) AND CRM_IsActive__c=false]){
                        String str;
                        if(homeaddress=='By Region')
                            str =clrs.CRM_Region__c; 
                        else if(homeaddress=='By Market')
                            str =clrs.CRM_Market__c;
                        else if(homeaddress=='By Hospital' || homeaddress=='By Distance')
                            str =clrs.CRM_Hospital__c;
                        mapKey = 'Home Address '+clrs.Recordtype.Name;
                        if(!inactiveValuesMap.containsKey(mapKey))
                            inactiveValuesMap.put(mapKey,new list<string>{str});
                        else
                            inactiveValuesMap.get(mapKey).add(str);
                    }
                }
                
                if(homeaddress=='By State' || homeaddress=='By County' || homeaddress=='By CBSA'){
                    list<string> saCode = hsl.CRM_Search_Criteria_Level_2__c.split(';');
                    set<id> stateIds = new set<id>();
                    
                    for(CRM_CampaignGeographyReferenceData__c clrs : [select id,CRM_CBSA__c,Recordtype.Name,CRM_State__c,CRM_IsActive__c from CRM_CampaignGeographyReferenceData__c where (CRM_StateCode__c IN: saCode OR CRM_CBSA__c IN: saCode)]){
                        string str;
                        if(homeaddress=='By State' || homeaddress=='By County'){
                            str=clrs.CRM_State__c;
                            stateIds.add(clrs.id);
                        }else if(homeaddress=='By CBSA')
                            str=clrs.CRM_CBSA__c;
                            
                        mapKey = 'Home Address '+clrs.Recordtype.Name;
                        
                        if(!clrs.CRM_IsActive__c){
                            if(!inactiveValuesMap.containsKey(mapKey))
                                inactiveValuesMap.put(mapKey,new list<string>{str});
                            else
                                inactiveValuesMap.get(mapKey).add(str);
                        }
                        
                    }
                    
                    if(hsl.CRM_Search_Criteria_Level_3__c!=null){
                        list<string> level3Codes = hsl.CRM_Search_Criteria_Level_3__c.split(';');
                        for(CRM_CampaignGeographyReferenceData__c clrs : [select id,CRM_County__c,Recordtype.Name from CRM_CampaignGeographyReferenceData__c where CRM_CountysStateID__c IN:stateIds AND CRM_County__c IN: level3Codes AND CRM_IsActive__c=false]){
                            mapKey = 'Home Address '+clrs.Recordtype.Name;
                            if(!inactiveValuesMap.containsKey(mapKey))
                                inactiveValuesMap.put(mapKey,new list<string>{clrs.CRM_County__c});
                            else
                                inactiveValuesMap.get(mapKey).add(clrs.CRM_County__c);
                        }
                        
                    }
                    
                    
                }
            }
        }
        if(inactiveValuesMap.size()>0){
            for(String str : inactiveValuesMap.keySet()){
                if(inactiveValuesMap.get(str)!=null){
                    if(string.isBlank(errorMessage))
                        errorMessage = str +' : '+string.join(inactiveValuesMap.get(str),', ');
                    else
                        errorMessage += '<br/>'+str +' : '+string.join(inactiveValuesMap.get(str),', ');
                }
            }
        }
        return errorMessage;
    }
    //Design Change for channel vendor screen : Inactive values validation 
       
    /* Start :Clone Junction object values for channel screen and Campaign Details service/sub servic line */   
    /*Public void CloneSelectedPicklistValues(String campid,String cloneCampid )   
    { 
            List<CRM_CampaignRefJunction__c> listToBeCloned = new List<CRM_CampaignRefJunction__c> ();       
            for(CRM_CampaignRefJunction__c  ObjJO : [select id,CRM_CampaignWizardReferenceData__c,CRM_CampaignMapping__c  from CRM_CampaignRefJunction__c where CRM_CampaignMapping__c=:campid  ]) 
            {
                CRM_CampaignRefJunction__c newListRecord = new CRM_CampaignRefJunction__c (CRM_CampaignWizardReferenceData__c = ObjJO.CRM_CampaignWizardReferenceData__c,CRM_CampaignMapping__c= cloneCampid );        
                listToBeCloned.add(newListRecord ); 
            }
            if(listToBeCloned.size()>0) insert listToBeCloned;   
    }*/
    /*End : Clone Junction object values for channel screen and Campaign Details service/sub servic line */  

    /* Start :Clone Junction object values Encounter Hospital object */   
    public void cloneEncounterJunctionCriteria(map<id,id>  mainNClonedCampIdMap){
        map<Id,Id> clonedEncounterIds=new map<Id,Id>();
        for(Encounter__c er :[select id,Campaign__c from Encounter__c where Campaign__c=:mainNClonedCampIdMap.values()]){
            clonedEncounterIds.put(er.Campaign__c,er.id);
        } 
        if(clonedEncounterIds.size()>0){
            list<string> inactiveHospitals= new list<string>();
            list<CRM_EncounterHospitalJuntion__c> EncounterHospitalSelectionLIst = new list<CRM_EncounterHospitalJuntion__c>();
            for(CRM_EncounterHospitalJuntion__c ssl :[select CRM_CampaignLocationMapping__c,CRM_Encounter__c,CRM_CampaignLocationMapping__r.CRM_IsActive__c,CRM_Hospital__c,CRM_Encounter__r.Campaign__c from CRM_EncounterHospitalJuntion__c where CRM_Encounter__r.Campaign__c=:mainNClonedCampIdMap.keySet()]){
                EncounterHospitalSelectionLIst.add(new CRM_EncounterHospitalJuntion__c(CRM_CampaignLocationMapping__c=ssl.CRM_CampaignLocationMapping__c,CRM_Encounter__c=clonedEncounterIds.get(mainNClonedCampIdMap.get(ssl.CRM_Encounter__r.Campaign__c))));
                
            }
            if(EncounterHospitalSelectionLIst.size()>0)
                insert EncounterHospitalSelectionLIst;
            
            
            list<CRM_EncounterServiceLineSelection__c> serviceLIneAudienceSelectionLIst = new list<CRM_EncounterServiceLineSelection__c>();
            for(CRM_EncounterServiceLineSelection__c ssl :[select CRM_AudienceCriteriaReferenceData__c,CRM_Encounter__c,CRM_AudienceCriteriaReferenceData__r.CRM_IsActive__c,CRM_AudienceCriteriaReferenceData__r.CRM_ClinicalServiceLine__c,CRM_AudienceCriteriaReferenceData__r.CRM_ServiceSubServiceLine__c,CRM_Encounter__r.Campaign__c from CRM_EncounterServiceLineSelection__c where CRM_Encounter__r.Campaign__c=:mainNClonedCampIdMap.keySet()]){
                serviceLIneAudienceSelectionLIst.add(new CRM_EncounterServiceLineSelection__c(CRM_AudienceCriteriaReferenceData__c=ssl.CRM_AudienceCriteriaReferenceData__c,CRM_Encounter__c=clonedEncounterIds.get(mainNClonedCampIdMap.get(ssl.CRM_Encounter__r.Campaign__c))));
            }
            if(serviceLIneAudienceSelectionLIst.size()>0)
                insert serviceLIneAudienceSelectionLIst;    
        }
    }
    
    /* Start :Clone Junction object values Encounter aggregates Hospital object */   
    public void cloneEncounterAggregatesJunctionCriteria(map<id,id>  mainNClonedCampIdMap){
        map<id,id> clonedEncounterAggregatesIds = new map<id,id>();
        for(Encounter_aggregates__c er :[select id,Campaign__c from Encounter_aggregates__c where Campaign__c=:mainNClonedCampIdMap.values()]){
            clonedEncounterAggregatesIds.put(er.Campaign__c, er.id);
        } 
        if(clonedEncounterAggregatesIds.size()>0){
            list<string> inactivePreferedHospitals= new list<string>();
            list<CRM_EncounterAggHospitalJunction__c> EncounterAggregatesHospitalSelectionLIst = new list<CRM_EncounterAggHospitalJunction__c>();
            CRM_EncounterAggHospitalJunction__c clonedCriteria;
            for(CRM_EncounterAggHospitalJunction__c ssl :[select CRM_CampaignLocationEncAggMapping__c   ,CRM_EnocunterAggregates__c,CRM_CampaignLocationEncAggMapping__r.CRM_IsActive__c,CRM_Hospital__c,CRM_EnocunterAggregates__r.Campaign__c from CRM_EncounterAggHospitalJunction__c where CRM_EnocunterAggregates__r.Campaign__c=:mainNClonedCampIdMap.keySet()]){
                clonedCriteria = new CRM_EncounterAggHospitalJunction__c(CRM_CampaignLocationEncAggMapping__c=ssl.CRM_CampaignLocationEncAggMapping__c,CRM_EnocunterAggregates__c=clonedEncounterAggregatesIds.get(mainNClonedCampIdMap.get(ssl.CRM_EnocunterAggregates__r.Campaign__c)));
                EncounterAggregatesHospitalSelectionLIst.add(clonedCriteria);
                
            }
                
            if(EncounterAggregatesHospitalSelectionLIst.size()>0)
                insert EncounterAggregatesHospitalSelectionLIst;    
        }
    }
    /*
    public void clonesegmentedcampaign(id campid,Id newParentCampaignId)
    {
    
        
       set<String> clonedSegmentesIds= new Set<String>();        
        for(Campaign cc: [Select id, segment__c,name, Member_Types__c, CRM_ParentSegmentedCampaign__c from campaign where CRM_ParentSegmentedCampaign__c=: campid ])
        {   
            String childname= ReferenceData_PicklistController.getCampaignName(cc.id);
            Campaign newSegmentedCampaign= new campaign(segment__c=cc.Segment__c,name= childname, Member_Types__c=cc.Member_Types__c, CRM_ParentSegmentedCampaign__c=newParentCampaignId) ;
            Insert newSegmentedCampaign;
            
                
            
        }
      
    }
    */
    //PP4 Changes Start here
    public string queryString(string objectApiName,string relationshipName){
        string query;
        string childCampaignFieldSet;
        for (Schema.SObjectField objField : schemaMap.get(objectApiName).getDescribe().fields.getMap().values()){ 
            Schema.DescribeFieldResult fieldDesc = objField.getDescribe();
            if(fieldDesc.getType() != DisplayType.LOCATION){
              //system.debug('&&&&&='+fieldDesc.Name);
              if(string.isBlank(query)){
                query = 'select '+fieldDesc.Name;childCampaignFieldSet=fieldDesc.Name;
              }else{
                query += ','+fieldDesc.Name;childCampaignFieldSet+= ','+fieldDesc.Name;
              } 
            }
        }
        if(string.isBlank(relationshipName)){
            if(objectApiName.equalsIgnoreCase('Campaign')){
                query += ',(select '+childCampaignFieldSet+' from CRM_SegmentedParentCampaigns__r)';
            }
            query += ' from '+objectApiName;
        }else
            query += ' from '+relationshipName;
        
        return query;
    }
    //PP4 Changes Ends here
}
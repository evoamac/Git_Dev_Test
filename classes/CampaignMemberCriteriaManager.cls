/* This class named CampaignMemberCriteriaManager is handling INSERT/UPDATE/DELETE Operations of Wunderman API Calls
   and also storing the criteria in Salesforce */

public class CampaignMemberCriteriaManager 
{     
    
    public CampaignMemberCriteriaManager(ApexPages.StandardController acon) { }
    // This method is used to insert the criteria through the wunderman API calls.
    public static void insertCriteria(string fieldName, string value,Id campaignId, boolean exclude, string objectname)
    {
        Map<string, string> criteriasMap = new Map<string, string>();
        criteriasMap.put(fieldName, value);
        // starting of defect 835
       Integer i = [SELECT count() FROM Campaign_Member_Criteria__c WHERE Campaign__c =:campaignId AND Field_Name__c =:fieldName AND Exclude__c=:exclude];
        //This will handle the case when user perform delete all and then add zip code again before doing refresh count
        if(i>0)
            updateCriterias(criteriasMap, campaignId, exclude);
        else
            insertCriterias(criteriasMap, campaignId, exclude, objectname);
        
        // ending of defect 835    
    }
   
   
   
    // This method is used to insert the criteria through the wunderman API calls.
    public static void insertCriterias(Map<String, String> criteriasMap, Id campaignId, boolean exclude, string objectname)
    {       
    
    
        //Starting of defect duplicate criteria in audience for other screen
        Map<String, String> criteriasMapCMC =new Map<String, String>();
    
        for (Campaign_Member_Criteria__c CMCField :[SELECT Field_Name__c FROM Campaign_Member_Criteria__c WHERE Campaign__c =:campaignId AND Field_Name__c IN:criteriasMap.keySet() AND Exclude__c=:exclude  ])
        {
              system.debug('**********CMCField value *******'+CMCField );
           
              if (criteriasMap.containsKey(CMCField.Field_Name__c))
              {
                  criteriasMapCMC.put(CMCField.Field_Name__c,criteriasMap.get(CMCField.Field_Name__c)); 
                  criteriasMap.remove(CMCField.Field_Name__c);
                  system.debug('**********criteriasMap value inside*******'+criteriasMap);
                  system.debug('**********criteriasMapCMC value inside*******'+criteriasMapCMC);
              }
          
       }    
        system.debug('**********criteriasMapCMC*******'+criteriasMapCMC);
    
        if (!criteriasMapCMC.isEmpty())
        {
        
        system.debug('**********updateCriteriascriteriasMapCMC*******'+criteriasMapCMC);
        updateCriterias(criteriasMapCMC,campaignId, exclude);
        }
        //Ending of defect duplicate criteria in audience for other screen
    
    
    
        system.debug('**********criteriasMap*******'+criteriasMap);
        system.debug('**********campaignId*******'+campaignId);
        system.debug('**********exclude*******'+exclude);
        system.debug('**********objectname*******'+objectname);
        List<Campaign_Member_Criteria__c> lstCriterias = new List<Campaign_Member_Criteria__c> ();
        // Added for Audience Selection criteria story Service-SubService line
        /*List<Campaign_Member_Criteria__c> lstCampaignMemCrtieriaServline = new List<Campaign_Member_Criteria__c> ();
        lstCampaignMemCrtieriaServline = [SELECT Value__c,Field_Name__c FROM Campaign_Member_Criteria__c WHERE Campaign__c =:campaignId AND Field_Name__c = 'CRM_ServiceLine__c'];
        for(String fieldName : criteriasMap.keySet()) {
          if(objectname =='Encounter__c' && fieldName == 'CRM_SubServiceLine__c') {
              criteriasMap.remove('CRM_ServiceLine__c'); 
              
          }                   
        }
        System.debug('criteriasMap*******'+criteriasMap);*/
        // end of Audience Selection criteria story Service-SubService line
        for(String fieldName : criteriasMap.keySet())
        {
            Campaign_Member_Criteria__c criteria = new Campaign_Member_Criteria__c();
            criteria.WM_Sync_Type__c = 'Insert';
            criteria.WM_Sync_Status__c = 'Pending';
            criteria.Campaign__c = campaignId;
            criteria.Field_Name__c = fieldName;
            criteria.Exclude__c = exclude;
            criteria.Value__c = criteriasMap.get(fieldName); 
            // Added for Audience Selection criteria story birthMonth
            if(objectname =='Campaign_Demographics__c' && (criteria.Value__c.contains('Current Month') || criteria.Value__c.contains('Next Month'))) {
                if(criteria.Value__c.contains('Current Month') && !criteria.Value__c.contains('Next Month'))
                    criteria.Value__c = criteria.Value__c.replaceAll('Current Month', returnCurrentandNextmonth ('Current Month',campaignId));                
                else if(!criteria.Value__c.contains('Current Month') && criteria.Value__c.contains('Next Month')) 
                    criteria.Value__c = criteria.Value__c.replaceAll('Next Month', returnCurrentandNextmonth ('Next Month',campaignId));
                else if(criteria.Value__c.contains('Current Month') && criteria.Value__c.contains('Next Month')) {
                    String currnextMonth = 'Current Month';
                    criteria.Value__c = criteria.Value__c.replaceAll('Current Month', returnCurrentandNextmonth (currnextMonth ,campaignId));
                    currnextMonth = 'Next Month';
                    criteria.Value__c = criteria.Value__c.replaceAll('Next Month', returnCurrentandNextmonth (currnextMonth ,campaignId));
                }
            }
            // end of Added for Audience Selection criteria story birthMonth
           
            if(objectname=='ICD_Diagnosis_In__c')
                criteria.Field_id__c = 'Diagnosis Codes';
            else if(objectname=='Procedure_Information__c')
                criteria.Field_id__c = 'Procedure Codes';
            else if(objectname=='DRG_Code_Information__c')
                criteria.Field_id__c = 'DRG Codes';
            else if(objectname=='Geographic_Info_Information__c' || objectname=='Campaign_Location__c')
                criteria.Field_id__c = 'ZIP Code';
            else if(fieldName == 'Facility_ID__c')
                criteria.Field_id__c = 'Facility IDs';
            else if(fieldName == 'Member_Types__c')
                criteria.Field_id__c = 'Member Type';
            else
                criteria.Field_id__c = returnLabelNames(objectname).get(fieldName); 
            
            lstCriterias.add(criteria); 
             system.debug('**********lstCriterias*******'+lstCriterias);   
                       
        } 
        
        addCategoryInfoToCriterias(lstCriterias);
        
        Map<String, Campaign_Member_Criteria_Group__c> criteriaGroupsMap = getCriteriaGroupMap(lstCriterias, campaignId, exclude);
        system.debug('Formed Criteria Groups Map: ' + criteriaGroupsMap);
        
        for(Campaign_Member_Criteria__c criteria: lstCriterias)
        {
            string criteriaGroupkey = criteria.Category__c; 
            Campaign_Member_Criteria_Group__c criteriaGroup = criteriaGroupsMap.get(criteriaGroupkey);
            decimal groupNumber = 0;
            if(criteriaGroup != null)
            {
                groupNumber = criteriaGroup.Group_Number__c;
                criteria.Operator__c = criteriaGroup.Inner_Operator__c;
            }
        }
        if(criteriaGroupsMap.size()>0)
        {
            List<Campaign_Member_Criteria_Group__c> lstCriteriaGroups = new list<Campaign_Member_Criteria_Group__c>();
            for(string category: criteriaGroupsMap.keyset())
            {
                Campaign_Member_Criteria_Group__c criteriaGroup = criteriaGroupsMap.get(category);
                if(criteriaGroup!= null && criteriaGroup.Id == null)
                    lstCriteriaGroups.add(criteriaGroup);
            }           
            if(lstCriteriaGroups.size()>0)
                insert lstCriteriaGroups;
            system.debug('Inserted New Criteria Groups: ' + lstCriteriaGroups);
        }
        
        for(Campaign_Member_Criteria__c criteria: lstCriterias)
        {
            criteria.Campaign__c = campaignId;
            if(criteriaGroupsMap.size()>0)
            {
                string criteriaGroupkey = criteria.Category__c;
                Campaign_Member_Criteria_Group__c criteriaGroup = criteriaGroupsMap.get(criteriaGroupkey);
                if(criteriaGroup!= null)
                    criteria.Criteria_Group__c = criteriaGroup.Id;
            }
          }
        insert lstCriterias;
        system.debug('Criterias Inserted: ' + lstCriterias);
             
    }
    
    // This method is used to update the criteria through the wunderman API calls.
    public static void updateCriteria(string fieldName, string value,Id campaignId, boolean exclude)
    {
        Map<string, string> criteriasMap = new Map<string, string>();
        criteriasMap.put(fieldName, value);
        updateCriterias(criteriasMap, campaignId, exclude);
    }
    
    // This method is used to update the criteria through the wunderman API calls.
    public static void updateCriterias(Map<string, string> criteriasMap, Id campaignId, boolean exclude)
    {     
        
        // Added for Audience Selection criteria story Service-SubService line
        /*for(String fieldName : criteriasMap.keySet()) {
          if(fieldName == 'CRM_SubServiceLine__c') {
              criteriasMap.remove('CRM_ServiceLine__c');
              
           }
           else if(fieldName == 'CRM_ServiceLine__c') {
               criteriasMap.remove('CRM_SubServiceLine__c');       
               
           }
        }
        System.debug('criteriasMap*******'+criteriasMap);*/
        // end of Audience Selection criteria story Service-SubService line
        List<Campaign_Member_Criteria__c> lstCriterias = [SELECT Id, Field_Name__c, WM_Criteria_Id__c FROM Campaign_Member_Criteria__c WHERE Campaign__c =:campaignId AND Field_Name__c IN: criteriasMap.keyset() AND Exclude__c=:exclude];
        
        for(Campaign_Member_Criteria__c criteria: lstCriterias)
        {
            criteria.Value__c = criteriasMap.get(criteria.Field_Name__c);
            // Added for Audience Selection criteria story birthMonth
            if(criteria.Value__c.contains('Current Month') || criteria.Value__c.contains('Next Month')) {
                if(criteria.Value__c.contains('Current Month') && !criteria.Value__c.contains('Next Month'))
                    criteria.Value__c = criteria.Value__c.replaceAll('Current Month', returnCurrentandNextmonth ('Current Month',campaignId));                
                else if(!criteria.Value__c.contains('Current Month') && criteria.Value__c.contains('Next Month')) 
                    criteria.Value__c = criteria.Value__c.replaceAll('Next Month', returnCurrentandNextmonth ('Next Month',campaignId));
                else if(criteria.Value__c.contains('Current Month') && criteria.Value__c.contains('Next Month')) {
                    String currnextMonth = 'Current Month';
                    criteria.Value__c = criteria.Value__c.replaceAll('Current Month', returnCurrentandNextmonth (currnextMonth ,campaignId));
                    currnextMonth = 'Next Month';
                    criteria.Value__c = criteria.Value__c.replaceAll('Next Month', returnCurrentandNextmonth (currnextMonth ,campaignId));
                }
            }
            // end of Added for Audience Selection criteria story birthMonth
            if(criteria.WM_Criteria_Id__c==null)
                criteria.WM_Sync_Type__c = 'Insert';
            else
                criteria.WM_Sync_Type__c = 'Update';
            criteria.WM_Sync_Status__c = 'Pending';
        }
   
        if(lstCriterias.size()>0)
        {
            update lstCriterias;
            system.debug('Criterias updated: ' + lstCriterias);
        }        
    }   
    
    // This method is used to update the criteria through the wunderman API calls.
    public static void deleteCriteria(string fieldName, Id campaignId, boolean exclude)
    {
        System.debug('*******fieldName******'+fieldName+'*****campaignId***'+campaignId+'***exclude****'+exclude);
        Map<string, string> criteriasMap = new Map<string, string>();
        criteriasMap.put(fieldName, '');
        deleteCriterias(criteriasMap, campaignId, exclude);
    }
      
    // This method is used to delete the criteria through the wunderman API calls.
    public static void deleteCriterias(Map<string, string> criteriasMap, Id campaignId, boolean exclude)
    {
        List<Campaign_Member_Criteria__c> lstCriterias = [SELECT Id, WM_Criteria_Id__c,field_Name__c,Value__c FROM Campaign_Member_Criteria__c WHERE Campaign__c =:campaignId AND Field_Name__c IN: criteriasMap.keyset() AND Exclude__c=:exclude];
        List<Campaign_Member_Criteria__c> updateCriterias = new List<Campaign_Member_Criteria__c>();
        List<Campaign_Member_Criteria__c> deleteCriterias = new List<Campaign_Member_Criteria__c>();
                
        for(Campaign_Member_Criteria__c criteria: lstCriterias)
        {
            
            if(criteria.WM_Criteria_Id__c == null)
                deleteCriterias.add(criteria);
            else
            {
                criteria.WM_Sync_Type__c = 'Delete';
                criteria.WM_Sync_Status__c = 'Pending';
                updateCriterias.add(criteria);
            }
        }
        
        if(updateCriterias.size()>0)
        {
            update updateCriterias;
            system.debug('Criterias marked for deletion: ' + updateCriterias);
        }
        
        if(deleteCriterias.size()>0)
        {
            delete deleteCriterias;
            system.debug('Criterias deleted: ' + deleteCriterias);
        }
   } 
         
    private static Map<String, Campaign_Member_Criteria_Group__c> getCriteriaGroupMap(List<Campaign_Member_Criteria__c> lstCriterias, Id campaignId, boolean exclude)
    {
    
    
    system.debug('********lstCriterias*******'+lstCriterias);
    
        Campaign objCampaign = [SELECT Id, List_Order_Exclude_Grp_Id__c, List_Order_Select_Grp_Id__c FROM Campaign WHERE Id=:campaignId];
        system.debug('********objCampaign *******'+objCampaign );

        //Create a category wise map of the groups that already exist 
        Map<String, Campaign_Member_Criteria_Group__c> criteriaGroupsMap = new Map<String, Campaign_Member_Criteria_Group__c>();
        for(Campaign_Member_Criteria_Group__c criteriaGroup: [Select Group_Name__c,Inner_Operator__c, Id, WM_CriteriaGroup_Id__c, Group_Number__c, WM_Parent_group_Id__c, Exclude__c FROM Campaign_Member_Criteria_Group__c WHERE Campaign__c=:campaignId AND Exclude__c=:exclude])
            criteriaGroupsMap.put(criteriaGroup.Group_Name__c, criteriaGroup);   
        system.debug('criteriaGroupsMap: ' + criteriaGroupsMap);
                
        //Generate a list of the missing groups that need to be insert and add these to the criteriaGroupsMap 
       for(Campaign_Member_Criteria__c criteria: lstCriterias)
        {
        
         system.debug('******criteria****** ' + criteria);
            string criteriaGroupkey = criteria.Category__c; 
            if(!criteriaGroupsMap.containsKey(criteriaGroupkey))
            {
            system.debug('******criteriaGroupsMap****** ' + criteriaGroupsMap);
                Campaign_Member_Search_Critera__c cs = Campaign_Member_Search_Critera__c.getValues(criteria.Category__c);
                if(cs.Requires_SubGroup__c)
                {
                    Campaign_Member_Criteria_Group__c criteriaGroup = new Campaign_Member_Criteria_Group__c();
                    criteriaGroup.Campaign__c = campaignId;
                    criteriaGroup.Group_Name__c = criteriaGroupkey;
                    criteriaGroup.Exclude__c = criteria.Exclude__c;
                    criteriaGroup.Campaign__c = campaignId;
                    criteriaGroup.Inner_Operator__c = cs.Inner_Operator__c;
                    criteriaGroup.Outer_Operator__c = cs.Outer_Operator__c;
                    criteriaGroup.Group_Number__c = criteriaGroupsMap.size()>0?getNewGroupNumber(criteriaGroupsMap):1;
                    criteriaGroupsMap.put(criteriaGroupkey, criteriaGroup);
                    
                    
            system.debug('******criteriaGroupsMap2****** ' + criteriaGroupsMap);
                }
                else
                    criteriaGroupsMap.put(criteriaGroupkey, null);
                    
            system.debug('******criteriaGroupsMap3****** ' + criteriaGroupsMap);
            }       
        }
              
            system.debug('******criteriaGroupsMap4****** ' + criteriaGroupsMap);
        return criteriaGroupsMap;
    }
    
    private static decimal getNewGroupNumber(Map<String, Campaign_Member_Criteria_Group__c> criteriaGroupsMap)
    {
        decimal  n = 0;
        for(Campaign_Member_Criteria_Group__c criteriaGroup: criteriaGroupsMap.values())
        {
           if(criteriaGroup!=null && criteriaGroup.Group_Number__c!=null) {
              if(n<criteriaGroup.Group_Number__c)
                n = criteriaGroup.Group_Number__c;
             }
        } 
        n++;
        return n;
    }
    
    private static void addCategoryInfoToCriterias(List<Campaign_Member_Criteria__c> lstCriterias)
    {
    
       system.debug('********lstCriterias*******'+lstCriterias);
        Set<string> criteriaFields = new Set<string>();
        for(Campaign_Member_Criteria__c criteria: lstCriterias)
            criteriaFields.add(criteria.Field_Name__c);
        system.debug('********criteriaFields *******'+criteriaFields );
        Map<String, Data_Element_Identifier__c> fieldGroupsMap = new Map<String, Data_Element_Identifier__c>();
        for(Data_Element_Identifier__c element: [SELECT Field_Name__c, Id, Criteria_Group_Name__c FROM Data_Element_Identifier__c WHERE Field_Name__c IN: criteriaFields])
            fieldGroupsMap.put(element.Field_Name__c, element); 
        system.debug('fieldGroupsMap: ' + fieldGroupsMap);
        
        for(Campaign_Member_Criteria__c criteria: lstCriterias)
        {
        
          system.debug('******criteria*****' + criteria);
        //criteria.Field_Name__c == 'Diagnosis_Code__c'|| criteria.Field_Name__c == 'CRM_SubServiceLine__c'|| 
          if(criteria.Field_Name__c == 'Diagnosis_Code__c' || criteria.Field_Name__c == 'Procedure_Code__c')
              criteria.Category__c = 'Encounter Codes';
          else
              criteria.Category__c = fieldGroupsMap.get(criteria.Field_Name__c).Criteria_Group_Name__c;
           system.debug('******criteria.Category__c*****' + criteria.Category__c);        
        }
    }
         
    public static void addCampaignMemberCriteriasForClonedCampaign(List<Campaign_Member_Criteria__c> lstCriterias, String lstorderid, String lstordergrpid,String lstorderexgrpid, Campaign objcampaign, id clonedCampid)
    {       
        boolean exclude = lstCriterias[0].Exclude__c;
        List<Campaign_Member_Criteria__c> lstclonedCriteriaToBeInserted = new List<Campaign_Member_Criteria__c> ();
               system.debug('****exclude'+exclude);
               system.debug('****lstorderexgrpid'+lstorderexgrpid);
        if(exclude && lstorderexgrpid == null)
           lstorderexgrpid = WundermanAPIConnector.addExcudeAllGroupToListOrder(lstorderid);
        addCategoryInfoToCriterias(lstCriterias);
        Map<String, Campaign_Member_Criteria_Group__c> includeCriteriaGroupsMap = getCriteriaGroupMap(lstCriterias, objCampaign.Id, true);
        Map<String, Campaign_Member_Criteria_Group__c> excludeCriteriaGroupsMap = getCriteriaGroupMap(lstCriterias, objCampaign.Id, true);
        
        system.debug('Include Criteria Groups Map: ' + includeCriteriaGroupsMap );
        system.debug('Exclude Criteria Groups Map: ' + excludeCriteriaGroupsMap );
        
        for(Campaign_Member_Criteria__c criteria: lstCriterias)
        {
            string criteriaGroupkey = criteria.Category__c;
            Campaign_Member_Criteria_Group__c criteriaGroup = criteria.Exclude__c?excludeCriteriaGroupsMap.get(criteriaGroupkey):includeCriteriaGroupsMap.get(criteriaGroupkey);
            decimal groupNumber = 0;
            if(criteriaGroup != null)
            {
                groupNumber = criteriaGroup.Group_Number__c;
                criteria.Operator__c = criteriaGroup.Inner_Operator__c;
            }
        }
      
        if(includeCriteriaGroupsMap.size()>0 || excludeCriteriaGroupsMap.size()>0)
        {
            List<Campaign_Member_Criteria_Group__c> lstCriteriaGroups = new list<Campaign_Member_Criteria_Group__c>();
            for(string category: includeCriteriaGroupsMap.keyset())
            {
                Campaign_Member_Criteria_Group__c criteriaGroup = includeCriteriaGroupsMap.get(category);
                if(criteriaGroup!= null && criteriaGroup.Id == null)
                    lstCriteriaGroups.add(criteriaGroup);
            }    
            for(string category: excludeCriteriaGroupsMap.keyset())
            {
                Campaign_Member_Criteria_Group__c criteriaGroup = excludeCriteriaGroupsMap.get(category);
                if(criteriaGroup!= null && criteriaGroup.Id == null)
                    lstCriteriaGroups.add(criteriaGroup);
            }           
            if(lstCriteriaGroups.size()>0)
                insert lstCriteriaGroups;
            system.debug('Inserted New Criteria Groups: ' + lstCriteriaGroups);
        }
        
        for(Campaign_Member_Criteria__c criteria: lstCriterias)
        {
            Campaign_Member_Criteria__c cmc = new Campaign_Member_Criteria__c ();
            cmc.Campaign__c = clonedCampid;
            cmc.Operator__c = criteria.Operator__c;
            cmc.Field_Name__c= criteria.Field_Name__c;
            cmc.Value__c= criteria.Value__c;
            cmc.Field_id__c = criteria.Field_id__c;
            cmc.Category__c = criteria.Category__c;
            if(excludeCriteriaGroupsMap.size()>0 || includeCriteriaGroupsMap.size()>0)
            {
                string criteriaGroupkey = criteria.Category__c;
                Campaign_Member_Criteria_Group__c criteriaGroup = criteria.Exclude__c?excludeCriteriaGroupsMap.get(criteriaGroupkey):includeCriteriaGroupsMap.get(criteriaGroupkey);
                if(criteriaGroup!= null)
                    cmc.Criteria_Group__c = criteriaGroup.Id;
            }
            lstclonedCriteriaToBeInserted.add(cmc);
            
          }
        
        insert lstclonedCriteriaToBeInserted;
        system.debug('Inserted New Criterias: ' + lstCriterias);
    }
     @TestVisible
    private static string getValueIfTrue(boolean key, string value)
    {
        if(key==true)
            return value + ';';
        else    
            return '';
    }   
    
      public static void setAddOnExclusionCriterias(Id campaignId)
    {
        //Commented out by Lov as it was not adding the Exclude physician npis so added another filter criteria in SOQL
        
        //List<Campaign_Member_Criteria__c> lstCriterias = [SELECT Id, Field_Name__c, Value__c, Category__c, Exclude__c FROM Campaign_Member_Criteria__c WHERE Campaign__c =:campaignId AND Category__c LIKE 'Encounter%' AND WM_Sync_Type__c!='Delete'];
        List<Campaign_Member_Criteria__c> lstCriterias = [SELECT Id, Field_Name__c, Value__c, Category__c, Exclude__c FROM Campaign_Member_Criteria__c WHERE Campaign__c =:campaignId AND (Category__c LIKE 'Encounter%' OR  Category__c='Physicians' )AND WM_Sync_Type__c!='Delete'];
        Map<string, Campaign_Member_Criteria__c> existingAddOnExclusionCriteras = new Map<string, Campaign_Member_Criteria__c>();
        Map<string, Campaign_Member_Criteria__c> requiredAddOnExclusionCriteras = new Map<string, Campaign_Member_Criteria__c>();
        Map<string, string> insertAddOnExclusionCriterias = new Map<string, string>();
        Map<string, string> updateAddOnExclusionCriterias = new Map<string, string>();
        Map<string, string> deleteAddOnExclusionCriterias = new Map<string, string>();
        
        boolean requireExclusions = false;
        System.debug('*******lstCriterias'+lstCriterias);
        for(Campaign_Member_Criteria__c criteria: lstCriterias)
        {
           
            if(criteria.Exclude__c) 
            {
                System.debug('*******criteria.Category__c***'+criteria.Category__c);
                //Commented out by Lov as it was not adding the Exclude physician npis so added another filter criteria in SOQL
                //if (criteria.Category__c=='Encounter Codes' || criteria.Category__c=='Physician NPIs' || criteria.Field_Name__c=='Facility_ID__c')
                if (criteria.Category__c=='Encounter Codes' || criteria.Category__c=='Physicians' || criteria.Field_Name__c=='Facility_ID__c')
                    requireExclusions = true;
                else
                    existingAddOnExclusionCriteras.put(criteria.Field_Name__c, criteria);
            }
            else if(criteria.Category__c=='Encounters' && criteria.Field_Name__c!='Facility_ID__c')
                    requiredAddOnExclusionCriteras.put(criteria.Field_Name__c, criteria);
        }
        if(requireExclusions)
        {
            for(Campaign_Member_Criteria__c criteria: requiredAddOnExclusionCriteras.values())
            {
                if(!existingAddOnExclusionCriteras.containsKey(criteria.Field_Name__c))
                    insertAddOnExclusionCriterias.put(criteria.Field_Name__c,criteria.Value__c);
                else if(existingAddOnExclusionCriteras.get(criteria.Field_Name__c) != requiredAddOnExclusionCriteras.get(criteria.Field_Name__c))
                    updateAddOnExclusionCriterias.put(criteria.Field_Name__c, criteria.Value__c);
            }
            for(Campaign_Member_Criteria__c criteria: existingAddOnExclusionCriteras.values())
            {
                if(!requiredAddOnExclusionCriteras.containsKey(criteria.Field_Name__c))
                    deleteAddOnExclusionCriterias.put(criteria.Field_Name__c,criteria.Value__c);
            }
        }
        else
        {
            for(Campaign_Member_Criteria__c criteria: existingAddOnExclusionCriteras.values())
                deleteAddOnExclusionCriterias.put(criteria.Field_Name__c, criteria.Value__c);
        }
        if(insertAddOnExclusionCriterias.size()>0)
            insertCriterias(insertAddOnExclusionCriterias, campaignId, true, 'Encounter__c');
        if(updateAddOnExclusionCriterias.size()>0)
            updateCriterias(updateAddOnExclusionCriterias, campaignId, true);
        if(deleteAddOnExclusionCriterias.size()>0)
            deleteCriterias(deleteAddOnExclusionCriterias, campaignId, true);
    }
     
     
     /*Start: PP5 changes */
     
     public static void syncCampaignMemberCriterias(string campaignId,Boolean isFinalCount)
    {
        Campaign campaign = [SELECT Id, List_Order_Id__c,Member_types__c, CRM_Refreshed_Count_Date__c,List_Order_Select_Grp_Id__c, List_Order_Exclude_Grp_Id__c FROM Campaign WHERE Id=:campaignId]; // Added for Audience Selection criteria story birthMonth
        List<Campaign_Member_Criteria__c> includeCriterias = [SELECT Id, WM_Criteria_Id__c,Field_Id__c, Category__c, Operator__c, Field_Name__c, Value__c, Exclude__c,WM_Sync_Status__c, WM_Sync_Type__c, Criteria_Group__c, Criteria_Group__r.Group_Number__c, Criteria_Group__r.WM_CriteriaGroup_Id__c FROM Campaign_Member_Criteria__c WHERE Campaign__c =:campaignId And Exclude__c=:false AND (WM_Sync_Status__c!=:'Synced' OR Field_Name__c = 'CRM_Birth_Month__c' OR Field_Name__c = 'ZipCode__c') ];
        List<Campaign_Member_Criteria__c> excludeCriterias = [SELECT Id, WM_Criteria_Id__c, Field_Id__c,Category__c, Operator__c, Field_Name__c, Value__c, Exclude__c,WM_Sync_Status__c, WM_Sync_Type__c, Criteria_Group__c, Criteria_Group__r.Group_Number__c, Criteria_Group__r.WM_CriteriaGroup_Id__c FROM Campaign_Member_Criteria__c WHERE Campaign__c =:campaignId And Exclude__c=:true AND (WM_Sync_Status__c!=:'Synced' OR Field_Name__c = 'CRM_Birth_Month__c')];
        List<Campaign_Member_Criteria__c> updateCriterias = new List<Campaign_Member_Criteria__c>();
        List<Campaign_Member_Criteria__c> deleteCriterias = new List<Campaign_Member_Criteria__c>();
        // Added for Audience Selection criteria story birthMonth
        List<Campaign_Demographics__c> birthMonthCrtierias = [SELECT CRM_Birth_Month__c FROM Campaign_Demographics__c WHERE Campaign__c = :campaignId AND CRM_Birth_Month__c!=null AND CRM_Birth_Month__c!='Any'];
        // end of Added for Audience Selection criteria story birthMonth
        if(campaign.List_Order_Id__c == null)
            campaign.List_Order_Id__c = Decimal.valueOf(WundermanAPIConnector.startNewListOrder());
        
        if(campaign.List_Order_Select_Grp_Id__c == null)
            campaign.List_Order_Select_Grp_Id__c = Decimal.valueOf(WundermanAPIConnector.getListOrderGroupId(String.valueOf(campaign.List_Order_Id__c)));
        
        if(campaign.List_Order_Exclude_Grp_Id__c == null)
        {
            if(excludeCriterias.size()>0)
                campaign.List_Order_Exclude_Grp_Id__c = Decimal.valueOf(WundermanAPIConnector.addExcudeAllGroupToListOrder(String.valueOf(campaign.List_Order_Id__c)));
        }
        
        for(Campaign_Member_Criteria__c criteria: includeCriterias)
        {
            try
            {
                 //Added for Audience Selection criteria story birthMonth
                 Boolean flag = true; // This flag will be used to make sure system doesnt send birth month criteria every time
                 if(criteria.Field_Name__c == 'CRM_Birth_Month__c' && birthMonthCrtierias.size()>0 && criteria.WM_Sync_Type__c != 'Delete') {
                     //if(!criteria.value__c.contains(returnCalendarMonths(campaign.CRM_Refreshed_Count_Date__c.Month())) || criteria.WM_Sync_Status__c == 'Pending'){
                     if(campaign.CRM_Refreshed_Count_Date__c==null || campaign.CRM_Refreshed_Count_Date__c.Month()!=Date.Today().Month() || criteria.WM_Sync_Status__c == 'Pending'){
                         BirthMonthCriteriaImplementation(criteria,birthMonthCrtierias,campaignid);
                     }else{
                          flag=false;
                     }
                 }else if(criteria.WM_Sync_Status__c != 'Pending' && criteria.Field_Name__c!='ZipCode__c'){
                     flag=false;
                 }
                 
                // end of Added for Audience Selection criteria story birthMonth
                //  Added for Audience Selection criteria story Service-SubService line
                //if(criteria.Field_Name__c == 'CRM_SubServiceLine__c') ServSubServiceLineCrtieriaManager.ServiceSubServiceValuesAsperWDM (criteria);
                //end of Audience Selection criteria story Service-SubService line
                
                //fetch zip code during refresh count
                if(criteria.Field_Name__c=='ZipCode__c'){
                    setLastestZipCodes(criteria,campaignId);
                }
                
                decimal groupNumber = 0;              
                if(criteria.Criteria_Group__c != null)
                    groupNumber = criteria.Criteria_Group__r.Group_Number__c;
                if((criteria.WM_Criteria_Id__c==null || criteria.WM_Sync_Type__c=='Insert') && flag == true)
                {
                    WundermanAPIConnector.addCriteriaToListOrder(String.valueOf(campaign.List_Order_Select_Grp_Id__c), criteria, groupNumber);
                    updateCriterias.add(criteria);
                }
                else if(criteria.WM_Sync_Type__c=='Update' && flag == true)
                {
                    WundermanAPIConnector.updateCriteriaOfListOrder(criteria);
                    updateCriterias.add(criteria);
                }
                else if(criteria.WM_Sync_Type__c=='Delete')
                {
                    if(criteria.WM_Criteria_Id__c!=null)
                        WundermanAPIConnector.deleteCriteriaFromListOrder(criteria);
                    deleteCriterias.add(criteria);
                }
                criteria.WM_Sync_Status__c = 'Synced';
            }
            catch(Exception e)
            {
                Tenet_Exception_Handler logError = new Tenet_Exception_Handler();
                logError.creatExceptionLog(e,null,'CampaignMemberCriteriaManager');
                criteria.WM_Sync_Status__c = 'Failed';
                updateCriterias.add(criteria);
            }
        }
        
        boolean hasPendingExclusions = false;
        for(Campaign_Member_Criteria__c criteria: excludeCriterias)
        {
            try
            {
                // Added for Audience Selection criteria story birthMonth
                Boolean flag = true; // This flag will be used to make sure system doesnt send birth month criteria every time
                 if(criteria.Field_Name__c == 'CRM_Birth_Month__c' && birthMonthCrtierias.size()>0 && criteria.WM_Sync_Type__c != 'Delete') {
                     //if(!criteria.value__c.contains(returnCalendarMonths(campaign.CRM_Refreshed_Count_Date__c.Month())) || criteria.WM_Sync_Status__c == 'Pending'){
                     if(campaign.CRM_Refreshed_Count_Date__c==null || campaign.CRM_Refreshed_Count_Date__c.Month()!=Date.Today().Month() || criteria.WM_Sync_Status__c == 'Pending'){
                         BirthMonthCriteriaImplementation(criteria,birthMonthCrtierias,campaignid);
                     }else{
                          flag=false;
                     }
                 }else if(criteria.WM_Sync_Status__c != 'Pending'){
                     flag=false;
                 }
                // end of Added for Audience Selection criteria story birthMonth
                
                //  Added for Audience Selection criteria story Service-SubService line
                if(criteria.Field_Name__c == 'CRM_SubServiceLine__c') ServSubServiceLineCrtieriaManager.ServiceSubServiceValuesAsperWDM (criteria);
                //end of Audience Selection criteria story Service-SubService line
                decimal groupNumber = 0;
                if(criteria.Criteria_Group__c != null)
                       groupNumber = criteria.Criteria_Group__r.Group_Number__c;
                if((criteria.WM_Criteria_Id__c==null || criteria.WM_Sync_Type__c=='Insert') && flag == true)
                {
                    WundermanAPIConnector.addCriteriaToListOrder(String.valueOf(campaign.List_Order_Exclude_Grp_Id__c), criteria, groupNumber);
                    updateCriterias.add(criteria);
                    hasPendingExclusions = true;
                }
               else if(criteria.WM_Sync_Type__c=='Update' && flag == true)
                {
                    WundermanAPIConnector.updateCriteriaOfListOrder(criteria);
                    updateCriterias.add(criteria);
                    hasPendingExclusions = true;
                }
                else if(criteria.WM_Sync_Type__c=='Delete')
                {
                    WundermanAPIConnector.deleteCriteriaFromListOrder(criteria);
                    deleteCriterias.add(criteria);
                }   
                criteria.WM_Sync_Status__c = 'Synced';
            }
            catch(Exception e)
            {
                Tenet_Exception_Handler logError = new Tenet_Exception_Handler();
                logError.creatExceptionLog(e,null,'CampaignMemberCriteriaManager');
                criteria.WM_Sync_Status__c = 'Failed';
                updateCriterias.add(criteria);
            }
        }
        
        if(excludeCriterias.size()>0)
        {
            Integer syncedExcludeCount = [SELECT Count() FROM Campaign_Member_Criteria__c WHERE Campaign__c =:campaignId And Exclude__c=:true AND WM_Sync_Status__c=:'Synced'];
            if(syncedExcludeCount==0 && !hasPendingExclusions)
            {
                WundermanAPIConnector.deleteSubGroupToListOrder(String.valueOf(campaign.List_Order_Exclude_Grp_Id__c));
                campaign.List_Order_Exclude_Grp_Id__c = null;
            }
        }
        
        campaign.Current_count__c = WundermanAPIConnector.refreshCount(String.valueOf(campaign.List_Order_Id__c));
        // Added for Audience Selection criteria story birthMonth
        campaign.CRM_Refreshed_Count_Date__c = Date.Today();
        // end of Added for Audience Selection criteria story birthMonth
        
        System.debug('###campaign.Current_count__c ###'+campaign.Current_count__c );
        if(!isFinalCount){
          
            WundermanAPIConnector.logTransactions();
                   
            if(updateCriterias.size()>0 )
                update updateCriterias;
                
            if(deleteCriterias.size()>0)
                delete deleteCriterias;
            
            update campaign;
            
        //This part handle Final count logic 
        }else{
            System.debug('###campaign.Member_types__c###'+campaign.Member_types__c);
            System.debug('###Current_count__c###'+campaign.Current_count__c ); 
            
            if(campaign.Current_count__c!=null)
            {
                if(integer.valueof(campaign.Current_count__c)>150000){
                    WundermanAPIConnector.logTransactions();
                           
                    if(updateCriterias.size()>0 )
                        update updateCriterias;
                        
                    if(deleteCriterias.size()>0)
                        delete deleteCriterias;
                    
                    update campaign;
                    
                    throw new ApplicationException('Audience Count more than 150000');
                }
            }
           
            
            System.debug('###campaign.Current_count__c###'+campaign.Current_count__c);   
            //Starting of defect#798:Net counts did not complete being calculated. SFDC suspected timeout after 2 minutes and did a manual process to restart the job. 
         
            if(Tenet_Static_Variables.checkActiveJob(Tenet_Static_Variables.WUNDERMAN_SESSION_SCHEDULER) && Tenet_Static_Variables.checkActiveJob(Tenet_Static_Variables.WUNDERMAN_NET_COUNT_SCHEDULER))
            {
                if(campaign.Current_count__c>0){
	                String orderResponse=WundermanAPIConnector.placeOrder(string.valueOf(campaign.List_Order_Id__c));
	                string orderstaus=WundermanAPIConnector.getValueFromXmlResponse(orderResponse,'RETURNCODE');
	                
	                campaign.Add_Member_Status__c='Order Placed';
	                campaign.Error_Message__c=null;
	                update campaign;
	    			//WundermanAPIConnector.logTransactions();
                }
                //AXU CRM-316
                if (campaign.Current_count__c == 0)
                {
                    campaign.Add_Member_Status__c = 'Calculated Net Count';
                    campaign.Missing_Contact_Count__c = 0;
                    campaign.Supp_Count__c = 0;
                    campaign.CG_Count__c = 0;
                    update campaign;
                }
                System.debug('###placeOrder###'+campaign);
            }
            else
            {                
                System.debug('###NOplaceOrder###'); 
                throw new ApplicationException('Automated Process is not running. Please contact CRM support.');
            }
            //Ending of defect#789
        
            WundermanAPIConnector.logTransactions();
                   
            if(updateCriterias.size()>0 )
                update updateCriterias;
                
            if(deleteCriterias.size()>0)
                delete deleteCriterias;
            
            update campaign;
            System.debug('###NetCountELSE###');
        }   
    }
    public class ApplicationException extends Exception {}
     
     /*End: PP5 changes */
    
    public static void resetCampaignMemberCriteriasSync(id campaignId,Id unlockbatchID) 
    {
        
        system.debug('batch id ----'+ unlockbatchID);
       Campaign campaign = new Campaign ();
       list<Campaign> lstCampaign = [SELECT List_Order_Id__c,CRM_ParentSegmentedCampaign__c, List_Order_Exclude_Grp_Id__c, List_Order_Select_Grp_Id__c, Current_count__c FROM Campaign WHERE id = :campaignId];
       if(lstCampaign.size()>0) 
       {
           campaign = lstCampaign[0];
           campaign.List_Order_Id__c = null;
           campaign.List_Order_Exclude_Grp_Id__c = null;
           campaign.List_Order_Select_Grp_Id__c = null;
           campaign.Current_count__c = null;
           campaign.Supp_Count__c = null;
           campaign.CG_Count__c = null;
           campaign.Missing_Contact_Count__c = null;
           campaign.Add_Member_Status__c = null;
           List<Campaign_Member_Criteria__c> lstcriteria = [SELECT id, WM_Sync_Type__c, WM_Criteria_Id__c,WM_Sync_Status__c FROM Campaign_Member_Criteria__c WHERE Campaign__c =:campaignId];
           for(Campaign_Member_Criteria__c criteria : lstcriteria) 
           {
               criteria.WM_Sync_Type__c = 'Insert';
               criteria.WM_Sync_Status__c = 'Pending';
               criteria.WM_Criteria_Id__c = null;
            }
            //Changes for PP1 and PP6 Start
            Id uploadRecordTYpeId = ReferenceData_PicklistController.recordTypeId('CRM_AudienceUploadJunction__c','Audience_Report');
            list<CRM_AudienceUploadJunction__c> uploadJunctionList = new list<CRM_AudienceUploadJunction__c>();
            for(CRM_AudienceUploadJunction__c auj : [select id,CRM_ToDelete__c from CRM_AudienceUploadJunction__c where CRM_Campaign__c=:campaignId AND CRM_ToDelete__c=false AND RecordTypeId=:uploadRecordTYpeId]){
                auj.CRM_ToDelete__c=true;
                uploadJunctionList.add(auj);
            }
            
            update campaign;
            update lstcriteria;
            update uploadJunctionList;
            
            if(lstCampaign[0].CRM_ParentSegmentedCampaign__c!=null){
                Campaign camp = new Campaign(id=lstCampaign[0].CRM_ParentSegmentedCampaign__c);
                camp.Current_count__c = null;
                camp.Supp_Count__c = null;
                camp.CG_Count__c = null;
                camp.Missing_Contact_Count__c = null;
                if(unlockbatchID!=null){
                    camp.Add_Member_Status__c = 'Resetting';
                    camp.CRM_UnlockProcessBatch_ID__c = unlockbatchID;
                }
                else{
                camp.Add_Member_Status__c = null;
                }
                
                update camp;
            }
            //Changes for PP1 and PP6 Ends
            
            
        }
    } 
    @TestVisible 
    private static Map<String, String> returnLabelNames (String objectname) {
      Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
      Schema.SObjectType leadSchema = schemaMap.get(objectName);
      Map<String, Schema.SObjectField> fieldMap = leadSchema.getDescribe().fields.getMap();
      Map<String, String> mapApiNameswithValues = new Map<String, String>  ();
      for (Schema.SObjectField f : fieldMap.values()) { 
          Schema.DescribeFieldResult d = f.getDescribe(); 
          mapApiNameswithValues.put(d.getName(),d.getLabel());
      }
      return mapApiNameswithValues;
    }
    
    
    
    // Added for Audience Selection criteria story birthMonth
    
    @TestVisible
    private static void BirthMonthCriteriaImplementation (Campaign_Member_Criteria__c criteria, List<Campaign_Demographics__c> birthMonthCrtierias,id campaignId) {
           String replacedValue;
           if(criteria.WM_Criteria_Id__c== null)
               criteria.WM_Sync_Type__c='Insert';
           else
                criteria.WM_Sync_Type__c='Update'; 
           if(birthMonthCrtierias[0].CRM_Birth_Month__c.contains('Current Month') || birthMonthCrtierias[0].CRM_Birth_Month__c.contains('Next Month'))
            if(birthMonthCrtierias[0].CRM_Birth_Month__c.contains('Current Month') && !birthMonthCrtierias[0].CRM_Birth_Month__c.contains('Next Month')) {
                replacedValue = birthMonthCrtierias[0].CRM_Birth_Month__c.replaceAll('Current Month', returnCurrentandNextmonth ('Current Month',campaignId));                
                criteria.Value__c = replacedValue;
            }
            else if(!birthMonthCrtierias[0].CRM_Birth_Month__c.contains('Current Month') && birthMonthCrtierias[0].CRM_Birth_Month__c.contains('Next Month')) {
                replacedValue = birthMonthCrtierias[0].CRM_Birth_Month__c.replaceAll('Next Month', returnCurrentandNextmonth ('Next Month',campaignId));
                criteria.Value__c = replacedValue;
            }     
            else if(birthMonthCrtierias[0].CRM_Birth_Month__c.contains('Current Month') && birthMonthCrtierias[0].CRM_Birth_Month__c.contains('Next Month')) {
                String currnextMonth = 'Current Month';
                replacedValue  = birthMonthCrtierias[0].CRM_Birth_Month__c.replaceAll('Current Month', returnCurrentandNextmonth (currnextMonth ,campaignId));
                currnextMonth = 'Next Month';
                replacedValue = replacedValue.replaceAll('Next Month', returnCurrentandNextmonth (currnextMonth ,campaignId));
                criteria.Value__c = replacedValue;
            }
            //if(campaign.CRM_Refreshed_Count_Date__c!=null) criteria.WM_Sync_Type__c ='Update';
            
            System.debug('******criteriavalue***'+criteria.Value__c+'criteria.WM_Sync_Type__c******'+criteria.WM_Sync_Type__c);
            
    }
    @TestVisible
    private static String returnCurrentandNextmonth (String currentornextMonth,Id campaignId) {
        String month;
        //Date refreshedCountDate = [SELECT CRM_Refreshed_Count_Date__c FROM Campaign WHERE id=:campaignId][0].CRM_Refreshed_Count_Date__c;
            Integer sysMonth = Date.Today().Month();
            if(currentornextMonth == 'Current Month') month = returnCalendarMonths(sysMonth );
            else if(currentornextMonth == 'Next Month') {
                if(sysMonth == 12) month = returnCalendarMonths(1);
                else month = returnCalendarMonths(sysMonth+1);
            }
           return month;
    
    }
    @TestVisible
    private static String returnCalendarMonths (Integer month) {
        String calendarMonth;
        if(month == 1) calendarMonth = 'January';
        else if(month == 2) calendarMonth = 'February';
        else if(month == 3) calendarMonth = 'March';
        else if(month == 4) calendarMonth = 'April';
        else if(month == 5) calendarMonth = 'May';
        else if(month == 6) calendarMonth = 'June';
        else if(month == 7) calendarMonth = 'July';
        else if(month == 8) calendarMonth = 'August';
        else if(month == 9) calendarMonth = 'September';
        else if(month == 10) calendarMonth = 'October';
        else if(month == 11) calendarMonth = 'Novemeber';
        else if(month == 12) calendarMonth = 'December';
        return calendarMonth;
    }
    
    // end of Added for Audience Selection criteria story birthMonth
    
   static void setLastestZipCodes(Campaign_Member_Criteria__c criteria,id campaignId){
     
      CRM_Search_Criteria__c hsl;
      list<string> sl2=new list<string>();
      list<string> sl3=new list<string>();
      for(CRM_Search_Criteria__c crms : [select id,CRM_Campaign__c,CRM_Search_Criteria_Level_1__c,CRM_Search_Criteria_Level_2__c,CRM_Search_Criteria_Level_3__c,CRM_AdditionalZipCodes__c,CRM_ExcludedZipCodes__c from CRM_Search_Criteria__c where CRM_Campaign__c=:campaignId]){
        hsl = crms;
      }
      
      if(hsl!=null){
        
        string homeaddress = hsl.CRM_Search_Criteria_Level_1__c;
        
        if(homeaddress=='By Region' || homeaddress=='By Market' || homeaddress=='By Hospital'){
          
          list<string> saCode = hsl.CRM_Search_Criteria_Level_2__c.split(';');
          for(CRM_CampaignLocationReferenceData__c clrs : [select id,CRM_ServiceArea__c from CRM_CampaignLocationReferenceData__c where CRM_ServiceAreaCode__c IN: saCode AND CRM_IsActive__c=true]){
            sl2.add(clrs.id);
          }
          
          list<string> level3Codes = hsl.CRM_Search_Criteria_Level_3__c.split(';');
          for(CRM_CampaignLocationReferenceData__c clrs : [select id,CRM_Hospital__c,CRM_Market__c,CRM_Region__c from CRM_CampaignLocationReferenceData__c where (CRM_HospitalCode__c IN: level3Codes OR CRM_MarketCode__c IN: level3Codes OR CRM_RegionCode__c IN: level3Codes) AND CRM_IsActive__c=true]){
            sl3.add(clrs.id);
          }
          
        }
        if(homeaddress=='By Distance'){
          sl2.add(hsl.CRM_Search_Criteria_Level_2__c);
          list<string> level3Codes = hsl.CRM_Search_Criteria_Level_3__c.split(';');
          for(CRM_CampaignLocationReferenceData__c clrs : [select id from CRM_CampaignLocationReferenceData__c where CRM_HospitalCode__c IN: level3Codes AND CRM_IsActive__c=true]){
            sl3.add(clrs.id);
          }
        }
        if(homeaddress=='By State' || homeaddress=='By County' || homeaddress=='By CBSA'){
                    
          list<string> saCode = hsl.CRM_Search_Criteria_Level_2__c.split(';');
          for(CRM_CampaignGeographyReferenceData__c clrs : [select id,CRM_CBSA__c,CRM_State__c from CRM_CampaignGeographyReferenceData__c where (CRM_StateCode__c IN: saCode OR CRM_CBSA__c IN: saCode) AND CRM_IsActive__c=true]){
            sl2.add(clrs.id);
          }
          
          
          if(hsl.CRM_Search_Criteria_Level_3__c!=null){
              
            list<string> level3Codes = hsl.CRM_Search_Criteria_Level_3__c.split(';');
            for(CRM_CampaignGeographyReferenceData__c clrs : [select id,CRM_County__c from CRM_CampaignGeographyReferenceData__c where CRM_CountysStateID__c IN:sl2 AND CRM_County__c IN: level3Codes AND CRM_IsActive__c=true]){
              sl3.add(clrs.id);
            }
            
          }
          
          
        }
        
        set<string> zipcodeSet = new set<string>();
        if(!string.isBlank(hsl.CRM_AdditionalZipCodes__c)){
            for(string str : hsl.CRM_AdditionalZipCodes__c.split(';')){
              zipcodeSet.add(str);
            }
          }
          
        if(!string.isBlank(homeAddress))
          zipcodeSet.addAll(Homeaddress_Controller.searchResult(homeaddress, sl2,sl3));
        
        if(zipcodeSet.size()>0){
          
          if(criteria.WM_Criteria_Id__c== null)
                 criteria.WM_Sync_Type__c='Insert';
              else
                  criteria.WM_Sync_Type__c='Update';
          
          //Now remove excluded zip codes from search result
            if(!string.isBlank(hsl.CRM_ExcludedZipCodes__c)){
                for(string str : hsl.CRM_ExcludedZipCodes__c.split(';')){
                    if(zipcodeSet.contains(str))
                        zipcodeSet.remove(str);
                }
            }        
            
          list<string> zipcodeList = new list<string>();
          zipcodeList.addAll(zipcodeSet);
          criteria.Value__c = String.join(zipcodeList, ';');
        
        }else{
           criteria.WM_Sync_Type__c='Delete';
        }
          
      }
      
  }
}
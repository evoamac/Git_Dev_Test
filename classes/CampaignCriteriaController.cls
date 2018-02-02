public class CampaignCriteriaController
{
    public Campaign objcampaign {get;set;} 
    public Map<String, List<Campaign_Member_Criteria__c>> includeCriteriaMap {get;set;}
    public Map<String, List<Campaign_Member_Criteria__c>> excludeCriteriaMap {get;set;}
    public boolean hasInclusions {get;set;}
    public boolean hasExclusions {get;set;}
    public string wmSyncStatus {get;set;}
    public string homeaddress{get;set;}
    public string homeaddressSL2{get;set;}
    public string homeaddressSL3{get;set;}
    
    public CampaignCriteriaController(ApexPages.StandardController stdController)
    {
        wmSyncStatus = 'Synced';
        this.objcampaign = (Campaign)stdController.getRecord();
        //Changes for PP1 Start
        /*this.objcampaign=[select RecordTypeId,CRM_UploadAudienceCount__c,Current_count__c,Wunderman_Sync__c,
                         Id,List_Order_Id__c,Member_Types__c,Name,of_CampaignMembers__c,of_Members__c,
                         IsActive,Status,Add_Member_Status__c,
                         (SELECT ID, CRM_AudienceCount__c, recordtype.name from CRM_AudienceUploadJunctions__r WHERE RecordTypeId =:ReferenceData_PicklistController.recordTypeId('CRM_AudienceUploadJunction__c','Audience_Upload') AND CRM_ToDelete__c=:false limit 1)
                         from campaign where id=:this.objcampaign.id limit 1];*/
         this.objcampaign=[select RecordTypeId,Current_count__c,Wunderman_Sync__c,
                         Id,List_Order_Id__c,Member_Types__c,Name,of_CampaignMembers__c,of_Members__c,
                         IsActive,Status,Add_Member_Status__c from campaign where id=:this.objcampaign.id limit 1];                
        //Changes for PP1 Start   
        
        List<Campaign_Member_Criteria__c> includeCriterias = [SELECT Id, Field_Id__c, Value__c, Operator__c, Category__c, WM_Sync_Status__c, WM_Sync_Type__c FROM Campaign_Member_Criteria__c WHERE Campaign__c=:objcampaign.Id AND Exclude__c=:false];
        hasInclusions = includeCriterias.size()>0?true:false;
        List<Campaign_Member_Criteria__c> excludeCriterias = [SELECT Id, Field_Id__c, Value__c, Operator__c, Category__c, WM_Sync_Status__c, WM_Sync_Type__c FROM Campaign_Member_Criteria__c WHERE Campaign__c=:objcampaign.Id AND Exclude__c=:true];
        hasExclusions = excludeCriterias.size()>0?true:false;
        includeCriteriaMap = getCriteriaMap(includeCriterias);
        excludeCriteriaMap = getCriteriaMap(excludeCriterias);
        
        
        getHomeAddressCriteria();
    }
        
    private Map<String, List<Campaign_Member_Criteria__c>> getCriteriaMap(List<Campaign_Member_Criteria__c> lstCriterias)
    {
        Map<String, List<Campaign_Member_Criteria__c>> criteriaMap = new Map<String, List<Campaign_Member_Criteria__c>>();
        for(Campaign_Member_Criteria__c criteria: lstCriterias)
        {
             if(criteria.WM_Sync_Type__c !='Delete')
             {
                 if(!criteriaMap.containsKey(criteria.Category__c))
                 {
                     List<Campaign_Member_Criteria__c> criterias = new List<Campaign_Member_Criteria__c>(); 
                     criterias.add(criteria);
                     criteriaMap.put(criteria.Category__c, criterias);
                 }
                 else
                     criteriaMap.get(criteria.Category__c).add(criteria);
             }
             if(wmSyncStatus != 'Failed' && criteria.WM_Sync_Status__c != 'Synced')
                    wmSyncStatus = criteria.WM_Sync_Status__c;
        }
        return criteriaMap;
    }
    
    void getHomeAddressCriteria(){
      CRM_Search_Criteria__c hsl;
      for(CRM_Search_Criteria__c crms : [select id,CRM_Campaign__c,CRM_Search_Criteria_Level_1__c,CRM_Search_Criteria_Level_2__c,CRM_Search_Criteria_Level_3__c from CRM_Search_Criteria__c where CRM_Campaign__c=:objcampaign.Id]){
        hsl = crms;
      }
      
      if(hsl!=null){
        map<string,id> recordTypeMap = new map<string,id>();
    
          for(RecordType rt : [select developerName,id from RecordType where sObjectType='CRM_CampaignGeographyReferenceData__c' OR sObjectType='CRM_CampaignLocationReferenceData__c']){
              recordTypeMap.put(rt.developerName,rt.id);
          }
          
        homeaddress = hsl.CRM_Search_Criteria_Level_1__c;
        
        if(homeaddress=='By Region' || homeaddress=='By Market' || homeaddress=='By Hospital'){
          id recordTypeIds = homeaddress=='By Region'?recordTypeMap.get('Region'):homeaddress=='By Market'?recordTypeMap.get('Market'):recordTypeMap.get('Hospital');
          list<string> saCode = hsl.CRM_Search_Criteria_Level_2__c.split(';');
          for(CRM_CampaignLocationReferenceData__c clrs : [select id,CRM_ServiceArea__c from CRM_CampaignLocationReferenceData__c where CRM_ServiceAreaCode__c IN: saCode AND CRM_IsActive__c=true]){
            if(string.isBlank(homeaddressSL2))
              homeaddressSL2 = clrs.CRM_ServiceArea__c;
            else
              homeaddressSL2 += '; '+clrs.CRM_ServiceArea__c;
          }
          
          list<string> level3Codes = hsl.CRM_Search_Criteria_Level_3__c.split(';');
          for(CRM_CampaignLocationReferenceData__c clrs : [select id,CRM_Hospital__c,CRM_Market__c,CRM_Region__c from CRM_CampaignLocationReferenceData__c where (CRM_HospitalCode__c IN: level3Codes OR CRM_MarketCode__c IN: level3Codes OR CRM_RegionCode__c IN: level3Codes) AND CRM_IsActive__c=true AND recordTypeId=:recordTypeIds]){
            string str;
            if(homeaddress=='By Region')
              str =clrs.CRM_Region__c; 
            else if(homeaddress=='By Market')
              str =clrs.CRM_Market__c;
            else if(homeaddress=='By Hospital')
              str =clrs.CRM_Hospital__c;
            
            if(string.isBlank(homeaddressSL3))
              homeaddressSL3 = str;
            else
              homeaddressSL3 += '; '+str;
          }
          
        }
        if(homeaddress=='By Distance'){
           homeaddressSL2 = hsl.CRM_Search_Criteria_Level_2__c+' Miles';
           
           list<string> level3Codes = hsl.CRM_Search_Criteria_Level_3__c.split(';');
          for(CRM_CampaignLocationReferenceData__c clrs : [select id,CRM_Hospital__c from CRM_CampaignLocationReferenceData__c where CRM_HospitalCode__c IN: level3Codes AND CRM_IsActive__c=true]){
            string str;
            str =clrs.CRM_Hospital__c;
            
            if(string.isBlank(homeaddressSL3))
              homeaddressSL3 = str;
            else
              homeaddressSL3 += '; '+str;
          }
           
        }
        if(homeaddress=='By State' || homeaddress=='By County' || homeaddress=='By CBSA'){
          id recordTypeIds = homeaddress=='By State'?recordTypeMap.get('State'):homeaddress=='By County'?recordTypeMap.get('State'):recordTypeMap.get('CBSA');          
          list<string> saCode = hsl.CRM_Search_Criteria_Level_2__c.split(';');
          set<id> stateIds = new set<id>();
          for(CRM_CampaignGeographyReferenceData__c clrs : [select id,CRM_CBSA__c,CRM_State__c from CRM_CampaignGeographyReferenceData__c where (CRM_StateCode__c IN: saCode OR CRM_CBSA__c IN: saCode) AND CRM_IsActive__c=true AND recordTYpeId=:recordTypeIds]){
            string str;
            if(homeaddress=='By State' || homeaddress=='By County')
              str =clrs.CRM_State__c; 
            else if(homeaddress=='By CBSA')
              str =clrs.CRM_CBSA__c;
            
            if(string.isBlank(homeaddressSL2))
              homeaddressSL2 = str;
            else
              homeaddressSL2 += '; '+str;
              
              stateIds.add(clrs.id);
          }
          
          
          if(hsl.CRM_Search_Criteria_Level_3__c!=null){
              
            list<string> level3Codes = hsl.CRM_Search_Criteria_Level_3__c.split(';');
            for(CRM_CampaignGeographyReferenceData__c clrs : [select id,CRM_County__c from CRM_CampaignGeographyReferenceData__c where CRM_CountysStateID__c IN:stateIds AND CRM_County__c IN: level3Codes AND CRM_IsActive__c=true]){
              if(string.isBlank(homeaddressSL3))
                homeaddressSL3 = clrs.CRM_County__c;
              else
                homeaddressSL3 += '; '+clrs.CRM_County__c;
            }
            
          }
          
          
        }
        
      }
      
    }
}
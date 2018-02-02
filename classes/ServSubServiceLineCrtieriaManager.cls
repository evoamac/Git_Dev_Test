public class ServSubServiceLineCrtieriaManager {
   public static void ServiceSubServiceValuesAsperWDM (Campaign_Member_Criteria__c criteria) {
       if(criteria.Value__c!=null) {
            id RecordTypeidSub = [SELECT id FROM RecordType WHERE SobjectType='CRM_CampaignWizardReferenceData__c' AND DeveloperName='Sub_Service_Line'][0].id;
            List<String> subserviceLines = new List<String> ();
            List<String> lstreturnedSubServiceLine = new List<String> ();
            System.debug('*****criteria.Value__c'+criteria.Value__c);   
            for (String str : criteria.Value__c.split(';')) {
                str=str.trim();
                subserviceLines.add(str);
            }
            System.debug('*****subserviceLines '+subserviceLines);                  
            for(CRM_CampaignWizardReferenceData__c cwr:  [Select id ,CRM_SubServiceLine__c  FROM CRM_CampaignWizardReferenceData__c WHERE Recordtypeid =:RecordTypeidSub and CRM_IsActive__c = true AND CRM_ServiceSubServiceLine__c in:subserviceLines]) 
                lstreturnedSubServiceLine.add(cwr.CRM_SubServiceLine__c);
                
            if(lstreturnedSubServiceLine.size()>0) criteria.Value__c = String.join(lstreturnedSubServiceLine,';');
            System.debug('*****criteria.value*********'+criteria.Value__c);
       }
        
    }
    public static Map<String, String> ServiceLineSubServiceLineMapping() {
        id RecordTypeidSub = [SELECT id FROM RecordType WHERE SobjectType='CRM_CampaignWizardReferenceData__c' AND DeveloperName='Sub_Service_Line'][0].id;
        Map<String,String> mapserServiceLine = new Map<String,String> ();
        for(CRM_CampaignWizardReferenceData__c cwr:  [Select id ,CRM_SubServiceLine__c,CRM_ParentServiceLine__c  FROM CRM_CampaignWizardReferenceData__c WHERE Recordtypeid =:RecordTypeidSub and CRM_IsActive__c = true ]) 
             mapserServiceLine.put(cwr.CRM_SubServiceLine__c,cwr.CRM_ParentServiceLine__c);
                 
        return mapserServiceLine;
        
    }
    public static Map<String, Set<String>> ServiceLineSubServiceSetsMapping() {
        id RecordTypeidSub = [SELECT id FROM RecordType WHERE SobjectType='CRM_CampaignWizardReferenceData__c' AND DeveloperName='Sub_Service_Line'][0].id;
        Map<String, Set<String>> mapserSetServiceLine = new Map<String, Set<String>> ();
        for(CRM_CampaignWizardReferenceData__c cwr:  [Select id ,CRM_SubServiceLine__c,CRM_ParentServiceLine__c  FROM CRM_CampaignWizardReferenceData__c WHERE Recordtypeid =:RecordTypeidSub and CRM_IsActive__c = true ]) 
             if(mapserSetServiceLine .containsKey(cwr.CRM_ParentServiceLine__c))
                 mapserSetServiceLine .get(cwr.CRM_ParentServiceLine__c).add(cwr.CRM_SubServiceLine__c);
             else {
                 Set<String> setSubServLines = new Set<String> ();
                 setSubServLines.add(cwr.CRM_SubServiceLine__c);
                 mapserSetServiceLine.put(cwr.CRM_ParentServiceLine__c,setSubServLines);
             }
                 
        return mapserSetServiceLine;
        
    }

}
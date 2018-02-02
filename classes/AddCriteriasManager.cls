// This class is handling the functional code to insert the crtieria element ids into SFDC. 
Public class AddCriteriasManager 
{    
    // This method is used to insert the criteria element id into Campaign_Member_Criteria__c object along with other info such as SFDCAPIName, Campaignid etc..
    public static void addCriterias (String SFDCAPIName, String operator,String csvValue, String criteriaID, String criteriaGroupID,ID Campaignid) 
    {
        Campaign_Member_Criteria__c cmc = new Campaign_Member_Criteria__c ();
        cmc.Field_Name__c = SFDCAPIName;
        cmc.Operator__c = operator;
        cmc.Value__c = csvValue;
        cmc.WM_Criteria_Id__c = criteriaID;
        cmc.Campaign__c = Campaignid;
        insert cmc;
    }
}
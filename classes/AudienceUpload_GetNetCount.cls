public class AudienceUpload_GetNetCount implements Database.Batchable<sObject>, Database.Stateful 
{
    public String query;
    public List<String> wdmIdSet;
    public Campaign camp;
    
    public AudienceUpload_GetNetCount(Id campaignId)
    {
        wdmIdSet = new List<String>();
        camp =
        [
            SELECT Ignore_Bad_Debt_Suppression__c, Ignore_Minor_Suppression__c, Channel__c, Supp_Count__c, Control_Group_Percentage__c, Current_Count__c
            FROM Campaign
            WHERE Id =: campaignId
        ];
        List<Transaction__c> trans = [SELECT Response_Schema__c FROM Transaction__c WHERE Campaign__c =: campaignId AND Transaction_Source__c = 'Audience Upload'];
        for (Transaction__c t : trans)
        {
            wdmIdSet.addAll(t.Response_Schema__c.split(','));
        }
        
        query = 'SELECT Id, SUP_BAD_DEBT__c, SUP_MINOR__c, SUP_Clinical_Disease_States__c, SUP_Deceased_External__c, SUP_Deceased_Internal__c,SUP_Incarcerated__c, Industry_Suppr_State_Level_Do_Not_Mail__c, SUP_PO_Box_Types__c, SUP_Name_formats__c, SUP_Discharge_Status__c, SUP_Industry_State_Level__c FROM Contact WHERE Wunderman_Id__c IN :wdmIdSet';
        query += ' AND (SUP_Clinical_Disease_States__c=true OR SUP_Deceased_External__c=true OR SUP_Deceased_Internal__c=true OR SUP_Incarcerated__c=true OR SUP_Name_formats__c=true OR SUP_Discharge_Status__c=true OR SUP_Industry_State_Level__c=true';
        if(!camp.Ignore_Bad_Debt_Suppression__c)
            query += ' OR SUP_BAD_DEBT__c=true';
        if(!camp.Ignore_Minor_Suppression__c)
            query += ' OR SUP_Minor__c=true';
        if(camp.Channel__c=='Email')
            query += ' OR SUP_NON_EMAIL__c=true OR HasOptedOutOfEmail=true';
        if(camp.Channel__c=='Direct Mail')
            query += ' OR Industry_Suppr_State_Level_Do_Not_Mail__c=true';
        
        query +=')';
    }
    
    public Database.QueryLocator start(Database.BatchableContext bc)
    {      
        camp.Supp_Count__c = 0;
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc, List<Contact> cts)
    {
        camp.Supp_Count__c += cts.size();
    }
    
    public void finish(Database.BatchableContext bc)
    {
        try
        {
            if (camp.Control_Group_Percentage__c == null)
                camp.Control_Group_Percentage__c = 0;
            camp.CG_Count__c = Math.round(((camp.Current_Count__c - camp.Supp_Count__c)*integer.valueOf(camp.Control_Group_Percentage__c))/100);
            camp.Add_Member_Status__c = 'Adding Audience Report';
            update camp;
            
            Database.executeBatch(new Campaign_AudienceReportBatch(camp.Id, true), 1);
        }
        catch (Exception ex)
        {
            Tenet_Exception_Handler logError = new Tenet_Exception_Handler();
            logError.creatExceptionLog(ex,null,'Audience_dedupeBatch:Final');
        }
    }
}
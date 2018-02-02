public class Campaign_DeleteBatch implements Database.Batchable<sObject>, Database.Stateful
{
    private List<Id> campaignIds;
    
    public Campaign_DeleteBatch(List<Id> campIds)
    {
        campaignIds = campIds;
    }
    
    public Database.QueryLocator start(Database.BatchableContext bc)
    {
        //String query = 'SELECT Id FROM CRM_AudienceReport__c WHERE CRM_Campaign__c IN (' + getCampaignFilter(campaignIds) + ')';
        String query = 'SELECT Id FROM CRM_AudienceReport__c WHERE CRM_Campaign__c IN :campaignIds';
        System.debug(query);
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc, List<CRM_AudienceReport__c> scope)
    {
        try
        {
            delete scope;
        }
        catch (Exception ex)
        {
            createLogs(ex, 'Campaign_DeleteBatch: execute');
        }
    }
    
    public void finish(Database.BatchableContext bc)
    {
        try
        {
            delete [SELECT Id FROM Campaign WHERE Id in: campaignIds];
        }
        catch (Exception ex)
        {
            createLogs(ex, 'Campaign_DeleteBatch: finish');
        }
    }
    
    private string getCampaignFilter(List<Id> camIds)
    {
        String filter = '';
        for (String s : camIds)
            filter += s + ',';
        filter = filter.removeEnd(',');
        return filter;
    }
    
    private void createLogs(Exception ex, string sr)
    {
        Tenet_Exception_Handler logError = new Tenet_Exception_Handler();
        logError.creatExceptionLog(ex,null,sr);
    }
}
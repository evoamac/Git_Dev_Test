public class CampaignProcess_GetNetCount implements Database.Batchable<sObject>,Database.Stateful,Database.AllowsCallouts
{
    public final String query;
    //Changes for PP1 Start
    public set<id> campaignIds =  new set<Id>();
    //Changes for PP1 End
    public CampaignProcess_GetNetCount()
    {
        query = 'SELECT Id FROM Campaign WHERE Add_Member_Status__c=\'Order Placed\'';
    }
   
    public Database.QueryLocator start(Database.BatchableContext BC)
    {
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext BC,List<sObject> campaigns)
    {
         for(Sobject campaign : campaigns){
            CampaignMemberManager.getNetCount(campaign.id);
            campaignIds.add(campaign.id);
        }
    }
    
   public void finish(Database.BatchableContext BC){
       //Changes for PP1 Start
         set<id> campaignIdsProcessed = new set<id>();
         for(Campaign cm : [select Id from Campaign where Add_Member_Status__c='Adding Audience Report' AND Id IN: campaignIds]){
            campaignIdsProcessed.add(cm.Id);
         }
         if(campaignIdsProcessed.size()>0)
            Database.executeBatch(new Campaign_AudienceReportBatch(campaignIdsProcessed),1);
         //Changes for PP1 End
   }
}
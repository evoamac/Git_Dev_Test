public class CampaignProcess_ContactSyncToMarketo implements Database.Batchable<sObject>,Database.Stateful{
    public final String query;
    public Id campaignId;
    public boolean reprocessBatch;
    public CampaignProcess_ContactSyncToMarketo(Id campId)
    {
        reprocessBatch=false;
        campaignId = campId;
        query ='select id,contactId,contact.SyncToMarketo__c from CampaignMember where CampaignId=:campaignId AND Sync_To_Marketo__c=true AND ContactId!=null AND contact.SyncToMarketo__c=false order by CreatedDate desc';
    }
    
    public Database.QueryLocator start(Database.BatchableContext BC)
    {
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC,List<sObject> campaignMember)
    {
        try
        {
            list<Contact> updateContactList = new list<Contact>();
            for(Sobject t: campaignMember)
            { 
                CampaignMember cm = (CampaignMember)t;
                //if(!cm.contact.SyncToMarketo__c)//added in main query
                    updateContactList.add(new Contact(id=cm.ContactId,SyncToMarketo__c=true,SyncToMarketo_LastModifiedOn__c=DateTime.Now()));
                
            }
            
            if(updateContactList.size()>0){
                Database.SaveResult[] srList = Database.update(updateContactList,false);
                
                for (Database.SaveResult sr : srList){
                    if(!sr.isSuccess()){
                        reprocessBatch=true;
                        break;
                    }
                }
            }
       }
       catch(Exception ex)
       {
            Tenet_Exception_Handler logError = new Tenet_Exception_Handler();
            logError.creatExceptionLog(ex,null,'CampaignProcess_ContactSyncToMarketo');
       }    
    }
   
    public void finish(Database.BatchableContext BC)
    {
        if(reprocessBatch)
            Database.executeBatch(new CampaignProcess_ContactSyncToMarketo(campaignId), Integer.valueOf(Tenet_Static_Variables.tenetDataConfigSetting.get(Tenet_Static_Variables.Query_API_Page_Size).Static_Value__c));
        else
        	Database.executeBatch(new CampaignAudience_HistoryBatch(campaignId),2000);
    }
}
/*
	Author: AXU
*/
public class AudienceUploadController
{
    public Transient Blob fileBody { get; set; }
    //public Transient String csvString { get; set; }
    public Id campaignId { get; set; }
    public Boolean hasExistingUpload { get; set; }
    
    public AudienceUploadController()
    {
        try
        {
            if (String.isBlank(ApexPages.currentPage().getParameters().get('campaignId')))
            {
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CRM_AudienceUploadNoCampaignIdFound));
                return;
            }
            campaignId = ApexPages.currentPage().getParameters().get('campaignId');
        }
        catch (Exception ex)
        {
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CRM_AudienceUploadNoCampaignIdFound));
            return;
        }
        
        Campaign camp;
        try
        {
            camp = [SELECT CRM_AudienceUploadCount__c FROM Campaign WHERE Id =: campaignId];
        }
        catch (Exception ex)
        {
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CRM_Invalid_Campaign_ID));
            return;
        }
        hasExistingUpload = camp.CRM_AudienceUploadCount__c == null || camp.CRM_AudienceUploadCount__c == 0 ? false : true;
    }
    
    public PageReference importCsv()
    {
        PageReference ref = new PageReference('/apex/AudienceUpload');
        ref.getParameters().put('campaignId', campaignId);
        ref.setRedirect(true);
        
        update new Campaign(Id = campaignId, CRM_AudienceUploadCount__c = -1);
        
        importCsvFuture(fileBody, campaignId);
        return ref;
    }
    
    @future
    public static void importCsvFuture(Blob fileBodyfuture, Id campaignId)
    {
        String csvStringfuture;
        try
        {
            csvStringfuture = fileBodyfuture.toString();
        }
        catch (Exception ex)
        {
            update new Campaign(Id = campaignId, CRM_AudienceUploadCount__c = -2);
            return;
        }
        
        try
        {
            Transient AudienceUploadStringIterator ausi = New AudienceUploadStringIterator(csvStringfuture, null);
            Transient List<String> wdmIdChunks = new List<String>();
            Set<String> wdmIdSet = new Set<String>();
            Integer rowCount = 0;
            
            if (ausi.hasNext())
                ausi.next();
            
            while (ausi.hasNext())
            {
                Integer eachChunkCount = 0;
                String wdmIdChunk = '';
                while (wdmIdChunk.length() < 130000 && eachChunkCount < 9500 && ausi.hasNext())
                {
                    String thisString = ausi.next();
                    thisString = thisString.trim();
                    
                    if (!thisString.isNumeric())
                    {
                        update new Campaign(Id = campaignId, CRM_AudienceUploadCount__c = -2);
                        return;
                    }
                    
                    if (!wdmIdSet.contains(thisString))
                    {
                        wdmIdChunk += thisString + ',';
                        WdmIdSet.add(thisString);
                        eachChunkCount++;
                    }
                    rowCount++;
                    
                    if  (rowCount > 150000)
                    {
                        update new Campaign(Id = campaignId, CRM_AudienceUploadCount__c = -3);
                        return;
                    }
                }
                wdmIdChunks.add(wdmIdChunk);
            }
            
            List<Transaction__c> trans = new List<Transaction__c>();
            for (String s : wdmIdChunks)
            {
                Transaction__c t = new Transaction__c();
                t.Response_Schema__c = s;
                t.Campaign__c = campaignId;
                t.Transaction_Source__c = 'Audience Upload';
                trans.add(t);
            }
            
            update new Campaign(Id = campaignId, CRM_AudienceUploadCount__c = WdmIdSet.size(), CRM_AudienceUploadRowCount__c = rowCount);
            
            insert trans;
        }
        catch (Exception ex)
        {
            Tenet_Exception_Handler logError = new Tenet_Exception_Handler();
            logError.creatExceptionLog(ex,null,'Audience_dedupeBatch:Final');
        }
    }
    
    public static Boolean hasExistingFileUpload(Id CampaignId)
    {
        Integer transactionCount = 
        [
            SELECT Count()
            FROM Transaction__c
            WHERE Transaction_Source__c = 'Audience Upload'
            AND Campaign__c =: campaignId 
        ];
        return transactionCount > 0;
    }
}
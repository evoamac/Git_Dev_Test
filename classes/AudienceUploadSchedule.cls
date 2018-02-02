global class AudienceUploadSchedule implements Schedulable
{
    private Blob s_fileBody;
    private Id s_campaignId;

    
    global AudienceUploadSchedule(Blob fileBody, Id campaignId)
    {
        s_fileBody = fileBody;
        s_campaignId = campaignId;
    }
    
    global void execute(SchedulableContext ctx)
    {
        String csvStringfuture = s_fileBody.toString();
        AudienceUploadStringIterator ausi = New AudienceUploadStringIterator(csvStringfuture, null);
        List<String> wdmIdChunks = new List<String>();
        Integer rowCount = 0;
        
        if (ausi.hasNext())
            ausi.next();
        
        while (ausi.hasNext())
        {
            String wdmIdChunk = '';
            while (wdmIdChunk.length() < 130000 && ausi.hasNext())
            {
                String thisString = ausi.next();
                thisString = thisString.trim();
                
                if (!thisString.isNumeric())
                {
                    update new Campaign(Id = s_campaignId, CRM_AudienceUploadCount__c = -2);
                    return;
                }
                
                wdmIdChunk += thisString + ',';
                rowCount++;
            }
            wdmIdChunks.add(wdmIdChunk);
        }
        
        List<Transaction__c> trans = new List<Transaction__c>();
        for (String s : wdmIdChunks)
        {
            Transaction__c t = new Transaction__c();
            t.Response_Schema__c = s;
            t.Campaign__c = s_campaignId;
            t.Transaction_Source__c = 'Audience Upload';
            trans.add(t);
        }
        
        update new Campaign(Id = s_campaignId, CRM_AudienceUploadCount__c = rowCount);
        
        insert trans;
    }
}
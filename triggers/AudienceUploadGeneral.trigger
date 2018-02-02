//InActivating The Trigger for Covering few Test Classes
trigger AudienceUploadGeneral on CRM_AudienceUpload__c (before insert) 
{
    if (Trigger.isBefore && Trigger.isInsert)
    {
        AudienceUploadHelper_PP1.createJunctionRecords(Trigger.new);        
    }
}
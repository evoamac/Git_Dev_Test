trigger UploadGeneral on CRM_AudienceUpload__c (before insert, before update, after insert, after update) {


    if (Trigger.isBefore)
    {
        if (Trigger.isInsert)
        {
            //call AudienceUploadHelper
            AudienceUploadHelper.setJunctionUploadId(trigger.new);
        }

        if (Trigger.isUpdate)
        {
            //Currently not used
        }
    }

    if (Trigger.isAfter)
    {
        if (Trigger.isInsert)
        {
            //Currently not used
        }

        if (Trigger.isUpdate)
        {
            //Currently not used
        }
    }
}
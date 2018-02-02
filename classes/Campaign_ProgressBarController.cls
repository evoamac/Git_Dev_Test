public class Campaign_ProgressBarController
{
    public Campaign campaign {get;set;}
    public string status {get;set;}
    public string url {get;set;}
    public decimal countDiff {get;set;}
    public string recordType{get;set;}
    //Starting Of Defect 848 
    public string CampaignStatus {get;set;}
    public string recordprocessedMessage{get;set;} // Added for defect CRM-72 795 
    public string wdmDedupeProcessMessage { get; set; }
    public String resettingMessage { get; set; }
    public String uploadStatus { get; set; }
    public Integer duplicateCount { get; set; }
    
    public Campaign_ProgressBarController(ApexPages.StandardController stdController) 
    {
        url = ApexPages.currentPage().getUrl();
        this.campaign = (Campaign)stdController.getRecord();
      // Added CRM_ActivateProcessId__c in line 18 for defect CRM-72 795, only 5 campaigns can be activated
        campaign = 
        [
            SELECT 
                status,
                Current_Count__c,
                Segment__c,
                CRM_ActivateProcessId__c,
                Error_Message__c,
                List_Order_Id__c,
                recordtypeid, 
                Missing_Contact_Count__c, 
                of_CampaignMembers__c, 
                Add_Member_Status__c,
                CRM_WdmDedupeProcessId__c,
                CRM_UnlockProcessBatch_ID__c,
                CRM_AudienceUploadCount__c,
                CRM_AudienceUploadRowCount__c
            FROM 
                Campaign 
            WHERE 
                Id=:campaign.Id
        ];
        if (campaign.CRM_AudienceUploadCount__c == -2)
        {
            uploadStatus = 'Error';
        }
        else if (campaign.CRM_AudienceUploadCount__c > 0 && campaign.Current_count__c == null)
        {
            uploadStatus = 'Complete';
        }
        else if (campaign.CRM_AudienceUploadCount__c != null && campaign.CRM_AudienceUploadRowCount__c != null && campaign.CRM_AudienceUploadCount__c != campaign.CRM_AudienceUploadRowCount__c)
        {
            uploadStatus = 'Duplicate';
            duplicateCount = campaign.CRM_AudienceUploadRowCount__c.intValue() - campaign.CRM_AudienceUploadCount__c.intValue();
        }
        
        
       if(campaign.Missing_Contact_Count__c == null) campaign.Missing_Contact_Count__c = 0;
       if(campaign.Current_Count__c == null) campaign.Current_Count__c = 0;
       countDiff = campaign.Current_Count__c - (campaign.of_CampaignMembers__c + campaign.Missing_Contact_Count__c);
       system.debug('campaign.Missing_Contact_Count__c'+campaign.Missing_Contact_Count__c);
       system.debug('countDiff '+countDiff );
       
       status = campaign.Add_Member_Status__c;
        CampaignStatus =campaign.Status;
       
        recordType = [select id,developerName from recordtype where id=:campaign.recordtypeid].developerName;
    //starting of defect CRM-72 795, only 5 campaigns can be activated
        system.debug('***Constructor==status='+status);
        recordprocessedMessage = 'Activating Campaign';
        wdmDedupeProcessMessage = 'Processing Duplicate Wunderman IDs: 0% complete';
        if(!string.isBlank(campaign.CRM_ActivateProcessId__c))
                calculateProgress();
    }
    // ending of defect CRM-72 795
 //Ending Of Defect 848 
  //starting of defect CRM-72 795, only 5 campaigns can be activated
    public PageReference refresh()
    {
        campaign = 
            [
                SELECT 
                    Add_Member_Status__c,
                    CRM_ActivateProcessId__c,
                    List_Order_Id__c,
                    of_CampaignMembers__c,
                    Current_Count__c,
                    CRM_WdmDedupeProcessId__c,
                    CRM_UnlockProcessBatch_ID__c,
                    Segment__c
                FROM 
                    Campaign 
                WHERE 
                    Id=:campaign.Id];
        system.debug(status+'***Constructor==status='+campaign.Add_Member_Status__c);
        if(status!=campaign.Add_Member_Status__c || campaign.Add_Member_Status__c=='Added Members')
            return new PageReference(url);
        else{
            if(!string.isBlank(campaign.CRM_ActivateProcessId__c))
                calculateProgress();
            if (string.isNotBlank(campaign.CRM_WdmDedupeProcessId__c) && string.isBlank(campaign.CRM_UnlockProcessBatch_ID__c) )
                calculateWdmDedupeProgress();
            if(string.isNotBlank(campaign.CRM_UnlockProcessBatch_ID__c) && string.isBlank(campaign.CRM_WdmDedupeProcessId__c))
                 calculateUnlockDedupeProgress();
                 
           
            return null;
        }
    }
    //This method will calculate how many records have been processed during activation process
    private void calculateProgress(){
        
        if(Integer.valueOf(campaign.of_CampaignMembers__c)>0){
            recordprocessedMessage = Integer.valueOf(campaign.of_CampaignMembers__c)+' '+Label.Campaign_Activation_Request_In_Progress; //' members have been added so far.';
        }else{
            AsyncApexJob processDetails;
            // Bug fix reported by Chetan
            List<AsyncApexJob> lstProcessDetails = [SELECT JobItemsProcessed,Status,TotalJobItems FROM AsyncApexJob WHERE Id=:campaign.CRM_ActivateProcessId__c limit 1];
            if(lstProcessDetails.size()>0) {
                processDetails = lstProcessDetails[0];
                if(processDetails.Status=='Processing')
                    recordprocessedMessage = Integer.valueOf(campaign.of_CampaignMembers__c)+' '+Label.Campaign_Activation_Request_In_Progress;
                else if(processDetails.Status=='Failed' || processDetails.Status=='Aborted')        
                    recordprocessedMessage=Label.Campaign_Activation_Request_Failed;
                else if(processDetails.Status=='Completed')
                    recordprocessedMessage='Successfully activated the Campaign';
                else
                     recordprocessedMessage=Label.Campaign_Activation_Request_In_Queue;
           }
            // end of Bug fix reported by Chetan
        }
    }
// ending of defect CRM-72 795, only 5 campaigns can be activated

    private void calculateWdmDedupeProgress()
    {
        if (String.isNotBlank(campaign.Segment__c) || campaign.Add_Member_Status__c == 'Adding Members') return;
        
        List<AsyncApexJob> dedupeJobs = [SELECT JobItemsProcessed, Status, TotalJobItems FROM AsyncApexJob WHERE Id =: campaign.CRM_WdmDedupeProcessId__c LIMIT 1];
        if (dedupeJobs.size() < 1) return;
        
      
        
        AsyncApexJob DedupeJob = dedupeJobs[0];
        if (dedupeJob.Status == 'Holding' || dedupeJob.Status == 'Queued' || dedupeJob.Status == 'Preparing' || dedupeJob.Status == 'Processing')
        {
            Decimal percentCompleted = 0.0;
            if (DedupeJob.TotalJobItems != 0)
                percentCompleted = DedupeJob.JobItemsProcessed * 1.0 / DedupeJob.TotalJobItems * 100;
            percentCompleted = percentCompleted.setScale(2);
            wdmDedupeProcessMessage = Label.CRM_ProcessingDuplicateWundermanIds + ': ' + percentCompleted + '% Complete';
        }        
        else if (dedupeJob.Status == 'Failed' || dedupeJob.Status == 'Aborted')
        {
            wdmDedupeProcessMessage = 'There was an error during the Wunderman Deduping process. please contact Support';
        }
        /*
        else
        {   
            campaign.Add_Member_Status__c = 'Calculated Net Count';            
            campaign.CRM_WdmDedupeProcessId__c = null;
            update new Campaign(Id = campaign.Id, Add_Member_Status__c = 'Calculated Net Count', CRM_WdmDedupeProcessId__c = null);
        }
        */
    }
    
    private void calculateUnlockDedupeProgress()
    {
        List<AsyncApexJob> unlockdedupeJobs = [SELECT JobItemsProcessed, Status, TotalJobItems FROM AsyncApexJob WHERE Id =: campaign.CRM_UnlockProcessBatch_ID__c LIMIT 1];
        system.debug('after if batch---'+unlockdedupeJobs.size() );
        if(unlockdedupeJobs.size()<1) return;   
        
        
        resettingMessage = Label.CRM_Resetting_Segment;
        AsyncApexJob unDedupeJob = unlockdedupeJobs[0];
        system.debug('unlock batch status #@@@@'+ unDedupeJob.Status);
        if(unDedupeJob.Status=='Completed')
        {
            system.debug('unlock batch status #@@@@'+ unDedupeJob.Status);
            campaign.Add_Member_Status__c = null;
            campaign.CRM_UnlockProcessBatch_ID__c=null;
        }
        else if (unDedupeJob.Status == 'Failed' || unDedupeJob.Status == 'Aborted')
        {
            campaign.Add_Member_Status__c = null;
            campaign.CRM_UnlockProcessBatch_ID__c=null;
            resettingMessage = 'Unlocking process failed, please contact Support';
        }
        update campaign;
    
    }

}
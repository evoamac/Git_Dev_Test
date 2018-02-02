public with sharing class AudienceUploadHelper_PP1
{

    public static void createJunctionRecords(List<CRM_AudienceUpload__c> uploads)
    {
        Id campaignId = fetchCampaignId();
    }

    private static Id fetchCampaignId()
    {
        List<CRM_UserCampaign__c> userCampaigns = 
        [
            SELECT CRM_CampaignId__c
            FROM CRM_UserCampaign__c
            WHERE CRM_UserId__c =: UserInfo.getUserId()
        ];

        if (userCampaigns.size() != 1)
        {
            //TODO: throw exception
        }

        return userCampaigns[0].CRM_CampaignId__c;
    }  
    
}
public class CRM_CountSummaryController 
{
    public List<Campaign> lstSegmentCampaigns{get;set;}
    public Campaign parentCampaign{get;set;}
    public id CampId{get;set;}
    public integer totalSuppressionCount{get;set;} // added to get the dedupe count for each segment
    public integer totalMissingCount{get;set;}
    public integer totalFinalCount{get;set;}
   
    public CRM_CountSummaryController(ApexPages.StandardController controller)
    {
         lstSegmentCampaigns=new List<Campaign>();
         CampId=ApexPages.CurrentPage().getParameters().get('Id');
         if(CampId!=null)
         {
             parentCampaign=[select status ,Name ,Member_Types__c,Segment__c,Current_count__c,Missing_Contact_Count__c,CG_Count__c,Suppression_Count__c,Supp_Count__c,Control_Group_Count__c ,Net_Count__c,CRM_WundermanDuplicateCount__c from campaign where id=:CampId];
             lstSegmentCampaigns=[select status ,Segment__c,Current_count__c,Missing_Contact_Count__c,CG_Count__c,Suppression_Count__c,Supp_Count__c,Control_Group_Count__c ,Net_Count__c from campaign where CRM_ParentSegmentedCampaign__c=:parentCampaign.id];
             dedupeSegmentCount();
        
         } 
    }
    public pagereference enc_back()
    {
        pagereference ref;
        if(CampId!=null)
        {
            ref = new Pagereference('/apex/CampaignWizard?Id='+CampId+'&stepNo=3');
            ref.setredirect(true);             
        }
        return ref;
    }
    
     public pagereference callAnalysisByPreferredHospital()
    {
        pagereference ref;
        if(CampId!=null && parentCampaign.Member_Types__c=='Campaign Segments')
        {
            ref = new Pagereference('/'+System.label.CRM_ReportSegmentedAnalysisByPreferredHospitalId+'?pv0='+parentCampaign.name);             
        }
        else if(CampId!=null && parentCampaign.Member_Types__c!='Campaign Segments')
        {
            ref = new Pagereference('/'+System.label.CRM_ReportNonSegmentedAnalysisByPreferredHospitalId+'?pv0='+parentCampaign.name);
        }
        ref.setredirect(true);
        return ref;
    }
     public pagereference callAnalysisByZipcode()
    {
        pagereference ref;
        if(CampId!=null && parentCampaign.Member_Types__c=='Campaign Segments')
        {
            ref = new Pagereference('/'+System.Label.CRM_ReportSegmentedAnalysisByZipcodeId+'?pv0='+parentCampaign.name);             
        }
        else if(CampId!=null && parentCampaign.Member_Types__c!='Campaign Segments')
        {
            ref = new Pagereference('/'+System.label.CRM_ReportNonSegmentedAnalysisByZipcodeId+'?pv0='+parentCampaign.name);
        }
        ref.setredirect(true);
        return ref;
    }
    public pagereference callAnalysisTotalsOnly()
    {
        pagereference ref;
        if(CampId!=null && parentCampaign.Member_Types__c=='Campaign Segments')
        {
            ref = new Pagereference('/'+System.label.CRM_ReportSegmentedAnalysisTotalsOnlyId+'?pv0='+parentCampaign.name);
        }
        else if(CampId!=null && parentCampaign.Member_Types__c!='Campaign Segments')
        {
            ref = new Pagereference('/'+System.label.CRM_ReportNonSegmentedAnalysisTotalsOnlyId+'?pv0='+parentCampaign.name);
        }
        ref.setredirect(true);
        return ref;
    }    
   //added for dedupe count on each segment 
    public void dedupeSegmentCount()
    {
        List<id> segmentchildID = new List<id>();
        totalSuppressionCount = 0;
        totalMissingCount=0;
        totalFinalCount=0;
        for(campaign c : lstSegmentCampaigns)
        {
            segmentchildID.add(c.id);
        }   
        Integer duplicateARList = [SELECT count() FROM CRM_AudienceReport__c WHERE CRM_Campaign__c IN: segmentchildID AND CRM_WundermanDupe__c = true AND CRM_Supression__c = 1 AND CRM_AudienceUploadJunction__r.CRM_ToDelete__c = false ];
        totalSuppressionCount+=duplicateARList;
            
        Integer duplicateMissingList = [SELECT count() FROM CRM_AudienceReport__c WHERE CRM_Campaign__c IN: segmentchildID AND CRM_WundermanDupe__c = true AND CRM_Missing__c = 1 AND CRM_AudienceUploadJunction__r.CRM_ToDelete__c = false];
        
        totalMissingCount+=duplicateMissingList;
        Integer S = Integer.valueOf(parentCampaign.CRM_WundermanDuplicateCount__c);
        If(S!=null)
        {
            totalFinalCount= S-(totalSuppressionCount+totalMissingCount);
        }
        else
        {
            totalFinalCount=0-(totalSuppressionCount+totalMissingCount);
        }
    }
    
    
}
public class CampaignCriteria_GeographiesController
{
    public Campaign objcampaign {get;set;} 
    public boolean hasServiceAreas {get;set;}
    public boolean hasBoundaries {get;set;}
    public boolean hasDistances {get;set;}
    
    public boolean hasGeoSetup 
    {
        get {return hasServiceAreas || hasBoundaries || hasDistances;}
    }
       
    public CampaignCriteria_GeographiesController(ApexPages.StandardController stdController)
    {
        hasServiceAreas = false;
        hasBoundaries = false;
        hasDistances = false;
        
        this.objcampaign = (Campaign)stdController.getRecord();
        
        integer serviceAreasCount = [Select count() from Campaign_Location__c where Campaign__c=:objcampaign.Id ]; 
        if(serviceAreasCount>0)
           hasServiceAreas = true;
        else
        {
            integer boundariesCount = [Select count() from Geographic_Info_Information__c where Campaign__c=:objcampaign.Id AND Audience_Search_Type__c='Geography By Boundary'];
            if(boundariesCount>0)
                hasBoundaries = true;
            else
            {
                integer distancesCount = [Select count() from Geographic_Info_Information__c where Campaign__c=:objcampaign.Id AND Audience_Search_Type__c='Geography By Distance'];
                if(distancesCount>0)
                    hasDistances = true;
            }        
        }        
    }
    
    public PageReference BackToCampaign()
    {
        return new PageReference('/apex/CampaignWizard?id='+ objcampaign.id + '&stepNo=3');
    }
    
    public PageReference AddServiceAreas()
    {
        return new PageReference('/apex/CampaignCriteria_ServiceAreas?id='+ objcampaign.id);
    } 
    
    public PageReference AddBoundaries()
    {
        return new PageReference('/apex/CampaignCriteria_Boundaries?id='+ objcampaign.id);
    } 
    
    public PageReference AddDistances()
    {
        return new PageReference('/apex/CampaignCriteria_Distances?id='+ objcampaign.id);
    } 
    //start of home address change
     public PageReference AddHomeAddress()
    {
        return new PageReference('/apex/HomeAddress?id='+ objcampaign.id);
    }  
    // end of home address change
    
    //delete All Geography By Service Area records for this campaign
    public pageReference deleteAllGeoServiceArea()
    {
        list<Campaign_Location__c> campLoc = [SELECT Zip_Code__c FROM Campaign_Location__c where campaign__c=:objcampaign.id]; 
        CampaignMemberCriteriaManager.deleteCriteria('ZipCode__c', objcampaign.id, false);
      
        if(campLoc.size()>0)
            delete campLoc;
            
        Pagereference  pg = new Pagereference('/apex/CampaignCriteria_Geographies?Id='+objcampaign.id);
        pg.setRedirect(true);
        return pg;
    }
  
    //delete All Geography By Boundary and Distance records for this campaign
    public pageReference deleteAllGeoBoundaryDistance()
    {
        list<Geographic_Info_Information__c> campLoc = [select id from Geographic_Info_Information__c where Campaign__c=:objcampaign.id limit 10000];
        CampaignMemberCriteriaManager.deleteCriteria('ZipCode__c', objcampaign.id, false);
      
        if(campLoc.size()>0)
            delete campLoc;
        
        Pagereference  pg = new Pagereference('/apex/CampaignCriteria_Geographies?Id='+objcampaign.id);
        pg.setRedirect(true);
        return pg;
    }
    
}
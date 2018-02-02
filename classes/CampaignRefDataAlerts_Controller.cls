public class CampaignRefDataAlerts_Controller{
    
    public Campaign objcampaign {get;set;}
    public string alertMessage{get;set;}
    
    public CampaignRefDataAlerts_Controller(ApexPages.StandardController stdController){
        this.objcampaign = (Campaign)stdController.getRecord();
        if(this.objcampaign.Id!=null)
            alertMessage=ClonePlusController.inactiveOptionAlertMessage(new set<id>{this.objcampaign.id},false);
        if(!string.isBlank(alertMessage)){
            alertMessage= System.Label.CRM_Home_Address_Criteria_Clone+'<br/>'+alertMessage;
            CampaignWizardController.RefData_Alert=true;
        }
    }
}
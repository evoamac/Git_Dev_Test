@istest
public class CampaignTemplateController_Test
{
 public static testmethod void CampaignTemplateMethod()
 {
  Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.CRM_SubServiceLineText__c='Dermatology';
            newCampaign.Channel__c='Direct Mail';
            newCampaign.Save_Campaign_as_Template__c=True;
             insert newCampaign;   
   list<Selectoption> listslect = new list<selectoption>();
   listslect.add(new SelectOption('US','US'));
     pagereference testpage = new pagereference ('/apex/CampaignTemplate');
     Test.setcurrentPage(testPage);     
          ApexPages.currentPage().getParameters().put('id',newCampaign.id);
          ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
          CampaignTemplateController  Template = new CampaignTemplateController(sc);   
       Template.c=newCampaign;
       Template.SelectedSubServLines=listslect;
       Template.TempFlag=True;
       Template.ButtonFlag=True;
       Template.getSavedTemplate();
       Template.TemplateSelection();
       Template.SaveCamp();
       //Template.SubServiceLine();
  
  }
}
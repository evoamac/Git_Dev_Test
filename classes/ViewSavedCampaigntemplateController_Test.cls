@istest
public class ViewSavedCampaigntemplateController_Test
{
 public static testmethod void ViewSavedCampaign()
 {
list<campaign> listcmp = new list<campaign>();
Campaign newCampaign = marketingDataUtils.CreateCampaign();
 listcmp.add(newCampaign);
   pagereference testpage = new pagereference('apex/ViewSavedCampaignTemplate');
   test.setcurrentpage(testpage);
   apexpages.StandardController sc = new apexpages.standardController(newCampaign);
ViewSavedCampaigntemplateController viewsavedcamp = new ViewSavedCampaigntemplateController(sc);
    viewsavedcamp.clist=listcmp;
    viewsavedcamp.searchString = 'lksrch';
    viewsavedcamp.getCamp();
    viewsavedcamp.Search();
    viewsavedcamp.getFormTag();
    viewsavedcamp.getTextBox();
 }
}
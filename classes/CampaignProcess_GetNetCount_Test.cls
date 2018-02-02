@istest
public class CampaignProcess_GetNetCount_Test{
 public static testmethod void CampaignProcessMethod(){
 list<Campaign> camplist = new list<Campaign>();
  campaign cmp = marketingDataUtils.CreateCampaign();
   camplist.add(cmp);
     CampaignProcess_GetNetCount CampaignProcess = new CampaignProcess_GetNetCount();
      Database.BatchableContext BC;
          CampaignProcess.start(BC);
          CampaignProcess.execute(BC,camplist);
          CampaignProcess.finish(BC);
   }
}
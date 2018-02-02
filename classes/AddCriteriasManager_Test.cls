@istest
Public class AddCriteriasManager_Test
{	
 	public static testmethod void AddCriteriasMethod()
 	{
		 //Git Commit
		 //Git Commit 2
		campaign cmp = marketingDataUtils.CreateCampaign();
		String SFDCAPIName ='Test';
		String operator = 'AND';
		String csvValue = 'txt';
		String criteriaID = 'testagain';
		String criteriaGroupID = 'txt1';
		ID Campaignid = cmp.id;
		AddCriteriasManager.addCriterias(SFDCAPIName,operator,csvValue,criteriaID,criteriaGroupID,Campaignid);
 	}
}
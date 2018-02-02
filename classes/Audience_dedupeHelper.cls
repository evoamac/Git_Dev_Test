/*
	Created By : Amit Dahiya
	Created Date : 19 Dec 2017
	Summary : This class is used to identify and handle the duplicate wunderman id's for segment campaign
*/
public class Audience_dedupeHelper{
    
    
    
    public static Id batchId{get;set;}
    public static Id unlockbatchID{get;set;}
    

	public Audience_dedupeHelper(){
	 
	}
	
	public static void manageContactIdDeDuping(id campId){
	
		map<id,Decimal> campIdListOrderIdMap = new map<id,Decimal>();
		Campaign segmentCampaign;
		//This loop will run only once
		for(Campaign cc : [SELECT Id,Supp_Count__c,Current_count__c,Missing_Contact_Count__c,Control_Group_Percentage__c,Control_Group_Size__c,(select id,List_Order_Id__c from CRM_SegmentedParentCampaigns__r) From Campaign where Id =:campId]){
			segmentCampaign = cc;
			for(Campaign cmp : cc.CRM_SegmentedParentCampaigns__r)
				campIdListOrderIdMap.put(cmp.Id,cmp.List_Order_Id__c);
				
		}
		
		map<string,integer> wIdDuplicateCountMap = countDeuplicateWundermanIds(campIdListOrderIdMap);
		
		integer duplicateCount=0;
		for(Integer rc : wIdDuplicateCountMap.values()){
			duplicateCount += rc;
		}
		
		if(duplicateCount>0){
			set<Id> auIdSet = new set<Id>();
			for(CRM_AudienceUploadJunction__c au : [select id from CRM_AudienceUploadJunction__c where CRM_Campaign__c IN: campIdListOrderIdMap.keySet() AND CRM_ToDelete__c=false]){
				auIdSet.add(au.id);
			}
				
			if(duplicateCount<9500){//SFDC limit is 10000 but to make sure we cover other dml in same request we are using limit as 9500
				
				list<CRM_AudienceReport__c> auReportList = [select id,CRM_Supression__c,CRM_ControlGroup__c,CRM_Missing__c,CRM_WundermanID__c,CRM_WundermanDupe__c from CRM_AudienceReport__c where CRM_AudienceUploadJunction__c IN: auIdSet AND CRM_WundermanID__c IN: wIdDuplicateCountMap.keySet() order by CRM_WundermanID__c,createdDate asc];
				
				//Update Deduping details on Campaign
				manageDedupe(segmentCampaign,auReportList,null);
				
				update segmentCampaign;
				
				
			}else{
				//Call batch class
				system.debug('i am else of greater than 9500');
                
			Database.executeBatch(new Audience_dedupeBatch(segmentCampaign,auIdSet,wIdDuplicateCountMap.keySet()),2000);
			
                
               
            }
		}
	}
	
	//AXU get Changed for Batch Job ID
	public static string manageContactIdDeDuping2(id campId){
	
		map<id,Decimal> campIdListOrderIdMap = new map<id,Decimal>();
		Campaign segmentCampaign;
		//This loop will run only once
		for(Campaign cc : [SELECT Id,Supp_Count__c,Current_count__c,Missing_Contact_Count__c,Control_Group_Percentage__c,Control_Group_Size__c,(select id,List_Order_Id__c from CRM_SegmentedParentCampaigns__r) From Campaign where Id =:campId]){
			segmentCampaign = cc;
			for(Campaign cmp : cc.CRM_SegmentedParentCampaigns__r)
				campIdListOrderIdMap.put(cmp.Id,cmp.List_Order_Id__c);
				
		}
		
		map<string,integer> wIdDuplicateCountMap = countDeuplicateWundermanIds(campIdListOrderIdMap);
		
		integer duplicateCount=0;
		for(Integer rc : wIdDuplicateCountMap.values()){
			duplicateCount += rc;
		}
		
		if(duplicateCount>0){
			set<Id> auIdSet = new set<Id>();
			for(CRM_AudienceUploadJunction__c au : [select id from CRM_AudienceUploadJunction__c where CRM_Campaign__c IN: campIdListOrderIdMap.keySet() AND CRM_ToDelete__c=false]){
				auIdSet.add(au.id);
			}
				
			if(duplicateCount<9500){//SFDC limit is 10000 but to make sure we cover other dml in same request we are using limit as 9500
				
				list<CRM_AudienceReport__c> auReportList = [select id,CRM_Supression__c,CRM_ControlGroup__c,CRM_Missing__c,CRM_WundermanID__c,CRM_WundermanDupe__c from CRM_AudienceReport__c where CRM_AudienceUploadJunction__c IN: auIdSet AND CRM_WundermanID__c IN: wIdDuplicateCountMap.keySet() order by CRM_WundermanID__c,createdDate asc];
				
				//Update Deduping details on Campaign
				manageDedupe(segmentCampaign,auReportList,null);
				
				update segmentCampaign;
				
				
			}else{
				//Call batch class
				system.debug('i am else of greater than 9500');
                
			    batchId = Database.executeBatch(new Audience_dedupeBatch(segmentCampaign,auIdSet,wIdDuplicateCountMap.keySet()),2000);
			
                
                
                return batchId;
            }
		}
		return null;
	}	
    
    
    
    
	
	public static map<string,integer> countDeuplicateWundermanIds(map<id,Decimal> campIdListOrderIdMap){
		set<string> widSet = new set<string>();
		map<string,integer> wIdDuplicateCountMap = new map<string,integer>();
		for(Transaction__c tr : [select id,Response_Schema__c from Transaction__c where Campaign__c IN: campIdListOrderIdMap.keySet() AND ((WM_List_Order_Id__c IN: campIdListOrderIdMap.values() AND Type__c='GetOrderData') OR (Transaction_Source__c = 'Audience Upload')) order by Campaign__c,createdDate asc]){
			if(tr.Response_Schema__c!=null)
			{
                if(widSet.isEmpty())
                {
					widSet.addAll(tr.Response_Schema__c.split(','));
                }
				else
				{
					for(string wid : tr.Response_Schema__c.split(','))
					{
						if(widSet.contains(wid))
						{
                            
							if(wIdDuplicateCountMap.containsKey(wid))
							{
								wIdDuplicateCountMap.put(wid,wIdDuplicateCountMap.get(wid)+1);
							}
							else
							{
								wIdDuplicateCountMap.put(wid,1);
							}
						}
						else
						{
							widSet.add(wid);
						}
					}	
				}
			}
		}
		return wIdDuplicateCountMap;
	}
	
	public static void manageDedupe(Campaign segmentCampaign,list<CRM_AudienceReport__c> auReportList,string firstWid){
		
		list<CRM_AudienceReport__c> duplicateARList = new list<CRM_AudienceReport__c>();
		integer suppressionCount=0;
		integer missingCount=0;
		firstWid = null;
		
		for(CRM_AudienceReport__c ar : auReportList){
			//We will not mark first record as duplicate 
			if(firstWid != ar.CRM_WundermanID__c){
				firstWid = ar.CRM_WundermanID__c;
				continue;
			}else{
				//if(!ar.CRM_WundermanDupe__c){
					ar.CRM_WundermanDupe__c=true;
					duplicateARList.add(ar);
				//}
				
				if(integer.valueOf(ar.CRM_Supression__c) == 1)
					suppressionCount +=1;
				if(integer.valueOf(ar.CRM_Missing__c) == 1)
					missingCount +=1;
			}
		}
		
		if(duplicateARList.size()>0)
			update duplicateARList;
		
		segmentCampaign.Current_count__c -=  duplicateARList.size();
		segmentCampaign.Supp_Count__c -=suppressionCount;
		segmentCampaign.Missing_Contact_Count__c -=missingCount;
		//In case duplicate are less than 9500 this will update the duplicate count on campaign
		segmentCampaign.CRM_WundermanDuplicateCount__c=duplicateARList.size();
		segmentCampaign.CG_Count__c = Math.round(((segmentCampaign.Current_count__c - segmentCampaign.Supp_Count__c - segmentCampaign.Missing_Contact_Count__c) * Integer.valueOf(segmentCampaign.Control_Group_Percentage__c))/100);
	}
	
	public static String resetAuReportDuplicateHandler(Id campId){
		Campaign cmp = [select id,Member_Types__c,CRM_WundermanDuplicateCount__c,Control_Group_Percentage__c,Control_Group_Size__c,CRM_ParentSegmentedCampaign__c,CRM_ParentSegmentedCampaign__r.CRM_WundermanDuplicateCount__c from Campaign where Id=:campId];
        integer duplicateCount = Integer.valueOf(cmp.CRM_ParentSegmentedCampaign__r.CRM_WundermanDuplicateCount__c);
        if(cmp.Member_Types__c!='Campaign Segments' && cmp.CRM_ParentSegmentedCampaign__c !=null){
        	
        	set<Id> auIdSet = new set<Id>();
			for(CRM_AudienceUploadJunction__c au : [select id from CRM_AudienceUploadJunction__c where CRM_Campaign__c IN: [select id from Campaign where CRM_ParentSegmentedCampaign__c=:cmp.CRM_ParentSegmentedCampaign__c] AND CRM_ToDelete__c=false]){
				auIdSet.add(au.id);
			}
			
        	if(duplicateCount!=null && duplicateCount!=0 && duplicateCount<9500){
        		list<CRM_AudienceReport__c> duplicateARList = [select id,CRM_Supression__c,CRM_ControlGroup__c,CRM_Missing__c,CRM_WundermanID__c from CRM_AudienceReport__c where CRM_AudienceUploadJunction__c IN: auIdSet AND CRM_WundermanDupe__c=true];
        		resetAuReportDuplicate(duplicateARList,cmp);
        	}else if(duplicateCount>=9500){
        		//Call Batch Class Here
        	unlockbatchID =	Database.executeBatch(new Audience_dedupeBatch(cmp,auIdSet),2000);
                return unlockbatchID;
        	}
        		
        }
        return null;
	}
	public static void resetAuReportDuplicate(list<CRM_AudienceReport__c> auReportList,Campaign cmp){
		list<CRM_AudienceReport__c> duplicateARList = new list<CRM_AudienceReport__c>();
		for(CRM_AudienceReport__c ar : auReportList){
			ar.CRM_WundermanDupe__c=false;
			duplicateARList.add(ar);
		}
		
		if(duplicateARList.size()>0)
			update duplicateARList;
        
        
		if(cmp!=null)	
			update new Campaign(id=cmp.CRM_ParentSegmentedCampaign__c,CRM_WundermanDuplicateCount__c=0);
        system.debug('id of parent==='+cmp.CRM_ParentSegmentedCampaign__c);
	}
}
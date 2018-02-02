/*

Author: Amit Dahiya
Date: 10-10-2017
Description: This class will be used to prepare data for Campaign Audience Report

*/
public class AudienceReport_Helper{
	//This should not be a mehtod, this should done in Batch apex start method and then batch execute method should process each transaction record one by one
	public static void createCampaignAudienceReport(id campId){
		Campaign campObj = [SELECT Id, List_Order_Id__c FROM Campaign WHERE Id =: campId];
		list<Transaction__c> contactWundermanIdList = 
		[ 
			SELECT 
				id, 
				Response_Schema__c,
				Campaign__c 
			FROM 
				Transaction__c
			WHERE 
				Campaign__c =: campObj.Id
			AND 
				WM_List_Order_Id__c =: campObj.List_Order_Id__c
		];
		for(Transaction__c tran:contactWundermanIdList){
			if(!string.isBlank(tran.Response_Schema__c)){
				set<string> contactIds=new set<string>();
				contactIds.addAll(tran.Response_Schema__c.split(','));
				prepareAudienceRecord(tran.Campaign__c,contactIds);
			}
		}
	}
	//This method should be used in batch apex execute method
	public static List<CRM_AudienceReport__c> prepareAudienceRecord(Id campId, set<String> windermanIds){
		Id uploadRecordTYpeId = ReferenceData_PicklistController.recordTypeId('CRM_AudienceUploadJunction__c','Audience_Report');
		Map<String, String> hospitalMap = getHospitalMap();   //AXU Edited 12-02-2017
		
		Campaign campObj = 
		[
			SELECT 
				Id,
				CRM_ParentSegmentedCampaign__c,
				Member_types__c,
				List_Order_Id__c,
				Ignore_Bad_Debt_Suppression__c,
				Ignore_Minor_Suppression__c,Missing_Contact_Count__c,
				Channel__c,(select id from CRM_AudienceUploadJunctions__r where CRM_ToDelete__c=false AND RecordTypeId=:uploadRecordTYpeId) 
			FROM 
				Campaign 
			WHERE 
				Id =: campId
		];
		
		CRM_AudienceUploadJunction__c junctionUploadRecord;
		if(campObj.CRM_AudienceUploadJunctions__r.size()>0)
			junctionUploadRecord = campObj.CRM_AudienceUploadJunctions__r[0];	
		else{
			junctionUploadRecord = new CRM_AudienceUploadJunction__c(CRM_Campaign__c=campObj.Id,RecordTypeId=uploadRecordTYpeId);
			insert junctionUploadRecord;
		}
		List<CRM_AudienceReport__c> insertAudienceReportList = new list<CRM_AudienceReport__c>();
		for(Contact con : [
				SELECT 
					Id,Wunderman_Id__c,
					HospitalName__c,
					MailingPostalCode,
					SUP_BAD_DEBT__c,
					SUP_Minor__c,
					SUP_NON_EMAIL__c,
					HasOptedOutOfEmail,
					Industry_Suppr_State_Level_Do_Not_Mail__c,
					SUP_Clinical_Disease_States__c,
					SUP_Deceased_External__c,
					SUP_Deceased_Internal__c,
					SUP_Incarcerated__c,
					SUP_Name_formats__c,
					SUP_Discharge_Status__c,
					SUP_Industry_State_Level__c,
					hospitalCode__c,                    //AXU Edited 12-02-2017
					Number_of_Encounters__c             //AXU Edited 12-02-2017
				FROM 
					Contact 
				WHERE 
					Wunderman_Id__c IN:windermanIds 
			])
		{
			
	  		CRM_AudienceReport__c newAudienceReport = new CRM_AudienceReport__c(
				CRM_Campaign__c = campObj.Id,
				CRM_AudienceUploadJunction__c=junctionUploadRecord.id,
				CRM_ParentCampaign__c = campObj.CRM_ParentSegmentedCampaign__c,                                                                         //AXU Edited 12-02-2017
				CRM_ListOrderId__c = campObj.List_Order_Id__c,
				CRM_Member__c = con.Id,
				CRM_Hospital__c = con.hospitalCode__c, //AXU Edited 12-02-2017
				Preferred_Hospital__c = hospitalMap.get(con.hospitalCode__c),
				Patient_Prospect__c = con.Number_of_Encounters__c > 0 ? 'Patient' : 'Prospect',                                                         //AXU Edited 12-02-2017
				CRM_ZipCode__c= String.isBlank(con.MailingPostalCode) ? '•No Zip Code' : con.MailingPostalCode,                                         //AXU Edited 12-02-2017
				CRM_WundermanID__c = con.Wunderman_Id__c);
				
		    if (String.isBlank(newAudienceReport.Preferred_Hospital__c))                                                                                //AXU Edited 12-02-2017
		        newAudienceReport.Preferred_Hospital__c = '•No Preferred Hospital';                                                                     //AXU Edited 12-02-2017
				
				
			if((!campObj.Ignore_Bad_Debt_Suppression__c && 
				con.SUP_BAD_DEBT__c) ||
				(!campObj.Ignore_Minor_Suppression__c &&
				con.SUP_Minor__c) || 
				(campObj.Channel__c=='Email'  && 
				(con.SUP_NON_EMAIL__c || 
				con.HasOptedOutOfEmail)) || 
				(campObj.Channel__c=='Direct Mail' && 
				con.Industry_Suppr_State_Level_Do_Not_Mail__c) || 
				con.SUP_Clinical_Disease_States__c || 
				con.SUP_Deceased_External__c || 
				con.SUP_Deceased_Internal__c || 
				con.SUP_Incarcerated__c || 
				con.SUP_Name_formats__c || 
				con.SUP_Discharge_Status__c || 
				con.SUP_Industry_State_Level__c)
                newAudienceReport.CRM_Supression__c=1;
            else
            	newAudienceReport.CRM_Supression__c=0;
            
            //newAudienceReport.CRM_ControlGroup__c=????;	
			
			insertAudienceReportList.add(newAudienceReport);
			windermanIds.remove(con.Wunderman_Id__c);
		}
		//This will create Audience reprot records for WID's not available in SFDC
		for(String wdId : windermanIds){
			CRM_AudienceReport__c newAudienceReport = new CRM_AudienceReport__c(
				CRM_Campaign__c = campObj.Id,
				CRM_AudienceUploadJunction__c=junctionUploadRecord.id,
				CRM_ParentCampaign__c = campObj.CRM_ParentSegmentedCampaign__c,
				CRM_ListOrderId__c = campObj.List_Order_Id__c,
				Preferred_Hospital__c = '•Missing',                                                                                                     //AXU Edited 12-02-2017
	            Patient_Prospect__c = 'Missing',                                                                                                        //AXU Edited 12-02-2017
				CRM_ZipCode__c = '•Missing',                                                                                                            //AXU Edited 12-02-2017
				CRM_WundermanID__c = wdId);
			insertAudienceReportList.add(newAudienceReport);
		}
		if(campObj.Missing_Contact_Count__c==null)
			campObj.Missing_Contact_Count__c=0;
		
		campObj.Missing_Contact_Count__c +=windermanIds.size();
		
		update campObj;
		
		return insertAudienceReportList;
	}

	public static List<CRM_AudienceReport__c> prepareAudienceRecord(Id campId, Map<Id, String> campaignAudiences)
	{
		//TODO..
		return null;
	}
    
    //This method will rollup final count to segmented campaign 
    public static void rollupFinalCountDetailToSegmented(list<Id> campId, boolean isDelete,boolean isQuickCount){
    	set<id> camIds = new set<id>();
    	camIds.addAll(campId);
        set<id> parentCampaignIds = new set<id>();
        id segmentCampaignId;
        for(Campaign cmp :[select id, Member_types__c, CRM_ParentSegmentedCampaign__c  from campaign where id IN:camIds]){
        	if(cmp.CRM_ParentSegmentedCampaign__c!=null)
        		parentCampaignIds.add(cmp.CRM_ParentSegmentedCampaign__c);
        	if(string.valueOf(cmp.Member_types__c).equalsIgnoreCase('Campaign Segments')){
        		parentCampaignIds.add(cmp.id);
        		segmentCampaignId=cmp.id;
        	}
        }
        system.debug('****parentCampaignIds='+parentCampaignIds);
        if(parentCampaignIds.size()>0){
	        map<Id,Campaign> rollupCampaignMap = new map<Id,Campaign>();
	        
	        for(Campaign cc : [SELECT Id,Supp_Count__c,Current_count__c,Missing_Contact_Count__c,CRM_ParentSegmentedCampaign__r.Control_Group_Percentage__c,CRM_ParentSegmentedCampaign__r.Control_Group_Size__c,CRM_ParentSegmentedCampaign__c From Campaign where CRM_ParentSegmentedCampaign__c IN:parentCampaignIds]){
	        	//This check will make sure we only rollup campaigns which are not going to be deleted
	        	system.debug(isDelete+'=*****='+camIds.contains(cc.Id));
        		system.debug('=*****='+cc.Id);
	        	
	        	if(cc.Current_count__c==null || (isDelete && camIds.contains(cc.Id)))
                	cc.Current_count__c=0;
                if(!isQuickCount){
	                if(cc.Supp_Count__c==null || (isDelete && camIds.contains(cc.Id)))
	                    cc.Supp_Count__c=0;
	                    
	                if(cc.Missing_Contact_Count__c==null || (isDelete && camIds.contains(cc.Id)))
	                    cc.Missing_Contact_Count__c=0;
                }  
	        	if(rollupCampaignMap.containsKey(cc.CRM_ParentSegmentedCampaign__c)){
	        		rollupCampaignMap.get(cc.CRM_ParentSegmentedCampaign__c).Current_count__c +=cc.Current_count__c;
	        		if(!isQuickCount){
		        		rollupCampaignMap.get(cc.CRM_ParentSegmentedCampaign__c).Supp_Count__c +=cc.Supp_Count__c;
		        		rollupCampaignMap.get(cc.CRM_ParentSegmentedCampaign__c).Missing_Contact_Count__c +=cc.Missing_Contact_Count__c;
	        		}
	        	}else{
	        		Campaign cm =new Campaign(id=cc.CRM_ParentSegmentedCampaign__c,Current_count__c=cc.Current_count__c);
	        		if(!isQuickCount){
	        			cm.Supp_Count__c=cc.Supp_Count__c;
	        			cm.Missing_Contact_Count__c=cc.Missing_Contact_Count__c;
	        		}
	        		rollupCampaignMap.put(cc.CRM_ParentSegmentedCampaign__c,cm);
	        	}
	        	
	        	if(!isQuickCount){
		        	//Control Group Count will be done on parent campaign only
		        	if(cc.CRM_ParentSegmentedCampaign__r.Control_Group_Size__c!=null)
		        		rollupCampaignMap.get(cc.CRM_ParentSegmentedCampaign__c).CG_Count__c =cc.CRM_ParentSegmentedCampaign__r.Control_Group_Size__c;
		        	else{
		        		Campaign cmp = rollupCampaignMap.get(cc.CRM_ParentSegmentedCampaign__c);
		        		cmp.CG_Count__c = Math.round(((cmp.Current_Count__c - cmp.Supp_Count__c - cmp.Missing_Contact_Count__c)*integer.valueOf(cc.CRM_ParentSegmentedCampaign__r.Control_Group_Percentage__c))/100);
		        		rollupCampaignMap.put(cc.CRM_ParentSegmentedCampaign__c,cmp);
		        	}
		        	rollupCampaignMap.get(cc.CRM_ParentSegmentedCampaign__c).Add_Member_Status__c='Calculated Net Count';
	        	}else{
	        		rollupCampaignMap.get(cc.CRM_ParentSegmentedCampaign__c).CG_Count__c =null;
	        		rollupCampaignMap.get(cc.CRM_ParentSegmentedCampaign__c).Supp_Count__c =null;
		        	rollupCampaignMap.get(cc.CRM_ParentSegmentedCampaign__c).Missing_Contact_Count__c =null;
	        	}
	        	system.debug('*****rollupCampaignMap='+rollupCampaignMap);
	        }
	        
	        if(rollupCampaignMap.size()>0){
	            update rollupCampaignMap.values();
	        }
	        
	        if(segmentCampaignId!=null && !isQuickCount)
	        {
	        	Audience_dedupeHelper.manageContactIdDeDuping(segmentCampaignId);
	        }
        }
    }
    
    //AXU get batch Job ID
    public static String rollupFinalCountDetailToSegmented2(list<Id> campId, boolean isDelete,boolean isQuickCount){
        String apexJobId = null;
    	set<id> camIds = new set<id>();
    	camIds.addAll(campId);
        set<id> parentCampaignIds = new set<id>();
        id segmentCampaignId;
        for(Campaign cmp :[select id, Member_types__c, CRM_ParentSegmentedCampaign__c  from campaign where id IN:camIds]){
        	if(cmp.CRM_ParentSegmentedCampaign__c!=null)
        		parentCampaignIds.add(cmp.CRM_ParentSegmentedCampaign__c);
        	if(string.valueOf(cmp.Member_types__c).equalsIgnoreCase('Campaign Segments')){
        		parentCampaignIds.add(cmp.id);
        		segmentCampaignId=cmp.id;
        	}
        }
        system.debug('****parentCampaignIds='+parentCampaignIds);
        if(parentCampaignIds.size()>0){
	        map<Id,Campaign> rollupCampaignMap = new map<Id,Campaign>();
	        
	        for(Campaign cc : [SELECT Id,Supp_Count__c,Current_count__c,Missing_Contact_Count__c,CRM_ParentSegmentedCampaign__r.Control_Group_Percentage__c,CRM_ParentSegmentedCampaign__r.Control_Group_Size__c,CRM_ParentSegmentedCampaign__c From Campaign where CRM_ParentSegmentedCampaign__c IN:parentCampaignIds]){
	        	//This check will make sure we only rollup campaigns which are not going to be deleted
	        	system.debug(isDelete+'=*****='+camIds.contains(cc.Id));
        		system.debug('=*****='+cc.Id);
	        	
	        	if(cc.Current_count__c==null || (isDelete && camIds.contains(cc.Id)))
                	cc.Current_count__c=0;
                if(!isQuickCount){
	                if(cc.Supp_Count__c==null || (isDelete && camIds.contains(cc.Id)))
	                    cc.Supp_Count__c=0;
	                    
	                if(cc.Missing_Contact_Count__c==null || (isDelete && camIds.contains(cc.Id)))
	                    cc.Missing_Contact_Count__c=0;
                }  
	        	if(rollupCampaignMap.containsKey(cc.CRM_ParentSegmentedCampaign__c)){
	        		rollupCampaignMap.get(cc.CRM_ParentSegmentedCampaign__c).Current_count__c +=cc.Current_count__c;
	        		if(!isQuickCount){
		        		rollupCampaignMap.get(cc.CRM_ParentSegmentedCampaign__c).Supp_Count__c +=cc.Supp_Count__c;
		        		rollupCampaignMap.get(cc.CRM_ParentSegmentedCampaign__c).Missing_Contact_Count__c +=cc.Missing_Contact_Count__c;
	        		}
	        	}else{
	        		Campaign cm =new Campaign(id=cc.CRM_ParentSegmentedCampaign__c,Current_count__c=cc.Current_count__c);
	        		if(!isQuickCount){
	        			cm.Supp_Count__c=cc.Supp_Count__c;
	        			cm.Missing_Contact_Count__c=cc.Missing_Contact_Count__c;
	        		}
	        		rollupCampaignMap.put(cc.CRM_ParentSegmentedCampaign__c,cm);
	        	}
	        	
	        	if(!isQuickCount){
		        	//Control Group Count will be done on parent campaign only
		        	if(cc.CRM_ParentSegmentedCampaign__r.Control_Group_Size__c!=null)
		        		rollupCampaignMap.get(cc.CRM_ParentSegmentedCampaign__c).CG_Count__c =cc.CRM_ParentSegmentedCampaign__r.Control_Group_Size__c;
		        	else{
		        		Campaign cmp = rollupCampaignMap.get(cc.CRM_ParentSegmentedCampaign__c);
		        		cmp.CG_Count__c = Math.round(((cmp.Current_Count__c - cmp.Supp_Count__c - cmp.Missing_Contact_Count__c)*integer.valueOf(cc.CRM_ParentSegmentedCampaign__r.Control_Group_Percentage__c))/100);
		        		rollupCampaignMap.put(cc.CRM_ParentSegmentedCampaign__c,cmp);
		        	}
		        	rollupCampaignMap.get(cc.CRM_ParentSegmentedCampaign__c).Add_Member_Status__c='Calculated Net Count';
	        	}else{
	        		rollupCampaignMap.get(cc.CRM_ParentSegmentedCampaign__c).CG_Count__c =null;
	        		rollupCampaignMap.get(cc.CRM_ParentSegmentedCampaign__c).Supp_Count__c =null;
		        	rollupCampaignMap.get(cc.CRM_ParentSegmentedCampaign__c).Missing_Contact_Count__c =null;
	        	}
	        	system.debug('*****rollupCampaignMap='+rollupCampaignMap);
	        }
	        
	        if(rollupCampaignMap.size()>0){
	            update rollupCampaignMap.values();
	        }
	        
	        if(segmentCampaignId!=null && !isQuickCount)
	        {
	        	apexJobId = Audience_dedupeHelper.manageContactIdDeDuping2(segmentCampaignId);
	        }
        }
        return apexJobId;
    }
    
    
    //AXU: added to fectch hospital name
    private static Map<String, String> getHospitalMap()
    {
        Map<String, String> hospitalMap = new Map<String, String>();
        
        List<CRM_CampaignLocationReferenceData__c> hospitals = 
        [
            SELECT
		        CRM_HospitalCode__c,
		        CRM_Hospital__c
	        FROM
	            CRM_CampaignLocationReferenceData__c
            WHERE
                RecordType.Name = 'Hospital'
            AND
                CRM_HospitalCode__c <> NULL
            AND
                CRM_IsActive__c = true
        ];
        
        for (CRM_CampaignLocationReferenceData__c hospital : hospitals)
            hospitalMap.put(hospital.CRM_HospitalCode__c, hospital.CRM_Hospital__c);
        return hospitalMap;
    }
    //AXU - END EDIT
}
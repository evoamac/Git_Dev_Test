/*
	Created By : Amit Dahiya
	Created Date : 20 Dec 2017
	Summary : This batch class is used to mark duplicate wunderman id's for segment campaign in case duplicate count is more than 10000
*/
public class Audience_dedupeBatch implements Database.Batchable<sObject>,Database.Stateful{
    public final String query;
    public campaign segmentCamp;
    public set<id> junctionIds;
    public set<string> duplicateWids;
    public string batchLastWid;
    public integer firstBatch=0;
    public integer duplicateCount=0;
    public boolean isReset;
    //public Map<String, CRM_AudienceReport__c> wdmMap = new Map<String, CRM_AudienceReport__c>();
    public Set<String> wdmIdSet;
    public Integer suppCount;
    public Integer missCount;
    //This constructor will set duplicate record checkbox
    public Audience_dedupeBatch(Campaign cmp,set<Id> auIdSet,set<string> wdIdSet){
        segmentCamp = cmp;
        junctionIds = auIdSet;
        duplicateWids = wdIdSet;
        suppCount = 0;
        missCount = 0;
        isReset=false;
        wdmIdSet = new Set<String>();
        query ='select id,CRM_Supression__c,CRM_ControlGroup__c,CRM_Missing__c,CRM_WundermanID__c,CRM_WundermanDupe__c from CRM_AudienceReport__c where CRM_AudienceUploadJunction__c IN: junctionIds AND CRM_WundermanID__c IN: duplicateWids order by CRM_WundermanID__c,createdDate asc';
    } 
    //This constructor will reset duplicate record checkbox
    public Audience_dedupeBatch(Campaign cmp,set<Id> auIdSet){
        segmentCamp = new Campaign(id=cmp.CRM_ParentSegmentedCampaign__c);
        junctionIds = auIdSet;
        isReset=true;
        query ='select id,CRM_Supression__c,CRM_ControlGroup__c,CRM_Missing__c,CRM_WundermanID__c,CRM_WundermanDupe__c from CRM_AudienceReport__c where CRM_AudienceUploadJunction__c IN: junctionIds AND CRM_WundermanDupe__c=true';
    }
    
    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC,List<sObject> audienceReportList){
        
       try{
        	if(isReset){
             //   update new Campaign(id=segmentCamp.Id, Add_Member_Status__c='Resetting');
        		//This will reset all duplicate in case user delete/unlock any child campaign
        		Audience_dedupeHelper.resetAuReportDuplicate((list<CRM_AudienceReport__c>)audienceReportList,null);
        	 system.debug('value of reset!!! in if'+isReset );
            }else{
                system.debug('value of reset!!!'+isReset );
	        	//This will update all duplicate in case user do Final Count on segment campaign
	        	
	        	/*
	        	if(firstBatch!=0)
	        		batchLastWid = (string)audienceReportList[(audienceReportList.size()-1)].get('CRM_WundermanID__c');
	        		
	        	Audience_dedupeHelper.manageDedupe(segmentCamp,(list<CRM_AudienceReport__c>)audienceReportList,batchLastWid);
	       		firstBatch +=1;
	       		duplicateCount +=audienceReportList.size();
	       		*/
	       		
	       		
	       		//BEGIN AXU EDIT - previous logic had flaw
	       		List<CRM_AudienceReport__c> dupeArList = new List<CRM_AudienceReport__c>();
	       		
	       		for (CRM_AudienceReport__c ar : (List<CRM_AudienceReport__c>)audienceReportList)
	       		{
	       		    if (!wdmIdSet.contains(ar.CRM_WundermanID__c))
	       		    {
	       		        wdmIdSet.add(ar.CRM_WundermanID__c);
	       		        //wdmMap.put(ar.CRM_WundermanID__c, ar);
	       		    }
	       		    else
	       		    {
	       		        ar.CRM_WundermanDupe__c = true;
	       		        dupeArList.add(ar);
	       		        
	       		        if (Integer.valueOf(ar.CRM_Supression__c) == 1)
	       		            suppCount++;
       		            if (Integer.valueOf(ar.CRM_Missing__c) == 1)
       		                missCount++;
	       		    }
	       		}
	       		
	       		duplicateCount += dupeArList.size();
	       		update dupeArList;
	       		
	       		segmentCamp.Current_Count__c -= dupeArList.size();
                
	       		//segmentCamp.CRM_WundermanDuplicateCount__c += dupeArList.size();
	       		//END AXU EDIT
	       		
	       		
	       		
        	}
       }catch(Exception ex){
       
       		Tenet_Exception_Handler logError = new Tenet_Exception_Handler();
            logError.creatExceptionLog(ex,null,'Audience_dedupeBatch:Execute');  
       }    
    }
   
    public void finish(Database.BatchableContext BC)
    {
        if (isReset) return;
        
        try
        {
            segmentCamp.CRM_WundermanDuplicateCount__c=duplicateCount;
        	segmentCamp.Supp_Count__c -= suppCount;
        	segmentCamp.Missing_Contact_Count__c -= missCount;
            segmentCamp.Add_Member_Status__c = 'Calculated Net Count';
            segmentCamp.CRM_WdmDedupeProcessId__c = null;
            
            //added for control group count WDM deduping
            if(segmentCamp.Control_Group_Size__c!=null)
                segmentCamp.CG_Count__c =segmentCamp.Control_Group_Size__c;
            else if (segmentCamp.Current_Count__c != null &&
                     segmentCamp.Supp_Count__c != null &&
                     segmentCamp.Missing_Contact_Count__c != null &&
                     segmentCamp.Control_Group_Percentage__c != null)
            {
                segmentCamp.CG_Count__c = Math.round(((segmentCamp.Current_Count__c - segmentCamp.Supp_Count__c - segmentCamp.Missing_Contact_Count__c)*integer.valueOf(segmentCamp.Control_Group_Percentage__c))/100);
            } 
            
        	//In case duplicate are more than 10000 this will update the count on campaign
            
        	update segmentCamp;
        
        }catch(Exception ex){
       
             Tenet_Exception_Handler logError = new Tenet_Exception_Handler();
             logError.creatExceptionLog(ex,null,'Audience_dedupeBatch:Final');
        }
    }
}
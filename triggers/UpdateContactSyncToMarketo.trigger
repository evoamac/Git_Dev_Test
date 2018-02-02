/*
Created By : Amit Dahiya
Created Date : 20 October 2016
Description: This Trigger will set the Member Type field on Campaing Member 
*/
trigger UpdateContactSyncToMarketo on CampaignMember (before insert,before update) {
    set<id> contactIdset = new set<id>(); 
    
    for(CampaignMember cm : trigger.new){
        if(cm.ContactId!=null)
             contactIdset.add(cm.ContactId);
        
    }
    map<id,contact> contactIdMap = new map<id,contact>();
    for(Contact con : [select id,Number_of_Encounters__c from Contact where Id IN: contactIdset]){
        contactIdMap.put(con.Id,con);
    }
    
    if(contactIdMap.size()>0){
        for(CampaignMember cm :trigger.new){
            if(cm.ContactId!=null){
                if(contactIdMap.containsKey(cm.ContactId)){
                    if(contactIdMap.get(cm.ContactId).Number_of_Encounters__c>0)
                        cm.Member_Type__c='Patient';
                    else
                        cm.Member_Type__c='Prospect';
                }else{
                    cm.Member_Type__c='Prospect';
                }
            }
        }
    
    }
}
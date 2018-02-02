trigger TrackFieldHistory on Campaign (after insert, before update,after update) {
    public String nameoffield{get;set;}
    
    if(trigger.isUpdate && trigger.isBefore){
        // public campaign old1{get;set;}
        list<campaign> campaign_list=new list<campaign>();
        campaign_list=trigger.new;
        List<track_history__c> historiesToInsert = new List<track_history__c>();
       //list<track_history__c> history_list=new list<track_history__c>();
       //   if(Trigger.isUpdate){
            
           
       //get all fields from compliance that we want to check for changes
       Map<String, Schema.SObjectField> allComplFieldsMap = Schema.SObjectType.campaign.fields.getMap();
            //    system.debug('statement 1===============');
       Map<String, Schema.DescribeFieldResult>  complFieldsToTrack = new Map<String, Schema.DescribeFieldResult>();
             //    system.debug('statement =2==============');
            
       for (Schema.SObjectField complField : allComplFieldsMap.values()) {
           //  system.debug('statement 3===============' + complField);
            Schema.DescribeFieldResult describeResult = complField.getDescribe();
           //  system.debug('statement 4===============');
             //choose which fields to track depending on the field type
            if (describeResult.getType() == Schema.DisplayType.Boolean ||
                describeResult.getType() == Schema.DisplayType.Combobox ||
                describeResult.getType() == Schema.DisplayType.Currency ||
                describeResult.getType() == Schema.DisplayType.Date ||
                describeResult.getType() == Schema.DisplayType.DateTime ||
                describeResult.getType() == Schema.DisplayType.Double ||
                describeResult.getType() == Schema.DisplayType.Email ||
                describeResult.getType() == Schema.DisplayType.Integer ||
                describeResult.getType() == Schema.DisplayType.MultiPicklist ||
                describeResult.getType() == Schema.DisplayType.Percent ||
                describeResult.getType() == Schema.DisplayType.Phone ||
                describeResult.getType() == Schema.DisplayType.Picklist ||
                describeResult.getType() == Schema.DisplayType.String ||
                describeResult.getType() == Schema.DisplayType.TextArea ||
                describeResult.getType() == Schema.DisplayType.Time ||
                describeResult.getType() == Schema.DisplayType.URL) 
            {
                
                if (describeResult.getName() != 'CreatedDate' &&
                    describeResult.getName() != 'LastModifiedDate' &&
                    describeResult.getName() != 'SystemModstamp' &&
                    describeResult.getName() != 'Name' &&
                    describeResult.getName() !='HierarchyNumberOfLeads' &&
                    describeResult.getName() != 'HierarchyNumberOfWonOpportunities' &&
                    describeResult.getName() != 'NumberOfLeads' &&
                    describeResult.getName() !='NumberOfConvertedLeads' &&
                    describeResult.getName() !='HierarchyNumberOfConvertedLeads' &&
                    describeResult.getName()!='NumberOfContacts' &&
                    describeResult.getName()!='NumberOfResponses' &&
                    describeResult.getName()!='NumberOfOpportunities' &&
                    describeResult.getName()!='NumberOfWonOpportunities' &&
                    describeResult.getName()!='AmountAllOpportunities' &&
                    describeResult.getName()!='AmountWonOpportunities' &&
                    describeResult.getName()!='HierarchyNumberSent' &&
                    describeResult.getName() !='HierarchyNumberOfContacts' &&
                    describeResult.getName() !='HierarchyNumberOfResponses' &&
                    describeResult.getName() !='HierarchyNumberOfOpportunities' &&
                    describeResult.getNAme() != 'HierarchyAmountWonOpportunities' &&
                    describeResult.getName() !='HierarchyAmountAllOpportunities' &&
                    describeResult.getName() !='HierarchyAmountWonOpportunities' &&
                    describeResult.isAccessible() &&
                    
                    !describeResult.isCalculated()
                    )
                {
                    complFieldsToTrack.put(describeResult.getName(), describeResult);
                }
            }
        } 
        
        for(campaign m:campaign_list)
        {
         for (Schema.DescribeFieldResult fieldDescribe : complFieldsToTrack.values()) 
          { 
             system.debug('statement 5===============' + fieldDescribe);
             nameoffield = String.valueOf(fieldDescribe.getName());
            // nameoffield = nameoffield.substring(0, nameoffield.length()-1);
              system.debug('name of the field=========='+nameoffield);
             track_history__c history=new track_history__c();
             system.debug('statement 6===============');
           
          //  for (String str : allComplFieldsMap.keyset() ) 
           // {
         //   system.debug('fields in for loop========77777'+ str);
         //   system.debug('fields in for loop========7777799999999999999999'+ old.get(str));
            if(String.valueOf(m.get(nameoffield))!=string.valueOf(trigger.oldmap.get(m.id).get(nameoffield)))
            {   
    
                  history.campaign__c= m.Id;
                  system.debug('777777777777777777777777ID'+history.campaign__c);
                
                   // history.OldValue__c=trigger.oldmap.get(m.id).service_line__c;
                 history.OldValue__c= string.valueOf(trigger.oldmap.get(m.id).get(nameoffield));
           //     history.OldValue__c=old.get(str);
                    system.debug(history.OldValue__c);
                 if(history.OldValue__c==null){
                 history.OldValue__c='Blank';
                 }
                 
                   history.NewValue__c=String.valueOf(m.get(nameoffield));
                   system.debug(history.NewValue__c);
                 history.User__c = UserInfo.getName();
                history.Date__c = System.now();
                history.FieldHistory__c = 'Field ' +fieldDescribe.getLabel()+ ' value changed from ' + history.OldValue__c +  ' to ' +  history.NewValue__c;
                   
                historiesToInsert.add(history);
                }
            }
              
        }
           
            if (!historiesToInsert.isEmpty()) {
            //remove duplicate history records
            List<track_history__c> historiesToInsertWithoutDuplicates = new List<track_history__c>();
                    Set<track_history__c> historiesSet = new Set<track_history__c>();
           historiesSet.addAll(historiesToInsert);
            historiesToInsertWithoutDuplicates.addAll(historiesSet);
    
            //insert the rest of the records
            insert historiesToInsertWithoutDuplicates;
        }
        
    }else if(trigger.isAfter){
        //create member status for campaign
        if(trigger.isInsert)
            CampaignMemberManager.createMemberStatus(trigger.newMap,true);
        
        if(trigger.isUpdate){
            map<id,Campaign> campMap = new map<id,Campaign>();
            
            for(Campaign cm : trigger.new){
                if(cm.Call_to_Action__c=='Event' && cm.Call_to_Action__c != trigger.oldMap.get(cm.id).Call_to_Action__c){
                    if(cm.Channel__c =='Inbound')
                        campMap.put(cm.id,cm);
                }   
            }
            
            if(campMap.size()>0)
                CampaignMemberManager.createMemberStatus(campMap,false);
        } 
    }   
        
   
  //  }
    
   // }

}
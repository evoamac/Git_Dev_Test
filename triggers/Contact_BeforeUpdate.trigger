trigger Contact_BeforeUpdate on Contact (before update) 
{
    for(Contact updatedContact : Trigger.new) 
    {
        if(Trigger.newmap.get(updatedContact.id).SyncToMarketo__c!=Trigger.oldmap.get(updatedContact.id).SyncToMarketo__c||
          (Trigger.newmap.get(updatedContact.id).SyncToMarketo__c==true && 
          (Trigger.newmap.get(updatedContact.id).Salutation!=Trigger.oldmap.get(updatedContact.id).Salutation ||
           Trigger.newmap.get(updatedContact.id).MailingStreet!=Trigger.oldmap.get(updatedContact.id).MailingStreet ||
           Trigger.newmap.get(updatedContact.id).MailingState!=Trigger.oldmap.get(updatedContact.id).MailingState ||
           Trigger.newmap.get(updatedContact.id).MailingPostalCode!=Trigger.oldmap.get(updatedContact.id).MailingPostalCode ||
           Trigger.newmap.get(updatedContact.id).MailingCountry!=Trigger.oldmap.get(updatedContact.id).MailingCountry ||
           Trigger.newmap.get(updatedContact.id).MailingCity!=Trigger.oldmap.get(updatedContact.id).MailingCity ||
           Trigger.newmap.get(updatedContact.id).LastName!=Trigger.oldmap.get(updatedContact.id).LastName ||
           Trigger.newmap.get(updatedContact.id).FirstName!=Trigger.oldmap.get(updatedContact.id).FirstName ||
           Trigger.newmap.get(updatedContact.id).MiddleName!=Trigger.oldmap.get(updatedContact.id).MIddleName ||
           Trigger.newmap.get(updatedContact.id).Salutation!=Trigger.oldmap.get(updatedContact.id).Salutation ||
           Trigger.newmap.get(updatedContact.id).Suffix!=Trigger.oldmap.get(updatedContact.id).Suffix ||
           Trigger.newmap.get(updatedContact.id).Phone!=Trigger.oldmap.get(updatedContact.id).Phone ||
           Trigger.newmap.get(updatedContact.id).Email!=Trigger.oldmap.get(updatedContact.id).Email||
           Trigger.newmap.get(updatedContact.id).hospitalCode__c!=Trigger.oldmap.get(updatedContact.id).hospitalCode__c ||
           Trigger.newmap.get(updatedContact.id).Resolved_Gender_Code__c!=Trigger.oldmap.get(updatedContact.id).Resolved_Gender_Code__c||
           Trigger.newmap.get(updatedContact.id).Birthdate!=Trigger.oldmap.get(updatedContact.id).Birthdate ||
           Trigger.newmap.get(updatedContact.id).Living_Well__c != Trigger.oldmap.get(updatedContact.id).Living_Well__c ||                                              //AXU added 12/12/17 - Living Well
           Trigger.newmap.get(updatedContact.id).AML_Generations_2_0__c != Trigger.oldmap.get(updatedContact.id).AML_Generations_2_0__c ||                              //AXU added 12/12/17 - Generation 2.0
           Trigger.newmap.get(updatedContact.id).Ethnicity__c != Trigger.oldmap.get(updatedContact.id).Ethnicity__c ||                                                  //AXU added 12/12/17 - Ethnicity
           Trigger.newmap.get(updatedContact.id).AML_Presence_of_Elderly_Parent__c != Trigger.oldmap.get(updatedContact.id).AML_Presence_of_Elderly_Parent__c ||        //AXU added 12/12/17 - Presence of Elderly Parent
           Trigger.newmap.get(updatedContact.id).AML_Presence_of_Children__c != Trigger.oldmap.get(updatedContact.id).AML_Presence_of_Children__c)))                    //AXU added 12/12/17 - Presence of Children
        {
           updatedContact .SyncToMarketo_LastModifiedOn__c = DateTime.now();
        }
    } 
}
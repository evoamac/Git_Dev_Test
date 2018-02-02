/*
    Created By : Amit Dahiya
    Created Date : September 1, 2016
    Objective : This class will be used to handle request and response xml for Name Match implementation
    
    Use Case for DMC Conifer Lead:
    
    1. New Contact in Wunderman and SFDC
    2. Existing COntact in Wunderman and SFDC
    3. Existing Contact in Wunderman but new Contact in SFDC
    
    Use Case for Marketo Lead:
    
    1. New Contact in Wunderman and SFDC, multiple Campaign Members to proccess for every Lead
    2. Existing COntact in Wunderman and SFDC, multiple Campaign Members to proccess for every Lead 
    3. Existing Contact in Wunderman but new Contact in SFDC, multiple Campaign Members to proccess for every Lead
*/
public class Tenet_NameMatch_XML_Utility {
    
    //This method will be used to prepare xml request for wunderman system
    public static string buildRequestXML(Lead respondentDetails){
        //Depending upong available details prepare request xml for wunderman system
        map<string,string> keyValueMap=Tenet_Static_Variables.requestKeyValueMap.get(Tenet_Static_Variables.XML_Tag_Mapping_Type_Request);
        //Request xml start tag
        String requestXML = Tenet_Static_Variables.XML_REQUEST_START_TAG+'\n';
        
        //Request xml security start tag
        requestXML += Tenet_Static_Variables.XML_REQUEST_SECURITY_START_TAG+'\n';
        
        //Request xml credentials
        requestXML += Tenet_Static_Variables.XML_REQUEST_USERNAME_START_TAG;
        if(Tenet_Static_Variables.tenetDataConfigSetting.get(Tenet_Static_Variables.XML_CUSTOM_SETTING_USERNAME_VALUE).Static_Value__c!=null)
            requestXML += Tenet_Static_Variables.tenetDataConfigSetting.get(Tenet_Static_Variables.XML_CUSTOM_SETTING_USERNAME_VALUE).Static_Value__c;
        requestXML += Tenet_Static_Variables.XML_REQUEST_USERNAME_END_TAG+'\n';
        requestXML += Tenet_Static_Variables.XML_REQUEST_ORDERID_START_TAG;
        requestXML += Tenet_Static_Variables.tenetDataConfigSetting.get(Tenet_Static_Variables.XML_CUSTOM_SETTING_ORDERID_VALUE).Static_Value__c;
        requestXML += Tenet_Static_Variables.XML_REQUEST_ORDERID_END_TAG+'\n';
        requestXML += Tenet_Static_Variables.XML_REQUEST_SECURITY_TOKEN_START_TAG;
        requestXML += Tenet_Static_Variables.tenetDataConfigSetting.get(Tenet_Static_Variables.XML_CUSTOM_SETTING_SECURITY_TOKEN_VALUE).Static_Value__c;
        requestXML += Tenet_Static_Variables.XML_REQUEST_SECURITY_TOKEN_END_TAG+'\n';
        
        //Request xml security end tag
        requestXML += Tenet_Static_Variables.XML_REQUEST_SECURITY_END_TAG+'\n';
        
        //Request xml Attirbutes start tag
        requestXML += Tenet_Static_Variables.XML_REQUEST_ATTRIBUTES_START_TAG+'\n';
        
        for(string keyValue : keyValueMap.keySet()){
            //If respondent detail is not available then we will not add request xml tag for that
            if(respondentDetails.get(keyValueMap.get(keyValue).trim())!= null){
            
                //Respondent Detail Entry start tag
                requestXML += Tenet_Static_Variables.XML_REQUEST_ENTRY_START_TAG+'\n';
                
                //Respondent Detail Key tag
                requestXML += Tenet_Static_Variables.XML_REQUEST_KEY_START_TAG;
                requestXML +=keyValue;
                requestXML += Tenet_Static_Variables.XML_REQUEST_KEY_END_TAG+'\n';
                
                //Respondent Detail Value tag
                requestXML += Tenet_Static_Variables.XML_REQUEST_VALUE_START_TAG;
                
                //In case DOB we have to set the date format acceptable by wunderman
                if(keyValue.equalsIgnoreCase(Tenet_Static_Variables.XML_REQUEST_KEY_DOB_TAG))
                    requestXML +=Date.valueOf(respondentDetails.get(keyValueMap.get(keyValue).trim())).format();
                else
                    requestXML +=respondentDetails.get(keyValueMap.get(keyValue).trim());
                    
                requestXML += Tenet_Static_Variables.XML_REQUEST_VALUE_END_TAG+'\n';
                
                //Respondent Detail Entry start tag
                requestXML += Tenet_Static_Variables.XML_REQUEST_ENTRY_END_TAG+'\n';
            }
        }
        
        //Request xml Attirbutes start tag
        requestXML += Tenet_Static_Variables.XML_REQUEST_ATTRIBUTES_END_TAG+'\n';
        
        requestXML += Tenet_Static_Variables.XML_REQUEST_MESSAGE_TYPE_START_TAG;
        requestXML += Tenet_Static_Variables.tenetDataConfigSetting.get(Tenet_Static_Variables.XML_CUSTOM_SETTING_MESSAGE_TYPE_VALUE).Static_Value__c;
        requestXML += Tenet_Static_Variables.XML_REQUEST_MESSAGE_TYPE_END_TAG+'\n';
        
        requestXML += Tenet_Static_Variables.XML_REQUEST_END_TAG;
        return requestXML ;
    }
    
    //Parse xml response
    public static void handleResponse(HttpResponse resp,Lead respondentDetails){
        //Create Transaction Record
        //Create Error Log in case there is any exception
        //Update Campaign Member Record
        //Create Contact Record in case new contact is created in Wunderman
        //Update Lead so that scheduler either won't pick it again or should pick again in case of any faliure
        map<String,String> xmlTagNameValueMap;
        //In case there is any exception during callout custom response as null will be returned
        if(resp!=null){
            Tenet_NameMatch_Sync_Helper nameMatch = new Tenet_NameMatch_Sync_Helper();
            Tenet_Exception_Handler logError = new Tenet_Exception_Handler();
            
            if(resp.getStatusCode()==200){
               //Case 1: New Contact
               //Case 2: Existing Contact
               //Case 3: error returned by wundeman
               try{
                    //Handle Valid Response
                    if(validateResponse(resp.getBody())){
                        //returned tag name and value  map parsed from response xml
                        xmlTagNameValueMap = parseResponseXML(resp.getBody());
                        boolean isNewContact=false;
                        //check if response returned contains a new contact or existing contact
                        if(xmlTagNameValueMap.get(Tenet_Static_Variables.XML_RESPONSE_NEW_CONTACT_IDENTIFIER_TAG)==Tenet_Static_Variables.XML_RESPONSE_NEW_CONTACT_IDENTIFIER_VALUE)
                            isNewContact = true;
                        
                        //fetch tag and contact api field mapping
                        //map<string,string> tagAPIFieldNameMap=Tenet_Static_Variables.requestKeyValueMap.get(Tenet_Static_Variables.XML_Tag_Mapping_Type_Response);
                        
                        respondentDetails.Wunderman_Id__c=xmlTagNameValueMap.get(Tenet_Static_Variables.XML_RESPONSE_KEY_WID_TAG);
                        handleLeadConversion(isNewContact,respondentDetails,xmlTagNameValueMap);
                        
                        /*if(!string.isBlank(respondentDetails.SourceSystem__c) && respondentDetails.SourceSystem__c.equalsIgnoreCase('Marketo'))
                            handleMarketoResponse(isNewContact,respondentDetails,xmlTagNameValueMap);
                        else
                            handleDMConiferResponse(isNewContact,respondentDetails,xmlTagNameValueMap);
                        */
                        //update lead record with wunderman id
                        
                        nameMatch.udpateRespondent(respondentDetails,false);
                        
                    //Case 3
                    }else{
                        //Response is not valid
                        logError.creatExceptionLog(resp,respondentDetails,Tenet_Static_Variables.Error_Log_Source_NameMatch);
                
                        //update lead record
                        nameMatch.udpateRespondent(respondentDetails,true);
                    }       
               }catch(Exception ex){
                    system.debug('Exception*****='+ex.getMessage());
                    logError.creatExceptionLog(ex,respondentDetails,Tenet_Static_Variables.Error_Log_Source_NameMatch);
                    
                    //update lead record
                    nameMatch.udpateRespondent(respondentDetails,true);
               }
               
            }else{
                
                logError.creatExceptionLog(resp,respondentDetails,Tenet_Static_Variables.Error_Log_Source_NameMatch);
                
                //update lead record
                nameMatch.udpateRespondent(respondentDetails,true);
            }
        }
        //Else case will happen when callout exception occur and is already handled in Tenet_NameMatch_Sync_Helper class
        
    }
    //Convert Lead
    static void handleLeadConversion(boolean isNewContact,Lead respondentDetails,map<String,String> xmlTagNameValueMap){
        Tenet_NameMatch_Sync_Helper nameMatch = new Tenet_NameMatch_Sync_Helper();
        //Case 1
        Id contactId;
        if(isNewContact){
            
            nameMatch.convertLead(contactId,respondentDetails);
        //Case 2
        }else{
            //In case Lead is already synced with Wunderman but there is a new campaign member created for a campaign
            List<Contact> existingContact= [select id,FirstName,LastName from Contact where Wunderman_Id__c=:xmlTagNameValueMap.get(Tenet_Static_Variables.XML_RESPONSE_KEY_WID_TAG) limit 1];
            //In Case Contact exists in Wunderman and SFDC
            if(existingContact.size()>0){
                contactId= existingContact[0].id;
                nameMatch.convertLead(contactId,respondentDetails);
                
            //in case Contact exists in Wunderman and not in SFDC
            }else{
                
                nameMatch.convertLead(contactId,respondentDetails);
            }
            
            //nameMatch.copyResponseToContact(newContact,respondentDetails);
        }
    }
    /*static void handleDMConiferResponse(boolean isNewContact,Lead respondentDetails,map<String,String> xmlTagNameValueMap){
        Tenet_NameMatch_Sync_Helper nameMatch = new Tenet_NameMatch_Sync_Helper();
        Contact newContact = new Contact();
        CampaignMember cMember = new CampaignMember();
        //fetch campaign id to identify the campaign member
        system.debug('*****'+respondentDetails.CampaignID__c);
        system.debug('*****'+respondentDetails.CampaignTacticName__c);
        Campaign responseForCampaign = [select id from Campaign where Name=:respondentDetails.CampaignID__c OR (Call_Center_Identifier__c=:respondentDetails.CampaignID__c AND Campaign_Toll_Free_Number__c=:respondentDetails.CampaignTacticName__c) limit 1];
        
        //every campaign can have different set of  campaign member status picklist, we need to find which mapped hasResonded to true
        CampaignMemberStatus hasResponded = [SELECT HasResponded,Id,Label FROM CampaignMemberStatus where CampaignId=:responseForCampaign.Id AND HasResponded=true];
        //Case 1
        if(isNewContact){
            
            //In case of new contact a set of field from Lead will be copied to Contact
            newContact = nameMatch.createNewContact(xmlTagNameValueMap.get(Tenet_Static_Variables.XML_RESPONSE_KEY_WID_TAG),respondentDetails);
            system.debug('*****newContact='+newContact);
            
            //Create new Campaign member
            cMember.ContactId=newContact.Id;
            cMember.CampaignId=responseForCampaign.Id;
            cMember.Status = hasResponded.Label;
            cMember.Exclude_From_Roll_Up__c = true;
            
        //Case 2
        }else{
            
            List<Contact> existingContact= [select id,FirstName,LastName from Contact where Wunderman_Id__c=:xmlTagNameValueMap.get(Tenet_Static_Variables.XML_RESPONSE_KEY_WID_TAG) limit 1];
            //In Case Contact exists in Wunderman and SFDC
            if(existingContact.size()>0){
                newContact = existingContact[0];
                system.debug(responseForCampaign.Id+'*****'+newContact);
                List<CampaignMember> cmList = [select id,HasResponded from CampaignMember where CampaignId=:responseForCampaign.Id AND ContactId=:newContact.id];
                //In case contact exist but not added as campaign member
                if(cmList.size()>0)
                    cMember=cmList[0];
                else{
                    cMember.ContactId=newContact.Id;
                    cMember.CampaignId=responseForCampaign.Id;
                    cMember.Exclude_From_Roll_Up__c = true;
                }
                //update Campaign Member
                cMember.Status = hasResponded.Label;
                                
                newContact.SyncToMarketo__c=true;
                newContact.SyncToMarketo_LastModifiedOn__c=DateTime.Now();
                update newContact;
                
                
            //in case Contact exists in Wunderman and not in SFDC
            }else{
                
                //In case of new contact a set of field from Lead will be copied to Contact
                newContact = nameMatch.createNewContact(xmlTagNameValueMap.get(Tenet_Static_Variables.XML_RESPONSE_KEY_WID_TAG),respondentDetails);
                
                //Create new Campaign member
                cMember.ContactId=newContact.Id;
                cMember.CampaignId=responseForCampaign.Id;
                cMember.Status = hasResponded.Label;
                cMember.Exclude_From_Roll_Up__c = true;
            }
            
            system.debug('*****newContact 2='+newContact);   
        }
        
        //update or create Campaign Member
        upsert cMember ;
        
        //Copy set of fields from Lead to Interaction in case Lead source is DMC/Conifer
        if(!string.isBlank(respondentDetails.SourceSystem__c) && (respondentDetails.SourceSystem__c.equalsIgnoreCase('DMC') || respondentDetails.SourceSystem__c.equalsIgnoreCase('Conifer'))){
            //create new Interaction__c record
            Interaction__c intr = new Interaction__c();
            intr.Response_By_Campaign_Member__c=newContact.id;
            intr.Response_For_Campaign__c=responseForCampaign.id;
            nameMatch.prepareInteractionRecord(intr,respondentDetails);
            insert intr;
            
        }
        
    }
    static void handleMarketoResponse(boolean isNewContact,Lead respondentDetails,map<String,String> xmlTagNameValueMap){
        Tenet_NameMatch_Sync_Helper nameMatch = new Tenet_NameMatch_Sync_Helper();
        //Contact newContact = new Contact();
        //respondentDetails.Wunderman_Id__c=xmlTagNameValueMap.get(Tenet_Static_Variables.XML_RESPONSE_KEY_WID_TAG);
        //nameMatch.udpateRespondent(respondentDetails,false,false);
        //Case 1
        Id contactId;
        if(isNewContact){
            
            //Mark the campaign member as synced from marketo
            //Delete the field exclued from count from QAT, update rollup field on campaign, update synced from marketo before deleting this
            
            nameMatch.convertMarketoLead(contactId,respondentDetails);
        //Case 2
        }else{
            //In case Lead is already synced with Wunderman but there is a new campaign member created for a campaign
            List<Contact> existingContact= [select id,FirstName,LastName from Contact where Wunderman_Id__c=:xmlTagNameValueMap.get(Tenet_Static_Variables.XML_RESPONSE_KEY_WID_TAG) limit 1];
            //In Case Contact exists in Wunderman and SFDC
            if(existingContact.size()>0){
                contactId= existingContact[0].id;
                //Copy HRA field from Lead to Contact if Lead source is Marketo
                //if(!string.isBlank(respondentDetails.SourceSystem__c) && respondentDetails.SourceSystem__c.equalsIgnoreCase('Marketo')){
                    nameMatch.convertMarketoLead(contactId,respondentDetails);
                //}
                
            //in case Contact exists in Wunderman and not in SFDC
            }else{
                
                //In case of new contact a set of field from Lead will be copied to Contact
                //newContact = nameMatch.createNewContact(xmlTagNameValueMap.get(Tenet_Static_Variables.XML_RESPONSE_KEY_WID_TAG),respondentDetails);
                nameMatch.convertMarketoLead(contactId,respondentDetails);
            }
            
            //nameMatch.copyResponseToContact(newContact,respondentDetails);
        }
    }*/
    //Handle Marketo Response
    /*static void handleMarketoResponse(boolean isNewContact,Lead respondentDetails,map<String,String> xmlTagNameValueMap){
        Tenet_NameMatch_Sync_Helper nameMatch = new Tenet_NameMatch_Sync_Helper();
        Contact newContact = new Contact();
        
        //Case 1
        if(isNewContact){
            
            //Lead Conversion process
            //convert lead to existing account
            //convert lead to new contact
            //Mark the campaign member as synced from marketo
            //Delete the field exclued from count from QAT, update rollup field on campaign, update synced from marketo before deleting this
            //copy hra data to new contact
            //
            
            //In case of new contact a set of field from Lead will be copied to Contact
            newContact = nameMatch.createNewContact(xmlTagNameValueMap.get(Tenet_Static_Variables.XML_RESPONSE_KEY_WID_TAG),respondentDetails);
            
        //Case 2
        }else{
            //In case Lead is already synced with Wunderman but there is a new campaign member created for a campaign
            List<Contact> existingContact= [select id,FirstName,LastName from Contact where Wunderman_Id__c=:xmlTagNameValueMap.get(Tenet_Static_Variables.XML_RESPONSE_KEY_WID_TAG) limit 1];
            //In Case Contact exists in Wunderman and SFDC
            if(existingContact.size()>0){
                newContact = existingContact[0];
                //Copy HRA field from Lead to Contact if Lead source is Marketo
                if(!string.isBlank(respondentDetails.SourceSystem__c) && respondentDetails.SourceSystem__c.equalsIgnoreCase('Marketo')){
                    nameMatch.copyResponseToContact(newContact,respondentDetails);
                    update newContact;
                    
                }
                
            //in case Contact exists in Wunderman and not in SFDC
            }else{
                
                //In case of new contact a set of field from Lead will be copied to Contact
                newContact = nameMatch.createNewContact(xmlTagNameValueMap.get(Tenet_Static_Variables.XML_RESPONSE_KEY_WID_TAG),respondentDetails);
            }
            
             
        }
        List<CampaignMember> leadCM=mapMarketoCampaignMember(respondentDetails.Id,newContact.Id);
        //update or create Campaign Member
        if(leadCM.size()>0)
            upsert leadCM;
    }
    */
    //*********************************************************
    // Validate Response
    //*********************************************************
    static boolean validateResponse(String responseStr){
    
        Integer i = responseStr.lastIndexOf(Tenet_Static_Variables.XML_RESPONSE_RESPONSE_CODE_START_TAG);
        i += Tenet_Static_Variables.XML_RESPONSE_RESPONSE_CODE_START_TAG.length();
        Integer j = responseStr.lastIndexOf(Tenet_Static_Variables.XML_RESPONSE_RESPONSE_CODE_END_TAG);
        String resonseCode = responseStr.substring(i,j).trim();
        System.debug('Inside Response : resonseCode ::'+resonseCode);
        boolean flag=false;
        if(integer.valueof(resonseCode)==0)
        flag=true;
        return flag;
    }
    
    //Parse XML Response
    static map<string,string> parseResponseXML(string responseXML){
        
        //read response xml
        XmlStreamReader reader = new XmlStreamReader(responseXML);
        
        //prepare a map of xml tag and value from response xml
        map<String,String> xmlTagNameValueMap = new map<String,String>();
        String localName;
        
        while (reader.hasNext()){
            //System.debug('$$$$$'+XmlTag.START_ELEMENT+'$$$ reader.getEventType(): ' + reader.getEventType());
            localName= reader.getLocalName()!=null?reader.getLocalName():localName;
            if(reader.getEventType()==XmlTag.CHARACTERS){
                if(!xmlTagNameValueMap.containsKey(localName))
                    xmlTagNameValueMap.put(localName,reader.getText());
            }
            
            reader.next();
        }
        
        return xmlTagNameValueMap;
    }
    
    //This method will map Campaign Member for Marketo Lead
    /*static List<CampaignMember> mapMarketoCampaignMember(Id respondentId,Id conId){
        
        map<Id,List<CampaignMember>> updatedCampaignMembers = new map<Id,List<CampaignMember>>();
        system.debug('******respondentId='+respondentId);
        
        for(CampaignMember cm : [select id,HasResponded,Contact_Identifier__c,CampaignId from CampaignMember where LeadId=:respondentId AND Contact_Identifier__c=null]){
            //Lead Campaign Member
            cm.Contact_Identifier__c=conId;
            
            //Contact Campaign Member
            CampaignMember cMember = new CampaignMember();
            cMember.ContactId=conId;
            cMember.CampaignId=cm.CampaignId;
            cMember.Synced_From_Marketo__c=true;
            
            if(updatedCampaignMembers.containsKey(cm.CampaignId)){
                updatedCampaignMembers.get(cm.CampaignId).add(cm);
                updatedCampaignMembers.get(cm.CampaignId).add(cMember);
            }else{
                updatedCampaignMembers.put(cm.CampaignId,new List<CampaignMember>());
                updatedCampaignMembers.get(cm.CampaignId).add(cm);
                updatedCampaignMembers.get(cm.CampaignId).add(cMember);
            }
                
        }
        for(CampaignMember cm : [select id,CampaignId,ContactId from CampaignMember where ContactId=:conId AND CampaignId IN: updatedCampaignMembers.keySet()]){
            if(updatedCampaignMembers.containsKey(cm.CampaignId)){
                Integer i=0;
                for(CampaignMember c : updatedCampaignMembers.get(cm.CampaignId)){
                    if(c.ContactId==conId)
                        updatedCampaignMembers.get(cm.CampaignId).remove(i);
                    i++;
                }
            }
        }
        List<CampaignMember> leadCM = new List<CampaignMember>();
        //every campaign can have different set of  campaign member status picklist, we need the one which is mapped to hasResonded to true
        for(CampaignMemberStatus cms :[SELECT HasResponded,Id,Label,CampaignId FROM CampaignMemberStatus where CampaignId IN: updatedCampaignMembers.keySet() AND HasResponded=true]){
                for(CampaignMember cm:updatedCampaignMembers.get(cms.CampaignId)){
                    cm.Status = cms.Label;  
                    leadCM.add(cm); 
                }
        }
        
        //system.debug('******leadCM='+leadCM);
        return leadCM;
                                    
    }
    */
}
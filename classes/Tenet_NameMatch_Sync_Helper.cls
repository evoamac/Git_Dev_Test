/*
    Created By : Amit Dahiya
    Created Date : September 1, 2016
    Objective : This class will be used to manage communication between Salesforce and Wunderman system.
*/
public class Tenet_NameMatch_Sync_Helper {
    Lead respondentDetails;
    //Transaction__c storeRequestResponse;
    
    public void syncWithVendorSystem(Lead ls){
        
        try{        
            //prepare query for lead record
            //string soqlQuery = buildQuery(Tenet_Static_Variables.requestKeyValueMap.get(Tenet_Static_Variables.XML_Tag_Mapping_Type_Request).values());
            
            //Retrive Respondent(Lead) details
            //respondentDetails = Database.query(soqlQuery);
            
            respondentDetails = ls;
            //process received response
            Tenet_NameMatch_XML_Utility.handleResponse(getResponse(),respondentDetails);
            
        }catch(Exception ex){
            //Mark lead as unprocessed so that scheduler can pick this again
            udpateRespondent(respondentDetails,true);
            
            //create error log record
            Tenet_Exception_Handler logError = new Tenet_Exception_Handler();
            logError.creatExceptionLog(ex,respondentDetails,Tenet_Static_Variables.Error_Log_Source_NameMatch);
            
        }
    }
    
    public HttpResponse getResponse(){ 
      
      Http h=new Http(); 
      string respondentId;
      if(respondentDetails!=null)
        respondentId = respondentDetails.Id;
      //Instantiate a new HTTP request,specify the method (GET) as well as the endpoint 
      HttpRequest req= new HttpRequest(); 

      try{
          req.setEndpoint(Tenet_Static_Variables.tenetDataConfigSetting.get(Tenet_Static_Variables.XML_CUSTOM_SETTING_END_POINT_VALUE).Static_Value__c); 
          req.setMethod('POST'); 
          req.setTimeout(120000);
          req.setHeader('Content-Type','application/xml');
          req.setHeader('Accept', 'application/xml');
          //string st='<submitMessageRequestObject><security><orderId>150</orderId><securityToken>5LHvVXSPRC</securityToken><username>TEST</username></security><attributes><entry><key>FIRST_NAME</key><value>BILLY</value></entry><entry><key>MID_NAME</key><value>D</value></entry><entry><key>LAST_NAME</key><value>WILLIAMS</value></entry><entry><key>SUFFIX</key><value>III</value></entry><entry><key>HONORIFIC</key><value>DR.</value></entry><entry><key>DOB</key><value>11/03/1971</value></entry><entry><key>ADDRESS</key><value>239 GRANT ST</value></entry><entry><key>CITY</key><value>PARK FOREST</value></entry><entry><key>STATE</key><value>IL</value></entry><entry><key>EMAIL</key><value>B_2_WILLIAMS@myEmailProvider.com</value></entry><entry><key>PHONE</key><value>281.777.9311</value></entry><entry><key>ZIP</key><value>60466</value></entry></attributes><messageTypeCode>IDENTIFY.CONSUMER</messageTypeCode></submitMessageRequestObject>';
          //req.setBody(st);
          req.setBody(Tenet_NameMatch_XML_Utility.buildRequestXML(respondentDetails));
          system.debug('*****='+req.getBody());
         
          //Send the request, andreturn a response 
          HttpResponse res = h.send(req); 
          //String errorMsg='<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/"><S:Body><ns2:submitMessageResponse xmlns:ns2="http://service.leads.remix.kbmg.com/"><return><responseCode>-1</responseCode><responseMsg>Operation was failed</responseMsg><transactionId>15112123</transactionId></return></ns2:submitMessageResponse></S:Body></S:Envelope>';
          //string newRecord = '<submitMessageResponseObject><responseCode>0</responseCode><transactionId>1568502965</transactionId><attributes><entry><key>NEW_PERSON_IND</key><value>1</value></entry></attributes><jobId>0</jobId><objects><entry><key>person</key><value xsi:type="ns3:person" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns3="com.kbmg.remix.api"><address1>239 GRANT ST</address1><attributes/><city>PARK FOREST</city><country>USA</country><dob>11/03/1971</dob><emailAddress>B_2_WILLIAMS@MYEMAILPROVIDER.COM</emailAddress><firstName>BILLY</firstName><id>10001</id><lastName>WILLIAMS</lastName><middleName>D</middleName><objects/><state>IL</state><suffix>III</suffix><telephone>281.777.9311</telephone></value></entry></objects></submitMessageResponseObject>';
          //HttpResponse res = new HttpResponse();
          //res.setBody(newRecord);
          //res.setStatusCode(200);
          system.debug(res.getStatusCode()+'*****='+res.getBody());
          //Create transaction
          createTransaction(req.getBody(),res.getBody(),respondentId);
          
          return res;   
      
      }catch(System.CalloutException ex){
          //Create Transaction Record
          //Create Error Log Record
          //Update Lead Record
          Tenet_Exception_Handler logError = new Tenet_Exception_Handler();
          logError.creatExceptionLog(ex,respondentDetails,Tenet_Static_Variables.Error_Log_Source_NameMatch);
          
          //Update Lead
          udpateRespondent(respondentDetails,true);
          
          //Create transaction
          createTransaction(req.getBody(),'<faultstring>'+ex+'</faultstring>',respondentId);
          
          return null;
      }
    }
    
    
    //This method is used to build dynamic query on lead
    public static string buildQuery(List<String> fieldApiNameList, String source)
    {
        string leadQuery='Select id,Wunderman_Id__c,CampaignID__c,CampaignTacticName__c,(select id from CampaignMembers),Campaign_Name__c,Fax,mkto_dateOfBirth__c,Ifs_Best_Time_to_Call__c,Ifs_Best_Way_to_Contact__c,mkto_Gender__c,SourceSystem__c,CommunicationType__c,CallType__c,EncounterDate__c,FirstName,LastName,street,Address2__c,City,State,Country,PostalCode,Phone,MobilePhone,Email,OtherPhone__c,CommunicationPreference__c,eMailOptIn__c,eMailOptInDate__c,Donotmail__c,Hospital__c,mkto_asthmaRiskCategory__c,mkto_backNeckImpairment__c,mkto_bmiCategory__c,mkto_breastCancer5Year__c,mkto_diabetesRisk__c,mkto_incontinenceSymptoms__c,mkto_InterestBariatric__c,mkto_InterestCardiology__c,mkto_InterestEmergency__c,mkto_interestObstetrics__c,mkto_interestOrthopedics__c,mkto_InterestPediatrics__c,mkto_Joint__c,mkto_JointAssessment__c,mkto_JointBMICategory__c,mkto_Lead_Role__c,mkto_lifetimeRiskCategory__c,mkto_lungScreening__c,mkto_orthoOsteoarthritisJointDisease__c,mkto_orthoPainType__c,mkto_PadRiskCategory__c,mkto_prostateRiskCategory__c,mkto_qoLImpact__c,mkto_riskCategory__c,mkto_riskCategory30Years__c,mkto_Seminar_Date__c,mkto_strokeRiskCategory__c,mkto_weightLossRec__c,mkto_weightLossSurgeryRec__c';
        for(string apiField : fieldApiNameList){
           if(!leadQuery.containsIgnoreCase(apiField))
                leadQuery += ','+apiField;
        }
        leadQuery +=' from Lead where Is_Invalid_Data__c=false AND IsConverted=false AND Sync_Issue__c=false';
        if(source.tolowercase()=='marketo') 
            leadQuery +=' AND SourceSystem__c=\'Marketo\' AND Id IN (SELECT LeadId FROM CampaignMember)';
        else
            leadQuery +=' AND Sourcesystem__c<>\'Marketo\'';
        system.debug('*****='+leadQuery);
        return leadQuery;
    }
    
    
   /* 
    //This method is used to build dynamic query on lead
    public static string buildQuery(List<String> fieldApiNameList){
        string leadQuery='Select id,Wunderman_Id__c,CampaignID__c,CampaignTacticName__c,(select id from CampaignMembers),Campaign_Name__c,Fax,mkto_dateOfBirth__c,Ifs_Best_Time_to_Call__c,Ifs_Best_Way_to_Contact__c,mkto_Gender__c,SourceSystem__c,CommunicationType__c,CallType__c,EncounterDate__c,FirstName,LastName,street,Address2__c,City,State,Country,PostalCode,Phone,MobilePhone,Email,OtherPhone__c,CommunicationPreference__c,eMailOptIn__c,eMailOptInDate__c,Donotmail__c,Hospital__c,mkto_asthmaRiskCategory__c,mkto_backNeckImpairment__c,mkto_bmiCategory__c,mkto_breastCancer5Year__c,mkto_diabetesRisk__c,mkto_incontinenceSymptoms__c,mkto_InterestBariatric__c,mkto_InterestCardiology__c,mkto_InterestEmergency__c,mkto_interestObstetrics__c,mkto_interestOrthopedics__c,mkto_InterestPediatrics__c,mkto_Joint__c,mkto_JointAssessment__c,mkto_JointBMICategory__c,mkto_Lead_Role__c,mkto_lifetimeRiskCategory__c,mkto_lungScreening__c,mkto_orthoOsteoarthritisJointDisease__c,mkto_orthoPainType__c,mkto_PadRiskCategory__c,mkto_prostateRiskCategory__c,mkto_qoLImpact__c,mkto_riskCategory__c,mkto_riskCategory30Years__c,mkto_Seminar_Date__c,mkto_strokeRiskCategory__c,mkto_weightLossRec__c,mkto_weightLossSurgeryRec__c';
        for(string apiField : fieldApiNameList){
           if(!leadQuery.containsIgnoreCase(apiField))
                leadQuery += ','+apiField;
        }
        leadQuery +=' from Lead where Is_Invalid_Data__c=false AND IsConverted=false AND Sync_Issue__c=false';
        system.debug('*****='+leadQuery);
        return leadQuery;
    }*/
    
    //Create Transaction records
    public void createTransaction(string request,string response,string respondentId){
          //Create transaction record
          Transaction__c trns = new Transaction__c(); 
          trns.Lead_SFDC_Id__c = respondentDetails.id;
          trns.Transaction_Source__c = Tenet_Static_Variables.Error_Log_Source_NameMatch;
          if(response != null){
            if(response.length()>131072)
                trns.Response_Schema__c=response.substring(0, 131070);
            else
                trns.Response_Schema__c=response;
          }
          if(request != null){
            if(request.length()>131072)
                trns.Request_Schema__c=request.substring(0, 131070);
            else
                trns.Request_Schema__c=request;
          }
          
          insert trns;
    }
    public void udpateRespondent(Lead respondentDetail,boolean isError){
        //Mark lead as unprocessed so that scheduler can pick this again
        if(respondentDetail!=null){
            respondentDetail.Sync_Issue__c=isError;
            update respondentDetail;
        }
    }
    
    //In case Lead is coming from DMC copy set of fields from Lead to Interaction record
    public void prepareInteractionRecord(Interaction__c campaignResponseDetail,Lead campaignResponse){
        //Copy set of fields from Lead to Interaction in case Lead source is DMC/Conifer
        
        campaignResponseDetail.CampaignID__c=campaignResponse.CampaignID__c;
        campaignResponseDetail.Communication_Type__c=campaignResponse.CommunicationType__c;
        campaignResponseDetail.CallType__c=campaignResponse.CallType__c;
        campaignResponseDetail.EncounterDate__c=campaignResponse.EncounterDate__c;
        campaignResponseDetail.FirstName__c=campaignResponse.FirstName;
        campaignResponseDetail.LastName__c=campaignResponse.LastName;
        campaignResponseDetail.Address1__c=campaignResponse.street;
        campaignResponseDetail.Address_2__c=campaignResponse.Address2__c;
        campaignResponseDetail.City__c=campaignResponse.City;
        campaignResponseDetail.State__c=campaignResponse.State;
        campaignResponseDetail.Country__c=campaignResponse.Country;
        campaignResponseDetail.Zip__c=campaignResponse.PostalCode;
        campaignResponseDetail.Phone__c=campaignResponse.Phone;
        campaignResponseDetail.Mobile__c=campaignResponse.MobilePhone;
        campaignResponseDetail.Email__c=campaignResponse.Email;
        campaignResponseDetail.Other_Phone__c=campaignResponse.OtherPhone__c;
        campaignResponseDetail.CommunicationPreference__c=campaignResponse.CommunicationPreference__c;
        campaignResponseDetail.eMailOptIn__c=campaignResponse.eMailOptIn__c;
        campaignResponseDetail.eMailOptInDate__c=campaignResponse.eMailOptInDate__c;
        campaignResponseDetail.Donotmail__c=campaignResponse.Donotmail__c;
        campaignResponseDetail.Hospital__c=campaignResponse.Hospital__c;
        
    }
    
    //In case Lead is coming from Marketo copy set of fields from Lead to Contact
    public void copyResponseToContact(Contact con,Lead campaignResponse){
        //Text Fields
        if(!string.isBlank(campaignResponse.mkto_asthmaRiskCategory__c))
            con.mkto2_Asthma_Risk_Category__c=campaignResponse.mkto_asthmaRiskCategory__c;
        if(!string.isBlank(campaignResponse.mkto_backNeckImpairment__c))
            con.mkto2_Back_Neck_Impairment__c=campaignResponse.mkto_backNeckImpairment__c;
        if(!string.isBlank(campaignResponse.mkto_bmiCategory__c))
            con.hra_BMI_Category__c=campaignResponse.mkto_bmiCategory__c;
        if(!string.isBlank(campaignResponse.mkto_breastCancer5Year__c))
            con.hra_Breast_Cancer_5_Year__c=campaignResponse.mkto_breastCancer5Year__c;
        if(!string.isBlank(campaignResponse.mkto_diabetesRisk__c))
            con.hra_Diabetes_Risk__c=campaignResponse.mkto_diabetesRisk__c;
        if(!string.isBlank(campaignResponse.mkto_incontinenceSymptoms__c))
            con.hra_Incontinence_Symptoms__c=campaignResponse.mkto_incontinenceSymptoms__c;
        if(!string.isBlank(campaignResponse.mkto_Joint__c))
            con.mkto2_Joint__c=campaignResponse.mkto_Joint__c;
        if(!string.isBlank(campaignResponse.mkto_JointAssessment__c))
            con.mkto2_Joint_Assessment__c=campaignResponse.mkto_JointAssessment__c;
        if(!string.isBlank(campaignResponse.mkto_JointBMICategory__c))
            con.mkto2_Joint_BMI_Category__c=campaignResponse.mkto_JointBMICategory__c;
        if(!string.isBlank(campaignResponse.mkto_Lead_Role__c))
            con.hra_Lead_Role__c=campaignResponse.mkto_Lead_Role__c;
        if(!string.isBlank(campaignResponse.mkto_lifetimeRiskCategory__c))
            con.mkto2_Lifetime_Risk_Category__c=campaignResponse.mkto_lifetimeRiskCategory__c;
        if(!string.isBlank(campaignResponse.mkto_lungScreening__c))
            con.mkto2_Lung_Screening__c=campaignResponse.mkto_lungScreening__c;
        if(!string.isBlank(campaignResponse.mkto_orthoPainType__c))
            con.mkto2_Ortho_Pain_Type__c=campaignResponse.mkto_orthoPainType__c;
        if(!string.isBlank(campaignResponse.mkto_PadRiskCategory__c))
            con.mkto2_Pad_Risk_Category__c=campaignResponse.mkto_PadRiskCategory__c;
        if(!string.isBlank(campaignResponse.mkto_prostateRiskCategory__c))
            con.mkto2_Prostate_Risk_Category__c=campaignResponse.mkto_prostateRiskCategory__c;
        if(!string.isBlank(campaignResponse.mkto_qoLImpact__c))
            con.mkto2_QoL_Impact__c=campaignResponse.mkto_qoLImpact__c;
        if(!string.isBlank(campaignResponse.mkto_riskCategory__c))
            con.mkto2_Risk_Category__c=campaignResponse.mkto_riskCategory__c;
        if(!string.isBlank(campaignResponse.mkto_riskCategory30Years__c))
            con.mkto2_Risk_Category_30_Years__c=campaignResponse.mkto_riskCategory30Years__c;
        if(!string.isBlank(campaignResponse.mkto_strokeRiskCategory__c))
            con.mkto2_Stroke_Risk_Category__c=campaignResponse.mkto_strokeRiskCategory__c;
        if(!string.isBlank(campaignResponse.mkto_weightLossRec__c))
            con.mkto2_Weight_Loss_Rec__c=campaignResponse.mkto_weightLossRec__c;
        if(!string.isBlank(campaignResponse.mkto_weightLossSurgeryRec__c))
            con.mkto2_Weight_Loss_Surgery_Rec__c=campaignResponse.mkto_weightLossSurgeryRec__c;
        if(!string.isBlank(campaignResponse.Ifs_Best_Time_to_Call__c))
            con.Ifs_Best_Time_to_Call__c=campaignResponse.Ifs_Best_Time_to_Call__c;
        if(!string.isBlank(campaignResponse.Ifs_Best_Way_to_Contact__c))
            con.Ifs_Best_Way_to_Contact__c=campaignResponse.Ifs_Best_Way_to_Contact__c;
            
        //Date type fields
        if(campaignResponse.mkto_Seminar_Date__c!=null)
            con.mkto2_Seminar_Date__c=campaignResponse.mkto_Seminar_Date__c;
        
        //Boolean Fields
        con.mkto_Ortho_Osteo_Arthritis_Joint_Disease__c=campaignResponse.mkto_orthoOsteoarthritisJointDisease__c;
        con.mkto2_Interest_Bariatric__c=campaignResponse.mkto_InterestBariatric__c;
        con.mkto2_Interest_Cardiology__c=campaignResponse.mkto_InterestCardiology__c;
        con.mkto2_Interest_Emergency__c=campaignResponse.mkto_InterestEmergency__c;
        con.mkto2_Interest_Obstetrics__c=campaignResponse.mkto_interestObstetrics__c;
        con.mkto2_Interest_Orthopedics__c=campaignResponse.mkto_interestOrthopedics__c;
        con.mkto2_Interest_Pediatrics__c=campaignResponse.mkto_InterestPediatrics__c;
        
        update con;
    }
    /*
    //This method will create a new contact if it is not existing in SFDC - Only for DMC/Conifer Leads
    public Contact createNewContact(String WundermanId,Lead campaignResponse){
        Contact newContact = new Contact();
        //In case of new contact a set of field from Lead will be copied to Contact
        newContact.Wunderman_Id__c=WundermanId;
        newContact.FirstName=campaignResponse.FirstName;
        newContact.LastName=campaignResponse.LastName;
        newContact.MiddleName=campaignResponse.MiddleName;
        newContact.Salutation=campaignResponse.Salutation;
        newContact.Suffix=campaignResponse.Suffix;
        newContact.AML_GENDER__c=campaignResponse.mkto_Gender__c;
        //if(campaignResponse.mkto_dateOfBirth__c!=null){
            //newContact.DOB__c=campaignResponse.mkto_dateOfBirth__c;
            newContact.BirthDate=campaignResponse.mkto_dateOfBirth__c;
        //}else if(campaignResponse.Date_Of_Birth__c!=null){
            //newContact.DOB__c=campaignResponse.Date_Of_Birth__c;
            //newContact.BirthDate=campaignResponse.Date_Of_Birth__c;
        //} 
        newContact.MobilePhone=campaignResponse.MobilePhone;
        newContact.Phone=campaignResponse.Phone;
        newContact.Fax=campaignResponse.Fax;
        newContact.Email=campaignResponse.Email;
        newContact.MailingStreet=campaignResponse.Street;
        newContact.MailingCity=campaignResponse.City;
        newContact.MailingState=campaignResponse.State;
        newContact.MailingCountry=campaignResponse.Country;
        newContact.MailingPostalCode=campaignResponse.PostalCode;
        newContact.SyncToMarketo_LastModifiedOn__c=DateTime.Now();
        newContact.SyncToMarketo__c=true;
        //system.debug('**********='+campaignResponse);
        //Copy HRA field from Lead to Contact if Lead source is Marketo
        //if(!string.isBlank(campaignResponse.SourceSystem__c) && campaignResponse.SourceSystem__c.equalsIgnoreCase('Marketo')){
            //copyResponseToContact(newContact,campaignResponse);
        //}
        
        insert newContact;
        
        return newContact;  
    }
    */
    public void convertLead(Id contactId,Lead respondentDetail){
        
        try{
            Id accountId=Tenet_Static_Variables.tenetDataConfigSetting.get(Tenet_Static_Variables.CONVERT_LEAD_DEFAULT_ACCOUNT_ID).Static_Value__c;
            if(contactId!=null){
                update new Contact(id=contactId,accountId=accountId);
            }
            
            Database.LeadConvert lc = new Database.LeadConvert();
            lc.setLeadId(respondentDetail.Id);
            lc.setDoNotCreateOpportunity(true);
            lc.setAccountId(accountId);
            if(contactId!=null)
                lc.setContactId(contactId);
            LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
            lc.setConvertedStatus(convertStatus.MasterLabel);
            Database.convertLead(lc);
            
            Lead ld=[select id,ConvertedContactId,ConvertedAccountId,ConvertedOpportunityId from lead where id=:respondentDetail.id];
            system.debug('*****='+ld);
            
            //update new contact(id=ld.ConvertedContactId,accountid=null);
            Contact con = [select id,BirthDate,Wunderman_Id__c,AML_GENDER__c from Contact where id=:ld.ConvertedContactId];
            
            //Custome Filed mapping for Lead - Contact conversion. 
            if(con.BirthDate==null)
                con.BirthDate=respondentDetail.mkto_dateOfBirth__c;
            if(con.Wunderman_Id__c==null)
                con.Wunderman_Id__c=respondentDetail.Wunderman_Id__c;
            if(con.AML_GENDER__c==null)
                con.AML_GENDER__c=respondentDetail.mkto_Gender__c;
            
            con.SyncToMarketo_LastModifiedOn__c=DateTime.Now();
            con.SyncToMarketo__c=true;
            con.accountid=null;
            
            if(!string.isBlank(respondentDetail.SourceSystem__c) && respondentDetail.SourceSystem__c.equalsIgnoreCase('Marketo'))
                manageMarketoCM(con,respondentDetail);
            else
                manageDMCConiferCM(con,respondentDetail);
            
        }catch(System.CalloutException ex){
              //Create Error Log Record
              //Update Lead Record
              Tenet_Exception_Handler logError = new Tenet_Exception_Handler();
              logError.creatExceptionLog(ex,respondentDetails,Tenet_Static_Variables.Error_Log_Source_NameMatch);
              
              //Update Lead
              udpateRespondent(respondentDetail,true);
         }
    }
    
    //Manage Marketo Campaign Member
    void manageMarketoCM(Contact con, Lead respondentDetail){
        
        copyResponseToContact(con,respondentDetail);
        
        //Update CampaignMember
        
        /* Start of fix : marketo lead to contact conversion process fix   */
      //  CampaignMember cm = [select id,HasResponded,campaignId from CampaignMember where LeadId=:respondentDetail.Id limit 1];
       // CampaignMemberStatus hasResponded = [SELECT HasResponded,Id,Label FROM CampaignMemberStatus where CampaignId=:cm.campaignId AND HasResponded=true];
     // starting of defect 847  
        //Update CampaignMember
        list<CampaignMember> cm = [select id,HasResponded,campaignId from CampaignMember where LeadId=:respondentDetail.Id limit 1];
        system.debug('*****cm='+cm);
        if(cm.size()>0){
           // CampaignMemberStatus hasResponded = [SELECT HasResponded,Id,Label FROM CampaignMemberStatus where CampaignId=:cm[0].campaignId AND HasResponded=true];
            
            cm[0].Synced_From_Marketo__c=true;
            //cm.Contact_Identifier__c=ld.ConvertedContactId;
           // cm[0].Status = hasResponded.Label;
           /* Ending of Fix : marketo lead to contact conversion process fix   */
            cm[0].Exclude_From_Roll_Up__c = true;
            if(!string.isBlank(respondentDetail.SourceSystem__c))
                cm[0].Source_System__c=respondentDetail.SourceSystem__c.trim().toUpperCase();
            update cm[0];
        }
        // ending of defect 847
    } 
    //Manage DMC/Conifer Campaign Member
    void manageDMCConiferCM(Contact con, Lead respondentDetail){
        
        //This update will copy fileds such as birthdate, wundermanid and gender on contact         
        update con;
        
        //Update CampaignMember
        
        //CampaignMember cm = [select id,HasResponded,campaignId from CampaignMember where LeadId=:respondentDetail.Id limit 1];
        list<Campaign> ListResponseForCampaign = [select id from Campaign where Name=:respondentDetail.CampaignID__c OR (Call_Center_Identifier__c=:respondentDetail.CampaignID__c AND Campaign_Toll_Free_Number__c=:respondentDetail.CampaignTacticName__c) limit 1];
        Campaign responseForCampaign;
        if(ListResponseForCampaign.size()>0){
        
        responseForCampaign = ListResponseForCampaign[0];
        
        //every campaign can have different set of  campaign member status picklist, we need to find which mapped hasResonded to true
        CampaignMemberStatus hasResponded = [SELECT HasResponded,Id,Label FROM CampaignMemberStatus where CampaignId=:responseForCampaign.Id AND HasResponded=true];
        
        list<CampaignMember> cmlist =[select id from CampaignMember where ContactId=:con.Id AND CampaignId=:responseForCampaign.Id];
        
        CampaignMember cm;
        if(cmlist.size()>0){
            cm = new CampaignMember(Id=cmlist[0].Id);
        }else{
            cm = new CampaignMember();
            cm.Exclude_From_Roll_Up__c = true;
            cm.ContactId=con.Id;
            cm.CampaignId=responseForCampaign.Id;
        }
        
        cm.Status = hasResponded.Label;
        if(!string.isBlank(respondentDetail.SourceSystem__c))
            cm.Source_System__c=respondentDetail.SourceSystem__c.trim().toUpperCase();
        upsert cm;
        
        system.debug('****respondentDetail'+respondentDetail);
        system.debug('****respondentDetail'+respondentDetail.SourceSystem__c);
        }
        //Copy set of fields from Lead to Interaction in case Lead source is DMC/Conifer
        if(!string.isBlank(respondentDetail.SourceSystem__c) && (respondentDetail.SourceSystem__c.equalsIgnoreCase('DMC') || respondentDetail.SourceSystem__c.equalsIgnoreCase('Conifer'))){
            //create new Interaction__c record
            Interaction__c intr = new Interaction__c();
            intr.Response_By_Campaign_Member__c=con.id;
            if(responseForCampaign!=null)
                intr.Response_For_Campaign__c=responseForCampaign.id;
            prepareInteractionRecord(intr,respondentDetail);
            
            insert intr;
            
        }
    } 
}
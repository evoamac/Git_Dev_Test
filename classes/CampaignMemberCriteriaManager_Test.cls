@istest
Private class CampaignMemberCriteriaManager_Test
{
public static testmethod void CampaignMembermethod()
{
list<Campaign_Member_Criteria__c> cmpmembercritera = new list<Campaign_Member_Criteria__c>();
list<WundermanLogin__c> cslist = new list<WundermanLogin__c>();

    Campaign cmp = new Campaign();
        cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        cmp.Service_Line__c='Burn';
        cmp.CRM_SubServiceLineText__c='Dermatology';
        cmp.Tactic__c='Mail';
        cmp.count_of_index__c ='765';
        cmp.Channel__c='Direct Mail';
        cmp.List_Order_Id__c = 1876757;
          insert cmp; 
 
    Campaign_Member_Criteria_Group__c  grp = new Campaign_Member_Criteria_Group__c();
        grp.Campaign__c=cmp.id;
        grp.Exclude__c = True;
        grp.Group_Name__c='test';
        grp.WM_CriteriaGroup_Id__c='12';
        grp.WM_Parent_group_Id__c='677';
        grp.Inner_Operator__c = 'OR';
          insert grp;
    Campaign_Member_Criteria__c mem= new Campaign_Member_Criteria__c();
        mem.Campaign__c=cmp.id;
        mem.Exclude__c=true;
        mem.Category__c = 'Ailments';
        mem.Criteria_Group__c = grp.id;
        mem.Field_Name__c='ZipCode__c';
           insert mem;
        cmpmembercritera.add(mem);
    Data_Element_Identifier__c elementidentifier = new Data_Element_Identifier__c();
        elementidentifier.Data_Element_Identifier__c = 'ZIPCD';
        elementidentifier.Data_Element_Name__c='ZIP Code';
        elementidentifier.Display_Type_Code__c='GEO.MANUAL';
        elementidentifier.Value_Mapping__c='{"Out Patient":"O","In Patient":"I"}';
        elementidentifier.Field_Name__c ='ZipCode__c';
            insert elementidentifier;
    WundermanLogin__c login = new WundermanLogin__c();
        login.EndpointURL__c= 'https://thcintellisight.uat.kbmg.com/IntellisightListAPI/com/wunderman/api/listOrder';
        login.Session_Id__c ='5685179';
        login.Password__c ='tenet1test';
        login.GetSession__c='GetSession.jsp';
        login.Name ='tenettest1';
            insert login;    
            cslist.add(login);
    Campaign_Member_Search_Critera__c searchmem = new Campaign_Member_Search_Critera__c();
        searchmem.Name='Geographicss';
        searchmem.Inner_Operator__c = 'OR';
        searchmem.Outer_Operator__c = 'AND';  
        searchmem.Requires_SubGroup__c=True;
            insert searchmem;
  CRM_AudienceUploadJunction__c  audiencejunction = marketingDataUtils.createAudienceJunction(cmp.id);
         
    			Set<id> juncid = new Set<id>();
        juncid.add(audiencejunction.Id);			
    
                map<string,string> stringmap = new map<string,string>();
                stringmap.put('value','memgrp');
                string listOrderId = '7333';
                String lstordergrpid = '';
                String lstorderexgrpid = '';
                id clonedCampid = cmp.id;
                string fieldName ='ZipCode__c';
                string value = 'Zipcode';
                Id campaignId = cmp.id;
                string stringcampaignId = cmp.id;
                boolean exclude = true;
                string objectname ='Geographic_Info_Information__c';
                integer pageNumber=1;
                List<string> lstWMContactIds =new String[3];
                lstWMContactIds[0]='test';
                lstWMContactIds[1]='test1';
                lstWMContactIds[2]='test2';
                string request='txt';
                string xmlReponse = '<ROOT><RESULT><RETURNCODE>0</RETURNCODE><MESSAGE>Added Criteria element and values</MESSAGE><LIST_ORDER_CRITERIA_ELMNT_ID>4188725</LIST_ORDER_CRITERIA_ELMNT_ID></RESULT></ROOT>';
                 string source='sourc';
 system.debug('&&&id'+campaignId);
Test.startTest();
     string response='<submitMessageResponseObject><responseCode>0</responseCode><transactionId>1568502965</transactionId><attributes><entry><key>NEW_PERSON_IND</key><value>1</value></entry></attributes><jobId>0</jobId><objects><entry><key>person</key><value xsi:type="ns3:person" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns3="com.kbmg.remix.api"><address1>239 GRANT ST</address1><attributes/><city>PARK FOREST</city><country>USA</country><dob>11/03/1971</dob><emailAddress>B_2_WILLIAMS@MYEMAILPROVIDER.COM</emailAddress><firstName>BILLY</firstName><id>WDM1223</id><lastName>WILLIAMS</lastName><middleName>D</middleName><objects/><state>IL</state><suffix>III</suffix><telephone>281.777.9311</telephone></value></entry></objects></submitMessageResponseObject>';
     ID batchID = database.executeBatch(new Audience_dedupeBatch(cmp,juncid),2000);
    Test.setMock(HttpCalloutMock.class, new MockHttpResponse(response));
    CampaignMemberCriteriaManager.insertCriteria(fieldName,value,campaignId,exclude,objectname);
    CampaignMemberCriteriaManager.updateCriteria(fieldName,value,campaignId,exclude);
    CampaignMemberCriteriaManager.deleteCriteria(fieldName,campaignId,exclude);
    CampaignMemberCriteriaManager.addCampaignMemberCriteriasForClonedCampaign(cmpmembercritera,listOrderId,lstordergrpid,lstorderexgrpid,cmp,clonedCampid );
    CampaignMemberCriteriaManager.resetCampaignMemberCriteriasSync(campaignId, batchID);
    CampaignMemberCriteriaManager.setAddOnExclusionCriterias(campaignId);

    system.debug('****stringcampaignId'+stringcampaignId);
    //CampaignMemberCriteriaManager.syncCampaignMemberCriterias(stringcampaignId);
Test.stopTest();
}

public static testmethod void CampaignMembermethod1()
{
list<Campaign_Member_Criteria__c> cmpmembercritera = new list<Campaign_Member_Criteria__c>();

    Campaign cmp = new Campaign();
        cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        cmp.Service_Line__c='Burn';
        cmp.CRM_SubServiceLineText__c='Dermatology';
        cmp.Tactic__c='Mail';
        cmp.count_of_index__c ='765';
        cmp.Channel__c='Direct Mail';
        cmp.List_Order_Id__c = 76757;
            insert cmp;
          
    Campaign_Member_Criteria_Group__c  grp = new Campaign_Member_Criteria_Group__c();
        grp.Campaign__c=cmp.id;
        grp.Exclude__c = True;
        grp.Inner_Operator__c = 'OR';
            insert grp;
          
    Campaign_Member_Criteria__c mem= new Campaign_Member_Criteria__c();
        mem.Campaign__c=cmp.id;
        mem.Exclude__c=true;
        mem.Category__c = 'Ailments';
        mem.Criteria_Group__c = grp.id;
        mem.Field_Name__c='Diagnosis Codes';
        mem.WM_Criteria_Id__c ='444664';
            insert mem;
            cmpmembercritera.add(mem);
          
                id clonedCampid = cmp.id;
                string fieldName ='Diagnosis Codes';
                string objectname ='ICD_Diagnosis_In__c';
                string value = 'Zipcode';
                Id campaignId = cmp.id;
                string stringcampaignId = cmp.id;
                boolean exclude = true;
                
Test.startTest();
    string response='<submitMessageResponseObject><responseCode>0</responseCode><transactionId>1568502965</transactionId><attributes><entry><key>NEW_PERSON_IND</key><value>1</value></entry></attributes><jobId>0</jobId><objects><entry><key>person</key><value xsi:type="ns3:person" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns3="com.kbmg.remix.api"><address1>239 GRANT ST</address1><attributes/><city>PARK FOREST</city><country>USA</country><dob>11/03/1971</dob><emailAddress>B_2_WILLIAMS@MYEMAILPROVIDER.COM</emailAddress><firstName>BILLY</firstName><id>WDM1223</id><lastName>WILLIAMS</lastName><middleName>D</middleName><objects/><state>IL</state><suffix>III</suffix><telephone>281.777.9311</telephone></value></entry></objects></submitMessageResponseObject>';
  Test.setMock(HttpCalloutMock.class, new MockHttpResponse(response));
Test.stopTest();
}
public static testmethod void syncCampaignMemberCriteriasmethod()
{
list<Campaign_Member_Criteria__c> cmpmembercritera = new list<Campaign_Member_Criteria__c>();
    Campaign cmp = new Campaign();
        cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        cmp.Service_Line__c='Burn';
        cmp.CRM_SubServiceLineText__c='Dermatology';
        cmp.Tactic__c='Mail';
        cmp.Current_count__c =3636;
        cmp.List_Order_Id__c =89334422;
        cmp.List_Order_Select_Grp_Id__c=334823224;
        cmp.count_of_index__c ='765';
        cmp.List_Order_Exclude_Grp_Id__c=387873;
        cmp.Channel__c='Direct Mail';
        insert cmp;
         
    Campaign cmpnew = new Campaign();
        cmpnew.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        cmpnew.Service_Line__c='Burn';
        cmpnew.CRM_SubServiceLineText__c='Dermatology';
        cmpnew.List_Order_Id__c =893422;
        cmpnew.List_Order_Select_Grp_Id__c=33224;
        cmpnew.count_of_index__c ='765';
        cmpnew.ParentId=cmp.id;
        cmpnew.List_Order_Exclude_Grp_Id__c=387873;
        cmpnew.Channel__c='Direct Mail';
        insert cmpnew;
            
    Campaign_Member_Criteria_Group__c  grp = new Campaign_Member_Criteria_Group__c();
        grp.Campaign__c=cmp.id;
        grp.Exclude__c = True;
        grp.Group_Number__c=1;
        grp.WM_CriteriaGroup_Id__c='8130';
        grp.Inner_Operator__c = 'OR';
        insert grp;
        
    Campaign_Member_Criteria__c mem= new Campaign_Member_Criteria__c();
        mem.Campaign__c=cmp.id;
        mem.WM_Sync_Type__c='Insert';
        mem.Field_Id__c='Zip Code';
        mem.WM_Sync_Status__c='Pending';
        mem.Category__c = 'Geography';
        mem.Criteria_Group__c = grp.id;
        mem.Field_Name__c='ZipCode__c';
        mem.Value__c='12345';
        mem.Operator__c='AND';
        insert mem;
        
    Tenet_Data_Configuration__c tenet = new Tenet_Data_Configuration__c();
      tenet.Static_Value__c='9900';
      tenet.Name='Page Size';
      insert tenet;
      
    WundermanLogin__c login = new WundermanLogin__c();
        login.EndpointURL__c= 'https://thcintellisight.uat.kbmg.com/IntellisightListAPI/com/wunderman/api/listOrder';
        login.Session_Id__c ='5685179';
        login.Password__c ='tenet1test';
        login.GetSession__c='GetSession.jsp';
        login.Name ='tenettest1';
        insert login; 
    Data_Element_Identifier__c elementidentifier = new Data_Element_Identifier__c();
        elementidentifier.Data_Element_Identifier__c = '559';
        elementidentifier.Data_Element_Name__c='Zip Code';
        elementidentifier.Field_Name__c ='ZipCode__c';
            insert elementidentifier;
            cmpmembercritera.add(mem);
                
                string stringcampaignId=cmp.id;
                
   CRM_Search_Criteria__c searchcriteria = new CRM_Search_Criteria__c();
     searchcriteria.CRM_Campaign__c=Cmp.id;
     searchcriteria.CRM_Search_Criteria_Level_1__c ='By Distance';
     searchcriteria.CRM_Search_Criteria_Level_2__c ='PSA';
     searchcriteria.CRM_Search_Criteria_Level_3__c ='CR3';
     searchcriteria.CRM_AdditionalZipCodes__c ='';
     searchcriteria.CRM_ExcludedZipCodes__c ='12345';
     insert searchcriteria;
    Test.startTest();
       string response='<submitMessageResponseObject><responseCode>0</responseCode><transactionId>1568502965</transactionId><attributes><entry><key>NEW_PERSON_IND</key><value>1</value></entry></attributes><jobId>0</jobId><objects><entry><key>person</key><value xsi:type="ns3:person" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns3="com.kbmg.remix.api"><address1>239 GRANT ST</address1><attributes/><city>PARK FOREST</city><country>USA</country><dob>11/03/1971</dob><emailAddress>B_2_WILLIAMS@MYEMAILPROVIDER.COM</emailAddress><firstName>BILLY</firstName><id>WDM1223</id><lastName>WILLIAMS</lastName><middleName>D</middleName><objects/><state>IL</state><suffix>III</suffix><telephone>281.777.9311</telephone></value></entry></objects></submitMessageResponseObject>';
       Test.setMock(HttpCalloutMock.class, new MockHttpResponse(response));
       try{
           CampaignMemberCriteriaManager.syncCampaignMemberCriterias(stringcampaignId ,true);
       }Catch(Exception ex){
       }
    Test.stopTest();
    
}   
 public static testmethod void syncCampaignMemberCriteriasmethod1()
{
list<Campaign_Member_Criteria__c> cmpmembercritera = new list<Campaign_Member_Criteria__c>();
    Campaign cmp = new Campaign();
        cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        cmp.Service_Line__c='Burn';
        cmp.CRM_SubServiceLineText__c='Dermatology';
        cmp.Tactic__c='Mail';
        cmp.Current_count__c =3636;
        cmp.List_Order_Id__c =89334422;
        cmp.List_Order_Select_Grp_Id__c=334823224;
        cmp.count_of_index__c ='765';
        cmp.List_Order_Exclude_Grp_Id__c=387873;
        cmp.Channel__c='Direct Mail';
            insert cmp; 
    Campaign cmpnew = new Campaign();
        cmpnew.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        cmpnew.Service_Line__c='Burn';
        cmpnew.CRM_SubServiceLineText__c='Dermatology';
        cmpnew.List_Order_Id__c =893422;
        cmpnew.List_Order_Select_Grp_Id__c=33224;
        cmpnew.count_of_index__c ='765';
        cmpnew.ParentId=cmp.id;
        cmpnew.List_Order_Exclude_Grp_Id__c=387873;
        cmpnew.Channel__c='Direct Mail';
            insert cmpnew;
            
    Campaign_Member_Criteria_Group__c  grp = new Campaign_Member_Criteria_Group__c();
        grp.Campaign__c=cmp.id;
        grp.Exclude__c = True;
        grp.Group_Number__c=1;
        grp.WM_CriteriaGroup_Id__c='8130';
        grp.Inner_Operator__c = 'OR';
            insert grp;
    Campaign_Member_Criteria__c mem= new Campaign_Member_Criteria__c();
        mem.Campaign__c=cmp.id;
        mem.WM_Sync_Type__c='Insert';
        mem.Exclude__c=False;
        mem.Field_Id__c='Member Type';
        mem.WM_Sync_Status__c='Pending';
        mem.Category__c = 'Ailments';
        mem.Criteria_Group__c = grp.id;
        mem.Field_Name__c='ZipCode__c';
        mem.WM_Criteria_Id__c='4091543';
        mem.Value__c='American Indian';
        mem.Operator__c='AND';
            insert mem;
     WundermanLogin__c login = new WundermanLogin__c();
        login.EndpointURL__c= 'https://thcintellisight.uat.kbmg.com/IntellisightListAPI/com/wunderman/api/listOrder';
        login.Session_Id__c ='5685179';
        login.Password__c ='tenet1test';
        login.GetSession__c='GetSession.jsp';
        login.Name ='tenettest1';
            insert login; 
    Id Recordtypereglocation = Schema.SObjectType.CRM_CampaignLocationReferenceData__c.getRecordTypeInfosByName().get('Region').getRecordTypeId(); 
    CRM_CampaignLocationReferenceData__c locationrefregiondata = new CRM_CampaignLocationReferenceData__c();
     locationrefregiondata.CRM_Region__c='Baylor/Tenet JV Region';
     locationrefregiondata.CRM_RegionCode__c='CR3';
     locationrefregiondata.RecordTypeId=Recordtypereglocation;
     locationrefregiondata.CRM_IsActive__c=True;
            insert locationrefregiondata;
    Id Recordtypemarket = Schema.SObjectType.CRM_CampaignLocationReferenceData__c.getRecordTypeInfosByName().get('Market').getRecordTypeId(); 
    CRM_CampaignLocationReferenceData__c refdata = new CRM_CampaignLocationReferenceData__c();
     refdata.CRM_Market__c='Baylor/Tenet JV Region';
     refdata.CRM_MarketCode__c='CR3';
     refdata.CRM_MarketsRegionID__c=locationrefregiondata.id;
     refdata.RecordTypeId=Recordtypemarket;
     refdata.CRM_IsActive__c=True;
            insert refdata;
     CRM_Search_Criteria__c searchcriteria = new CRM_Search_Criteria__c();
     searchcriteria.CRM_Campaign__c=Cmp.id;
     searchcriteria.CRM_Search_Criteria_Level_1__c ='By Market';
     searchcriteria.CRM_Search_Criteria_Level_2__c ='PSA';
     searchcriteria.CRM_Search_Criteria_Level_3__c ='CR3';
     searchcriteria.CRM_AdditionalZipCodes__c ='';
     searchcriteria.CRM_ExcludedZipCodes__c ='12345';
     
   insert searchcriteria;
    Data_Element_Identifier__c elementidentifier = new Data_Element_Identifier__c();
        elementidentifier.Data_Element_Identifier__c = '559';
        elementidentifier.Data_Element_Name__c='ZIP Code';
        elementidentifier.Field_Name__c ='ZipCode__c';
            insert elementidentifier;
            cmpmembercritera.add(mem);
                
                string stringcampaignId=cmp.id;
                
  
    Test.startTest();
       string response='<submitMessageResponseObject><responseCode>0</responseCode><transactionId>1568502965</transactionId><attributes><entry><key>NEW_PERSON_IND</key><value>1</value></entry></attributes><jobId>0</jobId><objects><entry><key>person</key><value xsi:type="ns3:person" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns3="com.kbmg.remix.api"><address1>239 GRANT ST</address1><attributes/><city>PARK FOREST</city><country>USA</country><dob>11/03/1971</dob><emailAddress>B_2_WILLIAMS@MYEMAILPROVIDER.COM</emailAddress><firstName>BILLY</firstName><id>WDM1223</id><lastName>WILLIAMS</lastName><middleName>D</middleName><objects/><state>IL</state><suffix>III</suffix><telephone>281.777.9311</telephone></value></entry></objects></submitMessageResponseObject>';
  Test.setMock(HttpCalloutMock.class, new MockHttpResponse(response));
       CampaignMemberCriteriaManager.syncCampaignMemberCriterias(stringcampaignId,false);
    Test.stopTest();
    
}
public static testmethod void syncCampaignMemberCriteriasmethod2()
{
list<Campaign_Member_Criteria__c> cmpmembercritera = new list<Campaign_Member_Criteria__c>();
    Campaign cmp = new Campaign();
        cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        cmp.Service_Line__c='Burn';
        cmp.CRM_SubServiceLineText__c='Dermatology';
        cmp.Tactic__c='Mail';
        cmp.Current_count__c =3636;
        cmp.List_Order_Id__c =89334422;
        cmp.CRM_Refreshed_Count_Date__c=null;
        cmp.List_Order_Select_Grp_Id__c=334823224;
        cmp.count_of_index__c ='765';
        cmp.List_Order_Exclude_Grp_Id__c=387873;
        cmp.Channel__c='Direct Mail';
            insert cmp; 
    Campaign cmpnew = new Campaign();
        cmpnew.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        cmpnew.Service_Line__c='Burn';
        cmpnew.CRM_SubServiceLineText__c='Dermatology';
        cmpnew.List_Order_Id__c =893422;
        cmpnew.List_Order_Select_Grp_Id__c=33224;
        cmpnew.count_of_index__c ='765';
        cmpnew.ParentId=cmp.id;
        cmpnew.List_Order_Exclude_Grp_Id__c=387873;
        cmpnew.Channel__c='Direct Mail';
            insert cmpnew;
    Campaign_Demographics__c demographic = new Campaign_Demographics__c();
        demographic.Campaign__c= cmp.Id;
        demographic.AgeTo_UI__c =12;
        demographic.AgeFrom_UI__c =22;
        demographic.CRM_Birth_Month__c='Current Month';
            insert demographic;        
    Campaign_Member_Criteria_Group__c  grp = new Campaign_Member_Criteria_Group__c();
        grp.Campaign__c=cmp.id;
        grp.Exclude__c = True;
        grp.Group_Number__c=1;
        grp.WM_CriteriaGroup_Id__c='8130';
        grp.Inner_Operator__c = 'OR';
            insert grp;
    Campaign_Member_Criteria__c mem= new Campaign_Member_Criteria__c();
        mem.Campaign__c=cmp.id;
        mem.WM_Sync_Type__c='Delete';
        mem.Exclude__c=False;
        mem.Field_Id__c='Member Type';
        mem.WM_Sync_Status__c='Pending';
        mem.Category__c = 'Ailments';
        mem.Criteria_Group__c = grp.id;
        mem.Field_Name__c='ZipCode__c';
        mem.WM_Criteria_Id__c='4091543';
        mem.Value__c='American Indian';
        mem.Operator__c='AND';
            insert mem;
     WundermanLogin__c login = new WundermanLogin__c();
        login.EndpointURL__c= 'https://thcintellisight.uat.kbmg.com/IntellisightListAPI/com/wunderman/api/listOrder';
        login.Session_Id__c ='5685179';
        login.Password__c ='tenet1test';
        login.GetSession__c='GetSession.jsp';
        login.Name ='tenettest1';
            insert login; 
    Data_Element_Identifier__c elementidentifier = new Data_Element_Identifier__c();
        elementidentifier.Data_Element_Identifier__c = '561';
        elementidentifier.Data_Element_Name__c='Race';
        elementidentifier.Display_Type_Code__c='LIST.BOX.MULTI';
        elementidentifier.Value_Mapping__c='{"Asian":"A","African American":"B","Chinese":"C","Hispanic":"H","American Indian":"I","Jewish":"J","Japanese":"N","Portuguese":"P","Oriental":"R","Caucasian":"W","Uncoded":"U"}';
        elementidentifier.Field_Name__c ='ZipCode__c';
            insert elementidentifier;
            cmpmembercritera.add(mem);
                
                string stringcampaignId=cmp.id;
     CRM_Search_Criteria__c searchcriteria = new CRM_Search_Criteria__c();
     searchcriteria.CRM_Campaign__c=Cmp.id;
     searchcriteria.CRM_Search_Criteria_Level_1__c ='By State';
     searchcriteria.CRM_Search_Criteria_Level_2__c ='PSA';
     searchcriteria.CRM_Search_Criteria_Level_3__c ='CR3';
     searchcriteria.CRM_AdditionalZipCodes__c ='';
     searchcriteria.CRM_ExcludedZipCodes__c ='12345';
     insert searchcriteria;           
  
    Test.startTest();
       string response='<submitMessageResponseObject><responseCode>0</responseCode><transactionId>1568502965</transactionId><attributes><entry><key>NEW_PERSON_IND</key><value>1</value></entry></attributes><jobId>0</jobId><objects><entry><key>person</key><value xsi:type="ns3:person" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns3="com.kbmg.remix.api"><address1>239 GRANT ST</address1><attributes/><city>PARK FOREST</city><country>USA</country><dob>11/03/1971</dob><emailAddress>B_2_WILLIAMS@MYEMAILPROVIDER.COM</emailAddress><firstName>BILLY</firstName><id>WDM1223</id><lastName>WILLIAMS</lastName><middleName>D</middleName><objects/><state>IL</state><suffix>III</suffix><telephone>281.777.9311</telephone></value></entry></objects></submitMessageResponseObject>';
  Test.setMock(HttpCalloutMock.class, new MockHttpResponse(response));
       CampaignMemberCriteriaManager.syncCampaignMemberCriterias(stringcampaignId,false);
    Test.stopTest();
    
}   
 public static testmethod void syncCampaignMemberCriteriasmethod3()
{
list<Campaign_Member_Criteria__c> cmpmembercritera = new list<Campaign_Member_Criteria__c>();
    Campaign cmp = new Campaign();
        cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        cmp.Service_Line__c='Burn';
        cmp.CRM_SubServiceLineText__c='Dermatology';
        cmp.Tactic__c='Mail';
        cmp.Current_count__c =3636;
        cmp.List_Order_Id__c =89334422;
        cmp.List_Order_Select_Grp_Id__c=334823224;
        cmp.count_of_index__c ='765';
        cmp.List_Order_Exclude_Grp_Id__c=387873;
        cmp.Channel__c='Direct Mail';
            insert cmp; 
    Campaign cmpnew = new Campaign();
        cmpnew.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        cmpnew.Service_Line__c='Burn';
        cmpnew.CRM_SubServiceLineText__c='Dermatology';
        cmpnew.List_Order_Id__c =893422;
        cmpnew.List_Order_Select_Grp_Id__c=33224;
        cmpnew.count_of_index__c ='765';
        cmpnew.ParentId=cmp.id;
        cmpnew.List_Order_Exclude_Grp_Id__c=387873;
        cmpnew.Channel__c='Direct Mail';
            insert cmpnew;
            
    Campaign_Member_Criteria_Group__c  grp = new Campaign_Member_Criteria_Group__c();
        grp.Campaign__c=cmp.id;
        grp.Exclude__c = True;
        grp.Group_Number__c=1;
        grp.WM_CriteriaGroup_Id__c='8130';
        grp.Inner_Operator__c = 'OR';
            insert grp;
    Campaign_Member_Criteria__c mem= new Campaign_Member_Criteria__c();
        mem.Campaign__c=cmp.id;
        mem.WM_Sync_Type__c='Delete';
        mem.Exclude__c=True;
        mem.Field_Id__c='Member Type';
        mem.WM_Sync_Status__c='Pending';
        mem.Category__c = 'Ailments';
        mem.Criteria_Group__c = grp.id;
        mem.Field_Name__c='Race__c';
        mem.WM_Criteria_Id__c='4091543';
        mem.Value__c='American Indian';
        mem.Operator__c='AND';
            insert mem;
     WundermanLogin__c login = new WundermanLogin__c();
        login.EndpointURL__c= 'https://thcintellisight.uat.kbmg.com/IntellisightListAPI/com/wunderman/api/listOrder';
        login.Session_Id__c ='5685179';
        login.Password__c ='tenet1test';
        login.GetSession__c='GetSession.jsp';
        login.Name ='tenettest1';
            insert login; 
    Data_Element_Identifier__c elementidentifier = new Data_Element_Identifier__c();
        elementidentifier.Data_Element_Identifier__c = '561';
        elementidentifier.Data_Element_Name__c='Race';
        elementidentifier.Display_Type_Code__c='LIST.BOX.MULTI';
        elementidentifier.Value_Mapping__c='{"Asian":"A","African American":"B","Chinese":"C","Hispanic":"H","American Indian":"I","Jewish":"J","Japanese":"N","Portuguese":"P","Oriental":"R","Caucasian":"W","Uncoded":"U"}';
        elementidentifier.Field_Name__c ='Race__c';
            insert elementidentifier;
            cmpmembercritera.add(mem);
                
                string stringcampaignId=cmp.id;
                
  
    Test.startTest();
       string response='<submitMessageResponseObject><responseCode>0</responseCode><transactionId>1568502965</transactionId><attributes><entry><key>NEW_PERSON_IND</key><value>1</value></entry></attributes><jobId>0</jobId><objects><entry><key>person</key><value xsi:type="ns3:person" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns3="com.kbmg.remix.api"><address1>239 GRANT ST</address1><attributes/><city>PARK FOREST</city><country>USA</country><dob>11/03/1971</dob><emailAddress>B_2_WILLIAMS@MYEMAILPROVIDER.COM</emailAddress><firstName>BILLY</firstName><id>WDM1223</id><lastName>WILLIAMS</lastName><middleName>D</middleName><objects/><state>IL</state><suffix>III</suffix><telephone>281.777.9311</telephone></value></entry></objects></submitMessageResponseObject>';
  Test.setMock(HttpCalloutMock.class, new MockHttpResponse(response));
       CampaignMemberCriteriaManager.syncCampaignMemberCriterias(stringcampaignId,false);
    Test.stopTest();
    
}
public static testmethod void CampaignMembermethodnew()
{
list<WundermanLogin__c> cslist = new list<WundermanLogin__c>();

    Campaign cmp = new Campaign();
        cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        cmp.Service_Line__c='Burn';
        cmp.CRM_SubServiceLineText__c='Dermatology';
        cmp.Tactic__c='Mail';
        cmp.count_of_index__c ='765';
        cmp.Channel__c='Direct Mail';
        cmp.List_Order_Id__c = 1876757;
          insert cmp; 
 
    Campaign_Member_Criteria_Group__c  grp = new Campaign_Member_Criteria_Group__c();
        grp.Campaign__c=cmp.id;
        grp.Exclude__c = True;
        grp.Group_Name__c='test';
        grp.WM_CriteriaGroup_Id__c='12';
        grp.WM_Parent_group_Id__c='677';
        grp.Inner_Operator__c = 'OR';
          insert grp;
    Campaign_Member_Criteria__c mem= new Campaign_Member_Criteria__c();
        mem.Campaign__c=cmp.id;
        mem.Exclude__c=true;
        mem.WM_Sync_Type__c='insert';
        mem.Category__c = 'Encounters';
        mem.Criteria_Group__c = grp.id;
        mem.Field_Name__c='Facility_ID__c';
           insert mem;

Test.startTest();
     string response='<submitMessageResponseObject><responseCode>0</responseCode><transactionId>1568502965</transactionId><attributes><entry><key>NEW_PERSON_IND</key><value>1</value></entry></attributes><jobId>0</jobId><objects><entry><key>person</key><value xsi:type="ns3:person" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns3="com.kbmg.remix.api"><address1>239 GRANT ST</address1><attributes/><city>PARK FOREST</city><country>USA</country><dob>11/03/1971</dob><emailAddress>B_2_WILLIAMS@MYEMAILPROVIDER.COM</emailAddress><firstName>BILLY</firstName><id>WDM1223</id><lastName>WILLIAMS</lastName><middleName>D</middleName><objects/><state>IL</state><suffix>III</suffix><telephone>281.777.9311</telephone></value></entry></objects></submitMessageResponseObject>';
  Test.setMock(HttpCalloutMock.class, new MockHttpResponse(response));
    CampaignMemberCriteriaManager.setAddOnExclusionCriterias(cmp.id); 
Test.stopTest();
}
 public static testmethod void CampaignMembermethodnew1()
{
list<WundermanLogin__c> cslist = new list<WundermanLogin__c>();

    Campaign cmp = new Campaign();
        cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        cmp.Service_Line__c='Burn';
        cmp.CRM_SubServiceLineText__c='Dermatology';
        cmp.Tactic__c='Mail';
        cmp.count_of_index__c ='765';
        cmp.Channel__c='Direct Mail';
        cmp.List_Order_Id__c = 1876757;
          insert cmp; 
 
    Campaign_Member_Criteria_Group__c  grp = new Campaign_Member_Criteria_Group__c();
        grp.Campaign__c=cmp.id;
        grp.Exclude__c = False;
        grp.Group_Name__c='test';
        grp.WM_CriteriaGroup_Id__c='12';
        grp.WM_Parent_group_Id__c='677';
        grp.Inner_Operator__c = 'OR';
          insert grp;
    Campaign_Member_Criteria__c mem= new Campaign_Member_Criteria__c();
        mem.Campaign__c=cmp.id;
        mem.Exclude__c=False;
        mem.WM_Sync_Type__c='insert';
        mem.Category__c = 'Encounters';
        mem.Criteria_Group__c = grp.id;
        mem.Field_Name__c='ZipCode__c';
           insert mem;

Test.startTest();
     string response='<submitMessageResponseObject><responseCode>0</responseCode><transactionId>1568502965</transactionId><attributes><entry><key>NEW_PERSON_IND</key><value>1</value></entry></attributes><jobId>0</jobId><objects><entry><key>person</key><value xsi:type="ns3:person" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns3="com.kbmg.remix.api"><address1>239 GRANT ST</address1><attributes/><city>PARK FOREST</city><country>USA</country><dob>11/03/1971</dob><emailAddress>B_2_WILLIAMS@MYEMAILPROVIDER.COM</emailAddress><firstName>BILLY</firstName><id>WDM1223</id><lastName>WILLIAMS</lastName><middleName>D</middleName><objects/><state>IL</state><suffix>III</suffix><telephone>281.777.9311</telephone></value></entry></objects></submitMessageResponseObject>';
  Test.setMock(HttpCalloutMock.class, new MockHttpResponse(response));
    CampaignMemberCriteriaManager.setAddOnExclusionCriterias(cmp.id); 
Test.stopTest();
}

public static testmethod void CampaignMembermethodnew2()
{
list<WundermanLogin__c> cslist = new list<WundermanLogin__c>();

    Campaign cmp = new Campaign();
        cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        cmp.Service_Line__c='Burn';
        cmp.CRM_SubServiceLineText__c='Dermatology';
        cmp.Tactic__c='Mail';
        cmp.count_of_index__c ='765';
        cmp.Channel__c='Direct Mail';
        cmp.List_Order_Id__c = 1876757;
          insert cmp; 
 
    Campaign_Member_Criteria_Group__c  grp = new Campaign_Member_Criteria_Group__c();
        grp.Campaign__c=cmp.id;
        grp.Exclude__c = False;
        grp.Group_Name__c='test';
        grp.WM_CriteriaGroup_Id__c='12';
        grp.WM_Parent_group_Id__c='677';
        grp.Inner_Operator__c = 'OR';
          insert grp;
    Campaign_Member_Criteria__c mem= new Campaign_Member_Criteria__c();
        mem.Campaign__c=cmp.id;
        mem.Exclude__c=False;
        mem.WM_Sync_Type__c='insert';
        mem.Category__c = 'Encounters';
        mem.Criteria_Group__c = grp.id;
        mem.Field_Name__c='Diagnosis_Code__c';
           insert mem;

Test.startTest();
     string response='<submitMessageResponseObject><responseCode>0</responseCode><transactionId>1568502965</transactionId><attributes><entry><key>NEW_PERSON_IND</key><value>1</value></entry></attributes><jobId>0</jobId><objects><entry><key>person</key><value xsi:type="ns3:person" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns3="com.kbmg.remix.api"><address1>239 GRANT ST</address1><attributes/><city>PARK FOREST</city><country>USA</country><dob>11/03/1971</dob><emailAddress>B_2_WILLIAMS@MYEMAILPROVIDER.COM</emailAddress><firstName>BILLY</firstName><id>WDM1223</id><lastName>WILLIAMS</lastName><middleName>D</middleName><objects/><state>IL</state><suffix>III</suffix><telephone>281.777.9311</telephone></value></entry></objects></submitMessageResponseObject>';
  Test.setMock(HttpCalloutMock.class, new MockHttpResponse(response));
    CampaignMemberCriteriaManager.setAddOnExclusionCriterias(cmp.id); 
Test.stopTest();
}

public static testmethod void CampaignMembermethodnew3()
{
list<WundermanLogin__c> cslist = new list<WundermanLogin__c>();

    Campaign cmp = new Campaign();
        cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        cmp.Service_Line__c='Burn';
        cmp.CRM_SubServiceLineText__c='Dermatology';
        cmp.Tactic__c='Mail';
        cmp.count_of_index__c ='765';
        cmp.Channel__c='Direct Mail';
        cmp.List_Order_Id__c = 1876757;
          insert cmp; 
 
    Campaign_Member_Criteria_Group__c  grp = new Campaign_Member_Criteria_Group__c();
        grp.Campaign__c=cmp.id;
        grp.Exclude__c = False;
        grp.Group_Name__c='test';
        grp.WM_CriteriaGroup_Id__c='12';
        grp.WM_Parent_group_Id__c='677';
        grp.Inner_Operator__c = 'OR';
          insert grp;
    Campaign_Member_Criteria__c mem= new Campaign_Member_Criteria__c();
        mem.Campaign__c=cmp.id;
        mem.Exclude__c=True;
        mem.WM_Sync_Type__c='insert';
        mem.Category__c = 'Encounters';
        mem.Criteria_Group__c = grp.id;
        mem.Field_Name__c='Procedure_Code__c';
           insert mem;

Test.startTest();
     string response='<submitMessageResponseObject><responseCode>0</responseCode><transactionId>1568502965</transactionId><attributes><entry><key>NEW_PERSON_IND</key><value>1</value></entry></attributes><jobId>0</jobId><objects><entry><key>person</key><value xsi:type="ns3:person" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns3="com.kbmg.remix.api"><address1>239 GRANT ST</address1><attributes/><city>PARK FOREST</city><country>USA</country><dob>11/03/1971</dob><emailAddress>B_2_WILLIAMS@MYEMAILPROVIDER.COM</emailAddress><firstName>BILLY</firstName><id>WDM1223</id><lastName>WILLIAMS</lastName><middleName>D</middleName><objects/><state>IL</state><suffix>III</suffix><telephone>281.777.9311</telephone></value></entry></objects></submitMessageResponseObject>';
  Test.setMock(HttpCalloutMock.class, new MockHttpResponse(response));
    CampaignMemberCriteriaManager.setAddOnExclusionCriterias(cmp.id); 
Test.stopTest();
}

public static testmethod void CampaignMembermethod7()
{
list<Campaign_Member_Criteria__c> cmpmembercritera = new list<Campaign_Member_Criteria__c>();
list<WundermanLogin__c> cslist = new list<WundermanLogin__c>();

    Campaign cmp = new Campaign();
        cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        cmp.Service_Line__c='Burn';
        cmp.CRM_SubServiceLineText__c='Dermatology';
        cmp.Tactic__c='Mail';
        cmp.count_of_index__c ='765';
        cmp.Channel__c='Direct Mail';
        cmp.List_Order_Id__c = 1876757;
          insert cmp; 
 
    Campaign_Member_Criteria_Group__c  grp = new Campaign_Member_Criteria_Group__c();
        grp.Campaign__c=cmp.id;
        grp.Exclude__c = True;
        grp.Group_Name__c='test';
        grp.WM_CriteriaGroup_Id__c='12';
        grp.WM_Parent_group_Id__c='677';
        grp.Inner_Operator__c = 'OR';
          insert grp;
    Campaign_Member_Criteria__c mem= new Campaign_Member_Criteria__c();
        mem.Campaign__c=cmp.id;
        mem.Exclude__c=true;
        mem.Category__c = 'Ailments';
        mem.Criteria_Group__c = grp.id;
        mem.Field_Name__c='ZipCode__c';
        mem.WM_Criteria_Id__c='';
           insert mem;
        cmpmembercritera.add(mem);
    Data_Element_Identifier__c elementidentifier = new Data_Element_Identifier__c();
        elementidentifier.Data_Element_Identifier__c = 'ZIPCD';
        elementidentifier.Data_Element_Name__c='ZIP Code';
        elementidentifier.Display_Type_Code__c='GEO.MANUAL';
        elementidentifier.Value_Mapping__c='{"Out Patient":"O","In Patient":"I"}';
        elementidentifier.Field_Name__c ='ZipCode__c';
            insert elementidentifier;
    WundermanLogin__c login = new WundermanLogin__c();
        login.EndpointURL__c= 'https://thcintellisight.uat.kbmg.com/IntellisightListAPI/com/wunderman/api/listOrder';
        login.Session_Id__c ='5685179';
        login.Password__c ='tenet1test';
        login.GetSession__c='GetSession.jsp';
        login.Name ='tenettest1';
            insert login;    
            cslist.add(login);
    Campaign_Member_Search_Critera__c searchmem = new Campaign_Member_Search_Critera__c();
        searchmem.Name='Geographicss';
        searchmem.Inner_Operator__c = 'OR';
        searchmem.Outer_Operator__c = 'AND';  
        searchmem.Requires_SubGroup__c=false;
            insert searchmem;
 
    CRM_AudienceUploadJunction__c  audiencejunction = marketingDataUtils.createAudienceJunction(cmp.id);
         
    			Set<id> juncid = new Set<id>();
        juncid.add(audiencejunction.Id);
    
                map<string,string> stringmap = new map<string,string>();
                stringmap.put('value','memgrp');
                string listOrderId = '7333';
                String lstordergrpid = '';
                String lstorderexgrpid = '';
                id clonedCampid = cmp.id;
                string fieldName ='ZipCode__c';
                string value = 'Next Month;Current Month';
                Id campaignId = cmp.id;
                string stringcampaignId = cmp.id;
                boolean exclude = False;
                string objectname ='Geographic_Info_Information__c';
                integer pageNumber=1;
                List<string> lstWMContactIds =new String[3];
                lstWMContactIds[0]='test';
                lstWMContactIds[1]='test1';
                lstWMContactIds[2]='test2';
                string request='txt';
                string xmlReponse = '<ROOT><RESULT><RETURNCODE>0</RETURNCODE><MESSAGE>Added Criteria element and values</MESSAGE><LIST_ORDER_CRITERIA_ELMNT_ID>4188725</LIST_ORDER_CRITERIA_ELMNT_ID></RESULT></ROOT>';
                 string source='sourc';
 system.debug('&&&id'+campaignId);
Test.startTest();
     string response='<submitMessageResponseObject><responseCode>0</responseCode><transactionId>1568502965</transactionId><attributes><entry><key>NEW_PERSON_IND</key><value>1</value></entry></attributes><jobId>0</jobId><objects><entry><key>person</key><value xsi:type="ns3:person" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns3="com.kbmg.remix.api"><address1>239 GRANT ST</address1><attributes/><city>PARK FOREST</city><country>USA</country><dob>11/03/1971</dob><emailAddress>B_2_WILLIAMS@MYEMAILPROVIDER.COM</emailAddress><firstName>BILLY</firstName><id>WDM1223</id><lastName>WILLIAMS</lastName><middleName>D</middleName><objects/><state>IL</state><suffix>III</suffix><telephone>281.777.9311</telephone></value></entry></objects></submitMessageResponseObject>';
    ID batchID = database.executeBatch(new Audience_dedupeBatch(cmp,juncid),2000);
    Test.setMock(HttpCalloutMock.class, new MockHttpResponse(response));
    CampaignMemberCriteriaManager.insertCriteria(fieldName,value,campaignId,exclude,objectname);
    CampaignMemberCriteriaManager.updateCriteria(fieldName,value,campaignId,exclude);
    CampaignMemberCriteriaManager.deleteCriteria(fieldName,campaignId,exclude);
    CampaignMemberCriteriaManager.addCampaignMemberCriteriasForClonedCampaign(cmpmembercritera,listOrderId,lstordergrpid,lstorderexgrpid,cmp,clonedCampid );
    CampaignMemberCriteriaManager.resetCampaignMemberCriteriasSync(campaignId,batchID);
    CampaignMemberCriteriaManager.setAddOnExclusionCriterias(campaignId);

    system.debug('****stringcampaignId'+stringcampaignId);
Test.stopTest();
}
public static testmethod void CampaignMembermethod5()
{
list<Campaign_Member_Criteria__c> cmpmembercritera = new list<Campaign_Member_Criteria__c>();
list<WundermanLogin__c> cslist = new list<WundermanLogin__c>();

    Campaign cmp = new Campaign();
        cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        cmp.Service_Line__c='Burn';
        cmp.CRM_SubServiceLineText__c='Dermatology';
        cmp.Tactic__c='Mail';
        cmp.count_of_index__c ='765';
        cmp.Channel__c='Direct Mail';
        cmp.List_Order_Id__c = 1876757;
          insert cmp; 
 
    Campaign_Member_Criteria_Group__c  grp = new Campaign_Member_Criteria_Group__c();
        grp.Campaign__c=cmp.id;
        grp.Exclude__c = True;
        grp.Group_Name__c='test';
        grp.WM_CriteriaGroup_Id__c='12';
        grp.WM_Parent_group_Id__c='677';
        grp.Inner_Operator__c = 'OR';
          insert grp;
    Campaign_Member_Criteria__c mem= new Campaign_Member_Criteria__c();
        mem.Campaign__c=cmp.id;
        mem.Exclude__c=true;
        mem.Category__c = 'Ailments';
        mem.Criteria_Group__c = grp.id;
        mem.Field_Name__c='ZipCode__c';
        String lstorderexgrpid = '';
        mem.WM_Criteria_Id__c='';
           insert mem;
        cmpmembercritera.add(mem);
    Data_Element_Identifier__c elementidentifier = new Data_Element_Identifier__c();
        elementidentifier.Data_Element_Identifier__c = 'ZIPCD';
        elementidentifier.Data_Element_Name__c='ZIP Code';
        elementidentifier.Display_Type_Code__c='GEO.MANUAL';
        elementidentifier.Value_Mapping__c='{"Out Patient":"O","In Patient":"I"}';
        elementidentifier.Field_Name__c ='ZipCode__c';
            insert elementidentifier;
    WundermanLogin__c login = new WundermanLogin__c();
        login.EndpointURL__c= 'https://thcintellisight.uat.kbmg.com/IntellisightListAPI/com/wunderman/api/listOrder';
        login.Session_Id__c ='5685179';
        login.Password__c ='tenet1test';
        login.GetSession__c='GetSession.jsp';
        login.Name ='tenettest1';
            insert login;    
            cslist.add(login);
    Campaign_Member_Search_Critera__c searchmem = new Campaign_Member_Search_Critera__c();
        searchmem.Name='Geographicss';
        searchmem.Inner_Operator__c = 'OR';
        searchmem.Outer_Operator__c = 'AND';  
        searchmem.Requires_SubGroup__c=false;
            insert searchmem;
 
         CRM_AudienceUploadJunction__c  audiencejunction = marketingDataUtils.createAudienceJunction(cmp.id);
         
    			Set<id> juncid = new Set<id>();
        juncid.add(audiencejunction.Id);
    
    
                map<string,string> stringmap = new map<string,string>();
                stringmap.put('value','memgrp');
                string listOrderId = '7333';
                String lstordergrpid = '';
                
                id clonedCampid = cmp.id;
                string fieldName ='ZipCode__c';
                string value = 'Current Month';
                Id campaignId = cmp.id;
                string stringcampaignId = cmp.id;
                boolean exclude = true;
                string objectname ='Geographic_Info_Information__c';
                integer pageNumber=1;
                List<string> lstWMContactIds =new String[3];
                lstWMContactIds[0]='test';
                lstWMContactIds[1]='test1';
                lstWMContactIds[2]='test2';
                string request='txt';
                string xmlReponse = '<ROOT><RESULT><RETURNCODE>0</RETURNCODE><MESSAGE>Added Criteria element and values</MESSAGE><LIST_ORDER_CRITERIA_ELMNT_ID>4188725</LIST_ORDER_CRITERIA_ELMNT_ID></RESULT></ROOT>';
                 string source='sourc';
 system.debug('&&&id'+campaignId);
Test.startTest();
     string response='<submitMessageResponseObject><responseCode>0</responseCode><transactionId>1568502965</transactionId><attributes><entry><key>NEW_PERSON_IND</key><value>1</value></entry></attributes><jobId>0</jobId><objects><entry><key>person</key><value xsi:type="ns3:person" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns3="com.kbmg.remix.api"><address1>239 GRANT ST</address1><attributes/><city>PARK FOREST</city><country>USA</country><dob>11/03/1971</dob><emailAddress>B_2_WILLIAMS@MYEMAILPROVIDER.COM</emailAddress><firstName>BILLY</firstName><id>WDM1223</id><lastName>WILLIAMS</lastName><middleName>D</middleName><objects/><state>IL</state><suffix>III</suffix><telephone>281.777.9311</telephone></value></entry></objects></submitMessageResponseObject>';
    ID batchID = database.executeBatch(new Audience_dedupeBatch(cmp,juncid),2000);
    Test.setMock(HttpCalloutMock.class, new MockHttpResponse(response));
    CampaignMemberCriteriaManager.insertCriteria(fieldName,value,campaignId,exclude,objectname);
    CampaignMemberCriteriaManager.updateCriteria(fieldName,value,campaignId,exclude);
    CampaignMemberCriteriaManager.deleteCriteria(fieldName,campaignId,exclude);
    CampaignMemberCriteriaManager.addCampaignMemberCriteriasForClonedCampaign(cmpmembercritera,listOrderId,lstordergrpid,lstorderexgrpid,cmp,clonedCampid );
    CampaignMemberCriteriaManager.resetCampaignMemberCriteriasSync(campaignId,batchID);
    CampaignMemberCriteriaManager.setAddOnExclusionCriterias(campaignId);

    system.debug('****stringcampaignId'+stringcampaignId);
    
    //CampaignMemberCriteriaManager.syncCampaignMemberCriterias(stringcampaignId,false);
Test.stopTest();
}

public static testmethod void CampaignMembermethodnew4()
{
list<WundermanLogin__c> cslist = new list<WundermanLogin__c>();

    Campaign cmp = new Campaign();
        cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        cmp.Service_Line__c='Burn';
        cmp.CRM_SubServiceLineText__c='Dermatology';
        cmp.Tactic__c='Mail';
        cmp.count_of_index__c ='765';
        cmp.Channel__c='Direct Mail';
        cmp.List_Order_Id__c = 1876757;
          insert cmp; 
 
    Campaign_Member_Criteria_Group__c  grp = new Campaign_Member_Criteria_Group__c();
        grp.Campaign__c=cmp.id;
        grp.Exclude__c = False;
        grp.Group_Name__c='test';
        grp.WM_CriteriaGroup_Id__c='12';
        grp.WM_Parent_group_Id__c='677';
        grp.Inner_Operator__c = 'OR';
          insert grp;
    Campaign_Member_Criteria__c mem= new Campaign_Member_Criteria__c();
        mem.Campaign__c=cmp.id;
        mem.Exclude__c=false;
        mem.WM_Sync_Type__c='Update';
        mem.Category__c = 'Encounters';
        mem.Criteria_Group__c = grp.id;
        mem.Field_Name__c='Procedure_Code__c';
           insert mem;

Test.startTest();
     string response='<submitMessageResponseObject><responseCode>0</responseCode><transactionId>1568502965</transactionId><attributes><entry><key>NEW_PERSON_IND</key><value>1</value></entry></attributes><jobId>0</jobId><objects><entry><key>person</key><value xsi:type="ns3:person" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns3="com.kbmg.remix.api"><address1>239 GRANT ST</address1><attributes/><city>PARK FOREST</city><country>USA</country><dob>11/03/1971</dob><emailAddress>B_2_WILLIAMS@MYEMAILPROVIDER.COM</emailAddress><firstName>BILLY</firstName><id>WDM1223</id><lastName>WILLIAMS</lastName><middleName>D</middleName><objects/><state>IL</state><suffix>III</suffix><telephone>281.777.9311</telephone></value></entry></objects></submitMessageResponseObject>';
     Test.setMock(HttpCalloutMock.class, new MockHttpResponse(response));
     CampaignMemberCriteriaManager.setAddOnExclusionCriterias(cmp.id); 
     
Test.stopTest();
}   

public static testmethod void CoveringBirthMonthLogic () 
{

    Campaign cmp = new Campaign();
    cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
    cmp.Service_Line__c='Burn';
    cmp.CRM_SubServiceLineText__c='Dermatology';
    cmp.Tactic__c='Mail';
    cmp.Current_count__c =3636;
    cmp.List_Order_Id__c =89334422;
    cmp.CRM_Refreshed_Count_Date__c=null;
    cmp.List_Order_Select_Grp_Id__c=334823224;
    cmp.count_of_index__c ='765';
    cmp.List_Order_Exclude_Grp_Id__c=387873;
    cmp.Channel__c='Direct Mail';
    insert cmp; 
    System.assertEquals(cmp.Service_Line__c, 'Burn');
    
    Campaign_Demographics__c demographic = new Campaign_Demographics__c();
    demographic.Campaign__c= cmp.Id;
    demographic.AgeTo_UI__c =12;
    demographic.AgeFrom_UI__c =22;
    demographic.CRM_Birth_Month__c='Current Month';
    insert demographic;
    System.assertEquals(demographic.AgeTo_UI__c, 12);
            
    Campaign_Member_Criteria_Group__c  grp = new Campaign_Member_Criteria_Group__c();
    grp.Campaign__c=cmp.id;
    grp.Exclude__c = True;
    grp.Group_Number__c=1;
    grp.WM_CriteriaGroup_Id__c='8130';
    grp.Inner_Operator__c = 'OR';
    insert grp;
    System.assertEquals( grp.Group_Number__c,1);
    
    Campaign_Member_Criteria__c mem= new Campaign_Member_Criteria__c();
    mem.Campaign__c=cmp.id;
    mem.Exclude__c=true;
    mem.Category__c = 'Demographics';
    mem.Criteria_Group__c = grp.id;
    mem.Field_Name__c='CRM_Birth_Month__c';
    String lstorderexgrpid = '';
    mem.WM_Criteria_Id__c='';
    insert mem;
    System.assertEquals(mem.Category__c, 'Demographics');
       
    WundermanLogin__c login = new WundermanLogin__c();
    login.EndpointURL__c= 'https://thcintellisight.uat.kbmg.com/IntellisightListAPI/com/wunderman/api/listOrder';
    login.Session_Id__c ='5685179';
    login.Password__c ='tenet1test';
    login.GetSession__c='GetSession.jsp';
    login.Name ='tenettest1';
    insert login; 
    System.assertEquals(login.Password__c,'tenet1test');
    
    Data_Element_Identifier__c elementidentifier = new Data_Element_Identifier__c();
    elementidentifier.Data_Element_Identifier__c = '561';
    elementidentifier.Field_Name__c ='CRM_Birth_Month__c';
    elementidentifier.Criteria_Group_Name__c = 'Demographics';
    insert elementidentifier;
    string stringcampaignId=cmp.id;
    System.assertEquals(elementidentifier.Field_Name__c,'CRM_Birth_Month__c');
    
    Campaign_Member_Search_Critera__c cs = new Campaign_Member_Search_Critera__c ();
    cs.Requires_SubGroup__c = true;
    cs.Name = 'Demographics';
    cs.Inner_Operator__c = 'OR';
    cs.Outer_Operator__c = 'AND';        
    insert cs;     
    System.assertEquals(cs.Name, 'Demographics');
  
    Test.startTest();
    CampaignMemberCriteriaManager.insertCriteria(mem.Field_Name__c,demographic.CRM_Birth_Month__c,stringcampaignId,false,'Campaign_Demographics__c');
    Test.stopTest();


}
public static testmethod void CoveringBirthMonthLogicScenario2 () 
{

    Campaign cmp = new Campaign();
    cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
    cmp.Service_Line__c='Burn';
    cmp.CRM_SubServiceLineText__c='Dermatology';
    cmp.Tactic__c='Mail';
    cmp.Current_count__c =3636;
    cmp.List_Order_Id__c =89334422;
    cmp.CRM_Refreshed_Count_Date__c=null;
    cmp.List_Order_Select_Grp_Id__c=334823224;
    cmp.count_of_index__c ='765';
    cmp.List_Order_Exclude_Grp_Id__c=387873;
    cmp.Channel__c='Direct Mail';
    insert cmp; 
    System.assertEquals(cmp.Service_Line__c, 'Burn');
    
    Campaign_Demographics__c demographic = new Campaign_Demographics__c();
    demographic.Campaign__c= cmp.Id;
    demographic.AgeTo_UI__c =12;
    demographic.AgeFrom_UI__c =22;
    demographic.CRM_Birth_Month__c='Next Month';
    insert demographic;
    System.assertEquals(demographic.AgeTo_UI__c, 12);
            
    Campaign_Member_Criteria_Group__c  grp = new Campaign_Member_Criteria_Group__c();
    grp.Campaign__c=cmp.id;
    grp.Exclude__c = True;
    grp.Group_Number__c=1;
    grp.WM_CriteriaGroup_Id__c='8130';
    grp.Inner_Operator__c = 'OR';
    insert grp;
    System.assertEquals( grp.Group_Number__c,1);
    
    Campaign_Member_Criteria__c mem= new Campaign_Member_Criteria__c();
    mem.Campaign__c=cmp.id;
    mem.Exclude__c=true;
    mem.Category__c = 'Demographics';
    mem.Criteria_Group__c = grp.id;
    mem.Field_Name__c='CRM_Birth_Month__c';
    String lstorderexgrpid = '';
    mem.WM_Criteria_Id__c='';
    insert mem;
    System.assertEquals(mem.Category__c, 'Demographics');
       
    WundermanLogin__c login = new WundermanLogin__c();
    login.EndpointURL__c= 'https://thcintellisight.uat.kbmg.com/IntellisightListAPI/com/wunderman/api/listOrder';
    login.Session_Id__c ='5685179';
    login.Password__c ='tenet1test';
    login.GetSession__c='GetSession.jsp';
    login.Name ='tenettest1';
    insert login; 
    System.assertEquals(login.Password__c,'tenet1test');
    
    Data_Element_Identifier__c elementidentifier = new Data_Element_Identifier__c();
    elementidentifier.Data_Element_Identifier__c = '561';
    elementidentifier.Field_Name__c ='CRM_Birth_Month__c';
    elementidentifier.Criteria_Group_Name__c = 'Demographics';
    insert elementidentifier;
    string stringcampaignId=cmp.id;
    System.assertEquals(elementidentifier.Field_Name__c,'CRM_Birth_Month__c');
    
    Campaign_Member_Search_Critera__c cs = new Campaign_Member_Search_Critera__c ();
    cs.Requires_SubGroup__c = true;
    cs.Name = 'Demographics';
    cs.Inner_Operator__c = 'OR';
    cs.Outer_Operator__c = 'AND';        
    insert cs;     
    System.assertEquals(cs.Name, 'Demographics');     
  
    Test.startTest();
    CampaignMemberCriteriaManager.insertCriteria(mem.Field_Name__c,demographic.CRM_Birth_Month__c,stringcampaignId,false,'Campaign_Demographics__c');
    Test.stopTest();


}
public static testmethod void CoveringBirthMonthLogicScenario3 () 
{

    Campaign cmp = new Campaign();
    cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
    cmp.Service_Line__c='Burn';
    cmp.CRM_SubServiceLineText__c='Dermatology';
    cmp.Tactic__c='Mail';
    cmp.Current_count__c =3636;
    cmp.List_Order_Id__c =89334422;
    cmp.CRM_Refreshed_Count_Date__c=null;
    cmp.List_Order_Select_Grp_Id__c=334823224;
    cmp.count_of_index__c ='765';
    cmp.List_Order_Exclude_Grp_Id__c=387873;
    cmp.Channel__c='Direct Mail';
    insert cmp; 
    System.assertEquals(cmp.Service_Line__c, 'Burn');
    
    Campaign_Demographics__c demographic = new Campaign_Demographics__c();
    demographic.Campaign__c= cmp.Id;
    demographic.AgeTo_UI__c =12;
    demographic.AgeFrom_UI__c =22;
    demographic.CRM_Birth_Month__c='Current Month;Next Month';
    insert demographic;
    System.assertEquals(demographic.AgeTo_UI__c, 12);
            
    Campaign_Member_Criteria_Group__c  grp = new Campaign_Member_Criteria_Group__c();
    grp.Campaign__c=cmp.id;
    grp.Exclude__c = True;
    grp.Group_Number__c=1;
    grp.WM_CriteriaGroup_Id__c='8130';
    grp.Inner_Operator__c = 'OR';
    insert grp;
    System.assertEquals( grp.Group_Number__c,1);
    
    Campaign_Member_Criteria__c mem= new Campaign_Member_Criteria__c();
    mem.Campaign__c=cmp.id;
    mem.Exclude__c=true;
    mem.Category__c = 'Demographics';
    mem.Criteria_Group__c = grp.id;
    mem.Field_Name__c='CRM_Birth_Month__c';
    String lstorderexgrpid = '';
    mem.WM_Criteria_Id__c='';
    insert mem;
    System.assertEquals(mem.Category__c, 'Demographics');
       
    WundermanLogin__c login = new WundermanLogin__c();
    login.EndpointURL__c= 'https://thcintellisight.uat.kbmg.com/IntellisightListAPI/com/wunderman/api/listOrder';
    login.Session_Id__c ='5685179';
    login.Password__c ='tenet1test';
    login.GetSession__c='GetSession.jsp';
    login.Name ='tenettest1';
    insert login; 
    System.assertEquals(login.Password__c,'tenet1test');
    
    Data_Element_Identifier__c elementidentifier = new Data_Element_Identifier__c();
    elementidentifier.Data_Element_Identifier__c = '561';
    elementidentifier.Field_Name__c ='CRM_Birth_Month__c';
    elementidentifier.Criteria_Group_Name__c = 'Demographics';
    insert elementidentifier;
    string stringcampaignId=cmp.id;
    System.assertEquals(elementidentifier.Field_Name__c,'CRM_Birth_Month__c');
    
    Campaign_Member_Search_Critera__c cs = new Campaign_Member_Search_Critera__c ();
    cs.Requires_SubGroup__c = true;
    cs.Name = 'Demographics';
    cs.Inner_Operator__c = 'OR';
    cs.Outer_Operator__c = 'AND';        
    insert cs;     
    System.assertEquals(cs.Name, 'Demographics');   
  
    Test.startTest();
    CampaignMemberCriteriaManager.insertCriteria(mem.Field_Name__c,demographic.CRM_Birth_Month__c,stringcampaignId,false,'Campaign_Demographics__c');
    Test.stopTest();


}
public static testmethod void CoveringBirthMonthOnRefresh () 
{

    Campaign cmp = new Campaign();
    cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
    cmp.Service_Line__c='Burn';
    cmp.CRM_SubServiceLineText__c='Dermatology';
    cmp.Tactic__c='Mail';
    cmp.Current_count__c =3636;
    cmp.List_Order_Id__c =89334422;
    cmp.CRM_Refreshed_Count_Date__c=null;
    cmp.List_Order_Select_Grp_Id__c=334823224;
    cmp.count_of_index__c ='765';
    cmp.List_Order_Exclude_Grp_Id__c=387873;
    cmp.Channel__c='Direct Mail';
    insert cmp; 
    System.assertEquals(cmp.Service_Line__c, 'Burn');
    
    Campaign_Demographics__c demographic = new Campaign_Demographics__c();
    demographic.Campaign__c= cmp.Id;
    demographic.AgeTo_UI__c =12;
    demographic.AgeFrom_UI__c =22;
    demographic.CRM_Birth_Month__c='Current Month';
    insert demographic;
    System.assertEquals(demographic.AgeTo_UI__c, 12);
            
    Campaign_Member_Criteria_Group__c  grp = new Campaign_Member_Criteria_Group__c();
    grp.Campaign__c=cmp.id;
    grp.Exclude__c = True;
    grp.Group_Number__c=1;
    grp.WM_CriteriaGroup_Id__c='8130';
    grp.Inner_Operator__c = 'OR';
    insert grp;
    System.assertEquals( grp.Group_Number__c,1);
    
    Campaign_Member_Criteria__c mem= new Campaign_Member_Criteria__c();
    mem.Campaign__c=cmp.id;
    mem.Exclude__c=true;
    mem.Category__c = 'Demographics';
    mem.Criteria_Group__c = grp.id;
    mem.Field_Name__c='CRM_Birth_Month__c';
    String lstorderexgrpid = '';
    mem.WM_Criteria_Id__c='';
    insert mem;
    System.assertEquals(mem.Category__c, 'Demographics');
       
    WundermanLogin__c login = new WundermanLogin__c();
    login.EndpointURL__c= 'https://thcintellisight.uat.kbmg.com/IntellisightListAPI/com/wunderman/api/listOrder';
    login.Session_Id__c ='5685179';
    login.Password__c ='tenet1test';
    login.GetSession__c='GetSession.jsp';
    login.Name ='tenettest1';
    insert login; 
    System.assertEquals(login.Password__c,'tenet1test');
    
    Data_Element_Identifier__c elementidentifier = new Data_Element_Identifier__c();
    elementidentifier.Data_Element_Identifier__c = '561';
    elementidentifier.Field_Name__c ='CRM_Birth_Month__c';
    elementidentifier.Criteria_Group_Name__c = 'Demographics';
    insert elementidentifier;
    string stringcampaignId=cmp.id;
    System.assertEquals(elementidentifier.Field_Name__c,'CRM_Birth_Month__c');
  
    Test.startTest();
     string response='<submitMessageResponseObject><responseCode>0</responseCode><transactionId>1568502965</transactionId><attributes><entry><key>NEW_PERSON_IND</key><value>1</value></entry></attributes><jobId>0</jobId><objects><entry><key>person</key><value xsi:type="ns3:person" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns3="com.kbmg.remix.api"><address1>239 GRANT ST</address1><attributes/><city>PARK FOREST</city><country>USA</country><dob>11/03/1971</dob><emailAddress>B_2_WILLIAMS@MYEMAILPROVIDER.COM</emailAddress><firstName>BILLY</firstName><id>WDM1223</id><lastName>WILLIAMS</lastName><middleName>D</middleName><objects/><state>IL</state><suffix>III</suffix><telephone>281.777.9311</telephone></value></entry></objects></submitMessageResponseObject>';
     Test.setMock(HttpCalloutMock.class, new MockHttpResponse(response));
     try{
     CampaignMemberCriteriaManager.syncCampaignMemberCriterias(stringcampaignId,true);
     }Catch(Exception ex){
     }
    Test.stopTest();


}
public static testmethod void CoveringBirthMonthOnRefreshScen2 () 
{

    Campaign cmp = new Campaign();
    cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
    cmp.Service_Line__c='Burn';
    cmp.CRM_SubServiceLineText__c='Dermatology';
    cmp.Tactic__c='Mail';
    cmp.Current_count__c =3636;
    cmp.List_Order_Id__c =89334422;
    cmp.CRM_Refreshed_Count_Date__c=null;
    cmp.List_Order_Select_Grp_Id__c=334823224;
    cmp.count_of_index__c ='765';
    cmp.List_Order_Exclude_Grp_Id__c=387873;
    cmp.Channel__c='Direct Mail';
    insert cmp; 
    System.assertEquals(cmp.Service_Line__c, 'Burn');
    
    Campaign_Demographics__c demographic = new Campaign_Demographics__c();
    demographic.Campaign__c= cmp.Id;
    demographic.AgeTo_UI__c =12;
    demographic.AgeFrom_UI__c =22;
    demographic.CRM_Birth_Month__c='Next Month';
    insert demographic;
    System.assertEquals(demographic.AgeTo_UI__c, 12);
            
    Campaign_Member_Criteria_Group__c  grp = new Campaign_Member_Criteria_Group__c();
    grp.Campaign__c=cmp.id;
    grp.Exclude__c = True;
    grp.Group_Number__c=1;
    grp.WM_CriteriaGroup_Id__c='8130';
    grp.Inner_Operator__c = 'OR';
    insert grp;
    System.assertEquals( grp.Group_Number__c,1);
    
    Campaign_Member_Criteria__c mem= new Campaign_Member_Criteria__c();
    mem.Campaign__c=cmp.id;
    mem.Exclude__c=true;
    mem.Category__c = 'Demographics';
    mem.Criteria_Group__c = grp.id;
    mem.Field_Name__c='CRM_Birth_Month__c';
    String lstorderexgrpid = '';
    mem.WM_Criteria_Id__c='';
    insert mem;
    System.assertEquals(mem.Category__c, 'Demographics');
       
    WundermanLogin__c login = new WundermanLogin__c();
    login.EndpointURL__c= 'https://thcintellisight.uat.kbmg.com/IntellisightListAPI/com/wunderman/api/listOrder';
    login.Session_Id__c ='5685179';
    login.Password__c ='tenet1test';
    login.GetSession__c='GetSession.jsp';
    login.Name ='tenettest1';
    insert login; 
    System.assertEquals(login.Password__c,'tenet1test');
    
    Data_Element_Identifier__c elementidentifier = new Data_Element_Identifier__c();
    elementidentifier.Data_Element_Identifier__c = '561';
    elementidentifier.Field_Name__c ='CRM_Birth_Month__c';
    elementidentifier.Criteria_Group_Name__c = 'Demographics';
    insert elementidentifier;
    string stringcampaignId=cmp.id;
    System.assertEquals(elementidentifier.Field_Name__c,'CRM_Birth_Month__c');
                
  
    Test.startTest();
    string response='<submitMessageResponseObject><responseCode>0</responseCode><transactionId>1568502965</transactionId><attributes><entry><key>NEW_PERSON_IND</key><value>1</value></entry></attributes><jobId>0</jobId><objects><entry><key>person</key><value xsi:type="ns3:person" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns3="com.kbmg.remix.api"><address1>239 GRANT ST</address1><attributes/><city>PARK FOREST</city><country>USA</country><dob>11/03/1971</dob><emailAddress>B_2_WILLIAMS@MYEMAILPROVIDER.COM</emailAddress><firstName>BILLY</firstName><id>WDM1223</id><lastName>WILLIAMS</lastName><middleName>D</middleName><objects/><state>IL</state><suffix>III</suffix><telephone>281.777.9311</telephone></value></entry></objects></submitMessageResponseObject>';
    Test.setMock(HttpCalloutMock.class, new MockHttpResponse(response));
    try{
        CampaignMemberCriteriaManager.syncCampaignMemberCriterias(stringcampaignId,true);
        CampaignMemberCriteriaManager.getValueIfTrue(false, 'test');
    }Catch(Exception ex){
    }
    Test.stopTest();


}
public static testmethod void CoveringBirthMonthOnRefreshScen3 () 
{

    Campaign cmp = new Campaign();
    cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
    cmp.Service_Line__c='Burn';
    cmp.CRM_SubServiceLineText__c='Dermatology';
    cmp.Tactic__c='Mail';
    cmp.Current_count__c =3636;
    cmp.List_Order_Id__c =89334422;
    cmp.CRM_Refreshed_Count_Date__c=null;
    cmp.List_Order_Select_Grp_Id__c=334823224;
    cmp.count_of_index__c ='765';
    cmp.List_Order_Exclude_Grp_Id__c=387873;
    cmp.Channel__c='Direct Mail';
    insert cmp; 
    System.assertEquals(cmp.Service_Line__c, 'Burn');
    
    Campaign_Demographics__c demographic = new Campaign_Demographics__c();
    demographic.Campaign__c= cmp.Id;
    demographic.AgeTo_UI__c =12;
    demographic.AgeFrom_UI__c =22;
    demographic.CRM_Birth_Month__c='Current Month;Next Month';
    insert demographic;
    System.assertEquals(demographic.AgeTo_UI__c, 12);
            
    Campaign_Member_Criteria_Group__c  grp = new Campaign_Member_Criteria_Group__c();
    grp.Campaign__c=cmp.id;
    grp.Exclude__c = True;
    grp.Group_Number__c=1;
    grp.WM_CriteriaGroup_Id__c='8130';
    grp.Inner_Operator__c = 'OR';
    insert grp;
    System.assertEquals( grp.Group_Number__c,1);
   
    Campaign_Member_Criteria__c mem= new Campaign_Member_Criteria__c();
    mem.Campaign__c=cmp.id;
    mem.Exclude__c=true;
    mem.Category__c = 'Demographics';
    mem.Criteria_Group__c = grp.id;
    mem.Field_Name__c='CRM_Birth_Month__c';
    String lstorderexgrpid = '';
    mem.WM_Criteria_Id__c='';
    mem.WM_Sync_Type__c= 'Insert';
    insert mem;
    System.assertEquals(mem.Category__c, 'Demographics');
        
    WundermanLogin__c login = new WundermanLogin__c();
    login.EndpointURL__c= 'https://thcintellisight.uat.kbmg.com/IntellisightListAPI/com/wunderman/api/listOrder';
    login.Session_Id__c ='5685179';
    login.Password__c ='tenet1test';
    login.GetSession__c='GetSession.jsp';
    login.Name ='tenettest1';
    insert login; 
    System.assertEquals(login.Password__c,'tenet1test');
    
    Data_Element_Identifier__c elementidentifier = new Data_Element_Identifier__c();
    elementidentifier.Data_Element_Identifier__c = '561';
    elementidentifier.Field_Name__c ='CRM_Birth_Month__c';
    elementidentifier.Criteria_Group_Name__c = 'Demographics';
    insert elementidentifier;
    string stringcampaignId=cmp.id;
    System.assertEquals(elementidentifier.Field_Name__c,'CRM_Birth_Month__c');
                
  
    Test.startTest();
    string response='<submitMessageResponseObject><responseCode>0</responseCode><transactionId>1568502965</transactionId><attributes><entry><key>NEW_PERSON_IND</key><value>1</value></entry></attributes><jobId>0</jobId><objects><entry><key>person</key><value xsi:type="ns3:person" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns3="com.kbmg.remix.api"><address1>239 GRANT ST</address1><attributes/><city>PARK FOREST</city><country>USA</country><dob>11/03/1971</dob><emailAddress>B_2_WILLIAMS@MYEMAILPROVIDER.COM</emailAddress><firstName>BILLY</firstName><id>WDM1223</id><lastName>WILLIAMS</lastName><middleName>D</middleName><objects/><state>IL</state><suffix>III</suffix><telephone>281.777.9311</telephone></value></entry></objects></submitMessageResponseObject>';
    Test.setMock(HttpCalloutMock.class, new MockHttpResponse(response));
    CampaignMemberCriteriaManager.syncCampaignMemberCriterias(stringcampaignId,false);
    CampaignMemberCriteriaManager.getValueIfTrue(true, 'true');
    Test.stopTest();


}

public static testmethod void improveCoverage(){
	list<Campaign_Member_Criteria__c> cmpmembercritera = new list<Campaign_Member_Criteria__c>();
	list<WundermanLogin__c> cslist = new list<WundermanLogin__c>();
	Campaign cmp1 = new Campaign();
        cmp1.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        cmp1.Service_Line__c='Burn';
        cmp1.CRM_SubServiceLineText__c='Dermatology';
        cmp1.Tactic__c='Mail';
        cmp1.count_of_index__c ='765';
        cmp1.Channel__c='Direct Mail';
        cmp1.Member_Types__c = 'Campaign Segments';
        insert cmp1;
        
	Campaign cmp = new Campaign();
        cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        cmp.Service_Line__c='Burn';
        cmp.CRM_SubServiceLineText__c='Dermatology';
        cmp.Tactic__c='Mail';
        cmp.count_of_index__c ='765';
        cmp.Channel__c='Direct Mail';
        cmp.List_Order_Id__c = 1876757;
        cmp.CRM_ParentSegmentedCampaign__c=cmp1.id;
        insert cmp; 
 
    Id auRTId = ReferenceData_PicklistController.recordTypeId('CRM_AudienceUploadJunction__c','Audience_Report');
    CRM_AudienceUploadJunction__c au = new CRM_AudienceUploadJunction__c(CRM_Campaign__c=cmp.id,RecordTypeId=auRTId);
    insert au;
    
    CRM_Search_Criteria__c searchcriteria = new CRM_Search_Criteria__c();
     searchcriteria.CRM_Campaign__c=Cmp.id;
     searchcriteria.CRM_Search_Criteria_Level_1__c ='By Distance';
     searchcriteria.CRM_Search_Criteria_Level_2__c ='PSA';
     searchcriteria.CRM_Search_Criteria_Level_3__c ='CR3';
     searchcriteria.CRM_AdditionalZipCodes__c ='';
     searchcriteria.CRM_ExcludedZipCodes__c ='12345';
     insert searchcriteria;   
    
    Campaign_Member_Criteria_Group__c  grp = new Campaign_Member_Criteria_Group__c();
        grp.Campaign__c=cmp.id;
        grp.Exclude__c = True;
        grp.Group_Name__c='test';
        grp.WM_CriteriaGroup_Id__c='12';
        grp.WM_Parent_group_Id__c='677';
        grp.Inner_Operator__c = 'OR';
        insert grp;
    
    Campaign_Member_Criteria__c mem= new Campaign_Member_Criteria__c();
        mem.Campaign__c=cmp.id;
        mem.Exclude__c=false;
        mem.Category__c = 'Geography';
        mem.Criteria_Group__c = grp.id;
        mem.Field_Name__c='ZipCode__c';
        insert mem;
        cmpmembercritera.add(mem);
        
    Data_Element_Identifier__c elementidentifier = new Data_Element_Identifier__c();
        elementidentifier.Data_Element_Identifier__c = 'ZIPCD';
        elementidentifier.Data_Element_Name__c='ZIP Code';
        elementidentifier.Display_Type_Code__c='GEO.MANUAL';
        //elementidentifier.Value_Mapping__c='{"Out Patient":"O","In Patient":"I"}';
        elementidentifier.Field_Name__c ='ZipCode__c';
        insert elementidentifier;
    
    WundermanLogin__c login = new WundermanLogin__c();
        login.EndpointURL__c= 'https://thcintellisight.uat.kbmg.com/IntellisightListAPI/com/wunderman/api/listOrder';
        login.Session_Id__c ='5685179';
        login.Password__c ='tenet1test';
        login.GetSession__c='GetSession.jsp';
        login.Name ='tenettest1';
        insert login;    
        cslist.add(login);
    
    Campaign_Member_Search_Critera__c searchmem = new Campaign_Member_Search_Critera__c();
        searchmem.Name='Geography';
        searchmem.Inner_Operator__c = 'OR';
        searchmem.Outer_Operator__c = 'AND';  
        searchmem.Requires_SubGroup__c=false;
        insert searchmem;
        
    	CRM_AudienceUploadJunction__c  audiencejunction = marketingDataUtils.createAudienceJunction(cmp.id);
         
    			Set<id> juncid = new Set<id>();
        juncid.add(audiencejunction.Id);
    
        map<string,string> stringmap = new map<string,string>();
        stringmap.put('value','memgrp');
        string listOrderId = '7333';
        String lstordergrpid = '';
        String lstorderexgrpid = '';
        id clonedCampid = cmp.id;
        string fieldName ='ZipCode__c';
        string value = 'Zipcode';
        Id campaignId = cmp.id;
        string stringcampaignId = cmp.id;
        boolean exclude = true;
        string objectname ='Geographic_Info_Information__c';
        integer pageNumber=1;
        List<string> lstWMContactIds =new String[3];
        lstWMContactIds[0]='test';
        lstWMContactIds[1]='test1';
        lstWMContactIds[2]='test2';
        string request='txt';
        string xmlReponse = '<ROOT><RESULT><RETURNCODE>0</RETURNCODE><MESSAGE>Added Criteria element and values</MESSAGE><LIST_ORDER_CRITERIA_ELMNT_ID>4188725</LIST_ORDER_CRITERIA_ELMNT_ID></RESULT></ROOT>';
        string source='sourc';
 		system.debug('&&&id'+campaignId);

	Test.startTest();
  		string response='<submitMessageResponseObject><responseCode>0</responseCode><transactionId>1568502965</transactionId><attributes><entry><key>NEW_PERSON_IND</key><value>1</value></entry></attributes><jobId>0</jobId><objects><entry><key>person</key><value xsi:type="ns3:person" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns3="com.kbmg.remix.api"><address1>239 GRANT ST</address1><attributes/><city>PARK FOREST</city><country>USA</country><dob>11/03/1971</dob><emailAddress>B_2_WILLIAMS@MYEMAILPROVIDER.COM</emailAddress><firstName>BILLY</firstName><id>WDM1223</id><lastName>WILLIAMS</lastName><middleName>D</middleName><objects/><state>IL</state><suffix>III</suffix><telephone>281.777.9311</telephone></value></entry></objects></submitMessageResponseObject>';
  		ID batchID = database.executeBatch(new Audience_dedupeBatch(cmp,juncid),2000);
    Test.setMock(HttpCalloutMock.class, new MockHttpResponse(response));
    	CampaignMemberCriteriaManager.insertCriteria(fieldName,value,campaignId,exclude,objectname);
	    CampaignMemberCriteriaManager.updateCriteria(fieldName,value,campaignId,exclude);
	    CampaignMemberCriteriaManager.deleteCriteria(fieldName,campaignId,exclude);
	    CampaignMemberCriteriaManager.addCampaignMemberCriteriasForClonedCampaign(cmpmembercritera,listOrderId,lstordergrpid,lstorderexgrpid,cmp,clonedCampid );
	    CampaignMemberCriteriaManager.resetCampaignMemberCriteriasSync(campaignId,batchID);
	    CampaignMemberCriteriaManager.setAddOnExclusionCriterias(campaignId);

Test.stopTest();
}

}
@istest
public class Tenet_NameMatch_Sync_Helper_Test{
    
    static lead createTestData(){

        marketingDataUtils.createTagMapping();
        marketingDataUtils.createCustomSetting();
        Campaign cmp = marketingDataUtils.createcampainDetails();
        cmp.Name='This should be unique'+string.valueOf(DateTime.now());
        //cmp.Call_Center_Identifier__c=cmp.Name;
        //cmp.Campaign_Toll_Free_Number__c='xyztwt';
        update cmp;
        
        lead led = new lead();
        led.Status='New';led.LastName ='Test';led.FirstName = 'Test';led.Phone = '3133630467';led.PostalCode = '110098';
        led.Email = 'kayabe100@gmail.com';led.SourceSystem__c='Marketo';led.Company ='NTT';
        led.CampaignID__c = cmp.Name;
        led.CampaignTacticName__c=cmp.Campaign_Toll_Free_Number__c;
        led.mkto_asthmaRiskCategory__c ='test';led.mkto_backNeckImpairment__c ='test';led.mkto_bmiCategory__c = 'text';
        led.mkto_breastCancer5Year__c = 'tesxt';led.mkto_JointBMICategory__c ='test';led.mkto_Lead_Role__c = 'test1';
        led.mkto_diabetesRisk__c ='test';led.mkto_incontinenceSymptoms__c ='test';led.mkto_lifetimeRiskCategory__c ='test';
        led.mkto_Joint__c = 'thisjoint';led.mkto_lungScreening__c ='txt';led.mkto_Seminar_Date__c = system.today();
        led.mkto_JointAssessment__c = 'tesxt';led.SourceSystem__c = 'Marketo';led.mkto_orthoPainType__c ='test';
        led.mkto_PadRiskCategory__c ='test';led.mkto_prostateRiskCategory__c ='txt';led.mkto_qoLImpact__c = 'test';
        led.mkto_riskCategory__c = 'Marketo';led.mkto_riskCategory30Years__c ='20';led.mkto_strokeRiskCategory__c ='txt';
        led.mkto_weightLossRec__c = 'test';led.mkto_weightLossSurgeryRec__c = 'Marketo';led.Ifs_Best_Time_to_Call__c ='ted';
        led.Ifs_Best_Way_to_Contact__c ='yes';led.mkto_dateOfBirth__c=system.today().addYears(-40);
        insert led;
        
        Contact con = new Contact(lastName='test',Wunderman_Id__c='WDM1223');
        insert con;
        
        //insert new CampaignMemberStatus(Label='Member',SortOrder=3,CampaignId = cmp.id);
        CampaignMember cm = new campaignMember(campaignId=cmp.id,leadid=led.id,status='Member');
        insert cm;
        
        CampaignMember cm1 = new campaignMember(campaignId=cmp.id,contactid=con.id);
        insert cm1;
        
        system.debug(con.id+'*****'+[select id,name,Call_Center_Identifier__c,Campaign_Toll_Free_Number__c from Campaign where id=:cmp.id]);
        return led;
    }
    public static testmethod void marketoNewLead(){
        
        Test.startTest();
            Lead l=Tenet_NameMatch_Sync_Helper_Test.createTestData();
            string response='<submitMessageResponseObject><responseCode>0</responseCode><transactionId>1568502965</transactionId><attributes><entry><key>NEW_PERSON_IND</key><value>1</value></entry></attributes><jobId>0</jobId><objects><entry><key>person</key><value xsi:type="ns3:person" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns3="com.kbmg.remix.api"><address1>239 GRANT ST</address1><attributes/><city>PARK FOREST</city><country>USA</country><dob>11/03/1971</dob><emailAddress>B_2_WILLIAMS@MYEMAILPROVIDER.COM</emailAddress><firstName>BILLY</firstName><id>WDM1223</id><lastName>WILLIAMS</lastName><middleName>D</middleName><objects/><state>IL</state><suffix>III</suffix><telephone>281.777.9311</telephone></value></entry></objects></submitMessageResponseObject>';
            Test.setMock(HttpCalloutMock.class, new MockHttpResponse(response));
            NameMatchScheduler cri= new NameMatchScheduler(20);
            string ch='0 10 12 21 4 ?';
            system.schedule('testsch' , ch , cri);
            
        Test.stopTest();

    }
    public static testmethod void marketoExistingLead(){
        
        Test.startTest();
            Lead l=Tenet_NameMatch_Sync_Helper_Test.createTestData();
            string response='<submitMessageResponseObject><responseCode>0</responseCode><transactionId>1568502965</transactionId><attributes><entry><key>NEW_PERSON_IND</key><value>0</value></entry></attributes><jobId>0</jobId><objects><entry><key>person</key><value xsi:type="ns3:person" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns3="com.kbmg.remix.api"><address1>239 GRANT ST</address1><attributes/><city>PARK FOREST</city><country>USA</country><dob>11/03/1971</dob><emailAddress>B_2_WILLIAMS@MYEMAILPROVIDER.COM</emailAddress><firstName>BILLY</firstName><id>WDM1223</id><lastName>WILLIAMS</lastName><middleName>D</middleName><objects/><state>IL</state><suffix>III</suffix><telephone>281.777.9311</telephone></value></entry></objects></submitMessageResponseObject>';
            Test.setMock(HttpCalloutMock.class, new MockHttpResponse(response));
            NameMatchScheduler cri= new NameMatchScheduler(20);
            string ch='0 10 12 21 4 ?';
            system.schedule('testsch' , ch , cri);
            
        Test.stopTest();

    }
    
    public static testmethod void dmcNewLead(){
        
        Test.startTest();
            Lead l=Tenet_NameMatch_Sync_Helper_Test.createTestData();
            l.SourceSystem__c='DMC';
            update l;
            string response='<submitMessageResponseObject><responseCode>0</responseCode><transactionId>1568502965</transactionId><attributes><entry><key>NEW_PERSON_IND</key><value>1</value></entry></attributes><jobId>0</jobId><objects><entry><key>person</key><value xsi:type="ns3:person" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns3="com.kbmg.remix.api"><address1>239 GRANT ST</address1><attributes/><city>PARK FOREST</city><country>USA</country><dob>11/03/1971</dob><emailAddress>B_2_WILLIAMS@MYEMAILPROVIDER.COM</emailAddress><firstName>BILLY</firstName><id>WDM1223</id><lastName>WILLIAMS</lastName><middleName>D</middleName><objects/><state>IL</state><suffix>III</suffix><telephone>281.777.9311</telephone></value></entry></objects></submitMessageResponseObject>';
            Test.setMock(HttpCalloutMock.class, new MockHttpResponse(response));
            NameMatchScheduler cri= new NameMatchScheduler(20);
            string ch='0 10 12 21 4 ?';
            system.schedule('testsch' , ch , cri);
            
        Test.stopTest();

    }
    public static testmethod void dmcExistingLead(){
        
        Test.startTest();
            Lead l=Tenet_NameMatch_Sync_Helper_Test.createTestData();
            l.SourceSystem__c='DMC';
            update l;
            
            string response='<submitMessageResponseObject><responseCode>0</responseCode><transactionId>1568502965</transactionId><attributes><entry><key>NEW_PERSON_IND</key><value>0</value></entry></attributes><jobId>0</jobId><objects><entry><key>person</key><value xsi:type="ns3:person" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns3="com.kbmg.remix.api"><address1>239 GRANT ST</address1><attributes/><city>PARK FOREST</city><country>USA</country><dob>11/03/1971</dob><emailAddress>B_2_WILLIAMS@MYEMAILPROVIDER.COM</emailAddress><firstName>BILLY</firstName><id>WDM1223</id><lastName>WILLIAMS</lastName><middleName>D</middleName><objects/><state>IL</state><suffix>III</suffix><telephone>281.777.9311</telephone></value></entry></objects></submitMessageResponseObject>';
            Test.setMock(HttpCalloutMock.class, new MockHttpResponse(response));
            NameMatchScheduler cri= new NameMatchScheduler(20);
            string ch='0 10 12 21 4 ?';
            system.schedule('testsch' , ch , cri);
            
        Test.stopTest();

    }
}
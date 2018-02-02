@istest
public class WundermanSessionScheduler_Test {

public static testmethod void WundermanSessionScheduler_TestMethod () {
//String url = 'https://kosmos.kbmg.com/IntellisightListAPI/com/wunderman/api/listOrder/GetSession.jsp?username=tenettest&password=tenet1test';
list<WundermanLogin__c> cslist = new list<WundermanLogin__c>();
     WundermanLogin__c login = new WundermanLogin__c();
      login.EndpointURL__c= 'https://thcintellisight.uat.kbmg.com/IntellisightListAPI/com/wunderman/api/listOrder';
      login.Session_Id__c ='5685179';
      login.Password__c ='tenet1test';
      login.GetSession__c='GetSession.jsp';
      login.Name ='tenettest';
         insert login;    
      cslist.add(login);
Test.startTest();
    string response='<submitMessageResponseObject><responseCode>0</responseCode><transactionId>1568502965</transactionId><attributes><entry><key>NEW_PERSON_IND</key><value>1</value></entry></attributes><jobId>0</jobId><objects><entry><key>person</key><value xsi:type="ns3:person" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns3="com.kbmg.remix.api"><address1>239 GRANT ST</address1><attributes/><city>PARK FOREST</city><country>USA</country><dob>11/03/1971</dob><emailAddress>B_2_WILLIAMS@MYEMAILPROVIDER.COM</emailAddress><firstName>BILLY</firstName><id>WDM1223</id><lastName>WILLIAMS</lastName><middleName>D</middleName><objects/><state>IL</state><suffix>III</suffix><telephone>281.777.9311</telephone></value></entry></objects></submitMessageResponseObject>';
    Test.setMock(HttpCalloutMock.class, new MockHttpResponse(response));Datetime dt = Datetime.now().addMinutes(20);
String CRON_EXP = '0 10 12 21 4 ?';
String jobId = System.schedule('Sample_name', CRON_EXP, new WundermanSessionScheduler() ); 
WundermanSessionScheduler.getSession();
}
}
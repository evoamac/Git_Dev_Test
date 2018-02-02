@istest
public class Process_CampaignMember_Scheduler_Test{
public static testmethod void executemethod() {
integer interval = 21;
 Test.startTest();
Process_CampaignMember_Scheduler campmembersc = new Process_CampaignMember_Scheduler(interval);
string response='<submitMessageResponseObject><responseCode>0</responseCode><transactionId>1568502965</transactionId><attributes><entry><key>NEW_PERSON_IND</key><value>1</value></entry></attributes><jobId>0</jobId><objects><entry><key>person</key><value xsi:type="ns3:person" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns3="com.kbmg.remix.api"><address1>239 GRANT ST</address1><attributes/><city>PARK FOREST</city><country>USA</country><dob>11/03/1971</dob><emailAddress>B_2_WILLIAMS@MYEMAILPROVIDER.COM</emailAddress><firstName>BILLY</firstName><id>WDM1223</id><lastName>WILLIAMS</lastName><middleName>D</middleName><objects/><state>IL</state><suffix>III</suffix><telephone>281.777.9311</telephone></value></entry></objects></submitMessageResponseObject>';
Test.setMock(HttpCalloutMock.class, new MockHttpResponse(response));Datetime dt = Datetime.now().addMinutes(20);
String CRON_EXP = '0 10 12 21 4 ?';
String jobId = System.schedule('Sample_name', CRON_EXP, new Process_CampaignMember_Scheduler(interval) ); 
 Test.stopTest();
 } 
}
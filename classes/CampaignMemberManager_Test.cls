@istest
public class CampaignMemberManager_Test{
public static testmethod void managermethod(){
list<Transaction__c> listtran = new list<Transaction__c>();
integer suppressionCount = 3;
integer cgCount = 4;   
Campaign cmp = new Campaign();
        cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        cmp.Service_Line__c='Burn';
        cmp.Sub_Service_Line__c='Dermatology';
        cmp.Tactic__c='Mail';
        cmp.Audience__c='Detroit';
        cmp.count_of_index__c ='765';
        cmp.Channel__c='Direct Mail';
        cmp.Control_Group_Size__c=232;
        cmp.Ignore_Bad_Debt_Suppression__c = False;
        cmp.Control_Group_Percentage__c =67;
        cmp.List_Order_Id__c = 7333;
          insert cmp;
              Campaign cmp1 = new Campaign();
        cmp1.Name='20170129-103-Detroit-Burn-Direct Mail-V1';
        cmp1.Service_Line__c='Burn';
        cmp.Audience__c='Detroit';
        cmp1.Sub_Service_Line__c='Dermatology';
        cmp1.Tactic__c='Mail';
        cmp1.count_of_index__c ='765';
        cmp1.Channel__c='Direct Mail';
        cmp1.Control_Group_Size__c=232;
        cmp1.Ignore_Bad_Debt_Suppression__c = False;
        cmp1.Ignore_Minor_Suppression__c = True;
        cmp1.Control_Group_Percentage__c =67;
        cmp1.List_Order_Id__c = 7733;
        cmp1.ParentId =cmp.id;
        cmp1.Current_count__c=3789;
        cmp1.Supp_Count__c=660;
          insert cmp1;
 list<WundermanLogin__c> cslist = new list<WundermanLogin__c>();
 WundermanLogin__c login = new WundermanLogin__c();
  login.EndpointURL__c= 'https://thcintellisight.uat.kbmg.com/IntellisightListAPI/com/wunderman/api/listOrder';
  login.Session_Id__c ='5685179';
  login.Password__c ='tenet1test';
  login.GetSession__c='GetSession.jsp';
  login.Name ='tenettest1';
     insert login;    
  cslist.add(login);
map<id,Campaign> campaignMap = new map<id,campaign>([SELECT Id, Name,Channel__c,Call_to_Action__c FROM Campaign WHERE ID=:cmp.id]);
boolean isInsert= False;      
Decimal listOrderId = 87.46;     
  Account acc = new Account();
            acc.Name='test';
             insert acc;
     
        contact con = new Contact();
           con.AccountId = acc.id;
           con.LastName='test';
           con.Wunderman_Id__c ='76671';
           con.SUP_BAD_DEBT__c = true;
            insert con;
set<id> contactIds = new set<id>();
 contactIds.add(con.id);
Set<String> s1 = new Set<String>();
s1.add('7667');
s1.add('7865');
  CampaignMember campaignmem = new CampaignMember();
           campaignmem.CampaignId = cmp.Id;
           campaignmem.ContactId =Con.id;
           campaignmem.Control_Group__c = true;
           //campaignmem.Contact_Identifier__c = Con.id;
             insert campaignmem;

 
Model__c  mod = marketingDataUtils.createCampaignModel(cmp.id);
lead led = marketingDataUtils.createleads();
Transaction__c  trans = marketingDataUtils.createTransaction(cmp1.id,led.id);
 listtran.add(trans);
    test.starttest();
 
 ApexPages.StandardController sc = new ApexPages.standardController(cmp);
 CampaignMemberManager cmanagersc = new CampaignMemberManager(sc);
 CampaignMemberManager cmanager = new CampaignMemberManager();

 cmanager.confirmOrderPlace = false;
 string response='<submitMessageResponseObject><responseCode>0</responseCode><transactionId>1568502965</transactionId><attributes><entry><key>NEW_PERSON_IND</key><value>1</value></entry></attributes><jobId>0</jobId><objects><entry><key>person</key><value xsi:type="ns3:person" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns3="com.kbmg.remix.api"><address1>239 GRANT ST</address1><attributes/><city>PARK FOREST</city><country>USA</country><dob>11/03/1971</dob><emailAddress>B_2_WILLIAMS@MYEMAILPROVIDER.COM</emailAddress><firstName>BILLY</firstName><id>WDM1223</id><lastName>WILLIAMS</lastName><middleName>D</middleName><objects/><state>IL</state><suffix>III</suffix><telephone>281.777.9311</telephone></value></entry></objects></submitMessageResponseObject>';
Test.setMock(HttpCalloutMock.class, new MockHttpResponse(response));
CampaignMemberManager.getNetCount(cmp.id);
CampaignMemberManager.soqlContactCount = 10;
CampaignMemberManager.transactionList=listtran;
CampaignMemberManager.parseListOrderId(listOrderId);
CampaignMemberManager.getSuppressCount(s1,cmp1,2000);
//CampaignMemberManager.soqlContactCount =5;
CampaignMemberManager.getCGCount(cmp1);
CampaignMemberManager.updateContactSyncToMarketo(contactIds);
CampaignMemberManager.createMemberStatus(campaignMap, isInsert);
     test.stoptest();
}
public static testmethod void managermethodnew(){ 
 Campaign cmp = new Campaign();
        cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        cmp.Service_Line__c='Burn';
        cmp.Sub_Service_Line__c='Dermatology';
        cmp.Tactic__c='Mail';
        cmp.Audience__c='Detroit';
        cmp.count_of_index__c ='765';
        cmp.Channel__c='Direct Mail';
        cmp.Control_Group_Size__c=232;
        cmp.Ignore_Bad_Debt_Suppression__c = False;
        cmp.Control_Group_Percentage__c =67;
        cmp.List_Order_Id__c = 7333;
        cmp.Current_count__c=3789;
        cmp.Supp_Count__c=660;
          insert cmp;
Model__c  mod = marketingDataUtils.createCampaignModel(cmp.id);
CampaignMemberManager.soqlContactCount =5;
integer suppressionCount = 3;
integer cgCount = 4;   
CampaignMemberManager.getCGCount(cmp);
}
public static testmethod void managermethodnew1(){ 
    Campaign cmp = new Campaign();
        cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        cmp.Service_Line__c='Burn';
        cmp.Sub_Service_Line__c='Dermatology';
        cmp.Tactic__c='Mail';
        cmp.Audience__c='Detroit';
        cmp.count_of_index__c ='765';
        cmp.Channel__c='Direct Mail';
        cmp.Missing_Contact_Count__c =4;
        cmp.Control_Group_Size__c=232;
        cmp.CG_Count__c=4;
        cmp.Ignore_Bad_Debt_Suppression__c = False;
        cmp.Control_Group_Percentage__c =67;
        cmp.List_Order_Id__c = 7333;
          insert cmp;
    Account acc = new Account();
            acc.Name='test';
             insert acc;
     
    contact con = new Contact();
           con.AccountId = acc.id;
           con.LastName='test';
           con.Wunderman_Id__c ='76672';
           con.SUP_BAD_DEBT__c = true;
            insert con;
    
     Account acc1 = new Account();
            acc1.Name='testcon';
             insert acc1;
     
    contact cont = new Contact();
           cont.AccountId = acc.id;
           cont.LastName='vaishali';
           cont.Wunderman_Id__c ='7668';
           cont.SUP_BAD_DEBT__c = false;
            insert cont;
    
    contact cont3 = new Contact();
           cont3.AccountId = acc.id;
           cont3.LastName='vaishali';
           cont3.Wunderman_Id__c ='76684';
           cont3.SUP_BAD_DEBT__c = false;
            insert cont3;
    
    contact cont4 = new Contact();
           cont4.AccountId = acc.id;
           cont4.LastName='vaishali';
           cont4.Wunderman_Id__c ='78645';
           cont4.SUP_BAD_DEBT__c = True;
            insert cont4;
set<id> contactIds = new set<id>();
 contactIds.add(con.id);
Set<String> s1 = new Set<String>();
s1.add('7667');
s1.add('786');
lead ld = new lead();
       ld.Status='New';
       ld.LastName ='Goel';
       ld.FirstName = 'Vaishali';
       ld.Phone = '3133630467';
       ld.Email = 'kayabe100@gmail.com';
       ld.PostalCode = '110098';
       ld.CampaignID__c = '2016-05-24-044-Detroit-Florida-Miami-BMC-OB/GYN-Radio Internet-V1Undo';
       ld.SourceSystem__c='CONIFER';
       ld.Company ='NTT';
       //ld.Is_Processed__c = False;
        insert ld;
Transaction__c Transation = new Transaction__c();
       Transation.Campaign__c = cmp.Id;
       Transation.Request_URL__c ='test';
       Transation.Transaction_Source__c = 'Name Match';
       Transation.Campaign_Member_Status__c='Ready to Process';
       Transation.Lead_SFDC_Id__c = ld.id;
       Transation.WM_List_Order_Id__c=7333;
       Transation.Type__c='GetOrderData';
       Transation.Response_Schema__c ='ok this is just response schema';
        insert Transation;
list<CampaignMember> camplist = new list<CampaignMember>();
    
CampaignMember campaignmem = new CampaignMember();
           campaignmem.CampaignId = cmp.Id;
           campaignmem.ContactId =Con.id;
           campaignmem.Control_Group__c = true;
           //campaignmem.Contact_Identifier__c = Con.id;
             insert campaignmem;
    CampaignMember newcampainmember = new CampaignMember();
        newcampainmember.CampaignId = cmp.Id;
           newcampainmember.ContactId =cont.id;
           newcampainmember.Control_Group__c = true;
           //newcampainmember.Contact_Identifier__c = cont.id;
             insert newcampainmember;
    CampaignMemberManager.soqlContactCount =4;
    CampaignMemberManager.addContactsToCampaigns(s1,cmp.id,Transation);

}
 public static testmethod void managermethodisinsert(){       
list<Transaction__c> listtran = new list<Transaction__c>();
integer suppressionCount = 3;
integer cgCount = 4;   

Campaign cmp = new Campaign();
        cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        cmp.Service_Line__c='Burn';
        cmp.Sub_Service_Line__c='Dermatology';
        cmp.Audience__c='Detroit';
        cmp.count_of_index__c ='765';
        cmp.Channel__c='Inbound';
        cmp.Call_to_Action__c='Event';
        cmp.Control_Group_Size__c=232;
        cmp.Ignore_Bad_Debt_Suppression__c = False;
        cmp.Control_Group_Percentage__c =67;
        cmp.List_Order_Id__c = 7333;
          insert cmp;
    
              Campaign cmp1 = new Campaign();
        cmp1.Name='20170129-103-Detroit-Burn-Direct Mail-V1';
        cmp1.Service_Line__c='Burn';
        cmp1.Audience__c='Detroit';
        cmp1.Sub_Service_Line__c='Dermatology';
        cmp1.Tactic__c='Mail';
        cmp1.count_of_index__c ='765';
        cmp1.Channel__c='Direct Mail';
        cmp1.Control_Group_Size__c=232;
        cmp1.Ignore_Bad_Debt_Suppression__c = False;
        cmp1.Ignore_Minor_Suppression__c = True;
        cmp1.Control_Group_Percentage__c =67;
        cmp1.List_Order_Id__c = 7733;
        cmp1.ParentId =cmp.id;
          insert cmp1;  
     CampaignMemberStatus status = new CampaignMemberStatus();
       status.CampaignId=cmp.id;
       status.Label='No-Show1';
         insert status;
map<id,Campaign> campaignMap = new map<id,campaign>([SELECT Id, Name,Channel__c,Call_to_Action__c FROM Campaign WHERE ID=:cmp.id]);
boolean isInsert= false;      
 
  Account acc = new Account();
            acc.Name='test';
             insert acc;
     
        contact con = new Contact();
           con.AccountId = acc.id;
           con.LastName='test';
           con.Wunderman_Id__c ='766712';
           con.SUP_BAD_DEBT__c = true;
            insert con;
set<id> contactIds = new set<id>();
 contactIds.add(con.id);
Set<String> s1 = new Set<String>();
s1.add('7667');
s1.add('7865');
  CampaignMember campaignmem = new CampaignMember();
           campaignmem.CampaignId = cmp.Id;
           campaignmem.ContactId =Con.id;
           campaignmem.Control_Group__c = true;
           //campaignmem.Contact_Identifier__c = Con.id;
             insert campaignmem;     
Model__c  mod = marketingDataUtils.createCampaignModel(cmp.id);
lead led = marketingDataUtils.createleads();
Transaction__c  trans = marketingDataUtils.createTransaction(cmp1.id,led.id);
listtran.add(trans);
    test.starttest();  
 ApexPages.StandardController sc = new ApexPages.standardController(cmp);
 CampaignMemberManager cmanagersc = new CampaignMemberManager(sc);
 CampaignMemberManager cmanager = new CampaignMemberManager();
 cmanager.confirmOrderPlace = false;     
 CampaignMemberManager.createMemberStatus(campaignMap, isInsert);
    test.stoptest();
}
public static testmethod void managermethodnewadcont(){ 

    Campaign cmp = new Campaign();
        cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        cmp.Service_Line__c='Burn';
        cmp.Sub_Service_Line__c='Dermatology';
        cmp.Tactic__c='Mail';
        cmp.Audience__c='Detroit';
        cmp.count_of_index__c ='765';
        cmp.Channel__c='Direct Mail';
        cmp.Missing_Contact_Count__c =4;
        
        cmp.CG_Count__c=4;
        cmp.Ignore_Bad_Debt_Suppression__c = False;
        cmp.Control_Group_Percentage__c =67;
        cmp.List_Order_Id__c = 7333;
          insert cmp;
 lead ld = new lead();
       ld.Status='New';
       ld.LastName ='Goel';
       ld.FirstName = 'Vaishali';
       ld.Phone = '3133630467';
       ld.Email = 'kayabe100@gmail.com';
       ld.PostalCode = '110098';
       ld.CampaignID__c = '2016-05-24-044-Detroit-Florida-Miami-BMC-OB/GYN-Radio Internet-V1Undo';
       ld.SourceSystem__c='CONIFER';
       ld.Company ='NTT';
       //ld.Is_Processed__c = False;
        insert ld;
Transaction__c Transation = new Transaction__c();
       Transation.Campaign__c = cmp.Id;
       Transation.Request_URL__c ='test';
       Transation.Transaction_Source__c = 'Name Match';
       Transation.Campaign_Member_Status__c='Ready to Process';
       Transation.Lead_SFDC_Id__c = ld.id;
       Transation.WM_List_Order_Id__c=7333;
       Transation.Type__c='GetOrderData';
       Transation.Response_Schema__c ='ok this is just response schema';
        insert Transation;
 
    Account acc = new Account();
            acc.Name='test';
             insert acc;
     
    contact con = new Contact();
           con.AccountId = acc.id;
           con.LastName='test';
           con.Wunderman_Id__c ='766789';
           con.SUP_BAD_DEBT__c = true;
            insert con;
 contact conc = new Contact();
           conc.LastName='test';
           conc.Wunderman_Id__c ='7616789';
           conc.SUP_BAD_DEBT__c = true;
            insert conc;
    
     Account acc1 = new Account();
            acc1.Name='testcon';
             insert acc1;
     
    contact cont = new Contact();
           cont.AccountId = acc.id;
           cont.LastName='vaishali';
           cont.Wunderman_Id__c ='766727';
           cont.SUP_BAD_DEBT__c = false;
            insert cont;
 contact conte = new Contact();
           conte.AccountId = acc.id;
           conte.LastName='vaishali';
           conte.Wunderman_Id__c ='76690';
           conte.SUP_BAD_DEBT__c = True;
            insert conte;
   
set<id> contactIds = new set<id>();
 contactIds.add(con.id);
Set<String> s1 = new Set<String>();
s1.add('7616789');
s1.add('786');
//lead led = marketingDataUtils.createleads();
//Transaction__c  trans = marketingDataUtils.createTransaction(cmp.id,led.id);
list<CampaignMember> camplist = new list<CampaignMember>();
    
CampaignMember campaignmem = new CampaignMember();
           campaignmem.CampaignId = cmp.Id;
           campaignmem.ContactId =Con.id;
           campaignmem.Control_Group__c = true;
           //campaignmem.Contact_Identifier__c = Con.id;
             insert campaignmem;
    CampaignMember newcampainmember = new CampaignMember();
        newcampainmember.CampaignId = cmp.Id;
           newcampainmember.ContactId =cont.id;
           newcampainmember.Control_Group__c = true;
             insert newcampainmember;
    CampaignMemberManager.soqlContactCount =1;
    CampaignMemberManager.addContactsToCampaigns(s1,cmp.id,Transation);
   // CampaignMemberManager.confirmControlGroupCount(cmp);

}

public static testmethod void managermethodnewadcont1(){ 
  Double pageCount = 27;
    Campaign cmp = new Campaign();
        cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        cmp.Service_Line__c='Burn';
        cmp.Sub_Service_Line__c='Dermatology';
        cmp.Tactic__c='Mail';
        cmp.Audience__c='Detroit';
        cmp.count_of_index__c ='765';
        cmp.Channel__c='Direct Mail';
        cmp.Missing_Contact_Count__c =4;
        cmp.Supp_Count__c=660;
        cmp.CG_Count__c=1083;
        cmp.Current_count__c=3789;
        cmp.Supp_Count__c=660;       
        cmp.Ignore_Bad_Debt_Suppression__c = False;
        cmp.Control_Group_Percentage__c =5;
        cmp.List_Order_Id__c = 985675;
          insert cmp;
      lead ld = new lead();
       ld.Status='New';
       ld.LastName ='Goel';
       ld.FirstName = 'Vaishali';
       ld.Phone = '3133630467';
       ld.Email = 'kayabe100@gmail.com';
       ld.PostalCode = '110098';
       ld.CampaignID__c = '2016-05-24-044-Detroit-Florida-Miami-BMC-OB/GYN-Radio Internet-V1Undo';
       ld.SourceSystem__c='CONIFER';
       ld.Company ='NTT';
       //ld.Is_Processed__c = False;
        insert ld;
Transaction__c Transation = new Transaction__c();
       Transation.Campaign__c = cmp.Id;
       Transation.Request_URL__c ='test';
       Transation.Transaction_Source__c = 'Name Match';
       Transation.Campaign_Member_Status__c='Ready to Process';
       Transation.Lead_SFDC_Id__c = ld.id;
       Transation.WM_List_Order_Id__c=7333;
       Transation.Type__c='GetOrderData';
       Transation.Response_Schema__c ='ok this is just response schema';
        insert Transation;
 
    Account acc = new Account();
            acc.Name='test';
             insert acc;
     
    contact con = new Contact();
           con.AccountId = acc.id;
           con.LastName='test';
           con.Wunderman_Id__c ='766789';
           con.SUP_BAD_DEBT__c = true;
            insert con;
 contact conc = new Contact();
           conc.LastName='test';
           conc.Wunderman_Id__c ='7616789';
           conc.SUP_BAD_DEBT__c = true;
            insert conc;
    
     Account acc1 = new Account();
            acc1.Name='testcon';
             insert acc1;
     
    contact cont = new Contact();
           cont.AccountId = acc.id;
           cont.LastName='vaishali';
           cont.Wunderman_Id__c ='766727';
           cont.SUP_BAD_DEBT__c = false;
            insert cont;
 contact conte = new Contact();
           conte.AccountId = acc.id;
           conte.LastName='vaishali';
           conte.Wunderman_Id__c ='76690';
           conte.SUP_BAD_DEBT__c = True;
            insert conte;
   
  set<id> contactIds = new set<id>();
    contactIds.add(con.id);
    Set<String> s1 = new Set<String>();
      s1.add('7616789');
      s1.add('786');
//lead led = marketingDataUtils.createleads();
//Transaction__c  trans = marketingDataUtils.createTransaction(cmp.id,led.id);
list<CampaignMember> camplist = new list<CampaignMember>();
    
CampaignMember campaignmem = new CampaignMember();
           campaignmem.CampaignId = cmp.Id;
           campaignmem.ContactId =Con.id;
           campaignmem.Control_Group__c = true;
           //campaignmem.Contact_Identifier__c = Con.id;
             insert campaignmem;
    CampaignMember newcampainmember = new CampaignMember();
        newcampainmember.CampaignId = cmp.Id;
           newcampainmember.ContactId =cont.id;
           newcampainmember.Control_Group__c = true;
           //newcampainmember.Contact_Identifier__c = cont.id;
             insert newcampainmember;
    CampaignMemberManager.soqlContactCount =4;
    CampaignMemberManager.addContactsToCampaigns(s1,cmp.id,Transation);

}

public static testmethod void managermethod5(){
list<Transaction__c> listtran = new list<Transaction__c>();
integer suppressionCount = 3;
integer cgCount = 4;  
string failedIds='failIDDD'; 
integer epectedCGCount = -1;
Campaign cmp = new Campaign();
        cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        cmp.Service_Line__c='Burn';
        cmp.Sub_Service_Line__c='Dermatology';
        cmp.Tactic__c='Blast';
        cmp.Audience__c='Detroit';
        cmp.count_of_index__c ='765';
        cmp.Channel__c='Email';
        cmp.Control_Group_Size__c=232;
        cmp.Ignore_Bad_Debt_Suppression__c = true;
        cmp.Control_Group_Percentage__c =67;
        cmp.List_Order_Id__c = 7333;
          insert cmp;
              Campaign cmp1 = new Campaign();
        cmp1.Name='20170129-103-Detroit-Burn-Direct Mail-V1';
        cmp1.Service_Line__c='Burn';
        cmp.Audience__c='Detroit';
        cmp1.Sub_Service_Line__c='Dermatology';
        cmp1.Tactic__c='Blast';
        cmp1.count_of_index__c ='765';
        cmp1.Channel__c='Email';
        cmp1.Control_Group_Size__c=232;
        cmp1.Ignore_Bad_Debt_Suppression__c = False;
        cmp1.Ignore_Minor_Suppression__c = false;
        cmp1.Control_Group_Percentage__c =67;
        cmp1.List_Order_Id__c = 7733;
        cmp1.ParentId =cmp.id;
        cmp1.Current_count__c=3789;
        cmp1.Supp_Count__c=660;
          insert cmp1;
 list<WundermanLogin__c> cslist = new list<WundermanLogin__c>();
 WundermanLogin__c login = new WundermanLogin__c();
  login.EndpointURL__c= 'https://thcintellisight.uat.kbmg.com/IntellisightListAPI/com/wunderman/api/listOrder';
  login.Session_Id__c ='5685179';
  login.Password__c ='tenet1test';
  login.GetSession__c='GetSession.jsp';
  login.Name ='tenettest1';
     insert login;    
  cslist.add(login);
map<id,Campaign> campaignMap = new map<id,campaign>([SELECT Id, Name,Channel__c,Call_to_Action__c FROM Campaign WHERE ID=:cmp.id]);
boolean isInsert= False;      
Decimal listOrderId = 87.46;     
  Account acc = new Account();
            acc.Name='test';
             insert acc;
     
        contact con = new Contact();
           con.AccountId = acc.id;
           con.LastName='test';
           con.Wunderman_Id__c ='76671';
           con.SUP_BAD_DEBT__c = true;
            insert con;
set<id> contactIds = new set<id>();
 contactIds.add(con.id);
Set<String> s1 = new Set<String>();
s1.add('7667');
s1.add('7865');
  CampaignMember campaignmem = new CampaignMember();
           campaignmem.CampaignId = cmp.Id;
           campaignmem.ContactId =Con.id;
           campaignmem.Control_Group__c = true;
           //campaignmem.Contact_Identifier__c = Con.id;
             insert campaignmem;

 
Model__c  mod = marketingDataUtils.createCampaignModel(cmp.id);
lead led = marketingDataUtils.createleads();
Transaction__c  trans = marketingDataUtils.createTransaction(cmp1.id,led.id);
 listtran.add(trans);
    test.starttest();
 
 ApexPages.StandardController sc = new ApexPages.standardController(cmp);
 CampaignMemberManager cmanagersc = new CampaignMemberManager(sc);
  CampaignMemberManager cmanager = new CampaignMemberManager();
 

 cmanager.confirmOrderPlace = false;
 string response='<submitMessageResponseObject><responseCode>0</responseCode><transactionId>1568502965</transactionId><attributes><entry><key>NEW_PERSON_IND</key><value>1</value></entry></attributes><jobId>0</jobId><objects><entry><key>person</key><value xsi:type="ns3:person" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns3="com.kbmg.remix.api"><address1>239 GRANT ST</address1><attributes/><city>PARK FOREST</city><country>USA</country><dob>11/03/1971</dob><emailAddress>B_2_WILLIAMS@MYEMAILPROVIDER.COM</emailAddress><firstName>BILLY</firstName><id>WDM1223</id><lastName>WILLIAMS</lastName><middleName>D</middleName><objects/><state>IL</state><suffix>III</suffix><telephone>281.777.9311</telephone></value></entry></objects></submitMessageResponseObject>';
Test.setMock(HttpCalloutMock.class, new MockHttpResponse(response));
CampaignMemberManager.getNetCount(cmp.id);
CampaignMemberManager.soqlContactCount = 10;
CampaignMemberManager.transactionList=listtran;
CampaignMemberManager.parseListOrderId(listOrderId);
CampaignMemberManager.getSuppressCount(s1,cmp1,2000);
CampaignMemberManager.getCGCount(cmp1);
CampaignMemberManager.updateContactSyncToMarketo(contactIds);
CampaignMemberManager.createMemberStatus(campaignMap, isInsert);
     test.stoptest();
 }
public static testmethod void managermethod7(){
list<Transaction__c> listtran = new list<Transaction__c>();
integer suppressionCount = 3;
integer cgCount = 4; 
integer epectedCGCount = 787597;  
Campaign cmp = new Campaign();
        cmp.Name='20170127-103-Detroit-Cardiovascular-Direct Mail-V1';
        cmp.Service_Line__c='Burn';
        cmp.Sub_Service_Line__c='Dermatology';
        cmp.Tactic__c='Mail';
        cmp.Audience__c='Detroit';
        cmp.count_of_index__c ='765';
        cmp.Channel__c='Direct Mail';
        cmp.Control_Group_Size__c=457;
        cmp.Current_count__c=12;
        cmp.Ignore_Bad_Debt_Suppression__c = False;
        cmp.Control_Group_Percentage__c =67;
        cmp.List_Order_Id__c = 7333;
        cmp.Missing_Contact_Count__c=3;
        
        cmp.Supp_Count__c=2;
        cmp.Add_Member_Status__c= 'Calculated Net Count';
          insert cmp;
          
        Campaign cmp1 = new Campaign();
        cmp1.Name='20170129-103-Detroit-Burn-Direct Mail-V1';
        cmp1.Service_Line__c='Burn';
        cmp.Audience__c='Detroit';
        cmp1.Sub_Service_Line__c='Dermatology';
        cmp1.Tactic__c='Mail';
        cmp1.count_of_index__c ='765';
        cmp1.Channel__c='Direct Mail';
        cmp1.Control_Group_Size__c=NULL;
        cmp1.Ignore_Bad_Debt_Suppression__c = False;
        cmp1.Ignore_Minor_Suppression__c = True;
        cmp1.Control_Group_Percentage__c =1;
        cmp1.List_Order_Id__c = 7733;
        cmp1.Current_count__c=3789;
        cmp1.Supp_Count__c=660;
        cmp1.Missing_Contact_Count__c = 123;
        cmp1.ParentId =cmp.id;
        insert cmp1;
        
        
        
 list<WundermanLogin__c> cslist = new list<WundermanLogin__c>();
 WundermanLogin__c login = new WundermanLogin__c();
  login.EndpointURL__c= 'https://thcintellisight.uat.kbmg.com/IntellisightListAPI/com/wunderman/api/listOrder';
  login.Session_Id__c ='5685179';
  login.Password__c ='tenet1test';
  login.GetSession__c='GetSession.jsp';
  login.Name ='tenettest1';
     insert login;    
  cslist.add(login);

map<id,Campaign> campaignMap = new map<id,campaign>([SELECT Id, Name,Channel__c,Call_to_Action__c FROM Campaign WHERE ID=:cmp.id]);
boolean isInsert= False;      
Decimal listOrderId = 87.46;     
  Account acc = new Account();
            acc.Name='test';
             insert acc;
     
        contact con = new Contact();
           con.AccountId = acc.id;
           con.LastName='test';
           con.Wunderman_Id__c ='76671';
           con.SUP_BAD_DEBT__c = true;
            insert con;
           contact con2 = new Contact();
           con2.AccountId = acc.id;
           con2.LastName='test2';
           con2.Wunderman_Id__c ='76674';
           con2.SUP_BAD_DEBT__c = true;
            insert con2;
set<id> contactIds = new set<id>();
 contactIds.add(con.id);
Set<String> s1 = new Set<String>();
s1.add('7667');
s1.add('7865');
  CampaignMember campaignmem = new CampaignMember();
           campaignmem.CampaignId = cmp.Id;
           campaignmem.ContactId =Con.id;
           campaignmem.Control_Group__c = true;
           //campaignmem.Contact_Identifier__c = Con.id;
             insert campaignmem;
           CampaignMember campaignmem2 = new CampaignMember();
           campaignmem2.CampaignId = cmp1.Id;
           campaignmem2.ContactId =Con.id;
           campaignmem2.Control_Group__c = true;
           //campaignmem.Contact_Identifier__c = Con.id;
             insert campaignmem2;
           CampaignMember campaignmem3 = new CampaignMember();
           campaignmem3.CampaignId = cmp1.Id;
           campaignmem3.ContactId =Con2.id;
           campaignmem3.Control_Group__c = false;
           campaignmem3.Suppress__c = false;
           //campaignmem.Contact_Identifier__c = Con.id;
             insert campaignmem3;
             System.debug('****cmp1**member********'+cmp1.Control_Group_Count__c);
Tenet_Data_Configuration__c tenet = new Tenet_Data_Configuration__c();
          tenet.Static_Value__c='1';
          tenet.Name='Page Size';
            insert tenet; 
 Campaign_Member_Criteria_Group__c cmpgrp = marketingDataUtils.createCampaignmemgrp(cmp.id);
 Campaign_Member_Criteria__c mem= new Campaign_Member_Criteria__c();
                mem.Campaign__c=cmp.id;
                mem.Exclude__c=true;
                mem.Field_Name__c='Diagnosis_Code__c';
                mem.Value__c='One or more encounters - Patients';
                    insert mem;
 
Model__c  mod = marketingDataUtils.createCampaignModel(cmp.id);
lead led = marketingDataUtils.createleads();
Transaction__c  trans = marketingDataUtils.createTransaction(cmp1.id,led.id);
trans.Type__c='GetOrderData';

 listtran.add(trans);
    test.starttest();
 
 ApexPages.StandardController sc = new ApexPages.standardController(cmp);
 CampaignMemberManager cmanagersc = new CampaignMemberManager(sc);
 CampaignMemberManager cmanager = new CampaignMemberManager();

 cmanager.confirmOrderPlace = false;
 string failedIds='failIDDD'; 
 integer rowLimit = 457;
 string response='<submitMessageResponseObject><responseCode>0</responseCode><Order_Delivery_Status>DLVD.NO.CHRG</Order_Delivery_Status><transactionId>1568502965</transactionId><attributes><entry><key>NEW_PERSON_IND</key><value>1</value></entry></attributes><jobId>0</jobId><objects><entry><key>person</key><value xsi:type="ns3:person" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns3="com.kbmg.remix.api"><address1>239 GRANT ST</address1><attributes/><city>PARK FOREST</city><country>USA</country><dob>11/03/1971</dob><emailAddress>B_2_WILLIAMS@MYEMAILPROVIDER.COM</emailAddress><firstName>BILLY</firstName><id>WDM1223</id><lastName>WILLIAMS</lastName><middleName>D</middleName><objects/><state>IL</state><suffix>III</suffix><telephone>281.777.9311</telephone></value></entry></objects></submitMessageResponseObject>';
Test.setMock(HttpCalloutMock.class, new MockHttpResponse(response));
CampaignMemberManager.getNetCount(cmp.id);
CampaignMemberManager.soqlContactCount = 10;
CampaignMemberManager.transactionList=listtran;
CampaignMemberManager.parseListOrderId(listOrderId);
CampaignMemberManager.getSuppressCount(s1,cmp1,2000);
//CampaignMemberManager.soqlContactCount =5;
CampaignMemberManager.getCGCount(cmp1);
CampaignMemberManager.updateContactSyncToMarketo(contactIds);
CampaignMemberManager.createMemberStatus(campaignMap, isInsert);
Campaign  cmpFormula = [SELECT System_Control_Group_Count__c,Control_Group_Percentage__c,Control_Group_Size__c, Control_Group_Count__c FROM Campaign WHERE Id = :cmp1.Id]; 
CampaignMemberManager.confirmControlGroupCount(cmpFormula);

     test.stoptest();
} 
}
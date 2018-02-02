@istest
public class CampaignProcess_AddMember_Test{
 public static testmethod void CampaignProces(){
  list<Transaction__c>  listtransaction = new list<Transaction__c>();
   campaign cmp = marketingDataUtils.CreateCampaign();
   Lead led = marketingDataUtils.createleads();
   Transaction__c Trans = marketingDataUtils.createTransaction(cmp.id,led.id);
    listtransaction.add(Trans);
       Decimal camplistOrderId = 72763;
      Database.BatchableContext BC;
      Database.QueryLocator QL;
          CampaignProcess_AddMember CampaignPro = new CampaignProcess_AddMember(cmp.id,camplistOrderId);
           CampaignPro.start(BC);
           CampaignPro.execute(BC,listtransaction);
           CampaignPro.finish(BC);
       }
 public static testmethod void CampaignProces1(){
  list<Transaction__c>  listtransaction = new list<Transaction__c>();
Campaign cmp = new Campaign();
            cmp.Name='NewTestCampaign';
            cmp.Service_Line__c='Burn';
            cmp.Audience_Region__c='Texas';
            cmp.Channel__c='Direct Mail';
            cmp.Add_Member_Status__c = 'Order Placed';
            cmp.Current_count__c = 3;
            cmp.Missing_Contact_Count__c = 3;
              insert cmp; 
     Account acc1 = new Account();
                acc1.Name='testcon';
                 insert acc1;
         
        contact cont = new Contact();
               cont.AccountId = acc1.id;
               cont.LastName='vaishali';
              
                insert cont;
     CampaignMember campaignmem = new CampaignMember();
               campaignmem.CampaignId = cmp.Id;
               campaignmem.ContactId =Cont.id;
               campaignmem.Control_Group__c = true;
                 insert campaignmem;
               //campaignmem.Contact_Identifier__c = Cont.id;
     Manage_Campaign_Activation_Process__c  Activationprocess = new Manage_Campaign_Activation_Process__c();
        Activationprocess.Activate_Process__c = True;
        Activationprocess.Name='EmailOnCampaignActivationFailure';
          insert Activationprocess;
Tenet_Data_Configuration__c tenet = new Tenet_Data_Configuration__c();
          tenet.Static_Value__c='9900';
          tenet.Name='Page Size';
            insert tenet;                 
    
   Lead led = marketingDataUtils.createleads();
   Transaction__c Trans = marketingDataUtils.createTransaction(cmp.id,led.id);
    listtransaction.add(Trans);
       Decimal camplistOrderId = 72763;
      Database.BatchableContext BC;
      Database.QueryLocator QL;
          CampaignProcess_AddMember CampaignPro = new CampaignProcess_AddMember(cmp.id,camplistOrderId);
           CampaignPro.finish(BC);
           system.debug('(((('+CampaignPro);
 }
    public static testmethod void CampaignProces2(){
  list<Transaction__c>  listtransaction = new list<Transaction__c>();
Campaign cmp = new Campaign();
            cmp.Name='NewTestCampaign';
            cmp.Service_Line__c='Burn';
            cmp.Audience_Region__c='Texas';
            cmp.Channel__c='Direct Mail';
            cmp.Add_Member_Status__c = 'Order Placed';
            cmp.Current_count__c = 3;
            cmp.Missing_Contact_Count__c = 2;
              insert cmp; 
     Account acc1 = new Account();
                acc1.Name='testcon';
                 insert acc1;
         
        contact cont = new Contact();
               cont.AccountId = acc1.id;
               cont.LastName='vaishali';
              
                insert cont;
     CampaignMember campaignmem = new CampaignMember();
               campaignmem.CampaignId = cmp.Id;
               campaignmem.ContactId =Cont.id;
               campaignmem.Control_Group__c = true;
                 insert campaignmem;
               //campaignmem.Contact_Identifier__c = Cont.id;
     Manage_Campaign_Activation_Process__c  Activationprocess = new Manage_Campaign_Activation_Process__c();
        Activationprocess.Activate_Process__c = True;
        Activationprocess.Name='RetryCampaignActivation';
          insert Activationprocess;
Tenet_Data_Configuration__c tenet = new Tenet_Data_Configuration__c();
          tenet.Static_Value__c='9900';
          tenet.Name='Page Size';
            insert tenet;                 
    
   Lead led = marketingDataUtils.createleads();
   Transaction__c Trans = marketingDataUtils.createTransaction(cmp.id,led.id);
    listtransaction.add(Trans);
       Decimal camplistOrderId = 72763;
      Database.BatchableContext BC;
      Database.QueryLocator QL;
          CampaignProcess_AddMember CampaignPro = new CampaignProcess_AddMember(cmp.id,camplistOrderId);
           CampaignPro.finish(BC);
           system.debug('(((('+CampaignPro);
 }
 

public static testmethod void CampaignProces3(){
  list<Transaction__c>  listtransaction = new list<Transaction__c>();
Campaign cmp = new Campaign();
            cmp.Name='NewTestCampaign';
            cmp.Service_Line__c='Burn';
            cmp.Audience_Region__c='Texas';
            cmp.Channel__c='Direct Mail';
            cmp.Add_Member_Status__c = 'Order Placed';
            cmp.Current_count__c = 3;
            cmp.Missing_Contact_Count__c = 2;
              insert cmp; 
     Account acc1 = new Account();
                acc1.Name='testcon';
                 insert acc1;
         
        contact cont = new Contact();
               cont.AccountId = acc1.id;
               cont.LastName='vaishali';
              
                insert cont;
     CampaignMember campaignmem = new CampaignMember();
               campaignmem.CampaignId = cmp.Id;
               campaignmem.ContactId =Cont.id;
               campaignmem.Control_Group__c = true;
               
                 insert campaignmem;
               //campaignmem.Contact_Identifier__c = Cont.id;
     list<Manage_Campaign_Activation_Process__c> listActivateCS = new list<Manage_Campaign_Activation_Process__c>();
     listActivateCS.add(new Manage_Campaign_Activation_Process__c(Activate_Process__c = True,Name='EmailOnCampaignActivationSuccess'));
     listActivateCS.add(new Manage_Campaign_Activation_Process__c(Activate_Process__c = False,Name='RetryCampaignActivation'));
     insert listActivateCS;
     Tenet_Data_Configuration__c tenet = new Tenet_Data_Configuration__c();
          tenet.Static_Value__c='9900';
          tenet.Name='Page Size';
            insert tenet;                 
    
   Lead led = marketingDataUtils.createleads();
   Transaction__c Trans = marketingDataUtils.createTransaction(cmp.id,led.id);
   
    listtransaction.add(Trans);
       Decimal camplistOrderId = 72763;
      Database.BatchableContext BC;
      Database.QueryLocator QL;
          CampaignProcess_AddMember CampaignPro = new CampaignProcess_AddMember(cmp.id,camplistOrderId);
           CampaignPro.finish(BC);
           system.debug('(((('+CampaignPro);
 }
 
public static testmethod void CampaignProces4(){
  list<Transaction__c>  listtransaction = new list<Transaction__c>();
Campaign cmp = new Campaign();
            cmp.Name='NewTestCampaign';
            cmp.Service_Line__c='Burn';
            cmp.Audience_Region__c='Texas';
            cmp.Channel__c='Direct Mail';
            cmp.Add_Member_Status__c = 'Order Placed';
            cmp.Current_count__c = 3;
            cmp.Missing_Contact_Count__c = 2;
              insert cmp; 
              Campaign cmp2 = new Campaign();
            cmp2.Name='NewTestCampaign';
            cmp2.Service_Line__c='Burn';
            cmp2.Audience_Region__c='Texas';
            cmp2.Channel__c='Direct Mail';
            cmp2.Add_Member_Status__c = 'Order Placed';
            cmp2.Current_count__c = 3;
            cmp2.Missing_Contact_Count__c = 2;
            cmp2.CRM_ParentSegmentedCampaign__c = cmp.id;
              insert cmp2; 
              
     Account acc1 = new Account();
                acc1.Name='testcon';
                 insert acc1;
         
        contact cont = new Contact();
               cont.AccountId = acc1.id;
               cont.LastName='vaishali';
              
                insert cont;
     CampaignMember campaignmem = new CampaignMember();
               campaignmem.CampaignId = cmp.Id;
               campaignmem.ContactId =Cont.id;
               campaignmem.Control_Group__c = false;
               
                 insert campaignmem;
               //campaignmem.Contact_Identifier__c = Cont.id;
     Manage_Campaign_Activation_Process__c  Activationprocess = new Manage_Campaign_Activation_Process__c();
        Activationprocess.Activate_Process__c = true;
        Activationprocess.Name='RetryCampaignActivation';
          insert Activationprocess;
Tenet_Data_Configuration__c tenet = new Tenet_Data_Configuration__c();
          tenet.Static_Value__c='';
          tenet.Name='Page Size';
            insert tenet;                 
    
   Lead led = marketingDataUtils.createleads();
   Transaction__c Trans = marketingDataUtils.createTransaction(cmp.id,led.id);
    listtransaction.add(Trans);
      Decimal camplistOrderId = 0;
      Database.BatchableContext BC;
      Database.QueryLocator QL;
      
            Transaction__c t = new Transaction__c();
            t.Campaign__c= cmp2.id;
            t.Campaign_Member_Status__c = 'Ready to Process';
            t.Type__c = 'GetOrderData';
            t.WM_List_Order_Id__c = camplistOrderId;
            insert t; 
           CampaignProcess_AddMember CampaignPro = new CampaignProcess_AddMember(cmp.id,camplistOrderId);
           CampaignPro.finish(BC);
           string emailAddress;
           CampaignPro.emailAddress='Good@luck.com';
           CampaignProcess_AddMember CampaignProSegmented = new CampaignProcess_AddMember(cmp.id,true);
           CampaignProSegmented.isSegmentedCampaign = true;
           CampaignProSegmented.finish(BC);
           
           system.debug('(((('+CampaignPro);
 }
 


   
}
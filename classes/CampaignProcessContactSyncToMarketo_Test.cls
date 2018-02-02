@istest
 public class CampaignProcessContactSyncToMarketo_Test{
  public static testmethod void CampaignProcesmethod(){
  boolean reprocessBatch=true;
  list<CampaignMember> listcmpmem = new list<CampaignMember>();
  campaign cmp = marketingDataUtils.CreateCampaign();
  contact con = marketingDataUtils.createcontact();
  
  CampaignMember mem = marketingDataUtils.createcampmember(cmp.id,con.id);
  
   listcmpmem.add(mem);
   
  Database.BatchableContext BC;
   CampaignProcess_ContactSyncToMarketo   Marketo  = new CampaignProcess_ContactSyncToMarketo(cmp.id);
    Marketo.start(BC);
    Marketo.execute(BC,listcmpmem);
    Marketo.finish(BC);
    
    }   
    
  public static testmethod void CampaignProcesmethod3(){
  
  list<CampaignMember> listcmpmem = new list<CampaignMember>();
  
  campaign cmp = marketingDataUtils.CreateCampaign();
  contact con = marketingDataUtils.createcontact();
  
  CampaignMember mem = marketingDataUtils.createcampmember(cmp.id,con.id);
   listcmpmem.add(mem);
   Tenet_Data_Configuration__c tenet = new Tenet_Data_Configuration__c();
          tenet.Static_Value__c='1';
          tenet.Name='Page Size';
            insert tenet; 
 Campaign_Member_Criteria_Group__c cmpgrp = marketingDataUtils.createCampaignmemgrp(cmp.id);
  Database.BatchableContext BC;
   CampaignProcess_ContactSyncToMarketo   Marketo  = new CampaignProcess_ContactSyncToMarketo(cmp.id);
    Marketo.reprocessBatch = true;
    Marketo.start(BC);
    Marketo.execute(BC,listcmpmem);
    Marketo.finish(BC);
    
    }   
    
  public static testmethod void CampaignProcesmethod7(){
  
  list<CampaignMember> listcmpmem = new list<CampaignMember>();
  
  Campaign cmp = new Campaign();
            cmp.Name='NewTestCampaign';
            cmp.Service_Line__c='Burn';
            cmp.Audience_Region__c='Detroit';
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
               cont.LastName='jjki';
              
                insert cont;
     CampaignMember campaignmem = new CampaignMember();
               campaignmem.CampaignId = cmp.Id;
               campaignmem.ContactId =Cont.id;
               campaignmem.Control_Group__c = false;
               //campaignmem.Contact_Identifier__c = Cont.id;
                 insert campaignmem;
    
Tenet_Data_Configuration__c tenet = new Tenet_Data_Configuration__c();
          tenet.Static_Value__c='9900';
          tenet.Name='Page Size';
            insert tenet;              
   Lead led = marketingDataUtils.createleads();
  
  
 Campaign_Member_Criteria_Group__c cmpgrp = marketingDataUtils.createCampaignmemgrp(cmp.id);
  Database.BatchableContext BC;
   CampaignProcess_ContactSyncToMarketo   Marketo  = new CampaignProcess_ContactSyncToMarketo(cmp.id);
    Marketo.reprocessBatch = false;
    Marketo.start(BC);
    Marketo.execute(BC,listcmpmem);
    Marketo.finish(BC);
    
    }     
 }
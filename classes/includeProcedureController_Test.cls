@istest
public class  includeProcedureController_Test
{
    
   public static testmethod void procedure()
 {
           boolean selectAll=false;
           boolean flag = true;
           string encounterid=null;
           set<Integer> VisitedPage=Null;
     
         
          
            Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';
             
              insert newCampaign;
              

          Procedures__c proc1 = new Procedures__c();
          proc1.Type_Of_Procedure__c='ICD10';
          proc1.LongDescription__c='Fragmentation in Epidural Space, Open Approach';
          proc1.Code__c='00F30ZZ';
           insert proc1;   
           
           Procedure_Information__c procInfo = new Procedure_Information__c();
           procInfo.Campaign__c = newCampaign.Id;
           procInfo.ICD_CPT_Procedures__c = proc1.Id;
              insert procInfo;   
              
    
        
 includeProcedureController.WrapperClassForProcedure wrap = new includeProcedureController.WrapperClassForProcedure(proc1,flag);
     
        System.debug('@@@@@procInfo'+procInfo);
        wrap.index=2;
        wrap.isSelected=true;
        
       
    pagereference testpage = new pagereference ('/apex/IncludeProcedure');
    Test.setcurrentPage(testPage);
    ApexPages.currentPage().getParameters().put('id',newCampaign.id);          
    ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);

    includeProcedureController proc = new includeProcedureController(sc) ; 
    
           proc.TypeOfPro='ICD10';
           proc.IncludeProCode='ProcCode';
           proc.IPDis='Fragmentation in Epidural Space, Open Approach';
           proc.IPCodes='00F30ZZ'; 
           proc.size=2; 
           proc.selectedtypeofProcedures='ICD10';
           System.debug('proc@@@@@@'+proc);
              proc.showSearchResult=True;
              proc.selectAll=true;
              proc.searchIncludeProcedure();
              proc.getsearchResult();
              proc.selectAll=true;
              proc.campId='Campgn12';
              proc.showSearchResult=True;
              proc.noOfRecords=10;
              proc.selectAll=true;
              proc.saveProcedure();
              proc.cancel();
              proc.First();
              proc.last();
              proc.previous();
              proc.next();
              proc.quickSave();
              
 }
public static testmethod void testprocedure()
 {
           boolean selectAll=false;
           boolean flag = true;
           string encounterid=null;
           boolean masterSelectAll=true;
           boolean hasGeoRecordsAlready=true;
           
           
            Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
     
            User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser00@testorg.com',CommunityNickname='Nick');
              insert u;
          
            Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.OwnerId=u.id;
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';
             
              insert newCampaign;
          
            Procedures__c proc1 = new Procedures__c();
            proc1.Type_Of_Procedure__c='ICD10';
            proc1.LongDescription__c='Fragmentation in Epidural Space, Open Approach';
            proc1.Code__c='00F30ZZ';
             insert proc1;  
           
            Procedure_Information__c procInfo = new Procedure_Information__c();
            procInfo.Campaign__c = newCampaign.Id;
            procInfo.ICD_CPT_Procedures__c = proc1.Id;
              insert procInfo;   
              
  includeProcedureController.WrapperClassForProcedure wrap = new includeProcedureController.WrapperClassForProcedure(proc1,flag);
 
    System.debug('@@@@@procInfo'+procInfo);
    wrap.index=2;
    wrap.isSelected=true;  
    pagereference testpage = new pagereference ('/apex/IncludeProcedure');
    Test.setcurrentPage(testPage);
    ApexPages.currentPage().getParameters().put('id',newCampaign.id);          
    ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
    includeProcedureController proc2 = new includeProcedureController(sc) ; 
     
           proc2.TypeOfPro='ICD10';
           proc2.IPDis='Fragmentation in Epidural Space, Open Approach';
           proc2.IPCodes='00F30ZZ'; 
           proc2.size=2; 
           proc2.selectedtypeofProcedures='ICD10';
           System.debug('proc@@@@@@'+proc2);
            proc2.noOfRecords=10;
            proc2.searchIncludeProcedure();
            proc2.showSearchResult=True;    
            proc2.campId='Campgn12';
            proc2.getsearchResult();   
            proc2.cancel();
            proc2.First();
            proc2.last();
            proc2.previous();
            proc2.next();
            proc2.selectAll=true;
            proc2.masterSelectAll=True;
            proc2.saveProcedure();
            proc2.quickSave();
  }    
  
  public static testmethod void testprocedure3()
 {
           boolean selectAll=false;
           boolean masterSelectAll=true;
           string encounterid=null;
           boolean hasGeoRecordsAlready=true;
            
            Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
     
            User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser00@testorg.com',CommunityNickname='Nick');
              insert u;
          
            Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.OwnerId=u.id;
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';
             
              insert newCampaign;
          
            Procedures__c proc1 = new Procedures__c();
            proc1.Type_Of_Procedure__c='ICD10';
            proc1.LongDescription__c='Fragmentation in Epidural Space, Open Approach';
            proc1.Code__c='00F30ZZ';
             insert proc1;   
           
            Procedure_Information__c procInfo = new Procedure_Information__c();
            procInfo.Campaign__c = newCampaign.Id;
            procInfo.ICD_CPT_Procedures__c = proc1.Id;
              insert procInfo;   
              
  boolean flag = true;
        
  includeProcedureController.WrapperClassForProcedure wrap = new includeProcedureController.WrapperClassForProcedure(proc1,flag);
 
        System.debug('@@@@@procInfo'+procInfo);
        wrap.index=2;
        wrap.isSelected=false;
     
     pagereference testpage = new pagereference ('/apex/IncludeProcedure');
     Test.setcurrentPage(testPage);
    
    ApexPages.currentPage().getParameters().put('id',newCampaign.id);               
    ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
    includeProcedureController proc3 = new includeProcedureController(sc) ; 
           
           proc3.TypeOfPro='ICD10';
           proc3.IPDis='Fragmentation in Epidural Space, Open Approach';
           proc3.IPCodes='00F30ZZ'; 
           proc3.size=0; 
           proc3.selectedtypeofProcedures='';
           System.debug('proc@@@@@@'+proc3);
            proc3.noOfRecords=10;
            proc3.searchIncludeProcedure();
            proc3.showSearchResult=True;  
            proc3.campId='Campgn12';
            proc3.getsearchResult();
            proc3.noOfRecords=10; 
            proc3.cancel();
            proc3.First();
            proc3.last();
            proc3.previous();
            proc3.next();
            proc3.selectAll=true;
            proc3.masterSelectAll=false;
            proc3.saveProcedure();
            proc3.quickSave();
              
 }     

public static testmethod void procedurenew()
 {
            boolean flag = true;
            boolean SelectAll= False;
           
            Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
     
            User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser00@testorg.com',CommunityNickname='Nick');
              insert u;
          
            Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.OwnerId=u.id;
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';
             
              insert newCampaign;
              

            Procedures__c proc1 = new Procedures__c();
            proc1.Type_Of_Procedure__c='ICD10';
            proc1.LongDescription__c='Fragmentation in Epidural Space, Open Approach';
            proc1.Code__c='00F30ZZ';
             insert proc1;   
           
            Procedure_Information__c procInfo = new Procedure_Information__c();
            procInfo.Campaign__c = newCampaign.Id;
            procInfo.ICD_CPT_Procedures__c = proc1.Id;
              insert procInfo;   
  
 includeProcedureController.WrapperClassForProcedure wrap = new includeProcedureController.WrapperClassForProcedure(proc1,flag);
 
        System.debug('@@@@@procInfo'+procInfo);
        wrap.index=2;
        wrap.isSelected=true;
       
    pagereference testpage = new pagereference ('/apex/IncludeProcedure');
    Test.setcurrentPage(testPage);
    ApexPages.currentPage().getParameters().put('id',newCampaign.id);               
    ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
    includeProcedureController proc = new includeProcedureController(sc) ; 
    
           proc.TypeOfPro='ICD10';
           proc.IncludeProCode='ProcCode';
           proc.IPDis='Fragmentation in Epidural Space, Open Approach';
           proc.IPCodes='00F30ZZ'; 
           proc.size=2; 
           proc.selectedtypeofProcedures='ICD10';
           System.debug('proc@@@@@@'+proc);
              proc.searchIncludeProcedure(); 
              proc.getsearchResult();
              proc.showSearchResult=True;
              proc.selectAll=False;
              proc.masterSelectAll=True;
              proc.saveProcedure();
              proc.quickSave();
              proc.cancel();
              proc.First();
              proc.last();
              proc.previous();
              proc.next();
           
    } 
  
 public static testmethod void testprocedure2()
 {
           boolean selectAll=false;
           string encounterid=null;
           boolean masterSelectAll=true; 
           boolean hasGeoRecordsAlready=true;
          
            Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
     
            User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser00@testorg.com',CommunityNickname='Nick');
              insert u;
          
            Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.OwnerId=u.id;
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';
             
              insert newCampaign;
   
            Procedures__c proc1 = new Procedures__c();
            proc1.Type_Of_Procedure__c='ICD10';
            proc1.LongDescription__c='Fragmentation in Epidural Space, Open Approach';
            proc1.Code__c='Codeee';
             insert proc1;   
           
            Procedure_Information__c procInfo = new Procedure_Information__c();
            procInfo.Campaign__c = newCampaign.Id;
            procInfo.ICD_CPT_Procedures__c = proc1.Id;
              insert procInfo;   
              
 boolean flag = true;
        
 includeProcedureController.WrapperClassForProcedure wrap = new includeProcedureController.WrapperClassForProcedure(proc1,flag);
 
    System.debug('@@@@@procInfo'+procInfo);
    wrap.index=2;
    wrap.isSelected=true;
  
    pagereference testpage = new pagereference ('/apex/IncludeProcedure');
    Test.setcurrentPage(testPage); 
    ApexPages.currentPage().getParameters().put('id',newCampaign.id);           
    ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);
    includeProcedureController proc3 = new includeProcedureController(sc) ; 
           
           proc3.TypeOfPro='ICD10';
           proc3.IncludeProCode='';
           proc3.IPDis='Fragmentation in Epidural Space, Open Approach';
           proc3.IPCodes=''; 
           proc3.size=0; 
           proc3.selectedtypeofProcedures='';
           System.debug('proc@@@@@@'+proc3);
           // proc.preparePiclistFields();
           // proc.handleExistingRecords();
              proc3.searchIncludeProcedure();
              proc3.noOfRecords=10;
              proc3.showSearchResult=false;  
              proc3.selectAll=true;
              proc3.saveProcedure();
              proc3.getsearchResult();
              proc3.campId='Campgn12';
              proc3.First();
              proc3.last();
              proc3.previous();
              proc3.next();      
              proc3.cancel();  
              proc3.quickSave();    
              
}    
     public static testmethod void procedure3()
 {
           boolean selectAll=false;
           boolean flag = false;
           string encounterid=null;
           set<Integer> VisitedPage=Null;
     
         
          
            Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';
             
              insert newCampaign;
              

          Procedures__c proc1 = new Procedures__c();
          proc1.Type_Of_Procedure__c='ICD10';
          proc1.LongDescription__c='Fragmentation in Epidural Space, Open Approach';
          proc1.Code__c='00F30ZZ';
           insert proc1;   
           
           Procedure_Information__c procInfo = new Procedure_Information__c();
           procInfo.Campaign__c = newCampaign.Id;
           procInfo.ICD_CPT_Procedures__c = proc1.Id;
              insert procInfo;   
              
    
        
 includeProcedureController.WrapperClassForProcedure wrap = new includeProcedureController.WrapperClassForProcedure(proc1,flag);
     
        System.debug('@@@@@procInfo'+procInfo);
        wrap.index=2;
        wrap.isSelected=true;
        
       
    pagereference testpage = new pagereference ('/apex/IncludeProcedure');
    Test.setcurrentPage(testPage);
    ApexPages.currentPage().getParameters().put('id',newCampaign.id);          
    ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);

    includeProcedureController proc = new includeProcedureController(sc) ; 
    
           proc.TypeOfPro='ICD10';
           proc.IncludeProCode='ProcCode';
           proc.IPDis='Fragmentation in Epidural Space, Open Approach';
           proc.IPCodes='00F30ZZ'; 
           proc.size=2; 
           proc.selectedtypeofProcedures='ICD10';
           System.debug('proc@@@@@@'+proc);
              proc.showSearchResult=True;
              proc.selectAll=true;
              proc.searchIncludeProcedure();
              proc.getsearchResult();
              proc.selectAll=true;
              proc.campId='Campgn12';
              proc.showSearchResult=True;
              proc.noOfRecords=10;
              proc.selectAll=true;
              proc.saveProcedure();
              proc.cancel();
              proc.First();
              proc.last();
              proc.previous();
              proc.next();
              proc.quickSave();
 }
 
 public static testmethod void procedure4()
 {
           boolean selectAll=false;
           boolean flag = false;
           string encounterid='encntrid';
           set<Integer> VisitedPage=Null;
           
          
            Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';
             
              insert newCampaign;
              

          Procedures__c proc1 = new Procedures__c();
          proc1.Type_Of_Procedure__c='CPT4';
          proc1.LongDescription__c='Fragmentation in Epidural Space, Open Approach';
          proc1.Code__c='00F30ZZ';
          
           insert proc1;   
           
           Procedure_Information__c procInfo = new Procedure_Information__c();
           procInfo.Campaign__c = newCampaign.Id;
           procInfo.ICD_CPT_Procedures__c = proc1.Id;
           procInfo.Exclude__c=true;
              insert procInfo;   
              
    
        
 includeProcedureController.WrapperClassForProcedure wrap = new includeProcedureController.WrapperClassForProcedure(proc1,flag);
     
        System.debug('@@@@@procInfo'+procInfo);
        wrap.index=2;
        wrap.isSelected=true;
        
       
    pagereference testpage = new pagereference ('/apex/IncludeProcedure');
    Test.setcurrentPage(testPage);
   
    ApexPages.currentPage().getParameters().put('id',newCampaign.id);          
    ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);

    includeProcedureController proc = new includeProcedureController(sc) ; 
    
           proc.TypeOfPro='CPT4';
           proc.IncludeProCode='ProcCode';
           proc.IPDis='Fragmentation in Epidural Space, Open Approach';
           proc.IPCodes=''; 
           proc.size=-10; 
           proc.exclude=false;
           proc.selectedtypeofProcedures='CPT4';
           System.debug('proc@@@@@@'+proc);
              proc.showSearchResult=false;
              proc.selectAll=true;
              proc.searchIncludeProcedure();
              proc.getsearchResult();
              proc.selectAll=true;
              proc.campId='Campgn12';
              proc.showSearchResult=false;
              proc.noOfRecords=0;
              proc.selectAll=true;
              proc.saveProcedure();
              proc.cancel();
              proc.First();
              proc.last();
              proc.previous();
              proc.next();
              proc.quickSave();
              
              
 } 
 
 public static testmethod void procedure7()
 {
           boolean selectAll=false;
           boolean flag = false;
           string encounterid='encntrid';
           set<Integer> VisitedPage=Null;
           
          
            Campaign newCampaign = new Campaign();
            newCampaign.Name='NewTestCampaign';
            newCampaign.Service_Line__c='Burn';
            newCampaign.Audience_Region__c='Texas';
            newCampaign.Channel__c='Direct Mail';
             
              insert newCampaign;
              

          Procedures__c proc1 = new Procedures__c();
          proc1.Type_Of_Procedure__c='CPT4';
          proc1.LongDescription__c='Fragmentation in Epidural Space, Open Approach';
          proc1.Code__c='00F30ZZ';
          
           insert proc1;   
           
           Procedure_Information__c procInfo = new Procedure_Information__c();
           procInfo.Campaign__c = newCampaign.Id;
           procInfo.ICD_CPT_Procedures__c = proc1.Id;
           procInfo.Exclude__c=true;
              insert procInfo;   
              
    
        
 includeProcedureController.WrapperClassForProcedure wrap = new includeProcedureController.WrapperClassForProcedure(proc1,flag);
     
        System.debug('@@@@@procInfo'+procInfo);
        wrap.index=2;
        wrap.isSelected=true;
        
       
    pagereference testpage = new pagereference ('/apex/IncludeProcedure');
    Test.setcurrentPage(testPage);
   
    ApexPages.currentPage().getParameters().put('id',newCampaign.id);          
    ApexPages.StandardController sc = new ApexPages.standardController(newCampaign);

    includeProcedureController proc = new includeProcedureController(sc) ; 
    
           proc.TypeOfPro='CPT4';
           proc.IncludeProCode='ProcCode';
           proc.IPDis='Fragmentation in Epidural Space, Open Approach';
           proc.IPCodes=''; 
           proc.size=10; 
           proc.exclude=false;
           proc.selectedtypeofProcedures='ICD10';
           System.debug('proc@@@@@@'+proc);
              
              proc.searchIncludeProcedure();
              proc.getsearchResult();
              proc.selectAll=true;
              proc.campId='Campgn12';
              proc.showSearchResult=true;
              boolean isCalloutEventTypeDelete=true;     
              proc.noOfRecords=0;
              proc.selectAll=true;
              proc.saveProcedure();
              proc.cancel();
              proc.First();
              proc.last();
              proc.previous();
              proc.next();
              proc.quickSave();
              
              
 } 
 
}
/*
    Created By : Amit Dahiya
    Created Date : September 14, 2016
    Objective : This batch will process all the campaign responses on daily basis
    
*/
global class Tenet_SyncNameMatch_Batch implements Database.Batchable<sObject>,Database.Stateful,Database.AllowsCallouts{
   global Integer unSuccessfullBatch=0;
   global final String query;
   global string sourceSystem ='';
   
   global Tenet_SyncNameMatch_Batch()
   {
        //Prepare dynamic query
        sourceSystem = 'DMC/Conifer';
        query = Tenet_NameMatch_Sync_Helper.buildQuery(Tenet_Static_Variables.requestKeyValueMap.get(Tenet_Static_Variables.XML_Tag_Mapping_Type_Request).values(),sourceSystem);
   }
   
   global Tenet_SyncNameMatch_Batch(string source)
   {
        //Prepare dynamic query
        sourceSystem = source;
        query = Tenet_NameMatch_Sync_Helper.buildQuery(Tenet_Static_Variables.requestKeyValueMap.get(Tenet_Static_Variables.XML_Tag_Mapping_Type_Request).values(),sourceSystem);
   }
   
   global Database.QueryLocator start(Database.BatchableContext BC){
      //return lead records to be processed with Wunderman
      return Database.getQueryLocator(query);
   }

   global void execute(Database.BatchableContext BC,List<sObject> scope){
      Tenet_NameMatch_Sync_Helper syncRespondentDetail = new Tenet_NameMatch_Sync_Helper();
      Lead ls=new Lead();
      try{
          for(Sobject s : scope){ 
            ls = (Lead)s;
             if(!ls.SourceSystem__c.equalsIgnoreCase('Marketo'))
                syncRespondentDetail.syncWithVendorSystem(ls);
            else if(ls.CampaignMembers.size()>0)
                syncRespondentDetail.syncWithVendorSystem(ls);
          }
      }catch(Exception ex){
        unSuccessfullBatch++;
        //Mark lead as unprocessed so that scheduler can pick this again
        syncRespondentDetail.udpateRespondent(ls,true);
        
        //create error log record
        Tenet_Exception_Handler logError = new Tenet_Exception_Handler();
        logError.creatExceptionLog(ex,ls,Tenet_Static_Variables.Error_Log_Source_NameMatch);
      }
   }

   global void finish(Database.BatchableContext BC)
   {
       If(sourceSystem!='Marketo') 
           Database.executeBatch(new Tenet_SyncNameMatch_Batch('Marketo'),1);
       //we can send email to admin after back is completed
        system.debug('***unSuccessfullBatch='+unSuccessfullBatch);
   }
}
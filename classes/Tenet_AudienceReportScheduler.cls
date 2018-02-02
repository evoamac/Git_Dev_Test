/*
    Created By : Amit Dahiya
    Created Date : November 24, 2017
    Objective : This scheduler will run on daily night and delete the Aundience Report records
    
*/
global class Tenet_AudienceReportScheduler implements Schedulable {
   global void execute(SchedulableContext sc) {
      set<string> jobStatus = new set<string>{'Holding','Queued','Processing','Preparing'};
      Id classId =[SELECT Id,Name FROM ApexClass WHERE Name = 'Campaign_AudienceReportDeleteBatch' limit 1].Id;
      if([SELECT count() FROM AsyncApexJob WHERE ApexClassId =: classId AND Status IN: jobStatus]==0){
        database.executebatch(new Campaign_AudienceReportDeleteBatch(),2000);       
      }
   }
}
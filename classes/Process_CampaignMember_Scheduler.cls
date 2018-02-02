/*
    Created By : Amit Dahiya
    Created Date : November 30, 2016
    Objective : This batch will process all the where status is Order Placed and add campaign member
    
*/
global class Process_CampaignMember_Scheduler implements Schedulable,Database.AllowsCallouts{
    integer timeInterval;
    public Process_CampaignMember_Scheduler(integer interval){
        timeInterval=interval;
    }
    public void execute(SchedulableContext sc) {
        // Re-schedule ourself to run again in "intervalMinutes" time
        DateTime now  = DateTime.now();
        DateTime nextRunTime = now.addseconds(timeInterval);
        while(DateTime.now()>=nextRunTime){
          nextRunTime=nextRunTime.addSeconds(timeInterval);
        }
        String cronString = '' + nextRunTime.second() + ' ' + nextRunTime.minute() + ' ' + 
            nextRunTime.hour() + ' ' + nextRunTime.day() + ' ' + 
            nextRunTime.month() + ' ? ' + nextRunTime.year(); 
        System.schedule(Process_CampaignMember_Scheduler.class.getName() + '-' + now, cronString, new Process_CampaignMember_Scheduler(timeInterval));
        // Abort the current job
        Id jobId = sc.getTriggerId();
        System.abortJob(jobId);     
        // Launch a batch job or call a future method to do the actual work
        //If there is a batch that is already in progress then we wont start new batch
        //Starting of defect#850 : Unable to activate campaign 
         set<string> jobStatus = new set<string>{'Holding','Queued','Processing','Preparing'};
        Id classId =[SELECT Id,Name FROM ApexClass WHERE Name = 'CampaignProcess_GetNetCount' limit 1].Id;
        if([SELECT count() FROM AsyncApexJob WHERE ApexClassId =: classId AND Status IN: jobStatus]==0){
        //Ending of defect#850
           if([SELECT count() FROM AsyncApexJob WHERE JobType='BatchApex' AND (Status = 'Processing' OR Status = 'Preparing')] < 5){ 
               Database.executeBatch(new CampaignProcess_GetNetCount(),1);
            }
        }
    }
}
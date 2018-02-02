global without sharing class WundermanSessionScheduler implements Schedulable
{
    
    public void execute(SchedulableContext sc) 
    {
        // Re-schedule ourself to run again in "intervalMinutes" time
        DateTime now  = DateTime.now();
        System.debug(' now  ' + now  );
        DateTime nextRunTime = now.addMinutes(20);
        System.debug(' nextRunTime ' + nextRunTime  );
        String cronString = '' + nextRunTime.second() + ' ' + nextRunTime.minute() + ' ' + 
            nextRunTime.hour() + ' ' + nextRunTime.day() + ' ' + 
            nextRunTime.month() + ' ? ' + nextRunTime.year(); 
            System.debug(' cronString  ' + cronString);
        System.schedule(WundermanSessionScheduler.class.getName() + '-' + now.format(), cronString, new WundermanSessionScheduler());
        // Abort the current job
        Id jobId = sc.getTriggerId();
        System.abortJob(jobId);    
         
        // call a future method to do the actual work
        
        
        getSession();
        
    }
    
    
    @future(callout=true) 
    public static void getSession()
    {
             String session;
        
             List<WundermanLogin__c> mcs = WundermanLogin__c.getall().values();
            /***************************  Get session id ****************************************/
            //https://kosmos.kbmg.com/IntellisightListAPI/com/wunderman/api/listOrder/GetSession.jsp?username=tenettest&password=tenet1test   
            String url= mcs[0].EndpointURL__c+'/'+mcs[0].GetSession__c+'?username='+mcs[0].name+'&password='+mcs[0].Password__c;
            system.debug('session id URL'+url);
            
           
            Http my_http = new Http();
            
            HttpRequest req = new HttpRequest();
            req.setEndpoint(url);
            req.setMethod('GET');
            req.setHeader('content-type', 'text/xml; charset = utf-8'); 
            
            
            HttpResponse res = my_http.send(req);
            
            DOM.Document xmlDOC = new DOM.Document(); 
            String xmlString = res.getBody();
            xmlDOC.load(xmlString); 
            
            
            System.debug(' Session id ' + xmlString);
            
            for(DOM.XMLNode aNode : xmlDOC.getRootElement().getChildElements()) 
            {
                 if(aNode.getName() == 'RESULT') 
                 { 
                     for(DOM.XMLNode bNode : aNode.getChildElements())
                     {
                         if(bNode.getName() == 'SESSION') 
                         {
                             session =bNode.getText();
                             system.debug('SESSION'+session);
                         }
                     } 
                 
                 
                 }
            }
        
          WundermanLogin__c setting = WundermanLogin__c.getOrgDefaults();
          setting.Session_Id__c = session;
          update setting;
        
        
    }
    
    
    
    
    
}
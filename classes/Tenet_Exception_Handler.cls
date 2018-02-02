/*
    Created By : Amit Dahiya
    Created Date : September 2, 2016
    Objective : This class will be used to log exception in system which will occur during Name Match sync process
*/
public class Tenet_Exception_Handler{

    public void creatExceptionLog(Exception ex, Lead respondentDetails,String source){
        //log issue in system
        Error_Log__c errorLog = new Error_Log__c();
        if(respondentDetails!=null){
            errorLog.Lead__c=respondentDetails.Id;
        }
        errorLog.Error_Line_Number__c=ex.getLineNumber();
        errorLog.Error_Description__c=ex.getMessage();
        errorLog.Error_Source__c=source;
        errorLog.Error_Type__c=ex.getTypeName();
        errorLog.Stack_Trace__c=ex.getStackTraceString();
        errorLog.Opened_Date_Time__c=DateTime.Now();
        
        insert errorLog;
        
    }
	public void creatExceptionLog(HttpResponse ex, Lead respondentDetails,String source){
        //log issue in system
        Error_Log__c errorLog = new Error_Log__c();
        if(respondentDetails!=null){
            errorLog.Lead__c=respondentDetails.Id;
        }
        //errorLog.Error_Line_Number__c=ex.getLineNumber();
        if(ex.getBody().length()>32768)
            errorLog.Error_Description__c=ex.getBody().substring(0, 32767);
        else
            errorLog.Error_Description__c=ex.getBody();
        errorLog.Error_Source__c=source;
        errorLog.Error_Type__c='Issue In Response';
        errorLog.Stack_Trace__c='Response Status Code: '+ex.getStatusCode();
        errorLog.Opened_Date_Time__c=DateTime.Now();
        
        insert errorLog;
        
    }
}
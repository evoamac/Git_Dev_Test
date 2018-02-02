/*
    Created By : Amit Dahiya
    Created Date : September 1, 2016
    Objective : This class will be used to define static and constant variables, these variables will be used in Name Match implementation
*/
public class Tenet_Static_Variables {
    
    //Request XML Variables
    public static final String XML_REQUEST_START_TAG='<submitMessageRequestObject>';  
    public static final String XML_REQUEST_SECURITY_START_TAG='<security>';
    public static final String XML_REQUEST_SECURITY_END_TAG='</security>';
    public static final String XML_REQUEST_USERNAME_START_TAG='<username>';
    public static final String XML_REQUEST_USERNAME_END_TAG='</username>';
    public static final String XML_REQUEST_ORDERID_START_TAG='<orderId>';
    public static final String XML_REQUEST_ORDERID_END_TAG='</orderId>';
    public static final String XML_REQUEST_SECURITY_TOKEN_START_TAG='<securityToken>';
    public static final String XML_REQUEST_SECURITY_TOKEN_END_TAG='</securityToken>';
    public static final String XML_REQUEST_ATTRIBUTES_START_TAG='<attributes>';
    public static final String XML_REQUEST_ATTRIBUTES_END_TAG='</attributes>';
    public static final String XML_REQUEST_ENTRY_START_TAG='<entry>';
    public static final String XML_REQUEST_ENTRY_END_TAG='</entry>';
    public static final String XML_REQUEST_KEY_START_TAG='<key>';
    public static final String XML_REQUEST_KEY_END_TAG='</key>';
    public static final String XML_REQUEST_VALUE_START_TAG='<value>';
    public static final String XML_REQUEST_VALUE_END_TAG='</value>';
    public static final String XML_REQUEST_MESSAGE_TYPE_START_TAG='<messageTypeCode>';
    public static final String XML_REQUEST_MESSAGE_TYPE_END_TAG='</messageTypeCode>';
    public static final String XML_REQUEST_END_TAG='</submitMessageRequestObject>';
    public static final String XML_REQUEST_KEY_DOB_TAG='DOB';
    
    //Variables for custom setting key fields
    public static final String XML_CUSTOM_SETTING_MESSAGE_TYPE_VALUE='Message Type Code';
    public static final String XML_CUSTOM_SETTING_ORDERID_VALUE='Order Id';
    public static final String XML_CUSTOM_SETTING_SECURITY_TOKEN_VALUE='Security Token';
    public static final String XML_CUSTOM_SETTING_USERNAME_VALUE='Username';
    public static final String XML_CUSTOM_SETTING_END_POINT_VALUE='End Point';
    public static final String CONVERT_LEAD_DEFAULT_ACCOUNT_ID='Account Id';
    
    //Response xml variables
    public static final String XML_RESPONSE_RESPONSE_CODE_START_TAG='<responseCode>';
    public static final String XML_RESPONSE_RESPONSE_CODE_END_TAG='</responseCode>';
    public static final String XML_RESPONSE_NEW_CONTACT_IDENTIFIER_TAG='value';
    public static final String XML_RESPONSE_NEW_CONTACT_IDENTIFIER_VALUE='1';
    public static final String XML_RESPONSE_KEY_DOB_TAG='dob';
    public static final String XML_RESPONSE_KEY_WID_TAG='id';
    
    //xml tag mappign type picklist field value
    public static final String XML_Tag_Mapping_Type_Request='Request';
    public static final String XML_Tag_Mapping_Type_Response='Response';
    
    //Picklist field variables
    public static final String Error_Log_Source_NameMatch='Name Match';
    public static final String Error_Log_Source_QueryAPI='Query API Builder';
    
    //Wunderman Query API variables
    public static final String Order_Delivery_Status='DLVD.NO.CHRG';
    public static final String Query_API_Page_Size='Page Size';
    public static final String Query_API_Pagination_RestAPI_EndPoint='Pagination Rest API Endpoint';
    public static final String Campaign_Member_Suppression_Bad_Debt = 'Bad Debt';
    public static final String Campaign_Member_Suppression_Minor = 'Minor';
    public static string xmlRequest;
    public static string xmlResponse;
    public static integer suppressedCampaignMember=0;  
    //Marketo USer Id 
    public static final String Marketo_User_Id='Marketo User Id';
    
    //Campaign Activation Process Control Variables
    public static final String campaignFaliureEmail='EmailOnCampaignActivationFailure';
    public static final String campaignSuccessEmail='EmailOnCampaignActivationSuccess';
    public static final String reProcessCampaignMembers='RetryCampaignActivation';
    
    //Reference Data Variables
    public static final String Campaign_Ownership_Region='Region';
    public static final String Campaign_Ownership_Market='Market';
    public static final String Campaign_Ownership_Hospital='Hospital';
    
    //Wunderman access credentials and xml request static data, will be used in preparing requet xml 
    public static map<String,Tenet_Data_Configuration__c> tenetDataConfigSetting{
        get{
            if(tenetDataConfigSetting== null){
                tenetDataConfigSetting = Tenet_Data_Configuration__c.getAll();
            }
                
            return tenetDataConfigSetting;
        }
         
        set;
    }
    
    //Control Campaing Activation Process custom setting
    public static map<String,Manage_Campaign_Activation_Process__c> manageCampaignActivation{
        get{
            if(manageCampaignActivation== null){
                manageCampaignActivation = Manage_Campaign_Activation_Process__c.getAll();
            }
                
            return manageCampaignActivation;
        }
         
        set;
    }
    
    //returns request xml key value pair for respondent detail
    public static map<String,map<String,String>> requestKeyValueMap{
        get{
            //map of map of request/respone and tag key value 
            map<String,map<String,String>> keyValueMap = new map<String,map<String,String>>();
            for(XML_Tag_Mapping__c tagMap :[select id,name,XML_Tag__c,XML_Tag_Value__c,XML_Type__c from XML_Tag_Mapping__c]){
                if(!keyValueMap.containsKey(tagMap.XML_Type__c)){
                    keyValueMap.put(tagMap.XML_Type__c,new map<string,string>());
                    keyValueMap.get(tagMap.XML_Type__c).put(tagMap.XML_Tag__c,tagMap.XML_Tag_Value__c);
                }else
                    keyValueMap.get(tagMap.XML_Type__c).put(tagMap.XML_Tag__c,tagMap.XML_Tag_Value__c);
            }
            
            return keyValueMap;
        }
        
        set;
    }
    
   //Starting of defect#798:Net counts did not complete being calculated. SFDC suspected timeout after 2 minutes and did a manual process to restart the job. 

    //Active Job verification variables
    public static final List<String> SCHEDULER_STATE_LIST = new List<String>{'WAITING','ACQUIRED','EXECUTING'};
    public static final string WUNDERMAN_SESSION_SCHEDULER = 'WundermanSessionScheduler';
    public static final string WUNDERMAN_NET_COUNT_SCHEDULER = 'Process_CampaignMember_Scheduler';
    public static Boolean checkActiveJob(String schedulerName){        
        schedulerName +='%';    
        List<CronJobDetail> existingJobs = [SELECT Id,JobType,Name FROM CronJobDetail where name like: schedulerName];
        Boolean isActive=false;
        if(existingJobs.size()>0){
            List<CronTrigger> activeJobsList = [Select id from CronTrigger Where State IN :Tenet_Static_Variables.SCHEDULER_STATE_LIST AND CronJobDetailId IN :existingJobs];
            if(activeJobsList!=null && !activeJobsList.isEmpty()){
                isActive=true;  
            }      
        }
        
        return isActive;
    }
    //Ending of defect#798
}
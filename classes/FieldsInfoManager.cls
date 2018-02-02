Public class FieldsInfoManager {
    // Common method to get the fields info  for insert/update/delete operation  
  public static Map<String, Map<String, String>> GetFieldsInfoInsert (String objectName, sObject oldobject,  sObject newObject) {
      Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
      Schema.SObjectType leadSchema = schemaMap.get(objectName);
      Map<String, Schema.SObjectField> fieldMap = leadSchema.getDescribe().fields.getMap();
      Map<String, Map<String, String>> mapApiNameswithValues = new Map<String, Map<String, String>>  ();
      Map<String, String> mapcriteriasinsert = new  Map<String, String> ();      
      Map<String, String> mapcriteriasupdate = new  Map<String, String> ();
      Map<String, String> mapcriteriasdelete = new  Map<String, String> ();
      
      for (Schema.SObjectField f : fieldMap.values()) { 
          Schema.DescribeFieldResult d = f.getDescribe(); 
          if (d.isCustom() && d.getName()!='Campaign__c' && d.getName()!='Birthdate__c'  && d.getName()!='DOBFrom_UI__c' && d.getName()!='DOBTo_UI__c' && d.getName()!='AgeTo_UI__c' && d.getName()!='AgeFrom_UI__c' && d.getName()!='To_discharge_date_encounter__c' && d.getName()!='Discharge_Date_encounter__c' && d.getName()!='Preffered_Hospital__c'
           && d.getName()!='Discharge_Date__c' && d.getName()!='Discharge_Date_To__c' && d.getName()!='Model_1_from__c' && d.getName()!='Model_1_to__c' && d.getName()!= 'to_1__c' && d.getName()!='Last_Discharge_Date_From_UI__c' && d.getName()!='Last_Discharge_Date_To_UI__c'
           && d.getName()!='Model_2_from__c' && d.getName()!='Model_2_to__c' && d.getName()!='Model_3_from__c' && d.getName()!='Model_3_to__c' && d.getName()!='Model_4_from__c'
           && d.getName()!='Model_4_to__c' && d.getName()!='Model_5_from__c' && d.getName()!='Model_5_to__c' && d.getName()!='Model_6_from__c' && d.getName()!='Model_6_to__c' // Added for new Model Requirement
           && d.getName()!='Model_7_from__c' && d.getName()!='Model_7_to__c' && d.getName()!='Model_8_from__c' && d.getName()!='Model_8_to__c' // Added for new Model Requirement
           && d.getName()!='Model_9_from__c' && d.getName()!='Model_9_to__c' // Added for new Model CRM 270 req.
           && d.getName()!='Number_of_Persons_in_HH__c'  && d.getName()!='to_Number_of_Persons_in_HH__c'  && d.getName()!= 'Number_of_Adults_in_HH__c' 
           && d.getName()!= 'to_Number_of_Adults_in_HH__c' && d.getName()!='Number_of_Children__c' && d.getName()!='to_Number_of_Children__c' 
           && d.getName()!='Est_Discretionary_Income_Percent__c' && d.getName()!='Est_Discretionary_Income_Percent_to__c'
           && d.getName()!='Number_of_ER_Encounters__c' && d.getName()!='Number_of_ER_Encounters_to__c'
           && d.getName()!='Health_Index_Manage_Illness_Condition_Fr__c' && d.getName()!='Health_Index_Illness_or_Condition_To__c' && d.getName()!='Health_Index_Manage_Bus_of_Health__c' && d.getName()!='Number_of_ER_Encounters__c'
           && d.getName()!='Health_Index_Manage_Bus_of_Health_To__c' && d.getName()!='Health_Index_Manage_Health_From__c' && d.getName()!='Health_Index_Manage_Health_To__c' && d.getName()!='Health_Index_Wear_Dev_to_Manage_Health__c'
           && d.getName()!='Health_Index_Wear_Dev_to_Manage_Health_T__c' && d.getName()!='Health_Ins_Direct_Pay_Index_From__c' && d.getName()!='Health_Ins_Direct_Pay_Index_To__c' && d.getName()!='Health_Ins_Engagement_Index_From__c'
           && d.getName()!='Health_Ins_Engagement_Index_To__c' && d.getName()!='Health_Ins_Influence_Index_From__c' && d.getName()!='Health_Ins_Influence_Index_To__c' && d.getName()!='Health_Ins_Prem_Tolerance_Index__c'
           && d.getName()!='Health_Ins_Prem_Tolerance_Index_to__c' && d.getName()!='Medicare_Supplement_Ins_Rspnder_Idx_from__c' && d.getName()!='Medicare_Supplement_Ins_Rspnder_Idx_to__c' && d.getName()!='Uninsured_Index__c'
           && d.getName()!='Uninsured_Index_to__c'  && d.getName()!='Move_Activity_in_Months__c'  && d.getName()!='CRM_SelectedHospitalCodes__c' && d.getName()!='CRM_SelectedPreferedHospitalCodes__c') {
              System.debug('**********oldone******'+String.valueOf(oldobject.get(d.getName())));
              System.debug('**********newone******'+String.valueOf(newObject.get(d.getName())));
             
              String value = String.valueOf(newObject.get(d.getName()));
              
             
        
              if((String.valueOf(oldobject.get(d.getName()))==null &&  String.valueOf(newObject.get(d.getName()))!=null && String.valueOf(newObject.get(d.getName()))!='false' && String.valueOf(newObject.get(d.getName()))!='Everyone' && String.valueOf(newObject.get(d.getName()))!='All'  && String.valueOf(newObject.get(d.getName()))!='Any')// Added for Audience Selection criteria story (condition for any)- birthMonth
                  || (String.valueOf(oldobject.get(d.getName()))=='false' && String.valueOf(newObject.get(d.getName()))== 'true') ) {
                    
                   System.debug('*********valuefirst*****'+value);                          
                   if(String.valueOf(d.getType()) == 'BOOLEAN') {
                        if(value == 'true') value = '1';
                        else if(value == 'false') value = '0';
                   }                      
                  mapcriteriasinsert.put(d.getName(),value);
                  mapApiNameswithValues.put('Insert',mapcriteriasinsert);
              }
              else if((String.valueOf(oldobject.get(d.getName()))!=null  &&  String.valueOf(oldobject.get(d.getName()))=='All' &&  String.valueOf(newObject.get(d.getName()))!=null &&  String.valueOf(newObject.get(d.getName()))!='All')) 
              {
              System.debug('*********Insert for All*****');  
                  mapcriteriasinsert.put(d.getName(),value);
                  mapApiNameswithValues.put('Insert',mapcriteriasinsert);
              }
                        
              else if((String.valueOf(oldobject.get(d.getName()))!=null && String.valueOf(oldobject.get(d.getName()))=='Everyone' &&  String.valueOf(newObject.get(d.getName()))!=null && String.valueOf(newObject.get(d.getName()))!='Everyone')) 
              {
                  mapcriteriasinsert.put(d.getName(),value);
                  mapApiNameswithValues.put('Insert',mapcriteriasinsert);
              }
                 // Added for Audience Selection criteria story - BirthMonth
              else if((String.valueOf(oldobject.get(d.getName()))!=null && String.valueOf(oldobject.get(d.getName()))=='Any' &&  String.valueOf(newObject.get(d.getName()))!=null && String.valueOf(newObject.get(d.getName()))!='Any')) 
              {
                  mapcriteriasinsert.put(d.getName(),value);
                  mapApiNameswithValues.put('Insert',mapcriteriasinsert);
              }
              // end of Added for Audience Selection criteria story-birthMonth
              
              else if(String.valueOf(d.getType())!='BOOLEAN' && String.valueOf(oldobject.get(d.getName()))!= String.valueOf(newObject.get(d.getName())) && String.valueOf(oldobject.get(d.getName()))!=null && 
                      String.valueOf(oldobject.get(d.getName()))!='Everyone' && String.valueOf(newObject.get(d.getName()))!=null && String.valueOf(newObject.get(d.getName()))!='Everyone' &&
                      String.valueOf(oldobject.get(d.getName()))!='All' && String.valueOf(newObject.get(d.getName()))!='All'&& String.valueOf(newObject.get(d.getName()))!='Any') // Added for Audience Selection criteria story birthMonth 
                  {
                  mapcriteriasupdate.put(d.getName(),value);
                  mapApiNameswithValues.put('Update',mapcriteriasupdate);
              }
              else if((String.valueOf(oldobject.get(d.getName()))!=null && String.valueOf(newObject.get(d.getName()))==null) || (String.valueOf(oldobject.get(d.getName()))=='true' && String.valueOf(newObject.get(d.getName()))== 'false')) {
                  mapcriteriasdelete.put(d.getName(),value);
                  mapApiNameswithValues.put('Delete',mapcriteriasdelete);
              }
              else if((String.valueOf(oldobject.get(d.getName()))!=null && String.valueOf(newObject.get(d.getName()))!=null && String.valueOf(newObject.get(d.getName()))=='Everyone' && String.valueOf(oldObject.get(d.getName()))!='Everyone')) {
                  mapcriteriasdelete.put(d.getName(),value);
                  mapApiNameswithValues.put('Delete',mapcriteriasdelete);
              }
              else if((String.valueOf(oldobject.get(d.getName()))!=null && String.valueOf(newObject.get(d.getName()))!=null && String.valueOf(newObject.get(d.getName()))=='All' && String.valueOf(oldObject.get(d.getName()))!='All')) {
                  mapcriteriasdelete.put(d.getName(),value);
                  mapApiNameswithValues.put('Delete',mapcriteriasdelete);
              }
               // Added for Audience Selection criteria story birthMonth
              else if((String.valueOf(oldobject.get(d.getName()))!=null && String.valueOf(newObject.get(d.getName()))!=null && String.valueOf(newObject.get(d.getName()))=='Any' && String.valueOf(oldObject.get(d.getName()))!='Any')) {
                  mapcriteriasdelete.put(d.getName(),value);
                  mapApiNameswithValues.put('Delete',mapcriteriasdelete);
              }
              // end of Added for Audience Selection criteria story birthMonth
            
      } 
      System.debug('**********FieldiNfoManager.mapApiNameswithValues ******'+mapApiNameswithValues );
      
      
    

      
    } 
    return mapApiNameswithValues ;
 }
 
  public static Map<String, Map<String, String>> GetFieldsInfoMemberType (String oldvalue,  String newvalue) {
      Map<String, String> mapcriteriasupdate = new  Map<String, String> ();
      Map<String, String> mapcriteriasdelete = new  Map<String, String> ();
      Map<String, String> mapcriteriasinsert = new  Map<String, String> ();
      Map<String, Map<String, String>> mapApiNameswithValues = new Map<String, Map<String, String>>  ();
     if(oldvalue!=newvalue) {
          mapcriteriasupdate.put('Member_Types__c',newvalue);
          mapApiNameswithValues.put('Update',mapcriteriasupdate);
      }
      return mapApiNameswithValues;
  
  }


}
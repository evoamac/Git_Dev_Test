global class WundermanAPIConnector
{   

    public static list<Transaction__c> transactions = new list<Transaction__c>();
     
    private static string callMethod(string methodName, string parameters)
    {
        List<WundermanLogin__c> cs = WundermanLogin__c.getall().values(); 
        string endpointURL = cs[0].EndpointURL__c + '/' + methodName + '.jsp?username=' + cs[0].name + '&session=' + cs[0].Session_Id__c + '&' + parameters;
        system.debug('EndpointURL: ' + endpointURL);
        Tenet_Static_Variables.xmlRequest = endpointURL;
        system.debug('Tenet_Static_Variables.xmlRequest: ' + Tenet_Static_Variables.xmlRequest);
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpointURL);
        request.setMethod('POST');
        request.setTimeout(120000);
        request.setHeader('content-type', 'text/xml; charset = utf-8'); 
        Http http = new Http();
        HttpResponse response = http.send(request);
        if(response.getStatusCode()!=200)
            throw new WundermanAPIException('Wunderman API Call Failed. Method: '+ endpointURL+', Error: ' + response.toString());
        string responseXml = response.getBody();
        system.debug('ResponseXml : ' + responseXml);
        insertTransaction(methodName, endpointURL, responseXml);
        Tenet_Static_Variables.xmlResponse = responseXml;
        return responseXml;
    }
    //This method will specifically be used for adding campaign members
    private static string batchCallMethod(string methodName, string parameters)
    {
        List<WundermanLogin__c> cs = WundermanLogin__c.getall().values(); 
        string endpointURL = cs[0].EndpointURL__c + '/' + methodName + '.jsp?username=' + cs[0].name + '&session=' + cs[0].Session_Id__c + '&' + parameters;
        system.debug('EndpointURL: ' + endpointURL);
        Tenet_Static_Variables.xmlRequest = endpointURL;
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpointURL);
        request.setMethod('GET');
        request.setTimeout(120000);
        request.setHeader('content-type', 'text/xml; charset = utf-8'); 
        Http http = new Http();
        HttpResponse response = http.send(request);
        if(response.getStatusCode()!=200)
            throw new WundermanAPIException('Wunderman API Call Failed. Method: '+ endpointURL+', Error: ' + response.toString());
        string responseXml = response.getBody();
        //if(methodName == 'GetOrderData')
            //responseXml = responseXml.replaceAll( '\\s+', '');
        system.debug('ResponseXml : ' + responseXml);
        insertTransaction(methodName, endpointURL, responseXml);
        Tenet_Static_Variables.xmlResponse = responseXml;
        return responseXml;
    }
     // Method for handling values XML nodes in bulk
    private static string callMethodBulk(string methodName, string criteria)
    {
        List<WundermanLogin__c> cs = WundermanLogin__c.getall().values(); 
        string endpointURL = cs[0].EndpointURL__c + '/' + methodName + '.jsp' ;
        System.debug('Endpointurl********'+endpointURL);
        String finalxml = 'username='+cs[0].name + '&session=' + cs[0].Session_Id__c + '&' + criteria;
        System.debug('finalxml********'+finalxml);
        system.debug('EndpointURL: ' + endpointURL);
        Tenet_Static_Variables.xmlRequest = endpointURL+'?'+finalXML;
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpointURL);
        request.setMethod('POST');
        request.setBody(finalXML);
        request.setTimeout(120000);
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8'); 
        Http http = new Http();
        HttpResponse response = http.send(request);
        string responseXml = response.getBody();
        system.debug('ResponseXml : ' + responseXml); 
        insertTransaction(methodName, endpointURL, finalxml, responseXml);
        return responseXml;
    }
    
    public static String startNewListOrder()
    {
        try
        {   List<WundermanLogin__c> cs1 = WundermanLogin__c.getall().values();
            string param = 'list_product_id='+cs1[0].WundermanListProductId__c+'&count_name=SFDC';
           // string xmlResponse = callMethod('StartCount', 'list_product_id=980&count_name=SFDC');
           string xmlResponse = callMethod('StartCount', param);
            string listOrderId = getValueFromXmlResponse(xmlResponse, 'LIST_ORDER_ID');
            system.debug('List Order Id: ' + listOrderId);
            return listOrderId;
        }
        catch(Exception e)
        {
            throw new WundermanAPIException('Unable to start a new List Order. ' + e.getMessage());
            return null;
        }
    }
    
    public static string getListOrderInfo(string listOrderId)
    {
        return callMethod('GetCountCriteria', 'list_order_id='+listOrderId);
    }
    
    public static string getListOrderGroupId(string listOrderId)
    {
        string xmlResponse = callMethod('GetCountCriteria', 'list_order_id='+listOrderId);
        string listOrderGroupId = getValueFromXmlResponse(xmlResponse, 'LIST_ORDER_SELECT_GRP_ID');
        system.debug('List Order Group Id: ' + listOrderGroupId);
        return listOrderGroupId;
    }
    
    public static void addCriteriaToListOrder(string listOrderSelectGroupId, Campaign_Member_Criteria__c criteria, decimal groupLevel)
    {
        try
        {
            //Get the Wunderman Element Id of the Field and the Values in the Wunderman Xml Request Format
            WundermanMappingElement wme = getDataElement(criteria.Field_Name__c, criteria.Value__c);
            string dataElementId = wme.dataElementId;
            string valuesXML = wme.valuesXML;
            string operator = criteria.Operator__c == 'OR'?'o':'a';
            
            //Call the Wunderman API and capture the response XML
            string xmlResponse;
            system.debug('######countGrpids###### : '+ listOrderSelectGroupId);
            if(criteria.Field_Name__c == 'ZipCode__c' || criteria.Field_Name__c == 'Diagnosis_Code__c' || criteria.Field_Name__c == 'Procedure_Code__c' || criteria.Field_Name__c == 'MS_DRG__c') 
                xmlResponse = callMethodBulk('EditListOrderElements', 'list_order_select_grp_id='+listOrderSelectGroupId+'&group_level_num='+string.valueOf(groupLevel)+'&action=INSERT&logic_operator_cd='+operator+'&data_element_id=' + dataElementId + '&values_xml='+ valuesXml);
            else 
                xmlResponse = callMethod('EditListOrderElements', 'list_order_select_grp_id='+listOrderSelectGroupId+'&group_level_num='+string.valueOf(groupLevel)+'&action=INSERT&logic_operator_cd='+operator+'&data_element_id=' + dataElementId + '&values_xml='+ valuesXml);
              
            //Read the Criteria Element Id from the response Xml and map it to the SFDC Criteria Record 
            criteria.WM_Criteria_Id__c = getValueFromXmlResponse(xmlResponse, 'LIST_ORDER_CRITERIA_ELMNT_ID');
            system.debug('ListOrderCriteriaElementId: '+ criteria.WM_Criteria_Id__c);
            
        }
        catch(Exception e)
        {
            throw new WundermanAPIException('Unable to add the Criteria (' +criteria.Field_id__c+ ' as ' + criteria.Field_id__c+ ') in Wunderman. ' + e.getMessage());
        }
    }
    
    public static string insertCriteriaToListOrder(string listOrderSelectGroupId, Campaign_Member_Criteria__c criteria, decimal groupLevel)
    {
        try
        {
            //Get the Wunderman Element Id of the Field and the Values in the Wunderman Xml Request Format
            WundermanMappingElement wme = getDataElement(criteria.Field_Name__c, criteria.Value__c);
            string dataElementId = wme.dataElementId;
            string valuesXML = wme.valuesXML;
            string operator = criteria.Operator__c == 'OR'?'o':'a';
            
            //Call the Wunderman API and capture the response XML
            string xmlResponse;
            system.debug('######countGrpids###### : '+ listOrderSelectGroupId);
            if(criteria.Field_Name__c == 'ZipCode__c' || criteria.Field_Name__c == 'Diagnosis_Code__c' || criteria.Field_Name__c == 'Procedure_Code__c' || criteria.Field_Name__c == 'MS_DRG__c') 
                xmlResponse = callMethodBulk('EditListOrderElements', 'list_order_select_grp_id='+listOrderSelectGroupId+'&group_level_num='+string.valueOf(groupLevel)+'&action=INSERT&logic_operator_cd='+operator+'&data_element_id=' + dataElementId + '&values_xml='+ valuesXml);
            else 
                xmlResponse = callMethod('EditListOrderElements', 'list_order_select_grp_id='+listOrderSelectGroupId+'&group_level_num='+string.valueOf(groupLevel)+'&action=INSERT&logic_operator_cd='+operator+'&data_element_id=' + dataElementId + '&values_xml='+ valuesXml);
              
            //Read the Criteria Element Id from the response Xml and map it to the SFDC Criteria Record 
            criteria.WM_Criteria_Id__c = getValueFromXmlResponse(xmlResponse, 'LIST_ORDER_CRITERIA_ELMNT_ID');
            system.debug('ListOrderCriteriaElementId: '+ criteria.WM_Criteria_Id__c);
            return criteria.WM_Criteria_Id__c;
       }
        catch(Exception e)
        {
            throw new WundermanAPIException('Unable to add the Criteria (' +criteria.Field_id__c+ ' as ' + criteria.Field_id__c+ ') in Wunderman. ' + e.getMessage());
        }
    }
    
    public static void addCriteriaToListOrder(string listOrderSelectGroupId, Campaign_Member_Criteria__c criteria)
    {
       addCriteriaToListOrder(listOrderSelectGroupId, criteria, 0);
    }
    
    public static void updateCriteriaOfListOrder(Campaign_Member_Criteria__c criteria, decimal groupLevel)
    {
        try
        {
            //Get the Wunderman Element Id of the Field and the Values in the Wunderman Xml Request Format
            WundermanMappingElement wme = getDataElement(criteria.Field_Name__c, criteria.Value__c);
            string dataElementId = wme.dataElementId;
            string valuesXML = wme.valuesXML;
            string operator = criteria.Operator__c == 'OR'?'o':'a';
            
            //Call the Wunderman API and capture the response XML
            string xmlResponse;
            
            if(criteria.Field_Name__c == 'ZipCode__c' || criteria.Field_Name__c == 'Diagnosis_Code__c' || criteria.Field_Name__c == 'Procedure_Code__c' || criteria.Field_Name__c == 'MS_DRG__c') 
                xmlResponse = callMethodBulk('EditListOrderElements', 'list_order_criteria_elmnt_id='+criteria.WM_Criteria_Id__c+'&action=UPDATE&logic_operator_cd='+operator+'&values_xml='+ valuesXml);
            else 
                xmlResponse = callMethod('EditListOrderElements', 'list_order_criteria_elmnt_id='+criteria.WM_Criteria_Id__c+'&action=UPDATE&logic_operator_cd='+operator+'&values_xml='+ valuesXml);
                      
       }
        catch(Exception e)
        {
            throw new WundermanAPIException('Unable to update the Criteria (' +criteria.Field_id__c+ ' as ' + criteria.Field_id__c+ ') in Wunderman. ' + e.getMessage());
        }
    }
   
    public static void updateCriteriaOfListOrder(Campaign_Member_Criteria__c criteria)
    {
        updateCriteriaOfListOrder(criteria, 0);
    }
    
    public static void deleteCriteriaFromListOrder(Campaign_Member_Criteria__c criteria){
        
        try{
            string xmlResponse=callMethod('EditListOrderElements', 'action=DELETE'+'&list_order_criteria_elmnt_id='+criteria.WM_Criteria_Id__c);
                
            string result = getValueFromXmlResponse(xmlResponse, 'Message');
           
        }catch(Exception e){
            throw new WundermanAPIException('Unable to delete the Criteria (' +criteria.Field_id__c + ' as ' + criteria.Field_id__c + ') in Wunderman. ' + e.getMessage());
        }
    }
    
    public static void deleteSubGroupFromListOrder(Campaign_Member_Criteria_Group__c criteria){
        
        try
        {
            string xmlResponse=callMethod('EditListOrderGroups', 'action=DELETE'+'&list_order_select_grp_id='+criteria.WM_CriteriaGroup_Id__c);
            string result = getValueFromXmlResponse(xmlResponse, 'Message');
            
        }catch(Exception e){
            throw new WundermanAPIException('Unable to delete sub group (' +criteria.Name + ') in Wunderman. ' + e.getMessage());
        }
    }
  
    public static string addSubSelectGroupToListOrder(string listOrderId)
    {
        string xmlResponse = callMethod('EditListOrderGroups', 'list_order_id='+listOrderId+'&action=INSERT&select_group_type_code=SUB.SELECT');
        string subGroupId = getValueFromXmlResponse(xmlResponse, 'RETURNCODE');
        system.debug('Sub Group Id: ' + subGroupId);
        return subGroupId;
    }
    
    public static string addExcudeAllGroupToListOrder(string listOrderId)
    {
        string xmlResponse = callMethod('EditListOrderGroups', 'list_order_id='+listOrderId+'&action=INSERT&select_group_type_code=EXCLUDE.ALL');
        string subGroupId = getValueFromXmlResponse(xmlResponse, 'RETURNCODE');
        system.debug('Sub Group Id: ' + subGroupId);
        return subGroupId;
    }
    
    public static string updateGroupOfListOrder(string subGroupId)
    {
        return callMethod('EditListOrderGroups', 'list_order_select_grp_id='+subGroupId+'&action=UPDATE');
    }
    
    public static string deleteSubGroupToListOrder(string subGroupId)
    {
        return callMethod('EditListOrderGroups', 'list_order_select_grp_id='+subGroupId+'&action=DELETE');
    }
        
    public static integer refreshCount(string listOrderId)
    {  
    
        integer count;
        try {
        string xmlResponse = callMethod('RefreshCount', 'list_order_id='+listOrderId+'&action=COUNT');
        
        if (getValueFromXmlResponse(xmlResponse, 'TOTAL_COUNT')!=null)
        {
         count=  Integer.valueOf(getValueFromXmlResponse(xmlResponse, 'TOTAL_COUNT'));
        }else{
            
        }
        system.debug('Count: ' + count);
        }
        catch(Exception e) {
            System.debug('******Exception******'+e);
            throw new WundermanAPIException('Unable to do the refresh count from Wunderman. ' + e.getMessage());
        }
        return count;
    }
    
    public static string getListOrderStatus(string listOrderId)
    {
        string xmlResponse = batchCallMethod('GetListOrderStatus', 'list_order_id='+listOrderId);
        return xmlResponse;
    }
      
    public static string placeOrder(string listOrderId)
    {
        list<Transaction__c> transactionList = new list<Transaction__c>();
        Date dToday = Date.today()+1;
        
        String Month;
        String Day;
        if (dToday.month()<10)
        {
        Month='0'+String.valueOf(dToday.month());
        }
        else
        {
        Month=String.valueOf(dToday.month());
        }
        if (dToday.day()<10)
        {Day ='0'+String.valueOf(dToday.day());
        }
        else
        {
        Day =String.valueOf(dToday.day());
        }
        String dateStr = String.valueOf(dToday.year())+Month+Day ;
        
        string xmlResponse = callMethod('EditDeliveryInformation', 'list_order_id='+listOrderId +'&action=UPDATE&output_media_cd=NO.DELIVERY&approval_id=203481&delivery_type_cd=4&email_address=john.smith@tenet.com&offer_id=29400&mail_dttm='+dateStr+'&po_number=Example1');
        string xmlResponsePlaceOrder = callMethod('PlaceOrder', 'list_order_id='+listOrderId+'&override_warnings=true&order_type=SHORT');
        return xmlResponsePlaceOrder;
    }
       
    public static string getOrderData(string listOrderId, integer pageNumber)
    {
        string xmlResponse;
        if(listOrderId!=null)
         system.debug('xmlResponse***'+Tenet_Static_Variables.tenetDataConfigSetting.get(Tenet_Static_Variables.Query_API_Page_Size).Static_Value__c);   
            xmlResponse =  batchCallMethod('GetOrderData', 'list_order_id='+listOrderId+'&output_format=CSV&data_element_id=5631&page_number='+pageNumber+'&page_record_size='+Tenet_Static_Variables.tenetDataConfigSetting.get(Tenet_Static_Variables.Query_API_Page_Size).Static_Value__c);
        return xmlResponse;
    }
    
    public static string getOrderData(string listOrderId, integer pageNumber, integer pageSize)
    {
        string xmlResponse;
        if(listOrderId!=null)
            xmlResponse =  batchCallMethod('GetOrderData', 'list_order_id='+listOrderId+'&output_format=JSON&data_element_id=5631&page_number='+pageNumber+'&page_record_size='+pageSize); 
        return xmlResponse;
    }
    
    private static string getValuesXML(string valuesCSV)
    {
        System.debug('*******valuesCSV*****'+valuesCSV);
        string valuesXML;
        if(valuesCSV!=null) {
        valuesXML = '<ROOT><ELEMENT_VALUES>';
        for(string value: valuesCSV.split(';'))
            valuesXML +='<ELEMENT_VALUE><VALUE>' + value + '</VALUE></ELEMENT_VALUE>';
        valuesXML += '</ELEMENT_VALUES></ROOT>';
        }
        return valuesXML;
    }
        
    private static string getTransformedValuesXml(string fieldName, string valuesCSV, string valuesMapping)
    {
        string tValuesCSV = '';
        Map<String, Object> valuesMap = (Map<String, Object>)JSON.deserializeUntyped(valuesMapping);
        if(valuesCSV!=null) 
        {
            for(string key: valuesCSV.split(';'))
            {
                if(valuesMap.containsKey(key))
                    tValuesCSV += valuesMap.get(key) + ';';
                else
                    throw new WundermanMappingException('Mapping value for ' + key + ' not found for criteria ' + fieldName);
            }
        }
        tValuesCSV = tValuesCSV.removeEnd(';');
        string valuesXml = getValuesXML(tValuesCSV);
        return valuesXml;
    }
    
    public static string getValueFromXmlResponse(string xmlReponse, string elementName)
    {
        Dom.Document doc = new Dom.Document();
        doc.load(xmlReponse); 
        string returncode = getNodeValue(doc.getRootElement(), 'RETURNCODE');
        system.debug('returncode:'+returncode);
        if(returncode!=null && returncode=='-1')
        {
            string errorMessage = getNodeValue(doc.getRootElement(), 'Message');
            throw new WundermanMappingException(errorMessage);
        }
        else if(returncode!=null && returncode=='-1000')
        {
            string errorMessage = getNodeValue(doc.getRootElement(), 'Message');
            throw new WundermanMappingException(errorMessage);
        }
        return getNodeValue(doc.getRootElement(), elementName);
    } 
    
    public static List<string> getValuesFromXmlResponse(string xmlResponse)
    {
        List<string> values = new List<string>();
        XmlStreamReader reader = new XmlStreamReader(xmlResponse);
        while(reader.hasNext())
        {
           if(reader.getEventType()==Xmltag.CHARACTERS)
            {   
                if(reader.getText()!=null)
                    values.add(reader.getText());
            }
            reader.next();
        }
        system.debug('Values: ' + values);
        return values;
    }
    
    private static string getNodeValue(Dom.XmlNode node, string elementName)
    {
        if(node.getNodeType() == Dom.XmlNodeType.ELEMENT)
        {
            if(node.getName().trim()==elementName) 
                return node.getText().trim();
            for(dom.XmlNode childNode : node.getChildElements()) 
            {
                string value = getNodeValue(childNode, elementName);
                if(value!=null)
                    return value;
            }   
        }
        return null;
    }   
        
    private static string getDataElementId(string fieldName)
    {   
        System.debug('*********fieldName**********'+fieldName);
        List<Data_Element_Identifier__c> listDEI = new List<Data_Element_Identifier__c> ();
        if(fieldName!=null)         
            listDEI = [SELECT Id, Data_Element_Identifier__c, Data_Element_Name__c FROM Data_Element_Identifier__c  WHERE Field_Name__c=:fieldName];
        System.debug('*********listDEI**********'+listDEI);
        if(listDEI.size()>0)
            return listDEI[0].Data_Element_Identifier__c;
        else
            throw new WundermanMappingException('Wunderman Data Element Id for SFDC Field '+ fieldName + ' not found in the SFDC Data Element Identifier mapping table');
        
    }
        
    private static WundermanMappingElement getDataElement(string fieldName, string valuesCSV)
    {   
        System.debug('*********fieldName**********'+fieldName);
        if(fieldName == 'Diagnosis_Code__c' || fieldName == 'Procedure_Code__c')
            fieldName = 'Clinical_Code__c';
        List<Data_Element_Identifier__c> listDEI = new List<Data_Element_Identifier__c> ();
        if(fieldName!=null)         
            listDEI = [SELECT Id, Data_Element_Identifier__c, Data_Element_Name__c, Display_Type_Code__c, Value_Mapping__c FROM Data_Element_Identifier__c  WHERE Field_Name__c=:fieldName];
        System.debug('*********listDEI**********'+listDEI);
        if(listDEI.size()==0)
           throw new WundermanMappingException('Wunderman Data Element Id for SFDC Field '+ fieldName + ' not found in the SFDC Data Element Identifier mapping table');
        else
        {
            WundermanMappingElement wme = new WundermanMappingElement();
            wme.dataElementId = listDEI[0].Data_Element_Identifier__c;
            // Added for CR related to replacing hyphen with '\h' by Lov 3/1/2017
            System.debug('*****Pre-operation****'+valuesCSV);
            String replacingChars = '\\'+'\\h';
            if(listDEI[0].Value_Mapping__c == null && listDEI[0].Display_Type_Code__c!=null && !listDEI[0].Display_Type_Code__c.containsIgnoreCase('RANGE'))
                valuesCSV = valuesCSV.replaceAll('-',replacingChars);
            // Start of audience selection Service line and sub service  line change
            // Start Special characters (Apostrophe’ and Ampersand& ) change 
            if(fieldName=='CRM_SubServiceLine__c' || fieldName=='CRM_ServiceLine__c'){
              valuesCSV= valuesCSV.replaceAll('\'','%27');
              valuesCSV= valuesCSV.replaceAll('&','%26');
              valuesCSV= valuesCSV.replaceAll(' ','%20');
              
            }
            //end : Special characters (Apostrophe’ and Ampersand& ) change 
            //End of audience selection Service line and sub service  line change
            System.debug('*****Post-operation****'+valuesCSV);
            // End of CR related changes
            if(listDEI[0].Value_Mapping__c==null)
                wme.valuesXml = getValuesXML(valuesCSV);
            else
                wme.valuesXml = getTransformedValuesXml(fieldName, valuesCSV, listDEI[0].Value_Mapping__c);
            return wme;
        }      
    }
     public static void addCriteriaToListOrderWithMemType(id campId,string listOrderSelectGroupId, String fieldName, String value)
     {
        Campaign_Member_Criteria__c criteria = new Campaign_Member_Criteria__c();
        criteria.Field_Name__c = fieldName;
        criteria.Value__c = value;
        criteria.Campaign__c = campId;
        criteria.Field_id__c = 'Member Type';
        
        try
        {
            //Get the Wunderman Element Id of the Field and the Values in the Wunderman Xml Request Format
            WundermanMappingElement wme = getDataElement(fieldName, value);
            string dataElementId = wme.dataElementId;
            string valuesXML = wme.valuesXML;
            string operator = 'a';
            
            //Call the Wunderman API and capture the response XML
            string xmlResponse;
                  
            xmlResponse = callMethod('EditListOrderElements', 'list_order_select_grp_id='+listOrderSelectGroupId+'&group_level_num=0&action=INSERT&logic_operator_cd='+operator+'&data_element_id=' + dataElementId + '&values_xml='+ valuesXml);
              
            //Read the Criteria Element Id from the response Xml and map it to the SFDC Criteria Record 
           
            criteria.WM_Criteria_Id__c = getValueFromXmlResponse(xmlResponse, 'LIST_ORDER_CRITERIA_ELMNT_ID');
            system.debug('ListOrderCriteriaElementId: '+ criteria.WM_Criteria_Id__c);
            
            insert criteria;         
            
       }
        catch(Exception e)
        {
            throw new WundermanAPIException('Unable to add the Criteria (' +criteria.Field_id__c+ ' as ' + criteria.Field_id__c+ ') in Wunderman. ' + e.getMessage());
        }
    }
    /*Start :PP5 process change*/
    public static void logTransactions()
    {
        if(transactions.size()>0)
            insert transactions;
    }
   
    /*End:PP5 process change*/
    private static void insertTransaction (String methodName, String endpointURL, String responseXml) 
    {
        insertTransaction(methodName, endpointURL.split('\\?')[0], endpointURL.split('\\?')[1], responseXml);
    }
    
    private static void insertTransaction (String methodName, String endpointURL, string parameters, String responseXml) 
    {
        Transaction__c trans = new Transaction__c();
        trans.Type__c = methodName;
        trans.Request_Schema__c = parameters;
        trans.Request_URL__c = endpointURL;
        if(parameters!=null && parameters.length()>=131072)
            trans.Request_Schema__c = parameters.substring(0,131000);
        else 
            trans.Request_Schema__c = parameters;
        trans.Transaction_Source__c ='Query API Builder';
        trans.Response_Schema__c = responseXml;
        transactions.add(trans);
    }
   
    private static String JSONReader() {
    
        return null;
    
    }
    
    public class WundermanAPIException extends Exception {}
    
    public class WundermanMappingException extends Exception {}
    
    public class WundermanMappingElement
    {
        string dataElementId {get;set;}
        string valuesXml {get;set;}
    }
    
}
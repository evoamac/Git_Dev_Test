@isTest
global class MockHttpResponse implements HttpCalloutMock {

    string dummyResponse;
    global MockHttpResponse(string response){
    	dummyResponse=response;
    }   
	global HTTPResponse respond(HTTPRequest req) {

        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type','application/XML');
        if(!string.isBlank(dummyResponse))
        	res.setBody(dummyResponse);
        else
        	res.setBody('<root><RESULT><SERVICE>SecurityFilter</SERVICE><RETURNCODE>0</RETURNCODE><MESSAGE><![CDATA[Login successful]]></MESSAGE><SESSION>5420499</SESSION></RESULT></root>');
        res.setStatusCode(200);
        return res;

	}

}
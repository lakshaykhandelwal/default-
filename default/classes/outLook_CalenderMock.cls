@isTest
global class outLook_CalenderMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setBody('{"value":[{"Id":"uh24i734yhf23f1093id1","Subject":"CheckDaynm","WebLink":"https://outlook.office.com/api/v2.0/","Start":{"DateTime":"2020-06-10T02:30:00.0000000","TimeZone":"UTC"},"End":{"DateTime":"2020-06-10T03:00:00.0000000","TimeZone":"UTC"}}], "expires_in":"3600", "refresh_token":"test453", "scope":"https://outlook.office.com/api/v2.0", "token_type":"Bearer"}');
        response.setStatusCode(200);
        return response; 
    }
}
@isTest
global class SE_JQTableControllerMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setStatusCode(200);
        res.setBody('{"access_token":"test23", "expires_in":"3600", "refresh_token":"test453", "scope":"https://www.googleapis.com/auth/calendar", "token_type":"Bearer"}');
        
        return res; 
        
    }
}
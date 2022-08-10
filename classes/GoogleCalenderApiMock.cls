@isTest
global class GoogleCalenderApiMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setBody('{"access_token":"test23", "expires_in":"3600", "refresh_token":"test453", "scope":"https://www.googleapis.com/auth/calendar", "token_type":"Bearer"}');
        response.setStatusCode(200);
        return response; 
    }
}
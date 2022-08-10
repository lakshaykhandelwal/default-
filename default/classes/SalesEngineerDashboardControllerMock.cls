@isTest
global class SalesEngineerDashboardControllerMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        
        HttpResponse res = new HttpResponse();
        res.setBody('{"animals": {"id":1, "name":"Tests"}}');
        res.setStatusCode(200);
        return res; 
        
    }
}
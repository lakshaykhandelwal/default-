@isTest
global class SE_Open_Activities_TableCtrlMock implements HttpCalloutMock{
      global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"animal": {"id":2, "name":"Test"}}');
      response.setStatusCode(200);
        return response; 
    }

}
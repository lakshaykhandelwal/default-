public class googlefetchCodeController {

    public String authCode {get;set;}
    public String baseUrl{get;set;}
    public googlefetchCodeController(){
        baseUrl = System.URL.getSalesforceBaseUrl().toExternalForm()    ;
        authCode = ApexPages.currentPage().getParameters().get('code'); 
        system.debug('authCode'+authCode);    
    }
    

}
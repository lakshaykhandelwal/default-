public class fetchCodeController {
    public String authCode {get;set;}
    public String baseUrl{get;set;}
    public fetchCodeController(){
        baseUrl = System.URL.getSalesforceBaseUrl().toExternalForm()    ;
        authCode = ApexPages.currentPage().getParameters().get('code'); 
        system.debug('authCode'+authCode);    
    }
    
}
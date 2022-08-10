public class googlefetchCodeController {

    public String authCode {get;set;}
    public String baseUrl{get;set;}
    public googlefetchCodeController(){
        baseUrl = System.URL.getSalesforceBaseUrl().toExternalForm();
        authCode = ApexPages.currentPage().getParameters().get('code'); 

        authCode = EncodingUtil.base64Encode(Blob.valueOf(authCode));
        authCode = String.valueOf(EncodingUtil.base64Decode(authCode));
        system.debug('authCode'+authCode);    
    }
}
public class fetchCodeController {
    public String authCode {get;set;}
    public String baseUrl{get;set;}
    public fetchCodeController(){
        baseUrl = System.URL.getSalesforceBaseUrl().toExternalForm();
        authCode = ApexPages.currentPage().getParameters().get('code'); 
        //this line added after security org scanner
        authCode = EncodingUtil.base64Encode(Blob.valueOf(authCode));
        authCode = String.valueOf(EncodingUtil.base64Decode(authCode));
        system.debug('authCode'+authCode);    
    }
    
}
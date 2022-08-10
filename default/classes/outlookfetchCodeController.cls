public class outlookfetchCodeController {

    public String authCode {get;set;}
    public String baseUrl{get;set;}
    public outlookfetchCodeController(){
        baseUrl = System.URL.getSalesforceBaseUrl().toExternalForm();
        authCode = ApexPages.currentPage().getParameters().get('code');
        System.debug('>>baseUrl<<<'+baseUrl);
        system.debug('authCode'+authCode);    

        authCode = EncodingUtil.base64Encode(Blob.valueOf(authCode));
        authCode = String.valueOf(EncodingUtil.base64Decode(authCode));
    }
    

}
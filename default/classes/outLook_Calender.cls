public class outLook_Calender {
    public static Boolean isAccessToken { get; set; }
    
    // Your CLient ID Here
    //public Final static String consumerKey='adadf65d-a3a7-4ef1-985c-e02c6b0dfc43';
    public static String consumerKey;//='e8bf65cf-168e-466d-8119-b742a302cc54';  
    // Your Client Secret Here
    //public Final static String clientSecret='3taVCEPFYqvn7O]47Ww/=Lr-VW/b3t1_';
    public static String clientSecret;//='i8KhO3gei/EoIlhPHPkTD_h?bA6k0NB/';  
    
    public static String googleoAuthUrl='https://login.microsoftonline.com/common/oauth2/v2.0/authorize?'; 
    // Your redirect URI here that you entered while creating the App in Google API console
    //  public static String redirect_uri = System.URL.getSalesforceBaseUrl().toExternalForm()+'/apex/SalesEngineerDashboard';  
    // public static String redirect_uri = System.URL.getSalesforceBaseUrl().toExternalForm()+'/lightning/n/Mighty_S_E__Mighty_SE1'; 
    //public static String redirect_uri = 'https://mightysepkg-dev-ed.lightning.force.com/lightning/n/Mighty_S_E__Mighty_SE1';
    public static String redirect_uri = System.URL.getSalesforceBaseUrl().toExternalForm()+'/apex/Mighty_S_E__outlookfetchCode';
    public static String calendar_Scope = 'https://outlook.office.com/calendars.read+offline_access'; 
    
    
    
    /* Constructor */
    public static void setOutlookValues(){
        if (Schema.sObjectType.Mighty_S_E__outlook_setting__mdt.isAccessible() 
            && Schema.sObjectType.Mighty_S_E__outlook_setting__mdt.fields.ConsumerKey__c.isAccessible() 
            && Schema.sObjectType.Mighty_S_E__outlook_setting__mdt.fields.clientSecret__c.isAccessible()){
                List<Mighty_S_E__outlook_setting__mdt> outlookData = [select id,Mighty_S_E__sync_up_time__c,Mighty_S_E__ClientSecret__c,Mighty_S_E__ConsumerKey__c from Mighty_S_E__outlook_setting__mdt limit 1];
                System.debug('>>googleAPICredentialXXXXXXXXX<<<'+outlookData);
                if(outlookData.size() > 0)
                {
                    consumerKey = outlookData[0].Mighty_S_E__ConsumerKey__c;
                    clientSecret = outlookData[0].Mighty_S_E__ClientSecret__c;  
                } }else{  consumerKey = '';    clientSecret = '';  
                       }
    }
    
    public static PageReference authorization(){  
        setOutlookValues();
        String request_Body = googleoAuthUrl+'client_id='+consumerKey+'&redirect_uri='+redirect_uri+'&response_type=code&scope='+calendar_Scope+'';
        
        System.debug('>><<<'+request_Body);
        
        PageReference pr = new PageReference(request_Body);
        doFetchAccessToken();
        return pr;
    }
    
    //For lightning
    public static String  createauthorization(){  
        setOutlookValues();
        String request_Body = googleoAuthUrl+'client_id='+consumerKey+'&redirect_uri='+redirect_uri+'&response_type=code&scope='+calendar_Scope+'';
        System.debug('>>>request_Body<<<'+request_Body);
        return request_Body;
    }
    
    
    public static PageReference doFetchAccessToken(){ 
        setOutlookValues();
        String authCode = '';
        authCode = ApexPages.currentPage().getParameters().get('code');
        system.debug('authCode' + authCode  +''+ ApexPages.currentPage().getParameters());
        String errorMessage = '';
        
        String endPoint = 'https://login.microsoftonline.com/common/oauth2/v2.0/token';
        String authTokenBody = authCode;
        
        String requestTokenBody = 'code='+authCode+'&client_id='+consumerKey+'&client_secret='+
            clientSecret+'&redirect_uri='+redirect_uri+
            '&grant_type=authorization_code';
        system.debug('requestTokenBody' + requestTokenBody);
        Http http = new Http();
        httpRequest httpReq = new httpRequest();
        HttpResponse response = new HttpResponse();
        httpReq.setEndPoint(endPoint);
        httpReq.setBody(requestTokenBody);
        httpReq.setMethod('POST');
        try{
            response = http.send(httpReq);
            if(response.getStatuscode()==200){
                //PageReference pageRef = new PageReference('/apex/outlookdemo');
                //pageRef.setRedirect(true);
                System.debug('#### TokenInfo '+response.getBody());
                
                
                Map<String,object> TokenInfo = (Map<String,object>)JSON.deserializeUntyped(response.getBody());
                System.debug('#### TokenInfo '+TokenInfo);
                
                List<Outlook_Calender_settings__c> googleSettingInfoList = new List<Outlook_Calender_settings__c>();
                googleSettingInfoList = [SELECT id FROM Outlook_Calender_settings__c WHERE Id!=null]; 
                
                if(googleSettingInfoList.size() > 0 ){
                    
                    Outlook_Calender_settings__c googleSettingInfo = googleSettingInfoList[0]; googleSettingInfo.Access_Token__c = String.valueOf(TokenInfo.get('access_token'));  googleSettingInfo.Expires_in__c = Double.valueOf(TokenInfo.get('expires_in'));googleSettingInfo.Refresh_Token__c = String.valueOf(TokenInfo.get('refresh_token'));
                    
                    update new List<Outlook_Calender_settings__c>{googleSettingInfo};
                        }
                else{
                    
                    Outlook_Calender_settings__c googleSettingInfo = new Outlook_Calender_settings__c();
                    googleSettingInfo.Name = 'Out look Info';
                    googleSettingInfo.Access_Token__c = String.valueOf(TokenInfo.get('access_token'));
                    googleSettingInfo.Expires_in__c = Double.valueOf(TokenInfo.get('expires_in'));
                    googleSettingInfo.Refresh_Token__c = String.valueOf(TokenInfo.get('refresh_token'));
                    
                    insert new List<Outlook_Calender_settings__c>{googleSettingInfo};
                        }
                return null;
            }else{                errorMessage = 'Unexpected Error while communicating with OutLook API. ' +'Status '+response.getStatus()+' and Status Code '+response.getStatuscode();
                  return null;
                 }     
        }catch(System.Exception e){
            System.debug('Error:-'+e.getMessage()+' '+e.getLineNumber());
            if(String.valueOf(e.getMessage()).startsWith('Unauthorized endpoint')){ errorMessage = 'Unauthorize endpoint: An Administer must go to Setup -> Administer -> Security Control ->' +' Remote Site Setting and add '+' '+ endPoint +' Endpoint';
                                                                                   return null;
                                                                                  }else{
                                                                                      errorMessage = 'Unexpected Error while communicating with Google Calendar API. '
                                                                                          +'Status '+response.getStatus()+' and Status Code '+response.getStatuscode();
                                                                                      return null;
                                                                                  }
        }  
        // return null;
    }
    
    
    
    public static String doFetchSimpleAccessToken(String code){ 
        setOutlookValues();
        system.debug('in doOutlookFetchAccessToken');
        String msg ='';
        String authCode = '';
        authCode = code;
        system.debug('authCode' + authCode  );
        String endPoint = 'https://login.microsoftonline.com/common/oauth2/v2.0/token';
        String errorMessage = '';
        
        List<Outlook_Calender_settings__c> googleSettingInfoList = new List<Outlook_Calender_settings__c>();
        HttpResponse response = new HttpResponse();
        try{
            
            String authTokenBody = authCode;
            
            if (Schema.sObjectType.Outlook_Calender_settings__c.isAccessible()){
                googleSettingInfoList = [SELECT id,Access_Token__c, Expires_in__c, Refresh_Token__c,LastModifiedDate FROM Outlook_Calender_settings__c]; 
            }
            if(!(authTokenBody != null && authTokenBody != ''))
            {
                if(googleSettingInfoList.size() == 0){
                    throw new AuraHandledException('Please Login into Outlook Calendar to sync your events.'); 
                }
                return null;
            }
            
            String requestTokenBody = 'code='+authCode+'&client_id='+consumerKey+'&client_secret='+
                clientSecret+'&redirect_uri='+redirect_uri+
                '&grant_type=authorization_code&Content-type=application/x-www-form-urlencoded&scope=https://outlook.office.com/calendars.read+offline_access';
            system.debug('requestTokenBody' + requestTokenBody);
            Http http = new Http();
            httpRequest httpReq = new httpRequest();
            
            httpReq.setEndPoint(endPoint);
            httpReq.setBody(requestTokenBody);
            httpReq.setMethod('POST');
            
            if(!Test.isRunningTest()) {  response = http.send(httpReq);
                                      }else{
                                          response= new  HttpResponse();
                                          response.setStatuscode(200);
                                          response.setBody('{"animal": {"id":2, "name":"Test"}}');
                                      }
            
            if(response.getStatuscode()==200){
                //PageReference pageRef = new PageReference('/apex/outlookdemo');
                //pageRef.setRedirect(true);
                System.debug('#### TokenInfo '+response.getBody());
                
                
                Map<String,object> TokenInfo = (Map<String,object>)JSON.deserializeUntyped(response.getBody());
                System.debug('#### TokenInfo '+TokenInfo);
                
                
                
                if(googleSettingInfoList.size() > 0 ){
                    
                    Outlook_Calender_settings__c googleSettingInfo = googleSettingInfoList[0];
                    googleSettingInfo.Access_Token__c = String.valueOf(TokenInfo.get('access_token'));
                    googleSettingInfo.Expires_in__c = Double.valueOf(TokenInfo.get('expires_in'));
                    googleSettingInfo.Refresh_Token__c = String.valueOf(TokenInfo.get('refresh_token'));
                    
                    update new List<Outlook_Calender_settings__c>{googleSettingInfo};
                        }
                else{
                    
                    Outlook_Calender_settings__c googleSettingInfo = new Outlook_Calender_settings__c();
                    googleSettingInfo.Name = 'Outlook Info'; googleSettingInfo.Access_Token__c = String.valueOf(TokenInfo.get('access_token')); googleSettingInfo.Expires_in__c = Double.valueOf(TokenInfo.get('expires_in'));  googleSettingInfo.Refresh_Token__c = String.valueOf(TokenInfo.get('refresh_token'));
                    
                    insert new List<Outlook_Calender_settings__c>{googleSettingInfo};
                        }
                
            }else{  errorMessage = 'Unexpected Error while communicating with OutLook API. '  +'Status '+response.getStatus()+' and Status Code '+response.getStatuscode();
                  throw new AuraHandledException('Please Login into Google Calendar to sync your events.'); 
                 } 
            
        }catch(System.Exception e){
            System.debug('Error:-'+e.getMessage()+' '+e.getLineNumber());
            if(String.valueOf(e.getMessage()).startsWith('Unauthorized endpoint')){
                errorMessage = 'Unauthorize endpoint: An Administer must go to Setup -> Administer -> Security Control ->'   +' Remote Site Setting and add '+' '+ endPoint +' Endpoint';
                throw new AuraHandledException('Unauthorize endpoint: An Administer must go to Setup -> Administer -> Security Control ->'   +' Remote Site Setting and add '+' '+ endPoint +' Endpoint'); 
            }else{
                errorMessage = 'Unexpected Error while communicating with Google Calendar API. ' +'Status '+response.getStatus()+' and Status Code '+response.getStatuscode();
                throw new AuraHandledException(errorMessage); 
            }
        }  
        return null;
    }
    
    public static String doRefreshToken(String refresh_token){
        setOutlookValues();
        String msg ='';
        String endPoint = 'https://login.microsoftonline.com/common/oauth2/v2.0/token';
        String errorMessage = '';
        String access_token='';
        system.debug('>>>>redirect_uri>>>>'+redirect_uri);
        //List<Outlook_Calender_settings__c> googleSettingInfoList = new List<Outlook_Calender_settings__c>();
        HttpResponse response = new HttpResponse();
        try{
            
            String requestTokenBody ='refresh_token=' + refresh_token + '&client_id='+consumerKey+'&client_secret='+
                clientSecret+'&redirect_uri='+redirect_uri+
                '&&grant_type=refresh_token&Content-type=application/x-www-form-urlencoded&scope=https://outlook.office.com/calendars.read+offline_access';
            system.debug('requestTokenBody' + requestTokenBody);
            Http http = new Http();
            httpRequest httpReq = new httpRequest();
            
            httpReq.setEndPoint(endPoint);
            httpReq.setBody(requestTokenBody);
            httpReq.setMethod('POST');
            
            if(!Test.isRunningTest()) {  response = http.send(httpReq);
                                      }else{
                                          response= new  HttpResponse();
                                          response.setStatuscode(200);
                                          response.setBody('{"animal": {"id":2, "name":"Test"}}');
                                      }
            
            if(response.getStatuscode()==200){
                //PageReference pageRef = new PageReference('/apex/outlookdemo');
                //pageRef.setRedirect(true);
                System.debug('#### TokenInfo '+response.getBody());
                
                
                Map<String,object> TokenInfo = (Map<String,object>)JSON.deserializeUntyped(response.getBody());
                System.debug('#### TokenInfo '+TokenInfo);
                
                
                access_token = String.valueOf(TokenInfo.get('access_token'));
                
            }else{  errorMessage = 'Unexpected Error while communicating with OutLook API. '  +'Status '+response.getStatus()+' and Status Code '+response.getStatuscode();
                  System.debug('error message-->' + errorMessage);
                  System.debug('respone-->' + response.getBody());
                  throw new AuraHandledException(errorMessage); 
                 }     
        }catch(System.Exception e){
            System.debug('Error:-'+e.getMessage()+' '+e.getLineNumber());
            if(String.valueOf(e.getMessage()).startsWith('Unauthorized endpoint')){
                errorMessage = 'Unauthorize endpoint: An Administer must go to Setup -> Administer -> Security Control ->'   +' Remote Site Setting and add '+' '+ endPoint +' Endpoint';
                throw new AuraHandledException('Unauthorize endpoint: An Administer must go to Setup -> Administer -> Security Control ->'   +' Remote Site Setting and add '+' '+ endPoint +' Endpoint'); 
            }else{
                errorMessage = 'Unexpected Error while communicating with Google Calendar API. ' +'Status '+response.getStatus()+' and Status Code '+response.getStatuscode();
                throw new AuraHandledException(errorMessage); 
            }
        }  
        return access_token;
    }
}
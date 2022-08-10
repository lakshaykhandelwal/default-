public class GoogleCalenderApi {
    public static Boolean isAccessToken { get; set; }
    public List<GoogleAPICredentials_pub__c> googleAPICredential;
    public static String clientSecret;
    public static String consumerKey;
    
    public static String googleoAuthUrl='https://accounts.google.com/o/oauth2/auth?'; 
    
    //  public static String redirect_uri = System.URL.getSalesforceBaseUrl().toExternalForm()+'/apex/SalesEngineerDashboard'; 
    public static String redirect_uri = System.URL.getSalesforceBaseUrl().toExternalForm()+'/apex/Mighty_S_E__googlefetchCode';
    public static String calendar_Scope = 'https://www.googleapis.com/auth/calendar'; 
    
    //named credentials
    public static Http http = new Http();
    public static HTTPResponse response;
    public static HttpRequest request;
    
    public GoogleCalenderApi(){}
    
    public static PageReference authorization(){  
        System.debug('PageReference authorization--');
        if (Schema.sObjectType.GoogleAPICredentials_pub__c.isAccessible() 
            && Schema.sObjectType.GoogleAPICredentials_pub__c.fields.ConsumerKey__c.isAccessible() 
            && Schema.sObjectType.GoogleAPICredentials_pub__c.fields.clientSecret__c.isAccessible()){
                List<GoogleAPICredentials_pub__c> googleAPICredential = [Select Id,ConsumerKey__c,clientSecret__c from GoogleAPICredentials_pub__c  LIMIT 50000];
                System.debug('>>googleAPICredentialXXXXXXXXX<<<'+googleAPICredential);
                if(googleAPICredential.size() > 0)
                {
                    consumerKey = googleAPICredential[0].ConsumerKey__c;
                    clientSecret = googleAPICredential[0].clientSecret__c;  
                } }else{  consumerKey = '';    clientSecret = '';  
                       }
        
        String request_Body = googleoAuthUrl+'redirect_uri='+redirect_uri+'&response_type=code&client_id='+consumerKey+
            '&scope='+calendar_Scope+'&prompt=consent&access_type=offline&include_granted_scopes=true';
        
        
        PageReference pr = new PageReference(request_Body);
        // doFetchAccessToken();
        return pr;
    }
    public static String createauthorization(){  
        System.debug('PageReference authorization 1--');
        if (Schema.sObjectType.GoogleAPICredentials_pub__c.isAccessible() 
            && Schema.sObjectType.GoogleAPICredentials_pub__c.fields.ConsumerKey__c.isAccessible() 
            && Schema.sObjectType.GoogleAPICredentials_pub__c.fields.clientSecret__c.isAccessible()){
                List<GoogleAPICredentials_pub__c> googleAPICredential = [Select Id,ConsumerKey__c,clientSecret__c from GoogleAPICredentials_pub__c  LIMIT 50000];
                if(googleAPICredential.size() > 0) {  consumerKey = googleAPICredential[0].ConsumerKey__c;clientSecret = googleAPICredential[0].clientSecret__c;   } }else{  consumerKey = '';    clientSecret = '';  
                                                                                                                                                                          }
        
        String request_Body = googleoAuthUrl+'redirect_uri='+redirect_uri+'&response_type=code&client_id='+consumerKey+
            '&scope='+calendar_Scope+'&prompt=consent&access_type=offline&include_granted_scopes=true';
        system.debug('request_Body---'+request_Body);
        
        
        // doFetchAccessToken();
        return request_Body;
    }
    public static PageReference doFetchAccessToken(){ 
        String authCode = '';
        authCode = ApexPages.currentPage().getParameters().get('code') ;
        String errorMessage = '';
        String endPoint = 'https://www.googleapis.com/oauth2/v4/token';
        String authTokenBody = authCode;
        try{
            
            if (Schema.sObjectType.GoogleAPICredentials_pub__c.isAccessible() 
                && Schema.sObjectType.GoogleAPICredentials_pub__c.fields.ConsumerKey__c.isAccessible() 
                && Schema.sObjectType.GoogleAPICredentials_pub__c.fields.clientSecret__c.isAccessible()){
                    List<GoogleAPICredentials_pub__c> googleAPICredential = [Select Id,ConsumerKey__c,clientSecret__c from GoogleAPICredentials_pub__c  LIMIT 50000];
                    if(googleAPICredential.size() > 0){  consumerKey = googleAPICredential[0].ConsumerKey__c;  clientSecret = googleAPICredential[0].clientSecret__c;   
                                                      } }else{
                                                          consumerKey = '';    
                                                          clientSecret = '';   
                                                      }
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
            
            if(!Test.isRunningTest()) { response = http.send(httpReq);    
                                      }else{
                                          response = new HttpResponse(); 
                                          response.setStatuscode(200);
                                          response.setBody('{"access_token":"ya29.a0Adw1xeUDaGUkFYAVVO7zzXzA-8aAjD7Pwch1OwiUbLiPgQG4jXTmLZ-u5VqNA-IM4DCyXFPiPVJOKevQs3UY51zdoygeba0OmavfCxG15eeEhFbFt52VjegODgugsBn6lUzeqUFTfSxi6bhEIM_NvFR32aiyk2i9wRU", "expires_in":"3599", "refresh_token":"1//0eD4svWJyXg_XCgYIARAAGA4SNwF-L9Ir6Mi93P6f0tjZQeV6Yk2T7O_WSRTRSiG6cpGSYbW5h4E8VvTNkTPFsJGuP9D0wP6EPo8", "scope":"https://www.googleapis.com/auth/calendar", "token_type":"Bearer"}');
                                      }
            
            
            if(response.getStatuscode()==200){
                PageReference pageRef = new PageReference('/apex/GoogleCalendarActions');
                pageRef.setRedirect(true);
                System.debug('>>>TokenInfo<<<<'+(Map<String,object>)JSON.deserializeUntyped(response.getBody()));
                Map<String,object> TokenInfo = (Map<String,object>)JSON.deserializeUntyped(response.getBody());
                System.debug('#### TokenInfo '+TokenInfo);
                
                List<Google_Calender_setting__c> googleSettingInfoList = new List<Google_Calender_setting__c>();
                if (Schema.sObjectType.Google_Calender_setting__c.isAccessible()){
                    googleSettingInfoList = [SELECT id FROM Google_Calender_setting__c LIMIT 50000];
                    System.debug('#### googleSettingInfoList '+googleSettingInfoList);
                    if(googleSettingInfoList.size() > 0 ){
                        if(Schema.sObjectType.Google_Calender_setting__c.isCreateable()
                           && Schema.sObjectType.Google_Calender_setting__c.fields.Access_Token__c.isCreateable()
                           && Schema.sObjectType.Google_Calender_setting__c.fields.Expires_in_Seconds__c.isCreateable()
                           && Schema.sObjectType.Google_Calender_setting__c.fields.Refresh_Token__c.isCreateable()){
                               Google_Calender_setting__c googleSettingInfo = googleSettingInfoList[0];
                               Blob s = Blob.valueOf(String.valueOf(TokenInfo.get('access_token')));
                               String accessTokenHex = EncodingUtil.convertToHex(s);
                               googleSettingInfo.Access_Token__c =String.valueOf(TokenInfo.get('access_token')); // accessTokenHex;
                               googleSettingInfo.Expires_in_Seconds__c = Double.valueOf(TokenInfo.get('expires_in'));
                               googleSettingInfo.Refresh_Token__c = String.valueOf(TokenInfo.get('refresh_token'));
                               
                               update new List<Google_Calender_setting__c>{googleSettingInfo};
                                   }else{
                                       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Insufficient Access'));
                                       return null;
                                   }  
                    }else{
                        system.debug('insert store custom setting');
                        if(Schema.sObjectType.Google_Calender_setting__c.isCreateable()
                           && Schema.sObjectType.Google_Calender_setting__c.fields.Access_Token__c.isCreateable()
                           && Schema.sObjectType.Google_Calender_setting__c.fields.Expires_in_Seconds__c.isCreateable()
                           && Schema.sObjectType.Google_Calender_setting__c.fields.Refresh_Token__c.isCreateable()){
                               Google_Calender_setting__c googleSettingInfo = new Google_Calender_setting__c();
                               Blob s = Blob.valueOf(String.valueOf(TokenInfo.get('access_token')));
                               String accessTokenHex = EncodingUtil.convertToHex(s);
                               googleSettingInfo.Name = 'Google CalenderInfo';
                               googleSettingInfo.Access_Token__c = String.valueOf(TokenInfo.get('access_token')); /// accessTokenHex;
                               googleSettingInfo.Expires_in_Seconds__c = Double.valueOf(TokenInfo.get('expires_in'));
                               googleSettingInfo.Refresh_Token__c = String.valueOf(TokenInfo.get('refresh_token'));
                               system.debug('insert store custom setting');
                               insert new List<Google_Calender_setting__c>{googleSettingInfo}; 
                                   }
                    }
                }else{
                    system.debug('insert store custom setting');
                    if(Schema.sObjectType.Google_Calender_setting__c.isCreateable()
                       && Schema.sObjectType.Google_Calender_setting__c.fields.Access_Token__c.isCreateable()
                       && Schema.sObjectType.Google_Calender_setting__c.fields.Expires_in_Seconds__c.isCreateable()
                       && Schema.sObjectType.Google_Calender_setting__c.fields.Refresh_Token__c.isCreateable()){
                           Google_Calender_setting__c googleSettingInfo = new Google_Calender_setting__c();
                           Blob s = Blob.valueOf(String.valueOf(TokenInfo.get('access_token')));
                           String accessTokenHex = EncodingUtil.convertToHex(s);
                           googleSettingInfo.Name = 'Google CalenderInfo';
                           googleSettingInfo.Access_Token__c = String.valueOf(TokenInfo.get('access_token')); /// accessTokenHex;
                           googleSettingInfo.Expires_in_Seconds__c = Double.valueOf(TokenInfo.get('expires_in'));
                           googleSettingInfo.Refresh_Token__c = String.valueOf(TokenInfo.get('refresh_token'));
                           system.debug('insert store custom setting');
                           insert new List<Google_Calender_setting__c>{googleSettingInfo};
                               }else{
                                   ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Insufficient Access'));
                                   return null;
                               }
                }
                return pageRef;
            }else{
                errorMessage = 'Unexpected Error while communicating with Google Calendar API. '
                    +'Status '+response.getStatus()+' and Status Code '+response.getStatuscode();
                return null;
            }     
        }catch(System.Exception e){
            System.debug('Error:-'+e.getMessage()+' '+e.getLineNumber());
            if(String.valueOf(e.getMessage()).startsWith('Unauthorized endpoint')){
                errorMessage = 'Unauthorize endpoint: An Administer must go to Setup -> Administer -> Security Control ->'
                    +' Remote Site Setting and add '+' '+ endPoint +' Endpoint';
                return null;
            }else{
                errorMessage = 'Unexpected Error while communicating with Google Calendar API. ';
                return null;
            }
        }  
        
    }
    public static PageReference doFetchSimpleAccessToken(String code){ 
        String authCode = '';
        authCode = code ;
        String errorMessage = '';
        String endPoint = 'https://www.googleapis.com/oauth2/v4/token';
        String authTokenBody = authCode;
        List<Google_Calender_setting__c> googleSettingInfoList = new List<Google_Calender_setting__c>();
        system.debug('codecodecode: '+code);
        if (Schema.sObjectType.Google_Calender_setting__c.isAccessible()){
            googleSettingInfoList = [SELECT id FROM Google_Calender_setting__c where CreatedById = :UserInfo.getUserId() LIMIT 1];
        }
        if(!(code != null && code != '')){
            if(googleSettingInfoList.size() == 0){
                throw new AuraHandledException('Please Login into Google Calendar to sync your events.'); 
            }
            return null;
        }
        
        system.debug('codecodecode22: '+code);
        try{
            if (Schema.sObjectType.GoogleAPICredentials_pub__c.isAccessible() 
                && Schema.sObjectType.GoogleAPICredentials_pub__c.fields.ConsumerKey__c.isAccessible() 
                && Schema.sObjectType.GoogleAPICredentials_pub__c.fields.clientSecret__c.isAccessible()){
                    List<GoogleAPICredentials_pub__c> googleAPICredential = [Select Id,ConsumerKey__c,clientSecret__c from GoogleAPICredentials_pub__c  LIMIT 50000];
                    if(googleAPICredential.size() > 0)
                    {
                        consumerKey = googleAPICredential[0].ConsumerKey__c; 
                        clientSecret = googleAPICredential[0].clientSecret__c;   
                    } 
                }else{ consumerKey = '';    clientSecret = '';   
                     }
            
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
            if(!Test.isRunningTest()) { response = http.send(httpReq);    
                                      }else{
                                          response = new HttpResponse(); 
                                          response.setStatuscode(200);
                                          response.setBody('{"access_token":"test23", "expires_in":"3600", "refresh_token":"test453", "scope":"https://www.googleapis.com/auth/calendar", "token_type":"Bearer"}');
                                      }
            
            
            if(response.getStatuscode()==200){
                PageReference pageRef = new PageReference('/apex/GoogleCalendarActions');
                pageRef.setRedirect(true);
                Map<String,object> TokenInfo = (Map<String,object>)JSON.deserializeUntyped(response.getBody());
                System.debug('#### TokenInfo '+TokenInfo);
                
                if (Schema.sObjectType.Google_Calender_setting__c.isAccessible()){
                    
                    System.debug('#### googleSettingInfoList '+googleSettingInfoList);
                    if(googleSettingInfoList.size() > 0 ){
                        //if(!Test.isRunningTest() ){
                        if(Schema.sObjectType.Google_Calender_setting__c.isCreateable()
                           && Schema.sObjectType.Google_Calender_setting__c.fields.Access_Token__c.isCreateable()
                           && Schema.sObjectType.Google_Calender_setting__c.fields.Expires_in_Seconds__c.isCreateable()
                           && Schema.sObjectType.Google_Calender_setting__c.fields.Refresh_Token__c.isCreateable()){
                               Google_Calender_setting__c googleSettingInfo = googleSettingInfoList[0];
                               Blob s = Blob.valueOf(String.valueOf(TokenInfo.get('access_token')));
                               String accessTokenHex = EncodingUtil.convertToHex(s);
                               googleSettingInfo.Access_Token__c =String.valueOf(TokenInfo.get('access_token')); // accessTokenHex;
                               googleSettingInfo.Expires_in_Seconds__c = Double.valueOf(TokenInfo.get('expires_in'));
                               googleSettingInfo.Refresh_Token__c = String.valueOf(TokenInfo.get('refresh_token'));
                               
                               update new List<Google_Calender_setting__c>{googleSettingInfo};
                                   }else{
                                       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Insufficient Access'));
                                       return null;
                                   }  
                        // }
                    }else{
                        system.debug('insert store custom setting');
                        if(Schema.sObjectType.Google_Calender_setting__c.isCreateable()
                           && Schema.sObjectType.Google_Calender_setting__c.fields.Access_Token__c.isCreateable()
                           && Schema.sObjectType.Google_Calender_setting__c.fields.Expires_in_Seconds__c.isCreateable()
                           && Schema.sObjectType.Google_Calender_setting__c.fields.Refresh_Token__c.isCreateable()){
                               Google_Calender_setting__c googleSettingInfo = new Google_Calender_setting__c();
                               Blob s = Blob.valueOf(String.valueOf(TokenInfo.get('access_token')));
                               String accessTokenHex = EncodingUtil.convertToHex(s);
                               googleSettingInfo.Name = 'Google CalenderInfo';
                               googleSettingInfo.Access_Token__c = String.valueOf(TokenInfo.get('access_token')); /// accessTokenHex;
                               googleSettingInfo.Expires_in_Seconds__c = Double.valueOf(TokenInfo.get('expires_in'));
                               googleSettingInfo.Refresh_Token__c = String.valueOf(TokenInfo.get('refresh_token'));
                               system.debug('insert store custom setting');
                               insert new List<Google_Calender_setting__c>{googleSettingInfo}; 
                                   }
                    }
                }else{
                    system.debug('insert store custom setting');
                    //if(!Test.isRunningTest() ){
                    if(Schema.sObjectType.Google_Calender_setting__c.isCreateable()
                       && Schema.sObjectType.Google_Calender_setting__c.fields.Access_Token__c.isCreateable()
                       && Schema.sObjectType.Google_Calender_setting__c.fields.Expires_in_Seconds__c.isCreateable()
                       && Schema.sObjectType.Google_Calender_setting__c.fields.Refresh_Token__c.isCreateable()){
                           Google_Calender_setting__c googleSettingInfo = new Google_Calender_setting__c();
                           Blob s = Blob.valueOf(String.valueOf(TokenInfo.get('access_token')));
                           String accessTokenHex = EncodingUtil.convertToHex(s);
                           googleSettingInfo.Name = 'Google CalenderInfo';
                           googleSettingInfo.Access_Token__c = String.valueOf(TokenInfo.get('access_token')); /// accessTokenHex;
                           googleSettingInfo.Expires_in_Seconds__c = Double.valueOf(TokenInfo.get('expires_in'));
                           googleSettingInfo.Refresh_Token__c = String.valueOf(TokenInfo.get('refresh_token'));
                           system.debug('insert store custom setting');
                           insert new List<Google_Calender_setting__c>{googleSettingInfo};
                               }else{
                                   ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Insufficient Access'));
                                   return null;
                               }
                    //}
                }
                return pageRef;
            }else{
                errorMessage = 'Unexpected Error while communicating with Google Calendar API. '
                    +'Status '+response.getStatus()+' and Status Code '+response.getStatuscode();
                return null;
            }     
        }catch(System.Exception e){
            System.debug('Error:-'+e.getMessage()+' '+e.getLineNumber());
            if(String.valueOf(e.getMessage()).startsWith('Unauthorized endpoint')){
                errorMessage = 'Unauthorize endpoint: An Administer must go to Setup -> Administer -> Security Control ->'
                    +' Remote Site Setting and add '+' '+ endPoint +' Endpoint';
                return null;
            }else{
                errorMessage = 'Unexpected Error while communicating with Google Calendar API. ';
                return null;
            }
        }  
        
    }
    public static string getAccessTokenFromRefreshToken(string refreshToken)
    {
        String accessToken;
        if (Schema.sObjectType.GoogleAPICredentials_pub__c.isAccessible() 
            && Schema.sObjectType.GoogleAPICredentials_pub__c.fields.ConsumerKey__c.isAccessible() 
            && Schema.sObjectType.GoogleAPICredentials_pub__c.fields.clientSecret__c.isAccessible()){
                List<GoogleAPICredentials_pub__c> googleAPICredential = [Select Id,ConsumerKey__c,clientSecret__c from GoogleAPICredentials_pub__c  LIMIT 50000];
                if(googleAPICredential.size() > 0)
                {
                    consumerKey = googleAPICredential[0].ConsumerKey__c; 
                    clientSecret = googleAPICredential[0].clientSecret__c;   
                } 
            }
        else
        {
            return '';
        }
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        string endPointValue = 'https://www.googleapis.com/oauth2/v4/token';
        req.setEndpoint(endPointValue);  
        string bodyRequest = 'client_id='+consumerKey+'&client_secret='+clientSecret+'&refresh_token='+refreshToken+'&grant_type=refresh_token';
        system.debug('===bodyRequest==='+bodyRequest);
        req.setBody(bodyRequest);       
        req.setHeader('Content-length', string.ValueOf(bodyRequest.length()));   
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');  
        req.setMethod('POST');
        req.setTimeout(10000);
        HttpResponse res = h.send(req);
        System.debug('Response Value:'+res.getBody());  
        if(res.getBody() != null && res.getStatusCode()==200){
            Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());  
            System.debug(' ====You can parse the response to get the access token ==== ' + results); 
            accessToken=string.valueOf(results.get('access_token'));  
            system.debug('====accessToken==='+accessToken);  
            return accessToken;
        }
        return '';
    }
    
    public static void getMyCalendar(){
        request = new HttpRequest();
        request.setMethod('GET');
        //List<CalendarEndpoint__c> calendarEndpointInfoList = new List<CalendarEndpoint__c>();
        //calendarEndpointInfoList = CalendarEndpoint__c.getAll().values();
        
        CalendarEndpoint__c calendarEndpointInfo = [SELECT Id, Google_Calendar_Endpoint__c, Outlook_calendar_endpoint__c FROM CalendarEndpoint__c WHERE Id != Null];
        
        //https://www.googleapis.com/calendar/v3/calendars/calendarId/events/eventId
        //Endpoint=https://www.googleapis.com/calendar/v3/users/me/calendarList
        
        request.setEndpoint('callout:GoogleAPI/'+calendarEndpointInfo.Google_Calendar_Endpoint__c); 
        response = http.send(request); 
        System.debug('body--:'+response.getBody());
        Map<String, Object> root;
        if(response.getStatusCode() == 200){
            List<Google_Calendar_Event__c> googleCalendarEvtList = new List<Google_Calendar_Event__c>();
            
            root = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
            List<Object> items = (List<Object>)root.get('items');
            system.debug('googleCalendarEvtList---'+googleCalendarEvtList);
            if(Schema.sObjectType.Google_Calendar_Event__c.fields.Event_id__c.isCreateable()
               && Schema.sObjectType.Google_Calendar_Event__c.fields.Subject__c.isCreateable()
               && Schema.sObjectType.Google_Calendar_Event__c.fields.Gc_Link__c.isCreateable()
               && Schema.sObjectType.Google_Calendar_Event__c.fields.Start_Date_Time__c.isCreateable()
               && Schema.sObjectType.Google_Calendar_Event__c.fields.Event_id__c.isUpdateable()
               && Schema.sObjectType.Google_Calendar_Event__c.fields.Subject__c.isUpdateable()
               && Schema.sObjectType.Google_Calendar_Event__c.fields.Gc_Link__c.isUpdateable()
               && Schema.sObjectType.Google_Calendar_Event__c.fields.Start_Date_Time__c.isUpdateable()){            
                   for (Object item : items) {
                       
                       Google_Calendar_Event__c googleCalEvtObj =  new Google_Calendar_Event__c();
                       
                       Map<String, Object> itemsMap = (Map<String, Object>)item;
                       googleCalEvtObj.Event_id__c = String.valueOf(itemsMap.get('id'));
                       googleCalEvtObj.Subject__c = String.valueOf(itemsMap.get('summary'));
                       googleCalEvtObj.Gc_Link__c = String.valueOf(itemsMap.get('htmlLink'));
                       //System.debug('start---'+itemsMap.get('start'));
                       if(itemsMap.get('start') != null){
                           Map<String, Object>  customObject = (Map<String, Object>)itemsMap.get('start');
                           //System.debug('customObject----'+customObject.get('dateTime'));
                           if(customObject.get('dateTime') != null && String.valueOf(customObject.get('dateTime')).length() > 0 ) {
                               googleCalEvtObj.Start_Date_Time__c = DateTime.valueOfGMT(string.valueof(customObject.get('dateTime')).replace('T',' '));
                               system.debug('debug398--');
                           }
                           system.debug('debug400--');
                           googleCalendarEvtList.add(googleCalEvtObj);  
                       } 
                   } 
               }
            
            if(Schema.sObjectType.Google_Calendar_Event__c.fields.Event_id__c.isCreateable()
               && Schema.sObjectType.Google_Calendar_Event__c.fields.Subject__c.isCreateable()
               && Schema.sObjectType.Google_Calendar_Event__c.fields.Gc_Link__c.isCreateable()
               && Schema.sObjectType.Google_Calendar_Event__c.fields.Start_Date_Time__c.isCreateable()
               && Schema.sObjectType.Google_Calendar_Event__c.fields.Event_id__c.isUpdateable()
               && Schema.sObjectType.Google_Calendar_Event__c.fields.Subject__c.isUpdateable()
               && Schema.sObjectType.Google_Calendar_Event__c.fields.Gc_Link__c.isUpdateable()
               && Schema.sObjectType.Google_Calendar_Event__c.fields.Start_Date_Time__c.isUpdateable()
               && !(googleCalendarEvtList.isEmpty())){
                system.debug('before upsert-413--');
                   upsert googleCalendarEvtList Event_id__c;
               }
        }
    }
}
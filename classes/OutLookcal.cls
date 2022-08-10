public with Sharing class OutLookcal {
    //@AuraEnabled(cacheable=true)
    /*public static List<Outlook_Calendar_Event__c> fetchOutlookrcds(){
List<Outlook_Calendar_Event__c> getoutlookdata = new List<Outlook_Calendar_Event__c>();
try{
getoutlookdata = [SELECT Subject__c,oc_Link__c,Event_Start_Date__c,Opportunity_Name__c,Demo__c,Activity__c,Demo_Id__c,Opportunity__c,Opportunity__r.Name,Demo_Id__r.Name FROM Outlook_Calendar_Event__c where CreatedById =:UserInfo.getUserId() LIMIT 50000];   

system.debug('getoutlookdata'+getoutlookdata);

}Catch(Exception e)
{
system.debug('Exception '+ e.getStackTraceString());
}
return getoutlookdata;           

}*/
    
    @AuraEnabled
    public static list < Outlook_Calendar_Event__c > fetchOutlookrcds(String sortField, boolean isAsc,Date startDate , Date endDate) {
        String currUserId = UserInfo.getUserId();
        String sSoql = 'SELECT Mighty_S_E__Task_Type__c, Subject__c,oc_Link__c,Event_Start_Date__c,Opportunity_Name__c,Demo__c,Activity__c,Demo_Id__c,Opportunity__c,Opportunity__r.Name,Demo_Id__r.Name ';
        sSoql += 'From Outlook_Calendar_Event__c where CreatedById =:currUserId';
        sSoql += ' AND (Event_Start_Date__c >: startDate AND Event_Start_Date__c <:  endDate)';
        
        system.debug('sortField-->' + sortField);
        
        if (sortField != '') {
            sSoql += ' order by ' + sortField;
            
            // if isAsc is equal tp ture then set 'asc' order otherwise set 'desc' order.
            if (isAsc) {
                sSoql += ' asc';
            } else {
                sSoql += ' desc';
            }
        }
        // set record limit to query 
        sSoql += ' LIMIT 50000';
        
        System.debug('@Developer -->sSoql:' + sSoql);
        
        try {
            system.debug('The query is' + sSoql);
            list <Outlook_Calendar_Event__c> lstResult = Database.query(sSoql);
            return lstResult;
        } 
        catch (Exception ex) {
            System.debug('Error occured:-'+ex.getMessage()+'--'+ex.getLineNumber());
            return null;
        }
    }
    
    
    @AuraEnabled
    public static List<Opportunity> fetchCombobox(){
        List<Opportunity> Oppdata = [SELECT Id,Name,OwnerId FROM Opportunity  WHERE OwnerId=:UserInfo.getUserID()];
        return Oppdata;
    }
    @AuraEnabled
    public static String OutlookCalendar(){
        String reqURL= '';
        try{
            reqURL=  outLook_Calender.createauthorization();  
            return reqURL;
        }catch(Exception ex)  {
            System.debug('error'+ ex.getMessage());
        } return reqURL;
    }
    @AuraEnabled
    public static void doOutlookFetchAccessToken(String code){
        
        try{
            system.debug('doOutlookFetchAccessToken');
            outLook_Calender.doFetchSimpleAccessToken(code);  
            
        }catch(Exception ex)  {
            System.debug('error'+ ex.getMessage());
        }
        
    }
    
    // For List all Outlook Calender 
    @AuraEnabled 
    public static String doStoreListOutlookAllCalendar(){
        string Message = '';
        try{
            system.debug('doStoreListOutlookAllCalendar');
            List<Outlook_Calender_settings__c> tokenList = new List<Outlook_Calender_settings__c>();
            tokenList = [Select Access_Token__c, Expires_in__c, Refresh_Token__c from Outlook_Calender_settings__c];
            if(tokenList.size() > 0)
            {
                
                List<Mighty_S_E__outlook_setting__mdt> outlookData = [select id,Mighty_S_E__sync_up_time__c from Mighty_S_E__outlook_setting__mdt limit 1];
                if(outlookData.size() > 0)
                {
                    String accessToken = outLook_Calender.doRefreshToken(tokenList[0].Refresh_Token__c);//tokenList[0].Access_Token__c;
                    Integer Year = Date.Today().Year();
                    String endPoint = '';
                    String sdate = system.today().year()+ 1+'-'+system.today().month()+'-'+system.today().day();
                    if(outlookData[0].Mighty_S_E__sync_up_time__c == '1 week')
                    { String edate = Datetime.now().addDays(-7).format('yyyy-MM-dd');
                     System.debug('>>>edate<<<'+edate);
                     endPoint = 'https://outlook.office.com/api/v2.0/me/calendarview?startdatetime='+edate+'&enddatetime='+sdate+'';
                    }else if(outlookData[0].Mighty_S_E__sync_up_time__c == '14 Days')
                    {String edate = Datetime.now().addDays(-14).format('yyyy-MM-dd');
                     System.debug('>>>edate<<<'+edate);
                     endPoint = 'https://outlook.office.com/api/v2.0/me/calendarview?startdatetime='+edate+'&enddatetime='+sdate+'';
                    }else if(outlookData[0].Mighty_S_E__sync_up_time__c == '1 Month')
                    {
                        String edate = Datetime.now().addMonths(-1).format('yyyy-MM-dd');
                        System.debug('>>>edate<<<'+edate);
                        endPoint = 'https://outlook.office.com/api/v2.0/me/calendarview?startdatetime='+edate+'&enddatetime='+sdate+'';
                    }else if(outlookData[0].Mighty_S_E__sync_up_time__c == '6 Month')
                    { String edate = Datetime.now().addMonths(-6).format('yyyy-MM-dd');
                     System.debug('>>>edate<<<'+edate);endPoint = 'https://outlook.office.com/api/v2.0/me/calendarview?startdatetime='+edate+'&enddatetime='+sdate+'';
                    }else if(outlookData[0].Mighty_S_E__sync_up_time__c == '1 Year')
                    {String edate = Datetime.now().addMonths(-12).format('yyyy-MM-dd'); endPoint = 'https://outlook.office.com/api/v2.0/me/calendarview?startdatetime='+edate+'&enddatetime='+sdate+'';
                    }else{  endPoint = 'https://outlook.office.com/api/v2.0/me/calendarview?startdatetime='+(Year-1)+'-01-01T00:00:00Z&enddatetime='+Year+'-12-31T00:00:00Z';
                         }
                    System.debug('>>>sdate<<<'+sdate);
                    
                    Set<Id> sid= new Set<Id>();
                    Http http = new Http();
                    HttpRequest httpReq = new HttpRequest();
                    HttpResponse HttpRes = new HttpResponse();
                    system.debug('key ==> Bearer '+accessToken);
                    httpReq.setEndpoint(endpoint);
                    httpReq.setMethod('GET');
                    
                    httpReq.setHeader('Accept','application/json');
                    httpReq.setHeader('Authorization','Bearer '+accessToken);
                    httpReq.setHeader('Prefer','odata.track-changes');
                    httpReq.setHeader('Prefer','odata.maxpagesize=1');
                    
                    if(!Test.isRunningTest()) {    HttpRes = http.send(httpReq);
                                              }else{
                                                  HttpRes = new HttpResponse();
                                                  HttpRes.setStatuscode(200);
                                                  //HttpRes.setBody('{"value":[{"@odata.id":"https://outlook.office.com/api/v2.0/","ID":"AQMkADAwATYwMAItZTZmMC01Mzc0LTAwAi0wMAoARgAAAxrnXhLVE_NLjnuK2Ue7k8UHAPtZoTKh2wVOqn99auq-c9QAAAIBDQAAAPtZoTKh2wVOqn99auq-c9QABDr-gTMAAAA=","CreatedDateTime":"2020-06-11T08:35:23.5202144Z","LastModifiedDateTime":"2020-06-11T08:35:23.7680712Z","ChangeKey":"+1mhMqHbBU6qf31q6r9z1AAEOtn9sg==","Categories":[],"TransactionId":"cf97ed8c-565f-e198-5584-516cbc0af471","OriginalStartTimeZone":"India Standard Time","OriginalEndTimeZone":"India Standard Time","iCalUId":"040000008200E00074C5B7101A82E008000000007286CB3FCB3FD601000000000000000010000000277FE082ED455C4F94E23D5D702513E9","ReminderMinutesBeforeStart":15,"IsReminderOn":true,"HasAttachments":false,"Subject":"CRM and ERP","BodyPreview":"","Importance":"Normal","Sensitivity":"Normal","IsAllDay":false,"IsCancelled":false,"IsOrganizer":true,"IsRoomRequested":false,"AutoRoomBookingStatus":"None","ResponseRequested":true,"SeriesMasterId":null,"ShowAs":"Busy","Type":"SingleInstance","WebLink":"https://outlook.live.com/owa/?itemid=AQMkADAwATYwMAItZTZmMC01Mzc0LTAwAi0wMAoARgAAAxrnXhLVE%2BNLjnuK2Ue7k8UHAPtZoTKh2wVOqn99auq%2Fc9QAAAIBDQAAAPtZoTKh2wVOqn99auq%2Fc9QABDr%2FgTMAAAA%3D&exvsurl=1&path=/calendar/item","OnlineMeetingUrl":null,"IsOnlineMeeting":false,"OnlineMeetingProvider":"Unknown","AllowNewTimeProposals":true,"IsDraft":false,"ResponseStatus":{"Response":"Organizer","Time":"0001-01-01T00:00:00Z"},"Body":{"ContentType":"HTML","Content":""},"Start":{"DateTime":"2020-06-10T02:30:00.0000000","TimeZone":"UTC"},"End":{"DateTime":"2020-06-10T03:00:00.0000000","TimeZone":"UTC"},"Location":{"DisplayName":"","LocationType":"Default","UniqueIdType":"Unknown","Address":{"Type":"Unknown"},"Coordinates":{}},"Locations":[],"Recurrence":null,"AutoRoomBookingOptions":null,"Attendees":[],"Organizer":{"EmailAddress":{"Name":"Akshat Ajmera","Address":"aajmera10@hotmail.com"}},"OnlineMeeting":null},{"@odata.id":"https://outlook.office.com/api/v2","@odata.etag":"W/\"+1mhMqHbBU6qf31q6r9z1AAEOtnZUA==\"","Id":"AQMkADAwATYwMAItZTZmMC01Mzc0LTAwAi0wMAoARgAAAxrnXhLVE_NLjnuK2Ue7k8UHAPtZoTKh2wVOqn99auq-c9QAAAIBDQAAAPtZoTKh2wVOqn99auq-c9QABDr-gTEAAAA=","CreatedDateTime":"2020-06-10T14:22:31.076711Z","LastModifiedDateTime":"2020-06-10T14:28:08.9833949Z","ChangeKey":"+1mhMqHbBU6qf31q6r9z1AAEOtnZUA==","Categories":[],"TransactionId":"541d7c30-1e8d-ddfa-91e3-9d1b846443bc","OriginalStartTimeZone":"India Standard Time","OriginalEndTimeZone":"India Standard Time","iCalUId":"040000008200E00074C5B7101A82E0080000000021B09293323FD601000000000000000010000000CED1BB16200EAB44BF82D1BAFFDB1103","ReminderMinutesBeforeStart":15,"IsReminderOn":true,"HasAttachments":false,"Subject":"Black Buck","BodyPreview":"","Importance":"Normal","Sensitivity":"Normal","IsAllDay":false,"IsCancelled":false,"IsOrganizer":true,"IsRoomRequested":false,"AutoRoomBookingStatus":"None","ResponseRequested":true,"SeriesMasterId":null,"ShowAs":"Busy","Type":"SingleInstance","WebLink":"https://outlook.live.com/owa/?itemid=AQMkADAwATYwMAItZTZmMC01Mzc0LTAwAi0wMAoARgAAAxrnXhLVE%2BNLjnuK2Ue7k8UHAPtZoTKh2wVOqn99auq%2Fc9QAAAIBDQAAAPtZoTKh2wVOqn99auq%2Fc9QABDr%2FgTEAAAA%3D&exvsurl=1&path=/calendar/item","OnlineMeetingUrl":null,"IsOnlineMeeting":false,"OnlineMeetingProvider":"Unknown","AllowNewTimeProposals":true,"IsDraft":false,"ResponseStatus":{"Response":"Organizer","Time":"0001-01-01T00:00:00Z"},"Body":{"ContentType":"HTML","Content":""},"Start":{"DateTime":"2020-06-10T14:30:00.0000000","TimeZone":"UTC"},"End":{"DateTime":"2020-06-10T15:00:00.0000000","TimeZone":"UTC"},"Location":{"DisplayName":"","LocationType":"Default","UniqueIdType":"Unknown","Address":{"Type":"Unknown"},"Coordinates":{}},"Locations":[],"Recurrence":null,"AutoRoomBookingOptions":null,"Attendees":[],"Organizer":{"EmailAddress":{"Name":"Akshat Ajmera","Address":"aajmera10@hotmail.com"}},"OnlineMeeting":null}]}');
                                                  HttpRes.setBody('{"value":[{"Id":"uh24i734yhf23f1093id1","Subject":"CheckDaynm","WebLink":"https://outlook.office.com/api/v2.0/","Start":{"DateTime":"2020-06-10T02:30:00.0000000","TimeZone":"UTC"},"End":{"DateTime":"2020-06-10T03:00:00.0000000","TimeZone":"UTC"}}], "expires_in":"3600", "refresh_token":"test453", "scope":"https://outlook.office.com/api/v2.0", "token_type":"Bearer"}');
                                              }
                    
                    
                    if(httpRes.getStatusCode() == 200){
                        
                        /*showbtn = 'block';*/
                        System.debug('#### HtteRes '+HttpRes.getBody());
                        
                        Map<String,List<Object>> mapCalAtt = new Map<String,List<Object>>();
                        Set<Outlook_Calendar_Event__c> myset = new Set<Outlook_Calendar_Event__c>();
                        
                        List<Outlook_Calendar_Event__c> listdata = new List<Outlook_Calendar_Event__c>();
                        Map<String, Object> root = (Map<String, Object>)JSON.deserializeUntyped(HttpRes.getBody());
                        System.debug('>>>root<<<'+root);
                        List<Object> items = (List<Object>)root.get('value');
                        for (Object item : items) {
                            
                            Outlook_Calendar_Event__c gce =  new Outlook_Calendar_Event__c();
                            Map<String, Object> i = (Map<String, Object>)item;
                            gce.Event_id_Unique__c = String.valueOf(i.get('Id'));
                            gce.Subject__c = String.valueOf(i.get('Subject'));
                            gce.oc_Link__c = String.valueOf(i.get('WebLink'));
                            gce.Mighty_S_E__Task_Type__c = String.valueOf(i.get('Type'));
                            Map<String, Object>  customObject = (Map<String, Object>)i.get('Start');
                            system.debug('Subject--->'+customObject);
                            if(customObject.get('DateTime') != null && String.valueOf(customObject.get('DateTime')).length() > 0 ) {
                                gce.Event_Start_Date__c = Date.valueOf(string.valueof(customObject.get('DateTime')));
                            }
                            
                            myset.add(gce);  
                            system.debug('myset--->'+myset);
                            
                        }
                        listdata.addAll(myset);
                        System.debug('>>>listData<<<'+listData);
                        if(!(listdata.isEmpty())){
                            
                            Database.SaveResult[] srList = Database.insert(listdata, false);
                            // Iterate through each returned result
                            for (Database.SaveResult sr : srList) {
                                if (sr.isSuccess()) {
                                    // Operation was successful, so get the ID of the record that was processed
                                    sid.add(sr.getId());
                                    
                                    System.debug('Successfully inserted ID: ' + sid);
                                }
                                else {
                                    // Operation failed, so get all errors                
                                    for(Database.Error err : sr.getErrors()) {
                                        System.debug('The following error has occurred.');                    
                                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                                        System.debug('Account fields that affected this error: ' + err.getFields());
                                    }
                                }
                            }
                            
                            system.debug('mapCalAtt-->'+mapCalAtt);
                            Map<String,Id> mapCalendar = new  Map<String,Id>();
                            List<Outlook_Calendar_Event_Attendee__c> listatt =new List<Outlook_Calendar_Event_Attendee__c>();
                            for(Outlook_Calendar_Event__c gc : listdata){
                                if(gc.Id != null){
                                    mapCalendar.put(gc.Event_id__c,gc.Id);
                                    system.debug('eventid-->'+mapCalAtt.get(gc.Event_id__c));
                                    List<Object> attRoot = mapCalAtt.get(gc.Event_id__c);
                                    system.debug('attRoot-->'+attRoot);
                                    List<Object> attitems;//  = (List<Object>)attRoot.get('attendees');
                                    if(attRoot != null){
                                        for (Object item : attRoot) {
                                            Outlook_Calendar_Event_Attendee__c att =  new Outlook_Calendar_Event_Attendee__c();
                                            Map<String, Object> emailAdd = (Map<String, Object>)item;
                                            Map<String, Object> i = (Map<String, Object>)emailAdd.get('EmailAddress');
                                            system.debug('ai-->'+i.get('Address'));
                                            if(i.get('Address') != null && String.valueOf(i.get('Address')).length() > 0 ) {
                                                att.Email__c = String.valueOf(i.get('Address'));
                                                att.Outlook_Calendar_Event__c = gc.id ;
                                                att.Name = String.valueOf(i.get('Name'));
                                                
                                                listatt.add(att);  
                                            }
                                        }
                                    }
                                }
                            }
                            if(!(listatt.isEmpty()))
                                insert listatt;
                        }
                        Message = 'Success';
                        // ApexPages.addmessage(new ApexPages.message(
                        //  ApexPages.severity.CONFIRM,'Calendar List Retrieved Successfully '));
                    }else{
                        String errorMessage = 'Unexpected Error while communicating with Outlook Calendar API. '
                            +'Status '+HttpRes.getStatus()+' and Status Code '+HttpRes.getStatuscode();
                        Message = 'Error: Please Login into Outlook Calendar to sync your events';
                        //  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,errorMessage));
                    }  
                }else{
                    String errorMessage = 'Please set outlook configuration in custom metadata';
                    Message = 'Error: '+errorMessage;
                }
            }else{
                String errorMessage = 'Please Login into Outlook Calendar to sync your events';
                Message = 'Error: '+errorMessage;
            }
        }catch(System.Exception e){
            System.debug('#### Exception Executed '+e.getStackTraceString() +'  '+e.getMessage());
            Message = 'Error: '+e.getStackTraceString() +'  '+e.getMessage();
        }
        return Message;
    }
    
    
    
    @AuraEnabled
    public static List<Mighty_S_E__Demos__c> fetchCombo(){
        List<Mighty_S_E__Demos__c> Demodata = [SELECT Id,Name FROM Mighty_S_E__Demos__c ];
        return Demodata;
    }
    @AuraEnabled
    public static List < Outlook_Calendar_Event__c> saveAccount(List<Outlook_Calendar_Event__c> listOfAccount) {
        update listOfAccount;
        return listOfAccount;
    }
    @AuraEnabled
    public static boolean updateAccounts(List<Outlook_Calendar_Event__c> editedAccountList){
        try{
            update editedAccountList;
            return true;
        } catch(Exception e){ return false;
                            }
    }
    
    @AuraEnabled
    public static String getBaseUrl () {
        return System.URL.getSalesforceBaseUrl().toExternalForm();
    }
    
    @AuraEnabled  
    public static List<String> getPicklistValues(String ObjectApi_name,String Field_name){ 
        
        List<String> lstPickvals=new List<String>();
        try{
            Schema.SObjectType targetType = Schema.getGlobalDescribe().get(ObjectApi_name);
            Sobject obj2 = targetType.newSObject();
            Schema.sObjectType sobject_type = obj2.getSObjectType(); 
            Schema.DescribeSObjectResult sobject_describe = sobject_type.getDescribe(); 
            Map<String, Schema.SObjectField> field_map = sobject_describe.fields.getMap(); 
            List<Schema.PicklistEntry> pick_list_values = field_map.get(Field_name).getDescribe().getPickListValues(); 
            for (Schema.PicklistEntry a : pick_list_values) {
                lstPickvals.add(a.getValue());
            }
            System.debug('lstPickvals'+lstPickvals);} catch(Exception e){ 
                System.debug('error'+e.getMessage()+'---'+e.getStackTraceString());
            }
        return lstPickvals;
    }
    
    @AuraEnabled  
    public static List<String> getTaskPicklistValues(String ObjectApi_name,String Field_name){ 
        
        List<String> lstPickvals=new List<String>();
        try{
            Schema.SObjectType targetType = Schema.getGlobalDescribe().get(ObjectApi_name);
            Sobject obj2 = targetType.newSObject();
            Schema.sObjectType sobject_type = obj2.getSObjectType(); 
            Schema.DescribeSObjectResult sobject_describe = sobject_type.getDescribe(); 
            Map<String, Schema.SObjectField> field_map = sobject_describe.fields.getMap(); 
            List<Schema.PicklistEntry> pick_list_values = field_map.get(Field_name).getDescribe().getPickListValues(); 
            for (Schema.PicklistEntry a : pick_list_values) {
                lstPickvals.add(a.getValue());
            }
            System.debug('lstPickvals'+lstPickvals);
        }  
        catch(Exception e){ 
            System.debug('error'+e.getMessage()+'---'+e.getStackTraceString());
        }
        return lstPickvals;
    }
}
public class GoogleCal {
    // @AuraEnabled(cacheable=true)
    /*public static List<Mighty_S_E__Google_Calendar_Event__c> getAllgoogleList(){
List<Mighty_S_E__Google_Calendar_Event__c> getgoogledata = new List<Mighty_S_E__Google_Calendar_Event__c>();
try{
system.debug('in'); 
getgoogledata = [SELECT Mighty_S_E__Gc_Link__c, Mighty_S_E__Subject__c, Mighty_S_E__Event_Start_Date__c, Mighty_S_E__Opportunity__r.Name, Mighty_S_E__Demo_Id__r.Name, Mighty_S_E__Opportunity_Name__c,Mighty_S_E__Demo__c,Mighty_S_E__Activity__c FROM Mighty_S_E__Google_Calendar_Event__c  where CreatedById =:UserInfo.getUserId() order by createdDate DESC];     
system.debug('getgoogledata'+getgoogledata); 
}catch(Exception ex)   {
system.debug('Error---->'+ex.getMessage()); 
}

return getgoogledata;
}*/
    
    @AuraEnabled
    public static list < Mighty_S_E__Google_Calendar_Event__c > getAllgoogleList(String sortField, boolean isAsc,Date startDate , Date endDate) {
        System.debug('isasc #### '+isAsc);
        String currUserId = UserInfo.getUserId();
        DateTime sDatetime = startDate;
        DateTime eDatetime = endDate;
        //String sDate = String.valueOf(sDatetime);
        //String eDate = String.valueOf(eDatetime);
        String sSoql = 'SELECT Mighty_S_E__Gc_Link__c, Mighty_S_E__Subject__c, Mighty_S_E__Start_Date_Time__c, Mighty_S_E__Task_Type__c, '
            +'Mighty_S_E__Opportunity__r.Name, Mighty_S_E__Demo_Id__r.Name, Mighty_S_E__Opportunity_Name__c,Mighty_S_E__Demo__c, '
            +'Mighty_S_E__Activity__c From Mighty_S_E__Google_Calendar_Event__c where CreatedById =:currUserId'
            +' AND (Mighty_S_E__Start_Date_Time__c >: sDatetime AND Mighty_S_E__Start_Date_Time__c <:  eDatetime)';
        
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
        sSoql += ' LIMIT 20';
        
        System.debug('@Developer -->sSoql:' + sSoql);
        
        try {
            system.debug('The query is' + sSoql);
            list <Mighty_S_E__Google_Calendar_Event__c> lstResult = Database.query(sSoql);
            System.debug('lstResult #### '+lstResult);
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
    public static String googleCalendar(){
        String reqURL= '';
        try{
            reqURL=  GoogleCalenderApi.createauthorization();  
            //GoogleCalenderApi.getMyCalendar();  
            return reqURL;
        }catch(Exception ex)  {
            System.debug('error'+ ex.getMessage());
            return reqURL;
        } 
    }
    /* @AuraEnabled
public static String checkAccessToken()
{

try{
List<Google_Calender_setting__c> tokenList = new List<Google_Calender_setting__c>();
tokenList = [Select Access_Token__c, Expires_in_Seconds__c, Refresh_Token__c from Google_Calender_setting__c order by CreatedDate DESC limit 1];


}catch(Exception ex)  {
System.debug('error'+ ex.getMessage());
}

}*/
    @AuraEnabled
    public static void dogoogleFetchAccessToken(String code){
        system.debug('dogoogleFetchAccessToken');
        GoogleCalenderApi.doFetchSimpleAccessToken(code);  
    }
    
    @AuraEnabled
    public static List<Mighty_S_E__Demos__c> fetchCombo(){
        List<Mighty_S_E__Demos__c	> Demodata = [SELECT Id,Name FROM Mighty_S_E__Demos__c  ];
        return Demodata;
    }
    
    @AuraEnabled
    public static boolean updateAccounts(List<Google_Calendar_Event__c> editedAccountList){
        try{
            update editedAccountList; 
            return true;
        } 
        catch(Exception e){
            System.debug('ERRROR'+ e.getStackTraceString());
            return false;
        }
    }
    @AuraEnabled
    public static List < account > accountsToDisplay() {
        List < Account > returnList = new List < Account > ();
        List < Account > lstOfAccount = [select id, Name, Rating, website from account ];
        for (Account acc: lstOfAccount) {  returnList.add(acc);
                                        }
        return returnList;
    }
    // method for update records after inline editing 
    @AuraEnabled
    public static List < Google_Calendar_Event__c > saveAccount(List<Google_Calendar_Event__c> listOfAccount) {
        system.debug('listOfAccount'+listOfAccount);
        update listOfAccount;
        return listOfAccount;
    }
    // method for fetch picklist values dynamic 
    @AuraEnabled
    public static List < String > getselectOptions(sObject objObject, string fld) {
        List < String > allOpts = new list < String > ();
        Schema.sObjectType objType = objObject.getSObjectType();
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
        map < String, Schema.SObjectField > fieldMap = objDescribe.fields.getMap();
        list < Schema.PicklistEntry > values = fieldMap.get(fld).getDescribe().getPickListValues();
        for (Schema.PicklistEntry a: values) {
            allOpts.add(a.getValue());
        }
        allOpts.sort();
        return allOpts;
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
            System.debug('lstPickvals'+lstPickvals);
        }  
        catch(Exception e){ 
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
    
    
    
    @AuraEnabled
    public static String getBaseUrl () {
        return System.URL.getSalesforceBaseUrl().toExternalForm();
    }
    
    @AuraEnabled  
    public static string doStoreListAllCalendar(){
        system.debug('In doStoreListAllCalendar');
        string Message = '';
        try{
            List<Google_Calender_setting__c> tokenList = new List<Google_Calender_setting__c>();
            tokenList = [Select Access_Token__c, Expires_in_Seconds__c, Refresh_Token__c from Google_Calender_setting__c order by LastModifiedDate DESC limit 1];
            system.debug('size'+tokenList.size());
            
            if(tokenList.size() > 0){
                String refreshToken = tokenList[0].Refresh_Token__c;
                System.debug('>>>>accessToken<<<<'+refreshToken);
                String accessToken = GoogleCalenderApi.getAccessTokenFromRefreshToken(refreshToken);
                System.debug('>>>>accessToken<<<<'+accessToken);
                Set<Id> sid= new Set<Id>();
                
                String endPoint = 'https://www.googleapis.com/calendar/v3/calendars/primary/events';
                
                Http http = new Http();
                HttpRequest httpReq = new HttpRequest();
                HttpResponse HttpRes = new HttpResponse();
                
                httpReq.setEndpoint(endpoint);
                httpReq.setMethod('GET');
                httpReq.setHeader('Content-Type', 'application/json');
                httpReq.setHeader('Authorization','Bearer '+accessToken);
                
                
                if(!Test.isRunningTest()) { HttpRes = http.send(httpReq); }
                else{
                    HttpRes = new HttpResponse(); 
                    HttpRes.setStatuscode(200);
                    HttpRes.setBody('{"kind":"calendar#events","summary":"siddharth.qrioustech@gmail.com",'
                                    +'"updated":"2020-02-28T05:10:54.302Z","timeZone":"Asia/Kolkata","accessRole":"owner",'
                                    +'"defaultReminders":[{"method":"popup","minutes":30}],"nextSyncToken":"CLCeoOW98-cCELCeoOW98-cCGAU=",'
                                    +'"items":[{"kind":"calendar#event","etag":"3105786570444000","id":"8pmm2d82k7di1a3l4tlpthijls",'
                                    +'"status":"confirmed","htmlLink":"https://www.google.com/calendar/event?eid=OHBtb",'
                                    +'"created":"2019-03-18T07:14:45.000Z","updated":"2019-03-18T07:14:45.222Z",'
                                    +'"summary":"This is Test Event Using Calendar API ","location":"B 24 Noida Sec 65",'
                                    +'"creator":{"email":"siddharth.qrioustech@gmail.com","self":true},"organizer":{"email":'
                                    +'"siddharth.qrioustech@gmail.com","self":true},"start":{"dateTime":"2017-11-11T15:00:00+05:30"},'
                                    +'"end":{"dateTime":"2017-11-11T16:00:00+05:30"},"iCalUID":"8pmm2d82k7di1a3l4tlpthijls@google.com",'
                                    +'"sequence":0,"attendees":[{"email":"jheel.qrioustech@gmail.com","responseStatus":"needsAction"}],'
                                    +'"reminders":{"useDefault":true}}]}');
                }
                
                System.debug('#### HtteRes '+HttpRes.getBody());
                if(HttpRes.getStatusCode() == 200){
                    List<Google_Calendar_Event__c> listdata = new List<Google_Calendar_Event__c>();
                    Map<String,List<Object>> mapCalAtt = new Map<String,List<Object>>();
                    Map<String, Object> root = (Map<String, Object>)JSON.deserializeUntyped(HttpRes.getBody());
                    List<Object> items = (List<Object>)root.get('items');
                    
                    for (Object item : items) {
                        Google_Calendar_Event__c gce =  new Google_Calendar_Event__c();
                        Map<String, Object> i = (Map<String, Object>)item;
                        gce.Event_id__c = String.valueOf(i.get('id'));
                        gce.Subject__c = String.valueOf(i.get('summary'));
                        gce.Gc_Link__c = String.valueOf(i.get('htmlLink'));
                        System.debug('start@@'+i.get('start'));
                        if(i.get('start') != null){
                            Map<String, Object>  customObject = (Map<String, Object>)i.get('start');
                            System.debug('customObject@@@'+customObject.get('dateTime'));
                            if(customObject.get('dateTime') != null && String.valueOf(customObject.get('dateTime')).length() > 0 ) {
                                gce.Start_Date_Time__c = DateTime.valueOfGMT(string.valueof(customObject.get('dateTime')).replace('T',' '));
                            }
                            mapCalAtt.put(String.valueOf(i.get('id')), (List<Object>)i.get('attendees'));
                            listdata.add(gce);  
                        }}
                    
                    if(!(listdata.isEmpty())){
                        upsert  listdata Event_id__c;
                        /*
system.debug('mapCalAtt-->'+mapCalAtt);
Map<String,Id> mapCalendar = new  Map<String,Id>();
List<Google_Calendar_Event_Attendee__c> listatt =new List<Google_Calendar_Event_Attendee__c>();

for(Google_Calendar_Event__c gc : listdata){

if(gc.Id != null){
mapCalendar.put(gc.Event_id__c,gc.Id);
system.debug('eventid-->'+mapCalAtt.get(gc.Event_id__c));
List<Object> attRoot = mapCalAtt.get(gc.Event_id__c);
system.debug('attRoot-->'+attRoot);
List<Object> attitems;//  = (List<Object>)attRoot.get('attendees');

if(attRoot != null){
for (Object item : attRoot) {
Google_Calendar_Event_Attendee__c att =  new Google_Calendar_Event_Attendee__c();
Map<String, Object> i = (Map<String, Object>)item;
if(i.get('email') != null && String.valueOf(i.get('email')).length() > 0 ) {
att.Email__c = String.valueOf(i.get('email'));
att.Google_Calendar_Event__c = gc.id ;
att.Name = String.valueOf(i.get('email'));
att.responseStatus__c = String.valueOf(i.get('responseStatus'));
listatt.add(att);  
}
}
}
}
}
if(!(listatt.isEmpty()))
insert listatt;
*/
                    }
                    Message = 'Success ';
                }
                else{String errorMessage = 'Unexpected Error while communicating with Google Calendar API. '
                    +'Status '+HttpRes.getStatus()+' and Status Code '+HttpRes.getStatuscode();
                     Message = 'Error: Please Login into Google Calendar to sync your events';
                     //  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,errorMessage));
                    }  
            }
        }catch(System.Exception e){
            System.debug('#### Exception Executed '+e.getStackTraceString() +'  '+e.getMessage());
            Message = 'Error: '+e.getStackTraceString() +'  '+e.getMessage();
        }
        return Message;
    }
    
}
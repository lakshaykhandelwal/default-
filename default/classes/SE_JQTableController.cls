public with sharing class SE_JQTableController {
    public String data {get;set;}
    public List<sObject> lstEditableTable {get; set;}
    public SE_Chart_Manager__c objChartManager {get; set;}
    public string tablelabels {get; set;}
    public string tableColums {get; set;}
    public static String allOpportunity{get;set;}
    public boolean rowaddflag {get; set;}
    public string JSONdata {get; set;}
    public list<fields> dataFields {get; set;} 
    public list<columns> dataColumns {get; set;}
    public List<Opportunity> oppdatatwo{get;set;}
    public List<Demos__c> demoData{get;set;}
    public static string Objectname;
    
    public string filterquery;
    public String strQuery {get; set;}
    public String strnewQuery {get; set;}
    public Set<String> setFields {get; set;}
    public String strFields {get; set;}
    public string width {get; set;}
    public string savebtnflag {get; set;}
    public integer filterVal {get; set;}
    public static Boolean isListCalendars { get; set; }
    Public static String allCalendars { get; set; }
    public static String showbtn {get; set; }
    public static List<Opportunity> allOpportunities {get;set;}
    public SE_JQTableController()
    {   
        width = '100%';
        savebtnflag =  'none';
        rowaddflag = false;
    }
    /*@RemoteAction
public static Boolean saveTable(string dataToUpdate) {
try{

List<sObject> Lstobj = (List<sObject>)JSON.deserializeUntyped(dataToUpdate);
dynamicUpsert(Lstobj);
return true;
}
catch(exception ex){

return false;
}
}*/
    
    
    /*public static void dynamicUpsert(List<SObject> records)
{
//use GlobalDecribe to get a list of all available Objects
Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
Set<String> objectKeys = gd.keySet();
if(objectKeys.contains(Objectname.toLowerCase()))
{
try
{
//Creating a new sObject
sObject sObj = Schema.getGlobalDescribe().get(ObjectName).newSObject() ;
sObj.put('name' , records) ;
upsert sObj;
}
Catch(Exception e)
{

}
}
else
{

}
}*/
    public SE_Chart_Manager__c getquery()
    {
        return objChartManager;
    }
    
    public void setquery(SE_Chart_Manager__c obj)
    {   
        objChartManager = obj;
        width = objChartManager.width__c+'%' ;
        strQuery = 'Select '+objChartManager.Fields__c+' from '+objChartManager.Object_Name__c +' where '+ objChartManager.Where_Condition__c +' '+ objChartManager.GroupByOrderByLimit__c; 
        System.debug('----Data--TableQuery--'+strQuery);
        dataFields = new list<fields>();
        dataColumns = new list<columns>();
        list<String> arrFields = objChartManager.Column__c.split(',');
        list<string> arrLabel =  objChartManager.Fields_Labels__c.split(',');
        String[] demolist = new List<String>();
        String[] Oppolist = new List<String>();
        String[] actlist = new List<String>();
        if(objChartManager.Object_Name__c == 'Mighty_S_E__Outlook_Calendar_Event__c' || objChartManager.Object_Name__c == 'Mighty_S_E__Google_Calendar_Event__c')
        {
            
            if(Schema.SObjectType.Opportunity.isAccessible()
               && Schema.SObjectType.Opportunity.fields.Name.isAccessible()){
                   oppdatatwo = [Select Name from Opportunity];    
               }
            else{  ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'Error: user can not access this object'));
            }
            
            for(Opportunity oppVar:oppdatatwo){  Oppolist.add(oppVar.Name);
            }
            
            if(Schema.SObjectType.Demos__c.isAccessible()
               && Schema.SObjectType.Demos__c.fields.Name.isAccessible()){
                   demoData = [Select Name from Demos__c];    
               }
            else{ ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'Error: user can not access this object'));
            }
            
            
            for(Demos__c demoVar:demoData){ demolist.add(demoVar.Name);
            }
        }
        //  allOpportunity=JSON.serialize(oppdatatwo);
        integer i = 0;
        setFields = new Set<String>();
        strFields = '';
        for(string flds : arrFields)
        {
            fields objfields = new fields();
            system.debug('flds--'+flds);
            List<string> lstfields =  flds.split('@');
            objfields.name =  String.valueOf(lstfields[0].trim());
            objfields.type =  String.valueOf(lstfields[1].trim());
            setFields.add(String.valueOf(lstfields[0].trim()));
            dataFields.add(objfields);
            columns objCol = new columns();
            objCol.datafield = lstfields[0].trim();
            List<string> lstlabels = arrLabel[i].split('@');
            objCol.text =  String.valueOf(lstlabels[0]).trim();
            objCol.width = String.valueOf(lstlabels[1]+'%').trim();
            objCol.hidden = Boolean.valueOf(lstlabels[2]);
            objCol.editable = Boolean.valueOf(lstlabels[3]);
            System.debug('objfields.name'+objfields.name);
            if(lstlabels.size() > 4) {  objCol.filtertype = '@'+lstlabels[4]+'@';}
            if(lstlabels.size() > 5) { objCol.cellsrenderer = '@'+lstlabels[5]+'@';}
            if(Boolean.valueOf(lstlabels[3])){ savebtnflag = 'block';rowaddflag = true; 
            }
            string coltype =lstfields[1].trim();
            switch on coltype.toLowerCase() {
                when 'string' {  
                    system.debug('When String-->' +coltype.toLowerCase()); 
                    objCol.columntype = 'input';   
                }  
                when 'integer','decimal'  {
                    system.debug('When Number-->' +coltype.toLowerCase());     
                    objCol.columntype = 'numberinput';   
                }   
                when 'date' {    
                    system.debug('When Date-->' +coltype.toLowerCase());  
                    objCol.columntype = 'datetimeinput';  
                }
                when 'boolean' {       
                    objCol.columntype = 'checkbox';  
                }
                when 'picklist' {       
                    objCol.columntype = 'dropdownlist';  
                }
                when else {     
                    system.debug('When Default-->' +coltype.toLowerCase());  
                    objCol.columntype = 'input'; 
                }
            }
            if(objCol.columntype == 'dropdownlist' && (objChartManager.Object_Name__c == 'MightySE__Google_Calendar_Event__c' || objChartManager.Object_Name__c == 'MightySE__Outlook_Calendar_Event__c') && objfields.name =='MightySE__Opportunity_Name__c')
            {
                string drpdown =   JSON.serializePretty(Oppolist).replace('\"', '\''); objCol.createeditor = '@'+String.valueOf('function (row, cellvalue, editor, celltext, cellwidth, cellheight) {var dataSource =  '+ drpdown +';editor.jqxDropDownList({source: dataSource });}')+'@';  
            }
            if(objCol.columntype == 'dropdownlist' && (objChartManager.Object_Name__c == 'MightySE__Google_Calendar_Event__c' || objChartManager.Object_Name__c == 'MightySE__Outlook_Calendar_Event__c') &&  objfields.name =='MightySE__Demo__c')
            {
                string drpdown1 =   JSON.serializePretty(demolist).replace('\"', '\'');   objCol.createeditor = '@'+String.valueOf('function (row, cellvalue, editor, celltext, cellwidth, cellheight) {var dataSource =  '+ drpdown1 +';editor.jqxDropDownList({source: dataSource });}')+'@';  
            }
            if(objCol.columntype == 'dropdownlist' && (objChartManager.Object_Name__c == 'MightySE__Google_Calendar_Event__c' || objChartManager.Object_Name__c == 'MightySE__Outlook_Calendar_Event__c') && objfields.name =='MightySE__Activity__c' ){
                string drpdown2 =   JSON.serializePretty(actlist).replace('\"', '\''); objCol.createeditor = '@'+String.valueOf('function (row, cellvalue, editor, celltext, cellwidth, cellheight) {var dataSource =  '+ drpdown2 +';editor.jqxDropDownList({source: dataSource });}')+'@';
            }
            /*if(objCol.columntype == 'dropdownlist' && objChartManager.Object_Name__c == 'MightySE__Outlook_Calendar_Event__c' && objfields.name == 'MightySE__Opportunity_Name__c' )
{
string drpdown3 =   JSON.serializePretty(Oppolist1).replace('\"', '\'');
objCol.createeditor = '@'+String.valueOf('function (row, cellvalue, editor, celltext, cellwidth, cellheight) {var dataSource =  '+ drpdown3 +';editor.jqxDropDownList({source: dataSource });}')+'@';  
}
if(objCol.columntype == 'dropdownlist' && objChartManager.Object_Name__c == 'MightySE__Outlook_Calendar_Event__c' &&  objfields.name =='MightySE__Demo__c')
{
string drpdown4 =   JSON.serializePretty(demolist1).replace('\"', '\'');
objCol.createeditor = '@'+String.valueOf('function (row, cellvalue, editor, celltext, cellwidth, cellheight) {var dataSource =  '+ drpdown4 +';editor.jqxDropDownList({source: dataSource });}')+'@';  
}
if(objCol.columntype == 'dropdownlist' && objChartManager.Object_Name__c == 'MightySE__Outlook_Calendar_Event__c' && objfields.name =='MightySE__Activity__c' ){
string drpdown2 =   JSON.serializePretty(actlist).replace('\"', '\'');
objCol.createeditor = '@'+String.valueOf('function (row, cellvalue, editor, celltext, cellwidth, cellheight) {var dataSource =  '+ drpdown2 +';editor.jqxDropDownList({source: dataSource });}')+'@';
}*/
            
            dataColumns.add(objCol);
            i++;    
        }
        strFields = JSON.serialize(setFields);
        // = Database.query(strQuery);
        //system.debug('--Data--'+lstEditableTable);
        //data = JSON.serialize(lstEditableTable);
        //System.debug('--Data--'+data);
        tablelabels = JSON.serialize(dataFields);
        System.debug('--tablelabels--'+tablelabels);
        tableColums = JSON.serialize(dataColumns);
        System.debug('--tableColums-Old-'+tableColums);
        tableColums = tableColums.replace('@"', '');
        System.debug('--tableColums-Middle-'+tableColums);
        tableColums =  tableColums.replace('"@', '');
        System.debug('--tableColums-Final-'+tableColums);
    }
    
    public class fields{
        string name;
        string type;
    }
    public class columns{
        string text;
        string datafield;
        string filtertype;
        string width;
        boolean hidden;
        
        boolean editable;
        string columntype;
        string cellsrenderer;
        string createeditor;
        
    }
    
    public SE_Chart_Manager__c getstrnewQuery()
    {
        return objChartManager;
    }
    
    
    public void setstrnewQuery(SE_Chart_Manager__c obj) {   
        objChartManager = obj;
        Objectname = objChartManager.Object_Name__c;
        if(Objectname == 'Event') { 
            //filterVal = 2;
            if(filterVal == 1)
            {
                filterquery = 'And EventSubtype=Low or EventSubtype=High';
            }else if(filterVal == 2)
            {filterquery = 'And EventSubtype=High or EventSubtype=Low';
            }else{filterquery = ' ';  
            }
            width = objChartManager.width__c+'%' ;
            strQuery = 'Select '+objChartManager.Fields__c+' from '+objChartManager.Object_Name__c +' where '+ objChartManager.Where_Condition__c +' '+filterquery+' '+ objChartManager.GroupByOrderByLimit__c; 
            System.debug('----Data--TableQuery--'+strQuery);
            dataFields = new list<fields>();
            dataColumns = new list<columns>();
            list<String> arrFields = objChartManager.Column__c.split(',');
            list<string> arrLabel =  objChartManager.Fields_Labels__c.split(',');
            //list<Opportunity> opps = new list<Opportunity>();
            //opps = [Select Name from Opportunity];
            integer i = 0;
            setFields = new Set<String>();
            strFields = '';
            for(string flds : arrFields)
            {
                fields objfields = new fields();
                system.debug('flds--'+flds);
                List<string> lstfields =  flds.split('@');
                system.debug('lstfields--'+lstfields);
                objfields.name =  String.valueOf(lstfields[0].trim());
                objfields.type =  String.valueOf(lstfields[1].trim());
                setFields.add(String.valueOf(lstfields[0].trim()));
                dataFields.add(objfields);
                columns objCol = new columns();
                objCol.datafield = lstfields[0].trim();
                List<string> lstlabels = arrLabel[i].split('@');
                system.debug('lstlabels--'+lstlabels);
                objCol.text =  String.valueOf(lstlabels[0]).trim();
                objCol.width = String.valueOf(lstlabels[1]+'%').trim();
                objCol.hidden = Boolean.valueOf(lstlabels[2]);
                objCol.editable = Boolean.valueOf(lstlabels[3]);
                if(Boolean.valueOf(lstlabels[3])){savebtnflag = 'block';   rowaddflag = true; 
                }
                string coltype =lstfields[1].trim();
                switch on coltype.toLowerCase() {
                    when 'string' {  
                        system.debug('When String-->' +coltype.toLowerCase()); 
                        objCol.columntype = 'input';   
                    }  
                    when 'integer','decimal'  {
                        system.debug('When Number-->' +coltype.toLowerCase());     
                        objCol.columntype = 'numberinput';   
                    }   
                    when 'date' {    
                        system.debug('When Date-->' +coltype.toLowerCase());  
                        objCol.columntype = 'datetimeinput';  
                    }
                    when 'boolean' {       
                        objCol.columntype = 'checkbox';  
                    }
                    when 'picklist' {       
                        objCol.columntype = 'dropdownlist';  
                    }
                    when else {     
                        system.debug('When Default-->' +coltype.toLowerCase());  
                        objCol.columntype = 'input'; 
                    }
                }
                dataColumns.add(objCol);
                i++;    
            }
            strFields = JSON.serialize(setFields);
            tablelabels = JSON.serialize(dataFields);
            System.debug('--tablelabels--'+tablelabels);
            tableColums = JSON.serialize(dataColumns);
            System.debug('--tableColums--'+tableColums);
        }else
        { filterquery = ' ';
        }
        
        system.debug('qwerty---'+filterVal);
        
    }
    
    // For Google Calender Connect
    public static PageReference ConnectCalendar() {
        PageReference pr =  GoogleCalenderApi.authorization();
        doFetchAccessToken();
        return pr;
    }
    
    // For Google Calender Fetch Access Token Store in Custom setting
    
    public static void doFetchAccessToken(){
        GoogleCalenderApi.doFetchAccessToken();
        // doListAllCalendar();
    }
    public static void doListAllCalendar(){
        
        
        try{
            List<Google_Calender_setting__c> tokenList = new List<Google_Calender_setting__c>();
            tokenList = [Select Access_Token__c, Expires_in_Seconds__c, Refresh_Token__c from Google_Calender_setting__c order by CreatedDate DESC limit 1];
            
            if(tokenList.size() >0)
            {
                String accessToken = tokenList[0].Access_Token__c;
                String endPoint = 'https://www.googleapis.com/calendar/v3/calendars/primary/events';
                
                Http http = new Http();
                HttpRequest httpReq = new HttpRequest();
                HttpResponse HttpRes = new HttpResponse();
                
                httpReq.setEndpoint(endpoint);
                httpReq.setMethod('GET');
                httpReq.setHeader('Content-Type', 'application/json');
                httpReq.setHeader('Authorization','Bearer '+accessToken);
                HttpRes = http.send(httpReq);
                if(httpRes.getStatusCode() == 200){
                    isListCalendars = true;
                    showbtn = 'block';
                    System.debug('#### HtteRes '+HttpRes.getBody());
                    allCalendars = HttpRes.getBody();
                    Id userId= UserInfo.getUserId();
                    allOpportunities = [Select id,Name from Opportunity where CreatedById = :userId ];
                    allOpportunity = JSON.serialize(allOpportunities);
                    System.debug('allOpportunity--'+allOpportunity);
                    ApexPages.addmessage(new ApexPages.message(
                        ApexPages.severity.CONFIRM,'Calendar List Retrieved Successfully '));
                }else{  String errorMessage = 'Unexpected Error while communicating with Google Calendar API. '  +'Status '+HttpRes.getStatus()+' and Status Code '+HttpRes.getStatuscode();  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,errorMessage));
                } 
            }
            
        }catch(System.Exception e){
            System.debug('#### Exception Executed '+e.getStackTraceString() +'  '+e.getMessage());
        }
    }
 /* public static void doStoreListAllCalendar(){
        system.debug('In doStoreListAllCalendar');
        
        GoogleCalenderApi.doFetchAccessToken();
        
        
        try{
            List<Google_Calender_setting__c> tokenList = new List<Google_Calender_setting__c>();
            tokenList = [Select Access_Token__c, Expires_in_Seconds__c, Refresh_Token__c from Google_Calender_setting__c order by CreatedDate DESC limit 1];
            system.debug('size'+tokenList.size());
            if(tokenList.size() > 0)
            {
                Set<Id> sid= new Set<Id>();
                String accessToken = tokenList[0].Access_Token__c;
                String endPoint = 'https://www.googleapis.com/calendar/v3/calendars/primary/events';
                
                Http http = new Http();
                HttpRequest httpReq = new HttpRequest();
                HttpResponse HttpRes = new HttpResponse();
                
                httpReq.setEndpoint(endpoint);
                httpReq.setMethod('GET');
                httpReq.setHeader('Content-Type', 'application/json');
                httpReq.setHeader('Authorization','Bearer '+accessToken);
                
                HttpRes = http.send(httpReq);
                System.debug('#### HtteRes '+HttpRes.getBody());
                system.debug('HttpRes.getStatusCode()----'+HttpRes.getStatusCode());
                if(HttpRes.getStatusCode() == 200){
                    isListCalendars = true;
                    showbtn = 'block';
                    System.debug('#### HtteRes '+HttpRes.getBody());
                    allCalendars = HttpRes.getBody();
                    
//GoogleCalendarItems wrapper = GoogleCalendarItems.parse(allCalendars);
//system.debug('wrapper'+wrapper);
                    system.debug('allCalendars'+allCalendars);
                    List<Google_Calendar_Event__c> listdata = new List<Google_Calendar_Event__c>();
                    Map<String,List<Object>> mapCalAtt = new Map<String,List<Object>>();
                    Map<String, Object> root = (Map<String, Object>)JSON.deserializeUntyped(allCalendars);
                    List<Object> items = (List<Object>)root.get('items');
                    for (Object item : items) {
                        Google_Calendar_Event__c gce =  new Google_Calendar_Event__c();
                        Map<String, Object> i = (Map<String, Object>)item;
                        gce.Event_id__c = String.valueOf(i.get('id'));
                        gce.Subject__c = String.valueOf(i.get('summary'));
                        gce.Gc_Link__c = String.valueOf(i.get('htmlLink'));
                        Map<String, Object>  customObject = (Map<String, Object>)i.get('start');
                        if(customObject.get('dateTime') != null && String.valueOf(customObject.get('dateTime')).length() > 0 ) {
                            gce.Event_Start_Date__c = Date.valueOf(string.valueof(customObject.get('dateTime')));
                        }
                        mapCalAtt.put(String.valueOf(i.get('id')), (List<Object>)i.get('attendees'));
                        listdata.add(gce);  
                    }
                    if(!(listdata.isEmpty())){
                        Database.SaveResult[] srList;
                        if(Schema.sObjectType.Google_Calendar_Event__c.fields.Event_id__c.isCreateable()
                        && Schema.sObjectType.Google_Calendar_Event__c.fields.Subject__c.isCreateable()
                        && Schema.sObjectType.Google_Calendar_Event__c.fields.Gc_Link__c.isCreateable()
                        && Schema.sObjectType.Google_Calendar_Event__c.fields.Event_Start_Date__c.isCreateable()){
                            srList = Database.insert(listdata, false);
                        }
                        //Database.SaveResult[] srList = Database.insert(listdata, false);
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
                        if(Schema.sObjectType.Google_Calendar_Event_Attendee__c.fields.Email__c.isCreateable()
                        && Schema.sObjectType.Google_Calendar_Event_Attendee__c.fields.Google_Calendar_Event__c.isCreateable()
                        && Schema.sObjectType.Google_Calendar_Event_Attendee__c.fields.Name.isCreateable()
                        && Schema.sObjectType.Google_Calendar_Event_Attendee__c.fields.Name.isCreateable()
                        && !(listatt.isEmpty())){
                            insert listatt;
                        }
                            
                    }
                    
                    
                }else{
                    String errorMessage = 'Unexpected Error while communicating with Google Calendar API. '
                        +'Status '+HttpRes.getStatus()+' and Status Code '+HttpRes.getStatuscode();
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,errorMessage));
                }
            }}catch(System.Exception e){
                System.debug('#### Exception Executed '+e.getStackTraceString() +'  '+e.getMessage());
            }
    } */
    
    // For Outlook Calender Connect
    public static PageReference ConnectOutlookCalendar(){
        PageReference pr =  outLook_Calender.authorization();
        return pr;
    }
    
    // For Outlook Calender Fetch Access Token Store in Custom setting
    public void doOutlookFetchAccessToken(){
        outLook_Calender.doFetchAccessToken();
        //   doListOutlookAllCalendar();
    }
    // For List all Outlook Calender 
    public static void doListOutlookAllCalendar(){
        
        try{
            List<Outlook_Calender_settings__c> tokenList = new List<Outlook_Calender_settings__c>();
            tokenList = [Select Access_Token__c, Expires_in__c, Refresh_Token__c from Outlook_Calender_settings__c WHERE Id!=null];
            
            if(tokenList.size() > 0)
            {
                String accessToken = tokenList[0].Access_Token__c;
                String endPoint = 'https://outlook.office.com/api/v2.0/me/calendarview?startdatetime=2015-01-01T00:00:00Z&enddatetime=2019-12-31T00:00:00Z';
                
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
                
                HttpRes = http.send(httpReq);
                system.debug('getStatusCode'+httpRes.getStatusCode());
                if(httpRes.getStatusCode() == 200){
                    isListCalendars = true;
                    /*showbtn = 'block';*/
                    System.debug('#### HtteRes '+HttpRes.getBody());
                    allCalendars = HttpRes.getBody();
                    Map<String,List<Object>> mapCalAtt = new Map<String,List<Object>>();
                    Map<String, Object> root = (Map<String, Object>)JSON.deserializeUntyped(allCalendars);
                    List<Object> items = (List<Object>)root.get('value');
                    for (Object item : items) { Map<String, Object> i = (Map<String, Object>)item;
                        system.debug('Subject--->'+i.get('Subject')+'--Start Time -- '+i.get('Start')+'--ENd Time -- '+i.get('End')+'-WebLink -- '+i.get('WebLink')+'-attendees -- '+ i.get('Attendees'));
                        
                    }
                    /* Id userId= UserInfo.getUserId();
allOpportunities = [Select id,Name from Opportunity where CreatedById = :userId ];
allOpportunity = JSON.serialize(allOpportunities);
System.debug('allOpportunity--'+allOpportunity);*/
                    ApexPages.addmessage(new ApexPages.message( ApexPages.severity.CONFIRM,'Calendar List Retrieved Successfully '));
                }else{
                    String errorMessage = 'Unexpected Error while communicating with Google Calendar API. ' +'Status '+HttpRes.getStatus()+' and Status Code '+HttpRes.getStatuscode(); ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,errorMessage));
                }            
            }
            
        }catch(System.Exception e){
            System.debug('#### Exception Executed '+e.getStackTraceString() +'  '+e.getMessage());
        }
    }
    
    // For List all Outlook Calender 
   /* public static void doStoreListOutlookAllCalendar(){
        
        try{
            List<Outlook_Calender_settings__c> tokenList = new List<Outlook_Calender_settings__c>();
            tokenList = [Select Access_Token__c, Expires_in__c, Refresh_Token__c from Outlook_Calender_settings__c WHERE Id!=null];
            if(tokenList.size() > 0)
            {
                List<Mighty_S_E__outlook_setting__mdt> outlookData = [select id,Mighty_S_E__sync_up_time__c from Mighty_S_E__outlook_setting__mdt limit 1];
                if(outlookData.size() > 0)
                {
                    String accessToken = tokenList[0].Access_Token__c;
                    Integer Year = Date.Today().Year();
                    String endPoint = '';
                    String sdate = system.today().year()+'-'+system.today().month()+'-'+system.today().day();
                    if(outlookData[0].Mighty_S_E__sync_up_time__c == '1 week') { String edate = Datetime.now().addDays(-7).format('yyyy-MM-dd'); endPoint = 'https://outlook.office.com/api/v2.0/me/calendarview?startdatetime='+edate+'&enddatetime='+sdate+'';
                    }else if(outlookData[0].Mighty_S_E__sync_up_time__c == '14 Days') {String edate = Datetime.now().addDays(-14).format('yyyy-MM-dd'); endPoint = 'https://outlook.office.com/api/v2.0/me/calendarview?startdatetime='+edate+'&enddatetime='+sdate+'';
                    }else if(outlookData[0].Mighty_S_E__sync_up_time__c == '1 Month')
                    {
                        
                        String edate = Datetime.now().addMonths(-1).format('yyyy-MM-dd');
                        endPoint = 'https://outlook.office.com/api/v2.0/me/calendarview?startdatetime='+edate+'&enddatetime='+sdate+'';  }else if(outlookData[0].Mighty_S_E__sync_up_time__c == '6 Month')
                    { String edate = Datetime.now().addMonths(-6).format('yyyy-MM-dd');  endPoint = 'https://outlook.office.com/api/v2.0/me/calendarview?startdatetime='+edate+'&enddatetime='+sdate+'';
                    }else if(outlookData[0].Mighty_S_E__sync_up_time__c == '1 Year')
                    {  String edate = Datetime.now().addMonths(-12).format('yyyy-MM-dd'); endPoint = 'https://outlook.office.com/api/v2.0/me/calendarview?startdatetime='+edate+'&enddatetime='+sdate+'';
                    }else{ endPoint = 'https://outlook.office.com/api/v2.0/me/calendarview?startdatetime='+(Year-1)+'-01-01T00:00:00Z&enddatetime='+Year+'-12-31T00:00:00Z';
                    }
                    
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
                    
                    HttpRes = http.send(httpReq);
                    if(httpRes.getStatusCode() == 200){
                        isListCalendars = true;
                        //showbtn = 'block';
                        System.debug('#### HtteRes '+HttpRes.getBody());
                        allCalendars = HttpRes.getBody();
                        Map<String,List<Object>> mapCalAtt = new Map<String,List<Object>>();
                        Set<Outlook_Calendar_Event__c> myset = new Set<Outlook_Calendar_Event__c>();
                        
                        List<Outlook_Calendar_Event__c> listdata = new List<Outlook_Calendar_Event__c>();
                        Map<String, Object> root = (Map<String, Object>)JSON.deserializeUntyped(allCalendars);
                        List<Object> items = (List<Object>)root.get('value');
                        for (Object item : items) {
                            
                            Outlook_Calendar_Event__c gce =  new Outlook_Calendar_Event__c();
                            Map<String, Object> i = (Map<String, Object>)item;
                            gce.Event_id_Unique__c = String.valueOf(i.get('Id'));
                            gce.Subject__c = String.valueOf(i.get('Subject'));
                            gce.oc_Link__c = String.valueOf(i.get('WebLink'));
                            Map<String, Object>  customObject = (Map<String, Object>)i.get('Start');
                            system.debug('Subject--->'+customObject);
                            if(customObject.get('DateTime') != null && String.valueOf(customObject.get('DateTime')).length() > 0 ) {
                                gce.Event_Start_Date__c = Date.valueOf(string.valueof(customObject.get('DateTime')));
                            }
                            
                            myset.add(gce);  
                            system.debug('myset--->'+myset);
                            
                        }
                        listdata.addAll(myset);
                        Database.SaveResult[] srList;
                        if(!(listdata.isEmpty())){
                            if(Schema.sObjectType.Outlook_Calendar_Event__c.fields.Event_id_Unique__c.isCreateable()
                            && Schema.sObjectType.Outlook_Calendar_Event__c.fields.Subject__c.isCreateable()
                            && Schema.sObjectType.Outlook_Calendar_Event__c.fields.oc_Link__c.isCreateable()
                            && Schema.sObjectType.Outlook_Calendar_Event__c.fields.Event_Start_Date__c.isCreateable()){
                                srList = Database.insert(listdata, false);
                            }
                            
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
                            if(Schema.sObjectType.Outlook_Calendar_Event_Attendee__c.fields.Email__c.isCreateable()
                            && Schema.sObjectType.Outlook_Calendar_Event_Attendee__c.fields.Outlook_Calendar_Event__c.isCreateable()
                            && Schema.sObjectType.Outlook_Calendar_Event_Attendee__c.fields.Name.isCreateable()
                            && !(listatt.isEmpty())){
                                insert listatt;
                            }
                        }
                        
                        ApexPages.addmessage(new ApexPages.message(
                            ApexPages.severity.CONFIRM,'Calendar List Retrieved Successfully '));
                    }else{
                        String errorMessage = 'Unexpected Error while communicating with Google Calendar API. '
                            +'Status '+HttpRes.getStatus()+' and Status Code '+HttpRes.getStatuscode();
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,errorMessage));
                    }  
                }else{
                    String errorMessage = 'Please fill sync up data';
                }
            }
        }catch(System.Exception e){
            System.debug('#### Exception Executed '+e.getStackTraceString() +'  '+e.getMessage());
        }
    } */
    
    
    
}
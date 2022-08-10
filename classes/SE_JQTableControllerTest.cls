@isTest public class SE_JQTableControllerTest {
	@isTest public static void myTest() {
        Test.setMock(HttpCalloutMock.class, new SE_JQTableControllerMock());
        SE_JQTableController cntrlObj = new SE_JQTableController();
        cntrlObj.data = '';
        cntrlObj.lstEditableTable = new List<sObject>();
        
        cntrlObj.tablelabels = '';
        cntrlObj.tableColums = '';
        SE_JQTableController.allOpportunity = '';
        cntrlObj.rowaddflag = false;
        cntrlObj.JSONdata = '';
        cntrlObj.dataFields = new List<SE_JQTableController.fields>();
        cntrlObj.dataColumns = new List<SE_JQTableController.columns>();
        cntrlObj.oppdatatwo = new List<Opportunity>();
        cntrlObj.demoData = new List<Demos__c>();
        SE_JQTableController.Objectname = 'Account';
        cntrlObj.strQuery = 'Select Id from Account';
        cntrlObj.strnewQuery = 'Select Id from Account';
        cntrlObj.setFields = new Set<String>();
        cntrlObj.strFields = '';
        cntrlObj.width = '';
        cntrlObj.savebtnflag = '';
        cntrlObj.filterVal = 1;
        SE_JQTableController.isListCalendars = true;
        //SE_JQTableController.allCalendars = '';
        SE_JQTableController.showbtn = 'test';
        //SE_JQTableController.allOpportunities();
        //SE_JQTableController.doListAllCalendar();
        SE_Chart_Manager__c objChart = new SE_Chart_Manager__c();
        objChart.Column__c = 'Id@String,Name@String,Name@integer,Name@date,Name@boolean,Name@picklist,Name@test';
        objChart.Fields_Labels__c = '#@10@false@false,Account Name@50@false@false,#@10@false@false,#@10@false@false,#@10@false@false,#@10@false@false,#@10@false@false';
        objChart.Object_Name__c = 'Account';
        objChart.Where_Condition__c = '';
        objChart.GroupByOrderByLimit__c = '';
        
        cntrlObj.objChartManager = objChart;
        SE_Chart_Manager__c obj = cntrlObj.getquery();
        objChart.Object_Name__c = 'Mighty_S_E__Outlook_Calendar_Event__c';
        cntrlObj.setquery(objChart);
        
        objChart.Object_Name__c = 'Event';
        cntrlObj.getstrnewquery();
        cntrlObj.setstrnewquery(objChart);
        
        SE_JQTableController.ConnectCalendar();
        SE_JQTableController.doStoreListAllCalendar();
        SE_JQTableController.doFetchAccessToken();
        cntrlObj.doOutlookFetchAccessToken();
        SE_JQTableController.doStoreListOutlookAllCalendar();
        
        SE_JQTableController.ConnectOutlookCalendar();
       
        
    }
    @isTest public static void myTest1(){
        Google_Calendar_Info__c obj = new Google_Calendar_Info__c();
        obj.Access_Token__c= 'test1';
        obj.Expires_in_Seconds__c=2;
        obj.Refresh_Token__c='test3';
        insert obj;
        
        Google_Calender_setting__c obj1 = new Google_Calender_setting__c();
        obj1.Access_Token__c= 'test1';
        obj1.Expires_in_Seconds__c=2;
        obj1.Refresh_Token__c='test3';
        insert obj1;
            
        Outlook_Calender_settings__c outobj = new Outlook_Calender_settings__c();
        outobj.Access_Token__c= 'test1';
        outobj.Expires_in__c=2;
        outobj.Refresh_Token__c='test3';
        insert outobj;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new SE_JQTableControllerMock());
        Test.stopTest();
        SE_JQTableController.doListAllCalendar();
        SE_JQTableController.doListOutlookAllCalendar();
        SE_JQTableController.doStoreListOutlookAllCalendar();
        SE_JQTableController.doStoreListAllCalendar();
    }
    
}
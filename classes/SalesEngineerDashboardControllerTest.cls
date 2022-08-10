@isTest public class SalesEngineerDashboardControllerTest {
    @isTest public static void myTest(){
        Test.startTest();
        //Test.setMock(HttpCalloutMock.class, new SalesEngineerDashboardControllerMock()); 
        SalesEngineerDashboardController cntrlObj = new SalesEngineerDashboardController();
        cntrlObj.lstChartQueries = new List<ChartQuery__mdt>();
        cntrlObj.queries = new List<SE_Chart_Manager__c>();
        SalesEngineerDashboardController.allOpportunities = new List<Opportunity>();
        SalesEngineerDashboardController.allOpportunity = '';
        SalesEngineerDashboardController.isListCalendars = false;
        SalesEngineerDashboardController.allCalendars = '';
        SalesEngineerDashboardController.showEventbtn = false;
        SalesEngineerDashboardController.showbtn = '';
        HttpRequest hreq = new HttpRequest();
        Google_Calendar_Info__c objGCInfo = new Google_Calendar_Info__c();
        objGCInfo.Access_Token__c = 'aaaaaaaaaaaa';
        objGCInfo.Expires_in_Seconds__c = 10.0;
        objGCInfo.Refresh_Token__c = 'aesdtfyghjkeatrdyfughj';
        insert objGCInfo;
        
        System.assert(cntrlObj!=null);
        Test.stopTest();
    }
}
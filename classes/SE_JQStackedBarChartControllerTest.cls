@isTest public class SE_JQStackedBarChartControllerTest {
    @isTest public static void myTest() {
        SE_JQStackedBarChartController cntrlObj = new SE_JQStackedBarChartController();
        cntrlObj.data = '';
        cntrlObj.lstChart = new List<sObject>();
        cntrlObj.setquery('Select Id from Account');
        cntrlObj.getquery();
        system.assert(cntrlObj!=null);
        
    }
}
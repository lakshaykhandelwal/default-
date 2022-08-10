@isTest public class SE_JQBarChartVerticalControllerTest {
    @isTest public static void myTest(){
        SE_JQBarChartVerticalController cntrlObj = new SE_JQBarChartVerticalController();
        cntrlObj.data = '';
        cntrlObj.lstChart = new List<sObject>();
        cntrlObj.setquery('Select Id from Account');
        cntrlObj.getquery();
        system.assert(cntrlObj!=null);
        
    }
}
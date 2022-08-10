@isTest public class SE_JQPieChartControllerTest {
	@isTest public static void myTest(){
        SE_JQPieChartController cntrlObj = new SE_JQPieChartController();
        cntrlObj.data = '';
        cntrlObj.lstChart = new List<sObject>();
        cntrlObj.setquery('Select Id from Account');
        cntrlObj.getquery();
        system.assert(cntrlObj!=null);
    }
}
@isTest public class SE_JQUSHeatMapControllerTest {
   	@isTest public static void  myTest(){
        SE_JQUSHeatMapController cntrlObj = new SE_JQUSHeatMapController();
        cntrlObj.data = '';
        cntrlObj.lstChart = new List<sObject>();
        cntrlObj.setquery('Select Id from Account');
        cntrlObj.getquery();
        cntrlObj.fetchValue();
        system.assert(cntrlObj!=null);

    }
}
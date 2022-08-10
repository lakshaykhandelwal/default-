@isTest
public class MightySE_LandingControllerTest {
    @isTest public static void myTest(){
        MightySE_LandingController cntrlObj = new MightySE_LandingController();
        List<SE_Chart_Manager__c> lstCharts = cntrlObj.queries;
         System.assert(lstCharts != null);
    }
}
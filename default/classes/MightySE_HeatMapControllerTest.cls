@isTest
public class MightySE_HeatMapControllerTest {
    @isTest public static void  myTest(){
     String dataReturn = '';   
     dataReturn = MightySE_HeatMapController.fetchValue();
     system.debug('dataReturn----'+dataReturn);
     system.assert(dataReturn=='[]');
    }
}
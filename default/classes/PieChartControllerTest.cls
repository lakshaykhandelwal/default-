@isTest public class PieChartControllerTest {
	@isTest public static void  myTest(){
        String name='Test';
        Integer data = 123;
        PieChartController.PieWedgeData cmp = new PieChartController.PieWedgeData(name,data);
        PieChartController obj =new PieChartController();
        List<PieChartController.PieWedgeData> returnDataList = new List<PieChartController.PieWedgeData>();
        returnDataList = obj.getPieData();
        system.debug('returnDataList>>>'+returnDataList);
        system.assert(returnDataList.size()>0);
    }
}
@isTest public class PieChartControllerTest {
	@isTest public static void  myTest(){
        String name='Test';
        Integer data = 123;
        PieChartController.PieWedgeData cmp = new PieChartController.PieWedgeData(name,data);
        PieChartController obj =new PieChartController();
        obj.getPieData();
    }
}
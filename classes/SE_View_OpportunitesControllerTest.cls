@isTest
public class SE_View_OpportunitesControllerTest {
    public testmethod static void myTest(){
        SE_View_OpportunitesController obj = new SE_View_OpportunitesController();
       Boolean result = SE_View_OpportunitesController.saveTable('hello');
       System.assert(result == false);
    }

    public testmethod static void myTest1(){
        SE_View_OpportunitesController obj = new SE_View_OpportunitesController();
        List<Opportunity> lstOpportunity = new List<Opportunity>();
        Opportunity OppObj = new Opportunity();
        OppObj.Name = 'test';
        OppObj.CloseDate = system.today();
        OppObj.StageName = 'Prospecting';
        lstOpportunity.add(OppObj);
        Boolean result = SE_View_OpportunitesController.saveTable(JSON.serialize(lstOpportunity));
        System.assert(result == True);
    }

}
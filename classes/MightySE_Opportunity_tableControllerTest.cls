@isTest
public class MightySE_Opportunity_tableControllerTest {
    @isTest
    public static void  myTest()
    {
        MightySE_Opportunity_tableController.getAllOpportunityData(System.today(),System.today().addDays(5));
        
        List<Opportunity> lstOpportunity =  new List<Opportunity>();
        Account acc = new Account(Name = 'Morris and Ross');
        insert acc;
        Opportunity opp = new Opportunity( Name = 'newOpp',
                                          Type = 'New Customer',
                                          stageName='Prospecting',
                                          CloseDate=Date.Today(),
                                          AccountID = acc.id);
        
        MightySE_Opportunity_tableController.saveAccount(lstOpportunity);
    }
}
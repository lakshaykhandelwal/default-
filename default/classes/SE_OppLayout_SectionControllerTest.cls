@isTest
public class SE_OppLayout_SectionControllerTest {
    @isTest
    public static void testmethod1()
    {
        Account a = new Account( Name = 'Test' );  
        SE_OppLayout_SectionController obj = new SE_OppLayout_SectionController( new ApexPages.StandardController( a ) );
        User u = new User(FirstName = 'testing');
        Opportunity oppor = new Opportunity(Name = 'test3' , StageName = 'Closed Won', CloseDate = Date.newInstance(2019, 04, 25));
        oppor.SalesEngineer__c = u.Id;
        insert oppor;
        //ApexPages.currentPage().getParameters().put('0062v00001CvH0tAAF');
        ApexPages.currentPage().getParameters().put('id',oppor.Id);
        Opportunity opp = obj.getOppData();
        System.assert(opp != null);
    }
    public static testmethod void testmethod2(){
        Account a = new Account( Name = 'Test2' );
        SE_OppLayout_SectionController obj = new SE_OppLayout_SectionController( new ApexPages.StandardController( a ) );
        User u = new User(FirstName = 'testing1');
        Opportunity oppor = new Opportunity(Name = 'test2' , StageName = 'Closed Won', CloseDate = Date.newInstance(2019, 04, 25));
        oppor.SalesEngineer__c = u.Id;
        insert oppor;
        ApexPages.currentPage().getParameters().put('id',oppor.Id);
        List<SObject> eventData = new List<SObject>(); 
        eventData = obj.getEventData();
        System.assert(eventData != null);
    }
    
}
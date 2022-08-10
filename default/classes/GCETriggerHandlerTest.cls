@isTest
public class GCETriggerHandlerTest {
 @isTest
    public static void  myTest()
    {
        Mighty_S_E__Google_Calendar_Event__c  cgceObj =new Mighty_S_E__Google_Calendar_Event__c();
        cgceObj.Subject__c = 'Test';
        cgceObj.Event_id__c = '4poidjj4vbma0g2i83sj5bttgh';
        cgceObj.Event_Start_Date__c =system.today();
        cgceObj.Start_Date_Time__c = system.today();
        insert cgceObj;
        
        Account a = new Account(Name = 'Test Account Joe ');
     
        Opportunity o = new Opportunity();
       
        
        insert a;
        
        o.AccountId = a.Id;
        o.Name = 'Test_Joe_123';
        o.StageName = 'Prospecting';
        o.CloseDate = date.today();
        o.Type = 'New Business';
        insert o;
        
       
        cgceObj.Mighty_S_E__Opportunity__c = o.id;
        update cgceObj;
        Event evnt = [Select Id, Subject, StartDateTime From Event];
        system.assertEquals(cgceObj.Event_Start_Date__c, evnt.StartDateTime);
        
    }
    @isTest
    public static void  myTest2()
    {
        Mighty_S_E__Google_Calendar_Event__c  cgceObj =new Mighty_S_E__Google_Calendar_Event__c();
        cgceObj.Subject__c = 'Test';
        cgceObj.Event_id__c = '4poidjj4vbma0g2i83sj5bttgh';
        cgceObj.Event_Start_Date__c =system.today();
        cgceObj.Start_Date_Time__c = system.today();
        insert cgceObj;
        
        
        Account a = new Account(Name = 'Test Account Joe ');
     
        Opportunity o = new Opportunity();
       
        
        insert a;
        
        o.AccountId = a.Id;
        o.Name = 'Test_Joe_123';
        o.StageName = 'Prospecting';
        o.CloseDate = date.today();
        o.Type = 'New Business';
        insert o;
        
        Event obj= new Event();
        obj.Subject = 'Test';
        obj.StartDateTime = DateTime.valueOf('2017-11-11 00:00:00');
        obj.EndDateTime = DateTime.valueOf('2017-11-15 00:00:00');
        obj.WhatId= o.id;
         obj.Event_Id__c= '4poidjj4vbma0g2i83sj5bttgh';
        obj.Mighty_S_E__Demo__c = null;
        obj.Mighty_S_E__Type__c = 'RFP';
        insert obj;
        cgceObj.Mighty_S_E__Opportunity__c = o.id;
        update cgceObj;
        List<Event> evnt = [Select Id, Subject, StartDateTime, Mighty_S_E__Event_Type__c, WhatId From Event WHERE WhatId =: o.id];
        system.assert(evnt.size()>1);
        
    }
}
@isTest
public class MightySE_Activity_tableControllerTest {
    @isTest
    public static void  myTest()
    {
		MightySE_Activity_tableController.getAllActivityData('New',System.today(),System.today().addDays(5));
        MightySE_Activity_tableController.getAllTaskData('New',System.today(),System.today().addDays(5));
        MightySE_Activity_tableController.getPicklistValues('Account','Mighty_S_E__CustomerPriority__c'); 
        List<event> lstevent =  new List<event>();
        List<Task> lsttask =  new List<Task>();
        
        Account a= new Account ();
        a.name='Test Account';
        insert a;
        
        Event e = new Event();
        e.WhatId=a.id;
        e.StartDateTime=system.today();
        e.EndDateTime=system.today()+5;
        insert e;
        lstevent.add(e);
        MightySE_Activity_tableController.saveAccount(lstevent);
         
        Task t = new Task();
        t.WhatId=a.id;
     	insert t;
        
        lsttask.add(t);
        MightySE_Activity_tableController.saveAccountTask(lsttask);
    }
}
@isTest
public class OutLookcalTest {
    @isTest
    public static void  myTest()
    {
        List < Outlook_Calendar_Event__c> lstevent = new List < Outlook_Calendar_Event__c>();
        Outlook_Calendar_Event__c obj = new Outlook_Calendar_Event__c();
        obj.Mighty_S_E__Subject__c='sdfsd';
        obj.Mighty_S_E__Event_id__c='hweiufheuh';
        obj.Mighty_S_E__Event_Start_Date__c = System.today();
        insert obj;
        lstevent.add(obj);
        Outlook_Calendar_Event_Attendee__c attendee = new Outlook_Calendar_Event_Attendee__c();
        attendee.Mighty_S_E__Outlook_Calendar_Event__c = obj.id;
        attendee.Mighty_S_E__Email__c ='testUser@hotmail.com';
        insert attendee;
        OutLookcal.fetchOutlookrcds('test',true,System.today(),System.today().addDays(5));
        OutLookcal.fetchCombobox();
        OutLookcal.OutlookCalendar();
        OutLookcal.getBaseUrl();
        OutLookcal.doOutlookFetchAccessToken('Test');
        OutLookcal.doStoreListOutlookAllCalendar();
        OutLookcal.fetchCombo();
        OutLookcal.getPicklistValues('Account','Mighty_S_E__CustomerPriority__c');
        OutLookcal.saveAccount(lstevent);
        OutLookcal.updateAccounts(lstevent);
    }
    
    
}
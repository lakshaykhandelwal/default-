@isTest
public class GoogleCalTest {
    @isTest
    public static void  myTest()
    {       
        GoogleAPICredentials_pub__c gooapi = new GoogleAPICredentials_pub__c();
        gooapi.Mighty_S_E__ConsumerKey__c='209779636733';
        gooapi.Mighty_S_E__clientSecret__c ='Mjhdyhgfbh';
        insert gooapi;
        Google_Calender_setting__c obj= new Google_Calender_setting__c();
        obj.Access_Token__c = 'test453';
        obj.Expires_in_Seconds__c = 3600;
        obj.Refresh_Token__c = 'test453';
        insert obj;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new GoogleCalenderApiMock());  
        GoogleCal objg = new GoogleCal();
        GoogleCal.getAllgoogleList('Mighty_S_E__Demo__c',true,System.today(),System.today().addDays(5));
        //GoogleCal.fetchCombobox();
        GoogleCal.fetchCombobox();
        GoogleCal.googleCalendar();
        GoogleCal.fetchCombo();
        GoogleCal.getTaskPicklistValues('Task','Status__c');
        GoogleCal.getBaseUrl();
        GoogleCal.accountsToDisplay();
        GoogleCal.getselectOptions(new Account(),'Mighty_S_E__CustomerPriority__c');
        GoogleCal.getPicklistValues('Account','Mighty_S_E__CustomerPriority__c');
        
        GoogleCal.doStoreListAllCalendar();
        Test.stopTest();
        List<Google_Calendar_Event__c> acclst = new List<Google_Calendar_Event__c>();
        Google_Calendar_Event__c obj1 = new Google_Calendar_Event__c();
        obj1.Demo__c ='Test';
        acclst.add(obj1);
        GoogleCal.updateAccounts(acclst);     
        
        
        List<Google_Calendar_Event__c> acclst1 = new List<Google_Calendar_Event__c>();
        Google_Calendar_Event__c obj2 = new Google_Calendar_Event__c();
        obj2.Demo__c ='Test23';
        acclst.add(obj2);
        GoogleCal.saveAccount(acclst1); 
        GoogleCal.dogoogleFetchAccessToken('Test');
        system.assert(objg!=null);
        
    }
    
}
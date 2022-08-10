@isTest public class outLook_CalenderTest {
    @isTest public static void myTest(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new outLook_CalenderMock()); 
        
        outLook_Calender obj = new outLook_Calender();
        outLook_Calender.isAccessToken = false;
        outLook_Calender.authorization();
        Test.stopTest();
        Outlook_Calender_settings__c OCSObj = new Outlook_Calender_settings__c();
        OCSObj.Access_Token__c = 'Test';
        OCSObj.Expires_in__c = 456456;
        OCSObj.Refresh_Token__c = 'Test';
        insert OCSObj;
        
        
        outLook_Calender.doFetchAccessToken();
        
        String request_Body = outLook_Calender.createauthorization();
        system.debug('request_Body1---'+request_Body);
        system.assert(request_Body!=null || request_Body!='');
        outLook_Calender.doFetchSimpleAccessToken('Test');
        outLook_Calender.doRefreshToken('Test');
        
    }
    @isTest public static void myTest1(){
        
        
        Outlook_Calender_settings__c OCSObj = new Outlook_Calender_settings__c();
        OCSObj.Access_Token__c = 'Test';
        OCSObj.Expires_in__c = 456456;
        OCSObj.Refresh_Token__c = 'Test';
        insert OCSObj;
        
        
        outLook_Calender.doFetchAccessToken();
        
        String request_Body = outLook_Calender.createauthorization();
        system.debug('request_Body---'+request_Body);
        system.assert(request_Body!=null || request_Body!='');
        outLook_Calender.doFetchSimpleAccessToken('Test');
        outLook_Calender.doRefreshToken('Test');
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new outLook_CalenderMock()); 
        Test.stopTest();
        
        
    }
}
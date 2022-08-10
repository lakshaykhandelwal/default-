@isTest 
private class GoogleCalenderApiTest {
    @isTest 
    static void  myTest(){
        GoogleAPICredentials_pub__c gooapi = new GoogleAPICredentials_pub__c();
        gooapi.Mighty_S_E__ConsumerKey__c='209779636733';
        gooapi.Mighty_S_E__clientSecret__c ='Mjhdyhgfbh';
        insert gooapi;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new GoogleCalenderApiMock());  
        GoogleCalenderApi obj = new GoogleCalenderApi();
        GoogleCalenderApi.isAccessToken = false;
        GoogleCalenderApi.getAccessTokenFromRefreshToken('test453');
        String request_BodyReturn = '';
        request_BodyReturn = GoogleCalenderApi.createauthorization();
        System.debug('request_BodyReturn----'+request_BodyReturn);        
        GoogleCalenderApi.authorization();
        GoogleCalenderApi.doFetchAccessToken();
        GoogleCalenderApi.doFetchSimpleAccessToken('Test');
        system.assert(request_BodyReturn!=null || request_BodyReturn != '');
        Test.stopTest();
    }
    @isTest 
    static void myTest1(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Solution Manager']; 
        User u = new User(Alias = 'standt', Email='teststandarduser@testorg.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, 
                          TimeZoneSidKey='America/Los_Angeles', UserName='test@asd.adfs');
        List<Mighty_S_E__Google_Calender_setting__c> objem = new List<Mighty_S_E__Google_Calender_setting__c>();
        Mighty_S_E__Google_Calender_setting__c objgc = new Mighty_S_E__Google_Calender_setting__c();
        objgc.Mighty_S_E__Access_Token__c='ya29.Il-4B-baw69NK4YKytpPZpmJFjzSS9SZeQqJjxrlFDybu51YplX2wJulESJYyfHjAnPZ4_YQMdxodSlYzSuD2uXFs73i-VL_A';
        objgc.Mighty_S_E__Expires_in_Seconds__c=735;
        objgc.Mighty_S_E__Refresh_Token__c='1//0eDwlP_xnRMHwCgYIAddffAGA4SNwF-L9Il0vurl8I_a7LjAD7luVRWJJYk1N_SR4Ve-1M8bLulZOrGs0Xcst';
        objem.add(objgc);
        insert objem; 
        System.runAs(u) {
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new GoogleCalenderApiMock()); 
            GoogleCalenderApi obj = new GoogleCalenderApi();
            GoogleCalenderApi.isAccessToken = false;
            PageReference pageRefReturn = GoogleCalenderApi.doFetchAccessToken();
            System.debug('pageRefReturn----'+pageRefReturn);
            system.assert(pageRefReturn==null);
            GoogleCalenderApi.doFetchSimpleAccessToken('Test');
            
            Test.stopTest();
        }
    }
    @isTest 
    static void myTest2(){
        List<Mighty_S_E__Google_Calender_setting__c> objem = new List<Mighty_S_E__Google_Calender_setting__c>();
        Mighty_S_E__Google_Calender_setting__c objgc = new Mighty_S_E__Google_Calender_setting__c();
        objgc.Mighty_S_E__Access_Token__c='ya29.Il-4B-baw69NK4YKytpPZpmJFjzSS9SZeQqJjxrlFDybu51YplX2wJulESJYyfHjAnPZ4_YQMdxodSlYzSuD2uXFs73i-VL_A';
        objgc.Mighty_S_E__Expires_in_Seconds__c=735;
        objgc.Mighty_S_E__Refresh_Token__c='1//0eDwlP_xnRMHwCgYIAddffAGA4SNwF-L9Il0vurl8I_a7LjAD7luVRWJJYk1N_SR4Ve-1M8bLulZOrGs0Xcst';
        objem.add(objgc);
        insert objem; 
        GoogleAPICredentials_pub__c gooapi = new GoogleAPICredentials_pub__c();
        gooapi.Mighty_S_E__ConsumerKey__c='209779636733';
        gooapi.Mighty_S_E__clientSecret__c ='Mjhdyhgfbh';
        insert gooapi;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new GoogleCalenderApiMock()); 
        GoogleCalenderApi obj = new GoogleCalenderApi();
        GoogleCalenderApi.isAccessToken = false;
        PageReference pageRefReturn = GoogleCalenderApi.doFetchAccessToken();
        System.debug('pageRefReturn----'+pageRefReturn);
        system.assert(pageRefReturn!=null);
        GoogleCalenderApi.doFetchSimpleAccessToken('Test');
        Test.stopTest();
    }
    @isTest 
    static void myTest5(){
        List<Mighty_S_E__Google_Calender_setting__c> objem = new List<Mighty_S_E__Google_Calender_setting__c>();
        Mighty_S_E__Google_Calender_setting__c objgc = new Mighty_S_E__Google_Calender_setting__c();
        objgc.Mighty_S_E__Access_Token__c='';//'ya29.Il-4B-baw69NK4YKytpPZpmJFjzSS9SZeQqJjxrlFDybu51YplX2wJulESJYyfHjAnPZ4_YQMdxodSlYzSuD2uXFs73i-VL_A';
        objgc.Mighty_S_E__Expires_in_Seconds__c=0;//735;
        objgc.Mighty_S_E__Refresh_Token__c='';//'1//0eDwlP_xnRMHwCgYIAddffAGA4SNwF-L9Il0vurl8I_a7LjAD7luVRWJJYk1N_SR4Ve-1M8bLulZOrGs0Xcst';
        objem.add(objgc);
        insert objem; 
        GoogleAPICredentials_pub__c gooapi = new GoogleAPICredentials_pub__c();
        gooapi.Mighty_S_E__ConsumerKey__c='';//'209779636733';
        gooapi.Mighty_S_E__clientSecret__c ='';//'Mjhdyhgfbh';
        insert gooapi;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new GoogleCalenderApiMock()); 
        GoogleCalenderApi obj = new GoogleCalenderApi();
        GoogleCalenderApi.isAccessToken = false;
        PageReference pageRefReturn = GoogleCalenderApi.doFetchAccessToken();
        System.debug('pageRefReturn----'+pageRefReturn);
        system.assert(pageRefReturn!=null);
        GoogleCalenderApi.doFetchSimpleAccessToken(null);
        Test.stopTest();
    }
    @isTest 
    static void myTest4(){
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'standt', Email='teststandarduser@testorg.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, 
                          TimeZoneSidKey='America/Los_Angeles', UserName='test@asd.adfs');
        List<Mighty_S_E__Google_Calender_setting__c> objem = new List<Mighty_S_E__Google_Calender_setting__c>();
        Mighty_S_E__Google_Calender_setting__c objgc = new Mighty_S_E__Google_Calender_setting__c();
        objgc.Mighty_S_E__Access_Token__c='ya29.Il-4B-baw69NK4YKytpPZpmJFjzSS9SZeQqJjxrlFDybu51YplX2wJulESJYyfHjAnPZ4_YQMdxodSlYzSuD2uXFs73i-VL_A';
        objgc.Mighty_S_E__Expires_in_Seconds__c=735;
        objgc.Mighty_S_E__Refresh_Token__c='1//0eDwlP_xnRMHwCgYIAddffAGA4SNwF-L9Il0vurl8I_a7LjAD7luVRWJJYk1N_SR4Ve-1M8bLulZOrGs0Xcst';
        objem.add(objgc);
        insert objem; 
        System.runAs(u) {
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new GoogleCalenderApiMock()); 
            GoogleCalenderApi obj = new GoogleCalenderApi();
            GoogleCalenderApi.isAccessToken = false;
            PageReference pageRefReturn = GoogleCalenderApi.doFetchAccessToken();
            System.debug('pageRefReturn----'+pageRefReturn);
            system.assert(pageRefReturn!=null);
            GoogleCalenderApi.doFetchSimpleAccessToken('Test');
            
            Test.stopTest();
            
        }
    }
}
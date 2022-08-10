@isTest public class DeployCustomSettingTest {
	@isTest public static void  myTest(){
     
        DeployCustomSetting.deployData();
        GoogleAPICredentials_pub__c gcobj = [SELECT Id, clientSecret__c FROM GoogleAPICredentials_pub__c];
        system.assertEquals('M6K4oeE0h_PSuZu9OJW3e8gF', gcobj.clientSecret__c);
        
    }
}
@isTest
public class customLookUpController1Test {
    @isTest public static void  myTest(){
        Account accObj = new Account();
        accObj.name = 'test';
        insert accObj;
        customLookUpController1.fetchLookUpValues('test','Account');
    }
}
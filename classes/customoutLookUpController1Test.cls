@isTest
public class customoutLookUpController1Test {
    @isTest public static void  myTest(){
        Account accObj = new Account();
        accObj.name = 'test';
        insert accObj;
     customoutLookUpController1.fetchLookUpValues('test','Account');
    }
}
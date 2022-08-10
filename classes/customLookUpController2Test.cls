@isTest
public class customLookUpController2Test {
    @isTest public static void  myTest(){
        Account accObj = new Account();
        accObj.name = 'test';
        insert accObj;
     customLookUpController2.fetchLookUpValues('test','Account');
    }
}
@isTest
public class customoutLookUpController2Test {
    @isTest public static void  myTest(){
         Account accObj = new Account();
        accObj.name = 'test';
        insert accObj;
     customoutLookUpController2.fetchLookUpValues('test','Account');
    }
}
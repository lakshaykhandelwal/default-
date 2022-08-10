@isTest
public class customLookUpController2Test {
    @isTest public static void  myTest(){
        Account accObj = new Account();
        accObj.name = 'test';
        insert accObj;
        List<Account> returnList = new List<Account>();
        returnList = customLookUpController2.fetchLookUpValues('test','Account');
        system.assert(returnList.size()>0);
    }
}
@isTest
public class customoutLookUpController1Test {
    @isTest public static void  myTest(){
        Account accObj = new Account();
        accObj.name = 'test';
        insert accObj;
        List <sObject> returnList = customoutLookUpController1.fetchLookUpValues('test','Account');
        system.debug('returnList---'+returnList);
        system.assert(returnList.size()>0);
    }
}
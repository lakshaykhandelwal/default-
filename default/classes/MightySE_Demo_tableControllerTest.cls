@isTest
public class MightySE_Demo_tableControllerTest {
    @isTest public static void  myTest(){
        
        Account accObj = new Account();
        accObj.Name= 'test';
        insert accObj;
        List<Mighty_S_E__Demos__c> lstDemos= new List<Mighty_S_E__Demos__c>();
        
        Mighty_S_E__Demos__c demoObj= new Mighty_S_E__Demos__c();
        demoObj.Mighty_S_E__Notes__c ='asdas';
        demoObj.Mighty_S_E__Account__c = accObj.id;
        demoObj.Mighty_S_E__Demo_Date__c= Date.valueOf(system.today());
        insert demoObj;
        lstDemos.add(demoObj);
        MightySE_Demo_tableController.saveAccount(lstDemos);
        MightySE_Demo_tableController.getAlldemoData(System.today(),System.today().addDays(5));
        List<String> lstPickvals = new List<String>();
        lstPickvals = MightySE_Demo_tableController.getPicklistValues('Account','Mighty_S_E__Active__c');	
        system.assert(lstPickvals.size()>0);
    }
}
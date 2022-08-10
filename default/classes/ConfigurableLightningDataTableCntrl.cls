public with sharing class ConfigurableLightningDataTableCntrl {
    @AuraEnabled
    public static List<Account> getAllAccounts(){
        return [Select Id, Name, AnnualRevenue, Description, NumberOfEmployees, Industry, Rating, Phone, OwnerId from Account WHERE Id!=null] ; 
    }
    @AuraEnabled
    public static void updateAccount(List<Account> acc ){
        update acc;
    }
}
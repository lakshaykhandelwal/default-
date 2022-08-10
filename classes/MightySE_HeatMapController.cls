public with sharing  class MightySE_HeatMapController {
   
    
	 @AuraEnabled
    public static String fetchValue()
    {
        String data='';
        try{
            String chartQuery = 'select Count(ID) Hours, Account.BillingState Name from Opportunity  where ID != null AND Account.BillingState != null Group by Account.BillingState';
            List<sObject> lstChart = Database.query(chartQuery);
            data = JSON.serialize(lstChart);
            System.debug('ChartData-->'+data);
            return data;
        }catch(Exception ex) {  System.debug('Error'+ex.getMessage());} return data;
    } 
    
}
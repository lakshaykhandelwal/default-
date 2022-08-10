public with sharing class SE_JQUSHeatMapController
{
    public List<sObject> lstChart {get; set;}
    public String chartQuery;
    public String data {get; set;}
    
    public SE_JQUSHeatMapController() 
    {
        
    }
    
    public void setquery(String str) 
    {
        system.debug('chartQuery-->'+str);
        chartQuery = str;
        lstChart = Database.query(chartQuery);
        data = JSON.serialize(lstChart);
        System.debug('ChartData-->'+data);
    }
    
    public String getquery() 
    {
        return chartQuery;
    }
    public void fetchValue()
    {
        String chartQuery = 'select Count(ID) Hours, Account.BillingState Name from Opportunity  where ID != null AND Account.BillingState != null Group by Account.BillingState';
        lstChart = Database.query(chartQuery);
        data = JSON.serialize(lstChart);
        System.debug('ChartData-->'+data);
    } 
    
}
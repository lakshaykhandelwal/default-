public with sharing class SE_JQPieChartController 
{
	public List<sObject> lstChart {get; set;}
    public String chartQuery;
    public String data {get; set;}
    
	public SE_JQPieChartController() 
    {
        
    }
    
    public void setquery(String str) 
    {
        system.debug('chartQuery-->'+str);
        chartQuery = str;
        lstChart = Database.query(chartQuery);
        data= JSON.serialize(lstChart);
        System.debug('ChartData-->'+data);
    }
    
    public String getquery() 
    {
        return chartQuery;
    }
}
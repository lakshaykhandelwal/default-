public with sharing class SE_JQBarChartVerticalController 
{
	public List<sObject> lstChart {get; set;}
    public String chartQuery;
    public String data {get; set;}
    
    public SE_JQBarChartVerticalController()
    {
        
    }
    
    public void setquery(String str) 
    {
        system.debug('ChartQuery-->'+str);
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
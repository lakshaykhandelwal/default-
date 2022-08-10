public with sharing class SE_JQStackedBarChartController {
	public List<sObject> lstChart {get; set;}
    public String chartQuery;
    public String data {get; set;}
    
    public SE_JQStackedBarChartController()
    {
        
    }
    
    public void setquery(String str) 
    {
        system.debug('ChartQuery-->'+str);
        chartQuery = str;
        lstChart = Database.query(chartQuery);
        System.debug('lstChart-->'+lstChart);
        data= JSON.serialize(lstChart);
        System.debug('ChartData-->'+data);
    }
    
    public String getquery() 
    {
        return chartQuery;
    }
}
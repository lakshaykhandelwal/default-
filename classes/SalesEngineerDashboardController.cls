public with sharing class SalesEngineerDashboardController 
{
    public List<ChartQuery__mdt> lstChartQueries {get; set;}
    public List<SE_Chart_Manager__c> queries {get; set;}
    public static List<Opportunity> allOpportunities {get;set;}
    public static String allOpportunity{get;set;}
    public static Boolean isListCalendars { get; set; }
    Public static String allCalendars { get; set; }
    public static Boolean showEventbtn {get;set;}
    public static String showbtn {get; set; }
    
    
    
    public SalesEngineerDashboardController()
    {
        showbtn = 'none';
        //lstChartQueries = [Select Id, ChartType__c, Compare_with_Loggedin_User__c, Chart_Unit__c, Label, Check_Created_by__c, ChartWidth__c, GroupBy_OrderBy_Limits__c, Field1__c, Field2__c, whereCondition__c, Object__c, Sequence__c, IsActive__c, isVisibleTo__c, yAxisTitle__c, xAxisTitle__c, showLegends__c  from ChartQuery__mdt where IsActive__c = true order by Sequence__c];
        if (Schema.sObjectType.SE_Chart_Manager__c.isAccessible() 
            && Schema.sObjectType.SE_Chart_Manager__c.fields.Chart_Type__c.isAccessible() 
            && Schema.sObjectType.SE_Chart_Manager__c.fields.Compare_Fields_with_Loggedin_User__c.isAccessible() 
            && Schema.sObjectType.SE_Chart_Manager__c.fields.Column__c.isAccessible()
            && Schema.sObjectType.SE_Chart_Manager__c.fields.Created_by_Current_User__c.isAccessible()
            && Schema.sObjectType.SE_Chart_Manager__c.fields.Fields__c.isAccessible()
            && Schema.sObjectType.SE_Chart_Manager__c.fields.Fields_Labels__c.isAccessible()
            && Schema.sObjectType.SE_Chart_Manager__c.fields.Flag__c.isAccessible()
            && Schema.sObjectType.SE_Chart_Manager__c.fields.GroupByOrderByLimit__c.isAccessible()
            && Schema.sObjectType.SE_Chart_Manager__c.fields.Object_Name__c.isAccessible()
            && Schema.sObjectType.SE_Chart_Manager__c.fields.Sequence__c.isAccessible()
            && Schema.sObjectType.SE_Chart_Manager__c.fields.Show_Legends__c.isAccessible()
            && Schema.sObjectType.SE_Chart_Manager__c.fields.Unit__c.isAccessible()
            && Schema.sObjectType.SE_Chart_Manager__c.fields.Where_Condition__c.isAccessible()
            && Schema.sObjectType.SE_Chart_Manager__c.fields.Width__c.isAccessible()
            && Schema.sObjectType.SE_Chart_Manager__c.fields.X_Axis__c.isAccessible()
            && Schema.sObjectType.SE_Chart_Manager__c.fields.Y_Axis__c.isAccessible()
            && Schema.sObjectType.SE_Chart_Manager__c.fields.Is_Active__c.isAccessible()) {
                queries = [Select Name, Chart_Type__c, Compare_Fields_with_Loggedin_User__c,Column__c, Created_by_Current_User__c, Fields__c, Fields_Labels__c, Flag__c, GroupByOrderByLimit__c, Object_Name__c, Sequence__c, Show_Legends__c, Unit__c, Where_Condition__c, Width__c, X_Axis__c, Y_Axis__c From SE_Chart_Manager__c Where Is_Active__c = true  AND Flag__c ='sepage' order by Sequence__c];
            }else{
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'Error: user can not access this object'));
            }
    }

     
}
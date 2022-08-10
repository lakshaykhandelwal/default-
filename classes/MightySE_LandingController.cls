public with sharing class  MightySE_LandingController 
{
    public List<SE_Chart_Manager__c> queries {get; set;}
    public MightySE_LandingController()
    {
        if (Schema.sObjectType.SE_Chart_Manager__c.isAccessible() &&
            Schema.sObjectType.SE_Chart_Manager__c.fields.Name.isAccessible() &&
            Schema.sObjectType.SE_Chart_Manager__c.fields.Chart_Type__c.isAccessible() &&
            Schema.sObjectType.SE_Chart_Manager__c.fields.Compare_Fields_with_Loggedin_User__c.isAccessible() &&
            Schema.sObjectType.SE_Chart_Manager__c.fields.Column__c.isAccessible() &&
            Schema.sObjectType.SE_Chart_Manager__c.fields.Created_by_Current_User__c.isAccessible() &&
            Schema.sObjectType.SE_Chart_Manager__c.fields.Fields__c.isAccessible() &&
            Schema.sObjectType.SE_Chart_Manager__c.fields.Fields_Labels__c.isAccessible() &&
            Schema.sObjectType.SE_Chart_Manager__c.fields.Flag__c.isAccessible() &&
            Schema.sObjectType.SE_Chart_Manager__c.fields.GroupByOrderByLimit__c.isAccessible() &&
            Schema.sObjectType.SE_Chart_Manager__c.fields.Object_Name__c.isAccessible() &&
            Schema.sObjectType.SE_Chart_Manager__c.fields.Sequence__c.isAccessible() &&
            Schema.sObjectType.SE_Chart_Manager__c.fields.Show_Legends__c.isAccessible() &&
            Schema.sObjectType.SE_Chart_Manager__c.fields.Unit__c.isAccessible() &&
            Schema.sObjectType.SE_Chart_Manager__c.fields.Where_Condition__c.isAccessible() &&
            Schema.sObjectType.SE_Chart_Manager__c.fields.Width__c.isAccessible() &&
            Schema.sObjectType.SE_Chart_Manager__c.fields.X_Axis__c.isAccessible() &&
            Schema.sObjectType.SE_Chart_Manager__c.fields.Y_Axis__c.isAccessible() &&
            Schema.sObjectType.SE_Chart_Manager__c.fields.Is_Active__c.isAccessible()){
            queries = [Select Name, Chart_Type__c, Compare_Fields_with_Loggedin_User__c, Column__c, Created_by_Current_User__c, Fields__c, Fields_Labels__c, Flag__c, GroupByOrderByLimit__c, Object_Name__c, Sequence__c, Show_Legends__c, Unit__c, Where_Condition__c, Width__c, X_Axis__c, Y_Axis__c From SE_Chart_Manager__c Where Is_Active__c = true AND Flag__c ='landingpage' order by Sequence__c];
        }
        System.debug('queries-->'+ queries);
    }
}
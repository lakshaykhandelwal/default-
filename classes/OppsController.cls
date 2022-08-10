public with sharing class OppsController {
    
    // Get a set of Opportunities
    public ApexPages.StandardSetController setCon {
        get {
            if(setCon == null) {
                if (Schema.sObjectType.Opportunity.isAccessible()&&
                    Schema.sObjectType.Opportunity.fields.Name.isAccessible() &&
                    Schema.sObjectType.Opportunity.fields.type.isAccessible() &&
                    Schema.sObjectType.Opportunity.fields.amount.isAccessible() &&
                    Schema.sObjectType.Opportunity.fields.closedate.isAccessible() 
                   ){
                       setCon = new ApexPages.StandardSetController(Database.getQueryLocator(
                           [SELECT name, type, amount, closedate FROM Opportunity LIMIT 50000]));
                       setCon.setPageSize(5);
                   } }
            return setCon;
        }
        set;
    }
    
    public List<Opportunity> getOpportunities() {
         return (List<Opportunity>) setCon.getRecords();
    }
}
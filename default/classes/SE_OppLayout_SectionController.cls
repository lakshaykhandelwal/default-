public with sharing class SE_OppLayout_SectionController {
    //  public List<Event> eventData {get;set;}
    // public String oppData;
    public SE_OppLayout_SectionController(ApexPages.StandardController stdController) { }
    public Opportunity getOppData()
    {
        Opportunity oppData;
        if (Schema.sObjectType.Opportunity.isAccessible() && Schema.sObjectType.User.isAccessible() 
        && Schema.sObjectType.User.fields.FirstName.isAccessible() && Schema.sObjectType.Opportunity.fields.SalesEngineer__c.isAccessible() ){
            oppData = [select id, SalesEngineer__c, SalesEngineer__r.Name from Opportunity where id = :ApexPages.currentPage().getParameters().get('id')];
        } 
        return oppData;
    }
    
    public List<Event> getEventData(){
        List<SObject> eventData = new List<SObject>();
        if(Schema.sObjectType.Opportunity.isAccessible() &&
                   // Schema.sObjectType.Opportunity.fields.CreatedBy.FirstName.isAccessible() &&
                    Schema.sObjectType.Opportunity.fields.SalesEngineer__c.isAccessible() ) {
            Opportunity oppData = [select id,SalesEngineer__c ,CreatedBy.FirstName from Opportunity where id = :ApexPages.currentPage().getParameters().get('id')];		
            eventData.addAll([select Subject,type__c,Owner.Name,Priority__c,Status__c FROM Event where WhatId = :ApexPages.currentPage().getParameters().get('id') AND CreatedById = :oppData.SalesEngineer__c ]);
            eventData.addAll([select Subject,type__c,Owner.Name,Priority__c,Status__c FROM Task where WhatId = :ApexPages.currentPage().getParameters().get('id') AND CreatedById = :oppData.SalesEngineer__c ]);
            //List<Event> eventData = s;
            system.debug('@@eventData:-'+eventData);
        }
        return eventData;
    }
}
public with sharing class EventTriggerHandler {
    
    private Map<Id, Event> newEventMap; 
    private Map<Id, Event> oldEventMap;
    private List<Event> newEventList;
    private List<Event> oldEventList;

    public EventTriggerHandler(){
        this.newEventMap = (Map<Id, Event>) Trigger.newMap;
        this.oldEventMap = (Map<Id, Event>) Trigger.oldMap;
        this.newEventList = (List<Event>) Trigger.new;
        this.oldEventList = (List<Event>) Trigger.old;
    }

    public void onAfterInsert(){
        countEventsAndTasksAssociatedToDemo();
    }

    public void onAfterUpdate(){
        countEventsAndTasksAssociatedToDemo();
    }

    private void countEventsAndTasksAssociatedToDemo(){
        Set<Id> demoIds = new Set<Id>();
        for(Event objEvent: newEventList){
            if(objEvent.Demo__c != null){
                demoIds.add(objEvent.Demo__c);
            }
        }
        List<Demos__c> lstDemosToUpdate = new List<Demos__c>();
        List<AggregateResult> lstEventAggResult = [select Count(Id) num, Demo__c demoId from Event where Demo__c IN :demoIds Group By Demo__c Limit 1000];
        List<AggregateResult> lstTaskAggResult = [select Count(Id) num, Demo__c demoId from Task where Demo__c IN :demoIds Group By Demo__c Limit 1000]; 
        Map<Id, Decimal> mapDemoIDAndCount = new Map<Id, Decimal>();
        for(AggregateResult objAggrRes: lstTaskAggResult){
            if(mapDemoIDAndCount.containsKey((Id)objAggrRes.get('demoId'))){
                Decimal count = mapDemoIDAndCount.get((Id)objAggrRes.get('demoId'));
                count += (Decimal)objAggrRes.get('num');
                mapDemoIDAndCount.put((Id)objAggrRes.get('demoId'), count);
            }
            else{
                Decimal count = (Decimal)objAggrRes.get('num');
                mapDemoIDAndCount.put((Id)objAggrRes.get('demoId'), count);
            }
        }
        for(AggregateResult objAggrRes: lstEventAggResult){
            if(mapDemoIDAndCount.containsKey((Id)objAggrRes.get('demoId'))){
                Decimal count = mapDemoIDAndCount.get((Id)objAggrRes.get('demoId'));
                count += (Decimal)objAggrRes.get('num');
                mapDemoIDAndCount.put((Id)objAggrRes.get('demoId'), count);
            }
            else{
                Decimal count = (Decimal)objAggrRes.get('num');
                mapDemoIDAndCount.put((Id)objAggrRes.get('demoId'), count);
            }
        }
        for(Id demoId: mapDemoIDAndCount.keySet()){
            Demos__c objDemo = new Demos__c(); 
            objDemo.Id = demoId;
            objDemo.Times_Used__c = mapDemoIDAndCount.get(demoId); 
            lstDemosToUpdate.add(objDemo);
            System.debug('objDemo:-'+objDemo);
        }
        System.debug('lstDemosToUpdate:-'+lstDemosToUpdate);
        if(Schema.sObjectType.Demos__c.fields.Id.isUpdateable()
        && Schema.sObjectType.Demos__c.fields.Times_Used__c.isUpdateable()
           && lstDemosToUpdate.size() > 0){
            update lstDemosToUpdate;
        }
    }

}
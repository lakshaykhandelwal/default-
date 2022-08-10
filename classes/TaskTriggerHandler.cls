public with sharing class TaskTriggerHandler {

    private Map<Id, Task> newTaskMap; 
    private Map<Id, Task> oldTaskMap;
    private List<Task> newTaskList;
    private List<Task> oldTaskList;

    public TaskTriggerHandler(){
        this.newTaskMap = (Map<Id, Task>) Trigger.newMap;
        this.oldTaskMap = (Map<Id, Task>) Trigger.oldMap;
        this.newTaskList = (List<Task>) Trigger.new;
        this.oldTaskList = (List<Task>) Trigger.old;
    }

    public void onAfterInsert(){
        countEventsAndTasksAssociatedToDemo();
    }

    public void onAfterUpdate(){
        countEventsAndTasksAssociatedToDemo();
    }

    private void countEventsAndTasksAssociatedToDemo(){
        Set<Id> demoIds = new Set<Id>();
        for(Task objTask: newTaskList){
            if(objTask.Demo__c != null){
                demoIds.add(objTask.Demo__c);
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
        if(lstDemosToUpdate.size() > 0){
            update lstDemosToUpdate;
        }
    }

}
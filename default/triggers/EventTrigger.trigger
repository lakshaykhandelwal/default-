trigger EventTrigger on Event (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    EventTriggerHandler objHandler = new EventTriggerHandler();
    if(Trigger.isInsert && Trigger.isAfter){
        objHandler.onAfterInsert();
    }
    else if(Trigger.isUpdate && Trigger.isAfter){
        objHandler.onAfterUpdate();
    }
}
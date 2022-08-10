trigger TaskTrigger on Task (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    TaskTriggerHandler objHandler = new TaskTriggerHandler();
    if(Trigger.isInsert && Trigger.isAfter){
        objHandler.onAfterInsert();
    }
    else if(Trigger.isUpdate && Trigger.isAfter){
        objHandler.onAfterUpdate();
    }
}
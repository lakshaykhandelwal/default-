trigger OutllokCalendarEventTrigger on Mighty_S_E__Outlook_Calendar_Event__c(after insert, after update, before insert, 
before update,before delete, after delete) {

   //OCETriggerHandler  handler = new OCETriggerHandler();
    
  
    if(Trigger.isAfter && Trigger.isUpdate) {
       OCETriggerHandler.onAfterUpdate(Trigger.newMap);
    }
}
trigger GoogleCalendarEventTrigger  on Mighty_S_E__Google_Calendar_Event__c(after update) {
   //GCETriggerHandler  handler = new GCETriggerHandler();
   if(Trigger.isAfter && Trigger.isUpdate) {  
      GCETriggerHandler.onAfterUpdate(Trigger.newMap);
   }
 }
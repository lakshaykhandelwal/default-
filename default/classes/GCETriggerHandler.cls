public class GCETriggerHandler {
    public static void  onAfterUpdate(Map <Id, Google_Calendar_Event__c> newGCEMap) {
       // try{
            //List<Event> lstEvents = new List<Event>();
            List<Event> lstEventsfrUpdate = new List<Event>();
            List<String> lstGCEIds = new List<String>();
            Map<Id,Event> eventsMap = new Map<Id,Event> ();
            for(Google_Calendar_Event__c gceObj : newGCEMap.values()){			
                system.debug('gceObj.Opportunity__c'+String.ValueOf(gceObj.Opportunity__c));
                if(gceObj.Opportunity__c != null && String.ValueOf(gceObj.Opportunity__c) != ''){
                    system.debug('google calendar task field'+gceObj);
                    lstGCEIds.add(gceObj.Id);
                }
            }
            
            List<Event> lstevnts = [Select Id,Subject,Event_Id__c from Event where Event_Id__c=:lstGCEIds];
            for(Event enObj:lstevnts) { eventsMap.put(enObj.Event_Id__c,enObj); }
            Event evtObj; 
            for(Google_Calendar_Event__c gceObj : newGCEMap.values()){
                evtObj = new Event();
                if(eventsMap.containsKey(gceObj.Id)){ evtObj = eventsMap.get(gceObj.Id); }
                evtObj.Subject =  gceObj.Subject__c+'-'+gceObj.Opp_Name_Formula__c;
                evtObj.DurationInMinutes = 30;
                evtObj.StartDateTime =  gceObj.Start_Date_Time__c;
                evtObj.ActivityDateTime = gceObj.Start_Date_Time__c;
                evtObj.Type = gceObj.Mighty_S_E__Task_Type__c;
                //Datetime dt = gceObj.Start_Date_Time__c;
                //evtObj.EndDateTime = dt.addDays(4); 
                evtObj.Event_Id__c = gceObj.Id;
                evtObj.WhatId  =  gceObj.Opportunity__c;
                evtObj.Demo__c = gceObj.Demo_Id__c; 
                evtObj.Type__c = gceObj.Activity__c; 
                evtObj.Event_Type__c = 'Google'; 
                evtObj.Status__c =  'Open';
                if( evtObj.WhatId != null &&  String.valueOf(evtObj.WhatId) != ''){
                    lstEventsfrUpdate.add(evtObj);    
                }
            }
            system.debug('lstEventsfrUpdate'+lstEventsfrUpdate);
            if(Schema.sObjectType.Event.fields.Subject.isCreateable()
               && Schema.sObjectType.Event.fields.DurationInMinutes.isCreateable()
               && Schema.sObjectType.Event.fields.StartDateTime.isCreateable()
               && Schema.sObjectType.Event.fields.ActivityDateTime.isCreateable()
               && Schema.sObjectType.Event.fields.Type.isCreateable()
               && Schema.sObjectType.Event.fields.Event_Id__c.isCreateable()
               && Schema.sObjectType.Event.fields.WhatId.isCreateable()
               && Schema.sObjectType.Event.fields.Demo__c.isCreateable()
               && Schema.sObjectType.Event.fields.Type__c.isCreateable()
               && Schema.sObjectType.Event.fields.Event_Type__c.isCreateable()
               && Schema.sObjectType.Event.fields.Status__c.isCreateable()
               && Schema.sObjectType.Event.fields.Subject.isUpdateable()
               && Schema.sObjectType.Event.fields.DurationInMinutes.isUpdateable()
               && Schema.sObjectType.Event.fields.StartDateTime.isUpdateable()
               && Schema.sObjectType.Event.fields.ActivityDateTime.isUpdateable()
               && Schema.sObjectType.Event.fields.Type.isUpdateable()
               && Schema.sObjectType.Event.fields.Event_Id__c.isUpdateable()
               && Schema.sObjectType.Event.fields.WhatId.isUpdateable()
               && Schema.sObjectType.Event.fields.Demo__c.isUpdateable()
               && Schema.sObjectType.Event.fields.Type__c.isUpdateable()
               && Schema.sObjectType.Event.fields.Event_Type__c.isUpdateable()
               && Schema.sObjectType.Event.fields.Status__c.isUpdateable()
               && lstEventsfrUpdate.size() > 0){
                   upsert lstEventsfrUpdate ; 
               }
            System.debug('After Upsert of Event from Google Calendar:-'+lstEventsfrUpdate);
       // }catch(Exception e) {
       //     system.debug('ERROR'+e.getMessage());
       // }
    }
}
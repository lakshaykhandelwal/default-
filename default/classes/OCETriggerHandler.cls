public class OCETriggerHandler {
    
    
    public static void onAfterUpdate(Map <Id, Outlook_Calendar_Event__c> newOCEMap) {
        //try{
            
            //List<Event> lstEvents = new List<Event>();
            List<Event> lstEventsfrUpdate = new List<Event>();
            List<String> lstGCEIds = new List<String>();
            Map<Id,Event> eventsMap = new Map<Id,Event> ();
            for(Outlook_Calendar_Event__c gceObj : newOCEMap.values())
            {			
                system.debug('gceObj.Opportunity__c'+String.ValueOf(gceObj.Opportunity__c));
                
                if(gceObj.Opportunity__c != null && String.ValueOf(gceObj.Opportunity__c) != ''){
                    system.debug('gceObj.id'+gceObj.Id);
                    lstGCEIds.add(gceObj.Id);
                }
            }
            List<Event> lstevnts = [Select Id,Subject,Event_Id__c from Event where Event_Id__c=:lstGCEIds];
            
            for(Event enObj:lstevnts)  { eventsMap.put(enObj.Event_Id__c,enObj);
                                       }
            Event evtObj;
            for(Outlook_Calendar_Event__c gceObj : newOCEMap.values())
            {
                evtObj = new Event();
                if(eventsMap.get(gceObj.Id) != null ){  evtObj =  eventsMap.get(gceObj.Id);
                                                     }
                evtObj.Subject =  gceObj.Subject__c;
                evtObj.StartDateTime =  gceObj.Event_Start_Date__c;
                Datetime dt = gceObj.Event_Start_Date__c;
                evtObj.EndDateTime = dt.addDays(4); 
                evtObj.Event_Id__c = gceObj.Id;
                evtObj.WhatId  =  gceObj.Opportunity__c;
                evtObj.Demo__c = gceObj.Demo_Id__c; 
                evtObj.Type__c = gceObj.Activity__c; 
                evtObj.Event_Type__c = 'Outlook'; 
                evtObj.Status__c =  'Open';
                if( evtObj.WhatId != null &&  String.valueOf(evtObj.WhatId) != '')
                {
                    lstEventsfrUpdate.add(evtObj);    
                }
                
            }
            system.debug('lstEventsfrUpdate'+lstEventsfrUpdate);
            if(Schema.sObjectType.Event.fields.Subject.isCreateable()
               && Schema.sObjectType.Event.fields.EndDateTime.isCreateable()
               && Schema.sObjectType.Event.fields.StartDateTime.isCreateable()
               && Schema.sObjectType.Event.fields.Event_Id__c.isCreateable()
               && Schema.sObjectType.Event.fields.WhatId.isCreateable()
               && Schema.sObjectType.Event.fields.Demo__c.isCreateable()
               && Schema.sObjectType.Event.fields.Type__c.isCreateable()
               && Schema.sObjectType.Event.fields.Event_Type__c.isCreateable()
               && Schema.sObjectType.Event.fields.Status__c.isCreateable()
               && Schema.sObjectType.Event.fields.Subject.isUpdateable()
               && Schema.sObjectType.Event.fields.EndDateTime.isUpdateable()
               && Schema.sObjectType.Event.fields.StartDateTime.isUpdateable()
               && Schema.sObjectType.Event.fields.Event_Id__c.isUpdateable()
               && Schema.sObjectType.Event.fields.WhatId.isUpdateable()
               && Schema.sObjectType.Event.fields.Demo__c.isUpdateable()
               && Schema.sObjectType.Event.fields.Type__c.isUpdateable()
               && Schema.sObjectType.Event.fields.Event_Type__c.isUpdateable()
               && Schema.sObjectType.Event.fields.Status__c.isUpdateable()
               && lstEventsfrUpdate.size() > 0)
            {
                upsert lstEventsfrUpdate ; 
                
            }
            
        //}catch(Exception e) {
        //    system.debug('ERROR'+e.getMessage());
        //}
    }
}
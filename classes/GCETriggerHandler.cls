public class GCETriggerHandler {
    
    public void onAfterUpdate(List < Google_Calendar_Event__c > newGCE, List < Google_Calendar_Event__c > oldGCE, Map < Id, Google_Calendar_Event__c > newGCEMap, Map < Id, Google_Calendar_Event__c > oldGCEMap) {
        try{
            List<Event> lstEvents = new List<Event>();
            List<Event> lstEventsfrUpdate = new List<Event>();
            List<String> lstGCEIds = new List<String>();
            Map<Id,Event> eventsMap = new Map<Id,Event> ();
            for(Google_Calendar_Event__c gceObj : newGCE){			
                system.debug('gceObj.Opportunity__c'+String.ValueOf(gceObj.Opportunity__c));
                if(gceObj.Opportunity__c != null && String.ValueOf(gceObj.Opportunity__c) != ''){
                    system.debug('google calendar task field'+gceObj);
                    lstGCEIds.add(gceObj.Id);
                }
            }

            List<Event> lstevnts = [Select Id,Subject,Event_Id__c from Event where Event_Id__c=:lstGCEIds];
            for(Event enObj:lstevnts) { eventsMap.put(enObj.Event_Id__c,enObj); }
            
            for(Google_Calendar_Event__c gceObj : newGCE){
                Event evtObj = new Event();
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
            if(lstEventsfrUpdate.size() > 0){
                upsert lstEventsfrUpdate ; 
            }
            System.debug('After Upsert of Event from Google Calendar:-'+lstEventsfrUpdate);
        }catch(Exception e) {
            system.debug('ERROR'+e.getMessage());
        }
    }
}
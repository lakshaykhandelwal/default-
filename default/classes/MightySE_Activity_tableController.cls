public class MightySE_Activity_tableController {
    @AuraEnabled(cacheable=true)
    public static List<Event> getAllActivityData(String filterBy,Date startDate , Date endDate){
        List<Event> getevtdata = new List<Event>();
        try{
            system.debug('filterByEvent:-'+filterBy); 
            if(!String.isEmpty(filterBy)){
                getevtdata = [SELECT id,subject,Owner.Name,EndDateTime,Mighty_S_E__Priority__c,Mighty_S_E__Status__c FROM Event
                              where (CreatedById =:UserInfo.getUserId() OR OwnerId =:UserInfo.getUserId())
                              AND (EndDateTime >: startDate AND EndDateTime <:  endDate)
                              AND Mighty_S_E__Status__c = :filterBy
                              limit 1000];    
            }else {
                getevtdata = [SELECT id,subject,Owner.Name,EndDateTime,Mighty_S_E__Priority__c,Mighty_S_E__Status__c FROM Event
                              where (CreatedById =:UserInfo.getUserId() OR OwnerId =:UserInfo.getUserId())
                              AND (EndDateTime >: startDate AND EndDateTime <:  endDate)
                              limit 1000];    
            }
            system.debug('getevtdata'+getevtdata); 
        }catch(Exception ex) {
            system.debug('Error---->'+ex.getMessage()); 
        }
        
        return getevtdata;
    }
    @AuraEnabled(cacheable=true)
    public static List<Task> getAllTaskData(String filterBy,Date startDate , Date endDate){
        List<Task> gettskdata = new List<Task>();
        try{
            system.debug('filterByTask:-'+filterBy); 
            if(!String.isEmpty(filterBy)){
                gettskdata = [SELECT id,subject,Owner.Name,ActivityDate,Mighty_S_E__Priority__c,Mighty_S_E__Status__c FROM Task
                              where (CreatedById =:UserInfo.getUserId() OR OwnerId =:UserInfo.getUserId())
                              AND (ActivityDate >: startDate AND ActivityDate <:  endDate)
                              AND Mighty_S_E__Status__c = :filterBy 
                              limit 1000];
            }else{
                gettskdata = [SELECT id,subject,Owner.Name,ActivityDate,Mighty_S_E__Priority__c,Mighty_S_E__Status__c FROM Task
                              where (CreatedById =:UserInfo.getUserId() OR OwnerId =:UserInfo.getUserId())
                              AND (ActivityDate >: startDate AND ActivityDate <:  endDate)
                              limit 1000];
            }
            system.debug('gettskdata'+gettskdata); 
        }catch(Exception ex){
            system.debug('Error---->'+ex.getMessage()); 
        }
        
        return gettskdata;
    }
  @AuraEnabled  
    public static List<String> getPicklistValues(String ObjectApi_name,String Field_name){ 
        
        List<String> lstPickvals=new List<String>();
        try{
            Schema.SObjectType targetType = Schema.getGlobalDescribe().get(ObjectApi_name);
            Sobject obj2 = targetType.newSObject();
            Schema.sObjectType sobject_type = obj2.getSObjectType(); 
            Schema.DescribeSObjectResult sobject_describe = sobject_type.getDescribe(); 
            Map<String, Schema.SObjectField> field_map = sobject_describe.fields.getMap(); 
            List<Schema.PicklistEntry> pick_list_values = field_map.get(Field_name).getDescribe().getPickListValues(); 
            for (Schema.PicklistEntry a : pick_list_values) {
                lstPickvals.add(a.getValue());
            }
            }catch(Exception e){ 
            System.debug('error'+e.getMessage()+'---'+e.getStackTraceString());
        }
        return lstPickvals;
    }
     @AuraEnabled  
     public static List < Event > saveAccount(List<Event> listOfAccount) {
         system.debug('listOfAccount'+listOfAccount);
        update listOfAccount;
        return listOfAccount;
    }
     @AuraEnabled  
     public static List < Task > saveAccountTask(List<Task> listOfAccount) {
         system.debug('listOfAccount'+listOfAccount);
        update listOfAccount;
        return listOfAccount;
    }
}
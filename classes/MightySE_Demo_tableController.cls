public class MightySE_Demo_tableController {
    @AuraEnabled(cacheable=true)
    public static List<Demos__c> getAlldemoData(Date startDate , Date endDate){
        List<Demos__c> getdemosdata = new List<Demos__c>();
        try{
            system.debug('in');
            if(startDate == null && endDate == null){
              //  getdemosdata = [SELECT id,Mighty_S_E__Link__c,Name, Mighty_S_E__User_Name__c, Mighty_S_E__password__c, 
                //                Mighty_S_E__Demo_Date__c, Mighty_S_E__Status__c, CreatedDate, Mighty_S_E__Times_Used__c, Mighty_S_E__Industry__c 
                  //              FROM Mighty_S_E__Demos__c where CreatedById =:UserInfo.getUserId()];    
               // system.debug('getdemosdata'+getdemosdata);
                
            }else if(startDate != null && endDate != null){
              	getdemosdata = [SELECT id,Mighty_S_E__Link__c,Name, Mighty_S_E__User_Name__c, Mighty_S_E__password__c, 
                                Mighty_S_E__Demo_Date__c, Mighty_S_E__Status__c, CreatedDate, Mighty_S_E__Times_Used__c, Mighty_S_E__Industry__c 
                                FROM Mighty_S_E__Demos__c where CreatedById =:UserInfo.getUserId() AND
                                (Mighty_S_E__Demo_Date__c >: startDate AND Mighty_S_E__Demo_Date__c <:  endDate)];
            }
	        }catch(Exception ex)  {
            	system.debug('Error---->'+ex.getMessage()); 
        	}
        
        return getdemosdata;
    }
    @AuraEnabled  
    public static List < Demos__c > saveAccount(List<Demos__c> listOfAccount) {
        system.debug('listOfAccount'+listOfAccount);
        update listOfAccount;
        return listOfAccount;
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
            System.debug('lstPickvals'+lstPickvals);} catch(Exception e){ 
                System.debug('error'+e.getMessage()+'---'+e.getStackTraceString());
            }
        return lstPickvals;
    }
}
public class MightySE_Opportunity_tableController {
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getAllOpportunityData(Date startDate , Date endDate){
        List<Opportunity> getOpportunitydata = new List<Opportunity>();
        try{
			if(startDate != null && endDate != null){
                System.debug('>>>>startDate<<<<'+startDate);
                System.debug('>>>>>endDate<<<<<<'+endDate);
                getOpportunitydata = [SELECT id,Name,AccountId,Account.Name,Pricebook2.Name,StageName,Amount,
                                      CloseDate,Pricebook2Id,OwnerId,Owner.Name,Type
                                      FROM Opportunity Where
                                		(CloseDate >: startDate AND CloseDate <:  endDate)
                                      AND (OwnerID =:UserInfo.getUserId()
                                          OR SalesEngineer__c =:UserInfo.getUserId())];    
            }
        }catch(Exception ex)  {
            system.debug('Error---->'+ex.getMessage()); 
        }
        
        return getOpportunitydata;
    }
    @AuraEnabled  
    public static List < Opportunity > saveAccount(List<Opportunity> listOfAccount) {
        system.debug('Opportunity'+listOfAccount);
        update listOfAccount;
        return listOfAccount;
    }
}
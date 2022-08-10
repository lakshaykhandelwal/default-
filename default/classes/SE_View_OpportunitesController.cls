public with sharing class SE_View_OpportunitesController {
    public String data {get;set;}
    public List<sObject> lstEditableTable {get; set;}
    public SE_View_OpportunitesController()
    {         
        
       if (Schema.sObjectType.Opportunity.isAccessible() && Schema.sObjectType.Account.isAccessible() &&Schema.sObjectType.User.isAccessible() &&
           Schema.sObjectType.Account.fields.Name.isAccessible() &&
           Schema.sObjectType.Opportunity.fields.Amount.isAccessible()&&
           Schema.sObjectType.Opportunity.fields.CloseDate.isAccessible()&&
           Schema.sObjectType.Opportunity.fields.Type.isAccessible()&&
           Schema.sObjectType.Opportunity.fields.Pricebook2Id.isAccessible()&&
           Schema.sObjectType.Opportunity.fields.OwnerId.isAccessible()&&
           Schema.sObjectType.User.fields.Username.isAccessible()&&
           Schema.sObjectType.Opportunity.fields.CreatedDate.isAccessible()
          ){

        lstEditableTable = [Select Id, Account.Name, StageName, Amount, CloseDate, Type, Pricebook2Id, Owner.Name, CreatedDate from Opportunity where CreatedById=:UserInfo.getUserId()];       
        data =  Json.serialize(lstEditableTable);
        }
    }
	@RemoteAction
    public static Boolean saveTable(String dataToUpdate) {
         try{
             System.debug('Step 1-'+dataToUpdate);
             List<sObject> Lstobj = (List<sObject>)Json.deserialize(dataToUpdate, List<Opportunity>.class);
             System.debug('Step 2-'+Lstobj);
             upsert Lstobj;
             system.debug('Updated!');
             return true;
        }
        catch(exception ex){
            system.debug('Errors---->:'+ ex.getMessage() +'---Line ---' + ex.getLineNumber());
            return false;
        }
    }
}
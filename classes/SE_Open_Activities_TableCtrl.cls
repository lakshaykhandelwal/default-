public with sharing class SE_Open_Activities_TableCtrl 
{
	public String data {get;set;}
    public List<sObject> lstEditableTable {get; set;}
 

    public SE_Open_Activities_TableCtrl()
    { 
    
        lstEditableTable = Database.query('SELECT ID, Subject, Owner.Name, Who.Name, EndDateTime, Account.Name, EventSubtype from Event');
       
        data = JSON.serialize(lstEditableTable);
      
    }
    @RemoteAction
    public static Boolean saveTable(String dataToUpdate) {
         try{
             System.debug('Step 1-'+dataToUpdate);
             List<sObject> Lstobj = (List<sObject>)Json.deserialize(dataToUpdate, List<Event>.class);
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
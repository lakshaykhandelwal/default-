@isTest
public class SE_Open_Activities_TableCtrlTest {
    @isTest
    public static void testClass()
    {
         RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/DemoUrl';  //Request URL
        req.httpMethod = 'POST';//HTTP Request Type
        req.requestBody = Blob.valueof('test');
        RestContext.request = req;
        RestContext.response= res;
        
        Test.setMock(HttpCalloutMock.class, new SE_Open_Activities_TableCtrlMock()); 
         
      
      
         SE_Open_Activities_TableCtrl controller = new SE_Open_Activities_TableCtrl();
        
        
           
        
       // upsert acc;
        
        //List<sObject> Lstobj = (List<String>)System.JSON.deserialize(dataToUpdate, List<String>.SE_Open_Activities_TableCtrl);

			SE_Open_Activities_TableCtrl.saveTable('test');
        // Boolean result = SE_Open_Activities_TableCtrl.saveTable('hello');
        System.assert(controller!=null);
      
    }
     @isTest
    public static void testClass2()
    {
         RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/DemoUrl';  //Request URL
        req.httpMethod = 'POST';//HTTP Request Type
        req.requestBody = Blob.valueof('test');
        RestContext.request = req;
        RestContext.response= res;
        
        Test.setMock(HttpCalloutMock.class, new SE_Open_Activities_TableCtrlMock()); 
         
      
      
         SE_Open_Activities_TableCtrl controller = new SE_Open_Activities_TableCtrl();
        
        
        
        
        List<Event> evtObj = new List<Event>();
        Event e = new Event();
        e.Description = 'Test event description';
        e.Subject = 'Test event subject';
        e.IsAllDayEvent = false;
        e.IsRecurrence = false;
        e.StartDateTime = DateTime.now();
        e.EndDateTime = DateTime.now().addHours(1);
        evtObj.add(e);
        SE_Open_Activities_TableCtrl.saveTable(JSON.serialize(evtObj));
        System.assert(controller!=null);
      
    }
    
    
   
     
}
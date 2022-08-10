@isTest
public class OppsControllerTest {
    @isTest
     public static void testClass()
    {
		OppsController o = new OppsController();
        ApexPages.StandardSetController obj = o.setCon;
        
        o.getOpportunities();
         system.assert(o!=null);
        
                   

    }

}
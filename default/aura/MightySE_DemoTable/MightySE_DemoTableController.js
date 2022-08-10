({
    getDemoDataJS : function(component, event, helper) {
        var now = new Date();
        var quarter = Math.floor((now.getMonth() / 3));
        var firstDate = new Date(now.getFullYear(), quarter * 3, 2)
        var endDate = new Date(firstDate.getFullYear(), firstDate.getMonth() + 3, 2)
        helper.getDemoDataJS(component, event , firstDate.toISOString().substr(0, 10), endDate.toISOString().substr(0, 10));
    },
    
    SaveAccount : function(component, event, helper) {
        console.log("getAllDemoList"+ JSON.stringify(component.get("v.getAllDemoList")));
        var action = component.get("c.saveAccount");
        action.setParams({
            'listOfAccount': component.get("v.getAllDemoList")
        });
        action.setCallback(this, function(response) {
            if (response.getState() === "SUCCESS" && component.isValid()) {
                
                component.set("v.AccountList", response.getReturnValue());
                component.set("v.showSaveCancelBtn",false);
                helper.showToast(component, event);
            }
        });
        $A.enqueueAction(action);
        
    },
    /*End*/
    
    
    save : function(component, event, helper) {
        try {
            component.find("edit").get("e.recordSave").fire();
        }catch (e) {
            console.log(e);
        }
        location.reload();// This will refresh the app to get the latest updated data.        
    },
    
    edit : function(component, event, helper) {
        component.set("v.isEdit",true);
        //component.set("v.editId",event.target.id);
    },
    
    onNext : function(component, event, helper) {        
        var pageNumber = component.get("v.currentPageNumber");
        component.set("v.currentPageNumber", pageNumber+1);
        helper.buildData(component, helper);
    },
    
    onPrev : function(component, event, helper) {        
        var pageNumber = component.get("v.currentPageNumber");
        component.set("v.currentPageNumber", pageNumber-1);
        helper.buildData(component, helper);
    },
    
    processMe : function(component, event, helper) {
        component.set("v.currentPageNumber", parseInt(event.target.name));
        helper.buildData(component, helper);
    },
    
    onFirst : function(component, event, helper) {        
        component.set("v.currentPageNumber", 1);
        helper.buildData(component, helper);
    },
    
    onLast : function(component, event, helper) {        
        component.set("v.currentPageNumber", component.get("v.totalPages"));
        helper.buildData(component, helper);
    },
    incinputChanged:function(component, event, helper) {
        if(event.getSource){
            var target = event.getSource();  
            var txtVal = target.get("v.value") ;
            cmp.set("v.selectedLookUpRecord",txtVal);   
        }
    },
    
    openDemo : function(component, event, helper) {
        var eve = $A.get("e.force:createRecord");
        eve.setParams({
            "entityApiName": "Mighty_S_E__Demos__c",
            "navigationLocation" : "LOOKUP",
            "panelOnDestroyCallback": function(event) {
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": "/lightning/n/Mighty_S_E__Mighty_SE1"
                });
                urlEvent.fire();
            }
        });
        eve.fire();
        //window.open("/lightning/o/Mighty_S_E__Demos__c/new?count=1&nooverride=1&useRecordTypeCheck=1&backgroundContext=%2Flightning%2Fn%2FMighty_S_E__Mighty_SE1");
    },
    getDates:function(component,event,helper){
        var startDate = event.getParam("startDate"); 
        var endDate = event.getParam("endDate");
        helper.getDemoDataJS(component, event , startDate, endDate);
        //alert(startDate+' '+endDate)
    }
})
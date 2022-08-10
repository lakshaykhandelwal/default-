({
    getTaskDataJS : function(component, event, helper) {
        var now = new Date();
        var quarter = Math.floor((now.getMonth() / 3));
        var firstDate = new Date(now.getFullYear(), quarter * 3, 2)
        var endDate = new Date(firstDate.getFullYear(), firstDate.getMonth() + 3, 1)
        helper.getTaskDataJS(component, event , firstDate.toISOString().substr(0, 10), endDate.toISOString().substr(0, 10));
    },
    SaveAccount : function(component, event, helper) {
        console.log("getAllActivityList"+ JSON.stringify(component.get("v.getAllActivityList")));
        var action = component.get("c.saveAccountTask");
        action.setParams({
            'listOfAccount': component.get("v.getAllActivityList")
        });
        action.setCallback(this, function(response) {
            if (response.getState() === "SUCCESS" && component.isValid()) {
                
                component.set("v.AccountList", response.getReturnValue());
                component.set("v.showSaveCancelBtn",false);
                helper.showToast(component, event, helper);
            }
        });
        $A.enqueueAction(action);
        
    },
    /*End*/
    applyfilter : function(component, event, helper){
        helper.getTaskDataJS(component, event);
    },
    
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
        filterDates:function(component,event,helper){
        var startDate = event.getParam("startDate"); 
        var endDate = event.getParam("endDate");
        helper.getTaskDataJS(component, event , startDate, endDate);
        //alert(startDate+' '+endDate)
    }  
    
})
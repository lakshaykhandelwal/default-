({
	getPriorityTypeList: function(component, event){
        
        var action = component.get("c.getPicklistValues");
        action.setParams({ ObjectApi_name : 'ActivityHistory', Field_name : 'Mighty_S_E__Priority__c' });
        
      
        action.setCallback(this, function(response) {
            var state = response.getState();
                
            if (state === "SUCCESS") {
            
                var result = response.getReturnValue();
                var industryMap = [];
                for(var key in result){
                    industryMap.push({key: key, value: result[key]});
                }
                component.set("v.priorityMap", industryMap);
                
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
                else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.log("Error message: " + 
                                        errors[0].message);
                        }
                    } else {
                        console.log("Unknown error");
                    }
                }
        });
       
        $A.enqueueAction(action);
    },
    getStatusTypeList: function(component, event){
        
        var action = component.get("c.getPicklistValues");
        action.setParams({ ObjectApi_name : 'ActivityHistory', Field_name : 'Mighty_S_E__Status__c' });
        
      
        action.setCallback(this, function(response) {
            var state = response.getState();
                
            if (state === "SUCCESS") {
            
                var result = response.getReturnValue();
                var industryMap = [];
                for(var key in result){
                    industryMap.push({key: key, value: result[key]});
                }
                component.set("v.statusMap", industryMap);
                
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
                else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.log("Error message: " + 
                                        errors[0].message);
                        }
                    } else {
                        console.log("Unknown error");
                    }
                }
        });
       
        $A.enqueueAction(action);
    },
    showToast : function(component, event) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "type": "success",
            "message": "The record has been updated successfully."
        });
        toastEvent.fire();
    },
	
})
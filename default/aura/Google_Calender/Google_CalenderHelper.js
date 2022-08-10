({
    getBaseUrl : function (component) {
        var action = component.get('c.getBaseUrl')
        action.setCallback(this, function (response) {
            var state = response.getState()
            
            if (component.isValid() && state === 'SUCCESS') {
                var result = response.getReturnValue()
                
                component.set('v.baseUrl', result)
            }
        })
        $A.enqueueAction(action)
    },
    getGoogleCalenderList:function(component, event ,sortField,startDate,endDate) {
        var action = component.get("c.getAllgoogleList");
        action.setParams({
            'sortField': sortField,
            'isAsc': component.get("v.isAsc"),
            startDate : startDate,
            endDate : endDate
        });
        action.setCallback(this,function(response) {
            var state = response.getState();
            
            if (state === "SUCCESS") {
                
                console.log('Response Time: '+((new Date().getTime())-requestInitiatedTime));
                component.set("v.totalPages", Math.ceil(response.getReturnValue().length/component.get("v.pageSize")));
                component.set("v.allData", response.getReturnValue());
                component.set("v.getAllgoogleList", response.getReturnValue());
                console.log("sort list #### ", component.get("v.getAllgoogleList"));
                component.set("v.currentPageNumber",1);
                this.buildData(component, event);
            } else if (state === "INCOMPLETE") {
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
        var requestInitiatedTime = new Date().getTime();
        $A.enqueueAction(action);
    },
    
    
    /*
     * This function get called when user clicks on Save button
     * user can get all modified records
     * and pass them back to server side controller
     * */
    saveDataTable : function(component, event) {
        var editedRecords =  component.find("accountDataTable").get("v.draftValues");
        var totalRecordEdited = editedRecords.length;
        var action = component.get("c.updateAccounts");
        action.setParams({
            'editedAccountList' : editedRecords
        });
        
        action.setCallback(this,function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                //if update is successful
                if(response.getReturnValue() === true){
                    this.showToast({
                        "title": "Record Update",
                        "type": "success",
                        "message": totalRecordEdited+"Records Updated"
                    });
                    this.reloadDataTable();
                } else{ //if update got failed
                    this.showToast({
                        "title": "Error!!",
                        "type": "error",
                        "message": "Error in update"
                    });
                }
            }
        });
        $A.enqueueAction(action);
        
        
    },
    
    /*
     * Show toast with provided params
     * */
    showToast : function(title,stype,msg) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": title,
            "type": stype,
            "message":msg
        });
        toastEvent.fire();
    },
    
    /*
     * reload data table
     * */
    reloadDataTable : function(){
        var refreshEvent = $A.get("e.force:refreshView");
        if(refreshEvent){
            refreshEvent.fire();
        }
    },
    
    
    /*
     * this function will build table data
     * based on current page selection
     * */
    buildData : function(component, event) {
        
        var data = [];
        var pageNumber = component.get("v.currentPageNumber");
        var pageSize = component.get("v.pageSize");
        var allData = component.get("v.allData");
        
        var x = (pageNumber-1)*pageSize;
        
        //creating data-table data
        for(; x<=(pageNumber)*pageSize; x++){
            if(allData[x]){
                data.push(allData[x]);
            }
        }
        
        
        component.set("v.getAllgoogleList", data);
        this.generatePageList(component, pageNumber);
    },
    
    /*
     * this function generate page list
     * */
    generatePageList : function(component, pageNumber){
        pageNumber = parseInt(pageNumber);
        var pageList = [];
        var totalPages = component.get("v.totalPages");
        if(totalPages > 1){
            if(totalPages <= 10){
                var counter = 2;
                for(; counter < (totalPages); counter++){
                    pageList.push(counter);
                } 
            } else{
                if(pageNumber < 5){
                    pageList.push(2, 3, 4, 5, 6);
                } else{
                    if(pageNumber>(totalPages-5)){
                        pageList.push(totalPages-5, totalPages-4, totalPages-3, totalPages-2, totalPages-1);
                    } else{
                        pageList.push(pageNumber-2, pageNumber-1, pageNumber, pageNumber+1, pageNumber+2);
                    }
                }
            }
        }
        component.set("v.pageList", pageList);
    },
    
    fetchComboboxValues : function(component, event){
        var action = component.get("c.fetchCombobox");
        
        var opts = [];
        action.setCallback(this, function (response) {
            
            if (response.getState() == "SUCCESS") {
                var allValues = response.getReturnValue();
                console.log(allValues);
                
                for (var i = 0; i < allValues.length; i++) {
                    opts.push({
                        
                        label: allValues[i].Name,
                        value: allValues[i].Name
                    });
                }
                component.set('v.Oppdata', opts);
            }
        });
        $A.enqueueAction(action);
    }, 
    
    fetchCombo : function(component, event){
        var action = component.get("c.fetchCombo");
        
        var opts = [];
        action.setCallback(this, function (response) {
            
            if (response.getState() == "SUCCESS") {
                var allValues = response.getReturnValue();
                console.log(allValues);
                
                for (var i = 0; i < allValues.length; i++) {
                    opts.push({
                        
                        label: allValues[i].Name,
                        value: allValues[i].Name
                    });
                }
                component.set('v.Demodata', opts);
            }
        });
        $A.enqueueAction(action);
    },
    sortData: function (cmp, fieldName, sortDirection) {
        var data = cmp.get("v.getAllgoogleList");
        console.log(data);
        var reverse = sortDirection !== 'asc';
        
        data.sort(this.sortBy(fieldName, reverse));
        console.log(data);
        cmp.set("v.getAllgoogleList", data);
    },
    sortBy: function (field, reverse, primer) {
        var key = primer ?
            function(x) {return primer(x[field])} :
        function(x) {return x[field]};
        reverse = !reverse ? 1 : -1;
        return function (a, b) {
            return a = key(a), b = key(b), reverse * ((a > b) - (b > a));
        }
    },
    fetchStoreListAllCalendar: function (component, event, helper) {
        
        var action = component.get("c.doStoreListAllCalendar");
        
        action.setCallback(this, function(response) {
            console.log('heloo  '+response.getState()+'---'+response.getReturnValue().includes("Error:"))
            if (response.getState() === "SUCCESS"  &&  !response.getReturnValue().includes("Error:")) {
                
                this.showToast( "Record Update","success","Google Calendar Events Updated Successfully");
                
                //window.location= component.get("v.baseUrl") +'/lightning/n/Mighty_S_E__Mighty_SE1';
                
            }else if (response.getState()  === "SUCCESS" && response.getReturnValue().includes("Error:")) {
                
                this.showToast( "ERROR","error",response.getReturnValue());
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
    sortHelper: function(component, event, sortFieldName) {
        var currentDir = component.get("v.arrowDirection");
        
        if (currentDir == 'arrowdown') {
            // set the arrowDirection attribute for conditionally rendred arrow sign  
            component.set("v.arrowDirection", 'arrowup');
            // set the isAsc flag to true for sort in Assending order.  
            component.set("v.isAsc", true);
        } else {
            component.set("v.arrowDirection", 'arrowdown');
            component.set("v.isAsc", false);
        }
        console.log("sortFieldName #### ",sortFieldName);
        // call the onLoad function for call server side method with pass sortFieldName 
        this.getGoogleCalenderList(component, event, sortFieldName);
    },
    getTaskTypeList: function(component, event){
        
        var action = component.get("c.getTaskPicklistValues");
        action.setParams({ ObjectApi_name : 'Task', Field_name : 'Type' });
        
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            
            if (state === "SUCCESS") {
                
                var result = response.getReturnValue();
                var taskTypeMap = [];
                for(var key in result){
                    taskTypeMap.push({key: key, value: result[key]});
                }
                component.set("v.taskTypeMap", taskTypeMap);
                
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
    getActivityTypeList: function(component, event){
        
        var action = component.get("c.getPicklistValues");
        action.setParams({ ObjectApi_name : 'ActivityHistory', Field_name : 'Mighty_S_E__Type__c' });
        
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            
            if (state === "SUCCESS") {
                
                var result = response.getReturnValue();
                var industryMap = [];
                for(var key in result){
                    industryMap.push({key: key, value: result[key]});
                }
                component.set("v.industryMap", industryMap);
                
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
    }
    
    
    
    
    
})

//helper
// Fetch the accounts from the Apex controller
//  getGoogleCalender: function(component) {
//  var action = component.get('c.getGoogleCalender');
// Set up the callback
//  var self = this;
// action.setCallback(this, function(actionResult) {
// component.set('v.getGoogleCalender', actionResult.getReturnValue());
//});
// $A.enqueueAction(action);
//}
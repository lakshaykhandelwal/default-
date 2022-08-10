({
    
    /*
     * This finction defined column header
     * and calls getAccounts helper method for column data
     * editable:'true' will make the column editable
     * */
    
    getGoogleDataJS : function(component, event, helper) {
        helper.getActivityTypeList(component, event);
        helper.getTaskTypeList(component, event);
        helper.getBaseUrl(component);
        var url = window.location.href;
        function getParameterByName(name, url) {
            if (!url) url = window.location.href;
            name = name.replace(/[\[\]]/g, '\\$&');
            var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
                results = regex.exec(url);
            console.log('===results==',results);
            if (!results) return null;
            if (!results[2]) return '';
            return decodeURIComponent(results[2].replace(/\+/g, ' '));
        }
        var code = getParameterByName('g__code');
        
        component.set("v.code", code); 
        component.set("v.sortdirectionsub", false);
        component.set("v.sortdirectiondate", false);
        component.set("v.sortdirectionactivity", false);
        component.set("v.sortdirectiondemo", false);
        
        var action = component.get('c.dogoogleFetchAccessToken');
        action.setParams({
            'code' : code
        });
        action.setCallback(this, function(response){
            var status = response.getState();
            console.log('response'+JSON.stringify(response))
            if(status === "SUCCESS"){
                helper.fetchStoreListAllCalendar(component, event, helper);
            }else if(status === "ERROR"){
                
                 helper.showToast( "ERROR","error",'Please Login into Google Calendar to sync your events.');
            }
        });
        
        $A.enqueueAction(action);
            
        //helper.getGoogleCalenderList(component, event);
        var fieldsub = 'Mighty_S_E__Subject__c';
        var now = new Date();
        var quarter = Math.floor((now.getMonth() / 3));
        var firstDate = new Date(now.getFullYear(), quarter * 3, 2)
        var endDate = new Date(firstDate.getFullYear(), firstDate.getMonth() + 3, 1)
        helper.getGoogleCalenderList(component, event, fieldsub,firstDate.toISOString().substr(0, 10), endDate.toISOString().substr(0, 10));        
    },
    googleLogin: function(component, event, helper) {
        var action = component.get("c.googleCalendar");
        console.log('action---'+action);
        action.setCallback(this, function(response) {
            console.log('response.getState----'+response.getState)
            if (response.getState() === "SUCCESS" && component.isValid()) {
                /*var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": "/lightning/Mighty_S_E__Mighty_SE1"
                });
                
                urlEvent.fire();*/
                var authUrl = response.getReturnValue();
                window.location.href = response.getReturnValue();
                console.log('here it is---');
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
        /*action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var showMsg = component.get('c.showSuccess');
                $A.enqueueAction(showMsg);
                //alert("From server: " + response.getReturnValue());
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
        $A.enqueueAction(action);*/
    },
    
    showSuccess : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Success',
            message: 'The event has been updated successfully.',
            duration:' 3000',
            key: 'info_alt',
            type: 'success',
            mode: 'dismissible'
        });
        toastEvent.fire();
    },
    
    syncandSaveClick: function(component, event, helper) {
        
        
    },
    
    
    
    SaveAccount : function(component, event, helper) {
        console.log("ccountList"+ JSON.stringify(component.get("v.getAllgoogleList")));
        var action = component.get("c.saveAccount");
        action.setParams({
            'listOfAccount': component.get("v.getAllgoogleList")
        });
        action.setCallback(this, function(response) {
            if (response.getState() === "SUCCESS" && component.isValid()) {
                
                component.set("v.AccountList", response.getReturnValue());
                component.set("v.showSaveCancelBtn",false);
                helper.showToast( "Record Update","success","Google Calendar Events Updated Successfully");
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
    } ,
    
    sortSubject: function(component, event, helper) {
       // set current selected header field on selectedTabsoft attribute.     
       component.set("v.selectedTabsoft", 'Mighty_S_E__Subject__c');
       // call the helper function with pass sortField Name   
       helper.sortHelper(component, event, 'Mighty_S_E__Subject__c');
    },
    sortStartdate: function(component, event, helper) {
       // set current selected header field on selectedTabsoft attribute.     
       component.set("v.selectedTabsoft", 'Mighty_S_E__Start_Date_Time__c');
       // call the helper function with pass sortField Name   
       helper.sortHelper(component, event, 'Mighty_S_E__Start_Date_Time__c');
    },
    sortOpportunity: function(component, event, helper) {
       // set current selected header field on selectedTabsoft attribute.     
       component.set("v.selectedTabsoft", 'Mighty_S_E__Opportunity_Name__c');
       // call the helper function with pass sortField Name   
       helper.sortHelper(component, event, 'Mighty_S_E__Opportunity_Name__c');
    },
    sortActivity: function(component, event, helper) {
       // set current selected header field on selectedTabsoft attribute.     
       component.set("v.selectedTabsoft", 'Mighty_S_E__Activity__c');
       // call the helper function with pass sortField Name   
       helper.sortHelper(component, event, 'Mighty_S_E__Activity__c');
    },
    sortType: function(component, event, helper) {
       // set current selected header field on selectedTabsoft attribute.     
       component.set("v.selectedTabsoft", 'Mighty_S_E__Task_Type__c');
       // call the helper function with pass sortField Name   
       helper.sortHelper(component, event, 'Mighty_S_E__Task_Type__c');
    },
    sortDemo: function(component, event, helper) {
       // set current selected header field on selectedTabsoft attribute.     
       component.set("v.selectedTabsoft", 'Mighty_S_E__Demo__c');
       // call the helper function with pass sortField Name   
       helper.sortHelper(component, event, 'Mighty_S_E__Demo__c');
    },
    updateColumnSorting: function (cmp, event, helper) {
        cmp.set("v.sortdirectionsub", true);
        cmp.set("v.sortdirectiondate", true);
        cmp.set("v.sortdirectionactivity", true);
        cmp.set("v.sortdirectiondemo", true);
        var fieldName = event.currentTarget.dataset.fieldName;
        
        console.log(fieldName);
        
        var sortDirection = event.currentTarget.dataset.sortDirection;
        console.log(sortDirection);
        cmp.set("v.sortedBy", fieldName);
        cmp.set("v.sortedDirection", sortDirection);
        helper.sortData(cmp, fieldName, sortDirection);
       if(fieldName == 'Mighty_S_E__Subject__c'){
            cmp.set("v.subjectSortDir", !sortDirection);
        }
    },
        filterDates:function(component,event,helper){
        var startDate = event.getParam("startDate"); 
        var endDate = event.getParam("endDate");
        var fieldsub = 'Mighty_S_E__Subject__c';
        helper.getGoogleCalenderList(component, event, fieldsub,startDate,endDate);
        //alert(startDate+' '+endDate)
    }
   
    
    
})
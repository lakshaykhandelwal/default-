({
    
    /*
     * This finction defined column header
     * and calls getAccounts helper method for column data
     * editable:'true' will make the column editable
     * */
    
    
    getAccountsJS : function(component, event, helper) {
        helper.getBaseUrl(component);
        helper.getActivityTypeList(component, event);
        helper.getTaskTypeList(component, event);
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
        var code = getParameterByName('o__code');
        
        component.set("v.code", code); 
        
        var action = component.get('c.doOutlookFetchAccessToken');
        action.setParams({
            'code' : code
        });
        action.setCallback(this, function(response){
            var status = response.getState();
            
            if(status === "SUCCESS"){
                helper.fetchStoreListAllCalendar(component, event, helper);
            }else{
                helper.showToast( "ERROR","error",'Please Login into Google Calendar to sync your events.');
            }
        });
        
        $A.enqueueAction(action);
        //helper.getGoogleCalenderList(component, helper);
        var fieldsub = 'Subject__c';
        var now = new Date();
        var quarter = Math.floor((now.getMonth() / 3));
        var firstDate = new Date(now.getFullYear(), quarter * 3, 2)
        var endDate = new Date(firstDate.getFullYear(), firstDate.getMonth() + 3, 1)
        helper.getGoogleCalenderList(component, event, fieldsub,firstDate.toISOString().substr(0, 10), endDate.toISOString().substr(0, 10));
        //helper.getGoogleCalenderList(component, event, fieldsub);
        
    },
    outlookLogin: function(component, event, helper) {
        
        
        var action = component.get("c.OutlookCalendar");
        
        action.setCallback(this, function(response) {
            
            if (response.getState() === "SUCCESS" && component.isValid()) {
                var authUrl = response.getReturnValue();
                window.location.href = response.getReturnValue();
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
    syncandSaveClick: function(component, event, helper) {
        
    },
    SaveAccount : function(component, event, helper) {
        console.log("ccountList"+ JSON.stringify( component.get("v.allOutlookRcds")));
        var action = component.get("c.saveAccount");
        action.setParams({
            'listOfAccount': component.get("v.allOutlookRcds")
        });
        action.setCallback(this, function(response) {
            if (response.getState() === "SUCCESS" && component.isValid()) {
                
                component.set("v.AccountList", response.getReturnValue());
                component.set("v.showSaveCancelBtn",false);
                helper.showToast( "Record Update","success","Outlook Calendar Events Updated Successfully");
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
    sortType: function(component, event, helper) {     
        component.set("v.selectedTabsoft", 'Mighty_S_E__Task_Type__c');
        helper.sortHelper(component, event, 'Mighty_S_E__Task_Type__c');
     },
    sortSubject: function(component, event, helper) {
        // set current selected header field on selectedTabsoft attribute.     
        component.set("v.selectedTabsoft", 'Subject__c');
        // call the helper function with pass sortField Name   
        helper.sortHelper(component, event, 'Subject__c');
    },
    sortStartdate: function(component, event, helper) {
        // set current selected header field on selectedTabsoft attribute.     
        component.set("v.selectedTabsoft", 'Event_Start_Date__c');
        // call the helper function with pass sortField Name   
        helper.sortHelper(component, event, 'Event_Start_Date__c');
    },
    sortOpportunity: function(component, event, helper) {
        // set current selected header field on selectedTabsoft attribute.     
        component.set("v.selectedTabsoft", 'Opportunity_Name__c');
        // call the helper function with pass sortField Name   
        helper.sortHelper(component, event, 'Opportunity_Name__c');
    },
    sortActivity: function(component, event, helper) {
        // set current selected header field on selectedTabsoft attribute.     
        component.set("v.selectedTabsoft", 'Activity__c');
        // call the helper function with pass sortField Name   
        helper.sortHelper(component, event, 'Activity__c');
    },
    sortDemo: function(component, event, helper) {
        // set current selected header field on selectedTabsoft attribute.     
        component.set("v.selectedTabsoft", 'Demo__c');
        // call the helper function with pass sortField Name   
        helper.sortHelper(component, event, 'Demo__c');
    },
    incinputChanged:function(component, event, helper) {
        if(event.getSource){
            var target = event.getSource();  
            var txtVal = target.get("v.value") ;
            component.set("v.selectedLookUpRecord",txtVal);   
        }
    },       
    filterDates:function(component,event,helper){
        var startDate = event.getParam("startDate"); 
        var endDate = event.getParam("endDate");
        var fieldsub = 'Subject__c';
        helper.getGoogleCalenderList(component, event, fieldsub,startDate,endDate);
        //alert(startDate+' '+endDate)
    }  
    
    
})
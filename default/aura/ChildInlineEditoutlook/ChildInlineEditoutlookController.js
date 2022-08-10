({
    doInit: function(component, event, helper) {
        //  helper.fetchPickListVal(component, 'Rating', 'ratingPicklistOpts');
       // helper.getActivityTypeList(component, event);
    },
    EditName : function(component,event,helper){  
        component.set("v.nameEditMode", true);
        
    },
    closeName: function(component,event,helper){  
        component.set("v.nameEditMode", false);
        
    },
    EditName2 : function(component,event,helper){  
        component.set("v.nameEditMode2", true);
        setTimeout(function(){
            component.find("demoname").focus();
        }, 100);
    },
    closeName2: function(component,event,helper){  
        component.set("v.nameEditMode2", false);
        
    },
    EditName3 : function(component,event,helper){  
        component.set("v.nameEditMode3", true);
        setTimeout(function(){
            component.find("activitytype").focus();
        }, 100);
    },
    closeName3: function(component,event,helper){  
        component.set("v.nameEditMode3", false);
        
    },
    
    onNameChange : function(component,event,helper){
        if(event.getSource().get("v.value").trim() != ''){
            component.set("v.showSaveCancelBtn",true);
        }
    },
    onRatingChange : function(component,event,helper){
        component.set("v.showSaveCancelBtn",true);
    },    
    closeNameBox : function (component, event, helper) {
        component.set("v.nameEditMode", false);
        if(event.getSource().get("v.value").trim() == ''){
            component.set("v.showErrorClass",true);
        }else{
            component.set("v.showErrorClass",false);
        }
    },
    handleComponentEvent : function (component,event,helper)
    {
        // alert( event.getParam("oppid").Name);
        if(event.getParam("oppid").Id != null)
        {
           
             component.find('sdatas').set('v.value',event.getParam("oppid").Id);
            
            
            component.set("v.singleAccount.Mighty_S_E__Opportunity__r",event.getParam("oppid"));
            component.set("v.showSaveCancelBtn",true);
            component.set("v.nameEditMode",false);
            
        }
        
    }
    ,
    handleComponentEvent2 : function (component,event,helper)
    {
        //alert( event.getParam("demoid").Name);
        if(event.getParam("demoid").Id != null)
        {
            
            component.find('demoname').set('v.value',event.getParam("demoid").Id);
           
            component.set("v.singleAccount.Mighty_S_E__Demo_Id__r",event.getParam("demoid"));
            component.set("v.showSaveCancelBtn",true);
            component.set("v.nameEditMode2",false);
            
        }
        
    }
    , 
    slectedVal: function (component, event, helper) {
        component.set("v.nameEditMode3",false);
        component.set("v.showSaveCancelBtn",true);
    },
    closeNameBox2 : function (component, event, helper) {
        component.set("v.nameEditMode2", false);
        if(event.getSource().get("v.value").trim() == ''){
            component.set("v.showErrorClass",true);
        }else{
            component.set("v.showErrorClass",false);
        }
    },
    closeRatingBox : function (component, event, helper) {
        component.set("v.ratingEditMode", false);
    },

    editTaskType : function(component,event,helper){  
        component.set("v.editTaskType", true);
        setTimeout(function(){
            component.find("taskType").focus();
        }, 100);
         component.set("v.showSaveCancelBtn",true);
         
    },
    closeTaskType: function(component,event,helper){  
        component.set("v.editTaskType", false);
        
       
    },
    selectedTask: function (component, event, helper) {
        component.set("v.nameEditMode3",false);
  },
})
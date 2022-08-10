({
    doInit: function(component, event, helper) {
      //  helper.fetchPickListVal(component, 'Rating', 'ratingPicklistOpts');
       
        
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
            component.find("accRating").focus();
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
         component.set("v.showSaveCancelBtn",true);
         
    },
    closeName3: function(component,event,helper){  
        component.set("v.nameEditMode3", false);
        
       
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
    
    inlineEditRating : function(component,event,helper){  
        component.set("v.ratingEditMode", true);
        
        setTimeout(function(){
            component.find("accRating").focus();
        }, 100);
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
        
        if(event.getParam("demoid").Id != null)
        {
            component.find('accRating').set('v.value',event.getParam("demoid").Id);
           
            component.set("v.singleAccount.Mighty_S_E__Demo_Id__r",event.getParam("demoid"));
            
            component.set("v.showSaveCancelBtn",true);
            component.set("v.nameEditMode2",false);
            
        }
        
    }
    , 
    
    slectedVal: function (component, event, helper) {
          component.set("v.nameEditMode3",false);
    },
    selectedTask: function (component, event, helper) {
          component.set("v.nameEditMode3",false);
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
})
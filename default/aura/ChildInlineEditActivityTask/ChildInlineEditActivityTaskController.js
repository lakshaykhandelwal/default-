({
    doInit: function(component, event, helper) {
        //helper.fetchPickListVal(component, 'Rating', 'ratingPicklistOpts');
           helper.getPriorityTypeList(component, event);
        helper.getStatusTypeList(component, event);
    },
    EditName : function(component,event,helper){  
        component.set("v.nameEditMode", true);
       component.set("v.showSaveCancelBtn",true);
    },
    slectedVal: function(component,event,helper){  
        component.set("v.nameEditMode2", false);
       component.set("v.nameEditMode",false);
    },
    closeName: function(component,event,helper){  
        component.set("v.nameEditMode", false);
      
    },
     EditName2 : function(component,event,helper){  
        component.set("v.nameEditMode2", true);
          component.set("v.showSaveCancelBtn",true);
        setTimeout(function(){
            component.find("statustype").focus();
        }, 100);
    },
    closeName2: function(component,event,helper){  
        component.set("v.nameEditMode2", false);
       
    },
    closeinput: function(component,event,helper){  
        component.set("v.nameEditMode3", false);
       
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
       // alert( event.getParam("oppid").Name);
        if(event.getParam("oppid").Name != null)
        {
            component.find('sdatas').set('v.value',event.getParam("oppid").Name);
            component.set("v.showSaveCancelBtn",true);
            component.set("v.nameEditMode",false);
            
        }
        
    }
    ,
    handleComponentEvent2 : function (component,event,helper)
    {
       // alert( event.getParam("demoid").Name);
        if(event.getParam("demoid").Name != null)
        {
            component.find('accRating').set('v.value',event.getParam("demoid").Name);
            component.set("v.showSaveCancelBtn",true);
            component.set("v.nameEditMode2",false);
            
        }
        
    }
    , 
    handleComponentEventr: function (component,event,helper)
    {
       // alert( event.getParam("demoid").Name);
        if(event.getParam("OwnerId").Name != null)
        {
            component.find('accRating').set('v.value',event.getParam("OwnerId").Name);
            component.set("v.showSaveCancelBtn",true);
            component.set("v.nameEditMode2",false);
            
        }
        
    }
    , 
      closeNameBox2 : function (component, event, helper) {
        component.set("v.nameEditMode2", false);
        if(event.getSource().get("v.value").trim() == ''){
            component.set("v.showErrorClass",true);
        }else{
            component.set("v.showErrorClass",false);
        }
    },
     EditName3 : function(component,event,helper){  
        component.set("v.nameEditMode3", true);
        setTimeout(function(){
            component.find("sdatas").focus();
        }, 100);
           component.set("v.showSaveCancelBtn",true);
    },
    closeName3: function(component,event,helper){  
        component.set("v.nameEditMode3", false);
         component.set("v.showSaveCancelBtn",false);
    },
     EditName4 : function(component,event,helper){  
        component.set("v.nameEditMode4", true);
        setTimeout(function(){
            component.find("accRating").focus();
        }, 100);
           component.set("v.showSaveCancelBtn",true);
    },
    closeName4: function(component,event,helper){  
        component.set("v.nameEditMode4", false);
         component.set("v.showSaveCancelBtn",false);
    },
    closeRatingBox : function (component, event, helper) {
        component.set("v.ratingEditMode", false);
    },
})
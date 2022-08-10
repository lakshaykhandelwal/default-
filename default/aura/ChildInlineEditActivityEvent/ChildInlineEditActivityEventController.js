({
    doInit: function(component, event, helper) {
        //helper.fetchPickListVal(component, 'Rating', 'ratingPicklistOpts');
         helper.getPriorityTypeList(component, event);
        helper.getStatusTypeList(component, event);
    },
    EditName : function(component,event,helper){  
        component.set("v.nameEditMode", true);
      
    },
    closeName: function(component,event,helper){  
        component.set("v.nameEditMode", false);
      
    },
    closeinput: function(component,event,helper){  
        component.set("v.nameEditMode3", false);
      
    },
     EditName2 : function(component,event,helper){  
        component.set("v.nameEditMode2", true);
        setTimeout(function(){
            component.find("statustype").focus();
        }, 100);
    },
    closeName2: function(component,event,helper){  
        component.set("v.nameEditMode2", false);
       
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
            component.find("usersdatas").focus();
        }, 100);
           component.set("v.showSaveCancelBtn",true);
    },
    closeName4: function(component,event,helper){  
        component.set("v.nameEditMode4", false);
         component.set("v.showSaveCancelBtn",false);
    },
      EditName5 : function(component,event,helper){  
        component.set("v.nameEditMode5", true);
        setTimeout(function(){
            component.find("dateaccRating").focus();
        }, 100);
           component.set("v.showSaveCancelBtn",true);
    },
    closeName5: function(component,event,helper){  
        component.set("v.nameEditMode5", false);
         component.set("v.showSaveCancelBtn",false);
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
        if(event.getParam("OwnerId").Name != null)
        {
            component.find('usersdatas').set('v.value',event.getParam("OwnerId").Name);
            component.set("v.showSaveCancelBtn",true);
            component.set("v.nameEditMode4",false);
            
        }
        
    },
    slectedVal: function (component, event, helper) {
          component.set("v.nameEditMode",false);
        component.set("v.nameEditMode2",false);
          component.set("v.showSaveCancelBtn",true);
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
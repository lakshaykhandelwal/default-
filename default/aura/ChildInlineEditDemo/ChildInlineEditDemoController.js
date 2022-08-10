({
    doInit: function(component, event, helper) {
        //helper.fetchPickListVal(component, 'Rating', 'ratingPicklistOpts');
        helper.getStatusTypeList(component, event);
    },
    EditName : function(component,event,helper){  
        component.set("v.nameEditMode", true);
       setTimeout(function(){
            component.find("statustype").focus();
        }, 100)
    },
    closeName: function(component,event,helper){  
        component.set("v.nameEditMode", false);
      
    },
     EditName2 : function(component,event,helper){  
        component.set("v.nameEditMode2", true);
        
    },
    closeName2: function(component,event,helper){  
        component.set("v.nameEditMode2", false);
       
    },
    slectedVal: function(component,event,helper){  
        component.set("v.nameEditMode", false);
           component.set("v.showSaveCancelBtn",true);
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
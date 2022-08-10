({
    doInit: function(component, event, helper) {
        //helper.fetchPickListVal(component, 'Rating', 'ratingPicklistOpts');
    },
    EditName : function(component,event,helper){  
        component.set("v.nameEditMode", true);
        component.set("v.showSaveCancelBtn",true);
        setTimeout(function(){
            component.find("stageaccRating").focus();
        }, 100);
    },
    closeName: function(component,event,helper){  
        component.set("v.nameEditMode", false);
        
    },
    EditName3 : function(component,event,helper){  
        component.set("v.nameEditMode3", true);
        setTimeout(function(){
            component.find("AmountaccRating").focus();
        }, 100);
        component.set("v.showSaveCancelBtn",true);
    },
    closeName3: function(component,event,helper){  
        component.set("v.nameEditMode3", false);
        
    },
    EditName2 : function(component,event,helper){  
        component.set("v.nameEditMode2", true);
        setTimeout(function(){
            component.find("accRating").focus();
        }, 100);
        component.set("v.showSaveCancelBtn",true);
    },
    closeName2: function(component,event,helper){  
        component.set("v.nameEditMode2", false);
        
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
    hidedata: function (component, event, helper) {
        component.set("v.nameEditMode", false);
        component.set("v.nameEditMode3", false);
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
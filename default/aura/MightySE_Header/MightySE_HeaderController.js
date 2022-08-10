({
    doInit : function(component,event,helper){
        var now = new Date();
        var quarter = Math.floor((now.getMonth() / 3));
        var firstDate = new Date(now.getFullYear(), quarter * 3, 2);
        var endDate = new Date(firstDate.getFullYear(), firstDate.getMonth() + 3, 1);
        component.set("v.startDate",firstDate.toISOString().substr(0, 10));
        component.set("v.endDate",endDate.toISOString().substr(0, 10));
    },
    applyFilter : function(component,event,helper){
        console.log('applyFilters Called')
        var field1 = component.find('startDate');
        var field2 = component.find('endDate');
        var startDate = component.get("v.startDate");
        var endDate = component.get("v.endDate");
        console.log('applyFilters Called2')
        if(startDate != null && endDate != null){
            console.log('applyFilters Called3')
            field1.setCustomValidity("");
            field2.setCustomValidity("");
            var appEvent = $A.get("e.c:MightySE_FilterDateEvents");
            appEvent.setParams({"startDate" : startDate,
                                "endDate" : endDate}); 
            console.log('applyFilters Called',appEvent)
            appEvent.fire();
        }else{
            console.log('applyFilters Called4')
            field1.setCustomValidity("Please Enter a valid value");
            field2.setCustomValidity("Please Enter a valid value");
        }
        field1.reportValidity();
        field2.reportValidity();
    }
})
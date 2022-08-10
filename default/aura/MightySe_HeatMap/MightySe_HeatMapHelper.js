({
    afterload: function(component, event, helper) {
        
        
        var action = component.get("c.fetchValue");
        
        action.setCallback(this,function(response) {
            var state = response.getState();
            
            if (state === "SUCCESS") {
                var i=0;
                var mapdata =[];
                var lstData = JSON.parse(response.getReturnValue());
                var title='National Map of Deal Locations';
              
                
                for (i = 0; i < lstData.length; i++) {
                    
                    if(lstData[i]!=undefined && lstData[i].Name != undefined && lstData[i].Hours != undefined){
                        
                        mapdata.push({"code":lstData[i].Name.toUpperCase(), "value":Math.round(parseFloat(lstData[i].Hours))});
                    }
                }
                console.log('mapdata'+mapdata);
                Highcharts.mapChart('schart', {
                    chart: {
                        map: 'countries/us/us-all',
                        borderWidth: 1
                    },
                    title: {
                        text: title
                    },
                    exporting: {
                        sourceWidth: 600,
                        sourceHeight: 500
                    },
                    
                    legend: {
                        layout: 'horizontal',
                        borderWidth: 0,
                        backgroundColor: 'rgba(255,255,255,0.85)',
                        floating: true,
                        verticalAlign: 'top',
                        y: 25
                    },
                    
                    mapNavigation: {
                        enabled: true
                    },
                    
                    colorAxis: {
                        min: 1,
                        type: 'logarithmic',
                        minColor: '#EEEEFF',
                        maxColor: '#000022',
                        stops: [
                            [0, '#EFEFFF'],
                            [0.67, '#4444FF'],
                            [1, '#000022']
                        ]
                    },
                    
                    series: [{
                        animation: {
                            duration: 1000
                        },
                        data: mapdata,
                        joinBy: ['postal-code', 'code'],
                        dataLabels: {
                            enabled: true,
                            color: '#FFFFFF',
                            format: '{point.code}'
                        },
                        name: 'Opportunity density',
                        tooltip: {
                            pointFormat: '{point.code}: {point.value}'
                        }
                    }]
                });
            }
        });
        
        $A.enqueueAction(action);
           
        
    }
 })
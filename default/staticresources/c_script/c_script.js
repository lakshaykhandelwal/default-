 function stackedbarchart(sequence,data){  
            var stringified = JSON.stringify(data);
            var lstData = JSON.parse(stringified);
          //   lstData1= JSON.parse(data);//sforce.connection.query("{!chart_query}");//"{!lstChart}";
            
            console.log('stackChartData',lstData);
           
            
             names = [...new Set(lstData.map(a => a.Name ))];
            console.log(names);
            
             stage = [...new Set(lstData.map(a => a.Stage ))];
             console.log(stage);
            
            var j=0;
            var k=0;
            var q=0;
            var svalArr=[];
            //  var ValArr=[];
            //  var arrrr =[];
            for (j = 0; j < lstData.length; j++) {
                var ValArr=[];
                var arrrr =[];
                
                for (q = 0; q < names.length; q++) {
                    
                    for (k = 0; k < stage.length; k++) {
                        
                        if(lstData[j].Stage == stage[k]  && lstData[j].Name == names[q])
                            {
                                arrrr['name'] = lstData[j].Stage;
                                ValArr.push(lstData[j].Value);
                               
                             }else
                             {
                                   ValArr.push(0);	
                    				arrrr['name'] = stage[k];
                                          	              
                             }
                        
                    }
                    	
                	
                  }
                 	
                arrrr['data'] = ValArr;
                svalArr.push(arrrr); 
            }
            console.log(svalArr);
            Highcharts.chart("stacked"+sequence, {
                chart: {
                    type: 'column'
                },
                title: {
                    text: 'Stacked column chart'
                },
                xAxis: {
                    categories: names
                },
                yAxis: {
                    
                    min:0,
                    title: {
                        text: 'Total Amount consumption'
                    },
                    stackLabels: {
                        enabled: true,
                        style: {
                            fontWeight: 'bold',
                            color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
                        }
                    }
                },
                legend: {
                    align: 'right',
                    x: -30,
                    verticalAlign: 'top',
                    y: 40,
                    floating: true,
                    backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || 'white',
                    borderColor: '#CCC',
                    borderWidth: 1,
                    shadow: false
                },
                tooltip: {
                    headerFormat: '<b>{point.x}</b><br/>',
                    pointFormat: '{series.name}: {point.y}<br/>Total: {point.stackTotal}'
                },
                plotOptions: {
                    column: {
                        stacking: 'normal',
                        dataLabels: {
                            enabled: true,
                            color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white'
                        }
                    }
                },
                series: svalArr
            });
        }


        ///For pie charts


        function loadpiecharts(sequence,data,title,showLegends,unit){  
            // Coverge reps by hours
            var lstData = [];
            var lstEvents = [];
            var record1 = [];

            var stringified = JSON.stringify(data);
            var lstData = JSON.parse(stringified);
          //  lstData = JSON.parse('{!data}');//sforce.connection.query("{!chart_query}");//"{!lstChart}";
            console.log('lstData',lstData);
            var OppBySE =[];
            var i=0;
            for (i = 0; i < lstData.length; i++) {
                if(lstData[i]!=undefined && lstData[i].Name != undefined && lstData[i].Hours != undefined){
                    OppBySE.push({"name" : lstData[i].Name, "y" : Math.round(parseFloat(lstData[i].Hours))});
                }
            }
            /*Highcharts.setOptions({
            
            });*/
            Highcharts.chart('pie'+sequence, {
                chart: {
                    type: 'pie',
                    options3d: {
                    enabled: true,
                    alpha: 45,
                    beta: 0
                    },
                    
                },
                colors: ['#423030','#e57129', '#60cde0', ],
                
                title: {
                    text: title
                },
                tooltip: {
                    pointFormat: '{series.name}: <b>{point.percentage:.1f} %</b>'
                },
                plotOptions: {
                    pie: {
                        allowPointSelect: true,
                        cursor: 'pointer',
                         depth: 35,
                        dataLabels: {
                            enabled: false,
                            format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                        },
                        showInLegend: showLegends
                    }
                },
                credits: {
                    enabled: false
                },
                series: [{
                    name: unit,
                    colorByPoint: true,
                    data: OppBySE
                }]
        });
    }
        ///end for pie charts
        

        // barcharts


        function loadBarcharts(sequence,data,title,showLegends){  
            // Coverge reps by hours
            var lstData = [];
            var lstEvents = [];
            var record1 = [];
            var stringified = JSON.stringify(data);
            var lstData = JSON.parse(stringified);
           // lstData = JSON.parse('{!data}');//sforce.connection.query("{!chart_query}");//"{!lstChart}";
            console.log('lstData',lstData);
            var nameArr =[];
            var pointsArr = [];
            var i=0;
            for (i = 0; i < lstData.length; i++) {
                if(lstData[i]!=undefined && lstData[i].Name != undefined && lstData[i].Hours != undefined){
                    nameArr.push(lstData[i].Name);
                    pointsArr.push(Math.round(parseFloat(lstData[i].Hours)));
                }
            }
            Highcharts.chart('barcharts'+sequence, {
                chart: {
                    type: 'column'
                },
                title: {
                    text: title
                },
                credits: false,
                xAxis: {
                    categories: nameArr,
                    crosshair: true
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: 'SE Activities'
                    }
                },
                tooltip: {
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                    '<td style="padding:0"><b>{point.y:.1f} mm</b></td></tr>',
                    footerFormat: '</table>',
                    shared: true,
                    useHTML: true
                },
                plotOptions: {
                    column: {
                        pointPadding: 0,
                        borderWidth: 0,
                        showInLegend: showLegends
                    }
                },
                series: [{
                    name: '',
                    data: pointsArr
                    
                }]
            });
        }

        //end for barcharts



	//for heatmap

    function loadHeatMapcharts(sequence,data,title){  
            var lstData = [];
            var stringified = JSON.stringify(data);
            var lstData = JSON.parse(stringified);
            //lstData = JSON.parse('{!data}');
            console.log('lstData',lstData);
            var mapdata =[];
            var i=0;
            for (i = 0; i < lstData.length; i++) {
                if(lstData[i]!=undefined && lstData[i].Name != undefined && lstData[i].Hours != undefined){
                    mapdata.push({"code":lstData[i].Name.toUpperCase(), "value":Math.round(parseFloat(lstData[i].Hours))});
                }
            }
            console.log('Map--->',mapdata);
            Highcharts.mapChart('heatmap'+sequence, {
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
    //end for heatmap



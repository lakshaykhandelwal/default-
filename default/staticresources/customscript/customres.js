  function stackedbarcharts(sequence,data){  
            lstData = JSON.parse(data);//sforce.connection.query("{!chart_query}");//"{!lstChart}";
            
            console.log('stackChartData',lstData);
            /* 	
            var uniqueNames = [...new Set(lstData.map(data => data.Name))];
           	var uniqueStages = [...new Set(lstData.map(data => data.Stage))];
            console.log('uniqueNames--',uniqueNames);
            var i;
            var dataMap=[];
            for(i=0; i<lstData.length; i++)
            {
                var j;
                for(j=0; j<uniqueNames.length; j++)
                {
                    var arrTest=[];
                    if(lstData[i].Name==uniqueNames[j])
                    {
                        arrTest['name'] = lstData[i].Stage;
                        arrTest['data'] = lstData[i].Value;
                        if(dataMap[uniqueNames[j]]==undefined || dataMap[uniqueNames[j]]==null){
                            dataMap[uniqueNames[j]] = arrTest;
                        }
                        else
                        {
                            var lstTestData=[];
                            lstTestData.push(dataMap[uniqueNames[j]]);
                            lstTestData.push(arrTest);
                            dataMap[uniqueNames[j]]=lstTestData;
                        }
                    }	
                }
            }
            
            //console.log('dataMap--',dataMap);
            for(i=0; i<dataMap.length; i++)
            {
                var j;
                for(j=0; j<uniqueStages.length; j++)
                {
                    if(dataMap[i].name == uniqueStages[j])
                    {
                        
                    }
                }
            }
            
            */
            
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
            Highcharts.chart('sequence', {
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
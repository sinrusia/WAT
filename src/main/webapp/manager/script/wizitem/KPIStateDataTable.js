/**
 * Created by gojaehag on 2015. 11. 20..
 */
/**
 * ssd uiitem 확장 모듈
 */
(function (ssd) {

    /**
     * ssd에 확장 모듈을 정의한다
     * @param $scope
     * @constructor
     */
    ssd.KPIStateDataTable = function ($scope, $element) {

        var data = new Array();
        var firstNames =
            [
                "Andrew", "Nancy", "Shelley", "Regina", "Yoshi", "Antoni", "Mayumi", "Ian", "Peter", "Lars", "Petra", "Martin", "Sven", "Elio", "Beate", "Cheryl", "Michael", "Guylene"
            ];
        var lastNames =
            [
                "Fuller", "Davolio", "Burke", "Murphy", "Nagase", "Saavedra", "Ohno", "Devling", "Wilson", "Peterson", "Winkler", "Bein", "Petersen", "Rossi", "Vileid", "Saylor", "Bjorn", "Nodier"
            ];
        var productNames =
            [
                "Black Tea", "Green Tea", "Caffe Espresso", "Doubleshot Espresso", "Caffe Latte", "White Chocolate Mocha", "Cramel Latte", "Caffe Americano", "Cappuccino", "Espresso Truffle", "Espresso con Panna", "Peppermint Mocha Twist"
            ];
        var priceValues =
            [
                "2.25", "1.5", "3.0", "3.3", "4.5", "3.6", "3.8", "2.5", "5.0", "1.75", "3.25", "4.0"
            ];
        for (var i = 0; i < 10; i++) {
            var row = {};
            var productindex = Math.floor(Math.random() * productNames.length);
            var price = parseFloat(priceValues[productindex]);
            var quantity = 1 + Math.round(Math.random() * 10);
            row["firstname"] = firstNames[Math.floor(Math.random() * firstNames.length)];
            row["lastname"] = lastNames[Math.floor(Math.random() * lastNames.length)];
            row["productname"] = productNames[productindex];
            row["price"] = price;
            row["quantity"] = quantity;
            row["total"] = price * quantity;
            data[i] = row;
        }
        var source =
        {
            localData: data,
            dataType: "array",
            dataFields: [
                {name: 'firstname', type: 'string'},
                {name: 'lastname', type: 'string'},
                {name: 'productname', type: 'string'},
                {name: 'quantity', type: 'number'},
                {name: 'price', type: 'number'},
                {name: 'total', type: 'number'}
            ]
        };
        var dataAdapter = new $.jqx.dataAdapter(source);


        $element.find('.datatable').jqxDataTable({
            width: '100%',
            height: '200px',
            pageable: false,
            pageSize: 5,
            columnsResize: true,
            columns: [
                {text: '번호', dataField: 'rownum', width: 50, align: 'center'},
                {text: 'KPI명', dataField: 'kpi_name', align: 'center'},
                {text: '목표값', dataField: 'target', width: 150, align: 'center'},
                {text: '월중 실적', dataField: 'month_result', width: 150, align: 'center'},
                {text: '분기 실적', dataField: 'quarter_result', width: 150, align: 'center'},
                {text: '연중 실적', dataField: 'year_result', width: 150, align: 'center'},
                {
                    text: '최근 12개월 추이', dataField: 'month_trend', width: 250, align: 'center',
                    cellsRenderer: function (row, column, value, rowData) {

                        console.log('cellsRenderer');
                        //$scope.sparklineOption = {'height': 45,'barWidth': 20,'barSpacing': 10,'barColor': '#C0FFC0'};


                        //var aaa= '<div jq-sparkline type="bar" ng-model="data.mons"opts={{sparklineOption}} class="sparkline"> </div>'

                        var tag = '<div class="kpi-sparkline" style="width: 240px;height: 20px;">'+value+'</div>';


                        return tag;
                    },

                    rendered: function (element, align, height) {
                        console.log('rendered');
                        console.log(element);
                    }
                }
            ],
            rendered: function () {
                $('.kpi-sparkline').each(function (index) {
                    //$(this).sparkline('html', {type: "line", width:'240px'});


                    //alert($(this).text());

                    var values = $(this).text()

                    var settings = {
                        title: '',
                        description: '',
                        showLegend: false,
                        enableAnimations: false,
                        showBorderLine: false,
                        showToolTips: false,
                        backgroundColor: 'transparent',
                        padding: {left: 0, top: 0, right: 0, bottom: 0},
                        titlePadding: {left: 0, top: 0, right: 0, bottom: 0},
                        source: values.split(','),
                        xAxis: {
                            visible: false,
                            valuesOnTicks: false
                        },
                        colorScheme: 'scheme01',
                        seriesGroups: [
                            {
                                type: 'line',
                                columnsGapPercent: 0,
                                columnsMaxWidth: 4,

                                valueAxis: {
                                    minValue: 0,
                                    visible: false
                                },
                                series: [
                                    {"displayText": "건수", symbolType: "circle"}
                                ]
                            }
                        ]
                    };

                    $(this).jqxChart(settings);

                });
            }
        });

        /**
         *
         */
        $scope.updateData = function (resData, source, element) {
            source.localData = resData;
            var dataAdapter = new $.jqx.dataAdapter(source);

            element.find('.datatable').jqxDataTable({source: dataAdapter});

        }
    }
})(ssd);

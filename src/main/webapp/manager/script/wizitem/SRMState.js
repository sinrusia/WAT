/**
 * Created by gojaehag on 2015. 11. 17..
 */

/**
 */
(function (ssd) {

    /**
     * ssd에 확장 모듈을 정의한다
     * @param $scope
     * @constructor
     */
    ssd.SRMState = function ($scope) {

        $scope.dayCount = 0;
        $scope.monthCount = 0;
        $scope.yearCount = 0;

        /**
         *
         */
        $scope.updateData = function (resData, source, element) {
            if (source.field == 'monthCounts') {
                $('#srmMonthState').jqxChart({source: resData});
                $('#srmMonthState').jqxChart('refresh');
            } else if (source.field == 'dayCounts') {
                $('#srmDayState').jqxChart({source: resData});
                $('#srmDayState').jqxChart('refresh');

            }
        }


        var monthCounts = [];

        var dayCounts = [];

        for (var i = 1; i <= 31; i++) {
            dayCounts.push({day: i, count: 0});
        }

        for (var i = 1; i <= 12; i++) {
            monthCounts.push({month: i, count: 0});
        }

        //일별 발생현황
        var dayChartSettings = {
            title: "",
            description: "",
            borderLineWidth: 0,
            enableAnimations: true,
            showLegend: false,
            padding: {left: 10, top: 5, right: 10, bottom: 5},
            titlePadding: {left: 0, top: 0, right: 0, bottom: 10},
            source: dayCounts,
            xAxis: {
                dataField: 'day',
                gridLines: {visible: false},
                title: {text: '일', horizontalAlignment: 'right'}
            },
            valueAxis: {
                visible: false,
                title: {text: '발생건수'}
            },
            seriesGroups: [
                {
                    type: 'line',
                    series: [
                        {dataField: 'count', displayText: '발생건수', symbolType: 'circle', lineColor: '#abcef4'}
                    ]
                }
            ]
        };

        $('#srmDayState').jqxChart(dayChartSettings);

        //월별 발생현황
        var monthChartSettings = {
            title: "",
            description: "",
            borderLineWidth: 0,
            enableAnimations: true,
            showLegend: false,
            padding: {left: 10, top: 5, right: 10, bottom: 5},
            titlePadding: {left: 0, top: 0, right: 0, bottom: 10},
            source: monthCounts,
            xAxis: {
                dataField: 'month',
                gridLines: {visible: false},
                title: {text: '월', horizontalAlignment: 'right'}
            },
            valueAxis: {
                visible: false,
                title: {text: '발생건수'}
            },
            seriesGroups: [
                {
                    type: 'line',
                    series: [
                        {dataField: 'count', displayText: '발생건수', symbolType: 'circle', lineColor: '#43baa6'}
                    ]
                }
            ]
        };

        $('#srmMonthState').jqxChart(monthChartSettings);

    }
})(ssd);

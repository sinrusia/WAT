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
    ssd.LevelStateList = function ($scope, $element) {

        /**
         *
         */
        $scope.updateData = function (resData, source, element) {
            angular.forEach(resData, function (data) {
                if (data.state > 0) {
                    data.state_class = 'stat-success';
                } else if (data.state < 0) {
                    data.state_class = 'stat-important';
                } else {
                    data.state_class = '';
                }
                data.state = Math.abs(data.state);
            })
        }

        $scope.$on('ngRepeatFinished', function(event) {
            console.log('ngRepeatFinished');

            console.log(event);
            //you also get the actual event object
            //do stuff, execute functions -- whatever...
        });

        var size = 80, sz;
        var data = [];
        data.push({text: 'Used', value: size}); // current
        data.push({text: 'Available', value: (100 - size)}); // remaining

        var settings = {
            title: '',
            description: '',
            enableAnimations: true,
            showLegend: false,
            showBorderLine: false,
            backgroundColor: null,
            padding: {left: 5, top: 0, right: 5, bottom: 5},
            titlePadding: {left: 5, top: 0, right: 5, bottom: 5},
            source: data,
            showToolTips: true,
            seriesGroups: [
                {
                    type: 'donut',
                    useGradientColors: false,
                    series: [
                        {
                            showLabels: false,
                            enableSelection: true,
                            displayText: 'text',
                            dataField: 'value',
                            labelRadius: 120,
                            initialAngle: 90,
                            radius: 30,
                            innerRadius: 25,
                            centerOffset: 0
                        }
                    ]
                }
            ]
        };

        var valueText = size;

        settings.drawBefore = function (renderer, rect) {
            sz = renderer.measureText(valueText + "%", 0, {'class': 'chart-inner-text'});
            renderer.text(
                valueText + "%",
                rect.x + (rect.width - sz.width) / 2,
                rect.y + rect.height / 2 - 10,
                0,
                0,
                0,
                {'class': 'chart-inner-text'}
            );
        }

        //$($element).find('.donut-chart').jqxChart(settings);
        //$($element).find('.donut-chart').jqxChart('addColorScheme', 'customColorScheme', ['#00BAFF', '#EDE6E7']);
        //$($element).find('.donut-chart').jqxChart({colorScheme: 'customColorScheme'});


    }




})(ssd);
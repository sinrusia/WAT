/**
 * Created by gojaehag on 2015. 10. 15..
 */

(function(ssd){

    ssd.AccountBudgetStatus = function($scope) {
        var barColor;
        var rate = $scope.rate;
        if (rate > 90) barColor = '#00FF00';
        else if (rate > 85) barColor = '#00FFFF';
        else if (rate > 80) barColor = '#FFFF00';
        else  barColor = '#FF0000';

        var trackColor = barColor == 'rgba(255,255,255,0.95)' ? 'rgba(255,255,255,0.25)' : 'rgb(32, 31, 36)';

        $scope.piechartOption = {
            animate: {
                duration: 0,
                enabled: false
            },
            barColor: barColor,
            trackColor: trackColor,
            scaleColor: false,
            lineWidth: 10,
            lineCap: 'butt',
            size: 50
        }

        $scope.sparklineOption = {'height': 45,'barWidth': 20,'barSpacing': 10,'barColor': '#C0FFC0'};
    }
})(ssd)
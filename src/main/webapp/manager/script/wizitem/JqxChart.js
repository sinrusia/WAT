/**
 * Created by gojaehag on 2015. 10. 9..
 */
/**
 *
 */
(function (ssd) {
    /**
     *
     * @param $scope
     */
    ssd.JqxChart = function ($scope, $element) {

        if($scope.config.height) {
            $element.find('.jqx-chart').css('height', $scope.config.height);
        }

        $element.find('.jqx-chart').jqxChart($scope.config.settings);

        $scope.updateData = function (resData, source, element) {
            $(element).find('.jqx-chart').jqxChart({source: resData});
            $(element).find('.jqx-chart').jqxChart('refresh');
        }

    }
})(ssd);



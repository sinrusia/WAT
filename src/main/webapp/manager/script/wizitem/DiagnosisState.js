/**
 * Created by gojaehag on 2015. 11. 17..
 */
/**
 *
 */
(function (ssd) {
    /**
     *
     * @param $scope
     */
    ssd.DiagnosisState = function ($scope) {

        $scope.badCount = 0;
        $scope.normalCount = 0;
        $scope.nullCount = 0;
        $scope.procCount = 0;
        $scope.endCount = 0;
        $scope.procRate = 0;


        $scope.updateData = function (resData, source, element) {

            $('#'+$scope.component.parent).find('.panel-title').text('IT취약점 진단 현황('+resData.year+'년)');
        }

    }
})(ssd);
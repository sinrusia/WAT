/**
 * Created by gojaehag on 2015. 11. 12..
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
    ssd.JQXDataTable = function ($scope, $element) {
        var id = $scope.component.id;

        $element.find('.datatable').jqxDataTable($scope.config.settings);


        /**
         *
         */
        $scope.updateData = function (resData, source, element) {
            source.localData = resData;
            var dataAdapter = new $.jqx.dataAdapter(source);

            element.find('.datatable').jqxDataTable({source: dataAdapter});
            //element.find('.datatable').jqxDataTable('refresh');
        }
    }
})(ssd);



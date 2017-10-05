/**
 * Created by gojaehag on 2015. 11. 17..
 */

(function (ssd) {

    /**
     * ssd에 확장 모듈을 정의한다
     * @param $scope
     * @constructor
     */
    ssd.MaintenanceStateList = function ($scope) {

        var styleList = $scope.config.styleList;

        updateDataProvider();

        /**
         *
         */
        $scope.updateData = function (resData, source, element) {
            updateDataProvider();
        }

        $scope.setColor = function (data) {
            return {color: data.color, background: data.bg};
        }

        function updateDataProvider() {
            if ($scope.dataProvider === undefined) {
                $scope.dataProvider = [
                    {label: '유지정비계약', count: '0', bg: '#ffffff', color: '#49617b', icon: 'fa-inbox'},
                    {label: '하차담보계약', count: '0', bg: '#8db1d5', color: '#ffffff', icon: 'fa-file'},
                    {label: '위규', count: '0', bg: '#344a62', color: '#ffffff', icon: 'fa-paperclip'},
                    {label: '장애방문', count: '0', bg: '#f86b4f', color: '#ffffff', icon: 'fa-exclamation-triangle'},
                    {label: '재계약대상', count: '0'}
                ];
            } else {

            }

            for (var i = 0; $scope.dataProvider.length > i; i++) {
                var style = getStyle(i);
                if (styleList.length > i) {
                    $scope.dataProvider[i].bg = (style != undefined ? style.bg : styleList[i].bg);
                    $scope.dataProvider[i].color = (style != undefined ? style.color : styleList[i].color);
                    $scope.dataProvider[i].icon = (style != undefined ? style.icon : styleList[i].icon);
                } else {
                    $scope.dataProvider[i].bg = '#efefef';
                    $scope.dataProvider[i].color = '#49617b';
                    $scope.dataProvider[i].icon = 'fa-asterisk';
                }
            }
        }

        function getStyle(index) {
            if ($scope.config && $scope.config.settings.items) {
                return $scope.config.settings.items[index];
            }
            return undefined;
        }

    }
})(ssd);

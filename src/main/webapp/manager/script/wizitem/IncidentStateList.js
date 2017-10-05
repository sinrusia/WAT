/**
 * Created by gojaehag on 2015. 11. 16..
 */

(function (ssd) {

    /**
     * ssd에 확장 모듈을 정의한다
     * @param $scope
     * @constructor
     */
    ssd.IncidentStateList = function ($scope) {

        var styleList = [
            {bg: '#ffffff', color: '#49617b'},
            {bg: '#f86b4f', color: '#ffffff'},
            {bg: '#344a62', color: '#ffffff'},
            {bg: '#3fbaa5', color: '#ffffff'},
            {bg: '#8db1d5', color: '#ffffff'},
            {bg: '#f1d09e', color: '#ffffff'}
        ];

        updateDataProvider();

        /**
         *
         */
        $scope.updateData = function (resData, source, element) {
            updateDataProvider();
        }
        
        $scope.setColor = function(data) {
            return {color:data.color, background:data.bg};
        }

        function updateDataProvider() {
            if ($scope.dataProvider === undefined) {
                $scope.dataProvider = [
                    {label: '전체', level: '-', count: '0', bg: '#ffffff', color: '#49617b'},
                    {label: '전체', level: '-', count: '0', bg: '#f86b4f', color: '#ffffff'},
                    {label: '전체', level: '-', count: '0', bg: '#344a62', color: '#ffffff'},
                    {label: '전체', level: '-', count: '0', bg: '#3fbaa5', color: '#ffffff'},
                    {label: '전체', level: '-', count: '0', bg: '#8db1d5', color: '#ffffff'},
                    {label: '전체', level: '-', count: '0', bg: '#f1d09e', color: '#ffffff'}
                ];
            } else {

            }

            for (var i = 0; $scope.dataProvider.length > i; i++) {
                var style = getStyle(i);
                $scope.dataProvider[i].bg = (style != undefined ? style.bg : styleList[i].bg);
                $scope.dataProvider[i].color = (style != undefined ? style.color : styleList[i].color);
            }
        }

        function getStyle(index) {
            if ($scope.config && $scope.config.settings.items) {
                return $scope.config.settings.items[index];
            }
            return undefined;
        }

    }
})(ssd)


var xxx =
{
    "settings": {
        "items": [
            {"bg": "#ffffff", "color": "#49617b"},
            {"bg": "#f86b4f", "color": "#ffffff"},
            {"bg": "#344a62", "color": "#ffffff"},
            {"bg": "#3fbaa5", "color": "#ffffff"},
            {"bg": "#8db1d5", "color": "#ffffff"},
            {"bg": "#f1d09e", "color": "#ffffff"}
        ]
    },
    "minHeight": "100px"
}
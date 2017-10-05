/**
 * Created by gojaehag on 15. 9. 18..
 */
'use strict'
var ssdApp = angular.module('ssdApp', [
    'ngRoute',
    'ssdControllers',
    'jqwidgets',
    'ssdServices',
    'ssdDirectives',
    'filterDirectives',
    'easypiechart',
    'sparkline',
    'ssdFilters'
]);

ssdApp.controller('appController', function ($scope, $http, $location, $route, $attrs, templateService) {

    var system = $attrs.ssdSystem;

    $scope.loadedConfig = false;

    loadAppConfig(system);

    var weeks = ["일", "월", "화", "수", "목", "금", "토"];

    dispTime();

    $scope.menuChange = function (id) {
        angular.forEach($scope.menus, function (menu) {
            if (menu.men_id == id) {
                menu.active = true;
            } else {
                menu.active = false;
            }
        });
    };

    function loadAppConfig(systemId) {
        // load app configuration
        // dm1: SSD5.Panes.RL
        // dm2: SSD5.SMW.RL
        //var url = '/xssd5/jsp/data/sql.data.jsp?dm1=SSD5.Panes.RL&dm2=SSD5.SMW.RL&dm3=SSD.MenuBySystemAll&'
        $http({
            method: 'GET',
            url: '/xssd5/jsp/data/sql.data.jsp',
            params: {
                dm1: 'SSD5.Panes.RL',
                dm2: 'SSD5.SMW.RL',
                dm3: 'SSD.MenuBySystemAll',
                system: systemId
            }
        }).then(
            function success(res) {
                var data = res.data;
                // 패널 처리
                var panels = data.dm1, wizitems = data.dm2, menus = data.dm3;
                angular.forEach(panels, function (item) {
                    templateService.putTemplate(item.typ_id, item);
                });

                // UIItem 처리
                angular.forEach(wizitems, function (item) {
                    templateService.putTemplate(item.typ_id, item);
                    // load wizitems script
                    // TODO: wizitem에서 스크립트 모듈을 사용하는지 여부를 확인한 후 사용한다면 스크립트 로딩
                    jQuery.getScript('/xssd5/script/wizitem/' + item.typ_name + '.js').done(
                        function (script, textStatus) {
                            //console.log('load... ' + item.typ_name);
                        }
                    ).fail(
                        function (jqxhr, settings, exception) {
                            // TODO: 스크립트 로딩 실패시 수행할 프로세스 정의
                            //console.log('fail load... ' + item.typ_name);
                        }
                    );
                });
                // 메뉴 처리
                $scope.menus = menus;

                $scope.loadedConfig = true;

                $scope.$broadcast('loadedAppConfig');
            },
            function error(res) {
                $scope.$broadcast('loadedAppConfig');
            }
        );
    }

    function dispTime() {
        var $dt_o = $('.dt');
        var $ampm_o = $('.ampm');
        var $hhmi_o = $('.hhmi');
        var $ss_o = $('.ss');

        var d = new Date();
        var yy = d.getYear();
        var mm = d.getMonth() + 1;
        var dd = d.getDate();
        var hh = d.getHours();
        var mi = d.getMinutes();
        var ss = d.getSeconds();
        var wk = weeks[d.getDay()];


        var am = 'AM';
        if (hh >= 12) {
            am = 'PM';
        }
        if (hh >= 13) {
            hh -= 12;
        }

        if (yy < 2000) {
            yy = yy - 100 + 2000;
        }
        mm = (mm < 10 ) ? "0" + mm : mm + "";
        dd = (dd < 10 ) ? "0" + dd : dd + "";
        hh = (hh < 10 ) ? "0" + hh : hh + "";
        mi = (mi < 10 ) ? "0" + mi : mi + "";
        ss = (ss < 10 ) ? "0" + ss : ss + "";

        $dt_o.html(yy + "년 " + mm + "월 " + dd + "일 " + wk + "요일");
        $ampm_o.html(am);
        $hhmi_o.html(hh + ":" + mi + ":" + ss);
        //$ss_o.html(ss);
        setTimeout(dispTime, 1000);
    }

});

/**
 *
 */
ssdApp.config(['$routeProvider', function ($routeProvider) {
    $routeProvider.when('/board/:smb_id', {
        templateUrl: '/xssd5/jsp/board.jsp',
        controller: 'boardController'
    });
}]);


var bbb = {
    "filters": {
        "id": "dbf408e8-b344-4fb4-8b89-a96d33818eb6",
        "label": "filter",
        "items": [[{
            "id": "mon",
            "alias": "기간",
            "y": 1,
            "x": 1,
            "field_lw": "60",
            "field_vw": "180",
            "uiitem": "date-ym",
            "def_val": "2015"
        }]]
    },
    "contents": {
        "id": "eff136bd-56c8-4462-bcc5-9cf63fb5baaf",
        "label": "contents",
        "layout": "bootstrap",
        "items": [{
            "id": "56afa647-74fa-437c-a3ff-b621eff38956",
            "classification": "container",
            "type": "row",
            "label": "row-container",
            "col_type": "col-md",
            "items": [{
                "id": "ed28ebc5-c058-4de2-9c36-c0e14ffdf075",
                "classification": "container",
                "type": "col",
                "label": "col-container",
                "col_type": "col-md",
                "size": 6,
                "items": [{
                    "id": "3595380a-f8c5-4288-99f2-0671508e76d8",
                    "title": "이벤트 분류별 현황(건수)",
                    "classification": "container",
                    "type": "uicomponent",
                    "label": "이벤트 분류별 현황(건수)",
                    "compType": "panel",
                    "template": "P0004",
                    "name": "",
                    "tag": "",
                    "smb_id": "SB0002",
                    "parent": "ed28ebc5-c058-4de2-9c36-c0e14ffdf075",
                    "config": "",
                    "script": "",
                    "theme": "",
                    "order": 0,
                    "used": 1,
                    "description": "",
                    "height": 0,
                    "source": "{}",
                    "background": "#ffffff",
                    "items": [],
                    "linkUrl": ""
                }],
                "background": ""
            }, {
                "id": "660d3ef1-3b6d-4455-82c5-acb7e8bf71f7",
                "classification": "container",
                "type": "col",
                "label": "col-container",
                "col_type": "col-md",
                "size": 6,
                "items": [{
                    "id": "e20cf9ed-4a54-4bde-ac60-751c02578d06",
                    "title": "서비스요청 유형별 현황(건수)",
                    "classification": "container",
                    "type": "uicomponent",
                    "label": "서비스요청 유형별 현황(건수)",
                    "compType": "panel",
                    "template": "P0004",
                    "name": "",
                    "tag": "",
                    "smb_id": "SB0002",
                    "parent": "660d3ef1-3b6d-4455-82c5-acb7e8bf71f7",
                    "config": "",
                    "script": "",
                    "theme": "",
                    "order": 0,
                    "used": 1,
                    "description": "",
                    "height": 0,
                    "source": "{}",
                    "background": "#ffffff",
                    "items": [],
                    "linkUrl": ""
                }]
            }],
            "background": ""
        }, {
            "id": "7bde2f8d-b3c9-47b1-8d2e-452811b56358",
            "classification": "container",
            "type": "row",
            "label": "row-container",
            "col_type": "col-md",
            "items": [{
                "id": "e9a0d150-26c9-49be-9a1e-ff77ff4061ff",
                "classification": "container",
                "type": "col",
                "label": "col-container",
                "col_type": "col-md",
                "size": 6,
                "items": [{
                    "id": "05cb7ef8-b084-4e50-99e3-5bb10e37f2f7",
                    "title": "월중 서비스요청 추이(건수)",
                    "classification": "container",
                    "type": "uicomponent",
                    "label": "월중 서비스요청 추이(건수)",
                    "compType": "panel",
                    "template": "P0004",
                    "name": "",
                    "tag": "",
                    "smb_id": "SB0002",
                    "parent": "e9a0d150-26c9-49be-9a1e-ff77ff4061ff",
                    "config": "",
                    "script": "",
                    "theme": "",
                    "order": 0,
                    "used": 1,
                    "description": "",
                    "height": 0,
                    "source": "{}",
                    "background": "#ffffff",
                    "items": [],
                    "linkUrl": ""
                }]
            }, {
                "id": "a08938f7-5847-4b8a-94f9-a58594e76572",
                "classification": "container",
                "type": "col",
                "label": "col-container",
                "col_type": "col-md",
                "size": 6,
                "items": [{
                    "id": "0e13289c-7162-4ac2-b11d-a0af9e4afc6d",
                    "title": "연중 서비스요청 추이(건수)",
                    "classification": "container",
                    "type": "uicomponent",
                    "label": "연중 서비스요청 추이(건수)",
                    "compType": "panel",
                    "template": "P0004",
                    "name": "",
                    "tag": "",
                    "smb_id": "SB0002",
                    "parent": "a08938f7-5847-4b8a-94f9-a58594e76572",
                    "config": "",
                    "script": "",
                    "theme": "",
                    "order": 0,
                    "used": 1,
                    "description": "",
                    "height": 0,
                    "source": "{}",
                    "background": "#ffffff",
                    "items": [],
                    "linkUrl": ""
                }]
            }],
            "background": ""
        }],
        "background": ""
    }
}
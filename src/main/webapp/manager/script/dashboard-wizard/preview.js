/**
 * Created by gojaehag on 2015. 11. 3..
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

ssdApp.controller('appController', function ($scope, $http, $location, $route, templateService, boardService) {




    $scope.$on('loadedBoardConfig', function () {
        var board = boardService.getBoard();
        if (board.theme == undefined || board.theme == '') {
            $('body').append('<link href="/xssd5/css/dark/jqx.base.css" rel="stylesheet">');
            $('body').append('<link href="/xssd5/css/dark/ssd.css" rel="stylesheet">');
            $('body').append('<link href="/xssd5/css/dark/style.css" rel="stylesheet">');

        } else {
            $('body').append('<link href="/xssd5/css/'+board.theme+'/jqx.base.css" rel="stylesheet">');
            $('body').append('<link href="/xssd5/css/'+board.theme+'/ssd.css" rel="stylesheet">');
            $('body').append('<link href="/xssd5/css/'+board.theme+'/style.css" rel="stylesheet">');
        }
    });

        $scope.$on('loadedAppConfig', function () {

    });

    loadAppConfig();

    function loadAppConfig() {
        // load app configuration
        // dm1: SSD5.Panes.RL
        // dm2: SSD5.SMW.RL
        //var url = '/xssd5/jsp/data/sql.data.jsp?dm1=SSD5.Panes.RL&dm2=SSD5.SMW.RL&dm3=SSD.MenuBySystemAll&'
        $http({
            method: 'GET',
            url: '/xssd5/jsp/data/sql.data.jsp',
            params: {
                dm1: 'SSD5.Panes.RL',
                dm2: 'SSD5.SMW.RL'
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

                $scope.loadedConfig = true;

                $scope.$broadcast('loadedAppConfig');
            },
            function error(res) {
                $scope.$broadcast('loadedAppConfig');
            }
        );
    }
});


/**
 *
 */
ssdApp.config(['$routeProvider', function ($routeProvider) {
    $routeProvider.when('/:smb_id', {
        templateUrl: '/xssd5/jsp/board.jsp',
        controller: 'boardController'
    });
}]);

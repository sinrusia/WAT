/**
 * Created by gojaehag on 2015. 10. 13..
 */

var filterDirectives = angular.module('filterDirectives', []);

filterDirectives.directive('dateYm', function (boardService) {

    var controller = function ($scope, $attrs) {
        var years = [], id = $attrs.id;
        $scope.months = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
        $scope.select = {year: '', month: ''};
        $scope.filter = boardService.getWizItem(id);

        var def_val = $scope.filter.def_val;

        if(def_val) {
            $scope.select.year = parseInt(def_val.substring(0, 4));
            if(def_val.length >= 6) {
                $scope.select.month = parseInt(def_val.substring(4, 6));
            }
        } else {
            var now = new Date();
            $scope.select.year = now.getFullYear();
            $scope.select.month = now.getMonth() + 1;
        }


        var now = new Date();
        var syy = 2008;
        var eyy = now.getFullYear();
        for (var i = syy; i <= eyy; i++) {
            years.push(i);
        }
        $scope.years = years;

        putFilter($scope, id);

        $scope.changeHandler = function () {
            putFilter($scope, id);
        }
    };

    var linker = function ($scope, $attrs) {
        // configurat select option item
    };

    function putFilter($scope, id) {
        $scope.$parent.filter[id] = $scope.select.year + '' + ($scope.select.month < 10 ? '0' + $scope.select.month : $scope.select.month);
    }

    return {
        restrict: 'E',
        controller: controller,
        link: linker,
        replace: true,
        scope: true,
        templateUrl: '/xssd5/jsp/filter/Date.YM.jsp'
    }
});

filterDirectives.directive('dateYy', function (boardService) {

    var controller = function ($scope, $attrs) {
        var years = [], id = $attrs.id;
        $scope.select = {year: ''};
        $scope.filter = boardService.getWizItem(id);

        var def_val = $scope.filter.def_val;

        if(def_val) {
            $scope.select.year = parseInt(def_val.substring(0, 4));
        } else {
            var now = new Date();
            $scope.select.year = now.getFullYear();
        }


        var now = new Date();
        var syy = 2008;
        var eyy = now.getFullYear();
        for (var i = syy; i <= eyy; i++) {
            years.push(i);
        }
        $scope.years = years;

        putFilter($scope, id);

        $scope.changeHandler = function () {
            putFilter($scope, id);
        }
    };

    var linker = function ($scope, $attrs) {
        // configurat select option item
    };

    function putFilter($scope, id) {
        $scope.$parent.filter[id] = $scope.select.year;
    }

    return {
        restrict: 'E',
        controller: controller,
        link: linker,
        replace: true,
        scope: true,
        templateUrl: '/xssd5/jsp/filter/Date.YY.jsp'
    }
});

/**
 * Created by gojaehag on 2015. 11. 10..
 */
var wizPropertyDirective = angular.module('wizPropertyDirective', []);

wizPropertyDirective.directive('wizProperty', function ($compile) {

    function controller($scope) {
    }

    function linker(scope, element, attributes) {
        if (scope.property) {
            scope.property.control;
            scope.property.dataType;
            scope.property.editable;
            scope.property.groupName;
            scope.property.name;
        }
        scope.templateUrl = '/xssd5/jsp/dashboard-wizard/property/' + scope.property.control + '.jsp';

        if (scope.property.name === 'col_type') {
            scope.codes = [
                {id: 'col-lg', label: 'col-lg'},
                {id: 'col-md', label: 'col-md'},
                {id: 'col-sm', label: 'col-sm'},
                {id: 'col-xs', label: 'col-xs'}
            ];
        } else if (scope.property.name === 'filterused') {
            scope.codes = [
                {id: 'use', label: '사용', value:'1'},
                {id: 'notuse', label: '미사용', value:'0'}
            ];
        } else if (scope.property.name === 'theme') {
            scope.codes = [
                {id: 'dark', label: 'dark', value:'dark'},
                {id: 'white', label: 'white', value:'white'},
                {id: 'lightskyblue', label: 'lightskyblue', value:'lightskyblue'},
                {id: 'redrose', label: 'redrose', value:'redrose'},
            ];
        }

        scope.changeValue = function () {
            scope.$parent.updateProperty(scope.property.name, scope.property.value);
        };

        scope.propertyConfig = function () {
            scope.$emit('sourceProperty', scope.property);
        }

    }

    return {
        restrict: 'E',
        template: '<div ng-include="templateUrl"></div>',
        controller: controller,
        link: linker,
        replace: true
    };
})
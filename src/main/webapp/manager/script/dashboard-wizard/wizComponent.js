/**
 * Created by gojaehag on 2015. 11. 4..
 */

var wizComponentDirective = angular.module('wizComponentDirective', []);

wizComponentDirective.directive('wizComponent', function () {

    var linker = function(scope, elem, attrs) {

        scope.component = scope.$parent.getComponent(attrs.id);

        scope.overHandler = function (event) {
            var mainParent = getMainParent(event.target);

            if (mainParent == event.currentTarget) {
                $('.ui-component.over').each(function (index) {
                    $(this).removeClass('over');
                });
                $(mainParent).addClass('over');
            }
        };

        scope.selectHandler = function (event) {
            var mainParent = getMainParent(event.target);

            if (mainParent == event.currentTarget) {
                $('.ui-component.select').each(function (index) {
                    $(this).removeClass('select');
                });

                $(mainParent).addClass('select');

                $('.control-button-group.show').each(function (index) {
                    $(this).removeClass('show');
                })

                $(mainParent).children('.control-button-group').each(function () {
                    if ($(this).parents().eq(0)[0].id == mainParent.id) {
                        $(this).addClass('show');
                    }
                });

                scope.$emit('selectComponent', scope.component);

            }

            //$('#jqxTree').jqxTree('selectItem', scope.component);

        };

        scope.delete = function () {
            //scope.$emit('deleteComponent', scope.component);
            scope.$parent.removeChild(scope.component);
            $(elem).remove();
            scope.$destroy();
        }

        function getMainParent(elem) {
            if ($(elem).hasClass('ui-component')) {
            } else {
                elem = getMainParent(elem.parentElement);
            }
            return elem;
        }

    }

    return {
        restrict: 'E',
        templateUrl: '/xssd5/jsp/wizard/WizComponent.jsp',
        link: linker,
        scope: {
            component: '=component'
        },
        replace: true
    };
});

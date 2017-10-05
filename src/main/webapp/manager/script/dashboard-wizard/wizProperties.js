/**
 * Created by gojaehag on 2015. 11. 4..
 */
var wizPropertiesDirective = angular.module('wizPropertiesDirective', []);

wizPropertiesDirective.directive('wizProperties', function () {
    var linker = function (scope, element, attributes) {

        scope.properties = [];

        scope.$watch(attributes.selectedComponent, function handler(newValue, oldValue) {
            changeComponentHandler(newValue);
        });

        scope.updateProperty = function (key, value) {
            scope.selectedComponent[key] = value;
            scope.$emit('', scope.selectedComponent);

            scope.$emit('updateBoard', scope.selectedComponent, 'update', key, value);
        }

        scope.$parent.$parent.updateProperties = function (component) {
            scope.selectedComponent = component;
            changeComponentHandler(component);
        }

        function changeComponentHandler(component) {
            var propMap = {};
            scope.properties = [];
            expandProperties(component);

            function expandProperties(object) {
                var propList, property;
                if (object) {

                    // 속성이 확장된경우 여기에 추가 정의를 하여 속성을 자동으로 추가하도록 한다.
                    if (!object.hasOwnProperty('background')) {
                        object.background = '';
                    }

                    if(object.compType === 'panel') {
                        if (!object.hasOwnProperty('linkUrl')) {
                            object.linkUrl = '';
                        }
                    }

                    for (var key in object) {
                        if (isValid(key)) {


                            property = divideProperty(key);
                            if (!propMap[property.groupName]) {
                                var propertyGroup = {label: property.groupName, name: property.groupName};
                                propertyGroup.items = propMap[property.groupName] = [];
                                scope.properties.push(propertyGroup);
                            }
                            propList = propMap[property.groupName];

                            if (typeof object[key] === 'object') {
                                expandProperties(object[key]);
                            } else {
                                property.name = key;
                                property.value = object[key];
                                propList.push(property);
                            }
                        }
                    }
                }
            }
        }

        /**
         *
         * @param key
         * @returns {string}
         */
        function divideProperty(key) {
            /**
             *
             * type: string, number,
             * control: text, radio, list, select, checkbox
             * @type {{groupName: string, dataType: string, control: string, editable: boolean, label: string}}
             */
            var property = {groupName: '', dataType: '', control: '', editable: false, label: key};

            if (key === 'height') {
                property.groupName = 'layout';
                property.dataType = 'number';
                property.control = 'InputText';
            } else if (key === 'col_type') {
                property.groupName = 'layout';
                property.dataType = 'string';
                property.control = 'CodeSelect';
            } else if (key === 'source') {
                property.groupName = 'default';
                property.dataType = 'string';
                property.control = 'WindowButton';
                property.label = "데이터";
            } else if (key === 'config') {
                property.groupName = 'default';
                property.dataType = 'string';
                property.control = 'WindowButton';
                property.label = "화면구성";
            } else if (key === 'classification') {
                property.groupName = '컴포넌트';
                property.dataType = 'string';
                property.control = 'InputText';
                property.editable = true;
                property.label = "분류";
            } else if (key === 'type') {
                property.groupName = '컴포넌트';
                property.dataType = 'string';
                property.control = 'InputText';
                property.editable = true;
                property.label = "이름";
            } else if (key === 'template') {
                property.groupName = '컴포넌트';
                property.dataType = 'string';
                property.control = 'InputText';
                property.editable = true;
                property.label = "템플릿";
            } else if (key === 'description') {
                property.groupName = 'default';
                property.dataType = 'string';
                property.control = 'InputText';
                property.label = "설명";
            } else if (key === 'name') {
                property.groupName = 'default';
                property.dataType = 'string';
                property.control = 'InputText';
            } else if (key === 'id') {
                property.groupName = 'default';
                property.dataType = 'string';
                property.control = 'InputText';
                property.editable = true;
            } else if (key === 'layout') {
                property.groupName = 'default';
                property.dataType = 'string';
                property.control = 'InputText';
                property.editable = true;
            } else if (key === 'filterused') {
                property.groupName = 'default';
                property.dataType = 'boolean';
                property.control = 'CodeRadio'
                property.label = "필터";
            } else if (key === 'theme') {
                property.groupName = 'default';
                property.dataType = 'string';
                property.control = 'CodeSelect'
                property.label = "테마";
            } else {
                property.groupName = 'default';
                property.dataType = 'string';
                property.control = 'InputText';
            }

            return property;
        }

        function isValid(key) {
            if (key === 'items' ||
                key === 'parent' ||
                key === 'data' ||
                key === 'records' ||
                key === 'used' ||
                key === 'order' ||
                key === 'smb_id' ||
                key === 'expanded' ||
                key === 'leaf' ||
                key === 'uid'
            ) {
                return false;
            }
            return true;
        }

    };

    return {
        restrict: 'E',
        templateUrl: '/xssd5/jsp/wizard/WizProperties.jsp',
        link: linker,
        scope: {
            selectedComponent: '=selectedComponent'
        },
        replace: true
    }
});

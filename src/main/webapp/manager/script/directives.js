/**
 * Created by gojaehag on 15. 9. 18..
 */

var ssdDirectives = angular.module('ssdDirectives', []);

ssdDirectives.directive('ssdPane', function ($compile, templateService, boardService) {

    var controller = function ($scope, $element) {
        $scope.useLink = false;
    };

    /**
     * 패널 scope에 구성정보를 설정한다.
     * @param scope
     * @param element
     * @param attrs
     */
    var linker = function (scope, element, attrs) {
        var id = attrs.id;

        var pane = boardService.getPane(id);

        scope.config = pane;

        if (pane.items) {
            renderItems(pane.items, element.find('.pane-body'), scope)
        }

        // 스타일 설정
        if (pane.background) {
            $(element).css('background', pane.background);
        }

        //
        if (pane.linkUrl) {
            scope.useLink = true;
        }

        // legend 추가
        if(scope.config.config) {
            $(element).find('.panel-legend').html(scope.config.config);
        }
    };


    function renderItems(items, parent, scope) {
        angular.forEach(items, function (subItem, index) {
            renderItem(subItem, parent, index, scope);
        });
    }

    function renderItem(item, parent, index, scope) {
        //console.log('render Sub Item');
        if (item.classification == 'container') {
            renderContainer(item, parent, index, scope);
        } else if (item.classification == 'widget') {
            //renderComponent(item, parent, index, scope);
        } else {

        }
    }

    function renderContainer(item, parent, index, scope) {
        var elem;
        if (item.type == 'row') {
            var id = item.id;
            //$scope.configMap[id] = row;
            elem = $compile('<div class="row" id="' + id + '"></div>')(scope);
            $(parent).append(elem);

            if (item.items) {
                renderItems(item.items, elem, scope);
            }

        } else if (item.type == 'col') {
            var id = item.id;
            var gridOpt = item.col_type + '-' + item.size;
            elem = $compile('<div id="' + id + '" class="' + gridOpt + '"></div>')(scope);
            $(parent).append(elem);

            if (item.items) {
                renderItems(item.items, elem, scope);
            }

        } else if (item.type == 'panel') {
            renderPanel(item, parent, index, scope);
        }
    }

    function renderPanel(item, parent, index, scope) {
        var id = item.id;
        var tagName = 'pane-' + item.id;
        //$scope.configMap[id] = pane;

        // type null check
        if (!item.type) {
            item.type = "P0004";
        }
        var template = angular.element('<ssd-pane id="' + id + '" type="' + item.template + '"></ssd-pane>');
        var lf = $compile(template);
        lf(scope);
        $(parent).append(template);
    }


    /**
     * rows 정보를 이용하여 대시보드 열을 구성한다.
     * @param rows
     * @param parent
     */
    function renderRows(rows, parent, scope) {
        angular.forEach(rows, function (row) {
            var id = row.id;
            parent.append($compile('<div class="row" id="' + id + '"></div>')(scope));
            if (row.cols) {
                renderCols(row.cols, $('#' + id), scope);
            }
        });
    }

    function renderCols(cols, parent, scope) {
        $.each(cols, function (index, col) {
            var id = col.id;
            var gridOpt = "";
            if (col.xs) {
                gridOpt += " col-xs-" + col.xs;
            }
            if (col.sm) {
                gridOpt += " col-sm-" + col.sm;
            }
            if (col.md) {
                gridOpt += " col-md-" + col.md;
            }
            if (col.lg) {
                gridOpt += " col-lg-" + col.lg;
            }
            parent.append($compile('<div id="' + id + '" class="' + gridOpt + '"><div>')(scope));

            if (col.panes) {
                renderPanes(col.panes, $('#' + id), scope);
            }
        })
    }

    /**
     * panes 정보를 이용하여 패널(컬럼)을 구성한다.
     * @param panes
     * @param parent
     */
    function renderPanes(panes, parent, scope) {
        angular.forEach(panes, function (pane) {
            var id = pane.id;

            // type null check
            if (!pane.type) {
                pane.type = "P0001";
            }

            //var template = angular.element('<div id="'+id+'" ng-include="template.'+pane.type+'" ng-controller="panelCtrl">pane</div>');
            var template = angular.element('<ssd-pane id="' + id + '" type="' + pane.type + '"></ssd-pane>');
            var lf = $compile(template);
            lf(scope);
            parent.append(template);
        });
    }

    return {
        restrict: 'E',
        link: linker,
        controller: controller,
        scope: {
            content: '='
        },
        templateUrl: function (elem, attrs) {
            return templateService.templateUrl(attrs["type"]);
        },
        replace: true
    };

});

ssdDirectives.directive('ssdWidget', function ($http, $compile, templateService, boardService) {

    /**
     *
     * @param $scope
     * @param $attrs
     * @param $element
     */
    var controller = function ($scope, $element, $attrs) {
        // define variables
        var wizItem = boardService.getWizItem($attrs.id),
            config = jQuery.parseJSON(wizItem.config),
            witSource = jQuery.parseJSON(wizItem.source),
            moduleName = templateService.moduleName(wizItem.template);

        // define models
        $scope.component = $scope.wizItem = wizItem;
        $scope.config = config;
        $scope.value = 0;
        $scope.settings = {};
        $scope.sources = witSource.sources;

        // extend wizitem
        if (moduleName) {
            if (ssd[moduleName]) {
                var func = ssd[moduleName];
                func.call(this, $scope, $element);
            } else {
                $.getScript(templateService.moudleUrl(wizItem.wit_smw)).done(
                    function () {
                        var func = ssd[moduleName];
                        if (func) {
                            func.call(this, $scope);
                        }
                    }
                ).fail(
                    function (jqxhr, settings, exception) {
                        //console.log(jqxhr);
                        //console.log(settings);
                        //console.log(exception);
                    }
                );
            }
        }

        // update wizItem data
        fetchData();

        // wizItem settings information
        if ($scope.configureSettings) {
            // 확장된 configure 함수 호출
            $scope.configureSettings(config.settings, $scope);
        } else {
            $scope.settings = config.settings;
        }

        // updateDataMap 이벤트 핸들러
        // board scope의 dataMap이 변경되면 발생되는 이벤트
        // dataMap 데이터를 참조하지 않으면 처리를 수행하지 않는다
        // source datatype이 datamap인경우 처리를 수행한다.
        $scope.$on('upateDataMap', function (event, args) {
            if ($scope.sources) {
                angular.forEach($scope.sources, function (source) {
                    if (source) {
                        if (source.resource == 'datamap') {
                            fetchDataFromDataMap(source);
                        }
                    }

                });
            }
        });

        // search 이벤트 핸들러
        // board의 search 버튼을 클릭하면 발생하는 이벤트
        // wizItem에서 자체적으로 데이터 조회를 할경우 처리를 수행한다
        // source datatype이 webservice, sql인 경우 처리를 수행한다
        $scope.$on('search', function (event, args) {
            if ($scope.sources) {
                angular.forEach($scope.sources, function (source) {
                    if (source) {
                        if (source.resource == 'sql') {
                            fetchDataFromSQL(source);
                        } else if (source.resource == 'webservice') {
                            fetchDataFromWebService(source);
                        }
                    }
                });
            }

            /*
             dataAdapter = new $.jqx.dataAdapter({
             datatype: config.source.datatype,
             datafields: config.source.datafields,
             url: config.source.url,
             data: $.extend(args, config.source.data)
             })
             */
        });

        /**
         *
         */
        function fetchData() {
            if ($scope.sources) {
                angular.forEach($scope.sources, function (source) {
                    if (source) {
                        if (source.resource == 'datamap') {
                            fetchDataFromDataMap(source);
                        } else if (source.resource == 'sql') {
                            fetchDataFromSQL(source);
                        } else if (source.resource == 'webservice') {
                            fetchDataFromWebService(source);
                        }
                    }
                });
            }
        }

        /**
         *
         * @param source
         */
        function fetchDataFromDataMap(source) {
            var data;
            if ($scope.$parent.dataMap && $scope.$parent.dataMap[source.damid]) {
                data = $scope.$parent.dataMap[source.damid];
                injectData(data, source);
            }
        }

        /**
         *
         * @param source
         */
        function fetchDataFromSQL(source) {
            var params, url, data;

            if (source.datatype == 'object') {
                url = '/xssd5/jsp/data/QueryForObject.jsp';
            } else {
                url = '/xssd5/jsp/data/QueryForList.jsp';
            }
            params = {sql_id: source.sqlid};
            jQuery.extend(params, $scope.$parent.filter);
            $http({
                method: 'GET',
                url: url,
                params: params
            }).then(function success(res) {
                data = res.data;
                injectData(data, source);
            }, function error(res) {

            });

        }

        function fetchDataFromWebService(source) {
            var params = source.params, data;
            jQuery.extend(params, $scope.$parent.filter);
            $http({
                method: 'GET',
                url: url,
                params: params
            }).then(function success(res) {
                data = res.data;
                injectData(data, source);
            }, function error(res) {

            });

        }

        function injectData(data, source) {
            if (source.datatype == 'object') {
                // resDatar가 array이면 data의 값을 0번째 결과로 바꾼다
                if (angular.isArray(data)) {
                    data = data[0];
                }
                var fields = source.datafields;
                angular.forEach(fields, function (field) {
                    var key = field.field ? field.field : field.name;
                    var value = data[key];
                    $scope[field.name] = value;
                });
            } else if (source.datatype == 'array') {
                if (source.field) {
                    $scope[source.field] = data;
                } else {
                    $scope.dataProvider = data;
                }
            }

            if ($scope.updateData) {
                $scope.updateData(data, source, $element);
            }
        }

    };

    var linker = function (scope, element) {
        console.log('min-height', scope.config.minHeight);
        if (scope.config.minHeight) {
            $(element).css('min-height', scope.config.minHeight)
        }
    };

    return {
        restrict: 'E',
        link: linker,
        controller: controller,
        scope: {
            content: '='
        },
        templateUrl: function (elem, attrs) {
            return templateService.templateUrl(attrs["type"]);
        },
        replace: true
    };

});

ssdDirectives.directive('numberCount', function () {

    var linker = function (scope, element, attrs) {

        attrs.$observe('smwValue', function (value) {
            if (value) {
                valueChangeHandler(scope, element);
            }
        });
    };

    var controller = function ($scope, $element) {
        $scope.$watch($scope.value, function () {
            valueChangeHandler($scope, $element);
        });
    }

    function valueChangeHandler(scope, element) {
        var prefix, suffix, options, preval, curval, cntr, decimals, duration;

        if (scope.settings) {
            prefix = $.trim(scope.settings.prefix);
            suffix = $.trim(scope.settings.suffix);
            decimals = scope.settings.decimals;
            duration = scope.settings.duration;
        } else {
            prefix = element.attr("smw-prefix");
            suffix = element.attr("smw-suffix");
            decimals = element.attr("smw-decimals");
            duration = element.attr("smw-duration");
        }

        if (prefix === undefined) {
            prefix = ''
        }
        if (suffix === undefined) {
            suffix = ''
        }
        if (decimals === undefined) {
            decimals = 0
        }
        ;
        if (duration === undefined) {
            duration = 2
        }
        ;

        options = {
            useEasing: true,
            useGrouping: true,
            separator: ',',
            decimal: '.',
            prefix: prefix,
            suffix: suffix
        };
        preval = element.text();
        curval = scope.value;

        if (isNaN(preval)) {
            if (suffix && suffix !== '') {
                preval = preval.replace(suffix);
            }

            if (prefix && prefix !== '') {
                preval = preval.replace(prefix);
            }
        }

        if (preval === undefined || preval === '') {
            preval = 0;
        }

        cntr = new CountUp(element[0], parseFloat(preval), parseFloat(curval), decimals, duration, options);
        cntr.start();
    }


    return {
        restrict: 'E',
        template: '<span></span>',
        scope: {
            settings: '=smwSettings',
            value: '@smwValue'
        },
        link: linker,
        controller: controller,
        replace: true
    }
});

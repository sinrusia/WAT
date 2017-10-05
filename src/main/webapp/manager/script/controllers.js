/**
 * Created by gojaehag on 15. 9. 18..
 */
var ssdControllers = angular.module('ssdControllers', []);

ssdControllers.controller('boardController',
    function ($scope, $routeParams, $http, $compile, boardService) {
        var smb_id = $routeParams.smb_id, routedPage = false;
        var renderedcount = 0;
        var intervalId;

        $scope.filter = {};
        $scope.filterused = true;
        //console.log(smb_id);

        if ($scope.$parent.loadedConfig === true) {
            boardService.loadBoardConfig(smb_id);
        } else {
            routedPage = true;
        }

        $scope.$on('loadedAppConfig', function() {
            if(routedPage === true) {
                boardService.loadBoardConfig(smb_id);
            }
        });


        $scope.$on('loadedBoardConfig', function () {
            var board = boardService.getBoard(),
                contents = boardService.getContents(),
                filters = boardService.getFilters().items;


            // render board layout
            if (board) {
                // title 설정
                $scope.title = board.smb_title;

                // filter 사용여부 확인
                if(board.filterused  === '1') {
                    $scope.filterused = true;
                    // render board filter
                    if (filters) {
                        for (var i = 0; i < filters.length; i++) {
                            var filter = filters[i],
                                id = filter.id,
                                alias = filter.alias,
                                x = filter.x,
                                y = filter.y,
                                field_lw = filter.field_lw,
                                field_vw = filter.filed_vw,
                                uiitem = filter.uiitem,
                                def_val = filter.def_val;

                            // filter 기본값 설정
                            if (!$scope.filter) {
                                $scope.filter = {};
                            }
                            $scope.filter[id] = def_val;

                            // 1. 표준 브라우져 API를 이용하여 DOM으로 파싱
                            var template = angular.element('<' + uiitem + ' id="' + id + '" type="' + uiitem + '"></' + uiitem + '>');
                            // 2. compile 메소드를 통해서 DOM을 해석하면서 지시자(Directive)를 찾는다. link Function 리턴함.
                            var linkFunction = $compile(template);
                            // 3. 지시자별로 link()를 호출하며 지시자별 listener등록과 scope에 대한 watch를 설정한다
                            linkFunction($scope);
                            $('.filter').append(template);
                        }
                    }
                } else {
                    $scope.filterused = false;
                }

                // 데이터맵 조회
                fetchDataMap();

                if (contents) {
                    renderBoard(contents);
                    boardService.loadUIItems(smb_id);
                }
            }
        });

        $scope.$on('loadedUIItems', function () {
            var widgets = boardService.getWizItems();
            if (widgets) {
                angular.forEach(widgets, function (widget) {
                    var id = widget.id;
                    var widgetTemplate = angular.element('<ssd-widget id="' + id + '" type="' + widget.template + '"></ssd-widget>');
                    var lf = $compile(widgetTemplate);
                    lf($scope);
                    $('#cbox-' + widget.parent).html(widgetTemplate);
                });
            }

            // 데이터조회 주기 시작

            intervalId = setInterval(fetchDataMap, 60000);
        });

        /*
         템플릿 컨텐츠가 로드 되었을때 처리
         */
        $scope.$on('$includeContentLoaded', function (event) {
            renderedcount++;
            if (renderedcount == 4) {
                // Crappy hack!
                $('.removeparent').unwrap();
                $('.removeparent').removeClass('removeparent');
            }
        });

        $scope.$on('$destroy', function resetBoard() {
            clearInterval(intervalId);
        })

        $scope.search = function () {
            //console.log($scope.filter);
            //$scope.$broadcast('search', $scope.filter);
            fetchDataMap();
        }

        function fetchDataMap() {
            var params = {smb_id: smb_id};
            jQuery.extend(params, $scope.filter);
            $http({
                url: '/xssd5/jsp/data/datamap.data.jsp',
                params: params
            }).then(
                function success(res) {
                    var dataMap = res.data;
                    for (var id in dataMap) {
                        //console.log(id, dataMap);
                    }
                    $scope.dataMap = dataMap;
                    $scope.$broadcast('upateDataMap');
                },
                function error(res) {
                    // TODO: 데이터 조회 실패 시 수행할 프로세스
                }
            );
        }

        function renderBoard(contents) {
            if (contents.layout == 'bootstrap') {
                if (contents.items) {
                    renderItems(contents.items, angular.element('#layout'));
                }
            }
        }

        function renderItems(items, parent) {
            angular.forEach(items, function (subItem, index) {
                renderItem(subItem, parent, index);
            });
        }

        function renderItem(item, parent, index) {
            //console.log('renderItem');
            //console.log(item);
            if (item.classification == 'container') {
                renderContainer(item, parent, index);
            } else if (item.classification == 'widget') {
                renderComponent(item, parent, index);
            } else {

            }
        }

        function renderContainer(item, parent, index) {
            var elem;
            if (item.type == 'row') {
                var id = item.id;
                //$scope.configMap[id] = row;
                elem = $compile('<div class="row" id="' + id + '"></div>')($scope);
                $(parent).append(elem);

                if (item.items) {
                    renderItems(item.items, elem);
                }

            } else if (item.type == 'col') {
                var id = item.id;
                var gridOpt = item.col_type + '-' + item.size;
                elem = $compile('<div id="' + id + '" class="' + gridOpt + '"></div>')($scope);
                $(parent).append(elem);

                if (item.items) {
                    renderItems(item.items, elem);
                }

            } else if (item.type == 'panel') {
                renderPanel(item, parent, index);
            } else if (item.compType == 'panel') {
                renderPanel(item, parent, index);
            }
        }

        function renderPanel(item, parent, index) {
            var id = item.id;
            var tagName = 'pane-' + item.id;
            //$scope.configMap[id] = pane;

            // type null check
            if (!item.type) {
                item.type = "P0004";
            }
            var template = angular.element('<ssd-pane id="' + id + '" type="' + item.template + '"></ssd-pane>');
            var lf = $compile(template);
            lf($scope);
            $(parent).append(template);
        }

        /**
         * rows 정보를 이용하여 대시보드 열을 구성한다.
         * @param rows
         * @param parent
         */
        function renderRow(rows, parentId) {
            angular.forEach(rows, function (row) {
                var id = row.id;
                //$scope.configMap[id] = row;
                $('#' + parentId).append($compile('<div class="row" id="' + id + '"></div>')($scope));
                if (row.cols) {
                    renderCol(row.cols, id);
                }
            });
        }

        function renderCol(cols, parentId) {
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
                $('#' + parentId).append($compile('<div id="' + id + '" class="' + gridOpt + '"></div>')($scope));

                if (col.panes) {
                    renderPanes(col.panes, id);
                }

            })
        }

        /**
         * panes 정보를 이용하여 패널(컬럼)을 구성한다.
         * @param panes
         * @param parent
         */
        function renderPanes(panes, parentId) {
            angular.forEach(panes, function (pane) {
                var id = pane.id;
                var tagName = 'pane-' + pane.id;
                //$scope.configMap[id] = pane;

                // type null check
                if (!pane.type) {
                    pane.type = "P0004";
                }
                var template = angular.element('<ssd-pane id="' + id + '" type="' + pane.type + '"></ssd-pane>');
                var lf = $compile(template);
                lf($scope);
                $('#' + parentId).append(template);
            });
        }
    }
);

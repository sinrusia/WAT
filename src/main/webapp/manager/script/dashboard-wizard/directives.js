/**
 * Created by gojaehag on 2015. 10. 26..
 */

var dwDirectives = angular.module('dwDirecives', []);

dwDirectives.directive('smbId', function (appService) {
    return function (scope, elem, attrs) {
        appService.setSmbId(attrs.smbId);
        scope.$emit('changeSmb', attrs.smbId);
    };
});

dwDirectives.directive('wizLayout', function () {

    return {
        restrict: 'E',
        templateUrl: function (elem, attr) {
            return '/xssd5/jsp/wizard/WizLayout.jsp'
        },
        scope: {
            component: '=component'
        },
        replace: true
    };
});

dwDirectives.directive('wizContainer', function ($compile) {

    var linker = function (scope, elem, attrs) {

        scope.component = scope.$parent.getComponent(attrs.id);

        if (scope.component) {

            if (scope.component.type == 'row') {
                elem.addClass('row');
            } else if (scope.component.type == 'col') {
                elem.addClass(scope.component.col_type + '-' + scope.component.size);
            } else if (scope.component.col_type) {
                elem.addClass(scope.component.col_type + '-' + scope.component.size);
            }

            renderChildren();
        }

        function renderChildren() {
            var parent;
            scope.items = scope.component.items;
            parent = elem.find('.container-main:first');
            if (scope.component.items && scope.component.items.length > 0) {
                $(parent).children('.drop-zone').remove();
                angular.forEach(scope.component.items, function (item, index) {
                    if (elem.find('#' + item.id).length == 0) {
                        renderItem(scope, item, parent, index);
                    } else {
                        scope.$broadcast('updateChildComponents', item);
                    }
                });
            } else {
                parent.html('<div class="drop-zone" style=""></div>');
                if($('.jqx-listitem-element').length > 0) {
                    $('.jqx-listitem-element').jqxDragDrop({dropTarget: $('.drop-zone'), revert: true, appendTo: 'body'});
                }
            }
        }

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

        scope.addColumn = function () {
            var id = $.generateUUID(), item;
            if (scope.component.items == undefined || !angular.isArray(scope.component.items)) {
                scope.component.items = [];
            }

            item = {
                "id": id,
                "classification": "container",
                "type": "col",
                "label": "col-container",
                "col_type": "col-md",
                "size": 3,
                "items": []
            }

            var index = scope.component.items.push(item) - 1;

            // update column size
            var defaultSize = 0, lastSize = 0, sumSize = 0;
            defaultSize = parseInt(12 / scope.component.items.length);
            lastSize = 12 % scope.component.items.length;

            for (var i = 0; i < scope.component.items.length;) {
                var ci = scope.component.items[i];
                i++;
                if (i < scope.component.items.length) {
                    ci.size = defaultSize;
                } else {
                    ci.size = defaultSize + lastSize;
                }
            }

            //scope.$broadcast('updateChildComponents');

            renderChildren();
            //renderItem(scope, item,  elem.find('.container-main')[0], index);

            // update tree
            //var elementByID = $('#jqxTree').find("#" + scope.component.id)[0];
            //$('#jqxTree').jqxTree('addTo', item, elementByID);

            scope.$emit('updateBoard', item, 'add');
        }

        scope.addRow = function () {
            var id = $.generateUUID(), item;
            if (scope.component.items == undefined || !angular.isArray(scope.component.items)) {
                scope.component.items = [];

            }

            item = {
                "id": id,
                "classification": "container",
                "type": "row",
                "label": "row-container",
                "col_type": "col-md",
                "items": []
            };

            var index = scope.component.items.push(item) - 1;

            renderChildren();
            //renderItem(scope, item,  elem.find('.container-main')[0], index);

            // update tree
            //var elementByID = $('#jqxTree').find("#" + scope.component.id)[0];
            //$('#jqxTree').jqxTree('addTo', item, elementByID);

            scope.$emit('updateBoard', item, 'add');
        }

        scope.delete = function () {
            //scope.$emit('deleteComponent', scope.component);
            scope.$parent.removeChild(scope.component);
            $(elem).remove();
            scope.$destroy();

        }

        scope.getComponent = function (id) {
            var component;
            if (scope.component) {
                angular.forEach(scope.component.items, function (item) {
                    if (item.id === id) {
                        component = item;
                    }
                });
            }
            return component;
        }


        scope.$on("removeComponent", function (event, id) {
            //console.log('>>>>>>>>>>>>>>>>>>>');
            //console.log('receive event - ' + scope.component);
            if (scope.component) {
                //console.log('receive event - ' + scope.component.id + ":" + id);
                if (scope.component.id == id) {
                    //elem.remove();
                    //scope.$destroy();
                }
            }
        });

        scope.$on('$destroy', function () {
            if (scope) {
                scope.$destroy();
            }
        });

        scope.$on('updateChildComponents', function (event, component) {

            if (scope.component.id === component.id) {
                var classes = elem.attr('class').split(' ');
                angular.forEach(classes, function (cls) {
                    //console.log(cls.indexOf('col-'));
                    if (cls.indexOf('col-') == 0) {
                        $(elem).removeClass(cls);
                    }
                });

                if (scope.component.type == 'col') {

                    elem.addClass(scope.component.col_type + '-' + scope.component.size);
                }
            }
        })

        scope.removeChild = function (component) {
            if (scope.component.items) {
                scope.component.items = $.grep(scope.component.items, function (item) {
                    return item.id !== component.id;
                })

                // update column size
                var defaultSize = 0, lastSize = 0, sumSize = 0;
                defaultSize = parseInt(12 / scope.component.items.length);
                lastSize = 12 % scope.component.items.length;

                for (var i = 0; i < scope.component.items.length;) {
                    var ci = scope.component.items[i];
                    i++;
                    if (i < scope.component.items.length) {
                        ci.size = defaultSize;
                    } else {
                        ci.size = defaultSize + lastSize;
                    }
                }

                renderChildren();

                // update tree
                //$('#jqxTree').jqxTree('removeItem', component);
                //$('#jqxTree').jqxTree('render');

                scope.$emit('updateBoard', component, 'delete');
            }
        };

        scope.$on('deleteComponent', function (event, component) {
            if (scope.component.items) {
                scope.component.items = $.grep(scope.component.items, function (item) {
                    return item.id !== component.id;
                });

                renderChildren();

                // update tree
                //$('#jqxTree').jqxTree('removeItem', component);
                //$('#jqxTree').jqxTree('render');

                scope.$emit('updateBoard', component, 'delete');
            }
        });

        /**
         * broadcast로 발생한 이벤트를 처리하는 함수
         * 이벤트가 여러번 발생하여 중복 처리됨
         */
        scope.$on('dropComponent', function (event, id, item) {
            if (scope.component) {
                //console.log('receive event - ' + scope.component.id + '  :  ' + scope);
                //console.log(scope);
                if (scope.component.id === id) {

                    if (scope.component.items == undefined || !angular.isArray(scope.component.items)) {
                        scope.component.items = [];
                    }

                    if ($.inArray(item, scope.component.items) !== -1) {
                        return;
                    }

                    var index = scope.component.items.push(item) - 1;

                    renderChildren();
                    //renderItem(scope, item,  elem.find('.container-main')[0], index);

                    // update tree
                    //var elementByID = $('#jqxTree').find("#" + scope.component.id)[0];
                    //$('#jqxTree').jqxTree('addTo', item, elementByID);

                    scope.$emit('updateBoard', item, 'add');
                }
            }
        })


        scope.$on('loadWidgetComponent', function(event, component){
            if(component.parent == scope.component.id) {
                if (scope.component.items == undefined || !angular.isArray(scope.component.items)) {
                    scope.component.items = [];
                }

                if ($.inArray(component, scope.component.items) !== -1) {
                    return;
                }

                //console.log('loadWidgetComponent');
                //console.log(component);

                scope.component.items.push(component);

                renderChildren();
                //renderItem(scope, item,  elem.find('.container-main')[0], index);

                // update tree
                //var elementByID = $('#jqxTree').find("#" + scope.component.id)[0];
                //$('#jqxTree').jqxTree('addTo', component, elementByID);
            }
        });


    }

    function getMainParent(elem) {
        if ($(elem).hasClass('ui-component')) {
        } else {
            elem = getMainParent(elem.parentElement);
        }
        return elem;
    }


    function renderItem(scope, item, parent, index) {

        if (item.classification == 'container') {
            renderContainer(scope, item, parent, index);
        } else if (item.classification == 'widget') {
            renderComponent(scope, item, parent, index);
        } else {

        }
    }

    function renderContainer(scope, item, parent, index) {
        var template = angular.element('<wiz-container id="' + item.id + '" component-type="' + item.type + '"></wiz-container>');
        var linkFn = $compile(template);
        var elem = linkFn(scope);
        $(parent).append(elem)
    }

    function renderComponent(scope, item, parent, index) {
        var template = angular.element('<wiz-component id="' + item.id + '" component-type="' + item.type + '"></wiz-component>');
        var linkFn = $compile(template);
        var elem = linkFn(scope);
        $(parent).append(elem)
    }

    return {
        restrict: 'E',
        link: linker,
        templateUrl: function (elem, attr) {
            var type = attr['componentType'];
            if (type == "col") {
                return '/xssd5/jsp/wizard/WizLayout.jsp'
            } else if (type == "row") {
                return '/xssd5/jsp/wizard/WizLayout.jsp'
            } else if (type == "panel") {
                return '/xssd5/jsp/wizard/WizContainer.jsp'
            }
            return '/xssd5/jsp/wizard/WizContainer.jsp'
        },
        scope: {},
        replace: true
    };
});

dwDirectives.directive('wizCanvas', function () {

    return {
        restrict: 'E',
        templateUrl: '/xssd5/jsp/canvas.jsp',
        replace: true
    }

})

dwDirectives.directive('newWindow', function () {
    return {
        restrict: 'E',
        templateUrl: '/xssd5/jsp/window/NewDashboard.jsp',
        replace: true,
        link: function (scope, elem) {

            $(elem).jqxWindow({
                resizable: true,
                width: 500,
                height: 400,
                minWidth: 300,
                minHeight: 300,
                isModal: true,
                initContent: function () {
                    $(elem).find('#ok').jqxButton({width: '65px'});
                    $(elem).find('#cancel').jqxButton({width: '65px'});
                }
            });

            $(elem).jqxWindow('focus');

            $(elem).find('#ok').on('click', function () {
                // 저장 수행
                var dashboardName = $.trim($(elem).find('#dashboardName').val());
                var dashboardType = $('img.active').attr('type');
                if (dashboardType === undefined) {
                    alert('생성할 대시보드 타입을 선택하여 주십시오.');
                    return false;
                }

                if (dashboardName === undefined || dashboardName === '') {
                    alert('대시보드 이름을 입력하여 주십시오.')
                    $('#dashboardName').focus();
                    return false;
                }

                scope.$emit('generateDashboard', dashboardType, dashboardName);
                $(elem).jqxWindow('close');

                // reset
                $('img.active').each(function () {
                    $(this).removeClass('active');
                })

                $(elem).find('#dashboardName').val('');
            });

            $(elem).find('#cancel').on('click', function () {
                // reset
                $('img.active').each(function () {
                    $(this).removeClass('active');
                })

                $(elem).find('#dashboardName').val('');

                $(elem).jqxWindow('close');
            });


            $(elem).on('close', function (event) {
                if (event.type === 'close') {
                    // reset
                    $('img.active').each(function () {
                        $(this).removeClass('active');
                    })

                    $(elem).find('#dashboardName').val('');
                }
            });

            scope.selectTemplate = function (event) {
                $('img.active').each(function () {
                    $(this).removeClass('active');
                })

                $(event.currentTarget).find('img').addClass('active');
            }
        }
    }
});

dwDirectives.directive('openDashboard', function () {
    return {
        restrict: 'E',
        templateUrl: '/xssd5/jsp/window/OpenDashboard.jsp',
        replace: true,
        link: function (scope, elem) {
            $(elem).jqxWindow({
                resizable: true,
                width: 600,
                height: 430,
                minWidth: 300,
                minHeight: 300,
                isModal: true,
                initContent: function () {
                    $(elem).find('#ok').jqxButton({width: '65px'});
                    $(elem).find('#cancel').jqxButton({width: '65px'});
                }
            });

            fetchDashboards();

            $(elem).find('#ok').on('click', function () {
                // 선택한 값이 있으면 불러오기
                var rows = $(elem).find("#openDashboardTable").jqxDataTable('getSelection');

                if(rows.length > 0) {
                    var selection = rows[0];
                    scope.$emit('changeSmb', selection.smb_id);
                    $(elem).jqxWindow('close');
                    clearDashboard();
                } else {
                    alert('불러올 대시보드를 선택하여 주십시오.');
                }

            });

            $(elem).find('#cancel').on('click', function () {
                // reset

                $(elem).jqxWindow('close');
                clearDashboard();
            });


            $(elem).on('close', function (event) {
                clearDashboard();
            });

            $(elem).on('open', function (event) {
                fetchDashboards();
            });

            function fetchDashboards() {
                var url = "/xssd5/jsp/data/QueryForList.jsp?sql_id=SSD5.SMBoards.List";
                // prepare the data
                var source =
                {
                    dataType: "json",
                    dataFields: [
                        {name: 'smb_id', type: 'string'},
                        {name: 'smb_name', type: 'string'},
                        {name: 'smb_tag', type: 'int'},
                        {name: 'smb_descr', type: 'string'},
                        {name: 'smb_theme', type: 'string'},
                        {name: 'smb_title', type: 'string'}
                    ],
                    id: 'id',
                    url: url
                };

                var dataAdapter = new $.jqx.dataAdapter(source);

                $(elem).find("#openDashboardTable").jqxDataTable({
                    width: 585,
                    pageable: true,
                    pagerButtonsCount: 10,
                    source: dataAdapter,
                    columnsResize: true,
                    selectionMode: "singleRow",
                    columns: [
                        {text: 'Name', dataField: 'smb_name', width: 150},
                        {text: 'Title', dataField: 'smb_title', width: 155},
                        {text: 'Descriiption', dataField: 'smb_descr', width: 280}
                    ]
                });


            }

            function clearDashboard() {
                $(elem).find("#openDashboardTable").jqxDataTable('goToPage', 0);
                $(elem).find("#openDashboardTable").jqxDataTable('clear');
            }
        }
    }
});

dwDirectives.directive('datamapManager', function() {
    return {
        restrict: 'E',
        templateUrl: '/xssd5/jsp/window/DataMapManager.jsp',
        replace: true,
        scope: {
            smbid: '=smbid'
        },
        link: function(scope, elem) {
            $(elem).jqxWindow({
                resizable: true,
                width: 800,
                height: 530,
                isModal: true,
                initContent: function() {
                    $(elem).find('#ok').jqxButton({width: '65px'});
                    $(elem).find('#cancel').jqxButton({width: '65px'});
                }
            });

            fetchDataMap(scope.$parent.smbId);

            $(elem).find('#ok').on('click', function () {
                // 선택한 값이 있으면 불러오기
                var rows = $(elem).find(".dataMapTable").jqxDataTable('getSelection');

                if(rows.length > 0) {
                    // 저장
                    scope.$emit('addDataMap', rows);
                    $(elem).jqxWindow('close');
                    clearDataMap();
                } else {
                    alert('추가할 DataMap을 선택하여 주십시오.');
                }

            });

            $(elem).find('#cancel').on('click', function () {
                // reset

                $(elem).jqxWindow('close');
                clearDataMap();
            });


            $(elem).on('close', function (event) {
                clearDataMap();
            });

            $(elem).on('open', function (event) {
                fetchDataMap(scope.$parent.smbId);
            });

            function fetchDataMap(smbid) {
                var url = "/xssd5/jsp/data/QueryForList.jsp?sql_id=SSD5.DataMap.Not.Include&smb_id="+smbid;
                // prepare the data
                var source =
                {
                    dataType: "json",
                    dataFields: [
                        {name: 'dam_id', type: 'string'},
                        {name: 'dam_name', type: 'string'},
                        {name: 'dam_config', type: 'int'}
                    ],
                    id: 'dam_id',
                    url: url
                };

                var dataAdapter = new $.jqx.dataAdapter(source);

                $(elem).find(".dataMapTable").jqxDataTable({
                    width: '100%',
                    height: '440',
                    pageable: false,
                    source: dataAdapter,
                    columnsResize: true,
                    selectionMode: "muntiRow",
                    columns: [
                        {text: 'ID', dataField: 'dam_id', width: 150},
                        {text: 'Name', dataField: 'dam_name', width: 155},
                        {text: 'Config', dataField: 'dam_config'}
                    ]
                });


            }

            function clearDataMap() {
                $(elem).find(".dataMapTable").jqxDataTable('goToPage', 0);
                $(elem).find(".dataMapTable").jqxDataTable('clear');
            }

        }
    }
});

dwDirectives.directive('sourceProperty', function () {
    return {
        restrict: 'E',
        templateUrl: '/xssd5/jsp/window/SourceProperty.jsp',
        replace: true,
        link: function (scope, elem) {
            $(elem).jqxWindow({
                resizable: true,
                width: 800,
                height: 530,
                minWidth: 300,
                minHeight: 300,
                isModal: true,
                initContent: function () {
                    $(elem).find('#ok').jqxButton({width: '65px'});
                    $(elem).find('#cancel').jqxButton({width: '65px'});
                }
            });

            $(elem).find('.sourceEditor').val(scope.selectedComponent[scope.property.name]);

            $(elem).find('#ok').on('click', function () {
                scope.selectedComponent[scope.property.name] = $(elem).find('.sourceEditor').val()
                scope.$emit('updateBoard', scope.selectedComponent, 'update');
                $(elem).jqxWindow('close');
            });

            $(elem).find('#cancel').on('click', function () {
                $(elem).jqxWindow('close');
            });


            $(elem).on('close', function (event) {
                //초기화
                $(elem).find('.sourceEditor').val('');
            });

            $(elem).on('open', function (event) {
                //console.log(scope.selectedComponent);
                $(elem).find('.sourceEditor').val(scope.selectedComponent[scope.property.name]);
            });
        }
    }
});
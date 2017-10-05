/**
 * Created by gojaehag on 2015. 11. 2..
 */
var wizBoardDirective = angular.module('wizBoardDirective', []);

wizBoardDirective.directive('wizBoard', function ($compile, boardService) {
    function linker(scope, element, attributes, _, transclude) {

        var cloneScope;

        var cloneElement;

        scope.$watch(attributes.wizBoard, function handler(newValue, oldValue) {
            //console.log('change wizBoard');

            if (cloneElement) {
                cloneElement.remove();
                cloneScope.$destroy();
            }

            if (newValue) {
                cloneScope = scope.$new();
                cloneElement = transclude(
                    cloneScope,
                    function injectClonedElement(clone) {
                        element.after(clone);
                    }
                );

                cloneScope.component = newValue;
                cloneScope.items = newValue.items;

                renderBoard(newValue);

                setTimeout(function () {
                    boardService.loadUIItems(scope.smbId);
                }, 500);


                /*
                var source = {
                    dataType: "json",
                    dataFields: [
                        {name: 'id', type: 'string'},
                        {name: 'label', type: 'string'},
                        {name: 'items', type: 'array'}
                    ],
                    hierarchy: {
                        root: 'items'
                    },
                    id: 'id',
                    localData: [newValue]
                };

                var dataAdapter = new $.jqx.dataAdapter(source);

                $("#uiComponentTree").jqxTreeGrid({
                    width: '100%',
                    height: '100%',
                    source: dataAdapter,
                    icons: true,
                    pageable: false,
                    showHeader: false,
                    columnsResize: true,
                    ready: function () {
                        $('#uiComponentTree').jqxTreeGrid('expandAll');
                    },
                    columns: [
                        {text: 'label', dataField: 'label', minWidth: 100, width: '100%'}
                    ]
                });
                */


                /*
                 $('#jqxTree').jqxTree({source: [newValue], width: '100%', height: '100%'});
                 $('#jqxTree').jqxTree('expandAll');
                 $('#jqxTree').on('select', function (event) {
                 var args = event.args;
                 var item = $('#jqxTree').jqxTree('getItem', args.element);
                 var elemId = item.id;

                 var selectComponent;
                 if (elemId === cloneScope.component.id) {
                 selectComponent = cloneScope.component;
                 cloneScope.$emit('selectComponent', cloneScope.component);
                 } else {
                 selectComponent = getData(elemId, cloneScope.component.items);
                 }


                 if (selectComponent) {
                 cloneScope.$emit('selectComponent', selectComponent);
                 }

                 $('.ui-component').each(function (index) {
                 $(this).removeClass('select');
                 });

                 $('#canvas').find('#' + elemId).addClass('select');


                 $('.control-button-group.show').each(function (index) {
                 $(this).removeClass('show');
                 })

                 $('#canvas').find('#' + elemId).children('.control-button-group').each(function () {
                 $(this).addClass('show');
                 });
                 });
                 */

                cloneScope.addColumn = function () {
                    var id = $.generateUUID(), item;
                    if (cloneScope.component.items == undefined || !angular.isArray(cloneScope.component.items)) {
                        cloneScope.component.items = [];
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

                    var index = cloneScope.component.items.push(item) - 1;

                    renderItem(item, angular.element('#canvas-main'), index);

                    //renderChildren();
                    //renderItem(scope, item,  elem.find('.container-main')[0], index);

                    // update tree
                    //var elementByID = $('#jqxTree').find("#" + cloneScope.component.id)[0];
                    //$('#jqxTree').jqxTree('addTo', item, elementByID);

                    cloneScope.$emit('updateBoard', item);
                };

                cloneScope.addRow = function () {
                    var id = $.generateUUID(), item;
                    if (cloneScope.component.items == undefined || !angular.isArray(cloneScope.component.items)) {
                        cloneScope.component.items = [];

                    }

                    item = {
                        "id": id,
                        "classification": "container",
                        "type": "row",
                        "label": "row-container",
                        "col_type": "col-md",
                        "items": []
                    };

                    var index = cloneScope.component.items.push(item) - 1;

                    renderItem(item, angular.element('#canvas-main'), index);

                    //renderChildren();
                    //renderItem(scope, item,  elem.find('.container-main')[0], index);

                    // update tree
                    //var elementByID = $('#jqxTree').find("#" + cloneScope.component.id)[0];
                    //$('#jqxTree').jqxTree('addTo', item, elementByID);

                    cloneScope.$emit('updateBoard', item);
                };

                cloneScope.removeChild = function (component) {
                    if (cloneScope.component.items) {
                        cloneScope.component.items = $.grep(cloneScope.component.items, function (item) {
                            return item.id !== component.id;
                        })

                        // update column size
                        var defaultSize = 0, lastSize = 0, sumSize = 0;
                        defaultSize = parseInt(12 / cloneScope.component.items.length);
                        lastSize = 12 % cloneScope.component.items.length;

                        for (var i = 0; i < cloneScope.component.items.length;) {
                            var ci = cloneScope.component.items[i];
                            i++;
                            if (i < cloneScope.component.items.length) {
                                ci.size = defaultSize;
                            } else {
                                ci.size = defaultSize + lastSize;
                            }
                        }

                        // update tree
                        //$('#jqxTree').jqxTree('removeItem', component);
                        //$('#jqxTree').jqxTree('render');

                        scope.$emit('updateBoard', component, 'delete');
                    }
                };

                $(cloneElement).on('click', function (event) {
                    if (event.target.id == cloneScope.component.id || event.target.id == 'canvas-main') {
                        var elemId = this.id;
                        var mainParent = event.currentTarget;

                        scope.$emit('selectComponent', cloneScope.component);

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

                    }
                });

            }

            function renderBoard(board) {
                if (board.layout == 'bootstrap') {
                    angular.forEach(board.items, function (subItem, index) {
                        renderItem(subItem, angular.element('#canvas-main'), index);
                    });
                }
            }

            function renderItem(item, parent, index) {
                if (item.classification == 'container') {
                    renderContainer(item, parent, index);
                } else if (item.classification == 'widget') {
                    renderComponent(item, parent, index);
                } else {

                }
            }

            function renderContainer(item, parent, index) {
                var template = angular.element('<wiz-container id="' + item.id + '" component-type="' + item.type + '"></wiz-container>');
                var linkFn = $compile(template);
                var elem = linkFn(cloneScope);
                parent.append(elem)
            }

            function renderComponent(item, parent, index) {
                var template = angular.element('<wiz-component id="' + item.id + '" component-type="' + item.type + '"></wiz-component>');
                var linkFn = $compile(template);
                var elem = linkFn(cloneScope);
                parent.append(elem)
            }

        });


        function getData(id, items) {
            for (var i = 0; i < items.length; i++) {
                var item = items[i];
                if (item.id === id) {
                    return item;
                }

                if (item.items && item.items.length > 0) {
                    var data = getData(id, item.items);
                    if (data) {
                        return data;
                    }
                }
            }
            return undefined;
        }

    }

    return {
        link: linker,
        restrict: "A",
        transclude: "element"
    }
});
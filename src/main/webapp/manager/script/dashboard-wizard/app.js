/**
 * Created by gojaehag on 2015. 10. 19..
 */

var dashboardWizardApp = angular.module('dashboardWizardApp', [
    'dwDirecives',
    'dwServices',
    'ssdServices',
    'wizBoardDirective',
    'wizComponentDirective',
    'wizPropertiesDirective',
    'wizPropertyDirective'
]);


dashboardWizardApp.controller('appController', function ($scope, $http, $compile, boardService, templateService) {

    // default model 선언
    $scope.isEdit = false;

    $scope.filterused = true;

    $scope.updateProperties;


    loadAppConfig();

    // dataMapTable setting
    $("#dataMapTable").jqxDataTable({
        altRows: true,
        sortable: true,
        width: '100%',
        height: '100%',
        columns: [
            {text: 'ID', dataField: 'dam_id', width: 80, align: 'center'},
            {text: 'Name', dataField: 'dam_name', align: 'center'}
        ]
    });


    $scope.$on('changeSmb', function (event, smbId) {
        // TODO: smbId를 이용하여 보드정보 조회
        $scope.smbId = smbId;
        boardService.loadBoardConfig(smbId);

        loadDataMap(smbId);
    });

    $scope.$on('loadedBoardConfig', function (event, smbId) {

        // 로딩한 대시보드 정보를 Application Scope의 board 모델에 주입한다.
        $scope.board = $scope.selectedComponent = boardService.getBoard();

        $scope.contents = boardService.getContents();

        // board에서 필터 사용여부를 확인하여 화면에 반영한다.
        if ($scope.board.filterused === '1') {
            $scope.filterused = true;
        } else {
            $scope.filterused = false;
        }

        // board의 정보가 신규이면 수정상태로 설정하여 저장을 수행하게 한다.
        // DB에서 불러왔을 시 수정되지 않는 상태로 설정한다.
        // updateType : n(new), o(old)
        $scope.isEdit = false;

        // UIComponent Tree 구성
        // 1. JSON Data 구성
        var treeList = [{
            id: $scope.board.id,
            label:$scope.board.name,
            items:[
                $.extend(true, {}, boardService.getFilters()),
                $.extend(true, {}, boardService.getContents())
            ]
        }];
        // 2. config Tree Grid Source
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
            localData: treeList
        };

        // 3. generate dataAdapter
        var dataAdapter = new $.jqx.dataAdapter(source);

        // 4. config jqxTreeGrid
        $("#uiComponentTree").jqxTreeGrid({
            width: '100%',
            height: '100%',
            source: dataAdapter,
            pageable: false,
            showHeader: false,
            columnsResize: true,
            ready: function () {
                $('#uiComponentTree').jqxTreeGrid('expandAll');
            },
            columns: [
                {text: 'name', dataField: 'label', minWidth: 100, width: '100%'},
            ]
        });

        $("#uiComponentTree").on('rowSelect', function (event) {
            var args = event.args;
            var key = args.key;

            var item = boardService.getItem(key);

            if (item) {
                $scope.selectedComponent = item;
            } else {
                $scope.selectedComponent = {};
            }

            if($scope.updateProperties) {
                $scope.updateProperties($scope.selectedComponent);
            }
        });

    });

    $scope.$on('updateBoard', function (event, item, act, key, value) {
        //console.log($scope.board);
        //console.log(JSON.stringify($scope.board));
        //console.log(JSON.stringify(boardService.getConfig()));

        //$('#jqxTree').jqxTree('destroy');
        //$('#jqxTree').jqxTree({source: [$scope.board], width: '100%', height: '100%'});
        //$('#jqxTree').jqxTree('expandAll');

        if (item.classification === 'widget') {
            if (act === 'add') {
                boardService.insertComponent(item);
            } else if (act === 'update') {
                boardService.updateComponent(item);
            } else if (act === 'delete') {
                boardService.deleteComponent(item);
            }
        } else {

        }

        $scope.isEdit = true;

        if (key === 'filterused') {
            if (value === '1') {
                $scope.filterused = true;
            } else {
                $scope.filterused = false;
            }
        }
    });

    $scope.$on('dropComponent', function (event, id, item) {
        // 컴포넌트 확인
        if (item.classification === 'widget') {
            boardService.insertComponent(item);
        }
    });

    $scope.$on('loadedUIItems', function (event, smbId) {
        var widgets = boardService.getWizItems();
        if (widgets) {
            angular.forEach(widgets, function (component) {
                // 컨테이너에 compoent를 추가하라고 알려준다.
                //console.log("loadedUIItems", component.id);
                $scope.$broadcast('loadWidgetComponent', component);

            });
        }
    });

    $scope.$on('generateDashboard', function (event, type, name) {
        $scope.smbId = $.generateUUID();
        boardService.generateDashboard(type, name);
    });

    $scope.$on('selectComponent', function (event, component) {
        $scope.selectedComponent = component;
    });

    $scope.$on('sourceProperty', function (event, property) {
        $scope.property = property;
        if ($('#sourceProperty').length > 0) {
            $('#sourceProperty').jqxWindow('open');
        } else {
            var element = $compile(angular.element('<source-property></source-property>'))($scope);
            $('body').append(element);
        }
    });

    $scope.$on('addDataMap', function (event, addDataMaps) {

        angular.forEach(addDataMaps, function(dataMap) {

            var mappingData = {sd_id: $.generateUUID(),
                sd_smb_id: $scope.smbId,
                sd_dam_id: dataMap.dam_id
            };

            $.extend(mappingData, dataMap, true);

            $("#dataMapTable").jqxDataTable('addRow', null, mappingData);

            boardService.insertDataMap(mappingData);
        });

        $scope.isEdit = true;
    });

    $scope.getComponent = function (id) {
        var component;
        angular.forEach($scope.contents.items, function (item) {
            if (item.id === id) {
                component = item;
            }
        });
        return component;
    }

    $scope.removeChild = function (component) {
        if ($scope.board.items) {
            $scope.board.items = $.grep($scope.board.items, function (item) {
                return item.id !== component.id;
            })

            // update column size
            var defaultSize = 0, lastSize = 0, sumSize = 0;
            defaultSize = parseInt(12 / $scope.board.items.length);
            lastSize = 12 % $scope.board.items.length;

            for (var i = 0; i < $scope.board.items.length;) {
                var ci = $scope.board.items[i];
                i++;
                if (i < $scope.board.items.length) {
                    ci.size = defaultSize;
                } else {
                    ci.size = defaultSize + lastSize;
                }
            }

            angular.forEach($scope.board.items, function (subItem, index) {
                $scope.$broadcast('updateChildComponents', subItem);
            });

            // update tree
            //$('#jqxTree').jqxTree('removeItem', component);

            //$('#jqxTree').jqxTree('render');

            $scope.$emit('updateBoard', component);
        }
    };

    $scope.addDataMap = function() {
        // 전체 데이터 맵에서 조회하여 추가한다.
        if ($('#dataMapManager').length > 0) {
            $('#dataMapManager').jqxWindow('open');
        } else {
            var element = $compile(angular.element('<datamap-manager smbid="'+$scope.smbId+'"></datamap-manager>'))($scope);
            $('body').append(element);
        }
    };

    $scope.delDataMap = function() {
        // 선택한 데이터맵을 삭제한다.
        var selection = $("#dataMapTable").jqxDataTable('getSelection');

        if (selection.length > 0) {
            for (var i = 0; i < selection.length; i++) {
                deleteProc(selection[i]);
            }

            $scope.isEdit = true;
        }

        function deleteProc(selectionItem) {
            var rows = $('#dataMapTable').jqxDataTable('getRows');
            var index = rows.indexOf(selectionItem);
            $('#dataMapTable').jqxDataTable('deleteRow', index);
            boardService.deleteDataMap(selectionItem);
        }
    };

    /*
     * toolbar 버튼 click 이벤트 핸들러 정의
     */

    $('.toolbar .button.new').on('click', function () {
        if ($scope.isEdit === true) {
            bootbox.dialog({
                message: "변경된 내용을 저장 하시겠습니까?",
                title: "저장",
                buttons: {
                    nosave: {
                        label: "저장안함",
                        className: "btn-default",
                        callback: function () {
                            newDashboard();
                        }
                    },
                    save: {
                        label: "저장",
                        className: "btn-default",
                        callback: function () {
                            // 저장 수행
                            boardService.update(function (result) {
                                if (result == 'success') {
                                    newDashboard();
                                } else {
                                    return;
                                }
                            });
                        }
                    },
                    cancel: {
                        label: "취소",
                        className: "btn-default",
                        callback: function () {

                        }
                    }
                }
            });
        } else {
            newDashboard();
        }
    });

    $('.toolbar .button.open').on('click', function () {
        if ($scope.isEdit === true) {
            bootbox.dialog({
                message: "변경된 내용을 저장 하시겠습니까?",
                title: "저장",
                buttons: {
                    nosave: {
                        label: "저장안함",
                        className: "btn-default",
                        callback: function () {
                            openDashboard();
                        }
                    },
                    save: {
                        label: "저장",
                        className: "btn-default",
                        callback: function () {
                            // 저장 수행
                            boardService.update(function (result) {
                                if (result == 'success') {
                                    openDashboard();
                                } else {
                                    return;
                                }
                            });
                        }
                    },
                    cancel: {
                        label: "취소",
                        className: "btn-default",
                        callback: function () {

                        }
                    }
                }
            });
        } else {
            openDashboard();
        }
    });

    $('.toolbar .button.save').on('click', function () {
        if ($scope.isEdit === true) {
            boardService.update(function(result){
                if (result == 'success') {
                    $scope.isEdit = false;
                }
            });
        } else {
            alert('업데이트할 정보가 없습니다');
        }
    });

    $('.toolbar .button.preview').on('click', function () {
        window.open('http://localhost:8080/xssd5/jsp/dashboard-wizard/preview.jsp#/' + $scope.smbId);
    });

    function loadAppConfig() {

        // load app configuration
        // dm1: SSD5.Panes.RL
        // dm2: SSD5.SMW.RL
        // dm3: SSD5.SMB.DataMaps
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
                var data = res.data, source = [];
                // 패널 처리
                var panels = data.dm1, wizitems = data.dm2;
                angular.forEach(panels, function (item) {
                    templateService.putTemplate(item.typ_id, item);
                    //
                    source.push(item);
                });

                // UIItem 처리
                angular.forEach(wizitems, function (item) {
                    templateService.putTemplate(item.typ_id, item);
                    //
                    source.push(item);
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

                // Create a jqxListBox
                $('#jqxList').jqxListBox({
                    allowDrag: true,
                    source: source,
                    displayMember: "typ_name",
                    valueMember: "typ_id",
                    width: '100%',
                    height: '100%',
                    renderer: function (index, label, value) {
                        return '<div style="height: 20px; float: left;">' +
                            '<img width="16" height="16" style="float: left; margin-top: 2px; margin-right: 5px;" src="../../images/numberinput.png"/>' +
                            '<span style="float: left; font-size: 13px; font-family: Verdana Arial;">' + label + '</span></div>';
                        return label;
                    }
                });

                var dropContainer;

                $('#jqxList').on('dragStart', function (event) {
                    //console.log('jqxList DragStart');
                    //console.log(event);
                });

                $('#jqxList').on('dragEnd', function (event) {
                    //console.log('jqxList DragEnd');
                    //console.log(event.args);

                    if (dropContainer) {
                        var parent = dropContainer.attr('id');
                        var tmpId = event.args.value;
                        var template = templateService.getTemplate(tmpId);

                        var item = {
                            id: $.generateUUID(),
                            title: template.typ_name,
                            classification: template.typ_cls,
                            type: template.typ_type,
                            label: template.typ_name,
                            compType: template.typ_comp_type,
                            template: template.typ_id,
                            name: '',
                            tag: '',
                            smb_id: $scope.smbId,
                            parent: parent,
                            config: '',
                            script: '',
                            theme: '',
                            order: 0,
                            used: 1,
                            description: '',
                            height: 0,
                            source: '{}',
                            background: ''
                        };

                        if (template.typ_cls !== 'container') {
                            //item.config = jQuery.parseJSON(template.typ_config);
                            item.config = template.typ_config;
                        }

                        if (template.typ_cls == 'widget') {
                            boardService.putWizItem(item.id, item);
                        }

                        $scope.$broadcast('dropComponent', parent, item);
                    }
                    dropContainer = null;
                });

                $('.jqx-listitem-element').bind('dragStart', function (event) {
                    event.data = {name: 'panel'}
                    //console.log('dragStart')
                    $(this).jqxDragDrop('data', {
                        title: "서비스수준 현황",
                        classification: "container",
                        type: "panel",
                        label: "panel",
                        template: "P0001",
                        color: "green",
                        height: 108

                    });
                });

                $('.jqx-listitem-element').bind('dropTargetEnter', function (event) {
                    dropContainer = $(event.args.target).parent().parent();
                    //console.log(dropContainer);
                    $(this).jqxDragDrop('dropAction', 'none');
                });

                $('.draggable-demo-product').bind('dropTargetLeave', function (event) {
                    dropContainer = null;
                    $(this).jqxDragDrop('dropAction', 'default');
                });


                $scope.$emit('loadedAppConfig');
            },
            function error(res) {
                $scope.$emit('loadedAppConfig');
            }
        );
    }

    function loadDataMap(smbId) {
        $http({
            method: 'GET',
            url: '/xssd5/jsp/data/QueryForList.jsp',
            params: {
                sql_id: 'SSD5.SMB.DataMaps',
                smb_id: smbId
            }
        }).then(
            function success(res) {
                var dataMaps = res.data;

                var source =
                {
                    localData: dataMaps,
                    dataType: "array",
                    dataFields: [
                        {name: 'dam_id', type: 'string'},
                        {name: 'dam_name', type: 'string'}
                    ]
                };

                var dataAdapter = new $.jqx.dataAdapter(source);

                // Data Table
                $("#dataMapTable").jqxDataTable({source: dataAdapter});

            },
            function error(res) {

            }
        )

    }
    function saveDashboard(callbackFunc) {
        if ($scope.isEdit === true) {
            var boardInfo = boardService.getBoardInfo();

            boardInfo.smb_config = JSON.stringify(boardService.getConfig());

            $http({
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                method: 'POST',
                data: $.param(boardInfo),
                url: '/xssd5/jsp/data/UpdateDashboard.jsp'
            }).then(function (response) {
                // success
                var result = response.data;
                if (result.state == 'success') {
                    $scope.isEdit = false;
                    alert('저장되었습니다.');
                    boardService.getBoardInfo().updateType = 'o';
                } else {
                    alert(data.message);
                }
                if (callbackFunc) {
                    callbackFunc(result.state);
                }
            }, function (response) {
                // failed
                //console.log(response.data);
                alert('알수없는 오류가 발생하였습니다.');
                if (callbackFunc) {
                    callbackFunc('fail');
                }
            });

            /*
             $.ajax({
             type: 'POST',
             url: '/xssd5/jsp/data/UpdateDashboard.jsp',
             data: boardInfo,
             success: function (res) {
             console.log(res.data);
             console.log('success....');
             $scope.isEdit = false;
             }
             })
             */
        } else {
            alert('업데이트할 정보가 없습니다');
        }
    }

    function newDashboard() {
        if ($('#newWindow').length > 0) {
            $('#newWindow').jqxWindow('open');
        } else {
            var element = $compile(angular.element('<new-window></new-window>'))($scope);
            $('body').append(element);
        }
    }

    function openDashboard() {
        if ($('#openDashboard').length > 0) {
            $('#openDashboard').jqxWindow('open');
        } else {
            var element = $compile(angular.element('<open-dashboard></open-dashboard>'))($scope);
            $('body').append(element);
        }
    }

});

dashboardWizardApp.controller('canvasCtrl', function ($scope) {

});

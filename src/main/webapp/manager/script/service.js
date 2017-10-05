/**
 * Created by gojaehag on 15. 9. 18..
 */
var ssdServices = angular.module('ssdServices', []);


ssdServices.factory('templateService', function () {

    var templateMap = {};

    return {
        templateUrl: function (key) {
            var template = templateMap[key], url;
            if (template) {
                if (template.typ_cls === 'container') {
                    url = '/xssd5/jsp/pane/';
                } else if (template.typ_cls === 'widget') {
                    url = '/xssd5/jsp/wizitem/';
                } else {
                    url = ''
                }
                url += template.typ_name + '.jsp';
            }
            return url;
        },
        moduleName: function (key) {
            var template = templateMap[key];
            if (template) {
                if (template.typ_module && template.typ_module != '') {
                    return template.typ_module;
                } else {
                    return template.typ_name;
                }
            }
            return undefined;
        },
        moudleUrl: function (key) {
            var template = templateMap[key], url;
            if (template) {
                if (template.typ_cls === 'container') {
                    url = '/xssd5/script/pane/';
                } else if (template.typ_cls === 'widget') {
                    url = '/xssd5/script/wizitem/';
                } else {
                    url = ''
                }
                url += template.typ_name + '.js';
            }
            return url;
        },
        getTemplate: function (key) {
            return templateMap[key];
        },
        putTemplate: function (key, url) {
            templateMap[key] = url;
        }
    };
});

ssdServices.factory('boardService', function ($rootScope, $http) {

    var boardInfo,
        config,
        paneMap = {},
        wizItems,
        wizItemMap = {},
        insertList = [],
        updateList = [],
        deleteList = [],
        widgetComponents = [],
        insertDataMaps = [],
        updateDataMaps = [],
        deleteDataMaps = [];

    var loadBoardConfig = function (smb_id) {
        $http.get('/xssd5/jsp/data/sql.data.jsp?dm1=SSD5.SMBoards.RO' + '&' + 'smb_id=' + smb_id).success(function (data) {
            var dm1 = data.dm1;
            if (angular.isArray(dm1)) {
                boardInfo = dm1[0];
            } else {
                boardInfo = dm1;
            }

            if (boardInfo == undefined) {
                smb_id = $.generateUUID();
                boardInfo = {
                    id: smb_id,
                    name: '',
                    tag: '',
                    description: '',
                    order: '',
                    used: '1',
                    theme: '',
                    script: '',
                    title: 'New Dashboard',
                    config: getNewBoard(),
                    filterused: '1',
                    updateType: 'n'
                };
            } else {
                boardInfo.updateType = 'o';
            }

            if (boardInfo) {
                config = jQuery.parseJSON(boardInfo.config);
                // check filter information
                if (config.filters) {
                    checkFilters(config.filters);
                }
                // check contents information
                if (config.contents) {
                    checkItems(config.contents.items);
                }
            }
            // 대시보드정보를 로딩하면 loadedBoardConfig이벤트를 발생한다.
            $rootScope.$broadcast('loadedBoardConfig', smb_id);
        });
    };

    var loadUIItems = function (smb_id) {
        $http.get('/xssd5/jsp/data/sql.data.jsp?dm1=SSD5.WItems.RL' + '&' + 'smb_id=' + smb_id).success(function (data) {
            wizItems = data.dm1;
            // 대시보드정보를 로딩하면 loadedBoardConfig이벤트를 발생한다.
            $rootScope.$broadcast('loadedUIItems', smb_id);
            angular.forEach(wizItems, function (wizItem) {
                wizItemMap[wizItem.id] = wizItem;
            });
        });

        insertList = [];
        updateList = [];
        deleteList = [];

        insertDataMaps = [];
        updateDataMaps = [];
        deleteDataMaps = [];
    }

    var getBoard = function () {
        return boardInfo;
    }

    var getConfig = function () {
        return config;
    }

    var getFilters = function () {
        if (config) {
            return config.filters;
        }
        return undefined;
    }

    var getContents = function () {
        if (config) {
            return config.contents;
        }
        return undefined;
    }

    var getPane = function (id) {
        return paneMap[id];
    }

    var getWizItems = function () {
        return wizItems;
    }

    var getWizItem = function (id) {
        return wizItemMap[id];
    }

    var putWizItem = function (id, item) {
        wizItemMap[id] = item;
    }

    var generateDashboard = function (type, name) {
        var smb_id = $.generateUUID();
        if (type === 'blank') {
            boardInfo = {
                id: smb_id,
                name: name,
                tag: '',
                description: '',
                order: '',
                used: '1',
                theme: '',
                script: '',
                title: name,
                config: getNewBoard(),
                filterused: '1',
                updateType: 'n'
            }
        }

        if (boardInfo) {
            config = jQuery.parseJSON(boardInfo.config);
            // check filter information
            if (config.filters) {
                checkFilters(config.filters);
            }
            // check board information
            if (config.board) {
                checkItems(config.board.items);
            }
        }
        // 대시보드정보를 로딩하면 loadedBoardConfig이벤트를 발생한다.
        $rootScope.$broadcast('loadedBoardConfig', smb_id);
    };

    function checkFilters(filters) {
        angular.forEach(filters.items, function (filter) {
            wizItemMap[filter.id] = filter;
        });
    }

    function checkItems(items) {
        angular.forEach(items, function (item) {
            paneMap[item.id] = item;
            if (item.items) {
                checkItems(item.items);
            }
        });
    }

    function updateComponent(item) {
        if (!updateList) {
            updateList = [];
        }

        if ($.inArray(item, insertList) === -1) {
            if ($.inArray(item, updateList) === -1) {
                updateList.push(item);
            }
        }
    }

    function insertComponent(item) {
        if (!insertList) {
            insertList = [];
        }

        if ($.inArray(item, insertList) === -1) {
            insertList.push(item);
            widgetComponents.push(item);
        }
    }

    function deleteComponent(item) {
        if (!deleteList) {
            deleteList = [];
        }

        if ($.inArray(item, insertList) !== -1) {
            // 신규 추가된 아이템
            insertList.slice($.inArray(item, insertList), 1);
        } else {
            //
            if ($.inArray(item, updateList) !== -1) {
                updateList.slice($.inArray(item, updateList), 1);
            }

            if ($.inArray(item, deleteList) === -1) {
                deleteList.push(item);
            }
        }

        if ($.inArray(item, widgetComponents) !== -1) {
            widgetComponents.slice($.inArray(item, widgetComponents), 1);
        }
    }

    function updateDataMap(dataMap) {

    }

    function insertDataMap(dataMap) {
        if (!insertDataMaps) {
            insertDataMaps = [];
        }

        if ($.inArray(dataMap, insertDataMaps) === -1) {
            insertDataMaps.push(dataMap);
        }
    }

    function deleteDataMap(dataMap) {
        if (!deleteDataMaps) {
            deleteDataMaps = [];
        }

        if ($.inArray(dataMap, insertDataMaps) !== -1) {
            insertDataMaps.slice($.inArray(dataMap, insertDataMaps), 1);
        } else {
            if ($.inArray(dataMap, updateDataMaps) !== -1) {
                updateDataMaps.slice($.inArray(dataMap, updateDataMaps), 1);
            }

            if ($.inArray(dataMap, deleteDataMaps) === -1) {
                deleteDataMaps.push(dataMap);
            }
        }
    }

    function update(callbackFunc) {
        // 대시보드정보 업데이트

        boardInfo.config = getConfigStr();

        var param = {
            dashboard: boardInfo,
            widgetComponents: {
                insertList: insertList,
                updateList: updateList,
                deleteList: deleteList
            },
            dataMaps: {
                insertList: insertDataMaps,
                updateList: updateDataMaps,
                deleteList: deleteDataMaps
            }
        };

        $http({
            method: 'POST',
            data: param,
            url: '/xssd5/jsp/data/UpdateDashboard.jsp'
        }).then(function (response) {
            // success
            var result = response.data;
            if (result.state == 'success') {
                //$scope.isEdit = false;
                alert('저장되었습니다.');
            } else {
                alert(result.message);
            }
            if (callbackFunc) {
                callbackFunc(result.state);
            }
            insertList = [];
            updateList = [];
            deleteList = [];

            insertDataMaps = [];
            updateDataMaps = [];
            deleteDataMaps = [];
        }, function (response) {
            // failed
            //console.log(response.data);
            alert('알수없는 오류가 발생하였습니다.');
            if (callbackFunc) {
                callbackFunc('fail');
            }
        });
    }

    function getConfigStr() {
        var newObj = {};

        $.extend(true, newObj, config);

        if (!newObj.contents) {
            newObj.contents = {};
        }

        if (newObj.contents.items) {
            newObj.contents.items = filterWidgetComponent(newObj.contents.items);
        }

        return JSON.stringify(newObj);
    }

    function getItem(id) {
        if (boardInfo.id === id) {
            return boardInfo;
        }

        if (config.filters.id === id) {
            return config.filters;
        }

        if (config.contents.id === id) {
            return config.contents;
        }

        var item = getPane(id);

        if (item === undefined) {
            item = getWizItem(id);
        }

        return item;
    }

    function filterWidgetComponent(items) {
        items = $.grep(items, function (item, i) {
            return item.classification !== 'widget';
        })

        for (var i = 0, n = items.length; i < n; i++) {
            if (items[i].items) {
                items[i].items = filterWidgetComponent(items[i].items);
            }
        }
        return items;
    }

    function getNewBoard() {
        var newBoard = {
            filters: {
                id: $.generateUUID(),
                label: 'filter',
                items: []
            },
            contents: {
                id: $.generateUUID(),
                label: 'contents',
                layout: 'bootstrap',
                items: []
            }
        };

        return JSON.stringify(newBoard);
    }


    return {
        loadBoardConfig: loadBoardConfig,
        loadUIItems: loadUIItems,
        getBoard: getBoard,
        getConfig: getConfig,
        getContents: getContents,
        getFilters: getFilters,
        getPane: getPane,
        getWizItems: getWizItems,
        getWizItem: getWizItem,
        getItem: getItem,
        putWizItem: putWizItem,
        generateDashboard: generateDashboard,
        updateComponent: updateComponent,
        insertComponent: insertComponent,
        deleteComponent: deleteComponent,
        insertDataMap: insertDataMap,
        deleteDataMap: deleteDataMap,
        update: update
    }
});

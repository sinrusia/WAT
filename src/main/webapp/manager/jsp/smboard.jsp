<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/xefc/jsp/common/import.jspf" %>
<%

    Box box = HttpUtility.getBox(request);
    com.steg.efc.Texts texts = com.steg.efc.Texts.getInstance();

    GlobalConfig gcfg = GlobalConfig.getInstance();
    String sysname = gcfg.getValue("ssd.title");
    if (!StringUtil.valid(sysname)) {
        sysname = "SSD5 | Smart Strategy Dashbaord 5";
    }

    String smb_id = box.get("smb_id");
    if (!StringUtil.valid(smb_id)) {
        out.println("ID empty.");
        return;
    }

    DataMap dm = DUtil.queryByStrings("dm1:SSD5.Panes.RL,dm2:SSD5.SMW.RL,dm3:SSD5.SMBoards.RO,dm4:SSD5.WItems.RL", box);

    RecordSet rs1 = dm.rs("dm1");
    RecordSet rs2 = dm.rs("dm2");
    RecordSet rs3 = dm.rs("dm3");
    RecordSet rs4 = dm.rs("dm4");

    String[][] paneTypes = new String[2][];
    paneTypes[0] = rs1.getValues("typ_tag");
    paneTypes[1] = rs1.getValues("typ_config");

    String[][] smws = new String[2][];
    smws[0] = rs2.getValues("typ_tag");
    smws[1] = rs2.getValues("typ_config");

    String title = "";
    String smb_config = "";
    if (rs3.next()) {
        title = rs3.get("smb_title");
        smb_config = rs3.get("smb_config");
    }

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="/xefc/images/egene_bi.ico">

    <title><%= sysname %>
    </title>

    <!-- bootstrap & fontawesome -->
    <link href="/xplugin/bootstrap/ace/assets/css/bootstrap.css" rel="stylesheet">
    <link href="/xplugin/bootstrap/ace/assets/css/font-awesome.css" rel="stylesheet">

    <!-- text fonts -->
    <link href="/xplugin/bootstrap/ace/assets/css/ace-fonts.css" rel="stylesheet">

    <!-- ace style -->
    <link href="/xplugin/bootstrap/ace/assets/css/ace.css" rel="stylesheet">

    <!--[if lte IE 9]>
    <link rel="stylesheet" href="/xplugin/bootstrap/ace/assets/css/ace-part2.css" class="ace-main-stylesheet"/>
    <![endif]-->

    <!--[if lte IE 9]>
    <link rel="stylesheet" href="/xplugin/bootstrap/ace/assets/css/ace-ie.css"/>
    <![endif]-->

    <!-- inline styles related to this page -->

    <link rel="stylesheet" href="/xplugin/jqwidgets/styles/jqx.base.css" type="text/css"/>

    <style type="text/css">
        .padding-n {
            padding-left: 5px;
            padding-right: 5px;
        }

        .padding-w {
            padding-top: 5px;
            padding-bottom: 5px;
        }

        .padding-r {
            padding-left: 5px;
            padding-right: 5px;
        }

        .sta {
            padding: 0px;
            border: 1px solid #aaaaaa;
            background-color: #ffffff;
        }
    </style>


    <!-- ace settings handler -->
    <script src="/xplugin/bootstrap/ace/assets/js/ace-extra.js"></script>

    <!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->

    <!--[if lte IE 8]>
    <script src="/xplugin/bootstrap/ace/assets/js/html5shiv.js"></script>
    <script src="/xplugin/bootstrap/ace/assets/js/respond.js"></script>
    <![endif]-->
</head>

<body>
<div class="navbar-wrapper">
</div>

<!-- Service title Area -->
<div class="container sta">
    <form id=cond name=cond method=post>

        <!-- Title -->
        <div class="col-md-4">
            <%= title %>
        </div>

        <!-- filter -->
        <div class="col-md-7" style='text-align:right;'>

            <%
                try {
                    JSONObject jo = (JSONObject) JSONValue.parse(smb_config);
                    JSONArray farr = jo.getArray("filters");
                    for (int i = 0; farr != null && i < farr.size(); i++) {
                        UIFilterItem item = new UIFilterItem((JSONObject) farr.get(i));
                        request.setAttribute("fitem", item);
                        String fui = item.uiitem;
                        if (!StringUtil.valid(fui)) {
                            fui = "String.Text.jsp";
                        }
                        fui = "/xssd5/jsp/filter/" + fui + ".jsp";

                        try { %>
            <jsp:include page="<%= fui %>" flush="true"/>
            <%
                        } catch (Exception e) {
                            Log.biz.err("Fitler :" + item.id + " error.:" + e);
                        }

                    }
                } catch (Exception e) {
                    Log.biz.err("filter:" + e + "\n");
                }

            %>

        </div>

        <!-- Button -->
        <div class="col-md-1">
            <img src=/xssd/images/btn/btn03.png>
        </div>
    </form>
</div>


<div class="container" id=layout>


</div>
<!-- container -->


<!-- basic scripts -->


<!--[if !IE]> -->
<script type="text/javascript">
    window.jQuery || document.write("<script src='/xplugin/bootstrap/ace/assets/js/jquery.js'>" + "<" + "/script>");
</script>
<!-- <![endif]-->

<!--[if IE]>
<script type="text/javascript">
    window.jQuery || document.write("<script src='/xplugin/bootstrap/ace/assets/js/jquery1x.js'>" + "<" + "/script>");
</script>
<![endif]-->

<script type="text/javascript">
    if ('ontouchstart' in document.documentElement) document.write("<script src='../assets/js/jquery.mobile.custom.js'>" + "<" + "/script>");
</script>

<script src="/xplugin/bootstrap/ace/assets/js/bootstrap.js"></script>
<!--[if lte IE 8]>
<script src="/xplugin/bootstrap/ace/assets/js/excanvas.js"></script>
<![endif]-->
<script src="/xplugin/bootstrap/ace/assets/js/jquery-ui.custom.js"></script>
<script src="/xplugin/bootstrap/ace/assets/js/jquery.ui.touch-punch.js"></script>

<script src="/xplugin/bootstrap/ace/assets/js/jquery.easypiechart.js"></script>
<script src="/xplugin/bootstrap/ace/assets/js/jquery.sparkline.js"></script>
<script src="/xplugin/bootstrap/ace/assets/js/flot/jquery.flot.js"></script>
<script src="/xplugin/bootstrap/ace/assets/js/flot/jquery.flot.pie.js"></script>
<script src="/xplugin/bootstrap/ace/assets/js/flot/jquery.flot.resize.js"></script>

<!-- ace scripts -->
<script src="/xplugin/bootstrap/ace/assets/js/ace/elements.scroller.js"></script>
<script src="/xplugin/bootstrap/ace/assets/js/ace/elements.colorpicker.js"></script>
<script src="/xplugin/bootstrap/ace/assets/js/ace/elements.fileinput.js"></script>
<script src="/xplugin/bootstrap/ace/assets/js/ace/elements.typeahead.js"></script>
<script src="/xplugin/bootstrap/ace/assets/js/ace/elements.wysiwyg.js"></script>
<script src="/xplugin/bootstrap/ace/assets/js/ace/elements.spinner.js"></script>
<script src="/xplugin/bootstrap/ace/assets/js/ace/elements.treeview.js"></script>
<script src="/xplugin/bootstrap/ace/assets/js/ace/elements.wizard.js"></script>
<script src="/xplugin/bootstrap/ace/assets/js/ace/elements.aside.js"></script>
<script src="/xplugin/bootstrap/ace/assets/js/ace/ace.js"></script>
<script src="/xplugin/bootstrap/ace/assets/js/ace/ace.ajax-content.js"></script>
<script src="/xplugin/bootstrap/ace/assets/js/ace/ace.touch-drag.js"></script>
<script src="/xplugin/bootstrap/ace/assets/js/ace/ace.sidebar.js"></script>
<script src="/xplugin/bootstrap/ace/assets/js/ace/ace.sidebar-scroll-1.js"></script>
<script src="/xplugin/bootstrap/ace/assets/js/ace/ace.submenu-hover.js"></script>
<script src="/xplugin/bootstrap/ace/assets/js/ace/ace.widget-box.js"></script>
<script src="/xplugin/bootstrap/ace/assets/js/ace/ace.settings.js"></script>
<script src="/xplugin/bootstrap/ace/assets/js/ace/ace.settings-rtl.js"></script>
<script src="/xplugin/bootstrap/ace/assets/js/ace/ace.settings-skin.js"></script>
<script src="/xplugin/bootstrap/ace/assets/js/ace/ace.widget-on-reload.js"></script>
<script src="/xplugin/bootstrap/ace/assets/js/ace/ace.searchbox-autocomplete.js"></script>


<script src="/xplugin/jqwidgets/jqx-all.js"></script>

<script type="text/javascript">

    $(document).ready(function ($) {

        //-------------------------------------------------------------------------
        // Templates Init.
        //-------------------------------------------------------------------------
        Handlebars.templates = Handlebars.templates || [];
        //-------------------------------------------------------------------------
        // Layout Init.
        //-------------------------------------------------------------------------
        var params = _getParams();
        _callAjaxJson('layout.jsp', params, function (data) {
            var rows = data.rows;
            _renderTpl('tpl-row', data, 'layout');
            _initRows(rows);
            _initWidgets();
        });

    });

    ///-----------------------------------------
    // Widgets init.
    //------------------------------------------
    _initWidgets = function () {
        <%
          rs4.reset();
          JSONArray wgt_arr = new JSONArray();
          for(int i=0; rs4.next(); i++){
            String id = rs4.get("wit_id");
            String pane = rs4.get("wit_pane");
            int height = rs4.getInt("wit_height");
            JSONObject w = new JSONObject();
            w.put("id", id);
            w.put("pane", pane);
            w.put("height", height);
            wgt_arr.add(w);
          }
        %>
        var widgets = <%= wgt_arr.toString() %>;
        for (var i = 0; i < widgets.length; i++) {
            var wgt = widgets[i];
            _renderTpl('tpl-smw', wgt, _cbox(wgt.pane));
        }

        for (var i = 0; i < widgets.length; i++) {
            var wgt = widgets[i];
            _showItem(wgt.id);
        }

    }

    function _initRows(rows, depth) {
        if (!depth) depth = 0;

        for (var i = 0; i < rows.length; i++) {
            var row = rows[i];
            var rowId = row.id;
            var panes = row.panes;

            for (var j = 0; j < panes.length; j++) {
                var pane = panes[j];
                var paneType = _atr(pane, 'type');
                if (!paneType) paneType = 'a0tt';

                _renderTpl('tpl-pane-' + paneType, pane, _cbox(rowId));

                var srows = pane.rows;
                if (srows) {
                    _renderTpl('tpl-row', pane, _cbox(pane.id));
                    _initRows(srows, ++depth);
                }
            }
        }
    }

    // Template apply
    function _renderTpl(tpl, data, target) {
        if (!Handlebars.templates[tpl]) _initTpl(tpl);
        $(Handlebars.templates[tpl](data)).appendTo($('#' + target));
    }

    // Template init
    function _initTpl(tpl) {
        Handlebars.templates[tpl] = Handlebars.compile($('#' + tpl).html());
    }

    function _cbox(id) {
        return 'cbox-' + id;
    }

    function _rowId(id) {
        return 'row-' + id;
    }

    function _pandId(id) {
        return 'pane-' + id;
    }

    function _getParams() {
        var params = {smb_id: '<%= smb_id %>'};
        return params;
    }

    function _atr(o, id) {
        try {
            return o[id];
        } catch (e) {
        }
        return '';
    }

    var _items = {};
    function _addItem(id, fn) {
        _items[id] = fn;
    }

    function _showItem(id) {
        if (_items[id]) _items[id]();
    }

    function _callAjaxJson(uri, params, fn) {
        $.ajax({
            url: uri,
            data: params,
            type: 'POST',
            async: true,
            success: function (data) {
                //try{
                //var dataSource = JSON.parse(data);
                var dataSource = jQuery.parseJSON(data);
                //var dataSource = eval(data);
                if (dataSource.isError) {
                    alert("Widget invalid.1.");
                    return;
                }

                fn(dataSource);
                /*
                 }catch(e){
                 alert("[_CallAjaxJson] " + uri + " : " +  e.description);
                 }
                 */
            }
        });
    }


    function _callAjaxData(uri, params, fn) {
        $.ajax({
            url: uri,
            data: params,
            type: 'POST',
            async: true,
            success: function (data) {
                try {

                    fn(data);

                } catch (e) {
                    alert("[_callAjaxData] " + uri + " : " + e.description);
                }

            }
        });
    }
</script>

<script src="/xplugin/handlebars/handlebars.min.js"></script>
<script id="tpl-row" type="text/x-handlebars-template">
    {{#each rows}}
    <div id="cbox-{{id}}" class="row  padding-r" {{#if height}} style='height:{{height}}px' {{/if}} >

    </div>
    {{/each}}
</script>

<script id="tpl-pane" type="text/x-handlebars-template">
    <div id="pane-{{id}}" class="col-md-{{cols.md}}" style="">
    </div>
</script>
<!--
Pane 유형

[a]tt : [a] 상단타이틀
[a]bt : [a] 하단타이틀
[a]nt : [a] 노 타이틀
 -->
<%
    //-----------------------------------------------------------------
    // PaneType Template Define
    //-----------------------------------------------------------------
    for (int i = 0; i < paneTypes[0].length; i++) {
        String pane = paneTypes[0][i];
        String pane_html = paneTypes[1][i];
        String pane_jsp = "pane/" + pane + ".jsp";
%>
<script id="tpl-pane-<%= pane %>" type="text/x-handlebars-template">
    <%
        try {
    %>
    <jsp:include page="<%= pane_jsp %>" flush="true"/>
    <%
        } catch (javax.servlet.ServletException e) {
            Log.biz.err("pane_jsp :" + pane_jsp + ":" + e);
        } catch (java.io.IOException e) {
            Log.biz.err("pane_jsp :" + pane_jsp + ":" + e);
        }
    %>
</script>
<%
    }
    for (int i = 0; i < smws[0].length; i++) {
        String smw = smws[0][i];
        String smw_jsp = "smw/define/" + smw + ".define.jsp";
        try {
            Log.biz.info(i + ":" + smw_jsp);
%>
<jsp:include page="<%= smw_jsp %>" flush="true"/>

<%
        } catch (javax.servlet.ServletException e) {
            Log.biz.err("smw_jsp :" + smw_jsp + ":" + e);
        } catch (java.io.IOException e) {
            Log.biz.err("smw_jsp :" + smw_jsp + ":" + e);
        }
    }
%>

<%
    rs4.reset();
    for (int i = 0; rs4.next(); i++) {
        String wit_id = rs4.get("wit_id");
        String smw = rs4.get("wit_smw");
        String smw_jsp = "smw/" + smw + ".jsp";

        request.setAttribute("rs", rs4);
        try {
%>
<jsp:include page="<%= smw_jsp %>" flush="true"/>

<%
        } catch (javax.servlet.ServletException e) {
            Log.biz.err("smw_jsp :" + smw_jsp + ":" + e);
        } catch (java.io.IOException e) {
            Log.biz.err("smw_jsp :" + smw_jsp + ":" + e);
        }
    }
%>


<script id="tpl-smw" type="text/x-handlebars-template">
    <div id="smw-{{id}}" style='height:{{height}}px;'></div>
</script>


</body>
</html>
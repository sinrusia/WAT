<%--
  Created by IntelliJ IDEA.
  User: gojaehag
  Date: 2015. 10. 6.
  Time: 오후 3:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String system = "Empty";
    String sysname = "SSD5 | Smart Strategy Dashbaord 5";
%>
<!DOCTYPE html>
<html lang="en" ng-app="ssdApp">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <link rel="icon" href="/xefc/images/egene_bi.ico">

    <title><%= sysname %>
    </title>

    <!-- bootstrap & fontawesome -->

    <link href="/xplugin/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- font -->
    <link href="/xplugin/font-awesome/css/font-awesome.css" rel="stylesheet">

    <!-- jqx -->
    <link href="/xplugin/jqwidgets/styles/jqx.base.css" rel="stylesheet">

    <!-- default -->
    <link href="/xssd5/css/style.css" rel="stylesheet">

    <!-- ace style -->
    <link href="/xssd5/css/lightskyblue/jqx.base.css" rel="stylesheet">

    <link href="/xssd5/css/lightskyblue/style.css" rel="stylesheet">

    <!--
    <link href="/xplugin/bootstrap/ace/assets/css/ace.css" rel="stylesheet">
  -->

    <!-- jquery scripts -->
    <script src="/xplugin/jquery/jquery-1.11.3.js"></script>
    <!-- angularjs scripts -->
    <script src="/xplugin/angularjs/angular.js"></script>
    <script src="/xplugin/angularjs/angular-route.js"></script>
    <!-- bootstrap scripts -->
    <script src="/xplugin/bootstrap/js/bootstrap.js"></script>
    <!-- jqx scripts -->
    <script src="/xplugin/jqwidgets/jqx-all.js"></script>
    <!-- count up -->
    <script src="/xplugin/countup/countUp.js"></script>
    <!-- ssd script -->
    <script src="/xssd5/script/ssd.js"></script>
    <!-- easypiechart -->
    <script src="/xplugin/easypiechart/angular.easypiechart.js"></script>
    <!-- jquery sparkline -->
    <script src="/xplugin/jquery.sparkline/jquery.sparkline.js"></script>

    <!--[if lte IE 8]>
    <script src="/xplugin/bootstrap/ace/assets/js/excanvas.js"></script>
    <script src="/xplugin/bootstrap/ace/assets/js/html5shiv.js"></script>
    <![endif]-->

    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    <!-- application scripts -->
    <script src="/xssd5/script/app.js"></script>
    <script src="/xssd5/script/controllers.js"></script>
    <script src="/xssd5/script/directives.js"></script>
    <script src="/xssd5/script/filters.js"></script>
    <script src="/xssd5/script/directives/filter.js"></script>
    <script src="/xssd5/script/directives/sparkline.js"></script>
    <script src="/xssd5/script/service.js"></script>


    <script type="text/javascript">
        //Needed for IE8/9
        document.createElement('ssd-widget');
        document.createElement('ssd-pane');
    </script>

</head>

<body ng-controller="appController" ssd-system="<%=system%>">

<div class="article ssd-app">
    <!-- header -->
    <div class="header page-header" data-sidebar="true"
         data-sidebar-scroll="true" data-sidebar-hover="true">

        <div class="header-ci">
            <a href="#">
                <img src="/xssd5/images/top/ci.png"/>
            </a>
            <img src="/xssd5/images/top/title.png" style="padding-left: 20px;"/>
        </div>

        <div class="pull-right" style="width: 260px; color: #ffffff; padding: 15px 0">
            <div class="tm_info">
                <sapn class="dt"></sapn>
                <span class="ampm" ></span>
                <span class="hhmi" ></span>
                <span class="ss" ></span>
            </div>
        </div>
    </div>

    <!-- nav -->
    <div class="menubar">

        <ul class="nav menu-list">
            <li class="menu" ng-repeat="menu in menus">
                <a href="{{menu.men_url}}" ng-mouseover="bg=true" ng-mouseout="bg=false"
                   ng-click="menuChange(menu.men_id)">
                    <div class="center main-menu">
                        {{menu.men_name}}
                    </div>
                </a>

                <b class="arrow"></b>
            </li>

        </ul>
    </div>


    <!-- end header -->

    <div class="section">
        <div ng-view="">
        </div>
    </div>

    <div class="footer">
    </div>

</div>

</body>
</html>

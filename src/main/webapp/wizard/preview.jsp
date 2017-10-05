<%--
  Created by IntelliJ IDEA.
  User: gojaehag
  Date: 2015. 11. 3.
  Time: 오후 5:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/xefc/jsp/common/import.jspf" %>
<%
    Box box = HttpUtility.getBox(request);
    com.steg.efc.Texts texts = com.steg.efc.Texts.getInstance();

    GlobalConfig gcfg = GlobalConfig.getInstance();
    String sysname = gcfg.getValue("ssd.title");
    if (!StringUtil.valid(sysname)) {
        sysname = "SSD5 | Smart Strategy Dashbaord 5";
    }

%>
<!DOCTYPE html>
<html lang="en" ng-app="ssdApp">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
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

    <!-- ssd -->
    <link href="/xssd5/css/style.css" rel="stylesheet">

    <!-- ace style -->
    <!--
    <link href="/xssd5/css/redrose/jqx.base.css" rel="stylesheet">

    <link href="/xssd5/css/redrose/ssd.css" rel="stylesheet">

    <link href="/xssd5/css/redrose/style.css" rel="stylesheet">
    -->
    <!--
        <link href="/xssd5/css/white/jqx.base.css" rel="stylesheet">

        <link href="/xssd5/css/white/ace.css" rel="stylesheet">
    -->


    <!--
    <link href="/xplugin/bootstrap/ace/assets/css/ace.css" rel="stylesheet">
  -->

</head>

<body ng-controller="appController">

<div class="article ssd-app">
    <!-- header -->
    <div class="header page-header" data-sidebar="true"
         data-sidebar-scroll="true" data-sidebar-hover="true">

        <div class="header-ci">
            <a href="#">
                <img src="/xdashboard/images/dashboard_ci_white.png"/>
            </a>
        </div>
    </div>

    <!-- end header -->

    <div class="section">
        <div ng-view="">
        </div>
    </div>

    <div class="footer">
    </div>

</div>

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

<!-- application scripts -->
<script src="/xssd5/script/dashboard-wizard/preview.js"></script>
<script src="/xssd5/script/controllers.js"></script>
<script src="/xssd5/script/filters.js"></script>
<script src="/xssd5/script/directives.js"></script>
<script src="/xssd5/script/directives/filter.js"></script>
<script src="/xssd5/script/directives/sparkline.js"></script>
<script src="/xssd5/script/service.js"></script>

</body>
</html>
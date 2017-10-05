<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/xefc/jsp/common/import.jspf" %>
<%
    Box box = HttpUtility.getBox(request);
    com.steg.efc.Texts texts = com.steg.efc.Texts.getInstance();
    String title = "";
%>

<!-- Service title Area -->
<div class="article page-content sta">
    <div class="header page-top" ng-show="filterused" style="overflow: hidden">
        <!-- Title -->
        <div class="page-title h1">
            {{title}}
        </div>

        <div class="filter-ctrl">
            <!-- Button -->
            <button class="btn btn-sm btn-danger btn-white btn-round" ng-click="search()" style="padding: 0 10px 3px;">
                <i class="ace-icon fa fa-search bigger-125"></i>
                조 회
            </button>
        </div>

        <!-- filter -->
        <div class="filter">

        </div>

    </div>

    <div id="layout" class="section page-main">
    </div>

    <div class="footer">

    </div>

</div>



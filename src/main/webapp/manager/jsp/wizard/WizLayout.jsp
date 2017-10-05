<%--
  Created by IntelliJ IDEA.
  User: gojaehag
  Date: 2015. 10. 26.
  Time: 오전 10:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="ui-component wiz-container wiz-layout" ng-click="selectHandler($event)" ng-mouseover="overHandler($event)">


    <div class="container-main" style="position: relative">

    </div>

    <div class="control-button-group" style="position: absolute; top: 0px; right: 0px;">
        <input type="button" ng-click="delete()" class="button remove">
    </div>


    <div class="control-button-group" style="position: absolute; bottom: 0px; right: 0px;">
        <input type="button" ng-click="addRow()" class="button add-row">
        <input type="button" ng-click="addColumn()" class="button add-column">
    </div>
</div>
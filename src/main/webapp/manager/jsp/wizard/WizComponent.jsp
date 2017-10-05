<%--
  Created by IntelliJ IDEA.
  User: gojaehag
  Date: 2015. 10. 26.
  Time: 오전 10:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="ui-component wiz-component" ng-click="selectHandler($event)" ng-mouseover="overHandler($event)">
    <div ng-include="xssd5/jsp/wizitem/JqxChart.jsp"></div>

    <div class="control-button-group .hide" style="position: absolute; top: 0px; right: 0px;">
        <input type="button" ng-click="delete()" class="button remove">
    </div>

</div>
<%--
  Created by IntelliJ IDEA.
  User: gojaehag
  Date: 15. 10. 2.
  Time: 오전 9:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--
<div count-up id="numberAnimation" end-val="{{value}}" decimals="0" duration="2" class="h1"></div>
-->
<number-count smw-settings="settings" smw-value={{value}} class="h1"></number-count>

<input type="button" ng-click="setValue()" value="setValue">
<input type="button" ng-click="change()" value="change">
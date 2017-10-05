<%--
  Created by IntelliJ IDEA.
  User: gojaehag
  Date: 2015. 11. 10.
  Time: 오전 11:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<input name="{{property.name}}" type="text" ng-model="property.value" ng-change="changeValue()"
       ng-readonly="property.editable">

<%--
  Created by IntelliJ IDEA.
  User: gojaehag
  Date: 2015. 11. 10.
  Time: 오후 2:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<select name="{{property.name}}" ng-model="property.value" ng-change="changeValue()"
        ng-options="code.id as code.label for code in codes">
</select>

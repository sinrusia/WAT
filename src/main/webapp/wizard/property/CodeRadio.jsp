<%--
  Created by IntelliJ IDEA.
  User: gojaehag
  Date: 2015. 11. 13.
  Time: 오전 9:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div>
  <ul>
    <li ng-repeat="code in codes">
      <label style="color: #ffffff;">
        <input type="radio" ng-model="property.value" value="{{code.value}}" ng-change="changeValue()">
        {{code.label}}
      </label>
    </li>
  </ul>
</div>
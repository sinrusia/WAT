<%--
  Created by IntelliJ IDEA.
  User: gojaehag
  Date: 2015. 11. 16.
  Time: 오후 5:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div>
    <ul>
        <li ng-repeat="data in dataProvider">
            {{data.label}}
        </li>
    </ul>
</div>
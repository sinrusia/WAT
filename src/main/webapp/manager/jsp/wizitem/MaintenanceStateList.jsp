<%--
  Created by IntelliJ IDEA.
  User: gojaehag
  Date: 2015. 11. 17.
  Time: 오전 9:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div>
    <ul style="list-style: none; padding: 0 5px;">
        <li ng-repeat="data in dataProvider" style="width:20%; min-width: 110px;float: left; display: block; position: relative;">
            <div ng-style="setColor(data)"
            style="-webkit-border-radius: 3px;-moz-border-radius: 3px;border-radius: 3px;
            border: 0 solid {{data.bg}}; padding: 5px 0; margin: 4px; min-width: 80px; text-align: center;">
                <div style="font-size: 35px; text-decoration: none; line-height: 120%; font-weight: bold;">
                    <number-count smw-value={{data.count}} smw-suffix="" ></number-count>
                </div>
                <div style="font-size: 12px; text-decoration: none; line-height: 120%; font-weight:bold;">
                    <i class="fa {{data.icon}}" style="font-size:18px;"></i>
                    <span>{{data.label}}</span>
                </div>
            </div>
        </li>
    </ul>
</div>
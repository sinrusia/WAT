<%--
  Created by IntelliJ IDEA.
  User: gojaehag
  Date: 2015. 11. 16.
  Time: 오후 5:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div>
    <ul style="list-style: none; padding: 0 10px;">
        <li ng-repeat="data in dataProvider" style="width: 16%; min-width: 50px;float: left; display: block; position: relative;">
            <div ng-style="setColor(data)"
            style="-webkit-border-radius: 3px;-moz-border-radius: 3px;border-radius: 3px;
            border: 0 solid {{data.bg}}; padding: 5px 10px; margin: 4px; min-width: 80px; text-align: center;">
                <div style="font-size: 35px; text-decoration: none; line-height: 120%; font-weight: bold;">
                    <number-count smw-value={{data.count}} smw-suffix="" ></number-count>
                </div>
                <img src="/xssd5/images/icon/icon_0{{$index+1}}.png">
            </div>
        </li>
    </ul>
</div>
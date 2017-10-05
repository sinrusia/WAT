<%--
  Created by IntelliJ IDEA.
  User: gojaehag
  Date: 2015. 10. 2.
  Time: 오후 4:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div>
    <jqx-linear-gauge ng-model="value" jqx-settings="settings"
                      style="width: 200px; height: 50px; position: absolute; top: 35px;"></jqx-linear-gauge>
    
    <number-count smw-value={{value}} smw-suffix="%" class="h1 text-bold"
                  style="margin-top: 0; color: #8DC63F; text-align: right;"></number-count>
</div>

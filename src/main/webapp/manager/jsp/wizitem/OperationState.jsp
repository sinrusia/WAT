<%--
  Created by IntelliJ IDEA.
  User: gojaehag
  Date: 2015. 10. 2.
  Time: 오후 3:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="chart-item-bg" style="padding: 0 10px;">
    <div id="operation-stats" style="min-height: 140px; vertical-align:middle;">
        <jqx-gauge ng-model="value" jqx-settings="settings"
                   style="width: 170px; height: 140px; margin: 0 auto;"></jqx-gauge>
    </div>

    <div class="chart-label">
        <div style="min-width: 120px; float: left;">
            <number-count smw-value={{value}} smw-suffix="%" smw-decimals="2" class="h1"
                          style="font-size: 30px; color: #27a9e0; text-decoration: none; line-height: 120%; font-weight: bold;"></number-count>
        </div>

        <div style="padding-top: 13px;">
            <span class="text-upper"
                  style="padding-top: 10px; font-size: 15px; color: #808080; text-decoration: none; line-height: 120%; font-weight: bold;">목표 : {{target}}%</span>
        </div>
    </div>

</div>
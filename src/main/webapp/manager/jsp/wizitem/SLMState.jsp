<%--
  Created by IntelliJ IDEA.
  User: gojaehag
  Date: 15. 10. 1.
  Time: 오후 4:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="widget-component">

    <div style="display: table">
        <div style="display: table-row">
            <div style="display: table-cell;vertical-align: middle;background: #a8ccf0; padding: 10px;">
                <label style="font-size: 16px; color: #192938; text-decoration: none; line-height: 120%; font-weight: bold">2015년</label>
            </div>
            <div style="display: table-cell;">
                <jqx-gauge ng-model="year_point" jqx-settings="settings"
                           style="width:160px; height:140px;"></jqx-gauge>

            </div>
            <div style="display: table-cell;vertical-align: middle; padding: 5px;">
                <div>
                    <number-count smw-value={{year_point}} smw-suffix="" class="h1" style="margin-top: 0;
                    font-size: 29px; color: #68b728; text-decoration: none; line-height: 120%; font-weight: bold;"></number-count>
                    <span style="font-size: 18px; color: #68b728; text-decoration: none; line-height: 120%; font-weight: bold;">점</span>
                </div>
                <div>
                    <span style="font-size: 29px; color: #68b728; text-decoration: none; line-height: 120%; font-weight: bold;">{{year_level | uppercase}}</span>
                    <span style="font-size: 18px; color: #68b728; text-decoration: none; line-height: 120%; font-weight: bold;">등급</span>
                </div>
            </div>
            <div style="display: table-cell;vertical-align: middle;background: #a8ccf0; padding: 10px;">
                <label style="font-size: 16px; color: #192938; text-decoration: none; line-height: 120%; font-weight: bold;text-align: center;">2015년<br/>09월</label>
            </div>
            <div style="display: table-cell;">
                <jqx-gauge ng-model="month_point" jqx-settings="settings"
                           style="width:160px; height:140px;"></jqx-gauge>

            </div>
            <div style="display: table-cell;vertical-align: middle; padding: 5px;">
                <div>
                    <number-count smw-value={{month_point}} smw-suffix="" class="h1" style="margin-top: 0;
                    font-size: 29px; color: #68b728; text-decoration: none; line-height: 120%; font-weight: bold;"></number-count>
                    <span style="font-size: 18px; color: #68b728; text-decoration: none; line-height: 120%; font-weight: bold;">점</span>
                </div>
                <div>
                    <span style="font-size: 29px; color: #68b728; text-decoration: none; line-height: 120%; font-weight: bold;">{{month_level | uppercase}}</span>
                    <span style="font-size: 18px; color: #68b728; text-decoration: none; line-height: 120%; font-weight: bold;">등급</span>
                </div>

            </div>

        </div>
    </div>

</div>

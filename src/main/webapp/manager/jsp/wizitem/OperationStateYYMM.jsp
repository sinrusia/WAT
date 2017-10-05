<%--
  Created by IntelliJ IDEA.
  User: gojaehag
  Date: 2015. 11. 24.
  Time: 오전 10:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="widget-component">
    <div style="padding: 2px 10px"><li class="fa fa-arrow-circle-right"></li>무장애 시간: {{last_date | dateFormatter}} 이후 <span style="color: #008805;"> {{run_time}}시간 ({{last_date | numberOfPastday}}일)</span></div>

    <div style="border-top: 1px solid #cdcdcd">
        <div style="display: table-row">
            <div style="display: table-cell;vertical-align: middle;background: #a8ccf0; min-width: 55px; text-align: center;">
                <label style="font-size: 16px; color: #192938; text-decoration: none; line-height: 120%; font-weight: bold; text-align: center">{{year}}년</label>
            </div>
            <div style="display: table-cell;">
                <jqx-gauge ng-model="year_point" jqx-settings="settings"
                           style="width:150px; height:140px;"></jqx-gauge>

            </div>
            <div style="display: table-cell;vertical-align: middle; min-width:100px;">
                <div>
                    <number-count smw-value={{year_point}} smw-suffix="%" smw-decimals="2" class="h1"
                                  style="font-size: 25px; color: #27a9e0; text-decoration: none; line-height: 120%; font-weight: bold;"></number-count>
                </div>
                <div style="padding-top: 13px;">
                    <span class="text-upper"
                          style="padding-top: 10px; font-size: 15px; color: #808080; text-decoration: none; line-height: 120%; font-weight: bold;">목표 : {{year_target}}%</span><br/>
                    <span class="text-upper"
                          style="padding-top: 10px; font-size: 15px; color: #808080; text-decoration: none; line-height: 120%; font-weight: bold;">최저 : {{year_minimum}}%</span>
                </div>
            </div>
            <div style="display: table-cell;vertical-align: middle;background: #a8ccf0; min-width: 55px; text-align: center;">
                <label style="font-size: 16px; color: #192938; text-decoration: none; line-height: 120%; font-weight: bold;text-align: center;">{{year}}년<br/>{{month}}월</label>
            </div>
            <div style="display: table-cell;">
                <jqx-gauge ng-model="month_point" jqx-settings="settings"
                           style="width:150px; height:140px;"></jqx-gauge>

            </div>
            <div style="display: table-cell;vertical-align: middle; min-width:100px;">
                <div>
                    <number-count smw-value={{month_point}} smw-suffix="%" smw-decimals="2" class="h1"
                                  style="font-size: 25px; color: #27a9e0; text-decoration: none; line-height: 120%; font-weight: bold;"></number-count>
                </div>
                <div style="padding-top: 13px;">
                    <span class="text-upper"
                          style="padding-top: 10px; font-size: 15px; color: #808080; text-decoration: none; line-height: 120%; font-weight: bold;">목표 : {{month_target}}%</span><br/>
                    <span class="text-upper"
                          style="padding-top: 10px; font-size: 15px; color: #808080; text-decoration: none; line-height: 120%; font-weight: bold;">최저 : {{month_minimum}}%</span>
                </div>
                <div style="padding-top: 13px;">
                </div>

            </div>

        </div>
    </div>

</div>

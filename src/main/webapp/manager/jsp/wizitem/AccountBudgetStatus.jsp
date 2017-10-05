<%--
  Created by IntelliJ IDEA.
  User: gojaehag
  Date: 2015. 10. 15.
  Time: 오후 4:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<table class="smwc01" ng-repeat="data in dataProvider">
    <col width="20%" align="left">
    <col width="12%" align="center">
    <col width="12%" align="right">
    <col width="12%" align="right">
    <col width1="1%" align="left">
    <col width="12%" align="right">

    <tr>
        <td class="type">{{data.type}}</td>
        <td class="epie">
            <span class="chart" easypiechart options="piechartOption"
                  percent="data.rate" options="options">
                <span class="percent" ng-bind="data.rate"></span>
            </span>
        </td>
        <td class="val1">
            <number-count smw-value={{data.val1}} smw-suffix="" class="h1" style="margin-top: 0;"></number-count>

            <div class="st">예산</div>
        </td>
        <td class="val2">
            <number-count smw-value={{data.val2}} smw-suffix="" class="h1" style="margin-top: 0;"></number-count>
            <div class="st">실적</div>
        </td>
        <td class="mons">

            <div jq-sparkline type="bar" ng-model="data.mons"
                 opts={{sparklineOption}} class="sparkline">

            </div>
            <div class="stc">월별실적</div>
        </td>
        <td class="val3">
            <number-count smw-value={{data.val3}} smw-suffix="" class="h1" style="margin-top: 0;"></number-count>

            <div class="st">가용예산</div>
        </td>

    </tr>
</table>
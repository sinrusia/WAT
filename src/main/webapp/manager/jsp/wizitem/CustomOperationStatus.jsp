<%--
  Created by IntelliJ IDEA.
  User: gojaehag
  Date: 2015. 10. 2.
  Time: 오후 3:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="chart-item-bg" style="">
    <div class="row">

        <div class="chart-label" style="padding-top: 10px; position: absolute; right: 15px;">
            <span class="text-upper"><i class="ace-icon fa fa-chevron-circle-right "></i>&nbsp;년간 가동률</span>

            <number-count smw-value={{value}} smw-suffix="%" class="h1" style="margin-top: 0;"></number-count>


            <span class="text-upper"><i class="ace-icon fa fa-chevron-circle-right"></i>&nbsp;무장애 시간</span>

            <number-count smw-value={{time}} smw-suffix="시간" class="h1" style="margin-top: 0;"></number-count>


            <span class="text-upper"><i class="ace-icon fa fa-chevron-circle-right"></i>&nbsp;무장애 일수</span>

            <number-count smw-value={{date}} smw-suffix="" smw-suffix="D-" class="h1" style="margin-top: 0;"></number-count>


        </div>

        <div id="operation-stats" style="min-height: 204px; vertical-align:middle;">
            <jqx-gauge ng-model="value" jqx-settings="settings"
                       style="width: 170px; height: 140px; left: 5px;"></jqx-gauge>
        </div>
    </div>
</div>
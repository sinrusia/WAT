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

            <div id="operation-rate-label" class="h2 t-secondary text-bold yellow-num" xe-counter=""
                 data-count="this"
                 data-from="0.00" data-to="67.35" data-suffix="%" data-duration="1.5"
                 style="margin-top: 0; text-align:right;">0.00%
            </div>
            <span class="text-upper"><i class="ace-icon fa fa-chevron-circle-right"></i>&nbsp;무장애 시간</span>

            <div id="noerror-time-label" class="h2 text-secondary text-bold yellow-num"
                 xe-counter=""
                 data-count="this"
                 data-from="0" data-to="264" data-suffix="시간" data-duration="1"
                 style="margin-top: 0; text-align: right;">0시간
            </div>
            <span class="text-upper"><i class="ace-icon fa fa-chevron-circle-right"></i>&nbsp;무장애 일수</span>

            <div id="noerror-day-label" class="h2 text-secondary text-bold yellow-num" xe-counter=""
                 data-count="this"
                 data-from="0" data-to="264" data-suffix="시간" data-duration="1"
                 style="margin-top: 0; text-align: right;">D-198
            </div>

        </div>

        <div id="operation-stats" style="min-height: 204px; vertical-align:middle;">
            <jqx-gauge ng-model="value" jqx-settings="settings"
                       style="width: 170px; height: 140px; left: 5px;"></jqx-gauge>
        </div>
    </div>
</div>
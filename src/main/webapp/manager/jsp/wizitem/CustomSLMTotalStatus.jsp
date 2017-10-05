<%--
  Created by IntelliJ IDEA.
  User: gojaehag
  Date: 15. 10. 1.
  Time: 오후 4:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div>
<div style="display: table; padding-bottom: 5px;">
    <div style="display: table-row">
        <div style="display: table-cell; width: 110px;">종합수준</div>
    </div>
    <div style="display: table-row">
        <number-count smw-value={{value}} smw-suffix="%" class="h1" style="margin-top: 0;"></number-count>
        <!--
        <div id="service-level-label" class="h1 text-secondary text-bold yellow-num" xe-counter=""
             data-count="this"
             data-from="0.00" data-to="96.0%" data-suffix="" data-duration="1"
             style="margin-top: 0;">0.0%
        </div>
        -->
    </div>
    <div style="display: table-row">
        <div style="display: table-cell; width: 110px;">등급</div>
    </div>
    <div style="display: table-row">
        <div class="h1 text-secondary text-bold infobox-{{level | lowercase}}"
             style="display: table-cell; width: 110px;">
            <div class="infobox-icon">
                <i class="level-icon ace-icon fa fa-{{level | lowercase}}"></i>
            </div>
        </div>

    </div>
</div>

<jqx-gauge ng-model="value" jqx-settings="settings"
           style="width:170px; height:140px; position:absolute; right:15px; top:30px;"></jqx-gauge>

</div>

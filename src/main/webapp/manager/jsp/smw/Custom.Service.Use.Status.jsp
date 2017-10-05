<%--
  Created by IntelliJ IDEA.
  User: gojaehag
  Date: 2015. 10. 2.
  Time: 오후 4:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jqx-linear-gauge ng-model="value" jqx-settings="settings"
           style="width: 200px; height: 50px; position: absolute;"></jqx-linear-gauge>
<div class="tile-content">
  <div id="total-srm-label1" class="text-bold" xe-counter="" data-count="this"
       data-from="0.00" data-to="0" data-suffix="%" data-duration="1"
       style="margin-top: 0; text-align: right; color: #8DC63F;">0<span>%</span></div>
</div>

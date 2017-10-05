<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/xssd/jsp/common/import.jspf" %>
<div style="display:inline;">
    <select name="year" ng-options="year for year in years track by year" ng-model="select.year"
            ng-change="changeHandler()">
    </select>
</div>

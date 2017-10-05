<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/xssd/jsp/common/import.jspf" %>
<div style="display:inline;">
    <label>
        {{filter.alias}} :
    </label>
    <select name="year" ng-options="year for year in years track by year" ng-model="select.year"
            ng-change="changeHandler()">
    </select>
    년

    <select name="month" ng-options="month for month in months track by month" ng-model="select.month"
            ng-change="changeHandler()">
    </select>
    월
</div>

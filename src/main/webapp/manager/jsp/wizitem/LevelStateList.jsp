<%--
  Created by IntelliJ IDEA.
  User: gojaehag
  Date: 2015. 11. 20.
  Time: 오전 9:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div>
    <!-- Widget Component Contents -->
    <div>
        <ul style="list-style: none; padding: 0;">
            <li ng-repeat="data in dataProvider" class="col-sm-4 col-lg-2" on-finish-render="ngRepeatFinished">
                <div class="infobox">
                    <div class="infobox-progress">

                        <!--
                        <div class="donut-chart" style="width: 60px; height: 60px;">
                        </div>
                        -->
                        <div class="chart" easypiechart options="settings"
                             percent="data.level_rate" options="options">
                            <span class="percent" ng-bind="data.level_rate"></span>
                        </div>
                    </div>

                    <div class="infobox-data">
                        <span class="infobox-text">{{data.category}}</span>

                        <div class="infobox-content">
                            <span class="bigger-110">목표: </span>
                            {{data.target_rate}}%
                        </div>
                    </div>

                    <div class="stat" ng-class="data.state_class">{{data.state}}%</div>
                </div>
            </li>
        </ul>

    </div>
</div>
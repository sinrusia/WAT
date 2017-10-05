<%--
  Created by IntelliJ IDEA.
  User: gojaehag
  Date: 2015. 11. 12.
  Time: 오후 5:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="blue-panel panel-grape">
    <div class="blue-panel-heading">
        <div class="panel-title blue-panel-title">
            {{config.title}}
        </div>

        <div class="panel-toolbar">
            <span class="panel-legend">

            </span>

            <a href="{{config.linkUrl}}" ng-show="useLink">
                <img src="/xssd5/images/btn/more.png">
            </a>
        </div>

    </div>
    <div id="cbox-{{config.id}}" class="panel-body pane-body">

    </div>
</div>

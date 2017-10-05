<%--
  Created by IntelliJ IDEA.
  User: gojaehag
  Date: 2015. 11. 4.
  Time: 오후 2:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="wiz-properties">
    <style>
        .wiz-properties ul {
            padding: 0;
            position: relative;
            display: block;
        }

        .wiz-properties ul li {
            position: relative;
            display: block;
        }
    </style>
    <div style="width: 100%; height: 100%; overflow: auto;">
        <ul style="margin: 10px 0;">
            <li ng-repeat="propGroup in properties" style="background: #6d6c6c; margin: 2px 3px; padding: 4px 0 0;">

                <a href="#" style="color: #ffffff; font-size: 12px; text-decoration: none; font-weight: bold;
                padding-left: 5px;">
                    <i class="menu-icon fa fa-pencil-square-o"></i>
                    <span class="menu-text"> {{propGroup.name}} </span>

                    <b class="arrow fa fa-angle-down"></b>
                </a>
                <b class="arrow"></b>

                <ul style="background: #7a7979;padding: 2px 0; margin-top: 2px;">
                    <li ng-repeat="property in propGroup.items" style="padding: 2px 8px;">
                        <div style="overflow: hidden; min-width: 180px;">
                            <label style="width: 60px; float: left; position: relative; display: inline-block;
                            color: #ffffff; font-weight: normal;">{{property.label}}</label>

                            <div style="width: 100px; float: left; position: relative; display: block;">
                                <wiz-Property prop-control="{{property.control}}"></wiz-Property>
                            </div>
                        </div>
                    </li>
                </ul>
            </li>
        </ul>
    </div>

</div>
<%--
  Created by IntelliJ IDEA.
  User: gojaehag
  Date: 15. 9. 21.
  Time: 오전 11:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div id="pane-{{id}}" class="col-md-{{cols.md}} padding-n" style="">

    <div class="widget-box widget-color-{{color}}">
        <div class="widget-header widget-header-small">
            <h6 class="widget-title">
                <i class="ace-icon fa fa-bullseye "></i>
                {{title}}
            </h6>

            <div class="widget-toolbar">
                <a href="#" data-action="fullscreen" class=""><i class="ace-icon fa fa-expand"></i></a>
            </div>
        </div>
        <div class="widget-body">
            <div id="cbox-{{id}}" class="widget-main  padding-w" {{#if height}} style="min-height:{{height}}px;" {{/if}} >
        </div>
    </div>
</div>

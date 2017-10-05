<%@ page contentType="text/html; charset=utf-8"  %>
<%@ include file="/xefc/jsp/common/import.jspf" %>
<%
    Box box = HttpUtility.getBox(request);
%>
<div class="col-md-{{config.cols.md}} padding-n" style="" >

  <div class="widget-box widget-color-{{config.color}}">
      <div class="widget-header widget-header-small">
          <h6 class="widget-title">
              <i class="ace-icon fa fa-bullseye "></i>
              {{config.title}}
          </h6>
          <div class="widget-toolbar">
              <a href="#" data-action="fullscreen" class=""><i class="ace-icon fa fa-expand"></i></a>
          </div>
      </div>
      <div class="widget-body" >
          <div id="cbox-{{config.id}}" class="widget-main  padding-w"  {{#if height}} style="min-height:{{height}}px;"  {{/if}}  >
          </div>
      </div>
  </div>

</div>


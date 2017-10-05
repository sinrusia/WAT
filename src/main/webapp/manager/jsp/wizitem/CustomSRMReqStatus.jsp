<%--
  Created by IntelliJ IDEA.
  User: gojaehag
  Date: 15. 10. 1.
  Time: 오후 4:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div>
 <div class="infobox infobox-grey infobox-small infobox-bg">
   <div class="infobox-icon">
     <i class="ace-icon fa fa-tags"></i>
   </div>
 
   <div class="infobox-data">
     <div class="infobox-content">당일요청</div>
     <div class="infobox-content text-center">
       <span class="yellow-num" style="font-size: 22px;">101</span>
     </div>
   </div>
 </div>
 
 <div class="infobox infobox-green infobox-small infobox-bg">
   <div class="infobox-icon">
     <i class="ace-icon fa fa-cogs"></i>
   </div>
 
   <div class="infobox-data">
     <div class="infobox-content">처리중</div>
     <div class="infobox-content text-center">
       <span class="yellow-num" style="font-size: 22px;">22</span>
     </div>
   </div>
 </div>
 
 <div class="infobox infobox-red infobox-small infobox-bg">
   <div class="infobox-icon">
     <i class="ace-icon fa fa-warning"></i>
   </div>
 
   <div class="infobox-data">
     <div class="infobox-content">지연건수</div>
     <div class="infobox-content text-center">
       <span class="yellow-num" style="font-size: 22px;">5</span>
     </div>
   </div>
 </div>
 
 <div class="infobox infobox-orange2 infobox-small infobox-bg">
   <div class="infobox-progress">
     <!-- #section:pages/dashboard.infobox.easypiechart -->
     <div class="easy-pie-chart percentage" data-percent="61" data-size="39">
       <span class="percent">89</span>%
     </div>
 
     <!-- /section:pages/dashboard.infobox.easypiechart -->
   </div>
 
   <div class="infobox-data" style="max-width: 100px;">
     <div class="infobox-content">당일 처리율</div>
     <div class="infobox-content"></div>
   </div>
 </div>
</div>

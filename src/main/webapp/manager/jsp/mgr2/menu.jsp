<%@ page contentType="text/html; charset=utf-8"  %>
<%@ include file="/xssd5/jsp/common/import.jspf" %><%@ include file="/xssd5/jsp/common/session.jspf" %>
<%
	Box box = HttpUtility.getBox(request);
	String system = box.get("system");
	
	ICE ice = ICE.getInstance();
	Sqls sqls = ice.sqls();
	
	Result s_r = sqls.getResult("SSD.Type.SelectAll", "SYSTEM");
	RecordSet s_rs =  s_r.getRecordSet();
%>

	
<table cellspacing=0 class='grid'>
		<col width=60>
		<col width=100>
		<col width=50>
<!--		<col width=50> -->
		<col width=30>
<!--		<col width=30 align=center> -->
		<col width=40>
	<tr class=trh>
		<th class=th1>VAL</th>
		<th class=th>Name</th>
		<th class=th>TAG</th>
<!--		<th class=th>icon</th>	-->
		<th class=th><div class=ellipsis>Used</div></th>
<!--		<th class=th>Order</th> -->
		<th class=th ><span class=link onclick="showTypeDetail('','SYSTEM', 'System');"><img src='/xssd5/jsp/mgr2/images/icon/add.gif' align=absmiddle ></span></th>
	<%		RecordSet rs = s_rs;
	for(int i=0; rs.next(); i++){	%>				
	<tr class=trd onMouseOver="focusTr(this)" onMouseOut="blurTr(this)" >
		<td><div class='ellipsis link tu' onclick="getMenus('<%= rs.get("typ_value") %>','<%= rs.get("typ_name") %>')"><%= rs.get("typ_value") %></div></td>
		<td><div class='ellipsis link tu' onclick="getMenus('<%= rs.get("typ_value") %>','<%= rs.get("typ_name") %>')"><%= rs.get("typ_name") %></div></td>
		<td><%= rs.get("typ_tag") %></td>
<!--		<td style='text-align:center;'><img src='/xssd5/jsp/mgr2/images/menu/<%= rs.get("typ_tag") %>_on.png' width=42 height=14></td> -->
		<td style='text-align:center;'><%=  (rs.getBoolean("typ_used") ? "O" : "X") %></td>
<!--		<td style='text-align:center;'><%=  rs.get("typ_order") %></td>	-->
		<td > 
				<img class=link src='/xssd5/jsp/mgr2/images/icon/ctrl.gif' onclick="showTypeDetail('<%= rs.get("typ_id") %>','SYSTEM', 'System');" align=absmiddle>
				<img class=link src='/xssd5/jsp/mgr2/images/icon/icon_del.gif' onclick="delType('<%= rs.get("typ_id") %>','SYSTEM', '<%= rs.get("typ_value") %>');" align=absmiddle>
				
			 </td>
	</tr>				
	<%		}	%>	
	</table>	
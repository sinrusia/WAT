<%@ page contentType="text/html; charset=utf-8"  %>
<%@ include file="/xssd5/jsp/common/import.jspf" %><%@ include file="/xssd5/jsp/common/session.jspf" %>
<%
	Box box = HttpUtility.getBox(request);
	
	ICE ice = ICE.getInstance();
	Sqls sqls = ice.sqls();
	
	Result r = sqls.getResult("SSD.Widget.Select", box);
	RecordSet rs = r.getRecordSet();
	
%>
<form name=frm_widgets>
<div class=cond>
		ID <input type=text name=s_id value="<%= box.get("s_id") %>"> 
		Name <input type=text name=s_nm value="<%= box.get("s_nm") %>"> 
		Config <input type=text name=s_config value="<%= box.get("s_config") %>"> 
		<input type=button value="Search" onclick="getWidgets();" class=button> </div>
</form>
	
<table id=tab_widget width=100% cellspacing=0 border=0 class=grid >
	<col width=80	>
	<col width=120	>
	<col width=60	>
	<col width=250>
	<col width=50	>
	
	<col width=40	>
	<col width=40	>
	<col width=60 align=center>
<tr class=trh >
	<th class=th1>ID</th>
	<th class=th>Name</th>
	<th class=th>Grid</th>
	<th class=th>Descr</th>
	<th class=th>Count</th>
	<th class=th>Preview</th>
	<th class=th>Portal</th>
	<th class=th><span class=link onclick="showWidgetWizard('');"><img src='/xssd5/jsp/mgr2/images/icon/add.gif' align=absmiddle ></span></th>
</tr>
<%	
	if(rs.getRowCount() == 0){
		out.println("<tr class=tr1><td colspan=8 style='text-align:center'> Data not found.</td></tr>");
	}
	for(int i=0; rs.next(); i++){
		
%>	
<tr class=trd onMouseOver="focusTr(this)" onMouseOut="blurTr(this)" >
	<td><div class=ellipsis><%= rs.get("wgt_id") %></div></td>
	<td><div class='ellipsis link tu' onclick="showWidgetWizard('<%= rs.get("wgt_id") %>');"><%= rs.get("wgt_name") %></div></td>
	<td><div class=ellipsis style='text-align:center;'><%= rs.get("cnum") %> x <%= rs.get("cnum") %></div></td>
	<td><div class=ellipsis><%= rs.get("wgt_descr") %></div></td>
	<td><div class=ellipsis style='text-align:center;'><%= rs.get("cnt") %></div></td>
	<td><div class=ellipsis style='text-align:center;'><span class=link onclick="doWidgetPreview('<%= rs.get("wgt_id") %>');"><img src='/xssd5/jsp/mgr2/images/icon/icon_search.gif'></span></div></td>
	<td><div class=ellipsis style='text-align:center;'><span class=link onclick="doPortalPreview('<%= rs.get("wgt_id") %>');"><img src='/xssd5/jsp/mgr2/images/icon/icon_search.gif'></span></div></td>
	<td > 
			<img src='/xssd5/jsp/mgr2/images/icon/ctrl.gif'  class=link onclick="showWidgetWizard('<%= rs.get("wgt_id") %>');" align=absmiddle>
			<img src='/xssd5/jsp/mgr2/images/icon/icon_del.gif'  class=link onclick="delWidget('<%= rs.get("wgt_id") %>','<%= rs.get("wgt_name") %>');" align=absmiddle>
			<!--| 
			<span class=link onclick="showWidgetMenu('<%= rs.get("wgt_id") %>');">메뉴생성</span> -->
			</td>
</tr>
<%	}	%>		
</table>
<script language=javascript>
	//var sgrid = new ScrollGrid('tab_widget',613);
</script>
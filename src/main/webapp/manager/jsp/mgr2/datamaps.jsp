<%@ page contentType="text/html; charset=utf-8"  %>
<%@ include file="/xssd5/jsp/common/import.jspf" %><%@ include file="/xssd5/jsp/common/session.jspf" %>
<%
	Box box = HttpUtility.getBox(request);
	
	ICE ice = ICE.getInstance();
	Sqls sqls = ice.sqls();
	
	Result r = sqls.getResult("SSD5.Datamaps.Select", box);
	RecordSet rs = r.getRecordSet();
	
%>
<form name=frm_1>
<div class=cond>
		ID <input type=text name=s_id value="<%= box.get("s_id") %>"> 
		Name <input type=text name=s_nm value="<%= box.get("s_nm") %>"> 
		Config <input type=text name=s_config value="<%= box.get("s_config") %>"> 
		<input type=button value="Search" onclick="getDatamaps();" class=button> </div>
</form>
	
<table id=tab_grid  width=100% cellspacing=0 border=0 class=grid >
	<col width=100	>
	<col width=150	>
	<col width=100	>
	<col width=250>
	<col width=60	>
	<col width=60 align=center>
<tr class=trh >
	<th class=th1>ID</th>
	<th class=th>Name</th>
	<th class=th>Reg Date</th>
    <th class=th>Descr</th>
	<th class=th>Order</th>
	<th class=th><span class=link onclick="showDatamapDetail('');"><img src='/xssd5/jsp/mgr2/images/icon/add.gif' align=absmiddle ></span></th>
</tr>
<%	
	if(rs.getRowCount() == 0){
		out.println("<tr class=tr1><td colspan=6 style='text-align:center'> Data not found.</td></tr>");
	}
	for(int i=0; rs.next(); i++){
		
%>	
<tr class=trd onMouseOver="focusTr(this)" onMouseOut="blurTr(this)" >
	<td><div class='ellipsis link tu' onclick="showDatamapDetail('<%= rs.get("dam_id") %>');"><%= rs.get("dam_id") %></div></td>
	<td><div class='ellipsis'><%= rs.get("dam_name") %></div></td>
    <td><div class='ellipsis'><%= rs.get("reg_dttm") %></div></td>
	<td><div class=ellipsis><%= rs.get("dam_descr") %></div></td>
	<td><div class=ellipsis><%= rs.get("dam_order") %></div></td>
	<td > 
			<img src='/xssd5/jsp/mgr2/images/icon/ctrl.gif'  class=link onclick="showDatamapDetail('<%= rs.get("dam_id") %>');" align=absmiddle>
			<img src='/xssd5/jsp/mgr2/images/icon/icon_del.gif'  class=link onclick="delDatamap('<%= rs.get("dam_id") %>','<%= rs.get("dam_name") %>');" align=absmiddle>
	</td>
</tr>
<%	}	%>		
</table>
<script language=javascript>
	//var sgrid = new ScrollGrid('tab_grid',613);
</script>
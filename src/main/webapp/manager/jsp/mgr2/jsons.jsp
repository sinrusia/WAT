<%@ page contentType="text/html; charset=utf-8"  %>
<%@ include file="/xssd5/jsp/common/import.jspf" %><%@ include file="/xssd5/jsp/common/session.jspf" %>
<%
	Box box = HttpUtility.getBox(request);
	
	ICE ice = ICE.getInstance();
	Sqls sqls = ice.sqls();
	
	Result r = sqls.getResult("SSD.Json.Select", box);
	RecordSet rs = r.getRecordSet();
	
%>
<form name=frm_jsons>
<div class=cond>
		Value <input type=text name=s_val value="<%= box.get("s_val") %>"> 
		ID <input type=text name=s_id value="<%= box.get("s_id") %>"> 
		Name <input type=text name=s_nm value="<%= box.get("s_nm") %>"> 
		Config <input type=text name=s_config value="<%= box.get("s_config") %>"> 
		<input type=button value="Search" onclick="getJsons();" class=button> </div>
</form>
	
<table id=tab_grid  width=100% cellspacing=0 border=0 class=grid >
	<col width=150	>
	<col width=150	>
	<col width=250>
	<col width=60	>
	<col width=60 align=center>
<tr class=trh >
	<th class=th1>VAL</th>
	<th class=th>Name</th>
	<th class=th>Descr</th>
	<th class=th>Order</th>
	<th class=th><span class=link onclick="showJsonDetail('');"><img src='/xssd5/jsp/mgr2/images/icon/add.gif' align=absmiddle ></span></th>
</tr>
<%	
	if(rs.getRowCount() == 0){
		out.println("<tr class=tr1><td colspan=5 style='text-align:center'> Data not found.</td></tr>");
	}
	for(int i=0; rs.next(); i++){
		
%>	
<tr class=trd onMouseOver="focusTr(this)" onMouseOut="blurTr(this)" >
	<td><div class='ellipsis link tu' onclick="showJsonDetail('<%= rs.get("json_id") %>');"><%= rs.get("json_value") %></div></td>
	<td><div class='ellipsis'><%= rs.get("json_name") %></div></td>
	<td><div class=ellipsis><%= rs.get("json_descr") %></div></td>
	<td><div class=ellipsis><%= rs.get("json_order") %></div></td>
	<td > 
			<img src='/xssd5/jsp/mgr2/images/icon/ctrl.gif'  class=link onclick="showJsonDetail('<%= rs.get("json_id") %>');" align=absmiddle>
			<img src='/xssd5/jsp/mgr2/images/icon/icon_del.gif'  class=link onclick="delJson('<%= rs.get("json_id") %>','<%= rs.get("json_name") %>');" align=absmiddle>
	</td>
</tr>
<%	}	%>		
</table>
<script language=javascript>
	//var sgrid = new ScrollGrid('tab_grid',613);
</script>
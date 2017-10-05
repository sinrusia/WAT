<%@ page contentType="text/html; charset=utf-8"  %>
<%@ include file="/xssd5/jsp/common/import.jspf" %><%@ include file="/xssd5/jsp/common/session.jspf" %>
<%
	Box box = HttpUtility.getBox(request);
	String type = box.get("type");
	String api = box.get("api");
	
	ICE ice = ICE.getInstance();
	Sqls sqls = ice.sqls();
	
	Result r = sqls.getResult("SSD.TypeTempls.SelectAll", box);
	RecordSet rs = r.getRecordSet();
	
	Result t_r = sqls.getResult("SSD.Type.SelectAll", "TYPE");
	Result a_r = sqls.getResult("SSD.Type.SelectAll", "API");
	Result d_r = sqls.getResult("SSD.Type.SelectAll", "DSNAME");
	
	RecordSet t_rs =  t_r.getRecordSet();
	RecordSet a_rs =  a_r.getRecordSet();
	RecordSet d_rs =  d_r.getRecordSet();
	
	String[][] apis = new String[2][];
	String[][] types = new String[2][];
	String[][] ds_nms = new String[2][];
	
	apis[0] = a_rs.getValues("typ_value");
	apis[1] = a_rs.getValues("typ_name");

	types[0] = t_rs.getValues("typ_value");
	types[1] = t_rs.getValues("typ_name");

	ds_nms[0] = d_rs.getValues("typ_value");
	ds_nms[1] = d_rs.getValues("typ_name");
	
	
%>
<form name=frm_temps>
<div class=cond style='overflow-x:hidden;'>
		Data Source <%= getSelect("ds_name", box.get("ds_name"), ds_nms[0], ds_nms[1], "", "[ Select ]") %>		
		API Type <%= getSelect("api", box.get("api"), apis[0], apis[1], "", "[ Select ]") %>		
		Type <%= getSelect("type", box.get("type"), types[0], types[1], "", "[ Select ]") %>		
		Name <input type=text name=nm value="<%= box.get("nm") %>"> 
		Query <input type=text name=qry_id value="<%= box.get("qry_id") %>"> 
		<input type=button value="Search" onclick="getTypeTemplates();"> 
</div>
</form>
					
<table id=tab_grid cellspacing=0 border=0 class=grid >
	<col width=20>
	<col width=120>
	<col width=120>
	<col width=100	>
	<col width=80>
	<col width=80>
	
	<col width=40>
	<col width=60 align=center>
<tr class=trh >
	<th class=th1></th>
	<th class=th1>Query</th>
	<th class=th>Name</th>
	<th class=th>API</th>
	<th class=th>Type</th>
	<th class=th>Data Source</th>
	<th class=th>Used</th>
	<th class=th><span class=link onclick="showTemplDetail('');"><img src='/xssd5/jsp/mgr2/images/icon/add.gif' align=absmiddle></span></th>
</tr>
<%	
	if(rs.getRowCount() == 0){
		out.println("<tr class=tr1><td colspan=7> Data not found.</td></tr>");
	}
	for(int i=0; rs.next(); i++){
		String cls = (i%2 == 0 ? "tr1" : "tr2");
		
%>	
<tr   class=trd onMouseOver="focusTr(this)" onMouseOut="blurTr(this)" >
	<td><img src='/xssd5/jsp/mgr2/images/icon/type_<%= rs.get("wit_api_type").toLowerCase() %>.png' align=absmiddle></td>
	<td><div class=ellipsis><%= rs.get("wit_qry_id") %></div></td>
	<td><div class='ellipsis link tu' onclick="showTemplDetail('<%= rs.get("wit_id") %>');"><%= rs.get("wit_name") %></div></td>
	<td><div class=ellipsis><%= rs.get("api_nm") %></div></td>
	<td><div class=ellipsis><%= rs.get("typ_nm") %></div></td>
	<td><div class=ellipsis><%= rs.get("ds_nm") %></div></td>
	<td style='text-align:center;'><div class=ellipsis><%= (rs.getBoolean("wit_used") ? "O" : "X") %></div></td>
	<td style=''> 
			<img src='/xssd5/jsp/mgr2/images/icon/ctrl.gif' class=link onclick="showTemplDetail('<%= rs.get("wit_id") %>');" align=absmiddle>
			<img src='/xssd5/jsp/mgr2/images/icon/icon_del.gif' class=link onclick="delTempl('<%= rs.get("wit_id") %>','<%= rs.get("wit_name") %>');" align=absmiddle>
	</td>
</tr>
<%	}	%>		
</table>

<%@ include file="/xssd5/jsp/common/ui_common.jspf" %>

<script language=javascript>
	//var sgrid = new ScrollGrid('tab_grid',613);
</script>
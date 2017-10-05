<%@ page contentType="text/html; charset=utf-8"  %>
<%@ include file="/xssd5/jsp/common/import.jspf" %><%@ include file="/xssd5/jsp/common/session.jspf" %>
<%
	Box box = HttpUtility.getBox(request);

	ICE ice = ICE.getInstance();
	Sqls sqls = ice.sqls();
	
	
	RecordSet rs = null;
	
	
	String id = box.get("id");
	String mode = "2";
	
	Widgets wgts = Widgets.getInstance();
	String[][] types = wgts.getTypes("TYPE");	
	String[][] apis = wgts.getTypes("API");	
	String[][] ds_nms = wgts.getTypes("DSNAME");	
	
	if(!box.valid("id")){
		UniqueKey ukey = UniqueKey.getInstance();
		id = ukey.getKey();
		mode = "1";	
		box.put("id", id);
		rs = new RecordSet();
	}else{
		Result r = sqls.getResult("SSD.TypeTempl.Detail", box);
		rs = r.getRecordSet();
		rs.next();
	}
	
	String checked = rs.getChecked("wit_used");
	if(mode.equals("1")) checked = "checked";
	
%>


<form name=frm_templ >	
	<input type=hidden name=id value="<%= id %>">
	<input type=hidden name=mode value="<%= mode %>">	
			<table width=100% cellspacing=1 border=0 class=table >
				<col width=70>
				<col width=130>
				<col width=70>
				<col width=130>
				<col width=70>
				<col width=130>

				
				
			<tr >
				<th>Name</th><td><input type=text name=wit_name value="<%= rs.get("wit_name") %>" style='width:98%'></td>
				<th>Query</th><td><input type=text name=wit_qry_id value="<%= rs.get("wit_qry_id") %>"  style='width:98%'></td>
				<th>API</th><td><%= getSelect("wit_api_type", rs.get("wit_api_type"), apis[0], apis[1], "", "[ Select ]") %></td>
			</tr>
			<tr>
				<th>Data Source</th><td><%= getSelect("wit_ds_name", rs.get("wit_ds_name"), ds_nms[0], ds_nms[1], "", "[ Select ]") %></td>
				<th >Type</th><td><%= getSelect("wit_typ_cd", rs.get("wit_typ_cd"), types[0], types[1], "", "[ Select ]") %></td>
				<th>USED</th><td><input type=checkbox name=wit_used value="1" <%= checked %>></td>
			</tr>
			</table>


			<table width=100% cellspacing=1 border=0 class=table  style='margin-top:5px;'>
			<tr >
				<th>CONFIG</th>
				<th>SCRIPT</th>
			</tr>
			<tr >
					<td><textarea name=wit_config rows=30 style='width:99%;' ><%= rs.get("wit_config") %></textarea></td>
					<td><textarea name=wit_script rows=30 style='width:99%;' ><%= rs.get("wit_script") %></textarea></td>
			</tr >
			</table>
	

</form>

<div style='margin-top:3px;text-align:right;'>
<img src='/xssd5/jsp/mgr2/images/wizard/widget_apply.png'  onclick="doSaveTempl();" class='link btn'>
<img src='/xssd5/jsp/mgr2/images/wizard/widget_reset.png'  onclick="document.frm_templ.reset();" class='link btn'>
</div>

<%@ include file="/xssd5/jsp/common/ui_common.jspf" %>
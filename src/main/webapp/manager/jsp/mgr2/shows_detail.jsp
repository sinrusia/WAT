<%@ page contentType="text/html; charset=utf-8"  %>
<%@ include file="/xssd5/jsp/common/import.jspf" %><%@ include file="/xssd5/jsp/common/session.jspf" %>
<%
	Box box = HttpUtility.getBox(request);
	String id = box.get("shw_id");
	
	String mode = "2";
	ICE ice = ICE.getInstance();
	Sqls sqls = ice.sqls();
	
	RecordSet rs = null;
	if(!box.valid("shw_id")){
		SKeys skey = SKeys.getInstance();
		id = skey.getKey("zssd_show","shw_id","S",3);
		mode = "1";	
		rs = new RecordSet();
		box.put("shw_id", id);
	}else{
		Result r = sqls.getResult("SSD.Show.Detail", box);
		rs = r.getRecordSet();
		rs.next();
	}

	Result i_r = sqls.getResult("SSD.Show.Item.Select", box);
	RecordSet i_rs = i_r.getRecordSet();
	
	String checked = rs.getChecked("shw_used");
	if(mode.equals("1")) checked = "checked";

%>

<style>
.dl_table{
	
}
	
.dl_table td.ctt{
		border:1px solid #aaaaaa;
		background-color:#ffffff;
}

.dl_list td{
	padding:2px;
	border-bottom:1px solid #bbbbbb;
}

.dl_list td.sel{
	padding:2px;
	border-bottom:1px solid #bbbbbb;
	background-color:#000000;
	color:#ffffff;
	font-weight:bold;
}

</style>

<form name=frm_show >	
	<input type=hidden name=mode value="<%= mode %>">
		
	<table class=dl_table>
	<col width=600>
	<col width=400>	
	<tr>
		<td valign=top class=ctt1>
			<table width=100% cellspacing=1 border=0 class=table >
				<col width=70>
				<col width=130>
				<col width=70>
				<col width=130>
				<col width=70>
				<col width=130>
				
			<tr >
				<th>ID</th><td><input type=text name=shw_id value="<%= id %>" readonly ></td>
				<th>Name</th><td><input type=text name=shw_name value="<%= rs.get("shw_name") %>"></td>
				<th>TAG</th><td><input type=text name=shw_tag value="<%= rs.get("shw_tag") %>"></td>
			</tr>
			<tr >
				<th>Used</th><td><input type=checkbox name=shw_used value="1" <%= checked %>></td>
				<th >Order</th><td colspan=3><input type=text name=shw_order value="<%= rs.get("shw_order") %>" size=3></td>
			</tr>
			</table>


			<table width=100% cellspacing=1 border=0 class=table  style='margin-top:5px;'>
			<tr >
				<th>Description</th>
			</tr>
			<tr ><td><textarea name=shw_descr rows=5 style='width:99%;' ><%= rs.get("shw_descr") %></textarea></td>
			</tr >
			<tr >
				<th>CONFIG</th>
			</tr>
			<tr ><td><textarea name=shw_config rows=20 style='width:99%;' ><%= rs.get("shw_config") %></textarea></td>
			</tr >
			</table>

		</td>
		<td  valign=top class=ctt >
			<div style='text-align:left;background-color:#dddddd;border-bottom:1px solid #aaaaaa;margin-bottom:2px;'>
				<input type=checkbox onClick="checkAllWidget(this.checked)">  All Checked
			</div>
			<div style='overflow-y:scroll;height:470px; '>
			<table class=dl_list cellspacing=0 cellpadding=2 border=0>
				<col width=20><col width=100><col ><col width=40>
<%
		for(int i=0; i_rs.next(); i++){	
			boolean isUsed = StringUtil.valid(i_rs.get("shi_wgt_id"));
			String num = isUsed ? (i+1) + "" : "";
%>						
			<tr  >
				<td <%= isUsed ? "class=sel" : ""  %>><input type=checkbox name=wgt_id<%= i %> value="<%= i_rs.get("wgt_id") %>" <%= isUsed ? "checked" : ""  %> ></td>
				<td <%= isUsed ? "class=sel" : ""  %>><%= i_rs.get("wgt_id") %></td>
				<td><input type=text name=shi_name<%= i %> value="<%= i_rs.get("shi_name") %>" size=40></td>
				<td><input type=text name=shi_order<%= i %> value="<%= num %>" size=3></td>
			</tr>
<%
		}
%>					
			</table>
			</div>
		</td>
	</tr>
	</table>
	<input type=hidden name=row_cnt value="<%= i_rs.getRowCount() %>" >
</form>

<div style='margin-top:3px;text-align:right;'>
<img src='/xssd5/jsp/mgr2/images/wizard/widget_apply.png'  onclick="doSaveShow();" class='link btn'>
<img src='/xssd5/jsp/mgr2/images/wizard/widget_reset.png'  onclick="document.frm_show.reset();" class='link btn'>
</div>

<script language=javascript>
	checkAllWidget = function(b){
		var frm = document.frm_show;
		var cnt = frm.row_cnt.value;
		for(var i=0; i<cnt; i++){
			var o = frm['wgt_id'+i];
			o.checked = b;
		}
	}
</script>
<%@ include file="/xssd5/jsp/common/ui_common.jspf" %>
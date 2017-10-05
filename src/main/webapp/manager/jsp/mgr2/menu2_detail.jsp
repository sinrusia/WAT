<%@ page contentType="text/html; charset=utf-8"  %>
<%@ include file="/xssd5/jsp/common/import.jspf" %><%@ include file="/xssd5/jsp/common/session.jspf" %>
<%
	Box box = HttpUtility.getBox(request);
	Log.biz.info("menu_detail:"+ box);
	String id = box.get("id");
	String p_id = box.get("p_id");	
	String system = box.get("system");
	String lev = box.get("lev");
	ICE ice = ICE.getInstance();
	Sqls sqls = ice.sqls();
	
	
	RecordSet rs = null;

	String mode = "2";
	
	
	if(!box.valid("id")){
		UniqueKey ukey = UniqueKey.getInstance();
		id = ukey.getKey();
		mode = "1";	
		rs = new RecordSet();
		box.put("id", id);
	}else{
		Result r = sqls.getResult("SSD.Menu.Select", box);
		rs = r.getRecordSet();
		rs.next();
	}
	
	Result p_r = sqls.getResult("SSD.MenuBySystemAll", box);
	RecordSet p_rs = p_r.getRecordSet();
	
	String[][] p_arr = new String[3][];
	p_arr[0] = p_rs.getValues("men_id");
	p_arr[1] = p_rs.getValues("men_name");
	p_arr[2] = p_rs.getValues("men_system");
	
	for(int i=0; i<p_arr[1].length;i++){
		p_arr[1][i] = "[" + p_arr[2][i] +"] " + p_arr[1][i];
	}
	
	Widgets wgts = Widgets.getInstance();
	String[][] s_arr = wgts.getTypes("SYSTEM");	
	
	String[][] t_arr = { { "WIDGET", "CUSTOM"}, {"Widget", "Custom"}};
	
	if(rs.valid("men_pid")) p_id = rs.get("men_pid");
	if(rs.valid("men_system")) system = rs.get("men_system");

	String checked = rs.getChecked("men_used");
	if(mode.equals("1")) checked = "checked";
%>


<form name=frm_menu >	
	<input type=hidden name=id value="<%= id %>">
	<input type=hidden name=mode value="<%= mode %>">
	<input type=hidden name=lev value="<%= lev %>">	
			<table width=100% cellspacing=1 border=0 class=table >
				<col width=100>
				<col >
				
			<tr >
				<th>Name</th><td><input type=text name=men_name value="<%= rs.get("men_name") %>"></td>
			</tr><tr>
				<th>TAG</th><td><input type=text name=men_tag value="<%= rs.get("men_tag") %>"></td>
			</tr>
			<tr >
				<th>System</th><td><%= getSelect("men_system", system, s_arr[0], s_arr[1], "", "[ Select ]") %></td>
			</tr><tr>
				<th >Parent</th><td><%= getSelect("men_pid", p_id, p_arr[0], p_arr[1], "", "[ Select ]") %></td>
			</tr>
			<tr >
				<th>Descripiton</th><td><textarea name=men_descr rows=5 style='width:99%' ></textarea></td>
			</tr>
			<tr >
				<th>Type</th><td><%= getSelect("men_typ_cd", rs.get("men_typ_cd"), t_arr[0], t_arr[1], "", "[ Select ]") %></td>
			</tr>
			<tr >
				<th>URL</th><td><input type=text name=men_url value="<%= rs.get("men_url") %>" style='width:99%'></td>
			</tr>
			<tr >
				<th>Used</th><td><input type=checkbox name=men_used value="1" <%= checked %>></td>
			</tr><tr>
				<th >Order</th><td ><input type=text name=men_order value="<%= rs.get("men_order") %>"></td>
			</tr>
			</table>

</form>

<div style='margin-top:3px;text-align:right;'>
<img src='/xssd5/jsp/mgr2/images/wizard/widget_apply.png'  onclick="doSaveMenu2();" class='link btn'>
<img src='/xssd5/jsp/mgr2/images/wizard/widget_reset.png'  onclick="document.frm_menu.reset();" class='link btn'>
</div>
<script language=javascript>
	chgMenuType = function(val){
		var frm = document.frm_menu;
		if(val == 'WIDGET'){
			if(!frm.men_url.defaultValue){
				frm.men_url.value = "/xssd5/jsp/service.jsp?wgt_id=";
			}
		}else if(val == 'CUSTOM'){
			if(!frm.men_url.defaultValue ){
				frm.men_url.value = "";
			}
		}
	}
	
	document.frm_menu.men_typ_cd.onchange = function(){
		chgMenuType(this.value);
	}
</script>
<%@ include file="/xssd5/jsp/common/ui_common.jspf" %>

<%@ page contentType="text/html; charset=utf-8"  %>
<%@ include file="/xssd5/jsp/common/import.jspf" %><%@ include file="/xssd5/jsp/common/session.jspf" %>
<%
	Box box = HttpUtility.getBox(request);
	Log.biz.info("type_detail:"+ box);
	String type = box.get("type");
	String id = box.get("id");
	
	String mode = "2";
	ICE ice = ICE.getInstance();
	Sqls sqls = ice.sqls();
	
	RecordSet rs = null;
	if(!box.valid("id")){
		UniqueKey ukey = UniqueKey.getInstance();
		id = ukey.getKey();
		mode = "1";	
		rs = new RecordSet();
		box.put("id", id);
	}else{
		Result r = sqls.getResult("SSD.Type.Detail", id);
		rs = r.getRecordSet();
		rs.next();
	}

	
	String checked = rs.getChecked("typ_used");
	if(mode.equals("1")) checked = "checked";
	
	String cat_type = "CAT."+ type;
	Result cat_r = sqls.getResult("SSD.Type.SelectAll", cat_type);
	RecordSet cat_rs =  cat_r.getRecordSet();
	
	boolean ds_flag = type.equals("DSNAME");
	
	
	String[][] cats = new String[2][];
	cats[0] = cat_rs.getValues("typ_value");
	cats[1] = cat_rs.getValues("typ_name");
	
    cat_type = "CLS."+ type;
	cat_r = sqls.getResult("SSD.Type.SelectAll", cat_type);
	cat_rs =  cat_r.getRecordSet();

    String[][] cls = new String[2][];
	cls[0] = cat_rs.getValues("typ_value");
	cls[1] = cat_rs.getValues("typ_name");

    cat_type = "CT."+ type;
	cat_r = sqls.getResult("SSD.Type.SelectAll", cat_type);
	cat_rs =  cat_r.getRecordSet();
    String[][] comp_types = new String[2][];
	comp_types[0] = cat_rs.getValues("typ_value");
	comp_types[1] = cat_rs.getValues("typ_name");
%>


<form name=frm_type >	
	
	<input type=hidden name=type value="<%= type %>">
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
				<th>VAL</th><td><input type=text name=typ_value value="<%= rs.get("typ_value") %>"></td>
				<th>Name</th><td><input type=text name=typ_name value="<%= rs.get("typ_name") %>"></td>
				<th>TAG</th><td><input type=text name=typ_tag value="<%= rs.get("typ_tag") %>"></td>
			</tr>
			<tr >
				<th>Category</th><td><%= getSelect("typ_cat_cd", rs.get("typ_cat_cd"), cats[0], cats[1], "", "[ Select ]") %></td>
                <th>Classification</th><td><%= getSelect("typ_cls", rs.get("typ_cls"), cls[0], cls[1], "", "[ Select ]") %></td>
                <th>Comp Type</th><td><%= getSelect("typ_comp_type", rs.get("typ_comp_type"), comp_types[0], comp_types[1], "", "[ Select ]") %></td>
            </tr>
            <tr>
				<th>Used</th><td><input type=checkbox name=typ_used value="1" <%= checked %>></td>
				<th >Order</th><td ><input type=text name=typ_order value="<%= rs.get("typ_order") %>"></td>
			</tr>
			</table>


			<table width=100% cellspacing=1 border=0 class=table  style='margin-top:5px;'>
			<tr >
				<th>CONFIG 
				  <!--
                  <img src='/xssd5/jsp/mgr2/images/icon/icon_source.gif' onclick="swTypeJsonEditor(true)" class=link>  <img src='/xssd5/jsp/mgr2/images/icon/icon_editor.gif' onclick="swTypeJsonEditor(false)" class=link>
                  -->
                  </th>
				  </th>
			</tr>
			<tr ><td><textarea name=typ_config rows=25 style='width:99%;' ><%= rs.get("typ_config") %></textarea></td>
			</tr >
			</table>
	

</form>

<div style='margin-top:3px;text-align:right;'>
<% 	if(ds_flag){	%>
<img src='/xssd5/jsp/mgr2/images/wizard/btn_test.png'  onclick="doTestDataSource();" class='link btn'>	
<%	}	%>
<img src='/xssd5/jsp/mgr2/images/wizard/widget_apply.png'  onclick="doSaveType();" class='link btn'>
<img src='/xssd5/jsp/mgr2/images/wizard/widget_reset.png'  onclick="document.frm_type.reset();" class='link btn'>
</div>

<%@ include file="/xssd5/jsp/common/ui_common.jspf" %>
<%
  String json_tag = "Type";
%>  
<script language=javascript>
	
	setTypeJsonEditor = function(){
		item_jeditor = null;
		var frm = document.frm_type;
		var o = frm.typ_config;
	
		var	json_id = "SSD.<%= type %>.<%= rs.get("typ_cat_cd") %>";
		
		
		item_jeditor =jsonEditors.create('<%= id %>',json_id, o);
		//	if(cname && cinfo) jeditor.addColumnInfo(cname,cinfo);
		item_jeditor.show();
	
	  
	  
		item_je_temp = item_jeditor;
		
	}

	//setTypeJsonEditor();

	swTypeJsonEditor = function(b){
		var je = item_je_temp;
		if(je){
			
			if(b){
				 je.showSource();
				 item_jeditor = null;
			}
			else{
				 je.reload();
				 item_jeditor = item_je_temp;
			}
		}
	}

</script>
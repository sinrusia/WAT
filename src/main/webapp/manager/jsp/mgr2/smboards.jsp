<%@ page contentType="text/html; charset=utf-8"  %>
<%@ include file="/xssd5/jsp/common/import.jspf" %><%@ include file="/xssd5/jsp/common/session.jspf" %>
<%
	Box box = HttpUtility.getBox(request);
	
	ICE ice = ICE.getInstance();
	Sqls sqls = ice.sqls();
	
	Result r = sqls.getResult("SSD5.SMBoards.Select", box);
	RecordSet rs = r.getRecordSet();
	
%>
<form name=frm_1>
<div class=cond>
		ID <input type=text name=s_id value="<%= box.get("s_id") %>"> 
		Name <input type=text name=s_nm value="<%= box.get("s_nm") %>"> 
		Config <input type=text name=s_config value="<%= box.get("s_config") %>"> 
		<input type=button value="Search" onclick="getSMBoards();" class=button> </div>
</form>
	
<table id=tab_widget width=100% cellspacing=0 border=0 class=grid >
	<col width=250	>
	<col width=150	>
	<col width=150	>
	<col width=250>

	<col width=100	>
	<col width=60	>

	<col width=60	>
	<col width=60 align=center>
<tr class=trh >
	<th class=th1>ID</th>
	<th class=th>Name</th>
	<th class=th>Title</th>
	<th class=th>Descr</th>
	<th class=th>Theme</th>
	<th class=th>Order</th>
	<th class=th>Filter</th>
    <th class=th>Preview</th>
	<th class=th><span class=link onclick="showWidgetWizard('');"><img src='/xssd5/jsp/mgr2/images/icon/add.gif' align=absmiddle ></span></th>
</tr>
<%	
	if(rs.getRowCount() == 0){
		out.println("<tr class=tr1><td colspan=8 style='text-align:center'> Data not found.</td></tr>");
	}
	for(int i=0; rs.next(); i++){
		
%>	
<tr class=trd onMouseOver="focusTr(this)" onMouseOut="blurTr(this)" >
	<td><div class='ellipsis link tu' onclick="showSMBoardWizard('<%= rs.get("smb_id") %>');"><%= rs.get("smb_id") %></div></td>
	<td><div class='ellipsis link tu' onclick="showSMBoardWizard('<%= rs.get("smb_id") %>');"><%= rs.get("smb_name") %></div></td>
	<td><div class=ellipsis style=''><%= rs.get("smb_title") %></div></td>
	<td><div class=ellipsis><%= rs.get("smb_descr") %></div></td>
    <td><div class=ellipsis style='text-align:center;'><%= rs.get("smb_theme") %></div></td>
	<td><div class=ellipsis style='text-align:center;'><%= rs.get("smb_order") %></div></td>
    <td><div class=ellipsis style='text-align:center;'><%= rs.get("filter") %></div></td>

	<td><div class=ellipsis style='text-align:center;'><span class=link onclick="doSMBoardPreview('<%= rs.get("smb_id") %>');"><img src='/xssd5/jsp/mgr2/images/icon/icon_search.gif'></span></div></td>
	<td > 
			<img src='/xssd5/jsp/mgr2/images/icon/ctrl.gif'  class=link onclick="showSMBoardWizard('<%= rs.get("smb_id") %>');" align=absmiddle>
			<img src='/xssd5/jsp/mgr2/images/icon/icon_del.gif'  class=link onclick="delSMBoard('<%= rs.get("smb_id") %>','<%= rs.get("smb_name") %>');" align=absmiddle>
			<!--| 
			<span class=link onclick="showWidgetMenu('<%= rs.get("smb_id") %>');">메뉴생성</span> -->
			</td>
</tr>
<%	}	%>		
</table>
<script language=javascript>
	//var sgrid = new ScrollGrid('tab_widget',613);
</script>
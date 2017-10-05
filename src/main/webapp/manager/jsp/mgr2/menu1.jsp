<%@ page contentType="text/html; charset=utf-8"  %>
<%@ include file="/xssd5/jsp/common/import.jspf" %><%@ include file="/xssd5/jsp/common/session.jspf" %>
<%
	Box box = HttpUtility.getBox(request);
	String system = box.get("system");
	
	ICE ice = ICE.getInstance();
	Sqls sqls = ice.sqls();
	
	Result r = sqls.getResult("SSD.MenuBySystemAll", box);
	RecordSet rs = r.getRecordSet();
%>

			
<form name=frm_menus>
<div class=cond>
		Name <input type=text name=s_nm value="<%= box.get("s_nm") %>"> 
		URL <input type=text name=s_url value="<%= box.get("s_url") %>"> 
		<input type=button value="Search" onclick="searchMenus();" class=button> </div>
</form>
	
<table cellspacing=0 border=0 class='grid' >
	<col width=150>
	<col width=90	>
	<col width=200	>
	<col width=60>
	<col width=40>
	
	<col width=40>
	<col width=60 align=center>
<tr class=trh >
	<th class=th1>Name</th>
	<th class=th>System</th>
	<th class=th>URL</th>
	<th class=th>TAG</th>
	<th class=th>Order</th>
	<th class=th>Used</th>
	<th class=th><span class=link onclick="showMenuDetail1('','<%= system %>');"><img src='/xssd5/jsp/mgr2/images/icon/add.gif'  align=absmiddle></span></th>
</tr>
<%	
	if(rs.getRowCount() == 0){
		out.println("<tr class=tr1><td colspan=7 style='text-align:center'> Data not found.</td></tr>");
	}
	for(int i=0; rs.next(); i++){
		String cls = (i%2 == 0 ? "tr1" : "tr2");
		if(rs.valid("men_system")) system = rs.get("men_system");
		int lev = rs.getInt("lev");
		String uri = rs.get("men_url");
%>	
<tr class=tr<%= lev %> >
	<td class=td<%= lev %>><div class='ellipsis link tu' onclick="showMenuDetail<%= lev %>('<%= rs.get("men_id") %>','<%= system %>')"><%= rs.get("men_name") %></div></td>
	<td><div class=ellipsis><%= rs.get("sys_nm") %></div></td>
	<td><div class=ellipsis>
<%	if(StringUtil.valid(uri)){	%>		
			<span class='link tu' onclick="showURL('<%= uri %>')"><%= uri %></span>
<%	}else{	%>
			<%= uri %>
<%	}	%>				
			</div></td>
	<td><div class=ellipsis><%= rs.get("men_tag") %></div></td>
	<td style='text-align:center;'><div class=ellipsis><%= rs.get("men_order") %></div></td>
	<td style='text-align:center;'><div class=ellipsis><%= (rs.getBoolean("men_used") ? "O" : "X") %></div></td>
	<td style=''> 
<%	if(lev == 1){	%>
		<img src='/xssd5/jsp/mgr2/images/icon/ctrl.gif' class=link onclick="showMenuDetail1('<%= rs.get("men_id") %>','<%= system %>');" align=absmiddle>
		<img src='/xssd5/jsp/mgr2/images/icon/icon_del.gif' class=link onclick="delMenu('<%= rs.get("men_id") %>','<%= rs.get("men_name") %>');" align=absmiddle>
		<img src='/xssd5/jsp/mgr2/images/icon/add.gif' class=link onclick="showMenuDetail2('','<%= system %>','<%= rs.get("men_id") %>');" align=absmiddle>
<%	}else	if(lev == 2){	%>
		<img src='/xssd5/jsp/mgr2/images/icon/ctrl.gif' class=link onclick="showMenuDetail2('<%= rs.get("men_id") %>','<%= system %>','<%= rs.get("men_pid") %>');" align=absmiddle>
		<img src='/xssd5/jsp/mgr2/images/icon/icon_del.gif' class=link onclick="delMenu('<%= rs.get("men_id") %>','<%= rs.get("men_name") %>');" align=absmiddle>

<%	}	%>
	</td>
</tr>
<%	}	%>		
</table>

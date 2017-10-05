<%@ page contentType="text/html; charset=utf-8"  %>
<%@ include file="/xssd5/jsp/common/import.jspf" %><%@ include file="/xssd5/jsp/common/session.jspf" %>
<%
	Box box = HttpUtility.getBox(request);
	String type = box.get("type");


	Widgets wgts = Widgets.getInstance();


	ICE ice = ICE.getInstance();
	Sqls sqls = ice.sqls();
	
	
	Result r = sqls.getResult("SSD.Type.SelectAll", type);

	
	RecordSet rs =  r.getRecordSet();
	boolean hasImage = false;
	if(type.equals("TYPE")) hasImage = true;
%>
			<table id=tab_grid cellspacing=0 border=0 class=grid >
<%	if(hasImage){	%>
					<col width=40>
<%	}	%>					
					<col width=100>
					<col width=100>
					<col width=100>
					<col width=100>

                    <col width=100>
                    <col width=100>
                    <col width=100>

					<col width=40>
					<col width=40 >
					<col width=40 >
				<tr class=trh>
<%	if(hasImage){	%>
					<th class=th></th>
<%	}	%>
					<th class=th1>VAL</th>
					<th class=th>Name</th>
					<th class=th>TAG</th>
					<th class=th>Category</th>

                    <th class=th>Module</th>
                    <th class=th>Classification</th>
                    <th class=th>Component Type</th>

					<th class=th>USED</th>
					<th class=th>Order</th>
					<th class=th><span class=link onclick="showTypeDetail('','<%= type %>');"><img src='/xssd5/jsp/mgr2/images/icon/add.gif' align=absmiddle></span></th>
<%		
			for(int i=0; rs.next(); i++){	
				String img = "/xssd5/jsp/mgr2/images/witem/" + ( rs.valid("typ_tag") ? rs.get("typ_tag") : "blank" ) + ".png";
%>				
				<tr  class=trd onMouseOver="focusTr(this)" onMouseOut="blurTr(this)" >
<%	if(hasImage){	%>
					<td><img src="<%= img %>" align=absmiddle style='width:95%;border:1px solid #333333;'></td>
<%	}	%>
					<td><%= rs.get("typ_value") %></td>
					<td><div class='link tu' onclick="showTypeDetail('<%= rs.get("typ_id") %>','<%= type %>');" ><%= rs.get("typ_name") %></div></td>
					<td><%= rs.get("typ_tag") %></td>
					<td><%= rs.get("cat_nm") %></td>
                    
                    <td><%= rs.get("typ_module") %></td>
                    <td><%= rs.get("typ_cls") %></td>
                    <td><%= rs.get("typ_comp_type") %></td>

					<td style='text-align:center;'><%=  (rs.getBoolean("typ_used") ? "O" : "X") %></td>
					<td style='text-align:center;'><%=  rs.get("typ_order") %></td>
					<td style=''> 
							<img src='/xssd5/jsp/mgr2/images/icon/ctrl.gif' class=link onclick="showTypeDetail('<%= rs.get("typ_id") %>','<%= type %>');" align=absmiddle>
							<img src='/xssd5/jsp/mgr2/images/icon/icon_del.gif' class=link onclick="delType('<%= rs.get("typ_id") %>','<%= type %>','<%= rs.get("typ_value") %>');" align=absmiddle>
						 </td>
				</tr>				
<%		}	%>	
				</table>	
<script language=javascript>
	//var sgrid = new ScrollGrid('tab_grid',640);
</script>
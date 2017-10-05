<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/xssd/jsp/common/import.jspf" %><%@ include file="/xssd/jsp/common/session.jspf" %>
<%
	Box box = HttpUtility.getBox(request);
	UIFilterItem item = (UIFilterItem)request.getAttribute("fitem");
	
	org.sdf.lang.Time tm = new org.sdf.lang.Time();
	int syy = 2008;
	int eyy = tm.yy;
	
	int cnt = eyy - syy + 1;
	
	int vyy = box.getInt( item.id);
	if(!box.valid(item.id)){
		String def_val = item.def_val;
		
		if(StringUtil.valid(def_val)){
			try{
				char c = def_val.charAt(0);
				if(c >= '0' && c <= '9') eyy = Integer.parseInt(def_val);
			//20150921-Exception - NumberFormatException // 20150921-Logger
			}catch(NumberFormatException e){ Log.dbg.debug(e.getMessage()); }
			
		}
		if(vyy == 0) vyy = eyy;
	} 	
	
%>	
	<select name=<%= item.id %>>
<% 
	for(int i=0; i<cnt; i++){
		int yy = syy + i;
		String selected = "";
		if(yy == vyy) selected  = "selected";
%>			
	<option value="<%= yy %>" <%= selected %>><%= yy %>년</option>
<%
	}
%>
	</select>

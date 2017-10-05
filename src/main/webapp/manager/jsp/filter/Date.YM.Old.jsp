<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/xssd/jsp/common/import.jspf" %><%@ include file="/xssd/jsp/common/session.jspf" %>
<%
	Box box = HttpUtility.getBox(request);
	UIFilterItem item = (UIFilterItem)request.getAttribute("fitem");
	
	org.sdf.lang.Time tm = new org.sdf.lang.Time();
	int syy = 2008;
	int eyy = tm.yy;
	int vyy = 0;	
	int vmm = 0;	
	
	int cnt = eyy - syy + 1;
	
	String val = box.get( item.id);
	
	if(!box.valid(item.id)){
		String def_val = item.def_val;
		
		if(StringUtil.valid(def_val)){
			if(def_val.length() == 4){
				//20150921-Exception - NumberFormatException // 20150921-Logger
				try{
					vyy = Integer.parseInt(def_val);
				}catch(NumberFormatException e){ Log.dbg.debug(e.getMessage()); }
			}else if(def_val.length() == 6){
				try{
					vyy = Integer.parseInt(def_val.substring(0,4));
				}catch(NumberFormatException e){ Log.dbg.debug(e.getMessage()); }
				try{
					vmm = Integer.parseInt(def_val.substring(4));
				}catch(NumberFormatException e){ Log.dbg.debug(e.getMessage()); }
			}
		}
		
		Log.biz.info( def_val + ":" + vyy + ":" + vmm);
		if(vyy == 0) vmm = tm.mm;
		if(vyy == 0) vyy = eyy;
		
		val = vyy + "" + (vmm <10 ? "0" + vmm : "" + vmm);
	} 	
	
	vyy = Integer.parseInt(val.substring(0,4));
	vmm = Integer.parseInt(val.substring(4,6));
	
%>
	<input type=hidden name=<%= item.id %> value="<%= val %>">
	<select name=<%= item.id %>_YY onchange="setYM<%= item.id %>()">
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
	<select name=<%= item.id %>_MM  onchange="setYM<%= item.id %>()">
<% 
	for(int i=1; i<=12; i++){
		
		String selected = "";
		if(i == vmm) selected  = "selected";
		String mm = (i <10 ? "0" + i : "" + i);
%>			
	<option value="<%= mm %>" <%= selected %>><%= mm %>월</option>
<%
	}
%>
  </select>
	
<script language=javascript>
	setYM<%= item.id %> = function(){
		var id = '<%= item.id %>';
		var frm	= document.frm;
		var vo = frm[id];
		var yo = frm[id + '_YY'];
		var mo = frm[id + '_MM'];
		if(vo && yo && mo){
			vo.value = yo.value + "" + mo.value;	
		}
	}
	
</script>
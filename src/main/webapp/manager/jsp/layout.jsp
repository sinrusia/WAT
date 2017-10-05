<%@ page contentType="text/html; charset=utf-8"  %>
<%@ include file="/xefc/jsp/common/import.jspf" %>
<%
	Box box = HttpUtility.getBox(request);
	DataMap dm = DUtil.queryByStrings("dm1:SSD5.SMBoards.RO", box);
	RecordSet rs = dm.rs("dm1");
	rs.next();
%><%= rs.get("smb_config") %>
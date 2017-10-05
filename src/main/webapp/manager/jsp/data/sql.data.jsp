<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/xefc/jsp/common/import.jspf" %>
<%
    Box box = HttpUtility.getBox(request);
    String dm1 = box.get("dm1");
    String dm2 = box.get("dm2");
    String dm3 = box.get("dm3");
    String dm4 = box.get("dm4");
    JSONObject result = new JSONObject();

    String dmStr = "dm1:"+dm1;
    if(!StringUtil.isEmpty(dm2)) {
        dmStr += ",dm2:"+dm2;
    }
    if(!StringUtil.isEmpty(dm3)) {
        dmStr += ",dm3:"+dm3;
    }
    if(!StringUtil.isEmpty(dm4)) {
        dmStr += ",dm4:"+dm4;
    }

    DataMap dm = DUtil.queryByStrings(dmStr, box);
    // convert dm1 to JSON
    RecordSet rs1 = dm.rs("dm1");
    result.put("dm1", convertRecordSetToJSON(rs1));
    // convert dm2 to JSON
    RecordSet rs2 = dm.rs("dm2");
    result.put("dm2", convertRecordSetToJSON(rs2));
    // convert dm3 to JSON
    RecordSet rs3 = dm.rs("dm3");
    result.put("dm3", convertRecordSetToJSON(rs3));
    // convert dm4 to JSON
    RecordSet rs4 = dm.rs("dm4");
    result.put("dm4", convertRecordSetToJSON(rs4));

    out.println(result.toString());

%>

<%!
    JSONArray convertRecordSetToJSON(RecordSet rs) {
        JSONArray array = new JSONArray();

        String[] columnNames = rs.getColumnNames();

        while(rs.next()) {
            JSONObject obj = new JSONObject();
            for(int i = 0; i < columnNames.length; i++) {
                String name = columnNames[i];
                Log.biz.info("column:" + name);
                obj.put(name.toLowerCase(), rs.get(name));
            }
            array.add(obj);
        }
        return array;
    }
%>
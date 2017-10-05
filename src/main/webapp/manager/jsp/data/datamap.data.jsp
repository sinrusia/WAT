<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/xefc/jsp/common/import.jspf" %>
<%
    Box box = HttpUtility.getBox(request);
    String dam_id = box.get("dam_id");
    String var_id = box.get("var_id");
    if (!StringUtil.valid(var_id)) var_id = "data1";
    DataMap dcfg = DUtil.queryByStrings("dm1:SSD5.SMB.DataMaps", box);
    RecordSet rs = dcfg.rs("dm1");
    JSONObject result = new JSONObject();
    while (rs.next()) {
        String cfg = rs.get("dam_config");
        String id = rs.get("dam_id");

        if (!StringUtil.valid(cfg)) {
            out.println("[]");
            return;
        }

        DataMap dm = DUtil.queryByJSONString(cfg, box);

        JSONObject jo = dm.data();
        JSONArray jarr = null;
        if (jo != null) {
            JSONObject o = jo.getObject(var_id);
            if (o != null) {
                jarr = o.getArray("rows");
            }
        }


        result.put(id, jarr);
    }

    out.println(result);
%>

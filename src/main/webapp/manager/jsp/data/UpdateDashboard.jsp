<%@ page import="org.apache.axis.encoding.Base64" %>
<%--
  Created by IntelliJ IDEA.
  User: gojaehag
  Date: 2015. 10. 22.
  Time: 오전 11:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/xefc/jsp/common/import.jspf" %>
<%@ include file="/xefc/jsp/include/session.jspf" %>

<%
    Box box = HttpUtility.getBox(request);

    User user = (User) session.getAttribute("egene.user");
    String empId = user.getEmpId();

    String sql_id = "";
    ICE ice = ICE.getInstance();
    Sqls sqls = ice.sqls();

    TrxContext trx = null;
    TrxResult tr = new TrxResult(0);
    Connection con = null;
    JSONObject result = new JSONObject();


    String requestBody = null;
    StringBuilder sb = new StringBuilder();

    trx = new TrxContext(sqls.getDbName(sql_id));
    con = trx.getConnection();
    trx.begin();

    try {

        InputStream inputStream = request.getInputStream();
        if (inputStream != null) {
            BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));
            char[] charBuffer = new char[128];
            int bytesRead = -1;
            while ((bytesRead = reader.read(charBuffer)) > 0) {
                sb.append(charBuffer, 0, bytesRead);
            }
        }

        requestBody = sb.toString();

        JSONObject params = (JSONObject) JSONValue.parse(requestBody);

        Log.act.debug(params.toString());
        //-----------------------------
        // dashbard 정보 업데이트
        //-----------------------------
        Box dashboard = convertJSONToBox((JSONObject) params.get("dashboard"));
        dashboard.put("reg_emp_id", empId);
        dashboard.put("mod_emp_id", empId);

        String updateType = dashboard.get("updateType");

        Log.act.debug("---------------------");
        Log.act.debug(updateType);

        if (updateType.equals("n")) {
            sql_id = "SSD5.SMBoards.Insert";
        } else if (updateType.equals("o")) {
            sql_id = "SSD5.SMBoards.Update";
        }

        tr = sqls.execute(con, sql_id, dashboard);

        // Widget Component 정보
        JSONObject widgetComponents = (JSONObject) params.get("widgetComponents");
        JSONArray insertList = (JSONArray) widgetComponents.get("insertList");
        JSONArray updateList = (JSONArray) widgetComponents.get("updateList");
        JSONArray deleteList = (JSONArray) widgetComponents.get("deleteList");


        int i = 0, size = 0;
        // Widget Component 등록
        sql_id = "SSD5.Component.Insert";
        for (i = 0, size = insertList.size(); i < size; i++) {
            Box component = convertJSONToBox((JSONObject) insertList.get(i));
            tr = sqls.execute(con, sql_id, component);
        }

        // Widget Component 업데이트
        sql_id = "SSD5.Component.Update";
        for (i = 0, size = updateList.size(); i < size; i++) {
            Box component = convertJSONToBox((JSONObject) updateList.get(i));
            tr = sqls.execute(con, sql_id, component);
        }

        // Widget Component 삭제
        sql_id = "SSD5.Component.Delete";
        for (i = 0, size = deleteList.size(); i < size; i++) {
            Box component = convertJSONToBox((JSONObject) deleteList.get(i));
            tr = sqls.execute(con, sql_id, component);
        }

        JSONObject dataMaps = (JSONObject) params.get("dataMaps");
        JSONArray insertDataMaps = (JSONArray) dataMaps.get("insertList");
        JSONArray updateDataMaps = (JSONArray) dataMaps.get("updateList");
        JSONArray deleteDataMaps = (JSONArray) dataMaps.get("deleteList");

        // Dashboard DataMap 등록
        sql_id = "SSD5.SMB.DataMap.Insert";
        for (i = 0, size = insertDataMaps.size(); i < size; i++) {
            Box newMapping = convertJSONToBox((JSONObject) insertDataMaps.get(i));
            tr = sqls.execute(con, sql_id, newMapping);
        }

        // Dashboard DataMap 삭제
        sql_id = "SSD5.SMB.DataMap.Delete";
        for (i = 0, size = deleteDataMaps.size(); i < size; i++) {
            Box delMapping = convertJSONToBox((JSONObject) deleteDataMaps.get(i));
            tr = sqls.execute(con, sql_id, delMapping);
        }

        trx.commit();

        result.put("state", "success");

    } catch (SQLException e) {
        trx.rollback();
        Log.sql.err("SQL[" + sql_id + "] " + box, e);

        result.put("state", "fail");
        result.put("message", e.getMessage());
        trx.rollback();
    } catch (Exception e) {
        trx.rollback();
        Log.sql.err("SQL[" + sql_id + "] " + box, e);

        result.put("result", "fail");
        result.put("message", e.getMessage());
        trx.rollback();
    } finally {
        try {
            trx.close();
        } catch (Exception e) {
            Log.dbg.debug(e.getMessage());  /* 20150921-Logger */
        }
    }

    out.println(result.toString());
%>

<%!

    public Box convertJSONToBox(JSONObject obj) {
        Box box = new Box("box");
        if (obj != null) {
            Iterator<String> keys = obj.keySet().iterator();
            while (keys.hasNext()) {
                String key = keys.next();
                box.put(key, obj.get(key));
                Log.act.debug(key + " : " + obj.get(key));
            }
        }
        return box;
    }

    /**
     * '"' 를 &quot; 로 변환
     *
     * @param strString
     * @return String
     */
    public static String convert2QUOT(String strString) {
        if (isBlank(strString)) {
            return "";
        }

        return replace(strString, "\"", "&quot;");
    }

    /**
     * '&quot;'를 '\"'로 변환
     *
     * @param strString
     *            변환할 문자열
     * @return 변화된 문자열
     */
    public static String reverse2QUOT(String strString) {
        if (isBlank(strString)) {
            return "";
        }

        return replace(strString, "&quot;", "\"");
    }

    /**
     * String의 Blank여부 체크
     *
     * @param tmpString
     * @return null, "" 일 경우 true, null이 아니며, Blank String일 경우 false
     */
    public static boolean isBlank(String tmpString) {
        if (tmpString == null) {
            return true;
        }
        if ("".equals(tmpString)) {
            return true;
        }

        return false;
    }

    /**
     * 특정문자를 변환한다.
     *
     * @param source
     *            source 문자열
     * @param pattern
     *            바꿀 문자패턴
     * @param replace
     *            적용할 문자패턴
     * @return 변환된 문자
     */
    public static String replace(String source, String pattern, String replace) {
        if (source != null) {
            final int len = pattern.length();
            StringBuffer sb = new StringBuffer();
            int found = -1;
            int start = 0;

            while ((found = source.indexOf(pattern, start)) != -1) {
                sb.append(source.substring(start, found));
                sb.append(replace);
                start = found + len;
            }

            sb.append(source.substring(start));

            return sb.toString();
        }

        return "";
    }


%>

<%--
  Created by IntelliJ IDEA.
  User: gojaehag
  Date: 2015. 10. 14.
  Time: 오후 5:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/xefc/jsp/common/import.jspf" %>
<%
    // Request Wrapper Object
    Box box = HttpUtility.getBox(request);
    // 파라미터로 전달된 sql_id를 가져온다.
    String sqlId = box.get("sql_id");
    // sql id를 이용하여 디비 조회를 수행.
    DataMap dm = DUtil.queryByStrings(sqlId, box);
    // 데이터맵에서 조회한 결과를 sql id를 이용하여 가져온다.
    RecordSet rs1 = dm.rs(sqlId);
    // 조회한 결과를 JSON으로 변환한다.
    JSONObject result = convertRecordSetToJSON(rs1);
    // JSON으로 변환한 결과 null 처리
    if (result == null) result = new JSONObject();
    // 조회 결과를 문자열로 리턴한다.
    out.println(result.toString());
%>

<%!
    /**
     * 인자로 받은 RecordSet을 문자열로 변환한다.
     * RecordSet의 개수에 상관없이 첫번째 row를 JSON으로 변환하여 리턴한다.
     * @param rs
     * @return
     */
    JSONObject convertRecordSetToJSON(RecordSet rs) {
        // RecordSet의 결과를 담을 JSON Object
        JSONObject obj = new JSONObject();
        // start converting JSON
        if (rs.next()) {
            // RecordSet에서 조회한 컬럼 목록을 가져온다.
            String[] columnNames = rs.getColumnNames();
            // 컬럼의 개수만큼 반복문 수행
            for (int i = 0; i < columnNames.length; i++) {
                // column name
                String name = columnNames[i];
                // put column value
                obj.put(name.toLowerCase(), rs.get(name));
            }
        }
        return obj;
    }
%>
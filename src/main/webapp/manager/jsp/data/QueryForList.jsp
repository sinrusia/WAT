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
    DataMap dm = DUtil.queryByStrings(sqlId + ":" + sqlId, box);
    // 데이터맵에서 조회한 결과를 sql id를 이용하여 가져온다.
    RecordSet rs1 = dm.rs(sqlId);
    // 조회한 결과를 JSON으로 변환한다.
    JSONArray result = convertRecordSetToJSON(rs1);
    // JSON으로 변환한 결과 null 처리
    if (result == null) result = new JSONArray();
    // 조회 결과를 문자열로 리턴한다.
    out.println(result.toString());
%>

<%!
    /**
     * 인자로 받은 RecordSet 데이터를 JSON으로 변환
     * @param rs
     * @return
     */
    JSONArray convertRecordSetToJSON(RecordSet rs) {
        // RecordSet 결과를 담을 JSONArray
        JSONArray array = new JSONArray();
        // 조회한 결과의 컬럼 목록
        String[] columnNames = rs.getColumnNames();
        // 조회한 결과만큼 변환 수행
        while (rs.next()) {
            // RecordSet 한 Row를 담을 JSONObject
            JSONObject obj = new JSONObject();
            // 컬럼수만큼 반복 수행
            for (int i = 0; i < columnNames.length; i++) {
                // 컬럼 이름
                String name = columnNames[i];
                // put column value
                obj.put(name.toLowerCase(), rs.get(name));
            }
            array.add(obj);
        }
        return array;
    }
%>
<%@ page contentType="text/html; charset=utf-8"  %>
<%@ include file="/xefc/jsp/common/import.jspf" %>
<%
  Box box = HttpUtility.getBox(request);
  String dam_id = box.get("dam_id");
  DataMap dcfg = DUtil.queryByStrings("dm1:SSD5.DataMaps.RO", box);
  RecordSet rs = dcfg.rs("dm1");
  rs.next();
  String cfg = rs.get("dam_config");
  Log.biz.info("CFG:"+cfg + ":" + box);
	if(!StringUtil.valid(cfg)){
%>
		{}
<%	return;
	}
	
	
	DataMap dm = DUtil.queryByJSONString(cfg,box);
	
	out.println(dm.toJSONString());	
/*
--------------------------------------------------
-- Config 
--------------------------------------------------
--  type : int | double | String | boolean | 
--         array-int | array-double | array
--------------------------------------------------
[
 {  "id":"data1", "sql_id":"SSD5.DM.S001", 
    "cols":[
      { "name":"yy", "type":"string"}, { "name":"c02", "type":"int"}, { "name":"c03", "type":"double"}, { "name":"c04", "type":"int"}, { "name":"c05", "type":"array-int"}
    ]
 } 
] 

--------------------------------------------------
-- data 
--------------------------------------------------
{
    "data1": {
        "curpage": 0,
        "total": 6,
        "errorMessage": "",
        "pagesize": 0,
        "count": 6,
        "error": false,
        "page": false,
        "rows": [
            {
                "c05": [
                    1,
                    2,
                    3,
                    4
                ],
                "c04": 11,
                "c03": 20,
                "c02": 10,
                "yy": "2011"
            },
            {
                "c05": [
                    4,
                    5,
                    6,
                    1
                ],
                "c04": 20,
                "c03": 10,
                "c02": 25,
                "yy": "2012"
            },
            {
                "c05": [
                    22,
                    33,
                    11,
                    22
                ],
                "c04": 11,
                "c03": 5,
                "c02": 35,
                "yy": "2013"
            },
            {
                "c05": [],
                "c04": 22,
                "c03": 22,
                "c02": 25,
                "yy": "2014"
            },
            {
                "c05": [],
                "c04": 44,
                "c03": 33,
                "c02": 15,
                "yy": "2015"
            },
            {
                "c05": [],
                "c04": 22,
                "c03": 11,
                "c02": 20,
                "yy": "2016"
            }
        ]
    }
}
	*/
%>

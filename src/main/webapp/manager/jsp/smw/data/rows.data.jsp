<%@ page contentType="text/html; charset=utf-8"  %>
<%@ include file="/xefc/jsp/common/import.jspf" %>
<%
	Box box = HttpUtility.getBox(request);
	String dam_id = box.get("dam_id");
	String var_id = box.get("var_id");
	if(!StringUtil.valid(var_id)) var_id = "data1";
	DataMap dcfg = DUtil.queryByStrings("dm1:SSD5.DataMaps.RO", box);
	RecordSet rs = dcfg.rs("dm1");
	rs.next();
	String cfg = rs.get("dam_config");

	if(!StringUtil.valid(cfg)){
		out.println("[]");
		return;
	}

	DataMap dm = DUtil.queryByJSONString(cfg,box);
	
	JSONObject jo = dm.data();
	JSONArray jarr = null;
	if(jo!=null){
		JSONObject o = jo.getObject(var_id);
		if(o != null){
			jarr = o.getArray("rows");
		}
	}

	if(jarr !=null){
		out.println(jarr);
	}else{
		out.println("[]");
	}

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
[
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
*/
%>

<%@ page contentType="text/html; charset=utf-8"  %>
<%@ include file="/xefc/jsp/common/import.jspf" %>
<%
  Box box = HttpUtility.getBox(request);
  
   
  String wit_id = box.get("wit_id");
  String dam_id = box.get("dam_id");
  DataMap dcfg = DUtil.queryByStrings("dm1:SSD5.DataMaps.RO,dm2:SSD5.WItems.RO", box);
  RecordSet rs = dcfg.rs("dm1");
  rs.next();
  String cfg = rs.get("dam_config");
  
	if(!StringUtil.valid(cfg)){
%>
    cfg invalid.
<%	return;
	}
	
  rs = dcfg.rs("dm2");
  rs.next();
  String wit_cfg = rs.get("wit_config");
  JSONObject jo = null;
  JSONArray fields = null;
  try{
    jo = (JSONObject) JSONValue.parse(wit_cfg);
    if(jo!=null){
      fields = jo.getArray("fields");
    }
  }catch(Exception e){
     Log.dbg.debug(e.getMessage());  /* 20150921-Logger */ 
  }
  
  if(fields == null || fields.size() == 0){
%>
     WidgetItem config invalid.
<%
    return;
  }
	
  int fsize = fields.size();
	DataMap dm = DUtil.queryByJSONString(cfg,box);
  RecordSet d_rs = dm.rs("data1");
%>
<table class="table table-bordered" style="margin-bottom: 5px; ">
<thead>
<tr style="background-color: #2a91d8; ">
<% 

  for(int i=0; i <fsize; i++){
    JSONObject fo = (JSONObject) fields.get(i);
    String name = fo.getString("name");
    int width = fo.getInt("width");
    String alias = fo.getString("alias");
%>
<th style="text-align: center;width:<%= width %>px;"><%= alias %></th>
<%
  }
%>  
</tr>
</thead>
<tbody>
<%
  for(int i=0; d_rs.next(); i++){
%>
<tr>
<%  
    for(int j=0; j<fsize; j++){
      JSONObject fo = (JSONObject) fields.get(j);
      String name = fo.getString("name");
      int width = fo.getInt("width");
      String alias = fo.getString("alias");
      String v = d_rs.get(name);
%>
<td><%= v %></td>
<% 
    }
%>
</tr>
<%    
  } %>  
</tbody>
</table>
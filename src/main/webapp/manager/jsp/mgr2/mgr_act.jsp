<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/xssd5/jsp/common/import.jspf" %><%@ include file="/xssd5/jsp/common/session.jspf" %>
<%
	Box box = HttpUtility.getBox(request);
	box.restore();
	
	Log.biz.info("Types Act:" +box);
	String act = box.get("act");
	String mode = box.get("mode");
	String id = box.get("id");
	String type = box.get("type");
	
	boolean rf_mode = false;
	boolean mp_mode = false;
	if(act.equals("SAVE_TYPE")){
		ICE ice = ICE.getInstance();
		Sqls sqls = ice.sqls();

		if(mode.equals("1")){
			sqls.execute("SSD.Type.Insert", box);
		}else{
			sqls.execute("SSD.Type.Update", box);
		}
		Widgets wgts = Widgets.getInstance();
		wgts.initTypes(type);
		rf_mode = true;
		
		
		if(type.equals("DSNAME")){
			if(box.get("typ_cat_cd").equals("SAP")){
				String name = box.get("typ_value");
				String cfg = box.get("typ_config");
				
				
				com.steg.ssd.sap.SDestinationDataProvider provider = com.steg.ssd.sap.SAPProviders.getProvider();
				provider.setServerInfo(name, cfg);
			}
		}else if(type.equals("SYSTEM")){
			mp_mode = true;
			rf_mode = false;
		}
		
	}else if(act.equals("SAVE_TEMPL")){
		ICE ice = ICE.getInstance();
		Sqls sqls = ice.sqls();

		if(mode.equals("1")){
			sqls.execute("SSD.TypeTempl.Insert", box);
		}else{
			sqls.execute("SSD.TypeTempl.Update", box);
		}
		rf_mode = true;
	}else if(act.equals("SAVE_MENU")){
		ICE ice = ICE.getInstance();
		Sqls sqls = ice.sqls();

		if(mode.equals("1")){
			sqls.execute("SSD.Menu.Insert", box);
		}else{
			sqls.execute("SSD.Menu.Update", box);
		}
		rf_mode = true;
		
	}else if(act.equals("DEL_MENU")){
		ICE ice = ICE.getInstance();
		Sqls sqls = ice.sqls();

		sqls.execute("SSD.Menu.Delete", box);
		rf_mode = true;
		
	}else if(act.equals("DEL_TYPE")){
		ICE ice = ICE.getInstance();
		Sqls sqls = ice.sqls();
		if(type.equals("SYSTEM")){
			sqls.executeArray("SSD.Type.DeleteWithMenu", box);
			mp_mode = true;
		}else{
			sqls.execute("SSD.Type.Delete", box);
		}
		rf_mode = true;
	}else if(act.equals("DEL_TEMPL")){
		ICE ice = ICE.getInstance();
		Sqls sqls = ice.sqls();
		
		sqls.execute("SSD.TypeTempl.Delete", box);
		
		rf_mode = true;
	}else if(act.equals("DEL_WIDGET")){
		ICE ice = ICE.getInstance();
		Sqls sqls = ice.sqls();
		
		sqls.executeArray("SSD.Widget.DeleteWithAllChild", box);
		
		rf_mode = true;
	}else if(act.equals("SAVE_SHOW")){
		ICE ice = ICE.getInstance();
		Sqls sqls = ice.sqls();
		TrxSqls tsqls = sqls.getTrxSqls();
		tsqls.begin();
		
		if(mode.equals("1")){
			tsqls.execute("SSD.Show.Insert", box);
			
		}else{
			tsqls.execute("SSD.Show.Update", box);
		}
		
		tsqls.execute("SSD.Show.Item.Delete", box);
		tsqls.executeBatch("SSD.Show.Item.Insert", box);
		tsqls.commit();

		
		rf_mode = true;
		
	}else if(act.equals("DEL_SHOW")){
		ICE ice = ICE.getInstance();
		Sqls sqls = ice.sqls();
		
		sqls.executeArray("SSD.Show.DeleteWithAllChild", box);
		rf_mode = true;
		
	}else if(act.equals("SAVE_JSON")){
		ICE ice = ICE.getInstance();
		Sqls sqls = ice.sqls();

		if(mode.equals("1")){
			sqls.execute("SSD.Json.Insert", box);
		}else{
			sqls.execute("SSD.Json.Update", box);
		}

		Jsons jsons = Jsons.getInstance();
		jsons.sync();

		rf_mode = true;
	}else if(act.equals("DEL_JSON")){
		ICE ice = ICE.getInstance();
		Sqls sqls = ice.sqls();
		
		sqls.execute("SSD.Json.Delete", box);
		rf_mode = true;
	}else if(act.equals("SAVE_DATAMAP")){
		ICE ice = ICE.getInstance();
		Sqls sqls = ice.sqls();
		
		if(mode.equals("1")){
			sqls.execute("SSD5.Datamaps.Insert", box);
		}else{
			sqls.execute("SSD5.Datamaps.Update", box);
		}
		rf_mode = true;
	}else if(act.equals("DEL_SMBOARD")){
		ICE ice = ICE.getInstance();
		Sqls sqls = ice.sqls();
		
		sqls.execute("SSD5.SMBoards.Delete", box);
		rf_mode = true;
	}else if(act.equals("DEL_DATAMAP")){
		ICE ice = ICE.getInstance();
		Sqls sqls = ice.sqls();
		
		sqls.execute("SSD5.Datamap.Delete", box);
		rf_mode = true;
	}
	
	
%>
<script language=javascript>
	<% if(rf_mode){	%> doRefresh(); <% }	%>
	<% if(mp_mode){	%> getSystems(); <% }	%>
	
</script>
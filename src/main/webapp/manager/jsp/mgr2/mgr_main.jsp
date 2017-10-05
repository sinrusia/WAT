<%@ page contentType="text/html; charset=utf-8"  %>
<%@ include file="/xssd5/jsp/common/import.jspf" %><%@ include file="/xssd5/jsp/common/session.jspf" %>
<%
  Box box = HttpUtility.getBox(request);
	com.steg.efc.Texts texts = com.steg.efc.Texts.getInstance();
%>	
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>e-Gene SSD System Console</title>
<link href="/xssd5/jsp/mgr2/css/default.css" rel="stylesheet" type="text/css">
<link href="/xssd5/jsp/mgr2/css/mgr.css" rel="stylesheet" type="text/css">
<link href="/xssd5/jsp/mgr2/css/dialog.css" rel="stylesheet" type="text/css">
<link href="/xefc/css/ui_stab.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="/xefc/script/prototype.js"></script> 
<script type="text/javascript" src="/xefc/script/core.js"></script>
<script type="text/javascript" src="/xefc/script/common.js"></script>
<script type="text/javascript" src="/xssd5/jsp/mgr2/script/dialog.js"></script>


</head>
<body style='' >
<table cellspacing=0 cellpadding=0 width=100% >
<tr><td height=80 style='background:url(/xssd5/jsp/mgr2/images/mgr/console_bg.gif) no-repeat' align=right valign=bottom>
		<div style='padding:5px;'><img src='/xssd5/jsp/mgr2/images/icon/reset.png' align=absmiddle onclick="doReset();" style='cursor:hand;cursor:pointer;'></div>
	</td></tr>
<tr>
    <td>

		<table cellspacing=5 cellpadding=0 class=layout >
			<col width=350>
			<col >
		<tr height=680>
			<td valign=top class=border >
				
				<div class=item_fix>
					<div class=title><img src='/xssd5/jsp/mgr2/images/mgr/item.gif' align=absmiddle> Menu </div>
					<div class=ctt >
						
						<div id=menu_pane  style='height:300px;overflow-y:scroll;'></div>
						
					</div>
				</div>
<%
		for(int i=0; i<mgr_items[0].length; i++){
			String id = mgr_items[0][i];
			String nm = mgr_items[1][i];
			String jsp = mgr_items[2][i];
			if(mgr_items[3][i].equals("disable")){
%>
				<div class=item_disable >
					<div class=title ><img src='/xssd5/jsp/mgr2/images/mgr/item.gif' align=absmiddle> <%= nm %> </div>
				</div>

<%			
			}else{
%>		
				<div class=item >
					<div class=title onclick="selMgrItem(this,'<%= id %>','<%= nm %>','<%= jsp %>')"><img src='/xssd5/jsp/mgr2/images/mgr/item.gif' align=absmiddle> <%= nm %> </div>
				</div>
<%
			}
		}
%>						
			
				
				<div class=item_fix>
					<div class=ctt1 style='height:91px;overflow-y:scroll;'></div>
				</div>
				
			</td>        
			<td valign=top class=border>
				<div class=item_fix>
					<div class=title><img src='/xssd5/jsp/mgr2/images/mgr/item.gif' align=absmiddle> <span id=mgr_title> SSD System Console </span></div>
					<div class=ctt >
						<div id=mgr_pane style='height:640px;overflow-y:scroll;'>
						<img src='/xssd5/jsp/mgr2/images/mgr/content.png	'>
						</div>
					</div>
				</div>
				
			</td>
			
		</tr>
		</table>
    	
    </td>
</tr>
</table>

<div id=mgr_act style='display:;width:500px;height:100px;border:1px solid #aaaaaa;display:none;'></div>        
  
<script language=javascript>
var cur_mgr_obj='';
var cur_mgr_id='';
var cur_mgr_uri='';
var cur_system='';
selMgrItem = function(o, id,nm,uri){
	o = o.parentNode;
	blurCurObj();
	o.className = 'item_sel';
	cur_mgr_obj = o;
	cur_mgr_id = id;
	var t_o = $('mgr_title');
	if(t_o) t_o.innerHTML = nm;
	cur_mgr_uri = uri;
	getContents('mgr_pane',uri,'', '', false);
}

blurCurObj = function(){
	if(cur_mgr_obj) cur_mgr_obj.className = 'item';
	
}
	

getSystems = function(){
	
	var uri = 'menu.jsp';
	
	getContents('menu_pane',uri,'', '', false);
}

getMenus = function(system,nm){
	cur_system = system;
	var uri = 'menu1.jsp';
	var params = 'system=' + system;
	blurCurObj();
	
	var t_o = $('mgr_title');
	if(t_o) t_o.innerHTML = 'Menu [ '+ system+' : ' +nm + ' ]';
	
	cur_mgr_uri = uri + "?" + params;
	
	getContents('mgr_pane',cur_mgr_uri, '', false);
}

searchMenus = function(){
	var params = Forms.serialize(document.frm_menus);
	var uri = 'menu1.jsp';
	params += '&system=' + cur_system;
	
	cur_mgr_uri = uri + "?" + params;
	//alert(cur_mgr_uri);
	getContents('mgr_pane',cur_mgr_uri,'', '', false);
}

getTypeTemplates = function(){
	var params = Forms.serialize(document.frm_temps);
	var uri = 'templs.jsp';
	cur_mgr_uri = uri + "?" + params;
	getContents('mgr_pane',cur_mgr_uri,'', '', false);
}

getWidgets = function(){
	
	
	var params = Forms.serialize(document.frm_widgets);
	var uri = 'widgets.jsp';
	cur_mgr_uri = uri + "?" + params;
	getContents('mgr_pane',cur_mgr_uri,'', '', false);
}

getJsons = function(){
	var params = Forms.serialize(document.frm_jsons);
	var uri = 'jsons.jsp';
	cur_mgr_uri = uri + "?" + params;
	getContents('mgr_pane',cur_mgr_uri,'', '', false);
}


getSMBoards = function(){
	var params = Forms.serialize(document.frm_1);
	var uri = 'smboards.jsp';
	cur_mgr_uri = uri + "?" + params;
	getContents('mgr_pane',cur_mgr_uri,'', '', false);
}

getDatamaps = function(){
	var params = Forms.serialize(document.frm_1);
	var uri = 'datamaps.jsp';
	cur_mgr_uri = uri + "?" + params;
	getContents('mgr_pane',cur_mgr_uri,'', '', false);
}

				
var dialog = new sui.Dialog();
showTypeDetail = function(id, type, name){
	var uri = 'types_detail.jsp';
	var params = 'id=' + id + "&type=" + type ;
	//alert(params);
	var title = '';
	if(name) title = '[' + name + '] Detail';
	else title = 'Type Detail';
    
	dialog.show(uri,params,700, 500, title);
}



showTemplDetail = function(id){
	var uri = 'templ_detail.jsp';
	var params = 'id=' + id  ;
	//alert(params);
	dialog.show(uri,params,1000, 400, 'Template Detail');
}

showWidgetWizard = function(id){
		var uri = '/xssd5/jsp/wizard/wizard.jsp?wgt_id='+id;
		var w = 1200;
		var h = 840;
		
		var win = window.open(uri,"_ssd_wwizard","width="+w+",height="+h+",resizable=1,scrollbars=1,menubar=0,status=0,location=0,titlebar=0,toolbar=0,directories=0");
		win.focus();
	
}

showMenuDetail1 = function(id,system){
	if(!system) system = "";
	var uri = 'menu1_detail.jsp';
	var params = 'id=' + id +"&system=" + system+"&lev=1" ;
	//alert(params);
	dialog.show(uri,params,600, 200, 'Menu Detail');
}

showMenuDetail2 = function(id,system,p_id){
	if(!p_id) p_id = "";
	if(!system) system = "";
	var uri = 'menu2_detail.jsp';
	var params = 'id=' + id +"&system=" + system+"&p_id=" + p_id  + "&lev=2";
	//alert(params);
	dialog.show(uri,params,600, 300, 'Menu Detail');
}

showShowDetail = function(id){
	var uri = 'shows_detail.jsp';
	var params = 'shw_id=' + id  ;
	//alert(params);
	dialog.show(uri,params,1000, 450, 'SlideShow Detail');
}

showJsonDetail = function(id){
	var uri = 'json_detail.jsp';
	var params = 'json_id=' + id  ;
	//alert(params);
	dialog.show(uri,params,1000, 450, 'JSON Definition Detail');
}

showSMBoardWizard = function(id){
		var uri = '/xssd5/jsp/dashboard-wizard/index.jsp?smb_id='+id;
		var w = 1280;
		var h = 840;
		
		var win = window.open(uri,"_smbw" + id,"width="+w+",height="+h+",resizable=1,scrollbars=1,menubar=0,status=0,location=0,titlebar=0,toolbar=0,directories=0");
		win.focus();
	
}

showDatamapDetail = function(id){
	var uri = 'datamap_detail.jsp';
	var params = 'dam_id=' + id  ;
	//alert(params);
	dialog.show(uri,params,1000, 450, 'Datamap Definition Detail');
}



showURL = function(uri){
		
		var w = 1200;
		var h = 750;
		var win = window.open(uri,"_men_uri","width="+w+",height="+h+",resizable=1,scrollbars=1,menubar=0,status=0,location=0,titlebar=0,toolbar=0,directories=0");
		win.focus();
	
}

doSaveType = function(){
	dialog.hide();
	var params = Forms.serialize(document.frm_type);
	doAct('SAVE_TYPE', params);
	
}

doSaveTempl = function(){
	dialog.hide();
	var params = Forms.serialize(document.frm_templ);
	doAct('SAVE_TEMPL', params);
	
}

doSaveMenu1 = function(){
	var frm = document.frm_menu;
	var msg = ''
	if(!frm.men_name.value){
		msg = 'Name을 입력하세요.';
		alert(msg);
		frm.men_name.focus();
		return;
	};
	if(!frm.men_system.value){
		msg = 'System을 선택하세요.';
		alert(msg);
		frm.men_system.focus();
		return;
	}
	
	var params = Forms.serialize(document.frm_menu);
	doAct('SAVE_MENU', params);
	dialog.hide();
	
}

doSaveMenu2 = function(){
	var frm = document.frm_menu;
	var msg = '';
	if(!frm.men_name.value){
		msg = 'Name을 입력하세요.';
		alert(msg);
		frm.men_name.focus();
		return;
	}
	if(!frm.men_system.value){
		msg = 'System을 선택하세요.';
		alert(msg);
		frm.men_system.focus();
		return;
	}
	if(!frm.men_pid.value){
		msg = '상위메뉴를 선택하세요.';
		alert(msg);
		frm.men_pid.focus();
		return;
	}
	var params = Forms.serialize(document.frm_menu);
	
	doAct('SAVE_MENU', params);
	dialog.hide();
	
}

doSaveShow = function(){
	dialog.hide();
	var params = Forms.serialize(document.frm_show);
	doAct('SAVE_SHOW', params);
	
}

doSaveJson = function(){
	dialog.hide();
	var params = Forms.serialize(document.frm_json);
	doAct('SAVE_JSON', params);
	
}


doSaveDatamap = function(){
	dialog.hide();
	var params = Forms.serialize(document.frm_1);
	doAct('SAVE_DATAMAP', params);
	
}


delType = function(id, type, val){
	var msg = "["+ val + "]를 삭제하시겠습니까?";
	if(confirm(msg)){
		var params = "typ_id=" + id + "&type=" + type + "&typ_value=" + val;
		doAct('DEL_TYPE', params);
	}
}

delMenu = function(id, name){
	var msg = "["+ id + "/" + name + "]를 삭제하시겠습니까?";
	if(confirm(msg)){
		var params = "men_id=" + id ;
		doAct('DEL_MENU', params);
	}
}

delTempl = function(id, name){
	var msg = "["+ id + "/" + name + "]를 삭제하시겠습니까?";
	if(confirm(msg)){
		var params = "wit_id=" + id ;
		doAct('DEL_TEMPL', params);
	}
}

delShow = function(id, name){
	var msg = "["+ id + "/" +  name + "]를 삭제하시겠습니까?";
	if(confirm(msg)){
		var params = "shw_id=" + id ;
		doAct('DEL_SHOW', params);
	}
}

delJson = function(id, name){
	var msg = "["+ id + "/" +  name + "]를 삭제하시겠습니까?";
	if(confirm(msg)){
		var params = "json_id=" + id ;
		doAct('DEL_JSON', params);
	}
}


delWidget = function(id, name){
	var msg = "["+ name + "]를 삭제하시겠습니까?";
	if(confirm(msg)){
		var params = "wgt_id=" + id ;
		doAct('DEL_WIDGET', params);
	}
}

delSMBoard = function(id, name){
	var msg = "["+ name + "]를 삭제하시겠습니까?";
	if(confirm(msg)){
		var params = "smb_id=" + id ;
		doAct('DEL_SMBOARD', params);
	}
}

delDatamap = function(id, name){
	var msg = "["+ name + "]를 삭제하시겠습니까?";
	if(confirm(msg)){
		var params = "dam_id=" + id ;
		doAct('DEL_DATAMAP', params);
	}
}

doAct = function(act, params){
	var uri = "mgr_act.jsp";
	params = "act="+ act + "&" + params;	
	getContents("mgr_act", uri,params,'',true);
}

doSMBoardPreview = function(id){
		var uri = '/xssd5/#/board/'+ id;
		showWin(uri,'','',1200,760,'_preview'+id);	
}

doWidgetPreview = function(id){
		var uri = '/xssd5/jsp/service.jsp?wgt_id='+ id;
		showWin(uri,'','',1200,760,'_preview'+id);	
}

doPortalPreview = function(id){
		var uri = '/xssd5/jsp/portal.jsp?wgt_id='+ id;
		showWin(uri,'','',1200,760,'_preview'+id);	
}

doShowPreview = function(id){
		var uri = '/xssd5/jsp/shows_frame.jsp?shw_id='+ id;
		showWin(uri,'','',1200,760,'_pre_show'+id);	
}

doRefresh = function(){

	getContents('mgr_pane',cur_mgr_uri,'', '', false);
}

focusTr = function(obj){
	obj.className = "trd_sel";	
}

blurTr = function(obj){
	obj.className = "trd";	
}

window.onload = function(){
	getSystems();
}


doReset = function(){
		var uri = '/xssd5/jsp/reset.jsp'
		getContents('reset_div',uri,'' ,'',false);
		var o = $('reset_div');
		if(o) o.style.display = 'none';
}
	
</script>  

<div id=reset_div style='link' style='display:none;width:0;height:0'></div>
    
</body>
</html>


<%!

    String[][] mgr_items = { 
		{ "DASHBOARD", "DATAMAP", "CT.uicomponent", "uicomponent", "SSHOW", "ROLE"},
		{ "Dashboard", "Data Map", "Component Type", "Widget Component",  "Slide Show", "ROLE"},
		{ "smboards.jsp", "datamaps.jsp", "types.jsp?type=CT.uicomponent", "types.jsp?type=uicomponent",  "shows.jsp", "work.jsp"},
		{ "", "", "", "", "", "disable"},
	};
%>
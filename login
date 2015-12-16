<%--
  - ***************************************************************
  - *                           NOTICE                            *
  - *                                                             *
  - *   THIS SOFTWARE IS THE PROPERTY OF AND CONTAINS             *
  - *   CONFIDENTIAL INFORMATION OF INFOR AND/OR ITS AFFILIATES   *
  - *   OR SUBSIDIARIES AND SHALL NOT BE DISCLOSED WITHOUT PRIOR  *
  - *   WRITTEN PERMISSION. LICENSED CUSTOMERS MAY COPY AND       *
  - *   ADAPT THIS SOFTWARE FOR THEIR OWN USE IN ACCORDANCE WITH  *
  - *   THE TERMS OF THEIR SOFTWARE LICENSE AGREEMENT.            *
  - *   ALL OTHER RIGHTS RESERVED.                                *
  - *                                                             *
  - *   (c) COPYRIGHT 2015 INFOR.  ALL RIGHTS RESERVED.           *
  - *   THE WORD AND DESIGN MARKS SET FORTH HEREIN ARE            *
  - *   TRADEMARKS AND/OR REGISTERED TRADEMARKS OF INFOR          *
  - *   AND/OR ITS AFFILIATES AND SUBSIDIARIES. ALL RIGHTS        *
  - *   RESERVED.  ALL OTHER TRADEMARKS LISTED HEREIN ARE         *
  - *   THE PROPERTY OF THEIR RESPECTIVE OWNERS.                  *
  - *                                                             *
  - ***************************************************************
  --%>

<%-- 
  - $Revision: 1.55.2.1 $
  - $Author: kbernabe $   
  - $Date: 2015/10/08 06:51:10 $
  --%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%-- jsf:pagecode language="java" location="/JavaSource/pagecode/pou/touchscreen/Login.java" --%><%-- /jsf:pagecode --%>
<HTML>
<% 
	String contextpath_inc = request.getContextPath();
%>
<HEAD>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@taglib uri="http://richfaces.org/a4j" prefix="a4j"%>
<%@taglib uri="http://richfaces.org/rich" prefix="rich"%>

<f:view locale="#{userLocale.localeObject}">
<%@include file="/common/ui_jsf_includes.jsp"%>

<f:loadBundle basename="com.lawson.ma.pou.touchscreen.display.resource.ui" var="LABEL" />
<f:loadBundle basename="com.lawson.ma.pou.touchscreen.resource.TouchscreenUI" var="label"/>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<META http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<META name="GENERATOR" content="IBM Software Development Platform">
<META http-equiv="Content-Style-Type" content="text/css">
<TITLE><h:outputText value="#{LABEL['title.pouts']}"/></TITLE>
<LINK rel="stylesheet" type="text/css" href="css/stylesheet.css" title="Style">
<link type="text/css" href="<%=contextpath_inc%>/css/inforControlsCombined-3.2.css" rel="stylesheet" media="all" />
<SCRIPT type="text/javascript" src="scripts/caret.js"></SCRIPT>
<SCRIPT type="text/javascript" src="scripts/position.js"></SCRIPT>
<SCRIPT type="text/javascript" src="scripts/vkboard.js"></SCRIPT>
<SCRIPT type="text/javascript" src="scripts/default.js"></SCRIPT>
<SCRIPT type="text/javascript" src="scripts/popup.js"></SCRIPT>
<SCRIPT type="text/javascript">
function getObj(objId, formId) {
    var fullId = objId;
    if (formId != null && formId.length > 0) {
        fullId = formId + ':' + objId;
    }
    var elem = null;
    if (document.getElementById) {
        elem = document.getElementById(fullId);
    } else if (document.all) {
        elem = document.all[fullId];
    } else if (document.layers) {
        elem = document.layers[fullId];
    }
    return elem;
}
var source = null;
function get_selection_length() {
	return selectionLength(source);
}   	
function get_current_position() {
   return caretPos(source);
}
function move_cursor_left() {
   cPos = get_current_position()-1;
   window.setSelectionRange(source, cPos, cPos);
}
function move_cursor_right() {
   cPos = get_current_position()+1;
   window.setSelectionRange(source, cPos, cPos);
}
function move_cursor_end() {
   window.setSelectionRange(source, source.value.length, source.value.length);
}
function select_left() {
	cPos = get_current_position();
	window.setSelectionRange(source, cPos-1, cPos);
}   	
function select_right() {
   cPos = get_current_position();
   window.setSelectionRange(source, cPos, cPos+1);
}   	
function select_all() {
	window.setSelectionRange(source, 0, source.value.length);
}  	
function replace_selection(val) {   	
	replaceSelection(source, val);
	checkFields();
}   	
function callback(char) {
   	hide_error();
   	if(char == "Backspace") {
   	    if (get_selection_length() == 0) {
   	      	select_left();   	       	          	    	        
   	    }
   		replace_selection('');     	        
   	} else if (char == "Delete") {
   	    if (get_selection_length() == 0) {
   	    	select_right();   	      
   		}
   		replace_selection('');   	  
   	} else if (char == "Space") {
   	    replace_selection(' ');
   	} else if (char == "&lt;&lt;") {
   	    move_cursor_left();   
   	} else if (char == "&gt;&gt;") {
   	    move_cursor_right();
	} else {
   	    replace_selection(char);  
   	    move_cursor_end();  	    
   	    if (get_selection_length() > 0) {
		  	move_cursor_right();		  	
   	    }
   	    if (get_current_position() == 0) {
   	      	move_cursor_right();
  		}          	
	}   	 
}   	   	
function focus_keyboard(e) {
	source = get_event_source(e);
} 	
function show_keyboard() {
	ShowVKeyboard("keyboard", "callback");
}	
function hide_error() {
	var error_msg = document.getElementById("error_msg");
	error_msg.style.visibility = "hidden";
}    
function show_error() {
	var error_msg = document.getElementById("error_msg");
	error_msg.style.visibility = "visible";
}    
function clear_input() {
	hide_error();
	source = getObj('j_password','formLogin');
	source.focus();
	select_all();
	replace_selection('');
	source = getObj('j_username','formLogin');
	source.focus();
	select_all();
	replace_selection('');
}	
function setForm(){
	source = getObj('j_username','formLogin');
	source.focus();
	setup_event(getObj('j_username','formLogin'), 'focus', focus_keyboard);
	setup_event(getObj('j_password','formLogin'), 'focus', focus_keyboard);	
	checkFields();
}	
function fullscreen() {		
  
  var oWSS = new ActiveXObject("WScript.Shell");
  var keyValue = "";
  try
  {
    keyValue = oWSS.RegRead('HKEY_CURRENT_USER\\Volatile Environment\\ViewClient_Machine_Name');
  }
  catch(err)
  {
    keyValue = "";
  }

  
	
  if (this.name!="fullscreen"){
		tsfullscreen = window.open("/mscm/faces/pou/touchscreen/login.jsp?registryKey="+keyValue,"fullscreen","fullscreen=1,toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0");	
		if (window.focus) {
			tsfullscreen.focus();
		}
		if (tsfullscreen) {
			window.opener=null;
			window.open('','_self','');
			window.close();
			//return false;
		}			
	}
}	
function closeApplication(thisObj, thisEvent) {
     window.open('','_self','');
     window.close();
}	
function checkFields() {
	// [kristinef] BUG 6633. Add changeLoginStyle()
	if ((getObj('j_username','formLogin').value.length > 0) && (getObj('j_password','formLogin').value.length > 0) ) {				
		disableField('btnLogOn', 'formLogin', false);
		changeLoginStyle(false);
	} else if ((getObj('j_username','formLogin').value.length == 0) && (getObj('j_password','formLogin').value.length > 0) ) {				
		disableField('btnLogOn', 'formLogin', true);		    	
		changeLoginStyle(true);
    } else {		
		disableField('btnLogOn', 'formLogin', true);
		changeLoginStyle(true);
    }
	checkCase('j_username');
}
function checkCase() {
    // [gwade] Check to see if User ID is numeric 2nd through 6th places
    if ((getObj('j_username','formLogin').value.length > 0)) {
		if (isNaN(('j_username'.substring(1,5)), false)) {
		capitalizeFirstLetter('j_username');
		}
	}
}
function capitalizeFirstLetter(string) {
    // [gwade] Convert lower case to UPPER Case ()
    var string1 = 'j_username';
    return string1.charAt(0).toUpperCase() + string1.slice(1);
}
function removeErrMsg() {
	// [14286] BUG 6374 901.1.1 START		
	if ( (getObj('errorMsg', 'formLogin') != null) && (getObj('errorMsg', 'formLogin').innerText.length > 0) ) {
		getObj('errorMsg', 'formLogin').innerText = "";
	}
	// [14286] BUG 6374 901.1.1 END	*
}
function disableField(objId, formId, isEnabled) {
	getObj(objId, formId).disabled = isEnabled;
}	
// [kristinef] BUG 6633 START
function changeLoginStyle(isEnabled) {
	getObj('btnLogOn', 'formLogin').className ="commandExButtonPouLoginPressed";
	if (isEnabled == true) {
		getObj('btnLogOn', 'formLogin').className ="commandExButtonPouLoginDisabled";
	} else {	
		getObj('btnLogOn', 'formLogin').className ="commandExButtonPouLogin";
	}
}
// [kristinef] BUG 6633 END
function checkWorkstation() {
	getObj('j_username','formLogin').focus();
	var enableFlg = getObj('txtEnableLogin', 'formLogin').value;
	if ('false' == enableFlg) {
		disableField('j_username', 'formLogin', true);
		disableField('j_password', 'formLogin', true);
		disableField('btnLogOn', 'formLogin', true);
	}
}
function disableLogon(thisObj, thisEvent) {
	getObj("btnLogOn", "formLogin").disabled = true;
}
function enableLogon(thisObj, thisEvent) {	
	getObj("btnLogOn", "formLogin").disabled = false;	
}

function resetPage() {	
	source = getObj('j_username','formLogin');
	source.focus();
	setup_event(getObj('j_username','formLogin'), 'focus', focus_keyboard);
	setup_event(getObj('j_password','formLogin'), 'focus', focus_keyboard);		
}

</SCRIPT>
<STYLE>
	body{
		margin:auto !important;
	}
	.inforTouchscreenTextBox{
		border-radius: 3px;
		border: 1px solid #b3b3b3;
		width: 170px;	
		vertical-align: top;
		margin-top: 1px;
		margin-bottom: 1px;
		margin-left: 5px;
		color: #000000;
		font-family: "Segoe UI", Tahoma, Verdana, Arial, Helvetica, sans-serif;
		font-weight: normal;
		font-size: 16px;
		height: 28px;
		display: inline;
	}
	.inforTouchscreenTextBox:focus{
		border-radius: 3px;
		border: 1px solid #13a3f7;
		width: 170px;	
		vertical-align: top;
		margin-top: 1px;
		margin-bottom: 1px;
		margin-left: 5px;
		color: #000000;
		font-family: "Segoe UI", Tahoma, Verdana, Arial, Helvetica, sans-serif;
		font-weight: normal;
		font-size: 16px;
		height: 28px;
		display: inline;
	}
	.inforTouchScreenApplicationName{
		color: #686B73;
	    font-size: 1.7em;
	    top: 20px;
	}
</STYLE>
</HEAD>

	<BODY
		onload="show_keyboard(); setForm(); checkWorkstation(); fullscreen();">
			<TABLE width="800" height="600" cellpadding="0"
				cellspacing="0" align="center">
				<TR>
					<TD align="right">
						<div  style="padding-top:20px;" >
							<h:commandButton
									type="submit" id="btnClose" value=" "
									styleClass="commandExButtonPouHeader" style="margin-right: 5px"
									image="images/icon_close_17x17px.png"
									onmousedown="changeImageOnPress(this, 'images/icon_close_17x17px_pressed.png')"
									onmouseout="changeImageOnMouseOut(this, 'images/icon_close_17x17px.png')"
									action="#{pc_Touchscreen_login.doBtnCloseAction}"
									onclick="return closeApplication(this, event);">
							</h:commandButton>
						</div>
					</TD>
				</TR>
				<TR>
					<TD>
						<h:form id="formLogin">
						<INPUT type="hidden" name="j_username" id="username" />
						<INPUT type="hidden" name="j_password" id="password" />
						<INPUT type="hidden" name="mode" value="userlogin" />
						<CENTER>						
							<div style="padding-top:30px; margin-right:200px;">
							<table>
								<tr>
									<td>
										<div class="inforTouchScreenLogoTm"></div>
									</td>
									<td>
										<h:outputText styleClass="inforTouchScreenApplicationName"
										 value="#{label.POINT_OF_USE_TITLE}">
										</h:outputText>
									</td>
								</tr>
							</table> 
							</div>
							<div style="padding-top:80px;">
								<table>
									<tr>
										<td>	
											<a4j:outputPanel
												id="logusername" ajaxRendered="true">
												<h:inputText styleClass="inforTouchscreenTextBox" id="j_username" size="25"
													value="#{pc_Touchscreen_login.username}"
													onkeyup="checkFields();" onblur="removeErrMsg();">
												</h:inputText>
											</a4j:outputPanel>
											<INPUT type="hidden" name="CHK_j_username" value="STR|1|x|True|User Id">
										</td>
										<td>
											
											<a4j:outputPanel id="logpassword" ajaxRendered="true">
												<h:inputSecret styleClass="inforTouchscreenTextBox" id="j_password"
													size="25" value="#{pc_Touchscreen_login.password}"
													onkeyup="checkFields();">
												</h:inputSecret>
											</a4j:outputPanel>
										</td>
										<td>
											<a4j:commandButton type="submit" id="btnLogOn"
												value=" "
												actionListener="#{pc_Touchscreen_login.doBtnLogOnActionListener}"
												action="#{pc_Touchscreen_login.doBtnLogOnAction}"
												reRender="lblErrMsg, logusername, logpassword, btnLogOn"
												onclick="changeLoginStyle(true); this.disabled=true; showProcessIndicatorModal();"
												ondblclick="changeLoginStyle(true); this.disabled=true"
												oncomplete="setForm(); disableField('btnLogOn', 'formLogin', true); hideProcessIndicator();" 
												style='margin-right: 10px;'>
												<f:param name="paramUsername"
													value="#{pc_Touchscreen_login.username}" id="param1" />
												<f:param name="paramPassword"
													value="#{pc_Touchscreen_login.password}" id="param2" />
											</a4j:commandButton>
										</td>
									</tr>
								</table>
							<div/>
							<TABLE width="100%" cellspacing="0" cellpadding="0">
								<TR>
									<TD align="center">
									<a4j:outputPanel id="lblErrMsg" ajaxRendered="true">
										<DIV id="error_msg">
											<h:messages styleClass="errormsgpou" id="errorMsg" globalOnly="false"
												layout="list" style="errormsgpou"></h:messages>
											<h:graphicImage url="../../images/warning.gif" rendered="#{pc_Touchscreen_login.errorMessage!=''}"></h:graphicImage>
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<h:outputText styleClass="errormsgpou" id="lblErr" 
												value="#{pc_Touchscreen_login.errorMessage}">
											</h:outputText>
										</DIV>
									</a4j:outputPanel>
									</TD>
									<TD align="justify" width="100">
									<!-- [14286] BUG 6374 901.1.1 -->							
									</TD>
								</TR>
							</TABLE>
						</CENTER>
						<DIV id="divversion">
							<CENTER>
							<TABLE border="0" width="99%">
								<TR>
									<TD align="left" valign="bottom" width="40%">
									<h:inputText styleClass="inputText" id="txtEnableLogin"
											style="visibility: hidden"
											value="#{pc_Touchscreen_login.enableLogin}"></h:inputText></br>
										<SPAN class="pouVersion"><h:outputText
											styleClass="pouVersion" value="#{label.COPYRIGHT}"></h:outputText></SPAN>
									</TD>		
									<TD align="left" valign="bottom" width="20%">
										<!-- [14286] BUG 6374 901.1.1 -->
									</TD>					
									<TD align="right" valign="bottom" width="40%">
										<SPAN class="pouVersion"> <h:outputText
											styleClass="pouVersion" value="#{label.VERSION}"></h:outputText>
										&nbsp;<h:outputText styleClass="pouVersion" id="txtPouVersion"
											value="#{pc_Touchscreen_login.pouVersion}"
											style="margin-right: 5px"></h:outputText></SPAN>
									</TD>
								</TR>
							</TABLE>
							</CENTER>
						</DIV>
						<div class="divider"></div>					
						
						<DIV id="divkeyboard">
						<DIV id="keyboard" align="center"></DIV>
						</DIV>					
						</h:form>
					</TD>
				</TR>
			</TABLE>
	<jsp:include page="touchscreen_dialog.jsp" />
	</BODY>
	<%--<SCRIPT type="text/javascript">
	disableSelection(document.body) comment out to enable backspace and delete
</SCRIPT>--%>
</f:view>
</HTML>

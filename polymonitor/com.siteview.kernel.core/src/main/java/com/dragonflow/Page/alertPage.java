/*
 *
 * Created on 2014-4-20 22:12:36
 *
 * .java
 *
 * History:
 *
 */
package com.dragonflow.Page;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.Map.Entry;
import java.util.StringTokenizer;

import com.alibaba.fastjson.JSONObject;
import com.dragonflow.HTTP.HTTPRequest;
import com.dragonflow.HTTP.HTTPRequestException;
import com.dragonflow.Properties.HashMapOrdered;
import com.dragonflow.SiteView.Action;
import com.dragonflow.SiteView.MasterConfig;
import com.dragonflow.SiteView.MonitorGroup;
import com.dragonflow.SiteView.Platform;
import com.dragonflow.SiteView.SiteViewGroup;
import com.dragonflow.Utils.TextUtils;

import jgl.Array;
import jgl.HashMap;

// Referenced classes of package com.dragonflow.Page:
// CGI, treeControl, monitorPage, vMachinePage

public class alertPage extends com.dragonflow.Page.CGI {

	public static String DISABLED_EXPRESSION = "disabled and ";

	jgl.HashMap alertStats;

	static int alertArtID;

	static int historyArtID;

	static int helpArtID;

	static int siteviewArtID;

	static int groupArtID;

	static int alertDetailID;

	static int alertOnID;

	static int alertForID;

	static int alertDoID;

	static int alertDelID;

	static int alertEditID;

	static int alertAddID;

	static int alertPagerPrefsID;

	static int alertMailPrefsID;

	static int alertSNMPPrefsID;

	static int alertTestMailID;

	static int alertTestPagerID;

	static int alertTestSNMPID;

	static int alertErrorID;

	static int alertWarningID;

	static int alertGoodID;

	static int alertRunID;

	static int alertMailID;

	static int alertPageID;

	static int alertSNMPID;

	static int alertCustomID;

	static int alertAnyID;

	static int alertGroupID;

	static int alertNameID;

	static String french[];

	static String english[];

	String language[];

	public alertPage() {
		alertStats = null;
		language = english;
	}

	public CGI.menus getNavItems(
			com.dragonflow.HTTP.HTTPRequest httprequest) {
		com.dragonflow.Page.CGI.menus menus1 = new CGI.menus();
		if (httprequest.actionAllowed("_browse")) {
			menus1.add(new CGI.menuItems("Browse", "browse", "", "page", "Browse Monitors"));
		}
		if (httprequest.actionAllowed("_alertEdit")) {
			menus1.add(new CGI.menuItems("Add Alert", "alert", "AddList", "operation", "Add a new alert"));
		}
		if (httprequest.actionAllowed("_alertDisable") || httprequest.actionAllowed("_alertTempDisable")) {
			menus1.add(new CGI.menuItems("Disable Alerts", "alert", "Disable", "operation", "Disable all alerts"));
		}
		if (httprequest.actionAllowed("_alertEdit")) {
			menus1.add(new CGI.menuItems("Enable Alerts", "alert", "Enable", "operation", "Enable all disabled alerts"));
		}
		if (httprequest.actionAllowed("_alertRecentReport") || httprequest.actionAllowed("_alertAdhocReport")) {
			menus1.add(new CGI.menuItems("Alert Report", "alert", "ReportForm", "operation", "View a report of alerts sent"));
		}
		return menus1;
	}

	public void printProperty(
			com.dragonflow.Properties.StringProperty stringproperty,
			java.io.PrintWriter printwriter,
			com.dragonflow.SiteView.SiteViewObject siteviewobject,
			com.dragonflow.HTTP.HTTPRequest httprequest, jgl.HashMap hashmap,
			boolean flag) {
		if (!httprequest.getPermission("_alertProperty",
				stringproperty.getName()).equals("hidden")) {
			stringproperty.printProperty(this, printwriter, siteviewobject, httprequest, hashmap, flag);
			if (stringproperty.getName().indexOf("assword") > -1) {
				StringBuffer stringbuffer = new StringBuffer();
				StringBuffer stringbuffer1 = new StringBuffer();
				String s = siteviewobject.getProperty(stringproperty);
				com.dragonflow.Properties.StringProperty.getPrivate(s, stringproperty.getName(), "hidden" + stringproperty.getName(), stringbuffer,stringbuffer1);
				printwriter.print(stringbuffer1.toString());
			}
		}
	}

	void printForm(String s, String s1,
			String s2, String s3, jgl.HashMap hashmap)
			throws java.lang.Exception {
		printForm(s, s1, s2, s3, hashmap, null);
	}

	void printTargets(String s, String s1,
			String s2, jgl.HashMap hashmap)
			throws java.lang.Exception {
		jgl.Array array = new Array();
		if (s2 != null) {
			jgl.Array array1 = Platform.split(',', s2);
			String s8;
			for (Enumeration enumeration1 = array1.elements(); enumeration1.hasMoreElements(); array.add(s8.trim())) {
				s8 = (String) enumeration1.nextElement();
			}

		} else if (!com.dragonflow.Page.treeControl.useTree()) {
			String s3 = s;
			if (!s1.equals("_config")) {
				s3 = s3 + " " + s1;
			}
			array.add(s3);
		} else {
			Enumeration enumeration = request.getValues("targets");
			if (!enumeration.hasMoreElements()) {
				String s4 = request.getValue("group");
				String s9 = request.getValue("monitor");
				if (s4.length() > 0 && s9.length() > 0) {
					array.add(s4 + " " + s9);
				} else if (s4.length() > 0) {
					array.add(s4);
				} else if (s9.length() > 0) {
					array.add(s9);
				}
			} else {
				String s5;
				for (; enumeration.hasMoreElements(); array.add(s5)) {
					s5 = HTTPRequest.decodeString((String) enumeration.nextElement());
				}

			}
		}
		int i = 131;
		if (com.dragonflow.SiteView.Platform.isStandardAccount(request.getValue("account"))) {
			i += 64;
		} else {
			i += 8;
		}
		if (com.dragonflow.Page.treeControl.useTree()) {
			String s6 = TextUtils.getValue(
					hashmap, "targets");
			String s10 = "Select the Groups and Monitors handled by this Alert.  To select several items, hold down the Control key (on most platforms) while clicking item names.\n";
			StringBuffer stringbuffer = new StringBuffer();
			com.dragonflow.Page.treeControl treecontrol = new treeControl(request, "targets", false);
			treecontrol.process("Alert Subject(s)", s6, s10, array, null, null,i, this, stringbuffer);
			outputStream.println(stringbuffer.toString());
		} else {
			String monitorOptionsHTML = getMonitorOptionsHTML(array, null, null, i);
			String s11 = TextUtils.getValue(
					hashmap, "targets");
			outputStream.println("<B>Alert Subject(s)</B>\n<BLOCKQUOTE><DL>\n<DT>\n<TABLE>\n<TR>\n<TD><IMG SRC=/SiteView/htdocs/artwork/empty.gif WIDTH=25><select multiple name=targets size=10> "
							+ monitorOptionsHTML
							+ "</select></TD>\n"
							+ "<TD><I>"
							+ s11
							+ "</I></TD>\n"
							+ "</TR>\n"
							+ "</TABLE>\n"
							+ "<DD>Select the Groups and Monitors handled by this Alert.  To select several items, hold down the Control key (on most platforms) while clicking item names.\n"
							+ "</DL></BLOCKQUOTE>\n");
		}
	}

	/**
	 *
	 *
	 * @param s
	 * @param s1
	 * @param s2
	 * @param s3
	 * @param hashmap
	 * @param s4
	 * @throws java.lang.Exception
	 */
	void printForm(String s, String s1,
			String s2, String s3, jgl.HashMap hashmap,
			String s4) throws java.lang.Exception {
		String s12;
		Enumeration enumeration1;
		String s38;
		com.dragonflow.Utils.I18N.test(s1, 1);
		String s5 = "";
		String s6 = "";
		String s7 = "";
		String s8 = "";
		String s9 = "";
		String s10 = "";
		String s11 = "";
		s12 = "";
		String disabled = "";
		String s14 = "";
		String s15 = null;
		int i = -1;
		int j = -1;
		int k = -1;
		int l = -1;
		int i1 = -1;
		int j1 = -1;
		String category = request.getValue("category");
		com.dragonflow.SiteView.Action action = null;
		if (s.equals("Add")) {
			s6 = "checked";
			action = Action.createAction(request
					.getValue("class"));
			i = 1;
			j = 1;
			k = -1;
			l = 1;
			String s17 = request.getPermission("_actionType",(String) action.getClassProperty("class"));
			if (s17.equals("optional")) {
				printNotAvailable(action, request.getAccount());
				return;
			}
			if (com.dragonflow.Utils.TextUtils.toInt(s17) > 0) {
				int k1 = com.dragonflow.Utils.TextUtils
						.toInt(com.dragonflow.Page.alertPage.getValue(
								getAlertStats(), request.getValue("class")
										+ "Count"));
				if (k1 >= com.dragonflow.Utils.TextUtils.toInt(s17)) {
					printTooManyAlerts(action, request.getAccount(),
							com.dragonflow.Utils.TextUtils.toInt(s17), true);
					return;
				}
			}
			int i2 = request.getPermissionAsInteger("_maximumAlerts");
			if (i2 > 0) {
				int l1 = com.dragonflow.Utils.TextUtils
						.toInt(com.dragonflow.Page.alertPage.getValue(
								getAlertStats(), "TotalAlerts"));
				if (l1 >= i2) {
					printTooManyAlerts(action, request.getAccount(), i2, false);
					return;
				}
			}
		} else {
			if (com.dragonflow.SiteView.AtomicMonitor.alertDebug) {
				System.out.println("AlertPage: EDIT: previousCondition: " + s4 + " id: " + s3);
			}
			jgl.Array array;
			if (s4 == null) {
				array = findCondition(s3);
				if (com.dragonflow.SiteView.AtomicMonitor.alertDebug) {
					System.out .println("AlertPage: used findCondition pieces: " + array.toString() + " id: " + s3);
				}
			} else {
				array = Platform.split('\t', s4);
				if (com.dragonflow.SiteView.AtomicMonitor.alertDebug) {
					System.out.println("AlertPage: used previousCondition to get pieces: " + array.toString() + " id: " + s3);
				}
			}
			String s18 = (String) array.at(0);
			String s20 = (String) array.at(1);
			if (com.dragonflow.SiteView.AtomicMonitor.alertDebug) {
				System.out.println("AlertPage: actionString from  pieces.at(1): " + s20 + " id: " + s3);
			}
			String s22 = (String) array.at(3);
			if (array.size() > 3 && !s22.startsWith("_UIContext")) {
				s15 = (String) array.at(3);
			}
			action = Action
					.createAction(getActionClass(s20));
			if (com.dragonflow.SiteView.AtomicMonitor.alertDebug) {
				com.dragonflow.Utils.TextUtils
						.debugPrint("********* expression = " + s18 + " group.monitorsInError = " + s18.indexOf("group.monitorsInError"));
			}
			jgl.Array array1 = new Array();
			com.dragonflow.Properties.HashMapOrdered hashmapordered = new HashMapOrdered(
					true);
			getActionArguments(s20, array1, hashmapordered);
			if (com.dragonflow.SiteView.AtomicMonitor.alertDebug) {
				System.out
						.println("AlertPage: after getActionArguments from  args from actionString: " + array1.toString() + " id: " + s3);
			}
			action.initializeFromArguments(array1, hashmapordered);
			if (category.length() == 0) {
				category = getCategory(s18);
			}
			i = getErrorCount(s18);
			j = getAlwaysErrorCount(s18);
			k = getMultipleErrorCount(s18);
			l = getAlwaysErrorCount(s18);
			j1 = getPreviousErrorCount(s18);
			i1 = getMaxErrorCount(s18);
			if (s18.indexOf("group.monitorsInError") >= 0) {
				s9 = "checked";
			}
			s10 = getNameString(s18);
			s12 = getClassString(s18);
			s11 = getStatusString(s18);
			disabled = getDisabled(s18);
			if (s18.indexOf("monitorDoneTime") >= 0) {
				s14 = s18.substring(s18.indexOf("monitorDoneTime"));
			}
		}
		s8 = i1 == -1 ? null : "checked";
		s6 = i == -1 ? null : "checked";
		s7 = k == -1 ? null : "checked";
		s5 = i != -1 || k != -1 ? null : "checked";
		if (i < 1) {
			i = 1;
		}
		if (j < 1) {
			j = 1;
		}
		if (k < 1) {
			k = 1;
		}
		if (l < 1) {
			l = 1;
		}
		if (j1 < 1) {
			j1 = -1;
		}
		if (i1 < 1) {
			i1 = 1;
		}
		com.dragonflow.Page.CGI.menus menus1 = getNavItems(request);
		printButtonBar((String) action.getClassProperty("help"),
				"Alerts", menus1);
		String s19 = (String) action
				.getClassProperty("classType");
		if (s19 != null && s19.equals("beta")) {
			outputStream
					.println("<hr><p><b>This Alert is a beta feature of SiteView that is currently being tested.<br><br>We would appreciate your feedback on this feature (<a href=mailto:"
							+ com.dragonflow.SiteView.Platform.supportEmail
							+ " style='display:relative;'>"
							+ com.dragonflow.SiteView.Platform.supportEmail
							+ "<paper-ripple></paper-ripple></a>).&nbsp; "
							+ "If you send us comments and/or suggestions, we promise a "
							+ "quick response from one of our techincal staff."
							+ "</b><hr>");
		}
		String s21 = "Error";
		if (category.equals("warning")) {
			s21 = "Warning";
		} else if (category.equals("good")) {
			s21 = "OK";
		}
		String s23 = s;
		if (s23.equals("Add")) {
			s23 = "Define";
		}
		outputStream.println("<H2>" + s23 + " "
				+ action.getClassProperty("name") + " Alert on " + s21
				+ "</H2><P>\n");
		String s24 = getPagePOST("alert", s)
				+ "<input type=hidden name=group value=" + s1 + ">\n"
				+ "<input type=hidden name=category value=" + category + ">\n"
				+ "<input type=hidden name=monitor value=" + s2 + ">\n"
				+ "<input type=hidden name=id value=" + s3 + ">\n"
				+ "<input type=hidden name=class value="
				+ action.getClassProperty("class") + ">\n";
		outputStream.println(s24);
		if (!hashmap.isEmpty()) {
			printErrorHeader();
		}
		outputStream
				.println("<table border=0 cellspacing=4><tr><td><img src=\"/SiteView/htdocs/artwork/LabelSpacer.gif\"></td><td></td><td></td></tr>\n<tr><td colspan=3><hr></td></tr>");
		printTargets(s1, s2, s15, hashmap);
		outputStream.println("<tr><td colspan=3><hr></td></tr><TR><TD><B>"
				+ action.getClassProperty("title") + "</B></TD>");
		String s25 = (String) action
				.getClassProperty("prefs");
		if (!request.isStandardAccount()) {
			String s26 = (String) action
					.getClassProperty("accountPrefs");
			if (s26 == null) {
				s25 = "";
			} else {
				s25 = s26;
			}
		}
		if (s25 != null && s25.length() > 0) {
			outputStream.println("<TD> (<A HREF=" + getPageLink(s25, "")
					+ " style='display:relative;'>Edit " + action.getClassProperty("name")
					+ " Preferences<paper-ripple></paper-ripple></a>)</TD></TR>\n");
		}
		if ((action instanceof com.dragonflow.SiteView.ServerAction)
				&& com.dragonflow.SiteView.ServerAction.pMachineName.isEditable) {
			if (request.hasValue("server")) {
				String s27 = request.getValue("server");
				if (s27.equals("this server")) {
					s27 = "";
				}
				action
						.unsetProperty(com.dragonflow.SiteView.ServerAction.pMachineName);
				action.addProperty(
						com.dragonflow.SiteView.ServerAction.pMachineName, s27);
			} else if (s.equals("Add")) {
				jgl.HashMap hashmap1 = getMasterConfig();
				String s28 = TextUtils.getValue(
						hashmap1, "_defaultMachine");
				action.addProperty(
						com.dragonflow.SiteView.ServerAction.pMachineName, s28);
			}
		}
		boolean flag = !com.dragonflow.SiteView.SiteViewGroup.currentSiteView()
				.internalServerActive();
		jgl.Array array2 = action.getProperties();
		array2 = com.dragonflow.Properties.StringProperty.sortByOrder(array2);
		Enumeration enumeration = array2.elements();
		while (enumeration.hasMoreElements()) {
			com.dragonflow.Properties.StringProperty stringproperty = (com.dragonflow.Properties.StringProperty) enumeration
					.nextElement();
			if (stringproperty.isEditable && !stringproperty.isAdvanced) {
				printProperty(stringproperty, outputStream, action, request,
						hashmap, flag);
			}
		}

		String s29 = s;
		if (s.equals("Edit")) {
			s29 = "Update";
		}
		outputStream
				.println("<TR><TD COLSPAN=3><hr></TD></TR><TR><TD ALIGN=RIGHT VALIGN=TOP><B>When</B></TD>\n<TD><TABLE BORDER=0><TR><TD ALIGN=LEFT VALIGN=TOP>\n<DL><DT><INPUT TYPE=RADIO NAME=when value=always "
						+ s5
						+ ">\n"
						+ "Always, after the condition has occurred at least \n"
						+ "<input type=text name=alwaysErrorCount size=3 value=\""
						+ String.valueOf(j)
						+ "\"> times\n"
						+ "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<I><B>"
						+ com.dragonflow.Page.alertPage.getValue(hashmap,
								"when")
						+ "</B></I></DT>\n"
						+ "<DD>only cause an Alert after the condition occurs <B>at least</B> this many times, consecutively.\n"
						+ "<DT><INPUT TYPE=RADIO NAME=when value=count "
						+ s6
						+ ">Once, after condition occurs exactly \n"
						+ "<input type=text name=errorCount size=3 value=\""
						+ String.valueOf(i)
						+ "\"> times\n"
						+ "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<I><B>"
						+ com.dragonflow.Page.alertPage.getValue(hashmap,
								"when")
						+ "</B></I></DT>\n"
						+ "<DD>only cause an Alert after the condition occurs <B>exactly</B> this many times, consecutively.\n</DD>"
						+ "<DT><INPUT TYPE=RADIO NAME=when value=multiple "
						+ s7
						+ ">Initial alert \n"
						+ "<input type=text name=multipleStartCount size=3 value=\""
						+ String.valueOf(l)
						+ "\"> \n"
						+ "and repeat every <input type=text name=multipleErrorCount size=3 value=\""
						+ String.valueOf(k)
						+ "\"> \n"
						+ "times afterwards\n"
						+ "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<I><B>"
						+ com.dragonflow.Page.alertPage.getValue(hashmap,
								"when")
						+ "</B></I></DT>\n"
						+ "<DD>cause an Alert after the condition occurs X consecutive times and repeat the alert every Y consecutive times thereafter.</DD>\n");
		if (category.equals("error")) {
			outputStream
					.println("<DT><INPUT TYPE=RADIO NAME=when value=maxErrors "
							+ s8
							+ ">Once, after \n"
							+ "<input type=text name=maxErrorCount size=3 value=\""
							+ String.valueOf(i1)
							+ "\"> group errors\n"
							+ "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<I><B>"
							+ com.dragonflow.Page.alertPage.getValue(hashmap,
									"whenMaxErrors")
							+ "</B></I></DT>\n"
							+ "<DD>cause an alert the first time that any monitor in this group gets this many "
							+ "consecutive error readings</DD>\n"
							+ "<DT><INPUT TYPE=RADIO NAME=when value=allErrors "
							+ s9
							+ ">Once, when all monitors of this group are in error</B></I></DT>\n\n"
							+ "<DD>cause an alert when all of the monitors in the group are in error</DD>\n");
		}
		outputStream
				.println("</TD></TR></TABLE></TD></TR><tr><td colspan=3><hr></td></tr>");
		if (category.equals("good")) {
			String checked = "";
			if (j1 != -1) {
				checked = " checked ";
			} else {
				j1 = 2;
			}
			outputStream
					.println("<TR><TD ALIGN=RIGHT><input type=checkbox "
							+ checked
							+ " name=usePreviousErrorCount value=true "
							+ "></TD><TD ALIGN=LEFT>Only allow alert if monitor was previously in error at least "
							+ "<input type=text name=previousErrorCount size=3 value=\""
							+ String.valueOf(j1)
							+ "\"> times\n"
							+ "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<I><B>"
							+ com.dragonflow.Page.alertPage.getValue(hashmap,
									"previousErrorCount")
							+ "</B></I>"
							+ "<DD>allow this alert to be triggered only if the monitor was in error previously</TD></TR>\n");
		}
		outputStream.println("</TABLE>");
		outputStream.println("<P>\n<input type=submit value=" + s29 + "> " + action.getClassProperty("name") + " Alert</input>\n");
		outputStream.println("<p><HR><H3>Advanced Options</H3>");
		outputStream.println("<table border=0 cellspacing=4><tr><td><img src=\"/SiteView/htdocs/artwork/LabelSpacer.gif\"></td><td></td><td></td></tr>\n");
		enumeration = array2.elements();
		boolean flag1 = action.showOptionalProperties();
		while (enumeration.hasMoreElements()) {
			com.dragonflow.Properties.StringProperty stringproperty1 = (com.dragonflow.Properties.StringProperty) enumeration.nextElement();
			if (stringproperty1.isEditable && stringproperty1.isAdvanced && (!stringproperty1.isOptional || flag1)) {
				printProperty(stringproperty1, outputStream, action, request,hashmap, flag);
			}
		}

		String permanent = "";
		if (disabled.length() > 0) {
			if (disabled.equals("disabled")) {
				permanent = "permanent";
			} else if (disabled.startsWith("disabled until")) {
				if (com.dragonflow.Page.alertPage.isTimedDisable(s14)) {
					permanent = "timed";
				} else if (com.dragonflow.Page.alertPage
						.isScheduledDisable(s14)) {
					permanent = "scheduled";
				}
			}
		}
		int _timeOffset = com.dragonflow.Utils.TextUtils.toInt(request
				.getUserSetting("_timeOffset"));
		String s32 = com.dragonflow.Page.alertPage.getStartTimeHTML(
				_timeOffset, s14);
		String s33 = com.dragonflow.Page.alertPage.getEndTimeHTML(_timeOffset,
				s14);
		outputStream
				.println("\n<TR><TD ALIGN=RIGHT>Disable Alert</TD>\n<TD></TD></TR><TR><td>&nbsp;</td><TD ALIGN=LEFT>");
		if (request.actionAllowed("_alertDisable")
				|| request.actionAllowed("_alertTempDisable")) {
			outputStream.println("\n<TABLE BORDER=0><TR>");
		}
		outputStream
				.println("\n<TR><TD ALIGN=LEFT><INPUT TYPE=RADIO NAME=alertDisable VALUE=undo ");
		String s34 = "";
		if (!permanent.equals("permanent") && !permanent.equals("timed")
				&& !permanent.equals("scheduled")) {
			s34 = "checked";
		}
		outputStream.println(s34 + ">\nEnable Alert</TD></TR>");
		s34 = "";
		if (request.actionAllowed("_alertDisable")) {
			outputStream
					.println("\n<TD ALIGN=LEFT><INPUT TYPE=radio NAME=alertDisable VALUE=permanent ");
			s34 = permanent.equals("permanent") ? "checked" : "";
			outputStream.println(s34
					+ ">\nDisable alert permanently</INPUT></TD></TR>");
		}
		s34 = "";
		if (request.actionAllowed("_alertTempDisable")) {
			String s35 = "10";
			outputStream
					.println("\n<TR><TD ALIGN=LEFT><INPUT TYPE=radio NAME=alertDisable VALUE=timed");
			if (permanent.equals("timed")) {
				s34 = "checked";
				long l2 = com.dragonflow.Page.alertPage.getDisableScheduleTime(
						"endTime", s14);
				long l3 = l2 - com.dragonflow.SiteView.Platform.timeMillis();
				l3 /= 1000L;
				l3 /= 60L;
				s35 = (new Long(l3)).toString();
			}
			outputStream.println(s34 + "> Disable alerts for the next \n");
			outputStream
					.println("<INPUT TYPE=TEXT SIZE=5 NAME=disableAlertTime VALUE="
							+ s35
							+ ">"
							+ "\n<SELECT SIZE=1 NAME=disableAlertUnits>"
							+ "\n<OPTION>seconds<OPTION SELECTED>minutes<OPTION>hours<OPTION>days\n"
							+ "</SELECT>");
			outputStream
					.println("\n<TR><TD ALIGN=LEFT><INPUT TYPE=RADIO NAME=alertDisable VALUE=scheduled");
			s34 = permanent.equals("scheduled") ? " checked" : "";
			outputStream.println(s34 + ">\n"
					+ "\nDisable on a one-time schedule from " + s32 + " to "
					+ s33 + "</TD></TR>");
		}
		if (request.actionAllowed("_alertDisable")
				|| request.actionAllowed("_alertTempDisable")) {
			outputStream.println("\n</TABLE></TD></TR>\n");
		}
		outputStream
				.println("<tr><td colspan=3><hr></td></tr><TR><TD ALIGN=LEFT VALIGN=TOP COLSPAN=2><p><b>Global and Group Alert Filtering</b></p></TD><TD></TD></TR>");
		outputStream
				.println("<TR><TD>&nbsp;</TD></TR><TR><TD ALIGN=RIGHT VALIGN=TOP>Name Match</TD><TD><TABLE BORDER=0><TR><TD ALIGN=LEFT><input type=text name=nameMatchString size=50 value=\""
						+ s10
						+ "\"></TD></TR>"
						+ "<TR><TD><FONT SIZE=-1>The text to match in the Name string of the monitor before this alert is triggered. For\n"
						+ "example, entering <B><tt>URL:</tt></B> means this alert will only be triggered for monitors whose name contains the string \"<tt>URL:</tt>\". The match is case sensitive.</FONT></TD></TR>"
						+ "</TABLE></TD></TR>");
		outputStream
				.println("<TR><TD ALIGN=RIGHT VALIGN=TOP>Status Match</TD><TD><TABLE BORDER=0><TR><TD ALIGN=LEFT><input type=text name=statusMatchString size=50 value=\""
						+ s11
						+ "\"></TD></TR>"
						+ "<TR><TD><FONT SIZE=-1>The text to match in the Status string of the monitor before this alert is triggered. For\n"
						+ "example, entering <B><tt>timeout</tt></B> triggers this alert only for monitors whose status contains the string \"<tt>timeout</tt>\". The match is case sensitive.</FONT></TD></TR>"
						+ "</TABLE></TD></TR>");
		String s36 = s12.indexOf("Any Monitor") == -1 ? ""
				: " selected";
		jgl.Array array3 = com.dragonflow.Page.monitorPage.getMonitorClasses();
		enumeration1 = array3.elements();
		s38 = "<option value=Any Monitor" + s36 + ">" + "Any Monitor "
				+ "</option>\n";

		java.lang.Class class1;
		while (enumeration1.hasMoreElements()) {
			class1 = (java.lang.Class) enumeration1.nextElement();
			com.dragonflow.SiteView.AtomicMonitor atomicmonitor;
			atomicmonitor = (com.dragonflow.SiteView.AtomicMonitor) class1
					.newInstance();
			String s39 = request.getPermission("_monitorType",
					(String) atomicmonitor.getClassProperty("class"));
			if (s39.length() == 0) {
				s39 = request.getPermission("_monitorType", "default");
			}
			if (s39.equals("hidden")) {
				continue; /* Loop/switch isn't completed */
			}
			String s40;
			String s41;
			s40 = (String) atomicmonitor.getClassProperty("title");
			s41 = (String) atomicmonitor.getClassProperty("class");
			if (s41.indexOf("Monitor") >= 0) {
				try {
					String s37 = s12.indexOf(s41) == -1 ? ""
							: " selected";
					s38 = s38 + "<option value=" + s41 + s37 + ">" + s40
							+ "</option>\n";
				} catch (java.lang.Exception exception) {
					System.out
							.println("Could not create instance of " + class1);
				}
			}
		}

		outputStream
				.println(com.dragonflow.Page.vMachinePage
						.field(
								"Monitor Type ",
								"<select size=1 name=classMatchString>" + s38
										+ "</select>\n",
								"Select the type of monitor that will trigger this alert. Only monitors of this type within the group(s) selected in <b>Alert Subject(s)</b> above will trigger this alert.\n"));
		outputStream.println("</TABLE>");
		outputStream.print("</FORM>\n");
		printFooter(outputStream);
		return;
	}

	void printAddForm(String s) throws java.lang.Exception {
		String s1 = request.getValue("group");
		String s2 = request.getValue("monitor");
		String s3 = request.getValue("id");
		if (request.isPost()) {
			Enumeration enumeration = request.getValues("targets");
			String s4 = "";
			String s5 = "";
			String s6 = "";
			boolean flag = false;
			do {
				if (!enumeration.hasMoreElements()) {
					break;
				}
				String _master = (String) enumeration
						.nextElement();
				_master = com.dragonflow.HTTP.HTTPRequest.decodeString(_master);
				if (s6.length() != 0) {
					s6 = s6 + ",";
				}
				s6 = s6 + _master;
				if (_master.equals("_master")) {
					s4 = "_master";
					s5 = "_config";
					flag = false;
					break;
				}
				String _config = "_config";
				String s10 = _master;
				int i = _master.indexOf(" ");
				if (i != -1) {
					s10 = _master.substring(0, i);
					_config = _master.substring(i + 1);
				}
				if (s4.length() == 0) {
					s4 = s10;
					s5 = _config;
				} else if (!s4.equals(s10)) {
					s4 = "_master";
					s5 = "_config";
					flag = true;
				} else {
					s5 = "_config";
					flag = true;
				}
			} while (true);
			if (s4.equals("_master")
					&& !com.dragonflow.SiteView.Platform
							.isStandardAccount(request.getValue("account"))) {
				s4 = request.getValue("account");
			}
			String s8 = null;
			if (flag) {
				s8 = s6;
			}
			com.dragonflow.SiteView.Action action = Action
					.createAction(request.getValue("class"));
			jgl.HashMap hashmap = new HashMap();
			if (s6.length() == 0) {
				hashmap.put("targets", "no groups and/or monitors selected");
			}
			jgl.Array array = action.getProperties();
			array = com.dragonflow.Properties.StringProperty.sortByOrder(array);
			Enumeration enumeration1 = array.elements();
			label0: do {
				if (!enumeration1.hasMoreElements()) {
					break;
				}
				com.dragonflow.Properties.StringProperty stringproperty = (com.dragonflow.Properties.StringProperty) enumeration1
						.nextElement();
				if (!stringproperty.isEditable) {
					continue;
				}
				if (stringproperty.isMultiLine) {
					String s12 = request.getValue(stringproperty
							.getName());
					String as[] = com.dragonflow.Utils.TextUtils
							.split(s12, "\r\n");
					action.unsetProperty(stringproperty);
					int k = 0;
					while (k < as.length) {
						String s17 = as[k];
						s17 = action.verify(stringproperty, s17, request,
								hashmap);
						action.addProperty(stringproperty, s17);
						k++;
					}
					continue;
				}
				String s13 = request.getValue(stringproperty
						.getName());
				if (stringproperty instanceof com.dragonflow.Properties.ScalarProperty) {
					s13 = ((com.dragonflow.Properties.ScalarProperty) stringproperty)
							.getRawValue(request);
				}
				if (stringproperty.getName().indexOf("assword") > -1) {
					s13 = com.dragonflow.Properties.StringProperty.getPrivate(
							request, stringproperty.getName(), "hidden"
									+ stringproperty.getName(), null, null);
				}
				if ((stringproperty instanceof com.dragonflow.Properties.ScalarProperty)
						&& ((com.dragonflow.Properties.ScalarProperty) stringproperty).multiple) {
					int j = request.getPermissionAsInteger("_actionType",
							request.getValue("class") + "."
									+ stringproperty.getName());
					if (j > 0
							&& request.countValues(stringproperty.getName()) > j) {
						hashmap.put(stringproperty, "Only " + j
								+ " of these options may be chosen");
					}
					boolean flag2 = false;
					if (((com.dragonflow.Properties.ScalarProperty) stringproperty).allowOther) {
						flag2 = ((com.dragonflow.Properties.ScalarProperty) stringproperty)
								.usingCustomValue(request);
					}
					if (flag2) {
						String s18 = ((com.dragonflow.Properties.ScalarProperty) stringproperty)
								.getCustomValue(request);
						s18 = action.verify(stringproperty, s18, request,
								hashmap);
						action.setProperty(stringproperty, s18);
						continue;
					}
					Enumeration enumeration2 = request
							.getValues(stringproperty.getName());
					action.unsetProperty(stringproperty);
					do {
						String s19;
						do {
							if (!enumeration2.hasMoreElements()) {
								continue label0;
							}
							s19 = (String) enumeration2.nextElement();
						} while (s19.length() == 0);
						action.addProperty(stringproperty, s19);
					} while (true);
				}
				String s15 = action.verify(stringproperty, s13,
						request, hashmap);
				action.setProperty(stringproperty, s15);
			} while (true);
			String s11 = action.getActionString();
			String s14 = packCondition(request, s11, hashmap);
			boolean flag1 = hashmap.size() == 0;
			if (flag1) {
				if (s.equals("Add")) {
					addCondition(s4, s5, s14, s8);
				} else {
					replaceCondition(s1, s2, s4, s5, s3, s14, s8);
				}
			}
			if (flag1 && com.dragonflow.Page.treeControl.notHandled(request)) {
				String s16 = getPageLink("alert", "List");
				jgl.HashMap hashmap1 = getSettings();
				if (!action.defaultsAreSet(hashmap1)) {
					s16 = getPageLink((String) action
							.getClassProperty("prefs"), "");
				}
				printRefreshPage(s16, 0);
			} else {
				if (!com.dragonflow.Page.treeControl.notHandled(request)) {
					hashmap = new HashMap();
				}
				printForm(s, s1, s2, s3, hashmap, s14);
			}
		} else {
			printForm(s, s1, s2, s3, new HashMap());
		}
	}

	/**
	 *
	 *
	 * @param operation
	 * @throws java.io.IOException
	 */
	void printListForm(String operation) throws java.io.IOException {
		Enumeration enumeration1;
		com.dragonflow.SiteView.SiteViewGroup siteviewgroup = SiteViewGroup
				.currentSiteView();
		boolean flag = request.actionAllowed("_alertList"); //Whether if show the list.
		if (!flag) {
			outputStream.println("ACCESS NOT ALLOWED"); //No permission
			return;
		}
		com.dragonflow.Page.CGI.menus menus1 = getNavItems(request);
		printButtonBar("Alert.htm", "Alerts", menus1);
		boolean flag1 = request.actionAllowed("_alertEdit");
		boolean flag2 = request.actionAllowed("_alertRecentReport");
		if (isPortalServerRequest()) {
			flag2 = false;
		}
		boolean flag3 = siteviewgroup.internalServerActive()
				&& request.actionAllowed("_alertTest");
		boolean flag4 = request.actionAllowed("_alertEdit");
		boolean flag5 = false;
		jgl.HashMap hashmap = getSettings();
		if (hashmap != null) {
			String s1 = com.dragonflow.Page.alertPage.getValue(hashmap, "_alertPageColumnOrder");
			if (s1.length() > 0) {
				flag5 = true;
			}
		}
		String s2 = com.dragonflow.Utils.I18N
				.toDefaultEncoding(request.getValue("groupFilter"));
		String s3 = "<A HREF="
				+ com.dragonflow.Page.CGI.getGroupDetailURL(request,
						com.dragonflow.Utils.I18N.UnicodeToString(s2)) + ">";
		if (s2.length() > 0) {
			String s4 = com.dragonflow.Page.alertPage
					.getGroupFullName(s2);
			String s6 = "";
			if (s4.lastIndexOf(":") >= 0) {
				s6 = s4.substring(0, s4.lastIndexOf(":") + 1);
				s4 = s4.substring(s4.lastIndexOf(":") + 1);
			}
			s2 = " for " + s6 + s3 + s4 + "</a>";
		}
//		Alerts Definitions
		String s5 = getString(alertDetailID);
		outputStream.println("<p><H2>" + s5 + s2 + "</H2>");
		outputStream.println("<link rel='import' href='/SiteView/htdocs/js/components/data-table-ext/data-table-ext.html' async='true'>\n");
		outputStream.println("<link rel='import' href='/SiteView/htdocs/js/bower_components/paper-ripple/paper-ripple.html' async='true'>\n");
		outputStream.println("<link rel='import' href='/SiteView/htdocs/js/components/data-table-ext/simple-data-table-ext.html' async='true'>\n");

		jgl.Array array = getConditions();
		ArrayList<java.util.HashMap> mapList = new ArrayList<java.util.HashMap>();
		String mapListStr = "";
		Enumeration enumerationArr = array.elements();
		for(int i=0;i<array.size();i++){
			java.util.HashMap<String, String> dataMap = new java.util.HashMap<String, String>();
			jgl.HashMap hashmap1 = (jgl.HashMap) enumerationArr.nextElement();
			String s7 = getPageLink("alert", "")
					+ "&group="
					+ com.dragonflow.HTTP.HTTPRequest
							.encodeString(com.dragonflow.Utils.I18N
									.toDefaultEncoding(com.dragonflow.Utils.TextUtils
											.getValue(hashmap1, "group")))
					+ "&monitor=" + hashmap1.get("monitor") + "&id="
					+ hashmap1.get("id");
			String s8 = buildHistoryLink(hashmap1);
			String s9 = buildEditLink(s7);
			String s11 = buildTestLink(hashmap1);
			String s13 = buildDeleteLink(s7);
			if (flag5) {
				if (flag2) {
					dataMap.put("a_History", s8);
				}
				if (flag1) {
					dataMap.put("b_Edit", s9);
				}
				if (flag3) {
					dataMap.put("c_Test", s11);
				}
				if (flag4) {
					dataMap.put("d_"+getString(alertDelID), s13);
				}
			}

			dataMap.put("e_"+getString(alertOnID), (String)hashmap1.get("on"));
			dataMap.put("f_Group", (String)hashmap1.get("groupName"));
			dataMap.put("g_"+getString(alertForID), (String)hashmap1.get("for"));
			dataMap.put("h_"+getString(alertDoID), (String)hashmap1.get("do"));
			if (!flag5) {
				if (flag2) {
					dataMap.put("i_History", s8);
				}
				if (flag1) {
					dataMap.put("j_Edit", s9);
				}
				if (flag3) {
					dataMap.put("k_Test", s11);
				}
				if (flag4) {
					dataMap.put("l_"+getString(alertDelID), s13);
				}
			}
			mapList.add(dataMap);
		}
//		String jsonString = JSONObject.toJSONString(mapList, true);
    String jsonString = JSONObject.toJSONString(mapList);
		jsonString = jsonString.replaceAll(" ","@space");
		jsonString = jsonString.replaceAll(">","@big");
		jsonString = jsonString.replaceAll("<","@small");

		outputStream.println("<data-table-custom data-list="+jsonString+" is-show-header='true'></data-table-custom>\n");
//		Alert Definitions: End

//		Alert Actions: Start
		outputStream.println("<hr><font size=+1><b>Alert Actions:</b></font>");
		ArrayList<java.util.HashMap> actionsList = new ArrayList<java.util.HashMap>();
		if (request.actionAllowed("_alertEdit")) {
			java.util.HashMap<String, String> _alertEditMap = new java.util.HashMap<String, String>();
			_alertEditMap.put("atitle","<a href=" + getPageLink("alert", "AddList")+ ">"+ getString(alertAddID) + "<paper-ripple></paper-ripple></a>");
			_alertEditMap.put("desc","Add a new alert for one or more monitors or groups");
			actionsList.add(_alertEditMap);
		}
		if (request.actionAllowed("_alertDisable")) {
			java.util.HashMap<String, String> _alertDisableMap = new java.util.HashMap<String, String>();
			_alertDisableMap.put("atitle","<a href=" + getPageLink("alert", "Disable") + ">Disable<paper-ripple></paper-ripple></a>");
			_alertDisableMap.put("desc","Disable all alerts");
			actionsList.add(_alertDisableMap);
			java.util.HashMap<String, String> _alertEnableMap = new java.util.HashMap<String, String>();
			_alertEnableMap.put("atitle","<a href="+ getPageLink("alert", "Enable")+ ">Enable<paper-ripple></paper-ripple></a>");
			_alertEnableMap.put("desc","Enable all alerts previously disabled");
			actionsList.add(_alertEnableMap);
		}

		jgl.Array array1 = getActionClasses();
		enumeration1 = array1.elements();
		java.lang.Class class1;
		while (enumeration1.hasMoreElements()) {

			class1 = (java.lang.Class) enumeration1.nextElement();
			com.dragonflow.SiteView.Action action;
			String s10;
			try {
				action = (com.dragonflow.SiteView.Action) class1.newInstance();
				s10 = request.getPermission("_actionType",
						(String) action.getClassProperty("class"));
				if (s10.length() == 0) {
					s10 = request.getPermission("_actionType", "default");
				}
				if (!s10.equals("hidden")) {
					String s12 = (String) action
							.getClassProperty("prefs");
					boolean flag6 = request.actionAllowed("_preference");
					boolean flag7 = request.actionAllowed("_preferenceTest");
					if (!request.isStandardAccount()) {
						String s14 = (String) action
								.getClassProperty("accountPrefs");
						if (s14 == null) {
							flag6 = false;
						} else {
							s12 = s14;
						}
					}
					if (s12 != null && s12.length() > 0 && (flag6 || flag7)) {
						java.util.HashMap<String, String> _alertOtherMap = new java.util.HashMap<String, String>();
						String desc = "";
						String title = "";
						if (flag7) {
							title = "<A HREF=" + getPageLink(s12, "test") + ">Test "+ action.getClassProperty("name")+ "<paper-ripple></paper-ripple></a>";
							desc += "Send a test "+ action.getClassProperty("name") + " Alert ";
						}
						if (flag6) {
							desc += "using current <A HREF="+ getPageLink(s12, "") + ">"+ action.getClassProperty("name")+ " Preferences<paper-ripple></paper-ripple></a>";
						}
						_alertOtherMap.put("atitle",title);
						_alertOtherMap.put("desc",desc);
						actionsList.add(_alertOtherMap);
					}
				}
			} catch (java.lang.Exception exception) {
				outputStream.println("<br>class: " + class1.getName()
						+ " error: " + enumeration1);
			}
		}

		if (request.actionAllowed("_alertAdhocReport")) {
			java.util.HashMap<String, String> _alertAdhocReportMap = new java.util.HashMap<String, String>();
			_alertAdhocReportMap.put("atitle","<a HREF="+ getPageLink("alert", "ReportForm")+ ">Alert Report<paper-ripple></paper-ripple></a>");
			_alertAdhocReportMap.put("desc","View a report of alerts that have been sent");
			actionsList.add(_alertAdhocReportMap);
		}
		if (request.actionAllowed("_logs")) {
			java.util.HashMap<String, String> _logsMap = new java.util.HashMap<String, String>();
			_logsMap.put("atitle","<a href="+ getPageLink("log", "")+ ">Alert Log<paper-ripple></paper-ripple></a>");
			_logsMap.put("desc","View the the log of alerts sent");
			actionsList.add(_logsMap);
		}

		String actionsListStr = JSONObject.toJSONString(actionsList);
		actionsListStr = actionsListStr.replaceAll(" ","@space");
		actionsListStr = actionsListStr.replaceAll(">","@big");
		actionsListStr = actionsListStr.replaceAll("<","@small");
		// System.out.println("actionsListStr:"+actionsListStr);

		outputStream.println("<simple-data-table-ext data-list="+actionsListStr+"></simple-data-table-ext>\n");
//		Alert Actions: End
		outputStream.println("<hr>");
		printFooter(outputStream);
		return;
	}

	String buildHistoryLink(jgl.HashMap hashmap) {
		String s = getPageLink("alert", "Report")
				+ "&alert-id=SiteView";
		if (!TextUtils.getValue(hashmap, "group").equals(
				"_master")) {
			if (TextUtils.getValue(hashmap, "monitor")
					.equals("_config")) {
				s = s
						+ "/"
						+ com.dragonflow.HTTP.HTTPRequest
								.encodeString(com.dragonflow.Utils.I18N
										.UnicodeToString(
												com.dragonflow.Utils.TextUtils
														.getValue(hashmap,
																"group"),
												com.dragonflow.Utils.I18N
														.nullEncoding()));
			} else {
				s = s
						+ "/"
						+ com.dragonflow.HTTP.HTTPRequest
								.encodeString(com.dragonflow.Utils.I18N
										.UnicodeToString(
												com.dragonflow.Utils.TextUtils
														.getValue(hashmap,
																"group"),
												com.dragonflow.Utils.I18N
														.nullEncoding()))
						+ "/"
						+ TextUtils.getValue(hashmap,
								"monitor");
			}
		}
		s = s
				+ "/"
				+ com.dragonflow.HTTP.HTTPRequest
						.encodeString(com.dragonflow.Utils.I18N
								.UnicodeToString((String) hashmap
										.get("id"), com.dragonflow.Utils.I18N
										.nullEncoding()));
		return "<a HREF=" + s + ">History<paper-ripple></paper-ripple></a>";
	}

	String buildEditLink(String s) {
		return "<a href=" + s + "&operation=Edit>Edit<paper-ripple></paper-ripple></a>";
	}

	String buildTestLink(jgl.HashMap hashmap) {
		return "<a href="
				+ getPageLink("alert", "Test")
				+ "&alertID="
				+ com.dragonflow.HTTP.HTTPRequest
						.encodeString(com.dragonflow.Utils.I18N
								.UnicodeToString(com.dragonflow.Utils.TextUtils
										.getValue(hashmap, "fullID"),
										com.dragonflow.Utils.I18N
												.nullEncoding()))
				+ "&group="
				+ com.dragonflow.HTTP.HTTPRequest
						.encodeString(com.dragonflow.Utils.I18N
								.UnicodeToString(com.dragonflow.Utils.TextUtils
										.getValue(hashmap, "group"),
										com.dragonflow.Utils.I18N
												.nullEncoding())) + "&monitor="
				+ hashmap.get("monitor") + ">Test<paper-ripple></paper-ripple></a>";
	}

	String buildDeleteLink(String s) {
		return "<a href=" + s + "&operation=Delete>X<paper-ripple></paper-ripple></a>";
	}

	void printDisableForm(String s) throws java.lang.Exception {
		if (!request.isPost()) {
			outputStream
					.print("<FONT SIZE=+1>Are you sure you want to "
							+ s
							+ " all of the alerts?</FONT>"
							+ "<P>"
							+ getPagePOST("alert", s)
							+ "<TABLE WIDTH=100% BORDER=0><TR>"
							+ "<TD WIDTH=6%></TD><TD WIDTH=41%><input type=submit VALUE=\""
							+ s
							+ " Alerts\"></TD>"
							+ "<TD WIDTH=6%></TD><TD ALIGN=RIGHT WIDTH=41%><a href="
							+ getPageLink("alert", "List")
							+ ">Return to Alerts<paper-ripple></paper-ripple></a></TD><TD WIDTH=6%></TD>"
							+ "</TR></TABLE></FORM>");
			printFooter(outputStream);
			return;
		} else {
			disableAlerts(s.equals("Disable"));
			printRefreshPage(getPageLink("alert", "List"), 0);
			return;
		}
	}

	void disableAlerts(boolean flag) throws java.lang.Exception {
		jgl.Array array = getConditions();
		jgl.HashMap hashmap = new HashMap();
		for (int i = 0; i < array.size(); i++) {
			jgl.HashMap hashmap1 = (jgl.HashMap) array.at(i);
			hashmap.put(TextUtils.getValue(hashmap1,
					"group"), "true");
		}

		for (Enumeration enumeration = hashmap.keys(); enumeration
				.hasMoreElements(); com.dragonflow.SiteView.SiteViewGroup
				.SignalReload()) {
			String s = (String) enumeration.nextElement();
			jgl.Array array1;
			try {
				array1 = ReadGroupFrames(s);
			} catch (java.io.IOException ioexception) {
				throw new HTTPRequestException(557);
			}
			for (int j = 0; j < array1.size(); j++) {
				jgl.HashMap hashmap2 = (jgl.HashMap) array1.at(j);
				Enumeration enumeration1 = hashmap2
						.values("_alertCondition");
				if (!enumeration1.hasMoreElements()) {
					continue;
				}
				jgl.Array array2 = new Array();
				String s1;
				for (; enumeration1.hasMoreElements(); array2.add(s1)) {
					s1 = (String) enumeration1.nextElement();
					if (flag) {
						if (!s1.startsWith(DISABLED_EXPRESSION)) {
							s1 = DISABLED_EXPRESSION + s1;
						}
						continue;
					}
					if (s1.startsWith(DISABLED_EXPRESSION)) {
						s1 = s1.substring(DISABLED_EXPRESSION.length());
					}
				}

				hashmap2.put("_alertCondition", array2);
			}

			WriteGroupFrames(s, array1);
		}

	}

	void printDeleteForm(String s) throws java.lang.Exception {
		String s1 = request.getValue("group");
		String s2 = request.getValue("monitor");
		String s3 = request.getValue("id");
		jgl.Array array = ReadGroupFrames(com.dragonflow.Utils.I18N
				.toDefaultEncoding(s1));
		jgl.HashMap hashmap = com.dragonflow.Page.alertPage.findMonitor(array,
				s2);
		if (request.isPost()) {
			try {
				removeCondition(s1, s2, s3);
				printRefreshPage(getPageLink("alert", "List"), 0);
			} catch (java.lang.Exception exception) {
				printError("There was a problem deleting the alert.", exception
						.toString(), "/SiteView/"
						+ request.getAccountDirectory() + "/SiteView.html");
			}
		} else {
			jgl.HashMap hashmap1 = (jgl.HashMap) array.at(0);
			jgl.Array array1 = findCondition(s3);
			String s4 = conditionName(s1, hashmap, array1) + " ("
					+ displayName(s1, hashmap1, array1) + ")";
			outputStream
					.println("<FONT SIZE=+1>Are you sure you want to delete the alert for <B>"
							+ s4
							+ "</B>?</FONT>"
							+ "<p>"
							+ getPagePOST("alert", s)
							+ "<input type=hidden name=group value=\""
							+ s1
							+ "\">"
							+ "<input type=hidden name=monitor value=\""
							+ s2
							+ "\">"
							+ "<input type=hidden name=id value=\""
							+ s3
							+ "\">"
							+ "<TABLE WIDTH=\"100%\" BORDER=0><TR>"
							+ "<TD WIDTH=\"6%\"></TD><TD WIDTH=\"41%\"><input type=submit value=\""
							+ s
							+ " Alert\"></TD>"
							+ "<TD WIDTH=\"6%\"></TD><TD ALIGN=RIGHT WIDTH=\"41%\"><A HREF="
							+ getPageLink("alert", "List")
							+ ">Return to Detail<paper-ripple></paper-ripple></a></TD><TD WIDTH=\"6%\"></TD>"
							+ "</TR></TABLE></FORM>");
			printFooter(outputStream);
		}
	}

	String getString(int i) {
		return language[i];
	}

	public void printBody() throws java.lang.Exception {
		com.dragonflow.HTTP.HTTPRequest _tmp = request;
		if (request.languageID == com.dragonflow.HTTP.HTTPRequest.frenchID) {
			language = french;
		} else {
			language = english;
		}
		String operation = request.getValue("operation");
		String s1;
		if (operation.equals("List")) {
			s1 = "Alert Definitions";
		} else if (operation.startsWith("Report")) {
			s1 = "Quick Alert Report";
		} else if (operation.equals("AddList")) {
			s1 = "Add Alert";
		} else {
			s1 = operation + " Alert";
		}
		printBodyHeader(s1);
		if (operation.equals("AddList")) {
			printAddListForm(operation);
		} else if (operation.equals("List")) {
			printListForm(operation);
		} else if (operation.equals("Add")) {
			if (!request.actionAllowed("_alertEdit")) {
				throw new HTTPRequestException(557);
			}
			printAddForm(operation);
		} else if (operation.equals("Delete")) {
			if (!request.actionAllowed("_alertEdit")) {
				throw new HTTPRequestException(557);
			}
			printDeleteForm(operation);
		} else if (operation.equals("Edit")) {
			if (!request.actionAllowed("_alertEdit")) {
				throw new HTTPRequestException(557);
			}
			printAddForm(operation);
		} else if (operation.equals("Disable") || operation.equals("Enable")) {
			if (!request.actionAllowed("_alertDisable")) {
				throw new HTTPRequestException(557);
			}
			printDisableForm(operation);
		} else if (operation.equals("Report")) {
			if (!request.actionAllowed("_alertRecentReport")) {
				throw new HTTPRequestException(557);
			}
			printReportForm(operation);
		} else if (operation.equals("ReportForm")) {
			if (!request.actionAllowed("_alertAdhocReport")) {
				throw new HTTPRequestException(557);
			}
			printReportForm(operation);
		} else if (operation.startsWith("Test")) {
			if (!request.actionAllowed("_alertTest")) {
				throw new HTTPRequestException(557);
			}
			printTestForm(operation);
		} else {
			printError("The link was incorrect", "unknown operation",
					"/SiteView/" + request.getAccountDirectory()
							+ "/SiteView.html");
		}
	}

	public static void main(String args[]) throws java.io.IOException {
		com.dragonflow.Page.alertPage alertpage = new alertPage();
		if (args.length > 0) {
			alertpage.args = args;
		}
		alertpage.handleRequest();
	}

	jgl.Array findCondition(String s) throws java.lang.Exception {
		com.dragonflow.Api.Alert alert = com.dragonflow.Api.Alert.getInstance()
				.getByID((new Long(s)).longValue());
		return com.dragonflow.SiteView.Platform.split('\t', alert.getCondStr());
	}

	String packCondition(com.dragonflow.HTTP.HTTPRequest httprequest,
			String s, jgl.HashMap hashmap) {
		String s1 = "";
		String s2 = "";
		String s3 = "";
		String s4 = "";
		String s5 = "";
		String s6 = "";
		String s7 = httprequest.getValue("category");
		String s8 = httprequest.getValue("when") == null ? ""
				: httprequest.getValue("when");
		if (s8.equals("count")) {
			int i = com.dragonflow.Properties.StringProperty
					.toInteger(httprequest.getValue("errorCount"));
			if (i <= 0) {
				hashmap.put("when",
						"problem count must a number greater than zero");
			}
			s1 = " and " + s7 + "Count == "
					+ httprequest.getValue("errorCount");
		} else if (s8.equals("always")) {
			int j = com.dragonflow.Properties.StringProperty
					.toInteger(httprequest.getValue("alwaysErrorCount"));
			if (j <= 0) {
				hashmap.put("when",
						"problem count must a number greater than zero");
			}
			s1 = " and " + s7 + "Count >= "
					+ httprequest.getValue("alwaysErrorCount");
		} else if (s8.equals("multiple")) {
			int k = com.dragonflow.Properties.StringProperty
					.toInteger(httprequest.getValue("multipleStartCount"));
			if (k <= 0) {
				hashmap.put("when",
						"problem count must be a number greater than zero");
			}
			int j1 = com.dragonflow.Properties.StringProperty
					.toInteger(httprequest.getValue("multipleErrorCount"));
			if (j1 <= 0) {
				hashmap.put("when",
						"every count must be a number greater than zero");
			}
			if (j1 <= 0) {
				j1 = 1;
			}
			float f = j1;
			int k1 = k % j1;
			if (k1 < 1000) {
				f += (float) k1 / 1000F;
			}
			s1 = " and " + s7 + "Count >= " + k + " and " + s7
					+ "Count multipleOf " + f;
		} else if (s8.equals("allErrors")) {
			s1 = " and group.monitorsInGroup == group.monitorsInError and errorCount == 1";
		} else if (s8.equals("maxErrors")) {
			int l = com.dragonflow.Properties.StringProperty
					.toInteger(httprequest.getValue("maxErrorCount"));
			if (l <= 0) {
				hashmap.put("whenMaxErrors",
						"maximum count must be a number greater than zero");
			}
			s1 = " and group.maxErrorCount == "
					+ httprequest.getValue("maxErrorCount")
					+ " and errorCount == "
					+ httprequest.getValue("maxErrorCount");
		}
		if (httprequest.getValue("nameMatchString").length() > 0) {
			s3 = " and _name contains '"
					+ httprequest.getValue("nameMatchString") + "'";
		}
		if (httprequest.getValue("statusMatchString").length() > 0) {
			s5 = " and stateString contains '"
					+ httprequest.getValue("statusMatchString") + "'";
		}
		if (httprequest.getValue("classMatchString").length() > 0
				&& httprequest.getValue("classMatchString").indexOf("Any") < 0) {
			s4 = " and _class contains '"
					+ httprequest.getValue("classMatchString") + "'";
		}
		if (s7.equals("good")
				&& httprequest.getValue("usePreviousErrorCount").length() > 0) {
			int i1 = com.dragonflow.Properties.StringProperty
					.toInteger(httprequest.getValue("previousErrorCount"));
			if (i1 <= 0) {
				hashmap.put("previousErrorCount",
						"error count must be a number greater than zero");
			}
			s2 = " and errorCount >= "
					+ httprequest.getValue("previousErrorCount");
		}
		String s9 = "";
		String s10 = httprequest.getValue("alertDisable") == null ? ""
				: httprequest.getValue("alertDisable");
		if (s10.equals("permanent")) {
			if (httprequest.actionAllowed("_alertDisable")) {
				s9 = DISABLED_EXPRESSION;
			} else {
				hashmap.put("alertDisable", "Permission denied");
			}
		} else if (s10.equals("timed")) {
			if (httprequest.actionAllowed("_alertTempDisable")) {
				long l1 = com.dragonflow.Utils.TextUtils.toLong(httprequest
						.getValue("disableAlertTime"));
				if (l1 <= 0L) {
					hashmap.put("disableAlertTime",
							"Duration of alert disable missing");
				} else {
					String s11 = httprequest
							.getValue("disableAlertUnits");
					if (s11.equals("minutes")) {
						l1 *= com.dragonflow.Utils.TextUtils.MINUTE_SECONDS;
					} else if (s11.equals("hours")) {
						l1 *= com.dragonflow.Utils.TextUtils.HOUR_SECONDS;
					} else if (s11.equals("days")) {
						l1 *= com.dragonflow.Utils.TextUtils.DAY_SECONDS;
					}
					l1 *= 1000L;
					l1 += Platform.timeMillis();
					s6 = " and monitorDoneTime >= " + (new Long(l1)).toString();
					if (com.dragonflow.SiteView.AtomicMonitor.alertDebug) {
						com.dragonflow.Utils.TextUtils
								.debugPrint("alert disabled until "
										+ com.dragonflow.Utils.TextUtils
												.dateToString(l1));
					}
				}
			} else {
				hashmap.put("alertDisable", "Permission denied");
			}
		} else if (s10.equals("scheduled")) {
			if (httprequest.actionAllowed("_alertTempDisable")) {
				if (com.dragonflow.Utils.TextUtils
						.isDateStringValid(httprequest
								.getValue("startTimeDate"))
						&& com.dragonflow.Utils.TextUtils
								.isTimeStringValid(httprequest
										.getValue("startTimeTime"))
						&& com.dragonflow.Utils.TextUtils
								.isDateStringValid(httprequest
										.getValue("endTimeDate"))
						&& com.dragonflow.Utils.TextUtils
								.isTimeStringValid(httprequest
										.getValue("endTimeTime"))) {
					long l2 = com.dragonflow.Utils.TextUtils.toLong(httprequest
							.getUserSetting("_timeOffset")) * 1000L;
					long l3 = com.dragonflow.Utils.TextUtils
							.dateStringToSeconds(httprequest
									.getValue("startTimeDate"), httprequest
									.getValue("startTimeTime"));
					long l4 = com.dragonflow.Utils.TextUtils
							.dateStringToSeconds(httprequest
									.getValue("endTimeDate"), httprequest
									.getValue("endTimeTime"));
					long l5 = Platform.timeMillis() / 1000L;
					if (l4 <= Platform.timeMillis() / 1000L) {
						hashmap.put("alertDisable", "End time is in the past");
					}
					if (l3 > l4) {
						hashmap.put("alertDisable",
								"End time must be later than start time");
					}
					l3 *= 1000L;
					l4 *= 1000L;
					s6 = " and monitorDoneTime <= " + l3
							+ " or monitorDoneTime >= " + l4;
					String s12 = com.dragonflow.Utils.TextUtils
							.dateToString(l3 * 1000L - l2);
					String s13 = com.dragonflow.Utils.TextUtils
							.dateToString(l4 * 1000L - l2);
				} else {
					if (!com.dragonflow.Utils.TextUtils
							.isDateStringValid(httprequest
									.getValue("startTimeDate"))) {
						hashmap.put("startTimeDate",
								"Start date is invalid (use MM/DD/YY format)");
					}
					if (!com.dragonflow.Utils.TextUtils
							.isTimeStringValid(httprequest
									.getValue("startTimeTime"))) {
						hashmap.put("startTimeTime",
								"Start time is invalid (use HH:MM format)");
					}
					if (!com.dragonflow.Utils.TextUtils
							.isDateStringValid(httprequest
									.getValue("endTimeDate"))) {
						hashmap.put("endTimeDate",
								"End date is invalid (use MM/DD/YY format)");
					}
					if (!com.dragonflow.Utils.TextUtils
							.isTimeStringValid(httprequest
									.getValue("endTimeTime"))) {
						hashmap.put("endTimeTime",
								"End time is invalid (use HH:MM format)");
					}
				}
			} else {
				hashmap.put("alertDisable", "Permission denied");
			}
		} else if (s10.equals("undo")) {
			if (httprequest.actionAllowed("_alertDisable")
					|| httprequest.actionAllowed("_alertTempDisable")) {
				s6 = "";
				s9 = "";
			} else {
				hashmap.put("alertDisable", "Permission denied");
			}
		}
		return s9 + "category eq '" + s7 + "'" + s1 + s2 + s3 + s5 + s4 + s6
				+ "\t" + s;
	}

	jgl.HashMap replaceCondition(String s, String s1,
			String s2, String s3, String s4,
			String s5, String s6) {
		if (s.equals(s2) && s1.equals(s3)) {
			return mungeCondition(s, s1, s4, s5, s6);
		} else {
			removeCondition(s, s1, s4);
			return addCondition(s2, s3, s5, s6);
		}
	}

	void removeCondition(String s, String s1,
			String s2) {
		mungeCondition(s, s1, s2, null, null);
	}

	jgl.HashMap addCondition(String s, String s1,
			String s2, String s3) {
		return mungeCondition(s, s1, null, s2, s3);
	}

	jgl.HashMap mungeCondition(String s, String s1,
			String s2, String s3, String s4) {
		if (com.dragonflow.SiteView.AtomicMonitor.alertDebug) {
			com.dragonflow.Utils.TextUtils.debugPrint("group: " + s
					+ ", monitorID: " + s1 + ", id: " + s2 + ", cond: " + s3
					+ ", includeFilter: " + s4);
		}
		jgl.HashMap hashmap = null;
		try {
			jgl.Array array = ReadGroupFrames(s);
			hashmap = com.dragonflow.Page.alertPage.findMonitor(array, s1);
			if (s2 == null) {
				s2 = java.lang.Long
						.toString(com.dragonflow.ConfigurationManager.InternalIdsManager
								.getInstance().getNextSiteviewId());
			}
			String s5 = s3 + "\t" + s2;
			if (s4 != null) {
				s5 = s5 + "\t";
				if (s4 != null) {
					s5 = s5 + s4;
				}
				s5 = s5 + "\t";
			}
			jgl.Array array1 = new Array();
			boolean flag = false;
			Enumeration enumeration = hashmap
					.values("_alertCondition");
			if (com.dragonflow.SiteView.AtomicMonitor.alertDebug) {
				System.out.println("alertPage: Attempting to replace id: " + s2);
			}
			while (enumeration.hasMoreElements()) {
				String s6 = (String) enumeration
						.nextElement();
				jgl.Array array2 = Platform.split('\t',
						s6);
				if (array2.at(2).equals(s2)) {
					if (s3 != null) {
						array1.add(s5);
						flag = true;
						if (com.dragonflow.SiteView.AtomicMonitor.alertDebug) {
							System.out.println("alertPage: replacing id: " + s2 + " with: " + s6);
						}
					}
				} else {
					array1.add(s6);
				}
			}

			if (!flag && s3 != null) {
				array1.add(s5);
				if (com.dragonflow.SiteView.AtomicMonitor.alertDebug) {
					System.out.println("alertPage: we did not replace id: " + s2+ " with: " + s3);
				}
			}
			hashmap.put("_alertCondition", array1);
			if (com.dragonflow.SiteView.AtomicMonitor.alertDebug) {
				System.out.println("alertPage: here are the newConditions: "+ array1.toString());
			}
			WriteGroupFrames(s, array);
			com.dragonflow.SiteView.SiteViewGroup.SignalReload();
		} catch (java.io.IOException ioexception) {
		} catch (java.lang.Exception exception) {
		}
		return hashmap;
	}

	String getScriptList(String s) {
		StringBuffer stringbuffer = new StringBuffer();
		java.io.File file = new File(com.dragonflow.SiteView.Platform.getRoot()
				+ "/scripts/");
		String as[] = file.list();
		for (int i = 0; i < as.length; i++) {
			stringbuffer.append("<option ");
			if (as[i].equals(s)) {
				stringbuffer.append("SELECTED");
			}
			stringbuffer.append(" value=\"");
			stringbuffer.append(as[i]);
			stringbuffer.append("\">");
			stringbuffer.append(as[i]);
			stringbuffer.append("</option>\n");
		}

		return stringbuffer.toString();
	}

	String getActionClass(String s) {
		int i = s.indexOf(" ");
		if (i >= 0) {
			return com.dragonflow.Utils.TextUtils.toInitialUpper(s.substring(0,
					i));
		} else {
			return com.dragonflow.Utils.TextUtils.toInitialUpper(s);
		}
	}

	String displayName(String s, jgl.HashMap hashmap,
			jgl.Array array) {
		String s1 = null;
		if (array.size() > 3) {
			s1 = (String) array.at(3);
		}
		if (s.equals("_master")) {
			if (TextUtils.getValue(
					MasterConfig.getMasterConfig(),
					"_alertGroupDisplay").length() > 0) {
				if (s1 != null && s1.length() > 0) {
					return "multiple groups";
				} else {
					return "all groups";
				}
			}
			if (s1 != null && s1.length() > 0) {
				com.dragonflow.SiteView.SiteViewObject siteviewobject = getSiteView();
				StringBuffer stringbuffer = new StringBuffer();
				jgl.Array array1 = Platform.split(',',
						s1);
				for (int i = 0; i < array1.size(); i++) {
					String s2 = (String) array1.at(i);
					String as[] = com.dragonflow.Utils.TextUtils
							.split(s2);
					String s4 = as[0];
					com.dragonflow.SiteView.MonitorGroup monitorgroup = (com.dragonflow.SiteView.MonitorGroup) siteviewobject
							.getElement(s4);
					if (monitorgroup == null) {
						continue;
					}
					if (as.length > 1) {
						com.dragonflow.SiteView.Monitor monitor = (com.dragonflow.SiteView.Monitor) monitorgroup
								.getElementByID(as[1]);
						if (monitor != null) {
							com.dragonflow.Utils.TextUtils
									.addToBuffer(
											stringbuffer,
											com.dragonflow.Page.CGI
													.getGroupFullName(getGroupIDFull(monitorgroup
															.getProperty(com.dragonflow.SiteView.Monitor.pID)))
													+ ": "
													+ monitor
															.getProperty(com.dragonflow.SiteView.Monitor.pName));
						}
					} else {
						com.dragonflow.Utils.TextUtils
								.addToBuffer(
										stringbuffer,
										com.dragonflow.Page.CGI
												.getGroupFullName(getGroupIDFull(monitorgroup
														.getProperty(com.dragonflow.SiteView.Monitor.pID))));
					}
				}

				return stringbuffer.toString();
			} else {
				return "all groups";
			}
		}
		if (!com.dragonflow.SiteView.Platform.isStandardAccount(request
				.getValue("account"))
				&& s.equals(request.getValue("account"))) {
			if (s1 != null && s1.length() > 0) {
				com.dragonflow.SiteView.SiteViewObject siteviewobject1 = getSiteView();
				StringBuffer stringbuffer1 = new StringBuffer();
				jgl.Array array2 = Platform.split(',',
						s1);
				for (int j = 0; j < array2.size(); j++) {
					String s3 = (String) array2.at(j);
					String as1[] = com.dragonflow.Utils.TextUtils
							.split(s3);
					String s5 = as1[0];
					com.dragonflow.SiteView.MonitorGroup monitorgroup1 = (com.dragonflow.SiteView.MonitorGroup) siteviewobject1
							.getElement(s5);
					if (monitorgroup1 == null) {
						continue;
					}
					if (as1.length > 1) {
						com.dragonflow.SiteView.Monitor monitor1 = (com.dragonflow.SiteView.Monitor) monitorgroup1
								.getElementByID(as1[1]);
						if (monitor1 != null) {
							com.dragonflow.Utils.TextUtils
									.addToBuffer(
											stringbuffer1,
											com.dragonflow.Page.CGI
													.getGroupFullName(getGroupIDFull(monitorgroup1
															.getProperty(com.dragonflow.SiteView.Monitor.pID)))
													+ ": "
													+ monitor1
															.getProperty(com.dragonflow.SiteView.Monitor.pName));
						}
					} else {
						com.dragonflow.Utils.TextUtils
								.addToBuffer(
										stringbuffer1,
										com.dragonflow.Page.CGI
												.getGroupFullName(getGroupIDFull(monitorgroup1
														.getProperty(com.dragonflow.SiteView.Monitor.pID))));
					}
				}

				return stringbuffer1.toString();
			} else {
				return request.getValue("account");
			}
		} else {
			return com.dragonflow.Page.alertPage
					.getGroupFullName(com.dragonflow.Utils.I18N
							.toDefaultEncoding(getGroupIDFull(s)));
		}
	}

	public static String getGroupName(jgl.HashMap hashmap,
			String s) {
		String s1 = null;
		if (hashmap != null) {
			s1 = (String) hashmap.get("_name");
		}
		if (s1 == null || s1.equals("config") || s1.length() == 0) {
			s1 = com.dragonflow.Page.CGI.getGroupFullName(s);
		}
		if (com.dragonflow.SiteView.AtomicMonitor.alertDebug) {
			System.out.println("***id: " + s + ", name: " + s1);
		}
		return s1;
	}

	String conditionName(String s, jgl.HashMap hashmap,
			jgl.Array array) {
		String s2 = null;
		if (array.size() > 3) {
			s2 = (String) array.at(3);
		}
		String s1;
		if (s.equals("_master")) {
			if (s2 != null && s2.length() > 0) {
				s1 = "multiple monitors";
			} else {
				s1 = "any monitor";
			}
		} else if (isGroup(hashmap)) {
			if (s2 != null && s2.length() > 0) {
				s1 = "multiple monitors";
			} else {
				s1 = "any monitor in group";
			}
		} else {
			s1 = (String) hashmap.get("_name");
		}
		if (s1.equals("multiple monitors")) {
			com.dragonflow.SiteView.SiteViewGroup siteviewgroup = SiteViewGroup
					.currentSiteView();
			StringBuffer stringbuffer = new StringBuffer();
			jgl.Array array1 = Platform.split(',', s2);
			for (int i = 0; i < array1.size(); i++) {
				String s3 = (String) array1.at(i);
				if (s3.indexOf(' ') < 0) {
					continue;
				}
				com.dragonflow.SiteView.Monitor monitor = (com.dragonflow.SiteView.Monitor) siteviewgroup
						.getElement(com.dragonflow.Utils.I18N
								.toDefaultEncoding(s3.replace(' ', '/')));
				if (monitor != null) {
					com.dragonflow.Utils.TextUtils
							.addToBuffer(
									stringbuffer,
									monitor
											.getProperty(com.dragonflow.SiteView.Monitor.pName));
				}
			}

			if (stringbuffer.length() == 0) {
				stringbuffer.append(s1);
			}
			return stringbuffer.toString();
		} else {
			return s1;
		}
	}

	String getCategoryName(String s) {
		if (s.equals("error")) {
			return getString(alertErrorID);
		}
		if (s.equals("good")) {
			return getString(alertGoodID);
		} else {
			return getString(alertWarningID);
		}
	}

	String getAlertName(String s) {
		String s1 = "";
		String s2 = "alertName eq '";
		char ac[] = s.toCharArray();
		if (s.indexOf("alertName eq '") >= 0) {
			for (int i = s.indexOf(s2); i < s.length() && ac[i] != '\''; i++) {
				s1 = s1 + ac[i];
			}

		}
		return s1;
	}

	String getCategory(String s) {
		if (s.indexOf("category eq 'error'") >= 0) {
			return "error";
		}
		if (s.indexOf("category eq 'good'") >= 0) {
			return "good";
		} else {
			return "warning";
		}
	}

	String getDisabled(String s) {
		if (s.startsWith(DISABLED_EXPRESSION)) {
			return "disabled";
		}
		if (s.indexOf("monitorDoneTime") >= 0) {
			String s1 = ">=";
			String s2 = "<=";
			String s3 = s.substring(s.indexOf("monitorDoneTime"));
			java.util.StringTokenizer stringtokenizer = new StringTokenizer(s3,
					" ");
			String s4 = "";
			String s5 = "";
			while (stringtokenizer.hasMoreElements()) {
				String s6 = (String) stringtokenizer
						.nextElement();
				if (s6.equals("monitorDoneTime")) {
					String s7 = "";
					String s8 = "";
					if (stringtokenizer.hasMoreElements()) {
						s7 = (String) stringtokenizer.nextElement();
					}
					if (stringtokenizer.hasMoreElements()) {
						s8 = (String) stringtokenizer.nextElement();
					}
					if (s7.length() > 0 && s8.length() > 0) {
						if (s7.equals(s1)) {
							s4 = s8;
						} else if (s7.equals(s2)) {
							s5 = s8;
						}
					}
				}
			}

			if (s4.length() > 0
					&& (new Long(s4)).longValue() > com.dragonflow.SiteView.Platform
							.timeMillis()) {
				if (s5.length() > 0) {
					if ((new Long(s5)).longValue() < com.dragonflow.SiteView.Platform
							.timeMillis()) {
						return "disabled until "
								+ com.dragonflow.Utils.TextUtils
										.dateToString((new Long(s4))
												.longValue());
					}
				} else {
					return "disabled until "
							+ com.dragonflow.Utils.TextUtils
									.dateToString((new Long(s4)).longValue());
				}
			}
		}
		return "";
	}

	int getErrorCount(String s) {
		String s1 = "errorCount == ";
		int i = s.indexOf(s1);
		if (i < 0) {
			s1 = "warningCount == ";
			i = s.indexOf(s1);
		}
		if (i < 0) {
			s1 = "goodCount == ";
			i = s.indexOf(s1);
		}
		if (i != -1) {
			return java.lang.Math.max(0, com.dragonflow.Utils.TextUtils
					.readInteger(s, i + s1.length()));
		} else {
			return -1;
		}
	}

	int getPreviousErrorCount(String s) {
		String s1 = "errorCount >= ";
		int i = s.indexOf(s1);
		if (i != -1) {
			return java.lang.Math.max(0, com.dragonflow.Utils.TextUtils
					.readInteger(s, i + s1.length()));
		} else {
			return -1;
		}
	}

	int getAlwaysErrorCount(String s) {
		String s1 = "goodCount >= ";
		int i = s.indexOf(s1);
		if (i < 0) {
			s1 = "warningCount >= ";
			i = s.indexOf(s1);
		}
		if (i < 0) {
			s1 = "errorCount >= ";
			i = s.indexOf(s1);
		}
		if (i != -1) {
			return java.lang.Math.max(0, com.dragonflow.Utils.TextUtils
					.readInteger(s, i + s1.length()));
		} else {
			return -1;
		}
	}

	int getMultipleErrorCount(String s) {
		String s1 = "errorCount multipleOf ";
		int i = s.indexOf(s1);
		if (i < 0) {
			s1 = "warningCount multipleOf ";
			i = s.indexOf(s1);
		}
		if (i < 0) {
			s1 = "goodCount multipleOf ";
			i = s.indexOf(s1);
		}
		if (i != -1) {
			return java.lang.Math.max(0, com.dragonflow.Utils.TextUtils
					.readInteger(s, i + s1.length()));
		} else {
			return -1;
		}
	}

	int getMaxErrorCount(String s) {
		String s1 = "maxErrorCount == ";
		int i = s.indexOf(s1);
		if (i >= 0) {
			return java.lang.Math.max(0, com.dragonflow.Utils.TextUtils
					.readInteger(s, i + s1.length()));
		} else {
			return -1;
		}
	}

	String getStatusString(String s) {
		return getStringParameter(s, "stateString contains ");
	}

	String getNameString(String s) {
		return getStringParameter(s, "_name contains ");
	}

	String getClassString(String s) {
		return getStringParameter(s, "_class contains ");
	}

	String getStringParameter(String s, String s1) {
		int i = s.indexOf(s1);
		if (i >= 0) {
			byte byte0 = 32;
			i += s1.length();
			if (s.charAt(i) == '\'') {
				byte0 = 39;
				i++;
			}
			StringBuffer stringbuffer = new StringBuffer();
			char c = ' ';
			while (i < s.length()) {
				char c1 = s.charAt(i++);
				if (c1 == byte0 && c != 92) {
					break;
				}
				stringbuffer.append(c1);
				c = c1;
			}
			return stringbuffer.toString();
		} else {
			return "";
		}
	}

	jgl.HashMap parseCondition(String s, jgl.HashMap hashmap,
			String s1, String s2) {
		jgl.HashMap hashmap1 = new HashMap();
		hashmap1.put("raw", s);
		hashmap1.put("group", s1);
		hashmap1.put("monitor", s2);
		jgl.Array array = Platform.split('\t', s);
		String s3 = (String) array.at(0);
		String s4 = (String) array.at(1);
		String s5 = (String) array.at(2);
		String s6 = null;
		if (array.size() > 3) {
			s6 = (String) array.at(3);
		}
		String s7 = null;
		if (array.size() > 4) {
			s7 = (String) array.at(4);
		}
		if (com.dragonflow.SiteView.AtomicMonitor.alertDebug) {
			System.out.println("(" + array.size() + ")");
			System.out.println("expression(" + s3 + ")");
			System.out.println("action(" + s4 + ")");
			System.out.println("id(" + s5 + ")");
		}
		hashmap1.put("expression", s3);
		hashmap1.put("id", s5);
		hashmap1.put("action", s4);
		com.dragonflow.SiteView.Action action = Action
				.createAction(getActionClass(s4));
		com.dragonflow.SiteView.SiteViewObject siteviewobject = getSiteView();
		if (!s1.equals("_master")) {
			siteviewobject = siteviewobject
					.getElement(com.dragonflow.Utils.I18N.toDefaultEncoding(s1));
		}
		action.setOwner(siteviewobject);
		String s8 = siteviewobject.getFullID();
		if (!s2.equals("_config")) {
			s8 = s8 + "/" + s2;
		}
		hashmap1.put("fullID", s8 + "/" + s5);
		jgl.Array array1 = new Array();
		com.dragonflow.Properties.HashMapOrdered hashmapordered = new HashMapOrdered(
				true);
		getActionArguments(s4, array1, hashmapordered);
		action.initializeFromArguments(array1, hashmapordered);
		String s9 = getCategory(s3);
		hashmap1.put("category", s9);
		String s10 = getCategoryName(s9);
		int i = getErrorCount(s3);
		if (i != -1) {
			s10 = s10 + " x " + i;
		}
		int j = getMultipleErrorCount(s3);
		if (j != -1) {
			int k = getAlwaysErrorCount(s3);
			s10 = s10 + " at least x " + k + ", every " + j;
		} else {
			int l = getAlwaysErrorCount(s3);
			if (i == -1 && l > 1) {
				s10 = s10 + " at least x " + l;
			}
		}
		int i1 = getMaxErrorCount(s3);
		if (i1 != -1) {
			s10 = "group error x " + i1;
		}
		if (s3.indexOf("group.monitorsInError") >= 0) {
			s10 = "all in error";
		}
		String s11 = getStatusString(s3);
		if (s11.length() > 0) {
			s10 = s10 + ", status \"" + s11 + "\"";
		}
		String s12 = getDisabled(s3);
		if (s12.length() > 0) {
			s10 = "<B>(" + s12 + ")</B><BR>" + s10;
			hashmap1.put("disabled", "true");
		}
		hashmap1.put("on", s10);
		hashmap1.put("command", action.getClassProperty("label"));
		hashmap1.put("do", action.getActionDescription());
		String s13 = getNameString(s3);
		String s14 = conditionName(s1, hashmap, array);
		if (s13.length() > 0) {
			s14 = s14 + ", name \"" + s13 + "\"";
		}
		hashmap1.put("for", s14);
		hashmap1.put("groupName", displayName(s1, hashmap, array));
		return hashmap1;
	}

	void addConditions(jgl.Array array, jgl.HashMap hashmap,
			String s, String s1) {
		com.dragonflow.Utils.I18N.test(s, 1);
		if (com.dragonflow.SiteView.AtomicMonitor.alertDebug) {
			System.out.println("=" + hashmap + "=");
		}
		for (Enumeration enumeration = hashmap
				.values("_alertCondition"); enumeration.hasMoreElements();) {
			String s2 = (String) enumeration.nextElement();
			if (com.dragonflow.SiteView.AtomicMonitor.alertDebug) {
				System.out.println("<br>raw(" + s2 + ")");
			}
			try {
				jgl.HashMap hashmap1 = parseCondition(s2, hashmap, s, s1);
				array.add(hashmap1);
			} catch (java.lang.Exception exception) {
				outputStream
						.println("<hr><b>Error in alert</b>  Please report this problem to "
								+ com.dragonflow.SiteView.Platform.supportEmail
								+ "<ul>");
				outputStream.println("<li>alert=" + s2);
				outputStream.println("<li>monitor=" + s1);
				outputStream.println("<li>group="
						+ com.dragonflow.HTTP.HTTPRequest
								.encodeString(com.dragonflow.Utils.I18N
										.UnicodeToString(s,
												com.dragonflow.Utils.I18N
														.nullEncoding())));
				outputStream.println("<li>error=" + exception);
				outputStream.println("</ul>");
			}
		}

	}

	void printAddListForm(String s) {
		jgl.Array array = null;
		try {
			array = getActionClasses();
		} catch (java.lang.Exception exception) {
		}
		if (array == null) {
			printError("Could not read action classes",
					"Could not read action classes", "/SiteView/");
		}
		com.dragonflow.Page.CGI.menus menus1 = getNavItems(request);
		printButtonBar("Alert.htm", "Alerts", menus1);
		outputStream.println("<p><H2>Add Alert</H2>\n"
				+ getPageGET("alert", "Add"));
		outputStream
				.print("<TABLE BORDER=0 CELLSPACING=0><tr><td width=\"150\"><h3>Alerting on:</h3></td><td>&nbsp;&nbsp;&nbsp;</td><td valign=\"top\"><b>Choose the monitor status that should trigger the alert </b></td></tr></TABLE>\n<TABLE BORDER=0 CELLSPACING=4 width=\"50%\"><TR>\n<td><INPUT TYPE=RADIO NAME=category value=error checked><b>Error</b> </td>\n<td><INPUT TYPE=RADIO NAME=category value=warning><b>Warning</b> </td>\n<td><INPUT TYPE=RADIO NAME=category value=good><b>Ok</b></td></tr></table>\n");
		printClasses(
				array,
				"",
				"<HR>\n<TABLE BORDER=0 CELLSPACING=0><tr><td width=\"150\"><h3>Alert Type</h3></td>\n<td>&nbsp;&nbsp;&nbsp;</td><td valign=\"top\"><b>Choose the type of alert to create</b></td></tr></TABLE>");
		printClasses(
				array,
				"advanced",
				"<HR>\n<TABLE BORDER=0 CELLSPACING=0><tr><td width=\"180\"><h3>Advanced Alerts</h3>\n</td><td>&nbsp;&nbsp;&nbsp;</td><td valign=\"top\"><b>For specific needs of complex environments and may  require additional setup</b></td></tr></TABLE>");
		printClasses(
				array,
				"beta",
				"<HR>\n<TABLE BORDER=0 CELLSPACING=0><tr><td width=\"180\"><h3>Advanced Alerts</h3>\n</td><td>&nbsp;&nbsp;&nbsp;</td><td valign=\"top\"><b>Beta alerts are new features that are still under development.</b></td></tr></TABLE>");
		outputStream.println("</FORM>\n");
		printFooter(outputStream);
	}

	/**
	 *
	 *
	 * @param array
	 * @param s
	 * @param s1
	 */
	void printClasses(jgl.Array array, String s, String s1) {
		Enumeration enumeration;
		boolean flag;
		enumeration = array.elements();
		flag = false;

		java.lang.Class class1;
		while (enumeration.hasMoreElements()) {
			class1 = (java.lang.Class) enumeration.nextElement();
			String s2 = (String) com.dragonflow.SiteView.Monitor
					.getClassPropertyByObject(class1.getName(), "classType");
			if (s2 == null) {
				s2 = "";
			}
			if (!s2.equals(s)) {
				continue;
			}
			com.dragonflow.SiteView.Action action;
			String s3;
			try {
				action = (com.dragonflow.SiteView.Action) class1.newInstance();
				s3 = request.getPermission("_actionType",
						(String) action.getClassProperty("class"));
				if (s3.length() == 0) {
					s3 = request.getPermission("_actionType", "default");
				}
				if (!s3.equals("hidden")) {

					if (!flag) {
						flag = true;
						outputStream.print(s1
								+ "<TABLE BORDER=0 CELLSPACING=4 WIDTH=90%>");
					}
					String s4 = "";
					if ("Mailto".equals(action.getClassProperty("class"))) {
						s4 = "checked";
					}
					outputStream
							.print("<TR valign=\"top\"><TD valign=\"top\"><TD><input type=radio "
									+ s4
									+ " name=class value=\""
									+ action.getClassProperty("class")
									+ "\"></TD><TD valign=\"top\" width=\"180\">"
									+ action.getClassProperty("name")
									+ " Alert</TD>"
									+ "<TD valign=\"top\">"
									+ action.getClassProperty("description")
									+ "</TD><TD valign=\"top\"><A HREF=/SiteView/docs/"
									+ action.getClassProperty("help")
									+ " TARGET=Help>Help<paper-ripple></paper-ripple></a>" + "</TD></TR>");
				}

			} catch (java.lang.Exception exception) {
				outputStream.print("<BR>class: " + class1.getName()
						+ " error: " + enumeration);
			}
		}

		if (flag) {
			outputStream.print("</TABLE>\n");
			outputStream
					.print("<BR>&nbsp;&nbsp;<INPUT TYPE=SUBMIT VALUE=\"Define Alert\"><BR>");
		}
		return;
	}

	/**
	 *
	 *
	 * @return
	 * @throws java.io.IOException
	 */
	jgl.Array getConditions() throws java.io.IOException {
		jgl.Array array = new Array();
		jgl.HashMap hashmap = getMasterConfig();
		if (!request.getPermission("_editGlobalAlerts").equals("hidden")) {
			addConditions(array, hashmap, "_master", "_config");
		}
		jgl.Array array1 = new Array();
		jgl.Array array2 = getAllowedGroupIDs();
		SiteViewGroup siteviewgroup = SiteViewGroup.cCurrentSiteView;
		for (Enumeration enumeration = array2.elements(); enumeration
				.hasMoreElements();) {
			String s = (String) enumeration.nextElement();
			MonitorGroup monitor=siteviewgroup.getGroup(s);
			if(!s.equals("__Health__"))
			if(monitor!=null&&monitor.getFile()!=null&&!isTenantFile(request, monitor.getFile().getPath()))
				continue;
			jgl.Array array3 = ReadGroupFramesForPath(monitor.getFile().getPath());
			Enumeration enumeration2 = com.dragonflow.Page.alertPage
					.getMonitors(array3);
			jgl.HashMap hashmap1 = null;
			if (enumeration2.hasMoreElements()) {
				hashmap1 = (jgl.HashMap) enumeration2.nextElement();
			} else {
				hashmap1 = new HashMap();
			}
			addConditions(array, hashmap1, com.dragonflow.Utils.I18N
					.toNullEncoding(s), "_config");
			while (enumeration2.hasMoreElements()) {
				jgl.HashMap hashmap2 = (jgl.HashMap) enumeration2.nextElement();
				addConditions(array1, hashmap2, com.dragonflow.Utils.I18N
						.toNullEncoding(s), (String) hashmap2
						.get("_id"));
			}
		}
		Enumeration enumeration1 = array1.elements();

		while (enumeration1.hasMoreElements()) {
			array.add(enumeration1.nextElement());
		}
		return array;
	}
	boolean isTenantFile(HTTPRequest httpr,String file){
		String tenant=getTenant();
		if((tenant==null||tenant.length()==0))
			if(file.contains(File.separator+"groups"+File.separator+"tenants"+File.separator))
				return false;
			else
				return true;
		else{
			if(file.contains(File.separator+"groups"+File.separator+"tenants"+File.separator+tenant+File.separator))
				return true;
			else
				return false;
		}
	}
	jgl.Array getActionClasses() {
		jgl.Array array = new Array();
		jgl.HashMap hashmap = null;
		if (isPortalServerRequest()) {
			com.dragonflow.SiteView.PortalSiteView portalsiteview = (com.dragonflow.SiteView.PortalSiteView) getSiteView();
			if (portalsiteview != null) {
				hashmap = portalsiteview.getActionClassFilter();
			}
		}
		java.io.File file = new File(com.dragonflow.SiteView.Platform.getRoot()
				+ "/target/classes/com/dragonflow/StandardAction");
		String as[] = file.list();
		for (int i = 0; i < as.length; i++) {
			if (!as[i].endsWith(".class")) {
				continue;
			}
			int k = as[i].lastIndexOf(".class");
			String s = as[i].substring(0, k);
			if (hashmap != null && hashmap.get(s) == null) {
				continue;
			}
			try {
				java.lang.Class class1 = java.lang.Class
						.forName("com.dragonflow.StandardAction." + s);
				if (com.dragonflow.SiteView.SiteViewObject
						.loadableClass(class1)) {
					array.add(class1);
				}
			} catch (java.lang.Throwable throwable) {
			}
		}

		file = new File(com.dragonflow.SiteView.Platform.getRoot()
				+ "/classes/CustomAction");
		as = file.list();
		if (as != null) {
			for (int j = 0; j < as.length; j++) {
				if (!as[j].endsWith(".class")) {
					continue;
				}
				int l = as[j].lastIndexOf(".class");
				String s1 = as[j].substring(0, l);
				if (hashmap != null && hashmap.get(s1) == null) {
					continue;
				}
				try {
					java.lang.Class class2 = java.lang.Class
							.forName("CustomAction." + s1);
					if (com.dragonflow.SiteView.SiteViewObject
							.loadableClass(class2)) {
						array.add(class2);
					}
				} catch (java.lang.Throwable throwable1) {
				}
			}

		}
		return array;
	}

	void printNotAvailable(com.dragonflow.SiteView.Action action,
			String s) {
		String s1 = (String) action
				.getClassProperty("title");
		outputStream.print("<HR>The " + s1
				+ " Action cannot be added with a this account."
				+ "<HR><P><A HREF="
				+ com.dragonflow.Page.CGI.getGroupDetailURL(request, s)
				+ ">Return to Group<paper-ripple></paper-ripple></a>\n");
		printFooter(outputStream);
	}

	void printTooManyAlerts(com.dragonflow.SiteView.Action action,
			String s, int i, boolean flag) {
		String s1 = (String) action
				.getClassProperty("title");
		String s2 = "";
		if (flag) {
			s2 = " " + s1;
		}
		outputStream.print("<HR>");
		outputStream.print("You have reached your limit of " + i + s2
				+ " alerts for this account.");
		outputStream.println("<HR><P><A HREF="
				+ com.dragonflow.Page.CGI.getGroupDetailURL(request, s)
				+ ">Return to Group<paper-ripple></paper-ripple></a>\n");
		printFooter(outputStream);
	}

	jgl.HashMap getAlertStats() {
		if (alertStats == null) {
			try {
				jgl.Array array = getAllowedGroupIDs();
				alertStats = new HashMap();
				Enumeration enumeration = array.elements();
				do {
					if (!enumeration.hasMoreElements()) {
						break;
					}
					String s = (String) enumeration
							.nextElement();
					jgl.Array array1 = ReadGroupFrames(s);
					if (array1.size() >= 1) {
						updateAlertStats((jgl.HashMap) array1.at(0), alertStats);
						int i = 1;
						while (i < array1.size()) {
							jgl.HashMap hashmap = (jgl.HashMap) array1.at(i);
							if (com.dragonflow.SiteView.Monitor
									.isMonitorFrame(hashmap)) {
								updateAlertStats(hashmap, alertStats);
							}
							i++;
						}
					}
				} while (true);
				if (com.dragonflow.SiteView.Platform.isStandardAccount(request
						.getAccount())) {
					updateAlertStats(getMasterConfig(), alertStats);
				}
			} catch (java.io.IOException ioexception) {
				System.err
						.println("Could not read group file for group: "
								+ request.getAccount());
			}
		}
		if (alertStats == null) {
			alertStats = new HashMap();
		}
		return alertStats;
	}

	void updateAlertStats(jgl.HashMap hashmap, jgl.HashMap hashmap1) {
		for (Enumeration enumeration = hashmap
				.values("_alertCondition"); enumeration.hasMoreElements(); com.dragonflow.Utils.TextUtils
				.incrementEntry(hashmap1, "TotalAlerts")) {
			String s = (String) enumeration.nextElement();
			jgl.Array array = Platform.split('\t', s);
			String s1 = getActionClass((String) array.at(1));
			com.dragonflow.Utils.TextUtils.incrementEntry(hashmap1, s1
					+ "Count");
		}

	}

	/**
	 *
	 *
	 * @param s
	 */
	void printReportForm(String s) {
		int i;
		String s1;
		jgl.Array array1;
		Enumeration enumeration;
		com.dragonflow.Page.CGI.menus menus1 = getNavItems(request);
		printButtonBar("AlertReport.htm", "Alerts", menus1);
		jgl.Array array = getActionClasses();
		i = 0;
		s1 = "";
		array1 = new Array();
		Object obj = null;
		enumeration = array.elements();

		java.lang.Class class1;
		while (enumeration.hasMoreElements()) {
			class1 = (java.lang.Class) enumeration.nextElement();
			com.dragonflow.SiteView.Action action;
			String s2;
			try {
				action = (com.dragonflow.SiteView.Action) class1.newInstance();
				s2 = request.getPermission("_actionType",
						(String) action.getClassProperty("class"));
				if (s2.length() == 0) {
					s2 = request.getPermission("_actionType", "default");
				}
				if (!s2.equals("hidden")) {
					s1 = (String) action.getClassProperty("class");
					i++;
					array1.add(s1);
				}
			} catch (java.lang.Exception exception) {
				outputStream.println("<br>class: " + class1.getName()
						+ " error: " + exception);
			}
		}

		if (s.equals("Report")) {
			long l = com.dragonflow.Utils.TextUtils.toInt(request
					.getUserSetting("_timeOffset")) * 1000;
			long l1 = 0L;
			long l2 = 0L;
			if (request.getValue("startTimeTime").length() > 0) {
				if (com.dragonflow.Utils.TextUtils.isDateStringValid(request
						.getValue("startTimeDate"))
						&& com.dragonflow.Utils.TextUtils
								.isTimeStringValid(request
										.getValue("startTimeTime"))
						&& com.dragonflow.Utils.TextUtils
								.isDateStringValid(request
										.getValue("endTimeDate"))
						&& com.dragonflow.Utils.TextUtils
								.isTimeStringValid(request
										.getValue("endTimeTime"))) {
					long l3 = com.dragonflow.Utils.TextUtils
							.dateStringToSeconds(request
									.getValue("startTimeDate"), request
									.getValue("startTimeTime"));
					long l5 = com.dragonflow.Utils.TextUtils
							.dateStringToSeconds(request
									.getValue("endTimeDate"), request
									.getValue("endTimeTime"));
					l1 = l3 * 1000L - l;
					l2 = l5 * 1000L - l;
					l2 += 59999L;
				} else {
					outputStream
							.print("<H2>Quick Alert Report Error</H2><P><HR><UL>\n");
					outputStream.print("<LI>Invalid date or time entered");
					outputStream.print("</UL><HR></BODY></HTML>");
					return;
				}
			} else {
				long l4 = com.dragonflow.Utils.TextUtils.toLong(request
						.getUserSetting("_alertReportDefaultPeriod")) * 1000L;
				if (l4 <= 0L) {
					l4 = com.dragonflow.Utils.TextUtils.DAY_SECONDS * 1000;
				}
				l2 = Platform.timeMillis();
				l1 = l2 - l4;
			}
			java.util.Date date = new Date(l1);
			java.util.Date date1 = new Date(l2);
			jgl.Array array2 = getAllowedGroupIDs();
			jgl.HashMap hashmap = new HashMap(true);
			if (request.getValue("alert-type").equals("All")) {
				for (int i1 = 0; i1 < array1.size(); i1++) {
					hashmap.add("alert-type", array1.at(i1));
				}

			} else {
				hashmap.put("alert-type", request.getValue("alert-type"));
			}
			hashmap.put("alert-id", request.getValue("alert-id"));
			com.dragonflow.SiteView.AlertReport.generateReport(outputStream,
					hashmap, request.getValue("detailLevel"),
					array2.size() > 1, date, date1, (int) (l / 1000L), request
							.getAccount());
		} else {
			int j = com.dragonflow.Utils.TextUtils.toInt(request
					.getUserSetting("_timeOffset"));
			outputStream.println("<p><H2>Quick Alert Report</H2><p>"
					+ getPagePOST("alert", "Report"));
			outputStream
					.println("<B>Time Period</B>\n<BLOCKQUOTE><DL>\n<DT>\nFrom "
							+ com.dragonflow.Page.alertPage.getStartTimeHTML(j)
							+ " to "
							+ com.dragonflow.Page.alertPage.getEndTimeHTML(j)
							+ "<DD>Period of time over which to view the alerts\n"
							+ "</DL></BLOCKQUOTE>\n");
			StringBuffer stringbuffer = new StringBuffer();
			stringbuffer.append("<OPTION SELECTED VALUE=\"All\">All Types");
			for (int k = 0; k < array1.size(); k++) {
				stringbuffer.append("<OPTION VALUE=\"");
				stringbuffer.append(array1.at(k));
				stringbuffer.append("\">");
				stringbuffer.append((String) array1.at(k));
			}

			switch (i) {
			case 0: // '\0'
				outputStream
						.println("<input type=hidden name=alert-type value=\"\">");
				break;

			case 1: // '\001'
				outputStream
						.println("<input type=hidden name=alert-type value=\""
								+ s1 + "\">");
				break;

			default:
				outputStream
						.println("<B>Alert Type</B>\n<BLOCKQUOTE><DL>\n<DT>\n<SELECT name=alert-type SIZE=5 MULTIPLE>"
								+ stringbuffer.toString()
								+ "</SELECT>\n"
								+ "<DD>Type(s) of alerts to report on - select multiple types to view several types of alerts.\n"
								+ "</DL></BLOCKQUOTE>\n");
				break;
			}
			outputStream
					.println("<B>Detail Level</B>\n<BLOCKQUOTE><DL>\n<DT>\n<select name=detailLevel size=1><option value=basic>Basic<option value=detailonfail>Detail for Failed Alerts<option value=detail>Detail for All Alerts</select><DD>Select the detail level for the alert report.\nBasic shows the time and summary information for each alert sent. Detail for Failed Alerts is the same as Basic,\nexcept that any alerts that fail show the full diagnostic output for the alert. Detail for All Alerts shows the\nalert detail for each alert in the report.</DL></BLOCKQUOTE>\n");
			outputStream
					.println("<P><input type=submit value=\"View Alerts\"></FORM>\n");
		}
		printFooter(outputStream);
		return;
	}

	void printTestForm(String s) throws java.lang.Exception {
		com.dragonflow.Page.alertPage.printCurrentSiteView(outputStream,
				request);
		com.dragonflow.Page.CGI.menus menus1 = getNavItems(request);
		printButtonBar("Alert.htm", "Alerts", menus1);
		if (request.isPost()) {
			String s1 = "";
			String s2 = request.getValue("monitor");
			String s4 = request.getValue("alertID");
			boolean flag = false;
			com.dragonflow.SiteView.SiteViewObject siteviewobject1 = getSiteView();
			com.dragonflow.SiteView.Monitor monitor = (com.dragonflow.SiteView.Monitor) siteviewobject1
					.getElement(com.dragonflow.Utils.I18N.toDefaultEncoding(s2
							.replace(' ', '/')));
			outputStream.print("<P><H3>Testing alert...</H3>");
			outputStream.println("<HR>");
			if (!isPortalServerRequest()) {
				printContentStartComment();
				outputStream.println("<PRE>");
				if (monitor != null) {
					Enumeration enumeration = monitor
							.getActionRules();
					do {
						if (!enumeration.hasMoreElements()) {
							break;
						}
						com.dragonflow.SiteView.Rule rule = (com.dragonflow.SiteView.Rule) enumeration
								.nextElement();
						if (!rule.getFullID().equals(s4)) {
							continue;
						}
						rule.doAction(monitor, outputStream);
						flag = true;
						break;
					} while (true);
					if (!flag) {
						s1 = "Could not find the alert " + s4;
					}
				} else {
					s1 = "Could not find monitor " + s2;
				}
				if (s1.length() > 0) {
					outputStream
							.println("<H3>Error Testing Alert</H3><P>" + s1);
				}
				outputStream.println("</PRE>");
				printContentEndComment();
			} else {
				com.dragonflow.SiteView.PortalSiteView portalsiteview = (com.dragonflow.SiteView.PortalSiteView) getSiteView();
				if (portalsiteview != null) {
					String s11 = portalsiteview
							.getURLContentsFromRemoteSiteView(request,
									"_centrascopeTestMatch");
					outputStream.println(s11);
				}
			}
		} else {
			outputStream.println("<p><CENTER><H2>Alert Test</H2></CENTER><p>"
					+ getPagePOST("alert", "Test")
					+ "<input type=hidden name=alertID value=\""
					+ request.getValue("alertID") + "\">");
			outputStream
					.println("<P>Test the alert by running it using the current readings of the selected monitor.\nFor example, testing an E-mail alert using a CPU Monitor will result in an e-mail message with the CPU\nmonitor's last readings, resulting the same kind of E-mail alert you would receive if the monitor\nhad triggered the alert.<P>");
			int i = 1;
			String s3 = request.getValue("group");
			String s5 = "";
			if (com.dragonflow.Page.treeControl.useTree()) {
				String s6 = "Select the Groups and Monitors handled by this Alert.  To select several items, hold down the Control key (on most platforms) while clicking item names.\n";
				StringBuffer stringbuffer = new StringBuffer();
				if (s3.equals("_master")) {
					com.dragonflow.Page.treeControl treecontrol = new treeControl(
							request, "targets", false);
					treecontrol.process("Alert Subject(s)", "", s6, null, null,
							null, i, this, stringbuffer);
				} else if (request.getValue("monitor").equals("_config")) {
					jgl.Array array1 = com.dragonflow.Page.alertPage
							.expandSubgroupIDs(com.dragonflow.Utils.I18N
									.toDefaultEncoding(s3), this);
					com.dragonflow.Page.treeControl treecontrol1 = new treeControl(
							request, "targets", false);
					treecontrol1.process("Alert Subject(s)", "", s6, null,
							null, array1, i, this, stringbuffer);
				} else {
					com.dragonflow.SiteView.SiteViewObject siteviewobject2 = getSiteView();
					String s10 = s3 + " "
							+ request.getValue("monitor");
					com.dragonflow.SiteView.Monitor monitor2 = (com.dragonflow.SiteView.Monitor) siteviewobject2
							.getElement(com.dragonflow.Utils.I18N
									.toDefaultEncoding(s10.replace(' ', '/')));
					if (monitor2 != null) {
						s5 = "<option value=\""
								+ s10
								+ "\">"
								+ monitor2
										.getProperty(com.dragonflow.SiteView.Monitor.pName)
								+ "</option>";
					}
				}
			} else if (s3.equals("_master")) {
				s5 = getMonitorOptionsHTML(null, null, null, i);
			} else if (request.getValue("monitor").equals("_config")) {
				jgl.Array array = com.dragonflow.Page.alertPage
						.expandSubgroupIDs(com.dragonflow.Utils.I18N
								.toDefaultEncoding(s3), this);
				s5 = getMonitorOptionsHTML(null, null, array, i);
			} else {
				com.dragonflow.SiteView.SiteViewObject siteviewobject = getSiteView();
				String s8 = s3 + " " + request.getValue("monitor");
				com.dragonflow.SiteView.Monitor monitor1 = (com.dragonflow.SiteView.Monitor) siteviewobject
						.getElement(com.dragonflow.Utils.I18N
								.toDefaultEncoding(s8.replace(' ', '/')));
				if (monitor1 != null) {
					s5 = "<option value=\""
							+ s8
							+ "\">"
							+ monitor1
									.getProperty(com.dragonflow.SiteView.Monitor.pName)
							+ "</option>";
				}
			}
			outputStream.println("Monitor to Test With: ");
			String s7 = s5.toLowerCase();
			if (s7 != null && s7.length() > 0
					&& s7.indexOf("<option") == s7.lastIndexOf("<option")) {
				String as[] = { "  ", " " };
				String s9 = com.dragonflow.Utils.TextUtils
						.replaceString(s5.trim(), as);
				int j = s9.indexOf(">");
				outputStream.println("<input type=hidden name=monitor value="
						+ s9.substring(14, j) + ">" + s9.substring(j + 1));
			} else {
				outputStream.println("<select name=monitor size=1>\n" + s5
						+ "</select>\n");
			}
			outputStream
					.println("<p>&nbsp;</p><TABLE border=\"0\" width=\"90%\"><tr><td><input type=submit VALUE=\"Test Alert Settings\"></td><td width=\"25%\">&nbsp;</td><td align=right><A HREF="
							+ getPageLink("alert", "List")
							+ " style='display:relative;'>Back to Alerts List<paper-ripple></paper-ripple></a></TD>"
							+ "</TR></TABLE></FORM>");
		}
		printFooter(outputStream);
	}

	void getActionArguments(String s, jgl.Array array,
			jgl.HashMap hashmap) {
		int i = s.indexOf(" ");
		String as[];
		if (i >= 0) {
			as = com.dragonflow.Utils.TextUtils.split(s.substring(i + 1, s
					.length()));
		} else {
			as = new String[0];
		}
		for (int j = 0; j < as.length; j++) {
			int k = as[j].indexOf('=');
			if (k == -1) {
				as[j] = com.dragonflow.Utils.TextUtils.replaceString(as[j],
						com.dragonflow.SiteView.Action.EQUALS_SUBTITUTE, "=");
				array.add(as[j]);
			} else {
				as[j] = com.dragonflow.Utils.TextUtils.replaceString(as[j],
						com.dragonflow.SiteView.Action.EQUALS_SUBTITUTE, "=");
				hashmap.add(as[j].substring(0, k), as[j].substring(k + 1));
			}
		}

	}

	public static String getStartTimeHTML(long l, String s) {
		java.util.Date date = Platform.makeDate();
		l *= 1000L;
		long l1 = com.dragonflow.Page.alertPage.getDisableScheduleTime(
				"startTime", s);
		long l2 = com.dragonflow.Page.alertPage.getDisableScheduleTime(
				"endTime", s);
		long l3 = date.getTime() + l;
		if (l1 > 0L && l2 > l3) {
			l3 = l1;
		}
		return com.dragonflow.Page.alertPage.getTimeHTML(new Date(l3), "start");
	}

	public static String getEndTimeHTML(long l, String s) {
		java.util.Date date = Platform.makeDate();
		l *= 1000L;
		long l1 = com.dragonflow.Page.alertPage.getDisableScheduleTime(
				"endTime", s);
		long l2 = date.getTime() + l;
		if (l1 > 0L && l1 > l2) {
			l2 = l1;
		} else {
			l2 += 0x36ee80L;
		}
		return com.dragonflow.Page.alertPage.getTimeHTML(new Date(l2), "end");
	}

	static long getDisableScheduleTime(String s, String s1) {
		String s2 = "<=";
		String s3 = ">=";
		String s4 = "";
		long l = 0L;
		java.util.StringTokenizer stringtokenizer = new StringTokenizer(s1, " ");
		do {
			if (!stringtokenizer.hasMoreElements()) {
				break;
			}
			String s5 = (String) stringtokenizer
					.nextElement();
			if (s5.equals("monitorDoneTime")) {
				String s6 = (String) stringtokenizer
						.nextElement();
				if (s6.equals(s2) && s.equals("startTime")) {
					s4 = (String) stringtokenizer.nextElement();
				} else if (s6.equals(s3) && s.equals("endTime")) {
					s4 = (String) stringtokenizer.nextElement();
				}
			}
		} while (true);
		if (s4.length() > 0) {
			l = (new Long(s4)).longValue();
		}
		return l;
	}

	static boolean isTimedDisable(String s) {
		String s1 = "<=";
		for (java.util.StringTokenizer stringtokenizer = new StringTokenizer(s,
				" "); stringtokenizer.hasMoreElements();) {
			String s2 = (String) stringtokenizer
					.nextElement();
			if (s2.equals("monitorDoneTime")) {
				String s3 = (String) stringtokenizer
						.nextElement();
				if (s3.equals(s1)) {
					return false;
				}
			}
		}

		return true;
	}

	static boolean isScheduledDisable(String s) {
		String s1 = "<=";
		String s2 = ">=";
		boolean flag = false;
		boolean flag1 = false;
		for (java.util.StringTokenizer stringtokenizer = new StringTokenizer(s,
				" "); stringtokenizer.hasMoreElements();) {
			String s3 = (String) stringtokenizer
					.nextElement();
			if (s3.equals("monitorDoneTime")) {
				String s4 = (String) stringtokenizer
						.nextElement();
				if (s4.equals(s1)) {
					flag = true;
				} else if (s4.equals(s2)) {
					flag1 = true;
				}
			}
			if (flag1 && flag) {
				return true;
			}
		}

		return flag1 && flag;
	}

	static {
		alertArtID = 1;
		historyArtID = 2;
		helpArtID = 3;
		siteviewArtID = 4;
		groupArtID = 5;
		alertDetailID = 6;
		alertOnID = 7;
		alertForID = 8;
		alertDoID = 9;
		alertDelID = 10;
		alertEditID = 11;
		alertAddID = 12;
		alertPagerPrefsID = 13;
		alertMailPrefsID = 14;
		alertSNMPPrefsID = 15;
		alertTestMailID = 16;
		alertTestPagerID = 17;
		alertTestSNMPID = 18;
		alertErrorID = 19;
		alertWarningID = 20;
		alertGoodID = 21;
		alertRunID = 22;
		alertMailID = 23;
		alertPageID = 24;
		alertSNMPID = 25;
		alertCustomID = 26;
		alertAnyID = 27;
		alertGroupID = 28;
		alertNameID = 29;
		english = new String[100];
		english[alertArtID] = "alerts";
		english[historyArtID] = "reports";
		english[helpArtID] = "help";
		english[siteviewArtID] = "siteview";
		english[groupArtID] = "groups";
		english[alertDetailID] = "Alert Definitions";
		english[alertOnID] = "On";
		english[alertForID] = "For";
		english[alertDoID] = "Do";
		english[alertNameID] = "Name";
		english[alertDelID] = "Del";
		english[alertEditID] = "Edit an Alert by clicking the Edit link for the Alert.";
		english[alertAddID] = "Add";
		english[alertPagerPrefsID] = "Set Preferences</a> for Pager Alerts";
		english[alertMailPrefsID] = "Set Preferences</a> for Mail Alerts";
		english[alertSNMPPrefsID] = "Set Preferences</a> for SNMP Trap Alerts";
		english[alertTestPagerID] = "Send</a> a test alert to the pager";
		english[alertTestMailID] = "Send</a> a test alert using e-mail";
		english[alertTestSNMPID] = "Send</a> a test alert using SNMP";
		english[alertErrorID] = "error";
		english[alertWarningID] = "warning";
		english[alertGoodID] = "good";
		english[alertRunID] = "Run";
		english[alertMailID] = "Send Mail to";
		english[alertPageID] = "Send Page Message";
		english[alertSNMPID] = "Send SNMP Trap Message";
		english[alertCustomID] = "Custom";
		english[alertAnyID] = "any Monitor";
		english[alertGroupID] = "any Monitor in group";
		french = new String[100];
		french[alertArtID] = "alertsfr";
		french[historyArtID] = "reportsfr";
		french[helpArtID] = "helpfr";
		french[siteviewArtID] = "siteview";
		french[groupArtID] = "groupsfr";
		french[alertDetailID] = "Alerte D&eacute;taill&eacute;e";
		french[alertOnID] = "En";
		french[alertForID] = "Pour";
		french[alertDoID] = "Faire";
		french[alertNameID] = "nom";
		french[alertDelID] = "Effacer";
		french[alertEditID] = "Editer une Alerte en cliquant sur le nom de l'Alerte.";
		french[alertAddID] = "Ajouter";
		french[alertPagerPrefsID] = "Etablir les Pr&eacute;f&eacute;rences</a> des Alertes de Pager";
		french[alertMailPrefsID] = "Etablir les Pr&eacute;f&eacute;rences</a> des Alertes de E-mail";
		french[alertSNMPPrefsID] = "Etablir les Pr&eacute;f&eacute;rences</a> des Alertes de SNMP Trap";
		french[alertTestPagerID] = "Envoyer</a> une alerte d'essai au pager";
		french[alertTestMailID] = "Envoyer</a> une alerte d'essai par email";
		french[alertTestSNMPID] = "Envoyer</a> une alerte d'essai par SNMP trap";
		french[alertErrorID] = "erreur";
		french[alertWarningID] = "attention";
		french[alertGoodID] = "bon";
		french[alertRunID] = "Perform";
		french[alertMailID] = "Envoyer par email";
		french[alertPageID] = "Envoyer au pager";
		french[alertSNMPID] = "Envoyer par SNMP Trap";
		french[alertCustomID] = "Custom";
		french[alertAnyID] = "Tous les Monitors";
		french[alertGroupID] = "Tous les Monitors dans l'equipe";
	}
}

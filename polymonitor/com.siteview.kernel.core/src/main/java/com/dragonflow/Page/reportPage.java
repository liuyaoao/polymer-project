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
import java.util.Vector;

import jgl.Array;
import jgl.HashMap;

import com.alibaba.fastjson.JSONObject;
import com.dragonflow.Properties.HashMapOrdered;
import com.dragonflow.SiteView.CompareSlot;
import com.dragonflow.SiteView.Platform;
import com.dragonflow.SiteView.PortalFilter;
import com.dragonflow.SiteView.SiteViewGroup;
import com.dragonflow.Utils.TextUtils;

// Referenced classes of package com.dragonflow.Page:
// CGI, adhocReportPage, treeControl, portalChooserPage

public class reportPage extends com.dragonflow.Page.CGI {

	static final int MINUTE_SECONDS = 60;
	static final int HOUR_SECONDS = 3600;
	static final int DAY_SECONDS = 0x15180;
	static final int WEEK_SECONDS = 0x93a80;
	static final int MONTH_SECONDS = 0x278d00;
	static final int nScheduledTimePeriods[] = { 3600, 7200, 10800, 14400, 21600, 28800, 43200, 57600, 0x15180, 0x2a300,
			0x3f480, 0x54600, 0x69780, 0x93a80, 0x278d00 };
	static final int nAdhocTimePeriods[] = { 900, 1800, 3600, 7200, 10800, 14400, 18000, 21600, 25200, 28800, 32400,
			36000, 39600, 43200, 57600, 0x15180, 0x2a300, 0x3f480, 0x54600, 0x69780, 0x7e900, 0x93a80, 0x127500,
			0x1baf80, 0x278d00 };
	static final String TOPAZ_CONFIG_REPORT = "siteview/conf/sample_dispatcher?action=log";
	static final String strValueMonthToDate = "monthToDate";
	static final String strLabelMonthToDate = "month-to-date";
	static final String timeScaleSettings[] = { "default", "60", "120", "300", "600", "900", "1800", "3600", "7200",
			"21600", "43200", "86400" };
	String vertScaleSettings[] = { "", "1", "5", "10", "20", "50", "100", "500", "1000", "5000", "10000", "20000",
			"50000", "100000", "1000000", "10000000" };
	String email;
	String emailData;
	String xmlEmailData;
	String reportTitle;
	String mailTemplate;
	String queryID;
	String portalQuery;
	String title;
	String description;
	String disabledChecked;
	String detailedChecked;
	String attachReportChecked;
	String tabfileChecked;
	String xmlfileChecked;
	String bestCaseCalcChecked;
	String statusFilter;
	String schedFilter;
	String operation;
	String page;
	String operationString;
	String helpFile;
	String errors;
	String hiddenQueryID;
	String hoursOptions;
	String minutesOptions;
	String windowsOptions;
	String precisionOptions;
	String formatOptions;
	String vmaxOptions;
	String startHourOptions;
	String startTimeHTML;
	String endTimeHTML;
	String monitorOptionsHTML;
	String reportTypeHTML;
	int scheduleHour;
	int scheduleMinute;
	boolean readOnly;

	public reportPage() {
		email = "";
		emailData = "";
		xmlEmailData = "";
		reportTitle = "";
		mailTemplate = "";
		queryID = "";
		portalQuery = "";
		title = "History";
		description = "";
		disabledChecked = "";
		detailedChecked = "";
		attachReportChecked = "";
		tabfileChecked = "";
		xmlfileChecked = "";
		bestCaseCalcChecked = "";
		statusFilter = "";
		schedFilter = "";
		operation = "adhoc";
		page = "report";
		operationString = "Show Quick";
		helpFile = "AddHist.htm";
		errors = "";
		hiddenQueryID = "";
		hoursOptions = "";
		minutesOptions = "";
		windowsOptions = "";
		precisionOptions = "";
		formatOptions = "";
		vmaxOptions = "";
		startHourOptions = "";
		startTimeHTML = "";
		endTimeHTML = "";
		monitorOptionsHTML = "";
		reportTypeHTML = "";
		scheduleHour = 1;
		scheduleMinute = 0;
		readOnly = false;
	}

	public com.dragonflow.Page.CGI.menus getNavItems(com.dragonflow.HTTP.HTTPRequest httprequest) {
		com.dragonflow.Page.CGI.menus menus1 = new CGI.menus();
		if (httprequest.actionAllowed("_browse")) {
			menus1.add(new CGI.menuItems("Browse", "browse", "", "page", "Browse Monitors"));
		}
		if (httprequest.actionAllowed("_progress")) {
			menus1.add(new CGI.menuItems("Progress", "Progress", "", "url", "View current monitoring progress"));
		}
		if (httprequest.actionAllowed("_browse")) {
			menus1.add(new CGI.menuItems("Summary", "monitorSummary", "", "page", "View current monitor settings"));
		}
		if (httprequest.actionAllowed("_reportEdit")) {
			menus1.add(new CGI.menuItems("Add Report", "report", "add", "operation", "Add a new automated report"));
		}
		if (httprequest.actionAllowed("_reportAdhoc")) {
			menus1.add(new CGI.menuItems("Quick Report", "report", "adhoc", "operation", "Create an adhoc report"));
		}
		return menus1;
	}

	public static void printReportPage(java.io.PrintWriter printwriter, String s,
			com.dragonflow.HTTP.HTTPRequest httprequest) throws java.lang.Exception {
		int i = s.indexOf("/accounts");
		int j = s.indexOf("/htdocs");
		if (i != -1 && j != -1) {
			s = s.substring(0, i) + s.substring(j);
		}
		String s1 = com.dragonflow.Utils.FileUtils.readEncFile(s, com.dragonflow.Utils.I18N.nullEncoding()).toString();
		if (!httprequest.getAccount().equals("administrator") && !httprequest.getAccount().equals("user")
				&& s.endsWith(".html")) {
			if (!httprequest.actionAllowed("_reportGenerate")) {
				int k = s1.indexOf("<FORM");
				if (k != -1) {
					int l = s1.indexOf("<CENTER>", k);
					if (l != -1) {
						s1 = s1.substring(0, k) + s1.substring(l);
					}
				}
			}
			s1 = com.dragonflow.Utils.TextUtils.replaceString(s1, "/SiteView/htdocs/Reports-",
					"/SiteView/accounts/" + httprequest.getAccount() + "/htdocs/Reports-");
			s1 = com.dragonflow.Utils.TextUtils.replaceString(s1, "/SiteView/accounts/administrator/htdocs",
					"/SiteView/accounts/" + httprequest.getAccount() + "/htdocs");
			s1 = com.dragonflow.Utils.TextUtils.replaceString(s1, "/SiteView/htdocs/SiteView.html",
					"/SiteView/accounts/" + httprequest.getAccount() + "/htdocs/SiteView.html");
			s1 = com.dragonflow.Utils.TextUtils.replaceString(s1, "name=account value=administrator",
					"name=account value=" + httprequest.getAccount());
			s1 = com.dragonflow.Utils.TextUtils.replaceString(s1, "account=administrator",
					"account=" + httprequest.getAccount());
		}
		printwriter.print(s1);
	}

	public void printBody() throws java.lang.Exception {
		operation = request.getValue("operation");
		if (operation.length() == 0) {
			operation = "List";
		}
		if (operation.equals("List")) {
			printList();
			return;
		} else {
			printReportBody();
			return;
		}
	}

	private void printReportBody() throws java.lang.Exception {
		label0: {
			int i;
			java.lang.Object obj;
			label1: {
				if (operation.toLowerCase().indexOf("add") >= 0) {
					operationString = "Add";
				} else if (operation.toLowerCase().indexOf("edit") >= 0) {
					operationString = "Edit";
				} else if (operation.toLowerCase().indexOf("adhoc") >= 0) {
					operationString = "Show Quick";
				}
				queryID = request.getValue("queryID");
				boolean flag = true;
				i = com.dragonflow.Utils.TextUtils.toInt(request.getUserSetting("_timeOffset"));
				obj = null;
				if (!com.dragonflow.Page.treeControl.useTree()) {
					if (operation.equals("adhoc")) {
						page = "adhocReport";
					}
				} else if (request.isPost() && com.dragonflow.Page.treeControl.notHandled(request)
						&& operation.equals("adhoc")) {
					page = "adhocReport";
					com.dragonflow.Page.adhocReportPage adhocreportpage = new adhocReportPage();
					adhocreportpage.request = request;
					adhocreportpage.outputStream = outputStream;
					adhocreportpage.printBody();
					return;
				}
				if (operation.equals("Delete")) {
					flag = false;
					if (request.isPost() && com.dragonflow.Page.treeControl.notHandled(request)) {
						deleteHistoryReport(queryID);
						printRefreshHeader();
					} else {
						outputStream.println(
								"<FONT SIZE=+1>Are you sure you want to delete the report?</FONT><p><FORM ACTION=/SiteView/cgi/go.exe/SiteView method=POST><input type=hidden name=page value=report><input type=hidden name=operation value=\""
										+ operation + "\">" + "<input type=hidden name=queryID value=\"" + queryID
										+ "\">" + "<input type=hidden name=account value=" + request.getAccount() + ">"
										+ "<TABLE WIDTH=\"100%\" BORDER=0><TR>"
										+ "<TD WIDTH=\"6%\"></TD><TD WIDTH=\"41%\"><input type=submit value=\""
										+ operation + " Report\"></TD>"
										+ "<TD WIDTH=\"6%\"></TD><TD ALIGN=RIGHT WIDTH=\"41%\"><A HREF="
										+ CGI.getTenant(request.getURL())
										+ "/SiteView/cgi/go.exe/SiteView?page=report&operation=List&account="
										+ request.getAccount()
										+ ">Return to Detail<paper-ripple></paper-ripple></a></TD><TD WIDTH=\"6%\"></TD>"
										+ "</TR></TABLE></FORM>");
						printFooter(outputStream);
					}
				}
				if (flag && request.isPost() && com.dragonflow.Page.treeControl.notHandled(request)) {
					obj = new HashMapOrdered(true);
					boolean flag1 = com.dragonflow.Page.reportPage.setReportOptions(request, ((jgl.HashMap) (obj)));
					Enumeration enumeration = request.getValues("monitors");
					if (!enumeration.hasMoreElements() && !flag1 && request.getValue("query").length() == 0) {
						errors += "\tNo monitors were selected for this report";
					}
					String s2;
					for (; enumeration.hasMoreElements(); ((jgl.HashMap) (obj)).add("monitors", s2)) {
						s2 = (String) enumeration.nextElement();
						if (com.dragonflow.Page.treeControl.useTree()) {
							s2 = com.dragonflow.HTTP.HTTPRequest.decodeString(s2);
						}
					}

					if (queryID.length() > 0) {
						((jgl.HashMap) (obj)).put("id", queryID);
					}
					((jgl.HashMap) (obj)).put("window", request.getValue("window"));
					((jgl.HashMap) (obj)).put("precision", request.getValue("precision"));
					((jgl.HashMap) (obj)).put("format", request.getValue("format"));
					((jgl.HashMap) (obj)).put("vmax", request.getValue("vmax"));
					String s3 = request.getValue("startHour");
					if (!s3.equals("now")) {
						s3 = String.valueOf(com.dragonflow.Utils.TextUtils.toLong(s3) - (long) i);
					}
					if (com.dragonflow.SiteView.Platform.isPortal()) {
						((jgl.HashMap) (obj)).put("query",
								com.dragonflow.Page.portalChooserPage.getQueryChooseListSelectedItem(request));
					}
					((jgl.HashMap) (obj)).put("startHour", s3);
					((jgl.HashMap) (obj)).put("startDay", request.getValue("startDay"));
					((jgl.HashMap) (obj)).put("relative", request.getValue("relative"));
					((jgl.HashMap) (obj)).put("email",
							com.dragonflow.Utils.TextUtils.toEmailList(request.getValue("email")));
					((jgl.HashMap) (obj)).put("emailData",
							com.dragonflow.Utils.TextUtils.toEmailList(request.getValue("emailData")));
					((jgl.HashMap) (obj)).put("xmlEmailData",
							com.dragonflow.Utils.TextUtils.toEmailList(request.getValue("xmlEmailData")));
					((jgl.HashMap) (obj)).put("mailTemplate", request.getValue("mailTemplate"));
					((jgl.HashMap) (obj)).put("title", request.getValue("title"));
					((jgl.HashMap) (obj)).put("description", request.getValue("description"));
					((jgl.HashMap) (obj)).put("statusFilter", request.getValue("statusFilter"));
					((jgl.HashMap) (obj)).put("schedFilter", request.getValue("schedFilter"));
					if (TextUtils.getValue(((jgl.HashMap) (obj)), "mailTemplate").equals("HistoryMail")) {
						((jgl.HashMap) (obj)).remove("mailTemplate");
					}
					((jgl.HashMap) (obj)).put("noSlotFilter", "true");
					if (request.getValue("tabfile").length() > 0) {
						((jgl.HashMap) (obj)).put("tabfile", "yes");
					}
					if (request.getValue("xmlfile").length() > 0) {
						((jgl.HashMap) (obj)).put("xmlfile", "yes");
					}
					if (request.getValue("disabled").length() > 0) {
						((jgl.HashMap) (obj)).put("disabled", "checked");
					}
					if (request.getValue("detailed").length() == 0) {
						((jgl.HashMap) (obj)).put("basic", "checked");
					}
					if (request.getValue("attachReport").length() > 0) {
						((jgl.HashMap) (obj)).put("attachReport", "checked");
					}
					if (request.getValue("bestCaseCalc").length() > 0) {
						((jgl.HashMap) (obj)).put("bestCaseCalc", "checked");
					}
					int k = 0x15180;
					int l = 1;
					int i1 = 0;
					try {
						k = com.dragonflow.Utils.TextUtils.toInt(request.getValue("window"));
						l = com.dragonflow.Utils.TextUtils.toInt(request.getValue("hours"));
						i1 = com.dragonflow.Utils.TextUtils.toInt(request.getValue("minutes"));
					} catch (java.lang.NumberFormatException numberformatexception) {
						com.dragonflow.Log.LogManager.log("Error",
								"A number was passed from the browser reportPage that did not parse as an integer. It was 'window', 'hours', or 'minutes': "
										+ numberformatexception.toString());
						com.dragonflow.Log.LogManager.log("Error", "reportPage is unhappy: "
								+ com.dragonflow.Utils.FileUtils.stackTraceText(numberformatexception));
					}
					int j1 = (l + i1) - i;
					String s9;
					if (k == 0x278d00) {
						s9 = "monthday\t1\t" + j1;
					} else if (k == 0x93a80) {
						s9 = "weekday\tU\t" + j1;
					} else {
						s9 = "weekday\tM,T,W,R,F,S,U\t" + j1;
					}
					((jgl.HashMap) (obj)).put("schedule", s9);
					if (com.dragonflow.SiteView.Platform.isPortal()) {
						((jgl.HashMap) (obj)).put("account", request.getAccount());
					}
					if (errors.length() == 0) {
						flag = false;
						if (operation.equals("add")) {
							addHistoryReport(((jgl.HashMap) (obj)));
						} else {
							changeHistoryReport(((jgl.HashMap) (obj)));
						}
						printRefreshHeader();
					}
				}
				if (!flag) {
					break label0;
				}
				title = operationString + " Management Report";
				if (obj != null || queryID.length() <= 0) {
					break label1;
				}
				jgl.Array array = com.dragonflow.Page.reportPage.getReportFrames(request.getAccount());
				Enumeration enumeration1 = array.elements();
				jgl.HashMap hashmap;
				String s5;
				do {
					if (!enumeration1.hasMoreElements()) {
						break label1;
					}
					hashmap = (jgl.HashMap) enumeration1.nextElement();
					s5 = TextUtils.getValue(hashmap, "id");
				} while (!s5.equals(queryID));
				obj = hashmap;
				hiddenQueryID = "<input type=hidden name=queryID value=" + queryID + ">\n";
			}
			if (obj == null) {
				if (!operation.equals("adhoc")) {
					jgl.Array array1 = com.dragonflow.Page.reportPage.getReportFrames(request.getAccount());
					int j = request.getPermissionAsInteger("_maximumReportsCount");
					if (j > 0 && array1.size() >= j) {
						printTooManyReports(request.getAccount(), j);
						return;
					}
				}
				obj = new HashMap();
				((jgl.HashMap) (obj)).add("precision", "default");
				((jgl.HashMap) (obj)).add("format", "");
				((jgl.HashMap) (obj)).add("vmax", "");
				((jgl.HashMap) (obj)).add("startDay", "today");
				((jgl.HashMap) (obj)).add("startHour", "now");
				((jgl.HashMap) (obj)).add("basic", "checked");
				if (operation.equals("adhoc")) {
					((jgl.HashMap) (obj)).add("window", String.valueOf(3600));
				} else {
					((jgl.HashMap) (obj)).add("schedule", "weekday\tM,T,W,R,F,S,U\t3600");
					((jgl.HashMap) (obj)).add("window", String.valueOf(0x15180));
				}
				((jgl.HashMap) (obj)).add("relative", "-1");
			}
			String s = TextUtils.getValue(((jgl.HashMap) (obj)), "tabfile");
			if (s != null && s.length() > 0) {
				tabfileChecked = "CHECKED";
			}
			String s1 = TextUtils.getValue(((jgl.HashMap) (obj)), "xmlfile");
			if (s1 != null && s1.length() > 0) {
				xmlfileChecked = "CHECKED";
			}
			String s4 = TextUtils.getValue(((jgl.HashMap) (obj)), "disabled");
			if (s4.length() > 0) {
				disabledChecked = "CHECKED";
			}
			String s6 = TextUtils.getValue(((jgl.HashMap) (obj)), "basic");
			if (s6.length() == 0) {
				detailedChecked = "CHECKED";
			}
			String s7 = TextUtils.getValue(((jgl.HashMap) (obj)), "attachReport");
			if (s7.length() > 0) {
				attachReportChecked = "CHECKED";
			}
			String s8 = TextUtils.getValue(((jgl.HashMap) (obj)), "bestCaseCalc");
			if (s8.length() > 0) {
				bestCaseCalcChecked = "CHECKED";
			}
			email = TextUtils.getValue(((jgl.HashMap) (obj)), "email");
			emailData = TextUtils.getValue(((jgl.HashMap) (obj)), "emailData");
			xmlEmailData = TextUtils.getValue(((jgl.HashMap) (obj)), "xmlEmailData");
			reportTitle = TextUtils.getValue(((jgl.HashMap) (obj)), "title");
			description = TextUtils.getValue(((jgl.HashMap) (obj)), "description");
			statusFilter = TextUtils.getValue(((jgl.HashMap) (obj)), "statusFilter");
			schedFilter = TextUtils.getValue(((jgl.HashMap) (obj)), "schedFilter");
			if (reportTitle.length() > 0) {
				title = operationString + " : " + reportTitle;
			}
			mailTemplate = TextUtils.getValue(((jgl.HashMap) (obj)), "mailTemplate");
			String s10 = TextUtils.getValue(((jgl.HashMap) (obj)), "schedule");
			scheduleHour = 1;
			scheduleMinute = 0;
			if (s10 != null && s10.length() > 0) {
				String as[] = com.dragonflow.Utils.TextUtils.split(s10, "\t");
				int k1 = com.dragonflow.Utils.TextUtils.stringToDaySeconds(as[2]);
				k1 += i;
				scheduleHour = k1 / 3600;
				scheduleMinute = (k1 % 3600) / 60;
			}
			computeMonitorOptions(((jgl.HashMap) (obj)));
			hoursOptions = getHoursHTML(scheduleHour);
			minutesOptions = getMinutesHTML(scheduleMinute);
			String s11 = TextUtils.getValue(((jgl.HashMap) (obj)), "window");
			windowsOptions = getTimePeriodHTML(s11);
			String s12 = TextUtils.getValue(((jgl.HashMap) (obj)), "precision");
			precisionOptions = getTimeScaleHTML(s12);
			String s13 = TextUtils.getValue(((jgl.HashMap) (obj)), "format");
			formatOptions = getFormatHTML(s13);
			String s14 = TextUtils.getValue(((jgl.HashMap) (obj)), "vmax");
			vmaxOptions = getVertScaleHTML(s14);
			String s15 = TextUtils.getValue(((jgl.HashMap) (obj)), "startHour");
			startHourOptions = getStartHourHTML(s15, i);
			startTimeHTML = com.dragonflow.Page.reportPage.getStartTimeHTML(i);
			endTimeHTML = com.dragonflow.Page.reportPage.getEndTimeHTML(i);
			reportTypeHTML = getReportTypeHTML(((jgl.HashMap) (obj)));
			if (com.dragonflow.SiteView.Platform.isPortal()) {
				helpFile = "CentraReports.htm";
			}
			if (operation.equals("adhoc")) {
				helpFile = "EditQuick.htm";
				if (com.dragonflow.SiteView.Platform.isPortal()) {
					helpFile = "QuickReport.htm";
				}
			}
			if (operation.equals("edit") || operation.equals("add")) {
				helpFile = "EditHist.htm";
				if (com.dragonflow.SiteView.Platform.isPortal()) {
					helpFile = "MgntReport.htm";
				}
			}
			if (request.getValue("item").length() > 0) {
				portalQuery = null;
			} else {
				portalQuery = TextUtils.getValue(((jgl.HashMap) (obj)), "query");
			}
			printHeader();
			printForm();
			printFooter(outputStream);
		}
	}

	void deleteHistoryReport(String s) {
		adjustHistoryConfig(null, s);
	}

	void addHistoryReport(jgl.HashMap hashmap) {
		adjustHistoryConfig(hashmap, null);
	}

	void changeHistoryReport(jgl.HashMap hashmap) {
		adjustHistoryConfig(hashmap, TextUtils.getValue(hashmap, "id"));
	}

	void adjustHistoryConfig(jgl.HashMap hashmap, String s) {
		jgl.Array array = null;
		array = getReportFrameList();
		jgl.Array array1;
		if (hashmap != null && s == null) {
			try {
				jgl.HashMap hashmap1 = getMasterConfig();
				if (!request.isStandardAccount()) {
					hashmap1 = (jgl.HashMap) array.at(0);
				} else {
					hashmap1 = getMasterConfig();
				}
				s = TextUtils.getValue(hashmap1, "_nextReportID");
				if (s.length() == 0) {
					s = "10";
				}
				hashmap1.put("_nextReportID", com.dragonflow.Utils.TextUtils.increment(s));
				if (request.isStandardAccount()) {
					saveMasterConfig(hashmap1);
				}
				hashmap.put("id", s);
			} catch (java.io.IOException ioexception) {
				System.err.println("Could not read history configuration");
				com.dragonflow.Log.LogManager.log("Error",
						"reportPage is unhappy: " + com.dragonflow.Utils.FileUtils.stackTraceText(ioexception));
			}
			array1 = array;
			array1.add(hashmap);
		} else {
			array1 = new Array();
			Enumeration enumeration = array.elements();
			do {
				if (!enumeration.hasMoreElements()) {
					break;
				}
				jgl.HashMap hashmap2 = (jgl.HashMap) enumeration.nextElement();
				String s1 = TextUtils.getValue(hashmap2, "id");
				if (s1 != null && s1.equals(s) && com.dragonflow.SiteView.Monitor.isReportFrame(hashmap2)) {
					if (hashmap != null) {
						array1.add(hashmap);
					}
				} else {
					array1.add(hashmap2);
				}
			} while (true);
		}
		saveReportFrameList(array1, request.getAccount());
	}

	public static boolean setReportOptions(com.dragonflow.HTTP.HTTPRequest httprequest, jgl.HashMap hashmap) {
		String s = httprequest.getValue("reportType");
		hashmap.put("reportType", s);
		boolean flag = false;
		boolean flag1 = false;
		if (httprequest.getValue("showThresholdSummary").length() > 0) {
			hashmap.put("_showReportThresholdSummary", "checked");
		} else {
			hashmap.remove("_showReportThresholdSummary");
			flag = true;
		}
		if (httprequest.getValue("showSummaryTable").length() > 0) {
			hashmap.remove("_hideReportSummary");
			flag = true;
		} else {
			hashmap.put("_hideReportSummary", "checked");
		}
		if (httprequest.getValue("showErrorTimeSummary").length() == 0) {
			hashmap.remove("_showReportErrorTimeSummary");
			flag = true;
		} else {
			hashmap.put("_showReportErrorTimeSummary", "checked");
		}
		if (httprequest.getValue("showGraphs").length() > 0) {
			hashmap.remove("_hideReportGraphs");
			hashmap.remove("_hideReportCharts");
			flag = true;
		} else {
			hashmap.put("_hideReportGraphs", "checked");
			hashmap.put("_hideReportCharts", "checked");
		}
		if (httprequest.getValue("showTables").length() > 0) {
			hashmap.remove("_hideReportTables");
			flag = true;
		} else {
			hashmap.put("_hideReportTables", "checked");
		}
		if (httprequest.getValue("showErrors").length() > 0) {
			hashmap.remove("_hideReportErrors");
			flag = true;
		} else {
			hashmap.put("_hideReportErrors", "checked");
		}
		if (httprequest.getValue("showWarnings").length() > 0) {
			hashmap.remove("_hideReportWarnings");
			flag = true;
		} else {
			hashmap.put("_hideReportWarnings", "checked");
		}
		if (httprequest.getValue("warningNotIncluded").length() > 0) {
			hashmap.put("_warningNotIncluded", "checked");
		}
		if (httprequest.getValue("upTimeIncludeWarning").length() > 0) {
			hashmap.put("_upTimeIncludeWarning", "checked");
		}
		if (httprequest.getValue("failureNotIncluded").length() > 0) {
			hashmap.put("_failureNotIncluded", "checked");
		}
		if (httprequest.getValue("showGoods").length() > 0) {
			hashmap.remove("_hideReportGoods");
			flag = true;
		} else {
			hashmap.put("_hideReportGoods", "checked");
		}
		hashmap.remove("showAlertsOnly");
		if (httprequest.getValue("showAlerts").length() > 0) {
			if (!flag) {
				hashmap.put("showAlertsOnly", "true");
				flag1 = true;
			}
			hashmap.put("_showReportAlerts", httprequest.getValue("alertDetailLevel"));
		} else {
			hashmap.remove("_showReportAlerts");
		}
		return flag1;
	}

	void printForm() {
		String s = !operation.equals("adhoc") || com.dragonflow.Page.treeControl.useTree() ? "" : " target=reports";
		outputStream.print("<FORM action=/SiteView/cgi/go.exe/SiteView METHOD=POST" + s + ">\n" + hiddenQueryID
				+ "<input type=hidden name=page value=" + page + ">\n" + "<input type=hidden name=operation value="
				+ operation + ">\n" + "<input type=hidden name=account value=" + request.getAccount() + ">"
				+ "<table border=0 cellspacing=4><tr><td><img src=\"/SiteView/htdocs/artwork/LabelSpacer.gif\"></td><td></td><td></td></tr>\n");
		outputStream.print("<tr><td colspan=3><hr></td></tr>");
		if (com.dragonflow.SiteView.Platform.isPortal()) {
			com.dragonflow.Page.portalChooserPage.printQueryChooseList(outputStream, request,
					"<B>Report Subject(s)</B>", "Create a report from a request", portalQuery);
		} else if (com.dragonflow.Page.treeControl.useTree()) {
			outputStream.print(monitorOptionsHTML);
		} else {
			outputStream
					.print("<TABLE>\n<TR>\n<TD VALIGN=TOP>Show history for the selected items</TD>\n</TR>\n<TR>\n<TD><IMG SRC=/SiteView/htdocs/artwork/empty.gif WIDTH=25><select multiple name=monitors size=6> "
							+ monitorOptionsHTML + "</select></TD>\n" + "</TR>\n" + "</TABLE>\n"
							+ "<DD>To select several items, hold down the Control key (on most platforms) while clicking item names.\n"
							+ "</DL></BLOCKQUOTE>\n");
		}
		outputStream.print(
				"<TR><TD COLSPAN=3><hr></TD></TR><TR><TD ALIGN=RIGHT VALIGN=TOP>Time Period</TD><td></td></tr>\n<TR><td></td><TD ALIGN=LEFT VALIGN=TOP>\n<TABLE BORDER=0>\n<TR>\n");
		if (operation.equals("adhoc")) {
			outputStream.println("<TD>From " + startTimeHTML + " to " + endTimeHTML);
		} else {
			outputStream.println("<TD>Show data for last <select name=window size=1>\n" + windowsOptions + "</select>\n"
					+ "<input type=hidden name=relative value=\"-1\">\n" + "</TD>\n");
		}
		outputStream.println(
				"</TR>\n<TR><TD>\nPeriod of time to be included in the report.\n</TD></TR></TABLE></TD></TR>\n");
		outputStream.print(reportTypeHTML);
		if (!operation.equals("adhoc")) {
			printReportForm(mailTemplate);
		} else {
			printReportAdhocForm();
		}
		outputStream.print("</TABLE><p><input type=submit value=\"" + operationString + "\"> Management Report</p>\n");
		printWarningHTML();
		outputStream.print(
				"<HR>\n<H3>Advanced Options</H3><table border=0 cellspacing=4><tr><td><img src=\"/SiteView/htdocs/artwork/LabelSpacer.gif\"></td><td></td><td></td></tr>\n");
		outputStream
				.print("<TR><TD ALIGN=RIGHT VALIGN=TOP>Show Detail</TD>\n<TD ALIGN=LEFT VALIGN=TOP>\n\t<input type=checkbox name=detailed "
						+ detailedChecked + ">Show detailed monitor information\n"
						+ "<BR>If this box is checked, then all of the information gathered for each monitor is displayed\n"
						+ "on the report.  Otherwise, only the primary data is displayed for each monitor.<P>\n"
						+ "</TD></TR>\n");
		outputStream
				.print("<TR><TD ALIGN=RIGHT VALIGN=TOP>Show Monitors</TD>\n<TD ALIGN=LEFT VALIGN=TOP>\n\t<select name=statusFilter>"
						+ statusFilterHTML(statusFilter) + "</select>\n"
						+ "<BR>Show only monitors that have been in the chosen status during the time period of"
						+ " the report.<P>\n" + "</TD></TR>\n");
		if (!com.dragonflow.SiteView.Platform.isPortal()) {
			outputStream
					.print("<TR><TD ALIGN=RIGHT VALIGN=TOP>Schedule Filter</TD>\n<TD ALIGN=LEFT VALIGN=TOP>\n\t<select name=schedFilter>"
							+ scheduleFilterHTML(schedFilter) + "</select>\n"
							+ "<BR>Use only the data from samples that occur during this schedule period.\n"
							+ "<BR><A HREF=\"" + CGI.getTenant(request.getURL())
							+ "/SiteView/cgi/go.exe/SiteView?page=schedulePrefs&operation=List&account="
							+ request.getAccount() + "\">Edit<paper-ripple></paper-ripple></a> Schedules"
							+ "</TD></TR>\n");
		}
		if (!operation.equals("adhoc")) {
			outputStream
					.print("<TR><TD ALIGN=RIGHT VALIGN=TOP>Disable Report</TD>\n<TD ALIGN=LEFT VALIGN=TOP>\n\t<input type=checkbox name=disabled "
							+ disabledChecked + ">&nbsp;Disable this report temporarily\n"
							+ "<BR>If this box is checked, then the report will not be automatically generated.<P>\n"
							+ "</TD></TR>\n");
			outputStream
					.print("<tr><td colspan=3><hr></td></tr><TR><TD ALIGN=RIGHT VALIGN=TOP>Comma-Delimited Output</TD><td></td></tr>\n<TR><td></td><TD ALIGN=LEFT VALIGN=TOP>\n\t<input type=checkbox name=tabfile "
							+ tabfileChecked + ">Generate report as comma-delimited file\n"
							+ "<BR>If this box is checked, then whenever the report is generated, a comma-delimited text file\n"
							+ "(suitable for importing into a spreadsheet application such as Excel) will also be generated.\n"
							+ "<p>\n" + "\tE-mail:<input size=60 name=emailData value=" + emailData + ">\n"
							+ "<BR>If the box is checked and an e-mail address is entered, then a copy of the comma-delimited text file\n"
							+ "  will be sent as an e-mail message.  Separate multiple addresses using commas.<p>\n"
							+ "</TD></TR>\n");
			outputStream
					.print("<tr><td colspan=3><hr></td></tr><TR><TD ALIGN=RIGHT VALIGN=TOP>XML Output</TD><td></td></tr>\n<TR><td></td><TD ALIGN=LEFT VALIGN=TOP>\n\t<input type=checkbox name=xmlfile "
							+ xmlfileChecked + ">Generate report as XML file\n"
							+ "<BR>If this box is checked, then whenever the report is generated, a XML text file\n"
							+ "will also be generated.\n" + "<p>\n" + "\tE-mail:<input size=60 name=xmlEmailData value="
							+ xmlEmailData + ">\n"
							+ "<BR>If the box is checked and an e-mail address is entered, then a copy of the XML text file\n"
							+ "  will be sent as an e-mail message.  Separate multiple addresses using commas.<p>\n"
							+ "</TD></TR>\n" + "<tr><td colspan=3><hr></td></tr>");
		}
		String s1 = "<input type=hidden name=startDay value=\"today\">";
		String s2 = "";
		if (operation.equals("adhoc")) {
			s1 = "date: <input type=text name=startDay size=10 value=\"today\">";
			s2 = " Specify the date using a format of mm/dd/yy.  For example, 7/31/97.";
		}
		outputStream
				.print("<TR><TD ALIGN=RIGHT VALIGN=TOP>Uptime Calculation</TD><TD ALIGN=LEFT VALIGN=TOP>\n<TABLE BORDER=0>\n<TR><TD>\n<input type=\"checkbox\" name=\"bestCaseCalc\""
						+ bestCaseCalcChecked + ">Best Case Calculation\n" + "</TD></TR>\n" + "<TR><TD>\n"
						+ "Calculate the monitor uptime %, warning % and error % using a best case scenario.  "
						+ "In this scenario, monitor time in error is calculated from the first known Error run instead of the last known Good run.\n"
						+ "<p></TD></TR>" + "</TABLE>" + "" + "</TD>" + "</TR>\n");
		outputStream
				.print("<TR><TD ALIGN=RIGHT VALIGN=TOP>Time Scale</TD>\n<TD ALIGN=LEFT VALIGN=TOP>\n<TABLE BORDER=0>\n<TR>\n<TD>\nShow samples for every <select name=precision size=1>\n"
						+ precisionOptions + "</select>\n" + "</TD>\n" + "</TR>\n" + "<TR><TD>\n"
						+ "The time between samples.  Automatic will scale the time between samples to an appropriate value for the\n"
						+ "time period chosen.<p></TD></TR></TABLE></TD></TR>\n");
		outputStream
				.print("<TR><TD ALIGN=RIGHT VALIGN=TOP>Vertical Scale</TD>\n<TD ALIGN=LEFT VALIGN=TOP>\n<TABLE BORDER=0>\n<TR>\n<TD>\nMaximum graph value <select name=vmax size=1>\n"
						+ vmaxOptions + "</select>\n" + "</TD>\n" + "</TR>\n" + "<TR><TD>\n"
						+ "The maximum value displayed on the graph.  Automatic will use the maximum sample value.  Choosing this option makes it easier to compare graphs.<p>\n"
						+ "</TD></TR></TABLE></TD></TR>\n");
		if (!operation.equals("adhoc")) {
			outputStream.println(
					"<TR><TD ALIGN=RIGHT VALIGN=TOP>End Time</TD>\n<TD ALIGN=LEFT VALIGN=TOP>\n<TABLE BORDER=0>\n<TR>\n<TD>\nReporting period ends <select name=startHour size=1>\n"
							+ startHourOptions + "</select>\n" + s1 + "</TD>\n" + "</TR>\n" + "<TR><TD>\n"
							+ "The end time of the report period. The report samples will end at this time.  \n" + s2
							+ "<P></TD></TR></TABLE></TD></TR>\n");
			outputStream
					.print("<TR><TD ALIGN=RIGHT VALIGN=TOP>Report Schedule</TD>\n<TD ALIGN=LEFT VALIGN=TOP>\n<TABLE BORDER=0>\n<TR>\n<TD ALIGN=LEFT> Generate this report at: &nbsp;\n<select name=hours size=1>\n"
							+ hoursOptions + "</select>\n" + "<FONT SIZE=+2><B>:</B></FONT>\n"
							+ "<select name=minutes size=1>\n" + minutesOptions + "</select>\n" + "</TD>\n" + "</TR>\n"
							+ "\n"
							+ "<TR><TD>Select the time of day that the report should be generated. The report covers the time period specified under &quot;Time Period&quot; above, ending at the time\n"
							+ "that the report is run.  If you change the End Time above, then you can change this so that the report runs after the End Time.<p></TD></TR> \n"
							+ "</TABLE></TD></TR>\n");
		} else {
			printReportTitle();
		}
		outputStream.print("</table><P><input type=submit value=\"" + operationString + "\"> Management Report\n");
		outputStream.println("</FORM>\n");
	}

	String getReportTypeHTML(jgl.HashMap hashmap) {
		String s = com.dragonflow.Page.reportPage.getValue(hashmap, "reportType");
		boolean flag = com.dragonflow.Page.reportPage.getValue(hashmap, "_showReportThresholdSummary").length() == 0;
		boolean flag1 = com.dragonflow.Page.reportPage.getValue(hashmap, "_hideReportSummary").length() > 0;
		boolean flag2 = com.dragonflow.Page.reportPage.getValue(hashmap, "_showReportErrorTimeSummary").length() > 0;
		boolean flag3 = com.dragonflow.Page.reportPage.getValue(hashmap, "_hideReportCharts").length() > 0;
		boolean flag4 = com.dragonflow.Page.reportPage.getValue(hashmap, "_hideReportGraphs").length() > 0;
		boolean flag5 = com.dragonflow.Page.reportPage.getValue(hashmap, "_hideReportTables").length() > 0;
		boolean flag6 = com.dragonflow.Page.reportPage.getValue(hashmap, "_hideReportErrors").length() > 0;
		boolean flag7 = com.dragonflow.Page.reportPage.getValue(hashmap, "_hideReportWarnings").length() > 0;
		boolean flag8 = com.dragonflow.Page.reportPage.getValue(hashmap, "_hideReportGoods").length() > 0;
		boolean flag9 = com.dragonflow.Page.reportPage.getValue(hashmap, "_showReportAlerts").length() == 0;
		boolean flag10 = com.dragonflow.Page.reportPage.getValue(hashmap, "_warningNotIncluded").length() > 0;
		boolean flag11 = com.dragonflow.Page.reportPage.getValue(hashmap, "_upTimeIncludeWarning").length() > 0;
		boolean flag12 = com.dragonflow.Page.reportPage.getValue(hashmap, "_failureNotIncluded").length() > 0;
		String s1 = "basic";
		if (TextUtils.getValue(hashmap, "_showReportAlerts").length() > 0) {
			flag9 = false;
			s1 = TextUtils.getValue(hashmap, "_showReportAlerts");
		}
		if (flag3) {
			flag4 = true;
		}
		StringBuffer stringbuffer = new StringBuffer();
		java.util.Vector vector = new Vector();
		vector.addElement("barGraph");
		vector.addElement("bar graph - one graph per measurement");
		vector.addElement("lineGraph");
		vector.addElement("line graph - one graph per measurement");
		vector.addElement("lineGraph,similarProperties");
		vector.addElement("line graph - one graph per monitor");
		vector.addElement("lineGraph,multipleMonitors");
		vector.addElement("line graph - one graph per type of measurement");
		vector.addElement("lineGraph,similarProperties,multipleMonitors");
		vector.addElement("line graph - one graph for all measurements");
		if (operation.equals("adhoc")) {
			vector.addElement("textFile");
			vector.addElement("comma-delimited text");
			vector.addElement("xmlFile");
			vector.addElement("XML text");
		}
		if (s.length() == 0) {
			s = (String) vector.elementAt(0);
		}
		stringbuffer.append("<TR><TD colspan=3><hr></td></tr>\n");
		stringbuffer
				.append("<TR><TD ALIGN=RIGHT VALIGN=TOP><B>Report Sections</B></TD><td></td><td></td></tr>\n<tr><td></td><TD ALIGN=LEFT>Select the sections to include in the report</td></tr><tr><td></td><TD ALIGN=LEFT VALIGN=TOP><DL><DT><input type=checkbox name=showThresholdSummary "
						+ (flag ? "" : "CHECKED") + ">" + "Summary of Monitor Thresholds<BR>"
						+ "<input type=checkbox name=showSummaryTable " + (flag1 ? "" : "CHECKED")
						+ ">Summary of Uptime and Readings<BR>" + "<DD><input type=checkbox name=upTimeIncludeWarning "
						+ (flag11 ? "CHECKED" : "") + ">Count warning time the same as good time in UpTime<BR>"
						+ "<DT><input type=checkbox name=showErrorTimeSummary " + (flag2 ? "CHECKED" : "")
						+ ">Time in Error Summary<BR>" + "<DT><input type=checkbox name=showGraphs "
						+ (flag4 ? "" : "CHECKED") + ">" + "<select name=reportType>\n");
		stringbuffer.append(com.dragonflow.Page.reportPage.getOptionsHTML(vector, s));
		String s2 = "";
		if (operation.equals("adhoc")) {
			s2 = "Comma-delimited files are suitable for importing into spreadsheets.\n";
		}
		stringbuffer
				.append("</select>\n<DD>Bar graphs show one monitor per graph, line graphs can show multiple monitors or statistics per graph.\n"
						+ s2);
		stringbuffer.append("<DT><input type=checkbox name=showTables " + (flag5 ? "" : "CHECKED")
				+ ">Table of Monitor Readings<BR>" + "<DT><input type=checkbox name=showErrors "
				+ (flag6 ? "" : "CHECKED") + ">Listing of Errors<BR>" + "<DT><input type=checkbox name=showWarnings "
				+ (flag7 ? "" : "CHECKED") + ">Listing of Warnings<BR>" + "<DT><input type=checkbox name=showGoods "
				+ (flag8 ? "" : "CHECKED") + ">Listing of Goods<BR>"
				+ "<DT><input type=checkbox name=warningNotIncluded " + (flag10 ? "CHECKED" : "")
				+ ">Don't display warning % column in Summary of Uptime and Readings<BR>"
				+ "<DT><input type=checkbox name=failureNotIncluded " + (flag12 ? "CHECKED" : "")
				+ ">Don't display failure column in Summary of Uptime and Readings<BR>");
		if (!com.dragonflow.SiteView.Platform.isPortal()) {
			stringbuffer.append("<DT><input type=checkbox name=showAlerts " + (flag9 ? "" : "CHECKED")
					+ ">Listing of Alerts Sent - Detail Level: ");
			java.util.Vector vector1 = new Vector();
			vector1.addElement("basic");
			vector1.addElement("Basic");
			vector1.addElement("detailonfail");
			vector1.addElement("Show Detail for Failed Alerts");
			vector1.addElement("detail");
			vector1.addElement("Show Detail for All Alerts");
			stringbuffer.append("<select name=alertDetailLevel size=1>"
					+ com.dragonflow.Page.reportPage.getOptionsHTML(vector1, s1) + "</select><BR>");
		}
		stringbuffer.append("<DT>Formatting <select name=format size=1>\n" + formatOptions + "</select><br>\n");
		stringbuffer.append("</DL></TD></TR>\n");
		stringbuffer.append("<TR><TD colspan=3><hr></td></tr>\n");
		return stringbuffer.toString();
	}

	void printHeader() {
		printBodyHeader(title);
		printMenuItems(helpFile, "Reports");
		outputStream.println("<p><H2>" + title + "</H2>\n");
		if (errors.length() > 0) {
			String as[] = com.dragonflow.Utils.TextUtils.split(errors, "\t");
			outputStream.print("<UL>\n");
			for (int i = 0; i < as.length; i++) {
				if (as[i].length() > 0) {
					outputStream.print("<LI><B>" + as[i] + "</B>\n");
				}
			}

			outputStream.print("</UL><HR>\n");
		}
	}

	void printRefreshHeader() {
		String s = CGI.getTenant(request.getURL()) + "/SiteView/cgi/go.exe/SiteView?page=report&account="
				+ request.getAccount();
		printRefreshHeader("", s, 0);
	}

	void printWarningHTML() {
		if (operation.equals("adhoc")) {
			outputStream.print(
					"&#32;<BR>(<B>Note: </B>This may take a few moments, depending on the speed of the web server machine, the number\nof monitors and the time period of the report)\n");
		}
	}

	void printTooManyReports(String s, int i) {
		printHeader();
		String s1 = "You have reached your limit of " + i + " reports for this account.";
		outputStream.print("<P><HR>" + s1 + "<HR><P><A HREF=" + CGI.getTenant(request.getURL())
				+ "/SiteView/cgi/go.exe/SiteView?page=report&operation=List&account=" + request.getAccount()
				+ ">Return to Reports<paper-ripple></paper-ripple></a>\n");
		printFooter(outputStream);
	}

	void printReportAdhocForm() {
		outputStream
				.print("<TR><TD ALIGN=RIGHT VALIGN=TOP><B>Send Report by E-mail</B></TD>\n<TD ALIGN=LEFT VALIGN=TOP>\nE-mail:<input size=60 name=email value="
						+ email + ">\n"
						+ "<BR>If an e-mail address is entered, when the quick management report is generated, an html format of the \n"
						+ " report will be sent as an e-mail message.  Separate multiple addresses using commas.<p>\n"
						+ "</TD></TR>\n");
	}

	void printReportForm(String s) {
		java.util.Vector vector = SiteViewGroup.getTemplateList("templates.history", request);
		String s1 = "";
		if (s.length() == 0) {
			s = "HistoryMail";
		}
		for (int i = 0; i < vector.size(); i++) {
			String s2 = (String) vector.elementAt(i);
			boolean flag = s2.equals(s);
			s1 = s1 + com.dragonflow.Page.reportPage.getListOptionHTML(s2, s2, flag);
		}

		outputStream
				.print("<TR><TD ALIGN=RIGHT VALIGN=TOP><B>Send Report by E-mail</B></TD><td></td></tr>\n<TR><td></td><TD ALIGN=LEFT VALIGN=TOP><DL>\n<DT>E-mail:<input size=60 name=email value="
						+ email + ">\n"
						+ "<DD>If an e-mail address is entered, then whenever the report is generated, a summary of the report\n"
						+ "  will be sent as an e-mail message.  Separate multiple addresses using commas.\n" + "<P>"
						+ "<DT><input type=checkbox name=attachReport " + attachReportChecked
						+ ">Send using HTML format\n"
						+ "<DD>If this box is checked, then the report is sent as an HTML document. \n"
						+ "Otherwise, a text summary of the report is sent.\n" + "<P>"
						+ "<DT>Template:<select size=1 name=mailTemplate>" + s1 + "</select>\n"
						+ "<DD>The template is used to format, add information, and include links to report pages in SiteView. "
						+ "Use 'HistoryMail' to include a link to the SiteView Reports page as an Administrator and "
						+ "'HistoryUserMail' to include a link to the Site SiteView Reports page as a User. You will "
						+ "need to " + "<a href=\"" + CGI.getTenant(request.getURL())
						+ "/SiteView/cgi/go.exe/SiteView?page=userPrefs&account=" + request.getAccount()
						+ "&user=user&operation=Edit\">enable<paper-ripple></paper-ripple></a>"
						+ " the User login to use 'HistoryUserMail'.\n" + "</DL></TD></TR>\n");
		printReportTitle();
	}

	void printReportTitle() {
		outputStream
				.print("<TR><TD ALIGN=RIGHT VALIGN=TOP>Report Text</TD><td></td></tr>\n<TR><td></td><TD ALIGN=LEFT VALIGN=TOP><DL>\n<DT>\n\tTitle:&nbsp;&nbsp;&nbsp;&nbsp;<input size=60 name=title value=\""
						+ reportTitle + "\">\n"
						+ "<DD>(optional) Title for the report - shown at the top of the report and in the list of reports. If this\n"
						+ "is blank, then a name describing the monitors and groups in the report will be used.\n"
						+ "<DT>\n" + "\tDescription:<input size=60 name=description value=\""
						+ com.dragonflow.Utils.TextUtils.escapeHTML(description) + "\">\n"
						+ "<DD>(optional) Description for the report - shown at the top of the report\n"
						+ "</DL></TD></TR>\n");
	}

	void computeMonitorOptions(jgl.HashMap hashmap) throws java.lang.Exception {
		jgl.Array array = new Array();
		for (Enumeration enumeration = hashmap.values("groups"); enumeration.hasMoreElements(); array
				.add(enumeration.nextElement())) {
		}
		for (Enumeration enumeration1 = hashmap.values("monitors"); enumeration1.hasMoreElements(); array
				.add(enumeration1.nextElement())) {
		}
		if (com.dragonflow.Page.treeControl.useTree()) {
			StringBuffer stringbuffer = new StringBuffer();
			String s = "Show history for the selected items. Use the <img src=/SiteView/htdocs/artwork/Plus.gif border=0> to expand a group or the <img src=/SiteView/htdocs/artwork/Minus.gif border=0> to close a group.\n";
			byte byte0 = 35;
			com.dragonflow.Page.treeControl treecontrol = new treeControl(request, "monitors", false);
			treecontrol.process("Report Subject(s)", "", s, array, null, null, byte0, this, stringbuffer);
			monitorOptionsHTML = stringbuffer.toString();
		} else {
			monitorOptionsHTML = getMonitorOptionsHTML(array, null, null, 35);
		}
	}

	String getTimePeriodHTML(String s) {
		StringBuffer stringbuffer = new StringBuffer();
		int ai[] = nAdhocTimePeriods;
		if (!operation.equals("adhoc")) {
			ai = nScheduledTimePeriods;
		}
		String s1 = "";
		String s2 = "";
		boolean flag = false;
		for (int i = 0; i < ai.length; i++) {
			s1 = String.valueOf(ai[i]);
			s2 = secondsToString(ai[i]);
			flag = s.equals(s1);
			stringbuffer.append(com.dragonflow.Page.reportPage.getListOptionHTML(s1, s2, flag));
		}

		s1 = "monthToDate";
		s2 = "month-to-date";
		flag = s.equals(s1);
		stringbuffer.append(com.dragonflow.Page.reportPage.getListOptionHTML(s1, s2, flag));
		return stringbuffer.toString();
	}

	String getFormatHTML(String s) {
		boolean flag = s.length() == 0;
		String s1 = "\"\"";
		String s3 = "color background (default)";
		boolean flag1 = flag;
		String s5 = com.dragonflow.Page.reportPage.getListOptionHTML(s1, s3, flag1);
		com.dragonflow.SiteView.SiteViewGroup siteviewgroup = SiteViewGroup.currentSiteView();
		Enumeration enumeration = siteviewgroup.getMultipleSettings("_reportFormat");
		do {
			if (!enumeration.hasMoreElements()) {
				break;
			}
			jgl.HashMap hashmap = com.dragonflow.Utils.TextUtils.stringToHashMap((String) enumeration.nextElement());
			String s2 = TextUtils.getValue(hashmap, "_id");
			String s4 = TextUtils.getValue(hashmap, "_title").replace('_', ' ');
			boolean flag2 = !flag && s2.equals(s);
			s5 = s5 + com.dragonflow.Page.reportPage.getListOptionHTML(s2, s4, flag2);
			if (flag2) {
				flag = true;
			}
		} while (true);
		return s5;
	}

	String statusFilterHTML(String s) {
		java.util.Vector vector = new Vector();
		vector.addElement("");
		vector.addElement("show all monitors");
		vector.addElement("error or warning");
		vector.addElement("show only monitors that had errors or warnings");
		vector.addElement("error");
		vector.addElement("show only monitors that had errors");
		vector.addElement("warning");
		vector.addElement("show only monitors that had warnings");
		vector.addElement("good");
		vector.addElement("show only monitors that were OK");
		if (s.length() == 0) {
			s = (String) vector.elementAt(0);
		}
		return com.dragonflow.Page.reportPage.getOptionsHTML(vector, s);
	}

	String scheduleFilterHTML(String s) {
		java.util.Vector vector = new Vector();
		vector.addElement("");
		vector.addElement("every day, all day");
		jgl.HashMap hashmap;
		for (Enumeration enumeration = com.dragonflow.Page.CGI.getValues(getSettings(),
				"_additionalSchedule"); enumeration.hasMoreElements(); vector
						.addElement(TextUtils.getValue(hashmap, "_name"))) {
			String s1 = (String) enumeration.nextElement();
			hashmap = com.dragonflow.Utils.TextUtils.stringToHashMap(s1);
			vector.addElement("_id=" + TextUtils.getValue(hashmap, "_id"));
		}

		if (s.length() == 0) {
			s = (String) vector.elementAt(0);
		}
		return com.dragonflow.Page.reportPage.getOptionsHTML(vector, s);
	}

	String getTimeScaleHTML(String s) {
		StringBuffer stringbuffer = new StringBuffer();
		for (int i = 0; i < timeScaleSettings.length; i++) {
			boolean flag = false;
			String s1 = timeScaleSettings[i];
			if (s.equals(s1)) {
				flag = true;
			}
			String s2 = secondsToString(timeScaleSettings[i]);
			stringbuffer.append(com.dragonflow.Page.reportPage.getListOptionHTML(s1, s2, flag));
		}

		return stringbuffer.toString();
	}

	String getVertScaleHTML(String s) {
		StringBuffer stringbuffer = new StringBuffer();
		for (int i = 0; i < vertScaleSettings.length; i++) {
			boolean flag = false;
			String s1 = vertScaleSettings[i];
			if (s.equals(s1)) {
				flag = true;
			}
			s1 = '"' + s1 + '"';
			String s2 = vertScaleSettings[i];
			if (s2.equals("")) {
				s2 = "automatic";
			}
			stringbuffer.append(com.dragonflow.Page.reportPage.getListOptionHTML(s1, s2, flag));
		}

		return stringbuffer.toString();
	}

	String getStartHourHTML(String s, int i) {
		StringBuffer stringbuffer = new StringBuffer();
		String s1 = "now";
		String s3 = operation.equals("adhoc") ? s1 : "at the time the report is run";
		boolean flag = s.equals(s1);
		stringbuffer.append(com.dragonflow.Page.reportPage.getListOptionHTML(s1, s3, flag));
		if (!s.equals("now")) {
			s = String.valueOf(com.dragonflow.Utils.TextUtils.toInt(s) + i);
		} else {
			s = "-1";
		}
		for (int j = 0; j < 24; j++) {
			int k = j * 3600;
			String s2 = String.valueOf(k);
			String s4 = "at " + com.dragonflow.Utils.TextUtils.dateToMilitaryTime(new Date(0, 0, 0, j, 0));
			boolean flag1 = com.dragonflow.Utils.TextUtils.toInt(s) == k;
			stringbuffer.append(com.dragonflow.Page.reportPage.getListOptionHTML(s2, s4, flag1));
		}

		return stringbuffer.toString();
	}

	String getHoursHTML(int i) {
		StringBuffer stringbuffer = new StringBuffer();
		for (int j = 0; j < 24; j++) {
			int k = j * 3600;
			String s = String.valueOf(k);
			String s1 = com.dragonflow.Utils.TextUtils.numberToString(j);
			boolean flag = i == j;
			stringbuffer.append(com.dragonflow.Page.reportPage.getListOptionHTML(s, s1, flag));
		}

		return stringbuffer.toString();
	}

	String getMinutesHTML(int i) {
		StringBuffer stringbuffer = new StringBuffer();
		for (int j = 0; j < 60; j++) {
			int k = j * 60;
			String s = String.valueOf(k);
			String s1 = com.dragonflow.Utils.TextUtils.numberToString(j);
			boolean flag = i == j;
			stringbuffer.append(com.dragonflow.Page.reportPage.getListOptionHTML(s, s1, flag));
		}

		return stringbuffer.toString();
	}

	String secondsToString(int i) {
		return secondsToString(String.valueOf(i));
	}

	String secondsToString(String s) {
		if (s.equals("default")) {
			return "automatic";
		}
		int i = 0;
		try {
			i = com.dragonflow.Utils.TextUtils.toInt(s);
		} catch (java.lang.NumberFormatException numberformatexception) {
			com.dragonflow.Log.LogManager.log("Error",
					"A number '" + s + "' was passed from the browser reportPage that did not parse as an integer: "
							+ numberformatexception.toString());
			com.dragonflow.Log.LogManager.log("Error",
					"reportPage is unhappy: " + com.dragonflow.Utils.FileUtils.stackTraceText(numberformatexception));
		}
		String s1 = "minute";
		int j = 0;
		if (i >= 0x278d00) {
			s1 = "month";
			j = i / 0x278d00;
		} else if (i >= 0x93a80) {
			s1 = "week";
			j = i / 0x93a80;
		} else if (i >= 0x15180) {
			s1 = "day";
			j = i / 0x15180;
		} else if (i >= 3600) {
			s1 = "hour";
			j = i / 3600;
		} else {
			j = i / 60;
		}
		if (j != 1) {
			s1 = s1 + "s";
		}
		if (j == 1) {
			return s1;
		} else {
			return j + " " + s1;
		}
	}

	public void printList() {
		printBodyHeader("Management Reports");
		outputStream.println(
				"<link rel='import' href='/SiteView/htdocs/js/components/data-table-ext/simple-data-table-ext.html' async='true'>\n");
		outputStream.println(
				"<link rel='import' href='/SiteView/htdocs/js/bower_components/paper-ripple/paper-ripple.html' async='true'>\n");

		helpFile = com.dragonflow.SiteView.Platform.isPortal() ? "CentraReports.htm" : "HReports.htm";
		printMenuItems(helpFile, "Reports");
		outputStream.println("<p>\n<H2>Management Reports</H2>\n<p>\n");
		com.dragonflow.Page.reportPage.printReportTable(outputStream, request); // create
																				// list
																				// table.

		outputStream
				.print("<P>To view management reports and summaries, click the link in the Reports column above.<P>");
		outputStream.print("<hr><font size=+1><b>Report Actions:</b></font>\n");
		// outputStream.print("\n<TABLE BORDER=0 CELLSPACING=4
		// WIDTH=100%><tr><td width=15%>");
		String mainUrl = CGI.getTenant(request.getURL()) + "/SiteView/cgi/go.exe/SiteView?page=report&account="
				+ request.getAccount();
		ArrayList<java.util.HashMap> actionsList = new ArrayList<java.util.HashMap>();

		if (request.actionAllowed("_reportEdit")) {
			java.util.HashMap<String, String> _reportEditMap = new java.util.HashMap<String, String>();
			_reportEditMap.put("atitle", "<a href=" + mainUrl + "&operation=add>Add<paper-ripple></paper-ripple></a>");
			_reportEditMap.put("desc", "Add a new scheduled management report for a specified time interval");
			actionsList.add(_reportEditMap);
			// outputStream.print("<tr><td> </td><td></td></tr>");
		}
		if (request.actionAllowed("_reportAdhoc")) {
			java.util.HashMap<String, String> _reportAdhocMap = new java.util.HashMap<String, String>();
			_reportAdhocMap.put("atitle",
					"<A HREF=" + mainUrl + "&operation=adhoc>Quick<paper-ripple></paper-ripple></a>");
			_reportAdhocMap.put("desc", "Generate a Quick report for a custom time period and selected monitors");
			actionsList.add(_reportAdhocMap);
			// outputStream.print("<tr><td> </td><td></td></tr>");
		}
		if (request.actionAllowed("_progress")) {
			java.util.HashMap<String, String> _progressMap = new java.util.HashMap<String, String>();
			_progressMap.put("atitle", "<A HREF=/SiteView/" + request.getAccountDirectory()
					+ "/Progress.html>Progress<paper-ripple></paper-ripple></a>");
			_progressMap.put("desc", "View the SiteView Progress page for monitor load information");
			actionsList.add(_progressMap);
			// outputStream.print("<tr><td> </td><td></td></tr>");
		}
		if (!com.dragonflow.SiteView.Platform.isPortal() && request.actionAllowed("_browse")) {
			java.util.HashMap<String, String> _browseMap = new java.util.HashMap<String, String>();
			_browseMap.put("atitle",
					"<A HREF=" + CGI.getTenant(request.getURL())
							+ "/SiteView/cgi/go.exe/SiteView?page=monitorSummary&account=" + request.getAccount()
							+ ">Monitor Description<paper-ripple></paper-ripple></a>");
			_browseMap.put("desc", "Generate a report of monitor configuration settings by group or installation");
			actionsList.add(_browseMap);
			// outputStream.print("<tr><td> </td><td></td></tr>");
		}
		// if(com.dragonflow.TopazIntegration.TopazManager.getInstance().getTopazServerSettings().isConnected()
		// && request.actionAllowed("_topazConfigChangesReport")) {
		// outputStream.print("<tr><td><A HREF=" +
		// com.dragonflow.TopazIntegration.TopazManager.getInstance().getTopazServerSettings().getAdminServerUrl()
		// + "siteview/conf/sample_dispatcher?action=log" + ">" +
		// com.dragonflow.SiteView.TopazInfo.getTopazName() + " Configuration
		// Changes Report<paper-ripple></paper-ripple></a> </td><td>View the
		// configuration changes reported to " +
		// com.dragonflow.SiteView.TopazInfo.getTopazName() + "</td></tr>");
		// }

		String actionsListStr = JSONObject.toJSONString(actionsList);
		actionsListStr = actionsListStr.replaceAll(" ", "@space");
		actionsListStr = actionsListStr.replaceAll(">", "@big");
		actionsListStr = actionsListStr.replaceAll("<", "@small");
		outputStream.println("<simple-data-table-ext data-list=" + actionsListStr + "></simple-data-table-ext>\n");
		// outputStream.print("</table>");
		outputStream.print("<hr><center><p>\n");
		printFooter(outputStream);
		outputStream.print("</HTML>\n");
	}

	static boolean portalIsReportAllowed(jgl.HashMap hashmap, String s) {
		return TextUtils.getValue(hashmap, "account").equals(s);
	}

	static boolean isReportAllowed(jgl.HashMap hashmap, jgl.Array array) {
		label0: {
			if (array.size() == 0) {
				break label0;
			}
			for (Enumeration enumeration = hashmap.values("groups"); enumeration.hasMoreElements();) {
				String s = (String) enumeration.nextElement();
				if (!com.dragonflow.Page.CGI.allowedByGroupFilter(s, array)) {
					return false;
				}
			}

			Enumeration enumeration1 = hashmap.values("monitors");
			String as[];
			label1: do {
				do {
					if (!enumeration1.hasMoreElements()) {
						break label0;
					}
					String s1 = (String) enumeration1.nextElement();
					as = com.dragonflow.Utils.TextUtils.split(s1);
					if (as.length != 1) {
						continue label1;
					}
				} while (com.dragonflow.Page.CGI.allowedByGroupFilter(as[0], array));
				return false;
			} while (as.length <= 1 || com.dragonflow.Page.CGI.allowedByGroupFilter(as[1], array));
			return false;
		}
		return true;
	}

	public static void printReportTable(java.io.PrintWriter printwriter, com.dragonflow.HTTP.HTTPRequest httprequest) {
		jgl.Array array = com.dragonflow.Page.reportPage.getReportFrames(httprequest.getAccount());
		String account = httprequest.getAccount();
		printwriter.println(
				"<link rel='import' href='/SiteView/htdocs/js/components/data-table-ext/data-table-ext.html' async='true'>\n");
		boolean hasEditPermission = httprequest.actionAllowed("_reportEdit");
		ArrayList<java.util.HashMap> mapList = new ArrayList<java.util.HashMap>();

		Enumeration enumeration = array.elements();
		if (!enumeration.hasMoreElements()) {
			byte byte0 = 4;
			if (hasEditPermission) {
				byte0 = 2;
			}
		} else {
			do {
				if (!enumeration.hasMoreElements()) {
					break;
				}
				jgl.HashMap hashmap = (jgl.HashMap) enumeration.nextElement();
				if (hashmap.get("isQuick") == null || ((String) hashmap.get("isQuick")).length() <= 0) {
					String s1 = TextUtils.getValue(hashmap, "title");
					if (s1.length() == 0) {
						String s2 = com.dragonflow.Page.reportPage.getDefaultReportTitle(hashmap);
						hashmap.put("title", s2);
					}
				}
			} while (true);

			jgl.Sorting.sort(array, new CompareSlot("title", com.dragonflow.SiteView.CompareSlot.DIRECTION_LESS));
			enumeration = array.elements();
			jgl.Array array1 = com.dragonflow.Page.CGI.getGroupFilterForAccount(httprequest);
			do {
				if (!enumeration.hasMoreElements()) {
					break;
				}
				jgl.HashMap hashmap1 = (jgl.HashMap) enumeration.nextElement();
				java.util.HashMap<String, String> dataMap = new java.util.HashMap<String, String>();

				if ((hashmap1.get("isQuick") == null || ((String) hashmap1.get("isQuick")).length() <= 0)
						&& (com.dragonflow.SiteView.Platform.isPortal()
								? com.dragonflow.Page.reportPage.portalIsReportAllowed(hashmap1, account)
								: com.dragonflow.Page.reportPage.isReportAllowed(hashmap1, array1))) {
					String s3 = TextUtils.getValue(hashmap1, "title");
					String s4 = TextUtils.getValue(hashmap1, "window");
					int i = com.dragonflow.Properties.StringProperty.toInteger(s4);
					String timePeriod;
					switch (i) {
					case 3600:
						timePeriod = "last hour";
						break;
					case 86400:
						timePeriod = "last day";
						break;
					case 604800:
						timePeriod = "last week";
						break;
					case 2592000:
						timePeriod = "last month";
						break;
					default:
						String s6 = "minutes";
						int j = 0;
						if (i >= 0x2a300) {
							s6 = "days";
							j = i / 0x15180;
						} else if (i >= 7200) {
							s6 = "hours";
							j = i / 3600;
						} else {
							j = i / 60;
						}
						if (s4.equals("monthToDate")) {
							timePeriod = "month-to-date";
						} else {
							timePeriod = "last " + j + " " + s6;
						}
						break;
					}
					String s7 = TextUtils.getValue(hashmap1, "id");
					java.io.File file = com.dragonflow.Page.reportPage.createReportIndexFile(account, s7,
							hasEditPermission);
					String s8 = "";
					String s9 = "";
					if (file.exists()) {
						s8 = "<A HREF="
								+ com.dragonflow.SiteView.Platform.getURLPath(
										com.dragonflow.SiteView.HistoryReport.accountToDirectory(account), account)
								+ "/Reports-" + s7 + "/index.html>";
						s9 = "<paper-ripple></paper-ripple></a>";
					}
					if (TextUtils.getValue(hashmap1, "disabled").length() > 0) {
						s3 = "<B>(disabled)</B> " + s3;
					}
					dataMap.put("a_Reports", s8 + s3 + s9);
					dataMap.put("b_Time&nbsp;Period", timePeriod);
					if (hasEditPermission) {
						dataMap.put("c_Edit",
								"<A HREF=" + CGI.getTenant(httprequest.getURL())
										+ "/SiteView/cgi/go.exe/SiteView?page=report&operation=edit&queryID=" + s7
										+ "&account=" + account + ">Edit<paper-ripple></paper-ripple></a>");
						dataMap.put("d_Del",
								"<A HREF=" + CGI.getTenant(httprequest.getURL())
										+ "/SiteView/cgi/go.exe/SiteView?page=report&operation=Delete&queryID=" + s7
										+ "&account=" + account + ">X<paper-ripple></paper-ripple></a>");
					}
				}
				mapList.add(dataMap);
			} while (true);
		}
		String jsonString = JSONObject.toJSONString(mapList);
		jsonString = jsonString.replaceAll(" ", "@space");
		jsonString = jsonString.replaceAll(">", "@big");
		jsonString = jsonString.replaceAll("<", "@small");
		printwriter.println("<data-table-custom data-list=" + jsonString
				+ " is-show-header no-data-tip='No Management Reports Scheduled'></data-table-custom>\n");
	}

	private static java.io.File createReportIndexFile(String s, String s1, boolean flag) {
		java.io.File file = new File(com.dragonflow.SiteView.Platform
				.getDirectoryPath(com.dragonflow.SiteView.HistoryReport.accountToDirectory(s), s)
				+ java.io.File.separator + "Reports-" + s1 + java.io.File.separator + "index.html");
		if (!file.exists()) {
			if (com.dragonflow.SiteView.Platform.isStandardAccount(s)) {
				com.dragonflow.SiteView.HistoryReport.generateIndexPage("administrator", s1, "true");
				if (com.dragonflow.SiteView.Platform.isUserAccessAllowed()) {
					com.dragonflow.SiteView.HistoryReport.generateIndexPage("user", s1, "");
				}
			} else {
				com.dragonflow.SiteView.HistoryReport.generateIndexPage(s, s1, flag ? "true" : "");
			}
		}
		return file;
	}

	public static void createReportsIndexFiles(com.dragonflow.HTTP.HTTPRequest httprequest) {
		Enumeration enumeration = com.dragonflow.Page.reportPage.getReportFrames(null).elements();
		jgl.Array array = com.dragonflow.Page.CGI.getGroupFilterForAccount(httprequest);
		do {
			if (!enumeration.hasMoreElements())
				break;
			jgl.HashMap hashmap = (jgl.HashMap) enumeration.nextElement();
			if ((hashmap.get("isQuick") == null || ((String) hashmap.get("isQuick")).length() <= 0)
					&& (com.dragonflow.SiteView.Platform.isPortal()
							? com.dragonflow.Page.reportPage.portalIsReportAllowed(hashmap, httprequest.getAccount())
							: com.dragonflow.Page.reportPage.isReportAllowed(hashmap, array))) {
				String s = TextUtils.getValue(hashmap, "id");
				com.dragonflow.Page.reportPage.createReportIndexFile(httprequest.getAccount(), s,
						httprequest.actionAllowed("_reportEdit"));
			}
		} while (true);
	}

	public static String getDefaultReportTitle(jgl.HashMap hashmap) {
		StringBuffer stringbuffer = new StringBuffer();
		StringBuffer stringbuffer1 = new StringBuffer();
		int i = 0;
		int j = 0;
		com.dragonflow.SiteView.SiteViewGroup siteviewgroup = SiteViewGroup.currentSiteView();
		Enumeration enumeration = hashmap.values("groups");
		do {
			if (!enumeration.hasMoreElements())
				break;
			String s = (String) enumeration.nextElement();
			com.dragonflow.SiteView.MonitorGroup monitorgroup = (com.dragonflow.SiteView.MonitorGroup) siteviewgroup
					.getElement(s);
			if (monitorgroup != null) {
				if (stringbuffer.length() > 0) {
					stringbuffer.append(", ");
				}
				stringbuffer.append(monitorgroup.getProperty(com.dragonflow.SiteView.Monitor.pName));
				i++;
			}
		} while (true);
		enumeration = hashmap.values("monitors");
		do {
			if (!enumeration.hasMoreElements()) {
				break;
			}
			String s1 = com.dragonflow.Utils.I18N.toDefaultEncoding((String) enumeration.nextElement());
			String as[] = com.dragonflow.Utils.TextUtils.split(s1);
			if (as.length == 1) {
				com.dragonflow.SiteView.MonitorGroup monitorgroup1 = (com.dragonflow.SiteView.MonitorGroup) siteviewgroup
						.getElement(as[0]);
				if (monitorgroup1 != null) {
					if (stringbuffer.length() > 0) {
						stringbuffer.append(", ");
					}
					stringbuffer.append(monitorgroup1.getProperty(com.dragonflow.SiteView.Monitor.pName));
					i++;
				}
			} else if (as.length > 1) {
				com.dragonflow.SiteView.Monitor monitor = (com.dragonflow.SiteView.Monitor) siteviewgroup
						.getElement(as[1] + "/" + as[0]);
				if (monitor != null) {
					if (stringbuffer1.length() > 0) {
						stringbuffer1.append(", ");
					}
					stringbuffer1.append(monitor.getProperty(com.dragonflow.SiteView.Monitor.pName));
					j++;
				}
			}
		} while (true);
		StringBuffer stringbuffer2 = new StringBuffer();
		if (i > 0) {
			stringbuffer2.append(stringbuffer.toString());
			if (i == 1) {
				stringbuffer2.append(" Group");
			} else {
				stringbuffer2.append(" Groups");
			}
		}
		if (j > 0) {
			if (stringbuffer2.length() > 0) {
				stringbuffer2.append(" and ");
			}
			stringbuffer2.append(stringbuffer1.toString());
			if (j == 1) {
				stringbuffer2.append(" Monitor");
			} else {
				stringbuffer2.append(" Monitors");
			}
		}
		if (j == 0 && i == 0) {
			if (TextUtils.getValue(hashmap, "showAlertsOnly").length() == 0) {
				if (TextUtils.getValue(hashmap, "query").length() > 0) {
					com.dragonflow.SiteView.PortalFilter portalfilter = new PortalFilter(
							TextUtils.getValue(hashmap, "query"));
					stringbuffer2.append(portalfilter.getDescription());
				} else {
					stringbuffer2.append("No monitors in report");
				}
			} else {
				stringbuffer2.append("All Alerts");
			}
		}
		return stringbuffer2.toString();
	}

	public static jgl.Array getReportFrames(String s) {
		jgl.Array array = null;
		try {
			if (s != null && !com.dragonflow.SiteView.Platform.isStandardAccount(s)) {
				jgl.Array array1 = com.dragonflow.Page.reportPage.ReadGroupFrames(s, null);
				array = new Array();
				Enumeration enumeration = array1.elements();
				jgl.HashMap hashmap = (jgl.HashMap) enumeration.nextElement();
				do {
					if (!enumeration.hasMoreElements()) {
						break;
					}
					jgl.HashMap hashmap1 = (jgl.HashMap) enumeration.nextElement();
					if (com.dragonflow.SiteView.Monitor.isReportFrame(hashmap1)) {
						array.add(hashmap1);
					}
				} while (true);
			} else {
				String s1 = Platform.getRoot() + java.io.File.separator + "groups" + java.io.File.separator
						+ "history.config";
				java.io.File file = new File(s1);
				if (!file.exists()) {
					array = new Array();
				} else {
					array = com.dragonflow.Properties.FrameFile.readFromFile(s1);
				}
			}
		} catch (java.io.IOException ioexception) {
			array = new Array();
		}
		return array;
	}

	public jgl.Array getReportFrameList() {
		jgl.Array array = null;
		try {
			if (!request.isStandardAccount()) {
				array = ReadGroupFrames(request.getAccount());
			} else {
				String s = Platform.getRoot() + java.io.File.separator + "groups" + java.io.File.separator
						+ "history.config";
				java.io.File file = new File(s);
				if (!file.exists()) {
					array = new Array();
				} else {
					array = com.dragonflow.Properties.FrameFile.readFromFile(s);
				}
			}
		} catch (java.io.IOException ioexception) {
			array = new Array();
		}
		return array;
	}

	public void saveReportFrameList(jgl.Array array, String s) {
		try {
			if (!com.dragonflow.SiteView.Platform.isStandardAccount(s)) {
				WriteGroupFrames(s, array);
				com.dragonflow.SiteView.SiteViewGroup.updateStaticPages(s);
			} else {
				com.dragonflow.Properties.FrameFile.writeToFile(com.dragonflow.SiteView.Platform.getRoot()
						+ java.io.File.separator + "groups" + java.io.File.separator + "history.config", array);
				com.dragonflow.SiteView.SiteViewGroup.updateStaticPages();
			}
		} catch (java.io.IOException ioexception) {
			com.dragonflow.Log.LogManager.log("Error",
					"reportPage.saveReportFrameList() is unhappy with report config file, history.config: "
							+ ioexception.toString());
			com.dragonflow.Log.LogManager.log("Error", "reportPage.saveReportFrameList() is unhappy: "
					+ com.dragonflow.Utils.FileUtils.stackTraceText(ioexception));
		}
	}

	public static void main(String args[]) throws java.io.IOException {
		com.dragonflow.Page.reportPage reportpage = new reportPage();
		if (args.length > 0) {
			reportpage.args = args;
		}
		reportpage.handleRequest();
	}

	private void printMenuItems(String s, String s1) {
		com.dragonflow.Page.CGI.menus menus1 = getNavItems(request);
		printButtonBar(s, s1, menus1);
	}

}

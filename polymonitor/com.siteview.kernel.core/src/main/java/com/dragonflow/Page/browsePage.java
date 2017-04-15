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

import java.util.ArrayList;
import java.util.Enumeration;

import jgl.Array;

import com.alibaba.fastjson.JSONObject;
import com.dragonflow.HTTP.HTTPRequestException;
import com.dragonflow.SiteView.MasterConfig;
import com.dragonflow.SiteView.Monitor;
import com.dragonflow.SiteView.MonitorGroup;
import com.dragonflow.SiteView.SiteViewGroup;
import com.dragonflow.Utils.TextUtils;

// Referenced classes of package com.dragonflow.Page:
// CGI, monitorPage

public class browsePage extends com.dragonflow.Page.CGI implements jgl.BinaryPredicate {

	public static final int SORT_NAME = 1;
	public static final int SORT_STATUS = 2;
	public static final int SORT_MONITOR_TYPE = 3;
	public static final int SORT_CATEGORY = 4;
	public static final int SORT_GROUP = 5;
	public static final int SORT_ID = 6;
	public static final int SORT_MACHINE = 7;
	int sortKey;
	int secondaryKey;

	public browsePage() {
		sortKey = 4;
		secondaryKey = 1;
	}

	public com.dragonflow.Page.CGI.menus getNavItems(com.dragonflow.HTTP.HTTPRequest httprequest) {
		com.dragonflow.Page.CGI.menus menus1 = new CGI.menus();
		if (httprequest.actionAllowed("_browse")) {
			menus1.add(new CGI.menuItems("Browse", "browse", "", "page", "Browse Monitors"));
		}
		if (httprequest.actionAllowed("_preference")) {
			menus1.add(new CGI.menuItems("Remote UNIX/LINUX", "machine", "", "page",
					"Add/Edit Remote UNIX/Linux profiles"));
			menus1.add(new CGI.menuItems("Remote MQTT", "mqttmachine", "", "page", "Add/Edit Remote MQTT profiles"));
			menus1.add(new CGI.menuItems("Remote Windows", "windowsmachine", "", "page",
					"Add/Edit Remote Win NT/2000 profiles"));
		}
		if (httprequest.actionAllowed("_tools")) {
			menus1.add(new CGI.menuItems("Tools", "monitor", "Tools", "operation", "Use monitor diagnostic tools"));
		}
		if (httprequest.actionAllowed("_progress")) {
			menus1.add(new CGI.menuItems("Progress", "Progress", "", "url", "View current monitoring progress"));
		}
		if (httprequest.actionAllowed("_browse")) {
			menus1.add(new CGI.menuItems("Summary", "monitorSummary", "", "page", "View current monitor settings"));
		}
		return menus1;
	}

	void printXML(com.dragonflow.SiteView.Monitor monitor) {
		jgl.HashMap hashmap = monitor.getValuesTable();
		java.lang.Object obj;
		String s;
		for (Enumeration enumeration = hashmap.keys(); enumeration.hasMoreElements(); outputStream
				.println(com.dragonflow.Utils.TextUtils.escapeXML("" + obj, s))) {
			obj = enumeration.nextElement();
			s = "" + hashmap.get(obj);
			s = s.replace('<', '*');
			s = s.replace('>', '*');
		}

	}

	/**
	 *
	 */
	public void printBody() throws java.lang.Exception {
		if (!request.actionAllowed("_browse")) {
			throw new HTTPRequestException(557);
		}
		boolean flag = request.getValue("xml").length() > 0;
		if (flag && request.getValue("all").length() > 0) {
			outputStream.println("<?xml version=\"1.0\"?>");
			outputStream.println("<siteview>");
			jgl.Array array = getAllowedGroupIDs();
			com.dragonflow.SiteView.SiteViewGroup siteviewgroup = SiteViewGroup.currentSiteView();
			for (int i = 0; i < array.size(); i++) {
				String s2 = (String) array.at(i);
				com.dragonflow.SiteView.MonitorGroup monitorgroup = (com.dragonflow.SiteView.MonitorGroup) siteviewgroup
						.getElement(s2);
				if (monitorgroup == null) {
					continue;
				}
				Enumeration enumeration1 = monitorgroup.getMonitors();
				outputStream.println("<group>");
				printXML(monitorgroup);
				outputStream.println(TextUtils.escapeXML("category",
						monitorgroup.getProperty(com.dragonflow.SiteView.MonitorGroup.pCategory)));
				outputStream.println("<monitors>");
				for (; enumeration1.hasMoreElements(); outputStream.println("</monitor>")) {
					com.dragonflow.SiteView.Monitor monitor = (com.dragonflow.SiteView.Monitor) enumeration1
							.nextElement();
					outputStream.println("<monitor>");
					printXML(monitor);
				}

				outputStream.println("</monitors>");
				outputStream.println("</group>");
			}

			outputStream.println("</siteview>");
			return;
		}
		sortKey = com.dragonflow.Page.browsePage.sortType(request.getValue("sort"));
		// String s = request.getValue("categorySelect");
    String categorySelectSelectedVal = request.getValue("categorySelect"); //the selected value that is in dropdown select element.
		if (categorySelectSelectedVal.length() == 0) {
			categorySelectSelectedVal = Monitor.ERROR_CATEGORY + com.dragonflow.SiteView.Monitor.WARNING_CATEGORY;
		}
		Enumeration enumeration = request.getValues("monitorTypeSelect");
		String s1;
		for (s1 = ""; enumeration.hasMoreElements(); s1 = s1 + enumeration.nextElement()) {
		}
		String statusSelect = request.getValue("statusSelect");
		String monitorNameSelect = request.getValue("monitorNameSelect");
		String machineNameSelect = request.getValue("machineNameSelect");
		String s6 = request.getValue("refresh");
		com.dragonflow.SiteView.SiteViewGroup siteviewgroup1 = null;
		jgl.HashMap hashmap = null;
		jgl.Array array1 = getAllowedGroupIDs();
		siteviewgroup1 = SiteViewGroup.currentSiteView();
		String s7 = siteviewgroup1.getValue("_browseRefreshDefault");
		if (s6.length() == 0) {
			s6 = s7;
		} else if (!s7.equals(s6)) {
			siteviewgroup1.setProperty("_browseRefreshDefault", s6);
			siteviewgroup1.saveSettings();
		}
		hashmap = MasterConfig.getMasterConfig();
		String s8 = request.getValue("onlyBrowserUnacknowledge");
		if (!flag) {
			String s9 = "";
			s9 = CGI.getTenant(request.getURL()) + "/SiteView/cgi/go.exe/SiteView?page=browse";
			if (s6.length() > 0) {
				s9 = CGI.getTenant(request.getURL()) + "/SiteView/cgi/go.exe/SiteView?page=browse&sort="
						+ request.getValue("sort") + "&account=" + request.getValue("account") + "&categorySelect="
						+ request.getValue("categorySelect") + "&statusSelect=" + request.getValue("statusSelect")
						+ "&monitorNameSelect=" + request.getValue("monitorNameSelect") + "&machineNameSelect="
						+ request.getValue("machineNameSelect") + "&refresh=" + request.getValue("refresh")
						+ "&onlyBrowserUnacknowledge=" + request.getValue("onlyBrowserUnacknowledge") + "&hide="
						+ request.getValue("hide");
				for (Enumeration enumeration2 = request.getValues("monitorTypeSelect"); enumeration2
						.hasMoreElements();) {
					s9 = s9 + "&monitorTypeSelect=" + enumeration2.nextElement();
				}

			}
			String s10 = "Browse SiteView Monitors";
      // s6 = getRefreshSelectHTML(s6, true);
			 java.util.HashMap<String, String> refreshMap = getRefreshSelectData(s6, true);
      s6 = refreshMap.get("refreshSelectedVal");
			if (s6.length() > 0 && !s6.equals("0")) {
				printRefreshHeader(s10, s9, com.dragonflow.Utils.TextUtils.toInt(s6));
			} else {
				printBodyHeader(s10);
			}
			com.dragonflow.Page.CGI.menus menus1 = getNavItems(request);
			printButtonBar("MonBrows.htm", "", menus1);
		}
		jgl.Array array2 = new Array();
		int j = 0;
		label0: for (int k = 0; k < array1.size(); k++) {
			String s12 = (String) array1.at(k);
			com.dragonflow.SiteView.MonitorGroup monitorgroup1 = (com.dragonflow.SiteView.MonitorGroup) siteviewgroup1
					.getElement(s12);
			if (monitorgroup1 == null) {
				continue;
			}
			Enumeration enumeration4 = monitorgroup1.getMonitors();
			do {
				com.dragonflow.SiteView.Monitor monitor2;
				do {
					if (!enumeration4.hasMoreElements()) {
						continue label0;
					}
					monitor2 = (com.dragonflow.SiteView.Monitor) enumeration4.nextElement();
				} while (monitor2 instanceof com.dragonflow.SiteView.SubGroup);
				j++;
				if (!categorySelectSelectedVal.equals("ALL")) {
					String s17 = monitor2.getProperty(com.dragonflow.SiteView.Monitor.pCategory);
					if (monitor2.isDisabled()) {
						s17 = "DISABLED";
					} else if (monitor2.isAcknowledged() && categorySelectSelectedVal.startsWith("ACKNOWLEDGE")) {
						s17 = "ACKNOWLEDGED";
					} else if ((categorySelectSelectedVal.startsWith(com.dragonflow.SiteView.Monitor.ERROR_CATEGORY)
							|| categorySelectSelectedVal.startsWith(com.dragonflow.SiteView.Monitor.WARNING_CATEGORY)) && s8.length() > 0
							&& monitor2.isAcknowledged()) {
						continue;
					}
					if (categorySelectSelectedVal.startsWith("NOT") ? categorySelectSelectedVal.substring(3).indexOf(s17) != -1 : categorySelectSelectedVal.indexOf(s17) == -1) {
						continue;
					}
				}
				if (statusSelect.length() > 0) {
					String s19 = monitor2.getTableStatusString(request);
					jgl.Array array3 = new Array();
					int l = com.dragonflow.Utils.TextUtils.matchExpression(s19, statusSelect, array3, new StringBuffer());
					if (l != Monitor.kURLok) {
						l = com.dragonflow.Utils.TextUtils.matchExpression(s19, statusSelect, array3, new StringBuffer());
					}
					if (l != Monitor.kURLok) {
						continue;
					}
				}
				if (monitorNameSelect.length() > 0) {
					String s20 = monitor2.getProperty(com.dragonflow.SiteView.Monitor.pName)
							+ monitor2.getProperty(com.dragonflow.SiteView.Monitor.pDescription);
					jgl.Array array4 = new Array();
					int i1 = com.dragonflow.Utils.TextUtils.matchExpression(s20, monitorNameSelect, array4, new StringBuffer());
					if (i1 != Monitor.kURLok) {
						i1 = com.dragonflow.Utils.TextUtils.matchExpression(s20, monitorNameSelect, array4, new StringBuffer());
					}
					if (i1 != Monitor.kURLok) {
						continue;
					}
				}
				if (machineNameSelect.length() > 0) {
					String s21 = monitor2.getHostname();
					jgl.Array array5 = new Array();
					int j1 = com.dragonflow.Utils.TextUtils.matchExpression(s21, machineNameSelect, array5, new StringBuffer());
					if (j1 != Monitor.kURLok) {
						j1 = com.dragonflow.Utils.TextUtils.matchExpression(s21, machineNameSelect, array5, new StringBuffer());
					}
					if (j1 != Monitor.kURLok) {
						continue;
					}
				}
				if (s1.length() <= 0 || s1.indexOf((String) monitor2.getClassProperty("class")) != -1) {
					array2.add(monitor2);
				}
			} while (true);
		}

		if (array2.size() > 1) {
			jgl.Sorting.sort(array2, this);
		}
		if (flag) {
			outputStream.println("<?xml version=\"1.0\"?>");
			outputStream.println("<siteview>");
			for (Enumeration enumeration3 = array2.elements(); enumeration3.hasMoreElements(); outputStream
					.println("</monitor>")) {
				com.dragonflow.SiteView.Monitor monitor1 = (com.dragonflow.SiteView.Monitor) enumeration3.nextElement();
				outputStream.println("<monitor>");
				printXML(monitor1);
			}

			outputStream.println("</siteview>");
		} else {
      String sortName = request.getValue("sort");
      String sortSelectedVal = sortName;
			String s11 = request.getValue("sort").equals("group") ? "selected" : "";
			String s13 = request.getValue("sort").equals("name") ? "selected" : "";
			String s14 = request.getValue("sort").equals("status") ? "selected" : "";
			String s15 = request.getValue("sort").equals("category") ? "selected" : "";
			String s16 = request.getValue("sort").equals("machine") ? "selected" : "";
			String s18 = request.getValue("hide");
      String _account = request.getAccount();
      outputStream.println("<link rel='import' href='/SiteView/htdocs/js/pages/browsePage/browsePage_Form.html' async='true'>\n");
			if (s18.length() == 0) {

				// outputStream.println("<br><FORM ACTION=/SiteView/cgi/go.exe/SiteView method=GET>"
        //         +"<input type=hidden name=page value=browse><input type=hidden name=account value="
				// 				+ request.getAccount() + ">" + "<input type=hidden name=hide value=\"checked\">"
				// 				+ "<input type=hidden name=machineNameSelect value=\"" + machineNameSelect + "\">"
				// 				+ "<input type=hidden name=sort value=" + request.getValue("sort") + ">"
				// 				+ "<input type=hidden name=monitorNameSelect value=\"" + monitorNameSelect + "\">");
        String _refresh = request.getValue("refresh");
        String categorySelect = request.getValue("categorySelect");
        String monitorTypeSelect ="";
    		for (Enumeration enumeration5 = request.getValues("monitorTypeSelect"); enumeration5
    				.hasMoreElements(); monitorTypeSelect = (String)enumeration5.nextElement()) {
    		}

				// outputStream.println("<input type=hidden name=refresh value=" + _refresh + ">"
				// 		+ "<input type=hidden name=statusSelect value=\"" + statusSelect + "\">"
				// 		+ "<input type=hidden name=categorySelect value=" + categorySelect + ">");
				// outputStream.println("<input type=submit value=\"&lt;&lt; Hide Controls\">");
				// outputStream.println("</form>");


				// outputStream.println("<FORM ACTION=/SiteView/cgi/go.exe/SiteView method=GET>"+
        //       "<input type=hidden name=page value=browse><input type=hidden name=account value="
				// 				+ request.getAccount() + ">");

				// outputStream.println("<table border=0 width=100% cellspacing=5><tr><td colspan=8><hr></td></tr>");
				// outputStream.println("<tr>");

				String as[] = {
						com.dragonflow.SiteView.Monitor.ERROR_CATEGORY
								+ com.dragonflow.SiteView.Monitor.WARNING_CATEGORY,
						com.dragonflow.SiteView.Monitor.ERROR_CATEGORY,
						com.dragonflow.SiteView.Monitor.WARNING_CATEGORY, com.dragonflow.SiteView.Monitor.GOOD_CATEGORY,
						com.dragonflow.SiteView.Monitor.NODATA_CATEGORY, "DISABLED", "ACKNOWLEDGED" };
				String as1[] = { "Error or Warning", "Error", "Warning", "OK", "No Data", "Disabled", "Acknowledged" };

        ArrayList<java.util.HashMap> categorySelectDataList= new ArrayList<java.util.HashMap>();

				// outputStream.println("<td valign=top>Category to Show/Hide: </td><td><select name=categorySelect>");
				boolean flag1 = TextUtils.getValue(getMasterConfig(), "_acknowledgeMonitors").equalsIgnoreCase("CHECKED");
				for (int k1 = 0; k1 < 2; k1++) {
					String s26 = k1 != 0 ? "Hide " : "Show ";
					String s27 = k1 != 0 ? "NOT" : "";
					for (int l1 = 0; l1 < as1.length; l1++) {
						if (!as1[l1].equals("Acknowledged") || flag1) {
              java.util.HashMap<String, String> dataMap = new java.util.HashMap<String, String>();
              dataMap.put("label", ""+s26 + as1[l1]);
              dataMap.put("value", ""+s27 + as[l1]);
              categorySelectDataList.add(dataMap);
							// outputStream.println("<option value=" + s27 + as[l1]+ (categorySelectSelectedVal.equals(s27 + as[l1]) ? " selected>" : ">") + s26 + as1[l1] + "</option>\n");
						}
					}

				}
        java.util.HashMap<String, String> tempAllMap = new java.util.HashMap<String, String>();
        tempAllMap.put("label", "Show All Categories");
        tempAllMap.put("value", "ALL");
        categorySelectDataList.add(tempAllMap);
        String categorySelectData = JSONObject.toJSONString(categorySelectDataList);
				// outputStream.println("<option value=ALL" + (categorySelectSelectedVal.equals("ALL") ? " selected" : "") + ">Show All Categories</option>\n");
				// outputStream.println("</select></td>\n");


				// outputStream.println("<td valign=top>&nbsp;&nbsp;Match Status:</td><td valign=top>"
        //         +"<input type=text name=statusSelect size=15 value=\""+ statusSelect + "\"></td>");
				// outputStream.println("<td valign=top>&nbsp;&nbsp;Refresh Option:</td><td valign=top>");
        // outputStream.println("</td>");
        // outputStream.println("</tr>");
        // outputStream.println("<tr>");
        java.util.HashMap<String, String> refreshSelectDataMap = getRefreshSelectData(s6, false);

				// outputStream.println(getMonitorTypeSelectHTML(s1));
        java.util.HashMap<String, String> monitorTypeSelectDataMap = getMonitorTypeSelectData(s1);

				// outputStream.println(
				// 		"<td valign=top>&nbsp;&nbsp;Match Name:</td><td valign=top><input type=text name=monitorNameSelect size=15 value=\""
				// 				+ monitorNameSelect + "\"></td>");
				// outputStream.println("</tr>");
				// outputStream.println("<tr>");

				// outputStream.println(
				// 		"<td valign=top>Sort by: </td><td valign=top><select size=1 name=sort>\n<option value=category "
				// 				+ s15 + ">status</option>\n" + "<option value=group " + s11 + ">group</option>\n"
				// 				+ "<option value=name " + s13 + ">name</option>\n" + "<option value=status " + s14
				// 				+ ">status text</option>\n" + "<option value=machine " + s16 + ">machine</option>\n"
				// 				+ "</select></td>\n");

				// outputStream.println("<td valign=top>&nbsp;Match Machine:</td><td valign=top><input type=text name=machineNameSelect size=15 value=\""+ machineNameSelect + "\"></td>");

				// outputStream.println("<td valign=top>&nbsp;</td>");
				// outputStream.println("<td valign=top><input type=submit value=\"Update and Refresh\"></td>");
				// outputStream.println("</tr>");
				// outputStream.println("</table><br clear=all>");
        String _acknowledgeMonitorsChecked = "";
        String _onlyBrowserUnacknowledged = com.dragonflow.Page.browsePage.getValue(hashmap, "_onlyBrowserUnacknowledged");
        String val = TextUtils.getValue(hashmap, "_acknowledgeMonitors");
        if (TextUtils.getValue(hashmap, "_acknowledgeMonitors").equalsIgnoreCase("CHECKED")) {
          _acknowledgeMonitorsChecked = s8.equals("CHECKED") ? "checked" : "";
          // outputStream.println("<input type=checkbox " + _acknowledgeMonitorsChecked + " value=CHECKED name=onlyBrowserUnacknowledge"
          // + com.dragonflow.Page.browsePage.getValue(hashmap, "_onlyBrowserUnacknowledged")
          // + ">Only display unacknowledged monitors that are in error or warning\n<br>");
        }
        // outputStream.println("</form>");

        outputStream.println("<browse-page-form"
        +" account='"+_account+"' "
        +" machine-name-select='"+machineNameSelect+"' "
        +" sort-name='"+sortName+"' "
        +" monitor-name-select='"+monitorNameSelect+"' "
        +" monitor-type-select='"+monitorTypeSelect+"' "
        +" refresh='"+_refresh+"' "
        +" status-select='"+statusSelect+"' "
        +" category-select='"+categorySelect+"' "
        +" category-select-selected-val='"+categorySelectSelectedVal+"' "
        +" category-select-data='"+categorySelectData+"' "
        +" refresh-selected-val='"+refreshSelectDataMap.get("refreshSelectedVal")+"' "
        +" refresh-select-data='"+refreshSelectDataMap.get("refreshSelectData")+"' "
        +" monitor-type-selected-val='"+monitorTypeSelectDataMap.get("monitorTypeSelectedVal")+"' "
        +" monitor-type-select-data='"+monitorTypeSelectDataMap.get("monitorTypeSelectData")+"' "
        +" sort-selected-val='"+sortSelectedVal+"' "
        +" acknowledge-monitors-checked='"+_acknowledgeMonitorsChecked+"' "
        +" only-browser-unacknowledged='"+_onlyBrowserUnacknowledged+"' "
        +"></browse-page-form>");

			} else {
				outputStream.println(
						"<FORM ACTION=/SiteView/cgi/go.exe/SiteView method=GET><input type=hidden name=page value=browse><input type=hidden name=account value="
								+ request.getAccount() + ">" + "<input type=hidden name=hide value=>"
								+ "<input type=hidden name=machineNameSelect value=\"" + machineNameSelect + "\">"
								+ "<input type=hidden name=sort value=" + request.getValue("sort") + ">"
								+ "<input type=hidden name=monitorNameSelect value=\"" + monitorNameSelect + "\">");
				for (Enumeration enumeration6 = request.getValues("monitorTypeSelect"); enumeration6
						.hasMoreElements(); outputStream.println("<input type=hidden name=monitorTypeSelect value="
								+ enumeration6.nextElement() + ">")) {
				}
				outputStream.println("<input type=hidden name=refresh value=" + request.getValue("refresh") + ">"
						+ "<input type=hidden name=statusSelect value=\"" + statusSelect + "\">"
						+ "<input type=hidden name=categorySelect value=" + request.getValue("categorySelect") + ">");
				outputStream.println("<input type=submit value=\"Show Controls &gt;&gt;\">");
				outputStream.println("</form>");
			}
			int ai[] = { com.dragonflow.SiteView.MonitorGroup.CATEGORY_COLUMN,
					com.dragonflow.SiteView.MonitorGroup.ACKNOWLEDGE_COLUMN,
					com.dragonflow.SiteView.MonitorGroup.GAUGE_COLUMN,
					com.dragonflow.SiteView.MonitorGroup.STATUS_COLUMN,
					com.dragonflow.SiteView.MonitorGroup.NAME_COLUMN, com.dragonflow.SiteView.MonitorGroup.GROUP_COLUMN,
					com.dragonflow.SiteView.MonitorGroup.EDIT_COLUMN,
					com.dragonflow.SiteView.MonitorGroup.REFRESH_COLUMN,
					com.dragonflow.SiteView.MonitorGroup.CUSTOM_COLUMN,
					com.dragonflow.SiteView.MonitorGroup.MACHINE_COLUMN,
					com.dragonflow.SiteView.MonitorGroup.UPDATED_COLUMN,
					com.dragonflow.SiteView.MonitorGroup.ALERT_COLUMN,
					com.dragonflow.SiteView.MonitorGroup.REPORT_COLUMN };
			String s22 = request.actionAllowed("_browse")
					? "<br><font size=\"-1\" style=\"font-weight:normal\"> Use the <A HREF="
							+ CGI.getTenant(request.getURL())
							+ "/SiteView/cgi/go.exe/SiteView?page=monitorSummary&account=" + request.getAccount()
							+ " >Monitor Description Report</a> to view current monitor configuration settings.</font>"
					: "";
			String s23 = "<h2>Browse Monitors (" + array2.size() + " out of " + j + ")</h2>" + s22;
			if (request.getValue("justTitle").length() == 0) {
				String s24 = MonitorGroup.printMonitorTable(outputStream, request, s23, "", ai, array2.elements());
				com.dragonflow.SiteView.MonitorGroup.printCategoryInsertHTML(s24, siteviewgroup1, outputStream);
			}
			printFooter(outputStream);
		}
	}

	java.util.HashMap<String, String> getRefreshSelectData(String s, boolean flag) { //getRefreshSelectHTML
		String as[] = { "0", "15", "30", "60", "120", "300" };
		String as1[] = { "Manual refresh", "Refresh 15 seconds", "Refresh 30 seconds", "Refresh every minute",
				"Refresh every two minutes", "Refresh every five minutes" };
    ArrayList<java.util.HashMap> refreshSelectDataList= new ArrayList<java.util.HashMap>();
    String refreshSelectedVal = new String(s);
		for (int i = 0; i < as.length && !s.equals(as[i]); i++) {
			if (i == as.length - 1) {
				refreshSelectedVal = new String(as[0]);
			}
		}

		for (int j = 0; j < as.length; j++) {
      java.util.HashMap<String, String> dataMap = new java.util.HashMap<String, String>();
      dataMap.put("label", ""+as1[j]);
      dataMap.put("value", ""+as[j]);
      refreshSelectDataList.add(dataMap);
		}
		// if (!flag) {
		// 	outputStream.println(s1);
		// }
    String refreshSelectData = JSONObject.toJSONString(refreshSelectDataList);
    java.util.HashMap<String, String> returnMap = new java.util.HashMap<String, String>();
    returnMap.put("refreshSelectedVal",refreshSelectedVal);
    returnMap.put("refreshSelectData",refreshSelectData);
		return returnMap;
	}

	/**
	 *
	 *
	 * @param s
	 * @return
	 */
	java.util.HashMap<String, String> getMonitorTypeSelectData(String s) {
		// String s1;
    String monitorTypeSelectedVal = "";
		Enumeration enumeration;
		jgl.Array array1;
    ArrayList<java.util.HashMap> monitorTypeSelectDataList= new ArrayList<java.util.HashMap>();

		// s1 = "<td valign=top>For Monitor Type: </td><td valign=top><SELECT NAME=monitorTypeSelect><option value=\"\">All types</option>\n";
		jgl.Array array = com.dragonflow.Page.monitorPage.getMonitorClasses(true);
		enumeration = array.elements();
		array1 = _getUsedMonitorClasses();
		java.lang.Class class1;
		while (enumeration.hasMoreElements()) {
			class1 = (java.lang.Class) enumeration.nextElement();
			com.dragonflow.SiteView.AtomicMonitor atomicmonitor;
			String s3;
			try {
				atomicmonitor = (com.dragonflow.SiteView.AtomicMonitor) class1.newInstance();
				s3 = request.getPermission("_monitorType", (String) atomicmonitor.getClassProperty("class"));
				if (s3.length() == 0) {
					s3 = request.getPermission("_monitorType", "default");
				}
				if (!s3.equals("hidden")) {
					String s4 = (String) atomicmonitor.getClassProperty("title");
					String s5 = (String) atomicmonitor.getClassProperty("class");
					if (array1.indexOf(s5) != -1) {
						monitorTypeSelectedVal = s.indexOf(s5) == -1 ? "" : s5;
            java.util.HashMap<String, String> dataMap = new java.util.HashMap<String, String>();
            dataMap.put("label", ""+s4);
            dataMap.put("value", ""+s5);
            monitorTypeSelectDataList.add(dataMap);
						// s1 = s1 + "<option value=" + s5 + s2 + ">" + s4 + "</option>\n";
					}
				}
			} catch (java.lang.Exception exception) {
				// System.out.println("Could not create instance of " + class1);
			}
		}

		// s1 = s1 + "</select></td>\n";
    String monitorTypeSelectData = JSONObject.toJSONString(monitorTypeSelectDataList);
    java.util.HashMap<String, String> returnMap = new java.util.HashMap<String, String>();
    returnMap.put("monitorTypeSelectedVal",monitorTypeSelectedVal);
    returnMap.put("monitorTypeSelectData",monitorTypeSelectData);
		return returnMap;
	}

	public void printCGIHeader() {
		request.printHeader(outputStream);
	}

	public void printCGIFooter() {
		outputStream.println("");
	}

	public static void main(String args[]) throws java.io.IOException {
		com.dragonflow.Page.browsePage browsepage = new browsePage();
		if (args.length > 0) {
			browsepage.args = args;
		}
		browsepage.handleRequest();
	}

	public static int sortType(String s) {
		if (s.equals("status")) {
			return 2;
		}
		if (s.equals("type")) {
			return 3;
		}
		if (s.equals("name")) {
			return 1;
		}
		if (s.equals("category")) {
			return 4;
		}
		if (s.equals("group")) {
			return 5;
		}
		if (s.equals("id")) {
			return 6;
		}
		return !s.equals("machine") ? 4 : 7;
	}

	public boolean execute(java.lang.Object obj, java.lang.Object obj1) {
		com.dragonflow.SiteView.Monitor monitor = (com.dragonflow.SiteView.Monitor) obj;
		com.dragonflow.SiteView.Monitor monitor1 = (com.dragonflow.SiteView.Monitor) obj1;
		int i = compareMonitors(monitor, monitor1, sortKey);
		if (i == 0) {
			i = compareMonitors(monitor, monitor1, secondaryKey);
		}
		return i > 0;
	}

	public int compareMonitors(com.dragonflow.SiteView.Monitor monitor, com.dragonflow.SiteView.Monitor monitor1,
			int i) {
		int j = 0;
		switch (i) {
		case 3: // '\003'
		case 6: // '\006'
		default:
			break;

		case 5: // '\005'
			j = monitor1.getProperty(com.dragonflow.SiteView.Monitor.pGroupID)
					.compareTo(monitor.getProperty(com.dragonflow.SiteView.Monitor.pGroupID));
			break;

		case 7: // '\007'
			j = monitor1.getHostname().compareTo(monitor.getHostname());
			break;

		case 1: // '\001'
			String s = monitor1.getProperty(com.dragonflow.SiteView.Monitor.pName).toLowerCase();
			String s1 = monitor.getProperty(com.dragonflow.SiteView.Monitor.pName).toLowerCase();
			j = s.compareTo(s1);
			break;

		case 2: // '\002'
			j = monitor1.getProperty(com.dragonflow.SiteView.Monitor.pStateString)
					.compareTo(monitor.getProperty(com.dragonflow.SiteView.Monitor.pStateString));
			break;

		case 4: // '\004'
			java.lang.Integer integer = (java.lang.Integer) com.dragonflow.SiteView.MonitorGroup.categoryMap
					.get(monitor.getProperty(com.dragonflow.SiteView.Monitor.pCategory));
			java.lang.Integer integer1 = (java.lang.Integer) com.dragonflow.SiteView.MonitorGroup.categoryMap
					.get(monitor1.getProperty(com.dragonflow.SiteView.Monitor.pCategory));
			if (integer != null && integer1 != null) {
				j = integer.intValue() - integer1.intValue();
			}
			break;
		}
		return j;
	}
}

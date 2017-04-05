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

import java.io.IOException;
import java.util.Date;
import java.util.Enumeration;
import java.util.Vector;

import jgl.Array;
import jgl.HashMap;
import jgl.LessString;

import com.dragonflow.HTTP.HTTPRequest;
import com.dragonflow.Properties.HashMapOrdered;
import com.dragonflow.SiteView.Health;
import com.dragonflow.SiteView.Machine;
import com.dragonflow.SiteView.MasterConfig;
import com.dragonflow.SiteView.Monitor;
import com.dragonflow.SiteView.MonitorGroup;
import com.dragonflow.SiteView.Platform;
import com.dragonflow.SiteView.Portal;
import com.dragonflow.SiteView.PortalSiteView;
import com.dragonflow.SiteView.SiteViewGroup;
import com.dragonflow.SiteView.SiteViewObject;
import com.dragonflow.SiteView.SubGroup;
import com.dragonflow.SiteView.User;
import com.dragonflow.Utils.FileUtils;
import com.dragonflow.Utils.I18N;
import com.dragonflow.Utils.LUtils;
import com.dragonflow.Utils.LocaleUtils;
import com.dragonflow.Utils.TextUtils;

import freemarker.template.Configuration;

// Referenced classes of package com.dragonflow.Page:
// treeControl

public abstract class CGI {
    public static class menuItems {

        private String menuLabel;

        private String menuLink;

        private String opLink;

        private String linkClass;

        private String toolTip;

        public menuItems(String s, String s1,
                String s2, String s3, String s4) {
            menuLabel = "";
            menuLink = "";
            opLink = "";
            linkClass = "";
            toolTip = "";
            menuLabel = s;
            menuLink = s1;
            opLink = s2;
            linkClass = s3;
            toolTip = s4;
        }
    }

    public static class menus extends jgl.Array {

        public menus() {
            add(new menuItems("Multi-view", "overview", "", "script",
                    "Open the SiteView Multi-view Window"));
            add(new menuItems("Manage Monitors/Groups", "manage", "", "page",
                    "Manage Monitors and Groups"));
        }
    }

    String args[];

    public com.dragonflow.HTTP.HTTPRequest request;

    public java.io.PrintWriter outputStream;
    public static Configuration cfg ;

    protected boolean autoFollowPortalRefresh;

    public static String nocacheHeader = "<meta http-equiv=\"Expires\" content=\"0\">\n<meta http-equiv=\"Pragma\" content=\"no-cache\">\n";

    public static String CONTENT_REGEX = "/<!--CONTENTSTART-->(.*)<!--CONTENTEND-->/s";

    private jgl.HashMap privateConfigCache;

    private jgl.HashMap privateLocalConfigCache;

    private jgl.Array settingsArray;

    public static final int SHOW_MONITORS = 1;

    public static final int SHOW_GROUPS = 2;

    public static final int ADD_NONE_OPTION = 4;

    public static final int HIDE_GROUP_PREFIX = 8;

    public static final int ADD_TOP_LEVEL_OPTION = 16;

    public static final int REVERSE_MONITOR_SPEC = 32;

    public static final int SHOW_ALL_GROUPS = 64;

    public static final int SELECTED_FIRST = 128;

    public static final int SHOW_GROUPS_AND_MONITORS = 3;

    public static final boolean ALL_GROUPS = false;

    public static final boolean TOP_LEVEL_GROUPS = true;

    public CGI() {
        args = null;
        request = null;
        outputStream = null;
        autoFollowPortalRefresh = true;
        privateConfigCache = null;
        privateLocalConfigCache = null;
        settingsArray = null;

    }

    public abstract void printBody() throws java.lang.Exception;

    public void initialize(HTTPRequest httprequest,
            java.io.PrintWriter printwriter) {
        request = httprequest;
        outputStream = printwriter;

		System.out.println(request.queryString);

		Enumeration enum1=request.getVariables();
		while(enum1.hasMoreElements())
		{
			String key1=enum1.nextElement().toString();

			Enumeration enum2=request.getValues(key1);
			while(enum2.hasMoreElements())
			{
				System.out.println(key1+"="+enum2.nextElement());
			}
		}
    }

    public void printBody(java.io.PrintWriter printwriter)
            throws java.lang.Exception {
        outputStream = printwriter;
        printBody();
    }

    public void printFooter(java.io.PrintWriter printwriter) {
        printFooter(printwriter, request);
    }

    public static void printFooter(java.io.PrintWriter printwriter,
            String s) {
        printFooter(printwriter, s, false);
    }

    public static void printFooter(java.io.PrintWriter printwriter,
            String s, boolean flag) {
        printFooter(printwriter, s, flag, true);
    }

    public static void printFooter(java.io.PrintWriter printwriter,String s, boolean showCopyright, boolean showLogo) {

        String version = Platform.getVersion();
    	if (!Platform.isSiteSeerAccount(s)) {

            String s1 = "";
            String logo = "SiteViewlogo.gif";
            if (Platform.isPortal()) {
                logo = "SiteReliancelogo.gif";
            }
            String copyright = "";
            if (showCopyright) {
                copyright = "<p align=center><font size=-2>"
                        + LocaleUtils.createLink(
                                LocaleUtils
                                        .getResourceBundle().getString(
                                                "TermsAndConditions"), 1,
                                "/SiteView/license.html") + "</font>";
            }
            String s7 = "";
            if (showLogo) {
                s7 = "<center>" + Platform.companyLogo
                        + "</center>";
            }

            printwriter
                    .println("<table class=fine border=0 cellspacing=0 width=500 align=center><tr><td><p class=fine align=center>"
                            + s7
                            + "<br>\n"
                            + "<small>"
                            + Platform.productName
                            + " "
                            + version
                            + ", "
                            + "<p>"
                            + Platform.copyright
                            + s1
                            + "</small>"
                            + copyright
                            + "</p></td></tr></table></BODY></HTML>");
        } else {
            String logoLink = "";
            if (showLogo) {
                logoLink = "<img src=http://www.dragonflow.com/images/common/dragonflow_logo.gif  width=\"184\" height=\"69\" border=\"\" alt=\""
                        + Platform.companyName
                        + "\"></a>\n";
            }
            String s4 = "";
            if (showCopyright) {
                s4 =  "<p align=center><font size=-2>"
                        + LocaleUtils.createLink(
                                LocaleUtils
                                        .getResourceBundle().getString(
                                                "TermsAndConditions"), 1,
                                "/SiteView/license.html") + "</font>";
            }
            printwriter
                    .println("<table class=fine border=0 cellspacing=0 width=\"100%\" align=center><tr><td><p class=fine align=center><a href="
                            + Platform.homeURLPrefix
                            + ">"
                            + logoLink
                            + "<br><small>"
                            + Platform.productName
                            + " "
                            + version
                            + "<br>"
                            + "<a href=\""
                            + Platform.homeURLPrefix
                            + "\">dragonflow.com</a> | \n"
                            + "<a href=\"http://support.dragonflow.com\">Customer Support</a> | \n"
                            + "<a href=\""
                            + Platform.homeURLPrefix
                            + "/company/contact_us/\">Contact Us</a> | \n"
                            + Platform.copyright
                            + "</small>"
                            + s4
                            + "</p>\n</center>\n</td></tr></table></BODY></HTML>");
        }
    }

    public static void printFooter(java.io.PrintWriter printwriter,
            HTTPRequest httprequest) {
        printFooter(printwriter, httprequest, false);
    }

    jgl.Array _getUsedMonitorClasses() {
        jgl.Array array = new Array();
        SiteViewGroup siteviewgroup = SiteViewGroup
                .currentSiteView();
        Enumeration enumeration = siteviewgroup.getGroupIDs()
                .elements();
        jgl.HashMap hashmap = new HashMap();
        while (enumeration.hasMoreElements()) {
            MonitorGroup monitorgroup = SiteViewGroup
                    .currentSiteView().getGroup(
                            I18N
                                    .toDefaultEncoding(enumeration
                                            .nextElement().toString()));
            Enumeration enumeration1 = monitorgroup.getMonitors();
            while (enumeration1.hasMoreElements()) {
                Monitor monitor = (Monitor) enumeration1
                        .nextElement();
                String s = monitor.getClass().getName();
                s = s.substring(s.lastIndexOf(".") + 1);
                hashmap.put(s, "");
            }
        }
        array = TextUtils.enumToArray(hashmap.keys());
        return array;
    }

    public static void printFooter(java.io.PrintWriter printwriter,
            HTTPRequest httprequest, boolean flag) {
        if (httprequest == null
                || !Platform
                        .isSiteSeerAccount(httprequest.getAccount())) {
            String s = "";
            String s2 = "SiteViewlogo.gif";
            if (Platform.isPortal()) {
                s2 = "SiteReliancelogo.gif";
            }
            if (httprequest != null) {
                String s4 = httprequest.getPermission("_partner");
                if (s4.length() > 0) {
                    SiteViewGroup siteviewgroup = SiteViewGroup
                            .currentSiteView();
                    MonitorGroup monitorgroup = (MonitorGroup) siteviewgroup
                            .getElement(s4);
                    if (monitorgroup != null) {
                        s = monitorgroup.getProperty("_partnerCopyrightHTML");
                    }
                }
            }
            String license = "";
            if (flag) {
                license = license = "<p class=fine align=center><font size=-2>"
                        + LocaleUtils.createLink(
                                LocaleUtils
                                        .getResourceBundle().getString(
                                                "TermsAndConditions"), 1,
                                "/SiteView/license.html") + "</font>";
            }
            String s6 = Platform.getVersion();
            printwriter
                    .println("<table class=fine border=0 cellspacing=0 width=500 align=center><tr><td><p class=fine align=center>"
                            + Platform.companyLogo
                            + "<p>\n"
                            + "<p class=fine align=center><small>"
                            + Platform.productName
                            + " "
                            + s6
                            + ", "
                            + Platform.copyright
                            + s
                            + "</small>"
                            + license
                            + "</p>\n</center>\n</td></tr></table></BODY></HTML>");
        } else {
            String s1 = "http://www.dragonflow.com/images/common/dragonflow_logo.gif";
            printwriter
                    .println("<table class=fine border=0 cellspacing=0 width=\"100%\" align=center><tr><td><p class=fine align=center><a href="
                            + Platform.homeURLPrefix
                            + ">"
                            + Platform.companyLogo
                            + Platform.companyName
                            + "\"></a>\n"
                            + "<br><small>"
                            + Platform.productName
                            + " "
                            + Platform.getVersion()
                            + "<br>"
                            + "<a href=\""
                            + Platform.homeURLPrefix
                            + "\">dragonflow.com</a> | \n"
                            + "<a href=\"http://support.dragonflow.com\">Customer Support</a> | \n"
                            + "<a href=\""
                            + Platform.homeURLPrefix
                            + "/company/contact_us/\">Contact Us</a> | \n"
                            + Platform.copyright
                            + "</small>"
                            + "</p>\n</center>\n</td></tr></table></BODY></HTML>");
        }
    }

    public void printButtonBar(String s, String s1,
            menus menus1) {
        printButtonBar(outputStream, s, s1, request,getLocalMasterConfig(), menus1, false);
    }

    public void printButtonBar(String s, String s1) {
        printButtonBar(outputStream, s, s1, request,
                getLocalMasterConfig());
    }

    public static String getSubmitName(String s) {
        if (s.equals("Edit")) {
            return "Update";
        } else {
            return s;
        }
    }

    public static String reportURL(
            HTTPRequest httprequest) {
        if (httprequest.getAccount().equals("user")) {
            return Platform.getURLPath("userhtml",
                    httprequest.getAccount())
                    + "/Reports.html";
        } else {
            return "/SiteView/cgi/go.exe/SiteView?page=report&operation=List&view=Report&account="
                    + httprequest.getAccount();
        }
    }

    public static void printCurrentSiteView(java.io.PrintWriter printwriter,
            HTTPRequest httprequest) {
        if (com.dragonflow.Page.CGI.isPortalServerRequest(httprequest)) {
            PortalSiteView portalsiteview = (PortalSiteView) Portal
                    .getSiteViewForID(httprequest.getPortalServer());
            if (portalsiteview != null) {
                printwriter.println("<HR><B><FONT SIZE=+2>"
                        + portalsiteview.getProperty("_title")
                        + "</FONT></B> - information is for the "
                        + portalsiteview.getProperty("_title")
                        + " SiteView<HR>");
            }
        }
    }

    private static void printSecondNavBar(java.io.PrintWriter printwriter,
            HTTPRequest httprequest, menus menus1, int i,
            boolean flag) {
        if (menus1.size() < 3) {
            if (httprequest.actionAllowed("_browse")) {
                menus1.add(new menuItems("Browse", "browse", "", "page",
                        "Browse Monitors"));
            }
            if (httprequest.actionAllowed("_preference")) {
                menus1.add(new menuItems("Remote UNIX/LINUX", "machine", "", "page",
                        "Add/Edit Remote UNIX/Linux profiles"));
                menus1.add(new menuItems("Remote Windows", "ntmachine", "", "page",
                        "Add/Edit Remote Win NT/2000 profiles"));
            }
            if (httprequest.actionAllowed("_tools")) {
                menus1.add(new menuItems("Tools", "monitor", "Tools",
                        "operation", "Use monitor diagnostic tools"));
            }
            if (httprequest.actionAllowed("_progress")) {
                menus1.add(new menuItems("Progress", "Progress", "", "url",
                        "View current monitoring progress"));
            }
            if (httprequest.actionAllowed("_browse")) {
                menus1.add(new menuItems("Summary", "monitorSummary", "",
                        "page", "View current monitor settings"));
            }
        }
        if (Platform.isSiteSeerAccount(httprequest.getAccount())) {
            return;
        }
        printwriter.print("<TABLE class=\"subnav\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"4\"><TR class=\"subnav\"><TD><img src=/SiteView/htdocs/artwork/empty1111.gif width=10 height=10 border=0></td>");
        if (menus1.size() != 0) {
            for (int j = 0; j < menus1.size(); j++) {
                menuItems menuitems = (menuItems) menus1.at(j);
                if (menuitems.linkClass.equals("url")) {
                    printwriter
                            .print("<TD><p class=navbar align=center> <font size=-1 face=Arial, sans-serif><b><a href=\"/SiteView/"
                                    + httprequest.getAccountDirectory()
                                    + "/"
                                    + menuitems.menuLink
                                    + ".html\" title=\""
                                    + menuitems.toolTip
                                    + "\">"
                                    + menuitems.menuLabel
                                    + "</a></b></font></p>");
                } else if (menuitems.linkClass.equals("script")) {
                    if (httprequest.isStandardAccount()) {
                        printwriter
                                .print("<TD><p class=navbar align=center> <font size=-1 face=Arial, sans-serif><b><a href=\"javascript:OpenOverview()\" title=\""
                                        + menuitems.toolTip
                                        + "\">"
                                        + menuitems.menuLabel
                                        + "</a></b></font></p>");
                    }
                } else if (menuitems.linkClass.equals("operation")) {
                    printwriter
                            .print("<TD><p class=navbar align=center> <font size=-1 face=Arial, sans-serif><b><a href=\"/SiteView/cgi/go.exe/SiteView?page="
                                    + menuitems.menuLink
                                    + "&operation="
                                    + menuitems.opLink
                                    + "&account="
                                    + httprequest.getAccount()
                                    + "\" title=\""
                                    + menuitems.toolTip
                                    + "\">"
                                    + menuitems.menuLabel
                                    + "</a></b></font></p>");
                } else {
                    printwriter
                            .print("<TD><p class=navbar align=center> <font size=-1 face=Arial, sans-serif><b><a href=\"/SiteView/cgi/go.exe/SiteView?page="
                                    + menuitems.menuLink
                                    + "&account="
                                    + httprequest.getAccount()
                                    + "\"  title=\""
                                    + menuitems.toolTip
                                    + "\">"
                                    + menuitems.menuLabel
                                    + "</a></b></font></p>");
                }
                printwriter
                        .print("<TD><img src=/SiteView/htdocs/artwork/empty1111.gif width=10 height=10 border=0></td>");
            }

            printwriter.print("</TR></table>\n");
        }
    }

    private static void printSecondNavBar(java.io.PrintWriter printwriter,
            HTTPRequest httprequest, int i, boolean flag) {
        if (Platform.isSiteSeerAccount(httprequest
                .getAccount())) {
            return;
        }
        String s = "<TD>&nbsp;</td>";
        if (httprequest.actionAllowed("_preference")) {
            String s1 = "general";
            s = "<TD><p class=navbar align=center> <font size=-1 face=Arial, sans-serif><b><a href=/SiteView/cgi/go.exe/SiteView?page="
                    + s1
                    + "Prefs&account="
                    + httprequest.getAccount()
                    + ">"
                    + LocaleUtils.getResourceBundle()
                            .getString("Preferences")
                    + "</a></b></font></p></TD>\n";
        }
        String s2 = "<TD><img src=/SiteView/htdocs/artwork/empty1111.gif width=10 height=10 border=0></td>";
        if (httprequest.actionAllowed("_browse")) {
            s2 = "<TD><img src=/SiteView/htdocs/artwork/empty1111.gif width=10 height=10 border=0></td><TD><p class=navbar align=center><font size=-1 face=Arial, sans-serif><b><A HREF=/SiteView/cgi/go.exe/SiteView?page=browse&account="
                    + httprequest.getAccount()
                    + ">"
                    + LocaleUtils.getResourceBundle()
                            .getString("BrowseMonitors")
                    + "</A></b></font></p></TD>\n";
        }
        String s3 = "<TD><img src=/SiteView/htdocs/artwork/empty1111.gif width=10 height=10 border=0></td>";
        if ((httprequest.actionAllowed("_groupEdit")
                || httprequest.actionAllowed("_groupDisable") || httprequest
                .actionAllowed("_groupRefresh"))
                && !httprequest.getPermission("_link", "deleteGroup").equals(
                        "hidden")) {
            s3 = "<TD><img src=/SiteView/htdocs/artwork/empty1111.gif width=10 height=10 border=0></td><TD><p class=navbar align=center><font size=-1 face=Arial, sans-serif><b><A HREF=/SiteView/cgi/go.exe/SiteView?page=manage&account="
                    + httprequest.getAccount()
                    + ">"
                    + LocaleUtils.getResourceBundle()
                            .getString("Manage") + "</A></b></font></p></TD>\n";
        }
        String s4 = "<TD><img src=/SiteView/htdocs/artwork/empty1111.gif width=10 height=10 border=0></td>";
        if (httprequest.actionAllowed("_tools")) {
            s4 = "<TD><img src=/SiteView/htdocs/artwork/empty1111.gif width=10 height=10 border=0></td><TD><p class=navbar align=center><font size=-1 face=Arial, sans-serif><b><A HREF=/SiteView/cgi/go.exe/SiteView?page=monitor&operation=Tools&account="
                    + httprequest.getAccount()
                    + ">"
                    + LocaleUtils.getResourceBundle()
                            .getString("DiagnosticTools")
                    + "</A></b></font></p></TD>\n";
        }
        String s5 = "<TD><img src=/SiteView/htdocs/artwork/empty1111.gif width=10 height=10 border=0></td>";
        if (httprequest.actionAllowed("_support")) {
            s5 = "<TD><img src=/SiteView/htdocs/artwork/empty1111.gif width=10 height=10 border=0></td><TD><p class=navbar align=center><font size=-1 face=Arial, sans-serif><b><a href=\"http://support.dragonflow.com/\" target=\"Help\">"
                    + LocaleUtils.getResourceBundle()
                            .getString("SupportRequest")
                    + "</a></b></font></p></td>\n";
        }
        printwriter
                .println("<img src=/SiteView/htdocs/artwork/empty6010.gif height=5 width=10><br>\n");
        if (flag) {
            printwriter
                    .print("<TABLE border=0 align=center cellpadding=0 width="
                            + i + "><TR>" + s + s2 + s3 + s4 + s5
                            + "</TR></TABLE>\n");
        } else {
            printwriter.print("<center><TABLE border=0 cellpadding=0 width="
                    + i + "><TR>" + s + s2 + s3 + s4 + s5
                    + "</TR></table></center>\n");
        }
    }

    public static void printButtonBar(java.io.PrintWriter printwriter,String s, String s1,HTTPRequest httprequest, jgl.HashMap hashmap) {

    	printButtonBar(printwriter, s, s1, httprequest,hashmap, false);
    }

    public static void printButtonBar(java.io.PrintWriter printwriter,
            String s, String s1,HTTPRequest httprequest, jgl.HashMap hashmap,boolean flag) {

    	menus menus1 = new menus();
        printButtonBar(printwriter, s, s1, httprequest,hashmap, menus1, flag);
    }

    public static void printButtonBar(java.io.PrintWriter printwriter,
            String s, String selected,HTTPRequest httprequest, jgl.HashMap hashmap,menus menus1, boolean flag) {
        if (Platform.isPortal()) {
            if (httprequest.getValue("toolbar").equals("off")) {
                return;
            }
            User user = httprequest.getUser();
            String buttonBar = user.getProperty("_buttonBar");
            if (buttonBar.length() == 0) {
                buttonBar = "Toolbar.htm";
            }
            String s5 = Portal.getViewContent(buttonBar, httprequest);
            s5 = TextUtils.replaceString(s5,"CentraScopeTOC.htm", s);
            printwriter.println(s5);
            com.dragonflow.Page.CGI.printCurrentSiteView(printwriter,httprequest);
            return;
        }
        String home = "/SiteView/" + httprequest.getAccountDirectory() + "/SiteView.html";
        String s4 = reportURL(httprequest);
        String alert = "";
        if (httprequest.actionAllowed("_alertList")) {
            alert = "/SiteView/cgi/go.exe/SiteView?page=alert&operation=List&view=Alert&account=" + httprequest.getAccount();
        } else {
            alert = home;
        }
        String overviewPage = "/SiteView/cgi/go.exe/SiteView?page=overview&account=" + httprequest.getAccount();
        String healthView = "";
        if (httprequest.actionAllowed("_healthView")
                || httprequest.actionAllowed("_healthEdit")) {
            healthView = "/SiteView/cgi/go.exe/SiteView?page=health&operation=List&account="
                    + httprequest.getAccount();
        } else {
            healthView = home;
        }
        String generalPrefs = "/SiteView/cgi/go.exe/SiteView?page=generalPrefs&account=" + httprequest.getAccount();
        String preferences = "preferences";
        if (httprequest.actionAllowed("_preference") || httprequest.actionAllowed("_detachFromMA")) {
            generalPrefs = "/SiteView/cgi/go.exe/SiteView?page=generalPrefs&account=" + httprequest.getAccount();
            preferences = "preferences";
        } else {
            generalPrefs = home;
        }
        String siteview = "siteview";
        String alerts = "alerts";
        String reports = "reports";
        String overview = "overview";
        String curSelected = "SiteView";
        String healthState = Health.getHealthState();
        if (healthState.equals("nodata")) {
            healthState = "disable";
        }
        String health = "Health" + healthState.toLowerCase();
        if (httprequest.isSiteSeerAccount()) {
            siteview = "siteseer";
        }
        if (selected.equals("SiteView")) {
            curSelected = "SiteView";
            siteview = "H" + siteview;
        } else if (selected.equals("Alerts")) {
            curSelected = "Alerts";
            alerts = "H" + alerts;
        } else if (selected.equals("Reports")) {
            curSelected = "Reports";
            reports = "H" + reports;
        } else if (selected.equals("Health")) {
            curSelected = "Health";
            health = "H" + health;
        } else if (selected.equals("Preference")) {
            curSelected = "Preferences";
            preferences = "H" + preferences;
        } else if (selected.length() != 0) {
            curSelected = "Alerts";
            alerts = "alerts";
        }
        if (httprequest.isStandardAccount()) {
          
          printwriter.println("<link rel='import' href='/SiteView/htdocs/js/components/monitor-tabs/monitor-tabs.html'>\n");
          printwriter.println("<link rel='import' href='/SiteView/htdocs/js/components/monitor-tabs/monitor-tabs-header.html'>\n");
            printwriter.println("<SCRIPT LANGUAGE = \"JavaScript\">\n");
            printwriter
                    .println("<!--\nfunction OpenOverview()\n{\noverviewWindow=window.open(\""
                            + overviewPage
                            + "\",\"SiteView\",\""
                            + TextUtils.getValue(hashmap,
                                    "_overviewOptions")
                            + "\");\n"
                            + "location.reload();\n"
                            + "}\n"
                            + "if (location.search == '?openMultiView') { OpenOverview();}\n"
                            + "//-->\n");
            printwriter.println("</SCRIPT>\n");
        }
        if (!selected.equals("SiteView")) {
            String partnerHeaderHTML = "";
            String partner = httprequest.getPermission("_partner");
            if (partner.length() > 0) {
                SiteViewGroup siteviewgroup = SiteViewGroup.currentSiteView();
                MonitorGroup monitorgroup = (MonitorGroup) siteviewgroup.getElement(partner);
                if (monitorgroup != null) {
                    partnerHeaderHTML = monitorgroup.getProperty("_partnerHeaderHTML");
                }
            }
            if (partnerHeaderHTML.length() == 0) {
                partnerHeaderHTML = com.dragonflow.Page.CGI.getValue(hashmap, "_headerHTML");
            }
            printwriter.print(partnerHeaderHTML);
            printwriter.println(Platform.licenseHeader(
                    hashmap, true, httprequest.getAccount()));
        }
        printwriter.print("<table border=\"0\" align=\"center\" cellspacing=\"0\" cellpadding=\"0\" width=\"100%\"><TR class=\"navbox\"><TD>\n");
        printwriter.print("<table class=\"topnav\" border=\"0\" align=\"center\" cellspacing=\"0\" cellpadding=\"0\"><TR class=\"topnav\">\n<TD></td>");
        byte byte0 = 106;
        String productName = Platform.productName;
        //TBD: need consider the permission, refer to the original
        String jsonObjStr = "{'SiteView':'"+home+"'"
        				+ ",'Alerts':'"+alert+"'"
        				+ ",'Reports':'"+s4+"'"
        				+ ",'Health':'"+healthView+"'"
        				+ ",'Preferences':'"+generalPrefs+"'"
        				+ ",'Help':'/SiteView/docs/"+s+"'}";
       
        printwriter.println("<monitor-tabs-header cur-selected="+curSelected+" json-data-str="+jsonObjStr+"></monitor-tabs-header>");
       
      //   printwriter.println("<TD><a href="
      //                   + s2
      //                   + "><IMG SRC=/SiteView/htdocs/artwork/"
      //                   + s11
      //                   + ".gif ALT=\"SiteView Main View\""
      //                   + " width="
      //                   + byte0
      //                   + " height=44\n"
      //                   + "border=0></a></td><TD><a href="
      //                   + s6
      //                   + ">"
      //                   + "<IMG SRC=/SiteView/htdocs/artwork/"
      //                   + s12
      //                   + ".gif ALT=\"View/add/edit automated alerts\" width=82 height=44 border=0></a></td>\n");
      //   printwriter
      //           .println("<TD><a href="
      //                   + s4
      //                   + ">"
      //                   + "<IMG SRC=/SiteView/htdocs/artwork/"
      //                   + s13
      //                   + ".gif ALT=\"View/create/edit automated and adhoc reports\" width=82 height=44 border=0></a></td>\n");
      //   if (!Platform.isSiteSeerAccount(httprequest
      //           .getAccount())) {
      //       printwriter
      //               .println("<TD><a href="
      //                       + s8
      //                       + "><IMG SRC=/SiteView/htdocs/artwork/"
      //                       + s16
      //                       + ".gif ALT=\"View current health of SiteView processes and files\" width=82 height=44 border=0></a></td>\n");
      //       printwriter
      //               .println("<TD><a href="
      //                       + s9
      //                       + "><IMG SRC=/SiteView/htdocs/artwork/"
      //                       + s10
      //                       + ".gif ALT=\"View/edit SiteView configuration settings and options\" height=44 border=0></a></td>\n");
      //   }
      //   String s20 = "<a href=/SiteView/docs/" + s + " TARGET=Help>";
      //   printwriter
      //           .println("<TD>"
      //                   + s20
      //                   + "<IMG SRC=/SiteView/htdocs/artwork/help.gif ALT=\"View the online SiteView User's Guide\" width=82 height=44\n"
      //                   + "border=0></a></td><TD><IMG SRC=/SiteView/htdocs/artwork/right.gif width=35 height=44 ALT=\"\" border=0>"
      //                   + "</td></TR></TABLE>\n");
        printwriter.println("</td></TR><TR class=\"navbox\"><TD>");
        printSecondNavBar(printwriter, httprequest,menus1, 600, flag);
        printwriter.println("</td></TR><TR class=\"navbox\"><TD>");
        printNavBarMessages(printwriter);
        printwriter.print("</TD></TR></TABLE>\n");
    }

    void printErrorHeader() {
        outputStream
                .println("<HR><CENTER><FONT SIZE=+2> Error </FONT><BR>There was an error in the entered information - the error message is displayed in italics to the right of the field that is in error.</CENTER><HR>");
    }

    void printError(String s, String s1, String s2) {
        com.dragonflow.Page.CGI.printError(outputStream, s, s1, s2);
    }

    static void printError(java.io.PrintWriter printwriter, String s,
            String s1, String s2) {
        printRefreshHeader(printwriter, "", s2, 1);
        printwriter.print(s + "<HR>" + s1 + "<HR>");
        HTTPRequest httprequest = null;
        printFooter(printwriter, httprequest);
        printwriter.println("</BODY>");
    }

    public static void printHeadTag(java.io.PrintWriter printwriter,
            String s, String s1) {
        printHeadTag(printwriter, s, s1,
                Platform.charSetTag);
    }

    public static void printHeadTag(java.io.PrintWriter printwriter,
            String s, String s1, String s2) {
        SiteViewGroup siteviewgroup = SiteViewGroup
                .currentSiteView();
        SiteViewGroup _tmp = siteviewgroup;
        String s3 = SiteViewGroup
                .getServerID();
        printwriter.println("<HEAD>\n" + nocacheHeader + s2 + s1 + "\n<TITLE>"
                + s3 + " : " + s + "</TITLE>\n"
                		+ "<script type='text/javascript' src='/SiteView/htdocs/js/appRoot.js'></script>\n"
                		+ "<script type='text/javascript' async='true' src='/SiteView/htdocs/js/bower_components/webcomponentsjs/webcomponents-lite.min.js'></script>\n");
        printwriter
                .println("<link rel=\"stylesheet\" type=\"text/css\" href=\"/SiteView/htdocs/artwork/siteviewUI.css\">\n"
                		+ "<link rel=\"stylesheet\" type=\"text/css\" href=\"/SiteView/htdocs/artwork/user.css\">\n "
                		+"<link rel='import' href='/SiteView/htdocs/js/bower_components/paper-styles/paper-styles.html'>\n"
                		+ "</HEAD>\n");
    }

    public void printHeadTagAWRequest(java.io.PrintWriter printwriter,
            String s, String s1, String s2) {
        printwriter.println("<HEAD>\n" + nocacheHeader + s2 + s1);
        if (request.getValue("AWRequest").equals("yes")) {
            printwriter
                    .println("<style type=\"text/css\">.darkrow {COLOR: black; BACKGROUND-COLOR: #cccc99; FONT-FAMILY: Verdana; FONT-SIZE: 7.5pt }.lightrow { COLOR: black; BACKGROUND-COLOR: #efefdf; FONT-FAMILY: Verdana; FONT-SIZE: 7.5pt }.titlerow { BACKGROUND-COLOR: #330066; COLOR: white; FONT-FAMILY: Verdana; FONT-SIZE: 8pt } .VerBl8 { COLOR: black; FONT-FAMILY: Verdana; FONT-SIZE: 8pt }.VerdanaDB10 { COLOR: #330066; FONT-FAMILY: Verdana; FONT-SIZE: 10pt }</style>\n");
        }
        printwriter
                .println("<TITLE>"
                        + s
                        + "</TITLE>"
                        + "\n<link rel=\"stylesheet\" type=\"text/css\" href=\"/SiteView/htdocs/artwork/siteviewUI.css\">\n"
                        + "</HEAD>\n");
    }

    public static void printBodyHeader(java.io.PrintWriter printwriter,
            String s, String s1) {
        printBodyHeader(printwriter, s, s1, "");
    }

    public static void printBodyHeader(java.io.PrintWriter printwriter,
            String s, String s1, String s2) {
        String s3 = "";
        if (s2.length() > 0) {
            s3 = "<META HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html;CHARSET="
                    + s2 + "\">\n";
        } else {
            s3 = Platform.charSetTag;
        }
        printHeadTag(printwriter, s, s1, s3);
        String s4 = "";
        if (s.toLowerCase().indexOf("overview") != -1) {
            s4 = " onload=\"window.focus()\"";
        }
        printwriter
                .println("<BODY BGCOLOR=\"#ffffff\" link=#1155bb alink=#1155bb vlink=#1155bb"
                        + s4 + ">\n");
    }

    public void printBodyHeader(String header) {
        if (!request.getValue("AWRequest").equals("yes")) {
            printBodyHeader(outputStream, header, "");
        } else {
            printBodyHeaderAWRequest(outputStream, header, "", "");
        }
    }

    public static String getGroupDetailURL(
            HTTPRequest httprequest, String s) {
        String s1 = httprequest.getValue("_health").length() <= 0 ? ""
                : "?_health=true";
        return "/SiteView/" + httprequest.getAccountDirectory() + "/Detail"
                + HTTPRequest.encodeString(s) + ".html" + s1;
    }

    public void printBodyHeaderAWRequest(java.io.PrintWriter printwriter,
            String s, String s1, String s2) {
        String s3 = "";
        if (s2.length() > 0) {
            s3 = "<META HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html;CHARSET="
                    + s2 + "\">\n";
        }
        printHeadTagAWRequest(printwriter, s, s1, s3);
        printwriter.println("<BODY BGCOLOR=\"#ffffff\" class=\"VerBl8\">\n");
    }

    public static void printRefreshHeader(java.io.PrintWriter printwriter,
            String s, String s1, int i) {
        printBodyHeader(printwriter, s,
                "<meta HTTP-EQUIV=\"Refresh\" CONTENT=\"" + i + "; URL=" + s1
                        + "\">\n");
        printwriter.flush();
    }

    public String getWhereURL(String s) {
        if (isPortalServerRequest() && autoFollowPortalRefresh) {
            if (request.getValue("rview").length() > 0) {
                s = getPageLink("portal", "") + "&view="
                        + request.getValue("rview");
                if (request.getValue("detail").length() > 0) {
                    String s1 = request.getValue("detail");
                    if (s1.indexOf('=') > 0) {
                        s1 = s1.substring(0, s1.indexOf('=')) + "%3D"
                                + s1.substring(s1.indexOf('=') + 1);
                    }
                    if (s1.indexOf('&') > 0) {
                        s1 = s1.substring(0, s1.indexOf('&')) + "%26"
                                + s1.substring(s1.indexOf('&') + 1);
                    }
                    s = s + "&detail=" + s1;
                }
            } else {
                s = getPageLink("portalMain", "");
            }
        }
        return s;
    }

    public String getWhereLabel(String s) {
        if (isPortalServerRequest()) {
            s = "Return";
        }
        return s;
    }

    public void printRefreshHeader(String s, String s1,
            int i) {
        s1 = getWhereURL(s1);
        printRefreshHeader(outputStream, s, s1, i);
    }

    public void printRefreshPage(String s, int i) {
        printRefreshHeader("", s, i);
        outputStream
                .println("<!--<br><br><br><br><hr><br><h3 align=center>SiteView is running</h3><br> <p align=center>If your browser doesn't refresh in 5 seconds, click on <A HREF="
                        + s
                        + ">this link</A> to continue.</p>"
                        + "<br><hr>\n"
                        + "<p class=fine align=center>"
                        + Platform.companyLogo
                        + "--></body>");
    }

    public void printReturnRefresh(String s, int i) {
        printRefreshPage(s, i);
    }

    public void printCGIHeader() {
        request.printHeader(outputStream);
        outputStream.println("<HTML>");
    }

    public void printCGIFooter() {
        outputStream.println("</HTML>");
        outputStream.flush();
    }

    public void printLicenseExceeded(Monitor monitor,
            String s, int i, String s1) {
        String s2 = (String) monitor.getClassProperty("title");
        printButtonBar((String) monitor.getClassProperty("help"), s);
        outputStream.print("<HR>");
        if (s1.equals("license")) {
            outputStream.println(LUtils.getLicenseExceededHTML());
        } else {
            String s4 = "";
            if (s1.equals("class")) {
                s4 = " " + s2;
            }
            outputStream.print("You have reached your limit of " + i + s4
                    + " monitors for this account.");
        }
        outputStream.print("<HR><P><A HREF="
                + getGroupDetailURL(request, s)
                + ">Return to Group</A>\n");
        printFooter(outputStream);
    }

    public void printTooManyFAndIMonitors(String s, int i) {
        outputStream.print("<HR>");
        outputStream.print("You have reached your limit of " + i
                + " frames and images for this account.");
        outputStream.print("<HR><P><A HREF="
                + getGroupDetailURL(request, s)
                + ">Return to Group</A>\n");
        printFooter(outputStream);
    }

    public void printContentStartComment() {
        outputStream.println("\n<!--CONTENTSTART-->");
    }

    public void printContentEndComment() {
        outputStream.println("\n<!--CONTENTEND-->");
    }

    public void handleRequest() {
        outputStream.println("Content-type: text/html\n\n<HTML>");
        try {
            java.io.BufferedReader bufferedreader = FileUtils
                    .MakeInputReader(System.in);
            if (args != null) {
                request = new HTTPRequest(args);
                request.setUser(request.getAccount());
            } else {
                request = new HTTPRequest(bufferedreader);
            }
            printBody();
        } catch (java.lang.Exception exception) {
            printError("There was a unexpected problem.", exception.toString(),
                    "/SiteView/" + request.getAccountDirectory()
                            + "/SiteView.html");
        }
        printCGIFooter();
    }

    boolean isGroup(jgl.HashMap hashmap) {
        return hashmap.get("_id") == null;
    }

    jgl.Array getAllowedGroupIDs() {
        return getAllowedGroupIDsForAccount(request);
    }

    public static boolean isRelated(String s, String s1) {
        SiteViewGroup siteviewgroup = SiteViewGroup
                .currentSiteView();
        Object obj = null;
        while (s.length() != 0) {
            if (s.equals(s1)) {
                return true;
            }
            Monitor monitor;
            if (com.dragonflow.Page.treeControl.useTree()) {
                String as[] = TextUtils.split(s,
                        "/");
                if (as[0].equals(s1)) {
                    return true;
                }
                monitor = (Monitor) siteviewgroup
                        .getElement(as[0]);
            } else {
                monitor = (Monitor) siteviewgroup
                        .getElement(s);
            }
            if (monitor == null) {
                break;
            }
            s = I18N.toDefaultEncoding(monitor
                    .getProperty("_parent"));
        }
        return false;
    }

    public static jgl.Array getAllowedGroupIDsForAccount(
            HTTPRequest httprequest) {
        if (com.dragonflow.Page.CGI.isPortalServerRequest(httprequest)) {
            jgl.Array array = Portal.findObjects(
                    "item=" + httprequest.getPortalServer(), 2, httprequest);
            jgl.Array array2 = new Array();
            for (int i = 0; i < array.size(); i++) {
                MonitorGroup monitorgroup = (MonitorGroup) array
                        .at(i);
                array2
                        .add(I18N
                                .toDefaultEncoding(monitorgroup
                                        .getProperty(MonitorGroup.pID)));
            }

            return array2;
        } else {
            jgl.Array array1 = I18N
                    .toDefaultArray(SiteViewGroup
                            .currentSiteView().getGroupIDs());
            return com.dragonflow.Page.CGI.filterGroupsForAccount(array1,
                    httprequest);
        }
    }

    public static jgl.Array getGroupFilterForAccount(
            HTTPRequest httprequest) {
        jgl.Array array = new Array();
        String s = httprequest.getAccount();
        String s1 = httprequest.getValue("groupFilter");
        if (Platform.isStandardAccount(s)) {
            Enumeration enumeration = httprequest.getUser()
                    .getMultipleValues("_group");
            if (enumeration.hasMoreElements()) {
                while (enumeration.hasMoreElements()) {
                    String s2 = I18N
                            .toDefaultEncoding((String) enumeration
                                    .nextElement());
                    if (s1.length() == 0
                            || com.dragonflow.Page.CGI.isRelated(s2, s1)) {
                        array.add(s2);
                    }
                }
            } else if (s1.length() > 0) {
                array.add(I18N.toDefaultEncoding(s1));
            }
        } else {
            if (s1 == null || s1.length() == 0) {
                array.add(s);
            } else {
                array.add(I18N.toDefaultEncoding(s1));
            }
            SiteViewGroup siteviewgroup = SiteViewGroup
                    .currentSiteView();
            MonitorGroup monitorgroup = (MonitorGroup) siteviewgroup
                    .getElement(s);
            if (monitorgroup != null
                    && s.equals(monitorgroup.getProperty("_partnerFilter"))) {
                SiteViewGroup siteviewgroup1 = SiteViewGroup
                        .currentSiteView();
                jgl.Array array1 = siteviewgroup1.getGroupIDs();
                Enumeration enumeration1 = array1.elements();
                while (enumeration1.hasMoreElements()) {
                    String s3 = I18N
                            .toDefaultEncoding((String) enumeration1
                                    .nextElement());
                    MonitorGroup monitorgroup1 = (MonitorGroup) siteviewgroup1
                            .getElement(s3);
                    if (monitorgroup1 != null
                            && monitorgroup1.getProperty("_partner").equals(s)) {
                        array.add(s3);
                    }
                }
            }
        }
        return array;
    }

    public static boolean allowedByGroupFilter(String s,
            jgl.Array array) {
        for (Enumeration enumeration = array.elements(); enumeration
                .hasMoreElements();) {
            String s1 = (String) enumeration.nextElement();
            if (com.dragonflow.Page.CGI.isRelated(s, s1)) {
                return true;
            }
        }

        return false;
    }

    public static boolean isGroupAllowedForAccount(String s,
            HTTPRequest httprequest) {
        return com.dragonflow.Page.CGI.isGroupAllowedForAccount(s,
                com.dragonflow.Page.CGI.getGroupFilterForAccount(httprequest));
    }

    public static boolean isGroupAllowedForAccount(String s,
            jgl.Array array) {
        if (array != null && array.size() != 0) {
            return com.dragonflow.Page.CGI.allowedByGroupFilter(s, array);
        } else {
            return true;
        }
    }

    public static jgl.Array filterGroupsForAccount(jgl.Array array,HTTPRequest httprequest) {
        jgl.Array array1 = CGI.getGroupFilterForAccount(httprequest);
        if (array1 != null && array1.size() != 0) {
            Enumeration enumeration = array.elements();
            array = new Array();
            while (enumeration.hasMoreElements()) {
                String s = (String) enumeration.nextElement();
                if (CGI.allowedByGroupFilter(s, array1)) {
                    array.add(s);
                }
            }
        }
        return array;
    }

    public static String getGroupFullLinks(
            Monitor monitor) {
        return com.dragonflow.Page.CGI.getGroupFullLinks(monitor, null);
    }

    public static String getGroupFullLinks(
            Monitor monitor,
            HTTPRequest httprequest) {
        String s = I18N.toDefaultEncoding(monitor
                .getProperty(Monitor.pID));
        return com.dragonflow.Page.CGI.getGroupPath(monitor, s, true,
                httprequest);
    }

    public static String getGroupFullName(String s) {
        I18N.test(s, 0);
        SiteViewObject siteviewobject = Portal
                .getSiteViewForID(s);
        Monitor monitor = (Monitor) siteviewobject
                .getElementByID(com.dragonflow.Page.CGI.getGroupIDRelative(s));
        return com.dragonflow.Page.CGI.getGroupPath(monitor, s, false);
    }

    public static String getGroupPath(
            Monitor monitor, String s,
            boolean flag) {
        return com.dragonflow.Page.CGI.getGroupPath(monitor, s, flag, null);
    }

    public static String getGroupPath(
            Monitor monitor, String s,
            boolean flag, HTTPRequest httprequest) {
        I18N.test(s, 0);
        SiteViewObject siteviewobject = Portal
                .getSiteViewForID(s);
        String s1 = httprequest == null
                || httprequest.getValue("_health").length() <= 0 ? ""
                : "?_health=true";
        String s2 = "";
        while (true) {
            if (s2.length() != 0) {
                s2 = ": " + s2;
            }
            String s3 = com.dragonflow.Page.CGI.getGroupName(monitor,
                    s);
            s = com.dragonflow.HTTP.HTTPRequest.encodeString(s);
            if (flag && s2.length() != 0) {
                s2 = "<A HREF=Detail" + s + ".html" + s1 + ">" + s3 + "</a>"
                        + s2;
            } else {
                s2 = s3 + s2;
            }
            if (monitor == null) {
                break;
            }
            s = I18N.toDefaultEncoding(monitor
                    .getProperty("_parent"));
            if (s == null || s.length() == 0) {
                break;
            }
            monitor = (Monitor) siteviewobject
                    .getElement(s);
        }
        return s2;
    }

    public static String getGroupName(
            Monitor monitor, String s) {
        I18N.test(s, 0);
        String s1;
        if (monitor == null) {
            s1 = I18N.toNullEncoding(s);
            s1 = "MISSING GROUP (" + s1 + ")";
        } else {
            s1 = com.dragonflow.Page.CGI.getGroupName(s);
        }
        return s1;
    }

    public static String getGroupName(String s) {
        I18N.test(s, 0);
        jgl.HashMap hashmap = null;
        try {
            jgl.Array array = com.dragonflow.Page.CGI.ReadGroupFrames(s, null);
            Enumeration enumeration = array.elements();
            if (enumeration.hasMoreElements()) {
                hashmap = (jgl.HashMap) enumeration.nextElement();
            } else {
                hashmap = new HashMap();
            }
        } catch (java.io.IOException ioexception) {
            System.out.println("***id: " + s + ", error: "
                    + ioexception);
        }
        return com.dragonflow.Page.CGI.getGroupName(hashmap, s);
    }

    public static String getGroupName(jgl.Array array,
            String s) {
        I18N.test(s, 0);
        if (array.size() > 0) {
            jgl.HashMap hashmap = (jgl.HashMap) array.at(0);
            return com.dragonflow.Page.CGI.getGroupName(hashmap, s);
        } else {
            System.out.println("GROUP : " + s + " IS EMPTY.");
            return "";
        }
    }

    public static String getGroupName(jgl.HashMap hashmap,
            String s) {
        String s1 = null;
        I18N.test(s, 0);
        if (Portal.isPortalID(s)) {
            MonitorGroup monitorgroup = (MonitorGroup) Portal
                    .getPortal().getElement(s);
            if (monitorgroup != null) {
                PortalSiteView portalsiteview = (PortalSiteView) monitorgroup
                        .getOwner();
                if (portalsiteview != null) {
                    s1 = monitorgroup
                            .getProperty(MonitorGroup.pName)
                            + " on "
                            + portalsiteview
                                    .getProperty(PortalSiteView.pTitle);
                }
            }
            if (s1 == null) {
                s1 = "UNKNOWN NAME: " + s;
            }
        } else {
            if (hashmap != null) {
                s1 = (String) hashmap.get("_name");
            }
            if (s1 == null || s1.equals("config") || s1.length() == 0) {
                s1 = I18N.toNullEncoding(s);
            }
        }
        return s1;
    }

    public static String getGroupIDFull(String s,
            String s1) {
        if (s1.length() > 0 && Portal.isPortalID(s1)) {
            s = Portal.makePortalID(
                    Portal.getServerID(s1), s, "");
        }
        return s;
    }

    public static String getGroupIDFull(String s,
            SiteViewObject siteviewobject) {
        if (siteviewobject instanceof PortalSiteView) {
            s = Portal.makePortalID(siteviewobject
                    .getProperty(PortalSiteView.pID),
                    s, "");
        }
        return s;
    }

    public String getGroupIDFull(String s) {
        return com.dragonflow.Page.CGI.getGroupIDFull(s, request
                .getPortalServer());
    }

    public static String getGroupIDRelative(String s) {
        if (Portal.isPortalID(s)) {
            s = Portal.getGroupID(s);
        }
        return s;
    }

    public SiteViewObject getSiteView() {
        return Portal.getSiteViewForID(request
                .getPortalServer());
    }

    public String computeGroupName(String s) {
        return com.dragonflow.Page.CGI.computeGroupName(s, request);
    }

    public static String computeGroupName(String s,
            HTTPRequest httprequest) {
        String s1 = s;
        s = com.dragonflow.Page.CGI.getGroupIDRelative(s);
        s = s.replace(' ', '_');
        SiteViewGroup siteviewgroup = SiteViewGroup
                .currentSiteView();
        jgl.Array array = siteviewgroup.getGroupFileIDs();
        String s2 = s.toUpperCase() + ".";
        int i = -1;
        Enumeration enumeration = array.elements();
        while (enumeration.hasMoreElements()) {
            String s3 = (String) enumeration.nextElement();
            s3 = s3.toUpperCase() + '.';
            if (s3.startsWith(s2)) {
                int j = TextUtils.readInteger(s3, s2
                        .length());
                if (j < 0) {
                    j = 0;
                }
                if (j > i) {
                    i = j;
                }
            }
        }

        if (i++ >= 0) {
            s = s + "." + i;
        }
        return com.dragonflow.Page.CGI.getGroupIDFull(s, s1);
    }

    public static String getGroupFilePath(String s,
            HTTPRequest httprequest) {
        return com.dragonflow.Page.CGI.getGroupFilePath(s, httprequest, ".mg");
    }

    public static String getGroupFilePath(String s,
            HTTPRequest httprequest, String s1) {
        String s2 = "";
        if (httprequest != null) {
            s2 = Portal.cleanPortalServerID(httprequest
                    .getPortalServer());
        }
        if (Portal.isPortalID(s)) {
            String as[] = Portal
                    .getIDComponents(s);
            s2 = as[0];
            s = as[1];
        }
        String masterConfig;
        if (s.equals("_master")) {
            masterConfig = "/groups/master.config";
        } else if (s.equals("_users")) {
            masterConfig = "/groups/users.config";
        } else {
            masterConfig = "/groups/" + s + s1;
        }
        String s4 = "";
        if (s2.length() > 0) {
            s4 = Portal.getPortalSiteViewRootPath(s2)
                    + masterConfig;
        } else {
            s4 = Platform.getRoot() + masterConfig;
        }
        return s4;
    }

    public jgl.Array ReadGroupFrames(String s)
            throws java.io.IOException {
        return com.dragonflow.Page.CGI.ReadGroupFrames(s, request);
    }

    public static jgl.Array ReadGroupFrames(String s,
            HTTPRequest httprequest)
            throws java.io.IOException {
        if (httprequest != null
                && !com.dragonflow.Page.CGI.isGroupAllowedForAccount(s,
                        httprequest)) {
            throw new IOException("login " + httprequest.getUser()
                    + " cannot access " + s);
        }
        String s1 = com.dragonflow.Page.CGI.getGroupFilePath(s,
                httprequest);
        jgl.Array array = com.dragonflow.Properties.FrameFile.readFromFile(s1);
        if (array.size() == 0) {
            array.add(new HashMap());
        }
        return array;
    }

    public void WriteGroupFrames(String s, jgl.Array array)
            throws java.io.IOException {
        com.dragonflow.Page.CGI.WriteGroupFrames(s, array, request);
    }

    public static void WriteGroupFrames(String s, jgl.Array array,
            HTTPRequest httprequest)
            throws java.io.IOException {
        String s1 = com.dragonflow.Page.CGI.getGroupFilePath(s,
                httprequest);
        for (int i = 0; i < array.size(); i++) {
            jgl.HashMap hashmap = (jgl.HashMap) array.at(i);
            if (TextUtils.getValue(hashmap, "_encoding")
                    .length() == 0) {
                hashmap.put("_encoding", I18N
                        .nullEncoding());
            }
        }

        com.dragonflow.Properties.FrameFile.writeToFile(s1, array, "_", true);
    }

    public static Enumeration getMonitors(jgl.Array array) {
        jgl.Array array1 = new Array();
        Enumeration enumeration = array.elements();
        if (enumeration.hasMoreElements()) {
            array1.add(enumeration.nextElement());
        }
        while (enumeration.hasMoreElements()) {
            jgl.HashMap hashmap = (jgl.HashMap) enumeration.nextElement();
            if (Monitor.isMonitorFrame(hashmap)) {
                array1.add(hashmap);
            }
        }

        return array1.elements();
    }

    public static int findMonitorIndex(jgl.Array array, String s)
            throws java.lang.Exception {
        if (s.equals("_config")) {
            return 0;
        }
        Enumeration enumeration = array.elements();
        int i = 0;
        enumeration.nextElement();
        i++;
        int j = -1;
        while (enumeration.hasMoreElements()) {
            jgl.HashMap hashmap = (jgl.HashMap) enumeration.nextElement();
            if (Monitor.isMonitorFrame(hashmap)
                    && hashmap.get("_id").equals(s)) {
                j = i;
                break;
            }
            i++;
        }

        if (j == -1) {
            throw new Exception("monitor id (" + s + ") could not be found");
        } else {
            return j;
        }
    }

    public static int findSubGroupIndex(jgl.Array array, String s)
            throws java.lang.Exception {
        Enumeration enumeration = array.elements();
        int i = 0;
        s = com.dragonflow.Page.CGI.getGroupIDRelative(s);
        enumeration.nextElement();
        i++;
        int j = -1;
        for (; enumeration.hasMoreElements(); i++) {
            jgl.HashMap hashmap = (jgl.HashMap) enumeration.nextElement();
            if (!Monitor.isMonitorFrame(hashmap)) {
                continue;
            }
            String s1 = TextUtils.getValue(
                    hashmap, "_group");
            if (s1.length() == 0 || !s1.equals(s)) {
                continue;
            }
            j = i;
            break;
        }

        if (j == -1) {
            throw new Exception("subgroup id (" + s + ") could not be found");
        } else {
            return j;
        }
    }

    public static String getValue(jgl.HashMap hashmap,
            String s) {
        String s1 = (String) hashmap.get(s);
        if (s1 == null) {
            return "";
        } else {
            return s1;
        }
    }

    public static Enumeration getValues(jgl.HashMap hashmap,
            String s) {
        return hashmap.values(s);
    }

    public jgl.HashMap getMasterConfig() {
        if (privateConfigCache == null) {
            privateConfigCache = loadMasterConfig();
        }
        return privateConfigCache;
    }

    public jgl.HashMap getLocalMasterConfig() {
        if (privateLocalConfigCache == null) {
            privateLocalConfigCache = com.dragonflow.Page.CGI
                    .loadMasterConfig(null);
        }
        return privateLocalConfigCache;
    }

    public jgl.HashMap loadMasterConfig() {
        return com.dragonflow.Page.CGI.loadMasterConfig(request);
    }

    public static jgl.HashMap loadMasterConfig(
            HTTPRequest httprequest) {
        java.lang.Object obj = new HashMapOrdered(true);
        try {
            String masterConfigPath = com.dragonflow.Page.CGI.getGroupFilePath(
                    "_master", httprequest);
            jgl.Array array = com.dragonflow.Properties.FrameFile.readFromFile(masterConfigPath);
            obj = (jgl.HashMap) array.front();
        } catch (java.lang.Exception exception) {
        }
        return ((jgl.HashMap) (obj));
    }
    //lihua.zhong 2017.03.23
    public static jgl.HashMap loadMasterConfigFor() {
        java.lang.Object obj = new HashMapOrdered(true);
        try {
            String masterConfigPath =Platform.getRoot() +"/groups/master.config";
            jgl.Array array = com.dragonflow.Properties.FrameFile.readFromFile(masterConfigPath);
            obj = (jgl.HashMap) array.front();
        } catch (java.lang.Exception exception) {
        }
        return ((jgl.HashMap) (obj));
    }

    public void saveMasterConfig(jgl.HashMap hashmap)
            throws java.io.IOException {
        com.dragonflow.Page.CGI.saveMasterConfig(hashmap, request);
    }

    public static void saveMasterConfig(jgl.HashMap hashmap,
            HTTPRequest httprequest)
            throws java.io.IOException {
        jgl.Array array = new Array();
        array.add(hashmap);
        String s = com.dragonflow.Page.CGI.getGroupFilePath("_master",
                httprequest);
        com.dragonflow.Properties.FrameFile.writeToFile(s, array, true);
        SiteViewGroup.updateStaticPages(httprequest);
    }
    //lihua.zhong add 2017.03.23
    public static void saveMasterConfigFor(jgl.Array array,String str) throws IOException{
    	 jgl.HashMap jmap = loadMasterConfigFor();
    	 jmap.remove(str);
         for (int i = 0; i < array.size(); i++) {
              jgl.HashMap hashmap1 = (jgl.HashMap) array.at(i);
              jmap.add(str, TextUtils.hashMapToString(hashmap1));
          }
    	jgl.Array array1 = new Array();
        array1.add(jmap);
        String s =Platform.getRoot() +"/groups/master.config";
        com.dragonflow.Properties.FrameFile.writeToFile(s, array1, true);
    }
    //lihua.zhong add 2017.03.23
    public static void addMachine(String str,jgl.HashMap h) throws IOException{
    	 jgl.HashMap jmap = loadMasterConfigFor();
    	 jmap.remove(str);
    	 h.put("_id", TextUtils.getValue(jmap,
                 "_nextRemoteID"));

    	 jgl.HashMap hashmaps = Machine.getMachineTable();
		 jgl.Array array = new Array();
		  for (Enumeration enumeration = hashmaps.elements(); enumeration
	                .hasMoreElements();) {
	            Machine machine = (Machine) enumeration.nextElement();
	            jmap.add(str, TextUtils.hashMapToString(machine.getValuesTable()));
	      }

         jmap.add(str,TextUtils.hashMapToString(h));
    	jgl.Array array1 = new Array();
        array1.add(jmap);
        String s =Platform.getRoot() +"/groups/master.config";
        com.dragonflow.Properties.FrameFile.writeToFile(s, array1, true);
    }

    public static jgl.HashMap findMonitor(jgl.Array array, String s)
            throws java.lang.Exception {
        int i = com.dragonflow.Page.CGI.findMonitorIndex(array, s);
        return (jgl.HashMap) array.at(i);
    }

    public jgl.HashMap getSettings() {
        java.lang.Object obj = new HashMapOrdered(true);
        if (request.isStandardAccount()) {
            obj = getMasterConfig();
        } else {
            try {
                settingsArray = ReadGroupFrames(request.getAccount());
                obj = (jgl.HashMap) settingsArray.at(0);
            } catch (java.lang.Exception exception) {
            }
        }
        return ((jgl.HashMap) (obj));
    }

    void saveSettings(jgl.HashMap hashmap) throws java.io.IOException {
        if (request.isStandardAccount()) {
            saveMasterConfig(hashmap);
        } else {
            settingsArray.put(0, hashmap);
            WriteGroupFrames(request.getAccount(), settingsArray);
            SiteViewGroup.updateStaticPages(request
                    .getAccount());
        }
    }

    String getMonitorOptionsHTML(String s,
            String s1, int i) throws java.lang.Exception {
        jgl.Array array = new Array();
        array.add(s);
        jgl.Array array1 = new Array();
        array1.add(s1);
        return getMonitorOptionsHTML(array, array1, null, i);
    }

    String getMonitorOptionsHTML(jgl.Array array, jgl.Array array1,
            jgl.Array array2, int i) throws java.lang.Exception {
        StringBuffer stringbuffer = new StringBuffer();
        StringBuffer stringbuffer1 = new StringBuffer();
        StringBuffer stringbuffer2 = new StringBuffer();
        StringBuffer stringbuffer3 = new StringBuffer();
        StringBuffer stringbuffer4 = new StringBuffer();
        if ((i & 4) != 0) {
            stringbuffer2.append("<option value=\"\">none");
        }
        if ((i & 0x10) != 0) {
            stringbuffer2.append("<option value=\"\">-- SiteView Panel --");
        }
        jgl.HashMap hashmap = new HashMap();
        if (array != null) {
            for (int j = 0; j < array.size(); j++) {
                hashmap.put(array.at(j), "true");
            }

        }
        jgl.HashMap hashmap1 = new HashMap();
        if (array1 != null) {
            for (int k = 0; k < array1.size(); k++) {
                hashmap1.put(array1.at(k), "true");
            }

        }
        jgl.HashMap hashmap2 = null;
        if (array2 != null) {
            hashmap2 = new HashMap();
            for (int l = 0; l < array2.size(); l++) {
                hashmap2.put(array2.at(l), "true");
            }

        }
        if ((i & 0x40) != 0) {
            String s = "";
            if (hashmap.get("_master") != null) {
                s = "selected";
            }
            StringBuffer stringbuffer5 = stringbuffer2;
            if (s.length() > 0 && (i & 0x80) != 0) {
                stringbuffer5 = stringbuffer3;
            }
            stringbuffer5.append("\n<option " + s
                    + " value=\"_master\">All Groups");
        }
        com.dragonflow.Properties.HashMapOrdered hashmapordered = new HashMapOrdered(
                true);
        jgl.Array array3 = getGroupNameList(hashmapordered, hashmap1, hashmap2,
                false);
        for (Enumeration enumeration = array3.elements(); enumeration
                .hasMoreElements();) {
            String s1 = (String) enumeration.nextElement();
            Enumeration enumeration1 = hashmapordered.values(s1);
            while (enumeration1.hasMoreElements()) {
                MonitorGroup monitorgroup = (MonitorGroup) enumeration1
                        .nextElement();
                String s2 = monitorgroup
                        .getProperty(Monitor.pID);
                Enumeration enumeration2 = monitorgroup.getMonitors();
                if ((i & 2) != 0) {
                    String s3 = "";
                    if (hashmap.get(s2) != null) {
                        s3 = "selected";
                    }
                    StringBuffer stringbuffer6 = stringbuffer1;
                    if (s3.length() > 0 && (i & 0x80) != 0) {
                        stringbuffer6 = stringbuffer3;
                    }
                    stringbuffer6.append("\n<option ");
                    stringbuffer6.append(s3);
                    stringbuffer6.append(" value=\"");
                    stringbuffer6.append(s2);
                    stringbuffer6.append("\">");
                    if (monitorgroup.getTreeSetting("_truncateGroupName")
                            .length() > 0) {
                        String s5 = monitorgroup
                                .getTreeSetting("_truncateGroupName");
                        int i1 = (new Integer(s5)).intValue();
                        String s8 = s1.length() <= i1 ? s1 : s1
                                .substring(i1);
                        stringbuffer6.append(s8);
                    } else {
                        stringbuffer6.append(s1);
                    }
                }
                while (enumeration2.hasMoreElements()) {
                    Monitor monitor = (Monitor) enumeration2
                            .nextElement();
                    if (!(monitor instanceof SubGroup)
                            && (i & 1) != 0) {
                        String s4 = "";
                        String s6 = monitor
                                .getProperty(Monitor.pID);
                        String s7;
                        if ((i & 0x20) != 0) {
                            s7 = s6 + " " + s2;
                        } else {
                            s7 = s2 + " " + s6;
                        }
                        if (hashmap.get(s7) != null) {
                            s4 = "selected";
                        }
                        StringBuffer stringbuffer7 = stringbuffer;
                        if (s4.length() > 0 && (i & 0x80) != 0) {
                            stringbuffer7 = stringbuffer4;
                        }
                        stringbuffer7.append("\n<option ");
                        stringbuffer7.append(s4);
                        stringbuffer7.append(" value=\"");
                        stringbuffer7.append(s7);
                        stringbuffer7.append("\">");
                        if ((i & 8) == 0) {
                            if (monitor.getTreeSetting("_truncateGroupName")
                                    .length() > 0) {
                                String s9 = monitor
                                        .getTreeSetting("_truncateGroupName");
                                int j1 = (new Integer(s9)).intValue();
                                String s12 = s1.length() <= j1 ? s1
                                        : s1.substring(j1);
                                stringbuffer7.append(s12);
                            } else {
                                stringbuffer7.append(s1);
                            }
                            stringbuffer7.append(": ");
                        }
                        String s10 = monitor
                                .getProperty(Monitor.pName);
                        if (monitor.getTreeSetting("_truncateMonitorName")
                                .length() > 0) {
                            String s11 = monitor
                                    .getTreeSetting("_truncateMonitorName");
                            int k1 = (new Integer(s11)).intValue();
                            String s13 = s10.length() <= k1 ? s10
                                    : s10.substring(k1);
                            stringbuffer7.append(s13);
                        } else {
                            stringbuffer7.append(s10);
                        }
                    }
                }
            }
        }

        return stringbuffer3.toString() + stringbuffer4.toString()
                + stringbuffer2.toString() + stringbuffer1.toString()
                + stringbuffer.toString();
    }

    public String getSelectedOptionsHTML(jgl.Array array,
            String s, String s1, jgl.Array array1,
            jgl.Array array2, int i) throws java.lang.Exception {
        StringBuffer stringbuffer = new StringBuffer();
        return stringbuffer.toString();
    }

    public jgl.Array getGroupNameList(jgl.HashMap hashmap,
            jgl.HashMap hashmap1, jgl.HashMap hashmap2, boolean flag) {
        SiteViewGroup siteviewgroup = SiteViewGroup
                .currentSiteView();
        jgl.Array array = null;
        array = getAllowedGroupIDs();
        Enumeration enumeration = array.elements();
        jgl.Array array1 = new Array();
        String s = "";
        String s1 = null;
        while (enumeration.hasMoreElements()) {
            String s2 = (String) enumeration.nextElement();
            if ((hashmap1 == null || hashmap1.get(s2) == null)
                    && (hashmap2 == null || hashmap2.get(s2) != null)) {
                MonitorGroup monitorgroup = (MonitorGroup) siteviewgroup
                        .getElement(s2);
                if (monitorgroup != null
                        && (!flag || monitorgroup.getProperty(
                                MonitorGroup.pParent)
                                .length() <= 0)) {
                    String s3 = com.dragonflow.Page.CGI.getGroupPath(
                            monitorgroup, com.dragonflow.Page.CGI
                                    .getGroupIDFull(s2, siteviewgroup), false);
                    hashmap.add(s3 + " (" + s2 + ")", monitorgroup);
                    if (!s2.equals(s)) {
                        if (s2.equals("__Health__")) {
                            s1 = s3 + " (" + s2 + ")";
                        } else {
                            array1.add(s3 + " (" + s2 + ")");
                        }
                    }
                    s = s2;
                }
            }
        }

        jgl.Sorting.sort(array1, new LessString());
        if (s1 != null) {
            array1.insert(0, s1);
        }
        return array1;
    }

    void printProgressMessage(String s) {
        if (s.length() > 0) {
            outputStream.println(s);
            outputStream.flush();
            com.dragonflow.Log.LogManager.log("RunMonitor", "progress: " + s);
        }
    }

    public static String getStartTimeHTML(long l) {
        java.util.Date date = Platform.makeDate();
        l *= 1000L;
        return com.dragonflow.Page.CGI
                .getTimeHTML(
                        new Date(
                                (date.getTime() - (long) (TextUtils.HOUR_SECONDS * 1000))
                                        + l), "start");
    }

    public static String getEndTimeHTML(long l) {
        java.util.Date date = Platform.makeDate();
        l *= 1000L;
        return com.dragonflow.Page.CGI.getTimeHTML(new Date(date.getTime() + l),
                "end");
    }

    public static String getTimeHTML(java.util.Date date,
            String s) {
        StringBuffer stringbuffer = new StringBuffer();
        stringbuffer.append("<input type=text size=5 maxlength=5 name=");
        stringbuffer.append(s);
        stringbuffer.append("TimeTime value=\"");
        stringbuffer.append(TextUtils
                .dateToMilitaryTime(date));
        stringbuffer.append("\"> ");
        stringbuffer.append("<input type=text size=10 maxlength=11 name=");
        stringbuffer.append(s);
        stringbuffer.append("TimeDate value=\"");
        stringbuffer.append(TextUtils.prettyDateDate(date));
        stringbuffer.append("\"> ");
        return stringbuffer.toString();
    }

    public static String getOptionsHTML(jgl.Array array,
            String s) {
        java.util.Vector vector = new Vector();
        for (int i = 0; i < array.size(); i++) {
            vector.addElement(array.at(i));
        }

        return com.dragonflow.Page.CGI.getOptionsHTML(vector, s);
    }

    public static String getOptionsHTML(java.util.Vector vector,
            String s) {
        jgl.HashMap hashmap = new HashMap();
        if (s.length() > 0) {
            hashmap.put(s, "true");
        }
        return com.dragonflow.Page.CGI.getOptionsHTML(vector, hashmap);
    }

    public static String getOptionsHTML(java.util.Vector vector,
            jgl.HashMap hashmap) {
        String s = "";
        for (int i = 0; i < vector.size(); i += 2) {
            String s1 = "";
            String s3 = (String) vector.elementAt(i);
            if (s3 != null
                    && (hashmap.get(s3) != null || i == 0
                            && hashmap.size() == 0)) {
                hashmap.remove(s3);
                s1 = "SELECTED ";
            }
            s = s + "<OPTION " + s1 + "value=\"" + s3 + "\">"
                    + vector.elementAt(i + 1) + "</OPTION>\n";
        }

        if (hashmap.size() > 0) {
            for (Enumeration enumeration = hashmap.keys(); enumeration
                    .hasMoreElements();) {
                String s2 = (String) enumeration
                        .nextElement();
                s = s + "<OPTION SELECTED value=\"" + s2 + "\">" + s2
                        + "</OPTION>\n";
            }

        }
        return s;
    }

    public static jgl.Array expandSubgroupIDs(String s) {
        I18N.test(s, 0);
        return com.dragonflow.Page.CGI.expandSubgroupIDs(s, null);
    }

    public static jgl.Array expandSubgroupIDs(String s,
            com.dragonflow.Page.CGI cgi) {
        I18N.test(s, 0);
        jgl.Array array = new Array();
        com.dragonflow.Page.CGI.expandSubgroupIDs(s, array, cgi);
        return array;
    }

    public static void expandSubgroupIDs(String s, jgl.Array array,
            com.dragonflow.Page.CGI cgi) {
        I18N.test(s, 0);
        java.lang.Object obj = SiteViewGroup
                .currentSiteView();
        if (cgi != null) {
            obj = cgi.getSiteView();
        }
        array.add(s);
        MonitorGroup monitorgroup = (MonitorGroup) ((SiteViewObject) (obj))
                .getElement(s);
        if (monitorgroup != null) {
            Enumeration enumeration = monitorgroup.getMonitors();
            while (enumeration.hasMoreElements()) {
                Monitor monitor = (Monitor) enumeration
                        .nextElement();
                if (monitor instanceof SubGroup) {
                    com.dragonflow.Page.CGI
                            .expandSubgroupIDs(
                                    I18N
                                            .toDefaultEncoding(monitor
                                                    .getProperty(SubGroup.pGroup)),
                                    array, cgi);
                }
            }
        }
    }

    public String getPageLink(String s, String s1) {
        return getPageLink(s, s1, "");
    }

    public String getPageLink(String s,
            String s1, String s2) {
        String s3 = "/SiteView/cgi/go.exe/SiteView?page=" + s
                + "&account=" + request.getAccount();
        if (s.startsWith("portal")) {
            String s4 = request.getPortalServer();
            if (s4.length() > 0) {
                s3 = s3 + "&portalserver=" + s4;
            }
            String s6 = request.getValue("rview");
            if (s6.length() > 0) {
                s3 = s3 + "&rview=" + s6;
            }
            if (request.getValue("detail").length() > 0) {
                String s7 = request.getValue("detail");
                if (s7.indexOf('=') > 0) {
                    s7 = s7.substring(0, s7.indexOf('=')) + "%3D"
                            + s7.substring(s7.indexOf('=') + 1);
                }
                if (s7.indexOf('&') > 0) {
                    s7 = s7.substring(0, s7.indexOf('&')) + "%26"
                            + s7.substring(s7.indexOf('&') + 1);
                }
                s3 = s3 + "&detail=" + s7;
            }
        }
        String s5 = I18N
                .toDefaultEncoding(request.getValue("groupFilter"));
        if (s5.length() > 0) {
            s3 = s3 + "&groupFilter="
                    + com.dragonflow.HTTP.HTTPRequest.encodeString(s5);
        }
        if (s1.length() > 0) {
            s3 = s3 + "&operation="
                    + com.dragonflow.HTTP.HTTPRequest.encodeString(s1);
        }
        if (request.getValue("_health").length() > 0) {
            s3 = s3 + "&_health=true";
        }
        if (s2.length() > 0) {
            s3 = s3 + "&view="
                    + com.dragonflow.HTTP.HTTPRequest.encodeString(s2);
        }
        return s3;
    }

    public String getPagePOST(String s, String s1) {
        return getPagePOST(s, s1, "");
    }

    public String getPagePOST(String s,
            String s1, String s2) {
        return getPageForm(s, s1, "POST", s2);
    }

    public String getPageGET(String s, String s1) {
        return getPageGET(s, s1, "");
    }

    public String getPageGET(String s, String s1,
            String s2) {
        return getPageForm(s, s1, "GET", s2);
    }

    public String getPageForm(String s,
            String s1, String s2) {
        return getPageForm(s, s1, s2, "");
    }

    public String getPageForm(String s,
            String s1, String s2, String s3) {
        String s4 = "<FORM ACTION=/SiteView/cgi/go.exe/SiteView method="
                + s2
                + ">\n"
                + "<input type=hidden name=page value="
                + s
                + ">\n"
                + "<input type=hidden name=account value=\""
                + request.getAccount() + "\">\n";
        if (s3.length() > 0) {
            s4 = s4 + "<input type=hidden name=view value=" + s3 + ">\n";
        }
        if (request.getValue("AWRequest").equals("yes")) {
            s4 = s4 + "<input type=hidden name=AWRequest value=yes>\n";
        }
        if (!s.startsWith("portal")) {
            String s5 = request.getPortalServer();
            if (s5.length() > 0) {
                s4 = s4 + "<input type=hidden name=portalserver value=\"" + s5
                        + "\">\n";
            }
            String s7 = request.getValue("rview");
            if (s7.length() > 0) {
                s4 = s4 + "<input type=hidden name=rview value=\"" + s7
                        + "\">\n";
            }
            if (request.getValue("detail").length() > 0) {
                s4 = s4 + "<input type=hidden name=detail value=\""
                        + request.getValue("detail") + "\">\n";
            }
        }
        String s6 = request.getValue("groupFilter");
        if (s6.length() > 0) {
            s4 = s4 + "<input type=hidden name=groupFilter value=\"" + s6
                    + "\">\n";
        }
        if (s1.length() > 0) {
            s4 = s4 + "<input type=hidden name=operation value=\"" + s1
                    + "\">\n";
        }
        return s4;
    }

    boolean isPortalServerRequest() {
        if (request != null) {
            return com.dragonflow.Page.CGI.isPortalServerRequest(request);
        } else {
            return false;
        }
    }

    public static boolean isPortalServerRequest(
            HTTPRequest httprequest) {
        if (httprequest != null) {
            return httprequest.getPortalServer().length() > 0;
        } else {
            return false;
        }
    }
//update static
    jgl.Array readMachines(String s) throws java.io.IOException {
        jgl.Array array = new Array();
        jgl.HashMap hashmap = getMasterConfig();
        String s1;
        for (Enumeration enumeration = hashmap.values(s); enumeration
                .hasMoreElements(); array.add(TextUtils.stringToHashMap(s1))) {
            s1 = (String) enumeration.nextElement();
            if (s1.indexOf("_id") >= 0) {
                continue;
            }
            String s2 = "_nextRemoteID";
            if (s.equals("_remoteNTMachine")) {
                s2 = "_nextRemoteNTID";
            }
            String s3 = TextUtils.getValue(
                    hashmap, s2);
            if (s3.length() == 0) {
                s3 = "10";
            }
            s1 = s1 + " _id=" + s3;
            hashmap.put(s2, TextUtils.increment(s3));
            saveMasterConfig(hashmap);
        }

        return array;
    }

    void saveMachines(jgl.Array array, String s)
            throws java.io.IOException {
        jgl.HashMap hashmap = getMasterConfig();
        hashmap.remove(s);
        for (int i = 0; i < array.size(); i++) {
            jgl.HashMap hashmap1 = (jgl.HashMap) array.at(i);
            hashmap.add(s, TextUtils.hashMapToString(hashmap1));
        }

        saveMasterConfig(hashmap);
    }

    jgl.HashMap findMachine(jgl.Array array, String s) {
        Enumeration enumeration = array.elements();
        jgl.HashMap hashmap = new HashMap();
        while (enumeration.hasMoreElements()) {
            jgl.HashMap hashmap1 = (jgl.HashMap) enumeration.nextElement();
            if (s.equals(TextUtils.getValue(hashmap1,
                    "_id"))) {
            hashmap = hashmap1;
            break;
            }
        }

        return hashmap;
    }

    protected static String getListOptionHTML(String s,
            String s1, boolean flag) {
        StringBuffer stringbuffer = new StringBuffer();
        stringbuffer.append("<option ");
        if (flag) {
            stringbuffer.append("SELECTED ");
        }
        stringbuffer.append("value=");
        stringbuffer.append(s);
        stringbuffer.append(">");
        stringbuffer.append(s1);
        stringbuffer.append("</option>\n");
        return stringbuffer.toString();
    }

    protected static String getComboOptionHTML(String s,
            boolean flag) {
        StringBuffer stringbuffer = new StringBuffer();
        stringbuffer.append("<option ");
        if (flag) {
            stringbuffer.append("SELECTED");
        }
        stringbuffer.append(">");
        stringbuffer.append(s);
        stringbuffer.append("</option>\n");
        return stringbuffer.toString();
    }

    public int platformOS() {
        int i = Platform.getLocalPlatform();
        if (isPortalServerRequest()) {
            PortalSiteView portalsiteview = (PortalSiteView) Portal
                    .getSiteViewForServerID(Portal
                            .cleanPortalServerID(request.getPortalServer()));
            if (portalsiteview != null) {
                String s = portalsiteview
                        .getProperty(PortalSiteView.pPlatformOS);
                i = Machine.stringToOS(s);
            }
        }
        return i;
    }

    private static void printNavBarMessages(java.io.PrintWriter printwriter) {
        jgl.HashMap hashmap = MasterConfig
                .getMasterConfig();
        if (TextUtils.getValue(hashmap, "_suspendMonitors")
                .equals("CHECKED")) {
            printwriter
                    .println("<TABLE class=\"subnav\" width=\"600\" bgcolor=\"#CCCCCC\" bordercolor=\"#666666\" border=\"1\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\"><TR class=\"subnav\"><td><p class=\"navbar\" align=\"center\"> <font size=\"-1\" face=Arial, sans-serif><b>SiteView is in Suspended mode; no monitors are currently running.</b><br>To reactivate monitoring, clear the <b>Suspend Monitors</b> setting on the  <a href=/SiteView/docs/GenPref.htm#suspend target=\"Help\"> General Preferences</a> page.</font></p></TD></TR></TABLE>");
        }
        if (SiteViewGroup.currentSiteView()
                .hasCircularGroups()
                && SiteViewGroup.currentSiteView()
                        .checkForCircularGroups()) {
            printwriter
                    .println("<TABLE class=\"subnav\" width=\"600\" bgcolor=\"#CCCCCC\" bordercolor=\"#666666\" border=\"1\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\"><TR class=\"subnav\"><td><p class=\"navbar\" align=\"center\"> <font size=\"-1\" face=Arial, sans-serif><b>A circular group hierarchy has been detected.  Check the error log for details.</b><br>It is recommended that SiteView be shut down until the problem is fixed. </font></p></TD></TR></TABLE>");
        }
    }

}

package com.dragonflow.Page;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;

import com.alibaba.fastjson.JSONObject;
import com.dragonflow.HTTP.HTTPRequestException;
import com.dragonflow.Properties.FrameFile;
import com.dragonflow.Properties.HashMapOrdered;
import com.dragonflow.SiteView.Platform;
import com.dragonflow.SiteView.Tenant;
import com.dragonflow.SiteView.User;
import com.dragonflow.Utils.TextUtils;

import jgl.Array;
import jgl.HashMap;

public class tenantPrefsPage extends com.dragonflow.Page.prefsPage{
	  static final String GROUPS = "_group";

	    public tenantPrefsPage()
	    {
	    }

	    String getHelpPage()
	    {
	        return "TenantPref.htm";
	    }

	    void printOption(boolean flag, jgl.HashMap hashmap, String s, String s1, String s2)
	    {
	        String s3 = "";
	        if(flag || com.dragonflow.Page.userPrefsPage.getValue(hashmap, s1).length() > 0)
	        {
	            s3 = "CHECKED";
	        }
	        if(s2.length() < 1)
	        {
	            outputStream.println("<TR><TD align=\"left\" colspan=\"3\">" + s + "</TD></TR>");
	        } else
	        {
	            outputStream.println("<TR><TD ALIGN=RIGHT>" + s + "</TD>" + "<TD ALIGN=LEFT><input type=checkbox name=" + s1 + " value=true " + s3 + "></TD>" + "<TD><FONT SIZE=-1>" + s2 + "</FONT></TD>" + "<TD><I></I></TD></TR>");
	        }
	    }

	    String getGroupsHTML(jgl.HashMap hashmap)
	        throws java.lang.Exception
	    {
	        jgl.Array array = new Array();
	        for(Enumeration enumeration = hashmap.values("_group"); enumeration.hasMoreElements(); array.add(enumeration.nextElement())) { }
	        String s = "<option value=\"\">all groups";
	        if(array.size() == 0)
	        {
	            s = "<option selected value=\"\">all groups";
	        }
	        return "<select multiple name=_group size=4> " + s + getMonitorOptionsHTML(array, null, null, 2) + "</select>";
	    }

	    String getGroupsHTML(String s, String s1, String s2, jgl.HashMap hashmap)
	        throws java.lang.Exception
	    {
	        jgl.Array array = new Array();
	        Enumeration enumeration = hashmap.values("_group");
	        if(!enumeration.hasMoreElements() && !request.isPost())
	        {
	            array.add("_master");
	        } else
	        {
	            String s3;
	            for(; enumeration.hasMoreElements(); array.add(s3))
	            {
	                s3 = com.dragonflow.HTTP.HTTPRequest.decodeString((String)enumeration.nextElement());
	            }

	        }
	        StringBuffer stringbuffer = new StringBuffer();
	        int i = 130;
	        if(com.dragonflow.SiteView.Platform.isStandardAccount(request.getValue("account")))
	        {
	            i += 64;
	        } else
	        {
	            i += 8;
	        }
	        com.dragonflow.Page.treeControl treecontrol = new treeControl(request, "_group", false);
	        treecontrol.process(s, s1, s2, array, null, null, i, this, stringbuffer);
	        return stringbuffer.toString();
	    }

	    void printForm(String s, jgl.Array array, jgl.HashMap hashmap)
	        throws java.lang.Exception
	    {
	        String s1 = request.getValue("tenantid");
	        String s2 = s;
	        boolean flag = false;
	        jgl.HashMap hashmap1;
	        if(s.equals("Edit"))
	        {
	            s2 = "Update";
	            hashmap1 = Tenant.findTenant(array, s1);
	        } else
	        {
	            s2 = "Add";
	            hashmap1 = new HashMap();
	            flag = true;
	        }
	        String s3 = s2 + " Tenant";
	        printBodyHeader(s3);
	        printButtonBar(getHelpPage(), "", getSecondNavItems(request));
	        printPrefsBar("Tenants");
	        outputStream.println("<p><H2>" + s3 + "</H2>\n" + getPagePOST(request.getValue("page"), s) + "<input type=hidden name=tenantid value=" + s1 + ">\n");
	        outputStream.print("<TABLE>\n");
//	        printAccessFields(s1, hashmap, hashmap1);
	        outputStream.println("<TR><TD ALIGN=RIGHT>Company name</TD><TD><TABLE><TR><TD ALIGN=LEFT><input type=text name=_cName size=50 value=\"" + com.dragonflow.Page.userPrefsPage.getValue(hashmap1, "_cName") + "\"></TD></TR>" + "<TR><TD><FONT SIZE=-1>the Company name for this tenant, if empty, no Company name is required</FONT></TD></TR>" + "</TABLE></TD><TD><I>" + com.dragonflow.Page.userPrefsPage.getValue(hashmap, "cName") + "</I></TD></TR>" 
	        		+ "<TR><TD ALIGN=RIGHT>Company Number</TD>" + "<TD><TABLE><TR><TD ALIGN=LEFT>" + "<input type=text name=_cNumber value=\""+com.dragonflow.Page.userPrefsPage.getValue(hashmap1, "_cNumber") + "\""+" size=50></TD></TR>" +  "<TR><TD><FONT SIZE=-1>the Company Number for this tenant</FONT></TD></TR>" + "<TR><TD><FONT SIZE=-1></FONT></TD></TR>" + "</TABLE></TD><TD><I>" + com.dragonflow.Page.userPrefsPage.getValue(hashmap, "cNumber") + "</I></TD></TR>" 
	        		+ "<TR><TD ALIGN=RIGHT>Number Of Companies</TD>" + "<TD><TABLE><TR><TD ALIGN=LEFT>"+"<input type=text name=_cNumberC value=\""+com.dragonflow.Page.userPrefsPage.getValue(hashmap1, "_cNumberC") + "\""+" size=50></TD></TR>"+"<input type=hidden name=" + s2 + " value=\"" + TextUtils.obscure(s) + "\"> "+ "<TR><TD><FONT SIZE=-1>the Number Of Companies</FONT></TD></TR>" + "</TABLE></TD><TD><I>" + com.dragonflow.Page.userPrefsPage.getValue(hashmap, "cNumberC") + "</I></TD></TR>");
	        outputStream.println("<TR><TD ALIGN=RIGHT>Company Phone</TD><TD><TABLE><TR><TD ALIGN=LEFT><input type=text name=_cPhone size=50 value=\"" + com.dragonflow.Page.userPrefsPage.getValue(hashmap1, "_cPhone") + "\"></TD></TR>" +"<input type=hidden name=" + s2 + " value=\"" + TextUtils.obscure(s) + "\"> "+ "<TR><TD><FONT SIZE=-1>the  Phone for this Company </FONT></TD></TR>" + "</TABLE></TD><TD><I>" + com.dragonflow.Page.userPrefsPage.getValue(hashmap, "cPhone") + "</I></TD></TR>");
	        outputStream.println("<TR><TD ALIGN=RIGHT>Company Email</TD><TD><TABLE><TR><TD ALIGN=LEFT><input type=text name=_cEmail size=50 value=\"" + com.dragonflow.Page.userPrefsPage.getValue(hashmap1, "_cEmail") + "\"></TD></TR>" + "<TR><TD><FONT SIZE=-1>the  Eamil for this Company\n</FONT></TD></TR>" + "<TR><TD><FONT SIZE=-1>the type \" uid=testuser,ou=TEST,o=this-company.com\".</FONT></TD></TR>" + "</TABLE></TD><TD><I>" + com.dragonflow.Page.userPrefsPage.getValue(hashmap, "cEmail") + "</I></TD></TR>");
	        String s4 = "";
	        if(flag)
	        {
	            s4 = "";
	        } else
	        if(com.dragonflow.Page.userPrefsPage.getValue(hashmap1, "_disabled").length() > 0)
	        {
	            s4 = "CHECKED";
	        }
	        if(s1.equals("administrator"))
	        {
	            outputStream.println("<input type=hidden name=_disabled value=\"\">");
	        } else
	        {
	            outputStream.println("<TR><TD ALIGN=RIGHT>Disabled</TD><TD><TABLE><TR><TD ALIGN=LEFT><input type=checkbox name=_disabled value=true " + s4 + "></TD></TR>" + "<TR><TD><FONT SIZE=-1>Disable tenants </FONT></TD></TR>" + "</TABLE></TD><TD><I></I></TD></TR>");
	        }
	        if(s1.equals("tenant") || s1.equals("administrator"))
	        {
	            outputStream.println("<TR><TD ALIGN=RIGHT>Title</TD><TD><TABLE><TR><TD ALIGN=LEFT>" + getTenantTitle(hashmap1) + "</TD></TR>" + "<input type=hidden name=_realName size=50 value=\"" + getTenantTitle(hashmap1) + "\">" + "<TR><TD><FONT SIZE=-1> </FONT></TD></TR>" + "</TABLE></TD><TD><I></I></TD></TR>");
	        } else
	        {
	            outputStream.println("<TR><TD ALIGN=RIGHT>Title</TD><TD><TABLE><TR><TD ALIGN=LEFT><input type=text name=_realName size=50 value=\"" + getTenantTitle(hashmap1) + "\">" + "</TD></TR>" + "<TR><TD><FONT SIZE=-1>optional title for this tenant. the title will appear in the Name field of the tenant Preference table.   the default title is the company name</FONT></TD></TR>" + "</TABLE></TD><TD><I></I></TD></TR>");
	        }
	        outputStream.println("</TABLE>");
	        outputStream.println("<TABLE WIDTH=100%><TR><TD><input type=submit value=\"" + s2 + "\"> Tenant\n" + "</TD></TR></TABLE>");
//	        printPermissions(s1, flag, s2, hashmap, hashmap1);
	        outputStream.println("</FORM>");
	        printFooter(outputStream);
	    }

	    void printAccessFields(String s, jgl.HashMap hashmap, jgl.HashMap hashmap1)
	        throws java.lang.Exception
	    {
	        if(s.equals("administrator") || s.equals("tenant"))
	        {
	            outputStream.println("<TR><TD ALIGN=LEFT>Groups</TD><TD><TABLE><TR><TD ALIGN=LEFT>all groups</TD></TR><TR><TD><FONT SIZE=-1>access is allowed to all groups</FONT></TD></TR></TABLE></TD><TD><I>" + com.dragonflow.Page.userPrefsPage.getValue(hashmap, "_group") + "</I></TD></TR>");
	        } else
	        if(com.dragonflow.Page.treeControl.useTree())
	        {
	            outputStream.println(getGroupsHTML("Groups", com.dragonflow.Page.userPrefsPage.getValue(hashmap, "_group"), "optional, restrict access to the selected groups - the default allows access to all groups", hashmap1));
	        } else
	        {
	            outputStream.println("<TR><TD ALIGN=LEFT>Groups</TD><TD><TABLE><TR><TD ALIGN=LEFT>" + getGroupsHTML(hashmap1) + "</TD></TR>" + "<TR><TD><FONT SIZE=-1>optional, restrict access to the selected groups - the default allows access to all groups</FONT></TD></TR>" + "</TABLE></TD><TD><I>" + com.dragonflow.Page.userPrefsPage.getValue(hashmap, "_group") + "</I></TD></TR>");
	        }
	    }

	    void printPermissions(String s, boolean flag, String s1, jgl.HashMap hashmap, jgl.HashMap hashmap1)
	    {
	        if(s.equals("administrator"))
	        {
	            outputStream.println("<BLOCKQUOTE>");
	            outputStream.println("<br><br><h3>Permissions</h3>The " + com.dragonflow.SiteView.Platform.productName + " Administrator is a builtin account with permissions to view and make changes on any pages.");
	            outputStream.println("</BLOCKQUOTE>");
	        } else
	        {
	            outputStream.println("<BLOCKQUOTE>");
	            outputStream.println("<br><h3>Permissions</h3><TABLE>");
	            printPermissionsCheckBoxes(flag, hashmap1);
	            outputStream.println("</TABLE>");
	            outputStream.println("</BLOCKQUOTE>");
	            outputStream.println("<TABLE WIDTH=100%><TR><TD><input type=submit value=\"" + s1 + "\"> Tenant\n" + "</TD></TR></TABLE>");
	        }
	    }

	    void printPermissionsCheckBoxes(boolean flag, jgl.HashMap hashmap)
	    {
	        printOption(flag, hashmap, "<hr><p><b>Group Actions</b></p>", "", "");
	        printOption(flag, hashmap, "Edit Groups", "_groupEdit", "add, rename, copy, or delete groups");
	        printOption(flag, hashmap, "Refresh Groups", "_groupRefresh", "refresh groups");
	        printOption(flag, hashmap, "Disable Groups", "_groupDisable", "disable or enable groups");
	        printOption(flag, hashmap, "<hr><p><b>Monitor Actions</b></p>", "", "");
	        printOption(flag, hashmap, "Edit Monitors", "_monitorEdit", "add, edit, or delete monitors");
	        printOption(flag, hashmap, "Refresh Monitors", "_monitorRefresh", "refresh monitors");
	        printOption(flag, hashmap, "Acknowledge Monitors", "_monitorAcknowledge", "acknowledge monitors");
	        printOption(flag, hashmap, "Disable Monitors", "_monitorDisable", "disable or enable monitors");
	        printOption(flag, hashmap, "Use Monitor Tools", "_monitorTools", "use the Tools form for a monitor");
	        printOption(flag, hashmap, "Use Tools", "_tools", "use the generic Tools forms");
	        printOption(flag, hashmap, "<hr><p><b>Alert Actions</b></p>", "", "");
	        printOption(flag, hashmap, "View Alerts List", "_alertList", "view the list of the alerts in the alert page");
	        printOption(flag, hashmap, "Edit Alerts", "_alertEdit", "add, edit, or delete alerts");
	        printOption(flag, hashmap, "Test Alerts", "_alertTest", "test an alert");
	        printOption(flag, hashmap, "Disable Alerts Indefinitely", "_alertDisable", "disable or enable alerts indefinitely");
	        printOption(flag, hashmap, "Disable Alerts Temporarily", "_alertTempDisable", "disable or enable alerts temporarily");
	        printOption(flag, hashmap, "View Alert History Report", "_alertRecentReport", "view the recent history report for an alert");
	        printOption(flag, hashmap, "Create Adhoc Alert Reports", "_alertAdhocReport", "create adhoc alert reports");
	        printOption(flag, hashmap, "<hr><p><b>Report Actions</b></p>", "", "");
	        printOption(flag, hashmap, "Generate Reports", "_reportGenerate", "generate a scheduled report manually");
	        printOption(flag, hashmap, "Show Report Toolbar", "_reportToolbar", "include links at the top on reports");
	        printOption(flag, hashmap, "Edit Reports", "_reportEdit", "add, edit, or delete reports");
	        printOption(flag, hashmap, "Create Adhoc Reports", "_reportAdhoc", "create adhoc reports");
	        printOption(flag, hashmap, "Disable Reports", "_reportDisable", "disable or enable reports");
	        printOption(flag, hashmap, "View Monitor History Report", "_monitorRecent", "view the recent history report for a monitor");
	        printOption(flag, hashmap, "<hr><p><b>Preference Actions</b></p>", "", "");
	        printOption(flag, hashmap, "Edit Preferences", "_preference", "use any of the Preference forms");
	        printOption(flag, hashmap, "Test Preferences", "_preferenceTest", "test a preference setting");
	        printOption(flag, hashmap, "<hr><p><b>Other Options</b></p>", "", "");
	        printOption(flag, hashmap, "Edit Multi-View", "_multiEdit", "add, edit or delete items on the Multi-View page");
	        printOption(flag, hashmap, "Use Browse and Summary", "_browse", "use the Browse Monitor form and Monitor Description Report");
	        printOption(flag, hashmap, "View Progress", "_progress", "view the Progress page showing monitors that are running");
//	        printOption(flag, hashmap, "View " + com.dragonflow.SiteView.TopazInfo.getTopazName() + " Configuration Changes", "_topazConfigChangesReport", "View the configuration changes reported to " + com.dragonflow.SiteView.TopazInfo.getTopazName());
	        printOption(flag, hashmap, "View Logs", "_logs", "view the raw data for monitors, alerts and other logs");
	        printOption(flag, hashmap, "View Health Page", "_healthView", "View the SiteView Health (self-monitoring) page");
	        printOption(flag, hashmap, "Edit Health Parameters", "_healthEdit", "Edit SiteView Health parameters");
	        printOption(flag, hashmap, "Disable/Enable Application Health Monitors", "_healthDisable", "Enable/Disable SiteView Health monitoring");
	        printOption(flag, hashmap, "Use the Support Tool", "_support", "use the Send Support Request form");
	    }

	    void printAddForm(String s)
	        throws java.lang.Exception
	    {
	        if(!request.getAccount().equals("administrator"))
	        {
	            outputStream.println("<hr>Administrator access only<hr>");
	            return;
	        }
	        jgl.Array array = getTenantFrames();
	        if(request.isPost() && com.dragonflow.Page.treeControl.notHandled(request))
	        {
	            String s1 = request.getValue("tenantid");
	            jgl.HashMap hashmap = new HashMap();
	            String s2 = request.getValue("_cName");
	            for(int i = 1; i < array.size(); i++)
	            {
	                jgl.HashMap hashmap1 = (jgl.HashMap)array.at(i);
	                String s5 = TextUtils.getValue(hashmap1, "_id");
	                if(s5.equals(s1))
	                {
	                    continue;
	                }
	                String s7 = TextUtils.getValue(hashmap1, "_cName");
	                if(!s7.equalsIgnoreCase(s2) || request.getAccount().equals("administrator") && s7.length() <= 0)
	                {
	                    continue;
	                }
	                hashmap.put("tenant", "Company Name is already in use - please choose another Company Name");
	                break;
	            }

//	            String s3 = com.dragonflow.Properties.StringProperty.getPrivate(request, "_password", "userSuff", null, null);
//	            String s4 = com.dragonflow.Properties.StringProperty.getPrivate(request, "password2", "userSuff2", null, null);
//	            String s6 = User.checkPassword(getMasterConfig(), s3, s4);
//	            if(s6.length() > 0)
//	            {
//	                hashmap.put("password", s6);
//	            }
	            if(hashmap.size() > 0)
	            {
	                super.printCGIHeader();
	                printForm(s, array, hashmap);
	                return;
	            }
	            if(s1.equals("tenant") && request.getValue("disabled").length() == 0)
	            {
	                com.dragonflow.SiteView.Platform.enableUserAccess();
	            }
	            java.lang.Object obj = null;
	            if(s.equals("Add"))
	            {
	                jgl.HashMap hashmap2 = (jgl.HashMap)array.at(0);
	                s1 = (String)hashmap2.get("_nextID");
	                if(s1 == null)
	                {
	                    s1 = "1";
	                }
	                obj = new HashMapOrdered(true);
	                ((jgl.HashMap) (obj)).put("_id", "tenant" + s1);
	                array.add(obj);
	                hashmap2.put("_nextID", com.dragonflow.Utils.TextUtils.increment(s1));
	                File file = new File(Platform.getRoot()+"/groups/tenants/"+s2);
	                file.mkdirs();
	            } else
	            {
	                obj = Tenant.findTenant(array, s1);
	                File file= new File(Platform.getRoot()+"/groups/tenants/"+TextUtils.getValue((jgl.HashMap) obj, "_cName"));
	                File newfile= new File(Platform.getRoot()+"/groups/tenants/"+s2);
	                if(file.exists()&&file.isDirectory())
	                	file.renameTo(newfile);
	                else
	                	newfile.mkdirs();
	            }
	            ((jgl.HashMap) (obj)).put("_cName", request.getValue("_cName"));
	            ((jgl.HashMap) (obj)).put("_cNumber", request.getValue("_cNumber"));
	            ((jgl.HashMap) (obj)).put("_cNumberC", request.getValue("_cNumberC"));
	            ((jgl.HashMap) (obj)).put("_cDesc", request.getValue("_cDesc"));
	            ((jgl.HashMap) (obj)).put("_cPhone", request.getValue("_cPhone"));
	            ((jgl.HashMap) (obj)).put("_cEmail", request.getValue("_cEmail"));
	            ((jgl.HashMap) (obj)).put("_realName", request.getValue("_realName"));
	            ((jgl.HashMap) (obj)).put("_disabled", request.getValue("_disabled"));
//	            if(com.dragonflow.SiteView.Platform.isPortal())
//	            {
//	                ((jgl.HashMap) (obj)).put("_homeView", request.getValue("_homeView"));
//	                ((jgl.HashMap) (obj)).put("_buttonBar", request.getValue("_buttonBar"));
//	                ((jgl.HashMap) (obj)).put("_query", com.dragonflow.Page.portalChooserPage.getQueryChooseListSelectedItem(request));
//	            }
//	            ((jgl.HashMap) (obj)).put("_progress", request.getValue("_progress"));
//	            ((jgl.HashMap) (obj)).put("_topazConfigChangesReport", request.getValue("_topazConfigChangesReport"));
//	            ((jgl.HashMap) (obj)).put("_alertList", request.getValue("_alertList"));
//	            ((jgl.HashMap) (obj)).put("_browse", request.getValue("_browse"));
//	            ((jgl.HashMap) (obj)).put("_tools", request.getValue("_tools"));
//	            ((jgl.HashMap) (obj)).put("_support", request.getValue("_support"));
//	            ((jgl.HashMap) (obj)).put("_preference", request.getValue("_preference"));
//	            ((jgl.HashMap) (obj)).put("_preferenceTest", request.getValue("_preferenceTest"));
//	            ((jgl.HashMap) (obj)).put("_logs", request.getValue("_logs"));
//	            ((jgl.HashMap) (obj)).put("_multiEdit", request.getValue("_multiEdit"));
//	            ((jgl.HashMap) (obj)).put("_groupEdit", request.getValue("_groupEdit"));
//	            ((jgl.HashMap) (obj)).put("_groupDisable", request.getValue("_groupDisable"));
//	            ((jgl.HashMap) (obj)).put("_groupRefresh", request.getValue("_groupRefresh"));
//	            ((jgl.HashMap) (obj)).put("_monitorEdit", request.getValue("_monitorEdit"));
//	            ((jgl.HashMap) (obj)).put("_monitorDisable", request.getValue("_monitorDisable"));
//	            ((jgl.HashMap) (obj)).put("_monitorRefresh", request.getValue("_monitorRefresh"));
//	            ((jgl.HashMap) (obj)).put("_monitorAcknowledge", request.getValue("_monitorAcknowledge"));
//	            ((jgl.HashMap) (obj)).put("_monitorRecent", request.getValue("_monitorRecent"));
//	            ((jgl.HashMap) (obj)).put("_monitorTools", request.getValue("_monitorTools"));
//	            ((jgl.HashMap) (obj)).put("_alertEdit", request.getValue("_alertEdit"));
//	            ((jgl.HashMap) (obj)).put("_alertDisable", request.getValue("_alertDisable"));
//	            ((jgl.HashMap) (obj)).put("_alertTempDisable", request.getValue("_alertTempDisable"));
//	            ((jgl.HashMap) (obj)).put("_alertRecentReport", request.getValue("_alertRecentReport"));
//	            ((jgl.HashMap) (obj)).put("_alertAdhocReport", request.getValue("_alertAdhocReport"));
//	            ((jgl.HashMap) (obj)).put("_alertTest", request.getValue("_alertTest"));
//	            ((jgl.HashMap) (obj)).put("_reportEdit", request.getValue("_reportEdit"));
//	            ((jgl.HashMap) (obj)).put("_reportDisable", request.getValue("_reportDisable"));
//	            ((jgl.HashMap) (obj)).put("_reportAdhoc", request.getValue("_reportAdhoc"));
//	            ((jgl.HashMap) (obj)).put("_reportToolbar", request.getValue("_reportToolbar"));
//	            ((jgl.HashMap) (obj)).put("_reportGenerate", request.getValue("_reportGenerate"));
//	            ((jgl.HashMap) (obj)).put("_healthView", request.getValue("_healthView"));
//	            ((jgl.HashMap) (obj)).put("_healthEdit", request.getValue("_healthEdit"));
//	            ((jgl.HashMap) (obj)).put("_healthDisable", request.getValue("_healthDisable"));
//	            ((jgl.HashMap) (obj)).remove("_group");
//	            Enumeration enumeration = request.getValues("_group");
//	            boolean flag = false;
//	            if(!com.dragonflow.Page.treeControl.useTree())
//	            {
//	                for(; enumeration.hasMoreElements(); ((jgl.HashMap) (obj)).add("_group", (String)enumeration.nextElement())) { }
//	            } else
//	            {
//	                do
//	                {
//	                    if(!enumeration.hasMoreElements())
//	                    {
//	                        break;
//	                    }
//	                    String s8 = com.dragonflow.HTTP.HTTPRequest.decodeString((String)enumeration.nextElement());
//	                    if(!s8.equals("_master"))
//	                    {
//	                        continue;
//	                    }
//	                    flag = true;
//	                    break;
//	                } while(true);
//	                if(!flag)
//	                {
//	                    for(Enumeration enumeration1 = request.getValues("_group"); enumeration1.hasMoreElements(); ((jgl.HashMap) (obj)).add("_group", com.dragonflow.HTTP.HTTPRequest.decodeString((String)enumeration1.nextElement()))) { }
//	                }
//	            }
//	            ((jgl.HashMap) (obj)).put("_demo", request.getValue("_demo"));
//	            ((jgl.HashMap) (obj)).put("_license", request.getValue("_license"));
	            saveTenantFrames(array);
	            if(s.equals("Add"))
	            	createdTenantAdminUser( request.getValue("_cName"), "tenant" + s1);
	            super.printCGIHeader();
	            printRefreshPage(getPageLink(request.getValue("page"), ""), 0);
	        } else
	        {
	            printForm(s, array, new HashMap());
	        }
	    }

	    private void createdTenantAdminUser(String value,String id) {
			// TODO Auto-generated method stub
			File file = new File(Platform.getRoot()+"/groups/tenants/"+value+"/users.config");
			if(!file.exists()||!file.isFile()){
				try {
					file.createNewFile();
					Array array = new Array();
					HashMap hashmap = new HashMap();
					hashmap.put("_nextID", "2");
					hashmap.put("_fileEncoding", "UTF-8");
					array.add(hashmap);
					hashmap = new HashMap();
					hashmap.put("_id", value+"1");
					hashmap.put("_userEdit", "true");
					hashmap.put("_realName", value);
					hashmap.put("_password", value);
					hashmap.put("_login", value);
					hashmap.put("_tenant", id);
					hashmap.put("_monitorAcknowledge", "true");
					hashmap.put("_preference", "true");
					hashmap.put("_monitorDisable", "true");
					hashmap.put("_groupRefresh", "true");
					hashmap.put("_progress", "true");
					hashmap.put("_alertAdhocReport", "true");
					hashmap.put("_reportToolbar", "true");
					hashmap.put("_preferenceTest", "true");
					hashmap.put("_monitorEdit", "true");
					hashmap.put("_healthDisable", "true");
					hashmap.put("_groupEdit", "true");
					hashmap.put("_alertEdit", "true");
					hashmap.put("_reportDisable", "true");
					hashmap.put("_reportAdhoc", "true");
					hashmap.put("_userEdit", "true");
					hashmap.put("_monitorRefresh", "true");
					hashmap.put("_reportGenerate", "true");
					hashmap.put("_alertRecentReport", "true");
					hashmap.put("_multiEdit", "true");
					hashmap.put("_groupDisable", "true");
					hashmap.put("_monitorRecent", "true");
					hashmap.put("_alertTempDisable", "true");
					hashmap.put("_monitorTools", "true");
					hashmap.put("_browse", "true");
					hashmap.put("_alertList", "true");
					hashmap.put("_logs", "true");
					hashmap.put("_healthView", "true");
					hashmap.put("_support", "true");
					hashmap.put("_tools", "true");
					hashmap.put("_reportEdit", "true");
					hashmap.put("_alertTest", "true");
					hashmap.put("_healthEdit", "true");
					hashmap.put("_alertDisable", "true");
					array.add(hashmap);
					User.usersCacheMap.put(value, array);
					User.loadUsers(value);
					FrameFile.writeToFile(file.getPath(), array);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	    private void deleteTenant(String value){
	    	File file = new File (Platform.getRoot()+"/groups/tenants/"+value);
	    	User.unloadUsers(value);
	    	if(file.exists()&&file.isDirectory()){
	    		File[] files = file.listFiles();
	    		for(File f:files)
	    			f.delete();
	    		file.delete();
	    	}
	    }
		String getTenantTitle(jgl.HashMap hashmap)
	    {
	        String s = com.dragonflow.Page.userPrefsPage.getValue(hashmap, "_realName");
	        if(s.length() == 0)
	        {
	            s = com.dragonflow.Page.userPrefsPage.getValue(hashmap, "_cName");
	        }
	        return s;
	    }

	    void printListForm(String s)
	        throws java.io.IOException
	    {
	        String s1 = "Tenant Preferences";
	        printBodyHeader(s1);
	        printButtonBar(getHelpPage(), "", getSecondNavItems(request));
	        printPrefsBar("Tenants");
	        outputStream.println("<link rel='import' href='/SiteView/htdocs/js/components/data-table-ext/data-table-ext.html' async='true'>\n");
	        outputStream.println("<H2>Tenant Profiles</H2><p>Tenant profiles control viewing and editing permissions on this SiteView installation.</p>\n");
	        // if(request.actionAllowed("_users")){
	        //     outputStream.println("<TH WIDTH=10%>Edit</TH><TH WIDTH=3%>Del</TH>");
	        // }
	        // outputStream.println("</TR>");
	        jgl.Array array = getTenantFrames();
	        Enumeration enumeration = array.elements();
	        if(enumeration.hasMoreElements())
	        {
	            enumeration.nextElement();
	        }
	        ArrayList<java.util.HashMap> mapList = new ArrayList<java.util.HashMap>();
	        while(enumeration.hasMoreElements()){
	          java.util.HashMap<String, String> dataMap = new java.util.HashMap<String, String>();
	            jgl.HashMap hashmap = (jgl.HashMap)enumeration.nextElement();
	            String s2 = TextUtils.getValue(hashmap, "_id");
	            String cname = TextUtils.getValue(hashmap, "_cName");
	            String userTitle = getTenantTitle(hashmap);
	            if(TextUtils.getValue(hashmap, "_disabled").length() > 0){
	                userTitle = userTitle + " (disabled)";
	            }
	            String s4 =cname+"/SiteView";
	            if(cname.length()>0)
	            	s4="/"+s4;
	            if(request.actionAllowed("_tentans")){
	                String mainUrl = getPageLink(request.getValue("page"), "") + "&tenantid=" + s2;
	                String delOperation = "<A href=" + mainUrl + "&operation=Delete>X</a>";
	                if(s2.equals("tenant") || s2.equals("administrator")){
	                    delOperation = "&nbsp;";
	                }
	                dataMap.put("a_Name", userTitle);
	                // outputStream.println("<TR><TD align=left>" + userTitle + "</TD>");
	                if(TextUtils.getValue(hashmap, "_disabled").length() <= 0){
	                  dataMap.put("b_Login&nbsp;URL", "<a href=" + s4 + ">" + s4 + "</a>");
	                    // outputStream.println("<TD><A href=" + s4 + ">" + s4 + "</a></TD>");
	                } else{
	                  dataMap.put("b_Login&nbsp;URL", s4);
	                    // outputStream.println("<TD>" + s4 + " </TD>");
	                }
	                dataMap.put("c_Edit", "<A href=" + mainUrl + "&operation=Edit>Edit</a>");
	                dataMap.put("d_Del", delOperation);
	                // outputStream.println("<TD><A href=" + mainUrl + "&operation=Edit>Edit</a></TD>" + "<TD>" + delOperation + "</TD>" + "</TR>\n");
	            } else{
	              dataMap.put("a_Name", userTitle);
	              dataMap.put("b_Login&nbsp;URL", "<a href=" + s4 + ">" + s4 + "</a>");
	                // outputStream.println("<TR><TD align=left>" + userTitle + "</TD>" + "<TD><a href=" + s4 + ">" + s4 + "</a></TD>" + "</TR>\n");
	            }
	            mapList.add(dataMap);
	        }
	        String jsonString = JSONObject.toJSONString(mapList);
	    		jsonString = jsonString.replaceAll(" ","@space");
	    		jsonString = jsonString.replaceAll(">","@big");
	    		jsonString = jsonString.replaceAll("<","@small");

	    		outputStream.println("<data-table-custom data-list="+jsonString+" is-show-header='true'></data-table-custom>\n");

	        // outputStream.println("</TABLE>");

	        if(request.actionAllowed("_users"))
	        {
	            outputStream.println("<br><A HREF=" + getPageLink(request.getValue("page"), "Add") + ">Add</A> New Tenant Profile\n" + "<br><br><hr>\n");
	        }
	        printFooter(outputStream);
	    }

	    void printDeleteForm(String s)
	        throws java.lang.Exception
	    {
	        if(!request.getAccount().equals("administrator"))
	        {
	            outputStream.println("<hr>Administrator access only<hr>");
	            return;
	        }
	        String s1 = request.getValue("tenantid");
	        jgl.Array array = getTenantFrames();
	        jgl.HashMap hashmap = Tenant.findTenant(array, s1);
	        if(request.isPost())
	        {
	            try
	            {
	                array.remove(hashmap);
	                deleteTenant( TextUtils.getValue(hashmap, "_cName"));
	                saveTenantFrames(array);
	                printRefreshPage(getPageLink(request.getValue("page"), "List"), 0);
	            }
	            catch(java.lang.Exception exception)
	            {
	                printError("There was a problem deleting the user.", exception.toString(), "/SiteView/" + request.getAccountDirectory() + "/SiteView.html");
	            }
	        } else
	        {
	            printBodyHeader("Delete Confirmation");
	            outputStream.println("<FONT SIZE=+1>Are you sure you want to remove the user <B>" + getTenantTitle(hashmap) + "</B>?</FONT>" + "<p>" + getPagePOST(request.getValue("page"), s) + "<input type=hidden name=tenantid value=" + s1 + ">\n" + "<TABLE WIDTH=100% BORDER=0><TR>" + "<TD WIDTH=6%></TD><TD WIDTH=41%><input type=submit value=\"" + s + "\"></TD>" + "<TD WIDTH=6%></TD><TD ALIGN=RIGHT WIDTH=41%><A HREF=" + getPageLink(request.getValue("page"), "") + ">Return to Detail</A></TD><TD WIDTH=6%></TD>" + "</TR></TABLE></FORM>");
	            printFooter(outputStream);
	        }
	    }

	    void printPreferencesSaved()
	    {
	        printPreferencesSaved("/SiteView/" + request.getAccountDirectory() + "/SiteView.html", "", 0);
	    }

	    void printErrorPage(String s)
	    {
	        printBodyHeader("User Preferences");
	        outputStream.println("<p><CENTER><H2></H2></CENTER>\n<HR>There were errors in the entered information.  Use your browser's back button to return\nthe general preferences editing page\n");
	        String as[] = com.dragonflow.Utils.TextUtils.split(s, "\t");
	        outputStream.print("<UL>\n");
	        for(int i = 0; i < as.length; i++)
	        {
	            if(as[i].length() > 0)
	            {
	                outputStream.print("<LI><B>" + as[i] + "</B>\n");
	            }
	        }

	        outputStream.print("</UL><HR></BODY>\n");
	    }

	    public void printBody()
	        throws java.lang.Exception
	    {
	        String s = request.getValue("operation");
	        if(s.length() == 0)
	        {
	            s = "List";
	        }
	        if(s.equals("List"))
	        {
	            if(!request.actionAllowed("_preference"))
	            {
	                throw new HTTPRequestException(557);
	            }
	            printListForm(s);
	        } else
	        {
	            if(!request.actionAllowed("_users"))
	            {
	                throw new HTTPRequestException(557);
	            }
	            if(s.equals("Add"))
	            {
	                printAddForm(s);
	            } else
	            if(s.equals("Delete"))
	            {
	                printDeleteForm(s);
	            } else
	            if(s.equals("Edit"))
	            {
	                printAddForm(s);
	            } else
	            {
	                printError("The link was incorrect", "unknown operation", "/SiteView/" + request.getAccountDirectory() + "/SiteView.html");
	            }
	        }
	    }

	    public void printCGIHeader()
	    {
	        if(request.isPost() && (request.getValue("operation").equals("Add") || request.getValue("operation").equals("Edit")))
	        {
	            return;
	        } else
	        {
	            super.printCGIHeader();
	            return;
	        }
	    }

	    jgl.Array getTenantFrames()
	        throws java.io.IOException
	    {
	        jgl.Array array = null;
	        if(isPortalServerRequest())
	        {
	            try
	            {
	                array = ReadGroupFrames("_tenants");
	            }
	            catch(java.lang.Exception exception)
	            {
	                array = new Array();
	            }
	            jgl.HashMap hashmap = getMasterConfig();
//	            Tenant.initializeTenantList(array, hashmap);
	        } else
	        {
	            array = Tenant.readTenants();
	        }
	        return array;
	    }

	    void saveTenantFrames(jgl.Array array)
	        throws java.io.IOException
	    {
	        if(isPortalServerRequest())
	        {
	            WriteGroupFrames("_tenants", array);
	            return;
	        } else
	        {
	            Tenant.writeTenants(array);
	            return;
	        }
	    }

}

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
import java.util.Vector;

import jgl.Array;
import jgl.HashMap;

import com.alibaba.fastjson.JSONObject;
import com.dragonflow.HTTP.HTTPRequestException;
import com.dragonflow.SiteView.Machine;
import com.dragonflow.Utils.TextUtils;

// Referenced classes of package com.dragonflow.Page:
// prefsPage, serverPage, CGI

public abstract class remoteBase extends com.dragonflow.Page.prefsPage {

	private static final String DEFAULT_PASSWORD = "*********";

	private static final String SSH_AUTH_METHOD_FORM_VARIABLE = "sshAuthMethod";

	private static final String PASSWORD_FORM_VARIABLE = "password";

	private static final String SSH_CLIENT_METHOD_VARIABLE = "sshClient";

	private static final String KEYFILE_FORM_VARIABLE = "keyFile";

	private static final String FORCE_VERSION2_FORM_VARIABLE = "version2";

	private static final String DISABLE_CACHE_FORM_VARIABLE = "disableCache";

	private static final String CONNECTIONS_LIMIT = "sshConnectionsLimit";

	private static final String COMMAND_LINE_FORM_VARIABLE = "sshCommandLine";

	private static final String PORT_FORM_VARIABLE = "sshPort";

	public remoteBase() {
	}

	abstract jgl.Array getListTableHeaders(String s);

	abstract jgl.Array getListTableRow(jgl.HashMap hashmap, String s);

	abstract void doTest(com.dragonflow.SiteView.Machine machine);

	abstract String getTestMachineID();

	abstract String getTestMachineName();

	abstract String getTestDescription();

	abstract com.dragonflow.SiteView.Machine getTestMachine();

	abstract String getTestCentra();

	abstract String getHelpPage();

	abstract String getPage();

	abstract String getIDName();

	abstract String getNextMachineName();

	abstract String getRemoteName();

	abstract String getListTitle();

	abstract String getListSubtitle();

	abstract String getPrefTitle();

	abstract String getPrintFormSubmit();

	abstract boolean displayFormTable(jgl.HashMap hashmap, String s);

	void saveAddProperties(String s, jgl.HashMap hashmap, String s1) {
		hashmap.put(com.dragonflow.SiteView.Machine.pSshAuthMethod.getName(), request.getValue("sshAuthMethod"));
		hashmap.put(com.dragonflow.SiteView.Machine.pSshKeyFile.getName(), request.getValue("keyFile"));
		hashmap.put(com.dragonflow.SiteView.Machine.pSSHClient.getName(), request.getValue("sshClient"));
		hashmap.put(com.dragonflow.SiteView.Machine.pSSHForceVersion2.getName(), request.getValue("version2"));
		hashmap.put(com.dragonflow.SiteView.Machine.pSSHConnectionCaching.getName(), request.getValue("disableCache"));
		hashmap.put(com.dragonflow.SiteView.Machine.pSSHConnectionsLimit.getName(),
				request.getValue("sshConnectionsLimit"));
		hashmap.put(com.dragonflow.SiteView.Machine.pSSHCommandLine.getName(), request.getValue("sshCommandLine"));
		hashmap.put(com.dragonflow.SiteView.Machine.pSSHPort.getName(), request.getValue("sshPort"));
		String s2 = request.getValue("password");
		if (!s2.equals("*********")) {
			hashmap.put(com.dragonflow.SiteView.Machine.pPassword.getName(), s2);
		}
	}

	String getMachineID() {
		String s = request.getValue(getIDName());
		return s;
	}

	jgl.HashMap getTestMachineFrame() {
		return findMachine(getFrames(), getMachineID());
	}

	jgl.Array getFrames() {
		jgl.Array array = new Array();
		try {
			array = readMachines(getRemoteName());
		} catch (java.lang.Exception exception) {
		}
		return array;
	}

	String getNextMachineID(jgl.HashMap hashmap) {
		String s = null;
		if (hashmap != null) {
			s = TextUtils.getValue(hashmap, getNextMachineName());
		} else {
			s = request.getValue(getNextMachineName());
		}
		return s;
	}

	String getReturnLink(boolean flag, String s) {
		if (s.length() > 0) {
			if (flag) {
				return "<input type=hidden name=storeID value=" + s + ">\n";
			} else {
				return "&storeID=" + s;
			}
		} else {
			return "";
		}
	}

	void printBackLink() {
		String s = request.getValue("backURL");
		String s1 = request.getValue("backLabel");
		String s2 = request.getValue("backDescription");
		String s3 = request.getValue("backOperation");
		String s4 = request.getValue("storeID");
		String s5;
		if (s.length() == 0) {
			s5 = getPagePOST(getPage(), s3) + getReturnLink(true, s4);
		} else {
			s5 = "<form action=" + s + ">\n";
		}
		if (s1.length() == 0) {
			s1 = "Back to Remote Machines";
		}
		if (s3.length() == 0) {
			s3 = "List";
		}
		outputStream.println(s5+"<button type='submit' class='btn btn-info btn-blue'>"
				+"<iron-icon icon='arrow-back'></iron-icon>"+s1+"</button>"+s2+"</form>");
		// outputStream.println(s5 + "<input type=submit value=\"" + s1 + "\">" + s2 + "</input>\n</form>");
	}

	void formLogin(jgl.HashMap hashmap) {
		String s = getPage();
		String loginDesc = "";
		if (s.indexOf("windowsmachine") != -1) {
			loginDesc = "Enter the login for the remote server. <br>For a domain login, include the domain name before the user login (example: <i>domainname\\user</i>). <br>For a local or standalone login, include the machine name before the user login  (example: <i>machinename\\user</i>).";
		} else if (s.indexOf("machine") != -1) {
			loginDesc = "Enter the login to use for connecting to the remote server";
		} else {
			loginDesc = "Enter the login for the remote server";
		}
		// login input
		outputStream.println("<div class='row'><div class='col-xs-12 col-sm-6 col-md-4'>"
				+"<paper-input type='search' id='' name='login' label='Login:' size='50' value='"+TextUtils.getValue(hashmap, "_login")+"'></paper-input>"
				+"<div>"+loginDesc+"</div>"
				+"</div></div>");
//		outputStream.println(field("Login","<input type=text name=login size=50 value=\"" + TextUtils.getValue(hashmap, "_login") + "\">", loginDesc));

		String s2 = "";
		if (TextUtils.getValue(hashmap, com.dragonflow.SiteView.Machine.pPassword.getName()) != "") {
			s2 = "*********";
		}
		//password input
		outputStream.println("<div class='row'><div class='col-xs-12 col-sm-6 col-md-4'>"
				+"<paper-input type='password' id='' name='password' label='Password:' size='50' value='"+s2+"'></paper-input>"
				+"<div>The password for the remote server or the passphrase for the SSH key file.</div>"
				+"</div></div>");
//		outputStream.println(field("Password", "<input type=password name=password size=50 value=\"" + s2 + "\">","The password for the remote server or the passphrase for the SSH key file."));

		//title input
		outputStream.println("<div class='row'><div class='col-xs-12 col-sm-6 col-md-4'>"
				+"<paper-input type='search' id='' name='title' label='Title:' size='50' value='"+com.dragonflow.Page.remoteBase.getValue(hashmap, "_name")+"'></paper-input>"
				+"<div>Optional title describing the remote server. The default title is the server address</div>"
				+"</div></div>");
//		outputStream.println(field("Title","<input type=text name=title size=50 value=\""+ com.dragonflow.Page.remoteBase.getValue(hashmap, "_name") + "\">",
//				"Optional title describing the remote server. The default title is the server address"));
	}

	boolean dependentCheck() {
		if (request.getValue("method").equals("ssh")) {
			com.dragonflow.SSH.SSHManager.getInstance().deleteRemote(getRemoteUniqueId());
			String s = com.dragonflow.SSH.SSHManager.getInstance()
					.checkClient(request.getValue(com.dragonflow.SiteView.Machine.pSSHClient.getName()));
			if (s.length() != 0) {
				String s1 = "SSH client not found";
				printBodyHeader(s1);
				printButtonBar("Remote.htm", "");
				outputStream.println("<H2>" + s1 + "</H2>\n");
				outputStream.println(
						"<p>To monitor using SSH, SiteView requires that the ssh client is installed at <blockquote>"
								+ s + "</blockquote>");
				printFooter(outputStream);
				return true;
			}
		}
		return false;
	}

	String field(String s, String s1, String s2) {
		return "<TR><TD ALIGN=\"RIGHT\" VALIGN=\"TOP\">" + s + "</TD>" + "<TD><TABLE><TR><TD ALIGN=LEFT>" + s1
				+ "</TD></TR>" + "<TR><TD><FONT SIZE=-1>" + s2 + "</FONT></TD></TR>"
				+ "</TABLE></TD><TD><I></I></TD></TR>";
	}

	public void printBody() throws java.lang.Exception {
		String s = request.getValue("storeID");
		String operation = request.getValue("operation");
		if (operation.length() == 0) {
			operation = "List";
		}
		if (operation.equals("Test")) {
			if (!request.actionAllowed("_preferenceTest") && s.length() == 0) {
				throw new HTTPRequestException(557);
			}
			printTestForm(operation);
		} else {
			if (!request.actionAllowed("_preference") && s.length() == 0) {
				throw new HTTPRequestException(557);
			}
			if (operation.equals("List")) {
				printListForm(operation);
			} else if (operation.equals("Add")) {
				printAddForm(operation);
			} else if (operation.equals("Delete")) {
				printDeleteForm(operation);
			} else if (operation.equals("Edit")) {
				printAddForm(operation);
			} else {
				printError("The link was incorrect", "unknown operation",
						"/SiteView/" + request.getAccountDirectory() + "/SiteView.html");
			}
		}
	}

	void printListForm(String s) throws java.io.IOException {
		String s1 = request.getValue("backURL");
		String s3 = request.getValue("storeURL");
		String s4 = request.getValue("storeID");
		if (s1.length() > 0) {
			com.dragonflow.Page.serverPage.clientID++;
			com.dragonflow.Page.serverPage.setReturnURL(com.dragonflow.Page.serverPage.storeReturnURL, s3);
			com.dragonflow.Page.serverPage.setReturnURL(com.dragonflow.Page.serverPage.thisURL, s1);
			s4 = String.valueOf(com.dragonflow.Page.serverPage.clientID);
		}
		String s5 = getListTitle();
		String s6 = getListSubtitle();
		printBodyHeader(s5);

		printButtonBar(getHelpPage(), "", getSecondNavItems(request));
		if (s4.length() == 0) {
			printPrefsBar(getPrefTitle());
		}
		outputStream.println("<link rel='import' href='/SiteView/htdocs/js/pages/machine/machineListPage.html' async='true'>\n");

//		outputStream.println("<link rel='import' href='/SiteView/htdocs/js/components/data-table-ext/simple-data-table-ext.html' async='true'>\n");
		jgl.Array tableHeaders = getListTableHeaders(s4);

		ArrayList<java.util.HashMap> actionsList = new ArrayList<java.util.HashMap>();

		outputStream.println("<H2>" + s5 + "</H2> " + "<p>" + s6 + "</p>");

		// for (int i = 0; i < tableHeaders.size(); i++) {
		// 	outputStream.println("<TH align=left>" + tableHeaders.at(i) + "</TH>");
		// }

		jgl.Array array1 = readMachines(getRemoteName());
		if (array1.size() != 0) {
        String[] tbHeaderPrefixs = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n"};
	      for (Enumeration enumeration = array1.elements(); enumeration.hasMoreElements(); ) {
		        jgl.HashMap hashmap = (jgl.HashMap) enumeration.nextElement();
		        java.util.HashMap<String, String> dataMap = new java.util.HashMap<String, String>();
		        jgl.Array tableCols = getListTableRow(hashmap, s4);

		        for (int j = 0; j < tableCols.size(); j++) {
		          dataMap.put(tbHeaderPrefixs[j]+ "_" + tableHeaders.at(j),(String)tableCols.at(j));
		        }
		        actionsList.add(dataMap);
	      }
		}


		String actionsListStr = JSONObject.toJSONString(actionsList);
		actionsListStr = actionsListStr.replaceAll(" ","@space");
		actionsListStr = actionsListStr.replaceAll(">","@big");
		actionsListStr = actionsListStr.replaceAll("<","@small");
		// System.out.println("actionsListStr:"+actionsListStr);
		outputStream.println("<machine-list-page>");

		outputStream.println("<simple-data-table-ext data-list="+actionsListStr+" is-show-header no-data-tip='no remote servers defined'></simple-data-table-ext>");

		if (request.actionAllowed("_preference") || s4.length() > 0) {
			outputStream.println("<div style='margin-left:1em;'><A class='btn btn-info btn-blue' style='position:relative;display:inline-block;' href=" + getPageLink(getPage(), "Add") + getReturnLink(false, s4)
					+ ">Add<paper-ripple></paper-ripple></a> a Remote Machine\n" + "</div><br>\n");
		}
		if (s4.length() > 0) {
			String s2 = new String(
					com.dragonflow.Page.serverPage.getReturnURL(com.dragonflow.Page.serverPage.thisURL, s4));
			outputStream.println("<a href=\"" + s2 + "&pop=true&storeID=" + s4 + "\">Return to Choose Server<paper-ripple></paper-ripple></a>");
		}
		try {
			printDeleteDialog("Delete");
		} catch (java.lang.Exception exception) {
			printError("There was a problem deleting the remote server.", exception.toString(),
					"/SiteView/" + request.getAccountDirectory() + "/SiteView.html");
		}
		outputStream.println("</machine-list-page>");
		printFooter(outputStream);
	}

	void printDeleteDialog(String operation) throws java.lang.Exception{
		String s1 = getMachineID();
		String s2 = "ID " + s1;
		jgl.Array array = readMachines(getRemoteName());

		jgl.HashMap hashmap = findMachine(array, s1);
		if (hashmap != null) {
			s2 = TextUtils.getValue(hashmap, "_name");
			if (s2.length() == 0) {
				s2 = TextUtils.getValue(hashmap, "_host");
			}
		}
		String actionUrl = getTenant(request.getURL())+"/SiteView/cgi/go.exe/SiteView";
		outputStream.println("<machine-delete-dialog>");
		outputStream.println("<div class='dialogHeader'><FONT SIZE=+1>Are you sure you want to delete the remote server <B>" + s2
				+ "</B>?</FONT></div>");
		outputStream.println("<div class='dialogContent'><form action='"+actionUrl+"' method='post'>");
		String formHideInput = getFormHideInput(getPage(),operation);
		outputStream.println(formHideInput+"<input type=hidden name='" + getIDName()+ "' value=''>" + getReturnLink(true, request.getValue("storeID")));
		outputStream.println("<paper-input type=submit value='delete'></paper-input>");
		outputStream.println("<a class='btn btn-info btn-blue' href="+ getPageLink(getPage(), "List") + ">Return to Detail<paper-ripple></paper-ripple></a>");
		outputStream.println("</form></div>");

		// outputStream.println("<FONT SIZE=+1>Are you sure you want to delete the remote server <B>" + s2
		// 		+ "</B>?</FONT>" + "<p>" + getPagePOST(getPage(), operation) + "<input type=hidden name=" + getIDName()
		// 		+ " value=\"" + s1 + "\">" + getReturnLink(true, request.getValue("storeID"))
		// 		+ "<TABLE WIDTH=100% BORDER=0><TR>" + "<TD WIDTH=6%></TD><TD WIDTH=41%><input type=submit value=\""
		// 		+ operation + "\"></TD>" + "<TD WIDTH=6%></TD><TD ALIGN=RIGHT WIDTH=41%><A HREF="
		// 		+ getPageLink(getPage(), "List") + ">Return to Detail<paper-ripple></paper-ripple></a></TD><TD WIDTH=6%></TD>"
		// 		+ "</TR></TABLE></FORM>");
	}

	void printForm(String operation, jgl.Array array, jgl.HashMap hashmap) throws java.lang.Exception {
		String pagetitle = "";
		String s2 = getMachineID();
		String s3 = com.dragonflow.Page.remoteBase.getSubmitName(operation);
		String storeId = request.getValue("storeID");
		Boolean isAdd = false;
		jgl.HashMap hashmap1;
		if (operation.equals("Edit")) {
			hashmap1 = findMachine(array, s2);
			pagetitle = s3 + " Remote Server : " + hashmap1.get("_name");
		} else if(operation.equals("Add")) {
			isAdd = true;
			hashmap1 = new HashMap();
			String s5 = request.getValue("host");
			hashmap1.put("_host", s5);
			pagetitle = s3 + " Remote Server";
		}else{
			hashmap1 = new HashMap();
		}
		printBodyHeader(pagetitle);
		printButtonBar(getHelpPage(), "");
		outputStream.println("</td></tr></table>");

		outputStream.println("<link rel='import' href='/SiteView/htdocs/js/pages/machine/machineAddEdit_Form.html' async='true'>\n");

		outputStream.println("<p><H2>" + pagetitle + "</H2>\n");
		// outputStream.println(getPagePOST(getPage(), operation));
		String actionUrl = getTenant(request.getURL())+"/SiteView/cgi/go.exe/SiteView";
		String formHideInput = getFormHideInput(getPage(),operation);
		outputStream.println("<machine-add-edit-form id='machineAddEditFormContainer'><form is='iron-form-ext' id='machineAddEditForm' action='"+actionUrl+"' method='post' use-native-submit>");

		outputStream.println(formHideInput+"<input type=hidden name=backURL value=\"" + request.getValue("backURL") + "\">\n"
				+ "<input type=hidden name=backLabel value=\"" + request.getValue("backLabel") + "\">");
		if (operation.equals("Edit")) {
			outputStream.println("<input type=hidden name=" + getIDName() + " value=" + s2 + ">");
		}
		outputStream.println(getReturnLink(true, storeId));

		boolean flag = displayFormTable(hashmap1, operation);

		if (flag) {
			outputStream.println("<div class='row'><div class='col-xs-12 col-sm-6 col-md-4' style='text-align:center;margin-top:1em;'>" + getReturnLink(true, storeId) + "<paper-button class='fancy' raised onclick='_onClickAddEditUpdate()'>"
					+ s3 + "</paper-button> " + getPrintFormSubmit() + "\n" + "</div></div></form></machine-add-edit-form>");
		} else {
			printBackLink();
		}
		printFooter(outputStream);
	}

	private jgl.Array parseHosts(String s) {
		jgl.Array array = new Array();
		if (s.indexOf(",") != -1) {
			array = com.dragonflow.Utils.TextUtils.splitArray(s, ",");
		} else {
			array.add(s.trim());
		}
		return array;
	}
	public String getFormHideInput(String s,String s1) {
    	String tenant=getTenant(request.getURL());
        String s4 = "<input type=hidden name=page value="
                + s
                + ">\n"
                + "<input type=hidden name=account value=\""
                + request.getAccount() + "\">\n";
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

	private int getIndex(jgl.Array array, jgl.HashMap hashmap) {
		if (TextUtils.getValue(hashmap, "_id").length() == 0) {
			return -1;
		}
		for (int i = 0; i < array.size(); i++) {
			jgl.HashMap hashmap1 = (jgl.HashMap) array.at(i);
			if (TextUtils.getValue(hashmap, "_id").equals(TextUtils.getValue(hashmap1, "_id"))) {
				return i;
			}
		}

		return -1;
	}

	void printAddForm(String operation) throws java.lang.Exception {
		jgl.Array array = getFrames();
		if (request.isPost()) {
			if (dependentCheck()) {
				return;
			}
			String s1 = null;
			Object obj = null;
			jgl.HashMap hashmap1 = null;
			int i = -1;
			jgl.Array array1 = parseHosts(request.getValue("host"));
			boolean flag = array1.size() > 1;
			for (int j = 0; j < array1.size(); j++) {
				jgl.HashMap hashmap;
				if (operation.equals("Add")) {
					if (hashmap1 == null) {
						hashmap1 = getMasterConfig();
					}
					s1 = getNextMachineID(hashmap1);
					hashmap = new HashMap();
					if (s1.length() == 0) {
						s1 = "10";
					}
					hashmap1.put(getNextMachineName(), com.dragonflow.Utils.TextUtils.increment(s1));
				} else {
					s1 = getMachineID();
					hashmap = findMachine(array, s1);
					i = getIndex(array, hashmap);
					array.remove(hashmap);
				}
				hashmap.put("_host", array1.at(j).toString().trim());
				if (request.getValue("title").length() == 0) {
					hashmap.put("_name", hashmap.get("_host"));
				} else if (flag) {
					hashmap.put("_name", request.getValue("title") + " - " + hashmap.get("_host"));
				} else {
					hashmap.put("_name", request.getValue("title"));
				}
				saveAddProperties(operation, hashmap, s1);
				if (operation.equals("Add")) {
					array.add(hashmap);
				} else {
					array.insert(i, hashmap);
				}
			}

			saveMachines(array, getRemoteName());
			String s2 = "";
			if (request.getValue("addtest").indexOf("add") != -1 || array1.size() > 1) {
				s2 = getPageLink(getPage(), "List") + "&" + getIDName() + "=" + s1 + "&backURL="
						+ request.getValue("backURL") + "&backLabel="
						+ java.net.URLEncoder.encode(request.getValue("backLabel")) + "&backDescription="
						+ java.net.URLEncoder.encode(request.getValue("backDescription"))
						+ getReturnLink(false, request.getValue("storeID"));
			} else {
				s2 = getPageLink(getPage(), "Test") + "&" + getIDName() + "=" + s1 + "&backURL="
						+ request.getValue("backURL") + "&backLabel="
						+ java.net.URLEncoder.encode(request.getValue("backLabel")) + "&backDescription="
						+ java.net.URLEncoder.encode(request.getValue("backDescription"))
						+ getReturnLink(false, request.getValue("storeID"));
			}
			autoFollowPortalRefresh = false;
			printRefreshPage(s2, 0);
		} else {
			printForm(operation, array, new HashMap());
		}
	}

	void printDeleteForm(String s) throws java.lang.Exception { //deprecated.
		String s1 = getMachineID();
		String s2 = "ID " + s1;
		jgl.Array array = readMachines(getRemoteName());
		jgl.HashMap hashmap = findMachine(array, s1);
		if (hashmap != null) {
			s2 = TextUtils.getValue(hashmap, "_name");
			if (s2.length() == 0) {
				s2 = TextUtils.getValue(hashmap, "_host");
			}
		}
		if (request.isPost()) {
			try {
				com.dragonflow.SSH.SSHManager.getInstance().deleteRemote(getRemoteUniqueId());
				array.remove(hashmap);
				saveMachines(array, getRemoteName());
				autoFollowPortalRefresh = false;
				printRefreshPage(getPageLink(getPage(), "List") + getReturnLink(false, request.getValue("storeID")), 0);
			} catch (java.lang.Exception exception) {
				printError("There was a problem deleting the remote server.", exception.toString(),
						"/SiteView/" + request.getAccountDirectory() + "/SiteView.html");
			}
		} else {
			printBodyHeader("Delete Confirmation");
			outputStream.println("<FONT SIZE=+1>Are you sure you want to delete the remote server <B>" + s2
					+ "</B>?</FONT>" + "<p>" + getPagePOST(getPage(), s) + "<input type=hidden name=" + getIDName()
					+ " value=\"" + s1 + "\">" + getReturnLink(true, request.getValue("storeID"))
					+ "<TABLE WIDTH=100% BORDER=0><TR>" + "<TD WIDTH=6%></TD><TD WIDTH=41%><input type=submit value=\""
					+ s + "\"></TD>" + "<TD WIDTH=6%></TD><TD ALIGN=RIGHT WIDTH=41%><A HREF="
					+ getPageLink(getPage(), "List") + ">Return to Detail<paper-ripple></paper-ripple></a></TD><TD WIDTH=6%></TD>"
					+ "</TR></TABLE></FORM>");
			printFooter(outputStream);
		}
	}

	public void printTestForm(String operation) {
		printBodyHeader("checking the remote connection");
		printButtonBar(getHelpPage(), "");
		outputStream.println("<link rel='import' href='/SiteView/htdocs/js/pages/machine/machineTestPage.html' async='true'>\n");

		outputStream.println("<machine-test-page id='machineTestPageForm'><div class='container'><h2>Remote Machine Connection Test</h2>");
		outputStream.println("<p>This will test to see if the remote monitoring connection to:<b> "
				+ getTestMachineName() + "</b> is\n" + "working properly.\n");
		outputStream.println(getTestDescription());
		outputStream.println("<div class='row'><div class='col-xs-12 text-right'>");
		printBackLink();
		outputStream.println("</div></div></div>");
		if (!isPortalServerRequest()) {
			printContentStartComment();
			doTest(getTestMachine());
			printContentEndComment();
		} else {
			com.dragonflow.SiteView.PortalSiteView portalsiteview = (com.dragonflow.SiteView.PortalSiteView) getSiteView();
			if (portalsiteview != null) {
				String s1 = portalsiteview.getURLContentsFromRemoteSiteView(request, getTestCentra());
				outputStream.println(s1);
			}
		}
		printBackLink();
		outputStream.println("</machine-test-page>");
		outputStream.flush();
	}

	private static String _stripDoubleSlash(String s) {
		if (s.length() >= 2 && s.substring(0, 2).equals("\\\\")) {
			s = s.substring(2);
		}
		return s;
	}

	protected String getSshAuthMethodHtml(jgl.HashMap hashmap) {
		String s = TextUtils.getValue(hashmap, com.dragonflow.SiteView.Machine.pSshAuthMethod.getName());
		if (s.length() == 0) {
			s = "password";
		}

		String sshAuthMethod = "<div class='row'><div class='col-xs-12 col-sm-6 col-md-4'>"
				+"<paper-dropdown-menu label='SSH Authentication Method:' name='sshAuthMethod' horizontal-align='right'>"
				+"<paper-listbox class='dropdown-content' attr-for-selected='value' selected='"+s+"'>";
		sshAuthMethod += getOptionsElementByArr(com.dragonflow.SiteView.Machine.getAllowedSshAuthMethods());
		sshAuthMethod += "</paper-listbox>"
						+"</paper-dropdown-menu>"
						+"<div>Select the method to use to authenticate to the remote server.</div>"
						+"</div></div>";
		return sshAuthMethod;
//		return field("SSH Authentication Method","<select name=sshAuthMethod size=1>" + com.dragonflow.Page.remoteBase.getOptionsHTML(com.dragonflow.SiteView.Machine.getAllowedSshAuthMethods(), s),
//				"Select the method to use to authenticate to the remote server.");
	}

	protected String getSshClientHtml(jgl.HashMap hashmap) {
		String s = TextUtils.getValue(hashmap, com.dragonflow.SiteView.Machine.pSSHClient.getName());
		if (request.getValue("operation").equals("Add")) {
			s = "java";
		} else if (s.length() == 0) {
			s = "plink";
		}
		jgl.Array array = Machine.getAllowedSshConnectionMethods();
		boolean flag = false;
		for (int i = 0; i < array.size(); i++) {
			if (array.at(i).equals(s)) {
				flag = true;
				break;
			}
		}
		if (!flag) {
			s = "";
		}
		String sshClient = "<div class='row'><div class='col-xs-12 col-sm-6 col-md-4'>"
				+"<paper-dropdown-menu label='SSH Client:' name='sshClient' horizontal-align='right'>"
				+"<paper-listbox class='dropdown-content' attr-for-selected='value' selected='"+s+"'>";
		sshClient += getOptionsElementByArr(array);
		sshClient += "</paper-listbox>"
						+"</paper-dropdown-menu>"
						+"<div>Select the client to use to connect to the remote server.</div>"
						+"</div></div>";
		return sshClient;
//		return field("SSH Client","<select name=sshClient size=1>" + com.dragonflow.Page.remoteBase.getOptionsHTML(array, s),
//				"Select the client to use to connect to the remote server.");
	}
	private String getOptionsElementByArr(jgl.Array array){
		java.util.Vector vector = new Vector();
		String temp = "";
		for (int i = 0; i < array.size(); i++) {
				vector.addElement(array.at(i));
		}
		for (int i = 0; i < vector.size(); i += 2) {
				String value = (String) vector.elementAt(i);
				String label = (String) vector.elementAt(i+1);
				temp += "<paper-item-ext label='"+label+"' value='"+value+"'>"+label+"<paper-ripple></paper-ripple></paper-item-ext>";
		}
		return temp;
	}

	protected String getSSHKeyFileHtml(jgl.HashMap hashmap) {
		String s = TextUtils.getValue(hashmap, com.dragonflow.SiteView.Machine.pSshKeyFile.getName());
		if (s.length() == 0) {
			s = Machine.pSshKeyFile.getDefault();
		}
		String keyFile = "";
		keyFile = "<div class='row'><div class='col-xs-12 col-sm-6 col-md-4'>"
				+"<paper-input type='search' id='' name='keyFile' label='Key File for SSH connections:' size='50' value='"+s+"'></paper-input>"
				+"<div>Enter the path to the file containing the private key for this SSH connection. <b> Only valid if authentication method is \"Key File\".</div>"
				+"</div></div>";
		return keyFile;
//		return field("Key File for SSH connections", "<input type=text name=keyFile size=50 value=\"" + s + "\">",
//				"Enter the path to the file containing the private key for this SSH connection. <b> Only valid if authentication method is \"Key File\".");
	}

	protected String getSSHCommandLine(jgl.HashMap hashmap) {
		String s = TextUtils.getValue(hashmap, com.dragonflow.SiteView.Machine.pSSHCommandLine.getName());
		if (s.length() == 0) {
			s = Machine.pSSHCommandLine.getDefault();
		}
		String sshCommandLine = "<div class='row'><div class='col-xs-12 col-sm-6 col-md-4'>"
				+"<paper-input type='search' id='' name='sshCommandLine' label='Custom Commandline:' size='50' value='"+s+"'></paper-input>"
				+"<div>Enter the command for execution of external ssh client.  For substituion with above options use $host$, $user$ and $password$ respectivly. <b> This setting is for only for connections using an external process.</div>"
				+"</div></div>";
		return sshCommandLine;
//		return field("Custom Commandline", "<input type=text name=sshCommandLine size=50 value=\"" + s + "\">",
//				"Enter the command for execution of external ssh client.  For substituion with above options use $host$, $user$ and $password$ respectivly. <b> This setting is for only for connections using an external process.</b>");
	}

	protected String getNumConnectionseHtml(jgl.HashMap hashmap) {
		String s = TextUtils.getValue(hashmap, com.dragonflow.SiteView.Machine.pSSHConnectionsLimit.getName());
		if (s.length() == 0) {
			s = Machine.pSSHConnectionsLimit.getDefault();
		}
		String sshConnectionsLimit = "<div class='row'><div class='col-xs-12 col-sm-6 col-md-4'>"
				+"<paper-input type='search' id='' name='sshConnectionsLimit' label='Connection Limit:' size='50' value='"+s+"'></paper-input>"
				+"<div>Enter the maximum number of open connections allowed for this remote.</div>"
				+"</div></div>";
		return sshConnectionsLimit;
//		return field("Connection Limit", "<input type=text name=sshConnectionsLimit size=2 value=\"" + s + "\">",
//				"Enter the maximum number of open connections allowed for this remote.");
	}

	protected String getPortNumberHtml(jgl.HashMap hashmap) {
		String s = TextUtils.getValue(hashmap, com.dragonflow.SiteView.Machine.pSSHPort.getName());
		if (s.length() == 0) {
			s = Machine.pSSHPort.getDefault();
		}
		String sshPort = "<div class='row'><div class='col-xs-12 col-sm-6 col-md-4'>"
				+"<paper-input type='search' id='' name='sshPort' label='Port Number:' size='2' value='"+s+"'></paper-input>"
				+"<div>Enter the port number that the ssh server is running on. <b> Default is 22. </b></div>"
				+"</div></div>";
		return sshPort;
//		return field("Port Number", "<input type=text name=sshPort size=2 value=\"" + s + "\">",
//				"Enter the port number that the ssh server is running on. <b> Default is 22. </b>");
	}

	protected String getSSHForceVersion2Html(jgl.HashMap hashmap) {
		String s = TextUtils.getValue(hashmap, com.dragonflow.SiteView.Machine.pSSHForceVersion2.getName());
		if (s.length() > 0) {
			s = " CHECKED";
		}
		String version2 = "<div class='row'><div class='col-xs-12 col-sm-12 col-md-12'>"
				+"<paper-checkbox-ext "+s+" checked-value='CHECKED' name='version2'><div>SSH Version 2 Only,Check this box to force SSH to only use SSH protocol version 2. <b> ( This SSH option is only supported using the internal java libraries connection method) </b></div>"
				+ "</paper-checkbox-ext></div></div>";
		return version2;
//		return field("SSH Version 2 Only", "<input type=checkbox name=version2" + s + ">",
//				"Check this box to force SSH to only use SSH protocol version 2. <b> ( This SSH option is only supported using the internal java libraries connection method) </b>");
	}

	protected String getDisableCacheHtml(jgl.HashMap hashmap) {
		String s = com.dragonflow.Utils.TextUtils.getValue(hashmap,
				com.dragonflow.SiteView.Machine.pSSHConnectionCaching.getName());
		if (s.length() > 0) {
			s = " CHECKED";
		}
		String disableCache = "<div class='row'><div class='col-xs-12 col-sm-12 col-md-12'>"
				+"<paper-checkbox-ext "+s+" checked-value='CHECKED' name='disableCache'><div>Disable Connection Caching, Check this box to disable caching of SSH connections.</div>"
				+ "</paper-checkbox-ext></div></div>";
		return disableCache;
//		return field("Disable Connection Caching", "<input type=checkbox name=disableCache" + s + ">",
//				"Check this box to disable caching of SSH connections. ");
	}

	public String getRemoteUniqueId() {
		return request.getValue("ntMachineID");
	}

	protected StringBuffer getAdnvacedSSHOptions(jgl.HashMap hashmap) {
		StringBuffer stringbuffer = new StringBuffer();
		stringbuffer.append("<div class='row'><div class='col-xs-12'><hr><H3>SSH Advanced Options</H3></div></div>");
		stringbuffer.append(getSshClientHtml(hashmap));
		stringbuffer.append(getPortNumberHtml(hashmap));
		stringbuffer.append(getDisableCacheHtml(hashmap));
		stringbuffer.append(getNumConnectionseHtml(hashmap));
		stringbuffer.append(getSshAuthMethodHtml(hashmap));
		stringbuffer.append(getSSHKeyFileHtml(hashmap));
		stringbuffer.append(getSSHForceVersion2Html(hashmap));
		stringbuffer.append(getSSHCommandLine(hashmap));
		return stringbuffer;
	}
}

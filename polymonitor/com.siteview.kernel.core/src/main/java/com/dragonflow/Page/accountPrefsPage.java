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

import jgl.Array;

import com.dragonflow.SiteView.MasterConfig;
import com.dragonflow.SiteView.Platform;
import com.dragonflow.SiteView.SiteViewGroup;
import com.dragonflow.SiteView.User;

// Referenced classes of package com.dragonflow.Page:
// prefsPage, siteseerAdminPage, CGI

public class accountPrefsPage extends com.dragonflow.Page.prefsPage{

    public accountPrefsPage(){
    }

    public static void main(String args[]) throws java.io.IOException{
      com.dragonflow.Page.accountPrefsPage accountprefspage = new accountPrefsPage();
      if(args.length > 0){
        accountprefspage.args = args;
      }
      accountprefspage.handleRequest();
    }
    public void printBody(){
        if(request.isPost()){
            savePreferences();
        } else{
            com.dragonflow.Page.accountPrefsPage.printForm(outputStream, request);
        }
    }

    void savePreferences(){
        String errorInfo = "";
        com.dragonflow.SiteView.User user = request.getUser();
        if(user != null){
        	String loginName = request.getValue("login");
        	String password = request.getValue("password");
        	if(loginName.length() == 0){
        		errorInfo = "A login name is required.";
        	} else if(!password.equals(request.getValue("password2"))){
        		errorInfo = "The two passwords didn't match.";
        	} else if(password.length() == 0){
        		errorInfo = "A password is required.";
        	} else if(request.getValue("outageEmail").length() <= 0){
        		errorInfo = "Please enter a notification E-mail address.";
        	}
        	if(errorInfo.length() == 0){
        		realSavePreferences(loginName,password); //real save info.
        	}
        } else{
        	errorInfo = "Could not find the user for username " + request.getUsername();
        }
        if(errorInfo.length() == 0){
        	printRefreshPage("/SiteView/" + request.getAccountDirectory() + "/SiteView.html", 0);
        } else{
        	printBodyHeader("Account Error");
        	outputStream.println("<H2>Account Error</H2><hr>" + errorInfo + "<hr>There were errors in the entered information. \n" + "Use your browser's back button to return to the account page.\n");
        	printFooter(outputStream);
        	outputStream.println("</BODY>\n");
        }
    }
    private void realSavePreferences(String loginName,String password){
    	try{
	        jgl.HashMap hashmap = getSettings();
	        com.dragonflow.SiteView.User user = request.getUser();
	        com.dragonflow.SiteView.User user1 = new User();
	        jgl.Array array = user.getImmediateProperties();
	        for(int i = 0; i < array.size(); i++){
	            com.dragonflow.Properties.StringProperty stringproperty = (com.dragonflow.Properties.StringProperty)array.at(i);
	            user1.setProperty(stringproperty, user.getProperty(stringproperty));
	        }
	
	        user1.setProperty(User.pRealName, request.getValue("realName"));
	        user1.setProperty(User.pLogin, loginName);
	        user1.setProperty(User.pPassword, password);
	        user1.setProperty(User.pEmail, request.getValue("contactEmail"));
	        java.lang.Object obj = hashmap.get("_user");
	        jgl.Array array1 = new Array();
	        array1.add(com.dragonflow.Utils.TextUtils.hashMapToString(user1.getValuesTable()));
	        if(obj != null && (obj instanceof jgl.Array)){
	            jgl.Array array2 = (jgl.Array)obj;
	            for(int j = 1; j < array2.size(); j++){
	                array1.add(array2.at(j));
	            }
	        }
	        hashmap.put("_user", array1);
	        hashmap.put("_timeOffset", request.getValue("timeOffset"));
	        hashmap.put("_contactEmail", request.getValue("contactEmail"));
	        hashmap.put("_outageEmail", request.getValue("outageEmail"));
	        saveSettings(hashmap);
    	}
        catch(java.io.IOException ioexception){
            printError("The preferences could not be saved", "master.config file could not be saved", "/SiteView/" + request.getAccountDirectory() + "/SiteView.html");
        }
    }

    public static void printForm(java.io.PrintWriter printwriter, com.dragonflow.HTTP.HTTPRequest httprequest){
        com.dragonflow.SiteView.User user = httprequest.getUser();
        if(user == null){
        	String errInfo = "User \"" + httprequest.getUsername() + "\" is not defined";
        	String linkToUrl = "/SiteView/cgi/go.exe/SiteView?account=" + httprequest.getAccount();
            com.dragonflow.Page.accountPrefsPage.printError(printwriter, errInfo, "", linkToUrl);
            return;
        }
        String _account = httprequest.getAccount(); //s
        com.dragonflow.SiteView.SiteViewGroup siteviewgroup = SiteViewGroup.currentSiteView();
        com.dragonflow.SiteView.MonitorGroup monitorgroup = (com.dragonflow.SiteView.MonitorGroup)siteviewgroup.getElement(_account);
        boolean flag = httprequest.getPermission("_monitorType", "URLMonitor").length() <= 0;
        System.out.println("newAccount=" + flag);
        String s1 = "&account=" + httprequest.getAccount();
        String s2 = monitorgroup.getSetting("_partnerFilter");
        if(s2.length() > 0){
            String linkToUrl = "/SiteView/cgi/go.exe/SiteView?page=siteseerAdmin&account=" + httprequest.getAccount();
            com.dragonflow.Page.accountPrefsPage.printRefreshHeader(printwriter, "", linkToUrl, 0);
            printwriter.println("<!--If your browser doesn't refresh, click on <A HREF=" + linkToUrl + ">this link</A> to continue.-->" + "</BODY>\n");
            return;
        }
        String _partnerSupportHTML = "";
        String s5 = "";
        String s6 = "";
        String s7 = "";
        String s8 = "";
        String _partnerMainFooterHTML = "";
        String _partnerMainHTML = "";
        String s11 = monitorgroup.getSetting("_partner");
        if(s11.length() > 0){
            com.dragonflow.SiteView.MonitorGroup monitorgroup1 = (com.dragonflow.SiteView.MonitorGroup)siteviewgroup.getElement(s11);
            if(monitorgroup1 != null){
                _partnerMainFooterHTML = monitorgroup1.getProperty("_partnerMainFooterHTML");
                s8 = monitorgroup1.getProperty("_partnerMainHeaderHTML");
                _partnerMainHTML = monitorgroup1.getProperty("_partnerMainHTML");
                _partnerSupportHTML = monitorgroup1.getProperty("_partnerSupportHTML");
                s5 = monitorgroup1.getProperty("_partnerExpiredHTML");
                s6 = monitorgroup1.getProperty("_partnerUpgradeHTML");
                s7 = monitorgroup1.getProperty("_partnerSubscribeHTML");
            }
        }
        if(s8.length() == 0)
        {
            s8 = monitorgroup.getSetting("_accountHTML");
        }
        if(_partnerSupportHTML.length() == 0){
            _partnerSupportHTML = "<DT><B>SiteSeer Support</B>\n<DD>If you have any questions, "
              +"comments or problems with your SiteSeer account, we&#039;d be happy to help.\n"
              +"You can reach us via e-mail at <A HREF=mailto:"
              + com.dragonflow.SiteView.Platform.siteseerSupportEmail + ">"
              + com.dragonflow.SiteView.Platform.siteseerSupportEmail + "</A>,\n"
              + "or by telephone at " + com.dragonflow.SiteView.Platform.supportPhone
              + ". If you have feedback on additional features that you&#039;d like\n"
              + "to see or changes that we should make to ensure SiteSeer is even more useful, "+
              "please also drop us a line" + " &#045; we value your opinion.\n";
        }
        if(s5.length() == 0){
            s5 = "To subscribe to SiteSeer, <a href="
            + com.dragonflow.SiteView.Platform.homeURLPrefix + "/OrderOpts.htm>order online</a>, call us toll-free at "
            + com.dragonflow.SiteView.Platform.salesPhone + "\n" + "or send e-mail to <a href=mailto:"
            + com.dragonflow.SiteView.Platform.salesEmail + ">" + com.dragonflow.SiteView.Platform.salesEmail + "</a>.";
        }
        if(s6.length() == 0){
            s6 = "To upgrade or renew your SiteSeer service, call us toll-free at "
            + com.dragonflow.SiteView.Platform.salesPhone + ", or send e-mail to <a href=mailto:"
            + com.dragonflow.SiteView.Platform.salesEmail + ">" + com.dragonflow.SiteView.Platform.salesEmail + "</a>";
        }
        if(s7.length() == 0){
            s7 = "To subscribe to SiteSeer, <a href=" + com.dragonflow.SiteView.Platform.homeURLPrefix
            + "/OrderOpts.htm>order online</a>, call us toll-free at "
            + com.dragonflow.SiteView.Platform.salesPhone + "\n" + "or send e-mail to <a href=mailto:"
            + com.dragonflow.SiteView.Platform.salesEmail + ">" + com.dragonflow.SiteView.Platform.salesEmail + "</a>.";
        }
        jgl.HashMap hashmap = monitorgroup.getValuesTable();
        long al[] ;//= com.dragonflow.Page.siteseerAdminPage.getDays(hashmap);
        // XXX com.dragonflow.Page.siteseerAdminPage class does not exist.
        long l = 0;// = al[1];
        String _accountType = "SiteSeer";
        String s13 = monitorgroup.getSetting("_customer");
        if(s13.length() > 0){
            if(s13.equals("global")){
                _accountType = "Global " + _accountType;
            } else
            if(!s13.equals("standard")){
                _accountType = _accountType + " " + com.dragonflow.Utils.TextUtils.toInitialUpper(s13);
            }
        }
        String s14 = "";
        if(s13.indexOf("trial") != -1){
            s14 = "trial ";
        }
        String s15 = "Your " + s14 + "account expired today";
        if(l < 0L){
            s15 = "Your " + s14 + "account expired " + -l + " days ago\n";
        } else if(l > 0L){
            s15 = "Your " + s14 + "account expires in " + l + " days\n";
        }
        String _expiredInfo = "";
        if(s13.indexOf("trial") != -1 || l < 30L){
            _expiredInfo = "<HR><CENTER><h3>" + s15 + "</h3></CENTER>\n";
            if(s13.indexOf("trial") != -1){
                _expiredInfo = _expiredInfo + "<p><img src=/SiteView/htdocs/artwork/new2.gif>\n<P>SiteSeer offers numerous options to fit your monitoring needs. "
                +" These include a number\nof POP locations domestically and worldwide combined with the ability to monitor "
                +"URLs or URL\n sequences for availability. For more information, call us toll free at "
                + com.dragonflow.SiteView.Platform.salesPhone + " or\n" + " send an e-mail to <a href=mailto:"
                + com.dragonflow.SiteView.Platform.salesEmail + ">" + com.dragonflow.SiteView.Platform.salesEmail
                + "</a>.  You can also \n" + "<a href="+CGI.getTenant(httprequest.getURL())+"/SiteView/cgi/go.exe/SiteView?page=tranWizard&monitor&group="
                + _account + "&operation=Add&class=URLRemoteSequenceMonitor&account=" + _account + ">run a sample URL sequence monitor</a> "
                +"from select worldwide locations.\n" + "<HR>";
            }
        } else{
            _expiredInfo = "<p><CENTER>" + s15 + "</CENTER>";
        }
        boolean _chatEnabled = monitorgroup.getSetting("_chatEnabled").length() > 0;
        String s18 = monitorgroup.getSetting("_chatScript");
        s18 = com.dragonflow.Utils.TextUtils.replaceString(s18, "\\n", "\n");
        com.dragonflow.Page.accountPrefsPage.printBodyHeader(printwriter, _accountType + " Account", s18);
        printwriter.print(s8);
        com.dragonflow.Page.accountPrefsPage.printButtonBar(printwriter, "SiteSeer.htm", "SiteView", httprequest, MasterConfig.getMasterConfig());

        // polymer components start
        printwriter.println("<link rel='import' href='/SiteView/htdocs/js/pages/accountPrefsPage/accountPrefsPage_Form/account-prefs-page-form.html' async='true'>\n");

        String _chatHTML = "";
        if(_chatEnabled){
            long l1 = monitorgroup.getSettingAsLong("_chatStartHour");
            long l2 = monitorgroup.getSettingAsLong("_chatEndHour");
            java.util.Date date = Platform.makeDate();
            if(s13.indexOf("247") != -1 || (long)date.getHours() >= l1 && (long)date.getHours() <= l2)
            {
                _chatHTML = "" + monitorgroup.getSetting("_chatHTML");
            }
        }
        // bolw content will put in polymer component "account-prefs-page-form".
        // printwriter.print(_partnerMainHTML + _expiredInfo + "<P><TABLE WIDTH=\"100%\" BORDER=0><TR>\n"
        //   + "<TD ROWSPAN=2><a href=" + com.dragonflow.SiteView.Platform.homeURLPrefix
        //   + "/SiteSeer.htm><img border=0 src=/SiteView/htdocs/artwork/siteseerlogo.gif></a></TD></TR>\n"
        //   + "<TR><TD><H2>" + _accountType + " Account: " + com.dragonflow.Page.accountPrefsPage.getGroupName(monitorgroup, _account)
        //   + "</H2></TD><td>" + _chatHTML + "</td></TR>\n" + "</TABLE>\n" + monitorgroup.getSetting("_siteseerNews"));
        int ai[] = {
            com.dragonflow.SiteView.MonitorGroup.CATEGORY_COLUMN,
            com.dragonflow.SiteView.MonitorGroup.STATUS_COLUMN,
            com.dragonflow.SiteView.MonitorGroup.SIMPLE_NAME_COLUMN
        };
        com.dragonflow.SiteView.MonitorGroup.printMonitorTable(printwriter, httprequest, "<h2>Current Status of Monitors</h2>", "", ai, monitorgroup.getMonitors());

        // printwriter.println("<BLOCKQUOTE><DL>");

        String _groupDetailUrl = com.dragonflow.Page.CGI.getGroupDetailURL(httprequest, monitorgroup.getProperty(com.dragonflow.SiteView.Monitor.pID));
        // printwriter.println("<DT><TABLE width=300><TR><TD><A HREF=" + _groupDetailUrl + ">" + "Go to Monitor Detail</A>" + "<TD align=right><A HREF=/SiteView/docs/Group.htm#detail TARGET=Help>Help</A>" + "</TABLE><DD>" + "Add or modify monitors, or get more information about the monitors.");

        String _reportsListUrl = "/SiteView/cgi/go.exe/SiteView?page=report&operation=List" + s1;
        // printwriter.println("<DT><TABLE width=300><TR><TD><A HREF=" + _reportsListUrl + ">" + "Go to Reports</A>" + "<TD align=right><A HREF=/SiteView/docs/HReports.htm TARGET=Help>Help</A>" + "</TABLE><DD>" + "Reports provide historical data from the readings of your monitors.\n" + "View generated daily and weekly reports. Modify report settings, and add reports.\n");

        String _alertListUrl = "/SiteView/cgi/go.exe/SiteView?page=alert&operation=List" + s1;
        // printwriter.println("<DT><TABLE width=300><TR><TD><A HREF=" + _alertListUrl + ">" + "Go to Alerts</A>" + "<TD align=right><A HREF=/SiteView/docs/Alert.htm TARGET=Help>Help</A>" + "</TABLE><DD>" + "Alerts define the method by which SiteSeer will contact you in the event of a problem.\n" + "Change how often alerts are sent, and add and modify pager settings.");

        String _logUrl = "/SiteView/cgi/go.exe/SiteView?page=log" + s1;
        // printwriter.println("<DT><TABLE width=300><TR><TD><A HREF=" + _logUrl + ">" + "Go to Logs</A>" + "<TD align=right><A HREF=/SiteView/docs/Log.htm TARGET=Help>Help</A>" + "</TABLE><DD>" + "View the unformatted contents of the log files for monitoring and alerting.");

        String s23 = "";
        if(s13.length() > 0 && !s13.equals("standard")){
            s23 = com.dragonflow.Utils.TextUtils.toInitialUpper(s13) + " ";
        }
        String _userRealName = user.getProperty(User.pRealName);
        String _userEmail = user.getProperty(User.pEmail);
        String _outageEmail = monitorgroup.getProperty("_outageEmail");
        String _userLoginName = user.getProperty(User.pLogin);
        String _userLoginPassword = user.getProperty(User.pPassword);
        String _timeZoneName = "";
        String _formSelectOption = "";
        if(!httprequest.actionAllowed("_preference")){
            // printwriter.print("<P>\n<P>\n<DT><B>Account Details</B>\n<DD><TABLE BORDER=\"0\">\n<TR><TD ALIGN=RIGHT>Account:</TD>"
            // +"<TD>" + _account + "</TD></TR>\n" + "<TR><TD ALIGN=RIGHT>Contact Name:</TD>"
            // +"<TD>" + _userRealName + "</TD></TR>\n" + "<TR><TD ALIGN=RIGHT>Contact E-mail:</TD>"
            // +"<TD>" + _userEmail + "</TD></TR>\n" + "<TR><TD ALIGN=RIGHT>Notification E-mail:</TD>"
            // +"<TD>" + _outageEmail + "</TD></TR>\n" + "<TR><TD ALIGN=RIGHT>Time Zone:</TD><TD>");

            int i = com.dragonflow.Utils.TextUtils.toInt(monitorgroup.getProperty("_timeOffset"));
            for(int k = 0x11940; k >= -21600; k -= 3600)
            {
                String s26 = Platform.timeZoneName(k);
                if(s26.length() > 0)
                {
                    s26 = "(" + s26 + ")";
                }
                String s29 = " hours ";
                if(k == 3600 || k == -3600)
                {
                    s29 = " hour ";
                }
                if(k > 0)
                {
                    s26 = "+" + k / 3600 + s29 + s26;
                } else
                if(k <= 0)
                {
                    s26 = k / 3600 + s29 + s26;
                }
                if(k == i){
                  _timeZoneName += s26;
                    // printwriter.print(s26);
                }
            }
            // printwriter.print(_timeZoneName+"</TD></TR></TABLE><p>");
        } else{
            // printwriter.print("<P>\n<P>\n<FORM ACTION=/SiteView/cgi/go.exe/SiteView method=POST>\n<input type=hidden name=account value=" + _account + ">\n"
            // + "<input type=hidden name=page value=accountPrefs>\n" + "<input type=hidden name=operation value=save>\n"
            // + "<DT><B>Account Details</B>\n" + "<DD><TABLE>\n"
            // + "<TR><TD ALIGN=RIGHT>Account:</TD><TD>" + _account + "</TD></TR>\n"
            // + "<TR><TD ALIGN=RIGHT>Username:</TD><TD ALIGN=LEFT><input name=login size=25 value=\"" + _userLoginName + "\"></TD>"
            // +"</TR>\n" + "<TR><TD></TD><TD><FONT SIZE=-1>the username used to login to this account</FONT></TD></TR>\n"
            // + "<TR><TD ALIGN=RIGHT>Password:</TD><TD ALIGN=LEFT><input type=password name=password size=25 value=\"" + user.getProperty(User.pPassword) + "\"></TD></TR>\n"
            // + "<TR><TD></TD><TD><FONT SIZE=-1>the password used to login to this account</FONT></TD></TR>\n"
            // + "<TR><TD ALIGN=RIGHT>Password (again):</TD><TD ALIGN=LEFT><input type=password name=password2 size=25 value=\"" + user.getProperty(User.pPassword) + "\"></TD></TR>\n"
            // + "<TR><TD></TD><TD><FONT SIZE=-1>the password again used to login to this account</FONT></TD></TR>\n"
            // + "<TR><TD ALIGN=RIGHT>Contact Name:</TD><TD ALIGN=LEFT><input name=realName size=30 value=\"" + user.getProperty(User.pRealName) + "\"></TD></TR>\n"
            // + "<TR><TD></TD><TD><FONT SIZE=-1>the contact person for questions about this account</FONT></TD></TR>\n"
            // + "<TR><TD ALIGN=RIGHT>Contact E-mail:</TD><TD ALIGN=LEFT><input name=contactEmail size=30 value=\"" + user.getProperty(User.pEmail) + "\"></TD></TR>\n"
            // + "<TR><TD></TD><TD><FONT SIZE=-1>the contact email for questions about this account</FONT></TD></TR>\n" + "<TR><TD ALIGN=RIGHT>Notification E-mail:</TD>"
            // +"<TD ALIGN=LEFT><input name=outageEmail size=30 value=\"" + monitorgroup.getProperty("_outageEmail") + "\"></TD>"
            // +"</TR>\n" + "<TR><TD></TD><TD><FONT SIZE=-1>optional, email address for notification of scheduled maintenance and upgrades</FONT></TD></TR>\n"
            // + "<TR><TD ALIGN=RIGHT>Time Zone:</TD><TD ALIGN=LEFT>");
            // printwriter.print("<select name=timeOffset size=1>\n");
            int j = com.dragonflow.Utils.TextUtils.toInt(monitorgroup.getProperty("_timeOffset"));
            for(int i1 = 0x11940; i1 >= -21600; i1 -= 3600)
            {
                String s27 = Platform.timeZoneName(i1);
                if(s27.length() > 0)
                {
                    s27 = "(" + s27 + ")";
                }
                String s30 = " hours ";
                if(i1 == 3600 || i1 == -3600)
                {
                    s30 = " hour ";
                }
                if(i1 > 0)
                {
                    s27 = "+" + i1 / 3600 + s30 + s27;
                } else
                if(i1 <= 0)
                {
                    s27 = i1 / 3600 + s30 + s27;
                }
                String s32 = "";
                if(i1 == j)
                {
                    s32 = "SELECTED";
                }
                _formSelectOption += "<option " + s32 + " value=\"" + i1 + "\">" + s27 + "</option>";
                // printwriter.print("<option " + s32 + " value=\"" + i1 + "\">" + s27 + "</option>\n");
            }
            // printwriter.print("</select>\n");
            // printwriter.print("</TD></TR><TR><TD></TD><TD><FONT SIZE=-1>choose which time zone to use for displaying times in this account</FONT></TD></TR></TABLE><p>\n<input type=submit value=\"Save Changes\"></FORM>\n");
        }
        String s24 = "<br>SiteSeer Gold subscribers can also:<UL><LI>monitor every five minutes</LI>"
              +"<LI>send alerts to multiple pagers</LI><LI>use a second login for read-only access</LI><LI>monitor other applications such as FTP, Mail, DNS, and News</LI></UL>";
        String s25 = "<br>Global SiteSeer subscribers can also:<UL><LI>monitor up to five URLs from multiple locations around the world</LI><LI>(including San Francisco, Washington DC, Denver, London, Toronto, and Australia)</LI><LI>create a single graph showing response times from each location</LI><LI>send alerts only when errors occur from several locations</LI></UL>";
        String _moreInfo = "";
        if(s13.equals("gold")){
            _moreInfo = "<DT><b>Upgrade to Global SiteSeer</b><DD>" + s6 + "<br>" + s25;
        } else if(s13.equals("standard")){
            _moreInfo = "<DT><b>Upgrade to SiteSeer Gold or Global SiteSeer</b><DD>" + s6 + "<br>" + s24 + s25;
        } else if(s13.indexOf("trial") != -1){
            _moreInfo = "<DT><b>Subscribe to SiteSeer</b><DD>To subscribe to the SiteSeer service or order additional POPs, monitors\n "
            +"or other options for your account, call us toll free at "
            + com.dragonflow.SiteView.Platform.salesPhone + " or\n"
            + " send an e-mail to <a href=mailto:" + com.dragonflow.SiteView.Platform.salesEmail + ">"
            + com.dragonflow.SiteView.Platform.salesEmail + "</a>";
        }
        String _monitorEditType = "read only";
        if(httprequest.actionAllowed("_monitorEdit")){
            _monitorEditType = "read/write";
        }
        String _adviceInfoOne = "none, requires upgrade to Global SiteSeer";
        String _adviceInfoTwo = "none, requires Global Transaction upgrade";
        int j1 = com.dragonflow.Utils.TextUtils.toInt(httprequest.getPermission("_monitorType", "URLRemoteMonitor"));
        if(j1 != 0){
            _adviceInfoOne = "up to " + j1 + " global monitors may be added.";
        }
        int k1 = com.dragonflow.Utils.TextUtils.toInt(httprequest.getPermission("_monitorType", "URLRemoteSequenceMonitor"));
        if(k1 != 0){
            _adviceInfoTwo = "up to " + k1 + " global transactions may be added.";
        }
        if(flag)
        {
            _adviceInfoOne = "none";
            _adviceInfoTwo = "none";
            if(_moreInfo.length() == 0)
            {
                _moreInfo = s6;
            }
            if(j1 != 0)
            {
                _adviceInfoOne = "up to " + j1 + " URL monitor(s) may be added";
            }
            if(k1 != 0)
            {
                _adviceInfoTwo = "up to " + k1 + " URL sequence monitor(s) may be added.";
            }
        }
        // printwriter.print("<P>\n<P>\n<DT><FONT SIZE=+1><B>Account Configuration</B></FONT>\n<DD><TABLE BORDER=\"0\">\n");

        String _secondsStr = com.dragonflow.Utils.TextUtils.secondsToString(com.dragonflow.Utils.TextUtils.toInt(monitorgroup.getSetting("_minimumFrequency")));
        String _maximumMonitors = monitorgroup.getSetting("_maximumMonitors");
        String _maximumReportsCount = monitorgroup.getSetting("_maximumReportsCount");
        // if(flag){
        //     printwriter.print("<TR><TD ALIGN=RIGHT><B>URL Monitors:</B></TD><TD>" + _adviceInfoOne
        //     		+ "</TD></TR>\n" + "<TR><TD ALIGN=RIGHT><B>URL Sequence Monitors:</B></TD><TD>" + _adviceInfoTwo
        //     		+ "</TD></TR>\n" + "<TR><TD ALIGN=RIGHT><B>Monitors:</B></TD><TD>up to "
        //     		+ _maximumMonitors + " total monitors may be added.</TD></TR>\n" +
        //     		"<TR><TD ALIGN=RIGHT><B>Reports:</B></TD><TD>up to " + monitorgroup.getSetting("_maximumReportsCount")
        //     		+ " reports may be defined.</TD></TR>\n" + "<TR><TD ALIGN=RIGHT><B>Frequency:</B></TD><TD>monitors as often as every "
        //     		+ _secondsStr
        //     		+ "</TD></TR>\n" + "<TR><TD ALIGN=RIGHT><B>Privileges:</B></TD><TD>" + _monitorEditType + "</TD></TR>\n");
        // } else{
        //     printwriter.print("<TR><TD ALIGN=RIGHT><B>Global Transactions:</B></TD><TD>" + _adviceInfoTwo
        //     		+ "</TD></TR>\n" + "<TR><TD ALIGN=RIGHT><B>Global Monitors:</B></TD><TD>" + _adviceInfoOne
        //     		+ "</TD></TR>\n" + "<TR><TD ALIGN=RIGHT><B>Monitors:</B></TD><TD>up to "
        //     		+ _maximumMonitors + " monitors may be added.</TD></TR>\n"
        //     		+ "<TR><TD ALIGN=RIGHT><B>Reports:</B></TD><TD>up to " + monitorgroup.getSetting("_maximumReportsCount")
        //     		+ " reports may be defined.</TD></TR>\n" + "<TR><TD ALIGN=RIGHT><B>Frequency:</B></TD><TD>sample as often as every "
        //     		+ _secondsStr
        //     		+ "</TD></TR>\n" + "<TR><TD ALIGN=RIGHT><B>Privileges:</B></TD><TD>" + _monitorEditType + "</TD></TR>\n");
        // }
        //
        // printwriter.print("</TABLE><p>\n" + _moreInfo + "\n" + "<P>\n" + _partnerSupportHTML + "<P>\n" + "<P>\n");
        // printwriter.println("</DL></BLOCKQUOTE>" + _partnerMainFooterHTML);

        printwriter.println("<account-prefs-page-form _partner-main-html='"+_partnerMainHTML+"' "
                +" _expired-info='"+_expiredInfo+"' "
                +" _home-url-prefix='"+com.dragonflow.SiteView.Platform.homeURLPrefix+"' "
                +" _account-type='"+_accountType+"' "
                +" _group-name='"+com.dragonflow.Page.accountPrefsPage.getGroupName(monitorgroup, _account,httprequest)+"' "
                +" _chat-html='"+_chatHTML+"' "
                +" _siteseer-news='"+monitorgroup.getSetting("_siteseerNews")+"' "
                +" _group-detail-url='"+_groupDetailUrl+"' "
                +" _reports-list-url='"+_reportsListUrl+"' "
                +" _alert-list-url='"+_alertListUrl+"' "
                +" _log-url='"+_logUrl+"' "
                + (httprequest.actionAllowed("_preference") ? " _preference_allowed ":" ")
                +" _user-real-name='"+_userRealName+"' "
                +" _user-email='"+_userEmail+"' "
                +" _outage-email='"+_outageEmail+"' "
                +" _time-zone-name='"+_timeZoneName+"' "
                +" _user-login-name='"+_userLoginName+"' "
                +" _user-login-password='"+_userLoginPassword+"' "
                +" _form-select-option='"+_formSelectOption+"' "
                + (flag ? " _flag ":" ")
                +" _partner-support-html='"+_partnerSupportHTML+"' "
                +" _partner-main-footer-html='"+_partnerMainFooterHTML+"' "
                +" _monitor-edit-type='"+_monitorEditType+"' "
                +" _advice-info-one='"+_adviceInfoOne+"' "
                +" _advice-info-two='"+_adviceInfoTwo+"' "
                +" _maximum-monitors='"+_maximumMonitors+"' "
                +" _maximum-reports-count='"+_maximumReportsCount+"' "
                +" _seconds-str='"+_secondsStr+"' "
                +" _more-info='"+_moreInfo+"' "
                +""
                +"></account-prefs-page-form>");
        com.dragonflow.Page.accountPrefsPage.printFooter(printwriter, httprequest);
    }

}

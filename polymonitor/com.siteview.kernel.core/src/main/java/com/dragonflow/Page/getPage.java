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

import java.util.Enumeration;

import jgl.Array;
import jgl.HashMap;

import com.dragonflow.HTTP.HTTPRequestException;
import com.dragonflow.SiteView.AtomicMonitor;
import com.dragonflow.SiteView.Monitor;
import com.dragonflow.SiteView.Platform;
import com.dragonflow.SiteView.SiteViewGroup;
import com.dragonflow.StandardMonitor.URLLoader;
import com.dragonflow.Utils.URLInfo;

// Referenced classes of package com.dragonflow.Page:
// CGI

public class getPage extends com.dragonflow.Page.CGI
{

    static final boolean $assertionsDisabled; /* synthetic field */

    public getPage()
    {
    }

    public void printBody()
        throws java.lang.Exception
    {
        if(!request.actionAllowed("_tools"))
        {
            throw new HTTPRequestException(557);
        }
        String s = com.dragonflow.HTTP.HTTPRequest.decodeString(request.getValue("group"));
        String s1 = com.dragonflow.Utils.I18N.UnicodeToString(s, com.dragonflow.Utils.I18N.nullEncoding());
        s1 = com.dragonflow.Utils.I18N.StringToUnicode(s1, "");
        String s2 = request.getValue("id");
        String s3 = "";
        String s4 = "";
        String s5 = "";
        String s6 = "";
        String s7 = "";
        String s8 = "";
        String s9 = "";
        String s10 = "";
        String s11 = "";
        String s12 = "";
        String s13 = com.dragonflow.Utils.I18N.getDefaultEncoding();
        Enumeration enumeration = null;
        boolean flag = false;
        boolean flag1 = false;
        StringBuffer stringbuffer = new StringBuffer();
        StringBuffer stringbuffer1 = new StringBuffer();
        StringBuffer stringbuffer2 = new StringBuffer();
        StringBuffer stringbuffer3 = new StringBuffer();
        if(request.isPost())
        {
            s3 = request.getValue("host");
            s4 = request.getValue("location");
            s13 = request.getValue("URLEncoding");
            if(s13.length() == 0)
            {
                s13 = com.dragonflow.Utils.I18N.getDefaultEncoding();
            }
            s5 = request.getValue("match");
            s6 = request.getValue("errorMatch");
            s7 = request.getValue("user");
            s8 = com.dragonflow.Properties.StringProperty.getPrivate(request, "_password", "getSuff", stringbuffer, stringbuffer1);
            s9 = request.getValue("domain");
            s10 = request.getValue("proxy");
            s11 = request.getValue("proxyUser");
            s12 = com.dragonflow.Properties.StringProperty.getPrivate(request, "_proxypassword", "pgetSuff", stringbuffer2, stringbuffer3);
            enumeration = request.getValues("postData");
            flag = request.getValue("getFrames").length() > 0;
            flag1 = request.getValue("getImages").length() > 0;
        } else
        if(s1.length() > 0)
        {
            jgl.Array array = ReadGroupFrames(s1);
            com.dragonflow.SiteView.AtomicMonitor atomicmonitor = AtomicMonitor.MonitorCreate(array, s2, request.getPortalServer());
            s3 = atomicmonitor.getValue("_url");
            s4 = atomicmonitor.getValue("_location");
            s13 = atomicmonitor.getValue("_URLEncoding");
            s5 = atomicmonitor.getValue("_content");
            s6 = atomicmonitor.getValue("_errorContent");
            s7 = atomicmonitor.getValue("_username");
            s8 = com.dragonflow.Properties.StringProperty.getPrivate(atomicmonitor, "_password", "getSuff", stringbuffer, stringbuffer1);
            s9 = atomicmonitor.getValue("_domain");
            s10 = atomicmonitor.getValue("_proxy");
            s11 = atomicmonitor.getValue("_proxyusername");
            s12 = com.dragonflow.Properties.StringProperty.getPrivate(atomicmonitor, "_proxypassword", "pgetSuff", stringbuffer2, stringbuffer3);
            enumeration = atomicmonitor.getMultipleSettings("_postData");
            flag = atomicmonitor.getValue("getFrames").length() > 0;
            flag1 = atomicmonitor.getValue("getImages").length() > 0;
        } else
        {
            s8 = com.dragonflow.Properties.StringProperty.getPrivate(request, "_password", "getSuff", stringbuffer, stringbuffer1);
            s12 = com.dragonflow.Properties.StringProperty.getPrivate(request, "_proxypassword", "pgetSuff", stringbuffer2, stringbuffer3);
        }
        String s14 = "";
        String s15 = "";
        if(s4.length() > 0)
        {
            s14 = com.dragonflow.Utils.HTTPUtils.getLocationURLByID(s4);
            s15 = com.dragonflow.Utils.HTTPUtils.getLocationNameByID(s4);
        }
        if(s15.length() != 0)
        {
            s15 = ", from " + s15;
        }
        String s16 = "";
        if(s3.length() > 0)
        {
            com.dragonflow.Utils.URLInfo urlinfo = new URLInfo(s3);
            s16 = urlinfo.getProtocol();
            if(s16.length() == 0)
            {
                s16 = "http://";
                s3 = s16 + s3;
            } else
            {
                s16 = s16 + "://";
            }
        }
        printBodyHeader("Get URL and URL Content");
        if(!request.getValue("AWRequest").equals("yes"))
        {
            printButtonBar("Url.htm", "");
        }
        String s17 = "";
        if(s3.length() > 0)
        {
            s17 = s3.substring(s16.length());
            int i = s17.indexOf(":");
            if(i >= 0)
            {
                s17 = s17.substring(0, i);
            }
            i = s17.indexOf("/");
            if(i >= 0)
            {
                s17 = s17.substring(0, i);
            }
        }
        String s18 = "";
        if(s4.length() != 0)
        {
            s18 = "&location=" + s4;
            for(s18 = s18.trim(); s18.indexOf(" ") >= 0; s18 = s18.substring(0, s18.indexOf(" ")) + s18.substring(s18.indexOf(" ") + 1)) { }
        }
        if(!request.getValue("AWRequest").equals("yes"))
        {
            outputStream.println("<center><b>Get URL and URL Content</b> | <a href=" + getPageLink("ping", "") + "&host=" + s17 + s18 + "&group=" + com.dragonflow.HTTP.HTTPRequest.encodeString(s1) + ">Ping</a>" + " | <a href=" + getPageLink("trace", "") + "&host=" + s17 + s18 + "&group=" + com.dragonflow.HTTP.HTTPRequest.encodeString(s1) + ">TraceRoute</a>" + "</center><P>");
        } else
        {
            outputStream.println("<center><b>Get URL and URL Content</b> | <a href=" + getPageLink("ping", "") + "&host=" + s17 + s18 + "&AWRequest=yes" + ">Ping</a>" + " | <a href=" + getPageLink("trace", "") + "&host=" + s17 + s18 + "&AWRequest=yes" + ">TraceRoute</a>" + " | " + "<a href="+CGI.getTenant(request.getURL())+"/SiteView/cgi/go.exe/SiteView?page=monitor&operation=Tools&account=" + request.getAccount() + "&AWRequest=yes>Diagnostic Tools</a>" + "</center><P>");
        }
        String s19 = flag ? "CHECKED" : "";
        String s20 = flag1 ? "CHECKED" : "";
        outputStream.println("<p>\n<CENTER><H2>Get URL and URL Content</H2></CENTER><P>\n<p>\n" + getPagePOST("get", "") + "Browsers display pages by sending requests to web servers (using the HTTP protocol).  The URL specifies which\n" + "server to contact and also which page on the server.\n" + "This form will send a request to a web server.  Enter the URL of the\n" + "page to receive, and optionally, the user name, password and/or proxy server\n" + "to use.\n" + "<p><TABLE BORDER=0>\n" + "<TR><TD ALIGN=RIGHT>URL:<TD><input type=text name=host value=\"" + s3 + "\" size=60><br>\n" + "<TR><TD ALIGN=RIGHT>Encoding Character Set:<TD><input type=text name=URLEncoding value=\"" + s13 + "\" size=60><br>\n" + "<TR><TD ALIGN=RIGHT>User Name:<TD><input type=text name=user value=\"" + s7 + "\" size=30><br>\n" + "<TR><TD ALIGN=RIGHT>Password:<TD>" + stringbuffer.toString() + " size=30><br>\n" + stringbuffer1.toString() + "<TR><TD ALIGN=RIGHT>Domain:<TD><input type=text name=domain value=\"" + s9 + "\" size=30><br>\n" + "<TR><TD ALIGN=RIGHT>Proxy:<TD><input type=text name=proxy value=\"" + s10 + "\" size=40><br>\n" + "<TR><TD ALIGN=RIGHT>Proxy User Name:<TD><input type=text name=proxyUser value=\"" + s11 + "\" size=30><br>\n" + "<TR><TD ALIGN=RIGHT>Proxy Password:<TD>" + stringbuffer2.toString() + " size=30><br>\n" + stringbuffer3.toString() + "<TR><TD ALIGN=RIGHT>Content Match:<TD><input type=text name=match value=\"" + com.dragonflow.Utils.I18N.escapeString(s5, s13) + "\" size=30><br>\n" + "<TR><TD ALIGN=RIGHT>Error Content Match:<TD><input type=text name=errorMatch value=\"" + com.dragonflow.Utils.I18N.escapeString(s6, s13) + "\" size=30><br>\n" + "<TR><TD ALIGN=RIGHT>Retrieve Frames:<TD><input type=checkbox name=getFrames " + s19 + " ><br>\n" + "<TR><TD ALIGN=RIGHT>Retrieve Images:<TD><input type=checkbox name=getImages " + s20 + " ><br>\n" + "<input type=hidden name=group value=" + s + ">\n" + "<input type=hidden name=id value=" + s2 + ">\n" + "</TABLE><p>\n");
        boolean flag2 = !isPortalServerRequest();
        try
        {
            java.lang.Class.forName("com.dragonflow.StandardMonitor.URLRemoteMonitor");
        }
        catch(java.lang.ClassNotFoundException classnotfoundexception)
        {
            flag2 = false;
        }
        if(flag2)
        {
            outputStream.print(com.dragonflow.Utils.HTTPUtils.locationsHTML(s4, request));
        }
        String s21 = "";
        Enumeration enumeration1 = request.getValues("postData");
        if(enumeration != null)
        {
            while(enumeration.hasMoreElements()) 
            {
                s21 = s21 + "<input type=hidden name=postData value=\"" + (String)enumeration.nextElement() + "\">\n";
            }
        }
        outputStream.println("<input type=submit value=\"Get URL\" class=\"VerBl8\">\n" + s21 + "</FORM>\n");
        outputStream.println("<P><A HREF=" + com.dragonflow.Page.CGI.getGroupDetailURL(request, s1) + ">Return to Group</A><p>\n");
        if(s3.length() > 0)
        {
            if(!isPortalServerRequest())
            {
                printContentStartComment();
                long l = System.currentTimeMillis();
                StringBuffer stringbuffer4 = null;
                StringBuffer stringbuffer5 = null;
                if(request.getValue("nodump").length() == 0)
                {
                    stringbuffer5 = new StringBuffer();
                    stringbuffer4 = new StringBuffer();
                }
                outputStream.println("Retrieving " + s3 + s15 + "...\n\n");
                outputStream.flush();
                String s23 = "";
                for(Enumeration enumeration2 = request.getValues("header"); enumeration2.hasMoreElements();)
                {
                    s23 = s23 + enumeration2.nextElement() + com.dragonflow.StandardMonitor.URLMonitor.CRLF;
                }

                jgl.HashMap hashmap = getMasterConfig();
                long l1 = -1L;
                if(com.dragonflow.Page.getPage.getValue(hashmap, "_urlContentMatchMax").length() > 0)
                {
                    l1 = com.dragonflow.Utils.TextUtils.toLong(com.dragonflow.Page.getPage.getValue(hashmap, "_urlContentMatchMax"));
                }
                if(l1 < 1L)
                {
                    l1 = 50000L;
                }
                jgl.Array array1 = com.dragonflow.Utils.TextUtils.enumToArray(enumeration1);
                com.dragonflow.SiteView.SiteViewGroup siteviewgroup = SiteViewGroup.currentSiteView();
                String s24 = "" + s1 + "/" + request.getValue("id");
                com.dragonflow.SiteView.Monitor monitor = (com.dragonflow.SiteView.Monitor)siteviewgroup.getElement(s24);
                StringBuffer stringbuffer6 = new StringBuffer(s3);
                com.dragonflow.Utils.SocketSession socketsession = com.dragonflow.Utils.SocketSession.getSession(monitor);
                if(monitor != null && (monitor instanceof com.dragonflow.StandardMonitor.URLMonitor))
                {
                    l1 = monitor.getSettingAsLong("_urlContentMatchMax", 50000);
                }
                socketsession.setDomain(s9);
                long al[] = null;
                jgl.Array array2 = Platform.split(',', s10);
                String s25 = "";
                if(array2.size() <= 1)
                {
                    al = com.dragonflow.StandardMonitor.URLMonitor.checkURL(socketsession, s3, s13, com.dragonflow.Utils.I18N.UnicodeToString(s5, com.dragonflow.Utils.I18N.nullEncoding()), com.dragonflow.Utils.I18N.UnicodeToString(s6, com.dragonflow.Utils.I18N.nullEncoding()), s10, s11, s12, array1, s7, s8, s14, stringbuffer4, l1, s23, 0, 0x1d4c0, stringbuffer6, stringbuffer5);
                } else
                {
                    Enumeration enumeration3 = array2.elements();
                    do
                    {
                        if(!enumeration3.hasMoreElements())
                        {
                            break;
                        }
                        s25 = (String)enumeration3.nextElement();
                        al = com.dragonflow.StandardMonitor.URLMonitor.checkURL(socketsession, s3, s13, com.dragonflow.Utils.I18N.UnicodeToString(s5, com.dragonflow.Utils.I18N.nullEncoding()), com.dragonflow.Utils.I18N.UnicodeToString(s6, com.dragonflow.Utils.I18N.nullEncoding()), s10, s11, s12, array1, s7, s8, s14, stringbuffer4, l1, s23, 0, 0x1d4c0, stringbuffer6, stringbuffer5);
                    } while(com.dragonflow.StandardMonitor.URLMonitor.shouldTryNextProxy(al[0]));
                }
                String s26 = stringbuffer6.toString();
                String s27 = "";
                String s28 = "";
                String s29 = "";
                if(al[0] == 200L && (flag || flag1))
                {
                    jgl.HashMap hashmap1 = new HashMap();
                    int j = com.dragonflow.Utils.TextUtils.toInt(com.dragonflow.Page.getPage.getValue(hashmap, "_urlLoadThreads"));
                    if(j == 0)
                    {
                        j = 1;
                    }
                    String s34 = s23;
                    if(s34.length() > 0 && !s34.endsWith(com.dragonflow.StandardMonitor.URLMonitor.CRLF))
                    {
                        s34 = s34 + com.dragonflow.StandardMonitor.URLMonitor.CRLF;
                    }
                    if(array1 != null)
                    {
                        Enumeration enumeration4 = array1.elements();
                        do
                        {
                            if(!enumeration4.hasMoreElements())
                            {
                                break;
                            }
                            String s37 = (String)enumeration4.nextElement();
                            if(com.dragonflow.Utils.TextUtils.startsWithIgnoreCase(s37, com.dragonflow.StandardMonitor.URLMonitor.CUSTOM_HEADER))
                            {
                                s34 = s34 + s37.substring(com.dragonflow.StandardMonitor.URLMonitor.CUSTOM_HEADER.length()) + com.dragonflow.StandardMonitor.URLMonitor.CRLF;
                            }
                        } while(true);
                    }
                    com.dragonflow.StandardMonitor.URLLoader urlloader = new URLLoader(null, socketsession, hashmap1, j, flag, flag1, s26, s7, s8, s34, s14, l1, stringbuffer4, 0x1d4c0, s10, s11, s12, outputStream);
                    urlloader.waitForCompletion();
                    StringBuffer stringbuffer7 = new StringBuffer();
                    StringBuffer stringbuffer8 = new StringBuffer();
                    StringBuffer stringbuffer9 = new StringBuffer();
                    urlloader.getSummary(stringbuffer7, stringbuffer8, stringbuffer9);
                    if(flag1)
                    {
                        s27 = "<P>" + stringbuffer7.toString();
                    }
                    if(flag)
                    {
                        s28 = "<P>" + stringbuffer8.toString();
                        s29 = stringbuffer9.toString();
                    }
                }
                socketsession.close();
                String s30 = stringbuffer5.toString();
                String s31 = com.dragonflow.StandardMonitor.URLMonitor.getHTMLEncoding(s30);
                String s35 = com.dragonflow.Utils.I18N.escapeString(s30, s13);
                String s36 = stringbuffer4.toString();
                long l2 = al[0];
                String s38 = com.dragonflow.StandardMonitor.URLMonitor.lookupStatus(l2);
                if(s25.length() != 0)
                {
                    s38 = s38 + ", used proxy " + s25;
                }
                long l3 = System.currentTimeMillis() - l;
                String s39 = com.dragonflow.Utils.TextUtils.floatToString((float)l3 / 1000F, 2) + " seconds";
                jgl.Array array3 = new Array();
                int k = com.dragonflow.Utils.TextUtils.matchExpression(s36, s5, array3);
                if(k != Monitor.kURLok && com.dragonflow.Utils.I18N.hasUnicode(s5))
                {
                    String s32 = com.dragonflow.StandardMonitor.URLMonitor.getHTMLEncoding(s36);
                    int i1 = com.dragonflow.Utils.TextUtils.matchExpression(s36, com.dragonflow.Utils.I18N.UnicodeToString(s5, s32), array3);
                }
                jgl.Array array4 = new Array();
                int k1 = com.dragonflow.Utils.TextUtils.matchExpression(s36, s6, array4);
                if(k1 != Monitor.kURLok && com.dragonflow.Utils.I18N.hasUnicode(s5))
                {
                    String s33 = com.dragonflow.StandardMonitor.URLMonitor.getHTMLEncoding(s36);
                    int j1 = com.dragonflow.Utils.TextUtils.matchExpression(s36, com.dragonflow.Utils.I18N.UnicodeToString(s6, s33), array3);
                }
                outputStream.print("<P>Result: <B>" + s38 + "</B><P>\n");
                if(!$assertionsDisabled && al.length <= 10)
                {
                    throw new AssertionError("results array too small.");
                }
                if(al[10] > 0L)
                {
                    outputStream.println("<B>WARNING: " + com.dragonflow.StandardMonitor.URLMonitor.getURLContentMatchMaxTruncateError(al[10]) + "</B><P>\n");
                }
                outputStream.print("URL: <B>" + stringbuffer6 + "</B><BR>\n" + "Total time: <B>" + s39 + "</B><BR>\n" + "<!--URLSTATUS=" + l2 + "-->\n");
                outputStream.print("<p>Content Match Results:");
                for(int i2 = 0; i2 < array3.size(); i2++)
                {
                    String s40 = com.dragonflow.Utils.I18N.escapeString((String)array3.at(i2), s13);
                    if(i2 == 0)
                    {
                        outputStream.print("<br>&nbsp;&nbsp;Matched: <b>" + s40 + " </b>");
                        continue;
                    }
                    if(i2 == 1)
                    {
                        outputStream.print("<br>&nbsp;&nbsp;value: <b>" + s40 + " </b>");
                    } else
                    {
                        outputStream.print("<br>&nbsp;&nbsp;value" + i2 + ": <b>" + s40 + " </b>");
                    }
                }

                outputStream.print("<p>Error Content Match Results:");
                for(int j2 = 0; j2 < array4.size(); j2++)
                {
                    String s41 = com.dragonflow.Utils.I18N.escapeString((String)array4.at(j2), s13);
                    if(j2 == 0)
                    {
                        outputStream.print("<br>&nbsp;&nbsp;Matched: <b>" + s41 + " </b>");
                        continue;
                    }
                    if(j2 == 1)
                    {
                        outputStream.print("<br>&nbsp;&nbsp;value: <b>" + s41 + " </b>");
                    } else
                    {
                        outputStream.print("<br>&nbsp;&nbsp;value" + j2 + ": <b>" + s41 + " </b>");
                    }
                }

                outputStream.print("<br>\n");
                outputStream.println(s28);
                outputStream.println(s27);
                if(stringbuffer5 != null)
                {
                    outputStream.print("<HR><PRE>" + s35 + "</PRE></HR>");
                }
                outputStream.print(s29);
                printContentEndComment();
            } else
            {
                com.dragonflow.SiteView.PortalSiteView portalsiteview = (com.dragonflow.SiteView.PortalSiteView)getSiteView();
                if(portalsiteview != null)
                {
                    String s22 = portalsiteview.getURLContentsFromRemoteSiteView(request, "_centrascopeToolMatch");
                    outputStream.println(s22);
                }
            }
        }
        if(!request.getValue("AWRequest").equals("yes"))
        {
            printFooter(outputStream);
        } else
        {
            outputStream.println("</BODY>");
        }
    }

    public static void main(String args[])
        throws java.io.IOException
    {
        com.dragonflow.Page.getPage getpage = new getPage();
        if(args.length > 0)
        {
            getpage.args = args;
        }
        getpage.handleRequest();
    }

    static 
    {
        $assertionsDisabled = !(com.dragonflow.Page.getPage.class).desiredAssertionStatus();
    }
}

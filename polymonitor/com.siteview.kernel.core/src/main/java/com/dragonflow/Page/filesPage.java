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
import java.util.Date;

import com.dragonflow.SiteView.Platform;

// Referenced classes of package com.dragonflow.Page:
// CGI

public class filesPage extends com.dragonflow.Page.CGI
{

    public filesPage()
    {
    }

    void doSecure()
    {
        printRefreshHeader("", CGI.getTenant(request.getURL())+"/SiteView/cgi/go.exe/SiteView?page=files", 1);
        String s = request.getValue("operation");
        outputStream.println("<b>Processing (" + s + ")......</b><p>\n");
        outputStream.flush();
        StringBuffer stringbuffer = new StringBuffer();
        try
        {
            if(s.equals("demangle"))
            {
                com.dragonflow.Properties.FrameFile.setMangle(false, stringbuffer);
            } else
            {
                com.dragonflow.Properties.FrameFile.setMangle(true, stringbuffer);
            }
        }
        catch(java.lang.Exception exception)
        {
            outputStream.println("<HR>Error: " + exception + "<hr>");
        }
        outputStream.println("<pre>" + stringbuffer + "<pre>");
        outputStream.flush();
        outputStream.println("</BODY>\n");
    }

    public void printBody()
    {
        if(!request.getAccount().equals("administrator"))
        {
            outputStream.println("<hr>Administrator access only<hr>");
            return;
        }
        String s = request.getValue("operation");
        if(s.length() > 0)
        {
            doSecure();
        } else
        {
            printBodyHeader("Files");
            outputStream.println("<CENTER><H2>Files</H2></CENTER><P><FORM ACTION=/SiteView/cgi/go.exe/SiteView method=POST><input type=hidden name=page value=\"files\"><input type=hidden name=account value=\"administrator\">\n");
            String s1 = com.dragonflow.Properties.FrameFile.safetyChecks();
            if(s1.length() > 0)
            {
                outputStream.println("<hr> ERROR: " + s1 + "<hr>");
            }
            outputStream.println("<TABLE border=1 cellspacing=0><TR><TH>File<TH>Status<TH>Size<TH>Modified");
            java.io.File file = new File(com.dragonflow.SiteView.Platform.getRoot() + java.io.File.separator + "groups");
            String as[] = file.list();
            for(int i = 0; i < as.length; i++)
            {
                String s2 = as[i];
                if(!com.dragonflow.Properties.FrameFile.isConfig(s2))
                {
                    continue;
                }
                String s3 = Platform.getRoot() + java.io.File.separator + "groups" + java.io.File.separator + s2;
                java.io.File file1 = new File(s3);
                long l = file1.length();
                String s4 = "" + new Date(file1.lastModified());
                String s5;
                try
                {
                    com.dragonflow.Properties.FrameFile.readFromFile(s3);
                    if(com.dragonflow.Properties.FrameFile.forceMangleOnRead)
                    {
                        s5 = "encrypted";
                    } else
                    {
                        s5 = "plaintext";
                    }
                }
                catch(java.lang.Exception exception)
                {
                    s5 = "ERROR: " + exception;
                }
                outputStream.println("<TR><TD>" + s2 + "<td>" + s5 + "<td>" + l + "<td>" + s4);
            }

            outputStream.println("</TABLE");
            outputStream.println("<P><input type=submit name=operation value=\"Enable\"> file encryption");
            outputStream.println("</FORM>");
            printFooter(outputStream);
        }
    }

    public static void main(String args[])
        throws java.io.IOException
    {
        (new filesPage()).handleRequest();
    }
}

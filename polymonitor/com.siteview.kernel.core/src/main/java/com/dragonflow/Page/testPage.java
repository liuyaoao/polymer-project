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
import java.util.Properties;

import jgl.Array;
import jgl.HashMap;

import com.dragonflow.SiteView.Platform;
import com.dragonflow.SiteView.SiteViewGroup;

// Referenced classes of package com.dragonflow.Page:
// CGI, testAction

public class testPage extends com.dragonflow.Page.CGI {

    public testPage() {
    }

    public void printBody() {
        outputStream.println("<pre>");
        try {
            StringBuffer stringbuffer = com.dragonflow.Utils.FileUtils
                    .readFile("f:/www/htdocs/siteseer_legal_agreement.htm");
            jgl.Array array = Platform.split('\n',
                    stringbuffer.toString());
            String s1;
            for (Enumeration enumeration1 = array.elements(); enumeration1
                    .hasMoreElements(); outputStream.println("+\"" + s1.trim()
                    + "\"")) {
                s1 = (String) enumeration1.nextElement();
                s1 = com.dragonflow.Utils.TextUtils.replaceChar(s1, '"', "\\\"");
            }

        } catch (java.lang.Exception exception) {
        }
        outputStream.println("root="
                + com.dragonflow.SiteView.Platform.getRoot());
        java.util.Properties properties = new Properties(java.lang.System
                .getProperties());
        properties.list(outputStream);
        outputStream.flush();
        for (Enumeration enumeration = request.getVariables(); enumeration
                .hasMoreElements();) {
            String s = (String) enumeration.nextElement();
            Enumeration enumeration2 = request.getValues(s);
            while (enumeration2.hasMoreElements()) {
                outputStream.println(s + "=" + enumeration2.nextElement());
            }
        }

        outputStream.println("</pre>");
        if (request.getValue("schedulerTest").length() > 0) {
            com.dragonflow.SiteView.SiteViewGroup siteviewgroup = SiteViewGroup
                    .currentSiteView();
            com.dragonflow.Page.testAction testaction = new testAction();
            siteviewgroup.monitorScheduler.scheduleRepeatedPeriodicAction(
                    testaction, 1L, 1L);
            jgl.Array array1 = new Array();
            jgl.Array array2 = new Array();
            jgl.Array array3 = new Array();
            while (true) {
                siteviewgroup.adjustGroups(array1, array2, array3,
                        new HashMap());
            } 
        } else {
            return;
        }
    }
}

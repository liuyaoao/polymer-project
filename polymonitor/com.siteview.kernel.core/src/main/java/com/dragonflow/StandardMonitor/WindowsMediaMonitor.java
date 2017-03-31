/*
 * 
 * Created on 2014-3-7 1:20:16
 *
 * WindowsMediaMonitor.java
 *
 * History:
 *
 */
package com.dragonflow.StandardMonitor;

/**
 * Comment for <code>WindowsMediaMonitor</code>
 * 
 * @author 
 * @version 0.0
 *
 *
 */

import com.dragonflow.HTTP.HTTPRequest;
import com.dragonflow.Properties.StringProperty;
import com.dragonflow.SiteView.*;
import java.net.URLEncoder;
import jgl.HashMap;

public class WindowsMediaMonitor extends NTCounterBase
{

    public static String counterObjects;
    public static String returnURL;
    private static StringProperty pCounters;

    public WindowsMediaMonitor()
    {
    }

    public String getCountersContent()
    {
        String s = getProperty(pCounters);
        return s;
    }

    public void setCountersContent(String s)
    {
        setProperty(pCounters, s);
    }

    public StringProperty getCountersProperty()
    {
        return pCounters;
    }

    public String getCounterObjects()
    {
        String s1 = getSetting("_counterObjectsWindowsMediaMonitor");
        String s;
        if(s1 == "")
        {
            s = counterObjects;
        } else
        {
            s = s1;
        }
        return s;
    }

    public String getReturnURL()
    {
        return HTTPRequest.encodeString(returnURL);
    }

    public String getDefaultInstance()
    {
        String s1 = getSetting("_counterInstanceWindowsMediaMonitor");
        String s;
        if(s1 == "")
        {
            s = "SINGLE";
        } else
        {
            s = s1;
        }
        return s;
    }

    public String getDefaultCounters()
    {
        return "Windows Media Unicast Service -- Stream Errors -- SINGLE,Windows Media Unicast Service -- Late Reads -- SINGLE,Windows Media Unicast Service -- Connection Rate -- SINGLE,Windows Media Unicast Service -- Aggregate Send Rate -- SINGLE,Windows Media Unicast Service -- Aggregate Read Rate -- SINGLE,Windows Media Unicast Service -- Streams -- SINGLE,Windows Media Unicast Service -- Stations -- SINGLE,Windows Media Unicast Service -- Pending Connections -- SINGLE,Windows Media Unicast Service -- Active Streams -- SINGLE,Windows Media Unicast Service -- Active TCP Streams -- SINGLE";
    }

    protected String getTestMachine()
    {
        return "\\\\TESTWIN2K9.qa.dragonflow.com";
    }

    public String verify(StringProperty stringproperty, String s, HTTPRequest httprequest, HashMap hashmap)
    {
        if(stringproperty == pCounters)
        {
            if(s.equals("No Counters available for this machine"))
            {
                hashmap.put(stringproperty, stringproperty.getLabel() + " missing");
            }
            return s;
        } else
        {
            return super.verify(stringproperty, s, httprequest, hashmap);
        }
    }

    static 
    {
        counterObjects = "Windows Media Station Service,Windows Media Unicast Service";
        returnURL = "/SiteView/cgi/go.exe/SiteView/?page=monitor&class=WindowsMediaMonitor";
        pCounters = new StringProperty("_counters", "", "Selected Counters");
        pCounters.setDisplayText("Counters", "the current selection of counters</TD></TR><TR><TD></TD><TD><A HREF=\"/SiteView/cgi/go.exe/SiteView/?page=counter&returnURL=" + URLEncoder.encode(returnURL) + "&maxcounters=" + nMaxCounters + "&counterobjects=" + counterObjects + "&type=NTCounter\">choose counters</A>");
        pCounters.setParameterOptions(false, true, 1, false);
        pCounters.isMultiLine = true;
        StringProperty astringproperty[] = {
            pCounters
        };
        addProperties("com.dragonflow.StandardMonitor.WindowsMediaMonitor", astringproperty);
        addClassElement("com.dragonflow.StandardMonitor.WindowsMediaMonitor", Rule.stringToClassifier("value0 == n/a\terror", true));
        addClassElement("com.dragonflow.StandardMonitor.WindowsMediaMonitor", Rule.stringToClassifier("always\tgood"));
        setClassProperty("com.dragonflow.StandardMonitor.WindowsMediaMonitor", "description", "Monitors Microsoft Windows Media Server performance metrics.");
        setClassProperty("com.dragonflow.StandardMonitor.WindowsMediaMonitor", "help", "WinMediaServMon.htm");
        setClassProperty("com.dragonflow.StandardMonitor.WindowsMediaMonitor", "title", "Windows Media Server");
        setClassProperty("com.dragonflow.StandardMonitor.WindowsMediaMonitor", "class", "WindowsMediaMonitor");
        setClassProperty("com.dragonflow.StandardMonitor.WindowsMediaMonitor", "target", "_serverName");
        setClassProperty("com.dragonflow.StandardMonitor.WindowsMediaMonitor", "topazName", "MS Winodws Media Server");
        setClassProperty("com.dragonflow.StandardMonitor.WindowsMediaMonitor", "topazType", "Streaming Media");
        setClassProperty("com.dragonflow.StandardMonitor.WindowsMediaMonitor", "classType", "application");
        setClassProperty("com.dragonflow.StandardMonitor.WindowsMediaMonitor", "topazType", "Application Server");
        setClassProperty("com.dragonflow.StandardMonitor.WindowsMediaMonitor", "applicationType", "NTCounter");
        if(!Platform.isWindows())
        {
            setClassProperty("com.dragonflow.StandardMonitor.WindowsMediaMonitor", "loadable", "false");
        }
    }
}

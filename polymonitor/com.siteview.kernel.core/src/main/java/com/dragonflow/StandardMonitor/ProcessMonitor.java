
package com.dragonflow.StandardMonitor;

/**
 * Comment for <code>ServiceMonitor</code>
 * 
 * @author lihua.zhong
 * @version 0.0
 *
 *
 */

import java.net.URLEncoder;
import java.util.Enumeration;
import java.util.Vector;

import jgl.Array;
import jgl.HashMap;
import com.dragonflow.HTTP.HTTPRequest;
import com.dragonflow.Log.LogManager;
import com.dragonflow.Page.CGI;
import com.dragonflow.Properties.BooleanProperty;
import com.dragonflow.Properties.NumericProperty;
import com.dragonflow.Properties.ScalarProperty;
import com.dragonflow.Properties.StringProperty;
import com.dragonflow.SiteView.Machine;
import com.dragonflow.SiteView.Platform;
import com.dragonflow.SiteView.Rule;
import com.dragonflow.SiteView.ServerMonitor;
import com.dragonflow.SiteViewException.SiteViewException;
import com.dragonflow.Utils.TextUtils;

public class ProcessMonitor extends ServerMonitor
{

    static ScalarProperty pProcessName;
    static ScalarProperty pUnixServiceName;
//    static StringProperty pProcessName;
    static BooleanProperty pCheckMemory;
    static StringProperty pStatus;
    static StringProperty pProcessCPU;
    static StringProperty pProcessMemory;
    static StringProperty pUnixProcessMemory;
    static StringProperty pProcessCount;
    static StringProperty pLastMeasurement;
    static StringProperty pLastMeasurementTime;
    static final String userProcessName = "(using Process Name)";

    public ProcessMonitor()
    {
    }

    String processError(long l)
    {
        if(!isKnownStatus(l))
        {
            return "not found (" + l + ")";
        } else
        {
            return "not found (remote monitoring error - " + lookupStatus(l) + ")";
        }
    }

    public String getTestURL()
    {
        String s = URLEncoder.encode(getProperty(pMachineName));
        String s1 = "/SiteView/cgi/go.exe/SiteView?page=service&machine=" + s;
        return s1;
    }

    StringProperty getProcessMemoryProperty()
    {
        return Platform.isWindows(getPlatform()) ? pProcessMemory : pUnixProcessMemory;
    }

    protected boolean update()
    {
        String processname =getProperty(pProcessName.toString());
        String machine = getProperty(pMachineName);
        String statustrng="";
        double[] al=new double[3];//al[0]ͬ���̵�������al[1]cpu��al[2]�ڴ�
        try {
			al=Platform.getprocessesful(al, machine, processname);
		} catch (SiteViewException e) {
			e.printStackTrace();
		}
        if(stillActive())
        {
            synchronized(this)
            {
                if(Platform.isWindows(getPlatform()))
                {
                	if(al[0]<=0){
                		statustrng="status=stop, \u8FDB\u7A0B\u6570=0, \u5360\u7528cpu=n/a, \u5360\u7528\u5185\u5B58=n/a";
                		 setProperty("status", "stop");
                		 setProperty(pProcessCount, "0");
                		 setProperty(pProcessMemory, "n/a");
                		 setProperty(pProcessCPU, "n/a");
                	}else{
                		statustrng="status=running, \u8FDB\u7A0B\u6570="+al[0]+", \u5360\u7528cpu="+al[1]+", \u5360\u7528\u5185\u5B58="+al[2];
                		setProperty("status", "running");
                		 setProperty(pProcessCount, al[0]);
               		 	setProperty(pProcessCPU, al[1]);
               		 	setProperty(pProcessMemory, al[2]);
                	}
                }else{
                	if(al[0]<=0){
                		statustrng="status=stop, \u8FDB\u7A0B\u6570=0, \u5360\u7528cpu=n/a, \u5360\u7528\u5185\u5B58=n/a";
               		 setProperty("status", "stop");
               		 setProperty(pProcessCount, "0");
               		 setProperty(pProcessMemory, "n/a");
               		 setProperty(pProcessCPU, "n/a");
                	}else{
                		setProperty("status", "running");
                		setProperty(pProcessCount, al[0]);
              		 	setProperty(pProcessCPU, al[1]);
              		 	setProperty(pProcessMemory, al[2]);
              		 	statustrng="status=running, \u8FDB\u7A0B\u6570="+al[0]+", \u5360\u7528cpu="+al[1]+", \u5360\u7528\u5185\u5B58="+al[2];
                	}
                }
                setProperty(pStateString, statustrng);
            }
        }
        return true;
    }

    public Enumeration getStatePropertyObjects(boolean flag)
    {
        Enumeration enumeration = super.getStatePropertyObjects(flag);
        Array array = new Array();
        do
        {
            if(!enumeration.hasMoreElements())
            {
                break;
            }
            StringProperty stringproperty = (StringProperty)enumeration.nextElement();
            if(stringproperty == pProcessCPU)
            {
                if(getProperty(pProcessName).length() > 0)
                {
                    array.add(stringproperty);
                }
            } else
            if(stringproperty == pProcessMemory || stringproperty == pUnixProcessMemory)
            {
                if(getProperty(pProcessName).length() > 0)
                {
                    array.add(stringproperty);
                } else
                if(getPropertyAsBoolean(pCheckMemory))
                {
                    array.add(stringproperty);
                }
            } else
            {
                array.add(stringproperty);
            }
        } while(true);
        return array.elements();
    }

    public Array getLogProperties()
    {
        Array array = super.getLogProperties();
        array.add(pStatus);
        array.add(pProcessCount);
        array.add(pProcessCPU);
        array.add(getProcessMemoryProperty());
        return array;
    }

    public Vector getScalarValues(ScalarProperty scalarproperty, HTTPRequest httprequest, CGI cgi)
        throws SiteViewException
    {
        if(scalarproperty == pProcessName || scalarproperty == pUnixServiceName)
        {
            Array array = Platform.getProcesses(Machine.getFullMachineID(getProperty(pMachineName), httprequest), true);
            Enumeration enumeration = array.elements();
            Vector vector = new Vector();
            String s;
            for(; enumeration.hasMoreElements(); vector.addElement(s))
            {
                s = (String)enumeration.nextElement();
                vector.addElement(s);
            }

            if(Platform.isWindows())
            {
                vector.addElement("(using Process Name)");
                vector.addElement("(using Process Name)");
            }
            return vector;
        } else
        {
            return super.getScalarValues(scalarproperty, httprequest, cgi);
        }
    }

    public String defaultTitle()
    {
        String s = super.defaultTitle();
        if(Platform.isWindows())
        {
            String s1 = getProperty(pProcessName);
            if(s1.length() > 0)
            {
                s = "Process: " + s1;
            }
        }
        return s;
    }

    public String verify(StringProperty stringproperty, String s, HTTPRequest httprequest, HashMap hashmap)
    {
        if(Platform.isWindows(getPlatform()) && stringproperty == pProcessName)
        {
            if(s.length() > 0)
            {
                setProperty(pProcessName, "(using Process Name)");
                String s1 = s.toLowerCase();
                if(s1.endsWith(".exe"))
                {
                    s = s.substring(0, s.length() - 4);
                }
            } else
            if(getProperty(pProcessName).equals("(using Process Name)"))
            {
                setProperty(pProcessName, "none");
            }
            return s;
        }
        if(stringproperty == pCheckMemory)
        {
            if(s.length() != 0)
            {
                String s2 = getProperty(pMachineName);
                if(Machine.getCommandString("serviceMonitor", s2).length() > 0)
                {
                    return s;
                }
                String s3 = getProperty(pUnixServiceName);
                int i = s3.indexOf(' ');
                if(i != -1)
                {
                    s3 = s3.substring(0, i);
                }
                int j = s3.lastIndexOf('/');
                if(j != -1)
                {
                    s3 = s3.substring(j + 1);
                }
                if(Machine.getOSName(s2).indexOf("HP") >= 0 && s3.length() > 14)
                {
                    s3 = s3.substring(0, 14);
                }
                setProperty(pUnixServiceName, s3);
            }
            return s;
        } else
        {
            return super.verify(stringproperty, s, httprequest, hashmap);
        }
    }

    static 
    {
    	pProcessName = new ScalarProperty("_process", true);
    	pProcessName.setWindowsPlatforms();
    	pProcessName.setDisplayText("Service", "the NT service to monitor");
    	pProcessName.setParameterOptions(true, 1, false);
    	pProcessName.allowOther = true;
        pUnixServiceName = new ScalarProperty("_process", true);
        pUnixServiceName.setUnixPlatforms();
        pUnixServiceName.setDisplayText("Process", "the process to monitor");
        pUnixServiceName.setParameterOptions(true, 1, false);
        pUnixServiceName.allowOther = true;
//        pProcessName = new StringProperty("_process");
//        pProcessName.setWindowsPlatforms();
//        pProcessName.setParameterOptions(true, 2, true);
//        pProcessName.setDisplayText("Process Name", "optional process name for process count and cpu usage (example: httpd); use a string or a <a href=/SiteView/docs/regexp.htm>regular expression</a>");
        pCheckMemory = new BooleanProperty("_checkMemory", "");
        pCheckMemory.setUnixPlatforms();
        pCheckMemory.setDisplayText("Measure Process Memory Use", "when selected, measure amount of virtual memory used by process");
        pCheckMemory.setParameterOptions(true, 6, true);
        pStatus = new StringProperty("status", "no data");
        pStatus.setStateOptions(1);
        pStatus.setIsThreshold(true);
        pProcessCPU = new NumericProperty("processCPU", "0", "%");
        pProcessCPU.setWindowsPlatforms();
        pProcessCPU.setLabel("cpu");
        pProcessCPU.setStateOptions(2);
        pProcessMemory = new NumericProperty("processMemory", "0", "bytes");
        pProcessMemory.setWindowsPlatforms();
        pProcessMemory.setLabel("memory");
        pProcessMemory.setStateOptions(3);
        pUnixProcessMemory = new NumericProperty("processMemory", "0", "bytes");
        pUnixProcessMemory.setUnixPlatforms();
        pUnixProcessMemory.setLabel("memory");
        pUnixProcessMemory.setIsThreshold(true);
        pUnixProcessMemory.setStateOptions(3);
        pProcessCount = new NumericProperty("processCount", "0", "processes");
        pProcessCount.setLabel("processes");
        pProcessCount.setIsThreshold(true);
        pProcessCount.setStateOptions(4);
        pLastMeasurement = new NumericProperty("lastMeasurement");
        pLastMeasurementTime = new NumericProperty("lastMeasurementTime");
        StringProperty astringproperty[] = {
        		pProcessName, pUnixServiceName, pCheckMemory, pStatus, pProcessCPU, pProcessMemory, pUnixProcessMemory, pProcessCount, pLastMeasurementTime, 
            pLastMeasurement
        };
        addProperties("com.dragonflow.StandardMonitor.ProcessMonitor", astringproperty);
        addClassElement("com.dragonflow.StandardMonitor.ProcessMonitor", Rule.stringToClassifier("status != 'running'\terror", true));
        addClassElement("com.dragonflow.StandardMonitor.ProcessMonitor", Rule.stringToClassifier("status == 'running'\tgood", true));
        setClassProperty("com.dragonflow.StandardMonitor.ProcessMonitor", "description", "Determines whether a process is running.");
        setClassProperty("com.dragonflow.StandardMonitor.ProcessMonitor", "help", "ServMon.htm");
        setClassProperty("com.dragonflow.StandardMonitor.ProcessMonitor", "title", "Process");
        setClassProperty("com.dragonflow.StandardMonitor.ProcessMonitor", "class", "ProcessMonitor");
        setClassProperty("com.dragonflow.StandardMonitor.ProcessMonitor", "target", "_process");
        setClassProperty("com.dragonflow.StandardMonitor.ProcessMonitor", "classType", "server");
        setClassProperty("com.dragonflow.StandardMonitor.ProcessMonitor", "topazName", "process");
        setClassProperty("com.dragonflow.StandardMonitor.ProcessMonitor", "topazType", "System Resources");
        if(Platform.isWindows())
        {
            setClassProperty("com.dragonflow.StandardMonitor.ProcessMonitor", "toolName", "Process");
            setClassProperty("com.dragonflow.StandardMonitor.ProcessMonitor", "toolDescription", "Shows a list of currently running Services.");
        } else
        {
            setClassProperty("com.dragonflow.StandardMonitor.ProcessMonitor", "toolName", "Process");
            setClassProperty("com.dragonflow.StandardMonitor.ProcessMonitor", "toolDescription", "Shows a list of currently running Processes.");
        }
    }
}

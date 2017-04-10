package com.dragonflow.StandardMonitor;

import java.net.URLEncoder;
import java.util.Enumeration;

import jgl.Array;
import com.dragonflow.Log.LogManager;
import com.dragonflow.Page.servicePage;
import com.dragonflow.Properties.NumericProperty;
import com.dragonflow.Properties.PercentProperty;
import com.dragonflow.Properties.StringProperty;
import com.dragonflow.Resource.SiteViewErrorCodes;
import com.dragonflow.SiteView.Machine;
import com.dragonflow.SiteView.MasterConfig;
import com.dragonflow.SiteView.Platform;
import com.dragonflow.SiteView.Rule;
import com.dragonflow.SiteView.ServerMonitor;
import com.dragonflow.SiteViewException.SiteViewAvailabilityException;
import com.dragonflow.SiteViewException.SiteViewException;
import com.dragonflow.Utils.TextUtils;

public class CPUMonitor extends ServerMonitor
{

 static StringProperty pCPU;
 static StringProperty pUtilization;
 static StringProperty pLastMeasurement;
 static StringProperty pLastMeasurementTime;
 static StringProperty pCpusNum;
 static StringProperty pUtilizations[];
 static StringProperty pLastMeasurements[];
 static int maxCPUs;
 private static boolean cpuEnableErrorAt100;
 static final boolean $assertionsDisabled; /* synthetic field */

 public CPUMonitor()
 {
 }

 protected boolean update()
     throws SiteViewException
 {
     String machineName = getProperty(pMachineName);
     String s1 = TextUtils.stripChars(machineName, ".-_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789");
     String s2 = getProperty(pGetHostName);
     s2 = TextUtils.stripChars(s2, ".-_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789");
     if(s2 != null && s2.length() > 0 && !s2.equals(s1))
     {
         setProperty(pLastMeasurement, 0);
         setProperty(pLastMeasurementTime, 0);
         for(int i = 0; i < maxCPUs; i++)
         {
             setProperty(pLastMeasurements[i], 0);
         }

     }
     long l = (new Long(getProperty(pLastMeasurement))).longValue();
     long l1 = (new Long(getProperty(pLastMeasurementTime))).longValue();
     long al[] = new long[maxCPUs];
     for(int j = 0; j < maxCPUs; j++)
     {
         al[j] = (new Long(getProperty(pLastMeasurements[j]))).longValue();
     }

     Array array = null;
     if(monitorDebugLevel == 3)
     {
         array = new Array();
     }
     SiteViewException siteviewexception = null;
     long _measurementResult[] = null;
     try
     {
         _measurementResult = Platform.cpuUsed(machineName, l1, l, al, this, array);
     }
     catch(SiteViewException siteviewexception1)
     {
         siteviewexception = siteviewexception1;
     }
     currentStatus = "CPUMonitor analayzing results...";
     boolean flag = false;
     long _pUtilization = -1L;
     long _pLastMeasurementTime = -1L;
     long _pLastMeasurement = -1L;
     if(_measurementResult == null)
     {
         flag = true;
     } else
     {
         _pUtilization = _measurementResult[0];
         _pLastMeasurementTime = _measurementResult[1];
         _pLastMeasurement = _measurementResult[2];
         setProperty(pCpusNum, (int)_measurementResult[3]);
     }
     if(stillActive())
     {
         synchronized(this)
         {
             if(_pUtilization == -1L || flag)
             {
                 setProperty(pUtilization, "n/a");
                 setProperty(pLastMeasurementTime, 0);
                 setProperty(pLastMeasurement, 0);
                 setProperty(pMeasurement, 0);
                 setProperty(pStateString, "no data");
                 setProperty(pNoData, "n/a");
                 if(monitorDebugLevel == 3 && array != null)
                 {
                     StringBuffer stringbuffer = new StringBuffer();
                     for(int k = 0; k < array.size(); k++)
                     {
                         stringbuffer.append(array.at(k) + "\n");
                     }

                     LogManager.log("Error", "CPUMonitor: " + getFullID() + " failed, output:\n" + stringbuffer);
                 }
                 if(siteviewexception == null)
                 {
                     if(!$assertionsDisabled)
                     {
                         throw new AssertionError("CPU Monitor exception has been overlooked." + _pUtilization);
                     } else
                     {
                         throw new SiteViewAvailabilityException(SiteViewErrorCodes.ERR_AVAIL_SS_GENERAL);
                     }
                 } else
                 {
                     throw siteviewexception;
                 }
             }
             setProperty(pUtilization, _pUtilization);
             setProperty(pLastMeasurementTime, _pLastMeasurementTime);
             setProperty(pLastMeasurement, _pLastMeasurement);
             setProperty(pMeasurement, getMeasurement(pUtilization));
             String s3 = "" + _pUtilization;
             String s4 = "";
             int i1 = 0;
             do
             {
                 if(i1 >= getPropertyAsInteger(pCpusNum))
                 {
                     break;
                 }
                 long l5 = _measurementResult[4 + i1];
                 if(l5 == -1L)
                 {
                     break;
                 }
                 s4 = s4 + ", cpu" + (i1 + 1) + " " + l5 + "%";
                 setProperty(pUtilizations[i1], l5);
                 setProperty(pLastMeasurements[i1], al[i1]);
                 i1++;
             } while(true);
             if(getPropertyAsInteger(pCpusNum) > 1)
             {
                 s3 = s3 + "% avg" + s4;
             } else
             {
                 s3 = s3 + "% used";
             }
             setProperty(pStateString, s3);
         }
     }
     return true;
 }

 public String getProperty(StringProperty stringproperty)
     throws NullPointerException
 {
     if(stringproperty == pDiagnosticText)
     {
         String _machine = getProperty("_machine");
         StringBuffer stringbuffer = new StringBuffer();
         servicePage.printProcessStats(5, null, stringbuffer, _machine, true);
         return stringbuffer.toString();
     } else
     {
         return super.getProperty(stringproperty);
     }
 }

 public Array getLogProperties()
 {
     Array array = super.getLogProperties();
     array.add(pUtilization);
     for(int i = 0; i < getPropertyAsInteger(pCpusNum); i++)
     {
         array.add(pUtilizations[i]);
     }

     return array;
 }

 public Enumeration getStatePropertyObjects(boolean flag)
 {
     Array array = new Array();
     array.add(pUtilization);
     if(flag && getPropertyAsInteger(pCpusNum) > 1)
     {
         for(int i = 0; i < getPropertyAsInteger(pCpusNum); i++)
         {
             array.add(pUtilizations[i]);
         }

     }
     return array.elements();
 }

 public static void main(String args[])
 {
     CPUMonitor cpumonitor = new CPUMonitor();
     Array array = cpumonitor.getProperties();
     StringProperty astringproperty[] = new StringProperty[array.size()];
     for(int i = 0; i < array.size(); i++)
     {
         astringproperty[i] = (StringProperty)array.at(i);
     }

     int j = 1000;
     if(args.length > 0)
     {
         j = TextUtils.toInt(args[0]);
     }
     int k = j / 10;
     long l = Platform.timeMillis();
     for(int i1 = 0; i1 < j; i1++)
     {
         int j1 = i1 % astringproperty.length;
         cpumonitor.setProperty(astringproperty[j1].getName(), "test");
         if(i1 % k == 0)
         {
             System.out.println("SET TRIAL=" + i1);
         }
     }

     long l1 = Platform.timeMillis();
     System.out.println("" + j + " setProperty in " + (l1 - l));
     l = Platform.timeMillis();
     for(int k1 = 0; k1 < j; k1++)
     {
         int j2 = k1 % astringproperty.length;
         cpumonitor.getProperty(astringproperty[j2].getName());
         if(k1 % k == 0)
         {
             System.out.println("GET TRIAL=" + k1);
         }
     }

     l1 = Platform.timeMillis();
     System.out.println("" + j + " getProperty in " + (l1 - l));
     l = Platform.timeMillis();
     for(int i2 = 0; i2 < j; i2++)
     {
         int k2 = i2 % astringproperty.length;
         cpumonitor.setProperty(astringproperty[k2].getName(), "test");
         if(i2 % k == 0)
         {
             System.out.println("SET TRIAL=" + i2);
         }
     }

     l1 = Platform.timeMillis();
     System.out.println("" + j + " setProperty in " + (l1 - l));
 }

 public String getTestURL()
 {
     int i = Machine.getOS(getProperty(pMachineName));
     if(Platform.isWindows(i))
     {
         String s = URLEncoder.encode(getProperty(pMachineName));
         String s1 = "/SiteView/cgi/go.exe/SiteView?page=perfCounter&counterObject=Processor&machineName=" + s;
         return s1;
     } else
     {
         return null;
     }
 }

 static 
 {
	 $assertionsDisabled = !(CPUMonitor.class).desiredAssertionStatus();
     maxCPUs = 8;
     cpuEnableErrorAt100 = true;
     jgl.HashMap hashmap = MasterConfig.getMasterConfig();
     String s = TextUtils.getValue(hashmap, "_cpuMaxProcessors");
     maxCPUs = TextUtils.toInt(s);
     if(maxCPUs == 0)
     {
         maxCPUs = 8;
     }
     String s1 = TextUtils.getValue(hashmap, "_cpuEnableErrorAt100");
     if(s1.equalsIgnoreCase("false"))
     {
         cpuEnableErrorAt100 = false;
     }
     pUtilization = new PercentProperty("utilizationPercentage");
     pUtilization.setDisplayText("utilization", "the percentage of CPU time that is being used");
     pUtilization.setStateOptions(1);
     pCpusNum = new NumericProperty("cpusNum");
     pLastMeasurement = new NumericProperty("lastMeasurement");
     pLastMeasurementTime = new NumericProperty("lastMeasurementTime");
     Array array = new Array();
     array.add(pUtilization);
     array.add(pCpusNum);
     array.add(pLastMeasurement);
     array.add(pLastMeasurementTime);
     pUtilizations = new StringProperty[maxCPUs];
     pLastMeasurements = new StringProperty[maxCPUs];
     for(int i = 0; i < maxCPUs; i++)
     {
         int j = i + 1;
         pUtilizations[i] = new PercentProperty("utilizationPercentage" + j);
         pUtilizations[i].setDisplayText("utilization cpu # " + j, "the percentage of CPU # " + j + " time that is being used");
         pUtilizations[i].setStateOptions(j + 1);
         array.add(pUtilizations[i]);
         pLastMeasurements[i] = new NumericProperty("lastMeasurement" + j);
         array.add(pLastMeasurements[i]);
     }

     StringProperty astringproperty[] = new StringProperty[array.size()];
     for(int k = 0; k < array.size(); k++)
     {
         astringproperty[k] = (StringProperty)array.at(k);
     }

     addProperties("com.dragonflow.StandardMonitor.CPUMonitor", astringproperty);
     if(cpuEnableErrorAt100)
     {
         addClassElement("com.dragonflow.StandardMonitor.CPUMonitor", Rule.stringToClassifier("utilizationPercentage == 100\terror", true));
     }
     addClassElement("com.dragonflow.StandardMonitor.CPUMonitor", Rule.stringToClassifier("utilizationPercentage > 90\twarning", true));
     addClassElement("com.dragonflow.StandardMonitor.CPUMonitor", Rule.stringToClassifier("utilizationPercentage == n/a\terror"));
     addClassElement("com.dragonflow.StandardMonitor.CPUMonitor", Rule.stringToClassifier("always\tgood"));
     setClassProperty("com.dragonflow.StandardMonitor.CPUMonitor", "description", "Measures the percentage of CPU time that is being used on a server.");
     setClassProperty("com.dragonflow.StandardMonitor.CPUMonitor", "help", "CpuMon.htm");
     setClassProperty("com.dragonflow.StandardMonitor.CPUMonitor", "title", "CPU Utilization");
     setClassProperty("com.dragonflow.StandardMonitor.CPUMonitor", "class", "CPUMonitor");
     setClassProperty("com.dragonflow.StandardMonitor.CPUMonitor", "target", "_cpu");
     setClassProperty("com.dragonflow.StandardMonitor.CPUMonitor", "topazName", "CPU");
     setClassProperty("com.dragonflow.StandardMonitor.CPUMonitor", "topazType", "System Resources");
     setClassProperty("com.dragonflow.StandardMonitor.CPUMonitor", "classType", "server");
 }
}

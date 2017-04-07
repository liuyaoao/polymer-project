package com.dragonflow.StandardMonitor;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import com.dragonflow.Log.LogManager;
import com.dragonflow.Properties.NumericProperty;
import com.dragonflow.Properties.PercentProperty;
import com.dragonflow.Properties.RateProperty;
import com.dragonflow.Properties.StringProperty;
import com.dragonflow.SiteView.Machine;
import com.dragonflow.SiteView.Platform;
import com.dragonflow.SiteView.Rule;
import com.dragonflow.SiteView.ServerMonitor;
import com.dragonflow.Utils.TextUtils;
import com.siteview.kernel.mqttutil.ReceiveMessageContainer;

import SiteViewMain.Start;
import jgl.Array;

public class MqttMemoryMonitor extends ServerMonitor{
	  static StringProperty pPercentFull;
	    static StringProperty pFreeSpace;
	    static RateProperty pPageFaultsPerSecond;
	    static NumericProperty pLastMeasurement;
	    static NumericProperty pLastPageFaults;
	    public MqttMemoryMonitor()
	    {
	    }

	    protected boolean update()
	    {
	    	 String id=TextUtils.getOrderIdByUUId();
			 String machineName = getProperty(pMachineName);
			 List<Long> al =new ArrayList<Long>();
			 if(machineName.contains(":")){
				 Machine machine=Machine.getMqttMachine(machineName.substring(machineName.indexOf(":")+1));
				 if(machine!=null)
					 machineName=machine.getProperty("_host");
				 Start.agent.sendMessage(machineName, (id+"free").getBytes());
				 int i=0;
				 while(i<10){
					 String msg=ReceiveMessageContainer.getInstance().getMessageString(id);
					 if(msg==null){
						 try {
							this.getThread().sleep(1000);
						} catch (InterruptedException e) {
							e.printStackTrace();
						}
					 }else{
						 System.out.println(msg+"=====================================");
						 String[] s = msg.trim().split("\n");
						 if(s.length>0){
							 String s1 = s[s.length-1].trim();
							 String[] ss=s1.split("       ");
							 String total = ss[1];
							 String user = ss[2];
							 String free = ss[3];
							 al.add(Long.parseLong(user)*100/Long.parseLong(total));
							 al.add(Long.parseLong(user));
							 al.add(Long.parseLong(total));
						 }
						 ReceiveMessageContainer.getInstance().removeMessage(id);
						 break;
					 }
					 i++;
				 }
			 }
	        long l = 0L;
	        long l1 = 0L;
	        Array array = null;
	        if(monitorDebugLevel == 3)
	        {
	            array = new Array();
	        }
	        long l2 = al.get(0);
	        long l3 = al.get(2);
	        long l4 = l3 - al.get(1);
	        String s1 = "" + l4 / 1024;
	        float f = -1F;
	        if(stillActive())
	        {
	            synchronized(this)
	            {
	                if(l2 == -1L)
	                {
	                    setProperty(pPercentFull, "n/a");
	                    setProperty(pFreeSpace, "n/a");
	                    setProperty(pPageFaultsPerSecond, "n/a");
	                    setProperty(pMeasurement, 0);
	                    setProperty(pStateString, "no data");
	                    setProperty(pNoData, "n/a");
	                    if(monitorDebugLevel == 3 && array != null)
	                    {
	                        StringBuffer stringbuffer = new StringBuffer();
	                        for(int i = 0; i < array.size(); i++)
	                        {
	                            stringbuffer.append(array.at(i) + "\n");
	                        }

	                        LogManager.log("Error", "MemoryMonitor: " + getFullID() + " failed, output:\n" + stringbuffer);
	                    }
	                } else
	                {
	                    setProperty(pPercentFull, l2);
	                    setProperty(pFreeSpace, l4 / 1024);
	                    setProperty(pMeasurement, getMeasurement(pPercentFull));
	                    String s2 = l2 + "% used, " + s1 + "MB free";
	                    if(f == -1F)
	                    {
	                        setProperty(pPageFaultsPerSecond, "n/a");
	                    } else
	                    {
	                        setProperty(pPageFaultsPerSecond, f);
	                        s2 = s2 + ", " + TextUtils.floatToString(f, 2) + " pages/sec";
	                    }
	                    setProperty(pStateString, s2);
	                }
	            }
	        }
	        return true;
	    }

	    public Array getLogProperties()
	    {
	        Array array = super.getLogProperties();
	        array.add(pPercentFull);
	        array.add(pFreeSpace);
	        array.add(pPageFaultsPerSecond);
	        return array;
	    }

	    public String getTestURL()
	    {
	        int i = Machine.getOS(getProperty(pMachineName));
	        if(Platform.isWindows(i))
	        {
	            String s = URLEncoder.encode(getProperty(pMachineName));
	            String s1 = "/SiteView/cgi/go.exe/SiteView?page=perfCounter&counterObject=MqttMemory&machineName=" + s;
	            return s1;
	        } else
	        {
	            return null;
	        }
	    }

	    static 
	    {
	        pPercentFull = new PercentProperty("percentFull");
	        pPercentFull.setLabel("percent used");
	        pPercentFull.setStateOptions(1);
	        pFreeSpace = new NumericProperty("freeSpace", "0", "MB");
	        pFreeSpace.setLabel("MB free");
	        pFreeSpace.setStateOptions(2);
	        pPageFaultsPerSecond = new RateProperty("pageFaultsPerSecond", "0", "pages", "seconds");
	        pPageFaultsPerSecond.setLabel("pages/sec");
	        pPageFaultsPerSecond.setStateOptions(3);
	        pLastMeasurement = new NumericProperty("lastMeasurement");
	        pLastPageFaults = new NumericProperty("lastPageFaults");
	        StringProperty astringproperty[] = {
	            pPercentFull, pFreeSpace, pPageFaultsPerSecond, pLastMeasurement, pLastPageFaults
	        };
	        addProperties("com.dragonflow.StandardMonitor.MqttMemoryMonitor", astringproperty);
	        addClassElement("com.dragonflow.StandardMonitor.MqttMemoryMonitor", Rule.stringToClassifier("percentFull > 90\terror", true));
	        addClassElement("com.dragonflow.StandardMonitor.MqttMemoryMonitor", Rule.stringToClassifier("percentFull > 80\twarning", true));
	        addClassElement("com.dragonflow.StandardMonitor.MqttMemoryMonitor", Rule.stringToClassifier("percentFull == n/a\terror"));
	        addClassElement("com.dragonflow.StandardMonitor.MqttMemoryMonitor", Rule.stringToClassifier("always\tgood"));
	        setClassProperty("com.dragonflow.StandardMonitor.MqttMemoryMonitor", "description", "Measure virtual memory usage");
	        setClassProperty("com.dragonflow.StandardMonitor.MqttMemoryMonitor", "help", "MqttMemoryMon.htm");
	        setClassProperty("com.dragonflow.StandardMonitor.MqttMemoryMonitor", "title", "MqttMemory");
	        setClassProperty("com.dragonflow.StandardMonitor.MqttMemoryMonitor", "class", "MqttMemoryMonitor");
	        setClassProperty("com.dragonflow.StandardMonitor.MqttMemoryMonitor", "classType", "server");
	        setClassProperty("com.dragonflow.StandardMonitor.MqttMemoryMonitor", "topazName", "MqttMemory");
	        setClassProperty("com.dragonflow.StandardMonitor.MqttMemoryMonitor", "topazType", "System Resources");
	    }
}

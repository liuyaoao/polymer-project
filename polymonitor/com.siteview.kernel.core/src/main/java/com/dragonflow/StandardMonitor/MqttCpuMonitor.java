package com.dragonflow.StandardMonitor;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import com.dragonflow.Properties.NumericProperty;
import com.dragonflow.Properties.PercentProperty;
import com.dragonflow.Properties.StringProperty;
import com.dragonflow.SiteView.Machine;
import com.dragonflow.SiteView.MasterConfig;
import com.dragonflow.SiteView.Rule;
import com.dragonflow.SiteView.ServerMonitor;
import com.dragonflow.SiteViewException.SiteViewException;
import com.dragonflow.Utils.TextUtils;
import com.siteview.kernel.mqttutil.ReceiveMessageContainer;

import SiteViewMain.Start;
import jgl.Array;

public class MqttCpuMonitor extends ServerMonitor{
	 static StringProperty pCPU;
	 static StringProperty pUtilization;
	 static StringProperty pLastMeasurement;
	 static StringProperty pLastMeasurementTime;
	 static StringProperty pCpusNum;
	 static StringProperty pUtilizations[];
	 static StringProperty pLastMeasurements[];
	 static int maxCPUs;
	 private static boolean cpuEnableErrorAt100;
	 public MqttCpuMonitor(){}
	 DecimalFormat df = new DecimalFormat("0.0");
	 protected boolean update()throws SiteViewException{
		 String id=TextUtils.getOrderIdByUUId();
		 String machineName = getProperty(pMachineName);
		 List<Double> al =new ArrayList<Double>();
		 if(machineName.contains(":")){
			 Machine machine=Machine.getMqttMachine(machineName.substring(machineName.indexOf(":")+1));
			 if(machine!=null)
				 machineName=machine.getProperty("_host");
			 Start.agent.sendMessage(machineName, (id+"head -n1 /proc/stat && sleep 2 && head -n1 /proc/stat 2>&1").getBytes());
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
					 ReceiveMessageContainer.getInstance().removeMessage(id);
					 String[] s = msg.trim().split("\n");
					 String[] cpu0= s[0].trim().split(" ");
					 String[] cpu1= s[1].trim().split(" ");
					 long cpuol=0;
					 long cpu1l=0;
					 long cpu0i=0;
					 long cpu1i=0;
					for(int n=2;n<cpu0.length;n++){
						cpuol += Long.parseLong(cpu0[n]);
						cpu1l += Long.parseLong(cpu1[n]);
						if(n==5){
							cpu0i=Long.parseLong(cpu0[n]);
							cpu1i=Long.parseLong(cpu1[n]);
						}
					}
					long t=cpu1l-cpuol;
					long it=cpu1i-cpu0i;
					al.add((t-it)*100.0/t);
				 }
				 i++;
			 }
		 }
		 if(al.size()<1){
			 setProperty(pUtilization, "n/a");
	         setProperty(pLastMeasurementTime, 0);
	         setProperty(pLastMeasurement, 0);
	         setProperty(pMeasurement, 0);
	         setProperty(pStateString, "no data");
	         setProperty(pNoData, "n/a");
		 }else{
			 setProperty(pUtilization, df.format(al.get(0)));
             setProperty(pLastMeasurementTime, 0);
             setProperty(pLastMeasurement, 0);
             setProperty(pMeasurement, getMeasurement(pUtilization));
             String s3 = "" + df.format(al.get(0));
             String s4 = "";
             int i1 = 0;
             do
             {
                 if(i1 >= getPropertyAsInteger(pCpusNum))
                 {
                     break;
                 }
                 double l5 = al.get(2 + i1);
                 if(l5 == -1L)
                 {
                     break;
                 }
                 s4 = s4 + ", cpu" + (i1 + 1) + " " + df.format(l5) + "%";
                 setProperty(pUtilizations[i1], df.format(l5));
//                 setProperty(pLastMeasurements[i1], al.get(i1));
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
		 return true;
	 }
	 static 
	 {
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

	     addProperties("com.dragonflow.StandardMonitor.MqttCpuMonitor", astringproperty);
	     if(cpuEnableErrorAt100)
	     {
	         addClassElement("com.dragonflow.StandardMonitor.MqttCpuMonitor", Rule.stringToClassifier("utilizationPercentage == 100\terror", true));
	     }
	     addClassElement("com.dragonflow.StandardMonitor.MqttCpuMonitor", Rule.stringToClassifier("utilizationPercentage > 90\twarning", true));
	     addClassElement("com.dragonflow.StandardMonitor.MqttCpuMonitor", Rule.stringToClassifier("utilizationPercentage == n/a\terror"));
	     addClassElement("com.dragonflow.StandardMonitor.MqttCpuMonitor", Rule.stringToClassifier("always\tgood"));
	     setClassProperty("com.dragonflow.StandardMonitor.MqttCpuMonitor", "description", "Measures the percentage of CPU time that is being used on a server.");
	     setClassProperty("com.dragonflow.StandardMonitor.MqttCpuMonitor", "help", "MqttCpuMonitor.htm");
	     setClassProperty("com.dragonflow.StandardMonitor.MqttCpuMonitor", "title", "MqttCPU Utilization");
	     setClassProperty("com.dragonflow.StandardMonitor.MqttCpuMonitor", "class", "MqttCpuMonitor");
	     setClassProperty("com.dragonflow.StandardMonitor.MqttCpuMonitor", "target", "_cpu");
	     setClassProperty("com.dragonflow.StandardMonitor.MqttCpuMonitor", "topazName", "CPU");
	     setClassProperty("com.dragonflow.StandardMonitor.MqttCpuMonitor", "topazType", "System Resources");
	     setClassProperty("com.dragonflow.StandardMonitor.MqttCpuMonitor", "classType", "server");
	 }
}

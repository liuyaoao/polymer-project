package com.dragonflow.StandardMonitor;

import java.util.HashMap;
import java.util.Map;

import com.dragonflow.Properties.PercentProperty;
import com.dragonflow.Properties.ScalarProperty;
import com.dragonflow.Properties.StringProperty;
import com.dragonflow.SiteView.Machine;
import com.dragonflow.SiteView.Rule;
import com.dragonflow.SiteView.ServerMonitor;
import com.dragonflow.Utils.TextUtils;
import com.siteview.kernel.mqttutil.ReceiveMessageContainer;

import SiteViewMain.Start;
import jgl.Array;

public class MqttSubnetStatusMonitor extends ServerMonitor {
	static ScalarProperty pSubnet;
	static StringProperty pSubnetStatus;

	public MqttSubnetStatusMonitor() {
	}

	@SuppressWarnings("static-access")
	protected boolean update() {
		String id = TextUtils.getOrderIdByUUId();
		String machineName = getProperty(pMachineName);
		Map<String, String> resultMap = new HashMap<String, String>();
				if (machineName.contains(":")) {
			Machine machine = Machine.getMqttMachine(machineName.substring(machineName.indexOf(":") + 1));
			if (machine != null)
				machineName = machine.getProperty("_host");
			ReceiveMessageContainer.getInstance().receiveMessage(id, "".getBytes());
			Start.agent.sendMessage(machineName, (id + "ifconfig br0|grep Mask 2>&1").getBytes());
			int i = 0;
			while (i < 10) {
				String msg = ReceiveMessageContainer.getInstance().getMessageString(id);
				if (msg == null||msg.length()==0) {
					try {
						this.getThread().sleep(1000);
						//System.out.println((i+1)+"---"+"subnet no message");
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				} else {
					//System.out.println(msg);
					resultMap = analysisMsg(msg);
					break;
				}
				i++;
			}
			ReceiveMessageContainer.getInstance().removeMessage(id);
		}
		if (stillActive()) {
			synchronized (this) {
				if (resultMap.size()!=0) {
					setProperty(pStateString, resultMap.get("result"));
					setProperty(pSubnetStatus, resultMap.get("stat"));
				} else {
					setProperty(pStateString, "no data");
					setProperty(pSubnetStatus, "error");
				}
				setProperty(pMeasurement, pSubnetStatus);
			}
		}
		return true;
	}
	
	public Map<String, String> analysisMsg(String msg){
		String[] arr = msg.split("  ");
		String result = "";
		String status = "";
		Map<String, String> map = new HashMap<String, String>();
		for(String item:arr){
			if(item.contains("addr")&&item.contains(":")){
				result += "IPAddress"+item.substring(item.indexOf(":"), item.length());
			}
			if(item.contains("Mask")&&item.contains(":")){
				result += ";Mask"+item.substring(item.indexOf(":"), item.length());
			}
		}
		status = result.equals("")?"error":"good";
		map.put("result", result.equals("")?"no data":result);
		map.put("stat", status);
		return map;
	}
	
	public Array getLogProperties() {
		Array array = super.getLogProperties();
		array.add(pSubnetStatus);
		return array;
	}
	
	static {
		pSubnet = new ScalarProperty("_subnet", true);
		pSubnet.setWindowsPlatforms();
		pSubnet.setDisplayText("Service", "the NT service to monitor.");
		pSubnet.setParameterOptions(true, 1, false);
		pSubnet.allowOther = true;
		pSubnetStatus = new PercentProperty("Status");
		pSubnetStatus.setStateOptions(1);
		
		StringProperty astringproperty[] = { pSubnet, pSubnetStatus };
		addProperties("com.dragonflow.StandardMonitor.MqttSubnetStatusMonitor", astringproperty);
		addClassElement("com.dragonflow.StandardMonitor.MqttSubnetStatusMonitor",Rule.stringToClassifier("Status == 'error'\terror", true));
		addClassElement("com.dragonflow.StandardMonitor.MqttSubnetStatusMonitor",Rule.stringToClassifier("Status == 'good'\tgood", true));
		setClassProperty("com.dragonflow.StandardMonitor.MqttSubnetStatusMonitor", "description","Determines whether subnet is exist.");
		setClassProperty("com.dragonflow.StandardMonitor.MqttSubnetStatusMonitor", "help", "ServMon.htm");
		setClassProperty("com.dragonflow.StandardMonitor.MqttSubnetStatusMonitor", "title", "MqttSubnetStatus");
		setClassProperty("com.dragonflow.StandardMonitor.MqttSubnetStatusMonitor", "class", "MqttSubnetStatusMonitor");
		setClassProperty("com.dragonflow.StandardMonitor.MqttSubnetStatusMonitor", "target", "MqttSubnet");
		setClassProperty("com.dragonflow.StandardMonitor.MqttSubnetStatusMonitor", "classType", "server");
		setClassProperty("com.dragonflow.StandardMonitor.MqttSubnetStatusMonitor", "topazName", "MqttSubnet");
		setClassProperty("com.dragonflow.StandardMonitor.MqttSubnetStatusMonitor", "topazType", "System Resources");
	}
}

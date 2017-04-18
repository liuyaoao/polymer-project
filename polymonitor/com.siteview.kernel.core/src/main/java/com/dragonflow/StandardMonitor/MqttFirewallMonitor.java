package com.dragonflow.StandardMonitor;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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

public class MqttFirewallMonitor extends ServerMonitor {
	static ScalarProperty pFirewall;
	static StringProperty pFirewallStatus;

	public MqttFirewallMonitor() {
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
			Start.agent.sendMessage(machineName, (id + "iptables -L -t nat -v | grep -E 'site|tun' 2>&1").getBytes());
			int i = 0;
			while (i < 10) {
				String msg = ReceiveMessageContainer.getInstance().getMessageString(id);
				if (msg == null||msg.length()==0) {
					try {
						this.getThread().sleep(1000);
						//System.out.println((i+1)+"---"+"firewall no message");
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				} else {
					//System.out.println(msg);
					resultMap = getResult(msg);
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
					setProperty(pFirewallStatus, resultMap.get("stat"));
				} else {
					setProperty(pStateString, "no data");
					setProperty(pFirewallStatus, "error");
				}
				setProperty(pMeasurement, pFirewallStatus);
			}
		}
		return true;
	}
	
	public Map<String, String> getResult(String msg){
		Map<String, String> map = new HashMap<String, String>();
		String result = "";
		String status ="";
		String tagstr = "MASQUERADE  all  --  any";
		if(getCountStr(tagstr, msg)==10){
			result = "status is good";
			status = "good";
		}else{
			result = "error";
			status = "error";
		}
		map.put("result", result);
		map.put("stat", status);
		return map;
	}
	
	public int getCountStr(String tar, String msg){
		int count = 0;
		final Pattern r = Pattern.compile(tar);
		final Matcher m = r.matcher(msg);
		while (m.find()) {
			count++;
		}
		return count;
	}
	
	public Array getLogProperties() {
		Array array = super.getLogProperties();
		array.add(pFirewallStatus);
		return array;
	}
	
	static {
		pFirewall = new ScalarProperty("_firewall", true);
		pFirewall.setWindowsPlatforms();
		pFirewall.setDisplayText("Service", "the NT service to monitor.");
		pFirewall.setParameterOptions(true, 1, false);
		pFirewall.allowOther = true;
		pFirewallStatus = new PercentProperty("Status");
		pFirewallStatus.setStateOptions(1);
		
		StringProperty astringproperty[] = { pFirewall, pFirewallStatus };
		addProperties("com.dragonflow.StandardMonitor.MqttFirewallMonitor", astringproperty);
		addClassElement("com.dragonflow.StandardMonitor.MqttFirewallMonitor",Rule.stringToClassifier("Status == 'error'\terror", true));
		addClassElement("com.dragonflow.StandardMonitor.MqttFirewallMonitor",Rule.stringToClassifier("Status == 'good'\tgood", true));
		setClassProperty("com.dragonflow.StandardMonitor.MqttFirewallMonitor", "description","Determines whether Firewall is running.");
		setClassProperty("com.dragonflow.StandardMonitor.MqttFirewallMonitor", "help", "ServMon.htm");
		setClassProperty("com.dragonflow.StandardMonitor.MqttFirewallMonitor", "title", "MqttFirewall");
		setClassProperty("com.dragonflow.StandardMonitor.MqttFirewallMonitor", "class", "MqttFirewallMonitor");
		setClassProperty("com.dragonflow.StandardMonitor.MqttFirewallMonitor", "target", "MqttFirewall");
		setClassProperty("com.dragonflow.StandardMonitor.MqttFirewallMonitor", "classType", "server");
		setClassProperty("com.dragonflow.StandardMonitor.MqttFirewallMonitor", "topazName", "MqttFirewall");
		setClassProperty("com.dragonflow.StandardMonitor.MqttFirewallMonitor", "topazType", "System Resources");
		
	}
}

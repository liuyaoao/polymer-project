package com.dragonflow.StandardMonitor;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.dragonflow.Properties.PercentProperty;
import com.dragonflow.Properties.StringProperty;
import com.dragonflow.SiteView.Machine;
import com.dragonflow.SiteView.Rule;
import com.dragonflow.SiteView.ServerMonitor;
import com.dragonflow.Utils.TextUtils;
import com.siteview.kernel.mqttutil.ReceiveMessageContainer;

import SiteViewMain.Start;
import jgl.Array;

public class MqttProcessMonitor extends ServerMonitor {
	static StringProperty pCommand;
	static StringProperty pProcessStatus;

	public MqttProcessMonitor() {
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
			String cmd = getProperty(pCommand);
			Start.agent.sendMessage(machineName, (id + cmd).getBytes());
			int i = 0;
			while (i < 10) {
				String msg = ReceiveMessageContainer.getInstance().getMessageString(id);
				if (msg == null || msg.length() == 0) {
					try {
						this.getThread().sleep(1000);
						//System.out.println((i+1)+"---"+"process no message");
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				} else {
					//System.out.println(msg);
					resultMap = analysisMsg(cmd, msg);
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
					setProperty(pProcessStatus, resultMap.get("stat"));
				} else {
					setProperty(pStateString, "no data");
					setProperty(pProcessStatus, "error");
				}
				setProperty(pMeasurement, pProcessStatus);
			}
		}
		return true;
	}
	
	public Map<String, String> analysisMsg(String cmd, String msg){
		Map<String, String> map = new HashMap<String, String>();
		String result = "";
		String status ="";
		String stat = "warning";
		boolean rtag = false;
		boolean dtag = false;
		String[] cmdArr = cmd.substring(cmd.indexOf("'")+1, cmd.lastIndexOf("'")).split("\\|");
		if (cmdArr.length>0) {
			for(int i=0;i<cmdArr.length;i++){
				if(i!=0){
					result += ";";
				}
				if(cmdArr[i].equals("vpnctrl")||cmdArr[i].equals("vppnctrl")){
					if(getCountStr(cmdArr[i]+" -t", msg)>=5){
						status = "run";
						rtag = true;
					}else{
						status = "down";
						dtag = true;
					}
				}else if(cmdArr[i].equals("mqtt-monitord")){
					status = "run";
				}else{
					if(getCountStr("/usr/sbin/"+cmdArr[i], msg)>0){
						status = "run";
						rtag = true;
					}else{
						status = "down";
						dtag = true;
					}
				}
				result += cmdArr[i]+":"+status;
			}
		}else{
			result = "no data";
		}
		if(!rtag&&dtag){
			result = result.replace("mqtt-monitord:run", "mqtt-monitord:down");
			stat = "error";
		}
		if(!dtag&&rtag){
			stat = "good";
		}
		map.put("result", result);
		map.put("stat", stat);
		return map;
	}
	
	public int getCountStr(String process, String msg){
		int count = 0;
		final Pattern r = Pattern.compile(" "+process+" ");
		final Matcher m = r.matcher(msg);
		while (m.find()) {
			count++;
		}
		return count;
	}

	public Array getLogProperties() {
		Array array = super.getLogProperties();
		array.add(pProcessStatus);
		return array;
	}

	static {
		pCommand = new StringProperty("_command", "ps|grep -E 'tincd|dnsmasq|bird|mqtt-monitord|vpnctrl|vppnctrl' 2>&1", "command");
		pCommand.setDisplayText("Command", "the command to get message");
		pCommand.setParameterOptions(true, 2, false);
		pProcessStatus = new PercentProperty("Status");
		pProcessStatus.setLabel("ProcessStatus");
		pProcessStatus.setStateOptions(1);
		StringProperty astringproperty[] = { pCommand, pProcessStatus };
		addProperties("com.dragonflow.StandardMonitor.MqttProcessMonitor", astringproperty);
		addClassElement("com.dragonflow.StandardMonitor.MqttProcessMonitor", Rule.stringToClassifier("Status == 'error'\terror", true));
		addClassElement("com.dragonflow.StandardMonitor.MqttProcessMonitor", Rule.stringToClassifier("Status == 'warning'\twarning", true));
		addClassElement("com.dragonflow.StandardMonitor.MqttProcessMonitor", Rule.stringToClassifier("Status == 'good'\tgood", true));
		setClassProperty("com.dragonflow.StandardMonitor.MqttProcessMonitor", "description", "Measure the process run status");
		setClassProperty("com.dragonflow.StandardMonitor.MqttProcessMonitor", "help", "MqttProcessMon.htm");
		setClassProperty("com.dragonflow.StandardMonitor.MqttProcessMonitor", "title", "MqttProcess");
		setClassProperty("com.dragonflow.StandardMonitor.MqttProcessMonitor", "class", "MqttProcessMonitor");
		setClassProperty("com.dragonflow.StandardMonitor.MqttProcessMonitor", "classType", "server");
		setClassProperty("com.dragonflow.StandardMonitor.MqttProcessMonitor", "topazName", "MqttProcess");
		setClassProperty("com.dragonflow.StandardMonitor.MqttProcessMonitor", "topazType", "System Resources");
	}
}

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

public class MqttConnectedDeviceMonitor extends ServerMonitor {
	static ScalarProperty pConnectedDevice;
	static StringProperty pDevicesStatus;

	public MqttConnectedDeviceMonitor() {
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
			Start.agent.sendMessage(machineName, (id + "soap-tool get_attachdevice 2>&1").getBytes());
			int i = 0;
			while (i < 10) {
				String msg = ReceiveMessageContainer.getInstance().getMessageString(id);
				if (msg == null||msg.length()==0) {
					try {
						this.getThread().sleep(1000);
						//System.out.println((i+1)+"---"+"connected device no message");
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				} else {
//					System.out.println(msg);
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
					setProperty(pDevicesStatus, resultMap.get("stat"));
				} else {
					setProperty(pStateString, "no data");
					setProperty(pDevicesStatus, "error");
				}
				setProperty(pMeasurement, pDevicesStatus);
			}
		}
		return true;
	}
	
	public Map<String, String> analysisMsg(String msg){
		Map<String, String> map = new HashMap<String, String>();
		String result = "";
		String status = "";
		String indexvs = "<NewAttachDevice>";
		String indexve = "</NewAttachDevice>";
		String substr = msg.substring(msg.indexOf(indexvs)+indexvs.length(), msg.lastIndexOf(indexve));
		substr = substr.replaceAll("&lt;", "").replaceAll("&gt;", "");
		if(substr.equals("0")){
			map.put("result", "no device");
			map.put("stat", "good");
		}else{
			String device = "";
			String[] deviceDetail;
			String[] arr = substr.split("@");
			for(int i=1;i<arr.length;i++){
				device = arr[i];
				deviceDetail = device.split(";");
				for(int j=0;j<deviceDetail.length;j++){
					switch (j) {
					case 1:
						result += (i==1?"":",") + "@IP:"+deviceDetail[j];
						break;
					case 2:
						result += ";Name:"+deviceDetail[j];
						break;
					case 3:
						result += ";Mac:"+deviceDetail[j];
						break;
					default:
						break;
					}
				}
			}
			status = result.equals("")?"error":"good";
			result = result.equals("")?"no data":result;
			map.put("result", result);
			map.put("stat", status);
		}
		return map;
	}
	
	public Array getLogProperties() {
		Array array = super.getLogProperties();
		array.add(pDevicesStatus);
		return array;
	}
	
	static {
		pConnectedDevice = new ScalarProperty("_connecteddevice", true);
		pConnectedDevice.setWindowsPlatforms();
		pConnectedDevice.setDisplayText("Service", "the NT service to monitor.");
		pConnectedDevice.setParameterOptions(true, 1, false);
		pConnectedDevice.allowOther = true;
		pDevicesStatus = new PercentProperty("Status");
		pDevicesStatus.setStateOptions(1);
		
		StringProperty astringproperty[] = { pConnectedDevice, pDevicesStatus };
		addProperties("com.dragonflow.StandardMonitor.MqttConnectedDeviceMonitor", astringproperty);
		addClassElement("com.dragonflow.StandardMonitor.MqttConnectedDeviceMonitor",Rule.stringToClassifier("Status == 'error'\terror", true));
		addClassElement("com.dragonflow.StandardMonitor.MqttConnectedDeviceMonitor",Rule.stringToClassifier("Status == 'good'\tgood", true));
		setClassProperty("com.dragonflow.StandardMonitor.MqttConnectedDeviceMonitor", "description","Check the connected devices.");
		setClassProperty("com.dragonflow.StandardMonitor.MqttConnectedDeviceMonitor", "help", "ServMon.htm");
		setClassProperty("com.dragonflow.StandardMonitor.MqttConnectedDeviceMonitor", "title", "MqttConnectedDevice");
		setClassProperty("com.dragonflow.StandardMonitor.MqttConnectedDeviceMonitor", "class", "MqttConnectedDeviceMonitor");
		setClassProperty("com.dragonflow.StandardMonitor.MqttConnectedDeviceMonitor", "target", "MqttConnected");
		setClassProperty("com.dragonflow.StandardMonitor.MqttConnectedDeviceMonitor", "classType", "server");
		setClassProperty("com.dragonflow.StandardMonitor.MqttConnectedDeviceMonitor", "topazName", "MqttConnected");
		setClassProperty("com.dragonflow.StandardMonitor.MqttConnectedDeviceMonitor", "topazType", "System Resources");
		
	}
}

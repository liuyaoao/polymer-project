package com.dragonflow.StandardMonitor;

import java.util.HashMap;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.dragonflow.Properties.NumericProperty;
import com.dragonflow.Properties.ScalarProperty;
import com.dragonflow.Properties.StringProperty;
import com.dragonflow.SiteView.Machine;
import com.dragonflow.SiteView.Rule;
import com.dragonflow.SiteView.ServerMonitor;
import com.dragonflow.Utils.TextUtils;
import com.siteview.kernel.mqttutil.ReceiveMessageContainer;

import SiteViewMain.Start;
import jgl.Array;

public class MqttFlowMonitor extends ServerMonitor {
	static ScalarProperty pFlow;
	static NumericProperty pFlowPercent;

	public MqttFlowMonitor() {
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
			Start.agent.sendMessage(machineName, (id + "ifconfig site0|grep -E 'TX|RX' && sleep 1 && ifconfig site0|grep -E 'TX|RX' 2>&1").getBytes());
			int i = 0;
			while (i < 10) {
				String msg = ReceiveMessageContainer.getInstance().getMessageString(id);
				if (msg == null || msg.length() == 0) {
					try {
						this.getThread().sleep(1000);
//						System.out.println((i+1)+"---"+"flow no message");
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
					setProperty(pFlowPercent, resultMap.get("stat").equals("good")?0:1);
				} else {
					setProperty(pStateString, "no data");
					setProperty(pFlowPercent, 1);
				}
				setProperty(pMeasurement, pFlowPercent);
			}
		}
		return true;
	}
	
	public Map<String, String> analysisMsg(String msg){
		Map<String, String> map = new HashMap<String, String>();
		String str = msg;
		String result="no data";
		try {
			String[] arr = str.substring(str.indexOf("\n")+2, str.lastIndexOf("\n")).trim().replaceAll("\\)  TX", "\\)\nTX").split("\n");
			JSONObject json = new JSONObject();
			JSONObject subjson = null;
			int i = 0;
			String key = "",sub = "",value = "";
			if(arr.length==8){
				for(String s:arr){i++;
					sub = s.trim().replaceAll(" ", ",").trim();
					key = sub.substring(0, 2);
					value = sub.substring(3);
					if(value.contains("bytes")){
						value = value.substring(0, value.indexOf(","));
					}
					value = "{"+value+"}";
					subjson = JSONObject.parseObject(value);
					json.put(key+i, subjson);
				}
			}
			if(json.size()==8){
				String RX = "RX:bytes:"+(json.getJSONObject("RX7").getIntValue("bytes")-json.getJSONObject("RX3").getIntValue("bytes"))
						 +";packets:"+(json.getJSONObject("RX5").getByteValue("packets")-json.getJSONObject("RX1").getByteValue("packets"))
						 +";errors:"+(json.getJSONObject("RX5").getByteValue("errors")-json.getJSONObject("RX1").getByteValue("errors"))
						 +";dropped:"+(json.getJSONObject("RX5").getByteValue("dropped")-json.getJSONObject("RX1").getByteValue("dropped"))
						 +";overruns:"+(json.getJSONObject("RX5").getByteValue("overruns")-json.getJSONObject("RX1").getByteValue("overruns"));
				String TX = "TX:bytes:"+(json.getJSONObject("TX8").getIntValue("bytes")-json.getJSONObject("TX4").getIntValue("bytes"))
					 +";packets:"+(json.getJSONObject("TX6").getByteValue("packets")-json.getJSONObject("TX2").getByteValue("packets"))
					 +";errors:"+(json.getJSONObject("TX6").getByteValue("errors")-json.getJSONObject("TX2").getByteValue("errors"))
					 +";dropped:"+(json.getJSONObject("TX6").getByteValue("dropped")-json.getJSONObject("TX2").getByteValue("dropped"))
					 +";overruns:"+(json.getJSONObject("TX6").getByteValue("overruns")-json.getJSONObject("TX2").getByteValue("overruns"));
				result = RX+","+TX;
				if(json.getJSONObject("RX5").getByteValue("errors")>0||json.getJSONObject("RX1").getByteValue("errors")>0
						||json.getJSONObject("TX2").getByteValue("errors")>0||json.getJSONObject("TX6").getByteValue("errors")>0){
					map.put("stat", "error");
				}else{
					map.put("stat", "good");
				}
			}else{
				map.put("stat", "error");
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("stat", "error");
		}
		map.put("result", result);
		System.out.println(map);
		return map;
	}
	
	public Array getLogProperties() {
		Array array = super.getLogProperties();
		array.add(pFlowPercent);
		return array;
	}

	static {
		pFlow = new ScalarProperty("_flow", true);
		pFlow.setWindowsPlatforms();
		pFlow.setDisplayText("Service", "the NT service to monitor.");
		pFlow.setParameterOptions(true, 1, false);
		pFlow.allowOther = true;
		pFlowPercent = new NumericProperty("flowerror");
		pFlowPercent.setLabel("flowerror");
		pFlowPercent.setStateOptions(1);
		StringProperty astringproperty[] = { pFlow, pFlowPercent };
		addProperties("com.dragonflow.StandardMonitor.MqttFlowMonitor", astringproperty);
		addClassElement("com.dragonflow.StandardMonitor.MqttFlowMonitor", Rule.stringToClassifier("flowerror > 0\terror", true));
		addClassElement("com.dragonflow.StandardMonitor.MqttFlowMonitor", Rule.stringToClassifier("flowerror == 0\tgood", true));
		setClassProperty("com.dragonflow.StandardMonitor.MqttFlowMonitor", "description", "Measure the flow");
		setClassProperty("com.dragonflow.StandardMonitor.MqttFlowMonitor", "help", "MqttFlowMon.htm");
		setClassProperty("com.dragonflow.StandardMonitor.MqttFlowMonitor", "title", "MqttFlow");
		setClassProperty("com.dragonflow.StandardMonitor.MqttFlowMonitor", "class", "MqttFlowMonitor");
		setClassProperty("com.dragonflow.StandardMonitor.MqttFlowMonitor", "classType", "server");
		setClassProperty("com.dragonflow.StandardMonitor.MqttFlowMonitor", "topazName", "MqttFlow");
		setClassProperty("com.dragonflow.StandardMonitor.MqttFlowMonitor", "topazType", "System Resources");
	}
}

package com.siteview.kernel.mqttclient;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.LinkedBlockingQueue;

import com.siteview.ecc.mqtt.brokers.status.OnlineStatus;
import com.siteview.kernel.mqttutil.AgentUser;
import com.siteview.kernel.mqttutil.ParseRoute;

public class AgentUserManager {
	public static AgentUser getServerAgentUser() throws Exception{
		int port = OnlineStatus.getInstance().serverPort;
		String ip = OnlineStatus.getInstance().getServerIp();
		String pwd = "";
		String address = "#";
		AgentUser serverAgentUser = createServerAgentUser(ip,port,address,pwd);
		return serverAgentUser;
	}
	
	public static Map<String, Boolean> getAllAgentUserStatus() {
		LinkedBlockingQueue<String> linkeds = OnlineStatus.getInstance().onlines;
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		for (String str : linkeds) {
			if (str.contains("weadminserver")) {
				map.put("weadmin/agent2server", true);
			} else {
				map.put(str, true);
			}

		}
		return map;
	}
	
	private static AgentUser createServerAgentUser(String serverIp,int port,String address,String pwd) throws Exception{
		AgentUser agentUser = null;
		if(serverIp==null||serverIp.equals("0.0.0.0")){
			agentUser = new AgentUser("weadmin/agent2server", pwd, ParseRoute.getInstance().getLocalIPAddress(), port, address,null);
		}
		else{
			agentUser =  new AgentUser("weadmin/agent2server", pwd, serverIp, port, address,null);
		}
		return agentUser;
	}
}

package com.siteview.kernel.mqttclient;


import java.net.URI;
import java.util.Map;

import org.eclipse.paho.client.mqttv3.IMqttAsyncClient;
import org.eclipse.paho.client.mqttv3.IMqttToken;
import org.eclipse.paho.client.mqttv3.MqttConnectOptions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.siteview.ecc.mqtt.brokers.status.OnlineStatus;
import com.siteview.kernel.mqttutil.AgentType;
import com.siteview.kernel.mqttutil.AgentUser;

public class AgentService4Mqtt {

	private Logger logger = LoggerFactory.getLogger(AgentService4Mqtt.class);

	private IMqttAsyncClient client;
	private boolean isrunning;
	private int reconnect_time = 5 * 1000;

	private int errorCount = 0;

	public void progressService(){
		connect();
	}

	public void release() {
		try {
			if (client != null && client.isConnected()) {
				client.disconnect();
				if (logger.isDebugEnabled()) {
					logger.debug("mqtt client:" + client.getClientId() + " disconnect");
				}
			}
		} catch (Exception e) {
			logger.error("mqtt client:" + client.getClientId() + " disconnect error", e);
		}
	}

	public synchronized void connect() {
		try {
			if (!mqttclientIsValid()) {
				AgentUser serverAgentUser = getAgentUser();
				client = MqttClientFactoryPaho.getInstance().createMqttAsyncClient(new URI("tcp://" + serverAgentUser.getServerAddress() + ":" + serverAgentUser.getPort()), "weadminserver");//tcp://192.168.9.102:1883
				client.setCallback(new AsyncMqttCallback(this));
				MqttConnectOptions options = new MqttConnectOptions();
				options.setCleanSession(true);
				// options.setConnectionTimeout(30000);
				IMqttToken connectToken = client.connect(options);
				connectToken.waitForCompletion(5000);
				String[] subscribes = { "mqtt/ecc9/#"};
				int[] qs = { 0};
				if (client.isConnected()) {
					isrunning=true;
					System.out.println("---------Start to Subscribe-------");
					IMqttToken subscribeToken = client.subscribe(subscribes, qs);
					subscribeToken.waitForCompletion(5000);
					resetReConnectTime();
					if (logger.isDebugEnabled()) {
						logger.debug("mqtt client:" + client.getClientId() + " subscribe to the success of all agents message request");
					}
				} else {
					if (logger.isDebugEnabled()) {
						logger.debug("mqtt client:" + client.getClientId() + " connect lose,reconnecting ...");
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("mqtt client:" + client.getClientId() + " connect error,reconnecting ...", e);
//			reConnectWait();
//			connect();
		}
	}
	public AgentUser getAgentUser() throws Exception {
		return AgentUserManager.getServerAgentUser();
	}

	public void updateAgentVersion(String from, String to) throws Exception {

	}

	public Map<String, Boolean> getAllAgentUserStatus() {
		return AgentUserManager.getAllAgentUserStatus();
	}
	
	public boolean getAgentUserStatus(String user) {
		return OnlineStatus.getInstance().onlines.contains(user);
	}

	public AgentType getAgentType() {
		return AgentType.MQTT;
	}

	public boolean mqttclientIsValid() {
		return client != null && client.isConnected();

	}

	public IMqttAsyncClient getMqttClient() {
		return client;
	}

	public void resetReConnectTime() {
		reconnect_time = 5000;
		errorCount = 0;
	}

	/*
	 * 增量等待时间
	 */
	private void incrementAddReConnectTime() {
		if (errorCount > 0 && errorCount % 3 == 0) {
			if (reconnect_time > 5 * 60 * 1000) {
				resetReConnectTime();
			} else {
				reconnect_time += reconnect_time;
			}
		}
	}

	/*
	 * 重连等待
	 */
	public void reConnectWait() {
		try {
			Thread.sleep(reconnect_time);
			errorCount++;
		} catch (Exception e) {
		}
		incrementAddReConnectTime();
	}

	public boolean isIsrunning() {
		return isrunning;
	}

	public void setIsrunning(boolean isrunning) {
		this.isrunning = isrunning;
	}
	
}

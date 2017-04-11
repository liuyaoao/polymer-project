package com.siteview.kernel.mqttclient;

import org.eclipse.paho.client.mqttv3.IMqttDeliveryToken;
import org.eclipse.paho.client.mqttv3.MqttCallback;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.siteview.kernel.mqttmessage.MessageUtils;
import com.siteview.kernel.mqttutil.ReceiveMessageContainer;


public class AsyncMqttCallback implements MqttCallback{
	
	private Logger logger = LoggerFactory.getLogger(AsyncMqttCallback.class);
	
	private AgentService4Mqtt agentservice4mqtt;
	
	public AsyncMqttCallback(AgentService4Mqtt agentservice4mqtt){
		this.agentservice4mqtt=agentservice4mqtt;
	}

	@Override
	public void connectionLost(Throwable throwable) {
		if(agentservice4mqtt.isIsrunning()){
			if(logger.isDebugEnabled()){
				logger.debug("mqtt client:"+agentservice4mqtt.getMqttClient().getClientId()+" offline,reconnecting ...");
			}
			agentservice4mqtt.reConnectWait();
			try {
				agentservice4mqtt.connect();
			} 
			catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	@Override
	public void deliveryComplete(IMqttDeliveryToken token) {
		
	}

	@Override
	public void messageArrived(String topic, MqttMessage msg) throws Exception {
			int msgTypeCode=MessageUtils.getMessageTypeCode(msg.getPayload());
			if(msgTypeCode==0){
				CreateOrUpdateEquipmentInfo.getInstance().update(msg.getPayload());
			}
			if(msg.toString().startsWith("{")&&msg.toString().endsWith("}")&&msg.toString().contains("TID")){
				String id="adfas";
				ReceiveMessageContainer.getInstance().receiveMessage(id,msg.getPayload());
			}else
				ReceiveMessageContainer.getInstance().receiveMessage(MessageUtils.getPacketId(msg.getPayload()),
						MessageUtils.getMessage(msg.getPayload()));
	}
}

package com.siteview.kernel.mqttutil;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class ReceiveMessageContainer {

	private Map<String,byte[]> containerMap = new ConcurrentHashMap<String,byte[]>();
	
	private static ReceiveMessageContainer  instance = new ReceiveMessageContainer();
	
	private ReceiveMessageContainer(){
		
	}
	
	public static ReceiveMessageContainer getInstance(){
		return instance;
	}
	
	public void receiveMessage(String key,byte[] msg){
		containerMap.put(key, msg);
	}
	
	public byte[] getMessage(String key){
		return containerMap.get(key);
	}
	
	public String getMessageString(String key){
		if(containerMap.containsKey(key)){
			return new String(containerMap.get(key));
		}
		return null;
	}
	
	public byte[] removeMessage(String key){
		return containerMap.remove(key);
		 
	}
}

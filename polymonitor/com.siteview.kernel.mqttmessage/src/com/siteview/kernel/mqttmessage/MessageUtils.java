package com.siteview.kernel.mqttmessage;

import java.io.UnsupportedEncodingException;
import java.util.Arrays;

/**
 * 在监测信息的字节数组尾部第一个字节存放监测信息类�?
 * �?32个字节存放packetid
 * @author sharklee
 *
 */
public class MessageUtils {

	
	private static byte[] addMessageType(byte[] payload,MessageType type){
		int length = payload.length;
		byte[] result = new byte[length+1];
		for(int i = 0;i<length;i++){
			result[i] = payload[i];
		}
		result[length] = (byte) type.ordinal();
		return result;
	}
	
	public static byte[] addPacketId(byte[] payload,String packetId) throws UnsupportedEncodingException{
		int length = payload.length;
		byte[] idBytes = packetId.getBytes("utf-8");
		int length1 = idBytes.length;
		byte[] result = new byte[length+length1];
		for(int i = 0;i<length;i++){
			result[i] = payload[i];
		}
		for(int j = length;j<length+length1;j++){
			result[j] = idBytes[j-length];
		}
		return result;
	}
	
	public static byte[] transForm(byte[] payload,MessageType type,String packetId) throws UnsupportedEncodingException{
		return addPacketId(addMessageType(payload,type),packetId);
	}
	
	public static int getMessageTypeCode(byte[] payload){
		int length = payload.length;
		return payload[length-33];
	}
	
	public static String getPacketId(byte[] payload){
		int length = payload.length;
		return new String(Arrays.copyOfRange(payload, length-32, length));
	}
	
	public static byte[] getMessage(byte[] payload){
		int length = payload.length;
		return Arrays.copyOfRange(payload, 0, length-33);
	}
}

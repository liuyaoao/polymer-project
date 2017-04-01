package com.siteview.kernel.mqttclient;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
public class CreateOrUpdateEquipmentInfo {
//	private Map<String, User> mapusers = new HashMap<String, User>();
	private String monitorName = null;
	// private String keyvalue = null;
	List<String> erroralarm_key = new ArrayList<String>();
	List<String> erroralarm_show = new ArrayList<String>();
	List<String> goodalarm_key = new ArrayList<String>();
	List<String> goodalarm_show = new ArrayList<String>();
	List<String> warningalarm_key = new ArrayList<String>();
	List<String> warningalarm_show = new ArrayList<String>();
	static List<String> os_list = new ArrayList<String>();
	static CreateOrUpdateEquipmentInfo equipmentInfo = null;
	// String subgroupsgroups;
	public static ExecutorService pool = Executors.newFixedThreadPool(30);
	static {
		os_list.add("AIX");
		os_list.add("CentOS");
		os_list.add("Fedora");
		os_list.add("FreBSD");
		os_list.add("HP/Ux");
		os_list.add("HP/UX 64-bit");
		os_list.add("Linux");
		os_list.add("MaxOSX");
		os_list.add("OPENSERVER");
		os_list.add("Red Hat Enterprise Linux");
		os_list.add("SCO");
		os_list.add("SGI Irix");
		os_list.add("SUSE");
		os_list.add("Ubuntu");
	}

	public static CreateOrUpdateEquipmentInfo getInstance() {
		if (equipmentInfo == null) {
			equipmentInfo = new CreateOrUpdateEquipmentInfo();
		}
		return equipmentInfo;
	}



	public void update(byte[] message) throws Exception {}

	/**
	 * 灏嗕簩杩涘埗杞崲锟�?6杩涘埗
	 * 
	 * @param buf
	 * @return
	 */
	public static String parseByte2HexStr(byte buf[]) {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < buf.length; i++) {
			String hex = Integer.toHexString(buf[i] & 0xFF);
			if (hex.length() == 1) {
				hex = '0' + hex;
			}
			sb.append(hex.toUpperCase());
		}
		return sb.toString();
	}

	/**
	 * 锟�?6杩涘埗杞崲涓轰簩杩涘埗
	 * 
	 * @param hexStr
	 * @return
	 */
	public static byte[] parseHexStr2Byte(String hexStr) {
		if (hexStr.length() < 1)
			return null;
		byte[] result = new byte[hexStr.length() / 2];
		for (int i = 0; i < hexStr.length() / 2; i++) {
			int high = Integer.parseInt(hexStr.substring(i * 2, i * 2 + 1), 16);
			int low = Integer.parseInt(hexStr.substring(i * 2 + 1, i * 2 + 2), 16);
			result[i] = (byte) (high * 16 + low);
		}
		return result;
	}

	/**
	 * 瑙ｅ瘑
	 * 
	 * @param content
	 *            寰呰В瀵嗗唴锟�?
	 * @param password
	 *            瑙ｅ瘑瀵嗛挜
	 * @return
	 */
	public static byte[] decrypt(byte[] content, String password) {
		try {
			KeyGenerator kgen = KeyGenerator.getInstance("AES");
			kgen.init(128, new SecureRandom(password.getBytes()));
			SecretKey secretKey = kgen.generateKey();
			byte[] enCodeFormat = secretKey.getEncoded();
			SecretKeySpec key = new SecretKeySpec(enCodeFormat, "AES");
			Cipher cipher = Cipher.getInstance("AES");// 鍒涘缓瀵嗙爜锟�?
			cipher.init(Cipher.DECRYPT_MODE, key);// 鍒濆锟�?
			byte[] result = cipher.doFinal(content);
			return result; // 鍔犲瘑
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (NoSuchPaddingException e) {
			e.printStackTrace();
		} catch (InvalidKeyException e) {
			e.printStackTrace();
		} catch (IllegalBlockSizeException e) {
			e.printStackTrace();
		} catch (BadPaddingException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 鍔犲瘑
	 * 
	 * @param content
	 *            锟�?锟斤拷鍔犲瘑鐨勫唴锟�?
	 * @param password
	 *            鍔犲瘑瀵嗙爜
	 * @return
	 */
	public static byte[] encrypt(String content, String password) {
		try {
			KeyGenerator kgen = KeyGenerator.getInstance("AES");
			kgen.init(128, new SecureRandom(password.getBytes()));
			SecretKey secretKey = kgen.generateKey();
			byte[] enCodeFormat = secretKey.getEncoded();
			SecretKeySpec key = new SecretKeySpec(enCodeFormat, "AES");
			Cipher cipher = Cipher.getInstance("AES");// 鍒涘缓瀵嗙爜锟�?
			byte[] byteContent = content.getBytes("utf-8");
			cipher.init(Cipher.ENCRYPT_MODE, key);// 鍒濆锟�?
			byte[] result = cipher.doFinal(byteContent);
			return result; // 鍔犲瘑
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (NoSuchPaddingException e) {
			e.printStackTrace();
		} catch (InvalidKeyException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IllegalBlockSizeException e) {
			e.printStackTrace();
		} catch (BadPaddingException e) {
			e.printStackTrace();
		}
		return null;
	}

	public static void main(String[] args) {
		byte[] ss = encrypt("w shuo ", "siteview");
		for (int i = 0; i < ss.length; i++) {
			System.out.printf("%X", ss[i]);
		}
	}
	public String getSpecialProperties(String value,String key,String value1){
		if(value.contains(key)){
			String start=value.substring(0, value.indexOf(key+"="));
			value=value.substring(value.indexOf(key+"="));
			if(value.contains(","))
				value=value.substring(value.indexOf(",")+1);
			else
				value="";
			if(start.length()>0&&!start.endsWith(","))
				start+=",";
			start+=key+"="+value1;
			if(value.length()>0&&!value.endsWith(","))
				value=","+value;		
			value=start+value;
		}else{
			if(value.length()>0)
				value+=",";
			value+=key+"="+value1;
		}
		return value;
	}
}

package com.siteview.kernel.mqttutil;

import java.util.Map;
public interface IAgentService {
	
	/*
	 * 消息发�??
	 */
	public String sendMessage(String from,String to,byte[] msg) throws Exception;
	
	/*
	 * 获取server的用户信�?
	 */
	public AgentUser getAgentUser() throws Exception;
	
	/*
	 * 版本升级
	 */
	public void updateAgentVersion(String from,String to) throws Exception;
	
	/*
	 * 获取�?有Agent用户信息状�?�״�?
	 */
	public Map<String,Boolean> getAllAgentUserStatus();
	
	/*
	 * 获取当前用户状�?�信�?
	 */
	public boolean getAgentUserStatus(String user);
	
	/*
	 * 获取Agent类型
	 */
	public AgentType getAgentType();
}

package com.siteview.kernel.mqttutil;

import java.util.Map;

public class AgentUser {
	private String user;
	private String pwd;
	private String serveraddress;
	private String port;
	private String hostName;
	private String domainName;
	public static AgentUser xmppUser = null;

	//
	public AgentUser(String userName, String userPwd, String serveraddress, int port, String host, String domainName) {
		super();
		this.user = userName;
		this.pwd = userPwd;
		this.serveraddress = serveraddress;
		this.port = port + "";
		this.hostName = host;
		this.domainName = domainName;
	}

	// public void SaveXmppUser() {
	// if (xmppbo == null) {
	// xmppUser = new XmppUser();
	// }
	// try {
	// xmppbo.GetField("xmppuser").SetValue(new SiteviewValue(this.user));
	// xmppbo.GetField("xmpppwd").SetValue(new SiteviewValue(this.pwd));
	// xmppbo.GetField("xmppServer").SetValue(new
	// SiteviewValue(this.xmppServer));
	// xmppbo.GetField("xmppPort").SetValue(new SiteviewValue(this.xmppPort));
	// xmppbo.GetField("hostName").SetValue(new SiteviewValue(this.hostName));
	// xmppbo.SaveObject(ConnectionBroker.get_SiteviewApi(), true, true);
	// } catch (SiteviewException e) {
	// e.printStackTrace();
	// }
	// }

	// private XmppUser() {
	// try {
	// if (Activator.xmppUser == null) {
	// String xmpphostname = "";
	// String xmppserver = "";
	// String xmppport = "";
	// SiteviewQuery query = new SiteviewQuery();
	// query.AddBusObQuery("XmppUser", QueryInfoToGet.All);
	// Element xml =
	// query.get_CriteriaBuilder().FieldAndValueExpression("xmppType",
	// Operators.Equals, "PrimaryServer");
	// query.AddOrderByDesc("CreatedDateTime");
	// query.set_BusObSearchCriteria(xml);
	// BusinessObject bo =
	// ConnectionBroker.get_SiteviewApi().get_BusObService().GetBusinessObject(query);
	// BundleContext context = Activator.plugin.getBundle().getBundleContext();
	// ServiceReference<?> ref =
	// context.getServiceReference(XMPPServerInfo.class.getName());
	// if (ref != null) {
	// XMPPServerInfo info = (XMPPServerInfo)context.getService(ref);
	// xmppserver = info.getHostname();
	// xmpphostname = info.getIP();
	// xmppport = info.getSSLPort() + "";
	// Map<String,UserModel> map = info.getUsers();
	// if (map.get("itossmonitor") == null) {
	// info.addUser("itossmonitor", "qwe123!@#");
	// }
	// }
	// if (bo == null) {
	// bo =
	// ConnectionBroker.get_SiteviewApi().get_BusObService().Create("XmppUser");
	// }
	// bo.GetField("xmppuser").SetValue(new SiteviewValue("itossmonitor"));
	// bo.GetField("xmpppwd").SetValue(new SiteviewValue("qwe123!@#"));
	// // bo.GetField("xmppServer").SetValue(new
	// // SiteviewValue("xmpp.bigit.com"));
	// // bo.GetField("xmppPort").SetValue(new SiteviewValue(995));
	// // bo.GetField("hostName").SetValue(new
	// // SiteviewValue("xmpp1.bigit.com"));
	// bo.GetField("xmppServer").SetValue(new SiteviewValue(xmppserver));
	// bo.GetField("xmppPort").SetValue(new
	// SiteviewValue(Integer.parseInt(xmppport)));
	// bo.GetField("hostName").SetValue(new SiteviewValue(xmpphostname));
	// bo.GetField("xmppType").SetValue(new SiteviewValue("PrimaryServer"));
	// bo.SaveObject(ConnectionBroker.get_SiteviewApi(), true,
	// true).get_SaveSuccess();
	// this.user = bo.GetField("xmppuser").get_Value().toString();
	// this.pwd = bo.GetField("xmpppwd").get_Value().toString();
	// this.xmppServer = bo.GetField("xmppServer").get_Value().toString();
	// this.xmppPort = bo.GetField("xmppPort").get_Value().toString();
	// this.hostName = bo.GetField("hostName").get_Value().toString();
	// this.xmppbo = bo;
	// Activator.xmppUser = this;
	// } else {
	// xmppUser = Activator.xmppUser;
	// }
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	// }

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getServerAddress() {
		return serveraddress;
	}

	public void setServerAddress(String serveraddress) {
		this.serveraddress = serveraddress;
	}

	public String getPort() {
		return port;
	}

	public void setPort(String port) {
		this.port = port;
	}

	public String getHostName() {
		return hostName;
	}

	public void setHostName(String hostName) {
		this.hostName = hostName;
	}

	public String getDomainName() {
		return domainName;
	}

	public void setDomainName(String domainName) {
		this.domainName = domainName;
	}

}

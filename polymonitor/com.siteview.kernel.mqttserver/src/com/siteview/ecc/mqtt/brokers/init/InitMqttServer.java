package com.siteview.ecc.mqtt.brokers.init;

import java.io.File;

import org.eclipse.moquette.server.Server;

public class InitMqttServer {

	public InitMqttServer() {
	}


	public static void execute() {
		try {
			String rootDir = System.getProperty("user.dir");
			File sysFile = new File(rootDir,"config/moquette.conf");
			System.setProperty("moquette.path",sysFile.getPath());
			Server server = new Server();
			server.startServer();
	        
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public static void main(String[] args) {
		System.out.println(System.getProperty("user.dir"));
	}
}

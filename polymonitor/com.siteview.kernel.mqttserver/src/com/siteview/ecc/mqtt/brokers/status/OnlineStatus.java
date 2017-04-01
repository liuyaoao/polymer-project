package com.siteview.ecc.mqtt.brokers.status;

import java.util.concurrent.LinkedBlockingQueue;

public class OnlineStatus {

    public String serverIp="0.0.0.0";
    public int serverPort;
    
    public final LinkedBlockingQueue<String> onlines = new LinkedBlockingQueue<String>();

    private static OnlineStatus onlineStatus = null;

    private OnlineStatus() {
    }

    public static OnlineStatus getInstance() {
        if (onlineStatus == null) {
            synchronized (OnlineStatus.class) {
                onlineStatus = new OnlineStatus();
            }
        }
        return onlineStatus;
    }

    public String getServerIp() {
        return serverIp;
    }

    public void setServerIp(String serverIp) {
        this.serverIp = serverIp;
    }

    public int getServerPort() {
        return serverPort;
    }

    public void setServerPort(int serverPort) {
        this.serverPort = serverPort;
    }

    
    
}

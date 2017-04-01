package org.eclipse.moquette.server;

import java.util.Date;

public class ClientEntityBean {
    
    private String clientId;
    private int keepAliveTime;
    private Date lastConnTime;
    private int status; //0 - line; 1 - offline;
    
    public ClientEntityBean() {
        
    }

    public ClientEntityBean(String clientId, int keepAliveTime,
            Date lastConnTime, int status) {
        super();
        this.clientId = clientId;
        this.keepAliveTime = keepAliveTime;
        this.lastConnTime = lastConnTime;
        this.status = status;
    }

    public String getClientId() {
        return clientId;
    }

    public void setClientId(String clientId) {
        this.clientId = clientId;
    }

    public int getKeepAliveTime() {
        return keepAliveTime;
    }

    public void setKeepAliveTime(int keepAliveTime) {
        this.keepAliveTime = keepAliveTime;
    }

    public Date getLastConnTime() {
        return lastConnTime;
    }

    public void setLastConnTime(Date lastConnTime) {
        this.lastConnTime = lastConnTime;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
    
    

}

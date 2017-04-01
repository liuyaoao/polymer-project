package org.eclipse.moquette.server;

import java.util.Date;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class OnlineStatusHandler {

    private String id;
    private Map<String, Date> lastConTimes = new ConcurrentHashMap<String, Date>();

    private static OnlineStatusHandler statusHandler = null;

    private OnlineStatusHandler() {
    }

    public static OnlineStatusHandler getInstance() {
        if (statusHandler == null) {
            synchronized (OnlineStatusHandler.class) {
                statusHandler = new OnlineStatusHandler();
            }
        }
        return statusHandler;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Map<String, Date> getLastConTimes() {
        return lastConTimes;
    }

    public void setLastConTimes(Map<String, Date> lastConTimes) {
        this.lastConTimes = lastConTimes;
    }
    
}

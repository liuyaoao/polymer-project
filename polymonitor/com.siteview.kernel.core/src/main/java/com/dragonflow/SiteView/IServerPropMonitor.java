/*
 * 
 * Created on 2014-2-16 15:14:00
 *
 * IServerPropMonitor.java
 *
 * History:
 *
 */
package com.dragonflow.SiteView;

/**
 * Comment for <code>IServerPropMonitor</code>
 * 
 * @author
 * @version 0.0
 * 
 * 
 */
import com.dragonflow.Properties.StringProperty;

public interface IServerPropMonitor {

    public abstract StringProperty getServerProperty();

    public abstract boolean remoteCommandLineAllowed();
}

/*
 * 
 * Created on 2014-2-16 15:14:00
 *
 * GreaterEqualMonitorName.java
 *
 * History:
 *
 */
package com.dragonflow.SiteView;

/**
 * Comment for <code>GreaterEqualMonitorName</code>
 * 
 * @author
 * @version 0.0
 * 
 * 
 */
import jgl.BinaryPredicate;

// Referenced classes of package com.dragonflow.SiteView:
// Monitor

public class GreaterEqualMonitorName implements BinaryPredicate {

    public GreaterEqualMonitorName() {
    }

    public boolean execute(Object obj, Object obj1) {
        String s = ((Monitor) obj).getProperty(Monitor.pName);
        String s1 = ((Monitor) obj1).getProperty(Monitor.pName);
        s = s.toLowerCase();
        s1 = s1.toLowerCase();
        return s.compareTo(s1) > 0;
    }
}
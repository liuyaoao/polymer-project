/*
 * Created on 2014-2-9 3:06:20
 *
 * .java
 *
 * History:
 *
 */
package com.dragonflow.Utils;

import com.dragonflow.SiteView.Platform;

/**
 * Comment for <code></code>
 * 
 * @author
 * @version 0.0
 * 
 * 
 */

// Referenced classes of package com.dragonflow.Utils:
// MediaPlayerMonitorUtils
public class RealPlayerMonitorUtils extends com.dragonflow.Utils.MediaPlayerMonitorUtils {

    private static String VugenScriptPath = Platform.getRoot() + "\\media\\real\\real.usr";

    private static String logFileRoot = "\\RealMedia";

    public RealPlayerMonitorUtils() {
    }

    protected String getLogFileRoot() {
        return logFileRoot;
    }

    protected String getVugenScriptPath() {
        return VugenScriptPath;
    }

}

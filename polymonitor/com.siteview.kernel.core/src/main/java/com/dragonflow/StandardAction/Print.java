/*
 * Created on 2014-3-10 22:16:20
 *
 * .java
 *
 * History:
 *
 */
package com.dragonflow.StandardAction;

/**
 * Comment for <code></code>
 * 
 * @author
 * @version 0.0
 * 
 * 
 */

public class Print extends com.dragonflow.SiteView.Action {

    public Print() {
        runType = 3;
        maxRuns = 50;
        attemptDelay = 7000L;
    }

    public boolean execute() {
        System.out.print("Print: ");
        for (int i = 0; i < args.length; i ++) {
            System.out.print(args[i] + " ");
        }

        System.out.println(" (" + monitor + ")");
        boolean flag = triggerCount > 35;
        if (flag) {
            messageBuffer.append("Print succeeded");
        } else {
            messageBuffer.append("PRINT FAILED: " + args[0]);
        }
        return flag;
    }
}

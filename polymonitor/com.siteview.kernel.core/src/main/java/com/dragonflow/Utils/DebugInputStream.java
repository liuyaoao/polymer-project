/*
 * Created on 2014-2-9 3:06:20
 *
 * .java
 *
 * History:
 *
 */
package com.dragonflow.Utils;

/**
 * Comment for <code></code>
 * 
 * @author
 * @version 0.0
 * 
 * 
 */

class DebugInputStream extends java.io.InputStream {

    java.io.InputStream is;

    DebugInputStream(java.io.InputStream inputstream) {
        is = null;
        is = inputstream;
    }

    public int read() throws java.io.IOException {
        int i = is.read();
        System.out.print((char) i);
        return i;
    }
}

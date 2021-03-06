/*
 * 
 * Created on 2014-4-20 18:55:36
 *
 * PDHRawCounterCache.java
 *
 * History:
 *
 */
package com.dragonflow.Utils.WebSphere;

public class ConnectionException extends java.lang.Exception {

    java.lang.Exception e;

    public ConnectionException(java.lang.Exception exception) {
        super("Inner exception is: " + exception);
        e = exception;
    }

    public ConnectionException(String s) {
        super(s);
    }

    public java.lang.Exception getInnerException() {
        return e;
    }
}

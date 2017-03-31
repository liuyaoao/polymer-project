/*
 * 
 * Created on 2014-4-20 22:12:36
 *
 * .java
 *
 * History:
 *
 */
package com.dragonflow.Page;

class monitorSetFilter implements java.io.FilenameFilter {

    String m_suffix;

    monitorSetFilter(String s) {
        m_suffix = s;
    }

    public boolean accept(java.io.File file, String s) {
        return s.endsWith(m_suffix);
    }
}

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

class GreaterEqualProcessInfo implements jgl.BinaryPredicate {

    GreaterEqualProcessInfo() {
    }

    public boolean execute(Object obj, Object obj1) {
        String s = (String) ((jgl.HashMap) obj).get("name");
        String s1 = (String) ((jgl.HashMap) obj1).get("name");
        s = s.toLowerCase();
        s1 = s1.toLowerCase();
        return s1.compareTo(s) > 0;
    }
}

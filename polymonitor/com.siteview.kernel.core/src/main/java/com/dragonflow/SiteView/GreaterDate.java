/*
 * 
 * Created on 2014-2-16 15:13:16
 *
 * GreaterDate.java
 *
 * History:
 *
 */
package com.dragonflow.SiteView;

/**
 * Comment for <code>GreaterDate</code>
 * 
 * @author
 * @version 0.0
 * 
 * 
 */
import java.util.Date;

import jgl.BinaryPredicate;

public final class GreaterDate implements BinaryPredicate {

    public GreaterDate() {
    }

    public boolean execute(Object obj, Object obj1) {
        return ((Date) obj).after((Date) obj1);
    }
}

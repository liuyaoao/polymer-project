/*
 * 
 * Created on 2014-2-16 17:36:33
 *
 * Weblogic6xObject.java
 *
 * History:
 *
 */
package com.dragonflow.SiteView;

/**
 * Comment for <code>Weblogic6xObject</code>
 * 
 * @author
 * @version 0.0
 * 
 * 
 */
import java.util.Vector;

import com.dragonflow.Log.LogManager;
import com.dragonflow.Utils.JMXInterface;

// Referenced classes of package com.dragonflow.SiteView:
// JMXObject

public class Weblogic6xObject extends JMXObject {

    public Weblogic6xObject() {
    }

    public Weblogic6xObject(Object obj, Object obj1, JMXInterface jmxinterface) {
        super(obj, obj1, jmxinterface);
        try {
            type = (String) jmxinterface.getKeyPropertyMethod.invoke(obj, new Object[] { "Type" });
            name = null;
            if ("TransactionNameRuntime".equals(type)) {
                name = (String) getAttribute("TransactionName");
            } else if ("WebAppComponentRuntime".equals(type)) {
                name = (String) jmxinterface.getKeyPropertyMethod.invoke(obj, new Object[] { "Name" });
                for (String s = (String) jmxinterface.getKeyPropertyMethod.invoke(obj, new Object[] { "Location" }) + "_"; name.toString().startsWith(s); name = name.toString().substring(s.length())) {
                }
            } else if ("ServletRuntime".equals(type)) {
                name = (String) getAttribute("ServletName");
                if (name == null) {
                    name = (String) jmxinterface.getKeyPropertyMethod.invoke(obj, new Object[] { "Name" });
                }
            }
            if (name == null) {
                name = (String) jmxinterface.getKeyPropertyMethod.invoke(obj, new Object[] { "Name" });
            }
            try {
                parentName = jmxinterface.getAttributeMethod.invoke(obj1, new Object[] { obj, "Parent" });
            } catch (Exception exception) {
                parentName = null;
            }
            addCounters();
        } catch (Exception exception1) {
            LogManager.log("Error", "Failed to parse MBean object: " + exception1);
        }
    }

    public Weblogic6xObject(Object obj, Weblogic6xObject weblogic6xobject, Object obj1, JMXInterface jmxinterface) {
        this(obj, obj1, jmxinterface);
        parent = weblogic6xobject;
    }

    /**
     * 
     * 
     * @return
     */
    int addCounters() {
        if (cachedCounters.containsKey(type)) {
            counters = (Vector) cachedCounters.get(type);
        } else {
            counters = new Vector();
            try {
                Object obj = management.getMBeanInfoMethod.invoke(mbs, new Object[] { objectName });
                Object aobj[] = (Object[]) management.getAttributesMethod.invoke(obj, null);
                for (int i = 0; i < aobj.length; i ++) {
                    if (((Boolean) management.isReadableMethod.invoke(aobj[i], null)).booleanValue()) {
                        String s = (String) management.getTypeMethod.invoke(aobj[i], null);
                        String as[] = { "byte", "short", "int", "long", "float", "double","java.lang.Long"};

                        for (int j = 0; j < as.length; j ++) {
                            if (s.equals(as[j])) {
                                String s1 = (String) management.getNameMethod.invoke(aobj[i], null);
                                String s2 = (String) management.getDescriptionMethod.invoke(aobj[i], null);
                                counters.add(new JMXObject.Counter(this, s1, s2));
                                break;
                            }
                        }
                    }
                }

            } catch (Exception exception) {
                LogManager.log("Error", "Failed to add counters for MBean " + objectName + ", exception: " + exception);
            }
            cachedCounters.put(type, counters);
        }
        return counters.size();
    }
}

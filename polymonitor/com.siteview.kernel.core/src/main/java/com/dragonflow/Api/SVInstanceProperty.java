/*
 * Created on 2014-3-10 22:16:20
 *
 * .java
 *
 * History:
 *
 */
package com.dragonflow.Api;

/**
 * Comment for <code></code>
 * 
 * @author
 * @version 0.0
 * 
 * 
 */

// Referenced classes of package com.dragonflow.Api:
// SSBaseReturnValues
public class SVInstanceProperty extends com.dragonflow.Api.SVBaseReturnValues {

    private String name;

    private String label;

    private java.lang.Object value;

    public SVInstanceProperty(String name, java.lang.Object value) {
        this.name = name;
        this.value = value;
    }

    public String toString() {
        return "(" + name + ", " + label + ", " + (String) value + ")";
    }

    public SVInstanceProperty(String name, String label, java.lang.Object value) {
        this.name = name;
        this.label = label;
        this.value = value;
    }

    public java.lang.Object getReturnValueType() {
        java.lang.Class class1 = getClass();
        return class1.getName();
    }

    public String getName() {
        return name;
    }

    public String getLabel() {
        return label;
    }

    public java.lang.Object getValue() {
        return value;
    }
}

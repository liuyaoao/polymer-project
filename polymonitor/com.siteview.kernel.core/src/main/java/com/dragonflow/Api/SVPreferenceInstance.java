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
// SSBaseReturnValues, SSInstanceProperty

public class SVPreferenceInstance extends com.dragonflow.Api.SVBaseReturnValues
{

    private String settingName;
    private com.dragonflow.Api.SVInstanceProperty instanceProperties[];

    public SVPreferenceInstance(String s, com.dragonflow.Api.SVInstanceProperty assinstanceproperty[])
    {
        settingName = s;
        instanceProperties = assinstanceproperty;
    }

    public java.lang.Object getReturnValueType()
    {
        java.lang.Class class1 = getClass();
        return class1.getName();
    }

    public String getSettingName()
    {
        return settingName;
    }

    public com.dragonflow.Api.SVInstanceProperty[] getInstanceProperties()
    {
        return instanceProperties;
    }
}

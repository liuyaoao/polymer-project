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

public class SSGroupInstance extends SSBaseReturnValues
{

    private String groupId;
    private SSInstanceProperty instanceProperties[];

    public SSGroupInstance(String s, SSInstanceProperty assinstanceproperty[])
    {
        groupId = s;
        instanceProperties = assinstanceproperty;
    }

    public java.lang.Object getReturnValueType()
    {
        java.lang.Class class1 = getClass();
        return class1.getName();
    }

    public String getGroupId()
    {
        return groupId;
    }

    public SSInstanceProperty[] getInstanceProperties()
    {
        return instanceProperties;
    }
}

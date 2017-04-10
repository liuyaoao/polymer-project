/*
 * Created on 2014-3-10 22:16:20
 *
 * .java
 *
 * History:
 *
 */
package com.dragonflow.Api;


// Referenced classes of package com.dragonflow.Api:
// SSBaseReturnValues, SSInstanceProperty

public class SVMonitorInstance extends SVBaseReturnValues
{

    private String groupId;
    private String monitorId;
    private SVInstanceProperty instanceProperties[];

    public SVMonitorInstance(String s, String s1, SVInstanceProperty assinstanceproperty[])
    {
        groupId = s;
        monitorId = s1;
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

    public String getMonitorId()
    {
        return monitorId;
    }

    public SVInstanceProperty[] getInstanceProperties()
    {
        return instanceProperties;
    }
}

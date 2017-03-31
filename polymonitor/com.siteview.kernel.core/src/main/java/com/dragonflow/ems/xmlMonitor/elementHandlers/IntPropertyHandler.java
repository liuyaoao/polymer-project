//   Date: 2005-3-8 13:55:26

 
// Source File Name:   IntPropertyHandler.java

package com.dragonflow.ems.xmlMonitor.elementHandlers;

import com.dragonflow.Properties.NumericProperty;
import com.dragonflow.Properties.StringProperty;

// Referenced classes of package com.dragonflow.ems.xmlMonitor.elementHandlers:
//            StringPropertyHandler, PropertyHandlerDispatcher

public class IntPropertyHandler extends StringPropertyHandler
{

    public IntPropertyHandler(PropertyHandlerDispatcher dispatcher)
    {
        super(dispatcher);
    }

    protected StringProperty getProperty(String name, String defaultVal)
    {
        StringProperty p;
        if(defaultVal != null && defaultVal.trim().length() > 0)
            p = new NumericProperty(name, defaultVal);
        else
            p = new NumericProperty(name);
        return p;
    }
}
//   Date: 2005-3-8 13:55:27

 
// Source File Name:   PasswordPropertyHandler.java

package com.dragonflow.ems.xmlMonitor.elementHandlers;

import com.dragonflow.Properties.StringProperty;

// Referenced classes of package com.dragonflow.ems.xmlMonitor.elementHandlers:
//            StringPropertyHandler, PropertyHandlerDispatcher

public class PasswordPropertyHandler extends StringPropertyHandler
{

    public PasswordPropertyHandler(PropertyHandlerDispatcher dispatcher)
    {
        super(dispatcher);
    }

    protected StringProperty getProperty(String name, String defaultVal)
    {
        StringProperty p = super.getProperty(name, defaultVal);
        p.isPassword = true;
        return p;
    }
}
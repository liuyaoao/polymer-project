//   Date: 2005-3-8 13:55:27

 
// Source File Name:   ConfigFilePathPropertyHandler.java

package com.dragonflow.ems.xmlMonitor.elementHandlers;

import com.dragonflow.Properties.StringProperty;
import com.dragonflow.ems.Shared.EmsConfigFileProperty;
import java.util.Vector;
import org.xml.sax.Attributes;

// Referenced classes of package com.dragonflow.ems.xmlMonitor.elementHandlers:
//            PropertyHandler, PropertyHandlerDispatcher

public class ConfigFilePathPropertyHandler
    implements PropertyHandler
{

    public ConfigFilePathPropertyHandler(PropertyHandlerDispatcher dispatcher)
    {
        this.dispatcher = dispatcher;
    }

    protected StringProperty getProperty()
    {
        StringProperty p = new EmsConfigFileProperty(dispatcher.getFolderName());
        return p;
    }

    public void handleProperty(Attributes attrs, Vector props)
    {
        StringProperty p = getProperty();
        int counter = dispatcher.getCounter(true);
        p.setParameterOptions(true, counter, true);
        props.add(p);
    }

    protected PropertyHandlerDispatcher dispatcher;
}
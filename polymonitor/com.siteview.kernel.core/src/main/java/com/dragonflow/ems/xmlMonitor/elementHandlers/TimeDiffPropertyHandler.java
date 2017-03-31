package com.dragonflow.ems.xmlMonitor.elementHandlers;

import com.dragonflow.Properties.StringProperty;
import com.dragonflow.ems.Shared.EmsTimeDiffProperty;
import java.util.Vector;
import org.xml.sax.Attributes;

// Referenced classes of package com.dragonflow.ems.xmlMonitor.elementHandlers:
//            PropertyHandler, PropertyHandlerDispatcher

public class TimeDiffPropertyHandler
    implements PropertyHandler
{

    public TimeDiffPropertyHandler(PropertyHandlerDispatcher dispatcher)
    {
        this.dispatcher = dispatcher;
    }

    public void handleProperty(Attributes attrs, Vector props)
    {
        StringProperty p = new EmsTimeDiffProperty();
        int counter = dispatcher.getCounter(true);
        p.setParameterOptions(true, counter, true);
        props.add(p);
    }

    private PropertyHandlerDispatcher dispatcher;
}
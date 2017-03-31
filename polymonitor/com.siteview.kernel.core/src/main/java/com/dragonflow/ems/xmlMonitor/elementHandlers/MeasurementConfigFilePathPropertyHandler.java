//   Date: 2005-3-8 13:55:25

 
// Source File Name:   MeasurementConfigFilePathPropertyHandler.java

package com.dragonflow.ems.xmlMonitor.elementHandlers;

import com.dragonflow.Properties.StringProperty;
import com.dragonflow.ems.Shared.EmsMeasurementConfigFileProperty;

// Referenced classes of package com.dragonflow.ems.xmlMonitor.elementHandlers:
//            ConfigFilePathPropertyHandler, PropertyHandlerDispatcher

public class MeasurementConfigFilePathPropertyHandler extends ConfigFilePathPropertyHandler
{

    public MeasurementConfigFilePathPropertyHandler(PropertyHandlerDispatcher dispatcher)
    {
        super(dispatcher);
    }

    protected StringProperty getProperty()
    {
        StringProperty p = new EmsMeasurementConfigFileProperty(dispatcher.getFolderName());
        return p;
    }
}
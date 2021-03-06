/*
 * 
 * Created on 2014-3-7 1:21:00
 *
 * HealthMonitorBase.java
 *
 * History:
 *
 */
package com.dragonflow.StandardMonitor;

/**
 * Comment for <code>HealthMonitorBase</code>
 * 
 * @author 
 * @version 0.0
 *
 *
 */
import com.dragonflow.Health.FileBase;
import com.dragonflow.Properties.NumericProperty;
import com.dragonflow.Properties.StringProperty;
import com.dragonflow.SiteView.AtomicMonitor;
import jgl.Array;

public class HealthMonitorBase extends AtomicMonitor
{

 protected static NumericProperty pNumErrors;

 public HealthMonitorBase()
 {
 }

 public String getHostname()
 {
     return "";
 }

 public Array getLogProperties()
 {
     Array array = super.getLogProperties();
     array.add(pNumErrors);
     return array;
 }

 protected void setStatus(FileBase filebase)
 {
     Array array = filebase.errorCheck();
     if(array.size() > 0)
     {
         StringBuffer stringbuffer = new StringBuffer(256);
         for(int i = 0; i < array.size(); i++)
         {
             com.dragonflow.Health.FileBase.ErrorMessage errormessage = (com.dragonflow.Health.FileBase.ErrorMessage)array.at(i);
             stringbuffer.append(errormessage.message);
             if(i != array.size() - 1)
             {
                 stringbuffer.append(", ");
             }
         }

         setProperty(pStateString, stringbuffer.toString());
     } else
     {
         setProperty(pStateString, "no errors");
     }
     setProperty(pNumErrors, Integer.toString(array.size()));
 }

 public int getCostInLicensePoints()
 {
     return 0;
 }

 static 
 {
     String s = (com.dragonflow.StandardMonitor.HealthMonitorBase.class).getName();
     pNumErrors = new NumericProperty("numErrors", "0");
     pNumErrors.setLabel("numErrors");
     pNumErrors.setStateOptions(1);
     StringProperty astringproperty[] = {
         pNumErrors
     };
     addProperties(s, astringproperty);
 }
}

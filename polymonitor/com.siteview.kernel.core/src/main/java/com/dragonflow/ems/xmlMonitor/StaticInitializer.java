//   Date: 2005-2-22 15:16:04

 
// Source File Name:   StaticInitializer.java

package com.dragonflow.ems.xmlMonitor;

import com.dragonflow.Properties.StringProperty;
import com.dragonflow.SiteView.Platform;
import java.io.*;
import java.util.ResourceBundle;
import org.xml.sax.*;
import org.xml.sax.helpers.XMLReaderFactory;

// Referenced classes of package com.dragonflow.ems.xmlMonitor:
//            StaticInitializeSaxHandler

public class StaticInitializer
{

    public StaticInitializer()
    {
    }

    public static String getRoot()
    {
        return rootDir;
    }

    public static String getString(String key)
    {
        String val = "";
        if(key != null)
            val = rc.getString(key);
        return val;
    }

    public static StringProperty[] initialize(String xmlFile)
    {
        XMLReader parser = null;
        StaticInitializeSaxHandler handler = new StaticInitializeSaxHandler();
        try
        {
            parser = XMLReaderFactory.createXMLReader("org.apache.xerces.parsers.SAXParser");
            parser.setContentHandler(handler);
            FileInputStream fi = new FileInputStream(xmlFile);
            parser.parse(new InputSource(new InputStreamReader(fi, "UTF-8")));
            fi.close();
        }
        catch(SAXException e)
        {
            e.printStackTrace();
        }
        catch(IOException e)
        {
            e.printStackTrace();
        }
        return handler.getProps();
    }

    static String rootDir;
    static ResourceBundle rc = ResourceBundle.getBundle("com.dragonflow.ems.xmlMonitor.monitors");

    static 
    {
        rootDir = Platform.getRoot() + File.pathSeparatorChar + "ems" + File.pathSeparatorChar;
    }
}
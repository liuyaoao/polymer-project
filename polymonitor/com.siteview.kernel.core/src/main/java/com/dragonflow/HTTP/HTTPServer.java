package com.dragonflow.HTTP;

/**
 * Comment for <code></code>
 * 
 * @author
 * @version 0.0
 * 
 * 
 */

import java.net.ServerSocket;
import java.util.Enumeration;
import java.util.HashSet;

import jgl.Array;
import jgl.HashMap;
import com.dragonflow.Log.LogManager;
import com.dragonflow.SiteView.MasterConfig;
import com.dragonflow.SiteView.SiteViewGroup;
import com.dragonflow.Utils.SSLSocketStream;
import com.dragonflow.Utils.SocketStream;
import com.dragonflow.Utils.TextUtils;

// Referenced classes of package com.dragonflow.HTTP:
// HTTPRequestThread, VirtualDirectory

public class HTTPServer
    implements java.lang.Runnable
{

    private ServerSocket serverSocket;
    private boolean running;
    private jgl.Array virtualDirectories;
    private jgl.HashMap typeMap;
    private boolean sslEnabled;
    public boolean keepAliveEnabled;
    public int port;
    private int numConnections;
    private int maxConnections;
    protected java.lang.Thread serverThread;
    static boolean debug = false;
    static jgl.HashMap config;
    static String strPages[];
    static HashSet filter;
    long lastTime;

    public HTTPServer(int portNum, int maxConn, boolean ssl, boolean keepAlive)
    {
        serverSocket = null;
        running = true;
        virtualDirectories = new Array();
        typeMap = new HashMap();
        sslEnabled = false;
        keepAliveEnabled = false;
        port = 9999;
        numConnections = 0;
        maxConnections = 0;
        lastTime = 0L;
        port = portNum;
        sslEnabled = ssl;
        keepAliveEnabled = keepAlive;
        if(maxConn > 0)
        {
            maxConnections = maxConn;
        }
        addType(".old", "text/plain");
        addType(".log", "text/plain");
        addType(".config", "text/plain");
        addType(".dyn", "text/plain");
        addType(".mg", "text/plain");
        addType(".html", "text/html");
        addType(".pdf", "application/pdf");
        addType(".htm", "text/html");
        addType(".gif", "image/gif");
        addType(".png", "image/png");
        addType(".jpg", "image/jpeg");
        addType(".jpeg", "image/jpeg");
        addType(".au", "audio/basic");
        addType(".wav", "audio/x-wav");
    }

    static void dump(String as[])
    {
        for(int i = 0; i < as.length; i++)
        {
            com.dragonflow.Utils.TextUtils.debugPrint(i + ": " + as[i]);
        }

    }

    public void startServer()
        throws java.io.IOException
    {
        SiteViewGroup siteviewgroup = SiteViewGroup.currentSiteView();
        String httpIP = siteviewgroup.getSetting("_httpListenerIP");
        javax.net.ServerSocketFactory serversocketfactory = null;
        String httpProtocol = "HTTP";
        if(sslEnabled)
        {
            serversocketfactory = SocketStream.getSSLServerFactory();
            httpProtocol = "HTTPS";
        }
        if(httpIP.length() > 0)
        {
            java.net.InetAddress inetaddress = java.net.InetAddress.getByName(httpIP);
            LogManager.log("RunMonitor", "Starting " + httpProtocol + " Server listener on " + httpIP + ":" + port);
            int maxConn = 0;
            if(maxConnections > 0)
            {
                maxConn = maxConnections;
            } else
            {
                maxConn = 20;
            }
            LogManager.log("RunMonitor", "Number of maximum connections accepted is : " + maxConn + " on " + httpIP + ":" + port);
            if(serversocketfactory != null)
            {
                serverSocket = serversocketfactory.createServerSocket(port, maxConn, inetaddress);
            } else
            {
                serverSocket = new ServerSocket(port, maxConn, inetaddress);
            }
        } else
        {
            LogManager.log("RunMonitor", "Starting " + httpProtocol + " Server listener on " + port);
            if(serversocketfactory != null)
            {
                serverSocket = serversocketfactory.createServerSocket(port);
            } else
            {
                serverSocket = new ServerSocket(port);
            }
        }
        if(sslEnabled)
        {
            LogManager.log("RunMonitor", SSLSocketStream.certificateDescription);
        }
        serverThread = new Thread(this);
        serverThread.setName("HTTP Server on port " + port);
        serverThread.setPriority(6);
        serverThread.start();
    }

    public void stopServer()
    {
        running = false;
        serverThread.stop();
        try
        {
            serverThread.join(15000L);
        }
        catch(java.lang.InterruptedException interruptedexception) { }
        LogManager.log("RunMonitor", "Shut down HTTP Server on port " + port);
        serverThread = null;
    }

    void timeStamp()
    {
        long l = System.currentTimeMillis();
        if(lastTime != 0L)
        {
            System.out.print((l - lastTime) + ":");
        }
        lastTime = l;
    }

    public void incConnections()
    {
        numConnections++;
    }

    public void decConnections()
    {
        numConnections--;
    }

    public int getConnections()
    {
        return numConnections;
    }

    public int getMaxConnections()
    {
        return maxConnections;
    }

    public void run()
    {
        int i = 10000;
        try
        {
            do
            {
                if(!running)
                {
                    break;
                }
                i++;
                java.net.Socket socket = null;
                try
                {
                    if(debug)
                    {
                        System.out.println(i + "-HTTPSERVER - waiting for a request ");
                    }
                    socket = serverSocket.accept();
                    if(debug)
                    {
                        System.out.println(i + "-HTTPSERVER - got a request ");
                    }
                    if(getMaxConnections() > 0)
                    {
                        if(debug)
                        {
                            System.out.println(i + "-HTTPSERVER - maxConnections > 0");
                        }
                        incConnections();
                    }
                }
                catch(java.io.IOException ioexception)
                {
                    System.out.println("Could not accept() on port " + port + ": " + ioexception.getMessage());
                    continue;
                }
                if(debug)
                {
                    System.out.println(i + "-HTTPSERVER - making new HTTPRequestThread ");
                }
                new HTTPRequestThread(this, socket, keepAliveEnabled);
                if(debug)
                {
                    System.out.println(i + "-HTTPSERVER - back from HTTPRequestThread ");
                }
            } while(true);
        }
        finally
        {
            try
            {
                serverSocket.close();
            }
            catch(java.io.IOException ioexception1)
            {
                System.out.println("Could not close server socket." + ioexception1.getMessage());
            }
            catch(java.lang.Exception exception1)
            {
                exception1.printStackTrace();
            }
        }
    }

    public void addVirtualDirectory(String s, String s1)
    {
        virtualDirectories.add(new VirtualDirectory(s, s1));
    }

    public void addCGIVirtualDirectory(String s, String s1)
    {
        virtualDirectories.add(new VirtualDirectory(s, s1, true));
    }

    com.dragonflow.HTTP.VirtualDirectory getVirtualDirectory(String s)
    {
    	if(s.contains("/")&&!s.startsWith("/SiteView")){
    		s=s.substring(s.indexOf("/SiteView"));
    	}
        for(Enumeration enumeration = virtualDirectories.elements(); enumeration.hasMoreElements();)
        {
            com.dragonflow.HTTP.VirtualDirectory virtualdirectory = (com.dragonflow.HTTP.VirtualDirectory)enumeration.nextElement();
            String s1 = virtualdirectory.getFullDocumentPath(s);
            if(s1 != null)
            {
                return virtualdirectory;
            }
        }

        return null;
    }

    public void addType(String s, String s1)
    {
        typeMap.put(s, s1);
    }

    String getType(String s)
    {
        String s1 = (String)typeMap.get(s);
        if(s1 == null)
        {
            s1 = "text/plain";
        }
        return s1;
    }

    static 
    {
        config = MasterConfig.getMasterConfig();
        strPages = TextUtils.split(TextUtils.getValue(config, "_serverFilter").toLowerCase(), ";");
        filter = new HashSet();
        String s = System.getProperty("HTTPServer.debug");
        if(s != null && s.length() > 0)
        {
            debug = true;
        }
        for(int i = 0; i < strPages.length; i++)
        {
            filter.add(strPages[i]);
        }

    }
}

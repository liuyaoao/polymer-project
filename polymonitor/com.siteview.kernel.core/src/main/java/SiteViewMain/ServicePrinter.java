
package SiteViewMain;

import com.dragonflow.Utils.ThreadPool;

import java.io.*;

public class ServicePrinter
    implements Runnable
{

    public ServicePrinter()
    {
        printing = true;
        collecting = false;
        collected = new StringBuffer();
        collectedMax = 500;
    }

    public void run()
    {
        try
        {
            while(true) 
            {
                String s;
                if((s = stream.readLine()) == null)
                    break;
                if(printing)
                    System.out.println(s);
                if(collecting)
                {
                    collected.append(s + "\n");
                    if(collected.length() > collectedMax)
                    {
                        String s1 = collected.toString().substring(collected.length() - collectedMax);
                        collected = new StringBuffer(s1);
                    }
                }
            }
        }
        catch(Exception exception)
        {
            try
            {
                stream.close();
            }
            catch(IOException ioexception) { }
        }
    }

    public static ThreadPool servicePrinterThreadPool = new ThreadPool("ServicePrinter", null);
    public BufferedReader stream;
    public boolean printing;
    public boolean collecting;
    public StringBuffer collected;
    public int collectedMax;

}
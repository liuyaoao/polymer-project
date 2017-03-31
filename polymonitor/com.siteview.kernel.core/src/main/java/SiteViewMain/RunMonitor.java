package SiteViewMain;

import com.dragonflow.SiteView.AtomicMonitor;
import com.dragonflow.SiteView.SiteViewGroup;
import java.io.PrintStream;

public class RunMonitor
{

    public RunMonitor()
    {
    }

    public static void main(String args[])
    {
        byte status = 0;
        try
        {
            String groupid = args[0];
            String monitorid = args[1];
            SiteViewGroup siteviewgroup = SiteViewGroup.currentSiteView();
            AtomicMonitor atomicmonitor = (AtomicMonitor)siteviewgroup.getElement(groupid + "/" + monitorid);
            if(atomicmonitor == null)
            {
                System.out.println("monitor not found, group: " + groupid + ", id: " + monitorid);
                status = 4;
            } else
            {
                atomicmonitor.testUpdate();
                System.out.println("group: " + groupid);
                System.out.println("monitor: " + monitorid);
                System.out.println("name: " + atomicmonitor.getProperty(AtomicMonitor.pName));
                System.out.println("status: " + atomicmonitor.getProperty(AtomicMonitor.pStateString));
                System.out.println("category: " + atomicmonitor.getProperty(AtomicMonitor.pCategory));
                String category = atomicmonitor.getProperty(AtomicMonitor.pCategory);
                if(category.equals("good"))
                    status = 1;
                else
                if(category.equals("warning"))
                    status = 2;
                else
                if(category.equals("error"))
                    status = 3;
            }
        }
        catch(Exception exception)
        {
            System.out.println("error: " + exception);
        }
        System.exit(status);
    }
}
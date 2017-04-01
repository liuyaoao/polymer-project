package SiteViewMain;
import java.io.IOException;

import com.dragonflow.Api.ApiRmiServer;
import com.dragonflow.Log.LogManager;
import com.dragonflow.SiteView.Platform;
import com.siteview.ecc.mqtt.brokers.init.InitMqttServer;
import com.siteview.kernel.mqttclient.AgentService4Mqtt;

import SiteViewMain.SiteViewSupport;
public class Start {
	  
	public Start()
	 {
	 }
	public static void main(String args[])
    throws IOException
    {
        SiteViewSupport.argv = args;
        try
        {
            SiteViewSupport.InitProcess();
            SiteViewSupport.InitProcess2();
            SiteViewSupport.StartProcess();
            InitMqttServer.execute();
            ApiRmiServer server = new ApiRmiServer();
            AgentService4Mqtt agent = new AgentService4Mqtt();
            agent.progressService();
            SiteViewSupport.WaitForProcess();
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
            LogManager.log("Error", Platform.productName + " unexpected shutdown: " + exception);
        }
        SiteViewSupport.ShutdownProcess();
    }

}

package com.dragonflow.StandardMonitor;

import java.util.Enumeration;

import com.dragonflow.Log.LogManager;
import com.dragonflow.Properties.BooleanProperty;
import com.dragonflow.Properties.NumericProperty;
import com.dragonflow.Properties.StringProperty;
import com.dragonflow.SiteView.CompositeBase;
import com.dragonflow.SiteView.Monitor;
import com.dragonflow.SiteView.MonitorGroup;
import com.dragonflow.SiteView.Rule;
import com.dragonflow.SiteView.SiteViewGroup;

public class StaticsReportMonitor extends CompositeBase{
	
	 static StringProperty pReportType;
	 static StringProperty pReportCheck;
	 static StringProperty pReportForm;
	 static StringProperty pReportSendMail;
	 static StringProperty pReportTime;
	 static StringProperty pReportEndTime;
	 static StringProperty pReportWeekEndTime;
	 static StringProperty pReportOtherStartTime;
	 static StringProperty pReportOtherEndTime;
	 
	 
//	 static StringProperty pDeepCheck;
//	 static StringProperty pRunMonitors;
//	 static StringProperty pDelay;

	 public StaticsReportMonitor()
	 {
	 }

	 public String getHostname()
	 {
	     return "StaticsReport";
	 }

	 protected boolean update()
	 {
//	     int ai[] = initializeStats();
//	     String as[] = initializeNameList();
//	     Enumeration enumeration = getMultipleValues(pItems);
//	     SiteViewGroup siteviewgroup = SiteViewGroup.currentSiteView();
//	     boolean flag = getPropertyAsBoolean(pDeepCheck);
//	     long l = getPropertyAsLong(pDelay) * 1000L;
//	     if(getPropertyAsBoolean(pRunMonitors))
//	     {
//	         flag = true;
//	         checkSequentially(ai, as, false, l, "");
//	     } else
//	     {
//	         do
//	         {
//	             if(!enumeration.hasMoreElements())
//	             {
//	                 break;
//	             }
//	             String s = (String)enumeration.nextElement();
//	             Monitor monitor = (Monitor)siteviewgroup.getElement(s.replace(' ', '/'));
//	             if(monitor != this)
//	             {
//	                 if(monitor != null)
//	                 {
//	                     if((monitor instanceof MonitorGroup) && flag)
//	                     {
//	                         checkGroup(ai, as, (MonitorGroup)monitor);
//	                     } else
//	                     {
//	                         updateStats(ai, as, monitor);
//	                     }
//	                 } else
//	                 {
//	                     LogManager.log("Error", "Could not get monitor " + s + " in Composite Monitor " + getProperty(pName));
//	                 }
//	             }
//	         } while(true);
//	     }
//	     updateProperties(ai, as, getPropertyAsBoolean(pRunMonitors));
	     return true;
	 }

	 public String defaultTitle()
	 {
	     String s = super.defaultTitle();
	     return "StaticsReport: " + s;
	 }

	 static 
	 {
//	     pRunMonitors = new BooleanProperty("_checkSequentially", "");
//	     pRunMonitors.setDisplayText("Run Monitors", "Run each monitor before checking.");
//	     pRunMonitors.setParameterOptions(true, 2, true);
//	     pDelay = new NumericProperty("_delay", "0");
//	     pDelay.setDisplayText("Monitor Delay", "If running each monitor, delay in seconds between monitors");
//	     pDelay.setParameterOptions(true, 5, true);
//	     pDeepCheck = new BooleanProperty("_deepCheck", "");
//	     pDeepCheck.setDisplayText("Check All Monitors in Group(s)", "By default, a group is counted as a single item when checking status.  If this box is checked, all of the monitors in selected groups (and their subgroups) are checked and counted towards the totals.");
//	     pDeepCheck.setParameterOptions(true, 6, true);
		 pReportCheck=new StringProperty("_check","");
		 pReportCheck.setDisplayText("Run Monitors", "Run each monitor before checking.");
	     pReportCheck.setParameterOptions(true, 2, true);
		 
	     pReportEndTime=new StringProperty("_endTime","");
	     pReportEndTime.setDisplayText("Run Monitors", "Run each monitor before checking.");
	     pReportEndTime.setParameterOptions(true, 2, true);
	     
	     pReportForm=new StringProperty("_format","");
	     pReportForm.setDisplayText("Run Monitors", "Run each monitor before checking.");
	     pReportForm.setParameterOptions(true, 2, true);
	     
	     pReportOtherEndTime=new StringProperty("_OtherEndTime","");
	     pReportOtherEndTime.setDisplayText("Run Monitors", "Run each monitor before checking.");
	     pReportOtherEndTime.setParameterOptions(true, 2, true);
		 
	     pReportOtherStartTime=new StringProperty("","");
	     pReportOtherStartTime.setDisplayText("Run Monitors", "Run each monitor before checking.");
	     pReportOtherStartTime.setParameterOptions(true, 2, true);
	     
	     pReportSendMail=new StringProperty("","");
	     pReportSendMail.setDisplayText("Run Monitors", "Run each monitor before checking.");
	     pReportSendMail.setParameterOptions(true, 2, true);
	     
	     pReportTime=new StringProperty("","");
	     pReportTime.setDisplayText("Run Monitors", "Run each monitor before checking.");
	     pReportTime.setParameterOptions(true, 2, true);
	     
	     pReportType=new StringProperty("","");
	     pReportType.setDisplayText("Run Monitors", "Run each monitor before checking.");
	     pReportType.setParameterOptions(true, 2, true);
	     
	     pReportWeekEndTime=new StringProperty("","");
	     pReportWeekEndTime.setDisplayText("Run Monitors", "Run each monitor before checking.");
	     pReportWeekEndTime.setParameterOptions(true, 2, true);
	     
	     StringProperty astringproperty[] = {
	         pReportCheck, pReportEndTime, pReportForm,pReportOtherEndTime,pReportOtherStartTime,pReportSendMail
	         ,pReportTime,pReportType,pReportWeekEndTime };
		 
	     addProperties("com.dragonflow.StandardMonitor.StaticsReportMonitor", astringproperty);
	     addClassElement("com.dragonflow.StandardMonitor.StaticsReportMonitor", Rule.stringToClassifier("itemsInError > 0\terror", true));
	     addClassElement("com.dragonflow.StandardMonitor.StaticsReportMonitor", Rule.stringToClassifier("itemsInError == 'n/a'\terror"));
	     addClassElement("com.dragonflow.StandardMonitor.StaticsReportMonitor", Rule.stringToClassifier("itemsInWarning > 0\twarning", true));
	     addClassElement("com.dragonflow.StandardMonitor.StaticsReportMonitor", Rule.stringToClassifier("always\tgood"));
	     setClassProperty("com.dragonflow.StandardMonitor.StaticsReportMonitor", "description", "Monitors the statuses of a set of groups and/or monitors.");
	     setClassProperty("com.dragonflow.StandardMonitor.StaticsReportMonitor", "help", "PingMon.htm");
	     setClassProperty("com.dragonflow.StandardMonitor.StaticsReportMonitor", "title", "StaticsReport");
	     setClassProperty("com.dragonflow.StandardMonitor.StaticsReportMonitor", "class", "StaticsReportMonitor");
	     setClassProperty("com.dragonflow.StandardMonitor.StaticsReportMonitor", "classType", "advanced");
	     setClassProperty("com.dragonflow.StandardMonitor.StaticsReportMonitor", "topazName", "StaticsReport");
	     setClassProperty("com.dragonflow.StandardMonitor.StaticsReportMonitor", "topazType", "System Resources");
	     setClassProperty("com.dragonflow.StandardMonitor.StaticsReportMonitor", "target", "_monitor");
	 }

}

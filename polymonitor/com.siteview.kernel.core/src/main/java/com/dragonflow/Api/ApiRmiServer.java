
package com.dragonflow.Api;

import java.io.IOException;
import java.net.InetAddress;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Vector;

import com.dragonflow.Page.CGI;
import com.dragonflow.Page.monitorPage;
import com.dragonflow.Properties.HashMapOrdered;
import com.dragonflow.Properties.StringProperty;
import com.dragonflow.SiteView.AtomicMonitor;
import com.dragonflow.SiteView.Machine;
import com.dragonflow.SiteView.Monitor;
import com.dragonflow.SiteView.MonitorGroup;
import com.dragonflow.SiteView.User;
import com.dragonflow.SiteViewException.SiteViewException;
import com.dragonflow.StandardMonitor.PingMonitor;

import jgl.Array;
import jgl.HashMapIterator;

public class ApiRmiServer extends java.rmi.server.UnicastRemoteObject implements APIInterfaces{
	String hostname;
	Registry registry; 
	APIGroup apigroup;
	APIMonitor apimonitor;


	public ApiRmiServer() throws RemoteException{
		try{
			InetAddress addr = InetAddress.getLocalHost();
		    // Get IP Address
//		    byte[] ipAddr = addr.getAddress();

		    // Get hostname
		    hostname = addr.getHostName();
		}
		catch(Exception e){
			System.out.println("can't get inet address.");
		}
		int port=3232; 
		System.out.println("RMI server start at this address=" + hostname +  ",port=" + port);
		try{
			registry = LocateRegistry.createRegistry(port);
			registry.rebind("kernelApiRmiServer", this);
			
			apigroup = new APIGroup();
			apimonitor = new APIMonitor();
		}
		catch(RemoteException e){
			System.out.println("remote exception"+ e);
		}
	}
	
	public String getHostname () {
		return hostname;
	}


	public List<Map<String, Object>> getAllGroupInstances() throws SiteViewException {	
		List<MonitorGroup> mgs = apigroup.getAllGroupInstances();
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		for (MonitorGroup mg:mgs) {
			SSInstanceProperty assinstanceproperty1[] = apigroup.getInstanceProperties(mg.getProperty("_id"), APISiteView.FILTER_CONFIGURATION_EDIT_ALL);
            Map<String,Object> nodedata = new HashMap<String, Object>();
            for (int k = 0; k < assinstanceproperty1.length; k ++) {
                nodedata.put(assinstanceproperty1[k].getName(), assinstanceproperty1[k].getValue());
            }

            nodedata.put("_id", mg.getFullID());
            list.add(nodedata);
		}
		System.out.println(Machine.getMachineTable().size());
		return list;
	}


	public List<Map<String, Object>> getTopLevelGroupInstances() throws RemoteException, SiteViewException {		
		
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		try
		{
			APIGroup apimg = new APIGroup();
			ArrayList<MonitorGroup> mgs = apigroup.getTopLevelGroupInstances();

			for(MonitorGroup mg:mgs)
			{
				SSInstanceProperty assinstanceproperty1[] = apigroup.getInstanceProperties(mg.getProperty("_id"), APISiteView.FILTER_CONFIGURATION_EDIT_ALL);
				Map<String, Object> nodedata = new HashMap<String, Object>();
	            for (int k = 0; k < assinstanceproperty1.length; k ++) {
	                nodedata.put(assinstanceproperty1[k].getName(), assinstanceproperty1[k].getValue());
	            }
	            nodedata.put("_id", mg.getFullID());
	            list.add(nodedata);
			}
		} catch (java.lang.Exception e)
		{
			System.out.println(e);
		}
		return list;
		
	}
	
	public List<Map<String, Object>> getChildGroupInstances(String groupID) throws RemoteException, SiteViewException {		
		
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		try
		{
			Collection mgs = apigroup.getChildGroupInstances(groupID);
			
			if(mgs.size() > 0) {
				for(Iterator iter=mgs.iterator();iter.hasNext();){
					MonitorGroup mg = (MonitorGroup) iter.next();
					SSInstanceProperty assinstanceproperty1[] = apigroup.getInstanceProperties(mg.getProperty("_id"), APISiteView.FILTER_CONFIGURATION_EDIT_ALL);
					Map<String, Object> nodedata = new HashMap<String, Object>();
		            for (int k = 0; k < assinstanceproperty1.length; k ++) {
		                nodedata.put(assinstanceproperty1[k].getName(), assinstanceproperty1[k].getValue());
		            }
		            nodedata.put("_id", mg.getFullID());
		            list.add(nodedata);
				}
			}
		} catch (java.lang.Exception e)
		{
			System.out.println(e);
		}
		return list;
	}
	
	public void deleteGroup(String groupID) throws RemoteException, SiteViewException {		
		apigroup.delete(groupID);
	}

	public void deleteMonitor(String monitorID,String groupID) throws RemoteException, SiteViewException {		
		apimonitor.delete(monitorID,groupID);
	}

	public List<Map<String, Object>> getMonitorsForGroup(String groupID) throws RemoteException, SiteViewException {		
		
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		try
		{
			Collection mgs = apimonitor.getMonitorsForGroup(groupID);
			
			if(mgs.size() > 0) {
				for(Iterator iter=mgs.iterator();iter.hasNext();){
					AtomicMonitor monitor = (AtomicMonitor) iter.next();
					SSInstanceProperty assinstanceproperty1[] = apimonitor.getInstanceProperties(monitor.getProperty("_id"), groupID,APISiteView.FILTER_CONFIGURATION_EDIT_ALL);
					Map<String, Object> nodedata = new HashMap<String, Object>();
		            for (int k = 0; k < assinstanceproperty1.length; k ++) {
		                nodedata.put(assinstanceproperty1[k].getName(), assinstanceproperty1[k].getValue());
		            }
		            nodedata.put("_id", monitor.getFullID());
		            list.add(nodedata);
				}
			}
		} catch (java.lang.Exception e)
		{
			System.out.println(e);
		}
		return list;
	}

	public int getNumOfMonitorsForGroup(String groupID) throws RemoteException, SiteViewException {		
		return apigroup.getNumOfMonitorsForGroup(groupID);
	}
	
	static public ArrayList<HashMap<String, String>> getMonitorsData()
	{		
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		try
		{
			APIMonitor apim = new APIMonitor();
			Collection collection = apim.getAllMonitors();
			Vector vector = (Vector) collection;

			Monitor monitor;
			int index = 0;
			for (Iterator iterator = collection.iterator(); iterator.hasNext();)
			{
				monitor = (Monitor) iterator.next();
				
				HashMap<String, String> ndata = new HashMap<String, String>();
				ndata.put(new String("Name"), monitor.getProperty(AtomicMonitor.pName));
				ndata.put(new String("GroupID"), monitor.getProperty(AtomicMonitor.pOwnerID));
				ndata.put(new String("MonitorID"), monitor.getProperty(AtomicMonitor.pID));
				ndata.put(new String("Type"), monitor.getProperty(AtomicMonitor.pClass));
				list.add(ndata);
			}
		} catch (java.lang.Exception e)
		{
			System.out.println(e);
		}
		return list;
	}
	
	public boolean trylogin(String strUser, String strPwd) throws RemoteException,SiteViewException {
		jgl.Array array = User.findUsersForLogin(strUser, strPwd);
		if(array.size() > 0)
			return true;
		else
			return false;
	}

	public List<HashMap<String,String>> getMachines() throws RemoteException, SiteViewException {
		List<HashMap<String,String>> list = new ArrayList<HashMap<String,String>>();
		 jgl.HashMap hashmap = Machine.getMachineTable();
	        for (Enumeration enumeration = hashmap.elements(); enumeration
	                .hasMoreElements();) {
	            Machine machine = (Machine) enumeration.nextElement();
	            jgl.HashMap jmap = machine.getValuesTable();
	            HashMap<String,String> map = new HashMap<String, String>();
	            for(Enumeration enumeration1 = jmap.elements(); enumeration1
		                .hasMoreElements();enumeration1.nextElement()){
	            	map.put(((HashMapIterator)enumeration1).key().toString(), ((HashMapIterator)enumeration1).value().toString());
	            }
	            list.add(map);
	        }
		return list;
	}

	public void addMachine(Map<String, String> map) throws RemoteException, SiteViewException {
		 jgl.HashMap hashmap = new jgl.HashMap();
		 Iterator<String> ite = map.keySet().iterator();
		 while(ite.hasNext()){
			 String key = ite.next();
			 hashmap.put(key, map.get(key));
		 }
		 try {
				CGI.addMachine("_remoteMachine",hashmap);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void deleteMachine(String id) throws RemoteException, SiteViewException {
		// TODO Auto-generated method stub
		 jgl.HashMap hashmap = Machine.getMachineTable();
		 hashmap.remove(id);
		 jgl.Array array = new Array();
		  for (Enumeration enumeration = hashmap.elements(); enumeration
	                .hasMoreElements();) {
	            Machine machine = (Machine) enumeration.nextElement();
	            array.add(machine.getValuesTable());
	      }
		 try {
				CGI.saveMasterConfigFor(array,"_remoteMachine");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void updateMachine(Map<String, String> map) throws RemoteException, SiteViewException {
		// TODO Auto-generated method stub
		 String id = map.get("_id");
		 jgl.HashMap hashmap = Machine.getMachineTable();
		 jgl.Array array = new Array();
		  for (Enumeration enumeration = hashmap.elements(); enumeration
	                .hasMoreElements();) {
	            Machine machine = (Machine) enumeration.nextElement();
	            jgl.HashMap jmap = machine.getValuesTable();
	            if(jmap.get("_id").equals(id))
		            for(Enumeration enumeration1 = jmap.elements(); enumeration1
			                .hasMoreElements();enumeration1.nextElement()){
		            	String key = ((HashMapIterator)enumeration1).key().toString();
		            	jmap.put(key, map.get(key));
		            }
	            array.add(machine.getValuesTable());
	      }
		  try {
				CGI.saveMasterConfigFor(array,"_remoteMachine");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public Map<String,List<List<StringProperty>>> getMonitor() throws RemoteException, SiteViewException {
		Map<String,List<List<StringProperty>>>  monitors = new HashMap<String,List<List<StringProperty>>> ();
		try
		{
			Collection mgs = apimonitor.getMonitorsForGroup("Test");
			if(mgs.size() > 0) {
				for(Iterator iter=mgs.iterator();iter.hasNext();){
					AtomicMonitor monitor = (AtomicMonitor) iter.next();
					String name=monitor.getClass().getName();
					if(name.contains("."))
						name = name.substring(name.lastIndexOf(".")+1);
					List<List<StringProperty>> lists = monitors.get(name);
					if(lists==null)
						lists = new ArrayList<List<StringProperty>>();
					
					List<StringProperty> list = new ArrayList<StringProperty>();
					Array array= monitor.getProperties();
					for(int i=0;i<array.size();i++)
						list.add((StringProperty)array.at(i));
					lists.add(list);
					monitors.put(name, lists);
				}
			}
		} catch (java.lang.Exception e)
		{
			System.out.println(e);
		}
		return monitors;
	}

}

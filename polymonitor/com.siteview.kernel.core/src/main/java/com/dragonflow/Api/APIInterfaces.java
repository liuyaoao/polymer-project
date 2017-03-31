
package com.dragonflow.Api;

import java.rmi.Remote;
import java.rmi.RemoteException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import com.dragonflow.Properties.HashMapOrdered;
import com.dragonflow.Properties.StringProperty;
import com.dragonflow.SiteView.AtomicMonitor;
import com.dragonflow.SiteViewException.SiteViewException;

public interface APIInterfaces extends Remote
{
	List<Map<String, Object>> getAllGroupInstances()  throws RemoteException, SiteViewException;
	List<Map<String, Object>> getTopLevelGroupInstances()  throws RemoteException,SiteViewException;
	List<Map<String, Object>> getChildGroupInstances(String groupid)  throws RemoteException,SiteViewException;
	List<Map<String, Object>> getMonitorsForGroup(String groupid)  throws RemoteException,SiteViewException;
	int getNumOfMonitorsForGroup(String groupid)  throws RemoteException,SiteViewException;
	void deleteGroup(String groupId)  throws RemoteException,SiteViewException;
	void deleteMonitor(String monitorId,String groupId)  throws RemoteException,SiteViewException;
	boolean trylogin(String strUser, String strPwd) throws RemoteException,SiteViewException;	
	//lihua.zhong add 2017.0.23
	List<HashMap<String,String>> getMachines()  throws RemoteException, SiteViewException;
	void addMachine(Map<String,String> map)  throws RemoteException, SiteViewException;
	void deleteMachine(String id)  throws RemoteException, SiteViewException;
	void updateMachine(Map<String,String> map) throws RemoteException, SiteViewException;
	Map<String,List<List<StringProperty>>>  getMonitor() throws RemoteException, SiteViewException;;
}

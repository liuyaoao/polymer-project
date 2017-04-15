package com.dragonflow.SiteView;

import java.io.IOException;
import java.util.Enumeration;

import com.dragonflow.Log.LogManager;
import com.dragonflow.Properties.FrameFile;
import com.dragonflow.Properties.HashMapOrdered;
import com.dragonflow.Properties.StringProperty;
import com.dragonflow.Utils.TextUtils;

import jgl.Array;
import jgl.HashMap;

public class Tenant extends SiteViewObject {
	public static StringProperty pCompanyName;
	public static StringProperty pCompanyNumber;
	public static StringProperty pCompanyDesc;
	public static StringProperty pNumberOfCompanies;
	public static StringProperty pCompanyUrl;
	public static StringProperty pCompaniesPhone;
	public static StringProperty pCompaniesEmail;
	public static final String TENANT_FILENAME = "tenants.config";
	static Array tenantCache = null;

    HashMap permissions;
    MonitorGroup accountGroup;
    
	public static HashMap tenantTable = new HashMapOrdered(true);

	public static Array readTenants() {
		if (tenantCache == null) {
			tenantCache = new Array();
			try {
				tenantCache = FrameFile.readFromFile(Platform.getRoot() + "/groups/" + "tenants.config");
			} catch (Exception exception) {
			}
			HashMap hashmap = MasterConfig.getMasterConfig();
			initializeTenantList(tenantCache, hashmap);
		}
		return tenantCache;
	}

	public static void initializeTenantList(Array array, HashMap hashmap) {
		if (array.size() == 0) {
			HashMap hashmap1 = new HashMap();
			hashmap1.put("_nextID", "1");
			array.add(hashmap1);
		}
		if (findTenant(array, "administrator") == null) {
			array.add(createAdministratorTenant(hashmap));
		}
//		if (!Platform.isPortal() && findTenant(array, "tenant") == null) {
//			array.add(createTenantLogin(hashmap));
//		}
	}

	public static HashMap findTenant(Array array, String s) {
		Enumeration enumeration= array.elements();
		if(enumeration.hasMoreElements())
			enumeration.nextElement();
		while (enumeration.hasMoreElements()) {
			HashMap hashmap = (HashMap) enumeration.nextElement();
			if (s.equals(TextUtils.getValue(hashmap, "_id"))) {
				return hashmap;
			}
		}
		return null;
	}
	public static HashMap findTenantforName(Array array, String s) {
		Enumeration enumeration= array.elements();
		if(enumeration.hasMoreElements())
			enumeration.nextElement();
		while (enumeration.hasMoreElements()) {
			HashMap hashmap = (HashMap) enumeration.nextElement();
			if (s.equals(TextUtils.getValue(hashmap, "_cName"))) {
				return hashmap;
			}
		}
		return null;
	}
	public static String findTenantToName(Array array, String s) {
		Enumeration enumeration= array.elements();
		if(enumeration.hasMoreElements())
			enumeration.nextElement();
		while (enumeration.hasMoreElements()) {
			HashMap hashmap = (HashMap) enumeration.nextElement();
			if (s.equals(TextUtils.getValue(hashmap, "_id"))) {
				return TextUtils.getValue(hashmap, "_cName");
			}
		}
		return "";
	}
	public static HashMap createAdministratorTenant(HashMap hashmap) {
		HashMap hashmap1 = new HashMap();
		hashmap1.put("_id", "administrator");
		hashmap1.put("_cName", TextUtils.getValue(hashmap, "_adminCName"));
		hashmap1.put("_cNumber", TextUtils.getValue(hashmap, "_adminCNumber"));
		hashmap1.put("_cDesc", TextUtils.getValue(hashmap, "_adminCDesc"));
		hashmap1.put("_cNumberC", TextUtils.getValue(hashmap, "_adminCNumberC"));
		hashmap1.put("_cUrl", TextUtils.getValue(hashmap, "_adminCUrl"));
		hashmap1.put("_cPhone", TextUtils.getValue(hashmap, "_adminCPhone"));
		hashmap1.put("_realName", Platform.productName + " Administrator");
		hashmap1.put("_edit", "true");
		hashmap1.put("_useGlobalPermissions", "true");
		return hashmap1;
	}

	public static HashMap createTenantLogin(HashMap hashmap) {
		HashMap hashmap1 = new HashMap();
		hashmap1.put("_id", "tenant");
		hashmap1.put("_cName", TextUtils.getValue(hashmap, "_adminCName"));
		hashmap1.put("_cNumber", TextUtils.getValue(hashmap, "_adminCNumber"));
		hashmap1.put("_cDesc", TextUtils.getValue(hashmap, "_adminCDesc"));
		hashmap1.put("_cNumberC", TextUtils.getValue(hashmap, "_adminCNumberC"));
		hashmap1.put("_cUrl", TextUtils.getValue(hashmap, "_adminCUrl"));
		hashmap1.put("_cPhone", TextUtils.getValue(hashmap, "_adminCPhone"));
		if (TextUtils.getValue(hashmap, "_userEnabled").length() == 0) {
			hashmap1.put("_disabled", "true");
		}
		if (TextUtils.getValue(hashmap, "_userDisableQuickReports").length() == 0) {
			hashmap1.put("_reportAdhoc", "true");
			hashmap1.put("_monitorRecent", "true");
			hashmap1.put("_alertRecentReport", "true");
			hashmap1.put("_alertAdhocReport", "true");
		}
		if (TextUtils.getValue(hashmap, "_userDisableReportIndexToolbar").length() == 0) {
			hashmap1.put("_reportIndexToolbar", "true");
		}
		if (TextUtils.getValue(hashmap, "_userEnableRefresh").length() > 0) {
			hashmap1.put("_monitorRefresh", "true");
		}
		if (TextUtils.getValue(hashmap, "_userHideMoreColumn").length() == 0) {
			hashmap1.put("_monitorTools", "true");
		}
		hashmap1.put("_preferenceTest", "true");
		hashmap1.put("_progress", "true");
		hashmap1.put("_browse", "true");
		hashmap1.put("_tools", "true");
		hashmap1.put("_topazConfigChangesReport", "true");
		return hashmap1;
	}
	 static void registerTenant(String s, HashMap hashmap, HashMap hashmap1) {
	        registerTenant(null, s, hashmap, hashmap1);
	    }

	    static void registerTenant(MonitorGroup monitorgroup, String s, HashMap hashmap, HashMap hashmap1) {
	        if (s.length() > 0) {
	            Tenant tenant = new Tenant();
	            tenant.readFromHashMap(hashmap);
	            tenant.initialize(hashmap);
	            tenant.permissions = hashmap1;
	            tenant.accountGroup = monitorgroup;
	            tenant.setProperty(pCompanyName, s);
	            tenantTable.add(s, tenant);
	        }
	    }
	 public static void loadTenants() {
	        LogManager.log("RunMonitor", "Loading tenant.config");
	        Array array = readTenants();
	        Enumeration enumeration = array.elements();
	        if (enumeration.hasMoreElements()) {
	            enumeration.nextElement();
	        }
	        while (enumeration.hasMoreElements()) {
	            HashMap hashmap = (HashMap) enumeration.nextElement();
	            String s = TextUtils.getValue(hashmap, "_useGlobalPermissions");
	            if (s.length() > 0) {
	                registerTenant(TextUtils.getValue(hashmap, "_id"), hashmap, MasterConfig.getMasterConfig());
	            } else {
	                registerTenant(TextUtils.getValue(hashmap, "_id"), hashmap, hashmap);
	            }
	        }
	    }

	    public static void unloadTenants() {
	        LogManager.log("Debug", "unloading tenant.config");
	        Array array = readTenants();
	        Enumeration enumeration = array.elements();
	        if (enumeration.hasMoreElements()) {
	            enumeration.nextElement();
	        }
	        HashMap hashmap;
	        for (; enumeration.hasMoreElements(); unregisterTenants(TextUtils.getValue(hashmap, "_id"))) {
	            hashmap = (HashMap) enumeration.nextElement();
	        }

	        clearTenantsCache();
	    }
	    static void unregisterTenants(String s) {
	        tenantTable.remove(s);
	    }
	    static void clearTenantsCache() {
	        tenantCache = null;
	    }
	    public static Array findTenantsForLogin(String s, String s1) {
	        Array array = new Array();
	        for (Enumeration enumeration = tenantTable.keys(); enumeration.hasMoreElements();) {
	            String s2 = (String) enumeration.nextElement();
	            Enumeration enumeration1 = tenantTable.values(s2);
	            while (enumeration1.hasMoreElements()) {
	                User user = (User) enumeration1.nextElement();
	                if (user.getProperty(pCompanyName).equalsIgnoreCase(s) && user.getProperty(pCompanyNumber).equals(s1)) {
	                    array.add(user);
	                }
	            }
	        }
	        return array;
	    }
	    public static void writeTenants(Array array) throws IOException {
	        FrameFile.writeToFile(Platform.getRoot() + "/groups/" + "tenants.config", array);
	        unloadTenants();
	        loadTenants();
	    }
	    static {
	    	pCompanyName = new StringProperty("_cName", "");
	    	pCompanyNumber = new StringProperty("_cNumber", "");
	    	pNumberOfCompanies = new StringProperty("_cNumberC", "");
	    	pCompanyDesc = new StringProperty("_cDesc", "");
	    	pCompanyUrl = new StringProperty("_cURL", "");
	    	pCompaniesPhone = new StringProperty("_cPhone", "");
	    	pCompaniesEmail = new StringProperty("_cEmail", "");
	    	
	        StringProperty astringproperty[] = { pCompanyName, pCompanyNumber, pNumberOfCompanies,
	        		pCompanyDesc, pCompanyUrl, pCompaniesPhone, pCompaniesEmail};
	        addProperties("com.dragonflow.SiteView.Tenant", astringproperty);
	        SiteViewGroup siteviewgroup = SiteViewGroup.currentSiteView();
	    }
	}

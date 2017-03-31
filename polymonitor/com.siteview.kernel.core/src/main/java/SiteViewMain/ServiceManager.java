package SiteViewMain;

import static org.jinterop.dcom.core.JIProgId.valueOf;
import static org.jinterop.dcom.impls.JIObjectFactory.narrowObject;
import static org.jinterop.dcom.impls.automation.IJIDispatch.IID;
import java.util.logging.Level;
import org.jinterop.dcom.common.JIException;
import org.jinterop.dcom.common.JIRuntimeException;
import org.jinterop.dcom.common.JISystem;
import org.jinterop.dcom.core.IJIComObject;
import org.jinterop.dcom.core.JIArray;
import org.jinterop.dcom.core.JIComServer;
import org.jinterop.dcom.core.JISession;
import org.jinterop.dcom.core.JIString;
import org.jinterop.dcom.core.JIVariant;
import org.jinterop.dcom.impls.automation.IJIDispatch;
import org.jinterop.dcom.impls.automation.IJIEnumVariant;

public class ServiceManager {
	private static String domainName = "";
	private static String userName = "administrator";
	private static String password = "19870926";
	private static String hostIP = "192.168.9.131";
	static final String win32_namespace = "\\\\192.168.9.131\\root\\cimv2";
	private static final int STOP_SERVICE = 0;
	private static final int START_SERVICE = 1;
	private JISession dcomSession = null;

	public static void main(String[] args) {
		ServiceManager manager = new ServiceManager();
		manager.stopService(domainName, hostIP, userName, password, "MySql");// stopsaservicenamedMySql
	}

	public void startService(String domainName, String hostname,
			String username, String password, String serviceName) {
		execute(domainName, hostname, username, password, serviceName,
				START_SERVICE);
	}

	public void stopService(String domainName, String hostname,
			String username, String password, String serviceName) {
		execute(domainName, hostname, username, password, serviceName,
				STOP_SERVICE);
	}

	public void execute(String domainName, String hostname, String username,
			String password, String serviceName, int action) {
		try {
			IJIDispatch wbemServices = createCOMServer();
			final int RETURN_IMMEDIATE = 0x10;
			final int FORWARD_ONLY = 0x20;
			Object[] params = new Object[] {
					new JIString("SELECT * FROM Win32_Service WHERE Name='"
							+ serviceName + "'"
							), JIVariant.OPTIONAL_PARAM(),
					new JIVariant(new Integer(RETURN_IMMEDIATE + FORWARD_ONLY)) };
			JIVariant[] servicesSet = wbemServices.callMethodA("ConnectServer",
					params);
			IJIDispatch wbemObjectSet = (IJIDispatch) narrowObject(servicesSet[0]
					.getObjectAsComObject());
			JIVariant newEnumvariant = wbemObjectSet.get("_NewEnum");
			IJIComObject enumComObject = newEnumvariant.getObjectAsComObject();
			IJIEnumVariant enumVariant = (IJIEnumVariant) narrowObject(enumComObject
					.queryInterface(IJIEnumVariant.IID));
			Object[] elements = enumVariant.next(1);
			JIArray aJIArray = (JIArray) elements[0];
			JIVariant[] array = (JIVariant[]) aJIArray.getArrayInstance();
			for (JIVariant variant : array) {
				IJIDispatch wbemObjectDispatch = (IJIDispatch) narrowObject(variant
						.getObjectAsComObject());
				// Printobjectastext.
				JIVariant[] v = wbemObjectDispatch.callMethodA(
						"GetObjectText_", new Object[] { 1 });
				System.out.println(v[0].getObjectAsString().getString());
				// StartorStoptheservice
				String methodToInvoke = (action == START_SERVICE) ? "StartService"
						: "StopService";
				JIVariant returnStatus = wbemObjectDispatch
						.callMethodA(methodToInvoke);
				System.out.println("Returnstatus:"
						+ returnStatus.getObjectAsInt());// ifreturncode=0success.Seemsdnformoredetailsaboutthemethod.
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (dcomSession != null) {
				try {
					JISession.destroySession(dcomSession);
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}
		}
	}

	private IJIDispatch createCOMServer() {
		JIComServer comServer;
		try {
			JISystem.getLogger().setLevel(Level.WARNING);
			JISystem.setAutoRegisteration(true);
			dcomSession = JISession.createSession(domainName, userName,
					password);
			dcomSession.useSessionSecurity(false);
			comServer = new JIComServer(valueOf("WbemScripting.SWbemLocator"),
					hostIP, dcomSession);
			IJIDispatch wbemLocator = (IJIDispatch) narrowObject(comServer
					.createInstance().queryInterface(IID));
			// parameterstoconnecttoWbemScripting.SWbemLocator
			Object[] params = new Object[] { new JIString(hostIP),// strServer
					new JIString(win32_namespace),// strNamespace
					JIVariant.OPTIONAL_PARAM(),// strUser
					JIVariant.OPTIONAL_PARAM(),// strPassword
					JIVariant.OPTIONAL_PARAM(),// strLocale
					JIVariant.OPTIONAL_PARAM(),// strAuthority
					new Integer(0),// iSecurityFlags
					JIVariant.OPTIONAL_PARAM() // objwbemNamedValueSet
			};
			JIVariant results[] = wbemLocator.callMethodA("ConnectServer",
					params);
			IJIDispatch wbemServices = (IJIDispatch) narrowObject(results[0]
					.getObjectAsComObject());
			return wbemServices;
		} catch (JIException jie) {
			System.out.println(jie.getMessage());
			jie.printStackTrace();
		} catch (JIRuntimeException jire) {
			jire.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (dcomSession != null) {
				try {
					JISession.destroySession(dcomSession);
				} catch (JIException e) {
					e.printStackTrace();
				}
			}
		}
		return null;
	}

}

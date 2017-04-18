package com.dragonflow.Page;

import java.util.Vector;

import com.dragonflow.SiteView.Machine;
import com.dragonflow.Utils.TextUtils;

import jgl.Array;
import jgl.HashMap;

public class mqttmachinePage extends com.dragonflow.Page.remoteBase{

	@Override //table表格列
	Array getListTableHeaders(String s) {
		 jgl.Array array = new Array();
	        array.add(new String("Name"));
	        array.add(new String("Server"));
	        array.add(new String("Status"));
	        array.add(new String("OS"));
//	        array.add(new String("Method"));
	        if(request.actionAllowed("_preference") || s.length() > 0)
	        {
	            array.add(new String("Edit"));
	            array.add(new String("Test"));
	            array.add(new String("Detailed Test"));
	            array.add(new String("Del"));
	        }
	        return array;
	}

	@Override //表格行数据
	Array getListTableRow(HashMap hashmap, String s) {
        jgl.Array array = new Array();
        String s1 = TextUtils.getValue(hashmap, "_id");
        String s2 = com.dragonflow.Page.windowsmachinePage.getValue(hashmap, "_name");
        if(s2.length() == 0)
        {
            s2 = TextUtils.getValue(hashmap, "_host");
        }
        jgl.Array array2 = Machine.getAllowedOSs();
        array.add(new String("<b>" + s2 + "</b>"));
        array.add(new String(TextUtils.getValue(hashmap, "_host")));
        array.add(new String("<b><i>" + TextUtils.getValue(hashmap, "_status") + "</i></b>"));
        array.add(new String(com.dragonflow.Utils.TextUtils.keyToDisplayString(com.dragonflow.Page.machinePage.getValue(hashmap, "_os"), array2)));
        if(request.actionAllowed("_preference") || s.length() > 0)
        {
            array.add(new String("<A href=" + getPageLink("mqttmachine", "Edit") + "&mqttMachineID=" + s1 + "&storeID=" + s + ">Edit<paper-ripple></paper-ripple></a>"));
            array.add(new String("<A href=" + getPageLink("mqttmachine", "Test") + "&mqttMachineID=" + s1 + "&storeID=" + s + "&link=true>Test<paper-ripple></paper-ripple></a>"));
            array.add(new String("<A href=" + getPageLink("mqttmachine", "Test") + "&mqttMachineID=" + s1 + "&storeID=" + s + "&detail=true>Detailed Test<paper-ripple></paper-ripple></a>"));
            array.add(new String("<A href=" + getPageLink("mqttmachine", "Delete") + "&mqttMachineID=" + s1 + "&storeID=" + s + ">X<paper-ripple></paper-ripple></a>"));
        }
        return array;
	}

	@Override
	void doTest(Machine machine) {


	}

	@Override
	String getTestMachineID() {
		 String s = getMachineID();
	     String s1 = Machine.REMOTE_MQTTPREFIX + s;
	     String s2 = Machine.getFullMachineID(s1, request);
	     return s2;
	}

	@Override
	String getTestMachineName() {
		jgl.HashMap hashmap = getTestMachineFrame();
        return TextUtils.getValue(hashmap, "_host");
	}

	@Override
	String getTestDescription() {
		// TODO Auto-generated method stub
		return new String("<p>This test checks for both network connectivity and permissions to access  the selected machine.\nIf an access permission error is returned,\n make sure the user name and password are correct.\nIf a network connectivity error is returned check the network connection.\n");
	}

	@Override
	Machine getTestMachine() {
		   String s = getTestMachineID();
	        com.dragonflow.SiteView.Machine machine = Machine.getMqttMachine(s);
	        return machine;
	}

	@Override
	String getTestCentra() {
		// TODO Auto-generated method stub
		 return "_centrascopeRemoteTestMatch";
	}

	@Override
	String getHelpPage() {
		// TODO Auto-generated method stub
		return "MqttRemote.htm";
	}

	@Override
	String getPage() {
		// TODO Auto-generated method stub
		return "mqttmachine";
	}

	@Override
	String getIDName() {
		// TODO Auto-generated method stub
		return "mqttMachineID";
	}

	@Override
	String getNextMachineName() {
		// TODO Auto-generated method stub
		 return "_nextMqttRemoteID";
	}

	@Override
	String getRemoteName() {
		// TODO Auto-generated method stub
		return "_remoteMqttMachine";
	}

	@Override
	String getListTitle() {
		// TODO Auto-generated method stub
		return "Remote Mqtt Servers";
	}

	@Override
	String getListSubtitle() {
		// TODO Auto-generated method stub
		return "A list of Mqtt servers ";
	}

	@Override
	String getPrefTitle() {
		// TODO Auto-generated method stub
		return "Mqtt Remotes";
	}

	@Override
	String getPrintFormSubmit() {
		// TODO Auto-generated method stub
		return "Remote Mqtt Server";
	}

	@Override
	boolean displayFormTable(HashMap hashmap, String s) {
		boolean flag = true;
		outputStream.println("<div class='row'><div class='col-xs-12 col-sm-6 col-md-4'>"
					+"<paper-input type='search' id='' name='host' label='Mqtt Subscribe' size='50' value='"+TextUtils.getValue(hashmap, "_host")+"'></paper-input>"
					+"<div>The Mqtt Subscribe of the remote server "+ "Subscribe to topics(for example, mac/ip)</div>"
					+"</div></div>");
        if(flag){
        	outputStream.println("<div class='row'><div class='col-xs-12 col-sm-6 col-md-4'>"
											+"<paper-dropdown-menu id='categorySelect' label='os:' name='os' horizontal-align='right'>"
											+"<paper-listbox class='dropdown-content' attr-for-selected='value' selected='"+TextUtils.getValue(hashmap, "_os")+"'>");
						printOsOptionElement(com.dragonflow.SiteView.Machine.getAllowedOSs());
			outputStream.println("</paper-listbox>"
											+"</paper-dropdown-menu>"
											+"<div>The operating system (OS) running on the remote server</div>"
											+"</div></div>");
            if(com.dragonflow.Utils.I18N.isI18N){
                String s3 = com.dragonflow.Page.machinePage.getValue(hashmap, "_encoding");
                if(s3.length() == 0){
                    s3 = com.dragonflow.Utils.I18N.getDefaultEncoding();
                }
                byte abyte0[] = new byte[10];
                abyte0[0] = -112;
                String s4 = "null";
                try{
                    s4 = new String(abyte0, 0, 1, "Shift_JIS");
                }
                catch(java.lang.Exception exception){
                    System.out.println(exception.getMessage());
                    exception.printStackTrace();
                }
                com.dragonflow.Utils.I18N.dmp("E:", s4);
								outputStream.println("<div class='row'><div class='col-xs-12 col-sm-12 col-md-12'>"
											+"<paper-input type='search' id='' name='encoding' label='Remote Machine encoding:' size='30' value='"+s3+"'></paper-input>"
											+"<div>Enter code page (ie Cp1252, Shift_JIS, EUC-JP, etc.)</div>"
											+"</div></div>");
            }
        }
        String s2 = com.dragonflow.Page.machinePage.getValue(hashmap, "_trace").length() <= 0 ? "" : " checked ";
		outputStream.println("<div class='row'><div class='col-xs-12 col-sm-12 col-md-12'>"
							+"<paper-checkbox-ext "+s2+" checked-value='CHECKED' name='trace'><div>Check this box to trace messages to and from the remote server (messages are  written in the RunMonitor.log file)</div></paper-checkbox-ext>"
							+"</div></div>");

		outputStream.println("<div class='row'><div class='col-xs-12 col-sm-12 col-md-12'>"
								+"<paper-radio-group-ext attr-for-selected='label' selected='test'>"
								+"<paper-radio-button name='addtest' label='test' value='test'>"+s+" and Test,Check to " + s + " the profile and test the connection</paper-radio-button>"
								+"<paper-radio-button name='addtest' label='add' value='add'>"+s+" Only,Check to " + s + " the profile only</paper-radio-button>"
								+"</paper-radio-group-ext>"
								+"</div></div>");

        return flag;
	}
	private void printOsOptionElement(jgl.Array array){
			java.util.Vector vector = new Vector();
      for (int i = 0; i < array.size(); i++) {
          vector.addElement(array.at(i));
      }
      for (int i = 0; i < vector.size(); i += 2) {
          String value = (String) vector.elementAt(i);
          String label = (String) vector.elementAt(i+1);
          outputStream.println("<paper-item-ext label='"+label+"' value='"+value+"'>"+label+"<paper-ripple></paper-ripple></paper-item-ext>");
      }
	}
	 void saveAddProperties(String s, jgl.HashMap hashmap, String s1)
	    {
	        String s3 = (String)hashmap.get("_host");
	        hashmap.put("_id", s1);
	        hashmap.put("_host", s3);
	        hashmap.put("_trace", request.getValue("trace"));
	        hashmap.put("_os",request.getValue("os"));
	        hashmap.put("_status", "unknown");
	    }
}

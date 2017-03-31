/*
 * Created on 2014-2-9 3:06:20
 *
 * .java
 *
 * History:
 *
 */
package com.dragonflow.Utils;

/**
 * Comment for <code></code>
 * 
 * @author
 * @version 0.0
 * 
 * 
 */

import java.util.Enumeration;

import jgl.Array;

import com.dragonflow.SiteView.Machine;
import com.dragonflow.SiteView.Platform;

// Referenced classes of package com.dragonflow.Utils:
// SSHCommandLine, RemoteCommandLine

public class RemoteFile {

    String machineID;

    String pwd;

    String path;

    String fullPath;

    boolean directory;

    int os;

    public RemoteFile(String s, String s1) {
        machineID = "";
        pwd = "";
        path = "";
        fullPath = "";
        directory = false;
        path = s1;
        machineID = s;
        if (com.dragonflow.SiteView.Machine.isNTSSH(s)) {
            return;
        }
        com.dragonflow.SiteView.Machine machine = Machine.getMachine(s);
        if (machine != null) {
            com.dragonflow.Utils.RemoteCommandLine remotecommandline = Machine.getRemoteCommandLine(machine);
            os = Machine.getOS(s);
            if (com.dragonflow.SiteView.Platform.isWindows(os)) {
                if (path.indexOf(":\\") >= 0) {
                    fullPath = path;
                }
            } else if (com.dragonflow.SiteView.Platform.isUnix(os) && path.startsWith("/")) {
                fullPath = path;
            }
            com.dragonflow.SiteView.Machine _tmp = machine;
            if (machine.getPropertyAsBoolean(com.dragonflow.SiteView.Machine.pTrace)) {
                com.dragonflow.Log.LogManager.log("RunMonitor", "RemoteFile() after UNIX setting fullpath. path: " + path + " fullPath: " + fullPath);
            }
            if (fullPath.length() == 0) {
                String s2 = Platform.currentDirectoryCommand(s);
                jgl.Array array = remotecommandline.exec(s2, machine);
                if (remotecommandline.exitValue == 0 && array.size() > 0) {
                    pwd = (String) array.at(0);
                    pwd = pwd.trim();
                    findStartOfUnixPwdResultDirectoryPath(machine);
                    com.dragonflow.SiteView.Machine _tmp1 = machine;
                    if (machine.getPropertyAsBoolean(com.dragonflow.SiteView.Machine.pTrace)) {
                        com.dragonflow.Log.LogManager.log("RunMonitor", "RemoteFile() after UNIX call to pwd on remote. pwd: " + pwd + " from remote line 1: " + (String) array.at(0));
                    }
                    if (pwd.length() == 0) {
                        pwd = (String) array.at(1);
                        pwd = pwd.trim();
                        findStartOfUnixPwdResultDirectoryPath(machine);
                        com.dragonflow.SiteView.Machine _tmp2 = machine;
                        if (machine.getPropertyAsBoolean(com.dragonflow.SiteView.Machine.pTrace)) {
                            com.dragonflow.Log.LogManager.log("RunMonitor", "RemoteFile() after UNIX call to pwd on remote. pwd: " + pwd + " from remote line 2: " + (String) array.at(1));
                        }
                    }
                }
                if (!pwd.endsWith(com.dragonflow.SiteView.Platform.pathSeparator(os))) {
                    pwd += Platform.pathSeparator(os);
                }
                fullPath = pwd + path;
                com.dragonflow.SiteView.Machine _tmp3 = machine;
                if (machine.getPropertyAsBoolean(com.dragonflow.SiteView.Machine.pTrace)) {
                    com.dragonflow.Log.LogManager.log("RunMonitor", "RemoteFile() after UNIX pwd plus path.  pwd: " + pwd + " path: " + path + " fullPath: " + fullPath);
                }
            } else {
                com.dragonflow.SiteView.Machine _tmp4 = machine;
                if (machine.getPropertyAsBoolean(com.dragonflow.SiteView.Machine.pTrace)) {
                    com.dragonflow.Log.LogManager.log("RunMonitor", "RemoteFile() after UNIX FINAL fullpath. path: " + path + " fullPath: " + fullPath);
                }
            }
        } else {
            com.dragonflow.Log.LogManager.log("Error", "Could find machine for " + s + " - looking for remote file " + path);
        }
    }

    private void findStartOfUnixPwdResultDirectoryPath(com.dragonflow.SiteView.Machine machine) {
        int i = pwd.indexOf(" /");
        com.dragonflow.SiteView.Machine _tmp = machine;
        if (machine.getPropertyAsBoolean(com.dragonflow.SiteView.Machine.pTrace)) {
            com.dragonflow.Log.LogManager.log("RunMonitor", "RemoteFile() after UNIX call to pwd on remote. pwd: " + pwd + " indexPathStart: " + i);
        }
        if (com.dragonflow.SiteView.Platform.isUnix(os) && i > 0 && i < pwd.length()) {
            pwd = pwd.substring(i + 1);
        }
    }

    public String getFullPath() {
        return fullPath;
    }

    public String getPwd() {
        return pwd;
    }

    public String pathSeparator() {
        return com.dragonflow.SiteView.Platform.pathSeparator(os);
    }

    public jgl.Array listFiles() {
        String s = Platform.dirCommand(machineID, com.dragonflow.SiteView.Platform.DIR_FILES);
        s = s + " " + fullPath;
        String s1 = machineID;
        if (s1.startsWith("\\\\")) {
            s1 = s1.substring(2);
        }
        Object obj = null;
        jgl.Array array = new Array();
        if (com.dragonflow.SiteView.Machine.isNTSSH(s1)) {
            s = "directory.bat";
            com.dragonflow.SiteView.Machine machine = Machine.getNTMachine(s1);
            com.dragonflow.Utils.SSHCommandLine sshcommandline = new SSHCommandLine();
            jgl.Array array1 = sshcommandline.exec(s, machine, false);
            Enumeration enumeration = array1.elements();
            while (enumeration.hasMoreElements()) {
                String s2 = (String) enumeration.nextElement();
                s2 = s2.trim();
                if (!s2.endsWith("/")) {
                    array.add(s2);
                }
            }
        } else {
            com.dragonflow.SiteView.Machine machine1 = Machine.getMachine(machineID);
            if (machine1 != null) {
                com.dragonflow.Utils.RemoteCommandLine remotecommandline = Machine.getRemoteCommandLine(machine1);
                if (com.dragonflow.SiteView.Platform.isUnix(com.dragonflow.SiteView.Machine.getOS(machineID))) {
                    s = s + " | cat";
                }
                jgl.Array array2 = remotecommandline.exec(s, machine1);
                Enumeration enumeration1 = array2.elements();
                while (enumeration1.hasMoreElements()) {
                    String s3 = (String) enumeration1.nextElement();
                    s3 = s3.trim();
                    if (s3.endsWith("*")) {
                        s3 = s3.substring(0, s3.length() - 1);
                    }
                    if (!s3.endsWith("/")) {
                        array.add(s3);
                    }
                } 
            }
        }
        return array;
    }
}

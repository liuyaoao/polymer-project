package com.dragonflow.Page;

import jgl.HashMap;

import com.dragonflow.SiteView.MasterConfig;
import com.dragonflow.SiteView.Platform;
import com.dragonflow.SiteView.User;
import com.dragonflow.Utils.TextUtils;

// Referenced classes of package com.dragonflow.Page:
// CGI

public class loginPage extends com.dragonflow.Page.CGI
{

    public loginPage()
    {
    }
	private static String username="";
	private static String errormessage="";
    void printLoginForm(String s,String res) throws java.io.IOException
    {
    	String tenant=getTenant();
        jgl.HashMap masterConfig = getMasterConfig();
        jgl.HashMap hashmap1 = new HashMap();
        String bodyHeader = Platform.productName + " Login";
        
        super.printCGIHeader();
        printBodyHeader(bodyHeader);
        String loginHTMLHeader = TextUtils.getValue(masterConfig, "_loginHTMLHeader");
        if(loginHTMLHeader.length() > 0)
        {
            outputStream.println(loginHTMLHeader);
        }

        String loginpanelLink = "<link rel='import' href='/SiteView/htdocs/js/components/login-panel/login-panel.html'>\n";
        outputStream.println(loginpanelLink+"<center><H2>" + Platform.productName + " Login</H2></center><hr>");
        Boolean canChangePassword = TextUtils.getValue(masterConfig, "_disableLoginChangePassword").length() == 0;
       if(tenant.length()>0)
    	   tenant="/"+tenant;
        outputStream.println("<div class='container' style='text-align: center;'>"
                  + "<login-panel "
                  +" form-id='loginFormNative' "
                  +" opened "
                  +" action-url='"+tenant+"/SiteView/cgi/go.exe/SiteView' "
                  +" group-redirect='" + request.getValue("groupRedirect") + "' "
                  +" can-change-password='"+canChangePassword+"' "
                  +" result-message='"+errormessage+"' "
                  +" user-name='"+username+"' "
                  +" _login-hashmap='" + com.dragonflow.Page.loginPage.getValue(hashmap1, "_login") + "'"
                  +" _password-hashmap='" + com.dragonflow.Page.loginPage.getValue(hashmap1, "_password") + "'"
                  +" _new-password-hashmap='" + com.dragonflow.Page.loginPage.getValue(hashmap1, "_newPassword") + "'"
                  +" _new-password2-hashmap='" + com.dragonflow.Page.loginPage.getValue(hashmap1, "_newPassword2") + "'"
                  +"></login-panel></div><hr>");

        printFooter(outputStream);
    }

    String getUserTitle(jgl.HashMap hashmap)
    {
        String realName = loginPage.getValue(hashmap, "_realName");
        if(realName.length() == 0)
        {
            realName = loginPage.getValue(hashmap, "_login");
        }
        return realName;
    }

    void printLoginComplete(String s)
        throws java.lang.Exception
    {
        String tenant = getTenant();
    	String login = request.getValue("_login");
        String password = request.getValue("_password");
        username=login;
        jgl.HashMap hashmap = MasterConfig.getMasterConfig();
        jgl.Array users = User.findUsersForLogin(login, password,tenant);
        String loginDisabledMessage = "";
        if(users.size() > 1)
        {
        	 loginDisabledMessage = "This username/password cannot be used to login using this login. Use the specific login URL instead (http://"
             		+ TextUtils.getValue(hashmap, "_webserverAddress") + "/SiteView/?account=yourlogin";
//            loginDisabledMessage = "This username/password cannot be used to login using this login. Use the specific login URL instead (http://"
//            		+ TextUtils.getValue(hashmap, "_webserverAddress") + "/SiteView/?account=yourlogin" + "<hr>";
            if(TextUtils.getValue(hashmap, "_loginDuplicateMessage").length() > 0)
            {
                loginDisabledMessage = TextUtils.getValue(hashmap, "_loginDuplicateMessage");
            }
            errormessage = loginDisabledMessage;
        	printLoginForm("LoginForm", loginDisabledMessage);
            return;
//            loginDisabledMessage = loginDisabledMessage + "<br><a href=\"/SiteView/cgi/go.exe/SiteView?page=login\">Return to login</a>";
        } else
        if(users.size() == 1)
        {
            User user = (User)users.at(0);
            if(user.getProperty("_disabled").length() > 0)
            {
//                loginDisabledMessage = "This account has been disabled.<hr>";
                loginDisabledMessage = "This account has been disabled";
                if(TextUtils.getValue(hashmap, "_loginDisabledMessage").length() > 0)
                {
                    loginDisabledMessage = TextUtils.getValue(hashmap, "_loginDisabledMessage");
                }
                errormessage = loginDisabledMessage;
            	printLoginForm("LoginForm", loginDisabledMessage);
                return;
//                loginDisabledMessage = loginDisabledMessage + "<br><a href=\"/SiteView/cgi/go.exe/SiteView?page=login\">Return to login</a>";
            } else
            {
                boolean flag = true;
                String s4 = password;
                if(request.getValue("_newPassword").length() > 0 && (user.getProperty(User.pLdap).length() == 0 || user.getProperty(User.pSecurityPrincipal).length() == 0))
                {
                    if(request.getValue("_newPassword").equals(request.getValue("_newPassword2")))
                    {
                        jgl.Array array1 = User.readUsers();
                        jgl.HashMap hashmap1 = User.findUser(array1, user.getProperty(User.pID));
                        if(hashmap1 != null)
                        {
                            hashmap1.put("_password", request.getValue("_newPassword"));
                            s4 = request.getValue("_newPassword");
                            User.writeUsers(array1);
                        }
                    } else
                    {
                        flag = false;
                        loginDisabledMessage = "New passwords did not match. Please re-enter them";
//                        loginDisabledMessage = "New passwords did not match. Please re-enter them.<hr>";
                        if(TextUtils.getValue(hashmap, "_loginNoNewMatchMessage").length() > 0)
                        {
                            loginDisabledMessage = TextUtils.getValue(hashmap, "_loginNoNewMatchMessage");
                        }
                        errormessage = loginDisabledMessage;
                    	printLoginForm("LoginForm", loginDisabledMessage);
                        return;
//                        loginDisabledMessage = loginDisabledMessage + "<br><a href=\"/SiteView/cgi/go.exe/SiteView?page=login\">Return to login</a>";
                    }
                } else
                if(request.getValue("_newPassword").length() > 0)
                {
                    flag = false;
//                    loginDisabledMessage = "You MUST use LDAP to change your password.<hr>";
                    loginDisabledMessage = "You MUST use LDAP to change your password";
                    if(TextUtils.getValue(hashmap, "_loginNoNewMatchMessage").length() > 0)
                    {
                        loginDisabledMessage = TextUtils.getValue(hashmap, "_loginNoNewMatchMessage");
                    }
                    errormessage = loginDisabledMessage;
                	printLoginForm("LoginForm", loginDisabledMessage);
                    return;
//                    loginDisabledMessage = loginDisabledMessage + "<br><a href=\"/SiteView/cgi/go.exe/SiteView?page=login\">Return to login</a>";
                }
                if(flag)
                {
                    String account = user.getProperty(User.pAccount);
                    String groupRedirect = request.getValue("groupRedirect");
                    String groupRedirectUrl;
                    
                    if(groupRedirect != null && groupRedirect.length() > 0)
                    {
                        String s8 = account.equalsIgnoreCase("administrator") ? "" : "/accounts/" + account;
                        groupRedirectUrl = "/SiteView" + s8 + "/htdocs/" + groupRedirect + ".html";
                    } else
                    {
                        groupRedirectUrl = "/SiteView?account=" + user.getProperty(User.pAccount);
                    }
                    request.addOtherHeader("Set-Cookie: " + com.dragonflow.SiteView.Platform.productName + "=" + user.getProperty(User.pAccount) + "|" + user.getProperty(User.pLogin) + "|" + com.dragonflow.Utils.TextUtils.obscure(s4) +"|"+tenant+ "; path=/");
                    if(tenant.length()==0)
                    	tenant="";
                    else
                    	tenant="/"+tenant;
                    request.addOtherHeader("Location: " + tenant+groupRedirectUrl);
                    request.setStatus(301);
                    loginDisabledMessage = "<br>Correct username and password<br><a href=\"" +  tenant+groupRedirectUrl + "\">Go to Main Console</a>" + "<meta http-equiv=\"refresh\" content=\"5;url=\"" + groupRedirectUrl + "\">";
                }
            }
        } else
        {
        	errormessage = "Incorrect username or password";
        	printLoginForm("LoginForm", "Incorrect username or password");
            return;
//            loginDisabledMessage = "Incorrect username or password.<hr>";
//            if(TextUtils.getValue(hashmap, "_loginIncorrectMessage").length() > 0)
//            {
//                loginDisabledMessage = TextUtils.getValue(hashmap, "_loginIncorrectMessage");
//            }
//            loginDisabledMessage = loginDisabledMessage + "<br><a href=\"/SiteView/cgi/go.exe/SiteView?page=login\">Return to login</a>";
        }
        super.printCGIHeader();
        outputStream.println(loginDisabledMessage);
        printFooter(outputStream);
    }

    public void printCGIHeader()
    {
    }

    void printErrorPage(String s)
    {
        printBodyHeader("User Preferences");
        outputStream.println("<p><CENTER><H2></H2></CENTER>\n<HR>There were errors in the entered information.  Use your browser's back button to return\nthe general preferences editing page\n");
        String as[] = com.dragonflow.Utils.TextUtils.split(s, "\t");
        outputStream.print("<UL>\n");
        for(int i = 0; i < as.length; i++)
        {
            if(as[i].length() > 0)
            {
                outputStream.print("<LI><B>" + as[i] + "</B>\n");
            }
        }

        outputStream.print("</UL><HR></BODY>\n");
    }

    public void printBody()
        throws java.lang.Exception
    {
        String operation = request.getValue("operation");
        if(operation.length() == 0)
        {
            operation = "LoginForm";
        }
        if(operation.equals("LoginForm"))
        {request.getValue("loginerror");
            printLoginForm(operation,errormessage);
            errormessage="";
        } else if(operation.equals("Login"))
        {
            printLoginComplete(operation);
        } else
        {
            printError("The link was incorrect", "unknown operation", "/SiteView/" + request.getAccountDirectory() + "/SiteView.html");
        }
    }

    public static void main(String args[])
        throws java.io.IOException
    {
        if(args.length == 1 && args[0].equals("-d"))
        {
            jgl.Array array = User.readUsers();
            jgl.HashMap hashmap = new HashMap();
            for(int i = 1; i < array.size(); i++)
            {
                jgl.HashMap hashmap1 = (jgl.HashMap)array.at(i);
                String id = TextUtils.getValue(hashmap1, "_id");
                String login = TextUtils.getValue(hashmap1, "_login");
                String password = TextUtils.getValue(hashmap1, "_password");
                String userpassword = login + "/" + password;
                if(hashmap.get(userpassword) != null)
                {
                    jgl.HashMap hashmap2 = (jgl.HashMap)hashmap.get(userpassword);
                    System.out.println("Duplicate found " + login + " " + password + "  account=" + id);
                    System.out.println("Original        " + TextUtils.getValue(hashmap2, "_login") + " " + TextUtils.getValue(hashmap2, "_password") + "  account=" + TextUtils.getValue(hashmap2, "_id"));
                }
                hashmap.put(userpassword, hashmap1);
            }

            System.exit(0);
        }
        loginPage loginpage = new loginPage();
        if(args.length > 0)
        {
            loginpage.args = args;
        }
        loginpage.handleRequest();
    }
}

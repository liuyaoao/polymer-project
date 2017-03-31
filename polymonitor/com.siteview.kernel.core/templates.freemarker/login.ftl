<center><H2> ${productName} 系统登陆</H2></center><hr>

<FORM ACTION=/SiteView/cgi/go.exe/SiteView method=POST>
<input type=hidden name=page value=login>
<input type=hidden name=groupRedirect value= ${groupRedirect}>
<input type=hidden name=operation value=Login>

<TABLE>
	<TR><TD ALIGN=RIGHT>用户名</TD>
		<TD>
			<TABLE>
				<TR><TD ALIGN=LEFT><input type=text name=_login size=30 value=""></TD></TR>
				<TR><TD><FONT SIZE=-1>输入用户名</FONT></TD></TR>
			</TABLE>
		</TD>
		<TD><I> ${_login} </I></TD>
	</TR>
	<TR>
		<TD ALIGN=RIGHT>密码</TD>
		<TD>
		<TABLE>
			<TR>
				<TD ALIGN=LEFT><input type=password name=_password size=30 value=""></TD>
			</TR>
			<TR>
				<TD><FONT SIZE=-1>输入密码</FONT></TD>
			</TR>
		</TABLE>
		<TD><I> ${_password} </I></TD>
	</TR>

<TR><TD>&nbsp;</TD></TR>
<TR><TD COLSPAN=2 ALIGN=CENTER><input type=submit VALUE="Log In"></TD></TR>
<TR><TD>&nbsp;</TD></TR>
        

<#if _disableLoginChangePassword == "">
   <TR>
	   	<TD ALIGN=LEFT><H3>修改密码</H3></TD></TR>
	   	<TR>
	   		<TD ALIGN=RIGHT>新密码</TD>
	    	<TD>
	    		<TABLE>
	    			<TR><TD ALIGN=LEFT><input type=password name=${_newPassword} size=30 value=""></TD></TR>
	            	<TR><TD><FONT SIZE=-1>修改密码, 在这儿输入新密码</FONT></TD></TR>
	        	</TABLE>
	    	</TD>
	    	<TD><I>${_newPassword} </I></TD>
	    </TR>
   <TR>
   		<TD ALIGN=RIGHT>新密码确认</TD> 
    	<TD>
    		<TABLE>
    			<TR><TD ALIGN=LEFT><input type=password name=${_newPassword2} size=30 value=""></TD></TR>
   				<TR><TD><FONT SIZE=-1>再一次输入新密码确认</FONT></TD></TR>
           </TABLE>
           	</TD><TD><I> ${_newPassword2} </I></TD>
    </TR>
</#if>  
          
</TABLE>

</FORM>
<cfoutput>
	<div id="loginDiv">
		<form name="LoginForm" method="post" id="LoginForm" action="#event.buildLink('Login/doLogin')#" >
			<div id="loginContainer" class="center">
				<div id="messageBox"><cfif StructKeyExists(prc,"login") and StructKeyExists(prc.login,"ResponseDescription") and Len(prc.login.responsedescription)>#encodeforHTML(prc.login.responsedescription)#</cfif></div>
				<div class="formRow">
					<div class="formLabel">Email Address: </div>
					<div class="formField"><input id="emailAddress" type="text" name="emailaddress"></div>
				</div>
				<div class="formRow">
					<div class="formLabel">Password: </div>
					<div class="formField"><input id="password" type="password"  name="password"></div>
				</div>
				<br clear="all">
				<div class="center"><input type="submit" value="Login"  name="loginBtn" id="loginBtn"></div><BR>
				<a href="#event.buildLink('Signup.index')#">Sign Up</a>
			</div>
		</form>
	</div>
</cfoutput>
<h1>Sign Up Page</h1>
<cfoutput>
	<div id="loginDiv">
		<form name="SignUpForm" method="post" id="SignUpForm" action="#event.buildLink('SignUp/doSignUp')#" >
			<div id="loginContainer" class="center">
				<div id="messageBox"><cfif StructKeyExists(prc,"signup") and StructKeyExists(prc.signup,"ResponseDescription") and Len(prc.signup.responsedescription)>#encodeforHTML(prc.signup.responsedescription)#</cfif></div>
				<div class="float-container">
					<div class="float-child">First Name: </div>
					<div class="float-child"><input id="firstName" type="text"  name="firstName"></div>
				</div>
                <div class="float-container">
					<div class="float-child">Last Name: </div>
					<div class="float-child"><input id="lastName" type="text"  name="lastName"></div>
				</div>
                <div class="float-container">
					<div class="float-child">Email Address: </div>
					<div class="float-child"><input id="emailAddress" type="text" name="emailaddress" data-msg-required="Please enter an email address"></div>
				</div>
                <div class="float-container">
					<div class="float-child">Password: </div>
					<div class="float-child"><input id="password" type="password"  name="password" data-msg-required="Please enter a password"></div>
				</div>
				<br clear="all">
				<div class="center"><input type="submit" value="Sign Up"  name="SignUpBtn" id="SignUpBtn"></div>
			</div>
		</form>
	</div>
</cfoutput>
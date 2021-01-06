<h1>Edit Profile</h1>
<cfoutput>
	<div id="loginDiv">
		<form name="EditForm" method="post" id="EditForm" action="#event.buildLink('Profile/editProfile')#" >
			<div id="loginContainer" class="center">
				<div id="messageBox"><cfif StructKeyExists(prc,"edit") and StructKeyExists(prc.edit,"ResponseDescription") and Len(prc.edit.responsedescription)>#encodeforHTML(prc.edit.responsedescription)#</cfif></div>
				<div class="float-container">
					<div class="float-child">First Name: </div>
					<div class="float-child"><input id="firstName" type="text" value="#prc.userInfo.output.firstname#" name="firstName"></div>
				</div>
                <div class="float-container">
					<div class="float-child">Last Name: </div>
					<div class="float-child"><input id="lastName" type="text" value="#prc.userInfo.output.lastname#" name="lastName"></div>
				</div>
                <div class="float-container">
					<div class="float-child">Email Address: </div>
					<div class="float-child"><input id="emailAddress" type="text" name="emailaddress" value="#prc.userInfo.output.emailaddress#" data-msg-required="Please enter an email address"></div>
				</div>
				<br clear="all">
				<div class="float-child"><input type="submit" value="Update User Info"  name="Btn" id="btn"></div>
                <BR><BR>
			</div>
		</form>
	</div>


    <div id="loginDiv">
		<form name="PasswordForm" method="post" id="PasswordForm" action="#event.buildLink('Profile/editPassword')#" >
			<div id="loginContainer" class="center">
				<div id="messageBox"><cfif StructKeyExists(prc,"edit") and StructKeyExists(prc.edit,"ResponseDescriptionPass") and Len(prc.edit.ResponseDescriptionPass)>#encodeforHTML(prc.edit.ResponseDescriptionPass)#</cfif></div>
				<div class="float-container">
					<div class="float-child">New Password: </div>
					<div class="float-child"><input id="password" type="password" name="password"></div>
				</div>
                <div class="float-container">
					<div class="float-child">Re-Password: </div>
					<div class="float-child"><input id="repassword" type="password" name="repassword"></div>
				</div>
				<br clear="all">
				<div class="float-child"><input type="submit" value="Update Password"  name="Btn" id="btn"></div>
			</div>
		</form>
	</div>
</cfoutput>
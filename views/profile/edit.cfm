<h1>Edit Profile</h1>
<cfoutput>
	<div id="loginDiv">
		<form name="SignUpForm" method="post" id="SignUpForm" action="#event.buildLink('Profile/editProfile')#" >
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
				<div class="center"><input type="submit" value="Update"  name="SignUpBtn" id="SignUpBtn"></div>
			</div>
		</form>
	</div>
</cfoutput>
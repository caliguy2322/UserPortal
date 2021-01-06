<cfoutput>
<h1>Profile Page</h1>
#html.table( data=prc.userInfo, class="table table-striped table-hover" )#
<div id="loginContainer" class="center">
    <div class="float-child"><a href="#event.buildLink('profile.edit')#">edit</a></div>
    <div class="float-child"><a href="#event.buildLink('profile.logout')#">Log Out</a></div>
</div>    
</cfoutput>
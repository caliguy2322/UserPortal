<cfoutput>
<h1>Profile Page</h1> &nbsp; <cfif session.isadmin eq 1> <a href="#event.buildLink('admin.index')#">Admin Page</a> </cfif>
#html.table( data=prc.userInfo.output, class="table table-striped table-hover" )#
<div id="loginContainer" class="center">
    <div class="float-child"><a href="#event.buildLink('profile.edit')#">edit</a></div>
    <div class="float-child"><a href="#event.buildLink('profile.logout')#">Log Out</a></div>
</div>    
</cfoutput>
<cfoutput>
<h1>Admin Page</h1>
<a href="#event.buildLink('Profile.index')#">Profile Page</a>
#html.table( data=prc.getAllUsers.output, class="table table-striped table-hover" )#
</cfoutput>
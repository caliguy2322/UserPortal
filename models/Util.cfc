<cfcomponent output="false">
	
	<cffunction name="doHashPassword" returntype="string">
		<cfargument name="password" type="string" required="true">
		<cfargument name="hashKey" type="string" required="true">
		<cfreturn Hash(arguments.password & "_" & arguments.hashKey, 'SHA-512')>
	</cffunction>

	<cffunction name="doValidate" returntype="struct">
		<cfargument name="rc" type="struct" required="false" default="">
		<cfset var returnStruct = structNew()>
		
		<cfset returnStruct.success = true>
		<cfset returnStruct.responseDescription = "">
			
		<cfif not structKeyExists(arguments.rc,"emailaddress")>
		 	<cfset returnStruct.responseDescription = "invalid emailaddress (missing)">
			<cfset returnStruct.success = false>
		<cfelse> 
		   	<cfif not Len(trim(arguments.rc.emailaddress))>
				<cfset returnStruct.responseDescription = "invalid emailaddress (missing)">
				<cfset returnStruct.success = false>
			<cfelseif Len(arguments.rc.emailaddress) gt 50>
				<cfset returnStruct.responseDescription = "invalid emailaddress (too long). 50 chars max">
				<cfset returnStruct.success = false>	
			</cfif>
		</cfif>	
		
		<cfif not structKeyExists(arguments.rc,"password")>
		 	<cfset returnStruct.responseDescription = "invalid password (missing)">
			<cfset returnStruct.success = false>
		<cfelse> 
		   	<cfif not Len(trim(arguments.rc.password))>
				<cfset returnStruct.responseDescription = "invalid password (missing)">
				<cfset returnStruct.success = false>
			<cfelseif Len(arguments.rc.password) gt 15>
				<cfset returnStruct.responseDescription = "invalid password (too long). 15 chars max">
				<cfset returnStruct.success = false>	
			</cfif>
		</cfif>	

		<cfreturn returnStruct>
	</cffunction>

</cfcomponent>


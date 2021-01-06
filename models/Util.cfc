<cfcomponent output="false">
	
	<cffunction name="doHashPassword" returntype="string">
		<cfargument name="password" type="string" required="true">
		<cfargument name="hashKey" type="string" required="true">
		<cfreturn Hash(arguments.password & "_" & arguments.hashKey, 'SHA-512')>
	</cffunction>

	<cffunction name="doValidate">
		<cfargument name="rc" type="struct" required="false" default="">

		<cfif not structKeyExists(arguments.rc,"emailaddress")>
			<cfthrow message="invalid emailaddress" type="validation" detail="missing">
		<cfelse> 
		   	<cfif not Len(trim(arguments.rc.emailaddress))>
			   	<cfthrow message="invalid emailaddress" type="validation" detail="missing">
			<cfelseif Len(arguments.rc.emailaddress) gt 50>
				<cfthrow message="invalid emailaddress" type="validation" detail="too long. 50 chars max">
			</cfif>
		</cfif>	
		
		<cfif not structKeyExists(arguments.rc,"password")>
			<cfthrow message="invalid password" type="validation" detail="missing">
		<cfelse> 
		   	<cfif not Len(trim(arguments.rc.password))>
			   	<cfthrow message="invalid password " type="validation" detail="missing">
			<cfelseif Len(arguments.rc.password) gt 15>
				<cfthrow message="invalid password" type="validation" detail="too long. 15 chars max">
			</cfif>
		</cfif>	

	</cffunction>

</cfcomponent>


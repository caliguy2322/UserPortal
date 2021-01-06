<cfcomponent output="false">
	
	<cfproperty name="dao" inject="models.UserDAO">
    <cfproperty name="util" inject="models.Util">
	
	<cffunction name="init" returntype="any" >
		<cfreturn this>
	</cffunction>
	
	<cffunction name="doSignUp" returntype="struct">
		<cfargument name="rc" type="struct" required="true">
		<cfargument name="HashKey" type="string" required="true">

		<cfset var validateStruct = structNew()>
        <cfset var loginStructValidator = structNew()>
		<cfset var returnStruct = structNew()>
		<cfset returnStruct.responseDescription = "">

		<cfset validateStruct = util.doValidate(arguments.rc)>	
		<cfset returnStruct.responseDescription = validateStruct.responseDescription>
		<cfif validateStruct.success>
			<cfset hashPassword = util.doHashPassword(password = arguments.rc.password, hashKey = arguments.Hashkey)>
            <cfset arguments.rc.hashPassword = hashPassword>
            <cftry>
			    <cfset returnStruct = dao.NewUser(rc = arguments.rc)> 
                <cfcatch type="any">
				    <cfthrow message="#cfcatch.message#" type="#cfcatch.type#" detail="#cfcatch.detail#">
			    </cfcatch>
		    </cftry>	
		</cfif>

		<cfreturn returnStruct>
	</cffunction>

    <cffunction name="doLogin" returntype="struct">
		<cfargument name="rc" type="struct" required="true">
		<cfargument name="HashKey" type="string" required="true">
		<cfset var validateStruct = structNew()>
		<cfset var returnStruct = structNew()>
		<cfset returnStruct.responseDescription = "">

		<cfset validateStruct = util.doValidate(arguments.rc)>	
		<cfset returnStruct.responseDescription = validateStruct.responseDescription>
		<cfif validateStruct.success>
			<cfset hashPassword = util.doHashPassword(password = arguments.rc.password, hashKey = arguments.Hashkey)>
            <cftry>
			    <cfset returnStruct = dao.login(emailaddress = arguments.rc.emailaddress, password = hashPassword)> 
                <cfcatch type="any">
				    <cfthrow message="#cfcatch.message#" type="#cfcatch.type#" detail="#cfcatch.detail#">
			    </cfcatch>
		    </cftry>	

			<cfif not returnStruct.output.recordcount>
				<cfset returnStruct.responseDescription = "Invalid login">
			</cfif>
		</cfif>

		<cfreturn returnStruct>
	</cffunction>

    <cffunction name="doGetAllUsers" returntype="struct">
		<cfset var returnStruct = structNew()>
		<cfset returnStruct.responseDescription = "">
        <cftry>
		    <cfset returnStruct = dao.doGetAll()>
            <cfcatch type="any">
                <cfthrow message="#cfcatch.message#" type="#cfcatch.type#" detail="#cfcatch.detail#">
            </cfcatch>
        </cftry>	
		<cfreturn returnStruct>
	</cffunction>
	
</cfcomponent>
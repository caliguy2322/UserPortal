<cfcomponent output="false">
	
	<cfproperty name="dao" inject="models.UserDAO">
    <cfproperty name="util" inject="models.Util">
	
	<cffunction name="init" returntype="any" >
		<cfreturn this>
	</cffunction>
	
	<cffunction name="doSignUp" returntype="struct">
		<cfargument name="rc" type="struct" required="true">
		<cfargument name="HashKey" type="string" required="true">
		<cfset var returnStruct = structNew()>
		<cfset returnStruct.responseDescription = "">

		<cftry>
			<cfset util.doValidate(arguments.rc)>	
			<cfcatch type="any">
				<cfthrow message="#cfcatch.message#" type="#cfcatch.type#" detail="#cfcatch.detail#">
			</cfcatch>
		</cftry>
		
		<cfset hashPassword = util.doHashPassword(password = arguments.rc.password, hashKey = arguments.Hashkey)>
		<cfset arguments.rc.hashPassword = hashPassword>
		<cftry>
			<cfset returnStruct = dao.NewUser(rc = arguments.rc)> 
			<cfcatch type="any">
				<cfthrow message="#cfcatch.message#" type="#cfcatch.type#" detail="#cfcatch.detail#">
			</cfcatch>
		</cftry>	

		<cfreturn returnStruct>
	</cffunction>

    <cffunction name="doLogin" returntype="struct">
		<cfargument name="rc" type="struct" required="true">
		<cfargument name="HashKey" type="string" required="true">
		<cfset var returnStruct = structNew()>
		<cftry>
			<cfset util.doValidate(arguments.rc)>	
			<cfcatch type="any">
				<cfthrow message="#cfcatch.message#" type="#cfcatch.type#" detail="#cfcatch.detail#">
			</cfcatch>
		</cftry>

		<cfset hashPassword = util.doHashPassword(password = arguments.rc.password, hashKey = arguments.Hashkey)>
		<cftry>
			<cfset returnStruct = dao.login(emailaddress = arguments.rc.emailaddress, password = hashPassword)> 
			<cfcatch type="any">
				<cfthrow message="#cfcatch.message#" type="#cfcatch.type#" detail="#cfcatch.detail#">
			</cfcatch>
		</cftry>	

		<cfif not returnStruct.output.recordcount>
			<cfthrow message="Invalid login" type="Validation" detail="">
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

	<cffunction name="doGetUserByUserId" returntype="struct">
		<cfargument name="rc" type="struct" required="true">
		<cfset var returnStruct = structNew()>
		<cftry>
			<cfset returnStruct = dao.doGetUserByUserId(arguments.rc)>	
			<cfcatch type="any">
				<cfthrow message="#cfcatch.message#" type="#cfcatch.type#" detail="#cfcatch.detail#">
			</cfcatch>
		</cftry>
		<cfreturn returnStruct>
	</cffunction>

	<cffunction name="doEditProfile" returntype="struct">
		<cfargument name="rc" type="struct" required="true">
		<cfset var returnStruct = structNew()>
		<cftry>
			<cfset util.doValidateEmail(arguments.rc)>	
			<cfcatch type="any">
				<cfthrow message="#cfcatch.message#" type="#cfcatch.type#" detail="#cfcatch.detail#">
			</cfcatch>
		</cftry>

		<cftry>
			<cfset returnStruct = dao.update(rc = arguments.rc)> 
			<cfcatch type="any">
				<cfthrow message="#cfcatch.message#" type="#cfcatch.type#" detail="#cfcatch.detail#">
			</cfcatch>
		</cftry>	

		<cfreturn returnStruct>
	</cffunction>
	
</cfcomponent>
<cfcomponent output="false">
	<cffunction name="init" returntype="any" >
		<cfreturn this>
	</cffunction>

    <cffunction name="login" returntype="struct" access="public">
		<cfargument name="emailaddress" type="string" required="true">
		<cfargument name="password" type="string" required="true">
		<cfset var returnStruct = structNew()>
        <cfset var qLogin = "" />
		<cfset returnStruct.success = true>
		<cfset returnStruct.output = QueryNew("userid")>
		<cftry>
			<cfquery name="qLogin" datasource="#application.dsn#">
				select user_id, firstname, lastname, password, emailaddress, isadmin  from users 
				where emailaddress = <cfqueryparam value="#arguments.emailaddress#" cfsqltype="cf_sql_varchar">
				and password = <cfqueryparam value="#arguments.password#" cfsqltype="cf_sql_varchar">
			</cfquery>
			<cfset returnStruct.output = qLogin>
			<cfcatch type="any">
				<cfthrow message="Connection Error" type="dberror" detail="Unable to login">
			</cfcatch>
		</cftry>	
		
		<cfreturn returnStruct>
	</cffunction>
	
	<cffunction name="NewUser" returntype="struct" access="public">
		<cfargument name="rc" type="struct" required="true">
		<cfset var returnStruct = structNew()>
        <cfset var qSignUp = "" />
		<cfset returnStruct.success = false>
		<cftry>
			<cfquery name="qSignUp" datasource="#application.dsn#">
                INSERT INTO users (firstname, lastname, password, emailaddress, isadmin)
                VALUES  (<cfqueryparam value="#arguments.rc.firstname#" CFSQLType="cf_sql_varchar" />, 
                        <cfqueryparam value="#arguments.rc.lastname#" CFSQLType="cf_sql_varchar" />, 
                        <cfqueryparam value="#arguments.rc.hashpassword#" CFSQLType="cf_sql_varchar" />,
                        <cfqueryparam value="#arguments.rc.emailaddress#" CFSQLType="cf_sql_varchar" />, 
                        <cfqueryparam value="false" CFSQLType="cf_sql_BIT" />)
			</cfquery>
            <cfset returnStruct.success = true>
			<cfcatch type="any">
                <cfif FindNoCase("users_email_key", cfcatch.message)>
                    <cfthrow message="This user already exists" type="dberror" detail="Unable to create new user">
                <cfelse>   
				    <cfthrow message="#cfcatch.message#" type="dberror" detail="Unable to create new user">
                </cfif>    
			</cfcatch>
		</cftry>	
		<cfreturn returnStruct>
	</cffunction>

    <cffunction name="doGetAll" returntype="struct" access="public">
		<cfset var returnStruct = structNew()>
        <cfset var qGetAll = "" />
		<cftry>
			<cfquery name="qGetAll" datasource="#application.dsn#">
                SELECT user_id, firstname, lastname, password, emailaddress, isadmin
	            FROM users;
			</cfquery>
            <cfset returnStruct.output = qGetAll>
			<cfcatch type="any">
				<cfthrow message="#cfcatch.message#" type="dberror" detail="Unable to create new user">
			</cfcatch>
		</cftry>	
		<cfreturn returnStruct>
	</cffunction>


</cfcomponent>
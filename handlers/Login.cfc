/**
 * I am a new handler
 */
component{

	// OPTIONAL HANDLER PROPERTIES
	this.prehandler_only 	= "";
	this.prehandler_except 	= "";
	this.posthandler_only 	= "";
	this.posthandler_except = "";
	this.aroundHandler_only = "";
	this.aroundHandler_except = "";
	// REST Allowed HTTP Methods Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'}
	this.allowedMethods = {};

	function preHandler( event, rc, prc, action, eventArguments ){
		if (structKeyExists(session,"user_id")){ 
			if (session.user_id){ 
				relocate(event="Profile.index");
			}
		}
	}

	/**
	IMPLICIT FUNCTIONS: Uncomment to use

	function postHandler( event, rc, prc, action, eventArguments ){
	}
	function aroundHandler( event, rc, prc, targetAction, eventArguments ){
		// executed targeted action
		arguments.targetAction( event );
	}
	function onMissingAction( event, rc, prc, missingAction, eventArguments ){
	}
	function onError( event, rc, prc, faultAction, exception, eventArguments ){
	}
	function onInvalidHTTPMethod( event, rc, prc, faultAction, eventArguments ){
	}
	*/

	property name="userService" inject="UserService";

	function doLogin( event, rc, prc ){
		prc.login = structNew("soft");

		try {
			prc.login = userService.doLogin(rc, application.Hashkey);
		}
		catch(any n){
			prc.login.ResponseDescription = n.message & " " & n.detail
		}
		
		if (structKeyExists(prc.login, "output") and prc.login.output.recordcount){
			session.user_id = prc.login.output.user_id;
			session.isadmin = prc.login.output.isadmin;
			relocate(event="Profile.index");
		}	
		else {
			event.setView( "Login/index" );
		}
	}
	
	/**
	 * index
	 */
	function index( event, rc, prc ){
		event.setView( "Login/index" );
	}



}

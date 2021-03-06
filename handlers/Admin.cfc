/**
 * I am a new handler
 */
component{

	// OPTIONAL HANDLER PROPERTIES
	this.prehandler_only 	= "index";
	this.prehandler_except 	= "";
	this.posthandler_only 	= "";
	this.posthandler_except = "";
	this.aroundHandler_only = "";
	this.aroundHandler_except = "";
	// REST Allowed HTTP Methods Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'}
	this.allowedMethods = {};

	function preHandler( event, rc, prc, action, eventArguments ){
		if (not structKeyExists(session,"isadmin")){ 
			relocate(event="Admin.denied");
		}
		elseif (session.isadmin != 1){ 
			relocate(event="Admin.denied");
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


	/**
	 * index
	 */
	function index( event, rc, prc ){
		prc.getAllUsers = structNew("soft");

		try {
			prc.getAllUsers = userService.doGetAllUsers();
		}
		catch(any n){
			prc.getAllUsers.ResponseDescription = n.message & " " & n.detail
		}
		event.setView( "Admin/index" );
	}

	function denied( event, rc, prc ){
		event.setView( "Admin/denied" );
	}

}

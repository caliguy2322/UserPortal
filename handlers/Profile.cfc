/**
 * I am a new handler
 */
component{

	// OPTIONAL HANDLER PROPERTIES
	this.prehandler_only 	= "index,edit,logout";
	this.prehandler_except 	= "";
	this.posthandler_only 	= "";
	this.posthandler_except = "";
	this.aroundHandler_only = "";
	this.aroundHandler_except = "";
	// REST Allowed HTTP Methods Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'}
	this.allowedMethods = {};

	function preHandler( event, rc, prc, action, eventArguments ){
		if (not structKeyExists(session,"user_id")){ 
			relocate(event="Login.index");
		}
		elseif (not Len(session.user_id )){ 
			relocate(event="Login.index");
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
		rc.user_id = session.user_id;
		prc.userInfo = userService.doGetUserByUserId(rc);
		event.setView( "Profile/index" );
	}

	function edit( event, rc, prc ){
		prc.edit = structNew("soft");
		rc.user_id = session.user_id;
		prc.userInfo = userService.doGetUserByUserId(rc);

		if (flash.exists('errorMsg')){
			prc.edit.ResponseDescription = flash.get("errorMsg");
		}
		event.setView( "Profile/edit" );
	}

	function editProfile( event, rc, prc ){
		prc.edit = structNew("soft");
		rc.user_id = session.user_id;
		var errorMsg = "";
		try {
			prc.edit = userService.doEditProfile(rc);
			relocate(event="Profile.index");
		}
		catch(any n){
			errorMsg = n.message & " " & n.detail;
			prc.edit.ResponseDescription = errorMsg
		}
		flash.put(name="errorMsg",value=errorMsg);
		relocate(event="Profile.edit");
	}

	function logout( event, rc, prc ){
		structClear( session );
		sessionInvalidate();
		relocate(event="Login.index");
	}
}

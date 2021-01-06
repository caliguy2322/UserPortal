component extends="coldbox.system.Interceptor"{

	function configure(){}

    function preProcess( event, interceptData, buffer, rc, prc ){
    	var logginIn = false;
    	
    	if (rc.event eq "login.doLogin"){
    		logginIn = true;
    	}

    	if (not structKeyExists(session,"auth") and not logginIn){
    		event.overrideEvent('login/index');
    	}
    }
}
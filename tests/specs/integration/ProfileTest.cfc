/*******************************************************************************
*	Integration Test as BDD (CF10+ or Railo 4.1 Plus)
*
*	Extends the integration class: coldbox.system.testing.BaseTestCase
*
*	so you can test your ColdBox application headlessly. The 'appMapping' points by default to 
*	the '/root' mapping created in the test folder Application.cfc.  Please note that this 
*	Application.cfc must mimic the real one in your root, including ORM settings if needed.
*
*	The 'execute()' method is used to execute a ColdBox event, with the following arguments
*	* event : the name of the event
*	* private : if the event is private or not
*	* prePostExempt : if the event needs to be exempt of pre post interceptors
*	* eventArguments : The struct of args to pass to the event
*	* renderResults : Render back the results of the event
*******************************************************************************/
component extends="coldbox.system.testing.BaseTestCase" appMapping="/"{
	
	/*********************************** LIFE CYCLE Methods ***********************************/

	function beforeAll(){
		loc={};
		loc.mockbox = new testbox.system.MockBox();
		loc.UserServiceObj = loc.mockBox.createMock("models.UserService");
		loc.UserServiceObj.init();
		
		super.beforeAll();
		
		// setup the model
		super.setup();
	}

	function afterAll(){
		// do your own stuff here
		super.afterAll();
	}

	/*********************************** BDD SUITES ***********************************/
	
	function run(){

		describe( "SignUp Suite", function(){

			beforeEach(function( currentSpec ){
				// Setup as a new ColdBox request for this suite, VERY IMPORTANT. ELSE EVERYTHING LOOKS LIKE THE SAME REQUEST.
				setup();
			});

			it( "index", function(){
				var mockDAO = loc.mockBox.createMock("models.UserDAO");
		        returnStruct = {};
		        returnStruct.output = queryNew('user_id');
		        queryAddRow(returnStruct.output);
		        querySetCell(returnStruct.output,'user_id',1);
				mockDAO.$(method="doGetUserByUserId",returns=returnStruct)
		 		loc.UserServiceObj.$property(propertyName="dao",mock=mockDAO);
    
				variables.rc = {};
		 		rc.user_id = 123;
				results = loc.UserServiceObj.doGetUserByUserId(rc);
		        expect( results.output.recordcount ).toBe("true");
			});

            it( "editProfile", function(){
				var mockDAO = loc.mockBox.createMock("models.UserDAO");
                var mockUtil = loc.mockBox.createMock("models.Util");
		        returnStruct = {};
		        returnStruct.success = true;
                mockUtil.$(method="doValidateEmail")
				mockDAO.$(method="update",returns=returnStruct)
		 		loc.UserServiceObj.$property(propertyName="dao",mock=mockDAO);
                loc.UserServiceObj.$property(propertyName="util",mock=mockUtil);

				variables.rc = {};
		 		rc.user_id = 123;
				results = loc.UserServiceObj.doEditProfile(rc);
		        expect( results.success ).toBe("true");
			});

             it( "editPassword", function(){
				var mockDAO = loc.mockBox.createMock("models.UserDAO");
                var mockUtil = loc.mockBox.createMock("models.Util");
		        returnStruct = {};
		        returnStruct.success = true;
                mockUtil.$(method="doValidateMatchingPassword")
                mockUtil.$(method="doHashPassword",returns="myhash")
				mockDAO.$(method="update",returns=returnStruct)
		 		loc.UserServiceObj.$property(propertyName="dao",mock=mockDAO);
                loc.UserServiceObj.$property(propertyName="util",mock=mockUtil);

				variables.rc = {};
		 		rc.password = 123;
                rc.repassword = 123;
                var hashKey = '1234';
				results = loc.UserServiceObj.doEditPassword(rc,hashKey);
		        expect( results.success ).toBe("true");
			});

		
		});

	}

}

Feature: Login Details
Background:
			* url BaseURL
  		* def config = { username: '#(dbUserName)', password:'#(dbUserPassword)', url: '#(dbQuery)',driverClassName: 'com.microsoft.sqlserver.jdbc.SQLServerDriver' }
    	* def DbUtils = Java.type('utils.DbUtils')
    	* def db = new DbUtils(config)
    	
    	* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
    	
Scenario: Reports 
	 
	 
	 Given path '/internalapi/api/licensing/new-license/getDueDates/'+appId
        And header authorization = 'Bearer ' + strToken
        And header Content-Type = 'application/json; charset=utf-8'
   		And header Accept = 'application/json; text/plain;*/*'
  		And request ""
		When method get
		Then status 200
		And print response
		
		And def reslicAction = response[1].action
		And def resAppStatus = response[1].applicationStatus
		And def resAppDueDate = response[1].dueDate
		And print reslicAction
		And print resAppStatus 
		
		And print resAppDueDate 
	     * match reslicAction == licAction
	     * match resAppStatus == appStatus
	     * match resAppDueDate contains dueDate


 

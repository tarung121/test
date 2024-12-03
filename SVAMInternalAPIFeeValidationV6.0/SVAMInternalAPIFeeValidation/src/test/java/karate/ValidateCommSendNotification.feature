Feature: IntakeLicense
Background:
			* url BaseURL
  		* def config = { username: '#(dbUserName)', password:'#(dbUserPassword)', url: '#(dbQuery)',driverClassName: 'com.microsoft.sqlserver.jdbc.SQLServerDriver' }
    	* def DbUtils = Java.type('utils.DbUtils')
    	* def db = new DbUtils(config)
		* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}

 Scenario Outline: Email Communication Page scenario
	
	Given path '/internalapi/api/Communication/GetEmailCommQueue/Application/'+<AppID>
	   	* def dbSts = db.approvalLicenseEmailMapping((<AppID>+''))
		And print dbSts
		* match dbSts == true
	 	And header authorization = 'Bearer ' + strToken
	  	And header Content-Type = 'application/json; charset=utf-8'
	    And header Accept = 'application/json; text/plain;*/*'
	    And header user-agent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36'
	  	And request ""
	    When method get
	    Then status 200
	    And def serverResponse = response
		And print serverResponse[0].status
	  	* match serverResponse[0].status contains 'Sent'
	  	* match serverResponse[0].emailTo != []
	  	* match serverResponse[0].subject != []
	  	* match serverResponse[0].emailBody != []
 	
 Examples:
    
    | read('../../../licenseAPPIds.csv') |
 
Feature: IntakeLicense
Background:
			* url BaseURL
  		* def config = { username: '#(dbUserName)', password:'#(dbUserPassword)', url: '#(dbQuery)',driverClassName: 'com.microsoft.sqlserver.jdbc.SQLServerDriver' }
    	* def DbUtils = Java.type('utils.DbUtils')
    	* def db = new DbUtils(config)
			
#********* SignIn *********************

Scenario: Intake License Submission
   
	# ********* App Intake *********************
  	* call read('LoginDetails.feature') { strToken:'#(strToken)'}
 
 	Given path '/internalapi/api/licensing/selectapptype/savenewpermitapp'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
   		
     
      And request {"businessType":"","permitType":"Temporary Permit","mainLicenseId":null,"tempPermitTypeId":[{"applicationId":null,"tempLicensePermitTypeId":'#(mainLicensePermitTypeId)'}],"mainApplicationId":"","associatedLicenseList":[],"isMainTempPermitRequired":true,"newPermitTypeIds":[],"isNotQualified":false,"notQualifiedReason":""}

	  When method post
	  Then status 200
	 
	 And def ApplicationId = response[0].mainApplicationId
	  And print ApplicationId
	  And def description = response[0].description
	 
	   And def appId = response[0].appId
	  
	   * def formId = response[0].formId
Feature: Email Mapping 
Background: * url BaseURL
  		* def config = { username: '#(dbUserName)', password:'#(dbUserPassword)', url: '#(dbQuery)',driverClassName: 'com.microsoft.sqlserver.jdbc.SQLServerDriver' }
    	* def DbUtils = Java.type('utils.DbUtils')
    	* def db = new DbUtils(config)
    	
    	
    	
Scenario Outline: Email Mapping    

   * callonce read('LoginDetails.feature') { strToken:'#(strToken)'} 
   
    Given path '/internalapi/api/Communication/GetEmailCommQueue/licensePermit/'+appId
  * def appId = <appId>
  * def dbSts = db.getApprovalLicenseEmailMapping((appId+''))
	And print dbSts
	And match dbSts == 'Processed'
	
  Examples:
    | read('/LicenseInputs/licenseAPPIds.csv') |	
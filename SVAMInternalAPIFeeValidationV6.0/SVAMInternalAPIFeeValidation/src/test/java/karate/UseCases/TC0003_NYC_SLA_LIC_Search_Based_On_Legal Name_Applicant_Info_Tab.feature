Feature: Select Licenses Intake form
Background:
			* url BaseURL
  			* def config = { username: '#(dbUserName)', password:'#(dbUserPassword)', url: '#(dbQuery)',driverClassName: 'com.microsoft.sqlserver.jdbc.SQLServerDriver' }
    	 	
    	
Scenario Outline: Select Licenses Intake form
   
	# ********* Login Functionality *********************
  	* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
	  	* def mainLicensePermitTypeId = <LicensePermitTypeId>
	    * def termInYears = <NumberOfTerm>
	    * def termDesc = <NumberOfTerm>+' Year (s)'
	    * def licenseFees = <InitialLicFee>
	    * def fillingFees = <NonRefundableFilingFees>
	    * def renewalFees = <RenewalFilingFees>+''
	    * string productName = <ProductTypes>+''
	     * def emailId = 'automation@svam.com'
	    * def CountyID = 1	
	   
	   ## ******************** UC_LIC_018 : Get County List Scenario Start ***************************##
	   	 #* callonce read('LicensesCommonMethods.feature@GetCountyList') {}
	 ## ******************** UC_LIC_018 : Get County List Scenario End ***************************## 
	 
Examples:
    | read('/CSVFiles/UC_LIC_18_SelectType.csv') |
	  
 	
 
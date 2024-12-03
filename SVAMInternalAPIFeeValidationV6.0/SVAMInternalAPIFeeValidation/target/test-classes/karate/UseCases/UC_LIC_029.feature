Feature: Renewal Submission
Background:
			* url BaseURL
  			* def config = { username: '#(dbUserName)', password:'#(dbUserPassword)', url: '#(dbQuery)',driverClassName: 'com.microsoft.sqlserver.jdbc.SQLServerDriver' }
    	 	
    	
Scenario Outline: Renewal Submission
   
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
	     
	     
	     
    ## ******************** UC_LIC_029: Due Date Extension – New Application Scenario End ***************************##
	    * call read('LicenseFormScenarios.feature@IntakeLicense') {}
	    * call read('LicenseFormScenarios.feature@LicSaveApplicantInfo'){} 
	    * call read('LicenseFormScenarios.feature@LicSavePrinciPpal'){}
	    * call read('LicenseFormScenarios.feature@LicSaveRepresentative'){}
	    * call read('LicenseFormScenarios.feature@LicSave'){}
	    * call read('LicenseFormScenarios.feature@LicFillingFeeWithFundDueDate') {}
	    * call read('LicenseFormScenarios.feature@LicIntakeSubmission'){} 
	        * call read('LicenseFormScenarios.feature@LicSaveCommentApplication') {}
	    * call read('LicenseFormScenarios.feature@LicDueDateExtension'){} 
	    
	    * call read('LicenseFormScenarios.feature@LicValidateDueDate'){} 
	## ******************** UC_LIC_029: Due Date Extension – New Application Scenario End ***************************##
	
     
Examples:
    | read('/LicenseInputs/DueDateLicenses.csv') |
	  
 	
 
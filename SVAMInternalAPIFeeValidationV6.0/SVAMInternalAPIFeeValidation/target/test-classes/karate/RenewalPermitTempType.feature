Feature: Renewal StandAlone Permit Submission
Background:
			* url BaseURL
  			* def config = { username: '#(dbUserName)', password:'#(dbUserPassword)', url: '#(dbQuery)',driverClassName: 'com.microsoft.sqlserver.jdbc.SQLServerDriver' }
    	 	
    	
Scenario Outline: Renewal StandAlone Permit Submission
   
	# ********* Login Functionality *********************
  	* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
	  	* def mainLicensePermitTypeId = <LicensePermitTypeId>
	    * def termInYears = <NumberOfTerm>
	    * def termDesc = <NumberOfTerm>+' Year (s)'
	    * def licenseFees = <InitialLicFee>
	    * def fillingFees = <NonRefundableFilingFees>
	    * def renewalFees = <RenewalFilingFees>+''
	   
	     * def emailId = 'saxena.neeraj@svam.com'
	     
	     
	     
    ## ******************** LicenseApproval Scenario End ***************************##
	    * call read('PermitScenarios.feature@IntakeTempPermit') {}
	    * call read('PermitScenarios.feature@PermitSaveApplicantInfo'){} 
	    * call read('LicenseFormScenarios.feature@LicSave'){}
	    * call read('LicenseFormScenarios.feature@LicFillingFee') {}
	    * call read('LicenseFormScenarios.feature@LicIntakeSubmission'){} 
	    * call read('LicenseFormScenarios.feature@AssignLicense') {} 
	    * call read('PermitScenarios.feature@ReviewTempPermit'){} 
	    * call read('PermitScenarios.feature@SubmitTempPermit') {} 
	    * call read('LicenseFormScenarios.feature@ValidateLicenseIDGeneration'){} 
		#* call read('LicenseFormScenarios.feature@ValidateEmailSentAndCommPage'){} 
	
	## ******************** LicenseApproval Scenario End ***************************##
	
	
	## ******************** Renewal Scenario Start ***************************##
	
		* call read('LicenseFormScenarios.feature@RenewalIntake') {}
	    * call read('LicenseFormScenarios.feature@LicSave') {}
		* call read('LicenseFormScenarios.feature@LicFillingFee') {}
	    * call read('LicenseFormScenarios.feature@LicIntakeSubmission'){} 
	    * call read('LicenseFormScenarios.feature@AssignLicense'){} 
	    * call read('LicenseFormScenarios.feature@RenewalExaminerReviewSendToLB') {} 
	    * call read('LicenseFormScenarios.feature@LicenseClaimingQueue') {} 
	    * call read('LicenseFormScenarios.feature@RenewalLicenseApproval') {}
    
    ## ******************** Renewal Scenario End ***************************##
     

 	
 Examples:
    | read('/LicenseInputs/TempPermit.csv') |
  
	  
 	
 
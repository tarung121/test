Feature: Renewal Submission
Background:
			* url BaseURL
  			* def config = { username: '#(dbUserName)', password:'#(dbUserPassword)', url: '#(dbQuery)',driverClassName: 'com.microsoft.sqlserver.jdbc.SQLServerDriver' }
    	 	
    	
#********* SignIn *********************

Scenario Outline: Renewal Submission
   
	# ********* App Intake *********************
  	* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
  	* def mainLicensePermitTypeId = <LicensePermitTypeId>
    * def termInYears = <NumberOfTerm>
    * def termDesc = <NumberOfTerm>+' Year (s)'
    * def licenseFees = <InitialLicFee>
    * def fillingFees = <NonRefundableFilingFees>
    * def renewalFees = <RenewalFilingFees>+''
    * string productName = <ProductTypes>+''
    * call read('LicenseFormScenarios.feature@IntakeLicense') { mainLicensePermitTypeId:'#(mainLicensePermitTypeId)',strToken:'#(strToken)', appId: '#(appId)', description: '#(description)', ApplicationId: '#(applicationId)',formVersionId: '#(FormVersionId)',formId: '#(formId)'}
    * call read('LicenseFormScenarios.feature@LicSaveApplicantInfo') {strToken:'#(strToken)', appId: '#(appId)' } 
    * call read('LicenseFormScenarios.feature@LicSavePrinciPpal') { strToken:'#(strToken)',appId: '#(appId)',personResponse:'#(personResponse)' }
    * call read('LicenseFormScenarios.feature@LicSaveRepresentative') { strToken:'#(strToken)', appId: '#(appId)' }
    * call read('LicenseFormScenarios.feature@LicSave') {strToken:'#(strToken)', appId: '#(appId)',description: '#(description)',formId: '#(formId)' }
    * call read('LicenseFormScenarios.feature@LicFillingFee') {strToken:'#(strToken)', appId: '#(appId)',description: '#(description)',formId: '#(formId)', licenseFees:'#(licenseFees)', fillingFees:'#(fillingFees)',termInYears:'#(termInYears)',termDesc:'#(termDesc)'}
    * call read('LicenseFormScenarios.feature@LicIntakeSubmission') {strToken:'#(strToken)', appId: '#(appId)' } 
    * call read('LicenseFormScenarios.feature@AssignLicense') {strToken:'#(strToken)', appId: '#(appId)' } 
    * call read('LicenseFormScenarios.feature@ReviewLBLicense') {strToken:'#(strToken)', appId: '#(appId)' } 
    * call read('LicenseFormScenarios.feature@LicenseClaimingQueue') {strToken:'#(strToken)', appId: '#(appId)' } 
    * call read('LicenseFormScenarios.feature@LicenseApproval') {strToken:'#(strToken)', appId: '#(appId)' } 
    * call read('LicenseFormScenarios.feature@ValidateLicenseIDGeneration') {strToken:'#(strToken)', appId: '#(appId)',licenseId:'#(licenseId)' } 
	#* call read('LicenseFormScenarios.feature@ValidateEmailSentAndCommPage') {strToken:'#(strToken)', appId: '#(appId)' } 
	
	
	* call read('LicenseFormScenarios.feature@RenewalIntake') { strToken:'#(strToken)',licenseId:'#(licenseId)', appId: '#(appId)', description: '#(description)', ApplicationId: '#(applicationId)',formVersionId: '#(FormVersionId)',formId: '#(formId)'}
    * call read('LicenseFormScenarios.feature@SaveAssociatedPrincipal') {strToken:'#(strToken)', appId: '#(appId)',personResponse:'#(personResponse)'  }
    * call read('LicenseFormScenarios.feature@LicSave') {strToken:'#(strToken)', appId: '#(appId)',description: '#(description)',formId: '#(formId)' }
	* call read('LicenseFormScenarios.feature@LicFillingFee') {strToken:'#(strToken)', appId: '#(appId)',description: '#(description)',formId: '#(formId)', licenseFees:'#(licenseFees)', fillingFees:'#(fillingFees)',termInYears:'#(termInYears)',termDesc:'#(termDesc)'}
    * call read('LicenseFormScenarios.feature@LicIntakeSubmission') {strToken:'#(strToken)', appId: '#(appId)' } 
    * call read('LicenseFormScenarios.feature@AssignLicense') {strToken:'#(strToken)', appId: '#(appId)' } 
    * call read('LicenseFormScenarios.feature@RenewalExaminerReviewSendToLB') {strToken:'#(strToken)', appId: '#(appId)',ApplicationId: '#(applicationId)' } 
    * call read('LicenseFormScenarios.feature@LicenseClaimingQueue') {strToken:'#(strToken)', appId: '#(appId)' } 
    * call read('LicenseFormScenarios.feature@RenewalLicenseApproval') {strToken:'#(strToken)', appId: '#(appId)' }
    
     
Examples:
    | read('/LicenseInputs/Renewal_Manf_Wholesale.csv') |
	  
 	
 
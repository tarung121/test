Feature: Intake Fee Amendment Type
Background:
			* url BaseURL
			* call read('LoginDetails.feature') { strToken:'#(strToken)'}
  			* def config = { username: '#(dbUserName)', password:'#(dbUserPassword)', url: '#(dbQuery)',driverClassName: 'com.microsoft.sqlserver.jdbc.SQLServerDriver' }
    	 	* def getcorporateStructureCodeFunc =
			"""
				function(value){
					if (value === 'Individual'){
					return 1;
					}
					else {
					return 2;
					}
			    }
			"""
		* def getStatusIndOrgStatus =
			"""
				function(value){
					if (value === 'Individual'){
					return true;
					}
					else {
					return false;
					}
			    }
			"""
		* def getAmendmentTypeIdFunc =
			"""
				function(amendmentType){
					if (amendmentType == 'ABC Officer'){
					return 1;
					}
					else if (amendmentType == 'Additional Bar'){
					return 2;
					}
					else if (amendmentType == 'Alteration'){
					return 3;
					}
					else if (amendmentType == 'Alteration with Additional Bar'){
					return 3;
					}
					
					
			    }
			"""
		 * def waitFunc =
		        """
		      function(timeinMiliSeconds) {
		        // load java type into js engine
		        var Thread = Java.type('java.lang.Thread');
		        Thread.sleep(timeinMiliSeconds); 
		      }
		      """
   
   	 		 		 
		 		 		 		 
@TC0001_NYC_SLA_AMD_Intake_Fees_Bond
Scenario: TC0007_NYC_SLA_AMD_Intake_Preview_Submit
 
  		## ******************** UC_IntakeAmendment: Validate TC0007_NYC_SLA_AMD_Intake_Preview_Submit Scenario Start ***************************##
	   	* def SearchByLegalName = true
	   	* def SearchByLicId = false
	   	* def amendmentType = 'ABC Officer'
	   	* def appType = 'AO-'
	   	* def termInYears = 3
	   	* def termDesc = termInYears +' Year (s)'
	   	* def typeOfNotification = 'Letter_Fingerprinting_Instructions'
	   	* def fileName = 'Letter_Fingerprinting_Instructions.pdf'
	   	* def amendmentCode = getAmendmentTypeIdFunc(amendmentType)
	    * call read('AmendmentsCommonMethods.feature@SearchLicPermitIdForAmendment') {LicensePermitId:'#(LicensePermitId)'}
	    * call read('AmendmentsCommonMethods.feature@IntakeAmendment') {}
	    * call read('LicensesCommonMethods.feature@GetPreFillLicenseAllDetailsByLicenseId') {} 
	    * call read('AmendmentsCommonMethods.feature@FillAndSaveApplicantInformationPageAmendment') {}
	  	   
	   * call read('AmendmentsCommonMethods.feature@saveABCOfficerForm') {}
	   
	   * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
	  
	   * call read('AmendmentsCommonMethods.feature@AmendmentFeeValidationSingleCheck') {amount:128}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * def waiting = waitFunc(65000)
	    * call read('LicensesCommonMethods.feature@EMailNotificationDataValidation') {}
	   
	    ## ******************** UC_IntakeAmendment: Validate TC0007_NYC_SLA_AMD_Intake_Preview_Submit Scenario End ***************************##   
		 		 		 		 
@TC0002_NYC_SLA_AMD_Single_Check_More_Than_One_License_Amendment
Scenario: TC0002_NYC_SLA_AMD_Single_Check_More_Than_One_License_Amendment
 
  		## ******************** UC_IntakeAmendment: Validate TC0009_NYC_SLA_AMD_Highly_Deficient Scenario Start ***************************##
	   	* def SearchByLegalName = true
	   	* def SearchByLicId = false
	   	* def amendmentType = 'ABC Officer'
	   	* def appType = 'AO-'
	   	* def termInYears = 3
	   	* def termDesc = termInYears +' Year (s)'
	   	* def typeOfNotification = 'Letter_Fingerprinting_Instructions'
	   	* def fileName = 'Letter_Fingerprinting_Instructions.pdf'
	   	* def amendmentCode = getAmendmentTypeIdFunc(amendmentType)
	    * call read('AmendmentsCommonMethods.feature@SearchLicPermitIdForAmendment') {LicensePermitId:'#(LicensePermitId)'}	   
	   * call read('AmendmentsCommonMethods.feature@IntakeAmendment') {}
	    * call read('LicensesCommonMethods.feature@GetPreFillLicenseAllDetailsByLicenseId') {} 
	    * call read('AmendmentsCommonMethods.feature@FillAndSaveApplicantInformationPageAmendment') {}
	  	   
	   * call read('AmendmentsCommonMethods.feature@saveABCOfficerForm') {}
	   
	   * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
	   * call read('AmendmentsCommonMethods.feature@AmendmentFeeValidationSingleCheck') {amount:128}
	   * call read('LicensesCommonMethods.feature@SaveReasonHiglyDeficient') {}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@getAndValidateReasonHiglyDeficient') {}
	   
	    ## ******************** UC_IntakeAmendment: Validate TC0009_NYC_SLA_AMD_Highly_Deficient Scenario End ***************************##   
		 	 			 	 		 	 		
@TC0005_NYC_SLA_AMD_Under_Payment
Scenario: TC0005_NYC_SLA_AMD_Under_Payment
 
  		## ******************** UC_IntakeAmendment: Validate TC0009_NYC_SLA_AMD_Highly_Deficient Scenario Start ***************************##
	   	* def SearchByLegalName = true
	   	* def SearchByLicId = false
	   	* def amendmentType = 'ABC Officer'
	   	* def appType = 'AO-'
	   	* def termInYears = 3
	   	* def termDesc = termInYears +' Year (s)'
	   	* def typeOfNotification = 'Letter_Fingerprinting_Instructions'
	   	* def fileName = 'Letter_Fingerprinting_Instructions.pdf'
	   	* def amendmentCode = getAmendmentTypeIdFunc(amendmentType)
	    * call read('AmendmentsCommonMethods.feature@SearchLicPermitIdForAmendment') {LicensePermitId:'#(LicensePermitId)'}
	   * call read('AmendmentsCommonMethods.feature@IntakeAmendment') {}
	    * call read('LicensesCommonMethods.feature@GetPreFillLicenseAllDetailsByLicenseId') {} 
	    * call read('AmendmentsCommonMethods.feature@FillAndSaveApplicantInformationPageAmendment') {}
	  	   
	   * call read('AmendmentsCommonMethods.feature@saveABCOfficerForm') {}
	   * def amount = '#(amount)'
	   * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
	   * call read('AmendmentsCommonMethods.feature@AmendmentUnderPayment') {amount:100}
	   * call read('LicensesCommonMethods.feature@SaveReasonHiglyDeficient') {}
	   * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Additional Funds'}
	   * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
	   * call read('LicensesCommonMethods.feature@getAndValidateReasonHiglyDeficient') {}
	   
	    ## ******************** UC_IntakeAmendment: Validate TC0009_NYC_SLA_AMD_Highly_Deficient Scenario End ***************************##   		 	 		
		 	 		 		 		 
@TC0006_NYC_SLA_AMD_Over_Payment
Scenario: TC0006_NYC_SLA_AMD_Over_Payment
 
  		## ******************** UC_IntakeAmendment: Validate TC0009_NYC_SLA_AMD_Highly_Deficient Scenario Start ***************************##
	   	* def SearchByLegalName = true
	   	* def SearchByLicId = false
	   	* def amendmentType = 'ABC Officer'
	   	* def appType = 'AO-'
	   	* def termInYears = 3
	   	* def termDesc = termInYears +' Year (s)'
	   	* def typeOfNotification = 'Letter_Fingerprinting_Instructions'
	   	* def fileName = 'Letter_Fingerprinting_Instructions.pdf'
	   	* def amendmentCode = getAmendmentTypeIdFunc(amendmentType)
	    * call read('AmendmentsCommonMethods.feature@SearchLicPermitIdForAmendment') {LicensePermitId:'#(LicensePermitId)'}	   
	   * call read('AmendmentsCommonMethods.feature@IntakeAmendment') {}
	    * call read('LicensesCommonMethods.feature@GetPreFillLicenseAllDetailsByLicenseId') {} 
	    * call read('AmendmentsCommonMethods.feature@FillAndSaveApplicantInformationPageAmendment') {}
	  	   
	   * call read('AmendmentsCommonMethods.feature@saveABCOfficerForm') {}
	   
	   * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
	   * call read('AmendmentsCommonMethods.feature@AmendmentOverPayment') {amount:40000}
	   * call read('LicensesCommonMethods.feature@SaveReasonHiglyDeficient') {}
	   * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	   * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	   * call read('LicensesCommonMethods.feature@getAndValidateReasonHiglyDeficient') {}
	   
	    ## ******************** UC_IntakeAmendment: Validate TC0009_NYC_SLA_AMD_Highly_Deficient Scenario End ***************************##   	
	    
@TC0007_NYC_SLA_AMD_Waived_Fee
Scenario: TC0007_NYC_SLA_AMD_Waived_Fee
 
  		## ******************** UC_IntakeAmendment: Validate TC0009_NYC_SLA_AMD_Highly_Deficient Scenario Start ***************************##
	   	* def SearchByLegalName = true
	   	* def SearchByLicId = false
	   	* def amendmentType = 'Endorsement'
	   	* def appType = 'EN-'
	   	* def termInYears = 3
	   	* def termDesc = termInYears +' Year (s)'
	   	* def typeOfNotification = 'Letter_Fingerprinting_Instructions'
	   	* def fileName = 'Letter_Fingerprinting_Instructions.pdf'
	   	* def amendmentCode = getAmendmentTypeIdFunc(amendmentType)
	    * call read('AmendmentsCommonMethods.feature@SearchLicPermitIdForAmendment') {LicensePermitId:'#(LicensePermitId)'}
	   * call read('AmendmentsCommonMethods.feature@IntakeAmendment') {}
	    * call read('LicensesCommonMethods.feature@GetPreFillLicenseAllDetailsByLicenseId') {} 
	    * call read('AmendmentsCommonMethods.feature@FillAndSaveApplicantInformationPageAmendment') {}
	  	   
	   * call read('AmendmentsCommonMethods.feature@EndorsementNoTab') {}
	   
	   * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
	   * call read('AmendmentsCommonMethods.feature@AmendmentWaveFeesValidation') {amount:128}
	   * call read('LicensesCommonMethods.feature@SaveReasonHiglyDeficient') {}
	   * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	   * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	   * call read('LicensesCommonMethods.feature@getAndValidateReasonHiglyDeficient') {}
	   
	    ## ******************** UC_IntakeAmendment: Validate TC0009_NYC_SLA_AMD_Highly_Deficient Scenario End ***************************##   		 	 				 		 		 		 	    	 	 				 		 		 		 
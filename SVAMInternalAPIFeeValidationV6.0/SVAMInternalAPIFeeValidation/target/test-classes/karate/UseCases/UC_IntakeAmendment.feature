Feature: Intake Amendment Type
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
   
   	 		 		 
		 		 		 		 
@TC0007_NYC_SLA_AMD_Intake_Preview_Submit
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
	   * call read('AmendmentsCommonMethods.feature@saveABCOfficerForm') {}
	   
	   * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
	  
	   * call read('AmendmentsCommonMethods.feature@AmendmentFeeValidation') {amount:128}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * def waiting = waitFunc(65000)
	    * call read('LicensesCommonMethods.feature@EMailNotificationDataValidation') {}
	   
	    ## ******************** UC_IntakeAmendment: Validate TC0007_NYC_SLA_AMD_Intake_Preview_Submit Scenario End ***************************##   
		 		 		 		 
@TC0009_NYC_SLA_AMD_Highly_Deficient
Scenario: TC0009_NYC_SLA_AMD_Highly_Deficient
 
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
	   * call read('AmendmentsCommonMethods.feature@saveABCOfficerForm') {}
	   
	   * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
	   * call read('AmendmentsCommonMethods.feature@AmendmentFeeValidation') {amount:128}
	   * call read('LicensesCommonMethods.feature@SaveReasonHiglyDeficient') {}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@getAndValidateReasonHiglyDeficient') {}
	   
	    ## ******************** UC_IntakeAmendment: Validate TC0009_NYC_SLA_AMD_Highly_Deficient Scenario End ***************************##   
		 	 		 	 		
		 	 		
		 	 		 		 		 
		 		 		 		 
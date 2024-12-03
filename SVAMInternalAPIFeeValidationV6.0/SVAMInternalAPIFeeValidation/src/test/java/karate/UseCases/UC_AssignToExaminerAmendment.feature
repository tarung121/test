Feature: Permit Application Type
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
   
   	 		 		 
		 		 		 		 
@TC0001_NYC_SLA_LIC_AMD_Examiner_Supervisor_Assign_ApplicationToExaminer
Scenario: TC0001_NYC_SLA_LIC_AMD_Examiner_Supervisor_Assign_ApplicationToExaminer
 
  		## ******************** UC_IntakeAmendment: Validate TC0001_NYC_SLA_LIC_AMD_Examiner_Supervisor_Assign_Application to Examiner Scenario Start ***************************##
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
	   * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {}
	    ## ******************** UC_IntakeAmendment: Validate TC0001_NYC_SLA_LIC_AMD_Examiner_Supervisor_Assign_ Application to Examiner Scenario End ***************************##   
		 
@TC0002_NYC_SLA_LIC_AMD_Assign_Multiple_Applications_to_Examiner
Scenario: TC0002_NYC_SLA_LIC_AMD_Assign_Multiple_Applications_to_Examiner
 
  		## ******************** UC_IntakeAmendment: Validate TC0002_NYC_SLA_LIC_AMD_Assign_Multiple_Applications_to_Examiner Scenario Start ***************************##
	   	* def SearchByLegalName = true
	   	* def SearchByLicId = false
	   	* def amendmentType = 'ABC Officer'
	   	* def appType = 'AO-'
	   	* def termInYears = 3
	   	* def termDesc = termInYears +' Year (s)'
	   	* def typeOfNotification = 'Letter_Fingerprinting_Instructions'
	   	* def fileName = 'Letter_Fingerprinting_Instructions.pdf'
	   	* def amendmentCode = getAmendmentTypeIdFunc(amendmentType)
	    * call read('AmendmentsCommonMethods.feature@SearchLicPermitIdForAmendment') {}
	   * call read('AmendmentsCommonMethods.feature@IntakeAmendment') {}
	   * call read('AmendmentsCommonMethods.feature@saveABCOfficerForm') {}
	   
	   * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
	  
	   * call read('AmendmentsCommonMethods.feature@AmendmentFeeValidation') {amount:128}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	   * def appId1 = appId
	  * def amendmentType = 'ABC Officer'
	   * call read('AmendmentsCommonMethods.feature@SearchLicPermitIdForAmendment') {}
	   * call read('AmendmentsCommonMethods.feature@IntakeAmendment') {}
	   * call read('AmendmentsCommonMethods.feature@saveABCOfficerForm') {}
	   
	   * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
	  
	   * call read('AmendmentsCommonMethods.feature@AmendmentFeeValidation') {amount:128}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	   
	   * call read('LicensesCommonMethods.feature@AssignMultipleApplicationsToExaminer') {}
	   * def appId = appId1
	   * call read('LicensesCommonMethods.feature@checkApplicationStatus') {}
	    ## ******************** UC_IntakeAmendment: Validate TC0002_NYC_SLA_LIC_AMD_Assign_Multiple_Applications_to_Examiner Scenario End ***************************##   
		 
			
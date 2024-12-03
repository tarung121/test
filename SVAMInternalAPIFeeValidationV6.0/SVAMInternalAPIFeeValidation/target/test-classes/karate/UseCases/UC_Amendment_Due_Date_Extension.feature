Feature: Due Date Extension
Background:
			* url BaseURL
			* def amendmentTypeId = 1
  			* def config = { username: '#(dbUserName)', password:'#(dbUserPassword)', url: '#(dbQuery)',driverClassName: 'com.microsoft.sqlserver.jdbc.SQLServerDriver' }
    	 	* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
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
		* def getIndORgCodeFunc =
			"""
				function(value1, value2){
					if (value1 == 1 && value2 == 'Individual'){
					return 1;
					}
					else if (value1 == 1 && value2 == 'Sole Propretior'){
					return 2;
					}
					else if (value1 == 2 && value2 == 'Individual'){
					return 1;
					}
					else if (value1 == 2 && value2 == 'Limited Liability Company'){
					return 2;
					}else if (value1 == 2 && value2 == 'Corporation'){
					return 3;
					}else if (value1 == 2 && value2 == 'Limited Liability Partnership'){
					return 4;
					}else if (value1 == 2 && value2 == 'Limited Partnership'){
					return 5;
					}else if (value1 == 2 && value2 == 'Partnership'){
					return 6;
					}else if (value1 == 2 && value2 == 'Government'){
					return 7;
					}else if (value1 == 2 && value2 == 'Sole Propretior'){
					return 8;
					}else if (value1 == 2 && value2 == 'Trust'){
					return 9;
					}else if (value1 == 2 && value2 == 'Estate'){
					return 10;
					}
					
					else {
					return 1;
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
		      
		        * def fundDueDateFunc1 =
		  """
			  function(days) {
			    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
			    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
			    
			    var date = new java.util.Date();
			    var dayAfter = new java.util.Date(date.getTime() + java.util.concurrent.TimeUnit.DAYS.toMillis( days));
			    return sdf.format(dayAfter);
			  } 
		  """

@TC0001_NYC_SLA_LIC_AMD_Due_Date_Extension_Approved_For_Respond_Deficiencies	  
Scenario Outline: TC0001_NYC_SLA_LIC_AMD_Due_Date_Extension_Approved_For_Respond_Deficiencies
   
	# ********* Login Functionality *********************
  		
  		

	    * def convictedOfCrime = <convictedOfCrime>
	    * def percentageOfOwners = <percentageOfOwners>
	    * def isFingerprintRequired = <isFingerprintRequired>
	    * def isFingerprintsApproved = <isFingerprintsApproved>
	    * def isSignature = <isSignature>
	    
	    * def convictedOfCrime = <convictedOfCrime>
	    
	  	* def mainLicensePermitTypeId = <LicensePermitTypeId>
	    * def termInYears = <NumberOfTerm>
	    * def termDesc = <NumberOfTerm>+' Year (s)'
	    * def licenseFees = <InitialLicFee>
	    * def fillingFees = <NonRefundableFilingFees>
	    * def licAncillaryFees = <AncillaryFees>
	    * def renewalFees = <RenewalFilingFees>+''
	    * string productName = <ProductTypes>+''
	     
	    #* def CountyID = <countyIds>
	   # * def CountyName = <County>	
		* def totalFees = licenseFees+fillingFees
	     # * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_LIC_ExamnerReviewToLB: Validate TC0001_NYC_SLA_LIC_AMD_Examiner_Sends_Application_For_LB_Review Scenario Start ***************************##
	   
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
        * call read('LicensesCommonMethods.feature@GetPreFillLicenseAllDetailsByLicenseId') {} 
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}

	    * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPageAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@saveABCOfficerForm') {}
	    * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
	   
	    * call read('AmendmentsCommonMethods.feature@AmendmentFeeValidation') {amount:128}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	   
	    * call read('AmendmentsCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		* call read('AmendmentsCommonMethods.feature@getAmendmentABCOfficerDetails') {}
		
		* call read('LicensesCommonMethods.feature@ReviewDigestValidate') {}
		* def reviewType = 'Define Deficiencies'
		* def value = '#(value)'
		* def deficienciesCount = '#(deficienciesCount)'
	    * call read('AmendmentsCommonMethods.feature@AddDeficiency') {}

		* call read('AmendmentsCommonMethods.feature@AmendmentExaminerReviewApprovalToLB2') {expStatus:'Additional Info Required',value:1,deficienciesCount:2}
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}	   
		* call read('AmendmentsCommonMethods.feature@getDocumentCount') {}
	    * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
	  	* call read('AmendmentsCommonMethods.feature@getDueDateExtension'){}
	  	
	  	* def extendedDueDate = fundDueDateFunc1(10)
	  	And print extendedDueDate
	  	
	  	* def approvedStatus = true
	  	
	  	* call read('AmendmentsCommonMethods.feature@ApproveDisapproveDueDateExtension'){}
	  	* call read('AmendmentsCommonMethods.feature@ValidateCommunicationPageAndEMailForOnPromises'){}

	    
	     ## ******************** UC_LIC_ExamnerReviewToLB: Validate TC0001_NYC_SLA_LIC_AMD_Examiner_Sends_Application_For_LB_Review Scenario End ***************************##   

Examples:
    | read('/CSVFiles/Uc_22_TC0005_NYC_SLA_LIC_Under_Payment.csv') | 	 
    
@TC0002_NYC_SLA_LIC_AMD_Due_Date_Extension_Approved_For_Failed_Payment	  
Scenario Outline: TC0002_NYC_SLA_LIC_AMD_Due_Date_Extension_Approved_For_Failed_Payment
   
	# ********* Login Functionality *********************
  
		* call read('LicensesCommonMethods.feature') {}	   

		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}	   
		* call read('AmendmentsCommonMethods.feature@getDocumentCount') {}
	    * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
	  	* call read('AmendmentsCommonMethods.feature@getDueDateExtension'){}
	  	
	  	* def extendedDueDate = fundDueDateFunc1(10)
	  	And print extendedDueDate
	  	
	  	* def approvedStatus = true
	  	
	  	* call read('AmendmentsCommonMethods.feature@ApproveDisapproveDueDateExtension'){}
	  	* call read('AmendmentsCommonMethods.feature@ValidateCommunicationPageAndEMailForOnPromises'){}

	    
	     ## ******************** UC_LIC_ExamnerReviewToLB: Validate TC0001_NYC_SLA_LIC_AMD_Examiner_Sends_Application_For_LB_Review Scenario End ***************************##   

Examples:
    | read('/CSVFiles/Uc_22_TC0005_NYC_SLA_LIC_Under_Payment.csv') | 	
    
@TC0003_NYC_SLA_LIC_AMD_Due_Date_Extension_Approved_For_Conditions	  
Scenario Outline: TC0003_NYC_SLA_LIC_AMD_Due_Date_Extension_Approved_For_Conditions
   
	# ********* Login Functionality *********************
  		
  		

	    * def convictedOfCrime = <convictedOfCrime>
	    * def percentageOfOwners = <percentageOfOwners>
	    * def isFingerprintRequired = <isFingerprintRequired>
	    * def isFingerprintsApproved = <isFingerprintsApproved>
	    * def isSignature = <isSignature>
	    
	    * def convictedOfCrime = <convictedOfCrime>
	    
	  	* def mainLicensePermitTypeId = <LicensePermitTypeId>
	    * def termInYears = <NumberOfTerm>
	    * def termDesc = <NumberOfTerm>+' Year (s)'
	    * def licenseFees = <InitialLicFee>
	    * def fillingFees = <NonRefundableFilingFees>
	    * def licAncillaryFees = <AncillaryFees>
	    * def renewalFees = <RenewalFilingFees>+''
	    * string productName = <ProductTypes>+''
	     
	    #* def CountyID = <countyIds>
	   # * def CountyName = <County>	
		* def totalFees = licenseFees+fillingFees
	     # * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_LIC_ExamnerReviewToLB: Validate TC0001_NYC_SLA_LIC_AMD_Examiner_Sends_Application_For_LB_Review Scenario Start ***************************##
	   
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
        * call read('LicensesCommonMethods.feature@GetPreFillLicenseAllDetailsByLicenseId') {} 
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}

	    * call read('AmendmentsCommonMethods.feature@FillAndSaveApplicantInformationPageAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@saveABCOfficerForm') {}
	    * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
	   
	    * call read('AmendmentsCommonMethods.feature@AmendmentFeeValidation') {amount:128}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	   
	    * call read('AmendmentsCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		* call read('AmendmentsCommonMethods.feature@getAmendmentABCOfficerDetails') {}
		
		* call read('LicensesCommonMethods.feature@ReviewDigestValidate') {}
		* def reviewType = 'Send to Licensing Board'
	    * call read('AmendmentsCommonMethods.feature@AmendmentExaminerReviewApprovalToLB2') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
	    * call read('LicensesCommonMethods.feature@AddLicenseClaimingQueue') {}
		* def DefineStipulationStatus = true
		* def licStatus = 'Conditionally Approved'
	#    * call read('AmendmentsCommonMethods.feature@GetLBDecision') {}
	#	* call read('AmendmentsCommonMethods.feature@ApproveLBWithStipulationsAmendments') {StipulationsCount: > 1}
	#	* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Conditionally Approved'}
	#	* call read('LicensesCommonMethods.feature@SelectUploadTextConditionsFromConditonallyApprovedLic') {isConditionMet:true}
	#	* call read('LicensesCommonMethods.feature@SelectUploadTextConditionsFromConditonallyApprovedLic') {isConditionMet:false}
		#* call read('LicensesCommonMethods.feature@SelectUploadTextConditionsFromConditonallyApprovedLic') {isConditionMet:null}
     #   * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Active'}		
	  #  * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
	  #	* call read('AmendmentsCommonMethods.feature@getDueDateExtension'){}
	  	
	#  	* def extendedDueDate = fundDueDateFunc1(10)
	#  	And print extendedDueDate
	  	
	 # 	* def approvedStatus = true
	  	
	  #	* call read('AmendmentsCommonMethods.feature@ApproveDisapproveDueDateExtension'){}
	#	* call read('AmendmentsCommonMethods.feature@ValidateCommunicationPageAndEMailForOnPromises'){}

	    
	     ## ******************** UC_LIC_ExamnerReviewToLB: Validate TC0001_NYC_SLA_LIC_AMD_Examiner_Sends_Application_For_LB_Review Scenario End ***************************##   

Examples:
    | read('/CSVFiles/Uc_22_TC0005_NYC_SLA_LIC_Under_Payment.csv') | 	            
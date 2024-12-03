Feature: Examiner review
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

 @TC0001_NYC_SLA_LIC_AMD_Examiner_Sends_Application_For_LB_Review	  
 Scenario Outline: TC0001_NYC_SLA_LIC_AMD_Examiner_Sends_Application_For_LB_Review
   
	# ********* Login Functionality *********************
  		
  		
		* def IndOrgSelectionDropDown = <IndOrgSelection>
  		* def indOrgCode = getIndORgCodeFunc(IndOrgSelectionDropDown)
  			And print indOrgCode
  		* def isIndStatus = getStatusIndOrgStatus(IndOrgSelectionDropDown)
	    * def CorporateStructureDropDown = <CorporateStructure>
	    * def CorporateStructureDropDownCode = getIndORgCodeFunc(indOrgCode,CorporateStructureDropDown)
	   		And print CorporateStructureDropDownCode
	    * def firstName = <FirstName>
	    * def lastName = <LastName>
	    * def legalName = firstName+ ' '+lastName
	    * def Address1 = <Address1>
	    * def Address2 = <Address2>
	    * def CityName = <City>
	    * def zipCode = <ZipCode>
	    * def postalCode = <PostalCode>
	    * def countryName = <Country>
	    * def emailId = <Email>
	    * def convictedOfCrime = <convictedOfCrime>
	    * def percentageOfOwners = <percentageOfOwners>
	    * def isFingerprintRequired = <isFingerprintRequired>
	    * def isFingerprintsApproved = <isFingerprintsApproved>
	    * def isSignature = <isSignature>
	    
	    * def convictedOfCrime = <convictedOfCrime>
		* def PhoneNumber = <PhoneNumber>
		* def PhoneExtn = <PhoneExtn>
		* def countryCode = <countryCode>
		* def stateCode = <StateCode>
	    
	  	* def mainLicensePermitTypeId = <LicensePermitTypeId>
	    * def termInYears = <NumberOfTerm>
	    * def termDesc = <NumberOfTerm>+' Year (s)'
	    * def licenseFees = <InitialLicFee>
	    * def fillingFees = <NonRefundableFilingFees>
	    * def licAncillaryFees = <AncillaryFees>
	    * def renewalFees = <RenewalFilingFees>+''
	    * string productName = <ProductTypes>+''
	     
	    * def CountyID = <countyIds>
	    * def CountyName = <County>	
		* def totalFees = licenseFees+fillingFees
	      * def splittedCityName = CityName.replaceAll(" ","")
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
	   * call read('AmendmentsCommonMethods.feature@saveABCOfficerForm') {}
	   
	   * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
	  
	   * call read('AmendmentsCommonMethods.feature@AmendmentFeeValidation') {amount:128}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	   
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		* call read('AmendmentsCommonMethods.feature@getAmendmentABCOfficerDetails') {}
		
		* call read('AmendmentsCommonMethods.feature@ReviewDigestValidate') {}
		* def reviewType = 'Send to Licensing Board'
		
		* call read('AmendmentsCommonMethods.feature@AmendmentExaminerReviewApprovalToLB') {expStatus:'Awaiting Review'}
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}	   
	    
	     ## ******************** UC_LIC_ExamnerReviewToLB: Validate TC0001_NYC_SLA_LIC_AMD_Examiner_Sends_Application_For_LB_Review Scenario End ***************************##   
	
	
     
Examples:
    | read('/CSVFiles/Uc_22_TC0005_NYC_SLA_LIC_Under_Payment.csv') |
    
 
 @TC0001b_NYC_SLA_LIC_AMD_Examiner_MethodOfOperation_DigestTab	  
 Scenario Outline: TC0001b_NYC_SLA_LIC_AMD_Examiner_MethodOfOperation_DigestTab
   
	# ********* Login Functionality *********************
			
  		
		* def IndOrgSelectionDropDown = <IndOrgSelection>
  		* def indOrgCode = getIndORgCodeFunc(IndOrgSelectionDropDown)
  			And print indOrgCode
  		* def isIndStatus = getStatusIndOrgStatus(IndOrgSelectionDropDown)
	    * def CorporateStructureDropDown = <CorporateStructure>
	    * def CorporateStructureDropDownCode = getIndORgCodeFunc(indOrgCode,CorporateStructureDropDown)
	   		And print CorporateStructureDropDownCode
	    * def firstName = <FirstName>
	    * def lastName = <LastName>
	    * def legalName = firstName+ ' '+lastName
	    * def Address1 = <Address1>
	    * def Address2 = <Address2>
	    * def CityName = <City>
	    * def zipCode = <ZipCode>
	    * def postalCode = <PostalCode>
	    * def countryName = <Country>
	    * def emailId = <Email>
	    * def convictedOfCrime = <convictedOfCrime>
	    * def percentageOfOwners = <percentageOfOwners>
	    * def isFingerprintRequired = <isFingerprintRequired>
	    * def isFingerprintsApproved = <isFingerprintsApproved>
	    * def isSignature = <isSignature>
	    
	    * def convictedOfCrime = <convictedOfCrime>
		* def PhoneNumber = <PhoneNumber>
		* def PhoneExtn = <PhoneExtn>
		* def countryCode = <countryCode>
		* def stateCode = <StateCode>
	    
	  	* def mainLicensePermitTypeId = <LicensePermitTypeId>
	    * def termInYears = <NumberOfTerm>
	    * def termDesc = <NumberOfTerm>+' Year (s)'
	    * def licenseFees = <InitialLicFee>
	    * def fillingFees = <NonRefundableFilingFees>
	    * def licAncillaryFees = <AncillaryFees>
	    * def renewalFees = <RenewalFilingFees>+''
	    * string productName = <ProductTypes>+''
	     
	    * def CountyId = <countyIds>
	    * def CountyName = <County>	
		* def totalFees = licenseFees+fillingFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_LIC_ExamnerReviewToLB: Validate TC0001b_NYC_SLA_LIC_AMD_Examiner_MethodOfOperation_DigestTab Scenario Start ***************************##
	   
	   
	     * call read('LicensesCommonMethods.feature@IntakeLicensewithoutAssociatedLic') {}
        * def CountyName = "New York"
        * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {county:'#(CountyName)'}
        * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
        * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
        * call read('LicensesCommonMethods.feature@FillAndSaveMethodOfOperationPage') {}
        * call read('LicensesCommonMethods.feature@FeesValidation') {amount:'#(totalFees)'}
        * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
        * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {}
        * call read('LicensesCommonMethods.feature@ExaminerReviewApprovalToLB') {}
        * call read('LicensesCommonMethods.feature@LBClaimingQueue') {}
        * call read('LicensesCommonMethods.feature@LBApproval') {approvalName:'Approved', expStatus:'Approved'}
        * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Approved'}
	   	  
	   
	  * def SearchByLegalName = false
	   	* def SearchByLicId = true
	    * def amendmentType = 'Method of Operation'
	   	* def appType = 'MO-'
	   
	   	* def termInYears = 3
	   	* def termDesc = termInYears +' Year (s)'
	   * call read('LicensesCommonMethods.feature@GetLicenseId') {} 
	   	 And print licenseId
	   	   	* def termInYears = 3
	   	* def termDesc = termInYears +' Year (s)'
	   	* def amendmentCode = getAmendmentTypeIdFunc(amendmentType)
	   	* def LicensePermitId = '#(LicensePermitId)'
        * call read('LicensesCommonMethods.feature@GetLicenseId') {LicensePermitId:'#(licenseId)'}
	   
	   
	   
	   * call read('AmendmentsCommonMethods.feature@IntakeAmendment') {}
	    * def amendmentType = 'Method of Operation'
	   * call read('AmendmentsCommonMethods.feature@AmendmentFeeValidation') {amount:10}
	   * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
	  
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	   

	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		* call read('LicensesCommonMethods.feature@ReviewDigestDocumentValidation') {documentDesc:'TestDocument.docx',docFileName:'TestDocument.docx'}
		* def reviewType = 'Send to Licensing Board'
		* def amendmentTypeId = 6
		* call read('AmendmentsCommonMethods.feature@AmendmentExaminerReviewApprovalToLB') {expStatus:'Awaiting Review'}
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}	   
	    
	     ## ******************** UC_LIC_ExamnerReviewToLB: Validate TC0001b_NYC_SLA_LIC_AMD_Examiner_MethodOfOperation_DigestTab Scenario End ***************************##   
	
 
Examples:
    | read('/CSVFiles/Uc_22_TC0005_NYC_SLA_LIC_Under_Payment.csv') |
    


 @TC0001c_NYC_SLA_LIC_AMD_Examiner_Alteration_DigestTab	  
 Scenario Outline: TC0001c_NYC_SLA_LIC_AMD_Examiner_Alteration_DigestTab
   
	# ********* Login Functionality *********************
  		
  		
		* def IndOrgSelectionDropDown = <IndOrgSelection>
  		* def indOrgCode = getIndORgCodeFunc(IndOrgSelectionDropDown)
  			And print indOrgCode
  		* def isIndStatus = getStatusIndOrgStatus(IndOrgSelectionDropDown)
	    * def CorporateStructureDropDown = <CorporateStructure>
	    * def CorporateStructureDropDownCode = getIndORgCodeFunc(indOrgCode,CorporateStructureDropDown)
	   		And print CorporateStructureDropDownCode
	    * def firstName = <FirstName>
	    * def lastName = <LastName>
	    * def legalName = firstName+ ' '+lastName
	    * def Address1 = <Address1>
	    * def Address2 = <Address2>
	    * def CityName = <City>
	    * def zipCode = <ZipCode>
	    * def postalCode = <PostalCode>
	    * def countryName = <Country>
	    * def emailId = <Email>
	    * def convictedOfCrime = <convictedOfCrime>
	    * def percentageOfOwners = <percentageOfOwners>
	    * def isFingerprintRequired = <isFingerprintRequired>
	    * def isFingerprintsApproved = <isFingerprintsApproved>
	    * def isSignature = <isSignature>
	    
	    * def convictedOfCrime = <convictedOfCrime>
		* def PhoneNumber = <PhoneNumber>
		* def PhoneExtn = <PhoneExtn>
		* def countryCode = <countryCode>
		* def stateCode = <StateCode>
	    
	  	* def mainLicensePermitTypeId = <LicensePermitTypeId>
	    * def termInYears = <NumberOfTerm>
	    * def termDesc = <NumberOfTerm>+' Year (s)'
	    * def licenseFees = <InitialLicFee>
	    * def fillingFees = <NonRefundableFilingFees>
	    * def licAncillaryFees = <AncillaryFees>
	    * def renewalFees = <RenewalFilingFees>+''
	    * string productName = <ProductTypes>+''
	     
	    * def CountyID = <countyIds>
	    * def CountyName = <County>	
		* def totalFees = licenseFees+fillingFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_LIC_ExamnerReviewToLB: Validate TC0001c_NYC_SLA_LIC_AMD_Examiner_Alteration_Digest Tab Scenario Start ***************************##
	   
	  * def SearchByLegalName = true
	   	* def SearchByLicId = false
	   	* def amendmentType = 'Alteration'
	   	* def appType = 'AL-'
	   
	   	* def termInYears = 1
	   	* def termDesc = termInYears +' Year (s)'
	   
	   	* def amendmentCode = getAmendmentTypeIdFunc(amendmentType)
	    * call read('AmendmentsCommonMethods.feature@SearchLicPermitIdForAmendment') {}
	   * call read('AmendmentsCommonMethods.feature@IntakeAmendment') {}
	   * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@AmendmentFeeValidation') {amount:10}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	   
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		* call read('LicensesCommonMethods.feature@ReviewDigestDocumentValidation') {documentDesc:'TestDocument.docx',docFileName:'TestDocument.docx'}
		* def reviewType = 'Send to Licensing Board'
		* def amendmentTypeId = 3
		* call read('AmendmentsCommonMethods.feature@AmendmentExaminerReviewApprovalToLB') {expStatus:'Awaiting Review'}
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}	   
	    
	     ## ******************** UC_LIC_ExamnerReviewToLB: Validate TC0001c_NYC_SLA_LIC_AMD_Examiner_Alteration_Digest Tab Scenario End ***************************##   
	
	
     
Examples:
    | read('/CSVFiles/Uc_22_TC0005_NYC_SLA_LIC_Under_Payment.csv') |    
     
     
     
 @TC0001d_NYC_SLA_LIC_AMD_Examiner_CorporateChange_DigestTab	  
 Scenario Outline: TC0001d_NYC_SLA_LIC_AMD_Examiner_CorporateChange_DigestTab
   
	# ********* Login Functionality *********************
  		
  		
		* def IndOrgSelectionDropDown = <IndOrgSelection>
  		* def indOrgCode = getIndORgCodeFunc(IndOrgSelectionDropDown)
  			And print indOrgCode
  		* def isIndStatus = getStatusIndOrgStatus(IndOrgSelectionDropDown)
	    * def CorporateStructureDropDown = <CorporateStructure>
	    * def CorporateStructureDropDownCode = getIndORgCodeFunc(indOrgCode,CorporateStructureDropDown)
	   		And print CorporateStructureDropDownCode
	    * def firstName = <FirstName>
	    * def lastName = <LastName>
	    * def legalName = firstName+ ' '+lastName
	    * def Address1 = <Address1>
	    * def Address2 = <Address2>
	    * def CityName = <City>
	    * def zipCode = <ZipCode>
	    * def postalCode = <PostalCode>
	    * def countryName = <Country>
	    * def emailId = <Email>
	    * def convictedOfCrime = <convictedOfCrime>
	    * def percentageOfOwners = <percentageOfOwners>
	    * def isFingerprintRequired = <isFingerprintRequired>
	    * def isFingerprintsApproved = <isFingerprintsApproved>
	    * def isSignature = <isSignature>
	    
	    * def convictedOfCrime = <convictedOfCrime>
		* def PhoneNumber = <PhoneNumber>
		* def PhoneExtn = <PhoneExtn>
		* def countryCode = <countryCode>
		* def stateCode = <StateCode>
	    
	  	* def mainLicensePermitTypeId = <LicensePermitTypeId>
	    * def termInYears = <NumberOfTerm>
	    * def termDesc = <NumberOfTerm>+' Year (s)'
	    * def licenseFees = <InitialLicFee>
	    * def fillingFees = <NonRefundableFilingFees>
	    * def licAncillaryFees = <AncillaryFees>
	    * def renewalFees = <RenewalFilingFees>+''
	    * string productName = <ProductTypes>+''
	     
	    * def CountyID = <countyIds>
	    * def CountyName = <County>	
		* def totalFees = licenseFees+fillingFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_LIC_ExamnerReviewToLB: Validate TC0001d_NYC_SLA_LIC_AMD_Examiner_Corporate Change_Digest Tab Scenario Start ***************************##
	   
	  * def SearchByLegalName = true
	   	* def SearchByLicId = false
	    * def amendmentType = 'Corporate Change'
	   	* def appType = 'CC-'
	   
	   	* def termInYears = 1
	   	* def termDesc = termInYears +' Year (s)'
	   
	   	* def amendmentCode = getAmendmentTypeIdFunc(amendmentType)
	    * call read('AmendmentsCommonMethods.feature@SearchLicPermitIdForAmendment') {}
	   * call read('AmendmentsCommonMethods.feature@IntakeAmendment') {}
	   * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@AmendmentFeeValidation') {amount:128}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	   
	    * call read('AmendmentsCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		* call read('LicensesCommonMethods.feature@ReviewDigestDocumentValidation') {documentDesc:'TestDocument.docx',docFileName:'TestDocument.docx'}
		* def reviewType = 'Send to Licensing Board'
		* def amendmentTypeId = 11
		* call read('AmendmentsCommonMethods.feature@AmendmentExaminerReviewApprovalToLB') {expStatus:'Awaiting Review'}
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}	   
	    
	     ## ******************** UC_LIC_ExamnerReviewToLB: Validate TC0001d_NYC_SLA_LIC_AMD_Examiner_Corporate Change_Digest Tab Scenario End ***************************##   
	
	
     
Examples:
    | read('/CSVFiles/Uc_22_TC0005_NYC_SLA_LIC_Under_Payment.csv') |    
   
   
 @TC0001e_NYC_SLA_LIC_AMD_Examiner_Endorsement_DigestTab	  
 Scenario Outline: TC0001e_NYC_SLA_LIC_AMD_Examiner_Endorsement_DigestTab
   
	# ********* Login Functionality *********************
  		
  		
		* def IndOrgSelectionDropDown = <IndOrgSelection>
  		* def indOrgCode = getIndORgCodeFunc(IndOrgSelectionDropDown)
  			And print indOrgCode
  		* def isIndStatus = getStatusIndOrgStatus(IndOrgSelectionDropDown)
	    * def CorporateStructureDropDown = <CorporateStructure>
	    * def CorporateStructureDropDownCode = getIndORgCodeFunc(indOrgCode,CorporateStructureDropDown)
	   		And print CorporateStructureDropDownCode
	    * def firstName = <FirstName>
	    * def lastName = <LastName>
	    * def legalName = firstName+ ' '+lastName
	    * def Address1 = <Address1>
	    * def Address2 = <Address2>
	    * def CityName = <City>
	    * def zipCode = <ZipCode>
	    * def postalCode = <PostalCode>
	    * def countryName = <Country>
	    * def emailId = <Email>
	    * def convictedOfCrime = <convictedOfCrime>
	    * def percentageOfOwners = <percentageOfOwners>
	    * def isFingerprintRequired = <isFingerprintRequired>
	    * def isFingerprintsApproved = <isFingerprintsApproved>
	    * def isSignature = <isSignature>
	    
	    * def convictedOfCrime = <convictedOfCrime>
		* def PhoneNumber = <PhoneNumber>
		* def PhoneExtn = <PhoneExtn>
		* def countryCode = <countryCode>
		* def stateCode = <StateCode>
	    
	  	* def mainLicensePermitTypeId = <LicensePermitTypeId>
	   
	    * def licenseFees = <InitialLicFee>
	    * def fillingFees = <NonRefundableFilingFees>
	    * def licAncillaryFees = <AncillaryFees>
	    * def renewalFees = <RenewalFilingFees>+''
	    * string productName = <ProductTypes>+''
	     
	    * def CountyID = <countyIds>
	    * def CountyName = <County>	
		* def totalFees = licenseFees+fillingFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_LIC_ExamnerReviewToLB: Validate TC0001e_NYC_SLA_LIC_AMD_Examiner_Endorsement_DigestTab Scenario Start ***************************##
	   
	  * def SearchByLegalName = true
	   	* def SearchByLicId = false
	    * def amendmentType = 'Endorsement'
	   	* def appType = 'EN-'
	   
	   	* def termInYears = 7
	   	* def termDesc = termInYears +' Months'
	   
	   	* def amendmentCode = getAmendmentTypeIdFunc(amendmentType)
	    * call read('AmendmentsCommonMethods.feature@SearchLicPermitIdForAmendment') {}
	   * call read('AmendmentsCommonMethods.feature@IntakeAmendment') {}
	   * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@AmendmentWaveFeesValidation') {}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	   
	    * call read('AmendmentsCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		* call read('LicensesCommonMethods.feature@ReviewDigestDocumentValidation') {documentDesc:'TestDocument.docx',docFileName:'TestDocument.docx'}
		* def reviewType = 'Send to Licensing Board'
		* def amendmentTypeId = 5
		* call read('LicensesCommonMethods.feature@AmendmentExaminerReviewApprovalToLB') {expStatus:'Awaiting Review'}
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}	   
	    
	     ## ******************** UC_LIC_ExamnerReviewToLB: Validate TC0001e_NYC_SLA_LIC_AMD_Examiner_Endorsement_DigestTab  Scenario End ***************************##   
	
	
     
Examples:
    | read('/CSVFiles/Uc_22_TC0005_NYC_SLA_LIC_Under_Payment.csv') |   
   
     
    
@TC0003_NYC_SLA_LIC_AMD_Examiner_Sends_Application_For_FBPT_Review	  
 Scenario Outline: TC0003_NYC_SLA_LIC_AMD_Examiner_Sends_Application_For_FBPT_Review
   
	   * def foo = ['123']
	   * match foo == '#[] #regex \\d+'
	# ********* Login Functionality *********************
  		
  		
		* def IndOrgSelectionDropDown = <IndOrgSelection>
  		* def indOrgCode = getIndORgCodeFunc(IndOrgSelectionDropDown)
  			And print indOrgCode
  		* def isIndStatus = getStatusIndOrgStatus(IndOrgSelectionDropDown)
	    * def CorporateStructureDropDown = <CorporateStructure>
	    * def CorporateStructureDropDownCode = getIndORgCodeFunc(indOrgCode,CorporateStructureDropDown)
	   		And print CorporateStructureDropDownCode
	    * def firstName = <FirstName>
	    * def lastName = <LastName>
	    * def legalName = firstName+ ' '+lastName
	    * def Address1 = <Address1>
	    * def Address2 = <Address2>
	    * def CityName = <City>
	    * def zipCode = <ZipCode>
	    * def postalCode = <PostalCode>
	    * def countryName = <Country>
	    * def emailId = <Email>
	    * def convictedOfCrime = <convictedOfCrime>
	    * def percentageOfOwners = <percentageOfOwners>
	    * def isFingerprintRequired = <isFingerprintRequired>
	    * def isFingerprintsApproved = <isFingerprintsApproved>
	    * def isSignature = <isSignature>
	    
	    * def convictedOfCrime = <convictedOfCrime>
		* def PhoneNumber = <PhoneNumber>
		* def PhoneExtn = <PhoneExtn>
		* def countryCode = <countryCode>
		* def stateCode = <StateCode>
	    
	  	* def mainLicensePermitTypeId = <LicensePermitTypeId>
	    * def termInYears = <NumberOfTerm>
	    * def termDesc = <NumberOfTerm>+' Year (s)'
	    * def licenseFees = <InitialLicFee>
	    * def fillingFees = <NonRefundableFilingFees>
	    * def licAncillaryFees = <AncillaryFees>
	    * def renewalFees = <RenewalFilingFees>+''
	    * string productName = <ProductTypes>+''
	     
	    * def CountyID = <countyIds>
	    * def CountyName = <County>	
		* def totalFees = licenseFees+fillingFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_Amendment_ExaminerReview: Validate TC0003_NYC_SLA_LIC_AMD_Examiner_Sends_Application_For_FBPT_Review Scenario Start ***************************##
	   
	  
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
	     
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		* call read('AmendmentsCommonMethods.feature@getAmendmentABCOfficerDetails') {}
		* def reviewType = 'Send to Full Board Preview Team'
		
		#* call read('LicensesCommonMethods.feature@SaveAndValidateAmendmentMemoLinkData') {}
		* call read('AmendmentsCommonMethods.feature@AmendmentExaminerReviewApprovalToLB') {expStatus:'Awaiting Review'}
		## ******************** UC_Amendment_ExaminerReview: Validate TC0003_NYC_SLA_LIC_AMD_Examiner_Sends_Application_For_FBPT_Review Scenario End ***************************##   
	    
Examples:
    | read('/CSVFiles/Uc_22_TC0005_NYC_SLA_LIC_Under_Payment.csv') | 
    
    
    
     
 @TC0004_NYC_SLA_LIC_AMD_Define_DeficienciesAndSend_Deficiency_Letter
 Scenario Outline: TC0004_NYC_SLA_LIC_AMD_Define_DeficienciesAndSend_Deficiency_Letter
   
	   * def foo = ['123']
	   * match foo == '#[] #regex \\d+'
	# ********* Login Functionality *********************
  		
  		
		* def IndOrgSelectionDropDown = <IndOrgSelection>
  		* def indOrgCode = getIndORgCodeFunc(IndOrgSelectionDropDown)
  			And print indOrgCode
  		* def isIndStatus = getStatusIndOrgStatus(IndOrgSelectionDropDown)
	    * def CorporateStructureDropDown = <CorporateStructure>
	    * def CorporateStructureDropDownCode = getIndORgCodeFunc(indOrgCode,CorporateStructureDropDown)
	   		And print CorporateStructureDropDownCode
	    * def firstName = <FirstName>
	    * def lastName = <LastName>
	    * def legalName = firstName+ ' '+lastName
	    * def Address1 = <Address1>
	    * def Address2 = <Address2>
	    * def CityName = <City>
	    * def zipCode = <ZipCode>
	    * def postalCode = <PostalCode>
	    * def countryName = <Country>
	    * def emailId = <Email>
	    * def convictedOfCrime = <convictedOfCrime>
	    * def percentageOfOwners = <percentageOfOwners>
	    * def isFingerprintRequired = <isFingerprintRequired>
	    * def isFingerprintsApproved = <isFingerprintsApproved>
	    * def isSignature = <isSignature>
	    
	    * def convictedOfCrime = <convictedOfCrime>
		* def PhoneNumber = <PhoneNumber>
		* def PhoneExtn = <PhoneExtn>
		* def countryCode = <countryCode>
		* def stateCode = <StateCode>
	    
	  	* def mainLicensePermitTypeId = <LicensePermitTypeId>
	    * def termInYears = <NumberOfTerm>
	    * def termDesc = <NumberOfTerm>+' Year (s)'
	    * def licenseFees = <InitialLicFee>
	    * def fillingFees = <NonRefundableFilingFees>
	    * def licAncillaryFees = <AncillaryFees>
	    * def renewalFees = <RenewalFilingFees>+''
	    * string productName = <ProductTypes>+''
	     
	    * def CountyID = <countyIds>
	    * def CountyName = <County>	
		* def totalFees = licenseFees+fillingFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_Amendment_ExaminerReview: Validate TC0004_NYC_SLA_LIC_AMD_Define_Deficiencies and send Deficiency Letter Scenario Start ***************************##
	   
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
	   
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		* call read('AmendmentsCommonMethods.feature@getAmendmentABCOfficerDetails') {}
		* def deficienciesCount = 1
		* def reviewType = 'Define Deficiencies'
		
		* call read('AmendmentsCommonMethods.feature@AmendmentExaminerReviewApprovalToLB') {expStatus:'Additional Info Required'}
		
	     ## ******************** UC_Amendment_ExaminerReview: Validate TC0004_NYC_SLA_LIC_AMD_Define_Deficiencies and send Deficiency Letter Scenario End ***************************##   
	
	
     
Examples:
    | read('/CSVFiles/Uc_22_TC0005_NYC_SLA_LIC_Under_Payment.csv') |      
      

 @TC0005_NYC_SLA_LIC_AMD_Add_Multiple_Deficiencies
 Scenario Outline: TC0005_NYC_SLA_LIC_AMD_Add_Multiple_Deficiencies
   
	   * def foo = ['123']
	   * match foo == '#[] #regex \\d+'
	# ********* Login Functionality *********************
  		
  		
		* def IndOrgSelectionDropDown = <IndOrgSelection>
  		* def indOrgCode = getIndORgCodeFunc(IndOrgSelectionDropDown)
  			And print indOrgCode
  		* def isIndStatus = getStatusIndOrgStatus(IndOrgSelectionDropDown)
	    * def CorporateStructureDropDown = <CorporateStructure>
	    * def CorporateStructureDropDownCode = getIndORgCodeFunc(indOrgCode,CorporateStructureDropDown)
	   		And print CorporateStructureDropDownCode
	    * def firstName = <FirstName>
	    * def lastName = <LastName>
	    * def legalName = firstName+ ' '+lastName
	    * def Address1 = <Address1>
	    * def Address2 = <Address2>
	    * def CityName = <City>
	    * def zipCode = <ZipCode>
	    * def postalCode = <PostalCode>
	    * def countryName = <Country>
	    * def emailId = <Email>
	    * def convictedOfCrime = <convictedOfCrime>
	    * def percentageOfOwners = <percentageOfOwners>
	    * def isFingerprintRequired = <isFingerprintRequired>
	    * def isFingerprintsApproved = <isFingerprintsApproved>
	    * def isSignature = <isSignature>
	    
	    * def convictedOfCrime = <convictedOfCrime>
		* def PhoneNumber = <PhoneNumber>
		* def PhoneExtn = <PhoneExtn>
		* def countryCode = <countryCode>
		* def stateCode = <StateCode>
	    
	  	* def mainLicensePermitTypeId = <LicensePermitTypeId>
	    * def termInYears = <NumberOfTerm>
	    * def termDesc = <NumberOfTerm>+' Year (s)'
	    * def licenseFees = <InitialLicFee>
	    * def fillingFees = <NonRefundableFilingFees>
	    * def licAncillaryFees = <AncillaryFees>
	    * def renewalFees = <RenewalFilingFees>+''
	    * string productName = <ProductTypes>+''
	     
	    * def CountyID = <countyIds>
	    * def CountyName = <County>	
		* def totalFees = licenseFees+fillingFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_Amendment_ExaminerReview: Validate TC0005_NYC_SLA_LIC_AMD_Add_Multiple_Deficiencies Scenario Start ***************************##
	   
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
	   
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		* call read('AmendmentsCommonMethods.feature@getAmendmentABCOfficerDetails') {}
		* def deficienciesCount = 2
		* def reviewType = 'Define Deficiencies'
		
		* call read('AmendmentsCommonMethods.feature@AmendmentExaminerReviewApprovalToLB') {expStatus:'Additional Info Required'}
		
	     ## ******************** UC_Amendment_ExaminerReview: Validate TC0005_NYC_SLA_LIC_AMD_Add_Multiple_Deficiencies Scenario End ***************************##   
	
	
     
Examples:
    | read('/CSVFiles/Uc_22_TC0005_NYC_SLA_LIC_Under_Payment.csv') |     
    
    
    
    
    
@TC0017_NYC_SLA_LIC_AMD_Highly_Deficient
Scenario: TC0017_NYC_SLA_LIC_AMD_Highly_Deficient
 
  		## ******************** UC_Amendment_ExaminerReview: Validate TC0017_NYC_SLA_LIC_AMD_Highly_Deficient Scenario Start ***************************##
	   	
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
	   * def amendmentType = 'ABC Officer'
	   * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
	   * call read('AmendmentsCommonMethods.feature@AmendmentFeeValidation') {amount:128}
	   * def reason = 'Automation Admnt Highly Deficient'
	   * call read('LicensesCommonMethods.feature@SaveReasonHiglyDeficient') {}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@getAndValidateReasonHiglyDeficient') {}
	   
	    ## ******************** UC_Amendment_ExaminerReview: Validate TC0017_NYC_SLA_LIC_AMD_Highly_Deficient Scenario End ***************************##   
		 	 		 	 		
		 	 	          
	 	  
Feature: Rescind Decision
Background:
			* url BaseURL
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
@TC0001_SLA_COM_Rescind_Decision_Approved_Main_License_with_associated_Permit    	
Scenario Outline: TC0001_SLA_COM_Rescind_Decision_Approved_Main_License_with_associated_Permit
   
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
	    #* def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees
	    * def splittedCityName = CityName.replaceAll(" ","")
	    * def SearchByLegalName = false
	   	* def SearchByLicId = true
	    * def PermitType = 'Associated'	   	
	   	* def appType = 'NA-'
	   	* def termInYears = 3
	   	* def LicensePermitId = '0002-'
	   	* def termDesc = termInYears +' Year (s)'
	    * call read('AmendmentsCommonMethods.feature@SearchLicPermitIdForAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@IntakePermit') {}
        #* call read('LicensesCommonMethods.feature@GetPreFillLicenseAllDetailsByLicenseId') {} 
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    #* call read('AmendmentsCommonMethods.feature@FillAndSaveApplicantInformationPageAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
	    * call read('LicensesCommonMethods.feature@FeesValidation') {amount:40000}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@PermitExaminerReview') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}    
        * call read('LicensesCommonMethods.feature@LBClaimingQueue') {}
		* def name = 'Approved'
		* def value = 1
		* call read('LicensesCommonMethods.feature@PermitLBDecisions') {}
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Approved'}
	    * def licAppId = appId	 
	    And print licAppId   
	    * call read('LicensesCommonMethods.feature@IntakeRescindApplication') {}
		* call read('LicensesCommonMethods.feature@UploadDisApprovalDocumentRescind') {}
		* def name = 'Disapproved'
		* def value = 2
		* call read('LicensesCommonMethods.feature@RescindDecision') {}   
        * call read('LicensesCommonMethods.feature@checkRescindApplicationStatusforDisapprove') {expStatus:'Disapproved'}
	 #   * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}	    
	
Examples:
    | read('/CSVFiles/TC_AssociatedPermitInputs.csv') |
    
         
@TC0002_SLA_COM_Rescind_Decision_Disapproved_License    	
Scenario Outline: TC0002_SLA_COM_Rescind_Decision_Disapproved_License
   
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
	    #* def CountyName = <County>	
		* def totalFees = licenseFees+fillingFees
	    * def splittedCityName = CityName.replaceAll(" ","")
	    * def SearchByLegalName = true
	   	* def SearchByLicId = false
	    * def PermitType = 'Associated'	   	
	   	* def appType = 'NA-'
	   	* def termInYears = 3
	   	* def LicensePermitId = '0002-'
	   	 * def CountyName = "New York"
	   	* def termDesc = termInYears +' Year (s)'
	    * call read('UC_PRMT_099_LBDecisions.feature@TC0002_SLA_PER_LB_ReasonforDisapproved') {}
	    * def licAppId = appId
	    * call read('LicensesCommonMethods.feature@IntakeRescindApplication') {}
		* def name = 'Approved'
		* def value = 1
		* call read('LicensesCommonMethods.feature@RescindDecision') {}  
        * call read('LicensesCommonMethods.feature@checkRescindApplicationStatus') {expStatus:'Approved'}
	 #   * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}	    

Examples:
    | read('/CSVFiles/TC_AssociatedPermitInputs.csv') |
    
@TC0003_SLA_COM_Rescind_Decision_Approved_Standalone_Permit    	
Scenario Outline: TC0003_SLA_COM_Rescind_Decision_Approved_Standalone_Permit
   
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
	    #* def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees
	    * def splittedCityName = CityName.replaceAll(" ","")
	    * def SearchByLegalName = false
	   	* def SearchByLicId = true
	    * def PermitType = 'Associated'	   	
	   	* def appType = 'NA-'
	   	* def termInYears = 3
	   	* def LicensePermitId = '0002-'
	   	* def termDesc = termInYears +' Year (s)'
	    * call read('AmendmentsCommonMethods.feature@SearchLicPermitIdForAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@IntakePermit') {}
        #* call read('LicensesCommonMethods.feature@GetPreFillLicenseAllDetailsByLicenseId') {} 
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    #* call read('AmendmentsCommonMethods.feature@FillAndSaveApplicantInformationPageAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
	    * call read('LicensesCommonMethods.feature@FeesValidation') {amount:40000}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@PermitExaminerReview') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}    
        * call read('LicensesCommonMethods.feature@LBClaimingQueue') {}
		* def name = 'Approved'
		* def value = 1
		* call read('LicensesCommonMethods.feature@PermitLBDecisions') {}
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Approved'}
	    * def licAppId = appId	 
	    And print licAppId   
	    * call read('LicensesCommonMethods.feature@IntakeRescindApplication') {}
		* call read('LicensesCommonMethods.feature@UploadDisApprovalDocumentRescind') {}
		* def name = 'Disapproved'
		* def value = 2
		* call read('LicensesCommonMethods.feature@RescindDecision') {}   
        * call read('LicensesCommonMethods.feature@checkRescindApplicationStatusforDisapprove') {expStatus:'Disapproved'}
	 #   * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}	    

Examples:
    | read('/CSVFiles/TC_StandAlone.csv') |
    
@TC0004_SLA_COM_Rescind_Decision_Disapproved_Standalone_Permit    	
Scenario Outline: TC0004_SLA_COM_Rescind_Decision_Disapproved_Standalone_Permit
   
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
	    #* def CountyName = <County>	
		* def totalFees = licenseFees+fillingFees
	    * def splittedCityName = CityName.replaceAll(" ","")
	    * def SearchByLegalName = true
	   	* def SearchByLicId = false
	    * def PermitType = 'Associated'	   	
	   	* def appType = 'NA-'
	   	* def termInYears = 3
	   	* def LicensePermitId = '0002-'
	   	 * def CountyName = "New York"
	   	* def termDesc = termInYears +' Year (s)'
	    * call read('UC_PRMT_099_LBDecisions.feature@TC0002_SLA_PER_LB_ReasonforDisapproved') {}
	    * def licAppId = appId
	    * call read('LicensesCommonMethods.feature@IntakeRescindApplication') {}
		* def name = 'Approved'
		* def value = 1
		* call read('LicensesCommonMethods.feature@RescindDecision') {}  
        * call read('LicensesCommonMethods.feature@checkRescindApplicationStatus') {expStatus:'Approved'}
	 #   * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}	    

Examples:
    | read('/CSVFiles/TC_StandAlone.csv') |

@TC0005_SLA_COM_Send_Application_back_to_Examiner_Approved_application    	
Scenario Outline: TC0005_SLA_COM_Send_Application_back_to_Examiner_Approved_application
   
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
	   
	    * call read('LicensesCommonMethods.feature@IntakeLicensewithoutAssociatedLic') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('LicensesCommonMethods.feature@FeesValidation') {amount:'#(totalFees)'}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	   
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	     
	    * call read('LicensesCommonMethods.feature@ExaminerReviewApprovalToLB') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
	    * call read('LicensesCommonMethods.feature@AddLicenseClaimingQueue') {}
		* def DefineStipulationStatus = true
		* def licStatus = 'Approved'
		* call read('LicensesCommonMethods.feature@ApproveLBWithStipulations') {StipulationsCount:0}
        * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Approved'}
	    * def licAppId = appId
	    * call read('LicensesCommonMethods.feature@IntakeRescindApplication') {}
		* def exptask = 'Rescinded'
		* call read('LicensesCommonMethods.feature@RescindDecisionSendBackToExaminer') {}  
        * call read('LicensesCommonMethods.feature@CheckApplicationSendBackToExaminer') {expStatus:'Under Review'}
	#   * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}	    	

Examples:
    | read('/CSVFiles/Uc_22_TC0005_NYC_SLA_LIC_Under_Payment.csv') |    
    
@TC0006_SLA_COM_Send_Application_back_to_Examiner_Disapproved_application    	
Scenario Outline: TC0006_SLA_COM_Send_Application_back_to_Examiner_Disapproved_application
   
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
	    #* def CountyName = <County>	
		* def totalFees = licenseFees+fillingFees
	    * def splittedCityName = CityName.replaceAll(" ","")
	    * def SearchByLegalName = true
	   	* def SearchByLicId = false
	    * def PermitType = 'Associated'	   	
	   	* def appType = 'NA-'
	   	* def termInYears = 3
	   	* def LicensePermitId = '0002-'
	   	 * def CountyName = "New York"
	   	* def termDesc = termInYears +' Year (s)'
	    * call read('UC_PRMT_099_LBDecisions.feature@TC0002_SLA_PER_LB_ReasonforDisapproved') {}
	    * def licAppId = appId
	    * call read('LicensesCommonMethods.feature@IntakeRescindApplication') {}
		* def exptask = 'Rescinded'
		* call read('LicensesCommonMethods.feature@RescindDecisionSendBackToExaminer') {}  
        * call read('LicensesCommonMethods.feature@CheckApplicationSendBackToExaminer') {expStatus:'Under Review'}
	#   * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}	    	

Examples:
    | read('/CSVFiles/TC_AssociatedPermitInputs.csv') |  
    
@TC0007_SLA_COM_Send_Application_back_to_Examiner_Approved_standalone_Permit    	
Scenario Outline: TC0007_SLA_COM_Send_Application_back_to_Examiner_Approved_standalone_Permit
   
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
	    #* def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees
	    * def splittedCityName = CityName.replaceAll(" ","")
	    * def SearchByLegalName = false
	   	* def SearchByLicId = true
	    * def PermitType = 'Associated'	   	
	   	* def appType = 'NA-'
	   	* def termInYears = 3
	   	* def LicensePermitId = '0002-'
	   	* def termDesc = termInYears +' Year (s)'
	    * call read('AmendmentsCommonMethods.feature@SearchLicPermitIdForAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@IntakePermit') {}
        #* call read('LicensesCommonMethods.feature@GetPreFillLicenseAllDetailsByLicenseId') {} 
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    #* call read('AmendmentsCommonMethods.feature@FillAndSaveApplicantInformationPageAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
	    * call read('LicensesCommonMethods.feature@FeesValidation') {amount:40000}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@PermitExaminerReview') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}    
        * call read('LicensesCommonMethods.feature@LBClaimingQueue') {}
		* def name = 'Approved'
		* def value = 1
		* call read('LicensesCommonMethods.feature@PermitLBDecisions') {}
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Approved'}
	    * def licAppId = appId	 
	    * call read('LicensesCommonMethods.feature@IntakeRescindApplication') {}
		* def exptask = 'Rescinded'
		* call read('LicensesCommonMethods.feature@RescindDecisionSendBackToExaminer') {}  
        * call read('LicensesCommonMethods.feature@CheckApplicationSendBackToExaminer') {expStatus:'Under Review'}
	#   * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}	    	

Examples:
    | read('/CSVFiles/TC_StandAlone.csv') |
    
@TC0008_SLA_COM_Send_Application_back_to_Examiner_Disapproved_standalone_Permit    	
Scenario Outline: TC0008_SLA_COM_Send_Application_back_to_Examiner_Disapproved_standalone_Permit
   
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
	    #* def CountyName = <County>	
		* def totalFees = licenseFees+fillingFees
	    * def splittedCityName = CityName.replaceAll(" ","")
	    * def SearchByLegalName = true
	   	* def SearchByLicId = false
	    * def PermitType = 'Associated'	   	
	   	* def appType = 'NA-'
	   	* def termInYears = 3
	   	* def LicensePermitId = '0002-'
	   	 * def CountyName = "New York"
	   	* def termDesc = termInYears +' Year (s)'
	    * call read('UC_PRMT_099_LBDecisions.feature@TC0002_SLA_PER_LB_ReasonforDisapproved') {}
	    * def licAppId = appId
	    * call read('LicensesCommonMethods.feature@IntakeRescindApplication') {}
		* def exptask = 'Rescinded'
		* call read('LicensesCommonMethods.feature@RescindDecisionSendBackToExaminer') {}  
        * call read('LicensesCommonMethods.feature@CheckApplicationSendBackToExaminer') {expStatus:'Under Review'}
	#   * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}	    	

Examples:
    | read('/CSVFiles/TC_StandAlone.csv') |                
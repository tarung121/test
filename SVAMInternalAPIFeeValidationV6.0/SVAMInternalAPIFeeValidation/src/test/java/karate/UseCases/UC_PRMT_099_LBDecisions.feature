Feature: LB Decision Permits
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
 			* def waitFunc =
		        """
		      function(timeinMiliSeconds) {
		        // load java type into js engine
		        var Thread = Java.type('java.lang.Thread');
		        Thread.sleep(timeinMiliSeconds); 
		      }
		      """

@TC0001_SLA_PER_LB_Approved_Aircraft_Onetime	  
Scenario Outline: TC0001_SLA_PER_LB_Approved_Aircraft_Onetime
   
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
	    
	     ## ******************** UC_PRMT_099_LBDecisions: Validate TC0001_SLA_PER_LB_Approved_Aircraft_Onetime Scenario End ***************************##   
	
Examples:
    | read('/CSVFiles/TC_LBDecisions.csv') |   
     
@TC0001_SLA_PER_LB_Approved_Liquidator	  
Scenario Outline: TC0001_SLA_PER_LB_Approved_Liquidator
   
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
	    * def PermitType = 'TemporaryNotQualified'	   	
	   	* def appType = 'NA-'
	   	* def termInYears = 3
	   	* def LicensePermitId = '0002-'
	   	* def termDesc = termInYears +' Year (s)'
	    * call read('AmendmentsCommonMethods.feature@SearchLicPermitIdForAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@LiquidatorPermitIntake') {}
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
	    
	     ## ******************** UC_PRMT_099_LBDecisions: Validate TC0001_SLA_PER_LB_Approved_Aircraft_Onetime Scenario End ***************************##   
	
Examples:
    | read('/CSVFiles/LiquidatorPermit.csv') |   	    

@TC0002_SLA_PER_LB_ReasonforDisapproved	  
Scenario Outline: TC0002_SLA_PER_LB_ReasonforDisapproved
   
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
	    #* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@PermitExaminerReview') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}    
        * call read('LicensesCommonMethods.feature@LBClaimingQueue') {}
		* call read('LicensesCommonMethods.feature@UploadDisApprovalDocument') {}
		* def name = 'Disapproved'
		* def value = 2
		* call read('LicensesCommonMethods.feature@PermitLBDecisionsDisapproval') {expStatus:'Disapproved'}
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Disapproved'}	
		* def wait = waitFunc(50000)
	    * def subject = 'Disapproval'
	    #* call read('LicensesCommonMethods.feature@ValidatePermitCommunicationPageAndEMail') {typeOfNotification:'Generic Non-Portal'}
	   * call read('LicensesCommonMethods.feature@ValidateAttachedDocument')
	    
	     ## ******************** UC_PRMT_099_LBDecisions: Validate TC0002a_SLA_PER_LB_Reason for Disapproved Scenario End ***************************##   
	
Examples:
    | read('/CSVFiles/TC_AssociatedPermitInputs.csv') |   	  

@TC0010_SLA_PER_LB_disapproval_to_counsel_Disapproved_for_Cause	  
Scenario Outline: TC0010_SLA_PER_LB_disapproval_to_counsel_Disapproved_for_Cause
   
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
	    #* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@PermitExaminerReview') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}    
        * call read('LicensesCommonMethods.feature@LBClaimingQueue') {}
		* call read('LicensesCommonMethods.feature@UploadDisApprovalDocument') {}
		* def name = 'Disapproval to Counsel'
		* def value = 3
		* call read('LicensesCommonMethods.feature@PermitLBDecisionsDisapproval') {expStatus:'Pending Disapproval Letter'}
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}	
		* def wait = waitFunc(50000)
	    * def subject = 'Disapproval'
	  #  * call read('LicensesCommonMethods.feature@ValidatePermitCommunicationPageAndEMail') {typeOfNotification:'Generic Non-Portal'}
	   * call read('LicensesCommonMethods.feature@ValidateAttachedDocument')
	    
	     ## ******************** UC_PRMT_099_LBDecisions: Validate TC0002a_SLA_PER_LB_Reason for Disapproved Scenario End ***************************##   
	
Examples:
    | read('/CSVFiles/TC_AssociatedPermitInputs.csv') |
 
 
 
@TC0011_SLA_PER_LB_Withdrawal_Withdrawal_Requested	  
Scenario Outline: TC0011_SLA_PER_LB_Withdrawal_Withdrawal_Requested
   
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
	    #* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@PermitExaminerReview') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}    
        * call read('LicensesCommonMethods.feature@LBClaimingQueue') {}
		* call read('LicensesCommonMethods.feature@UploadDisApprovalDocument') {}
		* def name = 'Withdrawal'
		* def value = 4
		* call read('LicensesCommonMethods.feature@PermitLBDecisionsDisapproval') {expStatus:'Refund Awaiting Review'}
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Withdrawn'}	
		* def wait = waitFunc(50000)
	    * def subject = 'Withdrawal'
	  #  * call read('LicensesCommonMethods.feature@ValidatePermitCommunicationPageAndEMail') {typeOfNotification:'Generic Non-Portal'}
	   * call read('LicensesCommonMethods.feature@ValidateAttachedDocument')
	    
	     ## ******************** UC_PRMT_099_LBDecisions: Validate TC0002a_SLA_PER_LB_Reason for Disapproved Scenario End ***************************##   
	
Examples:
    | read('/CSVFiles/TC_AssociatedPermitInputs.csv') |
    
@TC0013_SLA_PERLB_FB_Decision_required	  
Scenario Outline: TC0013_SLA_PERLB_FB_Decision_required
   
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
	    #* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@PermitExaminerReview') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}    
        * call read('LicensesCommonMethods.feature@LBClaimingQueue') {}
		* call read('LicensesCommonMethods.feature@UploadDisApprovalDocument') {}
		* def name = 'FB Decision Required'
		* def value = 6
		* call read('LicensesCommonMethods.feature@PermitLBDecisionsDisapproval') {expStatus:'FB Decision Required'}
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}	
	    
	     ## ******************** UC_PRMT_099_LBDecisions: Validate TC0002a_SLA_PER_LB_Reason for Disapproved Scenario End ***************************##   
	
Examples:
    | read('/CSVFiles/TC_AssociatedPermitInputs.csv') |   
    

@TC0014_SLA_PER_LB_Return_to_an_Examiner	  
Scenario Outline: TC0014_SLA_PER_LB_Return_to_an_Examiner
   
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
	    #* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@PermitExaminerReview') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}    
        * call read('LicensesCommonMethods.feature@LBClaimingQueue') {}
		* call read('LicensesCommonMethods.feature@UploadDisApprovalDocument') {}
		* def name = 'Return to Examiner'
		* def value = 7
		* call read('LicensesCommonMethods.feature@PermitLBDecisions') {}
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}	
	    
	     ## ******************** UC_PRMT_099_LBDecisions: Validate TC0002a_SLA_PER_LB_Reason for Disapproved Scenario End ***************************##   
	
Examples:
    | read('/CSVFiles/TC_AssociatedPermitInputs.csv') |   

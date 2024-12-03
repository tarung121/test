Feature: Select Licenses Intake form
Background:
			* url BaseURL
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
@licenseAllScenarios  	
Scenario Outline: Select Licenses Intake form
   
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
	    * def CountyID = <countyIds>	
	    	
    ## ******************** UC_LIC_018 a: IntakeLicensewithoutAssociatedLic Scenario Start ***************************##
	   
	    * call read('LicensesCommonMethods.feature@IntakeLicensewithoutAssociatedLic') {}
	 ## ******************** UC_LIC_018 a: IntakeLicensewithoutAssociatedLic Scenario End ***************************##   
	
	 ## ******************** UC_LIC_018 b: IntakeLicensewithAssociatedTempPermit Scenario Start ***************************##
	   #* call read('LicensesCommonMethods.feature@IntakeLicensewithAssociatedTempPermit') {}
	 ## ******************** UC_LIC_018 b: IntakeLicensewithAssociatedTempPermit Scenario End ***************************##   
	
      ## ******************** UC_LIC_018 c: IntakeLicensewithApplyForTempPermit Scenario Start ***************************##
	    #* call read('LicensesCommonMethods.feature@IntakeLicensewithApplyForTempPermit') {}
	 ## ******************** UC_LIC_018 c: IntakeLicensewithApplyForTempPermit Scenario End ***************************## 
	 
	 ## ******************** UC_LIC_018 d: IntakeAdditionalSeasonalBarLicensewithoutTempPermit Scenario Start ***************************##
	   # * call read('LicensesCommonMethods.feature@IntakeAdditionalSeasonalBarLicensewithoutTempPermit') {}
	 ## ******************** UC_LIC_018 d: IntakeAdditionalSeasonalBarLicensewithoutTempPermit Scenario End ***************************## 
	 
	  ## ******************** UC_LIC_018 e: IntakeAdditionalSeasonalBarLicensewithTempPermit Scenario Start ***************************##
	    #* call read('LicensesCommonMethods.feature@IntakeAdditionalBarLicensewithTempPermit') {}
	 ## ******************** UC_LIC_018 e: IntakeAdditionalSeasonalBarLicensewithTempPermit Scenario End ***************************## 
	 
     
Examples:
    | read('/CSVFiles/UC_LIC_18_SelectType.csv') |
    
@licenseAwaitingAdditionalFundsValidation	  
 Scenario Outline: UC_LIC_019- Due Dates InformationIf status is 'Awaiting Additional Funds'- due date to provide new payment/satisfy fees when application is marked as 'Payment Failed'
   
	# ********* Login Functionality *********************
  	* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
  		
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
	    * def renewalFees = <RenewalFilingFees>+''
	    * string productName = <ProductTypes>+''
	     
	    * def CountyID = <countyIds>	
	      * def CountyName = <County>	
	## ******************** UC_LIC_019 a: Awaiting Additional Funds Scenario Start ***************************##
	   
	    * call read('LicensesCommonMethods.feature@IntakeLicensewithoutAssociatedLic') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('LicensesCommonMethods.feature@FeesValidation') {}
	    * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@IsPaymentFailedScenario') {expStatus:'Awaiting Additional Funds'}
	    
	    
	 ## ******************** UC_LIC_019 a: Awaiting Additional Funds Scenario End ***************************##   
	
	
     
Examples:
    | read('/CSVFiles/UC_LIC_18_SelectTypeInputs.csv') |
	  	
 
 
 
 @licenseDefineDefendenciesValidation	  
 Scenario Outline: UC_LIC_019- License Validation with Define Depedencies
   
	# ********* Login Functionality *********************
  	* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
  		
		
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
	    * def renewalFees = <RenewalFilingFees>+''
	    * string productName = <ProductTypes>+''
	     
	    * def CountyID = <countyIds>	
	      * def CountyName = <County>	
	   ## ******************** UC_LIC_019 a: Validate Define Dependencies Scenario Start ***************************##
	   
	    * call read('LicensesCommonMethods.feature@IntakeLicensewithoutAssociatedLic') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('LicensesCommonMethods.feature@FeesValidation') {}
	    * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ExaminerReviewDefineDeficiencies') {approvalName:'Define Deficiencies',expStatus:'Additional Info Required'}
	    
	    
	 ## ******************** UC_LIC_019 a: Validate Define Dependencies Scenario End ***************************##   
	
	
     
Examples:
    | read('/CSVFiles/UC_LIC_18_SelectTypeInputs.csv') |
    
    
    

 @licenseConditionallyApprovedValidation	  
 Scenario Outline: UC_LIC_019- License Validation with ConditionallyApproved
   
	# ********* Login Functionality *********************
  	* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
  		
		
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
	    * def renewalFees = <RenewalFilingFees>+''
	    * string productName = <ProductTypes>+''
	     
	    * def CountyID = <countyIds>	
	     * def CountyName = <County>	 
	   ## ******************** UC_LIC_019 a: Validate ConditionallyApproved Scenario Start ***************************##
	   
	    * call read('LicensesCommonMethods.feature@IntakeLicensewithoutAssociatedLic') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('LicensesCommonMethods.feature@FeesValidation') {}
	    * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	     * call read('LicensesCommonMethods.feature@ExaminerReviewApprovalToLB') {expStatus:'Awaiting Review'}
	    
	    * call read('LicensesCommonMethods.feature@LBClaimingQueue') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@LBApproval') {approvalName:'Conditionally Approved',expStatus:'Conditionally Approved'}
	    
	    
	 ## ******************** UC_LIC_019 a: Validate ConditionallyApproved Scenario End ***************************##   
	
	
     
Examples:
    | read('/CSVFiles/UC_LIC_18_SelectTypeInputs.csv') |    
	  	
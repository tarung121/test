Feature: Examiner review
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


 @TC0001_NYC_SLA_LIC_LB_Approves_Application_With_No_Stipulations	  
 Scenario Outline: TC0001_NYC_SLA_LIC_LB_Approves_Application_With_No_Stipulations
   
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
	   ## ******************** UC_LIC_32_LBDecisions: Validate TC0001_NYC_SLA_LIC_LB_Approves_Application_With_No_Stipulations Scenario Start ***************************##
	   
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
	     ## ******************** UC_LIC_32_LBDecisions: Validate TC0001_NYC_SLA_LIC_LB_Approves_Application_With_No_Stipulations Scenario End ***************************##   
	

Examples:
    | read('/CSVFiles/Uc_22_TC0005_NYC_SLA_LIC_Under_Payment.csv') |
    

 @TC0002_NYC_SLA_LIC_LB_Approves_Application_With_Stipulations	  
 Scenario Outline: TC0002_NYC_SLA_LIC_LB_Approves_Application_With_Stipulations
   
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
	   ## ******************** UC_LIC_32_LBDecisions: Validate TC0002_NYC_SLA_LIC_LB_Approves_Application_With_Stipulations Scenario Start ***************************##
	   
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
		* call read('LicensesCommonMethods.feature@ApproveLBWithStipulations') {StipulationsCount:1}
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Approved'}
	     ## ******************** UC_LIC_32_LBDecisions: Validate TC0002_NYC_SLA_LIC_LB_Approves_Application_With_Stipulations Scenario End ***************************##   
	

Examples:
    | read('/CSVFiles/Uc_22_TC0005_NYC_SLA_LIC_Under_Payment.csv') |
    


 @TC0003_NYC_SLA_LIC_LB_Approves_With_Multiple_Stipulations	  
 Scenario Outline: TC0003_NYC_SLA_LIC_LB_Approves_With_Multiple_Stipulations
   
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
	   ## ******************** UC_LIC_32_LBDecisions: Validate TC0003_NYC_SLA_LIC_LB_Approves_With_Multiple_Stipulations Scenario Start ***************************##
	   
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
		* call read('LicensesCommonMethods.feature@ApproveLBWithStipulations') {StipulationsCount:2}
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Approved'}
	     ## ******************** UC_LIC_32_LBDecisions: Validate TC0003_NYC_SLA_LIC_LB_Approves_With_Multiple_Stipulations Scenario End ***************************##   
	

Examples:
    | read('/CSVFiles/Uc_22_TC0005_NYC_SLA_LIC_Under_Payment.csv') | 
    
    
  
 @TC0006_NYC_SLA_LIC_LB_Disapproves_Application	  
 Scenario Outline: TC0006_NYC_SLA_LIC_LB_Disapproves_Application
   
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
	   ## ******************** UC_LIC_32_LBDecisions: Validate TC0006_NYC_SLA_LIC_LB_Disapproves_Application Scenario Start ***************************##
	   
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
	    * def lbStatus = 'Disapproved'
	    * def lbDropDownVal = 2
		* call read('LicensesCommonMethods.feature@DisapproveLB') {}
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Disapproved'}
	     ## ******************** UC_LIC_32_LBDecisions: Validate TC0006_NYC_SLA_LIC_LB_Disapproves_Application Scenario End ***************************##   
	

Examples:
    | read('/CSVFiles/Uc_22_TC0005_NYC_SLA_LIC_Under_Payment.csv') |  
    
    

 @TC0008_NYC_SLA_LIC_LB_Marks_Application_As_Disapproval_To_Counsel	  
 Scenario Outline: TC0008_NYC_SLA_LIC_LB_Marks_Application_As_Disapproval_To_Counsel
   
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
	   ## ******************** UC_LIC_32_LBDecisions: Validate TC0008_NYC_SLA_LIC_LB_Marks_Application_As_Disapproval_To_Counsel Scenario Start ***************************##
	   
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
	    * def lbStatus = 'Disapproval to Counsel'
	    * def lbDropDownVal = 3
		* call read('LicensesCommonMethods.feature@DisapproveLB') {}
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		* def letterStatus = 'Pending Disapproval Letter'
		* call read('LicensesCommonMethods.feature@SearchAndValidateCounselQueueApplicationStatus') {}
		
	     ## ******************** UC_LIC_32_LBDecisions: Validate TC0008_NYC_SLA_LIC_LB_Marks_Application_As_Disapproval_To_Counsel Scenario End ***************************##   
	

Examples:
    | read('/CSVFiles/Uc_22_TC0005_NYC_SLA_LIC_Under_Payment.csv') |     


 @TC0009_NYC_SLA_LIC_LB_Marks_Application_As_Withdrawn	  
 Scenario Outline: TC0009_NYC_SLA_LIC_LB_Marks_Application_As_Withdrawn
   
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
	   ## ******************** UC_LIC_32_LBDecisions: Validate TC0009_NYC_SLA_LIC_LB_Marks_Application_As_Withdrawn Scenario Start ***************************##
	   
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
	    * def lbStatus = 'Withdrawal'
	    * def lbDropDownVal = 4
		* call read('LicensesCommonMethods.feature@DisapproveLB') {}
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Withdrawn'}
		
		
	     ## ******************** UC_LIC_32_LBDecisions: Validate TC0009_NYC_SLA_LIC_LB_Marks_Application_As_Withdrawn Scenario End ***************************##   
	

Examples:
    | read('/CSVFiles/Uc_22_TC0005_NYC_SLA_LIC_Under_Payment.csv') | 
    
    

 @TC0010_NYC_SLA_LIC_LB_Conditionally_Approved_Application	  
 Scenario Outline: TC0010_NYC_SLA_LIC_LB_Conditionally_Approved_Application
   
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
	   ## ******************** UC_LIC_32_LBDecisions: Validate TC0010_NYC_SLA_LIC_LB_Conditionally_Approved_Application Scenario Start ***************************##
	   
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
		* def licStatus = 'Conditionally Approved'
		* call read('LicensesCommonMethods.feature@ApproveLBWithStipulations') {StipulationsCount:1}
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Conditionally Approved'}
	     ## ******************** UC_LIC_32_LBDecisions: Validate TC0010_NYC_SLA_LIC_LB_Conditionally_Approved_Application Scenario End ***************************##   
	

Examples:
    | read('/CSVFiles/Uc_22_TC0005_NYC_SLA_LIC_Under_Payment.csv') |     
    
          
	 	  
	
	

 @TC0011_NYC_SLA_LIC_LB_Marks_Application_FB_Decision_Required
 Scenario Outline: TC0011_NYC_SLA_LIC_LB_Marks_Application_FB_Decision_Required(redirected to Examiner)
   
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
	   ## ******************** UC_LIC_32_LBDecisions: Validate TC0011_NYC_SLA_LIC_LB_Marks_Application_FB_Decision_Required(redirected to Examiner) Scenario Start ***************************##
	   
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
		
		* call read('LicensesCommonMethods.feature@FBDecisionRequiredScenario') {}
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
	    
	    * call read('LicensesCommonMethods.feature@SearchAndValidateLicenseExaminerQueue') {taskStatus:'FB Decision Required'}
	     ## ******************** UC_LIC_32_LBDecisions: Validate TC0011_NYC_SLA_LIC_LB_Marks_Application_FB_Decision_Required(redirected to Examiner) Scenario End ***************************##   
	

Examples:
    | read('/CSVFiles/Uc_22_TC0005_NYC_SLA_LIC_Under_Payment.csv') | 
    
    
@TC0012_NYC_SLA_LIC_LB_Returns_Application_To_Examiner 
Scenario Outline: TC0012_NYC_SLA_LIC_LB_Returns_Application_To_Examiner
   
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
	   ## ******************** UC_LIC_32_LBDecisions: Validate TC0012_NYC_SLA_LIC_LB_Returns_Application_To_Examiner Scenario Start ***************************##
	   
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
		* def licStatus = 'Return to Examiner'
		* call read('LicensesCommonMethods.feature@ApproveLBWithStipulations') {StipulationsCount:0}
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
	    
	    * call read('LicensesCommonMethods.feature@SearchAndValidateLicenseExaminerQueue') {taskStatus:'Additional Info Requested'}
	     ## ******************** UC_LIC_32_LBDecisions: Validate TC0012_NYC_SLA_LIC_LB_Returns_Application_To_Examiner Scenario End ***************************##   
	

Examples:
    | read('/CSVFiles/Uc_22_TC0005_NYC_SLA_LIC_Under_Payment.csv') |   	
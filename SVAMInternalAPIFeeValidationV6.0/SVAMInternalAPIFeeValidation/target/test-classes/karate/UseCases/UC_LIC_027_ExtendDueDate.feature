Feature: ExtendDueDate
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
		  
		  * def fundDueDateFunc1 =
		  """
			  function(days) {
			    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
			    var sdf = new SimpleDateFormat("yyyy-MM-dd");
			    
			    var date = new java.util.Date();
			    var dayAfter = new java.util.Date(date.getTime() + java.util.concurrent.TimeUnit.DAYS.toMillis( days));
			    return sdf.format(dayAfter);
			  } 
		  """
		  
		  
@TC0001_NYS_SLA_Deficiency_Due_Date_Extension_Approved	  
Scenario Outline: TC0001_NYS_SLA_Deficiency_Due_Date_Extension_Approved		  
  
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
		* def amountPaid = totalFees+''
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_LIC_027: Validate TC0001_NYS_SLA_Deficiency_Due_Date_Extension_Approved Scenario Start ***************************##
	   
	    * call read('LicensesCommonMethods.feature@IntakeLicensewithoutAssociatedLic') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('LicensesCommonMethods.feature@FeesValidation') {amount:'#(totalFees)'}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		* call read('LicensesCommonMethods.feature@ExaminerReviewApprovalWithAllDefineDeficiencies') {expStatus:'Additional Info Required'}
	   * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
	   * call read('LicensesCommonMethods.feature@checkApplicationStatus') {expStatus:'Additional Info Required'}
		
		* call read('LicensesCommonMethods.feature@getDueDateExtension2'){}
	  	* def extendedDueDate = fundDueDateFunc1(10)
	  	And print extendedDueDate
	  	
	  	* def approvedStatus = true
	  	
	  	* call read('LicensesCommonMethods.feature@ApproveDisapproveDueDateExtension2'){}

	    
	     ## ******************** UC_LIC_027: Validate TC0001_NYS_SLA_Deficiency_Due_Date_Extension_Approved Scenario End ***************************##   
	
Examples:
    | read('/CSVFiles/Uc_22_TC0005_NYC_SLA_LIC_Under_Payment.csv') |  

@TC0006_NYS_SLA_Failed_Payment_Extension_Approved	  
Scenario: TC0006_NYS_SLA_Failed_Payment_Extension_Approved
    
	# ********* Login Functionality *********************
  
  		
		
	   ## ******************** UC_LIC_027_ExtendDueDateOfReturnCheck: TC0006_NYS_SLA_Failed_Payment_Extension_Approved Scenario Start ***************************##
	   
	  	* call read('UC_LIC_027_ReturnCheck.feature@TC0002_NYC_SLA_LIC_Update_Application_Send_Notifications'){}
	  	
	  	* def extendedDueDate = fundDueDateFunc1(10)
	  	And print extendedDueDate
	  	* def approvedStatus = true
	  	* call read('LicensesCommonMethods.feature@ApproveDisapproveDueDateExtension2'){}
	  
	 ## ******************** UC_LIC_027_ExtendDueDateOfReturnCheck: TC0006_NYS_SLA_Failed_Payment_Extension_Approved Scenario End ***************************##   

    
 @TC0007_NYS_SLA_Deficiency_Due_Date_Extension_Disapproved
 Scenario Outline: TC0007_NYS_SLA_Deficiency_Due_Date_Extension_Disapproved
   
	  
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
	   ## ******************** UC_LIC_027: Validate TC0007_NYS_SLA_Deficiency_Due_Date_Extension_Disapproved Scenario Start ***************************##
	   
	    * call read('LicensesCommonMethods.feature@IntakeLicensewithoutAssociatedLic') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('LicensesCommonMethods.feature@FeesValidation') {amount:'#(totalFees)'}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		* call read('LicensesCommonMethods.feature@ExaminerReviewApprovalWithAllDefineDeficiencies') {expStatus:'Additional Info Required'}
	   * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
	    * call read('LicensesCommonMethods.feature@checkApplicationStatus') {expStatus:'Additional Info Required'}
		
		  * call read('LicensesCommonMethods.feature@getDueDateExtension'){}
	  	* def extendedDueDate = currentDueDate
	  	
	  	* def approvedStatus = false
	  	And print extendedDueDate
	  	* call read('LicensesCommonMethods.feature@ApproveDisapproveDueDateExtension2'){}
	    
	     ## ******************** UC_LIC_027: Validate TC0007_NYS_SLA_Deficiency_Due_Date_Extension_Disapproved Scenario End ***************************##   
	
	
     
Examples:
    | read('/CSVFiles/Uc_22_TC0005_NYC_SLA_LIC_Under_Payment.csv') |  
  
  
@TC0008_NYS_SLA_Failed_Payment_Extension_Disapproved	  
Scenario: TC0008_NYS_SLA_Failed_Payment_Extension_Disapproved
     ## ******************** UC_LIC_027_ExtendDueDateOfReturnCheck:TC0008_NYS_SLA_Failed_Payment_Extension_Disapproved Scenario Start ***************************##
	   
	  	* call read('UC_LIC_027_ReturnCheck.feature@TC0002_NYC_SLA_LIC_Update_Application_Send_Notifications'){}
	  	* call read('LicensesCommonMethods.feature@getDueDateExtension'){}
	  	* def extendedDueDate = currentDueDate
	  	* def approvedStatus = false
	  	And print extendedDueDate
	  	* call read('LicensesCommonMethods.feature@ApproveDisapproveDueDateExtension2'){}
	  
	  
	  
	  
	 ## ******************** UC_LIC_027_ExtendDueDateOfReturnCheck: TC0008_NYS_SLA_Failed_Payment_Extension_Disapproved Scenario End ***************************##   

@TC0011_NYS_SLA_Conditions_Due_Date_Extension_Approved	  
Scenario: TC0008_NYS_SLA_Failed_Payment_Extension_Disapproved
     ## ******************** UC_LIC_027_ExtendDueDateOfReturnCheck:TC0008_NYS_SLA_Failed_Payment_Extension_Disapproved Scenario Start ***************************##
	   
	  	* call read('UC_LIC_030_IntakeConditions.feature@TC0006_NYC_SLA_LIC_Intake_Conditions_Mark_Partial_Condition_Met'){}
	  	 * call read('LicensesCommonMethods.feature@getDueDateExtension'){}
	  	* def extendedDueDate = currentDueDate
	  	
	  	* def approvedStatus = false
	  	And print extendedDueDate
	  	* call read('LicensesCommonMethods.feature@ApproveDisapproveDueDateExtension'){}
	    
  
    
        
	  
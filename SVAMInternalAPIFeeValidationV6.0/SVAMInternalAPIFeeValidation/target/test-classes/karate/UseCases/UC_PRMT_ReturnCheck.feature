Feature: UC_PRMT_ReturnCheck
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
		
		 * def fundDueDateFunc1 =
		  """
			  function(days) {
			    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
			    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'00:00:00");
			    
			    var date = new java.util.Date();
			    var dayAfter = new java.util.Date(date.getTime() + java.util.concurrent.TimeUnit.DAYS.toMillis( days));
			    return sdf.format(dayAfter);
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

@TC0001_SLA_PER_Return_Check_Payment_failed_Awaiting_Review	  
Scenario Outline: TC0001_SLA_PER_Return_Check_Payment_failed_Awaiting_Review
   
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
	    * call read('LicensesCommonMethods.feature@SearchLicenseApplicationByCriteria') {expLicStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@IsPaymentFailedScenario') {dueDateCount:10,expStatus:'Awaiting Additional Funds'}
	   	* def fundDueDate1 = fundDueDateFunc1(10)
	    * call read('LicensesCommonMethods.feature@GetDueDateByAppId') {licAction:'Payment Failed',appStatus:'Awaiting Additional Funds',dueDate:'#(fundDueDate1)'}
	    * def documentDesc = 'Returned_Check'
	   # * call read('LicensesCommonMethods.feature@ValidateAttachedDocument1') {}
	    
	 ## ******************** UC_LIC_029_ReturnCheck: TC0002_NYC_SLA_LIC_Update_Application_Send_Notification Scenario End ***************************##   
	
Examples:
    | read('/CSVFiles/TC_AssociatedPermitInputs.csv') |    

@TC0002_SLA_REN_Return_Check_Intake_Payment_Awaiting_Additional_Funds	  
Scenario Outline: TC0002_SLA_REN_Return_Check_Intake_Payment_Awaiting_Additional_Funds
   
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
	    * call read('LicensesCommonMethods.feature@SearchLicenseApplicationByCriteria') {expLicStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@IsPaymentFailedScenario') {dueDateCount:10,expStatus:'Awaiting Additional Funds'}
	   	* def fundDueDate1 = fundDueDateFunc1(10)
	    * call read('LicensesCommonMethods.feature@GetDueDateByAppId') {licAction:'Payment Failed',appStatus:'Awaiting Additional Funds',dueDate:'#(fundDueDate1)'}
	    * def documentDesc = 'Returned_Check'
	   # * call read('LicensesCommonMethods.feature@ValidateAttachedDocument1') {}
	    * def previousAmount =  amount+ ".00"
	    * def totalAmount = ~~Math.round(totalFees)
	    * def totalAmountStr = ~~Math.round(totalFees)+".00"
	   # * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@FillFeesFormwithPaymentAfterPaymentFailed') {previousAmount:'#(previousAmount)',isPaymentFailed:true,totalAmount:'#(totalAmount)'}
	    * call read('LicensesCommonMethods.feature@SearchLicenseApplicationByCriteria') {expLicStatus:'Awaiting Additional Funds'}
	 ## ******************** UC_LIC_029_ReturnCheck: TC0002_NYC_SLA_LIC_Update_Application_Send_Notification Scenario End ***************************##   
	
Examples:
    | read('/CSVFiles/TC_AssociatedPermitInputs.csv') |           

@TC0004_NYC_SLA_LIC_Insufficient_Funds_received	  
Scenario Outline: TC0004_NYC_SLA_LIC_Insufficient_Funds_received
   
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
	    * call read('LicensesCommonMethods.feature@SearchLicenseApplicationByCriteria') {expLicStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@IsPaymentFailedScenario') {dueDateCount:10,expStatus:'Awaiting Additional Funds'}
	   	* def fundDueDate1 = fundDueDateFunc1(10)
	    * call read('LicensesCommonMethods.feature@GetDueDateByAppId') {licAction:'Payment Failed',appStatus:'Awaiting Additional Funds',dueDate:'#(fundDueDate1)'}
	    * def documentDesc = 'Returned_Check'
	 #   * call read('LicensesCommonMethods.feature@ValidateAttachedDocument1') {}
	    * def previousAmount =  amount+ ".00"
	    * def totalAmount = ~~Math.round(totalFees-10)
	    * def totalAmountStr = ~~Math.round(totalFees-10)+".00"
	   # * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@FillFeesFormwithPaymentAfterPaymentFailed') {previousAmount:'#(previousAmount)',isPaymentFailed:true,totalAmount:'#(totalAmount)'}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Additional Funds'}
	    
	 ## ******************** UC_LIC_029_ReturnCheck: TC0004_NYC_SLA_LIC_Insufficient_Funds_received Scenario End ***************************##   
    
Examples:
    | read('/CSVFiles/TC_AssociatedPermitInputs.csv') |    

@TC0010_NYC_SLA_LIC_Intake_New_Payment_Overpayment	  
Scenario Outline: TC0010_NYC_SLA_LIC_Intake_New_Payment_Overpayment
   
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
	    * call read('LicensesCommonMethods.feature@SearchLicenseApplicationByCriteria') {expLicStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@IsPaymentFailedScenario') {dueDateCount:10,expStatus:'Awaiting Additional Funds'}
	   	* def fundDueDate1 = fundDueDateFunc1(10)
	    * call read('LicensesCommonMethods.feature@GetDueDateByAppId') {licAction:'Payment Failed',appStatus:'Awaiting Additional Funds',dueDate:'#(fundDueDate1)'}
	    * def documentDesc = 'Returned_Check'
	   # * call read('LicensesCommonMethods.feature@ValidateAttachedDocument1') {}
	    * def previousAmount =  amount+ ".00"
	    * def totalAmount = ~~Math.round(totalFees+100)
	    * def totalAmountStr = totalAmount+".00"
	    And print totalAmountStr
	   # * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@FillFeesFormwithPaymentAfterPaymentFailed') {previousAmount:'#(previousAmount)',isPaymentFailed:true,totalAmount:'#(totalAmount)'}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    
	 ## ******************** UC_LIC_029_ReturnCheck: TC0010_NYC_SLA_LIC_Intake_New_Payment_Overpayment Scenario End ***************************##   
    
Examples:
    | read('/CSVFiles/TC_AssociatedPermitInputs.csv') |    
	  
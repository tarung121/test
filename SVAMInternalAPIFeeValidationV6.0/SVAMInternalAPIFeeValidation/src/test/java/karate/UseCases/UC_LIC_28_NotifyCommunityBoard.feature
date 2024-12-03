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

@TC0001_NYS_SLA_Notification_To_Community_Board	  
Scenario Outline: TC0001_NYS_SLA_Notification_To_Community_Board
   
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
	    * def LicenseDescription = <LicDescription> 
	    * def CountyId = <countyIds>
	     #* def CountyName = <County>	
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_LIC_020 a: Validate TC0001_NYS_SLA_LIC_PD_Letter_On Scenario Start ***************************##	    
	    * call read('LicensesCommonMethods.feature@IntakeLicensewithoutAssociatedLic') {}
	    * def CountyName = "New York"
	    * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {county:'#(CountyName)'}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    #* call read('LicensesCommonMethods.feature@FillAndSaveMethodOfOperationPage') {}
	    * call read('LicensesCommonMethods.feature@WaveFeesValidation') {expStatus:'Intake Complete'}
	    * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus2') {expStatus:'Awaiting Review'}
    * def docName = 'CommunityBoard'
	    * call read('LicensesCommonMethods.feature@ValidateCommunicationPageAndEMailForOnPromises2') {NotificationMethodName:'SendPDLetterNotification',typeOfNotification:'Email',emailBodyData:'Authorized Representative,  \r<br/>\r<br/>Please see the attached letter regarding an application filed with the New York State Liquor Authority. \r<br/>\r<br/>Sincerely yours, \r<br/>\r<br/>State Liquor Authority \u2013 Licensing Bureau'}
	   
	    
	 ## ******************** UC_LIC_020 a: Validate TC0001_NYS_SLA_LIC_PD_Letter_On Scenario End ***************************##   
	
	
     
Examples:
    | read('/CSVFiles/TC0001_NYS_SLA_LIC_NotifyCommunityBoard.csv') |    
	  


@TC0002_NYS_SLA_No_Notification_To_Community_Board	  
Scenario Outline: TC0002_NYS_SLA_No_Notification_To_Community_Board
   
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
	     
	    * def CountyId = <countyIds>
	     * def CountyName = <County>	
	      * def splittedCityName = CityName.replaceAll(" ","")
	      
	   ## ******************** UC_LIC_020 b: Validate TC0002_NYC_SLA_LIC_PD_Letter_Of Scenario Start ***************************##
	   
	    * call read('LicensesCommonMethods.feature@IntakeLicensewithoutAssociatedLic') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('LicensesCommonMethods.feature@FeesValidation') {}
	    * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {}
	    * def docName = splittedCityName+'_PD_Letter'
	    * def emailBodyData = 'Dear '+legalName1+',\r<br/>\r<br/>Important information pertaining to your record(s) is attached.\r<br/>\r<br/>Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date.\r<br/>\r<br/>Failure to provide a timely response may result in the disapproval of your application. The response should be sent to the e-mail address provided in the letter.\r<br/>\r<br/>Sincerely yours,\r<br/>\r<br/>New York State Liquor Authority'
	    * call read('LicensesCommonMethods.feature@ValidateCommunicationPageAndEMailForOFFPromises2') {NotificationMethodName:'SendPDLetterNotification',typeOfNotification:'Email',emailBodyData:'#(emailBodyData)'}
	   
	    
	 ## ******************** UC_LIC_020 b: Validate TC0002_NYC_SLA_LIC_PD_Letter_Of Scenario End ***************************##   
	
	
     
Examples:
    | read('/CSVFiles/TC0002_NYC_SLA_LIC_PD_Letter_Of.csv') |  	  
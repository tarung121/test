Feature: UC_024_GISReport
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
			
					 * def waitFunc =
		        """
		      function(timeinMiliSeconds) {
		        // load java type into js engine
		        var Thread = Java.type('java.lang.Thread');
		        Thread.sleep(timeinMiliSeconds); 
		      }
		      """

@TC0001_NYC_SLA_LIC_Request_Gross_Sales_Report  
 Scenario Outline: TC0001_NYC_SLA_LIC_Request_Gross_Sales_Report
   
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
	    * def licAncillaryFees = <AncillaryFees>
	    * def renewalFees = <RenewalFilingFees>+''
	    * string productName = <ProductTypes>+''
	     
	    * def CountyId = <countyIds>
	    * def CountyName = <County>	
		* def totalFees = licenseFees+fillingFees
	    * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_LIC_024: Validate TC0001_NYC_SLA_LIC_Request_Gross_Sales_Report Scenario Start ***************************##
	   
	    * call read('LicensesCommonMethods.feature@IntakeLicensewithoutAssociatedLic') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('LicensesCommonMethods.feature@WaveFeesValidation') {amount:'#(totalFees)'}
	    * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {}
	    
	    # * call read('LicensesCommonMethods.feature@getGisReportByAppId') {}
	    * call read('LicensesCommonMethods.feature@getGisReport') {}
	     * call read('LicensesCommonMethods.feature@SaveGrossSalesReport') {}
	    
	     * call read('LicensesCommonMethods.feature@UpdateGISReportDecision') {}
	     * def docName = 'Gross Sales New App'
	    
	   
	     #* call read('LicensesCommonMethods.feature@ValidateCommunicationPageAndEMailForOnPromises'){NotificationMethodName:'SendPDLetterNotification',typeOfNotification:'Generic Template',emailBodyData:'Important information pertaining to your record(s) is attached.<br/><br/>Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date.<br/><br/>Failure to provide a timely response may result in the disapproval of your application. The response should be sent to the e-mail address provided in the letter.<br/><br/>Sincerely yours,<br/><br/>New York State Liquor Authority'}
	    								           																																		        
	    
	    
	 ## ******************** UC_LIC_024: Validate TC0001_NYC_SLA_LIC_Request_Gross_Sales_Report Scenario End ***************************##   
	
	
     
Examples:
    | read('/CSVFiles/Uc_24_GISReport.csv') |  
    
    
    
    
@TC0004_NYC_SLA_LIC_Generate_200_Notification_Church_Enforcement  
 Scenario Outline: TC0004_NYC_SLA_LIC_Generate_200_Notification_Church_Enforcement
   
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
	    * def licAncillaryFees = <AncillaryFees>
	    * def renewalFees = <RenewalFilingFees>+''
	    * string productName = <ProductTypes>+''
	     
	    * def CountyId = <countyIds>
	    * def CountyName = <County>	
		* def totalFees = licenseFees+fillingFees
	    * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_LIC_024: Validate TC0004_NYC_SLA_LIC_Generate_200_Notification_Church_Enforcement Scenario Start ***************************##
	   
	    * call read('LicensesCommonMethods.feature@IntakeLicensewithoutAssociatedLic') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('LicensesCommonMethods.feature@WaveFeesValidation') {amount:'#(totalFees)'}
	    * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {}
	    
	    # * call read('LicensesCommonMethods.feature@getGisReportByAppId') {}
	    * call read('LicensesCommonMethods.feature@getGisReport') {}
	     * call read('LicensesCommonMethods.feature@SaveGrossSalesReport') {}
	   * def wait = waitFunc(30000)
	     
	      * call read('LicensesCommonMethods.feature@getTodayReferedEnforcementCount') {}
	     * def beforeReferEnfcount = totalEnfCount
	     * call read('LicensesCommonMethods.feature@GISReferToEnforcement') {TypeId:3,Type:'Church',TypeName:"217church Office 2",TypeAddress:"4 Church St, Windsor, NJ 08561",TypeApproxDistance:"2.55 Mi",licenseId:67435,churchComments:" 217church Office 2\n",schoolComments:null }
	   * def wait = waitFunc(30000)
	    
	    * call read('LicensesCommonMethods.feature@getTodayReferedEnforcementCount') {}
	     * def afterReferEnfcount = totalEnfCount
	     And print beforeReferEnfcount
	     And print afterReferEnfcount
	 ## ******************** UC_LIC_024: Validate TC0004_NYC_SLA_LIC_Generate_200_Notification_Church_Enforcement Scenario End ***************************##   
	
	
     
Examples:
    | read('/CSVFiles/Uc_24_GISReport.csv') |    
          
   
@TC0006_NYC_SLA_LIC_Generate_200_Notification_School_Enforcement  
 Scenario Outline: TC0006_NYC_SLA_LIC_Generate_200_Notification_School_Enforcement
   
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
	    * def licAncillaryFees = <AncillaryFees>
	    * def renewalFees = <RenewalFilingFees>+''
	    * string productName = <ProductTypes>+''
	     
	    * def CountyId = <countyIds>
	    * def CountyName = <County>	
		* def totalFees = licenseFees+fillingFees
	    * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_LIC_024: Validate TC0006_NYC_SLA_LIC_Generate_200_Notification_School_Enforcement Scenario Start ***************************##
	   
	    * call read('LicensesCommonMethods.feature@IntakeLicensewithoutAssociatedLic') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('LicensesCommonMethods.feature@WaveFeesValidation') {amount:'#(totalFees)'}
	    * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {}
	    
	     #* call read('LicensesCommonMethods.feature@getGisReportByAppId') {}
	    * call read('LicensesCommonMethods.feature@getGisReport') {}
	     * call read('LicensesCommonMethods.feature@SaveGrossSalesReport') {}
	   * def wait = waitFunc(30000)
	     
	      * call read('LicensesCommonMethods.feature@getTodayReferedEnforcementCount') {}
	     * def beforeReferEnfcount = totalEnfCount
	     * call read('LicensesCommonMethods.feature@GISReferToEnforcement') {TypeId:2,Type:'School',TypeName:"Community Middle School",TypeAddress:"95 Grovers Mill Rd, Plainsboro Township, NJ 08536",TypeApproxDistance:"2.42 Mi",licenseId:12345,churchComments:null,schoolComments:" Community Middle School\n" }
	   * def wait = waitFunc(300000)
	    * call read('LicensesCommonMethods.feature@getTodayReferedEnforcementCount') {}
	     * def afterReferEnfcount = totalEnfCount
	     And print beforeReferEnfcount
	     And print afterReferEnfcount
	     * assert afterReferEnfcount > beforeReferEnfcount
	   ## ******************** UC_LIC_024: Validate TC0006_NYC_SLA_LIC_Generate_200_Notification_School_Enforcement Scenario End ***************************##   
	
	
     
Examples:
    | read('/CSVFiles/Uc_24_GISReport.csv') |        

	  
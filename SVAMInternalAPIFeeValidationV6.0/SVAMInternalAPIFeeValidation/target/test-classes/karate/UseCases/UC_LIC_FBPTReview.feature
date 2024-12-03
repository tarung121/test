Feature: FBPT review
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
			    	* def UniqueDate =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("M/D/YYYY''HH:00:00'AM'");
		    var date = new java.util.Date();
		    return sdf.format(date);
		    System.out.println(date)
		  } 
		  """
		  #9/7/2022 12:00:00 AM
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


 @TC0001_NYC_SLA_LIC_FBPT_Redirects_Application_For_LB_Decision	  
 Scenario Outline: TC0001_NYC_SLA_LIC_FBPT_Redirects_Application_For_LB_Decision
   
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
	     * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees
	    * def amountPaid = totalFees+''
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_LIC_020 a: Validate TC0001_NYC_SLA_LIC_FBPT_Redirects_Application_For_LB_Decision Scenario Start ***************************##
	   
	    * call read('LicensesCommonMethods.feature@IntakeLicensewithoutAssociatedLic') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('LicensesCommonMethods.feature@FeesValidation') {amount:'#(totalFees)'}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		* call read('LicensesCommonMethods.feature@ExaminerReviewApprovalToFBPTQueue') {}
	    * call read('LicensesCommonMethods.feature@getAndValidateMemoData') {}
	    * call read('LicensesCommonMethods.feature@AssignFBPTLicToLB') {}
	    #* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
	    #* call read('LicensesCommonMethods.feature@checkApplicationStatus') {expStatus:'Awaiting Review'}
		
	    
	     ## ******************** UC_LIC_022 a: Validate TC0001_NYC_SLA_LIC_FBPT_Redirects_Application_For_LB_Decision Scenario End ***************************##   
	
	
     
Examples:
    | read('/CSVFiles/Uc_22_TC0005_NYC_SLA_LIC_Under_Payment.csv') |     
	 	  
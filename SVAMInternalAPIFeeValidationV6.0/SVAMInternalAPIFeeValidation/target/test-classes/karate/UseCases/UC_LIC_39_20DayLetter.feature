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


    

 @TC0001_NYC_SLA_LIC_Approve_20_Days_Letter	  
 Scenario Outline: TC0001_NYC_SLA_LIC_Approve_20_Days_Letter
   
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
	   ## ******************** UC_LIC_39_20DayLetter: Validate TC0001_NYC_SLA_LIC_Approve_20_Days_Letter Scenario Start ***************************##
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
	    
	    * call read('LicensesCommonMethods.feature@updateInformationLetter') {approvedStatus:true,comment:"Approve letter before 20 days"}
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Conditionally Approved -Operating under 20 day'}
		
		* def getCurrentDate =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("MM/dd/yyyy");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		  """
		   * def getAddedDate =
		  """
		  function(days) {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("MM/dd/yyyy");
		    
		    var date = new java.util.Date();
		    var dayAfter = new java.util.Date(date.getTime() + java.util.concurrent.TimeUnit.DAYS.toMillis( days));
		    return sdf.format(dayAfter);
		  } 
		  """
		* def tomorrowDate = getAddedDate(1)
		* def Added20DaysDate = getAddedDate(20)
		* def taskStatus = 'Conditionally Approved - Operating under 20 day Valid From '+tomorrowDate+ ' To '+Added20DaysDate
		* call read('LicensesCommonMethods.feature@SearchAndValidateClericalQueueApplicationStatus') {}
	    
	    * def documentDesc = '20_Day_Approval'
	    * call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {}
	     ## ******************** UC_LIC_39_20dayLetter: Validate TC0001_NYC_SLA_LIC_Approve_20_Days_Letter Scenario End ***************************##   
	

Examples:
    | read('/CSVFiles/Uc_22_TC0005_NYC_SLA_LIC_Under_Payment.csv') |     
    
    
    
  
 @TC0001a_NYC_SLA_LIC_Conditions_Met_Before_20_Days	  
 Scenario: TC0001a_NYC_SLA_LIC_Conditions_Met_Before_20_Days
   
	     ## ******************** UC_LIC_39_20dayLetter: Validate TC0001a_NYC_SLA_LIC_Conditions_Met_Before_20_Days Scenario End ***************************##   
	* call read('UC_LIC_39_20DayLetter.feature@TC0001_NYC_SLA_LIC_Approve_20_Days_Letter') {}
	
		* call read('LicensesCommonMethods.feature@saveConditionsInfo') {}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Active'}
	     * def sleep = function(millis){ java.lang.Thread.sleep(millis) }
		* sleep(30000)
	     * def documentDesc = 'License_Cert'
	    * call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {}
	     
	    
	     ## ******************** UC_LIC_39_20dayLetter: Validate TC0001a_NYC_SLA_LIC_Conditions_Met_Before_20_Days Scenario End ***************************##   
    
          
 

 @TC0003_NYC_SLA_LIC_Disapprove_20_Days_Letter	  
 Scenario Outline: TC0003_NYC_SLA_LIC_Disapprove_20_Days_Letter
   
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
	   ## ******************** UC_LIC_39_20DayLetter: Validate TC0003_NYC_SLA_LIC_Disapprove_20_Days_Letter Scenario Start ***************************##
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
	    
	    * call read('LicensesCommonMethods.feature@updateInformationLetter') {approvedStatus:false,comment:"Disapproval Letter comment"}
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Conditionally Approved'}
		* def sleep = function(millis){ java.lang.Thread.sleep(millis) }
		* sleep(10000)
		* def typeOfNotification = '20 Day letter_Disapproval'
		* def subject = '20 Day Letter Disapproval'
		#* def emailBodyData = "Dear Applicant,    \r<br/>  \r<br/>Your request for a 20-Day operating letter, for the above-mentioned record, has been denied.    \r<br/>  \r<br/>You are required to satisfy all conditions of approval prior to license being issued.      \r<br/>\r<br/>Sincerely yours,      \r<br/>\r<br/>New York State Liquor Authority - Licensing Bureau"

		#* call read('LicensesCommonMethods.feature@ValidateEmailCommunicationQueue') {}
	     ## ******************** UC_LIC_39_20dayLetter: Validate TC0003_NYC_SLA_LIC_Disapprove_20_Days_Letter Scenario End ***************************##   
	

Examples:
    | read('/CSVFiles/Uc_22_TC0005_NYC_SLA_LIC_Under_Payment.csv') |     
    
    	 	  
	
	  	
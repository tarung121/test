Feature: Examiner review
Background:
			* url BaseURL
			* def config = { username: '#(dbUserName)', password:'#(dbUserPassword)', url: '#(dbQuery)',driverClassName: 'com.microsoft.sqlserver.jdbc.SQLServerDriver' }
    	 	* def DbUtils = Java.type('utils.DbUtils')
    		* def db = new DbUtils(config)
			* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
			* def amendmentTypeId = 1
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
	* def getAmendmentTypeIdFunc =
			"""
				function(amendmentType){
					if (amendmentType == 'ABC Officer'){
					return 1;
					}
					else if (amendmentType == 'Additional Bar'){
					return 2;
					}
					else if (amendmentType == 'Alteration'){
					return 3;
					}
					else if (amendmentType == 'Alteration with Additional Bar'){
					return 3;
					}
					
					
			    }
			"""
		 * def waitFunc =
		        """
		      function(timeinMiliSeconds) {
		        // load java type into js engine
		        var Thread = Java.type('java.lang.Thread');
		        Thread.sleep(timeinMiliSeconds*1000); 
		      }
		      """
		* def fundDueDateFunc =
		  """
		  function(days) {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
		    
		    var date = new java.util.Date();
		    var dayAfter = new java.util.Date(date.getTime() + java.util.concurrent.TimeUnit.DAYS.toMillis( days));
		    return sdf.format(dayAfter);
		  } 
		  """
		* def fundDueDateFunc1 =
		  """
		  function(days) {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH");
		    
		    var date = new java.util.Date();
		    var dayAfter = new java.util.Date(date.getTime() + java.util.concurrent.TimeUnit.DAYS.toMillis( days));
		    return sdf.format(dayAfter);
		  } 
		  """
		* def getMMMMDate =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("MMMM dd, yyyy");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		  """
		  
  	  * def mmmmdate = getMMMMDate()
  	  
  	  * def getMMYYDate =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("MM/dd/yyyy");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		  """
		  
  	  * def mmyydate = getMMYYDate()
  	  
  	  * def getFundDueDateMMYYDate =
		  """
		  function(days) {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("MM/dd/yyyy");
		    
		    var date = new java.util.Date();
		    var dayAfter = new java.util.Date(date.getTime() + java.util.concurrent.TimeUnit.DAYS.toMillis( days));
		    return sdf.format(dayAfter);
		  } 
		  """
		  
  	  * def mmyydateFundDueDate = getFundDueDateMMYYDate(7)

 @TC0001_NYC_SLA_LIC_AMD_Update_Application_Send_Notification	  
 Scenario Outline: TC0001_NYC_SLA_LIC_AMD_Update_Application_Send_Notification
   
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
	   ## ******************** UC_LIC_ExamnerReviewToLB: Validate TC0001_NYC_SLA_LIC_AMD_Update_Application_Send_Notification Scenario Start ***************************##
	   
	  * def SearchByLegalName = false
	   	* def SearchByLicId = true
	   	* def amendmentType = 'ABC Officer'
	   	* def appType = 'AO-'
	   	* def termInYears = 3
	   	
	   	* def termDesc = termInYears +' Year (s)'
	   	* def typeOfNotification = 'Letter_Fingerprinting_Instructions'
	   	* def fileName = 'Letter_Fingerprinting_Instructions.pdf'
	   	
	   	* call read('LicensesCommonMethods.feature@IntakeLicensewithoutAssociatedLic') {}
        * def CountyName = "New York"
        * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {county:'#(CountyName)'}
        * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
        * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
        * call read('LicensesCommonMethods.feature@FillAndSaveMethodOfOperationPage') {}
        * call read('LicensesCommonMethods.feature@FeesValidation') {amount:'#(totalFees)'}
        * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	   	 * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {}
        * call read('LicensesCommonMethods.feature@ExaminerReviewApprovalToLB') {}
        * call read('LicensesCommonMethods.feature@LBClaimingQueue') {}
         * def expirationDate = fundDueDateFunc(10)
        * call read('LicensesCommonMethods.feature@LBApprovalWithDueDate') {approvalName:'Approved', expStatus:'Approved'}
        * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Approved'}
	   	  * def SearchByLegalName = false
	   	* def SearchByLicId = true
	    
	   	* def amendmentCode = getAmendmentTypeIdFunc(amendmentType)
	   	* def termInYears = 3
	   	* def termDesc = termInYears +' Year (s)'
	   * call read('LicensesCommonMethods.feature@GetLicenseId') {} 
	   	 And print licenseId
	   * call read('LicensesCommonMethods.feature@SearchLicPermitIdForAmendment') {LicensePermitId:'#(licenseId)'}
	   * call read('LicensesCommonMethods.feature@IntakeAmendment') {}
	   * call read('LicensesCommonMethods.feature@saveABCOfficerForm') {}
	  	* def amendmentType = 'ABC Officer'
	  	
	   * call read('LicensesCommonMethods.feature@AmendmentFeeValidation') {amount:128}
	   * call read('LicensesCommonMethods.feature@UploadDocumentAmendment') {}
	  
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	   * def AMDfundDueDate = fundDueDateFunc(10)
	    * def AMDfundDueDate1 = fundDueDateFunc1(10)
	   
	 	* call read('LicensesCommonMethods.feature@IsPaymentFailedAmendmentScenario') {expStatus:'Awaiting Additional Funds'}
		
	    * call read('LicensesCommonMethods.feature@GetAndValidateDueDateForLicense') {licAction:'Payment Failed',appStatus:'Awaiting Additional Funds',dueDate:'#(AMDfundDueDate1)'}
	    * def typeOfNotification = 'Returned_Check'
	    * def fileName = typeOfNotification + '.pdf'
	    * def wait = waitFunc(60)
	    * call read('LicensesCommonMethods.feature@EMailNotificationDataValidation') {}
	  
	  	* def documentDesc = typeOfNotification
	    

		* def actualFilePath = "C:/eclipse-workspace/SVAMInternalAPI/" + documentDesc + ".pdf"
		* call read('LicensesCommonMethods.feature@getPDFFileDataAndSave') {actualFilePath:'#(actualFilePath)'}
	   	* def mmyydateFundDueDate = getFundDueDateMMYYDate(7)
		* def expectedData = db.readPDFFileData(actualFilePath)
		And print expectedData
		* match expectedData contains 'Vincent G. Bradley'
		* match expectedData contains 'Greeley T. Ford'
		* match expectedData contains 'Kathy Hochul'
		* match expectedData contains 'Lily M. Fan'
		* match expectedData contains ':Application ID: '+ApplicationId
		* match expectedData contains mmmmdate
		* match expectedData contains 'Dear Sir or Madam:'
		* match expectedData contains 'Your check/money order(s) listed below were returned to us because of insufficient funds'
		* match expectedData contains 'Please submit to this office no later than '+mmyydateFundDueDate
	
	  
	     ## ******************** UC_LIC_ExamnerReviewToLB: Validate TC0001_NYC_SLA_LIC_AMD_Update_Application_Send_Notification Scenario End ***************************##   
	
	
	
 Examples:
    | read('/CSVFiles/Uc_22_TC0005_NYC_SLA_LIC_Under_Payment.csv') |
    
 
 

 	 	          

 @TC0002_NYC_SLA_AMD_Intake_New_Payment	  
 Scenario Outline: TC0002_NYC_SLA_AMD_Intake_New_Payment
   
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
	   ## ******************** UC_LIC_ExamnerReviewToLB: Validate TC0002_NYC_SLA_AMD_Intake_New_Payment Scenario Start ***************************##
	   
	  * def SearchByLegalName = false
	   	* def SearchByLicId = true
	   	* def amendmentType = 'ABC Officer'
	   	* def appType = 'AO-'
	   	* def termInYears = 3
	   	
	   	* def termDesc = termInYears +' Year (s)'
	   	* def typeOfNotification = 'Letter_Fingerprinting_Instructions'
	   	* def fileName = 'Letter_Fingerprinting_Instructions.pdf'
	   	
	   	* call read('LicensesCommonMethods.feature@IntakeLicensewithoutAssociatedLic') {}
        * def CountyName = "New York"
        * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {county:'#(CountyName)'}
        * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
        * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
        * call read('LicensesCommonMethods.feature@FillAndSaveMethodOfOperationPage') {}
        * call read('LicensesCommonMethods.feature@FeesValidation') {amount:'#(totalFees)'}
        * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	   	 * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {}
        * call read('LicensesCommonMethods.feature@ExaminerReviewApprovalToLB') {}
        * call read('LicensesCommonMethods.feature@LBClaimingQueue') {}
         * def expirationDate = fundDueDateFunc(10)
        * call read('LicensesCommonMethods.feature@LBApprovalWithDueDate') {approvalName:'Approved', expStatus:'Approved'}
        * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Approved'}
	   	  * def SearchByLegalName = false
	   	* def SearchByLicId = true
	    
	   	* def amendmentCode = getAmendmentTypeIdFunc(amendmentType)
	   	* def termInYears = 3
	   	* def termDesc = termInYears +' Year (s)'
	   * call read('LicensesCommonMethods.feature@GetLicenseId') {} 
	   	 And print licenseId
	   * call read('LicensesCommonMethods.feature@SearchLicPermitIdForAmendment') {LicensePermitId:'#(licenseId)'}
	   * call read('LicensesCommonMethods.feature@IntakeAmendment') {}
	   * call read('LicensesCommonMethods.feature@saveABCOfficerForm') {}
	  	* def amendmentType = 'ABC Officer'
	  	
	   * call read('LicensesCommonMethods.feature@AmendmentFeeValidation') {amount:128}
	   * call read('LicensesCommonMethods.feature@UploadDocumentAmendment') {}
	  
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	   * def AMDfundDueDate = fundDueDateFunc(10)
	    * def AMDfundDueDate1 = fundDueDateFunc1(10)
	   
	 	* call read('LicensesCommonMethods.feature@IsPaymentFailedAmendmentScenario') {expStatus:'Awaiting Additional Funds'}
		
	    * call read('LicensesCommonMethods.feature@GetAndValidateDueDateForLicense') {licAction:'Payment Failed',appStatus:'Awaiting Additional Funds',dueDate:'#(AMDfundDueDate1)'}
	   
	   
	   
	    * def previousAmount =  amount+ ".00"
	    * def totalAmount = ~~Math.round(amount+100)
	    * def totalAmountStr = totalAmount+".00"
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AmendmentFillFeesFormwithPaymentAfterPaymentFailed') {previousAmount:'#(previousAmount)',isPaymentFailed:true,totalAmount:'#(totalAmount)'}
	    * call read('LicensesCommonMethods.feature@SearchLicenseApplicationByCriteria') {expLicStatus:'Awaiting Review'}
	    
	  
	     ## ******************** UC_LIC_ExamnerReviewToLB: Validate TC0002_NYC_SLA_AMD_Intake_New_Payment Scenario End ***************************##   
	
	
	
 Examples:
    | read('/CSVFiles/Uc_22_TC0005_NYC_SLA_LIC_Under_Payment.csv') |
    
    
    
 @TC0003_NYC_SLA_AMD_Insufficient_Funds_received	  
 Scenario Outline: TC0003_NYC_SLA_AMD_Insufficient_Funds_received
   
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
	   ## ******************** UC_LIC_ExamnerReviewToLB: Validate TC0003_NYC_SLA_AMD_Insufficient_Funds_received Scenario Start ***************************##
	   
	  * def SearchByLegalName = false
	   	* def SearchByLicId = true
	   	* def amendmentType = 'ABC Officer'
	   	* def appType = 'AO-'
	   	* def termInYears = 3
	   	
	   	* def termDesc = termInYears +' Year (s)'
	   	* def typeOfNotification = 'Letter_Fingerprinting_Instructions'
	   	* def fileName = 'Letter_Fingerprinting_Instructions.pdf'
	   	
	   	* call read('LicensesCommonMethods.feature@IntakeLicensewithoutAssociatedLic') {}
        * def CountyName = "New York"
        * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {county:'#(CountyName)'}
        * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
        * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
        * call read('LicensesCommonMethods.feature@FillAndSaveMethodOfOperationPage') {}
        * call read('LicensesCommonMethods.feature@FeesValidation') {amount:'#(totalFees)'}
        * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	   	 * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {}
        * call read('LicensesCommonMethods.feature@ExaminerReviewApprovalToLB') {}
        * call read('LicensesCommonMethods.feature@LBClaimingQueue') {}
         * def expirationDate = fundDueDateFunc(0)
        * call read('LicensesCommonMethods.feature@LBApprovalWithDueDate') {approvalName:'Approved', expStatus:'Approved'}
        * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Approved'}
	   	  * def SearchByLegalName = false
	   	* def SearchByLicId = true
	    
	   	* def amendmentCode = getAmendmentTypeIdFunc(amendmentType)
	   	* def termInYears = 3
	   	* def termDesc = termInYears +' Year (s)'
	   * call read('LicensesCommonMethods.feature@GetLicenseId') {} 
	   	 And print licenseId
	   * call read('LicensesCommonMethods.feature@SearchLicPermitIdForAmendment') {LicensePermitId:'#(licenseId)'}
	   * call read('LicensesCommonMethods.feature@IntakeAmendment') {}
	   * call read('LicensesCommonMethods.feature@saveABCOfficerForm') {}
	  	* def amendmentType = 'ABC Officer'
	  	
	   * call read('LicensesCommonMethods.feature@AmendmentFeeValidation') {amount:128}
	   * call read('LicensesCommonMethods.feature@UploadDocumentAmendment') {}
	  
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	   * def AMDfundDueDate = fundDueDateFunc(10)
	    * def AMDfundDueDate1 = fundDueDateFunc1(10)
	   
	 	* call read('LicensesCommonMethods.feature@IsPaymentFailedAmendmentScenario') {expStatus:'Awaiting Additional Funds'}
		
	    * call read('LicensesCommonMethods.feature@GetAndValidateDueDateForLicense') {licAction:'Payment Failed',appStatus:'Awaiting Additional Funds',dueDate:'#(AMDfundDueDate1)'}
	   
	   
	    * def underpay = 30
	    * def previousAmount =  amount+ ".00"
	    * def totalAmount = ~~Math.round(amount - underpay)
	   
	    * def totalAmountStr = totalAmount+".00"
	    * def isPaymentFailed = true
	   * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	   * call read('LicensesCommonMethods.feature@AmendmentFillFeesFormwithPaymentAfterPaymentFailed') {previousAmount:'#(previousAmount)',totalAmount:'#(totalAmount)'}
	    * call read('LicensesCommonMethods.feature@SearchLicenseApplicationByCriteria') {expLicStatus:'Awaiting Additional Funds'}
		
	     ## ******************** UC_LIC_ExamnerReviewToLB: Validate TC0003_NYC_SLA_AMD_Insufficient_Funds_received Scenario End ***************************##   
	
	
	
 Examples:
    | read('/CSVFiles/Uc_22_TC0005_NYC_SLA_LIC_Under_Payment.csv') |		 	  	 	  
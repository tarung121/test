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
		* def fundDueDateFuncRenewal =
		  """
			  function(days) {
			    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
			    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
			    
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

	* def dateFnc =
		"""
		  function(days) {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd");
		     var date = new java.util.Date();
		     var dayAfter = new java.util.Date( date.getTime() - java.util.concurrent.TimeUnit.DAYS.toMillis( days));
		    return sdf.format(dayAfter);
		  } """
	 	
  
@TC0001_SLA_REN_ReturnCheck_Payment_failed_Awaiting__Review_License
Scenario Outline: SLA_REN_Lic_AssignToExaminer
   
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
		* def totalFees = licenseFees+fillingFees+licAncillaryFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_RenewalExaminerReview: Validate SLA_REN_Lic_AssignToExaminer Scenario Start ***************************##
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
	   	
	   * call read('LicensesCommonMethods.feature@GetLicenseId') {} 
	   	 And print licenseId
	   	 * def notQualifiedApplication = false
	   	 * def notQlfdAppMessage = ''
	   	 * def LicensePermitId = licenseId
	   * call read('RenewalCommonMethods.feature@IntakeRenewalLicense') {}
	   * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {}
	  
	   * call read('RenewalCommonMethods.feature@SaveAssociatedPrincipal') {}
	   * call read('RenewalCommonMethods.feature@RenewalLicFillingFee') {amount:40000}
	   * call read('LicensesCommonMethods.feature@UploadDocumentAmendment') {}
	    
	   * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	   	  * def licPerType = 'license'
	   	 * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	     
	   	 ## ******************** UC_RenewalExaminerReview: Validate SLA_REN_Lic_AssignToExaminer  Scenario End ***************************##   
	
	
	
 Examples:
    | read('/CSVFiles/RenewalOnPremises.csv') |  
    
    
    
 @SLA_REN_Permit_AssignToExaminer	  
 Scenario Outline: SLA_REN_Permit_AssignToExaminer
   
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
		* def totalFees = licenseFees+fillingFees+licAncillaryFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_RenewalExaminerReviewApp: Validate SLA_REN_Permit_AssignToExaminer Scenario Start ***************************##
	   	* call read('PermitsCommonMethods.feature@IntakeStandalonePermitwithoutLic') {}
        
        * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('LicensesCommonMethods.feature@FeesValidation') {amount:'#(totalFees)'}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	
		* call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	     
	    * call read('PermitsCommonMethods.feature@PermitExaminerReview') {isFingerPrintsApproved:true,isFingerPrintsRequired:false,expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
	    * call read('LicensesCommonMethods.feature@AddLicenseClaimingQueue') {}
		* def licStatus = 'Approved'
		* def expStatus = 'Approved'
		* def checboxDisapprovalCause = false
		* call read('PermitsCommonMethods.feature@PermitLBDecisions') {StipulationsCount:0}
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Approved'}
		# * def waiting = waitFunc(20000)
	    # * def subject = 'Approval'
	    # * call read('PermitsCommonMethods.feature@ValidatePermitCommunicationPage') {typeOfNotification:'Approval'}
	    
	    
	   * call read('LicensesCommonMethods.feature@GetLicenseId') {} 
	   	 And print licenseId
	   	 * def notQualifiedApplication = false
	   	 * def notQlfdAppMessage = ''
	   * call read('RenewalCommonMethods.feature@IntakeRenewalLicense') {}
	   * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {}
	   * call read('RenewalCommonMethods.feature@SaveAssociatedPrincipal') {}
	   * call read('RenewalCommonMethods.feature@RenewalLicFillingFee') {amount:40000}
	   * call read('LicensesCommonMethods.feature@UploadDocumentAmendment') {}
	   * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	   	 * def SafekeepingStatus = false
	   	 * def licPerType = 'permit'
	   	 * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	  ## ******************** UC_RenewalExaminerReviewApp: Validate SLA_REN_Permit_AssignToExaminer Scenario End ***************************##   
	
	
	
 Examples:
    | read('/CSVFiles/RenewalStandalonePermit.csv') | 
    
    
     
    
    
@TC0001_SLA_REN_ReturnCheck_Payment_failed_Awaiting_Review_License
Scenario: TC0001_SLA_REN_ReturnCheck_Payment_failed_Awaiting_Review_License
   	## ******************** UC_RenewalExaminerReview: Validate TC0001_SLA_REN_ReturnCheck_Payment_failed_Awaiting__Review_License Scenario Start ***************************##
	   	* call read('Uc_RenewalDueDate.feature@SLA_REN_Lic_AssignToExaminer') {}
	   
	   	* call read('LicensesCommonMethods.feature@IsPaymentFailedScenario'){'dueDateCount':10,expStatus:'Awaiting Additional Funds'}
	  
	## ******************** UC_RenewalExaminerReview: Validate TC0001_SLA_REN_ReturnCheck_Payment_failed_Awaiting__Review_License  Scenario End ***************************##   

    
   @TC0001a_SLA_REN_Return_Check_Paymentfailed_Awaiting_Review_Permit
Scenario: TC0001a_SLA_REN_Return_Check_Paymentfailed_Awaiting_Review_Permit
   	## ******************** UC_RenewalExaminerReview: Validate TC0001a_SLA_REN_Return_Check_Paymentfailed_Awaiting_Review_Permit Scenario Start ***************************##
	   	* call read('Uc_RenewalDueDate.feature@SLA_REN_Permit_AssignToExaminer') {}
	   
	   	* call read('LicensesCommonMethods.feature@IsPaymentFailedScenario'){'dueDateCount':10,expStatus:'Awaiting Additional Funds'}
	  
	## ******************** UC_RenewalExaminerReview: Validate TC0001a_SLA_REN_Return_Check_Paymentfailed_Awaiting_Review_Permit  Scenario End ***************************##   
  
  
   
    
@TC0002_SLA_REN_ReturnCheck_Intake_Payment_Awaiting_Additional_Funds_License
Scenario: TC0002_SLA_REN_ReturnCheck_Intake_Payment_Awaiting_Additional_Funds_License
   	## ******************** UC_RenewalExaminerReview: Validate TC0002_SLA_REN_ReturnCheck_Intake_Payment_Awaiting_Additional_Funds_License Scenario Start ***************************##
	   	* call read('Uc_RenewalDueDate.feature@SLA_REN_Lic_AssignToExaminer') {}
	   	And print totalFees
	 	* call read('LicensesCommonMethods.feature@IsPaymentFailedScenario'){'dueDateCount':10,expStatus:'Awaiting Additional Funds'}
		* def fundDueDate1 = fundDueDateFunc1(10)
	  	* call read('LicensesCommonMethods.feature@GetAndValidateDueDateForLicense') {licAction:'Payment Failed',appStatus:'Awaiting Additional Funds',dueDate:'#(fundDueDate1)'}
	    * def isPaymentFailed = true
	    * def previousAmount =  amount+ ".00"
	    * def totalAmount = ~~Math.round(totalFees+100)
	     * def totalFeesStr = totalFees+".00"
	    * def totalAmountStr = totalAmount+".00"
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
	    * call read('RenewalCommonMethods.feature@RenewalFillFeesFormwithPaymentAfterPaymentFailedUpdated') {previousAmount:'#(previousAmount)',isPaymentFailed:true,totalAmount:'#(totalAmount)'}
	    * call read('LicensesCommonMethods.feature@checkApplicationStatus') {expLicStatus:'Under Review'}
	    
	   
	## ******************** UC_RenewalExaminerReview: Validate TC0002_SLA_REN_ReturnCheck_Intake_Payment_Awaiting_Additional_Funds_License  Scenario End ***************************##   
 
   
@TC0002a_SLA_REN_ReturnCheck_Intake_Payment_Awaiting_Additional_Funds_Permit
Scenario: TC0002a_SLA_REN_ReturnCheck_Intake_Payment_Awaiting_Additional_Funds_Permit
   	## ******************** UC_RenewalExaminerReview: Validate TC0002a_SLA_REN_ReturnCheck_Intake_Payment_Awaiting_Additional_Funds_Permit Scenario Start ***************************##
	   * call read('Uc_RenewalDueDate.feature@SLA_REN_Permit_AssignToExaminer') {}
	   	And print totalFees
	 	* call read('LicensesCommonMethods.feature@IsPaymentFailedScenario'){'dueDateCount':10,expStatus:'Awaiting Additional Funds'}
		* def fundDueDate1 = fundDueDateFunc1(10)
	  	* call read('LicensesCommonMethods.feature@GetAndValidateDueDateForLicense') {licAction:'Payment Failed',appStatus:'Awaiting Additional Funds',dueDate:'#(fundDueDate1)'}
	    * def isPaymentFailed = true
	    * def previousAmount =  amount+ ".00"
	    * def totalAmount = ~~Math.round(totalFees+100)
	     * def totalFeesStr = totalFees+".00"
	    * def totalAmountStr = totalAmount+".00"
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
	    * call read('RenewalCommonMethods.feature@RenewalFillFeesFormwithPaymentAfterPaymentFailedUpdated') {previousAmount:'#(previousAmount)',isPaymentFailed:true,totalAmount:'#(totalAmount)'}
	    * call read('LicensesCommonMethods.feature@checkApplicationStatus') {expLicStatus:'Under Review'}
	    
	   
	## ******************** UC_RenewalExaminerReview: Validate TC0002a_SLA_REN_ReturnCheck_Intake_Payment_Awaiting_Additional_Funds_Permit  Scenario End ***************************##   
            	 			 	  	 	  
       	
       	
       	
       	
       	
       	 			 	  	 	  
  
@TC0004_SLA_REN_ReturnCheck_Intake_Payment_Awaiting_Additional_Funds_insufficient_fund_received_License
Scenario: TC0004_SLA_REN_ReturnCheck_Intake_Payment_Awaiting_Additional_Funds_insufficient_fund_received_License
   	## ******************** UC_RenewalExaminerReview: Validate TC0004_SLA_REN_ReturnCheck_Intake_Payment_Awaiting_Additional_Funds_insufficient_fund_received_License Scenario Start ***************************##
	   	* call read('Uc_RenewalDueDate.feature@SLA_REN_Lic_AssignToExaminer') {}
	   	And print totalFees
	 	* call read('LicensesCommonMethods.feature@IsPaymentFailedScenario'){'dueDateCount':10,expStatus:'Awaiting Additional Funds'}
		* def fundDueDate1 = fundDueDateFunc1(10)
	  	* call read('LicensesCommonMethods.feature@GetAndValidateDueDateForLicense') {licAction:'Payment Failed',appStatus:'Awaiting Additional Funds',dueDate:'#(fundDueDate1)'}
	    * def isPaymentFailed = true
	    * def previousAmount =  amount+ ".00"
	    * def totalAmount = 100
	     * def totalFeesStr = totalFees+".00"
	    * def totalAmountStr = totalAmount+".00"
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
	    * call read('LicensesCommonMethods.feature@FillFeesFormwithPaymentAfterPaymentFailed') {previousAmount:'#(previousAmount)',isPaymentFailed:true,totalAmount:'#(totalAmount)'}
	    * call read('LicensesCommonMethods.feature@checkApplicationStatus') {expLicStatus:'Awaiting Additional Funds'}
	    
	   
	## ******************** UC_RenewalExaminerReview: Validate TC0004_SLA_REN_ReturnCheck_Intake_Payment_Awaiting_Additional_Funds_insufficient_fund_received_License  Scenario End ***************************##   
 
   
@TC0004a_SLA_REN_ReturnCheck_Intake_Payment_Awaiting_Additional_Funds_insufficient_fund_received_Permit
Scenario: TC0004a_SLA_REN_ReturnCheck_Intake_Payment_Awaiting_Additional_Funds_insufficient_fund_received_Permit
   	## ******************** UC_RenewalExaminerReview: Validate TC0004a_SLA_REN_ReturnCheck_Intake_Payment_Awaiting_Additional_Funds_insufficient_fund_received_Permit Scenario Start ***************************##
	   * call read('Uc_RenewalDueDate.feature@SLA_REN_Permit_AssignToExaminer') {}
	   	And print totalFees
	 	* call read('LicensesCommonMethods.feature@IsPaymentFailedScenario'){'dueDateCount':10,expStatus:'Awaiting Additional Funds'}
		* def fundDueDate1 = fundDueDateFunc1(10)
	  	* call read('LicensesCommonMethods.feature@GetAndValidateDueDateForLicense') {licAction:'Payment Failed',appStatus:'Awaiting Additional Funds',dueDate:'#(fundDueDate1)'}
	    * def isPaymentFailed = true
	    * def previousAmount =  amount+ ".00"
	    * def totalAmount = ~~Math.round(totalFees-200)
	     * def totalFeesStr = totalFees+".00"
	    * def totalAmountStr = totalAmount+".00"
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
	    * call read('LicensesCommonMethods.feature@FillFeesFormwithPaymentAfterPaymentFailed') {previousAmount:'#(previousAmount)',isPaymentFailed:true,totalAmount:'#(totalAmount)'}
	    * call read('LicensesCommonMethods.feature@checkApplicationStatus') {expLicStatus:'Awaiting Additional Funds'}
	    
	## ******************** UC_RenewalExaminerReview: Validate TC0004a_SLA_REN_ReturnCheck_Intake_Payment_Awaiting_Additional_Funds_insufficient_fund_received_Permit  Scenario End ***************************##   
            	 			 	      	 			 	  	 	          	 			 	      	 			 	  	 	  
Feature: Renewal LB Decision Feature
Background:
			* url BaseURL
  		* def config = { username: '#(dbUserName)', password:'#(dbUserPassword)', url: '#(dbQuery)',driverClassName: 'com.microsoft.sqlserver.jdbc.SQLServerDriver' }
    	* def DbUtils = Java.type('utils.DbUtils')
    	* def db = new DbUtils(config)
    	    	* def getExpiryDateFunc =
            """
          function(termsInyears) {
          java.lang.System.out.print("termsInyears"+termsInyears);
          var today = new java.util.Date(); 
             var calendar = java.util.Calendar.getInstance();  
          calendar.setTime(today);  
          calendar.add(java.util.Calendar.MONTH, 1);  
          calendar.set(java.util.Calendar.DAY_OF_MONTH, 1);  
          calendar.add(java.util.Calendar.DATE, -1);  
          var lastDayOfMonth = calendar.getTime();  
          var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
          var sdf = new SimpleDateFormat("yyyy-MM-dd");  
          var dayAfter = new java.util.Date(lastDayOfMonth + java.util.concurrent.TimeUnit.DAYS.toMillis( 365*termsInyears));
          return sdf.format(dayAfter);
          } 
          """
          
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
  	  
  	  * def dateFnc =
		"""
		  function(days) {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd");
		     var date = new java.util.Date();
		     var dayAfter = new java.util.Date( date.getTime() - java.util.concurrent.TimeUnit.DAYS.toMillis( days));
		    return sdf.format(dayAfter);
		  } """

 @TC0002A_SLA_REN_Examiner_to_LB_review_Common_Digest_Permit
 Scenario Outline: TC0002A_SLA_REN_Examiner_to_LB_review_Common_Digest_Permit
   
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
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees+licAncillaryFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0002A_SLA_REN_Examiner_review_Common_Digest_Permit Scenario Start ***************************##
	   	* call read('LicensesCommonMethods.feature@IntakeStandalonePermitwithoutLic') {}
        
        * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('LicensesCommonMethods.feature@FeesValidation') {amount:'#(totalFees)'}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	
		* call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	     
	    * call read('LicensesCommonMethods.feature@PermitExaminerReview') {isFingerPrintsApproved:true,isFingerPrintsRequired:false,expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
	    * call read('LicensesCommonMethods.feature@AddLicenseClaimingQueue') {}
		* def licStatus = 'Approved'
		* def expStatus = 'Approved'
		* def checboxDisapprovalCause = false
		* call read('LicensesCommonMethods.feature@PermitLBDecisions') {StipulationsCount:0}
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Approved'}
		# * def waiting = waitFunc(20000)
	    # * def subject = 'Approval'
	    # * call read('LicensesCommonMethods.feature@ValidatePermitCommunicationPage') {typeOfNotification:'Approval'}
	    
	    
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
	            
	     ## ******************** UC_Renewal_LBDescision : Validate TC0002A_SLA_REN_Examiner_to_LB_review_Common_Digest_Permit Scenario End ***************************##   
	
     
Examples:
    | read('/CSVFiles/RenewalStandalonePermit.csv') |   
    
    
    
     @TC0002A_SLA_REN_Examiner_to_LB_review_On_Premises_Digest
 Scenario Outline: TC0002A_SLA_REN_Examiner_to_LB_review_On_Premises_Digest
 * def frmtDate1 = dateFnc(32)
   * def frmtDate2 = dateFnc(0)
   And print frmtDate1
   And print frmtDate2
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
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees+licAncillaryFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_Renewal_LBDescision: Validate TC0002A_SLA_REN_Examiner_to_LB_review_On_Premises_Digest Scenario Start ***************************##
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
	   * call read('RenewalCommonMethods.feature@IntakeRenewalLicense') {}
	   * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {}
	  
	   * call read('RenewalCommonMethods.feature@SaveAssociatedPrincipal') {}
	   * call read('RenewalCommonMethods.feature@RenewalLicFillingFee') {amount:40000}
	   * call read('LicensesCommonMethods.feature@UploadDocumentAmendment') {}
	   
	   
	   * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	   	  
	   	  * def licPerType = 'license'
	   	 * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	     * def frmtDate = dateFnc(32)
	     * call read('LicensesCommonMethods.feature@SaveDigestData') {}
	     
	     * call read('RenewalCommonMethods.feature@RenewalLicenseExaminerReviewApprovalToLB') 
	    ## * call read('RenewalCommonMethods.feature@RenewalExaminerReviewApprovalToLB')   
	        
	      * call read('LicensesCommonMethods.feature@AddLicenseClaimingQueue')
	      * call read('LicensesCommonMethods.feature@searchAndValidateLBClaimingQueue')
	    ##  * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Approved'}
	   
	   
	      ## ******************** UC_Renewal_LBDescision: Validate TC0002A_SLA_REN_Examiner_to_LB_review_On_Premises_Digest  Scenario End ***************************##   
	
	
 Examples:
    | read('/CSVFiles/RenewalOnPremises.csv') |
    
    
    @TC0002A_SLA_REN_LB_review_Common
    Scenario Outline: TC0002A_SLA_REN_LB_review_Common
  ## ******************** UC_Renewal_LBDescision: Validate TC0002A_SLA_REN_LB_review_Common Scenario Start ***************************##
	      
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
	    * def CountyName = <countynames>	
		  * def totalFees = licenseFees+fillingFees+licAncillaryFees
	    * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_Renewal_LBDescision: Validate TC0002A_SLA_REN_LB_review_Common Scenario Start ***************************##
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
	   * call read('RenewalCommonMethods.feature@IntakeRenewalLicense') {}
	   * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {}
	  
	   * call read('RenewalCommonMethods.feature@SaveAssociatedPrincipal') {}
	   * call read('RenewalCommonMethods.feature@RenewalLicFillingFee') {amount:40000}
	   * call read('LicensesCommonMethods.feature@UploadDocumentAmendment') {}
	   
	   
	   * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	   	  * def SafekeepingStatus = false
	   	  * def licPerType = 'license'
	   	 * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	     * def frmtDate = dateFnc(0)
	     * call read('LicensesCommonMethods.feature@SaveDigestData') {}
	     
	     * call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApprovalToLB')
	     
	      * call read('LicensesCommonMethods.feature@AddLicenseClaimingQueue')
	      * call read('LicensesCommonMethods.feature@searchAndValidateLBClaimingQueue')
	      * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus'){LicAppStatus:'Under Review'}
	    ##  * call read('LicensesCommonMethods.feature@GetPreFillLicenseAllDetailsByLicenseId')  
    
	     ## ******************** UC_Renewal_LBDescision: Validate TC0002A_SLA_REN_LB_review_Common Scenario End ***************************## 
Examples:
    | read('/CSVFiles/RenewalOnPremises.csv') |
    
 
 
 @TC0001_SLA_REN_LB_Decision_Approve
 Scenario: TC0001_SLA_REN_LB_Decision_Approve
  ## ******************** UC_Renewal_LBDescision: Validate TC0001_SLA_REN_LB_Decision_Approve Scenario Start ***************************##
	      
	   	* call read('Uc_Renewal_LBDecision.feature@TC0002A_SLA_REN_LB_review_Common') {}	 
	   	* call read('RenewalCommonMethods.feature@LBDecisionApprovalNotification')
	   * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Approved'}
	  ##	* call read('LicensesCommonMethods.feature@GetPreFillLicenseAllDetailsByLicenseId')  
	 	  
	     ## ******************** UC_Renewal_LBDescision: Validate TC0001_SLA_REN_LB_Decision_Approve Scenario End ***************************## 

  
  @TC0002_SLA_REN_LB_Decision_Approve_Define_Provisions_Removal
    Scenario: TC0002_SLA_REN_LB_Decision_Approve_Define_Provisions_Removal
  ## ******************** UC_Renewal_LBDescision: Validate TC0002_SLA_REN_LB_Decision_Approve_Define_Provisions_Removal Scenario Start ***************************##
	      
	    	* call read('Uc_Renewal_LBDecision.feature@TC0002A_SLA_REN_LB_review_Common') {}
	    	#  * call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproval') {expStatus:'Approved'} 
	    	* call read('RenewalCommonMethods.feature@LBDecisionApprovalNotificationYesDefineProvisions')  {expStatus:'Awaiting Review'}
	    	* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Approved'}
	  ##	 * call read('LicensesCommonMethods.feature@GetPreFillLicenseAllDetailsByLicenseId')  
  
	     ## ******************** UC_Renewal_LBDescision: Validate TC0002_SLA_REN_LB_Decision_Approve_Define_Provisions_Removal Scenario End ***************************## 

     @TC0003_SLA_REN_LB_Decision_Approve_Define_Provisions_CorporateChange
    Scenario: TC0003_SLA_REN_LB_Decision_Approve_Define_Provisions_CorporateChange
  ## ******************** UC_Renewal_LBDescision: Validate TC0003_SLA_REN_LB_Decision_Approve_Define_Provisions_CorporateChange Scenario Start ***************************##
	      
	    	* call read('Uc_Renewal_LBDecision.feature@TC0002A_SLA_REN_LB_review_Common') {}
        * def SafekeepingStatus = false
	   	  * def licPerType = 'CorporateChange'   
	   	 # * call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproval') {expStatus:'Approved'}
	   	  * call read('LicensesCommonMethods.feature@RenewalPermitExaminerReviewApprovalToLBDefineProvisionsCorporateChange') {expStatus:'Approved'}
	   	  * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
  
	     ## ******************** UC_Renewal_LBDescision: Validate TC0003_SLA_REN_LB_Decision_Approve_Define_Provisions_CorporateChange Scenario End ***************************## 
  
    
     @TC0004_SLA_REN_LB_Decision_Approve_Define_Provisions_Alteration
    Scenario: TC0004_SLA_REN_LB_Decision_Approve_Define_Provisions_Alteration
  ## ******************** UC_Renewal_LBDescision: Validate TC0004_SLA_REN_LB_Decision_Approve_Define_Provisions_Alteration Scenario Start ***************************##
	      
	    	* call read('Uc_Renewal_LBDecision.feature@TC0002A_SLA_REN_LB_review_Common') {}
        * def SafekeepingStatus = false
	   	  * def licPerType = 'Alteration'  
	   	#  * call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproval') {expStatus:'Approved'}
	      * call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApprovalToLBDefineProvisionsAlteration1') {expStatus:'Awaiting Review'}
	   	  * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
       
         
	     ## ******************** UC_Renewal_LBDescision: Validate TC0004_SLA_REN_LB_Decision_Approve_Define_Provisions_Alteration Scenario End ***************************## 

    @TC0005_SLA_REN_LB_Decision_Approve_Define_Provisions_Endorsement
    Scenario: TC0005_SLA_REN_LB_Decision_Approve_Define_Provisions_Endorsement
  ## ******************** UC_Renewal_LBDescision: Validate TC0005_SLA_REN_LB_Decision_Approve_Define_Provisions_Endorsement Scenario Start ***************************##
	      
	    	* call read('Uc_Renewal_LBDecision.feature@TC0002A_SLA_REN_LB_review_Common') {}
        * def SafekeepingStatus = false
	   	  * def licPerType = 'Endorsement'   
	   	#  * call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproval') {expStatus:'Approved'}
	    	* call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApprovalToLBDefineProvisionsEndorsement1') {expStatus:'Awaiting Review'}
	   	  * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
          
	     ## ******************** UC_Renewal_LBDescision: Validate TC0005_SLA_REN_LB_Decision_Approve_Define_Provisions_Endorsement Scenario End ***************************## 

    
    
    @TC0006_SLA_REN_LB_Decision_Approve_Safekeeping
      Scenario: TC0006_SLA_REN_LB_Decision_Approve_Safekeeping
  ## ******************** UC_Renewal_LBDescision: Validate TC0006_SLA_REN_LB_Decision_Approve_Safekeeping Scenario Start ***************************##
	      
	    	* call read('Uc_Renewal_LBDecision.feature@TC0002A_SLA_REN_LB_review_Common') {}
        * def SafekeepingStatus = true
	   	  * def licPerType = 'license'
	   	  * call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApprovalWithSafekeeping1') 
	    	#* call read('LicensesCommonMethods.feature@GetPreFillLicenseAllDetailsByLicenseId')  
	   	  * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
  
	     ## ******************** UC_Renewal_LBDescision: Validate TC0006_SLA_REN_LB_Decision_Approve_Safekeeping Scenario End ***************************## 
  
     
    @TC0007_SLA_REN_LB_Decision_Approve_Safekeeping_Define_Provisions_Removal
      Scenario: TC0007_SLA_REN_LB_Decision_Approve_Safekeeping_Define_Provisions_Removal
  ## ******************** UC_Renewal_LBDescision: Validate TC0007_SLA_REN_LB_Decision_Approve_Safekeeping_Define_Provisions_Removal Scenario Start ***************************##
	      
	    	* call read('Uc_Renewal_LBDecision.feature@TC0002A_SLA_REN_LB_review_Common') {}
         * def SafekeepingStatus = true
	   	  * def licPerType = 'Removal'
	   	  * call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApprovalWithSafekeepingProvisionRemoval1') 
	    	#* call read('LicensesCommonMethods.feature@GetPreFillLicenseAllDetailsByLicenseId')  
	   	  * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
  
	     ## ******************** UC_Renewal_LBDescision: Validate TC0007_SLA_REN_LB_Decision_Approve_Safekeeping_Define_Provisions_Removal Scenario End ***************************## 
 
     @TC0008_SLA_REN_LB_Decision_Approve_Safekeeping_Define_Provisions_CorporateChange
      Scenario: TC0008_SLA_REN_LB_Decision_Approve_Safekeeping_Define_Provisions_CorporateChange
  ## ******************** UC_Renewal_LBDescision: Validate TC0008_SLA_REN_LB_Decision_Approve_Safekeeping_Define_Provisions_CorporateChange Scenario Start ***************************##
	      
	    	* call read('Uc_Renewal_LBDecision.feature@TC0002A_SLA_REN_LB_review_Common') {}
        * def SafekeepingStatus = true
	   	  * def licPerType = 'CorporateChange'
	   	  * call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApprovalWithSafekeepingProvisionCorporateChange1') 
	    	# * call read('LicensesCommonMethods.feature@GetPreFillLicenseAllDetailsByLicenseId')  
	   	  * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
  
	     ## ******************** UC_Renewal_LBDescision: Validate TC0008_SLA_REN_LB_Decision_Approve_Safekeeping_Define_Provisions_CorporateChange Scenario End ***************************## 

    
    
    @TC0009_SLA_REN_LB_Decision_Approve_Safekeeping_Define_Provisions_Alteration
      Scenario: TC0009_SLA_REN_LB_Decision_Approve_Safekeeping_Define_Provisions_Alteration
  ## ******************** UC_Renewal_LBDescision: Validate TC0009_SLA_REN_LB_Decision_Approve_Safekeeping_Define_Provisions_Alteration Scenario Start ***************************##
	      
	    	* call read('Uc_Renewal_LBDecision.feature@TC0002A_SLA_REN_LB_review_Common') {}
        * def SafekeepingStatus = true
	   	  * def licPerType = 'CorporateChange'
	   	  * call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApprovalWithSafekeepingProvisionAlteration1') 
	    	# * call read('LicensesCommonMethods.feature@GetPreFillLicenseAllDetailsByLicenseId')  
	   	  * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
  
	     ## ******************** UC_Renewal_LBDescision: Validate TC0009_SLA_REN_LB_Decision_Approve_Safekeeping_Define_Provisions_Alteration Scenario End ***************************## 
 
    
    
     @TC0010_SLA_REN_LB_Decision_Approve_Safekeeping_Define_Provisions_Endorsement
      Scenario: TC0010_SLA_REN_LB_Decision_Approve_Safekeeping_Define_Provisions_Endorsement
  ## ******************** UC_Renewal_LBDescision: Validate TC0010_SLA_REN_LB_Decision_Approve_Safekeeping_Define_Provisions_Endorsement Scenario Start ***************************##
	      
	    	* call read('Uc_Renewal_LBDecision.feature@TC0002A_SLA_REN_LB_review_Common') {}
        * def SafekeepingStatus = true
	   	  * def licPerType = 'CorporateChange'
	   	  * call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApprovalWithSafekeepingProvisionEndorsement1') 
	    	# * call read('LicensesCommonMethods.feature@GetPreFillLicenseAllDetailsByLicenseId')  
	   	  * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
  
	     ## ******************** UC_Renewal_LBDescision: Validate TC0010_SLA_REN_LB_Decision_Approve_Safekeeping_Define_Provisions_Endorsement Scenario End ***************************## 
	     
	     
	       @TC0011_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice
      Scenario: TC0011_SLA_REN_LB_Decision_Approve_Referto_Counsel’sOffice
  ## ******************** UC_Renewal_LBDescision: Validate TC0011_SLA_REN_LB_Decision_Approve_Referto_Counsel’sOffice Scenario Start ***************************##
	      
	      * call read('Uc_Renewal_LBDecision.feature@TC0002A_SLA_REN_Examiner_to_LB_review_On_Premises_Digest') {}
	      * call read('RenewalCommonMethods.feature@LBDecisionApprovalNotificationCounselsOffice')
	      * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Approved'}
	       
	 	
	     ## ******************** UC_Renewal_LBDescision: Validate TC0011_SLA_REN_LB_Decision_Approve_Referto_Counsel’sOffice Scenario End ***************************## 
	      
	     

	       @TC0012_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_defineProvisions_Removal
      Scenario: TC0012_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_defineProvisions_Removal
  ## ******************** UC_Renewal_LBDescision: Validate TC0012_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_defineProvisions_Removal Scenario Start ***************************##
	      
	      * call read('Uc_Renewal_LBDecision.feature@TC0002A_SLA_REN_Examiner_to_LB_review_On_Premises_Digest') {}
	      * call read('RenewalCommonMethods.feature@LBDecisionApprovalNotificationCounselsOfficeDefineProvisionsRemoval')
	      * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Approved'}
	       
	 	
	     ## ******************** UC_Renewal_LBDescision: Validate TC0012_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_defineProvisions_Removal Scenario End ***************************## 
	      
	       @TC0013_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_defineProvisions_CorporateChange
      Scenario: TC0013_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_defineProvisions_CorporateChange
  ## ******************** UC_Renewal_LBDescision: Validate TC0013_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_defineProvisions_CorporateChange Scenario Start ***************************##
	      
	      * call read('Uc_Renewal_LBDecision.feature@TC0002A_SLA_REN_Examiner_to_LB_review_On_Premises_Digest') {}
	      * call read('RenewalCommonMethods.feature@LBDecisionApprovalNotificationCounselsOfficeDefineProvisionsCorporateChange')
	      * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Approved'}
	       
	 	
	     ## ******************** UC_Renewal_LBDescision: Validate TC0013_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_defineProvisions_CorporateChange Scenario End ***************************## 
    
      @TC0014_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_defineProvisions_Alteration
      Scenario: TC0014_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_defineProvisions_Alteration
  ## ******************** UC_Renewal_LBDescision: Validate TC0014_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_defineProvisions_Alteration Scenario Start ***************************##
	      
	      * call read('Uc_Renewal_LBDecision.feature@TC0002A_SLA_REN_Examiner_to_LB_review_On_Premises_Digest') {}
	      * call read('RenewalCommonMethods.feature@LBDecisionApprovalNotificationCounselsOfficeDefineProvisionsAlteration')
	      * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Approved'}
	       
	 	
	     ## ******************** UC_Renewal_LBDescision: Validate TC0014_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_defineProvisions_Alteration Scenario End ***************************##
    
    
      @TC0015_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_defineProvisions_Endorsement
      Scenario: TC0015_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_defineProvisions_Endorsement
  ## ******************** UC_Renewal_LBDescision: Validate TC0015_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_defineProvisions_Endorsement Scenario Start ***************************##
	      
	      * call read('Uc_Renewal_LBDecision.feature@TC0002A_SLA_REN_Examiner_to_LB_review_On_Premises_Digest') {}
	      * call read('RenewalCommonMethods.feature@LBDecisionApprovalNotificationCounselsOfficeDefineProvisionsEndorsement')
	      * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Approved'}
	       
	 	
	     ## ******************** UC_Renewal_LBDescision: Validate TC0015_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_defineProvisions_Endorsement Scenario End ***************************##
	     
	     
	     @TC0016_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_Safekeeping
      Scenario: TC0016_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_Safekeeping
  ## ******************** UC_Renewal_LBDescision: Validate TC0016_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_Safekeeping Scenario Start ***************************##
	      
	      * call read('Uc_Renewal_LBDecision.feature@TC0002A_SLA_REN_Examiner_to_LB_review_On_Premises_Digest') {}
	      * call read('RenewalCommonMethods.feature@LBDecisionApprovalNotificationCounselsOfficeSafekeeping')
	      * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
	       
	 	
	     ## ******************** UC_Renewal_LBDescision: Validate TC0016_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_Safekeeping Scenario End ***************************##
	     
	       @TC0017_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_Safekeeping_DefineProvisions_Removal
      Scenario: TC0017_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_Safekeeping_DefineProvisions_Removal
  ## ******************** UC_Renewal_LBDescision: Validate TC0017_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_Safekeeping_DefineProvisions_Removal Scenario Start ***************************##
	      
	      * call read('Uc_Renewal_LBDecision.feature@TC0002A_SLA_REN_Examiner_to_LB_review_On_Premises_Digest') {}
	      * call read('RenewalCommonMethods.feature@LBDecisionApprovalNotificationCounselsOfficeSafekeepingDefineProvisionsRemoval')
	      * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
	       
	 	
	     ## ******************** UC_Renewal_LBDescision: Validate TC0017_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_Safekeeping_DefineProvisions_Removal Scenario End ***************************##
	     
	     
	       @TC0018_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_Safekeeping_DefineProvisions_CorporateChange
      Scenario: TC0018_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_Safekeeping_DefineProvisions_CorporateChange
  ## ******************** UC_Renewal_LBDescision: Validate TC0018_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_Safekeeping_DefineProvisions_CorporateChange Scenario Start ***************************##
	      
	      * call read('Uc_Renewal_LBDecision.feature@TC0002A_SLA_REN_Examiner_to_LB_review_On_Premises_Digest') {}
	      * call read('RenewalCommonMethods.feature@LBDecisionApprovalNotificationCounselsOfficeSafekeepingDefineProvisionsCorporateChange')
	      * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
	       
	 	
	     ## ******************** UC_Renewal_LBDescision: Validate TC0018_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_Safekeeping_DefineProvisions_CorporateChange Scenario End ***************************##
	     
	     
	     @TC0019_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_Safekeeping_DefineProvisions_Alteration
      Scenario: TC0019_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_Safekeeping_DefineProvisions_Alteration
  ## ******************** UC_Renewal_LBDescision: Validate TC0019_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_Safekeeping_DefineProvisions_Alteration Scenario Start ***************************##
	      
	      * call read('Uc_Renewal_LBDecision.feature@TC0002A_SLA_REN_Examiner_to_LB_review_On_Premises_Digest') {}
	      * call read('RenewalCommonMethods.feature@LBDecisionApprovalNotificationCounselsOfficeSafekeepingDefineProvisionsAlteration')
	      * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
	       
	 	
	     ## ******************** UC_Renewal_LBDescision: Validate TC0019_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_Safekeeping_DefineProvisions_Alteration Scenario End ***************************##
	     
	     
	       @TC0020_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_Safekeeping_DefineProvisions_Endorsement
      Scenario: TC0020_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_Safekeeping_DefineProvisions_Endorsement
  ## ******************** UC_Renewal_LBDescision: Validate TC0020_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_Safekeeping_DefineProvisions_Endorsement Scenario Start ***************************##
	      
	      * call read('Uc_Renewal_LBDecision.feature@TC0002A_SLA_REN_Examiner_to_LB_review_On_Premises_Digest') {}
	      * call read('RenewalCommonMethods.feature@LBDecisionApprovalNotificationCounselsOfficeSafekeepingDefineProvisionsEndorsement')
	      * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
	       
	 	
	     ## ******************** UC_Renewal_LBDescision: Validate TC0020_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_Safekeeping_DefineProvisions_Endorsement Scenario End ***************************##
	     
	     
	      @TC0021_SLA_REN_LB_Decision_Approved_HoldforCBNotice
      Scenario: TC0021_SLA_REN_LB_Decision_Approved_HoldforCBNotice
  ## ******************** UC_Renewal_LBDescision: Validate TC0021_SLA_REN_LB_Decision_Approved_HoldforCBNotice Scenario Start ***************************##
	      
	      * call read('Uc_Renewal_LBDecision.feature@TC0002A_SLA_REN_Examiner_to_LB_review_On_Premises_Digest') {}
	     ## * call read('RenewalCommonMethods.feature@RenewalLicenseExaminerReviewApprovalToLB') 
	      * call read('RenewalCommonMethods.feature@LBDecisionApprovalNotificationHoldforCBNotice')
	      * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	 	
	     ## ******************** UC_Renewal_LBDescision: Validate TC0021_SLA_REN_LB_Decision_Approved_HoldforCBNotice Scenario End ***************************##
	     
	     
	      @TC0022_SLA_REN_LB_Decision_Approved_HoldforCBNotice_defineProvisions_Removal
      Scenario: TC0022_SLA_REN_LB_Decision_Approved_HoldforCBNotice_defineProvisions_Removal
  ## ******************** UC_Renewal_LBDescision: Validate TC0022_SLA_REN_LB_Decision_Approved_HoldforCBNotice_defineProvisions_Removal Scenario Start ***************************##
	      
	      * call read('Uc_Renewal_LBDecision.feature@TC0002A_SLA_REN_Examiner_to_LB_review_On_Premises_Digest') {}
	     ## * call read('RenewalCommonMethods.feature@RenewalLicenseExaminerReviewApprovalToLB') 
	      * call read('RenewalCommonMethods.feature@LBDecisionApprovalNotificationHoldforCBNoticedefineProvisionsRemoval')
	      * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	 	
	     ## ******************** UC_Renewal_LBDescision: Validate TC0022_SLA_REN_LB_Decision_Approved_HoldforCBNotice_defineProvisions_Removal Scenario End ***************************##
	     
	     @TC0023_SLA_REN_LB_Decision_Approved_HoldforCBNotice_defineProvisions_CorporateChange
      Scenario: TC0023_SLA_REN_LB_Decision_Approved_HoldforCBNotice_defineProvisions_CorporateChange
  ## ******************** UC_Renewal_LBDescision: Validate TC0023_SLA_REN_LB_Decision_Approved_HoldforCBNotice_defineProvisions_CorporateChange Scenario Start ***************************##
	      
	      * call read('Uc_Renewal_LBDecision.feature@TC0002A_SLA_REN_Examiner_to_LB_review_On_Premises_Digest') {}
	     ## * call read('RenewalCommonMethods.feature@RenewalLicenseExaminerReviewApprovalToLB') 
	      * call read('RenewalCommonMethods.feature@LBDecisionApprovalNotificationHoldforCBNoticedefineProvisionsCorporateChange')
	      * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	 	
	     ## ******************** UC_Renewal_LBDescision: Validate TC0023_SLA_REN_LB_Decision_Approved_HoldforCBNotice_defineProvisions_CorporateChange Scenario End ***************************##
	     
	     
	      @TC0024_SLA_REN_LB_Decision_Approved_HoldforCBNotice_defineProvisions_Alteration
      Scenario: TC0024_SLA_REN_LB_Decision_Approved_HoldforCBNotice_defineProvisions_Alteration
  ## ******************** UC_Renewal_LBDescision: Validate TC0024_SLA_REN_LB_Decision_Approved_HoldforCBNotice_defineProvisions_Alteration Scenario Start ***************************##
	      
	      * call read('Uc_Renewal_LBDecision.feature@TC0002A_SLA_REN_Examiner_to_LB_review_On_Premises_Digest') {}
	     ## * call read('RenewalCommonMethods.feature@RenewalLicenseExaminerReviewApprovalToLB') 
	      * call read('RenewalCommonMethods.feature@LBDecisionApprovalNotificationHoldforCBNoticedefineProvisionsAlteration')
	      * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	       * def typeOfNotification = 'Application Receipt'
		* def subject = 'NYS Liquor Authority Licensing Bureau Record Information'
		* def emailBodyData = 'Dear '+legalName+',<br/><br/>'
		And print emailBodyData
		* def emailBodyData2 = "Important information pertaining to your record(s) is attached.<br/><br/>" 
		* def emailBodyData3 = "Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date.<br/><br/>"
		* def emailBodyData4 = "Failure to provide a timely response may result in the disapproval of your application. The response should be sent to the e-mail address provided in the letter.<br/><br/>"  
    * def emailBodyData5 = "Sincerely yours,<br/><br/>New York State Liquor Authority"
		* call read('LicensesCommonMethods.feature@ValidateEmailCommunicationQueue') {}
		* match serverResponseNotificationData[0].emailBody contains emailBodyData2
		* match serverResponseNotificationData[0].emailBody contains emailBodyData3
		* match serverResponseNotificationData[0].emailBody contains emailBodyData4
		* match serverResponseNotificationData[0].emailBody contains emailBodyData5
	 	
	     ## ******************** UC_Renewal_LBDescision: Validate TC0024_SLA_REN_LB_Decision_Approved_HoldforCBNotice_defineProvisions_Alteration Scenario End ***************************##
	     
	     
	       @TC0025_SLA_REN_LB_Decision_Approved_HoldforCBNotice_defineProvisions_Endorsement
      Scenario: TC0025_SLA_REN_LB_Decision_Approved_HoldforCBNotice_defineProvisions_Endorsement
  ## ******************** UC_Renewal_LBDescision: Validate TC0025_SLA_REN_LB_Decision_Approved_HoldforCBNotice_defineProvisions_Endorsement Scenario Start ***************************##
	      
	      * call read('Uc_Renewal_LBDecision.feature@TC0002A_SLA_REN_Examiner_to_LB_review_On_Premises_Digest') {}
	     ## * call read('RenewalCommonMethods.feature@RenewalLicenseExaminerReviewApprovalToLB') 
	      * call read('RenewalCommonMethods.feature@LBDecisionApprovalNotificationHoldforCBNoticedefineProvisionsEndorsement')
	      * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	 	  * def typeOfNotification = 'Application Receipt'
		* def subject = 'NYS Liquor Authority Licensing Bureau Record Information'
		* def emailBodyData = 'Dear '+legalName+',<br/><br/>'
		And print emailBodyData
		* def emailBodyData2 = "Important information pertaining to your record(s) is attached.<br/><br/>" 
		* def emailBodyData3 = "Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date.<br/><br/>"
		* def emailBodyData4 = "Failure to provide a timely response may result in the disapproval of your application. The response should be sent to the e-mail address provided in the letter.<br/><br/>"  
    * def emailBodyData5 = "Sincerely yours,<br/><br/>New York State Liquor Authority"
		* call read('LicensesCommonMethods.feature@ValidateEmailCommunicationQueue') {}
		* match serverResponseNotificationData[0].emailBody contains emailBodyData2
		* match serverResponseNotificationData[0].emailBody contains emailBodyData3
		* match serverResponseNotificationData[0].emailBody contains emailBodyData4
		* match serverResponseNotificationData[0].emailBody contains emailBodyData5
	 	
	     ## ******************** UC_Renewal_LBDescision: Validate TC0025_SLA_REN_LB_Decision_Approved_HoldforCBNotice_defineProvisions_Endorsement Scenario End ***************************##
	     
	     
	     @TC0026_SLA_REN_LB_Decision_Approved_HoldforCBNotice_safekeeping
      Scenario: TC0026_SLA_REN_LB_Decision_Approved_HoldforCBNotice_safekeeping
  ## ******************** UC_Renewal_LBDescision: Validate TC0026_SLA_REN_LB_Decision_Approved_HoldforCBNotice_safekeeping Scenario Start ***************************##
	      
	      * call read('Uc_Renewal_LBDecision.feature@TC0002A_SLA_REN_Examiner_to_LB_review_On_Premises_Digest') {}
	     ## * call read('RenewalCommonMethods.feature@RenewalLicenseExaminerReviewApprovalToLB') 
	      * call read('RenewalCommonMethods.feature@LBDecisionApprovalNotificationHoldforCBNoticesafekeeping')
	      * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
	        * def typeOfNotification = 'Application Receipt'
		* def subject = 'NYS Liquor Authority Licensing Bureau Record Information'
		* def emailBodyData = 'Dear '+legalName+',<br/><br/>'
		And print emailBodyData
		* def emailBodyData2 = "Important information pertaining to your record(s) is attached.<br/><br/>" 
		* def emailBodyData3 = "Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date.<br/><br/>"
		* def emailBodyData4 = "Failure to provide a timely response may result in the disapproval of your application. The response should be sent to the e-mail address provided in the letter.<br/><br/>"  
    * def emailBodyData5 = "Sincerely yours,<br/><br/>New York State Liquor Authority"
		* call read('LicensesCommonMethods.feature@ValidateEmailCommunicationQueue') {}
		* match serverResponseNotificationData[0].emailBody contains emailBodyData2
		* match serverResponseNotificationData[0].emailBody contains emailBodyData3
		* match serverResponseNotificationData[0].emailBody contains emailBodyData4
		* match serverResponseNotificationData[0].emailBody contains emailBodyData5
	 	
	     ## ******************** UC_Renewal_LBDescision: Validate TC0026_SLA_REN_LB_Decision_Approved_HoldforCBNotice_safekeeping Scenario End ***************************##
	     
	     
	      @TC0027_SLA_REN_LB_Decision_Approved_HoldforCBNotice_safekeeping_DefineProvisions_Removal
      Scenario: TC0027_SLA_REN_LB_Decision_Approved_HoldforCBNotice_safekeeping_DefineProvisions_Removal
  ## ******************** UC_Renewal_LBDescision: Validate TC0027_SLA_REN_LB_Decision_Approved_HoldforCBNotice_safekeeping_DefineProvisions_Removal Scenario Start ***************************##
	      
	      * call read('Uc_Renewal_LBDecision.feature@TC0002A_SLA_REN_Examiner_to_LB_review_On_Premises_Digest') {}
	     ## * call read('RenewalCommonMethods.feature@RenewalLicenseExaminerReviewApprovalToLB') 
	      * call read('RenewalCommonMethods.feature@LBDecisionApprovalNotificationHoldforCBNoticesafekeepingDefineProvisionsRemoval')
	      * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
	      * def typeOfNotification = 'Application Receipt'
		* def subject = 'NYS Liquor Authority Licensing Bureau Record Information'
		* def emailBodyData = 'Dear '+legalName+',<br/><br/>'
		And print emailBodyData
		* def emailBodyData2 = "Important information pertaining to your record(s) is attached.<br/><br/>" 
		* def emailBodyData3 = "Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date.<br/><br/>"
		* def emailBodyData4 = "Failure to provide a timely response may result in the disapproval of your application. The response should be sent to the e-mail address provided in the letter.<br/><br/>"  
    * def emailBodyData5 = "Sincerely yours,<br/><br/>New York State Liquor Authority"
		* call read('LicensesCommonMethods.feature@ValidateEmailCommunicationQueue') {}
		* match serverResponseNotificationData[0].emailBody contains emailBodyData2
		* match serverResponseNotificationData[0].emailBody contains emailBodyData3
		* match serverResponseNotificationData[0].emailBody contains emailBodyData4
		* match serverResponseNotificationData[0].emailBody contains emailBodyData5
	 	
	     ## ******************** UC_Renewal_LBDescision: Validate TC0027_SLA_REN_LB_Decision_Approved_HoldforCBNotice_safekeeping_DefineProvisions_Removal Scenario End ***************************##
	     
	      @TC0028_SLA_REN_LB_Decision_Approved_HoldforCBNotice_safekeeping_DefineProvisions_CorporateChange
      Scenario: TC0028_SLA_REN_LB_Decision_Approved_HoldforCBNotice_safekeeping_DefineProvisions_CorporateChange
  ## ******************** UC_Renewal_LBDescision: Validate TC0028_SLA_REN_LB_Decision_Approved_HoldforCBNotice_safekeeping_DefineProvisions_CorporateChange Scenario Start ***************************##
	      
	      * call read('Uc_Renewal_LBDecision.feature@TC0002A_SLA_REN_Examiner_to_LB_review_On_Premises_Digest') {}
	     ## * call read('RenewalCommonMethods.feature@RenewalLicenseExaminerReviewApprovalToLB') 
	      * call read('RenewalCommonMethods.feature@LBDecisionApprovalNotificationHoldforCBNoticesafekeepingDefineProvisionsCorporateChange')
	      * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
	       * def typeOfNotification = 'Application Receipt'
		* def subject = 'NYS Liquor Authority Licensing Bureau Record Information'
		* def emailBodyData = 'Dear '+legalName+',<br/><br/>'
		And print emailBodyData
		* def emailBodyData2 = "Important information pertaining to your record(s) is attached.<br/><br/>" 
		* def emailBodyData3 = "Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date.<br/><br/>"
		* def emailBodyData4 = "Failure to provide a timely response may result in the disapproval of your application. The response should be sent to the e-mail address provided in the letter.<br/><br/>"  
    * def emailBodyData5 = "Sincerely yours,<br/><br/>New York State Liquor Authority"
		* call read('LicensesCommonMethods.feature@ValidateEmailCommunicationQueue') {}
		* match serverResponseNotificationData[0].emailBody contains emailBodyData2
		* match serverResponseNotificationData[0].emailBody contains emailBodyData3
		* match serverResponseNotificationData[0].emailBody contains emailBodyData4
		* match serverResponseNotificationData[0].emailBody contains emailBodyData5
	 	
	     ## ******************** UC_Renewal_LBDescision: Validate TC0028_SLA_REN_LB_Decision_Approved_HoldforCBNotice_safekeeping_DefineProvisions_CorporateChange Scenario End ***************************##
	     
	     
	      @TC0029_SLA_REN_LB_Decision_Approved_HoldforCBNotice_safekeeping_DefineProvisions_Alteration
      Scenario: TC0029_SLA_REN_LB_Decision_Approved_HoldforCBNotice_safekeeping_DefineProvisions_Alteration
  ## ******************** UC_Renewal_LBDescision: Validate TC0029_SLA_REN_LB_Decision_Approved_HoldforCBNotice_safekeeping_DefineProvisions_Alteration Scenario Start ***************************##
	      
	      * call read('Uc_Renewal_LBDecision.feature@TC0002A_SLA_REN_Examiner_to_LB_review_On_Premises_Digest') {}
	     ## * call read('RenewalCommonMethods.feature@RenewalLicenseExaminerReviewApprovalToLB') 
	      * call read('RenewalCommonMethods.feature@LBDecisionApprovalNotificationHoldforCBNoticesafekeepingDefineProvisionsAlteration')
	      * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
	      * def typeOfNotification = 'Application Receipt'
		* def subject = 'NYS Liquor Authority Licensing Bureau Record Information'
		* def emailBodyData = 'Dear '+legalName+',<br/><br/>'
		And print emailBodyData
		* def emailBodyData2 = "Important information pertaining to your record(s) is attached.<br/><br/>" 
		* def emailBodyData3 = "Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date.<br/><br/>"
		* def emailBodyData4 = "Failure to provide a timely response may result in the disapproval of your application. The response should be sent to the e-mail address provided in the letter.<br/><br/>"  
    * def emailBodyData5 = "Sincerely yours,<br/><br/>New York State Liquor Authority"
		* call read('LicensesCommonMethods.feature@ValidateEmailCommunicationQueue') {}
		* match serverResponseNotificationData[0].emailBody contains emailBodyData2
		* match serverResponseNotificationData[0].emailBody contains emailBodyData3
		* match serverResponseNotificationData[0].emailBody contains emailBodyData4
		* match serverResponseNotificationData[0].emailBody contains emailBodyData5
	 	
	     ## ******************** UC_Renewal_LBDescision: Validate TC0029_SLA_REN_LB_Decision_Approved_HoldforCBNotice_safekeeping_DefineProvisions_Alteration Scenario End ***************************##
	     
	     
	     @TC0030_SLA_REN_LB_Decision_Approved_HoldforCBNotice_safekeeping_DefineProvisions_Endorsement
      Scenario: TC0030_SLA_REN_LB_Decision_Approved_HoldforCBNotice_safekeeping_DefineProvisions_Endorsement
  ## ******************** UC_Renewal_LBDescision: Validate TC0030_SLA_REN_LB_Decision_Approved_HoldforCBNotice_safekeeping_DefineProvisions_Endorsement Scenario Start ***************************##
	      
	      * call read('Uc_Renewal_LBDecision.feature@TC0002A_SLA_REN_Examiner_to_LB_review_On_Premises_Digest') {}
	     ## * call read('RenewalCommonMethods.feature@RenewalLicenseExaminerReviewApprovalToLB') 
	      * call read('RenewalCommonMethods.feature@LBDecisionApprovalNotificationHoldforCBNoticesafekeepingDefineProvisionsEndorsement')
	      * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
	 
	* def typeOfNotification = 'Application Receipt'
		* def subject = 'NYS Liquor Authority Licensing Bureau Record Information'
		* def emailBodyData = 'Dear '+legalName+',<br/><br/>'
		And print emailBodyData
		* def emailBodyData2 = "Important information pertaining to your record(s) is attached.<br/><br/>" 
		* def emailBodyData3 = "Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date.<br/><br/>"
		* def emailBodyData4 = "Failure to provide a timely response may result in the disapproval of your application. The response should be sent to the e-mail address provided in the letter.<br/><br/>"  
    * def emailBodyData5 = "Sincerely yours,<br/><br/>New York State Liquor Authority"
		* call read('LicensesCommonMethods.feature@ValidateEmailCommunicationQueue') {}
		* match serverResponseNotificationData[0].emailBody contains emailBodyData2
		* match serverResponseNotificationData[0].emailBody contains emailBodyData3
		* match serverResponseNotificationData[0].emailBody contains emailBodyData4
		* match serverResponseNotificationData[0].emailBody contains emailBodyData5
	 	
	     ## ******************** UC_Renewal_LBDescision: Validate TC0030_SLA_REN_LB_Decision_Approved_HoldforCBNotice_safekeeping_DefineProvisions_Endorsement Scenario End ***************************##
	     
	     
	     @TC0031_SLA_REN_LB_Decision_Disapproved_for_Cause_selectReason
      Scenario: TC0031_SLA_REN_LB_Decision_Disapproved_for_Cause_selectReason
  ## ******************** UC_Renewal_LBDescision: Validate TC0031_SLA_REN_LB_Decision_Disapproved_for_Cause_selectReason Scenario Start ***************************##
	      
	      * call read('Uc_Renewal_LBDecision.feature@TC0002A_SLA_REN_Examiner_to_LB_review_On_Premises_Digest') {}
	    
	 	
	     ## ******************** UC_Renewal_LBDescision: Validate TC0031_SLA_REN_LB_Decision_Disapproved_for_Cause_selectReason Scenario End ***************************##
	     
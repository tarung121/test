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

	* def dateFnc =
		"""
		  function(days) {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd");
		     var date = new java.util.Date();
		     var dayAfter = new java.util.Date( date.getTime() - java.util.concurrent.TimeUnit.DAYS.toMillis( days));
		    return sdf.format(dayAfter);
		  } """
		  
@TC0002_SLA_REN_Examiner_review_Digest_Approved_and_Hold_for_CB_notice	  
Scenario Outline: TC0002_SLA_REN_Examiner_review_Digest_Approved_and_Hold_for_CB_notice
   
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
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees+licAncillaryFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_RenewalExaminerReview: Validate TC0002_SLA_REN_Examiner_review_Digest_Approved_and_Hold_for_CB_notice Scenario Start ***************************##
	   	* call read('LicensesCommonMethods.feature@IntakeLicensewithoutAssociatedLic') {}
        * def CountyName = "New York"
        * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {county:'#(CountyName)'}
        * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
        * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
        #* call read('LicensesCommonMethods.feature@FillAndSaveMethodOfOperationPage') {}
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
	   
	   	     ## ******************** UC_RenewalExaminerReview: Validate TC0002_SLA_REN_Examiner_review_Digest_Approved_and_Hold_for_CB_notice  Scenario End ***************************##   
	
	
	
 Examples:
    | read('/CSVFiles/RenewalOnPremises.csv') |


		  
@TC0002_SLA_REN_Examiner_review_Digest_ApprovedandRefertoCounselsOffice	  
Scenario Outline: TC0002_SLA_REN_Examiner_review_Digest_ApprovedandRefertoCounselsOffice
   
   * def frmtDate1 = dateFnc(32)
   * def frmtDate2 = dateFnc(0)
   And print frmtDate1
   And print frmtDate2
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
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees+licAncillaryFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_RenewalExaminerReview: Validate TC0002_SLA_REN_Examiner_review_Digest_ApprovedandRefertoCounselsOffice Scenario Start ***************************##
	   	* call read('LicensesCommonMethods.feature@IntakeLicensewithoutAssociatedLic') {}
        * def CountyName = "New York"
        * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {county:'#(CountyName)'}
        * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
        * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
        #* call read('LicensesCommonMethods.feature@FillAndSaveMethodOfOperationPage') {}
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
	   
	   	     ## ******************** UC_RenewalExaminerReview: Validate TC0002_SLA_REN_Examiner_review_Digest_ApprovedandRefertoCounselsOffice  Scenario End ***************************##   
	
	
	
 Examples:
    | read('/CSVFiles/RenewalOnPremises.csv') |

@TC0002A_SLA_REN_Examiner_review_Common_Digest_License	  
Scenario Outline: TC0002A_SLA_REN_Examiner_review_Common_Digest_License
   
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
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees+licAncillaryFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_RenewalExaminerReview: Validate TC0002A_SLA_REN_Examiner_review_Common_Digest_License Scenario Start ***************************##
	   	* call read('LicensesCommonMethods.feature@IntakeLicensewithoutAssociatedLic') {}
        * def CountyName = "New York"
        * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {county:'#(CountyName)'}
        * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
        * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
        #* call read('LicensesCommonMethods.feature@FillAndSaveMethodOfOperationPage') {}
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
	      ## ******************** UC_RenewalExaminerReview: Validate TC0002A_SLA_REN_Examiner_review_Common_Digest_License  Scenario End ***************************##   
	
	
	
 Examples:
    | read('/CSVFiles/RenewalOnPremises.csv') |


@TC0002A_SLA_REN_Examiner_review_Common_Digest_Permit	  
Scenario Outline: TC0002A_SLA_REN_Examiner_review_Common_Digest_Permit
   
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
		* call read('LicensesCommonMethods.feature@PermitLBDecisions1') {StipulationsCount:0}
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
	  ## ******************** UC_RenewalExaminerReviewApp: Validate TC0002A_SLA_REN_Examiner_review_Common_Digest_Permit Scenario End ***************************##   
	
	
	
 Examples:
    | read('/CSVFiles/RenewalStandalonePermit.csv') |   


@TC0003_SLA_REN_Examiner_review_Approve_license	  
Scenario Outline: TC0003_SLA_REN_Examiner_review_Approve_license
   
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
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees+licAncillaryFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_RenewalExaminerReview: Validate TC0003_SLA_REN_Examiner_review_Approve_license Scenario Start ***************************##
	   	* call read('LicensesCommonMethods.feature@IntakeLicensewithoutAssociatedLic') {}
        * def CountyName = "New York"
        * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {county:'#(CountyName)'}
        * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
        * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
        #* call read('LicensesCommonMethods.feature@FillAndSaveMethodOfOperationPage') {}
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
	   * call read('RenewalCommonMethods.feature@SaveAssociatedPrincipal') {}
	   * call read('RenewalCommonMethods.feature@RenewalLicFillingFee') {amount:40000}
	   * call read('LicensesCommonMethods.feature@UploadDocumentAmendment') {}
	   * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	   	  * def SafekeepingStatus = false
	   	  * def licPerType = 'license'
	   	 * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	     
	    * call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproval') {expStatus:'Approved'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	    
	   	     ## ******************** UC_RenewalExaminerReview: Validate TC0003_SLA_REN_Examiner_review_Approve_license  Scenario End ***************************##   
	
	
	
 Examples:
    | read('/CSVFiles/RenewalWholeSaleOnPremises.csv') |

 @TC0004_SLA_REN_Examiner_review_Approve_Standalone_Permit	  
 Scenario Outline: TC0004_SLA_REN_Examiner_review_Approve_Standalone_Permit
   
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
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees+licAncillaryFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0004_SLA_REN_Examiner_review_Approve_Standalone_Permit Scenario Start ***************************##
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
		* call read('LicensesCommonMethods.feature@PermitLBDecisions1') {StipulationsCount:0}
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
	     
	    * call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproval') {expStatus:'Approved'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	    
	   	  
	   	     ## ******************** UC_RenewalExaminerReviewApp: Validate TC0004_SLA_REN_Examiner_review_Approve_Standalone_Permit Scenario End ***************************##   
	
	
	
 Examples:
    | read('/CSVFiles/RenewalStandalonePermit.csv') |       
   

 @TC0005_SLA_REN_Examiner_review_Approve_Associated_Permit	  
 Scenario Outline: TC0005_SLA_REN_Examiner_review_Approve_Associated_Permit
   
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
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees+licAncillaryFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0005_SLA_REN_Examiner_review_Approve_Associated_Permit Scenario Start ***************************##
	    * call read('PermitsCommonMethods.feature@GetActivatedLicenses') {SearchName:'Automation'}
      	* call read('PermitsCommonMethods.feature@IntakeAssociatedPermit') {}
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
	     
	    * call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproval') {expStatus:'Refund Awaiting Review'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	    
	   	 
	   	     ## ******************** UC_RenewalExaminerReviewApp: Validate TC0005_SLA_REN_Examiner_review_Approve_Associated_Permit Scenario End ***************************##   
	

	
 Examples:
    | read('/CSVFiles/RenewalAssociatedPermit.csv') | 
  
 
 @TC0006_SLA_REN_Examiner_review_Approve_Temporary_Permit	  
 Scenario Outline: TC0006_SLA_REN_Examiner_review_Approve_Temporary_Permit
   
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
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees+licAncillaryFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0006_SLA_REN_Examiner_review_Approve_Temporary_Permit Scenario Start ***************************##
	    * call read('PermitsCommonMethods.feature@IntakeTempPermit') {permit_Type:'Temporary Permit', SearchedapplicationId: null}
		* call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('LicensesCommonMethods.feature@FeesValidation') {amount:'#(totalFees)'}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		* call read('PermitsCommonMethods.feature@ApproveTempPermit') {expStatus:'Approved'}
	   * def checboxDisapprovalCause = false
		
	    
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
	     
	    * call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproval') {expStatus:'Refund Awaiting Review'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	    
	   	  
	   	     ## ******************** UC_RenewalExaminerReviewApp: Validate TC0006_SLA_REN_Examiner_review_Approve_Temporary_Permit Scenario End ***************************##   
	
	
	
 Examples:
    | read('/CSVFiles/RenewalTempPermit.csv') |



@TC0007_SLA_REN_Examiner_Approve_Safekeeping_License	  
Scenario Outline: TC0007_SLA_REN_Examiner_Approve_Safekeeping_License
   
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
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees+licAncillaryFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_RenewalExaminerReview: Validate TC0007_SLA_REN_Examiner_Approve_Safekeeping_License Scenario Start ***************************##
	   	* call read('LicensesCommonMethods.feature@IntakeLicensewithoutAssociatedLic') {}
       # * def CountyName = "New York"
        * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {county:'#(CountyName)'}
        * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
        * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
        #* call read('LicensesCommonMethods.feature@FillAndSaveMethodOfOperationPage') {}
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
	   * call read('RenewalCommonMethods.feature@SaveAssociatedPrincipal') {}
	   * call read('RenewalCommonMethods.feature@RenewalLicFillingFee') {amount:40000}
	   * call read('LicensesCommonMethods.feature@UploadDocumentAmendment') {}
	   * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	   	  * def SafekeepingStatus = true
	   	  * def licPerType = 'license'
	   	 * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	     
	    * call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproval') {expStatus:'Approved'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
	    
	   	     ## ******************** UC_RenewalExaminerReview: Validate TC0007_SLA_REN_Examiner_Approve_Safekeeping_License  Scenario End ***************************##   
	
	
	
 Examples:
    | read('/CSVFiles/RenewalWholeSaleOnPremises.csv') |


 @TC0008_SLA_REN_Examiner_Approve_Safekeeping_Associated_Permit	  
 Scenario Outline: TC0008_SLA_REN_Examiner_Approve_Safekeeping_Associated_Permit
   
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
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees+licAncillaryFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0008_SLA_REN_Examiner_Approve_Safekeeping_Associated_Permit Scenario Start ***************************##
	    * call read('PermitsCommonMethods.feature@GetActivatedLicenses') {SearchName:'Automation'}
      	* call read('PermitsCommonMethods.feature@IntakeAssociatedPermit') {}
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
	   	 * def SafekeepingStatus = true
	   	 * def licPerType = 'permit'
	   	 * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	     
	    * call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproval') {expStatus:'Refund Awaiting Review'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
	    
	   	 
	   	     ## ******************** UC_RenewalExaminerReviewApp: Validate TC0008_SLA_REN_Examiner_Approve_Safekeeping_Associated_Permit Scenario End ***************************##   
	

	
 Examples:
    | read('/CSVFiles/RenewalAssociatedPermit.csv') | 
 
 @TC0009_SLA_REN_Examiner_Approve_Safekeeping_Standalone_Permit	  
 Scenario Outline: TC0009_SLA_REN_Examiner_Approve_Safekeeping_Standalone_Permit
   
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
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees+licAncillaryFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0009_SLA_REN_Examiner_Approve_Safekeeping_Standalone_Permit Scenario Start ***************************##
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
	   	 * def SafekeepingStatus = true
	   	 * def licPerType = 'permit'
	   	 * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	     
	    * call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproval') {expStatus:'Approved'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
	    
	   	  
	   	     ## ******************** UC_RenewalExaminerReviewApp: Validate TC0009_SLA_REN_Examiner_Approve_Safekeeping_Standalone_Permit Scenario End ***************************##   
	
	
	
 Examples:
    | read('/CSVFiles/RenewalStandalonePermit.csv') |       
    
 
 @TC0010_SLA_REN_Examiner_Approve_Safekeeping_Temporary_Permit	  
 Scenario Outline: TC0010_SLA_REN_Examiner_Approve_Safekeeping_Temporary_Permit
   
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
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees+licAncillaryFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0010_SLA_REN_Examiner_Approve_Safekeeping_Temporary_Permit Scenario Start ***************************##
	    * call read('PermitsCommonMethods.feature@IntakeTempPermit') {permit_Type:'Temporary Permit', SearchedapplicationId: null}
		* call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('LicensesCommonMethods.feature@FeesValidation') {amount:'#(totalFees)'}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		* call read('PermitsCommonMethods.feature@ApproveTempPermit') {expStatus:'Approved'}
	   * def checboxDisapprovalCause = false
		
	    
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
	   	 * def SafekeepingStatus = true
	   	 * def licPerType = 'permit'
	   	 * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	     
	    * call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproval') {expStatus:'Refund Awaiting Review'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
	    
	   	  
	   	     ## ******************** UC_RenewalExaminerReviewApp: Validate TC0010_SLA_REN_Examiner_Approve_Safekeeping_Temporary_Permit Scenario End ***************************##   
	
	
	
 Examples:
    | read('/CSVFiles/RenewalTempPermit.csv') |
 
 
@TC0012_SLA_REN_Examiner_review_Approve_Provisions_Removal	  
Scenario: TC0012_SLA_REN_Examiner_review_Approve_Provisions_Removal
   	## ******************** UC_RenewalExaminerReview: Validate TC0012_SLA_REN_Examiner_review_Approve_Provisions_Removal Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002A_SLA_REN_Examiner_review_Common_Digest_License') {}
         * def SafekeepingStatus = false
	   	 * def licPerType = 'Removal'
	   	* call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproval') {expStatus:'Approved'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	   
	## ******************** UC_RenewalExaminerReview: Validate TC0012_SLA_REN_Examiner_review_Approve_Provisions_Removal  Scenario End ***************************##   

       

 
@TC0013_SLA_REN_Examiner_review_Approve_Provisions_Corporate_Change	  
Scenario: TC0013_SLA_REN_Examiner_review_Approve_Provisions_Corporate_Change
   	## ******************** UC_RenewalExaminerReview: Validate TC0013_SLA_REN_Examiner_review_Approve_Provisions_Corporate_Change Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002A_SLA_REN_Examiner_review_Common_Digest_License') {}
         * def SafekeepingStatus = false
	   	 * def licPerType = 'CorporateChange'
	   	 
	   	* call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproval') {expStatus:'Approved'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	   
	## ******************** UC_RenewalExaminerReview: Validate TC0013_SLA_REN_Examiner_review_Approve_Provisions_Corporate_Change  Scenario End ***************************##   

 
@TC0014_SLA_REN_Examiner_review_Approve_Provisions_Alteration	  
Scenario: TC0014_SLA_REN_Examiner_review_Approve_Provisions_Alteration
   	## ******************** UC_RenewalExaminerReview: Validate TC0014_SLA_REN_Examiner_review_Approve_Provisions_Alteration Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002A_SLA_REN_Examiner_review_Common_Digest_License') {}
         * def SafekeepingStatus = false
	   	 * def licPerType = 'Alteration'
	   	 * call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproval') {expStatus:'Approved'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	   
	## ******************** UC_RenewalExaminerReview: Validate TC0014_SLA_REN_Examiner_review_Approve_Provisions_Alteration  Scenario End ***************************##   


@TC0015_SLA_REN_Examiner_review_Approve_Provisions_Endorsement	  
Scenario: TC0015_SLA_REN_Examiner_review_Approve_Provisions_Endorsement
   	## ******************** UC_RenewalExaminerReview: Validate TC0015_SLA_REN_Examiner_review_Approve_Provisions_Endorsement Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002A_SLA_REN_Examiner_review_Common_Digest_License') {}
         * def SafekeepingStatus = false
	   	 * def licPerType = 'Endorsement'
	   	* call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproval') {expStatus:'Approved'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	   
	## ******************** UC_RenewalExaminerReview: Validate TC0015_SLA_REN_Examiner_review_Approve_Provisions_Endorsement  Scenario End ***************************##   
        
  	 	

@TC0016_SLA_REN_Examiner_review_Approve_Provisions_Safekeeping_Removal	  
Scenario: TC0016_SLA_REN_Examiner_review_Approve_Provisions_Safekeeping_Removal
   	## ******************** UC_RenewalExaminerReview: Validate TC0016_SLA_REN_Examiner_review_Approve_Provisions_Safekeeping_Removal Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002A_SLA_REN_Examiner_review_Common_Digest_License') {}
         * def SafekeepingStatus = true
	   	 * def licPerType = 'Removal'
	   	* call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproval') {expStatus:'Approved'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
	   
	## ******************** UC_RenewalExaminerReview: Validate TC0016_SLA_REN_Examiner_review_Approve_Provisions_Safekeeping_Removal  Scenario End ***************************##   

       

 
@TC0017_SLA_REN_Examiner_review_Approve_Provisions_Safekeeping_Corporate_Change	  
Scenario: TC0017_SLA_REN_Examiner_review_Approve_Provisions_Safekeeping_Corporate_Change
   	## ******************** UC_RenewalExaminerReview: Validate TC0017_SLA_REN_Examiner_review_Approve_Provisions_Safekeeping_Corporate_Change Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002A_SLA_REN_Examiner_review_Common_Digest_License') {}
         * def SafekeepingStatus = true
	   	 * def licPerType = 'CorporateChange'
	   	 
	   	* call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproval') {expStatus:'Approved'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
	   
	## ******************** UC_RenewalExaminerReview: Validate TC0017_SLA_REN_Examiner_review_Approve_Provisions_Safekeeping_Corporate_Change  Scenario End ***************************##   

 
@TC0018_SLA_REN_Examiner_review_Approve_Provisions_Safekeeping_Alteration	  
Scenario: TC0018_SLA_REN_Examiner_review_Approve_Provisions_Safekeeping_Alteration
   	## ******************** UC_RenewalExaminerReview: Validate TC0018_SLA_REN_Examiner_review_Approve_Provisions_Safekeeping_Alteration Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002A_SLA_REN_Examiner_review_Common_Digest_License') {}
         * def SafekeepingStatus = true
	   	 * def licPerType = 'Alteration'
	   	 * call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproval') {expStatus:'Approved'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
	   
	## ******************** UC_RenewalExaminerReview: Validate TC0018_SLA_REN_Examiner_review_Approve_Provisions_Safekeeping_Alteration  Scenario End ***************************##   


@TC0019_SLA_REN_Examiner_review_Approve_Provisions_Safekeeping_Endorsement	  
Scenario: TC0019_SLA_REN_Examiner_review_Approve_Provisions_Safekeeping_Endorsement
   	## ******************** UC_RenewalExaminerReview: Validate TC0019_SLA_REN_Examiner_review_Approve_Provisions_Safekeeping_Endorsement Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002A_SLA_REN_Examiner_review_Common_Digest_License') {}
         * def SafekeepingStatus = true
	   	 * def licPerType = 'Endorsement'
	   	* call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproval') {expStatus:'Approved'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
	   
	## ******************** UC_RenewalExaminerReview: Validate TC0019_SLA_REN_Examiner_review_Approve_Provisions_Safekeeping_Endorsement  Scenario End ***************************##
	
 @TC0020_SLA_REN_Examiner_review_Send_to_LB_for_Review_License
 Scenario Outline: TC0020_SLA_REN_Examiner_review_Send_to_LB_for_Review_License
   
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
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_Renewal_ExaminerReviewsRenewal: Validate TC0020_SLA_REN_Examiner_review_Send_to_LB_for_Review_License Scenario Start ***************************##
	   
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
         #* call read('LicensesCommonMethods.feature@FillAndSaveMethodOfOperationPage') {}
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
	      * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {county:'#(CountyName)'}
	      * call read('RenewalCommonMethods.feature@SaveAssociatedPrincipal') {}
	      * call read('RenewalCommonMethods.feature@RenewalLicFillingFee') {amount:40000}
	      * call read('LicensesCommonMethods.feature@UploadDocumentAmendment') {}
	      * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	   	  * def SafekeepingStatus = false
	   	  * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}     
	      * call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApprovalToLB') {expStatus:'Awaiting Review'}   
	      * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
         
	     ## ******************** UC_Renewal_ExaminerReviewsRenewal: Validate TC0020_SLA_REN_Examiner_review_Send_to_LB_for_Review_License Scenario End ***************************##   
	
     
Examples:
    | read('/CSVFiles/Uc_22_TC0005_NYC_SLA_LIC_Under_Payment.csv') |
    
 
 @TC0021_SLA_REN_Examiner_review_Send_to_LB_for_Review_Permit	  
 Scenario Outline: TC0021_SLA_REN_Examiner_review_Send_to_LB_for_Review_Permit
   
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
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees+licAncillaryFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0021_SLA_REN_Examiner_review_Send_to_LB_for_Review_Permit Scenario Start ***************************##
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
	   	 * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	     
	    * call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApprovalToLB') {expStatus:'Awaiting Review'}
	   
	    # * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Awaiting Review'}
	    
	   	  
	   	     ## ******************** UC_RenewalExaminerReviewApp: Validate TC0021_SLA_REN_Examiner_review_Send_to_LB_for_Review_Permit Scenario End ***************************##   
	
 Examples:
    | read('/CSVFiles/RenewalStandalonePermit.csv') |     
    

@TC0022_SLA_REN_Examiner_Review_Send_to_LB_On_Premises_License	  
 Scenario Outline: TC0022_SLA_REN_Examiner_Review_Send_to_LB_On_Premises_License
   
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
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees+licAncillaryFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0022_SLA_REN_Examiner_Review_Send_to_LB_On_Premises_License Scenario Start ***************************##
	   	* call read('LicensesCommonMethods.feature@IntakeLicensewithoutAssociatedLic') {}
        * def CountyName = "New York"
        * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {county:'#(CountyName)'}
        * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
        * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
        #* call read('LicensesCommonMethods.feature@FillAndSaveMethodOfOperationPage') {}
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
	   * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {county:'#(CountyName)'}
        
	   * call read('RenewalCommonMethods.feature@SaveAssociatedPrincipal') {}
	   * call read('LicensesCommonMethods.feature@UploadDocumentAmendment') {}
	   * call read('RenewalCommonMethods.feature@RenewalLicFillingFee') {amount:40000}
	   
	    * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	   	 * def SafekeepingStatus = false
	   	 * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	     
	    * call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApprovalToLB') {expStatus:'Awaiting Review'}
	   
	   #  * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Awaiting Review'}
	   	 
	   	     ## ******************** UC_RenewalExaminerReviewApp: Validate TC0022_SLA_REN_Examiner_Review_Send_to_LB_On_Premises_License Scenario End ***************************##   
	
 Examples:
    | read('/CSVFiles/RenewalSeasonalOnPremises.csv') | 
 
		 	 		 	 		
	@TC0024_SLA_REN_Examiner_Review_FBPT_for_Review_License	  
Scenario Outline: TC0024_SLA_REN_Examiner_Review_FBPT_for_Review_License
   
	   * def foo = ['123']
	   * match foo == '#[] #regex \\d+'
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
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0024_SLA_REN_Examiner_Review_FBPT_for_Review_License Scenario Start ***************************##
	   
	    * call read('LicensesCommonMethods.feature@IntakeLicensewithoutAssociatedLic') {}
	    * def CountyName = "New York"
      * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {county:'#(CountyName)'}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('LicensesCommonMethods.feature@FeesValidation') {amount:'#(totalFees)'}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		#  * call read('LicensesCommonMethods.feature@SaveAndValidateMemoLinkData') {}
		
		  * call read('LicensesCommonMethods.feature@ExaminerReviewApprovalToFBPTQueue') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@getAndValidateMemoData') {}
	    * call read('LicensesCommonMethods.feature@AssignFBPTLicToLB') {}
	    * call read('LicensesCommonMethods.feature@checkApplicationStatus') {expStatus:'Awaiting Review'}
		
	    
	     ## ******************** UC_RenewalExaminerReviewApp: Validate TC0024_SLA_REN_Examiner_Review_FBPT_for_Review_License Scenario End ***************************##   
	
		Examples:
    | read('/CSVFiles/RenewalSeasonalOnPremises.csv') |  	 	 
		 	 	 
		 	 	 
		 	 	 
		 	 	          
	 	  @TC0025_SLA_REN_Examiner_Review_FBPT_for_Review_On_Premises_License  
Scenario Outline: TC0025_SLA_REN_Examiner_Review_FBPT_for_Review_On_Premises_License
   
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
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0025_SLA_REN_Examiner_Review_FBPT_for_Review_On_Premises_License Scenario Start ***************************##
	   
	    * call read('LicensesCommonMethods.feature@IntakeLicensewithoutAssociatedLic') {}
	    * def CountyName = "New York"
      * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {county:'#(CountyName)'}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('LicensesCommonMethods.feature@FeesValidation') {amount:'#(totalFees)'}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		#  * call read('LicensesCommonMethods.feature@SaveAndValidateMemoLinkData') {}
		
		  * call read('LicensesCommonMethods.feature@ExaminerReviewApprovalToFBPTQueue') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@getAndValidateMemoData') {}
	    * call read('LicensesCommonMethods.feature@AssignFBPTLicToLB') {}
	    * call read('LicensesCommonMethods.feature@checkApplicationStatus') {expStatus:'Awaiting Review'}
		
	    
	     ## ******************** UC_RenewalExaminerReviewApp: Validate TC0025_SLA_REN_Examiner_Review_FBPT_for_Review_On_Premises_License Scenario End ***************************## 
	     
	     Examples:
    | read('/CSVFiles/RenewalSeasonalOnPremises.csv') |  
    
    
    
    @TC0026_SLA_REN_Examiner_Review_FBPT_for_Review_Permit  
Scenario Outline: TC0026_SLA_REN_Examiner_Review_FBPT_for_Review_Permit
   
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0026_SLA_REN_Examiner_Review_FBPT_for_Review_Permit Scenario Start ***************************##
	   
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002A_SLA_REN_Examiner_review_Common_Digest_License') {}
	   	* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		#  * call read('LicensesCommonMethods.feature@SaveAndValidateMemoLinkData') {}
		  * call read('LicensesCommonMethods.feature@ExaminerReviewApprovalToFBPTQueue2') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@getAndValidateMemoData') {}
	    * call read('LicensesCommonMethods.feature@AssignFBPTLicToLB') {}
	    * call read('LicensesCommonMethods.feature@checkApplicationStatus') {expStatus:'Awaiting Review'}
		  
	     ## ******************** UC_RenewalExaminerReviewApp: Validate TC0026_SLA_REN_Examiner_Review_FBPT_for_Review_Permit Scenario End ***************************## 
	     
	     Examples:
                  | read('/CSVFiles/RenewalSeasonalOnPremises.csv') |  
   
    @TC0029_SLA_REN_Examiner_Review_Define_Deficiencies_License  
Scenario Outline: TC0029_SLA_REN_Examiner_Review_Define_Deficiencies_License
   
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0029_SLA_REN_Examiner_Review_Define_Deficiencies_License Scenario Start ***************************##
	   
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002A_SLA_REN_Examiner_review_Common_Digest_License') {}
	   	* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		  * def deficienciesCount = 1
		  * def reviewType = 'Define Deficiencies'		
	 	 * call read('AmendmentsCommonMethods.feature@AddDeficiency') {}
	 	  
	 	  * call read('RenewalCommonMethods.feature@RenewalExaminerReviewApprovalToLB') {expStatus:'Additional Info Required'}
	#	  * call read('LicensesCommonMethods.feature@ExaminerReviewDefineDeficiencies')
		   * def wait = waitFunc(70)

		* def typeOfNotification = 'Generic Non-Portal'
		* def subject = 'NYS Liquor Authority Licensing Bureau Record Information'
		* def emailBodyData = 'Dear '+legalName+','
		And print emailBodyData
		* def emailBodyData2 = "Important information pertaining to your record(s) is attached."  
		* def emailBodyData3 = "Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date."
		* def emailBodyData4 = "Failure to provide a timely response may result in the disapproval of your application. The response should be sent to the e-mail address provided in the letter."  
        * def emailBodyData5 = "Sincerely yours, \r<br/>New York State Liquor Authority"
		* call read('LicensesCommonMethods.feature@ValidateEmailCommunicationQueue') {}
		* match serverResponseNotificationData[0].emailBody contains emailBodyData2
		* match serverResponseNotificationData[0].emailBody contains emailBodyData3
		* match serverResponseNotificationData[0].emailBody contains emailBodyData4
		* match serverResponseNotificationData[0].emailBody contains emailBodyData5
	    
	     ## ******************** UC_RenewalExaminerReviewApp: Validate TC0029_SLA_REN_Examiner_Review_Define_Deficiencies_License Scenario End ***************************## 
	     
	     Examples:
    | read('/CSVFiles/RenewalSeasonalOnPremises.csv') |  
    
    
    @TC0030_SLA_REN_Examiner_Review_Define_Deficiencies_On_Premises_License  
Scenario Outline: TC0030_SLA_REN_Examiner_Review_Define_Deficiencies_On_Premises_License
   
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0030_SLA_REN_Examiner_Review_Define_Deficiencies_On_Premises_License Scenario Start ***************************##
	   
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002_SLA_REN_Examiner_review_Digest_ApprovedandRefertoCounselsOffice') {}
	   	* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		  * def deficienciesCount = 1
		  * def reviewType = 'Define Deficiencies'		
	 	 * call read('AmendmentsCommonMethods.feature@AddDeficiency') {}
	 	 
	 	  * call read('RenewalCommonMethods.feature@RenewalExaminerReviewApprovalToLB') {expStatus:'Additional Info Required'}
		 # * call read('LicensesCommonMethods.feature@ExaminerReviewDefineDeficiencies')
		   * def wait = waitFunc(70)

		* def typeOfNotification = 'Generic Non-Portal'
		* def subject = 'NYS Liquor Authority Licensing Bureau Record Information'
		* def emailBodyData = 'Dear '+legalName+','
		And print emailBodyData
		* def emailBodyData2 = "Important information pertaining to your record(s) is attached."  
		* def emailBodyData3 = "Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date."
		* def emailBodyData4 = "Failure to provide a timely response may result in the disapproval of your application. The response should be sent to the e-mail address provided in the letter."  
        * def emailBodyData5 = "Sincerely yours, \r<br/>New York State Liquor Authority"
		* call read('LicensesCommonMethods.feature@ValidateEmailCommunicationQueue') {}
		* match serverResponseNotificationData[0].emailBody contains emailBodyData2
		* match serverResponseNotificationData[0].emailBody contains emailBodyData3
		* match serverResponseNotificationData[0].emailBody contains emailBodyData4
		* match serverResponseNotificationData[0].emailBody contains emailBodyData5
				  
	     ## ******************** UC_RenewalExaminerReviewApp: Validate TC0030_SLA_REN_Examiner_Review_Define_Deficiencies_On_Premises_License Scenario End ***************************## 
	     
	     Examples:
    | read('/CSVFiles/RenewalSeasonalOnPremises.csv') | 
    
    
@TC0031_SLA_REN_Examiner_Review_DefineDeficiencies_Permit  
Scenario: TC0031_SLA_REN_Examiner_Review_DefineDeficiencies_Permit
   
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0031_SLA_REN_Examiner_Review_DefineDeficiencies_Permit Scenario Start ***************************##
	   
	   	* call read('UC_RenewalIntakeApp.feature@TC0002_SLA_REN_Intake_Standalone_Permit') {}
	   	* def SafekeepingStatus = false
	   	* def licPerType = 'license'
	   	* call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	   	* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		  * def deficienciesCount = 1
		  * def reviewType = 'Define Deficiencies'		
	 	 * call read('AmendmentsCommonMethods.feature@AddDeficiency') {}
	 	 
	 	  * call read('RenewalCommonMethods.feature@RenewalExaminerReviewApprovalToLB') {expStatus:'Additional Info Required'}
		  #* call read('LicensesCommonMethods.feature@ExaminerReviewDefineDeficiencies')
		   * def wait = waitFunc(70)

		* def typeOfNotification = 'Generic Non-Portal'
		* def subject = 'NYS Liquor Authority Licensing Bureau Record Information'
		* def emailBodyData = 'Dear '+legalName+','
		And print emailBodyData
		* def emailBodyData2 = "Important information pertaining to your record(s) is attached."  
		* def emailBodyData3 = "Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date."
		* def emailBodyData4 = "Failure to provide a timely response may result in the disapproval of your application. The response should be sent to the e-mail address provided in the letter."  
        * def emailBodyData5 = "Sincerely yours, \r<br/>New York State Liquor Authority"
		* call read('LicensesCommonMethods.feature@ValidateEmailCommunicationQueue') {}
		* match serverResponseNotificationData[0].emailBody contains emailBodyData2
		* match serverResponseNotificationData[0].emailBody contains emailBodyData3
		* match serverResponseNotificationData[0].emailBody contains emailBodyData4
		* match serverResponseNotificationData[0].emailBody contains emailBodyData5		  
	     ## ******************** UC_RenewalExaminerReviewApp: Validate TC0031_SLA_REN_Examiner_Review_DefineDeficiencies_Permit Scenario End ***************************## 
    
    
     @TC0032_SLA_REN_Examiner_Review_IntakeDeficiencies_Permit  
Scenario Outline: TC0032_SLA_REN_Examiner_Review_IntakeDeficiencies_Permit
   
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0032_SLA_REN_Examiner_Review_IntakeDeficiencies_Permit Scenario Start ***************************##
	   * call read('UC_RenewalIntakeApp.feature@TC0002_SLA_REN_Intake_Standalone_Permit') {}
	   	* def SafekeepingStatus = false
	   	* def licPerType = 'license'
	   	* call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	   	* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		  * def deficienciesCount = 1
		  * def reviewType = 'Define Deficiencies'		
	 	  * call read('AmendmentsCommonMethods.feature@AddDeficiency') {} 	 
	 	  * call read('RenewalCommonMethods.feature@RenewalExaminerReviewApprovalToLB') {expStatus:'Additional Info Required'}
	 	  * call read('LicensesCommonMethods.feature@AddUpdateOneDeficiencyDetailsPermitExaminerQueue')
	 	  * call read('LicensesCommonMethods.feature@DeleteTextResponseDeficiencyDetailsPermitExaminerQueue')
	 	  * call read('LicensesCommonMethods.feature@SelectUploadDocConditionsForDeficiency')
     ## * call read('LicensesCommonMethods.feature@DeleteUploadedDocConditionsForDeficiency')
      * call read('LicensesCommonMethods.feature@UpdateDeficiencyReceived')
      
	     ## ******************** UC_RenewalExaminerReviewApp: Validate TC0032_SLA_REN_Examiner_Review_IntakeDeficiencies_Permit Scenario End ***************************## 
	     
	     Examples:
    | read('/CSVFiles/RenewalSeasonalOnPremises.csv') |
    
    
    @TC0034_SLA_REN_Examiner_Review_IntakeDeficiencies_On_Premises_License  
Scenario Outline: TC0034_SLA_REN_Examiner_Review_IntakeDeficiencies_On_Premises_License
   
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0034_SLA_REN_Examiner_Review_IntakeDeficiencies_On_Premises_License Scenario Start ***************************##
	   
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002_SLA_REN_Examiner_review_Digest_ApprovedandRefertoCounselsOffice') {}
	   	* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		  * def deficienciesCount = 1
		  * def reviewType = 'Define Deficiencies'		
	 	  * call read('AmendmentsCommonMethods.feature@AddDeficiency') {} 
	 	  * call read('RenewalCommonMethods.feature@RenewalExaminerReviewApprovalToLB') {expStatus:'Additional Info Required'}
	 	   * call read('LicensesCommonMethods.feature@AddUpdateOneDeficiencyDetailsPermitExaminerQueue')
	 	  * call read('LicensesCommonMethods.feature@DeleteTextResponseDeficiencyDetailsPermitExaminerQueue')
	 	  * call read('LicensesCommonMethods.feature@SelectUploadDocConditionsForDeficiency')
     ## * call read('LicensesCommonMethods.feature@DeleteUploadedDocConditionsForDeficiency')
      * call read('LicensesCommonMethods.feature@AddUpdateOneDeficiencyDetailsPermitExaminerQueue')
      * call read('LicensesCommonMethods.feature@UpdateDeficiencyReceived')
	 	  
	     ## ******************** UC_RenewalExaminerReviewApp: Validate TC0034_SLA_REN_Examiner_Review_IntakeDeficiencies_On_Premises_License Scenario End ***************************## 
	     
	     Examples:
    | read('/CSVFiles/RenewalSeasonalOnPremises.csv') |
    
    
    @TC0035_SLA_REN_Examiner_Review_IntakeDeficiencies_License  
Scenario Outline: TC0035_SLA_REN_Examiner_Review_IntakeDeficiencies_License
   
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0035_SLA_REN_Examiner_Review_IntakeDeficiencies_License Scenario Start ***************************##
	   
	    
	    * call read('Uc_RenewalExaminerReview.feature@TC0002A_SLA_REN_Examiner_review_Common_Digest_License') {}
	   	* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		  * def deficienciesCount = 1
		  * def reviewType = 'Define Deficiencies'		
	 	  * call read('AmendmentsCommonMethods.feature@AddDeficiency') {}	  
	 	  * call read('RenewalCommonMethods.feature@RenewalExaminerReviewApprovalToLB') {expStatus:'Additional Info Required'}
	 	  * call read('LicensesCommonMethods.feature@AddUpdateOneDeficiencyDetailsPermitExaminerQueue')
	 	  * call read('LicensesCommonMethods.feature@DeleteTextResponseDeficiencyDetailsPermitExaminerQueue')
	 	  * call read('LicensesCommonMethods.feature@SelectUploadDocConditionsForDeficiency')
     ## * call read('LicensesCommonMethods.feature@DeleteUploadedDocConditionsForDeficiency')
       * call read('LicensesCommonMethods.feature@AddUpdateOneDeficiencyDetailsPermitExaminerQueue')
      * call read('LicensesCommonMethods.feature@UpdateDeficiencyReceived')
	 	  
		  
	     ## ******************** UC_RenewalExaminerReviewApp: Validate TC0035_SLA_REN_Examiner_Review_IntakeDeficiencies_License Scenario End ***************************## 
	     
	     Examples:
    | read('/CSVFiles/RenewalSeasonalOnPremises.csv') |
    
    
      @TC0036_SLA_REN_Examiner_Review_Deficiencies_Permit_AllDeficiencies_met_YES  
Scenario: TC0036_SLA_REN_Examiner_Review_Deficiencies_Permit_AllDeficiencies_met_YES
   
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0036_SLA_REN_Examiner_Review_Deficiencies_Permit_AllDeficiencies_met_YES Scenario Start ***************************##
	      
	   	* call read('UC_RenewalIntakeApp.feature@TC0002_SLA_REN_Intake_Standalone_Permit') {}
	   	* def SafekeepingStatus = false
	   	* def licPerType = 'license'
	   	* call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	   	* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		  * def deficienciesCount = 1
		  * def reviewType = 'Define Deficiencies'		
	 	  * call read('AmendmentsCommonMethods.feature@AddDeficiency') {} 	 
	 	  * call read('RenewalCommonMethods.feature@RenewalExaminerReviewApprovalToLB') {expStatus:'Additional Info Required'}
	 	  * call read('RenewalCommonMethods.feature@RenwealExaminerReviewDeficiencesReceivedSubmit') {expStatus:'Additional Info Received'}
	 	  
		  
	     ## ******************** UC_RenewalExaminerReviewApp: Validate TC0036_SLA_REN_Examiner_Review_Deficiencies_Permit_AllDeficiencies_met_YES Scenario End ***************************## 
	 
    
     @TC0037_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_No_Define_YES_Final_YES  
Scenario: TC0037_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_No_Define_YES_Final_YES
   
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0037_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_No_Define_YES_Final_YES Scenario Start ***************************##
	      
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002A_SLA_REN_Examiner_review_Common_Digest_License') {}
	   	* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		  * def deficienciesCount = 1
		  * def reviewType = 'Define Deficiencies'		
	  	* call read('AmendmentsCommonMethods.feature@AddDeficiency') {}	 	  
	 	  * call read('RenewalCommonMethods.feature@RenewalExaminerReviewApprovalToLB') {expStatus:'Additional Info Required'}
		  * call read('RenewalCommonMethods.feature@RenwealExaminerReviewDeficiencesReceivedSubmit') {expStatus:'Additional Info Received'}
		  * call read('AmendmentsCommonMethods.feature@AddDeficiency') {}	 	
		  * call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewDefineDefencies') {expStatus:'Additional Info Required'}
		  
	     ## ******************** UC_RenewalExaminerReviewApp: Validate TC0037_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_No_Define_YES_Final_YES Scenario End ***************************## 
	     
	       
    
    @TC0038_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_No_Define_NO_Final_NO  
Scenario Outline: TC0038_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_No_Define_NO_Final_NO
   
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0038_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_No_Define_NO_Final_NO Scenario Start ***************************##
	      
	    * call read('Uc_RenewalExaminerReview.feature@TC0002A_SLA_REN_Examiner_review_Common_Digest_License') {}
	   	* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		  * def deficienciesCount = 1
		  * def reviewType = 'Define Deficiencies'		
	  	* call read('AmendmentsCommonMethods.feature@AddDeficiency') {}	 	  
	 	  * call read('RenewalCommonMethods.feature@RenewalExaminerReviewApprovalToLB') {expStatus:'Additional Info Required'}
		  * call read('RenewalCommonMethods.feature@RenwealExaminerReviewDeficiencesReceivedSubmit') {expStatus:'Additional Info Received'}
		  * call read('AmendmentsCommonMethods.feature@AddNoDeficiency') {}	 	
		  * call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewNoDefineDefencies') 
		  
	     ## ******************** UC_RenewalExaminerReviewApp: Validate TC0038_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_No_Define_NO_Final_NO Scenario End ***************************## 
	     
	     Examples:
    | read('/CSVFiles/RenewalSeasonalOnPremises.csv') |
    
    
    
    @TC0039_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_NO_Final_deficiency_Checked_before  
Scenario Outline: TC0039_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_NO_Final_deficiency_Checked_before
   
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0039_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_NO_Final_deficiency_Checked_before Scenario Start ***************************##
	      
	     * call read('Uc_RenewalExaminerReview.feature@TC0002A_SLA_REN_Examiner_review_Common_Digest_License') {}
	   	* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		  * def deficienciesCount = 1
		  * def reviewType = 'Define Deficiencies'		
	  	* call read('AmendmentsCommonMethods.feature@AddDeficiency') {}	 	  
	 	  * call read('RenewalCommonMethods.feature@RenewalExaminerReviewApprovalToLB') {expStatus:'Additional Info Required'}
		  * call read('RenewalCommonMethods.feature@RenwealExaminerReviewDeficiencesReceivedSubmit') {expStatus:'Additional Info Received'}
		  * call read('AmendmentsCommonMethods.feature@AddNoDeficiency') {}	 	
		  * call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewNoDefineDefencies') 
		  
	     ## ******************** UC_RenewalExaminerReviewApp: Validate TC0039_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_NO_Final_deficiency_Checked_before Scenario End ***************************## 
	     
	     Examples:
    | read('/CSVFiles/RenewalSeasonalOnPremises.csv') |
   
@TC0040_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_No_Define_YES_Final_NO  
Scenario Outline: TC0040_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_No_Define_YES_Final_NO
   
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0040_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_No_Define_YES_Final_NO Scenario Start ***************************##
	      
	   * call read('Uc_RenewalExaminerReview.feature@TC0002A_SLA_REN_Examiner_review_Common_Digest_License') {}
	   	* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		  * def deficienciesCount = 1
		  * def reviewType = 'Define Deficiencies'		
	  	* call read('AmendmentsCommonMethods.feature@AddDeficiency') {}	 	  
	 	  * call read('RenewalCommonMethods.feature@RenewalExaminerReviewApprovalToLB') {expStatus:'Additional Info Required'}
		  * call read('RenewalCommonMethods.feature@RenwealExaminerReviewDeficiencesReceivedSubmit') {expStatus:'Additional Info Received'}
		  * call read('AmendmentsCommonMethods.feature@AddNoDeficiency') {}	 	
		  * call read('AmendmentsCommonMethods.feature@AddDeficiency') {}	 	
		  * call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewDefineDefenciesWithNoDefineYESFinalNO') {expStatus:'Additional Info Received'}
		
		  
	     ## ******************** UC_RenewalExaminerReviewApp: Validate TC0040_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_No_Define_YES_Final_NO Scenario End ***************************## 
	     
	     Examples:
    | read('/CSVFiles/RenewalSeasonalOnPremises.csv') |
        
    
@TC0041_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_YES_Define_YES_Final_YES_response_OK  
Scenario Outline: TC0041_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_YES_Define_YES_Final_YES_response_OK
   
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0041_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_YES_Define_YES_Final_YES_response_OK Scenario Start ***************************##
	      
	    * call read('Uc_RenewalExaminerReview.feature@TC0002A_SLA_REN_Examiner_review_Common_Digest_License') {}
	   	* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		  * def deficienciesCount = 1
		  * def reviewType = 'Define Deficiencies'		
	  	* call read('AmendmentsCommonMethods.feature@AddDeficiency') {}	 	  
	 	  * call read('RenewalCommonMethods.feature@RenewalExaminerReviewApprovalToLB') {expStatus:'Additional Info Required'}
		  * call read('RenewalCommonMethods.feature@RenwealExaminerReviewDeficiencesReceivedSubmit') {expStatus:'Additional Info Received'}
	  	* call read('AmendmentsCommonMethods.feature@AddYesAllDeficiencyOnly') {}
		  * call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewDefineDefenciesWithYesDefineYESFinalYes') {expStatus:'Additional Info Received'}
		  
	     ## ******************** UC_RenewalExaminerReviewApp: Validate TC0041_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_YES_Define_YES_Final_YES_response_OK Scenario End ***************************## 
	     
	     Examples:
    | read('/CSVFiles/RenewalSeasonalOnPremises.csv') |
    
    
    
    
@TC0042_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_YES_Define_YES_Final_YES_response_NO  
Scenario Outline: TC0042_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_YES_Define_YES_Final_YES_response_NO
   
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0042_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_YES_Define_YES_Final_YES_response_NO Scenario Start ***************************##
	      
	    * call read('Uc_RenewalExaminerReview.feature@TC0002A_SLA_REN_Examiner_review_Common_Digest_License') {}
	   	* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		  * def deficienciesCount = 1
		  * def reviewType = 'Define Deficiencies'		
	  	* call read('AmendmentsCommonMethods.feature@AddDeficiency') {}	 	  
	 	  * call read('RenewalCommonMethods.feature@RenewalExaminerReviewApprovalToLB') {expStatus:'Additional Info Required'}
		  * call read('RenewalCommonMethods.feature@RenwealExaminerReviewDeficiencesReceivedSubmit') {expStatus:'Additional Info Received'}
		  * call read('AmendmentsCommonMethods.feature@AddNoDeficiency') {}	 	
		  * call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewNoDefineDefencies') 
		  * call read('RenewalCommonMethods.feature@RenewalExaminerReviewSelectDecisionDeficiencyToLB') {expStatus:'Awaiting Review'}
	     ## ******************** UC_RenewalExaminerReviewApp: Validate TC0042_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_YES_Define_YES_Final_YES_response_NO Scenario End ***************************## 
	     
	     Examples:
    | read('/CSVFiles/RenewalSeasonalOnPremises.csv') |
  
  
  
  
@TC0043_SLA_REN_ExaminersReview_SendDeficiency_Reminder  
Scenario Outline: TC0043_SLA_REN_ExaminersReview_SendDeficiency_Reminder
   
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0043_SLA_REN_ExaminersReview_SendDeficiency_Reminder Scenario Start ***************************##
	      
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002_SLA_REN_Examiner_review_Digest_ApprovedandRefertoCounselsOffice') {}
	   	* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		  * def deficienciesCount = 1
		  * def reviewType = 'Define Deficiencies'		
	 	  * call read('RenewalCommonMethods.feature@RenewalExaminerReviewApprovalToLB') {expStatus:'Additional Info Required'}
		  ##* call read('LicensesCommonMethods.feature@SearchAndValidatePermitExaminerQueue')
		  ##* call read('RenewalCommonMethods.feature@ValidateAddDeficiencyDetails) //Unable to validate deficiency reminder
		
	     ## ******************** UC_RenewalExaminerReviewApp: Validate TC0043_SLA_REN_ExaminersReview_SendDeficiency_Reminder Scenario End ***************************## 
	     
	     Examples:
    | read('/CSVFiles/RenewalSeasonalOnPremises.csv') |
  
  
  
@TC0044_SLA_REN_ExaminersReview_Send_DisapprovalLetter  
Scenario Outline: TC0044_SLA_REN_ExaminersReview_Send_DisapprovalLetter
   
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0044_SLA_REN_ExaminersReview_Send_DisapprovalLetter Scenario Start ***************************##
	      
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002_SLA_REN_Examiner_review_Digest_ApprovedandRefertoCounselsOffice') {}
	   	* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		  * def deficienciesCount = 1
		  * def reviewType = 'Define Deficiencies'		
	 	  * call read('RenewalCommonMethods.feature@RenewalExaminerReviewApprovalToLB') {expStatus:'Additional Info Required'}
		  ##* call read('LicensesCommonMethods.feature@SearchAndValidatePermitExaminerQueue')
		  ##* call read('RenewalCommonMethods.feature@ValidateAddDeficiencyDetails) //Unable to validate Workflow Services
		
	     ## ******************** UC_RenewalExaminerReviewApp: Validate TC0044_SLA_REN_ExaminersReview_Send_DisapprovalLetter Scenario End ***************************## 
	     
	     Examples:
    | read('/CSVFiles/RenewalSeasonalOnPremises.csv') |
    

@TC0045_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice	  
Scenario: TC0045_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice
   	## ******************** UC_RenewalExaminerReview: Validate TC0045_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002_SLA_REN_Examiner_review_Digest_ApprovedandRefertoCounselsOffice') {}
         * def SafekeepingStatus = false
	   	 * def licPerType = 'license'
	   	* call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproveAndReferToCounsel') {expStatus:'Approved'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	    * call read('LicensesCommonMethods.feature@GetLicenseId') {} 
	   	 And print licenseId
	   	* call read('LicensesCommonMethods.feature@SearchAndValidateCounselAttorneyQueue') {} 
	   	 
	## ******************** UC_RenewalExaminerReview: Validate TC0045_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice  Scenario End ***************************##
	
@TC0046_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping	  
Scenario: TC0046_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping
   	## ******************** UC_RenewalExaminerReview: Validate TC0045_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002_SLA_REN_Examiner_review_Digest_ApprovedandRefertoCounselsOffice') {}
         * def SafekeepingStatus = true
	   	 * def licPerType = 'license'
	   	* call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproveAndReferToCounsel') {expStatus:'Approved'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
	    * call read('LicensesCommonMethods.feature@GetLicenseId') {} 
	   	 And print licenseId
	   	* call read('LicensesCommonMethods.feature@SearchAndValidateCounselAttorneyQueue') {} 
	   	 
	## ******************** UC_RenewalExaminerReview: Validate TC0046_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping  Scenario End ***************************##
		
	
	
 
@TC0047_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Define_provisions_Removal	  
Scenario: TC0047_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Define_provisions_Removal
   	## ******************** UC_RenewalExaminerReview: Validate TC0047_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Define_provisions_Removal Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002_SLA_REN_Examiner_review_Digest_ApprovedandRefertoCounselsOffice') {}
         * def SafekeepingStatus = false
	   	 * def licPerType = 'Removal'
	   	* call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproveAndReferToCounsel') {expStatus:'Approved'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	    * call read('LicensesCommonMethods.feature@GetLicenseId') {} 
	   	 And print licenseId
	   	* call read('LicensesCommonMethods.feature@SearchAndValidateCounselAttorneyQueue') {} 
	   	 
	## ******************** UC_RenewalExaminerReview: Validate TC0047_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Define_provisions_Removal  Scenario End ***************************##   

       

 
@TC0048_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Define_provisions_Corporate_Change	  
Scenario: TC0048_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Define_provisions_Corporate_Change
   	## ******************** UC_RenewalExaminerReview: Validate TC0048_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Define_provisions_Corporate_Change Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002_SLA_REN_Examiner_review_Digest_ApprovedandRefertoCounselsOffice') {}
         * def SafekeepingStatus = false
	   	 * def licPerType = 'CorporateChange'
	   	 
	   		* call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproveAndReferToCounsel') {expStatus:'Approved'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	    * call read('LicensesCommonMethods.feature@GetLicenseId') {} 
	   	 And print licenseId
	   	* call read('LicensesCommonMethods.feature@SearchAndValidateCounselAttorneyQueue') {} 
	   	 
	## ******************** UC_RenewalExaminerReview: Validate TC0048_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Define_provisions_Corporate_Change  Scenario End ***************************##   

 
@TC0049_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Define_provisions_Alteration	  
Scenario: TC0049_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Define_provisions_Alteration
   	## ******************** UC_RenewalExaminerReview: Validate TC0049_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Define_provisions_Alteration Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002_SLA_REN_Examiner_review_Digest_ApprovedandRefertoCounselsOffice') {}
         * def SafekeepingStatus = false
	   	 * def licPerType = 'Alteration'
	   		* call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproveAndReferToCounsel') {expStatus:'Approved'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	    * call read('LicensesCommonMethods.feature@GetLicenseId') {} 
	   	 And print licenseId
	   	* call read('LicensesCommonMethods.feature@SearchAndValidateCounselAttorneyQueue') {} 
	   	 
	## ******************** UC_RenewalExaminerReview: Validate TC0049_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Define_provisions_Alteration  Scenario End ***************************##   


@TC0050_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Define_provisions_Endorsement	  
Scenario: TC0050_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Define_provisions_Endorsement
   	## ******************** UC_RenewalExaminerReview: Validate TC0050_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Define_provisions_Endorsement Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002_SLA_REN_Examiner_review_Digest_ApprovedandRefertoCounselsOffice') {}
         * def SafekeepingStatus = false
	   	 * def licPerType = 'Endorsement'
	   		* call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproveAndReferToCounsel') {expStatus:'Approved'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	    * call read('LicensesCommonMethods.feature@GetLicenseId') {} 
	   	 And print licenseId
	   	* call read('LicensesCommonMethods.feature@SearchAndValidateCounselAttorneyQueue') {} 
	   	 
	## ******************** UC_RenewalExaminerReview: Validate TC0050_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Define_provisions_Endorsement  Scenario End ***************************##   
        
  	
@TC0051_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping_Define_provisions_Removal	  
Scenario: TC0051_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping_Define_provisions_Removal
   	## ******************** UC_RenewalExaminerReview: Validate TC0051_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping_Define_provisions_Removal Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002_SLA_REN_Examiner_review_Digest_ApprovedandRefertoCounselsOffice') {}
         * def SafekeepingStatus = true
	   	 * def licPerType = 'Removal'
	   	* call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproveAndReferToCounsel') {expStatus:'Approved'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
	    * call read('LicensesCommonMethods.feature@GetLicenseId') {} 
	   	 And print licenseId
	   	* call read('LicensesCommonMethods.feature@SearchAndValidateCounselAttorneyQueue') {} 
	   	 
	## ******************** UC_RenewalExaminerReview: Validate TC0051_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping_Define_provisions_Removal  Scenario End ***************************##   

       

 
@TC0052_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping_Define_provisions_Corporate_Change	  
Scenario: TC0052_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping_Define_provisions_Corporate_Change
   	## ******************** UC_RenewalExaminerReview: Validate TC0052_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping_Define_provisions_Corporate_Change Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002_SLA_REN_Examiner_review_Digest_ApprovedandRefertoCounselsOffice') {}
         * def SafekeepingStatus = true
	   	 * def licPerType = 'CorporateChange'
	   	 
	   		* call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproveAndReferToCounsel') {expStatus:'Approved'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
	    * call read('LicensesCommonMethods.feature@GetLicenseId') {} 
	   	 And print licenseId
	   	* call read('LicensesCommonMethods.feature@SearchAndValidateCounselAttorneyQueue') {} 
	   	 
	## ******************** UC_RenewalExaminerReview: Validate TC0052_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping_Define_provisions_Corporate_Change  Scenario End ***************************##   

 
@TC0053_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping_Define_provisions_Alteration	  
Scenario: TC0053_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping_Define_provisions_Alteration
   	## ******************** UC_RenewalExaminerReview: Validate TC0053_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping_Define_provisions_Alteration Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002_SLA_REN_Examiner_review_Digest_ApprovedandRefertoCounselsOffice') {}
         * def SafekeepingStatus = true
	   	 * def licPerType = 'Alteration'
	   		* call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproveAndReferToCounsel') {expStatus:'Approved'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
	    * call read('LicensesCommonMethods.feature@GetLicenseId') {} 
	   	 And print licenseId
	   	* call read('LicensesCommonMethods.feature@SearchAndValidateCounselAttorneyQueue') {} 
	   	 
	## ******************** UC_RenewalExaminerReview: Validate TC0053_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping_Define_provisions_Alteration  Scenario End ***************************##   


@TC0054_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping_Define_provisions_Endorsement	  
Scenario: TC0054_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping_Define_provisions_Endorsement
   	## ******************** UC_RenewalExaminerReview: Validate TC0054_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping_Define_provisions_Endorsement Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002_SLA_REN_Examiner_review_Digest_ApprovedandRefertoCounselsOffice') {}
         * def SafekeepingStatus = true
	   	 * def licPerType = 'Endorsement'
	   		* call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproveAndReferToCounsel') {expStatus:'Approved'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
	    * call read('LicensesCommonMethods.feature@GetLicenseId') {} 
	   	 And print licenseId
	   	* call read('LicensesCommonMethods.feature@SearchAndValidateCounselAttorneyQueue') {} 
	   	 
	## ******************** UC_RenewalExaminerReview: Validate TC0054_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping_Define_provisions_Endorsement  Scenario End ***************************##   
        
@TC0055_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice	  
Scenario: TC0055_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice
   	## ******************** UC_RenewalExaminerReview: Validate TC0055_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002_SLA_REN_Examiner_review_Digest_Approved_and_Hold_for_CB_notice') {}
         * def SafekeepingStatus = false
	   	 * def licPerType = 'license'
	   		* call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproveAndHold_for_CBNotice') {expStatus:'Hold for CB Notice'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	    
	   	 
	## ******************** UC_RenewalExaminerReview: Validate TC0055_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice  Scenario End ***************************##   
        
@TC0056_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping	  
Scenario: TC0056_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping
   	## ******************** UC_RenewalExaminerReview: Validate TC0056_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002_SLA_REN_Examiner_review_Digest_Approved_and_Hold_for_CB_notice') {}
         * def SafekeepingStatus = true
	   	 * def licPerType = 'license'
	   		* call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproveAndHold_for_CBNotice') {expStatus:'Hold for CB Notice'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
	    
	   	 
	## ******************** UC_RenewalExaminerReview: Validate TC0056_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping  Scenario End ***************************##   
    
    
    
@TC0057_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Define_provisions_Removal  
Scenario: TC0057_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Define_provisions_Removal
   	## ******************** UC_RenewalExaminerReview: Validate TC0057_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Define_provisions_Removal Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002_SLA_REN_Examiner_review_Digest_Approved_and_Hold_for_CB_notice') {}
         * def SafekeepingStatus = false
	   	 * def licPerType = 'Removal'
	   		* call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproveAndHold_for_CBNotice') {expStatus:'Hold for CB Notice'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	    
	   	 
	## ******************** UC_RenewalExaminerReview: Validate TC0057_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Define_provisions_Removal  Scenario End ***************************##   
     
@TC0058_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Define_provisions_CorporateChange	  
Scenario: TC0058_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Define_provisions_CorporateChange
   	## ******************** UC_RenewalExaminerReview: Validate TC0058_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Define_provisions_CorporateChange Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002_SLA_REN_Examiner_review_Digest_Approved_and_Hold_for_CB_notice') {}
         * def SafekeepingStatus = false
	   	 * def licPerType = 'CorporateChange'
	   		* call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproveAndHold_for_CBNotice') {expStatus:'Hold for CB Notice'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	    
	   	 
	## ******************** UC_RenewalExaminerReview: Validate TC0058_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Define_provisions_CorporateChange  Scenario End ***************************##   
     
@TC0059_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Define_provisions_Alternation	  
Scenario: TC0059_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Define_provisions_Alternation
   	## ******************** UC_RenewalExaminerReview: Validate TC0059_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Define_provisions_Alternation Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002_SLA_REN_Examiner_review_Digest_Approved_and_Hold_for_CB_notice') {}
         * def SafekeepingStatus = false
	   	 * def licPerType = 'Alternation'
	   		* call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproveAndHold_for_CBNotice') {expStatus:'Hold for CB Notice'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	    
	   	 
	## ******************** UC_RenewalExaminerReview: Validate TC0059_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Define_provisions_Alternation  Scenario End ***************************##   
     	 	
  	
@TC0060_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Define_provisions_Endorsement	  
Scenario: TC0060_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Define_provisions_Endorsement
   	## ******************** UC_RenewalExaminerReview: Validate TC0060_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Define_provisions_Endorsement Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002_SLA_REN_Examiner_review_Digest_Approved_and_Hold_for_CB_notice') {}
         * def SafekeepingStatus = false
	   	 * def licPerType = 'Endorsement'
	   		* call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproveAndHold_for_CBNotice') {expStatus:'Hold for CB Notice'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	    
	   	 
	## ******************** UC_RenewalExaminerReview: Validate TC0060_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Define_provisions_Endorsement  Scenario End ***************************##   
     	 	
  	
   
    
@TC0061_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping_Define_provisions_Removal  
Scenario: TC0061_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping_Define_provisions_Removal
   	## ******************** UC_RenewalExaminerReview: Validate TC0061_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping_Define_provisions_Removal Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002_SLA_REN_Examiner_review_Digest_Approved_and_Hold_for_CB_notice') {}
         * def SafekeepingStatus = true
	   	 * def licPerType = 'Removal'
	   		* call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproveAndHold_for_CBNotice') {expStatus:'Hold for CB Notice'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
	    
	   	 
	## ******************** UC_RenewalExaminerReview: Validate TC0061_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping_Define_provisions_Removal  Scenario End ***************************##   
     
@TC0062_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping_Define_provisions_CorporateChange	  
Scenario: TC0062_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping_Define_provisions_CorporateChange
   	## ******************** UC_RenewalExaminerReview: Validate TC0062_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping_Define_provisions_CorporateChange Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002_SLA_REN_Examiner_review_Digest_Approved_and_Hold_for_CB_notice') {}
         * def SafekeepingStatus = true
	   	 * def licPerType = 'CorporateChange'
	   		* call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproveAndHold_for_CBNotice') {expStatus:'Hold for CB Notice'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
	    
	   	 
	## ******************** UC_RenewalExaminerReview: Validate TC0062_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping_Define_provisions_CorporateChange  Scenario End ***************************##   
     
@TC0063_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping_Define_provisions_Alternation	  
Scenario: TC0063_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping_Define_provisions_Alternation
   	## ******************** UC_RenewalExaminerReview: Validate TC0063_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping_Define_provisions_Alternation Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002_SLA_REN_Examiner_review_Digest_Approved_and_Hold_for_CB_notice') {}
         * def SafekeepingStatus = true
	   	 * def licPerType = 'Alternation'
	   		* call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproveAndHold_for_CBNotice') {expStatus:'Hold for CB Notice'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
	    
	   	 
	## ******************** UC_RenewalExaminerReview: Validate TC0063_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping_Define_provisions_Alternation  Scenario End ***************************##   
     	 	
  	
@TC0064_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping_Define_provisions_Endorsement	  
Scenario: TC0064_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping_Define_provisions_Endorsement
   	## ******************** UC_RenewalExaminerReview: Validate TC0064_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping_Define_provisions_Endorsement Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002_SLA_REN_Examiner_review_Digest_Approved_and_Hold_for_CB_notice') {}
         * def SafekeepingStatus = true
	   	 * def licPerType = 'Endorsement'
	   		* call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproveAndHold_for_CBNotice') {expStatus:'Hold for CB Notice'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
	    
	   	 
	## ******************** UC_RenewalExaminerReview: Validate TC0064_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping_Define_provisions_Endorsement  Scenario End ***************************##   
     	 	
  
@TC0066_SLA_REN_Examiners_Review_Highly_Deficient	  
Scenario Outline: TC0066_SLA_REN_Examiners_Review_Highly_Deficient
   
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
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees+licAncillaryFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_RenewalExaminerReview: Validate TC0066_SLA_REN_Examiners_Review_Highly_Deficient Scenario Start ***************************##
	   	* call read('LicensesCommonMethods.feature@IntakeLicensewithoutAssociatedLic') {}
        * def CountyName = "New York"
        * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {county:'#(CountyName)'}
        * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
        * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
        #* call read('LicensesCommonMethods.feature@FillAndSaveMethodOfOperationPage') {}
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
	     * def reason = 'Automation Reneal Highly Deficient'
	   * call read('LicensesCommonMethods.feature@SaveReasonHiglyDeficient') {}
	   
	   * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	   	 ## ******************** UC_RenewalExaminerReview: Validate TC0066_SLA_REN_Examiners_Review_Highly_Deficient  Scenario End ***************************##   
	
	
	
 Examples:
    | read('/CSVFiles/RenewalOnPremises.csv') |    

@TC0069_SLA_REN_ExaminersReview_Cancel  
Scenario Outline: TC0069_SLA_REN_ExaminersReview_Cancel
   
   
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0069_SLA_REN_ExaminersReview_Cancel Scenario Start ***************************##
	      
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002_SLA_REN_Examiner_review_Digest_ApprovedandRefertoCounselsOffice') {}
	   	* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		  * def deficienciesCount = 1
		  * def reviewType = 'Define Deficiencies'		
	 	  * call read('RenewalCommonMethods.feature@RenewalExaminerReviewApprovalToLB') {expStatus:'Additional Info Required'}
		  ##* call read('PermitsCommonMethods.feature@SearchAndValidatePermitExaminerQueue')
		  ##* call read('RenewalCommonMethods.feature@ValidateAddDeficiencyDetails)
		  ##* call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproval) {expStatus:'Under Review'}
		  
	     ## ******************** UC_RenewalExaminerReviewApp: Validate TC0069_SLA_REN_ExaminersReview_Cancel Scenario End ***************************## 
	     
 Examples:
    | read('/CSVFiles/RenewalSeasonalOnPremises.csv') |       	 			 	  	 	      	 			 	  	 	  
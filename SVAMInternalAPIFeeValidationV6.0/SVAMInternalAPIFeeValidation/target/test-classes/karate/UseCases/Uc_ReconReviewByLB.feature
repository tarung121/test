Feature: LB review
Background:
			* url BaseURL
			* def config = { username: '#(dbUserName)', password:'#(dbUserPassword)', url: '#(dbQuery)',driverClassName: 'com.microsoft.sqlserver.jdbc.SQLServerDriver' }
    	 	* def DbUtils = Java.type('utils.DbUtils')
    	 	* def defineProvisions = false
    		* def db = new DbUtils(config)
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
		  
@TC0001_SLA_RCN_Review_Recon_Request_LB_Grant_Cause_Main_License	  
Scenario: TC0001_SLA_RCN_Review_Recon_Request_LB_Grant_Cause_Main_License
   
	
	   ## ******************** Uc_ReconReviewByExaminer: Validate TC0001_SLA_RCN_Review_Recon_Request_LB_Grant_Cause_Main_License Scenario Start ***************************##
	   	* call read('Uc_ReconReviewByExaminer.feature@TC0001a_SLA_RCN_Review_Recon_request_Examiner_Grant') {}
	   	
        * call read('LicensesCommonMethods.feature@AddLicenseClaimingQueue') {}
        * def Comments = 'Automation Recon Review Granted'
        * def DeterminationValue = 1
        * def reconType = 'CAUSE'
        * def TaskId = 3509 
	    * call read('ReconCommonMethods.feature@SubmitReconLBDecision') {expStatus:'Recon Granted'}
	    * def wait = waitFunc(40)
    	     * call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'Recond_Granted'}
	   ## ******************** Uc_ReconReviewByExaminer: Validate TC0001_SLA_RCN_Review_Recon_Request_LB_Grant_Cause_Main_License  Scenario End ***************************##   
	

		  
@TC0008_SLA_RCN_Review_Recon_Request_LB_Grant_FTC_Main_License	  
Scenario: TC0008_SLA_RCN_Review_Recon_Request_LB_Grant_FTC_Main_License
   
	
	   ## ******************** Uc_ReconReviewByExaminer: Validate TC0008_SLA_RCN_Review_Recon_Request_LB_Grant_FTC_Main_License Scenario Start ***************************##
	   	* call read('Uc_ReconReviewByExaminer.feature@TC0001_SLA_RCN_Review_Recon_request_Examiner_Grant') {}
        * call read('LicensesCommonMethods.feature@AddLicenseClaimingQueue') {}
        * def Comments = 'FTC Automation Recon Review Granted'
        * def DeterminationValue = 1
        * def reconType = 'FTC'
        * def TaskId = 3509 
      
	    * call read('ReconCommonMethods.feature@SubmitReconLBDecision') {expStatus:'Recon Granted'}
	    * def wait = waitFunc(40)
    	     * call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'Recond_Granted'}
	   ## ******************** Uc_ReconReviewByExaminer: Validate TC0008_SLA_RCN_Review_Recon_Request_LB_Grant_FTC_Main_License  Scenario End ***************************##   
	


 @TC0003_SLA_RCN_Review_Recon_Request_LB_Grant_Cause_Standalone_permit	  
 Scenario Outline: TC0003_SLA_RCN_Review_Recon_Request_LB_Grant_Cause_Standalone_permit
   
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
	     
	    * def CountyID = <countyIds>
	    * def CountyName = <County>	
		* def totalFees = licenseFees+fillingFees+licAncillaryFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0003_SLA_RCN_Review_Recon_Request_LB_Grant_Cause_Standalone_permit Scenario Start ***************************##
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
		* call read('ReconCommonMethods.feature@UploadReconDisapprovalDoc') {}
		 * def lbStatus = 'Disapproved'
		 * def lbDropDownVal = 2
	    * def DisapprovalForCause = true
		* call read('PermitsCommonMethods.feature@PermitLBDisapproval') {expStatus:'Disapproved'}
		
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Disapproved'}
	   
	    * def TaskId = 1611
	     
	    
	    * call read('ReconCommonMethods.feature@SumbitReviewReconRequest') {expStatus:'Reconsideration Review'}
	    * call read('LicensesCommonMethods.feature@AddLicenseClaimingQueue') {}
        * def Comments = 'StandAlone Permit - Automation Recon Review Granted'
        * def DeterminationValue = 1
        * def reconType = 'CAUSE'
        * def TaskId = 3524
	    * call read('ReconCommonMethods.feature@SubmitReconLBDecision') {expStatus:'Recon Granted'}
	    * def wait = waitFunc(40)
	   	  	     * call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'Recond_Granted'} 
	   	 ## ******************** UC_RenewalExaminerReviewApp: Validate TC0003_SLA_RCN_Review_Recon_Request_LB_Grant_Cause_Standalone_permit Scenario End ***************************##   
	
	
	
 Examples:
    | read('/CSVFiles/RenewalStandalonePermit.csv') |   


 @TC0007_SLA_RCN_Review_Recon_Request_LB_Grant_FTC_Standalone_permit	  
 Scenario Outline: TC0007_SLA_RCN_Review_Recon_Request_LB_Grant_FTC_Standalone_permit
   
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
	     
	    * def CountyID = <countyIds>
	    * def CountyName = <County>	
		* def totalFees = licenseFees+fillingFees+licAncillaryFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0007_SLA_RCN_Review_Recon_Request_LB_Grant_FTC_Standalone_permit Scenario Start ***************************##
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
		* call read('ReconCommonMethods.feature@UploadReconDisapprovalDoc') {}
		 * def lbStatus = 'Disapproved'
		 * def lbDropDownVal = 2
	    * def DisapprovalForCause = false
		* call read('PermitsCommonMethods.feature@PermitLBDisapproval') {expStatus:'Disapproved'}
		
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Disapproved'}
	   
	    * def TaskId = 1611
	     
	    
	    * call read('ReconCommonMethods.feature@SumbitReviewReconRequest') {expStatus:'Reconsideration Review'}
	     * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {}
       * def Comments = 'StandAlone Permit - FTC Automation Recon Review Granted'
        * def DeterminationValue = 2
	    * call read('ReconCommonMethods.feature@SubmitReconExaminerQueue') {expStatus:'FTC, Recommend to Grant'}
	    
	    * call read('LicensesCommonMethods.feature@AddLicenseClaimingQueue') {}
        
        * def reconType = 'FTC'
        * def TaskId = 3509
         * def DeterminationValue = 1
	    * call read('ReconCommonMethods.feature@SubmitReconLBDecision') {expStatus:'Recon Granted'}
	     * def wait = waitFunc(40)
	     * call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'Recond_Granted'}
         
	   	 ## ******************** UC_RenewalExaminerReviewApp: Validate TC0007_SLA_RCN_Review_Recon_Request_LB_Grant_FTC_Standalone_permit Scenario End ***************************##   
	
	
	
 Examples:
    | read('/CSVFiles/RenewalStandalonePermit.csv') | 



@TC0002_SLA_RCN_Review_Recon_request_LB_Grant_Cause_Main_license_Associated_license_permit
Scenario: TC0002_SLA_RCN_Review Recon request_LB_Grant_Cause_Main license_Associated license_permit
   

   * callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
   * def DisapprovalForCause = true
    * call read('ReconCommonMethods.feature@AssociatedLicPermitDisApproval') {}
   
	   
	    * def TaskId = 1164
	    * call read('ReconCommonMethods.feature@SumbitReviewReconRequest') {expStatus:'Reconsideration Review'}
	    * call read('LicensesCommonMethods.feature@AddLicenseClaimingQueue') {}
        * def Comments = 'Associated Permit - Automation Recon Review Granted'
        * def DeterminationValue = 1
        * def reconType = 'CAUSE'
        * def TaskId = 3524
	    * call read('ReconCommonMethods.feature@SubmitReconLBDecision') {expStatus:'Recon Granted'}
	    * def wait = waitFunc(40)
	   	* call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'Recond_Granted'} 
	
	
	## End : TC0002_SLA_RCN_Review_Recon_request_LB_Grant_Cause_Main_license_Associated_license_permit ****##
	
     
  

@TC0009_SLA_RCN_Review_Recon_request_LB_Grant_FTC_Associated_Permit
Scenario:TC0009_SLA_RCN_Review_Recon_request_LB_Grant_FTC_Associated_Permit
   
	# ********* Login Functionality *********************
  	## Start: TC0009_SLA_RCN_Review_Recon_request_LB_Grant_FTC_Associated_Permit ****##
	
   * callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
   * def DisapprovalForCause = false
    * call read('ReconCommonMethods.feature@AssociatedLicPermitDisApproval') {}
    * def TaskId = 1164
	    * call read('ReconCommonMethods.feature@SumbitReviewReconRequest') {expStatus:'Reconsideration Review'}
	     * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {}
       * def Comments = 'Associated Permit - FTC Automation Recon Review Granted'
        * def DeterminationValue = 2
	    * call read('ReconCommonMethods.feature@SubmitReconExaminerQueue') {expStatus:'FTC, Recommend to Grant'}
	    
	    * call read('LicensesCommonMethods.feature@AddLicenseClaimingQueue') {}
        
        * def reconType = 'FTC'
        * def TaskId = 3509
         * def DeterminationValue = 1
	    * call read('ReconCommonMethods.feature@SubmitReconLBDecision') {expStatus:'Recon Granted'}
	     * def wait = waitFunc(40)
	     * call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'Recond_Granted'}
         
	
	## End : TC0009_SLA_RCN_Review_Recon_request_LB_Grant_FTC_Associated_Permit ****##
	
    
  	  

 @TC0004_SLA_RCN_Review_Recon_Request_LB_Grant_Cause_temp_permit	  
 Scenario Outline: TC0004_SLA_RCN_Review_Recon_Request_LB_Grant_Cause_temp_permit
   
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
	     
	    * def CountyID = <countyIds>
	    * def CountyName = <County>	
		* def totalFees = licenseFees+fillingFees+licAncillaryFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0004_SLA_RCN_Review_Recon_Request_LB_Grant_Cause_temp_permit Scenario Start ***************************##
	    * call read('PermitsCommonMethods.feature@IntakeTempPermit') {permit_Type:'Temporary Permit', SearchedapplicationId: null}
		* call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('LicensesCommonMethods.feature@FeesValidation') {amount:'#(totalFees)'}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		* call read('ReconCommonMethods.feature@UploadReconDisapprovalDoc') {}
		 * def lbStatus = 'Disapproved'
		 * def lbDropDownVal = 2
	    * def DisapprovalForCause = true
		* call read('PermitsCommonMethods.feature@PermitLBDisapproval') {expStatus:'Disapproved'}
		
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Disapproved'}
	   
	    * def TaskId = 1164
	    * call read('ReconCommonMethods.feature@SumbitReviewReconRequest') {expStatus:'Reconsideration Review'}
	    * call read('LicensesCommonMethods.feature@AddLicenseClaimingQueue') {}
        * def Comments = 'Temp Permit - Automation Recon Review Granted'
        * def DeterminationValue = 1
        * def reconType = 'CAUSE'
        * def TaskId = 3524
	    * call read('ReconCommonMethods.feature@SubmitReconLBDecision') {expStatus:'Recon Granted'}
	    * def wait = waitFunc(40)
	   	* call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'Recond_Granted_ST'} 
	
	
	   	  
	   	     ## ******************** UC_RenewalExaminerReviewApp: Validate TC0004_SLA_RCN_Review_Recon_Request_LB_Grant_Cause_temp_permit Scenario End ***************************##   
	
	
	
 Examples:
    | read('/CSVFiles/RenewalTempPermit.csv') |
       	 			 	  	 	  
       	 			 	  	 	  
 
 @TC0010_SLA_RCN_Review_Recon_Request_LB_Grant_FTC_temp_permit	  
 Scenario Outline: TC0010_SLA_RCN_Review_Recon_Request_LB_Grant_FTC_temp_permit
   
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
	     
	    * def CountyID = <countyIds>
	    * def CountyName = <County>	
		* def totalFees = licenseFees+fillingFees+licAncillaryFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0010_SLA_RCN_Review_Recon_Request_LB_Grant_FTC_temp_permit Scenario Start ***************************##
	    * call read('PermitsCommonMethods.feature@IntakeTempPermit') {permit_Type:'Temporary Permit', SearchedapplicationId: null}
		* call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('LicensesCommonMethods.feature@FeesValidation') {amount:'#(totalFees)'}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		* call read('ReconCommonMethods.feature@UploadReconDisapprovalDoc') {}
		 * def lbStatus = 'Disapproved'
		 * def lbDropDownVal = 2
	    * def DisapprovalForCause = false
		* call read('PermitsCommonMethods.feature@PermitLBDisapproval') {expStatus:'Disapproved'}
		
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Disapproved'}
	   
	    * def TaskId = 1164
	    
	    * call read('ReconCommonMethods.feature@SumbitReviewReconRequest') {expStatus:'Reconsideration Review'}
	     * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {}
       * def Comments = 'Temp Permit - FTC Automation Recon Review Granted'
        * def DeterminationValue = 2
	    * call read('ReconCommonMethods.feature@SubmitReconExaminerQueue') {expStatus:'FTC, Recommend to Grant'}
	    
	    * call read('LicensesCommonMethods.feature@AddLicenseClaimingQueue') {}
        
        * def reconType = 'FTC'
        * def TaskId = 3509
         * def DeterminationValue = 1
	    * call read('ReconCommonMethods.feature@SubmitReconLBDecision') {expStatus:'Recon Granted'}
	     * def wait = waitFunc(40)
	   	* call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'Recond_Granted_ST'} 
	
	
	   	  
	   	     ## ******************** UC_RenewalExaminerReviewApp: Validate TC0010_SLA_RCN_Review_Recon_Request_LB_Grant_FTC_temp_permit Scenario End ***************************##   
	

 Examples:
    | read('/CSVFiles/RenewalTempPermit.csv') |	




@TC0011_SLA_RCN_Review_Recon_request_LB_Grant_FTC_Activate_checked
Scenario: TC0011_SLA_RCN_Review_Recon_request_LB_Grant_FTC_Activate_checked
   * callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
   * def DisapprovalForCause = false
    * call read('ReconCommonMethods.feature@AssociatedLicPermitDisApproval') {}
    * def TaskId = 1164
	 * call read('ReconCommonMethods.feature@SumbitReviewReconRequest') {expStatus:'Reconsideration Review'}
	     * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {}
      	* def DeterminationValue = 2
      * def Comments = 'Associated Lic permit - Automation Recon Review Activate Checked- Recon Granted'
        
	   # * call read('ReconCommonMethods.feature@SubmitReconExaminerQueue') {expStatus:'FTC, Recommend to Grant'}
	    
	   # * call read('LicensesCommonMethods.feature@AddLicenseClaimingQueue') {}
        
       * def reconType = 'FTC'
        * def TaskId = 3509
         * def DeterminationValue = 1
	   # * call read('ReconCommonMethods.feature@SubmitReconLBDecision') {expStatus:'Recon Granted'}
	   #  * def wait = waitFunc(40)
	   #	* call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'Recond_Granted'} 
		
	  	
	## End : TC0011_SLA_RCN_Review_Recon_request_LB_Grant_FTC_Activate_checked ****##

     
     
     
     
     
		
	
@TC0019_SLA_RCN_Review_Recon_request_LB_Recon_Cause_to_Counsels_Office_Main_License	  
Scenario: TC0019_SLA_RCN_Review_Recon_request_LB_Recon_Cause_to_Counsels_Office_Main_License
   
	
	   ## ******************** Uc_ReconReviewByExaminer: Validate TC0019_SLA_RCN_Review_Recon_request_LB_Recon_Cause_to_Counsels_Office_Main_License Scenario Start ***************************##
	   	* call read('Uc_ReconReviewByExaminer.feature@TC0001a_SLA_RCN_Review_Recon_request_Examiner_Grant') {}
        * call read('LicensesCommonMethods.feature@AddLicenseClaimingQueue') {}
        * def Comments = 'Main Lic -Automation Recon Review Send to Counsel'
        * def DeterminationValue = 2
        * def reconType = 'CAUSE'
        * def TaskId = 3524 
        * def DisapprovalForCause = true
		* call read('ReconCommonMethods.feature@SubmitReconLBDecision') {expStatus:'Awaiting Review'}
	  
	     * call read('LicensesCommonMethods.feature@SearchAndValidateCounselQueueApplicationStatus') {letterStatus:'Awaiting Review'}
	    
	    
	## ******************** Uc_ReconReviewByExaminer: Validate TC0019_SLA_RCN_Review_Recon_request_LB_Recon_Cause_to_Counsels_Office_Main_License  Scenario End ***************************##   
		

@TC0020_SLA_RCN_Review_Recon_request_LB_Recon_Cause_to_Counsels_Office_mainLicense_with_Associated_Permit
Scenario: TC0020_SLA_RCN_Review_Recon_request_LB_Recon_Cause_to_Counsels_Office_mainLicense_with_Associated_Permit
   # ********* Login Functionality *********************
   * callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
   * def DisapprovalForCause = true
    * call read('ReconCommonMethods.feature@AssociatedLicPermitDisApproval') {}
    * def TaskId = 1164
    
	
  	## Start: TC0020_SLA_RCN_Review_Recon_request_LB_Recon_Cause_to_Counsels_Office_mainLicense_with_Associated_Permit ****##
	
	    * call read('ReconCommonMethods.feature@SumbitReviewReconRequest') {expStatus:'Reconsideration Review'}
	    * call read('LicensesCommonMethods.feature@AddLicenseClaimingQueue') {}
        * def Comments = 'Associated Permit - Automation Recon Review send to Counsel'
        * def DeterminationValue = 2
        * def reconType = 'CAUSE'
        * def TaskId = 3524
	     * call read('ReconCommonMethods.feature@SubmitReconLBDecision') {expStatus:'Awaiting Review'}
	  
	     * call read('LicensesCommonMethods.feature@SearchAndValidateCounselQueueApplicationStatus') {letterStatus:'Awaiting Review'}
	    
	
	## End : TC0020_SLA_RCN_Review_Recon_request_LB_Recon_Cause_to_Counsels_Office_mainLicense_with_Associated_Permit ****##
 	


 @TC0021_SLA_RCN_Review_Recon_request_LB_Recon_Cause_to_Counsels_Office_Standalone_permit	  
 Scenario Outline: TC0021_SLA_RCN_Review_Recon_request_LB_Recon_Cause_to_Counsels_Office_Standalone_permit
   
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
	     
	    * def CountyID = <countyIds>
	    * def CountyName = <County>	
		* def totalFees = licenseFees+fillingFees+licAncillaryFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0021_SLA_RCN_Review_Recon_request_LB_Recon_Cause_to_Counsels_Office_Standalone_permit Scenario Start ***************************##
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
		* call read('ReconCommonMethods.feature@UploadReconDisapprovalDoc') {}
		 * def lbStatus = 'Disapproved'
		 * def lbDropDownVal = 2
	    * def DisapprovalForCause = true
		* call read('PermitsCommonMethods.feature@PermitLBDisapproval') {expStatus:'Disapproved'}
		
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Disapproved'}
	   
	    * def TaskId = 1611
	    * call read('ReconCommonMethods.feature@SumbitReviewReconRequest') {expStatus:'Reconsideration Review'}
	    * call read('LicensesCommonMethods.feature@AddLicenseClaimingQueue') {}
        * def Comments = 'StandAlone Permit - Automation Recon Review Send to Counsel'
        
        * def reconType = 'CAUSE'
        * def TaskId = 3524
	     
         * def DeterminationValue = 2
	     * call read('ReconCommonMethods.feature@SubmitReconLBDecision') {expStatus:'Awaiting Review'}
	  
	     * call read('LicensesCommonMethods.feature@SearchAndValidateCounselQueueApplicationStatus') {letterStatus:'Awaiting Review'}

	
	   	 ## ******************** UC_RenewalExaminerReviewApp: Validate TC0021_SLA_RCN_Review_Recon_request_LB_Recon_Cause_to_Counsels_Office_Standalone_permit Scenario End ***************************##   
	
	
	
 Examples:
    | read('/CSVFiles/RenewalStandalonePermit.csv') | 
    	
	
 @TC0022_SLA_RCN_Review_Recon_Request_LB_Recon_CausetoCounselsOffice_TempPermit	  
 Scenario Outline: TC0022_SLA_RCN_Review_Recon_Request_LB_Recon_CausetoCounselsOffice_TempPermit
   
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
	     
	    * def CountyID = <countyIds>
	    * def CountyName = <County>	
		* def totalFees = licenseFees+fillingFees+licAncillaryFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0022_SLA_RCN_Review_Recon_Request_LB_Recon_CausetoCounselsOffice_TempPermit Scenario Start ***************************##
	    * call read('PermitsCommonMethods.feature@IntakeTempPermit') {permit_Type:'Temporary Permit', SearchedapplicationId: null}
		* call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('LicensesCommonMethods.feature@FeesValidation') {amount:'#(totalFees)'}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		* call read('ReconCommonMethods.feature@UploadReconDisapprovalDoc') {}
		 * def lbStatus = 'Disapproved'
		 
		 
		 * def lbDropDownVal = 2
	    * def DisapprovalForCause = true
		* call read('PermitsCommonMethods.feature@PermitLBDisapproval') {expStatus:'Disapproved'}
		
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Disapproved'}
	   
	    * def TaskId = 1164
	    * call read('ReconCommonMethods.feature@SumbitReviewReconRequest') {expStatus:'Reconsideration Review'}
	    * call read('LicensesCommonMethods.feature@AddLicenseClaimingQueue') {}
        * def Comments = 'Temp Permit - Automation Recon Review Send TO counsel'
        * def DeterminationValue = 2
        * def reconType = 'CAUSE'
        * def TaskId = 3524
	    * call read('ReconCommonMethods.feature@SubmitReconLBDecision') {expStatus:'Awaiting Review'}
	  
	     * call read('LicensesCommonMethods.feature@SearchAndValidateCounselQueueApplicationStatus') {letterStatus:'Awaiting Review'}

	
	
	   	  
	   	     ## ******************** UC_RenewalExaminerReviewApp: Validate TC0022_SLA_RCN_Review_Recon_Request_LB_Recon_CausetoCounselsOffice_TempPermit Scenario End ***************************##   
	
	
	
 Examples:
    | read('/CSVFiles/RenewalTempPermit.csv') |
       	 			 	  	 	  
       	     	 			 	


@TC0023_SLA_RCN_Review_Recon_request_LB_Recon_Cause_to_Deputy_Commissioner_main_License	  
Scenario: TC0023_SLA_RCN_Review_Recon_request_LB_Recon_Cause_to_Deputy_Commissioner_main_License
   
	
	   ## ******************** Uc_ReconReviewByExaminer: Validate TC0023_SLA_RCN_Review_Recon_request_LB_Recon_Cause_to_Deputy_Commissioner_main_License Scenario Start ***************************##
	   	* call read('Uc_ReconReviewByExaminer.feature@TC0001a_SLA_RCN_Review_Recon_request_Examiner_Grant') {}
        * call read('LicensesCommonMethods.feature@AddLicenseClaimingQueue') {}
        * def Comments = 'Main Lic -Automation Recon Review Send to Deputy Commissioner'
        * def DeterminationValue = 3
        * def reconType = 'CAUSE'
        * def TaskId = 3524 
        * def DisapprovalForCause = true
		* call read('ReconCommonMethods.feature@SubmitReconLBDecision') {expStatus:'Cause, Review Requested'}
	  
	    
	## ******************** Uc_ReconReviewByExaminer: Validate TC0023_SLA_RCN_Review_Recon_request_LB_Recon_Cause_to_Deputy_Commissioner_main_License  Scenario End ***************************##   
		

@TC0024_SLA_RCN_Review_Recon_request_LB_Recon_Cause_to_Deputy_Commissioner_main_License_with_Associated_Permit
Scenario: TC0024_SLA_RCN_Review_Recon_request_LB_Recon_Cause_to_Deputy_Commissioner_main_License_with_Associated_Permit
   
	# ********* Login Functionality *********************
	 * callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
   * def DisapprovalForCause = true
    * call read('ReconCommonMethods.feature@AssociatedLicPermitDisApproval') {}
    * def TaskId = 1164
  	
	    * call read('ReconCommonMethods.feature@SumbitReviewReconRequest') {expStatus:'Reconsideration Review'}
	    * call read('LicensesCommonMethods.feature@AddLicenseClaimingQueue') {}
        * def Comments = 'Associated Permit - Automation Recon Review send to Deputy Commissioner'
        * def DeterminationValue = 3
        * def reconType = 'CAUSE'
        * def TaskId = 3524
	     * call read('ReconCommonMethods.feature@SubmitReconLBDecision') {expStatus:'Cause, Review Requested'}
	  
	
	## End : TC0024_SLA_RCN_Review_Recon_request_LB_Recon_Cause_to_Deputy_Commissioner_main_License_with_Associated_Permit ****##
 	
	


 @TC0025_SLA_RCN_Review_Recon_request_LB_Recon_Cause_to_Deputy_Commissioner_Standalone_permit	  
 Scenario Outline: TC0025_SLA_RCN_Review_Recon_request_LB_Recon_Cause_to_Deputy_Commissioner_Standalone_permit
   
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
	     
	    * def CountyID = <countyIds>
	    * def CountyName = <County>	
		* def totalFees = licenseFees+fillingFees+licAncillaryFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0025_SLA_RCN_Review_Recon_request_LB_Recon_Cause_to_Deputy_Commissioner_Standalone_permit Scenario Start ***************************##
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
		* call read('ReconCommonMethods.feature@UploadReconDisapprovalDoc') {}
		 * def lbStatus = 'Disapproved'
		 * def lbDropDownVal = 2
	    * def DisapprovalForCause = true
		* call read('PermitsCommonMethods.feature@PermitLBDisapproval') {expStatus:'Disapproved'}
		
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Disapproved'}
	   
	    * def TaskId = 1611
	    * call read('ReconCommonMethods.feature@SumbitReviewReconRequest') {expStatus:'Reconsideration Review'}
	    * call read('LicensesCommonMethods.feature@AddLicenseClaimingQueue') {}
        * def Comments = 'StandAlone Permit - Automation Recon Review Send to Deputy Commissioner '
        
        * def reconType = 'CAUSE'
        * def TaskId = 3524
	     
         * def DeterminationValue = 3
	     * call read('ReconCommonMethods.feature@SubmitReconLBDecision') {expStatus:'Cause, Review Requested'}
	  
	   	 ## ******************** UC_RenewalExaminerReviewApp: Validate TC0025_SLA_RCN_Review_Recon_request_LB_Recon_Cause_to_Deputy_Commissioner_Standalone_permit Scenario End ***************************##   
	
	
	
 Examples:
    | read('/CSVFiles/RenewalStandalonePermit.csv') | 
    	
	
 @TC0026_SLA_RCN_Review_Recon_Request_LB_Recon_Cause_to_Deputy_Commissioner_TempPermit	  
 Scenario Outline: TC0026_SLA_RCN_Review_Recon_Request_LB_Recon_Cause_to_Deputy_Commissioner_TempPermit
   
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
	     
	    * def CountyID = <countyIds>
	    * def CountyName = <County>	
		* def totalFees = licenseFees+fillingFees+licAncillaryFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0026_SLA_RCN_Review_Recon_Request_LB_Recon_Cause_to_Deputy_Commissioner_TempPermit Scenario Start ***************************##
	    * call read('PermitsCommonMethods.feature@IntakeTempPermit') {permit_Type:'Temporary Permit', SearchedapplicationId: null}
		* call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('LicensesCommonMethods.feature@FeesValidation') {amount:'#(totalFees)'}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		* call read('ReconCommonMethods.feature@UploadReconDisapprovalDoc') {}
		 * def lbStatus = 'Disapproved'
		 
		 
		 * def lbDropDownVal = 2
	    * def DisapprovalForCause = true
		* call read('PermitsCommonMethods.feature@PermitLBDisapproval') {expStatus:'Disapproved'}
		
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Disapproved'}
	   
	    * def TaskId = 1164
	    * call read('ReconCommonMethods.feature@SumbitReviewReconRequest') {expStatus:'Reconsideration Review'}
	    * call read('LicensesCommonMethods.feature@AddLicenseClaimingQueue') {}
        * def Comments = 'Temp Permit - Automation Recon Review Send TO counsel'
        * def reconType = 'CAUSE'
        * def TaskId = 3524
	     
         * def DeterminationValue = 3
	     * call read('ReconCommonMethods.feature@SubmitReconLBDecision') {expStatus:'Cause, Review Requested'}
	  
	
	   	  
	   	     ## ******************** UC_RenewalExaminerReviewApp: Validate TC0026_SLA_RCN_Review_Recon_Request_LB_Recon_Cause_to_Deputy_Commissioner_TempPermit Scenario End ***************************##   
	
 Examples:
    | read('/CSVFiles/RenewalTempPermit.csv') |   	
    
    
   			 
@TC0027_SLA_RCN_Review_Recon_request_LB_Deny_FTC_Standalone_permit	  
 Scenario Outline: TC0027_SLA_RCN_Review_Recon_request_LB_Deny_FTC_Standalone_permit
   
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
	     
	    * def CountyID = <countyIds>
	    * def CountyName = <County>	
		* def totalFees = licenseFees+fillingFees+licAncillaryFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0027_SLA_RCN_Review_Recon_request_LB_Deny_FTC_Standalone_permit Scenario Start ***************************##
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
		* call read('ReconCommonMethods.feature@UploadReconDisapprovalDoc') {}
		* def lbStatus = 'Disapproved'
		 * def lbDropDownVal = 2
	    * def DisapprovalForCause = false
		* call read('PermitsCommonMethods.feature@PermitLBDisapproval') {expStatus:'Disapproved'}
		
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Disapproved'}
	   
	    * def TaskId = 1611
	     
	    
	    * call read('ReconCommonMethods.feature@SumbitReviewReconRequest') {expStatus:'Reconsideration Review'}
	     * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {}
      	* def DeterminationValue = 2
	    * call read('ReconCommonMethods.feature@SubmitReconExaminerQueue') {expStatus:'FTC, Recommend to Grant'}
	    
	    * call read('LicensesCommonMethods.feature@AddLicenseClaimingQueue') {}
        
        
       * def Comments = 'Standalone permit - Automation Recon Review FTC Recommend Denial'
        
	   
	    * call read('LicensesCommonMethods.feature@AddLicenseClaimingQueue') {}
       
		* def reconType = 'FTC'
        * def TaskId = 3509 
	   * call read('ReconCommonMethods.feature@SubmitReconLBDecision') {expStatus:'FTC, Recommend Denial'}
	   

      ## ******************** UC_RenewalExaminerReviewApp: Validate TC0027_SLA_RCN_Review_Recon_request_LB_Deny_FTC_Standalone_permit Scenario End ***************************##   
	
	
	
 Examples:
    | read('/CSVFiles/RenewalStandalonePermit.csv') |  	     	 			 

@TC0028_SLA_RCN_Review_Recon_request_LB_Recon_Deny_FTC_main_License	  
Scenario: TC0028_SLA_RCN_Review_Recon_request_LB_Recon_Deny_FTC_main_License
   
	
	   ## ******************** Uc_ReconReviewByExaminer: Validate TC0028_SLA_RCN_Review_Recon_request_LB_Recon_Deny_FTC_main_License Scenario Start ***************************##
	   	* call read('Uc_ReconReviewByExaminer.feature@TC0001_SLA_RCN_Review_Recon_request_Examiner_Grant') {}
        * call read('LicensesCommonMethods.feature@AddLicenseClaimingQueue') {}
        * def Comments = 'Main Lic -Automation Recon Review FTC Recommend Denial'
        
        * def DisapprovalForCause = false
		  * def DeterminationValue = 2
        * def reconType = 'FTC'
        * def TaskId = 3509 
	   * call read('ReconCommonMethods.feature@SubmitReconLBDecision') {expStatus:'FTC, Recommend Denial'}
	   
	## ******************** Uc_ReconReviewByExaminer: Validate TC0028_SLA_RCN_Review_Recon_request_LB_Recon_Deny_FTC_main_License  Scenario End ***************************##   
		

@TC0029_SLA_RCN_Review_Recon_request_LB_Recon_Deny_Associated_Permit
Scenario:  TC0029_SLA_RCN_Review_Recon_request_LB_Recon_Deny_Associated_Permit
   
	# ********* Login Functionality *********************
	* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
   * def DisapprovalForCause = false
    * call read('ReconCommonMethods.feature@AssociatedLicPermitDisApproval') {}
    * def TaskId = 1164
    
  	## Start: TC0029_SLA_RCN_Review_Recon_request_LB_Recon_Deny_Associated_Permit ****##
	
		
	    * call read('ReconCommonMethods.feature@SumbitReviewReconRequest') {expStatus:'Reconsideration Review'}
	     * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {}
      	* def DeterminationValue = 2
	    * call read('ReconCommonMethods.feature@SubmitReconExaminerQueue') {expStatus:'FTC, Recommend to Grant'}
	    
	    * call read('LicensesCommonMethods.feature@AddLicenseClaimingQueue') {}
        
        
       * def Comments = 'Associated permit - Automation Recon Review FTC Recommend Denial'
        
	   
	    * call read('LicensesCommonMethods.feature@AddLicenseClaimingQueue') {}
       
		* def reconType = 'FTC'
        * def TaskId = 3509 
	   * call read('ReconCommonMethods.feature@SubmitReconLBDecision') {expStatus:'FTC, Recommend Denial'}
	   
	## End : TC0029_SLA_RCN_Review_Recon_request_LB_Recon_Deny_Associated_Permit ****##
	
   
     
     

 @TC0030_SLA_RCN_Review_Recon_Request_LB_Deny_FTC_temp_permit	  
 Scenario Outline: TC0030_SLA_RCN_Review_Recon_Request_LB_Deny_FTC_temp_permit
   
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
	     
	    * def CountyID = <countyIds>
	    * def CountyName = <County>	
		* def totalFees = licenseFees+fillingFees+licAncillaryFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_RenewalExaminerReviewApp: Validate TC0030_SLA_RCN_Review_Recon_Request_LB_Deny_FTC_temp_permit Scenario Start ***************************##
	    * call read('PermitsCommonMethods.feature@IntakeTempPermit') {permit_Type:'Temporary Permit', SearchedapplicationId: null}
		* call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('LicensesCommonMethods.feature@FeesValidation') {amount:'#(totalFees)'}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		* call read('ReconCommonMethods.feature@UploadReconDisapprovalDoc') {}
		 * def lbStatus = 'Disapproved'
		 * def lbDropDownVal = 2
	    * def DisapprovalForCause = false
		* call read('PermitsCommonMethods.feature@PermitLBDisapproval') {expStatus:'Disapproved'}
		
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Disapproved'}
	   * def Comments = 'Temp permit - Automation Recon Review FTC Recommend Denial'
	    * def TaskId = 1164
	    
	    * call read('ReconCommonMethods.feature@SumbitReviewReconRequest') {expStatus:'Reconsideration Review'}
	     * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {}
       
       
        * def DeterminationValue = 2
	    * call read('ReconCommonMethods.feature@SubmitReconExaminerQueue') {expStatus:'FTC, Recommend to Grant'}
	    
	    * call read('LicensesCommonMethods.feature@AddLicenseClaimingQueue') {}
        
        
	   
	    * call read('LicensesCommonMethods.feature@AddLicenseClaimingQueue') {}
       
		* def reconType = 'FTC'
        * def TaskId = 3509 
	   * call read('ReconCommonMethods.feature@SubmitReconLBDecision') {expStatus:'FTC, Recommend Denial'}
	   
	   	     ## ******************** UC_RenewalExaminerReviewApp: Validate TC0030_SLA_RCN_Review_Recon_Request_LB_Deny_FTC_temp_permit Scenario End ***************************##   
	

 Examples:
    | read('/CSVFiles/RenewalTempPermit.csv') |	     
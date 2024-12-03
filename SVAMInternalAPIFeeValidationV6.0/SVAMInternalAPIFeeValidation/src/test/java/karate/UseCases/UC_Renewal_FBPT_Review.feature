Feature: Renewal FBPT review
Background:
			* url BaseURL
  			* def config = { username: '#(dbUserName)', password:'#(dbUserPassword)', url: '#(dbQuery)',driverClassName: 'com.microsoft.sqlserver.jdbc.SQLServerDriver' }
    	 	
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
          var dayAfter = new java.util.Date(lastDayOfMonth + java.util.concurrent.TimeUnit.DAYS.toMillis( 365*termInYears));
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
         	    * def waitFunc =
		        """
		      function(timeinMiliSeconds) {
		        // load java type into js engine
		        var Thread = Java.type('java.lang.Thread');
		        Thread.sleep(timeinMiliSeconds); 
		      }
		      """

@TC0001_SLA_REN_FBPT_Review_Redirect_for_LB_Decision	  
Scenario Outline: TC0001_SLA_REN_FBPT_Review_Redirect_for_LB_Decision
   
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
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		#  * call read('LicensesCommonMethods.feature@SaveAndValidateMemoLinkData') {}
		
		  * call read('RenewalCommonMethods.feature@RenewalExaminerReviewApprovalToFBPTQueue') {expStatus:'Awaiting Review'}
	    * def name = 'Redirect to LB'
	    * def value = 1	  
	    * call read('RenewalCommonMethods.feature@RenewalAssignFBPTLicToLB') {}
	    * call read('LicensesCommonMethods.feature@checkApplicationStatus') {expStatus:'Awaiting Review'}
		
	    
	     ## ******************** UC_RenewalExaminerReviewApp: Validate TC0024_SLA_REN_Examiner_Review_FBPT_for_Review_License Scenario End ***************************##   
	
		Examples:
    | read('/CSVFiles/RenewalSeasonalOnPremises.csv') |  	   

@TC0002_SLA_REN_FBPT_Review_Additional_Information_Required	  
Scenario Outline: TC0002_SLA_REN_FBPT_Review_Additional_Information_Required
   
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
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
		#  * call read('LicensesCommonMethods.feature@SaveAndValidateMemoLinkData') {}
		  * call read('RenewalCommonMethods.feature@RenewalExaminerReviewApprovalToFBPTQueue') {expStatus:'Awaiting Review'}
	    * def name = 'Redirect to Examiner'
	    * def value = 3		
	    * call read('RenewalCommonMethods.feature@RenewalAssignFBPTLicToLB') {}
	    * call read('LicensesCommonMethods.feature@checkApplicationStatus') {expStatus:'Additional Info Requested'}
	    	    
	     ## ******************** UC_RenewalExaminerReviewApp: Validate TC0024_SLA_REN_Examiner_Review_FBPT_for_Review_License Scenario End ***************************##   
	
		Examples:
    | read('/CSVFiles/RenewalSeasonalOnPremises.csv') |
                       
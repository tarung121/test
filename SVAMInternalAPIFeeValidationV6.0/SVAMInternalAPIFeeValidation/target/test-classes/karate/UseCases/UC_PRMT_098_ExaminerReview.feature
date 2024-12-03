Feature: Permits Examiner review
Background:
			* url BaseURL
  			* def config = { username: '#(dbUserName)', password:'#(dbUserPassword)', url: '#(dbQuery)',driverClassName: 'com.microsoft.sqlserver.jdbc.SQLServerDriver' }
    	 	* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
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

@TC0001_SLA_PER_Examiner_Send_to_LB_Review
Scenario Outline: TC0001_SLA_PER_Examiner_Send_to_LB_Review

  	
  		
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
	    #* def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees
	    * def splittedCityName = CityName.replaceAll(" ","")
	    * def SearchByLegalName = false
	   	* def SearchByLicId = true
	    * def PermitType = 'Associated'	   	
	   	* def appType = 'NA-'
	   	* def termInYears = 3
	   	* def LicensePermitId = '0002-'
	   	* def termDesc = termInYears +' Year (s)'
	    * call read('AmendmentsCommonMethods.feature@SearchLicPermitIdForAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@IntakePermit') {}
        * call read('LicensesCommonMethods.feature@GetPreFillLicenseAllDetailsByLicenseId') {} 
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('AmendmentsCommonMethods.feature@FillAndSaveApplicantInformationPageAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
	    * call read('LicensesCommonMethods.feature@FeesValidation') {amount:40000}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@PermitExaminerReview') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}    
  Examples:
   | read('/CSVFiles/TC_AssociatedPermitInputs.csv') |   
    
@TC0001a_SLA_PER_Digest_screen
Scenario Outline: TC0001a_SLA_PER_Digest_screen

  	
  		
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
	    #* def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees
	    * def splittedCityName = CityName.replaceAll(" ","")
	    * def SearchByLegalName = false
	   	* def SearchByLicId = true
	    * def PermitType = 'Associated'	   	
	   	* def appType = 'NA-'
	   	* def termInYears = 3
	   	* def LicensePermitId = '0002-'
	   	* def termDesc = termInYears +' Year (s)'
	    * call read('AmendmentsCommonMethods.feature@SearchLicPermitIdForAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@IntakePermit') {}
        * call read('LicensesCommonMethods.feature@GetPreFillLicenseAllDetailsByLicenseId') {} 
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('AmendmentsCommonMethods.feature@FillAndSaveApplicantInformationPageAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
	    * call read('LicensesCommonMethods.feature@FeesValidation') {amount:40000}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@SaveDigestData') {}
	    * call read('LicensesCommonMethods.feature@PermitExaminerReview') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}    
 
  Examples:
   | read('/CSVFiles/TC_AssociatedPermitInputs.csv') | 

@TC0001c_SLA_PER_Solicitor_Digest_screen
Scenario Outline: TC0001c_SLA_PER_Solicitor_Digest_screen

  	
  		
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
	  #  * string productName = <ProductTypes>+''
	    * def CountyId = <countyIds>
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees
	    * def splittedCityName = CityName.replaceAll(" ","")
	    * def SearchByLegalName = false
	   	* def SearchByLicId = true
	    * def PermitType = 'StandAlone'	   	
	   	* def appType = 'NA-'
	   	* def termInYears = 3
	   	* def LicensePermitId = '0002-'
	   	* def termDesc = termInYears +' Year (s)'
    
	    * call read('AmendmentsCommonMethods.feature@SearchLicPermitIdForAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@IntakePermit') {}
     #   * call read('LicensesCommonMethods.feature@GetPreFillLicenseAllDetailsByLicenseId') {} 
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('AmendmentsCommonMethods.feature@FillAndSaveApplicantInformationPageAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
        * call read('AmendmentsCommonMethods.feature@PermitFeesValidationwithMultipleChecks') {amount:1000}	    
	    * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}   
 	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@SaveDigestData') {}
	    * call read('LicensesCommonMethods.feature@PermitExaminerReview') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}    
	 
	  Examples:
    | read('/CSVFiles/TC_Solicitor.csv') |	
    
@TC0001e_NYC_SLA_PER__Examiner__Street_Fair_or_Festival_Digest_Tab
Scenario Outline: TC0001e_NYC_SLA_PER__Examiner__Street_Fair_or_Festival_Digest_Tab

  	
  		
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
	  #  * string productName = <ProductTypes>+''
	    * def CountyId = <countyIds>
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees
	    * def splittedCityName = CityName.replaceAll(" ","")
	    * def SearchByLegalName = false
	   	* def SearchByLicId = true
	    * def PermitType = 'StandAlone'	   	
	   	* def appType = 'NA-'
	   	* def termInYears = 3
	   	* def LicensePermitId = '0002-'
	   	* def termDesc = termInYears +' Year (s)'
    
	    * call read('AmendmentsCommonMethods.feature@IntakePermit') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('AmendmentsCommonMethods.feature@FillAndSaveApplicantInformationPageAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
        * call read('AmendmentsCommonMethods.feature@PermitFeesValidationwithMultipleChecks') {amount:1000}	    
	    * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}   
 	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@SaveDigestData') {}
	    * call read('LicensesCommonMethods.feature@PermitExaminerReview') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}    
	 
	  Examples:
    | read('/CSVFiles/TC_Solicitor2.csv') |	

@TC0003_SLA_PER_Examiner_toFBPTReview	  
Scenario Outline: TC0003_SLA_PER_Examiner_toFBPTReview
   
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
	  #  * string productName = <ProductTypes>+''
	    * def CountyId = <countyIds>
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees
	    * def splittedCityName = CityName.replaceAll(" ","")
	    * def SearchByLegalName = false
	   	* def SearchByLicId = true
	    * def PermitType = 'StandAlone'	   	
	   	* def appType = 'NA-'
	   	* def termInYears = 3
	   	* def LicensePermitId = '0002-'
	   	* def termDesc = termInYears +' Year (s)'
    
	    * call read('AmendmentsCommonMethods.feature@IntakePermit') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('AmendmentsCommonMethods.feature@FillAndSaveApplicantInformationPageAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
        * call read('AmendmentsCommonMethods.feature@PermitFeesValidationwithMultipleChecks') {amount:1000}	    
	    * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}   
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@PermitsExaminerReviewApprovalToFBPTQueue') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@getAndValidateMemoData') {}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
	    
	     ## ******************** UC_PRMT_098_ExaminerReview: Validate TC0003_SLA_PER_Examiner_toFBPTReview Scenario End ***************************##   
	
	
	  Examples:
    | read('/CSVFiles/TC_Solicitor.csv') |	   

@TC0004_SLA_PER_Examiner_DefineDeficiency	  
Scenario Outline: TC0004_SLA_PER_Examiner_DefineDeficiency
   
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
	  #  * string productName = <ProductTypes>+''
	    * def CountyId = <countyIds>
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees
	    * def splittedCityName = CityName.replaceAll(" ","")
	    * def SearchByLegalName = false
	   	* def SearchByLicId = true
	    * def PermitType = 'StandAlone'	   	
	   	* def appType = 'NA-'
	   	* def termInYears = 3
	   	* def LicensePermitId = '0002-'
	   	* def termDesc = termInYears +' Year (s)'
    
	    * call read('AmendmentsCommonMethods.feature@IntakePermit') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('AmendmentsCommonMethods.feature@FillAndSaveApplicantInformationPageAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
        * call read('AmendmentsCommonMethods.feature@PermitFeesValidationwithMultipleChecks') {amount:1000}	    
	    * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}   
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ExaminerReviewApprovalToDefineDeficiencies') {expStatus:'Additional Info Required'}
	    * def wait = waitFunc(60000)
	    * call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'Deficiency Letter'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
	    
	     ## ******************** UC_PRMT_098_ExaminerReview: Validate TC0004_SLA_PER_Examiner_Define Deficiency Scenario End ***************************##   
     
	  Examples:
    | read('/CSVFiles/TC_Solicitor.csv') |     
 
@TC0005_SLA_PER_Examiner_Intake_Deficiency	  
Scenario Outline: TC0005_SLA_PER_Examiner_Intake_Deficiency
   
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
	  #  * string productName = <ProductTypes>+''
	    * def CountyId = <countyIds>
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees
	    * def splittedCityName = CityName.replaceAll(" ","")
	    * def SearchByLegalName = false
	   	* def SearchByLicId = true
	    * def PermitType = 'StandAlone'	   	
	   	* def appType = 'NA-'
	   	* def termInYears = 3
	   	* def LicensePermitId = '0002-'
	   	* def termDesc = termInYears +' Year (s)'
    
	    * call read('AmendmentsCommonMethods.feature@IntakePermit') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('AmendmentsCommonMethods.feature@FillAndSaveApplicantInformationPageAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
        * call read('AmendmentsCommonMethods.feature@PermitFeesValidationwithMultipleChecks') {amount:1000}	    
	    * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}   
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('AmendmentsCommonMethods.feature@AddDeficiency') {}
	    * call read('LicensesCommonMethods.feature@ExaminerReviewApprovalToDefineDeficiencies') {expStatus:'Additional Info Required'}
	    * def wait = waitFunc(60000)
	    * call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'Deficiency Letter'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
	    
	     ## ******************** UC_PRMT_098_ExaminerReview: Validate TC0004_SLA_PER_Examiner_Define Deficiency Scenario End ***************************##   
     
	  Examples:
    | read('/CSVFiles/TC_Solicitor.csv') |        

@TC0006_SLA_PER_Examiner_Review_AllDeficiencies_YES	  
Scenario Outline: TC0006_SLA_PER_Examiner_Review_AllDeficienciesmet_YES
   
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
	  #  * string productName = <ProductTypes>+''
	    * def CountyId = <countyIds>
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees
	    * def splittedCityName = CityName.replaceAll(" ","")
	    * def SearchByLegalName = false
	   	* def SearchByLicId = true
	    * def PermitType = 'StandAlone'	   	
	   	* def appType = 'NA-'
	   	* def termInYears = 3
	   	* def LicensePermitId = '0002-'
	   	* def termDesc = termInYears +' Year (s)'
    
	    * call read('AmendmentsCommonMethods.feature@IntakePermit') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('AmendmentsCommonMethods.feature@FillAndSaveApplicantInformationPageAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
        * call read('AmendmentsCommonMethods.feature@PermitFeesValidationwithMultipleChecks') {amount:1000}	    
	    * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}   
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('AmendmentsCommonMethods.feature@AddDeficiency') {}
	    * call read('LicensesCommonMethods.feature@ExaminerReviewApprovalToDefineWithAllDeficiencies') {expStatus:'Additional Info Required'}

	    * def wait = waitFunc(60000)
	    * call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'Deficiency Letter'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
	    * call read('LicensesCommonMethods.feature@AdditionalinfoReceived') {expStatus:'Additional Info Received'}

	     ## ******************** UC_PRMT_098_ExaminerReview: Validate TC0006_SLA_PER_Examiner_Review_All Deficiencies met_YES Scenario End ***************************##   
	
	  Examples:
    | read('/CSVFiles/TC_Solicitor.csv') |    
    
@TC0006a_SLA_PER_Examiner_Review_Additional_Info_Requested	  
Scenario Outline: TC0006a_SLA_PER_Examiner_Review_Additional_Info_Requested
   
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
	  #  * string productName = <ProductTypes>+''
	    * def CountyId = <countyIds>
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees
	    * def splittedCityName = CityName.replaceAll(" ","")
	    * def SearchByLegalName = false
	   	* def SearchByLicId = true
	    * def PermitType = 'StandAlone'	   	
	   	* def appType = 'NA-'
	   	* def termInYears = 3
	   	* def LicensePermitId = '0002-'
	   	* def termDesc = termInYears +' Year (s)'
    
	    * call read('AmendmentsCommonMethods.feature@IntakePermit') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('AmendmentsCommonMethods.feature@FillAndSaveApplicantInformationPageAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
        * call read('AmendmentsCommonMethods.feature@PermitFeesValidationwithMultipleChecks') {amount:1000}	    
	    * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}   
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('AmendmentsCommonMethods.feature@AddDeficiency') {expStatus:'Additional Info Required'}
	 #   * call read('LicensesCommonMethods.feature@ExaminerReviewApprovalToDefineWithAllDeficiencies') {}

	    * def wait = waitFunc(60000)
	    * call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'Deficiency Letter'}
	   	* def typeOfNotification = 'Application Receipt'
		* def subject = 'NYS Liquor Authority Licensing Bureau Record Information'
		* def emailBodyData = 'Dear '+legalName+','
		And print emailBodyData
		* def emailBodyData2 = 'Important information pertaining to your record(s) is attached.'  
		* def emailBodyData3 = 'Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date.'
		* def emailBodyData4 = 'Failure to provide a timely response may result in the disapproval of your application. The response should be sent to the e-mail address provided in the letter.'  
        * def emailBodyData5 = 'Sincerely yours,'
        * def emailBodyData6 = 'New York State Liquor Authority'

		* call read('LicensesCommonMethods.feature@ValidateEmailCommunicationQueue') {}
		* match serverResponseNotificationData[0].emailBody contains emailBodyData2
		* match serverResponseNotificationData[0].emailBody contains emailBodyData3
		* match serverResponseNotificationData[0].emailBody contains emailBodyData4
		* match serverResponseNotificationData[0].emailBody contains emailBodyData5	
		* match serverResponseNotificationData[0].emailBody contains emailBodyData6
		
		* def typeOfNotification = 'Generic Non-Portal'
		* def subject = 'NYS Liquor Authority Licensing Bureau Record Information'
		* def emailBodyData = ''+date+''
		And print emailBodyData
		* def emailBodyData2 = ''+ApplicationId+''  
		* def emailBodyData3 = ''+legalName+''
		* def emailBodyData4 = ''+Address1+''  
        * def emailBodyData5 = 'A review of your application shows the following deficiencies.  A response correcting ALL DEFICIENCIES must be received at the address listed below, or by email at '+emailId+', NO LATER THAN or the application will be disapproved.'
        * def emailBodyData6 = ''
        * def emailBodyData7 = 'Respectfully,'
        * def emailBodyData8 = 'Deficiency Resolution Team'
        * def emailBodyData9 = 'State Liquor Authority'

		* call read('LicensesCommonMethods.feature@ValidateEmailCommunicationQueue') {}
		* match serverResponseNotificationData[0].emailBody contains emailBodyData2
		* match serverResponseNotificationData[0].emailBody contains emailBodyData3
		* match serverResponseNotificationData[0].emailBody contains emailBodyData4
		* match serverResponseNotificationData[0].emailBody contains emailBodyData5	
		* match serverResponseNotificationData[0].emailBody contains emailBodyData6
		* match serverResponseNotificationData[0].emailBody contains emailBodyData7
		* match serverResponseNotificationData[0].emailBody contains emailBodyData8
		* match serverResponseNotificationData[0].emailBody contains emailBodyData9
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
	    * call read('LicensesCommonMethods.feature@AdditionalinfoReceived') {expStatus:'Additional Info Received'}
	    * call read('LicensesCommonMethods.feature@DeficienciesMetScenario') {expStatus:'Additional Info Received'}
	    * call read('LicensesCommonMethods.feature@PermitExaminerReview') {expStatus:'Awaiting Review'}
        * call read('LicensesCommonMethods.feature@LBClaimingQueue') {}
    #    * call read('LicensesCommonMethods.feature@LBApprovalPermits') {expStatus:'Approved'}
    #    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Active'}
	    
	     ## ******************** UC_PRMT_098_ExaminerReview: Validate TC0006_SLA_PER_Examiner_Review_All Deficiencies met_YES Scenario End ***************************##   
	
	  Examples:
    | read('/CSVFiles/TC_Solicitor.csv') |    

@TC0007_SLA_PER_Examiner_Review_All_Deficiencies_met_No_Define_YES_Final_YES	  
Scenario Outline: TC0007_SLA_PER_Examiner_Review_All_Deficiencies_met_No_Define_YES_Final_YES
   
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
	  #  * string productName = <ProductTypes>+''
	    * def CountyId = <countyIds>
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees
	    * def splittedCityName = CityName.replaceAll(" ","")
	    * def SearchByLegalName = false
	   	* def SearchByLicId = true
	    * def PermitType = 'StandAlone'	   	
	   	* def appType = 'NA-'
	   	* def termInYears = 3
	   	* def LicensePermitId = '0002-'
	   	* def termDesc = termInYears +' Year (s)'
    
	    * call read('AmendmentsCommonMethods.feature@IntakePermit') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('AmendmentsCommonMethods.feature@FillAndSaveApplicantInformationPageAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
        * call read('AmendmentsCommonMethods.feature@PermitFeesValidationwithMultipleChecks') {amount:1000}	    
	    * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}   
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('AmendmentsCommonMethods.feature@AddDeficiency') {expStatus:'Additional Info Required'}
	 #   * call read('LicensesCommonMethods.feature@ExaminerReviewApprovalToDefineWithAllDeficiencies') {}

	    * def wait = waitFunc(60000)
	    * call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'Deficiency Letter'}
	   	* def typeOfNotification = 'Application Receipt'
		* def subject = 'NYS Liquor Authority Licensing Bureau Record Information'
		* def emailBodyData = 'Dear '+legalName+','
		And print emailBodyData
		* def emailBodyData2 = 'Important information pertaining to your record(s) is attached.'  
		* def emailBodyData3 = 'Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date.'
		* def emailBodyData4 = 'Failure to provide a timely response may result in the disapproval of your application. The response should be sent to the e-mail address provided in the letter.'  
        * def emailBodyData5 = 'Sincerely yours,'
        * def emailBodyData6 = 'New York State Liquor Authority'

		* call read('LicensesCommonMethods.feature@ValidateEmailCommunicationQueue') {}
		* match serverResponseNotificationData[0].emailBody contains emailBodyData2
		* match serverResponseNotificationData[0].emailBody contains emailBodyData3
		* match serverResponseNotificationData[0].emailBody contains emailBodyData4
		* match serverResponseNotificationData[0].emailBody contains emailBodyData5	
		* match serverResponseNotificationData[0].emailBody contains emailBodyData6
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
	    * call read('LicensesCommonMethods.feature@AdditionalinfoReceived') {expStatus:'Additional Info Received'}
	    * call read('LicensesCommonMethods.feature@DeficienciesMetScenario') {expStatus:'Additional Info Received'}
	    
	     ## ******************** UC_PRMT_098_ExaminerReview: Validate TC0006_SLA_PER_Examiner_Review_All Deficiencies met_YES Scenario End ***************************##   
	
	  Examples:
    | read('/CSVFiles/TC_Solicitor.csv') |    

@TC0008_SLA_PER_Examiner_Review_All_Deficiencies_met_NO_Final_deficiency_Checked_before	  
Scenario Outline: TC0008_SLA_PER_Examiner_Review_All_Deficiencies_met_NO_Final_deficiency_Checked_before
   
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
	  #  * string productName = <ProductTypes>+''
	    * def CountyId = <countyIds>
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees
	    * def splittedCityName = CityName.replaceAll(" ","")
	    * def SearchByLegalName = false
	   	* def SearchByLicId = true
	    * def PermitType = 'StandAlone'	   	
	   	* def appType = 'NA-'
	   	* def termInYears = 3
	   	* def LicensePermitId = '0002-'
	   	* def termDesc = termInYears +' Year (s)'
    
	    * call read('AmendmentsCommonMethods.feature@IntakePermit') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('AmendmentsCommonMethods.feature@FillAndSaveApplicantInformationPageAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
        * call read('AmendmentsCommonMethods.feature@PermitFeesValidationwithMultipleChecks') {amount:1000}	    
	    * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}   
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('AmendmentsCommonMethods.feature@AddDeficiency') {expStatus:'Additional Info Required'}
	 #   * call read('LicensesCommonMethods.feature@ExaminerReviewApprovalToDefineWithAllDeficiencies') {}

	    * def wait = waitFunc(60000)
	    * call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'Deficiency Letter'}
	   	* def typeOfNotification = 'Application Receipt'
		* def subject = 'NYS Liquor Authority Licensing Bureau Record Information'
		* def emailBodyData = 'Dear '+legalName+','
		And print emailBodyData
		* def emailBodyData2 = 'Important information pertaining to your record(s) is attached.'  
		* def emailBodyData3 = 'Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date.'
		* def emailBodyData4 = 'Failure to provide a timely response may result in the disapproval of your application. The response should be sent to the e-mail address provided in the letter.'  
        * def emailBodyData5 = 'Sincerely yours,'
        * def emailBodyData6 = 'New York State Liquor Authority'

		* call read('LicensesCommonMethods.feature@ValidateEmailCommunicationQueue') {}
		* match serverResponseNotificationData[0].emailBody contains emailBodyData2
		* match serverResponseNotificationData[0].emailBody contains emailBodyData3
		* match serverResponseNotificationData[0].emailBody contains emailBodyData4
		* match serverResponseNotificationData[0].emailBody contains emailBodyData5	
		* match serverResponseNotificationData[0].emailBody contains emailBodyData6
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
	    * call read('LicensesCommonMethods.feature@AdditionalinfoReceived') {expStatus:'Additional Info Received'}
	    * call read('LicensesCommonMethods.feature@DeficienciesNotMetScenario') {expStatus:'Additional Info Received'}
	    
	     ## ******************** UC_PRMT_098_ExaminerReview: Validate TC0006_SLA_PER_Examiner_Review_All Deficiencies met_YES Scenario End ***************************##   
	
	  Examples:
    | read('/CSVFiles/TC_Solicitor.csv') |    

@TC0013_SLA_PER_Examiners_Review_Send_PD_Letter_functionality	  
Scenario Outline: TC0013_SLA_PER_Examiners_Review_Send_PD_Letter_functionality
   
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
	  #  * string productName = <ProductTypes>+''
	    * def CountyId = <countyIds>
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees
	    * def splittedCityName = CityName.replaceAll(" ","")
	    * def SearchByLegalName = false
	   	* def SearchByLicId = true
	    * def PermitType = 'StandAlone'	   	
	   	* def appType = 'NA-'
	   	* def termInYears = 3
	   	* def LicensePermitId = '0002-'
	   	* def termDesc = termInYears +' Year (s)'
    
	    * call read('AmendmentsCommonMethods.feature@IntakePermit') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('AmendmentsCommonMethods.feature@FillAndSaveApplicantInformationPageAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
        * call read('AmendmentsCommonMethods.feature@PermitFeesValidationwithMultipleChecks') {amount:1000}	    
	    * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}   
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@PermitExaminerReviewPdLetterYes') {expStatus:'Awaiting Review'}
	   	* def typeOfNotification = 'PD Permit'
		* def subject = 'NYS Liquor Authority Licensing Bureau Record Information'
		* def emailBodyData = 'RE: '+ApplicationId+' '+description+''
		And print emailBodyData
		* def emailBodyData2 = ''+legalName+''  
		* def emailBodyData3 = ''+CityName+''
		* def emailBodyData4 = 'September 30, 2022'
        * def emailBodyData5 = 'Dear {PoliceDepartment},'
        * def emailBodyData6 = 'On 09/30/2022 the above mentioned filed an application with the State Liquor Authority for a '+description+'.'
        * def emailBodyData7 = 'If you have information that would adversely affect the approval of this application, please contact the NYS Liquor Authority, Permit Unit, at (518) 474-3114, fax (518) 474-9804 or e-mail permits@sla.ny.gov no later than three days from the date of this correspondence. '
        * def emailBodyData8 = 'Due to time constraints, any information received beyond the three day deadline may not be used in making a determination.'
        * def emailBodyData9 = 'Sincerely yours,'
        * def emailBodyData10 = 'New York State Liquor Authority – Permit Unit'

		* call read('LicensesCommonMethods.feature@ValidateEmailCommunicationQueue') {}
		* match serverResponseNotificationData[0].emailBody contains emailBodyData2
		* match serverResponseNotificationData[0].emailBody contains emailBodyData3
		* match serverResponseNotificationData[0].emailBody contains emailBodyData4
		* match serverResponseNotificationData[0].emailBody contains emailBodyData5	
		* match serverResponseNotificationData[0].emailBody contains emailBodyData6
		* match serverResponseNotificationData[0].emailBody contains emailBodyData7
		* match serverResponseNotificationData[0].emailBody contains emailBodyData8
		* match serverResponseNotificationData[0].emailBody contains emailBodyData9
		* match serverResponseNotificationData[0].emailBody contains emailBodyData10
	    
	     ## ******************** UC_PRMT_098_ExaminerReview: Validate TC0006_SLA_PER_Examiner_Review_All Deficiencies met_YES Scenario End ***************************##   
	
	  Examples:
    | read('/CSVFiles/PermitPDLetter.csv') |  

@TC0013_SLA_PER_Examiners_Review_Send_PD_Letter_Define_deficiency	  
Scenario Outline: TC0013_SLA_PER_Examiners_Review_Send_PD_Letter_Define_deficiency
   
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
	  #  * string productName = <ProductTypes>+''
	    * def CountyId = <countyIds>
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees
	    * def splittedCityName = CityName.replaceAll(" ","")
	    * def SearchByLegalName = false
	   	* def SearchByLicId = true
	    * def PermitType = 'StandAlone'	   	
	   	* def appType = 'NA-'
	   	* def termInYears = 3
	   	* def LicensePermitId = '0002-'
	   	* def termDesc = termInYears +' Year (s)'
    
	    * call read('AmendmentsCommonMethods.feature@IntakePermit') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('AmendmentsCommonMethods.feature@FillAndSaveApplicantInformationPageAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
        * call read('AmendmentsCommonMethods.feature@PermitFeesValidationwithMultipleChecks') {amount:1000}	    
	    * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}   
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@PermitExaminerReviewPdLetterYes') {expStatus:'Awaiting Review'}
	   	* def typeOfNotification = 'PD Permit'
		* def subject = 'NYS Liquor Authority Licensing Bureau Record Information'
		* def emailBodyData = 'RE: '+ApplicationId+' '+description+''
		And print emailBodyData
		* def emailBodyData2 = ''+legalName+''  
		* def emailBodyData3 = ''+CityName+''
		* def emailBodyData4 = 'September 30, 2022'
        * def emailBodyData5 = 'Dear {PoliceDepartment},'
        * def emailBodyData6 = 'On 09/30/2022 the above mentioned filed an application with the State Liquor Authority for a '+description+'.'
        * def emailBodyData7 = 'If you have information that would adversely affect the approval of this application, please contact the NYS Liquor Authority, Permit Unit, at (518) 474-3114, fax (518) 474-9804 or e-mail permits@sla.ny.gov no later than three days from the date of this correspondence. '
        * def emailBodyData8 = 'Due to time constraints, any information received beyond the three day deadline may not be used in making a determination.'
        * def emailBodyData9 = 'Sincerely yours,'
        * def emailBodyData10 = 'New York State Liquor Authority – Permit Unit'

		* call read('LicensesCommonMethods.feature@ValidateEmailCommunicationQueue') {}
		* match serverResponseNotificationData[0].emailBody contains emailBodyData2
		* match serverResponseNotificationData[0].emailBody contains emailBodyData3
		* match serverResponseNotificationData[0].emailBody contains emailBodyData4
		* match serverResponseNotificationData[0].emailBody contains emailBodyData5	
		* match serverResponseNotificationData[0].emailBody contains emailBodyData6
		* match serverResponseNotificationData[0].emailBody contains emailBodyData7
		* match serverResponseNotificationData[0].emailBody contains emailBodyData8
		* match serverResponseNotificationData[0].emailBody contains emailBodyData9
		* match serverResponseNotificationData[0].emailBody contains emailBodyData10
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('AmendmentsCommonMethods.feature@AddDeficiency') {expStatus:'Additional Info Required'}
	 #   * call read('LicensesCommonMethods.feature@ExaminerReviewApprovalToDefineWithAllDeficiencies') {}

	    * def wait = waitFunc(60000)
	    * call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'Deficiency Letter'}
	   	* def typeOfNotification = 'Application Receipt'
		* def subject = 'NYS Liquor Authority Licensing Bureau Record Information'
		* def emailBodyData = 'Dear '+legalName+','
		And print emailBodyData
		* def emailBodyData2 = 'Important information pertaining to your record(s) is attached.'  
		* def emailBodyData3 = 'Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date.'
		* def emailBodyData4 = 'Failure to provide a timely response may result in the disapproval of your application. The response should be sent to the e-mail address provided in the letter.'  
        * def emailBodyData5 = 'Sincerely yours,'
        * def emailBodyData6 = 'New York State Liquor Authority'

		* call read('LicensesCommonMethods.feature@ValidateEmailCommunicationQueue') {}
		* match serverResponseNotificationData[0].emailBody contains emailBodyData2
		* match serverResponseNotificationData[0].emailBody contains emailBodyData3
		* match serverResponseNotificationData[0].emailBody contains emailBodyData4
		* match serverResponseNotificationData[0].emailBody contains emailBodyData5	
		* match serverResponseNotificationData[0].emailBody contains emailBodyData6
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}	    
	     ## ******************** UC_PRMT_098_ExaminerReview: Validate TC0006_SLA_PER_Examiner_Review_All Deficiencies met_YES Scenario End ***************************##   
	
	  Examples:
    | read('/CSVFiles/PermitPDLetter.csv') |   

@TC0013_SLA_PER_Examiners_Review_Send_PD_Letter_send_to_FBPT	  
Scenario Outline: TC0013_SLA_PER_Examiners_Review_Send_PD_Letter_send_to_FBPT
   
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
	  #  * string productName = <ProductTypes>+''
	    * def CountyId = <countyIds>
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees
	    * def splittedCityName = CityName.replaceAll(" ","")
	    * def SearchByLegalName = false
	   	* def SearchByLicId = true
	    * def PermitType = 'StandAlone'	   	
	   	* def appType = 'NA-'
	   	* def termInYears = 3
	   	* def LicensePermitId = '0002-'
	   	* def termDesc = termInYears +' Year (s)'
    
	    * call read('AmendmentsCommonMethods.feature@IntakePermit') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('AmendmentsCommonMethods.feature@FillAndSaveApplicantInformationPageAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
        * call read('AmendmentsCommonMethods.feature@PermitFeesValidationwithMultipleChecks') {amount:1000}	    
	    * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}   
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@PermitExaminerReviewPdLetterYes') {expStatus:'Awaiting Review'}
	   	* def typeOfNotification = 'PD Permit'
		* def subject = 'NYS Liquor Authority Licensing Bureau Record Information'
		* def emailBodyData = 'RE: '+ApplicationId+' '+description+''
		And print emailBodyData
		* def emailBodyData2 = ''+legalName+''  
		* def emailBodyData3 = ''+CityName+''
		* def emailBodyData4 = 'September 30, 2022'
        * def emailBodyData5 = 'Dear {PoliceDepartment},'
        * def emailBodyData6 = 'On 09/30/2022 the above mentioned filed an application with the State Liquor Authority for a '+description+'.'
        * def emailBodyData7 = 'If you have information that would adversely affect the approval of this application, please contact the NYS Liquor Authority, Permit Unit, at (518) 474-3114, fax (518) 474-9804 or e-mail permits@sla.ny.gov no later than three days from the date of this correspondence. '
        * def emailBodyData8 = 'Due to time constraints, any information received beyond the three day deadline may not be used in making a determination.'
        * def emailBodyData9 = 'Sincerely yours,'
        * def emailBodyData10 = 'New York State Liquor Authority – Permit Unit'

		* call read('LicensesCommonMethods.feature@ValidateEmailCommunicationQueue') {}
		* match serverResponseNotificationData[0].emailBody contains emailBodyData2
		* match serverResponseNotificationData[0].emailBody contains emailBodyData3
		* match serverResponseNotificationData[0].emailBody contains emailBodyData4
		* match serverResponseNotificationData[0].emailBody contains emailBodyData5	
		* match serverResponseNotificationData[0].emailBody contains emailBodyData6
		* match serverResponseNotificationData[0].emailBody contains emailBodyData7
		* match serverResponseNotificationData[0].emailBody contains emailBodyData8
		* match serverResponseNotificationData[0].emailBody contains emailBodyData9
		* match serverResponseNotificationData[0].emailBody contains emailBodyData10
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@PermitsExaminerReviewApprovalToFBPTQueue') {expStatus:'Awaiting Review'}

	    * def wait = waitFunc(60000)
	    * call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'Deficiency Letter'}
	   	* def typeOfNotification = 'Application Receipt'
		* def subject = 'NYS Liquor Authority Licensing Bureau Record Information'
		* def emailBodyData = 'Dear '+legalName+','
		And print emailBodyData
		* def emailBodyData2 = 'Important information pertaining to your record(s) is attached.'  
		* def emailBodyData3 = 'Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date.'
		* def emailBodyData4 = 'Failure to provide a timely response may result in the disapproval of your application. The response should be sent to the e-mail address provided in the letter.'  
        * def emailBodyData5 = 'Sincerely yours,'
        * def emailBodyData6 = 'New York State Liquor Authority'

		* call read('LicensesCommonMethods.feature@ValidateEmailCommunicationQueue') {}
		* match serverResponseNotificationData[0].emailBody contains emailBodyData2
		* match serverResponseNotificationData[0].emailBody contains emailBodyData3
		* match serverResponseNotificationData[0].emailBody contains emailBodyData4
		* match serverResponseNotificationData[0].emailBody contains emailBodyData5	
		* match serverResponseNotificationData[0].emailBody contains emailBodyData6
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}	    
	     ## ******************** UC_PRMT_098_ExaminerReview: Validate TC0006_SLA_PER_Examiner_Review_All Deficiencies met_YES Scenario End ***************************##   
	
	  Examples:
    | read('/CSVFiles/PermitPDLetter.csv') |   

@TC0013_SLA_PER_Examiners_Review_Send_PD_Letter_send_to_LB	  
Scenario Outline: TC0013_SLA_PER_Examiners_Review_Send_PD_Letter_send_to_LB
   
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
	  #  * string productName = <ProductTypes>+''
	    * def CountyId = <countyIds>
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees
	    * def splittedCityName = CityName.replaceAll(" ","")
	    * def SearchByLegalName = false
	   	* def SearchByLicId = true
	    * def PermitType = 'StandAlone'	   	
	   	* def appType = 'NA-'
	   	* def termInYears = 3
	   	* def LicensePermitId = '0002-'
	   	* def termDesc = termInYears +' Year (s)'
    
	    * call read('AmendmentsCommonMethods.feature@IntakePermit') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('AmendmentsCommonMethods.feature@FillAndSaveApplicantInformationPageAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
        * call read('AmendmentsCommonMethods.feature@PermitFeesValidationwithMultipleChecks') {amount:1000}	    
	    * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}   
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@PermitExaminerReviewPdLetterYes') {expStatus:'Awaiting Review'}
	   	* def typeOfNotification = 'PD Permit'
		* def subject = 'NYS Liquor Authority Licensing Bureau Record Information'
		* def emailBodyData = 'RE: '+ApplicationId+' '+description+''
		And print emailBodyData
		* def emailBodyData2 = ''+legalName+''  
		* def emailBodyData3 = ''+CityName+''
		* def emailBodyData4 = 'September 30, 2022'
        * def emailBodyData5 = 'Dear {PoliceDepartment},'
        * def emailBodyData6 = 'On 09/30/2022 the above mentioned filed an application with the State Liquor Authority for a '+description+'.'
        * def emailBodyData7 = 'If you have information that would adversely affect the approval of this application, please contact the NYS Liquor Authority, Permit Unit, at (518) 474-3114, fax (518) 474-9804 or e-mail permits@sla.ny.gov no later than three days from the date of this correspondence. '
        * def emailBodyData8 = 'Due to time constraints, any information received beyond the three day deadline may not be used in making a determination.'
        * def emailBodyData9 = 'Sincerely yours,'
        * def emailBodyData10 = 'New York State Liquor Authority – Permit Unit'

		* call read('LicensesCommonMethods.feature@ValidateEmailCommunicationQueue') {}
		* match serverResponseNotificationData[0].emailBody contains emailBodyData2
		* match serverResponseNotificationData[0].emailBody contains emailBodyData3
		* match serverResponseNotificationData[0].emailBody contains emailBodyData4
		* match serverResponseNotificationData[0].emailBody contains emailBodyData5	
		* match serverResponseNotificationData[0].emailBody contains emailBodyData6
		* match serverResponseNotificationData[0].emailBody contains emailBodyData7
		* match serverResponseNotificationData[0].emailBody contains emailBodyData8
		* match serverResponseNotificationData[0].emailBody contains emailBodyData9
		* match serverResponseNotificationData[0].emailBody contains emailBodyData10
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@PermitExaminerReview') {expStatus:'Awaiting Review'}

	    * def wait = waitFunc(60000)
	    * call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'Deficiency Letter'}
	   	* def typeOfNotification = 'Application Receipt'
		* def subject = 'NYS Liquor Authority Licensing Bureau Record Information'
		* def emailBodyData = 'Dear '+legalName+','
		And print emailBodyData
		* def emailBodyData2 = 'Important information pertaining to your record(s) is attached.'  
		* def emailBodyData3 = 'Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date.'
		* def emailBodyData4 = 'Failure to provide a timely response may result in the disapproval of your application. The response should be sent to the e-mail address provided in the letter.'  
        * def emailBodyData5 = 'Sincerely yours,'
        * def emailBodyData6 = 'New York State Liquor Authority'

		* call read('LicensesCommonMethods.feature@ValidateEmailCommunicationQueue') {}
		* match serverResponseNotificationData[0].emailBody contains emailBodyData2
		* match serverResponseNotificationData[0].emailBody contains emailBodyData3
		* match serverResponseNotificationData[0].emailBody contains emailBodyData4
		* match serverResponseNotificationData[0].emailBody contains emailBodyData5	
		* match serverResponseNotificationData[0].emailBody contains emailBodyData6
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}	    
	     ## ******************** UC_PRMT_098_ExaminerReview: Validate TC0006_SLA_PER_Examiner_Review_All Deficiencies met_YES Scenario End ***************************##   
	
	  Examples:
    | read('/CSVFiles/PermitPDLetter.csv') |

@TC0016_SLA_PER_Examiners_Review_Highly_deficiency_functionality	  
Scenario Outline: TC0016_SLA_PER_Examiners_Review_Highly_deficiency_functionality
   
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
	  #  * string productName = <ProductTypes>+''
	    * def CountyId = <countyIds>
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees
	    * def splittedCityName = CityName.replaceAll(" ","")
	    * def SearchByLegalName = false
	   	* def SearchByLicId = true
	    * def PermitType = 'StandAlone'	   	
	   	* def appType = 'NA-'
	   	* def termInYears = 3
	   	* def LicensePermitId = '0002-'
	   	* def termDesc = termInYears +' Year (s)'
    
	    * call read('AmendmentsCommonMethods.feature@IntakePermit') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('AmendmentsCommonMethods.feature@FillAndSaveApplicantInformationPageAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
        * call read('AmendmentsCommonMethods.feature@PermitFeesValidationwithMultipleChecks') {amount:1000}	    
	    * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}   
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('AmendmentsCommonMethods.feature@AddDeficiency') {expStatus:'Additional Info Required'}
	    * call read('LicensesCommonMethods.feature@PermitExaminerHighlyDeficient') {expStatus:'Awaiting Review'}
        * call read('LicensesCommonMethods.feature@LBClaimingQueue') {}
	    
	     ## ******************** UC_PRMT_098_ExaminerReview: Validate TC0003_SLA_PER_Examiner_toFBPTReview Scenario End ***************************##   
	
	  Examples:
    | read('/CSVFiles/TC_Solicitor.csv') |	   
    
@TC0009_SLA_PER_Temp_Per_Pending_200	  
Scenario Outline: TC0009_SLA_PER_Temp_Per_Pending_200
   
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
	  #  * string productName = <ProductTypes>+''
	    * def CountyId = <countyIds>
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees
	    * def splittedCityName = CityName.replaceAll(" ","")
	    * def SearchByLegalName = false
	   	* def SearchByLicId = true
	    * def PermitType = 'TemporaryWithoutLicence'	   	
	   	* def appType = 'NA-'
	   	* def termInYears = 3
	   	* def LicensePermitId = '0002-'
	   	* def termDesc = termInYears +' Year (s)'
    
	    * call read('AmendmentsCommonMethods.feature@IntakePermit') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('AmendmentsCommonMethods.feature@FillAndSaveApplicantInformationPageAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
        * call read('AmendmentsCommonMethods.feature@PermitFeesValidationwithMultipleChecks') {amount:1000}	    
	    * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}   
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
		* def name = 'Pending 200 measurement'
		* def value = 4
		* call read('LicensesCommonMethods.feature@PermitTempAndLiquadatorExaminerReview') {}	    
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
	    And match taskStatus == 'Pending 200 measurement'
	    
	     ## ******************** UC_PRMT_098_ExaminerReview: Validate TC0003_SLA_PER_Examiner_toFBPTReview Scenario End ***************************##   
	
	
	  Examples:
    | read('/CSVFiles/TC_Temporary_Permit.csv') |

@TC0010_SLA_PER_Temp_Per_Pending_500	  
Scenario Outline: TC0010_SLA_PER_Temp_Per_Pending_500
   
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
	  #  * string productName = <ProductTypes>+''
	    * def CountyId = <countyIds>
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees
	    * def splittedCityName = CityName.replaceAll(" ","")
	    * def SearchByLegalName = false
	   	* def SearchByLicId = true
	    * def PermitType = 'TemporaryWithoutLicence'	   	
	   	* def appType = 'NA-'
	   	* def termInYears = 3
	   	* def LicensePermitId = '0002-'
	   	* def termDesc = termInYears +' Year (s)'
    
	    * call read('AmendmentsCommonMethods.feature@IntakePermit') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('AmendmentsCommonMethods.feature@FillAndSaveApplicantInformationPageAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
        * call read('AmendmentsCommonMethods.feature@PermitFeesValidationwithMultipleChecks') {amount:1000}	    
	    * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}   
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
		* def name = 'Pending 500 foot report'
		* def value = 5
		* call read('LicensesCommonMethods.feature@PermitTempAndLiquadatorExaminerReview') {}	    
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
	    And match taskStatus == 'Pending 500 foot report'
	    
	     ## ******************** UC_PRMT_098_ExaminerReview: Validate TC0003_SLA_PER_Examiner_toFBPTReview Scenario End ***************************##   
	
	
	  Examples:
    | read('/CSVFiles/TC_Temporary_Permit.csv') |
    
@TC0011_SLA_PER_Temp_Per_Pending_Full_Board	  
Scenario Outline: TC0011_SLA_PER_Temp_Per_Pending_Full_Board
   
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
	  #  * string productName = <ProductTypes>+''
	    * def CountyId = <countyIds>
	    * def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees
	    * def splittedCityName = CityName.replaceAll(" ","")
	    * def SearchByLegalName = false
	   	* def SearchByLicId = true
	    * def PermitType = 'TemporaryWithoutLicence'	   	
	   	* def appType = 'NA-'
	   	* def termInYears = 3
	   	* def LicensePermitId = '0002-'
	   	* def termDesc = termInYears +' Year (s)'
    
	    * call read('AmendmentsCommonMethods.feature@IntakePermit') {}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('AmendmentsCommonMethods.feature@FillAndSaveApplicantInformationPageAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
        * call read('AmendmentsCommonMethods.feature@PermitFeesValidationwithMultipleChecks') {amount:1000}	    
	    * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}   
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
		* def name = 'Pending Full Board'
		* def value = 6
		* call read('LicensesCommonMethods.feature@PermitTempAndLiquadatorExaminerReview') {}	    
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
	    And match taskStatus == 'Pending Full Board'
	    
	     ## ******************** UC_PRMT_098_ExaminerReview: Validate TC0003_SLA_PER_Examiner_toFBPTReview Scenario End ***************************##   
	
	
	  Examples:
    | read('/CSVFiles/TC_Temporary_Permit.csv') |  
    
@TC0002_SLA_PER_Temp_Permit_Disapproval_Cause_Save_Letter	  
Scenario Outline: TC0002_SLA_PER_Temp_Permit_Disapproval_Cause_Save_Letter
   
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
	    #* def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees
	    * def splittedCityName = CityName.replaceAll(" ","")
	    * def SearchByLegalName = false
	   	* def SearchByLicId = true
	    * def PermitType = 'Associated'	   	
	   	* def appType = 'NA-'
	   	* def termInYears = 3
	   	* def LicensePermitId = '0002-'
	   	* def termDesc = termInYears +' Year (s)'
	    * call read('AmendmentsCommonMethods.feature@SearchLicPermitIdForAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@IntakePermit') {}
        #* call read('LicensesCommonMethods.feature@GetPreFillLicenseAllDetailsByLicenseId') {} 
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    #* call read('AmendmentsCommonMethods.feature@FillAndSaveApplicantInformationPageAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
	    * call read('LicensesCommonMethods.feature@FeesValidation') {amount:40000}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    #* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
		* call read('LicensesCommonMethods.feature@UploadDisApprovalDocument') {}
		* def name = 'Disapprove'
		* def value = 2
	    * call read('LicensesCommonMethods.feature@PermitTempAndLiquadatorExaminerReviewWithEmailSend') {expStatus:'Awaiting Review'}
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Disapproved'}	
		* def wait = waitFunc(50000)
	    * def subject = 'Disapproval'
	    #* call read('LicensesCommonMethods.feature@ValidatePermitCommunicationPageAndEMail') {typeOfNotification:'Generic Non-Portal'}
	   * call read('LicensesCommonMethods.feature@ValidateAttachedDocument')
	    
	     ## ******************** UC_PRMT_098_ExaminerReview: Validate TC0003_SLA_PER_Examiner_toFBPTReview Scenario End ***************************##   
	
	
	  Examples:
    | read('/CSVFiles/TC_Temporary_Permit.csv') |  
    
@TC0008_SLA_PER_Temp_Permit_Conditionally_Approve_Main_license	  
Scenario Outline: TC0008_SLA_PER_Temp_Permit_Conditionally_Approve_Main_license
   
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
	    #* def CountyName = <countynames>	
		* def totalFees = licenseFees+fillingFees
	    * def splittedCityName = CityName.replaceAll(" ","")
	    * def SearchByLegalName = false
	   	* def SearchByLicId = true
	    * def PermitType = 'Associated'	   	
	   	* def appType = 'NA-'
	   	* def termInYears = 3
	   	* def LicensePermitId = '0002-'
	   	* def termDesc = termInYears +' Year (s)'
	    * call read('AmendmentsCommonMethods.feature@SearchLicPermitIdForAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@IntakePermit') {}
        #* call read('LicensesCommonMethods.feature@GetPreFillLicenseAllDetailsByLicenseId') {} 
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    #* call read('AmendmentsCommonMethods.feature@FillAndSaveApplicantInformationPageAmendment') {}
	    * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
	    * call read('LicensesCommonMethods.feature@FeesValidation') {amount:40000}
	  	* call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	    #* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
		* call read('LicensesCommonMethods.feature@UploadDisApprovalDocument') {}
		* def name = 'Conditionally Approve'
		* def value = 3
	    * call read('LicensesCommonMethods.feature@PermitTempAndLiquadatorExaminerReviewWithEmailSend') {expStatus:'Awaiting Review'}
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Conditionally Approved'}	

	   * call read('LicensesCommonMethods.feature@ValidateAttachedDocument')
	    
	     ## ******************** UC_PRMT_098_ExaminerReview: Validate TC0003_SLA_PER_Examiner_toFBPTReview Scenario End ***************************##   
	
	
	  Examples:
    | read('/CSVFiles/TC_Temporary_Permit.csv') |                        
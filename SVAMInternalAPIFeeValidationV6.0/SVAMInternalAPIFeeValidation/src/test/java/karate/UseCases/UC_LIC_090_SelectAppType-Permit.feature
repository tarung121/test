Feature: Permit Application Type
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
@TC0002SelectAssociatedPermitvalidapprovedlicenseid		    
Scenario Outline: Beer Retail License Intake

        * callonce read('LoginDetails.feature') { strToken:'#(strToken)'}	
        * def dbSts = db.cleanHeap()
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
	    * def LicenseDescription = <LicDescription>
	    * def convictedOfCrime = <convictedOfCrime>
		* def PhoneNumber = <PhoneNumber>
		* def PhoneExtn = <PhoneExtn>
		* def countryCode = <countryCode>
		* def stateCode = <StateCode>	
	  	* def mainLicensePermitTypeId = <LicensePermitTypeId>
	    * def termInYears = <NumberOfTerm>
	    * def expiryDate = getExpiryDateFunc(termInYears);
	      #And print expiryDate
	    * def termDesc = <NumberOfTerm>+' Year (s)'
	    * def licenseFees = <InitialLicFee>
	    * def fillingFees = <NonRefundableFilingFees>
	    * def renewalFees = <RenewalFilingFees>+''
	   # * string productName = <ProductTypes>+''
	    * def CountyId = <countyIds>	
	    * def fiveDigitLicID = '0002-'
        * call read('WholeSaleLicenseIdActive.feature') {licenseId:'#(licenseId)'}
        * call read('PermitsCommonMethods.feature@IntakeAssociatedPermit') {}
         * def CountyName = "New York"
	    * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {county:'#(CountyName)'}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveMethodOfOperationPage') {}
	    * call read('LicensesCommonMethods.feature@WaveFeesValidation') {expStatus:'Intake Complete'}
	    * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
 
 Examples:
   
    | read('/CSVFiles/AssociatedPermit.csv') |
    
@TC0003SolicitorPermit	    
Scenario Outline: Beer Retail License Intake

        * callonce read('LoginDetails.feature') { strToken:'#(strToken)'}	
        * def dbSts = db.cleanHeap()
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
	    * def LicenseDescription = <LicDescription>
	    * def convictedOfCrime = <convictedOfCrime>
		* def PhoneNumber = <PhoneNumber>
		* def PhoneExtn = <PhoneExtn>
		* def countryCode = <countryCode>
		* def stateCode = <StateCode>	
	  	* def mainLicensePermitTypeId = <LicensePermitTypeId>
	    * def termInYears = <NumberOfTerm>
	    * def expiryDate = getExpiryDateFunc(termInYears);
	      #And print expiryDate
	    * def termDesc = <NumberOfTerm>+' Year (s)'
	    * def licenseFees = <InitialLicFee>
	    * def fillingFees = <NonRefundableFilingFees>
	    * def renewalFees = <RenewalFilingFees>+''
	   # * string productName = <ProductTypes>+''
	    * def CountyId = <countyIds>	
	    * def fiveDigitLicID = '0002-'
        * call read('WholeSaleLicenseIdActive.feature') {licenseId:'#(licenseId)'}
        * call read('PermitsCommonMethods.feature@IntakeSolicitorPermit') {}
         * def CountyName = "New York"
	    * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {county:'#(CountyName)'}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    #* call read('LicensesCommonMethods.feature@FillAndSavePersonalQuestionnairePage') {}
	    * call read('LicensesCommonMethods.feature@WaveFeesValidation') {expStatus:'Intake Complete'}
	    * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
 
 Examples:
   
    | read('/CSVFiles/AssociatedPermit.csv') |
    
@TC0004aAssociatedPermitinvalidlicenseidLegalname	    
Scenario Outline: Invalid License Id

        * callonce read('LoginDetails.feature') { strToken:'#(strToken)'}	
        * call read('PermitsCommonMethods.feature@InvalidLicenseId') {}
 
 Examples:
   
    | read('/CSVFiles/AssociatedPermit.csv') | 
    
@TC0004bAssociatedPermitinvalidlicenseidLegalname	    
Scenario Outline: Invalid Name

        * callonce read('LoginDetails.feature') { strToken:'#(strToken)'}	
        * call read('PermitsCommonMethods.feature@InvalidLegalName') {}
 
 Examples:
   
    | read('/CSVFiles/AssociatedPermit.csv') |     
    
@TC0005SelectMultipleAssociatedpermit		    
Scenario Outline: Multiple Associated Permit Intake

        * callonce read('LoginDetails.feature') { strToken:'#(strToken)'}	
        * def dbSts = db.cleanHeap()
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
	    * def LicenseDescription = <LicDescription>
	    * def convictedOfCrime = <convictedOfCrime>
		* def PhoneNumber = <PhoneNumber>
		* def PhoneExtn = <PhoneExtn>
		* def countryCode = <countryCode>
		* def stateCode = <StateCode>	
	  	* def mainLicensePermitTypeId = <LicensePermitTypeId>
	    * def termInYears = <NumberOfTerm>
	    * def expiryDate = getExpiryDateFunc(termInYears);
	      #And print expiryDate
	    * def termDesc = <NumberOfTerm>+' Year (s)'
	    * def licenseFees = <InitialLicFee>
	    * def fillingFees = <NonRefundableFilingFees>
	    * def renewalFees = <RenewalFilingFees>+''
	   # * string productName = <ProductTypes>+''
	    * def CountyId = <countyIds>	
	    * def fiveDigitLicID = '0002-'
        * call read('WholeSaleLicenseIdActive.feature') {licenseId:'#(licenseId)'}
        * call read('PermitsCommonMethods.feature@MultipleAssociatedpermit') {}
         * def CountyName = "New York"
	    * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {county:'#(CountyName)'}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveMethodOfOperationPage') {}
	    * call read('LicensesCommonMethods.feature@WaveFeesValidation') {expStatus:'Intake Complete'}
	    * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
 
 Examples:
   
    | read('/CSVFiles/AssociatedPermit.csv') |   
    
@TC0005SelectMultipleAssociatedpermit		    
Scenario Outline: Multiple Associated Permit Intake

        * callonce read('LoginDetails.feature') { strToken:'#(strToken)'}	
        * def dbSts = db.cleanHeap()
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
	    * def LicenseDescription = <LicDescription>
	    * def convictedOfCrime = <convictedOfCrime>
		* def PhoneNumber = <PhoneNumber>
		* def PhoneExtn = <PhoneExtn>
		* def countryCode = <countryCode>
		* def stateCode = <StateCode>	
	  	* def mainLicensePermitTypeId = <LicensePermitTypeId>
	    * def termInYears = <NumberOfTerm>
	    * def expiryDate = getExpiryDateFunc(termInYears);
	      #And print expiryDate
	    * def termDesc = <NumberOfTerm>+' Year (s)'
	    * def licenseFees = <InitialLicFee>
	    * def fillingFees = <NonRefundableFilingFees>
	    * def renewalFees = <RenewalFilingFees>+''
	   # * string productName = <ProductTypes>+''
	    * def CountyId = <countyIds>	
	    * def fiveDigitLicID = '0002-'
        * call read('WholeSaleLicenseIdActive.feature') {licenseId:'#(licenseId)'}
        * call read('PermitsCommonMethods.feature@IntakeAssociatedPermit') {}
         * def CountyName = "New York"
	    * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {county:'#(CountyName)'}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveMethodOfOperationPage') {}
	    * call read('LicensesCommonMethods.feature@WaveFeesValidation') {expStatus:'Intake Complete'}
	    * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
 
 Examples:
   
    | read('/CSVFiles/AssociatedPermit.csv') |  
    
@TC0006AssociatedPermitValidlegalname
Scenario Outline: TC0006_SLA_PER_Select_Associated Permit_Valid legal name

 * callonce read('LoginDetails.feature') { strToken:'#(strToken)'}	
        * def dbSts = db.cleanHeap()
		* def IndOrgSelectionDropDown = <IndOrgSelection>
  		* def indOrgCode = getIndORgCodeFunc(IndOrgSelectionDropDown)
  		  And print indOrgCode
  		* def isIndStatus = getStatusIndOrgStatus(IndOrgSelectionDropDown)
	    * def CorporateStructureDropDown = <CorporateStructure>
	    * def CorporateStructureDropDownCode = getIndORgCodeFunc(indOrgCode,CorporateStructureDropDown)
	   	  And print CorporateStructureDropDownCode
	    * def firstName = <FirstName>
	    * def lastName = <LastName>
	    #* def legalName = firstName+ ' '+lastName
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
	    * def LicenseDescription = <LicDescription>
	    * def convictedOfCrime = <convictedOfCrime>
		* def PhoneNumber = <PhoneNumber>
		* def PhoneExtn = <PhoneExtn>
		* def countryCode = <countryCode>
		* def stateCode = <StateCode>	
	  	* def mainLicensePermitTypeId = <LicensePermitTypeId>
	    * def termInYears = <NumberOfTerm>
	    * def expiryDate = getExpiryDateFunc(termInYears);
	      #And print expiryDate
	    * def termDesc = <NumberOfTerm>+' Year (s)'
	    * def licenseFees = <InitialLicFee>
	    * def fillingFees = <NonRefundableFilingFees>
	    * def renewalFees = <RenewalFilingFees>+''
	   # * string productName = <ProductTypes>+''
	    * def CountyId = <countyIds>	
	    * def fiveDigitLicID = '0002-'
        * call read('WholeSaleLicenseIdActive.feature') {SearchName:'#(SearchName)'}
        * call read('PermitsCommonMethods.feature@GetActivatedLicensesLegalName') {licId:'#(licId)'}
        * call read('PermitsCommonMethods.feature@IntakeAssociatedPermit2') {}
         * def CountyName = "New York"
	    * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {county:'#(CountyName)'}
	    * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
	    * call read('LicensesCommonMethods.feature@FillAndSaveMethodOfOperationPage') {}
	    * call read('LicensesCommonMethods.feature@WaveFeesValidation') {expStatus:'Intake Complete'}
	    * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
 
 Examples:
   
    | read('/CSVFiles/AssociatedPermit.csv') |  

                     
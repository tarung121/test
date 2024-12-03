Feature: UC_LIC_038 Intake Support/Opposition Parties
Background:
			* url BaseURL
  			* def config = { username: '#(dbUserName)', password:'#(dbUserPassword)', url: '#(dbQuery)',driverClassName: 'com.microsoft.sqlserver.jdbc.SQLServerDriver' }
    	 	* def getDate =
	    """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat('yyyyMMddHHmmss');
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		"""
    

 @TC0002_NYC_SLA_LIC_Upload_Additional_Support_Opposition	  
 Scenario Outline: TC0002_NYC_SLA_LIC_Upload_Additional_Support_Opposition
   
	# ********* Login Functionality *********************
  		* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
  		
  		
	    * def firstName = <FirstName>
	    * def lastName_1 = <LastName> 
	    * def lastName = lastName_1 +'Support'
	    * def autoFirstName = firstName + getDate()
	    * def dbaName = firstName + lastName +'DBA'
		* def legalName = autoFirstName + lastName
	    * def Address1 = <Address1>
	    * def Address2 = <Address2>
	    * def CityName = <City>
	    * def zipCode = <ZipCode>
	    * def postalCode = <PostalCode>
	    * def countryName = <Country>
	    * def emailId = <Email>
	    * def CountyId = <countyIds>
	    * def CountyName = <County>	
		* def countryCode = <countryCode>
		* def stateCode = <StateCode>
		* def feedbackType = 'Support'
		
		* def tempGuid = "39a00723-8391-eaa7-2891-bd836c665294"
	    * def feedback = 'Test Automation For '+feedbackType+' Party'
	    
	   ## ******************** UC_LIC_038: Validate TC0002_NYC_SLA_LIC_Upload_Additional_Support_Opposition Scenario Start ***************************##
	   
	    * call read('LicensesCommonMethods.feature@UploadSupportOppositionParties') {}
	    * call read('LicensesCommonMethods.feature@SearchAndValidateUploadedSupportOppositionParty') {}
	    
	    
	    ## ******************** UC_LIC_038: Validate TC0002_NYC_SLA_LIC_Upload_Additional_Support_Opposition Scenario End ***************************##   
	
Examples:
    | read('/CSVFiles/Uc_038_UploadSupport.csv') |     
    
 
 @TC0005_NYC_SLA_LIC_View_Support_Opposition	  
 Scenario Outline: TC0005_NYC_SLA_LIC_View_Support_Opposition
   
	# ********* Login Functionality *********************
  		* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
  		
  		
	    * def firstName = <FirstName>
	    * def lastName_1 = <LastName> 
	    * def lastName = lastName_1 +'Support'
	    * def autoFirstName = firstName + getDate()
	    * def dbaName = firstName + lastName +'DBA'
		* def legalName = autoFirstName + lastName
	    * def Address1 = <Address1>
	    * def Address2 = <Address2>
	    * def CityName = <City>
	    * def zipCode = <ZipCode>
	    * def postalCode = <PostalCode>
	    * def countryName = <Country>
	    * def emailId = <Email>
	    * def CountyId = <countyIds>
	    * def CountyName = <County>	
		* def countryCode = <countryCode>
		* def stateCode = <StateCode>
		* def feedbackType = 'Opposition'
		
		* def tempGuid = "1d02f4f3-197e-d8e9-0096-4a71f7b1e238"
	    * def feedback = 'Test Automation For '+feedbackType+' Party'
	   
	   ## ******************** UC_LIC_038: Validate TC0005_NYC_SLA_LIC_View_Support_Opposition Scenario Start ***************************##
	   
	    * call read('LicensesCommonMethods.feature@UploadSupportOppositionParties') {}
	    * call read('LicensesCommonMethods.feature@ViewUploadedSupportOppositionParties') {}
	    
	    ## ******************** UC_LIC_038: Validate TC0005_NYC_SLA_LIC_View_Support_Opposition Scenario End ***************************##   
	
Examples:
    | read('/CSVFiles/Uc_038_UploadSupport.csv') |  
    
 
 @TC0004_NYC_SLA_LIC_Delete_Support_Opposition	  
 Scenario Outline: TC0004_NYC_SLA_LIC_Delete_Support_Opposition
   
	# ********* Login Functionality *********************
  		* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
  		
  		
	    * def firstName = <FirstName>
	    * def lastName_1 = <LastName> 
	    * def lastName = lastName_1 +'Support'
	    * def autoFirstName = firstName + getDate()
	    * def dbaName = firstName + lastName +'DBA'
		* def legalName = autoFirstName + lastName
	    * def Address1 = <Address1>
	    * def Address2 = <Address2>
	    * def CityName = <City>
	    * def zipCode = <ZipCode>
	    * def postalCode = <PostalCode>
	    * def countryName = <Country>
	    * def emailId = <Email>
	    * def CountyId = <countyIds>
	    * def CountyName = <County>	
		* def countryCode = <countryCode>
		* def stateCode = <StateCode>
		* def feedbackType = 'Opposition'
		
		* def tempGuid = "1d02f4f3-197e-d8e9-0096-4a71f7b1e238"
	    * def feedback = 'Test Automation For '+feedbackType+' Party'
	   
	   ## ******************** UC_LIC_038: Validate TC0004_NYC_SLA_LIC_Delete_Support_Opposition Scenario Start ***************************##
	   
	    * call read('LicensesCommonMethods.feature@UploadSupportOppositionParties') {}
	    * call read('LicensesCommonMethods.feature@DeleteUploadedSupportOppositionParties') {}
	    
	    ## ******************** UC_LIC_038: Validate TC0004_NYC_SLA_LIC_Delete_Support_Opposition Scenario End ***************************##   
	
Examples:
    | read('/CSVFiles/Uc_038_UploadSupport.csv') |    
    

 @IntakeLicAndValidateSupportOpppsitionParties	  
 Scenario Outline: IntakeLicAndValidateSupportOpppsitionParties
   
	# ********* Login Functionality *********************
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
		* def IndOrgSelectionDropDown = <IndOrgSelection>
  		* def indOrgCode = getIndORgCodeFunc(IndOrgSelectionDropDown)
  			And print indOrgCode
  		* def isIndStatus = getStatusIndOrgStatus(IndOrgSelectionDropDown)
	    * def CorporateStructureDropDown = <CorporateStructure>
	    * def CorporateStructureDropDownCode = getIndORgCodeFunc(indOrgCode,CorporateStructureDropDown)
	   		And print CorporateStructureDropDownCode
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
	  
		
		* def firstName = <FirstName>
	    * def lastName_1 = <LastName> 
	    * def lastName = lastName_1 +'Support'
	    * def autoFirstName = firstName + getDate()
	    * def dbaName = firstName + lastName +'DBA'
		* def legalName = autoFirstName + lastName
		* def feedbackType = 'Opposition'
		
		* def tempGuid = "1d02f4f3-197e-d8e9-0096-4a71f7b1e238"
	    * def feedback = 'Test Automation For '+feedbackType+' Party'
	   
	   ## ******************** UC_LIC_038: Validate IntakeLicAndValidateSupportOpppsitionParties Scenario Start ***************************##
	   
	    * call read('LicensesCommonMethods.feature@UploadSupportOppositionParties') {}
	         
     	* call read('LicensesCommonMethods.feature@IntakeLicensewithoutAssociatedLic') {}
     	
   		* call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {}
   		* call read('LicensesCommonMethods.feature@SearchUploadedSupportOppositionOnPremisesPage') {}
   		* call read('LicensesCommonMethods.feature@AssociateFeeback') {}
   		* call read('LicensesCommonMethods.feature@disAssociateFeedBack') {}
   		
	    
	    ## ******************** UC_LIC_038: Validate IntakeLicAndValidateSupportOpppsitionParties Scenario End ***************************##   
	
Examples:
    | read('/CSVFiles/Uc_038_UploadSupport.csv') | 
      
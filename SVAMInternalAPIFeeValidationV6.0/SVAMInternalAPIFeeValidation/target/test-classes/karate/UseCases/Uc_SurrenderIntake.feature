Feature: Intake Surrender
Background:
			* url BaseURL
			* def config = { username: '#(dbUserName)', password:'#(dbUserPassword)', url: '#(dbQuery)',driverClassName: 'com.microsoft.sqlserver.jdbc.SQLServerDriver' }
    	 	* def DbUtils = Java.type('utils.DbUtils')
    		* def db = new DbUtils(config)
			* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
			* def amendmentTypeId = 1
			* def waitFunc =
		        """
		      function(timeinMiliSeconds) {
		        // load java type into js engine
		        var Thread = Java.type('java.lang.Thread');
		        Thread.sleep(timeinMiliSeconds*1000); 
		      }
		      """
		          	* def DueDateCheck =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("M/dd/YYYY 12:00:00 'AM'");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		  """
     * def DueDateCheck = DueDateCheck(7)
       And print DueDateCheck

			* def DueDateCheckl =
            """
          function(termsInyears) {
          java.lang.System.out.print("termsInyears"+termsInyears);
          var today = new java.util.Date(); 
          var calendar = java.util.Calendar.getInstance();  
          calendar.setTime(today);  
          calendar.add(java.util.Calendar.MONTH, 1);  
          var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
          var sdf = new SimpleDateFormat("m/dd/yyyy 12:00:00 'AM'");  
          var dayAfter = new java.util.Date(java.util.concurrent.TimeUnit.DAYS.toMillis( 7));
          return sdf.format(dayAfter);
          } 
          """
           * def DueDateCheck2 = DueDateCheckl()
       And print DueDateCheck2
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
			
           * def getDate7 =
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
          var sdf = new SimpleDateFormat("MM/dd/yyyy");  
          var dayAfter = new java.util.Date(lastDayOfMonth + java.util.concurrent.TimeUnit.DAYS.toMillis( 7));
          return sdf.format(dayAfter);
          } 
          """
         * def getDate7 = getDate7()
          
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
		  
@TC0001_SLA_SUR_Intake_Surrender_Select_Screen_License	  
Scenario Outline: TC0001_SLA_SUR_Intake_Surrender_Select_Screen_License
   
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

	   	* def SearchByLegalName = true
	   	* def SearchByLicId = false
        * call read('SurrenderCommonMethods.feature@SearchLicPermitIdForSurrender') {}
        * call read('SurrenderCommonMethods.feature@IntakeSurrender') {}
        * call read('SurrenderCommonMethods.feature@DraftSurrenderPreview') {}
        And match isTempPermit == false
	   
	   	     ## ******************** UC_RenewalExaminerReview: Validate TC0002_SLA_REN_Examiner_review_Digest_Approved_and_Hold_for_CB_notice  Scenario End ***************************##   
	
 Examples:
    | read('/CSVFiles/RenewalOnPremises.csv') |
		  
@TC0001a_SLA_SUR_Intake_Form_Surrender	  
Scenario Outline: TC0001a_SLA_SUR_Intake_Form_Surrender
   
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
	   	* def SearchByLegalName = true
	   	* def SearchByLicId = false
        * call read('SurrenderCommonMethods.feature@SearchLicPermitIdForSurrender') {}
        * call read('SurrenderCommonMethods.feature@IntakeSurrender') {}
        * call read('SurrenderCommonMethods.feature@DraftSurrenderPreview') {}
        And match isTempPermit == false
        * call read('SurrenderCommonMethods.feature@SurrenderTabFill') {}
        * configure continueOnStepFailure = true
        * def noteDetail = 'Surrender Test'
        * call read('SurrenderCommonMethods.feature@SurrenderAddNotes') {}
        * def Comment = 'Surrender Test'
        * call read('SurrenderCommonMethods.feature@SurrenderAddComments') {}
        * call read('LicensesCommonMethods.feature@UploadDocumentAmendment') {}
        * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	   
	   	     ## ******************** UC_RenewalExaminerReview: Validate TC0002_SLA_REN_Examiner_review_Digest_Approved_and_Hold_for_CB_notice  Scenario End ***************************##   
	
 Examples:
    | read('/CSVFiles/SurrenderOnPremises.csv') |

@TC0002_SLA_SUR_Intake_Surrender_Select_Main_License_Search      
Scenario Outline: TC0002_SLA_SUR_Intake_Surrender_Select_Main_License_Search
   
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
           * call read('LicensesCommonMethods.feature@IntakeLicensewithAssociatedTempPermit') {}
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
           * def SearchByLegalName = false
           * def SearchByLicId = true
        * call read('SurrenderCommonMethods.feature@SearchLicPermitIdForSurrender') {}
        * call read('SurrenderCommonMethods.feature@IntakeSurrender') {}
        * call read('SurrenderCommonMethods.feature@DraftSurrenderPreview') {}
        And match isTempPermit == false
        * call read('SurrenderCommonMethods.feature@SurrenderTabFill') {}
        * configure continueOnStepFailure = true
        * def noteDetail = 'Surrender Test'
        * call read('SurrenderCommonMethods.feature@SurrenderAddNotes') {}
        * def Comment = 'Surrender Test'
        * call read('SurrenderCommonMethods.feature@SurrenderAddComments') {}
        * call read('LicensesCommonMethods.feature@UploadDocumentAmendment') {}
        * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
       
                ## ******************** UC_RenewalExaminerReview: Validate TC0002_SLA_REN_Examiner_review_Digest_Approved_and_Hold_for_CB_notice  Scenario End ***************************##   
    
Examples:
    | read('/CSVFiles/RenewalOnPremises.csv') |

@TC0003_SLA_SUR_Intake_Surrender_Select_Main_License_Permit_Search      
Scenario Outline: TC0003_SLA_SUR_Intake_Surrender_Select_Main_License_Permit_Search
   
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
        * def SearchByLegalName = false
           * def SearchByLicId = true
        * def PermitType = 'StandAlone'           
           * def appType = 'NA-'
           * def termInYears = 3
           * def LicensePermitId = '0002-'
           * def termDesc = termInYears +' Year (s)'
        * call read('AmendmentsCommonMethods.feature@SearchLicPermitIdForAmendment') {}
        * call read('AmendmentsCommonMethods.feature@IntakePermit') {}
        * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
        * call read('AmendmentsCommonMethods.feature@FillAndSaveApplicantInformationPageAmendment') {}
        * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
        * call read('LicensesCommonMethods.feature@FeesValidation') {amount:40000}
          * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
        * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}        
            * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {}
        * call read('LicensesCommonMethods.feature@PermitExaminerReview') {expStatus:'Awaiting Review'}
        * call read('LicensesCommonMethods.feature@LBClaimingQueue') {}
         * def expirationDate = fundDueDateFunc(10)
         * def name = 'Approved'
		* def value = 1
        * call read('LicensesCommonMethods.feature@PermitLBDecisions') {}
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Approved'}
	       
     * call read('LicensesCommonMethods.feature@GetLicenseId') {}
            And print licenseId
           * def SearchByLegalName = false
           * def SearchByLicId = true
        * call read('SurrenderCommonMethods.feature@SearchLicPermitIdForSurrender') {}
        * call read('SurrenderCommonMethods.feature@IntakeSurrender') {}
        * call read('SurrenderCommonMethods.feature@DraftSurrenderPreview') {}
        And match isTempPermit == false
        * call read('SurrenderCommonMethods.feature@SurrenderTabFill') {}
        * configure continueOnStepFailure = true
        * def noteDetail = 'Surrender Test'
        * call read('SurrenderCommonMethods.feature@SurrenderAddNotes') {}
        * def Comment = 'Surrender Test'
        * call read('SurrenderCommonMethods.feature@SurrenderAddComments') {}
        * call read('LicensesCommonMethods.feature@UploadDocumentAmendment') {}
        * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
       
                ## ******************** UC_RenewalExaminerReview: Validate TC0002_SLA_REN_Examiner_review_Digest_Approved_and_Hold_for_CB_notice  Scenario End ***************************##   
    
Examples:
    | read('/CSVFiles/TC_StandAlone.csv') |

@TC0008_SLA_SUR_Intake_Surrender_Select_Stand_Alone_License_Permit	  
Scenario Outline: TC0008_SLA_SUR_Intake_Surrender_Select_Stand_Alone_License_Permit
   
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
	    * def amountPaid = totalFees+''
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_RenewalExaminerReview: Validate TC0002_SLA_REN_Examiner_review_Digest_Approved_and_Hold_for_CB_notice Scenario Start ***************************##
	   	* def SearchByLegalName = false
           * def SearchByLicId = true
        * def PermitType = 'StandAlone'           
           * def appType = 'NA-'
           * def termInYears = 3
           * def LicensePermitId = '0002-'
           * def termDesc = termInYears +' Year (s)'
        * call read('AmendmentsCommonMethods.feature@SearchLicPermitIdForAmendment') {}
        * call read('AmendmentsCommonMethods.feature@IntakePermit') {}
        * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
        * call read('AmendmentsCommonMethods.feature@FillAndSaveApplicantInformationPageAmendment') {}
        * call read('AmendmentsCommonMethods.feature@UploadDocumentAmendment') {}
        * call read('LicensesCommonMethods.feature@FeesValidation') {amount:40000}
          * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
        * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}        
            * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {}
        * call read('LicensesCommonMethods.feature@PermitExaminerReview') {expStatus:'Awaiting Review'}
        * call read('LicensesCommonMethods.feature@LBClaimingQueue') {}
         * def expirationDate = fundDueDateFunc(10)
         * def name = 'Approved'
		* def value = 1
        * call read('LicensesCommonMethods.feature@PermitLBDecisions') {}
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Approved'}
	       
     * call read('LicensesCommonMethods.feature@GetLicenseId') {}
            And print licenseId
           * def SearchByLegalName = false
           * def SearchByLicId = true
        * call read('SurrenderCommonMethods.feature@SearchLicPermitIdForSurrender') {}
        * call read('SurrenderCommonMethods.feature@IntakeSurrender') {}
        * call read('SurrenderCommonMethods.feature@DraftSurrenderPreview') {}
        And match isTempPermit == false
        * call read('SurrenderCommonMethods.feature@SurrenderTabFill') {}
        * configure continueOnStepFailure = true
        * def noteDetail = 'Surrender Test'
        * call read('SurrenderCommonMethods.feature@SurrenderAddNotes') {}
        * def Comment = 'Surrender Test'
        * call read('SurrenderCommonMethods.feature@SurrenderAddComments') {}
        * call read('LicensesCommonMethods.feature@UploadDocumentAmendment') {}
        * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
        
        
	   	     ## ******************** UC_RenewalExaminerReview: Validate TC0002_SLA_REN_Examiner_review_Digest_Approved_and_Hold_for_CB_notice  Scenario End ***************************##   
	
 Examples:
    | read('/CSVFiles/RenewalStandalonePermit.csv') |   
Feature: Solicitors Permit
Background:
			* url BaseURL
			* def config = { username: '#(dbUserName)', password:'#(dbUserPassword)', url: '#(dbQuery)',driverClassName: 'com.microsoft.sqlserver.jdbc.SQLServerDriver' }
    	 	* def DbUtils = Java.type('utils.DbUtils')
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
		  
@TC0001_SLA_SOL_Solicitor_Approved	  
Scenario Outline: TC0001_SLA_SOL_Solicitor_Approved
   
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
	   ## ******************** UC_SolicitorsPermit: Validate TC0001_SLA_SOL_Solicitor_Approved Scenario Start ***************************##
	       	* call read('PermitsCommonMethods.feature@SearchAndValidateLBPermitQueue')
	       	* call read('PermitsCommonMethods.feature@PermitLBApproval')
	       	* call read('PermitsCommonMethods.feature@ValidatePermitApplicationStatus')
	       	 * def wait = waitFunc(70)

		* def typeOfNotification = 'Application Receipt'
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
	   
	   	     ## ******************** UC_SolicitorsPermit: Validate TC0001_SLA_SOL_Solicitor_Approved  Scenario End ***************************##   

 Examples:
    | read('/CSVFiles/RenewalOnPremises.csv') |


@TC0002_SLA_SOL_Solicitor_Disapproved_Cause_Save_Letter  
Scenario: TC0002_SLA_SOL_Solicitor_Disapproved_Cause_Save_Letter
   
   
	   ## ******************** UC_SolicitorsPermit: Validate TC0002_SLA_SOL_Solicitor_Disapproved_Cause_Save_Letter Scenario Start ***************************##
	      	* call read('PermitsCommonMethods.feature@SearchAndValidateLBPermitQueue')
	      	* call read('PermitsCommonMethods.feature@PermitLBDisapprovalApproval')
		  * call read('PermitsCommonMethods.feature@ValidatePermitApplicationStatus')
	       	 * def wait = waitFunc(70)
		* def typeOfNotification = 'Application Receipt'
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
	     ## ******************** UC_SolicitorsPermit: Validate TC0002_SLA_SOL_Solicitor_Disapproved_Cause_Save_Letter Scenario End ***************************## 
	     
    	
@TC0003_SLA_SOL_Solicitor_Disapproved_FTC_Save_Letter  
Scenario: TC0003_SLA_SOL_Solicitor_Disapproved_FTC_Save_Letter
   
   
	   ## ******************** UC_SolicitorsPermit: Validate TC0003_SLA_SOL_Solicitor_Disapproved_FTC_Save_Letter Scenario Start ***************************##
	      	* call read('PermitsCommonMethods.feature@SearchAndValidateLBPermitQueue')
	      	* call read('PermitsCommonMethods.feature@PermitLBDisapprovalApproval')
		  * call read('PermitsCommonMethods.feature@ValidatePermitApplicationStatus')
	       	 * def wait = waitFunc(70)
		* def typeOfNotification = 'Application Receipt'
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
	     ## ******************** UC_SolicitorsPermit: Validate TC0003_SLA_SOL_Solicitor_Disapproved_FTC_Save_Letter Scenario End ***************************##  		
	     
	     
@TC0004_SLA_SOL_Solicitor_Disapproved_Cause_Download_disapprovalletter  
Scenario: TC0004_SLA_SOL_Solicitor_Disapproved_Cause_Download_disapprovalletter
   
   
	   ## ******************** UC_SolicitorsPermit: Validate TC0004_SLA_SOL_Solicitor_Disapproved_Cause_Download_disapprovalletter Scenario Start ***************************##
	      	* call read('PermitsCommonMethods.feature@SearchAndValidateLBPermitQueue')
	      	* call read('PermitsCommonMethods.feature@PermitLBDisapprovalApproval')
		  * call read('PermitsCommonMethods.feature@ValidatePermitApplicationStatus')
	       	 * def wait = waitFunc(70)
		* def typeOfNotification = 'Application Receipt'
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
	     ## ******************** UC_SolicitorsPermit: Validate TC0004_SLA_SOL_Solicitor_Disapproved_Cause_Download_disapprovalletter Scenario End ***************************##  	
	     
	     
@TC0004a_SLA_SOL_Solicitor_Disapproved_FTC_Download_disapprovalletter  
Scenario: TC0004a_SLA_SOL_Solicitor_Disapproved_FTC_Download_disapprovalletter
   
   
	   ## ******************** UC_SolicitorsPermit: Validate TC0004a_SLA_SOL_Solicitor_Disapproved_FTC_Download_disapprovalletter Scenario Start ***************************##
	      	* call read('PermitsCommonMethods.feature@SearchAndValidateLBPermitQueue')
	      	* call read('PermitsCommonMethods.feature@PermitLBDisapprovalApproval')
		  * call read('PermitsCommonMethods.feature@ValidatePermitApplicationStatus')
	       	 * def wait = waitFunc(70)
		* def typeOfNotification = 'Application Receipt'
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
	     ## ******************** UC_SolicitorsPermit: Validate TC0004a_SLA_SOL_Solicitor_Disapproved_FTC_Download_disapprovalletter Scenario End ***************************##  	
	     
	     
	     @TC0005_SLA_SOL_Solicitor_Disapproval_Counsel_Cause  
       Scenario: TC0005_SLA_SOL_Solicitor_Disapproval_Counsel_Cause
   
	   ## ******************** UC_SolicitorsPermit: Validate TC0005_SLA_SOL_Solicitor_Disapproval_Counsel_Cause Scenario Start ***************************##
	      	* call read('PermitsCommonMethods.feature@SearchAndValidateLBPermitQueue')
	      	* call read('PermitsCommonMethods.feature@PermitLBDisapprovalApproval')
		  * call read('PermitsCommonMethods.feature@ValidatePermitApplicationStatus')
	       	 * def wait = waitFunc(70)
		* def typeOfNotification = 'Application Receipt'
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
	     ## ******************** UC_SolicitorsPermit: Validate TC0005_SLA_SOL_Solicitor_Disapproval_Counsel_Cause Scenario End ***************************##  		 
	     
	     
	      @TC0005a_SLA_SOL_Solicitor_Disapproval_Counsel_FTC  
       Scenario: TC0005a_SLA_SOL_Solicitor_Disapproval_Counsel_FTC
   
	   ## ******************** UC_SolicitorsPermit: Validate TC0005a_SLA_SOL_Solicitor_Disapproval_Counsel_FTC Scenario Start ***************************##
	      	* call read('PermitsCommonMethods.feature@SearchAndValidateLBPermitQueue')
	      	* call read('PermitsCommonMethods.feature@PermitLBDisapprovalApproval')
		  * call read('PermitsCommonMethods.feature@ValidatePermitApplicationStatus')
	       	 * def wait = waitFunc(70)
		* def typeOfNotification = 'Application Receipt'
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
	     ## ******************** UC_SolicitorsPermit: Validate TC0005a_SLA_SOL_Solicitor_Disapproval_Counsel_FTC Scenario End ***************************##  		
	     
	     
	     @TC0008_SLA_SOL_Solicitor_Withdrawn  
       Scenario: TC0008_SLA_SOL_Solicitor_Withdrawn
   
	   ## ******************** UC_SolicitorsPermit: Validate TC0008_SLA_SOL_Solicitor_Withdrawn Scenario Start ***************************##
	      	* call read('PermitsCommonMethods.feature@SearchAndValidateLBPermitQueue')
	      	* call read('PermitsCommonMethods.feature@PermitLBDisapprovalApproval')
		  * call read('PermitsCommonMethods.feature@ValidatePermitApplicationStatus')
	       	 * def wait = waitFunc(70)
		* def typeOfNotification = 'Application Receipt'
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
	     ## ******************** UC_SolicitorsPermit: Validate TC0008_SLA_SOL_Solicitor_Withdrawn Scenario End ***************************##  		 	  	 	  	  	  	 	  	 		  	 	  	 	  	 	  	 	  	 	  	 	  	 	  
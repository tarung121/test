Feature: Enforcement_Unlicensed_Complaint
Background:
			* url BaseURL
  			* def config = { username: '#(dbUserName)', password:'#(dbUserPassword)', url: '#(dbQuery)',driverClassName: 'com.microsoft.sqlserver.jdbc.SQLServerDriver' }
    	 * def MonthDateYear =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("MM/dd/yyyy");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		  """ 
		   * def MonthDateYear = MonthDateYear()
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
			
@TC0001_Unlicensed_PD_Letter_Location   	
Scenario: TC0001_Unlicensed_PD_Letter_Location
   
	# ********* Login Functionality *********************
    * callonce read('LoginDetails.feature') { strToken:'#(strToken)'}  		
	* callonce read('EnforcementCommonMethods.feature@HearingCreateLic') {}
  	
	* def documentDescUpload = 'COMPLAINT'
	* def acaTypeUpload = 'Complaint'
	* def keyUpload = 58
	* def valueUpload = 'COMPLAINT'
	* def documentSubCategoryUpload = '' 
	* def lpApplicationId = "" 	
	* def TempGuid = '41f72d5c-2b07-711a-f2e1-cf9505bbbafb'
	* def premisesId = ""
	* def licenseId = ""
	* def licId = ""
	* call read('EnforcementCommonMethods.feature@AddReferralFormEnforcementUnlicensed') {}
	* def CountyId = 12
  	* call read('EnforcementCommonMethods.feature@ComplaintIdCreatedCheckForUnlicensed') {}
  	* def taskDecision = 1
  	* def staffId = 1069
  	* def taskId = 6234
  	* def pdText = ''
  	* def description = 'Location and PD Comment'
  	* call read('EnforcementCommonMethods.feature@ReviewUnLicensedComplaintBySupervisor') {}
	  * match applicationStatus == "Process Referral Letter to PD & Cease and Desist Letter"

  	* call read('EnforcementCommonMethods.feature@SendCeaseNDecistLetterNPDLetter') {}
	  	  
  	   Given path 'internalapi/api/GenericSearch/SearchEnforcement'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
       And params  {page:1,pageSize:10'}
     
   	 And request [{"dataTypeValue":"Text","key":"ComplaintNo","operatorValue":"=","value":'#(complaintNo)'}]
	  When method post
	 
	   Then status 200
	   And def applicationStatus = response.data[0].applicationStatus
	   And def dateOpened = response.data[0].dateOpened
	   And def dba = response.data[0].dba
	   
	   And match applicationStatus == 'Closed'
    
   	* def typeOfNotification = 'Email Template Generic Non-portal'
	* def subject = 'NYS Liquor Authority Enforcement Case Information'
	* def emailBodyData = 'Dear '+legalName+', \r<br/>\r<br/>\r<br/>Important information pertaining to your record(s) is attached. \r<br/>\r<br/>Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date. \r<br/>\r<br/>To avoid consequential action, the response should be sent to the e-mail address provided in the letter. \r<br/> \r<br/>\r<br/>Sincerely yours, \r<br/>\r<br/>New York State Liquor Authority'
   	  And print emailBodyData
    * call read('EnforcementCommonMethods.feature@ValidateEmailCommunicationQueueComplaint') {}	   
   	
   	* def typeOfNotification = 'Cease_Desist'
    * call read('EnforcementCommonMethods.feature@ValidateMailCommunicationQueueComplaint') {}	   
    
    * def type = 'Complaint'
    * def id = 'complaintNo'
    * def documentDesc = 'PD Referral Letter'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentUpdatedEnforcement') {}	
    * def documentDesc = 'Cease_Desist'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentUpdatedEnforcement') {}
    * def documentDesc = 'Deficiency Letter'
                	    	  	 
@TC0002_Unlicensed_PD_Letter  	
Scenario: TC0002_Unlicensed_PD_Letter
   
	# ********* Login Functionality *********************
    * callonce read('LoginDetails.feature') { strToken:'#(strToken)'}  		
	* callonce read('EnforcementCommonMethods.feature@HearingCreateLic') {}
  	
	* def documentDescUpload = 'COMPLAINT'
	* def acaTypeUpload = 'Complaint'
	* def keyUpload = 58
	* def valueUpload = 'COMPLAINT'
	* def documentSubCategoryUpload = '' 
	* def lpApplicationId = "" 	
	* def TempGuid = '41f72d5c-2b07-711a-f2e1-cf9505bbbafb'
	* def premisesId = ""
	* def licenseId = ""
	* def licId = ""
	* call read('EnforcementCommonMethods.feature@AddReferralFormEnforcementUnlicensed') {}
	* def CountyId = 12
  	* call read('EnforcementCommonMethods.feature@ComplaintIdCreatedCheckForUnlicensed') {}
  	* def taskDecision = 3
  	* def staffId = 1069
  	* def taskId = 6234
  	* def pdText = 'Test PD text'
  	* def description = 'PD Comment'
  	* call read('EnforcementCommonMethods.feature@ReviewUnLicensedComplaintBySupervisor') {}
	  * match applicationStatus == "Process Referral Letter to PD"

  	* call read('EnforcementCommonMethods.feature@SendPDLetter') {}
	  	  
  	   Given path 'internalapi/api/GenericSearch/SearchEnforcement'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
       And params  {page:1,pageSize:10'}
     
   	 And request [{"dataTypeValue":"Text","key":"ComplaintNo","operatorValue":"=","value":'#(complaintNo)'}]
	  When method post
	 
	   Then status 200
	   And def applicationStatus = response.data[0].applicationStatus
	   And def dateOpened = response.data[0].dateOpened
	   And def dba = response.data[0].dba
	   
	   And match applicationStatus == 'Closed'
    
   	* def typeOfNotification = 'Email Template Generic Non-portal'
	* def subject = 'NYS Liquor Authority Enforcement Case Information'
	* def emailBodyData = 'Dear '+legalName+', \r<br/>\r<br/>\r<br/>Important information pertaining to your record(s) is attached. \r<br/>\r<br/>Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date. \r<br/>\r<br/>To avoid consequential action, the response should be sent to the e-mail address provided in the letter. \r<br/> \r<br/>\r<br/>Sincerely yours, \r<br/>\r<br/>New York State Liquor Authority'
   	  And print emailBodyData
    * call read('EnforcementCommonMethods.feature@ValidateEmailCommunicationQueueComplaint') {}	   
   	
    * def type = 'Complaint'
    * def id = 'complaintNo'
    * def documentDesc = 'PD Referral Letter'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentUpdatedEnforcement') {}
    * def documentDesc = 'Deficiency Letter'
                      
@TC0003_Unlicensed_Location  	
Scenario: TC0003_Unlicensed_Location 
   
	# ********* Login Functionality *********************
    * callonce read('LoginDetails.feature') { strToken:'#(strToken)'}  		
	* callonce read('EnforcementCommonMethods.feature@HearingCreateLic') {}
  	
	* def documentDescUpload = 'COMPLAINT'
	* def acaTypeUpload = 'Complaint'
	* def keyUpload = 58
	* def valueUpload = 'COMPLAINT'
	* def documentSubCategoryUpload = '' 
	* def lpApplicationId = "" 	
	* def TempGuid = '41f72d5c-2b07-711a-f2e1-cf9505bbbafb'
	* def premisesId = ""
	* def licenseId = ""
	* def licId = ""
	* call read('EnforcementCommonMethods.feature@AddReferralFormEnforcementUnlicensed') {}
	* def CountyId = 12
  	* call read('EnforcementCommonMethods.feature@ComplaintIdCreatedCheckForUnlicensed') {}
  	* def taskDecision = 2
  	* def staffId = 1069
  	* def taskId = 6234
  	* def pdText = 'Test PD text'
  	* def description = 'Location Comment'
  	* call read('EnforcementCommonMethods.feature@ReviewUnLicensedComplaintBySupervisor') {}
	  * match applicationStatus == "Process Cease and Desist Letter"

  	* call read('EnforcementCommonMethods.feature@SendCeaseNDecistLetter') {}
	  	  
  	   Given path 'internalapi/api/GenericSearch/SearchEnforcement'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
       And params  {page:1,pageSize:10'}
     
   	 And request [{"dataTypeValue":"Text","key":"ComplaintNo","operatorValue":"=","value":'#(complaintNo)'}]
	  When method post
	 
	   Then status 200
	   And def applicationStatus = response.data[0].applicationStatus
	   And def dateOpened = response.data[0].dateOpened
	   And def dba = response.data[0].dba
	   
	   And match applicationStatus == 'Closed'
    
    * def typeOfNotification = 'Cease_Desist'
    * call read('EnforcementCommonMethods.feature@ValidateMailCommunicationQueueComplaint') {}	   
    
    * def type = 'Complaint'
    * def id = 'complaintNo'
    * def documentDesc = 'Cease_Desist'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentUpdatedEnforcement') {}   	

@TC0004_Unlicensed_Close_Complaint  	
Scenario: TC0004_Unlicensed_Close_Complaint
   
	# ********* Login Functionality *********************
    * callonce read('LoginDetails.feature') { strToken:'#(strToken)'}  		
	* callonce read('EnforcementCommonMethods.feature@HearingCreateLic') {}
  	
	* def documentDescUpload = 'COMPLAINT'
	* def acaTypeUpload = 'Complaint'
	* def keyUpload = 58
	* def valueUpload = 'COMPLAINT'
	* def documentSubCategoryUpload = '' 
	* def lpApplicationId = "" 	
	* def TempGuid = '41f72d5c-2b07-711a-f2e1-cf9505bbbafb'
	* def premisesId = ""
	* def licenseId = ""
	* def licId = ""
	* call read('EnforcementCommonMethods.feature@AddReferralFormEnforcementUnlicensed') {}
	* def CountyId = 12
  	* call read('EnforcementCommonMethods.feature@ComplaintIdCreatedCheckForUnlicensed') {}
  	* def taskDecision = 4
  	* def staffId = 1069
  	* def taskId = 6234
  	* call read('EnforcementCommonMethods.feature@CloseCaseUnlicensed') {}
  	And match noteDetail == 'Test Close text'
	  	  
  	   Given path 'internalapi/api/GenericSearch/SearchEnforcement'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
       And params  {page:1,pageSize:10'}
     
   	 And request [{"dataTypeValue":"Text","key":"ComplaintNo","operatorValue":"=","value":'#(complaintNo)'}]
	  When method post
	 
	   Then status 200
	   And def applicationStatus = response.data[0].applicationStatus
	   And def dateOpened = response.data[0].dateOpened
	   And def dba = response.data[0].dba
	   
	   And match applicationStatus == 'Closed'
	   
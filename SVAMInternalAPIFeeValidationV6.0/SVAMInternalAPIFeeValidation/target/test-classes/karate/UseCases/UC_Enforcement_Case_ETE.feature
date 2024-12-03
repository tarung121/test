Feature: Enforcement_Case
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
			
@TC0001_SLA_ENF_ETE_Positive_unrelated_Complaint_Yes_PSS_Yes_NWOP_send_to_Counsel_Attorney    	
Scenario: TC0001_SLA_ENF_ETE_Positive_unrelated_Complaint_Yes_PSS_Yes_NWOP_send_to_Counsel_Attorney
   
	# ********* Login Functionality *********************
    * callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
	* callonce read('EnforcementCommonMethods.feature@HearingCreateLic') {}
  		
  	* def SearchByLegalName = false
  	* def licKeywordName = 'Automation'
	* def documentDescUpload = 'COMPLAINT'
	* def acaTypeUpload = 'Complaint'
	* def keyUpload = 58
	* def valueUpload = 'COMPLAINT'
	* def documentSubCategoryUpload = ''  	
	* call read('EnforcementCommonMethods.feature@AddReferralFormEnforcement') {}
  	* call read('EnforcementCommonMethods.feature@ComplaintIdCreatedCheck') {}
  	* def isPositiveComplaint = true
  	* def hasRelatedCase = false
  	* def taskId = 6006
  	* def nwop = true
  	* call read('EnforcementCommonMethods.feature@PositiveComplaintYes') {}
  	  
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
	   
	   And match applicationStatus == 'Complaint Closed Positive'
	   
  	* call read('EnforcementCommonMethods.feature@ViolationsAdd') {}
  	* def IsSummarySuspension = true
  	* def taskDecision = 1
   	* call read('EnforcementCommonMethods.feature@SubmitNWOPYes') {}
  # 	* call read('EnforcementCommonMethods.feature@ClaimEnforcementCaseToCounsel') {}
      And match taskStatus == "Awaiting Review"
      And match IsSummarySuspension == true
	   
   	* call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
   	* call read('EnforcementCommonMethods.feature@NoticeWOPrejudiceFormPreInterview') {}
   	* call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * def documentDescUpload = 'NOTICE OF WARNING W/O PREJUDICE'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 148
	* def valueUpload = 'NOTICE OF WARNING W/O PREJUDICE'
	* def documentSubCategoryUpload = ''  
    * def documentDesc = 'NOTICE OF WARNING W/O PREJUDICE'
    * def documentDesc1 = 'NOTICE OF WARNING W/O PREJUDICE'
   	* call read('EnforcementCommonMethods.feature@NoticeWOPrejudiceFormPostInterview') {}
    * def documentDesc = 'NOTICE OF WARNING W/O PREJUDICE'
    * def documentDesc1 = 'NWOP'
    * def documentDesc = 'NOTICE OF WARNING W/O PREJUDICE'
    * def type = 'Arrest Notification'
    * def id = 'caseId'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentUpdatedEnforcement') {}   
    * def referralCaseId = caseId	
    * def typeOfNotification = 'Email Template Generic Non-portal'
	* def subject = 'NYS Liquor Authority Enforcement Case Information'
	* def emailBodyData = 'Dear '+legalName+', \r<br/>\r<br/>\r<br/>Important information pertaining to your record(s) is attached. \r<br/>\r<br/>Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date. \r<br/>\r<br/>To avoid consequential action, the response should be sent to the e-mail address provided in the letter. \r<br/> \r<br/>\r<br/>Sincerely yours, \r<br/>\r<br/>New York State Liquor Authority'
   	  And print emailBodyData
    * call read('CounselCommonMethods.feature@ValidateEmailCommunicationQueueCase') {}
   	* call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * def documentDescUpload = 'Notice of Action'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 391
	* def valueUpload = 'Notice of Action'
	* def documentSubCategoryUpload = ''  
    * def documentDesc1 = 'Notice of Action'
   	* call read('EnforcementCommonMethods.feature@NoticeOfActionFormPostInterview') {}
    * call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * call read('EnforcementCommonMethods.feature@AssignAssistingInvestigator') {}
    * call read('EnforcementCommonMethods.feature@LoginAsAssignAssistingInvestigator') {}

    * call read('EnforcementCommonMethods.feature@EnforcementAssistingInvestigatorQueueByCaseNo') {}
    * match applicationStatus == 'Awaiting Review'
    * def documentDescUpload = 'SUPPLEMENTAL REPORT'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 218
	* def valueUpload = 'SUPPLEMENTAL REPORT'
	* def documentSubCategoryUpload = ''
    * call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}
    * call read('EnforcementCommonMethods.feature@SubmitInterviewReport') {}
  	* call read('LoginDetails.feature') { strToken:'#(strToken)'}
    * call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * match applicationStatus == 'Awaiting Review'
    * def documentDescUpload = 'REPORT OF INVESTIGATION"'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 176
	* def valueUpload = 'REPORT OF INVESTIGATION'
	* def documentSubCategoryUpload = ''
	* def isSaleToMinor = false
	* def isLeadInvestigator = true
	* call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}
    * call read('EnforcementCommonMethods.feature@CreateinvestigationReport') {}
    And match DocumentDescRes == 'REPORT OF INVESTIGATION"'
    And match DocumentDescRes1 == 'SUPPLEMENTAL REPORT'
    * call read('EnforcementCommonMethods.feature@SubmitAllInvestigationReports') {}
    And match applicationStatus == 'Report Awaiting Review'
    * call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}
    * def AllApproved = true
    * def NwopChecked = true
    * def DecisionValue1 = 1
    * def DecisionValue2 = 1
    * def TaskDecision = 1
    * def PossibleSummarySuspension = true
    * call read('EnforcementCommonMethods.feature@SubmitSupervisorReport') {}
	   
	   Given path '/internalapi/api/CounselDashboard/GetCounselAttorneyClaimQueue'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      * def stringParam = "referralCaseApplicationNo~contains~'"+caseNo+"'"
       And params  {filter:'#(stringParam)',page:1,pageSize:10'}
   
   	 And request {filter:'#(stringParam)',page:1,pageSize:10'}
	  When method get
	 
	  Then status 200
	  And match response.data[0].taskStatus == 'Awaiting Review'
	  And match response.data[0].isSummarySuspension == 1
    * call read('EnforcementCommonMethods.feature@EnforcementGenericQueueByCaseId') {expapplicationStatus:'Case Completed'}  
    * def appId = caseId	  
    * def documentDesc = 'NWOP'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentCase') {}	
    * def documentDesc = 'NOTICE OF WARNING W/O PREJUDICE'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentCase') {}
    * def documentDesc = 'Notice of Action'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentCase') {}	
    * def documentDesc = 'SUPPLEMENTAL REPORT'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentCase') {}	        
    * def documentDesc = 'REPORT OF INVESTIGATION\"'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentCase') {}	  
        	    	  	 
@TC0002_SLA_ENF_ETE_Positive_unrelated_complaint_No_PSS_No_NWOP_Letter_of_advice  
Scenario: TC0002_SLA_ENF_ETE_Positive_unrelated_complaint_No_PSS_No_NWOP_Letter_of_advice
   
	# ********* Login Functionality *********************
    * callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
	* callonce read('EnforcementCommonMethods.feature@HearingCreateLic') {}
  		
  	* def SearchByLegalName = false
  	* def licKeywordName = 'Automation'
	* def documentDescUpload = 'COMPLAINT'
	* def acaTypeUpload = 'Complaint'
	* def keyUpload = 58
	* def valueUpload = 'COMPLAINT'
	* def documentSubCategoryUpload = ''  	
	* call read('EnforcementCommonMethods.feature@AddReferralFormEnforcement') {}
  	* call read('EnforcementCommonMethods.feature@ComplaintIdCreatedCheck') {}
  	* def isPositiveComplaint = true
  	* def hasRelatedCase = false
  	* def taskId = 6006
  	* def nwop = false
  	* call read('EnforcementCommonMethods.feature@PositiveComplaintYes') {}
  	* call read('EnforcementCommonMethods.feature@ViolationsAdd') {}
  	* def IsSummarySuspension = false
  	* def taskDecision = 1
    * call read('EnforcementCommonMethods.feature@SubmitNWOPYes') {}
   	* call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * call read('EnforcementCommonMethods.feature@AssignAssistingInvestigator') {}
    * call read('EnforcementCommonMethods.feature@LoginAsAssignAssistingInvestigator') {}
    * call read('EnforcementCommonMethods.feature@EnforcementAssistingInvestigatorQueueByCaseNo') {}
    * match applicationStatus == 'Awaiting Review'
    * def documentDescUpload = 'SUPPLEMENTAL REPORT'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 218
	* def valueUpload = 'SUPPLEMENTAL REPORT'
	* def documentSubCategoryUpload = ''
	* call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}
    * call read('EnforcementCommonMethods.feature@SubmitInterviewReport') {}
  	* call read('LoginDetails.feature') { strToken:'#(strToken)'}
    * call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * match applicationStatus == 'Awaiting Review'
    * def documentDescUpload = 'REPORT OF INVESTIGATION"'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 176
	* def valueUpload = 'REPORT OF INVESTIGATION'
	* def documentSubCategoryUpload = ''
	* def isSaleToMinor = false
	* def isLeadInvestigator = true
    * call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}
    * call read('EnforcementCommonMethods.feature@CreateinvestigationReport') {}
      And match DocumentDescRes == 'REPORT OF INVESTIGATION"'
      And match DocumentDescRes1 == 'SUPPLEMENTAL REPORT'
    * call read('EnforcementCommonMethods.feature@SubmitAllInvestigationReports') {}
      And match applicationStatus == 'Report Awaiting Review'
   # * call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}
  	* call read('EnforcementCommonMethods.feature@ViolationsAdd') {}
    * def AllApproved = false
    * def NwopChecked = false
    * def DecisionValue1 = 3
    * def DecisionValue2 = 4
    * def TaskDecision = 0
    * call read('EnforcementCommonMethods.feature@SubmitSupervisorReport') {}
    * call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
      And match applicationStatus == 'Additional Information Requested'
  #  * call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}
    * def documentDescUpload = 'REPORT OF INVESTIGATION"'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 176
	* def valueUpload = 'REPORT OF INVESTIGATION'
	* def documentSubCategoryUpload = ''    
	* def isSaleToMinor = false
	* def isLeadInvestigator = true	
    * call read('EnforcementCommonMethods.feature@AmendInvestigationReport') {}
     And match DocumentDescRes == 'REPORT OF INVESTIGATION"'
     And match applicationStatus == 'Report Awaiting Review'
  #  * call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}  	
    * def TaskDecision = 2
    * call read('EnforcementCommonMethods.feature@SubmitSupervisorLOA') {}
    * def waiting = waitFunc(30)
	  
      Given path 'internalapi/api/GenericSearch/SearchEnforcement'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
       And params  {page:1,pageSize:10'}
     
   	 And request [{"dataTypeValue":"Text","key":"CaseNo","operatorValue":"=","value":'#(caseNo)'}]
	  When method post
	 
	   Then status 200
	   And def applicationStatus = response.data[0].applicationStatus
	   And def dateOpened = response.data[0].dateOpened
	   
	      And match applicationStatus == 'Case Closed'
	   
	    * def referralCaseId = caseId	
    	* def typeOfNotification = 'Email Template Generic Non-portal'
		* def subject = 'NYS Liquor Authority Enforcement Case Information'
		* def emailBodyData = 'Dear '+legalName+', \r<br/>\r<br/>\r<br/>Important information pertaining to your record(s) is attached. \r<br/>\r<br/>Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date. \r<br/>\r<br/>To avoid consequential action, the response should be sent to the e-mail address provided in the letter. \r<br/> \r<br/>\r<br/>Sincerely yours, \r<br/>\r<br/>New York State Liquor Authority'
		  And print emailBodyData
        * call read('CounselCommonMethods.feature@ValidateEmailCommunicationQueueCase') {}
        * def documentDesc = 'Letter_of_Advice_Updated'
        * def type = 'Case'
        * def id = 'caseId'
        * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentUpdatedEnforcement') {} 
                      
@TC0003_SLA_ENF_ETE_Positive_complaint_Related_to_a_Case    	
Scenario: TC0003_SLA_ENF_ETE_Positive_complaint_Related_to_a_Case
   
	# ********* Login Functionality *********************
    * callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
	* callonce read('EnforcementCommonMethods.feature@HearingCreateLic') {}
	
	* def SearchByLicId = false
  	* def SearchByPrincipalName = true
	* call read('EnforcementCommonMethods.feature@SearchLicPermitIdForArrest') {}
	* call read('EnforcementCommonMethods.feature@SearchLicenseByPrincipalId') {}
	* def documentDescUpload = 'ARREST NOTIFICATION - LETTER'
	* def acaTypeUpload = 'Arrest Notification'
	* def keyUpload = 25
	* def valueUpload = 'ARREST NOTIFICATION - LETTER'
	* def documentSubCategoryUpload = 'ARREST NOTIFICATION'
	* call read('EnforcementCommonMethods.feature@UploadDocumentArrest') {}
    * def documentDesc = 'test arrest'
    * def valueprincipalId = principalId.toString();	 
    
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentUpdatedEnforcement') {}
    * def comment = 'A principal associated with this application has been arrested'
    * call read('EnforcementCommonMethods.feature@SaveArrestNotificationInfo') {}
    * def PName = firstName + lastName
    * call read('EnforcementCommonMethods.feature@ArrestOfLicenseeQueue') {}
    * call read('EnforcementCommonMethods.feature@CreateCaseBasedOnLocation') {}
  		
  	* def SearchByLegalName = false
  	* def licKeywordName = 'Automation'
	* def documentDescUpload = 'COMPLAINT'
	* def acaTypeUpload = 'Complaint'
	* def keyUpload = 58
	* def valueUpload = 'COMPLAINT'
	* def documentSubCategoryUpload = ''  	
	* call read('EnforcementCommonMethods.feature@AddReferralFormEnforcement') {}
  	* call read('EnforcementCommonMethods.feature@ComplaintIdCreatedCheck') {}
  	* def isPositiveComplaint = true
  	* def hasRelatedCase = true
  	* def taskId = 6006
  	* def nwop = false
  	* call read('EnforcementCommonMethods.feature@RelatedCaseYes') {}

@TC0004_SLA_ENF_ETE_Negative_complaint    	
Scenario: TC0004_SLA_ENF_ETE_Negative_complaint
   
	# ********* Login Functionality *********************
    * callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
	* callonce read('EnforcementCommonMethods.feature@HearingCreateLic') {}
  		
  	* def SearchByLegalName = false
  	* def licKeywordName = 'Automation'
	* def documentDescUpload = 'COMPLAINT'
	* def acaTypeUpload = 'Complaint'
	* def keyUpload = 58
	* def valueUpload = 'COMPLAINT'
	* def documentSubCategoryUpload = ''  	
	* call read('EnforcementCommonMethods.feature@AddReferralFormEnforcement') {}
  	* call read('EnforcementCommonMethods.feature@ComplaintIdCreatedCheck') {}
  	* def isPositiveComplaint = false
  	* def hasRelatedCase = false
  	* def taskId = 6006
  	* def nwop = false
  	* call read('EnforcementCommonMethods.feature@NegativeComplaintYes') {}
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
	   
	   And match applicationStatus == 'Complaint Closed Negative'  	

@TC0005_SLA_ENF_ETE_Positive_unrelated_complaint_Yes_PSS_No_to_Yes_for_NWOP_send_to_Counsel_Attorney    	
Scenario: TC0005_SLA_ENF_ETE_Positive_unrelated_complaint_Yes_PSS_No_to_Yes_for_NWOP_send_to_Counsel_Attorney
   
	# ********* Login Functionality *********************
    * callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
	* callonce read('EnforcementCommonMethods.feature@HearingCreateLic') {}
  		
  	* def SearchByLegalName = false
  	* def licKeywordName = 'Automation'
	* def documentDescUpload = 'COMPLAINT'
	* def acaTypeUpload = 'Complaint'
	* def keyUpload = 58
	* def valueUpload = 'COMPLAINT'
	* def documentSubCategoryUpload = ''  	
	* call read('EnforcementCommonMethods.feature@AddReferralFormEnforcement') {}
  	* call read('EnforcementCommonMethods.feature@ComplaintIdCreatedCheck') {}
  	* def isPositiveComplaint = true
  	* def hasRelatedCase = false
  	* def taskId = 6006
  	* call read('EnforcementCommonMethods.feature@PositiveComplaintYes') {}
  	  	  
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
	   
	   And match applicationStatus == 'Complaint Closed Positive'
	   
  	* call read('EnforcementCommonMethods.feature@ViolationsAdd') {}
  	* def IsSummarySuspension = true
  	* def taskDecision = 1
  	* def nwop = false
   	* call read('EnforcementCommonMethods.feature@SubmitNWOPYes') {}
   #	* call read('EnforcementCommonMethods.feature@ClaimEnforcementCaseToCounsel') {}
    And match isSummarySuspension == 1
   #  And match response == 'true'     
  	* call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * call read('EnforcementCommonMethods.feature@AssignAssistingInvestigator') {}
    * call read('EnforcementCommonMethods.feature@LoginAsAssignAssistingInvestigator') {}
    * call read('EnforcementCommonMethods.feature@EnforcementAssistingInvestigatorQueueByCaseNo') {}
    * match applicationStatus == 'Awaiting Review'
    * def documentDescUpload = 'SUPPLEMENTAL REPORT'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 218
	* def valueUpload = 'SUPPLEMENTAL REPORT'
	* def documentSubCategoryUpload = ''
    * call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}
    * call read('EnforcementCommonMethods.feature@SubmitInterviewReport') {}
  	* call read('LoginDetails.feature') { strToken:'#(strToken)'}
    * call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * match applicationStatus == 'Awaiting Review'
    * def documentDescUpload = 'REPORT OF INVESTIGATION"'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 176
	* def valueUpload = 'REPORT OF INVESTIGATION'
	* def documentSubCategoryUpload = ''
	* def isSaleToMinor = true
	* def isLeadInvestigator = true
    * call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}
    * call read('EnforcementCommonMethods.feature@CreateinvestigationReportWithYesSaleToMinor') {}
    * def DocumentDescRes2 = response[1].documentDesc	
    And match DocumentDescRes == 'REPORT OF INVESTIGATION"'
    And match DocumentDescRes1 == 'SUPPLEMENTAL REPORT'
    * call read('EnforcementCommonMethods.feature@SubmitAllInvestigationReports') {}
    And match applicationStatus == 'Report Awaiting Review'
  #  * call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}
    * call read('EnforcementCommonMethods.feature@GetMinorList') {}
  	* call read('EnforcementCommonMethods.feature@ViolationsAdd') {}
    * call read('EnforcementCommonMethods.feature@SaveMinor') {}
    * def AllApproved = false
    * def NwopChecked = true
    * def DecisionValue1 = 3
    * def DecisionValue2 = 4
    * def TaskDecision = 0
        * def PossibleSummarySuspension = true
    
    * call read('EnforcementCommonMethods.feature@SubmitSupervisorReport') {}
    * call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    And match applicationStatus == 'Additional Information Requested'
  #  * call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}

   	* call read('EnforcementCommonMethods.feature@NoticeWOPrejudiceFormPreInterviewForTC0003') {}
   	* call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * def documentDescUpload = 'NOTICE OF WARNING W/O PREJUDICE'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 148
	* def valueUpload = 'NOTICE OF WARNING W/O PREJUDICE'
	* def documentSubCategoryUpload = ''  
    * def documentDesc1 = 'NOTICE OF WARNING W/O PREJUDICE'
    * def documentDesc = 'NOTICE OF WARNING W/O PREJUDICE'
   	* call read('EnforcementCommonMethods.feature@NoticeWOPrejudiceFormPostInterviewForTC0003') {}
    * def documentDesc = 'NOTICE OF WARNING W/O PREJUDICE'
    * def valueprincipalId = caseId
    * def documentDesc = 'NWOP'
    * def documentDesc1 = 'NOTICE OF WARNING W/O PREJUDICE'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentUpdatedEnforcement') {}   
    * def referralCaseId = caseId	
   	* def typeOfNotification = 'Email Template Generic Non-portal'
	* def subject = 'NYS Liquor Authority Enforcement Case Information'
	* def emailBodyData = 'Dear '+legalName+', \r<br/>\r<br/>\r<br/>Important information pertaining to your record(s) is attached. \r<br/>\r<br/>Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date. \r<br/>\r<br/>To avoid consequential action, the response should be sent to the e-mail address provided in the letter. \r<br/> \r<br/>\r<br/>Sincerely yours, \r<br/>\r<br/>New York State Liquor Authority'
   	  And print emailBodyData
    * call read('CounselCommonMethods.feature@ValidateEmailCommunicationQueueCase') {}
   	* call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * def documentDescUpload = 'Notice of Action'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 391
	* def valueUpload = 'Notice of Action'
	* def documentSubCategoryUpload = ''  
    * def documentDesc1 = 'Notice of Action'
   	* call read('EnforcementCommonMethods.feature@NoticeOfActionFormPostInterview') {}
    * call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    And match applicationStatus == 'Additional Information Requested'
   # * call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}
    * def documentDescUpload = 'REPORT OF INVESTIGATION"'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 176
	* def valueUpload = 'REPORT OF INVESTIGATION'
	* def documentSubCategoryUpload = ''    
	* def isSaleToMinor = true
	* def isLeadInvestigator = true	
    * call read('EnforcementCommonMethods.feature@GetMinorList') {}
    * call read('EnforcementCommonMethods.feature@AmendInvestigationReport') {}
     And match DocumentDescRes == 'REPORT OF INVESTIGATION"'
     And match applicationStatus == 'Report Awaiting Review'
    * def AllApproved = true
    * def NwopChecked = true
    * def DecisionValue2 = 2                                                          
    * def TaskDecision = 1
    * def PossibleSummarySuspension = true
    * call read('EnforcementCommonMethods.feature@SubmitSupervisorReport') {}  
    * def waiting = waitFunc(30)
	   
	   Given path '/internalapi/api/CounselDashboard/GetCounselAttorneyClaimQueue'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      * def stringParam = "referralCaseApplicationNo~contains~'"+caseNo+"'"
       And params  {filter:'#(stringParam)',page:1,pageSize:10'}
   
   	 And request {filter:'#(stringParam)',page:1,pageSize:10'}
	  When method get
	 
	  Then status 200
	  And match response.data[0].taskStatus == 'Awaiting Review'
	  And match response.data[0].isSummarySuspension == 1	
    * call read('EnforcementCommonMethods.feature@EnforcementGenericQueueByCaseId') {expapplicationStatus:'Case Completed'}  	  	    
    * def appId = caseId	  
    * def documentDesc = 'NWOP'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentCase') {}	
    * def documentDesc = 'NOTICE OF WARNING W/O PREJUDICE'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentCase') {}
    * def documentDesc = 'Notice of Action'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentCase') {}	
    * def documentDesc = 'SUPPLEMENTAL REPORT'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentCase') {}	        
    * def documentDesc = 'REPORT OF INVESTIGATION\"'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentCase') {}	  
    
@TC0006_SLA_ENF_ETE_Positive_unrelated_complaint_Changes_in_Sale_To_Minor_Table_send_to_Counsel_SS    	
Scenario: TC0006_SLA_ENF_ETE_Positive_unrelated_complaint_Changes_in_Sale_To_Minor_Table_send_to_Counsel_SS
   
	# ********* Login Functionality *********************
    * callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
	* callonce read('EnforcementCommonMethods.feature@HearingCreateLic') {}
  		
  	* def SearchByLegalName = false
  	* def licKeywordName = 'Automation'
	* def documentDescUpload = 'COMPLAINT'
	* def acaTypeUpload = 'Complaint'
	* def keyUpload = 58
	* def valueUpload = 'COMPLAINT'
	* def documentSubCategoryUpload = ''  	
	* call read('EnforcementCommonMethods.feature@AddReferralFormEnforcement') {}
  	* call read('EnforcementCommonMethods.feature@ComplaintIdCreatedCheck') {}
  	* def isPositiveComplaint = true
  	* def hasRelatedCase = false
  	* def taskId = 6006
  	* def nwop = true
  	* call read('EnforcementCommonMethods.feature@PositiveComplaintYes') {}
      
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
	   
	   And match applicationStatus == 'Complaint Closed Positive'
	   
	* call read('EnforcementCommonMethods.feature@ViolationsAdd') {}
  	* def IsSummarySuspension = false
  	* def taskDecision = 1
   	* call read('EnforcementCommonMethods.feature@SubmitNWOPYes') {}
  	* call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * call read('EnforcementCommonMethods.feature@AssignAssistingInvestigator') {}
    * call read('EnforcementCommonMethods.feature@LoginAsAssignAssistingInvestigator') {}
    * call read('EnforcementCommonMethods.feature@EnforcementAssistingInvestigatorQueueByCaseNo') {}
    * match applicationStatus == 'Awaiting Review'
    * def documentDescUpload = 'SUPPLEMENTAL REPORT'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 218
	* def valueUpload = 'SUPPLEMENTAL REPORT'
	* def documentSubCategoryUpload = ''
    * call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}
    * call read('EnforcementCommonMethods.feature@SubmitInterviewReport') {}
  	* call read('LoginDetails.feature') { strToken:'#(strToken)'}
    * call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * match applicationStatus == 'Awaiting Review'
    * def documentDescUpload = 'REPORT OF INVESTIGATION"'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 176
	* def valueUpload = 'REPORT OF INVESTIGATION'
	* def documentSubCategoryUpload = ''
   	* call read('EnforcementCommonMethods.feature@NoticeWOPrejudiceFormPreInterview') {}
   	* call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * def documentDescUpload = 'NOTICE OF WARNING W/O PREJUDICE'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 148
	* def valueUpload = 'NOTICE OF WARNING W/O PREJUDICE'
	* def documentSubCategoryUpload = ''  
    * def documentDesc1 = 'NOTICE OF WARNING W/O PREJUDICE'
    * def documentDesc = 'NOTICE OF WARNING W/O PREJUDICE'
   	* call read('EnforcementCommonMethods.feature@NoticeWOPrejudiceFormPostInterview') {}  

   	* call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * def documentDescUpload = 'Notice of Action'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 391
	* def valueUpload = 'Notice of Action'
	* def documentSubCategoryUpload = ''  
    * def documentDesc1 = 'Notice of Action'
   	* call read('EnforcementCommonMethods.feature@NoticeOfActionFormPostInterview') {}
    * def referralCaseId = caseId	
   	* def typeOfNotification = 'Email Template Generic Non-portal'
	* def subject = 'NYS Liquor Authority Enforcement Case Information'
	* def emailBodyData = 'Dear '+legalName+', \r<br/>\r<br/>\r<br/>Important information pertaining to your record(s) is attached. \r<br/>\r<br/>Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date. \r<br/>\r<br/>To avoid consequential action, the response should be sent to the e-mail address provided in the letter. \r<br/> \r<br/>\r<br/>Sincerely yours, \r<br/>\r<br/>New York State Liquor Authority'
   	  And print emailBodyData
    * call read('CounselCommonMethods.feature@ValidateEmailCommunicationQueueCase') {}
    * call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    And match applicationStatus == 'Awaiting Review'	

	* def isSaleToMinor = true
	* def isLeadInvestigator = true
    * def documentDescUpload = 'REPORT OF INVESTIGATION"'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 176
	* def valueUpload = 'REPORT OF INVESTIGATION'
	* def documentSubCategoryUpload = ''
	* def isSaleToMinor = true
	* def isLeadInvestigator = true
    * call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}    
    * call read('EnforcementCommonMethods.feature@CreateinvestigationReportWithYesSaleToMinor') {}
    * call read('EnforcementCommonMethods.feature@SubmitAllInvestigationReports') {}
    And match applicationStatus == 'Report Awaiting Review'
  #  * call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}
    * call read('EnforcementCommonMethods.feature@GetMinorList') {}
  	* call read('EnforcementCommonMethods.feature@ViolationsAdd') {}
    * call read('EnforcementCommonMethods.feature@SaveMinor') {} 
    * def AllApproved = false
    * def NwopChecked = false
    * def DecisionValue1 = 3
    * def DecisionValue2 = 4
    * def TaskDecision = 0
    * call read('EnforcementCommonMethods.feature@SubmitSupervisorReport') {}
    * call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    And match applicationStatus == 'Additional Information Requested'
  #  * call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}
    * def documentDescUpload = 'REPORT OF INVESTIGATION"'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 176
	* def valueUpload = 'REPORT OF INVESTIGATION'
	* def documentSubCategoryUpload = ''    
	* def isSaleToMinor = true
	* def isLeadInvestigator = true	
    * call read('EnforcementCommonMethods.feature@GetMinorList') {}
    * call read('EnforcementCommonMethods.feature@AmendInvestigationReportforTC0006') {}
     And match applicationStatus == 'Report Awaiting Review'
    * def AllApproved = true
    * def NwopChecked = true
    * def DecisionValue2 = 2                                                          
    * def TaskDecision = 1
    * def PossibleSummarySuspension = false
    * call read('EnforcementCommonMethods.feature@SubmitSupervisorReport') {}  
    * def waiting = waitFunc(45)
    * def caseNumber = caseId
    * call read('EnforcementCommonMethods.feature@ClaimCreatedCase') {}  
    * call read('EnforcementCommonMethods.feature@EnforcementGenericQueueByCaseId') {expapplicationStatus:'Case Completed'}  	  	    
    * def appId = caseId	  
    * def documentDesc = 'NWOP'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentCase') {}	
    * def documentDesc = 'NOTICE OF WARNING W/O PREJUDICE'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentCase') {}
    * def documentDesc = 'Notice of Action'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentCase') {}	
    * def documentDesc = 'SUPPLEMENTAL REPORT'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentCase') {}	        
    * def documentDesc = 'REPORT OF INVESTIGATION\"'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentCase') {}	  
    
@TC0007_SLA_ENF_ETE_Positive_unrelated_complaint_NO_PSS_NWOP_Response_received_send_to_Counsel_SS    	
Scenario: TC0007_SLA_ENF_ETE_Positive_unrelated_complaint_NO_PSS_NWOP_Response_received_send_to_Counsel_SS
   
	# ********* Login Functionality *********************
    * callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
	* callonce read('EnforcementCommonMethods.feature@HearingCreateLic') {}
  		
  	* def SearchByLegalName = false
  	* def licKeywordName = 'Automation'
	* def documentDescUpload = 'COMPLAINT'
	* def acaTypeUpload = 'Complaint'
	* def keyUpload = 58
	* def valueUpload = 'COMPLAINT'
	* def documentSubCategoryUpload = ''  	
	* call read('EnforcementCommonMethods.feature@AddReferralFormEnforcement') {}
  	* call read('EnforcementCommonMethods.feature@ComplaintIdCreatedCheck') {}
  	* def isPositiveComplaint = true
  	* def hasRelatedCase = false
  	* def taskId = 6006
  	* def nwop = true
  	* call read('EnforcementCommonMethods.feature@PositiveComplaintYes') {}
  	      
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
	   
	   And match applicationStatus == 'Complaint Closed Positive'
	   
  	* call read('EnforcementCommonMethods.feature@ViolationsAdd') {}
  	* def IsSummarySuspension = false
  	* def taskDecision = 1
   	* call read('EnforcementCommonMethods.feature@SubmitNWOPYes') {}
	   
    * call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * match applicationStatus == 'Awaiting Review'
  #  * def documentDescUpload = 'REPORT OF INVESTIGATION"'
#	* def acaTypeUpload = 'Case'
	#* def keyUpload = 176
	#* def valueUpload = 'REPORT OF INVESTIGATION'
	#* def documentSubCategoryUpload = ''
   	* call read('EnforcementCommonMethods.feature@NoticeWOPrejudiceFormPreInterview') {}
   	* call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * def documentDescUpload = 'NOTICE OF WARNING W/O PREJUDICE'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 148
	* def valueUpload = 'NOTICE OF WARNING W/O PREJUDICE'
	* def documentSubCategoryUpload = ''  
    * def documentDesc1 = 'NOTICE OF WARNING W/O PREJUDICE'
    * def documentDesc = 'NOTICE OF WARNING W/O PREJUDICE'
   	* call read('EnforcementCommonMethods.feature@NoticeWOPrejudiceFormPostInterview') {}  

   	* call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * def documentDescUpload = 'Notice of Action'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 391
	* def valueUpload = 'Notice of Action'
	* def documentSubCategoryUpload = ''  
    * def documentDesc1 = 'Notice of Action'
   	* call read('EnforcementCommonMethods.feature@NoticeOfActionFormPostInterview') {}
   	* def referralCaseId = caseId	
   	* def typeOfNotification = 'Email Template Generic Non-portal'
	* def subject = 'NYS Liquor Authority Enforcement Case Information'
	* def emailBodyData = 'Dear '+legalName+', \r<br/>\r<br/>\r<br/>Important information pertaining to your record(s) is attached. \r<br/>\r<br/>Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date. \r<br/>\r<br/>To avoid consequential action, the response should be sent to the e-mail address provided in the letter. \r<br/> \r<br/>\r<br/>Sincerely yours, \r<br/>\r<br/>New York State Liquor Authority'
   	  And print emailBodyData
    * call read('CounselCommonMethods.feature@ValidateEmailCommunicationQueueCase') {}
    * call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    And match applicationStatus == 'Awaiting Review'	
  	* call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * call read('EnforcementCommonMethods.feature@AssignAssistingInvestigator') {}
    * call read('EnforcementCommonMethods.feature@LoginAsAssignAssistingInvestigator') {}

    * call read('EnforcementCommonMethods.feature@EnforcementAssistingInvestigatorQueueByCaseNo') {}
    * match applicationStatus == 'Awaiting Review'
    * def documentDescUpload = 'SUPPLEMENTAL REPORT'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 218
	* def valueUpload = 'SUPPLEMENTAL REPORT'
	* def documentSubCategoryUpload = ''
    * call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}
    * call read('EnforcementCommonMethods.feature@SubmitInterviewReport') {}
  	* call read('LoginDetails.feature') { strToken:'#(strToken)'}
    * call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * match applicationStatus == 'Awaiting Review'
    * def documentDescUpload = 'REPORT OF INVESTIGATION"'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 176
	* def valueUpload = 'REPORT OF INVESTIGATION'
	* def documentSubCategoryUpload = ''
	* def isSaleToMinor = false
	* def isLeadInvestigator = true
    * call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}
    * call read('EnforcementCommonMethods.feature@CreateinvestigationReport') {}
    And match DocumentDescRes == 'REPORT OF INVESTIGATION"'
    And match DocumentDescRes1 == 'SUPPLEMENTAL REPORT'
    * call read('EnforcementCommonMethods.feature@SubmitAllInvestigationReports') {}
    And match applicationStatus == 'Report Awaiting Review'
   # * call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}
    * def AllApproved = true
    * def NwopChecked = true
    * def DecisionValue1 = 1
    * def DecisionValue2 = 1
    * def TaskDecision = 1
    * def PossibleSummarySuspension = false
    * call read('EnforcementCommonMethods.feature@SubmitSupervisorReport') {}
    * def waiting = waitFunc(45)
    * def caseNumber = caseId
    * call read('EnforcementCommonMethods.feature@ClaimCreatedCase') {}  
    * call read('EnforcementCommonMethods.feature@EnforcementGenericQueueByCaseId') {expapplicationStatus:'Case Completed'}  	  	     
    * def appId = caseId	  
    * def documentDesc = 'NWOP'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentCase') {}	
    * def documentDesc = 'NOTICE OF WARNING W/O PREJUDICE'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentCase') {}
    * def documentDesc = 'Notice of Action'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentCase') {}	
    * def documentDesc = 'SUPPLEMENTAL REPORT'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentCase') {}	        
    * def documentDesc = 'REPORT OF INVESTIGATION\"'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentCase') {}	  
    
@TC0008_SLA_ENF_ETE_Positive_unrelated_complaint_Yes_for_PSS_No_NWOP_Response_send_to_Counsel_Attorney    	
Scenario: TC0008_SLA_ENF_ETE_Positive_unrelated_complaint_Yes_for_PSS_No_NWOP_Response_send_to_Counsel_Attorney
   
	# ********* Login Functionality *********************
    * callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
	* callonce read('EnforcementCommonMethods.feature@HearingCreateLic') {}
  		
  	* def SearchByLegalName = false
  	* def licKeywordName = 'Automation'
	* def documentDescUpload = 'COMPLAINT'
	* def acaTypeUpload = 'Complaint'
	* def keyUpload = 58
	* def valueUpload = 'COMPLAINT'
	* def documentSubCategoryUpload = ''  	
	* call read('EnforcementCommonMethods.feature@AddReferralFormEnforcement') {}
  	* call read('EnforcementCommonMethods.feature@ComplaintIdCreatedCheck') {}
  	* def isPositiveComplaint = true
  	* def hasRelatedCase = false
  	* def taskId = 6006
  	* def nwop = true
  	* call read('EnforcementCommonMethods.feature@PositiveComplaintYes') {}
  	  	      
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
	   
	   And match applicationStatus == 'Complaint Closed Positive'
	   
  	* call read('EnforcementCommonMethods.feature@ViolationsAdd') {}
  	* def IsSummarySuspension = true
  	* def taskDecision = 1
   	* call read('EnforcementCommonMethods.feature@SubmitNWOPYes') {}
	   
  # 	* call read('EnforcementCommonMethods.feature@ClaimEnforcementCaseToCounsel') {}
    And match isSummarySuspension == 1
  	* call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * call read('EnforcementCommonMethods.feature@AssignAssistingInvestigator') {}
    * call read('EnforcementCommonMethods.feature@LoginAsAssignAssistingInvestigator') {}
    * call read('EnforcementCommonMethods.feature@EnforcementAssistingInvestigatorQueueByCaseNo') {}
    * match applicationStatus == 'Awaiting Review'
    * def documentDescUpload = 'SUPPLEMENTAL REPORT'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 218
	* def valueUpload = 'SUPPLEMENTAL REPORT'
	* def documentSubCategoryUpload = ''
    * call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}
    * call read('EnforcementCommonMethods.feature@SubmitInterviewReport') {}
  	* call read('LoginDetails.feature') { strToken:'#(strToken)'}
    * call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * match applicationStatus == 'Awaiting Review'
    * def documentDescUpload = 'REPORT OF INVESTIGATION"'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 176
	* def valueUpload = 'REPORT OF INVESTIGATION'
	* def documentSubCategoryUpload = ''
	* def isSaleToMinor = false
	* def isLeadInvestigator = true
    * call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}
    * call read('EnforcementCommonMethods.feature@CreateinvestigationReport') {}
    And match DocumentDescRes == 'REPORT OF INVESTIGATION"'
    And match DocumentDescRes1 == 'SUPPLEMENTAL REPORT'
    * call read('EnforcementCommonMethods.feature@SubmitAllInvestigationReports') {}
    And match applicationStatus == 'Report Awaiting Review'
  #  * call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}
    * def AllApproved = true
    * def NwopChecked = true
    * def DecisionValue1 = 1
    * def DecisionValue2 = 1
    * def TaskDecision = 1
    * def PossibleSummarySuspension = true
    * call read('EnforcementCommonMethods.feature@SubmitSupervisorReport') {}
        * def waiting = waitFunc(45)
    
	   
	   Given path 'internalapi/api/CounselDashboard/GetCounselAttorneyClaimQueue'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      * def stringParam = "referralCaseApplicationNo~contains~'"+caseNo+"'"
       And params  {filter:'#(stringParam)',page:1,sort=isNopResponse-desc~isDiscoveryResponse-desc~isRejectionResponse-desc,pageSize:10'}
   
   	 And request {filter:'#(stringParam)',page:1,sort=isNopResponse-desc~isDiscoveryResponse-desc~isRejectionResponse-desc,pageSize:10'}
	  When method get
	 
	  Then status 200
	  And match response.data[0].taskStatus == 'Awaiting Review'
	  And match response.data[0].isSummarySuspension == 1   
    * call read('EnforcementCommonMethods.feature@EnforcementGenericQueueByCaseId') {expapplicationStatus:'Case Completed'}  	  	     
    * def appId = caseId	  
    * def documentDesc = 'SUPPLEMENTAL REPORT'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentCase') {}	        
    * def documentDesc = 'REPORT OF INVESTIGATION\"'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentCase') {}	  
    
@TC0009_SLA_ENF_ETE_Positive_unrealted_complaint_NO_to_YES_for_PSS_NWOP_Response_received_send_to_Counsel    	
Scenario: TC0009_SLA_ENF_ETE_Positive_unrealted_complaint_NO_to_YES_for_PSS_NWOP_Response_received_send_to_Counsel
   
	# ********* Login Functionality *********************
    * callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
	* callonce read('EnforcementCommonMethods.feature@HearingCreateLic') {}
  		
  	* def SearchByLegalName = false
  	* def licKeywordName = 'Automation'
	* def documentDescUpload = 'COMPLAINT'
	* def acaTypeUpload = 'Complaint'
	* def keyUpload = 58
	* def valueUpload = 'COMPLAINT'
	* def documentSubCategoryUpload = ''  	
	* call read('EnforcementCommonMethods.feature@AddReferralFormEnforcement') {}
  	* call read('EnforcementCommonMethods.feature@ComplaintIdCreatedCheck') {}
  	* def isPositiveComplaint = true
  	* def hasRelatedCase = false
  	* def taskId = 6006
  	* def nwop = true
  	* call read('EnforcementCommonMethods.feature@PositiveComplaintYes') {}
  	      
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
	   
	   And match applicationStatus == 'Complaint Closed Positive'
  	
  	* call read('EnforcementCommonMethods.feature@ViolationsAdd') {}
  	* def IsSummarySuspension = false
  	* def taskDecision = 1
   	* call read('EnforcementCommonMethods.feature@SubmitNWOPYes') {}
	   
  	* call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * call read('EnforcementCommonMethods.feature@AssignAssistingInvestigator') {}
    * call read('EnforcementCommonMethods.feature@LoginAsAssignAssistingInvestigator') {}
    * call read('EnforcementCommonMethods.feature@EnforcementAssistingInvestigatorQueueByCaseNo') {}
    * match applicationStatus == 'Awaiting Review'
    * def documentDescUpload = 'SUPPLEMENTAL REPORT'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 218
	* def valueUpload = 'SUPPLEMENTAL REPORT'
	* def documentSubCategoryUpload = ''
    * call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}
    * call read('EnforcementCommonMethods.feature@SubmitInterviewReport') {}
  	* call read('LoginDetails.feature') { strToken:'#(strToken)'}
    * call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * match applicationStatus == 'Awaiting Review'
    * def documentDescUpload = 'REPORT OF INVESTIGATION"'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 176
	* def valueUpload = 'REPORT OF INVESTIGATION'
	* def documentSubCategoryUpload = ''
	* call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}
   	* call read('EnforcementCommonMethods.feature@NoticeWOPrejudiceFormPreInterview') {}
   	* call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * def documentDescUpload = 'NOTICE OF WARNING W/O PREJUDICE'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 148
	* def valueUpload = 'NOTICE OF WARNING W/O PREJUDICE'
	* def documentSubCategoryUpload = ''  
    * def documentDesc1 = 'NOTICE OF WARNING W/O PREJUDICE'
    * def documentDesc = 'NOTICE OF WARNING W/O PREJUDICE'
   	* call read('EnforcementCommonMethods.feature@NoticeWOPrejudiceFormPostInterview') {}  

   	* call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * def documentDescUpload = 'Notice of Action'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 391
	* def valueUpload = 'Notice of Action'
	* def documentSubCategoryUpload = ''  
    * def documentDesc1 = 'Notice of Action'
   	* call read('EnforcementCommonMethods.feature@NoticeOfActionFormPostInterview') {}
    * call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    And match applicationStatus == 'Awaiting Review'
	* def isSaleToMinor = false
	* def isLeadInvestigator = true
    * call read('EnforcementCommonMethods.feature@CreateinvestigationReport') {}
    And match DocumentDescRes == 'REPORT OF INVESTIGATION'
    And match DocumentDescRes1 == 'SUPPLEMENTAL REPORT'
    * call read('EnforcementCommonMethods.feature@SubmitAllInvestigationReports') {}
    And match applicationStatus == 'Report Awaiting Review'
  #  * call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}
    * def AllApproved = true
    * def NwopChecked = true
    * def DecisionValue1 = 1
    * def DecisionValue2 = 1
    * def TaskDecision = 1
    * def PossibleSummarySuspension = true
    * call read('EnforcementCommonMethods.feature@SubmitSupervisorReport') {}
        * def waiting = waitFunc(45)
    
	   
	   Given path 'internalapi/api/CounselDashboard/GetCounselAttorneyQueue'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      * def stringParam = "referralCaseApplicationNo~contains~'"+caseNo+"'"
       And params  {filter:'#(stringParam)',page:1,pageSize:10'}
   
   	 And request {filter:'#(stringParam)',page:1,pageSize:10'}
	  When method get
	 
	  Then status 200
	  And match response.data[0].taskStatus == 'Awaiting Review'
	  And match response.data[0].isSummarySuspension == 1   
    * call read('EnforcementCommonMethods.feature@EnforcementGenericQueueByCaseId') {expapplicationStatus:'Case Completed'}  	  	     
    * def appId = caseId	  
    * def documentDesc = 'NWOP'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentCase') {}	
    * def documentDesc = 'NOTICE OF WARNING W/O PREJUDICE'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentCase') {}
    * def documentDesc = 'Notice of Action'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentCase') {}	
    * def documentDesc = 'SUPPLEMENTAL REPORT'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentCase') {}	        
    * def documentDesc = 'REPORT OF INVESTIGATION\"'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentCase') {}	 
    
@TC0010_SLA_ENF_ETE_Positive_unrelated_complaint_No_PSS_No_NWOP_Case_Closed
Scenario: TC0010_SLA_ENF_ETE_Positive_unrelated_complaint_No_PSS_No_NWOP_Case_Closed
   
	# ********* Login Functionality *********************
    * callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
	* callonce read('EnforcementCommonMethods.feature@HearingCreateLic') {}
  		
  	* def SearchByLegalName = false
  	* def licKeywordName = 'Automation'
	* def documentDescUpload = 'COMPLAINT'
	* def acaTypeUpload = 'Complaint'
	* def keyUpload = 58
	* def valueUpload = 'COMPLAINT'
	* def documentSubCategoryUpload = ''  	
	* call read('EnforcementCommonMethods.feature@AddReferralFormEnforcement') {}
  	* call read('EnforcementCommonMethods.feature@ComplaintIdCreatedCheck') {}
  	* def isPositiveComplaint = true
  	* def hasRelatedCase = false
  	* def taskId = 6006
  	* def nwop = false
  	* call read('EnforcementCommonMethods.feature@PositiveComplaintYes') {}
  	  	      
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
	   
	   And match applicationStatus == 'Complaint Closed Positive'
	   
  	* call read('EnforcementCommonMethods.feature@ViolationsAdd') {}
  	* def IsSummarySuspension = false
  	* def taskDecision = 1
   	* call read('EnforcementCommonMethods.feature@SubmitNWOPYes') {}
   	* call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * call read('EnforcementCommonMethods.feature@AssignAssistingInvestigator') {}
    * call read('EnforcementCommonMethods.feature@LoginAsAssignAssistingInvestigator') {}
    * call read('EnforcementCommonMethods.feature@EnforcementAssistingInvestigatorQueueByCaseNo') {}
    * match applicationStatus == 'Awaiting Review'
    * def documentDescUpload = 'SUPPLEMENTAL REPORT'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 218
	* def valueUpload = 'SUPPLEMENTAL REPORT'
	* def documentSubCategoryUpload = ''
    * call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}
    * call read('EnforcementCommonMethods.feature@SubmitInterviewReport') {}
  	* call read('LoginDetails.feature') { strToken:'#(strToken)'}
    * call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * match applicationStatus == 'Awaiting Review'
    * def documentDescUpload = 'REPORT OF INVESTIGATION"'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 176
	* def valueUpload = 'REPORT OF INVESTIGATION'
	* def documentSubCategoryUpload = ''
	* def isSaleToMinor = false
	* def isLeadInvestigator = true
	* call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}
    * call read('EnforcementCommonMethods.feature@CreateinvestigationReport') {}
    And match DocumentDescRes == 'REPORT OF INVESTIGATION"'
    And match DocumentDescRes1 == 'SUPPLEMENTAL REPORT'
    * call read('EnforcementCommonMethods.feature@SubmitAllInvestigationReports') {}
    And match applicationStatus == 'Report Awaiting Review'
  #  * call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}
    * def AllApproved = true
    * def NwopChecked = false
    * def DecisionValue1 = 3
    * def DecisionValue2 = 3
    * def TaskDecision = 3    
    * call read('EnforcementCommonMethods.feature@AddNotesEnforcement') {}
    * call read('EnforcementCommonMethods.feature@SubmitSupervisorReport') {expapplicationStatus:'case closed'}
    	   
       Given path 'internalapi/api/note/Case/get'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'   
   	 And request {"acaId":'#(caseId)',"acaStatus":"completed","acatype":"Case","acanoteId":-1,"noteId":-1}
	  When method post
	 
	  Then status 200
	  And match response.noteDetail == 'Test All Investigation Reports '

@TC0011_SLA_ENF_ETE_Positive_unrelated_Complaint_NWOP_process_by_Investigator_decision    	
Scenario: TC0011_SLA_ENF_ETE_Positive_unrelated_Complaint_NWOP_process_by_Investigator_decision
   
	# ********* Login Functionality *********************
    * callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
	* callonce read('EnforcementCommonMethods.feature@HearingCreateLic') {}
  		
  	* def SearchByLegalName = false
  	* def licKeywordName = 'Automation'
	* def documentDescUpload = 'COMPLAINT'
	* def acaTypeUpload = 'Complaint'
	* def keyUpload = 58
	* def valueUpload = 'COMPLAINT'
	* def documentSubCategoryUpload = ''  	
	* call read('EnforcementCommonMethods.feature@AddReferralFormEnforcement') {}
  	* call read('EnforcementCommonMethods.feature@ComplaintIdCreatedCheck') {}
  	* def isPositiveComplaint = true
  	* def hasRelatedCase = false
  	* def taskId = 6006
  	* def nwop = false
  	* call read('EnforcementCommonMethods.feature@PositiveComplaintYes') {}
  	      
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
	   
	   And match applicationStatus == 'Complaint Closed Positive'
	   
  	* def IsSummarySuspension = true
  	* def taskDecision = 1
   	* call read('EnforcementCommonMethods.feature@SubmitNWOPYes') {}
	   
	   	   Given path 'internalapi/api/CounselDashboard/GetCounselAttorneyQueue'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      * def stringParam = "referralCaseApplicationNo~contains~'"+caseNo+"'"
       And params  {filter:'#(stringParam)',page:1,pageSize:10'}
   
   	 And request {filter:'#(stringParam)',page:1,pageSize:10'}
	  When method get
	 
	  Then status 200
	  And match response.data[0].taskStatus == 'Awaiting Review'
	  And match response.data[0].isSummarySuspension == 1
	   
    * call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * match applicationStatus == 'Awaiting Review'
  #  * def documentDescUpload = 'REPORT OF INVESTIGATION"'
	#* def acaTypeUpload = 'Case'
	#* def keyUpload = 176
	#* def valueUpload = 'REPORT OF INVESTIGATION'
	#* def documentSubCategoryUpload = ''
   	* call read('EnforcementCommonMethods.feature@NoticeWOPrejudiceFormPreInterviewwithoutViolations') {}
   	* call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * def documentDescUpload = 'NOTICE OF WARNING W/O PREJUDICE'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 148
	* def valueUpload = 'NOTICE OF WARNING W/O PREJUDICE'
	* def documentSubCategoryUpload = ''  
    * def documentDesc1 = 'NOTICE OF WARNING W/O PREJUDICE'
    * def documentDesc = 'NOTICE OF WARNING W/O PREJUDICE'
   	* call read('EnforcementCommonMethods.feature@NoticeWOPrejudiceFormPostInterviewWithoutViolations') {}  
    * def referralCaseId = caseId	
    * def typeOfNotification = 'Email Template Generic Non-portal'
	* def subject = 'NYS Liquor Authority Enforcement Case Information'
	* def emailBodyData = 'Dear '+legalName+', \r<br/>\r<br/>\r<br/>Important information pertaining to your record(s) is attached. \r<br/>\r<br/>Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date. \r<br/>\r<br/>To avoid consequential action, the response should be sent to the e-mail address provided in the letter. \r<br/> \r<br/>\r<br/>Sincerely yours, \r<br/>\r<br/>New York State Liquor Authority'
   	  And print emailBodyData
    * call read('CounselCommonMethods.feature@ValidateEmailCommunicationQueueCase') {}
   	* call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * def documentDescUpload = 'Notice of Action'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 391
	* def valueUpload = 'Notice of Action'
	* def documentSubCategoryUpload = ''  
    * def documentDesc1 = 'Notice of Action'
   	* call read('EnforcementCommonMethods.feature@NoticeOfActionFormPostInterview') {}
    * call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    And match applicationStatus == 'Awaiting Review'	
  	* call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * call read('EnforcementCommonMethods.feature@AssignAssistingInvestigator') {}
    * call read('EnforcementCommonMethods.feature@LoginAsAssignAssistingInvestigator') {}

    * call read('EnforcementCommonMethods.feature@EnforcementAssistingInvestigatorQueueByCaseNo') {}
    * match applicationStatus == 'Awaiting Review'
    * def documentDescUpload = 'SUPPLEMENTAL REPORT'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 218
	* def valueUpload = 'SUPPLEMENTAL REPORT'
	* def documentSubCategoryUpload = ''
    * call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}
    * call read('EnforcementCommonMethods.feature@SubmitInterviewReport') {}
  	* call read('LoginDetails.feature') { strToken:'#(strToken)'}
    * call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * match applicationStatus == 'Awaiting Review'
    * def documentDescUpload = 'REPORT OF INVESTIGATION"'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 176
	* def valueUpload = 'REPORT OF INVESTIGATION'
	* def documentSubCategoryUpload = ''
	* def isSaleToMinor = false
	* def isLeadInvestigator = true
    * call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}
    * call read('EnforcementCommonMethods.feature@CreateinvestigationReport') {}
    And match DocumentDescRes == 'REPORT OF INVESTIGATION"'
    And match DocumentDescRes1 == 'SUPPLEMENTAL REPORT'
    * call read('EnforcementCommonMethods.feature@SubmitAllInvestigationReports') {}
    And match applicationStatus == 'Report Awaiting Review'
   # * call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}
    * def AllApproved = true
    * def NwopChecked = true
    * def DecisionValue1 = 1
    * def DecisionValue2 = 1
    * def TaskDecision = 1
    * def PossibleSummarySuspension = true
    * call read('EnforcementCommonMethods.feature@SubmitSupervisorReport') {}
        * def waiting = waitFunc(45)
    
	   
	   Given path 'internalapi/api/CounselDashboard/GetCounselAttorneyQueue'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      * def stringParam = "referralCaseApplicationNo~contains~'"+caseNo+"'"
       And params  {filter:'#(stringParam)',page:1,pageSize:10'}
   
   	 And request {filter:'#(stringParam)',page:1,pageSize:10'}
	  When method get
	 
	  Then status 200
	  And match response.data[0].taskStatus == 'Awaiting Review'
	  And match response.data[0].isSummarySuspension == 1
    * call read('EnforcementCommonMethods.feature@EnforcementGenericQueueByCaseId') {expapplicationStatus:'Case Completed'}  	  	     
    * def appId = caseId	  
    * def documentDesc = 'NWOP'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentCase') {}	
    * def documentDesc = 'NOTICE OF WARNING W/O PREJUDICE'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentCase') {}
    * def documentDesc = 'Notice of Action'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentCase') {}	
    * def documentDesc = 'SUPPLEMENTAL REPORT'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentCase') {}	        
    * def documentDesc = 'REPORT OF INVESTIGATION\"'
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentCase') {}
    * def referralCaseId = caseId	
    * def typeOfNotification = 'Email Template Generic Non-portal'
	* def subject = 'NYS Liquor Authority Enforcement Case Information'
	* def emailBodyData = 'Dear '+legalName+', \r<br/>\r<br/>\r<br/>Important information pertaining to your record(s) is attached. \r<br/>\r<br/>Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date. \r<br/>\r<br/>To avoid consequential action, the response should be sent to the e-mail address provided in the letter. \r<br/> \r<br/>\r<br/>Sincerely yours, \r<br/>\r<br/>New York State Liquor Authority'
   	  And print emailBodyData
    * call read('CounselCommonMethods.feature@ValidateEmailCommunicationQueueCase') {}    	 	  	      	          	             		      	     	       
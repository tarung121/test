Feature: UC_Enforcement_Arrest_Of_Licensee_ETE 
Background:
			* url BaseURL
  			* def config = { username: '#(dbUserName)', password:'#(dbUserPassword)', url: '#(dbQuery)',driverClassName: 'com.microsoft.sqlserver.jdbc.SQLServerDriver' }
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
			
			  	   * def waitFunc =
		        """
		      function(timeinMiliSeconds) {
		        // load java type into js engine
		        var Thread = Java.type('java.lang.Thread');
		        Thread.sleep(timeinMiliSeconds*1000); 
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
  	* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}

@TC0001_SLA_ENF_ETE_Arrest_of_Licensee_Response_received_by_Support_Staff_Case_Closed    	
Scenario: TC0001_SLA_ENF_ETE_Arrest_of_Licensee_Response_received_by_Support_Staff_Case_Closed
   
	# ********* Login Functionality *********************
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
    * call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueBylegalName') {expapplicationStatus:'Awaiting Review'}
    * match hasArrestOfLicRespRecieved == false
        
        * def typeOfNotification = 'Email Template Generic Non-portal'
		* def subject = 'NYS Liquor Authority Enforcement Case Information'
		* def emailBodyData = 'Dear '+legalName+', \r<br/>\r<br/>\r<br/>Important information pertaining to your record(s) is attached. \r<br/>\r<br/>Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date. \r<br/>\r<br/>To avoid consequential action, the response should be sent to the e-mail address provided in the letter. \r<br/> \r<br/>\r<br/>Sincerely yours, \r<br/>\r<br/>New York State Liquor Authority'
		And print emailBodyData
    * call read('CounselCommonMethods.feature@ValidateEmailCommunicationQueueCase') {}
    * def principalId = referralCaseId
    * def documentDesc = 'Arrest_Licensee '
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentUpdatedEnforcement') {}	    
    * call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueue') {expapplicationStatus:'Awaiting Review'}
	* def documentDescUpload = 'Response to Arrest Notification'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 465
	* def valueUpload = 'Response to Arrest Notification'
	* def documentSubCategoryUpload = ''
	* call read('EnforcementCommonMethods.feature@UploadDocumentArrest') {}
    * call read('EnforcementCommonMethods.feature@UpdateArrestNotification') {}
    * call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * match hasArrestOfLicRespRecieved == true
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
 #   * call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}
    * def AllApproved = true
    * def NwopChecked = false
    * def DecisionValue1 = 3
    * def DecisionValue2 = 3
    * def TaskDecision = 3    
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
        	    
@TC0003_SLA_ENF_ETE_Arrest_of_Licensee_Response_received_by_Lead_Investigator_referred_to_Counsel_Office    	
Scenario: TC0003_SLA_ENF_ETE_Arrest_of_Licensee_Response_received_by_Lead_Investigator_referred_to_Counsel_Office
   
	# ********* Login Functionality *********************
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
    * call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueBylegalName') {expapplicationStatus:'Awaiting Review'}
    * match hasArrestOfLicRespRecieved == false
        
        * def typeOfNotification = 'Email Template Generic Non-portal'
		* def subject = 'NYS Liquor Authority Enforcement Case Information'
		* def emailBodyData = 'Dear '+legalName+', \r<br/>\r<br/>\r<br/>Important information pertaining to your record(s) is attached. \r<br/>\r<br/>Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date. \r<br/>\r<br/>To avoid consequential action, the response should be sent to the e-mail address provided in the letter. \r<br/> \r<br/>\r<br/>Sincerely yours, \r<br/>\r<br/>New York State Liquor Authority'
		And print emailBodyData
    * call read('CounselCommonMethods.feature@ValidateEmailCommunicationQueueCase') {}
    * def principalId = referralCaseId
    * def documentDesc = 'Arrest_Licensee '
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentUpdatedEnforcement') {}	    
    * call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueue') {expapplicationStatus:'Awaiting Review'}
	* def documentDescUpload = 'Response to Arrest Notification'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 465
	* def valueUpload = 'Response to Arrest Notification'
	* def documentSubCategoryUpload = ''
	* call read('EnforcementCommonMethods.feature@UploadDocumentArrest') {}
    * call read('EnforcementCommonMethods.feature@UpdateArrestNotification') {}
    * call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * match hasArrestOfLicRespRecieved == true
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
 #   * call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}
    * def AllApproved = true
    * def NwopChecked = false
    * def DecisionValue1 = 1
    * def DecisionValue2 = 1
    * def TaskDecision = 1
    * call read('EnforcementCommonMethods.feature@SubmitSupervisorReport') {}
    * call read('CounselCommonMethods.feature@CounselSupportStaffClaimQueue') {exptaskStatus:'Awaiting Review',exptaskSource:'Enforcement'}
                  	
@TC0004_SLA_ENF_ETE_Arrest_of_Licensee_Response_received_by_Lead_Investigator_Send_to_Counsel_Attorney    	
Scenario: TC0004_SLA_ENF_ETE_Arrest_of_Licensee_Response_received_by_Lead_Investigator_Send_to_Counsel_Attorney
   
	# ********* Login Functionality *********************
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
    * call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueBylegalName') {expapplicationStatus:'Awaiting Review'}
    * match hasArrestOfLicRespRecieved == false
        
        * def typeOfNotification = 'Email Template Generic Non-portal'
		* def subject = 'NYS Liquor Authority Enforcement Case Information'
		* def emailBodyData = 'Dear '+legalName+', \r<br/>\r<br/>\r<br/>Important information pertaining to your record(s) is attached. \r<br/>\r<br/>Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date. \r<br/>\r<br/>To avoid consequential action, the response should be sent to the e-mail address provided in the letter. \r<br/> \r<br/>\r<br/>Sincerely yours, \r<br/>\r<br/>New York State Liquor Authority'
		And print emailBodyData
    * call read('CounselCommonMethods.feature@ValidateEmailCommunicationQueueCase') {}
    * def principalId = referralCaseId
    * def documentDesc = 'Arrest_Licensee '
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentUpdatedEnforcement') {}	    
    * call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueue') {expapplicationStatus:'Awaiting Review'}
	* def documentDescUpload = 'Response to Arrest Notification'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 465
	* def valueUpload = 'Response to Arrest Notification'
	* def documentSubCategoryUpload = ''
	* call read('EnforcementCommonMethods.feature@UploadDocumentArrest') {}
    * call read('EnforcementCommonMethods.feature@UpdateArrestNotification') {}
    * call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * match hasArrestOfLicRespRecieved == true
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
 #   * call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}
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
    * call read('EnforcementCommonMethods.feature@AmendInvestigationReport') {}
     And match DocumentDescRes == 'REPORT OF INVESTIGATION"'
     And match applicationStatus == 'Report Awaiting Review'
    * def AllApproved = false
    * def NwopChecked = true
    * def DecisionValue2 = 4                                                          
    * def TaskDecision = 0
    * def PossibleSummarySuspension = false
    * call read('EnforcementCommonMethods.feature@SubmitSupervisorReport') {}
    * call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
      And match applicationStatus == 'Additional Information Requested'
   	* call read('EnforcementCommonMethods.feature@NoticeWOPrejudiceFormPreInterviewForTC0003') {}
   	* call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * def documentDescUpload = 'NOTICE OF WARNING W/O PREJUDICE'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 148
	* def valueUpload = 'NOTICE OF WARNING W/O PREJUDICE'
	* def documentSubCategoryUpload = ''  
    * def documentDesc1 = 'NOTICE OF WARNING W/O PREJUDICE'
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
 #   * call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}
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
    And match applicationStatus == 'Report Awaiting Review'
    * def waiting = waitFunc(30)
	   
	   Given path '/internalapi/api/CounselDashboard/GetCounselAttorneyQueue'
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
	  
@TC0005_SLA_ENF_ETE_Arrest_of_Licensee_NWOP_by_Investigator_referred_to_Counsel_Office    	
Scenario: TC0005_SLA_ENF_ETE_Arrest_of_Licensee_NWOP_by_Investigator_referred_to_Counsel_Office
   
	# ********* Login Functionality *********************
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
    * call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueBylegalName') {expapplicationStatus:'Awaiting Review'}
    * match hasArrestOfLicRespRecieved == false
        
        * def typeOfNotification = 'Email Template Generic Non-portal'
		* def subject = 'NYS Liquor Authority Enforcement Case Information'
		* def emailBodyData = 'Dear '+legalName+', \r<br/>\r<br/>\r<br/>Important information pertaining to your record(s) is attached. \r<br/>\r<br/>Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date. \r<br/>\r<br/>To avoid consequential action, the response should be sent to the e-mail address provided in the letter. \r<br/> \r<br/>\r<br/>Sincerely yours, \r<br/>\r<br/>New York State Liquor Authority'
		And print emailBodyData
    * call read('CounselCommonMethods.feature@ValidateEmailCommunicationQueueCase') {}
    * def principalId = referralCaseId
    * def documentDesc = 'Arrest_Licensee '
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentUpdatedEnforcement') {}	    
    * call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueue') {expapplicationStatus:'Awaiting Review'}
	* def documentDescUpload = 'Response to Arrest Notification'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 465
	* def valueUpload = 'Response to Arrest Notification'
	* def documentSubCategoryUpload = ''
	* call read('EnforcementCommonMethods.feature@UploadDocumentArrest') {}
    * call read('EnforcementCommonMethods.feature@UpdateArrestNotification') {}
    * call read('EnforcementCommonMethods.feature@EnforcementInvestigatorQueueByCaseNo') {}
    * match hasArrestOfLicRespRecieved == true
    * call read('EnforcementCommonMethods.feature@AssignAssistingInvestigator') {}
    * call read('EnforcementCommonMethods.feature@LoginAsAssignAssistingInvestigator') {}
    * call read('EnforcementCommonMethods.feature@EnforcementAssistingInvestigatorQueueByCaseNo') {}
    * match applicationStatus == 'Awaiting Review'
   	* call read('EnforcementCommonMethods.feature@NoticeWOPrejudiceFormPreInterview') {}
    
       	* call read('EnforcementCommonMethods.feature@EnforcementAssistingInvestigatorQueueByCaseNo') {}
    * def documentDescUpload = 'NOTICE OF WARNING W/O PREJUDICE'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 148
	* def valueUpload = 'NOTICE OF WARNING W/O PREJUDICE'
	* def documentSubCategoryUpload = ''  
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
           	
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentUpdatedEnforcement') {}   
    * def referralCaseId = caseId	
    	* def typeOfNotification = 'Email Template Generic Non-portal'
		* def subject = 'NYS Liquor Authority Enforcement Case Information'
		* def emailBodyData = 'Dear '+legalName+', \r<br/>\r<br/>\r<br/>Important information pertaining to your record(s) is attached. \r<br/>\r<br/>Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date. \r<br/>\r<br/>To avoid consequential action, the response should be sent to the e-mail address provided in the letter. \r<br/> \r<br/>\r<br/>Sincerely yours, \r<br/>\r<br/>New York State Liquor Authority'
		And print emailBodyData
    * call read('CounselCommonMethods.feature@ValidateEmailCommunicationQueueCase') {}
   	* call read('EnforcementCommonMethods.feature@EnforcementAssistingInvestigatorQueueByCaseNo') {}
    * def documentDescUpload = 'Notice of Action'
	* def acaTypeUpload = 'Case'
	* def keyUpload = 391
	* def valueUpload = 'Notice of Action'
	* def documentSubCategoryUpload = ''  
    * def documentDesc1 = 'Notice of Action'
   	* call read('EnforcementCommonMethods.feature@NoticeOfActionFormPostInterview') {}
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
   # And match DocumentDescRes == 'SUPPLEMENTAL REPORT'
    And match DocumentDescRes1 == 'REPORT OF INVESTIGATION"'
    * call read('EnforcementCommonMethods.feature@SubmitAllInvestigationReports') {}
    And match applicationStatus == 'Report Awaiting Review'
   # * call read('EnforcementCommonMethods.feature@DownloadInterviewReport') {}
    * def AllApproved = true
    * def NwopChecked = false
    * def DecisionValue1 = 1
    * def DecisionValue2 = 1
    * def TaskDecision = 1
    * call read('EnforcementCommonMethods.feature@SubmitSupervisorReport') {}
    * call read('CounselCommonMethods.feature@CounselSupportStaffClaimQueue') {exptaskStatus:'Awaiting Review',exptaskSource:'Enforcement'}

    * def principalId = referralCaseId
    * def documentDesc = 'Arrest_Licensee '
    * call read('EnforcementCommonMethods.feature@ValidateAttachedDocumentUpdatedEnforcement') {}	
        
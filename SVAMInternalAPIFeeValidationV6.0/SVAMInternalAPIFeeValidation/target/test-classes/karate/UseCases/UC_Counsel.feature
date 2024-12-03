Feature: Counsel 
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
			
@TC0010_SLA_COUNSEL_ETE_Attorney_Post_Hearing_Submissions_for_cases    	
Scenario: TC0010_SLA_COUNSEL_ETE_Attorney_Post_Hearing_Submissions_for_cases
   
	# ********* Login Functionality *********************
    * callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
	* callonce read('EnforcementCommonMethods.feature@HearingCreateLic') {}
  		
  	* def SearchByLegalName = false
  	* def licKeywordName = 'Automation'
	* call read('CounselCommonMethods.feature@AddReferralForm') {}
    * callonce read('CounselCommonMethods.feature@ClaimCreatedCase') {}
    * callonce read('CounselCommonMethods.feature@AssignCaseToAttorney') {}	
	* call read('CounselCommonMethods.feature@PrepareNOP1') {}
    * call read('CounselCommonMethods.feature@NOPProcessingCompleteFlow') {}
    * call read('CounselCommonMethods.feature@AttachCertifiedMailReceipt') {}
	* call read('CounselCommonMethods.feature@SaveContactsDetails') {}
	* call read('CounselCommonMethods.feature@SaveWitnessDetails') {}
	* call read('CounselCommonMethods.feature@ScheduleCouselToHearing') {}
	* call read('CounselCommonMethods.feature@HearingAssignALJ') {}
	* call read('CounselCommonMethods.feature@HearingConclude') {ConcludeHearing:true, suppDocRequired:true}
	* call read('CounselCommonMethods.feature@GetHearingALJQueue') {applicationStatus:'Hearing Concluded'}
	* call read('CounselCommonMethods.feature@GetHearingBureauQueue') {HearingBureauStatus:'Pending Supplemental Documents '}
	* call read('CounselCommonMethods.feature@GetConsuelALJQueue') {ConsuelALJStatus:'Hearing Concluded'}
	* call read('CounselCommonMethods.feature@AttachAndSaveDocumentForHearingInfo') {}
         
@TC0008_SLA_COUNSEL_ETE_Attorney_Review_NOP_Scheduled_hearing_Send_Enforcement_to_serve_subpoena    	
Scenario: TC0008_SLA_COUNSEL_ETE_Attorney_Review_NOP_Scheduled_hearing_Send_Enforcement_to_serve_subpoena
   
	# ********* Login Functionality *********************
  		* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
	* callonce read('EnforcementCommonMethods.feature@HearingCreateLic') {}
  		
  	* def SearchByLegalName = false
  	* def licKeywordName = 'Automation'
	* call read('EnforcementCommonMethods.feature@AddReferralForm') {}
    * callonce read('EnforcementCommonMethods.feature@ClaimCreatedCase') {}
    * callonce read('EnforcementCommonMethods.feature@AssignCaseToAttorney') {}	
	* call read('EnforcementCommonMethods.feature@PrepareNOP') {}
    * call read('EnforcementCommonMethods.feature@NOPProcessingCompleteFlow') {}
    * call read('EnforcementCommonMethods.feature@AttachCertifiedMailReceipt') {}
	* call read('EnforcementCommonMethods.feature@SaveContactsDetails') {}
	* call read('EnforcementCommonMethods.feature@SaveWitnessDetails') {}
	* call read('EnforcementCommonMethods.feature@ScheduleCouselToHearing') {}
	* call read('EnforcementCommonMethods.feature@HearingAssignALJ') {}
	* call read('EnforcementCommonMethods.feature@HearingConclude') {ConcludeHearing:true, suppDocRequired:true}
	* call read('EnforcementCommonMethods.feature@GetHearingALJQueue') {applicationStatus:'Hearing Concluded'}
	* call read('EnforcementCommonMethods.feature@GetHearingBureauQueue') {HearingBureauStatus:'Pending Supplemental Documents '}
	* call read('EnforcementCommonMethods.feature@GetConsuelALJQueue') {ConsuelALJStatus:'Hearing Concluded'}
	* def letterTemplateId = "347"
	* call read('EnforcementCommonMethods.feature@ServeSubpoena') {}
    
@TC0003_SLA_COUNSEL_ETE_Attorney_Review_case_Prepare_NOP_NO_Contest_Send_to_Secretary_Office    	
Scenario: TC0003_SLA_COUNSEL_ETE_Attorney_Review_case_Prepare_NOP_NO_Contest_Send_to_Secretary_Office
   
	# ********* Login Functionality *********************
  		* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
	* callonce read('EnforcementCommonMethods.feature@HearingCreateLic') {}
  		
  	* def SearchByLegalName = false
  	* def licKeywordName = 'Automation'
  	* def suspensionStatus = true
	* call read('CounselCommonMethods.feature@AddReferralForm') {}
    * call read('CounselCommonMethods.feature@ClaimCreatedCase') {}
    * call read('CounselCommonMethods.feature@AssignCaseToAttorney') {}	
	* call read('CounselCommonMethods.feature@PrepareNOP1') {}
    * call read('CounselCommonMethods.feature@NOPProcessingCompleteFlow') {}
    * call read('CounselCommonMethods.feature@AttachCertifiedMailReceipt') {}
    
  #  **************** Hard Coded SaveContactDetails *****************************
    
	* call read('CounselCommonMethods.feature@SaveContactsDetails') {}
	* call read('CounselCommonMethods.feature@ValidatePreviewKeys') {}
	And match RepresentativeName == 'CHearing ' + 'Automation'
  
  #  **************** SaveContactDetails from search *****************************
    
#	* call read('CounselCommonMethods.feature@SaveContactsDetailsFromSearch') {}
#	* call read('CounselCommonMethods.feature@ValidatePreviewKeys') {}
#	And match RepresentativeName == repFirstName + ' ' + repLastName	
#	* call read('CounselCommonMethods.feature@SaveWitnessDetails') {}
	* def taskDecision = 1
	* def taskId = 7121
	* def hasNonCalendarItem = "true"
	* def isPlea = true
	* call read('CounselCommonMethods.feature@SubmitPlea') {}
	* def waiting = waitFunc(60)
	* call read('CounselCommonMethods.feature@CounselToSecOfficeLevel1') {expType:"Non-Full Board Calendar Item"}
	* call read('CounselCommonMethods.feature@WfhistoryCheck') {expBureau:'Secretary’s Office',expcurrentStatus:"Awaiting Review"}
	* call read('EnforcementCommonMethods.feature@AgendaTabCheck') {}
	
@TC0009_SLA_COUNSEL_ETE_Attorney_Review_case_Propose_summary_suspension_Send_case_to_Secretary_Office    	
Scenario: TC0009_SLA_COUNSEL_ETE_Attorney_Review_case_Propose_summary_suspension_Send_case_to_Secretary_Office
   
	# ********* Login Functionality *********************
  		* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
	* callonce read('EnforcementCommonMethods.feature@HearingCreateLic') {}
  		
  	* def SearchByLegalName = false
  	* def licKeywordName = 'Automation'
	* call read('CounselCommonMethods.feature@AddReferralForm') {}
    * call read('CounselCommonMethods.feature@ClaimCreatedCase') {}
    * call read('CounselCommonMethods.feature@AssignCaseToAttorney') {}	
    * call read('CounselCommonMethods.feature@CounselPrepareNOP1') {}	
    * call read('CounselCommonMethods.feature@CounselToSecOfficeLevel1') {expType:"Full Board Calendar Item"}	
		
@TC0012_SLA_COUNSEL_ETE_AQ_Licensee_recon_request_Attach_recon_Disapproved_by_Full_Board_Send_to_Secretary_Office    	
Scenario: TC0012_SLA_COUNSEL_ETE_AQ_Licensee_recon_request_Attach_recon_Disapproved_by_Full_Board_Send_to_Secretary_Office
   
	# ********* Login Functionality *********************
  		* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
  		
  	* def SearchByLegalName = false
  	* def licKeywordName = 'Automation'
	* call read('UC_LIC_032_LicenseBoardDecisions.feature@TC0006_NYC_SLA_LIC_LB_Disapproves_Application') {}
   # * call read('CounselCommonMethods.feature@ClaimCreatedCase') {}
   # * call read('CounselCommonMethods.feature@AssignCaseToAttorney') {}	
   # * call read('CounselCommonMethods.feature@CounselPrepareNOP') {}	
   # * call read('CounselCommonMethods.feature@CounselToSecOfficeLevel1') {expType:"Full Board Calendar Item"}	

@TC0013_SLA_COUNSEL_ETE_AQ_Attach_recon_License_Reconsideration_Chairman_Grant    	
Scenario: TC0013_SLA_COUNSEL_ETE_AQ_Attach_recon_License_Reconsideration_Chairman_Grant
   
	# ********* Login Functionality *********************
    * callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
  		
  	* def SearchByLegalName = false
  	* def licKeywordName = 'Automation'
	* call read('Uc_ReconReviewByLB.feature@TC0023_SLA_RCN_Review_Recon_request_LB_Recon_Cause_to_Deputy_Commissioner_main_License') {}
    * call read('ReconCommonMethods.feature@SubmitDCOLRecontoCounsel') {expStatus:'Awaiting Review'}
    * call read('CounselCommonMethods.feature@AssignCaseToAttorneyDCOL') {expTaskStatus:'Awaiting Review'}	
    * call read('ReconCommonMethods.feature@UploadRequestforReconDoc') {}
    * call read('CounselCommonMethods.feature@InitiateAppReconByAttorney') {}
    * call read('CounselCommonMethods.feature@SearchChairmanCounselGrid') {}
    * call read('CounselCommonMethods.feature@ReconByChairman') {taskDecision:1}
    	* def waiting = waitFunc(60)
    
    	* def typeOfNotification = 'Counsel App Recon Grant'
		* def subject = 'NYS Liquor Authority Counsel’s Office Record Information'
		* def emailBodyData = ''+legalName+'\r<br/>\r<br/>'
		And print emailBodyData
		* def emailBodyData2 = "Address1<br/>Address2\r<br/>New York,New York,12345\r<br/>" 
		* def emailBodyData3 = ''+ApplicationId+'\r<br/>\r<br/>\r<br/>Dear '+legalName+',\r<br/>\r<br/>\r<br/>Please be advised that the request for reconsideration of the above referenced has been granted.  You will receive notification of further action from the appropriate department.\r<br/>\r<br/>\r<br/>Sincerely,\r<br/>New York State Liquor Authority'
    * call read('LicensesCommonMethods.feature@ValidateEmailCommunicationQueue') {}
        * match serverResponseNotificationData[0].emailBody contains emailBodyData2
		* match serverResponseNotificationData[0].emailBody contains emailBodyData3

@TC0014_SLA_COUNSEL_ETE_AQ_Attach_recon_License_Reconsideration_Chairman_Deny    	
Scenario: TC0014_SLA_COUNSEL_ETE_AQ_Attach_recon_License_Reconsideration_Chairman_Deny
   
	# ********* Login Functionality *********************
    * callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
  		
  	* def SearchByLegalName = false
  	* def licKeywordName = 'Automation'
	* call read('Uc_ReconReviewByLB.feature@TC0023_SLA_RCN_Review_Recon_request_LB_Recon_Cause_to_Deputy_Commissioner_main_License') {}
    * call read('ReconCommonMethods.feature@SubmitDCOLRecontoCounsel') {expStatus:'Awaiting Review'}
    * call read('CounselCommonMethods.feature@AssignCaseToAttorneyDCOL') {expTaskStatus:'Awaiting Review'}	
    * call read('ReconCommonMethods.feature@UploadRequestforReconDoc') {}
    * call read('CounselCommonMethods.feature@InitiateAppReconByAttorney') {}
    * call read('CounselCommonMethods.feature@SearchChairmanCounselGrid') {}
    * call read('CounselCommonMethods.feature@ReconByChairman') {taskDecision:3}
    	* def waiting = waitFunc(60)
    
    	* def typeOfNotification = 'Counsel App Recon Deny'
		* def subject = 'NYS Liquor Authority Counsel’s Office Record Information'
		* def emailBodyData = ''+legalName+'\r<br/>\r<br/>Address1<br/>Address2\r<br/>New York,New York,12345\r<br/>'+ApplicationId+'\r<br/>\r<br/>\r<br/>Dear '+legalName+',\r<br/>\r<br/>Please be advised that the request for reconsideration of the above referenced was denied by a Member of the Board.  The determination dated '+MonthDateYear+', remains in effect.\r<br/>\r<br/>\r<br/>Sincerely,\r<br/>New York State Liquor Authority'
		And print emailBodyData
    * call read('LicensesCommonMethods.feature@ValidateEmailCommunicationQueue') {}
		
@TC0015_SLA_COUNSEL_ETE_AQ_Attach_recon_License_Reconsideration_Chairman_Send_to_FB    	
Scenario: TC0015_SLA_COUNSEL_ETE_AQ_Attach_recon_License_Reconsideration_Chairman_Send_to_FB
   
	# ********* Login Functionality *********************
    * callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
  		
  	* def SearchByLegalName = false
  	* def licKeywordName = 'Automation'
	* call read('Uc_ReconReviewByLB.feature@TC0023_SLA_RCN_Review_Recon_request_LB_Recon_Cause_to_Deputy_Commissioner_main_License') {}
    * call read('ReconCommonMethods.feature@SubmitDCOLRecontoCounsel') {expStatus:'Awaiting Review'}
    * call read('CounselCommonMethods.feature@AssignCaseToAttorneyDCOL') {expTaskStatus:'Awaiting Review'}	
    * call read('ReconCommonMethods.feature@UploadRequestforReconDoc') {}
    * call read('CounselCommonMethods.feature@InitiateAppReconByAttorney') {}
    * call read('CounselCommonMethods.feature@SearchChairmanCounselGrid') {}
    * call read('CounselCommonMethods.feature@ReconByChairman') {taskDecision:2}
    * call read('CounselCommonMethods.feature@FullBoardSecOffice2Search') {}

@TC0023_SLA_COUNSEL_ETE_Attorney_In_from_licensing_Process_NOP_NO_Contest_Send_to_Secretary_Office    	
Scenario: TC0023_SLA_COUNSEL_ETE_Attorney_In_from_licensing_Process_NOP_NO_Contest_Send_to_Secretary_Office
   
	# ********* Login Functionality *********************
  		* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
	* callonce read('EnforcementCommonMethods.feature@HearingCreateLic') {}
  		
  	* def SearchByLegalName = false
  	* def licKeywordName = 'Automation'
	* call read('CounselCommonMethods.feature@AddReferralForm') {}
    * call read('CounselCommonMethods.feature@ClaimCreatedCase') {}
    * call read('CounselCommonMethods.feature@AssignCaseToAttorney') {}	
    * call read('CounselCommonMethods.feature@CounselPrepareNOP') {}	
    * call read('CounselCommonMethods.feature@NOPProcessingCompleteFlowCounsel') {}	
    * call read('EnforcementCommonMethods.feature@AttachCertifiedMailReceipt') {}
	* def taskDecision = 1
	* def taskId = 7121
	* def hasNonCalendarItem = "true"
	* def isPlea = true
	* call read('CounselCommonMethods.feature@SubmitPlea') {}
	* def waiting = waitFunc(60)
	* call read('CounselCommonMethods.feature@CounselToSecOfficeLevel1') {expType:"Non-Full Board Calendar Item"}
	* call read('CounselCommonMethods.feature@WfhistoryCheck') {expBureau:'Secretary’s Office',expcurrentStatus:"Awaiting Review"}
	#* call read('EnforcementCommonMethods.feature@AgendaTabCheck') {}  
	
@TC0024_SLA_COUNSEL_ETE_Attorney_In_from_Enforcement_Process_NOP_NO_Contest_Send_to_Secretary_Office    	
Scenario: TC0024_SLA_COUNSEL_ETE_Attorney_In_from_Enforcement_Process_NOP_NO_Contest_Send_to_Secretary_Office
   
	# ********* Login Functionality *********************
  		* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
	* callonce read('EnforcementCommonMethods.feature@HearingCreateLic') {}
  		
  	* def SearchByLegalName = false
  	* def licKeywordName = 'Automation'
	* call read('CounselCommonMethods.feature@AddReferralForm') {}
    * call read('CounselCommonMethods.feature@ClaimCreatedCase') {}
    * call read('CounselCommonMethods.feature@AssignCaseToAttorney') {}	
    * call read('CounselCommonMethods.feature@CounselPrepareNOP') {}	
    * call read('CounselCommonMethods.feature@NOPProcessingCompleteFlowCounsel') {}	
    * call read('EnforcementCommonMethods.feature@AttachCertifiedMailReceipt') {}
	* def taskDecision = 1
	* def taskId = 7121
	* def hasNonCalendarItem = "true"
	* def isPlea = true
	* call read('CounselCommonMethods.feature@SubmitPlea') {}
	* def waiting = waitFunc(60)
	* call read('CounselCommonMethods.feature@CounselToSecOfficeLevel1') {expType:"Non-Full Board Calendar Item"}
	* call read('CounselCommonMethods.feature@WfhistoryCheck') {}
	#* call read('EnforcementCommonMethods.feature@AgendaTabCheck') {} 

@TC0026_SLA_COUNSEL_ETE_Attorney_Review_Application_Schedule_Hearing_Application    	
Scenario: TC0026_SLA_COUNSEL_ETE_Attorney_Review_Application_Schedule_Hearing_Application
   
	# ********* Login Functionality *********************
  		* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
  		
	* call read('UC_LIC_032_LicenseBoardDecisions.feature@TC0006_NYC_SLA_LIC_LB_Disapproves_Application') {}
	* call read('CounselCommonMethods.feature@CounselDissaprovalHearing') {}
	#* call read('EnforcementCommonMethods.feature@AgendaTabCheck') {} 
    * call read('CounselCommonMethods.feature@AssignCaseToAttorneyDCOL') {expTaskStatus:'Schedule For Hearing'}	
	* call read('CounselCommonMethods.feature@WitnessAttendeeAssign') {} 
    	* def waiting = waitFunc(60)
    
    	* def typeOfNotification = 'Counsel Generic Template application'
		* def subject = 'NYS Liquor Authority Counsel’s Office Record Information'
		* def emailBodyData = 'Dear '+legalName+',\r<br/>\r<br/>Important information pertaining to your record(s) is attached.\r<br/> \r<br/>Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date.\r<br/>\r<br/>To avoid consequential action, the response should be sent to the e-mail address provided in the letter.\r<br/>\r<br/>Sincerely yours, \r<br/>New York State Liquor Authority'
		And print emailBodyData
    * call read('CounselCommonMethods.feature@ValidateEmailCommunicationQueue') {}

    	* def typeOfNotification = 'Counsel Generic Template'
		* def subject = 'NYS Liquor Authority Counsel’s Office Record Information'
		* def emailBodyData = 'Dear '+legalName+',\r<br/>\r<br/>Important information pertaining to your record(s) is attached.\r<br/> \r<br/>Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date.\r<br/>\r<br/>To avoid consequential action, the response should be sent to the e-mail address provided in the letter.\r<br/>\r<br/>Sincerely yours, \r<br/>New York State Liquor Authority'
		And print emailBodyData
    * call read('CounselCommonMethods.feature@ValidateEmailCommunicationQueue') {}			

    	* def documentDesc = 'Disapproval Hearing Notice'
    * call read('LicensesCommonMethods.feature@ValidateAttachedDocumentUpdated') {}		
    
    	* def documentDesc = 'Disapproval Hearing Request'
    * call read('LicensesCommonMethods.feature@ValidateAttachedDocumentUpdated') {}	
    
    	* def documentDesc = 'Application Witness Request Letter'
    * call read('LicensesCommonMethods.feature@ValidateAttachedDocumentUpdated') {}

	* call read('CounselCommonMethods.feature@WfhistoryCheckChairman') {expBureau:'Counsel',expcurrentStatus:"Scheduled"}
 	* call read('CounselCommonMethods.feature@HbQueueLicensing') {expcurrentStatus:"Awaiting Review"}

@TC0007_SLA_COUNSEL_ETE_Attorney_Review_NOP_schedule_hearing_Adding_witness_Scheduled_Case    	
Scenario: TC0007_SLA_COUNSEL_ETE_Attorney_Review_NOP_schedule_hearing_Adding_witness_Scheduled_Case
   
	# ********* Login Functionality *********************
  		* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
	* callonce read('EnforcementCommonMethods.feature@HearingCreateLic') {}
  		
  	* def SearchByLegalName = false
  	* def licKeywordName = 'Automation'
	* call read('CounselCommonMethods.feature@AddReferralForm') {}
    * call read('CounselCommonMethods.feature@ClaimCreatedCase') {}
    * call read('CounselCommonMethods.feature@AssignCaseToAttorney') {}	
    * call read('CounselCommonMethods.feature@CounselPrepareNOP') {}	
    * call read('CounselCommonMethods.feature@NOPProcessingCompleteFlowCounsel') {}	
    * call read('EnforcementCommonMethods.feature@AttachCertifiedMailReceipt') {}
	* def taskId = 7121
    * call read('CounselCommonMethods.feature@CounselSubmitDiscovery') {expTaskStatus:'Schedule For Hearing',expBureau:'Counsel/Secretary’s Office',expcurrentStatus:'Schedule For Hearing'}	
 
    	* def typeOfNotification = 'Counsel Generic Template'
		* def subject = 'NYS Liquor Authority Counsel’s Office Record Information'
		* def emailBodyData = 'Dear '+legalName+',\r<br/>\r<br/>Important information pertaining to your record(s) is attached.\r<br/> \r<br/>Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date.\r<br/>\r<br/>To avoid consequential action, the response should be sent to the e-mail address provided in the letter.\r<br/>\r<br/>Sincerely yours, \r<br/>New York State Liquor Authority'
		And print emailBodyData
    * call read('CounselCommonMethods.feature@ValidateEmailCommunicationQueueCase') {}
    
    	* def documentDesc = '#(value)'
    * call read('LicensesCommonMethods.feature@ValidateAttachedDocumentUpdated') {}	     
	* call read('EnforcementCommonMethods.feature@SaveWitnessDetails') {}
	* call read('EnforcementCommonMethods.feature@ScheduleCouselToHearing') {}	    	

@TC0006_SLA_COUNSEL_ETE_Attorney_Review_NOP_response_Plea_Rejected    	
Scenario: TC0006_SLA_COUNSEL_ETE_Attorney_Review_NOP_response_Plea_Rejected
   
	# ********* Login Functionality *********************
  		* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
	* callonce read('EnforcementCommonMethods.feature@HearingCreateLic') {}
  		
  	* def SearchByLegalName = false
  	* def licKeywordName = 'Automation'
	* call read('CounselCommonMethods.feature@AddReferralForm') {}
    * call read('CounselCommonMethods.feature@ClaimCreatedCase') {}
    * call read('CounselCommonMethods.feature@AssignCaseToAttorney') {}	
    * call read('CounselCommonMethods.feature@CounselPrepareNOP') {}	
    * call read('CounselCommonMethods.feature@NOPProcessingCompleteFlowCounsel') {}	
    * call read('EnforcementCommonMethods.feature@AttachCertifiedMailReceipt') {}
	* call read('CounselCommonMethods.feature@PleaRejectionLetterPreview') {}
	* def taskDecision = 3
	* def taskId = 7121
	* def isPlea = true
	* call read('CounselCommonMethods.feature@SubmitRejectionPlea') {}
	* call read('CounselCommonMethods.feature@WfhistoryCheck') {expBureau:'Counsel/Secretary’s Office',expcurrentStatus:'Awaiting Customer Response'}
    	
    	* def typeOfNotification = 'Counsel Generic Template'
		* def subject = 'NYS Liquor Authority Counsel’s Office Record Information'
		* def emailBodyData = 'Dear '+legalName+',\r<br/>\r<br/>Important information pertaining to your record(s) is attached.\r<br/> \r<br/>Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date.\r<br/>\r<br/>To avoid consequential action, the response should be sent to the e-mail address provided in the letter.\r<br/>\r<br/>Sincerely yours, \r<br/>New York State Liquor Authority'
		And print emailBodyData
    * call read('CounselCommonMethods.feature@ValidateEmailCommunicationQueueCase') {}
    
    	* def documentDesc = 'PLEA FORM_PleaReject'
    * call read('LicensesCommonMethods.feature@ValidateAttachedDocumentUpdated') {}	
        
        * def documentDesc = 'Reject Letter'
    * call read('LicensesCommonMethods.feature@ValidateAttachedDocumentUpdated') {}	  

@TC0001_SLA_COUNSEL_ETE_SS_Review_Licensed_Case_Close_the_case    	
Scenario: TC0001_SLA_COUNSEL_ETE_SS_Review_Licensed_Case_Close_the_case
   
	# ********* Login Functionality *********************
  		* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
	* callonce read('EnforcementCommonMethods.feature@HearingCreateLic') {}
  		
  	* def SearchByLegalName = false
  	* def licKeywordName = 'Automation'
	* call read('CounselCommonMethods.feature@AddReferralForm') {}
    * call read('CounselCommonMethods.feature@ClaimCreatedCase') {}
    * call read('CounselCommonMethods.feature@CloseCase') {taskId:7103,taskDecision:2}
    * call read('CounselCommonMethods.feature@CounselGenericSearch') {}
	* call read('CounselCommonMethods.feature@WfhistoryCheck') {expBureau:'Counsel',expcurrentStatus:'Closed'}

@TC0002_SLA_COUNSEL_ETE_Attorney_Review_Licensed_Case_Close_the_Case    	
Scenario: TC0002_SLA_COUNSEL_ETE_Attorney_Review_Licensed_Case_Close_the_Case
   
	# ********* Login Functionality *********************
  		* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
	* callonce read('EnforcementCommonMethods.feature@HearingCreateLic') {}
  		
  	* def SearchByLegalName = false
  	* def licKeywordName = 'Automation'
	* call read('CounselCommonMethods.feature@AddReferralForm') {}
    * call read('CounselCommonMethods.feature@ClaimCreatedCase') {}
    * call read('CounselCommonMethods.feature@AssignCaseToAttorney') {}	
    * call read('CounselCommonMethods.feature@CloseCaseAttorney') {taskId:7105,taskDecision:3}
    * call read('CounselCommonMethods.feature@CounselGenericSearch') {}
	* call read('CounselCommonMethods.feature@WfhistoryCheck') {expBureau:'Counsel',expcurrentStatus:'Closed'}

@TC0004_SLA_COUNSEL_ETE_Attorney_sending_a_case_to_Enforcement    	
Scenario: TC0004_SLA_COUNSEL_ETE_Attorney_sending_a_case_to_Enforcement
   
	# ********* Login Functionality *********************
  		* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
	* callonce read('EnforcementCommonMethods.feature@HearingCreateLic') {}
  		
  	* def SearchByLegalName = false
  	* def licKeywordName = 'Automation'
	* call read('CounselCommonMethods.feature@AddReferralForm') {}
    * call read('CounselCommonMethods.feature@ClaimCreatedCase') {}
    * call read('CounselCommonMethods.feature@AssignCaseToAttorney') {}	
    * call read('CounselCommonMethods.feature@RequestAdditionalInfoFromEnforcement') {taskId:7105,taskDecision:3,isccDirector:true}

@TC0005_SLA_COUNSEL_ETE_Attorney_request_Additional_info_from_PD    	
Scenario: TC0005_SLA_COUNSEL_ETE_Attorney_request_Additional_info_from_PD
   
	# ********* Login Functionality *********************
  		* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
	* callonce read('EnforcementCommonMethods.feature@HearingCreateLic') {}
  		
  	* def SearchByLegalName = false
  	* def licKeywordName = 'Automation'
	* call read('CounselCommonMethods.feature@AddReferralForm') {}
    * call read('CounselCommonMethods.feature@ClaimCreatedCase') {}
    * call read('CounselCommonMethods.feature@AssignCaseToAttorney') {}	
    * def taskId = 7105
    * def taskDecision = 2
    * call read('CounselCommonMethods.feature@RequestAdditionalInfoFromPD') {}
	* call read('CounselCommonMethods.feature@WfhistoryCheck') {expBureau:'Counsel',expcurrentStatus:'Additional Info Required from PD'}
      	* def waiting = waitFunc(60)
    	
    	* def typeOfNotification = 'Case Refer to Pd'
		* def subject = 'NYS Liquor Authority Counsel’s Office Record Information'
		* def emailBodyData = 'Re:\tREQUEST FOR INFORMATION REGARDING:\r<br/>'+licenseId+' '+county+' '+licenseType+' \r<br/>'+legalName+'\r<br/>Address1\r<br/>Address2\r<br/>Spring Valley, New York 12345 \r<br/>Case #: '+referralCaseNo+'\r<br/>\r<br/>Dear '+pdname+',\r<br/>\r<br/>test \r<br/>\r<br/>Sincerely,\r<br/>New York State Liquor Authority'
		And print emailBodyData
    * call read('CounselCommonMethods.feature@ValidateEmailCommunicationQueueCase') {}
    
    	* def documentDesc = 'Police Records Request'
    * call read('LicensesCommonMethods.feature@ValidateAttachedDocumentUpdated') {}	

@TC0011_SLA_COUNSEL_ETE_Attorney_Post_Hearing_Submissions_for_application    	
Scenario: TC0011_SLA_COUNSEL_ETE_Attorney_Post_Hearing_Submissions_for_application
   
	# ********* Login Functionality *********************
  		* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
  		
	* call read('UC_LIC_032_LicenseBoardDecisions.feature@TC0006_NYC_SLA_LIC_LB_Disapproves_Application') {}
	* call read('CounselCommonMethods.feature@CounselDissaprovalHearing') {}
	#* call read('EnforcementCommonMethods.feature@AgendaTabCheck') {} 
    * call read('CounselCommonMethods.feature@AssignCaseToAttorneyDCOL') {expTaskStatus:'Schedule For Hearing'}	
	* call read('CounselCommonMethods.feature@WitnessAttendeeAssign') {} 
	* call read('CounselCommonMethods.feature@HbQueueLicensing') {expcurrentStatus:"Awaiting Review"} 
	* call read('EnforcementCommonMethods.feature@HearingAssignALJ') {}
	* call read('EnforcementCommonMethods.feature@HearingConclude') {ConcludeHearing:true, suppDocRequired:false}
	* def taskId = 7154
	* def taskDecision = 1
	* def workFlowName = 'Counsel'
	* call read('CounselCommonMethods.feature@PostHearingApplication') {} 
	* call read('CounselCommonMethods.feature@WfhistoryCheckChairman') {expBureau:'Counsel',expcurrentStatus:'Post Hearing Submission Received'}
	* call read('CounselCommonMethods.feature@HearingALJQueue') {expapplicationStatus:'Post Hearing Submission Received'}
    * def documentDesc = 'POST HEARING SUBMISSIONS'
    * call read('LicensesCommonMethods.feature@ValidateAttachedDocumentUpdated') {}	
    * match fileName == documentDesc+'.pdf' 
    
@TC0017_SLA_COUNSEL_ETE_AQ_Withdraw_All_Charges_General_Counsel_Approve    	
Scenario: TC0017_SLA_COUNSEL_ETE_AQ_Withdraw_All_Charges_General_Counsel_Approve
   
	# ********* Login Functionality *********************
    * callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
  		
  	* def SearchByLegalName = false
  	* def licKeywordName = 'Automation'
	* call read('EnforcementCommonMethods.feature@AddReferralForm') {}
    * callonce read('EnforcementCommonMethods.feature@ClaimCreatedCase') {}
    * callonce read('EnforcementCommonMethods.feature@AssignCaseToAttorney') {}	
	* call read('EnforcementCommonMethods.feature@PrepareNOP') {}
    * call read('EnforcementCommonMethods.feature@NOPProcessingCompleteFlow') {}
    * call read('EnforcementCommonMethods.feature@AttachCertifiedMailReceipt') {}
	* call read('EnforcementCommonMethods.feature@SaveContactsDetails') {}
	* call read('EnforcementCommonMethods.feature@SaveWitnessDetails') {}
	* call read('EnforcementCommonMethods.feature@ScheduleCouselToHearing') {} 
	* call read('CounselCommonMethods.feature@RequestWithdrawCharges') {}  
	* def workFlowName = 'WithdrawCharges' 
	* def taskDecision = 1  
	* call read('CounselCommonMethods.feature@WithdrawCharges') {}  
    	
    	* def typeOfNotification = 'Case Refer to Pd'
		* def subject = 'NYS Liquor Authority Counsel’s Office Record Information'
		* def emailBodyData = 'Re:\tREQUEST FOR INFORMATION REGARDING:\r<br/>'+licenseId+' '+county+' '+licenseType+' \r<br/>'+legalName+'\r<br/>Address1\r<br/>Address2\r<br/>Spring Valley, New York 12345 \r<br/>Case #: '+referralCaseNo+'\r<br/>\r<br/>Dear '+pdname+',\r<br/>\r<br/>test \r<br/>\r<br/>Sincerely,\r<br/>New York State Liquor Authority'
		And print emailBodyData
    * call read('CounselCommonMethods.feature@ValidateEmailCommunicationQueueCase') {}	

@TC0018_SLA_COUNSEL_ETE_AQ_Withdraw_All_Charges_General_Counsel_Disapprove    	
Scenario: TC0018_SLA_COUNSEL_ETE_AQ_Withdraw_All_Charges_General_Counsel_Disapprove
   
	# ********* Login Functionality *********************
    * callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
	* callonce read('EnforcementCommonMethods.feature@HearingCreateLic') {}
  		
  	* def SearchByLegalName = false
  	* def licKeywordName = 'Automation'
	* call read('EnforcementCommonMethods.feature@AddReferralForm') {}
    * callonce read('EnforcementCommonMethods.feature@ClaimCreatedCase') {}
    * callonce read('EnforcementCommonMethods.feature@AssignCaseToAttorney') {}	
	* call read('EnforcementCommonMethods.feature@PrepareNOP') {}
    * call read('EnforcementCommonMethods.feature@NOPProcessingCompleteFlow') {}
    * call read('EnforcementCommonMethods.feature@AttachCertifiedMailReceipt') {}
	* call read('EnforcementCommonMethods.feature@SaveContactsDetails') {}
	* call read('EnforcementCommonMethods.feature@SaveWitnessDetails') {}
	* call read('EnforcementCommonMethods.feature@ScheduleCouselToHearing') {} 
  
	        	            	       	            	     	            	       	            
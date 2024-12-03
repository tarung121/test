Feature: ATAP E2E Feature
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

  * callonce read('LoginDetails.feature') { strToken:'#(strToken)'}

@TC0001_SLA_ATAP_E2E_for_ConditionallyApprovalApplication
 Scenario:TC0001_SLA_ATAP_E2E_for_ConditionallyApprovalApplication
   

	   ## ******************** UC_ATAP: Validate TC0001_SLA_ATAP_E2E_for_ConditionallyApprovalApplication Scenario Start ***************************##
      
	   
	   	  * call read('ATAPCommonMethods.feature@ValidateATAPIntakeApplication') {}
	   	  * call read('ATAPCommonMethods.feature@GetAndValidateATAPReviewDashboardQueueStatus') {appStatus:'Awaiting Review'}  
	   	  * call read('ATAPCommonMethods.feature@ValidateSLAATAPConditionallyApprovedapplication') {}
	   	  * call read('ATAPCommonMethods.feature@GetAndValidateATAPSupportStaffQueueStatus') {appStatus:'Conditionally Approved'} 
	   	 * def wait = waitFunc(50)
                 * def typeOfNotification = 'Atap Application Generic Template'
                * def subject = 'NYS Liquor Authority ATAP Record Information'
                * def emailBodyData = 'Dear  ,\r<br/> \r<br/>'
                And print emailBodyData
                * def emailBodyData2 = "Important information pertaining to your record(s) is attached."  
                * def emailBodyData3 = "Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date."
                * def emailBodyData4 = "To avoid consequential action, the response should be sent to the e-mail address provided in the letter."  
                * def emailBodyData5 = "Sincerely yours,   \r<br/>New York State Liquor Authority"
                * call read('ATAPCommonMethods.feature@ValidateEmailCommunicationQueue') {}
                * match serverResponseNotificationData[0].emailBody contains emailBodyData2
                * match serverResponseNotificationData[0].emailBody contains emailBodyData3
                * match serverResponseNotificationData[0].emailBody contains emailBodyData4
                * match serverResponseNotificationData[0].emailBody contains emailBodyData5 
      
	       
	     ## ******************** UC_ATAP : Validate TC0001_SLA_ATAP_E2E_for_ConditionallyApprovalApplication Scenario End ***************************##   
	

    
    @TC0002_SLA_ATAP_E2E_forDeficientApplication
 Scenario:TC0002_SLA_ATAP_E2E_forDeficientApplication
   

	   ## ******************** UC_ATAP: Validate TC0002_SLA_ATAP_E2E_forDeficientApplication Scenario Start ***************************##
      
	  
	   	  * call read('ATAPCommonMethods.feature@ValidateATAPIntakeApplication') {}
	   	  * call read('ATAPCommonMethods.feature@GetAndValidateATAPReviewDashboardQueueStatus') {appStatus:'Awaiting Review'}  
	   	  
	 
	   		 * call read('ATAPCommonMethods.feature@ValidateSLAATAPDeficientapplication') {}
	   		 * call read('ATAPCommonMethods.feature@GetAndValidateATAPSupportStaffQueueStatus') {appStatus:'Additional Info Required'} 
	   	
	   
      	 * call read('ATAPCommonMethods.feature@ValidateSLAATAPIntakeDeficienciesUploadDocumentTextResponse') {}
	       * call read('ATAPCommonMethods.feature@GetAndValidateATAPGenericSearchStatus') {appStatus:'Additional Info Received'} 
	       
	       * def wait = waitFunc(50)
                 * def typeOfNotification = 'Atap Application Generic Template'
                * def subject = 'NYS Liquor Authority ATAP Record Information'
                * def emailBodyData = 'Dear  ,\r<br/> \r<br/>'
                And print emailBodyData
                * def emailBodyData2 = "Important information pertaining to your record(s) is attached."  
                * def emailBodyData3 = "Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date."
                * def emailBodyData4 = "To avoid consequential action, the response should be sent to the e-mail address provided in the letter."  
                * def emailBodyData5 = "Sincerely yours,   \r<br/>New York State Liquor Authority"
                * call read('ATAPCommonMethods.feature@ValidateEmailCommunicationQueue') {}
                * match serverResponseNotificationData[0].emailBody contains emailBodyData2
                * match serverResponseNotificationData[0].emailBody contains emailBodyData3
                * match serverResponseNotificationData[0].emailBody contains emailBodyData4
                * match serverResponseNotificationData[0].emailBody contains emailBodyData5 
	       
	     ## ******************** UC_ATAP : Validate TC0002_SLA_ATAP_E2E_forDeficientApplication Scenario End ***************************##   
	
    
    
    @TC0003_SLA_ATAP_E2E_forGrantReconsideration
 Scenario:TC0003_SLA_ATAP_E2E_forGrantReconsideration
 
	   ## ******************** UC_ATAP: Validate TC0003_SLA_ATAP_E2E_forGrantReconsideration Scenario Start ***************************##
      
	   	  * call read('ATAPCommonMethods.feature@ValidateATAPIntakeApplication') {}
	   	  * call read('ATAPCommonMethods.feature@GetAndValidateATAPReviewDashboardQueueStatus') {appStatus:'Awaiting Review'}  
	   	  
	   	  
	  
	   	    * call read('ATAPCommonMethods.feature@ValidateSLAATAPDisapprovedapplication') {}
	   	    * call read('ATAPCommonMethods.feature@GetAndValidateATAPSupportStaffQueueStatus') {appStatus:'Disapproved'} 
	   	    
	   	
	 
	         * call read('ATAPCommonMethods.feature@ValidateSLAATAPIntakeReconsiderationRequest') {}
	         * call read('ATAPCommonMethods.feature@GetAndValidateATAPReviewDashboardQueueStatus') {appStatus:'Recon Requested'} 
	    
     
         * call read('ATAPCommonMethods.feature@ValidateSLAATAPReviewReconsiderationRequest') {}
         * call read('ATAPCommonMethods.feature@GetAndValidateATAPChairmanDashboardQueueStatus') {appStatus:'Recon Received'} 
             
     
         * call read('ATAPCommonMethods.feature@ValidateSLAATAPApprovedReconsiderationRequestChairman') {}
          * call read('ATAPCommonMethods.feature@GetAndValidateATAPReviewDashboardQueueStatus') {appStatus:'Awaiting Review'}  
          
          * def wait = waitFunc(50)
                 * def typeOfNotification = 'Atap Application Generic Template'
                * def subject = 'NYS Liquor Authority ATAP Record Information'
                * def emailBodyData = 'Dear  ,\r<br/> \r<br/>'
                And print emailBodyData
                * def emailBodyData2 = "Important information pertaining to your record(s) is attached."  
                * def emailBodyData3 = "Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date."
                * def emailBodyData4 = "To avoid consequential action, the response should be sent to the e-mail address provided in the letter."  
                * def emailBodyData5 = "Sincerely yours,   \r<br/>New York State Liquor Authority"
                * call read('ATAPCommonMethods.feature@ValidateEmailCommunicationQueue') {}
                * match serverResponseNotificationData[0].emailBody contains emailBodyData2
                * match serverResponseNotificationData[0].emailBody contains emailBodyData3
                * match serverResponseNotificationData[0].emailBody contains emailBodyData4
                * match serverResponseNotificationData[0].emailBody contains emailBodyData5 
	       
	     ## ******************** UC_ATAP : Validate TC0003_SLA_ATAP_E2E_forGrantReconsideration Scenario End ***************************##  
	
	 
	   
    
 @TC0004_SLA_ATAP_E2E_forDenialReconsideration
 Scenario:TC0004_SLA_ATAP_E2E_forDenialReconsideration
   
	
	   ## ******************** UC_ATAP: Validate TC0004_SLA_ATAP_E2E_forDenialReconsideration Scenario Start ***************************##
      
	   	
	   	  * call read('ATAPCommonMethods.feature@ValidateATAPIntakeApplication') {}
	   	  * call read('ATAPCommonMethods.feature@GetAndValidateATAPReviewDashboardQueueStatus') {appStatus:'Awaiting Review'}     	 
	   	 
	  
	   	  * call read('ATAPCommonMethods.feature@ValidateSLAATAPDisapprovedapplication') {}
	   	  * call read('ATAPCommonMethods.feature@GetAndValidateATAPSupportStaffQueueStatus') {appStatus:'Disapproved'} 
   	   	
	   
	      * call read('ATAPCommonMethods.feature@ValidateSLAATAPIntakeReconsiderationRequest') {}
	      * call read('ATAPCommonMethods.feature@GetAndValidateATAPReviewDashboardQueueStatus') {appStatus:'Recon Requested'} 
	
         
         * call read('ATAPCommonMethods.feature@ValidateSLAATAPReviewReconsiderationRequest') {}
         * call read('ATAPCommonMethods.feature@GetAndValidateATAPChairmanDashboardQueueStatus') {appStatus:'Recon Received'} 
         
     
          * call read('ATAPCommonMethods.feature@ValidateSLAATAPDenialReconsiderationRequestChairman') {}
          * call read('ATAPCommonMethods.feature@GetAndValidateATAPGenericSearchStatus') {appStatus:'Recon Denied'} 
          
          * def wait = waitFunc(50)
                 * def typeOfNotification = 'Atap Application Generic Template'
                * def subject = 'NYS Liquor Authority ATAP Record Information'
                * def emailBodyData = 'Dear  ,\r<br/> \r<br/>'
                And print emailBodyData
                * def emailBodyData2 = "Important information pertaining to your record(s) is attached."  
                * def emailBodyData3 = "Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date."
                * def emailBodyData4 = "To avoid consequential action, the response should be sent to the e-mail address provided in the letter."  
                * def emailBodyData5 = "Sincerely yours,   \r<br/>New York State Liquor Authority"
                * call read('ATAPCommonMethods.feature@ValidateEmailCommunicationQueue') {}
                * match serverResponseNotificationData[0].emailBody contains emailBodyData2
                * match serverResponseNotificationData[0].emailBody contains emailBodyData3
                * match serverResponseNotificationData[0].emailBody contains emailBodyData4
                * match serverResponseNotificationData[0].emailBody contains emailBodyData5 
	       
	     ## ******************** UC_ATAP : Validate TC0004_SLA_ATAP_E2E_forDenialReconsideration Scenario End ***************************## 
	     
	     
	     
	   
    
 @TC0005_SLA_ATAP_E2E_forApplicationApproval
 Scenario:TC0005_SLA_ATAP_E2E_forApplicationApproval
 
	   ## ******************** UC_ATAP: Validate TC0005_SLA_ATAP_E2E_forApplicationApproval Scenario Start ***************************##
      
	   	
	   	   * call read('ATAPCommonMethods.feature@ValidateATAPIntakeApplication') {}
	   	  * call read('ATAPCommonMethods.feature@GetAndValidateATAPReviewDashboardQueueStatus') {appStatus:'Awaiting Review'} 
	   	  
	   	  
	   
	   	  * call read('ATAPCommonMethods.feature@ValidateSLAATAPConditionallyApprovedapplication') {}
	   	  * call read('ATAPCommonMethods.feature@GetAndValidateATAPSupportStaffQueueStatus') {appStatus:'Conditionally Approved'} 
	   	 
	   	 
	   
         * call read('ATAPCommonMethods.feature@ValidateSLAATAPPaymentSubmission') {}
         * call read('ATAPCommonMethods.feature@GetAndValidateATAPGenericSearchStatusWithSchoolId') {appStatus:'Approved'} 
         
         * def wait = waitFunc(50)
                 * def typeOfNotification = 'Atap Application Generic Template'
                * def subject = 'NYS Liquor Authority ATAP Record Information'
                * def emailBodyData = 'Dear  ,\r<br/> \r<br/>'
                And print emailBodyData
                * def emailBodyData2 = "Important information pertaining to your record(s) is attached."  
                * def emailBodyData3 = "Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date."
                * def emailBodyData4 = "To avoid consequential action, the response should be sent to the e-mail address provided in the letter."  
                * def emailBodyData5 = "Sincerely yours,   \r<br/>New York State Liquor Authority"
                * call read('ATAPCommonMethods.feature@ValidateEmailCommunicationQueue') {}
                * match serverResponseNotificationData[0].emailBody contains emailBodyData2
                * match serverResponseNotificationData[0].emailBody contains emailBodyData3
                * match serverResponseNotificationData[0].emailBody contains emailBodyData4
                * match serverResponseNotificationData[0].emailBody contains emailBodyData5 
	       
	     ## ******************** UC_ATAP : Validate TC0005_SLA_ATAP_E2E_forApplicationApproval Scenario End ***************************## 
	     
	 
    
    @TC0006_SLA_ATAP_E2E_forSessionApproval
 Scenario:TC0006_SLA_ATAP_E2E_forSessionApproval
 
	   ## ******************** UC_ATAP: Validate TC0006_SLA_ATAP_E2E_forSessionApproval Scenario Start ***************************##
      
	   
	   	   * call read('ATAPCommonMethods.feature@ValidateATAPIntakeApplication') {}
	   	  * call read('ATAPCommonMethods.feature@GetAndValidateATAPReviewDashboardQueueStatus') {appStatus:'Awaiting Review'}    	    	  
	  
	   	  * call read('ATAPCommonMethods.feature@ValidateSLAATAPConditionallyApprovedapplication') {}
	   	  * call read('ATAPCommonMethods.feature@GetAndValidateATAPSupportStaffQueueStatus') {appStatus:'Conditionally Approved'} 
	   	 
	   	  
	  
	       * call read('ATAPCommonMethods.feature@ValidateSLAATAPPaymentSubmission') {}
         * call read('ATAPCommonMethods.feature@GetAndValidateATAPGenericSearchStatusWithSchoolId') {appStatus:'Approved'} 
	
       
       	 * call read('ATAPCommonMethods.feature@ValidateSLAATAPSessionApplicationScheduleClassLate') {}
       	  * call read('ATAPCommonMethods.feature@GetAndValidateATAPReviewDashboardQueueStatusWithClassId') {appStatus:'Awaiting Scheduled Class Review'} 
       
    
       
       * call read('ATAPCommonMethods.feature@ValidateSLAATAPApproveOnSiteLateClass') {}
       * call read('ATAPCommonMethods.feature@GetAndValidateATAPSupportStaffQueueStatusWithSchoolId') {appStatus:'Awaiting Roster'} 
       
       * def wait = waitFunc(50)
                 * def typeOfNotification = 'Atap Application Generic Template'
                * def subject = 'NYS Liquor Authority ATAP Record Information'
                * def emailBodyData = 'Dear  ,\r<br/> \r<br/>'
                And print emailBodyData
                * def emailBodyData2 = "Important information pertaining to your record(s) is attached."  
                * def emailBodyData3 = "Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date."
                * def emailBodyData4 = "To avoid consequential action, the response should be sent to the e-mail address provided in the letter."  
                * def emailBodyData5 = "Sincerely yours,   \r<br/>New York State Liquor Authority"
                * call read('ATAPCommonMethods.feature@ValidateEmailCommunicationQueue') {}
                * match serverResponseNotificationData[0].emailBody contains emailBodyData2
                * match serverResponseNotificationData[0].emailBody contains emailBodyData3
                * match serverResponseNotificationData[0].emailBody contains emailBodyData4
                * match serverResponseNotificationData[0].emailBody contains emailBodyData5 
       
	       
	     ## ******************** UC_ATAP : Validate TC0006_SLA_ATAP_E2E_forSessionApproval Scenario End ***************************## 
	     
	   
    
      @TC0007_SLA_ATAP_E2E_forSessionDisapproval
 Scenario:TC0007_SLA_ATAP_E2E_forSessionDisapproval
 
	   ## ******************** UC_ATAP: Validate TC0007_SLA_ATAP_E2E_forSessionDisapproval Scenario Start ***************************##
      
	  
	   	   * call read('ATAPCommonMethods.feature@ValidateATAPIntakeApplication') {}
	   	  * call read('ATAPCommonMethods.feature@GetAndValidateATAPReviewDashboardQueueStatus') {appStatus:'Awaiting Review'}  
	   	  

	   * call read('ATAPCommonMethods.feature@ValidateSLAATAPConditionallyApprovedapplication') {}
	   	  * call read('ATAPCommonMethods.feature@GetAndValidateATAPSupportStaffQueueStatus') {appStatus:'Conditionally Approved'} 
	  
	  
	     * call read('ATAPCommonMethods.feature@ValidateSLAATAPPaymentSubmission') {}
         * call read('ATAPCommonMethods.feature@GetAndValidateATAPGenericSearchStatusWithSchoolId') {appStatus:'Approved'} 
	
         * call read('ATAPCommonMethods.feature@ValidateSLAATAPSessionApplicationScheduleClassLate') {}
       	  * call read('ATAPCommonMethods.feature@GetAndValidateATAPReviewDashboardQueueStatusWithClassId') {appStatus:'Awaiting Scheduled Class Review'}
       
     
     	   * call read('ATAPCommonMethods.feature@ValidateSLAATAPDisApproveOnSiteLateClass') {}
     	   * call read('ATAPCommonMethods.feature@GetAndValidateATAPGenericSearchStatusWithSchoolId') {appStatus:'Approved'} 
	     
	       * def wait = waitFunc(50)
                 * def typeOfNotification = 'Atap Application Generic Template'
                * def subject = 'NYS Liquor Authority ATAP Record Information'
                * def emailBodyData = 'Dear  ,\r<br/> \r<br/>'
                And print emailBodyData
                * def emailBodyData2 = "Important information pertaining to your record(s) is attached."  
                * def emailBodyData3 = "Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date."
                * def emailBodyData4 = "To avoid consequential action, the response should be sent to the e-mail address provided in the letter."  
                * def emailBodyData5 = "Sincerely yours,   \r<br/>New York State Liquor Authority"
                * call read('ATAPCommonMethods.feature@ValidateEmailCommunicationQueue') {}
                * match serverResponseNotificationData[0].emailBody contains emailBodyData2
                * match serverResponseNotificationData[0].emailBody contains emailBodyData3
                * match serverResponseNotificationData[0].emailBody contains emailBodyData4
                * match serverResponseNotificationData[0].emailBody contains emailBodyData5 
	       
	     ## ******************** UC_ATAP : Validate TC0007_SLA_ATAP_E2E_forSessionDisapproval Scenario End ***************************##
	     
	     
	    
    
    @TC0008_SLA_ATAP_E2E_forDisciplinaryActionRequiredSession
 Scenario:TC0008_SLA_ATAP_E2E_forDisciplinaryActionRequiredSession
 
	   ## ******************** UC_ATAP: Validate TC0008_SLA_ATAP_E2E_forDisciplinaryActionRequiredSession Scenario Start ***************************##
      
	   	
	   	    * call read('ATAPCommonMethods.feature@ValidateATAPIntakeApplication') {}
	   	   * call read('ATAPCommonMethods.feature@GetAndValidateATAPReviewDashboardQueueStatus') {appStatus:'Awaiting Review'}  
	   	  
	   	
	   	   * call read('ATAPCommonMethods.feature@ValidateSLAATAPConditionallyApprovedapplication') {}
	   	  * call read('ATAPCommonMethods.feature@GetAndValidateATAPSupportStaffQueueStatus') {appStatus:'Conditionally Approved'} 
	   	 
	    
	      * call read('ATAPCommonMethods.feature@ValidateSLAATAPPaymentSubmission') {}
         * call read('ATAPCommonMethods.feature@GetAndValidateATAPGenericSearchStatusWithSchoolId') {appStatus:'Approved'} 
         	     
   
       * call read('ATAPCommonMethods.feature@ValidateSLAATAPSessionApplicationScheduleClassLate') {}
       	  * call read('ATAPCommonMethods.feature@GetAndValidateATAPReviewDashboardQueueStatusWithClassId') {appStatus:'Awaiting Scheduled Class Review'}
 
        * call read('ATAPCommonMethods.feature@ValidateSLAATAPDisciplinaryActionRequired') {}
       
         * call read('ATAPCommonMethods.feature@ValidateATAPToCounselAttorneyDashboardStatus') {appStatus:'Awaiting Review',sourceStatus:'ATAP'}
         
         * call read('ATAPCommonMethods.feature@GetAndValidateCaseTabsAtCounselAttorneyDashboard')
	       
	     ## ******************** UC_ATAP : Validate TC0008_SLA_ATAP_E2E_forDisciplinaryActionRequiredSession Scenario End ***************************##
	     
	   
    
     @TC0009_SLA_ATAP_E2EforRosterApproval
 Scenario:TC0009_SLA_ATAP_E2EforRosterApproval
   
	
	   ## ******************** UC_ATAP: Validate TC0009_SLA_ATAP_E2EforRosterApproval Scenario Start ***************************##
      
	   	
	   	  * call read('ATAPCommonMethods.feature@ValidateATAPIntakeApplication') {}
	   	   * call read('ATAPCommonMethods.feature@GetAndValidateATAPReviewDashboardQueueStatus') {appStatus:'Awaiting Review'}  
	   	 
	   	
	   	   * call read('ATAPCommonMethods.feature@ValidateSLAATAPConditionallyApprovedapplication') {}
	   	  * call read('ATAPCommonMethods.feature@GetAndValidateATAPSupportStaffQueueStatus') {appStatus:'Conditionally Approved'} 
	   	 
	   	   
	      * call read('ATAPCommonMethods.feature@ValidateSLAATAPPaymentSubmission') {}
         * call read('ATAPCommonMethods.feature@GetAndValidateATAPGenericSearchStatusWithSchoolId') {appStatus:'Approved'} 
	    
	    
         * call read('ATAPCommonMethods.feature@ValidateSLAATAPSessionApplicationScheduleClassLate') {}
       	  * call read('ATAPCommonMethods.feature@GetAndValidateATAPReviewDashboardQueueStatusWithClassId') {appStatus:'Awaiting Scheduled Class Review'}
      
  
        * call read('ATAPCommonMethods.feature@ValidateSLAATAPApproveOnSiteLateClass') {}
       * call read('ATAPCommonMethods.feature@GetAndValidateATAPSupportStaffQueueStatusWithSchoolId') {appStatus:'Awaiting Roster'} 

       
        * call read('ATAPCommonMethods.feature@ValidateSLAATAPIntakeRosterSuccessfulSubmission') {}
         * call read('ATAPCommonMethods.feature@GetAndValidateATAPReviewDashboardQueueStatusWithClassId') {appStatus:'Review Roster'}
      
      
       * call read('ATAPCommonMethods.feature@ValidateSLAATAPApproveRoster') {}
        * call read('ATAPCommonMethods.feature@GetAndValidateATAPGenericSearchStatusWithSchoolId') {appStatus:'Approved'} 
          * def wait = waitFunc(50)
                 * def typeOfNotification = 'Atap Application Generic Template'
                * def subject = 'NYS Liquor Authority ATAP Record Information'
                * def emailBodyData = 'Dear  ,\r<br/> \r<br/>'
                And print emailBodyData
                * def emailBodyData2 = "Important information pertaining to your record(s) is attached."  
                * def emailBodyData3 = "Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date."
                * def emailBodyData4 = "To avoid consequential action, the response should be sent to the e-mail address provided in the letter."  
                * def emailBodyData5 = "Sincerely yours,   \r<br/>New York State Liquor Authority"
                * call read('ATAPCommonMethods.feature@ValidateEmailCommunicationQueue') {}
                * match serverResponseNotificationData[0].emailBody contains emailBodyData2
                * match serverResponseNotificationData[0].emailBody contains emailBodyData3
                * match serverResponseNotificationData[0].emailBody contains emailBodyData4
                * match serverResponseNotificationData[0].emailBody contains emailBodyData5 
	       
	     ## ******************** UC_ATAP : Validate TC0009_SLA_ATAP_E2EforRosterApproval Scenario End ***************************##
	     
	     
	  
    @TC0010_SLA_ATAP_E2EforRosterDenial
 Scenario:TC0010_SLA_ATAP_E2EforRosterDenial
  
	   ## ******************** UC_ATAP: Validate TC0010_SLA_ATAP_E2EforRosterDenial Scenario Start ***************************##
      
	   	   * call read('ATAPCommonMethods.feature@ValidateATAPIntakeApplication') {}
	   	   * call read('ATAPCommonMethods.feature@GetAndValidateATAPReviewDashboardQueueStatus') {appStatus:'Awaiting Review'}  
	   	   
	   	  * call read('ATAPCommonMethods.feature@ValidateSLAATAPConditionallyApprovedapplication') {}
	   	  * call read('ATAPCommonMethods.feature@GetAndValidateATAPSupportStaffQueueStatus') {appStatus:'Conditionally Approved'} 
	   	 
	   
	      * call read('ATAPCommonMethods.feature@ValidateSLAATAPPaymentSubmission') {}
         * call read('ATAPCommonMethods.feature@GetAndValidateATAPGenericSearchStatusWithSchoolId') {appStatus:'Approved'} 
	     
	     
         * call read('ATAPCommonMethods.feature@ValidateSLAATAPSessionApplicationScheduleClassLate') {}
       	 * call read('ATAPCommonMethods.feature@GetAndValidateATAPReviewDashboardQueueStatusWithClassId') {appStatus:'Awaiting Scheduled Class Review'}
       
       
          * call read('ATAPCommonMethods.feature@ValidateSLAATAPApproveOnSiteLateClass') {}
       * call read('ATAPCommonMethods.feature@GetAndValidateATAPSupportStaffQueueStatusWithSchoolId') {appStatus:'Awaiting Roster'} 
      
         
          * call read('ATAPCommonMethods.feature@ValidateSLAATAPIntakeRosterSuccessfulSubmission') {}
         * call read('ATAPCommonMethods.feature@GetAndValidateATAPReviewDashboardQueueStatusWithClassId') {appStatus:'Review Roster'}
    
      
           * call read('ATAPCommonMethods.feature@ValidateSLAATAPDenyRoster') {}
            * call read('ATAPCommonMethods.feature@GetAndValidateATAPGenericSearchStatusWithSchoolId') {appStatus:'Approved'} 
             * def wait = waitFunc(50)
                 * def typeOfNotification = 'Atap Application Generic Template'
                * def subject = 'NYS Liquor Authority ATAP Record Information'
                * def emailBodyData = 'Dear  ,\r<br/> \r<br/>'
                And print emailBodyData
                * def emailBodyData2 = "Important information pertaining to your record(s) is attached."  
                * def emailBodyData3 = "Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date."
                * def emailBodyData4 = "To avoid consequential action, the response should be sent to the e-mail address provided in the letter."  
                * def emailBodyData5 = "Sincerely yours,   \r<br/>New York State Liquor Authority"
                * call read('ATAPCommonMethods.feature@ValidateEmailCommunicationQueue') {}
                * match serverResponseNotificationData[0].emailBody contains emailBodyData2
                * match serverResponseNotificationData[0].emailBody contains emailBodyData3
                * match serverResponseNotificationData[0].emailBody contains emailBodyData4
                * match serverResponseNotificationData[0].emailBody contains emailBodyData5 
      
	       
	     ## ******************** UC_ATAP : Validate TC0010_SLA_ATAP_E2EforRosterDenial Scenario End ***************************##
	     
	 
    
     @TC0011_SLA_ATAP_E2E_forRosterDisciplinaryAction
 Scenario:TC0011_SLA_ATAP_E2E_forRosterDisciplinaryAction
 
	   ## ******************** UC_ATAP: Validate TC0011_SLA_ATAP_E2E_forRosterDisciplinaryAction Scenario Start ***************************##
      
	   	 
	   	 * call read('ATAPCommonMethods.feature@ValidateATAPIntakeApplication') {}
	   	   * call read('ATAPCommonMethods.feature@GetAndValidateATAPReviewDashboardQueueStatus') {appStatus:'Awaiting Review'} 
	   	
	   
	       * call read('ATAPCommonMethods.feature@ValidateSLAATAPConditionallyApprovedapplication') {}
	   	  * call read('ATAPCommonMethods.feature@GetAndValidateATAPSupportStaffQueueStatus') {appStatus:'Conditionally Approved'} 
	   
	   
	      * call read('ATAPCommonMethods.feature@ValidateSLAATAPPaymentSubmission') {}
         * call read('ATAPCommonMethods.feature@GetAndValidateATAPGenericSearchStatusWithSchoolId') {appStatus:'Approved'} 
	     
    
        * call read('ATAPCommonMethods.feature@ValidateSLAATAPSessionApplicationScheduleClassLate') {}
       	 * call read('ATAPCommonMethods.feature@GetAndValidateATAPReviewDashboardQueueStatusWithClassId') {appStatus:'Awaiting Scheduled Class Review'}
      
    
      
        * call read('ATAPCommonMethods.feature@ValidateSLAATAPApproveOnSiteLateClass') {}
       * call read('ATAPCommonMethods.feature@GetAndValidateATAPSupportStaffQueueStatusWithSchoolId') {appStatus:'Awaiting Roster'} 
      
     
      
       * call read('ATAPCommonMethods.feature@ValidateSLAATAPIntakeRosterSuccessfulSubmission') {}
         * call read('ATAPCommonMethods.feature@GetAndValidateATAPReviewDashboardQueueStatusWithClassId') {appStatus:'Review Roster'}
      
     
         * call read('ATAPCommonMethods.feature@ValidateSLAATAPDisciplinaryActionRequiredreviewRoster') {}
         
         * call read('ATAPCommonMethods.feature@ValidateATAPToCounselAttorneyDashboardStatus') {appStatus:'Awaiting Review',sourceStatus:'ATAP'}
         
	        * call read('ATAPCommonMethods.feature@GetAndValidateCaseTabsAtCounselAttorneyDashboard')
	        
	     ## ******************** UC_ATAP : Validate TC0011_SLA_ATAP_E2E_forRosterDisciplinaryAction Scenario End ***************************##
	    
	    
 @TC0012_SLA_ATAP_E2EforATAPApplicationApproval_forProgramTypeOnline
 Scenario:TC0012_SLA_ATAP_E2EforATAPApplicationApproval_forProgramTypeOnline
   
	
	   ## ******************** UC_ATAP: Validate TC0012_SLA_ATAP_E2EforATAPApplicationApproval_forProgramTypeOnline Scenario Start ***************************##
      
	   	  * call read('ATAPCommonMethods.feature@ValidateATAPIntakeApplicationProgramTypeOnline') {}
	   	   * call read('ATAPCommonMethods.feature@GetAndValidateATAPReviewDashboardQueueStatus') {appStatus:'Awaiting Review'} 
	   	   
	   		   	  
	   	   * call read('ATAPCommonMethods.feature@ValidateSLAATAPConditionallyApprovedapplication') {}
	   	  * call read('ATAPCommonMethods.feature@GetAndValidateATAPSupportStaffQueueStatus') {appStatus:'Conditionally Approved'} 
	   	  
	   
	      * call read('ATAPCommonMethods.feature@ValidateSLAATAPPaymentSubmission') {}
         * call read('ATAPCommonMethods.feature@GetAndValidateATAPGenericSearchStatusWithSchoolId') {appStatus:'Approved'} 
	     
     
       * call read('ATAPCommonMethods.feature@ValidateSLAATAPIntakeRosterOnlineClass') {}
        * call read('ATAPCommonMethods.feature@GetAndValidateATAPReviewDashboardQueueStatusWithClassId') {appStatus:'Review Roster'}
      
     
       * call read('ATAPCommonMethods.feature@ValidateSLAATAPApproveRoster') {}
       * call read('ATAPCommonMethods.feature@GetAndValidateATAPGenericSearchStatusWithSchoolId') {appStatus:'Approved'}
        * def wait = waitFunc(50)
                 * def typeOfNotification = 'Atap Application Generic Template'
                * def subject = 'NYS Liquor Authority ATAP Record Information'
                * def emailBodyData = 'Dear  ,\r<br/> \r<br/>'
                And print emailBodyData
                * def emailBodyData2 = "Important information pertaining to your record(s) is attached."  
                * def emailBodyData3 = "Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date."
                * def emailBodyData4 = "To avoid consequential action, the response should be sent to the e-mail address provided in the letter."  
                * def emailBodyData5 = "Sincerely yours,   \r<br/>New York State Liquor Authority"
                * call read('ATAPCommonMethods.feature@ValidateEmailCommunicationQueue') {}
                * match serverResponseNotificationData[0].emailBody contains emailBodyData2
                * match serverResponseNotificationData[0].emailBody contains emailBodyData3
                * match serverResponseNotificationData[0].emailBody contains emailBodyData4
                * match serverResponseNotificationData[0].emailBody contains emailBodyData5 
      
	     ## ******************** UC_ATAP : Validate TC0012_SLA_ATAP_E2EforATAPApplicationApproval_forProgramTypeOnline Scenario End ***************************##
	     
	     
    
    @TC0013_SLA_ATAP_E2EforATAPApplicationApproval_forProgramTypeClassroom
 Scenario:TC0013_SLA_ATAP_E2EforATAPApplicationApproval_forProgramTypeClassroom
   
	
	   ## ******************** UC_ATAP: Validate TC0013_SLA_ATAP_E2EforATAPApplicationApproval_forProgramTypeClassroom Scenario Start ***************************##
      
	   	  * call read('ATAPCommonMethods.feature@ValidateATAPIntakeApplicationProgramTypeClassroom')
	   	    * call read('ATAPCommonMethods.feature@GetAndValidateATAPReviewDashboardQueueStatus') {appStatus:'Awaiting Review'} 
	   	
	   	     * call read('ATAPCommonMethods.feature@ValidateSLAATAPConditionallyApprovedapplication') {}
	   	  * call read('ATAPCommonMethods.feature@GetAndValidateATAPSupportStaffQueueStatus') {appStatus:'Conditionally Approved'} 
	   	
	   	   
	         * call read('ATAPCommonMethods.feature@ValidateSLAATAPPaymentSubmission') {}
         * call read('ATAPCommonMethods.feature@GetAndValidateATAPGenericSearchStatusWithSchoolId') {appStatus:'Approved'} 
	     
     
          * call read('ATAPCommonMethods.feature@ValidateSLAATAPSessionApplicationScheduleClassLate') {}
       	  * call read('ATAPCommonMethods.feature@GetAndValidateATAPReviewDashboardQueueStatusWithClassId') {appStatus:'Awaiting Scheduled Class Review'}
      
    
         * call read('ATAPCommonMethods.feature@ValidateSLAATAPApproveOnSiteLateClass') {}
         * call read('ATAPCommonMethods.feature@GetAndValidateATAPSupportStaffQueueStatusWithSchoolId') {appStatus:'Awaiting Roster'} 
     
     
         * call read('ATAPCommonMethods.feature@ValidateSLAATAPIntakeRosterSuccessfulSubmission') {}
         * call read('ATAPCommonMethods.feature@GetAndValidateATAPReviewDashboardQueueStatusWithClassId') {appStatus:'Review Roster'}
      
    
        * call read('ATAPCommonMethods.feature@ValidateSLAATAPApproveRoster') {}
        * call read('ATAPCommonMethods.feature@GetAndValidateSLAATAPApplicationSearchQueueStatus') {} 
        * call read('ATAPCommonMethods.feature@GetAndValidateATAPGenericSearchStatusWithSchoolId') {appStatus:'Approved'} 
        
        * def wait = waitFunc(50)
                 * def typeOfNotification = 'Atap Application Generic Template'
                * def subject = 'NYS Liquor Authority ATAP Record Information'
                * def emailBodyData = 'Dear  ,\r<br/> \r<br/>'
                And print emailBodyData
                * def emailBodyData2 = "Important information pertaining to your record(s) is attached."  
                * def emailBodyData3 = "Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date."
                * def emailBodyData4 = "To avoid consequential action, the response should be sent to the e-mail address provided in the letter."  
                * def emailBodyData5 = "Sincerely yours,   \r<br/>New York State Liquor Authority"
                * call read('ATAPCommonMethods.feature@ValidateEmailCommunicationQueue') {}
                * match serverResponseNotificationData[0].emailBody contains emailBodyData2
                * match serverResponseNotificationData[0].emailBody contains emailBodyData3
                * match serverResponseNotificationData[0].emailBody contains emailBodyData4
                * match serverResponseNotificationData[0].emailBody contains emailBodyData5 
        
	     ## ******************** UC_ATAP : Validate TC0013_SLA_ATAP_E2EforATAPApplicationApproval_forProgramTypeClassroom Scenario End ***************************##
	     
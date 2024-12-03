Feature: Examiner review
Background:
			* url BaseURL
			* def config = { username: '#(dbUserName)', password:'#(dbUserPassword)', url: '#(dbQuery)',driverClassName: 'com.microsoft.sqlserver.jdbc.SQLServerDriver' }
    	 	* def DbUtils = Java.type('utils.DbUtils')
    	 	* def defineProvisions = false
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
   
    * def currentFormattedDate = dateFnc(0)
    * def expiredFormattedDate = dateFnc(0)
   * def SafekeepingStatus = 0
   * def defineProvisions = 0
 @TC0001_SLA_REN_Hold_for_CB_Notice_Approved_Waiver_YES	  
Scenario: TC0001_SLA_REN_Hold_for_CB_Notice_Approved_Waiver_YES
   	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC0001_SLA_REN_Hold_for_CB_Notice_Approved_Waiver_YES Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0055_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice') {}
         * def waverStatus = true
         * def decisionType = 'Approved'
         * call read('RenewalCommonMethods.feature@RenewalHoldForCBReview') {expStatus:'Approved'}
        
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	   	* def wait = waitFunc(70)
	    * call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'License_Cert'}
         * def emailBodyData = 'Failure to provide a timely response may result in the disapproval of your application. The response should be sent to the e-mail address provided in the letter.'
	  	* def subject = 'NYS Liquor Authority Licensing Bureau Record Information'
	  	* def typeOfNotification = 'Application Receipt'
	  	* call read('LicensesCommonMethods.feature@ValidateEmailCommunicationQueue'){}
	    
	   	 
	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC0001_SLA_REN_Hold_for_CB_Notice_Approved_Waiver_YES  Scenario End ***************************##   
         
 @TC002_SLA_REN_Hold_for_CB_Notice_Approved_Waiver_NO
Scenario: TC002_SLA_REN_Hold_for_CB_Notice_Approved_Waiver_NO
   	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC002_SLA_REN_Hold_for_CB_Notice_Approved_Waiver_NO Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0055_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice') {}
         * def waverStatus = false
          * def decisionType = 'Approved'
         * call read('RenewalCommonMethods.feature@RenewalHoldForCBReview') {expStatus:'Approved'}
        
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	   	* def wait = waitFunc(70)
	    * call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'License_Cert'}
         * def emailBodyData = 'Failure to provide a timely response may result in the disapproval of your application. The response should be sent to the e-mail address provided in the letter.'
	  	* def subject = 'NYS Liquor Authority Licensing Bureau Record Information'
	  	* def typeOfNotification = 'Application Receipt'
	  	* call read('LicensesCommonMethods.feature@ValidateEmailCommunicationQueue'){}
	    
	   	 
	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC002_SLA_REN_Hold_for_CB_Notice_Approved_Waiver_NO  Scenario End ***************************##   
       
 
 
         
@TC0003_SLA_REN_Hold_for_CB_Notice_Disapproved_Cause_Select_Reason
Scenario: TC0003_SLA_REN_Hold_for_CB_Notice_Disapproved_Cause_Select_Reason
   	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC0003_SLA_REN_Hold_for_CB_Notice_Disapproved_Cause_Select_Reason Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0055_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice') {}
         * def waverStatus = null
          * def decisionType = 'Disapproved'
           * def couseCheckboxChecked = true
         * call read('RenewalCommonMethods.feature@RenewalHoldForCBReview') {expStatus:'Disapproved'}
        
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	   #* def wait = waitFunc(70)
	    #* call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'Disapproval Letter'}
        # * def emailBodyData = 'Failure to provide a timely response may result in the disapproval of your application. The response should be sent to the e-mail address provided in the letter.'
	  	#* def subject = 'NYS Liquor Authority Licensing Bureau Record Information'
	  	#* def typeOfNotification = 'Application Receipt'
	  	#* call read('LicensesCommonMethods.feature@ValidateEmailCommunicationQueue'){}
	    
	   	 
	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC0003_SLA_REN_Hold_for_CB_Notice_Disapproved_Cause_Select_Reason  Scenario End ***************************##   
           


 	
         
@TC0004_SLA_REN_Hold_for_CB_Notice_Disapprove_to_counsel_Cause
Scenario: TC0004_SLA_REN_Hold_for_CB_Notice_Disapprove_to_counsel_Cause
   	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC0004_SLA_REN_Hold_for_CB_Notice_Disapprove_to_counsel_Cause Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0055_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice') {}
         * def waverStatus = false
          * def decisionType = 'Disapproval to Counsel'
           * def couseCheckboxChecked = true
         * call read('RenewalCommonMethods.feature@RenewalHoldForCBReview') {expStatus:'Pending Disapproval Letter'}
        
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	  * def letterStatus = 'Pending Disapproval Letter'
	 	* def wait = waitFunc(30)
		* call read('LicensesCommonMethods.feature@SearchAndValidateCounselQueueApplicationStatus') {}
	
	   	 
	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC0004_SLA_REN_Hold_for_CB_Notice_Disapprove_to_counsel_Cause  Scenario End ***************************##   
           
@TC0004a_SLA_REN_Hold_for_CB_Notice_Disapprove_to_Counsel_FTC
Scenario: TC0004a_SLA_REN_Hold_for_CB_Notice_Disapprove_to_FTC
   	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC0004a_SLA_REN_Hold_for_CB_Notice_Disapprove_to_FTC Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0055_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice') {}
         * def waverStatus = false
          * def decisionType = 'Disapproval to Counsel'
           * def couseCheckboxChecked = false
         * call read('RenewalCommonMethods.feature@RenewalHoldForCBReview') {expStatus:'Pending Disapproval Letter'}
        
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	 	* def letterStatus = 'Pending Disapproval Letter'
	 	* def wait = waitFunc(30)
		* call read('LicensesCommonMethods.feature@SearchAndValidateCounselQueueApplicationStatus') {}
	
	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC0004a_SLA_REN_Hold_for_CB_Notice_Disapprove_to_FTC  Scenario End ***************************##   
           

@TC0005_SLA_REN_Hold_for_CB_Notice_Approved_RefertoCounsel_Waiver_YES
Scenario: TC0005_SLA_REN_Hold_for_CB_Notice_Approved_RefertoCounsel_Waiver_YES
   	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC0005_SLA_REN_Hold_for_CB_Notice_Approved_RefertoCounsel_Waiver_YES Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0055_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice') {}
         * def waverStatus = true
          * def decisionType = 'Approved and Refer to Counsel’s Office'
           * def couseCheckboxChecked = false
         * call read('RenewalCommonMethods.feature@RenewalHoldForCBReview') {expStatus:'Approved'}
       
        
         * call read('LicensesCommonMethods.feature@GetLicenseId') {} 
	   	 And print licenseId
	   	 
	   	 * match licenseId != []
	   	 * match licenseId != null
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	 	* def letterStatus = 'Awaiting Review'
	 	* def wait = waitFunc(10)
		* call read('LicensesCommonMethods.feature@SearchAndValidateCounselAttorneyQueue') {}
	
	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC0005_SLA_REN_Hold_for_CB_Notice_Approved_RefertoCounsel_Waiver_YES  Scenario End ***************************##   
           

 
@TC0006_SLA_REN_Hold_for_CB_Notice_Approved_RefertoCounsel_Waiver_NO
Scenario: TC0006_SLA_REN_Hold_for_CB_Notice_Approved_RefertoCounsel_Waiver_NO
   	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC0006_SLA_REN_Hold_for_CB_Notice_Approved_RefertoCounsel_Waiver_NO Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0055_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice') {}
         * def waverStatus = false
          * def decisionType = 'Approved and Refer to Counsel’s Office'
           * def couseCheckboxChecked = false
         * call read('RenewalCommonMethods.feature@RenewalHoldForCBReview') {expStatus:'Approved'}
        * def licId = 
        
         * call read('LicensesCommonMethods.feature@GetLicenseId') {} 
	   	 And print licenseId
	   	 
	   	 * match licenseId != []
	   	 * match licenseId != null
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	 	* def letterStatus = 'Awaiting Review'
	 	* def wait = waitFunc(10)
		* call read('LicensesCommonMethods.feature@SearchAndValidateCounselAttorneyQueue') {}
	
	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC0006_SLA_REN_Hold_for_CB_Notice_Approved_RefertoCounsel_Waiver_NO  Scenario End ***************************##   
           
@TC0007_SLA_REN_Hold_for_CB_Notice_Review_Current_CBNotice_Date_greater_30_days
Scenario: TC0007_SLA_REN_Hold_for_CB_Notice_Review_Current_CBNotice_Date_greater_30_days
   	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC0007_SLA_REN_Hold_for_CB_Notice_Review_Current_CBNotice_Date_greater_30_days Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0055_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice') {}
        * def currentFormattedDate = dateFnc(32)
    	* def expiredFormattedDate = dateFnc(32)
	     
         * def waverStatus = false
          * def decisionType = 'Approved'
           * def couseCheckboxChecked = false
         * call read('RenewalCommonMethods.feature@RenewalHoldForCBReview') {expStatus:'Approved'}
        
        
         * call read('LicensesCommonMethods.feature@GetLicenseId') {} 
	   	 And print licenseId
	   	 
	   	 * match licenseId != []
	   	 * match licenseId != null
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	   	* def wait = waitFunc(70)
	    * call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'License_Cert'}
         * def emailBodyData = 'Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date.'
	  	* def subject = 'NYS Liquor Authority Licensing Bureau Record Information'
	  	* def typeOfNotification = 'Application Receipt'
	  	* call read('LicensesCommonMethods.feature@ValidateEmailCommunicationQueue'){}
	
	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC0007_SLA_REN_Hold_for_CB_Notice_Review_Current_CBNotice_Date_greater_30_days  Scenario End ***************************##   
    

  
@TC0008_SLA_REN_Hold_for_CB_Notice_Review_Current_CBNotice_Date_greater_30_days_safekeeping
Scenario: TC0008_SLA_REN_Hold_for_CB_Notice_Review_Current_CBNotice_Date_greater_30_days_safekeeping
   	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC0008_SLA_REN_Hold_for_CB_Notice_Review_Current_CBNotice_Date_greater_30_days_safekeeping Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0055_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice') {}
        * def currentFormattedDate = dateFnc(32)
    	* def expiredFormattedDate = dateFnc(32)
	     
         * def waverStatus = false
          * def decisionType = 'Approved'
           * def couseCheckboxChecked = false
           * def SafekeepingStatus = true
   		* def defineProvisions = 0
         * call read('RenewalCommonMethods.feature@RenewalHoldForCBReview') {expStatus:'Safekeeping'}
        
         * def SearchByLegalName = false
	   	* def SearchByLicId = true
	    
	   * call read('LicensesCommonMethods.feature@GetLicenseId') {} 
	   	 And print licenseId
	   
          * match licenseId != []
	   	 * match licenseId != null
	   	 * call read('LicensesCommonMethods.feature@SearchLicPermitIdForAmendment') {LicensePermitId:'#(licenseId)'}
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	   	* def wait = waitFunc(70)
	    * call read('LicensesCommonMethods.feature@ValidateNOAttachedDocument') {documentDesc:'License_Cert'}
         * def emailBodyData = 'Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date.'
	  	* def subject = 'NYS Liquor Authority Licensing Bureau Record Information'
	  	* def typeOfNotification = 'Application Receipt'
	  	* call read('LicensesCommonMethods.feature@ValidateEmailCommunicationQueue'){}
	
	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC0008_SLA_REN_Hold_for_CB_Notice_Review_Current_CBNotice_Date_greater_30_days_safekeeping  Scenario End ***************************##   
    

 	
@TC0009_SLA_REN_Hold_for_CB_Notice_Review_Current_CBNotice_Date_greater_30_days_Provision
Scenario: TC0009_SLA_REN_Hold_for_CB_Notice_Review_Current_CBNotice_Date_greater_30_days_Provision
   	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC0009_SLA_REN_Hold_for_CB_Notice_Review_Current_CBNotice_Date_greater_30_days_Provision Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0055_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice') {}
        * def currentFormattedDate = dateFnc(32)
    	* def expiredFormattedDate = dateFnc(32)
	     
         * def waverStatus = false
          * def decisionType = 'Approved'
           * def couseCheckboxChecked = false
           * def SafekeepingStatus = false
   		* def defineProvisions = true
         * call read('RenewalCommonMethods.feature@RenewalHoldForCBReview') {expStatus:'Approved'}
        
         * def SearchByLegalName = false
	   	* def SearchByLicId = true
	    
	   * call read('LicensesCommonMethods.feature@GetLicenseId') {} 
	   	 And print licenseId
	   
          * match licenseId != []
	   	 * match licenseId != null
	   	 * call read('LicensesCommonMethods.feature@SearchLicPermitIdForAmendment') {LicensePermitId:'#(licenseId)'}
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	   	* def wait = waitFunc(70)
	    * call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'License_Cert'}
         * def emailBodyData = 'Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date.'
	  	* def subject = 'NYS Liquor Authority Licensing Bureau Record Information'
	  	* def typeOfNotification = 'Application Receipt'
	  	* call read('LicensesCommonMethods.feature@ValidateEmailCommunicationQueue'){}
	
	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC0009_SLA_REN_Hold_for_CB_Notice_Review_Current_CBNotice_Date_greater_30_days_Provision  Scenario End ***************************##   
    

   
@TC010_SLA_REN_Hold_for_CB_Notice_Review_Current_CBNotice_Date_greater_30_days_safekeeping_provisions_defined
Scenario: TC010_SLA_REN_Hold_for_CB_Notice_Review_Current_CBNotice_Date_greater_30_days_safekeeping_provisions_defined
   	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC010_SLA_REN_Hold_for_CB_Notice_Review_Current_CBNotice_Date_greater_30_days_safekeeping_provisions_defined Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002_SLA_REN_Examiner_review_Digest_Approved_and_Hold_for_CB_notice') {}
         	
	   	 * def SafekeepingStatus = true
   		* def defineProvisions = true
   		* def licPerType = 'license'
	   	* call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproveAndHold_for_CBNotice') {expStatus:'Hold for CB Notice'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
	    * def currentFormattedDate = dateFnc(32)
    	* def expiredFormattedDate = dateFnc(32)
    	 * def waverStatus = false
          * def decisionType = 'Approved'
           * def couseCheckboxChecked = false
    	* call read('RenewalCommonMethods.feature@RenewalHoldForCBReview') {expStatus:'Approved'}
        
    	 * def SearchByLegalName = false
	   	* def SearchByLicId = true
	    
	   * call read('LicensesCommonMethods.feature@GetLicenseId') {} 
	   	 And print licenseId
	   
          * match licenseId != []
	   	 * match licenseId != null
	   	 * call read('LicensesCommonMethods.feature@SearchLicPermitIdForAmendment') {LicensePermitId:'#(licenseId)'}
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
	   	* def wait = waitFunc(70)
	    * call read('LicensesCommonMethods.feature@ValidateNOAttachedDocument') {documentDesc:'License_Cert'}
         * def emailBodyData = 'Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date.'
	  	* def subject = 'NYS Liquor Authority Licensing Bureau Record Information'
	  	* def typeOfNotification = 'Application Receipt'
	  	* call read('LicensesCommonMethods.feature@ValidateEmailCommunicationQueue'){}
	        
	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC010_SLA_REN_Hold_for_CB_Notice_Review_Current_CBNotice_Date_greater_30_days_safekeeping_provisions_defined  Scenario End ***************************##   
         
		       


  
@TC0011_SLA_REN_Hold_for_CB_Notice_Approved_Safekeeping_YES
Scenario: TC0011_SLA_REN_Hold_for_CB_Notice_Approved_Safekeeping_YES
   	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC0011_SLA_REN_Hold_for_CB_Notice_Approved_Safekeeping_YES Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0055_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice') {}
        
         * def waverStatus = true
          * def decisionType = 'Approved'
           * def couseCheckboxChecked = false
           * def SafekeepingStatus = true
   		* def defineProvisions = 0
         * call read('RenewalCommonMethods.feature@RenewalHoldForCBReview') {expStatus:'Safekeeping'}
        
         * def SearchByLegalName = false
	   	* def SearchByLicId = true
	    
	   * call read('LicensesCommonMethods.feature@GetLicenseId') {} 
	   	 And print licenseId
	   
          * match licenseId != []
	   	 * match licenseId != null
	   	 * call read('LicensesCommonMethods.feature@SearchLicPermitIdForAmendment') {LicensePermitId:'#(licenseId)'}
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	   	* def wait = waitFunc(10)
	    * call read('LicensesCommonMethods.feature@ValidateNOAttachedDocument') {documentDesc:'License_Cert'}
        
	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC0011_SLA_REN_Hold_for_CB_Notice_Approved_Safekeeping_YES  Scenario End ***************************##   
    

 	
@TC0012_SLA_REN_Hold_for_CB_Notice_Approved_Provision_YES
Scenario: TC0012_SLA_REN_Hold_for_CB_Notice_Approved_Provision_YES
   	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC0012_SLA_REN_Hold_for_CB_Notice_Approved_Provision_YES Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0055_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice') {}
         
         * def waverStatus = true
          * def decisionType = 'Approved'
           * def couseCheckboxChecked = false
           * def SafekeepingStatus = false
   		* def defineProvisions = true
         * call read('RenewalCommonMethods.feature@RenewalHoldForCBReview') {expStatus:'Approved'}



         * def SearchByLegalName = false
	   	* def SearchByLicId = true
	    
	   * call read('LicensesCommonMethods.feature@GetLicenseId') {} 
	   	 And print licenseId
	   
          * match licenseId != []
	   	 * match licenseId != null
	   	 * call read('LicensesCommonMethods.feature@SearchLicPermitIdForAmendment') {LicensePermitId:'#(licenseId)'}
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	   	* def wait = waitFunc(70)
	    * call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'License_Cert'}

	
	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC0012_SLA_REN_Hold_for_CB_Notice_Approved_Provision_YES  Scenario End ***************************##   
    

   
@TC0013_SLA_REN_Hold_for_CB_Notice_Approved_Safekeeping_Provision_YES
Scenario: TC0013_SLA_REN_Hold_for_CB_Notice_Approved_Safekeeping_Provision_YES
   	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC0013_SLA_REN_Hold_for_CB_Notice_Approved_Safekeeping_Provision_YES Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002_SLA_REN_Examiner_review_Digest_Approved_and_Hold_for_CB_notice') {}
         	
	   	 * def SafekeepingStatus = true
   		* def defineProvisions = true
   		* def licPerType = 'license'
	   	* call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproveAndHold_for_CBNotice') {expStatus:'Hold for CB Notice'}
	   
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
	    * def currentFormattedDate = dateFnc(32)
    	* def expiredFormattedDate = dateFnc(32)
    	 * def waverStatus = true
          * def decisionType = 'Approved'
           * def couseCheckboxChecked = false
    	* call read('RenewalCommonMethods.feature@RenewalHoldForCBReview') {expStatus:'Approved'}
        
    	 * def SearchByLegalName = false
	   	* def SearchByLicId = true
	    
	   * call read('LicensesCommonMethods.feature@GetLicenseId') {} 
	   	 And print licenseId
	   
          * match licenseId != []
	   	 * match licenseId != null
	   	 * call read('LicensesCommonMethods.feature@SearchLicPermitIdForAmendment') {LicensePermitId:'#(licenseId)'}
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
	   	* def wait = waitFunc(70)
	    * call read('LicensesCommonMethods.feature@ValidateNOAttachedDocument') {documentDesc:'License_Cert'}
       
	        
	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC0013_SLA_REN_Hold_for_CB_Notice_Approved_Safekeeping_Provision_YES  Scenario End ***************************##   
         
         
         

@TC0014_SLA_REN_Hold_for_CB_Notice_Approved_Safekeeping_RefertoCounsel_YES
Scenario: TC0014_SLA_REN_Hold_for_CB_Notice_Approved_Safekeeping_RefertoCounsel_YES
   	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC0014_SLA_REN_Hold_for_CB_Notice_Approved_Safekeeping_RefertoCounsel_YES Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002_SLA_REN_Examiner_review_Digest_Approved_and_Hold_for_CB_notice') {}
         	
	   	 * def SafekeepingStatus = true
   		* def defineProvisions = false
   		* def licPerType = 'license'
	   	* call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproveAndHold_for_CBNotice') {expStatus:'Hold for CB Notice'}
	   * def waverStatus = true
          * def decisionType = 'Approved and Refer to Counsel’s Office'
           * def couseCheckboxChecked = false
         * call read('RenewalCommonMethods.feature@RenewalHoldForCBReview') {expStatus:'Safekeeping'}
        * def SearchByLegalName = false
	   	* def SearchByLicId = true
		* call read('LicensesCommonMethods.feature@GetLicenseId') {} 
	   	 And print licenseId
	   
          * match licenseId != []
	   	 * match licenseId != null
	   	 * call read('LicensesCommonMethods.feature@SearchLicPermitIdForAmendment') {LicensePermitId:'#(licenseId)'}
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
	   	* def wait = waitFunc(70)
	    * call read('LicensesCommonMethods.feature@ValidateNOAttachedDocument') {documentDesc:'License_Cert'}
        * def letterStatus = 'Awaiting Review'
	 	* call read('LicensesCommonMethods.feature@SearchAndValidateCounselAttorneyQueue') {}
	
	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC0014_SLA_REN_Hold_for_CB_Notice_Approved_Safekeeping_RefertoCounsel_YES  Scenario End ***************************##   
          
			
			
@TC0015_SLA_REN_Hold_for_CB_Notice_Approved_Provision_RefertoCounsel_YES
Scenario: TC0015_SLA_REN_Hold_for_CB_Notice_Approved_Provision_RefertoCounsel_YES
   	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC0015_SLA_REN_Hold_for_CB_Notice_Approved_Provision_RefertoCounsel_YES Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002_SLA_REN_Examiner_review_Digest_Approved_and_Hold_for_CB_notice') {}
         	
	   	 * def SafekeepingStatus = false
   		* def defineProvisions = true
   		* def licPerType = 'license'
	   	* call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproveAndHold_for_CBNotice') {expStatus:'Hold for CB Notice'}
	   * def waverStatus = true
          * def decisionType = 'Approved and Refer to Counsel’s Office'
           * def couseCheckboxChecked = false
         * call read('RenewalCommonMethods.feature@RenewalHoldForCBReview') {expStatus:'Approved'}
        * def SearchByLegalName = false
	   	* def SearchByLicId = true
		* call read('LicensesCommonMethods.feature@GetLicenseId') {} 
	   	 And print licenseId
	   
          * match licenseId != []
	   	 * match licenseId != null
	   	 * call read('LicensesCommonMethods.feature@SearchLicPermitIdForAmendment') {LicensePermitId:'#(licenseId)'}
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
	   	* def wait = waitFunc(70)
	    * call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'License_Cert'}
       * def emailBodyData = 'Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date.'
	  	* def subject = 'NYS Liquor Authority Licensing Bureau Record Information'
	  	* def typeOfNotification = 'Application Receipt'
	  	* call read('LicensesCommonMethods.feature@ValidateEmailCommunicationQueue'){}
        * def letterStatus = 'Awaiting Review'
	 	* call read('LicensesCommonMethods.feature@SearchAndValidateCounselAttorneyQueue') {}
	
	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC0015_SLA_REN_Hold_for_CB_Notice_Approved_Provision_RefertoCounsel_YES  Scenario End ***************************##   
          
	     

@TC0016_SLA_REN_Hold_for_CB_Notice_Approved_Safekeeping_Provision_RefertoCounsel_YES
Scenario: TC0016_SLA_REN_Hold_for_CB_Notice_Approved_Safekeeping_Provision_RefertoCounsel_YES
   	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC0016_SLA_REN_Hold_for_CB_Notice_Approved_Safekeeping_Provision_RefertoCounsel_YES Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0002_SLA_REN_Examiner_review_Digest_Approved_and_Hold_for_CB_notice') {}
         	
	   	 * def SafekeepingStatus = true
   		* def defineProvisions = true
   		* def licPerType = 'license'
	   	* call read('RenewalCommonMethods.feature@RenewalPermitExaminerReviewApproveAndHold_for_CBNotice') {expStatus:'Hold for CB Notice'}
	   * def waverStatus = true
          * def decisionType = 'Approved and Refer to Counsel’s Office'
           * def couseCheckboxChecked = false
         * call read('RenewalCommonMethods.feature@RenewalHoldForCBReview') {expStatus:'Approved'}
        * def SearchByLegalName = false
	   	* def SearchByLicId = true
		* call read('LicensesCommonMethods.feature@GetLicenseId') {} 
	   	 And print licenseId
	   
          * match licenseId != []
	   	 * match licenseId != null
	   	 * call read('LicensesCommonMethods.feature@SearchLicPermitIdForAmendment') {LicensePermitId:'#(licenseId)'}
	    * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Safekeeping'}
	   	* def wait = waitFunc(70)
	    * call read('LicensesCommonMethods.feature@ValidateNOAttachedDocument') {documentDesc:'License_Cert'}
        * def emailBodyData = 'Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date.'
	  	* def subject = 'NYS Liquor Authority Licensing Bureau Record Information'
	  	* def typeOfNotification = 'Application Receipt'
	  	* call read('LicensesCommonMethods.feature@ValidateEmailCommunicationQueue'){}
        * def letterStatus = 'Awaiting Review'
	 	* call read('LicensesCommonMethods.feature@SearchAndValidateCounselAttorneyQueue') {}
	
	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC0016_SLA_REN_Hold_for_CB_Notice_Approved_Safekeeping_Provision_RefertoCounsel_YES  Scenario End ***************************##   
         
         
         
     

@TC0019_SLA_REN_Hold_for_CB_Notice_Disapproved_Download_letter_Cause
Scenario: TC0019_SLA_REN_Hold_for_CB_Notice_Disapproved_Download_letter_Cause
   	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC0019_SLA_REN_Hold_for_CB_Notice_Disapproved_Download_letter_Cause Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0055_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice') {}
         * def waverStatus = false
          * def decisionType = 'Disapproved'
           * def couseCheckboxChecked = true
         * call read('RenewalCommonMethods.feature@RenewalHoldForCBReview') {expStatus:'Disapproved'}
        * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
        * def wait = waitFunc(50)
         * def emailBodyData = 'Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date.'
	  	* def subject = 'NYS Liquor Authority Licensing Bureau Record Information'
	  	* def typeOfNotification = 'Application Receipt'
	  	* call read('LicensesCommonMethods.feature@ValidateEmailCommunicationQueue'){}
         
	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC0019_SLA_REN_Hold_for_CB_Notice_Disapproved_Download_letter_Cause  Scenario End ***************************##   
         	         
         	         
         	         
         	         


@TC0019a_SLA_REN_Hold_for_CB_Notice_Disapproved_Download_letter_FTC
Scenario: TC0019a_SLA_REN_Hold_for_CB_Notice_Disapproved_Download_letter_FTC
   	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC0019a_SLA_REN_Hold_for_CB_Notice_Disapproved_Download_letter_FTC Scenario Start ***************************##
	   	* call read('Uc_RenewalExaminerReview.feature@TC0055_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice') {}
         * def waverStatus = false
          * def decisionType = 'Disapproved'
           * def couseCheckboxChecked = false
         * call read('RenewalCommonMethods.feature@RenewalHoldForCBReview') {expStatus:'Disapproved'}
        * call read('RenewalCommonMethods.feature@ValidateLicenseStatusOnSearchPage') {licenseStatus:'Active'}
        * def wait = waitFunc(50)
         * def emailBodyData = 'Please carefully review this correspondence to see what action, if any, is required on your behalf.  In the event a response is required, you must respond on or before the stated due date.'
	  	* def subject = 'NYS Liquor Authority Licensing Bureau Record Information'
	  	* def typeOfNotification = 'Application Receipt'
	  	* call read('LicensesCommonMethods.feature@ValidateEmailCommunicationQueue'){}
         
	## ******************** UC_REN_Hold_for_CB_Notice: Validate TC0019a_SLA_REN_Hold_for_CB_Notice_Disapproved_Download_letter_FTC  Scenario End ***************************##   
         	         			 		         	         			 					 	  	 	  
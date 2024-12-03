Feature: DCOL to Grant Recon
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
		

	* def dateWithMonthsNameFnc =
		"""
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("MMM dd, yyyy");
		     var date = new java.util.Date();
		     var dayAfter = new java.util.Date( date.getTime());
		    return sdf.format(dayAfter);
		  } """
		* def dateWithMonthsName = dateWithMonthsNameFnc()
		
		
@TC001_SLA_RCN_Review_Recon_request_DCOL_Grant_Cause_main_License	  
Scenario: TC001_SLA_RCN_Review_Recon_request_DCOL_Grant_Cause_main_License
   ## ******************** Uc_ReconReviewByExaminer: Validate TC001_SLA_RCN_Review_Recon_request_DCOL_Grant_Cause_main_License Scenario Start ***************************##
	   	* call read('Uc_ReconReviewByLB.feature@TC0023_SLA_RCN_Review_Recon_request_LB_Recon_Cause_to_Deputy_Commissioner_main_License') {}
       	* def DisapproveForCause = true
        * def Comments = 'Main Lic -Automation DCOL to Grant Recon'
        * def DeterminationValue = 1
        * def reconType = 'CAUSE'
        * def TaskId = 3525 
	    * call read('ReconCommonMethods.feature@SubmitDCOLRecon') {expStatus:'Recon Granted'}
	    * def wait = waitFunc(40)
    	* call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'Recond_Granted'}
	   
	    
	## ******************** Uc_ReconReviewByExaminer: Validate TC001_SLA_RCN_Review_Recon_request_DCOL_Grant_Cause_main_License  Scenario End ***************************##   
	     
	     
@TC0002_SLA_RCN_Review_Recon_request_DCOL_Grant_Cause_Associated_Permit	  
Scenario: TC0002_SLA_RCN_Review_Recon_request_DCOL_Grant_Cause_Associated_Permit
   ## ******************** Uc_ReconReviewByExaminer: Validate TC0002_SLA_RCN_Review_Recon_request_DCOL_Grant_Cause_Associated_Permit Scenario Start ***************************##
	   	* call read('Uc_ReconReviewByLB.feature@TC0024_SLA_RCN_Review_Recon_request_LB_Recon_Cause_to_Deputy_Commissioner_main_License_with_Associated_Permit') {}
       	* def DisapproveForCause = true
        * def Comments = 'Associated  Lic-permit -Automation DCOL to Grant Recon'
        * def DeterminationValue = 1
        * def reconType = 'CAUSE'
        * def TaskId = 3525 
	    * call read('ReconCommonMethods.feature@SubmitDCOLRecon') {expStatus:'Recon Granted'}
	    * def wait = waitFunc(40)
    	* call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'Recond_Granted'}
	   
	    
	## ******************** Uc_ReconReviewByExaminer: Validate TC0002_SLA_RCN_Review_Recon_request_DCOL_Grant_Cause_Associated_Permit  Scenario End ***************************##   
	
	
@TC0004_SLA_RCN_Review_Recon_request_DCOL_Grant_Cause_Standalone_Permit	  
Scenario: TC0004_SLA_RCN_Review_Recon_request_DCOL_Grant_Cause_Standalone_Permit
   ## ******************** Uc_ReconReviewByExaminer: Validate TC0004_SLA_RCN_Review_Recon_request_DCOL_Grant_Cause_Standalone_Permit Scenario Start ***************************##
	   	* call read('Uc_ReconReviewByLB.feature@TC0025_SLA_RCN_Review_Recon_request_LB_Recon_Cause_to_Deputy_Commissioner_Standalone_permit') {}
       	* def DisapproveForCause = true
        * def Comments = 'StandAlone Lic-permit -Automation DCOL to Grant Recon'
        * def DeterminationValue = 1
        * def reconType = 'CAUSE'
        * def TaskId = 3525 
	    * call read('ReconCommonMethods.feature@SubmitDCOLRecon') {expStatus:'Recon Granted'}
	    * def wait = waitFunc(40)
    	* call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'Recond_Granted'}
	   
	    
	## ******************** Uc_ReconReviewByExaminer: Validate TC0004_SLA_RCN_Review_Recon_request_DCOL_Grant_Cause_Standalone_Permit  Scenario End ***************************##   
	

@TC0005_SLA_RCN_Review_Recon_request_DCOL_Grant_Cause_Temp_Permit	  
Scenario: TC0005_SLA_RCN_Review_Recon_request_DCOL_Grant_Cause_Temp_Permit
   ## ******************** Uc_ReconReviewByExaminer: Validate TC0005_SLA_RCN_Review_Recon_request_DCOL_Grant_Cause_Temp_Permit Scenario Start ***************************##
	   	* call read('Uc_ReconReviewByLB.feature@TC0026_SLA_RCN_Review_Recon_Request_LB_Recon_Cause_to_Deputy_Commissioner_TempPermit') {}
       	* def DisapproveForCause = true
        * def Comments = 'Temp Lic-permit -Automation DCOL to Grant Recon'
        * def DeterminationValue = 1
        * def reconType = 'CAUSE'
        * def TaskId = 3525 
	    * call read('ReconCommonMethods.feature@SubmitDCOLRecon') {expStatus:'Recon Granted'}
	    * def wait = waitFunc(40)
    	* call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'Recond_Granted'}
	   
	    
	## ******************** Uc_ReconReviewByExaminer: Validate TC0005_SLA_RCN_Review_Recon_request_DCOL_Grant_Cause_Temp_Permit  Scenario End ***************************##   
	
	
@TC008_SLA_RCN_Review_Recon_request_DCOL_Grant_FTC_main_License	  
Scenario: TC008_SLA_RCN_Review_Recon_request_DCOL_Grant_FTC_main_License
   ## ******************** Uc_ReconReviewByExaminer: Validate TC008_SLA_RCN_Review_Recon_request_DCOL_Grant_FTC_main_License Scenario Start ***************************##
	   	* call read('Uc_ReconReviewByLB.feature@TC0028_SLA_RCN_Review_Recon_request_LB_Recon_Deny_FTC_main_License') {}
       	* def DisapproveForCause = false
        * def Comments = 'FTC Main Lic -Automation DCOL to Grant Recon'
        * def DeterminationValue = 1
        * def reconType = 'FTC'
        * def TaskId = 3518 
	    * call read('ReconCommonMethods.feature@SubmitDCOLRecon') {expStatus:'Recon Granted'}
	    * def wait = waitFunc(40)
    	* call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'Recond_Granted'}
	   
	    
	## ******************** Uc_ReconReviewByExaminer: Validate TC008_SLA_RCN_Review_Recon_request_DCOL_Grant_FTC_main_License  Scenario End ***************************##   
	     
@TC009_SLA_RCN_Review_Recon_request_DCOL_Grant_FTC_main_License_AssociatedPermit	  
Scenario: TC009_SLA_RCN_Review_Recon_request_DCOL_Grant_FTC_main_License_AssociatedPermit
   ## ******************** Uc_ReconReviewByExaminer: Validate TC009_SLA_RCN_Review_Recon_request_DCOL_Grant_FTC_main_License_AssociatedPermit Scenario Start ***************************##
	   	* call read('Uc_ReconReviewByLB.feature@TC0029_SLA_RCN_Review_Recon_request_LB_Recon_Deny_Associated_Permit') {}
       	* def DisapproveForCause = false
        * def Comments = 'FTC Main Lic with Associated Permit -Automation DCOL to Grant Recon'
        * def DeterminationValue = 1
        * def reconType = 'FTC'
        * def TaskId = 3518 
	    * call read('ReconCommonMethods.feature@SubmitDCOLRecon') {expStatus:'Recon Granted'}
	    * def wait = waitFunc(40)
    	* call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'Recond_Granted'}
	   
	    
	## ******************** Uc_ReconReviewByExaminer: Validate TC009_SLA_RCN_Review_Recon_request_DCOL_Grant_FTC_main_License_AssociatedPermit  Scenario End ***************************##   
	        	     	
@TC011_SLA_RCN_Review_Recon_request_DCOL_Grant_FTC_StandalonePermit	  
Scenario: TC011_SLA_RCN_Review_Recon_request_DCOL_Grant_FTC_StandalonePermit
   ## ******************** Uc_ReconReviewByExaminer: Validate TC011_SLA_RCN_Review_Recon_request_DCOL_Grant_FTC_StandalonePermit Scenario Start ***************************##
	   	* call read('Uc_ReconReviewByLB.feature@TC0027_SLA_RCN_Review_Recon_request_LB_Deny_FTC_Standalone_permit') {}
       	* def DisapproveForCause = false
        * def Comments = 'FTC Standalone Permit -Automation DCOL to Grant Recon'
        * def DeterminationValue = 1
        * def reconType = 'FTC'
        * def TaskId = 3518 
	    * call read('ReconCommonMethods.feature@SubmitDCOLRecon') {expStatus:'Recon Granted'}
	    * def wait = waitFunc(40)
    	* call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'Recond_Granted'}
	   
	    
	## ******************** Uc_ReconReviewByExaminer: Validate TC011_SLA_RCN_Review_Recon_request_DCOL_Grant_FTC_StandalonePermit Scenario End ***************************##   
	        	     	
	        	     	
@TC012_SLA_RCN_Review_Recon_request_DCOL_Grant_FTC_Temp_Permit	  
Scenario: TC012_SLA_RCN_Review_Recon_request_DCOL_Grant_FTC_Temp_Permit
   ## ******************** Uc_ReconReviewByExaminer: Validate TC012_SLA_RCN_Review_Recon_request_DCOL_Grant_FTC_Temp_Permit Scenario Start ***************************##
	   	* call read('Uc_ReconReviewByLB.feature@TC0030_SLA_RCN_Review_Recon_Request_LB_Deny_FTC_temp_permit') {}
       	* def DisapproveForCause = false
        * def Comments = 'FTC Temp Permit - Automation DCOL to Grant Recon'
        * def DeterminationValue = 1
        * def reconType = 'FTC'
        * def TaskId = 3518 
	    * call read('ReconCommonMethods.feature@SubmitDCOLRecon') {expStatus:'Recon Granted'}
	    * def wait = waitFunc(40)
    	* call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'Recond_Granted'}
	   
	    
	## ******************** Uc_ReconReviewByExaminer: Validate TC012_SLA_RCN_Review_Recon_request_DCOL_Grant_FTC_Temp_Permit Scenario End ***************************##   
	        	     	

@TC015_SLA_RCN_Review_Recon_request_DCOL_Grant_Cause_main_License	  
Scenario: TC015_SLA_RCN_Review_Recon_request_DCOL_Grant_Cause_main_License
   ## ******************** Uc_ReconReviewByExaminer: Validate TC015_SLA_RCN_Review_Recon_request_DCOL_Grant_Cause_main_License Scenario Start ***************************##
	   	* call read('Uc_ReconReviewByLB.feature@TC0023_SLA_RCN_Review_Recon_request_LB_Recon_Cause_to_Deputy_Commissioner_main_License') {}
       	* def DisapproveForCause = true
        * def Comments = 'Main Lic -Automation DCOL to Counsel Office'
        * def DeterminationValue = 2
        * def reconType = 'CAUSE'
        * def TaskId = 3525 
	    * call read('ReconCommonMethods.feature@SubmitDCOLRecon') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@SearchAndValidateCounselQueueApplicationStatus') {letterStatus:'Awaiting Review'}
	    
	    
	## ******************** Uc_ReconReviewByExaminer: Validate TC015_SLA_RCN_Review_Recon_request_DCOL_Grant_Cause_main_License  Scenario End ***************************##   
	     
	     
@TC0016_SLA_RCN_Review_Recon_request_DCOL_Grant_Cause_Associated_Permit	  
Scenario: TC0016_SLA_RCN_Review_Recon_request_DCOL_Grant_Cause_Associated_Permit
   ## ******************** Uc_ReconReviewByExaminer: Validate TC0016_SLA_RCN_Review_Recon_request_DCOL_Grant_Cause_Associated_Permit Scenario Start ***************************##
	   	* call read('Uc_ReconReviewByLB.feature@TC0024_SLA_RCN_Review_Recon_request_LB_Recon_Cause_to_Deputy_Commissioner_main_License_with_Associated_Permit') {}
       	* def DisapproveForCause = true
        * def Comments = 'Associated  Lic-permit -Automation DCOL to Counsel Office'
        * def DeterminationValue = 2
        * def reconType = 'CAUSE'
        * def TaskId = 3525 
	    * call read('ReconCommonMethods.feature@SubmitDCOLRecon') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@SearchAndValidateCounselQueueApplicationStatus') {letterStatus:'Awaiting Review'}
	    
	    
	    
	## ******************** Uc_ReconReviewByExaminer: Validate TC0016_SLA_RCN_Review_Recon_request_DCOL_Grant_Cause_Associated_Permit  Scenario End ***************************##   
	
	
@TC018_SLA_RCN_Review_Recon_request_DCOL_Grant_Cause_Standalone_Permit	  
Scenario: TC018_SLA_RCN_Review_Recon_request_DCOL_Grant_Cause_Standalone_Permit
   ## ******************** Uc_ReconReviewByExaminer: Validate TC018_SLA_RCN_Review_Recon_request_DCOL_Grant_Cause_Standalone_Permit Scenario Start ***************************##
	   	* call read('Uc_ReconReviewByLB.feature@TC0025_SLA_RCN_Review_Recon_request_LB_Recon_Cause_to_Deputy_Commissioner_Standalone_permit') {}
       	* def DisapproveForCause = true
        * def Comments = 'StandAlone Lic-permit -Automation DCOL to Counsel Office'
        * def DeterminationValue = 2
        * def reconType = 'CAUSE'
        * def TaskId = 3525 
	   * call read('ReconCommonMethods.feature@SubmitDCOLRecon') {expStatus:'Awaiting Review'}
	     * call read('LicensesCommonMethods.feature@SearchAndValidateCounselQueueApplicationStatus') {letterStatus:'Awaiting Review'}
	    
	    
	## ******************** Uc_ReconReviewByExaminer: Validate TC018_SLA_RCN_Review_Recon_request_DCOL_Grant_Cause_Standalone_Permit  Scenario End ***************************##   
	

@TC019_SLA_RCN_Review_Recon_request_DCOL_Grant_Cause_Temp_Permit	  
Scenario: TC019_SLA_RCN_Review_Recon_request_DCOL_Grant_Cause_Temp_Permit
   ## ******************** Uc_ReconReviewByExaminer: Validate TC019_SLA_RCN_Review_Recon_request_DCOL_Grant_Cause_Temp_Permit Scenario Start ***************************##
	   	* call read('Uc_ReconReviewByLB.feature@TC0026_SLA_RCN_Review_Recon_Request_LB_Recon_Cause_to_Deputy_Commissioner_TempPermit') {}
       	* def DisapproveForCause = true
        * def Comments = 'Temp Lic-permit -Automation DCOL to Counsel Office'
      * def DeterminationValue = 2
        * def reconType = 'CAUSE'
        * def TaskId = 3525 
	   * call read('ReconCommonMethods.feature@SubmitDCOLRecon') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@SearchAndValidateCounselQueueApplicationStatus') {letterStatus:'Awaiting Review'}
	    
	    
	## ******************** Uc_ReconReviewByExaminer: Validate TC019_SLA_RCN_Review_Recon_request_DCOL_Grant_Cause_Temp_Permit  Scenario End ***************************##   
	
	

@TC020_SLA_RCN_Review_Recon_request_DCOL_Deny_FTC_main_License	  
Scenario: TC020_SLA_RCN_Review_Recon_request_DCOL_Deny_FTC_main_License
   ## ******************** Uc_ReconReviewByExaminer: Validate TC020_SLA_RCN_Review_Recon_request_DCOL_Deny_FTC_main_License Scenario Start ***************************##
	   	* call read('Uc_ReconReviewByLB.feature@TC0028_SLA_RCN_Review_Recon_request_LB_Recon_Deny_FTC_main_License') {}
       	* def DisapproveForCause = false
        * def Comments = 'FTC Main Lic -Automation DCOL to Reconsideration Denied'
        * def DeterminationValue = 2
        * def reconType = 'FTC'
        * def TaskId = 3518 
	    * call read('ReconCommonMethods.feature@SubmitDCOLRecon') {expStatus:'Disapproved'}
	    * def wait = waitFunc(40)
    	* call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'Disapproval Letter'}
	   
	    
	## ******************** Uc_ReconReviewByExaminer: Validate TC020_SLA_RCN_Review_Recon_request_DCOL_Deny_FTC_main_License  Scenario End ***************************##   
	
	
     
@TC0021_SLA_RCN_Review_Recon_request_DCOL_Deny_FTC_AssociatedPermit	  
Scenario: TC0021_SLA_RCN_Review_Recon_request_DCOL_Deny_FTC_AssociatedPermit
   ## ******************** Uc_ReconReviewByExaminer: Validate TC0021_SLA_RCN_Review_Recon_request_DCOL_Deny_FTC_AssociatedPermit Scenario Start ***************************##
	   	* call read('Uc_ReconReviewByLB.feature@TC0029_SLA_RCN_Review_Recon_request_LB_Recon_Deny_Associated_Permit') {}
       	* def DisapproveForCause = false
        * def Comments = 'FTC Main Lic with Associated Permit -Automation DCOL to Reconsideration Denied'
        * def DeterminationValue = 2
        * def reconType = 'FTC'
        * def TaskId = 3518 
	    * call read('ReconCommonMethods.feature@SubmitDCOLRecon') {expStatus:'Disapproved'}
	    * def wait = waitFunc(40)
    	* call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'Recon_Denied_FTC_Deficient'}
	   
	    
	## ******************** Uc_ReconReviewByExaminer: Validate TC0021_SLA_RCN_Review_Recon_request_DCOL_Deny_FTC_AssociatedPermit  Scenario End ***************************##   
	    
	      	     	
@TC023_SLA_RCN_Review_Recon_request_DCOL_Deny_FTC_StandalonePermit	  
Scenario: TC023_SLA_RCN_Review_Recon_request_DCOL_Deny_FTC_StandalonePermit
   ## ******************** Uc_ReconReviewByExaminer: Validate TC023_SLA_RCN_Review_Recon_request_DCOL_Deny_FTC_StandalonePermit Scenario Start ***************************##
	   	* call read('Uc_ReconReviewByLB.feature@TC0027_SLA_RCN_Review_Recon_request_LB_Deny_FTC_Standalone_permit') {}
       	* def DisapproveForCause = false
        * def Comments = 'FTC Standalone Permit -Automation DCOL to Reconsideration Denied'
        * def DeterminationValue = 2
        * def reconType = 'FTC'
        * def TaskId = 3518 
	    * call read('ReconCommonMethods.feature@SubmitDCOLRecon') {expStatus:'Disapproved'}
	    * def wait = waitFunc(40)
    	* call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'Recon_Denied_FTC_Deficient'}
	   
	    
	## ******************** Uc_ReconReviewByExaminer: Validate TC023_SLA_RCN_Review_Recon_request_DCOL_Deny_FTC_StandalonePermit Scenario End ***************************##   
	        	     	
	        	     	
@TC024_SLA_RCN_Review_Recon_request_DCOL_Deny_FTC_Temp_Permit	  
Scenario: TC024_SLA_RCN_Review_Recon_request_DCOL_Deny_FTC_Temp_Permit
   ## ******************** Uc_ReconReviewByExaminer: Validate TC024_SLA_RCN_Review_Recon_request_DCOL_Deny_FTC_Temp_Permit Scenario Start ***************************##
	   	* call read('Uc_ReconReviewByLB.feature@TC0030_SLA_RCN_Review_Recon_Request_LB_Deny_FTC_temp_permit') {}
       	* def DisapproveForCause = false
        
        * def Comments = 'FTC Temp Permit -Automation DCOL to Reconsideration Denied'
        * def DeterminationValue = 2
        * def reconType = 'FTC'
        * def TaskId = 3518 
	    * call read('ReconCommonMethods.feature@SubmitDCOLRecon') {expStatus:'Disapproved'}
	    * def wait = waitFunc(40)
    	* call read('LicensesCommonMethods.feature@ValidateAttachedDocument') {documentDesc:'Recon_Denied_FTC_Deficient'}
	   
	    
	    
	## ******************** Uc_ReconReviewByExaminer: Validate TC024_SLA_RCN_Review_Recon_request_DCOL_Deny_FTC_Temp_Permit Scenario End ***************************##   
	  		      	     	     	     
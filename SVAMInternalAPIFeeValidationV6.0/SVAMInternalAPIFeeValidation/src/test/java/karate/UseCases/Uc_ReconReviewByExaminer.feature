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
		  
@TC0001_SLA_RCN_Review_Recon_request_Examiner_Grant	  
Scenario: TC0001_SLA_RCN_Review_Recon_request_Examiner_Grant
   
	
	   ## ******************** Uc_ReconReviewByExaminer: Validate TC0001_SLA_RCN_Review_Recon_request_Examiner_Grant Scenario Start ***************************##
	   	* call read('Uc_ReconProcessByClerical.feature@TC0001_SLA_RCN_Process_Recon_request_clerical_failure_to_Comply') {}
        * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {}
        * def Comments = 'Comply Grant Recon Automation'
        * def DeterminationValue = 2
	    * call read('ReconCommonMethods.feature@SubmitReconExaminerQueue') {expStatus:'FTC, Recommend to Grant'}
	    
    
	   ## ******************** Uc_ReconReviewByExaminer: Validate TC0001_SLA_RCN_Review_Recon_request_Examiner_Grant  Scenario End ***************************##   
	
	
@TC0001a_SLA_RCN_Review_Recon_request_Examiner_Grant	  
Scenario: TC0001a_SLA_RCN_Review_Recon_request_Examiner_Grant
   
	
	   ## ******************** Uc_ReconReviewByExaminer: Validate TC0001_SLA_RCN_Review_Recon_request_Examiner_Grant Scenario Start ***************************##
	   	* call read('Uc_ReconProcessByClerical.feature@TC0002_SLA_RCN_Process_Recon_request_Clerical_disapproved_for_Cause') {}
         * def DeterminationValue = 2
    	* def Comments = 'Cause Grant Reconsideration Automation'
       
	    #* call read('ReconCommonMethods.feature@SubmitReconExaminerQueue') {expStatus:'Reconsideration Review'}
	    
	   ## ******************** Uc_ReconReviewByExaminer: Validate TC0001_SLA_RCN_Review_Recon_request_Examiner_Grant  Scenario End ***************************##   
	
	
			  
@TC0002_SLA_RCN_Review_Recon_request_Examiner_Deny	  
Scenario: TC0002_SLA_RCN_Review_Recon_request_Examiner_Deny
   
	
	   ## ******************** Uc_ReconReviewByExaminer: Validate TC0002_SLA_RCN_Review_Recon_request_Examiner_Deny Scenario Start ***************************##
	   	* call read('Uc_ReconProcessByClerical.feature@TC0001_SLA_RCN_Process_Recon_request_clerical_failure_to_Comply') {}
        * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {}
        * def Comments = 'Comply Deny Reconsideration Automation'
        * def DeterminationValue = 1
	    * call read('ReconCommonMethods.feature@SubmitReconExaminerQueue') {expStatus:'FTC, Recommend Denial'}
	    
    
	   ## ******************** Uc_ReconReviewByExaminer: Validate TC0002_SLA_RCN_Review_Recon_request_Examiner_Deny  Scenario End ***************************##   
	
	
	



       	 			 	  	 	  
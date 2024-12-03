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
         
@TC0001_Lead_Investigator_Reviews_Request_to_serve_Subpoena    	
Scenario: TC0001_Supervisor_Reviews_Request_to_serve_Subpoena
   
	# ********* Login Functionality *********************
  		* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
  	* callonce read('CounselCommonMethods.feature@HearingCreateLic') {}	
  	* def SearchByLegalName = false
  	* def licKeywordName = 'Automation'
  	* def suspensionStatus = true
	* call read('HearingCommonMethods.feature@AddReferralForm') {}
    * callonce read('CounselCommonMethods.feature@ClaimCreatedCase') {}
    * callonce read('CounselCommonMethods.feature@AssignCaseToAttorney') {}	
	* call read('CounselCommonMethods.feature@PrepareNOP1') {}
    * call read('CounselCommonMethods.feature@NOPProcessingCompleteFlow') {}
    * call read('CounselCommonMethods.feature@AttachCertifiedMailReceipt') {}
	* call read('CounselCommonMethods.feature@SaveContactsDetails') {}
	* call read('CounselCommonMethods.feature@SaveWitnessDetails') {}
	* def letterTemplateId = "347"
	* call read('CounselCommonMethods.feature@ServeSubpoena') {}
	* call read('EnforcementCommonMethods.feature@EnforcementAssignmentSearch') {}
	  And match applicationStatus == 'Awaiting Review'
	* def taskId = 6201
    * call read('EnforcementCommonMethods.feature@SupervisorAssignInvestigatorForAssignment') {}
    * call read('EnforcementCommonMethods.feature@LeadInvestigatorServeSubpoena') {}
      And match applicationStatus == 'Investigation In Process'
    
@TC0002_Supervisor_Reviews_Request_to_serve_Subpoena    	
Scenario: TC0002_Supervisor_Reviews_Request_to_serve_Subpoena
   
	# ********* Login Functionality *********************
  		* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
  	* callonce read('CounselCommonMethods.feature@HearingCreateLic') {}	
  	* def SearchByLegalName = false
  	* def licKeywordName = 'Automation'
  	* def suspensionStatus = true
	* call read('HearingCommonMethods.feature@AddReferralForm') {}
    * callonce read('CounselCommonMethods.feature@ClaimCreatedCase') {}
    * callonce read('CounselCommonMethods.feature@AssignCaseToAttorney') {}	
	* call read('CounselCommonMethods.feature@PrepareNOP1') {}
    * call read('CounselCommonMethods.feature@NOPProcessingCompleteFlow') {}
    * call read('CounselCommonMethods.feature@AttachCertifiedMailReceipt') {}
	* call read('CounselCommonMethods.feature@SaveContactsDetails') {}
	* call read('CounselCommonMethods.feature@SaveWitnessDetails') {}
	* def letterTemplateId = "347"
	* call read('CounselCommonMethods.feature@ServeSubpoena') {}
	* call read('EnforcementCommonMethods.feature@EnforcementAssignmentSearch') {}
	  And match applicationStatus == 'Awaiting Review'
	* def taskId = 6201
   # * call read('EnforcementCommonMethods.feature@SupervisorAssignInvestigatorForAssignment') {}
 #   * call read('EnforcementCommonMethods.feature@InFromCounselQueue') {}
	#And match response.total == 0
	
	        	            	       	            	     	            	       	            
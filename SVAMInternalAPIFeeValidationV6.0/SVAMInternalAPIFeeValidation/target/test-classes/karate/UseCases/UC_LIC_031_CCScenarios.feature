Feature: FBPT review
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


 @TC0001_NYC_SLA_LIC_Associate_Combined_Craft	  
 Scenario: TC0001_NYC_SLA_LIC_Associate_Combined_Craft
   
	# ********* Login Functionality *********************
  		* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
  		
	## ******************** UC_LIC_031_CCLicense: Validate TC0001_NYC_SLA_LIC_Associate_Combined_Craft Scenario Start ***************************##
	    
	    
	    * call read('LicensesCommonMethods.feature@IntakeCCApplication') {}
	    * call read('LicensesCommonMethods.feature@checkApplicationStatus') {expStatus:'Draft'}
	    * call read('LicensesCommonMethods.feature@SumbitCCApplication') {}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
	    * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}

		* call read('LicensesCommonMethods.feature@CheckExaminerSubmit') {}
	#	* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
	   # * call read('LicensesCommonMethods.feature@LBClaimingQueue') {}
	   # * call read('LicensesCommonMethods.feature@ApproveCCLicenseFromLB') {}
	    
	    
	  
	    
	## ******************** UC_LIC_031_CCLicense: Validate TC0001_NYC_SLA_LIC_Associate_Combined_Craft Scenario End ***************************##   
	
	
     
    
    
    
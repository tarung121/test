Feature: Examiner review
Background:
			* url BaseURL
			* def amendmentTypeId = 1
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
		        Thread.sleep(timeinMiliSeconds); 
		      }
		      """

 @TC0001_NYC_SLA_PER_AMD_Add_Truck	  
 Scenario: TC0001_NYC_SLA_PER_AMD_Add_Truck
   
	# ********* Login Functionality *********************
  		* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
 
	   ## ******************** TC0001_NYC_SLA_PER_AMD_Add_Truck ***************************##
	   
	  * def SearchByLegalName = true
	   	* def SearchByLicId = false
	   	* def amendmentType = 'ABC Officer'
	   	* def appType = 'AO-'
	   	* def termInYears = 3
	   	* def termDesc = termInYears +' Year (s)'
	   	* def typeOfNotification = 'Letter_Fingerprinting_Instructions'
	   	* def fileName = 'Letter_Fingerprinting_Instructions.pdf'
	   	* def amendmentCode = getAmendmentTypeIdFunc(amendmentType)
	    * call read('amendmentTruckingPermitFee2.feature') {}
	        
        * call read('AmendmentsCommonMethods.feature@AmendmentTruckingTypeSelectApplicationType') {}
        * def autoFirstName = 'Automation' + getDate()
	    * def legalName = autoFirstName+ ' '+'Amendment'
	   # * def LicensePermitId = '#(LicensePermitId)'
	   # * call read('LicensesCommonMethods.feature@GetPreFillLicenseAllDetailsByLicenseId') {LicensePermitId:'#(licenseId)'} 
	   # * call read('AmendmentsCommonMethods.feature@FillAndSaveApplicantInformationPageAmendment') {}
	  	   
	    * call read('AmendmentsCommonMethods.feature@VehicleTypeAdd') {}
	    
	     ## ******************** TC0001_NYC_SLA_PER_AMD_Add_Truck ***************************##   

@TC0002_NYC_SLA_PER_AMD_Edit_Truck_Added	  
 Scenario: TC0002_NYC_SLA_PER_AMD_Edit_Truck_Added
   
	# ********* Login Functionality *********************
  		* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
 
	   ## ******************** TC0002_NYC_SLA_PER_AMD_Edit_Truck_Added ***************************##
	   
	  * def SearchByLegalName = true
	   	* def SearchByLicId = false
	   	* def amendmentType = 'ABC Officer'
	   	* def appType = 'AO-'
	   	* def termInYears = 3
	   	* def termDesc = termInYears +' Year (s)'
	   	* def typeOfNotification = 'Letter_Fingerprinting_Instructions'
	   	* def fileName = 'Letter_Fingerprinting_Instructions.pdf'
	   	* def amendmentCode = getAmendmentTypeIdFunc(amendmentType)
	    * call read('amendmentTruckingPermitFee2.feature') {}
	        
        * call read('AmendmentsCommonMethods.feature@AmendmentTruckingTypeSelectApplicationType') {}
        * def autoFirstName = 'Automation' + getDate()
	    * def legalName = autoFirstName+ ' '+'Amendment'
	    * call read('AmendmentsCommonMethods.feature@VehicleTypeAdd') {}
	    * call read('AmendmentsCommonMethods.feature@VehicleTypeEdit') {}
	    
	     ## ******************** TC0002_NYC_SLA_PER_AMD_Edit_Truck_Added ***************************##   

@TC0003_NYC_SLA_PER_AMD_Remove_Truck	  
 Scenario: TC0003_NYC_SLA_PER_AMD_Remove_Truck
   
	# ********* Login Functionality *********************
  		* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
 
	   ## ******************** TC0003_NYC_SLA_PER_AMD_Remove_Truck ***************************##
	   
	  * def SearchByLegalName = true
	   	* def SearchByLicId = false
	   	* def amendmentType = 'ABC Officer'
	   	* def appType = 'AO-'
	   	* def termInYears = 3
	   	* def termDesc = termInYears +' Year (s)'
	   	* def typeOfNotification = 'Letter_Fingerprinting_Instructions'
	   	* def fileName = 'Letter_Fingerprinting_Instructions.pdf'
	   	* def amendmentCode = getAmendmentTypeIdFunc(amendmentType)
	    * call read('amendmentTruckingPermitFee2.feature') {}
	        
        * call read('AmendmentsCommonMethods.feature@AmendmentTruckingTypeSelectApplicationType') {}
        * def autoFirstName = 'Automation' + getDate()
	    * def legalName = autoFirstName+ ' '+'Amendment'
	    * call read('AmendmentsCommonMethods.feature@VehicleTypeAdd') {}
	    * call read('AmendmentsCommonMethods.feature@VehicleTypeRemove') {}
	    
	     ## ******************** TC0003_NYC_SLA_PER_AMD_Remove_Truck ***************************##   
	     
	     	     	 	  
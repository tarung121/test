Feature: Permit Application Type
Background:
			* url BaseURL
			* call read('LoginDetails.feature') { strToken:'#(strToken)'}
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

   

@TC0005_NYC_SLA_LIC_AMD_Search_By_Legal_name
Scenario: TC0005_NYC_SLA_LIC_AMD_Search_By_Legal_name
 
  		## ******************** UC_Amendment_SelectType: Validate TC0004_NYC_SLA_LIC_AMD_Search_By_Licene_ID Scenario Start ***************************##
	   	* def SearchByLegalName = true
	   	* def SearchByLicId = false
	    * call read('LicensesCommonMethods.feature@SearchLicPermitIdForAmendment') {LicensePermitId:'#(LicensePermitId)'}
	   
	    ## ******************** UC_Amendment_SelectType: Validate TC0005_NYC_SLA_LIC_AMD_Search_By_Legal_name Scenario End ***************************##   
		
		
@TC0004_NYC_SLA_LIC_AMD_Search_By_Licene_ID
Scenario: TC0004_NYC_SLA_LIC_AMD_Search_By_Licene_ID
 
  	 ## ******************** UC_Amendment_SelectType: Validate TC0004_NYC_SLA_LIC_AMD_Search_By_Licene_ID Scenario Start ***************************##
	   * call read('WholeSaleLicenseIdActive.feature') { }
	   
	   * def SearchByLegalName = true
	   	* def SearchByLicId = false
	    * call read('LicensesCommonMethods.feature@SearchLicPermitIdForAmendment') {LicensePermitId:'#(licenseId)'}
	   
	   #And print LicensePermitId
	   * def SearchByLegalName = false
	   	* def SearchByLicId = true
	    * call read('LicensesCommonMethods.feature@SearchLicPermitIdForAmendment') {}
	    
	    ## ******************** UC_Amendment_SelectType: Validate TC0004_NYC_SLA_LIC_AMD_Search_By_Licene_ID Scenario End ***************************##   
		
 @TC0007_NYC_SLA_LIC_AMD_Select_Amendment_Navigate_to_IntakeForm
Scenario: TC0007_NYC_SLA_LIC_AMD_Select_Amendment_&_Navigate_to_Intake Form
 
  		## ******************** UC_Amendment_SelectType: Validate TC0007_NYC_SLA_LIC_AMD_Select_Amendment_&_Navigate_to_Intake Form Scenario Start ***************************##
	   	* def SearchByLegalName = true
	   	* def SearchByLicId = false
	   	* def amendmentType = 'ABC Officer'
	   	* def appType = 'AO-'
	   	* def amendmentCode = getAmendmentTypeIdFunc(amendmentType)
	    * call read('LicensesCommonMethods.feature@SearchLicPermitIdForAmendment') {LicensePermitId:'#(LicensePermitId)'}
	   * call read('LicensesCommonMethods.feature@IntakeAmendment') {}
	    ## ******************** UC_Amendment_SelectType: Validate TC0007_NYC_SLA_LIC_AMD_Select_Amendment_&_Navigate_to_Intake Form Scenario End ***************************##   
		   
   @TC0009_NYC_SLA_LIC_AMD_Alteration_Amendment_With_Additional_Bars
Scenario: TC0009_NYC_SLA_LIC_AMD_Alteration_Amendment_With_Additional_Bars
 
  		## ******************** UC_Amendment_SelectType: Validate TC0009_NYC_SLA_LIC_AMD_Alteration_Amendment_With_Additional_Bars Scenario Start ***************************##
	   	* def SearchByLegalName = true
	   	* def SearchByLicId = false
	   	* def amendmentType = 'Additional Bar'
	   	* def appType = 'AB-'
	   	* def amendmentCode = getAmendmentTypeIdFunc(amendmentType)
	    * call read('LicensesCommonMethods.feature@SearchLicPermitIdForAmendment') {LicensePermitId:'#(LicensePermitId)'}
	   * call read('LicensesCommonMethods.feature@IntakeAmendment') {}
	    ## ******************** UC_Amendment_SelectType: Validate TC0009_NYC_SLA_LIC_AMD_Alteration_Amendment_With_Additional_Bars Scenario End ***************************##   
		 
	 @TC0010_NYC_SLA_LIC_AMD_Alteration_Amendment
Scenario: TC0010_NYC_SLA_LIC_AMD_Alteration_Amendment
 
  		## ******************** UC_Amendment_SelectType: Validate TC0010_NYC_SLA_LIC_AMD_Alteration_Amendment Scenario Start ***************************##
	   	* def SearchByLegalName = true
	   	* def SearchByLicId = false
	   	* def amendmentType = 'Alteration'
	   	* def appType = 'AL-'
	   	* def amendmentCode = getAmendmentTypeIdFunc(amendmentType)
	    * call read('LicensesCommonMethods.feature@SearchLicPermitIdForAmendment') {LicensePermitId:'#(LicensePermitId)'}
	   * call read('LicensesCommonMethods.feature@IntakeAmendment') {}
	    ## ******************** UC_Amendment_SelectType: Validate TC0010_NYC_SLA_LIC_AMD_Alteration_Amendment Scenario End ***************************##   
		 
 @TC0011_NYC_SLA_LIC_AMD_Alteration_Amendment_Seasonal_With_Additional_Bars
Scenario: TC0011_NYC_SLA_LIC_AMD_Alteration_Amendment_Seasonal_With_Additional_Bars
 
  		## ******************** UC_Amendment_SelectType: Validate TC0011_NYC_SLA_LIC_AMD_Alteration_Amendment_Seasonal_With_Additional_Bars Scenario Start ***************************##
	   	* def SearchByLegalName = true
	   	* def SearchByLicId = false
	   	* def amendmentType = 'Alteration with Additional Bar'
	   	* def appType = 'AL-'
	   	* def amendmentCode = getAmendmentTypeIdFunc(amendmentType)
	    * call read('LicensesCommonMethods.feature@SearchLicPermitIdForAmendment') {LicensePermitId:'#(LicensePermitId)'}
	   * call read('LicensesCommonMethods.feature@IntakeAmendmentWithAdditionalBar') {}
	    ## ******************** UC_Amendment_SelectType: Validate TC0011_NYC_SLA_LIC_AMD_Alteration_Amendment_Seasonal_With_Additional_Bars Scenario End ***************************##   
		 
		 
@TC0012_NYC_SLA_LIC_AMD_Endorsement_Amendment
Scenario: TC0012_NYC_SLA_LIC_AMD_Endorsement_Amendment
 
  		## ******************** UC_Amendment_SelectType: Validate TC0012_NYC_SLA_LIC_AMD_Endorsement_Amendment Scenario Start ***************************##
	   	* def SearchByLegalName = true
	   	* def SearchByLicId = false
	   	* def amendmentType = 'Endorsement'
	   	* def appType = 'EN-'
	   	* def amendmentCode = getAmendmentTypeIdFunc(amendmentType)
	    * call read('LicensesCommonMethods.feature@SearchLicPermitIdForAmendment') {LicensePermitId:'#(LicensePermitId)'}
	   * call read('LicensesCommonMethods.feature@IntakeAmendment') {}
	    ## ******************** UC_Amendment_SelectType: Validate TC0012_NYC_SLA_LIC_AMD_Endorsement_Amendment Scenario End ***************************##   
		 				 	 
		 
		 
		 
@TC0013_NYC_SLA_LIC_AMD_Class_Change_Amendment
Scenario: TC0013_NYC_SLA_LIC_AMD_Class_Change_Amendment
 
  		## ******************** UC_Amendment_SelectType: Validate TC0013_NYC_SLA_LIC_AMD_Class_Change_Amendment Scenario Start ***************************##
	   	* def SearchByLegalName = true
	   	* def SearchByLicId = false
	   	* def amendmentType = 'Class Change'
	   	* def appType = 'CL-'
	   	* def amendmentCode = getAmendmentTypeIdFunc(amendmentType)
	    * call read('LicensesCommonMethods.feature@SearchLicPermitIdForAmendment') {LicensePermitId:'#(LicensePermitId)'}
	   * call read('LicensesCommonMethods.feature@IntakeAmendment') {}
	    ## ******************** UC_Amendment_SelectType: Validate TC0013_NYC_SLA_LIC_AMD_Class_Change_Amendment Scenario End ***************************##   
		 		 
		 		 
		 		 
@TC0014_NYC_SLA_LIC_AMD_Trucking_Amendment
Scenario: TC0014_NYC_SLA_LIC_AMD_Trucking_Amendment
 
  		## ******************** UC_Amendment_SelectType: Validate TC0014_NYC_SLA_LIC_AMD_Trucking_Amendment Scenario Start ***************************##
	   	* def SearchByLegalName = true
	   	* def SearchByLicId = false
	   	* def amendmentType = 'Trucking Amendment'
	   	* def appType = 'TA-'
	   	* def amendmentCode = getAmendmentTypeIdFunc(amendmentType)
	    * call read('LicensesCommonMethods.feature@SearchLicPermitIdForAmendment') {LicensePermitId:'#(LicensePermitId)'}
	   * call read('LicensesCommonMethods.feature@IntakeAmendment') {}
	    ## ******************** UC_Amendment_SelectType: Validate TC0014_NYC_SLA_LIC_AMD_Trucking_Amendment Scenario End ***************************##   
		 		 		 
		 	
@TC0015_NYC_SLA_LIC_AMD_Corporate_Change_Amendment
Scenario: TC0015_NYC_SLA_LIC_AMD_Corporate_Change_Amendment
 
  		## ******************** UC_Amendment_SelectType: Validate TC0015_NYC_SLA_LIC_AMD_Corporate_Change_Amendment Scenario Start ***************************##
	   	* def SearchByLegalName = true
	   	* def SearchByLicId = false
	    * def amendmentType = 'Corporate Change'
	   	* def appType = 'CC-'
	   	* def amendmentCode = getAmendmentTypeIdFunc(amendmentType)
	    * call read('LicensesCommonMethods.feature@SearchLicPermitIdForAmendment') {LicensePermitId:'#(LicensePermitId)'}
	   * call read('LicensesCommonMethods.feature@IntakeAmendment') {}
	    ## ******************** UC_Amendment_SelectType: Validate TC0015_NYC_SLA_LIC_AMD_Corporate_Change_Amendment Scenario End ***************************##   
		 			 	
		 	
		 	
@TC0019_NYC_SLA_LIC_AMD_Seasonal_Extension_Amendment
Scenario: TC0019_NYC_SLA_LIC_AMD_Seasonal_Extension_Amendment
 
  		## ******************** UC_Amendment_SelectType: Validate TC0019_NYC_SLA_LIC_AMD_Seasonal_Extension_Amendment Scenario Start ***************************##
	   	* def SearchByLegalName = true
	   	* def SearchByLicId = false
	   	* def amendmentType = 'Seasonal Extension'
	   	* def appType = 'SE-'
	   	* def amendmentCode = getAmendmentTypeIdFunc(amendmentType)
	    * call read('LicensesCommonMethods.feature@SearchLicPermitIdForAmendment') {LicensePermitId:'#(LicensePermitId)'}
	   * call read('LicensesCommonMethods.feature@IntakeAmendment') {}
	    ## ******************** UC_Amendment_SelectType: Validate TC0019_NYC_SLA_LIC_AMD_Seasonal_Extension_Amendment Scenario End ***************************##   
		 		 	
	@TC0020_NYC_SLA_LIC_AMD_Additional_Bar_Amendment
Scenario: TC0020_NYC_SLA_LIC_AMD_Additional_Bar_Amendment
 
  		## ******************** UC_Amendment_SelectType: Validate TC0020_NYC_SLA_LIC_AMD_Additional_Bar_Amendment Scenario Start ***************************##
	   	* def SearchByLegalName = true
	   	* def SearchByLicId = false
	   		* def amendmentType = 'Additional bar- ball park'
	   	* def appType = 'AB-'
	   	* def amendmentCode = getAmendmentTypeIdFunc(amendmentType)
	    * call read('LicensesCommonMethods.feature@SearchLicPermitIdForAmendment') {LicensePermitId:'#(LicensePermitId)'}
	   * call read('LicensesCommonMethods.feature@IntakeAmendment') {}
	    ## ******************** UC_Amendment_SelectType: Validate TC0020_NYC_SLA_LIC_AMD_Additional_Bar_Amendment Scenario End ***************************##   
		 		 		 		 
		 		 		 		 
		 		 		 		 
	@TC0022_NYC_SLA_LIC_AMD_Not_Qualified_Application
Scenario: TC0022_NYC_SLA_LIC_AMD_Not_Qualified_Application
 
  		## ******************** UC_Amendment_SelectType: Validate TC0022_NYC_SLA_LIC_AMD_Not_Qualified_Application Scenario Start ***************************##
	   	* def SearchByLegalName = true
	   	* def SearchByLicId = false
	   		* def amendmentType = 'Method of Operation'
	   	* def appType = 'MO-'
	   	* def amendmentCode = getAmendmentTypeIdFunc(amendmentType)
	    * call read('LicensesCommonMethods.feature@SearchLicPermitIdForAmendment') {LicensePermitId:'#(LicensePermitId)'}
	   * call read('LicensesCommonMethods.feature@IntakeAmendment') {}
	    ## ******************** UC_Amendment_SelectType: Validate TC0022_NYC_SLA_LIC_AMD_Not_Qualified_Application Scenario End ***************************##   
		 	 		 		 		 
		 		 		 		 
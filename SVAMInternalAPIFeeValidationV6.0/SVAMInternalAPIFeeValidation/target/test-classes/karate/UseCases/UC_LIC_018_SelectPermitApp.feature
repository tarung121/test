Feature: Permit Combination Intake form
Background:
			* url BaseURL
  			* def config = { username: '#(dbUserName)', password:'#(dbUserPassword)', url: '#(dbQuery)',driverClassName: 'com.microsoft.sqlserver.jdbc.SQLServerDriver' }
    	 	* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}

@PermitAssociatedScenarios    	
Scenario Outline: Select Associated Permits Intake form
   
	# ********* Login Functionality *********************
  	
	  	* def mainLicensePermitTypeId = <LicensePermitTypeId>
	    * def termInYears = <NumberOfTerm>
	    * def termDesc = <NumberOfTerm>+' Year (s)'
	    * def licenseFees = <InitialLicFee>
	    * def fillingFees = <NonRefundableFilingFees>
	    * def renewalFees = <RenewalFilingFees>+''
	    
	     * def emailId = 'automation@svam.com'
	    * def CountyID = 1	
	    * def fiveDigitLicID = '0002-'
	    
	         
	  
    ## ******************** UC_LIC_018: IntakeAssociatedPermit with LicenseID Scenario Start ***************************##
			* call read('PermitsCommonMethods.feature@GetActivatedLicenses') {fiveDigitLicID:'0002-',legalName:null}
			* call read('PermitsCommonMethods.feature@IntakeAssociatedPermit') {}
	   
	 ## ******************** UC_LIC_018: IntakeAssociatedPermit with LicenseID Scenario End ***************************##   
	
	## ******************** UC_LIC_018: IntakeAssociatedPermit with LegalName Scenario Start ***************************##
	    	* call read('PermitsCommonMethods.feature@GetActivatedLicenses') {fiveDigitLicID:null,legalName:'Automation'}
	    	* call read('PermitsCommonMethods.feature@IntakeAssociatedPermit') {}
	   
	
Examples:
    | read('/CSVFiles/TC_AssociatedPermitInputs.csv') |
    
    
@PermitStandaloneScenarios 
Scenario Outline: Select StandAlone Permits Intake form
   
	# ********* Login Functionality *********************
  	
	  	* def mainLicensePermitTypeId = <LicensePermitTypeId>
	    * def termInYears = <NumberOfTerm>
	    * def termDesc = <NumberOfTerm>+' Year (s)'
	    * def licenseFees = <InitialLicFee>
	    * def fillingFees = <NonRefundableFilingFees>
	    * def renewalFees = <RenewalFilingFees>+''
	    
	     * def emailId = 'automation@svam.com'
	    * def CountyID = 1	
	    * def fiveDigitLicID = '0002-'

	  ## ******************** UC_LIC_018: IntakeStandAlonePermit without LicenseID & LegalName Scenario Start ***************************##
	  		* call read('PermitsCommonMethods.feature@IntakeStandalonePermit') {licId: null}
	## ******************** UC_LIC_018: IntakeStandAlonePermit without LicenseID & LegalName Scenario End ***************************##   
	
	
	## ******************** UC_LIC_018: IntakeStandAlonePermit with LicenseID Scenario Start ***************************##
			* call read('PermitsCommonMethods.feature@GetActivatedLicenses') {fiveDigitLicID:'0071-',legalName:null}
			* call read('PermitsCommonMethods.feature@IntakeStandalonePermit') {}
	   
	 ## ******************** UC_LIC_018: IntakeStandAlonePermit with LicenseID Scenario End ***************************##   
	
	## ******************** UC_LIC_018: IntakeAssociatedPermit with LegalName Scenario Start ***************************##
	   		* call read('PermitsCommonMethods.feature@GetActivatedLicenses') {fiveDigitLicID:null,legalName:'Automation'}
	   		* call read('PermitsCommonMethods.feature@IntakeStandalonePermit') {}
	   
	 ## ******************** UC_LIC_018: IntakeAssociatedPermit with LegalName Scenario End ***************************##   
	
Examples:
    | read('/CSVFiles/StandalonePermit.csv') |
    
    
@PermitTempScenarios 
Scenario Outline: Select Temp Permits Intake form
  
  		* def mainLicensePermitTypeId = <LicensePermitTypeId>
		* def termInYears = <NumberOfTerm>
	    * def termDesc = <NumberOfTerm>+' Year (s)'
	    * def licenseFees = <InitialLicFee>
	    * def fillingFees = <NonRefundableFilingFees>
	    * def renewalFees = <RenewalFilingFees>+''
	    * def productName = <LicDescription>
	     * def emailId = 'automation@svam.com'
	## ******************** UC_LIC_018: IntakeTempPermit without LicenseID & LegalName Scenario Start ***************************##
	  		* call read('PermitsCommonMethods.feature@IntakeTempPermit') {permit_Type:'Temporary Permit', SearchedapplicationId: null}
	## ******************** UC_LIC_018: IntakeTempPermit without LicenseID & LegalName Scenario End ***************************##   
	
	
	## ******************** UC_LIC_018: IntakeTempPermit with LicenseID Scenario Start ***************************##
			* call read('PermitsCommonMethods.feature@searchLicenseApplicationByCriteria') {fiveDigitAppID:'NA-00',legalName:null}
			* call read('PermitsCommonMethods.feature@IntakeTempPermit') {permit_Type:'Temporary Permit'}
	   
	## ******************** UC_LIC_018: IntakeTempPermit with LicenseID Scenario End ***************************##   
	
	## ******************** UC_LIC_018: IntakeTempPermit with LegalName Scenario Start ***************************##
	 		* call read('PermitsCommonMethods.feature@searchLicenseApplicationByCriteria') {fiveDigitAppID:null,legalName:'Automation'}
			* call read('PermitsCommonMethods.feature@IntakeTempPermit') {permit_Type:'Temporary Permit'}
	   
	 ## ******************** UC_LIC_018: IntakeTempPermit with LegalName Scenario End ***************************##   
	
Examples:
    | read('/CSVFiles/TempPermit.csv') |
	  
 	
 
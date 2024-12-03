Feature: amendment other fee validation

Background:
			* url BaseURL
  		* def config = { username: '#(dbUserName)', password:'#(dbUserPassword)', url: '#(dbQuery)',driverClassName: 'com.microsoft.sqlserver.jdbc.SQLServerDriver' }
    	* def DbUtils = Java.type('utils.DbUtils')
    	* def db = new DbUtils(config)
    	
    	* def getDate =
	    """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat('yyyyMMddHHmmss');
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		"""

Scenario Outline: Get Fees Details Validation

  * callonce read('FeeValidationManufacturingActiveLicense.feature') { strToken:'#(strToken)',strToken:'#(strToken)',licenseId:'#(licenseId)',db: '#(db)',businessID: '#(businessID)',appId: '#(appId)',ApplicationId: '#(applicationId)',formVersionId: '#(FormVersionId)',formId: '#(formId)'}

Given path '/internalapi/api/licensing/amendment/save'
 
    And header authorization = 'Bearer ' + strToken
     * def mainLicensePermitTypeId = <LicensePermitTypeId>
      * def termInYears = <NumberOfTerm>
      * def termDesc = <NumberOfTerm>+' Year (s)'
      * def licenseFees = <InitialLicFee>
      * def fillingFees = <NonRefundableFilingFees>
      * def renewalFees = <RenewalFilingFees>+''
      * def AncillaryPrice = <AncillaryFees>
      * def totalFees = licenseFees  + fillingFees + AncillaryPrice
    And request {"LicenseId":'#(licenseId)',"applicationTypeId":4,"completedProvisionals":[],"Amendments":[{"endorsementSubCategoryId":[],"corporateSetups":[],"proposedCorporateSetups":[],"additionalBar":[],"truckDetails":[],"licenseId":'#(licenseId)',"amendmentTypeId":4,"comments":"Class Change Test","classChangeLicenseId":'#(mainLicensePermitTypeId)',"removedTrucks":[]}],"EndorsmentOptions":[]}
    When method post
    Then status 200
    And def serverResponse = response
    And def ApplicationId = serverResponse[0].ApplicationId
    And def appId = serverResponse[0].appId
     And def termActRes = serverResponse[0].term
     
        * def autoFirstName = 'Automation' + getDate()
	    * def legalName = autoFirstName+ ' '+'Amendment'
          	    
Given path 'internalapi/api/licensing/fees/licenses/get/'+appId
          
     And header authorization = 'Bearer ' + strToken
     And header Content-Type = 'application/json; charset=utf-8'
   	 And header Accept = 'application/json; text/plain;*/*'
  	 And request ""
	 When method get
	 Then status 200 
	  And def FilingFees = response[0].filingFees
     And def ancillaryFees = response[0].ancillaryFees
     And def bondFee = response[0].bondFee
     And def licensingFees = response[0].licensingFees
     * def TotalFeesAct = licensingFees + ancillaryFees + FilingFees
     And print TotalFeesAct

                * configure continueOnStepFailure = true
 		        * match TotalFeesAct == 884

  Examples:
   | read('/LicenseInputs/classChangeBrewer.csv') |
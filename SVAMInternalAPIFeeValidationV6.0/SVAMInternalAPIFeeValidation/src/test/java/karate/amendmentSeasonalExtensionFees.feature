Feature: amendment no fee validation

Background:
			* url BaseURL
  		* def config = { username: '#(dbUserName)', password:'#(dbUserPassword)', url: '#(dbQuery)',driverClassName: 'com.microsoft.sqlserver.jdbc.SQLServerDriver' }
    	* def DbUtils = Java.type('utils.DbUtils')
    	* def db = new DbUtils(config)

Scenario Outline: Get Fees Details Validation

  * callonce read('WholeSaleLicenseIdActive.feature') { strToken:'#(strToken)',strToken:'#(strToken)',licenseId:'#(licenseId)',db: '#(db)',businessID: '#(businessID)',appId: '#(appId)',ApplicationId: '#(applicationId)',formVersionId: '#(FormVersionId)',formId: '#(formId)'}

Given path '/internalapi/api/licensing/amendment/save'
 
    And header authorization = 'Bearer ' + strToken
    * def mainLicensePermitTypeId = <LicensePermitTypeId>
    * def InitialLicenseFee = <InitialLicFee>
    * def BondValue = <bond>
      And print BondValue
    * def termExp = <NumberOfTerm>
    * def lDesc = <LicDescription>
    * def NonRefundableFilingFee = <NonRefundableFilingFees>
    * def RenewalFilingFee = <RenewalFilingFees>
    * def AncillaryPrice = <AncillaryFees>
    
    And def totalAmount = InitialLicenseFee+NonRefundableFilingFee+RenewalFilingFee
    And print totalAmount
    And request {"LicenseId":'#(licenseId)',"applicationTypeId":4,"completedProvisionals":[],"Amendments":[{"endorsementSubCategoryId":[],"corporateSetups":[],"proposedCorporateSetups":[],"additionalBar":[],"truckDetails":[],"licenseId":'#(licenseId)',"amendmentTypeId":3,"removedTrucks":[]}],"EndorsmentOptions":[]}
    When method post
    Then status 200
    And def serverResponse = response
    And def ApplicationId = serverResponse[0].applicationId
    And def appId = serverResponse[0].appId
     And def termActRes = serverResponse[0].term
     	    
Given path 'internalapi/api/licensing/fees/licenses/get/'+appId
          
     And header authorization = 'Bearer ' + strToken
     And header Content-Type = 'application/json; charset=utf-8'
   	 And header Accept = 'application/json; text/plain;*/*'
  	 And request ""
	 When method get
	 Then status 200 
	 * def LicenseName = response.licenseName
	 * def AmendmentFees = response[0].amendmentFees

                * configure continueOnStepFailure = true
 		        * match AmendmentFees == 0

  		    
  Examples:
   | read('/LicenseInputs/PermitFeeMain1.csv') |
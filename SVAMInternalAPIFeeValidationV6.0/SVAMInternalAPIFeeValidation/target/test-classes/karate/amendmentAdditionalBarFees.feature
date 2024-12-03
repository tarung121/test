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

  * callonce read('WholeSaleLicenseIdActive.feature') { strToken:'#(strToken)',strToken:'#(strToken)',licenseId:'#(licenseId)',db: '#(db)',businessID: '#(businessID)',appId: '#(appId)',ApplicationId: '#(applicationId)',formVersionId: '#(FormVersionId)',formId: '#(formId)'}

Given path '/internalapi/api/licensing/amendment/save'
 
    And header authorization = 'Bearer ' + strToken
    * def mainLicensePermitTypeId = <LicensePermitTypeId>
    * def termExp = <NumberOfTerm>
    * def lDesc = <LicDescription>
    * def licenseFees = <InitialLicFee>
        And print licenseFees
      * def fillingFees = <NonRefundableFilingFees>
        And print fillingFees
        * def totalFees = licenseFees  + fillingFees
    And request {"LicenseId":'#(licenseId)',"applicationTypeId":4,"completedProvisionals":[],"Amendments":[{"endorsementSubCategoryId":[],"corporateSetups":[],"proposedCorporateSetups":[],"additionalBar":[],"truckDetails":[],"licenseId":'#(licenseId)',"amendmentTypeId":1,"removedTrucks":[]}],"EndorsmentOptions":[]}
    When method post
    Then status 200
    And def serverResponse = response
    And def ApplicationId = serverResponse[0].ApplicationId
    And def appId = serverResponse[0].appId
     And def termActRes = serverResponse[0].term
     
        * def autoFirstName = 'ABC' + getDate()
	    * def legalName = autoFirstName+ ' '+'Officer'
     	    
Given path 'internalapi/api/licensing/app/static/abcofficer/save/'+appId
 
    And header authorization = 'Bearer ' + strToken
    And request {"isClubOfficerSignature":null,"clubOfficerTitle":"President","clubOfficerDateSigned":"","isProposedOfficerSignature":null,"proposedOfficerDateSigned":"","proposedAbcOfficer":{"personId":0,"isIndividualsPartnersAssociatedWithEntity":"","firstName":'#(autoFirstName)',"middleName":null,"lastName":"Officer","suffix":null,"socialSecurityNo":null,"birthDate":null,"email":"","age":null,"choosedEntity":[]},"proposedOfficerAddress":{"addressId":null,"appId":null,"addressLine1":null,"addressLine2":null,"city":null,"stateId":40,"county":null,"zipCode":null,"zip4":null,"street":null,"telephoneNumber":null,"country":"United States (US)","addressTypeId":null,"location":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null,"isActive":null,"showAndHide":null,"roomNo":null,"stateName":"New York","countryId":229,"serialNo":0,"addressType":null,"state":null}}
    When method post
    Then status 200
          	    
Given path 'internalapi/api/licensing/fees/licenses/get/'+appId
          
     And header authorization = 'Bearer ' + strToken
     And header Content-Type = 'application/json; charset=utf-8'
   	 And header Accept = 'application/json; text/plain;*/*'
  	 And request ""
	 When method get
	 Then status 200 
	 * def LicenseName = response.licenseName
	 * def AmendmentFees = response[0].amendmentFees
	 * def filingFees = response[0].filingFees
	 * def licensingFees = response[0].licensingFees

                * configure continueOnStepFailure = true
 		        * match AmendmentFees == 128
 		        * match filingFees == 0
 		        * match licensingFees == 0

  Examples:
   | read('/LicenseInputs/PermitFeeMain1.csv') |
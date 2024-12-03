Feature: amendment Endoesement Change validation

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
		
		 * def waitFunc =
                """
              function(timeinMiliSeconds) {
                // load java type into js engine
                var Thread = Java.type('java.lang.Thread');
                Thread.sleep(timeinMiliSeconds*1000);
              }
              """	

Scenario Outline: Get Fees Details Validation

  * callonce read('WholeSaleLicenseIdActive.feature') { strToken:'#(strToken)',strToken:'#(strToken)',licenseId:'#(licenseId)',db: '#(db)',businessID: '#(businessID)',appId: '#(appId)',ApplicationId: '#(applicationId)',formVersionId: '#(FormVersionId)',formId: '#(formId)'}

Given path '/internalapi/api/licensing/amendment/save'
 
    And header authorization = 'Bearer ' + strToken
    * def mainLicensePermitTypeId = <LicensePermitTypeId>
    * def termExp = <NumberOfTerm>
    * def lDesc = <LicDescription>
   # * def AmendmentExp = <amendmentFees>
    And request {"LicenseId":'#(licenseId)',"applicationTypeId":4,"completedProvisionals":[],"Amendments":[{"endorsementSubCategoryId":[],"corporateSetups":[],"proposedCorporateSetups":[],"additionalBar":[],"truckDetails":[],"licenseId":'#(licenseId)',"amendmentTypeId":5,"removedTrucks":[]}],"EndorsmentOptions":[]}
    When method post
    Then status 200
    And def serverResponse = response
    And def ApplicationId = serverResponse[0].ApplicationId
    And def appId = serverResponse[0].appId
     And def termActRes = serverResponse[0].term
     
        * def autoFirstName = 'Automation' + getDate()
	    * def legalName = autoFirstName+ ' '+'Amendment'
	    * def autoFirstName = 'Corp' + getDate()
	    * def legalName1 = autoFirstName+ ' '+'CorpChange'
     	    
Given path 'internalapi/api/licensing/app/static/endorsement/save/'+appId
 
    And header authorization = 'Bearer ' + strToken
    And request {"id":0,"changeRequested":"15","proposedChanges":{"id":0,"legalName":'#(legalName)',"dba":null,"fein":""},"existingOfficers":[{"id":79,"firstName":'#(autoFirstName)',"middleName":"AutoMidName","lastName":"CorpChange","entity":"","currentTitle":"15","currentPercentageOfInterest":20,"currentNumberOfShares":"0","isModified":false,"isRemoved":false,"entities":"[]","titleText":"Vice President"}],"proposedAddress":{"addressId":null,"appId":null,"addressLine1":"Address1","addressLine2":"Address2","city":"New York","stateId":40,"county":"United States (US)","zipCode":"12345","zip4":"1234","street":null,"telephoneNumber":null,"country":"United States (US)","addressTypeId":null,"location":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null,"isActive":null,"showAndHide":null,"roomNo":null,"stateName":"New York","countryId":229,"serialNo":0,"addressType":null,"state":null,"zip":"12345"},"attestation":{"id":0,"printName":null,"title":null,"date":"","signatureOfCurrentAuthorizedOfficer":null},"proposedOfficers":[{"id":79,"firstName":'#(autoFirstName)',"middleName":"AutoMidName","lastName":"CorpChange","entity":"","currentTitle":"15","currentPercentageOfInterest":20,"currentNumberOfShares":"0","isModified":false,"isRemoved":false,"entities":"[]","titleText":"Vice President","isNew":false}]}
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

                * configure continueOnStepFailure = true
 		        * match AmendmentFees == 13

  Examples:
   | read('/LicenseInputs/PermitFeeMain1.csv')
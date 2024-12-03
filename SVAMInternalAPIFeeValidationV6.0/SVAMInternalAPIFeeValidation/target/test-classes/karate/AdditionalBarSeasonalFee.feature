Feature: GetFeesDetails

Background:
			* url BaseURL
  		* def config = { username: '#(dbUserName)', password:'#(dbUserPassword)', url: '#(dbQuery)',driverClassName: 'com.microsoft.sqlserver.jdbc.SQLServerDriver' }
    	* def DbUtils = Java.type('utils.DbUtils')
    	* def db = new DbUtils(config)

Scenario Outline: Get Fees Details Validation

	# ********* App Intake *********************
  	* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
 
	Given path '/internalapi/api/licensing/selectapptype/savenewlicenseapp'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
   		
      * def mainLicensePermitTypeId = <LicensePermitTypeId>
      * def AssociatedMainLicensePermitTypeId = <AssociatedLicensePermitTypeId>
        And print mainLicensePermitTypeId
     #* def termInMonths = <NumberOfTerm>
       # And print termInMonths
       * def CountysId = <countyIds>
         And print CountysId
       * string CountysName = <countynames>
         And print CountysName
      * def licenseFees = <InitialLicFee>
        And print licenseFees
      * def fillingFees = <NonRefundableFilingFees>
        And print fillingFees
      * def renewalFees = <RenewalFilingFees>+''
        And print renewalFees
      * string Season = <Weather>+''	
      		* def licDate =
			"""
			  function() {
			    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
			    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
			    var date = new java.util.Date();
			    return sdf.format(date);
			  }
		  
		"""	
		 * def dt = licDate()
       * def dtEnd = licDate()
       * def NumberOfBar = <NoOfBars>
       * string productName = <ProductTypes>+''
       * def totalFees = licenseFees  + fillingFees
         And print totalFees	
   	     And request {"mainLicensePermitTypeId":'#(mainLicensePermitTypeId)',"noOfMonths":7,"startDate":'#(dt)',"endDate":'#(dtEnd)',"newPermitTypeIds":[],"combinedCraftId":null,"masterFileId":null,"isApplicableForTempPermit":false,"isNotQualified":false,"isChainRestaurant":false,"addBarList":[{"associatedLicenseTypeId":'#(AssociatedMainLicensePermitTypeId)',"noOfBars":'#(NumberOfBar)',"isSeasonal":true,"season":'#(Season)',"isTempPermitRequired":false}],"countyId":'#(CountysId)',"isApplicantCurrentLicensed":false,"isExistingManufacturer":false,"selectedLicense":null}

	     When method post
	     Then status 200
	     * def count = response.length
	     And def childAppId1 = response[0].childAppId
	     And print childAppId1
	     And def ChildApplicationId = response[0].childApplicationId
	     And print ChildApplicationId
	     And def appId = response[0].parentAppId
	     And print appId
	     And def ParentApplicationId = response[0].parentApplicationId
	     And print ParentApplicationId	 
	
  Given path '/internalapi/api/licensing/app/static/applicantinfo/save/'+appId
      
  	    And header Content-Type = 'application/json; charset=utf-8'
  	  * def getDate =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat('yyyyMMddHHmmss');
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		  """
  	  * def temp = 'Automation'+getDate()
  	  * def CitysName = <CityName>
        And print CitysName
	  * def legalName = temp + 'License'
        And header Accept = 'application/json; text/plain;*/*'
        And header authorization = 'Bearer ' + strToken
        And request {"businessInfo":{"website":null,"businessEntity":{"individualOrganization":"1","corporateStructure":"1","firstName":'#(temp)',"lastName":"License","middleName":"","suffix":null,"ssn":"","fein":"","legalName":'#(legalName)',"id":0,"isEmployeeForSoleProprietor":null,"individualOrganizationText":null,"corporateStructureText":null,"isIndividual":false},"address":{"addressId":0,"appId":null,"addressLine1":null,"addressLine2":null,"city":null,"stateId":40,"county":null,"zipCode":null,"zip4":null,"street":null,"telephoneNumber":null,"country":"United States (US)","addressTypeId":null,"location":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null,"isActive":null,"showAndHide":null,"roomNo":null,"stateName":"New York","countryId":229,"serialNo":0,"addressType":null,"state":null},"communication":{"email":null,"confirmEmail":null,"phones":[],"id":0},"id":0,"isLicensed":false,"isAssociated":false},"premisesInfo":{"dba":null,"licensePermitID":null,"address":{"addressId":0,"appId":null,"addressLine1":"qewda","addressLine2":null,"city":'#(CitysName)',"stateId":40,"county":'#(CountysName)',"zipCode":"11111","zip4":null,"street":null,"telephoneNumber":null,"country":"United States (US)","addressTypeId":null,"location":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null,"isActive":null,"showAndHide":null,"roomNo":null,"stateName":"New York","countryId":229,"serialNo":0,"addressType":null,"state":null},"communication":{"email":null,"confirmEmail":null,"phones":[],"id":0},"id":0,"isDbaSearched":null},"applicantDetail":{"masterFileID":null,"mfExpDate":null,"certificateNysTax":null,"certIssueDate":null,"applicantStatement":{"nameOfApplicant":null,"date":null,"title":null,"signature":null,"id":0},"id":0,"isPhysicalChange":null}}
	    When method post
	    Then status 200
	
# ********* SAVE Application Details To Save *********************
    
    Given path '/internalapi/api/licensing/fees/licenses/get/'+appId
         And header authorization = 'Bearer ' + strToken
         And header Content-Type = 'application/json; charset=utf-8'
   		 And request ""
	     When method get
		 Then status 200
	   * configure continueOnStepFailure = true     
         And def serverResponse = response
         And def ApplicationId = serverResponse[1].applicationId
         And def appId = serverResponse[1].appId
         And def termActRes = serverResponse[1].term
         And def filingFeesAct = serverResponse[1].filingFees
         And def ancillaryFees = serverResponse[1].ancillaryFees
        #And def renewalFees = serverResponse[1].renewalFees
         And def bondFee = serverResponse[1].bondFee
         And def licensingFees = serverResponse[1].licensingFees
         And print serverResponse

     
       * def BondValue = <bond>
         And print BondValue
       * def lDesc = <LicDescription>
       * def NonRefundableFilingFee = <NonRefundableFilingFees>
         And print NonRefundableFilingFee
      #* def RenewalFilingFee = <RenewalFilingFees>
    
       # And print 'MainLicense/PermitType ID : ' , mainLicensePermitTypeId, 'Type of License : ' , <LicDescription>,'Application ID : ', ApplicationId,'App ID : ' , appId
       # And print 'Licensing Fee Expected Value : ' , licenseFees,'Licensing Fee Actual Response : ' , licensingFees,'Filing Fee Expected Value : ' , fillingFees,'Filing Fee Actual Response : ' , filingFeesAct, 'Term Expected Value : ' , termInYears,'Term Actual Value : ' , termActRes
        
       
       
        * def addLicenseDataOnMismatchedFunc =
			"""
			function(actfilingFees,expfilingFees,actInitialLicenseFee, expInitialLicenseFee,actbondFee,expBondValue) {
			   
			        if(actfilingFees != expfilingFees || actInitialLicenseFee != expInitialLicenseFee || actbondFee != expBondValue ){
			            karate.log('condition satisfied');
			            return db.appendStrToFile('licenseFailedFeesCity.csv' , ('\n'+lDesc+','+productName+','+CitysName+','+actfilingFees+','+expfilingFees+','+actInitialLicenseFee+','+expInitialLicenseFee+','+actbondFee+','+expBondValue));
			        }
	        }
			"""
         * def addLicenseDataOnMismatched = addLicenseDataOnMismatchedFunc(filingFeesAct,fillingFees,licensingFees,licenseFees,bondFee,BondValue)
               
                * configure continueOnStepFailure = true
                * match filingFeesAct == fillingFees
				* match licenseFees == licensingFees
 		      # * match termActRes == termInMonths
 		        * match bondFee == BondValue
 		        
 		        #* match renewalFees == RenewalFilingFee
 		        #* match ancillaryFees == AncillaryPrice
			    
 Examples:
   | read('/LicenseInputs/AdditionalBarSeasonal.csv') |
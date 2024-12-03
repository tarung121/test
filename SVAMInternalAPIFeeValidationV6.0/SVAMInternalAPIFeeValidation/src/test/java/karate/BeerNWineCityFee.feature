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
     And print mainLicensePermitTypeId
     	
      * def termInYears = <NumberOfTerm>
     And print termInYears
      * def termDesc = <NumberOfTerm>+' Year (s)'
     	 And print termDesc
      * def licenseFees = <InitialLicFee>
     And print licenseFees
     	
      * def fillingFees = <NonRefundableFilingFees>
     And print fillingFees
     	
      * def renewalFees = <RenewalFilingFees>+''
     And print renewalFees
     	
     
    
    * string productName = <ProductTypes>+''
     * def totalFees = licenseFees  + fillingFees
     And print totalFees	
   				   And request {"mainLicensePermitTypeId":'#(mainLicensePermitTypeId)',"newPermitTypeIds":[],"combinedCraftId":null,"masterFileId":null,"isApplicableForTempPermit":false,"isNotQualified":false,"isChainRestaurant":false,"addBarList":[],"countyId":14,"isApplicantCurrentLicensed":false,"isExistingManufacturer":false,"selectedLicense":null}
	  When method post
	  Then status 200
	               
	   And def ApplicationId = response[0].mainApplicationId
	  And print ApplicationId
	  And def description = response[0].description
	 
	   And def appId = response[0].appId
	  
	   * def formId = response[0].formId
	 
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
  	   * string CitysName = <CityName>
         And print CitysName
	  * def legalName = temp + 'License'

      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {"businessInfo":{"website":null,"businessEntity":{"individualOrganization":"1","corporateStructure":"1","firstName":'#(temp)',"lastName":"License","middleName":"","suffix":null,"ssn":"","fein":"","legalName":'#(legalName)',"id":0,"isEmployeeForSoleProprietor":null,"individualOrganizationText":null,"corporateStructureText":null,"isIndividual":false},"address":{"addressId":0,"appId":null,"addressLine1":null,"addressLine2":null,"city":null,"stateId":40,"county":null,"zipCode":null,"zip4":null,"street":null,"telephoneNumber":null,"country":"United States (US)","addressTypeId":null,"location":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null,"isActive":null,"showAndHide":null,"roomNo":null,"stateName":"New York","countryId":229,"serialNo":0,"addressType":null,"state":null},"communication":{"email":"automation@test.com","confirmEmail":"automation@test.com","phones":[],"id":0},"id":0,"isLicensed":false,"isAssociated":false},"premisesInfo":{"dba":null,"licensePermitID":null,"address":{"addressId":0,"appId":null,"addressLine1":"Test","addressLine2":null,"city":'#(CitysName)',"stateId":40,"county":"Columbia","zipCode":"11111","zip4":"1111","street":null,"telephoneNumber":null,"country":"United States (US)","addressTypeId":null,"location":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null,"isActive":null,"showAndHide":null,"roomNo":null,"stateName":"New York","countryId":229,"serialNo":0,"addressType":null,"state":null},"communication":{"email":null,"confirmEmail":null,"phones":[],"id":0},"id":0},"applicantDetail":{"masterFileID":null,"mfExpDate":null,"certificateNysTax":null,"certIssueDate":null,"applicantStatement":{"nameOfApplicant":null,"date":null,"title":null,"signature":null,"id":0},"id":0,"isPhysicalChange":null}}
	  When method post
	  Then status 200

	 

# ********* SAVE Application Details To Save *********************
   
    Given path '/internalapi/api/licensing/fees/licenses/get/'+appId
          And header authorization = 'Bearer ' + strToken
          And header Content-Type = 'application/json; charset=utf-8'
   			  And header Accept = 'application/json; text/plain;*/*'
  			  And request ""
			    When method get
			    Then status 200
			     
    And def serverResponse = response
    And def ApplicationId = serverResponse[0].applicationId
    And def appId = serverResponse[0].appId
     And def termActRes = serverResponse[0].term
     And def filingFeesAct = serverResponse[0].filingFees
     And def ancillaryFees = serverResponse[0].ancillaryFees
     And def renewalFees = serverResponse[0].renewalFees
     And def bondFee = serverResponse[0].bondFee
     And def licensingFees = serverResponse[0].licensingFees
    And print serverResponse
    And print 'ApplicationId : ' , ApplicationId 
    And print 'appId : ' , appId
     And print 'term : ' , termActRes
      And print 'filingFeesAct : ' , filingFeesAct
       And print 'licensingFees : ' , licensingFees
       And print 'ancillaryFees : ' , ancillaryFees
       And print 'renewalFees : ' , renewalFees

    #* def InitialLicenseFee = <InitialLicFee>
    # And print InitialLicenseFee
     
     
       #* def CountysId = <countyIds>
        # And print CountysId
       * def BondValue = <bond>
         And print BondValue
       #* string CountysName = <countynames>
         #And print CountysName

     #* def termExp = <NumberOfTerm>
     * def lDesc = <LicDescription>
      #And eval if(InitialLicenseFee=='#notpresent') InitialLicenseFee=0
    * def NonRefundableFilingFee = <NonRefundableFilingFees>
     And print NonRefundableFilingFee
     #And eval if(NonRefundableFilingFee=='#notpresent') NonRefundableFilingFee=0
    * def RenewalFilingFee = <RenewalFilingFees>
    
     #And eval if(RenewalFilingFee=='#notpresent') RenewalFilingFee=0
      And print RenewalFilingFee
    And print 'MainLicense/PermitType ID : ' , mainLicensePermitTypeId, 'Type of License : ' , <LicDescription>,'Application ID : ', ApplicationId,'App ID : ' , appId
        And print 'Licensing Fee Expected Value : ' , licenseFees,'Licensing Fee Actual Response : ' , licensingFees,'Filing Fee Expected Value : ' , fillingFees,'Filing Fee Actual Response : ' , filingFeesAct, 'Term Expected Value : ' , termInYears,'Term Actual Value : ' , termActRes
        
       
       
        * def addLicenseDataOnMismatchedFunc =
			"""
			function(actfilingFees,expfilingFees,actInitialLicenseFee, expInitialLicenseFee,acttermActRes,exptermActRes,actbondFee,expBondValue) {
			   
			        if(actfilingFees != expfilingFees || actInitialLicenseFee != expInitialLicenseFee || acttermActRes != exptermActRes || actbondFee != expBondValue ){
			            karate.log('condition satisfied');
			            return db.appendStrToFile('BeerNWineCityFee.csv' , ('\n'+lDesc+','+productName+','+CitysName+','+actfilingFees+','+expfilingFees+','+actInitialLicenseFee+','+expInitialLicenseFee+','+acttermActRes+','+exptermActRes+','+actbondFee+','+expBondValue));
			        }
	        }
			"""
         * def addLicenseDataOnMismatched = addLicenseDataOnMismatchedFunc(filingFeesAct,fillingFees,licensingFees,licenseFees,termActRes,termInYears,bondFee,BondValue)
               

                * configure continueOnStepFailure = true
                * match filingFeesAct == fillingFees
				* match licenseFees == licensingFees
 		        * match termActRes == termInYears
 		        * match bondFee == BondValue
 		        
 		        #* match renewalFees == RenewalFilingFee
 		        #* match ancillaryFees == AncillaryPrice
  
  

  
			    
  Examples:
   | read('/LicenseInputs/BeerAndWineCityFees.csv') |
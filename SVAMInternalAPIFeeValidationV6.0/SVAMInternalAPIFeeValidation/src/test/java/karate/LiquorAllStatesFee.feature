Feature: GetFeesDetails

Background:
			* url BaseURL
  		* def config = { username: '#(dbUserName)', password:'#(dbUserPassword)', url: '#(dbQuery)',driverClassName: 'com.microsoft.sqlserver.jdbc.SQLServerDriver' }
    	* def DbUtils = Java.type('utils.DbUtils')
    	* def db = new DbUtils(config)

Scenario Outline: Get Fees Details Validation

  * callonce read('LoginDetails.feature') { strToken:'#(strToken)'}

Given path '/internalapi/api/TestFees/createLicenseAppAndGetFees'
    
    
    And header authorization = 'Bearer ' + strToken
    * def mainLicensePermitTypeId = <LicensePermitTypeId>
     And print mainLicensePermitTypeId
    * string ProductType = <ProductTypes>
    And print ProductType
   
    * def InitialLicenseFee = <InitialLicFee>
     And print InitialLicenseFee

		      
       * def CountysId = <countyIds>
         And print CountysId
       * def BondValue = <bond>
         And print BondValue
       * string CountysName = <countynames>
         And print CountysName
      # * string CitysName = <cityz>
         #And print CitysName
     * def termExp = <NumberOfTerm>
     * def lDesc = <LicDescription>
      #And eval if(InitialLicenseFee=='#notpresent') InitialLicenseFee=0
    * def NonRefundableFilingFee = <NonRefundableFilingFees>
     And print NonRefundableFilingFee
     #And eval if(NonRefundableFilingFee=='#notpresent') NonRefundableFilingFee=0
    * def RenewalFilingFee = <RenewalFilingFees>
    
     #And eval if(RenewalFilingFee=='#notpresent') RenewalFilingFee=0
      And print RenewalFilingFee
    #* def AncillaryPrice = <AncillaryFees>
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
     #And eval if(AncillaryPrice=='#notpresent') AncillaryPrice=0
      #And print AncillaryPrice
    And def totalAmount = InitialLicenseFee+NonRefundableFilingFee+RenewalFilingFee
    And print totalAmount
     And request {"mainLicensePermitTypeId":'#(mainLicensePermitTypeId)',"noOfMonths":'#(termExp)',"startDate":'#(dt)',"endDate":'#(dtEnd)',"newPermitTypeIds":[],"combinedCraftId":null,"masterFileId":null,"isApplicableForTempPermit":false,"isNotQualified":false,"isChainRestaurant":false,"addBarList":[],"countyId":'#(CountysId)',"isApplicantCurrentLicensed":false,"isExistingManufacturer":false,"selectedLicense":null}

    When method post
    Then status 200
    And def serverResponse = response
    And def ApplicationId = serverResponse[0].applicationId
    And def appId = serverResponse[0].appId
     And def termActRes = serverResponse[0].term
     And def filingFees = serverResponse[0].filingFees
     And def ancillaryFees = serverResponse[0].ancillaryFees
     And def renewalFees = serverResponse[0].renewalFees
     And def bondFee = serverResponse[0].bondFee
     And def licensingFees = serverResponse[0].licensingFees
    And print serverResponse
    #And print 'ApplicationId : ' , ApplicationId 
    #And print 'appId : ' , appId
     #And print 'term : ' , termActRes
      #And print 'filingFees : ' , filingFees
       #And print 'licensingFees : ' , licensingFees
       #And print 'ancillaryFees : ' , ancillaryFees
       #And print 'renewalFees : ' , renewalFees
        
        And print 'MainLicense/PermitType ID : ' , mainLicensePermitTypeId, 'Type of License : ' , <LicDescription>,'Application ID : ', ApplicationId,'App ID : ' , appId
        And print 'Licensing Fee Expected Value : ' , InitialLicenseFee,'Licensing Fee Actual Response : ' , licensingFees,'Filing Fee Expected Value : ' , NonRefundableFilingFee,'Filing Fee Actual Response : ' , filingFees, 'Term Expected Value : ' , termExp,'Term Actual Value : ' , termActRes
        
       
       
        * def addLicenseDataOnMismatchedFunc =
			"""
			function(actfilingFees,expfilingFees,actInitialLicenseFee, expInitialLicenseFee,acttermActRes,exptermActRes,actbondFee,expBondValue) {
			   
			        if(actfilingFees != expfilingFees || actInitialLicenseFee != expInitialLicenseFee || acttermActRes != exptermActRes || actbondFee != expBondValue ){
			            karate.log('condition not satisfied');
			            return db.appendStrToFile('LiquorAllStatesFee.csv' , ('\n'+lDesc+','+CountysName+','+ProductType+','+actfilingFees+','+expfilingFees+','+actInitialLicenseFee+','+expInitialLicenseFee+','+acttermActRes+','+exptermActRes+','+actbondFee+','+expBondValue));
			        }
	        }
			"""
         * def addLicenseDataOnMismatched = addLicenseDataOnMismatchedFunc(filingFees,NonRefundableFilingFee,licensingFees,InitialLicenseFee,termActRes,termExp,bondFee,BondValue)
    
                * configure continueOnStepFailure = true
                * match filingFees == NonRefundableFilingFee
				* match InitialLicenseFee == licensingFees
 		        * match termActRes == termExp
 		        * match bondFee == BondValue
 		        
 		        #* match renewalFees == RenewalFilingFee
 		        #* match ancillaryFees == AncillaryPrice
  
  

  
			    
  Examples:
   | read('/LicenseInputs/LiquorAllStatesFee.csv') |
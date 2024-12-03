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
     * def termExp = <NumberOfTerm>
     * def lDesc = <LicDescription>
      #And eval if(InitialLicenseFee=='#notpresent') InitialLicenseFee=0
    * def NonRefundableFilingFee = <NonRefundableFilingFees>
     And print NonRefundableFilingFee
     #And eval if(NonRefundableFilingFee=='#notpresent') NonRefundableFilingFee=0
    * def RenewalFilingFee = <RenewalFilingFees>
    
     #And eval if(RenewalFilingFee=='#notpresent') RenewalFilingFee=0
      And print RenewalFilingFee
    * def AncillaryPrice = <AncillaryFees>
    
     #And eval if(AncillaryPrice=='#notpresent') AncillaryPrice=0
      And print AncillaryPrice
    #And def totalAmount = InitialLicenseFee+NonRefundableFilingFee+RenewalFilingFee+AncillaryPrice
    #And print totalAmount
     And request {addBarList: [],combinedCraftId: null,"countyId": '#(CountysId)',endDate: "2022-10-20T18:30:00.000Z",isApplicableForTempPermit: false,isApplicantCurrentLicensed: false,isChainRestaurant: false,isExistingManufacturer: false,isNotQualified: false,"mainLicensePermitTypeId": '#(mainLicensePermitTypeId)',masterFileId: null,newPermitTypeIds: [],noOfMonths: '#(termExp)',selectedLicense: null,startDate: "2022-03-20T18:30:00.000Z"}

    When method post
    Then status 200
    And def serverResponse = response
    And def ApplicationId = serverResponse[0].applicationId
    And def appId = serverResponse[0].appId
     And def termActRes = serverResponse[0].term
     And def filingFees = serverResponse[0].filingFees
     And def ancillaryFees = serverResponse[0].ancillaryFees
     And def renewalFees = serverResponse[0].renewalFees
     And def licensingFees = serverResponse[0].licensingFees
     And def bondFee = serverResponse[0].bondFee
   # And print serverResponse
    #And print 'ApplicationId : ' , ApplicationId 
    #And print 'appId : ' , appId
     #And print 'term : ' , termActRes
      #And print 'filingFees : ' , filingFees
       #And print 'licensingFees : ' , licensingFees
       #And print 'ancillaryFees : ' , ancillaryFees
       #And print 'renewalFees : ' , renewalFees
       
       
       
       And print 'MainLicense/PermitType ID : ' , mainLicensePermitTypeId, 'Type of License : ' , <LicDescription>,'Application ID : ', ApplicationId,'App ID : ' , appId
        And print 'Licensing Fee Expected Value : ' , InitialLicenseFee,'Licensing Fee Actual Response : ' , licensingFees,'Filing Fee Expected Value : ' , NonRefundableFilingFee,'Filing Fee Actual Response : ' , filingFees,'Ancillary Fee Expected Value : ' , AncillaryPrice,'Ancillary Fee Actual Value : ' , ancillaryFees, 'Term Expected Value : ' , termExp,'Term Actual Value : ' , termActRes
                 
        * def addLicenseDataOnMismatchedFunc =
			"""
			function(actfilingFees,expfilingFees,actInitialLicenseFee, expInitialLicenseFee,acttermActRes,exptermActRes,actancillaryFees,expancillaryFees) {
			   
			        if(actfilingFees != expfilingFees || actInitialLicenseFee != expInitialLicenseFee || acttermActRes != exptermActRes || actancillaryFees != expancillaryFees ){
			            karate.log('condition satisfied');
			            return db.appendStrToFile('FeeValidationManufacturing.csv' , ('\n'+lDesc+','+actfilingFees+','+expfilingFees+','+actInitialLicenseFee+','+expInitialLicenseFee+','+acttermActRes+','+exptermActRes+','+actancillaryFees+','+expancillaryFees+','+bondFee+','+BondValue));
			        }
	        }
			"""
        * def addLicenseDataOnMismatched = addLicenseDataOnMismatchedFunc(filingFees,NonRefundableFilingFee,licensingFees,InitialLicenseFee,termActRes,termExp,ancillaryFees,AncillaryPrice)
                
                * configure continueOnStepFailure = true
                * match filingFees == NonRefundableFilingFee
				* match InitialLicenseFee == licensingFees
 		        * match termActRes == termExp
 		        
 		        #* match renewalFees == RenewalFilingFee
 		        * match ancillaryFees == AncillaryPrice
 				* match bondFee == BondValue
  
  

  
			    
  Examples:
   | read('/LicenseInputs/manufacturingFee.csv') |
 
 

   
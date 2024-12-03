Feature: License Methods
Background:
			* url BaseURL
  		* def config = { username: '#(dbUserName)', password:'#(dbUserPassword)', url: '#(dbQuery)',driverClassName: 'com.microsoft.sqlserver.jdbc.SQLServerDriver' }
    	* def DbUtils = Java.type('utils.DbUtils')
    	* def db = new DbUtils(config)
    	* def getDate2 =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		  """
		  * def date = getDate2()
		 * def effectiveDateFunc =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		  """ 
  	  * def effectiveDate = effectiveDateFunc()
  	  
  	  
		  
		* def getYearFunc =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat('yy');
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		  """
		   * def fundDueDateFunc =
		  """
		  function(days) {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
		    
		    var date = new java.util.Date();
		    var dayAfter = new java.util.Date(date.getTime() + java.util.concurrent.TimeUnit.DAYS.toMillis( days));
		    return sdf.format(dayAfter);
		  } 
		  """
		  * def fundDueDate = fundDueDateFunc(7)
		  
		  
	    * def licFeesDate =
			"""
			  function() {
			    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
			    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
			    var date = new java.util.Date();
			    return sdf.format(date);
			  } 
			  
			  
			"""
		* def conditionDefinedDateFunction =
			"""
			  function() {
			    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
			    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.00");
			    var date = new java.util.Date();
			    return sdf.format(date);
			  } 
		  
		  
		"""
		* def conditionDefinedDate = conditionDefinedDateFunction()
		* def conditionDefinedDateFunctionwithAddedDate =
			"""
			  function(days) {
			    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
			     var date = new java.util.Date();
			    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'00:00:00");
			   var dayAfter = new java.util.Date(date.getTime() + java.util.concurrent.TimeUnit.DAYS.toMillis( days));
		      return sdf.format(dayAfter);
			  } 
		  
		  
		"""
		* def licDate =
			"""
			  function() {
			    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
			    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
			    var date = new java.util.Date();
			    return sdf.format(date);
			  } 
		  
		  
		"""		
#********* SignIn *********************


@GetCountyList
Scenario: County List

Given path '/internalapi/api/reference'
   	* def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json;charset=utf-8'
      And header Accept = 'text/plain'
     # * def query = {name:countyzone&onlyActives:true}
 		And params  {name:countyzone,onlyActives:true}
 		#And param onlyActives='true'
     And request {}
	  When method get
	  * configure continueOnStepFailure = true
	  Then status 200
	    And def values = response.values
	* configure continueOnStepFailure = true
	 
	
@ValidateCountyNameList
Scenario Outline: Get CountyName List from CSV
	 * configure continueOnStepFailure = true
	 
	 * def CountyName =  <County>
	 * def countyData = karate.jsonPath(values, "$[?(@.CountyId == '" + <CountyId> + "')]")
	 * def countyZone = countyData[0].ZoneNo
	 * match countyData[0].County == CountyName
Examples:
| read('/CSVFiles/countyList.csv') |

@GetLicensePermitList
Scenario: Get LicensePermit List

Given path '/internalapi/api/reference'
   	* def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json;charset=utf-8'
      And header Accept = 'text/plain'
     
 		And params  {name:licensepermittype,onlyActives:true}
 		
     And request {}
	  When method get
	  * configure continueOnStepFailure = true
	  Then status 200
	    And def values = response.values
	  * call read('UcecasesScenarios.feature@ValidateLicensePermitList') {}
	
@ValidateLicensePermitList
Scenario Outline: Get LicensePermit List from CSV

 And print <LicensePermitTypeId>
	 * configure continueOnStepFailure = true
	 * def licId =  <LicensePermitTypeId>
	 * def licDescription =  <LicDescription>
	 * def expLicenseid = karate.jsonPath(values, "$[?(@.LicPermitTypeId == '" + <LicensePermitTypeId> + "')]")
	 
	 * match expLicenseid[0].Description contains licDescription
Examples:
| read('/CSVFiles/licensesPermitlist.csv') |




@IntakeLicensewithAssociatedTempPermit
Scenario: Intake License Submission
   
   * call read('LicensesCommonMethods.feature@GetCountyList') {}
 	 * def countyData = karate.jsonPath(values, "$[?(@.CountyId == '" + CountyID + "')]")
	  * def countyZone = countyData[0].ZoneNo
	  And print countyZone
	  
   Given path '/internalapi/api/licensing/selectapptype/GetTempPermit'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And configure continueOnStepFailure = true
   	 And request {}
	  When method get
	  * configure continueOnStepFailure = true
	  Then status 200
	    And def licensePermitId = response[0].licensePermitId
	  And print licensePermitId
	  And def licensePermitAppId = response[0].appId
	  And print licensePermitAppId
	  
	# ********* App Intake *********************
 
Given path '/internalapi/api/licensing/selectapptype/savenewlicenseapp'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
     
   	 And request {"mainLicensePermitTypeId":'#(mainLicensePermitTypeId)',"newPermitTypeIds":[],"combinedCraftId":null,"masterFileId":null,"isApplicableForTempPermit":false,"isNotQualified":false,"isChainRestaurant":false,"addBarList":[],"countyId":'#(CountyID)',"isApplicantCurrentLicensed":false,"isExistingManufacturer":false,"selectedLicense":null,"isAssociatedTempPermit":true,"tempLicensePermitId":'#(licensePermitId)'}
	  When method post
	  * configure continueOnStepFailure = true
	  Then status 200
	   
	   And def ApplicationId = response[0].mainApplicationId
	  And print ApplicationId
	  And match ApplicationId contains 'NA-'
	  
	  * def currentYear = '-'+getYearFunc()+'-'+countyZone
	  And match ApplicationId contains currentYear
	  And def description = response[0].description
	 
	   And def appId = response[0].appId
	  
	   * def formId = response[0].formId
	   * def FormVersionId = response[0].FormVersionId
 Given path '/internalapi/api/licensing/app/tree/'+appId
   	* def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And configure continueOnStepFailure = true
   	 And request {}
	  When method get
	  * configure continueOnStepFailure = true
	  Then status 200
	    And def licStatus = response.appStatus
	  And print licStatus
	  And def associatedpermitId = response.items[0].licensePermitId
	   And print associatedpermitId
	    And def lpStatus = response.items[0].lpStatus
	   And print lpStatus
	  And match licStatus == 'Draft'
	  And match associatedpermitId == licensePermitId
	  And match lpStatus == 'Active'
   
  
	  
@IntakeLicensewithoutAssociatedLic
Scenario: Intake License Submission
   
	# ********* App Intake *********************
 	* call read('LicensesCommonMethods.feature@GetCountyList') {}
 	 * def countyData = karate.jsonPath(values, "$[?(@.CountyId == '" + CountyID + "')]")
	  * def countyZone = countyData[0].ZoneNo
	  And print countyZone
	Given path '/internalapi/api/licensing/selectapptype/savenewlicenseapp'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      
   	  And request {"mainLicensePermitTypeId":'#(mainLicensePermitTypeId)',"newPermitTypeIds":[],"combinedCraftId":null,"masterFileId":null,"isApplicableForTempPermit":false,"isNotQualified":false,"isChainRestaurant":false,"addBarList":[],"countyId":'#(CountyID)',"isApplicantCurrentLicensed":false,"isExistingManufacturer":false,"selectedLicense":null,"isAssociatedTempPermit":false}
	  
	  When method post
	  * configure continueOnStepFailure = true
	  Then status 200
	   
	   And def ApplicationId = response[0].mainApplicationId
	  And print ApplicationId
	  And match ApplicationId contains 'NA-'
	 
	  * def currentYear = '-'+getYearFunc()+'-'+countyZone
	  And match ApplicationId contains currentYear
	  And def description = response[0].description
	 
	   And def appId = response[0].appId
	  
	   * def formId = response[0].formId
	   * def FormVersionId = response[0].FormVersionId
	   
	 Given path '/internalapi/api/application/preview/'+appId
	   	* def dbSts = db.cleanHeap()
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;*/*'
	      And configure continueOnStepFailure = true
	   	 And request {}
		  When method get
		  * configure continueOnStepFailure = true
		  Then status 200
		    And def licStatus = response.appStatus.statusDescription
		  And print licStatus
		  And match licStatus == 'Draft'

		  
		  
		  

@IntakeLicensewithApplyForTempPermit
Scenario: IntakeLicensewithApplyForTempRetailPermit
   # ********* App Intake *********************
   * call read('LicensesCommonMethods.feature@GetCountyList') {}
 	 * def countyData = karate.jsonPath(values, "$[?(@.CountyId == '" + CountyID + "')]")
	  * def countyZone = countyData[0].ZoneNo
	  And print countyZone
   Given path '/internalapi/api/licensing/selectapptype/savenewlicenseapp'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
     
   	 And request {"mainLicensePermitTypeId":'#(mainLicensePermitTypeId)',"newPermitTypeIds":[],"combinedCraftId":null,"masterFileId":null,"isApplicableForTempPermit":true,"isNotQualified":true,"notQualifiedReason":"Test Automation","isChainRestaurant":false,"addBarList":[],"tempLicensePermitTypeId":395,"countyId":'#(CountyID)',"isApplicantCurrentLicensed":false,"isExistingManufacturer":false,"selectedLicense":null,"isAssociatedTempPermit":false}
	             
	  When method post
	  * configure continueOnStepFailure = true
	  Then status 200
	   # And match response.length == 2
	  And def tempApplicationId = response[0].mainApplicationId
	  And print tempApplicationId
	  And match tempApplicationId == null
	  And def childAppId = response[0].childAppId
	  And print childAppId
	   And match childAppId != null
	   And def childTempApplicationId = response[0].childApplicationId
	  And print childTempApplicationId
	   And match childTempApplicationId != null
	  
	  
	  And def ApplicationId = response[1].mainApplicationId
	  And print ApplicationId
	  And match ApplicationId contains 'NA-'
	  * def currentYear = '-'+getYearFunc()+'-'+countyZone
	  And match ApplicationId contains currentYear
	 # * def countyData = karate.jsonPath(values, "$[?(@.CountyId == '" + CountyID + "')]")
	 # * def countyZone = countyData[0].ZoneNo
	 
     
	  And match ApplicationId != null
	  
	  And def childAppId = response[1].childAppId
	  And print childAppId
	   And match childAppId == null
	  And def appId = response[1].appId
	  And print appId
	   And match appId != null
	   
	   
  Given path '/internalapi/api/licensing/app/tree/'+appId
   	* def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And configure continueOnStepFailure = true
   	 And request {}
	  When method get
	  * configure continueOnStepFailure = true
	  Then status 200
	    And def licStatus = response.appStatus
	  And print licStatus
	  And def mainApplicationID = response.applicationId
	  And print mainApplicationID
	  And def tempPermitApplicationID = response.items[0].applicationId
	   And print tempPermitApplicationID
	    And def appStatus = response.items[0].appStatus
	   And print appStatus
	  And match appStatus == 'Draft'
	  And match tempPermitApplicationID == childTempApplicationId
	   And match mainApplicationID == ApplicationId
	  And match licStatus == 'Draft'
	   		 

@IntakeAdditionalSeasonalBarLicensewithoutTempPermit
Scenario: IntakeAdditionalSeasonalBarLicensewithoutTempPermit
   # ********* App Intake *********************
   * call read('LicensesCommonMethods.feature@GetCountyList') {}
 	 * def countyData = karate.jsonPath(values, "$[?(@.CountyId == '" + CountyID + "')]")
	  * def countyZone = countyData[0].ZoneNo
	  And print countyZone
   Given path '/internalapi/api/licensing/selectapptype/savenewlicenseapp'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
     
   	 And request {"mainLicensePermitTypeId":223,"newPermitTypeIds":[],"combinedCraftId":null,"masterFileId":null,"isApplicableForTempPermit":false,"isNotQualified":false,"notQualifiedReason":"","isChainRestaurant":false,"addBarList":[{"associatedLicenseTypeId":447,"noOfBars":5,"isSeasonal":true,"season":"Winter","isTempPermitRequired":false}],"countyId":1,"isApplicantCurrentLicensed":false,"isExistingManufacturer":false,"selectedLicense":null,"isAssociatedTempPermit":false}
	  When method post
	  * configure continueOnStepFailure = true
	  Then status 200
	  * def count = response.length
	  And match count == 6
	   And def appId = response[5].appId
	  And print appId
	  And match appId != null
	  And def ApplicationId1 = response[0].mainApplicationId
	  And print ApplicationId1
	  
	  And match ApplicationId1 == null
	  And def ApplicationId2 = response[1].mainApplicationId
	  And print ApplicationId2
	  And match ApplicationId2 == null
	  And def ApplicationId3 = response[2].mainApplicationId
	  And print ApplicationId3
	  And match ApplicationId3 == null
	  And def ApplicationId4 = response[3].mainApplicationId
	  And print ApplicationId4
	  And match ApplicationId4 == null
	  And def ApplicationId5 = response[4].mainApplicationId
	  And print ApplicationId5
	  And match ApplicationId5 == null
	  
	  And def ApplicationId = response[5].mainApplicationId
	  And print ApplicationId
	  And match ApplicationId contains 'NA-'
	  * def currentYear = '-'+getYearFunc()+'-'+countyZone
	  And match ApplicationId contains currentYear
	  And match ApplicationId != null
	  
	  
	   And def childAppId1 = response[0].childAppId
	  And print childAppId1
	  And match childAppId1 != null
	  And def childAppId2 = response[1].childAppId
	  And print childAppId2
	  And match childAppId2 != null
	  And def childAppId3 = response[2].childAppId
	  And print childAppId3
	  And match childAppId3 != null
	  And def childAppId4 = response[3].childAppId
	  And print childAppId4
	  And match childAppId4 != null
	  And def childAppId5 = response[4].childAppId
	  And print childAppId5
	  And match childAppId5 != null
	  
	  And def childAppId = response[5].childAppId
	  And print childAppId
	  And match childAppId == null
	  
	  And def childApplicationId1 = response[0].childApplicationId
	  And print childApplicationId1
	  And match childApplicationId1 != null
	  And def childApplicationId2 = response[1].childApplicationId
	  And print childApplicationId2
	  And match childApplicationId2 != null
	  And def childApplicationId3 = response[2].childApplicationId
	  And print childApplicationId3
	  And match childApplicationId3 != null
	  And def childApplicationId4 = response[3].childApplicationId
	  And print childApplicationId4
	  And match childApplicationId4 != null
	  And def childApplicationId5 = response[4].childApplicationId
	  And print childApplicationId5
	  And match childApplicationId5 != null
	  
	   And def childApplicationId = response[5].childApplicationId
	  And print childApplicationId
	  And match childApplicationId == null
	   
  Given path '/internalapi/api/licensing/app/tree/'+appId
   	* def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And configure continueOnStepFailure = true
   	 And request {}
	  When method get
	  * configure continueOnStepFailure = true
	  Then status 200
	    And def licStatus = response.appStatus
	  And print licStatus
	  And def mainApplicationID = response.applicationId
	  And print mainApplicationID
	  And match mainApplicationID == ApplicationId
	  And match licStatus == 'Draft'
	  
	  
	  And def additionalBarid1 = response.items[0].applicationId
	   And print additionalBarid1
	    And def additionalBarAppStatus1 = response.items[0].appStatus
	   And print additionalBarAppStatus1
	  And match additionalBarAppStatus1 == 'Draft'
	  And match additionalBarid1 == childApplicationId1
	  
	  And def additionalBarid2 = response.items[1].applicationId
	   And print additionalBarid2
	    And def additionalBarAppStatus2 = response.items[1].appStatus
	   And print additionalBarAppStatus2
	  And match additionalBarAppStatus2 == 'Draft'
	  And match additionalBarid2 == childApplicationId2
	  
	  And def additionalBarid3 = response.items[2].applicationId
	   And print additionalBarid3
	    And def additionalBarAppStatus2 = response.items[2].appStatus
	   And print additionalBarAppStatus2
	  And match additionalBarAppStatus2 == 'Draft'
	  And match additionalBarid3 == childApplicationId3
	  
	  And def additionalBarid4 = response.items[3].applicationId
	   And print additionalBarid4
	    And def additionalBarAppStatus4 = response.items[3].appStatus
	   And print additionalBarAppStatus4
	  And match additionalBarAppStatus4 == 'Draft'
	  And match additionalBarid4 == childApplicationId4
	  
	  And def additionalBarid5 = response.items[4].applicationId
	   And print additionalBarid5
	    And def additionalBarAppStatus5 = response.items[4].appStatus
	   And print additionalBarAppStatus5
	  And match additionalBarAppStatus5 == 'Draft'
	  And match additionalBarid5 == childApplicationId5
	  
	  

@IntakeAdditionalBarLicensewithTempPermit
Scenario: IntakeAdditionalBarLicensewithTempPermit
   # ********* App Intake *********************
   * call read('LicensesCommonMethods.feature@GetCountyList') {}
 	 * def countyData = karate.jsonPath(values, "$[?(@.CountyId == '" + CountyID + "')]")
	  * def countyZone = countyData[0].ZoneNo
	  And print countyZone
   Given path '/internalapi/api/licensing/selectapptype/savenewlicenseapp'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
     
   	 And request {"mainLicensePermitTypeId":223,"newPermitTypeIds":[],"combinedCraftId":null,"masterFileId":null,"isApplicableForTempPermit":true,"isNotQualified":false,"isChainRestaurant":false,"addBarList":[{"associatedLicenseTypeId":282,"durationInMonths":0,"noOfBars":2,"tempLicensePermitTypeId":395,"isTempPermitRequired":true}],"tempLicensePermitTypeId":395,"countyId":'#(CountyID)',"isApplicantCurrentLicensed":false,"isExistingManufacturer":false,"selectedLicense":null,"isAssociatedTempPermit":false}
	  When method post
	  * configure continueOnStepFailure = true
	  Then status 200
	  * def count = response.length
	  And match count == 6
	   And def appId = response[5].appId
	  And print appId
	  And match appId != null
	  And def ApplicationId1 = response[0].mainApplicationId
	  And print ApplicationId1
	  And match ApplicationId1 == null
	  And def ApplicationId2 = response[1].mainApplicationId
	  And print ApplicationId2
	  And match ApplicationId2 == null
	  And def ApplicationId3 = response[2].mainApplicationId
	  And print ApplicationId3
	  And match ApplicationId3 == null
	  And def ApplicationId4 = response[3].mainApplicationId
	  And print ApplicationId4
	  And match ApplicationId4 == null
	  And def ApplicationId5 = response[4].mainApplicationId
	  And print ApplicationId5
	  And match ApplicationId5 == null
	  
	  And def ApplicationId = response[5].mainApplicationId
	  And print ApplicationId
	  And match ApplicationId contains 'NA-'
	  * def currentYear = '-'+getYearFunc()+'-'+countyZone
	  And match ApplicationId contains currentYear
	  And match ApplicationId != null
	  * def formId = response[5].formId
	  
	   And def childAppId1 = response[0].childAppId
	  And print childAppId1
	  And match childAppId1 != null
	  And def childAppId2 = response[1].childAppId
	  And print childAppId2
	  And match childAppId2 != null
	  And def childAppId3 = response[2].childAppId
	  And print childAppId3
	  And match childAppId3 != null
	  And def childAppId4 = response[3].childAppId
	  And print childAppId4
	  And match childAppId4 != null
	  And def childAppId5 = response[4].childAppId
	  And print childAppId5
	  And match childAppId5 != null
	  
	  And def childAppId = response[5].childAppId
	  And print childAppId
	  And match childAppId == null
	  
	  And def childApplicationId1 = response[0].childApplicationId
	  And print childApplicationId1
	  And match childApplicationId1 != null
	  And def childApplicationId2 = response[1].childApplicationId
	  And print childApplicationId2
	  And match childApplicationId2 != null
	  And def childApplicationId3 = response[2].childApplicationId
	  And print childApplicationId3
	  And match childApplicationId3 != null
	  And def childApplicationId4 = response[3].childApplicationId
	  And print childApplicationId4
	  And match childApplicationId4 != null
	  And def childApplicationId5 = response[4].childApplicationId
	  And print childApplicationId5
	  And match childApplicationId5 != null
	  
	   And def childApplicationId = response[5].childApplicationId
	  And print childApplicationId
	  And match childApplicationId == null
	   
  Given path '/internalapi/api/licensing/app/tree/'+appId
   	* def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And configure continueOnStepFailure = true
   	 And request {}
	  When method get
	  * configure continueOnStepFailure = true
	  Then status 200
	    And def licStatus = response.appStatus
	  And print licStatus
	  And def mainApplicationID = response.applicationId
	  And print mainApplicationID
	  And match mainApplicationID == ApplicationId
	  And match licStatus == 'Draft'
	  
	  
	  And def additionalBarid1 = response.items[0].applicationId
	   And print additionalBarid1
	    And def additionalBarAppStatus1 = response.items[0].appStatus
	   And print additionalBarAppStatus1
	  And match additionalBarAppStatus1 == 'Draft'
	  And match additionalBarid1 == childApplicationId1
	  
	  And def additionalBarid2 = response.items[1].applicationId
	   And print additionalBarid2
	    And def additionalBarAppStatus2 = response.items[1].appStatus
	   And print additionalBarAppStatus2
	  And match additionalBarAppStatus2 == 'Draft'
	  And match additionalBarid2 == childApplicationId2
	  
	  And def additionalBarid3 = response.items[1].items[0].applicationId
	   And print additionalBarid3
	    And def additionalBarAppStatus3 = response.items[1].items[0].appStatus
	   And print additionalBarAppStatus3
	  And match additionalBarAppStatus2 == 'Draft'
	  And match additionalBarid3 == childApplicationId3
	  
	  And def additionalBarid4 = response.items[2].applicationId
	   And print additionalBarid4
	    And def additionalBarAppStatus4 = response.items[2].appStatus
	   And print additionalBarAppStatus4
	  And match additionalBarAppStatus4 == 'Draft'
	  And match additionalBarid4 == childApplicationId4
	  
	  And def additionalBarid5 = response.items[2].items[0].applicationId
	   And print additionalBarid5
	    And def additionalBarAppStatus5 = response.items[2].items[0].appStatus
	   And print additionalBarAppStatus5
	  And match additionalBarAppStatus5 == 'Draft'
	  And match additionalBarid5 == childApplicationId5	   
	  
	  
	  
	  
@FillAndSaveApplicantInformationPage
Scenario: FillApplicantInformationPage	  
	* def getDate =
	    """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat('yyyyMMddHHmmss');
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		"""
	Given path '/internalapi/api/licensing/app/static/applicantinfo/save/'+appId
      	And header Content-Type = 'application/json; charset=utf-8'
  	  	
		* def autoFirstName = firstName + getDate()
		* def legalName1 = autoFirstName + lastName
		And header Accept = 'application/json; text/plain;*/*'
       	And header authorization = 'Bearer ' + strToken
      	And request {"businessInfo":{"website":null,"businessEntity":{"individualOrganization":'#(indOrgCode)',"corporateStructure":'#(CorporateStructureDropDownCode)',"firstName":'#(autoFirstName)',"lastName":'#(lastName)',"middleName":"AutoMidName","suffix":"1","ssn":"","fein":"","legalName":'#(legalName1)',"id":0,"isEmployeeForSoleProprietor":null,"individualOrganizationText":'#(IndOrgSelectionDropDown)',"corporateStructureText":'#(CorporateStructureDropDown)',"isIndividual":'#(isIndStatus)'},"address":{"addressId":0,"appId":null,"addressLine1":'#(Address1)',"addressLine2":'#(Address2)',"city":'#(CityName)',"stateId":'#(stateCode)',"county":'#(CountyName)',"zipCode":'#(zipCode)',"zip4":'#(postalCode)',"street":null,"telephoneNumber":null,"country":'#(countryName)',"addressTypeId":null,"location":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null,"isActive":null,"showAndHide":null,"roomNo":null,"stateName":'#(CityName)',"countryId":229,"serialNo":0,"addressType":null,"state":null},"communication":{"email":'#(emailId)',"confirmEmail":'#(emailId)',"phones":[{"phoneType":"3","phoneTypeText":"Mobile","phone":'#(PhoneNumber)',"countryCode":'#(countryCode)',"phoneExtension":'#(PhoneExtn)',"phoneId":0}],"id":0},"id":0,"isLicensed":false,"isAssociated":false},"premisesInfo":{"dba":null,"licensePermitID":null,"address":{"addressId":0,"appId":null,"addressLine1":'#(Address1)',"addressLine2":'#(Address2)',"city":'#(CityName)',"stateId":'#(stateCode)',"county":'#(CountyName)',"zipCode":'#(zipCode)',"zip4":'#(postalCode)',"street":null,"telephoneNumber":null,"country":'#(countryName)',"addressTypeId":null,"location":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null,"isActive":null,"showAndHide":null,"roomNo":null,"stateName":'#(CityName)',"countryId":229,"serialNo":0,"addressType":null,"state":null},"communication":{"email":'#(emailId)',"confirmEmail":'#(emailId)',"phones":[{"phoneType":"2","phoneTypeText":"Office","phone":'#(PhoneNumber)',"countryCode":'#(countryCode)',"phoneExtension":'#(PhoneExtn)',"phoneId":0}],"id":0],"id":0},"id":0},"applicantDetail":{"masterFileID":null,"mfExpDate":null,"certificateNysTax":null,"certIssueDate":null,"applicantStatement":{"nameOfApplicant":null,"date":null,"title":null,"signature":null,"id":0},"id":0,"isPhysicalChange":null}}
	   	When method post
	  	Then status 200
	 	
	  
	  
@FillAndSavePrincipalPage
Scenario: FillAndSavePrincipalPage		  
   	* def getDate1 =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat('yyyyMMddHHmmss');
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		  """
	Given path '/internalapi/api/licensing/app/static/principal/save/'+appId
	    And header Content-Type = 'application/json; charset=utf-8'
  	   	* def prncipalName = firstName + getDate1()
  	   	* def dt = licDate()
		And header Accept = 'application/json; text/plain;*/*'
	    And header authorization = 'Bearer ' + strToken
	   And request {"entities":[],"principals":[{"principalId":0,"convictedOfCrime":'#(convictedOfCrime)',"percentageOfOwners":'#(percentageOfOwners)',"isFingerprintRequired":'#(isFingerprintRequired)',"isFingerprintsApproved":'#(isFingerprintsApproved)',"title":"15","numberOfShares":"","isSignature":false,"date":'#(dt)',"address":{"addressLine1":'#(Address1)',"addressLine2":'#(Address2)',"stateId":'#(stateCode)',"county":'#(CountyName)',"city":"New York","zipCode":'#(zipCode)',"zip4":'#(postalCode)',"country":'#(countryName)',"stateName":'#(CityName)',"countryId":229,"zip":'#(zipCode)'},"person":{"personId":0,"firstName":'#(prncipalName)',"middleName":"AutoMidName","lastName":"AutoLastName","suffix":"1","socialSecurityNo":"","birthDate":'#(dt)',"age":"","choosedEntity":null,"ssnFormat":"","suffixText":"JR"},"isIndividualsPartnersAssociatedWithEntity":"","communication":{"id":0,"phones":[],"email":'#(emailId)',"confirmEmail":'#(emailId)'},"titleText":"Vice President","convictedOfCrimeText":"No","disableFlags":"{\"isExisitingPrincipal\":false,\"isExistingPrincipalInBusiness\":false,\"isRenewalAndAmendPrincipal\":false,\"isNewPrincipal\":true}","isAssociated":false}]}
	   
		When method post
		Then status 200
	  
   
	  
@FillAndSaveRepresentativePage
Scenario: FillAndSaveRepresentativePage	  
  # ********* Representative ********************* 
    Given path '/internalapi/api/licensing/app/static/rep/save/'+appId
	    And header authorization = 'Bearer ' + strToken
	   	And request {"id":0,"contactType":"1","otherContactType":null,"selfCertified":null,"nysRegistrationNumber":null,"areYouBeingCompensated":null,"otherDescription":"Test Desc","subjectOfAppearance":null,"compensationType":null,"address":{"addressLine1":"1 wall street","addressLine2":"","county":'#(CountyName)',"city":'#(CityName)',"zipCode":"10011","country":"United States (US)","stateName":'#(CityName)',"countryId":229,"stateId":40},"isSelfCertifiedApplication":null,"person":{"personId":"0","isIndividualsPartnersAssociatedWithEntity":"","firstName":"Automation","middleName":"","lastName":"Automation","suffix":"","socialSecurityNo":"","birthDate":"","email":"","age":"","choosedEntity":""},"communication":{"email":"sbandi@svam.com","confirmEmail":"sbandi@svam.com","phones":[],"id":0},"phoneDetails":{"phoneType":"","countryCode":"","phone":"","phoneExtension":"","phoneId":0},"contactTypeText":"","isLicensed":""}
	   	When method post
	    Then status 200
	    And def serverResponse = response
   
@FillAndSaveRightToPrimisePage
Scenario: FillAndSaveRightToPrimisePage  
 # ********* Right to Premise ********************* 
    Given path '/internalapi/api/licensing/app/save'
	    And header authorization = 'Bearer ' + strToken
	    And request {"isApproved":false,"appId":'#(appId)',"formID":'#(formId)',"applicationID":"","formName":'#(description)',"formType":{},"formTypeId":null,"applicationType":{},"applicationTypeId":null,"formCategory":{},"formCategoryId":null,"approvalFlag":null,"status":"","createdBy":"","createdDate":"","modifiedBy":"","sections":[{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1957,"key":"","label":"By what right does the applicant have possession of the premises?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1958,"key":"","label":"Explain","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"No","fieldID":1959,"key":"","label":"Do the terms of the lease or other arrangement require the applicant to provide any consideration based on a percentage of the receipts of the business?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1960,"key":"","label":"If yes, list the section/page of the lease this information can be found","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"No","fieldID":1961,"key":"","label":"Does or will anyone other than the applicant/principals share on a percentage basis or in any way in the receipts, losses, or deficiencies of the business to any extent whatsoever","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1226,"sectionName":"","key":"0","label":"Right to Premises","order":5,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"Robert","fieldID":1685,"key":"","label":"","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1686,"key":"","label":"","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"Pascal","fieldID":1687,"key":"","label":"","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"1 wall street","fieldID":1697,"key":"","label":"","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1698,"key":"","label":"","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":'#(CityName)',"fieldID":1699,"key":"","label":"","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"1","fieldID":1700,"key":"","label":"","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"10011","fieldID":1701,"key":"","label":"","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1754,"key":"","label":"","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1934,"key":"","label":"","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1935,"key":"","label":"","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1218,"sectionName":"","key":"0","label":"Other Interested","order":1,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]}],"sectionFieldOrders":[]}],"formVersionId":1231,"version":7,"licenseDescription":"","statusDescription":"Draft","appStatusId":1,"showApplicant":true,"showRepresentative":true,"showPrincipal":true,"showLandlord":true,"showVehicles":false,"showSchedule":false,"staticTabSequence":{"Applicant Information":0,"Principal":1,"Representative":2,"Landlord Identification":3,"Personal Questionnaire":4},"staticTaborder":["Applicant Information","Principal","Representative","Landlord Identification","Personal Questionnaire"],"showPQ":true}
	    When method post
	    Then status 200
	    And def serverResponse = response

@FeesValidation
Scenario: FeesValidation     
	Given path '/internalapi/api/licensing/fees/licenses/get/'+appId
      And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {}
	  When method get
	  Then status 200
	  And def serverResponse = response
	  * def licTerm = serverResponse[0].term
	  * def licFees = serverResponse[0].licensingFees+''
	  * def licTermDesc = serverResponse[0].termDesc
	  * def licFeesRefId =  serverResponse[0].feesRefId
	  * def licAncillaryFees = serverResponse[0].ancillaryFees+''
	  * def licfilingFees = serverResponse[0].filingFees+''
	  * def licInitialFees = serverResponse[0].initialFees
	  * def bndFees = serverResponse[0].bondFee
	  * def isBondRequired = serverResponse[0].isBondRequired
	  And def totalFees = serverResponse[0].licensingFees+serverResponse[0].filingFees
	  And print totalFees  
	  * def underpaidAmount = totalFees-amount
	  * def amountPaid = amount+''
	  And print 'underpaidAmount- ',underpaidAmount
	  
	  
 	Given path '/internalapi/api/notification/SaveNotification'
      
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {"applicant":{"communicationId":8531,"email":'#(emailId)',"appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"}
	  When method post
	  Then status 200
	  And print response
	  
	  
	
	  
	  Given path 'internalapi/api/licensing/fees/details/save/'+appId+'/false'
      And header Content-Type = 'application/json; charset=utf-8'
  	  * def futureDateFunc =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
		    
		    var date = new java.util.Date();
		    var dayAfter = new java.util.Date(date.getTime() + java.util.concurrent.TimeUnit.DAYS.toMillis( 30 ));
		    return sdf.format(dayAfter);
		  } 
		  """
		  
		 
		   
  	   
  	  
	  * def futureDate = futureDateFunc()
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
     			  
      And request {"checks":[{"appId":'#(appId)',"slaintakeDate":'#(date)',"applyClick":false,"paymentSource":"RDC","checkNo":"1","batchNo":1,"itemNo":1,"slareceivedDate":'#(date)',"amount":'#(amountPaid)'}],"appFees":{"appFees":[{"licenseName":'#(description)',"applicationId":'#(ApplicationId)',"applicationTypeId":1,"appFeesId":0,"appId":'#(appId)',"feesRefId":'#(licFeesRefId)',"initialFees":0,"licensingFees":'#(licenseFees)',"amendmentFees":"0.00","renewalFees":"0.00","totalFees":'#(totalFees)',"filingFees":'#(licfilingFees)',"ancillaryFees":"0.00","isFeesWaived":false,"underPaymentAmount":'#(totalFees)',"amountReceived":"0.00","waivedComment":null,"isBondReceived":'#(isBondRequired)',"isBondRequired":'#(isBondRequired)',"bondFee":'#(bndFees)',"term":'#(licTerm)',"termDesc":'#(licTermDesc)',"seasonalStartDate":null,"seasonalEndDate":null,"isFeesCountBased":false,"isFeesUnitBased":false,"numOfUnits":0,"paymentDetails":[],"lateFee":0,"isFeesBarPerDay":null}],"bondDetails":null,"isPaymentFailed":false,"isUnderpaid":true,"sendNotification":false,"fundDueDate":'#(fundDueDate)',"emailNotificationDetail":{"applicant":{"communicationId":15102,"email":'#(emailId)',"appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"}},"notificationDetails":{"applicant":{"communicationId":15102,"email":'#(emailId)',"appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"},"taskId":null}
     When method post
	  Then status 200

  Given path 'internalapi/api/licensing/fees/check-payments/get/'+appId
    And header authorization = 'Bearer ' + strToken
    And request {}
    When method get
    Then status 200
    And def checkDetailId = response[0].checkDetailId
    And print checkDetailId
 
   Given path '/internalapi/api/licensing/fees/details/save/'+appId+'/false'
      And header Content-Type = 'application/json; charset=utf-8'
  	  * def futureDateFunc =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
		    
		    var date = new java.util.Date();
		    var dayAfter = new java.util.Date(date.getTime() + java.util.concurrent.TimeUnit.DAYS.toMillis( 30 ));
		    return sdf.format(dayAfter);
		  } 
		  """
 	* def futureDate = futureDateFunc()
		   * def getDate2 =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		  """
  	  * def date = getDate2()

      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {"checks":[{"appId":'#(appId)',"slaintakeDate":'#(date)',"applyClick":false,"paymentSource":"RDC","checkNo":"1","batchNo":1,"itemNo":1,"slareceivedDate":'#(date)',"amount":'#(totalFees)'}],"appFees":{"appFees":[{"licenseName":'#(description)',"applicationId":'#(ApplicationId)',"applicationTypeId":1,"appFeesId":0,"appId":'#(appId)',"feesRefId":'#(licFeesRefId)',"initialFees":'#(licInitialFees)',"licensingFees":'#(licenseFees)',"amendmentFees":"0.00","renewalFees":'#(renewalFees)',"totalFees":'#(totalFees)',"filingFees":'#(licfilingFees)',"ancillaryFees":'#(licAncillaryFees)',"isFeesWaived":false,"underPaymentAmount":'#(totalFees)',"amountReceived":"0.00","waivedComment":null,"isBondReceived":'#(isBondRequired)',"isBondRequired":'#(isBondRequired)',"bondFee":'#(bndFees)',"term":'#(termInYears)',"termDesc":'#(termDesc)',"seasonalStartDate":null,"seasonalEndDate":null,"isFeesCountBased":false,"isFeesUnitBased":false,"numOfUnits":0,"paymentDetails":[],"lateFee":0,"isFeesBarPerDay":null}],"bondDetails":null,"isPaymentFailed":false,"isUnderpaid":true,"sendNotification":false,"fundDueDate":'#(fundDueDate)',"emailNotificationDetail":{"applicant":{"communicationId":8531,"email":'#(emailId)',"appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"}},"notificationDetails":{"applicant":{"communicationId":8531,"email":'#(emailId)',"appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"},"taskId":null}
	 			  
	 
	  When method post
	  Then status 200
	 

   
   

# ********* SAVE Application Details To Save *********************
    Given path '/internalapi/api/licensing/app/save'
    And header authorization = 'Bearer ' + strToken
    And request {"isApproved":false,"appId":'#(appId)',"formID":'#(formId)',"applicationID":'#(ApplicationId)',"formName":'#(description)',"formType":{},"formTypeId":null,"applicationType":{},"applicationTypeId":null,"formCategory":{},"formCategoryId":null,"approvalFlag":null,"status":"","createdBy":"","createdDate":"","modifiedBy":"","sections":[{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1842,"key":"","label":"Signature","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1843,"key":"","label":"Date","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1851,"key":"","label":"Title","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"dropdown","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2232,"key":"","label":"First Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2233,"key":"","label":"Middle Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2234,"key":"","label":"Last Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1200,"sectionName":"","key":"0","label":"Applicant Statement","order":9,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1957,"key":"","label":"By what right does the applicant have possession of the premises?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1958,"key":"","label":"Explain","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1959,"key":"","label":"Do the terms of the lease or other arrangement require the applicant to provide any consideration based on a percentage of the receipts of the business?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1960,"key":"","label":"If yes, list the section/page of the lease this information can be found","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1961,"key":"","label":"Does or will anyone other than the applicant/principals share on a percentage basis or in any way in the receipts, losses, or deficiencies of the business to any extent whatsoever","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1226,"sectionName":"","key":"0","label":"Right to Premises","order":5,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1685,"key":"","label":"First Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1686,"key":"","label":"Middle Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1687,"key":"","label":"Last Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"1 wall street","fieldID":1697,"key":"","label":"Address Line 1/ POB #","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":6,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1698,"key":"","label":"Address Line 2","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":7,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":'#(CityName)',"fieldID":1699,"key":"","label":"City","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":8,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1700,"key":"","label":"State/Region","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":9,"controlType":"dropdown","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"10011","fieldID":1701,"key":"","label":"Zip/Postal Code","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":10,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1754,"key":"","label":"Address","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"label","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1934,"key":"","label":"Nature of Interest","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1935,"key":"","label":"Date acquired","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1218,"sectionName":"","key":"0","label":"Other Interested","order":1,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]}],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1933,"key":"","label":"Signature","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1936,"key":"","label":"Date","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1239,"sectionName":"","key":"0","label":"Bulletin 254","order":10,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2053,"key":"","label":"Describe the area where the premises is to be located","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2054,"key":"","label":"State what the area is zoned for","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2055,"key":"","label":"Provide a description of the premises to be licensed. Describe all building/structures that will be utilized in business operations including the number of floors in each.","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2056,"key":"","label":"has the building/premises been known by any other address?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2057,"key":"","label":"If yes, please Specify","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2058,"key":"","label":"has the premises to be licensed and or any other floor in the building been previously licensed or currently licensed to traffic in alcoholic beverages?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2059,"key":"","label":"What was the prior use of the premises to be licensed?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":6,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2060,"key":"","label":"Does the proposed location of the business comply with all state and local regulations and zoning codes?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":7,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2061,"key":"","label":"is there interior access to any other floor that will not be part of the licensed premises?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":8,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2062,"key":"","label":"if yes, list floor and means of access to each floor.","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":9,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2063,"key":"","label":"Does any other person have access to this area?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":10,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2064,"key":"","label":"where will the alcohol be stored","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":11,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2065,"key":"","label":"if applying for a farm winery license, special farm winery license or micro winery license, the premises must be located on a farm. In the box below, please provide a detailed description of the agricultural production that qualifies the premises as a farm","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":12,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1248,"sectionName":"","key":"0","label":"Premises Questionnaire","order":7,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1988,"key":"","label":"Will any other business of any kind be conducted on said premises?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1989,"key":"","label":"How many Employees?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1990,"key":"","label":"If answer is 0, provide explanation","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1991,"key":"","label":"Workers' Compensation Carrier Name and Policy Number?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1992,"key":"","label":"Disability Insurance Carrier name and policy Number","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2050,"key":"","label":"Check all activities the business will engage in","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"checkbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1249,"sectionName":"","key":"0","label":"Method of Operation","order":8,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2072,"key":"","label":"Real Property","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2073,"key":"","label":"Purchase/Contract Price of Business","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2074,"key":"","label":"Renovations/Improvement Costs","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2075,"key":"","label":"Miscellaneous","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2076,"key":"","label":"Cash","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"label","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2077,"key":"","label":"Source of Funds","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2078,"key":"","label":"Personal Questionnaire attached","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":6,"controlType":"checkbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2079,"key":"","label":"Dollar Amount","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":7,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2080,"key":"","label":"Total Cash","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":8,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2081,"key":"","label":"Borrowed","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":9,"controlType":"label","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2082,"key":"","label":"Source of Funds","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":10,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2083,"key":"","label":"Personal Questionnaire attached","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":11,"controlType":"checkbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2084,"key":"","label":"Dollar Amount","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":12,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2085,"key":"","label":"Total Borrowed","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":13,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2086,"key":"","label":"Total Investment","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":14,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2087,"key":"","label":"Have all investors been disclosed in this application","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":15,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1253,"sectionName":"","key":"0","label":"Financial Disclosure","order":6,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]}],"formVersionId":1231,"version":7,"licenseDescription":"","statusDescription":"Draft","appStatusId":1,"showApplicant":true,"showRepresentative":true,"showPrincipal":true,"showLandlord":true,"showVehicles":false,"showSchedule":false,"staticTabSequence":{"Applicant Information":0,"Principal":1,"Representative":2,"Landlord Identification":3,"Personal Questionnaire":4},"staticTaborder":["Applicant Information","Principal","Representative","Landlord Identification","Personal Questionnaire"],"showPQ":true}
    When method post
    Then status 200
   
    
    Given path '/internalapi/api/licensing/fees/licenses/get/'+appId
        And header authorization = 'Bearer ' + strToken
        And header Content-Type = 'application/json; charset=utf-8'
   		And header Accept = 'application/json; text/plain;*/*'
  		And request ""
		When method get
		Then status 200
		And print response[0].appFeesId
		And def appFeesId1 = response[0].appFeesId
		And def feesRefId1 = response[0].feesRefId
		And print appFeesId1
		And print feesRefId1 
		And def applicationTypeId = response[0].applicationTypeId
		And print applicationTypeId 
# ********* Save PAYMENT ********************* 
    
    Given path '/internalapi/api/licensing/fees/details/save/'+appId +'/false'
     
		* def slaDate = licFeesDate()
		* def slaaDate = licDate()
		* def licInitialFees1 = licInitialFees+''
		And print licInitialFees1
		* def renewalFees1 = renewalFees+''
		And print renewalFees1
		* def totalFees1 = totalFees+''
		
		And print totalFees1
		* def licAncillaryFees1 = licAncillaryFees+''
		* def licfilingFees1 = licfilingFees+''
		
		And header authorization = 'Bearer ' + strToken 
		And  request {"checks":[{"checkDetailId":'#(checkDetailId)',"appId":'#(appId)',"paymentSource":"RDC","checkNo":"1","batchNo":"1","itemNo":"1","slareceivedDate":'#(date)',"slaintakeDate":'#(date)',"amount":'#(amountPaid)',"appliedTo":null,"amountUsed":'#(amountPaid)',"comment":null,"isReplacement":null,"replacementReason":null,"isActive":true,"createdBy":"tgupta@svam.com","createdDate":'#(date)',"modifiedBy":null,"modifiedDate":null,"applyClick":true,"amountAvailable":0}],"appFees":{"appFees":[{"licenseName":'#(description)',"applicationId":'#(ApplicationId)',"applicationTypeId":1,"appFeesId":'#(licFeesRefId)',"appId":'#(appId)',"feesRefId":'#(licFeesRefId)',"initialFees":0,"licensingFees":'#(licenseFees)',"amendmentFees":"0.00","renewalFees":"0.00","totalFees":'#(totalFees1)',"filingFees":'#(licfilingFees1)',"ancillaryFees":"0.00","isFeesWaived":false,"underPaymentAmount":'#(underpaidAmount)',"amountReceived":'#(amountPaid)',"waivedComment":null,"isBondReceived":'#(isBondRequired)',"isBondRequired":'#(isBondRequired)',"bondFee":'#(bndFees)',"term":'#(termInYears)',"termDesc":'#(termDesc)',"seasonalStartDate":null,"seasonalEndDate":null,"isFeesCountBased":false,"isFeesUnitBased":false,"numOfUnits":0,"paymentDetails":[{"appId":'#(appId)',"checkDetailId":'#(checkDetailId)',"checkNo":"1","itemNo":"1","batchNo":"1","amountAppliedForApp":'#(amountPaid)',"amount":0}],"lateFee":0,"isFeesBarPerDay":null}],"bondDetails":null,"isPaymentFailed":false,"isUnderpaid":false,"sendNotification":false,"fundDueDate":'#(fundDueDate)',"emailNotificationDetail":{"applicant":{"communicationId":15102,"email":'#(emailId)',"appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"}},"notificationDetails":{"applicant":{"communicationId":15102,"email":'#(emailId)',"appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"},"taskId":null}
		  
		
	    
		
		When method post
	    Then status 200
	    And print response
    
    	
    
# ********* SAVE Application Details To Save *********************
    Given path '/internalapi/api/licensing/app/save'
	    And header authorization = 'Bearer ' + strToken
	    And request {"isApproved":false,"appId":'#(appId)',"formID":'#(formId)',"applicationID":'#(ApplicationId)',"formName":'#(description)',"formType":{},"formTypeId":null,"applicationType":{},"applicationTypeId":null,"formCategory":{},"formCategoryId":null,"approvalFlag":null,"status":"","createdBy":"","createdDate":"","modifiedBy":"","sections":[{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1842,"key":"","label":"Signature","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1843,"key":"","label":"Date","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1851,"key":"","label":"Title","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"dropdown","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2232,"key":"","label":"First Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2233,"key":"","label":"Middle Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2234,"key":"","label":"Last Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1200,"sectionName":"","key":"0","label":"Applicant Statement","order":9,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1957,"key":"","label":"By what right does the applicant have possession of the premises?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1958,"key":"","label":"Explain","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1959,"key":"","label":"Do the terms of the lease or other arrangement require the applicant to provide any consideration based on a percentage of the receipts of the business?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1960,"key":"","label":"If yes, list the section/page of the lease this information can be found","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1961,"key":"","label":"Does or will anyone other than the applicant/principals share on a percentage basis or in any way in the receipts, losses, or deficiencies of the business to any extent whatsoever","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1226,"sectionName":"","key":"0","label":"Right to Premises","order":5,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1685,"key":"","label":"First Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1686,"key":"","label":"Middle Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1687,"key":"","label":"Last Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"1 wall street","fieldID":1697,"key":"","label":"Address Line 1/ POB #","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":6,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1698,"key":"","label":"Address Line 2","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":7,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":'#(CityName)',"fieldID":1699,"key":"","label":"City","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":8,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1700,"key":"","label":"State/Region","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":9,"controlType":"dropdown","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"10011","fieldID":1701,"key":"","label":"Zip/Postal Code","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":10,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1754,"key":"","label":"Address","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"label","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1934,"key":"","label":"Nature of Interest","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1935,"key":"","label":"Date acquired","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1218,"sectionName":"","key":"0","label":"Other Interested","order":1,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]}],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1933,"key":"","label":"Signature","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1936,"key":"","label":"Date","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1239,"sectionName":"","key":"0","label":"Bulletin 254","order":10,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2053,"key":"","label":"Describe the area where the premises is to be located","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2054,"key":"","label":"State what the area is zoned for","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2055,"key":"","label":"Provide a description of the premises to be licensed. Describe all building/structures that will be utilized in business operations including the number of floors in each.","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2056,"key":"","label":"has the building/premises been known by any other address?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2057,"key":"","label":"If yes, please Specify","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2058,"key":"","label":"has the premises to be licensed and or any other floor in the building been previously licensed or currently licensed to traffic in alcoholic beverages?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2059,"key":"","label":"What was the prior use of the premises to be licensed?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":6,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2060,"key":"","label":"Does the proposed location of the business comply with all state and local regulations and zoning codes?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":7,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2061,"key":"","label":"is there interior access to any other floor that will not be part of the licensed premises?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":8,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2062,"key":"","label":"if yes, list floor and means of access to each floor.","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":9,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2063,"key":"","label":"Does any other person have access to this area?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":10,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2064,"key":"","label":"where will the alcohol be stored","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":11,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2065,"key":"","label":"if applying for a farm winery license, special farm winery license or micro winery license, the premises must be located on a farm. In the box below, please provide a detailed description of the agricultural production that qualifies the premises as a farm","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":12,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1248,"sectionName":"","key":"0","label":"Premises Questionnaire","order":7,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1988,"key":"","label":"Will any other business of any kind be conducted on said premises?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1989,"key":"","label":"How many Employees?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1990,"key":"","label":"If answer is 0, provide explanation","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1991,"key":"","label":"Workers' Compensation Carrier Name and Policy Number?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1992,"key":"","label":"Disability Insurance Carrier name and policy Number","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2050,"key":"","label":"Check all activities the business will engage in","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"checkbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1249,"sectionName":"","key":"0","label":"Method of Operation","order":8,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2072,"key":"","label":"Real Property","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2073,"key":"","label":"Purchase/Contract Price of Business","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2074,"key":"","label":"Renovations/Improvement Costs","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2075,"key":"","label":"Miscellaneous","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2076,"key":"","label":"Cash","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"label","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2077,"key":"","label":"Source of Funds","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2078,"key":"","label":"Personal Questionnaire attached","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":6,"controlType":"checkbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2079,"key":"","label":"Dollar Amount","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":7,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2080,"key":"","label":"Total Cash","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":8,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2081,"key":"","label":"Borrowed","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":9,"controlType":"label","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2082,"key":"","label":"Source of Funds","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":10,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2083,"key":"","label":"Personal Questionnaire attached","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":11,"controlType":"checkbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2084,"key":"","label":"Dollar Amount","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":12,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2085,"key":"","label":"Total Borrowed","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":13,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2086,"key":"","label":"Total Investment","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":14,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2087,"key":"","label":"Have all investors been disclosed in this application","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":15,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1253,"sectionName":"","key":"0","label":"Financial Disclosure","order":6,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]}],"formVersionId":1231,"version":7,"licenseDescription":"","statusDescription":"Draft","appStatusId":1,"showApplicant":true,"showRepresentative":true,"showPrincipal":true,"showLandlord":true,"showVehicles":false,"showSchedule":false,"staticTabSequence":{"Applicant Information":0,"Principal":1,"Representative":2,"Landlord Identification":3,"Personal Questionnaire":4},"staticTaborder":["Applicant Information","Principal","Representative","Landlord Identification","Personal Questionnaire"],"showPQ":true}
	    When method post
	    Then status 200
	    And def serverResponse = response
	    



@FeesValidationwithMultipleChecks
Scenario: FeesValidationwithMultipleChecks     
	Given path '/internalapi/api/licensing/fees/licenses/get/'+appId
      And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {}
	  When method get
	  Then status 200
	  And def serverResponse = response
	  * def licTerm = serverResponse[0].term
	  * def licFees = serverResponse[0].licensingFees+''
	  * def licTermDesc = serverResponse[0].termDesc
	  * def licFeesRefId =  serverResponse[0].feesRefId
	  * def licAncillaryFees = serverResponse[0].ancillaryFees+''
	  * def licfilingFees = serverResponse[0].filingFees+''
	  * def licInitialFees = serverResponse[0].initialFees
	  * def bndFees = serverResponse[0].bondFee
	  * def isBondRequired = serverResponse[0].isBondRequired
	  And def totalFees = serverResponse[0].licensingFees+serverResponse[0].filingFees
	  And print totalFees  
	  * def underpaidAmount = totalFees-(amount+100)
	  * def amountPaid = amount+''
	  And print 'underpaidAmount- ',underpaidAmount
	  
	  
 	Given path '/internalapi/api/notification/SaveNotification'
      
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {"applicant":{"communicationId":8531,"email":'#(emailId)',"appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"}
	  When method post
	  Then status 200
	  And print response
	  
	  
	  
	  Given path 'internalapi/api/licensing/fees/details/save/'+appId+'/false'
      And header Content-Type = 'application/json; charset=utf-8'
  	  * def futureDateFunc =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
		    
		    var date = new java.util.Date();
		    var dayAfter = new java.util.Date(date.getTime() + java.util.concurrent.TimeUnit.DAYS.toMillis( 30 ));
		    return sdf.format(dayAfter);
		  } 
		  """
		  
		 
		   * def getDate2 =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		  """
		  
  	  * def date = getDate2()
  	   
  	  
	  * def futureDate = futureDateFunc()
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
       			  
      And request {"checks":[{"appId":'#(appId)',"slaintakeDate":'#(date)',"applyClick":false,"paymentSource":"RDC","checkNo":"1","batchNo":1,"itemNo":1,"slareceivedDate":'#(date)',"amount":100},{"appId":'#(appId)',"slaintakeDate":'#(date)',"applyClick":false,"paymentSource":"RDC","checkNo":"2","batchNo":1,"itemNo":1,"slareceivedDate":'#(date)',"amount":'#(amountPaid)'}],"appFees":{"appFees":[{"licenseName":'#(description)',"applicationId":'#(ApplicationId)',"applicationTypeId":1,"appFeesId":0,"appId":'#(appId)',"feesRefId":'#(licFeesRefId)',"initialFees":0,"licensingFees":'#(licenseFees)',"amendmentFees":"0.00","renewalFees":"0.00","totalFees":"580.00","filingFees":'#(licfilingFees)',"ancillaryFees":'#(licAncillaryFees)',"isFeesWaived":false,"underPaymentAmount":'#(totalFees)',"amountReceived":"0.00","waivedComment":null,"isBondReceived":false,"isBondRequired":'#(isBondRequired)',"bondFee":'#(bndFees)',"term":'#(licTerm)',"termDesc":'#(licTermDesc)',"seasonalStartDate":null,"seasonalEndDate":null,"isFeesCountBased":false,"isFeesUnitBased":false,"numOfUnits":0,"paymentDetails":[],"lateFee":0,"isFeesBarPerDay":null}],"isFromReturnedCheck":false,"bondDetails":null,"isPaymentFailed":false,"isUnderpaid":true,"sendNotification":false,"fundDueDate":'#(fundDueDate)',"emailNotificationDetail":{"applicant":{"communicationId":15102,"email":'#(emailId)',"appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"}},"notificationDetails":{"applicant":{"communicationId":15102,"email":'#(emailId)',"appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"},"taskId":null}
    
     When method post
	  Then status 200

  Given path 'internalapi/api/licensing/fees/check-payments/get/'+appId
    And header authorization = 'Bearer ' + strToken
    And request {}
    When method get
    Then status 200
    And def checkDetailId = response[0].checkDetailId
    And print checkDetailId
    And def checkDetailId1 = response[1].checkDetailId
    And print checkDetailId1
 
   
    Given path '/internalapi/api/licensing/fees/licenses/get/'+appId
        And header authorization = 'Bearer ' + strToken
        And header Content-Type = 'application/json; charset=utf-8'
   		And header Accept = 'application/json; text/plain;*/*'
  		And request ""
		When method get
		Then status 200
		And print response[0].appFeesId
		And def appFeesId1 = response[0].appFeesId
		And def feesRefId1 = response[0].feesRefId
		And print appFeesId1
		And print feesRefId1 
		And def applicationTypeId = response[0].applicationTypeId
		And print applicationTypeId 
# ********* Save PAYMENT ********************* 
    
    Given path '/internalapi/api/licensing/fees/details/save/'+appId +'/false'
     
		* def slaDate = licFeesDate()
		* def slaaDate = licDate()
		* def licInitialFees1 = licInitialFees+''
		And print licInitialFees1
		* def renewalFees1 = renewalFees+''
		And print renewalFees1
		* def totalFees1 = totalFees+''
		
		And print totalFees1
		* def licAncillaryFees1 = licAncillaryFees+''
		* def licfilingFees1 = licfilingFees+''
			
	    And header authorization = 'Bearer ' + strToken
		And request {"checks":[{"checkDetailId":'#(checkDetailId)',"appId":'#(appId)',"paymentSource":"RDC","checkNo":"1","batchNo":"1","itemNo":"1","slareceivedDate":'#(date)',"slaintakeDate":'#(date)',"amount":100,"appliedTo":null,"amountUsed":100,"comment":null,"isReplacement":null,"replacementReason":null,"isActive":true,"createdBy":"tgupta@svam.com","createdDate":'#(date)',"modifiedBy":null,"modifiedDate":null,"applyClick":true,"amountAvailable":0},{"checkDetailId":'#(checkDetailId1)',"appId":'#(appId)',"paymentSource":"RDC","checkNo":"2","batchNo":"1","itemNo":"1","slareceivedDate":'#(date)',"slaintakeDate":'#(date)',"amount":'#(amountPaid)',"appliedTo":null,"amountUsed":0,"comment":null,"isReplacement":null,"replacementReason":null,"isActive":true,"createdBy":"tgupta@svam.com","createdDate":'#(date)',"modifiedBy":null,"modifiedDate":null,"applyClick":true,"amountAvailable":'#(amountPaid)'}],"appFees":{"appFees":[{"licenseName":'#(description)',"applicationId":'#(ApplicationId)',"applicationTypeId":1,"appFeesId":'#(licFeesRefId)',"appId":'#(appId)',"feesRefId":'#(licFeesRefId)',"initialFees":0,"licensingFees":'#(licenseFees)',"amendmentFees":"0.00","renewalFees":"0.00","totalFees":'#(totalFees1)',"filingFees":'#(licfilingFees1)',"ancillaryFees":'#(licAncillaryFees)',"isFeesWaived":false,"underPaymentAmount":0,"amountReceived":'#(amountPaid)',"waivedComment":null,"isBondReceived":false,"isBondRequired":'#(isBondRequired)',"bondFee":'#(bndFees)',"term":'#(termInYears)',"termDesc":'#(termDesc)',"seasonalStartDate":null,"seasonalEndDate":null,"isFeesCountBased":false,"isFeesUnitBased":false,"numOfUnits":0,"paymentDetails":[{"appId":'#(appId)',"checkDetailId":'#(checkDetailId)',"checkNo":"1","itemNo":"1","batchNo":"1","amountAppliedForApp":"100.00","amount":0},{"appId":'#(appId)',"checkDetailId":'#(checkDetailId1)',"checkNo":"2","itemNo":"1","batchNo":"1","amountAppliedForApp":'#(amountPaid)',"amount":0}],"lateFee":0,"isFeesBarPerDay":null}],"isFromReturnedCheck":false,"bondDetails":null,"isPaymentFailed":false,"isUnderpaid":false,"sendNotification":true,"fundDueDate":'#(fundDueDate)',"emailNotificationDetail":{"applicant":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"}},"notificationDetails":{"applicant":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"},"taskId":null}
		
		#{"checks":[{"checkDetailId":'#(checkDetailId)',"appId":'#(appId)',"paymentSource":"RDC","checkNo":"1","batchNo":"1","itemNo":"1","slareceivedDate":'#(date)',"slaintakeDate":'#(date)',"amount":'#(amountPaid)',"appliedTo":null,"amountUsed":'#(amountPaid)',"comment":null,"isReplacement":null,"replacementReason":null,"isActive":true,"createdBy":"tgupta@svam.com","createdDate":'#(date)',"modifiedBy":null,"modifiedDate":null,"applyClick":true,"amountAvailable":0}],"appFees":{"appFees":[{"licenseName":'#(description)',"applicationId":'#(ApplicationId)',"applicationTypeId":1,"appFeesId":'#(licFeesRefId)',"appId":'#(appId)',"feesRefId":'#(licFeesRefId)',"initialFees":0,"licensingFees":'#(licenseFees)',"amendmentFees":"0.00","renewalFees":"0.00","totalFees":'#(totalFees1)',"filingFees":'#(licfilingFees1)',"ancillaryFees":"0.00","isFeesWaived":false,"underPaymentAmount":'#(underpaidAmount)',"amountReceived":'#(amountPaid)',"waivedComment":null,"isBondReceived":'#(isBondRequired)',"isBondRequired":'#(isBondRequired)',"bondFee":'#(bndFees)',"term":'#(termInYears)',"termDesc":'#(termDesc)',"seasonalStartDate":null,"seasonalEndDate":null,"isFeesCountBased":false,"isFeesUnitBased":false,"numOfUnits":0,"paymentDetails":[{"appId":'#(appId)',"checkDetailId":'#(checkDetailId)',"checkNo":"1","itemNo":"1","batchNo":"1","amountAppliedForApp":'#(amountPaid)',"amount":0}],"lateFee":0,"isFeesBarPerDay":null}],"bondDetails":null,"isPaymentFailed":false,"isUnderpaid":false,"sendNotification":false,"fundDueDate":'#(fundDueDate)',"emailNotificationDetail":{"applicant":{"communicationId":15102,"email":'#(emailId)',"appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"}},"notificationDetails":{"applicant":{"communicationId":15102,"email":'#(emailId)',"appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"},"taskId":null}
When method post
	    Then status 200
	    And print response
    
    
    
# ********* SAVE Application Details To Save *********************
    Given path '/internalapi/api/licensing/app/save'
	    And header authorization = 'Bearer ' + strToken
	    And request {"isApproved":false,"appId":'#(appId)',"formID":'#(formId)',"applicationID":'#(ApplicationId)',"formName":'#(description)',"formType":{},"formTypeId":null,"applicationType":{},"applicationTypeId":null,"formCategory":{},"formCategoryId":null,"approvalFlag":null,"status":"","createdBy":"","createdDate":"","modifiedBy":"","sections":[{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1842,"key":"","label":"Signature","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1843,"key":"","label":"Date","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1851,"key":"","label":"Title","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"dropdown","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2232,"key":"","label":"First Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2233,"key":"","label":"Middle Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2234,"key":"","label":"Last Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1200,"sectionName":"","key":"0","label":"Applicant Statement","order":9,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1957,"key":"","label":"By what right does the applicant have possession of the premises?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1958,"key":"","label":"Explain","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1959,"key":"","label":"Do the terms of the lease or other arrangement require the applicant to provide any consideration based on a percentage of the receipts of the business?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1960,"key":"","label":"If yes, list the section/page of the lease this information can be found","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1961,"key":"","label":"Does or will anyone other than the applicant/principals share on a percentage basis or in any way in the receipts, losses, or deficiencies of the business to any extent whatsoever","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1226,"sectionName":"","key":"0","label":"Right to Premises","order":5,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1685,"key":"","label":"First Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1686,"key":"","label":"Middle Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1687,"key":"","label":"Last Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"1 wall street","fieldID":1697,"key":"","label":"Address Line 1/ POB #","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":6,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1698,"key":"","label":"Address Line 2","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":7,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":'#(CityName)',"fieldID":1699,"key":"","label":"City","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":8,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1700,"key":"","label":"State/Region","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":9,"controlType":"dropdown","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"10011","fieldID":1701,"key":"","label":"Zip/Postal Code","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":10,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1754,"key":"","label":"Address","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"label","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1934,"key":"","label":"Nature of Interest","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1935,"key":"","label":"Date acquired","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1218,"sectionName":"","key":"0","label":"Other Interested","order":1,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]}],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1933,"key":"","label":"Signature","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1936,"key":"","label":"Date","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1239,"sectionName":"","key":"0","label":"Bulletin 254","order":10,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2053,"key":"","label":"Describe the area where the premises is to be located","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2054,"key":"","label":"State what the area is zoned for","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2055,"key":"","label":"Provide a description of the premises to be licensed. Describe all building/structures that will be utilized in business operations including the number of floors in each.","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2056,"key":"","label":"has the building/premises been known by any other address?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2057,"key":"","label":"If yes, please Specify","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2058,"key":"","label":"has the premises to be licensed and or any other floor in the building been previously licensed or currently licensed to traffic in alcoholic beverages?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2059,"key":"","label":"What was the prior use of the premises to be licensed?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":6,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2060,"key":"","label":"Does the proposed location of the business comply with all state and local regulations and zoning codes?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":7,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2061,"key":"","label":"is there interior access to any other floor that will not be part of the licensed premises?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":8,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2062,"key":"","label":"if yes, list floor and means of access to each floor.","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":9,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2063,"key":"","label":"Does any other person have access to this area?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":10,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2064,"key":"","label":"where will the alcohol be stored","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":11,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2065,"key":"","label":"if applying for a farm winery license, special farm winery license or micro winery license, the premises must be located on a farm. In the box below, please provide a detailed description of the agricultural production that qualifies the premises as a farm","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":12,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1248,"sectionName":"","key":"0","label":"Premises Questionnaire","order":7,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1988,"key":"","label":"Will any other business of any kind be conducted on said premises?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1989,"key":"","label":"How many Employees?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1990,"key":"","label":"If answer is 0, provide explanation","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1991,"key":"","label":"Workers' Compensation Carrier Name and Policy Number?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1992,"key":"","label":"Disability Insurance Carrier name and policy Number","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2050,"key":"","label":"Check all activities the business will engage in","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"checkbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1249,"sectionName":"","key":"0","label":"Method of Operation","order":8,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2072,"key":"","label":"Real Property","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2073,"key":"","label":"Purchase/Contract Price of Business","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2074,"key":"","label":"Renovations/Improvement Costs","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2075,"key":"","label":"Miscellaneous","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2076,"key":"","label":"Cash","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"label","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2077,"key":"","label":"Source of Funds","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2078,"key":"","label":"Personal Questionnaire attached","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":6,"controlType":"checkbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2079,"key":"","label":"Dollar Amount","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":7,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2080,"key":"","label":"Total Cash","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":8,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2081,"key":"","label":"Borrowed","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":9,"controlType":"label","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2082,"key":"","label":"Source of Funds","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":10,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2083,"key":"","label":"Personal Questionnaire attached","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":11,"controlType":"checkbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2084,"key":"","label":"Dollar Amount","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":12,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2085,"key":"","label":"Total Borrowed","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":13,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2086,"key":"","label":"Total Investment","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":14,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2087,"key":"","label":"Have all investors been disclosed in this application","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":15,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1253,"sectionName":"","key":"0","label":"Financial Disclosure","order":6,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]}],"formVersionId":1231,"version":7,"licenseDescription":"","statusDescription":"Draft","appStatusId":1,"showApplicant":true,"showRepresentative":true,"showPrincipal":true,"showLandlord":true,"showVehicles":false,"showSchedule":false,"staticTabSequence":{"Applicant Information":0,"Principal":1,"Representative":2,"Landlord Identification":3,"Personal Questionnaire":4},"staticTaborder":["Applicant Information","Principal","Representative","Landlord Identification","Personal Questionnaire"],"showPQ":true}
	    When method post
	    Then status 200
	    And def serverResponse = response
	    
	    
	    
	    

@WaveFeesValidation
Scenario: WaveFeesValidation

  
    Given path 'internalapi/api/licensing/app/static/applicantinfo/'+appId
      And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {}
	  When method get
	  Then status 200
	  And def serverResponse = response
	  * def applicaintInfoCommID = serverResponse.businessInfo.communication.id
	  And print applicaintInfoCommID
	  * def applicaintInfoEmailId = serverResponse.businessInfo.communication.email
	  
	 Given path '/internalapi/api/licensing/app/static/rep/'+appId
      And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {}
	  When method get
	  Then status 200
	  And def serverResponse = response
	  * def attorneyCommID = serverResponse.communication.id
	  And print attorneyCommID
	  * def attorneyEmailId = serverResponse.communication.email 
	Given path '/internalapi/api/licensing/fees/licenses/get/'+appId
      And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {}
	  When method get
	  Then status 200
	  And def serverResponse = response
	  * def licTerm = serverResponse[0].term
	  * def licFees = serverResponse[0].licensingFees+'.00'
	  * def licTermDesc = serverResponse[0].termDesc
	  * def licFeesRefId =  serverResponse[0].feesRefId
	  * def licAncillaryFees = serverResponse[0].ancillaryFees+'.00'
	  * def licfilingFees = serverResponse[0].filingFees+'.00'
	  * def licInitialFees = serverResponse[0].initialFees | 0
	  * def bndFees = serverResponse[0].bondFee | 0
	  * def isBondRequired = serverResponse[0].isBondRequired
	  And def totalFees1 = serverResponse[0].licensingFees+serverResponse[0].filingFees
	  And print totalFees1
	 * def tFees = totalFees1+'.00'
	  * def underpaidAmount = totalFees1 | 0
	  
	 
   Given path '/internalapi/api/licensing/fees/details/save/'+appId+'/false'
      And header Content-Type = 'application/json'
      And header current-wfroleid = '3'
  	  * def futureDateFunc =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
		    
		    var date = new java.util.Date();
		    var dayAfter = new java.util.Date(date.getTime() + java.util.concurrent.TimeUnit.DAYS.toMillis(7 ));
		    return sdf.format(dayAfter);
		  } 
		  """
 	* def futureDate = futureDateFunc()
		   * def getDate2 =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		  """
  	  * def date = getDate2()
		
      And header Accept = 'application/json'
      And header authorization = 'Bearer ' + strToken
      #And request {"checks":[],"appFees":{"appFees":[{"licenseName":'#(description)',"applicationId":'#(ApplicationId)',"applicationTypeId":1,"appFeesId":0,"appId":'#(appId)',"feesRefId":'#(licFeesRefId)',"initialFees":'#(licInitialFees)',"licensingFees":'#(licFees)',"amendmentFees":"0.00","renewalFees":'0.00',"totalFees":'#(tFees)',"filingFees":'#(licfilingFees)',"ancillaryFees":'#(licAncillaryFees)',"isFeesWaived":true,"underPaymentAmount":'#(totalFees1)',"amountReceived":0,"waivedComment":"Waived fee for automation testing","isBondReceived":false,"isBondRequired":'#(isBondRequired)',"bondFee":'#(bndFees)',"term":'#(termInYears)',"termDesc":'#(termDesc)',"seasonalStartDate":null,"seasonalEndDate":null,"isFeesCountBased":false,"isFeesUnitBased":false,"numOfUnits":0,"paymentDetails":[],"lateFee":0,"isFeesBarPerDay":null}],"isFromReturnedCheck":false,"bondDetails":null,"isPaymentFailed":false,"isUnderpaid":false,"sendNotification":false,"fundDueDate":'#(fundDueDate)',"emailNotificationDetail":{"applicant":{"communicationId":24387,"email":'#(emailId)',"appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun Gupta"}},"notificationDetails":{"applicant":{"communicationId":24387,"email":'#(emailId)',"appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"},"taskId":null}
	  And request {"checks":[],"appFees":{"appFees":[{"licenseName":'#(description)',"applicationId":'#(ApplicationId)',"applicationTypeId":1,"appFeesId":0,"appId":'#(appId)',"feesRefId":'#(licFeesRefId)',"initialFees":'#(licInitialFees)',"licensingFees":'#(licFees)',"amendmentFees":"0.00","renewalFees":"0.00","totalFees":'#(tFees)',"filingFees":'#(licfilingFees)',"ancillaryFees":'#(licAncillaryFees)',"isFeesWaived":true,"underPaymentAmount":'#(underpaidAmount)',"amountReceived":0,"waivedComment":"Waived fee for automation testing","isBondReceived":false,"isBondRequired":'#(isBondRequired)',"bondFee":'#(bndFees)',"term":'#(termInYears)',"termDesc":'#(termDesc)',"seasonalStartDate":null,"seasonalEndDate":null,"isFeesCountBased":false,"isFeesUnitBased":false,"numOfUnits":0,"paymentDetails":[],"lateFee":0,"isFeesBarPerDay":null}],"isFromReturnedCheck":false,"bondDetails":null,"isPaymentFailed":false,"isUnderpaid":false,"sendNotification":false,"fundDueDate":'#(fundDueDate)',"emailNotificationDetail":{"applicant":{"communicationId":'#(applicaintInfoCommID)',"email":'#(applicaintInfoEmailId)',"appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":'#(attorneyCommID)',"email":'#(attorneyEmailId)',"appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)'}},"notificationDetails":{"applicant":{"communicationId":'#(applicaintInfoCommID)',"email":'#(applicaintInfoEmailId)',"appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":'#(attorneyCommID)',"email":'#(attorneyEmailId)',"appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)'},"taskId":null}
	  When method post
	  Then status 200
	  
	 
   	

# ********* SAVE Application Details To Save *********************
    Given path '/internalapi/api/licensing/app/save'
    And header authorization = 'Bearer ' + strToken
    And request {"isApproved":false,"appId":'#(appId)',"formID":'#(formId)',"applicationID":'#(ApplicationId)',"formName":'#(description)',"formType":{},"formTypeId":null,"applicationType":{},"applicationTypeId":null,"formCategory":{},"formCategoryId":null,"approvalFlag":null,"status":"","createdBy":"","createdDate":"","modifiedBy":"","sections":[{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1842,"key":"","label":"Signature","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1843,"key":"","label":"Date","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1851,"key":"","label":"Title","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"dropdown","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2232,"key":"","label":"First Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2233,"key":"","label":"Middle Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2234,"key":"","label":"Last Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1200,"sectionName":"","key":"0","label":"Applicant Statement","order":9,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1957,"key":"","label":"By what right does the applicant have possession of the premises?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1958,"key":"","label":"Explain","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1959,"key":"","label":"Do the terms of the lease or other arrangement require the applicant to provide any consideration based on a percentage of the receipts of the business?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1960,"key":"","label":"If yes, list the section/page of the lease this information can be found","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1961,"key":"","label":"Does or will anyone other than the applicant/principals share on a percentage basis or in any way in the receipts, losses, or deficiencies of the business to any extent whatsoever","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1226,"sectionName":"","key":"0","label":"Right to Premises","order":5,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1685,"key":"","label":"First Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1686,"key":"","label":"Middle Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1687,"key":"","label":"Last Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"1 wall street","fieldID":1697,"key":"","label":"Address Line 1/ POB #","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":6,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1698,"key":"","label":"Address Line 2","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":7,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":'#(CityName)',"fieldID":1699,"key":"","label":"City","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":8,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1700,"key":"","label":"State/Region","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":9,"controlType":"dropdown","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"10011","fieldID":1701,"key":"","label":"Zip/Postal Code","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":10,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1754,"key":"","label":"Address","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"label","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1934,"key":"","label":"Nature of Interest","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1935,"key":"","label":"Date acquired","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1218,"sectionName":"","key":"0","label":"Other Interested","order":1,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]}],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1933,"key":"","label":"Signature","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1936,"key":"","label":"Date","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1239,"sectionName":"","key":"0","label":"Bulletin 254","order":10,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2053,"key":"","label":"Describe the area where the premises is to be located","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2054,"key":"","label":"State what the area is zoned for","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2055,"key":"","label":"Provide a description of the premises to be licensed. Describe all building/structures that will be utilized in business operations including the number of floors in each.","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2056,"key":"","label":"has the building/premises been known by any other address?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2057,"key":"","label":"If yes, please Specify","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2058,"key":"","label":"has the premises to be licensed and or any other floor in the building been previously licensed or currently licensed to traffic in alcoholic beverages?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2059,"key":"","label":"What was the prior use of the premises to be licensed?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":6,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2060,"key":"","label":"Does the proposed location of the business comply with all state and local regulations and zoning codes?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":7,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2061,"key":"","label":"is there interior access to any other floor that will not be part of the licensed premises?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":8,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2062,"key":"","label":"if yes, list floor and means of access to each floor.","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":9,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2063,"key":"","label":"Does any other person have access to this area?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":10,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2064,"key":"","label":"where will the alcohol be stored","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":11,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2065,"key":"","label":"if applying for a farm winery license, special farm winery license or micro winery license, the premises must be located on a farm. In the box below, please provide a detailed description of the agricultural production that qualifies the premises as a farm","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":12,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1248,"sectionName":"","key":"0","label":"Premises Questionnaire","order":7,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1988,"key":"","label":"Will any other business of any kind be conducted on said premises?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1989,"key":"","label":"How many Employees?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1990,"key":"","label":"If answer is 0, provide explanation","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1991,"key":"","label":"Workers' Compensation Carrier Name and Policy Number?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1992,"key":"","label":"Disability Insurance Carrier name and policy Number","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2050,"key":"","label":"Check all activities the business will engage in","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"checkbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1249,"sectionName":"","key":"0","label":"Method of Operation","order":8,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2072,"key":"","label":"Real Property","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2073,"key":"","label":"Purchase/Contract Price of Business","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2074,"key":"","label":"Renovations/Improvement Costs","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2075,"key":"","label":"Miscellaneous","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2076,"key":"","label":"Cash","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"label","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2077,"key":"","label":"Source of Funds","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2078,"key":"","label":"Personal Questionnaire attached","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":6,"controlType":"checkbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2079,"key":"","label":"Dollar Amount","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":7,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2080,"key":"","label":"Total Cash","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":8,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2081,"key":"","label":"Borrowed","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":9,"controlType":"label","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2082,"key":"","label":"Source of Funds","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":10,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2083,"key":"","label":"Personal Questionnaire attached","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":11,"controlType":"checkbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2084,"key":"","label":"Dollar Amount","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":12,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2085,"key":"","label":"Total Borrowed","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":13,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2086,"key":"","label":"Total Investment","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":14,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2087,"key":"","label":"Have all investors been disclosed in this application","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":15,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1253,"sectionName":"","key":"0","label":"Financial Disclosure","order":6,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]}],"formVersionId":1231,"version":7,"licenseDescription":"","statusDescription":"Draft","appStatusId":1,"showApplicant":true,"showRepresentative":true,"showPrincipal":true,"showLandlord":true,"showVehicles":false,"showSchedule":false,"staticTabSequence":{"Applicant Information":0,"Principal":1,"Representative":2,"Landlord Identification":3,"Personal Questionnaire":4},"staticTaborder":["Applicant Information","Principal","Representative","Landlord Identification","Personal Questionnaire"],"showPQ":true}
    When method post
    Then status 200
     Given path '/internalapi/api/licensing/fees/licenses/get/'+appId
      And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {}
	  When method get
	  Then status 200
	  And def serverResponse = response
	  * def isFeesWaivedStatus = serverResponse[0].isFeesWaived
	   * def waivedCommentSt = serverResponse[0].waivedComment
	    * def waivedUnderPaymentAmount = serverResponse[0].underPaymentAmount
	    * def waivedTotalFees = serverResponse[0].totalFees
       And match isFeesWaivedStatus == true
       And match waivedUnderPaymentAmount == 0
       And match waivedTotalFees == 0
       And match waivedCommentSt == 'Waived fee for automation testing'
      
   
@SubmitLicenseAndValidateLicStatus
Scenario: SubmitLicenseAndValidateLicStatus 
# ********* Application SUBMIT ********************* 
   Given path '/internalapi/api/licensing/app/submit'
	    And header authorization = 'Bearer ' + strToken
	    And request {"appId":'#(appId)',"wfType":null}
	    When method post
	    Then status 200
	    And def serverResponse = response
		And match response.success == true
		* call read('LicensesCommonMethods.feature@checkApplicationStatus') {}
  
  
@AssignApplicationsToExaminer
Scenario: AssignApplicationsToExaminer
 # ********* AssignApplicationsToExaminer *********************
    Given path '/internalapi/api/licensing/examiner/assignApplicationsToExaminer'
	    And header authorization = 'Bearer ' + strToken
	    And request [{"appId":'#(appId)',"examinerId":1069,"priority":"Normal"}]
	    When method post
	    And def serverResponse = response
   		* call read('LicensesCommonMethods.feature@checkApplicationStatus') {}

@ExaminerReviewApprovalToLB
Scenario: ExaminerReviewApprovalToLB  
 # ********* Examiner Review Approval to LB *********************
	 * def summisionDate =
		"""
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } """
    Given path '/internalapi/api/licensing/examiner-review/SaveNewLicense'
    	* def formatedSumbitDate = summisionDate()
	    And header authorization = 'Bearer ' + strToken
	    And header current-wfroleid = 4
	    And request {"isFingerPrintsApproved":false,"isFingerPrintsRequired":false,"isCorpLLCDissolved":false,"isCorpLLCDTaken":false,"isSendPDLetter":false,"isDisable500LB_FBPT":false,"isDisableLBForPD":false,"isDisableLBForCaseClosed":false,"isDisableLateRenewalAndUnderpayment":false,"isLiquidatorPermitHasCompleted":-1,"isSubmit":true,"fieldDeficiencies":[],"masterFileData":[],"combinedCraftData":[],"application":{"applicationCategory":1,"appId":'#(appId)',"applicationId":'#(ApplicationId)',"licePermitTypeId":null,"applicationTypeId":1,"formVersionId":1231,"formId":'#(formId)',"legalName":"","submitDate":'#(formatedSumbitDate)',"isGISRequired":null,"licenseDescription":'#(description)',"recommendedDecisionId":null,"status500":null,"isApplicableForPDLetter":false,"countyName":'#(CityName)',"priority":"Normal","expirationDate":null,"appStatusId":3,"taskStatus":"Awaiting Review","taskId":1026,"currentWfstatus":null,"communityBoard":null,"isLicenseApplication":true,"currentDueDate":null,"isFinalDeficiency":null,"isHighlyDeficient":null,"isAllDeficienciesMet":null,"pastDueDate":null,"memo":null,"isOneTimePermit":null,"dueDateAction":null,"isDisapprovedForCause":false,"isNotQualified":false,"eventDate":null,"appStatus":{"appStatusId":3,"statusDescription":"Under Review","isActive":true,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"applicationType":null,"assignAppExaminer":{"appExaminerId":1069,"appId":'#(appId)',"examinerId":1069,"name":null,"assignDate":'#(formatedSumbitDate)',"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"assignAppToLB":null,"licePermitType":{"licPermitTypeId":'#(mainLicensePermitTypeId)',"type":"1","category":"1","product":'#(productName)',"class":null,"description":null,"sectionOfLaw":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null,"isTempPermit":false,"isELicensingPermit":false,"isAdditionalBar":false},"assoApplicationList":[],"isTempPermit":null,"isTempOrLiq":false,"licPermitTypeId":'#(mainLicensePermitTypeId)',"isAssociatedLicense":null,"effectiveDate":null,"assignedUserId":null,"amendmentTypeId":null,"amendmentType":null,"disapprovedDate":null,"condApprovedDate":null,"addressId":null,"isCaseOpen":null,"isClosed":null,"isSpecialEventPlusFour":null,"isSpecialEventInsideFiveBoroughs":null,"licStatus":null,"createdBy":null,"licenseId":null,"address":null,"isNybeApp":false,"isHearingCompleted":null,"does500FtHearingExist":null,"parentAppStatus":null,"premisesAppCount":0,"statusDescription":null,"eventAddress":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskRoleId":0,"taskDecision":null,"isActive":true,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":'#(formatedSumbitDate)'},"appId":'#(appId)',"notificationTypeId":2028,"applicationType":1,"decisionType":{"name":"Send to Licensing Board","value":2},"emailNotificationModel":{"applicant":{},"attorney":{},"communityBoard":{},"other":{}},"hasErrors":[],"taskId":1026,"newComments":"","recommendedDecisionId":null};
	    When method post
	    Then status 200
   		 * call read('LicensesCommonMethods.feature@checkApplicationStatus') {}

@ExaminerReviewDefineDeficiencies
Scenario: ExaminerReviewDefineDeficiencies  
 # ********* ExaminerReviewDefineDeficiencies *********************
 
 
	* def summisionDate =
		"""
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		  
		  
		"""
    Given path '/internalapi/api/licensing/examiner-review/SaveNewLicense'
    	
	    * def formatedSumbitDate = summisionDate()
	    And header authorization = 'Bearer ' + strToken
	    And header current-wfroleid = 4
	    And request {"isFingerPrintsApproved":true,"isFingerPrintsRequired":false,"isCorpLLCDissolved":false,"isCorpLLCDTaken":false,"isSendPDLetter":false,"isDisable500LB_FBPT":false,"isDisableLBForPD":false,"isDisableLBForCaseClosed":false,"isDisableLateRenewalAndUnderpayment":false,"isLiquidatorPermitHasCompleted":-1,"isSubmit":true,"fieldDeficiencies":[],"masterFileData":[],"combinedCraftData":[],"application":{"applicationCategory":1,"appId":'#(appId)',"applicationId":'#(ApplicationId)',"licePermitTypeId":null,"applicationTypeId":1, "formVersionId":1614,"formId":'#(formId)',"legalName":"","submitDate":'#(formatedSumbitDate)',"isGISRequired":null,"licenseDescription":'#(description)',"recommendedDecisionId":null,"status500":null,"isApplicableForPDLetter":false,"countyName":'#(CityName)',"priority":"Normal","expirationDate":null,"appStatusId":3,"taskStatus":"Awaiting Review","taskId":1026,"currentWfstatus":null,"communityBoard":null,"isLicenseApplication":true,"currentDueDate":null,"isFinalDeficiency":null,"isHighlyDeficient":null,"isAllDeficienciesMet":null,"pastDueDate":"5/12/2022","memo":null,"isOneTimePermit":null,"dueDateAction":null,"isDisapprovedForCause":false,"isNotQualified":false,"eventDate":null,"appStatus":{"appStatusId":3,"statusDescription":"Under Review","isActive":true,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"applicationType":null,"assignAppExaminer":{"appExaminerId":1069,"appId":'#(appId)',"examinerId":1069,"name":null,"assignDate":'#(formatedSumbitDate)',"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"assignAppToLB":null,"licePermitType":{"licPermitTypeId":'#(mainLicensePermitTypeId)',"type":"1","category":"1","product":'#(productName)',"class":null,"description":null,"sectionOfLaw":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null,"isTempPermit":false,"isELicensingPermit":false,"isAdditionalBar":false},"assoApplicationList":[],"isTempPermit":null,"isTempOrLiq":false,"licPermitTypeId":'#(mainLicensePermitTypeId)',"isAssociatedLicense":null,"effectiveDate":null,"assignedUserId":null,"amendmentTypeId":null,"amendmentType":null,"disapprovedDate":null,"condApprovedDate":null,"addressId":null,"isCaseOpen":null,"isClosed":null,"isSpecialEventPlusFour":null,"isSpecialEventInsideFiveBoroughs":null,"licStatus":null,"createdBy":null,"licenseId":null,"address":null,"isNybeApp":false,"isHearingCompleted":null,"does500FtHearingExist":null,"parentAppStatus":null,"premisesAppCount":0,"statusDescription":null,"eventAddress":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskRoleId":0,"taskDecision":null,"isActive":true,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":'#(formatedSumbitDate)'},"appId":'#(appId)',"notificationTypeId":2028,"applicationType":1,"decisionType":{"name":"Define Deficiencies","value":1},"emailNotificationModel":{"applicant":{"communicationId":14533,"email":'#(emailId)',"appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":14536,"email":"sbandi@svam.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":0,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"notificationTypeId":2028,"isInstantEmail":false},"hasErrors":[],"taskId":1026,"erDeficiencies":{"selectInput":{"fromFields":[{"id":4,"label":"As the applicant is a corporation, LLC or LLP, the applicant name must be the same as the name on the filing receipt."},{"id":5,"label":"Submit a copy of the Secretary of State filing receipt for the corp/LLC/LLP"},{"id":6,"label":"Provide a copy of the corporate minutes for the applicant entity"},{"id":7,"label":"Provide a copy of the LLC operating agreement for the applicant entity"},{"id":8,"label":"Provide a clear organizational chart for the applicant entity.  Each holding corporation should be listed.  All principals of each entity should be listed along with their percentage of ownership."},{"id":9,"label":"Premises address does not match the address listed on lease."},{"id":10,"label":"Premises address does not match the address listed on the bill of sale."},{"id":11,"label":"Premises address does not match the address listed on the deed."},{"id":12,"label":"Premises address must be written the same on all documents and must be the physical location of the premises (not the mailing address)."},{"id":13,"label":"Submit a Notice of Appearance or the attorney or representative."},{"id":14,"label":"Entity owning real property does not match applicant name – A lease between the two parties is required and must be submitted.  "},{"id":15,"label":"The lease must run the full term of the license period (please take processing time into consideration when determining the end date of the lease).  Provide either a new lease document or an amendment/rider to the existing one (signed by both landlord and tenant).  "},{"id":16,"label":"Landlord name must be the name shown on the deed."},{"id":17,"label":"All principals of the landlord entity must be listed."},{"id":18,"label":"To verify ownership, submit a copy of the deed."},{"id":19,"label":"The source of ALL funds (cash and borrowed) must be listed on this form."},{"id":20,"label":"Submit financial documentation proving the availability of the funds listed.  You must submit 3 consecutive months-worth of statements from checking or savings accounts showing the availability of the funds at the time they were expended."},{"id":21,"label":"Submit a copy of all executed loan agreements.  "},{"id":22,"label":"Provide the name and address of all on premises liquor establishments located within 500 feet of your establishment."},{"id":23,"label":"Provide a statement addressing why you believe it would be in the public's interest to issue this license."},{"id":24,"label":"Please complete the Statement of Area Plan form"},{"id":25,"label":"Provide a personal questionnaire for __________________."},{"id":26,"label":"Please list gender on _________'s personal questionnaire."},{"id":27,"label":"Provide residence addresses for the last 5 consecutive years."},{"id":28,"label":"Provide employment information for the last 5 consecutive years.  If unemployed for any period of time during the past 5 years, that must also be reflected."},{"id":29,"label":"________________ has/had license history with the Authority.  Amend question five to reflect all license history."},{"id":30,"label":"The Department of Criminal Justice Services has advised us that ________________________ has a conviction record. Amend question 6b to reflect the correct answer and provide a signed statement as to why the question was originally answered no.  Submit a Certificate of Disposition for all arrests and convictions. If convicted of a felony, you must submit a Certificate of Relief from Disabilities."},{"id":31,"label":"Amend the diagram labeling all rooms and bars"},{"id":32,"label":"Amend the diagram to include the food prep area"},{"id":33,"label":"Provide a diagram of the basement"},{"id":34,"label":"Provide a block plot diagram"},{"id":35,"label":"Add the outside area to the diagram "},{"id":36,"label":"Submit color photos of the interior of the premises including all dining areas, the bar and at least one of the kitchen.  Place the serial number on the back of each photo."},{"id":37,"label":"Submit one color photo of the front exterior of the premises.  Place the serial number on the back of the photo."},{"id":38,"label":"Submit color photos of any outside area (deck, patio, yard) to be licensed.  The photos must show how the area is contained (fencing, shrubbery, roping off).  Place the serial number on the back of the photos."},{"id":39,"label":"Provide a color photo of the applicant (no smaller than passport size) for _______________."},{"id":40,"label":"Provide a copy of ____________'s photo identification."},{"id":41,"label":"Submit a copy of the menu."},{"id":42,"label":"Provide proof of citizenship for _________________."},{"id":43,"label":"You have listed 1 restroom.  The Rules of the State Liquor Authority require 2 separate restrooms for both sexes.  Please submit a request to the Authority asking for a waiver of the 2-restroom rule.  You must explain why you believe one restroom is sufficient for the operation of your establishment."},{"id":44,"label":"Submit a copy of the maximum occupancy certificate."},{"id":45,"label":"______________________ needs to be fingerprinted. "},{"id":123,"label":"Additional Funds Required"},{"id":129,"label":"Provide a copy of the Assumed Name Certificate from the Secretary of State for your corporation/LLC's dba name."},{"id":130,"label":"Provide a copy of the business certificate from the county clerk for your dba name."},{"id":131,"label":"Provide your federal tax identification number."},{"id":132,"label":"Provide a copy of your Certificate of Authority from the New York State Tax Department."},{"id":133,"label":"Provide an amended Certificate of Authority – the name must match the applicant name exactly."},{"id":134,"label":"Provide an amended Certificate of Authority – the address must match the premises address exactly."},{"id":135,"label":"Provide a signed Bond Rider amending _______."},{"id":136,"label":"Provide Worker's Compensation and Disability Benefits insurance provider names and policy numbers."},{"id":137,"label":"Provide an inventory of the alcoholic beverages you will be purchasing from the current licensee."},{"id":138,"label":"Submit a copy of the Newspaper Affidavit(s)."},{"id":139,"label":"Provide your TTB permit."},{"id":140,"label":"Surrender of the current license in effect."},{"id":141,"label":"Make the edits listed below to the curriculum."},{"id":142,"label":"The submitted Curriculum generally covers the required topics. However,  the below changes must be made to ensure that the persons taking the course understand their rights, obligations, and liabilities under New York law."},{"id":143,"label":"The licensee's and server's responsibility to not sell, deliver or give alcohol to someone under the age of 21 (ABC Law 65)."},{"id":144,"label":"The licensee's and server's responsibility when serving more than one drink to an individual to be aware of any redelivery by the legal patron (on-premises only)."},{"id":145,"label":"The licensee's and server's responsibility to reasonably supervise the premises."},{"id":146,"label":"The licensee's and server's right to refuse to sell, including but not limited to, an underage patron, an intoxicated patron, or a patron without proper identification."},{"id":147,"label":"The licensee's and server's burden to establish that a delivery of alcohol was made in a reasonable reliance upon written evidence of age."},{"id":148,"label":"The forms of identification which may be legally accepted as written evidence of age (ABC Law 65-b.2)."},{"id":'#(appId)',"label":"Key features of the valid forms of identification and the way false and fraudulent forms of identification may be detected."},{"id":150,"label":"Devices and manuals which may be used to aid in the detection of false and fraudulent written evidence of age, and information regarding the way such devises and manuals may be obtained."},{"id":151,"label":"The criminal liabilities and penalties for both the individual and the establishment for unlawfully dealing with a child (Penal Law 260.20)."},{"id":152,"label":"The civil liabilities, general liabilities, responsibilities and general obligations (General Obligations Law 11-100 and 11-101)."},{"id":153,"label":"Firsthand accounts from the public illustrating the consequences of the failure of licensees and/or servers to operate in a safe, legal and responsible manner. (i.e., MADD, RID, and Shattered Lives)."},{"id":154,"label":"Provide the New York State Liquor Authority with access to the online course for review."},{"id":155,"label":"Remove the following content from the applicants' website:"},{"id":156,"label":"Provide the legal name of the applicant."},{"id":157,"label":"Provide the mailing address of the applicant."},{"id":158,"label":"Provide the federal id number of the applicant."},{"id":159,"label":"Provide the applicant's contact phone number."},{"id":160,"label":"Provide the applicant's email address."},{"id":161,"label":"Provide the director's name."},{"id":162,"label":"Provide the director's phone number."},{"id":163,"label":"Provide the director's email address."},{"id":164,"label":"Designate the format of the course. The Alcoholic Beverage Control Law states that the course be taught via online, classroom, or distance learning. An ATAP course can be offered in multiple formats."}],"toFields":[{"id":-1,"label":"As the applicant is a corporation, LLC or LLP, the applicant name must be the same as the name on the filing receipt.","originalId":4},{"id":-2,"label":"Submit a copy of the Secretary of State filing receipt for the corp/LLC/LLP","originalId":5},{"id":-3,"label":"Provide a copy of the corporate minutes for the applicant entity","originalId":6},{"id":-4,"label":"Provide a copy of the LLC operating agreement for the applicant entity","originalId":7},{"id":-5,"label":"Provide a clear organizational chart for the applicant entity.  Each holding corporation should be listed.  All principals of each entity should be listed along with their percentage of ownership.","originalId":8},{"id":-6,"label":"Premises address does not match the address listed on lease.","originalId":9},{"id":-7,"label":"Premises address does not match the address listed on the bill of sale.","originalId":10},{"id":-8,"label":"Premises address does not match the address listed on the deed.","originalId":11},{"id":-9,"label":"Premises address must be written the same on all documents and must be the physical location of the premises (not the mailing address).","originalId":12},{"id":-10,"label":"Submit a Notice of Appearance or the attorney or representative.","originalId":13},{"id":-11,"label":"Entity owning real property does not match applicant name – A lease between the two parties is required and must be submitted.  ","originalId":14},{"id":-12,"label":"The lease must run the full term of the license period (please take processing time into consideration when determining the end date of the lease).  Provide either a new lease document or an amendment/rider to the existing one (signed by both landlord and tenant).  ","originalId":15},{"id":-13,"label":"Landlord name must be the name shown on the deed.","originalId":16},{"id":-14,"label":"All principals of the landlord entity must be listed.","originalId":17},{"id":-15,"label":"To verify ownership, submit a copy of the deed.","originalId":18},{"id":-16,"label":"The source of ALL funds (cash and borrowed) must be listed on this form.","originalId":19},{"id":-17,"label":"Submit financial documentation proving the availability of the funds listed.  You must submit 3 consecutive months-worth of statements from checking or savings accounts showing the availability of the funds at the time they were expended.","originalId":20},{"id":-18,"label":"Submit a copy of all executed loan agreements.  ","originalId":21},{"id":-19,"label":"Provide the name and address of all on premises liquor establishments located within 500 feet of your establishment.","originalId":22},{"id":-20,"label":"Provide a statement addressing why you believe it would be in the public's interest to issue this license.","originalId":23},{"id":-21,"label":"Please complete the Statement of Area Plan form","originalId":24},{"id":-22,"label":"Provide a personal questionnaire for __________________.","originalId":25},{"id":-23,"label":"Please list gender on _________'s personal questionnaire.","originalId":26},{"id":-24,"label":"Provide residence addresses for the last 5 consecutive years.","originalId":27},{"id":-25,"label":"Provide employment information for the last 5 consecutive years.  If unemployed for any period of time during the past 5 years, that must also be reflected.","originalId":28},{"id":-26,"label":"________________ has/had license history with the Authority.  Amend question five to reflect all license history.","originalId":29},{"id":-27,"label":"The Department of Criminal Justice Services has advised us that ________________________ has a conviction record. Amend question 6b to reflect the correct answer and provide a signed statement as to why the question was originally answered no.  Submit a Certificate of Disposition for all arrests and convictions. If convicted of a felony, you must submit a Certificate of Relief from Disabilities.","originalId":30},{"id":-28,"label":"Amend the diagram labeling all rooms and bars","originalId":31},{"id":-29,"label":"Amend the diagram to include the food prep area","originalId":32},{"id":-30,"label":"Provide a diagram of the basement","originalId":33},{"id":-31,"label":"Provide a block plot diagram","originalId":34},{"id":-32,"label":"Add the outside area to the diagram ","originalId":35},{"id":-33,"label":"Submit color photos of the interior of the premises including all dining areas, the bar and at least one of the kitchen.  Place the serial number on the back of each photo.","originalId":36},{"id":-34,"label":"Submit one color photo of the front exterior of the premises.  Place the serial number on the back of the photo.","originalId":37},{"id":-35,"label":"Submit color photos of any outside area (deck, patio, yard) to be licensed.  The photos must show how the area is contained (fencing, shrubbery, roping off).  Place the serial number on the back of the photos.","originalId":38},{"id":-36,"label":"Provide a color photo of the applicant (no smaller than passport size) for _______________.","originalId":39},{"id":-37,"label":"Provide a copy of ____________'s photo identification.","originalId":40},{"id":-38,"label":"Submit a copy of the menu.","originalId":41},{"id":-39,"label":"Provide proof of citizenship for _________________.","originalId":42},{"id":-40,"label":"You have listed 1 restroom.  The Rules of the State Liquor Authority require 2 separate restrooms for both sexes.  Please submit a request to the Authority asking for a waiver of the 2-restroom rule.  You must explain why you believe one restroom is sufficient for the operation of your establishment.","originalId":43},{"id":-41,"label":"Submit a copy of the maximum occupancy certificate.","originalId":44},{"id":-42,"label":"______________________ needs to be fingerprinted. ","originalId":45},{"id":-43,"label":"Additional Funds Required","originalId":123},{"id":-44,"label":"Provide a copy of the Assumed Name Certificate from the Secretary of State for your corporation/LLC's dba name.","originalId":129},{"id":-45,"label":"Provide a copy of the business certificate from the county clerk for your dba name.","originalId":130},{"id":-46,"label":"Provide your federal tax identification number.","originalId":131},{"id":-47,"label":"Provide a copy of your Certificate of Authority from the New York State Tax Department.","originalId":132},{"id":-48,"label":"Provide an amended Certificate of Authority – the name must match the applicant name exactly.","originalId":133},{"id":-49,"label":"Provide an amended Certificate of Authority – the address must match the premises address exactly.","originalId":134},{"id":-50,"label":"Provide a signed Bond Rider amending _______.","originalId":135},{"id":-51,"label":"Provide Worker's Compensation and Disability Benefits insurance provider names and policy numbers.","originalId":136},{"id":-52,"label":"Provide an inventory of the alcoholic beverages you will be purchasing from the current licensee.","originalId":137},{"id":-53,"label":"Submit a copy of the Newspaper Affidavit(s).","originalId":138},{"id":-54,"label":"Provide your TTB permit.","originalId":139},{"id":-55,"label":"Surrender of the current license in effect.","originalId":140},{"id":-56,"label":"Make the edits listed below to the curriculum.","originalId":141},{"id":-57,"label":"The submitted Curriculum generally covers the required topics. However,  the below changes must be made to ensure that the persons taking the course understand their rights, obligations, and liabilities under New York law.","originalId":142},{"id":-58,"label":"The licensee's and server's responsibility to not sell, deliver or give alcohol to someone under the age of 21 (ABC Law 65).","originalId":143},{"id":-59,"label":"The licensee's and server's responsibility when serving more than one drink to an individual to be aware of any redelivery by the legal patron (on-premises only).","originalId":144},{"id":-60,"label":"The licensee's and server's responsibility to reasonably supervise the premises.","originalId":145},{"id":-61,"label":"The licensee's and server's right to refuse to sell, including but not limited to, an underage patron, an intoxicated patron, or a patron without proper identification.","originalId":146},{"id":-62,"label":"The licensee's and server's burden to establish that a delivery of alcohol was made in a reasonable reliance upon written evidence of age.","originalId":147},{"id":-63,"label":"The forms of identification which may be legally accepted as written evidence of age (ABC Law 65-b.2).","originalId":148},{"id":-64,"label":"Key features of the valid forms of identification and the way false and fraudulent forms of identification may be detected.","originalId":'#(appId)'},{"id":-65,"label":"Devices and manuals which may be used to aid in the detection of false and fraudulent written evidence of age, and information regarding the way such devises and manuals may be obtained.","originalId":150},{"id":-66,"label":"The criminal liabilities and penalties for both the individual and the establishment for unlawfully dealing with a child (Penal Law 260.20).","originalId":151},{"id":-67,"label":"The civil liabilities, general liabilities, responsibilities and general obligations (General Obligations Law 11-100 and 11-101).","originalId":152},{"id":-68,"label":"Firsthand accounts from the public illustrating the consequences of the failure of licensees and/or servers to operate in a safe, legal and responsible manner. (i.e., MADD, RID, and Shattered Lives).","originalId":153},{"id":-69,"label":"Provide the New York State Liquor Authority with access to the online course for review.","originalId":154},{"id":-70,"label":"Remove the following content from the applicants' website:","originalId":155},{"id":-71,"label":"Provide the legal name of the applicant.","originalId":156},{"id":-72,"label":"Provide the mailing address of the applicant.","originalId":157},{"id":-73,"label":"Provide the federal id number of the applicant.","originalId":158},{"id":-74,"label":"Provide the applicant's contact phone number.","originalId":159},{"id":-75,"label":"Provide the applicant's email address.","originalId":160},{"id":-76,"label":"Provide the director's name.","originalId":161},{"id":-77,"label":"Provide the director's phone number.","originalId":162},{"id":-78,"label":"Provide the director's email address.","originalId":163},{"id":-79,"label":"Designate the format of the course. The Alcoholic Beverage Control Law states that the course be taught via online, classroom, or distance learning. An ATAP course can be offered in multiple formats.","originalId":164}],"isRewritable":true,"rewriteLabel":"Edit Deficiency:","additionalComments":"","srclabel":"Select Deficiencies","dstlabel":"Add to Notification","additionalLabel":"Add Additional Deficiencies:"}},"newComments":""}
	    When method post
	    Then status 200
   		 * call read('LicensesCommonMethods.feature@checkApplicationStatus') {}




@checkApplicationStatus
Scenario: checkLicenseApplicationStatus
 Given path '/internalapi/api/application/preview/'+appId
	   	* def dbSts = db.cleanHeap()
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;*/*'
	      And configure continueOnStepFailure = true
	   	 And request {}
		  When method get
		  * configure continueOnStepFailure = true
		  Then status 200
		    And def licStatus = response.appStatus.statusDescription
		  And print licStatus
		 
		  And match licStatus == '#(expStatus)'             

@IsPaymentFailedScenario
Scenario: IsPaymentFailedScenario
		* eval if(dueDateCount > 0 ) fundDueDate = fundDueDateFunc(dueDateCount)
		 
 		* def getDate2 =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		  """
  	  * def date = getDate2()
	
	
	Given path '/internalapi/api/licensing/app/save'
	    And header authorization = 'Bearer ' + strToken
	    And request {"isApproved":false,"appId":'#(appId)',"formID":'#(formId)',"applicationID":'#(ApplicationId)',"formName":'#(description)',"formType":{},"formTypeId":null,"applicationType":{},"applicationTypeId":null,"formCategory":{},"formCategoryId":null,"approvalFlag":null,"status":"","createdBy":"","createdDate":"","modifiedBy":"","sections":[{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1842,"key":"","label":"Signature","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1843,"key":"","label":"Date","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1851,"key":"","label":"Title","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"dropdown","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2232,"key":"","label":"First Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2233,"key":"","label":"Middle Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2234,"key":"","label":"Last Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1200,"sectionName":"","key":"0","label":"Applicant Statement","order":9,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1957,"key":"","label":"By what right does the applicant have possession of the premises?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1958,"key":"","label":"Explain","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1959,"key":"","label":"Do the terms of the lease or other arrangement require the applicant to provide any consideration based on a percentage of the receipts of the business?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1960,"key":"","label":"If yes, list the section/page of the lease this information can be found","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1961,"key":"","label":"Does or will anyone other than the applicant/principals share on a percentage basis or in any way in the receipts, losses, or deficiencies of the business to any extent whatsoever","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1226,"sectionName":"","key":"0","label":"Right to Premises","order":5,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1685,"key":"","label":"First Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1686,"key":"","label":"Middle Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1687,"key":"","label":"Last Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"1 wall street","fieldID":1697,"key":"","label":"Address Line 1/ POB #","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":6,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1698,"key":"","label":"Address Line 2","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":7,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":'#(CityName)',"fieldID":1699,"key":"","label":"City","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":8,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1700,"key":"","label":"State/Region","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":9,"controlType":"dropdown","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"10011","fieldID":1701,"key":"","label":"Zip/Postal Code","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":10,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1754,"key":"","label":"Address","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"label","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1934,"key":"","label":"Nature of Interest","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1935,"key":"","label":"Date acquired","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1218,"sectionName":"","key":"0","label":"Other Interested","order":1,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]}],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1933,"key":"","label":"Signature","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1936,"key":"","label":"Date","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1239,"sectionName":"","key":"0","label":"Bulletin 254","order":10,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2053,"key":"","label":"Describe the area where the premises is to be located","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2054,"key":"","label":"State what the area is zoned for","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2055,"key":"","label":"Provide a description of the premises to be licensed. Describe all building/structures that will be utilized in business operations including the number of floors in each.","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2056,"key":"","label":"has the building/premises been known by any other address?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2057,"key":"","label":"If yes, please Specify","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2058,"key":"","label":"has the premises to be licensed and or any other floor in the building been previously licensed or currently licensed to traffic in alcoholic beverages?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2059,"key":"","label":"What was the prior use of the premises to be licensed?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":6,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2060,"key":"","label":"Does the proposed location of the business comply with all state and local regulations and zoning codes?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":7,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2061,"key":"","label":"is there interior access to any other floor that will not be part of the licensed premises?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":8,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2062,"key":"","label":"if yes, list floor and means of access to each floor.","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":9,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2063,"key":"","label":"Does any other person have access to this area?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":10,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2064,"key":"","label":"where will the alcohol be stored","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":11,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2065,"key":"","label":"if applying for a farm winery license, special farm winery license or micro winery license, the premises must be located on a farm. In the box below, please provide a detailed description of the agricultural production that qualifies the premises as a farm","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":12,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1248,"sectionName":"","key":"0","label":"Premises Questionnaire","order":7,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1988,"key":"","label":"Will any other business of any kind be conducted on said premises?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1989,"key":"","label":"How many Employees?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1990,"key":"","label":"If answer is 0, provide explanation","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1991,"key":"","label":"Workers' Compensation Carrier Name and Policy Number?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1992,"key":"","label":"Disability Insurance Carrier name and policy Number","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2050,"key":"","label":"Check all activities the business will engage in","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"checkbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1249,"sectionName":"","key":"0","label":"Method of Operation","order":8,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2072,"key":"","label":"Real Property","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2073,"key":"","label":"Purchase/Contract Price of Business","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2074,"key":"","label":"Renovations/Improvement Costs","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2075,"key":"","label":"Miscellaneous","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2076,"key":"","label":"Cash","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"label","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2077,"key":"","label":"Source of Funds","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2078,"key":"","label":"Personal Questionnaire attached","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":6,"controlType":"checkbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2079,"key":"","label":"Dollar Amount","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":7,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2080,"key":"","label":"Total Cash","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":8,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2081,"key":"","label":"Borrowed","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":9,"controlType":"label","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2082,"key":"","label":"Source of Funds","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":10,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2083,"key":"","label":"Personal Questionnaire attached","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":11,"controlType":"checkbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2084,"key":"","label":"Dollar Amount","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":12,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2085,"key":"","label":"Total Borrowed","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":13,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2086,"key":"","label":"Total Investment","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":14,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2087,"key":"","label":"Have all investors been disclosed in this application","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":15,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1253,"sectionName":"","key":"0","label":"Financial Disclosure","order":6,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]}],"formVersionId":1231,"version":7,"licenseDescription":"","statusDescription":"Draft","appStatusId":1,"showApplicant":true,"showRepresentative":true,"showPrincipal":true,"showLandlord":true,"showVehicles":false,"showSchedule":false,"staticTabSequence":{"Applicant Information":0,"Principal":1,"Representative":2,"Landlord Identification":3,"Personal Questionnaire":4},"staticTaborder":["Applicant Information","Principal","Representative","Landlord Identification","Personal Questionnaire"],"showPQ":true}
	    When method post
	    Then status 200
	    And def serverResponse = response
	Given path 'internalapi/api/licensing/fees/details/save/'+appId+'/true'
      And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {"checks":[{"checkDetailId":'#(checkDetailId)',"appId":'#(appId)',"paymentSource":"RDC","checkNo":"1","batchNo":"1","itemNo":"1","slareceivedDate":'#(date)',"slaintakeDate":'#(date)',"amount":'#(amountPaid)',"isPaymentFailed":true,"appliedTo":null,"amountUsed":'#(amountPaid)',"comment":null,"isReplacement":null,"replacementReason":null,"isActive":true,"createdBy":"tgupta@svam.com","createdDate":'#(date)',"modifiedBy":null,"modifiedDate":null,"applyClick":true}],"appFees":{"appFees":[{"licenseName":'#(description)',"applicationId":'#(ApplicationId)',"applicationTypeId":1,"appFeesId":'#(licFeesRefId)',"appId":'#(appId)',"feesRefId":'#(licFeesRefId)',"initialFees":0,"licensingFees":'#(licenseFees)',"amendmentFees":"0.00","renewalFees":"0.00","totalFees":'#(totalFees1)',"filingFees":'#(licfilingFees1)',"ancillaryFees":'#(licAncillaryFees1)',"isFeesWaived":false,"underPaymentAmount":'#(totalFees)',"amountReceived":"0.00","waivedComment":null,"isBondReceived":'#(isBondRequired)',"isBondRequired":'#(isBondRequired)',"bondFee":'#(bndFees)',"term":'#(termInYears)',"termDesc":'#(termDesc)',"seasonalStartDate":null,"seasonalEndDate":null,"isFeesCountBased":false,"isFeesUnitBased":false,"numOfUnits":0,"paymentDetails":[],"lateFee":0,"isFeesBarPerDay":null}],"bondDetails":null,"isPaymentFailed":false,"isUnderpaid":true,"sendNotification":false,"fundDueDate":'#(fundDueDate)',"emailNotificationDetail":{"applicant":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"}},"notificationDetails":{"applicant":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"},"taskId":1026}
	  When method post
	  Then status 200
	  And print response 
	  * call read('LicensesCommonMethods.feature@checkApplicationStatus') {}  
	
	    
	    
@LBClaimingQueue
Scenario: LBClaimingQueue 
 # ********* LB Claiming Queue  ********************* 
 
    Given path 'internalapi/api/licensing/claiming-queue/add/'+appId +'/1069'
	    And header authorization = 'Bearer ' + strToken
	    And header current-wfroleid = 5
	    And request {}
	    When method post
	    Then status 200
        * call read('LicensesCommonMethods.feature@checkApplicationStatus') {}  
@LBApproval
Scenario: LBApproval    
 # ********* LB Approval *********************    
    Given path '/internalapi/api/licensing/new-license/saveDecision'
	    And header authorization = 'Bearer ' + strToken
	    And header current-wfroleid = 5
	    * def getSelectedDecisionFunc =
			"""
				function(value1){
					if (value1 == 'Approved'){
					return 1;
					}
					else if (value1 == 'Disapproved'){
					return 2;
					}
					else if (value1 == 'Disapproval to Counsel'){
					return 3;
					}else if (value1 == 'Withdrawal'){
					return 4;
					}else if (value1 == 'Conditionally Approved'){
					return 5;
					}else if (value1 == 'FB Decision Required'){
					return 6;
					}else if (value1 == 'Return to Examiner'){
					return 7;
					}					
					else {
					return 1;
					}
			    }
			"""
			
		* def selectedDecisionCode = getSelectedDecisionFunc(approvalName)
  			And print selectedDecisionCode
	   And request {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"appId":'#(appId)',"applicationType":1,"applicationId":'#(ApplicationId)',"legalName":null,"statusId":3,"decisionType":{"name":'#(approvalName)',"value":'#(selectedDecisionCode)'},"emailNotificationModel":{"applicant":{"communicationId":6912,"email":'#(emailId)',"appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}},"hasErrors":[],"licPermitTypeId":'#(mainLicensePermitTypeId)',"taskId":1151,"newComments":"","conditionalApproval":{"selectInput":{"fromFields":[{"id":1,"label":"Provide a copy of the Assumed Name Certificate from the Secretary of State for your corporation/LLC’s dba name"},{"id":2,"label":"Provide a copy of the business certificate from the county clerk for your dba name"},{"id":3,"label":"Provide your federal tax identification number"},{"id":4,"label":"Provide a copy of your Certificate of Authority from the New York State Tax Department"},{"id":5,"label":"Provide an amended Certificate of Authority – the name must match the applicant name exactly."},{"id":7,"label":"Provide a signed Bond Rider amending____________"},{"id":8,"label":"Provide Worker’s Compensation and Disability Benefits insurance provider names and policy numbers"},{"id":10,"label":"Submit a copy of the Newspaper Affidavit(s)"},{"id":11,"label":"Provide your TTB permit"},{"id":12,"label":"Surrender of the current license in effect"},{"id":13,"label":"Other Condition"}],"toFields":[{"id":6,"label":"Provide an amended Certificate of Authority – the address must match the premises address exactly"},{"id":9,"label":"Provide an inventory of the alcoholic beverages you will be purchasing from the current licensee"}],"isRewritable":true,"rewriteLabel":"Edit Condition:","additionalComments":"","srclabel":"Select","dstlabel":"Add to Letter","additionalLabel":"Additional Conditions:"},"effectiveDate":'#(effectiveDate)',"expirationDate":'#(effectiveDate)',"conditions":[6,9],"descriptions":["Provide an amended Certificate of Authority – the address must match the premises address exactly","Provide an inventory of the alcoholic beverages you will be purchasing from the current licensee"]}}
	    When method post
	    Then status 200
	    And def serverResponse = response
   		* call read('LicensesCommonMethods.feature@checkApplicationStatus') {}   


@ValidateLicenseApplicationStatus
Scenario: ValidateLicenseApplicationStatus on Search Page 
Given path 'internalapi/api/GenericSearch/SearchLicense'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And params  {page:1,pageSize:10}
      And request [{"dataTypeValue":"Text","key":"ApplicationId","operatorValue":"=","value":'#(ApplicationId)'}]
	  When method post
	  Then status 200
	  And print response
	  * match response.data[0].applicationStatus == '#(LicAppStatus)'
	  
@ValidateCommunicationPageAndEMailForOnPromises
 Scenario: ValidateCommunicationPageAndEMail Email Communication Page scenario
	
	Given path '/internalapi/api/Communication/GetEmailCommQueue/Application/'+appId
	   	* def dbSts = db.approvalLicenseEmailMapping((appId+''),NotificationMethodName)
		And print dbSts
		* match dbSts == true
	 	And header authorization = 'Bearer ' + strToken
	  	And header Content-Type = 'application/json; charset=utf-8'
	    And header Accept = 'application/json; text/plain;*/*'
	    And header user-agent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36'
	  	And request ""
	    When method get
	    Then status 200	    
	    
	    And def serverResponse = response
	    
	    * def serverResponseNotificationData = karate.jsonPath(serverResponse, "$[?(@.typeOfNotification == '" + typeOfNotification + "')]")
		And print serverResponseNotificationData
		* match serverResponseNotificationData[0].status == 'Sent'
		* match serverResponseNotificationData[0].emailTo != []
		* match serverResponseNotificationData[0].subject == 'NYS Liquor Authority Licensing Bureau Record Information'
		* match serverResponseNotificationData[0].emailBody contains emailBodyData
		* match serverResponseNotificationData[0].attachments[0].documentDesc == docName
		* def acaDocumentId = serverResponseNotificationData[0].attachments[0].acaDocumentId
	Given path '/internalapi/api/notification/Application/email/download/'+acaDocumentId
	   	And header authorization = 'Bearer ' + strToken
	  	And header Content-Type = 'application/pdf;'
	    And header Accept = 'text/html,application/xhtml+xml,application/xml;text/plain;*/*'
	    And header user-agent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36'
	  	And request ""
	    When method get
	    Then status 200	    
	    
	    And def serverResponse = response
	    And print serverResponse
	    * match serverResponse != []
	  
    
@ValidateCommunicationPageAndEMailForOFFPromises
 Scenario: ValidateCommunicationPageAndEMailForOFFPromises Email Communication Page scenario
	
	Given path '/internalapi/api/Communication/GetEmailCommQueue/Application/'+appId
	   	* def dbSts = db.approvalLicenseEmailMapping((appId+''),NotificationMethodName)
		And print dbSts
		* match dbSts == true
	 	And header authorization = 'Bearer ' + strToken
	  	And header Content-Type = 'application/json; charset=utf-8'
	    And header Accept = 'application/json; text/plain;*/*'
	    And header user-agent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36'
	  	And request ""
	    When method get
	    Then status 200	    
	    
	    And def serverResponse = response
	    
	    * def serverResponseNotificationData = karate.jsonPath(serverResponse, "$[?(@.typeOfNotification == '" + typeOfNotification + "')]")
		And print serverResponseNotificationData
		* match serverResponse[0].status == 'Sent'
		* match serverResponse[0].emailTo != []
		* match serverResponse[0].subject == 'NYS Liquor Authority Licensing Bureau Record Information'
		* match serverResponse[0].emailBody contains emailBodyData
		* match serverResponse[0].attachments[0].documentDesc == 'Application Receipt'
		* match serverResponseNotificationData == []

@getBondFormData
Scenario: AddAndValidateBondForm on Fee & bond Page 
Given path '/internalapi/api/licensing/fees/bond/company/'+companyName
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request ""
	  When method get
	  Then status 200
	  And print response
	  * def bondCmpId = response.bondCompanyId
	  * def bondCmpName = response.companyName
		* def bondCmpName = response.companyName
		* def bondCmpaddress = response.address
		* def bondCmpCity = response.city
		* def bondCmpST = response.state
		* def bondCmpZip = response.zip
		* def bondCmpPhone = response.phone
		* def bondCmpCreatedDate = response.createdDate
		* def bondCmpModifiedBy = response.modifiedBy
		* def bondCmpEmail = response.email
		
@FeesValidationWithBondData
Scenario: FeesValidationWithBondData     
	Given path '/internalapi/api/licensing/fees/licenses/get/'+appId
      And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {}
	  When method get
	  Then status 200
	  And def serverResponse = response
	  * def licTerm = serverResponse[0].term
	  * def licFees = serverResponse[0].licensingFees+''
	  * def licTermDesc = serverResponse[0].termDesc
	  * def licFeesRefId =  serverResponse[0].feesRefId
	  * def licAncillaryFees = serverResponse[0].ancillaryFees+''
	  * def licfilingFees = serverResponse[0].filingFees+''
	  * def licInitialFees = serverResponse[0].initialFees
	  * def bndFees = serverResponse[0].bondFee
	  * def isBondRequired = serverResponse[0].isBondRequired
	  And def totalFees = serverResponse[0].licensingFees+serverResponse[0].filingFees
	  And print totalFees  
	  * def underpaidAmount = totalFees-amount
	  * def amountPaid = amount+''
	  And print 'underpaidAmount- ',underpaidAmount
	  
	  
 	Given path '/internalapi/api/notification/SaveNotification'
      
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {"applicant":{"communicationId":8531,"email":'#(emailId)',"appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"}
	  When method post
	  Then status 200
	  And print response
	  
	  
	
	  
	  Given path 'internalapi/api/licensing/fees/details/save/'+appId+'/false'
      And header Content-Type = 'application/json; charset=utf-8'
  	  * def futureDateFunc =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
		    
		    var date = new java.util.Date();
		    var dayAfter = new java.util.Date(date.getTime() + java.util.concurrent.TimeUnit.DAYS.toMillis( 30 ));
		    return sdf.format(dayAfter);
		  } 
		  """
		  
		 
		   * def getDate2 =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		  """
		  
  	  * def date = getDate2()
  	   
  	  
	  * def futureDate = futureDateFunc()
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
     			  
      And request {"checks":[{"appId":'#(appId)',"slaintakeDate":'#(date)',"applyClick":false,"paymentSource":"RDC","checkNo":"1","batchNo":1,"itemNo":1,"slareceivedDate":'#(date)',"amount":'#(amountPaid)'}],"appFees":{"appFees":[{"licenseName":'#(description)',"applicationId":'#(ApplicationId)',"applicationTypeId":1,"appFeesId":0,"appId":'#(appId)',"feesRefId":'#(licFeesRefId)',"initialFees":0,"licensingFees":'#(licenseFees)',"amendmentFees":"0.00","renewalFees":"0.00","totalFees":'#(totalFees)',"filingFees":'#(licfilingFees)',"ancillaryFees":"0.00","isFeesWaived":false,"underPaymentAmount":'#(totalFees)',"amountReceived":"0.00","waivedComment":null,"isBondReceived":'#(isBondRequired)',"isBondRequired":'#(isBondRequired)',"bondFee":'#(bndFees)',"term":'#(licTerm)',"termDesc":'#(licTermDesc)',"seasonalStartDate":null,"seasonalEndDate":null,"isFeesCountBased":false,"isFeesUnitBased":false,"numOfUnits":0,"paymentDetails":[],"lateFee":0,"isFeesBarPerDay":null}],"bondDetails":null,"isPaymentFailed":false,"isUnderpaid":true,"sendNotification":false,"fundDueDate":'#(fundDueDate)',"emailNotificationDetail":{"applicant":{"communicationId":15102,"email":'#(emailId)',"appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"}},"notificationDetails":{"applicant":{"communicationId":15102,"email":'#(emailId)',"appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"},"taskId":null}
     When method post
	  Then status 200

  Given path 'internalapi/api/licensing/fees/check-payments/get/'+appId
    And header authorization = 'Bearer ' + strToken
    And request {}
    When method get
    Then status 200
    And def checkDetailId = response[0].checkDetailId
    And print checkDetailId
 
   Given path '/internalapi/api/licensing/fees/details/save/'+appId+'/false'
      And header Content-Type = 'application/json; charset=utf-8'
  	  * def futureDateFunc =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
		    
		    var date = new java.util.Date();
		    var dayAfter = new java.util.Date(date.getTime() + java.util.concurrent.TimeUnit.DAYS.toMillis( 30 ));
		    return sdf.format(dayAfter);
		  } 
		  """
 	* def futureDate = futureDateFunc()
		   * def getDate2 =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		  """
  	  * def date = getDate2()

      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {"checks":[{"appId":'#(appId)',"slaintakeDate":'#(date)',"applyClick":false,"paymentSource":"RDC","checkNo":"1","batchNo":1,"itemNo":1,"slareceivedDate":'#(date)',"amount":'#(totalFees)'}],"appFees":{"appFees":[{"licenseName":'#(description)',"applicationId":'#(ApplicationId)',"applicationTypeId":1,"appFeesId":0,"appId":'#(appId)',"feesRefId":'#(licFeesRefId)',"initialFees":'#(licInitialFees)',"licensingFees":'#(licenseFees)',"amendmentFees":"0.00","renewalFees":'#(renewalFees)',"totalFees":'#(totalFees)',"filingFees":'#(licfilingFees)',"ancillaryFees":'#(licAncillaryFees)',"isFeesWaived":false,"underPaymentAmount":'#(totalFees)',"amountReceived":"0.00","waivedComment":null,"isBondReceived":'#(isBondRequired)',"isBondRequired":'#(isBondRequired)',"bondFee":'#(bndFees)',"term":'#(termInYears)',"termDesc":'#(termDesc)',"seasonalStartDate":null,"seasonalEndDate":null,"isFeesCountBased":false,"isFeesUnitBased":false,"numOfUnits":0,"paymentDetails":[],"lateFee":0,"isFeesBarPerDay":null}],"bondDetails":null,"isPaymentFailed":false,"isUnderpaid":true,"sendNotification":false,"fundDueDate":'#(fundDueDate)',"emailNotificationDetail":{"applicant":{"communicationId":8531,"email":'#(emailId)',"appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"}},"notificationDetails":{"applicant":{"communicationId":8531,"email":'#(emailId)',"appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"},"taskId":null}
	 			  
	 
	  When method post
	  Then status 200
	 

   
   

# ********* SAVE Application Details To Save *********************
    Given path '/internalapi/api/licensing/app/save'
    And header authorization = 'Bearer ' + strToken
    And request {"isApproved":false,"appId":'#(appId)',"formID":'#(formId)',"applicationID":'#(ApplicationId)',"formName":'#(description)',"formType":{},"formTypeId":null,"applicationType":{},"applicationTypeId":null,"formCategory":{},"formCategoryId":null,"approvalFlag":null,"status":"","createdBy":"","createdDate":"","modifiedBy":"","sections":[{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1842,"key":"","label":"Signature","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1843,"key":"","label":"Date","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1851,"key":"","label":"Title","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"dropdown","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2232,"key":"","label":"First Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2233,"key":"","label":"Middle Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2234,"key":"","label":"Last Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1200,"sectionName":"","key":"0","label":"Applicant Statement","order":9,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1957,"key":"","label":"By what right does the applicant have possession of the premises?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1958,"key":"","label":"Explain","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1959,"key":"","label":"Do the terms of the lease or other arrangement require the applicant to provide any consideration based on a percentage of the receipts of the business?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1960,"key":"","label":"If yes, list the section/page of the lease this information can be found","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1961,"key":"","label":"Does or will anyone other than the applicant/principals share on a percentage basis or in any way in the receipts, losses, or deficiencies of the business to any extent whatsoever","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1226,"sectionName":"","key":"0","label":"Right to Premises","order":5,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1685,"key":"","label":"First Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1686,"key":"","label":"Middle Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1687,"key":"","label":"Last Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"1 wall street","fieldID":1697,"key":"","label":"Address Line 1/ POB #","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":6,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1698,"key":"","label":"Address Line 2","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":7,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":'#(CityName)',"fieldID":1699,"key":"","label":"City","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":8,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1700,"key":"","label":"State/Region","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":9,"controlType":"dropdown","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"10011","fieldID":1701,"key":"","label":"Zip/Postal Code","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":10,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1754,"key":"","label":"Address","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"label","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1934,"key":"","label":"Nature of Interest","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1935,"key":"","label":"Date acquired","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1218,"sectionName":"","key":"0","label":"Other Interested","order":1,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]}],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1933,"key":"","label":"Signature","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1936,"key":"","label":"Date","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1239,"sectionName":"","key":"0","label":"Bulletin 254","order":10,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2053,"key":"","label":"Describe the area where the premises is to be located","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2054,"key":"","label":"State what the area is zoned for","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2055,"key":"","label":"Provide a description of the premises to be licensed. Describe all building/structures that will be utilized in business operations including the number of floors in each.","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2056,"key":"","label":"has the building/premises been known by any other address?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2057,"key":"","label":"If yes, please Specify","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2058,"key":"","label":"has the premises to be licensed and or any other floor in the building been previously licensed or currently licensed to traffic in alcoholic beverages?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2059,"key":"","label":"What was the prior use of the premises to be licensed?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":6,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2060,"key":"","label":"Does the proposed location of the business comply with all state and local regulations and zoning codes?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":7,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2061,"key":"","label":"is there interior access to any other floor that will not be part of the licensed premises?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":8,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2062,"key":"","label":"if yes, list floor and means of access to each floor.","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":9,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2063,"key":"","label":"Does any other person have access to this area?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":10,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2064,"key":"","label":"where will the alcohol be stored","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":11,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2065,"key":"","label":"if applying for a farm winery license, special farm winery license or micro winery license, the premises must be located on a farm. In the box below, please provide a detailed description of the agricultural production that qualifies the premises as a farm","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":12,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1248,"sectionName":"","key":"0","label":"Premises Questionnaire","order":7,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1988,"key":"","label":"Will any other business of any kind be conducted on said premises?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1989,"key":"","label":"How many Employees?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1990,"key":"","label":"If answer is 0, provide explanation","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1991,"key":"","label":"Workers' Compensation Carrier Name and Policy Number?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1992,"key":"","label":"Disability Insurance Carrier name and policy Number","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2050,"key":"","label":"Check all activities the business will engage in","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"checkbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1249,"sectionName":"","key":"0","label":"Method of Operation","order":8,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2072,"key":"","label":"Real Property","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2073,"key":"","label":"Purchase/Contract Price of Business","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2074,"key":"","label":"Renovations/Improvement Costs","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2075,"key":"","label":"Miscellaneous","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2076,"key":"","label":"Cash","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"label","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2077,"key":"","label":"Source of Funds","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2078,"key":"","label":"Personal Questionnaire attached","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":6,"controlType":"checkbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2079,"key":"","label":"Dollar Amount","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":7,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2080,"key":"","label":"Total Cash","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":8,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2081,"key":"","label":"Borrowed","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":9,"controlType":"label","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2082,"key":"","label":"Source of Funds","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":10,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2083,"key":"","label":"Personal Questionnaire attached","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":11,"controlType":"checkbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2084,"key":"","label":"Dollar Amount","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":12,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2085,"key":"","label":"Total Borrowed","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":13,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2086,"key":"","label":"Total Investment","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":14,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2087,"key":"","label":"Have all investors been disclosed in this application","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":15,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1253,"sectionName":"","key":"0","label":"Financial Disclosure","order":6,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]}],"formVersionId":1231,"version":7,"licenseDescription":"","statusDescription":"Draft","appStatusId":1,"showApplicant":true,"showRepresentative":true,"showPrincipal":true,"showLandlord":true,"showVehicles":false,"showSchedule":false,"staticTabSequence":{"Applicant Information":0,"Principal":1,"Representative":2,"Landlord Identification":3,"Personal Questionnaire":4},"staticTaborder":["Applicant Information","Principal","Representative","Landlord Identification","Personal Questionnaire"],"showPQ":true}
    When method post
    Then status 200
   
    
    Given path '/internalapi/api/licensing/fees/licenses/get/'+appId
        And header authorization = 'Bearer ' + strToken
        And header Content-Type = 'application/json; charset=utf-8'
   		And header Accept = 'application/json; text/plain;*/*'
  		And request ""
		When method get
		Then status 200
		And print response[0].appFeesId
		And def appFeesId1 = response[0].appFeesId
		And def feesRefId1 = response[0].feesRefId
		And print appFeesId1
		And print feesRefId1 
		And def applicationTypeId = response[0].applicationTypeId
		And print applicationTypeId 
# ********* Save PAYMENT ********************* 
    
    Given path '/internalapi/api/licensing/fees/details/save/'+appId +'/false'
     
		* def slaDate = licFeesDate()
		* def slaaDate = licDate()
		* def licInitialFees1 = licInitialFees+''
		And print licInitialFees1
		* def renewalFees1 = renewalFees+''
		And print renewalFees1
		* def totalFees1 = totalFees+''
		
		And print totalFees1
		* def licAncillaryFees1 = licAncillaryFees+''
		* def licfilingFees1 = licfilingFees+''
		
		And header authorization = 'Bearer ' + strToken 
		And request {"checks":[{"checkDetailId":'#(checkDetailId)',"appId":'#(appId)',"paymentSource":"RDC","checkNo":"1","batchNo":"1","itemNo":"1","slareceivedDate":'#(date)',"slaintakeDate":'#(date)',"amount":'#(amountPaid)',"appliedTo":null,"amountUsed":'#(amountPaid)',"comment":null,"isReplacement":null,"replacementReason":null,"isActive":true,"createdBy":"tgupta@svam.com","createdDate":'#(date)',"modifiedBy":null,"modifiedDate":null,"applyClick":true,"amountAvailable":0}],"appFees":{"appFees":[{"licenseName":'#(description)',"applicationId":'#(ApplicationId)',"applicationTypeId":1,"appFeesId":'#(licFeesRefId)',"appId":'#(appId)',"feesRefId":'#(licFeesRefId)',"initialFees":0,"licensingFees":'#(licenseFees)',"amendmentFees":"0.00","renewalFees":"0.00","totalFees":'#(totalFees1)',"filingFees":'#(licfilingFees1)',"ancillaryFees":"0.00","isFeesWaived":false,"underPaymentAmount":'#(underpaidAmount)',"amountReceived":'#(amountPaid)',"waivedComment":null,"isBondReceived":'#(isBondRequired)',"isBondRequired":'#(isBondRequired)',"bondFee":'#(bndFees)',"term":'#(termInYears)',"termDesc":'#(termDesc)',"seasonalStartDate":null,"seasonalEndDate":null,"isFeesCountBased":false,"isFeesUnitBased":false,"numOfUnits":0,"paymentDetails":[{"appId":'#(appId)',"checkDetailId":'#(checkDetailId)',"checkNo":"1","itemNo":"1","batchNo":"1","amountAppliedForApp":'#(amountPaid)',"amount":0}],"lateFee":0,"isFeesBarPerDay":null}],"bondDetails":[{"bondDetailId":0,"bondNo":'#(bondCmpId)',"appId":'#(appId)',"companyName":'#(bondCmpName)',"address1":"","city":'#(bondCmpCity)',"state":'#(bondCmpST)',"zipCode":"","phone":'#(bondCmpPhone)',"email":"","isActive":false,"createdBy":"","createdDate":'#(bondCmpCreatedDate)',"modifiedBy":'#(bondCmpModifiedBy)',"modifiedDate":null,"amount":'#(bndFees)',"address":'#(bondCmpaddress)',"zip":'#(bondCmpZip)',"emailAddress":'#(bondCmpEmail)',"expirationDate":2025}],"isPaymentFailed":false,"isUnderpaid":false,"sendNotification":false,"fundDueDate":'#(fundDueDate)',"emailNotificationDetail":{"applicant":{"appId":'#(appId)'},"attorney":{},"communityBoard":{},"other":{},"isInstantEmail":false,"appId":'#(appId)'}},"notificationDetails":{"applicant":{"appId":'#(appId)'},"attorney":{},"communityBoard":{},"other":{},"isInstantEmail":false,"appId":'#(appId)'},"taskId":null}
		
		When method post
	    Then status 200
	    And print response
    



@updateBodyFormData
Scenario: VerifyBondData on Fee & bond Page 

	Given path '/internalapi/api/licensing/fees/licenses/get/'+appId
      And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {}
	  When method get
	  Then status 200
	  And def serverResponse = response
	  * def appPaymentId = serverResponse[0].paymentDetails[0].appPaymentId
	  * def amountAppliedForApp = serverResponse[0].paymentDetails[0].amountAppliedForApp + ""
	 
 Given path '/internalapi/api/licensing/fees/details/save/'+appId +'/false'
     
		* def slaDate = licFeesDate()
		* def slaaDate = licDate()
		* def licInitialFees1 = licInitialFees+''
		And print licInitialFees1
		* def renewalFees1 = renewalFees+''
		And print renewalFees1
		* def totalFees1 = totalFees+''
		
		And print totalFees1
		* def licAncillaryFees1 = licAncillaryFees+''
		* def licfilingFees1 = licfilingFees+''
		
		And header authorization = 'Bearer ' + strToken 
		And request {"checks":[{"checkDetailId":'#(checkDetailId)',"appId":'#(appId)',"paymentSource":"RDC","checkNo":"1","batchNo":"1","itemNo":"1","slareceivedDate":'#(date)',"slaintakeDate":'#(date)',"amount":'#(amountPaid)',"isPaymentFailed":false,"appliedTo":null,"amountUsed":'#(amountPaid)',"comment":null,"isReplacement":null,"replacementReason":null,"isActive":true,"createdBy":"tgupta@svam.com","createdDate":'#(date)',"modifiedBy":null,"modifiedDate":null,"applyClick":true}],"appFees":{"appFees":[{"licenseName":'#(description)',"applicationId":'#(ApplicationId)',"applicationTypeId":1,"appFeesId":'#(licFeesRefId)',"appId":'#(appId)',"feesRefId":'#(licFeesRefId)',"initialFees":0,"licensingFees":'#(licenseFees)',"amendmentFees":"0.00","renewalFees":"0.00","totalFees":'#(totalFees1)',"filingFees":'#(licfilingFees1)',"ancillaryFees":"0.00","isFeesWaived":false,"underPaymentAmount":'#(underpaidAmount)',"amountReceived":'#(amountPaid)',"waivedComment":null,"isBondReceived":'#(isBondRequired)',"isBondRequired":'#(isBondRequired)',"bondFee":'#(bndFees)',"term":'#(termInYears)',"termDesc":'#(termDesc)',"seasonalStartDate":null,"seasonalEndDate":null,"isFeesCountBased":false,"isFeesUnitBased":false,"numOfUnits":0,"paymentDetails":[{"appPaymentId":'#(appPaymentId)',"amountAppliedForApp":'#(amountAppliedForApp)',"checkDetailId":'#(checkDetailId)',"appId":'#(appId)',"paymentSource":"RDC","checkNo":"1","batchNo":"1","itemNo":"1","slareceivedDate":'#(date)',"slaintakeDate":'#(date)',"amount":0,"isPaymentFailed":null,"appliedTo":null,"amountUsed":null,"comment":null,"isReplacement":null,"replacementReason":null,"isActive":true,"createdBy":null,"createdDate":'#(date)',"modifiedBy":"tgupta@svam.com","modifiedDate":null}],"lateFee":0,"isFeesBarPerDay":null}],"isFromReturnedCheck":false,"bondDetails":[{"bondId":'#(bondId)',"bondNo":'#(bondCmpId)',"amount":'#(bndFees)',"claimDate":null,"claimedAmt":null,"companyName":'#(bondCmpName)',"emailAddress":'#(bondCmpEmail)',"createdBy":"tgupta@svam.com","createdDate":'#(bondCmpCreatedDate)',"modifiedBy":"tgupta@svam.com","modifiedDate":null,"isActive":true,"appId":'#(appId)',"expirationDate":"2025","address":'#(bondCmpaddress)',"city":'#(bondCmpCity)',"state":'#(bondCmpST)',"zip":'#(bondCmpZip)',"phone":'#(bondCmpPhone)'}],"isPaymentFailed":false,"isUnderpaid":true,"sendNotification":true,"fundDueDate":'#(date)',"emailNotificationDetail":{"applicant":{"communicationId":28517,"email":"automation@svam.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":28520,"email":"sbandi@svam.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"}},"notificationDetails":{"applicant":{"communicationId":28517,"email":"automation@svam.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":28520,"email":"sbandi@svam.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"},"taskId":null}
		       
		When method post
	    Then status 200
	    And print response
    
@VerifyBondData
Scenario: VerifyBondData on Fee & bond Page 
Given path 'internalapi/api/licensing/fees/bond/bond-info/get/'+appId
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request ""
	  When method get
	  Then status 200
	  And print response
	  	* def bondId = response[0].bondId
	  	* def actBondCmpId = response[0].bondNo
	 	* def actBondCmpName = response[0].companyName
		* def actBondCmpaddress = response[0].address
		* def actBondCmpCity = response[0].city
		* def actBondCmpST = response[0].state
		* def actBondCmpZip = response[0].zip
		* def actBondCmpPhone = response[0].phone
		
		* def actBondCmpModifiedBy = response[0].modifiedBy
		* def actBondCmpEmail = response[0].emailAddress
  		* match  (bondCmpId+'') == (actBondCmpId)
  		* match  bondCmpName == actBondCmpName
  		* match  bondCmpaddress == actBondCmpaddress
  		* match  bondCmpCity == actBondCmpCity
  		* match  bondCmpST == actBondCmpST
  		* match  bondCmpZip == actBondCmpZip
  		* match  bondCmpPhone == actBondCmpPhone
  		* match  bondCmpEmail == actBondCmpEmail
  		
  		
  		

@getGisReportByAppId  		
Scenario: getGisReportByAppId Data
Given path '/internalapi/api/licensing/GisReport/getGISReportsByAppId/'+appId
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request ""
	  When method get
	  Then status 200
	 * def liquorStoreResponseData = response.typeList[0]
	 
@getGisReport  		
Scenario: getGisReport on Page Data
Given path 'internalapi/api/licensing/GisReport/'+appId
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request ""
	  When method get
	  Then status 200
	  
	  
	  * def schoolData = karate.jsonPath(response.typeList[0], "$[?(@.type == 'School')]")
	  * def ChurchData = karate.jsonPath(response.typeList[1], "$[?(@.type == 'Church')]")
	  * def liquorStoreData = karate.jsonPath(response.typeList[2], "$[?(@.type == 'liquorStore')]")
	  * def onPremiseLicenses750ftData = karate.jsonPath(response.typeList[3], "$[?(@.type == 'onPremiseLicenses750ft')]")
	  * def OnPremises2Data = karate.jsonPath(response.typeList[4], "$[?(@.type == 'OnPremises2')]")
	  * def OnPremises3Data = karate.jsonPath(response.typeList[5], "$[?(@.type == 'OnPremises3')]")
	  * def OnPremises4Data = karate.jsonPath(response.typeList[6], "$[?(@.type == 'OnPremises4')]")
	 * match schoolData != null 
	 * match schoolData != []
	 * match ChurchData != null 
	 * match ChurchData != []
	 * match liquorStoreData != null 
	 * match liquorStoreData != []
	 * match onPremiseLicenses750ftData != null 
	 * match onPremiseLicenses750ftData != []
	 * match OnPremises2Data != null 
	 * match OnPremises2Data != []
	  * match OnPremises3Data != null 
	 * match OnPremises3Data != []
	  * match OnPremises4Data != null 
	 * match OnPremises4Data != []
	 And print liquorStoreData[0]
	 * def liqourID = liquorStoreData[0].id
	 * def liqourType = liquorStoreData[0].type
	 * def liqourTypeName = liquorStoreData[0].typeName
	 * def liqourAddress = liquorStoreData[0].address 
	 * def liqourDistance = liquorStoreData[0].approxDistance
 
	
	 
@SaveGrossSalesReport  		
Scenario: SaveGrossSalesReport Data

Given path '/internalapi/api/licensing/GISReport/SaveGrossSalesReport'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request [{"id":'#(liqourID)',"type":'#(liqourType)',"typeName":'#(liqourTypeName)',"address":'#(liqourAddress)',"approxDistance":'#(liqourDistance)',"isReportReceived":false,"isSelected":true,"isSentToEnforcement":false,"isMailNotification":false,"isSent":null,"licenseId":67435,"appId":'#(appId)',"workFlowStatus":0,"isSubmit":false,"roleId":0,"workFlowCondition":0,"churchComments":null,"schoolComments":null,"comments":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}]
      When method Post
	  Then status 200
	  * match response == 'true'
	  
	  
@UpdateGISReportDecision  		
Scenario: UpdateGISReportDecision Data
	Given path '/internalapi/api/licensing/GisReport/updateDecision'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {"appId":'#(appId)',"workFlowStatus":1101,"isSubmit":true}
	  When method post
	  Then status 200
	
	  * match response == 'true'
	
@GISReferToEnforcement  		
Scenario: GISReferToEnforcement Data

	Given path '/internalapi/api/licensing/GISReport/SaveGrossSalesReport'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request [{"id":'#(TypeId)',"type":'#(Type)',"typeName":'#(TypeName)',"address":'#(TypeAddress)',"approxDistance":'#(TypeApproxDistance)',"isReportReceived":false,"isSelected":true,"isSentToEnforcement":false,"isMailNotification":false,"isSent":null,"licenseId":'#(licenseId)',"appId":'#(appId)',"workFlowStatus":0,"isSubmit":false,"roleId":0,"workFlowCondition":0,"churchComments":null,"schoolComments":null,"comments":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}]
      When method Post
	  Then status 200
	  * match response == 'true'
	Given path '/internalapi/api/licensing/GISReport/ReferToEnforcement'
  	  And header Content-Type = 'application/json;'
     
      And header current-wfroleid = '4'
      And header authorization = 'Bearer ' + strToken
      And request {"id":'#(TypeId)',"type":'#(Type)',"typeName":'#(TypeName)',"address":'#(TypeAddress)',"approxDistance":'#(TypeApproxDistance)',"isReportReceived":false,"isSelected":true,"isSentToEnforcement":true,"isMailNotification":false,"isSent":null,"licenseId":'#(licenseId)',"appId":'#(appId)',"workFlowStatus":0,"isSubmit":false,"roleId":0,"workFlowCondition":0,"churchComments":'#(churchComments)',"schoolComments":'#(schoolComments)',"comments":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}
	  When method post
	  Then status 200
	* match response == 'true'
	  
@getTodayReferedEnforcementCount  		
Scenario: getTodayReferedEnforcementCount Data	  	
	    * def getCurrentDate =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		  """
		* def currentDate = getCurrentDate()
	  Given path '/internalapi/api/EnforcementDashboard/InFromLicensingQueue/'
	
	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      * def stringParam = "assignedDate~gte~datetime'"+currentDate+"T00-00-00'"
      And params  {filter:'#(stringParam)',page:1,sort:'applicationStatus-asc'}
     
      And request ""
	  When method get
	  Then status 200
	  And print response
	  * def totalEnfCount = response.total 
	  
	  
@ValidateGISReportPDF  		
Scenario: UpdateGISReportDecision Data
Given path '/internalapi/api/notification/Application/email/download/'+appId
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {"appId":'#(appId)',"workFlowStatus":1101,"isSubmit":true}
	  When method post
	  Then status 200
	
	  * match response == 'true'
	
	
@SearchLicenseApplicationByCriteria  		
Scenario: SearchLicenseApplicationByCriteria 
Given path '/internalapi/api/licensing/search/searchLicenseApplicationByCriteria'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {"WfTaskIdList":[],"LicenseStatusList":[],"Status":null,"isTempPermit":null,"ApplicationId":'#(ApplicationId)',"LicensePermitId":null,"LegalName":null,"FEIN":null}

	  When method post
	  Then status 200
	
	  * match response.apps[0].taskStatus == expLicStatus
	

	  
	  
	  
	  
	  
@GetAndValidateDueDateForLicense  		
Scenario: GetAndValidateDueDateForLicense 
	 Given path '/internalapi/api/licensing/new-license/getDueDates/'+appId
        And header authorization = 'Bearer ' + strToken
        And header Content-Type = 'application/json; charset=utf-8'
   		And header Accept = 'application/json; text/plain;*/*'
  		And request ""
		When method get
		Then status 200
		
		And def reslicAction = response[1].action
		And def resAppStatus = response[1].applicationStatus
		And def resAppDueDate = response[1].dueDate
		And print reslicAction
		And print resAppStatus 
		
		And print resAppDueDate 
	     * match reslicAction == licAction
	     * match resAppStatus == appStatus
	     * match resAppDueDate contains dueDate
	     
	     


@FillFeesFormwithPaymentAfterPaymentFailed
Scenario: FeesValidationwithMultipleChecks     
	Given path '/internalapi/api/licensing/fees/licenses/get/'+appId
      And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {}
	  When method get
	  Then status 200
	  And def serverResponse = response
	  * def licTerm = serverResponse[0].term
	  * def licFees = serverResponse[0].licensingFees+'.00'
	  * def licTermDesc = serverResponse[0].termDesc
	  * def licFeesRefId =  serverResponse[0].feesRefId
	  * def licAncillaryFees = serverResponse[0].ancillaryFees+''
	  * def licfilingFees = serverResponse[0].filingFees+''
	  * def licInitialFees = serverResponse[0].initialFees
	  * def bndFees = ~~Math.round(serverResponse[0].bondFee)
	  * def isBondRequired = serverResponse[0].isBondRequired
	  And def totalFees = serverResponse[0].licensingFees+serverResponse[0].filingFees
	  And print totalFees  
	  * def underpaidAmount = ~~Math.round(totalFees-totalAmount)
	  * def amountPaid = totalFees+'.00'
	  And print 'underpaidAmount- ',underpaidAmount
	  
	  Given path 'internalapi/api/licensing/fees/check-payments/get/'+appId
	    And header authorization = 'Bearer ' + strToken
	    And request {}
	    When method get
	    Then status 200
	    And def checkDetailId = response[0].checkDetailId
	    And print checkDetailId
	   
 
   
    Given path '/internalapi/api/licensing/fees/licenses/get/'+appId
        And header authorization = 'Bearer ' + strToken
        And header Content-Type = 'application/json; charset=utf-8'
   		And header Accept = 'application/json; text/plain;*/*'
  		And request ""
		When method get
		Then status 200
		And print response[0].appFeesId
		And def appFeesId1 = response[0].appFeesId
		And def feesRefId1 = response[0].feesRefId
		And print appFeesId1
		And print feesRefId1 
		And def applicationTypeId = response[0].applicationTypeId
		And print applicationTypeId  
	  
 	Given path '/internalapi/api/notification/SaveNotification'
      
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {"applicant":{"communicationId":8531,"email":'#(emailId)',"appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"}
	  When method post
	  Then status 200
	  And print response
	  
	  
	  
	  Given path 'internalapi/api/licensing/fees/details/save/'+appId+'/false'
      And header Content-Type = 'application/json; charset=utf-8'
  	  * def futureDateFunc =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
		    
		    var date = new java.util.Date();
		    var dayAfter = new java.util.Date(date.getTime() + java.util.concurrent.TimeUnit.DAYS.toMillis( 30 ));
		    return sdf.format(dayAfter);
		  } 
		  """
		  
		 
		   * def getDate2 =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		  """
		  
		   * def getDate3 =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.S");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		  """
		  
  	  * def date = getDate2()
  	  * def date3 = getDate3()
  	   
  	  
	  * def futureDate = futureDateFunc()
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
       			  
      And request {"checks":[{"checkDetailId":'#(checkDetailId)',"appId":'#(appId)',"paymentSource":"RDC","checkNo":"1","batchNo":"1","itemNo":"1","slareceivedDate":'#(date)',"slaintakeDate":'#(date)',"amount":'#(previousAmount)',"isPaymentFailed":'#(isPaymentFailed)',"appliedTo":null,"amountUsed":0,"comment":null,"isReplacement":null,"replacementReason":null,"isActive":true,"createdBy":"tgupta@svam.com","createdDate":'#(date3)',"modifiedBy":null,"modifiedDate":null,"applyClick":true},{"appId":'#(appId)',"slaintakeDate":'#(date)',"applyClick":false,"paymentSource":"RDC","checkNo":"2","batchNo":1,"itemNo":1,"slareceivedDate":'#(date)',"amount":'#(totalAmount)'}],"appFees":{"appFees":[{"licenseName":'#(description)',"applicationId":'#(ApplicationId)',"applicationTypeId":1,"appFeesId":'#(appFeesId1)',"appId":'#(appId)',"feesRefId":'#(licFeesRefId)',"initialFees":0,"licensingFees":'#(licFees)',"amendmentFees":"0.00","renewalFees":"0.00","totalFees":'#(amountPaid)',"filingFees":'#(licfilingFees)',"ancillaryFees":'#(licAncillaryFees)',"isFeesWaived":false,"underPaymentAmount":'#(totalFees)',"amountReceived":"0.00","waivedComment":null,"isBondReceived":true,"isBondRequired":'#(isBondRequired)',"bondFee":'#(bndFees)',"term":'#(licTerm)',"termDesc":'#(licTermDesc)',"seasonalStartDate":null,"seasonalEndDate":null,"isFeesCountBased":false,"isFeesUnitBased":false,"numOfUnits":0,"paymentDetails":[],"lateFee":0,"isFeesBarPerDay":null}],"isFromReturnedCheck":true,"bondDetails":null,"isPaymentFailed":false,"isUnderpaid":true,"sendNotification":false,"fundDueDate":'#(fundDueDate1)',"emailNotificationDetail":{"applicant":{"communicationId":71118,"email":'#(appId)',"appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":71121,"email":'#(appId)',"appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"}},"notificationDetails":{"applicant":{"communicationId":71118,"email":'#(emailId)',"appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":71121,"email":"sbandi@svam.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"},"taskId":1304}
    
      #{"checks":[{"checkDetailId":5133,"appId":110540,"paymentSource":"RDC","checkNo":"1","batchNo":"1","itemNo":"1","slareceivedDate":"2022-05-19T04:00:00.000Z","slaintakeDate":"2022-05-19T04:00:00.000Z","amount":"100.00","isPaymentFailed":true,"appliedTo":null,"amountUsed":0,"comment":null,"isReplacement":null,"replacementReason":null,"isActive":true,"createdBy":"tgupta@svam.com","createdDate":"2022-05-19T04:11:07.6","modifiedBy":null,"modifiedDate":null,"applyClick":true},{"appId":110540,"slaintakeDate":"2022-05-19T08:22:58.710Z","applyClick":false,"paymentSource":"RDC","checkNo":"2","batchNo":1,"itemNo":1,"slareceivedDate":"2022-05-19T04:00:00.000Z","amount":960}],"appFees":{"appFees":[{"licenseName":"Restaurant - Beer","applicationId":"NA-0111-22-2107026","applicationTypeId":1,"appFeesId":7588,"appId":110540,"feesRefId":6039,"initialFees":0,"licensingFees":"960.00","amendmentFees":"0.00","renewalFees":"0.00","totalFees":"1060.00","filingFees":"100.00","ancillaryFees":"0.00","isFeesWaived":false,"underPaymentAmount":1060,"amountReceived":"0.00","waivedComment":null,"isBondReceived":true,"isBondRequired":true,"bondFee":1000,"term":3,"termDesc":"3 Year (s)","seasonalStartDate":null,"seasonalEndDate":null,"isFeesCountBased":false,"isFeesUnitBased":false,"numOfUnits":0,"paymentDetails":[],"lateFee":0,"isFeesBarPerDay":null}],"isFromReturnedCheck":true,"bondDetails":null,"isPaymentFailed":false,"isUnderpaid":true,"sendNotification":false,"fundDueDate":"2022-05-29T00:00:00.000Z","emailNotificationDetail":{"applicant":{"communicationId":71130,"email":"automation@svam.com","appId":110540,"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":71133,"email":"sbandi@svam.com","appId":110540,"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":110540,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":110540,"createdBy":"Tarun  Gupta"}},"notificationDetails":{"applicant":{"communicationId":71130,"email":"automation@svam.com","appId":110540,"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":71133,"email":"sbandi@svam.com","appId":110540,"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":110540,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":110540,"createdBy":"Tarun  Gupta"},"taskId":1304}
      
      # {"checks":[{"checkDetailId":5135,"appId":110541,"paymentSource":"RDC","checkNo":"1","batchNo":"1","itemNo":"1","slareceivedDate":"2022-05-19T04:36:32.783Z","slaintakeDate":"2022-05-19T04:36:32.783Z","amount":"100.00","isPaymentFailed":true,"appliedTo":null,"amountUsed":0,"comment":null,"isReplacement":null,"replacementReason":null,"isActive":true,"createdBy":"tgupta@svam.com","createdDate":"2022-05-19T04:36:32.784","modifiedBy":null,"modifiedDate":null,"applyClick":true},{"appId":110541,"slaintakeDate":"2022-05-19T04:36:32.783Z","applyClick":false,"paymentSource":"RDC","checkNo":"2","batchNo":1,"itemNo":1,"slareceivedDate":"2022-05-19T04:36:32.783Z","amount":960.0}],"appFees":{"appFees":[{"licenseName":"Restaurant-Beer","applicationId":"NA-0111-22-2107027","applicationTypeId":1,"appFeesId":7589,"appId":110541,"feesRefId":6039,"initialFees":0,"licensingFees":960,"amendmentFees":"0.00","renewalFees":"0.00","totalFees":1060.0,"filingFees":"100","ancillaryFees":"0","isFeesWaived":false,"underPaymentAmount":1060.0,"amountReceived":"0.00","waivedComment":null,"isBondReceived":"0","isBondRequired":true,"bondFee":1000.0,"term":3,"termDesc":"3 Year (s)","seasonalStartDate":null,"seasonalEndDate":null,"isFeesCountBased":false,"isFeesUnitBased":false,"numOfUnits":0,"paymentDetails":[],"lateFee":0,"isFeesBarPerDay":null}],"isFromReturnedCheck":true,"bondDetails":null,"isPaymentFailed":false,"isUnderpaid":true,"sendNotification":false,"fundDueDate":"2022-05-29","emailNotificationDetail":{"applicant":{"communicationId":71118,"email":110541,"appId":110541,"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":71121,"email":110541,"appId":110541,"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":110541,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":110541,"createdBy":"Tarun  Gupta"}},"notificationDetails":{"applicant":{"communicationId":71118,"email":"automation@svam.com","appId":110541,"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":71121,"email":"sbandi@svam.com","appId":110541,"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":110541,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":110541,"createdBy":"Tarun  Gupta"},"taskId":null}
     When method post
	  Then status 200

  Given path 'internalapi/api/licensing/fees/check-payments/get/'+appId
	    And header authorization = 'Bearer ' + strToken
	    And request {}
	    When method get
	    Then status 200
	    And def checkDetailId = response[0].checkDetailId
	    And print checkDetailId
	     And def checkDetailId1 = response[1].checkDetailId
	    And print checkDetailId1
# ********* Save PAYMENT ********************* 
    
    Given path '/internalapi/api/licensing/fees/details/save/'+appId +'/false'
     
		* def slaDate = licFeesDate()
		* def slaaDate = licDate()
		* def licInitialFees1 = licInitialFees+''
		And print licInitialFees1
		* def renewalFees1 = renewalFees+''
		And print renewalFees1
		* def totalFees1 = totalFees+''
		
		And print totalFees1
		* def licAncillaryFees1 = licAncillaryFees+''
		* def licfilingFees1 = licfilingFees+''
			
	    And header authorization = 'Bearer ' + strToken
		And request {"checks":[{"checkDetailId":'#(checkDetailId)',"appId":'#(appId)',"paymentSource":"RDC","checkNo":"1","batchNo":"1","itemNo":"1","slareceivedDate":'#(date)',"slaintakeDate":'#(date)',"amount":'#(previousAmount)',"isPaymentFailed":'#(isPaymentFailed)',"appliedTo":null,"amountUsed":0,"comment":null,"isReplacement":null,"replacementReason":null,"isActive":true,"createdBy":"tgupta@svam.com","createdDate":'#(date)',"modifiedBy":null,"modifiedDate":null,"applyClick":true,"amountAvailable":'#(amount)'},{"checkDetailId":'#(checkDetailId1)',"appId":'#(appId)',"paymentSource":"RDC","checkNo":"2","batchNo":"1","itemNo":"1","slareceivedDate":'#(date)',"slaintakeDate":'#(date)',"amount":'#(totalAmountStr)',"appliedTo":null,"amountUsed":'#(totalAmount)',"comment":null,"isReplacement":null,"replacementReason":null,"isActive":true,"createdBy":"tgupta@svam.com","createdDate":'#(date)',"modifiedBy":null,"modifiedDate":null,"applyClick":true,"amountAvailable":0}],"appFees":{"appFees":[{"licenseName":'#(description)',"applicationId":'#(ApplicationId)',"applicationTypeId":1,"appFeesId":'#(licFeesRefId)',"appId":'#(appId)',"feesRefId":'#(licFeesRefId)',"initialFees":0,"licensingFees":'#(licFees)',"amendmentFees":"0.00","renewalFees":"0.00","totalFees":'#(totalFees)',"filingFees":'#(licfilingFees1)',"ancillaryFees":'#(licAncillaryFees)',"isFeesWaived":false,"underPaymentAmount":'#(underpaidAmount)',"amountReceived":'#(totalAmount)',"waivedComment":null,"isBondReceived":false,"isBondRequired":'#(isBondRequired)',"bondFee":'#(bndFees)',"term":'#(termInYears)',"termDesc":'#(termDesc)',"seasonalStartDate":null,"seasonalEndDate":null,"isFeesCountBased":false,"isFeesUnitBased":false,"numOfUnits":0,"paymentDetails":[{"appId":'#(appId)',"checkDetailId":'#(checkDetailId1)',"checkNo":"2","itemNo":"1","batchNo":"1","amountAppliedForApp":'#(totalAmount)',"amount":0}],"lateFee":0,"isFeesBarPerDay":null}],"isFromReturnedCheck":true,"bondDetails":null,"isPaymentFailed":false,"isUnderpaid":true,"sendNotification":true,"fundDueDate":'#(fundDueDate1)',"emailNotificationDetail":{"applicant":{"communicationId":71118,"email":"automation@svam.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":71121,"email":"sbandi@svam.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"}},"notificationDetails":{"applicant":{"communicationId":71118,"email":"automation@svam.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":71121,"email":"sbandi@svam.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"},"taskId":1304}
		When method post
	    Then status 200
	    And print response 
    
    
    
# ********* SAVE Application Details To Save *********************
    Given path '/internalapi/api/licensing/app/save'
	    And header authorization = 'Bearer ' + strToken
	    And request {"isApproved":false,"appId":'#(appId)',"formID":'#(formId)',"applicationID":'#(ApplicationId)',"formName":'#(description)',"formType":{},"formTypeId":null,"applicationType":{},"applicationTypeId":null,"formCategory":{},"formCategoryId":null,"approvalFlag":null,"status":"","createdBy":"","createdDate":"","modifiedBy":"","sections":[{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1842,"key":"","label":"Signature","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1843,"key":"","label":"Date","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1851,"key":"","label":"Title","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"dropdown","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2232,"key":"","label":"First Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2233,"key":"","label":"Middle Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2234,"key":"","label":"Last Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1200,"sectionName":"","key":"0","label":"Applicant Statement","order":9,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1957,"key":"","label":"By what right does the applicant have possession of the premises?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1958,"key":"","label":"Explain","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1959,"key":"","label":"Do the terms of the lease or other arrangement require the applicant to provide any consideration based on a percentage of the receipts of the business?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1960,"key":"","label":"If yes, list the section/page of the lease this information can be found","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1961,"key":"","label":"Does or will anyone other than the applicant/principals share on a percentage basis or in any way in the receipts, losses, or deficiencies of the business to any extent whatsoever","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1226,"sectionName":"","key":"0","label":"Right to Premises","order":5,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1685,"key":"","label":"First Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1686,"key":"","label":"Middle Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1687,"key":"","label":"Last Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"1 wall street","fieldID":1697,"key":"","label":"Address Line 1/ POB #","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":6,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1698,"key":"","label":"Address Line 2","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":7,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":'#(CityName)',"fieldID":1699,"key":"","label":"City","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":8,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1700,"key":"","label":"State/Region","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":9,"controlType":"dropdown","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"10011","fieldID":1701,"key":"","label":"Zip/Postal Code","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":10,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1754,"key":"","label":"Address","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"label","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1934,"key":"","label":"Nature of Interest","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1935,"key":"","label":"Date acquired","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1218,"sectionName":"","key":"0","label":"Other Interested","order":1,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]}],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1933,"key":"","label":"Signature","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1936,"key":"","label":"Date","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1239,"sectionName":"","key":"0","label":"Bulletin 254","order":10,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2053,"key":"","label":"Describe the area where the premises is to be located","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2054,"key":"","label":"State what the area is zoned for","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2055,"key":"","label":"Provide a description of the premises to be licensed. Describe all building/structures that will be utilized in business operations including the number of floors in each.","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2056,"key":"","label":"has the building/premises been known by any other address?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2057,"key":"","label":"If yes, please Specify","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2058,"key":"","label":"has the premises to be licensed and or any other floor in the building been previously licensed or currently licensed to traffic in alcoholic beverages?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2059,"key":"","label":"What was the prior use of the premises to be licensed?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":6,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2060,"key":"","label":"Does the proposed location of the business comply with all state and local regulations and zoning codes?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":7,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2061,"key":"","label":"is there interior access to any other floor that will not be part of the licensed premises?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":8,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2062,"key":"","label":"if yes, list floor and means of access to each floor.","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":9,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2063,"key":"","label":"Does any other person have access to this area?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":10,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2064,"key":"","label":"where will the alcohol be stored","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":11,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2065,"key":"","label":"if applying for a farm winery license, special farm winery license or micro winery license, the premises must be located on a farm. In the box below, please provide a detailed description of the agricultural production that qualifies the premises as a farm","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":12,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1248,"sectionName":"","key":"0","label":"Premises Questionnaire","order":7,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1988,"key":"","label":"Will any other business of any kind be conducted on said premises?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1989,"key":"","label":"How many Employees?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1990,"key":"","label":"If answer is 0, provide explanation","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1991,"key":"","label":"Workers' Compensation Carrier Name and Policy Number?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1992,"key":"","label":"Disability Insurance Carrier name and policy Number","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2050,"key":"","label":"Check all activities the business will engage in","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"checkbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1249,"sectionName":"","key":"0","label":"Method of Operation","order":8,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2072,"key":"","label":"Real Property","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2073,"key":"","label":"Purchase/Contract Price of Business","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2074,"key":"","label":"Renovations/Improvement Costs","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2075,"key":"","label":"Miscellaneous","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2076,"key":"","label":"Cash","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"label","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2077,"key":"","label":"Source of Funds","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2078,"key":"","label":"Personal Questionnaire attached","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":6,"controlType":"checkbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2079,"key":"","label":"Dollar Amount","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":7,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2080,"key":"","label":"Total Cash","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":8,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2081,"key":"","label":"Borrowed","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":9,"controlType":"label","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2082,"key":"","label":"Source of Funds","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":10,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2083,"key":"","label":"Personal Questionnaire attached","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":11,"controlType":"checkbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2084,"key":"","label":"Dollar Amount","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":12,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2085,"key":"","label":"Total Borrowed","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":13,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2086,"key":"","label":"Total Investment","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":14,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2087,"key":"","label":"Have all investors been disclosed in this application","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":15,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1253,"sectionName":"","key":"0","label":"Financial Disclosure","order":6,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]}],"formVersionId":1231,"version":7,"licenseDescription":"","statusDescription":"Draft","appStatusId":1,"showApplicant":true,"showRepresentative":true,"showPrincipal":true,"showLandlord":true,"showVehicles":false,"showSchedule":false,"staticTabSequence":{"Applicant Information":0,"Principal":1,"Representative":2,"Landlord Identification":3,"Personal Questionnaire":4},"staticTaborder":["Applicant Information","Principal","Representative","Landlord Identification","Personal Questionnaire"],"showPQ":true}
	    When method post
	    Then status 200
	    And def serverResponse = response
	    
	 
@getDueDateExtension	
Scenario: get the Due date with the help of App-Id
Given path '/internalapi/api/licensing/duedate-extension/get/'+appId
	    And header authorization = 'Bearer ' + strToken
	    And request ''
	    When method get
	    Then status 200
	    And def serverResponse = response
	    * def currentDueDate = serverResponse.existingData[0].currentDueDate
	    
	 
	 
@ApproveDisapproveDueDateExtension  		
Scenario: ApproveDisapproveDueDateExtension 
	# ********* Approve Due Date *********************
	 Given path '/internalapi/api/licensing/search/GetEmailNotificationByAppIdAndNotificationTypeId/'+appId+'/0'
	    And header authorization = 'Bearer ' + strToken
	    And request ''
	    When method get
	    Then status 200
	    And def serverResponse = response
	   * def applicantCommId = serverResponse.applicant.communicationId
	   * def attorneyCommId = serverResponse.attorney.communicationId
	    
	   

    Given path '/internalapi/api/licensing/duedate-extension/save'
	    And header authorization = 'Bearer ' + strToken
	    And header current-wfroleid = '3'
	    And print extendedDueDate
	    And request {"extendtoDate":'#(extendedDueDate)',"decision":'#(approvedStatus)',"appId":'#(appId)',"taskId":1304,"emailNotificationModel":{"applicant":{"communicationId":'#(applicantCommId)',"email":'#(emailId)',"appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":'#(attorneyCommId)',"email":"sbandi@svam.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":0,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"email":"automation@test.com"}}}
	    When method post
	    Then status 200
	    And def serverResponse = response 
	 	And print serverResponse
	 	* match serverResponse == 'true'
	Given path '/internalapi/api/licensing/duedate-extension/get/'+appId
	    And header authorization = 'Bearer ' + strToken
	    And request ''
	    When method get
	    Then status 200
	    And def serverResponse = response
	    * match extendedDueDate contains serverResponse.existingData[0].currentDueDate
	    * match serverResponse.existingData[0].pastDueDate contains extendedDueDate
	    

	    
@SubmitSchedule500HearingWithYesoption  		
Scenario: SubmitSchedule500Hearing 
	Given path '/internalapi/api/reference'
   	* def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json;charset=utf-8'
      And header Accept = 'text/plain'
      And params  {name:hearinglocation,onlyActives:true}
 	  And request {}
	  When method get
	  * configure continueOnStepFailure = true
	  Then status 200
	    And def values = response.values
	   
	  * def hearingLocData = karate.jsonPath(values, "$[?(@.HearingLocationId == '" + hearingLocationId + "')]")
	   And print hearingLocData
	  * def hearingLocationName = hearingLocData[0].Name
	  And print hearingLocationName
      * def hearingLocationAddress = hearingLocData[0].Address
      * def hearingLocation = hearingLocData[0].Location
      * def hearingCity = hearingLocData[0].City
      * def hearingCountry = hearingLocData[0].County
      * def hearingCreatedDate = hearingLocData[0].CreatedDate
      * def hearingState = hearingLocData[0].StateName
      * def hearingZipCode = hearingLocData[0].ZipCode
      * def hearingZoneNumber = hearingLocData[0].ZoneNo
      * def hearingActiveStatus = hearingLocData[0].IsActive
      
      
    
      Given path '/internalapi/api/licensing/hearing500/save'
	 
	    And header authorization = 'Bearer ' + strToken
	    And request {"HearingLocation":{"HearingLocationId":'#(hearingLocationId)',"Name":'#(hearingLocationName)',"Address":'#(hearingLocationAddress)',"Location":'#(hearingLocation)',"City":'#(hearingCity)',"StateName":'#(hearingState)',"ZipCode":'#(hearingZipCode)',"ZoneNo":'#(hearingZoneNumber)',"County":'#(hearingCountry)',"IsActive":'#(hearingActiveStatus)',"CreatedBy":null,"CreatedDate":'#(hearingCreatedDate)',"ModifiedBy":null,"ModifiedDate":null,"Zip4":null},"EmailNotificationModel":{"applicant":{},"attorney":{},"communityBoard":{},"other":{}},"IsHearingRequired":true,"HearingReasonId":-1,"Comments":"","AppId":'#(appId)',"HearingDate":'#(date)',"HearingLocationId":'#(hearingLocationId)',"isSubmit":true}
	                
	    When method post
	    Then status 200
	    And def serverResponse = response
	   * match serverResponse == 'true'
	 Given path '/internalapi/api/licensing/hearing500/submit'
	 
	    And header authorization = 'Bearer ' + strToken
	    And request {"HearingLocation":{"HearingLocationId":'#(hearingLocationId)',"Name":'#(hearingLocationName)',"Address":'#(hearingLocationAddress)',"Location":'#(hearingLocation)',"City":'#(hearingCity)',"StateName":'#(hearingState)',"ZipCode":'#(hearingZipCode)',"ZoneNo":'#(hearingZoneNumber)',"County":'#(hearingCountry)',"IsActive":'#(hearingActiveStatus)',"CreatedBy":null,"CreatedDate":'#(hearingCreatedDate)',"ModifiedBy":null,"ModifiedDate":null,"Zip4":null},"EmailNotificationModel":{"applicant":{},"attorney":{},"communityBoard":{},"other":{}},"IsHearingRequired":true,"HearingReasonId":-1,"Comments":"","AppId":'#(appId)',"HearingDate":'#(date)',"HearingLocationId":'#(hearingLocationId)',"isSubmit":true}
	    When method post
	    Then status 200
	    And def serverResponse = response
	   * match serverResponse == 'true'
	   
	  Given path '/internalapi/api/licensing/search/GetEmailNotificationByAppIdAndNotificationTypeId/'+appId+'/0'
	    And header authorization = 'Bearer ' + strToken
	    And request ''
	    When method get
	    Then status 200
	    And def serverResponse = response
	   * def applicantCommId = serverResponse.applicant.communicationId
	   * def attorneyCommId = serverResponse.attorney.communicationId
	  Given path '/internalapi/api/notification/SaveNotification'
      
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {"applicant":{"communicationId":'#(applicantCommId)',"email":'#(emailId)',"appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":'#(attorneyCommId)',"email":'#(emailId)',"appId":'#(appId)',"emailContactTypeId":2,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"}
      When method post
	  Then status 200
	  And print response   
	  
    
@SaveAndSubmitSchedule500HearingWithNoOption  		
Scenario: SubmitSchedule500Hearing 
	
      Given path '/internalapi/api/licensing/hearing500/save'
	 
	    And header authorization = 'Bearer ' + strToken
	    And request {"HearingLocation":{"Address":"","City":"","County":"","Location":"","Name":"","StateName":"","ZipCode":""},"EmailNotificationModel":{"applicant":{},"attorney":{},"communityBoard":{},"other":{}},"IsHearingRequired":false,"HearingReasonId":"2","Comments":"Test","AppId":'#(appId)',"HearingDate":null,"HearingLocationId":-1,"isSubmit":true}
	    And print responseCode
	    When method post
	    Then match responseStatus == responseCode
	    * eval if(responseStatus == 200) karate.call('LicensesCommonMethods.feature@SubmitSchedule500HearingWithNoOption')
	   
	    
@SubmitSchedule500HearingWithNoOption  		
Scenario: SubmitSchedule500Hearing 	    
Given path '/internalapi/api/licensing/hearing500/submit'
	 
	    And header authorization = 'Bearer ' + strToken
	    And request {"HearingLocation":{"Address":"","City":"","County":"","Location":"","Name":"","StateName":"","ZipCode":""},"EmailNotificationModel":{"applicant":{},"attorney":{},"communityBoard":{},"other":{}},"IsHearingRequired":false,"HearingReasonId":"2","Comments":"Test","AppId":'#(appId)',"HearingDate":null,"HearingLocationId":-1,"isSubmit":true}
	    
	    When method post
	    Then status 200
	    And def serverResponse = response
	   * match serverResponse == 'true'
	   

@ExaminerReviewApprovalToFBPTQueue
Scenario: ExaminerReviewApprovalToFBPTQueue  
 # ********* Examiner Review Approval to FBPTQueue *********************
	 * def summisionDate =
		"""
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } """
    Given path '/internalapi/api/licensing/examiner-review/SaveNewLicense'
    	* def formatedSumbitDate = summisionDate()
	    And header authorization = 'Bearer ' + strToken
	    And header current-wfroleid = 4
	    And request {"isFingerPrintsApproved":true,"isFingerPrintsRequired":false,"isCorpLLCDissolved":false,"isCorpLLCDTaken":false,"isSendPDLetter":false,"isDisable500LB_FBPT":false,"isDisableLBForPD":false,"isDisableLBForCaseClosed":false,"isDisableLateRenewalAndUnderpayment":false,"isLiquidatorPermitHasCompleted":-1,"isSubmit":true,"fieldDeficiencies":[],"masterFileData":[],"combinedCraftData":[],"application":{"applicationCategory":4,"appId":'#(appId)',"applicationId":'#(ApplicationId)',"licePermitTypeId":null,"applicationTypeId":1,"formVersionId":'#(FormVersionId)',"formId":'#(formId)',"legalName":"Automation Automation","submitDate":'#(formatedSumbitDate)',"isGISRequired":null,"licenseDescription":'#(description)',"recommendedDecisionId":null,"status500":null,"isApplicableForPDLetter":false,"countyName":'#(CityName)',"priority":"Normal","expirationDate":null,"appStatusId":3,"taskStatus":"Awaiting Review","taskId":1026,"currentWfstatus":null,"communityBoard":null,"isLicenseApplication":true,"currentDueDate":null,"isFinalDeficiency":null,"isHighlyDeficient":null,"isAllDeficienciesMet":null,"pastDueDate":null,"memo":null,"isOneTimePermit":null,"dueDateAction":null,"isDisapprovedForCause":false,"isNotQualified":false,"eventDate":null,"appStatus":{"appStatusId":3,"statusDescription":"Under Review","isActive":true,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"applicationType":null,"assignAppExaminer":{"appExaminerId":1069,"appId":'#(appId)',"examinerId":1069,"name":null,"assignDate":'#(formatedSumbitDate)',"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"assignAppToLB":null,"licePermitType":{"licPermitTypeId":'#(mainLicensePermitTypeId)',"type":"1","category":"4","product":'#(productName)',"class":null,"description":null,"sectionOfLaw":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null,"isTempPermit":false,"isELicensingPermit":false,"isAdditionalBar":false},"assoApplicationList":[],"isTempPermit":null,"isTempOrLiq":false,"licPermitTypeId":'#(mainLicensePermitTypeId)',"isAssociatedLicense":null,"effectiveDate":null,"assignedUserId":null,"amendmentTypeId":null,"amendmentType":null,"disapprovedDate":null,"condApprovedDate":null,"addressId":null,"isCaseOpen":null,"isClosed":null,"isCaseOpenSameAddress":null,"isSpecialEventPlusFour":null,"isSpecialEventInsideFiveBoroughs":null,"licStatus":null,"createdBy":null,"licenseId":null,"address":null,"isNybeApp":false,"isHearingCompleted":null,"does500FtHearingExist":null,"parentAppStatus":null,"premisesAppCount":0,"statusDescription":null,"eventAddress":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskRoleId":0,"taskDecision":null,"isActive":true,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":'#(formatedSumbitDate)'},"appId":'#(appId)',"notificationTypeId":2028,"applicationType":1,"decisionType":{"name":"Send to Full Board Preview Team","value":3},"emailNotificationModel":{"applicant":{},"attorney":{},"communityBoard":{},"other":{}},"hasErrors":[],"taskId":1026,"newComments":"Test Comment","recommendedDecisionId":null}
	                
	   
	    When method post
	    Then status 200
   		* call read('LicensesCommonMethods.feature@checkApplicationStatus') {}
	   
	   
	   
@getAndValidateMemoData  		
Scenario: getAndValidateMemoData 	 
        * def numberWithCommas =
		""" 
		  function(x) {
   				 return x.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
		  }
		"""
Given path '/internalapi/api/licensing/memo/getPrepopulatedMemoByAppId/'+appId
	 
	    And header authorization = 'Bearer ' + strToken
	    And request ""
	    
	    When method get
	    Then status 200
	    And def serverResponse = response
	   * match serverResponse.sourceOfFunds == 'RDC' 
	   * def resultTotalFees = numberWithCommas(totalFees);
	   * match serverResponse.totalCash == resultTotalFees+'.00'
	   * match serverResponse.city == '#(CityName)'
	   * match serverResponse.applicationId == ApplicationId




@ReviewDigestValidate
Scenario: ReviewDigestValidate 
	
	Given path 'internalapi/api/licensing/digest/getDigestPrepopulatedByAppId/'+appId+'/DigestNewApplicationTypeA'
	 
	    And header authorization = 'Bearer ' + strToken
	    And request ""
	    
	    When method get
	    Then status 200
	    And def serverResponse = response
	   * match serverResponse.applicants[0].name contains prncipalName
	   * match serverResponse.appId == appId
	   * match serverResponse.applicationId == ApplicationId
	  
@SaveAndValidateMemoLinkData
Scenario: SaveAndValidateMemoLinkData 
	
	
	 Given path '/internalapi/api/application/'+appId
	   	* def dbSts = db.cleanHeap()
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;*/*'
	      And configure continueOnStepFailure = true
	   	 And request {}
		  When method get
		  * configure continueOnStepFailure = true
		  Then status 200
		    And def formVerID = response.formVersionId
		  And print formVerID
		   And def formId = response.formId
		  And print formId
		   And def legalName = response.legalName
		  And print legalName
		  And def submitDate = response.submitDate
		  And print submitDate
		 
		  And def pastDueDate = response.pastDueDate
		  And print pastDueDate
		
		   And def appExaminerId = response.assignAppExaminer.appExaminerId
		  And print appExaminerId
		   And def examinerId = response.assignAppExaminer.examinerId
		  And print examinerId
		     And def assignDate = response.assignAppExaminer.assignDate
		  And print assignDate
		  And def licPermitTypeId = response.licePermitType.licPermitTypeId
		  And print licPermitTypeId
		  And def type = response.licePermitType.type
		  And print type
		  And def category = response.licePermitType.category
		  And print category
		  And def product = response.licePermitType.product
		  And print product
	 * def numberWithCommas =
		""" 
		  function(x) {
   				 return x.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
		  }
		"""	  
	Given path '/internalapi/api/licensing/memo/getPrepopulatedMemoByAppId/'+appId
	 
	    And header authorization = 'Bearer ' + strToken
	    And request ""
	    
	    When method get
	    Then status 200
	    And def serverResponse = response
	   * match serverResponse.applicants[0].name contains prncipalName
	   * match serverResponse.appId == appId
	   * match serverResponse.applicationId == ApplicationId
	   * def memoId = serverResponse.memoId
	   * def date = serverResponse.date
	   * def from = serverResponse.from
	   * def examiner = serverResponse.examiner
	   * def addressLine1 = serverResponse.addressLine1
	   * def addressLine2 = serverResponse.addressLine2
	   * def city = serverResponse.city
	   * def state = serverResponse.state
	   * def zipCode = serverResponse.zipCode
	   * def typeApplication = serverResponse.typeApplication
	   * def representative = serverResponse.representative
	   * def filedDate = serverResponse.filedDate
	   
	   * def leaseDate = serverResponse.leaseDate
	   * def totalCash = numberWithCommas(serverResponse.totalCash)
	   
	   * def totalDefered = serverResponse.totalDefered
	   * def sourceOfFunds = serverResponse.sourceOfFunds
	   * def createdBy = serverResponse.createdBy
	   * def createdDate = serverResponse.createdDate
	   * def representative = serverResponse.representative
	   * def filedDate = serverResponse.filedDate
	   
	   	  
	Given path '/internalapi/api/licensing/memo/getPrepopulatedMemoByAppId/'+appId
	    And header authorization = 'Bearer ' + strToken
	    And header Content-Type = 'text/javascript;application/json; charset=utf-8'
	    And header Accept = 'application/json; text/plain;'
	    And request {"appId":'#(appId)',"to":"","subject":"","date":'#(date)',"from":'#(from)',"examiner":'#(examiner)',"applicationId":'#(ApplicationId)',"tradeName":"","addressLine1":'#(addressLine1)',"addressLine2":'#(addressLine2)',"city":'#(city)',"state":'#(state)',"zipCode":'#(zipCode)',"temporaryPermit":"","typeApplication":'#(typeApplication)',"representative":'#(representative)',"filedDate":'#(filedDate)',"nameOfCommunityBoard":"","dateOfCommunityBoard":null,"protests":null,"support":null,"hearingDate":"N/A","licensingBoardRecommendationAction":"","principalPastLicensing":"","principalCurrentLicensing":"","adjucatedAdverseHistory":"","twoHundredFromSchool":"","premisesPastLicensing":"","premisesCurrentLicensing":"","pastAdverseHistory":"","premisesDescription":"","premisesMethodOfOperation":"","premisesFoodAvailable":"","leaseDate":'#(leaseDate)',"landlord":null,"tenant":"","term":"","rentAmount":"","sublease":"","assignment":"","consent":"","investment":"Check/Payment","totalCash":'#(totalCash)',"totalDefered":'#(totalDefered)',"sourceOfFunds":'#(sourceOfFunds)',"other":"","subjectTo":"","isActive":true, "createdBy":'#(createdBy)',"createdDate":'#(createdDate)',"modifiedBy":null,"modifiedDate":null,"questionsToBeConsidered":null,"newComments":"Test123","userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"wfRoleId":0,"application":{"applicationCategory":4,"appId":'#(appId)',"applicationId":'#(ApplicationId)',"licePermitTypeId":null,"applicationTypeId":1,"formVersionId":'#(formVersionId)',"formId":'#(formId)',"legalName":'#(legalName)',"submitDate":'#(submitDate)',"isGISRequired":null,"licenseDescription":'#(description)',"recommendedDecisionId":null,"status500":null,"isApplicableForPDLetter":false,"countyName":'#(city)',"priority":"Normal","expirationDate":null,"appStatusId":3,"taskStatus":"Awaiting Review","taskId":1026,"currentWfstatus":null,"communityBoard":null,"isLicenseApplication":true,"currentDueDate":null,"isFinalDeficiency":null,"isHighlyDeficient":null,"isAllDeficienciesMet":null,"pastDueDate":"6/1/2022","memo":null,"isOneTimePermit":null,"dueDateAction":null,"isDisapprovedForCause":false,"isNotQualified":false,"eventDate":null,"appStatus":{"appStatusId":3,"statusDescription":"Under Review","isActive":true,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"applicationType":null,"assignAppExaminer":{"appExaminerId":'#(appExaminerId)',"appId":'#(appId)',"examinerId":'#(examinerId)',"name":null,"assignDate":'#(assignDate)',"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"assignAppToLB":null,"licePermitType":{"licPermitTypeId":'#(licPermitTypeId)',"type":"1","category":"4","product":'#(product)',"class":null,"description":null,"sectionOfLaw":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null,"isTempPermit":false,"isELicensingPermit":false,"isAdditionalBar":false},"assoApplicationList":[],"isTempPermit":null,"isTempOrLiq":false,"licPermitTypeId":'#(licPermitTypeId)',"isAssociatedLicense":null,"effectiveDate":null,"assignedUserId":null,"amendmentTypeId":null,"amendmentType":null,"disapprovedDate":null,"condApprovedDate":null,"addressId":null,"isCaseOpen":null,"isClosed":null,"isCaseOpenSameAddress":null,"isSpecialEventPlusFour":null,"isSpecialEventInsideFiveBoroughs":null,"licStatus":null,"createdBy":null,"licenseId":null,"address":null,"isNybeApp":false,"isHearingCompleted":null,"does500FtHearingExist":null,"parentAppStatus":null,"premisesAppCount":0,"statusDescription":null,"eventAddress":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskRoleId":0,"taskDecision":null,"isActive":true,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":'#(modifiedDate)'}}
	    When method post
	    Then status 200
	    And def serverResponse = response   
	   
	   
	  
@AssignFBPTLicToLB
Scenario: AssignFBPTLicToLB  
 # ********* Examiner Review Approval to FBPTQueue *********************
	 * def summisionDate =
		"""
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } """
		  
	 * def summisionDate1 =
		"""
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SS");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } """
		  
	 Given path '/internalapi/api/application/'+appId
	   	* def dbSts = db.cleanHeap()
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;*/*'
	      And configure continueOnStepFailure = true
	   	 And request {}
		  When method get
		  * configure continueOnStepFailure = true
		  Then status 200
		    And def formVerID = response.formVersionId
		  And print formVerID
		   And def formId = response.formId
		  And print formId
		   And def legalName = response.legalName
		  And print legalName
		  And def submitDate = response.submitDate
		  And print submitDate
		 
		  And def pastDueDate = response.pastDueDate
		  And print pastDueDate
		
		   And def appExaminerId = response.assignAppExaminer.appExaminerId
		  And print appExaminerId
		   And def examinerId = response.assignAppExaminer.examinerId
		  And print examinerId
		     And def assignDate = response.assignAppExaminer.assignDate
		  And print assignDate
		  And def licPermitTypeId = response.licePermitType.licPermitTypeId
		  And print licPermitTypeId
		  And def type = response.licePermitType.type
		  And print type
		  And def category = response.licePermitType.category
		  And print category
		  And def product = response.licePermitType.product
		  And print product

	    	  
    Given path '/internalapi/api/licensing/fbpt-review/NewLicense'
    	* def formatedSumbitDate = summisionDate()
    	* def formatedSumbitDate1 = summisionDate1()
	    And header authorization = 'Bearer ' + strToken
	    And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;'
	    And request {"isDisable500LB_FBPT":false,"isSubmit":true,"application":{"applicationCategory":1,"appId":'#(appId)',"applicationId":'#(ApplicationId)',"licePermitTypeId":null,"applicationTypeId":1,"formVersionId":'#(formVerID)',"formId":'#(formId)',"legalName":'#(legalName)',"submitDate":'#(submitDate)',"isGISRequired":null,"licenseDescription":'#(description)',"recommendedDecisionId":null,"status500":null,"isApplicableForPDLetter":false,"countyName":'#(CityName)',"priority":"Normal","expirationDate":null,"appStatusId":3,"taskStatus":"Awaiting Review","taskId":1040,"currentWfstatus":null,"communityBoard":null,"isLicenseApplication":true,"currentDueDate":null,"isFinalDeficiency":null,"isHighlyDeficient":null,"isAllDeficienciesMet":null,"pastDueDate":'#(pastDueDate)',"memo":null,"isOneTimePermit":null,"dueDateAction":null,"isDisapprovedForCause":false,"isNotQualified":false,"eventDate":null,"appStatus":{"appStatusId":3,"statusDescription":"Under Review","isActive":true,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"applicationType":null,"assignAppExaminer":{"appExaminerId":'#(appExaminerId)',"appId":'#(appId)',"examinerId":'#(examinerId)',"name":null,"assignDate":'#(assignDate)',"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"assignAppToLB":null,"licePermitType":{"licPermitTypeId":'#(licPermitTypeId)',"type":"1","category":"1","product":'#(product)',"class":null,"description":null,"sectionOfLaw":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null,"isTempPermit":false,"isELicensingPermit":false,"isAdditionalBar":false},"assoApplicationList":[],"isTempPermit":null,"isTempOrLiq":false,"licPermitTypeId":'#(licPermitTypeId)',"isAssociatedLicense":null,"effectiveDate":null,"assignedUserId":null,"amendmentTypeId":null,"amendmentType":null,"disapprovedDate":null,"condApprovedDate":null,"addressId":null,"isCaseOpen":null,"isClosed":null,"isCaseOpenSameAddress":null,"isSpecialEventPlusFour":null,"isSpecialEventInsideFiveBoroughs":null,"licStatus":null,"createdBy":null,"licenseId":null,"address":null,"isNybeApp":false,"isHearingCompleted":null,"does500FtHearingExist":null,"parentAppStatus":null,"premisesAppCount":0,"statusDescription":null,"eventAddress":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskRoleId":0,"taskDecision":null,"isActive":true,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":'#(formatedSumbitDate1)'},"appId":'#(appId)',"applicationType":1,"decisionType":{"name":"Redirect to LB","value":1,"isChecked":null},"hasErrors":[],"taskId":1040,"newComments":"Sending to LB Desc"}
	    When method post
	    Then status 200
	    * match response == 'true'
   		
    	Given path '/internalapi/api/comment/Application/save'
    	* def formatedSumbitDate = summisionDate()
	    And header authorization = 'Bearer ' + strToken
	   
	    And request {"description":"Sending to LB Desc","acaId":'#(appId)',"acatype":"Application","bureau":"License","bureauId":1}
	   
	   
	   #{"isDisable500LB_FBPT":false,"isSubmit":true,"application":{"applicationCategory":1,"appId":111841,"applicationId":"NA-0111-22-2108294","licePermitTypeId":null,"applicationTypeId":1,"formVersionId":1614,"formId":1165,"legalName":"Automation20220531040039Automation","submitDate":"2022-05-31T04:00:42.627","isGISRequired":null,"licenseDescription":"Restaurant-Beer","recommendedDecisionId":null,"status500":null,"isApplicableForPDLetter":false,"countyName":"New York","priority":"Normal","expirationDate":null,"appStatusId":3,"taskStatus":"Awaiting Review","taskId":1040,"currentWfstatus":null,"communityBoard":null,"isLicenseApplication":true,"currentDueDate":null,"isFinalDeficiency":null,"isHighlyDeficient":null,"isAllDeficienciesMet":null,"pastDueDate":"6/7/2022 12:00:00 AM","memo":null,"isOneTimePermit":null,"dueDateAction":null,"isDisapprovedForCause":false,"isNotQualified":false,"eventDate":null,"appStatus":{"appStatusId":3,"statusDescription":"Under Review","isActive":true,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"applicationType":null,"assignAppExaminer":{"appExaminerId":6910,"appId":111841,"examinerId":1069,"name":null,"assignDate":"2022-05-31T04:00:43.997","isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"assignAppToLB":null,"licePermitType":{"licPermitTypeId":'#(mainLicensePermitTypeId)',"type":"1","category":"1","product":"Beer","class":null,"description":null,"sectionOfLaw":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null,"isTempPermit":false,"isELicensingPermit":false,"isAdditionalBar":false},"assoApplicationList":[],"isTempPermit":null,"isTempOrLiq":false,"licPermitTypeId":'#(mainLicensePermitTypeId)',"isAssociatedLicense":null,"effectiveDate":null,"assignedUserId":null,"amendmentTypeId":null,"amendmentType":null,"disapprovedDate":null,"condApprovedDate":null,"addressId":null,"isCaseOpen":null,"isClosed":null,"isCaseOpenSameAddress":null,"isSpecialEventPlusFour":null,"isSpecialEventInsideFiveBoroughs":null,"licStatus":null,"createdBy":null,"licenseId":null,"address":null,"isNybeApp":false,"isHearingCompleted":null,"does500FtHearingExist":null,"parentAppStatus":null,"premisesAppCount":0,"statusDescription":null,"eventAddress":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskRoleId":0,"taskDecision":null,"isActive":true,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":"2022-05-31T04:00:45.22"},"appId":111841,"applicationType":1,"decisionType":{"name":"Redirect to LB","value":1,"isChecked":null},"hasErrors":[],"taskId":1040,"newComments":"Sending to LB Desc"}
	   #{"isDisable500LB_FBPT":false,"isSubmit":true,"application":{"applicationCategory":1,"appId":111851,"applicationId":"NA-0111-22-2108304","licePermitTypeId":null,"applicationTypeId":1,"formVersionId":1614,"formId":1165,"legalName":"Automation20220531052437Automation","submitDate":"2022-05-31T05:24:42.803","isGISRequired":null,"licenseDescription":"Restaurant-Beer","recommendedDecisionId":null,"status500":null,"isApplicableForPDLetter":false,"countyName":"New York","priority":"Normal","expirationDate":null,"appStatusId":3,"taskStatus":"Awaiting Review","taskId":1040,"currentWfstatus":null,"communityBoard":null,"isLicenseApplication":true,"currentDueDate":null,"isFinalDeficiency":null,"isHighlyDeficient":null,"isAllDeficienciesMet":null,"pastDueDate":"6\/7\/2022 12:00:00 AM","memo":null,"isOneTimePermit":null,"dueDateAction":null,"isDisapprovedForCause":false,"isNotQualified":false,"eventDate":null,"appStatus":{"appStatusId":3,"statusDescription":"Under Review","isActive":true,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"applicationType":null,"assignAppExaminer":{"appExaminerId":6920,"appId":111851,"examinerId":1069,"name":null,"assignDate":"2022-05-31T05:24:45.32","isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"assignAppToLB":null,"licePermitType":{"licPermitTypeId":'#(mainLicensePermitTypeId)',"type":"1","category":"1","product":"Beer","class":null,"description":null,"sectionOfLaw":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null,"isTempPermit":false,"isELicensingPermit":false,"isAdditionalBar":false},"assoApplicationList":[],"isTempPermit":null,"isTempOrLiq":false,"licPermitTypeId":'#(mainLicensePermitTypeId)',"isAssociatedLicense":null,"effectiveDate":null,"assignedUserId":null,"amendmentTypeId":null,"amendmentType":null,"disapprovedDate":null,"condApprovedDate":null,"addressId":null,"isCaseOpen":null,"isClosed":null,"isCaseOpenSameAddress":null,"isSpecialEventPlusFour":null,"isSpecialEventInsideFiveBoroughs":null,"licStatus":null,"createdBy":null,"licenseId":null,"address":null,"isNybeApp":false,"isHearingCompleted":null,"does500FtHearingExist":null,"parentAppStatus":null,"premisesAppCount":0,"statusDescription":null,"eventAddress":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskRoleId":0,"taskDecision":null,"isActive":true,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":"2022-05-31T05:24:48.904"},"appId":111851,"applicationType":1,"decisionType":{"name":"Redirect to LB","value":1,"isChecked":null},"hasErrors":[],"taskId":1040,"newComments":"Sending to LB Desc"}
	    When method post
	    Then status 200
	   And print response
	  
	  
	  

@ExaminerReviewApprovalWithAllDefineDeficiencies
Scenario: ExaminerReviewApprovalWithAllDefineDeficiencies  
 # ********* ExaminerReviewApprovalWithAllDefineDeficiencies *********************
	 * def summisionDate =
		"""
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } """
	Given path '/internalapi/api/application/'+appId
	   	* def dbSts = db.cleanHeap()
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;*/*'
	      And configure continueOnStepFailure = true
	   	 And request {}
		  When method get
		  * configure continueOnStepFailure = true
		  Then status 200
		    And def formVerID = response.formVersionId
		  And print formVerID
		   And def formId = response.formId
		  And print formId
		   And def legalName = response.legalName
		  And print legalName
		  And def submitDate = response.submitDate
		  And print submitDate
		 
		  And def pastDueDate = response.pastDueDate
		  And print pastDueDate
		
		   And def appExaminerId = response.assignAppExaminer.appExaminerId
		  And print appExaminerId
		   And def examinerId = response.assignAppExaminer.examinerId
		  And print examinerId
		     And def assignDate = response.assignAppExaminer.assignDate
		  And print assignDate
		  And def licPermitTypeId = response.licePermitType.licPermitTypeId
		  And print licPermitTypeId
		  And def type = response.licePermitType.type
		  And print type
		  And def category = response.licePermitType.category
		  And print category
		  And def product = response.licePermitType.product
		  And print product	  
    Given path '/internalapi/api/licensing/examiner-review/SaveNewLicense'
    	* def formatedSumbitDate = summisionDate()
	    And header authorization = 'Bearer ' + strToken
	    And header current-wfroleid = 4
	    And request {"isFingerPrintsApproved":true,"isFingerPrintsRequired":false,"isCorpLLCDissolved":false,"isCorpLLCDTaken":false,"isSendPDLetter":false,"isDisable500LB_FBPT":false,"isDisableLBForPD":false,"isDisableLBForCaseClosed":false,"isDisableLateRenewalAndUnderpayment":false,"isLiquidatorPermitHasCompleted":-1,"isSubmit":true,"fieldDeficiencies":[],"masterFileData":[],"combinedCraftData":[],"application":{"applicationCategory":3,"appId":'#(appId)',"applicationId":'#(ApplicationId)',"licePermitTypeId":null,"applicationTypeId":1,"formVersionId":'#(formVersionId)',"formId":'#(formId)',"legalName":'#(legalName)',"submitDate":'#(formatedSumbitDate)',"isGISRequired":null,"licenseDescription":'#(description)',"recommendedDecisionId":null,"status500":null,"isApplicableForPDLetter":false,"countyName":'#(CityName)',"priority":"Normal","expirationDate":null,"appStatusId":3,"taskStatus":"Awaiting Review","taskId":1026,"currentWfstatus":null,"communityBoard":null,"isLicenseApplication":true,"currentDueDate":null,"isFinalDeficiency":null,"isHighlyDeficient":false,"isAllDeficienciesMet":null,"pastDueDate":"1/1/1970 12:00:00 AM","memo":null,"isOneTimePermit":null,"dueDateAction":null,"isDisapprovedForCause":false,"isNotQualified":false,"eventDate":null,"appStatus":{"appStatusId":3,"statusDescription":"Under Review","isActive":true,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"applicationType":null,"assignAppExaminer":{"appExaminerId":'#(appExaminerId)',"appId":'#(appId)',"examinerId":'#(examinerId)',"name":null,"assignDate":'#(formatedSumbitDate)',"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"assignAppToLB":null,"licePermitType":{"licPermitTypeId":'#(mainLicensePermitTypeId)',"type":"1","category":"3","product":'#(productName)',"class":null,"description":null,"sectionOfLaw":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null,"isTempPermit":false,"isELicensingPermit":false,"isAdditionalBar":false},"assoApplicationList":[],"isTempPermit":null,"isTempOrLiq":false,"licPermitTypeId":'#(mainLicensePermitTypeId)',"isAssociatedLicense":null,"effectiveDate":null,"assignedUserId":null,"amendmentTypeId":null,"amendmentType":null,"disapprovedDate":null,"condApprovedDate":null,"addressId":null,"isCaseOpen":null,"isClosed":null,"isCaseOpenSameAddress":null,"isSpecialEventPlusFour":null,"isSpecialEventInsideFiveBoroughs":null,"licStatus":null,"createdBy":null,"licenseId":null,"address":null,"isNybeApp":false,"isHearingCompleted":null,"does500FtHearingExist":null,"parentAppStatus":null,"premisesAppCount":0,"statusDescription":null,"eventAddress":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskRoleId":0,"taskDecision":null,"isActive":true,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":'#(formatedSumbitDate)'},"appId":'#(appId)',"notificationTypeId":2028,"applicationType":1,"decisionType":{"name":"Define Deficiencies","value":1},"emailNotificationModel":{"applicant":{"communicationId":64788,"email":"Automation@test.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":64791,"email":"Automation@test.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"notificationTypeId":2028,"isInstantEmail":false},"hasErrors":[],"taskId":1026,"newComments":"DefineDeficiencies Desc","erDeficiencies":{"selectInput":{"fromFields":[{"id":4,"label":"As the applicant is a corporation, LLC or LLP, the applicant name must be the same as the name on the filing receipt."},{"id":5,"label":"Submit a copy of the Secretary of State filing receipt for the corp/LLC/LLP"},{"id":6,"label":"Provide a copy of the corporate minutes for the applicant entity"},{"id":7,"label":"Provide a copy of the LLC operating agreement for the applicant entity"},{"id":8,"label":"Provide a clear organizational chart for the applicant entity.  Each holding corporation should be listed.  All principals of each entity should be listed along with their percentage of ownership."},{"id":9,"label":"Premises address does not match the address listed on lease."},{"id":10,"label":"Premises address does not match the address listed on the bill of sale."},{"id":11,"label":"Premises address does not match the address listed on the deed."},{"id":12,"label":"Premises address must be written the same on all documents and must be the physical location of the premises (not the mailing address)."},{"id":13,"label":"Submit a Notice of Appearance or the attorney or representative."},{"id":14,"label":"Entity owning real property does not match applicant name – A lease between the two parties is required and must be submitted.  "},{"id":15,"label":"The lease must run the full term of the license period (please take processing time into consideration when determining the end date of the lease).  Provide either a new lease document or an amendment/rider to the existing one (signed by both landlord and tenant).  "},{"id":16,"label":"Landlord name must be the name shown on the deed."},{"id":17,"label":"All principals of the landlord entity must be listed."},{"id":18,"label":"To verify ownership, submit a copy of the deed."},{"id":19,"label":"The source of ALL funds (cash and borrowed) must be listed on this form."},{"id":20,"label":"Submit financial documentation proving the availability of the funds listed.  You must submit 3 consecutive months-worth of statements from checking or savings accounts showing the availability of the funds at the time they were expended."},{"id":21,"label":"Submit a copy of all executed loan agreements.  "},{"id":22,"label":"Provide the name and address of all on premises liquor establishments located within 500 feet of your establishment."},{"id":23,"label":"Provide a statement addressing why you believe it would be in the public's interest to issue this license."},{"id":24,"label":"Please complete the Statement of Area Plan form"},{"id":25,"label":"Provide a personal questionnaire for __________________."},{"id":26,"label":"Please list gender on _________'s personal questionnaire."},{"id":27,"label":"Provide residence addresses for the last 5 consecutive years."},{"id":28,"label":"Provide employment information for the last 5 consecutive years.  If unemployed for any period of time during the past 5 years, that must also be reflected."},{"id":29,"label":"________________ has/had license history with the Authority.  Amend question five to reflect all license history."},{"id":30,"label":"The Department of Criminal Justice Services has advised us that ________________________ has a conviction record. Amend question 6b to reflect the correct answer and provide a signed statement as to why the question was originally answered no.  Submit a Certificate of Disposition for all arrests and convictions. If convicted of a felony, you must submit a Certificate of Relief from Disabilities."},{"id":31,"label":"Amend the diagram labeling all rooms and bars"},{"id":32,"label":"Amend the diagram to include the food prep area"},{"id":33,"label":"Provide a diagram of the basement"},{"id":34,"label":"Provide a block plot diagram"},{"id":35,"label":"Add the outside area to the diagram "},{"id":36,"label":"Submit color photos of the interior of the premises including all dining areas, the bar and at least one of the kitchen.  Place the serial number on the back of each photo."},{"id":37,"label":"Submit one color photo of the front exterior of the premises.  Place the serial number on the back of the photo."},{"id":38,"label":"Submit color photos of any outside area (deck, patio, yard) to be licensed.  The photos must show how the area is contained (fencing, shrubbery, roping off).  Place the serial number on the back of the photos."},{"id":39,"label":"Provide a color photo of the applicant (no smaller than passport size) for _______________."},{"id":40,"label":"Provide a copy of ____________'s photo identification."},{"id":41,"label":"Submit a copy of the menu."},{"id":42,"label":"Provide proof of citizenship for _________________."},{"id":43,"label":"You have listed 1 restroom.  The Rules of the State Liquor Authority require 2 separate restrooms for both sexes.  Please submit a request to the Authority asking for a waiver of the 2-restroom rule.  You must explain why you believe one restroom is sufficient for the operation of your establishment."},{"id":44,"label":"Submit a copy of the maximum occupancy certificate."},{"id":45,"label":"______________________ needs to be fingerprinted. "},{"id":123,"label":"Additional Funds Required"},{"id":129,"label":"Provide a copy of the Assumed Name Certificate from the Secretary of State for your corporation/LLC's dba name."},{"id":130,"label":"Provide a copy of the business certificate from the county clerk for your dba name."},{"id":131,"label":"Provide your federal tax identification number."},{"id":132,"label":"Provide a copy of your Certificate of Authority from the New York State Tax Department."},{"id":133,"label":"Provide an amended Certificate of Authority – the name must match the applicant name exactly."},{"id":134,"label":"Provide an amended Certificate of Authority – the address must match the premises address exactly."},{"id":135,"label":"Provide a signed Bond Rider amending _______."},{"id":136,"label":"Provide Worker's Compensation and Disability Benefits insurance provider names and policy numbers."},{"id":137,"label":"Provide an inventory of the alcoholic beverages you will be purchasing from the current licensee."},{"id":138,"label":"Submit a copy of the Newspaper Affidavit(s)."},{"id":139,"label":"Provide your TTB permit."},{"id":140,"label":"Surrender of the current license in effect."},{"id":141,"label":"Make the edits listed below to the curriculum."},{"id":142,"label":"The submitted Curriculum generally covers the required topics. However,  the below changes must be made to ensure that the persons taking the course understand their rights, obligations, and liabilities under New York law."},{"id":143,"label":"The licensee's and server's responsibility to not sell, deliver or give alcohol to someone under the age of 21 (ABC Law 65)."},{"id":144,"label":"The licensee's and server's responsibility when serving more than one drink to an individual to be aware of any redelivery by the legal patron (on-premises only)."},{"id":145,"label":"The licensee's and server's responsibility to reasonably supervise the premises."},{"id":146,"label":"The licensee's and server's right to refuse to sell, including but not limited to, an underage patron, an intoxicated patron, or a patron without proper identification."},{"id":147,"label":"The licensee's and server's burden to establish that a delivery of alcohol was made in a reasonable reliance upon written evidence of age."},{"id":148,"label":"The forms of identification which may be legally accepted as written evidence of age (ABC Law 65-b.2)."},{"id":149,"label":"Key features of the valid forms of identification and the way false and fraudulent forms of identification may be detected."},{"id":150,"label":"Devices and manuals which may be used to aid in the detection of false and fraudulent written evidence of age, and information regarding the way such devises and manuals may be obtained."},{"id":151,"label":"The criminal liabilities and penalties for both the individual and the establishment for unlawfully dealing with a child (Penal Law 260.20)."},{"id":152,"label":"The civil liabilities, general liabilities, responsibilities and general obligations (General Obligations Law 11-100 and 11-101)."},{"id":153,"label":"Firsthand accounts from the public illustrating the consequences of the failure of licensees and/or servers to operate in a safe, legal and responsible manner. (i.e., MADD, RID, and Shattered Lives)."},{"id":154,"label":"Provide the New York State Liquor Authority with access to the online course for review."},{"id":155,"label":"Remove the following content from the applicants' website:"},{"id":156,"label":"Provide the legal name of the applicant."},{"id":157,"label":"Provide the mailing address of the applicant."},{"id":158,"label":"Provide the federal id number of the applicant."},{"id":159,"label":"Provide the applicant's contact phone number."},{"id":160,"label":"Provide the applicant's email address."},{"id":161,"label":"Provide the director's name."},{"id":162,"label":"Provide the director's phone number."},{"id":163,"label":"Provide the director's email address."},{"id":164,"label":"Designate the format of the course. The Alcoholic Beverage Control Law states that the course be taught via online, classroom, or distance learning. An ATAP course can be offered in multiple formats."}],"toFields":[{"id":-1,"label":"As the applicant is a corporation, LLC or LLP, the applicant name must be the same as the name on the filing receipt.","originalId":4},{"id":-2,"label":"Submit a copy of the Secretary of State filing receipt for the corp/LLC/LLP","originalId":5},{"id":-3,"label":"Provide a copy of the corporate minutes for the applicant entity","originalId":6},{"id":-4,"label":"Provide a copy of the LLC operating agreement for the applicant entity","originalId":7},{"id":-5,"label":"Provide a clear organizational chart for the applicant entity.  Each holding corporation should be listed.  All principals of each entity should be listed along with their percentage of ownership.","originalId":8},{"id":-6,"label":"Premises address does not match the address listed on lease.","originalId":9},{"id":-7,"label":"Premises address does not match the address listed on the bill of sale.","originalId":10},{"id":-8,"label":"Premises address does not match the address listed on the deed.","originalId":11},{"id":-9,"label":"Premises address must be written the same on all documents and must be the physical location of the premises (not the mailing address).","originalId":12},{"id":-10,"label":"Submit a Notice of Appearance or the attorney or representative.","originalId":13},{"id":-11,"label":"Entity owning real property does not match applicant name – A lease between the two parties is required and must be submitted.  ","originalId":14},{"id":-12,"label":"The lease must run the full term of the license period (please take processing time into consideration when determining the end date of the lease).  Provide either a new lease document or an amendment/rider to the existing one (signed by both landlord and tenant).  ","originalId":15},{"id":-13,"label":"Landlord name must be the name shown on the deed.","originalId":16},{"id":-14,"label":"All principals of the landlord entity must be listed.","originalId":17},{"id":-15,"label":"To verify ownership, submit a copy of the deed.","originalId":18},{"id":-16,"label":"The source of ALL funds (cash and borrowed) must be listed on this form.","originalId":19},{"id":-17,"label":"Submit financial documentation proving the availability of the funds listed.  You must submit 3 consecutive months-worth of statements from checking or savings accounts showing the availability of the funds at the time they were expended.","originalId":20},{"id":-18,"label":"Submit a copy of all executed loan agreements.  ","originalId":21},{"id":-19,"label":"Provide the name and address of all on premises liquor establishments located within 500 feet of your establishment.","originalId":22},{"id":-20,"label":"Provide a statement addressing why you believe it would be in the public's interest to issue this license.","originalId":23},{"id":-21,"label":"Please complete the Statement of Area Plan form","originalId":24},{"id":-22,"label":"Provide a personal questionnaire for __________________.","originalId":25},{"id":-23,"label":"Please list gender on _________'s personal questionnaire.","originalId":26},{"id":-24,"label":"Provide residence addresses for the last 5 consecutive years.","originalId":27},{"id":-25,"label":"Provide employment information for the last 5 consecutive years.  If unemployed for any period of time during the past 5 years, that must also be reflected.","originalId":28},{"id":-26,"label":"________________ has/had license history with the Authority.  Amend question five to reflect all license history.","originalId":29},{"id":-27,"label":"The Department of Criminal Justice Services has advised us that ________________________ has a conviction record. Amend question 6b to reflect the correct answer and provide a signed statement as to why the question was originally answered no.  Submit a Certificate of Disposition for all arrests and convictions. If convicted of a felony, you must submit a Certificate of Relief from Disabilities.","originalId":30},{"id":-28,"label":"Amend the diagram labeling all rooms and bars","originalId":31},{"id":-29,"label":"Amend the diagram to include the food prep area","originalId":32},{"id":-30,"label":"Provide a diagram of the basement","originalId":33},{"id":-31,"label":"Provide a block plot diagram","originalId":34},{"id":-32,"label":"Add the outside area to the diagram ","originalId":35},{"id":-33,"label":"Submit color photos of the interior of the premises including all dining areas, the bar and at least one of the kitchen.  Place the serial number on the back of each photo.","originalId":36},{"id":-34,"label":"Submit one color photo of the front exterior of the premises.  Place the serial number on the back of the photo.","originalId":37},{"id":-35,"label":"Submit color photos of any outside area (deck, patio, yard) to be licensed.  The photos must show how the area is contained (fencing, shrubbery, roping off).  Place the serial number on the back of the photos.","originalId":38},{"id":-36,"label":"Provide a color photo of the applicant (no smaller than passport size) for _______________.","originalId":39},{"id":-37,"label":"Provide a copy of ____________'s photo identification.","originalId":40},{"id":-38,"label":"Submit a copy of the menu.","originalId":41},{"id":-39,"label":"Provide proof of citizenship for _________________.","originalId":42},{"id":-40,"label":"You have listed 1 restroom.  The Rules of the State Liquor Authority require 2 separate restrooms for both sexes.  Please submit a request to the Authority asking for a waiver of the 2-restroom rule.  You must explain why you believe one restroom is sufficient for the operation of your establishment.","originalId":43},{"id":-41,"label":"Submit a copy of the maximum occupancy certificate.","originalId":44},{"id":-42,"label":"______________________ needs to be fingerprinted. ","originalId":45},{"id":-43,"label":"Additional Funds Required","originalId":123},{"id":-44,"label":"Provide a copy of the Assumed Name Certificate from the Secretary of State for your corporation/LLC's dba name.","originalId":129},{"id":-45,"label":"Provide a copy of the business certificate from the county clerk for your dba name.","originalId":130},{"id":-46,"label":"Provide your federal tax identification number.","originalId":131},{"id":-47,"label":"Provide a copy of your Certificate of Authority from the New York State Tax Department.","originalId":132},{"id":-48,"label":"Provide an amended Certificate of Authority – the name must match the applicant name exactly.","originalId":133},{"id":-49,"label":"Provide an amended Certificate of Authority – the address must match the premises address exactly.","originalId":134},{"id":-50,"label":"Provide a signed Bond Rider amending _______.","originalId":135},{"id":-51,"label":"Provide Worker's Compensation and Disability Benefits insurance provider names and policy numbers.","originalId":136},{"id":-52,"label":"Provide an inventory of the alcoholic beverages you will be purchasing from the current licensee.","originalId":137},{"id":-53,"label":"Submit a copy of the Newspaper Affidavit(s).","originalId":138},{"id":-54,"label":"Provide your TTB permit.","originalId":139},{"id":-55,"label":"Surrender of the current license in effect.","originalId":140},{"id":-56,"label":"Make the edits listed below to the curriculum.","originalId":141},{"id":-57,"label":"The submitted Curriculum generally covers the required topics. However,  the below changes must be made to ensure that the persons taking the course understand their rights, obligations, and liabilities under New York law.","originalId":142},{"id":-58,"label":"The licensee's and server's responsibility to not sell, deliver or give alcohol to someone under the age of 21 (ABC Law 65).","originalId":143},{"id":-59,"label":"The licensee's and server's responsibility when serving more than one drink to an individual to be aware of any redelivery by the legal patron (on-premises only).","originalId":144},{"id":-60,"label":"The licensee's and server's responsibility to reasonably supervise the premises.","originalId":145},{"id":-61,"label":"The licensee's and server's right to refuse to sell, including but not limited to, an underage patron, an intoxicated patron, or a patron without proper identification.","originalId":146},{"id":-62,"label":"The licensee's and server's burden to establish that a delivery of alcohol was made in a reasonable reliance upon written evidence of age.","originalId":147},{"id":-63,"label":"The forms of identification which may be legally accepted as written evidence of age (ABC Law 65-b.2).","originalId":148},{"id":-64,"label":"Key features of the valid forms of identification and the way false and fraudulent forms of identification may be detected.","originalId":149},{"id":-65,"label":"Devices and manuals which may be used to aid in the detection of false and fraudulent written evidence of age, and information regarding the way such devises and manuals may be obtained.","originalId":150},{"id":-66,"label":"The criminal liabilities and penalties for both the individual and the establishment for unlawfully dealing with a child (Penal Law 260.20).","originalId":151},{"id":-67,"label":"The civil liabilities, general liabilities, responsibilities and general obligations (General Obligations Law 11-100 and 11-101).","originalId":152},{"id":-68,"label":"Firsthand accounts from the public illustrating the consequences of the failure of licensees and/or servers to operate in a safe, legal and responsible manner. (i.e., MADD, RID, and Shattered Lives).","originalId":153},{"id":-69,"label":"Provide the New York State Liquor Authority with access to the online course for review.","originalId":154},{"id":-70,"label":"Remove the following content from the applicants' website:","originalId":155},{"id":-71,"label":"Provide the legal name of the applicant.","originalId":156},{"id":-72,"label":"Provide the mailing address of the applicant.","originalId":157},{"id":-73,"label":"Provide the federal id number of the applicant.","originalId":158},{"id":-74,"label":"Provide the applicant's contact phone number.","originalId":159},{"id":-75,"label":"Provide the applicant's email address.","originalId":160},{"id":-76,"label":"Provide the director's name.","originalId":161},{"id":-77,"label":"Provide the director's phone number.","originalId":162},{"id":-78,"label":"Provide the director's email address.","originalId":163},{"id":-79,"label":"Designate the format of the course. The Alcoholic Beverage Control Law states that the course be taught via online, classroom, or distance learning. An ATAP course can be offered in multiple formats.","originalId":164}],"isRewritable":true,"rewriteLabel":"Edit Deficiency:","additionalComments":"","srclabel":"Select Deficiencies","dstlabel":"Add to Notification","additionalLabel":"Add Additional Deficiencies:"}}}
	    When method post
	    Then status 200
	   * call read('LicensesCommonMethods.feature@checkApplicationStatus') {}	
	   
	   
	   
	   

@ExaminerReviewApprovalWithOneDefineDeficiencies
Scenario: ExaminerReviewApprovalWithOneDefineDeficiencies  
 # ********* ExaminerReviewApprovalWithAllDefineDeficiencies *********************
	 * def summisionDate =
		"""
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } """
	Given path '/internalapi/api/application/'+appId
	   	* def dbSts = db.cleanHeap()
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;*/*'
	      And configure continueOnStepFailure = true
	   	 And request {}
		  When method get
		  * configure continueOnStepFailure = true
		  Then status 200
		    And def formVerID = response.formVersionId
		  And print formVerID
		   And def formId = response.formId
		  And print formId
		   And def legalName = response.legalName
		  And print legalName
		  And def submitDate = response.submitDate
		  And print submitDate
		 
		  And def pastDueDate = response.pastDueDate
		  And print pastDueDate
		
		   And def appExaminerId = response.assignAppExaminer.appExaminerId
		  And print appExaminerId
		   And def examinerId = response.assignAppExaminer.examinerId
		  And print examinerId
		     And def assignDate = response.assignAppExaminer.assignDate
		  And print assignDate
		  And def licPermitTypeId = response.licePermitType.licPermitTypeId
		  And print licPermitTypeId
		  And def type = response.licePermitType.type
		  And print type
		  And def category = response.licePermitType.category
		  And print category
		  And def product = response.licePermitType.product
		  And print product	  
    Given path '/internalapi/api/licensing/examiner-review/SaveNewLicense'
    	* def formatedSumbitDate = summisionDate()
	    And header authorization = 'Bearer ' + strToken
	    And header current-wfroleid = 4
	    And request {"isFingerPrintsApproved":true,"isFingerPrintsRequired":false,"isCorpLLCDissolved":false,"isCorpLLCDTaken":false,"isSendPDLetter":false,"isDisable500LB_FBPT":false,"isDisableLBForPD":false,"isDisableLBForCaseClosed":false,"isDisableLateRenewalAndUnderpayment":false,"isLiquidatorPermitHasCompleted":-1,"isSubmit":true,"fieldDeficiencies":[],"masterFileData":[],"combinedCraftData":[],"application":{"applicationCategory":3,"appId":'#(appId)',"applicationId":'#(ApplicationId)',"licePermitTypeId":null,"applicationTypeId":1,"formVersionId":'#(formVersionId)',"formId":'#(formId)',"legalName":'#(legalName)',"submitDate":'#(formatedSumbitDate)',"isGISRequired":null,"licenseDescription":'#(description)',"recommendedDecisionId":null,"status500":null,"isApplicableForPDLetter":false,"countyName":'#(CityName)',"priority":"Normal","expirationDate":null,"appStatusId":3,"taskStatus":"Awaiting Review","taskId":1026,"currentWfstatus":null,"communityBoard":null,"isLicenseApplication":true,"currentDueDate":null,"isFinalDeficiency":null,"isHighlyDeficient":false,"isAllDeficienciesMet":null,"pastDueDate":"1/1/1970 12:00:00 AM","memo":null,"isOneTimePermit":null,"dueDateAction":null,"isDisapprovedForCause":false,"isNotQualified":false,"eventDate":null,"appStatus":{"appStatusId":3,"statusDescription":"Under Review","isActive":true,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"applicationType":null,"assignAppExaminer":{"appExaminerId":'#(appExaminerId)',"appId":'#(appId)',"examinerId":'#(examinerId)',"name":null,"assignDate":'#(formatedSumbitDate)',"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"assignAppToLB":null,"licePermitType":{"licPermitTypeId":'#(mainLicensePermitTypeId)',"type":"1","category":"3","product":'#(productName)',"class":null,"description":null,"sectionOfLaw":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null,"isTempPermit":false,"isELicensingPermit":false,"isAdditionalBar":false},"assoApplicationList":[],"isTempPermit":null,"isTempOrLiq":false,"licPermitTypeId":'#(mainLicensePermitTypeId)',"isAssociatedLicense":null,"effectiveDate":null,"assignedUserId":null,"amendmentTypeId":null,"amendmentType":null,"disapprovedDate":null,"condApprovedDate":null,"addressId":null,"isCaseOpen":null,"isClosed":null,"isCaseOpenSameAddress":null,"isSpecialEventPlusFour":null,"isSpecialEventInsideFiveBoroughs":null,"licStatus":null,"createdBy":null,"licenseId":null,"address":null,"isNybeApp":false,"isHearingCompleted":null,"does500FtHearingExist":null,"parentAppStatus":null,"premisesAppCount":0,"statusDescription":null,"eventAddress":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskRoleId":0,"taskDecision":null,"isActive":true,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":'#(formatedSumbitDate)'},"appId":'#(appId)',"notificationTypeId":2028,"applicationType":1,"decisionType":{"name":"Define Deficiencies","value":1},"emailNotificationModel":{"applicant":{"communicationId":64788,"email":"Automation@test.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":64791,"email":"Automation@test.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"notificationTypeId":2028,"isInstantEmail":false},"hasErrors":[],"taskId":1026,"newComments":"DefineDeficiencies Desc","erDeficiencies":{"selectInput":{"fromFields":[{"id":4,"label":"As the applicant is a corporation, LLC or LLP, the applicant name must be the same as the name on the filing receipt."}],"toFields":[{"id":-1,"label":"As the applicant is a corporation, LLC or LLP, the applicant name must be the same as the name on the filing receipt.","originalId":4}],"isRewritable":true,"rewriteLabel":"Edit Deficiency:","additionalComments":"","srclabel":"Select Deficiencies","dstlabel":"Add to Notification","additionalLabel":"Add Additional Deficiencies:"}}}
	    When method post
	    Then status 200
	   * call read('LicensesCommonMethods.feature@checkApplicationStatus') {}	     
	   
	   
	   
	   
	   
	   
@AddLicenseClaimingQueue
Scenario: AddLicenseClaimingQueue     
	# ********* LB Claiming Queue  ********************* 
 
    Given path 'internalapi/api/licensing/claiming-queue/add/'+appId +'/1069'
    And header authorization = 'Bearer ' + strToken
    And header current-wfroleid = 5
    And request {}
    When method post
    Then status 200
    And def serverResponse = response
    And print serverResponse
    
 # ********* LB Approval *********************    
   
@ApproveLBWithStipulations
Scenario: ApproveDisapproveLB 
	
		 * def fundDueDateFunc1 =
		  """
			  function(days) {
			    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
			    var sdf = new SimpleDateFormat("yyyy-MM-dd");
			    
			    var date = new java.util.Date();
			    var dayAfter = new java.util.Date(date.getTime() + java.util.concurrent.TimeUnit.DAYS.toMillis( days));
			    return sdf.format(dayAfter);
			  } 
		  """
		  * def currentDate = fundDueDateFunc1(0)  
		  * def expiryDate = fundDueDateFunc1(30)    
    Given path '/internalapi/api/licensing/new-license/saveDecision'
    And header authorization = 'Bearer ' + strToken
    And header current-wfroleid = 5
     * def payload = ""
    * def payloadWithReturnToExaminer = {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"isChainRestaurant":false,"appId":'#(appId)',"applicationType":1,"applicationId":'#(ApplicationId)',"legalName":'#(legalName)',"statusId":3,"decisionType":{"name":"Return to Examiner","value":7},"emailNotificationModel":{"applicant":{},"attorney":{},"communityBoard":{},"other":{}},"hasErrors":[],"licPermitTypeId":'#(mainLicensePermitTypeId)',"taskId":1151,"newComments":"returning to examiner queue for correct review"}
    * def payloadWithConditionalApprove = {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"isChainRestaurant":false,"appId":'#(appId)',"applicationType":1,"applicationId":'#(ApplicationId)',"legalName":'#(legalName)',"statusId":3,"decisionType":{"name":"Conditionally Approved","value":5},"emailNotificationModel":{"applicant":{"communicationId":106,"email":"automation@svam.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":109,"email":"sbandi@svam.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}},"hasErrors":[],"licPermitTypeId":'#(mainLicensePermitTypeId)',"taskId":1151,"newComments":"","conditionalApproval":{"selectInput":{"fromFields":[{"id":2,"label":"Provide a copy of the business certificate from the county clerk for your dba name"},{"id":3,"label":"Provide your federal tax identification number"},{"id":4,"label":"Provide a copy of your Certificate of Authority from the New York State Tax Department"},{"id":5,"label":"Provide an amended Certificate of Authority – the name must match the applicant name exactly."},{"id":6,"label":"Provide an amended Certificate of Authority – the address must match the premises address exactly"},{"id":7,"label":"Provide a signed Bond Rider amending____________"},{"id":8,"label":"Provide Worker’s Compensation and Disability Benefits insurance provider names and policy numbers"},{"id":9,"label":"Provide an inventory of the alcoholic beverages you will be purchasing from the current licensee"},{"id":10,"label":"Submit a copy of the Newspaper Affidavit(s)"},{"id":11,"label":"Provide your TTB permit"},{"id":12,"label":"Surrender of the current license in effect"},{"id":13,"label":"Other Condition"}],"toFields":[{"id":1,"label":"Provide a copy of the Assumed Name Certificate from the Secretary of State for your corporation/LLC’s dba name"}],"isRewritable":true,"rewriteLabel":"Edit Condition:","additionalComments":"","srclabel":"Select","dstlabel":"Add to Letter","additionalLabel":"Additional Conditions:"},"effectiveDate":'#(currentDate)',"expirationDate":'#(expiryDate)',"conditions":[1],"descriptions":["Provide a copy of the Assumed Name Certificate from the Secretary of State for your corporation/LLC’s dba name"]}}
    * def payloadWithoutStipulations = {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"isChainRestaurant":false,"appId":'#(appId)',"applicationType":1,"applicationId":'#(ApplicationId)',"legalName":'#(legalName)',"statusId":3,"decisionType":{"name":"Approved","value":1},"emailNotificationModel":{"applicant":{"communicationId":23,"email":"automation@svam.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":26,"email":"sbandi@svam.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}},"hasErrors":[],"licPermitTypeId":'#(mainLicensePermitTypeId)',"taskId":1151,"newComments":"","approval":{"isDefineStipulations":false,"selectInput":{"fromFields":[{"id":1,"label":"Inside of premises closes at x"},{"id":2,"label":"Side walk café closes at x"},{"id":3,"label":"Backyard closes at x"},{"id":4,"label":"Alcohol consumption inside stops at X"},{"id":5,"label":"Alcohol consumption in backyard stops at x"},{"id":6,"label":"Alcohol consumption on sidewalk café stops at x"},{"id":7,"label":"No live music in inside of premises"},{"id":8,"label":"No live music outside of premise"},{"id":9,"label":"No DJs"},{"id":10,"label":"No promoters"},{"id":11,"label":"No Promoted events"},{"id":12,"label":"Recorded music only"},{"id":13,"label":"Music stops at X"},{"id":14,"label":"Music outside stops at X"},{"id":15,"label":"Only non-amplified music"},{"id":16,"label":"Acoustic music only"},{"id":17,"label":"No bar crawls"},{"id":18,"label":"Close façade doors at certain time"},{"id":19,"label":"Close Windows at a certain time"},{"id":20,"label":"No boozy brunches"},{"id":21,"label":"No unlimited drink"},{"id":22,"label":"No happy Hours"},{"id":23,"label":"No bottle service "},{"id":24,"label":"No dancing"},{"id":25,"label":"No delivery bikes"},{"id":26,"label":"No TVs"},{"id":27,"label":"Licensed patio"},{"id":28,"label":"Licensed sidewalk café"},{"id":29,"label":"No outside areas"},{"id":30,"label":"Security Guards required"},{"id":31,"label":"X amount of security guards per x amount of patrons"},{"id":32,"label":"# of security guards per patron"},{"id":33,"label":"No VIP"},{"id":34,"label":"No roped lines"},{"id":35,"label":"No hookah"},{"id":36,"label":"Doors closed at all times"},{"id":37,"label":"Windows closed at all time"},{"id":38,"label":"All agreed upon CB stipulations except"},{"id":39,"label":"All employees must be TIPS trained"},{"id":40,"label":"ABC"}],"toFields":[],"isRewritable":true,"rewriteLabel":"Edit Stipulation:","additionalComments":"","srclabel":"Select Stipulations","dstlabel":"Add to Certificate","additionalLabel":"Add Additional Stipulations:"},"effectiveDate":'#(currentDate)',"expirationDate":'#(expiryDate)',"stipulations":[],"descriptions":[]}}
    * def payloadSingle = {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"isChainRestaurant":false,"appId":'#(appId)',"applicationType":1,"applicationId":'#(ApplicationId)',"legalName":'#(legalName)',"statusId":3,"decisionType":{"name":"Approved","value":1},"emailNotificationModel":{"applicant":{"communicationId":9854,"email":"automation@svam.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}},"hasErrors":[],"licPermitTypeId":'#(mainLicensePermitTypeId)',"taskId":1151,"newComments":"","approval":{"isDefineStipulations":'#(DefineStipulationStatus)',"selectInput":{"fromFields":[{"id":2,"label":"Side walk café closes at x"},{"id":3,"label":"Backyard closes at x"},{"id":4,"label":"Alcohol consumption inside stops at X"},{"id":5,"label":"Alcohol consumption in backyard stops at x"},{"id":6,"label":"Alcohol consumption on sidewalk café stops at x"},{"id":7,"label":"No live music in inside of premises"},{"id":8,"label":"No live music outside of premise"},{"id":9,"label":"No DJs"},{"id":10,"label":"No promoters"},{"id":11,"label":"No Promoted events"},{"id":12,"label":"Recorded music only"},{"id":13,"label":"Music stops at X"},{"id":14,"label":"Music outside stops at X"},{"id":15,"label":"Only non-amplified music"},{"id":16,"label":"Acoustic music only"},{"id":17,"label":"No bar crawls"},{"id":18,"label":"Close façade doors at certain time"},{"id":19,"label":"Close Windows at a certain time"},{"id":20,"label":"No boozy brunches"},{"id":21,"label":"No unlimited drink"},{"id":22,"label":"No happy Hours"},{"id":23,"label":"No bottle service "},{"id":24,"label":"No dancing"},{"id":25,"label":"No delivery bikes"},{"id":26,"label":"No TVs"},{"id":27,"label":"Licensed patio"},{"id":28,"label":"Licensed sidewalk café"},{"id":29,"label":"No outside areas"},{"id":30,"label":"Security Guards required"},{"id":31,"label":"X amount of security guards per x amount of patrons"},{"id":32,"label":"# of security guards per patron"},{"id":33,"label":"No VIP"},{"id":34,"label":"No roped lines"},{"id":35,"label":"No hookah"},{"id":36,"label":"Doors closed at all times"},{"id":37,"label":"Windows closed at all time"},{"id":38,"label":"All agreed upon CB stipulations except"},{"id":39,"label":"All employees must be TIPS trained"},{"id":40,"label":"ABC"}],"toFields":[{"id":1,"label":"Inside of premises closes at x"}],"isRewritable":true,"rewriteLabel":"Edit Stipulation:","additionalComments":"","srclabel":"Select Stipulations","dstlabel":"Add to Certificate","additionalLabel":"Add Additional Stipulations:"},"effectiveDate":'#(currentDate)',"expirationDate":'#(expiryDate)',"stipulations":[1],"descriptions":["Inside of premises closes at x"]}}
    * def payloadmultiple = {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"isChainRestaurant":false,"appId":'#(appId)',"applicationType":1,"applicationId":'#(ApplicationId)',"legalName":'#(legalName)',"statusId":3,"decisionType":{"name":"Approved","value":1},"emailNotificationModel":{"applicant":{"communicationId":9854,"email":"automation@svam.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}},"hasErrors":[],"licPermitTypeId":'#(mainLicensePermitTypeId)',"taskId":1151,"newComments":"","approval":{"isDefineStipulations":true,"selectInput":{"fromFields":[],"toFields":[{"id":1,"label":"Inside of premises closes at x"},{"id":2,"label":"Side walk café closes at x"},{"id":3,"label":"Backyard closes at x"},{"id":4,"label":"Alcohol consumption inside stops at X"},{"id":5,"label":"Alcohol consumption in backyard stops at x"},{"id":6,"label":"Alcohol consumption on sidewalk café stops at x"},{"id":7,"label":"No live music in inside of premises"},{"id":8,"label":"No live music outside of premise"},{"id":9,"label":"No DJs"},{"id":10,"label":"No promoters"},{"id":11,"label":"No Promoted events"},{"id":12,"label":"Recorded music only"},{"id":13,"label":"Music stops at X"},{"id":14,"label":"Music outside stops at X"},{"id":15,"label":"Only non-amplified music"},{"id":16,"label":"Acoustic music only"},{"id":17,"label":"No bar crawls"},{"id":18,"label":"Close façade doors at certain time"},{"id":19,"label":"Close Windows at a certain time"},{"id":20,"label":"No boozy brunches"},{"id":21,"label":"No unlimited drink"},{"id":22,"label":"No happy Hours"},{"id":23,"label":"No bottle service "},{"id":24,"label":"No dancing"},{"id":25,"label":"No delivery bikes"},{"id":26,"label":"No TVs"},{"id":27,"label":"Licensed patio"},{"id":28,"label":"Licensed sidewalk café"},{"id":29,"label":"No outside areas"},{"id":30,"label":"Security Guards required"},{"id":31,"label":"X amount of security guards per x amount of patrons"},{"id":32,"label":"# of security guards per patron"},{"id":33,"label":"No VIP"},{"id":34,"label":"No roped lines"},{"id":35,"label":"No hookah"},{"id":36,"label":"Doors closed at all times"},{"id":37,"label":"Windows closed at all time"},{"id":38,"label":"All agreed upon CB stipulations except"},{"id":39,"label":"All employees must be TIPS trained"},{"id":40,"label":"ABC"}],"isRewritable":true,"rewriteLabel":"Edit Stipulation:","additionalComments":"","srclabel":"Select Stipulations","dstlabel":"Add to Certificate","additionalLabel":"Add Additional Stipulations:"},"effectiveDate":'#(currentDate)',"expirationDate":'#(expiryDate)',"stipulations":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40],"descriptions":["Inside of premises closes at x","Side walk café closes at x","Backyard closes at x","Alcohol consumption inside stops at X","Alcohol consumption in backyard stops at x","Alcohol consumption on sidewalk café stops at x","No live music in inside of premises","No live music outside of premise","No DJs","No promoters","No Promoted events","Recorded music only","Music stops at X","Music outside stops at X","Only non-amplified music","Acoustic music only","No bar crawls","Close façade doors at certain time","Close Windows at a certain time","No boozy brunches","No unlimited drink","No happy Hours","No bottle service ","No dancing","No delivery bikes","No TVs","Licensed patio","Licensed sidewalk café","No outside areas","Security Guards required","X amount of security guards per x amount of patrons","# of security guards per patron","No VIP","No roped lines","No hookah","Doors closed at all times","Windows closed at all time","All agreed upon CB stipulations except","All employees must be TIPS trained","ABC"]}}
     * eval if (StipulationsCount == 0 && licStatus == 'Approved') payload = payloadWithoutStipulations
    * eval if (StipulationsCount == 1 && licStatus == 'Approved') payload = payloadSingle
    * eval if (StipulationsCount > 1 && licStatus == 'Approved') payload = payloadmultiple
    * eval if (licStatus == 'Conditionally Approved') payload = payloadWithConditionalApprove
    * eval if (licStatus == 'Return to Examiner') payload = payloadWithReturnToExaminer
    And request payload         
           When method post
    Then status 200
    And def serverResponse = response
    And print serverResponse
          
  # ********* GET License Id *********************  
  
    Given path '/internalapi/api/licensing/LBDecision/getLicenseByAppId/' + appId +'/-1'
    And header authorization = 'Bearer ' + strToken
    And request {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"masterFileData":[],"combinedCraftData":[],"appId":'#(appId)',"applicationType":1,"applicationId":'#(ApplicationId)',"legalName":null,"statusId":3,"decisionType":{"name":"Approved","value":1},"emailNotificationModel":{"applicant":{},"attorney":{},"other":{"email":""}},"hasErrors":[],"taskId":1151,"newComments":"","approval":{"isDefineStipulations":false,"selectInput":{"fromFields":[{"id":1,"label":"Inside of premises closes at x"},{"id":2,"label":"Side walk café closes at x"},{"id":3,"label":"Backyard closes at x"},{"id":4,"label":"Alcohol consumption inside stops at X"},{"id":5,"label":"Alcohol consumption in backyard stops at x"},{"id":6,"label":"Alcohol consumption on sidewalk café stops at x"},{"id":7,"label":"No live music in inside of premises"},{"id":8,"label":"No live music outside of premise"},{"id":9,"label":"No DJs"},{"id":10,"label":"No promoters"},{"id":11,"label":"No Promoted events"},{"id":12,"label":"Recorded music only"},{"id":13,"label":"Music stops at X"},{"id":14,"label":"Music outside stops at X"},{"id":15,"label":"Only non-amplified music"},{"id":16,"label":"Acoustic music only"},{"id":17,"label":"No bar crawls"},{"id":18,"label":"Close façade doors at certain time"},{"id":19,"label":"Close Windows at a certain time"},{"id":20,"label":"No boozy brunches"},{"id":21,"label":"No unlimited drink"},{"id":22,"label":"No happy Hours"},{"id":23,"label":"No bottle service "},{"id":24,"label":"No dancing"},{"id":25,"label":"No delivery bikes"},{"id":26,"label":"No TVs"},{"id":27,"label":"Licensed patio"},{"id":28,"label":"Licensed sidewalk café"},{"id":29,"label":"No outside areas"},{"id":30,"label":"Security Guards required"},{"id":31,"label":"X amount of security guards per x amount of patrons"},{"id":32,"label":"# of security guards per patron"},{"id":33,"label":"No VIP"},{"id":34,"label":"No roped lines"},{"id":35,"label":"No hookah"},{"id":36,"label":"Doors closed at all times"},{"id":37,"label":"Windows closed at all time"},{"id":38,"label":"All agreed upon CB stipulations except"},{"id":39,"label":"All employees must be TIPS trained"}],"toFields":[],"isRewritable":true,"rewriteLabel":"Edit Stipulation:","srclabel":"Select Stipulations","dstlabel":"Add to Certificate","additionalLabel":"Add Additional Stipulations:"},"effectiveDate":"2022-01-10","expirationDate":"2022-08-31","stipulations":[],"descriptions":[]}}
    When method get
    Then status 200
    And def serverResponse = response
    And print serverResponse
    And def licId = serverResponse.license.licId
    And def licenseId = serverResponse.license.licenseId
    And print serverResponse
    And print 'licId : ' , licId
    And print 'licenseId : ' , licenseId
    And match licId != []
    And match licenseId != []   
    
    
  
@DisapproveLB
Scenario: DisapproveLB
	Given path '/internalapi/api/licensing/new-license/saveDecision'
    And header authorization = 'Bearer ' + strToken
    And header current-wfroleid = 5
    * def payload = {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"isChainRestaurant":false,"appId":'#(appId)',"applicationType":1,"applicationId":'#(ApplicationId)',"legalName":'#(legalName)',"statusId":3,"decisionType":{"name":'#(lbStatus)',"value":'#(lbDropDownVal)'},"emailNotificationModel":{"applicant":{"communicationId":68,"email":"automation@test.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":71,"email":"automation@test.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":0,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}},"hasErrors":[],"licPermitTypeId":'#(mainLicensePermitTypeId)',"taskId":1151,"newComments":"","disApproval":{"isDisapprovalForCause":true,"isDisapprovalLetterAttach":true,"selectInput":{"fromFields":[{"id":2,"label":"A temporary permit for a New York City premises may not be considered for approval, unless a contract of sale is submitted with the application.  No contract of sale was submitted for this transaction."},{"id":3,"label":"A liquidator’s permit may not be considered for approval when the application it is filed in conjunction with is disapproved."},{"id":4,"label":"A liquidator’s permit may not be approved when the seller of the alcohol is currently in arrears and on the Authority’s COD List.  The seller will need to clear all accounts in arrears and re-apply."},{"id":5,"label":"An insufficient fee was submitted with the application.  Total fee due was $___ and the total fee paid was $_____"},{"id":6,"label":"Check number ____ in the amount of ________ , for payment in connection with this application was returned due to insufficient funds.  A request for certified funds was sent to the applicant on _________, to which there was no reply."},{"id":7,"label":"Licensees are not eligible to change corporate entities using an endorsement/corporate change application.  A licensee forming a new entity and using a new FEIN# must file a new application under the new corporate entity."},{"id":8,"label":"Endorsement applications may not be used to change an application from an executor of an estate to a corporation.  A new application must be filed once the estate is settled."},{"id":9,"label":"Licensee is not eligible to file a removal under a new corporate entity.  Licensee must file a new application for the new corporate entity with the new FEIN #."},{"id":10,"label":"The applicant submitted an outdated application form that is no longer accepted for processing as of 11/30/13."},{"id":11,"label":"Temporary retail permit was received with an outdated main application."},{"id":12,"label":"The corporate change filed under this serial number is a duplicate of a corporate change filed on _______________under _________________________________, serial number __________."}],"toFields":[{"id":1,"label":"A temporary permit may not be considered for approval unless it is preceded or accompanied by an application for a permanent license."}],"isRewritable":true,"rewriteLabel":"Edit Reason for Disapproval:","additionalComments":"disapprove the app","srclabel":"Select","dstlabel":"Add to Notification","additionalLabel":"Additional Reasons for Disapproval:"},"disapprovalReason":[1,-1],"descriptions":["A temporary permit may not be considered for approval unless it is preceded or accompanied by an application for a permanent license.","disapprove the app"]}}
   	* def withdrawalpayload = {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"isChainRestaurant":false,"appId":'#(appId)',"applicationType":1,"applicationId":'#(ApplicationId)',"legalName":'#(legalName)',"statusId":3,"decisionType":{"name":"Withdrawal","value":4},"emailNotificationModel":{"applicant":{"communicationId":8,"email":"automation@svam.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":11,"email":"sbandi@svam.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}},"hasErrors":[],"licPermitTypeId":'#(mainLicensePermitTypeId)',"taskId":1151,"newComments":"withdrawing app"}
   	* eval if(lbStatus == 'Withdrawal') payload = withdrawalpayload			
    And request payload         
    When method post
    Then status 200
    And def serverResponse = response
    And print serverResponse

@FBDecisionRequiredScenario
Scenario: FBDecisionRequiredScenario
	* def fundDueDateFunc1 =
		  """
			  function(days) {
			    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
			    var sdf = new SimpleDateFormat("yyyy-MM-dd");
			    
			    var date = new java.util.Date();
			    var dayAfter = new java.util.Date(date.getTime() + java.util.concurrent.TimeUnit.DAYS.toMillis( days));
			    return sdf.format(dayAfter);
			  } 
		  """
		  * def currentDate = fundDueDateFunc1(0)  
		  * def expiryDate = fundDueDateFunc1(30) 
	Given path '/internalapi/api/licensing/new-license/saveDecision'
    And header authorization = 'Bearer ' + strToken
    And header current-wfroleid = 5
    * def payload = {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"isChainRestaurant":false,"appId":'#(appId)',"applicationType":1,"applicationId":'#(ApplicationId)',"legalName":'#(legalName)',"statusId":3,"decisionType":{"name":"FB Decision Required","value":6},"emailNotificationModel":{"applicant":{},"attorney":{},"communityBoard":{},"other":{}},"hasErrors":[],"licPermitTypeId":'#(mainLicensePermitTypeId)',"taskId":1151,"newComments":"","conditionalApproval":{"selectInput":{"fromFields":[{"id":2,"label":"Provide a copy of the business certificate from the county clerk for your dba name"},{"id":3,"label":"Provide your federal tax identification number"},{"id":4,"label":"Provide a copy of your Certificate of Authority from the New York State Tax Department"},{"id":5,"label":"Provide an amended Certificate of Authority – the name must match the applicant name exactly."},{"id":6,"label":"Provide an amended Certificate of Authority – the address must match the premises address exactly"},{"id":7,"label":"Provide a signed Bond Rider amending____________"},{"id":8,"label":"Provide Worker’s Compensation and Disability Benefits insurance provider names and policy numbers"},{"id":9,"label":"Provide an inventory of the alcoholic beverages you will be purchasing from the current licensee"},{"id":10,"label":"Submit a copy of the Newspaper Affidavit(s)"},{"id":11,"label":"Provide your TTB permit"},{"id":12,"label":"Surrender of the current license in effect"},{"id":13,"label":"Other Condition"}],"toFields":[{"id":1,"label":"Provide a copy of the Assumed Name Certificate from the Secretary of State for your corporation/LLC’s dba name"}],"isRewritable":true,"rewriteLabel":"Edit Condition:","additionalComments":"FB decision required","srclabel":"Select","dstlabel":"Add to Letter","additionalLabel":"Additional Conditions:"},"effectiveDate":'#(currentDate)',"expirationDate":'#(expiryDate)',"conditions":[1,-1],"descriptions":["Provide a copy of the Assumed Name Certificate from the Secretary of State for your corporation/LLC’s dba name","FB decision required"]}}
   	And request payload         
    When method post
    Then status 200
    And def serverResponse = response
    And print serverResponse
    



@SearchAndValidateLicenseExaminerQueue
Scenario: SearchAndValidateLicenseExaminerQueue
Given path '/internalapi/api/licensing/search/licenseApplication/queueType/1'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      * def stringParam = "applicationId~contains~'"+ApplicationId+"'"
      And params  {filter:'#(stringParam)',page:1,pageSize:10,licenseTypeId:1,examinerId:1069,licensingBoardId:-1,isRealTimeResult:false}
     
      And request ""
	  When method get
	  Then status 200
	  And print response
	  * match response.data[0].applicationId == '#(ApplicationId)'  
	  * match response.data[0].taskStatus == '#(taskStatus)'

@SearchAndValidateCounselQueueApplicationStatus
Scenario: ValidateLicenseApplicationStatus on Search Page 
Given path '/internalapi/api/CounselDashboard/GetCounselAttorneyQueue'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      * def stringParam = "referralCaseApplicationNo~contains~'"+ApplicationId+"'"
      And params  {filter:'#(stringParam)',page:1,pageSize:10}
      And request ""
	  When method get
	  Then status 200
	  And print response
	  * match response.data[0].applicationId == '#(ApplicationId)'  
	  * match response.data[0].taskStatus == '#(letterStatus)' 
	  
@updateInformationLetter
Scenario: updateInformationLetter
	Given path '/internalapi/api/license/updateInformationLetter'
    And header authorization = 'Bearer ' + strToken
    And header Content-Type = 'application/json'
     And header current-wfroleid = '3'
    And header Accept = 'application/json'
    * def payload = ""
    * def disapprovalPayload = {"appId":'#(appId)',"applicationId":'#(ApplicationId)',"legalName":'#(legalName)',"opened":true,"approved":'#(approvedStatus)',"comment":'#(comment)',"disapprovalComment":"Disapproval Letter comment"}
    * def approvalPayload = {"appId":'#(appId)',"applicationId":'#(ApplicationId)',"legalName":'#(legalName)',"opened":true,"approved":'#(approvedStatus)',"comment":'#(comment)'}
   	* eval if(approvedStatus == true) payload = approvalPayload
   * eval if(approvedStatus == false) payload = disapprovalPayload
   	And request payload         
    When method post
    Then status 200
    And def serverResponse = response
    * match serverResponse == 'true' 
    
    
@SearchAndValidateClericalQueueApplicationStatus
Scenario: SearchAndValidateClericalQueueApplicationStatus on Search Page 
Given path '/internalapi/api/licensing/search/licenseApplication/queueType/5'
	* def dbSts = db.cleanHeap()
  	   And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json'
      And header Accept = 'application/json'
     
       And header current-wfroleid = '3'
      * def stringParam = "applicationId~contains~'"+ApplicationId+"'"
      And params  {licenseTypeId:1,examinerId:-1,licensingBoardId:-1,isRealTimeResult:false,filter:'#(stringParam)',page:1,pageSize:10}
      
      And request ""
	  When method get
	  Then status 200
	  And print response
	  * match response.data[0].applicationId == '#(ApplicationId)'  
	  * match response.data[0].taskStatus == '#(taskStatus)' 	  
	             
@saveConditionsInfo
Scenario: saveConditionsInfo
	Given path '/internalapi/api/licensing/conditionReview/getConditionsInfo/'+appId
    	* def dbSts = db.cleanHeap()
  	   And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json'
      And header current-wfroleid = '3'
    And header Accept = 'application/json'
     And request ""
	  When method get
	  Then status 200
	  And print response
	  * def appConditionId = response.conditionReview[0].appConditionId 
	  * def conditionDefinedDate = response.conditionReview[0].conditionDefinedDate 
	  * def conditionId = response.conditionReview[0].conditionId
	   * def conditionDescription = response.conditionReview[0].conditionDescription
	    * def conditionDescriptionDetail = response.conditionReview[0].conditionDescriptionDetail
	     * def responseDueDate = response.conditionReview[0].responseDueDate
	  * def taskDecision = response.conditionReview[0].taskDecision
	     * def taskId = response.conditionReview[0].taskId 
	 
	Given path '/internalapi/api/licensing/conditionReview/saveConditionsInfo'
    And header authorization = 'Bearer ' + strToken
    And header Content-Type = 'application/json'
     And header current-wfroleid = '3'
    And header Accept = 'application/json'
   
   * def getCurrentDate =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		  """
		   * def getAddedDate =
		  """
		  function(days) {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd");
		    
		    var date = new java.util.Date();
		    var dayAfter = new java.util.Date(date.getTime() + java.util.concurrent.TimeUnit.DAYS.toMillis( days));
		    return sdf.format(dayAfter);
		  } 
		  """
		* def todaysDate = getCurrentDate()
		* def Added20DaysDate = getAddedDate(20)
		
		
   	And request {"effectiveDate":'#(todaysDate)',"expirationDate":'#(Added20DaysDate)',"conditionReview":[{"appConditionId":'#(appConditionId)',"appId":'#(appId)',"conditionId":'#(conditionId)',"conditionDescriptionDetail":'#(conditionDescriptionDetail)',"conditionDescription":'#(conditionDescription)',"createdBy":"tgupta@svam.com","conditionDefinedDate":'#(conditionDefinedDate)',"responseDueDate":'#(responseDueDate)',"isConditionMet":true,"responseReceived":null,"attachedDocumentIds":null,"responseReceivedJson":null,"attachDocument":null,"taskOption":null,"documents":[],"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":'#(taskId)',"taskRoleId":0,"taskDecision":'#(taskDecision)',"isActive":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}],"appId":'#(appId)',"comment":"","taskId":'#(taskId)',"taskDecision":'#(taskDecision)',"isSaveResponse":false,"isSubmit":true,"emailNotificationModel":{"applicant":{"communicationId":19835,"email":"automation@svam.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":19838,"email":"sbandi@svam.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}}}

	 
    When method post
    Then status 200
    And def serverResponse = response
    * match serverResponse == 'true' 
    Given path '/internalapi/api/licensing/LBDecision/getApprovalInfoByAppId/'+appId
    
  	   And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json'
      And header current-wfroleid = '3'
    And header Accept = 'application/json'
     And request ""
	  When method get
	  Then status 200
	  And print response
	  * match response.licensePermitId != []
	   * match response.licensePermitId != null

@ValidateAttachedDocument
Scenario: ValidateAttachedDocument
	* def dbSts = db.cleanHeap()
	  Given path '/internalapi/api/documents/GetDocuments'
    
  	   And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json'
     And header current-wfroleid = '4'
    And header Accept = 'application/json, text/plain, */*'
     And request {"type":"application","id":'#(appId)',"subCategory":""}
	  When method post
	  Then status 200
	  And print response
	 * def docData = karate.jsonPath(response, "$[?(@.documentDesc == '" + documentDesc + "')]")
	 * def fileName = docData[0].fileName
	 * match fileName == documentDesc+'.pdf'
 
 
    	
@ValidateEmailCommunicationQueue
 Scenario: ValidateEmailCommunicationQueue Email Communication Page scenario
	
	Given path '/internalapi/api/Communication/GetEmailCommQueue/Application/'+appId
	   	
	 	And header authorization = 'Bearer ' + strToken
	  	And header Content-Type = 'application/json; charset=utf-8'
	    And header Accept = 'application/json; text/plain;*/*'
	    And header user-agent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36'
	  	And request ""
	    When method get
	    Then status 200	    
	    
	    And def serverResponse = response
	    
	    * def serverResponseNotificationData = karate.jsonPath(serverResponse, "$[?(@.typeOfNotification == '" + typeOfNotification + "')]")
		And print serverResponseNotificationData
		* match serverResponseNotificationData[0].status == 'Sent'
		* match serverResponseNotificationData[0].emailTo != []
		* match serverResponseNotificationData[0].subject == subject
		* match serverResponseNotificationData[0].emailBody contains emailBodyData
		
		
		
@IntakeCCApplication
Scenario: IntakeCCApplication 
	Given path '/internalapi/api/MfccSearch/MfccAppLicenseSearch'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      
      And request {"showOnlyLicensesAssociated":false,"applyFor":"combinedStatus","LicensePermitId":"","LegalName":"%%%"}
	  When method post
	  Then status 200
	  And print response
	  
	  * def docData = karate.jsonPath(response, "$[?(@.licensePermitStatus == 'Active')]")
	  * def docAppId1 = docData[0].appId
	  
	  * def docApplicationId1 = docData[0].applicationLicenseId
	  
	  * def docAppId2 = docData[1].appId
	  
	  * def docApplicationId2 = docData[1].applicationLicenseId
	  
	  
	  
	Given path '/internalapi/api/MfccCommon/CreateMfccLicense'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      
      And request {"existingLicenses":['#(docApplicationId1)','#(docApplicationId2)'],"isMasterFile":false,"masterFileId":null,"combinedCraftId":null}
	  When method post
	  Then status 200
	  And print response	
	  	 And def ApplicationId = response[0].mainApplicationId
	  And print ApplicationId
	  And match ApplicationId contains 'CM-'
	  And match ApplicationId contains '-A'
	  * def currentYear = '-'+getYearFunc()+'-'
	  And match ApplicationId contains currentYear
	  And def description = response[0].description
	 
	   And def appId = response[0].appId
	  
	   * def formId = response[0].formId
	   
	   * def licensePermitTypeId = response[0].licensePermitTypeId
	  
	  	
@SumbitCCApplication
Scenario: SumbitCCApplication 
	Given path '/internalapi/api/application/saveReasonHiglyDeficient'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      
      And request {"appId":'#(appId)',"isHighlyDeficient":false,"reasons":null,"comments":null}
	  When method post
	  Then status 200
	  And print response
	  * match response == 'true'
	 Given path '/internalapi/api/licensing/app/save'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      
      And request {"isApproved":false,"appId":'#(appId)',"formID":'#(formId)',"applicationID":"","formName":"CombinedCraft_Status","formType":{},"formTypeId":null,"applicationType":{},"applicationTypeId":1,"formCategory":{},"formCategoryId":7,"approvalFlag":null,"status":"","createdBy":"","createdDate":"","modifiedBy":"","sections":[{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1737,"key":"","label":"Attestation and Description","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"heading","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1738,"key":"","label":"By checking this box, I agree to comply with all the terms and conditions listed above","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"checkbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2419,"key":"","label":"Full Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":233,"sectionName":"Attestation","key":"0","label":"Attestation","order":4,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isStatic":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"parentSection":"","subSections":[],"sectionFieldOrders":[],"address":{"addressLine1":"","addressLine2":"","stateId":null,"county":"","city":"","zipCode":"","zip4":"","country":"United States (US)","stateName":"","countryId":229}},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2434,"key":"","label":"List Craft Manufacturer serial numbers currently licensed to be combined","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"heading","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1324,"sectionName":"AD_CombinedCraftStatus","key":"0","label":"Application Details","order":3,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isStatic":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"parentSection":"","subSections":[{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1968,"key":"","label":"License ID","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1323,"sectionName":"AD_CombinedCraftStatus","key":"0","label":"List of Licenses IDs","order":1,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isStatic":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"parentSection":"","subSections":[],"sectionFieldOrders":[],"address":{"addressLine1":"","addressLine2":"","stateId":null,"county":"","city":"","zipCode":"","zip4":"","country":"United States (US)","stateName":"","countryId":229}}],"sectionFieldOrders":[],"address":{"addressLine1":"","addressLine2":"","stateId":null,"county":"","city":"","zipCode":"","zip4":"","country":"United States (US)","stateName":"","countryId":229}}],"formVersionId":1379,"version":1,"licenseDescription":"Combined Craft Status","statusDescription":"Draft","appStatusId":1,"showApplicant":true,"showRepresentative":true,"showPrincipal":true,"showLandlord":false,"showVehicles":false,"showSchedule":false,"showAbcOfficer":false,"showCorpChange":false,"showEndorsement":false,"staticTabSequence":{"Applicant Information":0,"Principal":1,"Representative":2},"staticTaborder":["Applicant Information","Principal","Representative"],"showPQ":false,"showCC":false,"showManuOnPrem":false,"licPermitTypeId":'#(licensePermitTypeId)',"tabVisitied":{"Applicant Information":false,"Principal":false,"Representative":false}}
      When method post
	  Then status 200
	  And print response
	  * match response.appId == appId
	 
	 
	Given path '/internalapi/api/licensing/app/submit'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      
      And request {"appId":'#(appId)',"wfType":null}
	  When method post
	  Then status 200
	  And print response		
	  * match response.success == true	
	  
	  
	  
@CheckExaminerSubmit
Scenario: CheckExaminerSubmit 
	Given path '/internalapi/api/documents/GetDocuments'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      
      And request {"type":"application","id":'#(appId)',"subCategory":""}
	  When method POST
	  Then status 200
	  And print response
	  
	Given path '/internalapi/api/CombinedCraft/GetCombinedCraftData/'+appId
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      
      And request ""
	  When method get
	  Then status 200
	  And print response		
	  * def CombCraftAppId1 = response[0].appId
	  * def CombCraftAppId2 = response[1].appId
	  * def CombCraftId1 = response[0].id
	  * def CombCraftId2 = response[1].id
	  
	  * def CombCraftLicDes1 = response[0].licenseDescription
	  * def CombCraftLicDes2 = response[1].licenseDescription
	  * def CombCraftLicPermitTypeId1 = response[0].licPermitTypeId
	  * def CombCraftLicPermitTypeId2 = response[1].licPermitTypeId
	  
	  * def CombCraftLicenseId1 = response[0].licenseId
	  * def CombCraftLicenseId2 = response[1].licenseId
	  * def CombCraftExpiryDate1 = response[0].expiryDate
	  * def CombCraftExpiryDate2 = response[1].expiryDate
	  * def CombCraftlicId1 = response[0].licId
	  * def CombCraftlicId2 = response[1].licId
	  * def CombCraftlicenseFee1 = ~~Math.round(response[0].licenseFee)
	  * def CombCraftlicenseFee2 = ~~Math.round(response[1].licenseFee)
	  
   * def getDate =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'04:00:00.000'Z'");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		  """
		  
  	  * def conversionDate = getDate()
   Given path '/internalapi/api/comment/Application/get'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      
      And request {"acaId":'#(appId)',"acatype":"Application","acacommentId":-1,"commentId":-1,"bureauId":1}

	  When method POST
	  Then status 204
	  
   Given path '/internalapi/api/MfccCommon/ConvertLicenseExpiration'
  	  And header Content-Type = 'application/json'
      And header Accept = 'application/json'
      And header authorization = 'Bearer ' + strToken
            And header current-wfroleid = '4'
      * def CombCraftExpiryDate1 = CombCraftExpiryDate1 + '.000Z'
      * def CombCraftExpiryDate2 = CombCraftExpiryDate2 + '.000Z'
      And request {"appId":'#(appId)',"conversionDate":'#(conversionDate)',"mfccFileDataDtos":[{"id":'#(CombCraftId1)',"appId":'#(CombCraftAppId1)',"mainAppId":'#(appId)',"licId":'#(CombCraftlicId1)',"licenseId":'#(CombCraftLicenseId1)',"licPermitTypeId":'#(CombCraftLicPermitTypeId1)',"licenseDescription":'#(CombCraftLicDes1)',"expiryDate":'#(CombCraftExpiryDate1)',"licensePermitStatus":"Active","licenseFee":'#(CombCraftlicenseFee1)',"newExpiryDate":'#(conversionDate)',"oldExpiryDate":null,"amountDue":null,"newLicPermitTypeId":null,"oldLicPermitTypeId":null,"conversionFee":0,"termAdjustmentFee":0,"mfccMainAppId":'#(appId)',"isSelected":true},{"id":'#(CombCraftId2)',"appId":'#(CombCraftAppId2)',"mainAppId":'#(appId)',"licId":'#(CombCraftlicId2)',"licenseId":'#(CombCraftLicenseId2)',"licPermitTypeId":'#(CombCraftLicPermitTypeId2)',"licenseDescription":'#(CombCraftLicDes2)',"expiryDate":'#(CombCraftExpiryDate2)',"licensePermitStatus":"Active","licenseFee":'#(CombCraftlicenseFee2)',"newExpiryDate":'#(conversionDate)',"oldExpiryDate":null,"amountDue":null,"newLicPermitTypeId":null,"oldLicPermitTypeId":null,"conversionFee":0,"termAdjustmentFee":0,"mfccMainAppId":'#(appId)',"isSelected":true}]}
    			 
     When method post
	  Then status 200
	  And print response
	   * def CombCrafttermAdjustmentFee1 = 0
	   * eval if(response[0].termAdjustmentFee != null) CombCrafttermAdjustmentFee1 = ~~Math.round(response[0].termAdjustmentFee)
	   * def CombCrafttermAdjustmentFee2 = 0
	   * eval if(response[1].termAdjustmentFee != null) CombCrafttermAdjustmentFee2 = ~~Math.round(response[1].termAdjustmentFee)
	   * def CombCraftAmontDue1 = 0
	   * def CombCraftAmountDue1 = response[0].amountDue
	   * def CombCraftAmountDue2 = response[1].amountDue
	   * def termAdjustmentFee1 = response[0].termAdjustmentFee
	   * def termAdjustmentFee2 = response[1].termAdjustmentFee
	   * def totalAmountDue = response[0].amountDue + response[1].amountDue
	   * eval if(response[0].amountDue != null) CombCraftAmontDue1 = ~~Math.round(response[0].amountDue)
	   * def CombCraftAmontDue2 = 0
	   * eval if(response[1].amountDue != null) CombCraftAmontDue2 = ~~Math.round(response[1].amountDue)
	   And print CombCraftAmontDue1
	   And print CombCraftAmontDue2
	* def CombCrafttermoldExpiryDate1 = response[0].oldExpiryDate + '.000Z'
	* def CombCrafttermoldExpiryDate2 = response[1].oldExpiryDate + '.000Z'
	
	
	   Given path '/internalapi/api/application/'+appId
	   	* def dbSts = db.cleanHeap()
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;*/*'
	      And configure continueOnStepFailure = true
	   	 And request {}
		  When method get
		  * configure continueOnStepFailure = true
		  Then status 200
		    * def formVersionId = response.formVersionId
		  And print formVersionId
		  * def submitDateCC = response.submitDate
		  And print submitDateCC
		   * def appExaminerId = response.assignAppExaminer.appExaminerId
		  And print appExaminerId
		  * def assignDate = response.assignAppExaminer.assignDate
		  And print assignDate
	Given path '/internalapi/api/licensing/examiner-review/SaveNewLicense/'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And print CombCraftAmountDue1
	  And print CombCraftAmountDue2
	  And print termAdjustmentFee1
	  And print termAdjustmentFee2
      And print totalAmountDue
     And request {"isFingerPrintsApproved":false,"isFingerPrintsRequired":false,"isCorpLLCDissolved":false,"isCorpLLCDTaken":false,"isSendPDLetter":false,"isDisable500LB_FBPT":false,"isDisableLBForPD":false,"isDisableLBForCaseClosed":false,"isDisableLateRenewalAndUnderpayment":false,"isLiquidatorPermitHasCompleted":-1,"isSubmit":true,"fieldDeficiencies":[],"masterFileData":[],"combinedCraftData":[],"application":{"applicationCategory":7,"appId":'#(appId)',"applicationId":'#(ApplicationId)',"licePermitTypeId":null,"applicationTypeId":1,"formVersionId":'#(formVersionId)',"formId":'#(formId)',"legalName":null,"submitDate":'#(submitDateCC)',"isGISRequired":null,"licenseDescription":"Combined Craft Status","recommendedDecisionId":null,"status500":null,"isApplicableForPDLetter":false,"countyName":null,"priority":"Normal","expirationDate":null,"appStatusId":3,"taskStatus":"Awaiting Review","taskId":1026,"currentWfstatus":null,"communityBoard":null,"isLicenseApplication":true,"currentDueDate":null,"isFinalDeficiency":null,"isHighlyDeficient":false,"isAllDeficienciesMet":null,"pastDueDate":null,"memo":null,"isOneTimePermit":null,"dueDateAction":null,"isDisapprovedForCause":false,"isNotQualified":false,"eventDate":null,"appStatus":{"appStatusId":3,"statusDescription":"Under Review","isActive":true,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"applicationType":null,"assignAppExaminer":{"appExaminerId":'#(appExaminerId)',"appId":'#(appId)',"examinerId":1069,"name":null,"assignDate":'#(assignDate)',"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"assignAppToLB":null,"licePermitType":{"licPermitTypeId":'#(licensePermitTypeId)',"type":"1","category":"7","product":null,"class":null,"description":null,"sectionOfLaw":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null,"isTempPermit":false,"isELicensingPermit":false,"isAdditionalBar":false},"assoApplicationList":[],"isTempPermit":null,"isTempOrLiq":false,"licPermitTypeId":'#(licensePermitTypeId)',"isAssociatedLicense":null,"effectiveDate":null,"assignedUserId":null,"amendmentTypeId":null,"amendmentType":null,"disapprovedDate":null,"condApprovedDate":null,"addressId":null,"isCaseOpen":null,"isClosed":null,"isCaseOpenSameAddress":null,"isSpecialEventPlusFour":null,"isSpecialEventInsideFiveBoroughs":null,"licStatus":null,"createdBy":null,"licenseId":null,"address":null,"isNybeApp":false,"isHearingCompleted":null,"does500FtHearingExist":null,"parentAppStatus":null,"premisesAppCount":0,"statusDescription":null,"eventAddress":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskRoleId":0,"taskDecision":null,"isActive":true,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":'#(conditionDefinedDate)'},"appId":'#(appId)',"notificationTypeId":2028,"applicationType":1,"decisionType":{"name":"Send to Licensing Board","value":2},"emailNotificationModel":{"applicant":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{},"communityBoard":{},"other":{}},"hasErrors":[],"taskId":1026,"combinedCraftAndMasterFileGrandTotal":'#(totalAmountDue)',"mfccFileDataDtos":[{"id":'#(CombCraftId1)',"appId":'#(CombCraftAppId1)',"mainAppId":'#(appId)',"licId":'#(CombCraftlicId1)',"licenseId":'#(CombCraftLicenseId1)',"licPermitTypeId":'#(CombCraftLicPermitTypeId1)',"licenseDescription":'#(CombCraftLicDes1)',"expiryDate":'#(CombCraftExpiryDate1)',"licensePermitStatus":"Active","licenseFee":'#(CombCraftlicenseFee1)',"newExpiryDate":'#(conversionDate)',"oldExpiryDate":'#(CombCrafttermoldExpiryDate1)',"amountDue":'#(CombCraftAmountDue1)',"newLicPermitTypeId":null,"oldLicPermitTypeId":null,"conversionFee":0,"termAdjustmentFee":'#(termAdjustmentFee1)',"mfccMainAppId":'#(appId)',"isSelected":true},{"id":'#(CombCraftId2)',"appId":'#(CombCraftAppId2)',"mainAppId":'#(appId)',"licId":'#(CombCraftlicId2)',"licenseId":'#(CombCraftLicenseId2)',"licPermitTypeId":'#(CombCraftLicPermitTypeId2)',"licenseDescription":'#(CombCraftLicDes2)',"expiryDate":'#(CombCraftExpiryDate1)',"licensePermitStatus":"Active","licenseFee":'#(CombCraftlicenseFee2)',"newExpiryDate":'#(conversionDate)',"oldExpiryDate":'#(CombCrafttermoldExpiryDate2)',"amountDue":'#(CombCraftAmountDue2)',"newLicPermitTypeId":null,"oldLicPermitTypeId":null,"conversionFee":0,"termAdjustmentFee":'#(termAdjustmentFee2)',"mfccMainAppId":'#(appId)',"isSelected":true}],"newComments":"Test Automation","recommendedDecisionId":null}
      
      When method post
	  Then status 200
	  And print response
	  * match response == 'true'
	Given path '/internalapi/api/comment/Application/save'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      
      And request {"description":"Test Automation","acaId":'#(appId)',"acatype":"Application","bureau":"License","bureauId":1}
     
	  When method post
	  Then status 200
	  And print response
	  * def createdBy = response.createdBy
	  * def createdDate = response.createdBy
	  * def acacommentId = response.acacommentId
	  * def commentId = response.commentId
	Given path '/internalapi/api/MfccCommon/CheckExaminerSubmit'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      
      And request {"appId":'#(appId)',"mfccFileDataDtos":[{"id":'#(CombCraftId1)',"appId":'#(CombCraftAppId1)',"mainAppId":'#(appId)',"licId":'#(CombCraftlicId1)',"licenseId":'#(CombCraftLicenseId1)',"licPermitTypeId":'#(CombCraftLicPermitTypeId1)',"licenseDescription":'#(CombCraftLicDes1)',"expiryDate":'#(CombCraftExpiryDate1)',"licensePermitStatus":"Active","licenseFee":'#(CombCraftlicenseFee1)',"newExpiryDate":'#(conversionDate)',"oldExpiryDate":'#(CombCrafttermoldExpiryDate1)',"amountDue":'#(CombCraftAmountDue1)',"newLicPermitTypeId":null,"oldLicPermitTypeId":null,"conversionFee":0,"termAdjustmentFee":'#(termAdjustmentFee1)',"mfccMainAppId":'#(appId)',"isSelected":true},{"id":'#(CombCraftId2)',"appId":'#(CombCraftAppId2)',"mainAppId":'#(appId)',"licId":'#(CombCraftlicId2)',"licenseId":'#(CombCraftLicenseId2)',"licPermitTypeId":'#(CombCraftLicPermitTypeId2)',"licenseDescription":'#(CombCraftLicDes2)',"expiryDate":'#(CombCraftExpiryDate2)',"licensePermitStatus":"Active","licenseFee":'#(CombCraftlicenseFee2)',"newExpiryDate":'#(conversionDate)',"oldExpiryDate":'#(CombCrafttermoldExpiryDate2)',"amountDue":'#(CombCraftAmountDue2)',"newLicPermitTypeId":null,"oldLicPermitTypeId":null,"conversionFee":0,"termAdjustmentFee":'#(termAdjustmentFee1)',"mfccMainAppId":'#(appId)',"isSelected":true}]}
	      
	   
	           
	  When method post
	  Then status 200
	  And print response
	  * match response.validationMessage == 'Submitted Successfully'	
	  
	    
	 
	  
	  
@ApproveCCLicenseFromLB
Scenario: ApproveCCLicenseFromLB 
	Given path '/internalapi/api/comment/Application/save'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      
      And request {"description":"Test Automation","acaId":'#(appId)',"acatype":"Application","bureau":"License","bureauId":1}
     
	  When method post
	  Then status 200
	  And print response
	  * def createdBy = response.createdBy
	  * def createdDate = response.createdBy
	  * def acacommentId = response.acacommentId
	  * def commentId = response.commentId
	  
	 
	 Given path '/internalapi/api/licensing/new-license/saveDecision'
  	  And header Content-Type = 'application/json'
      And header Accept = 'application/json'
      And header authorization = 'Bearer ' + strToken
      
      And request {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"isChainRestaurant":false,"appId":'#(appId)',"applicationType":1,"applicationId":'#(ApplicationId)',"legalName":null,"statusId":3,"decisionType":{"name":"Approved","value":1},"emailNotificationModel":{"applicant":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}},"hasErrors":[],"licPermitTypeId":'#(licensePermitTypeId)',"taskId":1151,"combinedCraftAndMasterFileGrandTotal":0,"mfccFileDataDtos":[{"id":'#(CombCraftId1)',"appId":'#(CombCraftAppId1)',"mainAppId":'#(appId)',"licId":'#(CombCraftlicId1)',"licenseId":'#(CombCraftLicenseId1)',"licPermitTypeId":'#(CombCraftLicPermitTypeId1)',"licenseDescription":'#(CombCraftLicDes1)',"expiryDate":'#(CombCraftExpiryDate1)',"licensePermitStatus":"Active","licenseFee":'#(CombCraftlicenseFee1)',"newExpiryDate":'#(conversionDate)',"oldExpiryDate":"2022-09-12T22:30:00.000Z","amountDue":null,"newLicPermitTypeId":null,"oldLicPermitTypeId":null,"conversionFee":0,"termAdjustmentFee":0,"mfccMainAppId":'#(appId)',"isSelected":true},{"id":'#(CombCraftId2)',"appId":'#(CombCraftAppId2)',"mainAppId":'#(appId)',"licId":'#(CombCraftlicId2)',"licenseId":'#(CombCraftLicenseId2)',"licPermitTypeId":'#(CombCraftLicPermitTypeId2)',"licenseDescription":'#(CombCraftLicDes2)',"expiryDate":'#(CombCraftExpiryDate2)',"licensePermitStatus":"Active","licenseFee":'#(CombCraftlicenseFee2)',"newExpiryDate":'#(conversionDate)',"oldExpiryDate":"2022-08-31T04:00:00.000Z","amountDue":0,"newLicPermitTypeId":null,"oldLicPermitTypeId":null,"conversionFee":0,"termAdjustmentFee":0,"mfccMainAppId":'#(appId)',"isSelected":true}],"newComments":"Test  Approved Automation","approval":{"isDefineStipulations":false,"selectInput":{"fromFields":[{"id":1,"label":"Inside of premises closes at x"},{"id":2,"label":"Side walk café closes at x"},{"id":3,"label":"Backyard closes at x"},{"id":4,"label":"Alcohol consumption inside stops at X"},{"id":5,"label":"Alcohol consumption in backyard stops at x"},{"id":6,"label":"Alcohol consumption on sidewalk café stops at x"},{"id":7,"label":"No live music in inside of premises"},{"id":8,"label":"No live music outside of premise"},{"id":9,"label":"No DJs"},{"id":10,"label":"No promoters"},{"id":11,"label":"No Promoted events"},{"id":12,"label":"Recorded music only"},{"id":13,"label":"Music stops at X"},{"id":14,"label":"Music outside stops at X"},{"id":15,"label":"Only non-amplified music"},{"id":16,"label":"Acoustic music only"},{"id":17,"label":"No bar crawls"},{"id":18,"label":"Close façade doors at certain time"},{"id":19,"label":"Close Windows at a certain time"},{"id":20,"label":"No boozy brunches"},{"id":21,"label":"No unlimited drink"},{"id":22,"label":"No happy Hours"},{"id":23,"label":"No bottle service "},{"id":24,"label":"No dancing"},{"id":25,"label":"No delivery bikes"},{"id":26,"label":"No TVs"},{"id":27,"label":"Licensed patio"},{"id":28,"label":"Licensed sidewalk café"},{"id":29,"label":"No outside areas"},{"id":30,"label":"Security Guards required"},{"id":31,"label":"X amount of security guards per x amount of patrons"},{"id":32,"label":"# of security guards per patron"},{"id":33,"label":"No VIP"},{"id":34,"label":"No roped lines"},{"id":35,"label":"No hookah"},{"id":36,"label":"Doors closed at all times"},{"id":37,"label":"Windows closed at all time"},{"id":38,"label":"All agreed upon CB stipulations except"},{"id":39,"label":"All employees must be TIPS trained"},{"id":40,"label":"ABC"}],"toFields":[],"isRewritable":true,"rewriteLabel":"Edit Stipulation:","additionalComments":"","srclabel":"Select Stipulations","dstlabel":"Add to Certificate","additionalLabel":"Add Additional Stipulations:"},"effectiveDate":"2022-06-22","expirationDate":"2022-06-22","stipulations":[],"descriptions":[]}}
      When method post
      Then status 200
	  And print response  
	  * match response = 'true'
	 Given path '/internalapi/api/licensing/LBDecision/getApprovalInfoByAppId'+appId
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request ""
      When method get
	  Then status 200
	  And print response
	  * def cclicensePermitId = response.licensePermitId
	  * match cclicensePermitId != []
	  * match cclicensePermitId != null

	  
@SelectUploadTextConditionsFromConditonallyApprovedLic
Scenario: SelectUploadTextConditionsFromConditonallyApprovedLic 
	* def expirationDateFunc =
		  """
		  function(days) {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd");
		    var date = new java.util.Date();
		    
		    var dayAfter = new java.util.Date(date.getTime() + java.util.concurrent.TimeUnit.DAYS.toMillis( days));
		    return sdf.format(dayAfter);
		  } 
		  """ 
  	  * def expirationDate = expirationDateFunc(90)
  	  Given path '/internalapi/api/licensing/conditionReview/getConditionsInfo/'+appId
    	* def dbSts = db.cleanHeap()
  	   And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json'
      And header current-wfroleid = '3'
      And header Accept = 'application/json'
       And request ""
	  When method get
	  Then status 200
	  And print response
	  * def appConditionId = response.conditionReview[0].appConditionId 
	  * def conditionDefinedDate = response.conditionReview[0].conditionDefinedDate 
	  * def conditionId = response.conditionReview[0].conditionId
	   * def conditionDescription = response.conditionReview[0].conditionDescription
	    * def conditionDescriptionDetail = response.conditionReview[0].conditionDescriptionDetail
	     * def responseDueDate = response.conditionReview[0].responseDueDate
	  * def taskDecision = response.conditionReview[0].taskDecision
	     * def taskId = response.conditionReview[0].taskId 
	Given path '/internalapi/api/licensing/conditionReview/saveConditionsInfo'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      * def responseDueDate = expirationDate + "T00:00:00"
      
      * def payload = ""
    * def payloadWithYesConditionMet = {"effectiveDate":'#(effectiveDate)',"expirationDate":'#(expirationDate)',"conditionReview":[{"appConditionId":'#(appConditionId)',"appId":'#(appId)',"conditionId":'#(conditionId)',"conditionDescriptionDetail":'#(conditionDescriptionDetail)',"conditionDescription":'#(conditionDescriptionDetail)',"createdBy":"tgupta@svam.com","conditionDefinedDate":'#(conditionDefinedDate)',"responseDueDate":'#(responseDueDate)',"isConditionMet":true,"responseReceived":["adding Test Response message"],"attachedDocumentIds":null,"responseReceivedJson":null,"attachDocument":null,"taskOption":null,"documents":[],"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":'#(taskId)',"taskRoleId":0,"taskDecision":'#(taskDecision)',"isActive":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},{"appConditionId":'#(appConditionId)',"appId":'#(appId)',"conditionId":-1,"conditionDescriptionDetail":"test","conditionDescription":"test","createdBy":"tgupta@svam.com","conditionDefinedDate":'#(conditionDefinedDate)',"responseDueDate":'#(responseDueDate)',"isConditionMet":true,"responseReceived":null,"attachedDocumentIds":null,"responseReceivedJson":null,"attachDocument":null,"taskOption":null,"documents":[],"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":'#(taskId)',"taskRoleId":0,"taskDecision":'#(taskDecision)',"isActive":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}],"appId":'#(appId)',"comment":"test","taskId":'#(taskId)',"taskDecision":'#(taskDecision)',"isSaveResponse":false,"isSubmit":true,"emailNotificationModel":{"applicant":{"communicationId":6712,"email":"automation@svam.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":6715,"email":"sbandi@svam.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":0,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}}}
    * def payloadWithNoConditionMet = {"effectiveDate":'#(effectiveDate)',"expirationDate":'#(expirationDate)',"conditionReview":[{"appConditionId":'#(appConditionId)',"appId":'#(appId)',"conditionId":'#(conditionId)',"conditionDescriptionDetail":'#(conditionDescriptionDetail)',"conditionDescription":'#(conditionDescriptionDetail)',"createdBy":"tgupta@svam.com","conditionDefinedDate":'#(conditionDefinedDate)',"responseDueDate":'#(responseDueDate)',"isConditionMet":false,"responseReceived":["adding Test Response message"],"attachedDocumentIds":null,"responseReceivedJson":null,"attachDocument":null,"taskOption":null,"documents":[],"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":'#(taskId)',"taskRoleId":0,"taskDecision":'#(taskDecision)',"isActive":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},{"appConditionId":'#(appConditionId)',"appId":'#(appId)',"conditionId":-1,"conditionDescriptionDetail":"test","conditionDescription":"test","createdBy":"tgupta@svam.com","conditionDefinedDate":'#(conditionDefinedDate)',"responseDueDate":'#(responseDueDate)',"isConditionMet":true,"responseReceived":null,"attachedDocumentIds":null,"responseReceivedJson":null,"attachDocument":null,"taskOption":null,"documents":[],"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":'#(taskId)',"taskRoleId":0,"taskDecision":'#(taskDecision)',"isActive":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}],"appId":'#(appId)',"comment":"test","taskId":'#(taskId)',"taskDecision":'#(taskDecision)',"isSaveResponse":false,"isSubmit":true,"emailNotificationModel":{"applicant":{"communicationId":6712,"email":"automation@svam.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":6715,"email":"sbandi@svam.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":0,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}}}
    * def payloadWithoutConditionMet = {"effectiveDate":'#(effectiveDate)',"expirationDate":'#(expirationDate)',"conditionReview":[{"appConditionId":'#(appConditionId)',"appId":'#(appId)',"conditionId":'#(conditionId)',"conditionDescriptionDetail":'#(conditionDescriptionDetail)',"conditionDescription":'#(conditionDescriptionDetail)',"createdBy":"tgupta@svam.com","conditionDefinedDate":'#(conditionDefinedDate)',"responseDueDate":'#(responseDueDate)',"isConditionMet":null,"responseReceived":["adding Test Response message"],"attachedDocumentIds":null,"responseReceivedJson":null,"attachDocument":null,"taskOption":null,"documents":[],"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":'#(taskId)',"taskRoleId":0,"taskDecision":'#(taskDecision)',"isActive":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}],"appId":'#(appId)',"comment":"Test","taskId":'#(taskId)',"taskDecision":'#(taskDecision)',"isSaveResponse":false,"isSubmit":true,"emailNotificationModel":{"applicant":{"communicationId":6704,"email":"automation@svam.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":6707,"email":"sbandi@svam.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":0,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}}}
    
    * eval if (isConditionMet == true) payload = payloadWithYesConditionMet
    * eval if (isConditionMet == false) payload = payloadWithNoConditionMet
    * eval if (isConditionMet == null) payload = payloadWithoutConditionMet
    And request payload  
                                
      When method post
	  Then status 200
	  And print response
	  * match response == 'true'
	  

@SelectNullConditonMetUploadTextConditionsFromConditonallyApprovedLic
Scenario: SelectNullConditonMetUploadTextConditionsFromConditonallyApprovedLic 
	* def expirationDateFunc =
		  """
		  function(days) {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd");
		    var date = new java.util.Date();
		    
		    var dayAfter = new java.util.Date(date.getTime() + java.util.concurrent.TimeUnit.DAYS.toMillis( days));
		    return sdf.format(dayAfter);
		  } 
		  """ 
  	  * def expirationDate = expirationDateFunc(90)
  	  Given path '/internalapi/api/licensing/conditionReview/getConditionsInfo/'+appId
    	* def dbSts = db.cleanHeap()
  	   And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json'
      And header current-wfroleid = '3'
      And header Accept = 'application/json'
       And request ""
	  When method get
	  Then status 200
	  And print response
	  * def appConditionId = response.conditionReview[0].appConditionId 
	  * def conditionDefinedDate = response.conditionReview[0].conditionDefinedDate 
	  * def conditionId = response.conditionReview[0].conditionId
	   * def conditionDescription = response.conditionReview[0].conditionDescription
	    * def conditionDescriptionDetail = response.conditionReview[0].conditionDescriptionDetail
	     * def responseDueDate = response.conditionReview[0].responseDueDate
	  * def taskDecision = response.conditionReview[0].taskDecision
	     * def taskId = response.conditionReview[0].taskId 
	Given path '/internalapi/api/licensing/conditionReview/saveConditionsInfo'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      * def responseDueDate = expirationDate + "T00:00:00"
      
      * def payload = {"effectiveDate":'#(effectiveDate)',"expirationDate":'#(expirationDate)',"conditionReview":[{"appConditionId":'#(appConditionId)',"appId":'#(appId)',"conditionId":'#(conditionId)',"conditionDescriptionDetail":'#(conditionDescriptionDetail)',"conditionDescription":'#(conditionDescriptionDetail)',"createdBy":"tgupta@svam.com","conditionDefinedDate":'#(conditionDefinedDate)',"responseDueDate":'#(responseDueDate)',"isConditionMet":null,"responseReceived":["Add Text Response Automation"],"attachedDocumentIds":null,"responseReceivedJson":null,"attachDocument":null,"taskOption":null,"documents":[],"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":'#(taskId)',"taskRoleId":0,"taskDecision":'#(taskDecision)',"isActive":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}],"appId":'#(appId)',"comment":"","taskId":'#(taskId)',"taskDecision":'#(taskDecision)',"isSaveResponse":true,"isSubmit":false,"emailNotificationModel":{"applicant":{"communicationId":7913,"email":"automation@svam.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":7916,"email":"sbandi@svam.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}}}
    	And request payload  
      When method post
	  Then status 200
	  And print response
	  * match response == 'true'
	  Given path '/internalapi/api/licensing/conditionReview/saveConditionsInfo'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      * def payload =  {"effectiveDate":'#(effectiveDate)',"expirationDate":'#(expirationDate)',"conditionReview":[{"appConditionId":'#(appConditionId)',"appId":'#(appId)',"conditionId":'#(conditionId)',"conditionDescriptionDetail":'#(conditionDescriptionDetail)',"conditionDescription":'#(conditionDescriptionDetail)',"createdBy":"tgupta@svam.com","conditionDefinedDate":'#(conditionDefinedDate)',"responseDueDate":'#(responseDueDate)',"isConditionMet":null,"responseReceived":["Add Text Response Automation"],"attachedDocumentIds":null,"responseReceivedJson":null,"attachDocument":null,"taskOption":null,"documents":[],"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":'#(taskId)',"taskRoleId":0,"taskDecision":'#(taskDecision)',"isActive":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}],"appId":'#(appId)',"comment":"Automation Test","taskId":'#(taskId)',"taskDecision":'#(taskDecision)',"isSaveResponse":false,"isSubmit":true,"emailNotificationModel":{"applicant":{"communicationId":7913,"email":"automation@svam.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":7916,"email":"sbandi@svam.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}}}
    
     And request payload  
                                
      When method post
	  Then status 200
	  And print response
	  * match response == 'true'
	  	  
@getAndValidateApprovalInfoByAppId
Scenario: getAndValidateApprovalInfoByAppId	  
	  Given path '/internalapi/api/licensing/LBDecision/getApprovalInfoByAppId/'+appId
    
  	   And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json'
      And header current-wfroleid = '3'
    And header Accept = 'application/json'
     And request ""
	  When method get
	  Then status 200
	  And print response
	     * match response.licType == 'NA'
	  * match response.licensePermitId != []
	   * match response.licensePermitId != null
	  
@UploadDocument
Scenario: UploadDocument
 Given path '/internalapi/api/licensing/conditionReview/getConditionsInfo/'+appId
    	* def dbSts = db.cleanHeap()
  	   And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json'
      And header current-wfroleid = '3'
      And header Accept = 'application/json'
       And request ""
	  When method get
	  Then status 200
	  And print response
	  * def appConditionId = response.conditionReview[0].appConditionId 
	  * def conditionDefinedDate = response.conditionReview[0].conditionDefinedDate 
	  * def conditionId = response.conditionReview[0].conditionId
	   * def conditionDescription = response.conditionReview[0].conditionDescription
	    * def conditionDescriptionDetail = response.conditionReview[0].conditionDescriptionDetail
	     * def responseDueDate = response.conditionReview[0].responseDueDate
	  * def taskDecision = response.conditionReview[0].taskDecision
	     * def taskId = response.conditionReview[0].taskId 	
	     
	     * def receivedDateFunc =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy/MM/dd");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		  """ 
  	  * def receivedDate = receivedDateFunc()
  	  
	Given path '/internalapi/api/document/UploadDocument'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      
      And request {"documentDesc":"TestDocument.docx","acaId":'#(appConditionId)',"acaType":"ConditionalReview","bureau":"","documentType":{"key":1,"value":"20 DAY NOTICE","description":null,"documentSubCategory":"20 DAY"},"documentCategory":null,"receivedDate":'#(receivedDate)',"createdDate":'#(date)',"documentBase64":"data:application/vnd.openxmlformats-officedocument.wordprocessingml.document;base64,UEsDBBQABgAIAAAAIQDupm+0lQEAACkHAAATAM0BW0NvbnRlbnRfVHlwZXNdLnhtbCCiyQEooAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAvJVNS8NAEIbvgv8h7FWarQoi0tSDH0cVrOB13Uzaxf1iZ9raf+8k2ihaW2mql0CyO+/77LszZHD+4mw2g4Qm+EIc5n2RgdehNH5ciIfRde9UZEjKl8oGD4VYAIrz4f7eYLSIgBlXeyzEhCieSYl6Ak5hHiJ4XqlCcor4NY1lVPpZjUEe9fsnUgdP4KlHtYYYDi6hUlNL2dULf34jSWBRZBdvG2uvQqgYrdGKmFTOfPnFpffukHNlswcnJuIBYwi50qFe+dngve6Wo0mmhOxOJbpRjjHkPKRSlkFPHZ8hXy+zgjNUldHQ1tdqMQUNiJy5s3m74pTxS/4fOYgTB9k8DzuzNDIbLRGIGBU72307+lJ5I0LFfTFSTxZ2z9BKb4SYw9P9n0XxSXwdCDfLXQoRJQ9H5yygHr8Syh73Y4REBtr5WdV/rbcOaYuLWM5rXf1Lx2bykBYW/qL5Gt11YespUnCPzkpD4JrcjzqH3orWeptDb7d/MHSf+1Z0a4bj/87ho/maS9mR/Yo+lM2PbvgKAAD//wMAUEsDBBQABgAIAAAAIQCZVX4FBAEAAOECAAALAPMBX3JlbHMvLnJlbHMgou8BKKAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAArJLPSsNAEMbvgu+wzL2ZtIqINOlFhN5E4gMMu9MkmP3D7lTbt3ctiAZq0oPHnfnmm9987HpzsIN655h67ypYFiUodtqb3rUVvDZPi3tQScgZGrzjCo6cYFNfX61feCDJQ6nrQ1LZxaUKOpHwgJh0x5ZS4QO73Nn5aEnyM7YYSL9Ry7gqyzuMvz2gHnmqrakgbs0NqOYY8uZ5b7/b9Zofvd5bdnJmBfJB2Bk2ixAzW5Q+X6Maii1LBcbr51xOSCEUGRvwPNHqcqK/r0XLQoaEUPvI0zxfiimg5eVA8xGNFT/pfPhoMEd0ynaK5vY/afQ+ibcz8Zw030g4+pj1JwAAAP//AwBQSwMEFAAGAAgAAAAhAHalU6wiAQAA2wQAABwA2gB3b3JkL19yZWxzL2RvY3VtZW50LnhtbC5yZWxzIKLWACigAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACslMtqwzAQRfeF/oPRvpbttGkpkbMphWxbF7pV5PGD6mGkSVv/fUUgsUODkoU2ghmhew9XI63Wv0om32BdbzQjeZqRBLQwda9bRj6q17snkjjkuubSaGBkBEfW5e3N6g0kR3/Idf3gEq+iHSMd4vBMqRMdKO5SM4D2O42xiqMvbUsHLr54C7TIsiW1cw1Snmgmm5oRu6m9fzUO3vmytmmaXsCLETsFGs9YULFzaNSnkl6U2xaQkTSdurRHUIvUIxN6nmYRk+YHtu+A6KN2E8+sGQJ5jAlyTSxFiKaISeP+ZXLohBDyqAg4Sj/oxyFx+zpkv4xpf8195CGah5g06B8zTFnsS7pfgwz3MRkao7HiWznjOLYOQdCTL6n8AwAA//8DAFBLAwQUAAYACAAAACEAb0UNhycCAABNBgAAEQAAAHdvcmQvZG9jdW1lbnQueG1spJVNb9swDIbvA/YfDN0T22nadUacokvWoIcBRdOdB0WWbSGWKEhysuzXj/JHnH2gSJuLLYriw5eiJc/ufsoq2HFjBaiUxOOIBFwxyIQqUvL95WF0SwLrqMpoBYqn5MAtuZt//DDbJxmwWnLlAkQom+w1S0npnE7C0LKSS2rHUjADFnI3ZiBDyHPBeLgHk4WTKI6akTbAuLWYb0HVjlrS4eS/NNBcoTMHI6lD0xShpGZb6xHSNXViIyrhDsiObnoMpKQ2KukQo6MgH5K0grpXH2HOyduGLLsdaDKGhleoAZQthR7KeC8NnWUP2b1WxE5W/bq9jqeX9WBp6B5fA/Ac+VkbJKtW+evEODqjIx5xjDhHwp85eyWSCjUkftfWnGxufP02wORvgC4ua87KQK0HmriM9qi2R5Y/2W9gdU0+Lc1eJmZdUo0nULLksVBg6KZCRdiyAHc98J81meONs4Hs4N862Cd4Y2XPKYmi+yhaRFekn1rynNaV857Fw/Tz4r6JNP7h5i/culnoR/7ZTG4Atv4WWTtqHEJEhqGepqhEDT9W8IWyLQlP135V2XFl2KC0d1vO3JP5j7ZGc7H+hS78muPJZNpkKHF8fTttGH7BN+qDHeChi6ftEiOK0g3mBpwDOdgVz0+8JacZx+vr06QxcwB3Yha1a8wuHYPK4qzVlPF2TTONl/rKCF9eJRR/Eo6hyqubvs62xGbYNiMc/gPz3wAAAP//AwBQSwMEFAAGAAgAAAAhAKpSJd8jBgAAixoAABUAAAB3b3JkL3RoZW1lL3RoZW1lMS54bWzsWU2LGzcYvhf6H8TcHX/N+GOJN9hjO2mzm4TsJiVHeUaeUawZGUneXRMCJTkWCqVp6aGB3noobQMJ9JL+mm1T2hTyF6rReGzJllnabGApWcNaH8/76tH7So80nstXThICjhDjmKYdp3qp4gCUBjTEadRx7hwOSy0HcAHTEBKaoo4zR9y5svvhB5fhjohRgoC0T/kO7DixENOdcpkHshnyS3SKUtk3piyBQlZZVA4ZPJZ+E1KuVSqNcgJx6oAUJtLtzfEYBwgcZi6d3cL5gMh/qeBZQ0DYQeYaGRYKG06q2Refc58wcARJx5HjhPT4EJ0IBxDIhezoOBX155R3L5eXRkRssdXshupvYbcwCCc1Zcei0dLQdT230V36VwAiNnGD5qAxaCz9KQAMAjnTnIuO9XrtXt9bYDVQXrT47jf79aqB1/zXN/BdL/sYeAXKi+4Gfjj0VzHUQHnRs8SkWfNdA69AebGxgW9Wun23aeAVKCY4nWygK16j7hezXULGlFyzwtueO2zWFvAVqqytrtw+FdvWWgLvUzaUAJVcKHAKxHyKxjCQOB8SPGIY7OEolgtvClPKZXOlVhlW6vJ/9nFVSUUE7iCoWedNAd9oyvgAHjA8FR3nY+nV0SBvXv745uVzcProxemjX04fPz599LPF6hpMI93q9fdf/P30U/DX8+9eP/nKjuc6/vefPvvt1y/tQKEDX3397I8Xz1598/mfPzyxwLsMjnT4IU4QBzfQMbhNEzkxywBoxP6dxWEMsW7RTSMOU5jZWNADERvoG3NIoAXXQ2YE7zIpEzbg1dl9g/BBzGYCW4DX48QA7lNKepRZ53Q9G0uPwiyN7IOzmY67DeGRbWx/Lb+D2VSud2xz6cfIoHmLyJTDCKVIgKyPThCymN3D2IjrPg4Y5XQswD0MehBbQ3KIR8ZqWhldw4nMy9xGUObbiM3+XdCjxOa+j45MpNwVkNhcImKE8SqcCZhYGcOE6Mg9KGIbyYM5C4yAcyEzHSFCwSBEnNtsbrK5Qfe6lBd72vfJPDGRTOCJDbkHKdWRfTrxY5hMrZxxGuvYj/hELlEIblFhJUHNHZLVZR5gujXddzEy0n323r4jldW+QLKeGbNtCUTN/TgnY4iU8/Kanic4PVPc12Tde7eyLoX01bdP7bp7IQW9y7B1R63L+Dbcunj7lIX44mt3H87SW0huFwv0vXS/l+7/vXRv28/nL9grjVaX+OKqrtwkW+/tY0zIgZgTtMeVunM5vXAoG1VFGS0fE6axLC6GM3ARg6oMGBWfYBEfxHAqh6mqESK+cB1xMKVcng+q2eo76yCzZJ+GeWu1WjyZSgMoVu3yfCna5Wkk8tZGc/UItnSvapF6VC4IZLb/hoQ2mEmibiHRLBrPIKFmdi4s2hYWrcz9Vhbqa5EVuf8AzH7U8NyckVxvkKAwy1NuX2T33DO9LZjmtGuW6bUzrueTaYOEttxMEtoyjGGI1pvPOdftVUoNelkoNmk0W+8i15mIrGkDSc0aOJZ7ru5JNwGcdpyxvBnKYjKV/nimm5BEaccJxCLQ/0VZpoyLPuRxDlNd+fwTLBADBCdyretpIOmKW7XWzOZ4Qcm1KxcvcupLTzIaj1EgtrSsqrIvd2LtfUtwVqEzSfogDo/BiMzYbSgD5TWrWQBDzMUymiFm2uJeRXFNrhZb0fjFbLVFIZnGcHGi6GKew1V5SUebh2K6PiuzvpjMKMqS9Nan7tlGWYcmmlsOkOzUtOvHuzvkNVYr3TdY5dK9rnXtQuu2nRJvfyBo1FaDGdQyxhZqq1aT2jleCLThlktz2xlx3qfB+qrNDojiXqlqG68m6Oi+XPl9eV2dEcEVVXQinxH84kflXAlUa6EuJwLMGO44Dype1/Vrnl+qtLxBya27lVLL69ZLXc+rVwdetdLv1R7KoIg4qXr52EP5PEPmizcvqn3j7UtSXLMvBTQpU3UPLitj9falWtv+9gVgGZkHjdqwXW/3GqV2vTssuf1eq9T2G71Sv+E3+8O+77Xaw4cOOFJgt1v33cagVWpUfb/kNioZ/Va71HRrta7b7LYGbvfhItZy5sV3EV7Fa/cfAAAA//8DAFBLAwQUAAYACAAAACEABWtlBKYDAACtCQAAEQAAAHdvcmQvc2V0dGluZ3MueG1stFbbbts4EH0vsP9g6HkVS/KlqVCncO11myLeLir3AyiRsonwBpKy4hb99w4pMXLSReHdok8m58yNM2dGfv3mgbPRkWhDpVhE6VUSjYioJKZiv4g+7zbxdTQyFgmMmBRkEZ2Iid7c/PHidZsbYi2omRG4ECbn1SI6WKvy8dhUB8KRuZKKCABrqTmycNX7MUf6vlFxJblClpaUUXsaZ0kyj3o3chE1WuS9i5jTSksja+tMclnXtCL9T7DQl8TtTNayajgR1kcca8IgBynMgSoTvPH/6w3AQ3By/NkjjpwFvTZNLnhuKzV+tLgkPWegtKyIMdAgzkKCVAyBpz84eox9BbH7J3pXYJ4m/nSe+ey/OcieOTDskpd00B0tNdIdT/pn8Cq/3QupUcmAlfCcEWQU3QAtv0jJR22uiK6gN8DpJInGDoCKyLqwyBKAjSKMeZJXjCBw2OZ7jTjQM0i8DSY1apjdobKwUoHSEUHeL7PeZXVAGlWW6EKhCrytpLBasqCH5d/SroDqGjrRW3jiD6eiGyKwEIjDS54MxlZi4jJrNL282M7AR4d6nIV8HkjC0GuKyc5VsLAnRjaQfEG/kKXAHxpjKXj04/ELGfwsASJc5I/Q891JkQ1BtoEy/aZgvhMbRtWWai31rcDAjd8WjNY10RCAAte2QB+qZevr/J4gDLv2F+OOz2kEmxubcPgkpQ2qSbJMklUy6TJ16CXIajN9tVr2UXrfPHe77R8dTo4oI95ZrBAvNUWjrdt+Y6dR6vu3VAS8JDDO5BwpmjKAcdwBhiPGNjBJAfDjxXNMjVqT2p/ZFun94LfX0P8qhan98OjLbQGi32nZqA5tNVIdAYJKOp32llTYO8qD3DRlEawELKAzqBH441H7Og3laXMLjfSDdIc8IbwuEfHnoicM04VrNtkipTrOlPt0ETG6P9jUtdnCDcNH0l/KfdZjmceyDvMXVLmXgXZ/GGRZkJ3pTYJsMsimQTYdZLMgmw2yeZDNnewA06phdd4DfcPRyWvJmGwJfj/gP4i6IpgDUmTdbVagl+wE/ao1o2NOHmBvE0wt/PdQFHP04NZ4NnfmvTZDJ9nYJ7oOc8rqqQeMLAqD88TYU/xZLm7jVxToWJx4OSzyqy5xRg0Mu4Kdb6UO2J8eS2f+Y2B3wOJ7aOwnUr9FhuAew7K6xe4T1dl8nWz+Wl+naRIv02UaT7NsEl+/TNfxcpXOX22uJ6v5LP3WT2H4n3XzHQAA//8DAFBLAwQUAAYACAAAACEAnXtOcaoBAADtBAAAEgAAAHdvcmQvZm9udFRhYmxlLnhtbNySzWrjMBSF9wPzDkb7xrKTtB1Tp9CZBgrDLIb2ARRFti/Vj9FV4snb90p20kUoNJsuxgYhnSN9ujrcu/t/Rmd75RGcrVkx4yxTVrot2LZmL8/rq1uWYRB2K7SzqmYHhex+9f3b3VA1zgbM6LzFysiadSH0VZ6j7JQROHO9smQ2zhsRaOnb3Aj/uuuvpDO9CLABDeGQl5xfswnjP0NxTQNS/XJyZ5QN6XzulSais9hBj0fa8Bna4Py2904qRHqz0SPPCLAnTLE4AxmQ3qFrwoweM1WUUHS84Glm9DtgeRmgPAGMrJ5a67zYaAqfKskIxlZT+tlQWWHI+Ck0bDwkoxfWoSrI2wtdM17yNV/SGP8Fn8eR5XGj7IRHFSHjRj7KjTCgD0cVB0AcjR6C7I76XniIRY0WQkvGDje8Zo8LzsvH9ZqNSkHVcVIWNw+TUsa70vdjUuYnhUdFJk5aFiNHJs5pD92ZjwmcJfEMRmH2Rw3ZX2eE/SCRkl9TEkvKIyYzvygRn7gXJRLff5bIze3ySxKZeiP7DW0XPuyQ2Bf/aYdME1y9AQAA//8DAFBLAwQUAAYACAAAACEAW239kwkBAADxAQAAFAAAAHdvcmQvd2ViU2V0dGluZ3MueG1slNHBSgMxEAbgu+A7LLm32RYVWbotiFS8iKA+QJrOtsFMJsykrvXpHWutSC/1lkkyHzP8k9k7xuoNWAKl1oyGtakgeVqGtGrNy/N8cG0qKS4tXaQErdmCmNn0/GzSNz0snqAU/SmVKkka9K1Zl5Iba8WvAZ0MKUPSx44YXdGSVxYdv27ywBNmV8IixFC2dlzXV2bP8CkKdV3wcEt+g5DKrt8yRBUpyTpk+dH6U7SeeJmZPIjoPhi/PXQhHZjRxRGEwTMJdWWoy+wn2lHaPqp3J4y/wOX/gPEBQN/crxKxW0SNQCepFDNTzYByCRg+YE58w9QLsP26djFS//hwp4X9E9T0EwAA//8DAFBLAwQUAAYACAAAACEAON+1jWoBAADAAgAAEAAIAWRvY1Byb3BzL2FwcC54bWwgogQBKKAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACcUstOwzAQvCPxD1HurVMECKGtK9QKceBRqWl7tpxNYuHYlu1W7d+zadoQ4EZOO7O7o9mJYXZodLJHH5Q103QyztIEjbSFMtU0XefPo4c0CVGYQmhrcJoeMaQzfn0FS28d+qgwJCRhwjStY3SPjAVZYyPCmNqGOqX1jYgEfcVsWSqJCyt3DZrIbrLsnuEhoimwGLleMO0UH/fxv6KFla2/sMmPjvQ45Ng4LSLy93ZTA+sJyG0UOlcN8ozoHsBSVBj4BFhXwNb6IrQzXQHzWnghI0XHb4ENEDw5p5UUkSLlb0p6G2wZk4+Tz6TdBjYcAfK+QrnzKh5b/SGEV2U6F11BrryovHD12VqPYCWFxjldzUuhAwL7JmBuGycMybG+Ir3PsHa5XbQpnFd+koMTtyrWKyck/jp2wMOKWCzIfW+gJ+CF/oPXrTrtmgqLy8zfRhvfpnuQfHI3zug75XXh6Or+pfAvAAAA//8DAFBLAwQUAAYACAAAACEATYLc3nMBAADhAgAAEQD/AGRvY1Byb3BzL2NvcmUueG1sIKL7ACigAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAnFLLTsMwELwj8Q+R74mTFKEqSlLxKheKkAgCcTP2tjVNbMt2m/bvcZImbQQnJB+8O7Ozu2Ons31VejvQhkuRoSgIkQeCSsbFKkNvxdyfIs9YIhgppYAMHcCgWX55kVKVUKnhRUsF2nIwnlMSJqEqQ2trVYKxoWuoiAkcQzhwKXVFrAv1CitCN2QFOA7Da1yBJYxYghtBXw2K6CjJ6CCptrpsBRjFUEIFwhocBRE+cS3oyvxZ0CJnzIrbg3I7Hcc912a0Awf23vCBWNd1UE/aMdz8Ef5YPL22q/pcNF5RQHnKaGK5LSFP8enqbmb79Q3UdukhcADVQKzU+c3jw3PRFvWZxusNHGqpmXF1o8gVMjBUc2XdC3aqo4Rjl8TYhXvSJQd2e+gb/AaaPhp2vPkLedw2GkK3T2tfNyYwzxmSdPb1yPvk7r6YozwO48gPY3eKcJpcTZMw/Gz2GdU3BnWJ6jjZvxV7gc6a8afMfwAAAP//AwBQSwMEFAAGAAgAAAAhAAtGahAbCwAABHAAAA8AAAB3b3JkL3N0eWxlcy54bWy8nV1z27oRhu870//A0VV7kcjyZ+I5zhnbiWtP4xyfyGmuIRKyUIOEyo/Y7q8vAFIS5CUoLrj1lS1R+wDEuy+I5Yf02+/PqYx+8bwQKjsbTd7vjSKexSoR2cPZ6Mf91bsPo6goWZYwqTJ+Nnrhxej3T3/9y29Pp0X5InkRaUBWnKbx2WhRlsvT8biIFzxlxXu15JneOFd5ykr9Mn8Ypyx/rJbvYpUuWSlmQoryZby/t3c8ajB5H4qaz0XMP6u4SnlW2vhxzqUmqqxYiGWxoj31oT2pPFnmKuZFoXc6lTUvZSJbYyaHAJSKOFeFmpfv9c40PbIoHT7Zs/+lcgM4wgH214A0Pr15yFTOZlKPvu5JpGGjT3r4ExV/5nNWybIwL/O7vHnZvLJ/rlRWFtHTKStiIe51yxqSCs27Ps8KMdJbOCvK80Kw1o0L80/rlrgonbcvRCJGY9Ni8V+98ReTZ6P9/dU7l6YHW+9Jlj2s3uPZux9TtyfOWzPNPRux/N303ASOmx2r/zq7u3z9yja8ZLGw7bB5yXVmTY73DFQKk8j7Rx9XL75XZmxZVaqmEQuo/66xYzDiOuF0+k1rF+itfP5VxY88mZZ6w9nItqXf/HFzlwuV60w/G320beo3pzwV1yJJeOZ8MFuIhP9c8OxHwZPN+39e2Wxt3ohVlen/D04mNgtkkXx5jvnS5L7emjGjyTcTIM2nK7Fp3Ib/ZwWbNEq0xS84MxNANHmNsN1HIfZNROHsbTuzerXv9lOohg7eqqHDt2ro6K0aOn6rhk7eqqEPb9WQxfw/GxJZwp9rI8JmAHUXx+NGNMdjNjTH4yU0x2MVNMfjBDTHk+hojieP0RxPmiI4pYp9Wegk+4En27u5u48RYdzdh4Qw7u4jQBh394Qfxt09v4dxd0/nYdzds3cYd/dkjefWS63oRtssKwe7bK5UmamSRyV/Hk5jmWbZqoiGZw56PCfZSQJMPbM1B+LBtJjZ17szxJo0/HhemkIuUvNoLh6qXBfTQzvOs19c6rI2YkmieYTAnJdV7hmRkJzO+ZznPIs5ZWLTQU0lGGVVOiPIzSV7IGPxLCEevhWRZFJYJ7SunxfGJIIgqVMW52p41xQjmx++imL4WBlIdFFJyYlY32hSzLKG1wYWM7w0sJjhlYHFDC8MHM2ohqihEY1UQyMasIZGNG51flKNW0MjGreGRjRuDW34uN2LUtop3l11TPqfu7uUypzHHtyPqXjImF4ADD/cNOdMozuWs4ecLReROSvdjnX3GdvOhUpeonuKY9qaRLWutylyqfdaZNXwAd2iUZlrzSOy15pHZLA1b7jFbvUy2SzQrmnqmWk1K1tNa0m9TDtlsqoXtMPdxsrhGbYxwJXICzIbtGMJMvibWc4aOSlmvk0vh3dswxpuq9ezEmn3GiRBL6WKH2mm4euXJc91WfY4mHSlpFRPPKEjTstc1bnmWn7fStLL8l/S5YIVwtZKW4j+h/rVFfDoli0H79CdZCKj0e3Lu5QJGdGtIK7vb79G92ppykwzMDTAC1WWKiVjNmcC//aTz/5O08FzXQRnL0R7e050esjCLgXBQaYmqYSIpJeZIhMkx1DL+yd/mSmWJzS0u5zXN52UnIg4ZemyXnQQeEvPi096/iFYDVnev1guzHkhKlPdk8Cc04ZFNfs3j4dPdd9URHJm6I+qtOcf7VLXRtPhhi8TtnDDlwhWTX14MPlLsLNbuOE7u4Wj2tlLyYpCeC+hBvOodnfFo97f4cVfw1NS5fNK0g3gCkg2gisg2RAqWaVZQbnHlke4w5ZHvb+EKWN5BKfkLO8fuUjIxLAwKiUsjEoGC6PSwMJIBRh+h44DG36bjgMbfq9ODSNaAjgwqjwjPfwTXeVxYFR5ZmFUeWZhVHlmYVR5dvA54vO5XgTTHWIcJFXOOUi6A01W8nSpcpa/ECG/SP7ACE6Q1rS7XM3N0wgqq2/iJkCac9SScLFd46hE/slnZF0zLMp+EZwRZVIqRXRubXPAsZHb967tCrNPcgzuwp1kMV8omfDcs0/+WF0vT+vHMl5333aj12nPr+JhUUbTxfpsv4s53tsZuSrYt8J2N9g25ser51nawm55Iqp01VH4MMXxQf9gm9FbwYe7gzcria3Io56RsM3j3ZGbVfJW5EnPSNjmh56R1qdbkV1++Mzyx9ZEOOnKn3WN50m+k64sWge3NtuVSOvIthQ86cqiLatE53FsrhZAdfp5xh/fzzz+eIyL/BSMnfyU3r7yI7oM9p3/EubIjpk0bXvruyfAvG8X0b1mzj8rVZ+337rg1P+hrhu9cMoKHrVyDvpfuNqaZfzj2Hu68SN6zzt+RO8JyI/oNRN5w1FTkp/Se27yI3pPUn4EeraCRwTcbAXjcbMVjA+ZrSAlZLYasArwI3ovB/wItFEhAm3UASsFPwJlVBAeZFRIQRsVItBGhQi0UeECDGdUGI8zKowPMSqkhBgVUtBGhQi0USECbVSIQBsVItBGDVzbe8ODjAopaKNCBNqoEIE2ql0vDjAqjMcZFcaHGBVSQowKKWijQgTaqBCBNipEoI0KEWijQgTKqCA8yKiQgjYqRKCNChFoo9aPGoYbFcbjjArjQ4wKKSFGhRS0USECbVSIQBsVItBGhQi0USECZVQQHmRUSEEbFSLQRoUItFHtxcIBRoXxOKPC+BCjQkqIUSEFbVSIQBsVItBGhQi0USECbVSIQBkVhAcZFVLQRoUItFEhois/m0uUvtvsJ/iznt479vtfumo69d19lNtFHfRHrXrlZ/V/FuFCqceo9cHDA1tv9IOImRTKnqL2XFZ3ufaWCNSFzz8uu5/wcekDv3SpeRbCXjMF8MO+keCcymFXyruRoMg77Mp0NxKsOg+7Zl83EhwGD7smXevL1U0p+nAEgrumGSd44gnvmq2dcDjEXXO0EwhHuGtmdgLhAHfNx07gUWQm59fRRz3H6Xh9fykgdKWjQzjxE7rSEmq1mo6hMfqK5if0Vc9P6Cujn4DS04vBC+tHoRX2o8KkhjbDSh1uVD8BKzUkBEkNMOFSQ1Sw1BAVJjWcGLFSQwJW6vDJ2U8IkhpgwqWGqGCpISpMangow0oNCVipIQEr9cADshcTLjVEBUsNUWFSw8UdVmpIwEoNCVipISFIaoAJlxqigqWGqDCpQZWMlhoSsFJDAlZqSAiSGmDCpYaoYKkhqktqexZlS2qUwk44bhHmBOIOyE4gbnJ2AgOqJSc6sFpyCIHVEtRqpTmuWnJF8xP6qucn9JXRT0Dp6cXghfWj0Ar7UWFS46qlNqnDjeonYKXGVUteqXHVUqfUuGqpU2pcteSXGlcttUmNq5bapA6fnP2EIKlx1VKn1LhqqVNqXLXklxpXLbVJjauW2qTGVUttUg88IHsx4VLjqqVOqXHVkl9qXLXUJjWuWmqTGlcttUmNq5a8UuOqpU6pcdVSp9S4askvNa5aapMaVy21SY2rltqkxlVLXqlx1VKn1LhqqVNqT7U0ftr6ASbDtj9Ipj9cviy5+Q5u54GZpP4O0uYioP3gTbL+oSQTbHoSNT9J1bxtO9xcMKxbtIGwqXih24qbb0/yNNV8C+r6MR77HaivG/Z8VartyGYIVp9uhnRzKbT+3NZlz85+l2bIO/psJekco1o1Xwc/Nmm4q4e6PzNZ/2iX/ucmSzTgqfnBqrqnyTOrUXr7JZfyltWfVkv/RyWfl/XWyZ59aP7V9ln9/W/e+NxOFF7AeLsz9cvmh8M8411/I3xzBdubksYNLcNtb6cYOtKbvq3+Kz79DwAA//8DAFBLAwQUAAYACAAAACEASnSMYcoIAAD3LgAAEwAoAGN1c3RvbVhtbC9pdGVtMS54bWwgoiQAKKAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA7Frdk5s4En/fqv0fKO7Zxjb2+KPibE3Gyd3UZZLUjnfv3rZkSdhcMDggZjz//bUQEkIYG7CvbuvqkocErG51/9Tf4t0vx31gvdA48aNwaQ/7A9uiIY6IH26Xdsq83sz+5f07zBY4ChkN2frtQJ/xju6RBS//WNq2tUfqX23RF7SnS3sV4XQPZNkq7dfH1dIeHAdD+Du4m07md58+Pkznk/FgOHZn89Wn6YepOxu47sP9amLS/q6kHZo/rWiCY//AMmUeYooYtZAV0leL5IL0TZJnHB1A0Ox1jgMXbnrn0cFgM/fohHojd4gRJUN3gscuHbnuDNsWABcmC8yW9o6xw8JxkgyWpL/3cRwlkcf6ONo7kef5mDoj0NPZU4YIYsjRkJCM9qgLo0MM0sfMp0nG/J6x2N+kjCb2+59/endMyEJIZTEUbynjh5IcEAaF2wtd7JWBFUcR6M7ilGaPnk8DknDovDly8WwzmIwJ3nh3YzydwrkOp/iOTudkBIcWJiNhMmHiiv8IMEFeJdjr62v/1e1H8ZZjN3T++fRZ2J0E7Jg0X3tQS1sckq6vkA/kBsuYzt3RaDPpjQjZ9MabKeqh0d1dD88H2J2guwkZgIqSwAU8xuMxxWjSG5DJrDd2B6g3G4+GPW8yG8znQzwCWNRx+ftDFDMrLA6q0X6OPO4qfaPtFT0NKPfXTIClrUEgNwCbPgT0yOOAfJXQHykEDfVc5iE97wmFaJsxV8qe4IWCQLKVbGLqLW1uMk+U+OiZxi/gUE+5K4Ht+eFXjNMYzGFgV/Q4SfwJJawlA3fxvEMxJf/w2e63BCJQw411uhXI7AdNKcv63qcsWqNtN+KvD782FLe86V9pSGPEo+na33M3bw/1xxewpr+hZPcQkW4cuOZ/p2/fIj9k3dS/jnoFSWSNvtPwlP4OD7G5zWb/N0w6e5cbMrfr7Fn3l+ZEWXaRvlEX1RsFCysX6FMU71fUQ2kAgfxHigIfgjiRses/FozJvojcl8NxNXw4DGIPWIIIsQfcLLb7oRcdENvxbDJ1vqGYgW0/QFETR+CSEtdq+GycJ2sFVTGpG/PzgivmMlryzLG0a0IlWvghocelPYMk7AcB2gSwWOVw4ieHAL2J0q2Wxc4nhEKxqMjAMWkcouACHZRj5GsYvOWUEvIEYAmonk9imkAZg3ncsTYoAQnBZBZfIkZFfBdOVCIz/Yy7ZT0iRvxXqMzboVJh0wKZCu2fBx0t1ShkhqPL0OTpidPU2UOJ9ZUar+mR3cgeRH4slHUvK/vxyGKEGSVWJgdvgurVlvyv1DjzAOk2e3T8TMMt21kvKEjBR0aTiQaH5kOc4mqXqZQCBVrjy2jpseQEpxZ+c4L6SlRvaEdmsVNgBE1sm3hbZdQCoirxnwchs5grELprh1CVUQuEqsRXInTD3KQXqwU608vomIR1Mbi87haK/5dCkl6YF0i1rGzKTFrYUJnwShhbxSARyxu1A416//+3A//z7UB1dlE4DEx8L6UmQW7x2Qc0wZxUDy6nmNf4g9Ed8yo9f8U7MZgUyFACtR0N+UxaawD42OUJelVfdWt6I12t+Pn6R+j6jL4dFDjKgVEabqIUOiKiWJ6Q8Pwuq6Jnsi3emS5tLgrvYMKtsXVNs3aPMUjBHqH1Fgx4u5NJD29KMxfzpM4z5D2VZHleJhFStDFe9sLAInt3cZahTk6VndUTbsK9ep6FnRWDtMKM+Vj5QkermbFVZnHanPU1NQbdqnmVxn3z0l0cX6OMYIwz4PYghDmKB5MgxJJs2g7XA99hUFu5sYhpTxsHX0oaSN5ElIZMaaiNmTZBhL+r+dNfYIqWz3QqA53uUooZEdiS4tngXsG/vLjnhwlDMPOWYyhSjKEOaRxkSBLs5O6SOMP+0CnWgr1pQzCdIPtFrYxgqKSEOT0rk7HYiTZFFKudNOlbGbIJ9p8jnA181a4k3QQ+3AjGNNMpF8IBYBPnB2gI4zTXGYydwcghuA9IFzP4RlJIhW+xfcarLEN5CMTV+KauzGRsfFj/Yfyg4qoWAvMrkepi6dZ1VxcELzCEDxbFZjTXMtGwgE2KnF1dEJgxgK0IDnw4W84HjTgsfJjXMT7cbSmBmCWWLivPbH8q+6n4DFUGFA6lAWOe8q0sTSnEDe0XzGeBeXGgp3BxB5yPNWEUYe6yzuhr2Sfp5l8Us264kuK6uR0DAex3+vYaxcS81DC0q9QUtboEKNymELq7yAJeT7dR/HaWtnrCFVmEZvlF+m2YxfTF56VgS27KLcMwYllMk2/kpF6+tGr+rHd+IqZrFtiXzyFKLLajVpjuNzS2Is9K0Au8i2JLCpn0rTWsQIdDwAl4BQtMYBp3iKCehXG7BbnWSg8Efgu3wE1tgTzwdIsivFPM+j//dEo0Mc0ztRBvUUlbs2SrFlUBvwqFzz34zc+Hq0+/FLL2Oduz51ZjQHnMeYaDSzv5R6b5pYs5kXOEWVz1ocT5O5ob1Eq3vOvKL84afT+RYyODsvDub3D9De6Y/6alSImk1kgcE3UPkxnHAS9KHVMpn7znNizXG1tLaq1Z6kor+qLz1FwQvfHjz4am9bIKmEp6yiguG8NzqgpyTdHOxELT9uQfVg/3SRJhH0Ie+Qi1A3vrfNzAK+dQX7tofbhpAuZBwDmo3gICJXwaAiYlNvgiP5qxBbpqXW5K6vkEXWOS57eE0f1jXv7zLRuTSkghKdTRNTKzQg9hKab2Kk2XjU2RVeAw2cjCmPuAmGNcAlRwOIFNR1lMqBqyKcepwvJyjQ0HNlwcHiV92a5Kjnw+bNTykAbzK/VozD+WMrLiuXhQluaR8JJX/xKnDS3c43amhWvRzrS8Mu8q8+QSrRkjGnmRPGvd+Esn3T5sCkc8cdSdWfGz7k4Mh92dGE67OzEcd3diOO/2xGveJndOUpy6+az4Uo7qYH9KgK6hijP4wrNRez/L9iaXCG/gZIWM3c63mJCbmSl3Zg5eJqeahTqnPl1//28AAAD//wMAUEsDBBQABgAIAAAAIQB0Pzl6wgAAACgBAAAeAAgBY3VzdG9tWG1sL19yZWxzL2l0ZW0xLnhtbC5yZWxzIKIEASigAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAhM/BigIxDAbgu+A7lNydzngQkel4WRa8ibjgtXQyM8VpU5oo+vYWTyss7DEJ+f6k3T/CrO6Y2VM00FQ1KIyOeh9HAz/n79UWFIuNvZ0pooEnMuy75aI94WylLPHkE6uiRDYwiaSd1uwmDJYrShjLZKAcrJQyjzpZd7Uj6nVdb3T+bUD3YapDbyAf+gbU+ZlK8v82DYN3+EXuFjDKHxHa3VgoXMJ8zJS4yDaPKAa8YHi3mqrcC7pr9cd/3QsAAP//AwBQSwMEFAAGAAgAAAAhAD0ogF+2AAAAyQAAABgAKABjdXN0b21YbWwvaXRlbVByb3BzMi54bWwgoiQAKKAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADI3BCsIwEETvgv8Q9h5TG2tVjFKpBe8KXkO6rYVmV5oogvjv5jTMPJi3P378KN44hYHJwHKRgUBy3A7UG7hdG7kBEaKl1o5MaIAYjof5bN+GXWujDZEnvET0Ig1Dyktt4LstdZmdGy11rUu5yotGVlVxkvm6qHS+rJrTefUDkdSUboKBR4zPnVLBPdDbsOAnUoIdT97GVKdecdcNDmt2L48UVZ5la+VeSe/vfgR1+AMAAP//AwBQSwMEFAAGAAgAAAAhAL2EYiOQAAAA2wAAABMAKABjdXN0b21YbWwvaXRlbTIueG1sIKIkACigIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGyOOw7CMBAFr4LSky3o0OI0gQpR5QLGOIqlrNfyLh/fHgdBgZR6nmYediS8dRzVRx1K8p3BE2caPKXZqpfNi+Yoh2ZSTXsAcZMnKy0Fl1l41NYxgUw2+8QhKjx28LVptcFYXdIY7INUXzE9uzvV1Dlcs81lSSH8IB5vQdcnH4IX/1zHC0D4O27eAAAA//8DAFBLAwQUAAYACAAAACEApxCnGbYAAADJAAAAGAAoAGN1c3RvbVhtbC9pdGVtUHJvcHMxLnhtbCCiJAAooCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMjcEKwjAQRO+C/xD2HpPaWqsYRdoK3hW8hnSrhWZXmiiC+O/mNMw8mLc7fPwo3jiFgclAttAgkBx3A90NXC8nWYEI0VJnRyY0QAyH/Xy268K2s9GGyBOeI3qRhiHluTHwbfPjssiaWpbrrJZF3m5k1epabrJVVef6VJSN/oFIako3wcAjxudWqeAe6G1Y8BMpwZ4nb2Oq011x3w8OG3YvjxTVUutSuVfS+5sfQe3/AAAA//8DAFBLAwQUAAYACAAAACEAXJYnIsMAAAAoAQAAHgAIAWN1c3RvbVhtbC9fcmVscy9pdGVtMi54bWwucmVscyCiBAEooAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAITPwWrDMAwG4Huh72B0X5z2MEqJ00sZ5DZGC70aR0lMY8tYSmnffqanFgY7SkLfLzWHe5jVDTN7igY2VQ0Ko6Pex9HA+fT1sQPFYmNvZ4po4IEMh3a9an5wtlKWePKJVVEiG5hE0l5rdhMGyxUljGUyUA5WSplHnay72hH1tq4/dX41oH0zVdcbyF2/AXV6pJL8v03D4B0eyS0Bo/wRod3CQuES5u9MiYts84hiwAuGZ2tblXtBt41++6/9BQAA//8DAFBLAwQUAAYACAAAACEAf4tDw8EAAAAiAQAAEwAoAGN1c3RvbVhtbC9pdGVtMy54bWwgoiQAKKAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAfM8xT8NADIbhvxLd3nNaJEBRkg6sVEJiYbUuvuSknn06u6Q/H4KgMLF5eZ9P7o/XfG7eqWoSHtzet64hDjIlngd3sbh7dMexL12pUqhaIm0+C9auDG4xKx2AhoUyqs8pVFGJ5oNkkBhTIDi07T1kMpzQEH4V981cNd2gdV39euelzlu2h7fT8+uXvUushhzopyrhFv27njhKQVs27wFesBpTfRK2Kmd1Yz9JuGRiOyHjTNsFYw9/vx0/AAAA//8DAFBLAwQUAAYACAAAACEAXY+SPLkAAADJAAAAGAAoAGN1c3RvbVhtbC9pdGVtUHJvcHMzLnhtbCCiJAAooCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMjcGKwjAURfcD8w/h7WOSGrQWo9hWwb3CbEP6qoXmPWniMDDMv09Wl3sP3LM//sRZfOOSJiYHZqVBIAUeJno4uN8usgaRsqfBz0zogBiOh8+P/ZCawWefMi94zRhFGaaS197BrzVbo7uulVXXttLqy0nWta1lZU79+ry1ldnZPxBFTeUmOXjm/GqUSuGJ0acVv5AKHHmJPpe6PBSP4xSw5/COSFlVWm9UeBd9/IozqMM/AAAA//8DAFBLAwQUAAYACAAAACEAAMPsexEBAACSAQAAEwAIAWRvY1Byb3BzL2N1c3RvbS54bWwgogQBKKAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACckLFugzAURfdK/QfLO7GBOGAERAEHqVuHtDsyJkHCNrIdGlT132uUttk7Pt33js59+f4mRzALYwetChhuMARCcd0N6lzAt1MTpBBY16quHbUSBVyEhfvy+Sl/NXoSxg3CAo9QtoAX56YMIcsvQrZ242Plk14b2To/mjPSfT9wwTS/SqEcijDeIX61Tstg+sPBOy+b3X+RnearnX0/LZPXLfMf+AJ66YaugJ+M1IwRTILoSOsgxGEV0JgmAU4xjqqobujh+AXBtC5HEKhW+uq1Vs5rr9CXzlNnl43Th3WmxDfsGb5NQuiuOdYJJVscbuOUsiapkjjFcVwfGMnR4yZHv1Zljlbd+zPLbwAAAP//AwBQSwMEFAAGAAgAAAAhAHvzAqPDAAAAKAEAAB4ACAFjdXN0b21YbWwvX3JlbHMvaXRlbTMueG1sLnJlbHMgogQBKKAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACEz8FqwzAMBuB7Ye9gdF+cdDBKidPLKOQ2Rge7GkdxzGLLWOpY336mpxYGPUpC3y/1h9+4qh8sHCgZ6JoWFCZHU0jewOfp+LwDxWLTZFdKaOCCDIfhadN/4GqlLvESMquqJDawiOS91uwWjJYbypjqZKYSrdSyeJ2t+7Ye9bZtX3W5NWC4M9U4GSjj1IE6XXJNfmzTPAeHb+TOEZP8E6HdmYXiV1zfC2Wusi0exUAQjNfWS1PvBT30+u6/4Q8AAP//AwBQSwECLQAUAAYACAAAACEA7qZvtJUBAAApBwAAEwAAAAAAAAAAAAAAAAAAAAAAW0NvbnRlbnRfVHlwZXNdLnhtbFBLAQItABQABgAIAAAAIQCZVX4FBAEAAOECAAALAAAAAAAAAAAAAAAAAJMDAABfcmVscy8ucmVsc1BLAQItABQABgAIAAAAIQB2pVOsIgEAANsEAAAcAAAAAAAAAAAAAAAAALMGAAB3b3JkL19yZWxzL2RvY3VtZW50LnhtbC5yZWxzUEsBAi0AFAAGAAgAAAAhAG9FDYcnAgAATQYAABEAAAAAAAAAAAAAAAAA6QgAAHdvcmQvZG9jdW1lbnQueG1sUEsBAi0AFAAGAAgAAAAhAKpSJd8jBgAAixoAABUAAAAAAAAAAAAAAAAAPwsAAHdvcmQvdGhlbWUvdGhlbWUxLnhtbFBLAQItABQABgAIAAAAIQAFa2UEpgMAAK0JAAARAAAAAAAAAAAAAAAAAJURAAB3b3JkL3NldHRpbmdzLnhtbFBLAQItABQABgAIAAAAIQCde05xqgEAAO0EAAASAAAAAAAAAAAAAAAAAGoVAAB3b3JkL2ZvbnRUYWJsZS54bWxQSwECLQAUAAYACAAAACEAW239kwkBAADxAQAAFAAAAAAAAAAAAAAAAABEFwAAd29yZC93ZWJTZXR0aW5ncy54bWxQSwECLQAUAAYACAAAACEAON+1jWoBAADAAgAAEAAAAAAAAAAAAAAAAAB/GAAAZG9jUHJvcHMvYXBwLnhtbFBLAQItABQABgAIAAAAIQBNgtzecwEAAOECAAARAAAAAAAAAAAAAAAAAB8bAABkb2NQcm9wcy9jb3JlLnhtbFBLAQItABQABgAIAAAAIQALRmoQGwsAAARwAAAPAAAAAAAAAAAAAAAAAMAdAAB3b3JkL3N0eWxlcy54bWxQSwECLQAUAAYACAAAACEASnSMYcoIAAD3LgAAEwAAAAAAAAAAAAAAAAAIKQAAY3VzdG9tWG1sL2l0ZW0xLnhtbFBLAQItABQABgAIAAAAIQB0Pzl6wgAAACgBAAAeAAAAAAAAAAAAAAAAACsyAABjdXN0b21YbWwvX3JlbHMvaXRlbTEueG1sLnJlbHNQSwECLQAUAAYACAAAACEAPSiAX7YAAADJAAAAGAAAAAAAAAAAAAAAAAAxNAAAY3VzdG9tWG1sL2l0ZW1Qcm9wczIueG1sUEsBAi0AFAAGAAgAAAAhAL2EYiOQAAAA2wAAABMAAAAAAAAAAAAAAAAARTUAAGN1c3RvbVhtbC9pdGVtMi54bWxQSwECLQAUAAYACAAAACEApxCnGbYAAADJAAAAGAAAAAAAAAAAAAAAAAAuNgAAY3VzdG9tWG1sL2l0ZW1Qcm9wczEueG1sUEsBAi0AFAAGAAgAAAAhAFyWJyLDAAAAKAEAAB4AAAAAAAAAAAAAAAAAQjcAAGN1c3RvbVhtbC9fcmVscy9pdGVtMi54bWwucmVsc1BLAQItABQABgAIAAAAIQB/i0PDwQAAACIBAAATAAAAAAAAAAAAAAAAAEk5AABjdXN0b21YbWwvaXRlbTMueG1sUEsBAi0AFAAGAAgAAAAhAF2Pkjy5AAAAyQAAABgAAAAAAAAAAAAAAAAAYzoAAGN1c3RvbVhtbC9pdGVtUHJvcHMzLnhtbFBLAQItABQABgAIAAAAIQAAw+x7EQEAAJIBAAATAAAAAAAAAAAAAAAAAHo7AABkb2NQcm9wcy9jdXN0b20ueG1sUEsBAi0AFAAGAAgAAAAhAHvzAqPDAAAAKAEAAB4AAAAAAAAAAAAAAAAAxD0AAGN1c3RvbVhtbC9fcmVscy9pdGVtMy54bWwucmVsc1BLBQYAAAAAFQAVAHsFAADLPwAAAAA=","contentType":"application/vnd.openxmlformats-officedocument.wordprocessingml.document","fileName":"TestDocument.docx","tempGuid":"f01d4a05-9a1e-4f69-a5f1-f01b435c739a","acaParentId":'#(appId)'}
      When method post
	  Then status 200
	  And print response
	  * match response == 'true'
	  
@SelectUploadDocConditionsFromConditonallyApprovedLic
Scenario: SelectUploadDocConditionsFromConditonallyApprovedLic	  
	* def expirationDateFunc =
		  """
		  function(days) {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd");
		    var date = new java.util.Date();
		    
		    var dayAfter = new java.util.Date(date.getTime() + java.util.concurrent.TimeUnit.DAYS.toMillis( days));
		    return sdf.format(dayAfter);
		  } 
		  """ 
  	  * def expirationDate = expirationDateFunc(90)  
	Given path '/internalapi/api/documents/GetDocuments'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      
      And request {"type":"ConditionalReview","id":'#(appConditionId)',"subCategory":""}
      When method post
	  Then status 200
	  And print response
	  * def acaDocumentId = response[0].acaDocumentId 
	  * def documentId = response[0].documentId 
	  * def ecmFileNetID = response[0].ecmFileNetID
	  * def responseDueDate = expirationDate + "T00:00:00"
	 Given path '/internalapi/api/licensing/conditionReview/saveConditionsInfo'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      * def responseDueDate = expirationDate + "T00:00:00"
      And request {"effectiveDate":'#(effectiveDate)',"expirationDate":'#(expirationDate)',"conditionReview":[{"appConditionId":'#(appConditionId)',"appId":'#(appId)',"conditionId":'#(conditionId)',"conditionDescriptionDetail":'#(conditionDescriptionDetail)',"conditionDescription":'#(conditionDescriptionDetail)',"createdBy":"tgupta@svam.com","conditionDefinedDate":'#(conditionDefinedDate)',"responseDueDate":'#(responseDueDate)',"isConditionMet":true,"responseReceived":null,"attachedDocumentIds":null,"responseReceivedJson":null,"attachDocument":null,"taskOption":null,"documents":[],"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":'#(taskId)',"taskRoleId":0,"taskDecision":'#(taskDecision)',"isActive":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}],"appId":'#(appId)',"comment":"Test Automation","taskId":'#(taskId)',"taskDecision":'#(taskDecision)',"isSaveResponse":false,"isSubmit":true,"emailNotificationModel":{"applicant":{"communicationId":6700,"email":"automation@svam.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":6703,"email":"sbandi@svam.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":0,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}}}
      When method post
	  Then status 200
	  And print response
	  * match response == 'true'
	 Given path '/internalapi/api/documents/GetDocuments'
    
  	   And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json'
     And header current-wfroleid = '4'
    And header Accept = 'application/json, text/plain, */*'
     And request {"type":"application","id":'#(appId)',"subCategory":""}
	  When method post
	  Then status 200
	  And print response
	 * def docData = karate.jsonPath(response, "$[?(@.documentId == '" + documentId + "')]")
	 * def fileName = docData[0].fileName
	 * match fileName == 'TestDocument.docx'

@SearchLicenseForChangeApplicationType
Scenario: SearchLicenseForChangeApplicationType 
Given path '/internalapi/api/licensing/search/searchLicenseApplicationByCriteria'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {"WfTaskIdList":[],"LicenseStatusList":[3,2],"isMFCCAllowed":false,"isAmendmentAllowed":false,"ApplicationTypeIdList":[1],"Status":null,"isPermit":false,"isTempPermit":null,"isApplication":true,"ApplicationId":null,"LicensePermitId":null,"LegalName":"%%%","FEIN":null,"applyFor":""}

	  When method post
	  Then status 200
	  * def applicationId = response.apps[0].applicationId
	  * def appId = response.apps[0].appId
	  * def description = response.apps[0].description
	  * def formId = response.apps[0].formId
	  * def modifiedDate = response.apps[0].modifiedDate
	  * def status = response.apps[0].status
	  * def submitDate = response.apps[0].submitDate
	  * def taskId = response.apps[0].taskId
	  
@SumbitChangeApplicationType
Scenario: SumbitChangeApplicationType 
  	* def receivedDateFunc =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy/MM/dd");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		  """ 
  	  * def receivedDate = receivedDateFunc()
  	  
	Given path '/internalapi/api/document/UploadDocument'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      
      And request {"documentDesc":"TestDocument.docx","acaId":'#(appId)',"acaType":"Application","documentType":{"key":1,"value":"20 DAY NOTICE","description":null,"documentSubCategory":"20 DAY"},"documentCategory":null,"receivedDate":"2022/06/30","createdDate":"2022-06-30T10:07:00.000Z","documentBase64":"data:application/vnd.openxmlformats-officedocument.wordprocessingml.document;base64,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","contentType":"application/vnd.openxmlformats-officedocument.wordprocessingml.document","fileName":"TestDocument.docx","tempGuid":"af77bf79-5c64-65bb-ad51-11dc9cb4371a"}
      When method post
	  Then status 200
	  And print response
	  * match response == 'true'
	Given path '/internalapi/api/license/changeTypeApplication'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      
      And request {"appId":'#(appId)',"isAlternativeTypeAccepted":null,"isAlternativeTypeDecision":null,"comment":"","previousComment":"Test Automation Change Type","acaType":"Application","acaStatus":"ChangeApplicationType","additionalFeesDueDate":null,"isAdditionalFeesRequired":false,"additionalFeesAmount":null,"suggestedLicensePermitTypeIdFullBoard":"1","userDesiredLicensePermitTypeId":"","emailNotificationModel":{"applicant":{"communicationId":12,"email":"automation@svam.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":15,"email":"sbandi@svam.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"automation@svam.com","appId":'#(appId)',"emailContactTypeId":0,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"notificationTypeId":0},"isSubmit":true,"sendNotification":true,"isBasicFlow":true}
      When method post
	  Then status 204

@UploadSupportOppositionParties
Scenario: UploadSupportOppositionParties	  
	* def getDate =
	    """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat('yyyyMMddHHmmss');
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		"""
	Given path '/internalapi/api/licensing/support-opposition/saveSupportOpposition/'
      	And header Content-Type = 'application/json; charset=utf-8'
  	  	
		And header Accept = 'application/json; text/plain;*/*'
       	And header authorization = 'Bearer ' + strToken
      	And request {"premises":{"address":{"addressLine1":'#(Address1)',"addressLine2":'#(Address2)',"stateId":'#(stateCode)',"county":"","city":'#(CountyName)',"zipCode":'#(zipCode)',"zip4":'#(postalCode)',"country":'#(countryName)',"stateName":'#(CountyName)',"countryId":'#(CountyID)',"addressId":0},"legalName":'#(legalName)',"dba":'#(dbaName)',"addressId":null,"type":'suppopp'},"suppOppPartyContactInfo":{"address":{"addressLine1":'#(Address1)',"addressLine2":'#(Address2)',"stateId":'#(stateCode)',"county":"","city":'#(CountyName)',"zipCode":'#(zipCode)',"zip4":'#(postalCode)',"country":'#(countryName)',"stateName":'#(CountyName)',"countryId":'#(CountyID)'},"person":{"firstName":'#(firstName)',"lastName":'#(lastName)',"email":'#(emailId)'}},"feedback":'#(feedback)',"feedbackType":'#(feedbackType)',"tempGuid":'#(tempGuid)'}
	   	When method post
	  	Then status 200	
	    * def resValue = response  
	                   
	 Given path '/internalapi/api/licensing/support-opposition/isExistAddressPremisesAddress/'
      	And header Content-Type = 'application/json; charset=utf-8'
  	  	
		And header Accept = 'application/json; text/plain;*/*'
       	And header authorization = 'Bearer ' + strToken
      	And request {"addressLine1":'#(Address1)',"addressLine2":'#(Address2)',"stateId":'#(stateCode)',"county":"","city":'#(CountyName)',"zipCode":'#(zipCode)',"zip4":'#(postalCode)',"country":'#(countryName)',"stateName":'#(CountyName)',"countryId":'#(CountyID)'}
	   	When method post
	  	Then status 200	
	    
	    
	  Given path '/internalapi/api/licensing/support-opposition/getSupportOppositionByFeedbackList'
      	And header Content-Type = 'application/json; charset=utf-8'
  	  	
		And header Accept = 'application/json; text/plain;*/*'
       	And header authorization = 'Bearer ' + strToken
      	And request ['#(resValue)']
	   	When method post
	  	Then status 200	
	  	* def feedbackId = response.supportOppositionInfo[0].feedbackId + ''
	    * match feedbackId == resValue 
	    * match response.supportOppositionInfo[0].feedbackType == feedbackType 
	    * def suppOppPartyContactInfoId = response.supportOppositionInfo[0].suppOppPartyContactInfoId	
 		* def premisesId = response.supportOppositionInfo[0].premisesId	 
 		* def addressId = response.supportOppositionInfo[0].premises.addressId	
@ViewUploadedSupportOppositionParties
Scenario: ViewUploadedSupportOppositionParties	  
	Given path '/internalapi/api/licensing/support-opposition/getbyFeedBackId/'+resValue
      	And header Content-Type = 'application/json; charset=utf-8'
  	  	
		And header Accept = 'application/json; text/plain;*/*'
       	And header authorization = 'Bearer ' + strToken
      	And request ""
	   	When method get
	  	Then status 200	
	    * def feedbackId = response.supportOppositionInfo.feedbackId + ''
	    * match feedbackId == resValue 
	    * match response.supportOppositionInfo.feedbackType == feedbackType 
	    * match response.supportOppositionInfo.feedback == feedback 
	    
	    
@DeleteUploadedSupportOppositionParties
Scenario: DeleteUploadedSupportOppositionParties	  
	Given path '/internalapi/api/licensing/support-opposition/delete/'+resValue
      	And header Content-Type = 'application/json; charset=utf-8'
  	  	
		And header Accept = 'application/json; text/plain;*/*'
       	And header authorization = 'Bearer ' + strToken
      	And request ""
	   	When method POST
	  	Then status 200	
	    Given path '/internalapi/api/licensing/support-opposition/getbyFeedBackId/'+resValue
      	And header Content-Type = 'application/json; charset=utf-8'
  	  	
		And header Accept = 'application/json; text/plain;*/*'
       	And header authorization = 'Bearer ' + strToken
      	And request ""
	   	When method get
	  	Then status 200	
	    
	    * match response.supportOppositionInfo == null 
	    * match response.totalRecord == 0 


@SearchUploadedSupportOppositionOnPremisesPage
Scenario: SearchUploadedSupportOppositionOnPremisesPage	 
 
	Given path '/internalapi/api/licensing/support-opposition/GetSupportOppositionDataByAppId/'+appId+'/premisesAddress'
      	And header Content-Type = 'application/json; charset=utf-8'
  	  	
		And header Accept = 'application/json; text/plain;*/*'
       	And header authorization = 'Bearer ' + strToken
      	And request ""
	   	When method get
	  	Then status 200	
	  	
	  	 * def responseData = karate.jsonPath(response, "$[?(@.feedbackId == '" + resValue + "')]")
	   And print responseData
	    * def feedbackId = responseData[0].feedbackId + ''
	    * match feedbackId == resValue 
	    * match responseData[0].feedbackType == feedbackType 
	    * match responseData[0].feedback == feedback 
	    * match responseData[0].suppOppPartyContactInfoId == suppOppPartyContactInfoId 
	    * match responseData[0].addressId == addressId 
	      
@AssociateFeeback
Scenario: AssociateFeeback	 
 
	Given path '/internalapi/api/licensing/support-opposition/associateFeedBack/'
      	And header Content-Type = 'application/json; charset=utf-8'
  	  	
		And header Accept = 'application/json; text/plain;*/*'
       	And header authorization = 'Bearer ' + strToken
      	And request {"applicationId":'#(appId)',"feedbackId":'#(feedbackId)'}
	   	When method POST
	  	Then status 200		      
	     * match response == 'true' 
	  Given path '/internalapi/api/licensing/support-opposition/getSupportOpositionData'
      	And header Content-Type = 'application/json; charset=utf-8'
  	  	
		And header Accept = 'application/json; text/plain;*/*'
       	And header authorization = 'Bearer ' + strToken
      	And request {"appId":'#(appId)',"feedbackId":null,"premisesAddressId":null,"isAssociated":null}
	   	When method POST
	  	Then status 200	
	  	* def responseData = karate.jsonPath(response, "$[?(@.feedbackId == '" + resValue + "')]")
	   And print responseData  
	  	* match responseData[0] != []     
	 Given path '/internalapi/api/licensing/support-opposition/getFeedBackByAppId/'+appId
      	And header Content-Type = 'application/json; charset=utf-8'
  	  	
		And header Accept = 'application/json; text/plain;*/*'
       	And header authorization = 'Bearer ' + strToken
      	And request ""
	   	When method get
	  	Then status 200	
	  	
	  	 * def responseData = karate.jsonPath(response, "$[?(@.feedbackId == '" + resValue + "')]")
	   And print responseData     
	      * match responseData[0] != [] 
	      * match responseData[0] != null
	      * match responseData[0].suppOppPartyContactInfoId == suppOppPartyContactInfoId 
@disAssociateFeedBack
Scenario: disAssociateFeedBack	 
 
	Given path '/internalapi/api/licensing/support-opposition/disAssociateFeedBack/'
      	And header Content-Type = 'application/json; charset=utf-8'
  	  	
		And header Accept = 'application/json; text/plain;*/*'
       	And header authorization = 'Bearer ' + strToken
      	And request {"applicationId":'#(appId)',"feedbackId":'#(feedbackId)'}
	   	When method POST
	  	Then status 200		      
	     * match response == 'true' 
	  Given path '/internalapi/api/licensing/support-opposition/getSupportOpositionData'
      	And header Content-Type = 'application/json; charset=utf-8'
  	  	
		And header Accept = 'application/json; text/plain;*/*'
       	And header authorization = 'Bearer ' + strToken
      	And request {"appId":'#(appId)',"feedbackId":null,"premisesAddressId":null,"isAssociated":null}
	   	When method POST
	  	Then status 200
	  	* def responseData = karate.jsonPath(response, "$[?(@.feedbackId == '" + resValue + "')]")
	   And print responseData  	
	  	* match responseData == [] 
	          
	 Given path '/internalapi/api/licensing/support-opposition/getFeedBackByAppId/'+appId
      	And header Content-Type = 'application/json; charset=utf-8'
  	  	
		And header Accept = 'application/json; text/plain;*/*'
       	And header authorization = 'Bearer ' + strToken
      	And request ""
	   	When method get
	  	Then status 200	
	  	
	  	 * def responseData = karate.jsonPath(response, "$[?(@.feedbackId == '" + resValue + "')]")
	   And print responseData     
	     * match responseData == []  		    
	 
@SearchAndValidateUploadedSupportOppositionParty
Scenario: SearchAndValidateUploadedSupportOppositionParty		 
	  Given path '/internalapi/api/licensing/support-opposition/get'
      	And header Content-Type = 'application/json; charset=utf-8'
  	  	
		And header Accept = 'application/json; text/plain;*/*'
       	And header authorization = 'Bearer ' + strToken
      	And request ""
	   	When method get
	  	Then status 200	
	  	
	  	 * def responseData = karate.jsonPath(response, "$[?(@.feedbackId == '" + resValue + "')]")
	        
	     * def feedbackId = responseData[0].feedbackId + ''
	    * match feedbackId == resValue 
	    * match responseData[0].feedbackType == feedbackType 
	    * match responseData[0].feedback == feedback 
	    * match responseData[0].suppOppPartyContactInfoId == suppOppPartyContactInfoId 		    
	 
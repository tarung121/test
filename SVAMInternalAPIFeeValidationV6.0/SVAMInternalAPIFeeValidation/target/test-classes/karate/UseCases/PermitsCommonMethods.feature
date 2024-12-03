Feature: Permit Common Scenarios

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
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
		    
		    var date = new java.util.Date();
		    var dayAfter = new java.util.Date(date.getTime() + java.util.concurrent.TimeUnit.DAYS.toMillis( 7 ));
		    return sdf.format(dayAfter);
		  } 
		  """
		  * def fundDueDate = fundDueDateFunc()
	    * def licFeesDate =
			"""
			  function() {
			    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
			    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
			    var date = new java.util.Date();
			    return sdf.format(date);
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
  @GetConditionallyApprovedLicenses
  Scenario: Get ConditionallyApproved Licenses List
    Given path '/internalapi/api/licensing/search/searchLicenseApplicationByCriteria'
   
    And header authorization = 'Bearer ' + strToken
    And request {"showOnlyLicensesAssociated":true,"WfTaskIdList":[],"LicenseStatusList":[1,2,3,5,7,8,9],"Status":"Conditionally Approved","isPermit":false,"isTempPermit":null,"isApplication":true,"ApplicationId":null,"LicensePermitId":null,"LegalName":"Automation","FEIN":null,"applyFor":""}
    
    When method post
    Then status 200
    And def serverResponse = response
    And print serverResponse.apps[0].licensePermitId
    And print serverResponse.apps[0].licPermitTypeId
    * def licAppID = serverResponse.apps[0].appId
    * def licApplicationId = serverResponse.apps[0].applicationId
    
    
   @GetActivatedLicenses
  Scenario: Get Activated Licenses List
    Given path '/internalapi/api/licensing/search/searchLicensesAndPermits/'
    And header authorization = 'Bearer ' + strToken
    And request {"showOnlyLicensesAssociated":true,"Status":"Active","WfTaskIdList":[],"LicenseStatusList":[],"isPermit":false,"isTempPermit":null,"isApplication":true,"ApplicationId":null,"LicensePermitId":null,"LegalName":'#(SearchName)',"FEIN":null,"applyFor":""}
      When method post
    Then status 200
    And def serverResponse = response
    And print serverResponse.licenses[0].licensePermitId
    And print serverResponse.licenses[0].licPermitTypeId
    * def licTypeId = serverResponse.licenses[0].licPermitTypeId
    * def licId = serverResponse.licenses[0].licensePermitId
 

  @IntakeStandalonePermit
  Scenario: IntakeStandalonePermit
    Given path '/internalapi/api/licensing/selectapptype/savenewpermitapp'
    * def dbSts = db.cleanHeap()
    And header authorization = 'Bearer ' + strToken
    And header Content-Type = 'application/json; charset=utf-8'
    And header Accept = 'application/json; text/plain;*/*'
   
    And request {"businessType":"","permitType":"Standalone Permit","mainLicenseId":'#(licId)',"tempPermitTypeId":[],"mainApplicationId":"","associatedLicenseList":[],"isMainTempPermitRequired":false,"newPermitTypeIds":[{"permitTypeId":'#(mainLicensePermitTypeId)'}],"isNotQualified":false,"notQualifiedReason":""}
                
    When method post
    Then status 200
    And def ApplicationId = response[0].mainApplicationId
    And print ApplicationId
    And match ApplicationId contains 'NA-'
    And def description = response[0].description
    And print description
    And def appId = response[0].appId
    * def formId = response[0].formId
    * def licensePermitTypeId = response[0].licensePermitTypeId
  
    
    
    @SearchAndValidatePermitExaminerQueue
  Scenario: SearchAndValidatePermitExaminerQueue 
   Given path '/internalapi/api/licensing/search/licenseApplication/queueType/1'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      * def stringParam = "applicationId~contains~'"+ApplicationId+"'"
      * def examiner_id = 1069
      * eval if(examinerId != null && examinerId !=[]) examiner_id = examinerId
      And params  {licenseTypeId:2,examinerId:'#(examiner_id)',licensingBoardId:0,isTempOrLiq:false,isRealTimeResult:true,filter:'#(stringParam)',page:1,pageSize:10}
    
    And header current-wfroleid = 5
     And request ""
	  When method get
	  Then status 200
	  And print response
	  * match response.data[0].applicationId == '#(ApplicationId)'  
	  * match response.data[0].taskStatus == '#(taskStatus)'

@PermitLBApproval
Scenario: PermitLBApproval    
 # ********* PermitLBApproval *********************    
    Given path '/internalapi/api/licensing/new-permit/saveDecision'
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
	    And request {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"isChainRestaurant":false,"appId":'#(appId)',"applicationType":1,"applicationId":'#(ApplicationId)',"legalName":'#(legalName)',"statusId":3,"decisionType":{"name":'#(approvalName)',"value":'#(selectedDecisionCode)'},"emailNotificationModel":{"applicant":{"communicationId":6579,"email":'#(emailId)',"appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":6582,"email":"sbandi@svam.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}},"hasErrors":[],"licPermitTypeId":412,"taskId":1601,"newComments":"Test","approval":{"isDefineStipulations":false,"effectiveDate":"2022-07-07","expirationDate":"2025-07-31"}}
	    When method post
	    Then status 200
	    * def response = 'true'
   		* call read('LicensesCommonMethods.feature@checkApplicationStatus') {} 
   		
@SearchAndValidateSpecialPermitExaminerQueue
Scenario: SearchAndValidateSpecialPermitExaminerQueue
Given path '/internalapi/api/licensing/search/licenseApplication/queueType/1'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      * def stringParam = "applicationId~contains~'"+ApplicationId+"'"
      And params  {filter:'#(stringParam)',isTempOrLiq:false,page:1,pageSize:10,licenseTypeId:2,examinerId:1069,licensingBoardId:-1,isRealTimeResult:false}
     
      And request ""
	  When method get
	  Then status 200
	  And print response
	  * match response.data[0].applicationId == '#(ApplicationId)'  
	  * match response.data[0].isSpecialEventInsideFiveBoroughs == true
	  	  
  @IntakeStandalonePermitwithoutLic
  Scenario: IntakeStandalonePermitWithoutLic
    Given path '/internalapi/api/licensing/selectapptype/savenewpermitapp'
    * def dbSts = db.cleanHeap()
    And header authorization = 'Bearer ' + strToken
    And header Content-Type = 'application/json; charset=utf-8'
    And header Accept = 'application/json; text/plain;*/*'
    And request {"businessType":"","permitType":"Standalone Permit","mainLicenseId":null,"tempPermitTypeId":[],"mainApplicationId":"","associatedLicenseList":[],"isMainTempPermitRequired":false,"newPermitTypeIds":[{"permitTypeId":'#(mainLicensePermitTypeId)'}],"isNotQualified":false,"notQualifiedReason":""}
    When method post
    Then status 200
    And def ApplicationId = response[0].mainApplicationId
    And print ApplicationId
    And match ApplicationId contains 'NA-'
    And def description = response[0].description
    And print description
    And def appId = response[0].appId
    * def formId = response[0].formId
    
    @IntakeStandalonePermitwithoutLic_multipleintake
  Scenario: IntakeStandalonePermitwithoutLic_multipleintake
    Given path '/internalapi/api/licensing/selectapptype/savenewpermitapp'
    * def dbSts = db.cleanHeap()
    And header authorization = 'Bearer ' + strToken
    And header Content-Type = 'application/json; charset=utf-8'
    And header Accept = 'application/json; text/plain;*/*'
    And request {"businessType":"","permitType":"Standalone Permit","mainLicenseId":null,"tempPermitTypeId":[],"mainApplicationId":"","associatedLicenseList":[],"isMainTempPermitRequired":false,"newPermitTypeIds":[{"permitTypeId":'#(mainLicensePermitTypeId)'},{"permitTypeId":'#(mainLicensePermitTypeId)'}],"isNotQualified":false,"notQualifiedReason":""}
    When method post
    Then status 200
    And def ApplicationId = response[0].mainApplicationId
    And print ApplicationId
    And match ApplicationId contains 'NA-'
    And def description = response[0].description
    And print description
    And def appId = response[0].appId
    * def formId = response[0].formId
    
    
    
  @IntakeAssociatedPermit
  Scenario: intakeAssociated Permit
    Given path '/internalapi/api/licensing/selectapptype/savenewpermitapp'
    * def dbSts = db.cleanHeap()
    And header authorization = 'Bearer ' + strToken
    And header Content-Type = 'application/json; charset=utf-8'
    And header Accept = 'application/json; text/plain;*/*'
    * def totalFees = licenseFees  + fillingFees
    And print totalFees
    And request {"businessType":"","permitType":"Associated Permit","mainLicenseId":'#(licId)',"tempPermitTypeId":[],"mainApplicationId":"","associatedLicenseList":[],"isMainTempPermitRequired":false,"newPermitTypeIds":[{"permitTypeId":'#(mainLicensePermitTypeId)'}],"isNotQualified":false,"notQualifiedReason":""}
    When method post
    Then status 200
    And def ApplicationId = response[0].mainApplicationId
    And print ApplicationId
    And print ApplicationId
    And match ApplicationId contains 'NA-'
    And def description = response[0].description
    And def appId = response[0].appId
    * def formId = response[0].formId
    * def FormVersionId = response[0].FormVersionId
    * call read('PermitsCommonMethods.feature@ValidateAssociatedPermitAfterIntake') {}
    
    @IntakeMultipleAssociatedPermit
  Scenario: intakeAssociated Permit
    Given path '/internalapi/api/licensing/selectapptype/savenewpermitapp'
    * def dbSts = db.cleanHeap()
    And header authorization = 'Bearer ' + strToken
    And header Content-Type = 'application/json; charset=utf-8'
    And header Accept = 'application/json; text/plain;*/*'
    * def totalFees = licenseFees  + fillingFees
    And print totalFees
    And request {"businessType":"","permitType":"Associated Permit","mainLicenseId":'#(licId)',"tempPermitTypeId":[],"mainApplicationId":"","associatedLicenseList":[],"isMainTempPermitRequired":false,"newPermitTypeIds":[{"permitTypeId":'#(mainLicensePermitTypeId)'},{"permitTypeId":'#(mainLicensePermitTypeId)'}],"isNotQualified":false,"notQualifiedReason":""}
    When method post
    Then status 200
    And def ApplicationId = response[0].mainApplicationId
    And print ApplicationId
    And print ApplicationId
    And match ApplicationId contains 'NA-'
    And def description = response[0].description
    And def appId = response[0].appId
    * def formId = response[0].formId
    * def FormVersionId = response[0].FormVersionId
    * call read('PermitsCommonMethods.feature@ValidateAssociatedPermitAfterIntake') {}

  @ValidateAssociatedPermitAfterIntake
  Scenario: ValidateAssociatedPermitAfterIntake
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
    * def itemCount = (response.items.length) - 1
    And print itemCount
    And def lpStatus = response.items[itemCount].lpStatus
    And print lpStatus
    And def associatedpermitId = response.items[itemCount].licensePermitId
    And print associatedpermitId
    And def associatedApplicationId = response.items[itemCount].applicationId
    And print associatedApplicationId
    And def licStatus = response.items[itemCount].appStatus
    And print licStatus
    And match licStatus == 'Draft'
    And match associatedApplicationId == ApplicationId
    And match associatedpermitId == licId
    And match lpStatus == 'Active'

  @ValidateStandAlonePermitWithLicIDAfterIntake
  Scenario: ValidateStandAlonePermitWithLicIDAfterIntake
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
    And def respnseJson = response.items
    And print respnseJson
    * def responseData = karate.jsonPath(respnseJson, "$[?(@.applicationId == '" + ApplicationId + "')]")
    And print responseData
    And def licStatus = responseData[0].appStatus
    And match licStatus == 'Draft'
    And match responseData[0].applicationId == ApplicationId
    And match responseData[0].lpStatus == 'Active'
    And match responseData[0].licensePermitId == licId

  @searchLicenseApplicationByCriteria
  Scenario: searchLicenseApplicationByCriteria
    Given path '/internalapi/api/licensing/search/searchLicenseApplicationByCriteria'
    * def dbSts = db.cleanHeap()
    And header authorization = 'Bearer ' + strToken
    And header Content-Type = 'application/json; charset=utf-8'
    And header Accept = 'application/json; text/plain;*/*'
    And configure continueOnStepFailure = true
    And request {"showOnlyLicensesAssociated":true,"WfTaskIdList":[],"LicenseStatusList":[1,2,3,5,7,8,9],"Status":null,"isPermit":false,"isTempPermit":null,"isApplication":true,"ApplicationId":'#(fiveDigitAppID)',"LicensePermitId":null,"LegalName":'#(legalName)',"FEIN":null,"applyFor":""}
    When method post
    * configure continueOnStepFailure = true
    Then status 200
    And def respnseJson = response.apps
    And print respnseJson
    * def responseData = karate.jsonPath(respnseJson, "$[?(@.applicationId contains 'NA-')]")
    And print responseData
    And def SearchedapplicationId = responseData[0].applicationId
    And def SearchedapplicationIdStatus = responseData[0].status

  @IntakeTempPermit
Scenario: IntakeTempPermit
    # ********* App Intake *********************
    Given path '/internalapi/api/licensing/selectapptype/savenewpermitapp'
    * def dbSts = db.cleanHeap()
    And header authorization = 'Bearer ' + strToken
    And header Content-Type = 'application/json; charset=utf-8'
    And header Accept = 'application/json; text/plain;*/*'
    * def condition = permit_Type.startsWith('temp')
    And print condition
    And request {"businessType":"","permitType":'#(permit_Type)',"mainLicenseId":'#(SearchedapplicationId)',"tempPermitTypeId":[{"applicationId":'#(SearchedapplicationId)',"tempLicensePermitTypeId":'#(mainLicensePermitTypeId)'}],"mainApplicationId":"","associatedLicenseList":[],"isMainTempPermitRequired":true,"newPermitTypeIds":[],"isNotQualified":false,"notQualifiedReason":""}
    When method post
    Then status 200
    And def ApplicationId = response[0].mainApplicationId
    And print ApplicationId
    And def description = response[0].description
    And def appId = response[0].appId
    * def formId = response[0].formId
    And eval if(SearchedapplicationId != null){ karate.call('PermitsCommonMethods.feature@ValidatePermitWithApplicationAfterIntake')}
    And eval if(SearchedapplicationId == null){ karate.call('PermitsCommonMethods.feature@ValidateStandAlonePermitAfterIntake')}


  @ValidatePermitWithApplicationAfterIntake
  Scenario: ValidatePermitWithApplicationAfterIntake
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
    And def respnseJson = response.items
    And print respnseJson
    * def responseData = karate.jsonPath(respnseJson, "$[?(@.applicationId == '" + ApplicationId + "')]")
    And print responseData
    And def licStatus = response.appStatus
    And print licStatus
    And match licStatus == SearchedapplicationIdStatus
    And match response.applicationId == SearchedapplicationId
    And match responseData[0].appStatus == '#(AppStatus)'
    And match responseData[0].applicationId == ApplicationId

@PermitExaminerReview
  Scenario: PermitExaminerReview
    * def summisionDate =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		  
		  
		  """
	* def formatedSumbitDate = summisionDate()
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
		    And def formVersionId = response.formVersionId
		  And print formVersionId
		   And def formId = response.formId
		  And print formId
		   And def legalName = response.legalName
		  And print legalName
		  And def submitDate = response.submitDate
		  And print submitDate
		   And def modifiedDate = response.modifiedDate
		  And print modifiedDate
		 
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
		  And def licenseDescription = response.licenseDescription
		  And print licenseDescription
		  
    
 	Given path '/internalapi/api/licensing/examiner-review/SaveNewPermit'
	    
	    And header authorization = 'Bearer ' + strToken
	    And header current-wfroleid = 4
	    And request {"isFingerPrintsApproved":'#(isFingerPrintsApproved)',"isFingerPrintsRequired":'#(isFingerPrintsRequired)',"isCorpLLCDissolved":false,"isCorpLLCDTaken":false,"isSendPDLetter":false,"isDisable500LB_FBPT":false,"isDisableLBForPD":false,"isDisableLBForCaseClosed":false,"isDisableLateRenewalAndUnderpayment":false,"isLiquidatorPermitHasCompleted":-1,"isSubmit":true,"fieldDeficiencies":[],"masterFileData":[],"combinedCraftData":[],"application":{"applicationCategory":6,"appId":'#(appId)',"applicationId":'#(ApplicationId)',"licePermitTypeId":null,"applicationTypeId":1,"formVersionId":'#(formVersionId)',"formId":'#(formId)',"legalName":'#(legalName)',"submitDate":'#(formatedSumbitDate)',"isGISRequired":null,"licenseDescription":'#(licenseDescription)',"recommendedDecisionId":null,"status500":null,"isApplicableForPDLetter":false,"countyName":'#(CountyName)',"priority":"Normal","expirationDate":null,"appStatusId":2,"taskStatus":"Awaiting Review","taskId":1526,"currentWfstatus":null,"communityBoard":null,"isLicenseApplication":false,"currentDueDate":null,"isFinalDeficiency":null,"isHighlyDeficient":null,"isAllDeficienciesMet":null,"pastDueDate":null,"memo":null,"isOneTimePermit":null,"dueDateAction":null,"isDisapprovedForCause":false,"isNotQualified":false,"event":null,"appStatus":{"appStatusId":2,"statusDescription":"IntakeComplete","isActive":true,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"applicationType":null,"assignAppExaminer":{"appExaminerId":'#(appExaminerId)',"appId":'#(appId)',"examinerId":1069,"name":null,"assignDate":'#(formatedSumbitDate)',"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"assignAppToLB":null,"licePermitType":{"licPermitTypeId":'#(licPermitTypeId)',"type":"2","category":"6","product":"","class":null,"description":null,"sectionOfLaw":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null,"isTempPermit":false,"isELicensingPermit":true,"isAdditionalBar":false},"assoApplicationList":[],"isTempPermit":null,"isTempOrLiq":false,"licPermitTypeId":'#(licPermitTypeId)',"isAssociatedLicense":null,"effectiveDate":null,"assignedUserId":null,"amendmentTypeId":null,"amendmentType":null,"disapprovedDate":null,"condApprovedDate":null,"addressId":null,"isCaseOpen":null,"isClosed":null,"isSpecialEventPlusFour":null,"isSpecialEventInsideFiveBoroughs":null,"licStatus":null,"createdBy":null,"licenseId":null,"address":null,"isNybeApp":true,"isHearingCompleted":null,"does500FtHearingExist":null,"parentAppStatus":null,"premisesAppCount":0,"statusDescription":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskRoleId":0,"taskDecision":null,"isActive":true,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":'#(formatedSumbitDate)'},"appId":'#(appId)',"notificationTypeId":2028,"applicationType":1,"decisionType":{"name":"Send to Licensing Board","value":2},"emailNotificationModel":{"applicant":{},"attorney":{},"communityBoard":{},"other":{}},"hasErrors":[],"taskId":1526,"newComments":"SEND TO LB AUTOMATION","recommendedDecisionId":"1"}
	    When method post
	    Then status 200
    
   	  
@UploadDocument
Scenario: UploadDocument
 
	     
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
      
      And request {"documentDesc":"TestDocument.docx","acaId":'#(appId)',"acaType":"application","bureau":"bureau","documentType":{"key":158,"value":"PD LETTER - NO WITNESS","description":null,"documentSubCategory":""},"documentCategory":null,"receivedDate":'#(receivedDate)',"createdDate":'#(date)',"documentBase64":"data:application/vnd.openxmlformats-officedocument.wordprocessingml.document;base64,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","contentType":"application/vnd.openxmlformats-officedocument.wordprocessingml.document","fileName":"TestDocument.docx","tempGuid":"59c72c87-36e2-61bd-4fe4-2352433796c3"}
      When method post
	  Then status 200
	  And print response
	  * match response == 'true'
   
   				 
  	  
@UploadDisApprovalDocument
Scenario: UploadDisApprovalDocument
 
	     
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
      
      And request {"documentDesc":"TestDocument.docx","acaId":'#(appId)',"acaType":"Application","bureau":"Licensing","documentType":{"key":325,"value":"Disapproval Letter","description":null,"documentSubCategory":"DISAPPROVAL"},"documentCategory":null,"receivedDate":'#(receivedDate)',"createdDate":'#(date)',"documentBase64":"data:application/vnd.openxmlformats-officedocument.wordprocessingml.document;base64,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","contentType":"application/vnd.openxmlformats-officedocument.wordprocessingml.document","fileName":"TestDocument.docx","tempGuid":"2d2e4297-3017-4d19-2569-5350b503dea1"}
      When method post
	  Then status 200
	  And print response
	  * match response == 'true'
   
   	    
  
@GetDigestSupportDocuments
  Scenario: GetDigestSupportDocuments
   
    Given path '/internalapi/api/licensing/digest/getSupportDocumentsDigestByAppId/'+appId+'/DigestSupportDocuments'
	   	* def dbSts = db.cleanHeap()
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;*/*'
	      And configure continueOnStepFailure = true
	   	 And request {}
		  When method get
		  * configure continueOnStepFailure = true
		  Then status 200
		  
		 
		  * match response.userId == 1069
		  * match response.appId == appId
		  
@SaveSupportDocumentDigest
  Scenario: SaveSupportDocumentDigest
   
    Given path '/internalapi/api/licensing/digest/saveSupportDocumentDigest/'+appId
	   	* def dbSts = db.cleanHeap()
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;*/*'
	      And configure continueOnStepFailure = true
	   	 And request {digestList: []}
		  When method POST
		  * configure continueOnStepFailure = true
		  Then status 200
		  
		 	  
		  
   @PermitLBDecisions
  Scenario: PermitLBDecisions
    * def fundDueDateFunc1 =
		  """
			  function(days) {
			    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
			    var sdf = new SimpleDateFormat("yyyy-MM-dd");
			    
			    var date = new java.util.Date();
			    var dayAfter = new java.util.Date(date.getTime() + java.util.concurrent.TimeUnit.DAYS.toMillis( days));
			    return sdf.format(dayAfter);
			  } """
		 
		  * def currentDate = fundDueDateFunc1(0)  
		  * def expiryDate = fundDueDateFunc1(30)   
    Given path '/internalapi/api/licensing/new-permit/saveDecision'
    And header authorization = 'Bearer ' + strToken
    And header current-wfroleid = 5
    * def payload = ""
    * def payloadForFBDecisionReq = {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"isChainRestaurant":false,"appId":'#(appId)',"applicationType":1,"applicationId":'#(ApplicationId)',"legalName":'#(legalName)',"statusId":3,"decisionType":{"name":"FB Decision Required","value":6},"emailNotificationModel":{"applicant":{},"attorney":{},"communityBoard":{},"other":{}},"hasErrors":[],"licPermitTypeId":434,"taskId":1601,"newComments":"test","conditionalApproval":{"effectiveDate":'#(currentDate)',"expirationDate":'#(expiryDate)',"selectInput":{"fromFields":[{"id":1,"label":"Provide a copy of the Assumed Name Certificate from the Secretary of State for your corporation/LLC’s dba name"},{"id":2,"label":"Provide a copy of the business certificate from the county clerk for your dba name"},{"id":3,"label":"Provide your federal tax identification number"},{"id":4,"label":"Provide a copy of your Certificate of Authority from the New York State Tax Department"},{"id":5,"label":"Provide an amended Certificate of Authority – the name must match the applicant name exactly."},{"id":6,"label":"Provide an amended Certificate of Authority – the address must match the premises address exactly"},{"id":7,"label":"Provide a signed Bond Rider amending____________"},{"id":8,"label":"Provide Worker’s Compensation and Disability Benefits insurance provider names and policy numbers"},{"id":9,"label":"Provide an inventory of the alcoholic beverages you will be purchasing from the current licensee"},{"id":10,"label":"Submit a copy of the Newspaper Affidavit(s)"},{"id":11,"label":"Provide your TTB permit"},{"id":12,"label":"Surrender of the current license in effect"},{"id":13,"label":"Other Condition"}],"toFields":[],"isRewritable":true,"rewriteLabel":"Edit Condition:","additionalComments":"","srclabel":"Select","dstlabel":"Add to Letter","additionalLabel":"Additional Conditions:"}}}
    * def payloadForwithdraw = {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"isChainRestaurant":false,"appId":'#(appId)',"applicationType":1,"applicationId":'#(ApplicationId)',"legalName":'#(legalName)',"statusId":3,"decisionType":{"name":"Withdrawal","value":4},"emailNotificationModel":{"applicant":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"automation@test.com","appId":'#(appId)',"emailContactTypeId":0,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}},"hasErrors":[],"licPermitTypeId":'#(mainLicensePermitTypeId)',"taskId":1601,"newComments":"withdrawing the application"}
    * def payloadWithReturnToExaminer = {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"isChainRestaurant":false,"appId":'#(appId)',"applicationType":1,"applicationId":'#(ApplicationId)',"legalName":'#(legalName)',"statusId":3,"decisionType":{"name":"Return to Examiner","value":7,"isChecked":null},"emailNotificationModel":{"applicant":{},"attorney":{},"communityBoard":{},"other":{}},"hasErrors":[],"licPermitTypeId":'#(mainLicensePermitTypeId)',"taskId":1601,"newComments":"returning to examiner queue for correct review"}
    
    #* def payloadWithConditionalApprove = {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"isChainRestaurant":false,"appId":'#(appId)',"applicationType":1,"applicationId":'#(ApplicationId)',"legalName":'#(legalName)',"statusId":3,"decisionType":{"name":"Conditionally Approved","value":5},"emailNotificationModel":{"applicant":{"communicationId":106,"email":"automation@svam.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":109,"email":"sbandi@svam.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}},"hasErrors":[],"licPermitTypeId":'#(mainLicensePermitTypeId)',"taskId":1601,"newComments":"","conditionalApproval":{"selectInput":{"fromFields":[{"id":2,"label":"Provide a copy of the business certificate from the county clerk for your dba name"},{"id":3,"label":"Provide your federal tax identification number"},{"id":4,"label":"Provide a copy of your Certificate of Authority from the New York State Tax Department"},{"id":5,"label":"Provide an amended Certificate of Authority – the name must match the applicant name exactly."},{"id":6,"label":"Provide an amended Certificate of Authority – the address must match the premises address exactly"},{"id":7,"label":"Provide a signed Bond Rider amending____________"},{"id":8,"label":"Provide Worker’s Compensation and Disability Benefits insurance provider names and policy numbers"},{"id":9,"label":"Provide an inventory of the alcoholic beverages you will be purchasing from the current licensee"},{"id":10,"label":"Submit a copy of the Newspaper Affidavit(s)"},{"id":11,"label":"Provide your TTB permit"},{"id":12,"label":"Surrender of the current license in effect"},{"id":13,"label":"Other Condition"}],"toFields":[{"id":1,"label":"Provide a copy of the Assumed Name Certificate from the Secretary of State for your corporation/LLC’s dba name"}],"isRewritable":true,"rewriteLabel":"Edit Condition:","additionalComments":"","srclabel":"Select","dstlabel":"Add to Letter","additionalLabel":"Additional Conditions:"},"effectiveDate":'#(currentDate)',"expirationDate":'#(expiryDate)',"conditions":[1],"descriptions":["Provide a copy of the Assumed Name Certificate from the Secretary of State for your corporation/LLC’s dba name"]}}
    * def payloadWithApproval = {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"appId":'#(appId)',"applicationType":1,"applicationId":'#(applicationId)',"legalName":"Sep13_BrewerTasting_Annual_AQAMC","statusId":3,"decisionType":{"name":"Approved","value":1},"emailNotificationModel":{"applicant":{"communicationId":6936,"email":"vdsouza@svam.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":6938,"email":"vdsouza@svam.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}},"hasErrors":[],"licPermitTypeId":'#(mainLicensePermitTypeId)',"taskId":1601,"newComments":"","approval":{"isDefineStipulations":false,"effectiveDate":'#(currentDate)',"expirationDate":'#(expiryDate)'}}
    * def payloadDisapprovalWithSingle = {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"isChainRestaurant":false,"appId":'#(appId)',"applicationType":1,"applicationId":'#(applicationId)',"legalName":'#(legalName)',"statusId":3,"decisionType":{"name":"Disapproved","value":2},"emailNotificationModel":{"applicant":{"communicationId":4095,"email":"vdsouza@svam.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":4097,"email":"vdsouza@svam.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":0,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}},"hasErrors":[],"licPermitTypeId":'#(mainLicensePermitTypeId)',"taskId":1601,"newComments":"Disapproved the permit","disApproval":{"isDisapprovalForCause":true,"isDisapprovalLetterAttach":true,"selectInput":{"fromFields":[{"id":1,"label":"A temporary permit may not be considered for approval unless it is preceded or accompanied by an application for a permanent license."},{"id":2,"label":"A temporary permit for a New York City premises may not be considered for approval, unless a contract of sale is submitted with the application.  No contract of sale was submitted for this transaction."},{"id":3,"label":"A liquidator’s permit may not be considered for approval when the application it is filed in conjunction with is disapproved."},{"id":4,"label":"A liquidator’s permit may not be approved when the seller of the alcohol is currently in arrears and on the Authority’s COD List.  The seller will need to clear all accounts in arrears and re-apply."},{"id":6,"label":"Check number ____ in the amount of ________ , for payment in connection with this application was returned due to insufficient funds.  A request for certified funds was sent to the applicant on _________, to which there was no reply."},{"id":7,"label":"Licensees are not eligible to change corporate entities using an endorsement/corporate change application.  A licensee forming a new entity and using a new FEIN# must file a new application under the new corporate entity."},{"id":8,"label":"Endorsement applications may not be used to change an application from an executor of an estate to a corporation.  A new application must be filed once the estate is settled."},{"id":9,"label":"Licensee is not eligible to file a removal under a new corporate entity.  Licensee must file a new application for the new corporate entity with the new FEIN #."},{"id":10,"label":"The applicant submitted an outdated application form that is no longer accepted for processing as of 11/30/13."},{"id":11,"label":"Temporary retail permit was received with an outdated main application."},{"id":12,"label":"The corporate change filed under this serial number is a duplicate of a corporate change filed on _______________under _________________________________, serial number __________."}],"toFields":[{"id":5,"label":"An insufficient fee was submitted with the application.  Total fee due was $___ and the total fee paid was $_____"}],"isRewritable":true,"rewriteLabel":"Edit Reason for Disapproval:","additionalComments":"Test","srclabel":"Select","dstlabel":"Add to Notification","additionalLabel":"Additional Reasons for Disapproval:"},"disapprovalReason":[5,-1],"descriptions":["An insufficient fee was submitted with the application.  Total fee due was $___ and the total fee paid was $_____","Test"]}}
    * def payloadDisapprovalUncheckbox = {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"isChainRestaurant":false,"appId":'#(appId)',"applicationType":1,"applicationId":'#(applicationId)',"legalName":'#(legalName)',"statusId":3,"decisionType":{"name":"Disapproved","value":2},"emailNotificationModel":{"applicant":{"communicationId":6567,"email":"automation@svam.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":6570,"email":"sbandi@svam.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}},"hasErrors":[],"licPermitTypeId":'#(mainLicensePermitTypeId)',"taskId":1601,"newComments":"Disapproved the permit","approval":{"isDefineStipulations":false,"effectiveDate":'#(currentDate)',"expirationDate":'#(expiryDate)'},"disApproval":{"isDisapprovalForCause":false,"isDisapprovalLetterAttach":true,"selectInput":{"fromFields":[{"id":1,"label":"A temporary permit may not be considered for approval unless it is preceded or accompanied by an application for a permanent license."},{"id":2,"label":"A temporary permit for a New York City premises may not be considered for approval, unless a contract of sale is submitted with the application.  No contract of sale was submitted for this transaction."},{"id":3,"label":"A liquidator’s permit may not be considered for approval when the application it is filed in conjunction with is disapproved."},{"id":4,"label":"A liquidator’s permit may not be approved when the seller of the alcohol is currently in arrears and on the Authority’s COD List.  The seller will need to clear all accounts in arrears and re-apply."},{"id":6,"label":"Check number ____ in the amount of ________ , for payment in connection with this application was returned due to insufficient funds.  A request for certified funds was sent to the applicant on _________, to which there was no reply."},{"id":7,"label":"Licensees are not eligible to change corporate entities using an endorsement/corporate change application.  A licensee forming a new entity and using a new FEIN# must file a new application under the new corporate entity."},{"id":8,"label":"Endorsement applications may not be used to change an application from an executor of an estate to a corporation.  A new application must be filed once the estate is settled."},{"id":9,"label":"Licensee is not eligible to file a removal under a new corporate entity.  Licensee must file a new application for the new corporate entity with the new FEIN #."},{"id":10,"label":"The applicant submitted an outdated application form that is no longer accepted for processing as of 11/30/13."},{"id":11,"label":"Temporary retail permit was received with an outdated main application."},{"id":12,"label":"The corporate change filed under this serial number is a duplicate of a corporate change filed on _______________under _________________________________, serial number __________."}],"toFields":[{"id":5,"label":"An insufficient fee was submitted with the application.  Total fee due was $___ and the total fee paid was $_____"}],"isRewritable":true,"rewriteLabel":"Edit Reason for Disapproval:","additionalComments":"Test Automation Disapproval","srclabel":"Select","dstlabel":"Add to Notification","additionalLabel":"Additional Reasons for Disapproval:"},"disapprovalReason":[5,-1],"descriptions":["An insufficient fee was submitted with the application.  Total fee due was $___ and the total fee paid was $_____","Test Automation Disapproval"]}}
    * def payloadmultiple = {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"isChainRestaurant":false,"appId":'#(appId)',"applicationType":1,"applicationId":'#(ApplicationId)',"legalName":'#(legalName)',"statusId":3,"decisionType":{"name":"Approved","value":1},"emailNotificationModel":{"applicant":{"communicationId":9854,"email":"automation@svam.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}},"hasErrors":[],"licPermitTypeId":'#(mainLicensePermitTypeId)',"taskId":1151,"newComments":"","approval":{"isDefineStipulations":true,"selectInput":{"fromFields":[],"toFields":[{"id":1,"label":"Inside of premises closes at x"},{"id":2,"label":"Side walk café closes at x"},{"id":3,"label":"Backyard closes at x"},{"id":4,"label":"Alcohol consumption inside stops at X"},{"id":5,"label":"Alcohol consumption in backyard stops at x"},{"id":6,"label":"Alcohol consumption on sidewalk café stops at x"},{"id":7,"label":"No live music in inside of premises"},{"id":8,"label":"No live music outside of premise"},{"id":9,"label":"No DJs"},{"id":10,"label":"No promoters"},{"id":11,"label":"No Promoted events"},{"id":12,"label":"Recorded music only"},{"id":13,"label":"Music stops at X"},{"id":14,"label":"Music outside stops at X"},{"id":15,"label":"Only non-amplified music"},{"id":16,"label":"Acoustic music only"},{"id":17,"label":"No bar crawls"},{"id":18,"label":"Close façade doors at certain time"},{"id":19,"label":"Close Windows at a certain time"},{"id":20,"label":"No boozy brunches"},{"id":21,"label":"No unlimited drink"},{"id":22,"label":"No happy Hours"},{"id":23,"label":"No bottle service "},{"id":24,"label":"No dancing"},{"id":25,"label":"No delivery bikes"},{"id":26,"label":"No TVs"},{"id":27,"label":"Licensed patio"},{"id":28,"label":"Licensed sidewalk café"},{"id":29,"label":"No outside areas"},{"id":30,"label":"Security Guards required"},{"id":31,"label":"X amount of security guards per x amount of patrons"},{"id":32,"label":"# of security guards per patron"},{"id":33,"label":"No VIP"},{"id":34,"label":"No roped lines"},{"id":35,"label":"No hookah"},{"id":36,"label":"Doors closed at all times"},{"id":37,"label":"Windows closed at all time"},{"id":38,"label":"All agreed upon CB stipulations except"},{"id":39,"label":"All employees must be TIPS trained"},{"id":40,"label":"ABC"}],"isRewritable":true,"rewriteLabel":"Edit Stipulation:","additionalComments":"","srclabel":"Select Stipulations","dstlabel":"Add to Certificate","additionalLabel":"Add Additional Stipulations:"},"effectiveDate":'#(currentDate)',"expirationDate":'#(expiryDate)',"stipulations":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40],"descriptions":["Inside of premises closes at x","Side walk café closes at x","Backyard closes at x","Alcohol consumption inside stops at X","Alcohol consumption in backyard stops at x","Alcohol consumption on sidewalk café stops at x","No live music in inside of premises","No live music outside of premise","No DJs","No promoters","No Promoted events","Recorded music only","Music stops at X","Music outside stops at X","Only non-amplified music","Acoustic music only","No bar crawls","Close façade doors at certain time","Close Windows at a certain time","No boozy brunches","No unlimited drink","No happy Hours","No bottle service ","No dancing","No delivery bikes","No TVs","Licensed patio","Licensed sidewalk café","No outside areas","Security Guards required","X amount of security guards per x amount of patrons","# of security guards per patron","No VIP","No roped lines","No hookah","Doors closed at all times","Windows closed at all time","All agreed upon CB stipulations except","All employees must be TIPS trained","ABC"]}}
    * def payloadDisapproveCounsel = {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"isChainRestaurant":false,"appId":'#(appId)',"applicationType":1,"applicationId":'#(ApplicationId)',"legalName":'#(legalName)',"statusId":3,"decisionType":{"name":"Disapproval to Counsel","value":3},"emailNotificationModel":{"applicant":{"communicationId":6508,"email":"automation@test.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":0,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}},"hasErrors":[],"licPermitTypeId":'#(mainLicensePermitTypeId)',"taskId":1601,"newComments":"","disApproval":{"isDisapprovalForCause":true,"isDisapprovalLetterAttach":true,"selectInput":{"fromFields":[{"id":1,"label":"A temporary permit may not be considered for approval unless it is preceded or accompanied by an application for a permanent license."},{"id":2,"label":"A temporary permit for a New York City premises may not be considered for approval, unless a contract of sale is submitted with the application.  No contract of sale was submitted for this transaction."},{"id":3,"label":"A liquidator’s permit may not be considered for approval when the application it is filed in conjunction with is disapproved."},{"id":4,"label":"A liquidator’s permit may not be approved when the seller of the alcohol is currently in arrears and on the Authority’s COD List.  The seller will need to clear all accounts in arrears and re-apply."},{"id":6,"label":"Check number ____ in the amount of ________ , for payment in connection with this application was returned due to insufficient funds.  A request for certified funds was sent to the applicant on _________, to which there was no reply."},{"id":7,"label":"Licensees are not eligible to change corporate entities using an endorsement/corporate change application.  A licensee forming a new entity and using a new FEIN# must file a new application under the new corporate entity."},{"id":8,"label":"Endorsement applications may not be used to change an application from an executor of an estate to a corporation.  A new application must be filed once the estate is settled."},{"id":9,"label":"Licensee is not eligible to file a removal under a new corporate entity.  Licensee must file a new application for the new corporate entity with the new FEIN #."},{"id":10,"label":"The applicant submitted an outdated application form that is no longer accepted for processing as of 11/30/13."},{"id":11,"label":"Temporary retail permit was received with an outdated main application."},{"id":12,"label":"The corporate change filed under this serial number is a duplicate of a corporate change filed on _______________under _________________________________, serial number __________."}],"toFields":[{"id":5,"label":"An insufficient fee was submitted with the application.  Total fee due was $___ and the total fee paid was $_____"}],"isRewritable":true,"rewriteLabel":"Edit Reason for Disapproval:","additionalComments":"Disapproval  to counsel Test","srclabel":"Select","dstlabel":"Add to Notification","additionalLabel":"Additional Reasons for Disapproval:"},"disapprovalReason":[5,-1],"descriptions":["An insufficient fee was submitted with the application.  Total fee due was $___ and the total fee paid was $_____","Disapproval  to counsel Test"]}}
    
    * def payloadDisapproveCounsel1 = {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"isChainRestaurant":false,"appId":'#(appId)',"applicationType":1,"applicationId":'#(ApplicationId)',"legalName":'#(legalName)',"statusId":3,"decisionType":{"name":"Disapproval to Counsel","value":3},"emailNotificationModel":{"applicant":{"communicationId":6508,"email":"automation@test.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":0,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}},"hasErrors":[],"licPermitTypeId":'#(mainLicensePermitTypeId)',"taskId":1601,"newComments":"Test Automation for DisapprvalToCaousel","disApproval":{"isDisapprovalForCause":false,"isDisapprovalLetterAttach":true,"selectInput":{"fromFields":[{"id":1,"label":"A temporary permit may not be considered for approval unless it is preceded or accompanied by an application for a permanent license."},{"id":2,"label":"A temporary permit for a New York City premises may not be considered for approval, unless a contract of sale is submitted with the application.  No contract of sale was submitted for this transaction."},{"id":3,"label":"A liquidator’s permit may not be considered for approval when the application it is filed in conjunction with is disapproved."},{"id":4,"label":"A liquidator’s permit may not be approved when the seller of the alcohol is currently in arrears and on the Authority’s COD List.  The seller will need to clear all accounts in arrears and re-apply."},{"id":6,"label":"Check number ____ in the amount of ________ , for payment in connection with this application was returned due to insufficient funds.  A request for certified funds was sent to the applicant on _________, to which there was no reply."},{"id":7,"label":"Licensees are not eligible to change corporate entities using an endorsement/corporate change application.  A licensee forming a new entity and using a new FEIN# must file a new application under the new corporate entity."},{"id":8,"label":"Endorsement applications may not be used to change an application from an executor of an estate to a corporation.  A new application must be filed once the estate is settled."},{"id":9,"label":"Licensee is not eligible to file a removal under a new corporate entity.  Licensee must file a new application for the new corporate entity with the new FEIN #."},{"id":10,"label":"The applicant submitted an outdated application form that is no longer accepted for processing as of 11/30/13."},{"id":11,"label":"Temporary retail permit was received with an outdated main application."},{"id":12,"label":"The corporate change filed under this serial number is a duplicate of a corporate change filed on _______________under _________________________________, serial number __________."}],"toFields":[{"id":5,"label":"An insufficient fee was submitted with the application.  Total fee due was $___ and the total fee paid was $_____"}],"isRewritable":true,"rewriteLabel":"Edit Reason for Disapproval:","additionalComments":"Disapproval  to counsel Test","srclabel":"Select","dstlabel":"Add to Notification","additionalLabel":"Additional Reasons for Disapproval:"},"disapprovalReason":[5,-1],"descriptions":["An insufficient fee was submitted with the application.  Total fee due was $___ and the total fee paid was $_____","Disapproval  to counsel Test"]}} 
     								  
     * eval if (checboxDisapprovalCause == false && StipulationsCount == 1 && licStatus == 'Disapproved') payload = payloadDisapprovalUncheckbox
     * eval if (StipulationsCount == 0 && licStatus == 'Withdrawal') payload = payloadForwithdraw
     * eval if (StipulationsCount == 0 && licStatus == 'Approved') payload = payloadWithApproval
      * eval if (StipulationsCount == 0 && licStatus == 'FB Decision Required') payload = payloadForFBDecisionReq
    * eval if (checboxDisapprovalCause == true && StipulationsCount == 1 && licStatus == 'Disapproved') payload = payloadDisapprovalWithSingle
    * eval if (StipulationsCount > 1 && licStatus == 'Disapproved') payload = payloadmultiple
 	* eval if (checboxDisapprovalCause == true && StipulationsCount == 1 && licStatus == 'Disapproval to Counsel') payload = payloadDisapproveCounsel
 	* eval if (checboxDisapprovalCause == false && StipulationsCount == 1 && licStatus == 'Disapproval to Counsel') payload = payloadDisapproveCounsel1
   # * eval if (licStatus == 'Conditionally Approved') payload = payloadWithConditionalApprove
    * eval if (licStatus == 'Return to Examiner') payload = payloadWithReturnToExaminer
    And request payload
    When method post
    Then status 200
    And def serverResponse = response
   
          
  # ********* GET License Id *********************  
  
    Given path '/internalapi/api/licensing/LBDecision/getLicenseByAppId/' + appId +'/-1'
    And header authorization = 'Bearer ' + strToken
    And request {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"masterFileData":[],"combinedCraftData":[],"appId":'#(appId)',"applicationType":1,"applicationId":'#(ApplicationId)',"legalName":null,"statusId":3,"decisionType":{"name":"Approved","value":1},"emailNotificationModel":{"applicant":{},"attorney":{},"other":{"email":""}},"hasErrors":[],"taskId":1151,"newComments":"","approval":{"isDefineStipulations":false,"selectInput":{"fromFields":[{"id":1,"label":"Inside of premises closes at x"},{"id":2,"label":"Side walk café closes at x"},{"id":3,"label":"Backyard closes at x"},{"id":4,"label":"Alcohol consumption inside stops at X"},{"id":5,"label":"Alcohol consumption in backyard stops at x"},{"id":6,"label":"Alcohol consumption on sidewalk café stops at x"},{"id":7,"label":"No live music in inside of premises"},{"id":8,"label":"No live music outside of premise"},{"id":9,"label":"No DJs"},{"id":10,"label":"No promoters"},{"id":11,"label":"No Promoted events"},{"id":12,"label":"Recorded music only"},{"id":13,"label":"Music stops at X"},{"id":14,"label":"Music outside stops at X"},{"id":15,"label":"Only non-amplified music"},{"id":16,"label":"Acoustic music only"},{"id":17,"label":"No bar crawls"},{"id":18,"label":"Close façade doors at certain time"},{"id":19,"label":"Close Windows at a certain time"},{"id":20,"label":"No boozy brunches"},{"id":21,"label":"No unlimited drink"},{"id":22,"label":"No happy Hours"},{"id":23,"label":"No bottle service "},{"id":24,"label":"No dancing"},{"id":25,"label":"No delivery bikes"},{"id":26,"label":"No TVs"},{"id":27,"label":"Licensed patio"},{"id":28,"label":"Licensed sidewalk café"},{"id":29,"label":"No outside areas"},{"id":30,"label":"Security Guards required"},{"id":31,"label":"X amount of security guards per x amount of patrons"},{"id":32,"label":"# of security guards per patron"},{"id":33,"label":"No VIP"},{"id":34,"label":"No roped lines"},{"id":35,"label":"No hookah"},{"id":36,"label":"Doors closed at all times"},{"id":37,"label":"Windows closed at all time"},{"id":38,"label":"All agreed upon CB stipulations except"},{"id":39,"label":"All employees must be TIPS trained"}],"toFields":[],"isRewritable":true,"rewriteLabel":"Edit Stipulation:","srclabel":"Select Stipulations","dstlabel":"Add to Certificate","additionalLabel":"Add Additional Stipulations:"},"effectiveDate":"2022-01-10","expirationDate":"2022-08-31","stipulations":[],"descriptions":[]}}
    When method get
    Then status 200
    And def serverResponse = response
   
    And def licId = serverResponse.license.licId
    And def licenseId = serverResponse.license.licenseId
    
    And print 'licId : ' , licId
    And print 'licenseId : ' , licenseId
    And match licId != []
    And match licenseId != []
    * def appendAppID = db.appendStrToFile('PermitAPPIds.csv' , ('\n'+appId+','+licenseId))
  
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
		  
		  
		
	* def formatedSumbitDate = summisionDate()
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
		    And def formVersionId = response.formVersionId
		  And print formVersionId
		   And def formId = response.formId
		  And print formId
		   And def legalName = response.legalName
		  And print legalName
		  And def submitDate = response.submitDate
		  And print submitDate
		   And def modifiedDate = response.modifiedDate
		  And print modifiedDate
		 
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
		  And def licenseDescription = response.licenseDescription
		  And print licenseDescription
		  
    
 	Given path '/internalapi/api/licensing/examiner-review/SaveNewPermit'
    
    	* def formatedSumbitDate = summisionDate()
	    And header authorization = 'Bearer ' + strToken
	    And header current-wfroleid = 4
	    And request {"isFingerPrintsApproved":true,"isFingerPrintsRequired":false,"isCorpLLCDissolved":false,"isCorpLLCDTaken":false,"isSendPDLetter":false,"isDisable500LB_FBPT":false,"isDisableLBForPD":false,"isDisableLBForCaseClosed":false,"isDisableLateRenewalAndUnderpayment":false,"isLiquidatorPermitHasCompleted":-1,"isSubmit":true,"fieldDeficiencies":[],"masterFileData":[],"combinedCraftData":[],"application":{"applicationCategory":5,"appId":'#(appId)',"applicationId":'#(ApplicationId)',"licePermitTypeId":null,"applicationTypeId":1,"formVersionId":'#(formVersionId)',"formId":'#(formId)',"legalName":'#(legalName)',"submitDate":'#(formatedSumbitDate)',"isGISRequired":null,"licenseDescription":'#(description)',"recommendedDecisionId":null,"status500":null,"isApplicableForPDLetter":false,"countyName":'#(CityName)',"priority":"Normal","expirationDate":null,"appStatusId":2,"taskStatus":"Awaiting Review","taskId":1526,"currentWfstatus":null,"communityBoard":null,"isLicenseApplication":false,"currentDueDate":null,"isFinalDeficiency":null,"isHighlyDeficient":null,"isAllDeficienciesMet":null,"pastDueDate":null,"memo":null,"isOneTimePermit":null,"dueDateAction":null,"isDisapprovedForCause":false,"isNotQualified":false,"eventDate":null,"appStatus":{"appStatusId":2,"statusDescription":"IntakeComplete","isActive":true,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"applicationType":null,"assignAppExaminer":{"appExaminerId":'#(appExaminerId)',"appId":'#(appId)',"examinerId":1069,"name":null,"assignDate":'#(formatedSumbitDate)',"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"assignAppToLB":null,"licePermitType":{"licPermitTypeId":'#(mainLicensePermitTypeId)',"type":"2","category":"5","product":'#(productName)',"class":null,"description":null,"sectionOfLaw":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null,"isTempPermit":false,"isELicensingPermit":true,"isAdditionalBar":false},"assoApplicationList":[],"isTempPermit":null,"isTempOrLiq":false,"licPermitTypeId":'#(mainLicensePermitTypeId)',"isAssociatedLicense":null,"effectiveDate":null,"assignedUserId":null,"amendmentTypeId":null,"amendmentType":null,"disapprovedDate":null,"condApprovedDate":null,"addressId":null,"isCaseOpen":null,"isClosed":null,"isCaseOpenSameAddress":null,"isSpecialEventPlusFour":null,"isSpecialEventInsideFiveBoroughs":null,"licStatus":null,"createdBy":null,"licenseId":null,"address":null,"isNybeApp":true,"isHearingCompleted":null,"does500FtHearingExist":null,"parentAppStatus":null,"premisesAppCount":0,"statusDescription":null,"eventAddress":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskRoleId":0,"taskDecision":null,"isActive":true,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":'#(formatedSumbitDate)'},"appId":'#(appId)',"notificationTypeId":2028,"applicationType":1,"decisionType":{"name":"Send to Full Board Preview Team","value":3},"emailNotificationModel":{"applicant":{},"attorney":{},"communityBoard":{},"other":{}},"hasErrors":[],"taskId":1526,"newComments":"Test Comment","recommendedDecisionId":null}
	    When method post
	    Then status 200
   		* match response == 'true'
	    * call read('LicensesCommonMethods.feature@checkApplicationStatus') {} 


@ExaminerReviewApprovalToDefineDeficiencies
Scenario: ExaminerReviewApprovalToDefineDeficiencies  
 # ********* Examiner Review Approval to FBPTQueue *********************
	 * def summisionDate =
		"""
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } """
		  
		  
		
	* def formatedSumbitDate = summisionDate()
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
		    And def formVersionId = response.formVersionId
		  And print formVersionId
		   And def formId = response.formId
		  And print formId
		   And def legalName = response.legalName
		  And print legalName
		  And def submitDate = response.submitDate
		  And print submitDate
		   And def modifiedDate = response.modifiedDate
		  And print modifiedDate
		 
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
		  And def licenseDescription = response.licenseDescription
		  And print licenseDescription
		  
    
 	Given path '/internalapi/api/licensing/examiner-review/SaveNewPermit'
    
    	* def formatedSumbitDate = summisionDate()
	    And header authorization = 'Bearer ' + strToken
	    And header current-wfroleid = 4
	    And request {"isFingerPrintsApproved":true,"isFingerPrintsRequired":false,"isCorpLLCDissolved":false,"isCorpLLCDTaken":false,"isSendPDLetter":false,"isDisable500LB_FBPT":false,"isDisableLBForPD":false,"isDisableLBForCaseClosed":false,"isDisableLateRenewalAndUnderpayment":false,"isLiquidatorPermitHasCompleted":-1,"isSubmit":true,"fieldDeficiencies":[],"masterFileData":[],"combinedCraftData":[],"application":{"applicationCategory":6,"appId":'#(appId)',"applicationId":'#(ApplicationId)',"licePermitTypeId":null,"applicationTypeId":1,"formVersionId":'#(formVersionId)',"formId":'#(formId)',"legalName":'#(legalName)',"submitDate":'#(formatedSumbitDate)',"isGISRequired":null,"licenseDescription":'#(description)',"recommendedDecisionId":null,"status500":null,"isApplicableForPDLetter":false,"countyName":'#(CityName)',"priority":"Normal","expirationDate":null,"appStatusId":2,"taskStatus":"Awaiting Review","taskId":1526,"currentWfstatus":null,"communityBoard":null,"isLicenseApplication":false,"currentDueDate":null,"isFinalDeficiency":null,"isHighlyDeficient":null,"isAllDeficienciesMet":null,"pastDueDate":null,"memo":null,"isOneTimePermit":false,"dueDateAction":null,"isDisapprovedForCause":false,"isNotQualified":false,"eventDate":null,"appStatus":{"appStatusId":2,"statusDescription":"IntakeComplete","isActive":true,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"applicationType":null,"assignAppExaminer":{"appExaminerId":'#(appExaminerId)',"appId":'#(appId)',"examinerId":1069,"name":null,"assignDate":'#(formatedSumbitDate)',"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"assignAppToLB":null,"licePermitType":{"licPermitTypeId":'#(mainLicensePermitTypeId)',"type":"2","category":"6","product":'#(productName)',"class":null,"description":null,"sectionOfLaw":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null,"isTempPermit":false,"isELicensingPermit":true,"isAdditionalBar":false},"assoApplicationList":[],"isTempPermit":null,"isTempOrLiq":false,"licPermitTypeId":'#(mainLicensePermitTypeId)',"isAssociatedLicense":null,"effectiveDate":null,"assignedUserId":null,"amendmentTypeId":null,"amendmentType":null,"disapprovedDate":null,"condApprovedDate":null,"addressId":null,"isCaseOpen":null,"isClosed":null,"isCaseOpenSameAddress":null,"isSpecialEventPlusFour":null,"isSpecialEventInsideFiveBoroughs":null,"licStatus":null,"createdBy":null,"licenseId":null,"address":null,"isNybeApp":true,"isHearingCompleted":null,"does500FtHearingExist":null,"parentAppStatus":null,"premisesAppCount":0,"statusDescription":null,"eventAddress":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskRoleId":0,"taskDecision":null,"isActive":true,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":'#(formatedSumbitDate)'},"appId":'#(appId)',"notificationTypeId":2028,"applicationType":1,"decisionType":{"name":"Define Deficiencies","value":1},"emailNotificationModel":{"applicant":{"communicationId":4120,"email":"vdsouza@svam.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":4122,"email":"vdsouza@svam.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"automation@test.com","appId":'#(appId)',"emailContactTypeId":0,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"notificationTypeId":2028,"isInstantEmail":false},"hasErrors":[],"taskId":1526,"newComments":"","erDeficiencies":{"selectInput":{"fromFields":[{"id":4,"label":"As the applicant is a corporation, LLC or LLP, the applicant name must be the same as the name on the filing receipt."},{"id":5,"label":"Submit a copy of the Secretary of State filing receipt for the corp/LLC/LLP"},{"id":6,"label":"Provide a copy of the corporate minutes for the applicant entity"},{"id":7,"label":"Provide a copy of the LLC operating agreement for the applicant entity"},{"id":8,"label":"Provide a clear organizational chart for the applicant entity.  Each holding corporation should be listed.  All principals of each entity should be listed along with their percentage of ownership."},{"id":9,"label":"Premises address does not match the address listed on lease."},{"id":10,"label":"Premises address does not match the address listed on the bill of sale."},{"id":11,"label":"Premises address does not match the address listed on the deed."},{"id":12,"label":"Premises address must be written the same on all documents and must be the physical location of the premises (not the mailing address)."},{"id":13,"label":"Submit a Notice of Appearance or the attorney or representative."},{"id":14,"label":"Entity owning real property does not match applicant name – A lease between the two parties is required and must be submitted.  "},{"id":15,"label":"The lease must run the full term of the license period (please take processing time into consideration when determining the end date of the lease).  Provide either a new lease document or an amendment/rider to the existing one (signed by both landlord and tenant).  "},{"id":16,"label":"Landlord name must be the name shown on the deed."},{"id":17,"label":"All principals of the landlord entity must be listed."},{"id":18,"label":"To verify ownership, submit a copy of the deed."},{"id":19,"label":"The source of ALL funds (cash and borrowed) must be listed on this form."},{"id":20,"label":"Submit financial documentation proving the availability of the funds listed.  You must submit 3 consecutive months-worth of statements from checking or savings accounts showing the availability of the funds at the time they were expended."},{"id":21,"label":"Submit a copy of all executed loan agreements.  "},{"id":22,"label":"Provide the name and address of all on premises liquor establishments located within 500 feet of your establishment."},{"id":23,"label":"Provide a statement addressing why you believe it would be in the public's interest to issue this license."},{"id":24,"label":"Please complete the Statement of Area Plan form"},{"id":25,"label":"Provide a personal questionnaire for __________________."},{"id":26,"label":"Please list gender on _________'s personal questionnaire."},{"id":27,"label":"Provide residence addresses for the last 5 consecutive years."},{"id":28,"label":"Provide employment information for the last 5 consecutive years.  If unemployed for any period of time during the past 5 years, that must also be reflected."},{"id":29,"label":"________________ has/had license history with the Authority.  Amend question five to reflect all license history."},{"id":30,"label":"The Department of Criminal Justice Services has advised us that ________________________ has a conviction record. Amend question 6b to reflect the correct answer and provide a signed statement as to why the question was originally answered no.  Submit a Certificate of Disposition for all arrests and convictions. If convicted of a felony, you must submit a Certificate of Relief from Disabilities."},{"id":31,"label":"Amend the diagram labeling all rooms and bars"},{"id":32,"label":"Amend the diagram to include the food prep area"},{"id":33,"label":"Provide a diagram of the basement"},{"id":34,"label":"Provide a block plot diagram"},{"id":35,"label":"Add the outside area to the diagram "},{"id":36,"label":"Submit color photos of the interior of the premises including all dining areas, the bar and at least one of the kitchen.  Place the serial number on the back of each photo."},{"id":37,"label":"Submit one color photo of the front exterior of the premises.  Place the serial number on the back of the photo."},{"id":38,"label":"Submit color photos of any outside area (deck, patio, yard) to be licensed.  The photos must show how the area is contained (fencing, shrubbery, roping off).  Place the serial number on the back of the photos."},{"id":39,"label":"Provide a color photo of the applicant (no smaller than passport size) for _______________."},{"id":40,"label":"Provide a copy of ____________'s photo identification."},{"id":41,"label":"Submit a copy of the menu."},{"id":42,"label":"Provide proof of citizenship for _________________."},{"id":43,"label":"You have listed 1 restroom.  The Rules of the State Liquor Authority require 2 separate restrooms for both sexes.  Please submit a request to the Authority asking for a waiver of the 2-restroom rule.  You must explain why you believe one restroom is sufficient for the operation of your establishment."},{"id":44,"label":"Submit a copy of the maximum occupancy certificate."},{"id":45,"label":"______________________ needs to be fingerprinted. "},{"id":123,"label":"Additional Funds Required"},{"id":129,"label":"Provide a copy of the Assumed Name Certificate from the Secretary of State for your corporation/LLC's dba name."},{"id":130,"label":"Provide a copy of the business certificate from the county clerk for your dba name."},{"id":131,"label":"Provide your federal tax identification number."},{"id":132,"label":"Provide a copy of your Certificate of Authority from the New York State Tax Department."},{"id":133,"label":"Provide an amended Certificate of Authority – the name must match the applicant name exactly."},{"id":134,"label":"Provide an amended Certificate of Authority – the address must match the premises address exactly."},{"id":135,"label":"Provide a signed Bond Rider amending _______."},{"id":136,"label":"Provide Worker's Compensation and Disability Benefits insurance provider names and policy numbers."},{"id":137,"label":"Provide an inventory of the alcoholic beverages you will be purchasing from the current licensee."},{"id":138,"label":"Submit a copy of the Newspaper Affidavit(s)."},{"id":139,"label":"Provide your TTB permit."},{"id":140,"label":"Surrender of the current license in effect."},{"id":141,"label":"Make the edits listed below to the curriculum."},{"id":142,"label":"The submitted Curriculum generally covers the required topics. However,  the below changes must be made to ensure that the persons taking the course understand their rights, obligations, and liabilities under New York law."},{"id":143,"label":"The licensee's and server's responsibility to not sell, deliver or give alcohol to someone under the age of 21 (ABC Law 65)."},{"id":144,"label":"The licensee's and server's responsibility when serving more than one drink to an individual to be aware of any redelivery by the legal patron (on-premises only)."},{"id":145,"label":"The licensee's and server's responsibility to reasonably supervise the premises."},{"id":146,"label":"The licensee's and server's right to refuse to sell, including but not limited to, an underage patron, an intoxicated patron, or a patron without proper identification."},{"id":147,"label":"The licensee's and server's burden to establish that a delivery of alcohol was made in a reasonable reliance upon written evidence of age."},{"id":148,"label":"The forms of identification which may be legally accepted as written evidence of age (ABC Law 65-b.2)."},{"id":149,"label":"Key features of the valid forms of identification and the way false and fraudulent forms of identification may be detected."},{"id":150,"label":"Devices and manuals which may be used to aid in the detection of false and fraudulent written evidence of age, and information regarding the way such devises and manuals may be obtained."},{"id":151,"label":"The criminal liabilities and penalties for both the individual and the establishment for unlawfully dealing with a child (Penal Law 260.20)."},{"id":152,"label":"The civil liabilities, general liabilities, responsibilities and general obligations (General Obligations Law 11-100 and 11-101)."},{"id":153,"label":"Firsthand accounts from the public illustrating the consequences of the failure of licensees and/or servers to operate in a safe, legal and responsible manner. (i.e., MADD, RID, and Shattered Lives)."},{"id":154,"label":"Provide the New York State Liquor Authority with access to the online course for review."},{"id":155,"label":"Remove the following content from the applicants' website:"},{"id":156,"label":"Provide the legal name of the applicant."},{"id":157,"label":"Provide the mailing address of the applicant."},{"id":158,"label":"Provide the federal id number of the applicant."},{"id":159,"label":"Provide the applicant's contact phone number."},{"id":160,"label":"Provide the applicant's email address."},{"id":161,"label":"Provide the director's name."},{"id":162,"label":"Provide the director's phone number."},{"id":163,"label":"Provide the director's email address."},{"id":164,"label":"Designate the format of the course. The Alcoholic Beverage Control Law states that the course be taught via online, classroom, or distance learning. An ATAP course can be offered in multiple formats."}],"toFields":[{"id":-1,"label":"As the applicant is a corporation, LLC or LLP, the applicant name must be the same as the name on the filing receipt.","originalId":4}],"isRewritable":true,"rewriteLabel":"Edit Deficiency:","additionalComments":"Test Automation for Define Deficiency","srclabel":"Select Deficiencies","dstlabel":"Add to Notification","additionalLabel":"Add Additional Deficiencies:"}}}
	    When method post
	    Then status 200
   		* match response == 'true'
	    * call read('LicensesCommonMethods.feature@checkApplicationStatus') {} 

@ExaminerReviewApprovalToDefineWithAllDeficiencies
Scenario: ExaminerReviewApprovalToDefineWithAllDeficiencies  
 # ********* Examiner Review Approval to DefineWithAllDeficiencies *********************
	 * def summisionDate =
		"""
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } """
		  
		  
		
	* def formatedSumbitDate = summisionDate()
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
		    And def formVersionId = response.formVersionId
		  And print formVersionId
		   And def formId = response.formId
		  And print formId
		   And def legalName = response.legalName
		  And print legalName
		  And def submitDate = response.submitDate
		  And print submitDate
		   And def modifiedDate = response.modifiedDate
		  And print modifiedDate
		 
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
		  And def licenseDescription = response.licenseDescription
		  And print licenseDescription
		  
    
 	Given path '/internalapi/api/licensing/examiner-review/SaveNewPermit'
    
    	* def formatedSumbitDate = summisionDate()
	    And header authorization = 'Bearer ' + strToken
	    And header current-wfroleid = 4
	    And request {"isFingerPrintsApproved":true,"isFingerPrintsRequired":true,"isCorpLLCDissolved":false,"isCorpLLCDTaken":false,"isSendPDLetter":false,"isDisable500LB_FBPT":false,"isDisableLBForPD":false,"isDisableLBForCaseClosed":false,"isDisableLateRenewalAndUnderpayment":false,"isLiquidatorPermitHasCompleted":-1,"isSubmit":true,"fieldDeficiencies":[],"masterFileData":[],"combinedCraftData":[],"application":{"applicationCategory":6,"appId":'#(appId)',"applicationId":'#(ApplicationId)',"licePermitTypeId":null,"applicationTypeId":1,"formVersionId":'#(formVersionId)',"formId":'#(formId)',"legalName":'#(legalName)',"submitDate":'#(formatedSumbitDate)',"isGISRequired":null,"licenseDescription":'#(description)',"recommendedDecisionId":null,"status500":null,"isApplicableForPDLetter":false,"countyName":'#(CityName)',"priority":"Normal","expirationDate":null,"appStatusId":2,"taskStatus":"Awaiting Review","taskId":1526,"currentWfstatus":null,"communityBoard":null,"isLicenseApplication":false,"currentDueDate":null,"isFinalDeficiency":null,"isHighlyDeficient":false,"isAllDeficienciesMet":null,"pastDueDate":null,"memo":null,"isOneTimePermit":true,"dueDateAction":null,"isDisapprovedForCause":false,"isNotQualified":false,"eventDate":null,"appStatus":{"appStatusId":2,"statusDescription":"IntakeComplete","isActive":true,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"applicationType":null,"assignAppExaminer":{"appExaminerId":'#(appExaminerId)',"appId":'#(appId)',"examinerId":1069,"name":null,"assignDate":'#(formatedSumbitDate)',"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"assignAppToLB":null,"licePermitType":{"licPermitTypeId":'#(mainLicensePermitTypeId)',"type":"2","category":"6","product":'#(productName)',"class":null,"description":null,"sectionOfLaw":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null,"isTempPermit":false,"isELicensingPermit":true,"isAdditionalBar":false},"assoApplicationList":[],"isTempPermit":null,"isTempOrLiq":false,"licPermitTypeId":'#(mainLicensePermitTypeId)', "isAssociatedLicense":null,"effectiveDate":null,"assignedUserId":null,"amendmentTypeId":null,"amendmentType":null,"disapprovedDate":null,"condApprovedDate":null,"addressId":null,"isCaseOpen":null,"isClosed":null,"isCaseOpenSameAddress":null,"isSpecialEventPlusFour":null,"isSpecialEventInsideFiveBoroughs":null,"licStatus":null,"createdBy":null,"licenseId":null,"address":null,"isNybeApp":false,"isHearingCompleted":null,"does500FtHearingExist":null,"parentAppStatus":2,"premisesAppCount":0,"statusDescription":null,"eventAddress":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskRoleId":0,"taskDecision":null,"isActive":true,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":'#(formatedSumbitDate)'},"appId":'#(appId)',"notificationTypeId":2028,"applicationType":1,"decisionType":{"name":"Define Deficiencies","value":1},"emailNotificationModel":{"applicant":{"communicationId":3628,"email":"PRawool@svam.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":4720,"email":"PRawool@svam.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"notificationTypeId":2028,"isInstantEmail":false},"hasErrors":[],"taskId":1526,"erDeficiencies":{"selectInput":{"fromFields":[{"id":4,"label":"As the applicant is a corporation, LLC or LLP, the applicant name must be the same as the name on the filing receipt."},{"id":5,"label":"Submit a copy of the Secretary of State filing receipt for the corp/LLC/LLP"},{"id":6,"label":"Provide a copy of the corporate minutes for the applicant entity"},{"id":7,"label":"Provide a copy of the LLC operating agreement for the applicant entity"},{"id":8,"label":"Provide a clear organizational chart for the applicant entity.  Each holding corporation should be listed.  All principals of each entity should be listed along with their percentage of ownership."},{"id":9,"label":"Premises address does not match the address listed on lease."},{"id":10,"label":"Premises address does not match the address listed on the bill of sale."},{"id":11,"label":"Premises address does not match the address listed on the deed."},{"id":12,"label":"Premises address must be written the same on all documents and must be the physical location of the premises (not the mailing address)."},{"id":13,"label":"Submit a Notice of Appearance or the attorney or representative."},{"id":14,"label":"Entity owning real property does not match applicant name – A lease between the two parties is required and must be submitted.  "},{"id":15,"label":"The lease must run the full term of the license period (please take processing time into consideration when determining the end date of the lease).  Provide either a new lease document or an amendment/rider to the existing one (signed by both landlord and tenant).  "},{"id":16,"label":"Landlord name must be the name shown on the deed."},{"id":17,"label":"All principals of the landlord entity must be listed."},{"id":18,"label":"To verify ownership, submit a copy of the deed."},{"id":19,"label":"The source of ALL funds (cash and borrowed) must be listed on this form."},{"id":20,"label":"Submit financial documentation proving the availability of the funds listed.  You must submit 3 consecutive months-worth of statements from checking or savings accounts showing the availability of the funds at the time they were expended."},{"id":21,"label":"Submit a copy of all executed loan agreements.  "},{"id":22,"label":"Provide the name and address of all on premises liquor establishments located within 500 feet of your establishment."},{"id":23,"label":"Provide a statement addressing why you believe it would be in the public's interest to issue this license."},{"id":24,"label":"Please complete the Statement of Area Plan form"},{"id":25,"label":"Provide a personal questionnaire for __________________."},{"id":26,"label":"Please list gender on _________'s personal questionnaire."},{"id":27,"label":"Provide residence addresses for the last 5 consecutive years."},{"id":28,"label":"Provide employment information for the last 5 consecutive years.  If unemployed for any period of time during the past 5 years, that must also be reflected."},{"id":29,"label":"________________ has/had license history with the Authority.  Amend question five to reflect all license history."},{"id":30,"label":"The Department of Criminal Justice Services has advised us that ________________________ has a conviction record. Amend question 6b to reflect the correct answer and provide a signed statement as to why the question was originally answered no.  Submit a Certificate of Disposition for all arrests and convictions. If convicted of a felony, you must submit a Certificate of Relief from Disabilities."},{"id":31,"label":"Amend the diagram labeling all rooms and bars"},{"id":32,"label":"Amend the diagram to include the food prep area"},{"id":33,"label":"Provide a diagram of the basement"},{"id":34,"label":"Provide a block plot diagram"},{"id":35,"label":"Add the outside area to the diagram "},{"id":36,"label":"Submit color photos of the interior of the premises including all dining areas, the bar and at least one of the kitchen.  Place the serial number on the back of each photo."},{"id":37,"label":"Submit one color photo of the front exterior of the premises.  Place the serial number on the back of the photo."},{"id":38,"label":"Submit color photos of any outside area (deck, patio, yard) to be licensed.  The photos must show how the area is contained (fencing, shrubbery, roping off).  Place the serial number on the back of the photos."},{"id":39,"label":"Provide a color photo of the applicant (no smaller than passport size) for _______________."},{"id":40,"label":"Provide a copy of ____________'s photo identification."},{"id":41,"label":"Submit a copy of the menu."},{"id":42,"label":"Provide proof of citizenship for _________________."},{"id":43,"label":"You have listed 1 restroom.  The Rules of the State Liquor Authority require 2 separate restrooms for both sexes.  Please submit a request to the Authority asking for a waiver of the 2-restroom rule.  You must explain why you believe one restroom is sufficient for the operation of your establishment."},{"id":44,"label":"Submit a copy of the maximum occupancy certificate."},{"id":45,"label":"______________________ needs to be fingerprinted. "},{"id":123,"label":"Additional Funds Required"},{"id":129,"label":"Provide a copy of the Assumed Name Certificate from the Secretary of State for your corporation/LLC's dba name."},{"id":130,"label":"Provide a copy of the business certificate from the county clerk for your dba name."},{"id":131,"label":"Provide your federal tax identification number."},{"id":132,"label":"Provide a copy of your Certificate of Authority from the New York State Tax Department."},{"id":133,"label":"Provide an amended Certificate of Authority – the name must match the applicant name exactly."},{"id":134,"label":"Provide an amended Certificate of Authority – the address must match the premises address exactly."},{"id":135,"label":"Provide a signed Bond Rider amending _______."},{"id":136,"label":"Provide Worker's Compensation and Disability Benefits insurance provider names and policy numbers."},{"id":137,"label":"Provide an inventory of the alcoholic beverages you will be purchasing from the current licensee."},{"id":138,"label":"Submit a copy of the Newspaper Affidavit(s)."},{"id":139,"label":"Provide your TTB permit."},{"id":140,"label":"Surrender of the current license in effect."},{"id":141,"label":"Make the edits listed below to the curriculum."},{"id":142,"label":"The submitted Curriculum generally covers the required topics. However,  the below changes must be made to ensure that the persons taking the course understand their rights, obligations, and liabilities under New York law."},{"id":143,"label":"The licensee's and server's responsibility to not sell, deliver or give alcohol to someone under the age of 21 (ABC Law 65)."},{"id":144,"label":"The licensee's and server's responsibility when serving more than one drink to an individual to be aware of any redelivery by the legal patron (on-premises only)."},{"id":145,"label":"The licensee's and server's responsibility to reasonably supervise the premises."},{"id":146,"label":"The licensee's and server's right to refuse to sell, including but not limited to, an underage patron, an intoxicated patron, or a patron without proper identification."},{"id":147,"label":"The licensee's and server's burden to establish that a delivery of alcohol was made in a reasonable reliance upon written evidence of age."},{"id":148,"label":"The forms of identification which may be legally accepted as written evidence of age (ABC Law 65-b.2)."},{"id":149,"label":"Key features of the valid forms of identification and the way false and fraudulent forms of identification may be detected."},{"id":150,"label":"Devices and manuals which may be used to aid in the detection of false and fraudulent written evidence of age, and information regarding the way such devises and manuals may be obtained."},{"id":151,"label":"The criminal liabilities and penalties for both the individual and the establishment for unlawfully dealing with a child (Penal Law 260.20)."},{"id":152,"label":"The civil liabilities, general liabilities, responsibilities and general obligations (General Obligations Law 11-100 and 11-101)."},{"id":153,"label":"Firsthand accounts from the public illustrating the consequences of the failure of licensees and/or servers to operate in a safe, legal and responsible manner. (i.e., MADD, RID, and Shattered Lives)."},{"id":154,"label":"Provide the New York State Liquor Authority with access to the online course for review."},{"id":155,"label":"Remove the following content from the applicants' website:"},{"id":156,"label":"Provide the legal name of the applicant."},{"id":157,"label":"Provide the mailing address of the applicant."},{"id":158,"label":"Provide the federal id number of the applicant."},{"id":159,"label":"Provide the applicant's contact phone number."},{"id":160,"label":"Provide the applicant's email address."},{"id":161,"label":"Provide the director's name."},{"id":162,"label":"Provide the director's phone number."},{"id":163,"label":"Provide the director's email address."},{"id":164,"label":"Designate the format of the course. The Alcoholic Beverage Control Law states that the course be taught via online, classroom, or distance learning. An ATAP course can be offered in multiple formats."}],"toFields":[{"id":-1,"label":"As the applicant is a corporation, LLC or LLP, the applicant name must be the same as the name on the filing receipt.","originalId":4},{"id":-2,"label":"Submit a copy of the Secretary of State filing receipt for the corp/LLC/LLP","originalId":5},{"id":-3,"label":"Provide a copy of the corporate minutes for the applicant entity","originalId":6},{"id":-4,"label":"Provide a copy of the LLC operating agreement for the applicant entity","originalId":7},{"id":-5,"label":"Provide a clear organizational chart for the applicant entity.  Each holding corporation should be listed.  All principals of each entity should be listed along with their percentage of ownership.","originalId":8},{"id":-6,"label":"Premises address does not match the address listed on lease.","originalId":9},{"id":-7,"label":"Premises address does not match the address listed on the bill of sale.","originalId":10},{"id":-8,"label":"Premises address does not match the address listed on the deed.","originalId":11},{"id":-9,"label":"Premises address must be written the same on all documents and must be the physical location of the premises (not the mailing address).","originalId":12},{"id":-10,"label":"Submit a Notice of Appearance or the attorney or representative.","originalId":13},{"id":-11,"label":"Entity owning real property does not match applicant name – A lease between the two parties is required and must be submitted.  ","originalId":14},{"id":-12,"label":"The lease must run the full term of the license period (please take processing time into consideration when determining the end date of the lease).  Provide either a new lease document or an amendment/rider to the existing one (signed by both landlord and tenant).  ","originalId":15},{"id":-13,"label":"Landlord name must be the name shown on the deed.","originalId":16},{"id":-14,"label":"All principals of the landlord entity must be listed.","originalId":17},{"id":-15,"label":"To verify ownership, submit a copy of the deed.","originalId":18},{"id":-16,"label":"The source of ALL funds (cash and borrowed) must be listed on this form.","originalId":19},{"id":-17,"label":"Submit financial documentation proving the availability of the funds listed.  You must submit 3 consecutive months-worth of statements from checking or savings accounts showing the availability of the funds at the time they were expended.","originalId":20},{"id":-18,"label":"Submit a copy of all executed loan agreements.  ","originalId":21},{"id":-19,"label":"Provide the name and address of all on premises liquor establishments located within 500 feet of your establishment.","originalId":22},{"id":-20,"label":"Provide a statement addressing why you believe it would be in the public's interest to issue this license.","originalId":23},{"id":-21,"label":"Please complete the Statement of Area Plan form","originalId":24},{"id":-22,"label":"Provide a personal questionnaire for __________________.","originalId":25},{"id":-23,"label":"Please list gender on _________'s personal questionnaire.","originalId":26},{"id":-24,"label":"Provide residence addresses for the last 5 consecutive years.","originalId":27},{"id":-25,"label":"Provide employment information for the last 5 consecutive years.  If unemployed for any period of time during the past 5 years, that must also be reflected.","originalId":28},{"id":-26,"label":"________________ has/had license history with the Authority.  Amend question five to reflect all license history.","originalId":29},{"id":-27,"label":"The Department of Criminal Justice Services has advised us that ________________________ has a conviction record. Amend question 6b to reflect the correct answer and provide a signed statement as to why the question was originally answered no.  Submit a Certificate of Disposition for all arrests and convictions. If convicted of a felony, you must submit a Certificate of Relief from Disabilities.","originalId":30},{"id":-28,"label":"Amend the diagram labeling all rooms and bars","originalId":31},{"id":-29,"label":"Amend the diagram to include the food prep area","originalId":32},{"id":-30,"label":"Provide a diagram of the basement","originalId":33},{"id":-31,"label":"Provide a block plot diagram","originalId":34},{"id":-32,"label":"Add the outside area to the diagram ","originalId":35},{"id":-33,"label":"Submit color photos of the interior of the premises including all dining areas, the bar and at least one of the kitchen.  Place the serial number on the back of each photo.","originalId":36},{"id":-34,"label":"Submit one color photo of the front exterior of the premises.  Place the serial number on the back of the photo.","originalId":37},{"id":-35,"label":"Submit color photos of any outside area (deck, patio, yard) to be licensed.  The photos must show how the area is contained (fencing, shrubbery, roping off).  Place the serial number on the back of the photos.","originalId":38},{"id":-36,"label":"Provide a color photo of the applicant (no smaller than passport size) for _______________.","originalId":39},{"id":-37,"label":"Provide a copy of ____________'s photo identification.","originalId":40},{"id":-38,"label":"Submit a copy of the menu.","originalId":41},{"id":-39,"label":"Provide proof of citizenship for _________________.","originalId":42},{"id":-40,"label":"You have listed 1 restroom.  The Rules of the State Liquor Authority require 2 separate restrooms for both sexes.  Please submit a request to the Authority asking for a waiver of the 2-restroom rule.  You must explain why you believe one restroom is sufficient for the operation of your establishment.","originalId":43},{"id":-41,"label":"Submit a copy of the maximum occupancy certificate.","originalId":44},{"id":-42,"label":"______________________ needs to be fingerprinted. ","originalId":45},{"id":-43,"label":"Additional Funds Required","originalId":123},{"id":-44,"label":"Provide a copy of the Assumed Name Certificate from the Secretary of State for your corporation/LLC's dba name.","originalId":129},{"id":-45,"label":"Provide a copy of the business certificate from the county clerk for your dba name.","originalId":130},{"id":-46,"label":"Provide your federal tax identification number.","originalId":131},{"id":-47,"label":"Provide a copy of your Certificate of Authority from the New York State Tax Department.","originalId":132},{"id":-48,"label":"Provide an amended Certificate of Authority – the name must match the applicant name exactly.","originalId":133},{"id":-49,"label":"Provide an amended Certificate of Authority – the address must match the premises address exactly.","originalId":134},{"id":-50,"label":"Provide a signed Bond Rider amending _______.","originalId":135},{"id":-51,"label":"Provide Worker's Compensation and Disability Benefits insurance provider names and policy numbers.","originalId":136},{"id":-52,"label":"Provide an inventory of the alcoholic beverages you will be purchasing from the current licensee.","originalId":137},{"id":-53,"label":"Submit a copy of the Newspaper Affidavit(s).","originalId":138},{"id":-54,"label":"Provide your TTB permit.","originalId":139},{"id":-55,"label":"Surrender of the current license in effect.","originalId":140},{"id":-56,"label":"Make the edits listed below to the curriculum.","originalId":141},{"id":-57,"label":"The submitted Curriculum generally covers the required topics. However,  the below changes must be made to ensure that the persons taking the course understand their rights, obligations, and liabilities under New York law.","originalId":142},{"id":-58,"label":"The licensee's and server's responsibility to not sell, deliver or give alcohol to someone under the age of 21 (ABC Law 65).","originalId":143},{"id":-59,"label":"The licensee's and server's responsibility when serving more than one drink to an individual to be aware of any redelivery by the legal patron (on-premises only).","originalId":144},{"id":-60,"label":"The licensee's and server's responsibility to reasonably supervise the premises.","originalId":145},{"id":-61,"label":"The licensee's and server's right to refuse to sell, including but not limited to, an underage patron, an intoxicated patron, or a patron without proper identification.","originalId":146},{"id":-62,"label":"The licensee's and server's burden to establish that a delivery of alcohol was made in a reasonable reliance upon written evidence of age.","originalId":147},{"id":-63,"label":"The forms of identification which may be legally accepted as written evidence of age (ABC Law 65-b.2).","originalId":148},{"id":-64,"label":"Key features of the valid forms of identification and the way false and fraudulent forms of identification may be detected.","originalId":149},{"id":-65,"label":"Devices and manuals which may be used to aid in the detection of false and fraudulent written evidence of age, and information regarding the way such devises and manuals may be obtained.","originalId":150},{"id":-66,"label":"The criminal liabilities and penalties for both the individual and the establishment for unlawfully dealing with a child (Penal Law 260.20).","originalId":151},{"id":-67,"label":"The civil liabilities, general liabilities, responsibilities and general obligations (General Obligations Law 11-100 and 11-101).","originalId":152},{"id":-68,"label":"Firsthand accounts from the public illustrating the consequences of the failure of licensees and/or servers to operate in a safe, legal and responsible manner. (i.e., MADD, RID, and Shattered Lives).","originalId":153},{"id":-69,"label":"Provide the New York State Liquor Authority with access to the online course for review.","originalId":154},{"id":-70,"label":"Remove the following content from the applicants' website:","originalId":155},{"id":-71,"label":"Provide the legal name of the applicant.","originalId":156},{"id":-72,"label":"Provide the mailing address of the applicant.","originalId":157},{"id":-73,"label":"Provide the federal id number of the applicant.","originalId":158},{"id":-74,"label":"Provide the applicant's contact phone number.","originalId":159},{"id":-75,"label":"Provide the applicant's email address.","originalId":160},{"id":-76,"label":"Provide the director's name.","originalId":161},{"id":-77,"label":"Provide the director's phone number.","originalId":162},{"id":-78,"label":"Provide the director's email address.","originalId":163},{"id":-79,"label":"Designate the format of the course. The Alcoholic Beverage Control Law states that the course be taught via online, classroom, or distance learning. An ATAP course can be offered in multiple formats.","originalId":164}],"isRewritable":true,"rewriteLabel":"Edit Deficiency:","additionalComments":"TestAutomation","srclabel":"Select Deficiencies","dstlabel":"Add to Notification","additionalLabel":"Add Additional Deficiencies:"}},"newComments":"Test Automation"}
	    When method post
	    Then status 200
   		* match response == 'true'
	    * call read('LicensesCommonMethods.feature@checkApplicationStatus') {} 
    
    

    
 @ValidatePermitApplicationStatus
Scenario: ValidatePermitApplicationStatus on Search Page 
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
	  
 @updateCheckData
    Scenario: UpdateCheckData on Fee & bond Page 

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
		And request {"checks":[{"checkDetailId":'#(checkDetailId)',"appId":'#(appId)',"paymentSource":"RDC","checkNo":"33","batchNo":"33","itemNo":"1","slareceivedDate":'#(date)',"slaintakeDate":'#(date)',"amount":'#(amountPaid)',"appliedTo":null,"amountUsed":null,"comment":null,"isReplacement":null,"replacementReason":null,"isActive":true,"createdBy":"tgupta@svam.com","createdDate":'#(date)',"modifiedBy":null,"modifiedDate":null,"applyClick":true},{"checkDetailId":'#(checkDetailId)',"appId":'#(appId)',"paymentSource":"RDC","checkNo":"21","batchNo":"21","itemNo":"1","slareceivedDate":'#(date)',"slaintakeDate":'#(date)',"amount":'#(amountPaid)',"appliedTo":null,"amountUsed":null,"comment":null,"isReplacement":null,"replacementReason":null,"isActive":true,"createdBy":"tgupta@svam.com","createdDate":'#(date)',"modifiedBy":null,"modifiedDate":null,"applyClick":true}],"appFees":{"appFees":[{"licenseName":"All night ","applicationId":"NA-0527-22-03180","applicationTypeId":1,"appFeesId":1370,"appId":'#(appId)',"feesRefId":7147,"initialFees":0,"licensingFees":"51.00","amendmentFees":"0.00","renewalFees":"0.00","totalFees":"61.00","filingFees":"10.00","ancillaryFees":"0.00","isFeesWaived":false,"underPaymentAmount":'#(amountPaid)',"amountReceived":"0.00","waivedComment":null,"isBondReceived":false,"isBondRequired":false,"bondFee":0,"term":1,"termDesc":"1 x","seasonalStartDate":null,"seasonalEndDate":null,"isFeesCountBased":false,"isFeesUnitBased":false,"numOfUnits":0,"paymentDetails":[],"lateFee":0,"isFeesBarPerDay":null}],"isFromReturnedCheck":false,"isBondRequired":false,"bondDetails":null,"isPaymentFailed":false,"isUnderpaid":true,"sendNotification":false,"fundDueDate":"2022-06-21T14:13:52.948Z","emailNotificationDetail":{"applicant":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"}},"notificationDetails":{"applicant":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"},"taskId":null}		When method post
	    Then status 200
	    And print response
	    
@VerifyCheckData
Scenario: VerifyCheckData on Fee & bond Page 
Given path 'internalapi/api/licensing/fees/check-payments/get/'+appId
      And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request ""
	  When method get
	  Then status 200
	  And print response
	  	* def checkNo = response[0].checkNo
	  	* def batchNo = response[0].batchNo
	 	* def amount = response[0].amount
		* def actBondCmpModifiedBy = response[0].modifiedBy
		
@FillAndSaveVehiclesInformationPage
Scenario: FillAndSaveVehiclesInformationPage	  
	* def getDate =
	    """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat('yyyyMMddHHmmss');
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		"""
	
	Given path '/internalapi/api/licensing/app/static/vehicledetails/save/'+appId
      	And header Content-Type = 'application/json; charset=utf-8'
     And header Accept = 'application/json; text/plain;*/*'
       	And header authorization = 'Bearer ' + strToken
  
		* def autoFirstName = firstName + getDate()
		* def legalName1 = autoFirstName + lastName
		
	   	And request {"vehicleDetails":[{"id":0,"vehicleType":null,"vehicleModel":null,"vehicleMake":null,"vehicleVIN":"","vehicleYear":'#(year)',"vehicleNameOwner":'#(lastName)',"vehicleRegName":null,"isNew":true,"isRemoved":false}]}
	   	When method post
	  	Then status 200
	  	
	  	@IntakeTemporaryPermit
  Scenario: IntakeTemporaryPermit
    Given path '/internalapi/api/licensing/selectapptype/savenewpermitapp'
    * def dbSts = db.cleanHeap()
    And header authorization = 'Bearer ' + strToken
    And header Content-Type = 'application/json; charset=utf-8'
    And header Accept = 'application/json; text/plain;*/*'
    And request {"businessType":"","permitType":"Temporary Permit","mainLicenseId":'#(licId)',"tempPermitTypeId":[{"applicationId":'#(licId)',"tempLicensePermitTypeId":'#(mainLicensePermitTypeId)'}],"mainApplicationId":"","associatedLicenseList":[],"isMainTempPermitRequired":true,"newPermitTypeIds":[],"isNotQualified":false,"notQualifiedReason":""}
    
    When method post
    Then status 200
    And def ApplicationId = response[0].mainApplicationId
    And print ApplicationId
    And match ApplicationId contains 'NA-'
    And def description = response[0].description
    And print description
    And def appId = response[0].appId
    * def formId = response[0].formId		
    #* call read('PermitsCommonMethods.feature@ValidateTempPermitAfterIntake') {}
    
    	
@IntakeTemporaryPermitWithCondtionallyApprovedLic
  Scenario: IntakeTemporaryPermitWithCondtionallyApprovedLic
    Given path '/internalapi/api/licensing/selectapptype/savenewpermitapp'
    * def dbSts = db.cleanHeap()
    And header authorization = 'Bearer ' + strToken
    And header Content-Type = 'application/json; charset=utf-8'
    And header Accept = 'application/json; text/plain;*/*'
    And request {"businessType":"","permitType":"Temporary Permit","mainLicenseId":'#(licApplicationId)',"tempPermitTypeId":[{"applicationId":'#(licApplicationId)',"tempLicensePermitTypeId":'#(mainLicensePermitTypeId)'}],"mainApplicationId":"","associatedLicenseList":[],"isMainTempPermitRequired":true,"newPermitTypeIds":[],"isNotQualified":false,"notQualifiedReason":""}
    When method post
    Then status 200
    And def ApplicationId = response[0].mainApplicationId
    And print ApplicationId
    And match ApplicationId contains 'NA-'
    And def description = response[0].description
    And print description
    And def appId = response[0].appId
    * def formId = response[0].formId		
    #* call read('PermitsCommonMethods.feature@ValidateTempPermitAfterIntake') {}
	  	
	@IntakeTemporaryPermitwithoutLic
  Scenario: IntakeTemporaryPermitwithoutLic
    Given path '/internalapi/api/licensing/selectapptype/savenewpermitapp'
    * def dbSts = db.cleanHeap()
    And header authorization = 'Bearer ' + strToken
    And header Content-Type = 'application/json; charset=utf-8'
    And header Accept = 'application/json; text/plain;*/*'
    And request {"businessType":"","permitType":"Temporary Permit","mainLicenseId":null,"tempPermitTypeId":[{"applicationId":null,"tempLicensePermitTypeId":'#(mainLicensePermitTypeId)'}],"mainApplicationId":"","associatedLicenseList":[],"isMainTempPermitRequired":true,"newPermitTypeIds":[],"isNotQualified":false,"notQualifiedReason":""}
    
    When method post
    Then status 200
    And def ApplicationId = response[0].mainApplicationId
    And print ApplicationId
    And match ApplicationId contains 'NA-'
    And def description = response[0].description
    And print description
    And def appId = response[0].appId
    * def formId = response[0].formId		
    
    
    @IntakeMultipleTemporaryPermit
  Scenario: IntakeStandalonePermit
    Given path '/internalapi/api/licensing/selectapptype/savenewpermitapp'
    * def dbSts = db.cleanHeap()
    And header authorization = 'Bearer ' + strToken
    And header Content-Type = 'application/json; charset=utf-8'
    And header Accept = 'application/json; text/plain;*/*'
    And request {"businessType":"","permitType":"Temporary Permit","mainLicenseId":'#(licId)',"tempPermitTypeId":[{"applicationId":'#(licId)',"tempLicensePermitTypeId":'#(mainLicensePermitTypeId)'},{"applicationId":'#(licId)',"tempLicensePermitTypeId":'#(mainLicensePermitTypeId)'}],"mainApplicationId":"","associatedLicenseList":[],"isMainTempPermitRequired":true,"newPermitTypeIds":[],"isNotQualified":false,"notQualifiedReason":""}
    When method post
    Then status 200
    And def ApplicationId = response[0].mainApplicationId
    And print ApplicationId
    And match ApplicationId contains 'NA-'
    And def description = response[0].description
    And print description
    And def appId = response[0].appId
    * def formId = response[0].formId		
    #* call read('PermitsCommonMethods.feature@ValidateTempPermitAfterIntake') {}
	  	
	@IntakeMultipleTemporaryPermitwithoutLic
  Scenario: IntakeMultipleTemporaryPermitwithoutLic
    Given path '/internalapi/api/licensing/selectapptype/savenewpermitapp'
    * def dbSts = db.cleanHeap()
    And header authorization = 'Bearer ' + strToken
    And header Content-Type = 'application/json; charset=utf-8'
    And header Accept = 'application/json; text/plain;*/*'
    And request {"businessType":"","permitType":"Temporary Permit","mainLicenseId":null,"tempPermitTypeId":[{"applicationId":null,"tempLicensePermitTypeId":'#(mainLicensePermitTypeId)'},{"applicationId":'#(licId)',"tempLicensePermitTypeId":'#(mainLicensePermitTypeId)'}],"mainApplicationId":"","associatedLicenseList":[],"isMainTempPermitRequired":true,"newPermitTypeIds":[],"isNotQualified":false,"notQualifiedReason":""}
    
    When method post
    Then status 200
    And def ApplicationId = response[0].mainApplicationId
    And print ApplicationId
    And match ApplicationId contains 'NA-'
    And def description = response[0].description
    And print description
    And def appId = response[0].appId
    * def formId = response[0].formId		
    
    @ValidateTempPermitAfterIntake
  Scenario: ValidateTempPermitAfterIntake
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
    * def itemCount = (response.items.length) - 1
    And print itemCount
    And def lpStatus = response.items[itemCount].lpStatus
    And print lpStatus
    And def associatedpermitId = response.items[itemCount].licensePermitId
    And print associatedpermitId
    And def associatedApplicationId = response.items[itemCount].applicationId
    And print associatedApplicationId
    And def licStatus = response.items[itemCount].appStatus
    And print licStatus
    And match licStatus == 'Draft'
    And match associatedApplicationId == ApplicationId
    And match associatedpermitId == licId
    And match lpStatus == 'Active'
    
    
    @IntakeSolicitorPermit
  Scenario: IntakeStandalonePermit
  * call read('LicensesCommonMethods.feature@GetCountyList') {}
 	 * def countyData = karate.jsonPath(values, "$[?(@.CountyId == '" + CountyID + "')]")
	  * def countyZone = countyData[0].ZoneNo
	  And print countyZone
    Given path '/internalapi/api/licensing/selectapptype/savenewpermitapp'
    * def dbSts = db.cleanHeap()
    And header authorization = 'Bearer ' + strToken
    And header Content-Type = 'application/json; charset=utf-8'
    And header Accept = 'application/json; text/plain;*/*'
   
    And request {"businessType":"","permitType":"Associated Permit","mainLicenseId":'#(fiveDigitAppID)',"tempPermitTypeId":[],"mainApplicationId":"","associatedLicenseList":[],"isMainTempPermitRequired":false,"newPermitTypeIds":[{"permitTypeId":'#(mainLicensePermitTypeId)'}],"isNotQualified":false,"notQualifiedReason":""}
    When method post
    * configure continueOnStepFailure = true
     Then status 200
    And def ApplicationId = response[0].mainApplicationId
	  And print ApplicationId
	  And match ApplicationId contains 'NA'
	  #removed zone from below validation, as permit Id is starting wih zero after the year for solicitor("applicationId":"NA-0515-22-04656")
	  	  * def currentYear = '-'+getYearFunc()+'-'
	  And match ApplicationId contains currentYear
	  And def description = response[0].description
	  And def appId = response[0].appId
	  And def PermitDescription = response.description
	  And print PermitDescription
	  
	  
	   @GetInvalidLicenses
  Scenario: Get Activated Licenses List
    Given path '/internalapi/api/licensing/search/searchLicensesAndPermits/'
    And header authorization = 'Bearer ' + strToken
    And request {"showOnlyLicensesAssociated":true,"Status":"Active","WfTaskIdList":[],"LicenseStatusList":[],"isPermit":false,"isTempPermit":null,"isApplication":true,"ApplicationId":null,"LicensePermitId":null,"LegalName":'#(SearchName)',"FEIN":null,"applyFor":""}
    When method post
    Then status 200
    And def totalRecords = response.totalRecord
    
    
    
    
    
    
    
    # ********* Approve the Temp permit ********************* 
 @ApproveTempPermit
 Scenario: ApproveTempPermit
 
      Given path 'internalapi/api/licensing/TempPermit/save'
    
	    And header authorization = 'Bearer ' + strToken
	    And request {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"appId":'#(appId)',"applicationId":'#(ApplicationId)',"legalName":"Automation TempPermit","applicationType":1,"decisionType":{"name":"Approve","value":1},"newComments":"","emailNotificationModel":{"applicant":{"communicationId":11085,"email":"automation@test.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":11087,"email":"automation@svam.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}},"taskId":1252}
	    When method post
	    Then status 200
	    And def serverResponse = response
	    And print serverResponse
	    And match serverResponse == 'true'
     Given path '/internalapi/api/comment/Application/save'
    
	    And header authorization = 'Bearer ' + strToken
	    And request {"description":"Approved Comments","acaId":'#(appId)',"acatype":"Application","bureau":"License","bureauId":1}
	    When method post
	    Then status 200
	   
    
    Given path '/internalapi/api/licensing/TempPermit/submit'
    
    * def summisionDate =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		  
		  
		  """
	* def formatedSumbitDate = summisionDate()
    And header authorization = 'Bearer ' + strToken
    And header current-wfroleid = 4
    And request {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"isChainRestaurant":false,"decisionType":{"name":"Approve","value":1},"newComments":"Approved Comments","appId":'#(appId)',"applicationId":'#(ApplicationId)',"legalName":'#(legalName)',"applicationType":1,"emailNotificationModel":{"applicant":{"communicationId":21908,"email":"automation@svam.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":21911,"email":"sbandi@svam.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}},"taskId":1252}
    #{"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"isChainRestaurant":false,"appId":17625,"applicationId":"NA-0512-22-14369","legalName":"Automation Automation","applicationType":1,"decisionType":{"name":"Approve","value":1},"newComments":"","emailNotificationModel":{"applicant":{"communicationId":11085,"email":"automation@test.com","appId":17625,"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":11087,"email":"automation@svam.com","appId":17625,"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":17625,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}},"taskId":1252}
    
    When method post
    Then status 200
     And def serverResponse = response
    And print serverResponse
    And match serverResponse == 'true'         
    
     # ********* GET License Id *********************  
  
    Given path '/internalapi/api/licensing/LBDecision/getLicenseByAppId/' + appId +'/-1'
    And header authorization = 'Bearer ' + strToken
    And request {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"masterFileData":[],"combinedCraftData":[],"appId":'#(appId)',"applicationType":1,"applicationId":'#(ApplicationId)',"legalName":null,"statusId":3,"decisionType":{"name":"Approved","value":1},"emailNotificationModel":{"applicant":{},"attorney":{},"other":{"email":""}},"hasErrors":[],"taskId":1151,"newComments":"","approval":{"isDefineStipulations":false,"selectInput":{"fromFields":[{"id":1,"label":"Inside of premises closes at x"},{"id":2,"label":"Side walk café closes at x"},{"id":3,"label":"Backyard closes at x"},{"id":4,"label":"Alcohol consumption inside stops at X"},{"id":5,"label":"Alcohol consumption in backyard stops at x"},{"id":6,"label":"Alcohol consumption on sidewalk café stops at x"},{"id":7,"label":"No live music in inside of premises"},{"id":8,"label":"No live music outside of premise"},{"id":9,"label":"No DJs"},{"id":10,"label":"No promoters"},{"id":11,"label":"No Promoted events"},{"id":12,"label":"Recorded music only"},{"id":13,"label":"Music stops at X"},{"id":14,"label":"Music outside stops at X"},{"id":15,"label":"Only non-amplified music"},{"id":16,"label":"Acoustic music only"},{"id":17,"label":"No bar crawls"},{"id":18,"label":"Close façade doors at certain time"},{"id":19,"label":"Close Windows at a certain time"},{"id":20,"label":"No boozy brunches"},{"id":21,"label":"No unlimited drink"},{"id":22,"label":"No happy Hours"},{"id":23,"label":"No bottle service "},{"id":24,"label":"No dancing"},{"id":25,"label":"No delivery bikes"},{"id":26,"label":"No TVs"},{"id":27,"label":"Licensed patio"},{"id":28,"label":"Licensed sidewalk café"},{"id":29,"label":"No outside areas"},{"id":30,"label":"Security Guards required"},{"id":31,"label":"X amount of security guards per x amount of patrons"},{"id":32,"label":"# of security guards per patron"},{"id":33,"label":"No VIP"},{"id":34,"label":"No roped lines"},{"id":35,"label":"No hookah"},{"id":36,"label":"Doors closed at all times"},{"id":37,"label":"Windows closed at all time"},{"id":38,"label":"All agreed upon CB stipulations except"},{"id":39,"label":"All employees must be TIPS trained"}],"toFields":[],"isRewritable":true,"rewriteLabel":"Edit Stipulation:","srclabel":"Select Stipulations","dstlabel":"Add to Certificate","additionalLabel":"Add Additional Stipulations:"},"effectiveDate":"2022-01-10","expirationDate":"2022-08-31","stipulations":[],"descriptions":[]}}
    When method get
    Then status 200
    And def serverResponse = response
   
    And def licId = serverResponse.license.licId
    And def licenseId = serverResponse.license.licenseId
    
    And print 'licId : ' , licId
    And print 'licenseId : ' , licenseId
    And match licId != []
    And match licenseId != []
    * def appendAppID = db.appendStrToFile('PermitAPPIds.csv' , ('\n'+appId+','+licenseId))
    
    
    
   # ********* Disapprove the Temp permit ********************* 
 @DisapproveTempPermit
 Scenario: DisapproveTempPermit
 
      Given path 'internalapi/api/licensing/TempPermit/save'
    
	    And header authorization = 'Bearer ' + strToken
	    And request {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"isChainRestaurant":false,"appId":'#(appId)',"applicationId":'#(ApplicationId)',"legalName":'#(legalName)',"applicationType":1,"decisionType":{"name":"Disapprove","value":2},"newComments":"Disapprove Comments","disApproval":{"isDisapprovalForCause":'#(DisapprovalCauseStatus)',"selectInput":{"fromFields":[{"id":2,"label":"A temporary permit for a New York City premises may not be considered for approval, unless a contract of sale is submitted with the application.  No contract of sale was submitted for this transaction."},{"id":3,"label":"A liquidator’s permit may not be considered for approval when the application it is filed in conjunction with is disapproved."},{"id":4,"label":"A liquidator’s permit may not be approved when the seller of the alcohol is currently in arrears and on the Authority’s COD List.  The seller will need to clear all accounts in arrears and re-apply."},{"id":5,"label":"An insufficient fee was submitted with the application.  Total fee due was $___ and the total fee paid was $_____"},{"id":6,"label":"Check number ____ in the amount of ________ , for payment in connection with this application was returned due to insufficient funds.  A request for certified funds was sent to the applicant on _________, to which there was no reply."},{"id":7,"label":"Licensees are not eligible to change corporate entities using an endorsement/corporate change application.  A licensee forming a new entity and using a new FEIN# must file a new application under the new corporate entity."},{"id":8,"label":"Endorsement applications may not be used to change an application from an executor of an estate to a corporation.  A new application must be filed once the estate is settled."},{"id":9,"label":"Licensee is not eligible to file a removal under a new corporate entity.  Licensee must file a new application for the new corporate entity with the new FEIN #."},{"id":10,"label":"The applicant submitted an outdated application form that is no longer accepted for processing as of 11/30/13."},{"id":11,"label":"Temporary retail permit was received with an outdated main application."},{"id":12,"label":"The corporate change filed under this serial number is a duplicate of a corporate change filed on _______________under _________________________________, serial number __________."},{"id":1,"label":"A temporary permit may not be considered for approval unless it is preceded or accompanied by an application for a permanent license."},{"id":2,"label":"A temporary permit for a New York City premises may not be considered for approval, unless a contract of sale is submitted with the application.  No contract of sale was submitted for this transaction."},{"id":3,"label":"A liquidator’s permit may not be considered for approval when the application it is filed in conjunction with is disapproved."},{"id":4,"label":"A liquidator’s permit may not be approved when the seller of the alcohol is currently in arrears and on the Authority’s COD List.  The seller will need to clear all accounts in arrears and re-apply."},{"id":5,"label":"An insufficient fee was submitted with the application.  Total fee due was $___ and the total fee paid was $_____"},{"id":6,"label":"Check number ____ in the amount of ________ , for payment in connection with this application was returned due to insufficient funds.  A request for certified funds was sent to the applicant on _________, to which there was no reply."},{"id":7,"label":"Licensees are not eligible to change corporate entities using an endorsement/corporate change application.  A licensee forming a new entity and using a new FEIN# must file a new application under the new corporate entity."},{"id":8,"label":"Endorsement applications may not be used to change an application from an executor of an estate to a corporation.  A new application must be filed once the estate is settled."},{"id":9,"label":"Licensee is not eligible to file a removal under a new corporate entity.  Licensee must file a new application for the new corporate entity with the new FEIN #."},{"id":10,"label":"The applicant submitted an outdated application form that is no longer accepted for processing as of 11/30/13."},{"id":11,"label":"Temporary retail permit was received with an outdated main application."},{"id":12,"label":"The corporate change filed under this serial number is a duplicate of a corporate change filed on _______________under _________________________________, serial number __________."}],"toFields":[{"id":1,"label":"A temporary permit may not be considered for approval unless it is preceded or accompanied by an application for a permanent license."}],"isRewritable":true,"rewriteLabel":"Edit Reason for Disapproval:","additionalComments":"Auto-Test Reason","srclabel":"Select","dstlabel":"Add to Notification","additionalLabel":"Additional Reasons for Disapproval:"},"isDisapprovalLetterAttach":true,"disapprovalReason":[1,-1],"descriptions":["A temporary permit may not be considered for approval unless it is preceded or accompanied by an application for a permanent license.","Auto-Test Reason"]},"emailNotificationModel":{"applicant":{"communicationId":21912,"email":"automation@svam.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":21915,"email":"sbandi@svam.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}},"taskId":1252}
	    When method post
	    Then status 200
	    And def serverResponse = response
	    And print serverResponse
	    And match serverResponse == 'true'
     Given path '/internalapi/api/comment/Application/save'
    
	    And header authorization = 'Bearer ' + strToken
	    And request {"description":"Disapprove Comments","acaId":'#(appId)',"acatype":"Application","bureau":"License","bureauId":1}
	    When method post
	    Then status 200
	   
    
    Given path '/internalapi/api/licensing/TempPermit/submit'
    
    * def summisionDate =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		  
		  
		  """
	* def formatedSumbitDate = summisionDate()
    And header authorization = 'Bearer ' + strToken
    And header current-wfroleid = 4
    And request {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"isChainRestaurant":false,"appId":'#(appId)',"applicationId":'#(ApplicationId)',"legalName":'#(legalName)',"applicationType":1,"decisionType":{"name":"Disapprove","value":2},"newComments":"Disapprove Comments","disApproval":{"isDisapprovalForCause":'#(DisapprovalCauseStatus)',"selectInput":{"fromFields":[{"id":2,"label":"A temporary permit for a New York City premises may not be considered for approval, unless a contract of sale is submitted with the application.  No contract of sale was submitted for this transaction."},{"id":3,"label":"A liquidator’s permit may not be considered for approval when the application it is filed in conjunction with is disapproved."},{"id":4,"label":"A liquidator’s permit may not be approved when the seller of the alcohol is currently in arrears and on the Authority’s COD List.  The seller will need to clear all accounts in arrears and re-apply."},{"id":5,"label":"An insufficient fee was submitted with the application.  Total fee due was $___ and the total fee paid was $_____"},{"id":6,"label":"Check number ____ in the amount of ________ , for payment in connection with this application was returned due to insufficient funds.  A request for certified funds was sent to the applicant on _________, to which there was no reply."},{"id":7,"label":"Licensees are not eligible to change corporate entities using an endorsement/corporate change application.  A licensee forming a new entity and using a new FEIN# must file a new application under the new corporate entity."},{"id":8,"label":"Endorsement applications may not be used to change an application from an executor of an estate to a corporation.  A new application must be filed once the estate is settled."},{"id":9,"label":"Licensee is not eligible to file a removal under a new corporate entity.  Licensee must file a new application for the new corporate entity with the new FEIN #."},{"id":10,"label":"The applicant submitted an outdated application form that is no longer accepted for processing as of 11/30/13."},{"id":11,"label":"Temporary retail permit was received with an outdated main application."},{"id":12,"label":"The corporate change filed under this serial number is a duplicate of a corporate change filed on _______________under _________________________________, serial number __________."},{"id":1,"label":"A temporary permit may not be considered for approval unless it is preceded or accompanied by an application for a permanent license."},{"id":2,"label":"A temporary permit for a New York City premises may not be considered for approval, unless a contract of sale is submitted with the application.  No contract of sale was submitted for this transaction."},{"id":3,"label":"A liquidator’s permit may not be considered for approval when the application it is filed in conjunction with is disapproved."},{"id":4,"label":"A liquidator’s permit may not be approved when the seller of the alcohol is currently in arrears and on the Authority’s COD List.  The seller will need to clear all accounts in arrears and re-apply."},{"id":5,"label":"An insufficient fee was submitted with the application.  Total fee due was $___ and the total fee paid was $_____"},{"id":6,"label":"Check number ____ in the amount of ________ , for payment in connection with this application was returned due to insufficient funds.  A request for certified funds was sent to the applicant on _________, to which there was no reply."},{"id":7,"label":"Licensees are not eligible to change corporate entities using an endorsement/corporate change application.  A licensee forming a new entity and using a new FEIN# must file a new application under the new corporate entity."},{"id":8,"label":"Endorsement applications may not be used to change an application from an executor of an estate to a corporation.  A new application must be filed once the estate is settled."},{"id":9,"label":"Licensee is not eligible to file a removal under a new corporate entity.  Licensee must file a new application for the new corporate entity with the new FEIN #."},{"id":10,"label":"The applicant submitted an outdated application form that is no longer accepted for processing as of 11/30/13."},{"id":11,"label":"Temporary retail permit was received with an outdated main application."},{"id":12,"label":"The corporate change filed under this serial number is a duplicate of a corporate change filed on _______________under _________________________________, serial number __________."}],"toFields":[{"id":1,"label":"A temporary permit may not be considered for approval unless it is preceded or accompanied by an application for a permanent license."}],"isRewritable":true,"rewriteLabel":"Edit Reason for Disapproval:","additionalComments":"Auto-Test Reason","srclabel":"Select","dstlabel":"Add to Notification","additionalLabel":"Additional Reasons for Disapproval:"},"isDisapprovalLetterAttach":true,"disapprovalReason":[1,-1],"descriptions":["A temporary permit may not be considered for approval unless it is preceded or accompanied by an application for a permanent license.","Auto-Test Reason"]},"emailNotificationModel":{"applicant":{"communicationId":21912,"email":"automation@svam.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":21915,"email":"sbandi@svam.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}},"taskId":1252}
    When method post
    Then status 200
     And def serverResponse = response
    And print serverResponse
    And match serverResponse == 'true'   
    
    
   # ********* Conditionally Approve the Temp permit ********************* 
 @ConditionallyApproveTempPermit
 Scenario: ConditionallyApproveTempPermit
 
      Given path 'internalapi/api/licensing/TempPermit/save'
    
	    And header authorization = 'Bearer ' + strToken
	    And request {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"isChainRestaurant":false,"appId":'#(appId)',"applicationId":'#(ApplicationId)',"legalName":'#(legalName)',"applicationType":1,"decisionType":{"name":"Conditionally Approve","value":3},"newComments":"Conditionally Approved Comments","conditionalApproval":{"selectInput":{"fromFields":[{"id":2,"label":"Provide a copy of the business certificate from the county clerk for your dba name"},{"id":3,"label":"Provide your federal tax identification number"},{"id":4,"label":"Provide a copy of your Certificate of Authority from the New York State Tax Department"},{"id":5,"label":"Provide an amended Certificate of Authority – the name must match the applicant name exactly."},{"id":6,"label":"Provide an amended Certificate of Authority – the address must match the premises address exactly"},{"id":7,"label":"Provide a signed Bond Rider amending____________"},{"id":8,"label":"Provide Worker’s Compensation and Disability Benefits insurance provider names and policy numbers"},{"id":9,"label":"Provide an inventory of the alcoholic beverages you will be purchasing from the current licensee"},{"id":10,"label":"Submit a copy of the Newspaper Affidavit(s)"},{"id":11,"label":"Provide your TTB permit"},{"id":12,"label":"Surrender of the current license in effect"},{"id":13,"label":"Other Condition"}],"toFields":[{"id":1,"label":"Provide a copy of the Assumed Name Certificate from the Secretary of State for your corporation/LLC’s dba name"}],"isRewritable":true,"rewriteLabel":"Edit Conditions:","additionalComments":"Conditionally Approved","srclabel":"Select","dstlabel":"Add to Letter","additionalLabel":"Additional Conditions:"},"conditions":[1,-1],"descriptions":["Provide a copy of the Assumed Name Certificate from the Secretary of State for your corporation/LLC’s dba name","Conditionally Approved"]},"emailNotificationModel":{"applicant":{"communicationId":19903,"email":"automation@svam.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":0,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}},"taskId":1252}
	    When method post
	    Then status 200
	    And def serverResponse = response
	    And print serverResponse
	    And match serverResponse == 'true'
     Given path '/internalapi/api/comment/Application/save'
    
	    And header authorization = 'Bearer ' + strToken
	    And request {"description":"Conditionally Approved Comments","acaId":'#(appId)',"acatype":"Application","bureau":"License","bureauId":1}
	    When method post
	    Then status 200
	   
    
    Given path '/internalapi/api/licensing/TempPermit/submit'
    
    * def summisionDate =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		  
		  
		  """
	* def formatedSumbitDate = summisionDate()
    And header authorization = 'Bearer ' + strToken
    And header current-wfroleid = 4
    And request {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"isChainRestaurant":false,"appId":'#(appId)',"applicationId":'#(ApplicationId)',"legalName":'#(legalName)',"applicationType":1,"decisionType":{"name":"Conditionally Approve","value":3},"newComments":"Conditionally Approved Comments","conditionalApproval":{"selectInput":{"fromFields":[{"id":2,"label":"Provide a copy of the business certificate from the county clerk for your dba name"},{"id":3,"label":"Provide your federal tax identification number"},{"id":4,"label":"Provide a copy of your Certificate of Authority from the New York State Tax Department"},{"id":5,"label":"Provide an amended Certificate of Authority – the name must match the applicant name exactly."},{"id":6,"label":"Provide an amended Certificate of Authority – the address must match the premises address exactly"},{"id":7,"label":"Provide a signed Bond Rider amending____________"},{"id":8,"label":"Provide Worker’s Compensation and Disability Benefits insurance provider names and policy numbers"},{"id":9,"label":"Provide an inventory of the alcoholic beverages you will be purchasing from the current licensee"},{"id":10,"label":"Submit a copy of the Newspaper Affidavit(s)"},{"id":11,"label":"Provide your TTB permit"},{"id":12,"label":"Surrender of the current license in effect"},{"id":13,"label":"Other Condition"}],"toFields":[{"id":1,"label":"Provide a copy of the Assumed Name Certificate from the Secretary of State for your corporation/LLC’s dba name"}],"isRewritable":true,"rewriteLabel":"Edit Conditions:","additionalComments":"Conditionally Approved","srclabel":"Select","dstlabel":"Add to Letter","additionalLabel":"Additional Conditions:"},"conditions":[1,-1],"descriptions":["Provide a copy of the Assumed Name Certificate from the Secretary of State for your corporation/LLC’s dba name","Conditionally Approved"]},"emailNotificationModel":{"applicant":{"communicationId":19903,"email":"automation@svam.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":0,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}},"taskId":1252}
    
    When method post
    Then status 200
     And def serverResponse = response
    And print serverResponse
    And match serverResponse == 'true'         
      
  # ********* Submitting the Temp permit ********************* 
 @SubmittingTempPermit
 Scenario: SubmittingTempPermit
 
      Given path 'internalapi/api/licensing/TempPermit/save'
    
	    And header authorization = 'Bearer ' + strToken
	    And request {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"isChainRestaurant":false,"appId":'#(appId)',"applicationId":'#(ApplicationId)',"legalName":'#(legalName)',"applicationType":1,"decisionType":{"name":'#(decisionName)',"value":'#(decisionValue)'},"newComments":"AutoTest comments","emailNotificationModel":{"applicant":{},"attorney":{},"communityBoard":{},"other":{}},"taskId":1252}
	    When method post
	    Then status 200
	    And def serverResponse = response
	    And print serverResponse
	    And match serverResponse == 'true'
     Given path '/internalapi/api/comment/Application/save'
    
	    And header authorization = 'Bearer ' + strToken
	    And request {"description":"Test Comments","acaId":'#(appId)',"acatype":"Application","bureau":"License","bureauId":1}
	    When method post
	    Then status 200
	   
    
    Given path '/internalapi/api/licensing/TempPermit/submit'
    
    * def summisionDate =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		  
		  
		  """
	* def formatedSumbitDate = summisionDate()
    And header authorization = 'Bearer ' + strToken
    And header current-wfroleid = 4
    And request {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"isChainRestaurant":false,"appId":'#(appId)',"applicationId":'#(ApplicationId)',"legalName":'#(legalName)',"applicationType":1,"decisionType":{"name":'#(decisionName)',"value":'#(decisionValue)'},"newComments":"AutoTest comments","emailNotificationModel":{"applicant":{},"attorney":{},"communityBoard":{},"other":{}},"taskId":1252}
    
    When method post
    Then status 200
     And def serverResponse = response
    And print serverResponse
    And match serverResponse == 'true'        
  
  	  
@ValidatePermitCommunicationPage
 Scenario: ValidatePermitCommunicationPage scenario
	
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
		
		* match serverResponseNotificationData[0].status == 'Sent'
		* match serverResponseNotificationData[0].emailTo != []
		* match serverResponseNotificationData[0].subject == subject
	
  
  	  
@ValidatePermitCommunicationPageAndEMail
 Scenario: ValidatePermitCommunicationPage and Email Communication Page scenario
	
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
		
		* match serverResponseNotificationData[0].status == 'Sent'
		* match serverResponseNotificationData[0].emailTo != []
		* match serverResponseNotificationData[0].subject == subject
		* match serverResponseNotificationData[0].emailBody != []
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
	    
	    * match serverResponse != []    
	    
	    
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
	 * def docData = karate.jsonPath(response, "$[?(@.documentDesc == '" + docFileName + "')]")
	 * def fileName = docData[0].fileName
	 * match fileName == docFileName	         
  	
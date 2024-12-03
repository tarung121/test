Feature: IntakeLicense
Background:
			* url BaseURL
  		* def config = { username: '#(dbUserName)', password:'#(dbUserPassword)', url: '#(dbQuery)',driverClassName: 'com.microsoft.sqlserver.jdbc.SQLServerDriver' }
    	* def DbUtils = Java.type('utils.DbUtils')
    	* def db = new DbUtils(config)
			
#********* SignIn *********************

@IntakePermit
Scenario: Intake Permit Submission  
	# ********* App Intake *********************
   Given path '/internalapi/api/licensing/selectapptype/savenewpermitapp'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And request {"businessType":"","permitType":"Standalone Permit","mainLicenseId":null,"tempPermitTypeId":[],"mainApplicationId":"","associatedLicenseList":[],"isMainTempPermitRequired":false,"newPermitTypeIds":[{"permitTypeId":'#(mainLicensePermitTypeId)'}],"isNotQualified":false,"notQualifiedReason":""}
      
                  #{"mainLicensePermitTypeId":,"newPermitTypeIds":[],"combinedCraftId":null,"masterFileId":null,"isApplicableForTempPermit":false,"isNotQualified":false,"isChainRestaurant":false,"addBarList":[],"countyId":1,"isApplicantCurrentLicensed":false,"isExistingManufacturer":false,"selectedLicense":null}
	  When method post
	  Then status 200
	  And def ApplicationId = response[0].mainApplicationId
	  And print ApplicationId
	  And def description = response[0].description
	  And def appId = response[0].appId
	  * def formId = response[0].formId
	 
@PermitSaveApplicantInfo
Scenario: ApplicantInfo License Submission	 	 
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

      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {"businessInfo":{"website":null,"businessEntity":{"individualOrganization":"1","corporateStructure":"1","firstName":'#(temp)',"lastName":"Permit","middleName":"","suffix":null,"ssn":"","fein":"","legalName":"Automation AutoPermit","id":0,"isEmployeeForSoleProprietor":null,"individualOrganizationText":null,"corporateStructureText":null,"isIndividual":false},"address":{"addressId":0,"appId":null,"addressLine1":null,"addressLine2":null,"city":null,"stateId":40,"county":null,"zipCode":null,"zip4":null,"street":null,"telephoneNumber":null,"country":"United States (US)","addressTypeId":null,"location":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null,"isActive":null,"showAndHide":null,"roomNo":null,"stateName":"New York","countryId":229,"serialNo":0,"addressType":null,"state":null},"communication":{"email":"automation@test.com","confirmEmail":"automation@test.com","phones":[],"id":0},"id":0,"isLicensed":false,"isAssociated":false},"premisesInfo":{"dba":null,"licensePermitID":null,"address":{"addressId":0,"appId":null,"addressLine1":"Test","addressLine2":null,"city":"New York","stateId":40,"county":"New York","zipCode":"11111","zip4":"1111","street":null,"telephoneNumber":null,"country":"United States (US)","addressTypeId":null,"location":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null,"isActive":null,"showAndHide":null,"roomNo":null,"stateName":"New York","countryId":229,"serialNo":0,"addressType":null,"state":null},"communication":{"email":null,"confirmEmail":null,"phones":[],"id":0},"id":0},"applicantDetail":{"masterFileID":null,"mfExpDate":null,"certificateNysTax":null,"certIssueDate":null,"applicantStatement":{"nameOfApplicant":null,"date":null,"title":null,"signature":null,"id":0},"id":0,"isPhysicalChange":null}}
	  When method post
	  Then status 200
	 
	  
 
    
 # ********* Examiner Review Approval to LB ********************* 
@ReviewLBPermit
Scenario:ReviewLBPermit
    Given path '/internalapi/api/licensing/examiner-review/SaveNewPermit'
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
    And request {"isFingerPrintsApproved":true,"isFingerPrintsRequired":false,"isCorpLLCDissolved":false,"isCorpLLCDTaken":false,"isSendPDLetter":false,"isDisable500LB_FBPT":false,"isDisableLBForPD":false,"isDisableLBForCaseClosed":false,"isDisableLateRenewalAndUnderpayment":false,"isLiquidatorPermitHasCompleted":-1,"isSubmit":true,"fieldDeficiencies":[],"masterFileData":[],"combinedCraftData":[],"application":{"applicationCategory":6,"appId":'#(appId)',"applicationId":'#(ApplicationId)',"licePermitTypeId":null,"applicationTypeId":1,"formVersionId":1498,"formId":1111,"legalName":"Alm 2457 Industrial Alcohol","submitDate":"2021-09-23T12:56:31.137","isGISRequired":null,"licenseDescription":"Industrial Alcohol Manufacturer's Permit (Fuel Only)","recommendedDecisionId":null,"status500":null,"isApplicableForPDLetter":false,"countyName":"Albany","priority":"Normal","expirationDate":null,"appStatusId":2,"taskStatus":"Awaiting Review","taskId":1526,"currentWfstatus":null,"communityBoard":null,"isLicenseApplication":false,"currentDueDate":null,"isFinalDeficiency":null,"isHighlyDeficient":null,"isAllDeficienciesMet":null,"pastDueDate":null,"memo":null,"isOneTimePermit":null,"dueDateAction":null,"isDisapprovedForCause":false,"isNotQualified":false,"event":null,"appStatus":{"appStatusId":2,"statusDescription":"IntakeComplete","isActive":true,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"applicationType":null,"assignAppExaminer":{"appExaminerId":473,"appId":'#(appId)',"examinerId":1069,"name":null,"assignDate":"2021-09-23T12:56:31.433","isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"assignAppToLB":null,"licePermitType":{"licPermitTypeId":424,"type":"2","category":"6","product":"","class":null,"description":null,"sectionOfLaw":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null,"isTempPermit":false,"isELicensingPermit":true,"isAdditionalBar":false},"assoApplicationList":[],"isTempPermit":null,"isTempOrLiq":false,"licPermitTypeId":424,"isAssociatedLicense":null,"effectiveDate":null,"assignedUserId":null,"amendmentTypeId":null,"amendmentType":null,"disapprovedDate":null,"condApprovedDate":null,"addressId":null,"isCaseOpen":null,"isClosed":null,"isSpecialEventPlusFour":null,"isSpecialEventInsideFiveBoroughs":null,"licStatus":null,"createdBy":null,"licenseId":null,"address":null,"isNybeApp":true,"isHearingCompleted":null,"does500FtHearingExist":null,"parentAppStatus":null,"premisesAppCount":0,"statusDescription":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskRoleId":0,"taskDecision":null,"isActive":true,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":"2021-09-23T12:56:31.137"},"appId":'#(appId)',"notificationTypeId":2028,"applicationType":1,"decisionType":{"name":"Send to Licensing Board","value":2},"emailNotificationModel":{"applicant":{},"attorney":{},"communityBoard":{},"other":{}},"hasErrors":[],"taskId":1526,"newComments":"SEND TO LB AUTOMATION","recommendedDecisionId":"1"}
    When method post
    Then status 200
   
    
 # ********* LB Approval *********************    
   
@PermitApproval
Scenario: PermitApproval     
    Given path '/internalapi/api/licensing/new-permit/saveDecision'
    And header authorization = 'Bearer ' + strToken
    And header current-wfroleid = 5
    And request {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"appId":'#(appId)',"applicationType":1,"applicationId":'#(applicationId)',"legalName":"Sep13_BrewerTasting_Annual_AQAMC","statusId":3,"decisionType":{"name":"Approved","value":1},"emailNotificationModel":{"applicant":{"communicationId":6936,"email":"vdsouza@svam.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":6938,"email":"vdsouza@svam.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}},"hasErrors":[],"licPermitTypeId":374,"taskId":1601,"newComments":"","approval":{"isDefineStipulations":false,"effectiveDate":"2022-02-03","expirationDate":"2023-02-28"}}
    When method post
    Then status 200
    And def serverResponse = response
   

@ReviewTempPermit
Scenario:  ReviewTempPermit    
    # ********* Save and Assign Temp Permit *********************
    Given path 'internalapi/api/licensing/TempPermit/save'
    
    And header authorization = 'Bearer ' + strToken
    And request {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"appId":'#(appId)',"applicationId":'#(ApplicationId)',"legalName":"Automation TempPermit","applicationType":1,"decisionType":{"name":"Approve","value":1},"newComments":"","emailNotificationModel":{"applicant":{"communicationId":11085,"email":"automation@test.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":11087,"email":"automation@svam.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}},"taskId":1252}
    When method post
    Then status 200
    And def serverResponse = response
    And print serverResponse
    And match serverResponse == 'true'  
   
   
 # ********* Approve the Temp permit ********************* 

@SubmitTempPermit
Scenario:  SubmitTempPermit    
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
    #And header authorization = 'Bearer ' + strTokenRole
    And header authorization = 'Bearer ' + strToken
    And header current-wfroleid = 4
    And request {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"appId":'#(appId)',"applicationId":'#(ApplicationId)',"legalName":"Automation TempPermit","applicationType":1,"decisionType":{"name":"Approve","value":1},"newComments":"","emailNotificationModel":{"applicant":{"communicationId":11085,"email":"automation@test.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":11087,"email":"automation@svam.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}},"taskId":1252}
    #{"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"decisionType":{"name":"Approve","value":1},"newComments":"","appId":'#(appId)',"applicationId":'#(ApplicationId)',"legalName":"Automation TempPermit","applicationType":1,"emailNotificationModel":{"applicant":{"communicationId":11070,"email":"automation@test.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":11072,"email":"sbandi@svam.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}},"taskId":1252}
                
     
     When method post
    Then status 200
     And def serverResponse = response
    And print serverResponse
    And match serverResponse == 'true'   
   
   
   # ********* Getting Actived Licenses ********************* 
    
@searchLicensesAndPermits
Scenario: searchLicensesAndPermits
    Given path '/internalapi/api/licensing/search/searchLicensesAndPermits/'
    And header authorization = 'Bearer ' + strToken
   	And request {"showOnlyLicensesAssociated":true,"Status":"Active","WfTaskIdList":[],"LicenseStatusList":[],"isPermit":false,"isTempPermit":null,"isApplication":true,"ApplicationId":null,"LicensePermitId":null,"LegalName":"Automation","FEIN":null,"applyFor":""}
    When method post
    Then status 200
    And def serverResponse = response
    And print serverResponse.licenses[0].licensePermitId
    And print serverResponse.licenses[0].licPermitTypeId    
 	* def licTypeId = serverResponse.licenses[0].licPermitTypeId 
 	* def licId = serverResponse.licenses[0].licensePermitId
 	
 	
@IntakeAssociatedPermit
Scenario: Intake Associated Permit Submission
	Given path '/internalapi/api/licensing/selectapptype/savenewpermitapp'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
   
   
      And request {"businessType":"","permitType":"Associated Permit","mainLicenseId":'#(licId)',"tempPermitTypeId":[],"mainApplicationId":"","associatedLicenseList":[],"isMainTempPermitRequired":false,"newPermitTypeIds":[{"permitTypeId":'#(mainLicensePermitTypeId)'}],"isNotQualified":false,"notQualifiedReason":""}
      When method post
	  Then status 200
	 
	 And def ApplicationId = response[0].mainApplicationId
	  And print ApplicationId
	  And def description = response[0].description
	 
	   And def appId = response[0].appId
	  
	   * def formId = response[0].formId
	   
	   
	   
@IntakeTempPermit
Scenario: Intake Temp Permit Submission   
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
	  And def description = response[0].description
	 
	   And def appId = response[0].appId
	  
	   * def formId = response[0].formId
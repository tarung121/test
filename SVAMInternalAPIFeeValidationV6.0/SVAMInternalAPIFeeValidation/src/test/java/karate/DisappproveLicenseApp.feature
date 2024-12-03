Feature: Manufacture License Submission
Background:
			* url BaseURL
  		* def config = { username: '#(dbUserName)', password:'#(dbUserPassword)', url: '#(dbQuery)',driverClassName: 'com.microsoft.sqlserver.jdbc.SQLServerDriver' }
    	* def DbUtils = Java.type('utils.DbUtils')
    	* def db = new DbUtils(config)
			
#********* SignIn *********************

Scenario Outline: Intake License Submission
   
	# ********* App Intake *********************
  	* call read('LoginDetails.feature') { strToken:'#(strToken)'}
 
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
   				   And request {"mainLicensePermitTypeId":'#(mainLicensePermitTypeId)',"newPermitTypeIds":[],"combinedCraftId":null,"masterFileId":null,"isApplicableForTempPermit":false,"isNotQualified":false,"isChainRestaurant":false,"addBarList":[],"countyId":1,"isApplicantCurrentLicensed":false,"isExistingManufacturer":false,"selectedLicense":null}
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

      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {"businessInfo":{"website":null,"businessEntity":{"individualOrganization":"1","corporateStructure":"1","firstName":'#(temp)',"lastName":"License","middleName":"","suffix":null,"ssn":"","fein":"","legalName":"","id":0,"isEmployeeForSoleProprietor":null,"individualOrganizationText":null,"corporateStructureText":null,"isIndividual":false},"address":{"addressId":0,"appId":null,"addressLine1":null,"addressLine2":null,"city":null,"stateId":40,"county":null,"zipCode":null,"zip4":null,"street":null,"telephoneNumber":null,"country":"United States (US)","addressTypeId":null,"location":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null,"isActive":null,"showAndHide":null,"roomNo":null,"stateName":"New York","countryId":229,"serialNo":0,"addressType":null,"state":null},"communication":{"email":"automation@test.com","confirmEmail":"automation@test.com","phones":[],"id":0},"id":0,"isLicensed":false,"isAssociated":false},"premisesInfo":{"dba":null,"licensePermitID":null,"address":{"addressId":0,"appId":null,"addressLine1":"Test","addressLine2":null,"city":"New York","stateId":40,"county":"New York","zipCode":"11111","zip4":"1111","street":null,"telephoneNumber":null,"country":"United States (US)","addressTypeId":null,"location":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null,"isActive":null,"showAndHide":null,"roomNo":null,"stateName":"New York","countryId":229,"serialNo":0,"addressType":null,"state":null},"communication":{"email":null,"confirmEmail":null,"phones":[],"id":0},"id":0},"applicantDetail":{"masterFileID":null,"mfExpDate":null,"certificateNysTax":null,"certIssueDate":null,"applicantStatement":{"nameOfApplicant":null,"date":null,"title":null,"signature":null,"id":0},"id":0,"isPhysicalChange":null}}
	  When method post
	  Then status 200
	 
	  
	  
	  
   Given path '/internalapi/api/licensing/app/static/principal/save/'+appId
      
  	  And header Content-Type = 'application/json; charset=utf-8'
  	  * def getDate1 =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat('yyyyMMddHHmmss');
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		  """
  	  * def prncipalName = 'Automation'+getDate1()

      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {"entities":[],"principals":[{"principalId":0,"convictedOfCrime":"","percentageOfOwners":"","isFingerprintRequired":"","isFingerprintsApproved":"","title":"","numberOfShares":"","isSignature":"","date":"","address":{"addressLine1":"","addressLine2":"","stateId":40,"county":"","city":"","zipCode":"","zip4":"","country":"United States (US)","stateName":"New York","countryId":229,"zip":""},"person":{"personId":0,"firstName":'#(prncipalName)',"middleName":"","lastName":"License","suffix":"","socialSecurityNo":"","birthDate":"","age":"","choosedEntity":null,"ssnFormat":""},"isIndividualsPartnersAssociatedWithEntity":"","communication":{"id":0,"phones":[],"email":"automation@test.com","confirmEmail":"automation@test.com"},"disableFlags":"{\"isExisitingPrincipal\":false,\"isExistingPrincipalInBusiness\":false,\"isRenewalAndAmendPrincipal\":false,\"isNewPrincipal\":true}","isAssociated":false}]}
	  When method post
	  Then status 200
	
	  
	  
  # ********* Representative ********************* 
    
    
    Given path '/internalapi/api/licensing/app/static/rep/save/'+appId
    And header authorization = 'Bearer ' + strToken
   	And request {"id":0,"contactType":"1","otherContactType":null,"selfCertified":null,"nysRegistrationNumber":null,"areYouBeingCompensated":null,"otherDescription":"Test Desc","subjectOfAppearance":null,"compensationType":null,"address":{"addressLine1":"1 wall street","addressLine2":"","county":"New York","city":"New York","zipCode":"10011","country":"United States (US)","stateName":"New York","countryId":229,"stateId":40},"isSelfCertifiedApplication":false,"person":{"personId":"0","isIndividualsPartnersAssociatedWithEntity":"","firstName":"Automation","middleName":"","lastName":"Automation","suffix":"","socialSecurityNo":"","birthDate":"","email":"","age":"","choosedEntity":""},"communication":{"email":"sbandi@svam.com","confirmEmail":"sbandi@svam.com","phones":[],"id":0},"phoneDetails":{"phoneType":"","countryCode":"","phone":"","phoneExtension":"","phoneId":0},"contactTypeText":""}
    When method post
    Then status 200
    And def serverResponse = response
   
    
   
    
# ********* Application SUBMIT ********************* 
    
    
    Given path '/internalapi/api/licensing/app/submit'
    And header authorization = 'Bearer ' + strToken
    And request {"appId":'#(appId)',"wfType":null}
    When method post
    Then status 200
    And def serverResponse = response
   
    And match response.success == true
  
  

 # ********* AssignApplicationsToExaminer *********************
    Given path '/internalapi/api/licensing/examiner/assignApplicationsToExaminer'
    
    And header authorization = 'Bearer ' + strToken
    And request [{"appId":'#(appId)',"examinerId":1069,"priority":"Normal"}]
    When method post
    And def serverResponse = response
   
    
    
    
 
    
 # ********* Examiner Review Approval to LB ********************* 
#
    Given path '/internalapi/api/licensing/examiner-review/SaveNewLicense'
    
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
    And request {"isFingerPrintsApproved":false,"isFingerPrintsRequired":false,"isCorpLLCDissolved":false,"isCorpLLCDTaken":false,"isSendPDLetter":false,"isDisable500LB_FBPT":false,"isDisableLBForPD":false,"isDisableLBForCaseClosed":false,"isDisableLateRenewalAndUnderpayment":false,"isLiquidatorPermitHasCompleted":-1,"isSubmit":true,"fieldDeficiencies":[],"masterFileData":[],"combinedCraftData":[],"application":{"applicationCategory":1,"appId":'#(appId)',"applicationId":'#(ApplicationId)',"licePermitTypeId":null,"applicationTypeId":1,"formVersionId":1231,"formId":'#(formId)',"legalName":"Automation  Automation","submitDate":'#(formatedSumbitDate)',"isGISRequired":null,"licenseDescription":'#(description)',"recommendedDecisionId":null,"status500":null,"isApplicableForPDLetter":false,"countyName":"New York","priority":"Normal","expirationDate":null,"appStatusId":3,"taskStatus":"Awaiting Review","taskId":1026,"currentWfstatus":null,"communityBoard":null,"isLicenseApplication":true,"currentDueDate":null,"isFinalDeficiency":null,"isHighlyDeficient":false,"isAllDeficienciesMet":null,"pastDueDate":null,"memo":null,"isOneTimePermit":null,"dueDateAction":null,"isDisapprovedForCause":false,"isNotQualified":false,"eventDate":null,"appStatus":{"appStatusId":3,"statusDescription":"Under Review","isActive":true,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"applicationType":null,"assignAppExaminer":{"appExaminerId":1069,"appId":'#(appId)',"examinerId":1069,"name":null,"assignDate":'#(formatedSumbitDate)',"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"assignAppToLB":null,"licePermitType":{"licPermitTypeId":'#(mainLicensePermitTypeId)',"type":"1","category":"1","product":'#(productName)',"class":null,"description":null,"sectionOfLaw":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null,"isTempPermit":false,"isELicensingPermit":false,"isAdditionalBar":false},"assoApplicationList":[],"isTempPermit":null,"isTempOrLiq":false,"licPermitTypeId":'#(mainLicensePermitTypeId)',"isAssociatedLicense":null,"effectiveDate":null,"assignedUserId":null,"amendmentTypeId":null,"amendmentType":null,"disapprovedDate":null,"condApprovedDate":null,"addressId":null,"isCaseOpen":null,"isClosed":null,"isSpecialEventPlusFour":null,"isSpecialEventInsideFiveBoroughs":null,"licStatus":null,"createdBy":null,"licenseId":null,"address":null,"isNybeApp":false,"isHearingCompleted":null,"does500FtHearingExist":null,"parentAppStatus":null,"premisesAppCount":0,"statusDescription":null,"eventAddress":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskRoleId":0,"taskDecision":null,"isActive":true,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":'#(formatedSumbitDate)'},"appId":'#(appId)',"notificationTypeId":2028,"applicationType":1,"decisionType":{"name":"Send to Licensing Board","value":2},"emailNotificationModel":{"applicant":{},"attorney":{},"communityBoard":{},"other":{}},"hasErrors":[],"taskId":1026,"newComments":"","recommendedDecisionId":null}
    When method post
    Then status 200
   
    
   
 # ********* LB Claiming Queue  ********************* 
 
    Given path 'internalapi/api/licensing/claiming-queue/add/'+appId +'/1069'
    And header authorization = 'Bearer ' + strToken
    And header current-wfroleid = 5
    And request {}
    When method post
    Then status 200
   
    
 # ********* LB Disapproval *********************    
   
    
    Given path '/internalapi/api/licensing/new-license/saveDecision'
    And header authorization = 'Bearer ' + strToken
    And header current-wfroleid = 5
    And request {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"appId":'#(appId)',"applicationType":1,"applicationId":'#(ApplicationId)',"legalName":"Auto License","statusId":3,"decisionType":{"name":"Disapproved","value":2},"emailNotificationModel":{"applicant":{"communicationId":11786,"email":"automation@test.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}},"hasErrors":[],"licPermitTypeId":58,"taskId":1151,"newComments":"test","disApproval":{"isDisapprovalForCause":true,"isDisapprovalLetterAttach":true,"selectInput":{"fromFields":[{"id":2,"label":"A temporary permit for a New York City premises may not be considered for approval, unless a contract of sale is submitted with the application.  No contract of sale was submitted for this transaction."},{"id":1,"label":"A temporary permit may not be considered for approval unless it is preceded or accompanied by an application for a permanent license."},{"id":3,"label":"A liquidator’s permit may not be considered for approval when the application it is filed in conjunction with is disapproved."},{"id":4,"label":"A liquidator’s permit may not be approved when the seller of the alcohol is currently in arrears and on the Authority’s COD List.  The seller will need to clear all accounts in arrears and re-apply."},{"id":5,"label":"An insufficient fee was submitted with the application.  Total fee due was $___ and the total fee paid was $_____"},{"id":6,"label":"Check number ____ in the amount of ________ , for payment in connection with this application was returned due to insufficient funds.  A request for certified funds was sent to the applicant on _________, to which there was no reply."},{"id":7,"label":"Licensees are not eligible to change corporate entities using an endorsement/corporate change application.  A licensee forming a new entity and using a new FEIN# must file a new application under the new corporate entity."},{"id":8,"label":"Endorsement applications may not be used to change an application from an executor of an estate to a corporation.  A new application must be filed once the estate is settled."},{"id":9,"label":"Licensee is not eligible to file a removal under a new corporate entity.  Licensee must file a new application for the new corporate entity with the new FEIN #."},{"id":10,"label":"The applicant submitted an outdated application form that is no longer accepted for processing as of 11/30/13."},{"id":11,"label":"Temporary retail permit was received with an outdated main application."},{"id":12,"label":"The corporate change filed under this serial number is a duplicate of a corporate change filed on _______________under _________________________________, serial number __________."}],"toFields":[],"isRewritable":true,"rewriteLabel":"Edit Reason for Disapproval:","additionalComments":"test eeee","srclabel":"Select","dstlabel":"Add to Notification","additionalLabel":"Additional Reasons for Disapproval:"},"disapprovalReason":[-1],"descriptions":["test eeee"]},"approval":{"isDefineStipulations":null,"selectInput":{"fromFields":[{"id":1,"label":"Inside of premises closes at x"},{"id":2,"label":"Side walk café closes at x"},{"id":3,"label":"Backyard closes at x"},{"id":4,"label":"Alcohol consumption inside stops at X"},{"id":5,"label":"Alcohol consumption in backyard stops at x"},{"id":6,"label":"Alcohol consumption on sidewalk café stops at x"},{"id":7,"label":"No live music in inside of premises"},{"id":8,"label":"No live music outside of premise"},{"id":9,"label":"No DJs"},{"id":10,"label":"No promoters"},{"id":11,"label":"No Promoted events"},{"id":12,"label":"Recorded music only"},{"id":13,"label":"Music stops at X"},{"id":14,"label":"Music outside stops at X"},{"id":15,"label":"Only non-amplified music"},{"id":16,"label":"Acoustic music only"},{"id":17,"label":"No bar crawls"},{"id":18,"label":"Close façade doors at certain time"},{"id":19,"label":"Close Windows at a certain time"},{"id":20,"label":"No boozy brunches"},{"id":21,"label":"No unlimited drink"},{"id":22,"label":"No happy Hours"},{"id":23,"label":"No bottle service "},{"id":24,"label":"No dancing"},{"id":25,"label":"No delivery bikes"},{"id":26,"label":"No TVs"},{"id":27,"label":"Licensed patio"},{"id":28,"label":"Licensed sidewalk café"},{"id":29,"label":"No outside areas"},{"id":30,"label":"Security Guards required"},{"id":31,"label":"X amount of security guards per x amount of patrons"},{"id":32,"label":"# of security guards per patron"},{"id":33,"label":"No VIP"},{"id":34,"label":"No roped lines"},{"id":35,"label":"No hookah"},{"id":36,"label":"Doors closed at all times"},{"id":37,"label":"Windows closed at all time"},{"id":38,"label":"All agreed upon CB stipulations except"},{"id":39,"label":"All employees must be TIPS trained"},{"id":40,"label":"ABC"}],"toFields":[],"isRewritable":true,"rewriteLabel":"Edit Stipulation:","additionalComments":"","srclabel":"Select Stipulations","dstlabel":"Add to Certificate","additionalLabel":"Add Additional Stipulations:"},"effectiveDate":"2022-04-13","expirationDate":"2025-04-30"}}
     
     When method post
    Then status 200
    And def serverResponse = response
   
          
  # ********* GET License Id *********************  
  
    Given path '/internalapi/api/application/preview/' + appId
    And header authorization = 'Bearer ' + strToken
    And request {}
    When method get
    Then status 200
    And def serverResponse = response
   
    And print 'serverResponse : ' , serverResponse
    And def appStatus = serverResponse.appStatus.statusDescription
   
    And match appStatus == 'Disapproved'
    
  
   #Given path '/internalapi/api/Communication/GetEmailCommQueue/licensePermit/'+appId
   #* def dbSts = db.getApprovalLicenseEmailMapping((appId+''))
	#And print dbSts
 	#And header authorization = 'Bearer ' + strToken
  	#And header Content-Type = 'application/json; charset=utf-8'
    #And header Accept = 'application/json; text/plain;*/*'
   #And header user-agent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36'
  	#And request ""
    #When method get
    #Then status 200
    # And def serverResponse = response
    
 	# * match serverResponse[0].status == 'Sent'
 	
 Examples:
    | read('/LicenseInputs/DisapproveLicAPP.csv') |
   



 
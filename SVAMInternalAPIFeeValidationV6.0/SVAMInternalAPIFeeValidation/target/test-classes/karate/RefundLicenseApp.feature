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
     * def ancLicFees = <AncillaryFees>
     
     	
      * def fillingFees = <NonRefundableFilingFees>
     And print fillingFees
     	
      * def renewalFees = <RenewalFilingFees>+''
     And print renewalFees
     	
     
    
    * string productName = <ProductTypes>+''
     * def totalFees = licenseFees  + fillingFees +ancLicFees
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
   
    
 # ********* Right to Premise ********************* 
    
    
   
    
   Given path '/internalapi/api/licensing/app/save'
    And header authorization = 'Bearer ' + strToken
    And request {"isApproved":false,"appId":'#(appId)',"formID":'#(formId)',"applicationID":"","formName":'#(description)',"formType":{},"formTypeId":null,"applicationType":{},"applicationTypeId":null,"formCategory":{},"formCategoryId":null,"approvalFlag":null,"status":"","createdBy":"","createdDate":"","modifiedBy":"","sections":[{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1957,"key":"","label":"By what right does the applicant have possession of the premises?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1958,"key":"","label":"Explain","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"No","fieldID":1959,"key":"","label":"Do the terms of the lease or other arrangement require the applicant to provide any consideration based on a percentage of the receipts of the business?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1960,"key":"","label":"If yes, list the section/page of the lease this information can be found","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"No","fieldID":1961,"key":"","label":"Does or will anyone other than the applicant/principals share on a percentage basis or in any way in the receipts, losses, or deficiencies of the business to any extent whatsoever","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1226,"sectionName":"","key":"0","label":"Right to Premises","order":5,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"Robert","fieldID":1685,"key":"","label":"","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1686,"key":"","label":"","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"Pascal","fieldID":1687,"key":"","label":"","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"1 wall street","fieldID":1697,"key":"","label":"","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1698,"key":"","label":"","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"New York","fieldID":1699,"key":"","label":"","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"1","fieldID":1700,"key":"","label":"","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"10011","fieldID":1701,"key":"","label":"","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1754,"key":"","label":"","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1934,"key":"","label":"","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1935,"key":"","label":"","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1218,"sectionName":"","key":"0","label":"Other Interested","order":1,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]}],"sectionFieldOrders":[]}],"formVersionId":1231,"version":7,"licenseDescription":"","statusDescription":"Draft","appStatusId":1,"showApplicant":true,"showRepresentative":true,"showPrincipal":true,"showLandlord":true,"showVehicles":false,"showSchedule":false,"staticTabSequence":{"Applicant Information":0,"Principal":1,"Representative":2,"Landlord Identification":3,"Personal Questionnaire":4},"staticTaborder":["Applicant Information","Principal","Representative","Landlord Identification","Personal Questionnaire"],"showPQ":true}
    When method post
    Then status 200
    And def serverResponse = response
    
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
	  
	 # And def totalFees = licInitialFees+licfilingFees+licAncillaryFees
	  #And print totalFees  
	  
	  
	  
 	Given path '/internalapi/api/notification/SaveNotification'
      
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {"applicant":{"communicationId":8531,"email":"automation@test.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"}
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
     			  
      And request {"checks":[{"appId":'#(appId)',"slaintakeDate":"2022-03-24T09:42:15.865Z","applyClick":false,"paymentSource":"RDC","checkNo":"1","batchNo":1,"itemNo":1,"slareceivedDate":"2022-03-24T00:00:00.000Z","amount":40000}],"appFees":{"appFees":[{"licenseName":'#(description)',"applicationId":'#(ApplicationId)',"applicationTypeId":1,"appFeesId":0,"appId":'#(appId)',"feesRefId":'#(licFeesRefId)',"initialFees":0,"licensingFees":'#(licenseFees)',"amendmentFees":"0.00","renewalFees":"0.00","totalFees":'#(totalFees)',"filingFees":'#(licfilingFees)',"ancillaryFees":"0.00","isFeesWaived":false,"underPaymentAmount":'#(totalFees)',"amountReceived":"0.00","waivedComment":null,"isBondReceived":false,"isBondRequired":false,"bondFee":0,"term":'#(licTerm)',"termDesc":'#(licTermDesc)',"seasonalStartDate":null,"seasonalEndDate":null,"isFeesCountBased":false,"isFeesUnitBased":false,"numOfUnits":0,"paymentDetails":[],"lateFee":0,"isFeesBarPerDay":null}],"bondDetails":null,"isPaymentFailed":false,"isUnderpaid":true,"sendNotification":false,"fundDueDate":"2022-03-31T00:00:00.000Z","emailNotificationDetail":{"applicant":{"communicationId":15102,"email":"automation@test.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"}},"notificationDetails":{"applicant":{"communicationId":15102,"email":"automation@test.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"},"taskId":null}
     When method post
	  Then status 200

  Given path '/internalapi/api/licensing/fees/licenses/get/'+appId
    And header authorization = 'Bearer ' + strToken
    And request {}
    When method get
    Then status 200
    And def checkDetailId = response[0].checkDetailId
    And print checkDetailId

  Given path '/internalapi/api/licensing/fees/check-payments/get/'+appId
    And header authorization = 'Bearer ' + strToken
    And request {}
    When method get
    Then status 200
    And def checkDetailId = response[0].checkDetailId
    And print checkDetailId
 
 Given path '/internalapi/api/licensing/fees/details/save/'+appId +'/false'
     * def licFeesDate =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		  
		  
		  """
	* def slaDate = licFeesDate()
	 * def licDate =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		  
		  
		  """
		  
		  * def slaaDate = licDate()
	* def licInitialFees1 = licInitialFees+''
	And print licInitialFees1
	* def renewalFees1 = renewalFees+''
	And print renewalFees1
	* def totalFees1 = totalFees+''
	* def overpaid = totalFees-40000
	* def overpaid1 = 40000 - totalFees
		And print totalFees1
	* def licAncillaryFees1 = licAncillaryFees+''
	* def licfilingFees1 = licfilingFees+''
		
    And header authorization = 'Bearer ' + strToken
	And request {"checks":[{"checkDetailId":'#(checkDetailId)',"appId":'#(appId)',"paymentSource":"RDC","checkNo":"1","batchNo":"1","itemNo":"1","slareceivedDate":'#(slaaDate)',"slaintakeDate":'#(slaaDate)',"amount":40000,"appliedTo":null,"amountUsed":40000,"comment":null,"isReplacement":null,"replacementReason":null,"isActive":true,"createdBy":"tgupta@svam.com","createdDate":"2022-04-11T09:43:00.873","modifiedBy":null,"modifiedDate":null,"applyClick":true,"amountAvailable":0}],"appFees":{"appFees":[{"licenseName":'#(description)',"applicationId":'#(ApplicationId)',"applicationTypeId":1,"appFeesId":'#(licFeesRefId)',"appId":'#(appId)',"feesRefId":'#(licFeesRefId)',"initialFees":0,"licensingFees":'#(licenseFees)',"amendmentFees":"0.00","renewalFees":"0.00","totalFees":'#(totalFees1)',"filingFees":'#(licfilingFees1)',"ancillaryFees":'#(licAncillaryFees1)',"isFeesWaived":false,"underPaymentAmount":'#(overpaid)',"amountReceived":"40000.00","waivedComment":null,"isBondReceived":false,"isBondRequired":false,"bondFee":0,"term":'#(termInYears)',"termDesc":'#(termDesc)',"seasonalStartDate":null,"seasonalEndDate":null,"isFeesCountBased":false,"isFeesUnitBased":false,"numOfUnits":0,"paymentDetails":[{"appId":'#(appId)',"checkDetailId":'#(checkDetailId)',"checkNo":"1","itemNo":"1","batchNo":"1","amountAppliedForApp":"40000.00","amount":0}],"lateFee":0,"isFeesBarPerDay":null}],"bondDetails":null,"isPaymentFailed":false,"isUnderpaid":false,"sendNotification":false,"fundDueDate":"1970-01-01T00:00:00.000Z","emailNotificationDetail":{"applicant":{"communicationId":15102,"email":"automation@test.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"}},"notificationDetails":{"applicant":{"communicationId":15102,"email":"automation@test.com","appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)',"createdBy":"Tarun  Gupta"},"taskId":null}
		       # {"checks":[{"checkDetailId":2732,                    "appId":9873,"paymentSource":"RDC","checkNo":"1","batchNo":"1","itemNo":"1","slareceivedDate":"2022-04-09T18:30:00.000Z","slaintakeD     ,"amount":40000,"appliedTo":null,"amountUsed":40000,"comment":null,"isReplacement":null,"replacementReason":null,"isActive":true,"createdBy":"tgupta@svam.com","createdDate":"2022-04-11T11:20:06.63","modifiedBy":null,"modifiedDate":null,"applyClick":true,"amountAvailable":0}],"appFees":{"appFees":[{"licenseName":"Wholesale Beer - Beer","applicationId":"NA-0002-22-107296","applicationTypeId":1,"appFeesId":4737,"appId":9873,"feesRefId":5991,"initialFees":0,"licensingFees":"800.00","amendmentFees":"0.00","renewalFees":"0.00","totalFees":"1460.00","filingFees":"400.00","ancillaryFees":"260.00","isFeesWaived":false,"underPaymentAmount":-38540,                                                                       "amountReceived":"40000.00","waivedComment":null,"isBondReceived":false,"isBondRequired":false,"bondFee":0,"term":1,"termDesc":"1 Year (s)","                seasonalStartDate":null,"seasonalEndDate":null,"isFeesCountBased":false,"isFeesUnitBased":false,"numOfUnits":0,"paymentDetails":[{"appId":9873,"checkDetailId":2732,                    "checkNo":"1","itemNo":"1","batchNo":"1","amountAppliedForApp":"40000.00","amount":0}],"lateFee":0,"isFeesBarPerDay":null}],"bondDetails":null,"isPaymentFailed":false,"isUnderpaid":false,"sendNotification":true,"fundDueDate":"1970-01-01T05:30:00.000Z","emailNotificationDetail":{"applicant":{"communicationId":00000 ,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":9873,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":9873,"createdBy":"Tarun  Gupta"}},"notificationDetails":{"applicant":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":9873,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":9873,"createdBy":"Tarun  Gupta"},"taskId":null}
		 
		 When method post
    Then status 200
    And print response
		
		
		
 
 
 
   
    
    
    
    
# ********* SAVE Application Details To Save *********************
    Given path '/internalapi/api/licensing/app/save'
    And header authorization = 'Bearer ' + strToken
    And request {"isApproved":false,"appId":'#(appId)',"formID":'#(formId)',"applicationID":'#(ApplicationId)',"formName":'#(description)',"formType":{},"formTypeId":null,"applicationType":{},"applicationTypeId":null,"formCategory":{},"formCategoryId":null,"approvalFlag":null,"status":"","createdBy":"","createdDate":"","modifiedBy":"","sections":[{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1842,"key":"","label":"Signature","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1843,"key":"","label":"Date","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1851,"key":"","label":"Title","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"dropdown","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2232,"key":"","label":"First Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2233,"key":"","label":"Middle Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2234,"key":"","label":"Last Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1200,"sectionName":"","key":"0","label":"Applicant Statement","order":9,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1957,"key":"","label":"By what right does the applicant have possession of the premises?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1958,"key":"","label":"Explain","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1959,"key":"","label":"Do the terms of the lease or other arrangement require the applicant to provide any consideration based on a percentage of the receipts of the business?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1960,"key":"","label":"If yes, list the section/page of the lease this information can be found","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1961,"key":"","label":"Does or will anyone other than the applicant/principals share on a percentage basis or in any way in the receipts, losses, or deficiencies of the business to any extent whatsoever","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1226,"sectionName":"","key":"0","label":"Right to Premises","order":5,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1685,"key":"","label":"First Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1686,"key":"","label":"Middle Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1687,"key":"","label":"Last Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"1 wall street","fieldID":1697,"key":"","label":"Address Line 1/ POB #","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":6,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1698,"key":"","label":"Address Line 2","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":7,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"New York","fieldID":1699,"key":"","label":"City","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":8,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1700,"key":"","label":"State/Region","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":9,"controlType":"dropdown","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"10011","fieldID":1701,"key":"","label":"Zip/Postal Code","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":10,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1754,"key":"","label":"Address","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"label","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1934,"key":"","label":"Nature of Interest","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1935,"key":"","label":"Date acquired","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1218,"sectionName":"","key":"0","label":"Other Interested","order":1,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]}],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1933,"key":"","label":"Signature","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1936,"key":"","label":"Date","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1239,"sectionName":"","key":"0","label":"Bulletin 254","order":10,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2053,"key":"","label":"Describe the area where the premises is to be located","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2054,"key":"","label":"State what the area is zoned for","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2055,"key":"","label":"Provide a description of the premises to be licensed. Describe all building/structures that will be utilized in business operations including the number of floors in each.","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2056,"key":"","label":"has the building/premises been known by any other address?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2057,"key":"","label":"If yes, please Specify","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2058,"key":"","label":"has the premises to be licensed and or any other floor in the building been previously licensed or currently licensed to traffic in alcoholic beverages?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2059,"key":"","label":"What was the prior use of the premises to be licensed?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":6,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2060,"key":"","label":"Does the proposed location of the business comply with all state and local regulations and zoning codes?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":7,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2061,"key":"","label":"is there interior access to any other floor that will not be part of the licensed premises?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":8,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2062,"key":"","label":"if yes, list floor and means of access to each floor.","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":9,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2063,"key":"","label":"Does any other person have access to this area?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":10,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2064,"key":"","label":"where will the alcohol be stored","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":11,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2065,"key":"","label":"if applying for a farm winery license, special farm winery license or micro winery license, the premises must be located on a farm. In the box below, please provide a detailed description of the agricultural production that qualifies the premises as a farm","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":12,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1248,"sectionName":"","key":"0","label":"Premises Questionnaire","order":7,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1988,"key":"","label":"Will any other business of any kind be conducted on said premises?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1989,"key":"","label":"How many Employees?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1990,"key":"","label":"If answer is 0, provide explanation","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1991,"key":"","label":"Workers' Compensation Carrier Name and Policy Number?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1992,"key":"","label":"Disability Insurance Carrier name and policy Number","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2050,"key":"","label":"Check all activities the business will engage in","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"checkbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1249,"sectionName":"","key":"0","label":"Method of Operation","order":8,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]},{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2072,"key":"","label":"Real Property","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2073,"key":"","label":"Purchase/Contract Price of Business","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2074,"key":"","label":"Renovations/Improvement Costs","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2075,"key":"","label":"Miscellaneous","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2076,"key":"","label":"Cash","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"label","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2077,"key":"","label":"Source of Funds","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2078,"key":"","label":"Personal Questionnaire attached","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":6,"controlType":"checkbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2079,"key":"","label":"Dollar Amount","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":7,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2080,"key":"","label":"Total Cash","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":8,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2081,"key":"","label":"Borrowed","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":9,"controlType":"label","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2082,"key":"","label":"Source of Funds","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":10,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2083,"key":"","label":"Personal Questionnaire attached","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":11,"controlType":"checkbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2084,"key":"","label":"Dollar Amount","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":12,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2085,"key":"","label":"Total Borrowed","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":13,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2086,"key":"","label":"Total Investment","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":14,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":2087,"key":"","label":"Have all investors been disclosed in this application","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":15,"controlType":"radio","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1253,"sectionName":"","key":"0","label":"Financial Disclosure","order":6,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"subSections":[],"sectionFieldOrders":[]}],"formVersionId":1231,"version":7,"licenseDescription":"","statusDescription":"Draft","appStatusId":1,"showApplicant":true,"showRepresentative":true,"showPrincipal":true,"showLandlord":true,"showVehicles":false,"showSchedule":false,"staticTabSequence":{"Applicant Information":0,"Principal":1,"Representative":2,"Landlord Identification":3,"Personal Questionnaire":4},"staticTaborder":["Applicant Information","Principal","Representative","Landlord Identification","Personal Questionnaire"],"showPQ":true}
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
   
    
 # ********* LB Approval *********************    
   
    
    Given path '/internalapi/api/licensing/new-license/saveDecision'
    And header authorization = 'Bearer ' + strToken
    And header current-wfroleid = 5
    And request {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"masterFileData":[],"combinedCraftData":[],"appId":'#(appId)',"applicationType":1,"applicationId":'#(ApplicationId)',"legalName":null,"statusId":3,"decisionType":{"name":"Approved","value":1},"emailNotificationModel":{"applicant":{},"attorney":{},"other":{"email":""}},"hasErrors":[],"taskId":1151,"newComments":"","approval":{"isDefineStipulations":false,"selectInput":{"fromFields":[{"id":1,"label":"Inside of premises closes at x"},{"id":2,"label":"Side walk café closes at x"},{"id":3,"label":"Backyard closes at x"},{"id":4,"label":"Alcohol consumption inside stops at X"},{"id":5,"label":"Alcohol consumption in backyard stops at x"},{"id":6,"label":"Alcohol consumption on sidewalk café stops at x"},{"id":7,"label":"No live music in inside of premises"},{"id":8,"label":"No live music outside of premise"},{"id":9,"label":"No DJs"},{"id":10,"label":"No promoters"},{"id":11,"label":"No Promoted events"},{"id":12,"label":"Recorded music only"},{"id":13,"label":"Music stops at X"},{"id":14,"label":"Music outside stops at X"},{"id":15,"label":"Only non-amplified music"},{"id":16,"label":"Acoustic music only"},{"id":17,"label":"No bar crawls"},{"id":18,"label":"Close façade doors at certain time"},{"id":19,"label":"Close Windows at a certain time"},{"id":20,"label":"No boozy brunches"},{"id":21,"label":"No unlimited drink"},{"id":22,"label":"No happy Hours"},{"id":23,"label":"No bottle service "},{"id":24,"label":"No dancing"},{"id":25,"label":"No delivery bikes"},{"id":26,"label":"No TVs"},{"id":27,"label":"Licensed patio"},{"id":28,"label":"Licensed sidewalk café"},{"id":29,"label":"No outside areas"},{"id":30,"label":"Security Guards required"},{"id":31,"label":"X amount of security guards per x amount of patrons"},{"id":32,"label":"# of security guards per patron"},{"id":33,"label":"No VIP"},{"id":34,"label":"No roped lines"},{"id":35,"label":"No hookah"},{"id":36,"label":"Doors closed at all times"},{"id":37,"label":"Windows closed at all time"},{"id":38,"label":"All agreed upon CB stipulations except"},{"id":39,"label":"All employees must be TIPS trained"}],"toFields":[],"isRewritable":true,"rewriteLabel":"Edit Stipulation:","srclabel":"Select Stipulations","dstlabel":"Add to Certificate","additionalLabel":"Add Additional Stipulations:"},"effectiveDate":"2022-01-10","expirationDate":"2022-08-31","stipulations":[],"descriptions":[]}}
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
    And def refundid = db.getLastCreatedRefundID()
    And print refundid
    # ********* GET GenerateVoucherNo Id *********************  
  
   # Given path '/internalapi/api/refund/GenerateVoucherNo/' + refundid
   # And header authorization = 'Bearer ' + strToken
   # And request {}
   # When method get
   # Then status 200
   # And def serverResponse = response
   # And def voucherNumber = serverResponse.value
    
  # ********* GET License Id *********************  
  
    Given path '/internalapi/api/appContact/GetContactAddressByAppIdAndType/Application/' + appId +'/'+appId+'/114'
    And header authorization = 'Bearer ' + strToken
    And request {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"masterFileData":[],"combinedCraftData":[],"appId":'#(appId)',"applicationType":1,"applicationId":'#(ApplicationId)',"legalName":null,"statusId":3,"decisionType":{"name":"Approved","value":1},"emailNotificationModel":{"applicant":{},"attorney":{},"other":{"email":""}},"hasErrors":[],"taskId":1151,"newComments":"","approval":{"isDefineStipulations":false,"selectInput":{"fromFields":[{"id":1,"label":"Inside of premises closes at x"},{"id":2,"label":"Side walk café closes at x"},{"id":3,"label":"Backyard closes at x"},{"id":4,"label":"Alcohol consumption inside stops at X"},{"id":5,"label":"Alcohol consumption in backyard stops at x"},{"id":6,"label":"Alcohol consumption on sidewalk café stops at x"},{"id":7,"label":"No live music in inside of premises"},{"id":8,"label":"No live music outside of premise"},{"id":9,"label":"No DJs"},{"id":10,"label":"No promoters"},{"id":11,"label":"No Promoted events"},{"id":12,"label":"Recorded music only"},{"id":13,"label":"Music stops at X"},{"id":14,"label":"Music outside stops at X"},{"id":15,"label":"Only non-amplified music"},{"id":16,"label":"Acoustic music only"},{"id":17,"label":"No bar crawls"},{"id":18,"label":"Close façade doors at certain time"},{"id":19,"label":"Close Windows at a certain time"},{"id":20,"label":"No boozy brunches"},{"id":21,"label":"No unlimited drink"},{"id":22,"label":"No happy Hours"},{"id":23,"label":"No bottle service "},{"id":24,"label":"No dancing"},{"id":25,"label":"No delivery bikes"},{"id":26,"label":"No TVs"},{"id":27,"label":"Licensed patio"},{"id":28,"label":"Licensed sidewalk café"},{"id":29,"label":"No outside areas"},{"id":30,"label":"Security Guards required"},{"id":31,"label":"X amount of security guards per x amount of patrons"},{"id":32,"label":"# of security guards per patron"},{"id":33,"label":"No VIP"},{"id":34,"label":"No roped lines"},{"id":35,"label":"No hookah"},{"id":36,"label":"Doors closed at all times"},{"id":37,"label":"Windows closed at all time"},{"id":38,"label":"All agreed upon CB stipulations except"},{"id":39,"label":"All employees must be TIPS trained"}],"toFields":[],"isRewritable":true,"rewriteLabel":"Edit Stipulation:","srclabel":"Select Stipulations","dstlabel":"Add to Certificate","additionalLabel":"Add Additional Stipulations:"},"effectiveDate":"2022-01-10","expirationDate":"2022-08-31","stipulations":[],"descriptions":[]}}
    When method get
    Then status 200
    And def serverResponse = response
    And def addressLine1 = serverResponse.addressLine1
    And def city = serverResponse.city
    And def county = serverResponse.county
    And def zip4 = serverResponse.zip4
    And def zipCode = serverResponse.zipCode
    And def addressId = serverResponse.addressId
    
    
 # ********* Refund Take Action *********************    
   
    
    Given path '/internalapi/api/refund/SubmitRefund'
    And header authorization = 'Bearer ' + strToken
    
    * def dateFormat =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SS");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		  
		  
		  """
		  
   * def issueDate111 =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  }
		  """
	
      * def currentDate = dateFormat()
	  * def issueDate1 = issueDate111()
 
     And def voucherNumber = db.getLastCreatedVoucherNumber()
    
    And request {"refundId":'#(refundid)',"acatype":"Application","acaId":'#(appId)',"refundAmt":'#(overpaid1)',"voucherNo":'#(voucherNumber)',"addressId":'#(addressId)',"isAdditionalInfoRequired":false,"additionalInformation":null,"deliveryAddressType":"114","comment":null,"subTotal":'#(overpaid1)',"surrenderFee":30,"isSubmit":true,"newVoucherNo":null,"principalId":null,"resubmitComment":null,"refundCriteriaIds":[],"additionalInfoReceived":null,"isAdditionalInfoSatisfied":null,"addInfoComment":null,"addInfoRecComment":null,"isAdditionalFlow":null,"addressDto":null,"refundDetails":[{"acaId":'#(appId)',"appFeesId":'#(licFeesRefId)',"applicationId":'#(ApplicationId)',"licenseDescription":'#(description)',"licensePermitStatus":"Approved","disApprovalDate":null,"licensingFees":'#(licenseFees)',"filingFees":'#(fillingFees)',"ancillaryFees":'#(ancLicFees)',"totalFees":'#(totalFees)',"overPayment":'#(overpaid1)',"refundAmount":'#(overpaid1)',"surrenderDate":null,"expirationDate":"2022-08-31T00:00:00","issueDate":'#(issueDate1)',"amountDue":'#(totalFees)',"totalPaid":40000,"calculatedOverPayment":'#(overpaid1)',"calculatedRefundAmount":'#(overpaid1)',"calculatedSurrenderValue":null,"formId":'#(formId)',"amendmentFees":0,"renewalFees":0,"applicationTypeId":1,"lateFee":0}],"refundClaimedDto":null,"refundUnclaimedDto":null,"sfsReportDtos":null,"emailNotificationModel":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":"Approved","taskId":4502,"taskRoleId":0,"taskDecision":null,"isActive":true,"createdBy":null,"createdDate":'#(currentDate)',"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}
    When method post
    Then status 200
    And def serverResponse = response
    And match serverResponse == 'true'
    
  # ********* Refund DOL SubmitDolClaim *********************    
   Given path '/internalapi/api/dolDtf/SubmitDolClaim'
     And header authorization = 'Bearer ' + strToken
    * def refundClaimID = db.getRefundClaimID()
    And request {"refundClaimId":'#(refundClaimID)',"dolclaimAmt":100,"refundId":'#(refundid)',"acaId":'#(appId)',"refundAmt":'#(overpaid1)',"taskId":4508}
               
    When method post
    Then status 200
    And def serverResponse = response
    And match serverResponse == 'true'
      
    
 	  
  # ********* Refund DTF SubmitDolClaim *********************    
   Given path '/internalapi/api/dolDtf/SubmitDtfClaim'
     And header authorization = 'Bearer ' + strToken
    And request {"refundClaimId":'#(refundClaimID)',"dtfclaimAmt":100,"refundId":'#(refundid)',"acaId":'#(appId)',"refundAmt":'#(overpaid1)',"taskId":4509}
    When method post
    Then status 200
    And def serverResponse = response
    And match serverResponse == 'true'
   
   
   
   # ********* RefundSend to SFS *********************    
   
    
    Given path '/internalapi/api/RefundSfs/SendToSfs'
    And header authorization = 'Bearer ' + strToken
      * def currentDate = dateFormat()
	  * def issueDate1 = issueDate111()
      * def restAmount = totalFees - 200
     And def voucherNumber = db.getLastCreatedVoucherNumber()
    
    And request {"refundId":'#(refundid)',"acatype":"Application","acaId":'#(appId)',"refundAmt":'#(overpaid1)',"voucherNo":'#(voucherNumber)',"addressId":'#(addressId)',"isAdditionalInfoRequired":false,"additionalInformation":null,"deliveryAddressType":114,"comment":null,"subTotal":'#(overpaid1)',"surrenderFee":null,"isSubmit":true,"newVoucherNo":'#(voucherNumber)',"principalId":null,"resubmitComment":null,"refundCriteriaIds":null,"additionalInfoReceived":null,"isAdditionalInfoSatisfied":null,"addInfoComment":null,"addInfoRecComment":null,"isAdditionalFlow":null,"addressDto":null,"refundDetails":[{"acaId":'#(appId)',"appFeesId":'#(licFeesRefId)',"applicationId":'#(ApplicationId)',"licenseDescription":'#(description)',"licensePermitStatus":"Approved","disApprovalDate":null,"licensingFees":'#(licenseFees)',"filingFees":'#(fillingFees)',"ancillaryFees":'#(ancLicFees)',"totalFees":'#(totalFees)',"overPayment":'#(overpaid1)',"refundAmount":null,"surrenderDate":null,"expirationDate":"2022-08-31T00:00:00","issueDate":'#(issueDate1)',"amountDue":'#(totalFees)',"totalPaid":40000,"calculatedOverPayment":null,"calculatedRefundAmount":null,"calculatedSurrenderValue":null,"formId":'#(formId)',"amendmentFees":0,"renewalFees":0,"applicationTypeId":1,"lateFee":0}],"refundClaimedDto":{"refundClaimId":'#(refundClaimID)',"dtfclaimAmt":100,"dtfrefundAmt":100,"dolclaimAmt":100,"dolrefundAmt":100,"applicantClaimAmt":'#(restAmount)',"applicantRefundAmt":'#(restAmount)',"dtfcalculatedAmt":100,"dolcalculatedAmt":100,"applicantCalculatedAmt":'#(restAmount)',"refundId":'#(refundid)',"isSubmit":true,"refundAmt":null,"comment":null,"acaId":null,"isSameAsRequested":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":true,"createdBy":null,"createdDate":"2022-04-12T07:49:09.367","modifiedBy":"tgupta@svam.com","wfRoleId":0,"modifiedDate":"2022-04-12T08:01:28.183"},"refundUnclaimedDto":{"refundUnclaimedId":148,"refundId":836,"stopPaymentReasonId":null,"stopPaymentOtherReason":null,"comments":null,"isSubmit":true,"resubmitRefundReasonId":null,"additionalReasonToResubmit":null,"resubmitComment":null,"acaId":null,"voucherNo":"O00092","userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":true,"createdBy":"tgupta@svam.com","createdDate":"2022-04-12T07:49:09.35","modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"sfsReportDtos":null,"emailNotificationModel":{"applicant":{"communicationId":13346,"email":"automation@test.com","appId":10237,"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":13349,"email":"sbandi@svam.com","appId":'#(appId)',"emailContactTypeId":2,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":4973,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":4973,"notificationTypeId":2129,"createdBy":"Tarun  Gupta"},"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":"Approved","taskId":4513,"taskRoleId":0,"taskDecision":null,"isActive":true,"createdBy":null,"createdDate":"2022-02-28T20:11:11.47","modifiedBy":null,"wfRoleId":0,"modifiedDate":"2022-04-12T08:47:23.927"}
     When method post
    Then status 200
    And def serverResponse = response
    And match serverResponse == 'true'
    
    
    
    
 # ********* RefundSend to SFS *********************    
   
    
    Given path '/internalapi/api/RefundSfs/SubmitSfsReport/application/'+ApplicationId+'/true'
    #And header authorization = 'Bearer ' + strToken
    And request {}
    When method get
    Then status 200
    And print response
    And match response == 'true'
    

 Given path '/internalapi/api/refund/CustomSearch'
    And header authorization = 'Bearer ' + strToken
      * def currentDate = dateFormat()
	  * def issueDate1 = issueDate111()
      * def restAmount = totalFees - 200
     And def voucherNumber = db.getLastCreatedVoucherNumber()
    
    And request {"applicationId":'#(ApplicationId)',"searchForValue":"ApplicationLicenseID"}
                When method post
    Then status 200
    And def serverResponse = response
    And print serverResponse[0].taskStatus
    And match serverResponse[0].taskStatus == 'Refund Processed'
 	
 	
 Examples:
    | read('/LicenseInputs/RefundLicApp.csv') |
   



 
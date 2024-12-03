Feature: Surrender Methods
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
		  
		  
		   * def expirationDateFunc =
		  """
		  function(days) {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
		    
		    var date = new java.util.Date();
		    var dayAfter = new java.util.Date(date.getTime() + java.util.concurrent.TimeUnit.DAYS.toMillis( days));
		    return sdf.format(dayAfter);
		  } 
		  """
		  
		  
		   * def effectiveDateFunc =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'00:00:00.000'Z'");
		    
		    var date = new java.util.Date();
		    var dayAfter = new java.util.Date(date.getTime());
		    return sdf.format(dayAfter);
		  } 
		  """

@SearchLicPermitIdForSurrender
Scenario: SearchLicPermitIdForSurrender		 
	  Given path 'internalapi/api/licensing/surrender/searchLicensesOrPermitsForSurrender/'
      	And header Content-Type = 'application/json; charset=utf-8'
  	  	
		And header Accept = 'application/json; text/plain;*/*'
       	And header authorization = 'Bearer ' + strToken
       	* def payload = ""
       	* def payloadSearchByLegalName = {"showOnlyLicensesAssociated":false,"ApplicationId":null,"LicensePermitId":null,"LegalName":"automation","FEIN":null}
       	* def payloadSearchByLicId = {"showOnlyLicensesAssociated":false,"ApplicationId":null,"LicensePermitId":'#(licenseId)',"LegalName":null,"FEIN":null}
    	* eval if ( SearchByLicId == true) payload = payloadSearchByLicId
    	* eval if (SearchByLegalName == true) payload = payloadSearchByLegalName
    	And request payload
	   	When method post
	  	Then status 200	
	  
	  	* def randomNum = db.getRandomNumber(response.totalRecord)
	  	And print randomNum
	  	* def licAppId = response.licenses[randomNum].appId
	  	* def lpId = response.licenses[randomNum].lpId
	  	* def licPermitTypeId = response.licenses[randomNum].licPermitTypeId
	  	* def LicensePermitId = response.licenses[randomNum].licensePermitId
	  	* def LicensePermitId = response.licenses[randomNum].licensePermitId
	  	* def APPlicationId = response.licenses[randomNum].applicationId
	  	* def mainAppId = response.licenses[randomNum].appId

	  	And match licAppId != null
	  	And print LicensePermitId
		 
@IntakeSurrender
Scenario: IntakeAssociatedRenewalLicensePermit
   
   Given path 'internalapi/api/licensing/selectapptype/savesurrenderapp'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And configure continueOnStepFailure = true
   	 And request {"mainLicensePermitTypeId":'#(licPermitTypeId)',"masterFileId":null,"isApplicableForTempPermit":false,"newPermitTypeIds":[],"isNotQualified":false,"addBarList":[],"licensePermitTypeRef":'#(licPermitTypeId)',"LicensePermitId":'#(LicensePermitId)',"mainAppId":'#(mainAppId)',"surrenderLicPermitIds":[]}
	  When method Post
	  * configure continueOnStepFailure = true
	  Then status 200
	   * def description = response[0].description  
	  	* def appId = response[0].appId
	  	* def formId = response[0].formId
	  	* def ApplicationId = response[0].mainApplicationId
	  	* def licensePermitTypeId = response[0].licensePermitTypeId
	 	And print ApplicationId
		And match ApplicationId contains 'SU-'

@DraftSurrenderPreview
Scenario: DraftSurrenderPreview
   
   Given path 'internalapi/api/application/preview/'+appId
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And configure continueOnStepFailure = true
   	 And request {}
	  When method get
	  * configure continueOnStepFailure = true
	  Then status 200
	   * def statusDescription = response.appStatus.statusDescription  
	  	* def ApplicationId = response.applicationId 
	  	* def isPreFilled = response.isPreFilled 
	  	* def isTempPermit = response.licePermitType.isTempPermit
	 	And print ApplicationId
		And match ApplicationId contains 'SU-'	
		And match statusDescription == "Draft"
		And match isPreFilled == false

@SurrenderTabFill
Scenario: SurrenderTabFill
   
   Given path 'internalapi/api/licensing/app/save'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And configure continueOnStepFailure = true
   	 And request {"isApproved":false,"appId":'#(appId)',"formID":1147,"applicationID":"","formName":"Surrender","formType":{},"formTypeId":null,"applicationType":{},"applicationTypeId":6,"formCategory":{},"formCategoryId":1,"approvalFlag":null,"status":"","createdBy":"","createdDate":"","modifiedBy":"","sections":[{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"Yes","fieldID":1978,"key":"","label":"Has the licensee or (if a partnership) any of the partners or (if a corporation) any of the officers, directors or stockholders been arrested or indicted or served with a summons for any crime or offense (except traffic infractions or violations of the Administrative Code) in the past 12 months?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"Yes","fieldID":1979,"key":"","label":"Has any person other than reported in Question 1 above been arrested or indicted or served with a summons for any crime or offense committed on the licensed premises or which involved the licensed business (except violations of the Administrative Code) in the past 12 months?","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":"","fieldID":1980,"key":"","label":"Please specify the address where the refund, if any, is to be mailed","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":true,"fieldID":1981,"key":"","label":"The petitioner further states that the said licensee will, upon the surrender of said license, cease to traffic in alcoholic beverages during the term for which said license was issued and thereafter until a new license shall be issued to said licensee. WHEREFORE, the  petitioner asks that said license be cancelled and a refund made as provided in Section 127 of the Alcoholic Beverage Control Law.","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":1234,"sectionName":"AD_Surrender","key":"0","label":"Surrender","order":0,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isStatic":false,"isMultipleAllowed":false,"sectionType":null,"sectionSubTypeId":null,"parentSection":"","subSections":[{"show":true,"repeat":false,"isEditable":false,"fields":[{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":'#(Address1)',"fieldID":1697,"key":"","label":"Address Line 1/POB #","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":0,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":'#(Address2)',"fieldID":1698,"key":"","label":"Address Line 2","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":1,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":'#(CityName)',"fieldID":1699,"key":"","label":"City","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":2,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":40,"fieldID":1700,"key":"","label":"State/Region","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":3,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":'#(zipCode)',"fieldID":1701,"key":"","label":"Zip/Postal Code","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":4,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":'#(CountyName)',"fieldID":1702,"key":"","label":"County","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":6,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":229,"fieldID":1703,"key":"","label":"Country/Region","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":7,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":'#(postalCode)',"fieldID":1822,"key":"","label":"Zip+4","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":5,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""},{"dataSource":null,"show":true,"isSpecial":false,"sectionRepeatNo":1,"value":'#(CountyName)',"fieldID":2443,"key":"","label":"State Name","dataType":"text","required":false,"isSingleLine":true,"minLength":0,"maxLength":0,"order":9,"controlType":"textbox","defaultValue":"","format":"","isCalculatedField":false,"isEmptyField":false,"fieldName":"","columnName":"","expression":"","dataSourceId":0,"trigger":"","metaData":null,"createdBy":"","modifiedBy":""}],"sectionID":226,"sectionName":"Address","key":"0","label":"Address","order":1,"createdBy":"","createdDate":"","modifiedBy":"","tableName":"","isSpecial":false,"isStatic":false,"isMultipleAllowed":false,"sectionType":"Address","sectionSubTypeId":null,"parentSection":"","subSections":[],"sectionFieldOrders":[],"address":{"addressLine1":"","addressLine2":"","stateId":null,"county":"","city":"","zipCode":"","zip4":"","country":"United States (US)","stateName":"","countryId":229}}],"sectionFieldOrders":[],"address":{"addressLine1":"","addressLine2":"","stateId":null,"county":"","city":"","zipCode":"","zip4":"","country":"United States (US)","stateName":"","countryId":229}}],"formVersionId":1192,"version":1,"licenseDescription":'#(description)',"statusDescription":'#(statusDescription)',"appStatusId":1,"showApplicant":false,"showRepresentative":false,"showPrincipal":false,"showLandlord":false,"showVehicles":false,"showSchedule":false,"showAbcOfficer":false,"showCorpChange":false,"showEndorsement":false,"staticTabSequence":{},"staticTaborder":[],"showPQ":false,"showCC":false,"showManuOnPrem":false,"licPermitTypeId":'#(licPermitTypeId)',"tabVisitied":{}}
	  When method Post
	  * configure continueOnStepFailure = true
	  Then status 200

@SurrenderAddNotes
Scenario: SurrenderAddNotes
   
   Given path 'internalapi/api/note/application/save'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And configure continueOnStepFailure = true
   	 And request {"acaId":'#(appId)',"acaStatus":"completed","acatype":"application","noteDetail":'#(noteDetail)',"createdDate":'#(date)'}
	  When method Post
	  * configure continueOnStepFailure = true
	  Then status 200
	  * def noteDetail = response.noteDetail
	  * def isActive = response.isActive
	  * def noteId = response.noteId
	  * def acanoteId = response.acanoteId
	  
@SurrenderDeleteNotes
Scenario: SurrenderAddNotes
   
   Given path 'internalapi/api/note/application/delete/'+acanoteId
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And configure continueOnStepFailure = true
   	 And request {"acanoteId":'#(acanoteId)',"noteId":'#(noteId)',"acatype":"application","acaStatus":"completed","acaId":'#(appId)',"roleId":3,"bureauId":null,"noteDetail":'#(noteDetail)',"isEdit":true,"isDelete":true,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":true,"createdBy":"tgupta@svam.com","createdDate":'#(date)',"modifiedBy":null,"wfRoleId":0,"modifiedDate":null,"showEditDeleteIcon":true}
	  When method Post
	  * configure continueOnStepFailure = true
	  Then status 200

@SurrenderAddComments
Scenario: SurrenderAddComments
   
   Given path 'internalapi/api/comment/application/save'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And configure continueOnStepFailure = true
   	 And request {"acaId":'#(appId)',"acaStatus":"completed","acatype":"application","bureauId":1,"description":'#(Comment)'}
	  When method Post
	  * configure continueOnStepFailure = true
	  Then status 200
	  * def commentId = response.commentId
	  * def isActive = response.isActive
	  * def description = response.description
	  * def bureauId = response.bureauId
	  * def acacommentId = response.acacommentId
	  * def commentId = response.commentId

@SurrenderActionTabCommentCheck
Scenario: SurrenderActionTabCommentCheck
   
   Given path 'internalapi/api/comment/Application/get'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And configure continueOnStepFailure = true
   	 And request {"acaId":'#(appId)',"acacommentId":-1,"commentId":-1,"bureauId":'#(bureauId)',"acatype":"Application"}
	  When method Post
	  * configure continueOnStepFailure = true
	  Then status 200
	  * def descriptionCheck = response.description

@SaveSurrender
Scenario: SaveSurrender
   
   Given path 'internalapi/api/licensing/surrender/savesurrender/'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And configure continueOnStepFailure = true
   	 And request {"application":{"appId":'#(appId)',"applicationId":'#(ApplicationId)',"applicationTypeId":0,"appStatus":{"appStatusId":0,"statusDescription":""},"appStatusId":0,"formVersionId":0,"legalName":"","submitDate":null,"licenseDescription":"","countyName":"","priority":"","expirationDate":null,"communityBoard":"","isFinalDeficiency":null,"isHighlyDeficient":null,"isAllDeficienciesMet":null,"isNybeApp":false,"isApplicableForPDLetter":false,"isFairOrFestival":false,"isOneTimePermit":false,"createdDate":null,"modifiedDate":null,"assignAppExaminer":{"examinerId":"","name":""},"isTempPermit":false,"isAssociatedLicense":false,"taskStatus":"","taskId":0,"amendmentTypeId":0,"parentAppStatus":0,"does500FtHearingExist":false,"isHearingCompleted":false,"wfRoleId":0,"acaId":0,"recordID":""},"appId":'#(appId)',"deficiencyDetailModel":{"deficiencyTypeId":null,"acaType":"Surrender"},"deficiency":null,"licenseId":"License","status":"Surrendered","isDeficiencyDefined":null,"workFlowStatus":5502,"taskOptionsList":[{"name":"Deficient","value":1,"isChecked":null},{"name":"Not Deficient","value":2,"isChecked":null}],"selectInput":{"fromFields":[{"id":123,"label":"Additional Funds Required"},{"id":129,"label":"Provide a copy of the Assumed Name Certificate from the Secretary of State for your corporation/LLC's dba name."},{"id":130,"label":"Provide a copy of the business certificate from the county clerk for your dba name."},{"id":131,"label":"Provide your federal tax identification number."},{"id":132,"label":"Provide a copy of your Certificate of Authority from the New York State Tax Department."},{"id":133,"label":"Provide an amended Certificate of Authority – the name must match the applicant name exactly."},{"id":134,"label":"Provide an amended Certificate of Authority – the address must match the premises address exactly."},{"id":135,"label":"Provide a signed Bond Rider amending _______."},{"id":136,"label":"Provide Worker's Compensation and Disability Benefits insurance provider names and policy numbers."},{"id":137,"label":"Provide an inventory of the alcoholic beverages you will be purchasing from the current licensee."},{"id":138,"label":"Submit a copy of the Newspaper Affidavit(s)."},{"id":139,"label":"Provide your TTB permit."},{"id":140,"label":"Surrender of the current license in effect."}],"toFields":[],"isRewritable":true,"rewriteLabel":"Edit Deficiency:","additionalComments":"","srclabel":"Select Deficiencies","dstlabel":"Add to Notification","additionalLabel":"Add Additional Deficiencies:"},"workFlowCondition":"2","isSubmit":true,"emailNotificationModel":{"applicant":{"communicationId":6240,"email":'#(emailId)',"appId":'#(appId)',"emailContactTypeId":1,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":'#(emailId)',"appId":'#(appId)',"emailContactTypeId":0,"isChecked":true,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}}}
	  When method Post
	  * configure continueOnStepFailure = true
	  Then status 200

@SearchAndValidateRenewalApplicationStatus
Scenario: SearchAndValidateClericalQueueApplicationStatus on Search Page 
      
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
	  * match response.data[0].licenseStatus == '#(SurrenderStatus)'
	  	  
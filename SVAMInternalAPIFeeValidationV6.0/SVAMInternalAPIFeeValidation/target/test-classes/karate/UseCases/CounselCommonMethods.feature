Feature: Counsel Common Methods
Background:
			* url BaseURL
  		* def config = { username: '#(dbUserName)', password:'#(dbUserPassword)', url: '#(dbQuery)',driverClassName: 'com.microsoft.sqlserver.jdbc.SQLServerDriver' }
    	* def DbUtils = Java.type('utils.DbUtils')
    	* def db = new DbUtils(config)
    	 * def ChargesStrDateFunc =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("dd/MM/yyyy");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		  """ 
		   * def ChargesStrDate = ChargesStrDateFunc()
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
  	   * def responseReceiveDateFunc =
		  """
		  function(days) {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("yyyy-MM-dd");
		    
		    var date = new java.util.Date();
		    var dayAfter = new java.util.Date(date.getTime() + java.util.concurrent.TimeUnit.DAYS.toMillis( days));
		    return sdf.format(dayAfter);
		  } 
		  """
		  * def responseReceiveDate = responseReceiveDateFunc(21)
  	   * def waitFunc =
		        """
		      function(timeinMiliSeconds) {
		        // load java type into js engine
		        var Thread = Java.type('java.lang.Thread');
		        Thread.sleep(timeinMiliSeconds*1000); 
		      }
		      """
  	  
		  
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
			* def licDT = licDate() 
		* def getAmendmentReviewFunc =
			"""
				function(reviewType){
					if (reviewType == 'Send to Licensing Board'){
					return 2;
					}
					else if (reviewType == 'Send to Full Board Preview Team'){
					return 3;
					}
					else if (reviewType == 'Define Deficiencies'){
					return 1;
					}
				}
			"""	
			
			* def getAmendmentDetailsFunc =
			"""
				function(response, appNumber){
					for(i=0;i<response.total;i++)
					{
					 if(appNumber == response.data[i].applicationId)
					 {
					 return i;
					 }
					}
					
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

@SearchLicPermitIdForArrest
Scenario: SearchLicPermitIdForArrest		 
	  Given path 'internalapi/api/licensing/SearchByApplicantInfo'
      	And header Content-Type = 'application/json; charset=utf-8'
  	  	
		And header Accept = 'application/json; text/plain;*/*'
       	And header authorization = 'Bearer ' + strToken
       	* def payload = ""
       	* def payloadSearchByPrincipalName = {"ssn":"","firstName":"automation","lastName":"","dcjsNumber":""}
       	* def payloadSearchByLicId = {"ssn":"","firstName":"","lastName":"name","dcjsNumber":""}
    	* eval if ( SearchByLicId == true) payload = payloadSearchByLicId
    	* eval if (SearchByPrincipalName == true) payload = payloadSearchByPrincipalName
    	And request payload
	   	When method post
	  	Then status 200	
	  
	  	* def LicId = get[0] response $[?(@.status == 'Active')].id
	  	And print LicId
	  	* def effectiveDate = response.licenses[randomNum].appId
	  	* def lpId = response.licenses[randomNum].lpId
	  	* def licPermitTypeId = response.licenses[randomNum].licPermitTypeId
	  	* def LicensePermitId = response.licenses[randomNum].licensePermitId
	  	* def LicensePermitId = response.licenses[randomNum].licensePermitId
	  	* def APPlicationId = response.licenses[randomNum].applicationId
	  	* def mainAppId = response.licenses[randomNum].appId

	  	And match licAppId != null
	  	And print LicensePermitId
		 
@SubmitPlea
Scenario: SubmitPlea

	   Given path 'internalapi/api/CounselDashboard/GetCounselAttorneyClaimQueue'
       And header Content-Type = 'application/json; charset=utf-8'
       And header Accept = 'application/json; text/plain;*/*'
       And header authorization = 'Bearer ' + strToken
         * def stringParam = "referralCaseApplicationNo~contains~'"+referralCaseNo+"'" 
       And params  {filter:'#(stringParam)',page:1,sort=isNopResponse-desc~isDiscoveryResponse-desc~isRejectionResponse-desc,pageSize:10}
      And request {filter:'#(stringParam)',page:1,sort=isNopResponse-desc~isDiscoveryResponse-desc~isRejectionResponse-desc,pageSize:10}
	  When method get
	  Then status 200
      * def taskId = response.data[0].taskId
      * def taskStatus = response.data[0].taskStatus
      * def workflowName = response.data[0].workflowName
   
   Given path 'internalapi/api/auditLog/logAcaAudit'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And configure continueOnStepFailure = true
   	 And request {"acaId":'#(parseInt(caseNumber))',"acaType":'#(workflowName)',"tab":"Plea","wfStatus":'#(taskStatus)',"reportAccessed":false}
	  When method post
	  * configure continueOnStepFailure = true
	  Then status 200

   Given path 'internalapi/api/Nop/SubmitPleaResponse'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And configure continueOnStepFailure = true
   	  * def panality = ""
      * if(PleaPanity == true) panality = civilPanilty
      * if(PleaPanity == true) taskDecision = 2
      
      * def payload = ''       
      * def payloadForhasNonCalenderItem = {"caseId":'#(parseInt(caseNumber))',"memoText":"Test Plea","hasNonCalendarItem":false,"taskDecision":'#(taskDecision)',"taskId":'#(taskId)',"isPlea":'#(isPlea)',"cncDetailDtoObj":{"civilPenalty":"","bondClaim":"","daysForthWith":"","daysDeferred":"","acceptCncReasonId":"","other":"","authorizeBy":"","authorizeDate":"","acceptCncreasonList":""}}
      * def payloadForhasYesCalenderItem = {"caseId":'#(parseInt(caseNumber))',"memoText":"Test Plea","hasNonCalendarItem":true,"taskDecision":'#(taskDecision)',"taskId":'#(taskId)',"isPlea":'#(isPlea)',"cncDetailDtoObj":{"civilPenalty":'#(panality)',"bondClaim":"","daysForthWith":"","daysDeferred":"","acceptCncReasonId":"","other":"","authorizeBy":"","authorizeDate":"","acceptCncreasonList":""}}
      * eval if(payloadFor == 'NoCalenderItem') payload = payloadForhasNonCalenderItem
      * eval if(payloadFor == 'YesCalenderItem') payload = payloadForhasYesCalenderItem
       And request payload
   	 # And request {"caseId":'#(parseInt(caseNumber))',"memoText":"Test Plea","hasNonCalendarItem":'#(hasNonCalendarItem)',"taskDecision":'#(taskDecision)',"taskId":'#(taskId)',"isPlea":'#(isPlea)',"cncDetailDtoObj":{"civilPenalty":"","bondClaim":"","daysForthWith":"","daysDeferred":"","acceptCncReasonId":"","other":"","authorizeBy":"","authorizeDate":"","acceptCncreasonList":""}}
	  When method Post
	  * configure continueOnStepFailure = true
	  Then status 200
	  
	   Given path 'internalapi/api/CounselDashboard/GetCounselAttorneyClaimQueue'
       And header Content-Type = 'application/json; charset=utf-8'
       And header Accept = 'application/json; text/plain;*/*'
       And header authorization = 'Bearer ' + strToken
         * def stringParam = "referralCaseApplicationNo~contains~'"+referralCaseNo+"'" 
       And params  {filter:'#(stringParam)',page:1,sort=isNopResponse-desc~isDiscoveryResponse-desc~isRejectionResponse-desc,pageSize:10}
      And request {filter:'#(stringParam)',page:1,sort=isNopResponse-desc~isDiscoveryResponse-desc~isRejectionResponse-desc,pageSize:10}
	  When method get
	  Then status 200
      * match response.total == 0

@SubmitPlea1
Scenario: SubmitPlea

	   Given path 'internalapi/api/CounselDashboard/GetCounselAttorneyClaimQueue'
       And header Content-Type = 'application/json; charset=utf-8'
       And header Accept = 'application/json; text/plain;*/*'
       And header authorization = 'Bearer ' + strToken
         * def stringParam = "referralCaseApplicationNo~contains~'"+referralCaseNo+"'" 
       And params  {filter:'#(stringParam)',page:1,sort=isNopResponse-desc~isDiscoveryResponse-desc~isRejectionResponse-desc,pageSize:10}
      And request {filter:'#(stringParam)',page:1,sort=isNopResponse-desc~isDiscoveryResponse-desc~isRejectionResponse-desc,pageSize:10}
	  When method get
	  Then status 200
      * def taskId = response.data[0].taskId
      * def taskStatus = response.data[0].taskStatus
      * def workflowName = response.data[0].workflowName
   
   Given path 'internalapi/api/auditLog/logAcaAudit'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
     And header Accept = 'application/json; text/plain;*/*'
      And configure continueOnStepFailure = true
   	 And request {"acaId":'#(parseInt(caseNumber))',"acaType":'#(workflowName)',"tab":"Plea","wfStatus":'#(taskStatus)',"reportAccessed":false}
	  When method post
	  * configure continueOnStepFailure = true
	  Then status 200

   Given path 'internalapi/api/Nop/SubmitPleaResponse'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And configure continueOnStepFailure = true
      
      * def payload = ''       
      * def payloadForhasNonCalenderItem = {"caseId":'#(parseInt(caseNumber))',"memoText":"Test Plea","hasNonCalendarItem":false,"taskDecision":1,"taskId":'#(taskId)',"isPlea":'#(isPlea)',"cncDetailDtoObj":{"civilPenalty":"","bondClaim":"","daysForthWith":"","daysDeferred":"","acceptCncReasonId":"","other":"","authorizeBy":"","authorizeDate":"","acceptCncreasonList":""}}
      * def payloadForhasYesCalenderItem = {"caseId":'#(parseInt(caseNumber))',"memoText":"Test Plea","hasNonCalendarItem":true,"taskDecision":2,"taskId":'#(taskId)',"isPlea":'#(isPlea)',"cncDetailDtoObj":{"civilPenalty":"","bondClaim":"","daysForthWith":"","daysDeferred":"","acceptCncReasonId":"","other":"","authorizeBy":"","authorizeDate":"","acceptCncreasonList":""}}
       * eval if(payloadFor == 'NoCalenderItem') payload = payloadForhasNonCalenderItem
        * eval if(payloadFor == 'YesCalenderItem') payload = payloadForhasYesCalenderItem
       And request payload
   	 # And request {"caseId":'#(parseInt(caseNumber))',"memoText":"Test Plea","hasNonCalendarItem":'#(hasNonCalendarItem)',"taskDecision":'#(taskDecision)',"taskId":'#(taskId)',"isPlea":'#(isPlea)',"cncDetailDtoObj":{"civilPenalty":"","bondClaim":"","daysForthWith":"","daysDeferred":"","acceptCncReasonId":"","other":"","authorizeBy":"","authorizeDate":"","acceptCncreasonList":""}}
	  When method Post
	  * configure continueOnStepFailure = true
	  Then status 200
	  
	   Given path 'internalapi/api/CounselDashboard/GetCounselAttorneyClaimQueue'
       And header Content-Type = 'application/json; charset=utf-8'
       And header Accept = 'application/json; text/plain;*/*'
       And header authorization = 'Bearer ' + strToken
         * def stringParam = "referralCaseApplicationNo~contains~'"+referralCaseNo+"'" 
       And params  {filter:'#(stringParam)',page:1,sort=isNopResponse-desc~isDiscoveryResponse-desc~isRejectionResponse-desc,pageSize:10}
      And request {filter:'#(stringParam)',page:1,sort=isNopResponse-desc~isDiscoveryResponse-desc~isRejectionResponse-desc,pageSize:10}
	  When method get
	  Then status 200
      * match response.total == 0

@CounselToSecOfficeLevel1
Scenario: CounselToSecOfficeLevel1

	   Given path 'internalapi/api/SoDashboardSecLevel/GetDisciplinaryItemQueue/'
       And header Content-Type = 'application/json; charset=utf-8'
       And header Accept = 'application/json; text/plain;*/*'
       And header authorization = 'Bearer ' + strToken
         * def stringParam = "caseNo~contains~'"+referralCaseNo+"'" 
       And params  {filter:'#(stringParam)',page:1,pageSize:10}
       And request {filter:'#(stringParam)',page:1,pageSize:10}
	  When method get
	  Then status 200
      * def type = response.data[0].type
      * def applicationStatus = response.data[0].applicationStatus

      * match type == '#(expType)'
      * match applicationStatus == "Awaiting Review"

@CounselToSecOfficeLevel2
Scenario: CounselToSecOfficeLevel2

	   Given path 'internalapi/api/SoDashboardSecLevel/GetDisciplinaryItemQueue/'
       And header Content-Type = 'application/json; charset=utf-8'
       And header Accept = 'application/json; text/plain;*/*'
       And header authorization = 'Bearer ' + strToken
         * def stringParam = "caseNo~contains~'"+referralCaseNo+"'" 
       And params  {filter:'#(stringParam)',page:1,pageSize:10}
       And request {filter:'#(stringParam)',page:1,pageSize:10}
	  When method get
	  Then status 200
      * def type = response.data[0].type
      * def applicationStatus = response.data[0].applicationStatus
          And match type == appType
     # * match type == "Non-Full Board Calendar Item"
      * match applicationStatus == "Awaiting Review"

@WfhistoryCheck
Scenario: WfhistoryCheck

	   Given path 'internalapi/api/wfhistory/'+referralCaseId+'/Case'
       And header Content-Type = 'application/json; charset=utf-8'
       And header Accept = 'application/json; text/plain;*/*'
       And header authorization = 'Bearer ' + strToken
       And params  {page:1,pageSize:10}
       And request {page:1,pageSize:10}
	  When method get
	  Then status 200
      * def currentStatus = response.currentStatus
      * def bureau = response.bureau

      #* match bureau == '#(expBureau)'
      * match currentStatus == '#(expcurrentStatus)'
		* assert (bureau == "Secretary’s Office") || (bureau == "Counsel/Secretary’s Office")
      #* match currentStatus == "Awaiting Review"
		
@WfhistoryCheck1
Scenario: WfhistoryCheck

	   Given path 'internalapi/api/wfhistory/'+referralCaseId+'/Case'
       And header Content-Type = 'application/json; charset=utf-8'
       And header Accept = 'application/json; text/plain;*/*'
       And header authorization = 'Bearer ' + strToken
       And params  {page:1,pageSize:10}
       And request {page:1,pageSize:10}
	  When method get
	  Then status 200
      * def currentStatus = response.currentStatus
      * def bureau = response.bureau
       * assert (bureau == "Secretary’s Office") || (bureau == "Counsel/Secretary’s Office")
      #* match bureau ==  || bureau == 
      * match currentStatus == "Awaiting Review"

@AgendaTabCheck
Scenario: AgendaTabCheck

	   Given path 'internalapi/api/SoItemReview/GetMemoByCaseId/'+referralCaseId
       And header Content-Type = 'application/json; charset=utf-8'
       And header Accept = 'application/json; text/plain;*/*'
       And header authorization = 'Bearer ' + strToken
       And request ""
	  When method get
	  Then status 200
      * match response.memo == "Test Plea"

      Given path 'internalapi/api/SoItemReview/GetCaseChargesByCaseId/'+referralCaseId
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
     * def stringParam = "referralCaseApplicationNo~contains~'"+referralCaseNo+"'" 
       And params {page:1,sort=chargeId-asc,pageSize:10}
       And request {page:1,sort=chargeId-asc,pageSize:10}
      And configure continueOnStepFailure = true
   	 And request {"acaId":'#(parseInt(caseNumber))',"acaType":'#(workflowName)',"tab":"Plea","wfStatus":'#(taskStatus)',"reportAccessed":false}
	  When method get
	  * configure continueOnStepFailure = true
	  Then status 200
	  * def chargesType = response.data[0].chargesType
	  * def chargeId = response.data[0].chargeId

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
	  
@AddReferralForm
Scenario: AddReferralForm



	Given path '/internalapi/api/license/searchNames/'+licKeywordName
	   	* def dbSts = db.cleanHeap()
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json;charset=utf-8'
	      And header Accept = 'text/plain'
	     
	     And request {}
		  When method get
		 
		  Then status 200
		  * def lpApplicationId = response[0].lpApplicationId
		    And print lpApplicationId

	#Given path 'internalapi/api/license/'+lpApplicationId
	   #	* def dbSts = db.cleanHeap()
	    #  And header authorization = 'Bearer ' + strToken
	  	#  And header Content-Type = 'application/json;charset=utf-8'
	    #  And header Accept = 'text/plain'
	     
	    # And request {}
		# When method get
		 #Then status 200
		 #* def addressId = response.addressId
		#    And print addressId	
		# * def licensePermitNo = response.licensePermitNo
		#    And print licensePermitNo	
		# * def premisesId = response.premisesId
		#    And print premisesId
		# * def licId = response.licId
		#    And print licId  
		#    * def licensePermitType = response.licensePermitType
		  #  And print licensePermitType    
		  
		  Given path '/internalapi/api/licensingCommon/GetLicensePermitByLpIdLegalNameDba/'+licenseId+'/1'
	   	* def dbSts = db.cleanHeap()
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json;charset=utf-8'
	      And header Accept = 'text/plain'
	     
	     And request {}
		 When method get
		 Then status 200
		 * def addressId = response[0].addressId
		    And print addressId	
		 * def licensePermitNo = response[0].licensePermitNo
		    And print licensePermitNo	
		 * def premisesId = response[0].premisesId
		    And print premisesId
		 * def licId = response[0].licId
		    And print licId  
		     * def legalName = response[0].legalName
		    And print legalName  
		    * def licensePermitType = response[0].licensePermitType
		    And print licensePermitType 
		    	
	Given path '/internalapi/api/Referral/AddReferralForm'
	   	
		  * def dbSts = db.cleanHeap()
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;*/*'
	     
	   	 And request {"referralId":"","referralNo":"","licenseId":'#(licId)',"premisesId":'#(premisesId)',"referralTypeId":"","incidentDate":'#(licDT)',"additionalDetail":"Test","isPoliceContacted":false,"policeDepartment":"","isCaseInchargeKnown":false,"inchargeName":"","isEvidenceOfIncident":false,"asignedAtorney":"","referralStatus":"","isLicensedReferral":"","caseId":"","hasRelatedCase":"","isReferralSubmitted":"","isActive":"","complainantId":"","complaintType":"19","otherComplaintType":"","complainantInfoDto":{"complainantId":"","communicationTypeId":11,"sourceId":"5","otherSourceText":"","agencyId":null,"policeDeptId":"","personId":"","addressId":"","isActive":"","Person":{"personId":"","firstName":"Automation","lastName":"HearingFlow","phoneNo":"","middleName":"","email":"automation@test.com","faxNo":""},"Address":{"addressLine1":'#(Address1)',"addressLine2":'#(Address2)',"stateId":'#(stateCode)',"county":'#(CityName)',"city":'#(CityName)',"zipCode":'#(zipCode)',"zip4":'#(postalCode)',"country":'#(countryName)',"stateName":'#(CityName)',"countryId":'#(countryCode)'},"otherCommType":"","borough":"","communityBoardId":null,"pdCounty":"","OtherComplaintType":null,"OtherCommType":null},"premisesInfo":{"premisesId":'#(premisesId)',"licPermitId":"","licId":'#(licId)',"type":null,"addressId":'#(addressId)',"licenseDescription":null,"createdBy":"","createdDate":"","modifiedBy":"","modifiedDate":null,"isActive":"","Address":{"addressLine1":'#(Address1)',"addressLine2":'#(Address1)',"stateId":'#(stateCode)',"county":'#(CityName)',"city":'#(CityName)',"zipCode":'#(zipCode)',"zip4":'#(postalCode)',"country":'#(countryName)',"stateName":'#(CityName)',"countryId":'#(countryCode)',"addressId":'#(addressId)'},"licenseStatus":"Active","licenseType":'#(licensePermitType)'},"lpApplicationId":'#(lpApplicationId)',"noiseSource":"","complaintWhereId":"","complaintInvolvePeopleTypeId":"","complaintInvolvePeopleReason":"","natureOfIncident":"","isUnKnownValue":false,"unknownReason":"","incidentKnownReason":"","incidentDuration":"","isUnknown":false,"complaintTypeIds":[19],"complaintTypeOther":""}
		 When method post
		  Then status 200
		   
		  #377
		  * def caseNumber = response
		 And print caseNumber
	  
	  


@ClaimCreatedCase
Scenario: ClaimCreatedCase
   
             
   Given path '/internalapi/api/CounselDashboard/GetCounselSupportStaffQueue'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      * def stringParam = "licenseId~contains~'"+licensePermitNo+"'"
       And params  {filter:'#(stringParam)',page:1,pageSize:10,sort:'referralCaseId-desc'}
     
   	 And request {}
	  When method get
	 
	  Then status 200
	    And def referralCaseId = response.data[0].referralCaseId
	  And print referralCaseId
	  And def referralCaseNo = response.data[0].referralCaseNo
	  And print referralCaseNo
	   And def referralAppId = response.data[0].lpApplicationId
	  And print referralAppId
	   And def wfRoleId = response.data[0].wfRoleId
	  And print wfRoleId
	   And def taskId = response.data[0].taskId
	  And print taskId
	  
	  Given path '/internalapi/api/CounselAssignment/AssignToUser'
	   	
		  * def dbSts = db.cleanHeap()
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;*/*'
	     
	   	 And request {"assignedUserId":1069,"currentRoleId":1069,"type":"Case","id":'#(caseNumber)',"currentWfRoleId":'#(wfRoleId)'}
		 When method post
		  Then status 200
		 
		 And match response == 'true'


@AssignCaseToAttorney
Scenario: AssignCaseToAttorney
   
  
   Given path '/internalapi/api/Case/AssignCaseToAttorney/'
	  
	   * def dbSts = db.cleanHeap()
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;*/*'
	     
	   	 And request {"caseId":'#(caseNumber)',"hasAttorneyAssigned":true,"taskDecision":1,"taskId":'#(taskId)',"assignedUserId":1069}
		 When method post
		  Then status 200
		 
		 And match response == 'true'

@PrepareNOP
Scenario: PrepareNOP
   
  
   Given path '/internalapi/api/Charge/SyncCharges/'
	  
	   * def dbSts = db.cleanHeap()
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;*/*'
	     
	   	 And request {"caseId":'#(caseNumber)',"isSubmit":true,"charges":[{"chargeTypeId":"15","description":"That on or about [insert date], in violation of subdivision 6 of section 106 of the Alcoholic Beverage Control Law, the licensee suffered or permitted the licensed premises to become disorderly, to wit: mingling.","descriptionTemp":"That on or about <span style=\"background-color:#767070;\">[insert date]</span>, in violation of subdivision 6 of section 106 of the Alcoholic Beverage Control Law, the licensee suffered or permitted the licensed premises to become disorderly, to wit: mingling.","chargeStatusId":null,"caseId":'#(caseNumber)',"chargeDate":'#(licDT)',"chargeOrderNo":1,"tags":[{"indices":{"start":17,"end":30},"cssClass":"bg-pink","data":"insert date"}]}]}
		 When method post
		  Then status 200
		 
		 And match response == 'true'
	

	  
	  Given path '/internalapi/api/Nop/PrepareNop'
	  
	   * def dbSts = db.cleanHeap()
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;*/*'
	     * def summarySuspension = false
	     * if(suspensionStatus == true) summarySuspension = true
	   	 * def payload = {"caseId":'#(caseNumber)',"memoText":"","penalty":"","noptypeId":"1","isSummarySuspension":'#(summarySuspension)',"responseReceiveDate":'#(responseReceiveDate)',"nopdate":'#(effectiveDate)',"taskId":7105,"taskDecision":2,"mailingAddressTypeList":"3","billOfParticularText":"","isPreviewLoaded":true,"otherEMail":""}
	   	
		And request payload 
		 When method post
		  Then status 200
		 
		 And match response == 'true'
		 
		 Given path '/internalapi/api/Nop/SendNop'
	  
	   * def dbSts = db.cleanHeap()
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;*/*'
	       And header current-wfroleid = '32'
	     * def randomNum = db.getRandomNumber(9999999)
	  	And print randomNum
	  	* def truckingNumber = 'AutoTruckingNum'+randomNum
	   	 And request {"caseId":'#(parseInt(caseNumber))',"trackingNo":'#(truckingNumber)',"taskId":7108}
		 When method post
		  Then status 200
		 
		 And match response == 'true'
		 
@PrepareNOP1
Scenario: PrepareNOP
   
  
   Given path '/internalapi/api/Charge/SyncCharges/'
	  
	   * def dbSts = db.cleanHeap()
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;*/*'
	     
	   	 And request {"caseId":'#(caseNumber)',"isSubmit":true,"charges":[{"chargeTypeId":"15","description":"That on or about [insert date], in violation of subdivision 6 of section 106 of the Alcoholic Beverage Control Law, the licensee suffered or permitted the licensed premises to become disorderly, to wit: mingling.","descriptionTemp":"That on or about <span style=\"background-color:#767070;\">[insert date]</span>, in violation of subdivision 6 of section 106 of the Alcoholic Beverage Control Law, the licensee suffered or permitted the licensed premises to become disorderly, to wit: mingling.","chargeStatusId":null,"caseId":'#(caseNumber)',"chargeDate":'#(licDT)',"chargeOrderNo":1,"tags":[{"indices":{"start":17,"end":30},"cssClass":"bg-pink","data":"insert date"}]}]}
		 When method post
		  Then status 200
		 
		 And match response == 'true'
	

	  
	  Given path '/internalapi/api/Nop/PrepareNop'
	  
	   * def dbSts = db.cleanHeap()
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;*/*'
	     
	   	 And request {"caseId":'#(caseNumber)',"memoText":"","penalty":"","noptypeId":"1","isSummarySuspension":'#(suspensionStatus)',"responseReceiveDate":'#(responseReceiveDate)',"nopdate":'#(effectiveDate)',"taskId":7105,"taskDecision":2,"mailingAddressTypeList":"3","billOfParticularText":"","isPreviewLoaded":true,"otherEMail":""}
		 When method post
		  Then status 200
		 
		 And match response == 'true'
		 
		 Given path '/internalapi/api/Nop/SendNop'
	  
	   * def dbSts = db.cleanHeap()
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;*/*'
	       And header current-wfroleid = '32'
	     * def randomNum = db.getRandomNumber(9999999)
	  	And print randomNum
	  	* def truckingNumber = 'AutoTruckingNum'+randomNum
	   	 And request {"caseId":'#(parseInt(caseNumber))',"trackingNo":'#(truckingNumber)',"taskId":7108}
		 When method post
		  Then status 200
		 
		 And match response == 'true'		 

@NOPProcessingCompleteFlow
Scenario: NOPProcessingCompleteFlow
	  Given path '/internalapi/api/Nop/GetPreviewNOPPackageLetterPreviewLetterPlaceHolder/'+caseNumber
	  
	   * def dbSts = db.cleanHeap()
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;*/*'
	     
	   	 And request {}
		 When method get
		  Then status 200
		 * def resBody = response
		 And print response
   Given path '/internalapi/api/template/GenerateLetterWithMultiple'
	  
	   * def dbSts = db.cleanHeap()
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;*/*'
	     
	   	 And request {"templateIds":[164,319],"placeHolderDtos":'#(resBody)'}
		 																
		 When method post
		  Then status 200
		 * def base64Val = response.base64
		 
	

	  
	  Given path '/internalapi/api/Nop/MoveWorkflowAfterNop'
	  
	   * def dbSts = db.cleanHeap()
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;*/*'
	     And header current-wfroleid = '32'
	   	 And request {"caseId":'#(parseInt(caseNumber))',"trackingNo":'#(truckingNumber)',"taskId":7108} 
		 When method post
		  Then status 200
		 
		 And match response == 'true'		 
		 
	 Given path '/internalapi/api/CounselDashboard/GetCounselSupportStaffClaimQueue'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      * def stringParam = "referralCaseNo~contains~'"+referralCaseNo+"'"
       And params  {filter:'#(stringParam)',page:1,pageSize:10,sort:'referralCaseId-desc'}
   
   	 And request {}
	  When method get
	 
	  Then status 200
	   
	   And match response.data[0].taskStatus == 'NOP Processing Complete'
	  
@AttachCertifiedMailReceipt
Scenario: AttachCertifiedMailReceipt 
	 Given path '/internalapi/api/document/UploadDocument'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
     And request {"documentDesc":"SVAM Test DoC.docx","acaId":'#(caseNumber)',"acaType":"Case","bureau":"WorkFlowNameEnum.counsel","documentType":{"key":141,"value":"NOTICE OF PLEADING","description":null,"documentSubCategory":"NOP"},"documentCategory":null,"receivedDate":'#(receivedDate)',"createdDate":'#(date)',"documentBase64":"data:application/vnd.openxmlformats-officedocument.wordprocessingml.document;base64,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","contentType":"application/vnd.openxmlformats-officedocument.wordprocessingml.document","fileName":"SVAM Test DoC.docx","tempGuid":"efaa62dd-fe1d-0fbb-e341-488be0673530"}
      When method post
	  Then status 200
	  And print response
	  * match response == 'true'
	  
	   
	   Given path '/internalapi/api/Nop/AttachCertifiedMailReceipt'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
     And request {"caseId":'#(caseNumber)',"hasAttorneyAssigned":true,"taskDecision":1,"taskId":7120,"assignedUserId":1069}
      When method post
	  Then status 200
	  And print response
	  * match response == 'true'
	  
	 Given path '/internalapi/api/CounselDashboard/GetCounselAttorneyClaimQueue'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      * def stringParam = "referralCaseApplicationNo~contains~'"+referralCaseNo+"'"
       And params  {filter:'#(stringParam)',page:1,pageSize:10,sort:'isNopResponse-desc~isDiscoveryResponse-desc~isRejectionResponse-desc'}
   
   	 And request {}
	  When method get
	 
	  Then status 200
	  And match response.data[0].taskStatus == 'Awaiting Customer Response'
	  
	  
	  
@SaveContactsDetails
Scenario: SaveContactsDetails
   
			  
	Given path '/internalapi/api/LicenseeRepresentative/save'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      
   	 And request {"postcontactId":null,"lPApplicationId":'#(parseInt(lpApplicationId))',"person":{"firstName":"CHearing","middleName":"","lastName":"Automation","email":"gpriev@svam.com","phoneNo":"","faxNo":""},"firmName":"","nysregistrationNo":"","address":{"zip4":"1111","country":"United States (US)","countryId":229,"stateName":"New York","stateId":40,"county":"New York","addressLine1":"address1","addressLine2":"address2","city":"New York","zipCode":"12345"},"caseId":'#(caseNumber)'}
	  When method post
	 
	  Then status 200
	  * match response == 'true'
	  
@SaveWitnessDetails
Scenario: SaveWitnessDetails
   
			  
	Given path '/internalapi/api/Witness/Add'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      
   	 And request {"witnessId":null,"witnessTypeId":"213","caseId":'#(parseInt(caseNumber))',"witnessOther":"","personId":null,"addressId":null,"identificationNo":null,"jurisdiction":null,"slastaffId":"","policeDeptId":"","witnessDate":null,"other":"","isSubpoena":null,"address":{"addressLine1":"","addressLine2":"","stateId":40,"county":"","city":"","zipCode":"","zip4":"","country":"United States (US)","stateName":"New York","countryId":229,"addressId":0},"person":{"personId":0,"firstName":"WitnessHearing","middleName":"","lastName":"Automation","email":"automation@svam.com"},"pdTitle":"","countyId":"","tempGuid":"6c850938-32ff-1f75-591d-87532f99d599"}
   	When method post
	 
	  Then status 200
	  * match response == 'true'	
	  
	  Given path '/internalapi/api/auditLog/logAcaAudit'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      
   	 And request {"acaId":'#(parseInt(caseNumber))',"acaType":"Case","tab":"Hearing","wfStatus":"Scheduled","reportAccessed":false}
   	When method post
	 
	  Then status 200
	  * match response == 'true'
	  
 @HearingCreateLic  
 Scenario Outline: HearingCreateLic
   * def licKeywordName = 'Automation'	
	# ********* Login Functionality *********************
  		* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
  		
		* def IndOrgSelectionDropDown = <IndOrgSelection>
  		* def indOrgCode = getIndORgCodeFunc(IndOrgSelectionDropDown)
  			And print indOrgCode
  		* def isIndStatus = getStatusIndOrgStatus(IndOrgSelectionDropDown)
	    * def CorporateStructureDropDown = <CorporateStructure>
	    * def CorporateStructureDropDownCode = getIndORgCodeFunc(indOrgCode,CorporateStructureDropDown)
	   		And print CorporateStructureDropDownCode
	    * def firstName = <FirstName>
	    * def lastName = <LastName>
	    * def legalName = firstName+ ' '+lastName
	    * def Address1 = <Address1>
	    * def Address2 = <Address2>
	    * def CityName = <City>
	    * def zipCode = <ZipCode>
	    * def postalCode = <PostalCode>
	    * def countryName = <Country>
	    * def emailId = <Email>
	    * def convictedOfCrime = <convictedOfCrime>
	    * def percentageOfOwners = <percentageOfOwners>
	    * def isFingerprintRequired = <isFingerprintRequired>
	    * def isFingerprintsApproved = <isFingerprintsApproved>
	    * def isSignature = <isSignature>
	    
	    * def convictedOfCrime = <convictedOfCrime>
		* def PhoneNumber = <PhoneNumber>
		* def PhoneExtn = <PhoneExtn>
		* def countryCode = <countryCode>
		* def stateCode = <StateCode>
	    
	  	* def mainLicensePermitTypeId = <LicensePermitTypeId>
	    * def termInYears = <NumberOfTerm>
	    * def termDesc = <NumberOfTerm>+' Year (s)'
	    * def licenseFees = <InitialLicFee>
	    * def fillingFees = <NonRefundableFilingFees>
	    * def licAncillaryFees = <AncillaryFees>
	    * def renewalFees = <RenewalFilingFees>+''
	    * string productName = <ProductTypes>+''
	     
	    * def CountyId = <countyIds>
	    * def CountyName = <County>	
		* def totalFees = licenseFees+fillingFees+licAncillaryFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_RenewalIntakeApp: Validate TC0001_SLA_REN_Intake_Onpremises_License_Inside_5_Boroughts_Submit Scenario Start ***************************##
	   	* call read('LicensesCommonMethods.feature@IntakeLicensewithoutAssociatedLic') {}
        * def CountyName = "New York"
        * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {county:'#(CountyName)'}
        * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
        * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
        * call read('LicensesCommonMethods.feature@FillAndSaveMethodOfOperationPage') {}
        * call read('LicensesCommonMethods.feature@WaveFeesValidation') {}
       
        * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	   	 * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {}
        * call read('LicensesCommonMethods.feature@ExaminerReviewApprovalToLB') {}
        * call read('LicensesCommonMethods.feature@LBClaimingQueue') {}
         * def expirationDate = fundDueDateFunc(10)
        * call read('LicensesCommonMethods.feature@LBApprovalWithDueDate') {approvalName:'Approved', expStatus:'Approved'}
        * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Approved'}
	   	
	   * call read('LicensesCommonMethods.feature@GetLicenseId') {} 
	   	 And print licenseId
	   
 Examples:
    | read('/CSVFiles/RenewalOnPremises.csv') |	  
	  
@ScheduleCouselToHearing
Scenario: ScheduleCouselToHearing
   
	Given path '/internalapi/api/Witness/GetWitnessesByCaseId/'+caseNumber
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      
   	 And request {}
   	
   	When method get
	 
	  Then status 200
	  * def witnessId = response[0].witnessId
	  
	 
	  		  
	Given path '/internalapi/api/CounselHearing/Create'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      
   	 And request {"scheduleId":"","hearingId":"","hearingDate":'#(date)',"hearingLocationId":"19","note":"","hearingInfoDto":{"hearingId":"","caseId":'#(parseInt(caseNumber))',"appId":"","hearingTypeId":"","hearingType":"","taskId":""},"hearingLocationDto":{"hearingLocationId":"19","name":"","stateId":""},"witnessIds":['#(parseInt(witnessId))'],"addressId":"","taskId":7121}
   	 When method post
	 
	  Then status 200
	  * match response == 'true'	  
	
	
	Given path '/internalapi/api/HrDashboard/GetHbDisciplinaryQueue'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      * def stringParam = "caseNo~contains~'"+referralCaseNo+"'"
       And params  {filter:'#(stringParam)',page:1,pageSize:10}
   
   	 And request {}
	  When method get
	 
	  Then status 200
	  * def hearingId = response.data[0].hearingId
	  And match response.data[0].applicationStatus == 'Awaiting Review'
	 

@HearingAssignALJ
Scenario: HearingAssignALJ
     		  
	Given path '/internalapi/api/HearingInfo/AssignAlj'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      
   	 And request {"aljId":1069,"hearingId":'#(parseInt(hearingId))',"taskId":6505}
   	 When method post
	 
	  Then status 200
	  * match response == 'true'	
	  
@HearingConclude
Scenario: HearingConclude
   Given path '/internalapi/api/HearingInfo/SavePostHearing'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      
	  * def payloadwithBothTrue = {"isConcluded":'#(ConcludeHearing)',"suppDocRequired":'#(suppDocRequired)',"suppDocDueDate":'#(date)',"aljNote":"Conclude Hearing by Automation","hearingid":'#(parseInt(hearingId))',"taskId":6509,"taskDecision":1,"submit":true}
	  * def payloadwithConcludeHearingFalse = {"isConcluded":false,"suppDocRequired":"","suppDocDueDate":"","aljNote":"No-Conclude Hearing by Automation","hearingid":'#(parseInt(hearingId))',"taskId":6509,"taskDecision":3,"submit":true}
	   * def payloadwithConcludeHearingTrueSupportDocFalse = {"isConcluded":true,"suppDocRequired":false,"suppDocDueDate":"","aljNote":"Yes Conclude Hearing- no Support Doc","hearingid":'#(parseInt(hearingId))',"taskId":6509,"taskDecision":2,"submit":true}
	 
	  * eval if( ConcludeHearing == true && suppDocRequired == true) payload = payloadwithBothTrue
	  * eval if( ConcludeHearing == true && suppDocRequired == false) payload = payloadwithConcludeHearingTrueSupportDocFalse 
	  * eval if( ConcludeHearing == false) payload = payloadwithConcludeHearingFalse 
   	 And request payload
   	 When method post
	 
	  Then status 200
	  * match response == 'true'	  
	  
	   * def wait = waitFunc(30)

@GetHearingALJQueue
Scenario: GetHearingALJQueue	
	
	Given path '/internalapi/api/HrDashboard/GetAljQueue'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      * def stringParam = "caseNo~contains~'"+referralCaseNo+"'"
       And params  {filter:'#(stringParam)',page:1,pageSize:10}
   
   	 And request {}
	  When method get
	 
	  Then status 200
	 
	  And match response.data[0].applicationStatus == applicationStatus
	  
	  
@GetHearingBureauQueue
Scenario: GetHearingBureauQueue	  
	  Given path '/internalapi/api/HrDashboard/GetHbDisciplinaryQueue'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      * def stringParam = "caseNo~contains~'"+referralCaseNo+"'"
       And params  {filter:'#(stringParam)',page:1,pageSize:10}
   
   	 And request {}
	  When method get
	 
	  Then status 200
	  
	  And match response.data[0].applicationStatus == HearingBureauStatus
	  
	  
@GetConsuelALJQueue
Scenario: GetConsuelALJQueue	   
	   Given path '/internalapi/api/CounselDashboard/GetCounselAttorneyClaimQueue'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      * def stringParam = "referralCaseApplicationNo~contains~'"+referralCaseNo+"'"
       And params  {filter:'#(stringParam)',page:1,pageSize:10,sort:'isNopResponse-desc~isDiscoveryResponse-desc~isRejectionResponse-desc'}
   
   	 And request {}
	  When method get
	 
	  Then status 200
	  And match response.data[0].taskStatus == ConsuelALJStatus
	  
	  
  
@GetHearingBureauReportReviewQueue
Scenario: GetHearingBureauReportReviewQueue	   
	   Given path '/internalapi/api/HrDashboard/GetHbReviewQueue'
	  
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      * def stringParam = "caseNo~contains~'"+referralCaseNo+"'"
       And params  {filter:'#(stringParam)',page:1,pageSize:10}
   
   	 And request {}
	  When method get
	 
	  Then status 200
	  And match response.data[0].applicationStatus == HearingBureauReportReviewStatus
	  
	  	  

@AttachAndSaveDocumentForHearingInfo
Scenario: AttachAndSaveDocumentForHearingInfo 
	 Given path '/internalapi/api/document/UploadDocument'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
     And request {"documentDesc":"HearingFlowDoc.docx","acaId":'#(parseInt(hearingId))',"acaType":"Hearing","bureau":"Hearing","documentType":{"key":464,"value":"Supplemental Documentation","description":null,"documentSubCategory":""},"documentCategory":null,"receivedDate":'#(receivedDate)',"createdDate":'#(date)',"documentBase64":"data:application/vnd.openxmlformats-officedocument.wordprocessingml.document;base64,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","contentType":"application/vnd.openxmlformats-officedocument.wordprocessingml.document","fileName":"HearingFlowDoc.docx","tempGuid":"a7a5c5be-a25b-a566-6fc0-50307669948e"}
      When method post
	  Then status 200
	  And print response
	  * match response == 'true'
	  
	   
	   Given path '/internalapi/api/HearingInfo/SuppDocReceived'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
     And request {"hearingid":'#(parseInt(hearingId))',"taskId":6515}
      When method post
	  Then status 200
	  And print response
	  * match response == 'true'
	  
	 Given path '/internalapi/api/documents/Hearing/464/'+hearingId
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
     
   	 And request {}
	  When method get
	 
	  Then status 200
	  * def docData = karate.jsonPath(response, "$[?(@.documentDesc == 'HearingFlowDoc.docx')]")
	 
	 * def fileName = docData[0].fileName
	 
	 * match fileName == 'HearingFlowDoc.docx' 
	  	  


@UploadDocumentForHearingExhibits
Scenario: UploadDocumentForHearingExibits 
	 Given path '/internalapi/api/document/UploadDocument'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
     And request {"documentDesc":"HearingExhibits.docx","acaId":'#(parseInt(hearingId))',"acaType":"HearingExhibit","bureau":"Hearing","documentType":{"key":21,"value":"ALJ'S EXHIBIT III IN EVIDENCE","description":null,"documentSubCategory":"ALJ EVIDENCE"},"documentCategory":null,"receivedDate":'#(receivedDate)',"createdDate":'#(date)',"documentBase64":"data:application/vnd.openxmlformats-officedocument.wordprocessingml.document;base64,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","contentType":"application/vnd.openxmlformats-officedocument.wordprocessingml.document","fileName":"HearingExhibits.docx","tempGuid":"c992886e-f044-2f76-fed1-6d3212f4e598"}
      When method post
	  Then status 200
	  And print response
	  * match response == 'true'
	  
@UploadAndSubmitALJDocumentForHearing
Scenario: UploadAndSubmitALJDocumentForHearing 
	 Given path '/internalapi/api/document/UploadDocument'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
     And request {"documentDesc":"AljDoc.docx","acaId":'#(parseInt(hearingId))',"acaType":"Hearing","bureau":"Hearing","documentType":{"key":18,"value":"ALJ REPORT","description":null,"documentSubCategory":"ALJ"},"documentCategory":null,"receivedDate":'#(receivedDate)',"createdDate":'#(date)',"documentBase64":"data:application/vnd.openxmlformats-officedocument.wordprocessingml.document;base64,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","contentType":"application/vnd.openxmlformats-officedocument.wordprocessingml.document","fileName":"AljDoc.docx","tempGuid":"997a6f78-4643-5de8-f744-8e5565abbb2d"}
      When method post
	  Then status 200
	  And print response
	  * match response == 'true'	 
	  
	   Given path '/internalapi/api/HrAljReport/SaveAljReport'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
     And request {"charges":[{"chargeId":109,"caseId":'#(parseInt(caseNumber))',"chargeTypeId":null,"chargeTypeValue":"DISORDERLY PREMISES - MINGLING","chargeDate":'#(conditionDefinedDate)',"description":"That on or about [insert date], in violation of subdivision 6 of section 106 of the Alcoholic Beverage Control Law, the licensee suffered or permitted the licensed premises to become disorderly, to wit: mingling.","chargeOrderNo":1,"isSummarySuspension":null,"chargeStatusId":"201","chargeStatusValue":null,"hasSavedAsDraft":null,"isWithdrawn":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null,"ChargeStatus":"Sustained","ChargeStatusValue":"Sustained"}],"reportId":0,"taskId":6529,"caseId":'#(parseInt(caseNumber))',"hearingId":'#(parseInt(hearingId))',"reportTypeId":"207","isLicenseePresent":true,"hbComments":null}
      When method post
	  Then status 200
	  And print response
	  * match response == 'true'	
	  * def wait = waitFunc(25)	

 Given path '/internalapi/api/HrAljReport/SubmitAljReport'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
     And request {"charges":[],"hearingId":'#(parseInt(hearingId))',"taskId":6529,"reportCanBeSubmitted":true} 
 When method post
	  Then status 200
	  And print response
	  * match response == 'true'	
	  
@ServeSubpoena
Scenario: ServeSubpoena 
	
      Given path '/internalapi/api/Witness/GetWitnessesByCaseId/'+caseNumber
	* def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
     
   	  And request {}
	  When method get
	 
	  Then status 200
	  * def witnessName = response[0].witnessName
	  * def witnessId = response[0].witnessId	 
	  * def caseId = response[0].caseId 
	  And print caseId

      Given path '/internalapi/api/Subpoena/GetSubpoenaPreviewLetterPlaceHolder/'+caseNumber
	* def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
     
   	  And request {}
	  When method get
	  Then status 200

	 * def key0 = response[0].key
	 * def value0 = response[0].value
	 * def key1 = response[0].key
	 * def value1 = response[0].value
	 * def key2 = response[0].key
	 * def value2 = response[0].value
	 * def key3 = response[0].key
	 * def value3 = response[0].value
	 * def key4 = response[0].key
	 * def value4 = response[0].value
	 * def key5 = response[0].key
	 * def value5 = response[0].value
	 * def key6 = response[0].key
	 * def value6 = response[0].value
	 * def key7 = response[0].key
	 * def value7 = response[0].value
	 * def key8 = response[0].key
	 * def value8 = response[0].value
	 * def key9 = response[0].key
	 * def value9 = response[0].value
	 * def key10 = response[0].key
	 * def value10 = response[0].value
	 * def key11 = response[0].key
	 * def value11 = response[0].value
	 * def key12 = response[0].key
	 * def value12 = response[0].value
	 * def key13 = response[0].key
	 * def value13 = response[0].value
	 * def key14 = response[0].key
	 * def value14 = response[0].value
	 * def key15 = response[0].key
	 * def value15 = response[0].value
	 * def key16 = response[0].key
	 * def value16 = response[0].value
	 * def key17 = response[0].key
	 * def value17 = response[0].value
	 * def key18 = response[0].key
	 * def value18 = response[0].value
	 * def key19 = response[0].key
	 * def value19 = response[0].value
	 * def key20 = response[0].key
	 * def value20 = response[0].value
	 * def key21 = response[0].key
	 * def value21 = response[0].value
	 * def key22 = response[0].key
	 * def value22 = response[0].value
	 * def key23 = response[0].key
	 * def value23 = response[0].value
	 * def key24 = response[0].key
	 * def value24 = response[0].value
	 * def key25 = response[0].key
	 * def value25 = response[0].value
	 * def key26 = response[0].key
	 * def value26 = response[0].value
	 * def key27 = response[0].key
	 * def value27 = response[0].value
	 * def key28 = response[0].key
	 * def value28 = response[0].value
	 * def key29 = response[0].key
	 * def value29 = response[0].value
	 * def valueType29 = response[0].valueType
	 * def key30 = response[0].key
	 * def value30 = response[0].value
	 * def key31 = response[0].key
	 * def value31 = response[0].value
	 * def key31 = response[0].key
	 * def value31 = response[0].value
	 * def key32 = response[0].key
	 * def value32 = response[0].value
	 * def key33 = response[0].key
	 * def value33 = response[0].value
	 * def key34 = response[0].key
	 * def value34 = response[0].value
	 	
	  Given path 'internalapi/api/template/generatepdfletter/151'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request [{"key":'#(key0)',"value":'#(value0)',"valueType":"STR"},{"key":'#(key1)',"value":'#(value1)',"valueType":"STR"},{"key":'#(key2)',"value":'#(value2)',"valueType":"STR"},{"key":'#(key3)',"value":'#(value3)',"valueType":"STR"},{"key":'#(key4)',"value":'#(value4)',"valueType":"STR"},{"key":'#(key5)',"value":'#(value5)',"valueType":"STR"},{"key":'#(key6)',"value":'#(value6)',"valueType":"STR"},{"key":'#(key7)',"value":'#(value7)',"valueType":"STR"},{"key":'#(key8)',"value":'#(value8)',"valueType":"STR"},{"key":'#(key9)',"value":'#(value9)',"valueType":"STR"},{"key":'#(key10)',"value":'#(value10)',"valueType":"STR"},{"key":'#(key11)',"value":'#(value11)',"valueType":"STR"},{"key":'#(key12)',"value":'#(value12)',"valueType":"STR"},{"key":'#(key13)',"value":'#(value13)',"valueType":"STR"},{"key":'#(key14)',"value":'#(value14)',"valueType":"STR"},{"key":'#(key15)',"value":'#(15)',"valueType":"STR"},{"key":'#(key16)',"value":'#(value16)',"valueType":"STR"},{"key":'#(key17)',"value":'#(value17)',"valueType":"STR"},{"key":'#(key18)',"value":'#(value18)',"valueType":"STR"},{"key":'#(key19)',"value":'#(value19)',"valueType":"STR"},{"key":'#(key20)',"value":'#(value20)',"valueType":"STR"},{"key":'#(key21)',"value":'#(value21)',"valueType":"STR"},{"key":'#(key22)',"value":'#(value22)',"valueType":"STR"},{"key":'#(key23)',"value":'#(value23)',"valueType":"STR"},{"key":'#(key24)',"value":'#(value24)',"valueType":"STR"},{"key":'#(key25)',"value":'#(value25)',"valueType":"STR"},{"key":'#(key26)',"value":'#(value26)',"valueType":"STR"},{"key":'#(key27)',"value":'#(value27)',"valueType":"STR"},{"key":'#(key28)',"value":'#(value28)',"valueType":"STR"},{"key":'#(key29)',"value":'#(value29)',"valueType":'#(valueType29)'},{"key":'#(key30)',"value":'#(value30)',"valueType":"STR"},{"key":'#(key31)',"value":'#(value31)',"valueType":"STR"},{"key":'#(key32)',"value":'#(value32)',"valueType":"STR"},{"key":'#(key33)',"value":'#(value33)',"valueType":"STR"},{"key":'#(key34)',"value":'#(value34)',"valueType":"STR"},{"key":"SubpoenaAddress","valueType":"STR","value":"431, new york, New York 12121"},{"key":"SubpoenaDay","valueType":"STR","value":"5"},{"key":"SubpoenaMonth","valueType":"STR","value":"2"},{"key":"SubpoenaYear","valueType":"STR","value":"2023"},{"key":"SubpoenaTime","valueType":"STR","value":"12:00 PM"},{"key":"WitnessName","valueType":"STR","value":'#(witnessName)'},{"key":"documentsName","valueType":"STR","value":"test subpoena"}]
      When method post
	  Then status 200
	  And print response
	   
	   Given path 'internalapi/api/Subpoena/Create'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {"address":{"addressLine1":"431","addressLine2":"","stateId":40,"county":"Albany","city":"new york","zipCode":"12121","zip4":"","country":"United States (US)","stateName":"New York","countryId":229},"caseId":'#(caseNumber)',"letterTemplateId":'#(letterTemplateId)',"dueDate":'#(fundDueDate)',"documentsName":"test subpoena","serveSubpoena":true,"serveDate":'#(fundDueDate)',"witnessIds":['#(witnessId)']}
      When method post
	  Then status 200
	  And print response
	* match response == 'true'
	  
@CounselPrepareNOP
Scenario: CounselPrepareNOP
   
      Given path 'internalapi/api/CounselDashboard/GetCounselAttorneyClaimQueue'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      * def stringParam = "referralCaseApplicationNo~contains~'"+referralCaseNo+"'"
       And params  {filter:'#(stringParam)',page:1,sort=isNopResponse-desc~isDiscoveryResponse-desc~isRejectionResponse-desc,pageSize:10'}
     
   	 And request {filter:'#(stringParam)',page:1,sort=isNopResponse-desc~isDiscoveryResponse-desc~isRejectionResponse-desc,pageSize:10'}
	  When method get
	 
	   Then status 200
	   And def taskStatus = response.data[0].taskStatus
	   And def workflowName = response.data[0].workflowName
	   And def wfRoleId = response.data[0].wfRoleId
	   And def taskId = response.data[0].taskId
	   And def caseId = response.data[0].referralCaseApplicationId
	   And def caseNo = response.data[0].referralCaseApplicationNo
	  
       And match taskStatus == "Awaiting Review"
       
       	  Given path 'internalapi/api/Charge/GetChargeDescByTypeId/'
	   	
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;*/*'
	     
	   	 And request {"chargeTypeId":"1"}
		 When method post
		  Then status 200
		        	  
	  Given path 'internalapi/api/Charge/SyncCharges/'
	   	
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;*/*'
	     
	   	 And request {"caseId":'#(caseId)',"isSubmit":true,"charges":[{"chargeId":264,"caseId":'#(caseId)',"chargeTypeId":1,"chargeTypeValue":"ADVERTISING TO PUBLIC","chargeDate":'#(date)',"description":"test charge","chargeOrderNo":1,"isSummarySuspension":null,"chargeStatusId":null,"chargeStatusValue":null,"hasSavedAsDraft":null,"isWithdrawn":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":true,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null,"descriptionTemp":"test charge","chargeDateString":'#(ChargesStrDate)'}]}
		 When method post
		  Then status 200
		 
		 And match response == 'true'
		 
	  Given path 'internalapi/api/Nop/GetNopLetterPreviewLetterPlaceHolder'
	  
	   * def dbSts = db.cleanHeap()
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;*/*'
	     
	   	 And request {"caseId":'#(caseId)',"memoText":"test memo","penalty":"","noptypeId":"1","isSummarySuspension":'#(suspensionStatus)',"responseReceiveDate":'#(responseReceiveDate)',"nopdate":'#(effectiveDate)',"taskId":7105,"taskDecision":2,"mailingAddressTypeList":"5","billOfParticularText":"","isPreviewLoaded":true,"otherEMail":""}
		 When method post
		  Then status 200
		 * def resBody = response
		 And print response
   Given path 'internalapi/api/template/GenerateLetterWithMultiple'
	  
	   * def dbSts = db.cleanHeap()
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;*/*'
	     
	   	 And request {"templateIds":[164,319],"placeHolderDtos":'#(resBody)'}
		 																
		 When method post
		  Then status 200
		 * def base64Val = response.base64
	 
	  Given path '/internalapi/api/Nop/PrepareNop'
	  
	   * def dbSts = db.cleanHeap()
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;*/*'
	     
	   	 And request {"caseId":'#(caseNumber)',"memoText":"Test","penalty":"","noptypeId":"1","isSummarySuspension":'#(suspensionStatus)',"responseReceiveDate":'#(responseReceiveDate)',"nopdate":'#(effectiveDate)',"taskId":7105,"taskDecision":2,"mailingAddressTypeList":"3","billOfParticularText":"","isPreviewLoaded":true,"otherEMail":""}
		 When method post
		  Then status 200
		 
		 And match response == 'true'

      Given path 'internalapi/api/CounselDashboard/GetCounselSupportStaffClaimQueue'
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      * def stringParam = "referralCaseNo~contains~'"+caseNo+"'"
       And params  {filter:'#(stringParam)',page:1,sort=referralCaseId-desc,pageSize:10'}
     
   	 And request {filter:'#(stringParam)',page:1,sort=referralCaseId-desc,pageSize:10'}
	  When method get
	 
	   Then status 200
	   And def taskStatus = response.data[0].taskStatus
	   And def workflowName = response.data[0].workflowName
	   And def wfRoleId = response.data[0].wfRoleId
	   And def taskId = response.data[0].taskId
	   And def caseId = response.data[0].referralCaseId
	   And def caseNo = response.data[0].referralCaseNo
	  
       And match taskStatus == "Process NOP"

	      Given path 'internalapi/api/auditLog/logAcaAudit'
	   	
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;*/*'
	     
	    And request {"acaId":'#(caseId)',"acaType":"Case","tab":"Actions","wfStatus":'#(taskStatus)',"reportAccessed":false}
		 When method post
		  Then status 200
		 
		 And match response == 'true'
		 
		  Given path 'internalapi/api/auditLog/logAcaAudit'
	   	
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;*/*'
	     
	   	 And request {"acaId":'#(caseId)',"acaType":"Case","tab":"Workflow History","wfStatus":'#(taskStatus)',"reportAccessed":false}
		 When method post
		  Then status 200
		 
		 And match response == 'true'

	   Given path 'internalapi/api/wfhistory/'+caseId+'/Case'
       And header Content-Type = 'application/json; charset=utf-8'
       And header Accept = 'application/json; text/plain;*/*'
       And header authorization = 'Bearer ' + strToken
       And params  {page:1,pageSize:10}
       And request {page:1,pageSize:10}
	  When method get
	  Then status 200
      * def currentStatus = response.currentStatus
      * def bureau = response.bureau

      * match bureau == "Counsel/Secretary’s Office"
      * match currentStatus == "Awaiting Review"
 
@AssignCaseToAttorneyDCOL
Scenario: AssignCaseToAttorneyDCOL
   
     Given path 'internalapi/api/CounselAssignment/CheckAssignment/Application/'+appId+'/33'
	  
	   * def dbSts = db.cleanHeap()
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;*/*'
	     
	   	 And request ""
		 When method get
		  Then status 200
		 
		 And match response == 'false'  
		 
         Given path 'internalapi/api/CounselAssignment/AssignToUser'
	  
	   * def dbSts = db.cleanHeap()
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;*/*'
	     
	   	 And request {"assignedUserId":1069,"currentRoleId":8,"type":"Application","id":'#(appId)',"currentWfRoleId":33}
		 When method post
		  Then status 200
		 
		 And match response == 'true'    
		 
	   Given path 'internalapi/api/CounselDashboard/GetCounselAttorneyClaimQueue'
       And header Content-Type = 'application/json; charset=utf-8'
       And header Accept = 'application/json; text/plain;*/*'
       And header authorization = 'Bearer ' + strToken
         * def stringParam = "referralCaseApplicationNo~contains~'"+ApplicationId+"'" 
       And params  {filter:'#(stringParam)',page:1,sort=isNopResponse-desc~isDiscoveryResponse-desc~isRejectionResponse-desc,pageSize:10}
      And request {filter:'#(stringParam)',page:1,sort=isNopResponse-desc~isDiscoveryResponse-desc~isRejectionResponse-desc,pageSize:10}
	  When method get
	  Then status 200
      * def taskId = response.data[0].taskId
      * def taskStatus = response.data[0].taskStatus
      * def workflowName = response.data[0].workflowName
      * def referralCaseApplicationNo = response.data[0].referralCaseApplicationNo
      
      And match taskStatus == '#(expTaskStatus)'

@InitiateAppReconByAttorney
Scenario: InitiateAppReconByAttorney 
		 
         Given path 'internalapi/api/CounselApp/InitiateAppRecon'
	  
	   * def dbSts = db.cleanHeap()
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;*/*'
	     
	   	 And request {"appId":'#(appId)',"memo":"test recon by attorney memo","taskId":7451}
		 When method post
		  Then status 200
		 
		 And match response == 'true'    
		 
@SearchChairmanCounselGrid
Scenario: SearchChairmanCounselGrid 
		 
	   Given path 'internalapi/api/CounselDashboard/GetCounselChairmanQueue'
       And header Content-Type = 'application/json; charset=utf-8'
       And header Accept = 'application/json; text/plain;*/*'
       And header authorization = 'Bearer ' + strToken
         * def stringParam = "appCaseNo~contains~'"+ApplicationId+"'" 
       And params  {filter:'#(stringParam)',page:1,desc,pageSize:10}
      And request {filter:'#(stringParam)',page:1,pageSize:10}
	  When method get
	  Then status 200
      * def taskId = response.data[0].taskId
      * def taskStatus = response.data[0].taskStatus
      * def workflowName = response.data[0].workflowName
      * def referralCaseApplicationNo = response.data[0].referralCaseApplicationNo
      
      And match taskStatus == "Recon Requested" 

@WfhistoryCheckChairman
Scenario: WfhistoryCheckChairman

	   Given path 'internalapi/api/wfhistory/'+ApplicationId+'/Case'
       And header Content-Type = 'application/json; charset=utf-8'
       And header Accept = 'application/json; text/plain;*/*'
       And header authorization = 'Bearer ' + strToken
       And params  {page:1,pageSize:10}
       And request {page:1,pageSize:10}
	  When method get
	  Then status 200
      * def currentStatus = response.currentStatus
      * def bureau = response.bureau

      * match bureau == "Counsel"
      * match currentStatus == "Recon Requested"

@ReconByChairman
Scenario: ReconByChairman
   
     Given path 'internalapi/api/CounselApp/GetAppAttorneyMemo/'+appId
	  
	   * def dbSts = db.cleanHeap()
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;*/*'
	     
	   	 And request ""
		 When method get
		  Then status 200
		 
		 And match response == "test recon by attorney memo"  
		 
         Given path 'internalapi/api/CounselApp/SubmitAppChairmanResponse'
	  
	   * def dbSts = db.cleanHeap()
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;*/*'
	     
	   	 And request {"appId":'#(appId)',"taskId":7452,"taskDecision":'#(taskDecision)',"memo":""}
		 When method post
		  Then status 200
		 
		 And match response == 'true'    
		 
@FullBoardSecOffice2Search
Scenario: FullBoardSecOffice2Search
   
	   Given path 'internalapi/api/SoDashboardSecLevel/GetLicenseApplicationQueueLev2'
       And header Content-Type = 'application/json; charset=utf-8'
       And header Accept = 'application/json; text/plain;*/*'
       And header authorization = 'Bearer ' + strToken
         * def stringParam = "applicationId~contains~'"+ApplicationId+"'" 
       And params  {filter:'#(stringParam)',page:1,pageSize:10}
      And request {filter:'#(stringParam)',page:1,pageSize:10}
	  When method get
	  Then status 200
      * def taskId = response.data[0].taskId
      * def applicationStatus = response.data[0].applicationStatus
      * def workflowName = response.data[0].workflowName
      
      And match applicationStatus == 'Awaiting Review'
		 
	   Given path 'internalapi/api/wfhistory/'+appId+'/Application'
       And header Content-Type = 'application/json; charset=utf-8'
       And header Accept = 'application/json; text/plain;*/*'
       And header authorization = 'Bearer ' + strToken
       And params  {page:1,pageSize:10}
       And request {page:1,pageSize:10}
	  When method get
	  Then status 200
      * def currentStatus = response.currentStatus
      * def bureau = response.bureau

      * match bureau == "Secretary’s Office"
      * match currentStatus == "Awaiting Review"
      
@NOPProcessingCompleteFlowCounsel
Scenario: NOPProcessingCompleteFlowCounsel
	  Given path '/internalapi/api/Nop/MoveWorkflowAfterNop'
	  
	   * def dbSts = db.cleanHeap()
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;*/*'
	     And header current-wfroleid = '32'
	   	 And request {"caseId":'#(parseInt(caseNumber))',"trackingNo":'#(truckingNumber)',"taskId":7108} 
		 When method post
		  Then status 200
		 
		 And match response == 'true'		 
		 
	 Given path '/internalapi/api/CounselDashboard/GetCounselSupportStaffClaimQueue'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      * def stringParam = "referralCaseNo~contains~'"+referralCaseNo+"'"
       And params  {filter:'#(stringParam)',page:1,pageSize:10,sort:'referralCaseId-desc'}
   
   	 And request {}
	  When method get
	 
	  Then status 200
	   
	   And match response.data[0].taskStatus == 'NOP Processing Complete'

@CounselDissaprovalHearing
Scenario: CounselDissaprovalHearing
	  
	  Given path 'internalapi/api/CounselSearch/GenericSearch'
	  
	   * def dbSts = db.cleanHeap()
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json; charset=utf-8'
	      And header Accept = 'application/json; text/plain;*/*'
	     And header current-wfroleid = '32'
	   	 And request {"applicationId":'#(ApplicationId)',"legalName":"","dBA":"","caseNo":"","licensePermitId":""} 
		 When method post
		  Then status 200
		 
        * def legalName = response[0].legalName
        * def taskStatus = response[0].taskStatus
        
        And match taskStatus == 'Disapproved'

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
  	  
  	  Given path 'internalapi/api/documents/GetDocuments'
      
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {"type":"application","id":'#(appId)',"subCategory":""}
	  When method post
	  Then status 200
	  And print response
	  
	  * def totalEnfCount = response.length 
	  * def beforeReferEnfcount = totalEnfCount
  	  
	  Given path '/internalapi/api/document/UploadDocument'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {"documentDesc":"Disapproval Hearing Request","acaId":'#(appId)',"acaType":"application","bureau":"lic","documentType":{"key":324,"value":"Disapproval Hearing Request","description":null,"documentSubCategory":"Disapproval"},"documentCategory":null,"receivedDate":'#(receivedDate)',"createdDate":'#(date)',"documentBase64":"data:application/vnd.openxmlformats-officedocument.wordprocessingml.document;base64,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","contentType":"application/vnd.openxmlformats-officedocument.wordprocessingml.document","fileName":"TestDocument.docx","tempGuid":"a6fd31bc-fa24-f48f-a4ee-27338b50493c"}
              #   {"documentDesc":"Disapproval Hearing Request","acaId":57252     ,"acaType":"Application","bureau":"lic","documentType":{"key":324,"value":"Disapproval Hearing Request","description":null,"documentSubCategory":"Disapproval"},"documentCategory":null,"receivedDate":"2023/01/23","createdDate":"2023-01-23T19,"documentBase64":"data:application/vnd.openxmlformats-officedocument.wordprocessingml.document;base64,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","contentType":"application/vnd.openxmlformats-officedocument.wordprocessingml.document","fileName":"Deficiency Letter.docx","tempGuid":"47054036-8e97-06b4-8f88-979fda47e388"}
      When method post
	  Then status 200
	  And print response
	  * match response == 'true'	
	  
	  Given path 'internalapi/api/documents/GetDocuments'
      
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {"type":"application","id":'#(appId)',"subCategory":""}
	  When method post
	  Then status 200
	  And print response
	  
	  * def totalEnfCount = response.length 
	  * def afterReferEnfcount = totalEnfCount
	     And print beforeReferEnfcount
	     And print afterReferEnfcount
	     * assert afterReferEnfcount > beforeReferEnfcount
	     	   	   		                   		  		        	  	     
	  Given path 'internalapi/api/CounselApp/InitiateAppHearing/'+appId
      
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request ""
	  When method get
	  Then status 200
      And match response == 'true'
 
 	 Given path 'internalapi/api/CounselDashboard/GetCounselAttorneyQueue'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      * def stringParam = "referralCaseApplicationNo~contains~'"+ApplicationId+"'"
       And params  {filter:'#(stringParam)',page:1,pageSize:10}
   
   	 And request {}
	  When method get
	 
	  Then status 200
	   
	   And match response.data[0].taskStatus == 'Schedule For Hearing'    
	   
	   Given path 'internalapi/api/wfhistory/'+appId+'/Application'
       And header Content-Type = 'application/json; charset=utf-8'
       And header Accept = 'application/json; text/plain;*/*'
       And header authorization = 'Bearer ' + strToken
       And params  {page:1,pageSize:10}
       And request {page:1,pageSize:10}
	  When method get
	  Then status 200
      * def currentStatus = response.currentStatus
      * def bureau = response.bureau

      * match bureau == 'Counsel'
      * match currentStatus == 'Schedule For Hearing'

@ValidateEmailCommunicationQueueCase
 Scenario: ValidateEmailCommunicationQueueCase 
	
	Given path '/internalapi/api/Communication/GetEmailCommQueue/case/'+referralCaseId
	   	
	 	And header authorization = 'Bearer ' + strToken
	  	And header Content-Type = 'application/json; charset=utf-8'
	    And header Accept = 'application/json; text/plain;*/*'
	    And header user-agent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36'
	  	And request ""
	    When method get
	    Then status 200	    
	    
	    And def serverResponse = response
	    And print response
	    
	    * def serverResponseNotificationData = karate.jsonPath(serverResponse, "$[?(@.typeOfNotification == '" + typeOfNotification + "')]")
		And print serverResponseNotificationData
		* match serverResponseNotificationData[0].status == 'Sent'
		* match serverResponseNotificationData[0].emailTo != []
		* match serverResponseNotificationData[0].subject == subject
		* match serverResponseNotificationData[0].emailBody contains emailBodyData


@CounselCreateLic  
 Scenario Outline: CounselCreateLic
   * def licKeywordName = 'Automation'	
	# ********* Login Functionality *********************
  		* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
  		
		* def IndOrgSelectionDropDown = <IndOrgSelection>
  		* def indOrgCode = getIndORgCodeFunc(IndOrgSelectionDropDown)
  			And print indOrgCode
  		* def isIndStatus = getStatusIndOrgStatus(IndOrgSelectionDropDown)
	    * def CorporateStructureDropDown = <CorporateStructure>
	    * def CorporateStructureDropDownCode = getIndORgCodeFunc(indOrgCode,CorporateStructureDropDown)
	   		And print CorporateStructureDropDownCode
	    * def firstName = <FirstName>
	    * def lastName = <LastName>
	    * def legalName = firstName+ ' '+lastName
	    * def Address1 = <Address1>
	    * def Address2 = <Address2>
	    * def CityName = <City>
	    * def zipCode = <ZipCode>
	    * def postalCode = <PostalCode>
	    * def countryName = <Country>
	    * def emailId = <Email>
	    * def convictedOfCrime = <convictedOfCrime>
	    * def percentageOfOwners = <percentageOfOwners>
	    * def isFingerprintRequired = <isFingerprintRequired>
	    * def isFingerprintsApproved = <isFingerprintsApproved>
	    * def isSignature = <isSignature>
	    
	    * def convictedOfCrime = <convictedOfCrime>
		* def PhoneNumber = <PhoneNumber>
		* def PhoneExtn = <PhoneExtn>
		* def countryCode = <countryCode>
		* def stateCode = <StateCode>
	    
	  	* def mainLicensePermitTypeId = <LicensePermitTypeId>
	    * def termInYears = <NumberOfTerm>
	    * def termDesc = <NumberOfTerm>+' Year (s)'
	    * def licenseFees = <InitialLicFee>
	    * def fillingFees = <NonRefundableFilingFees>
	    * def licAncillaryFees = <AncillaryFees>
	    * def renewalFees = <RenewalFilingFees>+''
	    * string productName = <ProductTypes>+''
	     * def CountyID = <countyIds>
	    * def CountyId = <countyIds>
	    * def CountyName = <County>	
		* def totalFees = licenseFees+fillingFees+licAncillaryFees
	      * def splittedCityName = CityName.replaceAll(" ","")
	   ## ******************** UC_RenewalIntakeApp: Validate TC0001_SLA_REN_Intake_Onpremises_License_Inside_5_Boroughts_Submit Scenario Start ***************************##
	   	* call read('LicensesCommonMethods.feature@IntakeLicensewithoutAssociatedLic') {}
        * def CountyName = "New York"
        * call read('LicensesCommonMethods.feature@FillAndSaveApplicantInformationPage') {county:'#(CountyName)'}
        * call read('LicensesCommonMethods.feature@FillAndSavePrincipalPage') {}
        * call read('LicensesCommonMethods.feature@FillAndSaveRepresentativePage') {}
        * call read('LicensesCommonMethods.feature@FillAndSaveMethodOfOperationPage') {}
        * call read('LicensesCommonMethods.feature@WaveFeesValidation') {}
       
        * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	   	 * call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {}
        * call read('LicensesCommonMethods.feature@ExaminerReviewApprovalToLB') {}
        * call read('LicensesCommonMethods.feature@LBClaimingQueue') {}
         * def expirationDate = fundDueDateFunc(10)
        * call read('LicensesCommonMethods.feature@LBApprovalWithDueDate') {approvalName:'Approved', expStatus:'Approved'}
        * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Approved'}
	   	
	   * call read('LicensesCommonMethods.feature@GetLicenseId') {} 
	   	 And print licenseId
	   
 Examples:
    | read('/CSVFiles/RenewalOnPremises.csv') |	        	  	     	   	   		                   		  		        	  	     
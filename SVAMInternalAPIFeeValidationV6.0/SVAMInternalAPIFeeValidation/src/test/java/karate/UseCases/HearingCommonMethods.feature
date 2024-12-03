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
		  
		  * def currentTimeFunc =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("HH:mm");
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		  """
		   * def currentTime = currentTimeFunc()
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
#********* SignIn *********************


@AddReferralForm
Scenario: AddReferralForm



	#Given path '/internalapi/api/license/searchNames/'+licKeywordName
	   #	* def dbSts = db.cleanHeap()
	   #   And header authorization = 'Bearer ' + strToken
	  #	  And header Content-Type = 'application/json;charset=utf-8'
	    #  And header Accept = 'text/plain'
	     
	    # And request {}
		#  When method get
		 
		 # Then status 200
		  #* def lpApplicationId = response[0].lpApplicationId
		  #  And print lpApplicationId
		    
	Given path '/internalapi/api/documents/GetDocuments'
			* def dbSts = db.cleanHeap()
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json;charset=utf-8'
	      And header Accept = 'text/plain'
	     * def randomNum = db.getRandomNumber(999999)
	     * def Guid =  '494f4db9-fdc1-3949-235c-9c'+randomNum+'e68c'
	     
	     And request {"type":"Referral","id":'#(Guid)',"subCategory":""}
		  When method POST
		 
		  Then status 200
		    
	#Given path 'internalapi/api/license/'+lpApplicationId
	
	
	Given path '/internalapi/api/licensingCommon/GetLicensePermitByLpIdLegalNameDba/'+licenseId+'/1'
	   	* def dbSts = db.cleanHeap()
	      And header authorization = 'Bearer ' + strToken
	  	  And header Content-Type = 'application/json;charset=utf-8'
	      And header Accept = 'text/plain'
	     
	     And request {}
		 When method get
		 Then status 200
		 * def lpApplicationId = response[0].lpApplicationId
		 And print lpApplicationId	
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
	      
	      And header dnt = '1'
	     And request {"referralId":"","referralNo":"","licenseId":'#(licId)',"premisesId":'#(premisesId)',"referralTypeId":"","additionalDetail":"","isPoliceContacted":"","policeDepartment":"","isCaseInchargeKnown":"","inchargeName":"","isEvidenceOfIncident":"","asignedAtorney":"","referralStatus":"","isLicensedReferral":"","caseId":"","hasRelatedCase":"","isReferralSubmitted":"","isActive":"","complainantId":"","complaintType":"19","otherComplaintType":"","complainantInfoDto":{"complainantId":"","communicationTypeId":11,"sourceId":"3","otherSourceText":"","agencyId":null,"policeDeptId":"","personId":"","addressId":"","isActive":"","Person":{"personId":"","phoneNo":"","email":"","faxNo":""},"Address":{"addressLine1":"","addressLine2":"","stateId":40,"county":"","city":"","zipCode":"","zip4":"","country":"United States (US)","stateName":"New York","countryId":229},"otherCommType":"","borough":"","communityBoardId":null,"pdCounty":"","OtherComplaintType":null,"OtherCommType":null},"premisesInfo":{"premisesId":'#(premisesId)',"licPermitId":"","licId":'#(licId)',"legalName":'#(legalName)',"type":null,"dba":null,"addressId":'#(addressId)',"licenseDescription":null,"createdBy":"","createdDate":"","modifiedBy":"","modifiedDate":null,"isActive":"","Address":{"addressLine1":"Address1","addressLine2":"Address2","stateId":40,"county":"New York","city":"New York","zipCode":"12345","zip4":"1234","country":"United States (US)","stateName":"New York","countryId":229,"addressId":135103},"licenseStatus":"Active","licenseType":"Restaurant-Beer"},"lpApplicationId":'#(lpApplicationId)',"noiseSource":"","complaintWhereId":"","complaintInvolvePeopleTypeId":"","complaintInvolvePeopleReason":"","natureOfIncident":"","isUnKnownValue":false,"unknownReason":"","incidentKnownReason":"","incidentDuration":"","licensePermitNo":'#(licensePermitNo)',"isUnknown":false,"tempGuid":'#(Guid)',"complaintTypeIds":[19],"complaintTypeOther":""}
        When method post
		  Then status 200
		  
		  * def caseNumber = response
		 And print caseNumber
	  
	  

@ApplicationHearingInfo
Scenario: ApplicationHearingInfo
   
	Given path '/internalapi/api/HrDashboard/GetHbLicensingQueue/'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      
      * def stringParam = "applicationId~contains~'"+ApplicationId+"'"
       And params  {filter:'#(stringParam)',page:1,pageSize:10,sort:hearingId-desc}
   
   	 And request {}
	  When method get
	 
	  Then status 200
	  * def hearingId = response.data[0].hearingId
	   * def caseNumber = response.data[0].caseNo
	   * def taskId = response.data[0].taskId
	   * def referralCaseNo = ApplicationId
	  And match response.data[0].applicationStatus == 'Awaiting Review'


@SecOffLevel2LicAppQueue
Scenario: SecOffLevel2LicAppQueue
   
	Given path '/internalapi/api/SoDashboardSecLevel/GetLicenseApplicationQueueLev2'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
     
      * def stringParam = "applicationId~contains~'"+ApplicationId+"'"
       And params  {filter:'#(stringParam)',page:1,pageSize:10}
  
   	 And request {}
	  When method get
	 
	  Then status 200
	  
	  And match response.data[0].applicationStatus == LicAppQueueStatus 


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
	     
	   	 And request {"caseId":'#(caseNumber)',"memoText":"","penalty":"","noptypeId":"1","isSummarySuspension":false,"responseReceiveDate":'#(responseReceiveDate)',"nopdate":'#(effectiveDate)',"taskId":7105,"taskDecision":2,"mailingAddressTypeList":"3","billOfParticularText":"","isPreviewLoaded":true,"otherEMail":""}
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
       And params  {filter:'#(stringParam)',page:1,pageSize:10}
   
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
	 
	 
	 

@ScheduleCouselToHearingApplication
Scenario: ScheduleCouselToHearingApplication
   
	Given path '/internalapi/api/CounselApp/GetAppWitnesses/'+caseNumber
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
      
   	 And request {"scheduleId":"","hearingId":"","hearingDate":'#(date)',"hearingLocationId":"19","note":"","hearingInfoDto":{"hearingId":"","caseId":"","appId":'#(parseInt(caseNumber))',"hearingTypeId":"","hearingType":"","taskId":""},"witnessIds":['#(parseInt(witnessId))'],"addressId":"","taskId":7152}
	  When method post
	  Then status 200
	  * match response == 'true'	  
	
	
	
	 
	 

@HearingGenericSearch
Scenario: HearingGenericSearch	 
	 Given path '/internalapi/api/GenericSearch/SearchHearing'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      
       And params  {page:1,pageSize:10}
   
   	 And request [{"dataTypeValue":"Text","key":"CaseNo","operatorValue":"=","value":'#(referralCaseNo)'}]
	  When method post
	 
	  Then status 200
	  * def taskId = response.data[0].taskId
	  And match response.data[0].applicationStatus == applicationStatus	 

@HearingGenericSearchByAppID
Scenario: HearingGenericSearchByAppID	 
	 Given path '/internalapi/api/GenericSearch/SearchHearing'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      
       And params  {page:1,pageSize:10}
   
   	 And request [{"dataTypeValue":"Text","key":"ApplicationId","operatorValue":"=","value":'#(referralCaseNo)'}]
	  When method post
	 
	  Then status 200
	  * def hearingId = response.data[0].hearingId
	  * def taskId = response.data[0].taskId
	  * def hearingTypeId = response.data[0].hearingTypeId
	  
	  And match response.data[0].applicationStatus == applicationStatus
	  
	  
	  
	  
@SecOfficeLevel1Search
Scenario: SecOfficeLevel1Search	 
	 Given path '/internalapi/api/SoDashboardSecLevel/GetDisciplinaryItemQueue'
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

@HearingAssignALJ
Scenario: HearingAssignALJ
     		  
	Given path '/internalapi/api/HearingInfo/AssignAlj'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      
   	 And request {"aljId":1069,"hearingId":'#(parseInt(hearingId))',"taskId":'#(parseInt(taskId))'}
   	 When method post
	 
	  Then status 200
	  * match response == 'true'	

	  
@ATAPHearingConclude
Scenario: ATAPHearingConclude
   Given path '/internalapi/api/HearingInfo/SavePostHearing'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      
	  * def payloadwithBothTrue = {"isConcluded":true,"suppDocRequired":true,"suppDocDueDate":'#(date)',"aljNote":"ATAP Conclude Hearing by Automation","hearingid":'#(parseInt(hearingId))',"taskId":6510,"taskDecision":1,"submit":true}
	 						
	  * def payloadwithConcludeHearingFalse = {"isConcluded":false,"suppDocRequired":"","suppDocDueDate":"","aljNote":"No-ATAP Conclude Hearing by Automation","hearingid":'#(parseInt(hearingId))',"taskId":6510,"taskDecision":3,"submit":true}
	   * def payloadwithConcludeHearingTrueSupportDocFalse = {"isConcluded":true,"suppDocRequired":false,"suppDocDueDate":"","aljNote":"Yes ATAP Conclude Hearing- no Support Doc","hearingid":'#(parseInt(hearingId))',"taskId":6510,"taskDecision":2,"submit":true}
	 
	  * eval if( ConcludeHearing == true && suppDocRequired == true) payload = payloadwithBothTrue
	  * eval if( ConcludeHearing == true && suppDocRequired == false) payload = payloadwithConcludeHearingTrueSupportDocFalse 
	  * eval if( ConcludeHearing == false) payload = payloadwithConcludeHearingFalse 
   	 And request payload
   	 When method post
	 
	  Then status 200
	  * match response == 'true'	  
	  
	   * def wait = waitFunc(30)
	  
@HearingConclude
Scenario: HearingConclude
   Given path '/internalapi/api/HearingInfo/SavePostHearing'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      
	  * def payloadwithBothTrue = {"isConcluded":true,"suppDocRequired":true,"suppDocDueDate":'#(date)',"aljNote":"Conclude Hearing by Automation","hearingid":'#(parseInt(hearingId))',"taskId":'#(taskId)',"taskDecision":1,"submit":true}
	 						
	  * def payloadwithConcludeHearingFalse = {"isConcluded":false,"suppDocRequired":"","suppDocDueDate":"","aljNote":"No-Conclude Hearing by Automation","hearingid":'#(parseInt(hearingId))',"taskId":'#(taskId)',"taskDecision":3,"submit":true}
	  
	   * def payloadwithConcludeHearingTrueSupportDocFalse = {"isConcluded":true,"suppDocRequired":false,"suppDocDueDate":"","aljNote":"Yes Conclude Hearing- no Support Doc","hearingid":'#(parseInt(hearingId))',"taskId":'#(taskId)',"taskDecision":2,"submit":true}
	 
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
	  

@CounselGenericSearch
Scenario: CounselGenericSearch	  
	  Given path '/internalapi/api/CounselSearch/GenericSearch'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
     
   	 And request {"applicationId":'#(ApplicationId)',"legalName":"","dBA":"","caseNo":"","licensePermitId":""}
	  When method post
	 
	  Then status 200
	  
	  * def caseNumber = response[0].caseApplicationId
	  
	  
@InitiateAppHearing
Scenario: InitiateAppHearing	  
	  Given path '/internalapi/api/CounselApp/InitiateAppHearing/'+caseNumber
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
     
   	 And request {}
	  When method GET
	 
	  Then status 200
	  And match response == 'true' 
	  
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
     And request {"hearingid":'#(parseInt(hearingId))',"taskId":6529}
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
	  
	  

@IntakeATAP
Scenario: IntakeATAP 
	 Given path '/internalapi/api/document/UploadDocument'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
     And request {"documentDesc":"Test Doc.docx","acaType":"Atap","bureau":"Atap","documentType":{"key":4,"value":"30 AND LATE LETTER","description":null,"documentSubCategory":""},"documentCategory":null,"receivedDate":'#(receivedDate)',"createdDate":'#(date)',"documentBase64":"data:application/vnd.openxmlformats-officedocument.wordprocessingml.document;base64,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","contentType":"application/vnd.openxmlformats-officedocument.wordprocessingml.document","fileName":"Test Doc.docx","tempGuid":"a49b8233-3c6a-7ed0-264b-6bb1286845e0"}
     
      When method post
	  Then status 200
	  And print response
	  * match response == 'true'	  
	  
	  
	  * def getDate =
	    """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat('yyyyMMddHHmmss');
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		"""
	* def autoProviderName = 'ATAPAutomation' + getDate()
	     Given path '/internalapi/api/AtapApplicationForm/Add'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
     And request {"TempGuid":null,"providerName":'#(autoProviderName)',"federalNo":"12-3453333","addressDtoObj":{"addressLine1":"59 east 4th street","addressLine2":"AutoAddress2","stateId":40,"county":"New York","city":"New York","zipCode":"10003","zip4":"1000","country":"United States (US)","stateName":"New York","countryId":229},"providerTelephoneNo":"123-456-7899","providerEmail":"automation@svam.com","personDtoObj":{"personId":"","personTypeId":"","fIrstName":"AutoDirectorFName","middleName":"A","lastName":"AutoDirectorLName","phoneNo":"2342352222","email":"griev@svam.com","createdBy":"","createdDate":"","modifiedBy":"","modifiedDate":"","isActive":""},"programType1":[true,true],"programType":["Classroom","Online"],"programName":"AutoProgram","applicationDate":'#(date)',"signature":"Yes","gridItems":[],"ProgramTypesValues":["Classroom","Online"],"tempGuid":"a49b8233-3c6a-7ed0-264b-6bb1286845e0","hasSignature":true}
     When method post
	  Then status 200
	  And print response
	  * match response != null
	  * match response != []
	  * def atapAppId = response
	  

@ATAPSubmitTaskAction
Scenario: ATAPSubmitTaskAction 
	
	     Given path '/internalapi/api/Task/SubmitTaskAction/'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
    
      
     And request {"taskId":8002,"applicationId":'#(atapAppId)',"workFlowName":"Atap","taskDecision":"2"}
     When method post
	  Then status 200
	  And print response
	  * match response == 'true'


@ATAPAddCheckAndSubmitPayment
Scenario: ATAPAddCheckAndSubmitPayment 
	
	 Given path '/internalapi/api/AtapApplicationForm/AddCheckDetails'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {"checkNumber":"1111111112","batchNumber":"32","itemNumber":"13453","receivedDate":'#(date)',"amountReceived":900,"taskDecision":1,"appAtapId":'#(parseInt(atapAppId))'}
      When method post
	  Then status 200
	  And print response
	  * match response == 'true'	  
	 Given path '/internalapi/api/AtapApplicationForm/SubmitPayment'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {"applicationId":'#(parseInt(atapAppId))',"workFlowName":"Atap","taskDecision":1,"taskId":8009}
     
      When method post
	  Then status 200
	  And print response
	  * match response == 'true'	

@ATAPAddIntakeSessionForm
Scenario: ATAPAddIntakeSessionForm
	
	 Given path '/internalapi/api/AtapSearch/SearchProvider'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      * def pdrvrName = autoProviderName + '(12-3453333)'
      And request {"providerName":'#(pdrvrName)'}
      When method post
	  Then status 200
	 * def certicateNumber = response.certificateNo
	 
	  	  
	 Given path '/internalapi/api/AtapSessionForm/AddIntakeSessionForm'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {"providerName":'#(pdrvrName)',"sessionId":"","appAtapId":'#(parseInt(atapAppId))',"addressId":"","sessionDate":'#(date)',"dayOfWeek":"2","sessionStartTime":'#(currentTime)',"sessionEndTime":'#(currentTime)',"instructorID":"","schoolId":"","isActive":"","createdBy":"","createdDate":"","modifiedBy":"","modifiedDate":"","addressDtoObj":{"addressLine1":"59 east 4th street","addressLine2":"AutoAddress2","stateId":40,"county":"New York","city":"New York","zipCode":"10003","zip4":"1000","country":"United States (US)","stateName":"New York","countryId":229,"roomNo":"11111"},"instructorDetailDtoObj":{"instructorId":"","personId":"","addressId":"","isActive":"","createdBy":"","createdDate":"","modifiedBy":"","modifiedDate":"","personDtoObj":{"personId":"","personTypeId":"","firstName":"insAutoFName","middleName":"mName","lastName":"insAutoLName","phoneNo":"123-456-7877","createdBy":"","createdDate":"","modifiedBy":"","modifiedDate":"","isActive":""},"addressDtoObj":{"addressLine1":"59 east 4th street","addressLine2":"AutoAddress2","stateId":40,"county":"New York","city":"New York","zipCode":"10003","zip4":"1000","country":"United States (US)","stateName":"New York","countryId":229,"roomNo":"11111"},"isAddressSame":true},"schoolDetailDtoObj":{"schoolId":"","officialFirstName":"SVAM","officialMiddleName":"","officialLastName":"International","officialTitle":"AutoSchoolTitle","hasOfficialSignature":true,"atapcertApprovalNo":"","isActive":"","createdBy":"","createdDate":"","modifiedBy":"","modifiedDate":""},"isAddressSame":true}
      When method post
	  Then status 200
	  And print response
	  
	  * def resVal = response
	  	

@ATAPDisciplinaryAction
Scenario: ATAPDisciplinaryAction
	
	 Given path '/internalapi/api/AtapSessionForm/DisciplinaryAction'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
       And header current-wfroleid = '30'
      
      And request {"caseNotes":"ATAP Notes For notification","ccDirector":true,"applicationTaskDetailsDtoObj":{"applicationId":'#(parseInt(resVal))',"taskDecision":3,"taskId":8203,"workFlowName":"AtapSession"}}
      When method post
	  Then status 200
	  * match response == 'true'


@GetCounselAttorneyQueueByApplicationNumber
Scenario: GetCounselAttorneyQueueByApplicationNumber
   
  
   Given path '/internalapi/api/CounselDashboard/GetCounselAttorneyQueue'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	 
      And header Accept = 'application/json; text/plain;*/*'
      
     
      * def stringParam = "(referralCaseApplicationNo~contains~'" + ApplicationId + "')"
       And params  {filter:'#(stringParam)',page:1,pageSize:10}
   And request {}
	  When method get
		Then status 200
	    And def referralCaseNo = response.data[0].referralCaseApplicationNo
	  And print referralCaseNo
	  And def caseNumber = response.data[0].referralCaseApplicationId
	  And print caseNumber
	  
	   And def appId = response.data[0].appId
	  And print appId
	   And def wfRoleId = response.data[0].wfRoleId
	  And print wfRoleId
	   And def taskId = response.data[0].taskId
	  And print taskId
	  * match response.data[0].taskStatus == taskStatus
	  

@GetCounselAttorneyQueueAndAssignToUser
Scenario: GetCounselAttorneyQueueAndAssignToUser
   
  
   Given path '/internalapi/api/CounselDashboard/GetCounselAttorneyQueue'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	 
      And header Accept = 'application/json; text/plain;*/*'
      * def stringParam = "(source~contains~'ATAP'~and~legalName~contains~'" + autoProviderName + "')"
       And params  {filter:'#(stringParam)',page:1,pageSize:10}
   And request {}
	  When method get
		Then status 200
	    And def referralCaseNo = response.data[0].referralCaseApplicationNo
	  And print referralCaseNo
	  And def caseNumber = response.data[0].referralCaseApplicationId
	  And print caseNumber
	   And def atapSessionId = response.data[0].atapSessionId
	  And print atapSessionId
	   And def lpApplicationId = response.data[0].lpapplicationId
	  And print lpApplicationId
	   And def appId = response.data[0].appId
	  And print appId
	   And def wfRoleId = response.data[0].wfRoleId
	  And print wfRoleId
	   And def taskId = response.data[0].taskId
	  And print taskId
	 
	  Given path '/internalapi/api/CounselAssignment/AssignToUser'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {"assignedUserId":1069,"currentRoleId":10012,"type":"Case","id":'#(parseInt(caseNumber))',"currentWfRoleId":32}
      When method post
	  Then status 200
	  * match response == 'true'	  
	
@CounselAssignToUserApplicationType
Scenario: CounselAssignToUserApplicationType	
	 Given path '/internalapi/api/CounselAssignment/AssignToUser'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {"assignedUserId":1069,"currentRoleId":10012,"type":"Application","id":'#(parseInt(caseNumber))',"currentWfRoleId":33}
      When method post
	  Then status 200
	  * match response == 'true'
	
@CounselAssignToUser
Scenario: CounselAssignToUser	
	 Given path '/internalapi/api/CounselAssignment/AssignToUser'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {"assignedUserId":1069,"currentRoleId":10012,"type":"Case","id":'#(parseInt(caseNumber))',"currentWfRoleId":33}
      When method post
	  Then status 200
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
      * def chargeid = 109
      * def isLicenseePresent = true
       * eval if( chargeReport == 'Default') chargeid = 58
       
       * eval if( chargeReport == 'Default') isLicenseePresent = false
     * def payload = {"charges":[{"chargeId":'#(parseInt(chargeid))',"caseId":'#(parseInt(caseNumber))',"chargeTypeId":null,"chargeTypeValue":"DISORDERLY PREMISES - MINGLING","chargeDate":'#(conditionDefinedDate)',"description":"That on or about [insert date], in violation of subdivision 6 of section 106 of the Alcoholic Beverage Control Law, the licensee suffered or permitted the licensed premises to become disorderly, to wit: mingling.","chargeOrderNo":1,"isSummarySuspension":null,"chargeStatusId":"201","chargeStatusValue":null,"hasSavedAsDraft":null,"isWithdrawn":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null,"ChargeStatus":"Sustained","ChargeStatusValue":"Sustained"}],"reportId":0,"taskId":6529,"caseId":'#(parseInt(caseNumber))',"hearingId":'#(parseInt(hearingId))',"reportTypeId":"207","isLicenseePresent":'#(isLicenseePresent)',"hbComments":null}
     	 * def payload500FT = {"charges":[],"reportId":0,"taskId":6529,"caseId":null,"hearingId":'#(parseInt(hearingId))',"reportTypeId":'211',"isLicenseePresent":true,"hbComments":null}
     	 * def payloadDisapproved = {"charges":[],"reportId":0,"taskId":6529,"caseId":null,"hearingId":'#(parseInt(hearingId))',"reportTypeId":'209',"isLicenseePresent":true,"hbComments":null}
     	 
     	 * def payload500FTDefault = {"charges":[],"reportId":0,"taskId":6529,"caseId":null,"hearingId":'#(parseInt(hearingId))',"reportTypeId":'212',"isLicenseePresent":true,"hbComments":null}
		* eval if( chargeReport == '500FT') payload = payload500FT
		* eval if( chargeReport == 'Disapproved') payload = payloadDisapproved
		* eval if( chargeReport == '500FTDefault') payload = payload500FTDefault
		And request payload
     
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

	    	  
	  
@ValidateHearingComments
Scenario: ValidateHearingComments
 Given path '/internalapi/api/HearingInfo/GetHearingHistory/'+hearingId
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
     
   	 And request {}
	  When method get
	 
	  Then status 200
	  * def data = karate.jsonPath(response, "$[?(@.note == '#(hearingComments)')]")
	 
	 And print data
	 #* match data.length >= 1 



@SubmitHearingBureauReportForAddtionalInfo
Scenario: SubmitHearingBureauReportForAddtionalInfo 
	 Given path '/internalapi/api/HbReview/SubmitHbReviewReport'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
     And request {"hearingId":'#(parseInt(hearingId))',"taskId":6531,"caseId":'#(parseInt(caseNumber))',"taskDecision":"1","hbComments":"Additional Info For Decision Clarification"}
      When method post
	  Then status 200
	  And print response
	  * match response == 'true'	 
	   * call read('HearingCommonMethods.feature@GetHearingALJQueue') {applicationStatus:'Request For Decision Clarification'}
	  * call read('HearingCommonMethods.feature@GetAljReportDetails') {}

@SubmitHearingBureauReportComplete
Scenario: SubmitHearingBureauReportComplete 
	 Given path '/internalapi/api/HbReview/SubmitHbReviewReport'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
     
     And request {"hearingId":'#(parseInt(hearingId))',"taskId":6531,"caseId":'#(parseInt(caseNumber))',"taskDecision":"2","hbComments":""}
      When method post
	  Then status 200
	  And print response
	  * match response == 'true'
	  
	  Given path '/internalapi/api/documents/Hearing/18/'+hearingId
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      
   	 And request {}
	  When method get
	 
	  Then status 200
	  * def acaDocId = response[0].acaDocumentId 
	  * def docId = response[0].documentId 
	  * def ecmFileNetID = response[0].ecmFileNetID 
	  * def acaId = response[0].acaId
		 * def createdDate = response[0].createdDate
		 * def createdBy = response[0].createdBy
		 * def receivedDate = response[0].receivedDate
	  
	  Given path '/internalapi/api/template/CreateNotificationByDocument'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
     And request {"id":'#(parseInt(hearingId))',"emailTemplateId":60,"acaTypeName":"Hearing","documentId":'#(parseInt(docId))',"toMailIds":['#(emailId2)'],"templateId":264}
     
      When method post
	  Then status 200
	  And print response
	  * match response == 'true'
	  
	   Given path '/internalapi/api/template/CreateNotificationByDocument'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
     And request {"id":'#(parseInt(hearingId))',"emailTemplateId":60,"acaTypeName":"Hearing","documentId":'#(parseInt(docId))',"toMailIds":['#(emailId1)'],"templateId":114}
     
      When method post
	  Then status 200
	  And print response
	  * match response == 'true'
	  
	  * def wait = waitFunc(30)	 
	   


@Submit500ftHearingBureauReportComplete
Scenario: Submit500ftHearingBureauReportComplete 
	 Given path '/internalapi/api/HbReview/SubmitHbReviewReport'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
     
     And request {"hearingId":'#(parseInt(hearingId))',"taskId":6531,"caseId":null,"taskDecision":"2","hbComments":""}
      When method post
	  Then status 200
	  And print response
	  * match response == 'true'
	  
	  Given path '/internalapi/api/documents/Hearing/18/'+hearingId
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      
   	 And request {}
	  When method get
	 
	  Then status 200
	  * def acaDocId = response[0].acaDocumentId 
	  * def docId = response[0].documentId 
	  * def ecmFileNetID = response[0].ecmFileNetID 
	  * def acaId = response[0].acaId
		 * def createdDate = response[0].createdDate
		 * def createdBy = response[0].createdBy
		 * def receivedDate = response[0].receivedDate
	  
	  
	  
	  * def wait = waitFunc(30)	 

@GetAljReportDetails
Scenario: GetAljReportDetails	   
	   Given path '/internalapi/api/HrAljReport/GetAljReportDetails/'+hearingId
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      
   	 And request {}
	  When method get
	 
	  Then status 200
	  And match response.hBcomments == 'Additional Info For Decision Clarification'
	  	 
@ResheduleAljReportDetailsWithAppId
Scenario: ResheduleAljReportDetailsWithAppId	   
	   Given path '/internalapi/api/HearingInfo/RescheduleHearing'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      
      
      And header current-wfroleid = '26'
   	 And request {"hearingDate":'#(date)',"address":{"addressLine1":"70 Elizabeth Blackwell Street","addressLine2":"","stateId":40,"county":"Ontario","city":"Geneva","zipCode":"14456","zip4":null,"country":"United States (US)","stateName":"New York","countryId":229,"roomNo":"1st Floor Conference Room"},"hearingId":'#(parseInt(hearingId))',"hearingLocationId":19,"taskId":6507,"caseId":null,"witnessDto":[]}

	 			 When method post
	 
	  Then status 200
	  And match response == 'true'
	   * def wait = waitFunc(30)
	   * call read('HearingCommonMethods.feature@GetHearingALJQueue') {applicationStatus:'#(ResheduleAljReportStatus)'}
	  
	  
	    	 
@ResheduleAljReportDetails
Scenario: ResheduleAljReportDetails	   
	   Given path '/internalapi/api/HearingInfo/RescheduleHearing'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      
      
      And header current-wfroleid = '26'
   	 And request {"hearingDate":'#(date)',"address":{"addressLine1":"70 Elizabeth Blackwell Street","addressLine2":"","stateId":40,"county":"Ontario","city":"Geneva","zipCode":"14456","zip4":null,"country":"United States (US)","stateName":"New York","countryId":229,"roomNo":"1st Floor Conference Room"},"hearingId":'#(parseInt(hearingId))',"hearingLocationId":19,"taskId":'#(parseInt(taskId))',"caseId":'#(parseInt(caseNumber))',"witnessDto":[]}

	 			 When method post
	
	  Then status 200
	  And match response == 'true'
	   * def wait = waitFunc(30)
	   * call read('HearingCommonMethods.feature@GetHearingALJQueue') {applicationStatus:'#(ResheduleAljReportStatus)'}
	   
@ReplaceAndUploadALJDocumentAndSubmitDefault
Scenario: ReplaceAndUploadALJDocumentAndSubmitDefault 

	Given path '/internalapi/api/documents/Hearing/18/'+hearingId
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      
   	 And request {}
	  When method get
	 
	  Then status 200
	  * def acaDocId = response[0].acaDocumentId 
	  * def docId = response[0].documentId 
	  * def ecmFileNetID = response[0].ecmFileNetID 
	  * def acaId = response[0].acaId
		 * def createdDate = response[0].createdDate
		 * def createdBy = response[0].createdBy
		 * def receivedDate = response[0].receivedDate

	Given path '/internalapi/api/document/Hearing/delete/'+acaDocId
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
     And request {"acaDocumentId":'#(parseInt(acaDocId))',"documentId":'#(parseInt(docId))',"ecmFileNetID":'#(parseInt(ecmFileNetID))',"fileNetId":null,"acaType":"Hearing","acaId":'#(parseInt(acaId))',"documentDesc":"AljDoc.pdf","bureau":null,"documentType":{"key":18,"value":"ALJ REPORT","description":"ALJ REPORT","documentSubCategory":"ALJ"},"documentCategory":null,"fileName":"AljDoc.pdf","contentType":"application/pdf","fileData":null,"tempGuid":null,"attachments":null,"roleId":null,"bureauId":null,"receivedDate":'#(receivedDate)',"contentLength":null,"isEmailAttachment":false,"documentBase64":null,"isEdit":true,"isDelete":true,"isAdd":true,"acaParentId":null,"userName":null,"userId":0,"currentRoleId":0,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":true,"createdBy":'#(createdBy)',"createdDate":'#(createdDate)',"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}
      When method post
	  Then status 200
	  And print response
	  * match response == 'true'

	 Given path '/internalapi/api/document/UploadDocument'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
     And request {"documentDesc":"AljDocReplace.docx","acaId":'#(parseInt(hearingId))',"acaType":"Hearing","bureau":"Hearing","documentType":{"key":18,"value":"ALJ REPORT","description":null,"documentSubCategory":"ALJ"},"documentCategory":null,"receivedDate":'#(receivedDate)',"createdDate":'#(date)',"documentBase64":"data:application/vnd.openxmlformats-officedocument.wordprocessingml.document;base64,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","contentType":"application/vnd.openxmlformats-officedocument.wordprocessingml.document","fileName":"AljDocReplace.docx","tempGuid":"6901a707-b270-26e9-959c-2bcf0dcafda3"}
      When method post
	  Then status 200
	  And print response
	  * match response == 'true'	 
	  
	   Given path '/internalapi/api/HrAljReport/SaveAljReport'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
     And request {"charges":[{"chargeId":122,"caseId":'#(parseInt(caseNumber))',"chargeTypeId":null,"chargeTypeValue":"DISORDERLY PREMISES - MINGLING","chargeDate":'#(conditionDefinedDate)',"description":"That on or about [insert date], in violation of subdivision 6 of section 106 of the Alcoholic Beverage Control Law, the licensee suffered or permitted the licensed premises to become disorderly, to wit: mingling.","chargeOrderNo":1,"isSummarySuspension":null,"chargeStatusId":"203","chargeStatusValue":null,"hasSavedAsDraft":null,"isWithdrawn":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null,"ChargeStatus":"Withdrawn","ChargeStatusValue":"Withdrawn"}],"reportId":22,"taskId":'#(parseInt(taskId))',"caseId":'#(parseInt(caseNumber))',"hearingId":'#(parseInt(hearingId))',"reportTypeId":"208","isLicenseePresent":false,"hbComments":"Additional Info For Decision Clarification"}
      
      When method post
	  Then status 200
	 
	  * match response == 'true'	

 Given path '/internalapi/api/HrAljReport/SubmitAljReport'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
     And request {"charges":[],"hearingId":'#(parseInt(hearingId))',"taskId":'#(parseInt(taskId))',"reportCanBeSubmitted":true} 
 	
 	When method post
	  Then status 200
	  And print response
	  * match response == 'true'	

	    	  
@ValidateHearingCommunicationPage
 Scenario: ValidateHearingCommunicationPage
	
	Given path '/internalapi/api/Communication/GetEmailCommQueue/Hearing/'+hearingId
	   	
	
	 	And header authorization = 'Bearer ' + strToken
	  	And header Content-Type = 'application/json; charset=utf-8'
	    And header Accept = 'application/json; text/plain;*/*'
	    And header user-agent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36'
	  	And request ""
	    When method get
	    Then status 200	    
	    
	    And def serverResponse = response
	    
	    * def serverResponseNotificationData1 = karate.jsonPath(serverResponse, "$[?(@.emailTo == '" + emailId1 + "')]")
		* match serverResponseNotificationData1[0].status == 'Sent'
		* match serverResponseNotificationData1[0].subject == 'NYS Liquor Authority Hearing Bureau Record Information'
		* match serverResponseNotificationData1[0].attachments[0].documentDesc == '#(documentDesc1)'
		* match serverResponseNotificationData1[0].attachments[1].documentDesc contains '#(documentDesc2)'
		
		* def serverResponseNotificationData2 = karate.jsonPath(serverResponse, "$[?(@.emailTo == '" + emailId2 + "')]")
		* match serverResponseNotificationData2[0].attachments[0].documentDesc == '#(documentDesc1)'
		* match serverResponseNotificationData2[0].attachments[0].documentDesc contains '#(documentDesc2)'
		* match serverResponseNotificationData2[0].status == 'Sent'
		* match serverResponseNotificationData2[0].emailTo != []
		* match serverResponseNotificationData2[0].subject == 'NYS Liquor Authority Hearing Bureau Record Information'
		

@ValidateHearingEmailTemplateCommunicationPage
 Scenario: ValidateHearingEmailTemplateCommunicationPage
	
	Given path '/internalapi/api/Communication/GetEmailCommQueue/Hearing/'+hearingId
	   	
	
	 	And header authorization = 'Bearer ' + strToken
	  	And header Content-Type = 'application/json; charset=utf-8'
	    And header Accept = 'application/json; text/plain;*/*'
	    And header user-agent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36'
	  	And request ""
	    When method get
	    Then status 200	    
	    
	    And def serverResponse = response
	    
	    * def serverResponseNotificationData1 = karate.jsonPath(serverResponse, "$[?(@.typeOfNotification == '#(typeOfNotification)')]")
		* match serverResponseNotificationData1[0].status == 'Sent'
		#* match serverResponseNotificationData1[0].subject == 'NYS Liquor Authority Hearing Bureau Record Information'

		

	  	 
@HearingSaveComments
Scenario: HearingSaveComments	   
	   Given path '/internalapi/api/comment/Hearing/save'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      
   	 And request {"acaId":'#(parseInt(hearingId))',"acaStatus":"'completed'","acatype":"Hearing","bureauId":5,"description":"Automation_HearingComment12345"}
   	When method post
	 
	  Then status 200
	 * def acacommentId = response.acacommentId
	  * def commentId = response.commentId
	  
	  * match acacommentId != null
	  * match acacommentId != 0
	  * match commentId != null
	  * match commentId != 0
	  
	  
	  Given path '/internalapi/api/comments'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      
   	 And request {"acaId":'#(parseInt(hearingId))',"acatype":"Hearing","bureauId":5}
   	When method post
	 
	  Then status 200
	* match response.isAdd == true
	
	  
@uploadHearingADJOURNMENTDocAndMoveWorkflow
Scenario: uploadHearingADJOURNMENTDocAndMoveWorkflow
 Given path '/internalapi/api/document/UploadDocument'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
     And request {"documentDesc":'#(attachedFileName)',"acaId":'#(parseInt(hearingId))',"acaType":"Hearing","bureau":"Hearing","documentType":{"key":179,"value":"REQUEST FOR ADJOURNMENT","description":null,"documentSubCategory":"REQUEST "},"documentCategory":null,"receivedDate":'#(receivedDate)',"createdDate":'#(date)',"documentBase64":"data:application/vnd.openxmlformats-officedocument.wordprocessingml.document;base64,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","contentType":"application/vnd.openxmlformats-officedocument.wordprocessingml.document","fileName":'#(attachedFileName)',"tempGuid":"c4c6ea19-8ca2-e536-3797-b3fef0524bdc"}
            
      When method post
	  Then status 200
	  And print response
	  * match response == 'true'
	  
	  Given path '/internalapi/api/HearingInfo/MoveWorkFlow'
  	  And header Content-Type = 'application/json; charset=utf-8'
     And header Accept = 'application/json; text/plain;*/*'
     And header authorization = 'Bearer ' + strToken
     And print taskId
     And request {"hearingid":'#(parseInt(hearingId))',"taskId":6509,"taskDecision":4}
      
      When method post
	  Then status 200
	  And print response
	  * match response == 'true'


@UploadDocAndSubmitApplicationPOSTHEARINGSUBMISSIONS
Scenario: UploadDocAndSubmitApplicationPOSTHEARINGSUBMISSIONS
 Given path '/internalapi/api/document/UploadDocument'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
     And request {"documentDesc":"HearingFlowDoc.docx","acaId":'#(parseInt(caseNumber))',"acaType":"Application","bureau":"WorkFlowNameEnum.counsel","documentType":{"key":164,"value":"POST HEARING SUBMISSIONS","description":null,"documentSubCategory":""},"documentCategory":null,"receivedDate":'#(receivedDate)',"createdDate":'#(date)',"documentBase64":"data:application/vnd.openxmlformats-officedocument.wordprocessingml.document;base64,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","contentType":"application/vnd.openxmlformats-officedocument.wordprocessingml.document","fileName":"HearingFlowDoc.docx","tempGuid":"3fbedce1-59d1-3495-8218-93ccdd35a895"}
      When method post
	  Then status 200
	  And print response
	  * match response == 'true'
	  
	  Given path '/internalapi/api/CounselApp/SubmitAppPostHearing'
  	  And header Content-Type = 'application/json; charset=utf-8'
     And header Accept = 'application/json; text/plain;*/*'
     And header authorization = 'Bearer ' + strToken
     And print taskId
     And request {"applicationId":'#(parseInt(caseNumber))',"taskId":7154,"taskDecision":1,"workFlowName":"Counsel"}
    
      When method post
	  Then status 200
	  And print response
	  * match response == 'true'

@UploadDocAndSubmitPOSTHEARINGSUBMISSIONS
Scenario: UploadDocAndSubmitPOSTHEARINGSUBMISSIONS
 Given path '/internalapi/api/document/UploadDocument'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
     And request {"documentDesc":"LetterofContro.docx","acaId":'#(parseInt(caseNumber))',"acaType":"Case","bureau":"WorkFlowNameEnum.counsel","documentType":{"key":164,"value":"POST HEARING SUBMISSIONS","description":null,"documentSubCategory":""},"documentCategory":null,"receivedDate":'#(receivedDate)',"createdDate":'#(date)',"documentBase64":"data:application/vnd.openxmlformats-officedocument.wordprocessingml.document;base64,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","contentType":"application/vnd.openxmlformats-officedocument.wordprocessingml.document","fileName":"LetterofContro.docx","tempGuid":"21bf5f25-96d1-deac-eb8c-e9893fcc1da3"}       
      When method post
	  Then status 200
	  And print response
	  * match response == 'true'
	  
	  Given path '/internalapi/api/CounselHearing/SubmitPostHearing'
  	  And header Content-Type = 'application/json; charset=utf-8'
     And header Accept = 'application/json; text/plain;*/*'
     And header authorization = 'Bearer ' + strToken
     And print taskId
     And request {"applicationId":'#(parseInt(caseNumber))',"taskId":7126,"taskDecision":1}
      
      When method post
	  Then status 200
	  And print response
	  * match response == 'true'



@GrantDenyHearingCaseId
Scenario: GrantDenyHearingCaseId
 
	  
	  Given path '/internalapi/api/HearingInfo/MoveWorkFlow'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      * def payload = {"taskDecision":"1","taskId":6518,"hearingid":'#(parseInt(hearingId))',"adjReqCommTypeId":"354"}
      
            
       * def payloadDeny = {"taskDecision":"2","taskId":6518,"hearingid":'#(parseInt(hearingId))',"adjReqCommTypeId":"352"}
	 
	  * eval if( grantDenyStatus == 'Deny') payload = payloadDeny
	   
   	 And request payload
     
      When method post
	  Then status 200
	  And print response
	  * match response == 'true'

@ProcessControversionLetter
Scenario: ProcessControversionLetter 

	

	 Given path '/internalapi/api/document/UploadDocument'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
     And request {"documentDesc":"LetterofContro.docx","acaId":'#(parseInt(hearingId))',"acaType":"Hearing","bureau":"Hearing","documentType":{"key":97,"value":"LETTER OF CONTROVERSION","description":null,"documentSubCategory":""},"documentCategory":null,"receivedDate":'#(receivedDate)',"createdDate":'#(date)',"documentBase64":"data:application/vnd.openxmlformats-officedocument.wordprocessingml.document;base64,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","contentType":"application/vnd.openxmlformats-officedocument.wordprocessingml.document","fileName":"LetterofContro.docx","tempGuid":"d2c71f56-df8b-8714-fc89-7d139481c38e"}
      
      When method post
	  Then status 200
	  And print response
	  * match response == 'true'	 
	  
	   Given path '/internalapi/api/HearingInfo/ProcessControversionLetter'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
     And request {"hearingid":'#(parseInt(hearingId))',"taskId":6523,"taskDecision":100}
      
      When method post
	  Then status 200
	 
	  * match response == 'true'	
	  
	 

@GetAndValidateUploadedHearingDocument
Scenario: GetAndValidateUploadedHearingDocument 

	Given path '/internalapi/api/documents/Hearing/179/'+hearingId
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      
   	 And request {}
	  When method get
	 
	  Then status 200
	  * def acaDocId = response[0].acaDocumentId 
	  * def docId = response[0].documentId 
	 Given path '/internalapi/api/document/downloaddocument/'+acaDocId
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      
   	 And request {}
	  When method get
	 
	  Then status 200
	  * def FileName = response.fileName 
	  * match FileName == attachedFileName

@HearingViewDownloadDoc
Scenario: HearingViewDownloadDoc 

Given path 'internalapi/api/documents/GetDocuments'
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      
      And request {"type":"Hearing","id":'#(hearingId)',"subCategory":""}
      When method post
	  Then status 200
	  And print response
	  * def acaDocumentId = response[0].acaDocumentId
	  	  
 Given path '/internalapi/api/document/Hearing/download/'+acaDocumentId
    And header authorization = 'Bearer ' + strToken
    And request ""
    When method get
    Then status 200
	#* def responseData = db.readresponse(response)
	#And print responseData
	* def responseData = db.convertByteArrayToDoc(response,actualFilePath)
    And match header Content-Disposition contains 'attachment'
    And match header Content-Type == 'application/pdf'


@Hearing500FTLicenseIntake
Scenario: Hearing500FTLicenseIntake
Given path '/internalapi/api/licensing/selectapptype/savenewlicenseapp'
	  * def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
     
   	 And request {"mainLicensePermitTypeId":238,"newPermitTypeIds":[],"combinedCraftId":null,"masterFileId":null,"isApplicableForTempPermit":false,"isNotQualified":false,"isChainRestaurant":false,"addBarList":[],"countyId":31,"isApplicantCurrentLicensed":false,"isExistingManufacturer":false,"selectedLicense":null}
	  When method post
	  * configure continueOnStepFailure = true
	  Then status 200
	   
	   And def ApplicationId = response[0].mainApplicationId
	  And print ApplicationId
	  And match ApplicationId contains 'NA-'
	  
	  * def currentYear = '-'+getYearFunc()+'-'+3
	  And match ApplicationId contains currentYear
	  And def description = response[0].description
	 
	   And def appId = response[0].appId
	  
	   * def formId = response[0].formId
	   * def FormVersionId = response[0].FormVersionId
 Given path '/internalapi/api/licensing/app/1165/'+appId
   	* def dbSts = db.cleanHeap()
      And header authorization = 'Bearer ' + strToken
  	  And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json; text/plain;*/*'
      And configure continueOnStepFailure = true
   	 And request {}
	  When method get
	  * configure continueOnStepFailure = true
	  Then status 200
	   
	    And def lpStatus = response.form.statusDescription
	   And print lpStatus
	  And match lpStatus == 'Draft'
	  
	 
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
  	  	
		* def autoFirstName = 'AutomationFT500' + getDate()
		* def legalName = autoFirstName + 'ForHearing'
		And header Accept = 'application/json; text/plain;*/*'
       	And header authorization = 'Bearer ' + strToken
      	And request {"businessInfo":{"website":null,"businessEntity":{"individualOrganization":"2","corporateStructure":3,"firstName":"","lastName":"","middleName":"","suffix":"","ssn":"","fein":"23-2322322","legalName":'#(legalName)',"id":0,"isEmployeeForSoleProprietor":null,"individualOrganizationText":null,"corporateStructureText":null,"isIndividual":false},"address":{"addressId":0,"appId":null,"addressLine1":"A1","addressLine2":"A2","city":"New York","stateId":40,"county":"New York","zipCode":"10000","zip4":"1111","street":null,"telephoneNumber":null,"country":"United States (US)","addressTypeId":null,"location":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null,"isActive":null,"showAndHide":null,"roomNo":null,"stateName":"New York","countryId":229,"serialNo":0,"addressType":null,"state":null},"communication":{"email":"automation@svam.com","confirmEmail":"automation@svam.com","phones":[],"id":0},"id":0,"isLicensed":false,"isAssociated":false},"premisesInfo":{"dba":null,"licensePermitID":null,"address":{"addressId":0,"appId":null,"addressLine1":"a1","addressLine2":"a2","city":"New York","stateId":40,"county":"Cattaraugus","zipCode":"11111","zip4":"1111","street":null,"telephoneNumber":null,"country":"United States (US)","addressTypeId":null,"location":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null,"isActive":null,"showAndHide":null,"roomNo":null,"stateName":"New York","countryId":229,"serialNo":0,"addressType":null,"state":null},"communication":{"email":null,"confirmEmail":null,"phones":[],"id":0},"id":0,"isDbaSearched":null},"applicantDetail":{"masterFileID":null,"mfExpDate":null,"certificateNysTax":null,"certIssueDate":null,"applicantStatement":{"nameOfApplicant":null,"date":null,"title":null,"signature":null,"id":0},"id":0,"isPhysicalChange":null},"isFormInvalid":false}
      	When method post
	  	Then status 200
	  	
	  Given path '/internalapi/api/licensing/app/static/principal/save/'+appId
      	And header Content-Type = 'application/json; charset=utf-8'
  	  	
		* def autoFirstName = 'AutomationFT500' + getDate()
		
		And header Accept = 'application/json; text/plain;*/*'
       	And header authorization = 'Bearer ' + strToken
      	And request {"entities":[],"principals":[{"principalId":0,"convictedOfCrime":"","percentageOfOwners":"","isFingerprintRequired":true,"isFingerprintsApproved":true,"title":"15","dcjsFingerPrintStatus":"","numberOfShares":"","isSignature":false,"date":"","address":{"addressLine1":"A1","addressLine2":"A2","stateId":40,"county":"New York","city":"New York","zipCode":"10003","zip4":"1111","country":"United States (US)","stateName":"New York","countryId":229,"zip":"10003"},"person":{"personId":0,"firstName":'#(autoFirstName)',"middleName":"","lastName":"ForHearing","suffix":"","socialSecurityNo":"","birthDate":"","age":"","choosedEntity":null,"ssnFormat":""},"isIndividualsPartnersAssociatedWithEntity":"","communication":{"id":0,"phones":[],"email":null,"confirmEmail":null},"titleText":"Vice President","disableFlags":"{\"isExisitingPrincipal\":false,\"isExistingPrincipalInBusiness\":false,\"isRenewalAndAmendPrincipal\":false,\"isNewPrincipal\":true}","isAssociated":false}]}
      	When method post
	  	Then status 200
	  	* def licenseFees = 1792
	  	* def renewalFees = 100
	  	* def termInYears = 2
	  	* def termDesc = '2 Year (s)'
	  * call read('LicensesCommonMethods.feature@FeesValidation') {amount:1992}
	  	 * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Schedule 500 Foot Hearing'}
     * def hearingLocationId = 19
     
       * call read('LicensesCommonMethods.feature@SubmitSchedule500HearingWithYesoption') {}
       
       
       
       
@HearingCreateLic  
 Scenario Outline: HearingCreateLic
   * def licKeywordName = 'Automation'	
	# ********* Login Functionality *********************
  		
  		
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
        * call read('LicensesCommonMethods.feature@WaveFeesValidation') {amount:'#(totalFees)'}
       
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
    
  
  
  
  
@HearingDisapproveLic
 Scenario Outline: HearingdisapproveLic
   * def licKeywordName = 'Automation'	
	# ********* Login Functionality *********************
  		
  		
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
        * call read('LicensesCommonMethods.feature@FeesValidation') {amount:'#(totalFees)'}
        
        * call read('LicensesCommonMethods.feature@WaveFeesValidation') {}
       
        * call read('LicensesCommonMethods.feature@SubmitLicenseAndValidateLicStatus') {expStatus:'Awaiting Review'}
	   	
	  * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'IntakeComplete'}
		* call read('LicensesCommonMethods.feature@AssignApplicationsToExaminer') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ExaminerReviewApprovalToLB') {expStatus:'Awaiting Review'}
	    * call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Under Review'}
	    * call read('LicensesCommonMethods.feature@AddLicenseClaimingQueue') {}
	    * def DisapprovalForCause = true
	    * def lbStatus = 'Disapproved'
	    * def lbDropDownVal = 2
		* call read('LicensesCommonMethods.feature@DisapproveLB') {}
		* call read('LicensesCommonMethods.feature@ValidateLicenseApplicationStatus') {LicAppStatus:'Disapproved'}
		
		* def referralCaseNo = ApplicationId
	   
 Examples:
    | read('/CSVFiles/RenewalOnPremises.csv') |    
    
      
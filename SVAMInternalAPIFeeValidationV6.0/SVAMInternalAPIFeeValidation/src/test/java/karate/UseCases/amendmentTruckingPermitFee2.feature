Feature: amendment  Removal fee validation

Background:
			* url BaseURL
  		* def config = { username: '#(dbUserName)', password:'#(dbUserPassword)', url: '#(dbQuery)',driverClassName: 'com.microsoft.sqlserver.jdbc.SQLServerDriver' }
    	* def DbUtils = Java.type('utils.DbUtils')
    	* def db = new DbUtils(config)
          
    	* def getcorporateStructureCodeFunc =
				"""
				function(value){
					if (value === 'Individual'){
					return 1;
					}
					else {
					return 2;
					}
			    }
			"""
		* def getStatusIndOrgStatus =
			"""
				function(value){
					if (value === 'Individual'){
					return true;
					}
					else {
					return false;
					}
			    }
			"""
		* def getIndORgCodeFunc =
			"""
				function(value1, value2){
					if (value1 == 1 && value2 == 'Individual'){
					return 1;
					}
					else if (value1 == 1 && value2 == 'Sole Propretior'){
					return 2;
					}
					else if (value1 == 2 && value2 == 'Individual'){
					return 1;
					}
					else if (value1 == 2 && value2 == 'Limited Liability Company'){
					return 2;
					}else if (value1 == 2 && value2 == 'Corporation'){
					return 3;
					}else if (value1 == 2 && value2 == 'Limited Liability Partnership'){
					return 4;
					}else if (value1 == 2 && value2 == 'Limited Partnership'){
					return 5;
					}else if (value1 == 2 && value2 == 'Partnership'){
					return 6;
					}else if (value1 == 2 && value2 == 'Government'){
					return 7;
					}else if (value1 == 2 && value2 == 'Sole Propretior'){
					return 8;
					}else if (value1 == 2 && value2 == 'Trust'){
					return 9;
					}else if (value1 == 2 && value2 == 'Estate'){
					return 10;
					}
					
					else {
					return 1;
					}
			    }
			    """

    	
    	* def getDate =
	    """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat('yyyyMMddHHmmss');
		    var date = new java.util.Date();
		    return sdf.format(date);
		  } 
		"""
					
		* def getExpiryDateFunc =
		"""
          function(termsInyears) {
          java.lang.System.out.print("termsInyears"+termsInyears);
          var today = new java.util.Date(); 
             var calendar = java.util.Calendar.getInstance();  
          calendar.setTime(today);  
          calendar.add(java.util.Calendar.MONTH, 1);  
          calendar.set(java.util.Calendar.DAY_OF_MONTH, 1);  
          calendar.add(java.util.Calendar.DATE, -1);  
          var lastDayOfMonth = calendar.getTime();  
          var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
          var sdf = new SimpleDateFormat("yyyy-MM-dd");  
          var dayAfter = new java.util.Date(lastDayOfMonth + java.util.concurrent.TimeUnit.DAYS.toMillis( 30));
          return sdf.format(dayAfter);
          } 
          """	
          					
  	  * def getExpiryMonth =
		  """
		  function() {
		    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
		    var sdf = new SimpleDateFormat("MM");
		    
		    var date = new java.util.Date();
		    var dayAfter = new java.util.Date(date.getTime() + java.util.concurrent.TimeUnit.DAYS.toMillis( 30 ));
		    return sdf.format(dayAfter);
		  } 
		  """	
       * def EffDate =
			"""
			  function() {
			    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
			    var sdf = new SimpleDateFormat("yyyy-MM-dd");
			    var date = new java.util.Date();
			    return sdf.format(date);
			  } 
		  """
		         * def EffMonth =
			"""
			  function() {
			    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
			    var sdf = new SimpleDateFormat("MM");
			    var date = new java.util.Date();
			    return sdf.format(date);
			  } 
		  """
		* def expectedEffDate =
			"""
			  function() {
			    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
			    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'00:00:00");
			    var date = new java.util.Date();
			    return sdf.format(date);
			  } 
		  
		  
		"""	
Scenario Outline: Get Fees Details Validation

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
	    #* def legalName = firstName+ ' '+lastName
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
	    * def LicenseDescription = <LicDescription>
	    * def convictedOfCrime = <convictedOfCrime>
		* def PhoneNumber = <PhoneNumber>
		* def PhoneExtn = <PhoneExtn>
		* def countryCode = <countryCode>
		* def stateCode = <StateCode>	
	  	* def mainLicensePermitTypeId = <LicensePermitTypeId>
	    * def termInYears = <NumberOfTerm>
	    * def expiryDate = getExpiryDateFunc(termInYears);
	      And print expiryDate
	    * def termDesc = <NumberOfTerm>+' Year (s)'
	    * def licenseFees = <InitialLicFee>
	    * def fillingFees = <NonRefundableFilingFees>
	    * def renewalFees = <RenewalFilingFees>+''
        * def AncillaryPrice = <AncillaryFees>	
        * def totalFees = licenseFees  + fillingFees + AncillaryPrice     
	    * def CountyId = <countyIds>	
* callonce read('LoginDetails.feature') { strToken:'#(strToken)'}
 
	Given path 'internalapi/api/licensing/selectapptype/savenewpermitapp'
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

     * def totalFees = licenseFees  + fillingFees
     And print totalFees	
   				   And request {"businessType":"","permitType":"Standalone Permit","mainLicenseId":null,"tempPermitTypeId":[],"mainApplicationId":"","associatedLicenseList":[],"isMainTempPermitRequired":false,"newPermitTypeIds":[{"permitTypeId":410}],"isNotQualified":false,"notQualifiedReason":""}
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
  	  # * string CitysName = <CityName>
       #  And print CitysName
	  * def legalName = temp + 'License'

      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {"businessInfo":{"website":null,"businessEntity":{"individualOrganization":"1","corporateStructure":"1","firstName":'#(temp)',"lastName":"License","middleName":"","suffix":null,"ssn":"","fein":"","legalName":'#(legalName)',"id":0,"isEmployeeForSoleProprietor":null,"individualOrganizationText":null,"corporateStructureText":null,"isIndividual":false},"address":{"addressId":0,"appId":null,"addressLine1":null,"addressLine2":null,"city":null,"stateId":40,"county":null,"zipCode":null,"zip4":null,"street":null,"telephoneNumber":null,"country":"United States (US)","addressTypeId":null,"location":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null,"isActive":null,"showAndHide":null,"roomNo":null,"stateName":"New York","countryId":229,"serialNo":0,"addressType":null,"state":null},"communication":{"email":"automation@test.com","confirmEmail":"automation@test.com","phones":[],"id":0},"id":0,"isLicensed":false,"isAssociated":false},"premisesInfo":{"dba":null,"licensePermitID":null,"address":{"addressId":0,"appId":null,"addressLine1":"Test","addressLine2":null,"city":"Yonkers","stateId":40,"county":"Columbia","zipCode":"11111","zip4":"1111","street":null,"telephoneNumber":null,"country":"United States (US)","addressTypeId":null,"location":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null,"isActive":null,"showAndHide":null,"roomNo":null,"stateName":"New York","countryId":229,"serialNo":0,"addressType":null,"state":null},"communication":{"email":null,"confirmEmail":null,"phones":[],"id":0},"id":0},"applicantDetail":{"masterFileID":null,"mfExpDate":null,"certificateNysTax":null,"certIssueDate":null,"applicantStatement":{"nameOfApplicant":null,"date":null,"title":null,"signature":null,"id":0},"id":0,"isPhysicalChange":null}}
	  When method post
	  Then status 200

   Given path 'internalapi/api/licensing/app/static/principal/save/'+appId
      
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
  	  # * string CitysName = <CityName>
       #  And print CitysName
	  * def legalName = temp + 'License'

      And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {"entities":[],"principals":[{"principalId":0,"convictedOfCrime":"","percentageOfOwners":"","isFingerprintRequired":"","isFingerprintsApproved":"","title":"","numberOfShares":"","isSignature":"","date":"","address":{"addressLine1":"","addressLine2":"","stateId":40,"county":"","city":"","zipCode":"","zip4":"","country":"United States (US)","stateName":"New York","countryId":229,"zip":""},"person":{"personId":0,"firstName":"test","middleName":"","lastName":"tsgsd","suffix":"","socialSecurityNo":"","birthDate":"","age":"","choosedEntity":null,"ssnFormat":""},"isIndividualsPartnersAssociatedWithEntity":"","communication":{"id":0,"phones":[],"email":null,"confirmEmail":null},"disableFlags":"{\"isExisitingPrincipal\":false,\"isExistingPrincipalInBusiness\":false,\"isRenewalAndAmendPrincipal\":false,\"isNewPrincipal\":true}","isAssociated":false}]}
	  When method post
	  Then status 200
	  
     Given path '/internalapi/api/licensing/app/static/vehicledetails/save/'+appId
	       And header Accept = 'application/json; text/plain;*/*'
      And header authorization = 'Bearer ' + strToken
      And request {"vehicleDetails":[{"id":0,"vehicleType":"dsxZ","vehicleModel":null,"vehicleMake":"ewqdas","vehicleVIN":"22222222222222222","vehicleYear":"2019","vehicleNameOwner":"fasx","vehicleRegName":null,"isNew":true,"isRemoved":false},{"id":0,"vehicleType":"dqwsx","vehicleModel":null,"vehicleMake":"e2","vehicleVIN":"22222222222222222","vehicleYear":"2021","vehicleNameOwner":"dSx","vehicleRegName":null,"isNew":true,"isRemoved":false}]}
	  When method post
	  Then status 200
	 

# ********* SAVE Application Details To Save *********************
   
    Given path '/internalapi/api/licensing/fees/licenses/get/'+appId
          And header authorization = 'Bearer ' + strToken
          And header Content-Type = 'application/json; charset=utf-8'
   			  And header Accept = 'application/json; text/plain;*/*'
  			  And request ""
			    When method get
			    Then status 200
			     
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
	  And request {"checks":[],"appFees":{"appFees":[{"licenseName":"Trucking (individual vehicle)","applicationId":'#(ApplicationId)',"applicationTypeId":1,"appFeesId":0,"appId":'#(appId)',"feesRefId":7158,"initialFees":0,"licensingFees":"153.00","amendmentFees":"0.00","renewalFees":"0.00","totalFees":"173.00","filingFees":"20.00","ancillaryFees":"0.00","isFeesWaived":true,"underPaymentAmount":173,"amountReceived":0,"waivedComment":"test","isBondReceived":false,"isBondRequired":true,"bondFee":1000,"term":3,"termDesc":"3 Year (s)","seasonalStartDate":null,"seasonalEndDate":null,"isFeesCountBased":false,"isFeesUnitBased":false,"numOfUnits":0,"paymentDetails":[],"lateFee":0,"isFeesBarPerDay":null}],"isFromReturnedCheck":false,"isBondRequired":false,"bondDetails":null,"isPaymentFailed":false,"isUnderpaid":false,"sendNotification":false,"fundDueDate":'#(date)',"emailNotificationDetail":{"applicant":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":8057,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)'}},"notificationDetails":{"applicant":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"isInstantEmail":false,"appId":'#(appId)'},"taskId":null}
	  When method post
	  Then status 200 
	  
	   Given path 'internalapi/api/licensing/app/submit'
    And header authorization = 'Bearer ' + strToken
    And request {"appId":'#(appId)',"wfType":null}
    When method post
    Then status 200
  
     # ********* AssignApplicationsToExaminer *********************
    Given path '/internalapi/api/licensing/examiner/assignApplicationsToExaminer'
    
    And header authorization = 'Bearer ' + strToken
    And request [{"appId":'#(appId)',"examinerId":1069,"priority":"Normal"}]
    When method post
    And def serverResponse = response
   
 # ********* Examiner Review Approval to LB ********************* 

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
    #And header authorization = 'Bearer ' + strTokenRole
    And header authorization = 'Bearer ' + strToken
    And header current-wfroleid = 4
    And request {"isFingerPrintsApproved":true,"isFingerPrintsRequired":false,"isCorpLLCDissolved":false,"isCorpLLCDTaken":false,"isSendPDLetter":false,"isDisable500LB_FBPT":false,"isDisableLBForPD":false,"isDisableLBForCaseClosed":false,"isDisableLateRenewalAndUnderpayment":false,"isLiquidatorPermitHasCompleted":-1,"isSubmit":true,"fieldDeficiencies":[],"masterFileData":[],"combinedCraftData":[],"application":{"applicationCategory":6,"appId":'#(appId)',"applicationId":'#(ApplicationId)',"licePermitTypeId":null,"applicationTypeId":1,"formVersionId":1540,"formId":1124,"legalName":'#(legalName)',"submitDate":'#(formatedSumbitDate)',"isGISRequired":null,"licenseDescription":"Trucking (individual vehicle)","recommendedDecisionId":null,"status500":null,"isApplicableForPDLetter":false,"countyName":"Albany","priority":"Normal","expirationDate":null,"appStatusId":3,"taskStatus":"Awaiting Review","taskId":1526,"currentWfstatus":null,"communityBoard":null,"isLicenseApplication":false,"currentDueDate":null,"isFinalDeficiency":null,"isHighlyDeficient":false,"isAllDeficienciesMet":null,"pastDueDate":null,"memo":null,"isOneTimePermit":null,"dueDateAction":null,"isDisapprovedForCause":false,"isNotQualified":false,"eventDate":null,"appStatus":{"appStatusId":3,"statusDescription":"Under Review","isActive":true,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"applicationType":null,"assignAppExaminer":{"appExaminerId":3030,"appId":'#(appId)',"examinerId":1069,"name":null,"assignDate":'#(formatedSumbitDate)',"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"assignAppToLB":null,"licePermitType":{"licPermitTypeId":410,"type":"2","category":"6","product":"","class":null,"description":null,"sectionOfLaw":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null,"isTempPermit":false,"isELicensingPermit":true,"isAdditionalBar":false},"assoApplicationList":[],"isTempPermit":null,"isTempOrLiq":false,"licPermitTypeId":410,"isAssociatedLicense":null,"effectiveDate":null,"assignedUserId":null,"amendmentTypeId":null,"amendmentType":null,"disapprovedDate":null,"condApprovedDate":null,"addressId":null,"isCaseOpen":null,"isClosed":null,"isCaseOpenSameAddress":null,"isSpecialEventPlusFour":null,"isSpecialEventInsideFiveBoroughs":null,"licStatus":null,"createdBy":null,"licenseId":null,"address":null,"isNybeApp":false,"isHearingCompleted":null,"does500FtHearingExist":null,"parentAppStatus":3,"premisesAppCount":0,"statusDescription":null,"eventAddress":null,"isFairOrFestival":false,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskRoleId":0,"taskDecision":null,"isActive":true,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":'#(formatedSumbitDate)'},"appId":'#(appId)',"notificationTypeId":2028,"applicationType":1,"decisionType":{"name":"Send to Licensing Board","value":2},"emailNotificationModel":{"applicant":{},"attorney":{},"communityBoard":{},"other":{}},"hasErrors":[],"taskId":1526,"newComments":"","recommendedDecisionId":null}
               # {"isFingerPrintsApproved":true,"isFingerPrintsRequired":false,"isCorpLLCDissolved":false,"isCorpLLCDTaken":false,"isSendPDLetter":false,"isDisable500LB_FBPT":false,"isDisableLBForPD":false,"isDisableLBForCaseClosed":false,"isDisableLateRenewalAndUnderpayment":false,"isLiquidatorPermitHasCompleted":-1,"isSubmit":true,"fieldDeficiencies":[],"masterFileData":[],"combinedCraftData":[],"application":{"applicationCategory":6,"appId":8059,"applicationId":"NA-0553-22-07368","licePermitTypeId":null,"applicationTypeId":1,"formVersionId":1540,"formId":1124,"legalName":"tets fds","submitDate":"2022-07-28T13:42:49.79","isGISRequired":null,"licenseDescription":"Trucking (individual vehicle)","recommendedDecisionId":null,"status500":null,"isApplicableForPDLetter":false,"countyName":"Albany","priority":"Normal","expirationDate":null,"appStatusId":3,"taskStatus":"Awaiting Review","taskId":1526,"currentWfstatus":null,"communityBoard":null,"isLicenseApplication":false,"currentDueDate":null,"isFinalDeficiency":null,"isHighlyDeficient":false,"isAllDeficienciesMet":null,"pastDueDate":null,"memo":null,"isOneTimePermit":null,"dueDateAction":null,"isDisapprovedForCause":false,"isNotQualified":false,"eventDate":null,"appStatus":{"appStatusId":3,"statusDescription":"Under Review","isActive":true,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"applicationType":null,"assignAppExaminer":{"appExaminerId":3032,"appId":8059,"examinerId":1069,"name":null,"assignDate":"2022-07-28T13:59:14.66","isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"assignAppToLB":null,"licePermitType":{"licPermitTypeId":410,"type":"2","category":"6","product":"","class":null,"description":null,"sectionOfLaw":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null,"isTempPermit":false,"isELicensingPermit":true,"isAdditionalBar":false},"assoApplicationList":[],"isTempPermit":null,"isTempOrLiq":false,"licPermitTypeId":410,"isAssociatedLicense":null,"effectiveDate":null,"assignedUserId":null,"amendmentTypeId":null,"amendmentType":null,"disapprovedDate":null,"condApprovedDate":null,"addressId":null,"isCaseOpen":null,"isClosed":null,"isCaseOpenSameAddress":null,"isSpecialEventPlusFour":null,"isSpecialEventInsideFiveBoroughs":null,"licStatus":null,"createdBy":null,"licenseId":null,"address":null,"isNybeApp":false,"isHearingCompleted":null,"does500FtHearingExist":null,"parentAppStatus":3,"premisesAppCount":0,"statusDescription":null,"eventAddress":null,"isFairOrFestival":false,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskRoleId":0,"taskDecision":null,"isActive":true,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":"2022-07-28T13:59:14.67"},"appId":8059,"notificationTypeId":2028,"applicationType":1,"decisionType":{"name":"Send to Licensing Board","value":2},"emailNotificationModel":{"applicant":{},"attorney":{},"communityBoard":{},"other":{}},"hasErrors":[],"taskId":1526,"newComments":"","recommendedDecisionId":null}
               # {"isFingerPrintsApproved":true,"isFingerPrintsRequired":false,"isCorpLLCDissolved":false,"isCorpLLCDTaken":false,"isSendPDLetter":false,"isDisable500LB_FBPT":false,"isDisableLBForPD":false,"isDisableLBForCaseClosed":false,"isDisableLateRenewalAndUnderpayment":false,"isLiquidatorPermitHasCompleted":-1,"isSubmit":true,"fieldDeficiencies":[],"masterFileData":[],"combinedCraftData":[],"application":{"applicationCategory":6,"appId":8077,"applicationId":"NA-0553-22-07379","licePermitTypeId":null,"applicationTypeId":1,"formVersionId":1540,"formId":1124,"legalName":"Automati","submitDate":"2022-07-29T13:57:52.755","isGISRequired":null,"licenseDescription":"Trucking (individual vehicle)","recommendedDecisionId":null,"status500":null,"isApplicableForPDLetter":false,"countyName":"Albany","priority":"Normal","expirationDate":null,"appStatusId":3,"taskStatus":"Awaiting Review","taskId":1526,"currentWfstatus":null,"communityBoard":null,"isLicenseApplication":false,"currentDueDate":null,"isFinalDeficiency":null,"isHighlyDeficient":false,"isAllDeficienciesMet":null,"pastDueDate":null,"memo":null,"isOneTimePermit":null,"dueDateAction":null,"isDisapprovedForCause":false,"isNotQualified":false,"eventDate":null,"appStatus":{"appStatusId":3,"statusDescription":"Under Review","isActive":true,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"applicationType":null,"assignAppExaminer":{"appExaminerId":3030,"appId":8077,"examinerId":1069,"name":null,"assignDate":"2022-07-29T13:57:52.755","isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null},"assignAppToLB":null,"licePermitType":{"licPermitTypeId":373,"type":"2","category":"6","product":"","class":null,"description":null,"sectionOfLaw":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"modifiedDate":null,"isTempPermit":false,"isELicensingPermit":true,"isAdditionalBar":false},"assoApplicationList":[],"isTempPermit":null,"isTempOrLiq":false,"licPermitTypeId":373,"isAssociatedLicense":null,"effectiveDate":null,"assignedUserId":null,"amendmentTypeId":null,"amendmentType":null,"disapprovedDate":null,"condApprovedDate":null,"addressId":null,"isCaseOpen":null,"isClosed":null,"isCaseOpenSameAddress":null,"isSpecialEventPlusFour":null,"isSpecialEventInsideFiveBoroughs":null,"licStatus":null,"createdBy":null,"licenseId":null,"address":null,"isNybeApp":false,"isHearingCompleted":null,"does500FtHearingExist":null,"parentAppStatus":3,"premisesAppCount":0,"statusDescription":null,"eventAddress":null,"isFairOrFestival":false,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskRoleId":0,"taskDecision":null,"isActive":true,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":"2022-07-29T13:57:52.755"},"appId":8077,"notificationTypeId":2028,"applicationType":1,"decisionType":{"name":"Send to Licensing Board","value":2},"emailNotificationModel":{"applicant":{},"attorney":{},"communityBoard":{},"other":{}},"hasErrors":[],"taskId":1526,"newComments":"","recommendedDecisionId":null}
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
 
    * def expiryDate = getExpiryDateFunc()
    * def EffectiveDate = EffDate()
    Given path '/internalapi/api/licensing/new-permit/saveDecision'
    And header authorization = 'Bearer ' + strToken
    And header current-wfroleid = 5
    And request {"isSubmit":true,"isHoldForCB":false,"isWaiverReceived":false,"isBuyerApproved":-1,"masterFileData":[],"combinedCraftData":[],"isChainRestaurant":false,"isOneTimePermit":false,"appId":'#(appId)',"applicationType":1,"applicationId":'#(ApplicationId)',"legalName":'#(legalName)',"statusId":3,"decisionType":{"name":"Approved","value":1},"emailNotificationModel":{"applicant":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"attorney":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"communityBoard":{"communicationId":0,"email":null,"appId":0,"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null},"other":{"communicationId":0,"email":"","appId":'#(appId)',"emailContactTypeId":0,"isChecked":false,"roleId":null,"decision":null,"screen":null,"emails":null,"solicitorEmails":null,"notificatonTypeId":null,"acaType":null,"isInstantEmail":null,"userName":null,"userId":0,"currentRoleId":0,"tempGuid":null,"applicationStatus":null,"taskId":null,"taskRoleId":0,"taskDecision":null,"isActive":null,"createdBy":null,"createdDate":null,"modifiedBy":null,"wfRoleId":0,"modifiedDate":null}},"hasErrors":[],"licPermitTypeId":410,"taskId":1601,"newComments":"","approval":{"isDefineStipulations":false,"effectiveDate":'#(EffectiveDate)',"expirationDate":'#(expiryDate)'}}
    When method post
    Then status 200
    And def serverResponse = response
    And print expiryDate
    And print EffectiveDate
          
  # ********* GET License Id *********************  
  
    Given path 'internalapi/api/licensing/LBDecision/getApprovalInfoByAppId/'+appId
    And header authorization = 'Bearer ' + strToken
    And request ""
    When method get
    Then status 200
    And def serverResponse = response
   
    #And def licId = serverResponse.license.licId
    And def licenseId = serverResponse.licensePermitId
    
    #And print 'licId : ' , licId
    And print 'licenseId : ' , licenseId
   # And match licId != []
    And match licenseId != []

  Examples:
   | read('/CSVFiles/TruckingPermitFee2.csv') |
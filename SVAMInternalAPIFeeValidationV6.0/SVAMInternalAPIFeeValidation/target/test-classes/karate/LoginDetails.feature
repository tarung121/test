Feature: Login Details
Background:
		* url BaseURL
		#'https://slaleapqa.svam.com'
 
#********* SignIn *********************
Scenario: Login Details Submission
  
 # ********* SignIn *********************
  
    Given path '/internalapi/api/account/signin'
    And request {"userName":'#(loginUserName)',"password":'#(loginUserPassword)'}
    When method post
    Then status 200
    And def serverResponse = response
    And def strToken = response.token
    #And print serverResponse
    And print strToken
    And match strToken != []

 

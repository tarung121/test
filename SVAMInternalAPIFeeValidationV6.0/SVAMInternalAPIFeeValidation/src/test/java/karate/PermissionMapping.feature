Feature: Permission Mapping

Background:
			* url BaseURL
  		* def config = { username: '#(dbUserName)', password:'#(dbUserPassword)', url: '#(dbQuery)',driverClassName: 'com.microsoft.sqlserver.jdbc.SQLServerDriver' }
    	* def DbUtils = Java.type('utils.DbUtils')
    	* def db = new DbUtils(config)
    	
Scenario Outline:   

    Given path 'internalapi/api/rolemapping/getPermissionRefForTab'
    And header authorization = 'Bearer ' + strToken
    And header current-wfi = 5
    
    * def payload = ""
    * def i = <roleId>
    * def payload1 = [{"i":"1","menuIds":1},{"i":"1","menuIds":21},{"i":"1","menuIds":27},{"i":"1","menuIds":34},{"i":"1","menuIds":37},{"i":"1","menuIds":38},{"i":"1","menuIds":39},{"i":"1","menuIds":46},{"i":"1","menuIds":267}]
  # * def payload2 = []
    * def payload3 = [{"roleId":"3","menuIds":38},{"roleId":"3","menuIds":39},{"roleId":"3","menuIds":46}]
    * def payload4 = [{"roleId":"4","menuIds":27},{"roleId":"4","menuIds":46}]
    * def payload5 = [{"roleId":"6","menuIds":27},{"roleId":"6","menuIds":46}]
    * def payload6 = [{"roleId":"3","menuIds":38},{"roleId":"3","menuIds":39},{"roleId":"3","menuIds":46}]
    * def payload7 = [{"roleId":"8","menuIds":1},{"roleId":"8","menuIds":21},{"roleId":"8","menuIds":27},{"roleId":"8","menuIds":34},{"roleId":"8","menuIds":37},{"roleId":"8","menuIds":38},{"roleId":"8","menuIds":39},{"roleId":"8","menuIds":46},{"roleId":"8","menuIds":267}]
    * def payload8 = [{"roleId":"16","menuIds":46},{"roleId":"16","menuIds":267}]
    * def payload9 = [{"roleId":"17","menuIds":267}]
    * def payload10 = [{"roleId":"18","menuIds":267}]
    * def payload11 = [{"roleId":"41","menuIds":1}]
    * def payload12 = [{"roleId":"10007","menuIds":39},{"roleId":"10007","menuIds":46}]
    * def payload13 = [{"roleId":"10008","menuIds":39},{"roleId":"10008","menuIds":46}]
    * def payload14 = [{"roleId":"10009","menuIds":46}]
    * def payload15 = [{"roleId":"10010","menuIds":39},{"roleId":"10010","menuIds":46}]
    * def payload16 = [{"roleId":"10011","menuIds":46}]
    * def payload17 = [{"roleId":"10012","menuIds":27},{"roleId":"10012","menuIds":46}]
    * def payload18 = [{"roleId":"10013","menuIds":27},{"roleId":"10013","menuIds":34},{"roleId":"10013","menuIds":37},{"roleId":"10013","menuIds":38},{"roleId":"10013","menuIds":39},{"roleId":"10013","menuIds":46},{"roleId":"10013","menuIds":267}]
    * def payload19 = [{"roleId":"10016","menuIds":27},{"roleId":"10016","menuIds":37},{"roleId":"10016","menuIds":39},{"roleId":"10016","menuIds":46}]
    * def payload20 = [{"roleId":"10017","menuIds":39},{"roleId":"10017","menuIds":46}]
    * def payload21 = [{"roleId":"10025","menuIds":1},{"roleId":"10025","menuIds":21},{"roleId":"10025","menuIds":27},{"roleId":"10025","menuIds":34},{"roleId":"10025","menuIds":37},{"roleId":"10025","menuIds":38},{"roleId":"10025","menuIds":39},{"roleId":"10025","menuIds":46},{"roleId":"10025","menuIds":267}]
    * def payload22 = [{"roleId":"10027","menuIds":1},{"roleId":"10027","menuIds":21},{"roleId":"10027","menuIds":27},{"roleId":"10027","menuIds":34},{"roleId":"10027","menuIds":37},{"roleId":"10027","menuIds":38},{"roleId":"10027","menuIds":39},{"roleId":"10027","menuIds":46},{"roleId":"10027","menuIds":267}]
    * def payload23 = [{"roleId":"10029","menuIds":37},{"roleId":"10029","menuIds":46}]
    * def payload24 = [{"roleId":"10028","menuIds":1},{"roleId":"10028","menuIds":21},{"roleId":"10028","menuIds":27},{"roleId":"10028","menuIds":34},{"roleId":"10028","menuIds":37},{"roleId":"10028","menuIds":38},{"roleId":"10028","menuIds":39},{"roleId":"10028","menuIds":46},{"roleId":"10028","menuIds":267}]
      And eval for(i=0;i<24;i++) 
    * eval if (i == 1) payload = payload1
 #  * eval if (i == 2) payload = payload2
    * eval if (i == 3) payload = payload3
    * eval if (i == 4) payload = payload4
    * eval if (i == 5) payload = payload5
    * eval if (i == 5) payload = payload5
    * eval if (i == 6) payload = payload6
    * eval if (i == 7) payload = payload7
    * eval if (i == 8) payload = payload8
    * eval if (i == 9) payload = payload9
    * eval if (i == 10) payload = payload10
    * eval if (i == 11) payload = payload11
    * eval if (i == 12) payload = payload12
    * eval if (i == 13) payload = payload13
    * eval if (i == 14) payload = payload14
    * eval if (i == 15) payload = payload15
    * eval if (i == 16) payload = payload16
    * eval if (i == 17) payload = payload17
    * eval if (i == 18) payload = payload18
    * eval if (i == 19) payload = payload19
    * eval if (i == 20) payload = payload20
    * eval if (i == 21) payload = payload21
    * eval if (i == 22) payload = payload22
    * eval if (i == 23) payload = payload23
    * eval if (i == 24) payload = payload24
   
 if(response.data[i].name.endsWith("")) outPut.add(response.data[i].email)
    And request payload 
    And print payload    
    When method post
    Then status 200
    And def serverResponse = response
    And print serverResponse  	
    
    """
    {}
    """
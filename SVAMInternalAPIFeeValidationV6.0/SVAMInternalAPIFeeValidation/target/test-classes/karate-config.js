function fn() {   
  var env = karate.env; // get java system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev'; // a custom 'intelligent' default
  }
  var config = { // base config JSON
   	dbQuery: 'jdbc:sqlserver:// 13.71.95.27;databaseName=NYSLA_Leap_DevIntegration;integratedSecurity=false;',
    BaseURL: 'https://sladevapi.svam.com',
    dbUserName:  'leapDev',
    dbUserPassword:'MyPass@123',
    loginUserName:'tgupta@svam.com',
    loginUserPassword:'svam123'
  };
 
  if (env == 'svamqa') {
    // over-ride only those that need to be
    config.dbQuery = 'jdbc:sqlserver://52.140.54.227;databaseName=NYSLA_Leap_QA;integratedSecurity=false;';
    config.BaseURL = 'https://slaleapqaapi.svam.com';
    config.dbServerName= '52.140.54.227';
    config.databaseName= 'NYSLA_Leap_QA';
    config.dbUserName=  'leapDev';
    config.dbUserPassword='MyPass@123';
  }
  return config;
}
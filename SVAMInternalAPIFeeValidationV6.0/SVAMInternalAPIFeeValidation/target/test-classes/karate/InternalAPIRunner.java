package karate;

import com.intuit.karate.junit5.Karate;

import utils.DbUtils;

class InternalAPIRunner {
String env = "svamqa";
	//**************************************Start of LIcenses Scenarios ********************************//
	
	//@Karate.Test
	Karate ValidateBeerRetailOnPremisesLicense() {
		return Karate.run("classpath:karate/BeerRetailOnPremisesLicenseApp.feature").karateEnv(env);
	}
	
	//@Karate.Test
	Karate ValidateLiqourRetailOnPremisesLicense() {
		return Karate.run("classpath:karate/LiqourRetailOnPremisesLicenseApp.feature").karateEnv(env);
	}
	
	//@Karate.Test
	Karate ValidateWineRetailOnPremisesSeasonalLicense() {
		return Karate.run("classpath:karate/LiqourRetailOnPremisesSeasonalLicenseApp.feature").karateEnv(env);
	}

	//@Karate.Test
	Karate ValidateManufacturingLicense() {
		return Karate.run("classpath:karate/ManufactureLicenseApp.feature").karateEnv(env);
	}

	//@Karate.Test
	Karate ValidateWholesaleLicense() {
		return Karate.run("classpath:karate/WholeSaleLicenseApp.feature").karateEnv(env);
	}

	//@Karate.Test
	Karate ValidateRetailOffPremisesLicense() {
		return Karate.run("classpath:karate/RetailOFFPremisesLicenseApp.feature").karateEnv(env);
	}
	
	//@Karate.Test
	Karate WineRetailOnPremisesLicenseApp() {
		return Karate.run("classpath:karate/WineRetailOnPremisesLicenseApp.feature").karateEnv(env);
	}
	
	
	//**************************************End of LIcenses Scenarios ********************************//

	//@Karate.Test
	Karate ValidateStandAlonePermit() {
		return Karate.run("classpath:karate/StandalonePermitIntakeToApprove.feature").karateEnv(env);
	}

	//@Karate.Test
	Karate ValidateAssociatedPermit() {
		return Karate.run("classpath:karate/AssocitaedPermitIntakeToApprove.feature").karateEnv(env);
	}

	//@Karate.Test
	Karate ValidateTempPermit() {
		return Karate.run("classpath:karate/TempPermitIntakeToApprove.feature").karateEnv(env);
	}
	
	//@Karate.Test
	Karate EmailMapping() {
		String userDir = java.lang.System.getProperty("user.dir");
		String srcPath = userDir +"/licenseAPPIds.csv";
		String destPath = userDir +"/src/test/java/karate/LicenseInputs";
		DbUtils.copyFile(srcPath, destPath);
	    return Karate.run("classpath:karate/EmailMapping.feature").karateEnv(env);
	}
   
	//******************************* End of Permit Scenarios****************************************//
	
	// @Karate.Test
	Karate ValidateRefundLicApp() {
		return Karate.run("classpath:karate/RefundLicenseApp.feature").karateEnv(env);
	}

	 //@Karate.Test
	Karate ValidateDisapproveLicApp() {
		return Karate.run("classpath:karate/DisappproveLicenseApp.feature").karateEnv(env);
	}

	 //@Karate.Test
	Karate ValidateDisapprovePermitApp() {
		return Karate.run("classpath:karate/DisapprovePermitApp.feature").karateEnv(env);
	}

	////// @Karate.Test
	Karate ValidateRenewalApp() {
		return Karate.run("classpath:karate/RenewalLicenseApp.feature").karateEnv(env);
	}

	//////@Karate.Test
	Karate renewalLicenseManufactureAndWholeSaleApp() {
		return Karate.run("classpath:karate/RenewalLicenseApp.feature").karateEnv(env);
	}
	
	///////@Karate.Test
	Karate renewalWineRetailOnPremisesLicenseApp() {
		return Karate.run("classpath:karate/RenewalWineRetailOnPremisesLicenseApp.feature").karateEnv(env);
	}
	
	//////@Karate.Test
	Karate renewalRetailOFFPremisesLicenseApp() {
		return Karate.run("classpath:karate/RenewalOffPremisesLicenseApp.feature").karateEnv(env);
	}
	
	
	//////////@Karate.Test
	Karate renewalBeerRetailOnPremisesLicense() {
		return Karate.run("classpath:karate/RenewalBeerRetailOnPremisesLicense.feature").karateEnv(env);
	}
	
	///////@Karate.Test
	Karate renewalPermitStandAloneType() {
		return Karate.run("classpath:karate/RenewalPermitStandAloneType.feature").karateEnv(env);
	}
	

	//////////@Karate.Test
	Karate renewalPermitAssociatedType() {
		return Karate.run("classpath:karate/RenewalPermitAssociatedType.feature").karateEnv(env);
	}
	
	
	//////@Karate.Test
	Karate renewalPermitTempType() {
		return Karate.run("classpath:karate/RenewalPermitTempType.feature").karateEnv(env);
	}
	
	
	///@Karate.Test
	Karate UC_LIC_029() {
		return Karate.run("classpath:karate/UC_LIC_029.feature").karateEnv(env);
	}
	
	
	
	//@Karate.Test
		Karate ValidateCommPagewithCreatedLicAppID() {
			return Karate.run("classpath:karate/ValidateCommSendNotification.feature").karateEnv(env);
		}
		
	
}

	



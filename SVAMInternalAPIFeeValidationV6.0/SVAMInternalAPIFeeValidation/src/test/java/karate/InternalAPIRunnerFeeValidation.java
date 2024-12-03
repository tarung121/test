package karate;

import com.intuit.karate.junit5.Karate;

class InternalAPIRunnerFeeValidation {

//	// @Karate.Test
//	Karate testFullPath() {
//		return Karate.run().relativeTo(getClass());
//	}
//

	String env = "svamqa";
	
	
    //@Karate.Test
	Karate ValidateLicenseWholesale() {
		return Karate.run("classpath:karate/wholesale.feature").karateEnv(env);
	}
	
	//@Karate.Test
    Karate ValidateRetailAllStates1() {
		return Karate.run("classpath:karate/BeerAndWineAllStatesFees.feature").karateEnv(env);
	}
	
	//@Karate.Test
    Karate ValidateRetailAllStates2() {
		return Karate.run("classpath:karate/LiquorAllStatesFee.feature").karateEnv(env);
	}
	
	//@Karate.Test
    Karate ValidateLicenseBarFee() {
		return Karate.run("classpath:karate/AdditionalBarOtherFee.feature").karateEnv(env);
	}
    
	//@Karate.Test
    Karate ValidateLicenseBarSeasonalFee() {
		return Karate.run("classpath:karate/AdditionalBarSeasonalFee.feature").karateEnv(env);
	}
	
	//@Karate.Test
    Karate ValidateLicensemanufacturing() {
		return Karate.run("classpath:karate/FeeValidationManufacturing.feature").karateEnv(env);
	}
	
    //@Karate.Test
    Karate ValidatePermitFee() {
		return Karate.run("classpath:karate/PermitsFee.feature").karateEnv(env);
    }
    
    //@Karate.Test
    Karate ValidateRetailOnCity1() {
		return Karate.run("classpath:karate/LiquorRetailCityFees.feature").karateEnv(env);
    }

    //@Karate.Test
    Karate ValidateRetailOnCity2() {
		return Karate.run("classpath:karate/BeerNWineCityFee.feature").karateEnv(env);
	}
    
    //@Karate.Test
    Karate ValidateUnitFee() {
		return Karate.run("classpath:karate/UnitCategoryFees.feature").karateEnv(env);
    }
    
    //@Karate.Test
    Karate ValidateBusinessRuleFee() {
		return Karate.run("classpath:karate/BusinessRulePermitFee.feature").karateEnv(env);
    }
    
    //@Karate.Test
    Karate ValidateBusinessRuleFee2() {
		return Karate.run("classpath:karate/BusinessRulePermitFee2.feature").karateEnv(env);
    }
    
    //@Karate.Test
    Karate ValidateTruckingFee() {
		return Karate.run("classpath:karate/TruckingPermitFee.feature").karateEnv(env);
    }
    
    //@Karate.Test
    Karate ValidateamendmentnoFees() {
		return Karate.run("classpath:karate/amendmentEnforcementNoFees.feature").karateEnv(env);
    }
    
    //@Karate.Test
    Karate ValidateamendmentotherFees() {
		return Karate.run("classpath:karate/amendmentotherFees.feature").karateEnv(env);
    }
    
    //@Karate.Test
    Karate ValidateamendmentABCOfficerFees() {
		return Karate.run("classpath:karate/amendmentABCOfficerFees.feature").karateEnv(env);
    }
    
    //@Karate.Test
    Karate ValidateamendmentCorporateChangesFees() {
		return Karate.run("classpath:karate/amendmentCorporateChangeFees.feature").karateEnv(env);
    }
    
    //@Karate.Test
    Karate ValidateamendmentMethodOfOperationFees() {
		return Karate.run("classpath:karate/amendmentMethodOfOperation.feature").karateEnv(env);
    }
    
    //@Karate.Test
	Karate ValidateamendmentEndorsementChangeFees() {
		return Karate.run("classpath:karate/amendmentEndorsementChange.feature").karateEnv(env);
    }
    	
    //@Karate.Test
	Karate ValidateamendmentAlterationsFees() {
		return Karate.run("classpath:karate/amendmentAlterationsFees.feature").karateEnv(env);
    }
    	
    @Karate.Test
	Karate ValidateamendmentChangeInClassFees() {
		return Karate.run("classpath:karate/amendmentChangeInClassFees.feature").karateEnv(env);
    }
      
    //@Karate.Test
    Karate ValidateamendmentChangeInClassBrewerFees() {
    	return Karate.run("classpath:karate/amendmentChangeInClassBrewerFees.feature").karateEnv(env);
    }
      
    //@Karate.Test
    Karate ValidateamendmentRemovalFees() {
		return Karate.run("classpath:karate/amendmentRemoval.feature").karateEnv(env);
    }
      
    //@Karate.Test
    Karate ValidateamendmentTruckingFees() {
		return Karate.run("classpath:karate/amendmentTruckingPermitFee2.feature").karateEnv(env);
    }
}    

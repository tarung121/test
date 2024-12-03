package karate;

import org.junit.jupiter.api.BeforeAll;

import com.intuit.karate.junit5.Karate;

class FeeValidationRunner {

	String env = "dev";

	 @Karate.Test
	Karate UC_LIC_022_TC0001_NYC_SLA_LIC_Intake_Fees() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_022_FeeValidations.feature")
				.karateEnv(env);
	}

}
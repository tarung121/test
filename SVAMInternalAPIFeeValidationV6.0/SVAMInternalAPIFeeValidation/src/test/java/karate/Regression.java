package karate;

import com.intuit.karate.junit5.Karate;

class Regression {

	String env = "svamqa";

		@Karate.Test
		Karate UC_LIC_020_PDLetters() {
			return Karate.run("classpath:karate/UseCases/UC_LIC_020_PDLetters.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_LIC_28_NotifyCommunityBoard() {
			return Karate.run("classpath:karate/UseCases/UC_LIC_28_NotifyCommunityBoard.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_LIC_023_Schedule_500_FooterHearing() {
			return Karate.run("classpath:karate/UseCases/UC_LIC_023_Schedule_500_FooterHearing.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_LIC_024_GISReport() {
			return Karate.run("classpath:karate/UseCases/UC_LIC_024_GISReport.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_LIC_39_20DayLetter() {
			return Karate.run("classpath:karate/UseCases/UC_LIC_39_20DayLetter.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_LIC_022_FeeValidations() {
			return Karate.run("classpath:karate/UseCases/UC_LIC_022_FeeValidations.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_LIC_027_ReturnCheck() {
			return Karate.run("classpath:karate/UseCases/UC_LIC_027_ReturnCheck.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_LIC_030_IntakeConditions() {
			return Karate.run("classpath:karate/UseCases/UC_LIC_030_IntakeConditions.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_LIC_027_ExtendDueDate() {
			return Karate.run("classpath:karate/UseCases/UC_LIC_027_ExtendDueDate.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_LIC_032_LicenseBoardDecisions() {
			return Karate.run("classpath:karate/UseCases/UC_LIC_032_LicenseBoardDecisions.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_LIC_FBPTReview() {
			return Karate.run("classpath:karate/UseCases/UC_LIC_FBPTReview.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_LIC_031_ExaminerReview() {
			return Karate.run("classpath:karate/UseCases/UC_LIC_031_ExaminerReview.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_TempPermits() {
			return Karate.run("classpath:karate/UseCases/UC_TempPermits.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_LIC_031_CCScenarios() {
			return Karate.run("classpath:karate/UseCases/UC_LIC_031_CCScenarios.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_LIC_038_IntakeSupportOpposition() {
			return Karate.run("classpath:karate/UseCases/UC_LIC_038_IntakeSupportOpposition.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_LIC_ChangeAppType() {
			return Karate.run("classpath:karate/UseCases/UC_LIC_ChangeAppType.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_Amendment_SelectType() {
			return Karate.run("classpath:karate/UseCases/UC_Amendment_SelectType.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_IntakeAmendment() {
			return Karate.run("classpath:karate/UseCases/UC_IntakeAmendment.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_AssignToExaminerAmendment() {
			return Karate.run("classpath:karate/UseCases/UC_AssignToExaminerAmendment.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_Amendment_ExaminerReview() {
			return Karate.run("classpath:karate/UseCases/UC_Amendment_ExaminerReview.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_Amendments_IntakeFees() {
			return Karate.run("classpath:karate/UseCases/UC_Amendments_IntakeFees.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_Permit_Trucking_Amendment() {
			return Karate.run("classpath:karate/UseCases/UC_Permit_Trucking_Amendment.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC90_Select_Application_Type_Permis() {
			return Karate.run("classpath:karate/UseCases/UC90_Select_Application_Type_Permis.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_Amendment_ReturnCheck() {
			return Karate.run("classpath:karate/UseCases/UC_Amendment_ReturnCheck.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_RenewalIntakeApp() {
			return Karate.run("classpath:karate/UseCases/UC_RenewalIntakeApp.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate Uc_RenewalExaminerReview() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate Uc_RenewalDueDate() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalDueDate.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate Uc_RenewalReturnedCheck() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalReturnedCheck.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_RenewalSearchLicenseId() {
			return Karate.run("classpath:karate/UseCases/UC_RenewalSearchLicenseId.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate Uc_RenewalIntakeFees() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalIntakeFees.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate Uc_RenewalHoldForCBNoticeReview() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalHoldForCBNoticeReview.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate Uc_RenewalChangePriority() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalChangePriority.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate Uc_RenewalAlertForCORP_LLC() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalAlertForCORP_LLC.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate Uc_RenewalAlertForWorkerCompLapse() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalAlertForWorkerCompLapse.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate Uc_Renewal_LBDecision() {
			return Karate.run("classpath:karate/UseCases/Uc_Renewal_LBDecision.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_Renewal_FBPT_Review() {
			return Karate.run("classpath:karate/UseCases/UC_Renewal_FBPT_Review.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate Uc_ReconProcessByClerical() {
			return Karate.run("classpath:karate/UseCases/Uc_ReconProcessByClerical.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate Uc_ReconReviewByExaminer() {
			return Karate.run("classpath:karate/UseCases/Uc_ReconReviewByExaminer.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_Amendment_ChangePriority() {
			return Karate.run("classpath:karate/UseCases/UC_Amendment_ChangePriority.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_Amendment_Due_Date_Extension() {
			return Karate.run("classpath:karate/UseCases/UC_Amendment_Due_Date_Extension.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_Amendments_FBPT() {
			return Karate.run("classpath:karate/UseCases/UC_Amendments_FBPT.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC91_Intake_Permits() {
			return Karate.run("classpath:karate/UseCases/UC91_Intake_Permits.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_IntakeFee_Permit() {
			return Karate.run("classpath:karate/UseCases/UC_IntakeFee_Permit.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate Uc_SurrenderIntake() {
			return Karate.run("classpath:karate/UseCases/Uc_SurrenderIntake.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate Uc_SurrenderReviewApplication() {
			return Karate.run("classpath:karate/UseCases/Uc_SurrenderReviewApplication.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_PRMT_099_LBDecisions() {
			return Karate.run("classpath:karate/UseCases/UC_PRMT_099_LBDecisions.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_PRMT_ReturnCheck() {
			return Karate.run("classpath:karate/UseCases/UC_PRMT_ReturnCheck.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_PRMT_098_ExaminerReview() {
			return Karate.run("classpath:karate/UseCases/UC_PRMT_098_ExaminerReview.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_PRMT_FBPT_Review() {
			return Karate.run("classpath:karate/UseCases/UC_PRMT_FBPT_Review.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_PRMT_ExtendDueDate() {
			return Karate.run("classpath:karate/UseCases/UC_PRMT_ExtendDueDate.feature")
					.karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_Common_RescindDecision() {
			return Karate.run("classpath:karate/UseCases/UC_Common_RescindDecision.feature")
					.karateEnv(env);
		}
		
}

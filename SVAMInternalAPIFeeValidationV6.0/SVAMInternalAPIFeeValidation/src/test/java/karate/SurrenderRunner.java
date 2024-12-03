package karate;

import com.intuit.karate.junit5.Karate;

class SurrenderRunner {

	String env = "svamqa";

		@Karate.Test
		Karate UC_SurrenderIntake1() {
			return Karate.run("classpath:karate/UseCases/Uc_SurrenderIntake.feature")
					.karateEnv(env);
		}

		@Karate.Test
		Karate UC_SurrenderReview1() {
			return Karate.run("classpath:karate/UseCases/Uc_SurrenderReviewApplication.feature")
					.karateEnv(env);
		}

		@Karate.Test
		Karate UC_AssociatedPermits_090() {
			return Karate.run("classpath:karate/UseCases/UC90_Select_Application_Type_Permis.feature")
					.karateEnv(env);
		}
		 @Karate.Test
		Karate TC0003_NYS_SLA_Intake_Conditions_Upload_Document_Approve() {
			return Karate.run("classpath:karate/UseCases/UC_LIC_030_IntakeConditions.feature")
					.karateEnv(env);
		}
		@Karate.Test
			Karate UC_LIC_ChangeAppType_TC0006_NYC_SLA_LIC_Alternate_Class_Type_Change_Request_Additional_Funds() {
				return Karate.run("classpath:karate/UseCases/UC_LIC_ChangeAppType.feature")
						.karateEnv(env);
		}
		@Karate.Test
		Karate UC_LIC_ExaminerReview_TC0005_NYC_SLA_LIC_Add_All_Multiple_Deficiencies() {
			return Karate.run("classpath:karate/UseCases/UC_LIC_031_ExaminerReview.feature")
					.karateEnv(env);
		}
		@Karate.Test
		Karate UC_LIC_FBPTReview_TC0001_NYC_SLA_LIC_FBPT_Redirects_Application_For_LB_Decision() {
			return Karate.run("classpath:karate/UseCases/UC_LIC_FBPTReview.feature")
					.karateEnv(env);
		}
		@Karate.Test
		Karate UC_LIC_023_TC0007_Hearing_Fee_Due() {
			return Karate.run("classpath:karate/UseCases/UC_LIC_023_Schedule_500_FooterHearing.feature")
					.karateEnv(env);
		}
		@Karate.Test
		Karate UC_LIC_039_TC0003_NYC_SLA_LIC_Disapprove_20_Days_Letter() {
			return Karate.run("classpath:karate/UseCases/UC_LIC_39_20DayLetter.feature")
					.karateEnv(env);
		}
		@Karate.Test
		Karate UC_LIC_032_TC0012_NYC_SLA_LIC_LB_Returns_Application_To_Examiner() {
			return Karate.run("classpath:karate/UseCases/UC_LIC_032_LicenseBoardDecisions.feature")
					.karateEnv(env);
		}
		@Karate.Test
		Karate UC_LIC_027_TC0011_NYS_SLA_Failed_Payment_Extension_Disapproved() {
			return Karate.run("classpath:karate/UseCases/UC_LIC_027_ExtendDueDate.feature")
					.karateEnv(env);
		}
		@Karate.Test
		Karate UC_LIC_027_ReturnCheck_TC0010_NYC_SLA_LIC_Intake_New_Payment_Overpayment() {
			return Karate.run("classpath:karate/UseCases/UC_LIC_027_ReturnCheck.feature")
					.karateEnv(env);
		}
		@Karate.Test
		Karate TC0001_NYC_SLA_LIC_Associate_Combined_Craft() {
			return Karate.run("classpath:karate/UseCases/UC_LIC_031_CCScenarios.feature")
					.karateEnv(env);
		}
//		@Karate.Test
//		Karate UC_LIC_024_TC0006_NYC_SLA_LIC_Generate_200_Notification_School_Enforcement() {
//			return Karate.run("classpath:karate/UseCases/UC_LIC_024_GISReport.feature")
//					.karateEnv(env);
//		}
		@Karate.Test
		Karate UC_LIC_022_TC0015_NYC_SLA_LIC_Edit_Bond_Information() {
			return Karate.run("classpath:karate/UseCases/UC_LIC_022_FeeValidations.feature")
					.karateEnv(env);
		}
//		@Karate.Test
//		Karate TC0002_NYS_SLA_No_Notification_To_Community_Board() {
//			return Karate.run("classpath:karate/UseCases/UC_LIC_28_NotifyCommunityBoard.feature")
//					.karateEnv(env);
//		}
		@Karate.Test
		Karate UC_AssociatedPermits_IntakePermits_1() {
			return Karate.run("classpath:karate/UseCases/UC91_Intake_Permits.feature")
					.karateEnv(env);
		}
		@Karate.Test
		Karate UC_PermitIntakeFees1() {
			return Karate.run("classpath:karate/UseCases/UC_IntakeFee_Permit.feature")
					.karateEnv(env);
		}
		@Karate.Test
		Karate UC_PermitExaminerReview1() {
			return Karate.run("classpath:karate/UseCases/UC_PRMT_098_ExaminerReview.feature")
					.karateEnv(env);
		}
		@Karate.Test
		Karate UC_PermitFBPTReview1() {
			return Karate.run("classpath:karate/UseCases/UC_PRMT_FBPT_Review.feature")
					.karateEnv(env);
		}
		@Karate.Test
		Karate UC_PermitLBDecision1() {
			return Karate.run("classpath:karate/UseCases/UC_PRMT_099_LBDecisions.feature")
					.karateEnv(env);
		}
		@Karate.Test
		Karate UC_PermitReturnCheck1() {
			return Karate.run("classpath:karate/UseCases/UC_PRMT_ReturnCheck.feature")
					.karateEnv(env);
		}
		@Karate.Test
		Karate UC_PermitDueDate1() {
			return Karate.run("classpath:karate/UseCases/UC_PRMT_ExtendDueDate.feature")
					.karateEnv(env);
		}
		@Karate.Test
		Karate UC_Amendment_SelectType_TC05_NYC_SLA_LIC_AMD_Search_By_Legal_name() {
			return Karate.run("classpath:karate/UseCases/UC_Amendment_SelectType.feature")
					.karateEnv(env);
		}
		@Karate.Test
		Karate UC_IntakeAmendment_TC0009_NYC_SLA_AMD_Highly_Deficient() {
			return Karate.run("classpath:karate/UseCases/UC_IntakeAmendment.feature")
					.karateEnv(env);
		}
		@Karate.Test
		Karate UC_AssignToExaminerAmendment_TC0001_NYC_SLA_LIC_AMD_Examiner_Supervisor_Assign_ApplicationToExaminer() {
			return Karate.run("classpath:karate/UseCases/UC_AssignToExaminerAmendment.feature")
					.karateEnv(env);
		}
		@Karate.Test
		Karate UC_Amendment_ExaminerReview_TC0001_NYC_SLA_LIC_AMD_Examiner_Sends_Application_For_LB_Review() {
			return Karate.run("classpath:karate/UseCases/UC_Amendment_ExaminerReview.feature")
					.karateEnv(env);
		}
		@Karate.Test
		Karate UC_Amendment_Fee_01() {
			return Karate.run("classpath:karate/UseCases/UC_Amendments_IntakeFees.feature")
					.karateEnv(env);
		}
		@Karate.Test
		Karate UC_Amendment_Trucking1() {
			return Karate.run("classpath:karate/UseCases/UC_Permit_Trucking_Amendment.feature")
					.karateEnv(env);
		}
		@Karate.Test
		Karate UC_Amendment_FBPT1() {
			return Karate.run("classpath:karate/UseCases/UC_Amendments_FBPT.feature")
					.karateEnv(env);
		}
		@Karate.Test
		Karate UC_Amendment_Due_Date_1() {
			return Karate.run("classpath:karate/UseCases/UC_Amendment_Due_Date_Extension.feature")
					.karateEnv(env);
		}
		@Karate.Test
		Karate UC_Amendment_ReturnCheck_TC0001_NYC_SLA_LIC_AMD_Update_Application_Send_Notification() {
			return Karate.run("classpath:karate/UseCases/UC_Amendment_ReturnCheck.feature")
					.karateEnv(env);
		}
		@Karate.Test
		Karate UC_RenewalIntakeApp_TC0001_SLA_REN_Intake_Onpremises_License_Inside_5_Boroughts_Submit() {
			return Karate.run("classpath:karate/UseCases/UC_RenewalIntakeApp.feature")
					.karateEnv(env);
		}
		@Karate.Test
		Karate Uc_RenewalExaminerReview_TC0002_SLA_REN_Examiner_review_Digest_Approved_and_Hold_for_CB_notice() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
					.karateEnv(env);
		}
		@Karate.Test
	    Karate Uc_RenewalDueDate_TC0001_SLA_REN_Duedate_Extension_Approve_Respond_Deficiencies_License() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalDueDate.feature")
					.karateEnv(env);
		}
		@Karate.Test
		Karate Uc_RenewalReturnedCheck_TC0001_SLA_REN_ReturnCheck_Payment_failed_Awaiting_Review_License() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalReturnedCheck.feature")
					.karateEnv(env);
		}
		@Karate.Test
		Karate UC_RenewalSearchLicenseId1() {
			return Karate.run("classpath:karate/UseCases/UC_RenewalSearchLicenseId.feature")
					.karateEnv(env);
		}
		@Karate.Test
		Karate UC_RenewalIntakeFees1() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalIntakeFees.feature")
					.karateEnv(env);
		}
		@Karate.Test
		Karate UC_RenewalFBPT_Review1() {
			return Karate.run("classpath:karate/UseCases/UC_Renewal_FBPT_Review.feature")
					.karateEnv(env);
		}
		@Karate.Test
		Karate UC_RescindDecision1() {
			return Karate.run("classpath:karate/UseCases/UC_Common_RescindDecision.feature")
					.karateEnv(env);
		}
		
}

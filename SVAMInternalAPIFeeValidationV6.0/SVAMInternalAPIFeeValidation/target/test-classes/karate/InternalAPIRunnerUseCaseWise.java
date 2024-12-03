package karate;
import com.intuit.karate.junit5.Karate;

class InternalAPIRunnerUseCaseWise {

	String env = "svamqa";

	///@Karate.Test
	Karate UC_LicType_018() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_018_SelectLICApp.feature").tags("licenseAllScenarios")
				.karateEnv(env);
	}

	///@Karate.Test
	Karate UC_LicType_018_LicenseAwaitingAdditionalFunds() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_018_SelectLICApp.feature")
				.tags("licenseAwaitingAdditionalFundsValidation").karateEnv(env);
	}

	///@Karate.Test
	Karate UC_LicType_018_licenseDefineDefendenciesValidation() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_018_SelectLICApp.feature")
				.tags("licenseDefineDefendenciesValidation").karateEnv(env);
	}

	///Karate.Test
	Karate UC_LicType_018_LicConditonallyApproveValidation() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_018_SelectLICApp.feature")
				.tags("licenseConditionallyApprovedValidation").karateEnv(env);
	}
/////////////////////////////PD_Letter ////////////////
		

	//@Karate.Test
	Karate UC_LIC_020_TC0001_NYC_SLA_LIC_PD_Letter_ON() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_020_PDLetters.feature")
				.tags("TC0001_NYS_SLA_LIC_PD_Letter_On").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_020_TC0002_NYC_SLA_LIC_PD_Letter_Of() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_020_PDLetters.feature")
				.tags("TC0002_NYC_SLA_LIC_PD_Letter_Of").karateEnv(env);
	}
	
/////////////////////////////Notify_Community_Board ////////////////

	//@Karate.Test
	Karate TC0001_NYS_SLA_Notification_To_Community_Board() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_28_NotifyCommunityBoard.feature")
				.tags("TC0001_NYS_SLA_Notification_To_Community_Board").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0002_NYS_SLA_No_Notification_To_Community_Board() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_28_NotifyCommunityBoard.feature")
				.tags("TC0002_NYS_SLA_No_Notification_To_Community_Board").karateEnv(env);
	}

/////////////////////////////Schedule_500_FooterHearing////////////////
	
	//@Karate.Test
	Karate UC_LIC_023_TC0001_NYC_SLA_LIC_Schedule_500() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_023_Schedule_500_FooterHearing.feature")
				.tags("TC0001_NYC_SLA_LIC_Schedule_500").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_023_TC0004_500_Hearing_Not_Required() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_023_Schedule_500_FooterHearing.feature")
				.tags("TC0004_500_Hearing_Not_Required").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_023_TC0007_Hearing_Fee_Due() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_023_Schedule_500_FooterHearing.feature")
				.tags("TC0007_Hearing_Fee_Due").karateEnv(env);
	}

/////////////////////////////GIS_Report////////////////
	
	//@Karate.Test
	Karate UC_LIC_024_TC0001_NYC_SLA_LIC_Request_Gross_Sales_Report() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_024_GISReport.feature")
			.tags("TC0001_NYC_SLA_LIC_Request_Gross_Sales_Report").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_024_TC0006_NYC_SLA_LIC_Generate_200_Notification_School_Enforcement() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_024_GISReport.feature")
				.tags("TC0006_NYC_SLA_LIC_Generate_200_Notification_School_Enforcement").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_024_TC0004_NYC_SLA_LIC_Generate_200_Notification_Church_Enforcement() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_024_GISReport.feature")
			.tags("TC0004_NYC_SLA_LIC_Generate_200_Notification_Church_Enforcement").karateEnv(env);
	}

/////////////////////////////20_Day_Letter////////////////

	//@Karate.Test
	Karate UC_LIC_039_TC0001_NYC_SLA_LIC_Approve_20_Days_Letter() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_39_20DayLetter.feature")
				.tags("TC0001_NYC_SLA_LIC_Approve_20_Days_Letter").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_LIC_039_TC0001a_NYC_SLA_LIC_Conditions_Met_Before_20_Days() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_39_20DayLetter.feature")
				.tags("TC0001a_NYC_SLA_LIC_Conditions_Met_Before_20_Days").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_LIC_039_TC0003_NYC_SLA_LIC_Disapprove_20_Days_Letter() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_39_20DayLetter.feature")
				.tags("TC0003_NYC_SLA_LIC_Disapprove_20_Days_Letter").karateEnv(env);
	}

/////////////////////////////Fee_Validations////////////////


	//@Karate.Test
	Karate UC_LIC_022_TC0001_NYC_SLA_LIC_Intake_Fees() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_022_FeeValidations.feature")
				.tags("TC0001_NYC_SLA_LIC_Intake_Fees").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_022_TC0002_NYC_SLA_LIC_Single_Check_Multiple_Application() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_022_FeeValidations.feature")
				.tags("TC0002_NYC_SLA_LIC_Single_Check").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_022_TC0003_NYC_SLA_LIC_Multiple_Check_OneApplication() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_022_FeeValidations.feature")
				.tags("TC0003_NYC_SLA_LIC_Multiple_Check").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_022_TC0004_NYC_SLA_LIC_Multiple_Check_Multiple_Application() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_022_FeeValidations.feature")
				.tags("TC0004_NYC_SLA_LIC_Multiple_Check_Multiple_Application").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_022_TC0005_NYC_SLA_LIC_Under_Payment() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_022_FeeValidations.feature")
				.tags("TC0005_NYC_SLA_LIC_Under_Payment").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_022_TC0006_NYC_SLA_LIC_Over_Payment() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_022_FeeValidations.feature")
				.tags("TC0006_NYC_SLA_LIC_Over_Payment").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_022_TC0007_NYC_SLA_LIC_Waived_Fee() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_022_FeeValidations.feature")
				.tags("TC0007_NYC_SLA_LIC_Waived_Fee").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_022_TC0009_NYC_SLA_LIC_Intake_Bond() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_022_FeeValidations.feature")
				.tags("TC0009_NYC_SLA_LIC_Intake_Bond").karateEnv(env);
	}

	//@Karate.Test
	Karate TC0011_NYC_SLA_LIC_Under_Payment_Disapprove_After_Due_Date_Plus_2_Business_Days() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_022_FeeValidations.feature")
				.tags("TC0011_NYC_SLA_LIC_Under_Payment_Disapprove_After_Due_Date_Plus_2_Business_Days").karateEnv(env);
	}

	//@Karate.Test
	Karate TC0012_NYC_SLA_LIC_Under_Payment_Not_Disapprove_On_Due_Date() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_022_FeeValidations.feature")
				.tags("TC0012_NYC_SLA_LIC_Under_Payment_Not_Disapprove_On_Due_Date").karateEnv(env);
	}

	//@Karate.Test
	Karate TC0013_NYC_SLA_LIC_Under_Payment_Not_Disapprove_Before_Due_Date() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_022_FeeValidations.feature")
				.tags("TC0013_NYC_SLA_LIC_Under_Payment_Not_Disapprove_Before_Due_Date").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0014_NYC_SLA_LIC_Under_Payment_Not_Disapprove_After_Due_Date_and_Before_2_Business_Days() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_022_FeeValidations.feature")
				.tags("TC0014_NYC_SLA_LIC_Under_Payment_Not_Disapprove_After_Due_Date_and_Before_2_Business_Days").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_022_TC0015_NYC_SLA_LIC_Edit_Bond_Information() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_022_FeeValidations.feature")
				.tags("TC0015_NYC_SLA_LIC_Edit_Bond_Information").karateEnv(env);
	}

/////////////////////////////Return_Check////////////////


	//@Karate.Test
	Karate UC_LIC_027_ReturnCheck_TC0002_NYC_SLA_LIC_Update_Application_Send_Notification() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_027_ReturnCheck.feature")
				.tags("TC0002_NYC_SLA_LIC_Update_Application_Send_Notifications").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_027_ReturnCheck_TC0004_NYC_SLA_LIC_Insufficient_Funds_received() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_027_ReturnCheck.feature")
				.tags("TC0004_NYC_SLA_LIC_Insufficient_Funds_received").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_027_ReturnCheck_TC0010_NYC_SLA_LIC_Intake_New_Payment_Overpayment() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_027_ReturnCheck.feature")
				.tags("TC0010_NYC_SLA_LIC_Intake_New_Payment_Overpayment").karateEnv(env);
	}

/////////////////////////////Intake_Conditions////////////////

	
	//@Karate.Test
	Karate UC_LIC_030_IntakeConditions_TC0001_NYS_SLA_Validate_Intake_Conditions_Screen() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_030_IntakeConditions.feature")
				.tags("TC0001_NYS_SLA_Validate_Intake_Conditions_Screen").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_LIC_030_IntakeConditions_TC0002_NYS_SLA_Intake_Conditions_Upload_Edit_Text_Response_Approve() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_030_IntakeConditions.feature")
				.tags("TC0002_NYS_SLA_Intake_Conditions_Upload_Edit_Text_Response_Approve").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_LIC_030_IntakeConditions_TC0003_NYS_SLA_Intake_Conditions_Upload_Document_Approve() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_030_IntakeConditions.feature")
				.tags("TC0003_NYS_SLA_Intake_Conditions_Upload_Document_Approve").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_LIC_030_IntakeConditions_TC0005_NYC_SLA_LIC_Intake_Conditions_Mark_Conditions_Received() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_030_IntakeConditions.feature")
				.tags("TC0005_NYC_SLA_LIC_Intake_Conditions_Mark_Conditions_Received").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_LIC_030_IntakeConditions_TC0006_NYC_SLA_LIC_Intake_Conditions_Mark_Partial_Condition_Met() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_030_IntakeConditions.feature")
				.tags("TC0006_NYC_SLA_LIC_Intake_Conditions_Mark_Partial_Condition_Met").karateEnv(env);
	}

/////////////////////////////Extend_Due_Date////////////////


	//@Karate.Test
	Karate UC_LIC_027_ExtendDueDateReturnCheck_TC0001_NYS_SLA_Deficiency_Due_Date_Extension_Approved() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_027_ExtendDueDate.feature")
				.tags("TC0001_NYS_SLA_Deficiency_Due_Date_Extension_Approved").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_027_ExtendDueDateReturnCheck_TC0006_NYS_SLA_Failed_Payment_Extension_Approved() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_027_ExtendDueDate.feature")
				.tags("TC0006_NYS_SLA_Failed_Payment_Extension_Approved").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_027_TC0007_NYS_SLA_Deficiency_Due_Date_Extension_Disapproved() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_027_ExtendDueDate.feature")
				.tags("TC0007_NYS_SLA_Deficiency_Due_Date_Extension_Disapproved").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_027_TC0008_NYS_SLA_Failed_Payment_Extension_Disapproved() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_027_ExtendDueDate.feature")
				.tags("TC0008_NYS_SLA_Failed_Payment_Extension_Disapproved").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_LIC_027_TC0011_NYS_SLA_Failed_Payment_Extension_Disapproved() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_027_ExtendDueDate.feature")
				.tags("TC0011_NYS_SLA_Conditions_Due_Date_Extension_Approved").karateEnv(env);
	}

/////////////////////////////License_Board_Decisions////////////////


	//@Karate.Test
	Karate UC_LIC_032_TC0001_NYC_SLA_LIC_LB_Approves_Application_With_No_Stipulations() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_032_LicenseBoardDecisions.feature")
				.tags("TC0001_NYC_SLA_LIC_LB_Approves_Application_With_No_Stipulations").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_032_TC0002_NYC_SLA_LIC_LB_Approves_Application_With_Stipulations() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_032_LicenseBoardDecisions.feature")
				.tags("TC0002_NYC_SLA_LIC_LB_Approves_Application_With_Stipulations").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_032_TC0003_NYC_SLA_LIC_LB_Approves_With_Multiple_Stipulations() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_032_LicenseBoardDecisions.feature")
				.tags("TC0003_NYC_SLA_LIC_LB_Approves_With_Multiple_Stipulations").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_032_TC0006_NYC_SLA_LIC_LB_Disapproves_Application() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_032_LicenseBoardDecisions.feature")
				.tags("TC0006_NYC_SLA_LIC_LB_Disapproves_Application").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_032_TC0008_NYC_SLA_LIC_LB_Marks_Application_As_Disapproval_To_Counsel() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_032_LicenseBoardDecisions.feature")
				.tags("TC0008_NYC_SLA_LIC_LB_Marks_Application_As_Disapproval_To_Counsel").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_032_TC0009_NYC_SLA_LIC_LB_Marks_Application_As_Withdrawn() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_032_LicenseBoardDecisions.feature")
				.tags("TC0009_NYC_SLA_LIC_LB_Marks_Application_As_Withdrawn").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_032_TC0010_NYC_SLA_LIC_LB_Conditionally_Approved_Application() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_032_LicenseBoardDecisions.feature")
				.tags("TC0010_NYC_SLA_LIC_LB_Conditionally_Approved_Application").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_032_TC0011_NYC_SLA_LIC_LB_Marks_Application_FB_Decision_Required() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_032_LicenseBoardDecisions.feature")
				.tags("TC0011_NYC_SLA_LIC_LB_Marks_Application_FB_Decision_Required").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_032_TC0012_NYC_SLA_LIC_LB_Returns_Application_To_Examiner() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_032_LicenseBoardDecisions.feature")
				.tags("TC0012_NYC_SLA_LIC_LB_Returns_Application_To_Examiner").karateEnv(env);
	}

/////////////////////////////FBPT_Review////////////////


	//@Karate.Test
	Karate UC_LIC_FBPTReview_TC0001_NYC_SLA_LIC_FBPT_Redirects_Application_For_LB_Decision() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_FBPTReview.feature")
			.tags("TC0001_NYC_SLA_LIC_FBPT_Redirects_Application_For_LB_Decision").karateEnv(env);
	}

/////////////////////////////Examiner_Review////////////////


	//@Karate.Test
	Karate UC_LIC_ExaminerReview_TC0001_NYC_SLA_LIC_Examiner_sends_Application_For_LB_Review() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_031_ExaminerReview.feature")
				.tags("TC0001_NYC_SLA_LIC_Examiner_sends_Application_For_LB_Review").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_ExaminerReview_TC0003_NYC_SLA_LIC_Examiner_Sends_Application_For_FBPT_Review() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_031_ExaminerReview.feature")
				.tags("TC0003_NYC_SLA_LIC_Examiner_Sends_Application_For_FBPT_Review").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_ExaminerReview_TC0005_NYC_SLA_LIC_Add_One_Deficiencies() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_031_ExaminerReview.feature")
				.tags("TC0005_NYC_SLA_LIC_Add_One_Deficiencies").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_ExaminerReview_TC0005_NYC_SLA_LIC_Add_All_Multiple_Deficiencies() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_031_ExaminerReview.feature")
				.tags("TC0005_NYC_SLA_LIC_Add_All_Multiple_Deficiencies").karateEnv(env);
	}
	

/////////////////////////////Temp_Permits////////////////
		
	//@Karate.Test
	Karate UC_TempPermits_TC0001_SLA_PER_Temp_Permit_Approval() {
		return Karate.run("classpath:karate/UseCases/UC_TempPermits.feature")
				.tags("TC0001_SLA_PER_Temp_Permit_Approval").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_TempPermits_TC0002_SLA_PER_Temp_Permit_Disapproval_Cause_Save() {
		return Karate.run("classpath:karate/UseCases/UC_TempPermits.feature")
				.tags("TC0002_SLA_PER_Temp_Permit_Disapproval_Cause_Save").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_TempPermits_TC0002a_SLA_PER_Temp_Permit_Disapproval_FTC_Save() {
		return Karate.run("classpath:karate/UseCases/UC_TempPermits.feature")
				.tags("TC0002a_SLA_PER_Temp_Permit_Disapproval_FTC_Save").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_TempPermits_TC0008_SLA_PER_Temp_Permit_Conditionally_Approve() {
		return Karate.run("classpath:karate/UseCases/UC_TempPermits.feature")
				.tags("TC0008_SLA_PER_Temp_Permit_Conditionally_Approve").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_TempPermits_TC0009_SLA_PER_Temp_Per_Pending_200() {
		return Karate.run("classpath:karate/UseCases/UC_TempPermits.feature")
				.tags("TC0009_SLA_PER_Temp_Per_Pending_200").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_TempPermits_TC0010_SLA_PER_Temp_Per_Pending_500() {
		return Karate.run("classpath:karate/UseCases/UC_TempPermits.feature")
				.tags("TC0010_SLA_PER_Temp_Per_Pending_500").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_TempPermits_TC0011_SLA_PER_Temp_Per_Pending_Full_Board() {
		return Karate.run("classpath:karate/UseCases/UC_TempPermits.feature")
				.tags("TC0011_SLA_PER_Temp_Per_Pending_Full_Board").karateEnv(env);
	}

/////////////////////////////CC_Scenarios////////////////


	//@Karate.Test
	Karate UC_LIC_031_CCScenarios_TC0001_NYC_SLA_LIC_Associate_Combined_Craft() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_031_CCScenarios.feature")
			.tags("TC0001_NYC_SLA_LIC_Associate_Combined_Craft").karateEnv(env);
	}

/////////////////////////////Intake_Support_Opposition////////////////

	
	//@Karate.Test
	Karate UC_LIC_038_TC0002_NYC_SLA_LIC_Upload_Additional_Support() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_038_IntakeSupportOpposition.feature")
				.tags("TC0002_NYC_SLA_LIC_Upload_Additional_Support_Opposition").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_038_TC0002_TC0005_NYC_SLA_LIC_View_Support_Opposition() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_038_IntakeSupportOpposition.feature")
				.tags("TC0005_NYC_SLA_LIC_View_Support_Opposition").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_038_TC0004_NYC_SLA_LIC_Delete_Support_Opposition() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_038_IntakeSupportOpposition.feature")
				.tags("TC0004_NYC_SLA_LIC_Delete_Support_Opposition").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_038_IntakeLicAndValidateSupportOpppsitionParties() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_038_IntakeSupportOpposition.feature")
				.tags("IntakeLicAndValidateSupportOpppsitionParties").karateEnv(env);
	}

/////////////////////////////Change_App_Type////////////////

	
	//@Karate.Test
	Karate UC_LIC_ChangeAppType_TC0001_NYC_SLA_LIC_Send_License_Type_Change_notification() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_ChangeAppType.feature")
				.tags("TC0001_NYC_SLA_LIC_Send_License_Type_Change_notification").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_ChangeAppType_TC0002_NYC_SLA_LIC_Alternate_Class_Type_Change_Determined_By_FB_Decision_Accepted() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_ChangeAppType.feature")
				.tags("TC0002_NYC_SLA_LIC_Alternate_Class_Type_Change_Determined_By_FB_Decision_Accepted").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_ChangeAppType_TC0003_NYC_SLA_LIC_Alternate_ClassType_Change_Not_Determined_By_FB_Decision_Accepted() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_ChangeAppType.feature")
				.tags("TC0003_NYC_SLA_LIC_Alternate_ClassType_Change_Not_Determined_By_FB_Decision_Accepted").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_ChangeAppType_TC0004_NYC_SLA_LIC_Alternate_ClassType_Change_Determined_By_FB_Decision_Rejected() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_ChangeAppType.feature")
				.tags("TC0004_NYC_SLA_LIC_Alternate_ClassType_Change_Determined_By_FB_Decision_Rejected").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_ChangeAppType_TC0005_NYC_SLA_LIC_Alternate_ClassType_Change_Not_Determined_By_FB_Decision_Rejected() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_ChangeAppType.feature")
				.tags("TC0005_NYC_SLA_LIC_Alternate_ClassType_Change_Not_Determined_By_FB_Decision_Rejected").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_LIC_ChangeAppType_TC0006_NYC_SLA_LIC_Alternate_Class_Type_Change_Request_Additional_Funds() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_ChangeAppType.feature")
				.tags("TC0006_NYC_SLA_LIC_Alternate_Class_Type_Change_Request_Additional_Funds").karateEnv(env);
	}

/////////////////////////////Amendment_SelectType////////////////


	//@Karate.Test
	Karate UC_Amendment_SelectType_TC05_NYC_SLA_LIC_AMD_Search_By_Legal_name() {
		return Karate.run("classpath:karate/UseCases/UC_Amendment_SelectType.feature")
				.tags("TC0005_NYC_SLA_LIC_AMD_Search_By_Legal_name").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_Amendment_SelectType_TC0004_NYC_SLA_LIC_AMD_Search_By_Licene_ID() {
		return Karate.run("classpath:karate/UseCases/UC_Amendment_SelectType.feature")
				.tags("TC0004_NYC_SLA_LIC_AMD_Search_By_Licene_ID").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_Amendment_SelectType_TC0009_NYC_SLA_LIC_AMD_Alteration_Amendment_With_Additional_Bars() {
		return Karate.run("classpath:karate/UseCases/UC_Amendment_SelectType.feature")
				.tags("TC0009_NYC_SLA_LIC_AMD_Alteration_Amendment_With_Additional_Bars").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_Amendment_SelectType_TC0010_NYC_SLA_LIC_AMD_Alteration_Amendment() {
		return Karate.run("classpath:karate/UseCases/UC_Amendment_SelectType.feature")
				.tags("TC0010_NYC_SLA_LIC_AMD_Alteration_Amendment").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_Amendment_SelectType_TC0011_NYC_SLA_LIC_AMD_Alteration_Amendment_Seasonal_With_Additional_Bars() {
		return Karate.run("classpath:karate/UseCases/UC_Amendment_SelectType.feature")
				.tags("TC0011_NYC_SLA_LIC_AMD_Alteration_Amendment_Seasonal_With_Additional_Bars").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_Amendment_SelectType_TC0012_NYC_SLA_LIC_AMD_Endorsement_Amendment() {
		return Karate.run("classpath:karate/UseCases/UC_Amendment_SelectType.feature")
				.tags("TC0012_NYC_SLA_LIC_AMD_Endorsement_Amendment").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_Amendment_SelectType_TC0013_NYC_SLA_LIC_AMD_Class_Change_Amendment() {
		return Karate.run("classpath:karate/UseCases/UC_Amendment_SelectType.feature")
				.tags("TC0013_NYC_SLA_LIC_AMD_Class_Change_Amendment").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_Amendment_SelectType_TC0014_NYC_SLA_LIC_AMD_Trucking_Amendment() {
		return Karate.run("classpath:karate/UseCases/UC_Amendment_SelectType.feature")
				.tags("TC0014_NYC_SLA_LIC_AMD_Trucking_Amendment").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_Amendment_SelectType_TC0015_NYC_SLA_LIC_AMD_Corporate_Change_Amendment() {
		return Karate.run("classpath:karate/UseCases/UC_Amendment_SelectType.feature")
				.tags("TC0015_NYC_SLA_LIC_AMD_Corporate_Change_Amendment").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_Amendment_SelectType_TC0019_NYC_SLA_LIC_AMD_Seasonal_Extension_Amendment() {
		return Karate.run("classpath:karate/UseCases/UC_Amendment_SelectType.feature")
				.tags("TC0019_NYC_SLA_LIC_AMD_Seasonal_Extension_Amendment").karateEnv(env);
	}
	
	
	//@Karate.Test
	Karate UC_Amendment_SelectType_TC0020_NYC_SLA_LIC_AMD_Additional_Bar_Amendment() {
		return Karate.run("classpath:karate/UseCases/UC_Amendment_SelectType.feature")
				.tags("TC0020_NYC_SLA_LIC_AMD_Additional_Bar_Amendment").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_Amendment_SelectType_TC0022_NYC_SLA_LIC_AMD_Not_Qualified_Application() {
		return Karate.run("classpath:karate/UseCases/UC_Amendment_SelectType.feature")
				.tags("TC0022_NYC_SLA_LIC_AMD_Not_Qualified_Application").karateEnv(env);
	}

/////////////////////////////Intake_Amendment////////////////

	
	//@Karate.Test
	Karate UC_IntakeAmendment_TC0007_NYC_SLA_AMD_Intake_Preview_Submit() {
		return Karate.run("classpath:karate/UseCases/UC_IntakeAmendment.feature")
				.tags("TC0007_NYC_SLA_AMD_Intake_Preview_Submit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_IntakeAmendment_TC0009_NYC_SLA_AMD_Highly_Deficient() {
		return Karate.run("classpath:karate/UseCases/UC_IntakeAmendment.feature")
				.tags("TC0009_NYC_SLA_AMD_Highly_Deficient").karateEnv(env);
	}

/////////////////////////////Assign_To_Examiner_Amendment////////////////

	
	//@Karate.Test
	Karate UC_AssignToExaminerAmendment_TC0001_NYC_SLA_LIC_AMD_Examiner_Supervisor_Assign_ApplicationToExaminer() {
		return Karate.run("classpath:karate/UseCases/UC_AssignToExaminerAmendment.feature")
				.tags("TC0001_NYC_SLA_LIC_AMD_Examiner_Supervisor_Assign_ApplicationToExaminer").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_AssignToExaminerAmendment_TC0002_NYC_SLA_LIC_AMD_Assign_Multiple_Applications_to_Examiner() {
		return Karate.run("classpath:karate/UseCases/UC_AssignToExaminerAmendment.feature")
				.tags("TC0002_NYC_SLA_LIC_AMD_Assign_Multiple_Applications_to_Examiner").karateEnv(env);
	}
	
/////////////////////////////Amendment_Examiner_Review////////////////
	
	//@Karate.Test
	Karate UC_Amendment_ExaminerReview_TC0001_NYC_SLA_LIC_AMD_Examiner_Sends_Application_For_LB_Review() {
		return Karate.run("classpath:karate/UseCases/UC_Amendment_ExaminerReview.feature")
				.tags("TC0001_NYC_SLA_LIC_AMD_Examiner_Sends_Application_For_LB_Review").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_Amendment_ExaminerReview_TC0001b_NYC_SLA_LIC_AMD_Examiner_MethodOfOperation_DigestTab() {
		return Karate.run("classpath:karate/UseCases/UC_Amendment_ExaminerReview.feature")
				.tags("TC0001b_NYC_SLA_LIC_AMD_Examiner_MethodOfOperation_DigestTab").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_Amendment_ExaminerReview_TC0001c_NYC_SLA_LIC_AMD_Examiner_Alteration_DigestTab() {
		return Karate.run("classpath:karate/UseCases/UC_Amendment_ExaminerReview.feature")
				.tags("TC0001c_NYC_SLA_LIC_AMD_Examiner_Alteration_DigestTab").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_Amendment_ExaminerReview_TC0001d_NYC_SLA_LIC_AMD_Examiner_CorporateChange_DigestTab() {
		return Karate.run("classpath:karate/UseCases/UC_Amendment_ExaminerReview.feature")
				.tags("TC0001d_NYC_SLA_LIC_AMD_Examiner_CorporateChange_DigestTab").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_Amendment_ExaminerReview_TC0001e_NYC_SLA_LIC_AMD_Examiner_Endorsement_DigestTab() {
		return Karate.run("classpath:karate/UseCases/UC_Amendment_ExaminerReview.feature")
				.tags("TC0001e_NYC_SLA_LIC_AMD_Examiner_Endorsement_DigestTab").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_Amendment_ExaminerReview_TC0003_NYC_SLA_LIC_AMD_Examiner_Sends_Application_For_FBPT_Review() {
		return Karate.run("classpath:karate/UseCases/UC_Amendment_ExaminerReview.feature")
				.tags("TC0003_NYC_SLA_LIC_AMD_Examiner_Sends_Application_For_FBPT_Review").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_Amendment_ExaminerReview_TC0004_NYC_SLA_LIC_AMD_Define_DeficienciesAndSend_Deficiency_Letter() {
		return Karate.run("classpath:karate/UseCases/UC_Amendment_ExaminerReview.feature")
				.tags("TC0004_NYC_SLA_LIC_AMD_Define_DeficienciesAndSend_Deficiency_Letter").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_Amendment_ExaminerReview_TC0005_NYC_SLA_LIC_AMD_Add_Multiple_Deficiencies() {
		return Karate.run("classpath:karate/UseCases/UC_Amendment_ExaminerReview.feature")
				.tags("TC0005_NYC_SLA_LIC_AMD_Add_Multiple_Deficiencies").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_Amendment_ExaminerReview_TC0017_NYC_SLA_LIC_AMD_Highly_Deficient() {
		return Karate.run("classpath:karate/UseCases/UC_Amendment_ExaminerReview.feature")
				.tags("TC0017_NYC_SLA_LIC_AMD_Highly_Deficient").karateEnv(env);
	}

/////////////////////////////Amendments_Intake_Fees////////////////

	
	//@Karate.Test
	Karate UC_Amendment_Fee_01() {
		return Karate.run("classpath:karate/UseCases/UC_Amendments_IntakeFees.feature")
					.tags("TC0001_NYC_SLA_AMD_Intake_Fees_Bond").karateEnv(env);
	}
			
	//@Karate.Test
	Karate UC_Amendment_Fee_02() {
		return Karate.run("classpath:karate/UseCases/UC_Amendments_IntakeFees.feature")
				.tags("TC0002_NYC_SLA_AMD_Single_Check_More_Than_One_License_Amendment").karateEnv(env);
	}	
	
	//@Karate.Test
	Karate UC_Amendment_Fee_03() {
		return Karate.run("classpath:karate/UseCases/UC_Amendments_IntakeFees.feature")
				.tags("TC0005_NYC_SLA_AMD_Under_Payment").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_Amendment_Fee_05() {
		return Karate.run("classpath:karate/UseCases/UC_Amendments_IntakeFees.feature")
				.tags("TC0006_NYC_SLA_AMD_Over_Payment").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_Amendment_Fee_06() {
		return Karate.run("classpath:karate/UseCases/UC_Amendments_IntakeFees.feature")
				.tags("TC0007_NYC_SLA_AMD_Waived_Fee").karateEnv(env);
	}

/////////////////////////////Permit_Trucking_Amendment////////////////


	//@Karate.Test
	Karate UC_Amendment_Trucking1() {
		return Karate.run("classpath:karate/UseCases/UC_Permit_Trucking_Amendment.feature")
				.tags("TC0001_NYC_SLA_PER_AMD_Add_Truck").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_Amendment_Trucking2() {
		return Karate.run("classpath:karate/UseCases/UC_Permit_Trucking_Amendment.feature")
				.tags("TC0002_NYC_SLA_PER_AMD_Edit_Truck_Added").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_Amendment_Trucking3() {
		return Karate.run("classpath:karate/UseCases/UC_Permit_Trucking_Amendment.feature")
				.tags("TC0003_NYC_SLA_PER_AMD_Remove_Truck").karateEnv(env);
	}

/////////////////////////////Select_Application_Type_Permis////////////////

	
	//@Karate.Test
	Karate UC_AssociatedPermits_090() {
		return Karate.run("classpath:karate/UseCases/UC90_Select_Application_Type_Permis.feature")
				.tags("TC0002_SLA_PER_Select_Associated_Permit_valid_approved_license_id").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_AssociatedPermits_090_TC0003() {
		return Karate.run("classpath:karate/UseCases/UC90_Select_Application_Type_Permis.feature")
				.tags("TC0003_SLA_PER_Select_Solicitor_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_AssociatedPermits_090_TC0004() {
		return Karate.run("classpath:karate/UseCases/UC90_Select_Application_Type_Permis.feature")
				.tags("TC0004_SLA_PER_Select_Associated_Permit_invalid_license_id_Legal_name").karateEnv(env);
	}
		
	//@Karate.Test
	Karate UC_AssociatedPermits_090_TC0005() {
		return Karate.run("classpath:karate/UseCases/UC90_Select_Application_Type_Permis.feature")
			.tags("TC0005_SLA_PER_Select_Multiple_Associated_permit").karateEnv(env);
	}
		
	//@Karate.Test
	Karate UC_AssociatedPermits_090_TC0006() {
		return Karate.run("classpath:karate/UseCases/UC90_Select_Application_Type_Permis.feature")
			.tags("TC0006_SLA_PER_Select_Associated_Permit_Valid_legal_name").karateEnv(env);
	}
	 		 
	//@Karate.Test
	Karate UC_AssociatedPermits_090_TC0007() {
			return Karate.run("classpath:karate/UseCases/UC90_Select_Application_Type_Permis.feature")
				.tags("TC0007_SLA_PER_Select_Temp_Permit_in_process_main_license").karateEnv(env);
	}
			
	//@Karate.Test
	Karate UC_AssociatedPermits_090_TC0007a() {
			return Karate.run("classpath:karate/UseCases/UC90_Select_Application_Type_Permis.feature")
				.tags("TC0007a_SLA_PER_Select_Temp_Permit_NO_main_license").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_AssociatedPermits_0008() {
		return Karate.run("classpath:karate/UseCases/UC90_Select_Application_Type_Permis.feature")
			.tags("TC0008_SLA_PER_Select_multiple_Temp_Permit_in_process_main_license").karateEnv(env);	
	}
    
	//@Karate.Test
    Karate UC_AssociatedPermits_0009() {
		return Karate.run("classpath:karate/UseCases/UC90_Select_Application_Type_Permis.feature")
			.tags("TC0009_SLA_PER_Select_Not_qualified_Associated_Permit").karateEnv(env);	
	}
   
	//@Karate.Test
	Karate UC_StandalonePermits_0010() {
		return Karate.run("classpath:karate/UseCases/UC90_Select_Application_Type_Permis.feature")
				.tags("TC0014_SLA_PER_Select_Standalone_Permit_Valid_approved_License_ID_Legalname").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_TempPermits_0011() {
		return Karate.run("classpath:karate/UseCases/UC90_Select_Application_Type_Permis.feature")
			.tags("TC0015_SLA_PER_Select_Trucking_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_TempPermits_0012() {
		return Karate.run("classpath:karate/UseCases/UC90_Select_Application_Type_Permis.feature")
			.tags("TC0016_SLA_PER_Select_Multiple_Standalone_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_TempPermits_0013() {
		return Karate.run("classpath:karate/UseCases/UC90_Select_Application_Type_Permis.feature")
			.tags("TC0017_SLA_PER_Select_Not_Qualified_Standalone_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_TempPermits_0014() {
		return Karate.run("classpath:karate/UseCases/UC90_Select_Application_Type_Permis.feature")
			.tags("TC0018_SLA_PER_Select_Not_Qualified_Temporary_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_TempPermits_0015() {
		return Karate.run("classpath:karate/UseCases/UC90_Select_Application_Type_Permis.feature")
			.tags("TC0019_SLA_PER_Select_Liquidator_Permit_Buyer_License").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_TempPermits_0016() {
		return Karate.run("classpath:karate/UseCases/UC90_Select_Application_Type_Permis.feature")
				.tags("TC0019_SLA_PER_Select_Main_License_Permit").karateEnv(env);
	}

/////////////////////////////Amendment_ReturnCheck////////////////

	//@Karate.Test
	Karate UC_Amendment_ReturnCheck_TC0001_NYC_SLA_LIC_AMD_Update_Application_Send_Notification() {
		return Karate.run("classpath:karate/UseCases/UC_Amendment_ReturnCheck.feature")
			.tags("TC0001_NYC_SLA_LIC_AMD_Update_Application_Send_Notification").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_Amendment_ReturnCheck_TC0002_NYC_SLA_AMD_Intake_New_Payment() {
		return Karate.run("classpath:karate/UseCases/UC_Amendment_ReturnCheck.feature")
			.tags("TC0002_NYC_SLA_AMD_Intake_New_Payment").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_Amendment_ReturnCheck_TC0003_NYC_SLA_AMD_Insufficient_Funds_received() {
		return Karate.run("classpath:karate/UseCases/UC_Amendment_ReturnCheck.feature")
			.tags("TC0003_NYC_SLA_AMD_Insufficient_Funds_received").karateEnv(env);
	}

/////////////////////////////Renewal_Intake_App////////////////

	//@Karate.Test
	Karate UC_RenewalIntakeApp_TC0001_SLA_REN_Intake_Onpremises_License_Inside_5_Boroughts_Submit() {
		return Karate.run("classpath:karate/UseCases/UC_RenewalIntakeApp.feature")
				.tags("TC0001_SLA_REN_Intake_Onpremises_License_Inside_5_Boroughts_Submit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_RenewalIntakeApp_TC0001a_SLA_REN_Intake_On_premises_Seasonal() {
		return Karate.run("classpath:karate/UseCases/UC_RenewalIntakeApp.feature")
				.tags("TC0001a_SLA_REN_Intake_On_premises_Seasonal").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_RenewalIntakeApp_TC0001b_SLA_REN_Intake_Wholesaler_Manufacturer_License() {
		return Karate.run("classpath:karate/UseCases/UC_RenewalIntakeApp.feature")
				.tags("TC0001b_SLA_REN_Intake_Wholesaler_Manufacturer_License").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_RenewalIntakeApp_TC0001c_SLA_REN_Intake_Direct_Shipper_License() {
		return Karate.run("classpath:karate/UseCases/UC_RenewalIntakeApp.feature")
				.tags("TC0001c_SLA_REN_Intake_Direct_Shipper_License").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_RenewalIntakeApp_TC0002_SLA_REN_Intake_Standalone_Permit() {
		return Karate.run("classpath:karate/UseCases/UC_RenewalIntakeApp.feature")
				.tags("TC0002_SLA_REN_Intake_Standalone_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_RenewalIntakeApp_TC0002a_SLA_REN_Intake_Associated_Permit() {
		return Karate.run("classpath:karate/UseCases/UC_RenewalIntakeApp.feature")
				.tags("TC0002a_SLA_REN_Intake_Associated_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_RenewalIntakeApp_TC0003b_SLA_REN_Intake_Preview_Submit_Not_Qualified_application() {
		return Karate.run("classpath:karate/UseCases/UC_RenewalIntakeApp.feature")
				.tags("TC0003b_SLA_REN_Intake_Preview_Submit_Not_Qualified_application").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_RenewalIntakeApp_TC0004_SLA_REN_Intake_HighlyDeficiency() {
		return Karate.run("classpath:karate/UseCases/UC_RenewalIntakeApp.feature")
				.tags("TC0004_SLA_REN_Intake_HighlyDeficiency").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_RenewalIntakeApp_TC0005_SLA_REN_Intake_Main_license_Associated_Permit_Submit() {
		return Karate.run("classpath:karate/UseCases/UC_RenewalIntakeApp.feature")
				.tags("TC0005_SLA_REN_Intake_Main_license_Associated_Permit_Submit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_RenewalIntakeApp_TC0017_SLA_REN_Intake_Awaiting_Additional_Funs_application() {
		return Karate.run("classpath:karate/UseCases/UC_RenewalIntakeApp.feature")
				.tags("TC0017_SLA_REN_Intake_Awaiting_Additional_Funs_application").karateEnv(env);
	}
	

/////////////////////////////Renewal_Examiner_Review////////////////

	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0002_SLA_REN_Examiner_review_Digest_Approved_and_Hold_for_CB_notice() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0002_SLA_REN_Examiner_review_Digest_Approved_and_Hold_for_CB_notice").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0002_SLA_REN_Examiner_review_Digest_ApprovedandRefertoCounselsOffice() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0002_SLA_REN_Examiner_review_Digest_ApprovedandRefertoCounselsOffice").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0002A_SLA_REN_Examiner_review_Common_Digest_License() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0002A_SLA_REN_Examiner_review_Common_Digest_License").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0002A_SLA_REN_Examiner_review_Common_Digest_Permit() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0002A_SLA_REN_Examiner_review_Common_Digest_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0003_SLA_REN_Examiner_review_Approve_license() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0003_SLA_REN_Examiner_review_Approve_license").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0004_SLA_REN_Examiner_review_Approve_Standalone_Permit() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0004_SLA_REN_Examiner_review_Approve_Standalone_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0005_SLA_REN_Examiner_review_Approve_Associated_Permit() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0005_SLA_REN_Examiner_review_Approve_Associated_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0006_SLA_REN_Examiner_review_Approve_Temporary_Permit() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0006_SLA_REN_Examiner_review_Approve_Temporary_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0007_SLA_REN_Examiner_Approve_Safekeeping_License() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0007_SLA_REN_Examiner_Approve_Safekeeping_License").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0008_SLA_REN_Examiner_Approve_Safekeeping_Associated_Permit() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0008_SLA_REN_Examiner_Approve_Safekeeping_Associated_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0009_SLA_REN_Examiner_Approve_Safekeeping_Standalone_Permit() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0009_SLA_REN_Examiner_Approve_Safekeeping_Standalone_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0010_SLA_REN_Examiner_Approve_Safekeeping_Temporary_Permit() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0010_SLA_REN_Examiner_Approve_Safekeeping_Temporary_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0012_SLA_REN_Examiner_review_Approve_Provisions_Removal() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0012_SLA_REN_Examiner_review_Approve_Provisions_Removal").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0013_SLA_REN_Examiner_review_Approve_Provisions_Corporate_Change() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0013_SLA_REN_Examiner_review_Approve_Provisions_Corporate_Change").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0014_SLA_REN_Examiner_review_Approve_Provisions_Alteration() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0014_SLA_REN_Examiner_review_Approve_Provisions_Alteration").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0015_SLA_REN_Examiner_review_Approve_Provisions_Endorsement() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0015_SLA_REN_Examiner_review_Approve_Provisions_Endorsement").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0016_SLA_REN_Examiner_review_Approve_Provisions_Safekeeping_Removal() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0016_SLA_REN_Examiner_review_Approve_Provisions_Safekeeping_Removal").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0017_SLA_REN_Examiner_review_Approve_Provisions_Safekeeping_Corporate_Change() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0017_SLA_REN_Examiner_review_Approve_Provisions_Safekeeping_Corporate_Change").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0018_SLA_REN_Examiner_review_Approve_Provisions_Safekeeping_Alteration() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0018_SLA_REN_Examiner_review_Approve_Provisions_Safekeeping_Alteration").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0019_SLA_REN_Examiner_review_Approve_Provisions_Safekeeping_Endorsement() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0019_SLA_REN_Examiner_review_Approve_Provisions_Safekeeping_Endorsement").karateEnv(env);
	}
	
	//@Karate.Test
    Karate TC0020_SLA_REN_Examiner_review_Send_to_LB_for_Review_License() {
        return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
        		.tags("TC0020_SLA_REN_Examiner_review_Send_to_LB_for_Review_License").karateEnv(env);
	}
    
	//@Karate.Test
	Karate TC0021_SLA_REN_Examiner_review_Send_to_LB_for_Review_Permit() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
			.tags("TC0021_SLA_REN_Examiner_review_Send_to_LB_for_Review_Permit").karateEnv(env);
	}

	//@Karate.Test
	Karate TC0022_SLA_REN_Examiner_Review_Send_to_LB_On_Premises_License() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
			.tags("TC0022_SLA_REN_Examiner_Review_Send_to_LB_On_Premises_License").karateEnv(env);
	}

	//@Karate.Test
	Karate TC0024_SLA_REN_Examiner_Review_FBPT_for_Review_License() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
			.tags("TC0024_SLA_REN_Examiner_Review_FBPT_for_Review_License").karateEnv(env);
	}

	//@Karate.Test
	Karate TC0025_SLA_REN_Examiner_Review_FBPT_for_Review_On_Premises_License() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
			.tags("TC0025_SLA_REN_Examiner_Review_FBPT_for_Review_On_Premises_License").karateEnv(env);
	}

	//@Karate.Test
	Karate TC0026_SLA_REN_Examiner_Review_FBPT_for_Review_Permit() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
			.tags("TC0026_SLA_REN_Examiner_Review_FBPT_for_Review_Permit").karateEnv(env);
	}

	//@Karate.Test
	Karate TC0029_SLA_REN_Examiner_Review_Define_Deficiencies_License() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
			.tags("TC0029_SLA_REN_Examiner_Review_Define_Deficiencies_License").karateEnv(env);
	}

	//@Karate.Test
	Karate TC0030_SLA_REN_Examiner_Review_Define_Deficiencies_On_Premises_License() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
			.tags("TC0030_SLA_REN_Examiner_Review_Define_Deficiencies_On_Premises_License").karateEnv(env);
	}

	//@Karate.Test
	Karate TC0031_SLA_REN_Examiner_Review_DefineDeficiencies_Permit() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
			.tags("TC0031_SLA_REN_Examiner_Review_DefineDeficiencies_Permit").karateEnv(env);
	}

	//@Karate.Test
	Karate TC0032_SLA_REN_Examiner_Review_IntakeDeficiencies_Permit() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
			.tags("TC0032_SLA_REN_Examiner_Review_IntakeDeficiencies_Permit").karateEnv(env);
	}

	//@Karate.Test
	Karate TC0034_SLA_REN_Examiner_Review_IntakeDeficiencies_On_Premises_License() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
			.tags("TC0034_SLA_REN_Examiner_Review_IntakeDeficiencies_On_Premises_License").karateEnv(env);
	}

	//@Karate.Test
	Karate TC0035_SLA_REN_Examiner_Review_IntakeDeficiencies_License() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
			.tags("TC0035_SLA_REN_Examiner_Review_IntakeDeficiencies_License").karateEnv(env);
	}

	//@Karate.Test
	Karate TC0036_SLA_REN_Examiner_Review_Deficiencies_Permit_AllDeficiencies_met_YES() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
			.tags("TC0036_SLA_REN_Examiner_Review_Deficiencies_Permit_AllDeficiencies_met_YES").karateEnv(env);
	}

	//@Karate.Test
	Karate TC0037_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_No_Define_YES_Final_YES() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
			.tags("TC0037_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_No_Define_YES_Final_YES").karateEnv(env);
	}

	//@Karate.Test
	Karate TC0038_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_No_Define_NO_Final_NO() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
			.tags("TC0038_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_No_Define_NO_Final_NO").karateEnv(env);
	}

	//@Karate.Test
	Karate TC0039_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_NO_Final_deficiency_Checked_before() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
			.tags("TC0039_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_NO_Final_deficiency_Checked_before").karateEnv(env);
	}

	//@Karate.Test
	Karate TC0040_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_No_Define_YES_Final_NO() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
			.tags("TC0040_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_No_Define_YES_Final_NO").karateEnv(env);
	}

	//@Karate.Test
	Karate TC0041_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_YES_Define_YES_Final_YES_response_OK() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
			.tags("TC0041_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_YES_Define_YES_Final_YES_response_OK").karateEnv(env);
	}

	//@Karate.Test
	Karate TC0042_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_YES_Define_YES_Final_YES_response_NO() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
			.tags("TC0042_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_YES_Define_YES_Final_YES_response_NO").karateEnv(env);
	}

	//@Karate.Test
	Karate TC0043_SLA_REN_ExaminersReview_SendDeficiency_Reminder() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
			.tags("TC0043_SLA_REN_ExaminersReview_SendDeficiency_Reminder").karateEnv(env);
	}

	//@Karate.Test
	Karate TC0044_SLA_REN_ExaminersReview_Send_DisapprovalLetter() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0044_SLA_REN_ExaminersReview_Send_DisapprovalLetter").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0045_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0045_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0046_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0046_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0047_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Define_provisions_Removal() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0047_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Define_provisions_Removal").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0048_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Define_provisions_Corporate_Change() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0048_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Define_provisions_Corporate_Change").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0049_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Define_provisions_Alteration() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0049_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Define_provisions_Alteration").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0050_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Define_provisions_Endorsement() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0050_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Define_provisions_Endorsement").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0051_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping_Define_provisions_Removal() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0051_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping_Define_provisions_Removal").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0052_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping_Define_provisions_Corporate_Change() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0052_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping_Define_provisions_Corporate_Change").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0053_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping_Define_provisions_Alteration() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0053_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping_Define_provisions_Alteration").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0054_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping_Define_provisions_Endorsement() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0054_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping_Define_provisions_Endorsement").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0055_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0055_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0056_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0056_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0057_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Define_provisions_Removal() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0057_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Define_provisions_Removal").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0058_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Define_provisions_CorporateChange() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0058_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Define_provisions_CorporateChange").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0059_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Define_provisions_Alternation() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0059_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Define_provisions_Alternation").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0060_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Define_provisions_Endorsement() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0060_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Define_provisions_Endorsement").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0061_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping_Define_provisions_Removal() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0061_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping_Define_provisions_Removal").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0062_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping_Define_provisions_CorporateChange() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0062_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping_Define_provisions_CorporateChange").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0063_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping_Define_provisions_Alternation() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0063_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping_Define_provisions_Alternation").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0064_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping_Define_provisions_Endorsement() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0064_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping_Define_provisions_Endorsement").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalExaminerReview_TC0066_SLA_REN_Examiners_Review_Highly_Deficient() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
				.tags("TC0066_SLA_REN_Examiners_Review_Highly_Deficient").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0069_SLA_REN_ExaminersReview_Cancel() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
			  .tags("TC0069_SLA_REN_ExaminersReview_Cancel").karateEnv(env);
	}

/////////////////////////////Renewal_Due_Date////////////////

	
	//@Karate.Test
	Karate Uc_RenewalDueDate_TC0001_SLA_REN_Duedate_Extension_Approve_Respond_Deficiencies_License() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalDueDate.feature")
				.tags("TC0001_SLA_REN_Duedate_Extension_Approve_Respond_Deficiencies_License").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalDueDate_TC0001a_SLA_REN_Duedate_Extension_Approve_Respond_Deficiencies_Permit() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalDueDate.feature")
				.tags("TC0001a_SLA_REN_Duedate_Extension_Approve_Respond_Deficiencies_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalDueDate_TC0003_SLA_REN_Due_date_Extension_disapprove_Respond_Deficiencies_License() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalDueDate.feature")
				.tags("TC0003_SLA_REN_Due_date_Extension_disapprove_Respond_Deficiencies_License").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalDueDate_TC0003a_SLA_REN_Due_date_Extension_disapprove_Respond_Deficiencies_Permit() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalDueDate.feature")
				.tags("TC0003a_SLA_REN_Due_date_Extension_disapprove_Respond_Deficiencies_License_Permit").karateEnv(env);
	}

/////////////////////////////Renewal_Returned_Check////////////////

	
	
	//@Karate.Test
	Karate Uc_RenewalReturnedCheck_TC0001_SLA_REN_ReturnCheck_Payment_failed_Awaiting_Review_License() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalReturnedCheck.feature")
				.tags("TC0001_SLA_REN_ReturnCheck_Payment_failed_Awaiting_Review_License").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalReturnedCheck_TC0001a_SLA_REN_Return_Check_Paymentfailed_Awaiting_Review_Permit() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalReturnedCheck.feature")
				.tags("TC0001a_SLA_REN_Return_Check_Paymentfailed_Awaiting_Review_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalReturnedCheck_TC0002_SLA_REN_ReturnCheck_Intake_Payment_Awaiting_Additional_Funds_License() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalReturnedCheck.feature")
				.tags("TC0002_SLA_REN_ReturnCheck_Intake_Payment_Awaiting_Additional_Funds_License").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalReturnedCheck_TC0002a_SLA_REN_ReturnCheck_Intake_Payment_Awaiting_Additional_Funds_Permit() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalReturnedCheck.feature")
				.tags("TC0002a_SLA_REN_ReturnCheck_Intake_Payment_Awaiting_Additional_Funds_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalReturnedCheck_TC0004_SLA_REN_ReturnCheck_Intake_Payment_Awaiting_Additional_Funds_insufficient_fund_received_License() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalReturnedCheck.feature")
				.tags("TC0004_SLA_REN_ReturnCheck_Intake_Payment_Awaiting_Additional_Funds_insufficient_fund_received_License").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalReturnedCheck_TC0004a_SLA_REN_ReturnCheck_Intake_Payment_Awaiting_Additional_Funds_insufficient_fund_received_Permit() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalReturnedCheck.feature")
				.tags("TC0004a_SLA_REN_ReturnCheck_Intake_Payment_Awaiting_Additional_Funds_insufficient_fund_received_Permit").karateEnv(env);
	}
	
	
//////////Renewal_Search_License_Id/////////////	
	

	//@Karate.Test
	Karate UC_RenewalSearchLicenseId1() {
		return Karate.run("classpath:karate/UseCases/UC_RenewalSearchLicenseId.feature")
				.tags("TC0001_SLA_REN_Search_Renewal_Select_Application_Type").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_RenewalSearchLicenseId2() {
		return Karate.run("classpath:karate/UseCases/UC_RenewalSearchLicenseId.feature")
				.tags("TC0001a_SLA_REN_Search_Renewal_Select_Application_Type").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_RenewalSearchLicenseId3() {
		return Karate.run("classpath:karate/UseCases/UC_RenewalSearchLicenseId.feature")
				.tags("TC0001b_SLA_REN_Search_Renewal_Select_Application_Type_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_RenewalSearchLicenseId4() {
		return Karate.run("classpath:karate/UseCases/UC_RenewalSearchLicenseId.feature")
				.tags("TC0002_SLA_REN_Search_Renewal_Select_Application_Type_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_RenewalSearchLicenseId5() {
		return Karate.run("classpath:karate/UseCases/UC_RenewalSearchLicenseId.feature")
				.tags("TC0003_SLA_REN_Search_License_Name").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_RenewalSearchLicenseId6() {
		return Karate.run("classpath:karate/UseCases/UC_RenewalSearchLicenseId.feature")
				.tags("TC0004_SLA_REN_Search_License_Combined_Craft_select_two").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_RenewalSearchLicenseId7() {
		return Karate.run("classpath:karate/UseCases/UC_RenewalSearchLicenseId.feature")
				.tags("TC0005_SLA_REN_Search_License_Combined_Craft_ID_select_less_than_two_YES").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_RenewalSearchLicenseId8() {
		return Karate.run("classpath:karate/UseCases/UC_RenewalSearchLicenseId.feature")
				.tags("TC0007_SLA_REN_Search_License_Master_File_select_five").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_RenewalSearchLicenseId9() {
		return Karate.run("classpath:karate/UseCases/UC_RenewalSearchLicenseId.feature")
				.tags("TC0008_SLA_REN_Search_License_Master_File_select_less_than_five_YES").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_RenewalSearchLicenseId10() {
		return Karate.run("classpath:karate/UseCases/UC_RenewalSearchLicenseId.feature")
				.tags("TC0010_SLA_REN_Search_Not_Qualified").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_RenewalSearchLicenseId11() {
		return Karate.run("classpath:karate/UseCases/UC_RenewalSearchLicenseId.feature")
				.tags("TC0014_SLA_REN_Search_Associated_Permit_ID_Main_License_not_expired").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_RenewalSearchLicenseId12() {
		return Karate.run("classpath:karate/UseCases/UC_RenewalSearchLicenseId.feature")
				.tags("TC0015_SLA_REN_Search_Renewal_WH_MA_License_Solicitor_Permit").karateEnv(env);
	}
	
	
////////////////Renewal_Intake_Fees//////////////////

	//@Karate.Test
	Karate UC_RenewalIntakeFees1() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalIntakeFees.feature")
				.tags("TC001_SLA_REN_Intake_Fees_Main_License_Information_section").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_RenewalIntakeFees2() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalIntakeFees.feature")
				.tags("TC004_SLA_REN_Intake_Fees_Bond_Information_grid").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_RenewalIntakeFees3() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalIntakeFees.feature")
				.tags("TC006_SLA_REN_Intake_Fees_Apply_Payment_to_Single_Application").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_RenewalIntakeFees4() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalIntakeFees.feature")
				.tags("TC007_SLA_REN_Intake_Fees_Apply_Payment_to_multiple_Application").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_RenewalIntakeFees5() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalIntakeFees.feature")
				.tags("TC011_SLA_REN_Intake_Fees_Underpayment_Before_due_date").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_RenewalIntakeFees6() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalIntakeFees.feature")
				.tags("TC015_SLA_REN_Intake_Fees_Underpayment_HOLD").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_RenewalIntakeFees7() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalIntakeFees.feature")
				.tags("TC016_SLA_REN_Intake_Fees_Over_Payment").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_RenewalIntakeFees8() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalIntakeFees.feature")
				.tags("TC017_SLA_REN_Intake_Fees_Waived_Fee").karateEnv(env);
	}
	
////////////Renewal_Hold_For_CB_Notice_Review//////////////////
	
		
	//@Karate.Test
	Karate Uc_RenewalHoldForCBNoticeReview_TC0001_SLA_REN_Hold_for_CB_Notice_Approved_Waiver_YES() {
		return Karate.run("classpath:karate/UseCases/Uc_RenewalHoldForCBNoticeReview.feature")
				.tags("TC0001_SLA_REN_Hold_for_CB_Notice_Approved_Waiver_YES").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalHoldForCBNoticeReview_TC002_SLA_REN_Hold_for_CB_Notice_Approved_Waiver_NO() {
	return Karate.run("classpath:karate/UseCases/Uc_RenewalHoldForCBNoticeReview.feature")
			.tags("TC002_SLA_REN_Hold_for_CB_Notice_Approved_Waiver_NO").karateEnv(env);
	}	
	
	//@Karate.Test
	Karate Uc_RenewalHoldForCBNoticeReview_TC0003_SLA_REN_Hold_for_CB_Notice_Disapproved_Cause_Select_Reason() {
	return Karate.run("classpath:karate/UseCases/Uc_RenewalHoldForCBNoticeReview.feature")
			.tags("TC0003_SLA_REN_Hold_for_CB_Notice_Disapproved_Cause_Select_Reason").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalHoldForCBNoticeReview_TC0003_SLA_REN_Hold_for_CB_Notice_Disapproved_FTC_Select_Reason() {
	return Karate.run("classpath:karate/UseCases/Uc_RenewalHoldForCBNoticeReview.feature")
			.tags("TC0003_SLA_REN_Hold_for_CB_Notice_Disapproved_FTC_Select_Reason").karateEnv(env);
	}	
	
	//@Karate.Test
	Karate Uc_RenewalHoldForCBNoticeReview_TC0004_SLA_REN_Hold_for_CB_Notice_Disapprove_to_counsel_Cause() {
	return Karate.run("classpath:karate/UseCases/Uc_RenewalHoldForCBNoticeReview.feature")
			.tags("TC0004_SLA_REN_Hold_for_CB_Notice_Disapprove_to_counsel_Cause").karateEnv(env);
	}	
	
	//@Karate.Test
	Karate Uc_RenewalHoldForCBNoticeReview_TC0004a_SLA_REN_Hold_for_CB_Notice_Disapprove_to_Counsel_FTC() {
	return Karate.run("classpath:karate/UseCases/Uc_RenewalHoldForCBNoticeReview.feature")
			.tags("TC0004a_SLA_REN_Hold_for_CB_Notice_Disapprove_to_Counsel_FTC").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalHoldForCBNoticeReview_TC0005_SLA_REN_Hold_for_CB_Notice_Approved_RefertoCounsel_Waiver_YES() {
	return Karate.run("classpath:karate/UseCases/Uc_RenewalHoldForCBNoticeReview.feature")
			.tags("TC0005_SLA_REN_Hold_for_CB_Notice_Approved_RefertoCounsel_Waiver_YES").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalHoldForCBNoticeReview_TC0006_SLA_REN_Hold_for_CB_Notice_Approved_RefertoCounsel_Waiver_NO() {
	return Karate.run("classpath:karate/UseCases/Uc_RenewalHoldForCBNoticeReview.feature")
			.tags("TC0006_SLA_REN_Hold_for_CB_Notice_Approved_RefertoCounsel_Waiver_NO").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalHoldForCBNoticeReview_TC0007_SLA_REN_Hold_for_CB_Notice_Review_Current_CBNotice_Date_greater_30_days() {
	return Karate.run("classpath:karate/UseCases/Uc_RenewalHoldForCBNoticeReview.feature")
			.tags("TC0007_SLA_REN_Hold_for_CB_Notice_Review_Current_CBNotice_Date_greater_30_days").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalHoldForCBNoticeReview_TC0008_SLA_REN_Hold_for_CB_Notice_Review_Current_CBNotice_Date_greater_30_days_safekeeping() {
	return Karate.run("classpath:karate/UseCases/Uc_RenewalHoldForCBNoticeReview.feature")
			.tags("TC0008_SLA_REN_Hold_for_CB_Notice_Review_Current_CBNotice_Date_greater_30_days_safekeeping").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalHoldForCBNoticeReview_TC0009_SLA_REN_Hold_for_CB_Notice_Review_Current_CBNotice_Date_greater_30_days_Provision() {
	return Karate.run("classpath:karate/UseCases/Uc_RenewalHoldForCBNoticeReview.feature")
			.tags("TC0009_SLA_REN_Hold_for_CB_Notice_Review_Current_CBNotice_Date_greater_30_days_Provision").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalHoldForCBNoticeReview_TC010_SLA_REN_Hold_for_CB_Notice_Review_Current_CBNotice_Date_greater_30_days_safekeeping_provisions_defined() {
	return Karate.run("classpath:karate/UseCases/Uc_RenewalHoldForCBNoticeReview.feature")
			.tags("TC010_SLA_REN_Hold_for_CB_Notice_Review_Current_CBNotice_Date_greater_30_days_safekeeping_provisions_defined").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalHoldForCBNoticeReview_TC0011_SLA_REN_Hold_for_CB_Notice_Approved_Safekeeping_YES() {
	return Karate.run("classpath:karate/UseCases/Uc_RenewalHoldForCBNoticeReview.feature")
			.tags("TC0011_SLA_REN_Hold_for_CB_Notice_Approved_Safekeeping_YES").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalHoldForCBNoticeReview_TC0012_SLA_REN_Hold_for_CB_Notice_Approved_Provision_YES() {
	return Karate.run("classpath:karate/UseCases/Uc_RenewalHoldForCBNoticeReview.feature")
			.tags("TC0012_SLA_REN_Hold_for_CB_Notice_Approved_Provision_YES").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalHoldForCBNoticeReview_TC0013_SLA_REN_Hold_for_CB_Notice_Approved_Safekeeping_Provision_YES() {
	return Karate.run("classpath:karate/UseCases/Uc_RenewalHoldForCBNoticeReview.feature")
			.tags("TC0013_SLA_REN_Hold_for_CB_Notice_Approved_Safekeeping_Provision_YES").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalHoldForCBNoticeReview_TC0014_SLA_REN_Hold_for_CB_Notice_Approved_Safekeeping_RefertoCounsel_YES() {
	return Karate.run("classpath:karate/UseCases/Uc_RenewalHoldForCBNoticeReview.feature")
			.tags("TC0014_SLA_REN_Hold_for_CB_Notice_Approved_Safekeeping_RefertoCounsel_YES").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalHoldForCBNoticeReview_TC0015_SLA_REN_Hold_for_CB_Notice_Approved_Provision_RefertoCounsel_YES() {
	return Karate.run("classpath:karate/UseCases/Uc_RenewalHoldForCBNoticeReview.feature")
			.tags("TC0015_SLA_REN_Hold_for_CB_Notice_Approved_Provision_RefertoCounsel_YES").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalHoldForCBNoticeReview_TC0016_SLA_REN_Hold_for_CB_Notice_Approved_Safekeeping_Provision_RefertoCounsel_YES() {
	return Karate.run("classpath:karate/UseCases/Uc_RenewalHoldForCBNoticeReview.feature")
			.tags("TC0016_SLA_REN_Hold_for_CB_Notice_Approved_Safekeeping_Provision_RefertoCounsel_YES").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalHoldForCBNoticeReview_TC0019_SLA_REN_Hold_for_CB_Notice_Disapproved_Download_letter_Cause() {
	return Karate.run("classpath:karate/UseCases/Uc_RenewalHoldForCBNoticeReview.feature")
			.tags("TC0019_SLA_REN_Hold_for_CB_Notice_Disapproved_Download_letter_Cause").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalHoldForCBNoticeReview_TC0019a_SLA_REN_Hold_for_CB_Notice_Disapproved_Download_letter_FTC() {
	return Karate.run("classpath:karate/UseCases/Uc_RenewalHoldForCBNoticeReview.feature")
			.tags("TC0019a_SLA_REN_Hold_for_CB_Notice_Disapproved_Download_letter_FTC").karateEnv(env);
	}
	
//////////////////Renewal_Change_Priority/////////////////	
	
	//@Karate.Test
	Karate Uc_RenewalChangePriority_TC0001_SLA_REN_Change_Priority_of_a_Renewal_Application_Automatically_License() {
	return Karate.run("classpath:karate/UseCases/Uc_RenewalChangePriority.feature")
			.tags("TC0001_SLA_REN_Change_Priority_of_a_Renewal_Application_Automatically_License").karateEnv(env);
	}

	//@Karate.Test
	Karate Uc_RenewalChangePriority_TC0001_SLA_REN_Change_Priority_of_a_Renewal_Application_Automatically_Permit() {
	return Karate.run("classpath:karate/UseCases/Uc_RenewalChangePriority.feature")
			.tags("TC0001_SLA_REN_Change_Priority_of_a_Renewal_Application_Automatically_Permit").karateEnv(env);
	}
	
////////////////////Renewal_Alert_For_CORP_LLC///////////////////////
	
	//@Karate.Test
	Karate Uc_RenewalAlertForCORP_LLC_TC0001_SLA_REN_Send_Alert_for_Corp_LLC_Dissolved_License() {
	return Karate.run("classpath:karate/UseCases/Uc_RenewalAlertForCORP_LLC.feature")
			.tags("TC0001_SLA_REN_Send_Alert_for_Corp_LLC_Dissolved_License").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalAlertForCORP_LLC_TC0001_SLA_REN_Send_Alert_for_Corp_LLC_Dissolved_Permit() {
	return Karate.run("classpath:karate/UseCases/Uc_RenewalAlertForCORP_LLC.feature")
			.tags("TC0001_SLA_REN_Send_Alert_for_Corp_LLC_Dissolved_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalAlertForCORP_LLC_TC0001a_SLA_REN_Send_Alert_for_Corp_LLC_Dissolved_NO_License() {
	return Karate.run("classpath:karate/UseCases/Uc_RenewalAlertForCORP_LLC.feature")
			.tags("TC0001a_SLA_REN_Send_Alert_for_Corp_LLC_Dissolved_NO_License").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_RenewalAlertForCORP_LLC_TC0001a_SLA_REN_Send_Alert_for_Corp_LLC_Dissolved_No_Permit() {
	return Karate.run("classpath:karate/UseCases/Uc_RenewalAlertForCORP_LLC.feature")
			.tags("TC0001a_SLA_REN_Send_Alert_for_Corp_LLC_Dissolved_No_Permit").karateEnv(env);
	}
	
////////////////////Renewal_Alert_For_Worker_Comp_Lapse///////////////////////////
	
	//@Karate.Test
	Karate Uc_RenewalAlertForWorkerCompLapse_TC0001_SLA_REN_Send_Alert_for_Workers_Comp_Lapse() {
	return Karate.run("classpath:karate/UseCases/Uc_RenewalAlertForWorkerCompLapse.feature")
			.tags("TC0001_SLA_REN_Send_Alert_for_Workers_Comp_Lapse").karateEnv(env);
	}
	
	
/////////////////////////Uc_Renewal_LBDecision///////////////////	
	
	//@Karate.Test
	Karate TC0002A_SLA_REN_Examiner_to_LB_review_Common_Digest_Permit() {
	return Karate.run("classpath:karate/UseCases/Uc_Renewal_LBDecision.feature")
			.tags("TC0002A_SLA_REN_Examiner_to_LB_review_Common_Digest_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0002A_SLA_REN_Examiner_to_LB_review_On_Premises_Digest() {
	return Karate.run("classpath:karate/UseCases/Uc_Renewal_LBDecision.feature")
			.tags("TC0002A_SLA_REN_Examiner_to_LB_review_On_Premises_Digest").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0002A_SLA_REN_LB_review_Common() {
	return Karate.run("classpath:karate/UseCases/Uc_Renewal_LBDecision.feature")
			.tags("TC0002A_SLA_REN_LB_review_Common").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0001_SLA_REN_LB_Decision_Approve() {
	return Karate.run("classpath:karate/UseCases/Uc_Renewal_LBDecision.feature")
			.tags("TC0001_SLA_REN_LB_Decision_Approve").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0002_SLA_REN_LB_Decision_Approve_Define_Provisions_Removal() {
	return Karate.run("classpath:karate/UseCases/Uc_Renewal_LBDecision.feature")
			.tags("TC0002_SLA_REN_LB_Decision_Approve_Define_Provisions_Removal").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0003_SLA_REN_LB_Decision_Approve_Define_Provisions_CorporateChange() {
	return Karate.run("classpath:karate/UseCases/Uc_Renewal_LBDecision.feature")
			.tags("TC0003_SLA_REN_LB_Decision_Approve_Define_Provisions_CorporateChange").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0004_SLA_REN_LB_Decision_Approve_Define_Provisions_Alteration() {
	return Karate.run("classpath:karate/UseCases/Uc_Renewal_LBDecision.feature")
			.tags("TC0004_SLA_REN_LB_Decision_Approve_Define_Provisions_Alteration").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0005_SLA_REN_LB_Decision_Approve_Define_Provisions_Endorsement() {
	return Karate.run("classpath:karate/UseCases/Uc_Renewal_LBDecision.feature")
			.tags("TC0005_SLA_REN_LB_Decision_Approve_Define_Provisions_Endorsement").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0006_SLA_REN_LB_Decision_Approve_Safekeeping() {
	return Karate.run("classpath:karate/UseCases/Uc_Renewal_LBDecision.feature")
	.tags("TC0006_SLA_REN_LB_Decision_Approve_Safekeeping").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0007_SLA_REN_LB_Decision_Approve_Safekeeping_Define_Provisions_Removal() {
	return Karate.run("classpath:karate/UseCases/Uc_Renewal_LBDecision.feature")
			.tags("TC0007_SLA_REN_LB_Decision_Approve_Safekeeping_Define_Provisions_Removal").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0008_SLA_REN_LB_Decision_Approve_Safekeeping_Define_Provisions_CorporateChange() {
	return Karate.run("classpath:karate/UseCases/Uc_Renewal_LBDecision.feature")
			.tags("TC0008_SLA_REN_LB_Decision_Approve_Safekeeping_Define_Provisions_CorporateChange").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0009_SLA_REN_LB_Decision_Approve_Safekeeping_Define_Provisions_Alteration() {
	return Karate.run("classpath:karate/UseCases/Uc_Renewal_LBDecision.feature")
			.tags("TC0009_SLA_REN_LB_Decision_Approve_Safekeeping_Define_Provisions_Alteration").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0010_SLA_REN_LB_Decision_Approve_Safekeeping_Define_Provisions_Endorsement() {
	return Karate.run("classpath:karate/UseCases/Uc_Renewal_LBDecision.feature")
			.tags("TC0010_SLA_REN_LB_Decision_Approve_Safekeeping_Define_Provisions_Endorsement").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0011_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice() {
	return Karate.run("classpath:karate/UseCases/Uc_Renewal_LBDecision.feature")
			.tags("TC0011_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0012_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_defineProvisions_Removal() {
	return Karate.run("classpath:karate/UseCases/Uc_Renewal_LBDecision.feature")
			.tags("TC0012_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_defineProvisions_Removal").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0013_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_defineProvisions_CorporateChange() {
	return Karate.run("classpath:karate/UseCases/Uc_Renewal_LBDecision.feature")
			.tags("TC0013_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_defineProvisions_CorporateChange").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0014_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_defineProvisions_Alteration() {
	return Karate.run("classpath:karate/UseCases/Uc_Renewal_LBDecision.feature")
			.tags("TC0014_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_defineProvisions_Alteration").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0015_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_defineProvisions_Endorsement() {
	return Karate.run("classpath:karate/UseCases/Uc_Renewal_LBDecision.feature")
			.tags("TC0015_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_defineProvisions_Endorsement").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0016_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_Safekeeping() {
	return Karate.run("classpath:karate/UseCases/Uc_Renewal_LBDecision.feature")
			.tags("TC0016_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_Safekeeping").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0017_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_Safekeeping_DefineProvisions_Removal() {
	return Karate.run("classpath:karate/UseCases/Uc_Renewal_LBDecision.feature")
			.tags("TC0017_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_Safekeeping_DefineProvisions_Removal").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0018_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_Safekeeping_DefineProvisions_CorporateChange() {
	return Karate.run("classpath:karate/UseCases/Uc_Renewal_LBDecision.feature")
			.tags("TC0018_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_Safekeeping_DefineProvisions_CorporateChange").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0019_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_Safekeeping_DefineProvisions_Alteration() {
	return Karate.run("classpath:karate/UseCases/Uc_Renewal_LBDecision.feature")
			.tags("TC0019_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_Safekeeping_DefineProvisions_Alteration").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0020_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_Safekeeping_DefineProvisions_Endorsement() {
	return Karate.run("classpath:karate/UseCases/Uc_Renewal_LBDecision.feature")
			.tags("TC0020_SLA_REN_LB_Decision_Approve_Referto_CounselsOffice_Safekeeping_DefineProvisions_Endorsement").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0021_SLA_REN_LB_Decision_Approved_HoldforCBNotice() {
	return Karate.run("classpath:karate/UseCases/Uc_Renewal_LBDecision.feature")
			.tags("TC0021_SLA_REN_LB_Decision_Approved_HoldforCBNotice").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0022_SLA_REN_LB_Decision_Approved_HoldforCBNotice_defineProvisions_Removal() {
	return Karate.run("classpath:karate/UseCases/Uc_Renewal_LBDecision.feature")
			.tags("TC0022_SLA_REN_LB_Decision_Approved_HoldforCBNotice_defineProvisions_Removal").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0023_SLA_REN_LB_Decision_Approved_HoldforCBNotice_defineProvisions_CorporateChange() {
	return Karate.run("classpath:karate/UseCases/Uc_Renewal_LBDecision.feature")
			.tags("TC0023_SLA_REN_LB_Decision_Approved_HoldforCBNotice_defineProvisions_CorporateChange").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0024_SLA_REN_LB_Decision_Approved_HoldforCBNotice_defineProvisions_Alteration() {
	return Karate.run("classpath:karate/UseCases/Uc_Renewal_LBDecision.feature")
			.tags("TC0024_SLA_REN_LB_Decision_Approved_HoldforCBNotice_defineProvisions_Alteration").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0025_SLA_REN_LB_Decision_Approved_HoldforCBNotice_defineProvisions_Endorsement() {
	return Karate.run("classpath:karate/UseCases/Uc_Renewal_LBDecision.feature")
			.tags("TC0025_SLA_REN_LB_Decision_Approved_HoldforCBNotice_defineProvisions_Endorsement").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0026_SLA_REN_LB_Decision_Approved_HoldforCBNotice_safekeeping() {
	return Karate.run("classpath:karate/UseCases/Uc_Renewal_LBDecision.feature")
			.tags("TC0026_SLA_REN_LB_Decision_Approved_HoldforCBNotice_safekeeping").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0027_SLA_REN_LB_Decision_Approved_HoldforCBNotice_safekeeping_DefineProvisions_Removal() {
	return Karate.run("classpath:karate/UseCases/Uc_Renewal_LBDecision.feature")
			.tags("TC0027_SLA_REN_LB_Decision_Approved_HoldforCBNotice_safekeeping_DefineProvisions_Removal").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0028_SLA_REN_LB_Decision_Approved_HoldforCBNotice_safekeeping_DefineProvisions_CorporateChange() {
	return Karate.run("classpath:karate/UseCases/Uc_Renewal_LBDecision.feature")
			.tags("TC0028_SLA_REN_LB_Decision_Approved_HoldforCBNotice_safekeeping_DefineProvisions_CorporateChange").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0029_SLA_REN_LB_Decision_Approved_HoldforCBNotice_safekeeping_DefineProvisions_Alteration() {
	return Karate.run("classpath:karate/UseCases/Uc_Renewal_LBDecision.feature")
			.tags("TC0029_SLA_REN_LB_Decision_Approved_HoldforCBNotice_safekeeping_DefineProvisions_Alteration").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0030_SLA_REN_LB_Decision_Approved_HoldforCBNotice_safekeeping_DefineProvisions_Endorsement() {
	return Karate.run("classpath:karate/UseCases/Uc_Renewal_LBDecision.feature")
			.tags("TC0030_SLA_REN_LB_Decision_Approved_HoldforCBNotice_safekeeping_DefineProvisions_Endorsement").karateEnv(env);
	}
	
/////////////////UC_Renewal_FBPT_Review///////////////////		

	//@Karate.Test
	Karate UC_RenewalFBPT_Review1() {
	return Karate.run("classpath:karate/UseCases/UC_Renewal_FBPT_Review.feature")
	    .tags("TC0001_SLA_REN_FBPT_Review_Redirect_for_LB_Decision").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_RenewalFBPT_Review2() {
	return Karate.run("classpath:karate/UseCases/UC_Renewal_FBPT_Review.feature")
	    .tags("TC0002_SLA_REN_FBPT_Review_Additional_Information_Required").karateEnv(env);
	}
/////////////////UC_Renewal_Alert_For_Workers_Comp///////////////////		

     //@Karate.Test
     Karate UC_RenewalAlertForWorkersComp() {
     return Karate.run("classpath:karate/UseCases/Uc_RenewalAlertForWorkerCompLapse.feature")
          .tags("TC0001_SLA_REN_Send_Alert_for_Workers_Comp_Lapse").karateEnv(env);
     }
	
////////////////Recon_Process_By_Clerical//////////////////////////
	
	//@Karate.Test
	Karate Uc_ReconProcessByClerical_TC0001_SLA_RCN_Process_Recon_request_clerical_failure_to_Comply() {
	return Karate.run("classpath:karate/UseCases/Uc_ReconProcessByClerical.feature")
			.tags("TC0001_SLA_RCN_Process_Recon_request_clerical_failure_to_Comply").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_ReconProcessByClerical_TC0002_SLA_RCN_Process_Recon_request_Clerical_disapproved_for_Cause() {
	return Karate.run("classpath:karate/UseCases/Uc_ReconProcessByClerical.feature")
			.tags("TC0002_SLA_RCN_Process_Recon_request_Clerical_disapproved_for_Cause").karateEnv(env);
	}
	
////////////////////////Recon_Review_By_Examiner////////////////////////
	
	//@Karate.Test
	Karate Uc_ReconReviewByExaminer_TC0001_SLA_RCN_Review_Recon_request_Examiner_Grant() {
	return Karate.run("classpath:karate/UseCases/Uc_ReconReviewByExaminer.feature")
			.tags("TC0001_SLA_RCN_Review_Recon_request_Examiner_Grant").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_ReconReviewByExaminer_TC0001a_SLA_RCN_Review_Recon_request_Examiner_Grant() {
	return Karate.run("classpath:karate/UseCases/Uc_ReconReviewByExaminer.feature")
			.tags("TC0001a_SLA_RCN_Review_Recon_request_Examiner_Grant").karateEnv(env);
	}
	
	//@Karate.Test
	Karate Uc_ReconReviewByExaminer_TC0002_SLA_RCN_Review_Recon_request_Examiner_Deny() {
	return Karate.run("classpath:karate/UseCases/Uc_ReconReviewByExaminer.feature")
			.tags("TC0002_SLA_RCN_Review_Recon_request_Examiner_Deny").karateEnv(env);
	}
	
//////////Amendment_ChangePriority/////////////
	
	//@Karate.Test
	Karate TC0001_NYC_SLA_LIC_AMD_Update_Priority_Automatically_For_License() {
		return Karate.run("classpath:karate/UseCases/UC_Amendment_ChangePriority.feature")
				.tags("TC0001_NYC_SLA_LIC_AMD_Update_Priority_Automatically_For_License").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0002_NYC_SLA_LIC_AMD_Do_Not_Update_Priority_Automatically_For_License() {
		return Karate.run("classpath:karate/UseCases/UC_Amendment_ChangePriority.feature")
				.tags("TC0002_NYC_SLA_LIC_AMD_Do_Not_Update_Priority_Automatically_For_License").karateEnv(env);
	}
			
	//@Karate.Test
	Karate TC0003_NYC_SLA_LIC_AMD_NOT_APPLICABLE_Update_Priority_For_Alteration_Amendment() {
		return Karate.run("classpath:karate/UseCases/UC_Amendment_ChangePriority.feature")
				.tags("TC0003_NYC_SLA_LIC_AMD_NOT_APPLICABLE_Update_Priority_For_Alteration_Amendment").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0004_NYC_SLA_LIC_AMD_Update_Priority_For_Corporate_Change() {
	return Karate.run("classpath:karate/UseCases/UC_Amendment_ChangePriority.feature")
		.tags("TC0004_NYC_SLA_LIC_AMD_Update_Priority_For_Corporate_Change").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0005_NYC_SLA_LIC_AMD_Do_Not_Update_Priority_For_Corporate_Change() {
	return Karate.run("classpath:karate/UseCases/UC_Amendment_ChangePriority.feature")
		.tags("TC0005_NYC_SLA_LIC_AMD_Do_Not_Update_Priority_For_Corporate_Change").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0006_NYC_SLA_LIC_AMD_Update_Priority_For_Endorsement() {
	return Karate.run("classpath:karate/UseCases/UC_Amendment_ChangePriority.feature")
		.tags("TC0006_NYC_SLA_LIC_AMD_Update_Priority_For_Endorsement").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0007_NYC_SLA_LIC_AMD_Do_Not_Update_Priority_For_Endorsement() {
	return Karate.run("classpath:karate/UseCases/UC_Amendment_ChangePriority.feature")
		.tags("TC0007_NYC_SLA_LIC_AMD_Do_Not_Update_Priority_For_Endorsement").karateEnv(env);
	}
	
//////////Amendment_Due_Date_Extension/////////////
	
	//@Karate.Test
	Karate UC_Amendment_Due_Date_1() {
		return Karate.run("classpath:karate/UseCases/UC_Amendment_Due_Date_Extension.feature")
				.tags("TC0001_NYC_SLA_LIC_AMD_Due_Date_Extension_Approved_For_Respond_Deficiencies").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_Amendment_Due_Date_2() {
		return Karate.run("classpath:karate/UseCases/UC_Amendment_Due_Date_Extension.feature")
				.tags("TC0002_NYC_SLA_LIC_AMD_Due_Date_Extension_Approved_For_Failed_Payment").karateEnv(env);
	}
			
	//@Karate.Test
	Karate UC_Amendment_Due_Date_3() {
		return Karate.run("classpath:karate/UseCases/UC_Amendment_Due_Date_Extension.feature")
				.tags("TC0003_NYC_SLA_LIC_AMD_Due_Date_Extension_Approved_For_Conditions").karateEnv(env);
	}
	
/////// Amendment_FBPT ///////////////////
	
	//@Karate.Test
	Karate UC_Amendment_FBPT1() {
		return Karate.run("classpath:karate/UseCases/UC_Amendments_FBPT.feature")
				.tags("TC0001_NYC_SLA_LIC_AMD_FBPT_Redirects_For_LB_Decision").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_Amendment_FBPT2() {
		return Karate.run("classpath:karate/UseCases/UC_Amendments_FBPT.feature")
				.tags("TC0001b_NYC_SLA_LIC_AMD_Examiner_MethodOfOperation_DigestTab").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_Amendment_FBPT3() {
		return Karate.run("classpath:karate/UseCases/UC_Amendments_FBPT.feature")
				.tags("TC0001c_NYC_SLA_LIC_AMD_Examiner_Alteration_DigestTab").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_Amendment_FBPT4() {
		return Karate.run("classpath:karate/UseCases/UC_Amendments_FBPT.feature")
				.tags("TC0001d_NYC_SLA_LIC_AMD_Examiner_CorporateChange_DigestTab").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_Amendment_FBPT5() {
		return Karate.run("classpath:karate/UseCases/UC_Amendments_FBPT.feature")
				.tags("TC0001e_NYC_SLA_LIC_AMD_Examiner_Endorsement_DigestTab").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_Amendment_FBPT6() {
		return Karate.run("classpath:karate/UseCases/UC_Amendments_FBPT.feature")
				.tags("TC0003_NYC_SLA_LIC_AMD_Examiner_Sends_Application_For_FBPT_Review").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_Amendment_FBPT7() {
		return Karate.run("classpath:karate/UseCases/UC_Amendments_FBPT.feature")
				.tags("TC0004_NYC_SLA_LIC_AMD_Define_DeficienciesAndSend_Deficiency_Letter").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_Amendment_FBPT8() {
		return Karate.run("classpath:karate/UseCases/UC_Amendments_FBPT.feature")
				.tags("TC0005_NYC_SLA_LIC_AMD_Add_Multiple_Deficiencies").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_Amendment_FBPT9() {
		return Karate.run("classpath:karate/UseCases/UC_Amendments_FBPT.feature")
				.tags("TC0017_NYC_SLA_LIC_AMD_Highly_Deficient").karateEnv(env);
	}
	
////////////////Intake_Permits ///////////////////
	
	//@Karate.Test
	Karate UC_AssociatedPermits_IntakePermits_1() {
		return Karate.run("classpath:karate/UseCases/UC91_Intake_Permits.feature")
				.tags("TC0001_SLA_PER_Intake_Associated_Permit_Submit_Successfully").karateEnv(env);
	}
		
	//@Karate.Test
	Karate UC_AssociatedPermits_IntakePermits_2() {
		return Karate.run("classpath:karate/UseCases/UC91_Intake_Permits.feature")
				.tags("TC0001a_SLA_PER_Intake_Temporary_Permit_Submit_Successfully").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_AssociatedPermits_IntakePermits_3() {
		return Karate.run("classpath:karate/UseCases/UC91_Intake_Permits.feature")
				.tags("TC0002_SLA_PER_Intake_Standalone_Permit_submit_Successfully").karateEnv(env);
	}	
	
	//@Karate.Test
	Karate UC_AssociatedPermits_IntakePermits_4() {
		return Karate.run("classpath:karate/UseCases/UC91_Intake_Permits.feature")
				.tags("TC0004_SLA_PER_Intake_Documents_section").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_AssociatedPermits_IntakePermits_5() {
		return Karate.run("classpath:karate/UseCases/UC91_Intake_Permits.feature")
				.tags("TC0006_SLA_PER_Select_Associated_Permit_Valid_legal_name").karateEnv(env);
	}	 
	
	//@Karate.Test
	Karate UC_AssociatedPermits_IntakePermits_6() {
		return Karate.run("classpath:karate/UseCases/UC91_Intake_Permits.feature")
				.tags("TC0007_SLA_PER_Select_Temp_Permit_in_process_main_license").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_AssociatedPermits_IntakePermits_7() {
		return Karate.run("classpath:karate/UseCases/UC91_Intake_Permits.feature")
				.tags("TC0007a_SLA_PER_Select_Temp_Permit_NO_main_license").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_AssociatedPermits_IntakePermits_11() {
		return Karate.run("classpath:karate/UseCases/UC91_Intake_Permits.feature")
				.tags("TC0008_SLA_PER_Select_multiple_Temp_Permit_in_process_main_license").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_AssociatedPermits_IntakePermits_8() {
		return Karate.run("classpath:karate/UseCases/UC91_Intake_Permits.feature")
				.tags("TC0009_SLA_PER_Select_Not_qualified_Associated_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_AssociatedPermits_IntakePermits_9() {
		return Karate.run("classpath:karate/UseCases/UC91_Intake_Permits.feature")
				.tags("TC0014_SLA_PER_Select_Standalone_Permit_Valid_approved_License_ID_Legalname").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_AssociatedPermits_IntakePermits_10() {
		return Karate.run("classpath:karate/UseCases/UC91_Intake_Permits.feature")
				.tags("TC0015_SLA_PER_Select_Trucking_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_AssociatedPermits_IntakePermits_12() {
		return Karate.run("classpath:karate/UseCases/UC91_Intake_Permits.feature")
				.tags("TC0016_SLA_PER_Select_Multiple_Standalone_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_AssociatedPermits_IntakePermits_13() {
		return Karate.run("classpath:karate/UseCases/UC91_Intake_Permits.feature")
				.tags("TC0017_SLA_PER_Select_Not_Qualified_Standalone_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_AssociatedPermits_IntakePermits_14() {
		return Karate.run("classpath:karate/UseCases/UC91_Intake_Permits.feature")
				.tags("TC0018_SLA_PER_Select_Not_Qualified_Temporary_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_AssociatedPermits_IntakePermits_15() {
		return Karate.run("classpath:karate/UseCases/UC91_Intake_Permits.feature")
				.tags("TC0019_SLA_PER_Select_Liquidator_Permit_Buyer_License").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_AssociatedPermits_IntakePermits_16() {
		return Karate.run("classpath:karate/UseCases/UC91_Intake_Permits.feature")
				.tags("TC0019_SLA_PER_Select_Main_License_Permit").karateEnv(env);
	}	
	
//////// IntakeFee_Permit ///////////////////
	
	
	//@Karate.Test
	Karate UC_PermitIntakeFees1() {
		return Karate.run("classpath:karate/UseCases/UC_IntakeFee_Permit.feature")
				.tags("TC0002_SLA_PER_Intake_Fees_Single_Check_Payment_Details_grid").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_PermitIntakeFees2() {
		return Karate.run("classpath:karate/UseCases/UC_IntakeFee_Permit.feature")
				.tags("TC0003_SLA_PER_Intake_Fees_Multiple_Check_Payment_Details_Grid").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_PermitIntakeFees3() {
		return Karate.run("classpath:karate/UseCases/UC_IntakeFee_Permit.feature")
				.tags("TC0004_SLA_PER_Intake_Fees_Bond_Information_grid_Check_Payment_Details_Grid").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_PermitIntakeFees4() {
		return Karate.run("classpath:karate/UseCases/UC_IntakeFee_Permit.feature")
				.tags("TC0006_SLA_PER_Intake_Fees_Apply_Payment_to_Single_Application").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_PermitIntakeFees5() {
		return Karate.run("classpath:karate/UseCases/UC_IntakeFee_Permit.feature")
				.tags("TC0006a_SLA_PER_Intake_Fees_Edit_added_check_Information_grid").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_PermitIntakeFees6() {
		return Karate.run("classpath:karate/UseCases/UC_IntakeFee_Permit.feature")
				.tags("TC0009_SLA_PER_Intake_Fees_Underpayment_Disapproved_TDD").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_PermitIntakeFees7() {
		return Karate.run("classpath:karate/UseCases/UC_IntakeFee_Permit.feature")
				.tags("TC0015_SLA_PER_Intake_Fees_Underpayment").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_PermitIntakeFees8() {
		return Karate.run("classpath:karate/UseCases/UC_IntakeFee_Permit.feature")
				.tags("TC0015_SLA_PER_Intake_Fees_Underpayment_Not_Qualified").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_PermitIntakeFees9() {
		return Karate.run("classpath:karate/UseCases/UC_IntakeFee_Permit.feature")
				.tags("TC0016_SLA_PER_Intake_Fees_Over_Payment").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_PermitIntakeFees10() {
		return Karate.run("classpath:karate/UseCases/UC_IntakeFee_Permit.feature")
				.tags("TC0017_SLA_PER_Intake_Fees_Waived_Fee").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_PermitIntakeFees11() {
		return Karate.run("classpath:karate/UseCases/UC_IntakeFee_Permit.feature")
				.tags("TC0018_SLA_PER_Intake_Fees_Caterers").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_PermitIntakeFees12() {
		return Karate.run("classpath:karate/UseCases/UC_IntakeFee_Permit.feature")
				.tags("TC0018_SLA_PER_Intake_Fees_Temporary_Beer_and_Wine").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_PermitIntakeFees13() {
		return Karate.run("classpath:karate/UseCases/UC_IntakeFee_Permit.feature")
				.tags("TC0019_SLA_PER_Intake_Fees_Multiple_Trucking_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_PermitIntakeFees14() {
		return Karate.run("classpath:karate/UseCases/UC_IntakeFee_Permit.feature")
				.tags("TC0018_SLA_PER_Intake_Fees_Temporary_Permit_Intake_with_Main_license").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_PermitIntakeFees15() {
		return Karate.run("classpath:karate/UseCases/UC_IntakeFee_Permit.feature")
				.tags("TC0018_SLA_PER_Intake_Fees_Temporary_Permit_Intake_without_Main_license").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_PermitIntakeFees16() {
		return Karate.run("classpath:karate/UseCases/UC_IntakeFee_Permit.feature")
			.tags("TC0018_SLA_PER_Intake_Fees_Temporary_Permit_link_to_new_Main_license_intake").karateEnv(env);
	}
	
//////////////////////Surrender_Intake//////////////////////
	
	
	//@Karate.Test
	Karate UC_SurrenderIntake1() {
		return Karate.run("classpath:karate/UseCases/Uc_SurrenderIntake.feature")
				.tags("TC0001_SLA_SUR_Intake_Surrender_Select_Screen_License").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_SurrenderIntake2() {
		return Karate.run("classpath:karate/UseCases/Uc_SurrenderIntake.feature")
				.tags("TC0001a_SLA_SUR_Intake_Form_Surrender").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_SurrenderIntake3() {
		return Karate.run("classpath:karate/UseCases/Uc_SurrenderIntake.feature")
				.tags("TC0002_SLA_SUR_Intake_Surrender_Select_Main_License_Search").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_SurrenderIntake4() {
		return Karate.run("classpath:karate/UseCases/Uc_SurrenderIntake.feature")
				.tags("TC0003_SLA_SUR_Intake_Surrender_Select_Main_License_Permit_Search").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_SurrenderIntake5() {
		return Karate.run("classpath:karate/UseCases/Uc_SurrenderIntake.feature")
				.tags("TC0008_SLA_SUR_Intake_Surrender_Select_Stand_Alone_License_Permit").karateEnv(env);
	}
	
/////////////////Surrender_Review_Application///////////////////	

	//@Karate.Test
	Karate TC0002_SLA_SUR_Review_Surrender_Approve_Main_Licene() {
		return Karate.run("classpath:karate/UseCases/Uc_SurrenderReviewApplication.feature")
				.tags("TC0002_SLA_SUR_Review_Surrender_Approve_Main_Licene").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0003_SLA_SUR_Review_Surrender_Approve_Associated_Permit() {
		return Karate.run("classpath:karate/UseCases/Uc_SurrenderReviewApplication.feature")
				.tags("TC0003_SLA_SUR_Review_Surrender_Approve_Associated_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0004_SLA_SUR_Review_Surrender_Approve_Standalone_Permit() {
		return Karate.run("classpath:karate/UseCases/Uc_SurrenderReviewApplication.feature")
				.tags("TC0004_SLA_SUR_Review_Surrender_Approve_Standalone_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0005_SLA_SUR_Review_Surrender_Define_Deficiency_Main_License_Permit() {
		return Karate.run("classpath:karate/UseCases/Uc_SurrenderReviewApplication.feature")
				.tags("TC0005_SLA_SUR_Review_Surrender_Define_Deficiency_Main_License_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0006_SLA_SUR_Review_Surrender_Define_Deficiency_Main_License_Associated_Permit() {
		return Karate.run("classpath:karate/UseCases/Uc_SurrenderReviewApplication.feature")
				.tags("TC0006_SLA_SUR_Review_Surrender_Define_Deficiency_Main_License_Associated_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0007_SLA_SUR_Review_Surrender_Define_Deficiency_Stand_Alone_Permit() {
		return Karate.run("classpath:karate/UseCases/Uc_SurrenderReviewApplication.feature")
				.tags("TC0007_SLA_SUR_Review_Surrender_Define_Deficiency_Stand_Alone_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0008_SLA_SUR_Review_Surrender_Intake_Deficiency_Main_License_Permit() {
		return Karate.run("classpath:karate/UseCases/Uc_SurrenderReviewApplication.feature")
				.tags("TC0008_SLA_SUR_Review_Surrender_Intake_Deficiency_Main_License_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0009_SLA_SUR_Review_Surrender_Intake_Deficiency_Main_License_Associated_Permit() {
		return Karate.run("classpath:karate/UseCases/Uc_SurrenderReviewApplication.feature")
				.tags("TC0009_SLA_SUR_Review_Surrender_Intake_Deficiency_Main_License_Associated_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0010_SLA_SUR_Review_Surrender_Intake_Deficiency_Standalone_Permit() {
		return Karate.run("classpath:karate/UseCases/Uc_SurrenderReviewApplication.feature")
				.tags("TC0010_SLA_SUR_Review_Surrender_Intake_Deficiency_Standalone_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0014_SLA_SUR_Review_Surrender_Intake_Deficiency_Main_License_All_Deficiencies_are_met_NO() {
		return Karate.run("classpath:karate/UseCases/Uc_SurrenderReviewApplication.feature")
				.tags("TC0014_SLA_SUR_Review_Surrender_Intake_Deficiency_Main_License_All_Deficiencies_are_met_NO").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0015_SLA_SUR_Review_Surrender_Intake_Deficiency_Main_License_All_Deficiencies_are_met_Yes() {
		return Karate.run("classpath:karate/UseCases/Uc_SurrenderReviewApplication.feature")
				.tags("TC0015_SLA_SUR_Review_Surrender_Intake_Deficiency_Main_License_All_Deficiencies_are_met_Yes").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0011_SLA_SUR_Review_Surrender_Intake_Deficiency_Standalone_Permit_All_Deficiencies_are_met_NO() {
		return Karate.run("classpath:karate/UseCases/Uc_SurrenderReviewApplication.feature")
				.tags("TC0011_SLA_SUR_Review_Surrender_Intake_Deficiency_Standalone_Permit_All_Deficiencies_are_met_NO").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0012_SLA_SUR_Review_Surrender_Intake_Deficiency_Standalone_Permit_All_Deficiencies_are_met_NO() {
		return Karate.run("classpath:karate/UseCases/Uc_SurrenderReviewApplication.feature")
				.tags("TC0012_SLA_SUR_Review_Surrender_Intake_Deficiency_Standalone_Permit_All_Deficiencies_are_met_NO").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0013_SLA_SUR_Review_Surrender_Intake_Deficiency_Standalone_Permit_All_Deficiencies_are_met_Yes() {
		return Karate.run("classpath:karate/UseCases/Uc_SurrenderReviewApplication.feature")
				.tags("TC0013_SLA_SUR_Review_Surrender_Intake_Deficiency_Standalone_Permit_All_Deficiencies_are_met_Yes").karateEnv(env);
	}

/////////////////PRMT_099_LBDecisions/////////////////
	
	//@Karate.Test
	Karate UC_PermitLBDecision1() {
	    return Karate.run("classpath:karate/UseCases/UC_PRMT_099_LBDecisions.feature")
	        .tags("TC0001_SLA_PER_LB_Approved_Aircraft_Onetime").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_PermitLBDecision2() {
	    return Karate.run("classpath:karate/UseCases/UC_PRMT_099_LBDecisions.feature")
	        .tags("TC0001_SLA_PER_LB_Approved_Liquidator").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_PermitLBDecision3() {
	    return Karate.run("classpath:karate/UseCases/UC_PRMT_099_LBDecisions.feature")
	        .tags("TC0002_SLA_PER_LB_ReasonforDisapproved").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_PermitLBDecision4() {
	    return Karate.run("classpath:karate/UseCases/UC_PRMT_099_LBDecisions.feature")
	        .tags("TC0010_SLA_PER_LB_disapproval_to_counsel_Disapproved_for_Cause").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_PermitLBDecision5() {
	    return Karate.run("classpath:karate/UseCases/UC_PRMT_099_LBDecisions.feature")
	        .tags("TC0011_SLA_PER_LB_Withdrawal_Withdrawal_Requested").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_PermitLBDecision6() {
	    return Karate.run("classpath:karate/UseCases/UC_PRMT_099_LBDecisions.feature")
	        .tags("TC0013_SLA_PERLB_FB_Decision_required").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_PermitLBDecision7() {
    return Karate.run("classpath:karate/UseCases/UC_PRMT_099_LBDecisions.feature")
        .tags("TC0014_SLA_PER_LB_Return_to_an_Examiner").karateEnv(env);
    }
		
//////////////////////PRMT_ReturnCheck/////////////////////////
	
	//@Karate.Test
	Karate UC_PermitReturnCheck1() {
	    return Karate.run("classpath:karate/UseCases/UC_PRMT_ReturnCheck.feature")
	        .tags("TC0001_SLA_PER_Return_Check_Payment_failed_Awaiting_Review").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_PermitReturnCheck2() {
	    return Karate.run("classpath:karate/UseCases/UC_PRMT_ReturnCheck.feature")
	        .tags("TC0002_SLA_REN_Return_Check_Intake_Payment_Awaiting_Additional_Funds").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_PermitReturnCheck3() {
	    return Karate.run("classpath:karate/UseCases/UC_PRMT_ReturnCheck.feature")
	        .tags("TC0004_NYC_SLA_LIC_Insufficient_Funds_received").karateEnv(env);
	}
	
	//@Karate.Test
	Karate UC_PermitReturnCheck4() {
	    return Karate.run("classpath:karate/UseCases/UC_PRMT_ReturnCheck.feature")
	        .tags("TC0010_NYC_SLA_LIC_Intake_New_Payment_Overpayment").karateEnv(env);
	}
	
/////////////////////PRMT_098_Examiner_Review//////////////
	
	//@Karate.Test
	Karate TC0001_SLA_PER_Examiner_Send_to_LB_Review() {
	    return Karate.run("classpath:karate/UseCases/UC_PRMT_098_ExaminerReview.feature")
	        .tags("TC0001_SLA_PER_Examiner_Send_to_LB_Review").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0001a_SLA_PER_Digest_screen() {
	    return Karate.run("classpath:karate/UseCases/UC_PRMT_098_ExaminerReview.feature")
	        .tags("TC0001a_SLA_PER_Digest_screen").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0001c_SLA_PER_Solicitor_Digest_screen() {
	    return Karate.run("classpath:karate/UseCases/UC_PRMT_098_ExaminerReview.feature")
	        .tags("TC0001c_SLA_PER_Solicitor_Digest_screen").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0001e_NYC_SLA_PER__Examiner__Street_Fair_or_Festival_Digest_Tab() {
	    return Karate.run("classpath:karate/UseCases/UC_PRMT_098_ExaminerReview.feature")
	        .tags("@TC0001e_NYC_SLA_PER__Examiner__Street_Fair_or_Festival_Digest_Tab").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0003_SLA_PER_Examiner_toFBPTReview() {
	    return Karate.run("classpath:karate/UseCases/UC_PRMT_098_ExaminerReview.feature")
	        .tags("TC0003_SLA_PER_Examiner_toFBPTReview").karateEnv(env);
	}
	
	//@Karate.Test
    Karate TC0004_SLA_PER_Examiner_DefineDeficiency() {
        return Karate.run("classpath:karate/UseCases/UC_PRMT_098_ExaminerReview.feature")
                .tags("TC0004_SLA_PER_Examiner_DefineDeficiency").karateEnv(env);
    }
	
	//@Karate.Test
    Karate TC0005_SLA_PER_Examiner_Intake_Deficiency() {
        return Karate.run("classpath:karate/UseCases/UC_PRMT_098_ExaminerReview.feature")
                .tags("TC0005_SLA_PER_Examiner_Intake_Deficiency").karateEnv(env);
    }
	
	//@Karate.Test
    Karate TC0006_SLA_PER_Examiner_Review_AllDeficiencies_YES() {
        return Karate.run("classpath:karate/UseCases/UC_PRMT_098_ExaminerReview.feature")
                .tags("TC0006_SLA_PER_Examiner_Review_AllDeficiencies_YES").karateEnv(env);
    }
	
	//@Karate.Test
    Karate TC0006a_SLA_PER_Examiner_Review_Additional_Info_Requested() {
        return Karate.run("classpath:karate/UseCases/UC_PRMT_098_ExaminerReview.feature")
                .tags("TC0006a_SLA_PER_Examiner_Review_Additional_Info_Requested").karateEnv(env);
    }
	
	//@Karate.Test
    Karate TC0007_SLA_PER_Examiner_Review_All_Deficiencies_met_No_Define_YES_Final_YES() {
        return Karate.run("classpath:karate/UseCases/UC_PRMT_098_ExaminerReview.feature")
                .tags("TC0007_SLA_PER_Examiner_Review_All_Deficiencies_met_No_Define_YES_Final_YES").karateEnv(env);
    }
	
	//@Karate.Test
    Karate TC0008_SLA_PER_Examiner_Review_All_Deficiencies_met_NO_Final_deficiency_Checked_before() {
        return Karate.run("classpath:karate/UseCases/UC_PRMT_098_ExaminerReview.feature")
                .tags("TC0008_SLA_PER_Examiner_Review_All_Deficiencies_met_NO_Final_deficiency_Checked_before").karateEnv(env);
    }
	
	//@Karate.Test
    Karate TC0013_SLA_PER_Examiners_Review_Send_PD_Letter_functionality() {
        return Karate.run("classpath:karate/UseCases/UC_PRMT_098_ExaminerReview.feature")
                .tags("TC0013_SLA_PER_Examiners_Review_Send_PD_Letter_functionality").karateEnv(env);
    }
	
	//@Karate.Test
    Karate TC0013_SLA_PER_Examiners_Review_Send_PD_Letter_Define_deficiency() {
        return Karate.run("classpath:karate/UseCases/UC_PRMT_098_ExaminerReview.feature")
                .tags("TC0013_SLA_PER_Examiners_Review_Send_PD_Letter_Define_deficiency").karateEnv(env);
    }
	
	//@Karate.Test
    Karate TC0013_SLA_PER_Examiners_Review_Send_PD_Letter_send_to_FBPT() {
        return Karate.run("classpath:karate/UseCases/UC_PRMT_098_ExaminerReview.feature")
                .tags("TC0013_SLA_PER_Examiners_Review_Send_PD_Letter_send_to_FBPT").karateEnv(env);
    }
	
	//@Karate.Test
    Karate TC0013_SLA_PER_Examiners_Review_Send_PD_Letter_send_to_LB() {
        return Karate.run("classpath:karate/UseCases/UC_PRMT_098_ExaminerReview.feature")
                .tags("TC0013_SLA_PER_Examiners_Review_Send_PD_Letter_send_to_LB").karateEnv(env);
    }
	
	//@Karate.Test
    Karate TC0016_SLA_PER_Examiners_Review_Highly_deficiency_functionality() {
        return Karate.run("classpath:karate/UseCases/UC_PRMT_098_ExaminerReview.feature")
                .tags("TC0016_SLA_PER_Examiners_Review_Highly_deficiency_functionality").karateEnv(env);
    }
    
	//@Karate.Test
    Karate TC0009_SLA_PER_Temp_Per_Pending_200() {
        return Karate.run("classpath:karate/UseCases/UC_PRMT_098_ExaminerReview.feature")
                .tags("TC0009_SLA_PER_Temp_Per_Pending_200").karateEnv(env);
    }
    
    //@Karate.Test
    Karate TC0010_SLA_PER_Temp_Per_Pending_500() {
        return Karate.run("classpath:karate/UseCases/UC_PRMT_098_ExaminerReview.feature")
                .tags("TC0010_SLA_PER_Temp_Per_Pending_500").karateEnv(env);
    }
    
    //@Karate.Test
    Karate TC0011_SLA_PER_Temp_Per_Pending_Full_Board() {
        return Karate.run("classpath:karate/UseCases/UC_PRMT_098_ExaminerReview.feature")
                .tags("TC0011_SLA_PER_Temp_Per_Pending_Full_Board").karateEnv(env);
    }
    
    //@Karate.Test
    Karate TC0002_SLA_PER_Temp_Permit_Disapproval_Cause_Save_Letter() {
        return Karate.run("classpath:karate/UseCases/UC_PRMT_098_ExaminerReview.feature")
                .tags("TC0002_SLA_PER_Temp_Permit_Disapproval_Cause_Save_Letter").karateEnv(env);
    }
    
    //@Karate.Test
    Karate TC0008_SLA_PER_Temp_Permit_Conditionally_Approve_Main_license() {
        return Karate.run("classpath:karate/UseCases/UC_PRMT_098_ExaminerReview.feature")
                .tags("TC0008_SLA_PER_Temp_Permit_Conditionally_Approve_Main_license").karateEnv(env);
    }

/////////////////////PRMT_FBPT_Review//////////////
	
	//@Karate.Test
	Karate TC0001_SLA_PER_FBPT_Additonal_Info_NO_FB_Review_NO() {
	    return Karate.run("classpath:karate/UseCases/UC_PRMT_FBPT_Review.feature")
	        .tags("TC0001_SLA_PER_FBPT_Additonal_Info_NO_FB_Review_NO").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0002_SLA_PER_FBPT_Additonal_Info_YES() {
	    return Karate.run("classpath:karate/UseCases/UC_PRMT_FBPT_Review.feature")
	        .tags("TC0002_SLA_PER_FBPT_Additonal_Info_YES").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0003_SLA_PER_FBPT_Additonal_Info_NO_FB_Review_YES() {
	    return Karate.run("classpath:karate/UseCases/UC_PRMT_FBPT_Review.feature")
	        .tags("TC0003_SLA_PER_FBPT_Additonal_Info_NO_FB_Review_YES").karateEnv(env);
	}
	
///////////////////////PRMT Extend Due Date/////////////////////


	//@Karate.Test
	Karate TC0001_SLA_PER_Due_date_Extension_Approve_Respond_Deficiencies() {
		return Karate.run("classpath:karate/UseCases/UC_PRMT_ExtendDueDate.feature")
				.tags("TC0001_SLA_PER_Due_date_Extension_Approve_Respond_Deficiencies").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0006_NYS_SLA_Failed_Payment_Extension_Approved() {
		return Karate.run("classpath:karate/UseCases/UC_PRMT_ExtendDueDate.feature")
				.tags("TC0006_NYS_SLA_Failed_Payment_Extension_Approved").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0007_NYS_SLA_Deficiency_Due_Date_Extension_Disapproved() {
		return Karate.run("classpath:karate/UseCases/UC_PRMT_ExtendDueDate.feature")
				.tags("TC0007_NYS_SLA_Deficiency_Due_Date_Extension_Disapproved").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0008_NYS_SLA_Failed_Payment_Extension_Disapproved() {
		return Karate.run("classpath:karate/UseCases/UC_PRMT_ExtendDueDate.feature")
				.tags("TC0008_NYS_SLA_Failed_Payment_Extension_Disapproved").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0011_NYS_SLA_Conditions_Due_Date_Extension_Approved() {
		return Karate.run("classpath:karate/UseCases/UC_PRMT_ExtendDueDate.feature")
				.tags("TC0011_NYS_SLA_Conditions_Due_Date_Extension_Approved").karateEnv(env);
	}
	
/////////////////Common Rescind Decision///////////////////////////
	
	//@Karate.Test
	Karate TC0001_SLA_COM_Rescind_Decision_Approved_Main_License_with_associated_Permit() {
		return Karate.run("classpath:karate/UseCases/UC_Common_RescindDecision.feature")
				.tags("TC0001_SLA_COM_Rescind_Decision_Approved_Main_License_with_associated_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0002_SLA_COM_Rescind_Decision_Disapproved_License() {
		return Karate.run("classpath:karate/UseCases/UC_Common_RescindDecision.feature")
				.tags("TC0002_SLA_COM_Rescind_Decision_Disapproved_License").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0003_SLA_COM_Rescind_Decision_Approved_Standalone_Permit() {
		return Karate.run("classpath:karate/UseCases/UC_Common_RescindDecision.feature")
				.tags("TC0003_SLA_COM_Rescind_Decision_Approved_Standalone_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0004_SLA_COM_Rescind_Decision_Disapproved_Standalone_Permit() {
		return Karate.run("classpath:karate/UseCases/UC_Common_RescindDecision.feature")
				.tags("TC0004_SLA_COM_Rescind_Decision_Disapproved_Standalone_Permit").karateEnv(env);
	}
	
	//@Karate.Test
	Karate TC0005_SLA_COM_Send_Application_back_to_Examiner_Approved_application() {
		return Karate.run("classpath:karate/UseCases/UC_Common_RescindDecision.feature")
				.tags("TC0005_SLA_COM_Send_Application_back_to_Examiner_Approved_application").karateEnv(env);
	}
	
	//@Karate.Test
    Karate TC0006_SLA_COM_Send_Application_back_to_Examiner_Disapproved_application() {
        return Karate.run("classpath:karate/UseCases/UC_Common_RescindDecision.feature")
                .tags("TC0006_SLA_COM_Send_Application_back_to_Examiner_Disapproved_application").karateEnv(env);
    }
    
    //@Karate.Test
    Karate TC0007_SLA_COM_Send_Application_back_to_Examiner_Approved_standalone_Permit() {
        return Karate.run("classpath:karate/UseCases/UC_Common_RescindDecision.feature")
                .tags("TC0007_SLA_COM_Send_Application_back_to_Examiner_Approved_standalone_Permit").karateEnv(env);
    }
    
    //@Karate.Test
    Karate TC0008_SLA_COM_Send_Application_back_to_Examiner_Disapproved_standalone_Permit() {
        return Karate.run("classpath:karate/UseCases/UC_Common_RescindDecision.feature")
                .tags("TC0008_SLA_COM_Send_Application_back_to_Examiner_Disapproved_standalone_Permit").karateEnv(env);
    }
    
    ////////////////////////////// Solicitor Permit ///////////////////////////////////////////////
    
    //@Karate.Test
    Karate UC_SolicitorPermits1() {
        return Karate.run("classpath:karate/UseCases/UC_Solicitor'sPermit.feature")
                .tags("TC0001_SLA_SOL_Search_Solicitors_Permit").karateEnv(env);
    }
    
    //@Karate.Test
    Karate UC_SolicitorPermits2() {
        return Karate.run("classpath:karate/UseCases/UC_Solicitor'sPermit.feature")
                .tags("TC0001_SLA_SOL_Solicitor_Verification_Hold").karateEnv(env);
    }
    
    //@Karate.Test
    Karate UC_SolicitorPermits() {
        return Karate.run("classpath:karate/UseCases/SolicitorPermitIntakeToApproval.feature")
                .karateEnv(env);
    }
	//@Karate.Test
	Karate UC_ReferToEnforcement1() {
		return Karate.run("classpath:karate/UseCases/Uc_Common_ReferToEnforcement.feature")
				.tags("TC0001_SLA_COM_RefertoEnforcement_MainLicense_withassociatedPermit")
				.karateEnv(env);
	}
	
	
	
	
	
	
	
	
	
	
	
	
//****************************** Permit Use Cases*********************************//
	 
	 //@Karate.Test
	Karate UC_AssociatedPermits_090_TC0002() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_090_SelectAppType-Permit.feature")
				.tags("TC0002SelectAssociatedPermitvalidapprovedlicenseid").karateEnv(env);
	}
	 
		
	//************************	TC0004AssociatedPermitinvalidlicenseid_Legalname ************************//
	 //@Karate.Test
		Karate UC_AssociatedPermits_090_TC0004a() {
			return Karate.run("classpath:karate/UseCases/UC_LIC_090_SelectAppType-Permit.feature")
					.tags("TC0004aAssociatedPermitinvalidlicenseidLegalname").karateEnv(env);
		}
	 //@Karate.Test
		Karate UC_AssociatedPermits_090_TC0004b() {
			return Karate.run("classpath:karate/UseCases/UC_LIC_090_SelectAppType-Permit.feature")
					.tags("TC0004bAssociatedPermitinvalidlicenseidLegalname").karateEnv(env);
		}
	 
	//************************	TC0004AssociatedPermitinvalidlicenseid_Legalname ************************//
		 

	//@Karate.Test
   Karate UC_AssociatedPermits_090a() {
		return Karate.run("classpath:karate/UseCases/UC90_Select_Application_Type_Permis.feature")
				.tags("TC_0002_IntakeLicensewithoutAssociatedLic").karateEnv(env);	
	}
    
	//@Karate.Test
   Karate UC_AssociatedPermits_090b() {
		return Karate.run("classpath:karate/UseCases/UC90_Select_Application_Type_Permis.feature")
				.tags("PermitAllScenarios").karateEnv(env);	
	}
   
   //Karate.Test
	Karate UC_StandalonePermits_018() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_018_SelectPermitApp.feature")
				.tags("PermitStandaloneScenarios").karateEnv(env);
	}

	//@Karate.Test
	Karate UC_TempPermits_018() {
		return Karate.run("classpath:karate/UseCases/UC_LIC_018_SelectPermitApp.feature").tags("PermitTempScenarios")
				.karateEnv(env);
	}

	//@Karate.Test
	Karate UC_EnforcementCase56() {
		return Karate.run("classpath:karate/UseCases/Uc_ATAP_E2E.feature")
				.tags("TC0009_SLA_ATAP_E2EforRosterApproval")
				.karateEnv(env);
	}	
	//////////////////////////// Counsel ///////////////////////////////////////////////////
	
	//@Karate.Test
	Karate UC_Counse01() {
		return Karate.run("classpath:karate/UseCases/UC_Counsel.feature").tags("TC0001_SLA_COUNSEL_ETE_SS_Review_Licensed_Case_Close_the_case")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_Counse02() {
		return Karate.run("classpath:karate/UseCases/UC_Counsel.feature").tags("TC0002_SLA_COUNSEL_ETE_Attorney_Review_Licensed_Case_Close_the_Case")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_Counse03() {
		return Karate.run("classpath:karate/UseCases/UC_Counsel.feature").tags("TC0003_SLA_COUNSEL_ETE_Attorney_Review_case_Prepare_NOP_NO_Contest_Send_to_Secretary_Office")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_Counse04() {
		return Karate.run("classpath:karate/UseCases/UC_Counsel.feature").tags("TC0004_SLA_COUNSEL_ETE_Attorney_sending_a_case_to_Enforcement")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_Counse05() {
		return Karate.run("classpath:karate/UseCases/UC_Counsel.feature").tags("TC0005_SLA_COUNSEL_ETE_Attorney_request_Additional_info_from_PD")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_Counse06() {
		return Karate.run("classpath:karate/UseCases/UC_Counsel.feature").tags("TC0006_SLA_COUNSEL_ETE_Attorney_Review_NOP_response_Plea_Rejected")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_Counse07() {
		return Karate.run("classpath:karate/UseCases/UC_Counsel.feature").tags("TC0007_SLA_COUNSEL_ETE_Attorney_Review_NOP_schedule_hearing_Adding_witness_Scheduled_Case")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_Counsel08() {
		return Karate.run("classpath:karate/UseCases/UC_Counsel.feature").tags("TC0008_SLA_COUNSEL_ETE_Attorney_Review_NOP_Scheduled_hearing_Send_Enforcement_to_serve_subpoena")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_Counse09() {
		return Karate.run("classpath:karate/UseCases/UC_Counsel.feature").tags("TC0009_SLA_COUNSEL_ETE_Attorney_Review_case_Propose_summary_suspension_Send_case_to_Secretary_Office")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_Counse10() {
		return Karate.run("classpath:karate/UseCases/UC_Counsel.feature").tags("TC0010_SLA_COUNSEL_ETE_Attorney_Post_Hearing_Submissions_for_cases")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_Counse111() {
		return Karate.run("classpath:karate/UseCases/UC_Counsel.feature").tags("TC0011_SLA_COUNSEL_ETE_Attorney_Post_Hearing_Submissions_for_application")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_Counse12() {
		return Karate.run("classpath:karate/UseCases/UC_Counsel.feature").tags("TC0012_SLA_COUNSEL_ETE_AQ_Licensee_recon_request_Attach_recon_Disapproved_by_Full_Board_Send_to_Secretary_Office")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_Counse13() {
		return Karate.run("classpath:karate/UseCases/UC_Counsel.feature").tags("TC0013_SLA_COUNSEL_ETE_AQ_Attach_recon_License_Reconsideration_Chairman_Grant")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_Counse14() {
		return Karate.run("classpath:karate/UseCases/UC_Counsel.feature").tags("TC0014_SLA_COUNSEL_ETE_AQ_Attach_recon_License_Reconsideration_Chairman_Deny")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_Counsel15() {
		return Karate.run("classpath:karate/UseCases/UC_Counsel.feature").tags("TC0015_SLA_COUNSEL_ETE_AQ_Attach_recon_License_Reconsideration_Chairman_Send_to_FB")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_Counsel17() {
		return Karate.run("classpath:karate/UseCases/UC_Counsel.feature").tags("TC0017_SLA_COUNSEL_ETE_AQ_Withdraw_All_Charges_General_Counsel_Approve")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_Counsel18() {
		return Karate.run("classpath:karate/UseCases/UC_Counsel.feature").tags("TC0018_SLA_COUNSEL_ETE_AQ_Withdraw_All_Charges_General_Counsel_Disapprove")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_Counse23() {
		return Karate.run("classpath:karate/UseCases/UC_Counsel.feature").tags("TC0023_SLA_COUNSEL_ETE_Attorney_In_from_licensing_Process_NOP_NO_Contest_Send_to_Secretary_Office")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_Counse24() {
		return Karate.run("classpath:karate/UseCases/UC_Counsel.feature").tags("TC0024_SLA_COUNSEL_ETE_Attorney_In_from_Enforcement_Process_NOP_NO_Contest_Send_to_Secretary_Office")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_Counse25() {
		return Karate.run("classpath:karate/UseCases/UC_Counsel.feature").tags("TC0025_SLA_COUNSEL_ETE_Attorney_In_from_ATAP_Process_NOP_NO_Contest_Send_to_Secretary_Office")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_Counse26() {
		return Karate.run("classpath:karate/UseCases/UC_Counsel.feature").tags("TC0026_SLA_COUNSEL_ETE_Attorney_Review_Application_Schedule_Hearing_Application")
				.karateEnv(env);
	}
	
	////////////////////////////// Enforcement Arrest Notification /////////////////////////////////////////////////
	
	//@Karate.Test
	Karate UC_EnforcementAN1() {
		return Karate.run("classpath:karate/UseCases/UC_Enforcement_Arrest_Of_Licensee_ETE.feature")
				.tags("TC0001_SLA_ENF_ETE_Arrest_of_Licensee_Response_received_by_Support_Staff_Case_Closed")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_EnforcementAN3() {
		return Karate.run("classpath:karate/UseCases/UC_Enforcement_Arrest_Of_Licensee_ETE.feature")
				.tags("TC0003_SLA_ENF_ETE_Arrest_of_Licensee_Response_received_by_Lead_Investigator_referred_to_Counsel_Office")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_EnforcementAN4() {
		return Karate.run("classpath:karate/UseCases/UC_Enforcement_Arrest_Of_Licensee_ETE.feature")
				.tags("TC0004_SLA_ENF_ETE_Arrest_of_Licensee_Response_received_by_Lead_Investigator_Send_to_Counsel_Attorney")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_EnforcementAN5() {
		return Karate.run("classpath:karate/UseCases/UC_Enforcement_Arrest_Of_Licensee_ETE.feature")
				.tags("TC0005_SLA_ENF_ETE_Arrest_of_Licensee_NWOP_by_Investigator_referred_to_Counsel_Office")
				.karateEnv(env);
	}
	////////////////////////////// Enforcement OCSR ETE /////////////////////////////////////////////////
	
	//@Karate.Test
	Karate UC_EnforcementOCSR1() {
		return Karate.run("classpath:karate/UseCases/UC_Enforcement_OCSR_ETE.feature")
				.tags("TC0003_SLA_ENF_ETE_Flow_Serve_Order_of_Summary_Suspension_Case_close")
				.karateEnv(env);
	}
	////////////////////////////// Enforcement Case  /////////////////////////////////////////////////
	
	//@Karate.Test
	Karate UC_EnforcementCase1() {
		return Karate.run("classpath:karate/UseCases/UC_Enforcement_Case_ETE.feature")
				.tags("TC0001_SLA_ENF_ETE_Positive_unrelated_Complaint_Yes_PSS_Yes_NWOP_send_to_Counsel_Attorney")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_EnforcementCase2() {
		return Karate.run("classpath:karate/UseCases/UC_Enforcement_Case_ETE.feature")
				.tags("TC0002_SLA_ENF_ETE_Positive_unrelated_complaint_No_PSS_No_NWOP_Letter_of_advice")
				.karateEnv(env);
	}	
	//@Karate.Test
	Karate UC_EnforcementCase3() {
		return Karate.run("classpath:karate/UseCases/UC_Enforcement_Case_ETE.feature")
				.tags("TC0003_SLA_ENF_ETE_Positive_complaint_Related_to_a_Case")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_EnforcementCase4() {
		return Karate.run("classpath:karate/UseCases/UC_Enforcement_Case_ETE.feature")
				.tags("TC0004_SLA_ENF_ETE_Negative_complaint")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_EnforcementCase5() {
		return Karate.run("classpath:karate/UseCases/UC_Enforcement_Case_ETE.feature")
				.tags("TC0005_SLA_ENF_ETE_Positive_unrelated_complaint_Yes_PSS_No_to_Yes_for_NWOP_send_to_Counsel_Attorney")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_EnforcementCase6() {
		return Karate.run("classpath:karate/UseCases/UC_Enforcement_Case_ETE.feature")
				.tags("TC0006_SLA_ENF_ETE_Positive_unrelated_complaint_Changes_in_Sale_To_Minor_Table_send_to_Counsel_SS")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_EnforcementCase7() {
		return Karate.run("classpath:karate/UseCases/UC_Enforcement_Case_ETE.feature")
				.tags("TC0007_SLA_ENF_ETE_Positive_unrelated_complaint_NO_PSS_NWOP_Response_received_send_to_Counsel_SS")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_EnforcementCase8() {
		return Karate.run("classpath:karate/UseCases/UC_Enforcement_Case_ETE.feature")
				.tags("TC0008_SLA_ENF_ETE_Positive_unrelated_complaint_Yes_for_PSS_No_NWOP_Response_send_to_Counsel_Attorney")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_EnforcementCase9() {
		return Karate.run("classpath:karate/UseCases/UC_Enforcement_Case_ETE.feature")
				.tags("@TC0009_SLA_ENF_ETE_Positive_unrealted_complaint_NO_to_YES_for_PSS_NWOP_Response_received_send_to_Counsel")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_EnforcementCase10() {
		return Karate.run("classpath:karate/UseCases/UC_Enforcement_Case_ETE.feature")
				.tags("TC0010_SLA_ENF_ETE_Positive_unrelated_complaint_No_PSS_No_NWOP_Case_Closed")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_EnforcementCase11() {
		return Karate.run("classpath:karate/UseCases/UC_Enforcement_Case_ETE.feature")
				.tags("TC0011_SLA_ENF_ETE_Positive_unrelated_Complaint_NWOP_process_by_Investigator_decision")
				.karateEnv(env);
	}
	
	////////////////////////////// Enforcement IFL ETE /////////////////////////////////////////////////
	
	//@Karate.Test
	Karate UC_EnforcementIFL1() {
		return Karate.run("classpath:karate/UseCases/UC_Enforcement_In_From_Licensing_ETE.feature")
				.tags("TC0001_SLA_ENF_ETE_Flow_of_200ft_measurement_case")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_EnforcementIFL2() {
		return Karate.run("classpath:karate/UseCases/UC_Enforcement_In_From_Licensing_ETE.feature")
				.tags("TC0001_SLA_ENF_ETE_Flow_Refer_to_Enforcement_YES_for_PSS_No_NWOP")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_EnforcementIFL3() {
		return Karate.run("classpath:karate/UseCases/UC_Enforcement_In_From_Licensing_ETE.feature")
				.tags("TC0002_SLA_ENF_ETE_Flow_Refer_to_Enforcement_NO_for_PSS_No_NWOP_Case_Closed")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_EnforcementIFL4() {
		return Karate.run("classpath:karate/UseCases/UC_Enforcement_In_From_Licensing_ETE.feature")
				.tags("TC0003_SLA_ENF_ETE_Flow_Refer_to_Enforcement_NO_for_PSS_and_NO_for_NWOP_Letter_of_Advice")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_EnforcementIFL5() {
		return Karate.run("classpath:karate/UseCases/UC_Enforcement_In_From_Licensing_ETE.feature")
				.tags("TC0004_SLA_ENF_ETE_Flow_Refer_to_Enforcement_YES_to_No_for_PSS_and_YES_for_NWOP")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_EnforcementIFL6() {
		return Karate.run("classpath:karate/UseCases/UC_Enforcement_In_From_Licensing_ETE.feature")
				.tags("TC0005_SLA_ENF_ETE_Flow_Refer_to_Enforcement_Changes_in_Sale_to_Minor_Table")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_EnforcementIFL7() {
		return Karate.run("classpath:karate/UseCases/UC_Enforcement_In_From_Licensing_ETE.feature")
				.tags("TC0006_SLA_ENF_ETE_Flow_Refer_to_Enforcement_YES_for_PSS_NWOP_from_NO_to_YES")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_EnforcementIFL8() {
		return Karate.run("classpath:karate/UseCases/UC_Enforcement_In_From_Licensing_ETE.feature")
				.tags("TC0007_SLA_ENF_ETE_Flow_Refer_to_Enforcement_No_License_Permit_ID")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_EnforcementIFL9() {
		return Karate.run("classpath:karate/UseCases/UC_Enforcement_In_From_Licensing_ETE.feature")
				.tags("TC0008_SLA_ENF_ETE_Flow_Refer_to_Enforcement_NO_PSS_No_NWOP_Referred_to_Counsel_Support_Staff")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_EnforcementIFL10() {
		return Karate.run("classpath:karate/UseCases/UC_Enforcement_In_From_Licensing_ETE.feature")
				.tags("TC0009_SLA_ENF_ETE_Flow_Refer_to_Enforcement_NWOP_initiation_by_Investigator")
				.karateEnv(env);
	}
	////////////////////////////// Enforcement Unlicensed Complaint ETE /////////////////////////////////////////////////
	
	//@Karate.Test
	Karate UC_EnforcementUCETE1() {
		return Karate.run("classpath:karate/UseCases/UC_Enforcement_Unlicensed_Complaint_ETE.feature")
				.tags("TC0001_Unlicensed_PD_Letter_Location")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_EnforcementUCETE2() {
		return Karate.run("classpath:karate/UseCases/UC_Enforcement_Unlicensed_Complaint_ETE.feature")
				.tags("TC0002_Unlicensed_PD_Letter")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_EnforcementUCETE3() {
		return Karate.run("classpath:karate/UseCases/UC_Enforcement_Unlicensed_Complaint_ETE.feature")
				.tags("TC0003_Unlicensed_Location")
				.karateEnv(env);
	}
	//@Karate.Test
	Karate UC_EnforcementUCETE4() {
		return Karate.run("classpath:karate/UseCases/UC_Enforcement_Unlicensed_Complaint_ETE.feature")
				.tags("TC0004_Unlicensed_Close_Complaint")
				.karateEnv(env);
	}
	////////////////////////////// Enforcement In From Counsel ETE /////////////////////////////////////////////////
	
	//@Karate.Test
	Karate UC_EnforcementIFC1() {
		return Karate.run("classpath:karate/UseCases/UC_Enforcement_In_From_Counsel_ETE.feature")
				.tags("TC0001_Supervisor_Reviews_Request_to_serve_Subpoena")
				.karateEnv(env);
	}
	@Karate.Test
	Karate UC_EnforcementIFC2() {
		return Karate.run("classpath:karate/UseCases/UC_Enforcement_In_From_Counsel_ETE.feature")
				.tags("TC0002_Supervisor_Reviews_Request_to_serve_Subpoena")
				.karateEnv(env);
	}

}

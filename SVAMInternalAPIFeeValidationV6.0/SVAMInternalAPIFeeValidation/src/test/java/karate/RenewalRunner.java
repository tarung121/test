package karate;

import com.intuit.karate.junit5.Karate;

class RenewalRunner {

	String env = "dev";

		
		////////////////////// Renewal Use Cases ///////////////////////////////////////////
		
		@Karate.Test
		Karate UC_RenewalIntakeApp_TC0001_SLA_REN_Intake_Onpremises_License_Inside_5_Boroughts_Submit() {
			return Karate.run("classpath:karate/UseCases/UC_RenewalIntakeApp.feature")
					.tags("TC0001_SLA_REN_Intake_Onpremises_License_Inside_5_Boroughts_Submit").karateEnv(env);
		}
		@Karate.Test
		Karate UC_RenewalIntakeApp_TC0001a_SLA_REN_Intake_On_premises_Seasonal() {
			return Karate.run("classpath:karate/UseCases/UC_RenewalIntakeApp.feature")
					.tags("TC0001a_SLA_REN_Intake_On_premises_Seasonal").karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_RenewalIntakeApp_TC0001b_SLA_REN_Intake_Wholesaler_Manufacturer_License() {
			return Karate.run("classpath:karate/UseCases/UC_RenewalIntakeApp.feature")
					.tags("TC0001b_SLA_REN_Intake_Wholesaler_Manufacturer_License").karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_RenewalIntakeApp_TC0001c_SLA_REN_Intake_Direct_Shipper_License() {
			return Karate.run("classpath:karate/UseCases/UC_RenewalIntakeApp.feature")
					.tags("TC0001c_SLA_REN_Intake_Direct_Shipper_License").karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_RenewalIntakeApp_TC0002_SLA_REN_Intake_Standalone_Permit() {
			return Karate.run("classpath:karate/UseCases/UC_RenewalIntakeApp.feature")
					.tags("TC0002_SLA_REN_Intake_Standalone_Permit").karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_RenewalIntakeApp_TC0002a_SLA_REN_Intake_Associated_Permit() {
			return Karate.run("classpath:karate/UseCases/UC_RenewalIntakeApp.feature")
					.tags("TC0002a_SLA_REN_Intake_Associated_Permit").karateEnv(env);
		}
		
		@Karate.Test
		Karate UC_RenewalIntakeApp_TC0017_SLA_REN_Intake_Awaiting_Additional_Funs_application() {
			return Karate.run("classpath:karate/UseCases/UC_RenewalIntakeApp.feature")
					.tags("TC0017_SLA_REN_Intake_Awaiting_Additional_Funs_application").karateEnv(env);
		}
		
		
		@Karate.Test
		Karate UC_RenewalIntakeApp_TC0005_SLA_REN_Intake_Main_license_Associated_Permit_Submit() {
			return Karate.run("classpath:karate/UseCases/UC_RenewalIntakeApp.feature")
					.tags("TC0005_SLA_REN_Intake_Main_license_Associated_Permit_Submit").karateEnv(env);
		}


		@Karate.Test
		Karate UC_RenewalIntakeApp_TC0003a_SLA_REN_Intake_Preview_Submit_Tab_Multiple_Application() {
			return Karate.run("classpath:karate/UseCases/UC_RenewalIntakeApp.feature")
					.tags("TC0005_SLA_REN_Intake_Main_license_Associated_Permit_Submit").karateEnv(env);
		}

		@Karate.Test
		Karate UC_RenewalIntakeApp_TC0003b_SLA_REN_Intake_Preview_Submit_Not_Qualified_application() {
			return Karate.run("classpath:karate/UseCases/UC_RenewalIntakeApp.feature")
					.tags("TC0003b_SLA_REN_Intake_Preview_Submit_Not_Qualified_application").karateEnv(env);
		}

		@Karate.Test
		Karate UC_RenewalIntakeApp_TC0004_SLA_REN_Intake_HighlyDeficiency() {
			return Karate.run("classpath:karate/UseCases/UC_RenewalIntakeApp.feature")
					.tags("TC0004_SLA_REN_Intake_HighlyDeficiency").karateEnv(env);
		}


		 @Karate.Test
		Karate Uc_RenewalExaminerReview_TC0002_SLA_REN_Examiner_review_Digest_Approved_and_Hold_for_CB_notice() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
					.tags("TC0002_SLA_REN_Examiner_review_Digest_Approved_and_Hold_for_CB_notice").karateEnv(env);
		}

		 @Karate.Test
		Karate Uc_RenewalExaminerReview_TC0002_SLA_REN_Examiner_review_Digest_ApprovedandRefertoCounselsOffice() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
					.tags("TC0002_SLA_REN_Examiner_review_Digest_ApprovedandRefertoCounselsOffice").karateEnv(env);
		}

		 @Karate.Test
		Karate Uc_RenewalExaminerReview_TC0002A_SLA_REN_Examiner_review_Common_Digest_License() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
					.tags("TC0002A_SLA_REN_Examiner_review_Common_Digest_License").karateEnv(env);
		}

		 @Karate.Test
		Karate Uc_RenewalExaminerReview_TC0002A_SLA_REN_Examiner_review_Common_Digest_Permit() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
					.tags("TC0002A_SLA_REN_Examiner_review_Common_Digest_Permit").karateEnv(env);
		}

		 @Karate.Test
		Karate Uc_RenewalExaminerReview_TC0003_SLA_REN_Examiner_review_Approve_license() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
					.tags("TC0003_SLA_REN_Examiner_review_Approve_license").karateEnv(env);
		}

		 @Karate.Test
		Karate Uc_RenewalExaminerReview_TC0004_SLA_REN_Examiner_review_Approve_Standalone_Permit() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
					.tags("TC0004_SLA_REN_Examiner_review_Approve_Standalone_Permit").karateEnv(env);
		}

		 @Karate.Test
		Karate Uc_RenewalExaminerReview_TC0005_SLA_REN_Examiner_review_Approve_Associated_Permit() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
					.tags("TC0005_SLA_REN_Examiner_review_Approve_Associated_Permit").karateEnv(env);
		}

		 @Karate.Test
		Karate Uc_RenewalExaminerReview_TC0006_SLA_REN_Examiner_review_Approve_Temporary_Permit() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
					.tags("TC0006_SLA_REN_Examiner_review_Approve_Temporary_Permit").karateEnv(env);
		}

		 @Karate.Test
		Karate Uc_RenewalExaminerReview_TC0007_SLA_REN_Examiner_Approve_Safekeeping_License() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
					.tags("TC0007_SLA_REN_Examiner_Approve_Safekeeping_License").karateEnv(env);
		}

		@Karate.Test
		Karate Uc_RenewalExaminerReview_TC0008_SLA_REN_Examiner_Approve_Safekeeping_Associated_Permit() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
					.tags("TC0008_SLA_REN_Examiner_Approve_Safekeeping_Associated_Permit").karateEnv(env);
		}

		@Karate.Test
		Karate Uc_RenewalExaminerReview_TC0009_SLA_REN_Examiner_Approve_Safekeeping_Standalone_Permit() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
					.tags("TC0009_SLA_REN_Examiner_Approve_Safekeeping_Standalone_Permit").karateEnv(env);
		}

		 @Karate.Test
		Karate Uc_RenewalExaminerReview_TC0010_SLA_REN_Examiner_Approve_Safekeeping_Temporary_Permit() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
					.tags("TC0010_SLA_REN_Examiner_Approve_Safekeeping_Temporary_Permit").karateEnv(env);
		}

		@Karate.Test
		Karate Uc_RenewalExaminerReview_TC0012_SLA_REN_Examiner_review_Approve_Provisions_Removal() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
					.tags("TC0012_SLA_REN_Examiner_review_Approve_Provisions_Removal").karateEnv(env);
		}

		@Karate.Test
		Karate Uc_RenewalExaminerReview_TC0013_SLA_REN_Examiner_review_Approve_Provisions_Corporate_Change() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
					.tags("TC0013_SLA_REN_Examiner_review_Approve_Provisions_Corporate_Change").karateEnv(env);
		}

		@Karate.Test
		Karate Uc_RenewalExaminerReview_TC0014_SLA_REN_Examiner_review_Approve_Provisions_Alteration() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
					.tags("TC0014_SLA_REN_Examiner_review_Approve_Provisions_Alteration").karateEnv(env);
		}

		@Karate.Test
		Karate Uc_RenewalExaminerReview_TC0015_SLA_REN_Examiner_review_Approve_Provisions_Endorsement() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
					.tags("TC0015_SLA_REN_Examiner_review_Approve_Provisions_Endorsement").karateEnv(env);
		}

		@Karate.Test
		Karate Uc_RenewalExaminerReview_TC0016_SLA_REN_Examiner_review_Approve_Provisions_Safekeeping_Removal() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
					.tags("TC0016_SLA_REN_Examiner_review_Approve_Provisions_Safekeeping_Removal").karateEnv(env);
		}

		@Karate.Test
		Karate Uc_RenewalExaminerReview_TC0017_SLA_REN_Examiner_review_Approve_Provisions_Safekeeping_Corporate_Change() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
					.tags("TC0017_SLA_REN_Examiner_review_Approve_Provisions_Safekeeping_Corporate_Change").karateEnv(env);
		}

		@Karate.Test
		Karate Uc_RenewalExaminerReview_TC0018_SLA_REN_Examiner_review_Approve_Provisions_Safekeeping_Alteration() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
					.tags("TC0018_SLA_REN_Examiner_review_Approve_Provisions_Safekeeping_Alteration").karateEnv(env);
		}

		@Karate.Test
		Karate Uc_RenewalExaminerReview_TC0019_SLA_REN_Examiner_review_Approve_Provisions_Safekeeping_Endorsement() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
					.tags("TC0019_SLA_REN_Examiner_review_Approve_Provisions_Safekeeping_Endorsement").karateEnv(env);
		}
		
         @Karate.Test
        Karate TC0020_SLA_REN_Examiner_review_Send_to_LB_for_Review_License() {
        return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
        .tags("TC0020_SLA_REN_Examiner_review_Send_to_LB_for_Review_License").karateEnv(env);
       }
        @Karate.Test
        Karate TC0021_SLA_REN_Examiner_review_Send_to_LB_for_Review_Permit() {
        return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
        .tags("TC0021_SLA_REN_Examiner_review_Send_to_LB_for_Review_Permit").karateEnv(env);
       }
        
        @Karate.Test
        Karate TC0022_SLA_REN_Examiner_Review_Send_to_LB_On_Premises_License() {
        return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
        .tags("TC0022_SLA_REN_Examiner_Review_Send_to_LB_On_Premises_License").karateEnv(env);
       }
        
      @Karate.Test
        Karate TC0024_SLA_REN_Examiner_Review_FBPT_for_Review_License() {
        return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
        .tags("TC0024_SLA_REN_Examiner_Review_FBPT_for_Review_License").karateEnv(env);
       }
        
      @Karate.Test
        Karate TC0025_SLA_REN_Examiner_Review_FBPT_for_Review_On_Premises_License() {
        return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
        .tags("TC0025_SLA_REN_Examiner_Review_FBPT_for_Review_On_Premises_License").karateEnv(env);
       }
      
      @Karate.Test
      Karate TC0026_SLA_REN_Examiner_Review_FBPT_for_Review_Permit() {
      return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
      .tags("TC0026_SLA_REN_Examiner_Review_FBPT_for_Review_Permit").karateEnv(env);
     }
      
      @Karate.Test
      Karate TC0029_SLA_REN_Examiner_Review_Define_Deficiencies_License() {
      return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
      .tags("TC0029_SLA_REN_Examiner_Review_Define_Deficiencies_License").karateEnv(env);
     }
      
    @Karate.Test
      Karate TC0030_SLA_REN_Examiner_Review_Define_Deficiencies_On_Premises_License() {
      return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
      .tags("TC0030_SLA_REN_Examiner_Review_Define_Deficiencies_On_Premises_License").karateEnv(env);
     }
      
       @Karate.Test
      Karate TC0031_SLA_REN_Examiner_Review_DefineDeficiencies_Permit() {
      return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
      .tags("TC0031_SLA_REN_Examiner_Review_DefineDeficiencies_Permit").karateEnv(env);
     }
      
      @Karate.Test
      Karate TC0032_SLA_REN_Examiner_Review_IntakeDeficiencies_Permit() {
      return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
      .tags("TC0032_SLA_REN_Examiner_Review_IntakeDeficiencies_Permit").karateEnv(env);
     }
      
     @Karate.Test
      Karate TC0034_SLA_REN_Examiner_Review_IntakeDeficiencies_On_Premises_License() {
      return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
      .tags("TC0034_SLA_REN_Examiner_Review_IntakeDeficiencies_On_Premises_License").karateEnv(env);
     }
      
   @Karate.Test
      Karate TC0035_SLA_REN_Examiner_Review_IntakeDeficiencies_License() {
      return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
      .tags("TC0035_SLA_REN_Examiner_Review_IntakeDeficiencies_License").karateEnv(env);
     }
      
   @Karate.Test
      Karate TC0036_SLA_REN_Examiner_Review_Deficiencies_Permit_AllDeficiencies_met_YES() {
      return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
      .tags("TC0036_SLA_REN_Examiner_Review_Deficiencies_Permit_AllDeficiencies_met_YES").karateEnv(env);
     }
      
      @Karate.Test
      Karate TC0037_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_No_Define_YES_Final_YES() {
      return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
      .tags("TC0037_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_No_Define_YES_Final_YES").karateEnv(env);
     }
      
      @Karate.Test
      Karate TC0038_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_No_Define_NO_Final_NO() {
      return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
      .tags("TC0038_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_No_Define_NO_Final_NO").karateEnv(env);
     }
      
   @Karate.Test
      Karate TC0039_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_NO_Final_deficiency_Checked_before() {
      return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
      .tags("TC0039_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_NO_Final_deficiency_Checked_before").karateEnv(env);
     }
      
   @Karate.Test
      Karate TC0040_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_No_Define_YES_Final_NO() {
      return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
      .tags("TC0040_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_No_Define_YES_Final_NO").karateEnv(env);
     }
      
      @Karate.Test
      Karate TC0041_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_YES_Define_YES_Final_YES_response_OK() {
      return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
      .tags("TC0041_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_YES_Define_YES_Final_YES_response_OK").karateEnv(env);
     }
      
      
      @Karate.Test
      Karate TC0042_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_YES_Define_YES_Final_YES_response_NO() {
      return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
      .tags("TC0042_SLA_REN_Examiner_Review_Deficiencies_AllDeficiencies_met_YES_Define_YES_Final_YES_response_NO").karateEnv(env);
     }
      
      
      @Karate.Test
      Karate TC0043_SLA_REN_ExaminersReview_SendDeficiency_Reminder() {
      return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
      .tags("TC0043_SLA_REN_ExaminersReview_SendDeficiency_Reminder").karateEnv(env);
     }
      
      
      @Karate.Test
      Karate TC0044_SLA_REN_ExaminersReview_Send_DisapprovalLetter() {
      return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
      .tags("TC0044_SLA_REN_ExaminersReview_Send_DisapprovalLetter").karateEnv(env);
     }

		@Karate.Test
		Karate Uc_RenewalExaminerReview_TC0045_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
					.tags("TC0045_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice").karateEnv(env);
		}

		@Karate.Test
		Karate Uc_RenewalExaminerReview_TC0046_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
					.tags("TC0046_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping").karateEnv(env);
		}

		@Karate.Test
		Karate Uc_RenewalExaminerReview_TC0047_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Define_provisions_Removal() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
					.tags("TC0047_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Define_provisions_Removal")
					.karateEnv(env);
		}

		@Karate.Test
		Karate Uc_RenewalExaminerReview_TC0048_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Define_provisions_Corporate_Change() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature").tags(
					"TC0048_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Define_provisions_Corporate_Change")
					.karateEnv(env);
		}

		@Karate.Test
		Karate Uc_RenewalExaminerReview_TC0049_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Define_provisions_Alteration() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
					.tags("TC0049_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Define_provisions_Alteration")
					.karateEnv(env);
		}

		@Karate.Test
		Karate Uc_RenewalExaminerReview_TC0050_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Define_provisions_Endorsement() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
					.tags("TC0050_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Define_provisions_Endorsement")
					.karateEnv(env);
		}

		@Karate.Test
		Karate Uc_RenewalExaminerReview_TC0051_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping_Define_provisions_Removal() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature").tags(
					"TC0051_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping_Define_provisions_Removal")
					.karateEnv(env);
		}

		@Karate.Test
		Karate Uc_RenewalExaminerReview_TC0052_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping_Define_provisions_Corporate_Change() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature").tags(
					"TC0052_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping_Define_provisions_Corporate_Change")
					.karateEnv(env);
		}

		@Karate.Test
		Karate Uc_RenewalExaminerReview_TC0053_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping_Define_provisions_Alteration() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature").tags(
					"TC0053_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping_Define_provisions_Alteration")
					.karateEnv(env);
		}

		@Karate.Test
		Karate Uc_RenewalExaminerReview_TC0054_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping_Define_provisions_Endorsement() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature").tags(
					"TC0054_SLA_REN_Examiners_Review_Approved_Refer_to_CounselOffice_Safekeeping_Define_provisions_Endorsement")
					.karateEnv(env);
		}

		@Karate.Test
		Karate Uc_RenewalExaminerReview_TC0055_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
					.tags("TC0055_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice").karateEnv(env);
		}

		@Karate.Test
		Karate Uc_RenewalExaminerReview_TC0056_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
					.tags("TC0056_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping").karateEnv(env);
		}

		@Karate.Test
		Karate Uc_RenewalExaminerReview_TC0057_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Define_provisions_Removal() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
					.tags("TC0057_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Define_provisions_Removal")
					.karateEnv(env);
		}

//			@Karate.Test
		Karate Uc_RenewalExaminerReview_TC0058_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Define_provisions_CorporateChange() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature").tags(
					"TC0058_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Define_provisions_CorporateChange")
					.karateEnv(env);
		}

		@Karate.Test
		Karate Uc_RenewalExaminerReview_TC0059_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Define_provisions_Alternation() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
					.tags("TC0059_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Define_provisions_Alternation")
					.karateEnv(env);
		}

//			@Karate.Test
		Karate Uc_RenewalExaminerReview_TC0060_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Define_provisions_Endorsement() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
					.tags("TC0060_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Define_provisions_Endorsement")
					.karateEnv(env);
		}

//			@Karate.Test
		Karate Uc_RenewalExaminerReview_TC0061_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping_Define_provisions_Removal() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature").tags(
					"TC0061_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping_Define_provisions_Removal")
					.karateEnv(env);
		}

		@Karate.Test
		Karate Uc_RenewalExaminerReview_TC0062_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping_Define_provisions_CorporateChange() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature").tags(
					"TC0062_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping_Define_provisions_CorporateChange")
					.karateEnv(env);
		}

//			@Karate.Test
		Karate Uc_RenewalExaminerReview_TC0063_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping_Define_provisions_Alternation() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature").tags(
					"TC0063_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping_Define_provisions_Alternation")
					.karateEnv(env);
		}

		@Karate.Test
		Karate Uc_RenewalExaminerReview_TC0064_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping_Define_provisions_Endorsement() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature").tags(
					"TC0064_SLA_REN_Examiners_Review_Approved_and_Hold_for_CBNotice_Safekeeping_Define_provisions_Endorsement")
					.karateEnv(env);
		}

		@Karate.Test
		Karate Uc_RenewalExaminerReview_TC0066_SLA_REN_Examiners_Review_Highly_Deficient() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
					.tags("TC0066_SLA_REN_Examiners_Review_Highly_Deficient").karateEnv(env);
		}
 
		   @Karate.Test
		      Karate TC0069_SLA_REN_ExaminersReview_Cancel() {
		      return Karate.run("classpath:karate/UseCases/Uc_RenewalExaminerReview.feature")
		      .tags("TC0069_SLA_REN_ExaminersReview_Cancel").karateEnv(env);
		     }

		@Karate.Test
		Karate Uc_RenewalDueDate_TC0001_SLA_REN_Duedate_Extension_Approve_Respond_Deficiencies_License() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalDueDate.feature")
					.tags("TC0001_SLA_REN_Duedate_Extension_Approve_Respond_Deficiencies_License").karateEnv(env);
		}
		
		
		@Karate.Test
		Karate Uc_RenewalDueDate_TC0001a_SLA_REN_Duedate_Extension_Approve_Respond_Deficiencies_Permit() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalDueDate.feature")
					.tags("TC0001a_SLA_REN_Duedate_Extension_Approve_Respond_Deficiencies_Permit").karateEnv(env);
		}
		
		@Karate.Test
		Karate Uc_RenewalDueDate_TC0003_SLA_REN_Due_date_Extension_disapprove_Respond_Deficiencies_License() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalDueDate.feature")
					.tags("TC0003_SLA_REN_Due_date_Extension_disapprove_Respond_Deficiencies_License").karateEnv(env);
		}
		
		@Karate.Test
		Karate Uc_RenewalDueDate_TC0003a_SLA_REN_Due_date_Extension_disapprove_Respond_Deficiencies_Permit() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalDueDate.feature")
					.tags("TC0003a_SLA_REN_Due_date_Extension_disapprove_Respond_Deficiencies_License_Permit").karateEnv(env);
		}
		
		
		@Karate.Test
		Karate Uc_RenewalReturnedCheck_TC0001_SLA_REN_ReturnCheck_Payment_failed_Awaiting_Review_License() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalReturnedCheck.feature")
					.tags("TC0001_SLA_REN_ReturnCheck_Payment_failed_Awaiting_Review_License").karateEnv(env);
		}
		
		@Karate.Test
		Karate Uc_RenewalReturnedCheck_TC0001a_SLA_REN_Return_Check_Paymentfailed_Awaiting_Review_Permit() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalReturnedCheck.feature")
					.tags("TC0001a_SLA_REN_Return_Check_Paymentfailed_Awaiting_Review_Permit").karateEnv(env);
		}

		@Karate.Test
		Karate Uc_RenewalReturnedCheck_TC0002_SLA_REN_ReturnCheck_Intake_Payment_Awaiting_Additional_Funds_License() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalReturnedCheck.feature")
					.tags("TC0002_SLA_REN_ReturnCheck_Intake_Payment_Awaiting_Additional_Funds_License").karateEnv(env);
		}
		
		@Karate.Test
		Karate Uc_RenewalReturnedCheck_TC0002a_SLA_REN_ReturnCheck_Intake_Payment_Awaiting_Additional_Funds_Permit() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalReturnedCheck.feature")
					.tags("TC0002a_SLA_REN_ReturnCheck_Intake_Payment_Awaiting_Additional_Funds_Permit").karateEnv(env);
		}
		
		@Karate.Test
		Karate Uc_RenewalReturnedCheck_TC0004_SLA_REN_ReturnCheck_Intake_Payment_Awaiting_Additional_Funds_insufficient_fund_received_License() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalReturnedCheck.feature")
					.tags("TC0004_SLA_REN_ReturnCheck_Intake_Payment_Awaiting_Additional_Funds_insufficient_fund_received_License").karateEnv(env);
		}
		
		@Karate.Test
		Karate Uc_RenewalReturnedCheck_TC0004a_SLA_REN_ReturnCheck_Intake_Payment_Awaiting_Additional_Funds_insufficient_fund_received_Permit() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalReturnedCheck.feature")
					.tags("TC0004a_SLA_REN_ReturnCheck_Intake_Payment_Awaiting_Additional_Funds_insufficient_fund_received_Permit").karateEnv(env);
		}
		@Karate.Test
		Karate UC_RenewalSearchLicenseId1() {
			return Karate.run("classpath:karate/UseCases/UC_RenewalSearchLicenseId.feature")
					.tags("TC0001_SLA_REN_Search_Renewal_Select_Application_Type").karateEnv(env);
		}
		@Karate.Test
		Karate UC_RenewalSearchLicenseId2() {
			return Karate.run("classpath:karate/UseCases/UC_RenewalSearchLicenseId.feature")
					.tags("TC0001a_SLA_REN_Search_Renewal_Select_Application_Type").karateEnv(env);
		}
		@Karate.Test
		Karate UC_RenewalSearchLicenseId3() {
			return Karate.run("classpath:karate/UseCases/UC_RenewalSearchLicenseId.feature")
					.tags("TC0001b_SLA_REN_Search_Renewal_Select_Application_Type_Permit").karateEnv(env);
		}
		@Karate.Test
		Karate UC_RenewalSearchLicenseId4() {
			return Karate.run("classpath:karate/UseCases/UC_RenewalSearchLicenseId.feature")
					.tags("TC0002_SLA_REN_Search_Renewal_Select_Application_Type_Permit").karateEnv(env);
		}
		@Karate.Test
		Karate UC_RenewalSearchLicenseId5() {
			return Karate.run("classpath:karate/UseCases/UC_RenewalSearchLicenseId.feature")
					.tags("TC0003_SLA_REN_Search_License_Name").karateEnv(env);
		}
		@Karate.Test
		Karate UC_RenewalSearchLicenseId6() {
			return Karate.run("classpath:karate/UseCases/UC_RenewalSearchLicenseId.feature")
					.tags("TC0004_SLA_REN_Search_License_Combined_Craft_select_two").karateEnv(env);
		}
		@Karate.Test
		Karate UC_RenewalSearchLicenseId7() {
			return Karate.run("classpath:karate/UseCases/UC_RenewalSearchLicenseId.feature")
					.tags("TC0005_SLA_REN_Search_License_Combined_Craft_ID_select_less_than_two_YES").karateEnv(env);
		}
		@Karate.Test
		Karate UC_RenewalSearchLicenseId8() {
			return Karate.run("classpath:karate/UseCases/UC_RenewalSearchLicenseId.feature")
					.tags("TC0007_SLA_REN_Search_License_Master_File_select_five").karateEnv(env);
		}
		@Karate.Test
		Karate UC_RenewalSearchLicenseId9() {
			return Karate.run("classpath:karate/UseCases/UC_RenewalSearchLicenseId.feature")
					.tags("TC0008_SLA_REN_Search_License_Master_File_select_less_than_five_YES").karateEnv(env);
		}
		@Karate.Test
		Karate UC_RenewalSearchLicenseId10() {
			return Karate.run("classpath:karate/UseCases/UC_RenewalSearchLicenseId.feature")
					.tags("TC0010_SLA_REN_Search_Not_Qualified").karateEnv(env);
		}
		@Karate.Test
		Karate UC_RenewalSearchLicenseId11() {
			return Karate.run("classpath:karate/UseCases/UC_RenewalSearchLicenseId.feature")
					.tags("TC0014_SLA_REN_Search_Associated_Permit_ID_Main_License_not_expired").karateEnv(env);
		}
		@Karate.Test
		Karate UC_RenewalSearchLicenseId12() {
			return Karate.run("classpath:karate/UseCases/UC_RenewalSearchLicenseId.feature")
					.tags("TC0015_SLA_REN_Search_Renewal_WH_MA_License_Solicitor_Permit").karateEnv(env);
		}
		@Karate.Test
		Karate UC_RenewalIntakeFees1() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalIntakeFees.feature")
					.tags("TC001_SLA_REN_Intake_Fees_Main_License_Information_section").karateEnv(env);
		}
		@Karate.Test
		Karate UC_RenewalIntakeFees2() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalIntakeFees.feature")
					.tags("TC004_SLA_REN_Intake_Fees_Bond_Information_grid").karateEnv(env);
		}
		@Karate.Test
		Karate UC_RenewalIntakeFees3() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalIntakeFees.feature")
					.tags("TC006_SLA_REN_Intake_Fees_Apply_Payment_to_Single_Application").karateEnv(env);
		}
		@Karate.Test
		Karate UC_RenewalIntakeFees4() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalIntakeFees.feature")
					.tags("TC007_SLA_REN_Intake_Fees_Apply_Payment_to_multiple_Application").karateEnv(env);
		}
		@Karate.Test
		Karate UC_RenewalIntakeFees5() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalIntakeFees.feature")
					.tags("TC011_SLA_REN_Intake_Fees_Underpayment_Before_due_date").karateEnv(env);
		}
		@Karate.Test
		Karate UC_RenewalIntakeFees6() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalIntakeFees.feature")
					.tags("TC015_SLA_REN_Intake_Fees_Underpayment_HOLD").karateEnv(env);
		}
		@Karate.Test
		Karate UC_RenewalIntakeFees7() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalIntakeFees.feature")
					.tags("TC016_SLA_REN_Intake_Fees_Over_Payment").karateEnv(env);
		}
		@Karate.Test
		Karate UC_RenewalIntakeFees8() {
			return Karate.run("classpath:karate/UseCases/Uc_RenewalIntakeFees.feature")
					.tags("TC017_SLA_REN_Intake_Fees_Waived_Fee").karateEnv(env);
		}
		@Karate.Test
		Karate UC_RenewalFBPT_Review1() {
			return Karate.run("classpath:karate/UseCases/UC_Renewal_FBPT_Review.feature")
					.tags("TC0001_SLA_REN_FBPT_Review_Redirect_for_LB_Decision").karateEnv(env);
		}
		@Karate.Test
		Karate UC_RenewalFBPT_Review2() {
			return Karate.run("classpath:karate/UseCases/UC_Renewal_FBPT_Review.feature")
					.tags("TC0002_SLA_REN_FBPT_Review_Additional_Information_Required").karateEnv(env);
		}
	
}

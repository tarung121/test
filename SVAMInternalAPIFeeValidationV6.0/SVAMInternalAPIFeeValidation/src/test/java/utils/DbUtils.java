package utils;

import java.io.BufferedWriter;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import cucumber.api.java.en.Given;

import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;
import java.util.TimeZone;

public class DbUtils {

	private static final Logger logger = LoggerFactory.getLogger(DbUtils.class);

	private final JdbcTemplate jdbc;

	public static void main(String[] a) {

	}

	public int getRandomNumber(int maxNumber) {
		Random random = new Random();
		int randomNumber = random.nextInt(maxNumber);

		return randomNumber;
	}

	public void WritePDFData(String filePath, String wholeString) {

		byte[] buf = wholeString.getBytes(Charset.forName("UTF-8"));

		OutputStream oos = null;
		try {
			oos = new FileOutputStream(filePath);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		InputStream is = new ByteArrayInputStream(buf);
		int c = 0;

		try {
			while ((c = is.read(buf, 0, buf.length)) > 0) {
				System.out.println();
				oos.write(buf, 0, c);
				oos.flush();
				oos.close();
				is.close();
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	public static void copyFile(String srcLoc, String  desLocFolder) {
		try{
		File src = new File(srcLoc);
		File destDir = new File(desLocFolder);
        FileUtils.copyFileToDirectory(src, destDir);
	    }catch(Exception e){}

	}
//	public void appendStrToFile(String fileName, String str) {
//		try {
//			BufferedWriter out;
//
//			out = new BufferedWriter(new FileWriter(fileName, true));
//			out.write(str);
//			out.close();
//		} catch (IOException e) {
//			System.out.println("exception occurred" + e);
//		}
//	}

	public void appendStrToFile(String fileName, String str) {
		try {
			BufferedWriter out;
			Path path = Paths.get(fileName);
			boolean pathExistStatus = Files.notExists(path);

			out = new BufferedWriter(new FileWriter(fileName, true));
			if (pathExistStatus) {
				out.write("appId,term,description,licId,applicationId");
			}
			out.write(str);
			out.close();
		} catch (IOException e) {
			System.out.println("exception occurred" + e);
		}
	}

	public DbUtils(Map<String, Object> config) {
		String url = (String) config.get("url");
		String username = (String) config.get("username");
		String password = (String) config.get("password");
		// String driver = (String) config.get("driverClassName")
		System.out.println(url);
		System.out.println(username);
		System.out.println(password);
		DriverManagerDataSource dataSource = new DriverManagerDataSource();
		// dataSource.setDriverClassName(driver);
		dataSource.setUrl(url);
		dataSource.setUsername(username);
		dataSource.setPassword(password);
		jdbc = new JdbcTemplate(dataSource);
	}

	public Object readValue(String query) throws SQLException {
		return jdbc.queryForObject(query, Object.class);

	}

	public Map<String, Object> readRow(String sql) {
		return jdbc.queryForMap(sql);
	}

	public List<Map<String, Object>> readRows(String query) {
		return jdbc.queryForList(query);
	}

	public String readAPPIDFromTable(String applicationId) {
		return jdbc.queryForMap("SELECT AppId FROM Application where ApplicationId = '" + applicationId + "'")
				.get("AppId").toString();
	}

	public String readLicePermitTypeIdFromTable(String applicationId) {
		return jdbc
				.queryForMap("SELECT LicePermitTypeId FROM Application where ApplicationId = '" + applicationId + "'")
				.get("LicePermitTypeId").toString();
	}

	public String getIntakeLicenseEmailMapping(String appid) {
		return jdbc
				.queryForMap("Select Status from WfAsyncCustomHandlerQueue\r\n" + "	 Where WfType = 'Application'\r\n"
						+ "	 and NotificationTypeId in (2010,2011,2047,2089,2133,2134)\r\n" + "	 and WfItemId = '"
						+ appid + "'")
				.get("Status").toString();
	}

	public void cleanHeap() {
		try {
			System.gc();
		} catch (Exception e) {
		}
	}

	public String getApprovalLicenseEmailMapping(String appid) {
		String status = "Fail";

		int count = 0;
		while (count < 90) {
			status = jdbc.queryForMap("Select top(1) Status from WfAsyncCustomHandlerQueue\r\n"

					+ "Where WfType = 'Application'\r\n"
					+ "and NotificationTypeId in (Select NotificationTypeId from WfNotificationConfig Where TemplateId = 43)\r\n"
					+ "and WfItemId ='" + appid + "'").get("Status").toString();
			if (status.toLowerCase().contains("processed")) {
				try {
					Thread.sleep(5000);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				break;
			}
			count++;
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println(status + "---" + count);
		}
		return status;
	}

	public boolean approvalLicenseEmailMapping(String appid) {
		boolean status = false;

		String DBNotificationstatus = jdbc.queryForMap("Select Status from WfAsyncCustomHandlerQueue\r\n"

				+ "Where WfType = 'Application'\r\n"
				+ "and NotificationTypeId in (Select NotificationTypeId from WfNotificationConfig Where TemplateId = 43)\r\n"
				+ "and WfItemId ='" + appid + "'").get("Status").toString();
		status = DBNotificationstatus.toLowerCase().contains("processed");

		return status;
	}

	public boolean approvalLicenseEmailMapping(String appid, String NotificationName) {
		boolean status = false;

		int count = 0;
		while (count < 90) {
			String DBNotificationstatus = jdbc.queryForMap(
					"Select status from WfAsyncCustomHandlerQueue Where WfType = 'Application' and WfItemId ='" + appid
							+ "' and MethodName ='" + NotificationName + "'")
					.get("Status").toString();
			System.out.println(DBNotificationstatus);
			status = DBNotificationstatus.toLowerCase().contains("processed");

			if (status) {
				try {
					Thread.sleep(5000);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				break;
			}
			count++;
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println(status + "---" + count);
		}
		return status;
	}

	public int getLastCreatedCaseIDFromCaseInfoTable() {
		return Integer.parseInt(
				jdbc.queryForMap("select TOP 1 CaseId from CaseInfo ORDER BY CaseId DESC").get("CaseId").toString());
	}

	public int getLastCreatedRefundID() {
		return Integer.parseInt(jdbc.queryForMap("select TOP 1 refundid from refund ORDER BY refundid DESC")
				.get("refundid").toString());
	}

	public String getLastCreatedVoucherNumber() {
		String val = jdbc
				.queryForMap("select TOP 1 VoucherNo from refund WHERE VoucherNo IS NOT NULL ORDER BY refundid DESC")
				.get("VoucherNo").toString();
		int number = (Integer.parseInt(val.substring(1, val.length())) + 1);
		int length = String.valueOf(number).length();
		String newVersion = "O";
		if (length <= 2) {
			newVersion = "O000" + number;
		} else if (length <= 3) {
			newVersion = "O00" + number;
		} else if (length <= 4) {
			newVersion = "O0" + number;
		}

		System.out.println(newVersion);

		return newVersion;
	}
	
	public class MyStepDefinitions {
	    @Given("^an encoded string \"([^\"]*)\"$")
	    public void anEncodedString(String encodedString) {
	        byte[] decodedBytes = Base64.getDecoder().decode(encodedString);
	        String decodedString = new String(decodedBytes);
	        // use the decoded string as needed
	    }

	public String getLastCreatedCaseNumberFromCaseInfoTable() {
		return jdbc.queryForMap("select TOP 1 CaseNo from CaseInfo ORDER BY CaseId DESC").get("CaseNo").toString();
	}

	public int getRefundClaimID() {
		return (Integer.parseInt(jdbc.queryForMap("select TOP 1 * from RefundClaimed ORDER BY RefundClaimId DESC")
				.get("RefundClaimId").toString()));
	}

	public String readDataFromApplicationTable(String applicationId, String type) {
		return jdbc.queryForMap("SELECT " + type + " FROM Application where ApplicationId = '" + applicationId + "'")
				.get(type).toString();
	}

	public String readFromIDFromFbFormversionMasterTable(String formVersionID) {
		return jdbc.queryForMap("select formID FROM FbFormversionMaster where FormVersionId = '" + formVersionID + "'")
				.get("FormId").toString();
	}

	public String readBusinessSentityTable(String businessid) {
		return jdbc.queryForMap("select * from businessentity where NybeBusinessId = '" + businessid + "'").toString();
	}

	// select * from businessentity where NybeBusinessId = '228134387'
	// select * from FbFormversionMaster where FormVersionId in(1308, 1240, 1317)
}
}	

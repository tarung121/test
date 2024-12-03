package Reports;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.aventstack.extentreports.ExtentReports;
import com.aventstack.extentreports.reporter.ExtentSparkReporter;
import com.aventstack.extentreports.reporter.configuration.Theme;
import com.aventstack.extentreports.reporter.configuration.ViewName;

public class ExtentManager {

	private static ExtentReports extent;

	public static ExtentReports getInstance() {
		return extent;
	}

	public static void createInstance(String fileName) {
		ExtentSparkReporter htmlReporter = new ExtentSparkReporter(fileName);
		htmlReporter.config().setTheme(Theme.STANDARD);
		htmlReporter.config().setEncoding("UTF-8");
		htmlReporter.config().setProtocol(com.aventstack.extentreports.reporter.configuration.Protocol.HTTPS);
		htmlReporter.config().setDocumentTitle("Karate Extent Report");
		htmlReporter.config().setReportName("Karate Extent Demo");
		htmlReporter.viewConfigurer().viewOrder().as(new ViewName[] { ViewName.DASHBOARD, ViewName.TEST,
				ViewName.AUTHOR, ViewName.DEVICE, ViewName.EXCEPTION, ViewName.LOG }).apply();

		htmlReporter.config().setTimeStampFormat("MM/dd/yyyy hh:mm:ss a");
		extent = new ExtentReports();
		extent.setSystemInfo("Created By", "Jagannatha");
		extent.setSystemInfo("Autmation Type", "API");
		extent.attachReporter(htmlReporter);
	}

	public static void createReport() {
		System.out.println("Initialize Extent report was called");
		if (ExtentManager.getInstance() == null) {
			Date date = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy-HH-mm-ss");
			String formattedDate = dateFormat.format(date);
			ExtentManager.createInstance("results/" + "Extent_Report_Demo_" + formattedDate + ".html");
		}
	}
}
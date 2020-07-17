package com.examhub.test;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.examhub.Mailer;
import com.examhub.dao.*;
import com.examhub.impl.*;
import com.examhub.pojo.*;

@WebServlet("/resultServlet")
public class ResultServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	TestDao testDao = new TestDaoImpl();
	ExamDao examDao = new ExamDaoImpl();
	ResultDao resultDao = new ResultDaoImpl();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ResultServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	public static char checkGrade(int markObtained, int totalMrks) {
		char grade = 'A';
		int percentage = (markObtained * 100) / totalMrks;
		if (percentage <= 40) {
			grade = 'D';
		} else if (percentage <= 60) {
			grade = 'C';
		} else if (percentage < 75) {
			grade = 'B';
		} else {
			grade = 'A';
		}
		return grade;
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String opeartion = request.getParameter("operation");
		String studentUsername = (String) request.getSession().getAttribute("studentLogin");

		if (opeartion.equalsIgnoreCase("viewResult")) {

			int testId = Integer.parseInt(request.getParameter("testId"));

			Result resultToView = resultDao.viewResult(testId, studentUsername);
			List<Result> listOResults = resultDao.viewAllResults(testId);

			double totalStudentAppearTest = listOResults.size();
			int classD = 0, classC = 0, classB = 0, classA = 0;

			for (Result result : listOResults) {
				char grade = checkGrade(result.getObtained(), result.getMaxMarks());

				if (grade == 'A')
					classA++;
				else if (grade == 'B')
					classB++;
				else if (grade == 'C')
					classC++;
				else
					classD++;

				System.out.println(result.getObtained() + " " + result.getMaxMarks());
				System.out.println(grade);
				System.out.println(classA + " " + classB + " " + classC + " " + classD);
				System.out.println();
			}

			double rank = listOResults.indexOf(resultToView) + 1;
			double percentile = ((totalStudentAppearTest - rank) / totalStudentAppearTest) * 100;
			System.out.println(totalStudentAppearTest - rank);
			System.out.println((totalStudentAppearTest - rank) / totalStudentAppearTest);

			request.setAttribute("percentile", percentile);
			request.setAttribute("grade", checkGrade(resultToView.getObtained(), resultToView.getMaxMarks()));

			request.setAttribute("totalStudentAppearTest", totalStudentAppearTest);

			request.setAttribute("rank", rank);

			request.setAttribute("classA", classA);
			request.setAttribute("classB", classB);
			request.setAttribute("classC", classC);
			request.setAttribute("classD", classD);

			request.setAttribute("resultToView", resultToView);

			request.getRequestDispatcher("viewResult.jsp").forward(request, response);

		} else if (opeartion.equalsIgnoreCase("viewAllResult")) {
			List<List> resultReportList = new ArrayList<List>();

			List<Test> listOfTest = testDao.viewAllTest();

			for (Test test : listOfTest) {

				Integer testId = test.getTestId();

				List<Result> listOResults = resultDao.viewAllResults(testId);


				for (Result result : listOResults) {
					char grade = ResultServlet.checkGrade(result.getObtained(), result.getMaxMarks());
					String status="Fail";
					if (grade=='A' || grade=='B') {
						status="Pass";
					}
					List resultReportRecord = new ArrayList<>();
					resultReportRecord.add(test.getTestName() + " " + examDao.viewExam(test.getExamId()).getExamName());
					resultReportRecord.add(test.getTestType());
					resultReportRecord.add(result.getStudUsername());
					resultReportRecord.add((double)result.getMaxMarks());
					resultReportRecord.add((double)result.getObtained());
					resultReportRecord.add(grade);
					resultReportRecord.add(status);
					resultReportRecord.add(test.getTestId());
					resultReportRecord.add(result.getView());
					
					resultReportList.add(resultReportRecord);
				}
			}
			
			request.setAttribute("resultReportList", resultReportList);
			request.getRequestDispatcher("viewAllResult.jsp").forward(request, response);

		}else if(opeartion.equalsIgnoreCase("certificate")) {
			DateFormat dateFormat=new SimpleDateFormat("dd/MM/yyyy");
			
			String studentUserName=request.getParameter("username"); 
			//System.out.println(studentUserName);
			
			int testId=Integer.parseInt(request.getParameter("testId"));
			
			Test testDetails=testDao.viewTest(testId);
			String examName=testDetails.getTestName()+" ( "+examDao.viewExam(testDetails.getExamId()).getExamName()+" )" ;
			
			String percentage = String.format("%.2f",new Double(request.getParameter("per")));
			StudentDaoImpl studentImpl=new StudentDaoImpl();
			//System.out.println(" SER VVVVVVVVVVVVVVVVVVVVVVVVv "+studentImpl.viewProfile(studentUserName));
			
			String studentEmail=studentImpl.viewProfile(studentUserName).getEmail();
			String studentName=studentImpl.viewProfile(studentUserName).getName();
			
			dataToWrite=dataToWrite.replaceAll("Rakshit Shetty", studentName);
			dataToWrite=dataToWrite.replaceAll("Java SE Mock", examName);
			dataToWrite=dataToWrite.replaceAll("78%", percentage);
			dataToWrite=dataToWrite.replaceAll("22/02/2020", dateFormat.format(new Date()));
			
			Integer certificateId=new Random(450000).nextInt();
			Result resultDetails=resultDao.viewResult(testId, studentUserName);
			if(resultDetails.getView()==-1) {
				resultDao.updateResult(studentUserName, testId, certificateId);
			
			}
			else
			{
				certificateId=resultDetails.getView();
			}
			
			dataToWrite=dataToWrite.replaceAll("12345-7654321-4321", certificateId.toString());
			
			System.out.println(dataToWrite);
			File dir = new File("\\WEB-INF\\");
			dir.mkdirs();
			File tmp = new File(dir, "tmp.html");
			tmp.createNewFile();

			System.out.println(tmp.getAbsolutePath());
			FileWriter certifacteFile=new FileWriter(tmp);
			certifacteFile.write(dataToWrite);
			
			certifacteFile.flush();
			certifacteFile.close();
			
			
			Mailer.main(studentEmail, "examhub2020@gmail.com", "ExamHub@2020", tmp);
			
			request.getRequestDispatcher("resultServlet?operation=viewAllResult").forward(request, response);;
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	
	String dataToWrite="\r\n" + 
			"<?xml version='1.0' encoding='utf-8'?>\r\n" + 
			"<!-- Generator: Adobe Illustrator 22.0.0, SVG Export Plug-In . SVG Version: 6.00 Build 0)  -->\r\n" + 
			"<svg version='1.1' id='Layer_1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' x='0px' y='0px'\r\n" + 
			"	 width='1400px' height='980px' viewBox='0 0 1400 980' enable-background='new 0 0 1400 980' xml:space='preserve'>\r\n" + 
			"<g>\r\n" + 
			"	<rect fill='#565656' width='1400' height='980'/>\r\n" + 
			"	<g>\r\n" + 
			"		<g>\r\n" + 
			"			<linearGradient id='SVGID_1_' gradientUnits='userSpaceOnUse' x1='700' y1='-134.6851' x2='700' y2='1485.3464'>\r\n" + 
			"				<stop  offset='0' style='stop-color:#FFFFFF'/>\r\n" + 
			"				<stop  offset='1' style='stop-color:#D9D9D9'/>\r\n" + 
			"			</linearGradient>\r\n" + 
			"			<polygon fill='url(#SVGID_1_)' points='1272.8,85 1272.8,895 127.2,895 127.2,85 			'/>\r\n" + 
			"			<linearGradient id='SVGID_2_' gradientUnits='userSpaceOnUse' x1='700' y1='611.2206' x2='700' y2='1150.3622'>\r\n" + 
			"				<stop  offset='0' style='stop-color:#001C6E'/>\r\n" + 
			"				<stop  offset='1' style='stop-color:#00B4FF'/>\r\n" + 
			"			</linearGradient>\r\n" + 
			"			<path fill='url(#SVGID_2_)' d='M1272.8,736.8c-99.5,81.6-310.7,196.6-631.3,79.4c-258.8-94.6-514.3-41.9-514.3-41.9V895h1145.6\r\n" + 
			"				V736.8z'/>\r\n" + 
			"			<linearGradient id='SVGID_3_' gradientUnits='userSpaceOnUse' x1='700' y1='479.5082' x2='700' y2='979.9206'>\r\n" + 
			"				<stop  offset='0' style='stop-color:#001C6E'/>\r\n" + 
			"				<stop  offset='1' style='stop-color:#00B4FF'/>\r\n" + 
			"			</linearGradient>\r\n" + 
			"			<path opacity='0.73' fill='url(#SVGID_3_)' d='M127.2,736.8c99.5,81.6,310.7,196.6,631.3,79.4c258.8-94.6,514.3-41.9,514.3-41.9\r\n" + 
			"				V895H127.2V736.8z'/>\r\n" + 
			"			<g opacity='0.53'>\r\n" + 
			"				<path fill='none' d='M180.8,757.5c2.2-0.1,4.5-0.1,6.8-0.1c2.9-0.8,5.9-1.5,8.9-2.3c-2.3,0.2-4.6,0.4-6.9,0.6\r\n" + 
			"					C186.6,756.2,183.7,756.8,180.8,757.5z'/>\r\n" + 
			"				<path fill='none' d='M957,887.1c3.9,0.3,7.9,0.6,11.8,0.9c-3.2-1.1-6.4-2.1-9.6-3.3c-4,0-8-0.1-12-0.2\r\n" + 
			"					C950.4,885.4,953.7,886.3,957,887.1z'/>\r\n" + 
			"				<path fill='none' d='M376.7,768.5c75,10.4,146.6,28,212.9,52.2c88.3,32.3,174.2,50.7,256.8,55.1c-74-9-152.5-30.5-233.4-64\r\n" + 
			"					C548.1,784.9,476,766.8,399,758c-56.4-6.5-115.7-8-176.4-4.7c-4,1.3-7.9,2.6-11.8,3.8C267.1,757.2,322.8,761,376.7,768.5z'/>\r\n" + 
			"				<path fill='none' d='M944.3,883.7c4.3,0.2,8.6,0.3,12.8,0.3c-3.3-1.2-6.7-2.4-10-3.7c-4.4,0.1-8.7,0.3-13.1,0.3\r\n" + 
			"					C937.4,881.7,940.9,882.7,944.3,883.7z'/>\r\n" + 
			"				<path fill='none' d='M930.1,879.4c0.5,0.2,1.1,0.3,1.6,0.5c4.6,0,9.1-0.1,13.6-0.3c-3.3-1.3-6.7-2.6-10.1-3.9\r\n" + 
			"					c-4.7,0.3-9.3,0.6-14,0.9C924.2,877.6,927.1,878.5,930.1,879.4z'/>\r\n" + 
			"				<path fill='none' d='M229.6,749c2.2-0.2,4.4-0.5,6.6-0.7c2.8-0.9,5.7-1.7,8.5-2.6c-2.2,0.3-4.4,0.7-6.6,1.1\r\n" + 
			"					C235.3,747.5,232.4,748.2,229.6,749z'/>\r\n" + 
			"				<path fill='none' d='M488.1,713.6c85.8,2.6,159.8,22.5,219.8,59.3c77.9,47.7,149,82.3,211.4,103.1c4.8-0.2,9.6-0.5,14.4-0.8\r\n" + 
			"					c-59.4-23.8-125.7-60.3-202.5-111.2c-58.7-39-133.1-59.3-221-60.3c-65.6-0.7-138.8,9.2-217.9,29.5\r\n" + 
			"					C362.5,718.3,428.3,711.7,488.1,713.6z'/>\r\n" + 
			"				<path fill='none' d='M215,753c2.5-0.2,5-0.3,7.5-0.4c3.4-1.1,6.8-2.2,10.2-3.2c-2.6,0.3-5.1,0.6-7.7,0.9\r\n" + 
			"					C221.7,751.2,218.3,752.1,215,753z'/>\r\n" + 
			"				<path fill='none' d='M166.1,757.9c0.2,0,0.4-0.1,0.6-0.1c-0.4,0-0.8,0.1-1.2,0.1C165.7,757.9,165.9,757.9,166.1,757.9z'/>\r\n" + 
			"				<path fill='none' d='M970,890.3c3.4,0.5,6.8,0.9,10.2,1.3c-2.9-0.9-5.8-1.8-8.8-2.8c-3.4-0.2-6.8-0.4-10.3-0.7\r\n" + 
			"					C964.2,888.9,967.1,889.6,970,890.3z'/>\r\n" + 
			"				<path fill='none' d='M195.6,754.4c1.7-0.1,3.4-0.3,5.1-0.4c2.1-0.5,4.2-1,6.3-1.5c-1.6,0.2-3.3,0.4-4.9,0.7\r\n" + 
			"					C199.9,753.5,197.7,754,195.6,754.4z'/>\r\n" + 
			"				<path fill='none' d='M171.6,757.7c1.8-0.1,3.5-0.1,5.3-0.1c2.2-0.5,4.4-0.9,6.6-1.4c-1.7,0.2-3.5,0.3-5.2,0.5\r\n" + 
			"					C176,757,173.8,757.3,171.6,757.7z'/>\r\n" + 
			"				<path fill='none' d='M989.6,894.4c-1.8-0.5-3.7-1-5.5-1.6c-2-0.2-4-0.4-6-0.7C981.9,892.9,985.8,893.7,989.6,894.4z'/>\r\n" + 
			"				<path fill='none' d='M443.7,735.2c81.5,5.8,154.5,24.9,216.9,56.8c81.4,41.6,157.8,70.1,227.2,84.8c4.4,0,8.7-0.1,13.1-0.2\r\n" + 
			"					c-65.6-18-137.6-49.1-216.9-93.6c-61.1-34.3-134.5-53.8-218-58c-62.3-3.1-130.5,2.3-202.7,16c-2.8,0.8-5.6,1.6-8.5,2.4\r\n" + 
			"					C321.3,733.8,384.8,731,443.7,735.2z'/>\r\n" + 
			"				<path fill='none' d='M914.8,881.9c3.4,0.3,6.7,0.6,10.1,0.8c-2.9-0.7-5.8-1.3-8.7-2.1c-3.4-0.1-6.8-0.1-10.2-0.3\r\n" + 
			"					C908.9,880.9,911.8,881.4,914.8,881.9z'/>\r\n" + 
			"				<path fill='none' d='M200.7,754.7c-3.4,0.8-6.8,1.7-10.1,2.6c0.4,0,0.7,0,1.1,0c2.1,0,4.2,0,6.3-0.1c3.4-1,6.8-2,10.3-3\r\n" + 
			"					c-0.9,0.1-1.7,0.1-2.6,0.2C204.1,754.5,202.4,754.6,200.7,754.7z'/>\r\n" + 
			"				<path fill='none' d='M961.9,889.1c-1.6-0.4-3.3-0.8-5-1.3c-1.8-0.2-3.7-0.3-5.6-0.5C954.9,888,958.4,888.6,961.9,889.1z'/>\r\n" + 
			"				<path fill='none' d='M877.5,877.5c2.9,0.4,5.8,0.8,8.7,1.2c3.3,0.2,6.7,0.4,10,0.6c-2.8-0.6-5.7-1.1-8.5-1.7c-0.8,0-1.6,0-2.4,0\r\n" + 
			"					C882.7,877.5,880.1,877.5,877.5,877.5z'/>\r\n" + 
			"				<path fill='none' d='M421.4,746.2c79.3,7.3,151.8,25.9,215.5,55.4c83.1,38.4,162.3,63.6,235.4,75.1c4,0.1,8,0.1,12,0.1\r\n" + 
			"					c-68.6-14.9-143.9-43.2-224.1-84.2c-62.4-31.9-135.3-50.9-216.6-56.7c-60.3-4.3-125.5-1.2-193.8,9c-3.3,1-6.7,2-10,3\r\n" + 
			"					C303.1,741.5,364.1,740.9,421.4,746.2z'/>\r\n" + 
			"				<path fill='none' d='M897.8,878.8c1.1,0.2,2.2,0.4,3.4,0.6c4,0.2,7.9,0.3,11.9,0.4c-3.2-0.8-6.5-1.7-9.7-2.5\r\n" + 
			"					c-4.1,0.1-8.2,0.2-12.2,0.2C893.3,877.9,895.6,878.4,897.8,878.8z'/>\r\n" + 
			"				<path fill='none' d='M905.3,881c-1.4-0.3-2.8-0.5-4.3-0.8c-1.7-0.1-3.3-0.1-5-0.2C899.2,880.3,902.3,880.6,905.3,881z'/>\r\n" + 
			"				<path fill='none' d='M876.1,878c-1.3-0.2-2.6-0.4-3.9-0.6c-1.4,0-2.8,0-4.2-0.1C870.7,877.5,873.4,877.8,876.1,878z'/>\r\n" + 
			"				<path fill='none' d='M399.1,757.2c77.1,8.9,149.2,27,214.2,53.8c84.7,35,166.7,56.9,243.6,65.1c0.1,0,0.1,0,0.2,0\r\n" + 
			"					c3.3,0.1,6.7,0.2,10,0.3c-71.8-11.9-149.2-36.9-230.5-74.4c-63.6-29.4-136.1-48-215.3-55.3c-58.4-5.4-120.5-4.7-185,2.1\r\n" + 
			"					c-3.7,1.1-7.4,2.3-11,3.5C285.1,749.3,343.4,750.9,399.1,757.2z'/>\r\n" + 
			"				<path fill='none' d='M942.8,885.7c3.3,0.4,6.7,0.7,10,1c-2.8-0.8-5.7-1.5-8.6-2.4c-3.4-0.1-6.8-0.3-10.3-0.5\r\n" + 
			"					C936.9,884.6,939.8,885.2,942.8,885.7z'/>\r\n" + 
			"				<path fill='none' d='M933.9,884.7c-1.6-0.3-3.1-0.7-4.7-1c-1.7-0.1-3.4-0.2-5.2-0.3C927.4,883.8,930.7,884.2,933.9,884.7z'/>\r\n" + 
			"				<path fill='none' d='M220.2,750c1.6-0.2,3.1-0.4,4.6-0.5c2-0.5,4-1.1,6-1.6c-1.5,0.3-3,0.5-4.5,0.8\r\n" + 
			"					C224.3,749.1,222.3,749.6,220.2,750z'/>\r\n" + 
			"				<path fill='none' d='M200.7,757.2c2.6,0,5.2,0,7.8,0c3.7-1.2,7.5-2.5,11.3-3.7c-2.7,0.2-5.4,0.3-8.1,0.5\r\n" + 
			"					C208,755,204.3,756.1,200.7,757.2z'/>\r\n" + 
			"				<path fill='none' d='M245.4,744.8c1.5-0.2,2.9-0.4,4.4-0.7c1.8-0.5,3.7-1.1,5.5-1.6c-1.4,0.3-2.7,0.5-4.1,0.8\r\n" + 
			"					C249.2,743.9,247.3,744.3,245.4,744.8z'/>\r\n" + 
			"				<path fill='none' d='M213.7,751.6c-2.9,0.7-5.9,1.4-8.7,2.1c0.3,0,0.5,0,0.8-0.1c2-0.1,3.9-0.3,5.9-0.4c2.9-0.8,5.9-1.7,8.8-2.5\r\n" + 
			"					c-0.2,0-0.4,0-0.7,0.1C217.7,751.1,215.7,751.3,213.7,751.6z'/>\r\n" + 
			"				<path fill='none' d='M919.4,880.6c3.4,0.8,6.7,1.6,10,2.3c4,0.2,7.9,0.4,11.8,0.6c-3.2-0.9-6.5-1.9-9.7-2.9c-1.7,0-3.5,0-5.2,0\r\n" + 
			"					C924,880.7,921.7,880.6,919.4,880.6z'/>\r\n" + 
			"				<path fill='none' d='M465.9,724.3c83.6,4.2,157.1,23.7,218.3,58.1c80.2,45,152.9,76.3,219.1,94.2c4.6-0.1,9.3-0.3,13.9-0.5\r\n" + 
			"					c-62-20.9-132.5-55.3-209.7-102.6c-59.9-36.7-133.8-56.6-219.5-59.2c-64.4-1.9-135.6,5.8-211.9,23.1c-0.4,0.1-0.8,0.2-1.1,0.3\r\n" + 
			"					c-1.4,0.4-2.8,0.8-4.1,1.1C340.3,726.2,405.8,721.3,465.9,724.3z'/>\r\n" + 
			"				<path fill='none' d='M916.3,879.9c4.3,0.1,8.7,0.1,13,0.1c-3.3-1-6.7-2.1-10.1-3.3c-4.4,0.2-8.9,0.4-13.3,0.5\r\n" + 
			"					C909.4,878.1,912.8,879,916.3,879.9z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M891.1,877.5c4.1,0,8.2-0.1,12.2-0.2c-0.8-0.2-1.6-0.4-2.5-0.7c-4.3,0.1-8.7,0.2-13.1,0.2\r\n" + 
			"					C888.9,877,890,877.2,891.1,877.5z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M180.8,757.5c-1.3,0.3-2.5,0.5-3.8,0.8c2.5-0.1,5-0.1,7.6-0.2c1-0.3,2-0.5,3-0.8\r\n" + 
			"					C185.3,757.4,183,757.4,180.8,757.5z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M846.4,875.7c-82.7-4.4-168.5-22.8-256.8-55.1c-66.3-24.2-137.9-41.8-212.9-52.2\r\n" + 
			"					c-53.9-7.5-109.6-11.3-165.9-11.3c-0.7,0.2-1.5,0.5-2.2,0.7c57,0,113.4,3.7,167.9,11.3c74.9,10.4,146.5,27.9,212.8,52.2\r\n" + 
			"					C681.5,855,771,873.6,857,876.9c-0.1,0-0.1,0-0.2,0C853.4,876.6,849.9,876.2,846.4,875.7z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M171.6,757.7c-1.8,0.3-3.6,0.6-5.4,0.9c2.3-0.1,4.6-0.2,6.9-0.2c1.3-0.3,2.5-0.6,3.8-0.8\r\n" + 
			"					C175.1,757.6,173.3,757.6,171.6,757.7z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M165.5,757.9c-3.4,0.4-6.8,0.7-10.2,1.1c1.8-0.1,3.6-0.2,5.4-0.2c1.8-0.3,3.6-0.6,5.4-0.9\r\n" + 
			"					C165.9,757.9,165.7,757.9,165.5,757.9z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M868,877.3c1.4,0,2.8,0.1,4.2,0.1c-1.7-0.3-3.4-0.5-5.1-0.8c-3.3-0.1-6.7-0.2-10-0.3\r\n" + 
			"					C860.7,876.6,864.4,877,868,877.3z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M1272.8,752.1v-0.9c-53.7,39.6-132.9,84.8-235.9,108.6c-33.2,7.7-67.1,12.7-101.6,15.2\r\n" + 
			"					c0.5,0.2,1,0.4,1.5,0.6c34-2.5,67.5-7.5,100.2-15.1C1139.9,836.8,1219.1,791.7,1272.8,752.1z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M191.7,757.3c-0.4,0-0.7,0-1.1,0c-1,0.3-2,0.5-3,0.8c1.4,0,2.7,0,4.1-0.1c1.3,0,2.6,0,3.8,0\r\n" + 
			"					c0.8-0.2,1.7-0.5,2.5-0.7C196,757.2,193.8,757.2,191.7,757.3z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M200.7,757.2c-0.8,0.2-1.7,0.5-2.5,0.7c2.7,0,5.5,0,8.2-0.1c0.7-0.2,1.4-0.5,2.2-0.7\r\n" + 
			"					C205.9,757.1,203.3,757.1,200.7,757.2z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M921.2,876.6c4.7-0.2,9.4-0.5,14-0.9c-0.5-0.2-1-0.4-1.6-0.6c-4.8,0.3-9.6,0.6-14.4,0.8\r\n" + 
			"					C919.9,876.2,920.6,876.4,921.2,876.6z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M872.3,876.7c1.7,0.3,3.4,0.5,5,0.8c0,0,0.1,0,0.1,0c2.6,0,5.2,0,7.8,0c0.8,0,1.6,0,2.4,0\r\n" + 
			"					c-1.1-0.2-2.2-0.5-3.4-0.7C880.3,876.8,876.3,876.7,872.3,876.7z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M127.2,759.8v0.7c5.8-0.4,11.8-0.7,18-1.1c3.3-0.4,6.7-0.8,10.1-1.2\r\n" + 
			"					C145.5,758.7,136.1,759.2,127.2,759.8z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M905.9,877.2c4.4-0.1,8.9-0.3,13.3-0.5c-0.6-0.2-1.2-0.4-1.9-0.6c-4.6,0.2-9.3,0.4-13.9,0.5\r\n" + 
			"					C904.2,876.8,905.1,877,905.9,877.2z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M896.1,879.9c1.7,0.1,3.3,0.2,5,0.2c-1.1-0.2-2.3-0.4-3.4-0.6c-0.5-0.1-1-0.2-1.4-0.3\r\n" + 
			"					c-3.3-0.2-6.7-0.3-10-0.6C889.5,879.1,892.8,879.5,896.1,879.9z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M211.7,754c2.7-0.2,5.4-0.4,8.1-0.5c0.9-0.3,1.8-0.6,2.7-0.9c-2.5,0.1-5,0.3-7.5,0.4\r\n" + 
			"					C213.9,753.3,212.8,753.6,211.7,754z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M166.8,757.8c3.8-0.6,7.6-1.3,11.4-1.9c-7.8,0.7-15.5,1.5-22.9,2.4c-3.4,0.4-6.8,0.8-10.1,1.2\r\n" + 
			"					c-6.2,0.8-12.1,1.5-18,2.4v0.7c9-1.2,18.3-2.5,28.1-3.6c3.4-0.4,6.8-0.8,10.2-1.1C165.9,757.9,166.3,757.8,166.8,757.8z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M876.1,878c-2.7-0.2-5.4-0.4-8.1-0.7c-3.6-0.3-7.3-0.7-11-1.1c-0.1,0-0.1,0-0.2,0\r\n" + 
			"					c-77-8.2-158.9-30.1-243.6-65.1c-65-26.9-137.1-45-214.2-53.8c-55.6-6.4-114-8-173.7-4.8c-0.9,0.3-1.8,0.6-2.7,0.9\r\n" + 
			"					c60.7-3.4,119.9-1.8,176.4,4.7c77.1,8.9,149.1,27,214,53.8c81,33.5,159.4,55,233.4,64c3.5,0.4,6.9,0.8,10.4,1.2\r\n" + 
			"					c0.1,0,0.1,0,0.2,0c9.8,1,19.5,1.8,29.1,2.5c-2.9-0.4-5.9-0.8-8.9-1.2C876.9,878.1,876.5,878,876.1,878z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M1049.4,867.8c50.5-11,99.5-29.3,145.7-54.3c26.3-14.3,51.9-30.8,77.7-50.2v-0.9\r\n" + 
			"					c-25.9,19.5-51.6,36.1-78,50.4c-46.1,25.1-95.1,43.3-145.6,54.3c-32.9,7.1-67,11.3-102,12.5c0.6,0.2,1.2,0.4,1.8,0.7\r\n" + 
			"					C983.4,879,1017,874.8,1049.4,867.8z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M204.9,753.7c-1.4,0.3-2.8,0.7-4.2,1c1.7-0.1,3.3-0.2,5-0.4c0.9-0.1,1.7-0.1,2.6-0.2\r\n" + 
			"					c1.1-0.3,2.2-0.6,3.3-0.9c-2,0.1-3.9,0.2-5.9,0.4C205.4,753.6,205.2,753.7,204.9,753.7z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M183.4,756.1c1.9-0.4,3.8-0.8,5.7-1.2c-3.7,0.5-7.3,1.1-10.9,1.7C180,756.5,181.7,756.3,183.4,756.1z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M906,880.3c3.4,0.1,6.8,0.2,10.2,0.3c-1-0.3-2.1-0.5-3.1-0.8c-4-0.1-7.9-0.2-11.9-0.4\r\n" + 
			"					C902.8,879.7,904.4,880,906,880.3z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M916.3,879.9c1,0.3,2.1,0.5,3.1,0.8c2.3,0,4.6,0,6.9,0c1.8,0,3.5,0,5.2,0c-0.6-0.2-1.1-0.3-1.7-0.5\r\n" + 
			"					c-0.2-0.1-0.4-0.1-0.6-0.2C925,880,920.6,879.9,916.3,879.9z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M189.6,755.6c2.3-0.2,4.6-0.4,6.9-0.6c1.4-0.4,2.8-0.7,4.2-1.1c-1.7,0.1-3.4,0.3-5.1,0.4\r\n" + 
			"					C193.6,754.8,191.6,755.2,189.6,755.6z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M934,880.6c4.4-0.1,8.8-0.2,13.1-0.3c-0.6-0.2-1.1-0.4-1.7-0.6c0,0,0,0-0.1,0c-4.5,0.1-9.1,0.2-13.6,0.3\r\n" + 
			"					C932.4,880.2,933.2,880.4,934,880.6z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M933.9,883.9c3.4,0.2,6.9,0.3,10.3,0.5c-1-0.3-1.9-0.5-2.9-0.8c-3.9-0.2-7.9-0.4-11.8-0.6\r\n" + 
			"					C930.9,883.3,932.4,883.6,933.9,883.9z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M213.7,751.6c2-0.3,4-0.5,6.1-0.7c0.2,0,0.4,0,0.7-0.1c1.5-0.4,3-0.8,4.5-1.2c-1.5,0.2-3.1,0.3-4.6,0.5\r\n" + 
			"					C218,750.6,215.8,751.1,213.7,751.6z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M924.1,883.3c1.7,0.1,3.5,0.2,5.2,0.3c-1.5-0.3-2.9-0.7-4.4-1c-3.3-0.2-6.7-0.5-10.1-0.8\r\n" + 
			"					C917.9,882.4,921,882.8,924.1,883.3z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M896.1,879.9c-3.3-0.4-6.6-0.8-9.9-1.3c-2.9-0.4-5.8-0.8-8.7-1.2c0,0-0.1,0-0.1,0\r\n" + 
			"					c-1.7-0.3-3.4-0.5-5-0.8c-73.1-11.5-152.3-36.8-235.4-75.1c-63.7-29.4-136.2-48-215.5-55.4c-57.3-5.3-118.3-4.7-181.5,1.7\r\n" + 
			"					c-1.2,0.4-2.4,0.7-3.6,1.1c64.5-6.8,126.6-7.5,185-2.1c79.2,7.3,151.6,25.9,215.3,55.3c81.2,37.5,158.7,62.5,230.5,74.4\r\n" + 
			"					c1.7,0.3,3.4,0.6,5.1,0.8c1.3,0.2,2.6,0.4,3.9,0.6c0.4,0.1,0.7,0.1,1.1,0.2c3,0.4,5.9,0.8,8.9,1.2c9.5,1.3,19,2.3,28.4,3.1\r\n" + 
			"					c-3.1-0.5-6.1-1-9.2-1.6C902.3,880.6,899.2,880.3,896.1,879.9z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M178.3,756.6c3.6-0.6,7.2-1.1,10.9-1.7c4.2-0.9,8.4-1.7,12.7-2.5c-8.1,1.1-16,2.3-23.7,3.5\r\n" + 
			"					c-3.9,0.6-7.7,1.2-11.4,1.9c-0.2,0-0.4,0.1-0.6,0.1c-1.8,0.3-3.6,0.6-5.4,0.9c-11.7,2-22.9,4.2-33.5,6.3v0.7\r\n" + 
			"					c12.3-2.5,25.3-5,39-7.3c1.8-0.3,3.6-0.6,5.4-0.9C173.8,757.3,176,757,178.3,756.6z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M206.9,752.5c1.8-0.4,3.6-0.9,5.4-1.3c-3.4,0.6-6.9,1.3-10.2,1.9C203.6,752.9,205.3,752.7,206.9,752.5z'\r\n" + 
			"					/>\r\n" + 
			"				<path fill='#FFFFFF' d='M963.8,884.7c33.8,0,66.5-3.2,97.9-9.5c89.6-18.2,156.8-59.1,211.2-100.8v-0.9\r\n" + 
			"					c-54.4,41.7-121.6,82.8-211.3,101c-32.6,6.6-66.8,9.8-102.1,9.5c0.7,0.2,1.4,0.5,2.1,0.7C962.2,884.7,963,884.7,963.8,884.7z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M225,750.2c2.6-0.3,5.1-0.6,7.7-0.9c1.2-0.4,2.3-0.7,3.5-1.1c-2.2,0.2-4.4,0.5-6.6,0.7\r\n" + 
			"					C228.1,749.4,226.5,749.8,225,750.2z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M947.1,884.5c4,0.1,8,0.2,12,0.2c-0.7-0.2-1.4-0.5-2-0.7c-4.3-0.1-8.5-0.2-12.8-0.3\r\n" + 
			"					C945.2,883.9,946.2,884.2,947.1,884.5z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M961.2,888.2c3.4,0.3,6.9,0.5,10.3,0.7c-0.9-0.3-1.8-0.6-2.7-0.9c-3.9-0.2-7.8-0.5-11.8-0.9\r\n" + 
			"					C958.4,887.5,959.8,887.8,961.2,888.2z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M189.6,755.6c2-0.4,4-0.8,6-1.2c2.1-0.4,4.3-0.9,6.4-1.3c3.4-0.7,6.8-1.3,10.2-1.9\r\n" + 
			"					c4.6-1.1,9.3-2.2,14-3.2c-8.3,1.4-16.4,2.9-24.3,4.5c-4.3,0.8-8.5,1.7-12.7,2.5c-1.9,0.4-3.8,0.8-5.7,1.2\r\n" + 
			"					c-2.2,0.5-4.4,0.9-6.6,1.4c-1.3,0.3-2.5,0.6-3.8,0.8c-16.2,3.6-31.6,7.3-45.9,11.1v0.7c15.5-4.1,32.1-8.1,49.8-11.9\r\n" + 
			"					c1.3-0.3,2.5-0.5,3.8-0.8C183.7,756.8,186.6,756.2,189.6,755.6z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M924.1,883.3c-3.1-0.5-6.2-0.9-9.3-1.4c-2.9-0.5-5.9-1-8.8-1.5c-1.6-0.3-3.2-0.6-4.8-0.9\r\n" + 
			"					c-1.1-0.2-2.2-0.4-3.4-0.6c-2.2-0.4-4.5-0.9-6.7-1.3c-1.1-0.2-2.2-0.5-3.3-0.7C818.4,862,742,833.5,660.6,792\r\n" + 
			"					c-62.5-31.9-135.4-51-216.9-56.8c-58.9-4.2-122.4-1.4-188.9,8.3c-1.6,0.5-3.3,1-4.9,1.4c68.3-10.2,133.4-13.2,193.8-9\r\n" + 
			"					c81.4,5.7,154.3,24.8,216.6,56.7c80.2,41,155.5,69.2,224.1,84.2c1.1,0.2,2.2,0.5,3.4,0.7c2.8,0.6,5.7,1.2,8.5,1.7\r\n" + 
			"					c0.5,0.1,1,0.2,1.4,0.3c1.1,0.2,2.3,0.4,3.4,0.6c1.4,0.3,2.8,0.5,4.3,0.8c3.1,0.6,6.1,1.1,9.2,1.6c9.5,1.6,18.8,2.9,28.1,3.9\r\n" + 
			"					c-2.9-0.6-5.8-1.2-8.7-1.8C930.7,884.2,927.4,883.8,924.1,883.3z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M230.9,747.9c1.6-0.4,3.3-0.9,4.9-1.3c-3.2,0.7-6.3,1.4-9.4,2.1C227.9,748.4,229.4,748.1,230.9,747.9z'\r\n" + 
			"					/>\r\n" + 
			"				<path fill='#FFFFFF' d='M997.6,889.6c26.4,0,51.8-2.3,76.2-6.8c83.3-15.5,144.8-54.8,199-97.2v-0.9\r\n" + 
			"					c-54.2,42.5-115.7,81.9-199.1,97.4c-32.3,6-66.4,8-102.1,6.1c0.9,0.3,1.8,0.6,2.7,0.9C982.2,889.4,990,889.6,997.6,889.6z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M238.1,746.7c2.2-0.4,4.4-0.7,6.6-1.1c1.7-0.5,3.3-1,5-1.5c-1.5,0.2-2.9,0.4-4.4,0.7\r\n" + 
			"					C242.9,745.5,240.5,746.1,238.1,746.7z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M951.4,887.3c1.9,0.2,3.7,0.3,5.6,0.5c-1.4-0.4-2.8-0.7-4.2-1.1c-3.3-0.3-6.6-0.6-10-1\r\n" + 
			"					C945.7,886.3,948.5,886.8,951.4,887.3z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M200.7,754.7c1.4-0.3,2.8-0.7,4.2-1c2.9-0.7,5.8-1.4,8.7-2.1c2.2-0.5,4.4-1,6.6-1.5\r\n" + 
			"					c2-0.5,4.1-0.9,6.1-1.4c3.1-0.7,6.3-1.4,9.4-2.1c5-1.3,10.1-2.6,15.1-3.9c-1.2,0.2-2.4,0.5-3.6,0.7c-7.1,1.5-14.2,3-21.2,4.5\r\n" + 
			"					c-4.7,1.1-9.4,2.1-14,3.2c-1.8,0.4-3.6,0.9-5.4,1.3c-2.1,0.5-4.2,1-6.3,1.5c-1.4,0.3-2.8,0.7-4.2,1.1c-3,0.8-6,1.5-8.9,2.3\r\n" + 
			"					c-1,0.3-2,0.5-3,0.8c-20.5,5.4-39.7,11-57.4,16.5v0.8c18.5-5.8,38.8-11.7,60.4-17.3c1-0.3,2-0.5,3-0.8\r\n" + 
			"					C194,756.4,197.3,755.6,200.7,754.7z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M255.2,742.6c1.5-0.4,3-0.9,4.4-1.3c-2.9,0.7-5.7,1.4-8.6,2.1C252.5,743.1,253.9,742.8,255.2,742.6z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M1016.4,895h22.8c14.8-0.4,29.3-1.8,43.3-4c81.8-12.9,140-53.8,190.3-94.2v-0.9\r\n" + 
			"					c-50.3,40.5-108.6,81.5-190.4,94.4c-30.9,4.9-63.5,5.5-98.2,1.7c1.3,0.4,2.6,0.8,3.9,1.1C997.7,894.1,1007.1,894.7,1016.4,895z'\r\n" + 
			"					/>\r\n" + 
			"				<path fill='#FFFFFF' d='M978,892.1c2,0.2,4,0.5,6,0.7c-1.3-0.4-2.6-0.8-3.9-1.2c-3.4-0.4-6.8-0.8-10.2-1.3\r\n" + 
			"					C972.7,890.9,975.4,891.5,978,892.1z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M951.4,887.3c-2.9-0.5-5.7-1.1-8.6-1.6c-2.9-0.6-5.9-1.2-8.9-1.8c-1.5-0.3-3-0.6-4.5-1\r\n" + 
			"					c-3.3-0.7-6.7-1.5-10-2.3c-1-0.3-2.1-0.5-3.1-0.8c-3.4-0.9-6.9-1.7-10.4-2.7c-0.8-0.2-1.6-0.4-2.5-0.7\r\n" + 
			"					c-66.2-17.9-139-49.2-219.1-94.2c-61.2-34.3-134.7-53.9-218.3-58.1c-60.1-3-125.6,1.9-195,14.5c-2.6,0.7-5.2,1.4-7.8,2.2\r\n" + 
			"					c72.2-13.7,140.4-19.1,202.7-16c83.5,4.2,156.9,23.7,218,58c79.3,44.5,151.3,75.6,216.9,93.6c0.8,0.2,1.6,0.4,2.5,0.7\r\n" + 
			"					c3.3,0.9,6.5,1.7,9.7,2.5c1,0.3,2.1,0.5,3.1,0.8c2.9,0.7,5.8,1.4,8.7,2.1c1.5,0.3,3,0.7,4.4,1c1.6,0.3,3.1,0.7,4.7,1\r\n" + 
			"					c2.9,0.6,5.8,1.2,8.7,1.8c9.2,1.8,18.3,3.3,27.3,4.6c-2.7-0.6-5.3-1.3-8-1.9C958.4,888.6,954.9,888,951.4,887.3z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M211.7,754c1.1-0.3,2.2-0.6,3.3-0.9c3.3-0.9,6.6-1.9,10-2.8c1.5-0.4,3.1-0.8,4.6-1.3\r\n" + 
			"					c2.8-0.8,5.6-1.5,8.5-2.3c2.4-0.6,4.8-1.3,7.3-1.9c1.9-0.5,3.8-1,5.7-1.5c2.8-0.7,5.7-1.4,8.6-2.1c5-1.5,10.1-2.9,15.2-4.3\r\n" + 
			"					c0.4-0.1,0.8-0.2,1.2-0.3c-4.9,1.1-9.9,2.3-14.9,3.5c-3.4,0.8-6.8,1.7-10.2,2.5c-5.1,1.3-10.1,2.6-15.1,3.9\r\n" + 
			"					c-1.7,0.4-3.3,0.9-4.9,1.3c-2,0.5-4,1.1-6,1.6c-1.5,0.4-3,0.8-4.5,1.2c-3,0.8-5.9,1.6-8.8,2.5c-1.1,0.3-2.2,0.6-3.3,0.9\r\n" + 
			"					c-3.4,1-6.9,2-10.3,3c-0.8,0.2-1.7,0.5-2.5,0.7c-24.6,7.4-47.6,15.1-68.4,22.6v0.8c21.5-7.7,45.4-15.7,71-23.3\r\n" + 
			"					c0.8-0.3,1.7-0.5,2.5-0.7C204.3,756.1,208,755,211.7,754z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M978,892.1c-2.7-0.6-5.3-1.2-8-1.8c-2.9-0.7-5.9-1.4-8.8-2.1c-1.4-0.4-2.8-0.7-4.2-1.1\r\n" + 
			"					c-3.3-0.8-6.6-1.7-9.9-2.7c-0.9-0.3-1.9-0.5-2.8-0.8c-3.4-1-6.9-2-10.3-3c-0.8-0.2-1.5-0.5-2.3-0.7c-0.5-0.2-1.1-0.3-1.6-0.5\r\n" + 
			"					c-2.9-0.9-5.9-1.9-8.9-2.9c-0.6-0.2-1.3-0.4-1.9-0.6c-62.4-20.8-133.4-55.4-211.4-103.1c-60-36.7-134-56.7-219.8-59.3\r\n" + 
			"					c-59.9-1.8-125.6,4.8-195.8,19.6c-5.3,1.4-10.7,2.8-16.1,4.3c76.3-17.3,147.5-25.1,211.9-23.1c85.7,2.6,159.5,22.5,219.5,59.2\r\n" + 
			"					c77.2,47.3,147.7,81.7,209.7,102.6c0.6,0.2,1.2,0.4,1.9,0.6c3.4,1.1,6.7,2.2,10.1,3.3c0.2,0.1,0.4,0.1,0.6,0.2\r\n" + 
			"					c0.6,0.2,1.1,0.3,1.7,0.5c3.3,1,6.5,2,9.7,2.9c1,0.3,1.9,0.6,2.9,0.8c2.9,0.8,5.7,1.6,8.6,2.4c1.4,0.4,2.8,0.7,4.2,1.1\r\n" + 
			"					c1.7,0.4,3.3,0.9,5,1.3c2.7,0.7,5.4,1.3,8,1.9c6.5,1.5,12.9,2.8,19.2,4h2.8c-0.8-0.2-1.5-0.4-2.3-0.6\r\n" + 
			"					C985.8,893.7,981.9,892.9,978,892.1z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M1115.8,895c65.3-14.2,112.4-50.2,157-87v-0.9c-45.4,37.5-93.4,74.2-160.5,87.9H1115.8z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M731.6,763.3c-58.9-39.1-133.3-59.4-221.4-60.4c-70.1-0.8-148.9,10.6-234.2,33.8\r\n" + 
			"					c-0.4,0.1-0.8,0.2-1.2,0.3c-5.1,1.4-10.2,2.8-15.2,4.3c-1.5,0.4-3,0.9-4.4,1.3c-1.8,0.5-3.7,1.1-5.5,1.6c-1.7,0.5-3.3,1-5,1.5\r\n" + 
			"					c-2.9,0.9-5.7,1.7-8.5,2.6c-1.2,0.4-2.3,0.7-3.5,1.1c-3.4,1.1-6.8,2.1-10.2,3.2c-0.9,0.3-1.8,0.6-2.7,0.9\r\n" + 
			"					c-3.8,1.2-7.5,2.4-11.3,3.7c-0.7,0.2-1.4,0.5-2.2,0.7c-28.7,9.6-55.3,19.6-79.2,29.1v0.8c24.5-9.8,51.9-20,81.4-29.9\r\n" + 
			"					c0.7-0.2,1.5-0.5,2.2-0.7c3.9-1.3,7.8-2.6,11.8-3.8c0.9-0.3,1.8-0.6,2.7-0.9c3.6-1.2,7.3-2.3,11-3.5c1.2-0.4,2.4-0.7,3.6-1.1\r\n" + 
			"					c3.3-1,6.6-2,10-3c1.6-0.5,3.2-1,4.9-1.4c2.8-0.8,5.6-1.6,8.5-2.4c2.6-0.7,5.2-1.5,7.8-2.2c1.4-0.4,2.8-0.8,4.1-1.1\r\n" + 
			"					c0.4-0.1,0.8-0.2,1.1-0.3c5.4-1.5,10.7-2.9,16.1-4.3c79.1-20.4,152.3-30.3,217.9-29.5c87.9,1,162.2,21.3,221,60.3\r\n" + 
			"					c76.7,50.9,143.1,87.4,202.5,111.2c0.5,0.2,1,0.4,1.6,0.6c3.4,1.3,6.8,2.7,10.1,3.9c0,0,0,0,0.1,0c0.6,0.2,1.1,0.4,1.7,0.6\r\n" + 
			"					c3.4,1.3,6.7,2.5,10,3.7c0.7,0.2,1.4,0.5,2,0.7c3.2,1.1,6.4,2.2,9.6,3.3c0.9,0.3,1.8,0.6,2.7,0.9c2.9,1,5.9,1.9,8.8,2.8\r\n" + 
			"					c1.3,0.4,2.6,0.8,3.9,1.2c1.8,0.5,3.7,1.1,5.5,1.6c0.8,0.2,1.5,0.4,2.3,0.6h2.8c-2.2-0.6-4.4-1.2-6.6-1.8\r\n" + 
			"					c-1.3-0.4-2.6-0.7-3.9-1.1c-3.3-1-6.6-2-9.9-3c-0.9-0.3-1.8-0.6-2.7-0.9c-3.4-1.1-6.8-2.2-10.2-3.4c-0.7-0.2-1.4-0.5-2.1-0.7\r\n" + 
			"					c-3.4-1.2-6.9-2.5-10.4-3.7c-0.6-0.2-1.2-0.4-1.8-0.7c-0.5-0.2-1.1-0.4-1.6-0.6c-2.9-1.1-5.8-2.2-8.8-3.4\r\n" + 
			"					c-0.5-0.2-1-0.4-1.5-0.6C875.7,851.2,808.9,814.6,731.6,763.3z'/>\r\n" + 
			"				<path fill='#FFFFFF' d='M1272.8,818.3c-24.4,20.7-49.7,41.8-77.9,58c-13.4,7.7-26.9,13.9-40.7,18.6h2.2\r\n" + 
			"					c13.1-4.7,26-10.7,38.8-18c28.1-16.1,53.3-37.1,77.6-57.7V818.3z'/>\r\n" + 
			"			</g>\r\n" + 
			"		</g>\r\n" + 
			"		<g>\r\n" + 
			"			<g>\r\n" + 
			"				<text transform='matrix(1 0 0 1 508.3564 193.3515)'><tspan x='0' y='0' font-family=''PlayfairDisplay-Regular'' font-size='60.8788px'>CE</tspan><tspan x='79' y='0' font-family=''PlayfairDisplay-Regular'' font-size='60.8788px'>R</tspan><tspan x='118' y='0' font-family=''PlayfairDisplay-Regular'' font-size='60.8788px'>TIF</tspan><tspan x='211.1' y='0' font-family=''PlayfairDisplay-Regular'' font-size='60.8788px'>I</tspan><tspan x='231.2' y='0' font-family=''PlayfairDisplay-Regular'' font-size='60.8788px'>C</tspan><tspan x='273.1' y='0' font-family=''PlayfairDisplay-Regular'' font-size='60.8788px' letter-spacing='-3'>A</tspan><tspan x='308.4' y='0' font-family=''PlayfairDisplay-Regular'' font-size='60.8788px'>TE</tspan></text>\r\n" + 
			"				<text transform='matrix(1 0 0 1 600.438 228.1708)'>\r\n" + 
			"				<tspan x='0' y='0' font-family=''PlayfairDisplay-Regular'' font-size='20.513px' letter-spacing='2'>of\r\n" + 
			"				Achivement</text>\r\n" + 
			"				<text transform='matrix(1 0 0 1 540.6753 302.7734)'>\r\n" + 
			"				<tspan x='0' y='0' font-family=''PlayfairDisplay-Regular'' font-size='16.8108px' letter-spacing='1'>This Certificate is Proudly Presented to :</text>\r\n" + 
			"				<text transform='matrix(1 0 0 1 480.8125 419.1664)' font-family=''GreatVibes-Regular'' font-size='80.7766px'>\r\n" + 
			"				Rakshit Shetty</text>\r\n" + 
			"				This is to certify that Rakshit Shetty has successfully scored 78% in \r\n" + 
			"\r\n" + 
			"\r\n" + 
			"\r\n" + 
			"\r\n" + 
			"				<rect x='302.6' y='479.6' fill='none' width='794.8' height='66.2'/>\r\n" + 
			"				<text transform='matrix(1 0 0 1 500.438 491.2031)'><tspan x='0' y='0' font-family=''OpenSans'' font-size='15.2853px'>\r\n" + 
			"				This is to certify that Rakshit Shetty has successfully scored 78% in \r\n" + 
			"				</tspan><tspan x='45.3' y='18.3' font-family=''OpenSans'' font-size='15.2853px'>\r\n" + 
			"				Java SE Mock  Exam offered by Examhub.com \r\n" + 
			"				</tspan>\r\n" + 
			"				</text>\r\n" + 
			"				<g>\r\n" + 
			"					<text transform='matrix(1 0 0 1 350.6592 680.9277)'><tspan x='0' y='0'\r\n" + 
			"					font-family=''PlayfairDisplay-Regular'' font-size='25.077px' letter-spacing='1'>Dated : 22/02/2020.</tspan></text>\r\n" + 
			"				</g>\r\n" + 
			"				\r\n" + 
			"				<g>\r\n" + 
			"					<text transform='matrix(1 0 0 1 833.6592 680.9277)'><tspan x='0' y='0'\r\n" + 
			"					font-family=''PlayfairDisplay-Regular'' font-size='18.077px' letter-spacing='1'>Cert Id : 12345-7654321-4321.</tspan></text>\r\n" + 
			"				</g>\r\n" + 
			"\r\n" + 
			"			</g>\r\n" + 
			"			<g>\r\n" + 
			"				<g>\r\n" + 
			"					<g>\r\n" + 
			"						\r\n" + 
			"							<linearGradient id='SVGID_4_' gradientUnits='userSpaceOnUse' x1='649.7767' y1='604.4501' x2='649.7767' y2='846.4563' gradientTransform='matrix(0.9542 0.2991 -0.2991 0.9542 270.3629 -172.9024)'>\r\n" + 
			"							<stop  offset='0' style='stop-color:#E93400'/>\r\n" + 
			"							<stop  offset='1' style='stop-color:#942500'/>\r\n" + 
			"						</linearGradient>\r\n" + 
			"						<polygon fill='url(#SVGID_4_)' points='692.9,754.2 670.1,729.2 634.2,735.8 670.4,620.3 729.1,638.7 						'/>\r\n" + 
			"						\r\n" + 
			"							<linearGradient id='SVGID_5_' gradientUnits='userSpaceOnUse' x1='649.7767' y1='626.5754' x2='649.7767' y2='692.9128' gradientTransform='matrix(0.9542 0.2991 -0.2991 0.9542 270.3629 -172.9024)'>\r\n" + 
			"							<stop  offset='0' style='stop-color:#FFFFFF'/>\r\n" + 
			"							<stop  offset='1' style='stop-color:#D9D9D9'/>\r\n" + 
			"						</linearGradient>\r\n" + 
			"						<polygon fill='url(#SVGID_5_)' points='656.4,731.7 670.1,729.2 677.3,737.2 710.1,632.8 689.5,626.3 						'/>\r\n" + 
			"					</g>\r\n" + 
			"					<g>\r\n" + 
			"						\r\n" + 
			"							<linearGradient id='SVGID_6_' gradientUnits='userSpaceOnUse' x1='813.7444' y1='569.0437' x2='813.7444' y2='811.0499' gradientTransform='matrix(-0.9542 0.2991 0.2991 0.9542 1302.4109 -172.9024)'>\r\n" + 
			"							<stop  offset='0' style='stop-color:#E93400'/>\r\n" + 
			"							<stop  offset='1' style='stop-color:#942500'/>\r\n" + 
			"						</linearGradient>\r\n" + 
			"						<polygon fill='url(#SVGID_6_)' points='712.8,769.5 735.6,744.5 771.5,751.1 735.3,635.6 676.6,654 						'/>\r\n" + 
			"						\r\n" + 
			"							<linearGradient id='SVGID_7_' gradientUnits='userSpaceOnUse' x1='813.7444' y1='591.169' x2='813.7444' y2='657.5064' gradientTransform='matrix(-0.9542 0.2991 0.2991 0.9542 1302.4109 -172.9024)'>\r\n" + 
			"							<stop  offset='0' style='stop-color:#FFFFFF'/>\r\n" + 
			"							<stop  offset='1' style='stop-color:#D9D9D9'/>\r\n" + 
			"						</linearGradient>\r\n" + 
			"						<polygon fill='url(#SVGID_7_)' points='749.3,747 735.6,744.5 728.4,752.4 695.7,648 716.2,641.6 						'/>\r\n" + 
			"					</g>\r\n" + 
			"				</g>\r\n" + 
			"				<linearGradient id='SVGID_8_' gradientUnits='userSpaceOnUse' x1='700' y1='516.8008' x2='700' y2='815.7063'>\r\n" + 
			"					<stop  offset='0' style='stop-color:#E93400'/>\r\n" + 
			"					<stop  offset='1' style='stop-color:#942500'/>\r\n" + 
			"				</linearGradient>\r\n" + 
			"				<polygon fill='url(#SVGID_8_)' points='700,562.6 709.8,557.3 718,565 728.8,562.4 734.7,571.9 745.9,572.3 749.1,582.9 \r\n" + 
			"					759.8,586.2 760.2,597.3 769.6,603.2 767.1,614.1 774.7,622.2 769.5,632.1 774.7,641.9 767.1,650 769.6,660.9 760.2,666.8 \r\n" + 
			"					759.8,677.9 749.1,681.2 745.9,691.9 734.7,692.2 728.8,701.7 718,699.2 709.8,706.8 700,701.5 690.2,706.8 682,699.2 \r\n" + 
			"					671.2,701.7 665.3,692.2 654.1,691.9 650.9,681.2 640.2,677.9 639.8,666.8 630.4,660.9 632.9,650 625.3,641.9 630.5,632.1 \r\n" + 
			"					625.3,622.2 632.9,614.1 630.4,603.2 639.8,597.3 640.2,586.2 650.9,582.9 654.1,572.3 665.3,571.9 671.2,562.4 682,565 \r\n" + 
			"					690.2,557.3 				'/>\r\n" + 
			"				<linearGradient id='SVGID_9_' gradientUnits='userSpaceOnUse' x1='700' y1='545.3746' x2='700' y2='770.1781'>\r\n" + 
			"					<stop  offset='0' style='stop-color:#FFFFFF'/>\r\n" + 
			"					<stop  offset='1' style='stop-color:#D9D9D9'/>\r\n" + 
			"				</linearGradient>\r\n" + 
			"				<circle fill='url(#SVGID_9_)' cx='700' cy='632.1' r='56.2'/>\r\n" + 
			"				<linearGradient id='SVGID_10_' gradientUnits='userSpaceOnUse' x1='700' y1='580.5156' x2='700' y2='683.6023'>\r\n" + 
			"					<stop  offset='0' style='stop-color:#E93400'/>\r\n" + 
			"					<stop  offset='1' style='stop-color:#942500'/>\r\n" + 
			"				</linearGradient>\r\n" + 
			"				<circle fill='none' stroke='url(#SVGID_10_)' stroke-width='0.897' stroke-miterlimit='10' cx='700' cy='632.1' r='51.1'/>\r\n" + 
			"				<g>\r\n" + 
			"					<text transform='matrix(1 0 0 1 665.2383 624.6161)' font-family=''GreatVibes-Regular'' font-size='18.2707px'>Examhub</text>\r\n" + 
			"					<text transform='matrix(1 0 0 1 664.5269 649.2509)' font-family=''GreatVibes-Regular'' font-size='18.2707px'>Certified</text>\r\n" + 
			"				</g>\r\n" + 
			"			</g>\r\n" + 
			"		</g>\r\n" + 
			"	</g>\r\n" + 
			"</g>\r\n" + 
			"</svg>\r\n" + 
			"";
	
	
	
}



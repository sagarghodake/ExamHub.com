package com.examhub.test;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.examhub.dao.ExamDao;
import com.examhub.dao.TestDao;
import com.examhub.impl.ExamDaoImpl;
import com.examhub.impl.TestDaoImpl;
import com.examhub.pojo.Exam;
import com.examhub.pojo.Test;

/**
 * Servlet implementation class TestServlet
 */
@WebServlet("/testServlet")
public class TestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	TestDao testDaoImpl = new TestDaoImpl();
	ExamDao examDaoImpl = new ExamDaoImpl();
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public TestServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String opeartion = request.getParameter("operation");
		String studentUsername = (String) request.getSession().getAttribute("studentLogin");

		if (opeartion.equalsIgnoreCase("view")) {

			String examId = request.getParameter("examId");
			List<Test> listOfAlltest = null;
			if (examId == null) {
				listOfAlltest = testDaoImpl.viewAllTest();
			} else {
				int secId = Integer.parseInt(examId);
				listOfAlltest = testDaoImpl.viewAllTest(secId);
				request.setAttribute("examOfTest", examDaoImpl.viewExam(secId));
			}

			request.setAttribute("listOfAlltest", listOfAlltest);

			request.getRequestDispatcher("viewAllTest.jsp").forward(request, response);

		}
		
		else if (opeartion.equalsIgnoreCase("viewUpcomingTest")) {

			List<Test> listOfAlltest = testDaoImpl.viewAllUpcomingTest();
			request.setAttribute("listOfAlltest", listOfAlltest);

			request.getRequestDispatcher("viewUpcomingTest.jsp").forward(request, response);

		}
		
		else if (opeartion.equalsIgnoreCase("seachTestPapers")) {

			String categoryId = request.getParameter("categoryId");
			String type = request.getParameter("type");

			List<Test> listOfAlltest = new ArrayList<>();
			if (categoryId == null) {

				listOfAlltest.addAll(testDaoImpl.viewAllTest(type));
			} else {
				for (Exam ex : examDaoImpl.viewAllExam(Integer.parseInt(categoryId))) {
					listOfAlltest.addAll(testDaoImpl.viewAllTest(type, ex.getExamId()));
				}
			}
			
			
			request.setAttribute("listOfAlltest", listOfAlltest);
			System.out.println(" S RRRRRRRRR " + listOfAlltest);
			request.getRequestDispatcher("searchTest.jsp").forward(request, response);

		}

		else if (opeartion.equalsIgnoreCase("edit")) {

			int testId = Integer.parseInt(request.getParameter("testId"));
			Test testToEdit = testDaoImpl.viewTest(testId);
			request.setAttribute("testToEdit", testToEdit);

			request.getRequestDispatcher("editTest.jsp").forward(request, response);
		} else if (opeartion.equalsIgnoreCase("delete")) {

			int testId = Integer.parseInt(request.getParameter("testId"));

			if (testDaoImpl.daleteTest(testId)) {
				request.setAttribute("testDeleteSucessMessage", "Test Deleted Successfully.");
			} else {
				request.setAttribute("testDeleteFailedMessage", "Failed! Try Again !!!");
			}

			request.getRequestDispatcher("testServlet?operation=view").forward(request, response);

		} else if (opeartion.equalsIgnoreCase("deleteByExam")) {

			String examId = request.getParameter("examId");

			if (testDaoImpl.deleteTestByExam(Integer.parseInt(examId))) {
				request.setAttribute("testDeleteSucessMessage", "All Test of selected cated Deleted Successfully.");
			} else {
				request.setAttribute("testDeleteFailedMessage", "Failed! Try Again !!!");
			}

			request.getRequestDispatcher("testServlet?operation=view").forward(request, response);

		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@SuppressWarnings("deprecation")
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String opeartion = request.getParameter("operation");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		if (opeartion.equalsIgnoreCase("add")) {

			try {
				Test test = new Test();
				test.setTestName(request.getParameter("testName"));

				test.setTestType(request.getParameter("testType"));
				test.setMaxMarks(Integer.parseInt(request.getParameter("maxmarks")));
				test.setMaxQuestion(Integer.parseInt(request.getParameter("maxQuestion")));
				test.setDuration(Integer.parseInt(request.getParameter("testDuration")));

				Date openDate;

				openDate = dateFormat.parse(request.getParameter("openDate"));
				test.setOpen(openDate);
				Date closeDate = dateFormat.parse(request.getParameter("closeDate"));

				test.setclose(closeDate);
				test.setTestFee(Integer.parseInt(request.getParameter("testFee")));
				test.setExamId(Integer.parseInt(request.getParameter("examId")));

				if (testDaoImpl.createTest(test)) {
					request.setAttribute("testAddSucessMessage", "New test Added Successfully. <br> Add More .");
				} else {
					request.setAttribute("testAddFailedMessage", "Failed! Try Again !!!");
				}

				request.getRequestDispatcher("addTest.jsp").forward(request, response);

			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		} else if (opeartion.equalsIgnoreCase("edit")) {

			try {
			Test test = new Test();
			test.setTestId(Integer.parseInt(request.getParameter("testId")));
			// testName
			test.setTestName(request.getParameter("testName"));

			test.setTestType(request.getParameter("testType"));
			test.setMaxMarks(Integer.parseInt(request.getParameter("maxmarks")));
			test.setMaxQuestion(Integer.parseInt(request.getParameter("maxQuestion")));
			test.setDuration(Integer.parseInt(request.getParameter("testDuration")));
			Date openDate;

			openDate = dateFormat.parse(request.getParameter("openDate"));
			test.setOpen(openDate);
			Date closeDate = dateFormat.parse(request.getParameter("closeDate"));

			test.setclose(closeDate);

			test.setTestFee(Integer.parseInt(request.getParameter("testFee")));
			test.setExamId(Integer.parseInt(request.getParameter("examId")));

			if (testDaoImpl.updateTest(test)) {
				request.setAttribute("testEditSucessMessage", "test Updated Successfully.");
			} else {
				request.setAttribute("testEditFailedMessage", "Failed! Try Again !!!");
			}

			request.getRequestDispatcher("testServlet?operation=view").forward(request, response);
			}catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		} else if (opeartion.equalsIgnoreCase("view")) {

			doGet(request, response);

		}

	}

}

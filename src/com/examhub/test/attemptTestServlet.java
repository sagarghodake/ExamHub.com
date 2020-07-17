package com.examhub.test;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.examhub.impl.*;
import com.examhub.pojo.*;

/**
 * Servlet implementation class attemptTestServlet
 */
@WebServlet("/attemptTestServlet")
public class attemptTestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	TestDaoImpl testDaoImpl = new TestDaoImpl();
	ExamDaoImpl exDaoImpl = new ExamDaoImpl();
	SectionDaoImpl sectionDaoImpl = new SectionDaoImpl();
	QuestionDaoImpl questionDaoImpl = new QuestionDaoImpl();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public attemptTestServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String operation = request.getParameter("operation");
		String studentUsername = (String) request.getSession().getAttribute("studentLogin");

		if (operation.equalsIgnoreCase("attemptTest")) {
			int testId = Integer.parseInt(request.getParameter("testId"));
			Test testDetails = testDaoImpl.viewTest(testId);


			OnlineTest onlineTestObject = new OnlineTest();
			onlineTestObject.setStudentUsername(studentUsername);
			onlineTestObject.setTestId(testId);
			onlineTestObject.setExamId(testDetails.getExamId());
			onlineTestObject.setDuration(testDetails.getDuration());
			onlineTestObject.setMaxQuestion(testDetails.getMaxQuestion());
			onlineTestObject.setMaxMarks(testDetails.getMaxMarks());
			onlineTestObject.setType(testDetails.getTestType());
			onlineTestObject.setTestName(testDetails.getTestName());

			List<Section> listOfsections = sectionDaoImpl.viewAllSection(testDetails.getExamId());

			List<Question> listOfAllQuestions = new ArrayList<>();

			for (Section sec : listOfsections) {

				listOfAllQuestions.addAll(questionDaoImpl.viewAllQuestion(sec.getExamId(), sec.getSectionId()));
			}
			Collections.shuffle(listOfAllQuestions);

			for (int i = 0; i < testDetails.getMaxQuestion(); i++) {
				System.out.println(listOfAllQuestions.get(i).getQuestionId());
				onlineTestObject.getQuestionSet().add(listOfAllQuestions.get(i));
			}

			request.setAttribute("onlineTestObject", onlineTestObject);
			request.getRequestDispatcher("onlineTest.jsp").forward(request, response);
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */

	ResultDaoImpl impl = new ResultDaoImpl();

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String operation = request.getParameter("operation");

		HttpSession session = request.getSession();
		String studentLogin = (String) session.getAttribute("studentLogin");

		if (operation.equalsIgnoreCase("submitTest")) {

			int testId=Integer.parseInt(request.getParameter("testId"));
			int testMaxQuestions = Integer.parseInt(request.getParameter("testMaxQuestions"));
			int testMaxMarks = Integer.parseInt(request.getParameter("testMaxMarks"));
			int marksObtained = 0;
			int rA = 0;
			int attempted = 0;

			for (int i = 0; i < testMaxQuestions; i++) {
				int questionId = Integer.parseInt(request.getParameter("question" + i));
				System.out.println(questionId + " " + "question" + i);
				QuestionDaoImpl impl = new QuestionDaoImpl();
				Question q = impl.viewQuestion(questionId);

				String answer = request.getParameter("option" + i);

				if (answer != null) {
					attempted++;
					if (answer.trim().equalsIgnoreCase(q.getAnswer().trim())) {
						rA++;

					}

				}

			}

			marksObtained = ((rA * testMaxMarks) / testMaxQuestions);

			Result res = new Result();
			res.setView(-1);
			res.setTestId(testId);
			res.setAttempted(attempted);
			res.setCorrect(rA);
			res.setStudUsername(studentLogin);
			res.setMaxQuestions(testMaxQuestions);
			res.setMaxMarks(testMaxMarks);
			res.setObtained(marksObtained);

			if (impl.addResult(res)) {

				int percentageObtained=((marksObtained*100)/testMaxMarks);
				String result=studentLogin+" "+(percentageObtained>=60?" Passed the ":"Failed the ")+testDaoImpl.viewTest(testId).getTestName()+" Test."
						+ "<br> Result Analysis will be available soon by Admin.";
				System.out.println(" RESULT ADDED ");
				request.setAttribute("result",result);
				request.getRequestDispatcher("studentHome.jsp").forward(request, response);
			
				
			} else {
				request.setAttribute("result","problem Submitted test to Server ! Try Again !");
				request.getRequestDispatcher("studentHome.jsp").forward(request, response);
			
			}
		}
	}

}

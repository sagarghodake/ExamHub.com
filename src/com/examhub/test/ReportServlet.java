package com.examhub.test;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import com.examhub.dao.CategoryDao;
import com.examhub.dao.ExamDao;
import com.examhub.dao.QuestionDao;
import com.examhub.dao.ResultDao;
import com.examhub.dao.SectionDao;
import com.examhub.dao.StudentDao;
import com.examhub.dao.TestDao;
import com.examhub.impl.CategoryDaoImpl;
import com.examhub.impl.ExamDaoImpl;
import com.examhub.impl.QuestionDaoImpl;
import com.examhub.impl.ResultDaoImpl;
import com.examhub.impl.SectionDaoImpl;
import com.examhub.impl.StudentDaoImpl;
import com.examhub.impl.TestDaoImpl;
import com.examhub.pojo.Category;
import com.examhub.pojo.Exam;
import com.examhub.pojo.Question;
import com.examhub.pojo.Result;
import com.examhub.pojo.Section;
import com.examhub.pojo.Student;
import com.examhub.pojo.Test;

/**
 * Servlet implementation class ReportServlet
 */
@WebServlet("/reportServlet")
public class ReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	CategoryDao categoryDao = new CategoryDaoImpl();
	SectionDao sectionDao = new SectionDaoImpl();
	ExamDao examDao = new ExamDaoImpl();
	TestDao testDao = new TestDaoImpl();
	QuestionDao questionDao = new QuestionDaoImpl();
	ResultDao resultDao = new ResultDaoImpl();
	StudentDao studentDao = new StudentDaoImpl();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ReportServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		String operation = request.getParameter("reportName");

		if (operation.equalsIgnoreCase("Category")) {

			List<Category> listOfCategory = categoryDao.viewAllCategories();
			request.setAttribute("listOfCategory", listOfCategory);

			request.getRequestDispatcher("categoryReport.jsp").forward(request, response);

		} else if (operation.equalsIgnoreCase("Section")) {

			String examId = request.getParameter("examId");

			List<Section> listOfSection = null;
			if (examId == null)
				listOfSection = sectionDao.viewAllSection();
			else
				listOfSection = sectionDao.viewAllSection(Integer.parseInt(examId));

			request.setAttribute("listOfSection", listOfSection);

			request.getRequestDispatcher("sectionReport.jsp").forward(request, response);

		} else if (operation.equalsIgnoreCase("question")) {
			String examId = request.getParameter("examId");

			List<Question> listOfquestion = null;
			if (examId == null)
				listOfquestion = questionDao.viewAllQuestion();
			else
				listOfquestion = questionDao.viewAllQuestion(Integer.parseInt(examId));

			request.setAttribute("listOfQuestion", listOfquestion);

			request.getRequestDispatcher("questionReport.jsp").forward(request, response);

		} else if (operation.equalsIgnoreCase("test")) {
			String examId = request.getParameter("examId");
			String type = request.getParameter("type");

			List<Test> listOftest = null;
			if (examId.equalsIgnoreCase("aLL")) {
				if (type.equalsIgnoreCase("all"))
					listOftest = testDao.viewAllTest();
				else if (type.equalsIgnoreCase("mock") || type.equalsIgnoreCase("practice"))
					listOftest = testDao.viewAllTest(type);
			} else {
				if (type.equalsIgnoreCase("all"))
					listOftest = testDao.viewAllTest(Integer.parseInt(examId));
				else if (type.equalsIgnoreCase("mock") || type.equalsIgnoreCase("practice"))
					listOftest = testDao.viewAllTest(type, Integer.parseInt(examId));

			}

			request.setAttribute("listOftest", listOftest);

			request.getRequestDispatcher("testReport.jsp").forward(request, response);

		} else if (operation.equalsIgnoreCase("upcomingTest")) {
			List<Test> listOftest = testDao.viewAllUpcomingTest();
			request.setAttribute("listOftest", listOftest);

			request.getRequestDispatcher("testReport.jsp").forward(request, response);

		} else if (operation.equalsIgnoreCase("exam")) {
			List<Exam> listOfexam = examDao.viewAllExam();
			request.setAttribute("listOfexam", listOfexam);

			request.getRequestDispatcher("examReport.jsp").forward(request, response);

		} else if (operation.equalsIgnoreCase("student")) {
			List<Student> listOfstudent = studentDao.viewAllStudent();
			request.setAttribute("listOfstudent", listOfstudent);

			request.getRequestDispatcher("studentReport.jsp").forward(request, response);

		} 		
		else if (operation.equalsIgnoreCase("result")) {

			List<List> resultReportList = new ArrayList<List>();

			List<Test> listOfTest = testDao.viewAllTest();

			for (Test test : listOfTest) {

				Integer testId = test.getTestId();

				List<Result> listOResults = resultDao.viewAllResults(testId);

				double totalStudentAppearTest = listOResults.size();
				int classD = 0, classC = 0, classB = 0, classA = 0;

				for (Result result : listOResults) {
					char grade = ResultServlet.checkGrade(result.getObtained(), result.getMaxMarks());

					if (grade == 'A')
						classA++;
					else if (grade == 'B')
						classB++;
					else if (grade == 'C')
						classC++;
					else
						classD++;

				}

				List resultReportRecord = new ArrayList<>();
				resultReportRecord.add(testId);
				resultReportRecord.add(test.getTestName() + " " + examDao.viewExam(test.getExamId()).getExamName());
				resultReportRecord.add(test.getTestType());
				resultReportRecord.add(test.getOpen());
				resultReportRecord.add(test.getclose());
				resultReportRecord.add(test.getMaxMarks());
				resultReportRecord.add(totalStudentAppearTest);
				resultReportRecord.add(classA + classB);
				resultReportRecord.add(classC + classD);
				resultReportRecord.add(classD);

				resultReportList.add(resultReportRecord);

			}
			
			request.setAttribute("resultReportList", resultReportList);

			request.getRequestDispatcher("resultReport.jsp").forward(request, response);

		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

package com.examhub.test;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.examhub.dao.*;
import com.examhub.impl.*;
import com.examhub.pojo.*;

/**
 * Servlet implementation class QuestionServlet
 */
@WebServlet("/questionServlet")
public class QuestionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	QuestionDao questionDaoImpl = new QuestionDaoImpl();
	ExamDao examDaoImpl = new ExamDaoImpl();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public QuestionServlet() {
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

		if (opeartion.equalsIgnoreCase("viewByExam")) {

			String data[] = request.getParameter("examId").split("#");

			int examId = Integer.parseInt(data[0]);
			
			List<Question> listOfAllquestion = questionDaoImpl.viewAllQuestion(examId);
			
			request.setAttribute("examIdSelected", examDaoImpl.viewExam(examId));
			request.setAttribute("listOfAllquestion", listOfAllquestion);
			System.out.println("viewByExam   "+listOfAllquestion);
			request.getRequestDispatcher("viewAllQuestion.jsp").forward(request, response);

		} else if (opeartion.equalsIgnoreCase("viewBySection")) {

			String data[] = request.getParameter("examId").split("#");

			int examId = Integer.parseInt(data[0]);

			int sectionId = Integer.parseInt(data[1]);
			List<Question> listOfAllquestion = questionDaoImpl.viewAllQuestion(examId,sectionId);

			request.setAttribute("examIdSelected", examDaoImpl.viewExam(Integer.parseInt(data[0])));

			request.setAttribute("sectionIdSelected", examDaoImpl.viewExam(sectionId));

			request.setAttribute("listOfAllquestion", listOfAllquestion);
			System.out.println("viewBySection   "+listOfAllquestion);

			request.getRequestDispatcher("viewAllQuestion.jsp").forward(request, response);

		} else if (opeartion.equalsIgnoreCase("view")) {
			List<Question> listOfAllquestion = questionDaoImpl.viewAllQuestion();

			request.setAttribute("listOfAllquestion", listOfAllquestion);

			request.getRequestDispatcher("viewAllQuestion.jsp").forward(request, response);

		} else if (opeartion.equalsIgnoreCase("edit")) {

			int questionId = Integer.parseInt(request.getParameter("questionId"));
			System.out.println(" in servlet   "+questionId);
			Question questionToEdit = questionDaoImpl.viewQuestion(questionId);
			request.setAttribute("questionToEdit", questionToEdit);

			request.getRequestDispatcher("editQuestion.jsp").forward(request, response);
		} else if (opeartion.equalsIgnoreCase("delete")) {

			int questionId = Integer.parseInt(request.getParameter("questionId"));

			if (questionDaoImpl.deleteQuestion(questionId)) {
				request.setAttribute("questionDeleteSucessMessage", "Question Deleted Successfully.");
			} else {
				request.setAttribute("questionDeleteFailedMessage", "Failed! Try Again !!!");
			}

			request.getRequestDispatcher("questionServlet?operation=view").forward(request, response);

		} else if (opeartion.equalsIgnoreCase("deleteByExam")) {

			String data[] = request.getParameter("examId").split("#");

			int examId = Integer.parseInt(data[0]);

			if (questionDaoImpl.deleteQuestionByExam(examId)) {
				request.setAttribute("questionDeleteSucessMessage",
						"All Question of selected cated Deleted Successfully.");
			} else {
				request.setAttribute("questionDeleteFailedMessage", "Failed! Try Again !!!");
			}

			request.getRequestDispatcher("questionServlet?operation=view").forward(request, response);

		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String opeartion = request.getParameter("operation");

		if (opeartion.equalsIgnoreCase("add")) {

			Question question = new Question();
			question.setQuestion(request.getParameter("question"));
			question.setOption1(request.getParameter("option1"));
			question.setOption2(request.getParameter("option2"));
			question.setOption3(request.getParameter("option3"));
			question.setOption4(request.getParameter("option4"));

			question.setAnswer(request.getParameter("answer"));
			
			String data[] = request.getParameter("examId").split("#");

			int sectionId = Integer.parseInt(data[1]);


			question.setSectionId(sectionId);
			if (questionDaoImpl.addQuestion(question)) {
				request.setAttribute("questionAddSucessMessage", "New question Added Successfully. <br> Add More .");
			} else {
				request.setAttribute("questionAddFailedMessage", "Failed! Try Again !!!");
			}

			request.getRequestDispatcher("addQuestion.jsp").forward(request, response);

		} else if (opeartion.equalsIgnoreCase("edit")) {

			Question question = new Question();
			question.setQuestionId(Integer.parseInt(request.getParameter("questionId")));
			question.setQuestion(request.getParameter("question"));
			question.setOption1(request.getParameter("option1"));
			question.setOption2(request.getParameter("option2"));
			question.setOption3(request.getParameter("option3"));
			question.setOption4(request.getParameter("option4"));

			question.setAnswer(request.getParameter("answer"));

			String data[] = request.getParameter("examId").split("#");

			int sectionId = Integer.parseInt(data[1]);


			question.setSectionId(sectionId);

			if (questionDaoImpl.updateQuestion(question)) {
				request.setAttribute("questionEditSucessMessage", "question Updated Successfully.");
			} else {
				request.setAttribute("questionEditFailedMessage", "Failed! Try Again !!!");
			}

			request.getRequestDispatcher("questionServlet?operation=view").forward(request, response);

		} else if (opeartion.equalsIgnoreCase("view")) {

			doGet(request, response);

		}

	}

}

package com.examhub.test;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.examhub.dao.CategoryDao;
import com.examhub.dao.ExamDao;
import com.examhub.impl.CategoryDaoImpl;
import com.examhub.impl.ExamDaoImpl;
import com.examhub.pojo.Exam;

/**
 * Servlet implementation class ExamServlet
 */
@WebServlet("/examServlet")
public class ExamServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	ExamDao examDaoImpl=new ExamDaoImpl();
	CategoryDao categoryDaoImpl = new CategoryDaoImpl();

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ExamServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String opeartion = request.getParameter("operation");

		if (opeartion.equalsIgnoreCase("view")) {

			String categoryId=request.getParameter("categoryId");
			List<Exam> listOfAllexam =null;
			if(categoryId==null) {
					listOfAllexam = examDaoImpl.viewAllExam();
			}
			else
			{
				int catId=Integer.parseInt(categoryId);
				listOfAllexam=examDaoImpl.viewAllExam(catId);
				request.setAttribute("categoryOfExam", categoryDaoImpl.viewCategory(catId));
			}

			request.setAttribute("listOfAllexam", listOfAllexam);

			request.getRequestDispatcher("viewAllExam.jsp").forward(request, response);
			
			
		} else if (opeartion.equalsIgnoreCase("edit")) {

			int examId = Integer.parseInt(request.getParameter("examId"));
			Exam examToEdit = examDaoImpl.viewExam(examId);
			request.setAttribute("examToEdit", examToEdit);

			request.getRequestDispatcher("editExam.jsp").forward(request, response);
		} else if (opeartion.equalsIgnoreCase("delete")) {

			int examId = Integer.parseInt(request.getParameter("examId"));

			if (examDaoImpl.deleteExam(examId)) {
				request.setAttribute("examDeleteSucessMessage", "Exam Deleted Successfully.");
			} else {
				request.setAttribute("examDeleteFailedMessage", "Failed! Try Again !!!");
			}

			request.getRequestDispatcher("examServlet?operation=view").forward(request, response);

		}
		else if (opeartion.equalsIgnoreCase("deleteByCategory")) {

			String categoryId=request.getParameter("categoryId");

			if (examDaoImpl.deleteExamByCategory(Integer.parseInt(categoryId))) {
				request.setAttribute("examDeleteSucessMessage", "All Exam of selected cated Deleted Successfully.");
			} else {
				request.setAttribute("examDeleteFailedMessage", "Failed! Try Again !!!");
			}

			request.getRequestDispatcher("examServlet?operation=view").forward(request, response);

		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String opeartion = request.getParameter("operation");

		if (opeartion.equalsIgnoreCase("add")) {

			Exam exam = new Exam();
			exam.setExamName(request.getParameter("examName"));
			exam.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
			if (examDaoImpl.addExam(exam)) {
				request.setAttribute("examAddSucessMessage", "New exam Added Successfully. <br> Add More .");
			} else {
				request.setAttribute("examAddFailedMessage", "Failed! Try Again !!!");
			}

			request.getRequestDispatcher("addExam.jsp").forward(request, response);

		} else if (opeartion.equalsIgnoreCase("edit")) {

			Exam exam = new Exam();
			exam.setExamId(Integer.parseInt(request.getParameter("examId")));
			exam.setExamName(request.getParameter("examName"));
			exam.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));

			if (examDaoImpl.updateExam(exam)) {
				request.setAttribute("examEditSucessMessage", "exam Updated Successfully.");
			} else {
				request.setAttribute("examEditFailedMessage", "Failed! Try Again !!!");
			}

			request.getRequestDispatcher("examServlet?operation=view").forward(request, response);

		} else if (opeartion.equalsIgnoreCase("view")) {

			doGet(request, response);

		}
		
	}

}

package com.examhub.test;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.examhub.dao.AssignmentDao;
import com.examhub.impl.AssignmentDaoImpl;
import com.examhub.pojo.Assignment;

/**
 * Servlet implementation class ManageExamAssignment
 */
@WebServlet("/assignmentServlet")
public class AssignmentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	AssignmentDao assignmentDaoImpl = new AssignmentDaoImpl();

	public AssignmentServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String opeartion = request.getParameter("operation");

		if (opeartion.equalsIgnoreCase("viewAllAssignment")) {

			List<Assignment> listOfAllAssignment = assignmentDaoImpl.viewAllAssignment();

			request.setAttribute("listOfAllAssignment", listOfAllAssignment);

			request.getRequestDispatcher("viewAllAssignment.jsp").forward(request, response);
		} else if (opeartion.equalsIgnoreCase("edit")) {

			int assignmentId = Integer.parseInt(request.getParameter("assignmentId"));
			Assignment assignmentToEdit = assignmentDaoImpl.viewAssignment(assignmentId);
			request.setAttribute("assignmentToEdit", assignmentToEdit);

			request.getRequestDispatcher("editAssignment.jsp").forward(request, response);
		} else if (opeartion.equalsIgnoreCase("delete")) {

			int assignmentId = Integer.parseInt(request.getParameter("assignmentId"));

			if (assignmentDaoImpl.deleteAssignment(assignmentId)) {
				request.setAttribute("assignmentDeleteSucessMessage", "Assignment Deleted Successfully.");
			} else {
				request.setAttribute("assignmentDeleteFailedMessage", "Failed! Try Again !!!");
			}

			request.getRequestDispatcher("assignmentServlet?operation=viewAllAssignment").forward(request, response);

		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String opeartion = request.getParameter("operation");

		if (opeartion.equalsIgnoreCase("add")) {

			Assignment blg = new Assignment();
			blg.setAssignmentData(request.getParameter("assignmentData"));
			blg.setSubjectName(request.getParameter("subjectName"));
		
			if (assignmentDaoImpl.addAssignment(blg)) {
				request.setAttribute("assignmentAddSucessMessage", "New Assignment Added Successfully. <br> Add More .");
			} else {
				request.setAttribute("assignmentAddFailedMessage", "Failed! Try Again !!!");
			}

			request.getRequestDispatcher("addAssignment.jsp").forward(request, response);

		} else if (opeartion.equalsIgnoreCase("edit")) {

			Assignment blg = new Assignment();
			blg.setAssignementId(Integer.parseInt(request.getParameter("assignmentId")));
			blg.setAssignmentData(request.getParameter("assignmentData"));
			blg.setSubjectName(request.getParameter("subjectName"));
			
			if (assignmentDaoImpl.editAssignment(blg)) {
				request.setAttribute("assignmentEditSucessMessage", "Assignment Updated Successfully.");
			} else {
				request.setAttribute("assignmentEditFailedMessage", "Failed! Try Again !!!");
			}

			request.getRequestDispatcher("assignmentServlet?operation=viewAllAssignment").forward(request, response);

		} else if (opeartion.equalsIgnoreCase("viewAllAssignment")) {

			doGet(request, response);

		}

	}

}

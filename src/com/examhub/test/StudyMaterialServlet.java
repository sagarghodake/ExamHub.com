package com.examhub.test;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.examhub.impl.StudyMaterialDaoImpl;
import com.examhub.pojo.StudyMaterial;

/**
 * Servlet implementation class ManageExamStudyMaterial
 */
@WebServlet("/studyMaterialServlet")
public class StudyMaterialServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	StudyMaterialDaoImpl studyMaterialDaoImpl = new StudyMaterialDaoImpl();

	public StudyMaterialServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String opeartion = request.getParameter("operation");

		if (opeartion.equalsIgnoreCase("viewAllStudyMaterial")) {

			List<StudyMaterial> listOfAllStudyMaterial = studyMaterialDaoImpl.viewAllStudyMaterial();

			request.setAttribute("listOfAllStudyMaterial", listOfAllStudyMaterial);

			request.getRequestDispatcher("viewAllStudyMaterial.jsp").forward(request, response);
		} else if (opeartion.equalsIgnoreCase("edit")) {

			int studyMaterialId = Integer.parseInt(request.getParameter("studyMaterialId"));
			StudyMaterial studyMaterialToEdit = studyMaterialDaoImpl.viewStudyMaterial(studyMaterialId);
			request.setAttribute("studyMaterialToEdit", studyMaterialToEdit);

			request.getRequestDispatcher("editStudyMaterial.jsp").forward(request, response);
		} else if (opeartion.equalsIgnoreCase("delete")) {

			int studyMaterialId = Integer.parseInt(request.getParameter("studyMaterialId"));

			if (studyMaterialDaoImpl.deleteStudyMaterial(studyMaterialId)) {
				request.setAttribute("studyMaterialDeleteSucessMessage", "StudyMaterial Deleted Successfully.");
			} else {
				request.setAttribute("studyMaterialDeleteFailedMessage", "Failed! Try Again !!!");
			}

			request.getRequestDispatcher("studyMaterialServlet?operation=viewAllStudyMaterial").forward(request, response);

		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String opeartion = request.getParameter("operation");

		if (opeartion.equalsIgnoreCase("add")) {

			StudyMaterial sm = new StudyMaterial();
			
			sm.setDocumentType(request.getParameter("documentType"));
			sm.setSubjectName(request.getParameter("subjectName"));
			
			if (studyMaterialDaoImpl.addStudyMaterial(sm)) {
				request.setAttribute("studyMaterialAddSucessMessage", "New StudyMaterial Added Successfully. <br> Add More .");
			} else {
				request.setAttribute("studyMaterialAddFailedMessage", "Failed! Try Again !!!");
			}

			request.getRequestDispatcher("addStudyMaterial.jsp").forward(request, response);

		} else if (opeartion.equalsIgnoreCase("edit")) {

			StudyMaterial sm = new StudyMaterial();
			sm.setDocumentType(request.getParameter("documentType"));
			sm.setSubjectName(request.getParameter("subjectName"));
			
			if (studyMaterialDaoImpl.editStudyMaterial(sm)) {
				request.setAttribute("studyMaterialEditSucessMessage", "StudyMaterial Updated Successfully.");
			} else {
				request.setAttribute("studyMaterialEditFailedMessage", "Failed! Try Again !!!");
			}

			request.getRequestDispatcher("studyMaterialServlet?operation=viewAllStudyMaterial").forward(request, response);

		} else if (opeartion.equalsIgnoreCase("viewAllStudyMaterial")) {

			doGet(request, response);

		}

	}

}

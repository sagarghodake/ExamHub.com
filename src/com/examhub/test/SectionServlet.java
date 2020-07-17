package com.examhub.test;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.examhub.dao.ExamDao;
import com.examhub.dao.SectionDao;
import com.examhub.impl.ExamDaoImpl;
import com.examhub.impl.SectionDaoImpl;
import com.examhub.pojo.Section;

/**
 * Servlet implementation class SectionServlet
 */
@WebServlet("/sectionServlet")
public class SectionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	SectionDao sectionDaoImpl=new SectionDaoImpl();
	ExamDao examDaoImpl = new ExamDaoImpl();

    /**
     * @see HttpServlet#HttpServlet()
     */
    public SectionServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String opeartion = request.getParameter("operation");

		if (opeartion.equalsIgnoreCase("view")) {

			String examId=request.getParameter("examId");
			List<Section> listOfAllsection =null;
			if(examId==null) {
					listOfAllsection = sectionDaoImpl.viewAllSection();
			}
			else
			{
				int secId=Integer.parseInt(examId);
				listOfAllsection=sectionDaoImpl.viewAllSection(secId);
				request.setAttribute("examOfSection", examDaoImpl.viewExam(secId));
			}

			request.setAttribute("listOfAllsection", listOfAllsection);

			request.getRequestDispatcher("viewAllSection.jsp").forward(request, response);
			
			
		} else if (opeartion.equalsIgnoreCase("edit")) {

			int sectionId = Integer.parseInt(request.getParameter("sectionId"));
			Section sectionToEdit = sectionDaoImpl.viewSection(sectionId);
			request.setAttribute("sectionToEdit", sectionToEdit);

			request.getRequestDispatcher("editSection.jsp").forward(request, response);
		} else if (opeartion.equalsIgnoreCase("delete")) {

			int sectionId = Integer.parseInt(request.getParameter("sectionId"));

			if (sectionDaoImpl.deleteSection(sectionId)) {
				request.setAttribute("sectionDeleteSucessMessage", "Section Deleted Successfully.");
			} else {
				request.setAttribute("sectionDeleteFailedMessage", "Failed! Try Again !!!");
			}

			request.getRequestDispatcher("sectionServlet?operation=view").forward(request, response);

		}
		else if (opeartion.equalsIgnoreCase("deleteByExam")) {

			String examId=request.getParameter("examId");

			if (sectionDaoImpl.deleteSectionByExam(Integer.parseInt(examId))) {
				request.setAttribute("sectionDeleteSucessMessage", "All Section of selected cated Deleted Successfully.");
			} else {
				request.setAttribute("sectionDeleteFailedMessage", "Failed! Try Again !!!");
			}

			request.getRequestDispatcher("sectionServlet?operation=view").forward(request, response);

		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String opeartion = request.getParameter("operation");

		if (opeartion.equalsIgnoreCase("add")) {

			Section section = new Section();
			section.setSectionName(request.getParameter("sectionName"));
			section.setExamId(Integer.parseInt(request.getParameter("examId")));
			if (sectionDaoImpl.addSection(section)) {
				request.setAttribute("sectionAddSucessMessage", "New section Added Successfully. <br> Add More .");
			} else {
				request.setAttribute("sectionAddFailedMessage", "Failed! Try Again !!!");
			}

			request.getRequestDispatcher("addSection.jsp").forward(request, response);

		} else if (opeartion.equalsIgnoreCase("edit")) {

			Section section = new Section();
			section.setSectionId(Integer.parseInt(request.getParameter("sectionId")));
			section.setSectionName(request.getParameter("sectionName"));
			section.setExamId(Integer.parseInt(request.getParameter("examId")));

			if (sectionDaoImpl.updateSection(section)) {
				request.setAttribute("sectionEditSucessMessage", "section Updated Successfully.");
			} else {
				request.setAttribute("sectionEditFailedMessage", "Failed! Try Again !!!");
			}

			request.getRequestDispatcher("sectionServlet?operation=view").forward(request, response);

		} else if (opeartion.equalsIgnoreCase("view")) {

			doGet(request, response);

		}
		
	}

}

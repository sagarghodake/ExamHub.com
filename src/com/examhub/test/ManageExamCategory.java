package com.examhub.test;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.examhub.dao.CategoryDao;
import com.examhub.impl.CategoryDaoImpl;
import com.examhub.pojo.Category;

/**
 * Servlet implementation class ManageExamCategory
 */
@WebServlet("/categoryServlet")
public class ManageExamCategory extends HttpServlet {
	private static final long serialVersionUID = 1L;

	CategoryDao categoryDaoImpl = new CategoryDaoImpl();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ManageExamCategory() {
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

		String opeartion = request.getParameter("operation");

		if (opeartion.equalsIgnoreCase("viewAllCategories")) {

			List<Category> listOfAllCategory = categoryDaoImpl.viewAllCategories();

			request.setAttribute("listOfAllCategory", listOfAllCategory);

			request.getRequestDispatcher("viewAllCategories.jsp").forward(request, response);
		} else if (opeartion.equalsIgnoreCase("edit")) {

			int categoryId = Integer.parseInt(request.getParameter("categoryId"));
			Category categoryToEdit = categoryDaoImpl.viewCategory(categoryId);
			request.setAttribute("categoryToEdit", categoryToEdit);

			request.getRequestDispatcher("editCategory.jsp").forward(request, response);
		} else if (opeartion.equalsIgnoreCase("delete")) {

			int categoryId = Integer.parseInt(request.getParameter("categoryId"));

			if (categoryDaoImpl.deleteCatetegory(categoryId)) {
				request.setAttribute("categoryDeleteSucessMessage", "Category Deleted Successfully.");
			} else {
				request.setAttribute("categoryDeleteFailedMessage", "Failed! Try Again !!!");
			}

			request.getRequestDispatcher("categoryServlet?operation=viewAllCategories").forward(request, response);

		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		String opeartion = request.getParameter("operation");

		if (opeartion.equalsIgnoreCase("add")) {

			Category category = new Category();
			category.setCategoryName(request.getParameter("categoryName"));

			if (categoryDaoImpl.addCategory(category)) {
				request.setAttribute("categoryAddSucessMessage", "New Category Added Successfully. <br> Add More .");
			} else {
				request.setAttribute("categoryAddFailedMessage", "Failed! Try Again !!!");
			}

			request.getRequestDispatcher("addCategory.jsp").forward(request, response);

		} else if (opeartion.equalsIgnoreCase("edit")) {

			Category category = new Category();
			category.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
			category.setCategoryName(request.getParameter("categoryName"));

			if (categoryDaoImpl.updateCategory(category)) {
				request.setAttribute("categoryEditSucessMessage", "Category Updated Successfully.");
			} else {
				request.setAttribute("categoryEditFailedMessage", "Failed! Try Again !!!");
			}

			request.getRequestDispatcher("categoryServlet?operation=viewAllCategories").forward(request, response);

		} else if (opeartion.equalsIgnoreCase("viewAllCategories")) {

			doGet(request, response);

		}

	}

}

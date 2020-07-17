package com.examhub.test;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.examhub.dao.BlogDao;
import com.examhub.impl.BlogDaoImpl;
import com.examhub.pojo.Blog;

/**
 * Servlet implementation class ManageExamBlog
 */
@WebServlet("/blogServlet")
public class BlogServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	BlogDao blogDaoImpl = new BlogDaoImpl();

	public BlogServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String opeartion = request.getParameter("operation");

		if (opeartion.equalsIgnoreCase("viewAllBlog")) {

			List<Blog> listOfAllBlog = blogDaoImpl.viewAllBlog();

			request.setAttribute("listOfAllBlog", listOfAllBlog);

			String type=request.getParameter("type");
			if(type!=null) {
				request.getRequestDispatcher("blog.jsp").forward(request, response);
			}
			else {
				request.getRequestDispatcher("viewAllBlogs.jsp").forward(request, response);
			}
		} else if (opeartion.equalsIgnoreCase("edit")) {

			int blogId = Integer.parseInt(request.getParameter("blogId"));
			Blog blogToEdit = blogDaoImpl.viewBlog(blogId);
			request.setAttribute("blogToEdit", blogToEdit);

			request.getRequestDispatcher("editBlog.jsp").forward(request, response);
		}
		else if (opeartion.equalsIgnoreCase("viewBlog")) {

			int blogId = Integer.parseInt(request.getParameter("blogId"));
			Blog blogToView = blogDaoImpl.viewBlog(blogId);
			request.setAttribute("blogToView", blogToView);

			request.getRequestDispatcher("viewBlog.jsp").forward(request, response);
		}
		else if (opeartion.equalsIgnoreCase("delete")) {

			int blogId = Integer.parseInt(request.getParameter("blogId"));

			if (blogDaoImpl.deleteBlog(blogId)) {
				request.setAttribute("blogDeleteSucessMessage", "Blog Deleted Successfully.");
			} else {
				request.setAttribute("blogDeleteFailedMessage", "Failed! Try Again !!!");
			}

			request.getRequestDispatcher("blogServlet?operation=viewAllBlog").forward(request, response);

		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String opeartion = request.getParameter("operation");

		if (opeartion.equalsIgnoreCase("add")) {

			Blog blg = new Blog();
			blg.setBlogTitle(request.getParameter("blogTitle"));
			blg.setBlogData(request.getParameter("blogData"));
			blg.setLinkRelated(request.getParameter("links"));
			blg.setLastEdited(new Date().toString());
		
			if (blogDaoImpl.addBlog(blg)) {
				request.setAttribute("blogAddSucessMessage", "New Blog Added Successfully. <br> Add More .");
			} else {
				request.setAttribute("blogAddFailedMessage", "Failed! Try Again !!!");
			}

			request.getRequestDispatcher("addBlog.jsp").forward(request, response);

		} else if (opeartion.equalsIgnoreCase("edit")) {

			Blog blg = new Blog();
			blg.setBlogId(Integer.parseInt(request.getParameter("blogId")));
			blg.setBlogTitle(request.getParameter("blogTitle"));
			blg.setBlogData(request.getParameter("blogData"));
			blg.setLinkRelated(request.getParameter("links"));
			blg.setLastEdited(new Date().toString());
			
			if (blogDaoImpl.editBlog(blg)) {
				request.setAttribute("blogEditSucessMessage", "Blog Updated Successfully.");
			} else {
				request.setAttribute("blogEditFailedMessage", "Failed! Try Again !!!");
			}

			request.getRequestDispatcher("blogServlet?operation=viewAllBlog").forward(request, response);

		} else if (opeartion.equalsIgnoreCase("viewAllBlog")) {

			doGet(request, response);

		}

	}

}

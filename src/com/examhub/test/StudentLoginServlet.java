package com.examhub.test;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.examhub.impl.StudentDaoImpl;

/**
 * Servlet implementation class StudentLoginServlet
 */
@WebServlet("/studentLogin")
public class StudentLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public StudentLoginServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	StudentDaoImpl studentImpl = new StudentDaoImpl();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		String operation = request.getParameter("operation");

		if (operation.equalsIgnoreCase("logout")) {
			HttpSession session = request.getSession();
			session.invalidate();
			request.setAttribute("studentLogoutSucessMessage", "Admin Logout Success");

			request.getRequestDispatcher("studentHome.jsp").forward(request, response);
		}
		else {
			request.getRequestDispatcher("studentHome.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String operation = request.getParameter("operation");

		String username = request.getParameter("username");
		System.out.println(" IN BABA IN SERVLET " + username);
		String password = ((Integer) request.getParameter("password").hashCode()).toString();

		System.out.println(password);
		if (operation.equalsIgnoreCase("login")) {
			if (studentImpl.login(username, password)) {
				HttpSession session = request.getSession();
				session.setAttribute("studentLogin", username);
				request.setAttribute("studentLoginSucessMessage", "Admin Login Success");

				request.getRequestDispatcher("studentHome.jsp").forward(request, response);
			} else {
				request.setAttribute("studentLoginFailedMessage", "Admin Login Failed ! Try Again !!!");

				request.getRequestDispatcher("studentLogin.jsp").forward(request, response);

			}
		}
	}

}

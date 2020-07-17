package com.examhub.test;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.examhub.dao.AdminDao;
import com.examhub.impl.AdminDaoImpl;

/**
 * Servlet implementation class AdminLogin
 */
@WebServlet("/auth")
public class AdminLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	AdminDao adminImpl = new AdminDaoImpl();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminLogin() {
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
		HttpSession session = request.getSession();
		session.invalidate();
		request.setAttribute("adminLogoutSucessMessage", "Admin Logout Success");

		request.getRequestDispatcher("adminLogin.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String username = request.getParameter("username");
		System.out.println(" IN BABA IN SERVLET \n "+username);
		String password = ((Integer) request.getParameter("password").hashCode()).toString();

		System.out.println(password);

		if (adminImpl.login(username, password)) {
			HttpSession session = request.getSession();
			session.setAttribute("adminLogin", username);
			request.setAttribute("adminLoginSucessMessage", "Admin Login Success");

			request.getRequestDispatcher("home.jsp").forward(request, response);
		} else {
			request.setAttribute("adminLoginFailedMessage", "Admin Login Failed ! Try Again !!!");

			request.getRequestDispatcher("adminLogin.jsp").forward(request, response);

		}
	}

}


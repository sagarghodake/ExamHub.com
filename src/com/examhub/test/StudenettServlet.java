package com.examhub.test;

import java.io.IOException;
import java.math.BigInteger;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.examhub.dao.StudentDao;
import com.examhub.impl.StudentDaoImpl;
import com.examhub.pojo.Student;
import com.sun.corba.se.spi.orb.Operation;
import com.sun.scenario.effect.impl.state.LinearConvolveRenderState.PassType;

/**
 * Servlet implementation class ManageExamStudent
 */
@WebServlet("/studentServlet")
public class StudenettServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	StudentDao studentDaoImpl = new StudentDaoImpl();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public StudenettServlet() {
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
		HttpSession hs=request.getSession();
		String username=(String)hs.getAttribute("studentLogin");
		if (opeartion.equalsIgnoreCase("viewProfile")){
			Student studentToEdit=studentDaoImpl.viewProfile(username);
			request.setAttribute("studentToEdit", studentToEdit);
			
			request.getRequestDispatcher("editProfile.jsp").forward(request, response);
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
		HttpSession hs=request.getSession();
		String username=(String)hs.getAttribute("studentLogin");

		if (opeartion.equalsIgnoreCase("add")) {

			Student student = new Student();
			String contact=request.getParameter("contact");
			student.setName(request.getParameter("studentName"));
			student.setUsername(request.getParameter("username"));
			student.setPassword(((Integer)request.getParameter("password").hashCode()).toString());
			student.setAddress(request.getParameter("address"));
			student.setGender(request.getParameter("gender"));
			student.setDateOfBirth(request.getParameter("dob"));
			student.setEmail(request.getParameter("email"));
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			student.setRegDate(dateFormat.format(new Date()));
			student.setContact(contact);

			System.out.println(student+" hhhhhhhhhhhhhhhhh ");
			
			if (studentDaoImpl.registerStudent(student)) {
				request.setAttribute("studentRegisterSucessMessage", " Registration Success. <br> Now Login .");
			} else {
				request.setAttribute("studentRegisterFailedMessage", "Failed! Try Again !!!");
			}

			request.getRequestDispatcher("studentLogin.jsp").forward(request, response);
		} 
		else if (opeartion.equalsIgnoreCase("editProfile")) {

			Student student = new Student();
			String contact=request.getParameter("contact");
			student.setName(request.getParameter("studentName"));
			student.setUsername((String)request.getSession().getAttribute("studentLogin"));
			student.setAddress(request.getParameter("address"));
			student.setGender(request.getParameter("gender"));
			student.setDateOfBirth(request.getParameter("dob"));
			student.setEmail(request.getParameter("email"));
			student.setContact(contact);

			System.out.println(student+" hhhhhhhhhhhhhhhhh ");
			
			if (studentDaoImpl.updateProfile(student)) {
				request.setAttribute("studentEditSucessMessage", " Profile Edit Successful. <br> Now Login .");
			} else {
				request.setAttribute("studentEditFailedMessage", "Failed! Try Again !!!");
			}


			Student studentToEdit=studentDaoImpl.viewProfile(username);
			request.setAttribute("studentToEdit", studentToEdit);
			
			request.getRequestDispatcher("editProfile.jsp").forward(request, response);
		

		} else if (opeartion.equalsIgnoreCase("changePassword")) {
			
			String oldPassword=((Integer) request.getParameter("oldPassword").hashCode()).toString();
			String newPassword=((Integer) request.getParameter("newPassword").hashCode()).toString();
			
			
			
			
			boolean validUser=studentDaoImpl.login(username,oldPassword);
			System.out.println(studentDaoImpl.login(username.trim(), "oldPassword"));
			
			if(validUser){
				boolean passwordChangedStatus=studentDaoImpl.changePassword(username, newPassword);
				if(passwordChangedStatus){
					request.setAttribute("studentChangeSucessMessage", " Change Password Successfully. <br> Now Login .");
					
				}else{
					request.setAttribute("studentChangeFailedMessage", " Change Password Failed. <br>  Try Again !!!");	
				}
				request.getRequestDispatcher("changepassword.jsp").forward(request, response);
			}else{
				request.setAttribute("studentChangeFailedMessage", " Your Old Password is Incorrect. <br>  Try Again !!!");	
			}
			request.getRequestDispatcher("changepassword.jsp").forward(request, response);

			System.out.println(oldPassword);
			System.out.println(newPassword);
			System.out.println(validUser);
			System.out.println();

			doGet(request, response);

		}
		 else if (opeartion.equalsIgnoreCase("editProfile")) {
				
				
				doGet(request, response);

			}

	}

}

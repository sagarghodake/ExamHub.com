\<%@page import="java.util.*"%>
<%@page import="com.examhub.pojo.*"%>
<%@page import="com.examhub.impl.*"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<link
	href="https://fonts.googleapis.com/css?family=Raleway:100,200,300,400,500,600,700,800,900&display=swap"
	rel="stylesheet">

<link rel="icon" href="assets1\test.png">

<!--

Breezed Template

https://templatemo.com/tm-543-breezed

-->
<!-- Additional CSS Files -->
<link rel="stylesheet" type="text/css"
	href="assets1/css/bootstrap.min.css">

<link rel="stylesheet" type="text/css"
	href="assets1/css/font-awesome.css">

<link rel="stylesheet" href="assets1/css/templatemo-breezed.css">

<link rel="stylesheet" href="assets1/css/owl-carousel.css">

<link rel="stylesheet" href="assets1/css/lightbox.css">
<style>
.dropdown-submenu {
	position: relative;
}

.dropdown-submenu .dropdown-menu {
	top: 0;
	left: 100%;
	margin-top: -1px;
}
</style>

</head>

<body>

	<!-- ***** Preloader Start ***** -->
	<div id="preloader">
		<div class="jumper">
			<div></div>
			<div></div>
			<div></div>
		</div>
	</div>
	<!-- ***** Preloader End ***** -->


	<!-- ***** Header Area Start ***** -->
	<header class="header-area header-sticky background-header">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<nav class="main-nav">
						<a href="studentHome.jsp" class="logo"> ExamHub.com </a>
						<ul class="nav">
							
							<li class="submenu"><a href="javascript:;">ExamHub</a>
								<ul>
									<li class="scroll-to-section"><a href="studentHome.jsp">Home</a></li>
									<li><a href="blogServlet?operation=viewAllBlog&type=student">Blogs</a></li>
									<li><a href="testServlet?operation=viewUpcomingTest">Upcoming
											Exam</a></li>
									<li><a href="scope.jsp">Scope & Importance</a></li>
									<li><a href="sucessStories.jsp">Success Stories</a></li>
								</ul></li>

						
								
							<%
								String studentLogin = (String) session.getAttribute("studentLogin");

								if (studentLogin != null) {
							%>
							
									<li class="submenu"><a href="javascript:;">Resources</a>
								<ul>
									<li><a href="jobListing?operation=view">Placement</a></li>
									<li><a href="nontecnical.jsp">Interview Preparation</a></li>
									<li><a href="interviewQuestion.jsp">Question Bank</a></li>	
									<li><a href="rules.jsp">Rules & Regulations</a></li>
									<li><a href="studyMaterial.jsp">Study Material</a></li>
								</ul></li>
								
								<li><a href="testServlet?operation=seachTestPapers&type=practice">Practice Test</a></li>
								
								

				

							<li class="submenu"><a href="#">Exam</a>
								<ul>

									<%
										List<Category> listOfCategories = new CategoryDaoImpl().viewAllCategories();
											for (Category cat : listOfCategories) {
									%>
									<li><a
										href="testServlet?operation=seachTestPapers&type=mock&categoryId=<%=cat.getCategoryId()%>"><%=cat.getCategoryName()%></a></li>
									<%
										}
									%>
								</ul></li>
								
								<li class="submenu"><a href="javascript:;">MyAccount</a>
								<ul>
									<li><a href="changepassword.jsp">Change Password</a></li>
									<li><a href="studentServlet?operation=viewProfile">Edit Profile</a></li>
									<li><a href="studentResult.jsp">Result</a></li>
								</ul></li>

							<li class="submenu"><a href="javascript:;">About</a>
								<ul>
									<li><a href="aboutus.jsp">Examhub.com</a></li>
									<li><a href="contactus.jsp">Contact us</a></li>
								</ul></li>


							<li><a href="studentLogin?operation=logout">Logout</a></li>

							<%
								} else {
							%>
								
							<li class="submenu"><a href="javascript:;">About</a>
								<ul>
									<li><a href="aboutus.jsp">Examhub.com</a></li>
									<li><a href="contactus.jsp">Contact us</a></li>
								</ul></li>
								
							<li class="submenu"><a href="javascript:;">Login</a>
								<ul>
									<li><a href="studentLogin.jsp">Student</a></li>
									<li><a href="adminLogin.jsp">Admin</a></li>
								</ul></li>


							<%
								}
							%>
						</ul>

						<a class='menu-trigger'> <span>Menu</span>
						</a>
						<!-- ***** Menu End ***** -->
					</nav>
				</div>
			</div>
		</div>
	</header>
	<div class="scroll-down scroll-to-section">
		<a href="#about"><i class="fa fa-arrow-down"></i></a>
	</div>

	<!-- ***** Header Area End ***** -->

	<!-- ***** Search Area ***** -->
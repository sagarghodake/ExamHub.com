<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<%@page import="com.examhub.pojo.*"%>
<%@page autoFlush="true" buffer="100kb"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Examhub | Blogs</title>
</head>
<body>
	<jsp:include page="menu1.jsp" />

	<section class="section" id="about">
		<div class="container">
		<center><u><h1>ExamHub.com Blogs</h1></u></center><br><br>
			<%
				List<Blog> listOfAllBlog = (List<Blog>) request.getAttribute("listOfAllBlog");

				for (Blog blog : listOfAllBlog) {
			%>

			<div class="row">

				<div class="col-sm-4">
				<h5><%=blog.getBlogTitle()%></h5>

					<img src="assets1/images/java-logo.jpg.webp" class="rounded-circle"
						alt="">


				</div>
				<div class="col-sm-8">


					<p style="text-align: justify;">
						<%=blog.getBlogData().replaceAll("<[^>]*>", " ").substring(0, 500)%>
						......<a
							href="blogServlet?operation=viewBlog&blogId=<%=blog.getBlogId()%>">Read
							More</a>
					</p>
				</div>


			</div>

			<%
				}
			%>









		</div>
	</section>



	<jsp:include page="footer1.jsp" />
</body>
</html>
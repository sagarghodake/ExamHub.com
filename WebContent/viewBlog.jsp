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
			<%
				Blog blogToView = (Blog) request.getAttribute("blogToView");
			%>

			<div class="row">

				<div class="col-sm-12">
					<h5><%=blogToView.getBlogTitle()%></h5>


					<p style="text-align: justify;">
						<%=blogToView.getBlogData()%>
					</p>
				</div>


			</div>
		</div>
	</section>



	<jsp:include page="footer1.jsp" />
</body>
</html>
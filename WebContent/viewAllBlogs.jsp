<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<%@page import="com.examhub.pojo.*"%>
<%@page autoFlush="true" buffer="20kb"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ExamHub.com | Admin | Blog | view Blog</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<section class="content">
		<div class="body_scroll">
			<div class="block-header">
				<div class="row">
					<div class="col-lg-7 col-md-6 col-sm-12">
						<h2>Blog</h2>
						<ul class="breadcrumb">
							<li class="breadcrumb-item"><a href="home.jsp"><i
									class="zmdi zmdi-home"></i> Home </a></li>
							<li class="breadcrumb-item active">Blog</li>
						</ul>
						<button class="btn btn-primary btn-icon mobile_menu" type="button">
							<i class="zmdi zmdi-sort-amount-desc"></i>
						</button>
					</div>
					<div class="col-lg-5 col-md-6 col-sm-12">
						<button
							class="btn btn-primary btn-icon float-right right_icon_toggle_btn"
							type="button">
							<i class="zmdi zmdi-arrow-right"></i>
						</button>
					</div>
				</div>
			</div>
		</div>
		<div class="container-fluid">
			<div class="row clearfix">
				<div class="col-lg-12">

					<div class="card">
						<div class="body">
							<small>Manage your Blog Details here .
							</small> <br>

							<div class="col-sm-8 offset-sm-2">
								<a href="addBlog.jsp"
									class="btn btn-raised btn-primary btn-round waves-effect">Add
									Blog</a> <a href="blogServlet?operation=viewAllBlog"
									class="btn btn-raised btn-primary btn-round waves-effect">View
									All</a>
							</div>

						</div>
					</div>

				
							

							<%
								String admin = (String) session.getAttribute("adminLogin");
								List<Blog> listOfAllBlog = (List<Blog>) request.getAttribute("listOfAllBlog");
								if (admin == null) {
									response.sendRedirect("adminLogin.jsp");
								}
							%>
						
					</div>
					<div class="card">
						<div class="body">

<%
								String blogEditSucessMessage = (String) request.getAttribute("blogEditSucessMessage");
								String blogEditFailedMessage = (String) request.getAttribute("blogEditFailedMessage");
								String blogDeleteSucessMessage = (String) request.getAttribute("blogDeleteSucessMessage");
								String blogDeleteFailedMessage = (String) request.getAttribute("blogDeleteFailedMessage");

								if (blogEditSucessMessage != null) {
							%>
							<span style="align-content: center; color: green"><%=blogEditSucessMessage%></span>
							<%
								}

								if (blogEditFailedMessage != null) {
							%>
							<span style="align-content: center; color: red"><%=blogEditFailedMessage%></span>
							<%
								}

								if (blogDeleteSucessMessage != null) {
							%>
							<span style="align-content: center; color: green"><%=blogDeleteSucessMessage%></span>
							<%
								}

								if (blogDeleteFailedMessage != null) {
							%>
							<span style="align-content: center; color: red"><%=blogDeleteFailedMessage%></span>

							<%
								}
							%>


							<div class="table-responsive">
								<table
									class="table table-bordered table-striped table-hover dataTable js-exportable">
									<thead>
										<tr>
											<th>Blog ID</th>
											<th>Blog title</th>
											<th data-breakpoints="sm xs">action</th>
										</tr>
									</thead>
									<tbody>

										<%
											if (listOfAllBlog.size() == 0) {
										%>

										<tr>
											<td colspan="4"><span
												style="align-content: center; color: green">No
													Blogs Added yet !</span></td>
										</tr>
										<!-- <div class="alert alert-success">
									
								</div>-->


										<%
											} else {

												for (Blog blog : listOfAllBlog) {
										%>
										<tr>
											<td><span class="text-muted"><%=blog.getBlogId()%></span></td>
											<td><h5><%=blog.getBlogTitle()%></h5></td>

											<td><a
												href="blogServlet?operation=edit&blogId=<%=blog.getBlogId()%>"
												class="btn btn-default waves-effect waves-float btn-sm waves-green"><i
													class="zmdi zmdi-edit"></i></a> <a
												onclick="return confirm('Do You Really Want To Delete This?');"
												href="blogServlet?operation=delete&blogId=<%=blog.getBlogId()%>"
												class="btn btn-default waves-effect waves-float btn-sm waves-red"><i
													class="zmdi zmdi-delete"></i></a></td>


										</tr>

										<%
											}
											}
										%>
									</tbody>
								</table>
							</div>

						</div>
					</div>
				</div>
			</div>
	</section>

</body>
<jsp:include page="footer.jsp" />
</html>
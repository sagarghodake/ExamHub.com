<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<%@page import="com.examhub.pojo.*"%>
<%@page autoFlush="true" buffer="20kb"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ExamHub.com | Admin Panel | Category | view Category</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<section class="content">
		<div class="body_scroll">
			<div class="block-header">
				<div class="row">
					<div class="col-lg-7 col-md-6 col-sm-12">
						<h2>Category</h2>
						<ul class="breadcrumb">
							<li class="breadcrumb-item"><a href="home.jsp"><i
									class="zmdi zmdi-home"></i> Home </a></li>
							<li class="breadcrumb-item active">Exam Category</li>
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
							<small>Manage your Exam Categories here . Categories i.e
								Domains (e.g., <code>.Banking,Development,Testing</code>)
							</small> <br>

							<div class="col-sm-8 offset-sm-2">
								<a href="addCategory.jsp"
									class="btn btn-raised btn-primary btn-round waves-effect">Add
									Category</a> <a href="categoryServlet?operation=viewAllCategories"
									class="btn btn-raised btn-primary btn-round waves-effect">View
									All</a>
							</div>

						</div>
					</div>

				
							

							<%
								String admin = (String) session.getAttribute("adminLogin");
								List<Category> listOfAllCategory = (List<Category>) request.getAttribute("listOfAllCategory");
								if (admin == null) {
									response.sendRedirect("index.jsp");
								}
							%>
						
					</div>
					<div class="card">
						<div class="body">

<%
								String categoryEditSucessMessage = (String) request.getAttribute("categoryEditSucessMessage");
								String categoryEditFailedMessage = (String) request.getAttribute("categoryEditFailedMessage");
								String categoryDeleteSucessMessage = (String) request.getAttribute("categoryDeleteSucessMessage");
								String categoryDeleteFailedMessage = (String) request.getAttribute("categoryDeleteFailedMessage");

								if (categoryEditSucessMessage != null) {
							%>
							<span style="align-content: center; color: green"><%=categoryEditSucessMessage%></span>
							<%
								}

								if (categoryEditFailedMessage != null) {
							%>
							<span style="align-content: center; color: red"><%=categoryEditFailedMessage%></span>
							<%
								}

								if (categoryDeleteSucessMessage != null) {
							%>
							<span style="align-content: center; color: green"><%=categoryDeleteSucessMessage%></span>
							<%
								}

								if (categoryDeleteFailedMessage != null) {
							%>
							<span style="align-content: center; color: red"><%=categoryDeleteFailedMessage%></span>

							<%
								}
							%>


							<div class="table-responsive">
								<table
									class="table table-bordered table-striped table-hover dataTable js-exportable">
									<thead>
										<tr>
											<th>Category ID</th>
											<th>Category Name</th>
											<th data-breakpoints="sm xs">action</th>
										</tr>
									</thead>
									<tbody>

										<%
											if (listOfAllCategory.size() == 0) {
										%>

										<tr>
											<td colspan="4"><span
												style="align-content: center; color: green">No
													Categories Added yet !</span></td>
										</tr>
										<!-- <div class="alert alert-success">
									
								</div>-->


										<%
											} else {

												for (Category category : listOfAllCategory) {
										%>
										<tr>
											<td><span class="text-muted"><%=category.getCategoryId()%></span></td>
											<td><h5><%=category.getCategoryName()%></h5></td>

											<td><a
												href="categoryServlet?operation=edit&categoryId=<%=category.getCategoryId()%>"
												class="btn btn-default waves-effect waves-float btn-sm waves-green"><i
													class="zmdi zmdi-edit"></i></a> <a
												onclick="return confirm('Do You Really Want To Delete This?');"
												href="categoryServlet?operation=delete&categoryId=<%=category.getCategoryId()%>"
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
		</div>
	</section>

</body>
<jsp:include page="footer.jsp" />
</html>
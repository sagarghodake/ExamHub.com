<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<%@page import="com.examhub.pojo.*"%>
<%@page autoFlush="true" buffer="20kb"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ExamHub.com | Admin Panel | blog | Add blog Page</title>
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

						<small>Manage your Blog Details here . </small>

						<%
						Blog blogToEdit =(Blog)request.getAttribute("blogToEdit");
						%>

					</div>
				</div>
				<div class="col-lg-8 col-md-12">
					<div class="card">


						<%
							String admin = (String) session.getAttribute("adminLogin");
							if (admin == null) {
								response.sendRedirect("index.jsp");
							} else {
						%>


						<!-- Horizontal Layout -->
						<div class="row clearfix">
							<div class="col-lg-12 col-md-12 col-sm-12">
								<div class="card">
									<div class="header">
										<h2>
											<strong>Add</strong> New blog
										</h2>

									</div>
									<div class="body">
										<form class="form-horizontal" id="frm1" method="post">
											<input type="hidden" name="operation" value="edit">
											
											<div class="row clearfix">
												<div class="col-lg-2 col-md-2 col-sm-4 form-control-label">
													<label for="email_address_2">blog Id</label>
												</div>
												<div class="col-lg-10 col-md-10 col-sm-8">
													<div class="form-group">
														<input name="blogId" value="<%=blogToEdit.getBlogId() %>" type="text" readonly class="form-control"
															placeholder="Enter New blog Title">
													</div>
												</div>
											</div>
											
											
											<div class="row clearfix">
												<div class="col-lg-2 col-md-2 col-sm-4 form-control-label">
													<label for="email_address_2">blog Ttile</label>
												</div>
												<div class="col-lg-10 col-md-10 col-sm-8">
													<div class="form-group">
														<input name="blogTitle" type="text" value="<%=blogToEdit.getBlogTitle()%>" class="form-control"
															placeholder="Enter New blog Title">
													</div>
												</div>
											</div>


											<div class="row clearfix">
												<div class="col-lg-2 col-md-2 col-sm-4 form-control-label">
													<label for="email_address_2">blog Data</label>
												</div>
												<div class="col-lg-10 col-md-10 col-sm-8">
													<div class="form-group">
														<textarea  name="blogData" class="form-control"
															placeholder="Enter New blog Data"><%=blogToEdit.getBlogData() %></textarea>
													</div>
												</div>
											</div>
											
											
											
											<div class="row clearfix">
												<div class="col-lg-2 col-md-2 col-sm-4 form-control-label">
													<label for="email_address_2">blog links</label>
												</div>
												<div class="col-lg-10 col-md-10 col-sm-8">
													<div class="form-group">
														<input name="links"  value="<%=blogToEdit.getLinkRelated() %>" type="text" class="form-control"
															placeholder="Enter New blog links">
													</div>
												</div>
											</div>
											
											
								
											<div class="col-sm-8 offset-sm-2">
												<button onclick="callAdd()" type="button"
													class="btn btn-raised btn-primary btn-round waves-effect">
													Edit blog</button>
											</div>

										</form>
									</div>
								</div>
							</div>
						</div>

						<%
							}
						%>
					</div>
				</div>

				<div class="col-lg-4 col-md-12">
					<div class="card">
						<div class="header">
							<h2>
								<strong>Opeartions</strong>
							</h2>
						</div>
						<div class="body">
							<ul class="list-unstyled mb-0 widget-categories">
								<li><a href="addBlog.jsp">Add blog</a></li>
								<li><a href="blogServlet?operation=viewAllBlog">view</a></li>
							</ul>
						</div>
						<
					</div>

				</div>

			</div>
	</section>

</body>
<script>
	function callAdd() {
		var ff = document.getElementById("frm1");
		ff.action = "./blogServlet";
		ff.submit();
	}
</script>
<jsp:include page="footer.jsp" />
</html>
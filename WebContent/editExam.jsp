<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<%@page import="com.examhub.pojo.*"%>
<%@page import="com.examhub.impl.*"%>
<%@page autoFlush="true" buffer="20kb"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
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
							<li class="breadcrumb-item active">Exam</li>
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

						<small>Manage your Exam here . Exam (e.g., <code>.SBI
								Clerk Prelims, java SE 8</code>)
						</small>

						<%
							String examEditSucessMessage = (String) request.getAttribute("examEditSucessMessage");
							String examEditFailedMessage = (String) request.getAttribute("examEditFailedMessage");

							if (examEditSucessMessage != null) {
						%>


						<span style="align-content: center; color: green"><%=examEditSucessMessage%></span>


						<%
							}
						%>

						<%
							if (examEditFailedMessage != null) {
						%>

						<span style="align-content: center; color: red"><%=examEditFailedMessage%></span>

						<%
							}
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

								CategoryDaoImpl catDaoImpl = new CategoryDaoImpl();
								List<Category> listOfCategories = catDaoImpl.viewAllCategories();

								Exam examToEdit = (Exam) request.getAttribute("examToEdit");
						%>


						<!-- Horizontal Layout -->
						<div class="row clearfix">
							<div class="col-lg-12 col-md-12 col-sm-12">
								<div class="card">
									<div class="header">
										<h2>
											<strong>Edit</strong> New Exam
										</h2>

									</div>
									<div class="body">
										<form class="form-horizontal" id="frm1" method="post">
											<input type="hidden" name="operation" value="edit">

											<div class="row clearfix">
												<div class="col-lg-2 col-md-2 col-sm-4 form-control-label">
													<label for="email_address_2">Exam Id</label>
												</div>
												<div class="col-lg-10 col-md-10 col-sm-8">
													<div class="form-group">
														<input name="examId" type="number" readonly
															value="<%=examToEdit.getExamId()%>" class="form-control"
															placeholder="Exam Id">
													</div>
												</div>
											</div>


											<div class="row clearfix">
												<div class="col-lg-2 col-md-2 col-sm-4 form-control-label">
													<label for="email_address_2">Exam Name</label>
												</div>
												<div class="col-lg-10 col-md-10 col-sm-8">
													<div class="form-group">
														<input name="examName"
															value="<%=examToEdit.getExamName()%>" type="text"
															class="form-control" placeholder="Exam Name">
													</div>
												</div>
											</div>

											
											<div class="row clearfix">
												<div class="col-lg-2 col-md-2 col-sm-4 form-control-label">
													<label for="email_address_2">Select Exam Category</label>
												</div>
												<div class="col-lg-10 col-md-10 col-sm-8">
													<div class="form-group">
														<select class="form-control show-tick ms select2"
															
															name="categoryId">
															<%
																for (Category cat : listOfCategories) {

																		if (cat.getCategoryId() == examToEdit.getCategoryId()) {
															%>

															<option selected="selected" value="<%=cat.getCategoryId()%>"><%=cat.getCategoryName()%></option>
															<%
																} else {
															%>
															<option value="<%=cat.getCategoryId()%>"><%=cat.getCategoryName()%></option>

															<%
																}
																	}
															%>
														</select>
													</div>
												</div>
											</div>

											<div class="col-sm-8 offset-sm-2">
												<button onclick="callEdit()" type="button"
													class="btn btn-raised btn-primary btn-round waves-effect">Edit
													New Exam</button>
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
								<li><a href="addCategory.jsp">Add Exam</a></li>
								<li><a href="examServlet?operation=view">view</a></li>
							</ul>
						</div>
						<
					</div>

				</div>

			</div>
	</section>

</body>
<script>
	function callEdit() {
		var ff = document.getElementById("frm1");
		ff.action = "./examServlet";
		ff.submit();
	}
</script>
<jsp:include page="footer.jsp" />
</html>
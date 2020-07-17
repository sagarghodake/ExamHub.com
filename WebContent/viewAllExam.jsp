<%@page import="com.examhub.impl.CategoryDaoImpl"%>
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
<title>ExamHub.com | Admin | Examt</title>
</head>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<section class="content">
		<div class="body_scroll">
			<div class="block-header">
				<div class="row">
					<div class="col-lg-7 col-md-6 col-sm-12">
						<h2>Exam</h2>
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
						<div class="body">
							<small>Manage your Exam here . Exam i.e Subject (e.g., <code>.java,python,mentis e.t.c</code>)
							</small><br>
							
						
							<div class="col-sm-8 offset-sm-2">
									<a href="addExam.jsp" 
										class="btn btn-raised btn-primary btn-round waves-effect">Add New Exam</a>
										
									<a href="examServlet?operation=view"
										class="btn btn-raised btn-primary btn-round waves-effect" >View All</a>
								</div>
						
						</div>
					</div>
				</div>
				<div class="col-lg-12 col-md-12">
					<div class="card">
						<div class="body">

							<%
								String admin = (String) session.getAttribute("adminLogin");
								List<Exam> listOfAllExam = (List<Exam>) request.getAttribute("listOfAllexam");
								Category category = (Category) request.getAttribute("categoryOfExam");

								if (admin == null) {
									response.sendRedirect("index.jsp");
								}
								CategoryDaoImpl catDaoImpl = new CategoryDaoImpl();
								List<Category> listOfCategories = catDaoImpl.viewAllCategories();
							%>


							<form class="form-horizontal" id="frm1" method="get">

								<div class="row clearfix">
									<div class="col-lg-2 col-md-2 col-sm-4 form-control-label">
										<label for="email_address_2">Select Exam Category</label>
									</div>
									<div class="col-lg-10 col-md-10 col-sm-8">
										<div class="form-group">
											<select class="form-control show-tick ms select2"
												data-placeholder="Select" name="categoryId">
												<%
													for (Category cat : listOfCategories) {
												%>
												<option value="<%=cat.getCategoryId()%>"><%=cat.getCategoryName()%></option>
												<%
													}
												%>
											</select>
										</div>
									</div>
								</div>

								<div class="col-sm-8 offset-sm-2">
									<button onclick="callAdd()" type="button"
										class="btn btn-raised btn-primary btn-round waves-effect">View
										All Exam</button>
									<button onclick="callAdd1()" type="button"
										class="btn btn-raised btn-primary btn-round waves-effect">delete
										All Exam</button>
								</div>



							</form>
						</div>
					</div>
					<div class="card">
						<div class="body">
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


							<%
								String examDeleteSucessMessage = (String) request.getAttribute("examDeleteSucessMessage");
								String examDeleteFailedMessage = (String) request.getAttribute("examDeleteFailedMessage");

								if (examDeleteSucessMessage != null) {
							%>


							<span style="align-content: center; color: green"><%=examDeleteSucessMessage%></span>


							<%
								}
							%>

							<%
								if (examDeleteFailedMessage != null) {
							%>


							<span style="align-content: center; color: red"><%=examDeleteFailedMessage%></span>

							<%
								}
							%>




							<div class="table-responsive">
								<table
									class="table table-bordered table-striped table-hover dataTable js-exportable">
									<thead>
										<tr>
											<th>Exam ID</th>
											<th>Exam Name</th>
											<th>Exam Category</th>
											<th data-breakpoints="sm xs">action</th>
										</tr>
										
									</thead>
									<tbody>

										<%
											if (listOfAllExam.size() == 0) {
										%>

										<tr>
											<td colspan="4">
												<%
													if (category != null) {
												%> <span style="align-content: center; color: green">No
													Exam Added yet in !<%=category.getCategoryName()%></span> <%
 	} else {
 %> <span style="align-content: center; color: green">No Exam
													Added yet in any Category!</span> <%
 	}
 %>

											</td>
										</tr>
										<!-- <div class="alert alert-success">
									
								</div>-->


										<%
											} else {
												CategoryDaoImpl categoryDaoImpl = new CategoryDaoImpl();
												for (Exam exam : listOfAllExam) {
										%>
										<tr>
											<td><span class="text-muted"><%=exam.getExamId()%></span></td>
											<td><h5><%=exam.getExamName()%></h5></td>

											<%
												Category examCategory = categoryDaoImpl.viewCategory(exam.getCategoryId());
											%>

											<td><h5><%=examCategory.getCategoryName()%></h5></td>


											<td><a
												href="examServlet?operation=edit&examId=<%=exam.getExamId()%>"
												class="btn btn-default waves-effect waves-float btn-sm waves-green"><i
													class="zmdi zmdi-edit"></i></a> <a
												onclick="return confirm('Do You Really Want To Delete This?');"
												href="examServlet?operation=delete&examId=<%=exam.getExamId()%>"
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

<script>
	function callAdd1() {
		var ff = document.getElementById("frm1");
		var input = document.createElement("input");
		input.setAttribute('type', 'hidden');
		input.setAttribute('name', 'operation');

		input.setAttribute('value', 'deleteByCategory');
		ff.appendChild(input);
		ff.action = "./examServlet";
		ff.submit();
	}

	function callAdd() {
		var ff = document.getElementById("frm1");
		var input = document.createElement("input");
		input.setAttribute('type', 'hidden');
		input.setAttribute('name', 'operation');

		input.setAttribute('value', 'view');
		ff.appendChild(input);

		ff.action = "./examServlet";
		ff.submit();
	}
</script>
<jsp:include page="footer.jsp" />
</html>
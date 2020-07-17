<%@page import="com.examhub.impl.CategoryDaoImpl"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<%@page import="com.examhub.pojo.*"%>
<%@page import="com.examhub.impl.*"%>
<%@page import="java.text.*"%>
<%@page autoFlush="true" buffer="20kb"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ExamHub.com | Admin | Test</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<section class="content">
		<div class="body_scroll">
			<div class="block-header">
				<div class="row">
					<div class="col-lg-7 col-md-6 col-sm-12">
						<h2>Test</h2>
						<ul class="breadcrumb">
							<li class="breadcrumb-item"><a href="home.jsp"><i
									class="zmdi zmdi-home"></i> Home </a></li>
							<li class="breadcrumb-item active">Test</li>
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
							<small>Manage your Test of Each Exam here . </small><br>


							<div class="col-sm-8 offset-sm-2">
								<a href="addTest.jsp"
									class="btn btn-raised btn-primary btn-round waves-effect">Add
									Test</a> <a href="testServlet?operation=view"
									class="btn btn-raised btn-primary btn-round waves-effect">View
									All</a>
							</div>

						</div>
					</div>
				</div>
				<div class="col-lg-12 col-md-12">
					<div class="card">
						<div class="body">

							<%
								String admin = (String) session.getAttribute("adminLogin");
								List<Test> listOfAllTest = (List<Test>) request.getAttribute("listOfAlltest");
								Exam exam = (Exam) request.getAttribute("examOfTest");

								if (admin == null) {
							%>
							<jsp:forward page="adminLogin.jsp" />
							<%
								}
								ExamDaoImpl examDaoImpl = new ExamDaoImpl();
								List<Exam> listOfExams = examDaoImpl.viewAllExam();
							%>


							<form class="form-horizontal" id="frm1" method="get">

								<div class="row clearfix">
									<div class="col-lg-2 col-md-2 col-sm-4 form-control-label">
										<label for="email_address_2">Select Test Exam</label>
									</div>
									<div class="col-lg-10 col-md-10 col-sm-8">
										<div class="form-group">
											<select class="form-control show-tick ms select2"
												data-placeholder="Select" name="examId">
												<%
													for (Exam cat : listOfExams) {
												%>
												<option value="<%=cat.getExamId()%>"><%=cat.getExamName()%></option>
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
										All Test</button>
									<button onclick="callAdd1()" type="button"
										class="btn btn-raised btn-primary btn-round waves-effect">delete
										All Test</button>
								</div>



							</form>

						</div>
					</div>
					<div class="card">
						<div class="body">
							<%
								String testEditSucessMessage = (String) request.getAttribute("testEditSucessMessage");
								String testEditFailedMessage = (String) request.getAttribute("testEditFailedMessage");

								if (testEditSucessMessage != null) {
							%>


							<span style="align-content: center; color: green"><%=testEditSucessMessage%></span>


							<%
								}
							%>

							<%
								if (testEditFailedMessage != null) {
							%>


							<span style="align-content: center; color: red"><%=testEditFailedMessage%></span>

							<%
								}
							%>


							<%
								String testDeleteSucessMessage = (String) request.getAttribute("testDeleteSucessMessage");
								String testDeleteFailedMessage = (String) request.getAttribute("testDeleteFailedMessage");

								if (testDeleteSucessMessage != null) {
							%>


							<span style="align-content: center; color: green"><%=testDeleteSucessMessage%></span>


							<%
								}
							%>

							<%
								if (testDeleteFailedMessage != null) {
							%>


							<span style="align-content: center; color: red"><%=testDeleteFailedMessage%></span>

							<%
								}
							%>



							<div class="table-responsive">
								<table
									class="table table-bordered table-striped table-hover dataTable js-exportable">
									<thead>
										<tr>
										<tr>
											<th>Test Id</th>
											<th>Test Name</th>
											<th>Test Type</th>
											<th>Subject</th>
											<th>Max Marks</th>

											<th>Test Opens</th>

											<th>Test Closes</th>
											<th data-breakpoints="sm xs">action</th>
										</tr>
									</thead>
									<tbody>

										<%
											if (listOfAllTest.size() == 0) {
										%>

										<tr>
											<td colspan="4">
												<%
													if (exam != null) {
												%> <span style="align-content: center; color: green">No
													Test Added yet in !<%=exam.getExamName()%></span> <%
 	} else {
 %> <span style="align-content: center; color: green">No Test
													Added yet in any Exam!</span> <%
 	}
 %>

											</td>
										</tr>
										<!-- <div class="alert alert-success">
									
								</div>-->


										<%
											} else {
												DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

												for (Test test : listOfAllTest) {
													String closeDate = dateFormat.format(test.getclose());

													String openDate = dateFormat.format(test.getOpen());
										%>
										<tr>
											<td><span class="text-muted"><%=test.getTestId()%></span></td>
											<td><h5><%=test.getTestName()%></h5></td>

											<td><h5><%=test.getTestType()%></h5></td>

											<%
												Exam testExam = examDaoImpl.viewExam(test.getExamId());
											%>

											<td><h5><%=testExam.getExamName()%></h5></td>
											<td><h5><%=test.getMaxMarks()%></h5></td>


											<td><h5><%=openDate%></h5></td>
											<td><h5><%=closeDate%></h5></td>
											<td><a
												href="testServlet?operation=edit&testId=<%=test.getTestId()%>"
												class="btn btn-default waves-effect waves-float btn-sm waves-green"><i
													class="zmdi zmdi-edit"></i></a> <a
												onclick="return confirm('Do You Really Want To Delete This?');"
												href="testServlet?operation=delete&testId=<%=test.getTestId()%>"
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

		input.setAttribute('value', 'deleteByExam');
		ff.appendChild(input);
		ff.action = "./testServlet";
		ff.submit();
	}

	function callAdd() {
		var ff = document.getElementById("frm1");
		var input = document.createElement("input");
		input.setAttribute('type', 'hidden');
		input.setAttribute('name', 'operation');

		input.setAttribute('value', 'view');
		ff.appendChild(input);

		ff.action = "./testServlet";
		ff.submit();
	}
</script>
<jsp:include page="footer.jsp" />
</html>
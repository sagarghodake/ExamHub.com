<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" autoFlush="true"%>
<%@page import="java.util.*"%>
<%@page import="com.examhub.pojo.*"%>
<%@page import="com.examhub.impl.*"%>
<%@page autoFlush="true" buffer="20kb"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Test</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<section class="content">
		<div class="body_scroll">
			<div class="block-header">
				<div class="row">
					<div class="col-lg-7 col-md-6 col-sm-12">
						<h2>Add Test</h2>
						<ul class="breadcrumb">
							<li class="breadcrumb-item"><a href="home.jsp"><i
									class="zmdi zmdi-home"></i> Home </a></li>
							<li class="breadcrumb-item ">Exam</li>
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

						<small>Manage your Test in here . </small>

						<%
							String testAddSucessMessage = (String) request.getAttribute("testAddSucessMessage");
							String testAddFailedMessage = (String) request.getAttribute("testAddFailedMessage");

							if (testAddSucessMessage != null) {
						%>


						<span style="align-content: center; color: green"><%=testAddSucessMessage%></span>


						<%
							}
						%>

						<%
							if (testAddFailedMessage != null) {
						%>

						<span style="align-content: center; color: red"><%=testAddFailedMessage%></span>

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
						%>
						<jsp:forward page="adminLogin.jsp" />
						<%
							} else {

								ExamDaoImpl examDaoImpl = new ExamDaoImpl();
								List<Exam> listOfExams = examDaoImpl.viewAllExam();
						%>


						<!-- Horizontal Layout -->
						<div class="row clearfix">
							<div class="col-lg-12 col-md-12 col-sm-12">
								<div class="card">
									<div class="header">
										<h2>
											<strong>Add</strong> New Test
										</h2>

									</div>



									<div class="body">

										<form class="form-horizontal" id="frm1" method="post">
											<input type="hidden" name="operation" value="add">

											<div class="row clearfix">
												<div class="col-lg-2 col-md-2 col-sm-4 form-control-label">
													<label for="email_address_2">Test Name</label>
												</div>
												<div class="col-lg-10 col-md-10 col-sm-8">
													<div class="form-group">
														<input name="testName" type="text" class="form-control"
															placeholder="eg. 0 for free else Enter figure INR">
													</div>
												</div>
											</div>


											<div class="row clearfix">
												<div class="col-lg-2 col-md-2 col-sm-4 form-control-label">
													<label for="email_address_2">Test Type</label>
												</div>
												<div class="col-lg-10 col-md-10 col-sm-8">
													<div class="form-group">
														<input name="testType" type="text" class="form-control"
															placeholder="Test Name">
													</div>
												</div>
											</div>


											<div class="row clearfix">
												<div class="col-lg-2 col-md-2 col-sm-4 form-control-label">
													<label for="email_address_2">Test Fee</label>
												</div>
												<div class="col-lg-10 col-md-10 col-sm-8">
													<div class="form-group">
														<input name="testFee" type="number" class="form-control"
															placeholder="eg. 0 for free else Enter figure INR">
													</div>
												</div>
											</div>

											<div class="row clearfix">
												<div class="col-lg-2 col-md-2 col-sm-4 form-control-label">
													<label for="email_address_2">Max Questions</label>
												</div>
												<div class="col-lg-10 col-md-10 col-sm-8">
													<div class="form-group">
														<input name="maxQuestion" type="number"
															class="form-control"
															placeholder="eg. 0 for free else Enter figure INR">
													</div>
												</div>
											</div>


											<div class="row clearfix">
												<div class="col-lg-2 col-md-2 col-sm-4 form-control-label">
													<label for="email_address_2">Max marks</label>
												</div>
												<div class="col-lg-10 col-md-10 col-sm-8">
													<div class="form-group">
														<input name="maxmarks" type="number" class="form-control"
															placeholder="eg. 0 for free else Enter figure INR">
													</div>
												</div>
											</div>

											<div class="row clearfix">
												<div class="col-lg-2 col-md-2 col-sm-4 form-control-label">
													<label for="email_address_2">Test Duration</label>
												</div>
												<div class="col-lg-10 col-md-10 col-sm-8">
													<div class="form-group">
														<input name="testDuration" type="number"
															class="form-control"
															placeholder="eg. 0 for free else Enter figure INR">
													</div>
												</div>
											</div>



											<div class="row clearfix">
												<div class="col-lg-2 col-md-2 col-sm-4 form-control-label">
													<label for="email_address_2">Select Exam </label>
												</div>
												<div class="col-lg-10 col-md-10 col-sm-8">
													<div class="form-group">
														<select class="form-control show-tick ms select2"
															data-placeholder="Select" name="examId">
															<%
																for (Exam ex : listOfExams) {

																		SectionDaoImpl sectionDaoImpl = new SectionDaoImpl();
																		if (sectionDaoImpl.viewAllSection(ex.getExamId()).size() > 0) {
															%>
															<option value="<%=ex.getExamId()%>"><%=ex.getExamName()%></option>
															<%
																}
																	}
															%>
														</select>
													</div>
												</div>
											</div>


											<div class="row clearfix">
												<div class="col-lg-2 col-md-2 col-sm-4 form-control-label">
													<label for="email_address_2">Open Date :</label>
												</div>
												<div class="col-lg-10 col-md-10 col-sm-8">
													<div class="form-group">
														<input name="openDate" type="date" class="form-control"
															placeholder="eg. 0 for free else Enter figure INR">
													</div>
												</div>
											</div>



											<div class="row clearfix">
												<div class="col-lg-2 col-md-2 col-sm-4 form-control-label">
													<label for="email_address_2">Close Date :</label>
												</div>
												<div class="col-lg-10 col-md-10 col-sm-8">
													<div class="form-group">
														<input name="closeDate" type="date" class="form-control"
															>
													</div>
												</div>
											</div>



											<div class="col-sm-8 offset-sm-2">
												<button onclick="callAdd()" type="button"
													class="btn btn-raised btn-primary btn-round waves-effect">Add
													New Test</button>
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
								<li><a href="addTest.jsp">Add Test</a></li>
								<li><a href="testServlet?operation=view">view</a></li>
							</ul>
						</div>
						<
					</div>

				</div>

			</div>
		</div>
	</section>

</body>
<script>
	function callAdd() {
		var ff = document.getElementById("frm1");
		ff.action = "./testServlet";
		ff.submit();
	}
</script>
<jsp:include page="footer.jsp" />
</html>
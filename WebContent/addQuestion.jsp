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
<title>Add Question</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<section class="content">
		<div class="body_scroll">
			<div class="block-header">
				<div class="row">
					<div class="col-lg-7 col-md-6 col-sm-12">
						<h2>Add Question</h2>
						<ul class="breadcrumb">
							<li class="breadcrumb-item"><a href="home.jsp"><i
									class="zmdi zmdi-home"></i> Home </a></li>
							<li class="breadcrumb-item active" >Question</li>


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

						<small>Manage your Questions here ... </small>

						<%
							String questionAddSucessMessage = (String) request.getAttribute("questionAddSucessMessage");
							String questionAddFailedMessage = (String) request.getAttribute("questionAddFailedMessage");

							if (questionAddSucessMessage != null) {
						%>


						<span style="align-content: center; color: green"><%=questionAddSucessMessage%></span>


						<%
							}
						%>

						<%
							if (questionAddFailedMessage != null) {
						%>

						<span style="align-content: center; color: red"><%=questionAddFailedMessage%></span>

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

								ExamDaoImpl examDaoImpl = new ExamDaoImpl();
								List<Exam> listOfExams = examDaoImpl.viewAllExam();
						%>


						<!-- Horizontal Layout -->
						<div class="row clearfix">
							<div class="col-lg-12 col-md-12 col-sm-12">
								<div class="card">
									<div class="header">
										<h2>
											<strong>Add</strong> New Question
										</h2>

									</div>
									<div class="body">
										<form class="form-horizontal" id="frm1" method="post">
											<input type="hidden" name="operation" value="add">
											<div class="row clearfix">
												<div class="col-lg-2 col-md-2 col-sm-4 form-control-label">
													<label for="email_address_2">Question</label>
												</div>
												<div class="col-lg-10 col-md-10 col-sm-8">
													<div class="form-group">
														<textArea name="question" type="text" class="form-control"
															placeholder="Enter Question" cols="50"></textArea>
													</div>
												</div>
											</div>

<div class="row clearfix">
												<div class="col-lg-2 col-md-2 col-sm-4 form-control-label">
													<label for="email_address_2">Option 1</label>
												</div>
												<div class="col-lg-10 col-md-10 col-sm-8">
													<div class="form-group">
														<input name="option1" type="text" class="form-control"
															placeholder="Enter option">
													</div>
												</div>
											</div>
											
											
<div class="row clearfix">
												<div class="col-lg-2 col-md-2 col-sm-4 form-control-label">
													<label for="email_address_2">Option 2</label>
												</div>
												<div class="col-lg-10 col-md-10 col-sm-8">
													<div class="form-group">
														<input name="option2" type="text" class="form-control"
															placeholder="Enter option">
													</div>
												</div>
											</div>
											
											
<div class="row clearfix">
												<div class="col-lg-2 col-md-2 col-sm-4 form-control-label">
													<label for="email_address_2">Option 3</label>
												</div>
												<div class="col-lg-10 col-md-10 col-sm-8">
													<div class="form-group">
														<input name="option3" type="text" class="form-control"
															placeholder="Enter option">
													</div>
												</div>
											</div>
											
											
<div class="row clearfix">
												<div class="col-lg-2 col-md-2 col-sm-4 form-control-label">
													<label for="email_address_2">Option 4</label>
												</div>
												<div class="col-lg-10 col-md-10 col-sm-8">
													<div class="form-group">
														<input name="option4" type="text" class="form-control"
															placeholder="Enter option">
													</div>
												</div>
											</div>
											
											
<div class="row clearfix">
												<div class="col-lg-2 col-md-2 col-sm-4 form-control-label">
													<label for="email_address_2">Answer</label>
												</div>
												<div class="col-lg-10 col-md-10 col-sm-8">
													<div class="form-group">
														<input name="answer" type="text" class="form-control"
															placeholder="Enter Answer">
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
												<option></option>
												<%
													for (Exam ex : listOfExams) {
														SectionDaoImpl sectionImpl = new SectionDaoImpl();
														List<Section> examSectionList = sectionImpl.viewAllSection(ex.getExamId());
												%>
												<optgroup label="<%=ex.getExamName()%>">
													<%
														for (Section sec : examSectionList) {
													%>
													<option value="<%=ex.getExamId() + "#" + sec.getSectionId()%>"><%=sec.getSectionName()%></option>
													<%
														}
													%>
												</optgroup>

												<%
													}
												%>
											</select>

													</div>
												</div>
											</div>

											<div class="col-sm-8 offset-sm-2">
												<button onclick="callAdd()" type="button"
													class="btn btn-raised btn-primary btn-round waves-effect">Add
													New Question</button>
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
								<li><a href="addQuestion.jsp">Add Section</a></li>
								<li><a href="questionServlet?operation=view">view</a></li>
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
		ff.action = "./questionServlet";
		ff.submit();
	}
</script>
<jsp:include page="footer.jsp" />
</html>
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

							<li class="breadcrumb-item ">Question</li>


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

						<small>Manage your question in question here . </small>
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
								Question questionToEdit = (Question) request.getAttribute("questionToEdit");
						%>


						<!-- Horizontal Layout -->
						<div class="row clearfix">
							<div class="col-lg-12 col-md-12 col-sm-12">
								<div class="card">
									<div class="header">
										<h2>
											<strong>Edit</strong> Question
										</h2>

									</div>
									<div class="body">
										<form class="form-horizontal" id="frm1" method="post">
											<input type="hidden" name="operation" value="edit">

											<div class="row clearfix">
												<div class="col-lg-2 col-md-2 col-sm-4 form-control-label">
													<label for="email_address_2">Question Id</label>
												</div>
												<div class="col-lg-10 col-md-10 col-sm-8">
													<div class="form-group">
														<input name="questionId"
															value="<%=questionToEdit.getQuestionId()%>" type="text"
															class="form-control" placeholder="Section Name">
													</div>
												</div>
											</div>


											<div class="row clearfix">
												<div class="col-lg-2 col-md-2 col-sm-4 form-control-label">
													<label for="email_address_2">Question</label>
												</div>
												<div class="col-lg-10 col-md-10 col-sm-8">
													<div class="form-group">
														<textarea name="question" cols="50" class="form-control"
															placeholder="Section Name"><%=questionToEdit.getQuestion()%></textarea>
													</div>
												</div>
											</div>

											<div class="row clearfix">
												<div class="col-lg-2 col-md-2 col-sm-4 form-control-label">
													<label for="email_address_2">Option 1</label>
												</div>
												<div class="col-lg-10 col-md-10 col-sm-8">
													<div class="form-group">
														<input name="option1"
															value="<%=questionToEdit.getOption1()%>" type="text"
															class="form-control" placeholder="Section Name">
													</div>
												</div>
											</div>


											<div class="row clearfix">
												<div class="col-lg-2 col-md-2 col-sm-4 form-control-label">
													<label for="email_address_2">Option 2</label>
												</div>
												<div class="col-lg-10 col-md-10 col-sm-8">
													<div class="form-group">
														<input name="option2"
															value="<%=questionToEdit.getOption2()%>" type="text"
															class="form-control" placeholder="Section Name">
													</div>
												</div>
											</div>


											<div class="row clearfix">
												<div class="col-lg-2 col-md-2 col-sm-4 form-control-label">
													<label for="email_address_2">Option 3</label>
												</div>
												<div class="col-lg-10 col-md-10 col-sm-8">
													<div class="form-group">
														<input name="option3" type="text"
															value="<%=questionToEdit.getOption3()%>"
															class="form-control" placeholder="Section Name">
													</div>
												</div>
											</div>


											<div class="row clearfix">
												<div class="col-lg-2 col-md-2 col-sm-4 form-control-label">
													<label for="email_address_2">Option 4</label>
												</div>
												<div class="col-lg-10 col-md-10 col-sm-8">
													<div class="form-group">
														<input name="option4" type="text"
															value="<%=questionToEdit.getOption4()%>"
															class="form-control" placeholder="Section Name">
													</div>
												</div>
											</div>


											<div class="row clearfix">
												<div class="col-lg-2 col-md-2 col-sm-4 form-control-label">
													<label for="email_address_2">Answer</label>
												</div>
												<div class="col-lg-10 col-md-10 col-sm-8">
													<div class="form-group">
														<input name="answer" type="text"
															value="<%=questionToEdit.getAnswer()%>"
															class="form-control" placeholder="Section Name">
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
																				if (questionToEdit.getSectionId() == sec.getSectionId()) {
																%>
																<option selected
																	value="<%=ex.getExamId() + "#" + sec.getSectionId()%>"><%=sec.getSectionName()%></option>

																<%
																	} else {
																%>
																<option
																	value="<%=ex.getExamId() + "#" + sec.getSectionId()%>"><%=sec.getSectionName()%></option>

																<%
																	}
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
													class="btn btn-raised btn-primary btn-round waves-effect">Edit
													New Question</button>
											</div>

										</form>
									</div>
								</div>
							</div>
						</div>


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
								<li><a href="addQuestion.jsp">Add Question</a></li>
								<li><a href="questionServlet?operation=view">view</a></li>
							</ul>
						</div>

					</div>

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
<%
	}
%>
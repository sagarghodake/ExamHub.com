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
<title>Examhub | admin | Question</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<section class="content">
		<div class="body_scroll">
			<div class="block-header">
				<div class="row">
					<div class="col-lg-7 col-md-6 col-sm-12">
						<h2>Section</h2>
						<ul class="breadcrumb">
							<li class="breadcrumb-item"><a href="home.jsp"><i
									class="zmdi zmdi-home"></i> Home </a></li>
							<li class="breadcrumb-item active">Question</li>
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
							<small>Manage your Section of Each Exam here . </small> <br>
							<div class="col-sm-8 offset-sm-2">
								<a href="addQuestion.jsp"
									class="btn btn-raised btn-primary btn-round waves-effect">Add
									Question</a> <a href="questionServlet?operation=view"
									class="btn btn-raised btn-primary btn-round waves-effect">View
									All</a>
							</div>

							<%
								String sectionEditSucessMessage = (String) request.getAttribute("sectionEditSucessMessage");
								String sectionEditFailedMessage = (String) request.getAttribute("sectionEditFailedMessage");

								if (sectionEditSucessMessage != null) {
							%>


							<span style="align-content: center; color: green"><%=sectionEditSucessMessage%></span>


							<%
								}
							%>

							<%
								if (sectionEditFailedMessage != null) {
							%>


							<span style="align-content: center; color: red"><%=sectionEditFailedMessage%></span>

							<%
								}
							%>


							<%
								String sectionDeleteSucessMessage = (String) request.getAttribute("sectionDeleteSucessMessage");
								String sectionDeleteFailedMessage = (String) request.getAttribute("sectionDeleteFailedMessage");

								if (sectionDeleteSucessMessage != null) {
							%>


							<span style="align-content: center; color: green"><%=sectionDeleteSucessMessage%></span>


							<%
								}
							%>

							<%
								if (sectionDeleteFailedMessage != null) {
							%>


							<span style="align-content: center; color: red"><%=sectionDeleteFailedMessage%></span>

							<%
								}
							%>




						</div>
					</div>
				</div>
				<div class="col-lg-10 col-md-12">
					<div class="card">
						<div class="body">

							<%
								String admin = (String) session.getAttribute("adminLogin");
								List<Section> listOfAllSection = (List<Section>) request.getAttribute("listOfAllsection");

								if (admin == null) {
									response.sendRedirect("index.jsp");
								}
								ExamDaoImpl examDaoImpl = new ExamDaoImpl();
								List<Exam> listOfExams = examDaoImpl.viewAllExam();
							%>


							<form class="form-horizontal" id="frm1" method="get">

								<div class="row clearfix">
									<div class="col-lg-2 col-md-2 col-sm-4 form-control-label">
										<label for="email_address_2">Select Section Exam</label>
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
													<option
														value="<%=ex.getExamId() + "#" + sec.getSectionId()%>"><%=sec.getSectionName()%></option>
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



								<%
									List<Question> listOfAllQuestion = (List<Question>) request.getAttribute("listOfAllquestion");
									Exam exam = (Exam) request.getAttribute("examIdSelected");

									Section section = (Section) request.getAttribute("sectionIdSelected");
								%>



								<div class="col-sm-8 offset-sm-2">
									<button onclick="callViewByExam()" type="button"
										title="view Questions by Exam"
										class="btn btn-raised btn-primary btn-round waves-effect">View
										By Exam</button>

									<button onclick="callBySection()" type="button"
										title="view Questions Of Exam By Section"
										class="btn btn-raised btn-primary btn-round waves-effect">View
										By Section</button>

									<button onclick="callDelete()" type="button"
										title="Delete All Questions by Exam"
										class="btn btn-raised btn-primary btn-round waves-effect">delete
									</button>
								</div>



							</form>
						</div>
					</div>
				</div>

				<div class="card">
					<div class="body">

						<div class="table-responsive">
							<table
								class="table table-bordered table-striped table-hover dataTable js-exportable">
								<thead>
									<tr>
										<th>Question ID</th>
										<th>Question</th>
										<th>Exam</th>
										<th>Section</th>
										<th data-breakpoints="sm xs">action</th>
									</tr>
								</thead>
								<tbody>

									<%
										if (listOfAllQuestion.size() == 0) {
									%>

									<tr>
										<td colspan="4">
											<%
												if (exam != null && section != null) {
											%> <span style="align-content: center; color: green">No
												Questions not Added yet in <%=section.getSectionName()%>
												Section In <%=exam.getExamName()%></span> <%
 	} else if (exam != null && section == null) {
 %> <span style="align-content: center; color: green">No
												Questions not Added yet in <%=exam.getExamName()%></span> <%
 	}
 %>

										</td>
									</tr>
									<!-- <div class="alert alert-success">
									
								</div>-->


									<%
										} else {
											SectionDaoImpl sectionDaoImpl = new SectionDaoImpl();
											for (Question question : listOfAllQuestion) {
									%>
									<tr>
										<td><span class="text-muted"><%=question.getQuestionId()%></span></td>
										<td><h5><%=question.getQuestion()%></h5></td>

										<%
											Section questionSection = sectionDaoImpl.viewSection(question.getSectionId());

													Exam questionExam = examDaoImpl.viewExam(questionSection.getExamId());
										%>

										<td><h5><%=questionExam.getExamName()%></h5></td>
										<td><h5><%=questionSection.getSectionName()%></h5></td>


										<td><a
											href="questionServlet?operation=edit&questionId=<%=question.getQuestionId()%>"
											class="btn btn-default waves-effect waves-float btn-sm waves-green"><i
												class="zmdi zmdi-edit"></i></a> <a
											onclick="return confirm('Do You Really Want To Delete This?');"
											href="questionServlet?operation=delete&questionId=<%=question.getQuestionId()%>"
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

<script>
	function callBySection() {
		var ff = document.getElementById("frm1");
		var input = document.createElement("input");
		input.setAttribute('type', 'hidden');
		input.setAttribute('name', 'operation');

		input.setAttribute('value', 'viewBySection');
		ff.appendChild(input);
		ff.action = "./questionServlet";
		ff.submit();
	}

	function callAdd1() {
		var ff = document.getElementById("frm1");
		var input = document.createElement("input");
		input.setAttribute('type', 'hidden');
		input.setAttribute('name', 'operation');

		input.setAttribute('value', 'deleteByExam');
		ff.appendChild(input);
		ff.action = "./questionServlet";
		ff.submit();
	}

	function callViewByExam() {
		var ff = document.getElementById("frm1");
		var input = document.createElement("input");
		input.setAttribute('type', 'hidden');
		input.setAttribute('name', 'operation');

		input.setAttribute('value', 'viewByExam');
		ff.appendChild(input);

		ff.action = "./questionServlet";
		ff.submit();
	}
</script>
<jsp:include page="footer.jsp" />
</html>
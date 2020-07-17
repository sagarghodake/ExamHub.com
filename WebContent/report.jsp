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
<title>ExamHub.com | Admin | Exam</title>
</head>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<section class="content">
		<div class="body_scroll">
			<div class="block-header">
				<div class="row">
					<div class="col-lg-7 col-md-6 col-sm-12">
						<h2>Reports :</h2>
						<ul class="breadcrumb">
							<li class="breadcrumb-item"><a href="home.jsp"><i
									class="zmdi zmdi-home"></i> Home </a></li>
							<li class="breadcrumb-item active">Report Generation :</li>
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
		<%
			ExamDaoImpl examDaoImpl = new ExamDaoImpl();
			List<Exam> listOfExams = examDaoImpl.viewAllExam();
		%>

		<div class="container-fluid">
			<div class="row clearfix">
				<div class="col-lg-12">

					<div class="card">
						<div class="body">
							<h4>Reports of <b>ExamHub.com</b></b> Website  ...! </h4> <br>
							<div class="col-sm-8 offset-sm-2">
								<a href="reportServlet?reportName=Category"
									class="btn btn-raised btn-primary btn-round waves-effect"
									target="blank">Category Report</a>&nbsp&nbsp&nbsp&nbsp&nbsp
									 <a	href="reportServlet?reportName=exam"
									class="btn btn-raised btn-primary btn-round waves-effect"
									target="blank">Exam Report</a> &nbsp&nbsp&nbsp&nbsp&nbsp
									 <a href="reportServlet?reportName=student"
									class="btn btn-raised btn-primary btn-round waves-effect"
									target="blank">Student Report</a>
							</div>

						</div>
					</div>

				</div>

				<div class="col-lg-12">
					<div class="card">
						<div class="body">

							<form class="form-horizontal" target="_blank" id="frm1" method="get">
								<input type="hidden" name="reportName" value="Section" />
								<div class="row clearfix">
									<div class="col-lg-2 col-md-4 col-sm-4 form-control-label">
										<label for="email_address_2">Subject </label>
									</div>
									<div class="col-lg-10 col-md-10 col-sm-8">
										<div class="form-group">
											<select class="form-control show-tick ms select2"
												data-placeholder="Select" name="examId">
												<%
													for (Exam ex : listOfExams) {
												%>
												<option value="<%=ex.getExamId()%>"><%=ex.getExamName()%></option>
												<%
													}
												%>
											</select>
										</div>
									</div>
								</div>

								<div class="col-sm-8 offset-sm-2">
									<input onclick="generateSectionReport()" type="submit"
										class="btn btn-raised btn-primary btn-round waves-effect"
										value="View Section Report By Exam"> <a
										href="reportServlet?reportName=Section"
										class="btn btn-raised btn-primary btn-round waves-effect"
										target="blank">All Sections Report</a>
								</div>
							</form>
						</div>
					</div>

				</div>


				<div class="col-lg-12">
					<div class="card">
						<div class="body">

							<form class="form-horizontal" target="_blank" id="frm2" method="get">
								<input type="hidden" name="reportName" value="question" />
								<div class="row clearfix">
									<div class="col-lg-2 col-md-4 col-sm-4 form-control-label">
										<label for="email_address_2">Subject </label>
									</div>
									<div class="col-lg-10 col-md-10 col-sm-8">
										<div class="form-group">
											<select class="form-control show-tick ms select2"
												data-placeholder="Select" name="examId">
												<%
													for (Exam ex : listOfExams) {
												%>
												<option value="<%=ex.getExamId()%>"><%=ex.getExamName()%></option>
												<%
													}
												%>
											</select>
										</div>
									</div>
								</div>

								<div class="col-sm-8 offset-sm-2">
									<a class="btn btn-raised btn-primary btn-round waves-effect"
										 onclick="generateQuestionReport()"
										style="color: white;">View Question Report By Subject</a> <a
										href="reportServlet?reportName=question"
										class="btn btn-raised btn-primary btn-round waves-effect"
										target="blank">All Question Report</a>
								</div>
							</form>
						</div>
					</div>

				</div>


				<!--   TEST -->

				<div class="col-lg-12">
					<div class="card">
						<div class="body">

							<form class="form-horizontal" target="_blank" id="frm3" method="get">
								<input type="hidden" name="reportName" value="test" />
								<div class="row clearfix">
									<div class="col-lg-2 col-md-4 col-sm-4 form-control-label">
										<label for="email_address_2">Subject </label>
									</div>
									<div class="col-lg-10 col-md-10 col-sm-8">
										<div class="form-group">
											<select class="form-control show-tick ms select2"
												data-placeholder="Select" name="examId">
												<option value="aLL">All</option>

												<%
													for (Exam ex : listOfExams) {
												%>
												<option value="<%=ex.getExamId()%>"><%=ex.getExamName()%></option>
												<%
													}
												%>
											</select>

										</div>
									</div>
								</div>



								<div class="row clearfix">
									<div class="col-lg-2 col-md-4 col-sm-4 form-control-label">
										<label for="email_address_2">Type </label>
									</div>
									<div class="col-lg-10 col-md-10 col-sm-8">
										<div class="form-group">

											<select class="form-control show-tick ms select2"
												data-placeholder="Select" name="type">
												<option value="all">All</option>
												<option value="practice">Practice</option>
												<option value="mock">Mock</option>
											</select>


										</div>
									</div>
								</div>

								<div class="col-sm-8 offset-sm-2">
									<a class="btn btn-raised btn-primary btn-round waves-effect"
										target="blank" onclick="generateTestReport()"
										style="color: white;">Test Report By Subject</a> <a
										class="btn btn-raised btn-primary btn-round waves-effect" href="#"
										onclick="generateTestReport()" >All Test Report</a>
										
										 <a
										href="reportServlet?reportName=upcomingTest"
										class="btn btn-raised btn-primary btn-round waves-effect"
										 target="blank">Upcoming Exam Report</a>
								
								</div>
							</form>
						</div>
					</div>

				</div>

				<div class="col-lg-12">

					<div class="card">
						<div class="body">
							<h6>Generate Result Report here ... </h6> <br>
							<div class="col-sm-8 offset-sm-2"> <a
									href="reportServlet?reportName=result"
									class="btn btn-raised btn-primary btn-round waves-effect"
									target="blank">Result Report</a>
							</div>

						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

</body>
<script>
	function generateTestReport() {
		
		var ff2 = document.getElementById("frm3");
		ff2.action = "./reportServlet";
		ff2.submit();

	}
	
function generateQuestionReport(){
	var ff1 = document.getElementById("frm2");
	ff1.action = "./reportServlet";
	ff1.submit();
}

function generateSectionReport(){
	var ff = document.getElementById("frm1");
	ff.action = "./reportServlet";
	ff.submit();
}
	
	
</script>
<jsp:include page="footer.jsp" />
</html>



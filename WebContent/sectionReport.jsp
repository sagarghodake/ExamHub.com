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
<title>ExamHub.com | Admim | Exam Report</title>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<meta name="description"
	content="Responsive Bootstrap 4 and web Application ui kit.">
<!-- Favicon-->
<link rel="stylesheet"
	href="assets/plugins/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/css/style.min.css">
<link rel="stylesheet"
	href="assets/plugins/jquery-datatable/dataTables.bootstrap4.min.css">

</head>

<body>
	<section class="content">
	<center><h1><b>Section Report</b></h1></center>

		<div class="container-fluid">
			<div class="row clearfix">


				<%
					String admin = (String) session.getAttribute("adminLogin");
					List<Section> listOfAllSection = (List<Section>) request.getAttribute("listOfSection");

					if (admin == null) {
						response.sendRedirect("index.jsp");
					}
					ExamDaoImpl examDaoImpl = new ExamDaoImpl();
					List<Exam> listOfExams = examDaoImpl.viewAllExam();
				%>

				<div class="card">
					<div class="body">
						<div class="table-responsive">
							<table
								class="table table-bordered table-striped table-hover dataTable js-exportable">
								<thead>

									<tr>
										<th>Section ID</th>
										<th>Section Name</th>
										<th>Subject (Exam)  Name</th>
									</tr>

								</thead>
								<tbody>

									<%
										if (listOfAllSection.size() == 0) {
									%>

									<tr>
										<td colspan="4"><span
											style="align-content: center; color: green">No Section
												Added yet in Selected Exam / Subject!</span></td>
									</tr>
									<%
										} else {

											for (Section section : listOfAllSection) {
									%>
									<tr>
										<td><span class="text-muted"><%=section.getSectionId()%></span></td>
										<td><h5><%=section.getSectionName()%></h5></td>

										<%
											Exam sectionExam = examDaoImpl.viewExam(section.getExamId());
										%>

										<td><h5><%=sectionExam.getExamName()%></h5></td>



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
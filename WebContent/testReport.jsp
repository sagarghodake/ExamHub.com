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
<title>ExamHub.com | Admim | Test Report</title>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, maximum-scale=10">

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
	<center><h1><b>Test Report</b></h1></center>

		<div class="container-fluid">
			<div class="row clearfix">


				<%
					String admin = (String) session.getAttribute("adminLogin");
					ExamDaoImpl examDaoImpl = new ExamDaoImpl();
					List<Test> listOfAllTest = (List<Test>) request.getAttribute("listOftest");
					DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

					if (admin == null) {
						response.sendRedirect("index.jsp");
					}
				%>

				<div class="card">
					<div class="body">

						<div class="table-responsive">
							<table
								class="table table-bordered table-striped table-hover dataTable js-exportable">
								<thead>
									<tr>
										<th>Test Name</th>
										<th>Subject</th>
										<th>Test Type</th>
										<th>Max Questions</th>
										<th>Max Marks</th>
										<th>Duration</th>
										<th>Test Opens</th>
										<th>Test Closes</th>
									</tr>
								</thead>
								<tbody>
									<%
										if (listOfAllTest.size() == 0) {
									%>
									<tr>
										<td>No Test Created Yet By Admin ! Try another Category</td>
									</tr>
									<%
										} else {
											for (int i = 0; i < listOfAllTest.size(); i++) {
												Test test = listOfAllTest.get(i);
												String openDate = dateFormat.format(test.getOpen());
												String closeDate = dateFormat.format(test.getclose());
									%>
									<tr>
										<td><%=test.getTestName()%></td>
										<td><%=examDaoImpl.viewExam(test.getExamId()).getExamName() %></td>
										<td><%=test.getTestType()%></td>
										<td><%=test.getMaxQuestion()%></td>
										<td><%=test.getMaxMarks()%></td>
										<td><%=test.getDuration()%></td>
										<td><%=openDate%></td>

										<%
											if (closeDate.equalsIgnoreCase("0001-01-01")) {
										%>
										<td><%="No Close Date"%> <%
 	} else {
 %>
										<td><%=closeDate%></td>
										<%
											}
										%>
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
<jsp:include page="footer.jsp" />
</html>
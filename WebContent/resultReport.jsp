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
<title>ExamHub.com | Admim | Result Report</title>

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
	<center><h1><b>Result Report</b></h1></center>

		<div class="container-fluid">
			<div class="row clearfix">


				<%
					String admin = (String) session.getAttribute("adminLogin");
					List<List> resultReportList = (List<List>) request.getAttribute("resultReportList");
					DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

					if (admin == null) {
						response.sendRedirect("home.jsp");
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
										<th>Test Type</th>
										<th>Max Marks</th>
										<th>Test Opens</th>
										<th>Test Closes</th>
										<th>Total Attempt</th>
										<th>Passed Count</th>
										<th>Failed Count</th>
										<th>Certificate Count</th>
									</tr>
								</thead>
								<tbody>
									<%
										if (resultReportList.size() == 0) {
									%>
									<tr>
										<td>No Test Yet Attemptd by any student.</td>
									</tr>
									<%
										} else {
											for (int i = 0; i < resultReportList.size(); i++) {
												List record = resultReportList.get(i);

												String openDate = dateFormat.format(record.get(3));
												String closeDate = dateFormat.format(record.get(4));

												String columnStartTag = "jhjhj";
												String columnCloseTag = "</b></td>";

												Date CD = dateFormat.parse(closeDate);
												if ((!closeDate.equalsIgnoreCase("0001-01-01")) && CD.compareTo(new Date()) < 0) {
													columnStartTag = "<td style='color: red;' ><b>";

												} else if ((!closeDate.equalsIgnoreCase("0001-01-01")) && CD.compareTo(new Date()) > 0) {
													columnStartTag = "<td style='color: green;' ><b>";
												} else {
													columnStartTag = "<td>";

												}
									%>
									<tr>
										<%=columnStartTag + record.get(1) + columnCloseTag%>
										<%=columnStartTag + record.get(2) + columnCloseTag%>
										<%=columnStartTag + record.get(5) + columnCloseTag%>
										<%=columnStartTag + openDate + columnCloseTag%>
										<%
											if (closeDate.equalsIgnoreCase("0001-01-01")) {
										%>
										<%=columnStartTag + "No Close Date" + columnCloseTag%>

										<%
											} else {
										%>

										<%=columnStartTag + closeDate + columnCloseTag%>
										<%
											}
										%>

										<%=columnStartTag + record.get(6) + columnCloseTag%>
										<%=columnStartTag + record.get(7) + columnCloseTag%>
										
										<%=columnStartTag + record.get(8) + columnCloseTag%>
										<%
										%>
										<%=columnStartTag + record.get(9) + columnCloseTag%>


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
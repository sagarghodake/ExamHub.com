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
<title>ExamHub.com | Admin | Result</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<section class="content">
		<div class="body_scroll">
			<div class="block-header">
				<div class="row">
					<div class="col-lg-7 col-md-6 col-sm-12">
						<h2>Result</h2>
						<ul class="breadcrumb">
							<li class="breadcrumb-item"><a href="home.jsp"><i
									class="zmdi zmdi-home"></i> Home </a></li>
							<li class="breadcrumb-item active">Result</li>
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

				<%
					String admin = (String) session.getAttribute("adminLogin");
					List<List> resultReportList = (List<List>) request.getAttribute("resultReportList");

					if (admin == null) {
				%>
				<jsp:forward page="adminLogin.jsp" />
				<%
					}
				%>

				<div class="card">
					<div class="body">
						<div class="table-responsive">
							<table
								class="table table-bordered table-striped table-hover dataTable js-exportable">
								<thead>
									<tr>
									<tr>
										<th>Test Name</th>
										<th>Test Type</th>
										<th>Student</th>
										<th>Marks</th>
										<th>Obtained</th>
										<th>Grade</th>
										<th>Status</th>
										<th>Certificate</th>
									</tr>
								</thead>
								<tbody>

									<%
										if (resultReportList.size() == 0) {
									%><tr>

										<td colspan="4"><span
											style="align-content: center; color: green">No Results
												To Show/View</span> <%
 	} else {

 		for (List record : resultReportList) {
 %>
									<tr>
										<td><%=record.get(0)%></td>
										<td><%=record.get(1)%></td>
										<td><%=record.get(2)%></td>
										<td><%=record.get(3)%></td>
										<td><%=record.get(4)%></td>
										<td><%=record.get(5)%></td>
										<td><%=record.get(6)%></td>
										<%
											if ((((char) record.get(5)) == 'A') && record.get(1).equals("mock")) {
										%>
										<td><a href="resultServlet?operation=certificate&username=<%=record.get(2)%>&testId=<%=record.get(7)%>&per=<%=(((double)record.get(4)/(double)record.get(3))*100)%>">Send Certificate</a></td>
										<%
											} else {
										%>
										<td><strike>Send Certificate</strike></td>
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
		</div>
	</section>

</body>

<jsp:include page="footer.jsp" />
</html>
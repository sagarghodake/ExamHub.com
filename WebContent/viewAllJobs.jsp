<%@page import="java.util.*"%>
<%@page import="com.examhub.pojo.*"%>
<%@page import="com.examhub.impl.*"%>
<%@page import="java.text.*"%>
<%@page autoFlush="true" buffer="20kb"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ExamHub.com | Admin | Jobs</title>
</head>
</head>
<jsp:include page="menu1.jsp" />


<!-- ***** Features Big Item Start ***** -->
<section class="section" id="about">
	<div class="container">
		<div class="row">

			<div class="col-xs-12">
				<div class="left-text-content">
					<div class="section-heading">
						<h6>Home > view jobs :</h6>
					</div>
				</div>
			</div>
			<div class="container">


				<table class="table table-striped" id="dataTable" width="100%"
					cellspacing="0">
					<thead>
						<tr>
							<th>Type</th>
							<th>Title</th>
							<th>Date of Posting</th>
							<th>Apply</th>
						</tr>
					</thead>
					<tfoot>
						<tr>
							<th>Type</th>
							<th>Title</th>
							<th>Date of Posting</th>
							<th>Apply</th>
						</tr>
					</tfoot>
					<tbody>
						<%
							ArrayList<List> listOfJobs = (ArrayList<List>) request.getAttribute("listOfJobs");
						%>

						<%
							if (listOfJobs.size() == 0) {
						%>
						<tr>
							<td>No jobs yet .</td>
						</tr>
						<%
							} else {
								for (List item : listOfJobs) {
						%>
						<tr>
							<td><%=item.get(0)%></td>
							<td><%=item.get(2)%></td>
							<td><%=item.get(3)%></td>
							<td><a href='<%=item.get(1)%>'>Apply</a></td>
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
</section>
<jsp:include page="footer1.jsp" />

<script>
	$(document).ready(function() {
		var table = $('#dataTable').dataTable({
			"bPaginate" : true,
			"lengthMenu" : [ [ 10, 20, 30, 40 ], [ 10, 20, 30, 40 ] ],
			"bLengthChange" : true,
			"bFilter" : true,
			"bInfo" : true,
			"ordering" : true, // Ordering (Sorting on Each Column)will Be Disabled
			"searching" : true, // Search Box will Be Disabled
			"bAutoWidth" : true
		});

	});
</script>
</html>
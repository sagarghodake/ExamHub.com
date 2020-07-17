<%@page import="java.util.*"%>
<%@page import="com.examhub.pojo.*"%>
<%@page import="com.examhub.impl.*"%>
<%@page import="java.text.*" %>
<%@page autoFlush="true" buffer="20kb"%>


<html>
<head>
	<title>Examhub | Upcoming Exam </title>
</head>
<jsp:include page="menu1.jsp" />


<!-- ***** Features Big Item Start ***** -->
<section class="section" id="about">
	<div class="container">
		<div class="row">

			<div class="col-xs-12">
				<div class="left-text-content">
					<div class="section-heading">
						<h6>Home > Test Search Result :</h6>
						<h3>Upcoming Exam Schedule here .</h3>
					</div>
				</div>
			</div>
			<div class="container">


				<table class="table table-striped" id="dataTable" width="100%"
					cellspacing="0">
					<thead>
						<tr>
							<th>Test Name</th>
							<th>Test Type</th>
							<th>Max Questions</th>
							<th>Max Marks</th>
							<th>Duration</th>

							<th>Test Open</th>
							<th>Test Closes</th>
						</tr>
					</thead>
					<tfoot>
						<tr>
							<th>Test Name</th>
							<th>Test Type</th>
							<th>Max Questions</th>
							<th>Max Marks</th>
							<th>Duration</th>

							<th>Test Open</th>
							<th>Test Closes</th>
						</tr>
					</tfoot>
					<tbody>
						<%
							String studentLoginSucessMessage = (String) request.getAttribute("studentLoginSucessMessage");

							List<Test> listOfAllTest = (List<Test>) request.getAttribute("listOfAlltest");
							
							DateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
							

						%>

						<%
							if (listOfAllTest.size() == 0) {
						%>
						<tr>
							<td>No Upcoming Test .</td>
						</tr>
						<%
							} else {
									for (int i = 0; i < listOfAllTest.size(); i++) {

										Test test=listOfAllTest.get(i);
										String openDate=dateFormat.format(test.getOpen());
										String closeDate=dateFormat.format(test.getclose());

						%>
						<tr>
							<td><%=test.getTestName()%></td>
							<td><%=test.getTestType()%></td>
							<td><%=test.getMaxQuestion()%></td>
							<td><%=test.getMaxMarks()%></td>
							<td><%=test.getDuration()%></td>
							<td><%=openDate %></td>
							<% if(closeDate.equalsIgnoreCase("0001-01-01")){ %>
							<td><%="No Close Date" %>
							<%} else{ %>
							<td><%=closeDate %></td>
							<%} %>
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
	var table=	$('#dataTable').dataTable({
			"bPaginate" : true,
			"lengthMenu" : [ [10,20,30,40], [10,20,30,40] ],
			"bLengthChange" : true,
			"bFilter" : true,
			"bInfo" : false,
			"ordering" : false, // Ordering (Sorting on Each Column)will Be Disabled
			"searching" : true, // Search Box will Be Disabled
			"bAutoWidth" : false
		});
	
	 
    	
} );
</script>
</html>

<%@page import="java.util.*"%>
<%@page import="com.examhub.pojo.*"%>
<%@page import="com.examhub.impl.*"%>
<%@page import="java.text.*"%>
<%@page autoFlush="true" buffer="20kb"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Examhub | Test</title>
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
						<h3>Click on <b>Attempt Test</b> to start the Exam .</h3>
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

							<th>Test Closes</th>
							<th>Attempt Test</th>
						</tr>
					</thead>
					<tfoot>
						<tr>
							<th>Test Name</th>
							<th>Test Type</th>
							<th>Max Questions</th>
							<th>Max Marks</th>
							<th>Duration</th>

							<th>Test Closes</th>
							<th>Attempt Test</th>
						</tr>
					</tfoot>
					<tbody>
						<%
							ResultDaoImpl resultDao = new ResultDaoImpl();

							String studentLogin = (String) session.getAttribute("studentLogin");
							String studentLoginSucessMessage = (String) request.getAttribute("studentLoginSucessMessage");

							List<Test> listOfAllTest = (List<Test>) request.getAttribute("listOfAlltest");
							DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

							if (studentLogin != null) {
						%>

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

										String closeDate = dateFormat.format(test.getclose());
						%>
						<tr>
							<td><%=test.getTestName()%></td>
							<td><%=test.getTestType()%></td>
							<td><%=test.getMaxQuestion()%></td>
							<td><%=test.getMaxMarks()%></td>
							<td><%=test.getDuration()%></td>
							<%
								if (closeDate.equalsIgnoreCase("0001-01-01")) {
							%>
							<td><%="No Close Date"%> <%
 	} else {
 %>
							<td><%=closeDate%></td>
							<%
								}

											if (resultDao.isTestAttempted(test.getTestId(), studentLogin)) {
							%>
							<td><a 							target="blank"
							
								href="resultServlet?operation=viewResult&testId=<%=test.getTestId()%>">View Result</a></td>
							<%
								}

											else {
							%>
							<td><a 	onclick="return confirm('Clicked ok test will start.');"
							target="blank"
								href="attemptTestServlet?operation=attemptTest&testId=<%=test.getTestId()%>">Attempt
									Test</a></td>
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
</section>
<jsp:include page="footer1.jsp" />

<script>
	$(document).ready(function() {
		$('#dataTable').DataTable();
	});
	

	
</script>


<%
	} else {
%>

<jsp:forward page="index.jsp" />
<%
	}
%>
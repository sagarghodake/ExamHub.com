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
<title>ExamHub.com | Admim | Question Report</title>

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


	<%
		String admin = (String) session.getAttribute("adminLogin");
		List<Question> listOfAllQuestion = (List<Question>) request.getAttribute("listOfQuestion");

		if (admin == null) {
			response.sendRedirect("index.jsp");
		}
		ExamDaoImpl examDaoImpl = new ExamDaoImpl();
		List<Exam> listOfExams = examDaoImpl.viewAllExam();
	%>


	<div class="table-responsive">
		<table
			class="table table-bordered table-striped table-hover dataTable js-exportable">
			<thead>
				<tr>
					<th>Question ID</th>
					<th>Question</th>
					<th>Exam</th>
					<th>Section</th>
					<th>option 1</th>
					<th>option 2</th>
					<th>option 3</th>
					<th>option 4</th>
					<th>Answer</th>
				</tr>
			</thead>
			<tbody>

				<%
					if (listOfAllQuestion.size() == 0) {
				%>

				<tr>
					<td colspan="4"><span
						style="align-content: center; color: green">No Questions
							not Added yet in Selected Subject</span></td>
				</tr>

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
					<td><h5><%=question.getOption1()%></h5></td>
					<td><h5><%=question.getOption2()%></h5></td>
					<td><h5><%=question.getOption3()%></h5></td>
					<td><h5><%=question.getOption4()%></h5></td>
					<td><h5><%=question.getAnswer()%></h5></td>


				</tr>

				<%
					}
					}
				%>
			</tbody>
		</table>

	</div>

</body>
<jsp:include page="footer.jsp" />
</html>
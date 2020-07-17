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
<title>ExamHub.com | Admin | Exam Report</title>

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

		<div class="container-fluid">
			<div class="row clearfix">


				<%
					String admin = (String) session.getAttribute("adminLogin");
					List<Exam> listOfAllExam = (List<Exam>) request.getAttribute("listOfexam");

					if (admin == null) {
						response.sendRedirect("index.jsp");
					}
				%>

				<div class="card">
					<div class="body">

						<div class="table-responsive">
						<center><h1><b>Exam Report</b></h1></center>
							<table
								class="table table-bordered table-striped table-hover dataTable js-exportable">
								<thead>
									<tr>
										<th>Exam ID</th>
										<th>Exam Name</th>
										<th>Exam Category</th>
									</tr>

								</thead>
								<tbody>

									<%
										if (listOfAllExam.size() == 0) {
									%>

									<tr>
										<td colspan="4"><span
											style="align-content: center; color: green">No Exam
												Added yet in any Category!</span></td>
									</tr>
									<%
										} else {
											CategoryDaoImpl categoryDaoImpl = new CategoryDaoImpl();
											for (Exam exam : listOfAllExam) {
									%>
									<tr>
										<td><span class="text-muted"><%=exam.getExamId()%></span></td>
										<td><h5><%=exam.getExamName()%></h5></td>

										<%
											Category examCategory = categoryDaoImpl.viewCategory(exam.getCategoryId());
										%>

										<td><h5><%=examCategory.getCategoryName()%></h5></td>


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
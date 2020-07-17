<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<%@page import="com.examhub.pojo.*"%>
<%@page autoFlush="true" buffer="20kb"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ExamHub.com | Admim | Category Report</title>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<meta name="description"
	content="Responsive Bootstrap 4 and web Application ui kit.">

<!-- Favicon-->
<link rel="stylesheet" href="assets/plugins/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/css/style.min.css">    
<link rel="stylesheet" href="assets/plugins/jquery-datatable/dataTables.bootstrap4.min.css">

</head>

<body>
	<section class="content">
	<center><h1><b>Category Report</b></h1></center>

		<div class="container-fluid">
			<div class="row clearfix">


				<%
					String admin = (String) session.getAttribute("adminLogin");
					List<Category> listOfAllCategory = (List<Category>) request.getAttribute("listOfCategory");
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
										<th>Category ID</th>
										<th>Category Name</th>
									</tr>
								</thead>
								<tbody>

									<%
										if (listOfAllCategory.size() == 0) {
									%>

									<tr>
										<td colspan="4"><span
											style="align-content: center; color: green">No
												Categories Added yet !</span></td>
									</tr>

									<%
										} else {

											for (Category category : listOfAllCategory) {
									%>
									<tr>
										<td><span class="text-muted"><%=category.getCategoryId()%></span></td>
										<td><h5><%=category.getCategoryName()%></h5></td>
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
<jsp:include page="footer.jsp"/>
</html>
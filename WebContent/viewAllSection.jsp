<%@page import="com.examhub.impl.ExamDaoImpl"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<%@page import="com.examhub.pojo.*"%>
<%@page import="com.examhub.impl.*"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ExamHub.com | Admin | Manage Section</title>

</head>
<body>
	<jsp:include page="menu.jsp" />
	<section class="content">
		<div class="body_scroll">
			<div class="block-header">
				<div class="row">
					<div class="col-lg-7 col-md-6 col-sm-12">
						<h2>Section</h2>
						<ul class="breadcrumb">
							<li class="breadcrumb-item"><a href="home.jsp"><i
									class="zmdi zmdi-home"></i> Home </a></li>
							<li class="breadcrumb-item active">Section</li>
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
				<div class="col-lg-12">

					<div class="card">
						<div class="body">
							<small>Manage your Section of Each Exam here . </small>
							<br>
						
	
								<div class="col-sm-8 offset-sm-2">
									<a href="addSection.jsp" 
										class="btn btn-raised btn-primary btn-round waves-effect">Add Section</a>
										
									<a href="sectionServlet?operation=view"
										class="btn btn-raised btn-primary btn-round waves-effect">View All</a>
								</div>
							
											</div>
					</div>
				</div>
                <div class="col-lg-12">
					<div class="card">
						<div class="body">

							<%
								String admin = (String) session.getAttribute("adminLogin");
								List<Section> listOfAllSection = (List<Section>) request.getAttribute("listOfAllsection");
								Exam exam = (Exam) request.getAttribute("examOfSection");

								if (admin == null) {
									response.sendRedirect("index.jsp");
								}
								ExamDaoImpl examDaoImpl = new ExamDaoImpl();
								List<Exam> listOfExams = examDaoImpl.viewAllExam();
							%>


							<form class="form-horizontal" id="frm1" method="get">

								<div class="row clearfix">
									<div class="col-lg-2 col-md-2 col-sm-4 form-control-label">
										<label for="email_address_2">Select Section Exam</label>
									</div>
									<div class="col-lg-10 col-md-10 col-sm-8">
										<div class="form-group">
											<select class="form-control show-tick ms select2"
												data-placeholder="Select" name="examId">
												<%
													for (Exam cat : listOfExams) {
												%>
												<option value="<%=cat.getExamId()%>"><%=cat.getExamName()%></option>
												<%
													}
												%>
											</select>
										</div>
									</div>
								</div>

								<div class="col-sm-8 offset-sm-2">
									<button onclick="callAdd()" type="button"
										class="btn btn-raised btn-primary btn-round waves-effect">View
										All Section</button>
									<button onclick="callAdd1()" type="button"
										class="btn btn-raised btn-primary btn-round waves-effect">delete
										All Section</button>
								</div>



							</form>
						</div>
						</div>
						<div class="card">
						<div class="body">
		<%
								String sectionEditSucessMessage = (String) request.getAttribute("sectionEditSucessMessage");
								String sectionEditFailedMessage = (String) request.getAttribute("sectionEditFailedMessage");

								if (sectionEditSucessMessage != null) {
							%>


							<span style="align-content: center; color: green"><%=sectionEditSucessMessage%></span>


							<%
								}
							%>

							<%
								if (sectionEditFailedMessage != null) {
							%>


							<span style="align-content: center; color: red"><%=sectionEditFailedMessage%></span>

							<%
								}
							%>


							<%
								String sectionDeleteSucessMessage = (String) request.getAttribute("sectionDeleteSucessMessage");
								String sectionDeleteFailedMessage = (String) request.getAttribute("sectionDeleteFailedMessage");

								if (sectionDeleteSucessMessage != null) {
							%>


							<span style="align-content: center; color: green"><%=sectionDeleteSucessMessage%></span>


							<%
								}
							%>

							<%
								if (sectionDeleteFailedMessage != null) {
							%>


							<span style="align-content: center; color: red"><%=sectionDeleteFailedMessage%></span>

							<%
								}
							%>





							<div class="table-responsive">
								<table
									class="table table-bordered table-striped table-hover dataTable js-exportable">
									<thead>

										<tr>
											<th>Section ID</th>
											<th>Section Name</th>
											<th>Exam Exam</th>
											<th data-breakpoints="sm xs">action</th>
										</tr>

									</thead>
									<tbody>

										<%
											if (listOfAllSection.size() == 0) {
										%>

										<tr>
											<td colspan="4">
												<%
													if (exam != null) {
												%> <span style="align-content: center; color: green">No
													Section Added yet in !<%=exam.getExamName()%></span> <%
 	} else {
 %> <span style="align-content: center; color: green">No Section
													Added yet in any Exam!</span> <%
 	}
 %>

											</td>
										</tr>
										<!-- <div class="alert alert-success">
									
								</div>-->


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


											<td><a
												href="sectionServlet?operation=edit&sectionId=<%=section.getSectionId()%>"
												class="btn btn-default waves-effect waves-float btn-sm waves-green"><i
													class="zmdi zmdi-edit"></i></a> <a
												onclick="return confirm('Do You Really Want To Delete This?');"
												href="sectionServlet?operation=delete&sectionId=<%=section.getSectionId()%>"
												class="btn btn-default waves-effect waves-float btn-sm waves-red"><i
													class="zmdi zmdi-delete"></i></a></td>
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

<script>
	function callAdd1() {
		var ff = document.getElementById("frm1");
		var input = document.createElement("input");
		input.setAttribute('type', 'hidden');
		input.setAttribute('name', 'operation');

		input.setAttribute('value', 'deleteByExam');
		ff.appendChild(input);
		ff.action = "./sectionServlet";
		ff.submit();
	}

	function callAdd() {
		var ff = document.getElementById("frm1");
		var input = document.createElement("input");
		input.setAttribute('type', 'hidden');
		input.setAttribute('name', 'operation');

		input.setAttribute('value', 'view');
		ff.appendChild(input);

		ff.action = "./sectionServlet";
		ff.submit();
	}
</script>
<jsp:include page="footer.jsp" />
</html>
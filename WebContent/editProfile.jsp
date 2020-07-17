<%@page import="java.text.DateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page autoFlush="true" buffer="20kb"%>
<%@page import="com.examhub.pojo.*"%>
<%@page import="java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<title>ExamHub.com | Edit Profile</title>
</head>
<body>
	<jsp:include page="menu1.jsp" />

	<section class="section" id="about">
		<div class="container">
			<div class="row">
				<div class="col-sm-8">
					<div class="card">
						<div class="card-body">
							<center><h2 class="card-title">Edit Profile</h2></center>
							<%
							Student studentToEdit = (Student) request.getAttribute("studentToEdit");
							DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
						
							 %>
							 <%
								String studentEditSucessMessage = (String) request.getAttribute("studentEditSucessMessage");
								String studentEditFailedMessage = (String) request.getAttribute("studentEditFailedMessage");

								if (studentEditSucessMessage != null) {
							%>
							<script type="text/javascript">
								alert("Sucessfully Edited your profile...!!!");
							</script>
							<%
								}
								if (studentEditFailedMessage != null) {
							%>
							<script type="text/javascript">
								alert("Failed To Edit your Profile.Try Again.");
							</script>
							
							<%} %>
							 
							 
							<form method="post" action="studentServlet">
								<input type="hidden" name="operation" value="editProfile" />
								
								<div class="input-group mb-3">
									<input type="text" name="studentName" class="form-control"
										placeholder="Enter name" value="<%=studentToEdit.getName()%>">
								</div>

								<div class="input-group mb-3">
									<input type="text" name="address" class="form-control"
										placeholder="Enter address" value="<%=studentToEdit.getAddress()%>">
								</div>

								<div class="input-group mb-3">
									<select name="gender" class="form-control">
										<%
											if(studentToEdit.getGender().equalsIgnoreCase("Male")){
												
											
										%>
										<option selected="selected">Male</option>
										<option>Female</option>
										<% 
										}
										else{
										%>
										<option>Male</option>
										<option selected="selected">Female</option>
										<%
											}
										%>
									</select>
								</div>


								<div class="input-group mb-3">
									<input type="date" name="dob" class="form-control"
										placeholder="Enter date Of Birth" value="<%=studentToEdit.getDateOfBirth()%>" >
								</div>

								<div class="input-group mb-3">
									<input type="email" name="email" class="form-control"
										placeholder="Enter email" value="<%=studentToEdit.getEmail()%>">
								</div>
								<div class="input-group mb-3">
									<input type="number" name="contact" class="form-control"
										placeholder="Enter contact" value="<%=studentToEdit.getContact()%>">
								</div>


								<input
									class="btn btn-primary btn-block waves-effect waves-light"
									value="Edit Profile" type="submit">

							</form>

						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<jsp:include page="footer1.jsp" />

</body>
</html>
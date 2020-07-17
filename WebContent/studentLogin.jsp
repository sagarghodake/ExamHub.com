<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page autoFlush="true" buffer="20kb"%>

<!DOCTYPE html>
<html>
<head>
<title>ExamHub.com | Login</title>
</head>
<body>
	<jsp:include page="menu1.jsp" />

	<section class="section" id="about">
		<div class="container">
			<div class="row">
				<div class="col-sm-6">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">Student Registration</h5>
							<%
								String studentRegisterSucessMessage = (String) request.getAttribute("studentRegisterSucessMessage");
								String studentRegisterFailedMessage = (String) request.getAttribute("studentRegisterFailedMessage");

								if (studentRegisterSucessMessage != null) {
							%>
							<script type="text/javascript">
								alert("Sucessfully Registered.Continue to Login.");
							</script>
							<%
								}
								if (studentRegisterFailedMessage != null) {
							%>
							<script type="text/javascript">
								alert("Failed Registered.Try Again.");
							</script>
							
							<%} %>
							<form method="post" action="studentServlet">
								<input type="hidden" name="operation" value="add" />
								<div class="input-group mb-3">
									<input type="text" name="username" class="form-control"
										placeholder="Enter Username" pattern="^[A-Za-z]{5,20}$" title="Username length must be atleat 5 max 10 & Only alphabets">
								</div>
								<div class="input-group mb-3">
									<input type="password" name="password" class="form-control"
										placeholder="Enter Password" pattern="[A-Za-z0-9]{5,15}$" title="Passwords must contain atleast 5  max 15 characters, including Uppercase, Lowercase letters and Numbers mandatory.">
								</div>
								<div class="input-group mb-3">
									<input type="text" name="studentName" class="form-control"
										placeholder="Enter name">
								</div>

								<div class="input-group mb-3">
									<input type="text" name="address" class="form-control"
										placeholder="Enter address">
								</div>

								<div class="input-group mb-3">
									<select name="gender" class="form-control">
										<option>Male</option>
										<option>Female</option>
									</select>
								</div>


								<div class="input-group mb-3">
									<input type="date" name="dob" class="form-control"
										placeholder="Enter date Of Birth">
								</div>

								<div class="input-group mb-3">
									<input type="email" name="email" class="form-control"
										placeholder="Enter email">
								</div>
								<div class="input-group mb-3">
									<input type="number" name="contact" class="form-control"
										placeholder="Enter contact">
								</div>


								<input
									class="btn btn-primary btn-block waves-effect waves-light"
									value="Sign up" type="submit">

							</form>

						</div>
					</div>
				</div>
				<div class="col-sm-6">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">Student Login</h5>
							<form method="post" action="studentLogin?operation=login">
								<div class="input-group mb-3">
									<input type="text" name="username" class="form-control"
										placeholder="Enter Username">
								</div>
								<div class="input-group mb-3">
									<input type="password" name="password" class="form-control"
										placeholder="Enter Password">
								</div>

								<input
									class="btn btn-primary btn-block waves-effect waves-light"
									value="Sign in" type="submit">

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
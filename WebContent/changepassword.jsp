<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page autoFlush="true" buffer="20kb"%>

<!DOCTYPE html>
<html>
<head>
<title>ExamHub.com | Change Password</title>
</head>
<body>
	<jsp:include page="menu1.jsp" />

	<section class="section" id="about">
		<div class="container">
			<div class="row">

				<div class="col-sm-6">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">Change Password</h5>
							<%
								String studentChangeSucessMessage = (String) request.getAttribute("studentChangeSucessMessage");
								String studentChangeFailedMessage = (String) request.getAttribute("studentChangeFailedMessage");

								if (studentChangeSucessMessage != null) {
							%>
							<script type="text/javascript">
								alert("Sucessfully Changed Password. Continue to Re-Login...!!!");
							</script>
							<%
								}
								if (studentChangeFailedMessage != null) {
							%>
							<script type="text/javascript">
								alert("Change Password Failed.Try Again...!!!");
							</script>
							
							<%} %>
							<form method="post" action="studentServlet?operation=changePassword">
								<div class="input-group mb-3">
									<input type="password" name="oldPassword" class="form-control"
										placeholder="Enter old password">
								</div>
								<div class="input-group mb-3">
									<input type="password" name="newPassword" class="form-control"
										placeholder="Enter New Password">
								</div>

								<input
									class="btn btn-primary btn-block waves-effect waves-light"
									value="Change Password" type="submit">

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
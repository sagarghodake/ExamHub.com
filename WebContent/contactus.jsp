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

<div class="mapouter"><div class="gmap_canvas"><iframe width="380" height="500" id="gmap_canvas" src="https://maps.google.com/maps?q=Address%3A%20Ground%20Floor%2C%20Madhav%20Hari%20Apartment%2C%20near%20Sheetal%20Hotel%2C%20Kothrud%2C%20Pune%2C%20Maharashtra%20411038&t=&z=13&ie=UTF8&iwloc=&output=embed" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"></iframe><a href="https://www.embedgooglemap.net/en/">embed google map html</a></div><style>.mapouter{position:relative;text-align:right;height:500px;width:380px;}.gmap_canvas {overflow:hidden;background:none!important;height:500px;width:380px;}</style></div>							</div>

						
					</div>
				</div>
				<img src="assets/images/image-gallery/contact11.jpg" alt=""  style="height:550px">
			
			<br><br>
			<div class="col-sm-6"><br><br><br><br>
					<div class="card">
						<div class="card-body">
							<h2 class="card-title">Contact Us</h2>
							
							<form method="post" action="contactServlet?operation=sendmessage">
							
								<div class="input-group mb-3">
									<input type="text" name="fullname" class="form-control"
										placeholder="Enter full name">
								</div>
								<div class="input-group mb-3">
									<input type="text" name="mailId" class="form-control"
										placeholder="Enter Mail id">
								</div>

								<div class="input-group mb-3">
									<textarea name="message" class="form-control"
										> </textarea>
								</div>

								<input
									class="btn btn-primary btn-block waves-effect waves-light"
									value="Send Mail ExamHub.com" type="submit" >
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
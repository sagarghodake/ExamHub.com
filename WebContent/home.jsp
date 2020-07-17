<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@page autoFlush="true" buffer="20kb"%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ExamHub.com | Admin | Home</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<section class="content">
		<div class="body_scroll">
			<div class="block-header">
				<div class="row">
					<div class="col-lg-7 col-md-6 col-sm-12">
						<h1>Welcome back, Admin...!</h1>

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


						<%
							String admin = (String) session.getAttribute("adminLogin");
							String adminLoginSucessMessage = (String) request.getAttribute("adminLoginSucessMessage");
							System.out.println(admin+" "+adminLoginSucessMessage);
							if (admin == null) {
								response.sendRedirect("index.jsp");
							}

							if (adminLoginSucessMessage != null) {
						%>

						
							<span style="align-content:center; color: green"><%=adminLoginSucessMessage%></span>
						<%
							}
						%>
						
						
						
						
						<center>
		<div class="item">
			<div class="img-fill">
				<div class="text-content">
					<h2><b>ExamHub.com</b> <br>Best Online Examination Website</h2>
					<h6><b>Be ready. Be smart. Be noticed...!</b></b></h6>
					<a href="#" class="main-stroked-button">"Stay positive, work hard, make it happen."</a> 
					
				</div>
			</div>
		</div>
		</center>

						<div class="header">
							<h2>
								<small>From here you can manage your <a href="studentHome.jsp"><b>ExamHub.com</b></a> website.</small>
							</h2>
						</div>
						<div class="body">
						</div>
					</div>
				</div>

			</div>

		</div>
			<center><img src="assets/images/image-gallery/slide_1.jpg" alt="" height="600" width="1000"></center>
	</section>

</body>
<jsp:include page="footer.jsp" />
</html>
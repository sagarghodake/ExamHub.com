<%@page autoFlush="true" buffer="20kb"%>

<html>
<head>
<title>Examhub.com | Home</title>
</head>
<jsp:include page="menu1.jsp" />

<%
	String studentLoginSucessMessage = (String) request.getAttribute("studentLoginSucessMessage");
	String studentLogin = (String) session.getAttribute("studentLogin");

	if (studentLogin == null) {
%>

<!-- ***** Main Banner Area Start ***** -->
<div class="main-banner header-text" id="top">
	<div class="Modern-Slider">
		<!-- Item -->
		<div class="item">
			<div class="img-fill">
				<img src="assets1/images/slide-01.jpg" alt="">
				<div class="text-content">
					<h3>Welcome To ExamHub.com</h3>
					<h5>Don't Stress. Do your Best. Forget the Rest.</h5>
					<a href="#" class="main-stroked-button">Don't miss the chance</a> 
					<a href="#" class="main-filled-button">Assess Yourself</a>
				</div>
			</div>
		</div>
		<!-- // Item -->
		<!-- Item -->
		<div class="item">
			<div class="img-fill">
				<img src="assets1/images/slide-02.jpg" alt="">
				<div class="text-content">
					<h3>ExamHub.com Best Online Examining Website</h3>
					<h5>Be ready. Be smart. Be noticed...!</h5>
					<a href="#" class="main-stroked-button">Unlock Your Knowledge</a> 
					<a href="#"	class="main-filled-button">Assess Yourself</a>
				</div>
			</div>
		</div>
		<!-- // Item -->
		<!-- Item -->
		<div class="item">
			<div class="img-fill">
				<img src="assets1/images/slide-03.jpg" alt="">
				<div class="text-content">
					<h3>We came,We quizzed,We conquered.</h3>
					<h5>Robust and Speedy</h5>
					<a href="#" class="main-stroked-button">We quiz therefore we are.</a> <a href="#"
						class="main-filled-button">Assess Yourself</a>
				</div>
			</div>
		</div>
		<!-- // Item -->
	</div>
</div>
<%
	}
%>
<!-- ***** Main Banner Area End ***** -->

<section class="section" id="about">
	<div class="container">
		<%
			if (studentLoginSucessMessage != null) {
		%>
		<script type="text/javascript">
								alert("Sucessfully Logged In.");
							</script>
		<%
			}
		%>				
		
 
		<div class="row">
			<div class="col-sm-6">
				<h2 style="text-align: center; color: red;">About ExamHub.com</h2>

				<p style="text-align: justify;">ExamHub.com is first dedicated
					Online examination platform which is conducting a test online to
					measure the knowledge of the participants on a given topic. In the
					olden days everybody had to gather in a classroom at the same time
					to take an exam. With online examination students can do the exam
					online, in their own time and with their own device, regardless
					where they life. You online need a browser and internet connection.
					ExamHub.com is cost effective, scalable way to convert traditional
					pen and paper based exams to online and paperless mode. Candidates 
					can appear for the exam using any desktop, laptop or mobile device
					with browser. Exam results can be generated instantly for objective type of questions.
					It can simplify overall examination management and result generation activity.
				</p>

			</div>

			<div class="col-sm-6">
				<div class="embed-responsive embed-responsive-16by9">
					<iframe class="embed-responsive-item"
					src="https://www.youtube.com/embed/ht_4SEibYYQ" allowfullscreen></iframe>
				</div>

			</div><br><br>
			 <img src="assets/images/image-gallery/slide_1.jpg" alt=""  width="1140" height="600">
		</div>
	</div>
</section>
<jsp:include page="footer1.jsp" />
</html>

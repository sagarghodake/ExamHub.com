<%@page import="java.util.*"%>
<%@page import="com.examhub.pojo.*"%>
<%@page import="com.examhub.impl.*"%>
<%@page autoFlush="true" buffer="20kb"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ExamHub.com | Test</title>
</head>
<body onload="f1()">
	<jsp:include page="menu1.jsp" />


	<%
		OnlineTest onlineTestObject = (OnlineTest) request.getAttribute("onlineTestObject");
		String studentLogin = (String) session.getAttribute("studentLogin");
	%>

	<!-- ***** Features Big Item Start ***** -->
	<section class="section" id="about">
		<div class="container">
			<div class="row">

				<div class="col-lg-6 col-md-6 col-xs-12">
					<div class="left-text-content">
						<div class="section-heading">
							<h6>Home > Test Search Result :</h6>
							Time Left : <span id="mins"></span> : <span id="secs">.</span> <span
								id="end"></span>
						</div>
					</div>
				</div>
				<div class="container">
					<form action="#" method="post" id="frm" >
						<input type="hidden" name="operation" value="submitTest">
						<input type="hidden" name="testId"
							value="<%=onlineTestObject.getTestId()%>"> <input
							type="hidden" name="testType"
							value="<%=onlineTestObject.getType()%>"> <input
							type="hidden" name="testMaxQuestions"
							value="<%=onlineTestObject.getMaxQuestion()%>"> <input
							type="hidden" name="testMaxMarks"
							value="<%=onlineTestObject.getMaxMarks()%>"> <input
							type="hidden" name="examId"
							value="<%=onlineTestObject.getExamId()%>">


						<table class="table table-striped" id="dataTable" style="width: 80%">
							<thead>
								<tr>
									<th><%=onlineTestObject.getTestName()+" : "+onlineTestObject.getType() %>:</th>
								</tr>
							</thead>

							<tbody>

								<%
									if (studentLogin != null) {

										for (int i = 0; i < onlineTestObject.getQuestionSet().size(); i++) {

											Question q = onlineTestObject.getQuestionSet().get(i);
											List<String> options = new ArrayList<>();
											options.add(q.getOption1());
											options.add(q.getOption2());
											options.add(q.getOption3());
											options.add(q.getOption4());
											Collections.shuffle(options);
								%>
								<tr>
									<td>
									<input type="hidden" name="question<%=i%>"
										value="<%=q.getQuestionId()%>">
								
										<p>
											<b>Q <%=(i+1) %> : <%=q.getQuestion().replace("\n", "<br>").replace(" ", "&nbsp;")%></b>
										</p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<input name="option<%=i%>" type="radio"
												value="<%=options.get(0)%>"><%=options.get(0)%></p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<input name="option<%=i%>" type="radio"
												value="<%=options.get(1)%>"><%=options.get(1)%></p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<input name="option<%=i%>" type="radio"
												value="<%=options.get(2)%>"><%=options.get(2)%></p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<input name="option<%=i%>" type="radio"
												value="<%=options.get(3)%>"><%=options.get(3)%></p>
									</td>
								</tr>


								<%
									}
								%>

								<tr>

									<td><input type="button" id="button" onclick="ok()" value="Submit Test"></td>


								</tr>


							</tbody>
						</table>
					</form>

				</div>
			</div>
		</div>
	</section>




	<jsp:include page="footer1.jsp" />

	<script>

	$(document).ready(function() {
		var table=	$('#dataTable').dataTable({
				"bPaginate" : true,
				"lengthMenu" : [ [5], [5] ],
				"bLengthChange" : false,
				"bFilter" : true,
				"bInfo" : false,
				"ordering" : false, // Ordering (Sorting on Each Column)will Be Disabled
				"searching" : false, // Search Box will Be Disabled
				"bAutoWidth" : false
			});
		
		 
	    	
	} );

	function ok(){
        var ff = document.getElementById("frm");

		var table=	$('#dataTable').dataTable({
				"bPaginate" : true,
				"lengthMenu" : [ [6], [6] ],
				"bLengthChange" : false,
				"bFilter" : true,
				"bInfo" : false,
				"ordering" : false, // Ordering (Sorting on Each Column)will Be Disabled
				"searching" : false, // Search Box will Be Disabled
				"bAutoWidth" : false
			});
	        var data = table.$('input').serializeArray();
	        $.each(data, function(i, field){
	        	var input = document.createElement("input");
				input.setAttribute('type', 'hidden');
				input.setAttribute('name', field.name);

				input.setAttribute('value', field.value);
				ff.appendChild(input);
	          });
	        
		
			ff.action = "./attemptTestServlet";
			ff.submit();

	        
        return false;
	}

		// The data/time we want to countdown to
		var countDownDate = new Date().getTime()
				+ (60000 *
	<%=onlineTestObject.getDuration()%>
		);

		// Run myfunc every second
		var myfunc = setInterval(function() {

			var now = new Date().getTime();
			var timeleft = countDownDate - now;

			// Calculating the days, hours, minutes and seconds left
			var minutes = Math.floor((timeleft % (1000 * 60 * 60))
					/ (1000 * 60));
			var seconds = Math.floor((timeleft % (1000 * 60)) / 1000);

			// Result is output to the specific element
			document.getElementById("mins").innerHTML = minutes + "m "
			document.getElementById("secs").innerHTML = seconds + "s "

			// Display the message when countdown is over
			if (timeleft < 0) {
				clearInterval(myfunc);
				document.getElementById("mins").innerHTML = ""
				document.getElementById("secs").innerHTML = ""
				alert("Time's up . Your test will automatically get Submitted.")
				ok();
				}
		}, 1000);
	</script>


</body>
<%
	} else {
%>

<jsp:forward page="index.jsp" />
<%
	}
%>
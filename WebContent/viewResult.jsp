<%@page import="com.examhub.impl.ExamDaoImpl"%>
<%@page import="com.examhub.impl.TestDaoImpl"%>
<%@page import="com.examhub.pojo.*"%>
<%@page import="com.examhub.pojo.Result"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@page autoFlush="true" buffer="20kb"%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ExamHub | Result </title>
</head>
<body>
	<%
		String studentLogin = (String) session.getAttribute("studentLogin");
		Result resultToView = (Result) request.getAttribute("resultToView");
		Test test=new TestDaoImpl().viewTest(resultToView.getTestId()); 
		Exam exam=new ExamDaoImpl().viewExam(test.getExamId());
		int percentageObtained=((resultToView.getObtained()*100)/resultToView.getMaxMarks());
		String result=(percentageObtained>=60?" Passed ":"Failed ");

		double rank=(Double)request.getAttribute("rank");
		int classA=(Integer)request.getAttribute("classA");
		int classB=(Integer)request.getAttribute("classB");
		int classC=(Integer)request.getAttribute("classC");
		int classD=(Integer)request.getAttribute("classD");

		double totalStudentAppearTest=(Double)request.getAttribute("totalStudentAppearTest");
		char grade=(char)request.getAttribute("grade");
		double percentile=(Double)request.getAttribute("percentile");
		
		double attempted=resultToView.getAttempted();
		double correct=resultToView.getCorrect();
	
		
		System.out.println(percentile);
		System.out.println(correct);
		System.out.println(attempted);
		System.out.println(((correct/attempted)));
	
		System.out.println(100-((correct/attempted)*100));
		
		System.out.println(((correct/attempted)*100));
		System.out.println(" ");
		
		if (studentLogin != null) {
	%>
	<jsp:include page="menu1.jsp" />

	<section class="section" id="about">
		<div class="container">
			<div class="row">
				<div class="col-sm-12">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">Summary Of Previous Attempt:</h5>

							<table class="table table-striped" id="dataTable" width="100%"
								cellspacing="0">
								<thead>
									<tr>
										<th>Test Name</th>
										<th>Test Type</th>
										<th>Subject</th>
										<th>Grade </th>
									</tr>
								</thead>
								
								<tbody>
									<tr>
																		
										<td><%=test.getTestName() %></td>
										<td><%=test.getTestType() %></td>
										<td><%=exam.getExamName() %></td>
										<td><%=result %></td>
									</tr>
								</tbody>
							</table>


						</div>
					</div>
				</div>
			</div>


			<div class="row">
				<div class="col-sm-12">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">Result Analysis &n Report:</h5>

							<table class="table table-striped" id="dataTable" width="100%"
								cellspacing="0">
								<thead>
									<tr>
										<th>Total Attempt</th>
										<th>Total Marks</th>
										<th>Marks Obtained</th>
										<th>Rank</th>
										<th>Grade Obtained</th>
									</tr>
								</thead>
								
								<tbody>
									<tr>
																		
										<td><%=totalStudentAppearTest %></td>
										<td><%=resultToView.getMaxMarks() %></td>
										<td><%=resultToView.getObtained() %></td>
										<td><%=rank %></td>
										<td><%=grade %></td>
										
									</tr>
								</tbody>
							</table>


						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-sm-6">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">Percentile :</h5>
						
						    <div id="percentile" style="width: 400px; height: 300px;"></div>
						
							
						</div>
					</div>
				</div>
			
			<div class="col-sm-6">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">Accuracy :</h5>
						
						    <div id="accuracy" style="width: 400px; height: 300px;"></div>
						
							
						</div>
					</div>
				</div>
			
			</div>
			
			<div class="row">
				<div class="col-sm-4">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">Attempted :</h5>
						
						    <div id="attempted" style="width: 250px; height: 300px;"></div>
						
							
						</div>
					</div>
				</div>
			
			<div class="col-sm-8">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">Result Analysis :</h5>
						
						    <div id="donutchart" style="width: 550px; height: 300px;"></div>
						
							
						</div>
					</div>
				</div>
			
			</div>
		</div>
	</section>
	<jsp:include page="footer1.jsp" />
	<%
		}

		else {
	%>
	<jsp:forward page="studentLogin.jsp" />
	<%
		}
	%>
	
<script>

	
	$(document).ready(function() {
		var table=	$('#dataTable').dataTable({
				"bPaginate" : false,
				"lengthMenu" : [ [1], [1] ],
				"bLengthChange" : false,
				"bFilter" : true,
				"bInfo" : false,
				"ordering" : false, // Ordering (Sorting on Each Column)will Be Disabled
				"searching" : false, // Search Box will Be Disabled
				"bAutoWidth" : false
			});
		
		 
	    	
	} );

</script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['grade', 'number of Participants'],
          ['less than 40%',    <%=classA%>],
          ['less than 60%',    <%=classB%>],
          ['less than 75%',    <%=classC%>],
          ['75% or geater',    <%=classD%>]
        ]);

        var options = {
          title: 'Overall number of students achieving grade ranges',
          pieHole: 0.4,
          is3D: true,
        };

        var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
        chart.draw(data, options);
      }
      
      google.charts.setOnLoadCallback(percentile);
      function percentile() {
        var data = google.visualization.arrayToDataTable([
          ['percentile', 'percentile'],
          ['percentile',    <%=percentile%>],
          ['',    <%=100-percentile%>]
        ]);

        var options = {
          title: 'Percentile',
          pieHole: 0.6,
          slices: {
              0: { color: '#ff4dab' },
              1: { color: 'transparent' }
            },
          legend: 'none'
        };

        var chart = new google.visualization.PieChart(document.getElementById('percentile'));
        chart.draw(data, options);
      }

      

      
      google.charts.setOnLoadCallback(accuracy);
      function accuracy() {
        var data = google.visualization.arrayToDataTable([
          ['accuracy', 'accuracy'],
          ['accuracy',    <%=(correct/attempted)*100%>],
          ['',    <%=100-((correct/attempted)*100)%>]
        ]);

        var options = {
          title: 'Accuracy',
          pieHole: 0.6,
          slices: {
              0: { color: '#03A9F4' },
              1: { color: 'transparent' }
            },
          legend: 'none'
        };

        var chart = new google.visualization.PieChart(document.getElementById('accuracy'));
        chart.draw(data, options);
      }

      
      
      google.charts.setOnLoadCallback(attempted);
      function attempted() {
        var data = google.visualization.arrayToDataTable([
          ['attempted', 'attempted'],
          ['attempted',    <%=attempted%>],
          ['',    <%=resultToView.getMaxQuestions()-attempted%>]
        ]);

        var options = {
          title: 'Attempted',
          pieHole: 0.6,
          slices: {
              0: { color: '#04BE5B' },
              1: { color: 'transparent' }
            },
        
          legend: 'none'
        };

        var chart = new google.visualization.PieChart(document.getElementById('attempted'));
        chart.draw(data, options);
      }

      
      
    </script>
 
</body>
</html>
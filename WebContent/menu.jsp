 <!doctype html>
<html class="no-js " lang="en">


<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<meta name="description"
	content="Responsive Bootstrap 4 and web Application ui kit.">

<title>:: ExamHub.com Admin :: Examination</title>
<!-- Favicon-->
<link rel="stylesheet"
	href="assets/plugins/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/css/style.min.css">
<link rel="stylesheet"
	href="assets/plugins/jquery-datatable/dataTables.bootstrap4.min.css">

</head>

<body class="theme-blush">

	<!-- Page Loader -->

	<!-- Overlay For Sidebars -->
	<div class="overlay"></div>

	<!-- Main Search -->
	<div id="search">
		<button id="close" type="button"
			class="close btn btn-primary btn-icon btn-icon-mini btn-round">x</button>
		<form>
			<input type="search" value="" placeholder="Search..." />
			<button type="submit" class="btn btn-primary">Search</button>
		</form>
	</div>
	

	
	

	<!-- Right Icon menu Sidebar -->
	<div class="navbar-right">
		<ul class="navbar-nav">
			<li><a href="report.jsp" class="app_calendar" title="Reports"><i
					class="zmdi zmdi-chart"></i></a></li>
			
			<li><a href="#" class="mega-menu" title="File Manager"><i
					class="zmdi zmdi-folder"></i></a></li>
					
			<li><a href="#" class="mega-menu" title="Cart"><i
					class="zmdi zmdi-shopping-cart"></i></a></li>
			
			
			<li><a href="#" class="mega-menu" title="Authentication"><i
					class="zmdi zmdi-lock"></i></a></li>								
					
			<li><a href="auth?logout" class="mega-menu" title="Sign Out"><i
					class="zmdi zmdi-power"></i></a></li>
					
		</ul>
	</div>

	<!-- Left Sidebar -->
	<aside id="leftsidebar" class="sidebar">
		<div class="navbar-brand">
			<button class="btn-menu ls-toggle-btn" type="button">
				<i class="zmdi zmdi-menu"></i>
			</button>
			<a href="home.jsp"><img src="assets/images/logo.svg" width="25"
				alt="Aero"><span class="m-l-10"><b>ExamHub.com</b></span></a>
		</div>
		<div class="menu">
			<ul class="list">
				<li>
					<div class="user-info">
						<a class="image" href="profile.html"><img
							src="assets/images/image-gallery/sagar2.jpg" alt="User"></a>
						<div class="detail">
							<h6>Sagar Ghodake</h6>
							<small>Website Admin</small>
						</div>
					</div>
				</li>
				<li><a href="home.jsp"><i class="zmdi zmdi-home"></i><span>Dashboard</span></a></li>
				<li><a href="categoryServlet?operation=viewAllCategories"
					class="menu-toggle"><i class="zmdi zmdi-assignment"></i><span>Exam Category</span></a></li>

				<li><a href="examServlet?operation=view" class="menu-toggle"><i
						class="zmdi zmdi-assignment"></i><span>Exam SubCategory</span></a></li>

				<li><a href="sectionServlet?operation=view" class="menu-toggle"><i
						class="zmdi zmdi-map"></i><span>Manage Section</span></a></li>

				<li><a href="questionServlet?operation=view"
					class="menu-toggle"><i class="zmdi zmdi-swap-alt"></i><span>Manage Question</span></a></li>
					

				<li><a href="testServlet?operation=view" class="menu-toggle"><i
						class="zmdi zmdi-copy"></i><span>Manage Test</span></a></li>
				<li><a href="resultServlet?operation=viewAllResult"
					class="menu-toggle"><i class="zmdi zmdi-time"></i><span>Results</span></a></li>
					
				<li><a href="report.jsp"
					class="menu-toggle"><i class="zmdi zmdi-chart"></i><span>Report</span></a></li>		
			</ul>
		</div>

	</aside>
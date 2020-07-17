<%@page autoFlush="true" buffer="20kb"%>

<!doctype html>
<html class="no-js " lang="en">


<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<meta name="description" content="Responsive Bootstrap 4 and web Application ui kit.">

<title>ExamHub.com | Admin | Sign In</title>
<!-- Favicon-->
<link rel="icon" href="favicon.ico" type="image/x-icon">
<!-- Custom Css -->
<link rel="stylesheet" href="assets/plugins/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/css/style.min.css">    
</head>

<body class="theme-blush">

							
	<%
		String adminLogoutSucessMessage = (String) request.getAttribute("adminLogoutSucessMessage");
		String adminLoginFailedMessage = (String) request.getAttribute("adminLoginFailedMessage");
		
	%>
<div class="authentication">
    <div class="container">
        <div class="row">
            <div class="col-lg-4 col-sm-12">
                <form class="card auth_form" method="post" action="auth?login">
                    <div class="header">
                        <img class="logo" src="assets/images/logo.svg" alt="">
                        <h5>Log in</h5>
                        <%
                        if (adminLogoutSucessMessage != null) {
                        %>
                        <span style="color: green"><%=adminLogoutSucessMessage %></span>
                        <%} %>
                        
                        <%
                        if (adminLoginFailedMessage != null) {
                        %>
                        <span style="color: red"><%=adminLoginFailedMessage %></span>
                        <%} %>
                        
                    </div>
                    <div class="body">
                        <div class="input-group mb-3">
                            <input type="text" name="username" class="form-control" placeholder="Username">
                            <div class="input-group-append">
                                <span class="input-group-text"><i class="zmdi zmdi-account-circle"></i></span>
                            </div>
                        </div>
                        <div class="input-group mb-3">
                            <input type="password" name="password" class="form-control" placeholder="Password">
                            <div class="input-group-append">                                
                                <span class="input-group-text"><a href="forgot-password.html" class="forgot" title="Forgot Password"><i class="zmdi zmdi-lock"></i></a></span>
                            </div>                            
                        </div>
                        
              <input class="btn btn-primary btn-block waves-effect waves-light" value="Sign in" type="submit" >                        
                        
                    </div>
                </form>
                <div class="copyright text-center">
                    &copy;
                    <script>document.write(new Date().getFullYear())</script>,
                    <span><a href="index.jsp">Examhub.com</a></span>
                </div>
            </div>
            <div class="col-lg-8 col-sm-12">
                <div class="card">
                    <img src="assets/images/signup.svg" alt="Sign In"/>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
	function callServlet(){
		$.post('login');
		
	}
</script>
<!-- Jquery Core Js -->
<script src="assets/bundles/libscripts.bundle.js"></script>
<script src="assets/bundles/vendorscripts.bundle.js"></script> <!-- Lib Scripts Plugin Js -->
</body>

</html>
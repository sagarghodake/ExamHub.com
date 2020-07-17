<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<%@page import="com.examhub.pojo.*"%>
<%@page autoFlush="true" buffer="20kb"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ExamHub.com | Admin Panel | Category | Edit Category Page</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<section class="content">
		<div class="body_scroll">
			<div class="block-header">
				<div class="row">
					<div class="col-lg-7 col-md-6 col-sm-12">
						<h2>Category</h2>
						<ul class="breadcrumb">
							<li class="breadcrumb-item"><a href="home.jsp"><i
									class="zmdi zmdi-home"></i> Home </a></li>
							<li class="breadcrumb-item active">Exam Category</li>
						</ul>
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

						<small>Manage your Exam Categories here . Categories i.e
							Domains (e.g., <code>.Banking,Development,Testing</code>)
						</small>

<%
							Category categoryToEdit =(Category)request.getAttribute("categoryToEdit");
							
						%>

					</div>
				</div>
				<div class="col-lg-8 col-md-12">
					<div class="card">


						<%
							String admin = (String) session.getAttribute("adminLogin");
							if (admin == null) {
								response.sendRedirect("index.jsp");
							} else {
						%>

						
            <!-- Horizontal Layout -->
            <div class="row clearfix">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="card">
                        <div class="header">
                            <h2><strong>Edit</strong> Category</h2>
                           
                        </div>
                        <div class="body">
                            <form class="form-horizontal" id="frm1" method="post">
                            <input type="hidden" name="operation" value="edit">
                            
                            <div class="row clearfix">
                                    <div class="col-lg-2 col-md-2 col-sm-4 form-control-label">
                                        <label for="email_address_2">Category Id</label>
                                    </div>
                                    <div class="col-lg-10 col-md-10 col-sm-8">
                                        <div class="form-group">
                                            <input name="categoryId" readonly value="<%=categoryToEdit.getCategoryId() %>" type="text"  class="form-control" placeholder="Enter New Category Name">
                                        </div>
                                    </div>
                                </div>
                             
                            
                                <div class="row clearfix">
                                    <div class="col-lg-2 col-md-2 col-sm-4 form-control-label">
                                        <label for="email_address_2">Category Name</label>
                                    </div>
                                    <div class="col-lg-10 col-md-10 col-sm-8">
                                        <div class="form-group">
                                            <input name="categoryName" value="<%=categoryToEdit.getCategoryName() %>" type="text"  class="form-control" placeholder="Enter updated Category Name">
                                        </div>
                                    </div>
                                </div>
                             
                             
                                    <div class="col-sm-8 offset-sm-2">
                                        <button onclick="callAdd()" type="button" class="btn btn-raised btn-primary btn-round waves-effect">Edit Category</button>
                                    </div>
                                
                            </form>
                        </div>
                    </div>
                </div>
            </div>

						<%
							}
						%>
					</div>
				</div>

				<div class="col-lg-4 col-md-12">
					<div class="card">
						<div class="header">
							<h2>
								<strong>Opeartions</strong>
							</h2>
						</div>
						<div class="body">
							<ul class="list-unstyled mb-0 widget-categories">
								<li><a href="addCategory.jsp">Add Category</a></li>
								<li><a href="categoryServlet?operation=viewAllCategories">view</a></li>
							</ul>
						</div>
						<
					</div>

				</div>

			</div>
	</section>

</body>
<script>
function callAdd(){
 var ff=document.getElementById("frm1");        
                    ff.action="./categoryServlet";
                    ff.submit(); 
}
</script>
<jsp:include page="footer.jsp" />
</html>
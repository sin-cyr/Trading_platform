<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page isELIgnored="FALSE"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin - Companies</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!--Link to .css files-->
<link rel="stylesheet" href="resources/css/admin.css">
<c:if test="${empty loggedUser}">
	<%--c:redirect url="${pageContext.servletContext.contextPath}" /--%>
	<c:redirect url="" />

</c:if>

<style>
.cd-top.cd-is-visible {
	/* the button becomes visible */
	visibility: visible;
	opacity: 1;
}

.cd-top.cd-fade-out {
	/* if the user keeps scrolling down, the button is out of focus and becomes less visible */
	opacity: .5;
}
</style>
<link rel="stylesheet" id="font-awesome-css" 
href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" 
type="text/css" media="screen">
</head>
<body>
	<div class="container-fluid">
		<nav class="navbar navbar-default navbar-fixed-top">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#myNavbar"></button>

			<a class="navbar-brand"> <img
				src="resources/css/images/NewLogoAdmin.png"
				style="height: 45px; margin-left: -14px; margin-top: -14px;"
				alt="Image">
			</a>
			<ul class="nav navbar-nav navbar-left">
				<li><a
					href="${pageContext.servletContext.contextPath}/listcurrent">To
						Main</a></li>
				<li><a
					href="${pageContext.servletContext.contextPath}/adminTrade">Admin
						Trade </a></li>
				<li class="active"><a
					href="${pageContext.servletContext.contextPath}/adminCompany">Admin
						Company</a></li>
				<li><a
					href="${pageContext.servletContext.contextPath}/adminUser">Admin
						User</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a class="glyphicon glyphicon-user"
					class="dropdown-toggle" data-toggle="dropdown"
					href="${pageContext.servletContext.contextPath}/credit">${loggedUser.username}
						<span class="caret"></span> &nbsp;
				</a>
					<ul class="dropdown-menu">
						<li><a
							href="${pageContext.servletContext.contextPath}/profile">Profile</a></li>
						<li><a
							href="${pageContext.servletContext.contextPath}/credit">Credit</a></li>
						<li><a
							href="${pageContext.servletContext.contextPath}/Logout">Logout</a></li>
					</ul>
			</ul>
		</nav>
	</div>

	<div class="container">
		<p>
		<h1>
			Admin: Companies
			<button class="btn btn-primary" data-toggle="modal"
				data-target="#addCompany">Add Company</button>
		</h1>
		</p>

		<table class="table table-striped">
			<thead>
				<tr>
					<!--  -->


					<div class="modal fade" id="addCompany" role="dialog">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
								</div>
								<div class="modal-body">
									<form action="addCompany" method="Post">
										<div class="form-group">
											<label for="quant"><span
												class="glyphicon glyphicon-user"></span> Company Name</label> <input
												type="text" class="form-control" name="compName" required>
										</div>
										<div class="form-group">
											<label for="Pps"><span
												class="glyphicon glyphicon-user"></span> Industry</label> <input
												type="text" class="form-control" name="compIndustry"
												required>
										</div>
										<div class="form-group">
											<label for="total"><span
												class="glyphicon glyphicon-user"></span> Bio</label> <input
												type="text" class="form-control" name="compBio"
												maxlength="500" required>
										</div>
										<div class="form-group">
											<label for="total"><span
												class="glyphicon glyphicon-user"></span> No. of Shares</label> <input
												type="number" min=0 class="form-control"
												name="compShareAmount" required>
										</div>
										<div class="form-group">
											<label for="total"><span
												class="glyphicon glyphicon-user"></span> Share Price</label> <input
												type="number" min=0 class="form-control"
												name="compSharePrice" required>
										</div>
										<button type="submit" class="btn btn-primary" name="addbutton">Add Company</button>
									</form>
								</div>
							</div>
						</div>
					</div>









					<form action="queryCompanyName" method="POST">
						<!--  -->
						<form>
							<div class="input-group">
								<input type="text" class="form-control" name="query"
									placeholder="Search by Company Name">
								<div class="input-group-btn">
									<button class="btn btn-default" name="comp" type="submit">
										<i class="glyphicon glyphicon-search"></i>
									</button>
								</div>
							</div>
						</form>
						<h4 style="color: red">${error}</h4>
					</form>
					<hr>
				</tr>
				<tr>
					<th>Company name</th>
					<th>Industry</th>
					<th>No. of Shares</th>
				</tr>
			</thead>


			<tbody>
				<c:forEach var="company" items="${companies}">
					<tr>
						<td>${company.name}</td>
						<td>${company.industry}</td>
						<td>${fn:length(company.shares)}</td>
					</tr>

				</c:forEach>

			</tbody>
		</table>
<a href="#" class="back-to-top" style="display: inline;">
<i class="fa fa-arrow-circle-up"></i>
</a>								
					
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script>
 
jQuery(document).ready(function() {
	$('.back-to-top').css({"display": "none"});
 
var offset = 250;
 
var duration = 300;
 
jQuery(window).scroll(function() {
 
if (jQuery(this).scrollTop() > offset) {
 
jQuery('.back-to-top').fadeIn(duration);
 
} else {
 
jQuery('.back-to-top').fadeOut(duration);
 
}
 
});
 
 
 
jQuery('.back-to-top').click(function(event) {
 
event.preventDefault();
 
jQuery('html, body').animate({scrollTop: 0}, duration);
 
return false;
 
})
 
});
</script>
</body>
<footer class="text-center">
</footer>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
				<li><a
					href="${pageContext.servletContext.contextPath}/adminCompany">Admin
						Company</a></li>
				<li class="active"><a
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
		
		<h1 align="center">Admin: Users</h1>
		
		<div class="container-three">
			<form class="" action="sortUsers" method="Post">
				<div class="form-group">
					<div class="col-xs-4 selectContainer">
						<select class="form-control" name="options">
							<option value="usernameAZ">Username: A-Z</option>
							<option value="usernameZA">Username: Z-A</option>
							<option value="credLowest">Credit: Lowest to Highest</option>
							<option value="credHighest">Credit: Highest to Lowest</option>

						</select> <select class="form-control" name="filter">
							<option value="All">Users: Show All</option>
							<option value="Admin">Users: Admin</option>
							<option value="Banned">Users: Banned</option>
						</select>

					</div>
				</div>
				<button class="btn btn-default" name="sort" type="submit">Sort</button>
			</form>
		</div>

		<div class="form-group">
			<form action="adminGoToUser">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>Username</th>
							<th>Admin</th>
							<th>Banned</th>
							<th>Credits</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach var="user" items="${users}">
							<tr>
								<td>${user.username}</td>
								<td><c:choose>
										<c:when test="${user.adminBoolean  == '1'}">
											<h6>Admin</h6>
										</c:when>
										<c:when test="${user.adminBoolean  == '0'}">
										&nbsp;
									</c:when>
									</c:choose></td>
								<td><c:choose>
										<c:when test="${user.banned  == '1'}">
											<h6>Banned</h6>
										</c:when>
										<c:when test="${user.banned  == '0'}">
										&nbsp;
									</c:when>
									</c:choose></td>
								<td>${user.credit}</td>
								<td><button type="submit" class="btn btn-primary"
										name="edituserbutton" value="${user.username}">Go</button></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</form>
		</div>
	</div>
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
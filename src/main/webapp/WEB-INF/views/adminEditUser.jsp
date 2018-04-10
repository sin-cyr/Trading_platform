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

		<h3 align="center">${user.username}</h3>
		<table class="table">
			<tr>
				<td>Admin Status:</td>
				<td><c:choose>
						<c:when test="${user.adminBoolean == '1'}">Admin</c:when>
						<c:when test="${user.adminBoolean == '0'}">User</c:when>
					</c:choose></td>
				<td><c:if test="${user.adminBoolean == '1'}">
						<form action="changeAdminStatus">
							<button class="btn btn-danger" name="adminStatusButton"
								type="submit" value="${user.username}">Revoke
								Privileges</button>
						</form>
					</c:if> <c:if test="${(user.adminBoolean == '0') && (user.banned == '0')}">

						<form action="changeAdminStatus">
							<button class="btn btn-primary" name="adminStatusButton"
								type="submit" value="${user.username}">Promote</button>
						</form>

					</c:if> <c:if test="${(user.adminBoolean == '0') && (user.banned == '1')}">
						<form action="changeAdminStatus">
							<button class="btn btn-primary" name="adminStatusButton"
								type="submit" value="${user.username}" disabled>Promote</button>
						</form>
					</c:if>
			<tr>
				<td>Banned Status:</td>
				<td><c:choose>
						<c:when test="${user.banned == '1'}">Banned</c:when>
						<c:when test="${user.banned == '0'}">Active</c:when>
					</c:choose></td>
				<td><c:choose>
						<c:when
							test="${(user.adminBoolean == '1') && (user.banned == '1')}">
							<form action="changeBanStatus">
								<button class="btn btn-warning" name="banButton" type="submit"
									value="${user.username}" disabled>Unban</button>
							</form>
						</c:when>
						<c:when test="${(user.adminBoolean == '1')}">
							<form action="changeBanStatus">
								<button class="btn btn-danger" name="banButton" type="submit"
									value="${user.username}" disabled>Ban</button>
							</form>
						</c:when>
						<c:when
							test="${(user.adminBoolean == '0') && (user.banned == '0')}">
							<form action="changeBanStatus">
								<button class="btn btn-danger" name="banButton" type="submit"
									value="${user.username}">Ban</button>
							</form>
						</c:when>
						<c:when test="${user.banned == '1'}">
							<form action="changeBanStatus">
								<button class="btn btn-warning" name="banButton" type="submit"
									value="${user.username}">Unban</button>
							</form>
						</c:when>

					</c:choose>
				<td>
			</tr>
			<tr>
				<td>Email:</td>
				<td>${user.email}</td>
				<td></td>
			</tr>
			<tr>
				<td>Credits:</td>
				<td>${user.credit}</td>
				<td></td>
			</tr>
		</table>
	</div>
</body>
<footer class="text-center">

	<br> <br>
	<p>
		<a href="#" data-toggle="tooltip" title="Visit w3schools">JHAPPY.com
			CopyRight &#9400; 2017</a>
	</p>
</footer>
</html>
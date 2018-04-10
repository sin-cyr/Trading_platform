<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page isELIgnored="FALSE"%>
<!DOCTYPE html>
<html>
<head>
<title>JHAPPY Trading platform</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!--Link to .css files-->
<c:if test="${loggedUser.adminBoolean == '0'}">
	<link rel="stylesheet" href="resources/css/homepage.css">
</c:if>
<c:if test="${loggedUser.adminBoolean == '1'}">
	<link rel="stylesheet" href="resources/css/admin.css">
</c:if>

<c:if test="${empty loggedUser}">
	<%--c:redirect url="${pageContext.servletContext.contextPath}" /--%>
	<c:redirect url="" />

</c:if>
<link rel="stylesheet" id="font-awesome-css" 
href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" 
type="text/css" media="screen">
</head>
<body>
	<div class="container-fluid">
		<nav class="navbar navbar-default navbar-fixed-top">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#myNavbar"></button>

			<c:if test="${loggedUser.adminBoolean == '0'}">
				<a class="navbar-brand"> <img
					src="resources/css/images/NewLogo.png"
					style="height: 45px; margin-left: -14px; margin-top: -14px;"
					alt="Image">
				</a>
			</c:if>
			<c:if test="${loggedUser.adminBoolean == '1'}">
				<a class="navbar-brand"> <img
					src="resources/css/images/NewLogoAdmin.png"
					style="height: 45px; margin-left: -14px; margin-top: -14px;"
					alt="Image">
				</a>
			</c:if>
			<ul class="nav navbar-nav navbar-left">
				<li><a
					href="${pageContext.servletContext.contextPath}/listcurrent">Current
						Trades</a></li>
				<li><a
					href="${pageContext.servletContext.contextPath}/listowned">Owned
						Shares</a></li>
				<li><a
					href="${pageContext.servletContext.contextPath}/listtracked">Tracked
						Shares</a></li>
				<li><a
					href="${pageContext.servletContext.contextPath}/listhistory">Trading
						History</a></li>
				<li class="active"><a
					href="${pageContext.servletContext.contextPath}/listcompanies">Companies</a></li>

				<li><a href="${pageContext.servletContext.contextPath}/trade">Trade</a></li>


				<c:if test="${loggedUser.adminBoolean == '1'}">

					<!--  -->

					<li class="dropdown"><a class="dropdown-toggle"
						data-toggle="dropdown" href="#">Admin <span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a
								href="${pageContext.servletContext.contextPath}/adminUser">User</a></li>
							<li><a
								href="${pageContext.servletContext.contextPath}/adminTrade">Trades</a></li>
							<li><a
								href="${pageContext.servletContext.contextPath}/adminCompany">Companies</a></li>

						</ul></li>
					<!--  -->

				</c:if>
			</ul>

			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a class="glyphicon glyphicon-user dropdown-toggle" data-toggle="dropdown"
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
					</li>
			</ul>
		</nav>
	</div>

	<div class="container">
		<p>
		<h1>Company Listing</h1>
		</p>

		<div class="container-two">
			<!--  -->
			<c:set var="total" value="${0}" />
			<c:forEach var="ownedShare" items="${loggedUser.ownedShares}">
				<c:set var="total"
					value="${total + ownedShare.pricePerShare*ownedShare.quantity}" />
			</c:forEach>
			<form class="form-inline">
				<div class="form-group">
					<label for="profitloss">Profit/Loss:</label>
					<c:choose>
						<c:when test="${profitLoss gt 0}">
							<input type="text" class="form-control" id="profitloss"
								value="${profitLoss}" readonly style="color: green">
						</c:when>
						<c:otherwise>
							<input type="text" class="form-control" id="profitloss"
								value="${profitLoss}" readonly style="color: red">
						</c:otherwise>
					</c:choose>
				</div>
				<div class="form-group">
					<label for="funds">Available Funds:</label> <input type="text"
						class="form-control" id="funds" value="${loggedUser.credit}"
						placeholder="2090" readonly>
				</div>
				<div class="form-group">
					<label for="investment">Total Investment:</label> <input
						type="text" class="form-control" id="investment" value="${total}"
						placeholder="11500" readonly>
				</div>
			</form>

			<!--  -->
		</div>
		<hr>
		<table class="table table-striped">
			<thead>
				<tr>
					<!--  -->

					<form action="querycompany" method="POST">
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
					<th>No. of Shares</th>
					<th>Options</th>
					<th></th>
					<th></th>
					<th></th>
				</tr>
			</thead>


			<tbody>
				<c:forEach var="company" items="${companies}">
					<tr>
						<td>${company.name}</td>
						<td>${fn:length(company.shares)}</td>
						<td><c:choose>
								<c:when test="${fn:length(company.shares) =='0'}">
						No Stock History
					</c:when>
								<c:otherwise>
									<form action="company" method="Post">
										<button class="btn btn-info" type="submit" name="cinfo"
											value="${company.name}">View Company</button>
									</form>
								</c:otherwise>
							</c:choose></td>
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
<footer>

</footer>
</html>
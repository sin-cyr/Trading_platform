<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="FALSE"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<link rel="stylesheet" href="resources/css/login.css">
<c:if test="${empty loggedUser}">
	<%--c:redirect url="${pageContext.servletContext.contextPath}" /--%>
	<c:redirect url="" />

</c:if>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	// Load the Visualization API and the corechart package.
	google.charts.load('current', {
		packages : [ 'corechart', 'line' ]
	});

	// Set a callback to run when the Google Visualization API is loaded.
	google.charts.setOnLoadCallback(drawChart);

	// Callback that creates and populates a data table,
	// instantiates the pie chart, passes in the data and
	// draws it.
	function drawChart() {

		var dates = [];
		var prices = [];

		<c:forEach items="${priceHistory}" var="sp" varStatus="status">
		var price = '${sp.price}';
		var time = '${sp.timestamp}';
		prices.push(price);
		dates.push(time);
		</c:forEach>

		var listLen = time.length;
		var dataArray = [ [ 'Dates', 'Share Price' ] ];
		for (i = 0; i < listLen; i++) {
			dataArray.push([ dates[i], parseFloat(prices[i]) ]);
		}
		var data = google.visualization.arrayToDataTable(dataArray);

		var options = {
			hAxis : {
				title : 'Time',
				baselineColor : '#fff',
				gridlineColor : '#fff',
				textPosition : 'none'

			},
			vAxis : {
				title : 'Share Prices',
				format : 'decimal'
			},
			title : '${chosenCompany.name} Stock Prices',
			width : 1000,
			height : 500

		};

		var chart = new google.visualization.LineChart(document
				.getElementById('curve_chart'));

		chart.draw(data, options);
	}
</script>
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
		</c:if> <c:if test="${loggedUser.adminBoolean == '1'}">
			<a class="navbar-brand"> <img
				src="resources/css/images/NewLogoAdmin.png"
				style="height: 45px; margin-left: -14px; margin-top: -14px;"
				alt="Image">
			</a>
		</c:if>
		<ul class="nav navbar-nav navbar-left">
			<li class="active"><a
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
			<li><a
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
					<li><a href="${pageContext.servletContext.contextPath}/credit">Credit</a></li>
					<li><a href="${pageContext.servletContext.contextPath}/Logout">Logout</a></li>
				</ul>
				</li>
		</ul>
		</nav>


		<div class="container">
			<h1>${chosenCompany.name}</h1>
			<div id="bio">
				<h4>Bio</h4>
				<h5>${chosenCompany.bio}</h5>
				<h4>Industry</h4>
				<h5>${chosenCompany.industry}</h5>
			</div>
			<hr id="curve_chart" style="width: 800; height: 800">

		</div>
</body>
</html>
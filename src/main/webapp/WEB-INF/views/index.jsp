
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="FALSE"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>JHappy Trading platform</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!--Link to .css files-->
<link rel="stylesheet" href="resources/css/homepage.css">
<link rel="stylesheet" href="resources/css/login.css">
<script>
function startTime() {
    var today = new Date();
    var h = today.getHours();
    var m = today.getMinutes();
    var s = today.getSeconds();
    m = checkTime(m);
    s = checkTime(s);
    document.getElementById('txt').innerHTML =
    h + ":" + m + ":" + s;
    var t = setTimeout(startTime, 500);
}
function checkTime(i) {
    if (i < 10) {i = "0" + i};  // add zero in front of numbers < 10
    return i;
}
</script>
</head>
<body onload="startTime()">

	<!-- Navigation button -->
	<div class="container-fluid">
		<nav class="navbar navbar-default navbar-fixed-top">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#myNavbar"></button>

			<a class="navbar-brand" onload="startTime()">
			<table>
				<tr>
				<td> <img
				src="resources/css/images/NewLogo.png"
				style="height: 45px; margin-left: -14px; margin-top: -14px;"
				alt="Image"></td><td id="txt"><h4></h4>
				</td>
				</tr>
			</table>
			</a>

			<c:if test="${empty loggedUser}">

				<ul class="nav navbar-nav navbar-right">
					<li><a href="#register" data-toggle="modal"
						data-target="#myModal">REGISTER</a></li>
					<li><a href="#login" data-toggle="modal"
						data-target="#myModal2">LOGIN  &nbsp; &nbsp; </a></li>
				</ul>

			</c:if>
			<c:if test="${not empty loggedUser}">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="listcurrent" >TRADING</a></li>
					<li><a href="${pageContext.servletContext.contextPath}/Logout" >LOGOUT &nbsp; &nbsp;</a></li>
				</ul>

			</c:if>

		</nav>
	</div>


	<!-- Register Modal -->
	<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4>
						<span class="glyphicon glyphicon-lock"></span> REGISTER
					</h4>
				</div>
				<div class="modal-body">
					<form name='form-login' action="Register" method="post">
						<div class="form-group">
							<label for="psw"><span class="glyphicon glyphicon-user"></span>
								Username</label> <input type="text" class="form-control" name="username"
								placeholder="username" maxlength="50" required>
						</div>
						<div class="form-group">
							<label for="psw"><span class="glyphicon glyphicon-user"></span>
								Email</label> <input type="email" class="form-control"
								placeholder="name@domain.com" maxlength="50" name="email">
						</div>
						<div class="form-group">
							<label for="usrname"><span
								class="glyphicon glyphicon-user"></span> Password</label> <input
								type="password" class="form-control" name="password"
								placeholder="password" maxlength="50" required>
						</div>
						<div class="form-group">
							<label for="psw"><span class="glyphicon glyphicon-user"></span>
								Confirm password</label> <input type="password" class="form-control"
								name="password2" placeholder="pasword" maxlength="50" required>
						</div>
						<button type="submit" class="btn btn-block">
							Submit <span class="glyphicon glyphicon-ok"></span>
						</button>
					</form>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-danger btn-default pull-left"
						data-dismiss="modal">
						<span class="glyphicon glyphicon-remove"></span> Cancel
					</button>
					<p>
						Existing user? <a data-dismiss="modal" data-toggle="modal"
						href="#login" data-target="#myModal2">login</a>
					</p>
				</div>
			</div>
		</div>
	</div>

	<!-- Login Modal -->
	<div class="modal fade" id="myModal2" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4>
						<span class="glyphicon glyphicon-lock"></span> LOGIN
					</h4>
				</div>
				<div class="modal-body">
					<form name='form-login' action="Login" method="post">
						<div class="form-group">
							<label for="psw"><span class="glyphicon glyphicon-user"></span>
								Username or Email</label> <input type="text" class="form-control"
								placeholder="name@domain.com" maxlength="50" name="email">
						</div>
						<div class="form-group">
							<label for="usrname"><span
								class="glyphicon glyphicon-user"></span> Password</label> <input
								type="password" class="form-control" name="password"
								placeholder="password" maxlength="50" required>
						</div>
						<button type="submit" class="btn btn-block">
							Submit <span class="glyphicon glyphicon-ok"></span>
						</button>
					</form>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-danger btn-default pull-left"
						data-dismiss="modal">
						<span class="glyphicon glyphicon-remove"></span> Cancel
					</button>
					<p>
						New user? <a data-dismiss="modal" data-toggle="modal"
						href="#register" data-target="#myModal">register</a>
					</p>
				</div>
			</div>
		</div>
	</div>


<div id="myCarousel" class="carousel slide" data-ride="carousel">
		<!-- Indicators -->
		<ol class="carousel-indicators">
			<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
			<li data-target="#myCarousel" data-slide-to="1"></li>
			<li data-target="#myCarousel" data-slide-to="2"></li>
		</ol>

		<!-- Wrapper for slides -->
		<div class="carousel-inner" role="listbox">
			<div class="item active">
				<img
					src="http://www.stocktradingmyths.com/wp-content/uploads/2016/02/stock-market-3.jpg"
					style="height: 800px" alt="slide 1">
				<div class="carousel-caption">
					<h3>BUY STOCKS</h3>
					<p>Buy shares with JHappy</p>
				</div>
			</div>

			<div class="item">
				<img
					src="https://i1.wp.com/moneynation.com/wp-content/uploads/2015/11/shutterstock_80453707.jpg"
					style="height: 800px" alt="slide 2">
				<div class="carousel-caption">
					<h3>SELL STOCKS</h3>
					<p>Sell shares with JHappy</p>
				</div>
			</div>

			<div class="item">
				<img
					src="resources/css/images/slide 3.jpg"
					style="height: 800px" alt="slide 3">
				<div class="carousel-caption">
					<h3>TRACK STOCKS</h3>
					<p>Track your shares with JHappy</p>
				</div>
			</div>
		</div>

		<!-- Left and right controls -->
		<a class="left carousel-control" href="#myCarousel" role="button"
			data-slide="prev"> <span class="glyphicon glyphicon-chevron-left"
			aria-hidden="true"></span> <span class="sr-only">Previous</span>
		</a> <a class="right carousel-control" href="#myCarousel" role="button"
			data-slide="next"> <span
			class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
			<span class="sr-only">Next</span>
		</a>
	</div>

	


</body>
</html>
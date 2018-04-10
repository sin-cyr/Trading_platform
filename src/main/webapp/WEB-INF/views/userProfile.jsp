<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="FALSE"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>JHAPPY Trading platform</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript"
	src="https://www.simplify.com/commerce/v1/simplify.js"></script>
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

<script>
	function myFunction() {
		var x = document.getElementById("myFile").value;
		document.getElementById("pathname").innerHTML = x;
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
							<li><a
								href="${pageContext.servletContext.contextPath}/trade">Trade</a></li>

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
						</ul></li>
					<!--  -->

				</c:if>
			</ul>
			<ul class="nav navbar-nav navbar-right">


				<li class="dropdown"><a
					class="glyphicon glyphicon-user dropdown-toggle"
					data-toggle="dropdown"
					href="${pageContext.servletContext.contextPath}/credit">${loggedUser.username}
						<span class="caret"></span> &nbsp;
				</a>
					<ul class="dropdown-menu">
						<li class="active"><a
							href="${pageContext.servletContext.contextPath}/profile">Profile</a></li>
						<li><a
							href="${pageContext.servletContext.contextPath}/credit">Credit</a></li>
						<li><a
							href="${pageContext.servletContext.contextPath}/Logout">Logout</a></li>
					</ul></li>
			</ul>
		</nav>
	</div>

	<div class="container">



		<div class="col-sm-12">
			<div class="container-two" align="center">
				<h2>${username}</h2>
				<hr>
				<div class="row">
					<div class="col-sm-4">

						<img src="data:image/jpg;base64,${profileimage}"
							class="img-circle" width="150" height="150">
					</div>
					
					
					<div class="col-sm-8" align="left">

						<form action="imageupload" method="Post"
							enctype="multipart/form-data">
							<label class="col-sm-4">Select file to upload:</label>
							<div class="form-group">
								<div class="col-sm-5">
									<input class="form-control" type="file" name="filename"
										id="myFile" size="50" required>
									
								</div>
								<button class="btn btn-primary" type="submit">Submit</button>
							</div>
						</form>
					</div>
				</div>
				<hr>
			</div>



			<form class="form-horizontal" method="POST" action="updatepassword">
				<div class="form-group">
					<label class="control-label col-sm-2" for="balance">Balance:</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="balance"
							value="${usercredit}" placeholder="Balance" readonly>
					</div>
				</div>
				<div class="form-group" action="">
					<label class="control-label col-sm-2" for="email">Email:</label>
					<div class="col-sm-8">
						<input type="email" class="form-control" id="email"
							value="${useremail}" placeholder="Enter email" readonly>
					</div>
				</div>
				<div class="form-group" action="">
					<label class="control-label col-sm-2" for="username">UserName:</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="username"
							value="${username}" placeholder="Enter username" readonly>
					</div>
				</div>

				<div class="form-group">
					<label class="control-label col-sm-2" for="pwd">Old
						Password:</label>
					<div class="col-sm-8">

						<input type="password" class="form-control" name="pwd"
							placeholder="Enter old password">

					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-2" for="pwd1">New
						Password:</label>
					<div class="col-sm-8">

						<input type="password" class="form-control" name="pwd1"
							placeholder="Enter new password" maxlength="32" required>

					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-2" for="pwd2">Confirm
						Password:</label>
					<div class="col-sm-8">

						<input type="password" class="form-control" name="pwd2"
							placeholder="Confirm new password" maxlength="32" required>

					</div>
				</div>

				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-2">
						<button type="submit" class="btn btn-primary">Submit
							Changes</button>
					</div>
					<div class="col-sm-offset-0 col-sm-6">
						<div class="col-sm-8">
							<table>
								<tbody></tbody>
								<tr>
									<td>
										<p style='color:${color}'>${errormsg1}</p>
									</td>
								</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
</body>
</html>
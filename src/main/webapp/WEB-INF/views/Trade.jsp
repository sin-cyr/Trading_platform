<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

<script>
	function sum(number) {
		var quantity = document.getElementById('quantity' + number).value;
		var pricepershare = document.getElementById('pricepershare' + number).value;
		var result = parseInt(quantity) * parseInt(pricepershare);
		if (!isNaN(result)) {
			document.getElementById('totalcost' + number).value = result;
		}
	}

	function sumsell(number) {
		var quantity = document.getElementById('quantitysell' + number).value;
		var pricepershare = document.getElementById('pricepersharesell'
				+ number).value;
		var result = parseInt(quantity) * parseInt(pricepershare);
		if (!isNaN(result)) {
			document.getElementById('totalcostsell' + number).value = result;
		}
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
				<li class="active"><a
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
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a
					class="glyphicon glyphicon-user dropdown-toggle"
					data-toggle="dropdown"
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
		<h1>Trading</h1>
		<hr>

		<table class="table table-striped">
			<thead>
				<tr>
					<th>Company Name</th>
					<th>Buy Price</th>
					<th>Sell Price</th>
					<th>Time Posted</th>
					<th>Amount Buying</th>
					<th>Amount Selling</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="element" items="${mytrade}">
					<tr>
						<td>${element.share.company.name}</td>
						<td>${element.buyPrice}</td>
						<td>${element.sellPrice}</td>
						<td>${element.timePosted}</td>
						<td>${element.amountBuying}</td>
						<td>${element.amountSelling}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="container-two">

			<h2>Create Trade</h2>
			<hr>
			<form class="form-horizontal" action="whatAvailableTrades">
				<div class="form-group">
					<h4>
						<label class="control-label" for="selectashare">Step 1:
							Select a Share</label>
					</h4>
					<div class="col-sm-4">
						<select class="form-control" name="options"
							onchange="this.form.submit()">
							<option>Select</option>
							<c:forEach var="element" items="${mybuy}">
								<option value="${element.shareId}">${element.company.name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<br>
				<div class="form-group">
					<h4>
						<label class="control-label" for="selectbuysellboth">Step
							2: Select buy/sell/both</label>
					</h4>
					<div class="col-sm-2">
						<select class="form-control" name="tradeOptions">
							<option value="buyTrade">Buy</option>

							<c:if test="${quantityowned gt 0}">
								<option value="sellTrade">Sell</option>
								<option value="bothTrade">Both</option>
							</c:if>
						</select>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-1">
						<button class="btn btn-primary" name="button2" type="submit"
							formaction="modalCreateTrade">Next</button>
					</div>
				</div>
			</form>
		</div>
		<div class="container-two">
			<c:choose>
				<c:when test="${modalType == '1'}">
					<h3>Buy</h3>
					<h4>${selectedshare.company.name}</h4>
					<form class="form-horizontal" action="postBuyTrade" method="post">
						<div class="form-group">
							<label class="control-label col-sm-2">Buy Quantity:</label>
							<div class="col-sm-2">
								<input type="number" class="form-control" name="shareAmount"
									min="0" max="9999" required>

							</div>

							<label class="control-label col-sm-1">Price:</label>
							<div class="col-sm-2">
								<input type="number" class="form-control" name="price" min="0"
									max="9999" required>

							</div>
							<div>
								<input class="btn btn-primary" type="submit" value="Post" />
							</div>
						</div>
					</form>
				</c:when>
				<c:when test="${modalType == '2'}">
					<h3>Sell</h3>
					<h4>${selectedshare.company.name}</h4>
					<form class="form-horizontal" action="postSellTrade" method="post">
						<div class="form-group">
							<label class="control-label col-sm-2">Sell Quantity:</label>
							<div class="col-sm-2">
								<input type="number" min="0" max="${quantityowned}"
									class="form-control" name="shareAmount" required min="0">
							</div>
							<label class="control-label col-sm-1">Price:</label>
							<div class="col-sm-2">
								<input type="number" class="form-control" name="price" required
									min="0">
							</div>
							<div>
								<input class="btn btn-primary" type="submit" value="Post" />
							</div>
						</div>
					</form>
				</c:when>
				<c:when test="${modalType == '3'}">
					<h3>Both</h3>
					<h4>${selectedshare.company.name}</h4>
					<form class="form-horizontal" action="postBothTrade" method="post">
						<div class="form-group">
							<label class="control-label col-sm-2">Buy Quantity:</label>
							<div class="col-sm-4">
								<input type="number" class="form-control" min="0" max="9999"
									name="shareBuyAmount" required min="0">
							</div>
							<label class="control-label col-sm-2">Sell Quantity:</label>
							<div class="col-sm-4">
								<input type="number" min="0" max="${quantityowned}"
									class="form-control" name="shareSellAmount" required min="0">
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-2">Buy Price:</label>
							<div class="col-sm-4">
								<input type="number" class="form-control" min="0" max="9999"
									name="buyPrice" required min="0">
							</div>
							<label class="control-label col-sm-2">Sell Price:</label>
							<div class="col-sm-4">
								<input type="number" class="form-control" min="0" max="9999"
									name="sellPrice" required min="0">
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-1">
								<input class="btn btn-primary" type="submit" value="Post" />
							</div>
						</div>
					</form>
				</c:when>
			</c:choose>
		</div>
	</div>

	<!-- 
			<h3>Buy Trades</h3>
			<hr>
		
	
		<div class="container-two">
	
				<div>
					<c:set var="noOwnedShares" value="${mysell}" />
					<c:choose>
						<c:when test="${empty noOwnedShares}">
							<input class="btn btn-primary" type="submit" value="Sell"
								disabled />
						</c:when>
						<c:otherwise>
							<input class="btn btn-primary" type="submit" value="Sell" />
						</c:otherwise>
					</c:choose>
				</div>
			</form>
		</div>
	</div>
	-->

</body>
</html>
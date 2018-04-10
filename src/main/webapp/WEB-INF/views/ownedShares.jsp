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
<link rel="stylesheet" href="resources/css/login.css">
<c:if test="${empty loggedUser}">
	<%--c:redirect url="${pageContext.servletContext.contextPath}" /--%>
	<c:redirect url="" />

</c:if>

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
         <li><a href="${pageContext.servletContext.contextPath}/listcurrent">Current Trades</a></li>
  		 <li class="active"><a href="${pageContext.servletContext.contextPath}/listowned">Owned Shares</a></li>
      	<li><a href="${pageContext.servletContext.contextPath}/listtracked">Tracked Shares</a></li>
  		<li><a href="${pageContext.servletContext.contextPath}/listhistory">Trading History</a></li>
  		<li><a href="${pageContext.servletContext.contextPath}/listcompanies">Companies</a></li>
  		<li><a href="${pageContext.servletContext.contextPath}/trade">Trade</a></li>
  		
				<c:if test="${loggedUser.adminBoolean == '1'}">

				<!--  -->
				
				<li class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown" href="#">Admin
          <span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="${pageContext.servletContext.contextPath}/adminUser">User</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/adminTrade">Trades</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/adminCompany">Companies</a></li> 
          </ul>
        </li>
				<!--  -->
				
				</c:if>
   		 </ul>	
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
          <a class="glyphicon glyphicon-user dropdown-toggle" data-toggle="dropdown" href="${pageContext.servletContext.contextPath}/credit">${loggedUser.username}
            <span class="caret"></span> &nbsp;
          </a>
          <ul class="dropdown-menu">
            <li><a href="${pageContext.servletContext.contextPath}/profile">Profile</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/credit">Credit</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/Logout">Logout</a></li> 
          </ul>
          </li>
			</ul>
		</nav>
	</div>

<div class="container">
  	<p><h1>Owned Shares</h1></p>

<div class="container-two">
				<!--  -->
				<c:set var="total" value="${0}"/>
	 <c:forEach var="ownedShare" items="${loggedUser.ownedShares}">
	 <c:set var="total" value="${total + ownedShare.pricePerShare*ownedShare.quantity}"/>
	 </c:forEach>
	<form class="form-inline">
  <div class="form-group">
    <label for="profitloss">Profit/Loss:</label>
    	<c:choose>
					<c:when test="${profitLoss gt 0}">
						 <input type="text" class="form-control" id="profitloss" value="${profitLoss}"readonly style="color:green">
					</c:when>
					<c:otherwise>
 						<input type="text" class="form-control" id="profitloss" value="${profitLoss}"readonly style="color:red">
					</c:otherwise>
				</c:choose>
  </div>
  <div class="form-group">
    <label for="funds">Available Funds:</label>

    <input type="text" class="form-control" id="funds" placeholder="2090" value="${loggedUser.credit}" readonly>

  </div>
  <div class="form-group">
    <label for="investment">Total Investment:</label>
    <input type="text" class="form-control" id="investment" value="${total}" placeholder="" readonly>
  </div>
</form>
	
	<!--  -->
		</div>

  <hr>      
  <table class="table table-striped">
    <thead>
      <tr>
      	<th>Company Name</th>
        <th>Share id</th>
        <th>Quantity</th>
         <th>Price per Share</th>
        <th colspan="3">Options</th>
  	  </tr>
    </thead>
  
    <tbody>
     <c:forEach var="trades" items="${ownedShares}">
      <tr>
        <td>${trades.share.company.name}</td>
        <td>${trades.share}</td>
        <td>${trades.quantity}</td>
        <td>${trades.pricePerShare}</td>

        <td>
        <form action="company" method="Post">
								<button class="btn btn-info" type="submit" name="cinfo"
									value="${trades.share.company.name}">Info</button>
							</form>
        </td>
      </tr>
     </c:forEach>
     
     </tbody>
  </table>
</div>

</body>
<footer class="text-center">
  
  <br><br>
  <p><a href="#" data-toggle="tooltip" title="Visit w3schools">JHAPPY.com CopyRight &#9400; 2017</a></p> 
</footer>
</html>
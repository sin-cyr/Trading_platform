<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="FALSE"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin - Trades</title>
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
				<li class="active"><a
					href="${pageContext.servletContext.contextPath}/adminTrade">Admin
						Trade </a></li>
				<li><a
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
		<h1>Admin: Current Trades</h1>
		</p>


<div class="container-three">
			<form class="" action="adminSearchTrades" method="Post">
				<div class="form-group">
					<div class="col-xs-4 selectContainer">
						<select class="form-control" name="options">
							<option value="bplowest">Buy Price: Lowest to Highest</option>
							<option value="bphighest">Buy Price: Highest to Lowest</option>
							<option value="sphighest">Sell Price: Highest to Lowest</option>
							<option value="splowest">Sell Price: Lowest to Highest</option>
							<option value=tplatest>Time Posted: Most Recent</option>
							<option value="tprecent">Time Posted: Oldest</option>

						</select> <select class="form-control" name="filter">
							<option value="All">Industry: Show All</option>
							<option value="Payroll">Industry: Payroll</option>
							<option value="Advertising">Industry: Advertising</option>
							<option value="Accounting">Industry: Accounting</option>
							<option value="Asset Management">Industry: Asset
								Management</option>
							<option value="Customer Relations">Industry: Customer
								Relations</option>
							<option value="Customer Service">Industry: Customer
								Service</option>
							<option value="Finances">Industry: Finances</option>
							<option value="Human Resources">Industry: Human
								Resources</option>
							<option value="Legal Department">Industry: Legal
								Department</option>
							<option value="Media Relations">Industry: Media
								Relations</option>
							<option value="Public Relations">Industry: Public
								Relations</option>
							<option value="Quality Assurance">Industry: Quality
								Assurance</option>
							<option value="Research and Development">Industry:
								Research and Development</option>
							<option value="Sales and Marketing">Industry: Sales and
								Marketing</option>
							<option value="Tech Support">Industry: Tech Support</option>
						</select>

					</div>
				</div>
				<button class="btn btn-default" name="sort" type="submit">Search</button>
			</form>
		</div>

		<hr>
		
		<c:if test="${not empty no}">
			<h3>${no}</h3>
			<c:remove var="no" scope="session" />

		</c:if>
		
		<table class="table table-striped">
			<thead>
				<tr>
					<th>Company name</th>
					<th>Buy Price</th>
					<th>Sell Price</th>
					<th>Time Posted</th>
					<th colspan="2">Options</th>

				</tr>
			</thead>
			
			<tbody>

				<form action="adminFilterByCompany" method="Post">
					<!--  -->
					<form>
						<div class="input-group">
							<input type="text" class="form-control" name="comp2"
								placeholder="Search by Company Name">
							<div class="input-group-btn">
								<button class="btn btn-default" name="comp" type="submit">
									<i class="glyphicon glyphicon-search"></i>
								</button>
							</div>
						</div>
					</form>
					<hr>
					<!--  -->
					<!-- <input type="text" class="form-control" name="comp2" -->
					<!-- placeholder="Company Name"> -->
					<!-- <button class="btn btn-primary" name="comp" type="submit">Search</button> -->

				</form>
			</tbody>

			<c:forEach var="trade" items="${currentTrades}">
			<c:if test="${trade.amountBuying ne 0}">
			
				<tr>
					<td>${trade.share.company.name}</td>
					<td>${trade.buyPrice}</td>
					<td>${trade.sellPrice}</td>
					<td>${trade.timePosted}</td>
					<td>
						<!-- insert modal button to a Review modal -->
					
					<button class="btn btn-danger" type="button" data-toggle="modal"  data-target="#deleteModal" >Delete</button>
					
	<div id="deleteModal" class="modal modal-message modal-warning fade" style="display: none;" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <i class="fa fa-warning"></i>
                </div>
                <div class="modal-title"><h3>Confirm Action</h3></div>
				<div class="modal-body">
                You are currently attempting to delete a live trade; are you sure you want to continue with this action?
                <form action="deleteTrades" method="Post">
       
                </div>
                <div class="modal-footer">
        <button type="submit" class="btn btn-success" value="${trade.sharePriceId}" name="tradeID"><span class="glyphicon glyphicon-ok-sign"></span></button>
          <button type="button" class="btn btn-danger" data-dismiss="modal"><span class="glyphicon glyphicon-remove-sign"></span></button>     

		</form>
                </div>
            </div> <!-- / .modal-content -->
        </div> <!-- / .modal-dialog -->
    </div>
					
					
					
					<div class="modal fade" id="deleteModal" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        
		<h4> Are you sure you want to delete this trade?  </h4>
        <form action="deleteTrades" method="Post">
       
        <button type="submit" class="btn btn-default" value="${trade.sharePriceId}" name="tradeID">Yes</button>
          <button type="button" class="btn btn-default" data-dismiss="modal">No</button>     
		</form>
		
      </div>
      
    </div>
  </div>
					</td>
					<td>
					<button class="btn btn-danger" name="contact" data-toggle="modal" data-target="#messageModal">Contact</button>
					</td>
					<td>
						<form action="adminGoToUser" method="Post">
							<button class="btn btn-danger" type="submit" name="edituserbutton"
								value="${trade.user.username}">User</button>
						</form>
					</td>
				</tr>
			</c:if>
			</c:forEach>
			
			</tbody>
		</table>
	</div>

<div class="modal fade" id="messageModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Contact Trader</h4>
        </div>
        <div class="modal-body">
          <form>
									<div class="form-group">
										<label for="email">Email:</label> <input type="email"
											class="form-control" id="email" placeholder="Enter email" readonly>
									</div>
									<div class="form-group">
										<label for="message">Message:</label>
										<textarea class="form-control" rows="5" id="message"
											placeholder="Enter message"></textarea>
									</div>
									<button type="submit" class="btn btn-default">Send Email</button>
								</form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
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

	<br> <br>
	<p>
		<a href="#" data-toggle="tooltip"
			title="Visit w3schools">JHAPPY.com CopyRight &#9400; 2017</a>
	</p>
</footer>
</html>
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
						</ul></li>
					<!--  -->

				</c:if>

			</ul>
			<ul class="nav navbar-nav navbar-right">

				<li class="dropdown">
          			<a class="glyphicon glyphicon-user dropdown-toggle" data-toggle="dropdown" 
          				href="${pageContext.servletContext.contextPath}/credit">${loggedUser.username}
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
		<h2>My Credits</h2>
		<hr>
		<div class="container-three">
			<form class="form-inline" name='#' action="#" method="#">
				<table>
					<tr>


						<td>
							<h3>Balance:</h3>
						</td>
						<td><h3>${user.credit}</h3></td>

					</tr>
				</table>
			</form>
		</div>
		<h2>Add Credits</h2>
		<hr>
		<div class="container">
			<form class="form-horizontal" action="updatecredits">
				<div class="form-group">
					<label class="control-label col-sm-2" for="addamount">Credits
						Amount:</label>
					<div class="col-sm-4">
						<input type="number" class="form-control" id="addamount"
							name="amount" placeholder="Quantity to add" min="1" max="9999" required
							oninvalid="setCustomValidity('Please enter the limit allowed')"
							onchange="try{setCustomValidity('')}catch(e){}" />
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-2" for="cardnumber">Credit/Debit:</label>
					<div class="col-sm-4">


						<input type="number" class="form-control" id="cardnumber"
							placeholder="Card Number" min="1000000000000000"
							max="9999999999999999" required
							oninvalid="setCustomValidity('Please enter a 16 digit number')"
							onchange="try{setCustomValidity('')}catch(e){}" />
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-2" for="cvc">CVC:</label>
					<div class="col-sm-4">
						<input type="number" class="form-control" id="cvc"
							placeholder="last three digits on back of card" min="100"
							max="999" required
							oninvalid="setCustomValidity('Please enter your three digit security code')"
							onchange="try{setCustomValidity('')}catch(e){}" />
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-2" for="expirydate">Expiry Date:</label>
					<div class="col-sm-8">
					<div class="row">
						<div class="col-sm-2">
						<select class="form-control col-sm-2" id="cc-exp-month">
							<option value="01">Jan</option>
							<option value="02">Feb</option>
							<option value="03">Mar</option>
							<option value="04">Apr</option>
							<option value="05">May</option>
							<option value="06">Jun</option>
							<option value="07">Jul</option>
							<option value="08">Aug</option>
							<option value="09">Sep</option>
							<option value="10">Oct</option>
							<option value="11">Nov</option>
							<option value="12">Dec</option>
						</select>
						</div>
						<div class="col-sm-2">
						<select class="form-control col-sm-2" id="cc-exp-year">
							<option value="15">2017</option>
							<option value="16">2018</option>
							<option value="17">2019</option>
							<option value="18">2020</option>
							<option value="19">2021</option>
							<option value="20">2022</option>
							<option value="21">2023</option>
							<option value="22">2024</option>
							<option value="23">2025</option>
							<option value="24">2026</option>
						</select>
						</div>
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-4">
						<div class="checkbox">
							<label><input type="checkbox"> Remember me</label>
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-4">
						<button type="submit" class="btn btn-primary">Submit</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<script type="text/javascript"
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
	<script type="text/javascript"
		src="https://www.simplify.com/commerce/v1/simplify.js"></script>
	<script type="text/javascript">
		function simplifyResponseHandler(data) {
			var $paymentForm = $("#simplify-payment-form");
			// Remove all previous errors
			$(".error").remove();
			// Check for errors
			if (data.error) {
				// Show any validation errors
				if (data.error.code == "validation") {
					var fieldErrors = data.error.fieldErrors, fieldErrorsLength = fieldErrors.length, errorList = "";
					for (var i = 0; i < fieldErrorsLength; i++) {
						errorList += "<div class='error'>Field: '"
								+ fieldErrors[i].field + "' is invalid - "
								+ fieldErrors[i].message + "</div>";
					}
					// Display the errors
					$paymentForm.after(errorList);
				}
				// Re-enable the submit button
				$("#process-payment-btn").removeAttr("disabled");
			} else {
				// The token contains id, last4, and card type
				var token = data["id"];
				// Insert the token into the form so it gets submitted to the server
				$paymentForm
						.append("<input type='hidden' name='simplifyToken' value='" + token + "' />");
				// Submit the form to the server
				$paymentForm.get(0).submit();
			}
		}
		$(document).ready(function() {
			$("#simplify-payment-form").on("submit", function() {
				// Disable the submit button
				$("#process-payment-btn").attr("disabled", "disabled");
				// Generate a card token & handle the response
				SimplifyCommerce.generateToken({
					key : "YOUR_PUBLIC_KEY",
					card : {
						number : $("#cc-number").val(),
						cvc : $("#cc-cvc").val(),
						expMonth : $("#cc-exp-month").val(),
						expYear : $("#cc-exp-year").val()
					}
				}, simplifyResponseHandler);
				// Prevent the form from submitting
				return false;
			});
		});
	</script>

</body>
</html>
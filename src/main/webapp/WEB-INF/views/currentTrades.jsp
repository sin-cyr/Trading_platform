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
    var quantity = document.getElementById('quantity'+number).value;
    var pricepershare = document.getElementById('pricepershare'+number).value;
    var result = parseInt(quantity) * parseInt(pricepershare);
    if (!isNaN(result)) {
        document.getElementById('totalcost'+number).value = result;
    }
}
    
    function sumsell(number) {
        var quantity = document.getElementById('quantitysell'+number).value;
        var pricepershare = document.getElementById('pricepersharesell'+number).value;
        var result = parseInt(quantity) * parseInt(pricepershare);
        if (!isNaN(result)) {
            document.getElementById('totalcostsell'+number).value = result;
        }
    }

        
  
</script>
<script>
	$(document).ready(function() {
		$("#confirmation").click(function() {
			$(this).hide();
		});
	});
</script>
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
		<h1>Current Trades</h1>
		</p>


		<div class="container-two">
			<!--  -->
			<c:set var="total" value="${0}" />
			<c:forEach var="ownedShare" items="${loggedUser.ownedShares}">
				<c:set var="total"
					value="${total + ownedShare.pricePerShare*ownedShare.quantity}" />
			</c:forEach>
			<form class="form-inline" action="">

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
						placeholder="" readonly>
				</div>
				<div class="form-group">
					<label for="investment">Total Investment:</label> <input
						type="text" class="form-control" id="investment" value="${total}"
						placeholder="11500" readonly>
				</div>

			</form>
		</div>


		<!-- TESTING 
-->

		<div class="container-three">
			<form class="" action="searchTrades" method="Post">
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
					<th>Industry</th>
					<th>Buy Price</th>
					<th>Sell Price</th>
					<th>Time Posted</th>
					<th colspan="4">Options</th>

				</tr>
			</thead>


			<tbody>
			<tbody>

				<form action="filterByCompany" method="Post">
					<!--  -->

					<div class="input-group">
						<input type="text" class="form-control" name="comp2"
							placeholder="Search by Company Name" maxlength="80" required>
						<div class="input-group-btn">
							<button class="btn btn-default" name="comp" type="submit">
								<i class="glyphicon glyphicon-search"></i>
							</button>
						</div>
					</div>

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
						<td>${trade.share.company.industry}</td>
						<td>${trade.buyPrice}</td>
						<td>${trade.sellPrice}</td>
						<td>${trade.timePosted}</td>

						<!-- Search shares with company name  -->




						<td><c:set var="credit" value="${loggedUser.credit}" /> <c:set
								var="buyPrice" value="${trade.buyPrice}" /> <c:if
								test="${credit >= buyPrice}">
								<button class="btn btn-primary" data-toggle="modal"
									data-target="#buyModal${trade.sharePriceId}">Buy</button>
							</c:if> <c:if test="${credit < buyPrice}">
								<button class="btn btn-primary" data-toggle="modal"
									data-target="#buyModal${trade.sharePriceId}" disabled>Buy</button>
							</c:if>
							<div class="modal fade" id="buyModal${trade.sharePriceId}"
								role="dialog">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal">&times;</button>
										</div>
										<div class="modal-body">
											<form action="tradesBuy" method="Post">
												<div class="form-group">
													<label for="quant"><span
														class="glyphicon glyphicon-user"></span> Quantity</label> <input
														type="number" class="form-control" name="quantity" min="0" 
														placeholder="Quantity" id="quantity${trade.sharePriceId}"
														onkeyup="sum(${trade.sharePriceId});" required>
												</div>
												<div class="form-group">
													<label for="Pps"><span
														class="glyphicon glyphicon-user"></span> Price per Share</label> <input
														type="number" class="form-control" name="pricepershare"
														id="pricepershare${trade.sharePriceId}"
														value="${trade.sellPrice }" required>
												</div>
												<div class="form-group">
													<label for="total"><span
														class="glyphicon glyphicon-user"></span> Total cost</label> <input
														type="number" class="form-control" name="totalcost"
														id="totalcost${trade.sharePriceId}" value="">
												</div>
												<button type="submit" class="btn btn-primary"
													name="buybutton" value="${trade}">Buy</button>
											</form>
										</div>
									</div>
								</div>
							</div></td>
						<td><c:set var="shareisowned" value="0" /> <c:set
								var="tradeid" value="${trade.share.shareId}" /> <c:forEach
								var="ownedShare" items="${loggedUser.ownedShares }">
								<c:set var="ownedid" value="${ownedShare.share.shareId}" />
								<c:if test="${ownedid == tradeid}">
									<c:set var="shareisowned" value="1" />
								</c:if>
							</c:forEach> <c:if test="${shareisowned == 1}">
								<button class="btn btn-primary" data-toggle="modal"
									data-target="#sellModal${trade.sharePriceId}">Sell</button>
							</c:if> <c:if test="${shareisowned == 0}">
								<button class="btn btn-primary" data-toggle="modal"
									data-target="#sellModal${trade.sharePriceId}" disabled>Sell</button>
							</c:if>
							<div class="modal fade" id="sellModal${trade.sharePriceId}"
								role="dialog">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal">&times;</button>
										</div>
										<div class="modal-body">
											<form action="tradesSell" method="Post">
												<div class="form-group">
													<label for="quant"><span
														class="glyphicon glyphicon-user"></span> Quantity</label> <input
														type="number" class="form-control" name="quantity" min="0"
														placeholder="Quantity"
														id="quantitysell${trade.sharePriceId}"
														onkeyup="sumsell(${trade.sharePriceId});"  required>
												</div>
												<div class="form-group">
													<label for="Pps"><span
														class="glyphicon glyphicon-user"></span> Price per Share</label> <input
														type="number" class="form-control" name="pricepershare"
														id="pricepersharesell${trade.sharePriceId}"
														value="${trade.buyPrice }" required>
												</div>
												<div class="form-group">
													<label for="total"><span
														class="glyphicon glyphicon-user"></span> Total</label> <input
														type="number" class="form-control" name="totalcost"
														id="totalcostsell${trade.sharePriceId}" value="">
												</div>
												<button type="submit" class="btn btn-primary"
													name="sellbutton" value="${trade}">Sell</button>
											</form>
										</div>
									</div>
								</div>
							</div></td>
						<td>
							<form action="trackedShares" method="Post">
								<c:set var="shareistracked" value="0" />
								<c:set var="tradeid" value="${trade.share.shareId}" />

								<c:forEach var="trackedShare"
									items="${loggedUser.trackedShares }">
									<c:set var="trackedid"
										value="${trackedShare.sharePrice.share.shareId}" />
									<c:if test="${trackedid == tradeid}">
										<c:set var="shareistracked" value="1" />
									</c:if>
								</c:forEach>

								<c:if test="${shareistracked == 0}">
									<button class="btn btn-primary" name="shareid" type="submit"
										value="${trade.share.shareId}">Track</button>
								</c:if>
								<c:if test="${shareistracked == 1}">

									<button class="btn btn-primary" name="shareid" type="submit"
										value="${trade.share.shareId}" disabled>Track</button>

									<!-- 	<button class="btn btn-primary" name="shareid" disabled>Track</button> -->

								</c:if>

							</form>

						</td>
						<td>
							<form action="company" method="Post">
								<button class="btn btn-info" type="submit" name="cinfo"
									value="${trade.share.company.name}">Info</button>
							</form>
						</td>
					</tr>
				</c:if>
			</c:forEach>

			</tbody>
		</table>
	</div>
	<a onclick="topFunction()" id="top" title="Go to top"></a>
	<script>
//  When the user clicks on the button, scroll to the top of the document
window.onscroll = function() {scrollFunction()};
function topFunction() {
    document.body.scrollTop = 0; // For Chrome, Safari and Opera 
}
</script>

	<!-- Modal -->
	<div id="tradesModal" class="modal fade" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h3>Trade</h3>
				</div>

				<div class="modal-body">
					<div class="tabbable">
						<!-- Only required for left/right tabs -->
						<div class="tab-content">
							<div class="tab-pane active" id="tab1">

								<!-- Modal buy form -->

								<form name='form-tradesBuy' action="tradesBuy" method="Post">
									<br />
									<div class="form-group">
										<label for="tab1"><span
											class="glyphicon glyphicon-shopping-cart"></span> Number of
											Shares:</label> <input type="number" class="form-control"
											name="shareAmount" min="0" required>
									</div>
									<div class="form-group">
										<label for="tab1"><span
											class="glyphicon glyphicon-shopping-cart"></span> Price per
											Share:</label> <input type="number" class="form-control"
											name="pricePerShare" placeholder="${trades.buyPrice}"
											readonly>
									</div>
									<div class="form-group">
										<label for="tab1"><span
											class="glyphicon glyphicon-shopping-cart"></span> Total Cost:</label>
										<input type="number" class="form-control" name="totalCost"
											placeholder="${totalCost}" readonly>
									</div>
									<button type="button" onclick="trades" class="btn btn-block">
										Buy <span class="glyphicon glyphicon-ok"></span>
									</button>
								</form>

							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>

		</div>
	</div>

	</div>
	<script>
$('#form-tradesBuy').submit(function () {
	 sendContactForm();
	 return false;
	});
</script>
	<c:if test="${not empty tracked}">
		<c:set var="trackmsg" value="${tracked}" />
		<c:remove var="tracked" scope="session" />
		<div
			style="position: fixed; bottom: 0px; width: 100%; z-index: 999999;"
			id="confirmation">
			<a href="javascript:hidefreebie();">
				<div border="0"
					style="background-color: #B0B0B0; opacity: 0.85; height: 50px; width: 100%; position: absolute; bottom: 0px; z-index: -1;">
					<h3 align="center">${trackmsg}</h3>
				</div>
			</a>
		</div>
		<c:remove var="tracked" scope="session" />
	</c:if>
	
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
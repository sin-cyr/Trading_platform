<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="FALSE"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Google Charts - Line Chart Test</title>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
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

		var companynames = [];
		var prices = [];
		<c:forEach items="${pricelist}" var="sp" varStatus="status">
			var price = '${sp.price}';
			var name = '${sp.share.company.name}';
			prices.push(price);
			companynames.push(name);
		</c:forEach>

		var listLen = companynames.length;
		var dataArray = [['Company', 'Share Price']];
		for (i = 0; i < listLen; i++){
			dataArray.push([companynames[i], parseInt(prices[i])]);
		}
		var data = google.visualization.arrayToDataTable(dataArray);


		var options = {
			title: 'Company Stock Prices',
			curveType: 'function',
			
		};

		var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));

		chart.draw(data, options);
	}
</script>
</head>
<body>
	<div id="curve_chart" style="width: 1200; height: 1200"></div>
</body>
</html>
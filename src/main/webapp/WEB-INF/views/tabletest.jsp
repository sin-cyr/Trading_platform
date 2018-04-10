<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="FALSE"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Google Chart - Table Test</title>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	// Load the Visualization API and the corechart package.
	google.charts.load('current', {
		packages : [ 'corechart', 'table' ]
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

		var data = new google.visualization.DataTable();
		data.addColumn('string', 'Company Name');
		data.addColumn('number', 'Share Price');
		for (i = 0; i < listLen; i++){
			//dataArray.push([companynames[i], parseInt(prices[i])]);
		data.addRow([companynames[i], parseInt(prices[i])]);
		}

		var chart = new google.visualization.Table(document.getElementById('curve_chart'));

		chart.draw(data,{width:'100%', height: '100%'});
	}
</script>
</head>
<body>
	<div id="curve_chart"></div>
</body>
</html>
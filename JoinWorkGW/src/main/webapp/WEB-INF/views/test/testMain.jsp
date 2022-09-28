<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
#index_01{
	width:2000px;
}
#slide1 {
	height: 300px;
	overflow: hidden;
}
#slide1>ul>li {
	display: inline-block;
}
</style>
</head>
<body>
	<div id="index_01">
		<button type="button" onclick="prev();">prev</button>
		<div id="slide1">
			<ul>
				<li style="height:30vh;width:200px;background-color:red;"><a href="#"></a></li>
				<li style="height:30vh;width:200px;background-color:green;"><a href="#"></a></li>
				<li style="height:30vh;width:200px;background-color:red;"><a href="#"></a></li>
				<li style="height:30vh;width:200px;background-color:green;"><a href="#"></a></li>
				<li style="height:30vh;width:200px;background-color:red;"><a href="#"></a></li>
				<li style="height:30vh;width:200px;background-color:green;"><a href="#"></a></li>
				<li style="height:30vh;width:200px;background-color:red;"><a href="#"></a></li>
				<li style="height:30vh;width:200px;background-color:green;"><a href="#"></a></li>
				<li style="height:30vh;width:200px;background-color:red;"><a href="#"></a></li>
				<li style="height:30vh;width:200px;background-color:green;"><a href="#"></a></li>
			</ul>
		</div>
		<button type="button" onclick="next();">next</button>
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>	
	
	
<script>
function prev(){
	$('#slide1>ul').animate({
		marginLeft : $('#slide1>ul').css('margin-left').split('px')[0]*1 - 500+"px"
	});
}
function next(){
	$('#slide1>ul').animate({
		marginLeft : $('#slide1>ul').css('margin-left').split('px')[0]*1 + 500+"px"
	});
}
</script>
	
	
</body>



</html>
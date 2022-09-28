<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>

<head>

<meta charset="utf-8">

<title>:: QR ::</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jsQR.js"></script>

<style type="text/css">

	main {

		width:100%;

		height:100%;

		text-align:center;

	}

	

	main > div {

		float:left;

		width:1%;

		height:98%;

	}

	main > div:first-child {

		width:49%;

	}

	

	main > div:last-child {

		background-color:#D3D3D3;

		width:49%;

	}



	div#output {

		background-color:#BDBEBD;

		padding-left:10px;

		padding-right:10px;

		padding-top:10px;

		padding-bottom:10px;

	}

	

	div#frame {

		border:2px solid #005666;

		background-color:#FFFFFF;

		margin-left:10px;

		margin-right:10px;

		padding-left:8px;

		padding-right:8px;

		padding-top:8px;

		padding-bottom:8px;

	}

	

	div#outputLayer {

		text-align:left;

	}

	

	canvas {

		width:100%;

	}

</style>

</head>

<body>

<main>

	<div id="test">

		<h1>QR 코드 리더</h1>

		<div id="output">

			<div id="outputMessage">

				QR코드를 카메라에 노출시켜 주세요

			</div>

    		<div id="outputLayer" hidden>

    			<span id="outputData"></span>
				<p>사번 : <span id="empId"></span> </p>
				<p>이름 : <span id="empName"></span> </p>
				<p>팀: <span id="empTeam"></span></p>
				<p>부서: <span id="empDept"></span></p>

    		</div>

		</div>

	</div>

	<div>&nbsp;</div>

	<div>

		<h1>스캔</h1>

		<div id="frame">

			<div id="loadingMessage">

				🎥 비디오 스트림에 액세스 할 수 없습니다<br/>웹캠이 활성화되어 있는지 확인하십시오

			</div>

			<canvas id="canvas"></canvas>

		</div>

	</div>

</main>

</body>

</html>

<script type="text/javascript">	

	document.addEventListener("DOMContentLoaded", function() {

		

		var video = document.createElement("video");		

		var canvasElement = document.getElementById("canvas");

		var canvas = canvasElement.getContext("2d");

		var loadingMessage = document.getElementById("loadingMessage");

		var outputContainer = document.getElementById("output");


 
		var outputMessage = document.getElementById("outputMessage");


 
		var outputData = document.getElementById("outputData");
		var userName = document.getElementById("userName");
		var seatNo = document.getElementById("seatNo");

		

		function drawLine(begin, end, color) {

			

			canvas.beginPath();

			canvas.moveTo(begin.x, begin.y);

			canvas.lineTo(end.x, end.y);

			canvas.lineWidth = 4;

			canvas.strokeStyle = color;

			canvas.stroke();

                }

	    

	        // 카메라 사용시

		navigator.mediaDevices.getUserMedia({ video: { facingMode: "environment" } }).then(function(stream) {

			

      		        video.srcObject = stream;

      		        video.setAttribute("playsinline", true);      // iOS 사용시 전체 화면을 사용하지 않음을 전달

         		video.play();

      		        requestAnimationFrame(tick);

		});



		function tick() {

			

			loadingMessage.innerText = "⌛ 스캔 기능을 활성화 중입니다."

			

			if(video.readyState === video.HAVE_ENOUGH_DATA) {

				

        		      loadingMessage.hidden = true;

        		      canvasElement.hidden = false;

        		      outputContainer.hidden = false;

        		

        		      // 읽어들이는 비디오 화면의 크기

        		      canvasElement.height = video.videoHeight;

        	 	      canvasElement.width = video.videoWidth;

        		

        		      canvas.drawImage(video, 0, 0, canvasElement.width, canvasElement.height);

        		      var imageData = canvas.getImageData(0, 0, canvasElement.width, canvasElement.height);


 


        		      var code = jsQR(imageData.data, imageData.width, imageData.height, {



                                    inversionAttempts : "dontInvert",

        		      });
                              // QR코드 인식에 성공한 경우

                              if(code) {
                                     // 인식한 QR코드의 영역을 감싸는 사용자에게 보여지는 테두리 생성

                                    drawLine(code.location.topLeftCorner, code.location.topRightCorner, "#FF0000");

                                    drawLine(code.location.topRightCorner, code.location.bottomRightCorner, "#FF0000");

                                    drawLine(code.location.bottomRightCorner, code.location.bottomLeftCorner, "#FF0000");

                                    drawLine(code.location.bottomLeftCorner, code.location.topLeftCorner, "#FF0000");

                                    outputMessage.hidden = true;

                                    outputData.parentElement.hidden = false;

          			

                                    // QR코드 메시지 출력

                                   	array = code.data.split('/');

									empInfo = array[6].split('=');
									var sendData = { "empId": empInfo[1] };
									
									
									$.ajax({
										url : "<%=request.getContextPath()%>/attend/insertStartWorkQR",
								        type : "POST",
										data:JSON.stringify(sendData),
										contentType : 'application/json; charset=UTF-8',
										dataType:"json",
										success:function(data){
											var empInfo= data;
											console.log(data.empId);
											alert(data.empName +'님 ('+data.empDetp+'부서) 출근 완료');
											location.reload();
											
										},
										error:function(){
											alert('출근 실패');
											location.reload();
										}
									});


                                    // return을 써서 함수를 빠져나가면 QR코드 프로그램이 종료된다.

                                    return;

                              }

        		

                              // QR코드 인식에 실패한 경우 

                              else {



                                    outputMessage.hidden = false;

                                    outputData.parentElement.hidden = true;

                              }

                      }

      		

      		      requestAnimationFrame(tick);

		}

	});

</script>
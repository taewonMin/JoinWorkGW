<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>


<head>
<title>:: 내정보 설정</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
<meta name="description" content="Lucid Bootstrap 4x Admin Template">
<meta name="author" content="WrapTheme, design by: ThemeMakker.com">

<style type="text/css">
.img_wrap {
    width: 130px;
    margin-top: 120px;
    text-align: center;
}
 .img_wrap img { 
   max-width: 100%; 
} 
         
div.lb1{
text-align: left;
}
 
</style>
</head>


<!-- VENDOR CSS -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/assets/vendor/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/assets/vendor/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/assets/vendor/bootstrap-datepicker/css/bootstrap-datepicker3.min.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/assets/vendor/jvectormap/jquery-jvectormap-2.0.3.min.css"/>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/assets/vendor/morrisjs/morris.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/assets/vendor/nestable/jquery-nestable.css"/>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/assets/vendor/bootstrap-multiselect/bootstrap-multiselect.css"/>
<link rel="stylesheet" href="<%=request.getContextPath() %>resources/templates/assets/vendor/summernote/dist/summernote.css"/>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/assets/vendor/dropify/css/dropify.min.css">

<!-- MAIN CSS -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/light/assets/css/main.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/light/assets/css/blog.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/light/assets/css/color_skins.css">

    


<body class="theme-blue">

<div class="page-loader-wrapper">
    <div class="loader">
        <div class="m-t-30"><img src="<%=request.getContextPath() %>/resources/templates/assets/images/logo-icon.svg" width="48" height="48" alt="Lucid"></div>
        <p>Please wait...</p>        
    </div>
</div>

<div style="text-align: center; margin-top: 30px; " >
	<div class="card" style="width: 520px;">
		<div class="body">
			<div class="header">
				<h6 style="text-align: center; display: contents;">&nbsp;&nbsp;내정보</h6>
				<button type="button" id="cancelBtn" class="btn btn-dark float-right" onclick="history.go(-1);">&nbsp;&nbsp;&nbsp;취 &nbsp;&nbsp;소&nbsp;&nbsp;&nbsp;</button>
			</div>
			<div class="row clearfix" style="margin-right:0px; text-align: center; display: flex; justify-content: center;">
				<div class="row"  style="height:200px;  text-align: center;">
					<div style="text-align: center; width: 100%;">
						<div class="mailbox-attachments clearfix col-md-12" style="text-align: center; width:100%; ">						
							<div id="pictureView" style="border: 1px solid lightgray; height: 200px; width: 140px; margin: 0 auto; text-align: center;"></div>
							<br>
						</div>
					</div>
				</div>
	      
				<div class="col-lg-12 col-md-12" style="margin-left: 25px;">
					<div class="form-group lb1">
						<label>이름</label>
						<input type="text" class="form-control" required="" name="empName" value="${loginUser.empName}" readonly/>
					</div>
					   
					<div class="form-group lb1">
						<label>사번</label>
						<input type="text" class="form-control" required="" name="empId" value="${loginUser.empId}" readonly/>
					</div>
					         
					<div class="form-group lb1">
						<label>전화번호</label>
						<div class="input-group">
							<div class="input-group-prepend">
								<span class="input-group-text"><i class="icon-screen-smartphone"></i></span> 
							</div>
							<input type="text" id=ssn class="form-control" required="" name="empPwd" value="${loginUser.empHp}" readonly/>
						</div>
					</div>
					            
					<div class="form-group lb1">
						<label>주소</label>
						<div class="input-group">
							<div class="input-group-prepend">
								<span class="input-group-text"><i class="icon-home"></i></span>
							</div>
							<input type="text" class="form-control" required=""  name="empAdd" value="${loginUser.empAdd}" readonly/>
						</div>
					</div>
					            
					<div class="form-group lb1">
						<label>서명</label>
						<div class="custom-file">
							<input type="file" class="custom-file-input" id="inputGroupFile01" name="empSign" value="${loginUser.empSign}" >
							<label class="custom-file-label" for="inputGroupFile01" >서명 이미지를 첨부하세요</label>
						</div>
					</div>
					   
					<div class="form-group lb1">
						<label>부서</label>
						<div class="form-group">
							<!-- loginUser 심을 때 deptName까지 가져와서 셋팅하기 -->
							<input type="text" class="form-control" required=""  name="deptId" value="${loginUser.deptId}" readonly/>
						</div>
					</div>
					        
					<div class="form-group lb1">
						<label>직위</label>
						<div class="form-group">
							<input type="text" class="form-control" required=""  name="codeOfficialId" value="${loginUser.codeOfficialId}" readonly/>
						</div>
					</div>
				</div>
			</div>
			<div style="margin-bottom: 15px; margin-left: 25px;">
				<button type ="button" class="btn btn-primary" id="modifyBtn" onclick="location.href='/JoinWorkGW/common/mypage/modifyForm?id=${loginUser.empId}';">수정</button> &nbsp;&nbsp;
				<button type="button" class="btn btn-outline-primary" id="passworBtn" onclick="OpenWindow('<%=request.getContextPath()%>/common/password/modifyForm', '글 수정', 700, 700);">비밀번호 변경</button>
			</div>	
		</div>
	</div>
</div>
	
<form role="imageForm" action="upload/picture.do" method="post" enctype="multipart/form-data">
	<input id="inputFile" name="pictureFile" type="file" class="form-control" onchange="fileChange_go();" style="display:none;">
	<input id="oldFile" type="hidden" name="oldPicture" value="" />
	<input type="hidden" name="checkUpload" value="0" />	
</form>
	
	<script>
	<%@ include file="regist_picture_upload.jsp" %>
	<%@ include file="regist_submit.jsp" %>
	</script>
	
	<script src="<%=request.getContextPath() %>/resources/js/jquery-3.6.0.min.js"></script>
	
	<script src="<%=request.getContextPath() %>/resources/templates/light/assets/bundles/libscripts.bundle.js"></script>
	<script src="<%=request.getContextPath() %>/resources/templates/light/assets/bundles/vendorscripts.bundle.js"></script>
	
	<script src="<%=request.getContextPath() %>/resources/templates/light/assets/bundles/jvectormap.bundle.js"></script> <!-- JVectorMap Plugin Js -->
	<script src="<%=request.getContextPath() %>/resources/templates/light/assets/bundles/morrisscripts.bundle.js"></script><!-- Morris Plugin Js -->
	<script src="<%=request.getContextPath() %>/resources/templates/light/assets/bundles/knob.bundle.js"></script> <!-- Jquery Knob-->
	<script src="<%=request.getContextPath() %>/resources/templates/assets/vendor/nestable/jquery.nestable.min.js"></script> <!-- Jquery Nestable -->
	
	<script src="<%=request.getContextPath() %>/resources/templates/light/assets/bundles/mainscripts.bundle.js"></script>
	<script src="<%=request.getContextPath() %>/resources/templates/light/assets/js/pages/ui/sortable-nestable.js"></script>
	
	<script src="<%=request.getContextPath() %>/resources/templates/assets/vendor/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script><!-- bootstrap datepicker Plugin Js --> 
	<script src="<%=request.getContextPath() %>/resources/templates/assets/vendor/bootstrap-multiselect/bootstrap-multiselect.js"></script>
	<script src="<%=request.getContextPath() %>/resources/templates/assets/vendor/dropify/js/dropify.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/templates/light/assets/js/pages/forms/dropify.js"></script>
	
	<!-- common -->
	<script src="<%=request.getContextPath() %>/resources/js/common.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/prevPic.js" ></script>
	
	<script>
	$(function () {
	    $('.knob').knob({
	        draw: function () {
	            // "tron" case
	            if (this.$.data('skin') == 'tron') {
	
	                var a = this.angle(this.cv)  // Angle
	                    , sa = this.startAngle          // Previous start angle
	                    , sat = this.startAngle         // Start angle
	                    , ea                            // Previous end angle
	                    , eat = sat + a                 // End angle
	                    , r = true;
	
	                this.g.lineWidth = this.lineWidth;
	
	                this.o.cursor
	                    && (sat = eat - 0.3)
	                    && (eat = eat + 0.3);
	
	                if (this.o.displayPrevious) {
	                    ea = this.startAngle + this.angle(this.value);
	                    this.o.cursor
	                        && (sa = ea - 0.3)
	                        && (ea = ea + 0.3);
	                    this.g.beginPath();
	                    this.g.strokeStyle = this.previousColor;
	                    this.g.arc(this.xy, this.xy, this.radius - this.lineWidth, sa, ea, false);
	                    this.g.stroke();
	                }
	
	                this.g.beginPath();
	                this.g.strokeStyle = r ? this.o.fgColor : this.fgColor;
	                this.g.arc(this.xy, this.xy, this.radius - this.lineWidth, sat, eat, false);
	                this.g.stroke();
	
	                this.g.lineWidth = 2;
	                this.g.beginPath();
	                this.g.strokeStyle = this.o.fgColor;
	                this.g.arc(this.xy, this.xy, this.radius - this.lineWidth + 1 + this.lineWidth * 2 / 3, 0, 2 * Math.PI, false);
	                this.g.stroke();
	
	                return false;
	            }
	        }
	    });
	});
	</script>
	
<!-- 	<script> -->
<!--  	$('#target_img').click(function (e) { -->
<!--  	    document.signform.target_url.value = document.getElementById( 'target_img' ).src; -->
<!--  	    e.preventDefault(); -->
<!--  	    $('#file').click(); -->
<!--  	});        -->
	
<!--  	function changeValue(obj){ -->
<!--  	   document.signform.submit(); -->

<!--  	} -->
<!-- 	</script> -->
	
	<script type="text/javascript">
        
        var sel_file;
 
        $(document).ready(function() {
            $("#input_img").on("change", handleImgFileSelect);
        }); 
 
        function handleImgFileSelect(e) {
            var files = e.target.files;
            var filesArr = Array.prototype.slice.call(files);
 	
            filesArr.forEach(function(f) {
                if(!f.type.match("image.*")) {
                    alert("확장자는 이미지 확장자만 가능합니다.");
                    return;
                }
 
                sel_file = f;
 
                var reader = new FileReader();
                reader.onload = function(e) {
                    $("#img").attr("src", e.target.result);
                }
                reader.readAsDataURL(f);
            });
        }
 
    </script>
 

    

	<script> //사진이미지 불러오기
		window.onload=function(){
		Preview_picture('${loginUser.empPicture }');
		}
	</script>
	
	</body>
	</html>
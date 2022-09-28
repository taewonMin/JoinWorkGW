<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>     
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html lang="en">

<head>
<title>:: Site Admin - JoinWorkGW ::</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
<meta name="description" content="Lucid Bootstrap 4x Admin Template">
<meta name="author" content="WrapTheme, design by: ThemeMakker.com">

<!-- LOGO -->
<link rel="shortcut icon" href="<%=request.getContextPath() %>/resources/image/logo.ico">
<!-- VENDOR CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/templates/assets/vendor/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/templates/assets/vendor/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/templates/assets/vendor/jvectormap/jquery-jvectormap-2.0.3.min.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/templates/assets/vendor/morrisjs/morris.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/templates/assets/vendor/nestable/jquery-nestable.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/templates/assets/vendor/bootstrap-datepicker/css/bootstrap-datepicker3.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/templates/assets/vendor/bootstrap-multiselect/bootstrap-multiselect.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/templates/assets/vendor/summernote/dist/summernote.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/templates/assets/vendor/dropify/css/dropify.min.css">
                             
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/templates/assets/vendor/sweetalert/sweetalert.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/templates/assets/vendor/jquery-datatable/dataTables.bootstrap4.min.css">


<!-- MAIN CSS -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/light/assets/css/admin_main.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/light/assets/css/admin_color_skins.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/light/assets/fonts/font.css">

<!-- summernote -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/assets/vendor/summernote/dist/summernote.css"/>


<style>
.navbar-brand{
	margin-top: 10px;
	margin-left: 10px;
}
#left-sidebar{
	margin-top: 0px;
}
#left-sidebar .nav-tabs .nav-link.active{
	background-color: transparent;
    border-color: #dee2e6 #dee2e6 #404040;
    border-bottom-width: 2px;
}
#main-content{
	color: #000000;
}
.navbar-brand strong{
	font-size: 1.2em;
}
.sidebar-scroll{
	margin: 0px 5px;
}
.sidebar-nav li:hover, .sidebar-nav li:focus, ul.collapse li:hover {
	color: #404040;
}
#main-content{
	margin-top: 20px;
}
.nav-tabs>li>a:hover, .nav-tabs>li>a:focus {
    background-color: #f1c40f;
}
.form-control:focus {
	width:200px;
}
#pictureView{
	border-radius: 50%;
	border: 1px solid gray; 
	margin: 0px 20px 0px 0px;
	background-position: center;
	background-size: cover;
	background-repeat: no-repeat;
    display: inline-block;
    vertical-align: middle;
}
/* ul.main-menu li.selected { */
/* 	background-color: #f1c40f; */
/* } */
li.Myselected.active{
	color:#f1c40f;
}
.page-item.active .page-link, .btn-primary {
	z-index: 3;
    color: #fff;
    background-color: #2980b9;
    border-color: #2980b9;
}
.pagination>li>a:hover, .btn-primary:hover, .pagination>li>span:hover, .pagination>li>a:focus, .pagination>li>span:focus, .pagination>.active>a:hover, .pagination>.active>span:hover, .pagination>.active>a:focus, .pagination>.active>span:focus{
	background-color: rgb(135, 206, 250);
    border-color: rgb(135, 206, 250);
    color: #fff;
}
.sidebar-nav .metismenu ul a::before{
    content: '-';
    position: absolute;
    left: 19px;
}
.btn-primary, .btn-primary:focus {
    color: #fff;
    background-color: #2980b9;
    border-color: #2980b9;
}
.btn-primary:hover{
    background-color: rgb(54 159 223);
    border-color: rgb(54 159 223);
    box-shadow: 0 0 0 0px;
}
.btn.focus, .btn:focus{
    box-shadow: 0 0 0 0px;
}
body{
	font-family: S-CoreDream-4Regular;
}

</style>

</head>
<body class="theme-purple">

<!-- Page Loader -->
<div class="page-loader-wrapper">
    <div class="loader">
        <div class="m-t-30"><img src="<%=request.getContextPath() %>/resources/templates/assets/images/logo-icon.svg" width="48" height="48" alt="Lucid"></div>
        <p>Please wait...</p>        
    </div>
</div>
<!-- Overlay For Sidebars -->
<div id="wrapper">
    <div id="left-sidebar" class="sidebar">
        <div class="sidebar-scroll">
			<div class="navbar-brand">
	            <a href="<%=request.getContextPath() %>" style="color:white;font-weight: bold;"><small>관리자 페이지</small><br><strong>JoinWorkGW</strong></a>                
	        </div>
            <div class="user-account" >
				<c:if test="${ loginUser.empPicture != null}">
					<div id="pictureView" style="background-image:url('${pageContext.request.contextPath }/admin/emp/getPicture?picture=${ loginUser.empPicture}'); width: 80px; height: 80px;" class="rounded-circle avatar" ></div>
				</c:if>
				<c:if test="${ loginUser.empPicture == null}">
					<div id="pictureView" style="background-image:url('${pageContext.request.contextPath }/resources/image/NO_IMAGE.png'); width: 80px; height: 80px;" class="rounded-circle user-photo"></div>
				</c:if>
                <div class="dropdown" style="font-family: S-CoreDream-4Regular">
                    <span>반갑습니다,</span>
                    <a href="javascript:void(0);" class="dropdown-toggle user-name" data-toggle="dropdown"><strong>${loginUser.empName }&nbsp;님</strong></a>                    
                    <ul class="dropdown-menu dropdown-menu-right account animated flipInY">
                        <li><a href="<%=request.getContextPath()%>/common/home"><i class="icon-direction"></i>사용자 홈</a></li>
                        <li><a href="#"><i class="icon-envelope-open"></i>알림</a></li>
                        <li class="divider"></li>
                        <li><a href="<%=request.getContextPath()%>/common/logout"><i class="icon-power"></i>로그아웃</a></li>
                    </ul>
                </div>
                <hr>
            </div>
            <!-- Nav tabs -->
            <ul class="nav nav-tabs" style="font-family: InfinitySans-RegularA1">
                <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#hr_menu">관리자 메뉴</a></li>
            </ul>
                
            <!-- Tab panes -->
            <div class="tab-content p-l-0 p-r-0" style="font-family: InfinitySans-RegularA1">
                <div class="tab-pane animated fadeIn active" id="hr_menu">
                    <nav class="sidebar-nav">
                        <ul class="main-menu metismenu">
                            <li id="main"><a href="<%=request.getContextPath()%>/admin/main"><i class="icon-speedometer"></i><span>대시보드</span></a></li>
                            <li id="groupManage"><a href="#" class="has-arrow"><i class="icon-users"></i><span>조직 관리</span></a>
                                <ul value="thisisparent">
                                    <li id="emp"><a href="<%=request.getContextPath()%>/admin/emp/list">직원 관리</a></li>
                                    <li id="official"><a href="<%=request.getContextPath()%>/admin/official/list">직급 관리</a></li>
                                    <li id="dept"><a href="<%=request.getContextPath()%>/admin/dept/list">부서 관리</a></li>
                                </ul>
                            </li>
<!--                             <li id="doc"> -->
<!--                                 <a href="#" class="has-arrow"><i class="icon-credit-card"></i><span>전자결재 설정</span></a> -->
<!--                                 <ul> -->
<!--                                     <li><a href="#">결재 양식 조회</a></li> -->
<%--                                     <li><a href="<%=request.getContextPath()%>/admin/approval/registForm">결재 양식 등록</a></li>                                     --%>
<!--                                 </ul> -->
<!--                             </li> -->
                            <li id="menu">
                                <a href="<%=request.getContextPath()%>/admin/menu"><i class="icon-briefcase"></i><span>메뉴바 설정</span></a>
                            </li>
                            <li id="time">
                                <a href="<%=request.getContextPath()%>/admin/time"><i class="icon-bar-chart"></i><span>업무시간 설정</span></a>
                            </li>
                            <li id="resource">
                                <a href="#" class="has-arrow"><i class="icon-lock"></i><span>자원 관리</span></a>
                                <ul>
                                    <li id="loginlog"><a href="<%=request.getContextPath()%>/admin/resource/loginlog">로그인 기록 관리</a></li>
                                    <li id="errorlog"><a href="<%=request.getContextPath()%>/admin/resource/errorlog">에러 로그 관리</a></li>
                                    <li id="setting"><a href="<%=request.getContextPath()%>/admin/resource/setting">시스템 파일 설정</a></li>
                                </ul>
                            </li>
                        </ul>
                    </nav>
                </div>
                <!-- 서브메뉴 -->
                <div class="tab-pane animated fadeIn" id="setting">
                    <div class="p-l-15 p-r-15">
<!--                         <h6>제목입력</h6> -->
<!--                         <ul class="choose-skin list-unstyled"> -->
<!--                             <li data-theme="purple"> -->
<!--                                 <div class="purple"></div> -->
<!--                                 <span>Purple</span> -->
<!--                             </li>                    -->
<!--                         </ul> -->
<!--                         <hr> -->
                    </div>
                </div>             
            </div>          
        </div>
    </div>
	<!-- 메인 content -->
    <div id="main-content">
		<tiles:insertAttribute name="body" />       
    </div>
</div>

<!-- Javascript -->
<script src="${pageContext.request.contextPath }/resources/templates/light/assets/bundles/libscripts.bundle.js"></script>
<script src="${pageContext.request.contextPath }/resources/templates/light/assets/bundles/vendorscripts.bundle.js"></script>
             
<script src="${pageContext.request.contextPath }/resources/templates/light/assets/bundles/jvectormap.bundle.js"></script> <!-- JVectorMap Plugin Js -->
<script src="${pageContext.request.contextPath }/resources/templates/light/assets/bundles/morrisscripts.bundle.js"></script><!-- Morris Plugin Js -->
<script src="${pageContext.request.contextPath }/resources/templates/light/assets/bundles/knob.bundle.js"></script> <!-- Jquery Knob-->
<script src="${pageContext.request.contextPath }/resources/templates/assets/vendor/nestable/jquery.nestable.min.js"></script> <!-- Jquery Nestable -->
             
<script src="${pageContext.request.contextPath }/resources/templates/light/assets/bundles/mainscripts.bundle.js"></script>
<script src="${pageContext.request.contextPath }/resources/templates/light/assets/js/pages/ui/sortable-nestable.js"></script>

<script src="${pageContext.request.contextPath }/resources/templates/assets/vendor/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script><!-- bootstrap datepicker Plugin Js --> 
<script src="${pageContext.request.contextPath }/resources/templates/assets/vendor/bootstrap-multiselect/bootstrap-multiselect.js"></script>
<script src="${pageContext.request.contextPath }/resources/templates/assets/vendor/dropify/js/dropify.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/templates/light/assets/js/pages/forms/dropify.js"></script>

<!-- summernote -->
<script src="<%=request.getContextPath() %>/resources/templates/assets/vendor/summernote/dist/summernote.js"></script>

<!-- admin-common -->
<script src="<%=request.getContextPath() %>/resources/js/admin_common.js"></script>

<!-- websocket -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

<!-- common -->
<script src="${pageContext.request.contextPath }/resources/js/common.js"></script>

<script> // 메뉴바 변경 지속
cssManager();

$(document).ready(function (){
	connectWs('<c:url value="/echo-ws"/>');
	
	
	$('.metismenu li').on('click',function(){
// 		console.dir(this);
		checkMenuFocus(this);
	});
});

function checkMenuFocus(input){
// 	console.dir(input);
// 	console.dir(input.children[1]); // 오류메뉴는 ul.collapse , 정상메뉴는 ul.collapsing
// 	console.dir(input.children[1].attributes[1]); // 오류메뉴의 aria
// 	console.dir(input.children[1].attributes[0]); //오류메뉴는 value , 정상메뉴는 aria-expanded
// // 	console.dir($(input));
// 	console.log(input.children[1].attributes[0].value); //오류메뉴는 thisisparent , 정상메뉴는 열렸을 때 false 닫혔을 때 true
// 	console.log("----------------------------------------");
// 	if(input.children[1].attributes[1].name == 'aria-expanded'){
// 		input.children[1].attributes[1].value = false;
// 	}
	
}

function cssManager(){
	// 메뉴바 선택시 색깔 변경
	var menu = location.href.split('JoinWorkGW/')[1].split('/')[1];
	
	if(menu == 'emp' || menu == 'official' || menu == 'dept'){
		$('#groupManage').addClass('Myselected active');
	}
	$('#'+menu).addClass('Myselected active');
	
	
}
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="<%=request.getContextPath() %>/resources/image/logo.ico">
<title>:: JoinWorkGW :: Login</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
<meta name="description" content="Lucid Bootstrap 4x Admin Template">
<meta name="author" content="WrapTheme, design by: ThemeMakker.com">

<!-- VENDOR CSS -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/assets/vendor/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/assets/vendor/font-awesome/css/font-awesome.min.css">

<!-- MAIN CSS -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/light/assets/css/main.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/light/assets/css/color_skins.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/light/assets/fonts/font.css">

<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>

<style>
body{
	font-family: S-CoreDream-4Regular;
}

.header{
 		margin: 20px;
        padding: 20px 0px;
        text-align: center;
        text-transform: uppercase;
        font-family: "Arial Black", sans-serif;
        font-size: 60px;
        font-weight: bold;
}
.hiddenLoginBtn:hover { color : #323944 !important; }
.hiddenLoginBtn:focus { box-shadow : 0 0 0 0 ; }
</style>
</head>

<body class="theme-blue" >
	<!-- WRAPPER -->
	<div id="wrapper">
		<div class="vertical-align-wrap">
			<div class="vertical-align-middle auth-main">
				<div class="auth-box" style="display:inline-block;">
					<div class="card" >
                        <div class="header">
<!--                             <h4 style="font-weight: bold; text-shadow: 2px 2px 2px gray; ">JoinWork</h4> -->
								<h4 style="background-color: #449cff; 
									       color: #ffffff;
        								   text-shadow: 2px 8px 6px rgba(0,0,0,0.2), 0px -3px 20px rgba(255,255,255,0.4);
        								   height: 43px;
        								   font-size: 1.7rem;
        								   padding-top: 2.5px;
        								   box-shadow: 2px 2px 2px 2px #c0c0c0;		
        							he">JoinWork GW 
       							</h4>
                        </div>
                        <div class="body">
                            <form class="form-auth-small" name="loginForm" action="<%=request.getContextPath() %>/common/login" method="post">
                                <div class="form-group">
                                    <label for="signin" class="control-label sr-only">사원번호</label>
                                    <input type="id" class="form-control" id="ID" value="" name="empId" placeholder="ID">
                                </div>
                                <div class="form-group">
                                    <label for="signin-password" class="control-label sr-only">Password</label>
                                    <input type="password" class="form-control" id="password" value="" name="empPwd" placeholder="Password">
                                </div>
                                <button type="submit" class="btn btn-primary btn-lg btn-block" >로그인</button>
                                <div class="bottom">
                                </div>
                                
                                <!-- 간편 로그인 -->
                                <div style="color: #ffffff;">
                                	<select name="loginUser" onchange="login();" style="display: inline-block; float: left; width: 8em; height: 2em;">
                                		<option value="default">로그인</option>
                                		<option value="201006JW0206|ddit406!">김형민 사장</option>
                                		<option value="201006JW0202|ddit406!">변방길 부장</option>
                                		<option value="201006JW0201|ddit406!">민태원 부장</option>
                                		<option value="201006JW0204|950212">박지영 차장</option>
                                		<option value="201006JW0203|931212">장민수 과장</option>
                                		<option value="201006JW0205|123">윤종찬 대리</option>
                                		<option value="000802JW0002|720525">박서준 부장(관리자)</option>
                                	</select>
                                </div>
                            </form>
                        </div>
                    </div>
				</div>
				<div class="animated fadeIn" style="position: absolute;left: 700px;top: 40%;">
					<img src="<%=request.getContextPath() %>/resources/image/logo.ico" alt="logo" style="width:80px;">
					<strong style="font-size: 5.3em;color: black;vertical-align: middle;margin-left: 15px;
					 text-shadow: -3px 0 white, 0 2px white, 2px 0 white, 0 -3px white;">JoinWork GroupWare</strong>
				</div>
			</div>
		</div>
	</div>
	<!-- END WRAPPER -->
	<script>
	if('${msg}'){
		alert('${msg}');
	}
	
	function login(){
		var user = $('select[name="loginUser"]').val();
		var id = user.split('|')[0];
		var pass = user.split('|')[1];
		$('#ID').val(id);
		$('#password').val(pass);
		$('form[name="loginForm"]').submit();		
	}
	
	if(window.opener){
		window.close();
		opener.location.href="${pageContext.request.contextPath}";
	}
	
	</script>
</body>
</html>

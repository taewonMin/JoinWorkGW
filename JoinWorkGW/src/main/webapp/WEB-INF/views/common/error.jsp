<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<title>:: JoinWorkGW :: ${errorCode }</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">

<!-- VENDOR CSS -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/assets/vendor/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/assets/vendor/font-awesome/css/font-awesome.min.css">

<!-- MAIN CSS -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/light/assets/css/main.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/light/assets/css/color_skins.css">
</head>

<body class="theme-blue">
	<!-- WRAPPER -->
	<div id="wrapper">
		<div class="vertical-align-wrap">
			<div class="vertical-align-middle auth-main">
				<div class="auth-box">
                    <div class="top">
                        <img src="<%=request.getContextPath() %>/resources/templates/assets/images/logo-white.svg" alt="logo">
                    </div>
					<div class="card">
                        <div class="header">
                            <h3>
                                <span class="clearfix title">
                                    <span class="number left">${errorCode }</span> <span class="text">Oops! <br/>${errorMsg }</span>
                                </span>
                            </h3>
                        </div>
                        <div class="body">
                            <p>The page you were looking for could not be found, please <a href="javascript:void(0);">contact us</a> to report this issue.</p>
                            <div class="margin-top-30">
                                <a href="javascript:history.go(-1)" class="btn btn-default"><i class="fa fa-arrow-left"></i> <span>Go Back</span></a>
                                <a href="${pageContext.request.contextPath }/common/home" class="btn btn-primary"><i class="fa fa-home"></i> <span>Home</span></a>
                            </div>
                        </div>
                    </div>
				</div>
			</div>
		</div>
	</div>
	<!-- END WRAPPER -->
</body>
</html>
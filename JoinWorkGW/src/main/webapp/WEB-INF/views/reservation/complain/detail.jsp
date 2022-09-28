<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.card{
	padding-bottom: 30px;
}

.body{	
    padding-top: 15px;
    padding-left: 17px;
    padding-right: 17px;	
}

</style>

<body>

	<!-- 메인 content -->
	<div id="main-content">
		<div class="container-fluid" style="font-family: S-CoreDream-4Regular" >
			<div class="row clearfix" >
				<div class="col-12" style="margin-top: 2%; font-family: S-CoreDream-4Regular" >
					<h2 style="font-family: S-CoreDream-4Regular">
						<i class="icon-earphones-alt"></i>&nbsp;회의실 민원
						<button type="button" class="btn btn-secondary" onclick="window.close();"
							style="float: right;font-family: S-CoreDream-4Regular" > 
							<i class="icon-close"></i> <span>닫기</span>
						</button>
						
					</h2>
					<hr>
				</div>
			</div>
			<div class="div2">
				<div class="row clearfix">
					<div class="col-lg-12 col-md-12">
						<div class="card" style="padding-bottom:0px;">
							<div class="body project_report" style="width: 100%">
								<div>
									<strong>${complain.meetRoomId eq 'default' ? '공통' : complain.meetRoomId }</strong>
									<span> | ${complain.empName } ${complain.officialName }</span>
								</div>
								<hr>
								
								<!-- 내용 -->
								<div style="margin-top: 20px;">${complain.complainContent}</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>	
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<style>
.slash {
  background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg"><line x1="0" y1="100%" x2="100%" y2="0" stroke="gray" /></svg>');
}
#hiddenFillBtn:hover{
	color: #ffffff;
}
</style>

<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/common.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/assets/vendor/bootstrap/css/bootstrap.min.css">


    
<a id="viewModal" href="#defaultModal" data-toggle="modal" data-target="#defaultModal" style="display: none;"></a>  
<body>    
<!-- 메인 content -->
<div id="main-content">
	<a id="return-reason" href="#smallModal" data-toggle="modal" data-target="#smallModal" style="display: none;"></a>  
	<div class="container-fluid" style="margin-left: 20px;">
		<!-- 메인 content 넣는 곳 -->
		<div class="row clearfix">
			
			<div class="col-12" style="margin-top: 2%; margin-bottom: 3%; font-family: S-CoreDream-4Regular">
                    <h2>전자 결재 양식</h2>
            </div>
			<div class="btnWrapper col-12" style="margin-bottom: 10px;">
				<button type="button" class="btn btn-dark myBtn" style="width: 100px; opacity: 0.3;" onclick="review_go();">결재</button>
				<button type="button" class="btn btn-dark myBtn" style="width: 100px; opacity: 0.3;" onclick="return_go();">반려</button>
                <span onclick="toggleFileContent();" style="cursor: pointer; margin-left: 10px;"><i class="fa fa-sort-down" style="font-size: 25px;"></i></span>
                <c:if test="${historyVO.YN eq 'Y'}"> 
	                <span class="" style="position: relative;left: 465px;">
						<label class="checkbox-inline" for="emergency" style="cursor: pointer;"><strong>전결여부&nbsp&nbsp</strong><input id="allAgencyYN" type="checkbox" onchange="getCheckBoxYn();" style="position:relative;top: 3px; width: 17px;height: 17px;padding-top: 2px;cursor: pointer; border-radius: 3px;"></label>
					</span>
				</c:if>
				
			</div>
			<div class="col-10" id="fileContent" style="display: none; padding-left: 0;">
	            	<div class="card" style="margin-bottom: 10px; overflow-y: scroll; height: 300px; width: 840px; ">
			            <div class="body" style="padding: 0;">
			            	<div class="table-responsive" style="box-sizing: content-box;">
                                <table class="table table-hover center-aligned-table" style="margin-bottom: 0;">
                                    <thead>
	                                    <tr>
	                                        <th></th>
	                                        <th>타입</th>
	                                        <th>파일명</th>
	                                        <th>확장자</th>
	                                        <th>용량</th>
	                                        <th></th>
	                                        <th>다운로드 횟수</th>
	                                        <th></th>
	                                        <th></th>
	                                    </tr>
                                    </thead>
                                    
                                    <tbody id="appendTbody" style="overflow: scroll;">
                                    	<c:if test="${not empty approval.attachList }">
	                                    	<c:forEach items="${approval.attachList }" var="attach">
		                                    	<tr class="myFileLabels" style="cursor: pointer;" onclick="location.href='getFile?attachPath=${attach.attachPath }';">
			                                        <th></th>
			                                        <th style="padding-left:0;">
			                                       		<img alt="" src="<c:url value="/resources/exeImage/${attach.attachType}.png" />" width="30" />
			                                        </th>
			                                        <th><span style="padding-top: 10px;">${attach.attachName}</span></th>
			                                        <th><span style="padding-top: 10px;">${attach.attachType}</span></th>
			                                        <th><span style="padding-top: 10px;">${attach.attachVolume}</span></th>
			                                        <th></th>
			                                        <th></th>
			                                        <th></th>
			                                        <th></th>
			                                    </tr>
	                                    	</c:forEach>
                                    	</c:if>
	                                </tbody>
                                </table>
                            </div>
			            </div>
	            	</div>
			</div>
			
			
			
			
			<div class="inside-wrapper" style="border: 1px solid black; padding: 20px; border-radius: 1%;">
				<!--모달창 -->
	            <div class="modal fade" id="defaultModal" tabindex="-1" role="dialog">
				    <div class="modal-dialog" role="document">
				        <div class="modal-content" style="width:290px;">
				            <div class="modal-header" style="display: block; text-align: center;">
				                <h4 class="title" id="defaultModalLabel"></h4>
				            </div>
				            <div class="modal-body">
		                        <div class="body text-center">
		                            <div class="chart easy-pie-chart-1 user-photo" id="empPicture" style="width: 100px;height: 100px; border-radius: 50%;"></div>
		                            <h5 id="modalName"></h5>
		                            <h5 id="modalEmail"></h5>
		                            <h5 id="modalSt"></h5>
		                        </div>
				            </div>
				            <div class="modal-footer">
				                <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
				            </div>
				        </div>
				    </div>
				</div>
				
				${approval.approvalContent }
<%-- 			<%@ include file="docDetail_form.jsp" %> --%>
				
				<!-- 반려 이유 모달창 -->
				<div class="modal fade" id="smallModal" tabindex="-1" role="dialog">
				    <div class="modal-dialog modal-sm" role="document">
				        <div class="modal-content">
				            <div class="modal-header">
				                <h4 class="title" id="smallModalLabel">반려 이유</h4>
				            </div>
				            <div class="modal-body" > 
				            	<textarea id="reason-content" rows="10" cols="35" style="border: 0;"></textarea>
				             </div> 
				            <div class="modal-footer">
				            	<p>*반려이유는 기안자에게 전달됩니다.</p>
				                <button id="reason_y" type="button" class="btn btn-primary" onclick="reason_y();">확인</button>
				                <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="reason_n();">닫기</button>
				                <button id="modal-off" type="button" class="btn btn-danger" data-dismiss="modal" style="display: none;">닫기</button>
				            </div>
				        </div>
				    </div>
				</div>
			</div>
		</div>
	</div>
</div>
<iframe id="kakaoIframe" src="<%=request.getContextPath() %>/approval/kakaoMSG" style="display: none;"></iframe>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>
<script>

$("#vacationType option").eq(3).attr("selected",true);
$(".startDt").val("2021-05-11")
$(".endDt").val("2021-05-12")


function review_go(){
	if(!confirm("정말 결재 하시겠습니까?")){
		return false;
	}
	
	getSign();
	if($(".supEmpId")){
		getSlash();
	}
	
	if($("input:checkbox[id='allAgencyYN']").is(":checked")){
		getSlashAndMark();
	}
	
	var docId = '${approval.docId}';
	var content = $(".inside-wrapper").html();
	var title = $("#title").text();
	var obj = {};
	var receptionArr = [];
	var referArr = [];
	for(var i = 0; i < $(".refer").length; i++){
		referArr.push($(".refer").eq(i).attr("value"));
	}
	
	for(var i = 0; i < $(".reception").length; i++){
		receptionArr.push($(".reception").eq(i).attr("value"));
	}
	
	obj.approvalContent = content;
	obj.approvalTitle = title;
	obj.docId = docId;
	obj.receptionArr = receptionArr;
	obj.referArr = referArr;
	
	var empId = "";
	var docId = "";
	var myData;
	if($("input:checkbox[id='allAgencyYN']").is(":checked")){
		$.ajax({
			type:"POST",
			url:"<c:url value='approvalAllAgency'/>",
			contentType:"application/json",
		 	data : JSON.stringify(obj),
			processData:true,
			success: function(data) {
				console.log(data);
			},
			error: function(e) {
				console.log(e);
			}
		
		});
		alert('전결이 완료되었습니다.');
		opener.location.reload();
		window.close();
		
	}else{
		$.ajax({
			type:"POST",
			url:"<c:url value='approvalReview'/>",
			contentType:"application/json",
		 	data : JSON.stringify(obj),
			async:false,
			processData:true,
			success: function(data) {
				empId = data.empDrafterId;
				docId = data.docId;
				myData = data;
			},
			error: function(e) {
				console.log(e);
			}
		});
		
		//전자결재알림 
		$(myData).each(function(index){
			(function(index){
				sendMessage('${pageContext.request.contextPath}',
							empId,
							'새로운 결재 대기문서가 등록되었습니다. 확인해주세요.',
							$("#title").text(),
							'${pageContext.request.contextPath}/approval/waitDocDetail?docId='+docId,
							'전자결재');
			})(index);
		});
		
		if(window.opener){
			alert('검토가 완료되었습니다.');
			opener.location.reload();
			window.close();
			
		}else{
			alert('검토가 완료되었습니다.');
			location.href = "<%=request.getContextPath()%>/approval/main";
		}
	}
}


function return_go(){
	if(!confirm("정말 반려하시겠습니까?")){
		return false;
	}
	$("#return-reason").click();
	

}


function reason_y(){
	var reasonContent = $("#reason-content").val().trim();
	
	if(!reasonContent){
		alert("이유를 적어주세요.");
		return false;
	}
	$("#modal-off").click();
	
	$(".modal").remove();
	
	getReturnSign();
	if($(".supEmpId")){
		getSlash();
	}
	var content = $(".inside-wrapper").html();
	var docId = '${approval.docId}';
	var obj = {};
	
	obj.approvalCancelReason = reasonContent;
	obj.approvalContent = content;
	obj.docId = docId;
	
	$.ajax({
		type:"POST",
		url:"<c:url value='approvalReturn'/>",
		contentType:"application/json",
	 	data : JSON.stringify(obj),
		processData:true,
		success: function(data) {
			console.log(data);
		},
		error: function(e) {
			console.log(e);
		}
	});
	
	
	
	
	alert('반려가 완료되었습니다.');
	opener.location.reload();
	window.close();
}

function reason_n(){
	$("#reason-content").text("");
}


function getSign(){
	var imageURL = "getSign?sign=${loginUser.empId}.png";
	$('div#d${loginUser.empId}').css({'background-image':'url('+imageURL+')',
		'background-position':'center',
		'background-size':'contain',
		'background-repeat':'no-repeat'
	}).trigger("create");
	
	var tempDt = new Date();
	var year = tempDt.getFullYear();
	var month = ("0"+(tempDt.getMonth()+1)).slice(-2);
	var date = ("0"+tempDt.getDate()).slice(-2);
	var hours = ("0"+tempDt.getHours()).slice(-2);
	var minutes = ("0"+tempDt.getMinutes()).slice(-2);
	
	var sysDt = "<div style='height: 36px;'>"+year+"-"+month+"-"+date+" ["+hours+":"+minutes+"]</div>";
	
	$('div#d${loginUser.empId}').parent().append(sysDt);
}

function getSlash(){
	var supEmpId = $("div#d${loginUser.empId}").parent().parent().parent().find(".supEmpId").attr("value");
	if(supEmpId){
		$('div#d'+supEmpId+'').css("height","90px");
		$('div#d'+supEmpId+'').addClass("slash");
		$('div#d'+supEmpId+'').trigger("create");
	}
}

function getSlashAndMark(){
	var tempDt = new Date();
	var year = tempDt.getFullYear();
	var month = ("0"+(tempDt.getMonth()+1)).slice(-2);
	var date = ("0"+tempDt.getDate()).slice(-2);
	var hours = ("0"+tempDt.getHours()).slice(-2);
	var minutes = ("0"+tempDt.getMinutes()).slice(-2);
	var sysDt = "<div style='height: 36px;'>"+year+"-"+month+"-"+date+" ["+hours+":"+minutes+"]</div>";
	
	$("#결재").parent().parent().find("div").parent().css("padding-bottom","31px");
	$("#결재").parent().parent().find("div").html("<div style='font-size:30px;margin-bottom: 8px;'>전결</div>"+sysDt);
	
}


function getReturnSign() {
	var imageURL = "getReturnSign";
	$('div#d${loginUser.empId}').css({'background-image':'url('+imageURL+')',
		'background-position':'center',
		'background-size':'contain',
		'background-repeat':'no-repeat'
	}).trigger("create");
	
	var tempDt = new Date();
	var year = tempDt.getFullYear();
	var month = ("0"+(tempDt.getMonth()+1)).slice(-2);
	var date = ("0"+tempDt.getDate()).slice(-2);
	var hours = ("0"+tempDt.getHours()).slice(-2);
	var minutes = ("0"+tempDt.getMinutes()).slice(-2);
	
	var sysDt = "<div style='height: 36px;'>"+year+"-"+month+"-"+date+" ["+hours+":"+minutes+"]</div>";
	
	$('div#d${loginUser.empId}').parent().append(sysDt);
	
	
}


function empDetailModal(obj) {
	var empId = $(obj).attr("value");
	$.ajax({
		type:"POST",
		url:"<c:url value='/emp/getEmp'/>",
		contentType:"application/json",
	 	data : empId,
		processData:true,
		success: function(data) {
			var attendStName = data.attendStName;
			var deptName = data.deptName;
			var empEmail = data.empEmail;
			var empHp = data.empHp;
			var officialName = data.officialName;
			var empName = data.empName;
			var empId = data.empId;
			
			$("#defaultModalLabel").html(deptName);
			$("#modalName").html(empName+' '+officialName);
			$("#modalEmail").html(empEmail);
			$("#modalSt").html(attendStName);
			getPicture(empId);
			
		},
		error: function(e) {
			console.log(e);
		}
	});
	$("#viewModal").click();
}

function getPicture(empId){
	
	var imageURL = "/JoinWorkGW/emp/getPicture?picture="+empId+".jpg";
	$('div#empPicture').css({'background-image':'url('+imageURL+')',
		'background-position':'center',
		'background-size':'cover',
		'background-repeat':'no-repeat'
	}).trigger("create");
	
}


$(".referBtn").click(function(){
	console.log($(this).children("span"));
	empDetailModal($(this).children("span"));
});






</script>


<!-- 파일관련 -->
<script>
function toggleFileContent() {
	if($("#fileContent").css("display") === "none"){
		$("#fileContent").css("display","block");
		return false;
	}
	if($("#fileContent").css("display") === "block"){
		$("#fileContent").css("display","none");
		return false;
	}
}
</script>









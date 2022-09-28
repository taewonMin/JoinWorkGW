<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

    
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/common.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/assets/vendor/bootstrap/css/bootstrap.min.css">    
<body>    
<a id="viewModal" href="#defaultModal" data-toggle="modal" data-target="#defaultModal" style="display: none;"></a>
<a id="previewModal" href="#defaultModal" data-toggle="modal" data-target="#preModal" style="display: none;"></a>  
<!-- 메인 content -->
<div id="main-content">
	<div class="container-fluid" style="margin-left: 20px;">
		<!-- 메인 content 넣는 곳 -->
		<div class="row clearfix" >
			<div class="col-12" style="margin-top: 2%; margin-bottom: 3%; font-family: S-CoreDream-4Regular">
                    <h2 style="display: inline-block;">전자 결재 양식</h2>
                    <button onclick="inputContent();" class="float-right" type="button" style="background-color: white;color: white;border: white;">
                    	채우기 버튼
                    </button>
                    <br>
            </div>
			<div class="btnWrapper col-12" style="margin-bottom: 10px; font-family: S-CoreDream-6Bold">
				<button type="button" class="btn btn-dark myBtn" style="width: 100px; opacity: 0.3;" onclick="approval_go();">결재요청</button>
				<button type="button" class="btn btn-dark myBtn" style="width: 100px; opacity: 0.3;" onclick="approvalTemp_go();">임시저장</button>
				<button type="button" class="btn btn-dark myBtn" style="width: 100px; opacity: 0.3;" onclick="preview();">미리보기</button>
				<button type="button" class="btn btn-dark myBtn" style="width: 100px; opacity: 0.3;" onclick="window.close();" >취소</button>
				<button type="button" class="btn btn-dark myBtn" style="width: 100px; opacity: 0.3;" onclick='OpenWindow("approvalLine?docId=${approval.docId}", "결재선선택",1000,700);'>결재정보</button>
			</div>
			
			<div class="btnWrapper col-9" style="margin-bottom: 10px; font-family: S-CoreDream-6Bold">
				<div class="filebox"> 
					<button onclick="myFileUpload();" type="button" class="btn btn-dark myBtn" style="width: 100px; opacity: 0.3;">업로드</button>
					<span onclick="toggleFileContent();" style="cursor: pointer; margin-left: 10px;"><i class="fa fa-sort-down" style="font-size: 25px;"></i></span>
					<span class="" style="position: relative;left: 550px;">
						<label class="checkbox-inline" for="emergency" style="cursor: pointer;">
							<strong>긴급결재여부&nbsp&nbsp</strong>
							<input id="emergency" type="checkbox" style="position:relative;top: 3px; width: 17px;height: 17px;padding-top: 2px;cursor: pointer; border-radius: 3px;">
						</label>
					</span>
				</div>
			</div>
			
			<div class="col-10" id="fileContent" style="display: none; padding-left: 0;">
	            	<div class="card" style="margin-bottom: 10px; overflow-y: scroll; height: 300px; width: 840px; ">
			            <div class="body" style="padding: 0;">
			            	<div class="table-responsive" style="box-sizing: content-box;">
                                <table class="table center-aligned-table" style="margin-bottom: 0;">
                                    <thead>
	                                    <tr>
	                                        <th></th>
	                                        <th>타입</th>
	                                        <th>파일명</th>
	                                        <th>확장자</th>
	                                        <th>용량</th>
	                                        <th></th>
	                                        <th >상태</th>
	                                        <th class="deleteAllFile" style="cursor: pointer;">
	                                        	<i class="fa fa-trash-o"></i>
											</th>
	                                        <th></th>
	                                    </tr>
                                    </thead>
                                    
                                    <tbody id="appendTbody" style="overflow: scroll;">
                                    
                                    
	                                </tbody>
                                </table>
                            </div>
			            </div>
	            	</div>
			</div>
			
			
			<div class="inside-wrapper" style="border: 1px solid black; padding: 20px; border-radius: 1%;">
				<!--미리보기 모달창 -->
	            <div class="modal fade" id="preModal" tabindex="-1" role="dialog">
				    <div class="modal-dialog" role="document">
				        <div class="modal-content" style="width:900px; height:900px; overflow-y:scroll " >
				            <div class="modal-header" style="display: block; text-align: center;">
				                <h4 class="" id="">미리보기</h4>
				            </div>
				            <div class="modal-body">
		                        <div class="body text-center" id="previewInnerHtml">
		                        
		                        </div>
				            </div>
				            <div class="modal-footer">
				                <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
				            </div>
				        </div>
				    </div>
				</div>
				
				<!--직원상세 모달창 -->
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
				<div id="docContent">
					${approval.approvalContent }
				</div>
				
			</div>
		
		</div>
		
	</div>
</div>



<form:form commandName="approval" method="POST" id="fileUploadForm" name="registForm" enctype="multipart/form-data" cssStyle="display: none;">
	<form:input path="docId" type="text" id="fileDocId" cssStyle="display: none;" />
</form:form>
<iframe id="kakaoIframe" src="<%=request.getContextPath() %>/approval/kakaoMSG" style="display: none;"></iframe>


<input id="kakaoSendBtn" type="button" onClick="sendLinkDefault();" value="Default" style="display: none;"/>

<script type="text/JavaScript" src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>
<!-- 카카오톡 보내는 스크립트 -->


<script>
var myIp = '192.168.46.21';


$(".myBtn").hover(function(event){
	event.stopPropagation();
	$(this).css("opacity","");
	$(this).css("color","white");
	}, function(){
	$(this).css("opacity","0.3");
});

$(document).on("click",".referBtn",function(){
	if(confirm("삭제하시겠습니까?")){
		$(this).remove();
	}
	
});

//임시저장
function approvalTemp_go(){
	var jsonData = {};
	jsonData.docId =  '${approval.docId}';
	jsonData.approvalContent = $(".inside-wrapper").html();
	jsonData.approvalTitle = $("#title").text();
	
	console.log($("#title").text());
	
	if(!$("#title").text().trim()){
		alert("제목을 입력하셔야 합니다.");
		return false;
	}
	
	
	$.ajax({
		type:"POST",
		
		url:"<c:url value='modifyApprovalTemp'/>",
		contentType:"application/json",
		processData:true,
	 	data : JSON.stringify(jsonData),
		success: function(data) {
		},
		error: function(e) {
			console.log(e);
		}
	});
	alert("임시저장이 완료 되었습니다.");
	opener.location.reload();
}

//기안
function approval_go() {
	
	
	if(!$("table").hasClass("lineTable")){
		alert("결재자 없이는 결재요청을 할 수 없습니다.");
		return false;
	}
	
	if(!$("#title").text().trim()){
		alert("결재 제목을 입력해주세요.");
		return false;
	}
	
	if(!confirm("정말 결재요청을 하시겠습니까?")){
		return false;
	}
	
	var jsonData = {};
	var agencyObj = {};
	var agencyArr = [];
	//사인
	getSign();
	
	//문서 수정불가능하게 막아놓음
	$("td").attr("contenteditable",false);
	$("div").attr("contenteditable",false);
	$("#vacationType").attr("disabled",true);
	$(".startDt").attr("readonly",true);
	$(".endDt").attr("readonly",true);
	$("input").attr("readonly",true);
	$("textarea").attr("readonly",true);
	
	//ajax 날릴 data
	jsonData.apply = $("#신청").attr("value");
	jsonData.review = $("#검토").attr("value");
	jsonData.approval = $("#결재").attr("value");
	jsonData.docId =  $("#docId").text();
	jsonData.title = $("#title").text();
	jsonData.content = $(".inside-wrapper").html();
	
	if($("#emergency").prop("checked")){//긴급결재시
		jsonData.approvalEmergencyYn = 'Y';
	}
	
	var agencyLength =  $(".대결").length;
	
	for(var i = 0; i < agencyLength; i++){
		agencyObj.agencyEmpId = $(".대결").eq(i).attr("value");
		agencyObj.agencySupId = $(".supEmpId").eq(i).attr("value");
		agencyArr.push(agencyObj);
		agencyObj = {};
	}
	jsonData.agencyArr = agencyArr;
	
	var docId = "";
	var empId = "";
	var myData;
	$.ajax({
		type:"POST",
		url:"<c:url value='registApproval'/>",
		contentType:"application/json",
		processData:true,
		async:false,
	 	data : JSON.stringify(jsonData),
		success: function(data) {
			docId = data.docId;
			empId = data.empDrafterId;
			myData = data;
		},
		error: function(e) {
			console.log(e);
		}
	});
	
	for(var i = 0; i < $("input[name='fileUploadCommand.uploadFile']").length; i++){
		
		if(!$("input[name='fileUploadCommand.uploadFile']").eq(i)[0].files[0]){
			$("input[name='fileUploadCommand.uploadFile']").eq(i).remove();
		}
	}
	
	var form = $('#fileUploadForm')[0];
	var uploadFiles = new FormData(form);
	$("#fileDocId").val($("#docId").text());
	
	if($('#fileUploadForm').find("input").length > 1){
		$.ajax({
			type:"POST",
			url:"<c:url value='registApprovalAttach'/>",
			processData: false,  
			contentType: false,
		 	data : uploadFiles,
			success: function(data) {
				console.log(data);
			},
			error: function(e) {
				console.log(e);
			}
		});
	}
	
	
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
	
	
	//모바일 전자결재 
	var title = "결재문서가 도착했습니다.";
	var url = "http://"+myIp+"/JoinWorkGW/approval/waitDocDetail?docId="+docId+""
	if(empId === '201006JW0203'){	
		$("#kakaoIframe").get(0).contentWindow.getFriends();
		setTimeout(function(){
			var token = $('#kakaoIframe').contents().find("div").eq(0).parent().find("button").attr("onclick");
			token = token.split("'")[1];
			$("#kakaoIframe").get(0).contentWindow.sendMessage(token,title,url);
		}, 1000);
		setTimeout(function(){
			if(window.opener){
				alert('기안이 완료되었습니다.');
				opener.location.reload();
				window.close();
				return false;
				
			}else{
				alert('기안이 완료되었습니다.');
				location.href = "<%=request.getContextPath()%>/approval/main";
				window.close();
				return false;
			}
			
		},1000);
	}else{
		if(window.opener){
			alert('기안이 완료되었습니다.');
			opener.location.reload();
			window.close();
			return false;
			
		}else{
			alert('기안이 완료되었습니다.');
			location.href = "<%=request.getContextPath()%>/approval/main";
			return false;
		}
	}
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




function selectOption() {
	if($("#vacationType option:selected") != null){
		$("#vacationType option").removeAttr("selected");
	}
	$("#vacationType option:selected").attr("selected","selected");
}

$(".startDt").change(function(){
	var startDt = $(".startDt").val();
	$(".startDt").attr("value",startDt);
});

$(".endDt").change(function(){
	var startDt = $(".endDt").val();
	$(".endDt").attr("value",startDt);
});

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

function preview(){
	$("#previewInnerHtml").html("");
	$("#previewInnerHtml").html($("#docContent").html());
	
	$("#previewModal").click();
	
	$("#previewInnerHtml #title").attr("id","");
	$("#previewInnerHtml td").attr("contenteditable",false);
	$("#previewInnerHtml div").attr("contenteditable",false);
	$("#previewInnerHtml #vacationType").attr("disabled",true);
	$("#previewInnerHtml .startDt").attr("readonly",true);
	$("#previewInnerHtml .endDt").attr("readonly",true);
	$("#previewInnerHtml input").prop("disabled",true);
	$("#previewInnerHtml textarea").prop("disabled",true);
	
	$(".startDt").val("2021-05-11");
	$(".endDt").val("2021-05-12");
	
	
}





</script>


<!-- file 관련 스크립트 -->
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
var fileLength = 0;
var fileValue = 0;
function myFileUpload() {
	$("#fileContent").css("display","block");
	//빈 파일 테그면 사쿠죠
	for(var i = 0; i < $("input[name='fileUploadCommand.uploadFile']").length; i++){
		
		if(!$("input[name='fileUploadCommand.uploadFile']").eq(i)[0].files[0]){
			$("input[name='fileUploadCommand.uploadFile']").eq(i).remove();
		}
	}
	
	var input = $('<input>').attr({"type":"file","name":"fileUploadCommand.uploadFile","class":"myFile","value":fileValue+""});
	$("#fileUploadForm").append(input);
	
	fileLength = $("input[name='fileUploadCommand.uploadFile']").length;
	
	$("input[name='fileUploadCommand.uploadFile']").eq(fileLength-1).click();
}

$(document).on("change",".myFile",function(){
	var _fileLen = $("input[name='fileUploadCommand.uploadFile']").eq(fileLength-1)[0].files[0].name.length;
    var _lastDot = $("input[name='fileUploadCommand.uploadFile']").eq(fileLength-1)[0].files[0].name.lastIndexOf('.');


	var name = $("input[name='fileUploadCommand.uploadFile']").eq(fileLength-1)[0].files[0].name.substring(0, _lastDot);
	var extension = getExtensionOfFilename($("input[name='fileUploadCommand.uploadFile']").eq(fileLength-1)[0].files[0].name);
	var size = ($("input[name='fileUploadCommand.uploadFile']").eq(fileLength-1)[0].files[0].size)/1000 + "KB";
	
	
	setTimeout(function(){
		if(!(extension == 'png' || extension == 'doc' || extension == 'exe' || extension == 'gif' || extension == 'java' || extension == 'jpg' || extension == 'pdf'|| extension == 'ppt'|| extension == 'txt' || extension == 'xlsx'|| extension == 'zip')){
			alert("지원하지 않는 파일 형식입니다.");
			$("input[name='fileUploadCommand.uploadFile']").eq(fileLength-1).remove();
			return false;
		}
		
		var fileLabel = "";
		
		fileLabel += '<tr class="myFileLabels">';
		fileLabel += '    <td></td>';
		fileLabel += '    <td style="padding-left:0;"><img alt="" src="<c:url value="/resources/exeImage/'+extension+'.png" />" width="30" /></td>';
		fileLabel += '    <td>'+name+'</td>';
		fileLabel += '    <td>'+extension+'</td>';
		fileLabel += '    <td>'+size+'</td>';
		fileLabel += '    <td></td>';
		fileLabel += '    <td></td>';
		fileLabel += '    <td class="deleteFile" value="'+fileValue+'" style="cursor: pointer;"><i class="fa fa-trash-o"></i></td>';
		fileLabel += '</tr>';
		fileValue++;
		$("#appendTbody").append(fileLabel);
		$("#appendTbody").trigger("create");	
		
     },50);
	
});

//파일 확장자 추출 함수
function getExtensionOfFilename(filename) {
	 
    var _fileLen = filename.length;
 
    var _lastDot = filename.lastIndexOf('.');
 
    var _fileExt = filename.substring(_lastDot+1, _fileLen).toLowerCase();
 
    return _fileExt;
}

$(".deleteAllFile").click(function(){
	$(".myFileLabels").remove();
	$(".myFile").remove();
})

$(document).on("click",".deleteFile",function(){
	var fileNumber = parseInt($(this).attr("value"));
	console.log(fileNumber);	
	console.log($(".myFile[value="+fileNumber+"]"));	
	$(".myFile[value="+fileNumber+"]").remove();
	$(this).parent().remove();
	
});
	





</script>

<!-- 내용채워넣는 버튼 -->
<script>
if(location.href.split("from=")[1] == 'temp'){
	$(".startDt").val("2021-05-11");
	$(".endDt").val("2021-05-12");
}


function inputContent(){
	$("#previewInnerHtml").html("");
	var formId = location.href.split("formId=")[1];
	if(formId == "111"){
		$("#title").html("맡은 프로젝트가 종료되어 휴가신청드립니다.");
		$("#myContents").html("프로젝트가 마무리되어 휴가 신청 올립니다. 결재해주시면 감사하겠습니다.")
		$("#vacationType option").eq(3).attr("selected",true);
		$(".startDt").val("2021-05-18");
		$(".endDt").val("2021-05-21");
	}
	if(formId == "104" || formId == "103"){
		$("#title").html("최신 노트북 추가구매");
		$("#content1").html("홍길동");
		$("#content2").html("2021-05-11");
		$("#content3").html("20210511-101");
		$("#content4").html("042-732-2555");
		$("#content5").html("대전 대덕인재개발원");
		
		$("#content6").html("개발용");
		$("#content7").html("042-732-2556");
		$("#content8").html("2021-05-20");
		
		$("#content9").html("갤럭시북 Pro 360");
		$("#content10").html("중");
		$("#content11").html("개");
		$("#content12").html("3");
		$("#content13").html("100만원");
		$("#content14").html("300만원");
		$("#content15").html("300만원");
		
		$("#content40").html("갤럭시 북 Ion");
		$("#content17").html("중");
		$("#content18").html("개");
		$("#content19").html("3");
		$("#content20").html("90만원");
		$("#content21").html("270만원");
		$("#content22").html("270만원");
		
		$("#content39").html("노트북 Plus");
		$("#content24").html("중");
		$("#content25").html("개");
		$("#content26").html("4");
		$("#content27").html("80만원");
		$("#content28").html("320만원");
		$("#content29").html("320만원");
		
		$("#content38").html("갤럭시 북 S");
		$("#content31").html("중");
		$("#content32").html("개");
		$("#content33").html("2");
		$("#content34").html("110만원");
		$("#content35").html("220만원");
		$("#content36").html("220만원");
		
		$("#content41").html("노트북 오디세이");
		$("#content42").html("중");
		$("#content43").html("개");
		$("#content44").html("3");
		$("#content45").html("120만원");
		$("#content46").html("360만원");
		$("#content47").html("360만원");
		
		$("#content49").html("1470만원");//합계
		$("#content50").html("<span style='font-size: 20px !important;'>현재 사용중인 노트북의 성능 저하로 인해 프로젝트 지연된 상황</span> "+"<br>"+"<span style='font-size: 20px !important;'>긴급하게 추가 구매필요</span>");//구체적사유
		$("#content51").html("<span style='font-size: 20px !important;'>민태원 부장님은 핑크색 노트북을 선호하셔서 핑크색으로 주문!!!!</span>");//특이사항
		
	}
	
}
</script>














</body>
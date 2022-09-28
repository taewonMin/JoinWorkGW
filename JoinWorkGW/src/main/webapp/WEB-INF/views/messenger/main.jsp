<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    

<style>
	div.statusBar {
		background-color: #2980b9;
		width: 70px;
		height: 100vh;
		float: left;
	}
	ul.chatList li {
		padding: 10px 15px;
		margin: 0px !important;
	}
	ul.chatList li:hover {
		background-color: rgb(232, 241, 243, 0.95);
	}
	#pictureView{
		border-radius: 50%;
		border: 1px solid gray; 
		background-position: center;
		background-size: cover;
		background-repeat: no-repeat;
		cursor: pointer;
	}
</style>
<body>

<!-- status bar -->
<div class="statusBar">
	 <div class="user-account" style="margin:0px;padding-top:15px;text-align: center;">
	
		<!-- 프로필 사진 -->
  		<div id="pictureView" style="margin:0px 0px 15px 6px;background-image:url('${pageContext.request.contextPath }/emp/getPicture?picture=${ loginUser.empPicture}'); width: 55px; height: 55px;" class="rounded-circle avatar"></div>
		<!-- 알림 아이콘 -->
		<a href="javascript:void(0);">
        	<span style="color:white;"><i class="fa fa-bell fa-2x" aria-hidden="true" style="display: block;"></i></span>
        </a>
        
        <!-- 메신저 -->
        <a href="main">
        	<span style="color:white;"><i class="fa fa-comment fa-2x" aria-hidden="true" style="margin-top:15px;"></i></span>
        </a>
	</div>
</div>



<!-- 채팅화면 -->
            <div class="row clearfix" style="height:100vh;">
                <div class="card chat_app" style="border-radius: 0px;background-color:white;height:100vh;">
                    <div class="people_list" style="height:100vh;border-right:1px solid rgb(0,0,0,0.1);padding:0px;">
	                    <!-- 검색 버튼 -->
	                    <div class="input-group" style="padding:15px 15px 0 15px;">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="background-color: white;border-right: none;"><i class="icon-magnifier"></i></span>
                            </div>
                            <input type="text" class="form-control" placeholder="검색어" style="border-left: none;">
                        </div>
                        <!-- 대화방 목록 -->
                        <ul class="list-unstyled chat-list mt-3 mb-0 chatList" style="height:90vh;overflow-y: auto;">
                        	<c:forEach items="${myDeptList }" var="emp">
	                            <li data-id="${emp.empId }" data-name="${emp.empName }" data-picture="${emp.empPicture }" onclick="showChatContent(this);">
	                            	<div id="pictureView" style="display:inline-block;float:left;background-image:url('${pageContext.request.contextPath }/emp/getPicture?picture=${ emp.empPicture}'); width: 55px; height: 55px;" class="rounded-circle avatar"></div>
	                                <div class="about" style="margin-top:5px;">
	                                    <div class="name">${emp.empName }</div>
	                                    <div class="status"> <i class="fa fa-circle offline"></i> left 7 mins ago </div>                                            
	                                </div>
	                            </li>
                        	</c:forEach>
                        </ul>
                    </div>
                    <div class="chat" style="height:100vh;">
                    	<div class="chatView" style="height: 100vh;padding: 45% 0px;text-align: center;font-size: 1.5em;">
                    		우측 사용자를 클릭해 채팅 내용을 확인하세요.
                    	</div>
                    	<c:forEach items="${myDeptList }" var="emp">
                    		<div id="room_${emp.empId }" class="chatView" style="display:none;">
		                        <div class="chat-header clearfix">
		                            <div class="row">
		                                <div class="col-lg-6">
		                                    <div id="pictureView" class="detailEmpPicture_${emp.empId }" style="display:inline-block;float:left;width: 55px; height: 55px;" class="rounded-circle avatar"></div>
		                                    <div class="chat-about m-t-10">
		                                        <h6 class="m-b-0" id="detailEmpName_${emp.empId }"></h6>
		                                        <small id="detailEmpTime_${emp.empId }">Last seen: 2 hours ago</small>
		                                    </div>
		                                </div>
		                                <div class="col-lg-6 hidden-sm text-right">
		                                    <a href="javascript:void(0);" class="btn btn-sm btn-outline-info"><i class="icon-settings"></i></a>
		                                </div>
		                            </div>
		                        </div>
		                        <div class="chat-history clearfix" style="height:70vh;overflow-y:auto;">
		                            <ul class="m-b-0">
		                            	<!-- 채팅 내용 -->
		                            </ul>
		                        </div>
		                        <div class="chat-message clearfix" style="border-top:2px solid rgb(0,0,0,0.1);">
		                        	<div class="input-group mb-0">
			                       		<textarea id="chatContent_${emp.empId }" rows="5" style="font-size: 1.2em;width:90%;resize: none;border:none;outline:none;"></textarea>
			                       		<div style="width:10%;text-align: center;">
			                       			<input type="hidden" name="receiverId">
			                       			<input type="hidden" name="receiverName">
			                       			<button type="button" class="btn btn-primary btn-block" style="margin-left:10px;" onclick="sendChatMessage();">전송</button>
			                       		</div>
		                            </div>
		                        </div>
                    		</div>
                    	</c:forEach>
                    </div>
                </div>
            </div>

<script type="text/javascript">
// 로그아웃후 창 닫기
function logoutCloseWindow(){
	window.opener.location.href="<%=request.getContextPath()%>";
	window.close();
}

// textarea 크기 자동조절
// function adjustHeight(){
// 	var textEle = $('textarea');
// 	  	textEle[0].style.height = 'auto';
//   	var textEleHeight = textEle.prop('scrollHeight');
//   	textEle.css('height', textEleHeight);
// }

// 채팅내용 보이기
function showChatContent(obj){
	// 클릭된 프로필 배경색 변경
	$('.chat-list li').css('background-color','white');
	$(obj).css('background-color','#e8f1f3');
	
	var empId = $(obj).attr('data-id');
	var empName = $(obj).attr('data-name');
	var empPicture = $(obj).attr('data-picture');
	
	$('.detailEmpPicture_'+empId).css('background-image','url("${pageContext.request.contextPath }/emp/getPicture?picture='+empPicture+'")');
	$('#detailEmpName_'+empId).text(empName);
	
	// 수신자 정보 세팅
	$('input[name="receiverId"]').val(empId);
	$('input[name="receiverName"]').val(empName);
	
	// 뷰 전환
	$('.chatView').css('display','none');
	$('#room_'+empId).css('display','');
}

// 채팅 전송
function sendChatMessage(){
	var receiverId = $('input[name="receiverId"]').val();
	var receiverName = $('input[name="receiverName"]').val();
	var senderId = '${loginUser.empId}';
	
	var content = $('textarea#chatContent_'+receiverId).val();
	var today = new Date();
	var hour = today.getHours();
	var minute = today.getMinutes();
	minute = minute < 10 ? '0'+minute : minute;
	var ampm = hour >= 12 ? '오후' : '오전';
	hour = hour % 12 ? hour % 12 : 12;
	
	
	var chat = '<li class="clearfix">'
			  	+'<div class="message-data text-right">'
			  		+'<span class="message-data-time">'+ampm+' '+hour+':'+minute+'</span>'
			  	+'</div>'
			  	+'<div class="message float-right" style="max-width:500px;background-color: #e8f1f3;word-break: break-word;">'+content+'</div>'
			  +'</li>';
	$('#room_'+receiverId+' .chat-history ul').append(chat);
	$('textarea#chatContent_'+receiverId).val("");
	$('textarea#chatContent_'+receiverId).focus();
	$('#room_'+receiverId+" .chat-history").scrollTop($('#room_'+receiverId+" .chat-history")[0].scrollHeight);
	socket.send('[채팅],'+receiverId+','+receiverName+','+senderId+','+content);
} 
</script>

</body>

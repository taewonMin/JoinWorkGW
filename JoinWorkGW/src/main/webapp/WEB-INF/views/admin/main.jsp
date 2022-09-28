<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
.chat-list .loginUserList:hover {
	background-color:#f1f1f1;
}
.input-group-text:hover {
	cursor: pointer;
}
.noticeFormGroup{
	min-width: 100%;
}
.hiddenFillBtn:hover{ background-color: #ffffff; }
</style>

<div class="container-fluid">
	<div class="row clearfix">
	    <div class="col-lg-8 col-md-12">
	    
	    	<div class="card" style="margin-bottom:15px; ">
                <div class="body" style="font-family: S-CoreDream-6Bold">
                    <div class="row clearfix" >
                        <div class="col-6" style="font-family: S-CoreDream-4Regular">
                           <div class="head">
                              <h5>사내공지
                                 <span class="float-right" style="cursor: pointer;" onclick="location.href='<%=request.getContextPath()%>/board/notice/list'">
                                    <i class="fa fa-sign-in"></i>
                                 </span>
                              </h5>
                           </div>
                            <div class="table-responsive" style="overflow:hidden;">
                                 <table class="table table-hover m-b-0 c_list">
                                     <thead>
                                         <tr>
                                             <th>게시날짜</th>
                                             <th>제목</th>
                                             <th>작성자</th>
                                             <th>조회수</th>
                                         </tr>
                                     </thead>
                                     <tbody style="cursor: pointer;">
                                     	<c:if test="${!empty noticeList}">
                                       		<c:forEach items="${noticeList}" var="notice">
                                          		<tr onclick="OpenWindow('<%=request.getContextPath()%>/board/notice/detail?noticeId=${notice.noticeId }', '글 상세보기', 800, 700);">
                                               	<td><fmt:formatDate value="${notice.noticeCreateDt}" pattern="yyyy-MM-dd"/></td>
                                              		<td><span style="display: inline-block;font-weight: bold;max-width: 155px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">
                                              			<c:if test="${notice.noticeImportantYN eq 'Y'}">
                                               			<span class="badge badge-danger">필독</span>
                                              			</c:if>
                                              			${notice.noticeTitle}</span></td>
                                                   	<td><span>${notice.empName}&nbsp;${notice.officialName}</span></td>
                                                   	<td><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${notice.noticeReadcnt}</span></td>
                                               </tr>
                                       		</c:forEach>
                                       	</c:if>
                                        
                                       	<c:if test="${empty noticeList}">
                                       		<tr>
                                           		<td colspan="6" style="text-align: center;"><strong>사내공지가 존재하지 않습니다.</strong></td>
                                           </tr>
                                       	</c:if>
                                     </tbody>
                                 </table>
                             </div>
                        </div>
                        <div class="col-6"  style="font-family: S-CoreDream-4Regular">
                        		<div class="head">
                             <h5>민원함
                                 <span class="float-right" style="cursor: pointer;" onclick="location.href='${pageContext.request.contextPath}/reservation/adminMain';">
                                 	<i class="fa fa-sign-in"></i>
                                 </span>
                             </h5>
                           </div>
                           <div class="table-responsive" style="overflow: hidden;">
                               <table class="table table-hover m-b-0 c_list">
                                   <thead>
                                       <tr>
                                           <th>날짜</th>
                                           <th>제목</th>
                                           <th>작성자</th>
                                       </tr>
                                   </thead>
                                   <tbody style="cursor: pointer;">
                                   <!-- 민원 리스트 출력 -->
                                   		<c:if test="${!empty complainList}">
                                       		<c:forEach items="${complainList}" var="complain">
                                          		<tr onclick="OpenWindow('${pageContext.request.contextPath}/reservation/complain/detail?complainId=${complain.complainId}','민원상세창',500,400);">
                                               		<td>${complain.complainCreateDate}</td>
                                              		<td><span style="display: inline-block;font-weight: bold;max-width: 200px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">
                                              			<c:if test="${complain.complainId == 161}"><span class="badge badge-danger">New</span></c:if>${complain.complainContent}</span>
                                            		</td>
                                                   	<td><span>${complain.empName}&nbsp;${complain.officialName}</span></td>
                                               	</tr>
                                       		</c:forEach>
                                       	</c:if>
                                        
                                       	<c:if test="${empty complainList}">
                                       		<tr>
                                           		<td colspan="3" style="text-align: center;"><strong>민원이 존재하지 않습니다.</strong></td>
                                           </tr>
                                       	</c:if>
                                   </tbody>
                               </table>
                           </div>
                        </div>
                     </div>
                 </div>
             </div>
	        
          <div class="card">
              <div class="header" style="font-family: S-CoreDream-4Regular">
                  <h5>공지글 작성</h5>
                  <button type="button" class="btn hiddenFillBtn" onclick="presentationFill_1();" style="position:absolute;right:0px;top:0px;color:#ffffff">시연용버튼 1</button>
              </div>
              <div class="body" style="padding-top:0px;">
              	<form name="noticeRegistForm" method="post">
              		<input type="hidden" name="noticeVO.noticeContent">
              		<input type="hidden" name="noticeVO.empWriterId" value="${loginUser.empId }">
              		<input type="hidden" name="noticeVO.noticeUpdaterId" value="${loginUser.empId }">
             		<div class="row clearfix" style="font-family: S-CoreDream-6Bold;">
                     	<!-- 게시판 선택 -->
                       <div class="col-md-3">
                           <label>분류</label>
                           <div class="form-group">                                        
                               <select id="selectBoard" class="form-control noticeFormGroup" onchange="changeCategory(this);">
                                   <option value="default">-- 분류 선택 --</option>
                                   <option value="notice">사내공지</option>
                                   <option value="emergency">긴급공지</option>
                                   <option value="meetroom">회의실이슈</option>
                               </select>
                           </div>
                       </div>
                       
                       <!-- 본문 -->
                       <div class="col-md-3 col-sm-12">
                           <label class="boardWriter">작성자</label>
                           <div class="form-group">
                               <input type="text" readonly class="form-control noticeFormGroup" placeholder="" value="${loginUser.empName }" >
                           </div>
                       </div>
                       <div class="col-md-3 col-sm-12 formGroup noticeForm" style="display:none;">
                           <label>필독여부</label>
                           <div class="form-group">
                              	<select name="noticeVO.noticeImportantYN" id="selectNoticeYN" class="form-control noticeFormGroup">
                              		<option value="N">일반</option>
                              		<option value="Y">필독</option>
                              		<option value="E" style="display:none;">긴급</option>
                              	</select>
                           </div>
                       </div>
                       
                       <div class="col-sm-12">
                           	<div class="form-group">
                           	<label class="boardTitle">제목</label>
                           		<span class="formGroup emergencyForm" style="color:red;margin-left:15px;display:none;">* 긴급공지는 사용자 메뉴 하단에 고정되어 나타납니다.</span>
                               	<input type="text" name="noticeVO.noticeTitle" id="emergencyInput" class="form-control noticeFormGroup" style="max-width: 100%;" placeholder="">
                           	</div>
                       </div>
                       
                       <div class="col-sm-12 formGroup emergencyForm" style="display:none;">
                           	<div class="form-group">
                           	<label>현재 등록된 긴급공지</label>
                           		<a href="javascript:void(0);" id="removeEmergencyBtn" onclick="removeEmergency();" style="margin-left:10px;<c:if test="${empty emergency }">display:none;</c:if>"><i class="fa fa-trash-o"></i> 삭제</a>
                               	<input type="text" id="emergencyTitle" readonly="readonly" class="form-control noticeFormGroup" style="max-width: 100%;" placeholder="등록된 긴급공지가 없습니다. (긴급공지는 하나만 유지됩니다.)" value="${emergency.noticeTitle }">
                           	</div>
                       </div>
                  </div>
                  
                  <!-- 내용 입력 -->                          
                  <div class="col-sm-12 formGroup defaultForm noticeForm meetroomForm" style="padding:0px; font-family: S-CoreDream-4Regular">
                      <div class="summernote" style="height: 200px; "></div>
                  </div>
                  
                  <div class="m-t-10">
	                  <button type="button" class="btn btn-primary float-right" style="width:100px;font-family: S-CoreDream-6Bold;" onclick="registNotice();">등록</button>
	                  <button type="reset" onclick="resetBtn();" class="btn btn-dark float-right" style="margin-right:10px;font-family: S-CoreDream-6Bold;"><i class="fa fa-refresh"></i> <span>초기화</span></button>
	                  <div style="clear: both;"></div>
                  </div>
                </form>
             </div>
          </div>
	    </div>
	    
	    
	    <!-- 우측 메뉴 -->
	    <div class="col-lg-4 col-md-12 right-box" style="padding-left:0px; ">
	        <div class="card" style="margin-bottom:15px; font-family: S-CoreDream-6Bold">
	        	<div class="body">
                    <div class="row clearfix" style="margin-bottom:15px;">
                    	<div class="col-12" style="font-family: S-CoreDream-4Regular">
                       		<div class="head">
	        					<h5 style="display:inline;">현재 접속중인 사용자</h5>
	        					<span id="loginUserCount" style="margin-left:15px;">[${loginUserList.size() }명]</span>
	        					<span id="loginUserReload" style="margin-left:15px;cursor:pointer;" onclick="reloadLoginUser(this);"><i class="fa fa-refresh"></i><span> 새로고침</span></span>
        					</div>
       					</div>
        			</div>
        			
        			<!-- 접속중인 사용자 -->
        			<div class="people_list" style="position:relative;padding:10px 0px;display:inline-block;">
       					<div class="search">
			                <div class="input-group m-b-0">
			                    <div class="input-group-prepend">
			                        <span class="input-group-text" onclick="searchLoginUser();"><i class="icon-magnifier"></i></span>
			                    </div>
			                    <input type="text" id="searchLoginUserName" class="form-control" placeholder="Search..." onkeypress="checkEnter(searchLoginUser);">                                    
			                </div>
			            </div>
                       	<ul class="list-unstyled chat-list mt-2 mb-0" style="max-height:40vh;overflow-y:auto;">
	                       	<c:forEach items="${loginUserList }" var="user">
	                        	<li class="loginUserList" style="margin:0px;padding:10px;" data-deptId="${user.deptId }" data-empId="${user.empId }" onclick="showSendAlarmForm(this);">
	                        		<div id="pictureView" style="background-image:url('${pageContext.request.contextPath }/admin/emp/getPicture?picture=${user.empPicture }'); width: 40px; height: 40px;float:left;margin:0px;" class="rounded-circle avatar"></div>
	                               	<div class="about">
	                                	<div class="name"><strong style="color:black;">${user.empName } ${user.officialName }</strong></div>
	                                   	<div class="status">${user.deptName } ${user.teamName }</div>
	                            	</div>
	                           	</li>
	                       	</c:forEach>
                       </ul>
                   </div>
        			<div style="display: inline-block;float: right;width: 40%;padding:10px 5px;">
        				<h6 style="font-family: S-CoreDream-6Bold;">부서별 접속 현황</h6>
        				<hr>
        				<div style="max-height:40vh;overflow-y:auto;">
	        				<table style="width:100%;">
	        					<thead>
	        						<tr>
	        							<th style="width:70%;"></th>
	        							<th></th>
	        						</tr>
	        					</thead>
	        					<tbody>
	        						<c:forEach items="${deptList }" var="dept">
	        							<c:if test="${dept.deptTeamYn eq '부서' }">
			        						<tr>
			        							<td>${dept.deptName }</td>
			        							<td id="dept_${dept.deptId }" class="deptNum" style="text-align: center;">0</td>
			        						</tr>
	        							</c:if>
	        						</c:forEach>
	        					</tbody>
	        				</table>
        				</div>
        			</div>
        			
        			<!-- 알림 전송창 -->
        			<div style="clear:both;display:none;" id="divSendAlarm">
        				<hr>
        				<div class="header" style="padding:10px;">
                            <h5 style="display:inline-block;">알림 보내기</h5>
                        </div>
                        <div style="padding:0 10px;">
	                        <label class="boardWriter" style="margin-left:5px;">수신자</label>
	                        <div class="form-group" style="width:40%;">
	                            <input type="text" id="receiverName" readonly="" class="form-control">
	                            <input type="hidden" id="receiverId">
	                        </div>
                        </div>
                        <div class="body widget newsletter" style="padding:0 10px 10px;">
                        	<button type="button" class="btn hiddenFillBtn" onclick="presentationFill_2();" style="position:absolute;right:0px;top:35em;color:#ffffff">시연용버튼 2</button>                        
                            <div class="input-group">
                                <input type="text" class="form-control" id="alarmContent" placeholder="알림 내용을 입력하세요." onkeypress="checkEnter(sendAlarm);">
                                <div class="input-group-append">
                                    <span class="input-group-text" onclick="sendAlarm();"><i class="icon-paper-plane"></i></span>
                                </div>
                            </div>
                        </div>
        			</div>
       			</div>
	        </div>
	        
	        <!-- 메뉴바 설정 -->
	        <div class="card" style="margin-bottom:15px;">
	            <div class="body" style="padding-bottom:0px;">
                    <div class="row clearfix">
                    	<div class="col-7" style="font-family: S-CoreDream-4Regular">
                       		<div class="head">
	        					<h5 style="display:inline;">메뉴바 설정</h5>
        					</div>
       					</div>
       					<div class="form-group" style="padding:20px 20px 0px 20px;width:100%; font-family: S-CoreDream-6Bold">
       						<c:forEach items="${menuList }" var="menu" varStatus="status">
	                           	<label class="fancy-checkbox" style="width:100px;">
                                    <input type="checkbox" name="checkbox" data-parsley-errors-container="#error-checkbox" data-parsley-multiple="checkbox" <c:if test="${menu.mstate eq 'N'}">checked</c:if> />
                                    <span>${menu.mname }</span>
                                </label>
       							<c:if test="${status.index % 4 == 3 }">
       								<br>
       							</c:if>
	                       	</c:forEach>
	                       	<hr>
	                       	<button type="button" class="btn btn-primary float-right" style="width:100px;font-family: S-CoreDream-6Bold;" onclick="updateMenu();">저장</button>
       					</div>
        			</div>
       			</div>
	        </div>
	        
	        <!-- 업무 시간 설정 -->
	        <div class="card">
	            <div class="body" style="padding-bottom:0px;">
                    <div class="row clearfix">
                    	<div class="col-7" style="font-family: S-CoreDream-4Regular">
                       		<div class="head">
	        					<h5 style="display:inline;">업무 시간 설정</h5>
        					</div>
       					</div>
       					<div class="form-group" style="padding:30px 20px 0px 20px; width:100%; font-family: S-CoreDream-4Regular">
       						<form name="timeForm" action="${pageContext.request.contextPath }/admin/time/modify">
	                           	<label>출근 시간</label>
	                            <input type="time" class="form-control" name="attendTime" style="width: 50%;display: inline;margin-left: 15px;" value="${time.attendTime }">
	                            <br>
	                           	<label style="margin-top:20px;">퇴근 시간</label>
	                            <input type="time" class="form-control" name="leavingTime" style="width: 50%;display: inline;margin-left: 15px;" value="${time.leavingTime }">
		                       	<hr>
		                       	<button type="button" class="btn btn-primary float-right" style="width:100px;font-family: S-CoreDream-6Bold;" onclick="modifyTime();">저장</button>
       						</form>
       					</div>
        			</div>
       			</div>
	        </div>
	        
	    </div>
	</div>
</div>

<form name="menuForm">
</form>

<script>
window.onload=function(){
	setDeptNum();
}

// 부서원 수 초기화
function setDeptNum(){
	$('.deptNum').text("0");
	$('.chat-list li').each(function(){
		var deptId = $(this).attr('data-deptId');
		var deptNum = $('#dept_'+deptId).text()*1;
		$('#dept_'+deptId).text(deptNum+1);
	});
}

// 공지 입력 폼 변경
function changeCategory(obj){
	$('.formGroup').css('display','none');
	$('.'+obj.value+'Form').css('display','');
}

// 리셋 버튼
function resetBtn(){
	$('.note-editable').text("");
}

// 공지글 등록
function registNotice(){
	var form = $('form[name="noticeRegistForm"]');
	var category = $('select#selectBoard').val();
	if(category == 'default'){
		alert('글 분류를 선택하세요.');
		return;
	}
	
	if(category == 'notice'){
		form.action = '<c:url value="/board/notice/regist"/>';
		$('input[name="noticeVO.noticeContent"]').val($('.note-editable').html());
	}else if(category == 'emergency'){
		form.action = '<c:url value="/board/notice/regist"/>';
		$('input[name="noticeVO.noticeContent"]').remove();
		$('select[name="noticeVO.noticeImportantYN"]').val('E');
	}
	
	$.ajax({
		url:form.action,
		type:'post',
		data:form.serialize(),
		success:function(){
			alert('공지가 등록되었습니다.');
			
			if(category == 'notice'){
				window.location.reload(true);
			}else if(category == 'emergency'){
				$('#removeEmergencyBtn').css('display','');
				$('#emergencyTitle').val($('input[name="noticeVO.noticeTitle"]').val());
				$('input[name="noticeVO.noticeTitle"]').val("");
			}
		},
		error:function(){
			alert('공지 등록 실패');
		}
	});
}

// 긴급공지 삭제
function removeEmergency(){
	if(!confirm('긴급공지를 삭제하시겠습니까?')){
		return;
	}
	
	$.ajax({
		url:'<c:url value="/board/notice/remove"/>',
		type:'post',
		data:{noticeId:'${emergency.noticeId}'},
		success:function(){
			$('#removeEmergencyBtn').css('display','none');
			$('#emergencyTitle').val("");
		}
	});
}

// 로그인 사용자 리로드
function reloadLoginUser(obj){
	$(obj).find('i').addClass('fa-spin');
	$(obj).find('span').text(' 불러오는중..');
	
	$('input#searchLoginUserName').val("");
	
	setTimeout(() => {
		searchLoginUser('reload');
		
		$(obj).find('i').removeClass('fa-spin');
		$(obj).find('span').text(' 새로고침');
	},1000);
}

// 로그인 사용자 검색
function searchLoginUser(category){
	var empName = $('input#searchLoginUserName').val();
	
	$.ajax({
		url:'<c:url value="/admin/emp/search"/>',
		type:'post',
		data:{empName:empName},
		success:function(searchLoginUserList){
			$('.chat-list').children().remove();
			
			var liTag = '';
			
			if(searchLoginUserList.length == 0){
				liTag += '<li style="margin:0px;padding:50px 10px;cursor:inherit;">'
							+'<div style="text-align: center;">'
								+'<strong>해당 사용자는 접속중이 아닙니다.</strong>'
							+'</div>'
						+'</li>';
			}else{
				for(var i=0; i<searchLoginUserList.length; i++){
					var user = searchLoginUserList[i];
					
					liTag += '<li class="loginUserList" style="margin:0px;padding:10px;" data-deptId="'+user.deptId+'" data-empId="'+user.empId+'" onclick="showSendAlarmForm(this);">'
								+'<div id="pictureView" style="background-image:url(\'${pageContext.request.contextPath }/admin/emp/getPicture?picture='+user.empPicture+'\'); width: 40px; height: 40px;float:left;margin:0px;" class="rounded-circle avatar"></div>'
								+'<div class="about">'
									+'<div class="name"><strong style="color:black;">'+user.empName+' '+user.officialName+'</strong></div>'
									+'<div class="status">'+user.deptName+' '+user.teamName+'</div>'
								+'</div>'
							+'</li>';
				}
			}
			$('.chat-list').append(liTag);
			
			if(category == 'reload'){
				// 사용자수 변경
				$('#loginUserCount').text('['+$('.chat-list').children().length+'명]');
				
				// 부서원 수 변경
				setDeptNum();
			}
		}
	});
}

// 로그인 사용자 클릭시 알림창 보이기
function showSendAlarmForm(obj){
	$('.loginUserList').css('background-color','');
	$(obj).css('background-color','#e9ecef');
	
	$('#divSendAlarm').css('display','');
	var empName = $(obj).find('strong').text();
	var empId = $(obj).attr('data-empId');
	
	$('input#receiverName').val(empName);
	$('input#receiverId').val(empId);
}

// 알림 전송
function sendAlarm(){
	var empId = $('input#receiverId').val();
	var alarmContent = $('input#alarmContent').val();
	
	if($.trim(alarmContent) == ''){
		alert('알림 내용을 입력하세요');
		$('input#alarmContent').focus();
		return;
	}
	
	sendMessage('${pageContext.request.contextPath}',
				empId,
				'관리자 메시지',
				alarmContent,
				'',
				'관리자');
	
	alert('알림이 전송되었습니다.');
	$('input#alarmContent').val("");
	
	$('#loginUserReload').click();
}

// 메뉴바 설정 변경
function updateMenu(){
	var form = $('form[name="menuForm"]');
	form.children().remove();
	
	$('input[name="checkbox"]').each(function(){
		var value = "Y";
		if($(this).is(':checked')){
			value = "N";
		}
		var checkTag = $('<input>').attr({'type':'hidden','name':'menuList','value':value});
		form.append(checkTag);
	});
	
	var formData = new FormData(form[0]);
	$.ajax({
		url:'${pageContext.request.contextPath }/admin/menu/modify',
		type:'post',
		data:formData,
		contentType:false,
		processData:false,
		success:function(){
			alert('변경사항이 저장되었습니다.');
		},
		error:function(){
			alert('메뉴 업데이트 실패');
		}
	});
}

// 업무 시간 설정
function modifyTime(){
	var form = $('form[name="timeForm"]')[0];
	$.ajax({
		url:form.action,
		type:'post',
		data:new FormData(form),
		contentType:false,
		processData:false,
		success:function(){
			alert('변경사항이 저장되었습니다.');
		},
		error:function(){
			alert('시간 저장 실패');
		}
	});
}
</script>
<script> // 시연용
function presentationFill_1(){
	$('#emergencyInput').val('조직도 메뉴 점검으로 인해 일시적으로 사용이 불가합니다. 불편을 드려 죄송합니다.');
}
</script>
<script> // 시연용
function presentationFill_2(){
	$('#alarmContent').val('조인워크 그룹웨어를 활용해 업무효율을 높여보세요.');
}
</script>

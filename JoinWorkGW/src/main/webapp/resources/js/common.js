// 메뉴바 보여주기
function showMenu(contextPath){
	$.ajax({
		url:contextPath+'/common/menu/list',
		type:'post',
		success:function(menuList){
			for(var i=0; i<menuList.length; i++){
				var murl = menuList[i].murl;
				var menuId = murl.split('/')[2];
				if(menuId == 'board'){
					menuId = murl.split('/')[3];
				}
				var mname = menuList[i].mname;
				
				var menuTag = '<li id="'+menuId+'" ';
					if(menuList[i].mstate == 'N'){
						menuTag += 'style="color:rgb(255,255,255,0.3);" onclick="alert(\'해당 서비스가 현재 점검중입니다.\');"';
					}else{
						menuTag += 'onclick="location.href=\''+murl+'\';"';
					}
					menuTag += '>'+mname+'</li>';
				
				$('.menuList').append(menuTag);
			}
		},
		error:function(){
			alert('메뉴 가져오기 실패');
		},
		complete:function(){
			cssManager();
		}
	});
}

// 팝업창들 띄우기
// 새로운 window창을 open할 경우 사용되는 함수( arg : 주소, 창타이틀, 넓이, 길이)
function OpenWindow(UrlStr, WinTitle, WinWidth, WinHeight){
	winleft = (screen.width - WinWidth) / 2;
	wintop = (screen.height - WinHeight) / 2;
	var winX      = window.screenX || window.screenLeft || 0;// 현재창의 x좌표
	var winY      = window.screenY || window.screenTop || 0; // 현재창의 y좌표
	
	winleft = winX + winleft;
	wintop = winY + wintop;
	
	var win = window.open(UrlStr, WinTitle, "scrollbars=yes,width="+ WinWidth +", "
							+"height="+WinHeight + ", top=" + wintop +", left="
							+ winleft +", resizable=yes, status=yes");
	win.focus();
}

//팝업창 닫기
function CloseWindow(){
	if(window.opener) window.opener.location.reload(true);
	window.close();
}

function summernote_start(content,contextPath){
	$(content).summernote({
		placeholder:'여기에 내용을 적으세요.',
		height:250,
		disableResizeEditor: true,
		callbacks:{
			onImageUpload : function(files, editor, welEditable) {
				//alert("image insert!!");
				//file size check!
				for (var i = files.length - 1; i >= 0; i--) {
					if(files[i].size > 1024*1024*5){
	            		alert("이미지는 5MB 미만입니다.");
	            		return;
					}
				}
				
				//file sending
				for (var i = files.length - 1; i >= 0; i--) {
	            	sendImg(files[i], this,contextPath+'/common/summernote/uploadImg.do');
				}	
			},
			onMediaDelete : function(target) {
				//alert(target[0].src);
				var answer=confirm("정말 이미지를 삭제하시겠습니다.");
				if(answer){
					deleteImg(target[0].src,contextPath+'/common/summernote/deleteImg.do');
				}
			}
		}
	});
}

// 알림 창 띄우기
function showAlarm(obj){
    $context = $(obj).data('context');
    $message = $(obj).data('message');
    $position = $(obj).data('position');

    if ($context === '') {
        $context = 'info';
    }

    if ($position === '') {
        $positionClass = 'toast-bottom-right';
    } else {
        $positionClass = 'toast-' + $position;
    }

    toastr.remove();
    toastr[$context]($message, '', {
        positionClass: $positionClass
    });
}

// 클립보드 복사
function copyClipboard(copyText){
	var tempElem = document.createElement('textarea');
	tempElem.value = copyText;
	document.body.appendChild(tempElem);

	tempElem.select();
	document.execCommand("copy");
	document.body.removeChild(tempElem);
}

// 메뉴바 선택시 색깔 변경
function cssManager(){
	var menu = location.href.split('JoinWorkGW/')[1].split('/')[0];
	// 홈메뉴
	if(location.href.split('JoinWorkGW/')[1] == 'common/home'){
		menu = 'home';
	}
	// 게시판
	if(menu == 'board'){
		menu = location.href.split('JoinWorkGW/')[1].split('/')[1];
		if(menu == 'duty' || menu == 'issue' || menu == 'milestone' || menu == 'project'){
			$('#duty').css('background-color','#87cefa');
		}else{
			$('#notice').css('background-color','#87cefa');
		}
	}else{
		$('#'+menu).css('background-color','#87cefa');
	}
	
	// 게시판 서브메뉴 강조
	if(menu=='notice' || menu=='cac' || menu=='anony' || menu=='qt'){
		var submenu = location.href.split('board/')[1].split('/')[0];
		$('#li_'+submenu).addClass('active');
	}
	// 업무
	else if(menu=='duty'){
		$('#li_duty').addClass('active');
		$('#li_duty > a').attr('aria-expanded','true');
		$('#li_duty > ul').attr('aria-expanded','true');
		$('#li_duty > ul').addClass('in');
		menu = location.href.split('=')[1];
		if(!menu) menu = 'list';
		$('#a_'+menu).css('font-weight','bold');
	}
	// 이슈 서브메뉴 강조
	else if(menu=='issue' || menu=='milestone' || menu=='project'){
		$('#li_issue').addClass('active');
		$('#li_issue > a').attr('aria-expanded','true');
		$('#li_issue > ul').attr('aria-expanded','true');
		$('#li_issue > ul').addClass('in');
		$('#a_'+menu).css('font-weight','bold');
	}
}

//프로필사진 미리보기
function Preview_picture(fileName){
	
	var imageURL = "getPicture.do?picture="+fileName;
	$('div#pictureView').css({'background-image':'url('+imageURL+')',
		'background-position':'center',
		'background-size':'cover',
		'background-repeat':'no-repeat'
	});
	
}

//날짜 포맷 설정
function getFormatDate(date, separator){
    var year = date.getFullYear();              //yyyy
    var month = (1 + date.getMonth());          //M
    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
    var day = date.getDate();                   //d
    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
    return  year + separator + month + separator + day;       //'-' 추가하여 yyyy-mm-dd 형태 생성 가능
}

// 엔터키 입력시 함수 실행
function checkEnter(myFunction){
	if(event.keyCode == 13){
		myFunction();
	}
}

// ui:pagination 사용시 페이지네이션 css
function paginationCSS(currentPageNo, firstPageNoOnPageList, lastPageNoOnPageList, totalPageCount){
	var pagination = $('ul.pagination');
	pagination.children().each(function(){
		var text = $(this).text();
		if(text=='[처음]'){
			text = '<span class="goPrevPage" aria-hidden="true"><<</span>';
		}else if(text=='[이전]'){
			text = '<span class="goPrevPage" aria-hidden="true"><</span>';
		}else if(text=='[다음]'){
			text = '<span class="goNextPage" aria-hidden="true">></span>';
		}else if(text=='[마지막]'){
			text = '<span class="goNextPage" aria-hidden="true">>></span>';
		}
		var liTag = '<li class="page-item '
					+(currentPageNo==text ? "active" : "")
					+'" style="float:left;"><a class="page-link" href="javascript:void(0);" onclick="'+$(this).attr('onclick')+'">'+text+'</a></li>';
		pagination.append(liTag);
		$(this).remove();
	});
	if(firstPageNoOnPageList<=1){
		$('span.goPrevPage').closest('li').remove();
	}
	if(lastPageNoOnPageList == totalPageCount){
		$('span.goNextPage').closest('li').remove();
	}
}



// 알림기능
// 전역변수 선언-모든 홈페이지에서 사용 할 수 있게 index에 저장
var socket = null;

// 소켓 연결 및 알림 수신 표시
function connectWs(webSocketUrl){
	sock = new SockJS(webSocketUrl);
	socket = sock;

//	sock.onopen = function() {
//        console.log('info: connection opened.');
//	}

	sock.onmessage = function(evt) {
	 	var data = evt.data;
	 	if(data.split(',')[0] == '[채팅]'){	// 채팅
	 		var empId = data.split(',')[1];
	 		var empName = data.split(',')[2];
	 		var senderId = data.split(',')[3];
	 		var content = data.split(',')[4];
	 		addChatHistory(senderId, content);
	 	}else{	// 알림
	 		var contextPath = data.split(',')[0];
	 		var loginUserId = data.split(',')[1];
	 		var title = data.split(',')[2];
	 		var content = data.split(',')[3];
	 		var url = data.split(',')[4];
	 		if(opener){
	 			opener.showAlarm($('<span data-context="info" data-message="'+title+'<br>'+content+'" data-position="bottom-right"></span>'));
	 			opener.changeAlarmNum(contextPath, loginUserId);
	 		}else{
	 			showAlarm($('<span data-context="info" data-message="'+title+'<br>'+content+'" data-position="bottom-right"></span>'));
	 			changeAlarmNum(contextPath, loginUserId);
	 		}
	 	}
	}

//	sock.onclose = function() {	
//		console.log('connect close');
//	}
//
//	sock.onerror = function(err) {
//		console.log('Errors : ' , err);
//	}
}

// 알림 전송 및 전송한 알림 DB에 저장
function sendMessage(contextPath, receiverId, alarmTitle, alarmContent, alarmUrl, alarmCategory){
    // 전송한 정보를 db에 저장
    $.ajax({
    	url: contextPath+'/common/saveAlarm',
        type: 'post',
        data: {
            empReaderId: receiverId
            ,alarmTitle: alarmTitle
            ,alarmContent: alarmContent
            ,alarmUrl:alarmUrl
            ,alarmCategory: alarmCategory
        },
        async:false,
        success: function(result){    // db전송 성공시 실시간 알림 전송
        	console.log(result);
        	if(result == 'ignore') return;
            // 소켓에 전달되는 메시지
            // EchoHandler에서 ,(comma)를 이용하여 분리시킨다.
            socket.send(receiverId+","+alarmTitle+","+alarmContent+","+alarmUrl+","+alarmCategory+','+contextPath);	
        },error: function(error){
        	alert('에러 발생');
        }
    });
}

//알림 요약 목록 가져오기(최신 4개)
function updateAlarm(contextPath, loginUserId){
	$('.alarmSetting').css('display','none');
	
	$.ajax({
		url:contextPath+'/common/alarm/list',
		type:'post',
		data:{empId:loginUserId, status:'summary'},
		success:function(alarmList){
			$('div#alarm-list').children().remove();
			if(alarmList.length != 0){
				for(var i=0; i<alarmList.length; i++){
					var liTag = '<li class="alarm-list" style="border-bottom: 1px solid rgb(0,0,0,0.1);">'
						+'<a href="javascript:void(0);" onclick="readAlarm(\''+contextPath+'\',\''+loginUserId+'\',\''+alarmList[i].alarmId+'\',\''+(alarmList[i].alarmUrl ? alarmList[i].alarmUrl+'&alarmId='+alarmList[i].alarmId : '')+'\');">'
						+'<div class="media">'
						+'<div class="media-body">';
					if(alarmList[i].alarmSt == 0){
						liTag += '<span style="position:absolute;border:1px solid red;border-radius: 50%;background-color: red;width:5px;height:5px;margin:8px;"></span>';
					}
					liTag += '<div style="display:inline-block;padding:0 20px;width:100%;">'
						+'<p style="color:darkgray;display:inline-block;margin-bottom:0px;">'+alarmList[i].alarmCategory+'</p>'
						+'<span class="timestamp" style="float:right;">'+getTimeDefferFromCurrent(new Date(alarmList[i].alarmStartDt))+'</span>'
						+'<p class="text" style="display:inline-block"><strong>'+alarmList[i].alarmTitle+'</strong><br><span style="display:inline-block;max-width: 300px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">'+alarmList[i].alarmContent+'</span></p>'
						+'<span class="float-right m-t-15"><i class="icon-close" style="font-size:15px;" onclick="removeAlarm(\''+contextPath+'\',\''+loginUserId+'\',\'\','+alarmList[i].alarmId+');event.stopPropagation();"></i></span>'
						+'</div>'
						+'</div>'
						+'</div>'
						+'</a>'
						+'</li>';
					$('div#alarm-list').append(liTag);
				}
			}else{
				var liTag = '<li>'
						   +'<a href="javascript:void(0);" style="cursor: default;">'
						   +'<div class="media">'
						   +'<div class="media-body noAlarm" style="text-align: center;">'
						   +'새로운 알림이 없습니다.'
						   +'</div>'
						   +'</div>'
						   +'</a>'
						   +'</li>';
				$('div#alarm-list').append(liTag);
			}
			
		},
		error:function(){
			alert('알림 목록 가져오기 실패');
		},
		complete:function(){
			if($('#alarmModal').css('display')=='none'){
				$('#dropdownDiv').click();
			}
			changeAlarmNum(contextPath, loginUserId);
		}
	});
}

//알림 개수 표시
function changeAlarmNum(contextPath, loginUserId){
	// 알림 아이콘 숫자표시
	$.ajax({
		url:contextPath+'/common/getAlarmCount',
		type:'post',
		data:{empId:loginUserId},
		async:false,
		success:function(num){
			if(num != 0){
				$('#alarmIcon').css('display','');
				$('#alarmIcon').text(num);
			}else{
				$('#alarmIcon').css('display','none');
			}
			alarmDetail(contextPath,loginUserId);
		},
		error:function(){
			alert('알림 개수 가져오기 실패');
		}
	});
}

//알림 상세 목록 조회
function alarmDetail(contextPath, loginUserId){
	
	$.ajax({
		url:contextPath+'/common/alarm/list',
		type:'post',
		data:{empId:loginUserId,status:'list'},
		async:false,
		success:function(alarmList){
			$('div#allAlarmList').children().remove();
			if(alarmList.length != 0){
				
				for(var i=0; i<alarmList.length; i++){
					var alarmTag = '<a href="javascript:void(0);" onclick="closeModal(); readAlarm(\''+contextPath+'\',\''+loginUserId+'\',\''+alarmList[i].alarmId+'\',\''+(alarmList[i].alarmUrl ? alarmList[i].alarmUrl+'&alarmId='+alarmList[i].alarmId : '')+'\')">'
					+'<div class="media" style="margin:0px;">'
					+'<div class="media-body" style="padding:20px 10px;border-bottom: 1px solid rgb(0,0,0,0.1);">';
					if(alarmList[i].alarmSt == 0){
						alarmTag += '<span style="display:inline-block;vertical-align:top;border:1px solid red;border-radius: 50%;background-color: red;width:5px;height:5px;margin:8px;"></span>'
							+'<div style="display:inline-block;width:95%;">';
					}else{
						alarmTag += '<div style="display:inline-block;width:95%;margin-left:20px;">';
					}
					alarmTag +='<span class="text" style="color:darkgray;display:inline-block;">'+alarmList[i].alarmCategory+'</span>'
					+'<span class="timestamp" style="float:right;">'+getTimeDefferFromCurrent(new Date(alarmList[i].alarmStartDt))+'</span>'
					+'<p class="text" style="width:88%;display:inline-block;margin:0px;"><strong>'+alarmList[i].alarmTitle+'</strong><br>'+alarmList[i].alarmContent+'</p>'
					+'<span class="float-right m-t-15"><i class="icon-close" style="font-size:15px;" onclick="removeAlarm(\''+contextPath+'\',\''+loginUserId+'\',\'\','+alarmList[i].alarmId+');event.stopPropagation();"></i></span>'
					+'</div>'
					+'</div>'
					+'</div>'
					+'</a>';
					$('div#allAlarmList').append(alarmTag);
				}
			}else{
				var alarmTag = '<a href="javascript:void(0);" style="cursor: default;">'
							  +'<div class="media">'
							  +'<div class="media-body noAlarm" style="text-align: center;height:100px;padding:45px;font-size: 1.2em;">'
							  +'새로운 알림이 없습니다.'
							  +'</div>'
							  +'</div>'
							  +'</a>';
				$('div#allAlarmList').append(alarmTag);
			}
		},error:function(){
			alert('??');
		}
	});
}

//알림 설정창 열기
function showAlarmSetting(contextPath){
	if($('.alarmSetting').css('display') == 'none'){
		$.ajax({
			url:contextPath+'/common/alarm/settingForm',
			type:'post',
			success:function(alarmManageList){
				for(var i=0; i<alarmManageList.length; i++){
					if(alarmManageList[i] == 'Y'){
						$('.alarmSettingEl').eq(i).prop('checked','true');	
					} 
				}
				$('.alarmSetting').css('display','');
			}
		});
	}else{
		$('.alarmSetting').css('display','none');
	}
}

// 알림 설정 변경
function saveAlarmSetting(contextPath, loginUserId){
	var alarmObj = {empId:loginUserId};
	
	$('.alarmSettingEl').each(function(){
		var value = "N";
		if($(this).is(':checked')){
			value = "Y";
		}
		alarmObj[$(this).attr('data-colName')] = value;
	});
	
	$.ajax({
		url:contextPath+'/common/alarm/saveSetting',
		type:'post',
		data:alarmObj,
		success:function(){
			alert('알림 설정이 저장되었습니다.');
		}
	});
}

// 알림 삭제
function removeAlarm(contextPath,loginUserId,read,alarmId){
	if($('.noAlarm').length == 2) return;
	
	if(!confirm('알림을 삭제하시겠습니까?')) return;
	
	$.ajax({
		url:contextPath+'/common/alarm/remove',
		type:'post',
		data:{empReaderId:loginUserId,cri:read,alarmId:alarmId},
		success:function(){
			updateAlarm(contextPath,loginUserId);
		},
		error:function(){
			alert('알림 삭제 실패');
		}
	});
}

// 알림 클릭시 읽음 표시
function readAlarm(contextPath,loginUserId,alarmId,returnUrl){
	$.ajax({
		url:contextPath+'/common/alarm/modify',
		type:'post',
		data:{empReaderId:loginUserId,alarmId:alarmId},
		success:function(){
			// url에 따라 openwindow 판단
			if(returnUrl && returnUrl != ''){
				OpenWindow(returnUrl, 'JoinWorkGW', 1000, 700);
			}
			changeAlarmNum(contextPath,loginUserId);
		},
		error:function(){
			alert('알림 업데이트 실패');
		}
	});
}

// 시간 차이 계산하고 텍스트 출력
function getTimeDefferFromCurrent(tempDt){
	var year = tempDt.getFullYear();
	var month = tempDt.getMonth()
	var date = tempDt.getDate();
	var hours = tempDt.getHours();
	var minutes = tempDt.getMinutes();
	var seconds = tempDt.getSeconds();
	
	recommandDt = new Date(year,month,date,hours,minutes,seconds,0);
	var currentDt = new Date();
	
	//차이 계산
	var differentDt = (currentDt.getTime() - recommandDt.getTime());
	
	var differentDay = differentDt/(24*60*60*1000);
	var differentHours = differentDt/(60*60*1000);
	var differentMinutes = differentDt/(60*1000);

	var fiveMinutesByMillisecond = (5*60*1000);
	var oneHourByMillisecond = (60*60*1000);
	var oneDayByMillisecond = (1*24*60*60*1000);

	
	if(differentDt < fiveMinutesByMillisecond){
// 		alert("5분 전");
		return "방금";
		
	}
	
	if(differentDt < oneHourByMillisecond){
// 		alert("1시간 전");
		return Math.floor(differentMinutes)+"분 전";
		
	}
	
	if(differentDt < oneDayByMillisecond){
// 		alert("하루 전");
		return Math.floor(differentHours)+"시간 전";
	} 
	
	return Math.floor(differentDay)+"일 전";
}

//긴급공지창 보이기
function showEmergency(contextPath){
	$.ajax({
		url:contextPath+'/common/emergency',
		type:'post',
		success:function(emergency){
			if(emergency && sessionStorage.getItem('emergency') != 'emergencyId_'+emergency.noticeId){
				$('.emergencyArea').css('display','');
				$('#emergencyText').append('<MARQUEE class="emergency" id="emergencyId_'+emergency.noticeId+'" style="font-weight: bold;">'+emergency.noticeTitle+'</MARQUEE>');
			}
		}
	});
}

//긴급공지창 닫기
function closeEmergency(){
	$('.emergencyArea').css('display','none');
	sessionStorage.setItem('emergency',$('.emergency').attr('id'));
}

// 채팅 내용 추가
function addChatHistory(senderId, content){
	var today = new Date();
	var hour = today.getHours();
	var minute = today.getMinutes();
	minute = minute < 10 ? '0'+minute : minute;
	var ampm = hour >= 12 ? '오후' : '오전';
	hour = hour % 12 ? hour % 12 : 12;
	
	var chat = '<li class="clearfix">'
			  	+'<div class="message-data">'
			  		+'<span class="message-data-time">'+ampm+' '+hour+':'+minute+'</span>'
			  	+'</div>'
			  	+'<div class="message" style="max-width:500px;background-color: #e8f1f3;word-break: break-word;">'+content+'</div>'
			  +'</li>';
	$('#room_'+senderId+' .chat-history ul').append(chat);
	$('#room_'+senderId+" .chat-history").scrollTop($('#room_'+senderId+" .chat-history")[0].scrollHeight);
}
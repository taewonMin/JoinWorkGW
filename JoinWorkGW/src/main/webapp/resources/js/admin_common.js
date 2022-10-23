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

//엔터키 입력시 함수 실행
function checkEnter(myFunction){
	if(event.keyCode == 13){
		myFunction();
	}
}


//cssManager();
//
//function cssManager(){
//	alert('메뉴바 변경');
//	// 메뉴바 선택시 색깔 변경
//	var menu = location.href.split('JoinWorkGW/')[1].split('/')[0];
//	$('#'+menu).addClass('selected');
//	
//	// 게시판 선택된 서브메뉴 폰트 강조
//	if(menu=='board'){
//		var submenu = location.href.split('board/')[1].split('/')[0];
//		$('#'+submenu).addClass('active');
//		if(submenu=='issue' || submenu=='duty'){ // 업무 게시판
//			$('#myBoard').addClass('active');
//			$('#myBoard ul').addClass('in');
//		}else{ // 전사 게시판
//			$('#commonBoard').addClass('active');
//			$('#commonBoard ul').addClass('in');
//		}
//	}
//}

//page parameter
var pageParams={
	page:1,
	perPageNum:10,
	searchType:'',
	keyword:''	
}
//page paramenter & cookie initialize
function initPageParam(prefix){
	pageParams.page=1;
	pageParams.perPageNum=10;
	pageParams.searchType='';
	pageParams.keyword='';
	
	var paramKeys = Object.keys(pageParams);
	for(var key of paramKeys){	
		if(prefix){	
			$.removeCookie(prefix+key,{path:"/"});			
		}else{
			$.removeCookie(key,{path:"/"});
		}
	}
}


function setPageParams(page,perPageNum,searchType,keyword){	
	if(page) pageParams.page = page;
	if(perPageNum) pageParams.perPageNum = perPageNum;
	if(searchType) pageParams.searchType = searchType;
	if(keyword) pageParams.keyword = keyword;
	
}


// page number 가져오기
function getParameterValueFromUrl(paramName){
	
	var paramJson = {};	
	var queryParam = window.location.href.split("?")[1];
	var params = queryParam.split("&");
	for (var param of params){
		paramJson[param.split("=")[0]]=param.split("=")[1];
	}
	
	return paramName ? paramJson[paramName] : queryParam;
}

//ui:pagination 사용시 페이지네이션 css
function paginationCSS(currentPageNo, firstPageNoOnPageList, lastPageNoOnPageList, totalPageCount){
	var pagination = $('ul.pagination');
	pagination.children().each(function(){
		var text = $(this).text();
		if(text=='[처음]'){
			text = '<span class="goPrevPage" aria-hidden="true">«</span>';
		}else if(text=='[이전]'){
			text = '<span class="goPrevPage" aria-hidden="true">‹</span>';
		}else if(text=='[다음]'){
			text = '<span class="goNextPage" aria-hidden="true">›</span>';
		}else if(text=='[마지막]'){
			text = '<span class="goNextPage" aria-hidden="true">»</span>';
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


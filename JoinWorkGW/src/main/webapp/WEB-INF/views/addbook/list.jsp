<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/light/assets/fonts/font.css">


<style>
.thead-dark tr:hover, .table.table-custom.table tbody tr:hover,
	.sidebar-nav .metismenu a:hover, .sidebar-nav .metismenu a:focus,
	.sidebar-nav .metismenu a:active {
	cursor: pointer;
	background-color: rgb(0 0 0/ 10%);
}

#private_AddBook_menu {
	height: 200px;
	
	
	overflow: auto;
}

#company_AddBook_menu {
	height: 350px;
	overflow: auto;
}

#searchFormDiv {
	padding: 25px 25px 10px 25px;
}

#getExcelBtn:hover, #moveBtn:hover, #deleteBtn:hover {
	cursor: pointer;
}

span#getExcelBtn, span#moveBtn, span#deleteBtn {
	font-size: 1.2em;
	margin: 0px 0px 0px 10px;
	vertical-align: middle;
}

span#resultNumSpan {
	vertical-align: -webkit-baseline-middle;
	font-size: 1.2em;
	margin: 0px 0px 0px 10px;
	color: rgb(68, 68, 68);
}

.table-striped tbody tr:nth-of-type(odd) {
	background-color: white;
}

i.fa-cog {
	margin-right: 20px;
}

i.fa-cog:hover {
	margin-right: 20px;
	cursor: pointer;
	color: #cacaca;
}

#infoSpan {
	margin: 5px 0 0 10px;
	color: #4444447d;
}

.text-btn:hover {
	cursor: pointer;
	color: #888888;
}
.modal-backdrop.show {
    opacity: .35;
}

#excelInfo{
	font-family: InfinitySans-RegularA1;
    padding-right: 16px;
    padding-top: 7px;
    padding-bottom: 6px;
    padding-left: 14px;
    font-weight:  bold;
}
</style>


<!-- 사이드바 -->
<div id="left-sidebar" class="sidebar"
	style="border-right: 2px solid rgb(0, 0, 0, 0.1)">
	<div class="sidebar-scroll">
		<!-- 여기 사이드바 넣는곳 -->
		<form:form commandName="addBookFormVO" id="submenuForm" name="submenuForm">


			<div class="tab-content p-l-0 p-r-0 text-align" style="font-size: 25px;">
				<button onclick="registAddBook_go();" type="button" style="background-color: #2980b9; color: white; border: 0px; width: 14rem; height: 3.8rem; margin-left: 3.5%; border-radius: 5%; margin-top: 4%; font-family: InfinitySans-RegularA1">개인주소록
					추가</button>
			</div>

			<div class="tab-content p-l-0 p-r-0"
				style="font-size: 25px; margin-top: 4%; margin-left: 3%; padding-bottom: 0; font-family: S-CoreDream-4Regular">
				개인 주소록 <span class="float-right"
					onclick="javascript:OpenWindow('<%=request.getContextPath()%>/addbook/groupList','그룹편집','1105','455');"><i
					class="fa fa-cog"></i></span>
			</div>
			<div class="tab-content p-l-0 p-r-0">
				<div class="tab-pane animated fadeIn active"
					id="private_AddBook_menu">
					<nav class="sidebar-nav"
						style="font-size: 20px; font-family: InfinitySans-RegularA1">
						<ul class="main-menu metismenu privateAddBook">
							<li id="menu_private"><a href="<c:url value='/addbook/list'/>"  style="font-size: 18px;"><i class="fa fa-folder-o"></i>전체주소록</a></li>
							<c:forEach items="${groupList }" var="group">
								<li id="menu_${group.addBookId}">
									<a href="<%=request.getContextPath()%>/addbook/list?searchAddBookVO.addBookId=${group.addBookId}"  style="font-size: 18px;">
										<i class="fa fa-folder-o"></i>${group.addBookTitle }
									</a>
								</li>
							</c:forEach>
						</ul>
					</nav>
				</div>
			</div>

			<div class="tab-content p-l-0 p-r-0"
				style="font-size: 25px; margin-left: 3%; padding-bottom: 0; font-family: S-CoreDream-4Regular;">
				회사 주소록</div>
			<div class="tab-content p-l-0 p-r-0"
				style="font-family: InfinitySans-RegularA1">
				<div class="tab-pane animated fadeIn active"
					id="company_AddBook_menu">
					<nav class="sidebar-nav">
						<ul class="main-menu metismenu" style="font-size: 20px;">
							<li id="menu_company">
								<a href="<c:url value='/addbook/company/list'/>" style="font-size: 18px;">
									<i class="fa fa-folder-o"></i>전체주소록
								</a>
							</li>
							<c:forEach items="${deptList }" var="dept">
								<li id="menu_${dept.deptId}"><a
									href="<%=request.getContextPath()%>/addbook/company/list?deptId=${dept.deptId}" style="font-size: 18px;"><i
										class="fa fa-folder-o"></i>${dept.deptName }</a></li>
							</c:forEach>
						</ul>
					</nav>
				</div>
			</div>
		</form:form>
	</div>
</div>

<!-- 메인 content -->
<div id="main-content" style="font-family: S-CoreDream-7ExtraBold">
	<div class="container-fluid">
		<!-- 모달 -->
		<a id="groupViewModal" href="#groupModal" data-toggle="modal" data-target="#groupModal" style="display: none;"></a>
		<a id="moveViewModal" href="#moveModal" data-toggle="modal" data-target="#moveModal" style="display: none;"></a>

		<!-- 메인 content 넣는 곳 -->
		<div class="row clearfix">
		   <div class="col-12" style="margin-top: 2%;font-family: S-CoreDream-6Bold">
				<c:choose>
					<c:when test="${flag == 'private'}">
				      <h2><i class="icon-notebook"></i>&nbsp;개인주소록</h2>
				      <hr>
					</c:when>
					<c:otherwise>
				      <h2><i class="icon-notebook"></i>&nbsp;회사주소록</h2>
				      <hr>
					</c:otherwise>
				</c:choose>
		   </div>
		</div>
		<div class="row clearfix ">
			<div class="col-12">
				<div class="card mb-4">
					<div class="header">
						<div class="box-container">
							<c:if test="${flag eq 'private'}">
								<span id="deleteBtn" class="text-btn float-left" onclick="deleteAdds();"><i class="fa fa-trash-o"></i>&nbsp;삭제</span>
								<span id="moveBtn" class="text-btn float-left" onclick="moveAdd();"><i class="fa fa-share-square-o"></i>&nbsp;그룹이동</span>
							</c:if>
							<c:if test="${flag ne 'private'}">
								<span id="copyBtn" class="text-btn float-left" onclick="copyAdd();" style="margin-left: 10px;font-size:1.2em;"><i class="fa fa-share-square-o"></i>&nbsp;주소록 복사</span>
								<span id="dutyBtn" class="text-btn float-left" onclick="dutySend();" style="margin-left: 10px;font-size:1.2em;"><i class="fa fa-file-text"></i>&nbsp;업무제안</span>
							</c:if>
							<form:form commandName="addBookFormVO" id="excelForm"
								name="excelForm" method="post" enctype="multipart/form-data">
								<span id="getExcelBtn" class="text-btn  float-left"
									onclick="getExcel()"> <c:if test="${flag eq 'private'}">
										<a class="alert alert-info alert-dismissible" id="excelInfo" href="#"
											data-toggle="popover" data-trigger="hover"
											data-placement="top" data-html="true"
											data-content="주소록 체크 후 다운로드 시 해당 주소록만 다운로드 가능합니다.<br/>미체크 시 사용자의 모든 개인주소록 목록을 다운로드 합니다."> 
												<i class="fa fa-download"></i>&nbsp;주소록 다운로드
										</a>
									</c:if> <c:if test="${flag ne 'private'}">
										<a class="alert alert-info alert-dismissible" id="excelInfo" href="#"
											data-toggle="popover" data-trigger="hover"
											data-placement="top" data-html="true"
											data-content="주소록 체크 후 다운로드 시 해당 주소록만 다운로드 가능합니다.<br/>미체크 시 사용자의 모든 회사주소록 목록을 다운로드 합니다.">
												<i class="fa fa-download"></i>&nbsp;주소록 다운로드
										</a>
									</c:if>
								</span>
								<div id="appendDiv" style="display: none;">
								<!-- 컨트롤러 가져갈 id 담은 input 넣을 곳 -->
								</div>
<%-- 								<form:hidden path="AddBookRegistCommand.manageIdArr" /> --%>
								<!-- 안쓰면 삭제 예정 -->
							</form:form>
							<!-- 설정된 검색 조건 입력 폼 표시 -->
						</div>
					</div>
					<form:form commandName="addBookFormVO" id="listForm"
						name="listForm" method="post">
						<div class="box-container">
							<div class="box-container" id="searchFormDiv">
								<form:select path="searchAddBookVO.searchCondition"
									class="form-control selectSearch"
									style="width:130px;font-size: 1.2em;float:left;">
									<form:option value="npod">전체</form:option>
									<form:option value="n">이름</form:option>
									<form:option value="p">휴대폰</form:option>
									<form:option value="o">직급</form:option>
									<form:option value="d">부서명</form:option>
								</form:select>
								<div id="navbar-search"
									class="navbar-form search-form selectSearch"
									style="float: left;">
									<form:input path="searchAddBookVO.searchKeyword"
										class="form-control" placeholder="검색" type="text"
										style="width: 218px;height:36px;padding-right: 40px;"
										onkeypress="checkEnter(searchList);" autocomplete="off" />
									<button type="button" class="btn btn-default"
										onclick="searchList();">
										<i class="icon-magnifier"></i>
									</button>
								</div>
								<div class="form-group float-left" id="resultNumDiv">
									<span id="resultNumSpan">[총 <fmt:formatNumber
											value="${paginationInfo.totalRecordCount }" type="number" />개]
									</span>
								</div>
								<div class="form-group" style="float: right;">
									<div
										style="display: inline-block; float: left; font-size: 1.2em; margin: 6px 20px 0 0">
										<span>${paginationInfo.currentPageNo} </span>/<span>
											${paginationInfo.totalPageCount} 페이지 중</span>
									</div>
									<form:select path="searchAddBookVO.pageUnit"
										class="form-control" style="width:130px;font-size: 1.2em;"
										onchange="searchList(1);">
										<form:options
											items="${addBookFormVO.searchAddBookVO.pageUnitSelector}"
											itemValue="pageUnitValue" itemLabel="pageUnitLabel" />
									</form:select>
								</div>
							</div>
						</div>
						<div class="body">
							<div class="table-responsive">
								<table
									class="table table-hover js-basic-example dataTable table-custom table-striped m-b-0 c_list">
									<thead>
										<tr>
											<th><label class="fancy-checkbox"> <!-- TODO form input으로 -->
													<input class="select-all" type="checkbox" name="checkbox"
													id="manageId_0"> <span></span>
											</label></th>
											<th>이름(표시명)</th>
											<th>휴대폰</th>
											<th>이메일</th>
											<th>직급</th>
											<th>부서명</th>
											<th>그룹</th>
											<c:if test="${flag == 'private'}">
												<th>비고란</th>
											</c:if>
										</tr>
									</thead>
									<tbody>
										<c:choose>
											<c:when
												test="${flag == 'private' and (empty addBookList or addBookList[0].manageId eq null or addBookList[0].manageId == '')}">
												<tr>
													<td colspan="8" style="text-align: center;">자료가 존재하지
														않습니다.</td>
												</tr>
											</c:when>
											<c:when
												test="${flag == 'company' and fn:length(addBookList) == 0}">
												<tr>
													<td colspan="8" style="text-align: center;">자료가 존재하지
														않습니다.</td>
												</tr>
											</c:when>
										</c:choose>
										<!-- ####### 개인주소록 출력 ####### -->
										<c:if
											test="${addBookList[0].codeAddId != 'A01'  && addBookList[0].manageId != ''}">
											<c:forEach items="${addBookList}" var="addBook">
												<tr class="bookList"
													onclick="getDetail('${addBook.manageId}','private');">
													<td class="width45" onclick="event.cancelBubble=true">
														<label class="fancy-checkbox"> <input
															class="checkbox-tick" type="checkbox" name="checkbox">
															<span></span>
													</label>
													</td>
													<td id="manageId_${addBook.manageId}">
														<h6 class="mb-0">${addBook.manageDisplayName}</h6>
													</td>
													<td><span>${addBook.manageHp}</span></td>
													<td>${addBook.manageEmail}</td>
													<td>${addBook.manageOfficialName}</td>
													<td>${addBook.manageDeptName}</td>
													<td>${addBook.addBookTitle}</td>
													<td>${addBook.manageRemark}</td>
												</tr>
											</c:forEach>
										</c:if>
										<!-- ####### 회사주소록 출력 ####### -->
										<c:if
											test="${addBookList[0].empId !=null && addBookList[0].empId != ''}">
											<c:forEach items="${addBookList}" var="addBook">

												<tr class="bookList"
													onclick="getDetail('${addBook.empId}','company');">
													<td class="width45" onclick="event.cancelBubble=true">
														<label class="fancy-checkbox"> <input
															class="checkbox-tick" type="checkbox" name="checkbox">
															<span></span>
														</label> 
														<c:choose>
															<c:when test="${addBook.managePicture ne '없음'}">
																<img src="getPicture?picture=${ addBook.managePicture}"
																	class="rounded-circle avatar"
																	style="width: 40px; height: 40px;" alt="">
															</c:when>
															<c:otherwise>
																<img
																	src="<%=request.getContextPath()%>/resources/image/NO_IMAGE.png"
																	class="rounded-circle avatar" alt="">
															</c:otherwise>
														</c:choose>
													</td>
													<td id="manageId_${addBook.empId}">
														<h6 class="mb-0">${addBook.manageDisplayName}</h6>
													</td>
													<td><span>${ addBook.manageHp}</span></td>
													<td>${ addBook.manageEmail}</td>
													<td>${ addBook.manageOfficialName}</td>
													<td>${ addBook.manageDeptName}</td>
													<td>${ addBook.addBookTitle}</td>
												</tr>
											</c:forEach>
										</c:if>
									</tbody>
								</table>
							</div>
							<!-- Pagination -->
							<nav aria-label="Page navigation example"
								style="height: 45px; text-align: center; margin-top: 5px;">
								<ul class="pagination" style="display: inline-block;">
									<ui:pagination paginationInfo="${paginationInfo}" type="image"
										jsFunction="searchList" />
								</ul>
							</nav>
							<form:hidden path="searchAddBookVO.pageIndex" />
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</div>

<!--주소록 복사 모달창 -->
<div class="modal fade" id="groupModal" tabindex="-1" role="dialog"
	style="font-family: InfinitySans-RegularA1">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header" style="display: block; text-align: center;">
				<h4 class="title float-left" id="groupModalLabel">주소록 복사</h4>
				<button type="button" class="btn float-right" data-dismiss="modal"
					style="vertical-align: bottom;">X</button>
			</div>
			<div class="modal-body" id="modalBodyForGroup"
				style="padding: 20px; margin: auto;"></div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal"
					style="margin: auto;" onclick="copyAdd_go();">복사</button>
			</div>
		</div>
	</div>
</div>
<!--주소록 이동 모달창 -->
<div class="modal fade" id="moveModal" tabindex="-1" role="dialog"
	style="font-family: InfinitySans-RegularA1">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header" style="display: block; text-align: center;">
				<h4 class="title float-left" id="moveModalLabel">주소록 이동</h4>
				<button type="button" class="btn float-right" data-dismiss="modal"
					style="vertical-align: bottom;">X</button>
			</div>
			<div class="modal-body" id="modalBodyForMove"
				style="padding: 20px; margin: auto;"></div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal"
					style="margin: auto;" onclick="moveAdd_go();">이동</button>
			</div>
		</div>
	</div>
</div>



<script>

cssManager();
window.onload=function(){
	
	paginationCSS(${paginationInfo.currentPageNo},
			  ${paginationInfo.firstPageNoOnPageList},
			  ${paginationInfo.lastPageNoOnPageList},
			  ${paginationInfo.totalPageCount});
	
}


//검색 및 페이지네이션
function searchList(pageNo){
	if(!pageNo){
		pageNo = 1;
	}
	var listForm = $('form[name="listForm"]');
	$('input[name="searchAddBookVO.pageIndex"]').val(pageNo);
	listForm.submit();
	
}


// 개인주소록 새 등록
function registAddBook_go(){
	OpenWindow('<%=request.getContextPath()%>/addbook/registForm','주소록등록','700','560');
	
}

function getDetail(targetId, flag){
	
// 	console.log("targetId >> " + targetId);
	
	if(flag == 'private'){
		OpenWindow('<c:url value="detail?manageId="/>'+targetId,'주소록상세보기','700','580');
	}else if(flag == 'company'){
		OpenWindow('<c:url value="detail?empId="/>'+targetId,'주소록상세보기','700','732');
	}
	
	
}

// 개인주소록 내에서 이동
function moveAdd(){
	var manageIdArr = new Array(); // manageId 담을 배열. 개인주소록용
	    
	var moveCheckedTrArr = new Array();		  // check한 tr 담을 배열
	var moveCheckedLength = $("input:checked").length;
	
	manageIdArr, moveCheckedTrArr = []; // 초기화
	
	if(moveCheckedLength == 0){
		alert("이동할 주소록을 선택해주세요.");
		return false;
	}
	
	moveCheckedTrArr = $("input:checked"); // input n개
// 	console.dir(moveCheckedTrArr);
	
	for(var check of moveCheckedTrArr){
// 		console.log(check);
		if(check.id == 'manageId_0') continue; // all-check 부분은 pass
		
// 		console.dir($(check).parent().parent().parent().children());
		var splitedId = $(check).parent().parent().parent().children()[1].id.split('_')[1];
		if(splitedId != 0)manageIdArr.push(splitedId); // 0번인 select-all 빼고 push
	}
	
	$.ajax({
		type:"POST",
		url:"<%=request.getContextPath()%>/addbook/getGroupList",
		data:manageIdArr,
		contentType:"application/json",
		success: function(groupList) {
			var content = '<div class="input-group">' 
						 +'<form name="addBookFormVO" id="copyGroupForm" method="post" >'
						 +'<label for="modalAddBookId" class="float-left">그룹 선택</label>';
			content 	 +='<select name="addBookVO.addBookId" id="modalAddBookIdForMove" class="form-control float-right" style="min-width:15em;">'
							 	 +'<option value="0">전체주소록</option>';
			for(var idx = 0; idx < groupList.length ; idx++){
				content += '<option value="' + groupList[idx].addBookId + '">'+ groupList[idx].addBookTitle +'</option>';
				
			}
			content += 	'</select>'
						+'<input type="hidden" id="manageId" name="addBookVO.manageId" value="'+ manageIdArr +'">'
						+'</form>'
						+'</div>';
			
			$("#modalBodyForMove").html(content);
			
		},
		error: function(request, status, e) {
			console.log("request : " + request + ", status : " + status + ", e : " + e);
		}
	});
		
	

	$("#moveViewModal").click();
	
	
}

function moveAdd_go(){
		
	var manageId = $('#manageId').val(); // manageId 담을 문자열. , 로 잘라야 함.
	var addBookId = $('#modalAddBookIdForMove option:selected').val();
	var manageIdStr = '';
	
	
	console.log(manageId);
	console.log(addBookId);
	
	var sendData = {
			manageIdStr:manageId
			,addBookId:addBookId
	}
	
	$.ajax({
		url:"<c:url value='/addbook/moveAddBook'/>",
		type:'post',
		data:sendData,
		success:function(response){
			if(response > 0){
				alert("주소록이 이동되었습니다.");
				location.href="<c:url value='/addbook/list'/>";
			}else{
				alert("주소록 이동에 실패했습니다..");
			}
		},
		error:function(request, status, error){
			alert("주소록 이동에 실패했습니다..");
			console.log(error);
		}
		
	});	
	
}

// 회사 -> 개인주소록 복사 모달열기 (그룹 선택)
function copyAdd(){
	var empIdArr = new Array(); // empId 담을 배열. 회사주소록용
	var checkedTrArr = new Array();		  // check한 tr 담을 배열
	var checkedLength = $("input:checked").length;
	empIdArr, checkedTrArr = []; // 초기화
	
	if(checkedLength == 0){
		alert("복사할 주소록을 선택해주세요.");
		return false;
	}
	
	checkedTrArr = $("input:checked"); // input 3개
// 	console.dir(checkedTrArr);
	
	for(var check of checkedTrArr){
// 		console.log(check.id);
		if(check.id){ // all-check 부분은 pass
			continue;
		}
		var splitedId = $(check).parent().parent().parent().children()[1].id.split('_')[1];
		if(splitedId != 0)empIdArr.push(splitedId); // 0번인 select-all 빼고 push
	}
	
	
// 	console.log("모달 전");
// 	console.log(empIdArr);
	
	$.ajax({
		type:"POST",
		url:"<%=request.getContextPath()%>/addbook/getGroupList",
		data:empIdArr,
		contentType:"application/json",
		success: function(groupList) {
			var content = '<div class="input-group">' 
						 +'<form name="addBookFormVO" id="copyGroupForm" method="post" >'
						 +'<label for="modalAddBookId" class="float-left">그룹 선택</label>';
			content 	+= '<select name="addBookVO.addBookId" id="modalAddBookId" class="form-control float-right" style="min-width:15em;">'
							 	 +'<option value="0">전체주소록</option>';
			for(var idx = 0; idx < groupList.length ; idx++){
				content += '<option value="' + groupList[idx].addBookId + '">'+ groupList[idx].addBookTitle +'</option>';
				
			}
			content += 	'</select>'
						+'<input type="hidden" id="empId" name="addBookVO.empId" value="'+ empIdArr +'">'
						+'</form>'
						+'</div>';
			
			$("#modalBodyForGroup").html(content);
			
		},
		error: function(request, status, e) {
			console.log("request : " + request + ", status : " + status + ", e : " + e);
		}
	});
		
	

	$("#groupViewModal").click();
	
}

function copyAdd_go(){
	
	if(${flag eq 'company'}){
		
		var empId = $('#empId').val(); // manageId 담을 문자열. , 로 잘라야 함.
		var addBookId = $('#modalAddBookId option:selected').val();
		
		empIdArr = []; // 초기화
// 		console.log("초기화 후 arr");
// 		console.log(empIdArr);
		
// 		console.log("수정 전");
// 		console.log(empId);
		
		var sendData = {
				empId:empId
				,addBookId:addBookId
		}
		
		$.ajax({
			url:"<c:url value='/addbook/copyAddBook'/>",
			type:'post',
			data:sendData,
			success:function(response){
				if(response > 0){
					if(confirm("주소록이 복사되었습니다. 개인주소록으로 이동하시겠습니까?")){
						location.href='<c:url value="/addbook/list" />';
						window.close();					
					}else{
						if(window.opener) window.opener.location.reload(true);
						window.close();					
					}
				}else{
					alert("주소록 복사에 실패했습니다..");
				}
			},
			error:function(request, status, error){
				alert("주소록 복사에 실패했습니다..");
				console.log(error);
				window.close();
			}
			
		});	
	}
	
}

function dutySend(){
	
	var dutyEmpIdArr = new Array(); // empId 담을 배열. 개인주소록용
	var dutyEmpNameArr = new Array(); // empId 담을 배열. 개인주소록용
	
	var dutyCheckedTrArr = new Array();		  // check한 tr 담을 배열
	var dutyCheckedLength = $("input:checked").length;
	
	dutyEmpIdArr, dutyEmpNameArr, dutyCheckedTrArr = []; // 초기화
	
	if(dutyCheckedLength == 0){
		alert("업무제안을 전송할 대상을 선택해주세요.");
		return false;
	}
	
	dutyCheckedTrArr = $("input:checked"); // input n개
	console.dir(dutyCheckedTrArr);
	
	for(var check of dutyCheckedTrArr){
		if(check.id == 'manageId_0') continue; // all-check 부분은 pass
		
// 		console.dir($(check).parent().parent().parent().children());
		var splitedId = $(check).parent().parent().parent().children()[1].id.split('_')[1];
		var tempName = $(check).parent().parent().parent().children()[1].innerText;
		if(splitedId != 0)dutyEmpIdArr.push(splitedId); // 0번인 select-all 빼고 push
		if(tempName)dutyEmpNameArr.push(tempName); 
		
	}
	
	var openWin = window.open('/JoinWorkGW/board/duty/registForm?registParam=duty', '업무 작성', "width=1000, height=700");
	
	var tempTag = "";
	if(dutyCheckedTrArr[0].id == 'manageId_0'){
		for(var idx = 0; idx < dutyCheckedLength-1 ; idx ++){
			tempTag += '<div style="border:1px solid #ced4da;border-radius: 0.25rem;padding:10px 15px;width:150px;display:inline-block;">'
					+'<span>'+dutyEmpNameArr[idx]+'</span>'
					+'<div class="hiddenId manager" style="display:none;" value="'+dutyEmpIdArr[idx]+'"></div>'
					+'<i class="icon-close" style="float:right;cursor:pointer;margin-top:5px;" onclick="deleteElement(this);"></i>'
					+'</div>';
			
		}
	}else{
		for(var idx = 0; idx < dutyCheckedLength ; idx ++){
			tempTag += '<div style="border:1px solid #ced4da;border-radius: 0.25rem;padding:10px 15px;width:150px;display:inline-block;">'
					+'<span>'+dutyEmpNameArr[idx]+'</span>'
					+'<div class="hiddenId manager" style="display:none;" value="'+dutyEmpIdArr[idx]+'"></div>'
					+'<i class="icon-close" style="float:right;cursor:pointer;margin-top:5px;" onclick="deleteElement(this);"></i>'
					+'</div>';
			
		}
		
	}
	
	setTimeout(function(){
// 		console.log(openWin.document.getElementById("myEmpFinish"));
		openWin.document.getElementById("myEmpFinish").innerHTML = tempTag;
	},800)
	
}

// 개인주소록 삭제
function deleteAdds(){ 
	var manageIdArr = new Array(); // manageId 담을 배열. 개인주소록용
	var manageIdStr = '';
	var checkedTrArr = new Array();		  // check한 tr 담을 배열
	var checkedLength = $("input:checked").length;
	manageIdArr, checkedTrArr = []; // 초기화
	
	if(checkedLength == 0){
		alert('삭제할 주소록을 선택해주세요.');
		return false;
	}else {
		if($("input:checked")[0].id == 'manageId_0') checkedLength = checkedLength -1;
		if(confirm( checkedLength + '개의 주소록을 삭제하시겠습니까?')){
			
			checkedTrArr = $("input:checked"); // input n개
	//	 	console.dir(checkedTrArr);
			
			for(var check of checkedTrArr){
		 		console.log(check.id);
				if(check.id) continue; // all-check 부분은 pass
					
				var splitedId = $(check).parent().parent().parent().children()[1].id.split('_')[1];
				if(splitedId != 0){
					manageIdArr.push(splitedId); // 0번인 select-all 빼고 push
					manageIdStr += splitedId + ",";
				}
				
			}
			
			console.log(manageIdArr);
			var sendData = {
					manageIdStr:manageIdStr
			}
			console.log(sendData);
			
			$.ajax({
				url:"<c:url value='/addbook/remove'/>",
				type:'post',
				data:sendData,
				success:function(response){
					console.log(response);
					if(response > 0){
						alert("선택한 주소록 "+ checkedLength +"개를 삭제했습니다.");
						window.location.reload(true);
					}else{
						alert("주소록 삭제 중 오류가 발생했습니다.\n관리자에게 문의해주세요.");
						window.location.reload(true);
					}
				},
				error:function(request, status, error){
					alert("주소록 삭제 중 오류가 발생했습니다.\n관리자에게 문의해주세요.");
					console.log(error);
					window.close();
				}
				
			});	
		}
	}
	
	
	
	
}
function getExcel(){
	var checkedManageIdArr = new Array(); // manageId 담을 배열
	var checkedTrArr = new Array();		  // check한 tr 담을 배열
	var checkedLength = $("input:checked").length;
	checkedManageIdArr, checkedTrArr = []; // 초기화
	$("#appendDiv").empty();
	
	// 개인
// 	console.log("length >> " + checkedLength);
// 	console.log( $("input:checked"));
	
	checkedTrArr = $("input:checked");
	
	for(var check of checkedTrArr){
		if(check.id) continue; // all-check 거르는 부분. id 있으면 넘어가기.
		var splitedId = $(check).parent().parent().parent().children()[1].id.split('_')[1];
// 		console.log(splitedId);
		if(splitedId != 0)checkedManageIdArr.push(splitedId); // 0번인 select-all 빼고 push
	}
// 	console.log('for문 후');
// 	console.dir(checkedManageIdArr);
	
	var excelForm = document.excelForm;
// 	$(excelForm).empty();
	for(var id of checkedManageIdArr){
// 		console.log(id);
		$("#appendDiv").append($('<input/>',{type:"hidden",name:"manageIdArr",value:id}));
	}
	
	
	if(${flag eq 'private'}){ // 개인
		console.log('개인');
		excelForm.action = "<%=request.getContextPath()%>/addbook/getExcel";
	}else{
		console.log('회사');
		excelForm.action = "<%=request.getContextPath()%>/addbook/company/getExcel";
	}
	excelForm.submit();
}



function cssManager(){
	// 메뉴바 선택시 색깔 변경
	var menu = 'menu_'+location.href.split('JoinWorkGW/')[1].split('/')[1].split('=')[1];
	var companyMenu = 'menu_'+location.href.split('JoinWorkGW/')[1].split('=')[1];
	
	
	if(${flag eq 'private'}){
		if(menu == 'menu_undefined'){
			document.querySelector('#menu_private').style.backgroundColor = 'rgb(0 0 0/ 10%)';
			document.querySelector('#menu_private').scrollIntoView();
		}else{
			document.querySelector('#'+menu).style.backgroundColor = 'rgb(0 0 0/ 10%)';
			document.querySelector('#'+menu).scrollIntoView();
		}
	}else{
		if(companyMenu == 'menu_undefined'){
			document.querySelector('#menu_company').style.backgroundColor = 'rgb(0 0 0/ 10%)';
			document.querySelector('#menu_company').scrollIntoView();
		}else{
			document.querySelector('#'+companyMenu).style.backgroundColor = 'rgb(0 0 0/ 10%)';
			document.querySelector('#'+companyMenu).scrollIntoView();
		}
	}
	
	
	
}
</script>


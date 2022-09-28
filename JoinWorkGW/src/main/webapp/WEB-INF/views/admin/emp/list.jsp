<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<%-- <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/templates/assets/vendor/sweetalert/sweetalert.css"/> --%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/light/assets/fonts/font.css">
<%-- <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/templates/assets/vendor/jquery-datatable/dataTables.bootstrap4.min.css"> --%>

<style>
/* .btn-info{ */
/* 	background-color: #2980b9; */
/* 	border-color: #2980b9; */
/* } */
/* .btn-info:hover{ */
/* 	background-color: #2980b9; */
/* 	border-color: #2980b9; */
/* } */

#keyword > div.input-group{
	margin-left: 20px;
}
div.table-responsive>div.dataTables_wrapper>div.row{
	display: flex;
	flex-direction: row-reverse;
	justify-content: space-between;
}
.col-sm-12.col-md-6{
	padding-left: 0px;
}
.box-container{
	display: flex;
	margin: 20px 0px 10px 5px;
}
#registBtn{
	margin: 0px 0px 0px 5px;
}
span#getExcelBtn{
	font-size: large;
    vertical-align: bottom;
    padding-left: 10px;
    margin-top: 25px;
}
#DataTables_Table_0_filter{
	display: flex;
}
div#DataTables_Table_0_length{
	float: right;
}
#searchIcon{
	margin-left: 10px;
}
.table.table-custom.table tbody tr:hover {
	background-color: #ffc1077a;
	cursor: pointer;
}
#getExcelBtn:hover{
	cursor: pointer;
}
#pictureView{
	border-radius: 50%;
	border: 1px solid gray; 
	margin: 0px 20px 0px 0px;
	background-position: center;
	background-size: cover;
	background-repeat: no-repeat;
    display: inline-block;
    vertical-align: middle;
}
#infoSpan{
	margin: 10px;
}
#header-group{
	display: flex;
	justify-content: space-between;
}
#searchFormDiv{
	padding: 0 20px;
}
#resultNumSpan{
    vertical-align: -webkit-baseline-middle;
    font-size: 1.2em;
    margin: 0px 0px 0px 10px;
    color: rgb(68,68,68);
}
thead tr th, tbody tr td{
	text-align: center;
}
</style>
<!-- 메인 content -->
<div class="container-fluid">
	<!-- 메인 content 넣는 곳 -->

    <div class="row clearfix">
        <div class="col-lg-12">
            <div class="card">
            	<div class="header-group" id="header-group">
	                <div class="header col-lg-6">
	                	<span style="color: #a9a9a9; font-family: S-CoreDream-4Regular">조직 관리</span>
	                    <h3 style="font-family: S-CoreDream-6Bold">직원 목록</h3>
	                    <div class="box-container" style="font-family: S-CoreDream-7ExtraBold">
		                    <input type="button" onclick="registEmp();" class="btn btn-primary" id="registBtn" value="직원등록" style="font-family: S-CoreDream-6Bold">
		                    <form:form id="excelForm" name="excelForm" method="post" enctype="multipart/form-data">
			                    <span id="getExcelBtn" class="text-btn" onclick="getExcel()">
			                    	<a class="float-right" id="excelInfo" href="#" data-toggle="popover" data-trigger="hover" data-placement="bottom" data-html="true" data-content="직원을 체크하여 해당 직원 목록만 다운로드 가능합니다.<br/>미체크 시 모든 직원에 대한 목록을 다운로드합니다." style="font-family: InfinitySans-RegularA1">
				                    	<i class="fa fa-download"></i>
				                    	직원목록 다운로드
			                    	</a>
			                    </span>
			                    <div id="appendDiv" style="display: none;">
								<!-- 컨트롤러 가져갈 id 담은 input 넣을 곳 -->
								</div>
		                    </form:form>
	                    </div>
	                </div>
            	</div>
            	
            	<form:form commandName="empFormVO" id="listForm" name="listForm" method="post" >
					<div class="box" id="searchFormDiv" style="font-family: S-CoreDream-7ExtraBold">
						<form:select path="searchEmpVO.searchAuth" class="form-control selectSearch" style="width:150px;font-size: 1.2em;float:left;">
							<form:option value="">권한 전체</form:option>
							<form:option value="c">공통기능</form:option>
							<form:option value="t">팀장</form:option>
							<form:option value="e">임원</form:option>
							<form:option value="a">일반관리자</form:option>
							<form:option value="h">인사관리자</form:option>
							<form:option value="g">총무</form:option>
							<form:option value="s">시스템관리자</form:option>
						</form:select>
						<form:select path="searchEmpVO.searchCondition" class="form-control selectSearch" style="width:150px;font-size: 1.2em;float:left;">
							<form:option value="np">키워드 전체</form:option>
							<form:option value="n">이름</form:option>
							<form:option value="p">휴대폰</form:option>
						</form:select>
						<div id="navbar-search" class="navbar-form search-form selectSearch" style="float:left;">
							<form:input path="searchEmpVO.searchKeyword" class="form-control" placeholder="검색" type="text" style="width: 218px;height:36px;padding-right: 40px;" onkeypress="checkEnter(searchList);"  autocomplete="off"/>
							<button type="button" class="btn btn-default" onclick="searchList();"><i class="icon-magnifier"></i></button>
						</div>
						<div class="form-group float-left" id="resultNumDiv">
							<span id="resultNumSpan">[총 <fmt:formatNumber value="${paginationInfo.totalRecordCount }" type="number"/>개]</span>
						</div>
						<div class="form-group float-right">
							<div style="display: inline-block;float:left;font-size: 1.2em;margin:6px 20px 0 0">
								<span>${paginationInfo.currentPageNo} </span>/<span> ${paginationInfo.totalPageCount} 페이지 중</span>
							</div>
							<form:select path="searchEmpVO.pageUnit" class="form-control" style="width:130px;font-size: 1.2em;" onchange="searchList(1);">
								<form:options items="${empFormVO.searchEmpVO.pageUnitSelector}" itemValue="pageUnitValue" itemLabel="pageUnitLabel"/>
							</form:select>
						</div>
					</div>       
					<div class="body" style="font-family: S-CoreDream-7ExtraBold">
						<div class="table-responsive">
							<table class="table table-hover js-basic-example dataTable table-custom table-striped m-b-0 c_list">
								<thead class="thead-dark">
									<tr>
										<th style="text-align: left;">
											<label class="fancy-checkbox">
											    <input class="select-all" type="checkbox" name="checkbox" id="empId_0">
											    <span></span>
											</label>
	                                    </th>
	                                    <th>이름</th>
	                                    <th>사원번호</th>
	                                    <th>부서명</th>
	                                    <th>직급</th>
	                                    <th>권한</th>
	                                    <th>휴대폰</th>
	                                    <th>이메일</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${empList}" var="emp">
		                                <tr onclick="getDetail('${emp.empId}');">
		                                    <td class="width45" onclick="event.cancelBubble=true">
			                                    <label class="fancy-checkbox">
		                                            <input class="checkbox-tick" type="checkbox" name="checkbox" id="empId_${emp.empId }">
		                                            <span></span>
		                                        </label>
												<c:if test="${ emp.empPicture != null}">
													<div id="pictureView" style="background-image:url('${pageContext.request.contextPath }/admin/emp/getPicture?picture=${ emp.empPicture}'); width: 40px; height: 40px;" class="rounded-circle avatar" ></div>
												</c:if>
												<c:if test="${ emp.empPicture == null}">
													<div id="pictureView" style="background-image:url('${pageContext.request.contextPath }/resources/image/NO_IMAGE.png'); width: 40px; height: 40px;" class="rounded-circle user-photo"></div>
												</c:if>
		                                    </td>
		                                    <td>
		                                        <h6 class="mb-0">${emp.empName}</h6>
		                                    </td>
		                                    <td><span>${emp.empId }</span></td>
		                                    <td>${emp.deptName }</td>
		                                    <td>${emp.officialName }</td>
		                                    <c:choose>
		                                    	<c:when test="${emp.authId eq 'a04' }">
				                                    <td><span  class="badge badge-danger">${emp.authName }</span></td>
		                                    	</c:when>
		                                    	<c:when test="${emp.authId eq 'a07' }">
				                                    <td><span  class="badge badge-danger">${emp.authName }</span></td>
		                                    	</c:when>
		                                    	<c:otherwise>
				                                    <td>${emp.authName }</td>
		                                    	</c:otherwise>
		                                    </c:choose>
	                                        <c:choose>
		                                    	<c:when test="${empty emp.empHp }">
				                                    <td>없음</td>
		                                    	</c:when>
		                                    	<c:otherwise>
				                                    <td><span>${emp.empHp }</span></td>
		                                    	</c:otherwise>
		                                    </c:choose>
	                                        <c:choose>
		                                    	<c:when test="${empty emp.empEmail }">
				                                    <td>없음</td>
		                                    	</c:when>
		                                    	<c:otherwise>
				                                    <td><span>${emp.empEmail }</span></td>
		                                    	</c:otherwise>
		                                    </c:choose>
		                                </tr>
	                                </c:forEach>
								</tbody>
							</table>
						</div>
						<!-- Pagination -->
						<nav aria-label="Page navigation example" style="height:45px;text-align: center;margin-top:5px;">
							<ul class="pagination" style="display: inline-block;">
								<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="searchList" />
							</ul>
						</nav>
						<form:hidden path="searchEmpVO.pageIndex" />
					</div>	
				</form:form>
				
	            </div>
            </div>
        </div>
    </div>

<script src="${pageContext.request.contextPath }/resources/templates/light/assets/bundles/libscripts.bundle.js"></script>
<script src="${pageContext.request.contextPath }/resources/templates/light/assets/bundles/vendorscripts.bundle.js"></script>
             
<script src="${pageContext.request.contextPath }/resources/templates/light/assets/bundles/jvectormap.bundle.js"></script> <!-- JVectorMap Plugin Js -->
<script src="${pageContext.request.contextPath }/resources/templates/light/assets/bundles/morrisscripts.bundle.js"></script><!-- Morris Plugin Js -->
<script src="${pageContext.request.contextPath }/resources/templates/light/assets/bundles/knob.bundle.js"></script> <!-- Jquery Knob-->
<script src="${pageContext.request.contextPath }/resources/templates/assets/vendor/nestable/jquery.nestable.min.js"></script> <!-- Jquery Nestable -->
             
<script src="${pageContext.request.contextPath }/resources/templates/light/assets/bundles/mainscripts.bundle.js"></script>
<script src="${pageContext.request.contextPath }/resources/templates/light/assets/js/pages/ui/sortable-nestable.js"></script>

<script src="${pageContext.request.contextPath }/resources/templates/assets/vendor/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script><!-- bootstrap datepicker Plugin Js --> 
<script src="${pageContext.request.contextPath }/resources/templates/assets/vendor/bootstrap-multiselect/bootstrap-multiselect.js"></script>
<script src="${pageContext.request.contextPath }/resources/templates/assets/vendor/dropify/js/dropify.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/templates/light/assets/js/pages/forms/dropify.js"></script>



<script>

//검색 및 페이지네이션
function searchList(pageNo){
	if(!pageNo){
		pageNo = 1;
	}
	var listForm = $('form[name="listForm"]');
	$('input[name="searchEmpVO.pageIndex"]').val(pageNo);
	listForm.submit();
	
}


function getExcel(){
	var flag = $('#flag');
	var checkedEmpIdArr = new Array(); // empId 담을 배열
	var checkedTrArr = new Array();		  // check한 tr 담을 배열
	var checkedLength = $("input:checked").length;
	checkedEmpIdArr, checkedTrArr = [];
	$('#appendDiv').empty();
	
	// 개인
// 	console.log("length >> " + checkedLength);
// 	console.dir( $("input:checked").parent().parent().parent().children()[0].children[0].children[0].id.split('_')[1]); // id 나옴.
	
	checkedTrArr = $("input:checked").parent().parent().parent(); // tr n개
	
	for(var check of checkedTrArr){
		var splitedId = $(check).children()[0].children[0].children[0].id.split('_')[1];
// 		console.log(splitedId);
		if(splitedId != 0)checkedEmpIdArr.push(splitedId); // 0번인 select-all 빼고 push
	}
// 	console.dir(checkedEmpIdArr);
	
	var excelForm = document.excelForm;
	for(var id of checkedEmpIdArr){
		$('#appendDiv').append($('<input/>',{type:"hidden",name:"empIdArr",value:id}));
	}
	
	excelForm.action = "<%=request.getContextPath()%>/admin/emp/getExcel";
	excelForm.submit();
}

function getDetail(empId){
	//console.log(empId);
	OpenWindow('<%=request.getContextPath()%>/admin/emp/detail?empId='+empId,'직원상세조회','730','857');
}

function registEmp(){
	//alert('등록 클릭');
	OpenWindow('<%=request.getContextPath()%>/admin/emp/registForm','직원등록','730','910');
	
}

window.onload=function(){
	$('#DataTables_Table_0_filter > label > input').attr('placeholder','검색');
	$('#DataTables_Table_0_filter > label').append('<i class="fa fa-search" id="searchIcon"></i>');	
	
	
	paginationCSS(${paginationInfo.currentPageNo},
			  ${paginationInfo.firstPageNoOnPageList},
			  ${paginationInfo.lastPageNoOnPageList},
			  ${paginationInfo.totalPageCount});


}

</script>

</body>

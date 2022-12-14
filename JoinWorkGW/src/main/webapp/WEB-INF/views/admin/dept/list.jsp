<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/templates/light/assets/fonts/font.css">

<style>
.inner-card {
	border: 1px solid #dcdcdc;
	padding: 15px;
	margin: 0px;
	height: 100%;
}

.body {
	display: flex;
	justify-content: space-between;
	width: 100%;
}

input.btn {
	margin-bottom: 10px;
	float: right;
}

#getExcelBtn {
	margin-right: 25px;
	margin-top: 30px;
}

.table.table-custom.table tbody tr:hover, #detailView>tr:hover, tr.deptTr.mySelected,
	.deptTr.odd.mySelected {
	background-color: #ffc1077a !important;
	cursor: pointer;
}

#detailTitle {
	margin-bottom: 59px;
}

#getExcelBtn {
	cursor: pointer;
}

.form-group.row {
	width: 100%;
}

#editView label {
	width: 11em;
}

#editView label.deptHpLabel {
	width: 2em;
}

#editView form {
	width: 100%;
}

#editView input.btn, #editView button {
	width: 6em;
}

#editView div.input-group {
	padding-right: 0px;
}

#detailView {
	padding: 0 5px 0 20px;
}

#modifyHeaderBtns {
	margin-right: 35px;
	display: inline;
}

#deptLeaderIdDiv2, .deptStRadio {
	font-size: smaller;
}

#deptLeaderIdDiv2:focus, .deptStRadio {
	font-size: smaller;
}

h3.innerH {
	display: contents;
}

.box-container {
	display: inline;
}

.radioInput, .radioInput:hover, .radioInput:focus {
	width: 60px;
	/* 	font-size: smaller; */
}

.radioLabel, .radioLabel:hover, .radioLabel:focus {
	width: 60px;
}

#checkNameBtn {
	height: 2.5em;
}

thead tr th, tbody tr td {
	text-align: center;
}

div#searchFormDiv {
	margin: 40px 0px 20px;
}

#resultNumDiv {
	margin: 8px;
}

.form-control[readonly] {
	background-color: #ffffff;
}

#modifyBtn {
	margin: 15px 35px;
}
#hiddenFillBtn:hover {background-color: #ffffff;}
</style>


<!-- ?????? content -->
<div class="container-fluid">
	<!-- ?????? content ?????? ??? -->

	<div class="row clearfix">
		<div class="col-lg-12">
			<div class="card">
				<div class="header" style="padding-bottom:0px;">
					<div id="headDiv">
						<span style="color: #a9a9a9; font-family: S-CoreDream-4Regular">??????
							??????</span>
						<h3 style="font-family: S-CoreDream-6Bold">?????? ??? ??? ??????</h3>
					</div>
					<form:form id="excelForm" name="excelForm" method="post"
						enctype="multipart/form-data">
						<span id="getExcelBtn" class="text-btn float-right"
							onclick="getExcel()" style="margin-top:0px;font-family: S-CoreDream-7ExtraBold"><i
							class="fa fa-download"></i>???????????? ????????????</span>
					</form:form>
				</div>

				<div class="body">
					<div class="col-lg-7 col-md-12  float-left">
						<div class="card inner-card">
							<h3 class="innerH" style="font-family: S-CoreDream-6Bold">??????</h3>
							<div class="box-container">
								<button type="button" class="btn" id="hiddenFillBtn" onclick="presentationFill();" style="position:absolute;right:7em;top:1em;color:#ffffff">???????????????</button>
								<input type="button" onclick="registDept();"
									class="btn btn-primary" id="registBtn" value="????????????"
									style="font-family: S-CoreDream-6Bold">
							</div>
							<!-- ?????? ?????? -->
							<form:form commandName="deptFormVO" id="listForm" name="listForm"
								method="post" >
								<div class="box" id="searchFormDiv" style="font-family: S-CoreDream-7ExtraBold">
									<form:select path="searchDeptVO.searchCondition"
										class="form-control selectSearch"
										style="width:100px;font-size: 1em;float:left;">
										<form:option value="td">??????</form:option>
										<form:option value="t">???</form:option>
										<form:option value="d">??????</form:option>
									</form:select>
									<div id="navbar-search"
										class="navbar-form search-form selectSearch"
										style="float: left;">
										<form:input path="searchDeptVO.searchKeyword"
											class="form-control" placeholder="??????" type="text"
											style="width: 11em;height:36px;padding-right: 40px;"
											onkeypress="checkEnter(searchList);" autocomplete="off" />
										<button type="button" class="btn btn-default"
											onclick="searchList();">
											<i class="icon-magnifier"></i>
										</button>
									</div>
									<div class="form-group float-left" id="resultNumDiv">
										<span id="resultNumSpan">[??? <fmt:formatNumber
												value="${paginationInfo.totalRecordCount }" type="number" />???]
										</span>
									</div>
									<div class="form-group float-right">
										<div
											style="display: inline-block; float: left; font-size: 1em; margin: 6px 20px 0 0">
											<span>${paginationInfo.currentPageNo} </span>/<span>
												${paginationInfo.totalPageCount} ????????? ???</span>
										</div>
										<form:select path="searchDeptVO.pageUnit" class="form-control"
											style="width:130px;font-size: 1em;" onchange="searchList(1);">
											<form:options
												items="${deptFormVO.searchDeptVO.pageUnitSelector}"
												itemValue="pageUnitValue" itemLabel="pageUnitLabel" />
										</form:select>
									</div>
								</div>
								<div class="table-responsive"
									style="font-family: S-CoreDream-7ExtraBold">
									<table
										class="table table-hover js-basic-example dataTable table-custom table-striped m-b-0 c_list">
										<thead class="thead-dark">
											<tr>
												<th>??????</th>
												<th>??????</th>
												<th>??????</th>
												<th>?????????</th>
												<th>?????????</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${deptList}" var="dept">
												<tr class="deptTr" id="tr_${dept.deptId }"
													onclick="showDetail('${dept.deptId }');">
													<td>${dept.deptId }</td>
													<td>${dept.deptTeamYn}</td>
													<td>${dept.deptName }</td>
													<td>${dept.deptHp }</td>
													<c:choose>
														<c:when test="${dept.deptLeaderId eq '??????' }">
															<td>${dept.deptLeaderId }</td>
														</c:when>
														<c:otherwise>
															<td>${dept.deptLeaderName }</td>
														</c:otherwise>
													</c:choose>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
								<!--  Pagination  -->
								<nav aria-label="Page navigation example"
									style="height: 45px; text-align: center; margin-top: 5px;">
									<ul class="pagination" style="display: inline-block;">
										<ui:pagination paginationInfo="${paginationInfo}" type="image"
											jsFunction="searchList" />
									</ul>
								</nav>
								<form:hidden path="searchDeptVO.pageIndex" />
							</form:form>
						</div>
					</div>
					<!-- ???????????? -->

					<div class="col-lg-5 col-md-12 float-right" id="detailDiv">
						<div class="card inner-card"
							style="font-family: S-CoreDream-6Bold">
							<h3 class="innerH" id="detailTitle"
								style="font-family: S-CoreDream-6Bold">????????????</h3>
							<div style="padding: 20px; color: #ffffff;" id="marginDiv1">margin
								div</div>
							<div class="box-container">
								<input type="button" onclick="modifyDept();"
									class="btn btn-info float-right" id="modifyBtn"
									style="display: none;" value="????????????">
							</div>

							<div class="detailBody" id="detailView" style="display: none;">
								<div class="form-group row">
									<label class="col-sm-2 float-left" id="deptNameLabelForDeatil"
										style="margin-top: 10px;" for="deptNameForDetail">??????</label>
									<div class="col-sm-10 input-group" id="deptNameDivForDetail">
										<input type="text" name="deptNameForDetail"
											id="deptNameForDetail" class="form-control float-left"
											readonly />
									</div>
								</div>
								<div class="form-group row" id="deptTeamYnDivForDetail">
									<label class="col-sm-2 float-left" id="deptStLabelForDetail"
										for="deptTeamYnForDeatil">??????</label>
									<div class="col-sm-10 input-group"
										id="deptTeamYnDivForDetail-inner">
										<input type="text" name="deptTeamYnForDeatil"
											id="deptTeamYnForDeatil"
											class="form-control float-left radioInput" checked
											style="width: 60px;" readonly />
									</div>
								</div>
								<div class="form-group row">
									<label class="col-sm-2 float-left" for="deptHpForDetail">?????????</label>
									<div class="col-sm-10 input-group" id="deptHpDivForDetail">
										<input name="deptHpForDetail" id="deptHpForDetail"
											class="form-control float-right" style="width: 68px;"
											readonly />
									</div>
								</div>
								<div class="form-group row">
									<label class="col-sm-2 float-left" for="deptSupIdForDetail">????????????</label>
									<div class="col-sm-10 input-group" id="deptSupIdDivForDetail">
										<input name="deptSupIdForDetail" id="deptSupIdForDetail"
											class="form-control float-right" style="width: 68px;"
											readonly />
									</div>
								</div>
								<div class="form-group row">
									<label class="col-sm-2 float-left" for="deptLeaderIdForDetail">?????????</label>
									<div class="col-sm-10 input-group"
										id="deptLeaderIdDivForDetail">
										<input name="deptLeaderIdForDetail" id="deptLeaderIdForDetail"
											class="form-control float-right" style="width: 68px;"
											readonly />
									</div>
								</div>
								<div class="form-group row" id="deptEmpCountDivForDetail">
									<label class="col-sm-2 float-left" id="deptEmpCountForDetailLabel"
										for="deptStForDetail">????????????</label>
									<div class="col-sm-10 input-group" id="deptEmpCountDivForDetail2">
										<input type="text" name="deptEmpCountForDetail" id="deptEmpCountForDetail" class="form-control float-right" style="width: 68px;" readonly />
									</div>
								</div>
								<div class="form-group row" id="deptStDivForDeatil">
									<label class="col-sm-2 float-left" id="deptStLabelForDetail"
										for="deptStForDetail">??????</label>
									<div class="col-sm-10 input-group" id="deptStDivForDetail2">
										<input type="text" name="deptStForDetail" id="deptStForDetail"
											class="form-control float-left radioInput"
											style="width: 60px;" readonly />
									</div>
								</div>
							</div>

							<div class="detailBody" id="emptyDiv" style="text-align: center;">
								<p style="margin: 50% 0px;">?????? ???????????? ?????? ?????? ??? ??????????????? ???????????????.</p>
							</div>
						</div>
					</div>

					<!-- edit view -->
					<div class="col-lg-5 col-md-12 float-right" id="editView"
						style="display: none;">
						<div class="card inner-card"
							style="font-family: S-CoreDream-4Regular">
							<h3 class="innerH" id="modifyTitle"
								style="font-family: S-CoreDream-6Bold">??????/??? ??????</h3>
							<div style="padding: 10px; color: #ffffff;" id="marginDiv2">margin
								div</div>
							<div class="box-container" id="modifyHeaderBtns">
								<input type="button" onclick="showDetail();"
									class="btn btn-secondary float-right" value="??????"
									style="margin-right: 35px;"> <input type="button"
									onclick="modifySave();" class="btn btn-info float-right"
									id="modifySaveBtn" value="??????" style="display: none;"> <input
									type="button" onclick="regist();"
									class="btn btn-primary float-right" id="registSaveBtn"
									value="??????" style="display: none;">
							</div>
							<div class="body" id="modifyBody">
								<form id="modifyForm" name="modifyForm" class="horizontal"
									method="post" autocomplete="off">
									<div class="form-group row">
										<label class="col-sm-2 float-left" id="deptNameLabel2"
											style="margin-top: 10px;" for="deptName">??????</label>
										<div class="col-sm-10 input-group" id="deptNameDiv2">
											<input type="text" name="deptName" id="deptName2"
												class="form-control float-left" required="true"
												onchange="sameNameCheck(this);" />
											<button type="button"
												class="btn btn-sm btn-info  float-right" id="checkNameBtn"
												onclick="checkName();">????????????</button>
											<input type="hidden" value="0" id="dupleYN">
										</div>
									</div>
									<div class="form-group row">
										<label class="col-sm-2 float-left" for="deptHp">?????????</label>
										<c:set var="localTelArr"
											value="${fn:split('02,051,053,032,062,042,052,044,031,033,043,041,063,061,053,055,064',',') }" />
										<div class="col-sm-10 input-group" id="deptHpDiv2">
											<!-- select??? ?????? -->

											<label class="float-left deptHpLabel"
												style="padding: 0; text-align: center;">&nbsp;-&nbsp;</label>
											<input name="deptHp" id="deptHp2_2"
												class="form-control float-left" style="width: 68px;" /> <label
												class="float-left deptHpLabel"
												style="padding: 0; text-align: center;">&nbsp;-</label> <input
												name="deptHp" id="deptHp2_3"
												class="form-control float-right" style="width: 68px;" />
										</div>
									</div>
									<div class="form-group row">
										<label class="col-sm-2 float-left" for="deptSupId">????????????</label>
										<div class="col-sm-10 input-group" id="deptSupIdDiv">
											<!-- ???????????? select -->
										</div>
									</div>
									<div class="form-group row">
										<label class="col-sm-2 float-left" for="deptLeaderId2">?????????</label>
										<div class="col-sm-10 input-group" id="deptLeaderIdDiv2">
										</div>
									</div>
									<div class="form-group row" style="display: none;"
										id="deptStDiv">
										<label class="col-sm-2 float-left" id="deptStLabel2"
											for="deptSt">??????</label>
										<div class="col-sm-10 input-group" id="deptStDiv2">
											<input type="radio" name="deptSt" id="deptSt2_true"
												class="form-control float-left radioInput" value="1"
												style="width: 60px;" /> <label for="deptSt2_true"
												class="radioLabel">??????</label> <br> <input type="radio"
												name="deptSt" id="deptSt2_false"
												class="form-control float-left radioInput" value="0"
												style="width: 60px;" /> <label for="deptSt2_false"
												class="radioLabel">?????????</label>
										</div>
									</div>
									<div class="form-group row" id="deptTeamYnDiv"
										style="display: none;">
										<label class="col-sm-2 float-left" id="deptStLabel2"
											for="deptTeamYn">??????</label>
										<div class="col-sm-10 input-group" id="deptTeamYnDiv-inner">
											<input type="radio" name="deptTeamYn" id="deptTeamYn_Y"
												class="form-control float-left radioInput" value="Y"
												style="width: 60px;" /> <label for="deptTeamYn_Y"
												class="radioLabel">???</label> <br> <input type="radio"
												name="deptTeamYn" id="deptTeamYn_N"
												class="form-control float-left radioInput" value="N" checked
												style="width: 60px;" /> <label for="deptTeamYn_N"
												class="radioLabel">??????</label>
										</div>
									</div>
								</form>
							</div>

						</div>
					</div>

				</div>
			</div>
		</div>
	</div>
</div>

<!-- <input type="hidden" id="clickDeptId"> ?????? ??? deptId ?????? ??? ?????? -->
<input type="hidden" id="editViewClickYN" value="false">

<script
	src="${pageContext.request.contextPath }/resources/templates/light/assets/bundles/libscripts.bundle.js"></script>
<script
	src="${pageContext.request.contextPath }/resources/templates/light/assets/bundles/vendorscripts.bundle.js"></script>

<script
	src="${pageContext.request.contextPath }/resources/templates/light/assets/bundles/jvectormap.bundle.js"></script>
<!-- JVectorMap Plugin Js -->
<script
	src="${pageContext.request.contextPath }/resources/templates/light/assets/bundles/morrisscripts.bundle.js"></script>
<!-- Morris Plugin Js -->
<script
	src="${pageContext.request.contextPath }/resources/templates/light/assets/bundles/knob.bundle.js"></script>
<!-- Jquery Knob-->
<script
	src="${pageContext.request.contextPath }/resources/templates/assets/vendor/nestable/jquery.nestable.min.js"></script>
<!-- Jquery Nestable -->

<script
	src="${pageContext.request.contextPath }/resources/templates/light/assets/bundles/mainscripts.bundle.js"></script>
<script
	src="${pageContext.request.contextPath }/resources/templates/light/assets/js/pages/ui/sortable-nestable.js"></script>

<script
	src="${pageContext.request.contextPath }/resources/templates/assets/vendor/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script>
<!-- bootstrap datepicker Plugin Js -->
<script
	src="${pageContext.request.contextPath }/resources/templates/assets/vendor/bootstrap-multiselect/bootstrap-multiselect.js"></script>
<script
	src="${pageContext.request.contextPath }/resources/templates/assets/vendor/dropify/js/dropify.min.js"></script>
<script
	src="${pageContext.request.contextPath }/resources/templates/light/assets/js/pages/forms/dropify.js"></script>



<script
	src="<%=request.getContextPath()%>/resources/templates/light/assets/bundles/libscripts.bundle.js"></script>
<!-- jqeury ?????? -->
<script
	src="<%=request.getContextPath()%>/resources/templates/light/assets/bundles/vendorscripts.bundle.js"></script>
<!-- matchmenu? ?????? -->


<script
	src="<%=request.getContextPath()%>/resources/templates/light/assets/bundles/mainscripts.bundle.js"></script>
<!-- ????????? ????????? -->
<script
	src="<%=request.getContextPath()%>/resources/templates/light/assets/js/index.js"></script>
<!-- ???????????? -->
<script
	src="<%=request.getContextPath()%>/resources/templates/light/assets/js/pages/tables/jquery-datatable.js"></script>
<!-- ?????? ????????????. -->

<script>

var detailResponse = ''; // ????????? ?????? ????????? ?????? ????????????
var oldDeptId = ''; // dept ???????????? ????????? ?????? ?????? dept tr??? id

window.onload = function(){
// 	$('.deptTr').on('click', function(){
// 		$(this).css('background-color','#ffc1077a');
// 	});

// 	$('#DataTables_Table_1_info').css('display','none');
// 	$('#DataTables_Table_0_wrapper').

	$('#navbar-search').finish();
	$('#searchDeptVO.searchKeyword').finish();
	console.dir($('#navbar-search'));
	$('#navbar-search').off("animate");
	$('#searchDeptVO.searchKeyword').off("animate");

	$('#DataTables_Table_0_length').parent().removeClass('col-sm-12 col-md-6');
	$('#DataTables_Table_0_length').parent().addClass('col-sm-10 col-md-5').css('margin-right','60px');
	$('#DataTables_Table_0_filter > label > input').attr('placeholder','??????');
	$('#DataTables_Table_0_filter > label').append('<i class="fa fa-search" id="searchIcon" style="margin-left: 10px;"></i>');	
	
	paginationCSS(${paginationInfo.currentPageNo},
				${paginationInfo.firstPageNoOnPageList},
				${paginationInfo.lastPageNoOnPageList},
				${paginationInfo.totalPageCount});


}

function searchList(pageNo){
	if(!pageNo){
		pageNo = 1;
	}
	var listForm = $('form[name="listForm"]');
	$('input[name="searchDeptVO.pageIndex"]').val(pageNo);
	listForm.submit();
	
}


function showDetail(input){
	if(oldDeptId) $('#'+oldDeptId).removeClass('mySelected');
	$('#marginDiv1').css('padding','0px').css('display','');
	$("#editView").css("display","none");
	$('#deptStDiv').css('display','none');
	$('#emptyDiv').css('display','none');
	$("#detailDiv").css("display","");
	$("#detailView").css("display","");
	$('#modifyBtn').css('display','');
	
	if(input){
		$('#tr_'+input).addClass('mySelected');
		oldDeptId = "tr_"+input;
//	 	$('#clickDeptId').val(input); // ?????? ??? deptId ???????????? ?????? hidden ??????
		
		var sendData = {deptId:input};
		
		
		$.ajax({
			url: "<%=request.getContextPath()%>/admin/dept/detail"
			,type: "post"
	        ,data: sendData
	        ,dataType:'json'
	        ,success: function (response) {
//	 			console.dir(response);
				detailResponse = response;
				console.log("?????? ??? >> " + response.deptEmpCount);
				var sendHTML = "";
				if(response != null){
// 					var leader = "??????";
					$('#marginDiv').css('display','');
					$('#modifyBtn').css('display','');
					
					$('#deptNameForDetail').val(response.deptName);
					$('#deptHpForDetail').val(response.deptHp);
					if(response.deptLeaderId === '??????'){
						$('#deptLeaderIdForDetail').val(response.deptLeaderId);
					}else{
						$('#deptLeaderIdForDetail').val(response.deptLeaderName);
					}		
					if(response.deptSupName){
						$('#deptSupIdForDetail').val(response.deptSupName);
					}else{
						$('#deptSupIdForDetail').val('??????');
					}
					$('#deptStForDetail').val(response.deptSt);
					$('#deptTeamYnForDeatil').val(response.deptTeamYn);
					$('#deptEmpCountForDetail').val(response.deptEmpCount);
					
				}else{
//	 				$('#marginDiv').css('display','');
					$('#modifyBtn').css('display','none');
					$('#emptyDiv').css('display','');
					$("#detailView").css("display","none");
					
				}
	        }
	        ,error: function(request, status, error){
	     	   console.log("error ?????? >> " +error); // ????????? on?????? ??????
	     	   
	        }
			
		});
	}else{
		$('#modifyBtn').css('display','none');
		$('#emptyDiv').css('display','');
		$("#detailView").css("display","none");
		
	}
	
				
}
//??????

function registDept(){
	$('#marginDiv1').css('display','none');
	var editViewClickYN = $('#editViewClickYN');
	if(editViewClickYN.val() == 'true'){
		$("#deptHpDiv2").children().eq(0).remove();
		$('#deptLeaderIdDiv2').children().eq(0).remove();
		$('#deptSupIdDiv').children().eq(0).remove();
	}
	editViewClickYN.val(true);
	
	$('#modifyTitle').html("??????/??? ??????");
	$('#detailDiv').css('display','none');
	$('#marginDiv').css('display','none');
	$('#editView').css('display','');
	$('#deptStDiv').css('display','none');
	$('#modifySaveBtn').css('display','none');
	$('#registSaveBtn').css('display','');
	$('#deptTeamYnDiv').css('display','');
	$('#deptName2').val('');
	$('#deptHp2_2').val('');
	$('#deptHp2_3').val('');
	$('input:radio[name="deptSt"]').removeAttr('checked');
	
	var deptHpSelect = '<select name="deptHp" id="deptHp2" class="form-control float-left" style="width:75px;">'
		+'<option value="">-??????-</option>'
		+'<c:forEach items="${localTelArr }" var="tel">'
			+'<option value="${tel }">${tel }</option>'
		+'</c:forEach>'
	+'</select>'
	;
	$('#deptHpDiv2').prepend(deptHpSelect);
	
	var deptLeaderIdContent = '<select name="deptLeaderId" id="deptLeaderId2" class="form-control float-left" style="width:75px;">'
	 	 +'<option value="">-??????-</option>'
		 +'<c:forEach items="${empList }" var="emp">'
		 	+'<option value="${emp.empId }">${emp.empName } ${emp.officialName } / ${emp.deptName }</option>'
		 +'</c:forEach>'
	 +'</select>'
	 ;
	$('#deptLeaderIdDiv2').prepend(deptLeaderIdContent); 
	
	var deptSupIdContent =  '<select name="deptSupId"  id="deptSupId" class="form-control">'
		   +'<option value="">-??????????????????-</option>'
		   +'<c:forEach items="${supDeptList }" var="supDept">'
				+'<option value="${supDept.deptId}">${supDept.deptName}</option>'
		   +'</c:forEach>'
	   +'<select>'
		;
	$('#deptSupIdDiv').prepend(deptSupIdContent);
	
	return false;
	
}

function checkName(){
	var deptName = $('#deptName2').val().trim();
	var sendData = {deptName:deptName}; 
	
	if(!deptName || deptName == ""){
		alert("???????????? ??????????????????.");
		return false;
	}
	
	if(sameNameCheck($('#deptName2'))){
		alert('?????? ????????? ??????????????????.');
		return false;
	}
	
	$.ajax({
		url:'<c:url value="/admin/dept/checkName"/>'
		,type: "post"
        ,data: sendData
        ,success: function (response) {
			if(response > 0){
				alert('????????? ???????????? ????????????. ?????? ??????????????????.');
				$('#dupleYN').val(0);
				return false;
			}else{
				alert('??????????????? ??????????????????.');
				$('#dupleYN').val(1);
				return;
			}
        }
        ,error: function(request, status, error){
     	   console.log("error ?????? >> " +error);
        }
	});
}

function regist(){
	var deptName = $('input[name="deptName"]').val();
	var deptHpSel = $('select[name="deptHp"] option:selected').val();
	var deptHpArr = $('input[name="deptHp"]');
	var deptSupId = $('select[name="deptSupId"] option:selected').val();
	var deptLeaderId = $('select[name="deptLeaderId"] option:selected').val();
	var deptTeamYn = $('[name="deptTeamYn"]:checked').val();
	var deptHp = '';
	if(deptHpArr[0]){
		deptHpSel + "-" + deptHpArr[0].value + "-" + deptHpArr[1].value;
	}
	
	console.log("deptHpSel >> " + deptHpSel);
	console.log("deptHp >> " + deptHp);
	
	// ----- ????????? ?????? --- 
	var numberReg = /[0-9]/;
	// ----- ????????? ?????? --- 
	
	if(!deptName || deptName == ''){
		alert('???????????? ???????????????.');
		return false;
	}else if($('#dupleYN').val() == 0){
		alert('????????? ??????????????? ???????????????.');
		return false;
	}else if(deptHpSel){
		if(!numberReg.test(deptHpArr[0].value) || !numberReg.test(deptHpArr[1].value)){
			alert('??????????????? ????????? ??????????????????.');
			return false;
		}
	}

	
	var sendData = {
			deptName:deptName
			,deptHp:deptHp
			,deptSupId:deptSupId
			,deptLeaderId:deptLeaderId
			,deptTeamYn:deptTeamYn
	}
	
	console.dir(sendData);
	
	$.ajax({
		url:'<c:url value="/admin/dept/regist" />'
		,type:'post'
		,data:sendData
		,success:function(response){
				if(response > 0){
					alert('?????????????????????.');
// 					$('#marginDiv').css('display','');
					location.href="<c:url value='/admin/dept/list'/>";
				}else{
					alert('????????? ?????????????????????.');
				}
		}
		,error:function	(request,status,error){
			console.log('???????????? >> ' + error);
		}
		
	});
	
	return false;
}


function sameNameCheck(input){
	var deptName = '';
	if(input != 'undefined' && input != ''){
		deptName = $(input).val();
	}else{
		deptName = $('#deptName2').val();
	}
	if(deptName == detailResponse.deptName){
		$('#dupleYN').val(1);
	}
	
	return deptName == detailResponse.deptName;
}

//??????
function modifyDept(){
	$('#marginDiv1').css('display','none');
	var editViewClickYN = $('#editViewClickYN');
	if(editViewClickYN.val() == 'true'){
		$("#deptHpDiv2").children().eq(0).remove();
		$('#deptLeaderIdDiv2').children().eq(0).remove();
		$('#deptSupIdDiv').children().eq(0).remove();
	}
	editViewClickYN.val(true);
// 	var deptId = $('#clickDeptId').val();
	var deptId = detailResponse.deptId;
	console.log("deptId >> " + deptId);
	
	var sendData = {
			deptId:deptId
	}
	
	
	$.ajax({
		url:'<c:url value="/admin/dept/modifyForm" />'
		,type:'post'
		,data:sendData
		,success:function(response){
			$('#modifyTitle').html("??????/??? ??????");
// 			$('#marginDiv').css('display','none');
			$('#detailDiv').css('display','none');
			$('#editView').css('display','');
			$('#deptStDiv').css('display','');
			$('#modifySaveBtn').css('display','');
			$('#registSaveBtn').css('display','none');
			$('#deptTeamYnDiv').css('display','none');
			$('#deptTeamYnDiv').css('display','none');
			
			$('#deptName2').val(response.deptVO.deptName);
			
			var deptHpSelect = '<select name="deptHp" id="deptHp2" class="form-control float-left" style="width:75px;">'
									+'<option value="">-??????-</option>'
									+'<c:forEach items="${localTelArr }" var="tel">'
										+'<option value="${tel }">${tel }</option>'
									+'</c:forEach>'
								+'</select>'
			;
			$('#deptHpDiv2').prepend(deptHpSelect);
			
			var deptHpArr = response.deptVO.deptHp.split('-');
			$('#deptHp2').val(deptHpArr[0]).prop("selected",true);
			$('#deptHp2_2').val(deptHpArr[1]);
			$('#deptHp2_3').val(deptHpArr[2]);
			

			var deptLeaderIdContent = '<select name="deptLeaderId" id="deptLeaderId2" class="form-control float-left" style="width:75px;">'
									 	 +'<option value="">-??????-</option>'
										 +'<c:forEach items="${empList }" var="emp">'
										 	+'<option value="${emp.empId }">${emp.empName } ${emp.officialName } / ${emp.deptName }</option>'
										 +'</c:forEach>'
									 +'</select>'
									 ;
			$('#deptLeaderIdDiv2').prepend(deptLeaderIdContent); 
			if(response.deptVO.deptLeaderId != '??????') $('#deptLeaderId2').val(response.deptVO.deptLeaderId).prop("selected",true);
			
			var deptSupIdContent =  '<select name="deptSupId"  id="deptSupId" class="form-control">'
									   +'<option value="">-??????????????????-</option>'
									   +'<c:forEach items="${supDeptList }" var="supDept">'
											+'<option value="${supDept.deptId}">${supDept.deptName}</option>'
									   +'</c:forEach>'
								   +'<select>'
									;
			$('#deptSupIdDiv').prepend(deptSupIdContent);
			$('#deptSupId').val(response.deptVO.deptSupId).prop("selected",true);
			
			if(response.deptVO.deptSt == '??????'){
				$('#deptSt2_true').attr('checked','checked');
			}else{
				$('#deptSt2_false').attr('checked','checked');
			}
			
		}
		,error:function	(request,status,error){
			console.log('???????????? >> ' + error);
		}
		
	});
	return false;
	
}

function modifySave(){
	var deptId = detailResponse.deptId;
	var deptName = $('input[name="deptName"]').val();
	var deptHpSel = $('select[name="deptHp"] option:selected').val();
	var deptHpArr = $('input[name="deptHp"]');
	var deptSupId = $('select[name="deptSupId"] option:selected').val();
	var deptLeaderId = $('select[name="deptLeaderId"] option:selected').val();
	var deptSt = $('[name="deptSt"]:checked').val();
	var deptHp = '';
	if(deptHpArr[0].value != ''){
		deptHp = deptHpSel + "-" + deptHpArr[0].value + "-" + deptHpArr[1].value;
	}
	
// 	console.log("deptHpSel >> " + deptHpSel);
// 	console.log("deptHp >> " + deptHp);

	if(!sameNameCheck($('#deptName2'))){
		if($('#dupleYN').val() == 0){
			alert('????????? ??????????????? ???????????????.');
			return false;
		}
	} 
	
	if(detailResponse.deptEmpCount > 0){
		if(deptSt == 0){
			alert('?????? ????????? ?????? ?????? \n????????? ???????????? ??? ??? ????????????.');
			return false;
		}
	}
	var sendData = {
			deptId:deptId
			,deptName:deptName
			,deptHp:deptHp
			,deptSupId:deptSupId
			,deptLeaderId:deptLeaderId
			,deptSt:deptSt
	}
// 	console.log("????????? sendData >> " + sendData);
	
	$.ajax({
		url:'<c:url value="/admin/dept/modify" />'
		,type:'post'
		,data:sendData
		,success:function(response){
				if(response > 0){
					alert('?????????????????????.');
// 					$('#marginDiv').css('display','');
					location.href="<c:url value='/admin/dept/list'/>";
				}else{
					alert('????????? ?????????????????????.');
				}
		}
		,error:function	(request,status,error){
			console.log('???????????? >> ' + error);
		}
		
	});
	
	return false;
}

function getExcel(){
	//alert('???????????? ??????!');
	var excelForm = document.excelForm;
	excelForm.action = "<%=request.getContextPath()%>/admin/dept/getExcel";
	excelForm.submit();
	
}
</script>
<script> // ?????????
function presentationFill(){
// 	alert('??????');
	
	$('input[name="deptName"]').val('?????????????????????');
	$('select[name="deptHp"] option[value="042"]').attr("selected",true);
	$('input[name="deptHp"]').each(function(idx){
		if(idx == 0){
			$(this).val('523');
		}else{
			$(this).val('0504');
		}
	});
	$('select[name="deptLeaderId"] option[value="201006JW0201"]').attr("selected",true);
	
}
</script>



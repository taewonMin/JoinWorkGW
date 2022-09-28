<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/light/assets/fonts/font.css">

<style>
.inner-card{
	border: 1px solid #dcdcdc;
	padding: 15px;
	margin: 0px;
}
.body{
	display: flex;
	justify-content: space-between;
	width: 100%;
}
#modifyBtn, #registBtn{
	margin: 10px 0px 10px;
}
#headDiv{
	float: left;
	
}
#getExcelBtn{
	margin-right: 25px;
    margin-top: 30px;
}
.table.table-custom.table tbody tr:hover,  #detailView > tr:hover , .officialTr.even.mySelected , .officialTr.odd.mySelected{
	background-color: #ffc1077a !important;
	cursor: pointer;
}
#detailTitle {
	margin-bottom: 59px;
}
#getExcelBtn{
	cursor: pointer;
}
.box-container{
	display: inline;
}
h3.innerH{
	display: contents;
}
thead tr th, tbody tr td{
	text-align: center;
}
input#registBtn {
    margin: 0 5px 15px;
}
#DataTables_Table_0_paginate{
	float: left !important;
}
</style>
<!-- 메인 content -->
<div class="container-fluid">
	<!-- 메인 content 넣는 곳 -->

    <div class="row clearfix">
        <div class="col-lg-12">
            <div class="card">
                <div class="header">
                	<div id="headDiv">
    	            	<span style="color: #a9a9a9; font-family: S-CoreDream-4Regular">조직 관리</span>
	                    <h3 style="font-family: S-CoreDream-6Bold">직급 관리</h3>
                	</div>
                    <form:form id="excelForm" name="excelForm" method="post" enctype="multipart/form-data">
	                    <span id="getExcelBtn" class="text-btn float-right" style="font-family: S-CoreDream-6Bold; font-size: 18px;" onclick="getExcel()"><i class="fa fa-download"></i>직급목록 다운로드</span>
                    </form:form>
                </div>
                
                
                
                <div class="body" style="font-family: S-CoreDream-6Bold">
	                <div class="col-lg-6 col-md-12  float-left">
	                	<div class="card inner-card">
		                    <h3 class="innerH" style="font-family: S-CoreDream-6Bold">직급</h3>
		                    <div class="box-container">
			                    <input type="button" onclick="registOfficial();" class="btn btn-primary float-right" id="registBtn" value="직급추가" style="font-family: S-CoreDream-6Bold">
		                    </div>
		                    <div class="table-responsive">
		                        <table class="table table-hover js-basic-example dataTable table-custom table-striped m-b-0 c_list">
		                            <thead class="thead-dark">
		                                <tr>
		                                    <th>직급코드</th>
		                                    <th>직급명</th>
		                                    <th style="width: 30%;">사용인원(명)</th>
		                                </tr>
		                            </thead>
		                            <tbody>
		                            	<c:forEach items="${officialList}" var="official">
			                                <tr class="officialTr" id="tr_${official.codeId }" onclick="showDetailTable('${official.codeId }');">
			                                    <td>${official.codeId }</td>
			                                    <td>${official.codeName }</td>
			                                    <td>${official.useCount }</td>
			                                </tr>
		                                </c:forEach>
		                            </tbody>
		                        </table>
		                    </div>
		                </div>
	                </div>
	                <div class="col-lg-6 col-md-12 float-right">
	                	<div class="card inner-card">
		                    <h3 id="detailTitle" style="margin-bottom: 20px;">직급 상세조회</h3>
		                    <div style="padding: 16px; color: #ffffff;" id="marginDiv1">margin div</div>
		                    <div class="box-container">
			                    <input type="button" onclick="modifyOfficial();" class="btn btn-info float-right" id="modifyBtn" style="display: none;"value="직급수정">
		                    </div>
	                		<div class="table" id="emptyDetailDiv">
		                        <table class="table table-hover table-striped " id="detailTable">
		                            <thead class="thead-dark">
		                                <tr>
		                                    <th style="width: 25%;">NO</th>
		                                    <th style="width: 35%;">직원명</th>
		                                    <th style="width: 40%;">사원번호</th>
		                                </tr>
		                            </thead>
		                        </table>
		                    </div>
	                	</div>
	                </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input type="hidden" id="clickOfficial">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>
<script>

var beforePagingSelect = ''; // 페이징 넘어가기 전 선택한 tr의 id
var oldOfficialId = ''; // official 선택표시 해제를 위한 이전 official tr의 id


function registOfficial(){
	//alert('직급추가 클릭');
	OpenWindow('<%=request.getContextPath()%>/admin/official/registForm','직급추가','490','307');
	
}

function showDetailTable(input){
	
	$('#detailTable').find('tbody').remove();
	if(oldOfficialId) $('#'+oldOfficialId).removeClass('mySelected');
	$('#marginDiv1').css('display','none');
	
	
	var clickOfficial = $('#clickOfficial');
	clickOfficial.val(input);
	$('#tr_'+input).addClass('mySelected');
	oldOfficialId = "tr_"+input;
	beforePagingSelect = "tr_"+input;
	
	var sendData = {codeOfficialId:input};
	
	var dt = $('#detailTable').DataTable({
		scrollY:446
		,ajax: {
				"type" : "POST"
				,"url" : "<c:url value='/admin/official/detail' />"
				,"data": sendData
				,"dataType": "JSON"
		}
		,columns: [
		              { data: null }
		              ,{ data: "empName" }
		              ,{ data: "empId" }
		]
		,destroy:true // 다른 직급 detail 조회 시 기존 테이블 삭제 후 다시 dt 생성
		,columnDefs: [ { // 0번 컬럼 정의
            "searchable": false
            ,"orderable": false
            ,"targets": 0
        } ]
		,tr:{"height":"50px"}
	});
	dt.on('order.dt search.dt',function(){
		dt.column(0,{ search:'applied', order:'applied'}).nodes().each( function(cell,i){
			cell.innerHTML = i+1;
		});
	}).draw();
	
	setTimeout(function(){ // dataTable 생성 후 onclick 이벤트 바인딩
// 		console.dir(dt.context[0].nTBody.children.item(2).children[2].innerText); // empId
		var dtRow = dt.context[0].nTBody.children;
		$(dtRow).each(function(index, item){
			var empId = item.children[2].innerText;
			$(item).css('cursor','pointer');
			$(item).on('click',function(){
				OpenWindow('<c:url value="/admin/emp/detail?empId='+empId+'"/>','직원상세조회','730','857');
			});
			
		});
		
		
	},500);
}




function modifyOfficial(){
	//alert('직급수정 클릭');
	var codeId = $('#clickOfficial').val();
// 	console.log("codeId >> " + codeId);
	OpenWindow('<%=request.getContextPath()%>/admin/official/modifyForm?codeId='+codeId,'직급수정','490','307');
}

function getExcel(){
	var excelForm = document.excelForm;
	excelForm.action = "<%=request.getContextPath()%>/admin/official/getExcel";
	excelForm.submit();
}

// function resetSelected(){
// 	console.log($('.officialTr').hasClass('mySelected'));
// 	if($('.officialTr').hasClass('mySelected')){
// 		alert('있음');	
// 	}
	
// 	if(oldOfficialId) $('#'+oldOfficialId).removeClass('mySelected');
// }


window.onload=function(){
	$('#DataTables_Table_1_info').css('display','none');
// 	$('#DataTables_Table_0_wrapper').
	$('#DataTables_Table_0_length').parent().removeClass('col-sm-12 col-md-6');
	$('#DataTables_Table_0_length').parent().addClass('col-sm-10 col-md-5').css('margin-right','60px');
	$('#DataTables_Table_0_filter > label > input').attr('placeholder','검색');
	$('#DataTables_Table_0_filter > label').append('<i class="fa fa-search" id="searchIcon" style="margin-left: 10px;"></i>');	

	
	// 상세조회 다음 페이지 tr에 click이벤트 바인딩
	$(document).on('click','ul.pagination li.paginate_button',function(){
		var dtRow = $('#detailTable').find('tr');
		$(dtRow).each(function(index, item){
// 			console.log(item.children[2].innerHTML);
			if((item.children[2].innerHTML).length < 13){
// 				console.log('if 들어옴');
				var empId = item.children[2].innerText;
				$(item).css('cursor','pointer');
				$(item).on('click',function(){
					OpenWindow('<c:url value="/admin/emp/detail?empId='+empId+'"/>','직원상세조회','730','857');
				});
				
			}
		});
	});
}

$(document).on('click','.page-link',function(){
	//alert('asdf');
	$('.mySelected').removeClass('mySelected');
});
</script>

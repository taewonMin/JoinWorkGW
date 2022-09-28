<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/js/treeview/jquery.treeview.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/js/treeview/screen.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/emp.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/common.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/treeview/jquery.cookie.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/treeview/jquery.treeview.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/treeview/jquery.treeview.edit.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/treeview/jquery.treeview.async.js"></script>

<body style="background-color: #f4f7f6;">

<div class="wrapper">
	
	<!-- 메인 content -->
	<div id="main-content" style="margin-top: 20px;">
		<div class="container-fluid" style="font-size: 16px;">
		
			<div class="row clearfix" style="margin-bottom: 1%;">
				<div class="col-12" style="font-family: S-CoreDream-4Regular">
	               	<div>
	               		<span style="font-size: xx-large; ">결재양식 선택</span>
	               		<hr>
	              	</div>
              	</div>
            </div>
            
            <div class="inside-wrapper" style="padding:0 3% 3% 3%; background-color: white; border-radius: 2%; box-shadow: 0 1px 2px 0 rgb(0 0 0 / 10%); font-family: S-CoreDream-4Regular">
				<div class="row clearfix">
					<div class="col-12">
		               	<div>
		               		<span class="float-right" onclick="saveForm_go();" style=" font-size: 1.1rem; padding-bottom: 1%; padding-top: 2.5%;"><p class="addForm">+ 자주 쓰는 양식으로 추가</p></span>
		              	</div>
	              	</div>
	            </div>
				<!-- 메인 content 넣는 곳 -->
				<div class="row clearfix">
	                <div class="col-6">
	                	<div class="card" >
	                	
		                	<div class="header" style="background-color: #D8D8D8; height: 70px;">
			                    <input id="searchKeyword" type="search" class="form-control" placeholder="이름으로 검색" style="display: inline-block; width: 75%;">
				                <button type="button" class="btn btn-dark" onkeyup="enterkey();"><i class="icon-magnifier"></i></button>
		               		</div>
	                		<div class="body" style="overflow: auto; height: 300px;">
	                			<div>
									<ul id="codeList">
										<li>결재양식
											<ul id="lvl0"></ul> 
										</li>
									</ul>
								</div>
	                		</div>
	                	</div>
	                </div>
	                
	                <div class="col-6">
	                    <div class="card">
	                    	<div class="header" style="background-color: #D8D8D8; height: 70px;">
	                    		<h5>상세정보</h5>
		               		</div>
	                    	<div class="body" style="height: 300px;">
	                			<div style="margin-bottom: 20px; " >
	                				<p style="margin-bottom: 0;">양식제목</p>
	                				<span id="formName"></span>
	                			</div>
	                			<div style="margin-bottom: 20px;">
	                				<p style="margin-bottom: 0;">보존연한</p>
	                				<span id="formPeriod"></span>
	                			</div>
	                			<div style="margin-bottom: 20px;">
	                				<p style="margin-bottom: 0;">기안자</p>
	                				<span id="empName"></span>
	                			</div>
	                			<div style="margin-bottom: 20px;">
	                				<p style="margin-bottom: 0;">기안자 팀/부서</p>
	                				<span id="deptName"></span>
	                			</div>
	                			<div style="display: none;">
	                				<p style="margin-bottom: 0;">양식아이디</p>
	                				<span id="myFormId"></span>
	                			</div>
	                			
	                		
	                		</div>
	                    </div>
	                </div>
	            </div>
	            <div class="row clearfix">
	            	<div class="col-12">
		            	<button type="button" class="btn btn-secondary float-right" style="width: 100px;" onclick="window.close();" >취소</button>
		            	<button  type="button" class="btn btn-info float-right" style="width: 100px;" onclick="getForm_go();">확인</button>
		            </div>
	            </div>
            </div>
            
            
		</div>
	</div>
</div>

<!-- 공통모듈 -->
<script>
function deptTrees(){
	$.ajax({
		type:"GET",
		url:"/JoinWorkGW/getFormTreeView",
		contentType:"application/json",
	// 	data:dataSet,
		processData:true,
		success: function(data) {
			data.forEach(function(e, i) {
				var formId = e.formId;
				var formName = e.formName;
			    var formSupId = e.formSupId;
			    var level = 5;
			    var li = "";
			    if(e.level){
					level = e.level;
			    } 
			    if(formSupId != 0){
				    li = '<li onclick="empChecked(this); formDetail(this);" id="'+ formId +'" lvl="'+level +'" class="myHover" ><img src="<%=request.getContextPath() %>/resources/js/treeview/images/file.gif" >'+" "+ formName + '</li>';
			    }else{
			    	li = '<li id="'+ formId +'" lvl="'+level +'"><img src="<%=request.getContextPath() %>/resources/js/treeview/images/folder-closed.gif" ><a class="file code"  style="cursor: pointer;" onclick="myClick(this);">'+" "+ formName +'</a></li>';
			    }
				
				
				// 1레벨은 그냥 추가
				// 다음 레벨부터는 상위 li의 클래스를 폴더로 바꾸고 자기 자신을 추가
			    if(level == 1) {
					$("#lvl0").append(li);
				} else {
					  var parentLi = $("li[id='"+ formSupId +"']");
					  
					  parentLi.addClass("expandable lastExpandable");
				      var bUl = parentLi.children("ul");
			   		  
				      // 하위 그룹이 없으면 li로 추가
				      // 하위 그룹이 있으면 ul로 추가
				      if(bUl.length == 0) {
				    	  var div = "<div onclick='plusFromMinus(this);' class='hitarea expandable-hitarea lastExpandable-hitarea'></div>"
				          li = "<ul class='' style='display: none;'>" + li + "</ul>";
				          parentLi.append(div);
				          parentLi.append(li);
				          
				          return false;
				      } else {
				    	  bUl.append(li);
				      }
			     }
			});
		}
	});
}
function myClick(obj){
	$(obj).parent().children("div").click();
}
function empChecked(obj) {
	//기존 체크된 css 및 클래스 정보 삭제
	$(".myChecked").css("background-color","");
	$("li").removeClass("myChecked");
	
	//새로 체크된 css 및 클래스 정보 갱신
	$(obj).addClass("myChecked");
	$(".myChecked").css("background-color","#2980b9");
}
//조직도 검색을 위한 함수입니다.
function searchOrg(){
	var keyword = $("#searchKeyword").val();
	console.log(keyword);
	if(!keyword){//검색조건이 비어있으면 리턴
		$("#codeList")[0].scrollIntoView();
		$(".myChecked").css("background-color","");
		return false;
	}
	var $plusIcon = $("li:contains('"+keyword+"')").eq(2).parent().parent().children("div");//한칸
	
		
	$($plusIcon).parent("li").removeClass("expandable lastExpandable");
	$($plusIcon).parent("li").addClass("collapsable lastCollapsable");
	$($plusIcon).removeClass("hitarea expandable-hitarea lastExpandable-hitarea");
	$($plusIcon).addClass("hitarea collapsable-hitarea lastCollapsable-hitarea");
	$($plusIcon).parent("li").children("ul").css("display","block");
	
	$("li:contains('"+keyword+"')").eq(2)[0].scrollIntoView();
	$("li:contains('"+keyword+"')").eq(2)[0].click();
	
}


//열고 닫는 함수입니다.
function plusFromMinus(obj){
	if($(obj).hasClass("expandable-hitarea")){
		$(obj).parent("li").removeClass("expandable lastExpandable");
		$(obj).parent("li").addClass("collapsable lastCollapsable");
		$(obj).removeClass("hitarea expandable-hitarea lastExpandable-hitarea");
		$(obj).addClass("hitarea collapsable-hitarea lastCollapsable-hitarea");
		$(obj).parent("li").children("ul").css("display","block");
		$(obj).parent("li").children("img").attr("src","<%=request.getContextPath() %>/resources/js/treeview/images/folder.gif");	
		
	}else{
		$(obj).parent("li").removeClass("collapsable lastCollapsable");
		$(obj).parent("li").addClass("expandable lastExpandable");
		$(obj).removeClass("hitarea collapsable-hitarea lastCollapsable-hitarea");
		$(obj).addClass("hitarea expandable-hitarea lastExpandable-hitarea");
		$(obj).parent("li").children("ul").css("display","none");
		$(obj).parent("li").children("img").attr("src","<%=request.getContextPath() %>/resources/js/treeview/images/folder-closed.gif");
	}
}

window.onload = function(){
	deptTrees();
// 	getOrgChart();
	//부서클릭시 부서에 속한 직원 상세조회
}

$("#codeList").treeview({collapsed: false});

</script>

<script>

function formDetail(obj) {
	var formId = $(obj).attr("id");
	$.ajax({
		type:"POST",
		url:"<c:url value='getForm'/>",
		contentType:"application/json",
	 	data : formId,
		processData:true,
		success: function(data) {
			var empName = data.emp.empName + " " + data.emp.officialName;
			var deptName = data.emp.deptName;
			var formPeriod = data.form.formPeriod + "년";
			var formName = data.form.formName;
			var formId = data.form.formId;
			
			$("#empName").html(empName);
			$("#deptName").html(deptName);
			$("#formPeriod").html(formPeriod);
			$("#formName").html(formName);
			$("#myFormId").html(formId);
			
			
		},
		error: function(e) {
			console.log(e);
		}
	
	});
	
	
}

function getForm_go() {
	var formId = $("#myFormId").html();
	
	if(!formId){
		alert("양식을 선택해주세요.");
		return false;
	}
	
	opener.OpenWindow('docDetail?formId='+formId+'','결재양식',900,900);
	window.close();
}

function saveForm_go() {
	var formId = $("#myFormId").html();
	var saveFormCnt = 0;
	
	$.ajax({
		type:"POST",
		url:"<c:url value='getSaveFormCnt'/>",
		contentType:"application/json",
		processData:true,
		success: function(data) {
			saveFormCnt = data;
		},
		error: function(e) {
			console.log(e);
		}
	});
	
	if(saveFormCnt === 4){
		alert("자주 쓰는 양식은 4개 까지만 추가 가능합니다.");
		return false;
	}
	var obj = {}
	obj.formId = formId;
	
	$.ajax({
		type:"POST",
		url:"<c:url value='registSaveForm'/>",
		contentType:"application/json",
	 	data : JSON.stringify(obj),
		processData:true,
		success: function(data) {
			if(data === 'success'){
				alert('양식이 추가되었습니다.');
				opener.location.reload();
			}			
			if(data === 'fail'){
				alert('이미 추가된 양식입니다.');
			}			
			
			
			
		},
		error: function(e) {
			console.log(e);
		}
	});
}
$(document).keypress(function (event) {
    if (event.keyCode === 13) {
        searchOrg();
    }
})


</script>






















</body>
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

<style>
.table td {
	border-top: 0;
}

</style>
<body style="background-color: #f4f7f6;">

<div class="wrapper">
	<a id="viewModal" href="#defaultModal" data-toggle="modal" data-target="#defaultModal" style="display: none;"></a>  
	<!-- 메인 content -->
	<div id="main-content" style="margin-top: 20px;">
		<div class="container-fluid" style="font-size: 16px;">
		
			<div class="row clearfix " style="margin-bottom: 1%;">
				<div class="col-12">
	               	<div>
	               		<span style="font-size: xx-large; font-family: S-CoreDream-6Bold">결재선 선택</span>
	               		<hr>
	              	</div>
              	</div>
            </div>
            <div class="row clearfix" style="font-family: S-CoreDream-6Bold">
	            <div class="col-lg-4" style="height: 400px;">
		            <div class="card" style="margin-bottom: 0; height: 480px;">
			            <div class="body" style="padding: 6px;">
			                <ul class="nav nav-tabs">
			                    <li class="nav-item"><a class="nav-link active show" data-toggle="tab" href="#org">조직도</a></li>
			                    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#myLine">나의 결재선</a></li>
			                </ul>
			                <div class="tab-content" style="padding: 0;">
							<!-- 조직도 -->
			                    <div class="tab-pane show active" id="org">
			                    
			                    	<div class="header" style=" height: 60px;">
				                    	<input oninput="searchOrg(this);" type="search" class="form-control" placeholder="이름으로 검색" style="display: inline-block; width: 75%;">
					                    <button type="button" class="btn btn-dark" onclick="searchOrg(this);"><i class="icon-magnifier"></i></button>
				               		</div>
			                		<div class="body" style="overflow-y: scroll; height: 360px;">
			                			<div>
											<ul id="codeList">
												<li>JoinWork조직도
													<ul id="lvl0"></ul> 
												</li>
											</ul>
										</div>
			                		</div>
			                    </div>
			                    
			                    <div class="tab-pane" id="myLine">
			                    	<div class="header" style=" height: 60px;">
					                    <input oninput="searchLine(this);" type="search" class="form-control" placeholder="결재선 명칭" style="display: inline-block; width: 75%;">
					                    <button type="button" class="btn btn-dark" onclick="searchLine(this);"><i class="icon-magnifier"></i></button>
				               		</div>
			                		<div class="body" style="overflow-y: scroll; height: 360px;">
			                			<div class="table-responsive">
	                                		<table class="table table-hover m-b-0 c_list">
			                					<tbody id="approvalLines" style="cursor: pointer;">
			                						
												<!-- 나의결재선 들어가는 곳 -->
			                						
			                						
			                					</tbody>
			                				</table>
			                			</div>
			                		</div>
			                    </div>
			                    
			                    
			                </div>
			            </div>
		            </div>
	            </div>
	            <div class="col-lg-8">
	            	<div class="card" style="margin-bottom: 0; overflow-y: scroll; height: 407px; ">
			            <div class="body" style="padding: 0;">
			            	<div class="table-responsive" style="box-sizing: content-box;">
                                <table class="table center-aligned-table" style="margin-bottom: 0;">
                                <!--모달창 -->
                                    <div class="modal fade" id="defaultModal" tabindex="-1" role="dialog">
									    <div class="modal-dialog" role="document">
									        <div class="modal-content">
									            <div class="modal-header">
									                <h4 class="title" id="defaultModalLabel"></h4>
									            </div>
									            <div class="modal-body">
									            
									            
									            </div>
									            <div class="modal-footer">
									                <button onclick="moveApprovalLine();" type="button" class="btn btn-primary">결재선으로 추가</button>
									                <button id="closeModal" type="button" class="btn btn-danger" data-dismiss="modal">X</button>
									            </div>
									        </div>
									    </div>
									</div>
                                
                                    <thead>
	                                    <tr>
	                                        <th></th>
	                                        <th>타입</th>
	                                        <th>이름</th>
	                                        <th>부서</th>
	                                        <th></th>
	                                        <th >상태</th>
	                                        <th class="deleteAllEmp" style="cursor: pointer;">
	                                        	<i class="fa fa-trash-o"></i>
											</th>
	                                        <th></th>
	                                    </tr>
                                    </thead>
                                    
                                    <tbody id="appendTbody" style="overflow: scroll;">
	                                    <tr style="background-color: #f4f7f6;">
	                                        <td colspan="9">신청</td>
	                                    </tr>
	                                    <tr style="color: #D8D8D8;">
	                                        <td style="width: 48px;background-color: #F2F2F2; text-align: center; color:black;">
	                                        	<i class="fa fa-caret-right"></i>
	                                        </td>
	                                        <td>기안</td>
	                                        <td>${emp.empName } ${emp.officialName }</td>
	                                        <td>${emp.deptName }</td>
	                                        <td></td>
	                                        <td></td>
	                                        <td></td>
	                                        <td></td>
	                                    </tr>
	                                    <tr >
	                                        <td colspan="9" style="background-color: #f4f7f6;">승인</td>
	                                    </tr>
	                                    <tr id="appendTr">
	                                        <td onclick="moveRight();" rowspan="500" style="width: 48px;background-color: #F2F2F2; text-align: center; cursor: pointer;">
	                                        	<i class="fa fa-caret-right"></i>
	                                        </td>
											<!-- 첫 추가시 여기아래 붙음 -->
											
											
	                                    </tr>
	                                    
	                                 </tbody>
	                                 
                                </table>
                            </div>
			            </div>
	            	</div>
	            	<div class="card" style="margin-bottom: 0; height: 14.1%; ">
			            <div class="body" style="padding: 0;">
			            	<div class="table-responsive" style="box-sizing: content-box;">
                                <table class="table center-aligned-table" style="margin-bottom: 0;">
                                	<tr>
                                		<td>
                                			<button onclick="saveApprovalLine();" class="btn btn-primary" type="button">개인 결재선으로 저장</button>
                                			<button onclick="window.close();" class="float-right btn btn-secondary" type="button">취소</button>
	            							<button onclick="addLine_go();" class="float-right btn btn-primary" type="button">확인</button>
                                		</td>
                                	</tr>
                                </table>
                            </div>
                        </div>
                    </div>
	            </div>
            </div>
		</div>
	</div>
</div>


<script>
window.onload = function(){
	deptTrees();
// 	getOrgChart();
	//부서클릭시 부서에 속한 직원 상세조회


}

$("#codeList").treeview({collapsed: false});

</script>

<script>
getApprovalLines();//저장된 결재선 출력


//조직도 출력
function deptTrees(){
	$.ajax({
		type:"GET",
		url:"<c:url value='/orgList' />",
		contentType:"application/json",
	// 	data:dataSet,
		processData:true,
		success: function(data) {
			data.forEach(function(e, i) {
				var deptId = e.deptId;
				var deptName = e.deptName;
			    var deptSupId = e.deptSupId;
			    var position = e.position;
			    var stName = e.empState;
			    var level = 5;
			    var li = "";
			    if(e.level){
					level = e.level;
			    } 
				
			    if(position){
			    	if(stName == '휴가중'){
				    	li = '<li onclick="empChecked(this);" ondblclick="moveRight();" stName="'+stName+'" id="'+ deptId +'" lvl="'+level +'" class="" style="cursor:pointer" ><img src="<%=request.getContextPath() %>/resources/js/treeview/images/emp.png" >'+" "+ deptName + " "+e.position+'<span class="badge badge-warning">'+stName+'</span></li>';
			    	}else{
				    	li = '<li onclick="empChecked(this);" ondblclick="moveRight();" stName="'+stName+'" id="'+ deptId +'" lvl="'+level +'" class="" style="cursor:pointer" ><img src="<%=request.getContextPath() %>/resources/js/treeview/images/emp.png" >'+" "+ deptName + " "+e.position+'</li>';
			    	}
			    }else{
			    	li = '<li id="'+ deptId +'" lvl="'+level +'"><a class="file code" style="cursor: pointer;" onclick="myClick(this);">'+ deptName +'</a></li>';
			    }
				
				
				// 1레벨은 그냥 추가
				// 다음 레벨부터는 상위 li의 클래스를 폴더로 바꾸고 자기 자신을 추가
			    if(level == 1) {
					$("#lvl0").append(li);
				} else {
					  var parentLi = $("li[id='"+ deptSupId +"']");
					  
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
				          if(position){
				        	  bUl.prepend(li);
				        	  return false;
				          }
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

//조직도 검색을 위한 함수입니다.
function searchOrg(obj){
	var keyword = $(obj).val();
	if(!keyword){//검색조건이 비어있으면 리턴
		$("#codeList")[0].scrollIntoView();
		$(".myChecked").css("background-color","");
		return false;
	}
	
	$("li:contains('"+keyword+"')").eq(2);
// 	console.log($("li:contains('"+keyword+"')"));
// 	console.log($("li:contains('"+keyword+"')").eq(2)[0]);
	
	var $plusIcon = $("li:contains('"+keyword+"')").eq(2).parent().parent().children("div");//한칸
	var $plusIcon2 = $("li:contains('"+keyword+"')").eq(3).parent().parent().children("div");//한칸이상
	
	if($("li:contains('"+keyword+"')").eq(2).attr("lvl") == 5){
		
		$($plusIcon).parent("li").removeClass("expandable lastExpandable");
		$($plusIcon).parent("li").addClass("collapsable lastCollapsable");
		$($plusIcon).removeClass("hitarea expandable-hitarea lastExpandable-hitarea");
		$($plusIcon).addClass("hitarea collapsable-hitarea lastCollapsable-hitarea");
		$($plusIcon).parent("li").children("ul").css("display","block");
		
		$("li:contains('"+keyword+"')").eq(2)[0].scrollIntoView();
		$("li:contains('"+keyword+"')").eq(2)[0].click();
	}else{
		if($("li:contains('"+keyword+"')").eq(3)[0]){
			$($plusIcon2).parent("li").removeClass("expandable lastExpandable");
			$($plusIcon2).parent("li").addClass("collapsable lastCollapsable");
			$($plusIcon2).removeClass("hitarea expandable-hitarea lastExpandable-hitarea");
			$($plusIcon2).addClass("hitarea collapsable-hitarea lastCollapsable-hitarea");
			$($plusIcon2).parent("li").children("ul").css("display","block");
			
			$("li:contains('"+keyword+"')").eq(3)[0].scrollIntoView();
			$("li:contains('"+keyword+"')").eq(3)[0].click();
		}
	}
}

//열고 닫는 함수입니다.
function plusFromMinus(obj){
	if($(obj).hasClass("expandable-hitarea")){
		$(obj).parent("li").removeClass("expandable lastExpandable");
		$(obj).parent("li").addClass("collapsable lastCollapsable");
		$(obj).removeClass("hitarea expandable-hitarea lastExpandable-hitarea");
		$(obj).addClass("hitarea collapsable-hitarea lastCollapsable-hitarea");
		$(obj).parent("li").children("ul").css("display","block");
	}else{
		$(obj).parent("li").removeClass("collapsable lastCollapsable");
		$(obj).parent("li").addClass("expandable lastExpandable");
		$(obj).removeClass("hitarea collapsable-hitarea lastCollapsable-hitarea");
		$(obj).addClass("hitarea expandable-hitarea lastExpandable-hitarea");
		$(obj).parent("li").children("ul").css("display","none");
	}
}

function empChecked(obj) {
	//기존 체크된 css 및 클래스 정보 삭제
	$(".myChecked").css("background-color","");
	$("li").removeClass("myChecked");
	
	//새로 체크된 css 및 클래스 정보 갱신
	$(obj).addClass("myChecked");
	$(".myChecked").css("background-color","#2980b9");
}

function searchLine(obj){
	var keyword = $(obj).val();
	if(!keyword){//검색조건이 비어있으면 리턴
		$(obj).scrollIntoView();
		$(".myLineChecked").css("background-color","");
		return false;
	}
	$(".myLineChecked").css("background-color","");
	$("td").removeClass("myLineChecked");
	
	$("td:contains('"+keyword+"')").eq(0)[0].scrollIntoView();
	$("td:contains('"+keyword+"')").eq(0).addClass("myLineChecked");
	$(".myLineChecked").css("background-color","#2980b9");

}



//사원을 옆으로 이동
function moveRight() {
	if(!$("li").hasClass("myChecked")){
		alert("선택된 직원이 없습니다.");
		return false;
	}
	
	var str = "";
	var agencyStr = "";
	
	
	var empId = $(".myChecked").attr("id");
	var empName = $(".myChecked").text().trim();
	var deptName = $(".myChecked").parent().parent().children("a").text();
	var stName = $(".myChecked").attr("stName");
	
	if($("td").hasClass(empId)){
		alert("같은 직원은 추가할 수 없습니다.");
		return false;
	}
	
	if(empId === '${loginUser.empId}'){
		alert("자기 자신을 추가할 수 없습니다.");
		return false;
	}
	
	
// 	결재가 불가능한 상황일 때
	if(stName === '휴가중'){
		//ajax로 대결자 있는지 확인 후 있으면 사번 리스트 가져옴
		var deaAgencyList = [];
		$.ajax({
			type:"POST",
			url:"<c:url value='getDeaAgencyList' />",
			contentType:"application/json",
			async: false,
			data:empId,
			processData:true,
			success: function(data) {
				deaAgencyList = data;
			}
		});
		
		if(deaAgencyList.length == 0){
			alert(empName+"님은 "+stName+"인 상태이므로 결재가 불가능한 상태입니다.");
			return false;
		}
		
		var cnt = 0;
		for(var i = 0; i < deaAgencyList.length; i++){
			var agency = deaAgencyList[i];
			if($("#"+agency.empAgencyId+"").attr("stname") === '정상출근'){
				cnt++;
			}
		}
		if(cnt == 0){
			alert(empName+"님은 "+stName+"인 상태이므로 결재가 불가능한 상태입니다.");
			return false;
		}
		
		
		
		
		empName = empName.split("휴가중")[0];
		
		if(confirm(empName+"님은 "+stName+"인 상태이므로 결재가 불가능한 상태입니다. 대결자를 추가하시겠습니까?")){
			for(var i = 0; i < deaAgencyList.length; i++){
				var agency = deaAgencyList[i];
				agencyStr +='<tr>';
				agencyStr +='<input value="'+agency.empAgencyId+'" style="display:none;">';
				agencyStr +='<td class="myTd style="padding-right: 0;">';
				agencyStr +='<select disabled style="width: 65px;">';
				agencyStr +='<option selected>대결</option>';
				agencyStr +='</select>';
				agencyStr +='&nbsp&nbsp<small class="supEmpId" value="'+empId+'">'+empName+'</small>';
				agencyStr +='</td>';
				agencyStr +='<td class="myTd myName">'+agency.empName+' '+agency.officialName+'</td>';
				agencyStr +='<td class="myTd myDeptName">'+agency.deptName+'</td>';
				agencyStr +='<td class="myTd empTd '+agency.empAgencyId+'" style="display:none" value="'+agency.empAgencyId+'"></td>';
				agencyStr +='<td class="myTd"></td>';
				agencyStr +='<td class="myTd st">'+agency.attendStName+'</td>';
				agencyStr +='<td class="myTd deleteEmp" style="cursor: pointer;" ><i class="fa fa-trash-o"></i></td>';
				agencyStr +='<td class="myTd"></td>';
				agencyStr +='</tr>';
			}
		}else{
			return false;
		}
		
	}
	
	
	if(!$("td").hasClass("firTd")){
		str +='<td class="firTd style="padding-right: 0;">';
		str +='<select style="width: 65px;">';
		str +='<option>검토</option>';
		str +='<option>결재</option>';
		str +='<option>수신</option>';
		str +='<option>참조</option>';
		str +='</select>';
		str +='</td>';
		str +='<td class="firTd myName">'+empName+'</td>';
		str +='<td class="firTd myDeptName">'+deptName+'</td>';
		str +='<td class="firTd empTd '+empId+'" style="display:none" value="'+empId+'"></td>';
		str +='<td class="firTd"></td>';
		str +='<td class="firTd st">'+stName+'</td>';
		str +='<td class="firTd deleteEmp" style="cursor: pointer;" ><i class="fa fa-trash-o"></i></td>';
		str +='<td class="firTd"></td>';
		
		$("#appendTr").append(str);
		$("#appendTr").trigger("create");
		if(agencyStr){
			$("#appendTbody").append(agencyStr);
			$("#appendTbody").trigger("create");
			agencyStr = "";
		}
		
	}else{
		str +='<tr>';
		str +='<input value="'+empId+'" style="display:none;">';
		str +='<td class="myTd style="padding-right: 0;">';
		str +='<select style="width: 65px;">';
		str +='<option>검토</option>';
		str +='<option>결재</option>';
		str +='<option>수신</option>';
		str +='<option>참조</option>';
		str +='</select>';
		str +='</td>';
		str +='<td class="myTd myName">'+empName+'</td>';
		str +='<td class="myTd myDeptName">'+deptName+'</td>';
		str +='<td class="myTd empTd '+empId+'" style="display:none" value="'+empId+'"></td>';
		str +='<td class="myTd"></td>';
		str +='<td class="myTd st">'+stName+'</td>';
		str +='<td class="myTd deleteEmp" style="cursor: pointer;" ><i class="fa fa-trash-o"></i></td>';
		str +='<td class="myTd"></td>';
		str +='</tr>';
		
		$("#appendTbody").append(str);
		$("#appendTbody").trigger("create");
		if(agencyStr){
			$("#appendTbody").append(agencyStr);
			$("#appendTbody").trigger("create");
			agencyStr = "";
		}
	}
	
	
	
	
}

//사원 삭제
$(document).on("click",".deleteEmp",function(){
	if($(this).parent().attr("id") == "appendTr"){
		$(".firTd").remove();
	}else{
		$(this).parent().remove();
	}
	
});
//사원 전제 삭제
$(document).on("click",".deleteAllEmp",function(){
	$(".firTd").remove();
	$(".myTd").parent().remove();
});


//결재선 등록
function addLine_go() {

	var tempArr = [];
	var receptionArr = [];
	var referArr = [];
	var agencyArr = [];
	var selectBoxCnt = $("select").length;
	var approvalObj = {};
	var reviewObj = {};
	var receptionObj = {};
	var referObj = {};
	var agencyObj = {};
	
	//모든 타입을 우선 배열에 넣는다.
	for(var i = 0; i < selectBoxCnt; i++){
		var type = $("option:selected").eq(i).val();
		tempArr.push(type);
		
		if(type === '결재'){
			approvalObj.name = $("option:selected").eq(i).parent().parent().parent().find(".myName").text().split(" ")[0];
			approvalObj.official = $("option:selected").eq(i).parent().parent().parent().find(".myName").text().split(" ")[1];
			approvalObj.empId = $("option:selected").eq(i).parent().parent().parent().find(".empTd").attr("value");
			approvalObj.st = $("option:selected").eq(i).parent().parent().parent().find(".st").attr("value");
		}
		
		if(type === '검토'){
			reviewObj.name = $("option:selected").eq(i).parent().parent().parent().find(".myName").text().split(" ")[0];
			reviewObj.official = $("option:selected").eq(i).parent().parent().parent().find(".myName").text().split(" ")[1];
			reviewObj.empId = $("option:selected").eq(i).parent().parent().parent().find(".empTd").attr("value");
			reviewObj.st = $("option:selected").eq(i).parent().parent().parent().find(".st").attr("value");
		}
		
		if(type === '수신'){
			receptionObj.name = $("option:selected").eq(i).parent().parent().parent().find(".myName").text().split(" ")[0];
			receptionObj.official = $("option:selected").eq(i).parent().parent().parent().find(".myName").text().split(" ")[1];
			receptionObj.empId = $("option:selected").eq(i).parent().parent().parent().find(".empTd").attr("value");
			receptionArr.push(receptionObj);
			receptionObj = {};
		}
		
		if(type === '참조'){
			referObj.name = $("option:selected").eq(i).parent().parent().parent().find(".myName").text().split(" ")[0];
			referObj.official = $("option:selected").eq(i).parent().parent().parent().find(".myName").text().split(" ")[1];
			referObj.empId = $("option:selected").eq(i).parent().parent().parent().find(".empTd").attr("value");
			referArr.push(referObj);
			referObj = {};
		}
		
		if(type === '대결'){
			agencyObj.name = $("option:selected").eq(i).parent().parent().parent().find(".myName").text().split(" ")[0];
			agencyObj.official = $("option:selected").eq(i).parent().parent().parent().find(".myName").text().split(" ")[1];
			agencyObj.empId = $("option:selected").eq(i).parent().parent().parent().find(".empTd").attr("value");
			agencyObj.supEmpId = $("option:selected").eq(i).parent().parent().parent().find(".supEmpId").attr("value");
			agencyArr.push(agencyObj);
			agencyObj = {};
		}
		
	}
	
	var approvalCnt = tempArr.filter(element => '검토' === element).length;
	var reviewCnt = tempArr.filter(element => '결재' === element).length;
	var agencyCnt = tempArr.filter(element => '대결' === element).length;
	
	if(approvalCnt > 1 || reviewCnt > 1){
		alert("검토자나 결재자는 한명만 선택가능합니다.");
		return false;
	}
	if(approvalCnt == 0 || reviewCnt == 0){
		alert("검토자나 결재자가 최소 한명씩 있어야 합니다.");
		return false;
	}
	
	
	if(reviewObj.st === '휴가중'){
		var cnt = 0;
		if(!agencyArr){
			alert(reviewObj.name+"님의 대결자가 존재 하지 않습니다.");
			return false;
		}
		for(var i = 0; i < agencyArr.length; i++){
			if(agencyArr[i].supEmpId === reviewObj.empId){
				cnt++;
			}
		}	
		if(cnt > 2){
			alert(reviewObj.name + "님의 대결자가 2명 이상입니다.");
			return false;
		}
		
	}
	
	if(approvalObj.st === '휴가중'){
		var cnt = 0;
		if(!agencyArr){
			alert(approvalObj.name+"님의 대결자가 존재 하지 않습니다.");
			return false;
		}
		for(var i = 0; i < agencyArr.length; i++){
			if(agencyArr[i].supEmpId === approvalObj.empId){
				cnt++;
			}
		}	
		if(cnt > 2){
			alert(approvalObj.name + "님의 대결자가 2명 이상입니다.");
			return false;
		}
	}
	
	//대결자 명수
	var deLength = $("small").length;
	var duplicateSet = new Set();//중복대결자를 잡기위한 set
	
	for(var i = 0; i < deLength; i++){
		duplicateSet.add($("small").eq(i).attr("value"));
	}
	
	if(duplicateSet.size != deLength){
		alert("대결자는 한명만 가능합니다.");
		return false;
	}
	
	
	
	
	
	var str = "";
	for(var i = 0; i < 3+agencyCnt; i++){
		var empId = "";
		var name = "";
		var official = "";
		var supEmpId = "";
		var type = "";
		
		if(agencyCnt == 0){
			if(i == 0){
				empId = '${emp.empId }';
				name =  '${emp.empName }';
				official = '${emp.officialName }';
				type = "신청";
			}
			if(i == 1){
				empId = reviewObj.empId;
				name =  reviewObj.name;
				official = reviewObj.official;
				type = "검토";
			}
			if(i == 2){
				empId = approvalObj.empId;
				name =  approvalObj.name;
				official = approvalObj.official;
				type = "결재";
			}
		}
		if(agencyCnt == 1){
			if(agencyArr[0].supEmpId === reviewObj.empId){
				if(i == 0){
					empId = '${emp.empId }';
					name =  '${emp.empName }';
					official = '${emp.officialName }';
					type = "신청";
				}
				if(i == 1){
					empId = agencyArr[0].empId;
					name =  agencyArr[0].name;
					official = agencyArr[0].official;
					supEmpId = agencyArr[0].supEmpId;
					type = "대결";
				}
				if(i == 2){
					empId = reviewObj.empId;
					name =  reviewObj.name;
					official = reviewObj.official;
					type = "검토";
				}
				if(i == 3){
					empId = approvalObj.empId;
					name =  approvalObj.name;
					official = approvalObj.official;
					type = "결재";
				}
				
			}
			if(agencyArr[0].supEmpId === approvalObj.empId){
				if(i == 0){
					empId = '${emp.empId }';
					name =  '${emp.empName }';
					official = '${emp.officialName }';
					type = "신청";
				}
				if(i == 1){
					empId = reviewObj.empId;
					name =  reviewObj.name;
					official = reviewObj.official;
					type = "검토";
				}
				if(i == 2){
					empId = agencyArr[0].empId;
					name =  agencyArr[0].name;
					official = agencyArr[0].official;
					supEmpId = agencyArr[0].supEmpId;
					type = "대결";
				}
				if(i == 3){
					empId = approvalObj.empId;
					name =  approvalObj.name;
					official = approvalObj.official;
					type = "결재";
				}
			}
		}
		if(agencyCnt == 2){
			var agency1empId = "";
			var agency1name = "";
			var agency1official = "";
			var agency1supEmpId = "";
			var agency2empId = "";
			var agency2name = "";
			var agency2official = "";
			var agency2supEmpId = "";
			for(var j = 0; j < agencyArr.length; j++){
				if(agencyArr[j].supEmpId === reviewObj.empId){
					agency1empId = agencyArr[j].empId;
					agency1name = agencyArr[j].name;
					agency1official = agencyArr[j].official;
					agency1supEmpId = agencyArr[j].supEmpId;
				}
				if(agencyArr[j].supEmpId === approvalObj.empId){
					agency2empId = agencyArr[j].empId;
					agency2name = agencyArr[j].name;
					agency2official = agencyArr[j].official;
					agency2supEmpId = agencyArr[j].supEmpId;
				}
			}
			if(i == 0){
				empId = '${emp.empId }';
				name =  '${emp.empName }';
				official = '${emp.officialName }';
				type = "신청";
			}
			if(i == 1){
				empId = agency1empId;
				name =  agency1name;
				official = agency1official;
				supEmpId = agency1supEmpId;
				type = "대결";
			}
			if(i == 2){
				empId = reviewObj.empId;
				name =  reviewObj.name;
				official = reviewObj.official;
				type = "검토";
			}
			if(i == 3){
				empId = agency2empId;
				name =  agency2name;
				official = agency2official;
				supEmpId = agency2supEmpId;
				type = "대결";
			}
			if(i == 4){
				empId = approvalObj.empId;
				name =  approvalObj.name;
				official = approvalObj.official;
				type = "결재";
			}
			
		}
		str +='<table border="1" style="display: inline-block; border-collapse: collapse; background: white;" class="lineTable">'
		str +='	<tbody >'
		str +='		<tr>'
		str +='			<td style="width: 40px; text-align: center;">직급</td>'
		str +='			<td style="width: 90px; text-align: center;">'+official+'</td>'
		str +='		</tr>'
		str +='		<tr>'
		str +='			<td style="width: 40px; text-align: center;">'+type+'</td>'
		str +='			<td style="width: 90px; height: 95px; text-align: center;">'
						
		
		str +='				<div id="d'+empId+'" style="width: 90px; height: 56px;"></div>'
		str +='			</td>'
		str +='		</tr>'
		str +='		<tr>'
		str +='			<td style="width: 40px; text-align: center;">성명</td>'
		if(supEmpId){
			str +='		<td class="supEmpId" style="display:none;" value='+supEmpId+'>성명</td>'
		}
		str +='			<td id="'+type+'" class="'+type+'" onclick="empDetailModal(this);" contenteditable="false" style="width: 90px; text-align: center; cursor:pointer;" value="'+empId+'"><span class="badge badge-default">'+name+'</span></td>'
		str +='		</tr>'
				
		str +='	</tbody>'
		str +='</table>'
		
	}
	
	var str1 = "";
	for(var i = 0; i < receptionArr.length; i++){
		str1 +='<button class="btn btn-outline-secondary referBtn " style="padding:0;font-size:0; margin-right: 10px;">';
		str1 +='	<span class="reception" style="font-size: 11px;" value="'+receptionArr[i].empId+'">'+receptionArr[i].name+" "+receptionArr[i].official+'</span>';
		str1 +='</button>';
		
	}
	
	var str2 = "";
	for(var i = 0; i < referArr.length; i++){
		str2 +='<button class="btn btn-outline-secondary referBtn" style="padding:0;font-size:0; margin-right: 10px;">';
		str2 +='	<span class="refer" style="font-size: 11px;" value="'+referArr[i].empId+'">'+referArr[i].name+" "+referArr[i].official+'</span>';
		str2 +='</button>';
		
	}
	opener.document.querySelector("#previewInnerHtml").innerHTML = "";
	
	//검토 결재자 등록
	opener.document.querySelector("#approval-line").innerHTML = str;
	
	//수신자 등록
	opener.document.querySelector("#reception").innerHTML = str1;
	
	//참조자 등록
	opener.document.querySelector("#refer").innerHTML = str2;
	
	
	
	var sysDate = new Date();
	var prettyDate =  sysDate.getFullYear()+'-'+(sysDate.getMonth()+1)+'-'+sysDate.getDate();
	
	opener.document.querySelector("#recommandDate").innerHTML = prettyDate;
	opener.document.querySelector("#empName").innerHTML = '${emp.empName }'+" "+'${emp.officialName }';
	opener.document.querySelector("#deptName").innerHTML = '${emp.deptName }';
	opener.document.querySelector("#docId").innerHTML = '${docId}';
	
	window.close();
}

function saveApprovalLine() {
	var tempArr = [];
	var receptionArr = [];
	var referArr = [];
	var selectBoxCnt = $("select").length;
	var approvalObj = {};
	var reviewObj = {};
	var receptionObj = {};
	var referObj = {};
	
	//모든 타입을 우선 배열에 넣는다.
	for(var i = 0; i < selectBoxCnt; i++){
		var type = $("option:selected").eq(i).val();
		tempArr.push(type);
		
		if(type === '결재'){
			approvalObj.name = $("option:selected").eq(i).parent().parent().parent().find(".myName").text().split(" ")[0];
			approvalObj.official = $("option:selected").eq(i).parent().parent().parent().find(".myName").text().split(" ")[1];
			approvalObj.empId = $("option:selected").eq(i).parent().parent().parent().find(".empTd").attr("value");
		}
		
		if(type === '검토'){
			reviewObj.name = $("option:selected").eq(i).parent().parent().parent().find(".myName").text().split(" ")[0];
			reviewObj.official = $("option:selected").eq(i).parent().parent().parent().find(".myName").text().split(" ")[1];
			reviewObj.empId = $("option:selected").eq(i).parent().parent().parent().find(".empTd").attr("value");
		}
		
		if(type === '수신'){
			receptionObj.name = $("option:selected").eq(i).parent().parent().parent().find(".myName").text().split(" ")[0];
			receptionObj.official = $("option:selected").eq(i).parent().parent().parent().find(".myName").text().split(" ")[1];
			receptionObj.empId = $("option:selected").eq(i).parent().parent().parent().find(".empTd").attr("value");
			receptionArr.push(receptionObj);
			receptionObj = {};
		}
		
		if(type === '참조'){
			referObj.name = $("option:selected").eq(i).parent().parent().parent().find(".myName").text().split(" ")[0];
			referObj.official = $("option:selected").eq(i).parent().parent().parent().find(".myName").text().split(" ")[1];
			referObj.empId = $("option:selected").eq(i).parent().parent().parent().find(".empTd").attr("value");
			referArr.push(referObj);
			referObj = {};
		}
		if(type === '대결'){
			referObj.name = $("option:selected").eq(i).parent().parent().parent().find(".myName").text().split(" ")[0];
			referObj.official = $("option:selected").eq(i).parent().parent().parent().find(".myName").text().split(" ")[1];
			referObj.empId = $("option:selected").eq(i).parent().parent().parent().find(".empTd").attr("value");
			referArr.push(referObj);
			referObj = {};
		}
		
	}
	
	var approvalCnt = tempArr.filter(element => '검토' === element).length;
	var reviewCnt = tempArr.filter(element => '결재' === element).length;
	
	if(approvalCnt > 1 || reviewCnt > 1){
		alert("검토자나 결재자는 한명만 선택가능합니다.");
		return false;
	}
	if(approvalCnt == 0 || reviewCnt == 0){
		alert("검토자나 결재자가 최소 한명씩 있어야 합니다.");
		return false;
	}
	var result = prompt("결재선의 이름을 입력해주세요.");
	
	if(!result){
		return false;
	}
	
	var dataMap = {};
	dataMap.referArr = referArr;
	dataMap.receptionArr = receptionArr;
	dataMap.reviewObj = reviewObj;
	dataMap.approvalObj = approvalObj;
	dataMap.lineName = result;
	
	$.ajax({
		type:"POST",
		url:"registApprovalLine",
		contentType:"application/json",
	 	data : JSON.stringify(dataMap),
		processData:true,
		success: function(data) {
			console.log(data);
		},
		error: function(e) {
			console.log(e);
		}
	
	});
	alert("결재선이 추가되었습니다.")
	getApprovalLines();
}

function getApprovalLines(){
	$.ajax({
		type:"POST",
		url:"<c:url value='getApprovalLines' />",
		contentType:"application/json",
	// 	data:dataSet,
		processData:true,
		success: function(data) {
			var line = "";
			var lineEmp = "";
			var approvalNames = Object.keys(data);
			for(var i = 0; i < approvalNames.length; i++){
				var approvalLine = data[approvalNames[i]];
				
				line += '<tr onclick="viewLineEmp(this); approvalLineChecked(this);"  >';
				line +=	 '<td class="approvalName">'+approvalNames[i]+'</td>';
				
				for(var j = 0; j < approvalLine.length; j++){
					var empId = approvalLine[j].empId;
					var lineType = approvalLine[j].lineType;
					var empName = approvalLine[j].empName;
					var deptName = approvalLine[j].deptName;
					var attendStName = approvalLine[j].attendStName;
					var officialName = approvalLine[j].officialName;
					line +=	 '<td style="display:none;" class="empId">'+empId+'</td>';
					line +=	 '<td style="display:none;" class="lineType">'+lineType+'</td>';
					line +=	 '<td style="display:none;" class="empName">'+empName+'</td>';
					line +=	 '<td style="display:none;" class="deptName">'+deptName+'</td>';
					line +=	 '<td style="display:none;" class="attendStName">'+attendStName+'</td>';
					line +=	 '<td style="display:none;" class="officialName">'+officialName+'</td>';
					
				}
				
				line += '</tr>';
				$("#approvalLines").html(line).trigger("create");
				
			}
			
		},
		error: function(e) {
			
		}
	});
}

var lineEmpObj;

function viewLineEmp(obj) {
	var lineEmp = "";
	var empCnt = ($(obj).children("td").length -1)/6;
	var lineName = $(obj).children(".approvalName").text();
	lineEmpObj = obj;
		lineEmp += '<div class="card" style="margin-bottom: 0; overflow-y: scroll; height: 407px; "> ';
		lineEmp += '<div class="body" style="padding: 0;">                                           ';
		lineEmp += '	<div class="table-responsive" style="box-sizing: content-box;">                 ';
		lineEmp += '        <table class="table center-aligned-table" style="margin-bottom: 0;">     ';
		lineEmp += '                    <thead>                                                      ';
		lineEmp += '                <tr>                                                             ';
		lineEmp += '                    <th></th>                                                    ';
		lineEmp += '                    <th>타입</th>                                                ';
		lineEmp += '                    <th>이름</th>                                                ';
		lineEmp += '                     <th>부서</th>                                               ';
		lineEmp += '                     <th></th>                                                   ';
        lineEmp += '                    <th >상태</th>                                               ';
        lineEmp += '                     <th></th>                                                   ';
        lineEmp += '                 </tr>                                                           ';
        lineEmp += '            </thead>                                                             ';
        lineEmp += '            <tbody style="overflow: scroll;">                                    ';
        
	for(var i = 0; i < empCnt; i++){
		var empId = $(obj).children(".empId").eq(i).html();
		var lineType = $(obj).children(".lineType").eq(i).html();
		var empName = $(obj).children(".empName").eq(i).html();
		var deptName = $(obj).children(".deptName").eq(i).html();
		var attendStName = $(obj).children(".attendStName").eq(i).html();
		var officialName = $(obj).children(".officialName").eq(i).html();
		
        lineEmp += '                <tr>                                     ';
        lineEmp += '                    <td></td>                                                    ';
        lineEmp += '                    <td>'+lineType+'</td>                                                ';
        lineEmp += '                    <td>'+empName+' '+officialName+'</td>                ';
        lineEmp += '                    <td>'+deptName+'</td>                                    ';
        lineEmp += '                    <td></td>                                                    ';
        lineEmp += '                    <td>'+attendStName+'</td>                                                    ';
        lineEmp += '                    <td></td>                                                    ';
        lineEmp += '                </tr>                                                            ';
	}
	
        lineEmp += '             	</tbody>                                                            ';
		lineEmp += '                </table>                                                         ';
		lineEmp += '            </div>                                                               ';
		lineEmp += '        </div>                                                                   ';
		lineEmp += '	</div>                                                                          ';
	$("#defaultModalLabel").html(lineName).trigger("create");
	$(".modal-body").html(lineEmp).trigger("create");
	
 	$("#viewModal").click();
}

function moveApprovalLine() {
	
	var str1 = "";
	var str2 = "";
	var empCnt = ($(lineEmpObj).children("td").length -1)/6;
	var lineName = $(lineEmpObj).children(".approvalName").text();
	
	for(var i = 0; i < empCnt; i++){
		var empId = $(lineEmpObj).children(".empId").eq(i).html();
		var lineType = $(lineEmpObj).children(".lineType").eq(i).html();
		var empName = $(lineEmpObj).children(".empName").eq(i).html();
		var deptName = $(lineEmpObj).children(".deptName").eq(i).html();
		var attendStName = $(lineEmpObj).children(".attendStName").eq(i).html();
		var officialName = $(lineEmpObj).children(".officialName").eq(i).html();
		
		if($("td").hasClass(empId)){
			alert("결재선에 이미 중복된 직원이 있습니다. 중복된 직원을 삭제하고 다시 시도해주세요.");
			return false;
		}
	
		if(!$("td").hasClass("firTd") && i == 0){
			str1 +='<td class="firTd style="padding-right: 0;">';
			str1 +='<select style="width: 65px;">';
			if(lineType === '검토'){
			str1 +='<option selected>검토</option>';
			str1 +='<option>결재</option>';
			str1 +='<option>수신</option>';
			str1 +='<option>참조</option>';
			}else if(lineType === '결재'){
			str1 +='<option>검토</option>';
			str1 +='<option selected>결재</option>';
			str1 +='<option>수신</option>';
			str1 +='<option>참조</option>';
			}else if(lineType === '수신'){
			str1 +='<option>검토</option>';
			str1 +='<option>결재</option>';
			str1 +='<option selected>수신</option>';
			str1 +='<option>참조</option>';
			}else if(lineType === '참조'){
			str1 +='<option>검토</option>';
			str1 +='<option>결재</option>';
			str1 +='<option>수신</option>';
			str1 +='<option selected>참조</option>';
			}
			
			str1 +='</select>';
			str1 +='</td>';
			str1 +='<td class="firTd myName">'+empName+' '+officialName+'</td>';
			str1 +='<td class="firTd myDeptName">'+deptName+'</td>';
			str1 +='<td class="firTd empTd '+empId+'" style="display:none" value="'+empId+'"></td>';
			str1 +='<td class="firTd"></td>';
			str1 +='<td class="firTd">'+attendStName+'</td>';
			str1 +='<td class="firTd deleteEmp" style="cursor: pointer;" ><i class="fa fa-trash-o"></i></td>';
			str1 +='<td class="firTd"></td>';
			
		}else{
			str2 +='<tr>';
			str2 +='<input value="'+empId+'" style="display:none;">';
			str2 +='<td class="myTd style="padding-right: 0;">';
			str2 +='<select style="width: 65px;">';
			if(lineType === '검토'){
				str2 +='<option selected>검토</option>';
				str2 +='<option>결재</option>';
				str2 +='<option>수신</option>';
				str2 +='<option>참조</option>';
				}else if(lineType === '결재'){
				str2 +='<option>검토</option>';
				str2 +='<option selected>결재</option>';
				str2 +='<option>수신</option>';
				str2 +='<option>참조</option>';
				}else if(lineType === '수신'){
				str2 +='<option>검토</option>';
				str2 +='<option>결재</option>';
				str2 +='<option selected>수신</option>';
				str2 +='<option>참조</option>';
				}else if(lineType === '참조'){
				str2 +='<option>검토</option>';
				str2 +='<option>결재</option>';
				str2 +='<option>수신</option>';
				str2 +='<option selected>참조</option>';
				}
			str2 +='</select>';
			str2 +='</td>';
			str2 +='<td class="myTd myName">'+empName+' '+officialName+'</td>';
			str2 +='<td class="myTd myDeptName">'+deptName+'</td>';
			str2 +='<td class="myTd empTd '+empId+'" style="display:none" value="'+empId+'"></td>';
			str2 +='<td class="myTd"></td>';
			str2 +='<td class="myTd">'+attendStName+'</td>';
			str2 +='<td class="myTd deleteEmp" style="cursor: pointer;" ><i class="fa fa-trash-o"></i></td>';
			str2 +='<td class="myTd"></td>';
			str2 +='</tr>';
			
		}
	
	}
	$("#appendTr").append(str1);
	$("#appendTr").trigger("create");
	
	$("#appendTbody").append(str2);
	$("#appendTbody").trigger("create");
	
	$("#closeModal").click();
	
}













</script>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/js/treeview/jquery.treeview.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/js/treeview/screen.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/emp.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/common.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/light/assets/fonts/font.css">
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
	<!-- 메인 content -->
	<div id="main-content" style="margin-top: 20px;">
		<div class="container-fluid" style="font-size: 16px;">
		
			<div class="row clearfix " style="margin-bottom: 1%;">
				<div class="col-12" style="font-family: S-CoreDream-6Bold">
	               	<div>
	               		<span style="font-size: xx-large; ">권한 위임</span>
	               		<hr>
	              	</div>
              	</div>
            </div>
            <div class="row clearfix" style="font-family: S-CoreDream-4Regular">
	            <div class="col-lg-4" style="height: 400px;">
		            <div class="card" style="margin-bottom: 0; height: 480px;">
			            <div class="body" style="padding: 6px;">
			                <ul class="nav nav-tabs">
			                    <li class="nav-item"><a class="nav-link active show" data-toggle="tab" href="#org">조직도</a></li>
			                    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#myLine">대행자 결재문서</a></li>
			                </ul>
			                <div class="tab-content" style="padding: 0;">
							<!-- 조직도 -->
			                    <div class="tab-pane show active" id="org">
			                    
			                    	<div class="header" style=" height: 60px;">
					                    <input oninput="searchOrg(this);" type="search" class="form-control" placeholder="결재선 명칭" style="display: inline-block; width: 75%;">
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
					                    <input type="search" class="form-control" placeholder="기안자명/문서명" style="display: inline-block; width: 75%;">
					                    <button type="button" class="btn btn-dark"><i class="icon-magnifier"></i></button>
				               		</div>
			                		<div class="body" style="overflow-y: scroll; height: 360px;">
			                			<div class="table-responsive">
	                                		<table class="table table-hover m-b-0 c_list">
			                					<tbody id="approvalAuthDocs" style="cursor: pointer;">
			                						
												<!-- 권한부대행자가 처리한 문서 들어가는 곳 -->
			                						
			                						
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
                                
                                    <thead>
	                                    <tr>
	                                        <th></th>
	                                        <th>권한</th>
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
	                                        <td>부여자</td>
	                                        <td>${emp.empName } ${emp.officialName }</td>
	                                        <td>${emp.deptName }</td>
	                                        <td></td>
	                                        <td>${emp.attendStName }</td>
	                                        <td></td>
	                                        <td></td>
	                                    </tr>
	                                    <tr >
	                                        <td colspan="9" style="background-color: #f4f7f6;">승인</td>
	                                    </tr>
	                                    	<c:if test="${empty agencyList }">
		                                    <tr id="appendTr">
		                                        <td onclick="moveRight();" rowspan="500" style="width: 48px;background-color: #F2F2F2; text-align: center; cursor: pointer;">
		                                        	<i class="fa fa-caret-right"></i>
		                                        </td>
	                                        </c:if>
	                                        <c:if test="${!empty agencyList }">
												<c:forEach items="${agencyList}" var="agency" varStatus="num">
			                                    <tr id="appendTr">
													<c:if test="${num.count == 1 }">
				                                        <td onclick="moveRight();" rowspan="500" style="width: 48px;background-color: #F2F2F2; text-align: center; cursor: pointer;">
				                                        	<i class="fa fa-caret-right"></i>
				                                        </td>
														<!-- 첫 추가시 여기아래 붙음 -->
														<td class="firTd style="padding-right: 0;">
														<select style="width: 80px;">
															<option>없음</option>
															<option ${agency.agencyGroupName eq '전결자' ? 'selected':''}>전결자</option>
															<option ${agency.agencyGroupName eq '대결자' ? 'selected':''}>대결자</option>
														</select>
														</td>
														<td class="firTd myName">${agency.empName } ${agency.officialName }</td>
														<td class="firTd myDeptName">${agency.deptName }</td>
														<td class="firTd empTd ${agency.empAgencyId }" style="display:none" value="${agency.empAgencyId }"></td>
														<td class="firTd"></td>
														<td class="firTd">${agency.attendStName }</td>
														<td class="firTd deleteEmp" style="cursor: pointer;" ><i class="fa fa-trash-o"></i></td>
														<td class="firTd"></td>
													</c:if>
	                                    		</tr>
	                                    		<c:if test="${num.count > 1 }">
												<tr>
													<input value="${agency.empAgencyId }" style="display:none;">
													<td class="myTd style="padding-right: 0;">
													<select style="width: 80px;">
													<option>없음</option>
													<option ${agency.agencyGroupName eq '전결자' ? 'selected':''}>전결자</option>
													<option ${agency.agencyGroupName eq '대결자' ? 'selected':''}>대결자</option>
													</select>
													</td>
													<td class="myTd myName">${agency.empName } ${agency.officialName }</td>
													<td class="myTd myDeptName">${agency.deptName }</td>
													<td class="myTd empTd ${agency.empAgencyId }" style="display:none" value="${agency.empAgencyId }"></td>
													<td class="myTd"></td>
													<td class="myTd">${agency.attendStName }</td>
													<td class="myTd deleteEmp" style="cursor: pointer;" ><i class="fa fa-trash-o"></i></td>
													<td class="myTd"></td>
												</tr>
												</c:if>
												</c:forEach>
											</c:if>
	                                    
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
                                			<button onclick="window.close();" class="float-right btn btn-light" type="button">취소</button>
	            							<button onclick="addAgency_go();" class="float-right btn btn-info" type="button">확인</button>
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
				    li = '<li onclick="empChecked(this);" ondblclick="moveRight();" stName="'+stName+'" id="'+ deptId +'" lvl="'+level +'" class="" style="cursor:pointer" ><img src="<%=request.getContextPath() %>/resources/js/treeview/images/emp.png" >'+" "+ deptName + " "+e.position+'</li>';
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

//사원을 옆으로 이동
function moveRight() {
	if(!$("li").hasClass("myChecked")){
		alert("선택된 직원이 없습니다.");
		return false;
	}
	
	var str = "";
	
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
	
	if(!$("td").hasClass("firTd")){
		str +='<td class="firTd style="padding-right: 0;">';
		str +='<select style="width: 72px;">';
		str +='<option>없음</option>';
		str +='<option>전결자</option>';
		str +='<option>대결자</option>';
		str +='</select>';
		str +='</td>';
		str +='<td class="firTd myName">'+empName+'</td>';
		str +='<td class="firTd myDeptName">'+deptName+'</td>';
		str +='<td class="firTd empTd '+empId+'" style="display:none" value="'+empId+'"></td>';
		str +='<td class="firTd"></td>';
		str +='<td class="firTd">'+stName+'</td>';
		str +='<td class="firTd deleteEmp" style="cursor: pointer;" ><i class="fa fa-trash-o"></i></td>';
		str +='<td class="firTd"></td>';
		
		$("#appendTr").append(str);
		$("#appendTr").trigger("create");
	}else{
		str +='<tr>';
		str +='<input value="'+empId+'" style="display:none;">';
		str +='<td class="myTd style="padding-right: 0;">';
		str +='<select style="width: 72px;">';
		str +='<option>없음</option>';
		str +='<option>전결자</option>';
		str +='<option>대결자</option>';
		str +='</select>';
		str +='</td>';
		str +='<td class="myTd myName">'+empName+'</td>';
		str +='<td class="myTd myDeptName">'+deptName+'</td>';
		str +='<td class="myTd empTd '+empId+'" style="display:none" value="'+empId+'"></td>';
		str +='<td class="myTd"></td>';
		str +='<td class="myTd">'+stName+'</td>';
		str +='<td class="myTd deleteEmp" style="cursor: pointer;" ><i class="fa fa-trash-o"></i></td>';
		str +='<td class="myTd"></td>';
		str +='</tr>';
		
		$("#appendTbody").append(str);
		$("#appendTbody").trigger("create");
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

function addAgency_go() {
	var dataMap = {};
	var agencyObj = {};
	var arr = [];
	var agencyLength = $('.empTd').length;
	
	for(var i = 0; i < agencyLength; i++){
		var agencyGroupName = $("select").eq(i).children("option:selected").val();
		var empAgencyId = $('.empTd').eq(i).attr('value');
		
		agencyObj.empAgencyId = empAgencyId;
		agencyObj.agencyGroupName = agencyGroupName;
		arr.push(agencyObj);
		agencyObj = {};
		
	}
	dataMap.arr = arr;
	
	console.log(dataMap);
	
	$.ajax({
		type:"POST",
		url:"<c:url value='registAuth' />",
		contentType:"application/json",
		data:JSON.stringify(dataMap),
		processData:true,
		success: function(data) {
			
		},
		error: function() {
			
		}
	});
	window.close();
	
}





</script>

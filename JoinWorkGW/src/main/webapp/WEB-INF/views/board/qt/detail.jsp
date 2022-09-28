<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<style>
input[type=checkbox] {
	display: none;
}
input[type=checkbox] + label{
    cursor: pointer;
    margin-left: 30px;
    padding-top: 10px;
}
input[type=checkbox] + label:before {
    content: "";
    width: 20px;
    height: 20px;
    margin-right: 10px;
    position: absolute;
    left: 0;
    background-color: #f7f7f7;
    border-radius: 2px;
    box-shadow: inset 0px 1px 1px 0px rgba(0, 0, 0, .3), 0px 1px 0px 0px rgba(255, 255, 255, .8);  
    margin-left: 30px; 
}
input[type=checkbox]:checked + label:before{
    content: "\2714";
    text-shadow: 1px 1px 1px rgba(0, 0, 0, .2);  
    font-size: 18px; 
    font-weight:600; 
    color: #fff;  
    background:#2f87c1;
    text-align: center;
    margin-left: 30px;   
}
</style>


<body>
<!-- 메인 content -->
<div id="main-content" >
	<div class="container-fluid" >
			<div class="block-header">
	            <div class="row">
	            	<div class="col-sm-5" style="font-family: S-CoreDream-4Regular">
	                	<h2 style="padding-left:10px;font-size:2em;"><i class="fa fa-check-square-o"></i>&nbsp;설문조사 </h2>
	                </div>
	                <div class="col-sm-7" style="font-family: S-CoreDream-4Regular">
	                <c:if test="${loginUser.empId eq '201006JW0205' }">
	                	<button type="button" class="btn btn-info" style="width:120px;" onclick="qt_start();">설문시작</button>
	                	<button type="button" class="btn btn-info" style="width:120px;" onclick="qt_end();">설문종료</button>
	                </c:if>
	               		<div style="float:right;">
	               			<c:if test="${qtVO.qtBoardStYn eq 'Y' }">
	                    		<button type="button" class="btn btn-primary" style="width:80px;" onclick="apply_go();">제출</button>
	                    	</c:if>
	                    	<button type="button" onclick="window.opener.location.reload(true);window.close();" class="btn btn-secondary" style="width:80px; font-family: S-CoreDream-4Regular">닫기</button>
	                	</div>
	             	</div>
	            </div>
	        </div>
	        <div class="row clearfix">
	            <div class="col-lg-12 col-md-12 col-sm-12">
	                 <div class="body">
	                     <div class="row clearfix">
	                      <div class="table-responsive" style="padding:5px 15px; font-family: S-CoreDream-4Regular ;">
							<table class="table table-hover m-b-0">
								<thead class="shadow-none p-3 mb-5 bg-light rounded">
									<tr>
										<td style="width:130px;">
											<strong>설문 제목</strong>
										</td>
										
										<td colspan="5">
											<div style="padding-left:15px;border-left: 1px dotted gray;">${qtVO.qtBoardTitle }</div>
										</td>
									</tr>
									<tr>
										<td>
											<strong>작성자</strong>
										</td>
										<td style="width:200px;">
											<div style="padding-left:15px;border-left: 1px dotted gray;">${qtVO.empName }&nbsp${qtVO.officialName }</div>
										</td>
										<td style="width:130px;">
											<strong>설문 참여자</strong>
										</td>
										<td colspan="3">
											<div style="padding-left:15px;border-left: 1px dotted gray;">
													${loginUser.empName }
											</div>
										</td>
									</tr>
									<tr>
										<td>
											<strong>시작날짜</strong>
										</td>
										<td>
											<div style="padding-left:15px;border-left: 1px dotted gray;">
												<fmt:formatDate value="${qtVO.qtBoardStartDt }" pattern="yyyy-MM-dd"/>
											</div>
										</td>
										<td>
											<strong>종료날짜</strong>
										</td>
										<td style="width:200px;">
											<div style="padding-left:15px;border-left: 1px dotted gray;" >
												<fmt:formatDate value="${qtVO.qtBoardEndDt }" pattern="yyyy-MM-dd"/>
											</div>
										</td>
										<td style="width:130px;">
											<strong>조회수</strong>
										</td>
										<td>
											<div style="padding-left:15px;border-left: 1px dotted gray;">${qtVO.qtBoardReadcnt }</div>
										</td>
									</tr>
									<tr>
										<th>
											<i class="fa fa-user"></i>
											<strong>설문참여자</strong>
										</th>
										<th colspan="5">
											<div style="padding-left:15px;border-left: 1px dotted gray;">
												<span style="font-weight: normal;">${qtVO.participantCnt }명</span>
											</div>
										</th>
									</tr>
																						
								</thead>
							</table>
							</div>
							
							<div class="col-12">
								<div class="card">
									<div class="selected align-justify">
										<p style="font-size: 16px;font-family: S-CoreDream-6Bold; margin-top: 15px; padding: 0 30px 0 30px;">안녕하십니까? JoinWork 홈페이지에서는 사원이 필요로 하는 다양한 정보를 제공하고 있습니다.
										 사원중심의 온라인서비스를 지속적으로 확대.발전시키기 위하여 홈페이지 이용현황 및 개선사항에 대하여 여러분들의 의견을 듣고자 합니다.<br>
										응답하신 내용은 통계법 제33조에 이거 통계처리 목적 이외에는 절대 이용되지 않으니 바쁘시더라도 잠시 시간을 내어 응답해 주시면 감사하겠습니다.</p>
									</div>
								</div>
							</div>
							
							<div class="col-12" style="font-family: S-CoreDream-4Regular">
								<div class="card" style="padding: 30px;">
									<!-- 설문내용 -->
									
									<!-- 설문시행시 -->
									<c:if test="${qtVO.qtBoardStYn eq 'Y' }">
										<c:forEach items="${itemList}" var="item" varStatus="outterStatus">
											<c:if test="${item.itemMultiYn eq 'Y'}">
												<strong style="font-size: 20px;"> ${outterStatus.count }. <span class="itemId" value="${item.itemId }">${item.itemContent}</span></strong><br>
												<br>
												<c:forEach items="${selectorList}" var="selector" varStatus="innerStatus">
													<c:if test="${selector.itemId eq item.itemId }">
						                            	<div>
					                                        <input class="myCheckBox" id="${selector.selectorId}" type="checkbox" name="${item.itemId }" value="${selector.selectorId}">
					                                        <label for="${selector.selectorId}"><span>${selector.selectorName }</span><br></label>
					                                    </div>
													</c:if>
												</c:forEach>
											</c:if>
											
											<c:if test="${item.itemMultiYn ne 'Y'}">
												<strong style="font-size: 23px;">${outterStatus.count }. <span class="itemId" value="${item.itemId }">${item.itemContent}</span></strong><br>
												<c:forEach items="${selectorList}" var="selector" varStatus="innerStatus">
													<c:if test="${selector.itemId eq item.itemId }">
														<label class="fancy-radio">
							                                <input type="radio" name="${item.itemId }" value="${selector.selectorId}" required="" data-parsley-errors-container="#error-radio" data-parsley-multiple="gender">
							                                <span style="font-size: 15px; margin: 20px 0 20px 0;"><i></i>${selector.selectorName }</span>
							                            </label>
													</c:if>
												</c:forEach>
											</c:if>
											<br>
										</c:forEach>
									</c:if>
									
									<!-- 통계시 -->
									<c:if test="${qtVO.qtBoardStYn ne 'Y' }">
										<c:forEach items="${itemList}" var="item" varStatus="status">
											<c:if test="${item.itemMultiYn eq 'Y'}">
												<strong style="font-size: 20px;">${status.count }. <span class="itemId">${item.itemContent} (다중선택)</span><span style="font-size: 15px"><br>총${item.itemCnt}명 선택</span></strong><br>
												<br>
												<c:forEach items="${selectorList}" var="selector" >
													<c:if test="${selector.itemId eq item.itemId }">
													<c:set value="${selector.selectedCnt/item.itemCnt*100}" var="persentage" />
				                                        <span><i class="fa fa-circle"></i>&nbsp ${selector.selectorName }</span><br>
				                                        
														<c:choose>
															<c:when test="${(selector.selectedCnt/item.itemCnt*100) >= 80 }">
																<div class="progress" style="width: 500px;">
							                                    	<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="62" aria-valuemin="0" aria-valuemax="100" style="width: ${selector.selectedCnt/item.itemCnt*100}%;"><span>${selector.selectedCnt }명 <fmt:formatNumber value="${persentage-(persentage%1)}" type="number"/>% </span></div>
							                                    </div>
															</c:when>
															<c:when test="${(selector.selectedCnt/item.itemCnt*100) >= 60 }">
																<div class="progress" style="width: 500px;">
							                                    	<div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="31" aria-valuemin="0" aria-valuemax="100" style="width: ${selector.selectedCnt/item.itemCnt*100}%;"><span>${selector.selectedCnt }명 <fmt:formatNumber value="${persentage-(persentage%1)}" type="number"/>% </span></div>
							                                    </div>
															</c:when>
															<c:when test="${(selector.selectedCnt/item.itemCnt*100) >= 40 }">
																<div class="progress" style="width: 500px;">
							                                    	<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="78" aria-valuemin="0" aria-valuemax="100" style="width: ${selector.selectedCnt/item.itemCnt*100}%;"><span>${selector.selectedCnt }명 <fmt:formatNumber value="${persentage-(persentage%1)}" type="number"/>% </span></div>
							                                    </div>
															</c:when>
															
															<c:otherwise>
																<div class="progress" style="width: 500px;">
							                                    	<div class="progress-bar" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width: ${selector.selectedCnt/item.itemCnt*100}%;"><span>${selector.selectedCnt }명 <fmt:formatNumber value="${persentage-(persentage%1)}" type="number"/>% </span></div>
							                                    </div>
															</c:otherwise>
														</c:choose>				                                        
                            							
				                                        <br>
													</c:if>
												</c:forEach>
											</c:if>
											
											<c:if test="${item.itemMultiYn ne 'Y'}">
												<strong style="font-size: 23px;">${status.count }. <span class="itemId">${item.itemContent} (단일선택)</span><span style="font-size: 15px"><br>총${item.itemCnt}명 선택</span></strong><br>
												<br>
												<c:forEach items="${selectorList}" var="selector" >
													<c:if test="${selector.itemId eq item.itemId }">
													<c:set value="${selector.selectedCnt/item.itemCnt*100}" var="persentage" />
													
				                                        <span><i class="fa fa-circle"></i>&nbsp ${selector.selectorName }</span><br>
				                                        
				                                        <div>
					                                        <c:choose>
																<c:when test="${(selector.selectedCnt/item.itemCnt*100) >= 50 }">
																	<div class="progress" style="width: 500px;">
								                                    	<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="62" aria-valuemin="0" aria-valuemax="100" style="width: ${selector.selectedCnt/item.itemCnt*100}%;"><span>${selector.selectedCnt }명 <fmt:formatNumber value="${persentage-(persentage%1)}" type="number"/>% </span></div>
								                                    </div>
																</c:when>
																<c:otherwise>
																	<div class="progress" style="width: 500px;">
								                                    	<div class="progress-bar" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width: ${selector.selectedCnt/item.itemCnt*100}%;"><span>${selector.selectedCnt }명 <fmt:formatNumber value="${persentage-(persentage%1)}" type="number"/>% </span></div>
								                                    </div>
																</c:otherwise>
															</c:choose>	
				                                        </div>
				                                        <br>
													</c:if>
												</c:forEach>
											</c:if>
										</c:forEach>
									
									</c:if>
								</div>
							</div>
						</div>
	                 </div>
	            </div>
	        </div>
	</div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>

<script>
function apply_go() {
	var qtBoardId = '${qtVO.qtBoardId}';
	var itemLength = $(".itemId").length;
	var checkedLength = $("input:checked").length;
	var result = {};
	var selectorIdArr = [];
	var qtVO = {
		"qtBoardId":qtBoardId
	};
	
	var msg = "";
	$.ajax({
		type:"POST",
		url:"checkDuplicated",
		contentType:"application/json",
	 	data : JSON.stringify(qtVO),
		processData:true,
		async: false,
		success: function(data) {
			msg = data;
		},
		error: function(e) {
			console.log(e);
		}
	});
	
	if(msg == 'fail'){
		alert("이미 설문한 이력이 있습니다.");
		return false;
	}
	
	
	var mySet = new Set();
	
	for(var i = 0; i < checkedLength; i++){
		//체크안한 문항 체크해주는 set
		mySet.add($("input:checked").eq(i).attr("name"));		
		selectorIdArr.push($("input:checked").eq(i).val());	
	}
	
	result.qtBoardId = qtBoardId;
	result.selectorIdArr = selectorIdArr;
	
	if(mySet.size != itemLength){
		alert("체크하지 않은 문항이 있습니다. 다시확인해주세요.");
		return false;
	}
	
	
	$.ajax({
		type:"POST",
		url:"registQtResult",
		contentType:"application/json",
	 	data : JSON.stringify(result),
		processData:true,
		success: function(data) {
			console.log(data);
		},
		error: function(e) {
			console.log(e);
		}
	});
	
	alert("설문이 완료되었습니다. 감사합니다.");
	window.opener.location.reload(true);
	window.close();
	
	
}

function qt_start() {
	var qtBoardId = '${qtVO.qtBoardId}';
	var qtVO = {
			"qtBoardId":qtBoardId
		};
	$.ajax({
		type:"POST",
		url:"qtStart",
		contentType:"application/json",
	 	data : JSON.stringify(qtVO),
		processData:true,
		success: function(data) {
			console.log(data);
		},
		error: function(e) {
			console.log(e);
		}
	});
	alert("설문이 다시 활성화 됩니다.");
	window.opener.location.reload(true);
	window.close();
}

function qt_end() {
	var qtBoardId = '${qtVO.qtBoardId}';
	var qtVO = {
			"qtBoardId":qtBoardId
		};
	$.ajax({
		type:"POST",
		url:"qtEnd",
		contentType:"application/json",
	 	data : JSON.stringify(qtVO),
		processData:true,
		success: function(data) {
			console.log(data);
		},
		error: function(e) {
			console.log(e);
		}
	});
	alert("설문이 종료 됩니다.");
	window.opener.location.reload(true);
	window.close();
}



</script>

</body>
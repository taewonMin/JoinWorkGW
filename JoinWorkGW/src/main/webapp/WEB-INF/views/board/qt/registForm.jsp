<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/light/assets/fonts/font.css">


<style>
.formGroup{
 	display:none; 
}
</style>
    
<body>
<!-- Overlay For Sidebars -->
    <div id="main-content">
        <div class="container-fluid">
            <div class="block-header">
                <div class="row">
                	<div class="col-sm-3" >
                    	<h2 style="padding-left:10px; font-size:2em ; font-family:paybooc-Bold ; "><i class="icon-note"></i>&nbsp;설문작성 </h2>
                    </div>
                    <div class="col-sm-9">
                   		<div style="float:right;">
                        	<button type="button" class="btn btn-info" style="width:100px;font-size:1.2em;" onclick="submit_go();">등록</button>
                        	<button type="button" onclick="window.close();" class="btn btn-outline-secondary" style="width:100px;font-size:1.2em;">취소</button>
                    	</div>
                 	</div>
                </div>
            </div>

            <div class="row clearfix">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="card">
                        <div class="body">
	                            <div class="row clearfix">
		                             
		                             <!-- 본문 -->
		                             <div class="col-md-3 col-sm-12">
		                                 <label class="boardWriter">작성자</label>
		                                 <div class="form-group">
		                                     <input type="text" readonly class="form-control" placeholder="" value="${loginUser.empName }" >
		                                 </div>
		                             </div>
									 <div class="col-sm-12" style="display: block;">
		                                 <div class="form-group">
		                                 <label class="boardTitle">설문 제목</label>
		                                     <input type="text" id="qtBoardTitle" class="form-control" placeholder="">
		                                 </div>
		                             </div>
		                             
		                             <div class="col-sm-6" >
	                                 	<div class="form-group">
	                                 	<label>설문 시작</label>
	                                 		<div class="input-group date" data-date-autoclose="true" data-provide="datepicker">
			                                 	<input type="text" class="form-control" id="qtBoardStartDt" placeholder="설문 시작일자 선택" readonly="readonly">
				                                <div class="input-group-append">                                            
				                                    <button class="btn btn-outline-secondary" type="button"><i class="fa fa-calendar"></i></button>
				                                </div>
			                                </div>
	                                 	</div>
	                                 </div>
		                             <div class="col-sm-6 ">
	                                 	<div class="form-group">
	                                 	<label>설문 종료</label>
		                                	<div class="input-group date" data-date-autoclose="true" data-provide="datepicker">
				                                <input type="text" id="qtBoardEndDt" class="form-control" placeholder="설문 종료일자 선택" readonly>
				                                <div class="input-group-append">                                            
				                                    <button class="btn btn-outline-secondary" type="button"><i class="fa fa-calendar"></i></button>
				                                </div>
			                                </div>
	                                 	</div>
	                                 </div>
	                                 <div class="col-sm-12">
	                                 	<div class="form-group">
	                                 		<label>설문 작성</label>
	                                 		<button onclick="addQtItem();" type="button" class="btn btn-info float-right" >설문 항목 추가</button>
	                                 	</div>
	                                 </div>
	                                 <div class="col-sm-12 ItemAppendDiv">
	                                 
	                                 </div>
	                                 
	                                 
	                            </div>
                               
                        </div>
                    </div>
                </div>
            </div>
        </div>
	</div>

<script>
function addQtItem() {
	var item = "<div style='margin-top: 10px;'>항목 : <input class='item form-control' name='item' type='text' style='display: inline; width:610px;'>&nbsp&nbsp"
			+ "<button class='btn btn-outline-secondary' type='button' onclick='addCheckBox(this);'>다중선택 추가</button>"
			+ "<button class='btn btn-outline-secondary' type='button' onclick='addRadioBox(this);'>단일선택 추가</button>&nbsp&nbsp<i class='fa fa-trash-o' style='cursor:pointer; font-size:20px;' onclick='deleteItem(this);'></i></div>";
	$(".ItemAppendDiv").append(item);
	
}

function deleteItem(obj){
	$(obj).parent().remove();
}

//체크박스로 설문
function addCheckBox(obj){
	if($(obj).parent().find(".radioBoxGroup").length > 0){
		alert("단일선택과 다중선택을 같이 할 수는 없습니다.");
		return false;
	}
	var checkBox = "<div class='checkBoxGroup' style='margin-top: 5px;'>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp다중 선택문  <i class='fa fa-long-arrow-right' ></i>"
				+ "&nbsp&nbsp<input class='form-control checkSelector' name='' type='text' style='display: inline; width:515px;'>"
				+ "&nbsp&nbsp<i class='fa fa-trash-o' style='cursor:pointer;font-size: 20px;' onclick='deleteItem(this);'></i><br></div>";
	$(obj).parent().append(checkBox);
}

//라디오박스로 설문
function addRadioBox(obj){
	if($(obj).parent().find(".checkBoxGroup").length > 0){
		alert("단일선택과 다중선택을 같이 할 수는 없습니다.");
		return false;
	}
	var radioBox = "<div class='radioBoxGroup' style='margin-top: 5px;'>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp단일 선택문  <i class='fa fa-long-arrow-right' ></i>"
		+ "&nbsp&nbsp<input class='form-control radioSelector' name='' type='text' style='display: inline; width:515px;'>"
		+ "&nbsp&nbsp<i class='fa fa-trash-o' style='cursor:pointer;font-size: 20px;' onclick='deleteItem(this);'></i><br></div>";
	$(obj).parent().append(radioBox);
}

function submit_go(){
	var title = $("#qtBoardTitle").val();
	var qtBoardStartDt = $("#qtBoardStartDt").val();
	var qtBoardEndDt = $("#qtBoardEndDt").val();
	var qtVO = {
		"qtBoardTitle" : title
		,"qtBoardStartDt" : qtBoardStartDt
		,"qtBoardEndDt": qtBoardEndDt
	};
	
	if(!title){
		alert("제목이 비어있습니다.");
		return false;
	}
	if(!qtBoardStartDt){
		alert("시작일자가 비어있습니다.");
		return false;
	}
	if(!qtBoardEndDt){
		alert("종료일자가 비어있습니다.");
		return false;
	}
	
	
	var qtBoardStartDt = $("#qtBoardStartDt").val();
	var qtBoardEndDt = $("#qtBoardEndDt").val();
	var currentDt = new Date();
	
	var yearSt = qtBoardStartDt.split("/")[2];
	var monthSt = qtBoardStartDt.split("/")[0];
	var dateSt = qtBoardStartDt.split("/")[1];
	
	var yearEnd = qtBoardEndDt.split("/")[2];
	var monthEnd = qtBoardEndDt.split("/")[0];
	var dateEnd = qtBoardEndDt.split("/")[1];
	
	var yearSys = currentDt.getFullYear();
	var monthSys = currentDt.getMonth()+1;
	var dateSys = currentDt.getDate();
	
	
	
	
	var sysDt = new Date(yearSys,monthSys,dateSys);
	var startDt = new Date(yearSt,monthSt,dateSt);
	var endDt = new Date(yearEnd,monthEnd,dateEnd);
	
	var differentDt = (startDt.getTime() - sysDt.getTime());
	if(differentDt < 0){
		alert("시작 일자가 이미 지난 일자 입니다.");
		return false;
	}
	
	differentDt = (endDt.getTime() - startDt.getTime());
	if(differentDt < 0){
		alert("종료 일자가 시작 일자보다 빠릅니다. 다시 확인해 주세요.");
		return false;
	}
	
	
	var itemLength = $(".item").length;
	var itemArr = [];
	
	
	for(var i = 0; i < itemLength; i++){
		if(!$(".item").eq(i).val()){
			alert("항목 내용이 비어있습니다.");
			return false;
		}
		var itemObj = {};
		var itemContent = $(".item").eq(i).val();
		var itemMultiYn = "";
		itemObj.itemContent = itemContent;
		if($(".item").eq(i).parent().find(".checkBoxGroup").length > 0){
			itemMultiYn = "Y";
			itemObj.itemMultiYn = itemMultiYn;
			var checkSelectorArr = []; 
			for(var j = 0; j < $(".item").eq(i).parent().find(".checkBoxGroup").length; j++){
				var checkSelector = $(".item").eq(i).parent().find(".checkBoxGroup").find(".checkSelector").eq(j).val();
				if(!checkSelector){
					alert("선택목록이 비어 있습니다. 다시확인 해주세요.");
					return false;
				}
				
				checkSelectorArr.push(checkSelector);
				
			}
			itemObj.checkSelectorArr = checkSelectorArr;
		}
		
		if($(".item").eq(i).parent().find(".radioBoxGroup").length > 0){
			itemMultiYn = "N";
			itemObj.itemMultiYn = itemMultiYn;
			var checkSelectorArr = []; 
			for(var j = 0; j < $(".item").eq(i).parent().find(".radioBoxGroup").length; j++){
				var checkSelector = $(".item").eq(i).parent().find(".radioBoxGroup").find(".radioSelector").eq(j).val();
				if(!checkSelector){
					alert("선택목록이 비어 있습니다. 다시확인 해주세요.");
					return false;
				}
				
				checkSelectorArr.push(checkSelector);
				
			}
			itemObj.checkSelectorArr = checkSelectorArr;
		}
		itemArr.push(itemObj);
		
		
	}
	qtVO.itemArr = itemArr;
	console.log(qtVO);
	$.ajax({
		type:"POST",
		url:"regist",
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
	
	alert("설문등록이 완료되었습니다.");
	opener.location.reload();	
	window.close();
	
	
}


	


</script>


</body>

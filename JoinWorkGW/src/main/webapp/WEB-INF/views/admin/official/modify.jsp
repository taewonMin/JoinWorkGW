<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
#headDiv{
	float: left;
}
.whole{
	margin-top: 20px;
}
input.btn.float-right {
	margin-left: 10px;
	width: 20%;
}
.form-group.row{
	margin: 0px;
}
#registBody{
	padding: 0px 20px 30px 20px;
}
.form-control[readonly], .form-control{
	background-color: #ffffff;
}
</style>

<!-- 메인 content -->
<div class="container-fluid">
	<!-- 메인 content 넣는 곳 -->
	<div class="row clearfix">
        <div class="col-lg-12 whole">
            <div class="card">
                <div class="header">
                	<div id="headDiv">
	                    <h3>직책수정</h3>
                	</div>
                    <input type="button" onclick="CloseWindow();" class="btn btn-secondary float-right" value="닫기">
                    <input type="button" onclick="modify();" class="btn btn-info float-right" id="realModifyBtn" value="저장">
                </div>
                <br>
                <hr/>
                
                
                <div class="body"  id="registBody">
	                <form id="basic-form" class="horizontal" method="post">
                         <div class="form-group row">
                             <label class="col-sm-2 float-left" for="codeId" >직책코드</label>
                             <div class="col-sm-10 input-group input-group-sm ">
	                             <input type="text" name="codeId" class="form-control" value="${code.codeId }" required="true" readonly="true">
                             </div>
                         </div>
                         <div class="form-group row">
                             <label class="col-sm-2 float-left" style="margin-top: 10px;" for="codeName" >직책명</label>
                             <div class="col-sm-10 input-group input-group-sm">
	                             <input type="text" name="codeName" class="form-control float-left" value="${code.codeName}" required="true" autocomplete="off" >
	                             <button type="button" class="btn btn-sm btn-info  float-right" onclick="checkName();">중복확인</button>
	                             <input type="hidden" value="0" id="dupleYN">
                             </div>
                         </div>
                     </form>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
function modify(){
	var codeId = $('input[name="codeId"]').val(); // readonly
	var codeName = $('input[name="codeName"]').val().trim();
	var dupleYN = $('#dupleYN').val();
	
	if(!codeName || codeName == ""){
		alert("직책명은 필수입니다.");
		return false;
	}else if(dupleYN == 0){
		alert('직책명 중복확인은 필수입니다.');
	}
	
	var editData = {
			 codeId:codeId
			,codeName:codeName
			,codeGroupName:'직급'
			,codeYn:'Y'
			,codeGroupId:'O'
	};
		
	$.ajax({
		url: "<%=request.getContextPath()%>/admin/official/modify"
		,type: "post"
       ,data: editData
       ,success: function (response) {
			console.log(response);
			if(response > 0){
				alert('직책이 수정되었습니다.');
				CloseWindow();
			}else{
				alert('직책 수정에 실패하였습니다.');
				return false;
			}
       }
       ,error: function(request, status, error){
    	   console.log("error 발생 >> " +error);
       }
	});
	
}

function checkName(){
	var codeName = $('input[name="codeName"]').val().trim();
	var sendData = {codeName:codeName}; 
	
	if(!codeName || codeName == ""){
		alert("직책명을 입력해주세요.");
		return false;
	}
	
	$.ajax({
		url: "<%=request.getContextPath()%>/admin/official/checkName"
		,type: "post"
        ,data: sendData
        ,success: function (response) {
			if(response > 0){
				alert('중복된 직책명이 있습니다. 다시 입력해주세요.');
				$('#dupleYN').val(0);
				result = false;
			}else{
				alert('사용가능한 직책명입니다.');
				$('#dupleYN').val(1);
				result = true;
			}
        }
        ,error: function(request, status, error){
     	   console.log("error 발생 >> " +error);
        }
	});
}

</script>
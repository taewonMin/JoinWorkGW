<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

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
	margin: 10px 0px 10px;
	
}
#registBody{
	padding: 0px 20px 30px 20px;
}
.form-control[readonly], .form-control{
	background-color: #ffffff;
}
.form-group.row label.col-sm-2.float-left{
	padding: 5px 0px 0px 0px;
	margin-top: 10px;
}
#deptNameLabel{
	margin-top: 0px;
}
.input-group{
	margin-top: 10px;
	
}
input#deptTeamYn1, input#deptTeamYn2 {
	width: 15px;
    font-size: smaller;
    margin: 10px 0px 0px 0px; 
}
#deptTeamYnDiv label{
	margin: 10px 40px 0px 40px;
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
	                    <h3>부서/팀 수정</h3>
                	</div>
                    <input type="button" onclick="CloseWindow();" class="btn btn-secondary float-right" value="닫기">
                    <input type="button" onclick="save();" class="btn btn-info float-right" id="saveBtn" value="저장">
                </div>
                <br>
                <hr/>
                
                
                <div class="body"  id="modifyBody">
	                <form:form commandName="deptVO" id="modifyForm" name="modifyForm" class="horizontal" method="post" autocomplete="off">
                         <div class="form-group row">
                             <label class="col-sm-2 float-left" id="deptNameLabel" style="margin-top: 10px;" for="deptName" >명칭</label>
                             <div class="col-sm-10 input-group">
	                             <form:input type="text" path="deptName" id="deptName" class="form-control float-left" required="true" />
	                             <button type="button" class="btn btn-sm btn-info  float-right" onclick="checkName();">중복확인</button>
	                             <input type="hidden" value="0" id="dupleYN">
                             </div>
                         </div>
                         <div class="form-group row">
                             <label class="col-sm-2 float-left" for="deptHp" >연락처</label>
                             <div class="col-sm-10 input-group">
								<form:select path="deptHp" id="deptHp" cssClass="form-control float-left" style="width:75px;" multiple="false">
									<form:option value="">-선택-</form:option>
									<form:option value="02">02</form:option>
									<form:option value="051">051</form:option>
									<form:option value="053">053</form:option>
									<form:option value="032">032</form:option>
									<form:option value="062">062</form:option>
									<form:option value="042">042</form:option>
									<form:option value="052">052</form:option>
									<form:option value="044">044</form:option>
									<form:option value="031">031</form:option>
									<form:option value="033">033</form:option>
									<form:option value="043">043</form:option>
									<form:option value="041">041</form:option>
									<form:option value="063">063</form:option>
									<form:option value="061">061</form:option>
									<form:option value="054">054</form:option>
									<form:option value="055">055</form:option>
									<form:option value="064">064</form:option>
								</form:select>
								<label class="float-left" style="padding: 0; text-align: center;">&nbsp;-&nbsp;</label>										
								<form:input path="deptHp" class="form-control float-left" style="width:68px;"/>						
								<label class="float-left" style="padding: 0; text-align: center;">&nbsp;-</label>
								<form:input path="deptHp" class="form-control float-right" style="width:68px;"/>						
							</div>
                         </div>
                         <div class="form-group row">
                             <label class="col-sm-2 float-left" for="deptLeaderId" >부서장</label>
                             <div class="col-sm-10 input-group">
								<form:select path="deptLeaderId" id="deptLeaderId" cssClass="form-control float-left" style="width:75px;" multiple="false">
									<option value="">-선택-</option>
									<form:options items="${empList }"/>
								</form:select>
							</div>
                         </div>
                         <div class="form-group row">
                             <label class="col-sm-2 float-left" for="deptLeaderId" >부서장</label>
                             <div class="col-sm-10 input-group">
								<form:select path="deptLeaderId" id="deptLeaderId" cssClass="form-control float-left" style="width:75px;" multiple="false">
									<option value="">-선택-</option>
									<form:options items="${empList }"/>
								</form:select>
							</div>
                         </div>
                         <div class="form-group row">
                             <label class="col-sm-2 float-left" id="deptStLabel" style="margin-top: 10px;" for="deptSt" >상태</label>
                             <div class="col-sm-10 input-group">
	                             <form:input type="text" path="deptSt" id="deptSt" class="form-control float-left" required="true" />
	                             <button type="button" class="btn btn-sm btn-info  float-right" onclick="checkName();">중복확인</button>
	                             <input type="hidden" value="0" id="dupleYN">
                             </div>
                         </div>
                     </form:form>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
function save(){ // 수정사항 저장
	
	var dupleYN = $('#dupleYN').val();
	
	var deptName = $('#deptName').val().trim();
	if(!deptName) {
		alert('명칭은 필수입니다.');
		return false;
// 	}else if(dupleYN == 0){
// 		alert('직책명 중복확인은 필수입니다.');
//		return false;
	}
	
	var sup = $('#deptSupId');
	
	if($(':radio[name=deptTeamYn]:checked').length < 1){ 
		alert('팀/부서여부 선택은 필수입니다.');
		return false;
	}else if($(':radio[name=deptTeamYn]')[0].checked){
		if($('#deptSupId > option:selected').val() == '0'){
// 		if($('#deptSupId > option:selected').val() == '0' || sup[0][0].selected){
			alert('팀 생성 시 상위부서 선택은 필수입니다.');
			return false;
		}
	}
	
	
	var basicForm = document.basicForm;
	console.log(basicForm);
	console.dir(basicForm);
	
	var registData = {
			deptVO:basicForm
	}
	
	$.ajax({
		url: "<%=request.getContextPath()%>/admin/dept/regist"
		,type: "post"
        ,data: registData
        ,success: function (response) {
			console.log(response);
			if(response > 0){
				alert('부서가 등록되었습니다.');
				CloseWindow();
			}else{
				alert('부서 등록에 실패하였습니다.');
				return false;
			}
        }
        ,error: function(request, status, error){
     	   console.log("error 발생 >> " +error);
        }
	});

}

function checkName(){
	
	var deptName = $('#deptName').val().trim();
	if(!deptName) {
		alert('명칭은 필수입니다.');
		return false;
	}

	
	
	var sendData = {deptName:deptName}; 
	
	
	$.ajax({
		url: "<%=request.getContextPath()%>/admin/dept/checkName"
		,type: "post"
        ,data: sendData
        ,success: function (response) {
			if(response > 0){
				alert('중복된 부서명이 있습니다. 다시 입력해주세요.');
				$('#dupleYN').val(0);
				result = false;
			}else{
				alert('사용가능한 부서명입니다.');
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
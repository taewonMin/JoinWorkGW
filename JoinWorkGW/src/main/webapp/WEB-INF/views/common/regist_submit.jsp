<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
	function regist_go(){
	//alert("등록 버튼 클릭");

	var uploadCheck = $('input[name="checkUpload"]').val();
	if(!(uploadCheck>0)){
		alert("사진 업로드는 필수입니다.");	
		//$('input[name="pictureFile"]').click();
		return;
	}
	
	if($('input[name="id"]').val()==""){
		alert("아이디는 필수입니다.");
		return;
	} 
	
	if($('input[name="id"]').val()!=checkedID){
		alert("아이디 중복확인이 필요합니다.");
		return;
	}
	
	if($('input[name="pwd"]').val()==""){
		alert("패스워드는 필수입니다.");
		return;
	}	
	if($('input[name="name"]').val()==""){
		alert("이름은 필수입니다.");
		return;
	}	
	
	var form = $('form[role="form"]');
	form.submit();
}
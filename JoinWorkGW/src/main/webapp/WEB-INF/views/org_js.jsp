<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
//조직도
$("#codeList").treeview({collapsed: false});

//조직도 출력
function deptTrees(){
   $.ajax({
      type:"GET",
      url:"<c:url value='/orgList' />",
      contentType:"application/json",
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
                	li = '<li onclick="empChecked(this);" stName="'+stName+'" id="'+ deptId +'" lvl="'+level +'" class="orgEmp" style="cursor:pointer" ><img src="<%=request.getContextPath() %>/resources/js/treeview/images/emp.png" >'+" "+ deptName + " "+e.position+'<span class="badge badge-warning">'+stName+'</span></li>';
             	}else{
                	li = '<li onclick="empChecked(this);" stName="'+stName+'" id="'+ deptId +'" lvl="'+level +'" class="orgEmp" style="cursor:pointer" ><img src="<%=request.getContextPath() %>/resources/js/treeview/images/emp.png" >'+" "+ deptName + " "+e.position+'</li>';
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
                      li = "<ul class='' style='display: none;' >" + li + "</ul>";
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


function empChecked(obj) {
	var empId = $(obj).attr("id");
   //기존 체크된 css 및 클래스 정보 삭제
   $(".myChecked").css("background-color","");
   $("li").removeClass("myChecked");
   
   //새로 체크된 css 및 클래스 정보 갱신
   $(obj).addClass("myChecked");
   $(".myChecked").css("background-color","#2980b9");
	$.ajax({
		type:"POST",
		url:"<c:url value='/emp/getEmp'/>",
		contentType:"application/json",
	 	data : empId,
		processData:true,
		success: function(data) {
			var attendStName = data.attendStName;
			var deptName = data.deptName;
			var empEmail = data.empEmail;
			var empHp = data.empHp;
			var officialName = data.officialName;
			var empName = data.empName;
			var empId = data.empId;
			var stSpan = "";
			
			$("#defaultModalLabel").html(deptName);
			$("#modalName").html(empName+' '+officialName);
			$("#modalName").attr("value",empName+' '+officialName);
			$("#modalName").attr("data-empId",empId);
			$("#modalEmail").html(empEmail);
			$("#modalHp").html(empHp);
			if(attendStName === '휴가중'){
				stSpan = "&nbsp<span class='badge badge-warning'>"+attendStName+"</span>";
			}else{
				stSpan = "&nbsp<span class='badge badge-success'>"+attendStName+"</span>";
			}
			$("#modalName").append(stSpan);
			
			getModalPicture(empId);
		},
		error: function(e) {
			console.log(e);
		}
	});
	$("#viewModal").click();
}

function getModalPicture(empId){
	var imageURL = "/JoinWorkGW/emp/getPicture?picture="+empId+".jpg";
	$('div#empPicture').css({'background-image':'url('+imageURL+')',
		'background-position':'center',
		'background-size':'cover',
		'background-repeat':'no-repeat'
	}).trigger("create");
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

// id="displayAndHiddenOrg" class="nav-link " data-toggle="dropdown"

function orgHiddenAndShow(obj){
   console.log($(obj).attr("data-toggle"));
   
	if($(obj).attr("data-toggle") != ""){
	setTimeout(function(){
		$(obj).attr("data-toggle","");
		$(obj).children("#openCloseIcon").removeClass("fa fa-chevron-down");
		$(obj).children("#openCloseIcon").addClass("fa fa-chevron-up");
		$("#hiddenMenu").css("top","0%");
		return false;
	},100)
	}else{
				
		$(obj).attr("data-toggle","dropdown");
		$(obj).children("#openCloseIcon").removeClass("fa fa-chevron-up");
		$(obj).children("#openCloseIcon").addClass("fa fa-chevron-down");
		return false;
	}
   
}  
   


function dutyIndication(obj){
	var empName = $(obj).parent().find("#modalName").attr("value");
	var empId = $(obj).parent().find("#modalName").attr("data-empId");
	
 	var openWin = window.open('/JoinWorkGW/board/duty/registForm?registParam=duty', '업무 작성', "width=1000, height=700");
	
	var tempTag = "";
	
	tempTag += '<div style="border:1px solid #ced4da;border-radius: 0.25rem;padding:10px 15px;width:150px;display:inline-block;">'
			+'<span>'+empName+'</span>'
			+'<div class="hiddenId manager" style="display:none;" value="'+empId+'"></div>'
			+'<i class="icon-close" style="float:right;cursor:pointer;margin-top:5px;" onclick="deleteElement(this);"></i>'
			+'</div>';
			
	setTimeout(function(){
		console.log(openWin.document.getElementById("myEmpFinish"));
		openWin.document.getElementById("myEmpFinish").innerHTML = tempTag;
	},800)
}

//조직도 검색을 위한 함수입니다. className = orgEmp
function searchOrg(obj){
	var keyword = $(obj).val();
	if(!keyword){//검색조건이 비어있으면 리턴
		$("#codeList")[0].scrollIntoView();
		$(".myChecked").css("background-color","");
		return false;
	}
	$(".myChecked").css("background-color","");
	$(".myChecked").removeClass("myChecked");
	
	var $plusIcon = $("li .orgEmp:contains('"+keyword+"')").eq(0).parent().parent().children("div");//한칸
	var $plusIcon2 = $("li .orgEmp:contains('"+keyword+"')").eq(1).parent().parent().children("div");//한칸이상
	
	if($("li .orgEmp:contains('"+keyword+"')").eq(0).attr("lvl") == 5){
		
		$($plusIcon).parent("li").removeClass("expandable lastExpandable");
		$($plusIcon).parent("li").addClass("collapsable lastCollapsable");
		$($plusIcon).removeClass("hitarea expandable-hitarea lastExpandable-hitarea");
		$($plusIcon).addClass("hitarea collapsable-hitarea lastCollapsable-hitarea");
		$($plusIcon).parent("li").children("ul").css("display","block");
		
		$("li .orgEmp:contains('"+keyword+"')").eq(0)[0].scrollIntoView();
		$("li .orgEmp:contains('"+keyword+"')").eq(0).addClass("myChecked");
		$(".myChecked").css("background-color","#2980b9");
	}else{
		if($("li:contains('"+keyword+"')").eq(3)[0]){
			$($plusIcon2).parent("li").removeClass("expandable lastExpandable");
			$($plusIcon2).parent("li").addClass("collapsable lastCollapsable");
			$($plusIcon2).removeClass("hitarea expandable-hitarea lastExpandable-hitarea");
			$($plusIcon2).addClass("hitarea collapsable-hitarea lastCollapsable-hitarea");
			$($plusIcon2).parent("li").children("ul").css("display","block");
			
			$("li:contains('"+keyword+"')").eq(3)[0].scrollIntoView();
			$("li:contains('"+keyword+"')").eq(3).addClass("myChecked");
			$(".myChecked").css("background-color","#2980b9");
		}
	}
	
}














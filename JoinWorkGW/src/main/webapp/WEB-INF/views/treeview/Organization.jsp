<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>조직도 TreeView</title>
	
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/js/treeview/jquery.treeview.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/js/treeview/screen.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/treeview/jquery.cookie.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/treeview/jquery.treeview.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/treeview/jquery.treeview.edit.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/treeview/jquery.treeview.async.js"></script>

<script>
function deptTrees(){
	$.ajax({
		type:"GET",
		url:"<c:url value='/orgList'/>",
		contentType:"application/json",
	// 	data:dataSet,
		processData:true,
		success: function(data) {
			data.forEach(function(e, i) {
				var deptId = e.deptId;
				var deptName = e.deptName;
			    var deptSupId = e.deptSupId;
			    var position = e.position
			    var level = 5;
			    var li = "";
			    if(e.level){
					level = e.level;
			    } 
				
			    if(position){
				    li = '<li id="'+ deptId +'" lvl="'+level +'"><img src="<%=request.getContextPath() %>/resources/js/treeview/images/emp.png" ><a  class="file code myHover">'+" "+ deptName + " "+e.position+'</a></li>';
			    }else{
			    	li = '<li id="'+ deptId +'" lvl="'+level +'"><a class="file code">'+ deptName +'</a></li>';
			    }
				
				
				// 1레벨은 그냥 추가
				// 다음 레벨부터는 상위 li의 클래스를 폴더로 바꾸고 자기 자신을 추가
			    if(level == 1) {
					$("#lvl0").append(li);
				} else {
					  var parentLi = $("li[id='"+ deptSupId +"']");
					  
					  parentLi.addClass("expandable lastExpandable");
				      parentLi.find("a").removeClass("file");
				      parentLi.find("a").addClass("folder");
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


$(document).ready(function(){
	deptTrees();
	$("#refresh").click(function() {
		$("#codeList").empty();
		deptTrees();
	});
	$("#codeList").treeview({collapsed: true});
});

</script>


</head>
<body>


<ul id="codeList">

	<li ><a class="folder code">조직도</a>

		<ul id="lvl0"><!-- 자식 노드가 들어올 공간--></ul> 

	</li>

</ul>

	<form id="searchForm">
		<input type="hidden" name="parent" value="0" />
	</form>

</head>
<body>

</body>
</html>
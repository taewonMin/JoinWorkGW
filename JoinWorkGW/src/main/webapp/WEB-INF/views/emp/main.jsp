<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/js/treeview/jquery.treeview.css" />
	<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/js/treeview/screen.css" />
	<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/emp.css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/js/treeview/jquery.cookie.js"></script>
	<script src="<%=request.getContextPath() %>/resources/js/treeview/jquery.treeview.js"></script>
	<script src="<%=request.getContextPath() %>/resources/js/treeview/jquery.treeview.edit.js"></script>
	<script src="<%=request.getContextPath() %>/resources/js/treeview/jquery.treeview.async.js"></script>
	
	<!--orgChart -->
	<link rel="icon" href="<%=request.getContextPath() %>/resources/image/charOrgLogo.png">
  	<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/jquery.orgchart.css">
  	<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/style.css">
  	
	<!-- common css -->
  	<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/common.css">
  	<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/light/assets/fonts/font.css">



<body> 
<!-- 사이드바 -->
<div id="left-sidebar" class="sidebar" style="border-right:2px solid rgb(0,0,0,0.1); font-family: S-CoreDream-6Bold; font-size:17px ;">
	<div class="sidebar-scroll">
		<!-- 여기 사이드바 넣는곳 -->
		<div>
			<ul id="codeList">
				<li>JoinWorkGW 조직도
					<ul id="lvl0"><!-- 자식 노드가 들어올 공간--></ul> 
				</li>
			</ul>
		</div>
		
	</div>
</div>

<!-- 메인 content -->
<div id="main-content" style="font-family: S-CoreDream-6Bold; ">
	<div class="container-fluid" >
		<!-- 메인 content 넣는 곳 -->
		<div id="chart-container"></div>
		
		
	</div>
</div>










<!-- 공통모듈 -->
<script>
function deptTrees(){
	$.ajax({
		type:"GET",
		url:"/JoinWorkGW/orgList",
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
				    li = '<li onclick="empDetail(this);" id="'+ deptId +'" lvl="'+level +'" class="myHover" ><img src="<%=request.getContextPath() %>/resources/js/treeview/images/emp.png" >'+" "+ deptName + " "+e.position+'</li>';
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

window.onload = function(){
	deptTrees();
// 	getOrgChart();
	//부서클릭시 부서에 속한 직원 상세조회
}

$("#codeList").treeview({collapsed: false});

</script>


<script>
function empDetail(obj){
	var empId = $(obj).attr("id");
	$.ajax({
		type:"POST",
		url:"<%=request.getContextPath()%>/emp/getEmpModal",
		contentType:"application/json",
		data: empId,
		processData:true,
		success: function(data) {
			var empId = data.emp.empId;
			var empName = data.emp.empName;
			var officialPositionName = data.officialPositionName;
			var empPicture = data.emp.empPicture;//사진경로 
			var empEmail = data.emp.empEmail;
			
			OpenModal(empId, empName, officialPositionName, empPicture, empEmail);
			
		},
		error: function(e){
			alert("직원상세조회중 에러발생!");
		}
		
		
	});
	
}

function OpenModal(empId, empName, officialPositionName, empPicture, empEmail){
	if($(".myModal")){
		$(".myModal").remove();
	}
	
	var str = '<div class="myModal out" style="border: 3px solid gray; border-radius: 10%;">';
		str += '<div class="in">';
		str += '   <a href="#" class="close">X</a>';
		str += '   <input value='+empId+' type="hidden">';
		str += '   <br><br><br>';
		str += '   <h6 style="font-weight: bold; color: gray; font-size: 25px;">JoinWorkGW</h6>';
		str += '   <div class="chart easy-pie-chart-1" data-percent="75"> <span><img src="<%=request.getContextPath() %>/resources/templates/assets/images/sm/avatar1.jpg" alt="user" class="rounded-circle"/></span></div>';
		str += '   <h5 style="font-weight: bold;">'+empName+' '+officialPositionName+'</h5>';
		str += '   <p style="font-size: 13px; font-weight: bold;">'+empEmail+'</p>';
		str += '   <h6 style="font-weight: bold; ">'+empId+'</h6>';
		str += '   <div class="m-t-15">';
		str += '       <button class="btn btn-sm btn-info" style= "border-radius: 25%; "><i class="icon-users"/> 주소록 추가</button>';
		str += '      <button class="btn btn-sm btn-success" style= "border-radius: 25%; "><i class="icon-calendar"/> 일정보기</button>';
	    str += '   </div>';
	    str += '</div></div>';
	
	 $("#main-content").append(str);   
}


// $("body").click(function(){
// 	if($(".myModal")){
// 		$(".myModal").remove();
// 	}
// });


$(document).on("click", ".close", function(){
	$(".myModal").remove();
});

</script>
  
  
<!--orgChart시작 -->
<script>

$(function() {
      $.mockjax({
        url: '/orgchart/initdata',
        responseTime: 500,
        contentType: 'application/json',
        responseText: {
          'name': 'JoinWorkGW',
          'title': '윤종찬 사장',
          'id': '',
          'children': [
            {'id':'dd01', 'name': '총무기획부', 'title': '' ,
              'children': [
                {'id':'dd02', 'name': '마케팅부', 'title': '' },
                {'id':'dd03', 'name': '구매/생산부', 'title': '' },
                {'id':'dd04', 'name': '인사부', 'title': '' },
                {'id':'dd05', 'name': '배송부', 'title': '' },
                {'id':'dd08', 'name': '영업부', 'title': '' },
                {'id':'dd09', 'name': '기획부', 'title': '', 
                  'children': [
                    {'id':'dd06', 'name': 'IT부', 'title': '' },
                    {'id':'dd07', 'name': '홍보부', 'title': '' },
                    {'id':'dd10', 'name': '자금부', 'title': '' },
                    {'id':'dd11', 'name': '경리부', 'title': '' ,
                    	'children': [
                    		{'id':'dd12', 'name': '불철주야팀', 'title': '민태원' }
                    	]
                    }
                  ]
                }
              ]
            }
          ]
        }
      });

      $('#chart-container').orgchart({
        'data' : '/orgchart/initdata',
        'nodeContent': 'title'
      });
});



$(document).on("click", ".node", function(){
	var deptId = $(this).attr("id");
	if(deptId){
		deptId = deptId.substr("1");
	}else{
		return false;
	}
	
	$.ajax({
		type:"POST",
		url:"<%=request.getContextPath()%>/emp/getDeptDetail",
		contentType:"application/json",
		data: deptId,
		processData:true,
		success: function(data) {
			OpenModalDeptDetail(data);
			
		},
		error: function(e){
			alert("직원상세조회중 에러발생!");
		}
		
		
	});
	
})

function OpenModalDeptDetail(data){
	if($(".deptModal")){
		$(".deptModal").remove();
	}
	if(!data){
		$(".deptModal").remove();
		return false;
	}
	if($(".container-fluid")){
		$(".container-fluid").css("z-index","1");
	}
	
	
	var str = "";
	str += '<div id="main-content" class="deptModal">';
	str += '	<div class="container-fluid">';
	str += '		<table class="table table-hover js-basic-example dataTable table-custom table-striped m-b-0 c_list">';
	str += '<thead class="thead-dark">';
	str += '<tr>';
	str += '<th></th>';
	str += '<th>이름</th>';
	str += '<th>직급</th>';
	str += '<th>부서/팀</th>';
	str += '<th>연락처</th>';
	str += '</tr>';
	str += '</thead>';
	str += '<tbody>';
	
	for(var i = 0;i < data.length ; i++){
	str += '<tr>';
	str += '<td class="width45">';
	str += '	             <img src="" class="rounded-circle avatar" alt="">';
	str += '	             </td>';
	str += '	             <td>';
	str += '	                 <h6 class="mb-0">'+data[i].empName+'</h6>';
	str += '	                 <span>marshall-n@gmail.com</span>';
	str += '	             </td>';
	str += '	             <td><span>'+data[i].officialPositionName+'</span></td>';
	str += '	             <td><span>'+data[i].deptName+'</span></td>';
	str += '	             <td>'+data[i].empHp+'</td>';
	str += '</tr>';
	}
	str += '	     </tbody>';
	str += '	 </table>';
	str += '	</div>';
	str += '</div>';
	
	$("#main-content").append(str);   
	
}







// function getOrgChart(){
// 	$.ajax({
// 			type:"POST",
<%-- 			url:"<%=request.getContextPath()%>/getOrgChart", --%>
// 			contentType:"application/json",
// 			processData:true,
// 			success: function(data) {
// 				var map = {};
				
// 				for(var i = 0; i < data.length; i++){
// 					var obj = {"id" : data[i].id, "name" : data[i].name , "title" : data[i].title};
// 					obj.children = [];
// // 					map[obj.id] = obj;
					
// 					var parent = data[i].parent;
					
// 					if(!map[parent]){
// 						map[parent] = {
// 								children : []
// 						};
// 					}
// 					console.log(map);
// 					if(map[parent].children[parent]){
// 						map[parent].children[children].push(obj);
// 					}else{
// 						map[parent].children.push(obj);
// 					}					
					
// 				}
// 			console.log(map);
// // 			console.log(map["d01"]);
// 				var orgChart = {
// 									name: 'JoinWorkGW',
// 							        title: '윤종찬',
// 							        id: '음냐음냐',
// 							        children :[
// 							        	{'id':'gigi', 'name': 'Bo Miao', 'title': 'department manager' },
// 							            { 'name': 'Su Miao', 'title': 'department manager',
// 							              'children': [
// 							                { 'name': 'Tie Hua', 'title': 'senior engineer' },
// 							                { 'name': 'Hei Hei', 'title': 'senior ssss',
// 							                  'children': [
// 							                    { 'name': 'Pang Pang', 'title': 'engineer' },
// 							                    { 'name': 'Xiang Xiang', 'title': 'UE engineer' }
// 							                  ]
// 							                }
// 							              ]
// 							            },
// 							        ]
// 								};
				
// 				for(var i = 0; i < data.length; i++){
					
// 					if(map[data[i].id]){
						
// 						var parentNode = map[data[i].id]["children"];
// // 						console.log(parentNode);
// 						for(var j = 0; j < data.length; j++){
// 							if(parentNode[j]){
// 								delete parentNode[j].children;
// 							}
// 						}
// 						console.log(map[data[i].id]);
						
// 					}
// 				}
				
// 				for(var i = 0; i < Object.keys(map).length; i++){
// 					if(Object.keys(map)[i]){
// 						for(var j = 0; j < data.length; j++){
// 							if(data[i].id == Object.keys(map)[i]){
// 								map.children.push();
								
// 							}
							
// 						}
						
// 					}
					
// 				}
				
// 				console.log(map);
					
					
				
// 			},
// 			error: function(e){
// 				console.log(e);
// 			}
// 	});
	
// }





</script>



</body>  
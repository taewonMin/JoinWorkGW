<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
    
<!-- 사이드바 -->
<div id="left-sidebar" class="sidebar" style="border-right:2px solid rgb(0,0,0,0.1)">
	<div class="sidebar-scroll" >
		<!-- 여기 사이드바 넣는곳 -->
		
         <div class="tab-content p-l-0 p-r-0 text-align" style="font-size: 25px; ">
         	<button onclick="approval_go();" style="background-color: #2980b9; color: white; border: 0px; width: 14rem; height: 3.8rem; margin-left: 3.5%; border-radius: 5%; margin-top: 4%; font-family: InfinitySans-RegularA1">새 결재 진행</button>
         </div>
         
         <div class="tab-content p-l-0 p-r-0" style="font-size: 25px;margin-top: 4%; margin-left: 3%; padding-bottom: 0; font-family: S-CoreDream-4Regular">
         	자주 쓰는  양식
         </div>
         <div class="tab-content p-l-0 p-r-0" style="font-family: InfinitySans-RegularA1; height: 260px;">
                <div class="tab-pane animated fadeIn active" id="project_menu">
                    <nav class="sidebar-nav" style="font-size: 20px;">
                        <ul class="main-menu metismenu" >
	                        <c:forEach items="${dataMap.forms }" var="form">	                        	
	                            <li onclick="OpenWindow('<%=request.getContextPath()%>/approval/docDetail?formId=${form.formId}','결재양식',900,900);" value="${form.formId}"><a href="javascript:void(0);"style="font-size: 18px;"><i class="fa fa-file-o" style="font-size: 20px;"></i>${form.formName}</a></li>
	                        </c:forEach>
                        	<c:if test="${empty dataMap.forms}">
                            	<li><a style="font-size: 18px;"><i class="" style="font-size: 20px;"></i>저장된 양식이 없습니다.</a></li>
                            </c:if>
                        </ul>                        
                    </nav>                    
               
                </div>             
         </div>
           
         <div class="tab-content p-l-0 p-r-0" style="font-size: 25px; margin-left: 3%; padding-bottom: 0; font-family: S-CoreDream-4Regular">
         	나의 결재 목록
         </div>
         <div class="tab-content p-l-0 p-r-0" style="font-family: InfinitySans-RegularA1;overflow: auto; height: 310px;">
              <div class="tab-pane animated fadeIn active" id="project_menu">
                  <nav class="sidebar-nav">
                      <ul class="main-menu metismenu" style="font-size: 20px;">
                          <li ><a href="<%=request.getContextPath()%>/approval/lists/list" style="font-size: 18px;"><i class="icon-docs" style="font-size: 20px;"></i>모든 결재 문서</a></li>
                          <li ><a href="<%=request.getContextPath()%>/approval/lists/waitList" style="font-size: 18px;"><i class="icon-docs" style="font-size: 20px;"></i>결재 대기 문서 <span class="badge badge-warning float-right">${dataMap.docs.size()}</span></a></li>
                          <li ><a href="<%=request.getContextPath()%>/approval/lists/completeList" style="font-size: 18px;"><i class="icon-docs" style="font-size: 20px;"></i>결재 종료 문서</a></li>
                          <li ><a href="<%=request.getContextPath()%>/approval/lists/draftList" style="font-size: 18px;"><i class="icon-docs" style="font-size: 20px;"></i>기안 문서함 </a></li>
                          <li ><a href="<%=request.getContextPath()%>/approval/lists/tempList" style="font-size: 18px;"><i class="icon-docs" style="font-size: 20px;"></i>임시 저장함</a></li>
                          <li ><a href="<%=request.getContextPath()%>/approval/lists/receptionList" style="font-size: 18px;"><i class="icon-docs" style="font-size: 20px;"></i>수신 문서함</a></li>
                          <li ><a href="<%=request.getContextPath()%>/approval/lists/referList" style="font-size: 18px;"><i class="icon-docs" style="font-size: 20px;"></i>참조 문서함</a></li>
                      </ul>                        
                  </nav>                    
              </div>             
         </div>  
	</div>
</div>

<script>
function approval_go() {
	OpenWindow('<%=request.getContextPath()%>/approval/registDocForm','결재진행',700,700);
}


</script>

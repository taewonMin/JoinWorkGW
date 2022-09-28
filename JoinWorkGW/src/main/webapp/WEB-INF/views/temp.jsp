<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<body >
<div id="indexListAjax">

 <table id="holidays_list" class="table table-hover">
   <thead class="thead-dark">
       <tr>
          <!--해당 달전부 출력-->
           <th>사원리스트</th>
           <c:forEach items="${dataMap.attendenceList }" var="attendence">
             <td>*해당 날의 끝까지 출력*</td>
           </c:forEach>
       </tr>
   </thead>
   <!-- 근태 바디 -->
   <tbody class="attendBody">
      <c:forEach items="${dataMap.deptAttendenceInfoList }" var="attendenceMember">
         <tr>
               <td>
                  <c:choose>
                     <c:when test="${attendenceMember.attendenceAttendenceStList eq '1' }">정상 아이콘</c:when>
                     <c:when test="${attendenceMember.attendenceAttendenceStList eq '1' }">정상 아이콘</c:when>
                     <c:when test="${attendenceMember.attendenceAttendenceStList eq '2' }">노랑 아이콘</c:when>
                     <c:when test="${attendenceMember.attendenceAttendenceStList eq '3' }">빨강 아이콘</c:when>
                  </c:choose>
               </td>
         </tr>
      </c:forEach>
   </tbody>
</table>
</div>
</body>
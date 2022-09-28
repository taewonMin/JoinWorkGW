<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<body >
<div id="indexListAjax">

 <table id="holidays_list" class="table table-hover">
	<thead class="thead-dark">
	    <tr>
	        <th>#</th>
	        <th>사원 번호</th>
	        <th>날짜</th>
	        <th>출근일</th>
	        <th>퇴근일</th>
	        <th>상태</th>
	    </tr>
	</thead>
<!--                                         근태 바디 -->
	<tbody class="attendBody">
		<c:choose>
			<c:when test="${!empty dataMap.attendenceList}">
				<c:forEach items="${dataMap.attendenceList }" var="attendence">
					<tr>
						<td>${attendence.historyId}</td>
						<td>${attendence.empId}</td>
						<td><fmt:formatDate value="${attendence.historyAttendTime }" pattern="yyyy-MM-dd"/></td>
						<td>
							<c:choose>
								<c:when test="${!empty attendence.historyAttendTime }"> <fmt:formatDate value="${attendence.historyAttendTime }" pattern="HH:mm:ss"/> </c:when>
								<c:when test="${empty attendence.historyAttendTime}"> - </c:when>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${!empty attendence.historyLeavingTime }"> <fmt:formatDate value="${attendence.historyLeavingTime }" pattern="HH:mm:ss"/> </c:when>
								<c:when test="${empty attendence.historyLeavingTime}"> - </c:when>
							</c:choose>
						</td>
						<td>
							${attendence.attendStName}	
						</td>
					</tr>
				</c:forEach>
			</c:when>
			<c:when test="${empty dataMap.attendenceList}">
				<tr>
					<td></td>
					<td></td>
					<td style="text-align: center;">해당 월의 근태정보가 없습니다.</td>
					<td></td>
				</tr>
			</c:when>
		</c:choose>
	</tbody>
</table>
</div>
</body>

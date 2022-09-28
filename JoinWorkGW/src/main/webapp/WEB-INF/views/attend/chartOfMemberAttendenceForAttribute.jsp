<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


 									
<body >
	<div class="table-responsive" id="indexListAjax">
		<table class="table table-hover attendance_list">
			<thead>
				<tr>
					<th>부서</th>
					<c:forEach var="i" begin="1" end="${totalDay}">
						<td><c:out value="${i}" /></td>
					</c:forEach>
				</tr>
			</thead>
			<tbody class="attendBody">
				<c:forEach items="${dataMap}" var="name" >
				<tr>
					<td>${name.key}</td>
					
					<c:forEach items="${name.value}" var="val">
						<td>
							<c:choose>
								<c:when test="${val eq '1'}"><i class="icon-check" style="color: green;"></i></c:when>
								<c:when test="${val eq '2'}"><i class="icon-check" style="color: red;"></i></c:when>
								<c:when test="${val eq '3'}"><i class="icon-close" style="color: black;"></i></c:when>
								<c:when test="${val eq '5'}"><i class="icon-close" style="color: yellow;"></i></c:when>
							</c:choose>
						</td>
					</c:forEach>
				</tr>
				</c:forEach>
						
			</tbody>
		</table>
	</div>
</body>

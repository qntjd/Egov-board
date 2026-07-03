<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang ="ko">
<head>
<meta charset="UTF-8">
<title>사용자 리스트</title>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet"/>
<link rel="stylesheet" href="<c:url value='/css/userList.css'/>">
</head>
<body>

<div class="top-nav">
    <a href="<c:url value='/boardList.do'/>">게시판</a>
    <span>|</span>
    <c:choose>
        <c:when test="${not empty sessionScope.loginUser}">
            <span>${sessionScope.userName}님</span>
            <span>|</span>
            <a href="<c:url value='/logout.do'/>">로그아웃</a>
        </c:when>
        <c:otherwise>
            <a href="<c:url value='/login.do'/>">로그인</a>
            <span>|</span>
            <a href="<c:url value='/Register.do'/>">회원가입</a>
        </c:otherwise>
    </c:choose>
</div>
<div class="container mt-4">
	<h2>사용자 리스트</h2>
	<table class="table table-bordered table-hover">
		<thead class="thead-dark">
			<tr>
				<th>번호</th>
				<th>ID</th>
				<th>이름</th>
				<th>이메일주소</th>
				<th>전화번호</th>
				<th>성별</th>
				<th>생년월일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="user" items="${userList}">
			<tr>
				<th>${user.userNo}</th>
				<th>${user.userId}</th>
				<th>${user.userName}</th>
				<th>${user.email} </th>
				<th>${user.phoneNumber}</th>
				<th>${user.gender}</th>
				<th>${user.birth}</th>
			</tr>
			</c:forEach>
			<c:forEach begin="${fn:length(userList) + 1}" end="10" var="i">
			<tr class="empty-row">
				<td>${i}</td>
				<td>...</td>
				<td>...</td>
				<td></td>
				<td></td>
				<td>...</td>
				<td>...</td>
			
			</tr>
			</c:forEach>
		
		</tbody>
	
	</table>

</div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>서버 오류</title>
</head>
<body>
<div style="text-align:center; margin-top:100px;">
    <h3>${errorMsg}</h3>
    <a href="<c:url value='/boardList.do'/>">메인으로</a>
</div>
</body>
</html>
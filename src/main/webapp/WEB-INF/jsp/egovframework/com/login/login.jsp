<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
body { background-color: #f0f0f0; font-family: 'Malgun Gothic', sans-serif; }
.login-wrap {
    background-color: #fff;
    border: 2px solid #333;
    padding: 40px;
    max-width: 400px;
    margin: 100px auto;
}
.login-title {
    font-size: 22px;
    font-weight: bold;
    text-align: center;
    margin-bottom: 30px;
}
.form-label { font-size: 13px; }
.form-control {
    border-radius: 2px;
    font-size: 13px;
}
.btn-login {
    width: 100%;
    border-radius: 2px;
    background-color: #555;
    border-color: #555;
    font-size: 14px;
    padding: 8px;
}
.btn-login:hover { background-color: #333; border-color: #333; }
.error-msg { color: #e74c3c; font-size: 13px; text-align: center; margin-bottom: 10px; }
.link-area { text-align: center; margin-top: 15px; font-size: 13px; }
.link-area a { color: #555; text-decoration: none; }
.link-area a:hover { text-decoration: underline; }
</style>
</head>
<body>

<div class="login-wrap">
    <div class="login-title">로그인</div>

    
    <c:if test="${param.error != null}">
	    <div class="error-msg">아이디 또는 비밀번호가 올바르지 않습니다.</div>
	</c:if>

    <form id="loginForm" action="<c:url value='/loginAction.do'/>" method="post">
        <div class="mb-3">
            <label class="form-label">아이디</label>
            <input type="text" id="userId" name="userId" class="form-control"
                placeholder="아이디를 입력하세요" maxlength="30">
        </div>
        <div class="mb-3">
            <label class="form-label">비밀번호</label>
            <input type="password" id="userPw" name="userPw" class="form-control"
                placeholder="비밀번호를 입력하세요" maxlength="30">
        </div>
        <button type="button" id="btn_login" class="btn btn-dark btn-login">로그인</button>
    </form>

    <div class="link-area">
        <a href="<c:url value='/Register.do'/>">회원가입</a>
        <span style="color:#ccc; margin: 0 8px;">|</span>
        <a href="<c:url value='/boardList.do'/>">게시판</a>
    </div>
</div>

<script>
$(document).ready(function() {

    
    $("#userId, #userPw").keypress(function(e) {
        if (e.which == 13) {
            $("#btn_login").click();
        }
    });

    $("#btn_login").click(function() {
        var userId = $("#userId").val();
        var userPw = $("#userPw").val();

        if (userId == "" || userId == null) {
            alert("아이디를 입력해주세요");
            $("#userId").focus();
            return;
        }
        if (userPw == "" || userPw == null) {
            alert("비밀번호를 입력해주세요");
            $("#userPw").focus();
            return;
        }

        $("#loginForm").submit();
    });

});
</script>
</body>
</html>

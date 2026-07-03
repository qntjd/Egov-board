<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입</title>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="<c:url value= '/css/joinMbrinput.css'/>">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
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
		    

        <div class="modal fade" id="defaultModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                        <h4 class="modal-title">알림</h4>
                    </div>
                    <div class="modal-body">
                        <p class="modal-contents"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <form id="frm" class="form-horizontal" role="form" method="post" action="<c:url value='/insertUser.do'/>" accept-charset="UTF-8">
        <div class="form-group" id="divId">
            <label for="inputId" class="col-lg-2 control-label">아이디</label>
            <div class="col-lg-10">
                <input type="text" class="form-control onlyAlphabetAndNumber" id="userId" name="u
"
                    data-rule-required="true" placeholder="30자 이내 알파벳, 언더스코어, 숫자만 입력 가능합니다." maxlength="30">
                <button type="button" id="idDupChkBtn" class="btn btn-primary">중복 확인</button>
            </div>
        </div>
        <div class="form-group" id="divPassword">
            <label for="inputPassword" class="col-lg-2 control-label">비밀번호</label>
            <div class="col-lg-10">
                <input type="password" class="form-control" id="userPw" name="userPw"
                    data-rule-required="true" placeholder="비밀번호" maxlength="30">
            </div>
        </div>
        <div class="form-group" id="divPasswordCheck">
            <label for="inputPasswordCheck" class="col-lg-2 control-label">비밀번호 확인</label>
            <div class="col-lg-10">
                <input type="password" class="form-control" id="passwordCheck"
                    data-rule-required="true" placeholder="비밀번호 확인" maxlength="30">
            </div>
        </div>
        <div class="form-group" id="divName">
            <label for="inputName" class="col-lg-2 control-label">이름</label>
            <div class="col-lg-10">
                <input type="text" class="form-control onlyHangul" id="userName" name="userName"
                    data-rule-required="true" placeholder="한글만 입력 가능합니다" maxlength="15">
            </div>
        </div>
        <div class="form-group" id="divEmail">
            <label for="inputEmail" class="col-lg-2 control-label">이메일</label>
            <div class="col-lg-10">
                <input type="text" class="form-control" id="email" name="email"
                    data-rule-required="true" placeholder="이메일" maxlength="40">
            </div>
        </div>
        <div class="form-group" id="divPhoneNumber">
            <label for="inputPhoneNumber" class="col-lg-2 control-label">전화번호</label>
            <div class="col-lg-10">
                <input type="tel" class="form-control onlyNumber" id="phoneNumber" name="phoneNumber"
                    data-rule-required="true" placeholder="-을 제외하고 숫자만 입력하세요" maxlength="11">
                <input type = "button" onclick="authnum()" class = "authbtn" value = "인증번호받기">
                	<div style="display:none;" class="successMessage">인증번호가 발송되었습니다</div>
                	<input type="text" name="authNum" id="authNum"><input type="button" onclick="checkMessage()" value="인증번호 확인" >
                	<div style="display:none;" class="authSuccessMessage">인증 성공</div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-lg-2 control-label">성별</label>
            <div class="col-lg-10">
                <label class="radio-inline">
                    <input type="radio" name="gender" value="M" checked> 남자
                </label>
                <label class="radio-inline">
                    <input type="radio" name="gender" value="F"> 여자
                </label>
            </div>
        </div>
        <div class="form-group" id="divBirth">
            <label for="inputBirth" class="col-lg-2 control-label">생년월일</label>
            <div class="col-lg-10">
                <input type="date" class="form-control" id="birth" name="birth">
            </div>
        </div>
        <div class="form-group">
            <div class="col-lg-offset-2 col-lg-10">
                <button type="button" class="btn btn-default" onclick="location.href='<c:url value='/userList.do'/>'">리스트</button>
                <button type="submit" class="btn btn-primary">등록하기</button>
            </div>
        </div>
    </form>

    <script>
    
	    function idValidChkFn(userId) {
	        var reg = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,12}$/;
	        if (!reg.test(userId)) {
	            alert("아이디는 영문+숫자 조합 8~12자로 입력해주세요.");
	            return false;
	        }
	        return true;
	    }
	    
		async function duplicateChkFn() {
			var userId = $("#userId").val();
			
			if(!idValidChkFn(userId)){
				return false;
			}
			
			try {
				var response = await $.ajax({
					type : "get",
					url : "<c:url value='/selectDupIdChk.do'/>",
					data : {"userId" : userId},
					dataType : "json"
				});
				
				if(response.isDuplicated){
					alert(userId + "은/는 사용하실 수 없습니다");
				} else {
					alert(userId + "은/는 사용하실 수 있습니다");
				}
			} catch (error){
				alert ("오류가 발생했습니다");
			}
		}
        
        
        function authnum() {
        	var phoneNumber = $("#phoneNumber").val();
        	
        	if(phoneNumber == ""){
        		alert("전화번호를 입력해주세요");
        		return;
        	}
        	
        	try {
        		var response = await $.ajax({
        			type : "POST",
        			url : "<c:url value='/sendMessage'/>",
        			data : {"phoneNumber": phoneNumber},
        			dataType : "json"
        		});
        		
        		if(response.success){
        			$(".authbtn").prop("disabled",true);
        			$(".successMessage").css("display","block");
        			alert("인증번호가 발송되었습니다");
        		} else{
        			alert(response.message);
        		}
        	} catch (error){
        		alert("발송 중 오류가 발생했습니다");
        	}
        }
        
        async function checkMessage(){
        	var authNum = $("#authNum").val();
        	
        	if(authNum == ""){
        		alert("인증번호를 입력해주세요");
        		return;
        	}
        	
        	try {
        		var response = await $.ajax({
        			type:"POST",
        			url:"<c:url value='/checkAuthNumber'/>",
        			data:{"authNum":authNum},
        			dataType:"json"
        		
        		});
        		
        		if(response.success){
        			$(".authSuccessMessage").css("display","block");
        			$("#authNum").prop("disabled",true);
        			alert("인증되었습니다");
        		}else {
        			alert(response.message);
        		}
        	} catch (error){
        		alert("확인 중 오류가 발생했습니다");
        	}
        }

        $(function() {

            var modalContents = $(".modal-contents");
            var modal = $("#defaultModal");

           
            $("#idDupChkBtn").click(function() {
                duplicateChkFn();
            });

            $(".onlyAlphabetAndNumber").keyup(function(event) {
                if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
                    $(this).val($(this).val().replace(/[^_a-z0-9]/gi, ''));
                }
            });

            $(".onlyHangul").keyup(function(event) {
                if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
                    $(this).val($(this).val().replace(/[a-z0-9]/gi, ''));
                }
            });

            $(".onlyNumber").keyup(function(event) {
                if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
                    $(this).val($(this).val().replace(/[^0-9]/gi, ''));
                }
            });

            $('#userId').keyup(function() {
                var divId = $('#divId');
                if ($('#userId').val() == "") {
                    divId.removeClass("has-success").addClass("has-error");
                } else {
                    divId.removeClass("has-error").addClass("has-success");
                }
            });

            $('#userPw').keyup(function() {
                var divPassword = $('#divPassword');
                if ($('#userPw').val() == "") {
                    divPassword.removeClass("has-success").addClass("has-error");
                } else {
                    divPassword.removeClass("has-error").addClass("has-success");
                }
            });

            $('#passwordCheck').keyup(function() {
                var passwordCheck = $('#passwordCheck').val();
                var password = $('#userPw').val();
                var divPasswordCheck = $('#divPasswordCheck');
                if (passwordCheck == "" || password != passwordCheck) {
                    divPasswordCheck.removeClass("has-success").addClass("has-error");
                } else {
                    divPasswordCheck.removeClass("has-error").addClass("has-success");
                }
            });

            $('#userName').keyup(function() {
                var divName = $('#divName');
                if ($.trim($('#userName').val()) == "") {  
                    divName.removeClass("has-success").addClass("has-error");
                } else {
                    divName.removeClass("has-error").addClass("has-success");
                }
            });

            $('#email').keyup(function() {
                var divEmail = $('#divEmail');
                if ($.trim($('#email').val()) == "") {
                    divEmail.removeClass("has-success").addClass("has-error");
                } else {
                    divEmail.removeClass("has-error").addClass("has-success");
                }
            });

            $('#phoneNumber').keyup(function() {
                var divPhoneNumber = $('#divPhoneNumber');
                if ($.trim($('#phoneNumber').val()) == "") {
                    divPhoneNumber.removeClass("has-success").addClass("has-error");
                } else {
                    divPhoneNumber.removeClass("has-error").addClass("has-success");
                }
            });

            
            $("form").submit(function(event) {
                var divId = $('#divId');
                var divPassword = $('#divPassword');
                var divPasswordCheck = $('#divPasswordCheck');  
                var divName = $('#divName');
                var divEmail = $('#divEmail');  
                var divPhoneNumber = $('#divPhoneNumber');  

                if ($('#userId').val() == "") {
                    modalContents.text("아이디를 입력하여 주시기 바랍니다.");
                    modal.modal('show');
                    divId.removeClass("has-success").addClass("has-error");
                    $('#userId').focus();
                    return false;
                } else {
                    divId.removeClass("has-error").addClass("has-success");
                }

                if ($('#userPw').val() == "") {
                    modalContents.text("비밀번호를 입력하여 주시기 바랍니다.");
                    modal.modal('show');
                    divPassword.removeClass("has-success").addClass("has-error");
                    $('#userPw').focus();
                    return false;
                } else {
                    divPassword.removeClass("has-error").addClass("has-success");
                }

                if ($('#passwordCheck').val() == "") {
                    modalContents.text("비밀번호 확인을 입력해 주시기 바랍니다.");
                    modal.modal('show');
                    divPasswordCheck.removeClass("has-success").addClass("has-error");
                    $('#passwordCheck').focus();
                    return false;
                } else {
                    divPasswordCheck.removeClass("has-error").addClass("has-success");
                }

                if ($('#userPw').val() != $('#passwordCheck').val()) {
                    modalContents.text("비밀번호가 일치하지 않습니다.");
                    modal.modal('show');
                    divPasswordCheck.removeClass("has-success").addClass("has-error");
                    $('#passwordCheck').focus();
                    return false;
                } else {
                    divPasswordCheck.removeClass("has-error").addClass("has-success");
                }

                if ($('#userName').val() == "") {
                    modalContents.text("이름을 입력하여 주시기 바랍니다.");
                    modal.modal('show');
                    divName.removeClass("has-success").addClass("has-error");
                    $('#userName').focus();
                    return false;
                } else {
                    divName.removeClass("has-error").addClass("has-success");
                }

                if ($('#email').val() == "") {
                    modalContents.text("이메일을 입력하여 주시기 바랍니다.");
                    modal.modal('show');
                    divEmail.removeClass("has-success").addClass("has-error");
                    $('#email').focus();
                    return false;
                } else {
                    divEmail.removeClass("has-error").addClass("has-success");
                }

                if ($('#phoneNumber').val() == "") {
                    modalContents.text("휴대폰 번호를 입력하여 주시기 바랍니다.");
                    modal.modal('show');
                    divPhoneNumber.removeClass("has-success").addClass("has-error");
                    $('#phoneNumber').focus();
                    return false;
                } else {
                    divPhoneNumber.removeClass("has-error").addClass("has-success");
                }
            });
        });

    </script>
</body>
</html>

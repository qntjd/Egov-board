<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시글 상세</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW"
    crossorigin="anonymous"></script>
<style>
a { text-decoration: auto; }
.board-title { font-size: 20px; font-weight: bold; }
.board-info { color: #666; font-size: 13px; }
.board-content { min-height: 200px; padding: 20px 0; border-top: 1px solid #dee2e6; border-bottom: 1px solid #dee2e6; }
.file-list { margin-top: 10px; }
.file-list a { display: block; font-size: 13px; color: #0066cc; }
</style>
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
	<table class="table table-boardred">
		<tr>
			 <th style="width:100px; background:#f8f9fa">제목</th>
                <td colspan="3">
                    <span class="board-title">${board.title}</span>
                </td>
		</tr>
		<tr>
			<th style="background:#f8f9fa">작성자</th>
			<td>${board.writerName}</td>
			<th style="background:#f8f9fa">작성일자</th>
			<td>${board.regDate}</td>
		</tr>
		<tr>
			<th style="background:#f8f9fa">조회수</th>
			<td colspan="3">${board.viewCnt}</td>
		</tr>
		<tr>
			<th style="background:#f8f9fa">내용</th>
			<td colspan="3">
				<div class="board-content">${board.content}</div>
			</td>
		</tr>
		
		<c:if test="${not empty fileList}">
		<tr>
			<th style="background:#f8f9fa">첨부파일</th>
			<td colspan="3">
				<div class="file-list">
					<c:forEach var="file" items="${fileList}">
						<div>
							<a href="<c:url value='/cmm/fms/FileDown.do?atchFileId=${file.atchFileId}&fileSn=${file.fileSn}'/>">
							${file.orignlFileNm}(${file.fileMg} byte)
	                        </a>
							
						</div>
					</c:forEach>
				</div>
			</td>
		</tr>
		</c:if>
	</table>
	<div class="d-flex justify-content-between mt-3">
        <button type="button" class="btn btn-secondary"
            onclick="location.href='<c:url value='/boardList.do?searchType=${searchVO.searchType}&searchKeyword=${searchVO.searchKeyword}&pageNo=${searchVO.pageNo}&pageSize=${searchVO.pageSize}'/>'">
            목록으로
        </button>
        <div>
            <button type="button" class="btn btn-warning me-1"onclick="location.href='<c:url value='/updateBoard.do?boardNo=${board.boardNo}'/>'">수정</button>
            <button type="button" class="btn btn-danger" id="btn_delete">삭제</button>
        </div>
    </div>

   
    <form id="deleteForm" action="<c:url value='/boardDelete.do'/>" method="post">
        <input type="hidden" name="boardNo" value="${board.boardNo}"/>
    </form>
    <div class="comment-area">
    	<div class="comment-title">
    		댓글 <span style="color:#e74c3c">${commentList.size()}</span>개
    	</div>
    	<div class="comment-list">
    		<c:choose>
    			<c:when test="${empty commentList}">
    				<div>등록된 댓글이 없습니다.</div>
    			</c:when>
    		
	    		<c:otherwise>
	    			<c:forEach var="comment" items="${commentList}">
	    			<div class="comment-item">
	    				<span class="comment-writer">${comment.writerName}</span>
	    				<span class="comment-date">${comment.comtDate}</span>
	    				
	    				<span class="comment-delete" onclick="fn_commentDelete(${comment.comtNo},${board.boardNo}, '${comment.secretYn}')">삭제</span>
	    				<div class="comment-content">
	    					<c:choose>
	    						<c:when test="${comment.secretYn == 'Y'}">
	    							<span class="comment-secret">비밀 댓글입니다</span>
	    							<span id="viewBtn_${comment.comtNo}", style="color:#0066cc; cursor:pointer; font-size:12px; margin-left:5px;" onclick="fn_showPwInput(${comment.comtNo})">
	    							[보기]
	    							</span>
	    							<div id="pwInput_${comment.comtNo}" style="display:none; margin-top:5px">
	    								<div class="input-group" style="max-width:300px;">
	    									<input type="password" id="pw_${comment.comtNo}" class="form-control form-control-sm" placeholder="비밀번호 입력">
	    									<button type="button" class="btn btn-sm btn-secondary" onclick="fn_viewSecret(${comment.comtNo})">확인</button>
	    								</div>
	    							</div>
	    							<div id="deletePwInput_${comment.comtNo}" style="display:none; margin-top:5px;">
	    								<div class="input-group" style="max-width:300px;">
	    									<input type="password" id="deletePw_${comment.comtNo}" class="form-control form-control-sm" placeholder="삭제 비밀번호">
	    									<button type="button" class="btn btn-sm btn-danger" onclick="fn_deleteSecret(${comment.comtNo}, ${board.boardNo})">삭제 확인</button>
	    								</div>
	    							
	    							</div>
	    							<div id="comtContent_${comment.comtNo}" style="display:none; margin-top:5px;">
	    							</div>
	    						</c:when>
	    						<c:otherwise>
	    							${comment.comtContent}
	    						</c:otherwise>
	    					</c:choose>
	    				</div>
	    			</div>
	    			</c:forEach>
	    		</c:otherwise>
    		</c:choose>
    	</div>
    	
    	<div class="comment-form">
    		<form id="commentForm" action="<c:url value='/comtInsert.do'/>" method="post">
    			<input type="hidden" name="boardNo" value="${board.boardNo}">
    			<div class="row g-2 mb-2">
    				<div class="col-md-3">
    					<input type="text" name="writerName" class="form-control" placeholder="작성자" maxlength="50">
    				</div>
    				<div class="col-md-3">
    					<input type="password" name="comtPw" class="form-control" placeholder="비밀번호">
    				</div>
    			</div>
    			<div class="row g-2 mb-2">
    				<div class="col-md-10">
    					<textarea name="comtContent" class="form-control" placeholder="댓글을 입력하시오"  id="comtContent"></textarea>
    				</div>
    				<div class="col-md-2 d-flex align-items-end">
    					<button type="button" id="btn_comment" class="btn btn-dark btn-comment w-100">등록</button>
    				</div>
    			</div>
    		</form>
    	</div>
    
    </div>

</div>
<form id="commentDeleteForm" action="<c:url value='/comtDelete.do'/>" method="post">
	<input type="hidden" name="comtNo" id="deleteComtNo"/>
	<input type="hidden" name="boardNo" value="${board.boardNo}"/>
	<input type="hidden" name="comtPw" id="deleteComtPw"/>
</form>
<script>
function fn_fileDown(atchFileId, fileSn) {
    window.open("<c:url value='/cmm/fms/FileDown.do'/>?atchFileId=" + atchFileId + "&fileSn=" + fileSn);
}

var currentComtNo = 0;
var currentSecretYn = 'N';

function fn_commentDelete(comtNo, boardNo, secretYn) {
	
	
	if(secretYn == 'Y') {
		$("#deletePwInput_" + comtNo).toggle();
	}else {
		if(confirm("댓글을 삭제하시겠습니까?")){
			$("#deleteComtNo").val(comtNo);
			$("#deleteComtPw").val("");
			$("#commentDeleteForm").submit();
		}
	}
}

function fn_deleteSecret(comtNo, boardNo){
	var pw =$("#deletePw_" + comtNo).val();
	if(pw == ""){
		alert("비밀번호를 입력해 주세요");
		return;
	}
	$("#deleteComtNo").val(comtNo);
	$("#deleteComtPw").val(pw);
	$("#commentDeleteForm").submit();
}

function fn_showPwInput(comtNo) {
    $("#pwInput_" + comtNo).toggle();
}

function fn_viewSecret(comtNo) {
    var pw = $("#pw_" + comtNo).val();
    if (pw == "") {
        alert("비밀번호를 입력해주세요");
        return;
    }

    $.ajax({
        type: "POST",
        url: "<c:url value='/comtView.do'/>",
        data: { comtNo: comtNo, comtPw: pw },
        success: function(data) {
            if (data == "FAIL") {
                alert("비밀번호가 일치하지 않습니다.");
            } else {
                $("#pwInput_" + comtNo).hide();
                $("#viewBtn_" + comtNo).hide();
                $("#comtContent_" + comtNo).text(data).show();
            }
        },
        error: function() {
            alert("오류가 발생했습니다.");
        }
    });
}

$(document).ready(function(){
	$("#btn_delete").click(function() {
	    if (confirm("삭제하시겠습니까?")) {
	        $("#deleteForm").submit();
	    }
	});
	
	$("#btn_comment").click(function() {
		var writerName = $("input[name='writerName']").val();
		var comtContent = $("#comtContent").val();
		
		if(writerName == ""){
			alert("작성자를 입력해주세요");
			$("input[name='writerName']").focus();
			return;
		}
		if(comtContent == ""){
			alert("댓글을 입력해주세요");
			$("#comtContent").focus();
			return;
		}
		
		$("#commentForm").submit();
	});
	
	$("#btn_confirmDelete").click(function(){
		var pw = $("#inputComtPw").val();
		if(pw == "") {
			alert("비밀번호를 입력해주세요");
			return;
		}
		$("#deleteComtNo").val(currentComtNo);
		$("#deleteComtPw").val(pw);
		$("#deleteCommentModal").modal('hide');
		$("#commentDeleteForm").submit();
	
	});
	
	
});



</script>


</body>
</html>
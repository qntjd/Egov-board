<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>"></script>
<style>
a { text-decoration: auto; }
</style>
</head>
<body>

<h2>게시글 수정</h2>
<div class="container">

    <form id="update_form" action="<c:url value='/boardUpdateAction.do'/>" method="post" enctype="multipart/form-data">
        <input type="hidden" name="boardNo" value="${board.boardNo}"/>
        <input type="hidden" name="maxFileCount" id="maxFileCount" value="5"/>
        <input type="hidden" name="fileSavePath" value="Globals.fileStorePath"/>

        <table class="table table-bordered">
            <tbody>
                <tr>
                    <th style="width:100px; background:#f8f9fa">제목</th>
                    <td>
                        <input type="text" name="title" id="title" class="form-control"
                            value="${board.title}">
                    </td>
                </tr>
                <tr>
                    <th style="background:#f8f9fa">작성자</th>
                    <td>
                        <input type="text" name="writerName" id="writerName" class="form-control"
                            value="${board.writerName}">
                    </td>
                </tr>
                <tr>
                    <th style="background:#f8f9fa">내용</th>
                    <td>
                        <textarea name="content" id="content" class="form-control"
                            style="height:200px">${board.content}</textarea>
                    </td>
                </tr>
                
                <c:if test="${not empty fileList}">
                <tr>
                    <th style="background:#f8f9fa">기존 첨부파일</th>
                    <td>
                        <c:forEach var="file" items="${fileList}">
                        <div>
                          	  📎 ${file.orignlFileNm}
                            <a href="<c:url value='/fileDelete.do?atchFileId=${file.atchFileId}&fileSn=${file.fileSn}&boardNo=${board.boardNo}'/>"
                                onclick="return confirm('삭제하시겠습니까?')"
                                class="text-danger ms-2">x</a>
                        </div>
                        </c:forEach>
                    </td>
                </tr>
                </c:if>
                
                <tr>
                    <th style="background:#f8f9fa">파일 추가</th>
                    <td>
                        <input name="file_1" id="boardFileUploader" type="file"/>
                        <div id="boardFileList"></div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: right;">
                        <button id="btn_update" type="button" class="btn btn-success me-1">저장</button>
                        <button type="button" class="btn btn-secondary"
                            onclick="location.href='<c:url value='/boardDetail.do?boardNo=${board.boardNo}'/>'">
                            	취소
                        </button>
                    </td>
                </tr>
            </tbody>
        </table>

    </form>
</div>

<script type="text/javascript">

$(document).ready(function() {
	var maxCount = document.getElementById('maxFileCount').value;
	if(maxCount == null || maxCount == ""){
		maxCount = 3;
	}
	var boardFileSelector = new MultiSelector(document.getElementById('boardFileList'), maxCount);
	boardFileSelector.addElement(document.getElementById('boardFileUploader'));

    $("#btn_update").click(function() {
        var title = $("#title").val();
        var content = $("#content").val();

        if (title == "" || title == null) {
            alert("제목을 입력해주세요");
            $("#title").focus();
            return;
        }

        if (content == "" || content == null) {
            alert("내용을 입력해주세요");
            $("#content").focus();
            return;
        }

        $("#update_form").submit();
    });
});
</script>

</body>
</html>
